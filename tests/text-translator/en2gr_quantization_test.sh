#!/bin/bash

# Copyright (c) 2017-present, Facebook, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euxo pipefail

# Make a temporary file to store quantization profile in.
TEMP_FILE="$(mktemp)"

$BIN/text-translator -m "${MODELS_DIR}/en2gr" -keep-original-precision-for-nodes=Add -dump-profile=$TEMP_FILE -quantization-schema=symmetric <<< "My name is Bob ."

# CHECK: mein Name ist Bob \.$
$BIN/text-translator -m "${MODELS_DIR}/en2gr" -keep-original-precision-for-nodes=Add -load-profile=$TEMP_FILE <<< "My name is Bob ."

rm $TEMP_FILE
