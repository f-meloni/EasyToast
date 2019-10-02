import Danger 
let danger = Danger()

if danger.git.createdFiles.count + danger.git.modifiedFiles.count - danger.git.deletedFiles.count > 300 {
    warn("Big PR, try to keep changes smaller if you can")
}

danger.git.modifiedFiles.forEach { fail(message: "TEST", file: $0, line: 8) }
