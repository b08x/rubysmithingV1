---
id: "card-parameterize-pgvector-sql-queries-in-retriever-todo001"
boardId: "default"
title: "Parameterize pgvector SQL queries in Retriever"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: null
column: "todo"
rank: "U"
labels: ["Security", "High"]
assignee: null
fieldValues: {}
createdAt: "2026-05-13T09:02:03.000Z"
updatedAt: "2026-05-13T09:02:03.000Z"
createdBy: "person_01KRBHC33EM63ZHFQSRMAE864Z"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
Refactor Retriever#search to use Sequel's parameterized binding arrays for pgvector distance operators instead of string interpolation in Sequel.lit. This mitigates SQL injection and execution panic risks.
