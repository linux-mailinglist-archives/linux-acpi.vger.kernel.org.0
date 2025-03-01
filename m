Return-Path: <linux-acpi+bounces-11664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB7A4AA89
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235491896E8D
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39901D7994;
	Sat,  1 Mar 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jJtG7OGu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467B1E49F;
	Sat,  1 Mar 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740827187; cv=none; b=sKm0XUEpE1IUdJIbic5Ouw66WtNh8DAmc7mb/YxAa+x31t2NqHDIIH06fKf+/rVT3E5pu/wERWSjku7Ti6mfLhLJiFiIDLGNPYG90BBkP5OiBSdH26b+t9inOONPaNZlhUOIXMZVjjsO9wggWImvNZjhJvQm5tfxqpiNa2masL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740827187; c=relaxed/simple;
	bh=dqoPsVHRXcWg1vjIWsWAjPHXMOnXJRABQ0PGuw/EEus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKars6GXFJRZhfo237Y43kO7dlIxSSp1PVn60vNehBfg9WLrofrfpNTHmZyUAAw0OW8NnmSLIua5e/SmROa5LPq0Nxym5i6T9JOK3UldSJbm7Yc+628LSux6bVHfD/eDb4DcSnm/DKleE6DDAjiMkwIEtDWbv9eSZKNpJqIRWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jJtG7OGu; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 4F9262E08D88;
	Sat,  1 Mar 2025 13:06:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740827179;
	bh=aUaoeygsgJhIezOBdNxdiUuZSg+/aY8N4XRGBaLPbKs=;
	h=Received:From:Subject:To;
	b=jJtG7OGu19+zO8g4qDaMHOyPlP+5FGBT34rOHZt44EPyytcympAPjDUFR/Z2m8GDX
	 EC1yvd3RgJxKqHarnJ/olGBeCvJBwM8duadJ8ADNsx+V848uCv4eZdc0eXaYx6DZld
	 Zqay3waGeI+sdLoyFE4J2U38n2xxzQAhSPWpWPMo=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-30737db1aa9so26932581fa.1;
        Sat, 01 Mar 2025 03:06:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWaDW1dFRfzSiepJZoMAyobyGJ9P9akUOyKSGkyKzHmO7bJ/XkFcrFQlobRpHjOcD9aqn0fVYa+Z52R@vger.kernel.org,
 AJvYcCX2Bq8Nh/Dj5aEXFYaxx1NlIP7JvQWGBNhAY5Z601lYXfFR5yvvkAdr4NzqL+o/ZGW2cbZ02opzPm9BZ5ig@vger.kernel.org,
 AJvYcCXqyjD6FikbXw2u1DttgQLl1pb/ogovJSk5/yfjdz4Kt1wB+7h7hvo93plPorbtftvWkMSAl7+t/A49FZ0khsztnhwnLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHThU87cR7LmpTl9IYkadEUrn92r1c9CurtI3rJrkGoulflt8
	lWnLtcozanpMHk6CnBDiarKPzvv+/b/LlXUZ+1uMqmAn4xs8Nute0XpNg1iZVCMaOsM+3eAjc2H
	+ztjo6q+fZlUT1G9yXwb0KNw5Tzw=
X-Google-Smtp-Source: 
 AGHT+IGnRv3z9XRRLV8tL0yHSl9cB67T6t8udv8A8tynYi6QBlHyBYggVjpO2jfQSvTUUnN0EiHxC/wFj177VtfHTQA=
X-Received: by 2002:a05:651c:19a2:b0:308:f53a:ed1d with SMTP id
 38308e7fff4ca-30b93235faemr22574331fa.10.1740827177469; Sat, 01 Mar 2025
 03:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
 <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
 <6f56571a-3090-4323-a29d-008b916abf39@kernel.org>
In-Reply-To: <6f56571a-3090-4323-a29d-008b916abf39@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 12:06:06 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGFLQxGEQ-nb+d9yrikz=fx+u48mpTYUyUtvgFD-9ypQg@mail.gmail.com>
X-Gm-Features: AQ5f1JriMyrOEXTBARHc0fS1e-eUMn3jYC8_UdwxiL8-RLqhL-YLSJ_phnxQYco
Message-ID: 
 <CAGwozwGFLQxGEQ-nb+d9yrikz=fx+u48mpTYUyUtvgFD-9ypQg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden
 choices
To: Mario Limonciello <superm1@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174082717952.9241.9160337531640230093@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 04:19, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 2/28/2025 16:08, Kurt Borja wrote:
> > Hi Mario,
> >
> > On Fri Feb 28, 2025 at 12:01 PM -05, Mario Limonciello wrote:
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When two drivers don't support all the same profiles the legacy interface
> >> only exports the common profiles.
> >>
> >> This causes problems for cases where one driver uses low-power but another
> >> uses quiet because the result is that neither is exported to sysfs.
> >>
> >> To allow two drivers to disagree, add support for "hidden choices".
> >> Hidden choices are platform profiles that a driver supports to be
> >> compatible with the platform profile of another driver.
> >>
> >> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
> >> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> Cc: "Luke D. Jones" <luke@ljones.dev>
> >>   drivers/acpi/platform_profile.c  | 94 +++++++++++++++++++++++++-------
> >>   include/linux/platform_profile.h |  3 +
> >>   2 files changed, 76 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> >> index 2ad53cc6aae53..ef9444482db19 100644
> >> --- a/drivers/acpi/platform_profile.c
> >> +++ b/drivers/acpi/platform_profile.c
> >> @@ -21,9 +21,15 @@ struct platform_profile_handler {
> >>      struct device dev;
> >>      int minor;
> >>      unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >> +    unsigned long hidden_choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >>      const struct platform_profile_ops *ops;
> >>   };
> >>
> >> +struct aggregate_choices_data {
> >> +    unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >> +    int count;
> >> +};
> >> +
> >>   static const char * const profile_names[] = {
> >>      [PLATFORM_PROFILE_LOW_POWER] = "low-power",
> >>      [PLATFORM_PROFILE_COOL] = "cool",
> >> @@ -73,7 +79,7 @@ static int _store_class_profile(struct device *dev, void *data)
> >>
> >>      lockdep_assert_held(&profile_lock);
> >>      handler = to_pprof_handler(dev);
> >> -    if (!test_bit(*bit, handler->choices))
> >> +    if (!test_bit(*bit, handler->choices) && !test_bit(*bit, handler->hidden_choices))
> >>              return -EOPNOTSUPP;
> >>
> >>      return handler->ops->profile_set(dev, *bit);
> >> @@ -239,21 +245,44 @@ static const struct class platform_profile_class = {
> >>   /**
> >>    * _aggregate_choices - Aggregate the available profile choices
> >>    * @dev: The device
> >> - * @data: The available profile choices
> >> + * @arg: struct aggregate_choices_data
> >>    *
> >>    * Return: 0 on success, -errno on failure
> >>    */
> >> -static int _aggregate_choices(struct device *dev, void *data)
> >> +static int _aggregate_choices(struct device *dev, void *arg)
> >>   {
> >> +    unsigned long tmp[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >> +    struct aggregate_choices_data *data = arg;
> >>      struct platform_profile_handler *handler;
> >> -    unsigned long *aggregate = data;
> >>
> >>      lockdep_assert_held(&profile_lock);
> >>      handler = to_pprof_handler(dev);
> >> -    if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> >> -            bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> >> +    bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROFILE_LAST);
> >> +    if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
> >> +            bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
> >>      else
> >> -            bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
> >> +            bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
> >> +    data->count++;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +/**
> >> + * _remove_hidden_choices - Remove hidden choices from aggregate data
> >> + * @dev: The device
> >> + * @arg: struct aggregate_choices_data
> >> + *
> >> + * Return: 0 on success, -errno on failure
> >> + */
> >> +static int _remove_hidden_choices(struct device *dev, void *arg)
> >> +{
> >> +    struct aggregate_choices_data *data = arg;
> >> +    struct platform_profile_handler *handler;
> >> +
> >> +    lockdep_assert_held(&profile_lock);
> >> +    handler = to_pprof_handler(dev);
> >> +    bitmap_andnot(data->aggregate, handler->choices,
> >> +                  handler->hidden_choices, PLATFORM_PROFILE_LAST);
> >>
> >>      return 0;
> >>   }
> >> @@ -270,22 +299,31 @@ static ssize_t platform_profile_choices_show(struct device *dev,
> >>                                           struct device_attribute *attr,
> >>                                           char *buf)
> >>   {
> >> -    unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >> +    struct aggregate_choices_data data = {
> >> +            .aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
> >> +            .count = 0,
> >> +    };
> >>      int err;
> >>
> >> -    set_bit(PLATFORM_PROFILE_LAST, aggregate);
> >> +    set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
> >>      scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> >>              err = class_for_each_device(&platform_profile_class, NULL,
> >> -                                        aggregate, _aggregate_choices);
> >> +                                        &data, _aggregate_choices);
> >>              if (err)
> >>                      return err;
> >> +            if (data.count == 1) {
> >> +                    err = class_for_each_device(&platform_profile_class, NULL,
> >> +                                                &data, _remove_hidden_choices);
> >> +                    if (err)
> >> +                            return err;
> >> +            }
> >>      }
> >>
> >>      /* no profile handler registered any more */
> >> -    if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
> >> +    if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
> >>              return -EINVAL;
> >>
> >> -    return _commmon_choices_show(aggregate, buf);
> >> +    return _commmon_choices_show(data.aggregate, buf);
> >>   }
> >>
> >>   /**
> >> @@ -373,7 +411,10 @@ static ssize_t platform_profile_store(struct device *dev,
> >>                                    struct device_attribute *attr,
> >>                                    const char *buf, size_t count)
> >>   {
> >> -    unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >> +    struct aggregate_choices_data data = {
> >> +            .aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
> >> +            .count = 0,
> >> +    };
> >>      int ret;
> >>      int i;
> >>
> >> @@ -381,13 +422,13 @@ static ssize_t platform_profile_store(struct device *dev,
> >>      i = sysfs_match_string(profile_names, buf);
> >>      if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
> >>              return -EINVAL;
> >> -    set_bit(PLATFORM_PROFILE_LAST, choices);
> >> +    set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
> >>      scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> >>              ret = class_for_each_device(&platform_profile_class, NULL,
> >> -                                        choices, _aggregate_choices);
> >> +                                        &data, _aggregate_choices);
> >>              if (ret)
> >>                      return ret;
> >> -            if (!test_bit(i, choices))
> >> +            if (!test_bit(i, data.aggregate))
> >>                      return -EOPNOTSUPP;
> >>
> >>              ret = class_for_each_device(&platform_profile_class, NULL, &i,
> >> @@ -453,12 +494,15 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
> >>    */
> >>   int platform_profile_cycle(void)
> >>   {
> >> +    struct aggregate_choices_data data = {
> >> +            .aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
> >> +            .count = 0,
> >> +    };
> >>      enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> >>      enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
> >> -    unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >>      int err;
> >>
> >> -    set_bit(PLATFORM_PROFILE_LAST, choices);
> >> +    set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
> >>      scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> >>              err = class_for_each_device(&platform_profile_class, NULL,
> >>                                          &profile, _aggregate_profiles);
> >> @@ -470,14 +514,14 @@ int platform_profile_cycle(void)
> >>                      return -EINVAL;
> >>
> >>              err = class_for_each_device(&platform_profile_class, NULL,
> >> -                                        choices, _aggregate_choices);
> >> +                                        &data, _aggregate_choices);
> >>              if (err)
> >>                      return err;
> >>
> >>              /* never iterate into a custom if all drivers supported it */
> >> -            clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
> >> +            clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
> >>
> >> -            next = find_next_bit_wrap(choices,
> >> +            next = find_next_bit_wrap(data.aggregate,
> >>                                        PLATFORM_PROFILE_LAST,
> >>                                        profile + 1);
> >>
> >> @@ -532,6 +576,14 @@ struct device *platform_profile_register(struct device *dev, const char *name,
> >>              return ERR_PTR(-EINVAL);
> >>      }
> >>
> >> +    if (ops->hidden_choices) {
> >> +            err = ops->hidden_choices(drvdata, pprof->hidden_choices);
> >> +            if (err) {
> >> +                    dev_err(dev, "platform_profile hidden_choices failed\n");
> >> +                    return ERR_PTR(err);
> >> +            }
> >> +    }
> >> +
> >>      guard(mutex)(&profile_lock);
> >>
> >>      /* create class interface for individual handler */
> >> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> >> index 8ab5b0e8eb2c1..8c9df7dadd5d3 100644
> >> --- a/include/linux/platform_profile.h
> >> +++ b/include/linux/platform_profile.h
> >> @@ -33,6 +33,8 @@ enum platform_profile_option {
> >>    * @probe: Callback to setup choices available to the new class device. These
> >>    *    choices will only be enforced when setting a new profile, not when
> >>    *    getting the current one.
> >> + * @hidden_choices: Callback to setup choices that are not visible to the user
> >> + *              but can be set by the driver.
> >>    * @profile_get: Callback that will be called when showing the current platform
> >>    *          profile in sysfs.
> >>    * @profile_set: Callback that will be called when storing a new platform
> >> @@ -40,6 +42,7 @@ enum platform_profile_option {
> >>    */
> >>   struct platform_profile_ops {
> >>      int (*probe)(void *drvdata, unsigned long *choices);
> >> +    int (*hidden_choices)(void *drvdata, unsigned long *choices);
> >>      int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> >>      int (*profile_set)(struct device *dev, enum platform_profile_option profile);
> >>   };
> >
> > This approach works really well for the PMF driver because the
> > profile_get callback retrieves the raw profile that the profile_set
> > callback cached. However this is not the case for quite a few drivers,
> > which usually just retrieve the current profile from WMI for example.
> >
> > This means that writing a profile to the legacy platform_profile
> > attribute, which a driver has selected as a "hidden choice" may result
> > in the operation succeeding, but if the user were to immediately read
> > from platform_profile it would display "custom", because the profiles
> > for different handlers may be unsynchronized.
>
> I guess we need to think about how many other drivers would really need
> hidden choices added.
>
> Is it just PMF?
>
> >
> > This makes me wonder if the added complexity this patch brings, is
> > really worth it.
> >
> > IMHO we should do what Armin suggested in the patch proposed by Antheas.
> > In fact, I would suggest an even simpler version:
> >
> >    1. The legacy platform_profile_choices should aggregate `choices`
> >       with bitmap_or instead of bitmap_and. i.e. It should display all
> >       available choices
> >    2. When writing a profile to the legacy platform_profile, if a handler
> >       doesn't support it, we simply ignore it without failing and
> >       continue to the next
> >
> > I believe this works well with power-profiles-daemon, but I'm not
> > entirely sure. Maybe you know more about it.
> >
> > This of course has the problem that profiles would be unsync and
> > platform_profile might display "custom" immediately after setting a
> > profile, but this patch has the same "issue".
> >
> > For me this "custom" issue, is not really an issue. The legacy interface
> > should be deprecated in favor of the class interface, and new/old
> > user-space tools should use/migrate to that instead.
> >
> > Let me know what you think!
>
> I don't really like that profiles can get out of sync, this is asking
> for a non-deterministic behavior that can be difficult to diagnose
> issues and also difficult for userspace to work with.

I agree with Mario here. Imagine two drivers, one with low-power and
one with quiet. They both begin at performance.

Then, userspace software gets confused (incl. ppd) and sets firmware
profile to low-power. The latter gets left in performance, causing
excess drain.

I do not believe the legacy interface should be deprecated. Right now,
amd-pmf is a NOOP in most devices so there is actually 0 reason for
generic power handlers to move to the new API. Just extra work. So
lets make sure the legacy endpoint works properly for the foreseeable
future.

Also, when power handlers start moving to the new interface, they will
hardcode choices based on the name. As they should. TDP needs to be
customized per device/manufacturer. So moving handlers between
low-power and quiet will not be possible.

@Mario: I do not have a device with an amd-pmf integration. All of
mine have stub handlers. I would expect that a properly configured pmf
handler for e.g., Asus would do the same as the armoury interface, so
that users do not have to rely to vendor software on WIndows. Then
power profiles would be synced between windows and armoury. In that
case, we have a problem of setting the power mode twice. What would be
the mitigation for something like that?

Antheas

