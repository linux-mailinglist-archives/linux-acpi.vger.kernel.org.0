Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E82AD3A5
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKJKZe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 05:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJKZd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 05:25:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4FC0613CF;
        Tue, 10 Nov 2020 02:25:32 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so11028827pfp.5;
        Tue, 10 Nov 2020 02:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niga6ecIez4/CTrWY1D2m+YLWeUqIwGeKCtJmF4vVAg=;
        b=im83aAxNXiHZ9xQwNtMnvw2gsF/qjGRyH0HZUb1KVsLLl/1oLUwlTXaE9pRe2z2lbZ
         FYthwjEVnVN5i8cTaoB0iZ81qKrdWbgN1sNqosS3FtvAc8Vlv7EQDQSaXOAEFk7V2dkj
         9rxFaEpbNqwVTuHKnlfHevxaFiuU21hydEmk/62k4JlxASd6CV9BYT64hzX/SdBBxoSw
         jXQTG9uORIE9wAEf6945w4mMlkP6rbt66OX2umMrOCZutltj4eTVfSfeBzU9D6D+QreW
         IRybS/9Gbe0RCUl/0pUhEmPkkNiTV0C+RxjwKWHkj9GwsgRau1KrR4fVEC/ziEHZ+x3g
         lrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niga6ecIez4/CTrWY1D2m+YLWeUqIwGeKCtJmF4vVAg=;
        b=G5MOyNYPj55vvwBz8DacPvygqSu5UjNGAu2HT1BkjmxGjRSj6GHsGQKYMfdPvGLIYN
         MQ+BB3xyCvtaWErBrGZVR7k8Mvqy9FDAwKb04liBufvnrDt8jiBduKhOQ3oyQKM5Hi3P
         F9puzrj3WuGfqKECHVWkcGUG2IZrXTYSRtSSDXqP3dXk0v1PNAAIaYLEZjRIWAfgfev3
         5QdCXZ9sgRbViXvL625EuK1aTB7CGlN9npjjpvW57bJ0ky8UJsPBXNWHQKjvMO+04Lj7
         B2PxuUZ4g2r34bsi6U4XuFKroIs27t/PyiK7niSntIpVeox/au5ycrarzp6PPl/mDo3A
         oEng==
X-Gm-Message-State: AOAM533xq3zGqdGTavSZ5f6/yAYmjRElT5NDudfBpgWjGLyCD39wJXN4
        BOKRGlAzvj0ibWhUNQxhRpj3Z0mDqYh+eHJXwsY=
X-Google-Smtp-Source: ABdhPJzrJcuOzfxnFaHZJ+6DkRZv3ZN+jklVWsy9pTAhqOXiz8ZzpIleRahQjFiK/KBX1KuOcdrUHhYXou9M/tR5R4g=
X-Received: by 2002:a62:343:0:b029:15c:e33c:faff with SMTP id
 64-20020a6203430000b029015ce33cfaffmr17171093pfd.7.1605003931630; Tue, 10 Nov
 2020 02:25:31 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-3-markpearson@lenovo.com>
In-Reply-To: <20201110033124.3211-3-markpearson@lenovo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Nov 2020 12:26:16 +0200
Message-ID: <CAHp75VcPaZu3S6Sb-Zr3GFokxASWrD7hcOhBA0UA4frC1C5XAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: platform-profile: Add platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 5:35 AM Mark Pearson <markpearson@lenovo.com> wrote:
>
> This is the initial implementation of the platform-profile feature.
> It provides the details discussed and outlined in the
> sysfs-platform_profile document.
>
> Many modern systems have the ability to modify the operating profile to
> control aspects like fan speed, temperature and power levels. This
> module provides a common sysfs interface that platform modules can register
> against to control their individual profile options.

...

> +config ACPI_PLATFORM_PROFILE
> +       tristate "ACPI Platform Profile Driver"
> +       default y
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
> +

None of the blank lines is enough. But can you consider to find
perhaps better place (I imply some logical group of options in the
file).

...

>  obj-$(CONFIG_ACPI_SPCR_TABLE)  += spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT)        += pptt.o
> +obj-$(CONFIG_ACPI_PLATFORM_PROFILE)    += platform_profile.o

...yes, and this becomes consistent with the above.

...

> +/*
> + *  platform_profile.c - Platform profile sysfs interface
> + */

One line. PLease, don't put the file name into the file. If we want to
rename it, it will give additional churn and as shown in practice
people often forget this change to follow.

...

> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/device.h>
> +#include <linux/acpi.h>
> +#include <linux/mutex.h>
> +#include <acpi/acpi_bus.h>
> +#include <linux/platform_profile.h>

Perhaps sorted?
Why do you need a specific acpi_bus.h? I thought acpi.h includes it already, no?

...

> +struct platform_profile *cur_profile;

Better naming since it's a global variable.
Is it supposed to be exported to modules?

...

> +DEFINE_MUTEX(profile_lock);

No static?

...

> +/* Ensure the first char of each profile is unique */
> +static char *profile_str[] = {

static const char * const profile_names[]

Also naming (perhaps like I proposed above?).

> +       "Low-power",
> +       "Cool",
> +       "Quiet",
> +       "Balance",
> +       "Performance",

> +       "Unknown"

Leave the comma here.

> +};

...

> +       int i;
> +       int ret, count = 0;

count AFAICS should be size_t (or ssize_t).
Can you make them in reversed xmas tree order?

...

> +       return snprintf(buf, PAGE_SIZE, "%s", profile_str[profile]);

Nowadays we have sysfs_emit(), use it.

...

> +       /* Scan for a matching profile */
> +       for (profile = profile_low; profile < profile_unknown; profile++) {
> +               if (toupper(buf[0]) == profile_str[profile][0])
> +                       break;
> +       }

match_string() / sysfs_match_string() ?

...

> +static struct attribute *platform_profile_attributes[] = {
> +       &dev_attr_platform_profile_choices.attr,
> +       &dev_attr_platform_profile.attr,

> +       NULL,

Drop comma in terminator line.

> +};

...

> +module_init(platform_profile_init);
> +module_exit(platform_profile_exit);

Attach them to respective functions.

...

> +/*
> + * platform_profile.h - platform profile sysfs interface

No file name.

> + *
> + * See Documentation/ABI/testing/sysfs-platform_profile for more information.
> + */

...

> +/*
> + * If more options are added please update profile_str
> + * array in platform-profile.c
> + */

Kernel doc?

> +enum profile_option {
> +       profile_low,
> +       profile_cool,
> +       profile_quiet,
> +       profile_balance,
> +       profile_perform,

> +       profile_unknown /* Must always be last */

Comment is semi-useless. Comma at the end (or its absence) is usually
enough to give a clue, but okay, comment makes this explicit.

...

> +struct platform_profile {
> +       unsigned int choices; /* bitmap of available choices */
> +       int cur_profile;      /* Current active profile */

Kernel doc?

> +       int (*profile_get)(void);
> +       int (*profile_set)(int profile);
> +};

...

> +extern int platform_profile_register(struct platform_profile *pprof);
> +extern int platform_profile_unregister(void);
> +extern int platform_profile_notify(void);

extern is not needed.

-- 
With Best Regards,
Andy Shevchenko
