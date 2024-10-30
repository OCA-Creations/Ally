import unittest
import tempfile
import os

class TempFileTests(unittest.TestCase):

    def setUp(self):
        self.temp_file = tempfile.NamedTemporaryFile(delete=False)
        self.temp_file.close()
        self.original_zshrc = os.path.expanduser("~/.zshrc")
        self.temp_zshrc = self.temp_file.name

    def tearDown(self):
        os.remove(self.temp_zshrc)

    def test_add_alias(self):
        alias_command = f"ally add test_alias 'echo Hello, World!' --no-output --location {self.temp_zshrc}"
        os.system(alias_command)
        with open(self.temp_zshrc, 'r') as file:
            content = file.read()
        self.assertIn("alias test_alias='echo Hello, World!'", content)

    def test_remove_alias(self):
        with open(self.temp_zshrc, 'w') as file:
            file.write("alias test_alias='echo Hello, World!'\n")
        remove_command = f"ally remove test_alias --no-output --location {self.temp_zshrc}"
        os.system(remove_command)
        with open(self.temp_zshrc, 'r') as file:
            content = file.read()
        self.assertNotIn("alias test_alias='echo Hello, World!'", content)

if __name__ == '__main__':
    unittest.main()
