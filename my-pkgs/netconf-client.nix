{ buildPythonPackage, fetchFromGitHub, pythonOlder, poetry-core
, paramiko, lxml
}:

buildPythonPackage rec {
  pname = "netconf-client";
  version = "3.0.0";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ADTRAN";
    repo = "netconf_client";
    rev = "v${version}";
    sha256 = "sha256-qryvc18RKYoRYYaIOO4cjaMz4JWcvxAa0/Zswfp5XJs=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    paramiko
    lxml
  ];
}
