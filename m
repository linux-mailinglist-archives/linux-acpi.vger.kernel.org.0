Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A85EC4FF
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 15:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiI0Nyb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiI0Ny2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 09:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1DF13F298
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664286865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+fSmc3mQK+aqWmG3MScUFdiFJLPf6oWUhYcySI3/CQ=;
        b=MJJjrifRyegwHCku3TogsCIUykJXWaBwhBcryWKmehZnaPg3kvXuQ+TxPs1gksd/6fTwi9
        RoCF84EWamXHKRmxSX394eqTFtL/L7cvjljkS5zt1yiH/6986+TD487VnqahbOZRhFuFxI
        JxI2Flmww3hUoc7pP9Vawh+zFO0YOvE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-H-W1LSpyP5WwSghGpcVEtA-1; Tue, 27 Sep 2022 09:54:24 -0400
X-MC-Unique: H-W1LSpyP5WwSghGpcVEtA-1
Received: by mail-ed1-f69.google.com with SMTP id z16-20020a05640235d000b0045485e4a5e0so7862809edc.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=O+fSmc3mQK+aqWmG3MScUFdiFJLPf6oWUhYcySI3/CQ=;
        b=xF8zssF0y/O/RRTOJz764e3Ip4rAlgrmQ+BjHCjm1R3iCjK4NCqCtBoHFNO7uFoW8w
         b4UJnBp1q+n3hZZdfOTKMXIKGht1+lMoCJ15SM1XxhzgxrnqKrmfxQsXJPRJyYllG44v
         fDWYepgUIUZbACuDlF2h10FsMVpvLtuYpwhi4dVh6ERy/IcDm7W0jE81s0j27mgFDUa5
         OeIleHVYdetsbSvIdHuwyV9thtb/SomSh7dTk+ZNRluV5/3WBJjhKFnd+c5VUfMaA5H2
         FR98/MA09FdUfNlB0tVDcHx4RCIc5mIkYKjMT2JltTXkodWcAJWqUnzQS/on9812zvJU
         8pCg==
X-Gm-Message-State: ACrzQf059jDQ1L6xwvePYdM6HfE8/mUlOnBeFH8zIXlczNGBCbpART1c
        CPK6gtUGB+YwaHiMV5JZEDGS9neDh2pI4d91RSJ9nPYyFSt3XqqJg/GWFHm3V5a078O7KodvDXn
        +GRbG8VW5exBy+f1Ox4xEKA==
X-Received: by 2002:a17:907:3f04:b0:741:4bf4:fe42 with SMTP id hq4-20020a1709073f0400b007414bf4fe42mr23460487ejc.664.1664286860836;
        Tue, 27 Sep 2022 06:54:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SId5qGZ1ypbrD8MvtZcVAxrwOd+tXTnR0iN/FGxzT08gC1eFc5i9q+FedVtubnsF6slfSYQ==
X-Received: by 2002:a17:907:3f04:b0:741:4bf4:fe42 with SMTP id hq4-20020a1709073f0400b007414bf4fe42mr23460466ejc.664.1664286860504;
        Tue, 27 Sep 2022 06:54:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ss4-20020a170907038400b00781be3e7badsm847760ejb.53.2022.09.27.06.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:54:19 -0700 (PDT)
Message-ID: <8b8af307-c0b3-f42b-f470-a4778e814893@redhat.com>
Date:   Tue, 27 Sep 2022 15:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC v2 1/2] platform/x86: quickstart: Add ACPI quickstart
 button (PNP0C32) driver
Content-Language: en-US
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Cc:     platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220922182424.934340-1-lkml@vorpal.se>
 <20220922182424.934340-2-lkml@vorpal.se>
 <4-mkye9NM7L93IKQAGjd8BmHi1_2zEnx4F8L3AvKk9RsNBtuoS5cpNCKV-nyb1Xpb1jmAZQDdpNlyvjoUfrFKkq4V-EOfXo9b_gRbyC1hSs=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4-mkye9NM7L93IKQAGjd8BmHi1_2zEnx4F8L3AvKk9RsNBtuoS5cpNCKV-nyb1Xpb1jmAZQDdpNlyvjoUfrFKkq4V-EOfXo9b_gRbyC1hSs=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/23/22 21:24, Barnabás Pőcze wrote:
> Hi
> 
> 2022. szeptember 22., csütörtök 20:24 keltezéssel, Arvid Norlander írta:
> 
>> This is loosely based on a previous staging driver that was removed. See
>> links below for more info on that driver. The original commit ID was
>> 0be013e3dc2ee79ffab8a438bbb4e216837e3d52.
>>
>> However, here a completely different approach is taken to the user space
>> API (which should solve the issues the original driver had). Each PNP0C32
>> device is a button, and each such button gets a separate input device
>> associated with it (instead of a shared platform input device).
>>
>> The button ID (as read from ACPI method GHID) is provided via a sysfs file
>> "button_id".
>>
>> If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs file
>> to true. This can be reset by a user space process.
>>
>> Link: https://marc.info/?l=linux-acpi&m=120550727131007
>> Link: https://lkml.org/lkml/2010/5/28/327
>> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
>> ---
>> [...]
>> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
>> new file mode 100644
>> index 000000000000..ce51abe012f7
>> --- /dev/null
>> +++ b/drivers/platform/x86/quickstart.c
>> @@ -0,0 +1,320 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  quickstart.c - ACPI Direct App Launch driver
>> + *
>> + *  Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
>> + *  Copyright (C) 2007-2010 Angelo Arrifano <miknix@gmail.com>
>> + *
>> + *  Information gathered from disassembled dsdt and from here:
>> + *  <https://archive.org/details/microsoft-acpi-dirapplaunch>
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/types.h>
>> +#include <linux/acpi.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/input.h>
>> +#include <linux/input/sparse-keymap.h>
>> +#include <asm/unaligned.h>
>> +
>> +MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
>> +MODULE_AUTHOR("Angelo Arrifano");
>> +MODULE_DESCRIPTION("ACPI Direct App Launch driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +#define QUICKSTART_ACPI_DEVICE_NAME	"quickstart"
>> +#define QUICKSTART_ACPI_HID		"PNP0C32"
>> +
>> +/*
>> + * There will be two events:
>> + * 0x02 - A hot button was pressed while device was off/sleeping.
>> + * 0x80 - A hot button was pressed while device was up.
>> + */
>> +#define QUICKSTART_EVENT_WAKE		0x02
>> +#define QUICKSTART_EVENT_RUNTIME	0x80
>> +
>> +/*
>> + * Each PNP0C32 device is an individual button. This structure
>> + * keeps track of data associated with said device.
>> + */
>> +struct quickstart_acpi {
>> +	struct platform_device *platform_dev;
>> +	struct input_dev *input_device;
>> +	struct quickstart_button *button;
>> +	/* ID of button as returned by GHID */
>> +	u32 id;
>> +	/* Name of input device */
>> +	char input_name[32];
>> +	/* Physical path for the input device */
>> +	char phys[32];
>> +	/* Track if a wakeup event was received */
>> +	bool wakeup_cause;
>> +};
>> +
>> +#define quickstart_name(dev) acpi_device_bid(dev->acpi_dev)
> 
> This does not seem to be used.
> 
> 
>> +
>> +/*
>> + * Knowing what these buttons do require system specific knowledge.
>> + * This could be done by matching on DMI data in a long quirk table.
>> + * However, it is easier to leave it up to user space to figure this out.
>> + *
>> + * Using for example udev hwdb the scancode 0x1 can be remapped suitably.
>> + */
>> +static const struct key_entry quickstart_keymap[] = {
>> +	{ KE_KEY, 0x1, { KEY_UNKNOWN } },
>> +	{ KE_END, 0 },
>> +};
>> +
>> +static ssize_t wakeup_cause_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%s\n",
>> +			  (quickstart->wakeup_cause ? "true" : "false"));
>> +}
>> +
>> +static ssize_t wakeup_cause_store(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
>> +
>> +	if (count < 2)
>> +		return -EINVAL;
>> +
>> +	if (strncasecmp(buf, "false", 4) != 0)
>> +		return -EINVAL;
>> +
> 
> If "true"/"false" will be used in the final version, then I think this check
> currently is too lax. You could use `sysfs_streq()`. And I think the `count < 2`
> check is not needed.
> 
> 
>> +	quickstart->wakeup_cause = false;
>> +	return count;
>> +}
>> +static DEVICE_ATTR_RW(wakeup_cause);
>> +
>> +static ssize_t button_id_show(struct device *dev, struct device_attribute *attr,
>> +			      char *buf)
>> +{
>> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%u\n", quickstart->id);
>> +}
>> +static DEVICE_ATTR_RO(button_id);
>> +
>> +/* ACPI Driver functions */
>> +static void quickstart_acpi_notify(acpi_handle handle, u32 event, void *context)
>> +{
>> +	struct platform_device *device = context;
>> +	struct quickstart_acpi *quickstart = dev_get_drvdata(&device->dev);
>> +
>> +	if (!quickstart)
>> +		return;
>> +
>> +	switch (event) {
>> +	case QUICKSTART_EVENT_WAKE:
>> +		quickstart->wakeup_cause = true;
>> +		break;
>> +	case QUICKSTART_EVENT_RUNTIME:
>> +		if (!sparse_keymap_report_event(quickstart->input_device, 0x1,
>> +						1, true)) {
>> +			pr_info("Key handling error\n");
> 
> I don't think this branch can ever be taken.

True, might just as well drop the if and simply call sparse_keymap_report_event()
without checking the result.

> 
> 
>> +		}
>> +		break;
>> +	default:
>> +		pr_err("Unexpected ACPI event notify (%u)\n", event);
> 
> I think `dev_{err,info}()` should be preferred.
> 
> 
>> +		break;
>> +	}
>> +}
>> +
>> +/*
>> + * The GHID ACPI method is used to indicate the "role" of the button.
>> + * However, all the meanings of these values are vendor defined.
>> + *
>> + * We do however expose this value to user space.
>> + */
>> +static int quickstart_acpi_ghid(struct quickstart_acpi *quickstart)
>> +{
>> +	acpi_handle handle = ACPI_HANDLE(&quickstart->platform_dev->dev);
>> +	acpi_status status;
>> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	int ret = 0;
>> +	union acpi_object *obj = NULL;
>> +
>> +	/*
>> +	 * This returns a buffer telling the button usage ID,
>> +	 * and triggers pending notify events (The ones before booting).
>> +	 */
>> +	status = acpi_evaluate_object(handle, "GHID", NULL, &buffer);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(&quickstart->platform_dev->dev,
>> +			"GHID method failed, ACPI status %u\n", status);
>> +		return -EINVAL;
>> +	}
>> +	obj = buffer.pointer;
>> +
>> +	/*
>> +	 * GHID returns buffers, sanity check that is the case.
>> +	 */
>> +	if (obj->type != ACPI_TYPE_BUFFER) {
>> +		dev_err(&quickstart->platform_dev->dev,
>> +			"GHID did not return buffer\n");
>> +		ret = -EINVAL;
>> +		goto free_and_return;
>> +	}
>> +
>> +	/*
>> +	 * Quoting the specification:
>> +	 * "The GHID method can return a BYTE, WORD, or DWORD.
>> +	 *  The value must be encoded in little-endian byte
>> +	 *  order (least significant byte first)."
>> +	 */
>> +	switch (obj->buffer.length) {
>> +	case 1:
>> +		quickstart->id = *(u8 *)obj->buffer.pointer;
>> +		break;
>> +	case 2:
>> +		quickstart->id = get_unaligned_le16(obj->buffer.pointer);
>> +		break;
>> +	case 4:
>> +		quickstart->id = get_unaligned_le32(obj->buffer.pointer);
>> +		break;
>> +	case 8:
>> +		quickstart->id = get_unaligned_le64(obj->buffer.pointer);
>> +		break;
>> +	default:
>> +		dev_err(&quickstart->platform_dev->dev,
>> +			"GHID method returned buffer of unexpected length %lu\n",
>> +			(unsigned long)obj->buffer.length);
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +free_and_return:
>> +	kfree(buffer.pointer);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct attribute *quickstart_attributes[] = {
>> +	&dev_attr_wakeup_cause.attr,
>> +	&dev_attr_button_id.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group quickstart_attr_group = {
>> +	.attrs = quickstart_attributes,
>> +};
>> +
>> +static int quickstart_remove(struct platform_device *device)
>> +{
>> +	acpi_handle handle = ACPI_HANDLE(&device->dev);
>> +
>> +	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY,
>> +				   quickstart_acpi_notify);
>> +
>> +	return 0;
>> +}
>> +
>> +static int quickstart_probe(struct platform_device *device)
>> +{
>> +	int ret;
>> +	acpi_handle handle = ACPI_HANDLE(&device->dev);
>> +	acpi_status status;
>> +	struct quickstart_acpi *quickstart;
>> +
>> +	if (!device)
>> +		return -EINVAL;
>> +
>> +	quickstart =
>> +		devm_kzalloc(&device->dev, sizeof(*quickstart), GFP_KERNEL);
>> +	if (!quickstart)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * This must be set early for proper cleanup on error handling path.
>> +	 * After this point generic error handling can be used.
>> +	 */
>> +	quickstart->platform_dev = device;
>> +	dev_set_drvdata(&device->dev, quickstart);
>> +
>> +	/* Retrieve the GHID ID */
>> +	ret = quickstart_acpi_ghid(quickstart);
>> +	if (ret < 0)
>> +		goto error;
> 
> You can replace all `goto`s in this function with `return`s. In fact, you should
> because `quickstart_remove()` does not do useful work until the ACPI notify handler
> is registered, but if that succeeds, this function can no longer fail.
> 
> 
>> +
>> +	/* Set up sysfs entries */
>> +	ret = devm_device_add_group(&quickstart->platform_dev->dev,
>> +				    &quickstart_attr_group);
> 
> In the meantime I realized there is a simpler solution. Use the `ATTRIBUTE_GROUPS()`
> macro and then simply set the `.dev_groups` member of `quickstart_platform_driver.driver`.
> (see drivers/platform/x86/hp-wmi.c)

Ack yes please, using .dev_groups is greatly preferred.

> 
> 
>> +	if (ret) {
>> +		dev_err(&device->dev, "Unable to setup sysfs entries\n");
>> +		goto error;
>> +	}
>> +
>> +	/* Set up input device */
>> +	quickstart->input_device =
>> +		devm_input_allocate_device(&quickstart->platform_dev->dev);
>> +	if (!quickstart->input_device) {
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +	ret = sparse_keymap_setup(quickstart->input_device, quickstart_keymap,
>> +				  NULL);
>> +	if (ret)
>> +		goto error;
>> +
>> +	snprintf(quickstart->input_name, sizeof(quickstart->phys),
>> +		 "Quickstart Button %u", quickstart->id);
>> +	snprintf(quickstart->phys, sizeof(quickstart->phys),
>> +		 QUICKSTART_ACPI_DEVICE_NAME "/input%u", quickstart->id);
>> +
>> +	quickstart->input_device->name = quickstart->input_name;
>> +	quickstart->input_device->phys = quickstart->phys;
>> +	quickstart->input_device->id.bustype = BUS_HOST;
>> +
>> +	ret = input_register_device(quickstart->input_device);
>> +
>> +	/* Set up notify handler */
>> +	status = acpi_install_notify_handler(handle, ACPI_DEVICE_NOTIFY,
>> +					     quickstart_acpi_notify, device);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(&device->dev, "Error installing notify handler\n");
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +error:
>> +	quickstart_remove(device);
>> +	return ret;
>> +}
>> +
>> +static const struct acpi_device_id quickstart_device_ids[] = {
>> +	{ QUICKSTART_ACPI_HID, 0 },
>> +	{ "", 0 },
> 
> Small thing, but usually the comma after the sentinel entry is omitted.
> (see quickstart_keymap, quickstart_attributes as well)
> 
> 
>> +};
>> +MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
>> +
>> +static struct platform_driver quickstart_platform_driver = {
>> +	.probe	= quickstart_probe,
>> +	.remove	= quickstart_remove,
>> +	.driver	= {
>> +		.name = QUICKSTART_ACPI_DEVICE_NAME,
>> +		.acpi_match_table = quickstart_device_ids,
>> +		.owner = THIS_MODULE,
>> +	}
>> +};
>> +
>> +module_platform_driver(quickstart_platform_driver);
>> --
>> 2.37.3
> 
> 
> Regards,
> Barnabás Pőcze
> 

Regards,

Hans

