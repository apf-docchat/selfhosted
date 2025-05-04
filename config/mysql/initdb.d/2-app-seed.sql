-- Seed data for ProcessWiz application

-- 1. Insert master data for modules first (no dependencies)
INSERT INTO `modules` (`id`, `name`, `button_text`, `description`, `form_action`)
VALUES (1, 'Document Chat', 'Chat with Documents', 'Chat with your documents using AI', 'docchat'),
       (2, 'Document Guide', 'Guide Me', 'Get guided through your documents', 'docguide'),
       (3, 'Process Chat', 'Chat with Process', 'Chat about your processes', 'processchat'),
       (4, 'Process Guide', 'Process Guide', 'Get guided through your processes', 'processguide'),
       (5, 'Process Builder', 'Build Process', 'Build and manage your processes', 'processbuilder'),
       (6, 'File Manager', 'Manage Files', 'Manage your files and documents', 'filemanager'),
       (7, 'Process Manager', 'Manage Process', 'Manage your processes', 'processmanager'),
       (8, 'Collection Manager', 'Manage Collections', 'Manage your collections', 'collectionmanager'),
       (9, 'User Manager', 'Manage Users', 'Manage users and permissions', 'usermanager'),
       (10, 'Organization Manager', 'Manage Organization', 'Manage organization settings', 'orgmanager');

-- 2. Insert default user (parent for user_organization and user_roles)
INSERT INTO `users` (`username`, `password_hash`, `email`, `first_name`, `last_name`,
                     `is_active`, `is_admin`, `date_joined`)
VALUES ('admin',
        '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', -- password: admin123
        'admin@processwiz.com',
        'Admin',
        'User',
        1,
        1,
        CURRENT_TIMESTAMP);

-- 3. Add Default role for the user (depends on users)
INSERT INTO `user_roles` (`user_id`, `role_name`, `details`, `objectives`, `is_active`)
VALUES (1,
        'Default',
        'Default role for admin user',
        'System administration and management',
        1);

-- 4. Link user to Default role (depends on users and user_roles)
INSERT INTO `user_role_current` (`user_id`, `user_role_id`, `is_primary`)
VALUES (1,
        1,
        1);

-- 5. Insert organization (depends on users)
INSERT INTO `organization` (`org_name`, `description`, `status`, `created_by_user_id`, `admin_user_id`)
VALUES ('Default Organization',
        'Default organization for ProcessWiz',
        'ACTIVE',
        1,
        1);

-- 6. Link user to organization as super_user (depends on users and organization)
INSERT INTO `user_organization` (`user_id`, `org_id`, `role`)
VALUES (1,
        1,
        'SUPER_USER');

-- 7. Create NotInAnyCollection (depends on organization)
INSERT INTO `collections` (`collection_name`, `description`, `sharing_level`, `type`, `org_id`)
VALUES ('NotInAnyCollection',
        'Default collection for files not assigned to any specific collection',
        'ORG',
        'file',
        1);

-- 8. Link modules to organization (depends on organization and modules)
INSERT INTO `organization_modules` (`org_id`, `module_id`)
VALUES (1, 1),
       (1, 6),
       (1, 8),
       (1, 9),
       (1, 10);

-- Note: For Google Sheets integration, the installer needs to:
-- 1. Create a Service Account in Google Cloud
-- 2. Copy the credentials JSON content
-- 3. Insert it into collections_credentials table with:
-- INSERT INTO collections_credentials (service_type, credentials_json)
-- VALUES ('googlesheet', '<json_file_content>');
