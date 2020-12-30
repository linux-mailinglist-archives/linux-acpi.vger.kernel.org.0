Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CADC2E7BA7
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgL3Rlc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 12:41:32 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:34466 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3Rlc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2020 12:41:32 -0500
Received: by mail-oo1-f48.google.com with SMTP id x23so3849411oop.1;
        Wed, 30 Dec 2020 09:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFXGTYOvTRLyEU7NO11LgDiA0ft45RcElJHqohaAgZo=;
        b=nUeZbRtcfoVACpybhpmprxGtt0FabwIM7dcRdksTSQRXdQcSZvJ8Srb415/TBg5p6Y
         3U5nLLdNfoieiFdlxLmWYQAkAlUcDcSwqzz7R2APYbn34xhrgU6gDuUqAMVZp6S7mf/h
         aPDAoEGuBwMOWY89zK3qi1tiH1HhXXIbtKXWxMa99rH48gSQC6CUw7OVJ0GJTqUwouEx
         7k1kNNpcPEZmaCdeYco/D3myHGILYrUciuGzna3xfhe4leCdywwoaFcnWdfghxlIghqt
         PVEJwPdb888VdmSNAw8shkDlkAk+3huZ+CqsuNwIsRQg04x3FFHxN2PyHkUD9F0tkdvK
         sFJw==
X-Gm-Message-State: AOAM532OWPmKyswz0oiYYC5Vh6xeD134pnpd9X3m2EI+9xc1P2FbBima
        RNSGC0yEfZe6IJ6ktNXMaXaMV99Z20qTNLiweYI=
X-Google-Smtp-Source: ABdhPJwD106IHjQGoxWFg32N5cI4joE9qCn8Nx3EQ3ghGXdaYArxKFB+gG9i7Fw7hCXBeevCtHmFaHwjLQ78HAzkwxs=
X-Received: by 2002:a4a:bf14:: with SMTP id r20mr23155690oop.2.1609350050488;
 Wed, 30 Dec 2020 09:40:50 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201230001827.3745-1-markpearson@lenovo.com>
 <20201230001827.3745-2-markpearson@lenovo.com>
In-Reply-To: <20201230001827.3745-2-markpearson@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Dec 2020 18:40:39 +0100
Message-ID: <CAJZ5v0hTGy6xjAOwmeWXNaCiTa22YNKp2R8YX8WWXGeBVcR=Ag@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] ACPI: platform-profile: Add platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 30, 2020 at 1:24 AM Mark Pearson <markpearson@lenovo.com> wrote:
>
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
> Changes in v5:
>  - correct 'balance' to 'balanced' to be consistent with documentation
>  - add WARN_ON when checking profile index in show function
>  - switch mutex_lock_interruptible back to mutex_lock where appropriate
>  - add 'platform_profile_last' as final entry in profile entry. Update
>    implementation to use this appropriately
>  - Use BITS_TO_LONG and appropriate access functions for choices field
>  - Correct error handling as recommended
>  - Sanity check profile fields on registration
>  - Remove unnecessary init and exit functions
>
> Changed in v6:
>  - Change default build option to 'm' and clean in formating in Kconfig
>  - Change enums to be capitalised as requested
>  - Rename unregister function to remove
>
> Changes in v7
>  - version bump along with rest of patch series
>
> Changes in v8:
>  - correct checking for empty choices bitmap in register function

Applied with the Hans' R-by and I replaced PLATFORM_PROFILE_LOW and
PLATFORM_PROFILE_PERFORM with PLATFORM_PROFILE_LOW_POWER and
PLATFORM_PROFILE_PERFORMANCE, respectively.

Thanks!

>  drivers/acpi/Kconfig             |  17 +++
>  drivers/acpi/Makefile            |   1 +
>  drivers/acpi/platform_profile.c  | 181 +++++++++++++++++++++++++++++++
>  include/linux/platform_profile.h |  39 +++++++
>  4 files changed, 238 insertions(+)
>  create mode 100644 drivers/acpi/platform_profile.c
>  create mode 100644 include/linux/platform_profile.h
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..5ddff93e38c2 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -326,6 +326,23 @@ config ACPI_THERMAL
>           To compile this driver as a module, choose M here:
>           the module will be called thermal.
>
> +config ACPI_PLATFORM_PROFILE
> +       tristate "ACPI Platform Profile Driver"
> +       default m
> +       help
> +         This driver adds support for platform-profiles on platforms that
> +         support it.
> +
> +         Platform-profiles can be used to control the platform behaviour. For
> +         example whether to operate in a lower power mode, in a higher
> +         power performance mode or between the two.
> +
> +         This driver provides the sysfs interface and is used as the registration
> +         point for platform specific drivers.
> +
> +         Which profiles are supported is determined on a per-platform basis and
> +         should be obtained from the platform specific driver.
> +
>  config ACPI_CUSTOM_DSDT_FILE
>         string "Custom DSDT Table file to include"
>         default ""
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 44e412506317..c64a8af106c0 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_PCI_SLOT)   += pci_slot.o
>  obj-$(CONFIG_ACPI_PROCESSOR)   += processor.o
>  obj-$(CONFIG_ACPI)             += container.o
>  obj-$(CONFIG_ACPI_THERMAL)     += thermal.o
> +obj-$(CONFIG_ACPI_PLATFORM_PROFILE)    += platform_profile.o
>  obj-$(CONFIG_ACPI_NFIT)                += nfit/
>  obj-$(CONFIG_ACPI_NUMA)                += numa/
>  obj-$(CONFIG_ACPI)             += acpi_memhotplug.o
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> new file mode 100644
> index 000000000000..f65aa8cd2185
> --- /dev/null
> +++ b/drivers/acpi/platform_profile.c
> @@ -0,0 +1,181 @@
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
> +       [PLATFORM_PROFILE_LOW] = "low-power",
> +       [PLATFORM_PROFILE_COOL] = "cool",
> +       [PLATFORM_PROFILE_QUIET] = "quiet",
> +       [PLATFORM_PROFILE_BALANCED] = "balanced",
> +       [PLATFORM_PROFILE_PERFORM] = "performance",
> +};
> +static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> +
> +static ssize_t platform_profile_choices_show(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       int len = 0;
> +       int err, i;
> +
> +       err = mutex_lock_interruptible(&profile_lock);
> +       if (err)
> +               return err;
> +
> +       if (!cur_profile) {
> +               mutex_unlock(&profile_lock);
> +               return -ENODEV;
> +       }
> +
> +       for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> +               if (len == 0)
> +                       len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +               else
> +                       len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +       }
> +       len += sysfs_emit_at(buf, len, "\n");
> +       mutex_unlock(&profile_lock);
> +       return len;
> +}
> +
> +static ssize_t platform_profile_show(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
> +       int err;
> +
> +       err = mutex_lock_interruptible(&profile_lock);
> +       if (err)
> +               return err;
> +
> +       if (!cur_profile) {
> +               mutex_unlock(&profile_lock);
> +               return -ENODEV;
> +       }
> +
> +       err = cur_profile->profile_get(&profile);
> +       mutex_unlock(&profile_lock);
> +       if (err)
> +               return err;
> +
> +       /* Check that profile is valid index */
> +       if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> +               return -EIO;
> +
> +       return sysfs_emit(buf, "%s\n", profile_names[profile]);
> +}
> +
> +static ssize_t platform_profile_store(struct device *dev,
> +                           struct device_attribute *attr,
> +                           const char *buf, size_t count)
> +{
> +       int err, i;
> +
> +       err = mutex_lock_interruptible(&profile_lock);
> +       if (err)
> +               return err;
> +
> +       if (!cur_profile) {
> +               mutex_unlock(&profile_lock);
> +               return -ENODEV;
> +       }
> +
> +       /* Scan for a matching profile */
> +       i = sysfs_match_string(profile_names, buf);
> +       if (i < 0) {
> +               mutex_unlock(&profile_lock);
> +               return -EINVAL;
> +       }
> +
> +       /* Check that platform supports this profile choice */
> +       if (!test_bit(i, cur_profile->choices)) {
> +               mutex_unlock(&profile_lock);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       err = cur_profile->profile_set(i);
> +       mutex_unlock(&profile_lock);
> +       if (err)
> +               return err;
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RO(platform_profile_choices);
> +static DEVICE_ATTR_RW(platform_profile);
> +
> +static struct attribute *platform_profile_attrs[] = {
> +       &dev_attr_platform_profile_choices.attr,
> +       &dev_attr_platform_profile.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group platform_profile_group = {
> +       .attrs = platform_profile_attrs
> +};
> +
> +void platform_profile_notify(void)
> +{
> +       if (!cur_profile)
> +               return;
> +       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_notify);
> +
> +int platform_profile_register(const struct platform_profile_handler *pprof)
> +{
> +       int err;
> +
> +       mutex_lock(&profile_lock);
> +       /* We can only have one active profile */
> +       if (cur_profile) {
> +               mutex_unlock(&profile_lock);
> +               return -EEXIST;
> +       }
> +
> +       /* Sanity check the profile handler field are set */
> +       if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> +               !pprof->profile_set || !pprof->profile_get) {
> +               mutex_unlock(&profile_lock);
> +               return -EINVAL;
> +       }
> +
> +       err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> +       if (err) {
> +               mutex_unlock(&profile_lock);
> +               return err;
> +       }
> +
> +       cur_profile = pprof;
> +       mutex_unlock(&profile_lock);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_register);
> +
> +int platform_profile_remove(void)
> +{
> +       mutex_lock(&profile_lock);
> +       if (!cur_profile) {
> +               mutex_unlock(&profile_lock);
> +               return -ENODEV;
> +       }
> +
> +       sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +       cur_profile = NULL;
> +       mutex_unlock(&profile_lock);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_remove);
> +
> +MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> new file mode 100644
> index 000000000000..9a1e2abd7602
> --- /dev/null
> +++ b/include/linux/platform_profile.h
> @@ -0,0 +1,39 @@
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
> +#include <linux/bitops.h>
> +
> +/*
> + * If more options are added please update profile_names
> + * array in platform-profile.c and sysfs-platform-profile.rst
> + * documentation.
> + */
> +
> +enum platform_profile_option {
> +       PLATFORM_PROFILE_LOW,
> +       PLATFORM_PROFILE_COOL,
> +       PLATFORM_PROFILE_QUIET,
> +       PLATFORM_PROFILE_BALANCED,
> +       PLATFORM_PROFILE_PERFORM,
> +       PLATFORM_PROFILE_LAST, /*must always be last */
> +};
> +
> +struct platform_profile_handler {
> +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +       int (*profile_get)(enum platform_profile_option *profile);
> +       int (*profile_set)(enum platform_profile_option profile);
> +};
> +
> +int platform_profile_register(const struct platform_profile_handler *pprof);
> +int platform_profile_remove(void);
> +void platform_profile_notify(void);
> +
> +#endif  /*_PLATFORM_PROFILE_H_*/
> --
> 2.28.0
>
