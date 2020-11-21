=================
Release-Procedure
=================

This is the maintainer note on how to Release.

Major Release
-------------

This is in accordance to `Semantic Versioning 2.0.0
<https://semver.org/>`_.

The version should be of the form ``X.0.0`` where ``X`` is
the version one more than previous one.

Before the actual release there should be a Release Candidate as in,
with the version ``X.0.0-rc1``, published to PyPi and also a stable
branch ``text2svg-X.0.0`` should be created for the same. Finally,
there should be a Github Pre-Release for the same.

Finally, there should a Github Release with the specified version.

The changelog must be written
