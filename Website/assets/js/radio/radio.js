﻿body {
    font-family: sans-serif;
    font-weight: normal;
    margin: 10px;
    color: #999;
    background-color: #eee;
}

form {
    margin: 40px 0;
}

div {
    clear: both;
    margin: 0 50px;
}

label {
    width: 200px;
    border-radius: 3px;
    border: 1px solid #D1D3D4
}

/* hide input */
input.radio:empty {
    margin-left: -999px;
}

/* style label */
input.radio:empty ~ label {
    position: relative;
    float: left;
    line-height: 2.5em;
    text-indent: 3.25em;
    margin-top: 2em;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

input.radio:empty ~ label:before {
    position: absolute;
    display: block;
    top: 0;
    bottom: 0;
    left: 0;
    content: '';
    width: 2.5em;
    background: #D1D3D4;
    border-radius: 3px 0 0 3px;
}

/* toggle hover */
input.radio:hover:not(:checked) ~ label:before {
    content:'\2714';
    text-indent: .9em;
    color: #C2C2C2;
}

input.radio:hover:not(:checked) ~ label {
    color: #888;
}

/* toggle on */
input.radio:checked ~ label:before {
    content:'\2714';
    text-indent: .9em;
    color: #9CE2AE;
    background-color: #4DCB6D;
}

input.radio:checked ~ label {
    color: #777;
}

/* radio focus */
input.radio:focus ~ label:before {
    box-shadow: 0 0 0 3px #999;
}