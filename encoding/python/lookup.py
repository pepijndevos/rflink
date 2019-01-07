import re

def runs(x):
    binary = "{0:010b}".format(x)
    runs = re.findall("(0+|1+)", binary)
    lengths = [len(b) for b in runs]
    lengths[0] *= 2
    lengths[-1] *= 2
    return max(lengths), -len(runs)
    #return len(runs)

symbols = list(range(2**10))
symbols.remove(785)
#values = sorted(range(2**10), key=runs)[:256]
#inputs = sorted(range(-128,127), key=abs)
values = sorted(symbols, key=runs, reverse=True)[-256:]
inputs = sorted(range(-128,128), key=abs, reverse=True)
lookup = dict(zip(inputs, values))

def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    if (val<0):
        val = 2**bits - abs(val)       # compute negative value
    return val

for inp, outp in lookup.items():
    inp = twos_comp(inp, 8)
    print("when \"{0:08b}\" => data_out_tmp <= \"{1:010b}\";".format(inp, outp))

print("\n")

for inp, outp in lookup.items():
    inp = twos_comp(inp, 8)
    print("when \"{0:010b}\" => data_out_tmp <= \"{1:08b}\";".format(outp, inp))

