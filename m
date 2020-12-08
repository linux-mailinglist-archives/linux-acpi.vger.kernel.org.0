Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89F12D343B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 21:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgLHUdn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 15:33:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37703 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHUdn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 15:33:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id l207so17934495oib.4;
        Tue, 08 Dec 2020 12:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fq4raZ5Vx7/sk/WuTuDRykSxyqXOTREKUPg7yUal3EQ=;
        b=FmxeOuyKyYHMZAMqkFxDJR5e8KYVA3oyNpf8XfoNnFj1clxTzMQ0J0Md5ASibnZFe6
         lON1vax0aIRJATQRV9MZkr3KcRK7neZoiODu01CimDnoT+sJ3V5ZTK2SswB7K1yzigca
         7Gs9Mg+eW8n2lD9s077UQRbIAs2acOyC3W82+zqv/+1GBPoLnf71olQLuO0crv9EyFjW
         DUDK4pTxu2OdoZGzK3eCzP+88uThurZKSLJTaWcTGUV649wTLTIeXG4Xoq6Dm8+6PPFO
         nh6LsEBHRVrTYjM80e+J20QzpsvjWTcHwGwmemHAh0lDuYHH2+hx/6BJXxuqfCLIZv44
         AnFQ==
X-Gm-Message-State: AOAM532gBnRIX7QG1eSu6++GBOU8tvGAtUAaySzipdWND74Xpps/1bNp
        CN7u2jaTCockiEzNV7EGP/sBTED47GapbA5XOxxHptj3uRk=
X-Google-Smtp-Source: ABdhPJwYUP7c3gu1N4HnBON0Gkbf6R6FTLx6dL1skwEYYXmPlQRkC3/UJ5oHST5OBWEcQfbXmTaLkwaAYHbElFtqbOY=
X-Received: by 2002:aca:5197:: with SMTP id f145mr3984614oib.71.1607455105143;
 Tue, 08 Dec 2020 11:18:25 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201202171120.65269-1-markpearson@lenovo.com>
 <20201202171120.65269-2-markpearson@lenovo.com> <CAJZ5v0j9jZBoyvr4=2mTq1A8dc+rbUaf=Woy3PnpKh8Bbg=-RQ@mail.gmail.com>
 <2516bd75-952a-3b5e-0519-4c94d81eed4a@lenovo.com>
In-Reply-To: <2516bd75-952a-3b5e-0519-4c94d81eed4a@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 20:18:12 +0100
Message-ID: <CAJZ5v0iaOcciagBekn8Y8qRVc0Q7Swt6-tJAYfvNhx0siLXX2w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/3] ACPI: platform-profile: Add
 platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 8, 2020 at 7:54 PM Mark Pearson <markpearson@lenovo.com> wrote:
>
> Hi Rafael,
>
> Thanks for the review - a couple of questions (and a bunch of acks) below
>
> On 08/12/2020 13:26, Rafael J. Wysocki wrote:
> > On Wed, Dec 2, 2020 at 6:16 PM Mark Pearson <markpearson@lenovo.com> wrote:

[cut]

> >> +static const struct platform_profile_handler *cur_profile;
> >> +static DEFINE_MUTEX(profile_lock);
> >> +
> >> +static const char * const profile_names[] = {
> >> +       [platform_profile_low] = "low-power",
> >> +       [platform_profile_cool] = "cool",
> >> +       [platform_profile_quiet] = "quiet",
> >> +       [platform_profile_balanced] = "balanced",
> >> +       [platform_profile_perform] = "performance",
> >
> > The enum values in upper case, please.
> Sorry, I'm a bit confused here - do you mean change to "Low-power" or
> something else (maybe PLATFORM_PROFILE_LOW?)

platform_profile_low -> PLATFORM_PROFILE_LOW
platform_profile_cool -> PLATFORM_PROFILE_COOL

etc.

> Just want to make sure I'm getting it correct. If I change the strings
> it will impact patch1 in the series which is integrated into your
> bleeding-edge branch.
>
> >
> >> +};
> >> +static_assert(ARRAY_SIZE(profile_names) == platform_profile_last);
> >> +
> >> +static ssize_t platform_profile_choices_show(struct device *dev,
> >> +                                       struct device_attribute *attr,
> >> +                                       char *buf)
> >> +{
> >> +       int len = 0;
> >> +       int err, i;
> >> +
> >> +       err = mutex_lock_interruptible(&profile_lock);
> >
> > Why interruptible?
> >
> > And why is the lock needed in the first place?
>
> My thinking was that I don't know what happens when I hand over to thhe
> platform driver who does the get/set, so having a lock to prevent a get
> whilst a set is in operation seemed like a good idea.

Taking it over get/set probably is (and you need to protect the
cur_profile pointer from concurrent updates).

And here you need to ensure that the cur_profile object doesn't go
away while this is running.  So that's why.

> It was interruptible as a suggestion in an earlier reivew as the
> preferred way of doing these things for functions that could be called
> by user space.

Well, it is not used consistently this way at least.  But OK.

> Do you think the lock is a problem?

No, it isn't in principle.

> >
> >> +       if (err)
> >> +               return err;
> >> +
> >> +       if (!cur_profile) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       for_each_set_bit(i, cur_profile->choices, platform_profile_last) {
> >> +               if (len == 0)
> >> +                       len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
> >> +               else
> >> +                       len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
> >> +       }
> >> +       len += sysfs_emit_at(buf, len, "\n");
> >> +       mutex_unlock(&profile_lock);
> >> +       return len;
> >> +}
> >> +
> >> +static ssize_t platform_profile_show(struct device *dev,
> >> +                                       struct device_attribute *attr,
> >> +                                       char *buf)
> >> +{
> >> +       enum platform_profile_option profile = platform_profile_balanced;
> >> +       int err;
> >> +
> >> +       err = mutex_lock_interruptible(&profile_lock);
> >> +       if (err)
> >> +               return err;
> >> +
> >> +       if (!cur_profile) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       err = cur_profile->profile_get(&profile);
> >
> > In which cases this can fail?
> I'm not sure - but as this is supposed to be vendor agnostic I can't
> foresee what might be wanted or could happen on various hardware.

It returns the index of the current profile AFAICS, so I don't really
see a reason for it to fail.

Moreover, the index could be maintained by the common code along with
the cur_profile pointer, couldn't it?

> I agree a failure is probably unlikely in the Lenovo case where we're
> doing an ACPI call, but is there any issue in handling error codes?
> It doesn't seem to gain much by removing it and may have future impacts.
> >
> >> +       mutex_unlock(&profile_lock);
> >> +       if (err)
> >> +               return err;
> >> +
> >> +       /* Check that profile is valid index */
> >> +       if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> >> +               return -EIO;
> >> +
> >> +       return sysfs_emit(buf, "%s\n", profile_names[profile]);
> >> +}
> >> +
> >> +static ssize_t platform_profile_store(struct device *dev,
> >> +                           struct device_attribute *attr,
> >> +                           const char *buf, size_t count)
> >> +{
> >> +       int err, i;
> >> +
> >> +       err = mutex_lock_interruptible(&profile_lock);
> >> +       if (err)
> >> +               return err;
> >> +
> >> +       if (!cur_profile) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       /* Scan for a matching profile */
> >> +       i = sysfs_match_string(profile_names, buf);
> >> +       if (i < 0) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       /* Check that platform supports this profile choice */
> >> +       if (!test_bit(i, cur_profile->choices)) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -EOPNOTSUPP;
> >> +       }
> >> +
> >> +       err = cur_profile->profile_set(i);
> >
> > What if this gets a signal in the middle of the ->profile_set()
> > execution?  Is this always guaranteed to work?
> I'm afraid I don't know the answer to this one. What would be the
> recommendation to cover this event?

Never mind, this was a mistake of mine.

> >
> >> +       mutex_unlock(&profile_lock);
> >> +       if (err)
> >> +               return err;
> >> +       return count;
> >> +}
> >> +
> >> +static DEVICE_ATTR_RO(platform_profile_choices);
> >> +static DEVICE_ATTR_RW(platform_profile);
> >> +
> >> +static struct attribute *platform_profile_attrs[] = {
> >> +       &dev_attr_platform_profile_choices.attr,
> >> +       &dev_attr_platform_profile.attr,
> >> +       NULL
> >> +};
> >> +
> >> +static const struct attribute_group platform_profile_group = {
> >> +       .attrs = platform_profile_attrs
> >> +};
> >> +
> >> +void platform_profile_notify(void)
> >> +{
> >> +       if (!cur_profile)
> >> +               return;
> >> +       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> >> +}
> >> +EXPORT_SYMBOL_GPL(platform_profile_notify);
> >> +
> >> +int platform_profile_register(const struct platform_profile_handler *pprof)
> >> +{
> >> +       int err;
> >> +
> >> +       mutex_lock(&profile_lock);
> >> +       /* We can only have one active profile */
> >> +       if (cur_profile) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -EEXIST;
> >> +       }
> >> +
> >> +       /* Sanity check the profile handler field are set */
> >> +       if (!pprof || !pprof->choices || !pprof->profile_set ||
> >> +                       !pprof->profile_get) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> >> +       if (err) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return err;
> >> +       }
> >> +
> >> +       cur_profile = pprof;
> >> +       mutex_unlock(&profile_lock);
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(platform_profile_register);
> >> +
> >> +int platform_profile_unregister(void)
> >
> > "Unregister" functions typically take an argument pointing to the
> > target object, so something like platform_profile_remove() may be a
> > better choice here.
> Sure - happy to change that
>
> >
> >> +{
> >> +       mutex_lock(&profile_lock);
> >> +       if (!cur_profile) {
> >> +               mutex_unlock(&profile_lock);
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       sysfs_remove_group(acpi_kobj, &platform_profile_group);
> >> +       cur_profile = NULL;
> >> +       mutex_unlock(&profile_lock);
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
> >> +
> >> +MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> >> new file mode 100644
> >> index 000000000000..f2e1b1c90482
> >> --- /dev/null
> >> +++ b/include/linux/platform_profile.h
> >> @@ -0,0 +1,39 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/*
> >> + * Platform profile sysfs interface
> >> + *
> >> + * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
> >> + * information.
> >> + */
> >> +
> >> +#ifndef _PLATFORM_PROFILE_H_
> >> +#define _PLATFORM_PROFILE_H_
> >> +
> >> +#include <linux/bitops.h>
> >> +
> >> +/*
> >> + * If more options are added please update profile_names
> >> + * array in platform-profile.c and sysfs-platform-profile.rst
> >> + * documentation.
> >> + */
> >> +
> >> +enum platform_profile_option {
> >> +       platform_profile_low,
> >> +       platform_profile_cool,
> >> +       platform_profile_quiet,
> >> +       platform_profile_balanced,
> >> +       platform_profile_perform,
> >> +       platform_profile_last, /*must always be last */

So please use upper-case names in this list.

> >> +};
> >> +
> >> +struct platform_profile_handler {
> >> +       unsigned long choices[BITS_TO_LONGS(platform_profile_last)];
> >> +       int (*profile_get)(enum platform_profile_option *profile);
> >> +       int (*profile_set)(enum platform_profile_option profile);
> >> +};
> >> +
> >> +int platform_profile_register(const struct platform_profile_handler *pprof);
> >> +int platform_profile_unregister(void);
> >> +void platform_profile_notify(void);
> >> +
> >> +#endif  /*_PLATFORM_PROFILE_H_*/
> >> --
