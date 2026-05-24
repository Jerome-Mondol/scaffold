import { fileURLToPath } from "node:url";
import fs from 'fs'
import YAML from 'yaml'; 
import { startSelectionMenu } from "./ui.mjs";
import path, { dirname, parse } from "node:path";

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

const targetDir = process.cwd();


const buildTemplate = (chosenFile) => {
    try {
        const yamlFilePath = path.join(templatesFolderPath, chosenFile);
        const yamlFileContent = fs.readFileSync(yamlFilePath, 'utf8');
        const parsedYAML = YAML.parse(yamlFileContent);

        console.log(`\n🏗️  Building your backend layout using: ${chosenFile}...`);

        // Create a small worker function that can dive deep into nested objects
        const createNodes = (currentFolder, structureData) => {
            
            // If it's an array/list of files, just loop and create them
            if (Array.isArray(structureData)) {
                structureData.forEach(fileName => {
                    const filePath = path.join(currentFolder, fileName);
                    fs.mkdirSync(path.dirname(filePath), { recursive: true });
                    fs.writeFileSync(filePath, '', 'utf8');
                });
                return;
            }

            // Otherwise, track keys and values
            for (const [key, value] of Object.entries(structureData)) {
                const nextPath = path.join(currentFolder, key);

                // If the value is an object with stuff inside, it's a folder we need to dive into
                if (typeof value === 'object' && value !== null && Object.keys(value).length > 0) {
                    fs.mkdirSync(nextPath, { recursive: true });
                    createNodes(nextPath, value); // <--- Dive deeper!
                } 
                // If it's an empty object {} it's an empty folder
                else if (typeof value === 'object' && value !== null && Object.keys(value).length === 0) {
                    fs.mkdirSync(nextPath, { recursive: true });
                } 
                // Otherwise, it's a regular file
                else {
                    fs.mkdirSync(path.dirname(nextPath), { recursive: true });
                    fs.writeFileSync(nextPath, '', 'utf8');
                }
            }
        };

        // KICK OFF THE WORKER: Pass the target folder and the nested structure data
        createNodes(targetDir, parsedYAML.structure);

        // Move this OUTSIDE the loop so it only prints once at the very end!
        console.log("\n✅ Done! Your deep project skeleton is fully built.\n");

    } catch(err) {
        console.log("❌ Error while building the template:", err.message);
    }
}

startSelectionMenu(templates, buildTemplate)
