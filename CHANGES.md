## v0.2.0

* **Feature** Prefix matching via the new `CaseInsensitive#prefix` method.
* PostgreSQL CI index now uses the `text_pattern_ops` [opclass] by default (for prefix matching).
* Renamed `CaseInsensitiveEq` to `CaseInsensitive`, and `#find` to `#in`.
* Renamed `FullTextSearch` to `FullText`, and `#find` to `#search`.

[opclass]: http://www.postgresql.org/docs/9.5/static/indexes-opclass.html

## v0.1.2

Tightened the API. Improved documentation.

## v0.1.1

Initial release.
