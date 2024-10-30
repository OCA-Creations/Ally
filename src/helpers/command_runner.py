import subprocess

def safe_shell(command: str) -> str:
    """
    Execute a shell command safely and return its output.

    Args:
        command (str): The shell command to execute.

    Returns:
        str: The output of the shell command.
    """
    result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if result.returncode != 0:
        raise Exception(f"Command failed with error: {result.stderr}")
    return result.stdout
