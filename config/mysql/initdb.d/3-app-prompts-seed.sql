-- Insert master data for prompts (no dependencies)
INSERT INTO `prompts` (`prompt_type`, `prompt_name`, `name_label`, `prompt_text`, `description`)
VALUES ('docchat', 'default', 'Default Prompt',
        'You are a helpful assistant that answers questions based on the provided documents.',
        'Default prompt for document chat'),
       ('docguide', 'default', 'Default Guide', 'Guide the user through the document step by step.',
        'Default prompt for document guide'),
       ('processchat', 'default', 'Default Process Chat', 'Help users understand and navigate through processes.',
        'Default prompt for process chat'),
       ('processguide', 'default', 'Default Process Guide', 'Guide users through process steps and requirements.',
        'Default prompt for process guide');

INSERT INTO `entities` (`type`, `data`, `created_at`, `updated_at`)
VALUES ('configurations',
        '{"name":"chatbox_instructions","value":["This is a Generative AI tool, responses are not always accurate: Responses improve with quality data and clear instructions. Iterate multiple times to improve answers. Rephrase your prompts, add more context","If in doubt: Please verify with the source document.","Your role matters: Treat the model as a collaborator. Break tasks into smaller parts and use your expertise to guide it effectively."]}',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP);

-- 3. Insert master data for entity configurations (no dependencies)
INSERT INTO `entity_configurations` (`type`, `config`, `created_at`, `updated_at`)
VALUES ('chatbox_instructions',
        '{"name":"chatbox_instructions","value":["This is a Generative AI tool, responses are not always accurate: Responses improve with quality data and clear instructions. Iterate multiple times to improve answers. Rephrase your prompts, add more context","If in doubt: Please verify with the source document.","Your role matters: Treat the model as a collaborator. Break tasks into smaller parts and use your expertise to guide it effectively."]}',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
