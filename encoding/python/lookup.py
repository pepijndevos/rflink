import re

def runs(x):
    binary = "{0:010b}".format(x)
    runs = re.findall("(0+|1+)", binary)
    #return max(len(b) for b in runs)
    return len(runs)

#values = sorted(range(2**10), key=runs)[:256]
#inputs = sorted(range(-128,127), key=abs) 
values = sorted(range(2**10), key=runs)[-256:]
inputs = sorted(range(-128,128), key=abs, reverse=True)
lookup = dict(zip(inputs, values))

def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    if (val<0):
        val = 2**bits - abs(val)       # compute negative value
    return val    

#for inp, outp in lookup.items():
#    inp = twos_comp(inp, 8)
#    print("when \"{0:08b}\" => data_out_tmp <= \"{1:010b}\";".format(inp, outp))

print("\n")

#values = sorted(range(2**10), key=runs)[-257:]
#inputs = sorted(range(-128,127), key=abs, reverse=True)
#lookup = dict(zip(inputs, values))

#for inp, outp in lookup.items():
#    inp = twos_comp(inp, 8)
#    print("when \"{0:08b}\" => data_out_tmp <= \"{1:010b}\";".format(inp, outp))


for inp, outp in lookup.items():
    inp = twos_comp(inp, 8)
    print("when \"{0:010b}\" => data_out_tmp <= \"{1:08b}\";".format(outp, inp))

#print("\n")

#for inp, outp in lookup.items():
#    inp = twos_comp(inp, 8)
#    print("{}".format(outp))

