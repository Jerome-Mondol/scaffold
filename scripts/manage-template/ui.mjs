import inquirer from "inquirer";

export const startSelectionMenu = async (items, onSelectCallback) => {
    const answers = await inquirer.prompt([
        {
            type: 'select',
            name: 'selectedTemplate',
            message: 'Select a backend architecture tempalte configuration',
            choices: items.map((file) => ({
                name: file.split('.')[0],
                value: file
            }))
        }
    ])



    onSelectCallback(answers.selectedTemplate)
}