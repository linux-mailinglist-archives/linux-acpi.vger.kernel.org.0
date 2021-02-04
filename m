Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44630FB80
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 19:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhBDSaP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 13:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239137AbhBDS3q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 13:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612463299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaVqlNIeecJeWkJVHOtZ7cF2n5I5GFK1T6qxrN1YZuw=;
        b=BStYMAVXwjLwSBTdaen4TxCvlbLE/fBjZZ7xj54ty9ufMXC0oShHW1fFCcuiaolbLC2Fh8
        BEJ0zz60C/6oXQWnPgXqQvofTziSrKz1HcDP9gujCwxBOrVgVVPZazUTtxfx2g8SvDmDgp
        k3qmxh3ObINsb3ZS5d5HRfEUVyqDJhQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-cc65XknjP9aORT1cSJ0REg-1; Thu, 04 Feb 2021 13:28:18 -0500
X-MC-Unique: cc65XknjP9aORT1cSJ0REg-1
Received: by mail-ed1-f70.google.com with SMTP id ay16so3658889edb.2
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 10:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CaVqlNIeecJeWkJVHOtZ7cF2n5I5GFK1T6qxrN1YZuw=;
        b=SNlfG/aFgyuRzsIZKeMX8DcHni+UuzEdleAuigrMremkyRpJGKe8eBVGf1u5Pzavlf
         wro5Fd/SKDYbvmicIeKj2nULEVq38F1fX37VfBhbCHHw68k2JxGE23JlXh1yYFsdVTZZ
         G5fbEa/l7nOIecGhVXY2w4+80dh8R5ZxfNUyFlUSbEipYrECbRqsetztrBoWK6QfUF2x
         jE5/feOjHBrruRN8fSa+Q8duISQAU1aG6cfBXTnd7o0JSoDLKUSL4FKMxBVoAYEMs0JR
         x/KKr4+7DwHsO1V3wz0od2xbeVTnBHvXjpcXvPbaJ6iK2YBOuDp5CLCNmXydZBehNNhR
         OU9w==
X-Gm-Message-State: AOAM533JW7801i2ob/jJNuo+8q3Mgk5/6k1knnN1b4sLMUcp+FdmFUl9
        HetZWzOJWJCkdmbt7fr/oaElzs+rIjyRjD5HTT2BG1CFr2LEQ8ujX2/nX0XCshYAwa3p3++m1Ya
        mQimFyyPfCFnKNq05km6liQ==
X-Received: by 2002:aa7:d912:: with SMTP id a18mr266829edr.73.1612463296960;
        Thu, 04 Feb 2021 10:28:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJit3RA361GGIbkrhupm2QXbd2R/rovt+bOJ5mYd7RLF6Oubm7j2cvKzbl9CnfN3h6XSyL8Q==
X-Received: by 2002:aa7:d912:: with SMTP id a18mr266814edr.73.1612463296692;
        Thu, 04 Feb 2021 10:28:16 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id l13sm2835655eji.49.2021.02.04.10.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 10:28:16 -0800 (PST)
Subject: Re: [PATCH v3 3/5] ACPI: button: Clean up printing messages
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
 <1961054.9MKZ8ejxOh@kreacher> <5061782.uJCyLE8JBt@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f2a42f94-3990-8c0d-1826-4bc75a97ce53@redhat.com>
Date:   Thu, 4 Feb 2021 19:28:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5061782.uJCyLE8JBt@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/3/21 7:46 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() instance in button.c with an
> acpi_handle_debug() call, drop the _COMPONENT and ACPI_MODULE_NAME()
> definitions that are not used any more, drop the no longer needed
> ACPI_BUTTON_COMPONENT definition from the headers and update the
> documentation accordingly.
> 
> While at it, replace the direct printk() invocations with pr_info()
> (that changes the excessive log level for some of them too) and drop
> the unneeded PREFIX sybmbol definition from battery.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
> 
> v2 -> v3: Add R-by tag.
> 
> v1 -> v2: Changelog update.
> 
> ---
>  Documentation/firmware-guide/acpi/debug.rst |    1 -
>  drivers/acpi/button.c                       |   15 +++++----------
>  drivers/acpi/sysfs.c                        |    1 -
>  include/acpi/acpi_drivers.h                 |    1 -
>  4 files changed, 5 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/acpi/button.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/button.c
> +++ linux-pm/drivers/acpi/button.c
> @@ -21,8 +21,6 @@
>  #include <linux/dmi.h>
>  #include <acpi/button.h>
>  
> -#define PREFIX "ACPI: "
> -
>  #define ACPI_BUTTON_CLASS		"button"
>  #define ACPI_BUTTON_FILE_STATE		"state"
>  #define ACPI_BUTTON_TYPE_UNKNOWN	0x00
> @@ -54,9 +52,6 @@ static const char * const lid_init_state
>  	[ACPI_BUTTON_LID_INIT_DISABLED]		= "disabled",
>  };
>  
> -#define _COMPONENT		ACPI_BUTTON_COMPONENT
> -ACPI_MODULE_NAME("button");
> -
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Button Driver");
>  MODULE_LICENSE("GPL");
> @@ -285,7 +280,7 @@ static int acpi_button_add_fs(struct acp
>  		return 0;
>  
>  	if (acpi_button_dir || acpi_lid_dir) {
> -		printk(KERN_ERR PREFIX "More than one Lid device found!\n");
> +		pr_info("More than one Lid device found!\n");
>  		return -EEXIST;
>  	}
>  
> @@ -434,8 +429,8 @@ static void acpi_button_notify(struct ac
>  		}
>  		break;
>  	default:
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -				  "Unsupported event [0x%x]\n", event));
> +		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
> +				  event);
>  		break;
>  	}
>  }
> @@ -523,7 +518,7 @@ static int acpi_button_add(struct acpi_d
>  			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
>  		input->open = acpi_lid_input_open;
>  	} else {
> -		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
> +		pr_info("Unsupported hid [%s]\n", hid);
>  		error = -ENODEV;
>  		goto err_free_input;
>  	}
> @@ -567,7 +562,7 @@ static int acpi_button_add(struct acpi_d
>  	}
>  
>  	device_init_wakeup(&device->dev, true);
> -	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
> +	pr_info("%s [%s]\n", name, acpi_device_bid(device));
>  	return 0;
>  
>   err_remove_fs:
> Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
> +++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
> @@ -52,7 +52,6 @@ shows the supported mask values, current
>      ACPI_CA_DISASSEMBLER            0x00000800
>      ACPI_COMPILER                   0x00001000
>      ACPI_TOOLS                      0x00002000
> -    ACPI_BUTTON_COMPONENT           0x00080000
>      ACPI_SBS_COMPONENT              0x00100000
>      ACPI_FAN_COMPONENT              0x00200000
>      ACPI_PCI_COMPONENT              0x00400000
> Index: linux-pm/drivers/acpi/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sysfs.c
> +++ linux-pm/drivers/acpi/sysfs.c
> @@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
>  	ACPI_DEBUG_INIT(ACPI_COMPILER),
>  	ACPI_DEBUG_INIT(ACPI_TOOLS),
>  
> -	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
> Index: linux-pm/include/acpi/acpi_drivers.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_drivers.h
> +++ linux-pm/include/acpi/acpi_drivers.h
> @@ -15,7 +15,6 @@
>   * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
>   * if you add to this list.
>   */
> -#define ACPI_BUTTON_COMPONENT		0x00080000
>  #define ACPI_SBS_COMPONENT		0x00100000
>  #define ACPI_FAN_COMPONENT		0x00200000
>  #define ACPI_PCI_COMPONENT		0x00400000
> 
> 
> 

