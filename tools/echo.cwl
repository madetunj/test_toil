cwlVersion: v1.0
class: CommandLineTool
 
requirements:
 - class: ShellCommandRequirement
 
baseCommand: echo
 
inputs:
  message:
    type: string
    inputBinding:
      position: 1
  ofn:
    type: string
outputs:
  message_file:
    stdout
 
stdout: $(inputs.ofn)
