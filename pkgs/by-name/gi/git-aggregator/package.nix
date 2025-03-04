{
  lib,
  python3Packages,
  fetchPypi,
  git,
}:

python3Packages.buildPythonApplication rec {
  pname = "git-aggregator";
  version = "2.1.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-79xNPzYP1j71sU5wZM5e2xTqQExqQEdxXPxbk4T/Scw=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python3Packages; [
    argcomplete
    colorama
    git
    kaptan
    requests
  ];

  nativeCheckInputs = [
    git
  ];

  preCheck = ''
    export HOME="$(mktemp -d)"
    git config --global user.name John
    git config --global user.email john@localhost
    git config --global init.defaultBranch master
    git config --global pull.rebase false
  '';

  meta = with lib; {
    description = "Manage the aggregation of git branches from different remotes to build a consolidated one";
    homepage = "https://github.com/acsone/git-aggregator";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ bbjubjub ];
    mainProgram = "gitaggregate";
  };
}
