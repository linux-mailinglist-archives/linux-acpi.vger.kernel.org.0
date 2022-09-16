Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA15BAE48
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Sep 2022 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIPNgr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Sep 2022 09:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiIPNgp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Sep 2022 09:36:45 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1763AC26A;
        Fri, 16 Sep 2022 06:36:36 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 7A54C147E0;
        Fri, 16 Sep 2022 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1663335395; bh=7e6A48/pa44LVd/S8+GoF1rZGDzPfndFMWDf73mWw+c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HRDn/Mo8UyAh8EaYz1aBI05rzSNlMgkaOdFmuBSQLnB1tZkpOcJvIWUo2mTDygOMF
         WELVlcQ/0BTK6OrhZIa+ovg2wOVI0r75gvpRoXJZTun02+IqVtV1ox+M5BFDTEBJN6
         C3yWUi4sGeRZQEkYVcPtB9mMsXFalpEm0EqMeV6taaPHh1zLuLrDH3PLywlaPWXB4u
         SKVJuo5fhfUCTWFKE52tu7NcZYyVO3f99F4szTbqltAaxYHYRKdMDeAB03JHm4FVj+
         x+rEljqFDrIy5cwiTJDiFtRmdYiNpYZNI2JK9SfOwlTPWWpyuzCayYV8MTpbyOQzZd
         rCz8PR2jo3XMQ==
Message-ID: <be888665-396f-c8a0-04ad-b91433cbf03c@vorpal.se>
Date:   Fri, 16 Sep 2022 15:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RFC 1/2] staging: quickstart: Add ACPI quickstart button
 (PNP0C32) driver
Content-Language: en-US
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220911194934.558019-1-lkml@vorpal.se>
 <20220911194934.558019-2-lkml@vorpal.se>
 <drXHqh3nyou52BleUraC71bm5y1IXzb1kfROkRvfC-PXNoNbaxfYrq8Lj-_8aS4pFl0RHy7ts9fkz-uw_dMy0jaf5Yx8Rw5InWgZduKnojE=@protonmail.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <drXHqh3nyou52BleUraC71bm5y1IXzb1kfROkRvfC-PXNoNbaxfYrq8Lj-_8aS4pFl0RHy7ts9fkz-uw_dMy0jaf5Yx8Rw5InWgZduKnojE=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2022-09-14 20:27, Barnabás Pőcze wrote:
> Hi
> 
> 2022. szeptember 11., vasárnap 21:49 keltezéssel, Arvid Norlander írta:
> 
>> This is loosly based on a previous staging driver that was removed. See
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
>> [...]
>> +#define QUICKSTART_VERSION "1.04"
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/types.h>
>> +#include <linux/acpi.h>
>> +#include <linux/input.h>
>> +#include <linux/input/sparse-keymap.h>
>> +
>> +MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
>> +MODULE_AUTHOR("Angelo Arrifano");
>> +MODULE_DESCRIPTION("ACPI Direct App Launch driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +#define QUICKSTART_ACPI_DEVICE_NAME	"quickstart"
>> +#define QUICKSTART_ACPI_CLASS		"quickstart"
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
>> +	struct acpi_device *acpi_dev;
>> +	struct input_dev *input_device;
>> +	struct quickstart_button *button;
>> +	/* Name of button for debug messages */
>> +	char *name;
>> +	/* ID of button as returned by GHID */
>> +	u32 id;
>> +	/* Flags for cleanup */
>> +	unsigned int input_registered : 1;
> 
> This member is set, but never read.

Right, I switched to the devm_ version, so I believe it is no longer
needed. I'll remove it.

> 
> 
>> +	unsigned int sysfs_created : 1;
>> +	/* Track if a wakeup event was received */
>> +	unsigned int wakeup_cause : 1;
>> +	/* Name of input device */
>> +	char input_name[32];
>> +	/* Physical path for the input device */
>> +	char phys[32];
>> +};
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
>> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
>> +			 (quickstart->wakeup_cause ? "true" : "false"));
> 
> Please use `sysfs_emit()` preferably. And I think it would be easier to use 0/1
> instead of true/false. And you could use `kstrtobool()` in the _store() function.

Thanks! As I'm new to kernel development it is sometimes hard to know the
proper API. While there is some API documentation for the most part I have
not found any good tutorials or overviews. Basically you have to know what
you are looking for already in order to find it.

Thus I have taken to looking at existing drivers and copying the patterns
from those. However it is very hard to know what drivers use the currently
preferred patterns, and which ones use legacy patterns. Better documentation
would be great.

> 
> 
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
>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", quickstart->id);
> 
> Since it is unsigned `%u` would probably be better.

Good catch! Thanks. I wonder why I didn't get any -Wformat warnings about
this?

> 
> 
>> +}
>> +static DEVICE_ATTR_RO(button_id);
>> +
>> +/* ACPI Driver functions */
>> +static void quickstart_acpi_notify(struct acpi_device *acpi_dev, u32 event)
>> +{
>> +	struct quickstart_acpi *quickstart = acpi_driver_data(acpi_dev);
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
>> +		}
>> +		break;
>> +	default:
>> +		pr_err("Unexpected ACPI event notify (%u)\n", event);
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
>> +	acpi_status status;
>> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	int ret = 0;
>> +	union acpi_object *obj = NULL;
>> +
>> +	/*
>> +	 * This returns a buffer telling the button usage ID,
>> +	 * and triggers pending notify events (The ones before booting).
>> +	 */
>> +	status = acpi_evaluate_object(quickstart->acpi_dev->handle, "GHID",
>> +				      NULL, &buffer);
>> +	if (ACPI_FAILURE(status)) {
>> +		pr_err("%s GHID method failed\n", quickstart->name);
>> +		return -EINVAL;
>> +	}
>> +	obj = buffer.pointer;
>> +
>> +	/*
>> +	 * GHID returns buffers, sanity check that is the case.
>> +	 */
>> +	if (obj->type != ACPI_TYPE_BUFFER) {
>> +		pr_err("%s GHID did not return buffer\n", quickstart->name);
>> +		return -EINVAL;
> 
> `buffer.pointer` is not freed here. Since you know the maximum size, you could
> consider using an on-stack buffer.

Good catch! I thought about onstack buffer but couldn't get it working.
However I believe I was confused by the API at the point, and didn't
realise that "acpi_buffer" is not in fact the same as a buffer object in
ACPI. So it might be worth trying again.

> 
> 
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
>> +		quickstart->id = le16_to_cpu(*(u16 *)obj->buffer.pointer);
> 
> Probably does not matter here, but I personally like to use `get_unaligned_leN()`
> because those functions just always work.

This goes back to the whole "I know what I want to do, but I don't know
what the API is named, lets see what others are doing." thing I mentioned
above.

As you said, this is probably fine, as I doubt anyone has used this ACPI
standard on anything except x86, where unaligned reads are fine. Even the
whole endianness conversion will *probably* never come up in practise for
this driver.

> 
> 
>> +		break;
>> +	case 4:
>> +		quickstart->id = le32_to_cpu(*(u32 *)obj->buffer.pointer);
>> +		break;
>> +	case 8:
>> +		quickstart->id = le64_to_cpu(*(u64 *)obj->buffer.pointer);
>> +		break;
>> +	default:
>> +		pr_err("%s GHID method returned buffer of unexpected length %lu\n",
>> +		       quickstart->name, (unsigned long)obj->buffer.length);
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	kfree(buffer.pointer);
>> +
>> +	return ret;
>> +}
>> +
>> +static int quickstart_acpi_config(struct quickstart_acpi *quickstart)
>> +{
>> +	char *bid = acpi_device_bid(quickstart->acpi_dev);
>> +	char *name;
>> +
>> +	name = kmalloc(strlen(bid) + 1, GFP_KERNEL);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	quickstart->name = name;
>> +	strcpy(quickstart->name, bid);
> 
> You could use `kstrdup()` here, but you could probably even use `devm_kstrdup()`
> and then this function could be entirely removed.

Again, we are back to copying patterns from other drivers. Would be great
if there was a way to know which drivers were following current guidelines.
Maybe each subsystem could have a "model" driver, that they could point to
for current best practices?

However, I realised there is in fact no need to store a copy at all. We can
just define

#define quickstart_name(dev) acpi_device_bid(dev->acpi_dev)

and use that. As acpi_device_bid is itself just a macro that returns a
member.

> 
> 
>> +
>> +	return 0;
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
>> +static int quickstart_acpi_remove(struct acpi_device *acpi_dev)
>> +{
>> +	struct quickstart_acpi *quickstart;
>> +
>> +	if (!acpi_dev)
>> +		return -EINVAL;
>> +
>> +	quickstart = acpi_driver_data(acpi_dev);
>> +	if (!quickstart)
>> +		return -EINVAL;
>> +
>> +	if (quickstart->sysfs_created)
>> +		sysfs_remove_group(&quickstart->acpi_dev->dev.kobj,
>> +				   &quickstart_attr_group);
>> +
>> +	kfree(quickstart->name);
>> +	quickstart->name = NULL;
>> +
>> +	kfree(quickstart);
>> +
>> +	return 0;
>> +}
>> +
>> +static int quickstart_acpi_add(struct acpi_device *acpi_dev)
>> +{
>> +	int ret;
>> +	struct quickstart_acpi *quickstart;
>> +
>> +	if (!acpi_dev)
>> +		return -EINVAL;
>> +
>> +	quickstart = kzalloc(sizeof(*quickstart), GFP_KERNEL);
> 
> Have you considered `devm_kzalloc()`?

Again no. In this case it didn't come from copying something, but from
the old quickstart driver code from 2010.

I'm switching to this devm_ stuff, seems awesome.

> 
> 
>> +	if (!quickstart)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * This must be set early for proper cleanup on error handling path.
>> +	 * After this point generic error handling can be used.
>> +	 */
>> +	acpi_dev->driver_data = quickstart;
>> +	quickstart->acpi_dev = acpi_dev;
>> +	dev_set_drvdata(&acpi_dev->dev, quickstart);
>> +
>> +	strcpy(acpi_device_name(acpi_dev), QUICKSTART_ACPI_DEVICE_NAME);
>> +	strcpy(acpi_device_class(acpi_dev), QUICKSTART_ACPI_CLASS);
>> +
>> +	/* Initialize device name */
>> +	ret = quickstart_acpi_config(quickstart);
>> +	if (ret < 0)
>> +		goto error;
>> +
>> +	/* Retrieve the GHID ID */
>> +	ret = quickstart_acpi_ghid(quickstart);
>> +	if (ret < 0)
>> +		goto error;
>> +
>> +	/* Set up sysfs entries */
>> +	ret = sysfs_create_group(&quickstart->acpi_dev->dev.kobj,
>> +				 &quickstart_attr_group);
> 
> You could use `devm_device_add_group()`. And then the `sysfs_created` member
> could be removed.

Oh, nice.

> 
> 
>> +	if (ret) {
>> +		quickstart->sysfs_created = 0;
>> +		pr_err("Unable to setup sysfs entries\n");
>> +		goto error;
>> +	}
>> +	quickstart->sysfs_created = !ret;
>> +
>> +	/* Set up input device */
>> +	quickstart->input_device =
>> +		devm_input_allocate_device(&quickstart->acpi_dev->dev);
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
>> +	if (ret) {
>> +		quickstart->input_registered = 0;
>> +		pr_err("Unable to register input device\n");
>> +		goto error;
>> +	}
>> +	quickstart->input_registered = !ret;
>> +
>> +	return 0;
>> +error:
>> +	quickstart_acpi_remove(acpi_dev);
>> +	return ret;
>> +}
>> +
>> +static const struct acpi_device_id quickstart_device_ids[] = {
>> +	{ QUICKSTART_ACPI_HID, 0 },
>> +	{ "", 0 },
>> +};
>> +MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
>> +
>> +static struct acpi_driver quickstart_acpi_driver = {
>> +	.name	= "quickstart",
>> +	.owner	= THIS_MODULE,
>> +	.class	= QUICKSTART_ACPI_CLASS,
>> +	.ids	= quickstart_device_ids,
>> +	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>> +	.ops	= {
>> +		.add = quickstart_acpi_add,
>> +		.remove = quickstart_acpi_remove,
>> +		.notify = quickstart_acpi_notify
>> +	},
>> +};
>> +
>> +/* Module functions */
>> +static void quickstart_exit(void)
>> +{
>> +	acpi_bus_unregister_driver(&quickstart_acpi_driver);
>> +}
>> +
>> +static int __init quickstart_init(void)
>> +{
>> +	int ret;
>> +
>> +	/* ACPI driver register */
>> +	ret = acpi_bus_register_driver(&quickstart_acpi_driver);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pr_info("ACPI Direct App Launch ver %s\n", QUICKSTART_VERSION);
>> +
>> +	return 0;
>> +}
>> +
>> +module_init(quickstart_init);
>> +module_exit(quickstart_exit);
> 
> You could use the `module_acpi_driver()` macro to generate the init/exit methods.

Nice!

> 
> 
>> --
>> 2.37.3
> 
> 
> Regards,
> Barnabás Pőcze

I have fixed these locally, and will submit a new patch at the beginning of
next week. I was hoping to get some feedback on the open questions in the
cover letter before that, but right now that doesn't seem likely to happen.

Best regards,
Arvid Norlander
