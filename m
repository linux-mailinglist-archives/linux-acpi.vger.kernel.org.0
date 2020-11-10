Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEEC2AD8F0
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 15:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKJOjL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 09:39:11 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:48612 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgKJOjL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 09:39:11 -0500
Received: from [100.112.128.173] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id 05/D7-32453-B06AAAF5; Tue, 10 Nov 2020 14:39:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRWlGSWpSXmKPExsWS8eIhry73slX
  xBruXKVm8nHCY0WL/dQmLroUGFgvvn2K1+PrtNrvFm+PTmSyW7+tntGjqbGKz+NwxmcVi9Z4X
  zBZnTl9ideD2mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHu/3XWXz2HK1ncXj8ya5AI4o1sy8p
  PyKBNaMJVvXshZM1q84v2wbawPjBZUuRi4OIYH/jBJLds5hhnCeM0pMm7SYvYuRk0NYIFaiq2
  0LWxcjO4eIgL7E/jKQEmaBJcwSd5ftYISoP8Uo8WtyDytIPZuAtsSWLb/YQGxeAVuJZZf+MIH
  YLAKqEl3zJ4DNFBUIl+i4sYMJokZQ4uTMJywgNqdAoMTFx2fB4swCFhIz559nhLDFJW49mQ8V
  l5fY/hbkUE4OCSD79bt2KDtBYtnLO8wTGAVnIRk7C8moWUhGzUIyagEjyypG86SizPSMktzEz
  BxdQwMDXUNDI11DI0tdY2O9xCrdRL3SYt3y1OISXSO9xPJiveLK3OScFL281JJNjMB4TCloVN
  zBeOH1B71DjJIcTEqivH/mrooX4kvKT6nMSCzOiC8qzUktPsQow8GhJMG7bwlQTrAoNT21Ii0
  zB5gaYNISHDxKIrxqIGne4oLE3OLMdIjUKUZFKXHeQJCEAEgiozQPrg2Wji4xykoJ8zIyMDAI
  8RSkFuVmlqDKv2IU52BUEuZlAJnCk5lXAjf9FdBiJqDFAY4rQBaXJCKkpBqYWlqvBPF9nLLuy
  /X11mxtLdt9ZRctTxYKbXS6yXU9u9dbM0Ur4W3xMebU69MWlf+TitZIeiNsKuJkmThvVdiCZx
  Ypjud7uO0OLmu+VVew5vP7eIGvJo/LtINM+94XSlw+sKNDuOnwcb1rQZ1Xy1dOsAjMNZx1wPu
  e15yOjLRLHO9Xdl9mesbs8fz/mWiTPQ1ezEUiP1OM7+8/xlL+bHqWvsorn8sKOtUHjXQvir/6
  dS/8y54VM441yzTnP7/sZjTjyP3Ons4np5TYktLuvYzonzn9UsB5b50Fr5g2/5kcmczBlz5zV
  dxRiRNRG1+cLn65rnxt95Eb5W/VZC/m74hm/BNe/eeWqf18ATfmN+v/KrEUZyQaajEXFScCAP
  YZjb/CAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-33.tower-335.messagelabs.com!1605019146!564!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20143 invoked from network); 10 Nov 2020 14:39:07 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-33.tower-335.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 14:39:07 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id DFF30835A6A89766C873;
        Tue, 10 Nov 2020 09:39:05 -0500 (EST)
Received: from localhost.localdomain (10.46.61.15) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 10 Nov
 2020 06:39:03 -0800
Subject: Re: [External] Re: [PATCH 2/3] ACPI: platform-profile: Add platform
 profile support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-3-markpearson@lenovo.com>
 <CAHp75VcPaZu3S6Sb-Zr3GFokxASWrD7hcOhBA0UA4frC1C5XAg@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <eb682fb9-4021-7563-29ed-abf0e9698a6b@lenovo.com>
Date:   Tue, 10 Nov 2020 09:39:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcPaZu3S6Sb-Zr3GFokxASWrD7hcOhBA0UA4frC1C5XAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.61.15]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On 10/11/2020 05:26, Andy Shevchenko wrote:
> On Tue, Nov 10, 2020 at 5:35 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>> This is the initial implementation of the platform-profile feature.
>> It provides the details discussed and outlined in the
>> sysfs-platform_profile document.
>>
>> Many modern systems have the ability to modify the operating profile to
>> control aspects like fan speed, temperature and power levels. This
>> module provides a common sysfs interface that platform modules can register
>> against to control their individual profile options.
> 
> ...
> 
>> +config ACPI_PLATFORM_PROFILE
>> +       tristate "ACPI Platform Profile Driver"
>> +       default y
>> +       help
>> +         This driver adds support for platform-profiles on platforms that
>> +         support it.
>> +
>> +         Platform-profiles can be used to control the platform behaviour. For
>> +         example whether to operate in a lower power mode, in a higher
>> +         power performance mode or between the two.
>> +
>> +         This driver provides the sysfs interface and is used as the registration
>> +         point for platform specific drivers.
>> +
>> +         Which profiles are supported is determined on a per-platform basis and
>> +         should be obtained from the platform specific driver.
> 
>> +
>> +
> 
> None of the blank lines is enough. But can you consider to find
> perhaps better place (I imply some logical group of options in the
> file).
Will do.

> 
> ...
> 
>>   obj-$(CONFIG_ACPI_SPCR_TABLE)  += spcr.o
>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>>   obj-$(CONFIG_ACPI_PPTT)        += pptt.o
>> +obj-$(CONFIG_ACPI_PLATFORM_PROFILE)    += platform_profile.o
> 
> ...yes, and this becomes consistent with the above.
> 
> ...
> 
>> +/*
>> + *  platform_profile.c - Platform profile sysfs interface
>> + */
> 
> One line. PLease, don't put the file name into the file. If we want to
> rename it, it will give additional churn and as shown in practice
> people often forget this change to follow.
Ack.

> 
> ...
> 
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +#include <linux/kobject.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/init.h>
>> +#include <linux/fs.h>
>> +#include <linux/string.h>
>> +#include <linux/device.h>
>> +#include <linux/acpi.h>
>> +#include <linux/mutex.h>
>> +#include <acpi/acpi_bus.h>
>> +#include <linux/platform_profile.h>
> 
> Perhaps sorted?
> Why do you need a specific acpi_bus.h? I thought acpi.h includes it already, no?
Sure - I hadn't realised sorted was a requirement :)

I'll check on acpi_bus.h - I think I initially added acpi_bus.h thinking 
it was all I needed and then added acpi.h later. I'll clean up if I can.
> 
> ...
> 
>> +struct platform_profile *cur_profile;
> 
> Better naming since it's a global variable.
> Is it supposed to be exported to modules?
It's internal only, but agreed on improving the naming.
(Barabas pointed out that it should be a static too)
> 
> ...
> 
>> +DEFINE_MUTEX(profile_lock);
> 
> No static?
Yes, it should be.
> 
> ...
> 
>> +/* Ensure the first char of each profile is unique */
>> +static char *profile_str[] = {
> 
> static const char * const profile_names[]
> 
> Also naming (perhaps like I proposed above?).
Ack.
> 
>> +       "Low-power",
>> +       "Cool",
>> +       "Quiet",
>> +       "Balance",
>> +       "Performance",
> 
>> +       "Unknown"
> 
> Leave the comma here.
Ack.
> 
>> +};
> 
> ...
> 
>> +       int i;
>> +       int ret, count = 0;
> 
> count AFAICS should be size_t (or ssize_t).
> Can you make them in reversed xmas tree order?
Sure - will fix.

> 
> ...
> 
>> +       return snprintf(buf, PAGE_SIZE, "%s", profile_str[profile]);
> 
> Nowadays we have sysfs_emit(), use it.
OK - that was a new one to me. Will update.
> 
> ...
> 
>> +       /* Scan for a matching profile */
>> +       for (profile = profile_low; profile < profile_unknown; profile++) {
>> +               if (toupper(buf[0]) == profile_str[profile][0])
>> +                       break;
>> +       }
> 
> match_string() / sysfs_match_string() ?
Yes, Barnabas picked up on this too. I'll correct.

> 
> ...
> 
>> +static struct attribute *platform_profile_attributes[] = {
>> +       &dev_attr_platform_profile_choices.attr,
>> +       &dev_attr_platform_profile.attr,
> 
>> +       NULL,
> 
> Drop comma in terminator line.
Ack.
> 
>> +};
> 
> ...
> 
>> +module_init(platform_profile_init);
>> +module_exit(platform_profile_exit);
> 
> Attach them to respective functions.
OK.

> 
> ...
> 
>> +/*
>> + * platform_profile.h - platform profile sysfs interface
> 
> No file name.
Ack.
> 
>> + *
>> + * See Documentation/ABI/testing/sysfs-platform_profile for more information.
>> + */
> 
> ...
> 
>> +/*
>> + * If more options are added please update profile_str
>> + * array in platform-profile.c
>> + */
> 
> Kernel doc?
OK.
Just in case - I assume this should go int the sysfs-platform-profile 
doc (patch 1 of the series). Let me know if that's not the expectation.

> 
>> +enum profile_option {
>> +       profile_low,
>> +       profile_cool,
>> +       profile_quiet,
>> +       profile_balance,
>> +       profile_perform,
> 
>> +       profile_unknown /* Must always be last */
> 
> Comment is semi-useless. Comma at the end (or its absence) is usually
> enough to give a clue, but okay, comment makes this explicit.
I prefer explicit but let me know if you feel strongly about this one.

> 
> ...
> 
>> +struct platform_profile {
>> +       unsigned int choices; /* bitmap of available choices */
>> +       int cur_profile;      /* Current active profile */
> 
> Kernel doc?
Sure
> 
>> +       int (*profile_get)(void);
>> +       int (*profile_set)(int profile);
>> +};
> 
> ...
> 
>> +extern int platform_profile_register(struct platform_profile *pprof);
>> +extern int platform_profile_unregister(void);
>> +extern int platform_profile_notify(void);
> 
> extern is not needed.
> 
I will remove.

Thanks for the detailed review - very much appreciated.
Mark
