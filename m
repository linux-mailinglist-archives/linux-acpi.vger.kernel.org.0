Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842C92D347C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 21:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgLHUp7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 15:45:59 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:27642 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729786AbgLHUp6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 15:45:58 -0500
Received: from [100.112.128.122] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id 5E/33-50495-DFBCFCF5; Tue, 08 Dec 2020 18:54:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRWlGSWpSXmKPExsWSLveKTffP6fP
  xBtOW6Frsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtli7Zd5
  bBZzv0xltjhz+hKrxYTFG9kdeD0mzZzB7LFz1l12j1/b1rB4bF6h5bFpVSebx7yTgR49bZuYP
  N7vu8rmseVqO4vH501yAVxRrJl5SfkVCawZM7YfZy94EFUx58dclgbG785djFwcQgL/GSVunf
  jIDuE8Z5SYceUtWxcjJ4ewQILE9Fk/GUFsEQFtiSWLrjKDFDELzGORONewgxmi4wyjRFPLebA
  qNqCqLVt+gXXzCthKnLr9jBXEZhFQkbi3cTY7iC0qEC6xfslKRogaQYmTM5+wgNicAoESjxsW
  AdVwAG3QlFi/Sx8kzCwgLnHryXwmCFteYvvbOcwgtoSAgkT/mz52CDtBYtnLO8wTGAVnIZk6C
  2HSLCSTZiGZtICRZRWjRVJRZnpGSW5iZo6uoYGBrqGhka6hsYGukamRXmKVbqJeabFueWpxiS
  6QW16sV1yZm5yTopeXWrKJERi5KQVNf3Yw/n31Qe8QoyQHk5Iob9ih8/FCfEn5KZUZicUZ8UW
  lOanFhxhlODiUJHj5jgPlBItS01Mr0jJzgEkEJi3BwaMkwut2CijNW1yQmFucmQ6ROsWoKCXO
  2w6SEABJZJTmwbXBEtclRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8oSBTeDLzSuCmvwJaz
  AS02PfuaZDFJYkIKakGJteIb5env7k7ze7U3CNqz6ovhds5LxRJ8XLniZwxm6nes1F0O1dxvl
  3ctk8JIZWPNX9w5mfb3Diwq22SdNHHSIbbstLfpEpa6s8sfad/58uTj68cW7wMtJ8IWZRzONQ
  eOrvz1rMlxytvCuvOrwx9bN/1btq+tXw888y2LlHMddr9quXXChWRa+lv3X4mr/tpMN3JuIxT
  4bfDzvIct5K07Wp2/eErju7IuPzsnlzMf681belJ08q3spl1RdcZrpg1d/GVo72nbAMOvr22d
  KqA62e/nVKC0369+re6f9rPnB/sT4TWLi5aW1J4n5V3/a3iO2llDmHud2N4BEsiX32/IijmN4
  9b7HBU0h7lSfNL5iuxFGckGmoxFxUnAgDVCP3d1wMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-27.tower-336.messagelabs.com!1607453690!6462!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14944 invoked from network); 8 Dec 2020 18:54:52 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-27.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Dec 2020 18:54:52 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 709734DC2797A0C292AA;
        Wed,  9 Dec 2020 02:54:47 +0800 (CST)
Received: from localhost.localdomain (10.38.54.222) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 8 Dec 2020
 10:54:44 -0800
Subject: Re: [External] Re: [PATCH v5 2/3] ACPI: platform-profile: Add
 platform profile support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <markpearson@lenovo.com>
 <20201202171120.65269-1-markpearson@lenovo.com>
 <20201202171120.65269-2-markpearson@lenovo.com>
 <CAJZ5v0j9jZBoyvr4=2mTq1A8dc+rbUaf=Woy3PnpKh8Bbg=-RQ@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <2516bd75-952a-3b5e-0519-4c94d81eed4a@lenovo.com>
Date:   Tue, 8 Dec 2020 13:54:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j9jZBoyvr4=2mTq1A8dc+rbUaf=Woy3PnpKh8Bbg=-RQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.54.222]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Thanks for the review - a couple of questions (and a bunch of acks) below

On 08/12/2020 13:26, Rafael J. Wysocki wrote:
> On Wed, Dec 2, 2020 at 6:16 PM Mark Pearson <markpearson@lenovo.com> wrote:
>>
<snip>
>>
>>  drivers/acpi/Kconfig             |  14 +++
>>  drivers/acpi/Makefile            |   1 +
>>  drivers/acpi/platform_profile.c  | 181 +++++++++++++++++++++++++++++++
>>  include/linux/platform_profile.h |  39 +++++++
>>  4 files changed, 235 insertions(+)
>>  create mode 100644 drivers/acpi/platform_profile.c
>>  create mode 100644 include/linux/platform_profile.h
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index edf1558c1105..c1ca6255ff85 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -326,6 +326,20 @@ config ACPI_THERMAL
>>           To compile this driver as a module, choose M here:
>>           the module will be called thermal.
>>
>> +config ACPI_PLATFORM_PROFILE
>> +       tristate "ACPI Platform Profile Driver"
>> +       default y
> 
> default m
OK
> 
>> +       help
>> +         This driver adds support for platform-profiles on platforms that
>> +         support it.
> 
> Empty line here, please.
Ack
> 
>> +         Platform-profiles can be used to control the platform behaviour. For
>> +         example whether to operate in a lower power mode, in a higher
>> +         power performance mode or between the two.
> 
> And here.
Ack
> 
>> +         This driver provides the sysfs interface and is used as the registration
>> +         point for platform specific drivers.
> 
> And here.
Ack
> 
>> +         Which profiles are supported is determined on a per-platform basis and
>> +         should be obtained from the platform specific driver.
>> +
>>  config ACPI_CUSTOM_DSDT_FILE
>>         string "Custom DSDT Table file to include"
>>         default ""
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 44e412506317..c64a8af106c0 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_PCI_SLOT)   += pci_slot.o
>>  obj-$(CONFIG_ACPI_PROCESSOR)   += processor.o
>>  obj-$(CONFIG_ACPI)             += container.o
>>  obj-$(CONFIG_ACPI_THERMAL)     += thermal.o
>> +obj-$(CONFIG_ACPI_PLATFORM_PROFILE)    += platform_profile.o
>>  obj-$(CONFIG_ACPI_NFIT)                += nfit/
>>  obj-$(CONFIG_ACPI_NUMA)                += numa/
>>  obj-$(CONFIG_ACPI)             += acpi_memhotplug.o
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> new file mode 100644
>> index 000000000000..1bc092359e35
>> --- /dev/null
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/* Platform profile sysfs interface */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/bits.h>
>> +#include <linux/init.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/sysfs.h>
>> +
>> +static const struct platform_profile_handler *cur_profile;
>> +static DEFINE_MUTEX(profile_lock);
>> +
>> +static const char * const profile_names[] = {
>> +       [platform_profile_low] = "low-power",
>> +       [platform_profile_cool] = "cool",
>> +       [platform_profile_quiet] = "quiet",
>> +       [platform_profile_balanced] = "balanced",
>> +       [platform_profile_perform] = "performance",
> 
> The enum values in upper case, please.
Sorry, I'm a bit confused here - do you mean change to "Low-power" or
something else (maybe PLATFORM_PROFILE_LOW?)

Just want to make sure I'm getting it correct. If I change the strings
it will impact patch1 in the series which is integrated into your
bleeding-edge branch.

> 
>> +};
>> +static_assert(ARRAY_SIZE(profile_names) == platform_profile_last);
>> +
>> +static ssize_t platform_profile_choices_show(struct device *dev,
>> +                                       struct device_attribute *attr,
>> +                                       char *buf)
>> +{
>> +       int len = 0;
>> +       int err, i;
>> +
>> +       err = mutex_lock_interruptible(&profile_lock);
> 
> Why interruptible?
> 
> And why is the lock needed in the first place?

My thinking was that I don't know what happens when I hand over to thhe
platform driver who does the get/set, so having a lock to prevent a get
whilst a set is in operation seemed like a good idea.

It was interruptible as a suggestion in an earlier reivew as the
preferred way of doing these things for functions that could be called
by user space.

Do you think the lock is a problem?

> 
>> +       if (err)
>> +               return err;
>> +
>> +       if (!cur_profile) {
>> +               mutex_unlock(&profile_lock);
>> +               return -ENODEV;
>> +       }
>> +
>> +       for_each_set_bit(i, cur_profile->choices, platform_profile_last) {
>> +               if (len == 0)
>> +                       len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>> +               else
>> +                       len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>> +       }
>> +       len += sysfs_emit_at(buf, len, "\n");
>> +       mutex_unlock(&profile_lock);
>> +       return len;
>> +}
>> +
>> +static ssize_t platform_profile_show(struct device *dev,
>> +                                       struct device_attribute *attr,
>> +                                       char *buf)
>> +{
>> +       enum platform_profile_option profile = platform_profile_balanced;
>> +       int err;
>> +
>> +       err = mutex_lock_interruptible(&profile_lock);
>> +       if (err)
>> +               return err;
>> +
>> +       if (!cur_profile) {
>> +               mutex_unlock(&profile_lock);
>> +               return -ENODEV;
>> +       }
>> +
>> +       err = cur_profile->profile_get(&profile);
> 
> In which cases this can fail?
I'm not sure - but as this is supposed to be vendor agnostic I can't
foresee what might be wanted or could happen on various hardware. I
agree a failure is probably unlikely in the Lenovo case where we're
doing an ACPI call, but is there any issue in handling error codes?
It doesn't seem to gain much by removing it and may have future impacts.
> 
>> +       mutex_unlock(&profile_lock);
>> +       if (err)
>> +               return err;
>> +
>> +       /* Check that profile is valid index */
>> +       if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>> +               return -EIO;
>> +
>> +       return sysfs_emit(buf, "%s\n", profile_names[profile]);
>> +}
>> +
>> +static ssize_t platform_profile_store(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           const char *buf, size_t count)
>> +{
>> +       int err, i;
>> +
>> +       err = mutex_lock_interruptible(&profile_lock);
>> +       if (err)
>> +               return err;
>> +
>> +       if (!cur_profile) {
>> +               mutex_unlock(&profile_lock);
>> +               return -ENODEV;
>> +       }
>> +
>> +       /* Scan for a matching profile */
>> +       i = sysfs_match_string(profile_names, buf);
>> +       if (i < 0) {
>> +               mutex_unlock(&profile_lock);
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* Check that platform supports this profile choice */
>> +       if (!test_bit(i, cur_profile->choices)) {
>> +               mutex_unlock(&profile_lock);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>> +       err = cur_profile->profile_set(i);
> 
> What if this gets a signal in the middle of the ->profile_set()
> execution?  Is this always guaranteed to work?
I'm afraid I don't know the answer to this one. What would be the
recommendation to cover this event?

> 
>> +       mutex_unlock(&profile_lock);
>> +       if (err)
>> +               return err;
>> +       return count;
>> +}
>> +
>> +static DEVICE_ATTR_RO(platform_profile_choices);
>> +static DEVICE_ATTR_RW(platform_profile);
>> +
>> +static struct attribute *platform_profile_attrs[] = {
>> +       &dev_attr_platform_profile_choices.attr,
>> +       &dev_attr_platform_profile.attr,
>> +       NULL
>> +};
>> +
>> +static const struct attribute_group platform_profile_group = {
>> +       .attrs = platform_profile_attrs
>> +};
>> +
>> +void platform_profile_notify(void)
>> +{
>> +       if (!cur_profile)
>> +               return;
>> +       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_notify);
>> +
>> +int platform_profile_register(const struct platform_profile_handler *pprof)
>> +{
>> +       int err;
>> +
>> +       mutex_lock(&profile_lock);
>> +       /* We can only have one active profile */
>> +       if (cur_profile) {
>> +               mutex_unlock(&profile_lock);
>> +               return -EEXIST;
>> +       }
>> +
>> +       /* Sanity check the profile handler field are set */
>> +       if (!pprof || !pprof->choices || !pprof->profile_set ||
>> +                       !pprof->profile_get) {
>> +               mutex_unlock(&profile_lock);
>> +               return -EINVAL;
>> +       }
>> +
>> +       err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +       if (err) {
>> +               mutex_unlock(&profile_lock);
>> +               return err;
>> +       }
>> +
>> +       cur_profile = pprof;
>> +       mutex_unlock(&profile_lock);
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_register);
>> +
>> +int platform_profile_unregister(void)
> 
> "Unregister" functions typically take an argument pointing to the
> target object, so something like platform_profile_remove() may be a
> better choice here.
Sure - happy to change that

> 
>> +{
>> +       mutex_lock(&profile_lock);
>> +       if (!cur_profile) {
>> +               mutex_unlock(&profile_lock);
>> +               return -ENODEV;
>> +       }
>> +
>> +       sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +       cur_profile = NULL;
>> +       mutex_unlock(&profile_lock);
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
>> +
>> +MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> new file mode 100644
>> index 000000000000..f2e1b1c90482
>> --- /dev/null
>> +++ b/include/linux/platform_profile.h
>> @@ -0,0 +1,39 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Platform profile sysfs interface
>> + *
>> + * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
>> + * information.
>> + */
>> +
>> +#ifndef _PLATFORM_PROFILE_H_
>> +#define _PLATFORM_PROFILE_H_
>> +
>> +#include <linux/bitops.h>
>> +
>> +/*
>> + * If more options are added please update profile_names
>> + * array in platform-profile.c and sysfs-platform-profile.rst
>> + * documentation.
>> + */
>> +
>> +enum platform_profile_option {
>> +       platform_profile_low,
>> +       platform_profile_cool,
>> +       platform_profile_quiet,
>> +       platform_profile_balanced,
>> +       platform_profile_perform,
>> +       platform_profile_last, /*must always be last */
>> +};
>> +
>> +struct platform_profile_handler {
>> +       unsigned long choices[BITS_TO_LONGS(platform_profile_last)];
>> +       int (*profile_get)(enum platform_profile_option *profile);
>> +       int (*profile_set)(enum platform_profile_option profile);
>> +};
>> +
>> +int platform_profile_register(const struct platform_profile_handler *pprof);
>> +int platform_profile_unregister(void);
>> +void platform_profile_notify(void);
>> +
>> +#endif  /*_PLATFORM_PROFILE_H_*/
>> --
Thanks
Mark
