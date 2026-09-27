# Ban Kick Mute System

A comprehensive ban, kick, and mute system for FiveM servers.

## Features

- Ban players with customizable durations and reasons
- Kick players with customizable reasons
- Mute players with customizable durations and reasons
- Admin group permissions for command usage
- Logging system to track actions in the database

## Requirements

- FiveM server
- ESX Legacy
- MySQL-Async

## Installation

1. Download the script and place it in your FiveM server's resources folder.
2. Add the following to your `server.cfg`:

```
start mysql-async
start es_extended
start BanKickMuteSystem
```

3. Import the `database.sql` file into your MySQL database.

## Usage

### Commands

| Command | Description | Usage |
|---------|-------------|-------|
| /ban | Ban a player | /ban [playerId] [duration] [reason] |
| /kick | Kick a player | /kick [playerId] [reason] |
| /mute | Mute a player | /mute [playerId] [duration] [reason] |

### Permissions

- Only players with admin, superadmin, or mod group permissions can use the commands.

## Configuration

Edit the `config.lua` file to customize:

- Default ban and mute durations
- Admin groups
- Command names

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=ban-kick-mute-system&utm_content=bottom) — describe it in one sentence and get the full source code.

