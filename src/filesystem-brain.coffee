# Description:
#   Persist hubot's brain to filesystem
#
# Configuration:
#   STORAGE_FILE_PATH
#   default value: /hubot/root/folder
#
# Commands:
#   None

fs = require 'fs'
sysPath = require 'path'

module.exports = (robot) ->
  BRAIN_FILE_PATH = sysPath.join __dirname, '../../../', 'hubot_brain.json'

  robot.brain.setAutoSave false

  content = fs.readFileSync BRAIN_FILE_PATH, 'utf8'

  if content
    robot.logger.info "hubot-filesystem-brain: Data for hubot brain retrieved from File System"
    robot.brain.mergeData JSON.parse(content.toString())
  else
    robot.logger.info "hubot-filesystem-brain: Initializing new data for hubot brain"
    robot.brain.mergeData {}

  robot.brain.setAutoSave true

  robot.brain.on 'save', (data = {}) ->
    fs.writeFileSync BRAIN_FILE_PATH, JSON.stringify(data), 'utf8'
