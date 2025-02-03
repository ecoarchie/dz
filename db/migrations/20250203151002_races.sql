-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS races (
 id UUID PRIMARY KEY,
 name TEXT NOT NULL UNIQUE,
 race_date DATE NOT NULL,
 timezone TEXT NOT NULL
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS races;
-- +goose StatementEnd
