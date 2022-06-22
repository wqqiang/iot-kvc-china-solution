# Clone the SDK
git clone --recursive https://github.com/awslabs/amazon-kinesis-video-streams-webrtc-sdk-c.git

# Note: if you don't have a VPN set up, you will get the following error: fatal: unable to access 'https://github.com/awslabs/amazon-kinesis-video-streams-webrtc-sdk-c.git/': GnuTLS recv error (-110): The TLS connection was non-properly terminated.

# Configure and create build directory
# Note: this step will take a long time depends your network status.
mkdir -p amazon-kinesis-video-streams-webrtc-sdk-c/build
cd amazon-kinesis-video-streams-webrtc-sdk-c/build
cmake ..

# Build the library and sample applications
make
