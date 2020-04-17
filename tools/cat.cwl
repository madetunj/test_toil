cwlVersion: v1.0
class: CommandLineTool
 
requirements:
 - class: ShellCommandRequirement
 
baseCommand: cat
 
inputs:
  input_file:
    type: File[]
    inputBinding:
      position: 1
  output_file:
    type: string
outputs:
  all_messages:
    stdout
stdout: $(inputs.output_file)
