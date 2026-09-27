CREATE TABLE IF NOT EXISTS ban_kick_mute_system (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(255) NOT NULL,
    type ENUM('ban', 'kick', 'mute') NOT NULL,
    reason TEXT,
    duration INT,
    admin VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_identifier ON ban_kick_mute_system (identifier);
CREATE INDEX idx_type ON ban_kick_mute_system (type);