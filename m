Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD015EC50B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiI0Ny6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiI0Ny4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 09:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8564A822
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664286892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFzWTqg7ruOuMFEnKyj9bxOrUs1pn+4Pk6/g3H0UuoQ=;
        b=gleSCSBIcSJOoql4vo1gQV1Z5/IR1fvsNKzK0hc6tapuJHiDpjtxtHo2uVx6T/RSFMJxVU
        09pa+cRCWReoEQOpH471M85III7MYun1ExvbUz8QnSE2tAJds+jyEjE/sOflX737c5ndrJ
        2C8K/K/MQGhWb2mqgvkry1GvntnrkaM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-p4LGQJlVNc67s2A1IBPhoQ-1; Tue, 27 Sep 2022 09:54:51 -0400
X-MC-Unique: p4LGQJlVNc67s2A1IBPhoQ-1
Received: by mail-ej1-f71.google.com with SMTP id du10-20020a17090772ca00b00782e5bc9641so3610216ejc.23
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yFzWTqg7ruOuMFEnKyj9bxOrUs1pn+4Pk6/g3H0UuoQ=;
        b=h1gvoD4b6y5sfrfRtv8pF1tvVqP44UixUgRTt+H1h5l1BHvtXZVNJwej0dc5pxcJan
         7+zGv8Y36oy/cm4JzRu65s5skkkJX4NvJozupAbEUbQSl8KDSKBmPgZKWF5/E6S8Ypf8
         PfXWbQ+rm+eZZbl1ppTT14Vlymn/+Mq+lr5tP++MI7nqu0RCjikfykNBLBktBnB2gYU2
         OtiiVdJv0/zopf/0udSzcAt1ZskHY7NFdB555TBDPkicIhtv6svn8A9g/RXTjjDUCI1e
         6RR0Na3P/WuoAgsIwpZaFBInCnZalNUQJF5mhWlU+fBuYTM/6aeUu50FHKhL8PlbrBFf
         2KHQ==
X-Gm-Message-State: ACrzQf0kpVABIa5UoXF1qpsostaMf0ybKYCxRYGelS1ujeSq9DAIO6y1
        w1DphmYd2NUA7pBf1lqvKuaWw3TI3trjLfXy72Fp+o3Wx4hz6giygugZzkRofAjPl+qfNjeZIZr
        F+qWpBSrbP3YfeA970bu7SQ==
X-Received: by 2002:a17:907:7f1e:b0:783:4f25:39c1 with SMTP id qf30-20020a1709077f1e00b007834f2539c1mr10782914ejc.160.1664286886992;
        Tue, 27 Sep 2022 06:54:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6vfc+y+BCHoreRx7vSsbDNVO2bEWZe13YRu0e91G8JnDCf1EqiwdHvGwQ54C6OrKnPkEfvNw==
X-Received: by 2002:a17:907:7f1e:b0:783:4f25:39c1 with SMTP id qf30-20020a1709077f1e00b007834f2539c1mr10782744ejc.160.1664286885735;
        Tue, 27 Sep 2022 06:54:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090632c200b0074150f51d86sm815969ejk.162.2022.09.27.06.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:54:45 -0700 (PDT)
Message-ID: <36cc9c55-bc8c-ed9e-3467-8be0aa450167@redhat.com>
Date:   Tue, 27 Sep 2022 15:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC v2 1/2] platform/x86: quickstart: Add ACPI quickstart
 button (PNP0C32) driver
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
References: <20220922182424.934340-1-lkml@vorpal.se>
 <20220922182424.934340-2-lkml@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220922182424.934340-2-lkml@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/22/22 20:24, Arvid Norlander wrote:
> This is loosely based on a previous staging driver that was removed. See
> links below for more info on that driver. The original commit ID was
> 0be013e3dc2ee79ffab8a438bbb4e216837e3d52.
> 
> However, here a completely different approach is taken to the user space
> API (which should solve the issues the original driver had). Each PNP0C32
> device is a button, and each such button gets a separate input device
> associated with it (instead of a shared platform input device).
> 
> The button ID (as read from ACPI method GHID) is provided via a sysfs file
> "button_id".
> 
> If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs file
> to true. This can be reset by a user space process.
> 
> Link: https://marc.info/?l=linux-acpi&m=120550727131007
> Link: https://lkml.org/lkml/2010/5/28/327
> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
> ---
>  drivers/platform/x86/Kconfig      |  13 ++
>  drivers/platform/x86/Makefile     |   3 +
>  drivers/platform/x86/quickstart.c | 320 ++++++++++++++++++++++++++++++
>  3 files changed, 336 insertions(+)
>  create mode 100644 drivers/platform/x86/quickstart.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index f5312f51de19..eebd70ef4a7c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -685,6 +685,18 @@ config THINKPAD_LMI
>  
>  source "drivers/platform/x86/intel/Kconfig"
>  
> +config ACPI_QUICKSTART
> +	tristate "ACPI Quickstart key driver"
> +	depends on ACPI
> +	depends on INPUT
> +	select INPUT_SPARSEKMAP
> +	help
> +	  Say Y here if you have a platform that supports the ACPI
> +	  quickstart key protocol.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called quickstart.
> +
>  config MSI_LAPTOP
>  	tristate "MSI Laptop Extras"
>  	depends on ACPI
> @@ -803,6 +815,7 @@ config ACPI_TOSHIBA
>  	depends on RFKILL || RFKILL = n
>  	depends on IIO
>  	select INPUT_SPARSEKMAP
> +	select ACPI_QUICKSTART
>  	help
>  	  This driver adds support for access to certain system settings
>  	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 5a428caa654a..a8a8e1ddb2a3 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -72,6 +72,9 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  # Intel
>  obj-y				+= intel/
>  
> +# Microsoft
> +obj-$(CONFIG_ACPI_QUICKSTART)	+= quickstart.o
> +
>  # MSI
>  obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
>  obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
> new file mode 100644
> index 000000000000..ce51abe012f7
> --- /dev/null
> +++ b/drivers/platform/x86/quickstart.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  quickstart.c - ACPI Direct App Launch driver
> + *
> + *  Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
> + *  Copyright (C) 2007-2010 Angelo Arrifano <miknix@gmail.com>
> + *
> + *  Information gathered from disassembled dsdt and from here:
> + *  <https://archive.org/details/microsoft-acpi-dirapplaunch>

SPDX fully covers all the license stuff, so please drop the below
part of this comment block:

> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *

And stop dropping the comment here (obviously).

> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <asm/unaligned.h>
> +
> +MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
> +MODULE_AUTHOR("Angelo Arrifano");
> +MODULE_DESCRIPTION("ACPI Direct App Launch driver");
> +MODULE_LICENSE("GPL");
> +
> +#define QUICKSTART_ACPI_DEVICE_NAME	"quickstart"
> +#define QUICKSTART_ACPI_HID		"PNP0C32"
> +
> +/*
> + * There will be two events:
> + * 0x02 - A hot button was pressed while device was off/sleeping.
> + * 0x80 - A hot button was pressed while device was up.
> + */
> +#define QUICKSTART_EVENT_WAKE		0x02
> +#define QUICKSTART_EVENT_RUNTIME	0x80
> +
> +/*
> + * Each PNP0C32 device is an individual button. This structure
> + * keeps track of data associated with said device.
> + */
> +struct quickstart_acpi {
> +	struct platform_device *platform_dev;

Everywhere where this is used you use platform_dev->dev,
instead please just store &platform_dev->dev in a
struct device *dev here.

> +	struct input_dev *input_device;
> +	struct quickstart_button *button;
> +	/* ID of button as returned by GHID */
> +	u32 id;
> +	/* Name of input device */
> +	char input_name[32];
> +	/* Physical path for the input device */
> +	char phys[32];
> +	/* Track if a wakeup event was received */
> +	bool wakeup_cause;
> +};
> +
> +#define quickstart_name(dev) acpi_device_bid(dev->acpi_dev)
> +
> +/*
> + * Knowing what these buttons do require system specific knowledge.
> + * This could be done by matching on DMI data in a long quirk table.
> + * However, it is easier to leave it up to user space to figure this out.
> + *
> + * Using for example udev hwdb the scancode 0x1 can be remapped suitably.
> + */
> +static const struct key_entry quickstart_keymap[] = {
> +	{ KE_KEY, 0x1, { KEY_UNKNOWN } },
> +	{ KE_END, 0 },
> +};
> +
> +static ssize_t wakeup_cause_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  (quickstart->wakeup_cause ? "true" : "false"));
> +}
> +
> +static ssize_t wakeup_cause_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
> +
> +	if (count < 2)
> +		return -EINVAL;
> +
> +	if (strncasecmp(buf, "false", 4) != 0)
> +		return -EINVAL;
> +
> +	quickstart->wakeup_cause = false;
> +	return count;
> +}
> +static DEVICE_ATTR_RW(wakeup_cause);

I think it would be best here to just use the standard kernel boolean
convention like how it is also used for bool type module parameters,
then you would get something like this:

static ssize_t wakeup_cause_show(struct device *dev,
				 struct device_attribute *attr, char *buf)
{
	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);

	return sysfs_emit(buf, "%c\n", quickstart->wakeup_cause ? 'Y' : 'N');
}

static ssize_t wakeup_cause_store(struct device *dev,
				  struct device_attribute *attr,
				  const char *buf, size_t count)
{
	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
	bool value;
	int ret;

	ret = kstrtobool(buf, &value);
	if (ret)
		return ret;

	/* Only allow clearing, not setting */
	if (value)
		return -EINVAL;

	quickstart->wakeup_cause = false;
	return count;
}
static DEVICE_ATTR_RW(wakeup_cause);

Note I have chosen to show 'Y' and 'N' as values when reading because
that is what the kernel does when showing bool module parameters under
/sys/modules/*/parameters/*

But if you prefer to keep the true/false strings that is fine too.

Note you should also add a Documentation/ABI/testing/sysfs-platform-PNP0C32 or
Documentation/ABI/testing/sysfs-platform-quickstart file documenting the
sysfs attributes. So that whatever you chose (Y/N vs true/false) is
documented.

I think that Documentation/ABI/testing/sysfs-platform-PNP0C32 will
be easier to find for users since that is the name of the devices under
/sys/bus/platform/devices, but either suggested name works for me.


> +static ssize_t button_id_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", quickstart->id);
> +}
> +static DEVICE_ATTR_RO(button_id);
> +
> +/* ACPI Driver functions */
> +static void quickstart_acpi_notify(acpi_handle handle, u32 event, void *context)
> +{
> +	struct platform_device *device = context;
> +	struct quickstart_acpi *quickstart = dev_get_drvdata(&device->dev);
> +
> +	if (!quickstart)
> +		return;
> +
> +	switch (event) {
> +	case QUICKSTART_EVENT_WAKE:
> +		quickstart->wakeup_cause = true;
> +		break;
> +	case QUICKSTART_EVENT_RUNTIME:
> +		if (!sparse_keymap_report_event(quickstart->input_device, 0x1,
> +						1, true)) {
> +			pr_info("Key handling error\n");
> +		}
> +		break;
> +	default:
> +		pr_err("Unexpected ACPI event notify (%u)\n", event);

Also as Barnabás mentioned already please use dev_*, so:

		dev_err(quickstart->dev, "Unexpected ACPI event notify (%u)\n", event);


> +		break;
> +	}
> +}
> +
> +/*
> + * The GHID ACPI method is used to indicate the "role" of the button.
> + * However, all the meanings of these values are vendor defined.
> + *
> + * We do however expose this value to user space.
> + */
> +static int quickstart_acpi_ghid(struct quickstart_acpi *quickstart)
> +{
> +	acpi_handle handle = ACPI_HANDLE(&quickstart->platform_dev->dev);
> +	acpi_status status;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	int ret = 0;
> +	union acpi_object *obj = NULL;
> +
> +	/*
> +	 * This returns a buffer telling the button usage ID,
> +	 * and triggers pending notify events (The ones before booting).
> +	 */
> +	status = acpi_evaluate_object(handle, "GHID", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&quickstart->platform_dev->dev,
> +			"GHID method failed, ACPI status %u\n", status);
> +		return -EINVAL;
> +	}
> +	obj = buffer.pointer;
> +
> +	/*
> +	 * GHID returns buffers, sanity check that is the case.
> +	 */
> +	if (obj->type != ACPI_TYPE_BUFFER) {
> +		dev_err(&quickstart->platform_dev->dev,
> +			"GHID did not return buffer\n");
> +		ret = -EINVAL;
> +		goto free_and_return;
> +	}
> +
> +	/*
> +	 * Quoting the specification:
> +	 * "The GHID method can return a BYTE, WORD, or DWORD.
> +	 *  The value must be encoded in little-endian byte
> +	 *  order (least significant byte first)."
> +	 */
> +	switch (obj->buffer.length) {
> +	case 1:
> +		quickstart->id = *(u8 *)obj->buffer.pointer;
> +		break;
> +	case 2:
> +		quickstart->id = get_unaligned_le16(obj->buffer.pointer);
> +		break;
> +	case 4:
> +		quickstart->id = get_unaligned_le32(obj->buffer.pointer);
> +		break;
> +	case 8:
> +		quickstart->id = get_unaligned_le64(obj->buffer.pointer);
> +		break;
> +	default:
> +		dev_err(&quickstart->platform_dev->dev,
> +			"GHID method returned buffer of unexpected length %lu\n",
> +			(unsigned long)obj->buffer.length);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +free_and_return:
> +	kfree(buffer.pointer);
> +
> +	return ret;
> +}
> +
> +static struct attribute *quickstart_attributes[] = {
> +	&dev_attr_wakeup_cause.attr,
> +	&dev_attr_button_id.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group quickstart_attr_group = {
> +	.attrs = quickstart_attributes,
> +};
> +
> +static int quickstart_remove(struct platform_device *device)
> +{
> +	acpi_handle handle = ACPI_HANDLE(&device->dev);
> +
> +	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY,
> +				   quickstart_acpi_notify);
> +
> +	return 0;
> +}
> +
> +static int quickstart_probe(struct platform_device *device)
> +{
> +	int ret;
> +	acpi_handle handle = ACPI_HANDLE(&device->dev);
> +	acpi_status status;
> +	struct quickstart_acpi *quickstart;
> +
> +	if (!device)
> +		return -EINVAL;
> +
> +	quickstart =
> +		devm_kzalloc(&device->dev, sizeof(*quickstart), GFP_KERNEL);
> +	if (!quickstart)
> +		return -ENOMEM;
> +
> +	/*
> +	 * This must be set early for proper cleanup on error handling path.
> +	 * After this point generic error handling can be used.
> +	 */
> +	quickstart->platform_dev = device;
> +	dev_set_drvdata(&device->dev, quickstart);
> +
> +	/* Retrieve the GHID ID */
> +	ret = quickstart_acpi_ghid(quickstart);
> +	if (ret < 0)
> +		goto error;
> +
> +	/* Set up sysfs entries */
> +	ret = devm_device_add_group(&quickstart->platform_dev->dev,
> +				    &quickstart_attr_group);
> +	if (ret) {
> +		dev_err(&device->dev, "Unable to setup sysfs entries\n");
> +		goto error;
> +	}
> +
> +	/* Set up input device */
> +	quickstart->input_device =
> +		devm_input_allocate_device(&quickstart->platform_dev->dev);
> +	if (!quickstart->input_device) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +	ret = sparse_keymap_setup(quickstart->input_device, quickstart_keymap,
> +				  NULL);
> +	if (ret)
> +		goto error;
> +
> +	snprintf(quickstart->input_name, sizeof(quickstart->phys),
> +		 "Quickstart Button %u", quickstart->id);
> +	snprintf(quickstart->phys, sizeof(quickstart->phys),
> +		 QUICKSTART_ACPI_DEVICE_NAME "/input%u", quickstart->id);
> +
> +	quickstart->input_device->name = quickstart->input_name;
> +	quickstart->input_device->phys = quickstart->phys;
> +	quickstart->input_device->id.bustype = BUS_HOST;
> +
> +	ret = input_register_device(quickstart->input_device);
> +
> +	/* Set up notify handler */
> +	status = acpi_install_notify_handler(handle, ACPI_DEVICE_NOTIFY,
> +					     quickstart_acpi_notify, device);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&device->dev, "Error installing notify handler\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +error:
> +	quickstart_remove(device);
> +	return ret;
> +}
> +
> +static const struct acpi_device_id quickstart_device_ids[] = {
> +	{ QUICKSTART_ACPI_HID, 0 },
> +	{ "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
> +
> +static struct platform_driver quickstart_platform_driver = {
> +	.probe	= quickstart_probe,
> +	.remove	= quickstart_remove,
> +	.driver	= {
> +		.name = QUICKSTART_ACPI_DEVICE_NAME,
> +		.acpi_match_table = quickstart_device_ids,
> +		.owner = THIS_MODULE,
> +	}
> +};
> +
> +module_platform_driver(quickstart_platform_driver);

Otherwise this looks good to me, thanks.

Regards,

Hans

