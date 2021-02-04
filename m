Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2230FB6A
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 19:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhBDS13 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 13:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239111AbhBDS1B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 13:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612463133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xldkfZkqWfGGk6TArkScHUALBjtnF9wc0SKvfCMMaM=;
        b=hYUJIAnRZEV3Pmt7xysT2wQ2I4lAwPpo6wq6GCWRpf84wHhzv9YOIQxyjketnWRLJesVMz
        EQrrI5cJnhQLXGUHDvS+2pUY9vuPYZPUqqHZUObMKhryshrwS2uZfMuHX5KKEG8lY7J9tE
        v/YGktMhwgqgQpa1RAE+9Idj2jelHC8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-xY_1GPKTOCG01HUAjIdRuw-1; Thu, 04 Feb 2021 13:25:32 -0500
X-MC-Unique: xY_1GPKTOCG01HUAjIdRuw-1
Received: by mail-ej1-f70.google.com with SMTP id w16so3298031ejk.7
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 10:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1xldkfZkqWfGGk6TArkScHUALBjtnF9wc0SKvfCMMaM=;
        b=Ek/1bGRei+EKy9lm564FE+K/Rs6545SmOjyyZba3t9cr7U7jmwF2wl4XeKrZaplVCG
         EdLDrrc9Rduh/jKi0w4aKyjHj38rxvhn/F1vGzCl5+Zdzqja67PT0CSbOEK8ar87lQR0
         MZpCLU/dGt3iDH/K4AXN/d3w+/LSi2FQER0mF/lFNf2beaxMf1YkQE2zII4zheeAuEMZ
         jjnqOeL6EzVdhRQX9zwfKaNTZsC1FhHD3LLsK9p5fCcFnhdHCvVgCTYmTBpddF+8bzEe
         4on8Fp5kyYGCbDG4B17HzxystZmu3dZiSPuAlqg/mBUYRsz31W/CbWn+fsCuaYkKS9Dg
         3LKg==
X-Gm-Message-State: AOAM530TYtCjtgW4Ls2Ly6SpXArlVve2whlqVO4Agw8zo9wzGJIeobJG
        yd1SPlAB2o9c/lbhlgoDtZgjL3mOvtT0yr2YvjlMvusxm0/DStwjCNckni50FFqy8flcd+N4BLP
        g1n2yqbMXBH3ZiI3sK3CapA==
X-Received: by 2002:a17:906:5ac8:: with SMTP id x8mr371578ejs.347.1612463130797;
        Thu, 04 Feb 2021 10:25:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/zCYJ0KGwPPt4Ohj9Wlhj90xFLRGk/jUWth5vtj8+7OUdv41IsVDNVbAFTKPUHKxuBDh1/Q==
X-Received: by 2002:a17:906:5ac8:: with SMTP id x8mr371565ejs.347.1612463130633;
        Thu, 04 Feb 2021 10:25:30 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id u17sm2914283edr.0.2021.02.04.10.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 10:25:29 -0800 (PST)
Subject: Re: [PATCH v3 1/5] ACPI: AC: Clean up printing messages
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
 <1961054.9MKZ8ejxOh@kreacher> <15677254.uJehtQVoeh@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <754e838c-b3e3-9759-51f2-5e4022f42e91@redhat.com>
Date:   Thu, 4 Feb 2021 19:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <15677254.uJehtQVoeh@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/3/21 7:43 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in ac.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, which among other things causes the excessive log
> level of the messages previously printed via ACPI_EXCEPTION() to
> be increased.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more, drop the no longer needed ACPI_AC_COMPONENT definition
> from the headers and update the documentation accordingly.
> 
> While at it, replace the direct printk() invocation with pr_info(),
> add a pr_fmt() definition to ac.c and drop the unneeded PREFIX
> symbol definition from there.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> 
> v2 -> v3: Also add a pr_fmt() definition to ac.c and replace direct
>           printk() with pr_info (no log level change).
> 
> v1 -> v2: Changelog update.
> 
> ---
>  Documentation/firmware-guide/acpi/debug.rst |    1 -
>  drivers/acpi/ac.c                           |   23 ++++++++++-------------
>  drivers/acpi/sysfs.c                        |    1 -
>  include/acpi/acpi_drivers.h                 |    1 -
>  4 files changed, 10 insertions(+), 16 deletions(-)
> 
> Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
> +++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
> @@ -52,7 +52,6 @@ shows the supported mask values, current
>      ACPI_CA_DISASSEMBLER            0x00000800
>      ACPI_COMPILER                   0x00001000
>      ACPI_TOOLS                      0x00002000
> -    ACPI_AC_COMPONENT               0x00020000
>      ACPI_BATTERY_COMPONENT          0x00040000
>      ACPI_BUTTON_COMPONENT           0x00080000
>      ACPI_SBS_COMPONENT              0x00100000
> Index: linux-pm/drivers/acpi/ac.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ac.c
> +++ linux-pm/drivers/acpi/ac.c
> @@ -6,6 +6,8 @@
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>   */
>  
> +#define pr_fmt(fmt) "ACPI: AC: " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -18,8 +20,6 @@
>  #include <linux/acpi.h>
>  #include <acpi/battery.h>
>  
> -#define PREFIX "ACPI: "
> -
>  #define ACPI_AC_CLASS			"ac_adapter"
>  #define ACPI_AC_DEVICE_NAME		"AC Adapter"
>  #define ACPI_AC_FILE_STATE		"state"
> @@ -28,9 +28,6 @@
>  #define ACPI_AC_STATUS_ONLINE		0x01
>  #define ACPI_AC_STATUS_UNKNOWN		0xFF
>  
> -#define _COMPONENT		ACPI_AC_COMPONENT
> -ACPI_MODULE_NAME("ac");
> -
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI AC Adapter Driver");
>  MODULE_LICENSE("GPL");
> @@ -102,8 +99,9 @@ static int acpi_ac_get_state(struct acpi
>  	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
>  				       &ac->state);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status,
> -				"Error reading AC Adapter state"));
> +		acpi_handle_info(ac->device->handle,
> +				"Error reading AC Adapter state: %s\n",
> +				acpi_format_exception(status));
>  		ac->state = ACPI_AC_STATUS_UNKNOWN;
>  		return -ENODEV;
>  	}
> @@ -153,8 +151,8 @@ static void acpi_ac_notify(struct acpi_d
>  
>  	switch (event) {
>  	default:
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -				  "Unsupported event [0x%x]\n", event));
> +		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
> +				  event);
>  		fallthrough;
>  	case ACPI_AC_NOTIFY_STATUS:
>  	case ACPI_NOTIFY_BUS_CHECK:
> @@ -278,9 +276,8 @@ static int acpi_ac_add(struct acpi_devic
>  		goto end;
>  	}
>  
> -	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
> -	       acpi_device_name(device), acpi_device_bid(device),
> -	       ac->state ? "on-line" : "off-line");
> +	pr_info("%s [%s] (%s)\n", acpi_device_name(device),
> +		acpi_device_bid(device), ac->state ? "on-line" : "off-line");
>  
>  	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>  	register_acpi_notifier(&ac->battery_nb);
> @@ -348,7 +345,7 @@ static int __init acpi_ac_init(void)
>  		for (i = 0; i < ARRAY_SIZE(acpi_ac_blacklist); i++)
>  			if (acpi_dev_present(acpi_ac_blacklist[i].hid, "1",
>  					     acpi_ac_blacklist[i].hrv)) {
> -				pr_info(PREFIX "AC: found native %s PMIC, not loading\n",
> +				pr_info("found native %s PMIC, not loading\n",
>  					acpi_ac_blacklist[i].hid);
>  				return -ENODEV;
>  			}
> Index: linux-pm/drivers/acpi/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sysfs.c
> +++ linux-pm/drivers/acpi/sysfs.c
> @@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
>  	ACPI_DEBUG_INIT(ACPI_COMPILER),
>  	ACPI_DEBUG_INIT(ACPI_TOOLS),
>  
> -	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
> Index: linux-pm/include/acpi/acpi_drivers.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_drivers.h
> +++ linux-pm/include/acpi/acpi_drivers.h
> @@ -15,7 +15,6 @@
>   * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
>   * if you add to this list.
>   */
> -#define ACPI_AC_COMPONENT		0x00020000
>  #define ACPI_BATTERY_COMPONENT		0x00040000
>  #define ACPI_BUTTON_COMPONENT		0x00080000
>  #define ACPI_SBS_COMPONENT		0x00100000
> 
> 
> 

