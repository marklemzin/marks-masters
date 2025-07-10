// Ask for source and output folders
inputDir = getDirectory("Choose the input folder");
outputDir = getDirectory("Choose the output folder");

// Get list of JPG files
list = getFileList(inputDir);

// Store file paths for each condition
redFiles = newArray();
gfpFiles = newArray();
conditions = newArray();

// --- Step 1: Parse files ---
for (i = 0; i < list.length; i++) {
    name = list[i];
    if ( endsWith(name, ".jpg") || endsWith(name, ".JPG") || endsWith(name, ".tif") || endsWith(name, ".tif") ) {
        if (indexOf(name, "gfp") != -1 || indexOf(name, "red") != -1) {
			parts = split(name); // Split by whitespace
			if ( parts.length > 2) { // For typical naming convention I.E. '317 100x gfp 100ms'
				cond = parts[0] + " " + parts[1];
				conditions = Array.concat(conditions, cond);
				if (indexOf(name, "red") != -1) {
					redFiles = Array.concat(redFiles, inputDir + name + "::" + cond);
				}
				if (indexOf(name, "gfp") != -1) {
					gfpFiles = Array.concat(gfpFiles, inputDir + name + "::" + cond);
				}
			}
			if ( parts.length == 2 ) { // For shortened naming convention I.E. '317 gfp'
				cond = parts[0];
				conditions = Array.concat(conditions, cond);
				if (indexOf(name, "red") != -1) {
					redFiles = Array.concat(redFiles, inputDir + name + "::" + cond);
				}
				if (indexOf(name, "gfp") != -1) {
					gfpFiles = Array.concat(gfpFiles, inputDir + name + "::" + cond);
				}
			}
        }
    }
}

Array.print(conditions);
Array.print(redFiles);
Array.print(gfpFiles);

// --- Step 2: Process each condition ---
for (j = 0; j < conditions.length; j++) {
	
	cond = conditions[j];
	
	// Look up the red and gfp files for this condition
    redPath = "";
    gfpPath = "";
	
	for (k = 0; k < redFiles.length; k++) {
		
        parts = split(redFiles[k], "::");
        if (parts[2] == cond) {
            redPath = parts[1];
            break;
        }
    }
	
	for (k = 0; k < gfpFiles.length; k++) {
        parts = split(gfpFiles[k], "::");
        if (parts[2] == cond) {
            gfpPath = parts[1];
            break;
        }
    }
	
	// Skip if any file is missing
    if (redPath == "" || gfpPath == "") {
        print("Skipping condition: " + cond + " (missing red or gfp)");
        continue;
    }
	
	// --- Load and process red image ---
    open(redPath);
    run("8-bit");
	run("Bandpass Filter...", "filter_large=200 filter_small=0");
    run("Gamma...", "value=0.6");
    rename("Red");
    run("Duplicate...", "title=RedDup");
    run("Duplicate...", "title=GreenDup");

    // --- Load and process gfp image ---
    open(gfpPath);
    run("8-bit");
	run("Bandpass Filter...", "filter_large=200 filter_small=0");
    run("Gamma...", "value=0.6");
    rename("Blue");

    // --- Match sizes ---
    selectWindow("Blue");
    width = getWidth();
    height = getHeight();

    selectWindow("RedDup");
    run("Canvas Size...", "width=" + width + " height=" + height + " position=Center zero");
    selectWindow("GreenDup");
    run("Canvas Size...", "width=" + width + " height=" + height + " position=Center zero");

    // --- Merge into RGB image ---
    run("Merge Channels...", "c1=RedDup c2=GreenDup c3=Blue create");
    rename("Merged_" + cond);

    // --- Save output ---
    saveAs("Jpeg", outputDir + "Merged " + cond + ".jpg");

    // --- Close everything ---
    close("Red");
    close("RedDup");
    close("GreenDup");
    close("Blue");
	close("Merged_" + cond);
}