import os

print ("hoook creatating....")

absPath = os.path.abspath(os.path.dirname(__file__))

sourceFile = absPath + "/hooks/commit-msg"
targetFile = absPath + "/.git/hooks/commit-msg"
try:
    os.symlink(sourceFile,targetFile)
    print(f'hook {targetFile} created.')
except FileExistsError:
    print(f'hook {targetFile} already exists.')

sourceFile = absPath + "/hooks/pre-commit"
targetFile = absPath + "/.git/hooks/pre-commit"
try:
    os.symlink(sourceFile,targetFile)
    print(f'hook {targetFile} created.')
except FileExistsError:
    print(f'hook {targetFile} already exists.')

print ("hoook creatation completed.")
