import fs from 'fs'
import path from 'path'

const targetDir = process.argv[2];

if(!targetDir) {
    console.error("❌ Error: No target directory provided.");
    process.exit(1);
}

const packageJsonPath = path.join(targetDir, 'package.json')


try {
    const pkgText = fs.readFileSync(packageJsonPath, 'utf8');
    const pkg = JSON.parse(pkgText);

    pkg.type = "module";
    pkg.scripts = {
        "start": "node src/index.js",
        "dev": "nodemon src/index.js"
    }

    fs.writeFileSync(packageJsonPath, JSON.stringify(pkg, null, 2), 'utf8');
    console.log(`⚙️  package.json locked to ES Module ("type": "module")`);
} catch(err) {
    console.log("❌ Failed to modify package.json:", err.message);
    process.exit(1);
}