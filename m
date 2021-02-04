Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF930FBA0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 19:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhBDSfN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 13:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238476AbhBDSfE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 13:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612463615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKrOz7FAs3tJoHyGXBNrG1BWtJMXb7u2kkdGtqwvLV8=;
        b=gHwt0chJ6QlqM7nWZwrMwt7Wxbmkz7Gnt44L3cUUzWZYRFwmY/yji7ehcqulso1Er6lyRe
        +pVE6/Ev/rXMj97SDFy4CjeDFEPhoIVnU0MlZAaYouB4ILql0BUGnh7UryLVPFolmRaq7e
        rK5PW29keHNwJwM8+q2qZS+jCeeiOTc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-yAnA6_LuNWmoneX0DzflhQ-1; Thu, 04 Feb 2021 13:33:33 -0500
X-MC-Unique: yAnA6_LuNWmoneX0DzflhQ-1
Received: by mail-ej1-f70.google.com with SMTP id hx26so3311134ejc.3
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 10:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dKrOz7FAs3tJoHyGXBNrG1BWtJMXb7u2kkdGtqwvLV8=;
        b=tjeRP1BhTvJZ4K6IUBFwMs5ZQy4OMcur2XpDAPEUc+ylzxaOaJzBf7dfc4nRC2mUnI
         wsCjTEwOGdWlMsERJjIGSI8IU2cSN9XVsafMp1VP1jGC3yyKVyqnXI1QxQj3C+B/egte
         i4+DZpmqcMRhO+Fk/YtjdK+dg1F0bl6pOsTFxsUcPeSILUzB7nMW05r7LPZPXjngdQE5
         l7ANlam6UI5+FgplsDapKkqb2m4t/dQPy3XqqRcphVv1hwkU9sq036ZXu3kPHUYxC58K
         i3n6JCNnPnBW8jetsL7PFKOK78KKFBd854Do6vYzEKn46X434OtP1F613FMWv19CmGoD
         iAKg==
X-Gm-Message-State: AOAM531y6pCtVo+NtHeNsBr6drKN1l3/73j1W4+8z4w1G3Jc4rH2QsrM
        eI9JVkU3XMfwJKytPNhH+lPrJfwHtyhQsbjpKkBFqB368aa8vwSBXx3oh8Flv7NnIc8I1ynxvta
        +lZKThoBz1JyzjAxJu8uXSw==
X-Received: by 2002:a17:906:69c2:: with SMTP id g2mr389157ejs.249.1612463612099;
        Thu, 04 Feb 2021 10:33:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI8tZuMkp0s3kgIPgKAX8NrZicJU/N+6+o/Y4gR3AXjZ6IKYn4nargW7ZnRxYDkHzp6c90Wg==
X-Received: by 2002:a17:906:69c2:: with SMTP id g2mr388812ejs.249.1612463607793;
        Thu, 04 Feb 2021 10:33:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id k22sm2987184edv.33.2021.02.04.10.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 10:33:26 -0800 (PST)
Subject: Re: [PATCH v3 4/5] ACPI: video: Clean up printing messages
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>,
        Hanjun Guo <guohanjun@huawei.com>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
 <1961054.9MKZ8ejxOh@kreacher> <1924490.ZvBDFke9FE@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fc92bf0f-b770-a4d5-7c0f-0936a4a35a38@redhat.com>
Date:   Thu, 4 Feb 2021 19:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1924490.ZvBDFke9FE@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/3/21 7:48 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() instances in acpi_video.c with
> acpi_handle_debug() calls and the ACPI_EXCEPTION()/ACPI_ERROR()/
> ACPI_WARNING() instances in there with acpi_handle_info() calls,
> which among other things causes the excessive log levels of those
> messages to be increased.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more from acpi_video.c, drop the no longer needed
> ACPI_VIDEO_COMPONENT definition from the headers and update the
> documentation accordingly.
> 
> While at it, add a pr_fmt() definition to acpi_video.c, replace the
> direct printk() invocations in there with acpi_handle_info() or
> pr_info() (and reduce the excessive log level where applicable) and
> drop the PREFIX sybmbol definition which is not necessary any more
> from acpi_video.c.
> 
> Also make unrelated janitorial changes to fix up white space and
> use ACPI_FAILURE() instead of negating ACPI_SUCCESS().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> 
> v2 -> v3: Replace more !ACPI_SUCCESS() instances with ACPI_FAILURE().
> 
> v1 -> v2: Changelog update.
> 
> ---
>  Documentation/firmware-guide/acpi/debug.rst |    1 
>  drivers/acpi/acpi_video.c                   |   99 ++++++++++++++--------------
>  drivers/acpi/sysfs.c                        |    1 
>  include/acpi/acpi_drivers.h                 |    1 
>  4 files changed, 51 insertions(+), 51 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpi_video.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_video.c
> +++ linux-pm/drivers/acpi/acpi_video.c
> @@ -7,6 +7,8 @@
>   *  Copyright (C) 2006 Thomas Tuttle <linux-kernel@ttuttle.net>
>   */
>  
> +#define pr_fmt(fmt) "ACPI: video: " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -26,16 +28,11 @@
>  #include <acpi/video.h>
>  #include <linux/uaccess.h>
>  
> -#define PREFIX "ACPI: "
> -
>  #define ACPI_VIDEO_BUS_NAME		"Video Bus"
>  #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
>  
>  #define MAX_NAME_LEN	20
>  
> -#define _COMPONENT		ACPI_VIDEO_COMPONENT
> -ACPI_MODULE_NAME("video");
> -
>  MODULE_AUTHOR("Bruno Ducrot");
>  MODULE_DESCRIPTION("ACPI Video Driver");
>  MODULE_LICENSE("GPL");
> @@ -326,11 +323,11 @@ acpi_video_device_lcd_query_levels(acpi_
>  	*levels = NULL;
>  
>  	status = acpi_evaluate_object(handle, "_BCL", NULL, &buffer);
> -	if (!ACPI_SUCCESS(status))
> +	if (ACPI_FAILURE(status))
>  		return status;
>  	obj = (union acpi_object *)buffer.pointer;
>  	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
> -		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
> +		acpi_handle_info(handle, "Invalid _BCL data\n");
>  		status = -EFAULT;
>  		goto err;
>  	}
> @@ -354,7 +351,7 @@ acpi_video_device_lcd_set_level(struct a
>  	status = acpi_execute_simple_method(device->dev->handle,
>  					    "_BCM", level);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_ERROR((AE_INFO, "Evaluating _BCM failed"));
> +		acpi_handle_info(device->dev->handle, "_BCM evaluation failed\n");
>  		return -EIO;
>  	}
>  
> @@ -368,7 +365,7 @@ acpi_video_device_lcd_set_level(struct a
>  			return 0;
>  		}
>  
> -	ACPI_ERROR((AE_INFO, "Current brightness invalid"));
> +	acpi_handle_info(device->dev->handle, "Current brightness invalid\n");
>  	return -EINVAL;
>  }
>  
> @@ -622,9 +619,8 @@ acpi_video_device_lcd_get_level_current(
>  			 * BQC returned an invalid level.
>  			 * Stop using it.
>  			 */
> -			ACPI_WARNING((AE_INFO,
> -				      "%s returned an invalid level",
> -				      buf));
> +			acpi_handle_info(device->dev->handle,
> +					 "%s returned an invalid level", buf);
>  			device->cap._BQC = device->cap._BCQ = 0;
>  		} else {
>  			/*
> @@ -635,7 +631,8 @@ acpi_video_device_lcd_get_level_current(
>  			 * ACPI video backlight still works w/ buggy _BQC.
>  			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
>  			 */
> -			ACPI_WARNING((AE_INFO, "Evaluating %s failed", buf));
> +			acpi_handle_info(device->dev->handle,
> +					 "%s evaluation failed", buf);
>  			device->cap._BQC = device->cap._BCQ = 0;
>  		}
>  	}
> @@ -675,7 +672,7 @@ acpi_video_device_EDID(struct acpi_video
>  	if (obj && obj->type == ACPI_TYPE_BUFFER)
>  		*edid = obj;
>  	else {
> -		printk(KERN_ERR PREFIX "Invalid _DDC data\n");
> +		acpi_handle_info(device->dev->handle, "Invalid _DDC data\n");
>  		status = -EFAULT;
>  		kfree(obj);
>  	}
> @@ -827,10 +824,9 @@ int acpi_video_get_levels(struct acpi_de
>  	int result = 0;
>  	u32 value;
>  
> -	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device->handle,
> -								&obj))) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
> -						"LCD brightness level\n"));
> +	if (ACPI_FAILURE(acpi_video_device_lcd_query_levels(device->handle, &obj))) {
> +		acpi_handle_debug(device->handle,
> +				  "Could not query available LCD brightness level\n");
>  		result = -ENODEV;
>  		goto out;
>  	}
> @@ -842,7 +838,6 @@ int acpi_video_get_levels(struct acpi_de
>  
>  	br = kzalloc(sizeof(*br), GFP_KERNEL);
>  	if (!br) {
> -		printk(KERN_ERR "can't allocate memory\n");
>  		result = -ENOMEM;
>  		goto out;
>  	}
> @@ -863,7 +858,7 @@ int acpi_video_get_levels(struct acpi_de
>  	for (i = 0; i < obj->package.count; i++) {
>  		o = (union acpi_object *)&obj->package.elements[i];
>  		if (o->type != ACPI_TYPE_INTEGER) {
> -			printk(KERN_ERR PREFIX "Invalid data\n");
> +			acpi_handle_info(device->handle, "Invalid data\n");
>  			continue;
>  		}
>  		value = (u32) o->integer.value;
> @@ -900,7 +895,8 @@ int acpi_video_get_levels(struct acpi_de
>  			br->levels[i] = br->levels[i - level_ac_battery];
>  		count += level_ac_battery;
>  	} else if (level_ac_battery > ACPI_VIDEO_FIRST_LEVEL)
> -		ACPI_ERROR((AE_INFO, "Too many duplicates in _BCL package"));
> +		acpi_handle_info(device->handle,
> +				 "Too many duplicates in _BCL package");
>  
>  	/* Check if the _BCL package is in a reversed order */
>  	if (max_level == br->levels[ACPI_VIDEO_FIRST_LEVEL]) {
> @@ -910,8 +906,8 @@ int acpi_video_get_levels(struct acpi_de
>  		     sizeof(br->levels[ACPI_VIDEO_FIRST_LEVEL]),
>  		     acpi_video_cmp_level, NULL);
>  	} else if (max_level != br->levels[count - 1])
> -		ACPI_ERROR((AE_INFO,
> -			    "Found unordered _BCL package"));
> +		acpi_handle_info(device->handle,
> +				 "Found unordered _BCL package");
>  
>  	br->count = count;
>  	*dev_br = br;
> @@ -989,9 +985,9 @@ set_level:
>  	if (result)
>  		goto out_free_levels;
>  
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -			  "found %d brightness levels\n",
> -			  br->count - ACPI_VIDEO_FIRST_LEVEL));
> +	acpi_handle_debug(device->dev->handle, "found %d brightness levels\n",
> +			  br->count - ACPI_VIDEO_FIRST_LEVEL);
> +
>  	return 0;
>  
>  out_free_levels:
> @@ -1023,7 +1019,8 @@ static void acpi_video_device_find_cap(s
>  	if (acpi_has_method(device->dev->handle, "_BQC")) {
>  		device->cap._BQC = 1;
>  	} else if (acpi_has_method(device->dev->handle, "_BCQ")) {
> -		printk(KERN_WARNING FW_BUG "_BCQ is used instead of _BQC\n");
> +		acpi_handle_info(device->dev->handle,
> +				 "_BCQ is used instead of _BQC\n");
>  		device->cap._BCQ = 1;
>  	}
>  
> @@ -1083,8 +1080,7 @@ static int acpi_video_bus_check(struct a
>  	/* Does this device support video switching? */
>  	if (video->cap._DOS || video->cap._DOD) {
>  		if (!video->cap._DOS) {
> -			printk(KERN_WARNING FW_BUG
> -				"ACPI(%s) defines _DOD but not _DOS\n",
> +			pr_info(FW_BUG "ACPI(%s) defines _DOD but not _DOS\n",
>  				acpi_device_bid(video->device));
>  		}
>  		video->flags.multihead = 1;
> @@ -1272,7 +1268,8 @@ acpi_video_device_bind(struct acpi_video
>  		ids = &video->attached_array[i];
>  		if (device->device_id == (ids->value.int_val & 0xffff)) {
>  			ids->bind_info = device;
> -			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "device_bind %d\n", i));
> +			acpi_handle_debug(video->device->handle, "%s: %d\n",
> +					  __func__, i);
>  		}
>  	}
>  }
> @@ -1324,20 +1321,22 @@ static int acpi_video_device_enumerate(s
>  		return AE_NOT_EXIST;
>  
>  	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
> -	if (!ACPI_SUCCESS(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_info(video->device->handle,
> +				 "_DOD evaluation failed: %s\n",
> +				 acpi_format_exception(status));
>  		return status;
>  	}
>  
>  	dod = buffer.pointer;
>  	if (!dod || (dod->type != ACPI_TYPE_PACKAGE)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Invalid _DOD data"));
> +		acpi_handle_info(video->device->handle, "Invalid _DOD data\n");
>  		status = -EFAULT;
>  		goto out;
>  	}
>  
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d video heads in _DOD\n",
> -			  dod->package.count));
> +	acpi_handle_debug(video->device->handle, "Found %d video heads in _DOD\n",
> +			  dod->package.count);
>  
>  	active_list = kcalloc(1 + dod->package.count,
>  			      sizeof(struct acpi_video_enumerated_device),
> @@ -1352,15 +1351,18 @@ static int acpi_video_device_enumerate(s
>  		obj = &dod->package.elements[i];
>  
>  		if (obj->type != ACPI_TYPE_INTEGER) {
> -			printk(KERN_ERR PREFIX
> -				"Invalid _DOD data in element %d\n", i);
> +			acpi_handle_info(video->device->handle,
> +					 "Invalid _DOD data in element %d\n", i);
>  			continue;
>  		}
>  
>  		active_list[count].value.int_val = obj->integer.value;
>  		active_list[count].bind_info = NULL;
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = %d\n", i,
> -				  (int)obj->integer.value));
> +
> +		acpi_handle_debug(video->device->handle,
> +				  "_DOD element[%d] = %d\n", i,
> +				  (int)obj->integer.value);
> +
>  		count++;
>  	}
>  
> @@ -1451,7 +1453,8 @@ acpi_video_switch_brightness(struct work
>  
>  out:
>  	if (result)
> -		printk(KERN_ERR PREFIX "Failed to switch the brightness\n");
> +		acpi_handle_info(device->dev->handle,
> +				 "Failed to switch brightness\n");
>  }
>  
>  int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
> @@ -1601,8 +1604,8 @@ static void acpi_video_bus_notify(struct
>  		break;
>  
>  	default:
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -				  "Unsupported event [0x%x]\n", event));
> +		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
> +				  event);
>  		break;
>  	}
>  
> @@ -1675,8 +1678,7 @@ static void acpi_video_device_notify(acp
>  		keycode = KEY_DISPLAY_OFF;
>  		break;
>  	default:
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -				  "Unsupported event [0x%x]\n", event));
> +		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
>  		break;
>  	}
>  
> @@ -1812,11 +1814,12 @@ static void acpi_video_dev_register_back
>  			&device->cooling_dev->device.kobj,
>  			"thermal_cooling");
>  	if (result)
> -		printk(KERN_ERR PREFIX "Create sysfs link\n");
> +		pr_info("sysfs link creation failed\n");
> +
>  	result = sysfs_create_link(&device->cooling_dev->device.kobj,
>  			&device->dev->dev.kobj, "device");
>  	if (result)
> -		printk(KERN_ERR PREFIX "Create sysfs link\n");
> +		pr_info("Reverse sysfs link creation failed\n");
>  }
>  
>  static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
> @@ -2030,7 +2033,7 @@ static int acpi_video_bus_add(struct acp
>  				acpi_video_bus_match, NULL,
>  				device, NULL);
>  	if (status == AE_ALREADY_EXISTS) {
> -		printk(KERN_WARNING FW_BUG
> +		pr_info(FW_BUG
>  			"Duplicate ACPI video bus devices for the"
>  			" same VGA controller, please try module "
>  			"parameter \"video.allow_duplicates=1\""
> @@ -2073,7 +2076,7 @@ static int acpi_video_bus_add(struct acp
>  	if (error)
>  		goto err_put_video;
>  
> -	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
> +	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>  	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
>  	       video->flags.multihead ? "yes" : "no",
>  	       video->flags.rom ? "yes" : "no",
> Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
> +++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
> @@ -59,7 +59,6 @@ shows the supported mask values, current
>      ACPI_SYSTEM_COMPONENT           0x02000000
>      ACPI_THERMAL_COMPONENT          0x04000000
>      ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
> -    ACPI_VIDEO_COMPONENT            0x10000000
>      ACPI_PROCESSOR_COMPONENT        0x20000000
>  
>  debug_level
> Index: linux-pm/drivers/acpi/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sysfs.c
> +++ linux-pm/drivers/acpi/sysfs.c
> @@ -59,7 +59,6 @@ static const struct acpi_dlayer acpi_deb
>  	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
> -	ACPI_DEBUG_INIT(ACPI_VIDEO_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
>  };
>  
> Index: linux-pm/include/acpi/acpi_drivers.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_drivers.h
> +++ linux-pm/include/acpi/acpi_drivers.h
> @@ -22,7 +22,6 @@
>  #define ACPI_SYSTEM_COMPONENT		0x02000000
>  #define ACPI_THERMAL_COMPONENT		0x04000000
>  #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
> -#define ACPI_VIDEO_COMPONENT		0x10000000
>  #define ACPI_PROCESSOR_COMPONENT	0x20000000
>  
>  /*
> 
> 
> 

