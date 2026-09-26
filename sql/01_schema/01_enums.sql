-- 01_enums.sql
-- Contains all static enum definitions for the Church Equipment Database

CREATE TYPE tracking_method_enum AS ENUM (
    'INDIVIDUAL',
    'QUANTITY'
);

CREATE TYPE condition_enum AS ENUM (
    'GOOD',
    'NEEDS_REPAIR',
    'BROKEN',
    'UNKNOWN'
);

CREATE TYPE status_enum AS ENUM (
    'IN_USE',
    'IN_STORAGE',
    'UNDER_MAINTENANCE',
    'LOST',
    'DISPOSED'
);

CREATE TYPE ownership_enum AS ENUM (
    'CHURCH',
    'PERSONAL',
    'BORROWED'
);
