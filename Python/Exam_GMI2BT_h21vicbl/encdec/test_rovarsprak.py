'''test_rovarsprak.py'''
import unittest
import rovarsprak

class CaseCheck(unittest.TestCase):
    ''' unittest rovarsprak '''
    pairs = [['Test',   'TOTesostot'],
             ['IBM',    'IBOBMOM'],
             ['fooBAR', 'fofooBOBAROR'],
             ['XYZZYX', 'XOXYZOZZOZYXOX'],
             ['emacs',  'emomacocsos'],
             ['5',      '5'],
             ['',       '']]

    tricky = [['Bob',      'BOBobob'],
              ['robot',    'rorobobotot'],
              ['ror',      'rororor'],
              ['kalasfint', 'kokalolasosfofinontot']]

    def test_keep_upper1(self):
        """make sure that 'Test' turns into 'TOTesostot', 'IBM' into 'IBOBMOM' and so on"""
        for [i, o] in self.pairs:
            self.assertEqual(rovarsprak.enc_rov(i), o)

    def test_keep_upper2(self):
        """make sure that 'TOTesostot' turns into 'Test' and so on."""
        for [i, o] in self.pairs:
            self.assertEqual(rovarsprak.dec_rov(o), i)

    def test_tricky1(self):
        """make sure that 'bob' turns into 'bobobob', etc"""
        for [i, o] in self.tricky:
            self.assertEqual(rovarsprak.enc_rov(i), o)

    def test_tricky2(self):
        """make sure that 'rororor' turns into 'ror' and so on."""
        for [i, o] in self.tricky:
            self.assertEqual(rovarsprak.dec_rov(o), i)

if __name__ == "__main__":
    unittest.main(argv=['first-arg-is-ignored'], exit=False)
