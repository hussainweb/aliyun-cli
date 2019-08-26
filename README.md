# Aliyun CLI on Docker
This is the source for the [Aliyun CLI Docker image](https://hub.docker.com/r/hussainweb/aliyun-cli) (no entrypoint so that it may be used in a CI like Jenkins)

## Usage

Just run it with Docker as usual:

```
docker run -it hussainweb/aliyun-cli aliyun oss ...
```

## Usage with Jenkins

With Jenkins (or any other CI tool), just run the command in this container. Here is a sample Groovy script for Jenkins. The Aliyun key and secret is assumed to be stored in a username-password credential called `aliyun_key`.

```groovy
withCredentials([usernamePassword(credentialsId: 'aliyun_key', usernameVariable: 'ALIYUN_ACCESS_KEY_ID', passwordVariable: 'ALIYUN_SECRET_ACCESS_KEY')]) {
    docker.image('hussainweb/aliyun-cli').inside("-v /etc/passwd:/etc/passwd -v ${env.HOME}:${env.HOME}:rw,z") {
        String bucketName = "aliyun-oss-bucket-name"
        sh "aliyun oss cp dist/ oss://${bucketName} -r -f -u --mode AK --access-key-id \"${env.ALIYUN_ACCESS_KEY_ID}\" --access-key-secret \"${env.ALIYUN_SECRET_ACCESS_KEY}\" --region \"${aliyunRegion}\""
    }
}
```
