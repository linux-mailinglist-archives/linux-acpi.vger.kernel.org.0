Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02471FFD0
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 12:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjFBKzI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 06:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFBKzH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 06:55:07 -0400
X-Greylist: delayed 873 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 03:55:04 PDT
Received: from grilo.cascardo.info (grilo.cascardo.info [IPv6:2a01:4f8:13a:6e8:152:1:0:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF26C0;
        Fri,  2 Jun 2023 03:55:04 -0700 (PDT)
Received: from siri.cascardo.eti.br (unknown [IPv6:2804:431:e7c5:145d:6a17:29ff:fe00:4f38])
        by grilo.cascardo.info (Postfix) with ESMTPSA id CAF1A200172;
        Fri,  2 Jun 2023 07:30:00 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=holoscopio.com;
        s=mail; t=1685701803;
        bh=ueONc7ev81AAlv0Rz4GJDLaRhMnB1XlzZCYB16hNYlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5bdHpqd+s4eoRZc8KF0x4CL1Kiw8qGvsKkT6cjbK5qOdlQI4qpzmC0eVHcE+i2o0
         G5l6xmbZy9v4aliz4y6FeCamOV75bQxwdcd0B0EAXWbSrj4Fp5u2JYcQQw5UyIcVbA
         nCRWzeRgCOkKdxXE07fUXiYkI8tTzzhK/sLk2OGAsEVNrIn8+V260BoQ88cgZ/nNYg
         tpH6A3saSPbLp1jHDEJZZrWkXdvOmFCaH1H7yZ5v3hOnTvEbtQeYGjh71DXJuZP7dC
         8MbuKcM6L+WAR3ZHVZBYP254NvfIFzv925+f85yM1WZDu2B+JlZlHzpB1rgZj0DDTl
         EXjAoWdZnlz9w==
Date:   Fri, 2 Jun 2023 07:29:56 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     Daniel Oliveira Nascimento <don@syst.com.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 18/35] platform/x86/classmate-laptop: Move handler
 installing logic to driver
Message-ID: <ZHnEpDRJfywWP3mB@siri.cascardo.eti.br>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
 <20230601131739.300760-19-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131739.300760-19-michal.wilczynski@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 01, 2023 at 03:17:21PM +0200, Michal Wilczynski wrote:
> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
> 
> Call acpi_device_install_event_handler() at the end of .add() callback.
> Call acpi_device_remove_event_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify callback to match with
> what's required by acpi_device_install_event_handler().
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/platform/x86/classmate-laptop.c | 53 +++++++++++++++++++------
>  1 file changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 2edaea2492df..2d36abf5ecfe 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -180,8 +180,9 @@ static acpi_status cmpc_get_accel_v4(acpi_handle handle,
>  	return status;
>  }
>  
> -static void cmpc_accel_handler_v4(struct acpi_device *dev, u32 event)
> +static void cmpc_accel_handler_v4(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *dev = data;
>  	if (event == 0x81) {
>  		int16_t x, y, z;
>  		acpi_status status;
> @@ -407,6 +408,11 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	dev_set_drvdata(&inputdev->dev, accel);
>  
> +	error = acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
> +						  cmpc_accel_handler_v4);
> +	if (error)
> +		goto failed_input;
> +

In all cases, acpi_device_install_event_handler is being called after
cmpc_add_acpi_notify_device, which allocates and registers an input
device.

You should cleanup in case acpi_device_install_event_handler fails and
call cmpc_remove_acpi_notify_device.

Cascardo.

>  	return 0;
>  
>  failed_input:
> @@ -420,6 +426,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
>  
>  static void cmpc_accel_remove_v4(struct acpi_device *acpi)
>  {
> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_accel_handler_v4);
>  	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
>  	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
>  	cmpc_remove_acpi_notify_device(acpi);
> @@ -441,7 +448,6 @@ static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
>  	.ops = {
>  		.add = cmpc_accel_add_v4,
>  		.remove = cmpc_accel_remove_v4,
> -		.notify = cmpc_accel_handler_v4,
>  	},
>  	.drv.pm = &cmpc_accel_pm,
>  };
> @@ -523,8 +529,10 @@ static acpi_status cmpc_get_accel(acpi_handle handle,
>  	return status;
>  }
>  
> -static void cmpc_accel_handler(struct acpi_device *dev, u32 event)
> +static void cmpc_accel_handler(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *dev = data;
> +
>  	if (event == 0x81) {
>  		unsigned char x, y, z;
>  		acpi_status status;
> @@ -639,6 +647,11 @@ static int cmpc_accel_add(struct acpi_device *acpi)
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	dev_set_drvdata(&inputdev->dev, accel);
>  
> +	error = acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
> +						  cmpc_accel_handler);
> +	if (error)
> +		goto failed_input;
> +
>  	return 0;
>  
>  failed_input:
> @@ -650,6 +663,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
>  
>  static void cmpc_accel_remove(struct acpi_device *acpi)
>  {
> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_accel_handler);
>  	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
>  	cmpc_remove_acpi_notify_device(acpi);
>  }
> @@ -667,7 +681,6 @@ static struct acpi_driver cmpc_accel_acpi_driver = {
>  	.ops = {
>  		.add = cmpc_accel_add,
>  		.remove = cmpc_accel_remove,
> -		.notify = cmpc_accel_handler,
>  	}
>  };
>  
> @@ -693,8 +706,9 @@ static acpi_status cmpc_get_tablet(acpi_handle handle,
>  	return status;
>  }
>  
> -static void cmpc_tablet_handler(struct acpi_device *dev, u32 event)
> +static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *dev = data;
>  	unsigned long long val = 0;
>  	struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
>  
> @@ -723,12 +737,20 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
>  
>  static int cmpc_tablet_add(struct acpi_device *acpi)
>  {
> -	return cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
> -					   cmpc_tablet_idev_init);
> +	int ret;
> +
> +	ret = cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
> +					  cmpc_tablet_idev_init);
> +	if (ret)
> +		return ret;
> +
> +	return acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
> +						 cmpc_tablet_handler);
>  }
>  
>  static void cmpc_tablet_remove(struct acpi_device *acpi)
>  {
> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_tablet_handler);
>  	cmpc_remove_acpi_notify_device(acpi);
>  }
>  
> @@ -761,7 +783,6 @@ static struct acpi_driver cmpc_tablet_acpi_driver = {
>  	.ops = {
>  		.add = cmpc_tablet_add,
>  		.remove = cmpc_tablet_remove,
> -		.notify = cmpc_tablet_handler,
>  	},
>  	.drv.pm = &cmpc_tablet_pm,
>  };
> @@ -1026,8 +1047,9 @@ static int cmpc_keys_codes[] = {
>  	KEY_MAX
>  };
>  
> -static void cmpc_keys_handler(struct acpi_device *dev, u32 event)
> +static void cmpc_keys_handler(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *dev = data;
>  	struct input_dev *inputdev;
>  	int code = KEY_MAX;
>  
> @@ -1049,12 +1071,20 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
>  
>  static int cmpc_keys_add(struct acpi_device *acpi)
>  {
> -	return cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
> -					   cmpc_keys_idev_init);
> +	int error;
> +
> +	error = cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
> +					    cmpc_keys_idev_init);
> +	if (error)
> +		return error;
> +
> +	return acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
> +						 cmpc_keys_handler);
>  }
>  
>  static void cmpc_keys_remove(struct acpi_device *acpi)
>  {
> +	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_keys_handler);
>  	cmpc_remove_acpi_notify_device(acpi);
>  }
>  
> @@ -1071,7 +1101,6 @@ static struct acpi_driver cmpc_keys_acpi_driver = {
>  	.ops = {
>  		.add = cmpc_keys_add,
>  		.remove = cmpc_keys_remove,
> -		.notify = cmpc_keys_handler,
>  	}
>  };
>  
> -- 
> 2.40.1
> 
