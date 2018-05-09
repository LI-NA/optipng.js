# Optipng.js
Optipng.js is the port of [optipng](http://optipng.sourceforge.net/) in javascript using [emscripten](https://github.com/kripken/emscripten). You can optimize png image file without losing any information in the morden browser using Optipng.js.

Tip: Optipng version is 0.7.7.

## API

### `optipng(file, options, printFunction)`

#### `file`
Please use binary file like readFile on node or Uint8Array (converted from base64) on javascript.
```javascript
// Node.js
var input = fs.readFileSync("input.png");
var output = optipng(input, ["-o2"]);
```
```javascript
// Browser
function dataURLtoUint8(dataurl) {
    var arr = dataurl.split(','),
        mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]),
        n = bstr.length,
        u8arr = new Uint8Array(n);
    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }
    return u8arr;
}
function readFile (file, callback) {
    var fileReader = new FileReader();
    fileReader.onload = function() {
        var ary = dataURLtoUint8(this.target.result);
        callback(ary);
    };
    fileReader.readAsDataURL(file);
}

var input, output;
readFile(your_file_on_here, function(ary) {
    input = ary;
    output = optipng(input, ["-o2"]);
    // do something with output
});
```

#### `options`
Options can be array or object.
```javascript
var options = ["-o2", "-i0", "-strip", "all"];
var options = {o2: true, i0: true, strip: "all"};
// Both options is same options. If use boolean in value, value will be ignored and only key will be inserted as options.
```

#### `printFunction`
This callback function is optional. It will be called if optipng will print something on stdout or stderr.
```javascript
optipng(input, ["-o2"], function(str) {
    console.log(str);
});
```

#### `return`
```javascript
output = {
    data: [output file],
    stdout: [output string],
    stderr: [error string]
};
```

## Full Example

### Node.js
```
$ npm i -S optipng-js
```

```javascript
var optipng = require("optipng-js");
var fs = require("fs");

var input = fs.readFileSync("input.png");
var output = optipng(input, ["-o2"]);
// var output = optipng(input, {"o2": true});
/*
    output = {
        data: output file,
        stdout: output string,
        stderr: error string
    }
*/

console.log(output.stdout);
console.log(output.stderr);

fs.writeFileSync("output.png", out.data);
```

### Browser
Please check Demo with Web worker. [https://li-na.github.io/optipng.js/](https://li-na.github.io/optipng.js/)

## Build
Actually, I don't know what it is but I made build shell script and it seems working. Please let me know if you have ANY better way to build this project.
First, please setup emscript sdk on [here](http://kripken.github.io/emscripten-site/docs/getting_started/downloads.html). Then, download or clone this git and download optipng source code from website. Don't forget to extract optipng on `./deps/optipng`. Finally, just run `./build.sh` on Linux. It will configure optipng and compile with emcc.

## License
[MIT License](LICENSE)