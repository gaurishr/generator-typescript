FROM nginx:alpine

ARG APP_NAME
ARG APP_DESCRIPTION
ARG APP_VERSION

# Metadata
LABEL org.label-schema.name=$APP_NAME \
      org.label-schema.description=$APP_DESCRIPTION \
      org.label-schema.version=$APP_VERSION \
      org.label-schema.vcs-url="https://https://adi-digitalhealthcare@dev.azure.com/adi-digitalhealthcare/Medical%20Products%20Software/_git/dhc-support-ui" \
      org.label-schema.url="229314128549.dkr.ecr.us-east-1.amazonaws.com/dhc-support-ui"

LABEL maintainer="DHC Cloud Maintainers <DHCCloudMaintainers@analog.com>"

COPY . /usr/share/nginx/html
RUN chmod +x /usr/share/nginx/html/launch.sh
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT [ "/usr/share/nginx/html/launch.sh" ]
