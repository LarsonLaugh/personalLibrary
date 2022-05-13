import os
import sys


path = os.path.join(os.getcwd(),'Library') # rename the 'Library' folder to whatever you like
if len(sys.argv)>1:
    path = sys.argv # overwrite library path by the first command line argument (optional)
get_all = os.walk(path)
dirs = [d for d in get_all]

def rm_dotgit(list_of_folder_name): 
	return [name for name in list_of_folder_name if name != '.git']

def get_pdf(list_of_file_name):
	return [name for name in list_of_file_name if name.endswith('.pdf')]

subdirs = rm_dotgit(dirs[0][1])  # don't search in the .git directory
lines = []
with open(os.path.join(os.getcwd(),'README.md'),'r',encoding='utf-8') as f: # store all existing lines for later use
	line = f.readline()
	lines.append(line)
	while line != '### The tree of library (automatically updated)\n':
		line = f.readline()
		lines.append(line)
		
with open(os.path.join(os.getcwd(),'README.md'),'w',encoding='utf-8') as f: # write all existing lines and update the library tree. 
	for line in lines[:-1]: 
		f.write(line)
	f.write('### The tree of library (automatically updated)\n')
	f.write('```\n')
	f.write('Library\n')
	[f.write('|'+'\n'+'|----'+p+'\n') for p in subdirs]
	f.write('```')
