import unittest
import os

class DotFileParsingTests(unittest.TestCase):

    def setUp(self):
        bundle_path = os.path.dirname(os.path.abspath(__file__))
        home_path = os.path.join(bundle_path, "DotFiles")
        os.environ["HOME"] = home_path
        print(os.path.expanduser("~"))

    def tearDown(self):
        pass

    def test_example(self):
        print(os.path.expanduser("~"))

if __name__ == '__main__':
    unittest.main()
