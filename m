Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2598C2CFCC5
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Dec 2020 19:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgLESTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 13:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbgLESSb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 13:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607192221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6szMlU1XTINTQ7LKDtM0NJfGBYkIKSCusYvX2Ps4tVY=;
        b=Z2iAYW6PeveP43mmMIHKgptqDxrMF34+5HPwLJAzoGR2l7pwexCmBup8cW9nPjzWEsSLPd
        0sGm9xocgwLrfoPHa2gGDofUiGXkP24soMRdhwNPldqKNujcfE4Qms9baiXAXpyzlEzETZ
        2hMuQgZjygD6xigwuvI+MuvvBI8q524=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-2KgktBkdPGu9rrGIEAAJug-1; Sat, 05 Dec 2020 12:03:03 -0500
X-MC-Unique: 2KgktBkdPGu9rrGIEAAJug-1
Received: by mail-ed1-f72.google.com with SMTP id a9so3068799edy.8
        for <linux-acpi@vger.kernel.org>; Sat, 05 Dec 2020 09:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6szMlU1XTINTQ7LKDtM0NJfGBYkIKSCusYvX2Ps4tVY=;
        b=VFej4WKbskfO/N9lRTwwPLLufQ512Z9SlP57q56XKpDUpyfpI0Vap9IP7Vc0h73q78
         Yeo48QDnuhG3XrS4j9Mi5YuJ2AESYrsdM2USvXh7oXtBb+2Ml0b8k4RPXFagwHnXasny
         7bU6pYNM43RvEIuAS0KaTANoxsv2X+H3jGiDIQbAHKO7MXj0k0Dr0ScRWpQlbu3YhP6i
         F//wZmRVIliZPPVxHY95OyLmED7eDrBnZo9s1iORbsWUF27nR1NAE0uEsusF47O83Qma
         LoBIUx+9isysSun6lGs7ADwTV0vRhIwzqBzxaL7/1Z4rKgYqrIjKr/Ig47UsaEZcugtb
         qQgA==
X-Gm-Message-State: AOAM530wThRHhgPA/vJl+3dPl2UbGSSX6PR9eE9lMD4mkv9EwD6UWhFl
        g1esk+J8cqjuJW3Y55lFuY+FK8YrzlTMBsEQPtFJIj/A2yubosxDCu6sok8pjoMxHjWJtMcMxtl
        tRN82Uf/bxAodNdaLvv12fnsorqFDYrNUB8c7TeMys3VQJlW9cOwi8r6Bq2aJXEl3qXz2jUsdhg
        ==
X-Received: by 2002:a17:906:b143:: with SMTP id bt3mr12278435ejb.318.1607187781266;
        Sat, 05 Dec 2020 09:03:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/MrJ1uEUH5dVk046vmEPHOS/4VVYGWTTBg1VoWRFpZrK8IZojs62yoomRqzNQFTbrDpkZjg==
X-Received: by 2002:a17:906:b143:: with SMTP id bt3mr12278418ejb.318.1607187780956;
        Sat, 05 Dec 2020 09:03:00 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v8sm5851344edt.3.2020.12.05.09.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 09:03:00 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201121203040.146252-1-hdegoede@redhat.com>
 <00a4b9c2-aca2-4842-3006-720515f262db@redhat.com>
 <CAJZ5v0iP4a_6sSjO2sAgQUZ7T9BWvaV+s_JvYnD4NwdcCY9DMw@mail.gmail.com>
 <10746938.kh9KKrt31x@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e2bcbee4-78cb-a4f1-41d9-ccb4d3ae0af0@redhat.com>
Date:   Sat, 5 Dec 2020 18:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <10746938.kh9KKrt31x@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/5/20 4:44 PM, Rafael J. Wysocki wrote:
> On Thursday, December 3, 2020 3:27:27 PM CET Rafael J. Wysocki wrote:
>> On Thu, Dec 3, 2020 at 10:53 AM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> [cut]
> 
>>> That indeed is not necessary if you take the entire set and always enable the
>>> new behavior instead of using the module option. I guess we could go that route
>>> for 5.12, and get it into next as soon as 5.11-rc1 is available for maximum
>>> testing.
> 
> I'd prefer to do the whole thing in 5.11-rc and possibly revert something if it
> causes problems to occur.

Ok, that is you call to make, so that is fine with me.

>>> Do you want me to do a new version of the series which drops the acpi_defer_add_hids[]
>>> thing and the module option and simply always uses the new behavior?
>>
>> No, something else.  Stay tuned.
> 
> The patch below illustrates what I'd like to do.  It at least doesn't kill my
> test-bed system, but also it doesn't cause the enumeration ordering to change
> on that system.
> 
> It really is three patches in one and (again) I borrowed some code from your
> patches in the $subject series.

Borrowing some of my code is fine, no worries about that. I'm happy as some
fix for this gets upstream in some form :)

>  [It is on top of the "ACPI: scan: Add PNP0D80
> to the _DEP exceptions list" patch I've just posted.]
> 
> 
> Please let me know what you think.

I think this should work fine. I've 2 small remarks inline below, but nothing
big / important.

My list of kernel things to look into is longer then my available time
(something which I assume you are familiar with), so for now I've only taken
a good look at your proposed solution and not actually tested it.

Let me know if you want me to give this a spin on the device with the _HID
issue as is, or if you have something closer to a final version ready
which you want me to test.

> ---
>  drivers/acpi/scan.c |  141 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 120 insertions(+), 21 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1646,17 +1646,77 @@ void acpi_device_add_finalize(struct acp
>  	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
>  }
>  
> -static int acpi_add_single_object(struct acpi_device **child,
> -				  acpi_handle handle, int type,
> -				  unsigned long long sta)
> +/*
> + * List of IDs for which we defer enumeration them to the second pass, because
> + * some of their methods used during addition depend on OpRegions registered by
> + * the drivers for other ACPI devices.
> + */
> +static const char * const acpi_defer_enumeration_ids[] = {
> +	"BCM2E5B", /* Acer SW3-016 bluetooth HID vs GPIO OpRegs */
> +	NULL
> +};

Note that since you defer if there are unmet _DEP-s, this won't be necessary:

This list was purely there as a safer way to select devices which to defer,
the kernel cmdline option in my patch-set would switch between either using
this list, or checking _DEP. Since we are going to fully go for using _DEP
now, this can be dropped.

> +
> +static bool acpi_should_defer_enumeration(acpi_handle handle,
> +					  struct acpi_device_info *info)
> +{
> +	struct acpi_handle_list dep_devices;
> +	acpi_status status;
> +	int i;
> +
> +	if (acpi_info_matches_ids(info, acpi_defer_enumeration_ids))
> +		return true;
> +
> +	/*
> +	 * We check for _HID here to avoid deferring the enumeration of:
> +	 * 1. PCI devices
> +	 * 2. ACPI nodes describing USB ports
> +	 * However, checking for _HID catches more then just these cases ...
> +	 */
> +	if (!(info->valid & ACPI_VALID_HID))
> +		return false;

Interesting approach (using _HID), I went with _ADR since _ADR indicates
(more or less) that the ACPI fwnode is a companion node for a device
which will be enumerated through other means (such as PCI devices), rather
then one where the ACPI code will instantiate a platform_device, or
i2c_client (etc) for it.

Maybe if we want to play it safe check both, and if there either is no
HID, or there is an ADR do not defer ?  Note just thinking out loud here,
I'm fine with either approach.


> +
> +	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
> +	if (ACPI_FAILURE(status))
> +		return false;
> +
> +	for (i = 0; i < dep_devices.count; i++) {
> +		struct acpi_device_info *dep_info;
> +		bool ignore;
> +
> +		status = acpi_get_object_info(dep_devices.handles[i], &dep_info);
> +		if (ACPI_FAILURE(status))
> +			continue;
> +
> +		ignore = acpi_info_matches_ids(dep_info, acpi_ignore_dep_ids);
> +		kfree(dep_info);
> +
> +		if (ignore)
> +			continue;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int __acpi_add_single_object(struct acpi_device **child,
> +				    acpi_handle handle, int type,
> +				    unsigned long long sta, bool check_dep)
>  {
>  	int result;
>  	struct acpi_device *device;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct acpi_device_info *info = NULL;
>  
> -	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE)
> +	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE) {
>  		acpi_get_object_info(handle, &info);
> +		if (check_dep && info &&
> +		    acpi_should_defer_enumeration(handle, info)) {
> +			kfree(info);
> +			acpi_handle_info(handle, "Missing dependencies\n");
> +			return -EAGAIN;
> +		}
> +	}
>  
>  	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
>  	if (!device) {
> @@ -1696,6 +1756,13 @@ static int acpi_add_single_object(struct
>  	return 0;
>  }
>  
> +static int acpi_add_single_object(struct acpi_device **child,
> +				  acpi_handle handle, int type,
> +				  unsigned long long sta)
> +{
> +	return __acpi_add_single_object(child, handle, type, sta, false);
> +}
> +
>  static acpi_status acpi_get_resource_memory(struct acpi_resource *ares,
>  					    void *context)
>  {
> @@ -1892,8 +1959,8 @@ static void acpi_device_dep_initialize(s
>  	}
>  }
>  
> -static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
> -				      void *not_used, void **return_value)
> +static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> +				      struct acpi_device **adev_p)
>  {
>  	struct acpi_device *device = NULL;
>  	int type;
> @@ -1913,7 +1980,7 @@ static acpi_status acpi_bus_check_add(ac
>  		return AE_OK;
>  	}
>  
> -	acpi_add_single_object(&device, handle, type, sta);
> +	__acpi_add_single_object(&device, handle, type, sta, check_dep);
>  	if (!device)
>  		return AE_CTRL_DEPTH;
>  
> @@ -1921,12 +1988,24 @@ static acpi_status acpi_bus_check_add(ac
>  	acpi_device_dep_initialize(device);
>  
>   out:
> -	if (!*return_value)
> -		*return_value = device;
> +	if (!*adev_p)
> +		*adev_p = device;
>  
>  	return AE_OK;
>  }
>  
> +static acpi_status acpi_bus_check_add_1(acpi_handle handle, u32 lvl_not_used,
> +					void *not_used, void **ret_p)
> +{
> +	return acpi_bus_check_add(handle, true, (struct acpi_device **)ret_p);
> +}
> +
> +static acpi_status acpi_bus_check_add_2(acpi_handle handle, u32 lvl_not_used,
> +					void *not_used, void **ret_p)
> +{
> +	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
> +}
> +
>  static void acpi_default_enumeration(struct acpi_device *device)
>  {
>  	/*
> @@ -1994,12 +2073,16 @@ static int acpi_scan_attach_handler(stru
>  	return ret;
>  }
>  
> -static void acpi_bus_attach(struct acpi_device *device)
> +static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
>  {
>  	struct acpi_device *child;
> +	bool skip = !first_pass && device->flags.visited;
>  	acpi_handle ejd;
>  	int ret;
>  
> +	if (skip)
> +		goto ok;
> +
>  	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
>  		register_dock_dependent_device(device, ejd);
>  
> @@ -2046,9 +2129,9 @@ static void acpi_bus_attach(struct acpi_
>  
>   ok:
>  	list_for_each_entry(child, &device->children, node)
> -		acpi_bus_attach(child);
> +		acpi_bus_attach(child, first_pass);
>  
> -	if (device->handler && device->handler->hotplug.notify_online)
> +	if (!skip && device->handler && device->handler->hotplug.notify_online)
>  		device->handler->hotplug.notify_online(device);
>  }
>  
> @@ -2066,7 +2149,8 @@ void acpi_walk_dep_device_list(acpi_hand
>  
>  			adev->dep_unmet--;
>  			if (!adev->dep_unmet)
> -				acpi_bus_attach(adev);
> +				acpi_bus_attach(adev, true);
> +
>  			list_del(&dep->node);
>  			kfree(dep);
>  		}
> @@ -2091,17 +2175,32 @@ EXPORT_SYMBOL_GPL(acpi_walk_dep_device_l
>   */
>  int acpi_bus_scan(acpi_handle handle)
>  {
> -	void *device = NULL;
> +	struct acpi_device *device = NULL;
> +
> +	/* Pass 1: Avoid enumerating devices with missing dependencies. */
>  
> -	if (ACPI_SUCCESS(acpi_bus_check_add(handle, 0, NULL, &device)))
> +	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
>  		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> -				    acpi_bus_check_add, NULL, NULL, &device);
> +				    acpi_bus_check_add_1, NULL, NULL,
> +				    (void **)&device);
>  
> -	if (device) {
> -		acpi_bus_attach(device);
> -		return 0;
> -	}
> -	return -ENODEV;
> +	if (!device)
> +		return -ENODEV;
> +
> +	acpi_bus_attach(device, true);
> +
> +	/* Pass 2: Enumerate all of the remaining devices. */
> +
> +	device = NULL;
> +
> +	if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
> +		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> +				    acpi_bus_check_add_2, NULL, NULL,
> +				    (void **)&device);
> +
> +	acpi_bus_attach(device, false);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(acpi_bus_scan);

Regards,

Hans

