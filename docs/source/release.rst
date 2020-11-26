=================
Release Procedure
=================

This is the maintainer note on how to Release.


All versioning is in accordance to `Semantic Versioning 2.0.0
<https://semver.org/>`_.


Major Release
-------------

The version should be of the form ``X.0.0`` where ``X`` is
the version one more than previous one.

Before the actual release there should be a Release Candidate as in,
with the version ``X.0.0-rc1``, published to PyPi and also a stable
branch ``text2svg-X.0.0`` should be created for the same. Finally,
there should be a Github Pre-Release for the same. A tag must be created
for the sameand the a Github Release must be done.
The changelog must be written according. The ``__version__.py`` must
be modified accordingly.


.. important::

    A note for the version of documentation must be written in
    ``version.json`` in ``docs/source/_static`` folder, so that documentation
    contains all necessary versions.

Minor Release
-------------

The version should be of the form ``<previous-major>.X.0`` where
``X`` is 1 more than previous release.

Before the actual release there should be a Release Candidate as in,
with the version ``<previous-major>.X.0-rc1``, published to PyPi and also
the commit should go into the branch of ``<previous-major>.0.0``.
Finally, there should be a Github Pre-Release for the same. A tag must be created
for the same and the a Github Release must be done.
The changelog must be written according. The ``__version__.py`` must
be modified accordingly.

.. important::

    A note for the version of documentation must be written in
    ``version.json`` in ``docs/source/_static`` folder, so that
    documentation contains all necessary versions. The version
    should be replaced by previous major release.

Patches
-------

The version should be of the form ``<previous-major>.<previous-minor>.X`` where
``X`` is 1 more than previous release.

A release candidate is not required. But it must contain a Github Release
and a Pypi release as in other version. Also the branch ``<previous-major>.0.0``
must be updated with this version.
The changelog must be written accordingly.

.. important::

    A note for the version of documentation must be written in
    ``version.json`` in ``docs/source/_static`` folder, so that
    documentation contains all necessary versions. The version
    should be replaced by previous minor release.
