# PostgreSQL Setup for Rubysmithing

## System Requirements
The Rubysmithing discovery and blueprint system requires **PostgreSQL 16+** with the following extensions:
*   `vector` (via `pgvector`)
*   `pgcrypto` (for `gen_random_uuid`)
*   `pg_trgm` (for fuzzy search)

## Host Configuration (Fedora/DNF)
When setting up on Fedora or similar RHEL-based systems, ensure the `-contrib` package matches your major version:

```bash
# Install Postgres and required system extensions
sudo dnf install postgresql16-server postgresql16-contrib postgresql16-pgvector

# Initialize and start service
sudo /usr/bin/postgresql-setup --initdb
sudo systemctl enable --now postgresql
```

## Common Error Patterns
### 1. Missing `.control` files
**Error**: `ERROR: extension "pgcrypto" is not available. DETAIL: Could not open extension control file "/usr/share/pgsql/extension/pgcrypto.control": No such file or directory.`
**Cause**: The PostgreSQL `-contrib` package is not installed for your specific version.
**Fix**: `dnf install postgresql<version>-contrib`.

### 2. Operator Class for HNSW
**Error**: `data type vector has no default operator class for access method "hnsw"`
**Cause**: Missing `vector_cosine_ops` specification in the index definition.
**Fix**: Ensure your migration uses `index :embedding, type: "hnsw", op_class: "vector_cosine_ops"`.

## Troubleshooting Protocol for Agents
Before performing database operations, always survey the host:
1. Check OS: `cat /etc/os-release`
2. Check Installed Packages: `dnf list installed | grep postgres`
3. Verify Extensions: `ls /usr/share/pgsql/extension/*.control`
