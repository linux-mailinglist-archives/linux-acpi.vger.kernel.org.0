Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77732C72A3
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Nov 2020 23:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgK1VuN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 16:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733101AbgK1SLg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 28 Nov 2020 13:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606587007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O98r963HmndUG3c5I7HP4JhIfccqAJB54HaIoGypOQ0=;
        b=Zc0JQbInWgsyw3gvXciOiPONxkhG1JouWNLkgSyc4ZBv23s9Vnc0svXnyD9JwDbz4OgUSU
        Hd0kiijnllBfM9XruLQL/b8+LZIn0Uoy3SnngxI5xZzrtYIaPd8E1srQYS4B+jSsuHf/A5
        E/eGiQcNKJpd6NcwBzKuyp3pheSXflY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-WI91dmaVPTW2YAAWa7__nQ-1; Sat, 28 Nov 2020 09:08:50 -0500
X-MC-Unique: WI91dmaVPTW2YAAWa7__nQ-1
Received: by mail-ed1-f71.google.com with SMTP id z20so1384525edl.21
        for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2020 06:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O98r963HmndUG3c5I7HP4JhIfccqAJB54HaIoGypOQ0=;
        b=qbnUbff060UuKAWSLwTiXKEB61cCQ5a4UTtlhp8EJw+Aj7qkUuRrPzzuKBt41hr3KJ
         3IGTXuljid+wdYwrDBokUEJ0mN1dzKcsNY87ZBR8FdQsEBfM3WoAVprDLyTA5Wnndd2U
         QmYWIzDdmxSp/YNOtN+ZsG0E62RjOU64BZ5BfySmFoTm15h1xZtPJtR+Pl72QZMnkZ1e
         bpigU0Ab9FdxlxKbakVgr8sQfMBGY1wNkzoc8sUh/Exagp11qVtCNJMbIUxvqJNsmM3o
         +TXH/b09UtO2VaKA6KA1oQ/DxgnvLD6BDdbY94viOCQaW3KY4JQKmptEH+AF/nEm+Mc1
         0ikA==
X-Gm-Message-State: AOAM530+zBng92acxQPy0rQOmoR3v5Wi1ePRWM7dn1LbxS8j5ijouS+T
        66YTcVvoT5ERhk7YFCv2WhMhfRcTC/H2azczY0WxNmjKRUuTGnn6ibaDvVTBNOgq9AEA5uBV+h2
        aNVrkfIscdSXM03CxfoKd9g==
X-Received: by 2002:a17:906:3187:: with SMTP id 7mr12901523ejy.225.1606572529025;
        Sat, 28 Nov 2020 06:08:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjHp0qlThyuAZQQmcBkK0tUzzq3AUkynBvlN3wCgpjXI6N5ebPwmvzDDi+TQy+WeeRcRWSvA==
X-Received: by 2002:a17:906:3187:: with SMTP id 7mr12901483ejy.225.1606572528573;
        Sat, 28 Nov 2020 06:08:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g15sm5967576edj.49.2020.11.28.06.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 06:08:47 -0800 (PST)
Subject: Re: [PATCH v4 2/3] ACPI: platform-profile: Add platform profile
 support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     mgross@linux.intel.com, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rjw@rjwysocki.net,
        hadess@hadess.net, pobrn@protonmail.com,
        mario.limnociello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        dvhart@infradead.org
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-2-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <faa32924-f53f-b3fd-3f24-3848f45b67e1@redhat.com>
Date:   Sat, 28 Nov 2020 15:08:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126165143.32776-2-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/26/20 5:51 PM, Mark Pearson wrote:
> This is the initial implementation of the platform-profile feature.
> It provides the details discussed and outlined in the
> sysfs-platform_profile document.
> 
> Many modern systems have the ability to modify the operating profile to
> control aspects like fan speed, temperature and power levels. This
> module provides a common sysfs interface that platform modules can register
> against to control their individual profile options.
> 
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> ---
> Changes in v2:
>  Address (hopefully) all recommendations from review including:
>  - reorder includes list alphabetically
>  - make globals statics and use const as required
>  - change profile name scanning to use full string
>  - clean up profile name lists to remove unwanted additions
>  - use sysfs_emit and sysfs_emit_at appropriately (much nicer!)
>  - improve error handling. Return errors to user in all cases and use
>    better error codes where appropriate (ENOOPSUPP)
>  - clean up sysfs output for better readability
>  - formatting fixes where needed
>  - improve structure and enum names to be clearer
>  - remove cur_profile field from structure. It is now local to the
>    actual platform driver file (patch 3 in series)
>  - improve checking so if future profile options are added profile_names
>    will be updated as well.
>  - move CONFIG option next to ACPI_THERMAL as it seemed slightly related
>  - removed MAINTAINERS update as not appropriate (note warning message
>    is seen when running checkpatch)
> 
> Changes in v3:
>  - Add missed platform_profile.h file
> 
> Changes in v4:
>  - Clean up duplicate entry in Kconfig file
>  - Add linux/bits.h to include list
>  - Remove unnecessary items from include list
>  - Make cur_profile const
>  - Clean up comments
>  - formatting clean-ups
>  - add checking of profile return value to show function
>  - add checking to store to see if it's a supported profile
>  - revert ENOTSUPP change in store function
>  - improved error checking in profile registration
>  - improved profile naming (now platform_profile_*)
> 
>  drivers/acpi/Kconfig             |  14 ++
>  drivers/acpi/Makefile            |   1 +
>  drivers/acpi/platform_profile.c  | 215 +++++++++++++++++++++++++++++++
>  include/linux/platform_profile.h |  36 ++++++
>  4 files changed, 266 insertions(+)
>  create mode 100644 drivers/acpi/platform_profile.c
>  create mode 100644 include/linux/platform_profile.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..c1ca6255ff85 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -326,6 +326,20 @@ config ACPI_THERMAL
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called thermal.
>  
> +config ACPI_PLATFORM_PROFILE
> +	tristate "ACPI Platform Profile Driver"
> +	default y
> +	help
> +	  This driver adds support for platform-profiles on platforms that
> +	  support it.
> +	  Platform-profiles can be used to control the platform behaviour. For
> +	  example whether to operate in a lower power mode, in a higher
> +	  power performance mode or between the two.
> +	  This driver provides the sysfs interface and is used as the registration
> +	  point for platform specific drivers.
> +	  Which profiles are supported is determined on a per-platform basis and
> +	  should be obtained from the platform specific driver.
> +
>  config ACPI_CUSTOM_DSDT_FILE
>  	string "Custom DSDT Table file to include"
>  	default ""
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 44e412506317..c64a8af106c0 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
>  obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
>  obj-$(CONFIG_ACPI)		+= container.o
>  obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
> +obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
>  obj-$(CONFIG_ACPI_NFIT)		+= nfit/
>  obj-$(CONFIG_ACPI_NUMA)		+= numa/
>  obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> new file mode 100644
> index 000000000000..678cb4596ada
> --- /dev/null
> +++ b/drivers/acpi/platform_profile.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/* Platform profile sysfs interface */
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/init.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_profile.h>
> +#include <linux/sysfs.h>
> +
> +static const struct platform_profile_handler *cur_profile;
> +static DEFINE_MUTEX(profile_lock);
> +
> +static const char * const profile_names[] = {
> +	[platform_profile_low] = "low-power",
> +	[platform_profile_cool] = "cool",
> +	[platform_profile_quiet] = "quiet",
> +	[platform_profile_balance] = "balance",

As Barnabás already pointed out the docs added in patch 1 say "balanced"
and here you use "balance" both in the enum value/label as we as in
the actual string. I have a slight preference for balanced, but the
most important thing here is being consistent everywhere.

> +	[platform_profile_perform] = "performance",
> +};
> +static_assert(ARRAY_SIZE(profile_names) == platform_profile_perform+1);

It would be better to add an extra member/entry at the end of the enum
named platform_profile_no_profiles; and then use that instead of
platform_profile_perform+1. Also see below where I use this too.

> +
> +static ssize_t platform_profile_choices_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	int len = 0;
> +	int err, i;
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;
> +
> +	if (!cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -ENODEV;
> +	}
> +
> +	if (!cur_profile->choices) {
> +		mutex_unlock(&profile_lock);
> +		return sysfs_emit(buf, "\n");
> +	}

If choices is empty, the for below will never print anything and
the end result is still just emitting "\n", so this whole if
block is unnecessary and can be removed.

> +
> +	for (i = 0; i < ARRAY_SIZE(profile_names); i++) {
> +		if (cur_profile->choices & BIT(i)) {

Please change the type of choices to an unsigned long array, like this:

	unsigned long choices[BITS_TO_LONGS(platform_profile_no_profiles)];

And then replace the for + if with:

	for_each_set_bit(i, cur_profile->choices, platform_profile_no_profiles) {

This has 2 advantages:
1. Using for_each_set_bit is nicer then open coding it
2. If we ever go over 32 profile choices this will keep working automatically
   without needing any adjustment to the code.

Note this requires include/linux/bitops.h (in include/linux/platform_profile.h,
since you will be using BITS_TO_LONGS there).

> +			if (len == 0)
> +				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +			else
> +				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +		}
> +	}
> +	len += sysfs_emit_at(buf, len, "\n");
> +	mutex_unlock(&profile_lock);
> +	return len;
> +}
> +
> +static ssize_t platform_profile_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	enum platform_profile_option profile = platform_profile_balance;
> +	int err;
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;
> +
> +	if (!cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -ENODEV;
> +	}
> +
> +	if (!cur_profile->profile_get) {
> +		mutex_unlock(&profile_lock);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = cur_profile->profile_get(&profile);
> +	mutex_unlock(&profile_lock);
> +	if (err < 0)
> +		return err;
> +
> +	/* Check that profile is valid index */
> +	if ((profile < 0) || (profile >= ARRAY_SIZE(profile_names)))
> +		return sysfs_emit(buf, "\n");

IMHO it would be better to do "return -EIO" here, since there
clearly is something wrong in this case.

> +
> +	return sysfs_emit(buf, "%s\n", profile_names[profile]);
> +}
> +
> +static ssize_t platform_profile_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	int err, i;
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;
> +
> +	if (!cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -ENODEV;
> +	}
> +
> +	if (!cur_profile->profile_set) {
> +		mutex_unlock(&profile_lock);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Scan for a matching profile */
> +	i = sysfs_match_string(profile_names, buf);
> +	if (i < 0) {
> +		mutex_unlock(&profile_lock);
> +		return -EINVAL;
> +	}
> +
> +	/* Check that platform supports this profile choice */
> +	if (!(cur_profile->choices & BIT(i))) {
> +		mutex_unlock(&profile_lock);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = cur_profile->profile_set(i);
> +	mutex_unlock(&profile_lock);
> +	if (err)
> +		return err;
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RO(platform_profile_choices);
> +static DEVICE_ATTR_RW(platform_profile);
> +
> +static struct attribute *platform_profile_attrs[] = {
> +	&dev_attr_platform_profile_choices.attr,
> +	&dev_attr_platform_profile.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group platform_profile_group = {
> +	.attrs = platform_profile_attrs
> +};
> +
> +void platform_profile_notify(void)
> +{
> +	if (!cur_profile)
> +		return;
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_notify);
> +
> +int platform_profile_register(const struct platform_profile_handler *pprof)
> +{
> +	int err;

Maybe sanity check the platform_profile_handler a bit here,
I think it would be ok to check that choices, profile_set and profile_get
are all not 0 / NULL here and otherwise just return -EINVAL; Doing so
allows making the code above a bit simpler, also removing some exit
paths which require an unlock before exiting.

> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;

Please use a regular mutex_lock here, this is called during
driver probing, so no need to handle Ctrl+C and other signals.

> +
> +	/* We can only have one active profile */
> +	if (cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -EEXIST;
> +	}
> +
> +	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> +	if (err) {
> +		mutex_unlock(&profile_lock);
> +		return err;
> +	}
> +
> +	cur_profile = pprof;
> +	mutex_unlock(&profile_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_register);
> +
> +int platform_profile_unregister(void)
> +{
> +	int err;
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;

Also please use a regular mutex_lock here.

> +
> +	if (!cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -ENODEV;
> +	}
> +
> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	cur_profile = NULL;
> +	mutex_unlock(&profile_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
> +
> +static int __init platform_profile_init(void)
> +{
> +	return 0;
> +}
> +module_init(platform_profile_init);

AFAIK you do not need to provide a module_init function, since this
is a no-op you can just leave it out.

> +static void __exit platform_profile_exit(void)
> +{
> +	/* Check if we have a registered profile, and clean up */
> +	if (cur_profile) {
> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +		cur_profile = NULL;
> +	}
> +}
> +module_exit(platform_profile_exit);

Any driver/module registering a platform_profile will depend on
symbols from this module, so this module can only be unloaded (aka exit)
if that other driver/module has already been unloaded. Unloading that
other module should have already unregistered the cur_profile provider,
otherwise things like cur_profile->profile_set will now point to no
longer loaded code which would be really really bad. So you can drop
this exit function entirely.

Sorry for not spotting some of these sooner. Still nothing really big,
so hopefully you will be able to post a v5 addressing these soonish and
then with some luck we can at least get patches 1 and 2 merged by Rafael
in time for 5.11 (assuming Rafael is happy with v5). And then I can merge
patch 3 once 5.11-rc1 is out.

Regards,

Hans






> +
> +MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> new file mode 100644
> index 000000000000..33ccd40bb9cf
> --- /dev/null
> +++ b/include/linux/platform_profile.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Platform profile sysfs interface
> + *
> + * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
> + * information.
> + */
> +
> +#ifndef _PLATFORM_PROFILE_H_
> +#define _PLATFORM_PROFILE_H_
> +
> +/*
> + * If more options are added please update profile_names
> + * array in platform-profile.c and sysfs-platform-profile.rst
> + * documentation.
> + */
> +
> +enum platform_profile_option {
> +	platform_profile_low,
> +	platform_profile_cool,
> +	platform_profile_quiet,
> +	platform_profile_balance,
> +	platform_profile_perform,
> +};
> +
> +struct platform_profile_handler {
> +	unsigned int choices; /* Bitmap of available choices */
> +	int (*profile_get)(enum platform_profile_option *profile);
> +	int (*profile_set)(enum platform_profile_option profile);
> +};
> +
> +int platform_profile_register(const struct platform_profile_handler *pprof);
> +int platform_profile_unregister(void);
> +void platform_profile_notify(void);
> +
> +#endif  /*_PLATFORM_PROFILE_H_*/
> 

