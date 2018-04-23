#! /bin/bash
# Hamhandedly crafted by Sean Pepin
# Do what you want with it

# Check for existing fp-lib-table in current directory
if [ -f fp-lib-table ]; then
	echo fp-lib-table detected, delete or rename
	exit
fi

# Create blank library table
touch fp-lib-table
echo fp-lib-table generated

# Create file header
echo "(fp_lib_table" > fp-lib-table

# Iterate through directory
counter = 0 # Tabulates files processed
for i in `ls -d *.pretty`; do
    ((counter+=1))      # Count each file to assist in verifying all were processed (compare with directory file count)
    libname=${i%.*}     # Peel off the filename leader for use as the library name
    echo "Adding $i"    # If you want a different name in the Library Table, process before this point
	echo "  (lib (name $libname)(type KiCad)(uri \${KISYSMOD}/$i)(options \"\")(descr \"\"))" >> fp-lib-table
done

# Create file footer
echo ")" >> fp-lib-table
echo $counter files added

# Done
