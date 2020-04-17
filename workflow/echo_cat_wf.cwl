cwlVersion: v1.0
class: Workflow
 
requirements:
 - class: SubworkflowFeatureRequirement
 - class: ScatterFeatureRequirement
 
inputs:
  message_array: string[]
  ofn_array: string[]
  output_file: string
 
outputs:
  echo_message:
    type: File[]
    outputSource: echo_subwf/message_file
  cat_message:
    type: File
    outputSource: cat/all_messages
 
steps:
  echo_subwf:
    run:
      class: Workflow
      inputs:
        message: string
        ofn: string
      outputs:
        message_file:
          type: File
          outputSource: echo/message_file
      steps:
        echo:
          run: ../tools/echo.cwl
          in:
            message: message
            ofn: ofn
          out: [message_file]
    scatter: [message, ofn]
    scatterMethod: dotproduct
    in:
      message: message_array
      ofn: ofn_array
    out: [message_file]
  cat:
    requirements:
      ResourceRequirement:
        ramMax: 1000
        coresMin: 2
    run: ../tools/cat.cwl
    in:
      input_file: echo_subwf/message_file
      output_file: output_file
    out: [all_messages]
