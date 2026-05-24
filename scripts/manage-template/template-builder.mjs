import { fileURLToPath } from "node:url";
import fs from 'fs'
import { startSelectionMenu } from "./ui.mjs";
import path, { dirname } from "node:path";

const __filename = fileURLToPath(import.meta.url);
const currentDir = dirname(__filename);


const templatesFolderPath = path.resolve(currentDir, '..', '..', 'templates');
let templates;

try {
    templates = fs.readdirSync(templatesFolderPath);
    // console.log(files);
} catch(err) {
    console.log("❌ Failed to read templates folder: ", err.message);
}




const buildTemplate = (chosenFile) => {
    console.log(chosenFile)
}


startSelectionMenu(templates, buildTemplate)
