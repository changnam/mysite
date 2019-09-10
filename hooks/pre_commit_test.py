import subprocess
# run() returns a CompletedProcess object if it was successful
# errors in the created process are raised here too
def checkHash():
    process = subprocess.run(['git','rev-parse','HEAD'], check=True, stdout=subprocess.PIPE, universal_newlines=True)
    output = process.stdout

if __name__ == "__main__":
    print (output)
