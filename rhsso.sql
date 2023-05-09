--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.5 (Debian 14.5-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO eai;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO eai;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO eai;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO eai;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO eai;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO eai;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO eai;

--
-- Name: client; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO eai;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO eai;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO eai;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO eai;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO eai;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO eai;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO eai;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO eai;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO eai;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO eai;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO eai;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO eai;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO eai;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO eai;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO eai;

--
-- Name: component; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO eai;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO eai;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO eai;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO eai;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO eai;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO eai;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO eai;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO eai;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO eai;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO eai;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO eai;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO eai;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO eai;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO eai;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO eai;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO eai;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO eai;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO eai;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO eai;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO eai;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO eai;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO eai;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO eai;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO eai;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO eai;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO eai;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO eai;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO eai;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO eai;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO eai;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO eai;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO eai;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO eai;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO eai;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO eai;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO eai;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO eai;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO eai;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO eai;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO eai;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO eai;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO eai;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO eai;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO eai;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO eai;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO eai;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO eai;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO eai;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO eai;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO eai;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO eai;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO eai;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO eai;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO eai;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO eai;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO eai;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO eai;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO eai;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO eai;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO eai;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO eai;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO eai;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO eai;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO eai;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO eai;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO eai;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO eai;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO eai;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO eai;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: eai
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO eai;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
a7c7ae8e-db70-446b-944d-3c9bc17e6f13	\N	auth-cookie	b99b93ee-5ff5-4ecb-8266-0936b60d8371	879c6cd2-589b-460b-addb-d5d79a193207	2	10	f	\N	\N
853252bc-6760-4eae-adce-a95644dcd838	\N	auth-spnego	b99b93ee-5ff5-4ecb-8266-0936b60d8371	879c6cd2-589b-460b-addb-d5d79a193207	3	20	f	\N	\N
c72af43f-0e15-426c-808f-a9e27b901f91	\N	identity-provider-redirector	b99b93ee-5ff5-4ecb-8266-0936b60d8371	879c6cd2-589b-460b-addb-d5d79a193207	2	25	f	\N	\N
6a6776b8-bd71-4b48-a63d-6d715e7cce31	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	879c6cd2-589b-460b-addb-d5d79a193207	2	30	t	eacd6fdb-a3bf-4fba-91a8-3b63e812963c	\N
dd2790ab-a9cf-49a0-93d8-bec9188360c9	\N	auth-username-password-form	b99b93ee-5ff5-4ecb-8266-0936b60d8371	eacd6fdb-a3bf-4fba-91a8-3b63e812963c	0	10	f	\N	\N
1f8dbf8d-3164-45bc-9c53-eea518b7558e	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	eacd6fdb-a3bf-4fba-91a8-3b63e812963c	1	20	t	bd1d042e-5f89-4d0f-9daf-c28d9f8bde31	\N
a23e84e3-9a5a-4f12-ace7-23d50743bae7	\N	conditional-user-configured	b99b93ee-5ff5-4ecb-8266-0936b60d8371	bd1d042e-5f89-4d0f-9daf-c28d9f8bde31	0	10	f	\N	\N
1c93bb9d-614d-4af8-8386-fa797da446c0	\N	auth-otp-form	b99b93ee-5ff5-4ecb-8266-0936b60d8371	bd1d042e-5f89-4d0f-9daf-c28d9f8bde31	0	20	f	\N	\N
07f1d303-0772-43e5-86ec-ed46fe4dde12	\N	direct-grant-validate-username	b99b93ee-5ff5-4ecb-8266-0936b60d8371	d13a72ef-07f2-4cf6-aa5f-df19b5b5d578	0	10	f	\N	\N
4d85d74d-30c8-4f9f-9850-6286af66dbd3	\N	direct-grant-validate-password	b99b93ee-5ff5-4ecb-8266-0936b60d8371	d13a72ef-07f2-4cf6-aa5f-df19b5b5d578	0	20	f	\N	\N
0238fc95-508e-49d3-95a1-d49adaf71598	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	d13a72ef-07f2-4cf6-aa5f-df19b5b5d578	1	30	t	87d2c62b-fbfb-4139-892d-d4df1c339528	\N
23af794c-6152-4c65-87e9-636072cb4f0d	\N	conditional-user-configured	b99b93ee-5ff5-4ecb-8266-0936b60d8371	87d2c62b-fbfb-4139-892d-d4df1c339528	0	10	f	\N	\N
1e426f8c-118b-4924-b20a-df6d18a005ff	\N	direct-grant-validate-otp	b99b93ee-5ff5-4ecb-8266-0936b60d8371	87d2c62b-fbfb-4139-892d-d4df1c339528	0	20	f	\N	\N
b0e15bef-459c-4eb7-8e1e-cb23b6d5a5e5	\N	registration-page-form	b99b93ee-5ff5-4ecb-8266-0936b60d8371	43669a4c-0af1-4388-a632-3f07ddb35a51	0	10	t	a468f164-238c-43dc-8c81-ef4cc44f976d	\N
de6dcd9f-78ec-4bdb-8fbd-406bf184a45c	\N	registration-user-creation	b99b93ee-5ff5-4ecb-8266-0936b60d8371	a468f164-238c-43dc-8c81-ef4cc44f976d	0	20	f	\N	\N
517a4376-4cc3-4ec2-85ed-ee2a1c5021ea	\N	registration-profile-action	b99b93ee-5ff5-4ecb-8266-0936b60d8371	a468f164-238c-43dc-8c81-ef4cc44f976d	0	40	f	\N	\N
9d1a11ff-c560-4d17-ae37-390cec477624	\N	registration-password-action	b99b93ee-5ff5-4ecb-8266-0936b60d8371	a468f164-238c-43dc-8c81-ef4cc44f976d	0	50	f	\N	\N
a6c3ec4c-f159-4878-8bf2-e89f89d199a0	\N	registration-recaptcha-action	b99b93ee-5ff5-4ecb-8266-0936b60d8371	a468f164-238c-43dc-8c81-ef4cc44f976d	3	60	f	\N	\N
efdbe3c6-46b1-4566-941f-040f3c92647f	\N	reset-credentials-choose-user	b99b93ee-5ff5-4ecb-8266-0936b60d8371	b6f0fbbc-3302-4d1c-89d3-488c32fab202	0	10	f	\N	\N
2cbca4b8-2cb0-4d8a-b435-4b1f68e37ec7	\N	reset-credential-email	b99b93ee-5ff5-4ecb-8266-0936b60d8371	b6f0fbbc-3302-4d1c-89d3-488c32fab202	0	20	f	\N	\N
bf7570a4-0da0-4ee6-bb94-7f3681174244	\N	reset-password	b99b93ee-5ff5-4ecb-8266-0936b60d8371	b6f0fbbc-3302-4d1c-89d3-488c32fab202	0	30	f	\N	\N
715918fe-f47f-42cc-8edb-3480e6ca324b	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	b6f0fbbc-3302-4d1c-89d3-488c32fab202	1	40	t	04391ae9-c385-47d4-a010-9cf916669a36	\N
e24cc794-0abc-4dab-954d-38db5700cfd2	\N	conditional-user-configured	b99b93ee-5ff5-4ecb-8266-0936b60d8371	04391ae9-c385-47d4-a010-9cf916669a36	0	10	f	\N	\N
dfcd83c9-99de-47f2-8f7f-077dc482ddec	\N	reset-otp	b99b93ee-5ff5-4ecb-8266-0936b60d8371	04391ae9-c385-47d4-a010-9cf916669a36	0	20	f	\N	\N
f3d9be93-289b-4587-959a-e7995758a612	\N	client-secret	b99b93ee-5ff5-4ecb-8266-0936b60d8371	22546526-0e08-464a-b578-55f22aca56a8	2	10	f	\N	\N
1008a159-a31a-429c-a306-d46d4d3791c3	\N	client-jwt	b99b93ee-5ff5-4ecb-8266-0936b60d8371	22546526-0e08-464a-b578-55f22aca56a8	2	20	f	\N	\N
7028278e-ee05-45a5-b833-39c7152f7c72	\N	client-secret-jwt	b99b93ee-5ff5-4ecb-8266-0936b60d8371	22546526-0e08-464a-b578-55f22aca56a8	2	30	f	\N	\N
11d26cbd-6f0a-4cbb-ab5a-a067f9fc47b2	\N	client-x509	b99b93ee-5ff5-4ecb-8266-0936b60d8371	22546526-0e08-464a-b578-55f22aca56a8	2	40	f	\N	\N
8ce69da6-25e3-4632-8108-abbcb6db2e17	\N	idp-review-profile	b99b93ee-5ff5-4ecb-8266-0936b60d8371	e21961d9-c39c-4bdf-b00f-95808e5fd9e2	0	10	f	\N	10f0d778-d768-4d48-be43-e2532d5cd0a2
25c3a737-e443-4743-ba81-fb01b112c1f6	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	e21961d9-c39c-4bdf-b00f-95808e5fd9e2	0	20	t	8131dc48-38c9-4512-a96a-ed1eff105fd5	\N
bfe6d0c8-6e76-467c-b5c0-38fea834b02a	\N	idp-create-user-if-unique	b99b93ee-5ff5-4ecb-8266-0936b60d8371	8131dc48-38c9-4512-a96a-ed1eff105fd5	2	10	f	\N	54e12a8b-e15b-4c01-b885-9b9e13bfb4e0
500ab8bb-b497-4d71-97f1-12179dc9616f	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	8131dc48-38c9-4512-a96a-ed1eff105fd5	2	20	t	4476afbd-efc6-4e25-a530-ae8af320cc0f	\N
d7bcb6b4-f318-44fc-9356-59272562a5b2	\N	idp-confirm-link	b99b93ee-5ff5-4ecb-8266-0936b60d8371	4476afbd-efc6-4e25-a530-ae8af320cc0f	0	10	f	\N	\N
11b3666b-8790-4710-9d02-c66aab7a4b2e	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	4476afbd-efc6-4e25-a530-ae8af320cc0f	0	20	t	73fdcde9-13d3-482e-99d5-c97b076e4ab5	\N
5b28c29a-031f-4d66-9f85-1c67c1903c67	\N	idp-email-verification	b99b93ee-5ff5-4ecb-8266-0936b60d8371	73fdcde9-13d3-482e-99d5-c97b076e4ab5	2	10	f	\N	\N
c904f241-3192-4788-84fa-0131dd9a0f3a	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	73fdcde9-13d3-482e-99d5-c97b076e4ab5	2	20	t	b5471ddb-3bae-449f-8ea8-843c2f142da0	\N
15ca0638-fa68-4c36-8fb2-ce53fd5d62ce	\N	idp-username-password-form	b99b93ee-5ff5-4ecb-8266-0936b60d8371	b5471ddb-3bae-449f-8ea8-843c2f142da0	0	10	f	\N	\N
91e0f51a-536c-4ffe-bbfc-59e1144d585f	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	b5471ddb-3bae-449f-8ea8-843c2f142da0	1	20	t	767d04a5-c213-4eea-b1cf-44acbd50ba5b	\N
8689a820-140f-43d8-ae4b-b10d8a99d570	\N	conditional-user-configured	b99b93ee-5ff5-4ecb-8266-0936b60d8371	767d04a5-c213-4eea-b1cf-44acbd50ba5b	0	10	f	\N	\N
8cfbe053-4c94-416b-8544-aabcc7ac022c	\N	auth-otp-form	b99b93ee-5ff5-4ecb-8266-0936b60d8371	767d04a5-c213-4eea-b1cf-44acbd50ba5b	0	20	f	\N	\N
2f91d3f5-58ee-481a-87cf-517799a43626	\N	http-basic-authenticator	b99b93ee-5ff5-4ecb-8266-0936b60d8371	815c4e22-1188-41d3-80d5-a9676990b963	0	10	f	\N	\N
f9adeaac-b5f8-4f13-86f7-ef7a6e7a98cf	\N	docker-http-basic-authenticator	b99b93ee-5ff5-4ecb-8266-0936b60d8371	611219ef-5fb3-4f38-a35c-193c1aae4323	0	10	f	\N	\N
082b7ab7-6b18-436a-8c6e-1dfcd5651f84	\N	no-cookie-redirect	b99b93ee-5ff5-4ecb-8266-0936b60d8371	553654dc-fea7-4398-b962-a766ae899039	0	10	f	\N	\N
425d187f-77ad-4a61-b6f3-d525a24efe84	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	553654dc-fea7-4398-b962-a766ae899039	0	20	t	67722ea6-c1a0-4bb2-829f-2c4c086cf622	\N
7f022b70-d214-4df4-9654-28673dcaf4e8	\N	basic-auth	b99b93ee-5ff5-4ecb-8266-0936b60d8371	67722ea6-c1a0-4bb2-829f-2c4c086cf622	0	10	f	\N	\N
f743d5ab-0e81-4fdf-8d9f-4371c525613d	\N	basic-auth-otp	b99b93ee-5ff5-4ecb-8266-0936b60d8371	67722ea6-c1a0-4bb2-829f-2c4c086cf622	3	20	f	\N	\N
54853bcd-4f7f-4996-917f-963fd836860e	\N	auth-spnego	b99b93ee-5ff5-4ecb-8266-0936b60d8371	67722ea6-c1a0-4bb2-829f-2c4c086cf622	3	30	f	\N	\N
6f53852e-964f-44e5-8238-a45c565fd9d5	\N	auth-cookie	eai-poc	fef3889a-609e-463a-beb8-96381e6db2bc	2	10	f	\N	\N
3b9dff2a-7ebe-4402-91aa-aee32c850407	\N	auth-spnego	eai-poc	fef3889a-609e-463a-beb8-96381e6db2bc	3	20	f	\N	\N
7cb31d99-95f0-4b8f-929b-5b9426074cca	\N	identity-provider-redirector	eai-poc	fef3889a-609e-463a-beb8-96381e6db2bc	2	25	f	\N	\N
4289b889-46cb-46ef-8618-a9175fd53b63	\N	\N	eai-poc	fef3889a-609e-463a-beb8-96381e6db2bc	2	30	t	c5c884e8-ec79-4989-884a-6a8dfe4d38c4	\N
cf6aac14-8fd6-4258-8055-171b1a66765c	\N	auth-username-password-form	eai-poc	c5c884e8-ec79-4989-884a-6a8dfe4d38c4	0	10	f	\N	\N
2ca901bc-8026-4d74-aaf8-0eb8341667cb	\N	\N	eai-poc	c5c884e8-ec79-4989-884a-6a8dfe4d38c4	1	20	t	9cd00dcb-9400-49d8-a3e9-26a620102f0d	\N
4162364a-273c-49b0-a7cc-b2cd352cca44	\N	conditional-user-configured	eai-poc	9cd00dcb-9400-49d8-a3e9-26a620102f0d	0	10	f	\N	\N
f48b5852-c0e2-450a-ab56-8b8125a13a7b	\N	auth-otp-form	eai-poc	9cd00dcb-9400-49d8-a3e9-26a620102f0d	0	20	f	\N	\N
fb94bf9b-4bab-42a8-a60f-7094004d9923	\N	direct-grant-validate-username	eai-poc	e4391b1c-071c-4991-b4b7-76257dd2b742	0	10	f	\N	\N
441afc1b-9d17-4923-bebe-f91594c1724b	\N	direct-grant-validate-password	eai-poc	e4391b1c-071c-4991-b4b7-76257dd2b742	0	20	f	\N	\N
bac5e00d-68a7-40ef-a7ac-eb5bd4800f3a	\N	\N	eai-poc	e4391b1c-071c-4991-b4b7-76257dd2b742	1	30	t	9e51503e-2b63-417d-866e-5e52fa39a332	\N
1e27ebc7-f6cf-45d4-8c29-4eaeb51c4aa5	\N	conditional-user-configured	eai-poc	9e51503e-2b63-417d-866e-5e52fa39a332	0	10	f	\N	\N
502a115d-a8cb-49e6-b6b2-1c7137e57984	\N	direct-grant-validate-otp	eai-poc	9e51503e-2b63-417d-866e-5e52fa39a332	0	20	f	\N	\N
60aa550f-c37f-4ec1-8194-8812d592c049	\N	registration-page-form	eai-poc	d8a5dcec-4b4e-4a08-a045-8606ae339e19	0	10	t	4db5857c-d108-4973-9f1a-882027cd912e	\N
f36b3892-8622-4f37-8a9a-f6b4b908f0b1	\N	registration-user-creation	eai-poc	4db5857c-d108-4973-9f1a-882027cd912e	0	20	f	\N	\N
cdbdcae2-c656-42fd-ab3c-b6b2126e8a89	\N	registration-profile-action	eai-poc	4db5857c-d108-4973-9f1a-882027cd912e	0	40	f	\N	\N
4169ff92-34db-4a47-828c-7733582dc5c9	\N	registration-password-action	eai-poc	4db5857c-d108-4973-9f1a-882027cd912e	0	50	f	\N	\N
829ac9b8-2996-43e8-8658-1a96f258243e	\N	registration-recaptcha-action	eai-poc	4db5857c-d108-4973-9f1a-882027cd912e	3	60	f	\N	\N
f8824aed-7468-4ea6-ac6c-a913db6864ba	\N	reset-credentials-choose-user	eai-poc	40320e15-ea48-4f97-bd9d-358027b12ed0	0	10	f	\N	\N
bc34cd31-7d03-4a84-975f-d87313868a3b	\N	reset-credential-email	eai-poc	40320e15-ea48-4f97-bd9d-358027b12ed0	0	20	f	\N	\N
5f1c71ad-4690-40ce-9712-551e0780c3a1	\N	reset-password	eai-poc	40320e15-ea48-4f97-bd9d-358027b12ed0	0	30	f	\N	\N
53bd81b6-86cf-4abb-af1c-a41ed8d10abf	\N	\N	eai-poc	40320e15-ea48-4f97-bd9d-358027b12ed0	1	40	t	e61a5d91-f200-4cf7-af81-b77fd64fb9f2	\N
22e80b11-5db6-48ff-ae3f-f46f650ce5e4	\N	conditional-user-configured	eai-poc	e61a5d91-f200-4cf7-af81-b77fd64fb9f2	0	10	f	\N	\N
8dd52d70-9bae-4238-9b62-51f0e9022f25	\N	reset-otp	eai-poc	e61a5d91-f200-4cf7-af81-b77fd64fb9f2	0	20	f	\N	\N
d56593f8-365d-470f-be78-1883748103df	\N	client-secret	eai-poc	ac40e50f-8429-45ee-935d-f33e00070b3b	2	10	f	\N	\N
99644152-7a8e-452c-ba73-fd6968321eab	\N	client-jwt	eai-poc	ac40e50f-8429-45ee-935d-f33e00070b3b	2	20	f	\N	\N
58765430-1494-4009-a4b1-7757b770add4	\N	client-secret-jwt	eai-poc	ac40e50f-8429-45ee-935d-f33e00070b3b	2	30	f	\N	\N
f783a261-0003-4b7d-91a5-041f04f2e130	\N	client-x509	eai-poc	ac40e50f-8429-45ee-935d-f33e00070b3b	2	40	f	\N	\N
c28ea4df-a8d1-44e4-bd19-b3810809d089	\N	idp-review-profile	eai-poc	01f7938d-239c-4530-b965-b999a46f6ee7	0	10	f	\N	a60b1529-4020-4749-974d-df973dab4df4
b3990a94-9b23-4702-94bd-02e1311d394b	\N	\N	eai-poc	01f7938d-239c-4530-b965-b999a46f6ee7	0	20	t	4dc6d903-9b86-43c4-8266-f9fb66ba7134	\N
7a576a2e-86f8-4a8b-b498-141e3c01e4d4	\N	idp-create-user-if-unique	eai-poc	4dc6d903-9b86-43c4-8266-f9fb66ba7134	2	10	f	\N	65726776-a60f-45cb-8508-f25ffc1c43c9
046f274e-ab3e-4270-b070-a0906215aedf	\N	\N	eai-poc	4dc6d903-9b86-43c4-8266-f9fb66ba7134	2	20	t	01ec863c-45ad-4f7f-8a95-cafbc511bded	\N
6c53ee4e-231e-4a5e-8b3c-5760aac3b375	\N	idp-confirm-link	eai-poc	01ec863c-45ad-4f7f-8a95-cafbc511bded	0	10	f	\N	\N
ad3bc0a2-17ef-471d-9718-4dea4bff7042	\N	\N	eai-poc	01ec863c-45ad-4f7f-8a95-cafbc511bded	0	20	t	64522d15-da8b-4842-9d6f-353eb8c80ca0	\N
ddb81c2a-2fee-4276-9dd2-1698674f6b76	\N	idp-email-verification	eai-poc	64522d15-da8b-4842-9d6f-353eb8c80ca0	2	10	f	\N	\N
bacc53dc-321d-4d0a-86ca-b3c0502ca58c	\N	\N	eai-poc	64522d15-da8b-4842-9d6f-353eb8c80ca0	2	20	t	28ee863f-14f2-4db3-8aee-524a4e983425	\N
777aebb4-be53-40fd-a4cf-093af9dd54d2	\N	idp-username-password-form	eai-poc	28ee863f-14f2-4db3-8aee-524a4e983425	0	10	f	\N	\N
c8af9c86-19ab-48b3-9a8b-48fab1d097e0	\N	\N	eai-poc	28ee863f-14f2-4db3-8aee-524a4e983425	1	20	t	571a4ccd-4dab-4cfb-8af5-3cc291b6aa9b	\N
59b73b1e-9441-4d4c-b98f-f50a7fde4b2e	\N	conditional-user-configured	eai-poc	571a4ccd-4dab-4cfb-8af5-3cc291b6aa9b	0	10	f	\N	\N
b2300cce-652e-4984-a0af-cbe9c6de05ee	\N	auth-otp-form	eai-poc	571a4ccd-4dab-4cfb-8af5-3cc291b6aa9b	0	20	f	\N	\N
f7448b62-0d6e-4907-815f-1031866a4acc	\N	http-basic-authenticator	eai-poc	2b5fde73-9970-44d0-a4b3-28f0a2957dec	0	10	f	\N	\N
2bf5d7b7-bf25-4962-a112-d81e0d8c1534	\N	docker-http-basic-authenticator	eai-poc	12c88221-e445-4969-a6e7-37b39f30f0b3	0	10	f	\N	\N
31ca47d1-d981-4277-8a4f-6b567e88509b	\N	no-cookie-redirect	eai-poc	c6906417-ae9b-4e18-b140-9f5911323ddc	0	10	f	\N	\N
4b963015-b212-41af-979f-74c15dea31e9	\N	\N	eai-poc	c6906417-ae9b-4e18-b140-9f5911323ddc	0	20	t	47b34df7-7c38-406e-b516-6bd464ac162f	\N
09792a74-9343-4c6e-9369-90cf42ffe4ed	\N	basic-auth	eai-poc	47b34df7-7c38-406e-b516-6bd464ac162f	0	10	f	\N	\N
1dc95e84-f979-45f5-babc-08a502145d87	\N	basic-auth-otp	eai-poc	47b34df7-7c38-406e-b516-6bd464ac162f	3	20	f	\N	\N
8184aaa1-0fce-4a0d-93d2-088fc62e205c	\N	auth-spnego	eai-poc	47b34df7-7c38-406e-b516-6bd464ac162f	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
879c6cd2-589b-460b-addb-d5d79a193207	browser	browser based authentication	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
eacd6fdb-a3bf-4fba-91a8-3b63e812963c	forms	Username, password, otp and other auth forms.	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
bd1d042e-5f89-4d0f-9daf-c28d9f8bde31	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
d13a72ef-07f2-4cf6-aa5f-df19b5b5d578	direct grant	OpenID Connect Resource Owner Grant	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
87d2c62b-fbfb-4139-892d-d4df1c339528	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
43669a4c-0af1-4388-a632-3f07ddb35a51	registration	registration flow	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
a468f164-238c-43dc-8c81-ef4cc44f976d	registration form	registration form	b99b93ee-5ff5-4ecb-8266-0936b60d8371	form-flow	f	t
b6f0fbbc-3302-4d1c-89d3-488c32fab202	reset credentials	Reset credentials for a user if they forgot their password or something	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
04391ae9-c385-47d4-a010-9cf916669a36	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
22546526-0e08-464a-b578-55f22aca56a8	clients	Base authentication for clients	b99b93ee-5ff5-4ecb-8266-0936b60d8371	client-flow	t	t
e21961d9-c39c-4bdf-b00f-95808e5fd9e2	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
8131dc48-38c9-4512-a96a-ed1eff105fd5	User creation or linking	Flow for the existing/non-existing user alternatives	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
4476afbd-efc6-4e25-a530-ae8af320cc0f	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
73fdcde9-13d3-482e-99d5-c97b076e4ab5	Account verification options	Method with which to verity the existing account	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
b5471ddb-3bae-449f-8ea8-843c2f142da0	Verify Existing Account by Re-authentication	Reauthentication of existing account	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
767d04a5-c213-4eea-b1cf-44acbd50ba5b	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
815c4e22-1188-41d3-80d5-a9676990b963	saml ecp	SAML ECP Profile Authentication Flow	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
611219ef-5fb3-4f38-a35c-193c1aae4323	docker auth	Used by Docker clients to authenticate against the IDP	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
553654dc-fea7-4398-b962-a766ae899039	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	t	t
67722ea6-c1a0-4bb2-829f-2c4c086cf622	Authentication Options	Authentication options.	b99b93ee-5ff5-4ecb-8266-0936b60d8371	basic-flow	f	t
fef3889a-609e-463a-beb8-96381e6db2bc	browser	browser based authentication	eai-poc	basic-flow	t	t
c5c884e8-ec79-4989-884a-6a8dfe4d38c4	forms	Username, password, otp and other auth forms.	eai-poc	basic-flow	f	t
9cd00dcb-9400-49d8-a3e9-26a620102f0d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	eai-poc	basic-flow	f	t
e4391b1c-071c-4991-b4b7-76257dd2b742	direct grant	OpenID Connect Resource Owner Grant	eai-poc	basic-flow	t	t
9e51503e-2b63-417d-866e-5e52fa39a332	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	eai-poc	basic-flow	f	t
d8a5dcec-4b4e-4a08-a045-8606ae339e19	registration	registration flow	eai-poc	basic-flow	t	t
4db5857c-d108-4973-9f1a-882027cd912e	registration form	registration form	eai-poc	form-flow	f	t
40320e15-ea48-4f97-bd9d-358027b12ed0	reset credentials	Reset credentials for a user if they forgot their password or something	eai-poc	basic-flow	t	t
e61a5d91-f200-4cf7-af81-b77fd64fb9f2	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	eai-poc	basic-flow	f	t
ac40e50f-8429-45ee-935d-f33e00070b3b	clients	Base authentication for clients	eai-poc	client-flow	t	t
01f7938d-239c-4530-b965-b999a46f6ee7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	eai-poc	basic-flow	t	t
4dc6d903-9b86-43c4-8266-f9fb66ba7134	User creation or linking	Flow for the existing/non-existing user alternatives	eai-poc	basic-flow	f	t
01ec863c-45ad-4f7f-8a95-cafbc511bded	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	eai-poc	basic-flow	f	t
64522d15-da8b-4842-9d6f-353eb8c80ca0	Account verification options	Method with which to verity the existing account	eai-poc	basic-flow	f	t
28ee863f-14f2-4db3-8aee-524a4e983425	Verify Existing Account by Re-authentication	Reauthentication of existing account	eai-poc	basic-flow	f	t
571a4ccd-4dab-4cfb-8af5-3cc291b6aa9b	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	eai-poc	basic-flow	f	t
2b5fde73-9970-44d0-a4b3-28f0a2957dec	saml ecp	SAML ECP Profile Authentication Flow	eai-poc	basic-flow	t	t
12c88221-e445-4969-a6e7-37b39f30f0b3	docker auth	Used by Docker clients to authenticate against the IDP	eai-poc	basic-flow	t	t
c6906417-ae9b-4e18-b140-9f5911323ddc	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	eai-poc	basic-flow	t	t
47b34df7-7c38-406e-b516-6bd464ac162f	Authentication Options	Authentication options.	eai-poc	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
10f0d778-d768-4d48-be43-e2532d5cd0a2	review profile config	b99b93ee-5ff5-4ecb-8266-0936b60d8371
54e12a8b-e15b-4c01-b885-9b9e13bfb4e0	create unique user config	b99b93ee-5ff5-4ecb-8266-0936b60d8371
a60b1529-4020-4749-974d-df973dab4df4	review profile config	eai-poc
65726776-a60f-45cb-8508-f25ffc1c43c9	create unique user config	eai-poc
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
10f0d778-d768-4d48-be43-e2532d5cd0a2	missing	update.profile.on.first.login
54e12a8b-e15b-4c01-b885-9b9e13bfb4e0	false	require.password.update.after.registration
a60b1529-4020-4749-974d-df973dab4df4	missing	update.profile.on.first.login
65726776-a60f-45cb-8508-f25ffc1c43c9	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
c0293e7d-5594-44fe-a28a-8265232d7e20	t	f	master-realm	0	f	\N	\N	t	\N	f	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
f6690ccd-463d-49cd-a8cb-1110d45061cd	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	b99b93ee-5ff5-4ecb-8266-0936b60d8371	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	b99b93ee-5ff5-4ecb-8266-0936b60d8371	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	t	f	broker	0	f	\N	\N	t	\N	f	b99b93ee-5ff5-4ecb-8266-0936b60d8371	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	b99b93ee-5ff5-4ecb-8266-0936b60d8371	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	t	f	admin-cli	0	t	\N	\N	f	\N	f	b99b93ee-5ff5-4ecb-8266-0936b60d8371	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
86df04cd-3eac-4183-a69c-50ca8807c310	t	f	eai-poc-realm	0	f	\N	\N	t	\N	f	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N	0	f	f	eai-poc Realm	f	client-secret	\N	\N	\N	t	f	f	f
b3a61bec-042d-49f7-a585-f997585e7f87	t	f	realm-management	0	f	\N	\N	t	\N	f	eai-poc	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
806ff684-b7b4-461a-b71c-fb67bfa86672	t	f	account	0	t	\N	/realms/eai-poc/account/	f	\N	f	eai-poc	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4b9598f5-d742-461b-b70c-408b224e0792	t	f	account-console	0	t	\N	/realms/eai-poc/account/	f	\N	f	eai-poc	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6385ab1a-0f26-486d-a0ba-5f4812405fd5	t	f	broker	0	f	\N	\N	t	\N	f	eai-poc	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
74274da6-0aa6-4cf2-9b71-d4826f4da212	t	f	security-admin-console	0	t	\N	/admin/eai-poc/console/	f	\N	f	eai-poc	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
af9d3600-8ff0-4c80-b3f3-bfd429be4839	t	f	admin-cli	0	t	\N	\N	f	\N	f	eai-poc	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
fcec3dd8-531f-4989-869a-1e361cf2e629	t	t	64063030	0	f	7eJHp3dSxKDUFRmQEFEK5SjFbGjyYrTo	\N	f	\N	f	eai-poc	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	44d94778-db9f-495d-af5d-2b0c039f2412	f	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	S256	pkce.code.challenge.method
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	S256	pkce.code.challenge.method
4b9598f5-d742-461b-b70c-408b224e0792	S256	pkce.code.challenge.method
74274da6-0aa6-4cf2-9b71-d4826f4da212	S256	pkce.code.challenge.method
fcec3dd8-531f-4989-869a-1e361cf2e629	true	backchannel.logout.session.required
fcec3dd8-531f-4989-869a-1e361cf2e629	false	backchannel.logout.revoke.offline.tokens
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.artifact.binding
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.server.signature
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.server.signature.keyinfo.ext
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.assertion.signature
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.client.signature
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.encrypt
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.authnstatement
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.onetimeuse.condition
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml_force_name_id_format
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.allow.ecp.flow
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.multivalued.roles
fcec3dd8-531f-4989-869a-1e361cf2e629	false	saml.force.post.binding
fcec3dd8-531f-4989-869a-1e361cf2e629	false	exclude.session.state.from.auth.response
fcec3dd8-531f-4989-869a-1e361cf2e629	false	oauth2.device.authorization.grant.enabled
fcec3dd8-531f-4989-869a-1e361cf2e629	false	oidc.ciba.grant.enabled
fcec3dd8-531f-4989-869a-1e361cf2e629	true	use.refresh.tokens
fcec3dd8-531f-4989-869a-1e361cf2e629	false	id.token.as.detached.signature
fcec3dd8-531f-4989-869a-1e361cf2e629	false	tls.client.certificate.bound.access.tokens
fcec3dd8-531f-4989-869a-1e361cf2e629	false	require.pushed.authorization.requests
fcec3dd8-531f-4989-869a-1e361cf2e629	false	client_credentials.use_refresh_token
fcec3dd8-531f-4989-869a-1e361cf2e629	false	token.response.type.bearer.lower-case
fcec3dd8-531f-4989-869a-1e361cf2e629	false	display.on.consent.screen
fcec3dd8-531f-4989-869a-1e361cf2e629	false	frontchannel.logout.session.required
fcec3dd8-531f-4989-869a-1e361cf2e629	{}	acr.loa.map
fcec3dd8-531f-4989-869a-1e361cf2e629	36000	access.token.lifespan
fcec3dd8-531f-4989-869a-1e361cf2e629	HS256	token.endpoint.auth.signing.alg
fcec3dd8-531f-4989-869a-1e361cf2e629	1683486387	client.secret.creation.time
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
56c2acda-4af7-4da0-8a59-a989d8a928b3	offline_access	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect built-in scope: offline_access	openid-connect
c73aa77d-9113-435b-822c-b1a3daf0e59e	role_list	b99b93ee-5ff5-4ecb-8266-0936b60d8371	SAML role list	saml
d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	profile	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect built-in scope: profile	openid-connect
d607cefb-c308-40a4-8c8d-59225580ddd4	email	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect built-in scope: email	openid-connect
86faea84-1d76-42d5-8463-9236355eb860	address	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect built-in scope: address	openid-connect
04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	phone	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect built-in scope: phone	openid-connect
cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	roles	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect scope for add user roles to the access token	openid-connect
8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	web-origins	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a3ad611d-b4a5-4679-9cbd-30705553e507	microprofile-jwt	b99b93ee-5ff5-4ecb-8266-0936b60d8371	Microprofile - JWT built-in scope	openid-connect
1f7cdc9c-2983-4781-8efa-ffd5e8f96996	acr	b99b93ee-5ff5-4ecb-8266-0936b60d8371	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
088009a1-f3c0-4a6c-ac99-96a711fd9301	offline_access	eai-poc	OpenID Connect built-in scope: offline_access	openid-connect
33b77b7a-288d-4683-a3fb-f7a931666916	role_list	eai-poc	SAML role list	saml
cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	profile	eai-poc	OpenID Connect built-in scope: profile	openid-connect
ceaec65c-e507-4a3b-bd39-1c414a12d9a9	email	eai-poc	OpenID Connect built-in scope: email	openid-connect
20211f01-cb57-4e07-ab24-227de7c1752e	address	eai-poc	OpenID Connect built-in scope: address	openid-connect
56071c97-8010-4871-90c2-0d4dcf5ef64b	phone	eai-poc	OpenID Connect built-in scope: phone	openid-connect
857e5858-4bcb-4f75-af79-6ade599013f1	roles	eai-poc	OpenID Connect scope for add user roles to the access token	openid-connect
ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	web-origins	eai-poc	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	microprofile-jwt	eai-poc	Microprofile - JWT built-in scope	openid-connect
3d3ace4f-dad8-4728-8b0f-9c43522a4deb	acr	eai-poc	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
56c2acda-4af7-4da0-8a59-a989d8a928b3	true	display.on.consent.screen
56c2acda-4af7-4da0-8a59-a989d8a928b3	${offlineAccessScopeConsentText}	consent.screen.text
c73aa77d-9113-435b-822c-b1a3daf0e59e	true	display.on.consent.screen
c73aa77d-9113-435b-822c-b1a3daf0e59e	${samlRoleListScopeConsentText}	consent.screen.text
d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	true	display.on.consent.screen
d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	${profileScopeConsentText}	consent.screen.text
d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	true	include.in.token.scope
d607cefb-c308-40a4-8c8d-59225580ddd4	true	display.on.consent.screen
d607cefb-c308-40a4-8c8d-59225580ddd4	${emailScopeConsentText}	consent.screen.text
d607cefb-c308-40a4-8c8d-59225580ddd4	true	include.in.token.scope
86faea84-1d76-42d5-8463-9236355eb860	true	display.on.consent.screen
86faea84-1d76-42d5-8463-9236355eb860	${addressScopeConsentText}	consent.screen.text
86faea84-1d76-42d5-8463-9236355eb860	true	include.in.token.scope
04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	true	display.on.consent.screen
04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	${phoneScopeConsentText}	consent.screen.text
04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	true	include.in.token.scope
cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	true	display.on.consent.screen
cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	${rolesScopeConsentText}	consent.screen.text
cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	false	include.in.token.scope
8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	false	display.on.consent.screen
8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba		consent.screen.text
8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	false	include.in.token.scope
a3ad611d-b4a5-4679-9cbd-30705553e507	false	display.on.consent.screen
a3ad611d-b4a5-4679-9cbd-30705553e507	true	include.in.token.scope
1f7cdc9c-2983-4781-8efa-ffd5e8f96996	false	display.on.consent.screen
1f7cdc9c-2983-4781-8efa-ffd5e8f96996	false	include.in.token.scope
088009a1-f3c0-4a6c-ac99-96a711fd9301	true	display.on.consent.screen
088009a1-f3c0-4a6c-ac99-96a711fd9301	${offlineAccessScopeConsentText}	consent.screen.text
33b77b7a-288d-4683-a3fb-f7a931666916	true	display.on.consent.screen
33b77b7a-288d-4683-a3fb-f7a931666916	${samlRoleListScopeConsentText}	consent.screen.text
cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	true	display.on.consent.screen
cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	${profileScopeConsentText}	consent.screen.text
cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	true	include.in.token.scope
ceaec65c-e507-4a3b-bd39-1c414a12d9a9	true	display.on.consent.screen
ceaec65c-e507-4a3b-bd39-1c414a12d9a9	${emailScopeConsentText}	consent.screen.text
ceaec65c-e507-4a3b-bd39-1c414a12d9a9	true	include.in.token.scope
20211f01-cb57-4e07-ab24-227de7c1752e	true	display.on.consent.screen
20211f01-cb57-4e07-ab24-227de7c1752e	${addressScopeConsentText}	consent.screen.text
20211f01-cb57-4e07-ab24-227de7c1752e	true	include.in.token.scope
56071c97-8010-4871-90c2-0d4dcf5ef64b	true	display.on.consent.screen
56071c97-8010-4871-90c2-0d4dcf5ef64b	${phoneScopeConsentText}	consent.screen.text
56071c97-8010-4871-90c2-0d4dcf5ef64b	true	include.in.token.scope
857e5858-4bcb-4f75-af79-6ade599013f1	true	display.on.consent.screen
857e5858-4bcb-4f75-af79-6ade599013f1	${rolesScopeConsentText}	consent.screen.text
857e5858-4bcb-4f75-af79-6ade599013f1	false	include.in.token.scope
ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	false	display.on.consent.screen
ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc		consent.screen.text
ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	false	include.in.token.scope
3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	false	display.on.consent.screen
3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	true	include.in.token.scope
3d3ace4f-dad8-4728-8b0f-9c43522a4deb	false	display.on.consent.screen
3d3ace4f-dad8-4728-8b0f-9c43522a4deb	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
f6690ccd-463d-49cd-a8cb-1110d45061cd	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	t
f6690ccd-463d-49cd-a8cb-1110d45061cd	d607cefb-c308-40a4-8c8d-59225580ddd4	t
f6690ccd-463d-49cd-a8cb-1110d45061cd	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	t
f6690ccd-463d-49cd-a8cb-1110d45061cd	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	t
f6690ccd-463d-49cd-a8cb-1110d45061cd	1f7cdc9c-2983-4781-8efa-ffd5e8f96996	t
f6690ccd-463d-49cd-a8cb-1110d45061cd	56c2acda-4af7-4da0-8a59-a989d8a928b3	f
f6690ccd-463d-49cd-a8cb-1110d45061cd	86faea84-1d76-42d5-8463-9236355eb860	f
f6690ccd-463d-49cd-a8cb-1110d45061cd	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	f
f6690ccd-463d-49cd-a8cb-1110d45061cd	a3ad611d-b4a5-4679-9cbd-30705553e507	f
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	t
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	d607cefb-c308-40a4-8c8d-59225580ddd4	t
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	t
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	t
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	1f7cdc9c-2983-4781-8efa-ffd5e8f96996	t
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	56c2acda-4af7-4da0-8a59-a989d8a928b3	f
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	86faea84-1d76-42d5-8463-9236355eb860	f
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	f
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	a3ad611d-b4a5-4679-9cbd-30705553e507	f
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	t
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	d607cefb-c308-40a4-8c8d-59225580ddd4	t
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	t
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	t
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	1f7cdc9c-2983-4781-8efa-ffd5e8f96996	t
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	56c2acda-4af7-4da0-8a59-a989d8a928b3	f
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	86faea84-1d76-42d5-8463-9236355eb860	f
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	f
dbf27d08-b1b0-4b50-bed8-c0a6606e21c7	a3ad611d-b4a5-4679-9cbd-30705553e507	f
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	t
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	d607cefb-c308-40a4-8c8d-59225580ddd4	t
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	t
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	t
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	1f7cdc9c-2983-4781-8efa-ffd5e8f96996	t
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	56c2acda-4af7-4da0-8a59-a989d8a928b3	f
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	86faea84-1d76-42d5-8463-9236355eb860	f
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	f
9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	a3ad611d-b4a5-4679-9cbd-30705553e507	f
c0293e7d-5594-44fe-a28a-8265232d7e20	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	t
c0293e7d-5594-44fe-a28a-8265232d7e20	d607cefb-c308-40a4-8c8d-59225580ddd4	t
c0293e7d-5594-44fe-a28a-8265232d7e20	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	t
c0293e7d-5594-44fe-a28a-8265232d7e20	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	t
c0293e7d-5594-44fe-a28a-8265232d7e20	1f7cdc9c-2983-4781-8efa-ffd5e8f96996	t
c0293e7d-5594-44fe-a28a-8265232d7e20	56c2acda-4af7-4da0-8a59-a989d8a928b3	f
c0293e7d-5594-44fe-a28a-8265232d7e20	86faea84-1d76-42d5-8463-9236355eb860	f
c0293e7d-5594-44fe-a28a-8265232d7e20	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	f
c0293e7d-5594-44fe-a28a-8265232d7e20	a3ad611d-b4a5-4679-9cbd-30705553e507	f
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	t
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	d607cefb-c308-40a4-8c8d-59225580ddd4	t
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	t
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	t
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	1f7cdc9c-2983-4781-8efa-ffd5e8f96996	t
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	56c2acda-4af7-4da0-8a59-a989d8a928b3	f
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	86faea84-1d76-42d5-8463-9236355eb860	f
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	f
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	a3ad611d-b4a5-4679-9cbd-30705553e507	f
806ff684-b7b4-461a-b71c-fb67bfa86672	857e5858-4bcb-4f75-af79-6ade599013f1	t
806ff684-b7b4-461a-b71c-fb67bfa86672	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
806ff684-b7b4-461a-b71c-fb67bfa86672	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
806ff684-b7b4-461a-b71c-fb67bfa86672	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
806ff684-b7b4-461a-b71c-fb67bfa86672	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
806ff684-b7b4-461a-b71c-fb67bfa86672	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
806ff684-b7b4-461a-b71c-fb67bfa86672	20211f01-cb57-4e07-ab24-227de7c1752e	f
806ff684-b7b4-461a-b71c-fb67bfa86672	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
806ff684-b7b4-461a-b71c-fb67bfa86672	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
4b9598f5-d742-461b-b70c-408b224e0792	857e5858-4bcb-4f75-af79-6ade599013f1	t
4b9598f5-d742-461b-b70c-408b224e0792	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
4b9598f5-d742-461b-b70c-408b224e0792	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
4b9598f5-d742-461b-b70c-408b224e0792	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
4b9598f5-d742-461b-b70c-408b224e0792	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
4b9598f5-d742-461b-b70c-408b224e0792	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
4b9598f5-d742-461b-b70c-408b224e0792	20211f01-cb57-4e07-ab24-227de7c1752e	f
4b9598f5-d742-461b-b70c-408b224e0792	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
4b9598f5-d742-461b-b70c-408b224e0792	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
af9d3600-8ff0-4c80-b3f3-bfd429be4839	857e5858-4bcb-4f75-af79-6ade599013f1	t
af9d3600-8ff0-4c80-b3f3-bfd429be4839	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
af9d3600-8ff0-4c80-b3f3-bfd429be4839	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
af9d3600-8ff0-4c80-b3f3-bfd429be4839	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
af9d3600-8ff0-4c80-b3f3-bfd429be4839	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
af9d3600-8ff0-4c80-b3f3-bfd429be4839	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
af9d3600-8ff0-4c80-b3f3-bfd429be4839	20211f01-cb57-4e07-ab24-227de7c1752e	f
af9d3600-8ff0-4c80-b3f3-bfd429be4839	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
af9d3600-8ff0-4c80-b3f3-bfd429be4839	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
6385ab1a-0f26-486d-a0ba-5f4812405fd5	857e5858-4bcb-4f75-af79-6ade599013f1	t
6385ab1a-0f26-486d-a0ba-5f4812405fd5	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
6385ab1a-0f26-486d-a0ba-5f4812405fd5	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
6385ab1a-0f26-486d-a0ba-5f4812405fd5	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
6385ab1a-0f26-486d-a0ba-5f4812405fd5	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
6385ab1a-0f26-486d-a0ba-5f4812405fd5	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
6385ab1a-0f26-486d-a0ba-5f4812405fd5	20211f01-cb57-4e07-ab24-227de7c1752e	f
6385ab1a-0f26-486d-a0ba-5f4812405fd5	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
6385ab1a-0f26-486d-a0ba-5f4812405fd5	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
b3a61bec-042d-49f7-a585-f997585e7f87	857e5858-4bcb-4f75-af79-6ade599013f1	t
b3a61bec-042d-49f7-a585-f997585e7f87	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
b3a61bec-042d-49f7-a585-f997585e7f87	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
b3a61bec-042d-49f7-a585-f997585e7f87	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
b3a61bec-042d-49f7-a585-f997585e7f87	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
b3a61bec-042d-49f7-a585-f997585e7f87	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
b3a61bec-042d-49f7-a585-f997585e7f87	20211f01-cb57-4e07-ab24-227de7c1752e	f
b3a61bec-042d-49f7-a585-f997585e7f87	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
b3a61bec-042d-49f7-a585-f997585e7f87	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
74274da6-0aa6-4cf2-9b71-d4826f4da212	857e5858-4bcb-4f75-af79-6ade599013f1	t
74274da6-0aa6-4cf2-9b71-d4826f4da212	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
74274da6-0aa6-4cf2-9b71-d4826f4da212	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
74274da6-0aa6-4cf2-9b71-d4826f4da212	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
74274da6-0aa6-4cf2-9b71-d4826f4da212	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
74274da6-0aa6-4cf2-9b71-d4826f4da212	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
74274da6-0aa6-4cf2-9b71-d4826f4da212	20211f01-cb57-4e07-ab24-227de7c1752e	f
74274da6-0aa6-4cf2-9b71-d4826f4da212	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
74274da6-0aa6-4cf2-9b71-d4826f4da212	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
fcec3dd8-531f-4989-869a-1e361cf2e629	857e5858-4bcb-4f75-af79-6ade599013f1	t
fcec3dd8-531f-4989-869a-1e361cf2e629	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
fcec3dd8-531f-4989-869a-1e361cf2e629	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
fcec3dd8-531f-4989-869a-1e361cf2e629	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
fcec3dd8-531f-4989-869a-1e361cf2e629	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
fcec3dd8-531f-4989-869a-1e361cf2e629	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
fcec3dd8-531f-4989-869a-1e361cf2e629	20211f01-cb57-4e07-ab24-227de7c1752e	f
fcec3dd8-531f-4989-869a-1e361cf2e629	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
fcec3dd8-531f-4989-869a-1e361cf2e629	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
56c2acda-4af7-4da0-8a59-a989d8a928b3	aafabcb8-344e-4694-b610-423530804506
088009a1-f3c0-4a6c-ac99-96a711fd9301	2199e0b0-af34-4d4f-9086-9a080a1c60f8
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
05ee984d-87a6-4d9b-8fc7-669ccd7176e1	Trusted Hosts	b99b93ee-5ff5-4ecb-8266-0936b60d8371	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	anonymous
239205bd-23d2-4e50-9ac6-6e7d36c62ff0	Consent Required	b99b93ee-5ff5-4ecb-8266-0936b60d8371	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	anonymous
b993fbe5-a378-4492-bf21-1d04c953fbb6	Full Scope Disabled	b99b93ee-5ff5-4ecb-8266-0936b60d8371	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	anonymous
b3cc7450-743c-41db-bb42-9d0583d99d5a	Max Clients Limit	b99b93ee-5ff5-4ecb-8266-0936b60d8371	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	anonymous
1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	Allowed Protocol Mapper Types	b99b93ee-5ff5-4ecb-8266-0936b60d8371	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	anonymous
5f3e3c3a-55ca-4d2e-8f70-0c0d62ce8837	Allowed Client Scopes	b99b93ee-5ff5-4ecb-8266-0936b60d8371	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	anonymous
96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	Allowed Protocol Mapper Types	b99b93ee-5ff5-4ecb-8266-0936b60d8371	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	authenticated
f0d04970-93ef-4fc9-9b36-3bdb99c4f8a1	Allowed Client Scopes	b99b93ee-5ff5-4ecb-8266-0936b60d8371	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	authenticated
9c1070f8-ecbc-4134-a3cf-c6445a6f84f0	rsa-generated	b99b93ee-5ff5-4ecb-8266-0936b60d8371	rsa-generated	org.keycloak.keys.KeyProvider	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N
70a6d975-5b5e-4de2-b320-42e2dbb1a362	rsa-enc-generated	b99b93ee-5ff5-4ecb-8266-0936b60d8371	rsa-enc-generated	org.keycloak.keys.KeyProvider	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N
03473502-2d56-4cb5-8af3-8c4609eb8cba	hmac-generated	b99b93ee-5ff5-4ecb-8266-0936b60d8371	hmac-generated	org.keycloak.keys.KeyProvider	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N
082563ef-0c93-4d5e-85bb-29c6dd3516dd	aes-generated	b99b93ee-5ff5-4ecb-8266-0936b60d8371	aes-generated	org.keycloak.keys.KeyProvider	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N
e73114cf-331f-4739-9eca-97d9e4de50a2	rsa-generated	eai-poc	rsa-generated	org.keycloak.keys.KeyProvider	eai-poc	\N
897ee5cf-0e0e-4df0-9b0f-87dc6bce7606	rsa-enc-generated	eai-poc	rsa-enc-generated	org.keycloak.keys.KeyProvider	eai-poc	\N
3dc3bc75-4d0f-420a-a563-16e74108b0e0	hmac-generated	eai-poc	hmac-generated	org.keycloak.keys.KeyProvider	eai-poc	\N
d1f3b952-45d5-4f82-9b27-3e21b26443f9	aes-generated	eai-poc	aes-generated	org.keycloak.keys.KeyProvider	eai-poc	\N
2ea2cf97-c423-449d-9d79-7e7088dd306d	Trusted Hosts	eai-poc	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	anonymous
056591f5-84a6-4370-857a-3b8cf593fa50	Consent Required	eai-poc	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	anonymous
d98171d5-30c0-491f-ac48-86f8ccec9a1d	Full Scope Disabled	eai-poc	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	anonymous
cd274378-6afe-4d09-a371-6c813e554ae5	Max Clients Limit	eai-poc	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	anonymous
a6f9c494-efd3-44d2-9526-9481417f1420	Allowed Protocol Mapper Types	eai-poc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	anonymous
20e8c646-9ad1-43eb-b6d8-db647e217e4e	Allowed Client Scopes	eai-poc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	anonymous
6c0daf31-b718-4584-8d58-56d4d03a4e19	Allowed Protocol Mapper Types	eai-poc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	authenticated
9bf9b041-da20-4a24-b10b-d8045517bd6c	Allowed Client Scopes	eai-poc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	eai-poc	authenticated
1fcde5bf-1559-4eb1-b4fa-9ce0e2f09886	\N	eai-poc	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	eai-poc	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
d2d8de42-f034-4f8b-9b19-fd584418a9c2	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f78403b0-9ddd-4f66-8b9e-67ad35d99abb	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	oidc-full-name-mapper
a0fa7d50-c2da-401a-a1c7-dcf6ae7206d3	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	saml-user-property-mapper
ebb8b01d-c450-4860-b003-65d6e72ca17a	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f31ab2a2-47e1-475b-903e-3d77b7a79f46	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
44b58a34-e914-4473-bbf0-2d3a247882b1	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	saml-user-attribute-mapper
32042c77-e70c-4fe6-9e4c-0814afb48b2c	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	saml-role-list-mapper
cb33038f-2566-47e7-93f3-456394cedff5	1c8c0a5b-7f8e-4c87-b48d-6add64bf72b1	allowed-protocol-mapper-types	oidc-address-mapper
191c4086-6f69-4233-9b24-64d9d5b00660	5f3e3c3a-55ca-4d2e-8f70-0c0d62ce8837	allow-default-scopes	true
3e0d15eb-401d-4477-b7f2-198b4dd973fe	f0d04970-93ef-4fc9-9b36-3bdb99c4f8a1	allow-default-scopes	true
32ffa3b9-bcc4-435a-9219-11612df9b658	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	saml-role-list-mapper
7f7707a1-b0e7-44e3-b221-1ae4bf66daf6	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	oidc-address-mapper
3074972f-180e-4c54-9314-ee014578f61e	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	saml-user-property-mapper
3792ead6-109c-49c8-9ac0-4c1726ca6889	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b3e5cf1e-71d0-43c0-b33e-57618b992c6c	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
edd38e51-8ba6-4830-bac4-393e03614f43	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2a7c83a0-8ba9-4f6c-b567-ef55e3bcb0bc	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	oidc-full-name-mapper
4adeacab-a8ac-4335-8687-7ade31cb4d83	96a568ca-f68f-4ae1-aa9f-fdcb45a45a43	allowed-protocol-mapper-types	saml-user-attribute-mapper
62b1d4a5-7a51-421c-a911-7856f2fcc1e8	b3cc7450-743c-41db-bb42-9d0583d99d5a	max-clients	200
2d6e1aa4-1f7e-44eb-8ab4-f087d454c18f	05ee984d-87a6-4d9b-8fc7-669ccd7176e1	host-sending-registration-request-must-match	true
d9040f04-d74f-49b3-ba1a-101c36f577a7	05ee984d-87a6-4d9b-8fc7-669ccd7176e1	client-uris-must-match	true
318d7ba2-1de2-4a04-b294-81e882a2c4b9	03473502-2d56-4cb5-8af3-8c4609eb8cba	secret	TUyKoFeZexjHtg5Egx-wrqfD8gpNO4l6fqmj7O6RhTgXhpU6XsxCRG9lx-eDC8PrcMd3u7wPhOYbQhl6uPfhbg
2f50b8c8-2f0d-4f09-814e-6b3fbf2943ad	03473502-2d56-4cb5-8af3-8c4609eb8cba	algorithm	HS256
bc8c630f-06c3-4746-8ad3-4b1346302522	03473502-2d56-4cb5-8af3-8c4609eb8cba	priority	100
098c4b6a-1a88-48b8-9ec8-0c95a62dc2ae	03473502-2d56-4cb5-8af3-8c4609eb8cba	kid	ac5264e0-30d3-40ba-b5ee-9860a0c26fd9
12ac3263-0465-4350-af31-5b8a99117704	9c1070f8-ecbc-4134-a3cf-c6445a6f84f0	keyUse	SIG
b08a390d-1e96-4f08-821b-942581c61be9	9c1070f8-ecbc-4134-a3cf-c6445a6f84f0	priority	100
0e97cf55-2486-494b-8bf2-5cf4192ab975	9c1070f8-ecbc-4134-a3cf-c6445a6f84f0	certificate	MIICmzCCAYMCBgGHnH8AWjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNDIwMDIyODAxWhcNMzMwNDIwMDIyOTQxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCKYrsTHxIuV0Xw6xvi/LhOmhCwPEWaZtZkMwzTJdkONL6akl/ZUMcRpRX/xK8Hq/f9NEwl41peZfiOSefTKYAr3eahGs0H0rYjLvZn9PuBfIzPF4uiJQtQU0VSVdTc/prjFZR+wCrlc/ziCpfpDwIZM7YWr5P049PxGq1YgytPOH2ln2cIIMFSY3KlHafKS8+37TrV3TNexS9cTRwQEuhcqD762CzZs0lte3VyT0u8MhGrtFm7X6XleyX38Lq7kda4x3Nm9o72jljD4hL/Sd70joPN1nVhWsxmWCe2dpvMl9yzXXJzj0DnFoR8yIzJfVgmoqqoymlU4ejcmJwyV+3TAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABudmfZVShVYofxxnLJe87efD5WhqCrNix7Pufee+ten+AqhrnOAaxERVdAkcIh8gN5Zti+dltjS2nrfDQh+cpFxcRQd7NFSXMg9vPBGAS9CRpk5QWPW3VKv5qmcZ5dFEvR1E7GyB22WLz9/SxTPpoYL5Ce0eDUHTbBjx1osRPYt3CijPk07TRSKLpW8ZrLpSxBZhvKNAT09KzKmB6HJnmWQKW9kl0wfsqL0rxJS0OWSrU6ltTtdVNsdiuD0X2pc9hoY5+Q/TBhc7Xg0p99SOdKImV/UWgPZB6bQvSOeJ6iFaXjkD5eysfWgf5uSgtAYBPYxxRaA0I5OnmH5ERAp+Ew=
460a7ba7-47ab-42e4-8537-ca187c94ce7f	9c1070f8-ecbc-4134-a3cf-c6445a6f84f0	privateKey	MIIEpQIBAAKCAQEAimK7Ex8SLldF8Osb4vy4TpoQsDxFmmbWZDMM0yXZDjS+mpJf2VDHEaUV/8SvB6v3/TRMJeNaXmX4jknn0ymAK93moRrNB9K2Iy72Z/T7gXyMzxeLoiULUFNFUlXU3P6a4xWUfsAq5XP84gqX6Q8CGTO2Fq+T9OPT8RqtWIMrTzh9pZ9nCCDBUmNypR2nykvPt+061d0zXsUvXE0cEBLoXKg++tgs2bNJbXt1ck9LvDIRq7RZu1+l5Xsl9/C6u5HWuMdzZvaO9o5Yw+IS/0ne9I6DzdZ1YVrMZlgntnabzJfcs11yc49A5xaEfMiMyX1YJqKqqMppVOHo3JicMlft0wIDAQABAoIBAQCA1+/Jm9I3pzYNWzk5m4aWWEdVbqh3W2wdGpLEPKbc3Srhi4sGMHlH6maTHjLAd9KKwxhq5kULQvGquRDIwAj/zrieIu/mar79/wmYPLW2F5qabhepvcfM39rZD+UCZWMcLsl1QcIupFE8vBQ3/6s6f7T3Zj3hcgWwo9/lWysFs/VsCfADwwII/laH2M9q6PUYShakidFynmJxTdQhbqohG8JnlHET85iIjOoG+1QDpkPSPGeXc63vJT4VvAyscp/WpPypjdOaIHjlJMzFVAUNpvDREmLjz2VGvIbYsSO8YD5bSBjKctqc8RaefaYqHdY7Eg0rYi0uRIfOfXvSE8TRAoGBAN8IPtIPep2kw7ej24S4LskmKhLMfuPcsVObTxnOZdzOHDPue2hnLTk6e0vdOElokw0E5+NNlrJAYTNnW4rJA76WOX84+hoSrQFcNUXVjQ+uPXPURZVN+A/PJqndzZmMWeyU5rHCcMefwftu79jFR1q3u7T2dUCyfRk4jc0vkoUdAoGBAJ7XYNmnEVW2qvfOGfSrfYNr9uZKbhXtbqtdTnBIMUFLJJOBRSkrvjjT4glT9Bk2jb5O1/ekVnOAxZz25KxXatwCJSdP2ZzKFgpx1FCZPeUKztUndZ8g+lTrblpfYrdDTgMRWvQAFoGac89ymqY0te8Y/omQiV1trtX9DFWhAnuvAoGBAMlNl+XhMrq2zDAkJS5VT2UenTr6eE0SFLtxoqOYNzhkj/APgDNrbNYKgt6mfPdE+/T0SJhQn4OjuBe9YlKRvF95F8xMkPCXiq9/mlW9ueQ9UBoLrgJkrVEXl74aBEhi9YcjnlUzOrfy6hMWvkTZSt4Gl9Vt3cbXUzJAaTyZg5XBAoGAbcG7fYoQ015ukt7KVqNtDjO7HnQNz38J+sV1nuZzin+G3Zn0lTdRsOjQBswJHqbwmLDYUJkw140Cf6ymZGPfRfkBfUGSx+FoC32OTMcm2q52LxmeD//0mls4HKBOkP2j2UDTzUiGRLXaEl1JeVFw6a8mqx3BnVpd9iVtsXmZQqcCgYEApyVH3lBgNhyoCpqbvPf5v8ytNjiL2Injbiy7A98c0EXmQGwj+rTAIhZPrqK4jFdiOcNqIPl+sPbHUWRCWXyxofOq4Qg/cLp1C5GR+BhMR5/S/S90e/pLVTZUmYz0H0fTlhMeuCyxqfmBsiTlzyv3Q6F1nb1MZnQgWYEeffl1x08=
eede4ebc-4428-4a69-9d0d-976a455b8ac2	70a6d975-5b5e-4de2-b320-42e2dbb1a362	priority	100
49b6da8d-a675-4bf4-8b10-d63934947f6d	70a6d975-5b5e-4de2-b320-42e2dbb1a362	keyUse	ENC
050bf58f-7a2f-4365-8aa6-86f4e869e44d	70a6d975-5b5e-4de2-b320-42e2dbb1a362	privateKey	MIIEogIBAAKCAQEAkNDwvfiE4uFyzrE/Rls9eUAq5zQJI3KZMXSM31PWqLBZhzZDgLbt97/PC0hv1gPlMXaKWMkgfvtHqkHsmwXkPrpNT3+IFrr0MHnFWfo0B1BT70Au5G0u9FVHpND2GX2IOiSRT71a8SPOpklvpCnIq9UTpBQyzAP3kXLk7bUkPZs3eq13XiRpNbagEIVd5Ie/9OnaeimDlVqLJ3jaLSRbxoHE3Z6vAr+Q6KT7zciXVSWw5dOHkC7orp3adSwggCr6N7CzPlMSl8f+aDY4O4zrUoum0p8MkO3phvNy6+5t+Tt4SkMxom3CQFEhPMOCYbIGpqsguaPjjNODew0QquAedwIDAQABAoIBAC+M26+U/ZU9r6PcoUkpxlqczjmSZXnFNDX/7g2air5jAVKbZ7jI2ARkb8hlpYshRk1iffS/PbNUMOjfsqAIZDSQmbgDyRylkG6mXT25IQJRxu2lJoCMtUE3C0o77sLZ7DQjM696HnVVa5JARK8jpSd+1G8ozrEckFqq3i6LLvYnFU+uNSU3D9E6E9CCrbFk8crBrpmQC4WAFIYscyBZRkpDDzoBj7M4Cz5AEm3v8A4iK3sZk12buJIm3WQytoZtsq9FS7O9HRLjFuz8ughoMgTwi2PQcUz40cRV3yh5ZGQUwehuDGpqSw+XJ39d1yW8J1tLC7A3CRieXIZcOlJcGAkCgYEA0EaiNmx2DRhWjCvW9xhwu75TENWHulgQrHqohYsJrVCIj6m2b772+bjIlKvRWtchg65ZPfE0xgQ+9JHGAbupOVmTdxP/1h/N4ThcEFwbxKS4AYrW3UGkTdVfXIkBADOI8rig1rO/0gm491YBURSLj5w/4jxDk2gzDX4NQwsblz0CgYEAsf/J3GPfbq6Dbvo+YczCqxanPHoL/yja7FE5JZK9uhC+B2yk226pVUPhArbqwcqRP939545nf1o1ByNdbVqdIDTN0IaVm9rAW+FgFf2oAzPAG5MWrSI46J1Gh021otAd7FQL9kJKj78ISWu7s/EFPLHzuHYKFXM1musP81QyR8MCgYBToclJKUxN/dPi/UeYeQvrl4UrYVLbFLm9SJOa7DW6jngHmBJV1My/gd+pM0UhwPkIM15KbSzPxqyw8EgeMgjFqp54VmOIy8SUB1mQiCvuTmZE2EdnGRCs4F0mfy0Ts53uOQz8qbkA0j6fsr1cnW9c/1T3t1M7QcAeTttsbG1r0QKBgAHiiYqx7A3J/05PjBWRC4awSLkVOcdL8XWLLqW9NhEgWELP3bcNJvHmNB3JPhcrQ/p/KU8obOQmWmVm9HhR+1P5+yv4IOFzoZHXgyL4eqz+AUzJc/YFZMDh2XtZUVEWDxsPkMjcztlS1o2gfG5dYQbRg5kydszfWXP4hUS4YYftAoGAYJYRMuHvIxsul9+4zJk7PAGBLKFeZSEs1N7VBs941SxOf8N6wqBwSmmukhnw5737Vjpmn2N1PqPM2Sg6B6hf9n4D1viEqucxc/Vz0j45gDfeB91kRrFdkXNb+MI5UYc2ovz3dvqVr+mtcA+PvH8VABtBAMq9oCiNgeij7r/BnZ0=
a87c9e4d-409a-48c8-b759-558df10dac0b	70a6d975-5b5e-4de2-b320-42e2dbb1a362	certificate	MIICmzCCAYMCBgGHnH8BDzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNDIwMDIyODAxWhcNMzMwNDIwMDIyOTQxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCQ0PC9+ITi4XLOsT9GWz15QCrnNAkjcpkxdIzfU9aosFmHNkOAtu33v88LSG/WA+UxdopYySB++0eqQeybBeQ+uk1Pf4gWuvQwecVZ+jQHUFPvQC7kbS70VUek0PYZfYg6JJFPvVrxI86mSW+kKcir1ROkFDLMA/eRcuTttSQ9mzd6rXdeJGk1tqAQhV3kh7/06dp6KYOVWosneNotJFvGgcTdnq8Cv5DopPvNyJdVJbDl04eQLuiundp1LCCAKvo3sLM+UxKXx/5oNjg7jOtSi6bSnwyQ7emG83Lr7m35O3hKQzGibcJAUSE8w4JhsgamqyC5o+OM04N7DRCq4B53AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGTt4Chmy8R83i3YmoTk21wWktX07N+rGbH7pEpWYBl1G6zYiuSn1lcrvHqWh0jz1iZtg1ifkhElzL9EJGsBrIu3N2uqXO6qJ8JPYGWVBXub4ctWlNalaSQ3KinUr+gaWowB2xVLj046zqr9Xe6Lyb2W7F0KbE0wVKKrgLy63iCu9ROnVlEV6jvfKpGyV3vz3QbAc2fa8UWQUc2ZPhM12UkklEFMmgiK01Ln2RX8c94pkTiS4c58JV79AeA4nk5iUjE15C8DCeD7ouivljiNxV2y63NswM2mFe+VL79E/tOgwEKXqTupdbZSuqe8t4BW+J2ofRH6M9ZrANSy5FTNwvg=
44548e25-a400-4dc6-9938-1b72580d2339	70a6d975-5b5e-4de2-b320-42e2dbb1a362	algorithm	RSA-OAEP
9ecea5e1-288f-41b4-a43f-203f7c4af874	082563ef-0c93-4d5e-85bb-29c6dd3516dd	secret	aNeTHMtjB28rNTPPtKn80A
5aba1097-1b3d-4657-8693-72f36d02b437	082563ef-0c93-4d5e-85bb-29c6dd3516dd	priority	100
28a8bdf7-b3fc-4fd3-927a-9dbd3893b4f0	082563ef-0c93-4d5e-85bb-29c6dd3516dd	kid	f2fa260a-35e6-4450-9ba9-18d301f77964
3c159c37-fdae-451c-a695-6a3df322f5cf	e73114cf-331f-4739-9eca-97d9e4de50a2	privateKey	MIIEpAIBAAKCAQEApiZzdKG9qmyZ51I/EkS9Maxvpo3lpt5Q9zV3HkNwPw/wV83hlnnsxA6RLMSKQNYsddkVvcnadIAfj7m+OjlnUF1jT5E0UgVf5MCR1eb/DYa0DypTyGdinJFVRaK9RKeGAV4Q64kueGyMeGz6+5PcvnL2m9RjcD5fbUMWUiU2FVlqz71idpKYV4/Z57wP2sJGMXN9vCjEqDyY/3cSFJpMHF6Bg2S51X0Zv6wapQLDazA3+cwCJU5ic1X54x7gW8dtS82SkcEX449brZQQ01ZkOQ6TZid4LK3DsLjg96X0zvla1aVpKxA8p28vwDvCqbuAMaZoHrwF+hYiBOhrBJ7xCQIDAQABAoIBAQCjatBGF8sfs39QWMG2KyvWjp6mN4x4KtOBwfFuL7BYJkojYlkOEs/AKf+6A3ljugOyyZirubyGt3nTeEJUrB8kmSXTnaLTRXwC1zDZLUERQbsZ62zKgH0qN3uiaSU1QHv6HlYQBDZTtZgX3kChbtY/730E2coQHRjos4Jhuz3NkjNlkA/I7+gh6auL3QwoExXB+ZinUB1YIXDBhTmAPLIfDbp5G6EmUKNTakFzAYyq0CaLr9QX66sn9gru6MLfy6aqVYooVRA5ypdws1xGo358BgLBCTazMVoQCE2jAfAASIULAHdFKr2Oq7bGO2w0x7B2z6r839AMOSehR14BBYoBAoGBAOi383AUFt3J+FiSG9/VYDYsHrLORtHyLVgN0bj5KtUzO7+m4Zzx0HPCC0eBY7FIYpzogLMWK4KFYNJM+31OpmOLNS2bUCbB6ns74V+fEebIy+mB0ruHF3u5gLg3ejc5X8LICYarCCccJH/mv5Oa6/p8znWmi9twgCfaEzoqC01JAoGBALbFpet4ZTjL4cJDP0ZI7PmY72nLUsnGmQvA6VchqXaN4wUw7y1CmjnYm37axZeFmW0wcf0BLmdbEf8Hj96ol4zgQF4j3dOnyGKY9xb6b2rpzoR76HVhXDJY4q11KZqWJFp+GaE92qm7T25dCW3XvvfRagMr6XgxPyDwg9ldHUXBAoGATCSb5yj7jlfeBQTRT/xdvXvUE4cAjwLhKTVkUFReWmGoA/4TRamtHaL4082XE9NuSI6eRXpUhCEl28lKY+aO9HUA0kpGAFhkYyvlgsbmMY+zgFR04dzCpz27ywqD13vTRET1MPXW9gz0OFEEj8QZv9yEJOR4UDVQCToGHnrRNdkCgYBHtZpYnZ8RPqTv5BSCTgB0GXXtizGLKxlHDERAxFtJwXeNxNpCZrw97+dqSQl3XpqIxZYjjwAW2xtfdScUVA9J3X5DsUzKSy0Kyjs/z7hBOUSmpDrbOvzCYC9noO1W0oum2YzSv4L4Tx5mDaiyaRBrCMXQQr1SQ/ghw1vnv2nJwQKBgQDhe3N6spSzMtEv+Obx7dYVmXOOabjVLSah08a8pQK2eJ+WJ4gEe3iKrfvxIyZb3brV7gy+AdQZtDwOV5IpKDDPK9cGfJIevsYoOf2jNkXkDQKn9sgOHXLFv8QBp19J32H7w2mZAhC9G416SCH6GjjlwUZDSFp6bwHqXCS7aHgxzg==
8ad2697d-0bb9-4aaa-bf43-7fc1db963b6a	e73114cf-331f-4739-9eca-97d9e4de50a2	priority	100
d4bc02bd-d611-4a14-8ca5-79e161f70f5e	e73114cf-331f-4739-9eca-97d9e4de50a2	certificate	MIICnTCCAYUCBgGHnJF/TDANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdlYWktcG9jMB4XDTIzMDQyMDAyNDgxM1oXDTMzMDQyMDAyNDk1M1owEjEQMA4GA1UEAwwHZWFpLXBvYzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKYmc3ShvapsmedSPxJEvTGsb6aN5abeUPc1dx5DcD8P8FfN4ZZ57MQOkSzEikDWLHXZFb3J2nSAH4+5vjo5Z1BdY0+RNFIFX+TAkdXm/w2GtA8qU8hnYpyRVUWivUSnhgFeEOuJLnhsjHhs+vuT3L5y9pvUY3A+X21DFlIlNhVZas+9YnaSmFeP2ee8D9rCRjFzfbwoxKg8mP93EhSaTBxegYNkudV9Gb+sGqUCw2swN/nMAiVOYnNV+eMe4FvHbUvNkpHBF+OPW62UENNWZDkOk2YneCytw7C44Pel9M75WtWlaSsQPKdvL8A7wqm7gDGmaB68BfoWIgToawSe8QkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAT+8D/5Nn825oP2bIv/qq0ZX9WauIO1+WKRhfVv8B9BX6qs7WrUS8uKgFv05mu0o1ANtYK3H9J940Qi/fu/lTY3h+VURrXRehK1yOL6lxnPUVMK77co9Ji5HHEbZTWBiJbDmgTGoTUSRjOOFrt+2fliviLmfimHaHt5kYMHMfWAVVX7qBDCT65Cz2Sw81/uq18XVv/KkudOhwEUpAh/NJeN6qeW+R36Xnk+gYem9t23azqQwPgl2C4Kvtli07KRPsVtOaT/LeRjDcrBUiHMapS0fNJ7OClK9tebGjOOaPLmvOw4BuoVmn7QgLaZNwQr7CdzsYuU1R5IBVw509CMjpIg==
7c99f2c1-9367-40f0-a812-c77f86faa208	e73114cf-331f-4739-9eca-97d9e4de50a2	keyUse	SIG
3e4ba485-f144-411f-9fca-319439aed609	d1f3b952-45d5-4f82-9b27-3e21b26443f9	secret	crh-2zM52hGA_fcJs03bFw
75f7ab43-d44e-4849-bd69-8f2da0f2fedc	d1f3b952-45d5-4f82-9b27-3e21b26443f9	kid	662fbf8d-a680-465d-ab13-af021e687ac5
e7b1659f-5dff-42ca-aae9-38968fefe7ff	d1f3b952-45d5-4f82-9b27-3e21b26443f9	priority	100
e2a55866-67e7-47ab-be78-a774ee5d7577	897ee5cf-0e0e-4df0-9b0f-87dc6bce7606	privateKey	MIIEpQIBAAKCAQEA2aSgyXQfQAuRe/GSkjv1jsfLIpmRCU5aBA2Cl7GT3apTgIdbVXjp4lv7RCBTUKhomws7x3atydPIvgEyIOAoG7HesbbiKmjm/+9Aoc+1MSsMXx8AnGj+srNVbR7ZzLfaHXHTVdI5vveuDMp4uYBLnkvhh8Us/HN+M+VJV5nbyNgn23m2cCUHu5IpCMvQ4oZzWTUJJzOzhCS6Iy0HwbTol6JULmFLmPmfBCpMftB42ZzYimFk9jChgVT/GdSClwnFtlffpv9YwaGJhdA9m5LHJWlf7aFfVpNap48QSnww8VJW3WExII/RjihQm2lw0dNXWxxN2YaaOyeTMJaog1a0wwIDAQABAoIBAQCMDL/aYnrpf4gytZSXvTWalz5EGYWW83BBQ2BRtNdtwHjTMEa5jYETRBVAFX0HXhdSDbx98gSK51k5yxMyzIuCpsainQiUOcTL1G1Gsp3p8cWYQB7ohze+TmAeQ8frUDNu1xwjEZBPLpo1aOSemcwPJM0PzPXRzY/cXSMA1+TyK9Y9nt3Y4aJusegrTDXsTRVbvqCh9JoZyloLe1OhxNknlFfc49PnO9WPwxsm0xU30l53Nqo+xg67CFStp0byeLBqwpIW76Z4SgwZzSHusyMAMkRbYMEwkgTOQps+/PregqI2JWbwcusaVl6U3vs6W51Ep3G82ZlZEFYX8IKpOVNhAoGBAPFfxT7Z5l9Rn/Gy44B2H2k6vPt2vhWTRooE2/hYkiTJLOvFmUBI8Zc2/X3MG5GW2UoakGH0jR8Nn9Kr7bDFM6onjzfCvxD824d+U8e+Z9N4aim4t5BcNoh+ikes4Q6pr/2c5UGmjt3upENddE5reNw8R0VdFR1y1Q1euBzJL8UPAoGBAObUvRDm4wYKlzEQSkIkjz1ZFamY7FQ1K0hjiO/1oC931l4Imq53P2MzFJr3e4zX1KL+Xcl/wUs6rRbtmTAeU0kc+4U7lMV/qkasi17xdew/6qqNwKwT0H1eE84FT5tsYyO01+54RLldN+Y56taiJD0Bttxp0stdmEnkL6FZ+R0NAoGAYNOcWpQqt/4UfW7XmIbKHvpzKST/J8SGvYMpgrx1E9Cn9oSz73fTgmeK1NX2ETdEP1fcp47ktZpPjMFvfkP9b7qi1ymGYBgvMHFaxnv5Rnm9jLMO4Bg9wA+TBSGyvqEPeltgFC/ui9TZjDSHHZY7S43awVaPy9pu4QgoL1P9l70CgYEA4mZwFh7PNoK2rfmzS9J954bzt0d1LFaF4Fc33VuFxGj+iXZY+JufQVW9dQ0dUhPyy/c+176FQJsJX/6kjEyCFajmjVPV5CwGP5FGlVWw+onqSWQFQQGiMQRP2nbdEK0rQ79BNvUhOsnSZO4Thna7olaHGwJ0LODc2ESF7vTHYBUCgYEA33NJhKR1E317kCmQhWLseQzwwfC9yqd0u9cdhQIZNXKdYP2RAgJ4SErhGd1rEdJsnVT28Xg1VLvcsPyUs5uGCN7fp5TBiR/uFSMrDvbn4/kz19DDy25WjTjtDg+DU+TAf3DVnaBNw1M0T1U53bCeuxJkyGL+lbZmywBw8fzwMto=
e2c786e5-abea-4b21-add4-efaa4434892b	897ee5cf-0e0e-4df0-9b0f-87dc6bce7606	keyUse	ENC
fb642379-442a-4547-8213-27e97542b309	897ee5cf-0e0e-4df0-9b0f-87dc6bce7606	algorithm	RSA-OAEP
6745b89a-24af-43b4-8a7d-b95b4bb751e8	897ee5cf-0e0e-4df0-9b0f-87dc6bce7606	priority	100
335a1c2c-73fd-424e-9b7f-8206994b1d4b	897ee5cf-0e0e-4df0-9b0f-87dc6bce7606	certificate	MIICnTCCAYUCBgGHnJF/lzANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdlYWktcG9jMB4XDTIzMDQyMDAyNDgxM1oXDTMzMDQyMDAyNDk1M1owEjEQMA4GA1UEAwwHZWFpLXBvYzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANmkoMl0H0ALkXvxkpI79Y7HyyKZkQlOWgQNgpexk92qU4CHW1V46eJb+0QgU1CoaJsLO8d2rcnTyL4BMiDgKBux3rG24ipo5v/vQKHPtTErDF8fAJxo/rKzVW0e2cy32h1x01XSOb73rgzKeLmAS55L4YfFLPxzfjPlSVeZ28jYJ9t5tnAlB7uSKQjL0OKGc1k1CSczs4QkuiMtB8G06JeiVC5hS5j5nwQqTH7QeNmc2IphZPYwoYFU/xnUgpcJxbZX36b/WMGhiYXQPZuSxyVpX+2hX1aTWqePEEp8MPFSVt1hMSCP0Y4oUJtpcNHTV1scTdmGmjsnkzCWqINWtMMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAcoKu0qwYVRXHtysjtA9jxl2O5XnQMT1XuHNfFKdyXLGG69hNliPKPCLiu2J8WKwRFj0slAbW9jS2l7xwFesAFxnDRMbzM7zpB+wXRvPxEDs8BwG5/ObMwwkHTtbeIU2S2mFC8ETE7PaNy7FRuyoGznoLZEJd6URlHom6j/C12W+tFhq/eHdXzzgI93BdzZ64isNu6fqglgg4gWd4Dz6BiCfKQQ/kaRuMMqNcrTjRmHft5vVc0bVeOj8XPlwkw5QHQCRAQSybbD14JzenlB3jjqenl0d2ybaJ7++x85OFEVrZuQZBtVpJL174mTukWUn2Krg0hKHHU9uEa1DevF8VsQ==
e251f9e8-84ab-48fc-8291-be223eba5557	3dc3bc75-4d0f-420a-a563-16e74108b0e0	kid	717ebf1b-26a3-4f20-a0e8-c0f95fff1556
78515f1e-237b-4fcf-9f8c-6aba33dfef23	3dc3bc75-4d0f-420a-a563-16e74108b0e0	priority	100
750571f3-b4e0-46ea-bd80-ace5d318d99c	3dc3bc75-4d0f-420a-a563-16e74108b0e0	algorithm	HS256
ee9e205c-d7b8-4ed1-9a46-29a4d6cb62cd	3dc3bc75-4d0f-420a-a563-16e74108b0e0	secret	9R2WVEtH6ZlaVskLLGKsRF1rzA4DqXrfHKr85WuHKrYsHqjnFiL--2QfhZSgoCE1EbloXfsV9sQxiZ_Nh-QAmw
846e8b11-2f70-4483-96db-a03818ef34fe	20e8c646-9ad1-43eb-b6d8-db647e217e4e	allow-default-scopes	true
0ce95911-2aa1-450e-9d3e-1b128ef0db31	2ea2cf97-c423-449d-9d79-7e7088dd306d	host-sending-registration-request-must-match	true
0331c831-2e44-4b15-a0e2-e7e834eb80b1	2ea2cf97-c423-449d-9d79-7e7088dd306d	client-uris-must-match	true
c5ec5f20-a586-45df-b87a-b02a00dd0a99	cd274378-6afe-4d09-a371-6c813e554ae5	max-clients	200
92081fa1-eeda-44e3-94a7-1e6b39613bfc	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4fe0b93d-4154-4cd0-964e-a018b2c88714	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	saml-user-attribute-mapper
ae900dc0-80c2-4941-baf7-1a27b31d26e7	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	oidc-full-name-mapper
9324cc8a-5085-4048-9fac-d3ff4a41e1f3	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	saml-role-list-mapper
7753e68a-96f0-4b33-aa9b-a0d490136eb6	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	saml-user-property-mapper
02ec147e-e5a6-427c-88ef-13734a6f3080	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
35ea1cb2-8462-4167-b92d-d0b610e2838a	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
517bd49f-0339-4643-ac70-fecd4b7441cf	6c0daf31-b718-4584-8d58-56d4d03a4e19	allowed-protocol-mapper-types	oidc-address-mapper
ff3f6cb2-df94-484e-901e-22d30ba6c28a	9bf9b041-da20-4a24-b10b-d8045517bd6c	allow-default-scopes	true
d7cbeee1-7868-4713-b46e-1645d2ec5824	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
86cfa485-d955-4eb1-a592-fee7ef404e99	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	oidc-full-name-mapper
c2f53f4b-e187-41d4-8029-9b91d756a031	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	saml-role-list-mapper
d8b449fb-a7ba-44e5-9cfb-70ed03e4c4cd	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	saml-user-attribute-mapper
1247b0f1-38fd-458f-a75c-3f4a51dc73fc	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	saml-user-property-mapper
6d38da19-8839-4f4a-8c85-a3c1ad1886c7	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
83c520e5-1c66-400a-a955-4742fc136d60	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
850c012e-8fb9-4adc-917e-223f696767ca	a6f9c494-efd3-44d2-9526-9481417f1420	allowed-protocol-mapper-types	oidc-address-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.composite_role (composite, child_role) FROM stdin;
5c705864-595d-4ccf-8c3d-8747a5b3e31c	c4210c8e-49c8-4481-aa74-bb68c8c5850b
5c705864-595d-4ccf-8c3d-8747a5b3e31c	4c26d14a-6421-467b-80b1-e6d488ae2860
5c705864-595d-4ccf-8c3d-8747a5b3e31c	b6810eaa-963c-42bb-85ef-3ff74bcf4b66
5c705864-595d-4ccf-8c3d-8747a5b3e31c	0feac28c-4cec-4bd9-acc1-c3dd467d024b
5c705864-595d-4ccf-8c3d-8747a5b3e31c	bdce686b-0e54-4b29-990e-7be7394b339b
5c705864-595d-4ccf-8c3d-8747a5b3e31c	7a3f713c-f24e-4722-8250-318ea5c0d06a
5c705864-595d-4ccf-8c3d-8747a5b3e31c	fb475401-e8ff-493d-8227-20930ba65d8f
5c705864-595d-4ccf-8c3d-8747a5b3e31c	b5b8574d-dcc2-4e5b-8437-80dc08b0755d
5c705864-595d-4ccf-8c3d-8747a5b3e31c	9a64d3ea-952e-4723-ada0-bc714c9eca28
5c705864-595d-4ccf-8c3d-8747a5b3e31c	29046464-c751-49bb-8ed6-cffc6bf51cc0
5c705864-595d-4ccf-8c3d-8747a5b3e31c	e0de3301-23bb-4420-8073-91326f42d698
5c705864-595d-4ccf-8c3d-8747a5b3e31c	dc2f62ba-8140-4184-96e5-e03c384227eb
5c705864-595d-4ccf-8c3d-8747a5b3e31c	265febda-8e8a-4f5d-904b-cec0cecc3c99
5c705864-595d-4ccf-8c3d-8747a5b3e31c	f4fd8905-753f-496b-aec5-18fbd9003f1a
5c705864-595d-4ccf-8c3d-8747a5b3e31c	01ef1216-cc74-4d3b-8cf0-d0c4b2630fd9
5c705864-595d-4ccf-8c3d-8747a5b3e31c	92681917-3bdf-42af-875f-91a344bec671
5c705864-595d-4ccf-8c3d-8747a5b3e31c	907284ea-6f32-4396-99a2-fe0aaa5a8492
5c705864-595d-4ccf-8c3d-8747a5b3e31c	ca9e1371-5fc6-4f06-8d96-969166325cd0
bdce686b-0e54-4b29-990e-7be7394b339b	92681917-3bdf-42af-875f-91a344bec671
0feac28c-4cec-4bd9-acc1-c3dd467d024b	01ef1216-cc74-4d3b-8cf0-d0c4b2630fd9
0feac28c-4cec-4bd9-acc1-c3dd467d024b	ca9e1371-5fc6-4f06-8d96-969166325cd0
07110cdd-3302-4d19-83a0-b7f19e4491c5	37ee9488-bbc3-488a-bf96-0e203359b09a
07110cdd-3302-4d19-83a0-b7f19e4491c5	4fdee01a-4128-4b76-9569-bc932d78f329
4fdee01a-4128-4b76-9569-bc932d78f329	a088e022-c766-4c2d-9294-2bce838e4963
ec96db8c-cd81-4074-b00d-2c87154ba6be	8afcdb13-9c9e-4310-bc11-7ca7fd504633
5c705864-595d-4ccf-8c3d-8747a5b3e31c	26589b9d-fa49-481b-ad52-dc883ad929f9
07110cdd-3302-4d19-83a0-b7f19e4491c5	aafabcb8-344e-4694-b610-423530804506
07110cdd-3302-4d19-83a0-b7f19e4491c5	275b9e07-3582-4c2b-80c4-23a7cd4931bc
5c705864-595d-4ccf-8c3d-8747a5b3e31c	6eccf5bc-0ced-4a03-9432-3ecaebe29964
5c705864-595d-4ccf-8c3d-8747a5b3e31c	2635fbea-9393-44c9-ad9d-3785ccca026d
5c705864-595d-4ccf-8c3d-8747a5b3e31c	c06fef31-c71b-402c-bb69-465128a9b007
5c705864-595d-4ccf-8c3d-8747a5b3e31c	658c32c6-bc6e-4e46-b656-1fff86a61408
5c705864-595d-4ccf-8c3d-8747a5b3e31c	80fe7da1-df3e-4d02-85f2-1ff7818bfb05
5c705864-595d-4ccf-8c3d-8747a5b3e31c	62309425-1214-4cb2-ac5b-0120130080d2
5c705864-595d-4ccf-8c3d-8747a5b3e31c	d479803e-e5e2-49da-baf2-48ad5278a03f
5c705864-595d-4ccf-8c3d-8747a5b3e31c	14a72e2c-4e43-44db-802f-ef3293efece7
5c705864-595d-4ccf-8c3d-8747a5b3e31c	a8fbd9c3-577c-4d4e-bdf1-d1a57b95e483
5c705864-595d-4ccf-8c3d-8747a5b3e31c	afbc0728-d735-4c20-8eb9-194882f5deea
5c705864-595d-4ccf-8c3d-8747a5b3e31c	6deb3d6f-c11f-4f2c-b359-baa5ed5c0b8f
5c705864-595d-4ccf-8c3d-8747a5b3e31c	d3c0cb26-8bdd-488b-8b4b-a9249a6e2553
5c705864-595d-4ccf-8c3d-8747a5b3e31c	e7943001-d1a2-4bb9-aafe-3bbf407a0e0f
5c705864-595d-4ccf-8c3d-8747a5b3e31c	19c53a4d-1ebb-449b-a3a2-de77eeea11a9
5c705864-595d-4ccf-8c3d-8747a5b3e31c	0ad76d37-6ee3-4060-805a-861a46407a4a
5c705864-595d-4ccf-8c3d-8747a5b3e31c	21082e82-63fb-483e-8f38-771dc4e8c427
5c705864-595d-4ccf-8c3d-8747a5b3e31c	55032fff-90f6-42be-aaaf-1420fa002920
658c32c6-bc6e-4e46-b656-1fff86a61408	0ad76d37-6ee3-4060-805a-861a46407a4a
c06fef31-c71b-402c-bb69-465128a9b007	19c53a4d-1ebb-449b-a3a2-de77eeea11a9
c06fef31-c71b-402c-bb69-465128a9b007	55032fff-90f6-42be-aaaf-1420fa002920
e01bd37d-bab8-460f-b513-2b66b76d341a	e567197f-d6e1-4f35-9d67-d56a18f7ced5
e01bd37d-bab8-460f-b513-2b66b76d341a	b1b9a155-8134-43db-a3ec-81f32052bd9d
e01bd37d-bab8-460f-b513-2b66b76d341a	d2750b96-57bd-446e-bec9-1c53eeaf89c2
e01bd37d-bab8-460f-b513-2b66b76d341a	2814f8ec-23e6-451b-bea6-ef0e01124ac9
e01bd37d-bab8-460f-b513-2b66b76d341a	51616165-aa0b-439d-bfd7-549485568f8d
e01bd37d-bab8-460f-b513-2b66b76d341a	6c42f910-9bec-468b-b411-f91ff4176f76
e01bd37d-bab8-460f-b513-2b66b76d341a	9b82cd1c-6308-4ac9-8e6d-1aaa02b4cdbe
e01bd37d-bab8-460f-b513-2b66b76d341a	01bba654-7a59-414f-aba1-e6b68d042327
e01bd37d-bab8-460f-b513-2b66b76d341a	5546ff7b-7dbb-4d10-ad3d-a4a40533222f
e01bd37d-bab8-460f-b513-2b66b76d341a	92af9227-b1dd-453c-9592-594458bf378c
e01bd37d-bab8-460f-b513-2b66b76d341a	16c6fee0-2d05-435d-babd-f6c2ab4f3fa6
e01bd37d-bab8-460f-b513-2b66b76d341a	d5fca5fe-d98d-44bb-b5fb-5b378a822694
e01bd37d-bab8-460f-b513-2b66b76d341a	141ca221-197b-4a08-9f37-c35795f5fe9d
e01bd37d-bab8-460f-b513-2b66b76d341a	14f83dad-107d-42ad-bf14-930961bb0e27
e01bd37d-bab8-460f-b513-2b66b76d341a	c8fce70f-a190-4a46-acca-98a521724ecf
e01bd37d-bab8-460f-b513-2b66b76d341a	329017fb-175a-4aed-8705-a7f6472f6952
e01bd37d-bab8-460f-b513-2b66b76d341a	59bf26cd-4af9-4324-a677-4025bb705998
2814f8ec-23e6-451b-bea6-ef0e01124ac9	c8fce70f-a190-4a46-acca-98a521724ecf
d2750b96-57bd-446e-bec9-1c53eeaf89c2	14f83dad-107d-42ad-bf14-930961bb0e27
d2750b96-57bd-446e-bec9-1c53eeaf89c2	59bf26cd-4af9-4324-a677-4025bb705998
5b352f3b-42ad-4b08-9521-89bc7e06fc9c	5317fe48-5034-47fc-8793-15651c700d04
5b352f3b-42ad-4b08-9521-89bc7e06fc9c	dbda7341-2bff-48b9-8a9d-407cbfca0e3a
dbda7341-2bff-48b9-8a9d-407cbfca0e3a	a580aa3e-60bf-4d98-b916-0d408591bf73
9cba1b57-0ef7-4666-960c-566616270754	b497aa16-e0ac-45a1-910f-3484a8fc9e94
5c705864-595d-4ccf-8c3d-8747a5b3e31c	b7139850-6677-4094-a6bd-ed723d09ebce
e01bd37d-bab8-460f-b513-2b66b76d341a	fd52976d-c2fe-4636-839c-b807ee318d23
5b352f3b-42ad-4b08-9521-89bc7e06fc9c	2199e0b0-af34-4d4f-9086-9a080a1c60f8
5b352f3b-42ad-4b08-9521-89bc7e06fc9c	411d3a51-c160-4741-b6cb-a0232d04d4ac
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
683f0454-d337-4b98-bb14-075558de0748	\N	password	92fb3609-a1d9-467d-be6f-ee0f0de2eba3	1681958357478	\N	{"value":"08BlPI4jmrwVFhF/AGm/9dU59S9XHtphhIJByTNMbX+oUfe0dOfVy7Fwv0DSmFNHgzfx7SavHyog2uVSDGRSaQ==","salt":"Sc3lO5/FchUF/vqtVw+1zg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
09ffb4d8-4465-42b5-bae2-d8c5f9467fcb	\N	password	7c0f4961-1ae7-415a-af0b-b10f1537cabf	1681959214511	\N	{"value":"85hPc4l+LXJENtqObsxpyP0v8GXkLOcPw+uPMhUFQ2zYmXiyYJZerjuC91ZQEpYOZLidHIBG8BWmibQQTH9iMg==","salt":"37EpH7DVn4fUWhhAMZ1xug==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-04-20 02:29:36.107463	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	DEV	\N	\N	1957775818
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-04-20 02:29:36.115474	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	DEV	\N	\N	1957775818
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-04-20 02:29:36.150283	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	DEV	\N	\N	1957775818
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-04-20 02:29:36.153678	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	DEV	\N	\N	1957775818
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-04-20 02:29:36.245042	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	DEV	\N	\N	1957775818
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-04-20 02:29:36.253339	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	DEV	\N	\N	1957775818
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-04-20 02:29:36.39831	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	DEV	\N	\N	1957775818
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-04-20 02:29:36.402765	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	DEV	\N	\N	1957775818
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-04-20 02:29:36.40997	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	DEV	\N	\N	1957775818
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-04-20 02:29:36.497022	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	DEV	\N	\N	1957775818
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-04-20 02:29:36.540843	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	1957775818
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-04-20 02:29:36.542871	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	1957775818
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-04-20 02:29:36.568803	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	1957775818
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-04-20 02:29:36.585379	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	DEV	\N	\N	1957775818
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-04-20 02:29:36.588062	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	1957775818
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-04-20 02:29:36.590143	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	DEV	\N	\N	1957775818
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-04-20 02:29:36.592947	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	DEV	\N	\N	1957775818
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-04-20 02:29:36.630551	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	DEV	\N	\N	1957775818
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-04-20 02:29:36.669579	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	DEV	\N	\N	1957775818
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-04-20 02:29:36.675063	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	DEV	\N	\N	1957775818
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-04-20 02:29:37.566767	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	DEV	\N	\N	1957775818
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-04-20 02:29:36.677388	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	DEV	\N	\N	1957775818
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-04-20 02:29:36.681331	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	DEV	\N	\N	1957775818
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-04-20 02:29:36.750783	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	DEV	\N	\N	1957775818
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-04-20 02:29:36.755365	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	DEV	\N	\N	1957775818
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-04-20 02:29:36.757155	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	DEV	\N	\N	1957775818
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-04-20 02:29:36.882639	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	DEV	\N	\N	1957775818
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-04-20 02:29:36.955425	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	DEV	\N	\N	1957775818
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-04-20 02:29:36.958941	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	DEV	\N	\N	1957775818
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-04-20 02:29:37.042133	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	DEV	\N	\N	1957775818
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-04-20 02:29:37.057106	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	DEV	\N	\N	1957775818
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-04-20 02:29:37.079919	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	DEV	\N	\N	1957775818
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-04-20 02:29:37.087324	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	DEV	\N	\N	1957775818
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-04-20 02:29:37.093944	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	1957775818
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-04-20 02:29:37.097129	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	DEV	\N	\N	1957775818
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-04-20 02:29:37.121545	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	DEV	\N	\N	1957775818
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-04-20 02:29:37.124384	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	DEV	\N	\N	1957775818
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-04-20 02:29:37.128001	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	1957775818
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-04-20 02:29:37.130276	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	DEV	\N	\N	1957775818
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-04-20 02:29:37.132506	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	DEV	\N	\N	1957775818
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-04-20 02:29:37.133694	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	DEV	\N	\N	1957775818
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-04-20 02:29:37.134906	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	DEV	\N	\N	1957775818
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-04-20 02:29:37.137496	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	DEV	\N	\N	1957775818
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-04-20 02:29:37.556873	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	DEV	\N	\N	1957775818
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-04-20 02:29:37.55997	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	DEV	\N	\N	1957775818
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-04-20 02:29:37.562772	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	DEV	\N	\N	1957775818
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-04-20 02:29:37.568441	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	DEV	\N	\N	1957775818
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-04-20 02:29:37.621629	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	DEV	\N	\N	1957775818
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-04-20 02:29:37.625064	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	DEV	\N	\N	1957775818
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-04-20 02:29:37.656725	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	DEV	\N	\N	1957775818
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-04-20 02:29:37.774209	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	DEV	\N	\N	1957775818
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-04-20 02:29:37.777174	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	1957775818
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-04-20 02:29:37.779264	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	DEV	\N	\N	1957775818
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-04-20 02:29:37.781305	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	DEV	\N	\N	1957775818
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-04-20 02:29:37.786038	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	DEV	\N	\N	1957775818
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-04-20 02:29:37.790199	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	DEV	\N	\N	1957775818
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-04-20 02:29:37.815492	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	DEV	\N	\N	1957775818
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-04-20 02:29:37.943252	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	DEV	\N	\N	1957775818
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-04-20 02:29:37.959593	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	DEV	\N	\N	1957775818
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-04-20 02:29:37.963408	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	DEV	\N	\N	1957775818
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-04-20 02:29:37.968144	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	DEV	\N	\N	1957775818
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-04-20 02:29:37.971446	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	DEV	\N	\N	1957775818
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-04-20 02:29:37.973517	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	DEV	\N	\N	1957775818
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-04-20 02:29:37.975237	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	DEV	\N	\N	1957775818
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-04-20 02:29:37.976811	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	DEV	\N	\N	1957775818
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-04-20 02:29:37.989296	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	DEV	\N	\N	1957775818
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-04-20 02:29:37.997147	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	DEV	\N	\N	1957775818
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-04-20 02:29:37.999773	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	DEV	\N	\N	1957775818
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-04-20 02:29:38.011996	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	DEV	\N	\N	1957775818
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-04-20 02:29:38.015384	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	DEV	\N	\N	1957775818
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-04-20 02:29:38.017946	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	DEV	\N	\N	1957775818
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-04-20 02:29:38.021862	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	1957775818
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-04-20 02:29:38.02576	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	1957775818
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-04-20 02:29:38.027025	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	1957775818
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-04-20 02:29:38.038513	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	DEV	\N	\N	1957775818
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-04-20 02:29:38.049327	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	DEV	\N	\N	1957775818
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-04-20 02:29:38.052148	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	DEV	\N	\N	1957775818
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-04-20 02:29:38.053459	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	DEV	\N	\N	1957775818
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-04-20 02:29:38.068074	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	DEV	\N	\N	1957775818
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-04-20 02:29:38.06961	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	DEV	\N	\N	1957775818
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-04-20 02:29:38.079266	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	DEV	\N	\N	1957775818
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-04-20 02:29:38.080616	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	1957775818
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-04-20 02:29:38.083547	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	1957775818
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-04-20 02:29:38.084951	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	1957775818
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-04-20 02:29:38.094404	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	DEV	\N	\N	1957775818
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-04-20 02:29:38.098456	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	DEV	\N	\N	1957775818
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-04-20 02:29:38.104552	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	DEV	\N	\N	1957775818
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-04-20 02:29:38.110751	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	DEV	\N	\N	1957775818
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.115068	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	DEV	\N	\N	1957775818
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.11997	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	DEV	\N	\N	1957775818
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.128305	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	1957775818
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.133644	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	DEV	\N	\N	1957775818
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.134858	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	DEV	\N	\N	1957775818
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.141533	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	DEV	\N	\N	1957775818
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.142898	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	DEV	\N	\N	1957775818
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-04-20 02:29:38.146219	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	DEV	\N	\N	1957775818
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-04-20 02:29:38.167885	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	1957775818
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-04-20 02:29:38.169104	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	1957775818
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-04-20 02:29:38.17372	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	1957775818
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-04-20 02:29:38.182314	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	1957775818
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-04-20 02:29:38.18378	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	1957775818
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-04-20 02:29:38.193678	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	DEV	\N	\N	1957775818
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-04-20 02:29:38.196635	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	DEV	\N	\N	1957775818
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-04-20 02:29:38.200665	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	DEV	\N	\N	1957775818
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-04-20 02:29:38.210852	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	DEV	\N	\N	1957775818
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-04-20 02:29:38.221138	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	DEV	\N	\N	1957775818
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
b99b93ee-5ff5-4ecb-8266-0936b60d8371	56c2acda-4af7-4da0-8a59-a989d8a928b3	f
b99b93ee-5ff5-4ecb-8266-0936b60d8371	c73aa77d-9113-435b-822c-b1a3daf0e59e	t
b99b93ee-5ff5-4ecb-8266-0936b60d8371	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6	t
b99b93ee-5ff5-4ecb-8266-0936b60d8371	d607cefb-c308-40a4-8c8d-59225580ddd4	t
b99b93ee-5ff5-4ecb-8266-0936b60d8371	86faea84-1d76-42d5-8463-9236355eb860	f
b99b93ee-5ff5-4ecb-8266-0936b60d8371	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45	f
b99b93ee-5ff5-4ecb-8266-0936b60d8371	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6	t
b99b93ee-5ff5-4ecb-8266-0936b60d8371	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba	t
b99b93ee-5ff5-4ecb-8266-0936b60d8371	a3ad611d-b4a5-4679-9cbd-30705553e507	f
b99b93ee-5ff5-4ecb-8266-0936b60d8371	1f7cdc9c-2983-4781-8efa-ffd5e8f96996	t
eai-poc	088009a1-f3c0-4a6c-ac99-96a711fd9301	f
eai-poc	33b77b7a-288d-4683-a3fb-f7a931666916	t
eai-poc	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6	t
eai-poc	ceaec65c-e507-4a3b-bd39-1c414a12d9a9	t
eai-poc	20211f01-cb57-4e07-ab24-227de7c1752e	f
eai-poc	56071c97-8010-4871-90c2-0d4dcf5ef64b	f
eai-poc	857e5858-4bcb-4f75-af79-6ade599013f1	t
eai-poc	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc	t
eai-poc	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a	f
eai-poc	3d3ace4f-dad8-4728-8b0f-9c43522a4deb	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
07110cdd-3302-4d19-83a0-b7f19e4491c5	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f	${role_default-roles}	default-roles-master	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N	\N
5c705864-595d-4ccf-8c3d-8747a5b3e31c	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f	${role_admin}	admin	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N	\N
c4210c8e-49c8-4481-aa74-bb68c8c5850b	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f	${role_create-realm}	create-realm	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N	\N
4c26d14a-6421-467b-80b1-e6d488ae2860	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_create-client}	create-client	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
b6810eaa-963c-42bb-85ef-3ff74bcf4b66	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_view-realm}	view-realm	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
0feac28c-4cec-4bd9-acc1-c3dd467d024b	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_view-users}	view-users	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
bdce686b-0e54-4b29-990e-7be7394b339b	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_view-clients}	view-clients	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
7a3f713c-f24e-4722-8250-318ea5c0d06a	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_view-events}	view-events	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
fb475401-e8ff-493d-8227-20930ba65d8f	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_view-identity-providers}	view-identity-providers	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
b5b8574d-dcc2-4e5b-8437-80dc08b0755d	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_view-authorization}	view-authorization	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
9a64d3ea-952e-4723-ada0-bc714c9eca28	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_manage-realm}	manage-realm	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
29046464-c751-49bb-8ed6-cffc6bf51cc0	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_manage-users}	manage-users	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
e0de3301-23bb-4420-8073-91326f42d698	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_manage-clients}	manage-clients	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
dc2f62ba-8140-4184-96e5-e03c384227eb	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_manage-events}	manage-events	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
265febda-8e8a-4f5d-904b-cec0cecc3c99	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_manage-identity-providers}	manage-identity-providers	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
f4fd8905-753f-496b-aec5-18fbd9003f1a	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_manage-authorization}	manage-authorization	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
01ef1216-cc74-4d3b-8cf0-d0c4b2630fd9	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_query-users}	query-users	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
92681917-3bdf-42af-875f-91a344bec671	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_query-clients}	query-clients	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
907284ea-6f32-4396-99a2-fe0aaa5a8492	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_query-realms}	query-realms	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
ca9e1371-5fc6-4f06-8d96-969166325cd0	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_query-groups}	query-groups	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
37ee9488-bbc3-488a-bf96-0e203359b09a	f6690ccd-463d-49cd-a8cb-1110d45061cd	t	${role_view-profile}	view-profile	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f6690ccd-463d-49cd-a8cb-1110d45061cd	\N
4fdee01a-4128-4b76-9569-bc932d78f329	f6690ccd-463d-49cd-a8cb-1110d45061cd	t	${role_manage-account}	manage-account	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f6690ccd-463d-49cd-a8cb-1110d45061cd	\N
a088e022-c766-4c2d-9294-2bce838e4963	f6690ccd-463d-49cd-a8cb-1110d45061cd	t	${role_manage-account-links}	manage-account-links	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f6690ccd-463d-49cd-a8cb-1110d45061cd	\N
0be3b8bd-240c-4b86-aab2-cd0d1b2c2aeb	f6690ccd-463d-49cd-a8cb-1110d45061cd	t	${role_view-applications}	view-applications	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f6690ccd-463d-49cd-a8cb-1110d45061cd	\N
8afcdb13-9c9e-4310-bc11-7ca7fd504633	f6690ccd-463d-49cd-a8cb-1110d45061cd	t	${role_view-consent}	view-consent	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f6690ccd-463d-49cd-a8cb-1110d45061cd	\N
ec96db8c-cd81-4074-b00d-2c87154ba6be	f6690ccd-463d-49cd-a8cb-1110d45061cd	t	${role_manage-consent}	manage-consent	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f6690ccd-463d-49cd-a8cb-1110d45061cd	\N
4b6dd681-2f93-49a4-b76b-5f5836e2685a	f6690ccd-463d-49cd-a8cb-1110d45061cd	t	${role_delete-account}	delete-account	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f6690ccd-463d-49cd-a8cb-1110d45061cd	\N
0db72680-80c1-451b-9ccc-8499c9ab861e	9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	t	${role_read-token}	read-token	b99b93ee-5ff5-4ecb-8266-0936b60d8371	9ae6d4be-d8c8-4a68-ba5e-8e5e1d8925e5	\N
26589b9d-fa49-481b-ad52-dc883ad929f9	c0293e7d-5594-44fe-a28a-8265232d7e20	t	${role_impersonation}	impersonation	b99b93ee-5ff5-4ecb-8266-0936b60d8371	c0293e7d-5594-44fe-a28a-8265232d7e20	\N
aafabcb8-344e-4694-b610-423530804506	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f	${role_offline-access}	offline_access	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N	\N
275b9e07-3582-4c2b-80c4-23a7cd4931bc	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f	${role_uma_authorization}	uma_authorization	b99b93ee-5ff5-4ecb-8266-0936b60d8371	\N	\N
5b352f3b-42ad-4b08-9521-89bc7e06fc9c	eai-poc	f	${role_default-roles}	default-roles-eai-poc	eai-poc	\N	\N
6eccf5bc-0ced-4a03-9432-3ecaebe29964	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_create-client}	create-client	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
2635fbea-9393-44c9-ad9d-3785ccca026d	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_view-realm}	view-realm	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
c06fef31-c71b-402c-bb69-465128a9b007	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_view-users}	view-users	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
658c32c6-bc6e-4e46-b656-1fff86a61408	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_view-clients}	view-clients	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
80fe7da1-df3e-4d02-85f2-1ff7818bfb05	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_view-events}	view-events	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
62309425-1214-4cb2-ac5b-0120130080d2	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_view-identity-providers}	view-identity-providers	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
d479803e-e5e2-49da-baf2-48ad5278a03f	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_view-authorization}	view-authorization	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
14a72e2c-4e43-44db-802f-ef3293efece7	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_manage-realm}	manage-realm	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
a8fbd9c3-577c-4d4e-bdf1-d1a57b95e483	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_manage-users}	manage-users	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
afbc0728-d735-4c20-8eb9-194882f5deea	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_manage-clients}	manage-clients	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
6deb3d6f-c11f-4f2c-b359-baa5ed5c0b8f	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_manage-events}	manage-events	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
d3c0cb26-8bdd-488b-8b4b-a9249a6e2553	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_manage-identity-providers}	manage-identity-providers	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
e7943001-d1a2-4bb9-aafe-3bbf407a0e0f	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_manage-authorization}	manage-authorization	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
19c53a4d-1ebb-449b-a3a2-de77eeea11a9	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_query-users}	query-users	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
0ad76d37-6ee3-4060-805a-861a46407a4a	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_query-clients}	query-clients	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
21082e82-63fb-483e-8f38-771dc4e8c427	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_query-realms}	query-realms	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
55032fff-90f6-42be-aaaf-1420fa002920	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_query-groups}	query-groups	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
e01bd37d-bab8-460f-b513-2b66b76d341a	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_realm-admin}	realm-admin	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
e567197f-d6e1-4f35-9d67-d56a18f7ced5	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_create-client}	create-client	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
b1b9a155-8134-43db-a3ec-81f32052bd9d	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_view-realm}	view-realm	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
d2750b96-57bd-446e-bec9-1c53eeaf89c2	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_view-users}	view-users	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
2814f8ec-23e6-451b-bea6-ef0e01124ac9	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_view-clients}	view-clients	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
51616165-aa0b-439d-bfd7-549485568f8d	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_view-events}	view-events	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
6c42f910-9bec-468b-b411-f91ff4176f76	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_view-identity-providers}	view-identity-providers	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
9b82cd1c-6308-4ac9-8e6d-1aaa02b4cdbe	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_view-authorization}	view-authorization	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
01bba654-7a59-414f-aba1-e6b68d042327	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_manage-realm}	manage-realm	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
5546ff7b-7dbb-4d10-ad3d-a4a40533222f	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_manage-users}	manage-users	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
92af9227-b1dd-453c-9592-594458bf378c	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_manage-clients}	manage-clients	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
16c6fee0-2d05-435d-babd-f6c2ab4f3fa6	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_manage-events}	manage-events	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
d5fca5fe-d98d-44bb-b5fb-5b378a822694	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_manage-identity-providers}	manage-identity-providers	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
141ca221-197b-4a08-9f37-c35795f5fe9d	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_manage-authorization}	manage-authorization	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
14f83dad-107d-42ad-bf14-930961bb0e27	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_query-users}	query-users	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
c8fce70f-a190-4a46-acca-98a521724ecf	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_query-clients}	query-clients	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
329017fb-175a-4aed-8705-a7f6472f6952	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_query-realms}	query-realms	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
59bf26cd-4af9-4324-a677-4025bb705998	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_query-groups}	query-groups	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
5317fe48-5034-47fc-8793-15651c700d04	806ff684-b7b4-461a-b71c-fb67bfa86672	t	${role_view-profile}	view-profile	eai-poc	806ff684-b7b4-461a-b71c-fb67bfa86672	\N
dbda7341-2bff-48b9-8a9d-407cbfca0e3a	806ff684-b7b4-461a-b71c-fb67bfa86672	t	${role_manage-account}	manage-account	eai-poc	806ff684-b7b4-461a-b71c-fb67bfa86672	\N
a580aa3e-60bf-4d98-b916-0d408591bf73	806ff684-b7b4-461a-b71c-fb67bfa86672	t	${role_manage-account-links}	manage-account-links	eai-poc	806ff684-b7b4-461a-b71c-fb67bfa86672	\N
4268aa3b-e36b-42c5-923a-ecbc385780a8	806ff684-b7b4-461a-b71c-fb67bfa86672	t	${role_view-applications}	view-applications	eai-poc	806ff684-b7b4-461a-b71c-fb67bfa86672	\N
b497aa16-e0ac-45a1-910f-3484a8fc9e94	806ff684-b7b4-461a-b71c-fb67bfa86672	t	${role_view-consent}	view-consent	eai-poc	806ff684-b7b4-461a-b71c-fb67bfa86672	\N
9cba1b57-0ef7-4666-960c-566616270754	806ff684-b7b4-461a-b71c-fb67bfa86672	t	${role_manage-consent}	manage-consent	eai-poc	806ff684-b7b4-461a-b71c-fb67bfa86672	\N
3aea879a-a258-4dd0-b79a-8d063901ae1e	806ff684-b7b4-461a-b71c-fb67bfa86672	t	${role_delete-account}	delete-account	eai-poc	806ff684-b7b4-461a-b71c-fb67bfa86672	\N
b7139850-6677-4094-a6bd-ed723d09ebce	86df04cd-3eac-4183-a69c-50ca8807c310	t	${role_impersonation}	impersonation	b99b93ee-5ff5-4ecb-8266-0936b60d8371	86df04cd-3eac-4183-a69c-50ca8807c310	\N
fd52976d-c2fe-4636-839c-b807ee318d23	b3a61bec-042d-49f7-a585-f997585e7f87	t	${role_impersonation}	impersonation	eai-poc	b3a61bec-042d-49f7-a585-f997585e7f87	\N
49130c81-b985-4822-ba55-9f5fe2f44320	6385ab1a-0f26-486d-a0ba-5f4812405fd5	t	${role_read-token}	read-token	eai-poc	6385ab1a-0f26-486d-a0ba-5f4812405fd5	\N
2199e0b0-af34-4d4f-9086-9a080a1c60f8	eai-poc	f	${role_offline-access}	offline_access	eai-poc	\N	\N
411d3a51-c160-4741-b6cb-a0232d04d4ac	eai-poc	f	${role_uma_authorization}	uma_authorization	eai-poc	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.migration_model (id, version, update_time) FROM stdin;
129p3	18.0.0	1681957780
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
2b077706-e175-4155-a895-2bae517c1cd8	audience resolve	openid-connect	oidc-audience-resolve-mapper	d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	\N
e22b4408-dcf0-4c88-aa83-cf7952dc27f7	locale	openid-connect	oidc-usermodel-attribute-mapper	840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	\N
a5f255f7-6737-4f6e-9302-71602345bd9f	role list	saml	saml-role-list-mapper	\N	c73aa77d-9113-435b-822c-b1a3daf0e59e
c0be98d5-4776-4d84-8edc-ba2616688d7b	full name	openid-connect	oidc-full-name-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
d41622c8-c837-4415-8c01-d11d25297800	family name	openid-connect	oidc-usermodel-property-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
b26cd924-7094-4366-a9a7-878091e56d0f	given name	openid-connect	oidc-usermodel-property-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
2912ffd0-7b43-4536-abd4-dbf66e661ef1	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
f30bf8b7-af36-413d-bd53-0beae639cc37	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
3131d9c5-fc05-42a7-925b-5d66aa149431	username	openid-connect	oidc-usermodel-property-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
2503a693-9b0d-4fef-9791-d20cd53b0699	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
d7ecc27f-955d-4249-a88c-8230c467aa17	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
0ff360d6-42b7-432b-9ab6-d64964796878	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
69f74cce-fbb7-4d16-8eec-c41c9eabd68d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
8dffbef0-c256-425a-9d07-2341ef882cc2	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
8d67429b-98c1-4862-ac0f-28f8aca51edf	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
531d8c39-7750-4bfa-a794-87e04d867bb5	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
aacdffa1-9cec-4bb6-adf3-28eb9f2a65b7	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d8fdfc65-c78c-4ac6-be4b-897e7b6b41b6
f5d0ef67-38c5-4fb4-8ba9-3670f6e12077	email	openid-connect	oidc-usermodel-property-mapper	\N	d607cefb-c308-40a4-8c8d-59225580ddd4
b523ef53-13d8-4df1-bbe1-b603677194ab	email verified	openid-connect	oidc-usermodel-property-mapper	\N	d607cefb-c308-40a4-8c8d-59225580ddd4
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	address	openid-connect	oidc-address-mapper	\N	86faea84-1d76-42d5-8463-9236355eb860
7a7cc902-b92d-428c-894f-2aad2e547e2f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45
cdf3cab3-044a-4874-bddc-9ab210fff1db	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	04e7fc2c-9343-4dae-8c2f-9aabc49d2d45
c78aefaf-d734-43b1-8999-0e11b894ad44	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6
2b6db843-aeba-48ea-9b6d-11b8d114e117	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6
77f7467e-1cbe-4d1e-bb70-ad15c4f364d1	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	cd02a4f9-2e9c-4a2e-acb6-f12276e40ca6
385af14a-15fd-4b30-8cc4-092269facb08	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8c2451ba-b744-49cf-9e8b-bf4bd14fc5ba
733598e1-613a-4289-bb24-792588fad454	upn	openid-connect	oidc-usermodel-property-mapper	\N	a3ad611d-b4a5-4679-9cbd-30705553e507
568d9cf1-8d4e-49b6-aa6d-d4536562fcea	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a3ad611d-b4a5-4679-9cbd-30705553e507
68bffe0a-ac5c-4931-9239-fca903d9635a	acr loa level	openid-connect	oidc-acr-mapper	\N	1f7cdc9c-2983-4781-8efa-ffd5e8f96996
66957c98-00fa-493d-b244-2888ae5ba4ed	audience resolve	openid-connect	oidc-audience-resolve-mapper	4b9598f5-d742-461b-b70c-408b224e0792	\N
f4a2f0c7-a4fb-4d96-927e-6ec8f5f8d8bc	role list	saml	saml-role-list-mapper	\N	33b77b7a-288d-4683-a3fb-f7a931666916
0329f5cd-182e-464b-90e4-cd682098661c	full name	openid-connect	oidc-full-name-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
2ed08f9a-20a0-4768-8506-f33ec29281cc	family name	openid-connect	oidc-usermodel-property-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
712d81b0-788e-4f03-bf71-84965feef239	given name	openid-connect	oidc-usermodel-property-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
8fb93504-b159-4eab-9b29-8869f9187f98	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
85610e0d-3af3-4c13-a21c-348ba2482a4e	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
fe86a6c2-868c-4be3-b8f2-41ae0c0cac27	username	openid-connect	oidc-usermodel-property-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
e5398ab3-a44d-4a43-a347-75ef412620b9	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
222f24e7-f580-43d6-b097-7c6380906203	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
8d801f57-444e-4d5a-8d5e-95064ce31340	website	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
926d4fea-3783-4f75-b6d8-2cfd99c420d3	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
7dcd0137-84ab-414b-b128-fbf7474a5cc1	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
338a72c9-0b29-4de3-81ea-5219d8ecf33a	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
5253a4a9-e2a6-4a6b-949b-73f0d7593b8b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
e48a1ed3-4aa4-4bd4-9f42-ab62b55a9c77	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	cc76cbcc-ab8c-4b67-9ef5-eabdcad3eca6
7b8007bf-1c20-4800-a547-0651bee72193	email	openid-connect	oidc-usermodel-property-mapper	\N	ceaec65c-e507-4a3b-bd39-1c414a12d9a9
fabf1d9f-de9f-4c82-aea2-6affa4746d96	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ceaec65c-e507-4a3b-bd39-1c414a12d9a9
fb855c08-ab87-471d-aa3f-12e089fa02fe	address	openid-connect	oidc-address-mapper	\N	20211f01-cb57-4e07-ab24-227de7c1752e
d9de9d2b-2b11-4097-9a78-b2b1e89a42c7	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	56071c97-8010-4871-90c2-0d4dcf5ef64b
181b9f1d-28b4-499a-89e3-bbed466fb9ef	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	56071c97-8010-4871-90c2-0d4dcf5ef64b
23c42587-5341-49f0-8f10-22a326474473	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	857e5858-4bcb-4f75-af79-6ade599013f1
893dfb6f-0727-4da1-b662-6fb532cd7f65	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	857e5858-4bcb-4f75-af79-6ade599013f1
4d8960ad-9e65-4cd4-bc79-214baddab065	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	857e5858-4bcb-4f75-af79-6ade599013f1
4d5d3070-9c71-4771-8b99-801efafdf938	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	ee3b8e52-cc1b-4ddf-ae6f-5c4d886d1bdc
c4665e42-dc4d-4748-91ba-7918c5043bec	upn	openid-connect	oidc-usermodel-property-mapper	\N	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a
4fff4141-0d93-4f0c-80e4-e024e02ef611	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3fcd29cb-99ba-4e94-8ba9-6db84e54c87a
af52a5b5-e81f-4d05-bb6a-0103fdca5f8f	acr loa level	openid-connect	oidc-acr-mapper	\N	3d3ace4f-dad8-4728-8b0f-9c43522a4deb
fb08a762-60ab-4c93-aad0-87782705f83c	locale	openid-connect	oidc-usermodel-attribute-mapper	74274da6-0aa6-4cf2-9b71-d4826f4da212	\N
7f3b90f2-cfd4-4266-8863-56d04a809da2	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	fcec3dd8-531f-4989-869a-1e361cf2e629	\N
624a86cc-fa01-4260-9793-ad9cea0ae395	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	fcec3dd8-531f-4989-869a-1e361cf2e629	\N
dafb7075-3570-4b48-83e2-73c300d9b4e7	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	fcec3dd8-531f-4989-869a-1e361cf2e629	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
e22b4408-dcf0-4c88-aa83-cf7952dc27f7	true	userinfo.token.claim
e22b4408-dcf0-4c88-aa83-cf7952dc27f7	locale	user.attribute
e22b4408-dcf0-4c88-aa83-cf7952dc27f7	true	id.token.claim
e22b4408-dcf0-4c88-aa83-cf7952dc27f7	true	access.token.claim
e22b4408-dcf0-4c88-aa83-cf7952dc27f7	locale	claim.name
e22b4408-dcf0-4c88-aa83-cf7952dc27f7	String	jsonType.label
a5f255f7-6737-4f6e-9302-71602345bd9f	false	single
a5f255f7-6737-4f6e-9302-71602345bd9f	Basic	attribute.nameformat
a5f255f7-6737-4f6e-9302-71602345bd9f	Role	attribute.name
c0be98d5-4776-4d84-8edc-ba2616688d7b	true	userinfo.token.claim
c0be98d5-4776-4d84-8edc-ba2616688d7b	true	id.token.claim
c0be98d5-4776-4d84-8edc-ba2616688d7b	true	access.token.claim
d41622c8-c837-4415-8c01-d11d25297800	true	userinfo.token.claim
d41622c8-c837-4415-8c01-d11d25297800	lastName	user.attribute
d41622c8-c837-4415-8c01-d11d25297800	true	id.token.claim
d41622c8-c837-4415-8c01-d11d25297800	true	access.token.claim
d41622c8-c837-4415-8c01-d11d25297800	family_name	claim.name
d41622c8-c837-4415-8c01-d11d25297800	String	jsonType.label
b26cd924-7094-4366-a9a7-878091e56d0f	true	userinfo.token.claim
b26cd924-7094-4366-a9a7-878091e56d0f	firstName	user.attribute
b26cd924-7094-4366-a9a7-878091e56d0f	true	id.token.claim
b26cd924-7094-4366-a9a7-878091e56d0f	true	access.token.claim
b26cd924-7094-4366-a9a7-878091e56d0f	given_name	claim.name
b26cd924-7094-4366-a9a7-878091e56d0f	String	jsonType.label
2912ffd0-7b43-4536-abd4-dbf66e661ef1	true	userinfo.token.claim
2912ffd0-7b43-4536-abd4-dbf66e661ef1	middleName	user.attribute
2912ffd0-7b43-4536-abd4-dbf66e661ef1	true	id.token.claim
2912ffd0-7b43-4536-abd4-dbf66e661ef1	true	access.token.claim
2912ffd0-7b43-4536-abd4-dbf66e661ef1	middle_name	claim.name
2912ffd0-7b43-4536-abd4-dbf66e661ef1	String	jsonType.label
f30bf8b7-af36-413d-bd53-0beae639cc37	true	userinfo.token.claim
f30bf8b7-af36-413d-bd53-0beae639cc37	nickname	user.attribute
f30bf8b7-af36-413d-bd53-0beae639cc37	true	id.token.claim
f30bf8b7-af36-413d-bd53-0beae639cc37	true	access.token.claim
f30bf8b7-af36-413d-bd53-0beae639cc37	nickname	claim.name
f30bf8b7-af36-413d-bd53-0beae639cc37	String	jsonType.label
3131d9c5-fc05-42a7-925b-5d66aa149431	true	userinfo.token.claim
3131d9c5-fc05-42a7-925b-5d66aa149431	username	user.attribute
3131d9c5-fc05-42a7-925b-5d66aa149431	true	id.token.claim
3131d9c5-fc05-42a7-925b-5d66aa149431	true	access.token.claim
3131d9c5-fc05-42a7-925b-5d66aa149431	preferred_username	claim.name
3131d9c5-fc05-42a7-925b-5d66aa149431	String	jsonType.label
2503a693-9b0d-4fef-9791-d20cd53b0699	true	userinfo.token.claim
2503a693-9b0d-4fef-9791-d20cd53b0699	profile	user.attribute
2503a693-9b0d-4fef-9791-d20cd53b0699	true	id.token.claim
2503a693-9b0d-4fef-9791-d20cd53b0699	true	access.token.claim
2503a693-9b0d-4fef-9791-d20cd53b0699	profile	claim.name
2503a693-9b0d-4fef-9791-d20cd53b0699	String	jsonType.label
d7ecc27f-955d-4249-a88c-8230c467aa17	true	userinfo.token.claim
d7ecc27f-955d-4249-a88c-8230c467aa17	picture	user.attribute
d7ecc27f-955d-4249-a88c-8230c467aa17	true	id.token.claim
d7ecc27f-955d-4249-a88c-8230c467aa17	true	access.token.claim
d7ecc27f-955d-4249-a88c-8230c467aa17	picture	claim.name
d7ecc27f-955d-4249-a88c-8230c467aa17	String	jsonType.label
0ff360d6-42b7-432b-9ab6-d64964796878	true	userinfo.token.claim
0ff360d6-42b7-432b-9ab6-d64964796878	website	user.attribute
0ff360d6-42b7-432b-9ab6-d64964796878	true	id.token.claim
0ff360d6-42b7-432b-9ab6-d64964796878	true	access.token.claim
0ff360d6-42b7-432b-9ab6-d64964796878	website	claim.name
0ff360d6-42b7-432b-9ab6-d64964796878	String	jsonType.label
69f74cce-fbb7-4d16-8eec-c41c9eabd68d	true	userinfo.token.claim
69f74cce-fbb7-4d16-8eec-c41c9eabd68d	gender	user.attribute
69f74cce-fbb7-4d16-8eec-c41c9eabd68d	true	id.token.claim
69f74cce-fbb7-4d16-8eec-c41c9eabd68d	true	access.token.claim
69f74cce-fbb7-4d16-8eec-c41c9eabd68d	gender	claim.name
69f74cce-fbb7-4d16-8eec-c41c9eabd68d	String	jsonType.label
8dffbef0-c256-425a-9d07-2341ef882cc2	true	userinfo.token.claim
8dffbef0-c256-425a-9d07-2341ef882cc2	birthdate	user.attribute
8dffbef0-c256-425a-9d07-2341ef882cc2	true	id.token.claim
8dffbef0-c256-425a-9d07-2341ef882cc2	true	access.token.claim
8dffbef0-c256-425a-9d07-2341ef882cc2	birthdate	claim.name
8dffbef0-c256-425a-9d07-2341ef882cc2	String	jsonType.label
8d67429b-98c1-4862-ac0f-28f8aca51edf	true	userinfo.token.claim
8d67429b-98c1-4862-ac0f-28f8aca51edf	zoneinfo	user.attribute
8d67429b-98c1-4862-ac0f-28f8aca51edf	true	id.token.claim
8d67429b-98c1-4862-ac0f-28f8aca51edf	true	access.token.claim
8d67429b-98c1-4862-ac0f-28f8aca51edf	zoneinfo	claim.name
8d67429b-98c1-4862-ac0f-28f8aca51edf	String	jsonType.label
531d8c39-7750-4bfa-a794-87e04d867bb5	true	userinfo.token.claim
531d8c39-7750-4bfa-a794-87e04d867bb5	locale	user.attribute
531d8c39-7750-4bfa-a794-87e04d867bb5	true	id.token.claim
531d8c39-7750-4bfa-a794-87e04d867bb5	true	access.token.claim
531d8c39-7750-4bfa-a794-87e04d867bb5	locale	claim.name
531d8c39-7750-4bfa-a794-87e04d867bb5	String	jsonType.label
aacdffa1-9cec-4bb6-adf3-28eb9f2a65b7	true	userinfo.token.claim
aacdffa1-9cec-4bb6-adf3-28eb9f2a65b7	updatedAt	user.attribute
aacdffa1-9cec-4bb6-adf3-28eb9f2a65b7	true	id.token.claim
aacdffa1-9cec-4bb6-adf3-28eb9f2a65b7	true	access.token.claim
aacdffa1-9cec-4bb6-adf3-28eb9f2a65b7	updated_at	claim.name
aacdffa1-9cec-4bb6-adf3-28eb9f2a65b7	long	jsonType.label
f5d0ef67-38c5-4fb4-8ba9-3670f6e12077	true	userinfo.token.claim
f5d0ef67-38c5-4fb4-8ba9-3670f6e12077	email	user.attribute
f5d0ef67-38c5-4fb4-8ba9-3670f6e12077	true	id.token.claim
f5d0ef67-38c5-4fb4-8ba9-3670f6e12077	true	access.token.claim
f5d0ef67-38c5-4fb4-8ba9-3670f6e12077	email	claim.name
f5d0ef67-38c5-4fb4-8ba9-3670f6e12077	String	jsonType.label
b523ef53-13d8-4df1-bbe1-b603677194ab	true	userinfo.token.claim
b523ef53-13d8-4df1-bbe1-b603677194ab	emailVerified	user.attribute
b523ef53-13d8-4df1-bbe1-b603677194ab	true	id.token.claim
b523ef53-13d8-4df1-bbe1-b603677194ab	true	access.token.claim
b523ef53-13d8-4df1-bbe1-b603677194ab	email_verified	claim.name
b523ef53-13d8-4df1-bbe1-b603677194ab	boolean	jsonType.label
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	formatted	user.attribute.formatted
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	country	user.attribute.country
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	postal_code	user.attribute.postal_code
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	true	userinfo.token.claim
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	street	user.attribute.street
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	true	id.token.claim
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	region	user.attribute.region
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	true	access.token.claim
b5eeb425-fbc8-4565-b8d5-d63ffebd03a3	locality	user.attribute.locality
7a7cc902-b92d-428c-894f-2aad2e547e2f	true	userinfo.token.claim
7a7cc902-b92d-428c-894f-2aad2e547e2f	phoneNumber	user.attribute
7a7cc902-b92d-428c-894f-2aad2e547e2f	true	id.token.claim
7a7cc902-b92d-428c-894f-2aad2e547e2f	true	access.token.claim
7a7cc902-b92d-428c-894f-2aad2e547e2f	phone_number	claim.name
7a7cc902-b92d-428c-894f-2aad2e547e2f	String	jsonType.label
cdf3cab3-044a-4874-bddc-9ab210fff1db	true	userinfo.token.claim
cdf3cab3-044a-4874-bddc-9ab210fff1db	phoneNumberVerified	user.attribute
cdf3cab3-044a-4874-bddc-9ab210fff1db	true	id.token.claim
cdf3cab3-044a-4874-bddc-9ab210fff1db	true	access.token.claim
cdf3cab3-044a-4874-bddc-9ab210fff1db	phone_number_verified	claim.name
cdf3cab3-044a-4874-bddc-9ab210fff1db	boolean	jsonType.label
c78aefaf-d734-43b1-8999-0e11b894ad44	true	multivalued
c78aefaf-d734-43b1-8999-0e11b894ad44	foo	user.attribute
c78aefaf-d734-43b1-8999-0e11b894ad44	true	access.token.claim
c78aefaf-d734-43b1-8999-0e11b894ad44	realm_access.roles	claim.name
c78aefaf-d734-43b1-8999-0e11b894ad44	String	jsonType.label
2b6db843-aeba-48ea-9b6d-11b8d114e117	true	multivalued
2b6db843-aeba-48ea-9b6d-11b8d114e117	foo	user.attribute
2b6db843-aeba-48ea-9b6d-11b8d114e117	true	access.token.claim
2b6db843-aeba-48ea-9b6d-11b8d114e117	resource_access.${client_id}.roles	claim.name
2b6db843-aeba-48ea-9b6d-11b8d114e117	String	jsonType.label
733598e1-613a-4289-bb24-792588fad454	true	userinfo.token.claim
733598e1-613a-4289-bb24-792588fad454	username	user.attribute
733598e1-613a-4289-bb24-792588fad454	true	id.token.claim
733598e1-613a-4289-bb24-792588fad454	true	access.token.claim
733598e1-613a-4289-bb24-792588fad454	upn	claim.name
733598e1-613a-4289-bb24-792588fad454	String	jsonType.label
568d9cf1-8d4e-49b6-aa6d-d4536562fcea	true	multivalued
568d9cf1-8d4e-49b6-aa6d-d4536562fcea	foo	user.attribute
568d9cf1-8d4e-49b6-aa6d-d4536562fcea	true	id.token.claim
568d9cf1-8d4e-49b6-aa6d-d4536562fcea	true	access.token.claim
568d9cf1-8d4e-49b6-aa6d-d4536562fcea	groups	claim.name
568d9cf1-8d4e-49b6-aa6d-d4536562fcea	String	jsonType.label
68bffe0a-ac5c-4931-9239-fca903d9635a	true	id.token.claim
68bffe0a-ac5c-4931-9239-fca903d9635a	true	access.token.claim
f4a2f0c7-a4fb-4d96-927e-6ec8f5f8d8bc	false	single
f4a2f0c7-a4fb-4d96-927e-6ec8f5f8d8bc	Basic	attribute.nameformat
f4a2f0c7-a4fb-4d96-927e-6ec8f5f8d8bc	Role	attribute.name
0329f5cd-182e-464b-90e4-cd682098661c	true	userinfo.token.claim
0329f5cd-182e-464b-90e4-cd682098661c	true	id.token.claim
0329f5cd-182e-464b-90e4-cd682098661c	true	access.token.claim
2ed08f9a-20a0-4768-8506-f33ec29281cc	true	userinfo.token.claim
2ed08f9a-20a0-4768-8506-f33ec29281cc	lastName	user.attribute
2ed08f9a-20a0-4768-8506-f33ec29281cc	true	id.token.claim
2ed08f9a-20a0-4768-8506-f33ec29281cc	true	access.token.claim
2ed08f9a-20a0-4768-8506-f33ec29281cc	family_name	claim.name
2ed08f9a-20a0-4768-8506-f33ec29281cc	String	jsonType.label
712d81b0-788e-4f03-bf71-84965feef239	true	userinfo.token.claim
712d81b0-788e-4f03-bf71-84965feef239	firstName	user.attribute
712d81b0-788e-4f03-bf71-84965feef239	true	id.token.claim
712d81b0-788e-4f03-bf71-84965feef239	true	access.token.claim
712d81b0-788e-4f03-bf71-84965feef239	given_name	claim.name
712d81b0-788e-4f03-bf71-84965feef239	String	jsonType.label
8fb93504-b159-4eab-9b29-8869f9187f98	true	userinfo.token.claim
8fb93504-b159-4eab-9b29-8869f9187f98	middleName	user.attribute
8fb93504-b159-4eab-9b29-8869f9187f98	true	id.token.claim
8fb93504-b159-4eab-9b29-8869f9187f98	true	access.token.claim
8fb93504-b159-4eab-9b29-8869f9187f98	middle_name	claim.name
8fb93504-b159-4eab-9b29-8869f9187f98	String	jsonType.label
85610e0d-3af3-4c13-a21c-348ba2482a4e	true	userinfo.token.claim
85610e0d-3af3-4c13-a21c-348ba2482a4e	nickname	user.attribute
85610e0d-3af3-4c13-a21c-348ba2482a4e	true	id.token.claim
85610e0d-3af3-4c13-a21c-348ba2482a4e	true	access.token.claim
85610e0d-3af3-4c13-a21c-348ba2482a4e	nickname	claim.name
85610e0d-3af3-4c13-a21c-348ba2482a4e	String	jsonType.label
fe86a6c2-868c-4be3-b8f2-41ae0c0cac27	true	userinfo.token.claim
fe86a6c2-868c-4be3-b8f2-41ae0c0cac27	username	user.attribute
fe86a6c2-868c-4be3-b8f2-41ae0c0cac27	true	id.token.claim
fe86a6c2-868c-4be3-b8f2-41ae0c0cac27	true	access.token.claim
fe86a6c2-868c-4be3-b8f2-41ae0c0cac27	preferred_username	claim.name
fe86a6c2-868c-4be3-b8f2-41ae0c0cac27	String	jsonType.label
e5398ab3-a44d-4a43-a347-75ef412620b9	true	userinfo.token.claim
e5398ab3-a44d-4a43-a347-75ef412620b9	profile	user.attribute
e5398ab3-a44d-4a43-a347-75ef412620b9	true	id.token.claim
e5398ab3-a44d-4a43-a347-75ef412620b9	true	access.token.claim
e5398ab3-a44d-4a43-a347-75ef412620b9	profile	claim.name
e5398ab3-a44d-4a43-a347-75ef412620b9	String	jsonType.label
222f24e7-f580-43d6-b097-7c6380906203	true	userinfo.token.claim
222f24e7-f580-43d6-b097-7c6380906203	picture	user.attribute
222f24e7-f580-43d6-b097-7c6380906203	true	id.token.claim
222f24e7-f580-43d6-b097-7c6380906203	true	access.token.claim
222f24e7-f580-43d6-b097-7c6380906203	picture	claim.name
222f24e7-f580-43d6-b097-7c6380906203	String	jsonType.label
8d801f57-444e-4d5a-8d5e-95064ce31340	true	userinfo.token.claim
8d801f57-444e-4d5a-8d5e-95064ce31340	website	user.attribute
8d801f57-444e-4d5a-8d5e-95064ce31340	true	id.token.claim
8d801f57-444e-4d5a-8d5e-95064ce31340	true	access.token.claim
8d801f57-444e-4d5a-8d5e-95064ce31340	website	claim.name
8d801f57-444e-4d5a-8d5e-95064ce31340	String	jsonType.label
926d4fea-3783-4f75-b6d8-2cfd99c420d3	true	userinfo.token.claim
926d4fea-3783-4f75-b6d8-2cfd99c420d3	gender	user.attribute
926d4fea-3783-4f75-b6d8-2cfd99c420d3	true	id.token.claim
926d4fea-3783-4f75-b6d8-2cfd99c420d3	true	access.token.claim
926d4fea-3783-4f75-b6d8-2cfd99c420d3	gender	claim.name
926d4fea-3783-4f75-b6d8-2cfd99c420d3	String	jsonType.label
7dcd0137-84ab-414b-b128-fbf7474a5cc1	true	userinfo.token.claim
7dcd0137-84ab-414b-b128-fbf7474a5cc1	birthdate	user.attribute
7dcd0137-84ab-414b-b128-fbf7474a5cc1	true	id.token.claim
7dcd0137-84ab-414b-b128-fbf7474a5cc1	true	access.token.claim
7dcd0137-84ab-414b-b128-fbf7474a5cc1	birthdate	claim.name
7dcd0137-84ab-414b-b128-fbf7474a5cc1	String	jsonType.label
338a72c9-0b29-4de3-81ea-5219d8ecf33a	true	userinfo.token.claim
338a72c9-0b29-4de3-81ea-5219d8ecf33a	zoneinfo	user.attribute
338a72c9-0b29-4de3-81ea-5219d8ecf33a	true	id.token.claim
338a72c9-0b29-4de3-81ea-5219d8ecf33a	true	access.token.claim
338a72c9-0b29-4de3-81ea-5219d8ecf33a	zoneinfo	claim.name
338a72c9-0b29-4de3-81ea-5219d8ecf33a	String	jsonType.label
5253a4a9-e2a6-4a6b-949b-73f0d7593b8b	true	userinfo.token.claim
5253a4a9-e2a6-4a6b-949b-73f0d7593b8b	locale	user.attribute
5253a4a9-e2a6-4a6b-949b-73f0d7593b8b	true	id.token.claim
5253a4a9-e2a6-4a6b-949b-73f0d7593b8b	true	access.token.claim
5253a4a9-e2a6-4a6b-949b-73f0d7593b8b	locale	claim.name
5253a4a9-e2a6-4a6b-949b-73f0d7593b8b	String	jsonType.label
e48a1ed3-4aa4-4bd4-9f42-ab62b55a9c77	true	userinfo.token.claim
e48a1ed3-4aa4-4bd4-9f42-ab62b55a9c77	updatedAt	user.attribute
e48a1ed3-4aa4-4bd4-9f42-ab62b55a9c77	true	id.token.claim
e48a1ed3-4aa4-4bd4-9f42-ab62b55a9c77	true	access.token.claim
e48a1ed3-4aa4-4bd4-9f42-ab62b55a9c77	updated_at	claim.name
e48a1ed3-4aa4-4bd4-9f42-ab62b55a9c77	long	jsonType.label
7b8007bf-1c20-4800-a547-0651bee72193	true	userinfo.token.claim
7b8007bf-1c20-4800-a547-0651bee72193	email	user.attribute
7b8007bf-1c20-4800-a547-0651bee72193	true	id.token.claim
7b8007bf-1c20-4800-a547-0651bee72193	true	access.token.claim
7b8007bf-1c20-4800-a547-0651bee72193	email	claim.name
7b8007bf-1c20-4800-a547-0651bee72193	String	jsonType.label
fabf1d9f-de9f-4c82-aea2-6affa4746d96	true	userinfo.token.claim
fabf1d9f-de9f-4c82-aea2-6affa4746d96	emailVerified	user.attribute
fabf1d9f-de9f-4c82-aea2-6affa4746d96	true	id.token.claim
fabf1d9f-de9f-4c82-aea2-6affa4746d96	true	access.token.claim
fabf1d9f-de9f-4c82-aea2-6affa4746d96	email_verified	claim.name
fabf1d9f-de9f-4c82-aea2-6affa4746d96	boolean	jsonType.label
fb855c08-ab87-471d-aa3f-12e089fa02fe	formatted	user.attribute.formatted
fb855c08-ab87-471d-aa3f-12e089fa02fe	country	user.attribute.country
fb855c08-ab87-471d-aa3f-12e089fa02fe	postal_code	user.attribute.postal_code
fb855c08-ab87-471d-aa3f-12e089fa02fe	true	userinfo.token.claim
fb855c08-ab87-471d-aa3f-12e089fa02fe	street	user.attribute.street
fb855c08-ab87-471d-aa3f-12e089fa02fe	true	id.token.claim
fb855c08-ab87-471d-aa3f-12e089fa02fe	region	user.attribute.region
fb855c08-ab87-471d-aa3f-12e089fa02fe	true	access.token.claim
fb855c08-ab87-471d-aa3f-12e089fa02fe	locality	user.attribute.locality
d9de9d2b-2b11-4097-9a78-b2b1e89a42c7	true	userinfo.token.claim
d9de9d2b-2b11-4097-9a78-b2b1e89a42c7	phoneNumber	user.attribute
d9de9d2b-2b11-4097-9a78-b2b1e89a42c7	true	id.token.claim
d9de9d2b-2b11-4097-9a78-b2b1e89a42c7	true	access.token.claim
d9de9d2b-2b11-4097-9a78-b2b1e89a42c7	phone_number	claim.name
d9de9d2b-2b11-4097-9a78-b2b1e89a42c7	String	jsonType.label
181b9f1d-28b4-499a-89e3-bbed466fb9ef	true	userinfo.token.claim
181b9f1d-28b4-499a-89e3-bbed466fb9ef	phoneNumberVerified	user.attribute
181b9f1d-28b4-499a-89e3-bbed466fb9ef	true	id.token.claim
181b9f1d-28b4-499a-89e3-bbed466fb9ef	true	access.token.claim
181b9f1d-28b4-499a-89e3-bbed466fb9ef	phone_number_verified	claim.name
181b9f1d-28b4-499a-89e3-bbed466fb9ef	boolean	jsonType.label
23c42587-5341-49f0-8f10-22a326474473	true	multivalued
23c42587-5341-49f0-8f10-22a326474473	foo	user.attribute
23c42587-5341-49f0-8f10-22a326474473	true	access.token.claim
23c42587-5341-49f0-8f10-22a326474473	realm_access.roles	claim.name
23c42587-5341-49f0-8f10-22a326474473	String	jsonType.label
893dfb6f-0727-4da1-b662-6fb532cd7f65	true	multivalued
893dfb6f-0727-4da1-b662-6fb532cd7f65	foo	user.attribute
893dfb6f-0727-4da1-b662-6fb532cd7f65	true	access.token.claim
893dfb6f-0727-4da1-b662-6fb532cd7f65	resource_access.${client_id}.roles	claim.name
893dfb6f-0727-4da1-b662-6fb532cd7f65	String	jsonType.label
c4665e42-dc4d-4748-91ba-7918c5043bec	true	userinfo.token.claim
c4665e42-dc4d-4748-91ba-7918c5043bec	username	user.attribute
c4665e42-dc4d-4748-91ba-7918c5043bec	true	id.token.claim
c4665e42-dc4d-4748-91ba-7918c5043bec	true	access.token.claim
c4665e42-dc4d-4748-91ba-7918c5043bec	upn	claim.name
c4665e42-dc4d-4748-91ba-7918c5043bec	String	jsonType.label
4fff4141-0d93-4f0c-80e4-e024e02ef611	true	multivalued
4fff4141-0d93-4f0c-80e4-e024e02ef611	foo	user.attribute
4fff4141-0d93-4f0c-80e4-e024e02ef611	true	id.token.claim
4fff4141-0d93-4f0c-80e4-e024e02ef611	true	access.token.claim
4fff4141-0d93-4f0c-80e4-e024e02ef611	groups	claim.name
4fff4141-0d93-4f0c-80e4-e024e02ef611	String	jsonType.label
af52a5b5-e81f-4d05-bb6a-0103fdca5f8f	true	id.token.claim
af52a5b5-e81f-4d05-bb6a-0103fdca5f8f	true	access.token.claim
fb08a762-60ab-4c93-aad0-87782705f83c	true	userinfo.token.claim
fb08a762-60ab-4c93-aad0-87782705f83c	locale	user.attribute
fb08a762-60ab-4c93-aad0-87782705f83c	true	id.token.claim
fb08a762-60ab-4c93-aad0-87782705f83c	true	access.token.claim
fb08a762-60ab-4c93-aad0-87782705f83c	locale	claim.name
fb08a762-60ab-4c93-aad0-87782705f83c	String	jsonType.label
7f3b90f2-cfd4-4266-8863-56d04a809da2	clientId	user.session.note
7f3b90f2-cfd4-4266-8863-56d04a809da2	true	id.token.claim
7f3b90f2-cfd4-4266-8863-56d04a809da2	true	access.token.claim
7f3b90f2-cfd4-4266-8863-56d04a809da2	clientId	claim.name
7f3b90f2-cfd4-4266-8863-56d04a809da2	String	jsonType.label
624a86cc-fa01-4260-9793-ad9cea0ae395	clientHost	user.session.note
624a86cc-fa01-4260-9793-ad9cea0ae395	true	id.token.claim
624a86cc-fa01-4260-9793-ad9cea0ae395	true	access.token.claim
624a86cc-fa01-4260-9793-ad9cea0ae395	clientHost	claim.name
624a86cc-fa01-4260-9793-ad9cea0ae395	String	jsonType.label
dafb7075-3570-4b48-83e2-73c300d9b4e7	clientAddress	user.session.note
dafb7075-3570-4b48-83e2-73c300d9b4e7	true	id.token.claim
dafb7075-3570-4b48-83e2-73c300d9b4e7	true	access.token.claim
dafb7075-3570-4b48-83e2-73c300d9b4e7	clientAddress	claim.name
dafb7075-3570-4b48-83e2-73c300d9b4e7	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
b99b93ee-5ff5-4ecb-8266-0936b60d8371	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c0293e7d-5594-44fe-a28a-8265232d7e20	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	879c6cd2-589b-460b-addb-d5d79a193207	43669a4c-0af1-4388-a632-3f07ddb35a51	d13a72ef-07f2-4cf6-aa5f-df19b5b5d578	b6f0fbbc-3302-4d1c-89d3-488c32fab202	22546526-0e08-464a-b578-55f22aca56a8	2592000	f	900	t	f	611219ef-5fb3-4f38-a35c-193c1aae4323	0	f	0	0	07110cdd-3302-4d19-83a0-b7f19e4491c5
eai-poc	60	300	300	\N	\N	\N	t	f	0	\N	eai-poc	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	86df04cd-3eac-4183-a69c-50ca8807c310	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	fef3889a-609e-463a-beb8-96381e6db2bc	d8a5dcec-4b4e-4a08-a045-8606ae339e19	e4391b1c-071c-4991-b4b7-76257dd2b742	40320e15-ea48-4f97-bd9d-358027b12ed0	ac40e50f-8429-45ee-935d-f33e00070b3b	2592000	f	900	t	f	12c88221-e445-4969-a6e7-37b39f30f0b3	0	f	0	0	5b352f3b-42ad-4b08-9521-89bc7e06fc9c
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	b99b93ee-5ff5-4ecb-8266-0936b60d8371	
_browser_header.xContentTypeOptions	b99b93ee-5ff5-4ecb-8266-0936b60d8371	nosniff
_browser_header.xRobotsTag	b99b93ee-5ff5-4ecb-8266-0936b60d8371	none
_browser_header.xFrameOptions	b99b93ee-5ff5-4ecb-8266-0936b60d8371	SAMEORIGIN
_browser_header.contentSecurityPolicy	b99b93ee-5ff5-4ecb-8266-0936b60d8371	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	b99b93ee-5ff5-4ecb-8266-0936b60d8371	1; mode=block
_browser_header.strictTransportSecurity	b99b93ee-5ff5-4ecb-8266-0936b60d8371	max-age=31536000; includeSubDomains
bruteForceProtected	b99b93ee-5ff5-4ecb-8266-0936b60d8371	false
permanentLockout	b99b93ee-5ff5-4ecb-8266-0936b60d8371	false
maxFailureWaitSeconds	b99b93ee-5ff5-4ecb-8266-0936b60d8371	900
minimumQuickLoginWaitSeconds	b99b93ee-5ff5-4ecb-8266-0936b60d8371	60
waitIncrementSeconds	b99b93ee-5ff5-4ecb-8266-0936b60d8371	60
quickLoginCheckMilliSeconds	b99b93ee-5ff5-4ecb-8266-0936b60d8371	1000
maxDeltaTimeSeconds	b99b93ee-5ff5-4ecb-8266-0936b60d8371	43200
failureFactor	b99b93ee-5ff5-4ecb-8266-0936b60d8371	30
displayName	b99b93ee-5ff5-4ecb-8266-0936b60d8371	rh-sso
displayNameHtml	b99b93ee-5ff5-4ecb-8266-0936b60d8371	<strong>Red Hat</strong><sup>®</sup> Single Sign On
defaultSignatureAlgorithm	b99b93ee-5ff5-4ecb-8266-0936b60d8371	RS256
offlineSessionMaxLifespanEnabled	b99b93ee-5ff5-4ecb-8266-0936b60d8371	false
offlineSessionMaxLifespan	b99b93ee-5ff5-4ecb-8266-0936b60d8371	5184000
oauth2DeviceCodeLifespan	eai-poc	600
oauth2DevicePollingInterval	eai-poc	5
cibaBackchannelTokenDeliveryMode	eai-poc	poll
cibaExpiresIn	eai-poc	120
cibaInterval	eai-poc	5
cibaAuthRequestedUserHint	eai-poc	login_hint
parRequestUriLifespan	eai-poc	60
bruteForceProtected	eai-poc	false
permanentLockout	eai-poc	false
maxFailureWaitSeconds	eai-poc	900
minimumQuickLoginWaitSeconds	eai-poc	60
waitIncrementSeconds	eai-poc	60
quickLoginCheckMilliSeconds	eai-poc	1000
maxDeltaTimeSeconds	eai-poc	43200
failureFactor	eai-poc	30
actionTokenGeneratedByAdminLifespan	eai-poc	43200
actionTokenGeneratedByUserLifespan	eai-poc	300
defaultSignatureAlgorithm	eai-poc	HS256
offlineSessionMaxLifespanEnabled	eai-poc	false
offlineSessionMaxLifespan	eai-poc	5184000
clientSessionIdleTimeout	eai-poc	0
clientSessionMaxLifespan	eai-poc	0
clientOfflineSessionIdleTimeout	eai-poc	0
clientOfflineSessionMaxLifespan	eai-poc	0
webAuthnPolicyRpEntityName	eai-poc	keycloak
webAuthnPolicySignatureAlgorithms	eai-poc	ES256
webAuthnPolicyRpId	eai-poc	
webAuthnPolicyAttestationConveyancePreference	eai-poc	not specified
webAuthnPolicyAuthenticatorAttachment	eai-poc	not specified
webAuthnPolicyRequireResidentKey	eai-poc	not specified
webAuthnPolicyUserVerificationRequirement	eai-poc	not specified
webAuthnPolicyCreateTimeout	eai-poc	0
webAuthnPolicyAvoidSameAuthenticatorRegister	eai-poc	false
webAuthnPolicyRpEntityNamePasswordless	eai-poc	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	eai-poc	ES256
webAuthnPolicyRpIdPasswordless	eai-poc	
webAuthnPolicyAttestationConveyancePreferencePasswordless	eai-poc	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	eai-poc	not specified
webAuthnPolicyRequireResidentKeyPasswordless	eai-poc	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	eai-poc	not specified
webAuthnPolicyCreateTimeoutPasswordless	eai-poc	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	eai-poc	false
client-policies.profiles	eai-poc	{"profiles":[]}
client-policies.policies	eai-poc	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	eai-poc	
_browser_header.xContentTypeOptions	eai-poc	nosniff
_browser_header.xRobotsTag	eai-poc	none
_browser_header.xFrameOptions	eai-poc	SAMEORIGIN
_browser_header.contentSecurityPolicy	eai-poc	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	eai-poc	1; mode=block
_browser_header.strictTransportSecurity	eai-poc	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
b99b93ee-5ff5-4ecb-8266-0936b60d8371	jboss-logging
eai-poc	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	b99b93ee-5ff5-4ecb-8266-0936b60d8371
password	password	t	t	eai-poc
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.redirect_uris (client_id, value) FROM stdin;
f6690ccd-463d-49cd-a8cb-1110d45061cd	/realms/master/account/*
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	/realms/master/account/*
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	/admin/master/console/*
806ff684-b7b4-461a-b71c-fb67bfa86672	/realms/eai-poc/account/*
4b9598f5-d742-461b-b70c-408b224e0792	/realms/eai-poc/account/*
74274da6-0aa6-4cf2-9b71-d4826f4da212	/admin/eai-poc/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
a427d6a0-e17f-4d5f-a7c4-f3b2b58afddc	VERIFY_EMAIL	Verify Email	b99b93ee-5ff5-4ecb-8266-0936b60d8371	t	f	VERIFY_EMAIL	50
500c3853-e5ea-4ef3-a4fa-555609dfdd5b	UPDATE_PROFILE	Update Profile	b99b93ee-5ff5-4ecb-8266-0936b60d8371	t	f	UPDATE_PROFILE	40
a7f2185c-e69a-4085-8114-d915af20e623	CONFIGURE_TOTP	Configure OTP	b99b93ee-5ff5-4ecb-8266-0936b60d8371	t	f	CONFIGURE_TOTP	10
b97a2831-d2da-46cd-a6c9-a79b4af1cbe9	UPDATE_PASSWORD	Update Password	b99b93ee-5ff5-4ecb-8266-0936b60d8371	t	f	UPDATE_PASSWORD	30
d1497bc1-a3f5-4ab8-85ba-7f7f4c93beab	terms_and_conditions	Terms and Conditions	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f	f	terms_and_conditions	20
81578456-63eb-4c8d-80fa-6693ecf9bd5b	update_user_locale	Update User Locale	b99b93ee-5ff5-4ecb-8266-0936b60d8371	t	f	update_user_locale	1000
77c16c72-1848-4822-bb7b-024a1a891f75	delete_account	Delete Account	b99b93ee-5ff5-4ecb-8266-0936b60d8371	f	f	delete_account	60
83fdaad8-1bd8-41a2-80df-e6e6842fa724	VERIFY_EMAIL	Verify Email	eai-poc	t	f	VERIFY_EMAIL	50
4c734d15-1123-4b75-8e9c-a500e9d39e14	UPDATE_PROFILE	Update Profile	eai-poc	t	f	UPDATE_PROFILE	40
18d61664-0a49-4633-97ac-1500c5e50710	CONFIGURE_TOTP	Configure OTP	eai-poc	t	f	CONFIGURE_TOTP	10
f1a4b162-16ff-40fb-b086-b27ad6a2d054	UPDATE_PASSWORD	Update Password	eai-poc	t	f	UPDATE_PASSWORD	30
e954267d-0450-4b45-844a-9401abf0c91a	terms_and_conditions	Terms and Conditions	eai-poc	f	f	terms_and_conditions	20
e8b00677-7508-4cd7-b81f-191c1ad5c8bf	update_user_locale	Update User Locale	eai-poc	t	f	update_user_locale	1000
3d457bca-a4f9-471f-bfa7-af7353cb79b2	delete_account	Delete Account	eai-poc	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
d3a5d38f-ca83-4b6b-a6c5-3b16a12e293d	4fdee01a-4128-4b76-9569-bc932d78f329
4b9598f5-d742-461b-b70c-408b224e0792	dbda7341-2bff-48b9-8a9d-407cbfca0e3a
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
92fb3609-a1d9-467d-be6f-ee0f0de2eba3	\N	e5d69eec-6442-45d0-acbc-56a0bfc3a8ea	f	t	\N	\N	\N	b99b93ee-5ff5-4ecb-8266-0936b60d8371	eai	1681958357446	\N	0
feb3a4ae-3d77-4079-bfa8-3ecaff42aef4	\N	b3c2d55e-0535-4465-8d77-3ffdcbacef4f	f	t	\N	\N	\N	eai-poc	service-account-64063030	1681959124941	fcec3dd8-531f-4989-869a-1e361cf2e629	0
7c0f4961-1ae7-415a-af0b-b10f1537cabf	exmaple@eai.com	exmaple@eai.com	t	t	\N	eai	poc	eai-poc	eai	1681959201288	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
07110cdd-3302-4d19-83a0-b7f19e4491c5	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
5c705864-595d-4ccf-8c3d-8747a5b3e31c	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
6eccf5bc-0ced-4a03-9432-3ecaebe29964	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
2635fbea-9393-44c9-ad9d-3785ccca026d	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
c06fef31-c71b-402c-bb69-465128a9b007	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
658c32c6-bc6e-4e46-b656-1fff86a61408	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
80fe7da1-df3e-4d02-85f2-1ff7818bfb05	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
62309425-1214-4cb2-ac5b-0120130080d2	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
d479803e-e5e2-49da-baf2-48ad5278a03f	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
14a72e2c-4e43-44db-802f-ef3293efece7	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
a8fbd9c3-577c-4d4e-bdf1-d1a57b95e483	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
afbc0728-d735-4c20-8eb9-194882f5deea	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
6deb3d6f-c11f-4f2c-b359-baa5ed5c0b8f	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
d3c0cb26-8bdd-488b-8b4b-a9249a6e2553	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
e7943001-d1a2-4bb9-aafe-3bbf407a0e0f	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
19c53a4d-1ebb-449b-a3a2-de77eeea11a9	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
0ad76d37-6ee3-4060-805a-861a46407a4a	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
21082e82-63fb-483e-8f38-771dc4e8c427	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
55032fff-90f6-42be-aaaf-1420fa002920	92fb3609-a1d9-467d-be6f-ee0f0de2eba3
5b352f3b-42ad-4b08-9521-89bc7e06fc9c	feb3a4ae-3d77-4079-bfa8-3ecaff42aef4
92af9227-b1dd-453c-9592-594458bf378c	feb3a4ae-3d77-4079-bfa8-3ecaff42aef4
5b352f3b-42ad-4b08-9521-89bc7e06fc9c	7c0f4961-1ae7-415a-af0b-b10f1537cabf
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: eai
--

COPY public.web_origins (client_id, value) FROM stdin;
840fa3e4-af4a-4368-9d1e-6d0ec0ae93d2	+
74274da6-0aa6-4cf2-9b71-d4826f4da212	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: eai
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: eai
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

