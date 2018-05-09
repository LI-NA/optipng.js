	var file = null;

	// Try to get output file.
	try {
		// read processed image data in file
		file = FS.readFile("/output.png");
	} catch (e) {
		// Cleaning up input png from MEMFS
		FS.unlink("/input.png");
		return new Error("No output file: " + stderr);
	}

	// Cleanup files from
	FS.unlink("/output.png");
	FS.unlink("/input.png");

	return {
		"data": file,
		"stdout": stdout,
		"stderr": stderr
	};
};


// for npm... maybe working? idk
if (typeof module !== 'undefined' && typeof module.exports !== 'undefined') {
	module.exports = optipng;
} else {
	optipng.call(this);
}