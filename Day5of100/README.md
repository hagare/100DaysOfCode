# Simple Image Classification using IBM Watson Studio
Created a simple image classifier using Watson Studio and general module of Visual Recogniation on IBM cloud

1. Create an account on IBM Watson
https://dataplatform.cloud.ibm.com/

2. Create a Project with Watson Studio
- New Project
- Add Storage

3. Add asset to project
- Visual Recognition
- Pre-built > General
- Test (make sure it works as you want by uploading sample images and reviewing results)


- Attempted to Deploy ( add python script to notebook)

## From Watson help
```python
!pip install --upgrade "watson-developer-cloud>=1.0,<2.0"
from watson_developer_cloud import VisualRecognitionV3
visual_recognition = VisualRecognitionV3( '2016-05-20', api_key='<your-API-key>' )
image_url = 'https://watson-developer-cloud.github.io/doc-tutorial-downloads/visual-recognition/visual-recognition-food-fruit.png'
import json
parms = json.dumps( { 'url' : image_url, 'classifier_ids' : [ 'food' ] } )
results = visual_recognition.classify( parameters = parms )
print( json.dumps( results['images'][0]['classifiers'][0]['classes'], indent=2 ) )
```

### Errors thrown up because tutorial out of date
*I updated as follows*

#Install watson
import sys
!$sys.executable -m pip install --upgrade "ibm-watson>=4.3.0"
visual_recognition = VisualRecognitionV3( '2016-05-20', api_key='<your-API-key>' )
image_url = 'https://watson-developer-cloud.github.io/doc-tutorial-downloads/visual-recognition/visual-recognition-food-fruit.png'
import json
parms = json.dumps( { 'url' : image_url, 'classifier_ids' : [ 'food' ] } )
results = visual_recognition.classify( parameters = parms )
print( json.dumps( results['images'][0]['classifiers'][0]['classes'], indent=2 ) )
# did not work. only gui worked
