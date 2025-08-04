// Ask for source and output folders
inputDir = getDirectory("Choose the input folder");
outputDir = getDirectory("Choose the output folder");

// Get list of JPG or TIF files
list = getFileList(inputDir);

// Store file paths for each condition
Files = newArray();
conditions = newArray();

// --- Step 1: Parse files ---
for (i = 0; i < list.length; i++) {
    name = list[i];
    if ( endsWith(name, ".jpg") || endsWith(name, ".JPG") || endsWith(name, ".tif") || endsWith(name, ".tif") ) {
        if (indexOf(name, "gfp") != -1 || indexOf(name, "red") != -1 || indexOf(name, "bf") != -1) {
			parts = split(name); // Split by whitespace
			if ( parts.length == 3 ) { // For extended naming I.E. '317 gfp 10ms'
				cond = name;
				conditions = Array.concat(conditions, cond);
				if (indexOf(name, "red") != -1) {
					Files = Array.concat(Files, inputDir + name + "::" + cond);
				}
				if (indexOf(name, "gfp") != -1) {
					Files = Array.concat(Files, inputDir + name + "::" + cond);
				}
				if (indexOf(name, "bf") != -1) {
					Files = Array.concat(Files, inputDir + name + "::" + cond);
				}
			}
        }
    }
}

Array.print(conditions);
Array.print(Files);

// --- Step 2: Process each condition ---
for (j = 0; j < conditions.length; j++) {
	
	cond = conditions[j];
	
	// Look up the red and gfp files for this condition
    Path = "";
	
	for (k = 0; k < Files.length; k++) {
        parts = split(Files[k], "::");
        if (parts[2] == cond) {
            Path = parts[1];
            break;
        }
    }

	if (Path != "") {
		// --- Load, process and save image ---
		open(Path);
		run("8-bit");
		
		w = getWidth();
		h = getHeight();
		x = w / 3;
		y = h / 3;
		cropWidth = w / 3;
		cropHeight = h / 3;
		makeRectangle(x, y, cropWidth, cropHeight);
		run("Crop");
		
		run("Bandpass Filter...", "filter_large=200 filter_small=0");
		saveAs("Tiff", outputDir + cond + ".tif");
		rename("Temp");
	}
	
    // --- Close everything ---
    run("Close All");
}