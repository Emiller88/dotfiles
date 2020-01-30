# modules/dev/python.nix --- https://www.python.org/

{ lib, pkgs, ... }: {

  imports = [ ./. ];
  my = {
    packages = with pkgs; [
      conda
      python37
      python37Packages.black
      python37Packages.flake8
      python37Packages.ipython
      python37Packages.mypy
      python37Packages.pip
      # python37Packages.poetry
      python37Packages.pylint
      python37Packages.setuptools
    ];

    env.IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
    env.PIP_CONFIG_FILE = "$XDG_CONFIG_HOME/pip/pip.conf";
    env.PIP_LOG_FILE = "$XDG_DATA_HOME/pip/log";
    env.PYLINTHOME = "$XDG_DATA_HOME/pylint";
    env.PYLINTRC = "$XDG_CONFIG_HOME/pylint/pylintrc";
    env.PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc";
    env.PYTHON_EGG_CACHE = "$XDG_CACHE_HOME/python-eggs";
    env.JUPYTER_CONFIG_DIR = "$XDG_CONFIG_HOME/jupyter";

    alias.py = "python";
    alias.py2 = "python2";
    alias.py3 = "python3";
    alias.po = "poetry";
    alias.ipy = "ipython --no-banner";
    alias.ipylab = "ipython --pylab=qt5 --no-banner";
  };
}
