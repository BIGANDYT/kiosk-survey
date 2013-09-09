

function scSitecore() {
  this.cache = new Object();
  this.requests = new Array();
  this.contextmenu = "";
  this.dragMouseDown = null;
  this.frameName = null;
  this.modified = false;
  this.source = null;
  this.keymap = new Object();
  this.dictionary = new Object();
  this.suspended = new Object();
  this.uniqueID = 0;
  this.state = new Object();
  this.browser = new scBrowser();

  this.browser.attachEvent(window, "onload", function(evt) { if (scForm != null) { scForm.onLoad() } });
  this.browser.attachEvent(window, "onunload", function(evt) { if (scForm != null) scForm.onUnload(evt ? evt : window.event) });
  this.browser.attachEvent(window, "onblur", function(evt) { if (scForm != null) scForm.onBlur(evt ? evt : window.event) });
}

scSitecore.prototype.onBlur = function() {
  this.browser.closePopups("mainWindowBlur");
}

scSitecore.prototype.onKeyDown = function (evt) {
  evt = (evt != null ? evt : window.event);

  if (evt != null) {
    if (evt.keyCode == 123 && evt.altKey && evt.shiftKey && evt.ctrlKey) {
      return window.open().document.open('text/plain').write(document.documentElement.outerHTML);
    }

    var srcElement = scForm.browser.getSrcElement(evt);

    if (srcElement.tagName == "INPUT" || srcElement.tagName == "SELECT" || srcElement.tagName == "TEXTAREA" || srcElement.isContentEditable) {
      if (!(srcElement.readOnly == true || srcElement.disabled == true || srcElement.className.indexOf("scIgnoreModified") >= 0)) {
        if (!scForm.isFunctionKey(evt, true)) {
          this.setModified(true);
        }
      }

      if (evt.keyCode == 8 && (srcElement.className && srcElement.className.toLowerCase().indexOf("checkbox") >= 0) ||
          (srcElement.type && srcElement.type.toLowerCase() == "checkbox")) {
        scForm.browser.clearEvent(evt, false, false, 8);
      }
    }
    else {
      if (evt.keyCode == 8 && !isSilverlightApplicationLoaded(srcElement)) {
        scForm.browser.clearEvent(evt, false, false, 8);
      }
    }

    var result = this.handleKey(evt.srcElement, evt, null, null, true);

    if (evt.keyCode == 112 && evt.altKey) {
      for (var e = this.browser.getEnumerator(document.getElementsByTagName("span")); !e.atEnd(); e.moveNext()) {
        var ctl = e.item();

        if (ctl.className.indexOf("scRibbonToolbarKeyCode") >= 0) {
          ctl.style.display = ctl.style.display == "" ? "none" : "";
        }
      }
    }

    return result;
  }
}

scSitecore.prototype.onLoad = function() {
  this.browser.attachEvent(document, "onkeydown", function(evt) { if (scForm != null) { return scForm.onKeyDown(evt) } });
  this.browser.attachEvent(document, "onkeypress", function (evt) {
    evt = evt || window.event;
    if (evt.keyCode == 0 && evt.ctrlKey && scForm.browser.shouldKeyPressBeCleared(evt)) {
      scForm.browser.clearEvent(evt, true, false);
    } 
   });

  this.browser.initialize();

  if (scForm.Settings && scForm.Settings.SessionTimeout) {
    //Keep alive action should be performed earlier then session expires. That's why - 30 * 1000
    keepAliveTimeout = scForm.Settings.SessionTimeout - 30 * 1000;
  }
  else {
    if (window.console) {
      console.warn("SessionTimeout not found in settings scForm.Settings");
    }
    keepAliveTimeout = 1200 * 1000;
  }

  window.setInterval(scKeepAlive, keepAliveTimeout);
}

scSitecore.prototype.onUnload = function() {
  this.browser.closePopups("mainWindowUnload");

  if (typeof (scGeckoModalDialogRequest) != "undefined") {
    scGeckoModalDialogRequest.dialogResult = window.returnValue;
    scGeckoModalDialogRequest.resume();
  }
}

scSitecore.prototype.activate = function(tag, evt) {
  if (!tag.disabled) {
    this.setClass(tag, evt.type == "activate", "_Active");
  }

  return false;
}

scSitecore.prototype.broadcast = function(win, request, command) {
  if (typeof (win.scForm) != "undefined") {
    if (win.scForm.frameName == null) {
      win.scForm.frameName = "";

      var ctl = win.scForm.browser.getControl("__FRAMENAME");

      if (ctl != null) {
        win.scForm.frameName = ctl.value;
      }
    }

    if (command.framename == "*" || command.framename == win.scForm.frameName) {
      win.scForm.process(request, command, command.framecommand);
      return true;
    }
  }

  for (var n = 0; n < win.frames.length; n++) {
    try {
      if (this.broadcast(win.frames[n], request, command)) {
        return true;
      }
    } catch (ex) {
      console.log("Failed to accees frame. This typically happens due to a Permission Denied exception in IE9 caused by an intricate issue with Popup and ShowModalDialog calls. " + ex.message);
    }
  }

  return false;
}

scSitecore.prototype.drag = function(tag, evt, parameters) {
  switch (evt.type) {
    case "mousedown":
      if (evt.button == 1) {
        this.dragMouseDown = tag;
        this.dragMouseDownX = evt.x;
        this.dragMouseDownY = evt.y;
      }
      break;

    case "mousemove":
      if (this.dragMouseDown != null && this.dragMouseDown == tag && evt.button == 1) {
        if (Math.abs(this.dragMouseDownX - evt.x) > 4 || Math.abs(this.dragMouseDownY - evt.y) > 4) {
          evt.srcElement.dragDrop();
          this.dragMouseDown = null;
        }
      }
      else {
        this.dragMouseDown = null;
      }
      break;

    case "dragstart":
      evt.dataTransfer.setData("text", "sitecore:" + parameters);
      evt.dataTransfer.effectAllowed = "all";
      break;
  }
}

scSitecore.prototype.drop = function(tag, evt, parameters) {
  var data = evt.dataTransfer.getData("text");

  if (data != null) {
    if (data.substring(0, 9) == "sitecore:") {
      switch (evt.type) {
        case "dragover":
          evt.dataTransfer.dropEffect = (parameters != null && parameters != "" ? parameters : (evt.ctrlKey ? "copy" : "move"));
          this.browser.clearEvent(evt, true, false);
          return true;

        case "drop":
          this.browser.clearEvent(evt, true, false);

          this.postEvent(tag, evt, parameters.replace(/\$Data/gi, data));
          break;
      }
    }
    else {
      evt.dataTransfer.dropEffect = "none";
      this.browser.clearEvent(evt, null, false);
    }
  }

  return false;
}

scSitecore.prototype.expandHtml = function(html) {
  var n = html.indexOf("[[X:");
  if (n < 0) {
    return html;
  }

  var textareas = "";

  for (var e = this.browser.getEnumerator(document.getElementsByTagName("TEXTAREA")); !e.atEnd(); e.moveNext()) {
    var ctl = e.item();
    textareas += ctl.value;
  }

  while (n >= 0) {
    var e = html.indexOf("]]", n);
    if (e < 0) {
      e = n + 2;
    }

    var text = "";

    var id = html.substring(n + 4, e);

    var ctl = this.browser.getControl(id);
    if (ctl != null) {
      text = this.browser.getOuterHtml(ctl);
      var i = text.toUpperCase().lastIndexOf("</DIV>");
      text = text.substring(0, i) + "</div id=\"" + id + "\">";
    }
    else {
      var h = textareas.indexOf(id);

      if (h >= 0) {
        var i1 = textareas.lastIndexOf("<div", h);
        var i2 = textareas.lastIndexOf("<DIV", h);

        i = (i1 > i2 ? i1 : i2);

        var j = textareas.indexOf("</div id=\"" + id + "\">", i);
        if (j >= 0) {
          text = textareas.substring(i, j) + "</div id=\"" + id + "\">";
        }
      }
    }

    html = html.substr(0, n) + text + html.substr(e + 2);

    n = html.indexOf("[[X:");
  }

  return html;
}

scSitecore.prototype.focus = function(ctl) {
  try {
    ctl.focus();
  }
  catch (e) {
  }
}

scSitecore.prototype.getParentForm = function() {
  var frame = this.browser.getFrameElement(window);

  if (frame != null) {
    var win = this.browser.getParentWindow(frame.ownerDocument);

    if (typeof (win.scForm) != "undefined") {
      return win.scForm;
    }
  }

  return null;
}

scSitecore.prototype.invoke = function(method) {
  var e = window.event;
  if (method != "LoadItem" && scForm && scForm.disableRequests) {
      alert(this.translate("Please wait while the Content Editor is loading."));
    return;
  }

  if (arguments.length > 1) {    
    var argumentsList = [];
    for (var n = 1; n < arguments.length; n++) {
      var arg = arguments[n];
      var isEventArg = arg && (typeof(arg.stopPropagation) != "undefined" || typeof(arg.cancelBubble) != "undefined");      
      if (isEventArg) {
        e = arg;
        continue;
      } 

      argumentsList.push("\"" + arg + "\"");
    }

    if (argumentsList.length) {
      // should the arguments be separated with a delimiter, e.g. comma?
      // Not in the original code.
      method += "(" + argumentsList.join(",") + ")";  
    }   
  }

  if (method.substring(0, 11) == "javascript:") {
    if (e != null) {
      scForm.browser.clearEvent(e, true, false);
    }

    var result = eval(method.substr(11).replace(/#quote#|&quot;/gi, "'"));

    return result;
  }

  if (e != null) {
    scForm.browser.clearEvent(e, true, false);
  }

  return this.postRequest("", "", "", method);
}

scSitecore.prototype.invokeCallback = function(method, callback, async) {
  if (arguments.length > 0) {
    method += "(";

    for (var n = 2; n < arguments.length; n++) {
      method += "\"" + arguments[n] + "\"";
    }

    method += ")";
  }

  return this.postRequest("", "", "", method, callback, async);
}

scSitecore.prototype.invokeAsync = function(object) {
  var request = new scRequest();

  request.async = true;
  request.url = "/sitecore/shell/invoke.aspx"

  form = "__ISEVENT=1&__OBJECT=" + encodeURIComponent(object);

  if (arguments.length > 0) {
    for (var n = 1; n < arguments.length - 1; n += 2) {
      form += "&" + arguments[n] + "=" + encodeURIComponent(arguments[n + 1]);
    }
  }

  request.form = form;

  request.execute();
}

scSitecore.prototype.invokeUrl = function(url, async, callback) {
  var request = new scRequest();

  request.async = async == true;
  request.url = url;

  if (callback != null) {
    request.callback = new Function("result", callback + "(result)");
  }

  form = "__PAGESTATE=" + encodeURIComponent(scForm.browser.getControl("__PAGESTATE").value);

  if (arguments.length > 2) {
    for (var n = 3; n < arguments.length - 1; n += 2) {
      form += "&" + arguments[n] + "=" + encodeURIComponent(arguments[n + 1]);
    }
  }

  request.form = form;

  request.execute();
}

scSitecore.prototype.isSiblingsHidden = function(tag) {
  for (var e = this.browser.getEnumerator(tag.parentNode.childNodes); !e.atEnd(); e.moveNext()) {
    var ctl = e.item();

    if (ctl != tag && ctl.style.display != "none") {
      return false;
    }
  }

  return true;
}

scSitecore.prototype.getCookie = function(name) {
  name = name + "=";

  var i = 0;

  while (i < document.cookie.length) {
    var j = i + name.length;

    if (document.cookie.substring(i, j) == name) {
      var n = document.cookie.indexOf(";", j);

      if (n == -1) {
        n = document.cookie.length;
      }

      return unescape(document.cookie.substring(j, n));
    }

    i = document.cookie.indexOf(" ", i) + 1;

    if (i == 0) {
      break;
    }
  }

  return null;
}

scSitecore.prototype.getCookieName = function() {
  var href = window.location.href;

  var n = href.indexOf("xmlcontrol=");
  if (n >= 0) {
    href = href.substr(n + 11);
  }

  n = href.indexOf("&");
  if (n >= 0) {
    href = href.substr(0, n);
  }

  return href;
}

scSitecore.prototype.getEventControl = function(evt, tag) {
  var ctl = this.browser.getSrcElement(evt);

  while (ctl != null && ctl != tag && (ctl.id == null || ctl.id == "")) {
    ctl = ctl.parentNode;
  }

  return ctl;
}

scSitecore.prototype.getParameters = function(form) {
  // for overriding
  return form;
}

scSitecore.prototype.help = function(tag, evt, link) {
  window.showHelp(link);
}

scSitecore.prototype.insertIntoTable = function(ctl, command) {
  var container = ctl.ownerDocument.createElement("div");

  container.innerHTML = "<table>" + command.value + "</table>";

  var table = container.childNodes[0];
  var parent = ctl.parentNode;

  ctl = ctl.nextSibling;

  var rows = this.browser.getTableRows(table);

  if (ctl == null) {
    for (var n = 0; n < rows.length; n++) {
      parent.appendChild(rows[n]);
    }
  }
  else {
    for (var n = 0; n < rows.length; n++) {
      parent.insertBefore(rows[n], ctl);
    }
  }
}

scSitecore.prototype.insertIntoDiv = function(control, command) {
  var container = control.ownerDocument.createElement("div");
  container.innerHTML = "<div>" + command.value + "</div>";
  var grid = container.childNodes[0];
  var rows = this.getGridRows(grid);
  var parent = control.parentNode;
  control = control.nextSibling;

  for (var i = 0; i < rows.length; i++) {
    if (control == null) {
      parent.appendChild(rows[i]);
    }
    else {
      parent.insertBefore(rows[i], control);
    }
  }
}

scSitecore.prototype.getGridRows = function(grid) {
  var result = new Array();

  for (var i = 0; i < grid.childNodes.length; i++) {
    var control = grid.childNodes[i];

    if (control.tagName == "UL") {
      result.push(control);
    }
  }

  return result;
}

scSitecore.prototype.handleKey = function(tag, evt, parameters, keyFilter, global) {
  if (evt.keyCode == null) {
    return;
  }

  // special delete key handling
  if (evt.keyCode == 46 && tag != null && (tag.tagName == "INPUT" || tag.tagName == "SELECT" || tag.tagName == "TEXTAREA" || tag.isContentEditable)) {
    return;
  }
  // special enter key handling
  if (evt.keyCode == 13 && tag != null && (tag.tagName == "TEXTAREA" || tag.isContentEditable)) {
    return;
  }

  global = (global != null);

  var ok = true;
  var key = "";

  if (evt.shiftKey) {
    key += "s";
  }
  if (evt.ctrlKey) {
    key += "c";
  }
  if (evt.altKey) {
    key += "a";
  }

  key += evt.keyCode.toString();

  if (global) {
    var k = this.keymap[key];

    if (k != null) {
      parameters = k.click;
    }

    ok = (parameters != null);
  }
  else {
    if (keyFilter != null && keyFilter != "") {
      keyFilter = "," + keyFilter + ",";

      if (keyFilter.indexOf("," + key + ",") < 0) {
        ok = false;
      }
    }
  }

  if (key == "c0") {    
    this.browser.clearEvent(evt, true, false, 0);
  }

  if (ok) {
    this.browser.clearEvent(evt, true, false, evt.keyCode);

    this.postEvent(tag, evt, parameters);

    return false;
  }
  else if (global) {
    var win = window.parent;

    if (win != null && win != window) {
      if (typeof (win.scForm) != "undefined") {
        return win.scForm.handleKey(tag, evt, parameters, keyFilter, global);
      }
    }
  }
}

scSitecore.prototype.registerKey = function(key, click, group) {
  var k = new Object();
  k.click = click;
  k.group = group;

  this.keymap[key] = k;
}

scSitecore.prototype.isFunctionKey = function(evt, editorKeys) {
  if (editorKeys == true) {
    // Ctrl+B, Ctrl+I, Ctrl+U
    if (evt.ctrlKey && (evt.keyCode == 66 || evt.keyCode == 73 || evt.keyCode == 85)) {
      return false;
    }
  }

  // ignore all Ctrl-key combinations (except Ctrl-X and Ctrl-V)
  if (evt.ctrlKey && evt.keyCode != 88 && evt.keyCode != 86) {
    return true;
  }

  switch (evt.keyCode) {
    // check misc. control keys 
    case 9:       // Tab
    case 16:      // Shift
    case 17:      // Ctrl
    case 18:      // Alt
    case 20:      // Caps
    case 27:      // Esc
    case 35:      // Home
    case 36:      // End
    case 37:      // Arrows (37-40)
    case 38:
    case 39:
    case 40:
    case 112:     // F1-F12 (112-123)
    case 113:
    case 114:
    case 115:
    case 116:
    case 117:
    case 118:
    case 119:
    case 120:
    case 121:
    case 122:
    case 123:
      return true;

      // check for Shift-Insert (paste)
    case 45:      // Insert
      return !evt.shiftKey;
  }

  return false;
}

scSitecore.prototype.postEvent = function (tag, evt, parameters) {
  var result = false;

  if (evt.type == "contextmenu") {
    if (evt.ctrlKey) {
      return null;
    }

    this.contextmenu = this.browser.getSrcElement(evt);
  }

  this.lastEvent = evt;

  if (parameters != null && parameters.substring(0, 11) == "javascript:") {
    result = eval(parameters.substr(11).replace(/#quote#|&quot;/gi, "'"));
  }
  else {
    var ctl = this.getEventControl(evt, tag);

    var request = new scRequest();
    request.evt = evt;

    request.build(tag ? tag.id : "", (ctl != null ? ctl.id : ""), evt.type, parameters, true, this.contextmenu, this.modified);

    request.buildFields();

    result = request.execute();
  }

  this.lastEvent = null;

  this.browser.clearEvent(evt, true, result);

  return result;
}

scSitecore.prototype.postMessage = function(message, target, top, postSelf) {
  var win = window;
  var topWindow = null;

  do {
    topWindow = win;
    var form = win.scForm;
    if (form == null) {
      return;
    }

    var ctl = form.browser.getControl("__FRAMENAME");

    if (ctl != null) {
      if (ctl.value == top) {
        break;
      }
    }

    if (win.parent == null || win.parent == win) {
      if (win.opener != null && win.opener != win) {
        this.postMessageToWindow(win, message, target, postSelf);

        win = win.opener;
      }
      else if (win.dialogHeight != null) {
        this.postMessageToWindow(win, message, target, postSelf);

        try {
          win = win.dialogArguments[0];
          var dummy = win.scForm;
        }
        catch (e) {
          win = null;
        }
      }
      else {
        win = null;
      }
    }
    else {
      win = win.parent;
    }
  } while (win != null);

  if (topWindow != null) {
    this.postMessageToWindow(topWindow, message, target, postSelf);
  }
}

scSitecore.prototype.postMessageToWindow = function(win, message, target, postSelf) {
  if (win.scForm != null) {
    var ok = true;

    if (target != null) {
      var ctl = win.scForm.browser.getControl("__FRAMENAME");
      ok = (ctl != null && ctl.value == target);
    }

    var ctl = win.scForm.browser.getControl("__IGNOREMESSAGES");
    if (ctl != null && ctl.value == "1") {
      ok = false;
    }

    if (ok && (postSelf == true || win != window)) {
      win.scForm.postRequest("", "", "", message);
    }
  }

  for (var n = 0; n < win.frames.length; n++) {
    try {
      this.postMessageToWindow(win.frames[n], message, target, postSelf);
    } catch (ex) {
      console.log("Failed to accees frame. This typically happens due to a Permission Denied exception in IE9 caused by an intricate issue with Popup and ShowModalDialog calls. " + ex.message);
    }
  }
}

scSitecore.prototype.postRequest = function(control, source, eventtype, parameters, callback, async) {  
  var request = new scRequest();

  request.parameters = parameters;

  request.build(control, source, eventtype, parameters, true, this.contextmenu, this.modified);
  request.buildFields();

  request.callback = callback;
  request.async = (async == true);

  return request.execute();
}

scSitecore.prototype.postResult = function(result, pipeline) {
  var request = new scRequest();

  request.form = "&__RESULT=" + encodeURIComponent(result) +
    "&__PIPELINE=" + encodeURIComponent(pipeline);
  request.buildFields();

  request.pipeline = pipeline;

  return request.execute();
}

scSitecore.prototype.process = function (request, command, name) {
  name = (name == null ? command.command : name);
  this.state.pipeline = request.pipeline;

  switch (name) {
    case "Alert":
      alert(command.value);
      if (command.response != null) {
        this.postResult(command.response, request.pipeline);
      }
      break;

    case "Broadcast":
      if (window.dialogArguments != null) {
        this.broadcast(window.dialogArguments[0].top, request, command);
      }
      this.broadcast(window.top, request, command);
      break;

    case "Cache":
      this.cache[request.cacheKey] = request.response;
      break;

    case "CheckModified":
      if (command.frame == null) {
        var form = this;
      }
      else {
        var form = this.browser.getControl(command.frame);
        if (form != null) {
          form = form.contentWindow.scForm;
        }
      }

      var modified = false;
      if (form != null) {
        try {
          modified = form.modified;
        }
        catch (e) {
        }
      }

      if (modified) {
        if (request.dialogResult == "__!!NoDialogResult!!__") {
          this.browser.closePopups("checkModifiedShowModalDialog");
          this.browser.showModalDialog("/sitecore/shell/default.aspx?xmlcontrol=YesNoCancel&te=" + command.value, new Array(window), "dialogWidth:300px;dialogHeight:136px;help:no;scroll:auto;resizable:yes;status:no;center:yes", request);
        }

        var r = request.dialogResult;

        if (r != "__!!NoDialogResult!!__") {
          switch (r) {
            case "yes":
              form.setModified(false);
              var saved = form.postRequest("", "", "", command.disableNotifications == "1" ? "item:save(disableNotifications=true)" : "item:save");

              if (saved == "failed") {
                form.setModified(true);
                request.abort = true;
                r = "cancel";
              }
              break;

            case "no":
              form.setModified(false);
              form.disableRequests = false;
              break;

            case "cancel":
              request.abort = true;
              form.disableRequests = false;
              break;
          }

          if (command.response == "1") {
            var modified = form.modified;
            this.postResult(r, request.pipeline);
            form.setModified(modified);
          }
        }
      }
      else {
        if (command.response == "1") {
          this.postResult("no", request.pipeline);
        }
      }
      break;

    case "CloseWindow":
      window.top.close();
      break;

    case "ClosePopups":
      if (command.value == "1") {
        this.browser.closePopups("ClosePopupsCommand");
      }
      else {
        request.closePopups = false;
      }
      break;

    case "Confirm":
      if (confirm(command.value)) {
        this.postResult("yes", request.pipeline);
      }
      else {
        this.postResult("no", request.pipeline);
      }
      break;

    case "Debug":
      window.defaultStatus =
        "ViewState: " + command.viewstatesize + " bytes; " +
        "ControlStore: " + command.controlstoresize + " bytes; " +
        "Controls: " + command.controlcount + "; " +
        "Client time: " + request.timer + "ms; " +
        "Response: " + request.response.length + " bytes; " +
        "Commands: " + request.commands.length + ";";
      break;

    case "Download":
      var iframe = document.createElement("iframe")
      if (command.value.substring(0, 4) == 'http') {
        iframe.src = command.value;
      } else {
        iframe.src = "/sitecore/shell/download.aspx?file=" + encodeURIComponent(command.value);
      }
      iframe.width = "1";
      iframe.height = "1";
      iframe.style.position = "absolute";
      iframe.style.display = "none";
      document.body.appendChild(iframe);
      break;

    case "Eval":
      var r = eval(command.value);

      if (command.response != null) {
        this.postResult(r, request.pipeline);
      }
      break;

    case "Error":
      this.browser.showModalDialog("/sitecore/shell/controls/reload.htm", new Array(command.value), "center:yes;help:no;resizable:yes;scroll:yes;status:no;", request);
      window.top.location.href = window.top.location.href;
      break;

    case "Focus":
      var ctl = this.browser.getControl(command.value);
      if (ctl != null) {
        this.focus(ctl);

        if (command.scrollintoview == "1") {
          this.browser.scrollIntoView(ctl);
        }
      }
      break;

    case "Input":
      var input = command.defaultValue;
      var maxlength = (command.maxlength != null ? parseInt(command.maxlength, 10) : 0);

      while (true) {
        if (command.validation != null) {
          var re = new RegExp(command.validation);

          while (true) {
            input = scForm.browser.prompt(command.value, input);
            if (input == null || re.test(input)) {
              break;
            }
            alert(command.validationtext.replace(/\$Input/gi, input));
          }
        }
        else {
          input = scForm.browser.prompt(command.value, input);
        }

        if (maxlength == 0 || input == null || input.length <= maxlength) {
          break;
        }

        alert(command.maxLengthValidatationText);
      }

      if (typeof (input) == "undefined") {
        input = null;
      }

      this.postResult(input, request.pipeline);
      break;

    case "Insert":
      var id = command.id;
      var where = command.where;

      var ctl = (id != null && id != "" ? this.browser.getControl(id) : document.body);

      if (ctl != null) {
        if (where == "table") {
          this.insertIntoTable(ctl, command);
        }
        else if (where == "div") {
          this.insertIntoDiv(ctl, command);
          scTreeview.align();
        }
        else if (where == "append") {
          var div = document.createElement("div");

          if (command.tag != null) {
            command.value = "<" + command.tag + ">" + command.value + "</" + command.tag + ">";
          }

          div.innerHTML = command.value;

          var source = (command.tag != null ? div.childNodes[0] : div);

          while (source.childNodes.length > 0) {
            ctl.appendChild(source.childNodes[0]);
          }
        }
        else {
          if (where == null || where == "") {
            where = "afterBegin";
          }
          this.browser.insertAdjacentHTML(ctl, where, command.value);
        }
      }
      break;

    case "Redraw":
      request.currentCommand++;
      request.suspend = true;

      this.suspended[this.uniqueID] = request;
      setTimeout("scForm.resume(" + this.uniqueID + ")", 0);

      this.uniqueID++;
      break;

    case "RegisterKey":
      this.registerKey(command.keycode, command.value, command.group);
      break;

    case "RegisterTranslation":
      this.registerTranslation(command.key, command.value);
      break;

    case "Remove":
      var ctl = this.browser.getControl(command.id);
      if (ctl != null) {
        this.browser.removeChild(ctl);
      }
      break;

    case "SetAttribute":
      var ctl = this.browser.getControl(command.id);
      if (ctl != null) {
        var value = command.value;

        switch (command.name) {
          case "id":
            ctl.id = value;
            break;
          case "class": case "className":
            ctl.className = value;
            break;
          case "disabled":
            ctl.disabled = value;
            break;
          case "checked":
            ctl.checked = value;
            break;
          case "value":
            ctl.value = value;
            break;
          default:
            ctl.setAttribute(command.name, value);
        }
      }
      break;

    case "SetDialogValue":
      window.returnValue = command.value;
      if (!this.browser.isIE) {
        var win = window.top;
        if (win.opener != null) {
          win = win.opener.top;
        }
        win.returnValue = command.value;
      }
      break;

    case "SetInnerHtml":
      var ctl = this.browser.getControl(command.id);
      if (ctl != null) {
        var value = this.expandHtml(command.value);

        if (ctl.tagName == "TEXTAREA") {
          ctl.value = value;
        }
        else {
          var scrollTop = null;
          var scrollElement = ctl;
          if (command.preserveScrollTop == true) {
            if (command.preserveScrollElement != null) {
              scrollElement = this.browser.getControl(command.preserveScrollElement);
            }

            scrollTop = scrollElement.scrollTop;
          }

          ctl.innerHTML = value;

          var re = /<script\b[\s\S]*?>([\s\S]*?)<\//ig;
          var match;
          while (match = re.exec(value)) {
            eval(match[1]);
          }

          if (scrollTop != null) {
            window.setTimeout("scForm.browser.getControl('" + scrollElement.id + "').scrollTop=" + scrollTop, 1);
          }
        }
      }
      break;

    case "SetLocation":
      try {
        if (command.value != null && command.value != "") {
          location.href = command.value;
        }
        else {
          location.reload(true);
        }
      }
      catch (e) {
        // silent - user may have aborted action
      }
      break;

    case "SetModified":
      this.setModified(command.value);
      break;

    case "SetOuterHtml":
      var ctl = this.browser.getControl(command.id);
      if (ctl != null) {
        this.browser.setOuterHtml(ctl, this.expandHtml(command.value));
      }
      break;

    case "SetPipeline":
      request.pipeline = command.value;
      break;

    case "SetReturnValue":
      request.returnValue = command.value;
      break;

    case "SetStyle":
      var ctl = this.browser.getControl(command.id);
      if (ctl != null) {
        ctl.style[command.name] = command.value;
      }
      break;

    case "SetTableRowClass":
      var ctl = this.browser.getControl(command.id);
      if (ctl != null) {
        ctl.className = command.row;

        ctl.childNodes[0].className = command.firstcell;

        for (var n = 1; n < ctl.childNodes.length - 1; n++) {
          ctl.childNodes[n].className = command.cell;
        }

        ctl.childNodes[ctl.childNodes.length - 1].className = command.lastcell;
      }
      break;

    case "ShowModalDialog":
      if (request.dialogResult == "__!!NoDialogResult!!__") {
        this.browser.closePopups("ShowModalWindowCommand");

        window.___Message = command.message;
        this.browser.showModalDialog(command.value, new Array(window), command.features, request);
      }

      var r = request.dialogResult;

      if (r != "__!!NoDialogResult!!__") {
        if (command.response != null) {
          this.postResult(r, request.pipeline);
        }

        if (r != null && command.message != null) {
          this.postRequest("", "", "", command.message);
        }
      }
      break;

    case "ShowPopup":
      this.showPopup(command);
      request.closePopups = false;
      break;

    case "Timer":
      setTimeout("scForm.postRequest(\"\", \"\", \"\", \"" + command["event"] + "\")", command.delay);
      break;

    case "UnregisterKeyGroup":
      this.unregisterKeyGroup(command.value);
      break;
  }
}

scSitecore.prototype.resume = function(suspendID) {
  var request = this.suspended[suspendID];

  if (request != null) {
    delete this.suspended[suspendID];
    request.resume();
  }
}

scSitecore.prototype.hasSuspendedRequests = function() {
  for (var n in this.suspended) {
    if (n != null) {
      return true;
    }
  }

  return false;
}

scSitecore.prototype.rollOver = function(tag, evt) {
  if (!tag.disabled) {
    if (tag.tagName == "IMG") {
      var src = this.browser.getImageSrc(tag);

      var ext = src.substr(src.lastIndexOf("."));
      src = src.substr(0, src.length - ext.length);

      if (src.indexOf("_h") >= 0) {
        src = src.substr(0, src.lastIndexOf("_h"));
      }

      switch (evt.type) {
        case "mouseover": case "focus":
          this.browser.setImageSrc(tag, src + "_h" + ext);
          break;
        case "mouseout": case "blur":
          this.browser.setImageSrc(tag, src + ext);
          break;
      }
    }
    else {
      this.setClass(tag, evt.type == "mouseover" || evt.type == "focus", "_Hover");

      for (var n = 0; n < tag.childNodes.length; n++) {
        this.setClass(tag.childNodes[n], evt.type == "mouseover", "_Hover");
      }
    }
  }

  return false;
}

scSitecore.prototype.scrollIntoView = function(id, alignToTop, force) {
  if (force == null || force == false) {
    if (window.dialogArguments == null) {
      return;
    }
  }

  var ctl = scForm.browser.getControl(id);
  if (ctl != null) {
    ctl.scrollIntoView(alignToTop == null ? false : alignToTop);
  }
}

scSitecore.prototype.setClass = function(tag, enable, modifier) {
  var className = tag.className;

  if (className != null && className != "") {
    var tail = className.substr(className.length - modifier.length, modifier.length)

    if (enable) {
      if (tail != modifier) {
        tag.className = className + modifier;
      }
    }
    else {
      if (tail == modifier) {
        tag.className = className.substr(0, className.length - modifier.length);
      }
    }
  }
}

scSitecore.prototype.setCookie = function(name, value, expires, path, domain, secure) {
  if (expires == null) {
    expires = new Date();
    expires.setMonth(expires.getMonth() + 3);
  }

  if (path == null) {
    path = "/";
  }

  document.cookie = name + "=" + escape(value) +
    (expires ? "; expires=" + expires.toGMTString() : "") +
    (path ? "; path=" + path : "") +
    (domain ? "; domain=" + domain : "") +
    (secure ? "; secure" : "");
}

scSitecore.prototype.setModified = function(value) {
  this.modified = value;
}

scSitecore.prototype.showContextMenu = function(tag, evt, controlid) {
  if (evt.ctrlKey == true) {
    return null;
  }

  var ctl = this.getEventControl(evt, tag);

  this.contextmenu = (ctl != null ? ctl.id : "");

  if (!this.browser.isIE && !this.browser.isWebkit) {    
    window.event = evt;    
  }
  
  this.showPopup(null, null, controlid);

  this.browser.clearEvent(evt, true, false);

  return false;
}

scSitecore.prototype.showPopup = function(node, id, controlid, where, value, doc) {
  var evt = (scForm.lastEvent != null ? scForm.lastEvent : window.event);

  if (doc == null) {
    doc = document;

    if (document.popup != null && evt != null && evt.srcElement != null) {
      doc = evt.srcElement.ownerDocument;
    }
  }

  if (node == null) {
    node = new Object();
    node.controlid = controlid;
    node.id = id;
    node.where = where;
    node.value = value;
  }

  if (node.controlid != null) {
    var ctl = this.browser.getControl(node.controlid, doc);

    if (ctl == null) {
      alert("Control \"" + node.controlid + "\" not found.");
      return;
    }

    node.value = ctl;
  }

  this.browser.showPopup(node);
}

scSitecore.prototype.registerTranslation = function(key, message) {
  var k = new Object();
  k.message = message;

  this.keymap[key] = k;
}

scSitecore.prototype.translate = function(key) {
  var k = this.keymap[key];

  if (k != null) {
    return k.message;
  }

  return key;
}

scSitecore.prototype.unregisterKeyGroup = function(group) {
  for (var key in this.keymap) {
    var k = this.keymap[key];

    if (this.keymap[key].group == group) {
      delete this.keymap[key];
    }
  }
}


function scRequest() {
  this.abort = false;
  this.async = false;
  this.cacheKey = "";
  this.closePopups = true;
  this.contextmenu = "";
  this.control = "";
  this.currentCommand = 0;
  this.dialogResult = "__!!NoDialogResult!!__";
  this.evt = null;
  this.eventtype = "";
  this.form = "";
  this.isevent = false;
  this.modified = false;
  this.parameters = "";
  this.pipeline = "";
  this.response = null;
  this.returnValue = false;
  this.source = "";
  this.suspend = false;
  this.timer = new Date();
  this.url = null;

  this.async = this.isAsync();
}

scRequest.prototype.debug = function() {
  for (var index = 0; index < this.commands.length; index++) {
    var command = this.commands[index];

    if (command.command != null) {
      var text = "";

      for (var key in command) {
        if (key != "value") {
          text += "\n" + key + "=" + command[key];
        }
      }

      text = command.command + text + "\n\n" + command.value;
    }
  }
}

scRequest.prototype.build = function (control, source, eventtype, parameters, isevent, contextmenu, modified) {
  this.control = control;
  this.source = source;
  this.eventtype = eventtype;
  this.parameters = parameters;
  this.isevent = isevent;
  this.contextmenu = contextmenu;
  this.modified = modified;

  this.form += "&__PARAMETERS=" + escape(this.parameters != null ? this.parameters : "") +
    "&__EVENTTARGET=" + escape(this.control) +
    "&__EVENTARGUMENT=" +
    "&__SOURCE=" + escape(this.source) +
    "&__EVENTTYPE=" + escape(this.eventtype) +
    "&__CONTEXTMENU=" + escape(this.contextmenu) +
    "&__MODIFIED=" + (this.modified ? "1" : "");

  if (this.isevent) {
    this.form += "&__ISEVENT=1";
  }

  this.cacheKey = this.form;

  if (this.evt != null) {
    this.form += "&__SHIFTKEY=" + (this.evt.shiftKey ? "1" : "") +
      "&__CTRLKEY=" + (this.evt.ctrlKey ? "1" : "") +
      "&__ALTKEY=" + (this.evt.altKey ? "1" : "") +
      "&__BUTTON=" + this.evt.button +
      "&__KEYCODE=" + this.evt.keyCode +
      "&__X=" + this.evt.clientX +
      "&__Y=" + this.evt.clientY +
      "&__URL=" + escape(location.href);
  }

  if (window.dialogWidth != null) {
    this.form += "&__DIALOGWIDTH=" + escape(window.dialogWidth) +
      "&__DIALOGHEIGHT=" + escape(window.dialogHeight);
  }

  this.form = scForm.getParameters(this.form);
}

scRequest.prototype.buildFields = function (doc) {
  if (doc == null) {
    doc = document;
  }

  for (var e = scForm.browser.getEnumerator(doc.getElementsByTagName("INPUT")); !e.atEnd(); e.moveNext()) {
    var ctl = e.item();

    if ((ctl.type != "checkbox" && ctl.type != "radio") || ctl.checked) {
      this.form += this.getValue(ctl, ctl.value);
    }
  }

  for (var e = scForm.browser.getEnumerator(doc.getElementsByTagName("TEXTAREA")); !e.atEnd(); e.moveNext()) {
    var ctl = e.item();
    if (ctl.className != "scSheerIgnore") {
      this.form += this.getValue(ctl, ctl.value);
    }
  }

  for (var e = scForm.browser.getEnumerator(doc.getElementsByTagName("IFRAME")); !e.atEnd(); e.moveNext()) {
    var iframe = e.item();

    try {
      if (typeof (iframe.contentWindow.scGetFrameValue) != "undefined") {
        var v = iframe.contentWindow.scGetFrameValue(this.form, this);

        if (v != null) {
          this.form += this.getValue(iframe, v);
        }
      }
      else {
        var attr = iframe.attributes["sc_value"];

        if (attr != null) {
          this.form += this.getValue(iframe, attr.value);
        }
      }
    } catch (ex) {
      console.log("Failed to call scGetFrameValue in IFrame tag. This typically happens due to a Permission Denied exception in IE9 caused by an intricate issue with Popup and ShowModalDialog calls. " + ex.message);
    }
  }

  for (var e = scForm.browser.getEnumerator(doc.getElementsByTagName("SELECT")); !e.atEnd(); e.moveNext()) {
    var options = "";

    for (var o = scForm.browser.getEnumerator(e.item().options); !o.atEnd(); o.moveNext()) {
      if (o.item().selected) {
        options += (options != "" ? "," : "") + o.item().value;
      }
    }

    if (options != "") {
      this.form += this.getValue(e.item(), options);
    }
  }
}

scRequest.prototype.execute = function() {
  this.evt = null;

  this.send();

  if (!this.async) {
    return this.handle();
  }

  return false;
}

scRequest.prototype.handle = function() {
  if (this.httpRequest != null) {
    if (this.httpRequest.status != "200") {
      scForm.browser.showModalDialog("/sitecore/shell/controls/error.htm", new Array(this.httpRequest.responseText), "center:yes;help:no;resizable:yes;scroll:yes;status:no;");
      return false;
    }

    if (this.httpRequest.responseText.indexOf("/sitecore/login/default.js") >= 0) {
      window.top.location = "/sitecore";
      return false;
    }

    this.response = this.httpRequest.responseText;
  }

  if (this.response != null) {
    var result = null;

    if (this.response.substr(0, 12) != "{\"commands\":") {
      result = this.response;
    }
    else {
      this.parse();

      this.resume();

      result = this.returnValue;
    }

    if (this.callback != null) {
      this.callback(result);
    }

    return result;
  }

  return false;
}

scRequest.prototype.getValue = function(ctl, value) {
  var key = (ctl.name != null && ctl.name != "" ? ctl.name : (ctl.id != null && ctl.id != "" ? ctl.id : null));

  if (key != null) {
    return "&" + key + "=" + encodeURIComponent(value);
  }

  return "";
}

scRequest.prototype.isAsync = function() {
  var ctl = document.getElementsByName("__VIEWSTATE");

  if (ctl != null) {
    for (var n = 0; n < ctl.length; n++) {
      var value = ctl[n].value;

      if (value != null && value.length > 0) {
        return value.indexOf(":async") >= 0;
      }
    }
  }

  return false;
}

scRequest.prototype.parse = function() {
  var c = eval('(' + this.response + ')');

  this.commands = c.commands;

  if (scForm.debug) {
    this.debug();
  }
}

scRequest.prototype.resume = function () {
  this.suspend = false;

  while (this.currentCommand < this.commands.length) {
    scForm.process(this, this.commands[this.currentCommand]);

    this.dialogResult = "__!!NoDialogResult!!__";

    if (this.abort || this.suspend) {
      break;
    }

    this.currentCommand++;
  }

  var canClose = true;

  if (this.source != "") {
    var ctl = $(this.source);

    if (ctl == null) {
      var lastEvent = scForm.lastEvent;
      if (lastEvent != null) {
        var srcElement = scForm.browser.getSrcElement(lastEvent);
        if (srcElement != null) {
          var win = scForm.browser.getParentWindow(srcElement.ownerDocument);
          if (win != null && win.document) {            
            ctl = $(win.document.getElementById(this.source));                          
          }
        }
      }
    }

  if (ctl != null && ctl.ancestors) {
      var ancestors = ctl.ancestors();
      if (ancestors.find(function (e) { return e.hasClassName("scPopupTree"); }) != null) {
        canClose = ancestors.find(function (e) { return e.hasClassName("scTreeItem"); }) != null;
      }
    }
  }

  if (canClose && this.closePopups && typeof (scForm) != "undefined") {
    scForm.browser.closePopups("Request");
  }

  return this.returnValue;
}

scRequest.prototype.send = function() {
  if (this.cacheKey != null && this.cacheKey != "") {
    this.response = scForm.cache[this.cacheKey];
  }

  if (this.response == null) {
    var url = this.url;

    if (url == null) {
      var url = location.href;

      if (url.indexOf(".aspx") < 0 &&
         (url.substr(url.length - "/sitecore/shell/".length, "/sitecore/shell/".length) == "/sitecore/shell/" ||
          url.substr(url.length - "/sitecore/shell".length, "/sitecore/shell".length) == "/sitecore/shell")) {
        var n = url.indexOf("?");
        var qs = "";

        if (n >= 0) {
          qs = url.substr(n);
          url = url.substr(0, n);
        }

        url += (url.substr(url.length - 1) != "/" ? "/" : "") + "default.aspx" + qs;
      }

      if (url.indexOf("#") >= 0) {
        url = url.substr(0, url.indexOf("#"));
      }
    }

    this.httpRequest = scForm.browser.createHttpRequest();

    this.httpRequest.open("POST", url, this.async);

    this.httpRequest.setRequestHeader("lastCached", new Date().toString());
    this.httpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    if (this.async) {
      this.httpRequest.onreadystatechange = scRequestHandler;
      scForm.requests.push(this);
    }
    else {
      var status = window.defaultStatus;
      window.defaultStatus = "Communicating with the Sitecore server...";
    }

    this.timer = new Date();

    try {
      this.httpRequest.send(this.form);
    }
    catch (e) {
      alert("An error occured while communicating with the Sitecore server:\n\n" + e.message);
    }

    if (!this.async) {
      //var sleep = new Date();
      //while(new Date() - sleep < 500) {
      //}

      this.timer = new Date() - this.timer;

      window.defaultStatus = status;
    }
  }
}

function scRequestHandler() {
  for (var n = scForm.requests.length - 1; n >= 0; n--) {
    var request = scForm.requests[n];

    if (request != null) {
      if (request.httpRequest.readyState == 4) {
        if (scForm.requests.length == 1) {
          scForm.requests = new Array();
        }
        else {
          scForm.requests.splice(n, 1);
        }

        request.handle();
      }
    }
  }
}

function scKeepAlive() {
  var img = document.getElementById("scKeepAlive");

  if (img == null) {
    img = document.createElement("img");

    img.id = "scKeepAlive";
    img.width = "1";
    img.height = "1";
    img.alt = "";
    img.style.position = "absolute";
    img.style.display = "none"; /* if set to "", causes scrollbars in firefox */

    document.body.appendChild(img);
  }

  img.src = "/sitecore/service/keepalive.aspx?ts=" + Math.round(Math.random() * 12361814);
}

function scDing() {
  var span = scForm.browser.getControl("ding");

  if (span == null) {
    var span = document.createElement("bgsound");
    document.body.appendChild(span);
    span.id = "ding";
  }

  span.src = "/sitecore/shell/themes/standard/phaser.wav";
}

var scForm = new scSitecore();

function scInitializeGrid(sender, args) {
  try {
    new ComponentArtGrid(sender);
  }
  catch (e) {
    console.warn("Grid handler class is not loaded: %s", e.message);
  }
}

var scFlashDetection = function() {
  var isIE = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;
  var isWin = (navigator.appVersion.toLowerCase().indexOf("win") != -1) ? true : false;
  var isOpera = (navigator.userAgent.indexOf("Opera") != -1) ? true : false;

  function ControlVersion() {
    var version;
    var axo;
    var e;

    try {
      axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");
      version = axo.GetVariable("$version");
    } catch (e) {
    }

    if (!version) {
      try {
        axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");

        version = "WIN 6,0,21,0";

        axo.AllowScriptAccess = "always";

        version = axo.GetVariable("$version");

      } catch (e) {
      }
    }

    if (!version) {
      try {
        axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.3");
        version = axo.GetVariable("$version");
      } catch (e) {
      }
    }

    if (!version) {
      try {
        axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.3");
        version = "WIN 3,0,18,0";
      } catch (e) {
      }
    }

    if (!version) {
      try {
        axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
        version = "WIN 2,0,0,11";
      } catch (e) {
        version = -1;
      }
    }

    return version;
  }

  function GetSwfVer() {
    var flashVer = -1;

    if (navigator.plugins != null && navigator.plugins.length > 0) {
      if (navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {
        var swVer2 = navigator.plugins["Shockwave Flash 2.0"] ? " 2.0" : "";
        var flashDescription = navigator.plugins["Shockwave Flash" + swVer2].description;
        var descArray = flashDescription.split(" ");
        var tempArrayMajor = descArray[2].split(".");
        var versionMajor = tempArrayMajor[0];
        var versionMinor = tempArrayMajor[1];
        if (descArray[3] != "") {
          tempArrayMinor = descArray[3].split("r");
        } else {
          tempArrayMinor = descArray[4].split("r");
        }
        var versionRevision = tempArrayMinor[1] > 0 ? tempArrayMinor[1] : 0;
        var flashVer = versionMajor + "." + versionMinor + "." + versionRevision;
      }
    }
    else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.6") != -1) flashVer = 4;
    else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.5") != -1) flashVer = 3;
    else if (navigator.userAgent.toLowerCase().indexOf("webtv") != -1) flashVer = 2;
    else if (isIE && isWin && !isOpera) {
      flashVer = ControlVersion();
    }
    return flashVer;
  }

  function scPersistFlashVersion() {
    versionStr = GetSwfVer();
    if (versionStr == -1) {
      scForm.setCookie("sc_fv", "0.0.0", "");
    }
    else if (versionStr != 0) {
      if (isIE && isWin && !isOpera) {
        // Given "WIN 2,0,0,11"
        tempArray = versionStr.split(" ");   // ["WIN", "2,0,0,11"]
        tempString = tempArray[1];      // "2,0,0,11"
        versionArray = tempString.split(",");  // ['2', '0', '0', '11']
      }
      else {
        versionArray = versionStr.split(".");
      }

      var versionMajor = versionArray[0];
      var versionMinor = versionArray[1];
      var versionRevision = versionArray[2];

      var version = versionMajor + "." + versionMinor + "." + versionRevision;
      scForm.setCookie("sc_fv", version, "");
    }
  }

  scPersistFlashVersion();
};

if (!scForm.getCookie("sc_fv")) {
  scFlashDetection();
}

/*
 * Treeview.
 */

var scTreeview = new Treeview();

function Treeview()
{
  this.columnCount = null;
  this.initialized = false;
  this.rows = null;
  this.treeview = null;
  this.isHidden = false;
}

Treeview.prototype.align = function()
{
  try
  {
    this.initialize();
  }
  catch (exception)
  {
    return;
  }

  if (this.treeview.getHeight() == 0) {
    this.isHidden = true;
    return;
  }

  this.isHidden = false;
  
  for (var i = 0; i < this.columnCount; i++)
  {
    this.alignColumn(i);
  }

  this.treeview.setStyle("width: " + this.getTreeviewWidth() + "px");
}

Treeview.prototype.alignColumn = function(column)
{
  var cells = this.getColumnCells(column);
  var maxWidth = this.getMaxCellWidth(cells);

  for (var i = 0; i < cells.length; i++)
  {
    cells[i].setStyle("width: " + maxWidth + "px");
  }
}

Treeview.prototype.getColumnCells = function(column)
{
  var cells = new Array();

  for (var i = 0; i < this.rows.length; i++)
  {
    cells.push(this.rows[i].childElements()[column]);
  }

  return cells;
}

Treeview.prototype.getMaxCellWidth = function(cells)
{
  var maxWidth = 0;

  for (var i = 0; i < cells.length; i++)
  {
    var width = cells[i].offsetWidth;

    if (width > maxWidth)
    {
      maxWidth = width;
    }
  }

  return maxWidth;
}

Treeview.prototype.getRows = function()
{
  var treeHeader = $$(".scTreeHeader")[0];
  
  if ((treeHeader == undefined) || !treeHeader)
  {
    throw "Treeview exception: Tree header was not found.";
  }

  var dataRows = $$(".scTreeItem");

  if ((dataRows == undefined) || !dataRows || (dataRows.length == 0))
  {
    throw "Treeview exception: Data rows were not found.";
  }

  var rows = new Array();
  rows.push(treeHeader);

  for (var i = 0; i < dataRows.length; i++)
  {
    rows.push(dataRows[i]);
  }

  return rows;
}

Treeview.prototype.getTreeviewWidth = function()
{
  if (this.rows.length == 0)
  {
    return 0;
  }

  var width = 0;
  var cells = this.rows[0].childElements();

  for (var i = 0; i < cells.length; i++)
  {
    width += cells[i].offsetWidth + 1;
  }

  return width;
}

Treeview.prototype.initialize = function()
{
  this.rows = this.getRows();

  if (this.initialized)
  {
    return;
  }

  var columnCount = this.rows[0].childElements().length;

  if (columnCount == 0)
  {
    throw "Treeview exception: No columns found.";
  }

  this.columnCount = columnCount;

  var treeview = $$(".scTreeview")[0];

  if ((treeview == undefined) || !treeview)
  {
    throw "Treeview exception: Treeview was not found.";
  }

  this.treeview = treeview;

  this.initialized = true;
}

Treeview.prototype.FixLayout = function()
{
  var widthAdjustment = 17;

  if (scForm.browser.isIE) {  
    var itemsToFix = $$('.scTreeview .cell.text');
    if (itemsToFix.length == 0 && document.popup) {
      itemsToFix = Element.select(document.popup.document, '.scTreeview .cell.text');
    }

    itemsToFix
      .findAll(function (el) { return !el.style.width })
      .each(function (el) { el.style.width = widthAdjustment + parseInt(el.style.marginLeft, 10) + el.down('div').offsetWidth + 'px'; });

  }
  else if (scForm.browser.isFirefox) {
    $$('.scTreeview .cell.text')
      .findAll(function (el) { return !el.style.minWidth })
      .each(function (el) { el.style.minWidth = widthAdjustment + parseInt(el.style.marginLeft, 10) + el.down('div').offsetWidth + 'px'; });
  }
};

/*
* Checks if the element is the silverlight Engagement Plan object
*/
function isSilverlightApplicationLoaded(element) {
  return (element != null && (element.id == "scSilverlightEngagementPlan") || element.id == "scSilverlightExecutiveDashboard");
}