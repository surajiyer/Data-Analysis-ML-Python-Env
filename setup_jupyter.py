import yaml
import subprocess


with open('/tmp/jupyterlab_configuration.yml') as stream:
    config = yaml.safe_load(stream)

# check if node.js is installed
retcode = subprocess.call(['node', '-v'])
assert retcode == 0, 'Node.js is not installed.'

# check if jupyter is installed
retcode = subprocess.call(['jupyter', '--version'])
assert retcode == 0, 'Jupyter is not installed.'

# Install pip packages
for package in config['pip_packages']:
    retcode = subprocess.call(['pip', 'install', '-U', package])
    assert retcode == 0, f"Failed to install python package: {package}."

# Install lab extensions
for package in config['labextension']:
    retcode = subprocess.call(['jupyter', 'labextension', 'install', package])
    assert retcode == 0, f"Failed to install lab extension: {package}."

# Run any additional commands to setup jupyter correctly
for cmds in config['additional_cmds']:
    retcode = subprocess.call(cmds.split(' '))
    assert retcode == 0, f"Failed to run '{cmds}'."
