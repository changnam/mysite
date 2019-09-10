import subprocess, re
# run() returns a CompletedProcess object if it was successful
# errors in the created process are raised here too
output = None
def checkHash():
    process = subprocess.run(['git','rev-parse','HEAD'], check=True, stdout=subprocess.PIPE, universal_newlines=True)
    output = process.stdout
    print("xxx")

def branchNameCheck():
    process = subprocess.run(['git','rev-parse','--abbrev-ref','HEAD'], check=True, stdout=subprocess.PIPE, universal_newlines=True)
    localBranch = process.stdout
    valid_branch_regex = "^(feature|bugfix|improvement|library|prerelease|release|hotfix)\/[a-z0-9._-]+$"
    message = "There is something wrong with your branch name. Branch names in this project must adhere to this contract: $valid_branch_regex. Your commit will be rejected. You should rename your branch to a valid name and try again."

    # Check if the branch comply with standard:
    x = re.search(valid_branch_regex, localBranch)

    if (x):
        print("YES! We have a match!")
    else:
        print("No match")
        exit(1)

if __name__ == "__main__":
    print (output)
