import unittest

def suite():
    loader = unittest.TestLoader()
    suite = unittest.TestSuite()

    # Add all test files in the tests/ally_macOS_tests directory
    suite.addTests(loader.discover('tests/ally_macOS_tests'))

    return suite

if __name__ == '__main__':
    runner = unittest.TextTestRunner()
    runner.run(suite())
