import functions_framework
from flask import jsonify
from fiftyone_devicedetection_onpremise.devicedetection_onpremise_pipelinebuilder import DeviceDetectionOnPremisePipelineBuilder
import logging

# global variables, only initialised once 
hash_file = "data_file/51Degrees-LiteV4.1.hash"
pipeline = DeviceDetectionOnPremisePipelineBuilder(data_file_path=hash_file, licence_keys="", auto_update=False, performance_profile = "MaxPerformance", usage_sharing=False,add_javascript_builder = False).build()

@functions_framework.http
def main(request):
    try:
        # Retrieve input
        replies = []
        request_json = request.get_json()
        calls = request_json['calls']


        # iterate over useragents sent in batch request
        for call in calls:
            if call is not None:
                return_value = parse_useragent(call[0], pipeline)
            else:
                return_value =  {
                'error': 'value of call sent to function is "None"'
                }
            replies.append(return_value)

        # create return json
        # logging.debug(replies)
        return_json = jsonify({ "replies":  replies })
        return return_json
    
    except Exception as e:
        logging.error("Error in processing data:", e), 500

def parse_useragent(user_agent, pipeline):
    # parse useragents using 51degrees library
    header = "header.user-agent"
    try:
        fd = pipeline.create_flowdata()
        fd.evidence.add(header, user_agent)
        fd.process()
        return_value = {
            'PlatformName': str(fd.device.platformname.value()),
            'PlatformVersion': str(fd.device.platformversion.value()),
            'PlatformVendor': str(fd.device.platformvendor.value()),
            'BrowserName': str(fd.device.browsername.value()),
            'BrowserVersion': str(fd.device.browserversion.value()),
            'BrowserVendor': str(fd.device.browservendor.value()),
            'DeviceID': str(fd.device.deviceid.value()),
            'ScreenPixelsWidth': str(fd.device.screenpixelswidth.value()),
            'ScreenPixelsHeight': str(fd.device.screenpixelsheight.value())
        }
    except Exception as e:
        message = "Error in processing data"
        return_value = {
            'error': f"{message}, exception: {e}",
            'PlatformName': 'Unknown',
            'PlatformVersion': 'Unknown',
            'PlatformVendor': 'Unknown',
            'BrowserName': 'Unknown',
            'BrowserVersion': 'Unknown',
            'BrowserVendor': 'Unknown',
            'DeviceID': 'Unknown',
            'ScreenPixelsWidth': 0,
            'ScreenPixelsHeight': 0
        }

    # Additional transformation
    # Add IsMobile, IsSmartphone, IsTablet to return Dict
    try:
        return_value['IsMobile'] = fd.device.ismobile.value()
        return_value['IsSmartPhone'] = fd.device.issmartphone.value()
        return_value['IsTablet'] = fd.device.istablet.value()
    except Exception as e:
        # Default IsMobile, IsSmartphone, IsTablet to None when match isn't found
        return_value['IsMobile'] = None
        return_value['IsSmartPhone'] = None
        return_value['IsTablet'] = None

    # Apply overrides to return_value dict based of lazy parsing of UserAgent string
    user_agent_lower = user_agent.lower()

    if return_value['IsMobile'] is None and return_value['IsSmartPhone'] is None and return_value['IsTablet'] is None:
        if 'iphone' in user_agent_lower or 'ipad' in user_agent_lower or 'ipod' in user_agent_lower or 'android' in user_agent_lower: return_value['IsMobile'] = True
        if 'iphone' in user_agent_lower or 'ipod' in user_agent_lower or 'android' in user_agent_lower: return_value['IsSmartPhone'] = True
        if 'ipad' in user_agent_lower: return_value['IsTablet'] = True

    return(return_value)