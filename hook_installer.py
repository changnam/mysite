import os

print ("hoook creatating....")

absPath = os.path.abspath(os.path.dirname(__file__))

sourceFile = absPath + "/hooks/commit-msg"
targetFile = absPath + "/.git/hooks/commit-msg"
os.symlink(sourceFile,targetFile)

sourceFile = absPath + "/hooks/pre-commit"
targetFile = absPath + "/.git/hooks/pre-commit"
os.symlink(sourceFile,targetFile)

print ("hoook creatation completed.")