Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D8E2C46F9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 18:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgKYRn5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 12:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbgKYRn4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 12:43:56 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFFBC061A4F
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 09:43:56 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id k3so2948718otp.12
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u+YTLyj4ie3IN86jCfx4Roc0oN5l1ohxrxg0M+ICyFc=;
        b=v+0TaqJIZ6xBdedY8c/QAOafuOnHFYHa0PpHixm3maGaH8aKnKdTG8lEVFj2AOtKSg
         5Y6y8wRQMdmnXkprxxEmZ5PyKQMJQPCNfln2+GqIgjUx/a9vuUmuJbSjHJo3Uf5plH8K
         7s9fdnHhHt10Bkeaup2izshGDkztf5zU1N3zyRSwioZ122xrSKawBoBwPVRCt+rLsi50
         R9lS/LMZ1uV+O0clhb6z1ggLdriAe+QKlYa4nKartNHuXHzhIXIW3UvFNc6dsQV4+/Jg
         hEbQBOUMtP/XLz3REBvWq63wcDk9htj0qdiUtGbajghqbtu581e221Y7F32K70vD7+Co
         jGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u+YTLyj4ie3IN86jCfx4Roc0oN5l1ohxrxg0M+ICyFc=;
        b=G4ixdaXYjRGoVteoCVARBzFW1qW5mWi+e4/BDYB24GFyiPu8PKDUqL9S4qjPrPlIhg
         VcuEJtZjjBOJw/I+UXcl3+AjYQmL9R+xl3dAgHV3gX4xxZw5fOioSYrQVogp5ACYbd1R
         sfAByLsXa+mRdgKVjh8jlXoScUIAdbFN/haT+R+GRx7mAuJxlBDhaLQBRle1Oai8znzP
         bo7pZ23uPvuvvWQj5h7iOL81/B7BKoflvxjp36CkB8rsRLPVT9/Q+o7CsJU3jg+Rbfcg
         2hU09A8HR4y3/tPQODjHC3vmuZeXIn5bNSAoh9NEBHxQ+Mdc4EaRTbHcYVeWCQoQ7HvR
         mENA==
X-Gm-Message-State: AOAM5330EsOKCewhiUQKxdPIpKSH6e6s/tU9fSKKfBGc5D/VA2kDEY8z
        9D08VBg9ufpkLhY87SjR8HXTbcyrv7QPbdX0dfK9kA==
X-Google-Smtp-Source: ABdhPJyip73KKye5lZJcDseEDLuJUEZv7hv+XO9IpoBbBlSGjUiSUzpged/8GPgX+LQZgHaZLxDge9g4x9YwpNNB944=
X-Received: by 2002:a05:6830:18f8:: with SMTP id d24mr3682744otf.44.1606326235683;
 Wed, 25 Nov 2020 09:43:55 -0800 (PST)
MIME-Version: 1.0
References: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
 <CAJZ5v0hqU-qiM8ddYUT_u0Lm3RNM19gNcXye_s5v3DeCHr7mZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqU-qiM8ddYUT_u0Lm3RNM19gNcXye_s5v3DeCHr7mZQ@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 25 Nov 2020 09:43:39 -0800
Message-ID: <CAEGmHFFxxOxNBjut68azQ5eMh71J+ysJeX9SOak6WwNetuJnwA@mail.gmail.com>
Subject: Re: [RFC] ACPI PM during kernel poweroff/reboot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Thu, Nov 12, 2020 at 8:19 PM Furquan Shaikh <furquan@google.com> wrote=
:
> >
> > On x86 Chromebooks, we have observed this issue for a long time now -
> > when the system is powered off or rebooted, ACPI PM is not invoked and
> > this results in PowerResource _OFF methods not being invoked for any
> > of the devices. The _OFF methods are invoked correctly in case of
> > suspend-to-idle (S0ix) and suspend-to-memory(S3). However, they do not
> > get invoked when `poweroff` or `reboot` are triggered.
> >
> > One of the differences between suspend, hibernate and shutdown paths
> > in Linux kernel is that the shutdown path does not use the typical
> > device PM phases (prepare, freeze/suspend, poweroff) as used by
> > suspend/hibernate. Instead the shutdown path makes use of
> > .shutdown_pre() and .shutdown() callbacks.
> >
> > If I understand correctly, .shutdown() has been around for a long time
> > and existed even before the PM callbacks were added. Thus,
> > pm->poweroff() and .shutdown() are supposed to be analogous and
> > consistent in the behavior.
>
> Well, not quite.
>
> ->shutdown() is expected to be a lightweight operation also suitable
> for kexec() and similar situations where ->poweroff() may not work.
>
> > This is why runtime PM is disallowed by
> > device_shutdown() before it calls .shutdown() (i.e. to keep behavior
> > consistent for both paths). However, in practice, there are
> > differences in behavior for the pm->poweroff() and .shutdown() paths
> > since the shutdown path does not execute any PM domain operations.
>
> That's correct.
>
> > Because of this difference in behavior, shutdown path never invokes
> > ACPI PM and thus the ACPI PowerResources are not turned off when the
> > system is rebooted or powered off (sleep S5). On Chromebooks, it is
> > critical to run the _OFF methods for poweroff/reboot in order to
> > ensure that the device power off sequencing requirements are met.
> > Currently, these requirements are violated which impact the
> > reliability of devices over the lifetime of the platform.
> >
> > There are a few ways in which this can be addressed:
> >
> > 1. Similar to the case of hibernation, a new
> > PMSG_POWEROFF/PM_EVENT_POWEROFF can be introduced to invoke device
> > power management phases using `dpm_suspend_start(PMSG_POWEROFF)` and
> > `dpm_suspend_end(PMSG_POWEROFF)`. However, as the shutdown path uses
> > the class/bus/driver .shutdown() callbacks, adding dpm phases for
> > poweroff complicates the order of operations. If the dpm phases are
> > run before .shutdown() callbacks, then it will result in the callbacks
> > accessing devices after they are powered off. If the .shutdown()
> > callbacks are run before dpm phases, then the pm->poweroff() calls are
> > made after the device shutdown is done. Since .shutdown() and
> > pm->poweroff() are supposed to be analogous, having both calls in the
> > shutdown path is not only redundant but also results in incorrect
> > behavior.
> >
> > 2. Another option is to update device_shutdown() to make
> > pm_domain.poweroff calls after the class/bus/driver .shutdown() is
> > done. However, this suffers from the same problem as #1 above i.e. it
> > is redundant and creates conflicting order of operations.
> >
> > 3. Third possible solution is to detach the device from the PM domain
> > after it is shutdown. Currently, device drivers perform a detach
> > operation only when the device is removed. However, in case of
> > poweroff/reboot as the device is already shutdown, detaching PM domain
> > will give it the opportunity to ensure that any power resources are
> > correctly turned off before the system shuts down.
>
> 4. Make Chromebooks call something like hibernation_platform_enter()
> on S5 entries (including reboot).

Actually, Chromebooks do not support S4 and hence CONFIG_HIBERNATION.
This is done for a number of reasons including security. Hence, I
don't think using hibernation_platform_enter() would be an option.

>
> > Out of these, I think #3 makes the most sense as it does not introduce
> > any conflicting operations. I verified that the following diff results
> > in _OFF methods getting invoked in both poweroff and reboot cases:
>
> This won't work for PCI devices though, only for devices in the ACPI
> PM domain, so it is not sufficient in general.

That is true. The proposed solution only handles detaching of PM
domains. I understand your point about this not working for any
devices not part of the PM domain. The issues that we have observed in
shutdown/reboot paths have been specific to ACPI power resources
controlling the sequencing to external devices.

>
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 94df2ba1bbed..e55d65fbb4a9 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/genhd.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/sched/signal.h>
> > @@ -3230,6 +3231,8 @@ void device_shutdown(void)
> >                         dev->driver->shutdown(dev);
> >                 }
> >
> > +               dev_pm_domain_detach(dev, true);
> > +
>
> It generally makes sense to do this, because ->shutdown() is sort of
> analogous to ->remove() from the driver model perspective, so if it is
> sufficient for you, please feel free to send a formal patch with that
> change.

I will work on creating a formal patch and send it for review.

>
> >                 device_unlock(dev);
> >                 if (parent)
> >                         device_unlock(parent);
> >
> > This was discussed on the mailing list some time back[1] in the
> > context of a different use case. However, the idea of detaching
> > devices (on any bus) from the PM domain during shutdown is important
> > to ensure correct power sequencing for the devices.
> >
> > One of the concerns that was raised on the above thread was slowing
> > down the shutdown process when not needed. I think this can be handled
> > by adding a sysfs attribute to allow platforms to decide if they need
> > the ability to power off PM domains on shutdown/reboot path.
>
> If you need to do that on a per-platform basis, I would go for option
> 4 above instead.

For Chromebooks, I don't see a reason to do this on a per-platform
basis. But, I wanted to make sure that the proposed change does not
have any side-effect on any other user upstream.

>
> > Questions that I am looking to get feedback/comments are:
> >
> > 1. Is my assessment of the problem and understanding of the
> > .shutdown() and pm.poweroff() correct?
>
> Not exactly.
>
> > 2. Does the solution #3 i.e. detaching PM domain after shutting down
> > device on shutdown path makes sense?
>
> Yes, it does (to me), but no, it is not sufficient to address the
> problem at hand.
>
> > 3. Are there other possible approaches to solve this problem that can
> > be explored?
>
> Yes, there are.  See option 4 above.
>
> > 4. Do we still have the performance concern about the shutdown path? I
> > don=E2=80=99t think anything has changed since that thread, so this is
> > probably still true.
>
> I think that it is the case.  Whoever had had any performance concerns
> regarding this before is still going to have them.
>
> > 5. Does the use of sysfs attribute make sense to let platform control
> > if it wants to detach PM domains on shutdown path?
>
> That would be clunky IMV.

I can start with the diff I pasted above as a formal patch to see if
it makes sense. If more changes are required to it, I can work on
them.

>
> > Sorry about the long thread and thank you so much for your time!
>
> No worries.

Thanks again for your time. I really appreciate the insight and comments.

- Furquan

>
> Thanks!
