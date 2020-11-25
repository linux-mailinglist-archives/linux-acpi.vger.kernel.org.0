Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF72C456C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgKYQjk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 25 Nov 2020 11:39:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42469 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgKYQjj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 11:39:39 -0500
Received: by mail-oi1-f194.google.com with SMTP id v202so3470931oia.9;
        Wed, 25 Nov 2020 08:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7mPfjoGFAjx4anIfQnAyhev/AFP8Uj6hgAhwB8CNMbA=;
        b=HBY+AXgA1nwLaTOvNaFx2LV1//vvBU+Lcq7BChlHPgMxKYgM+BGOdqZ/6DlvH2U+xX
         FHC6r2C+iUmLuvFnawsjaq/RY2BOiMPi1BpmzuDN87usSyyhFSMavw8MLbuPTphL8WHI
         9+65VrS4sK1FJO1S5neV5iBFV+6M8PSk6QXSipPK7yw/+JzNqGOVxeTWsfmpYiO8tLGV
         3GzHBYbZoSPNlQ3NHZ2xxZiLkPGu7wZYejKLxsm6182qHECJ1nMOxn6Uq8/P+ZphktRh
         AdDloUlsemvq2b2jar7FQna7aE4MWFA7MBpPLIA+5MZ2+tOV5JTLMzoYoANkftE90fO4
         DHCA==
X-Gm-Message-State: AOAM532QinyrcYWH72tG6qBV9XlUe0Huh7Ply20e6h35JqfB76U74ET4
        yVuYyNWXYEuvqAq7KJFA1p5UhPFtGzbphp8n2z8=
X-Google-Smtp-Source: ABdhPJyLs19+KmxZQ/Uf6uZAQAx6ghSBtFw0Hp20wybfuAUg4HiuJEbUTE1WZece8jPOkNYEsTy3ooklg/D2z9DmQG0=
X-Received: by 2002:aca:f15:: with SMTP id 21mr2838260oip.71.1606322378446;
 Wed, 25 Nov 2020 08:39:38 -0800 (PST)
MIME-Version: 1.0
References: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
In-Reply-To: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 17:39:27 +0100
Message-ID: <CAJZ5v0hqU-qiM8ddYUT_u0Lm3RNM19gNcXye_s5v3DeCHr7mZQ@mail.gmail.com>
Subject: Re: [RFC] ACPI PM during kernel poweroff/reboot
To:     Furquan Shaikh <furquan@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 8:19 PM Furquan Shaikh <furquan@google.com> wrote:
>
> On x86 Chromebooks, we have observed this issue for a long time now -
> when the system is powered off or rebooted, ACPI PM is not invoked and
> this results in PowerResource _OFF methods not being invoked for any
> of the devices. The _OFF methods are invoked correctly in case of
> suspend-to-idle (S0ix) and suspend-to-memory(S3). However, they do not
> get invoked when `poweroff` or `reboot` are triggered.
>
> One of the differences between suspend, hibernate and shutdown paths
> in Linux kernel is that the shutdown path does not use the typical
> device PM phases (prepare, freeze/suspend, poweroff) as used by
> suspend/hibernate. Instead the shutdown path makes use of
> .shutdown_pre() and .shutdown() callbacks.
>
> If I understand correctly, .shutdown() has been around for a long time
> and existed even before the PM callbacks were added. Thus,
> pm->poweroff() and .shutdown() are supposed to be analogous and
> consistent in the behavior.

Well, not quite.

->shutdown() is expected to be a lightweight operation also suitable
for kexec() and similar situations where ->poweroff() may not work.

> This is why runtime PM is disallowed by
> device_shutdown() before it calls .shutdown() (i.e. to keep behavior
> consistent for both paths). However, in practice, there are
> differences in behavior for the pm->poweroff() and .shutdown() paths
> since the shutdown path does not execute any PM domain operations.

That's correct.

> Because of this difference in behavior, shutdown path never invokes
> ACPI PM and thus the ACPI PowerResources are not turned off when the
> system is rebooted or powered off (sleep S5). On Chromebooks, it is
> critical to run the _OFF methods for poweroff/reboot in order to
> ensure that the device power off sequencing requirements are met.
> Currently, these requirements are violated which impact the
> reliability of devices over the lifetime of the platform.
>
> There are a few ways in which this can be addressed:
>
> 1. Similar to the case of hibernation, a new
> PMSG_POWEROFF/PM_EVENT_POWEROFF can be introduced to invoke device
> power management phases using `dpm_suspend_start(PMSG_POWEROFF)` and
> `dpm_suspend_end(PMSG_POWEROFF)`. However, as the shutdown path uses
> the class/bus/driver .shutdown() callbacks, adding dpm phases for
> poweroff complicates the order of operations. If the dpm phases are
> run before .shutdown() callbacks, then it will result in the callbacks
> accessing devices after they are powered off. If the .shutdown()
> callbacks are run before dpm phases, then the pm->poweroff() calls are
> made after the device shutdown is done. Since .shutdown() and
> pm->poweroff() are supposed to be analogous, having both calls in the
> shutdown path is not only redundant but also results in incorrect
> behavior.
>
> 2. Another option is to update device_shutdown() to make
> pm_domain.poweroff calls after the class/bus/driver .shutdown() is
> done. However, this suffers from the same problem as #1 above i.e. it
> is redundant and creates conflicting order of operations.
>
> 3. Third possible solution is to detach the device from the PM domain
> after it is shutdown. Currently, device drivers perform a detach
> operation only when the device is removed. However, in case of
> poweroff/reboot as the device is already shutdown, detaching PM domain
> will give it the opportunity to ensure that any power resources are
> correctly turned off before the system shuts down.

4. Make Chromebooks call something like hibernation_platform_enter()
on S5 entries (including reboot).

> Out of these, I think #3 makes the most sense as it does not introduce
> any conflicting operations. I verified that the following diff results
> in _OFF methods getting invoked in both poweroff and reboot cases:

This won't work for PCI devices though, only for devices in the ACPI
PM domain, so it is not sufficient in general.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 94df2ba1bbed..e55d65fbb4a9 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_device.h>
>  #include <linux/genhd.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
> @@ -3230,6 +3231,8 @@ void device_shutdown(void)
>                         dev->driver->shutdown(dev);
>                 }
>
> +               dev_pm_domain_detach(dev, true);
> +

It generally makes sense to do this, because ->shutdown() is sort of
analogous to ->remove() from the driver model perspective, so if it is
sufficient for you, please feel free to send a formal patch with that
change.

>                 device_unlock(dev);
>                 if (parent)
>                         device_unlock(parent);
>
> This was discussed on the mailing list some time back[1] in the
> context of a different use case. However, the idea of detaching
> devices (on any bus) from the PM domain during shutdown is important
> to ensure correct power sequencing for the devices.
>
> One of the concerns that was raised on the above thread was slowing
> down the shutdown process when not needed. I think this can be handled
> by adding a sysfs attribute to allow platforms to decide if they need
> the ability to power off PM domains on shutdown/reboot path.

If you need to do that on a per-platform basis, I would go for option
4 above instead.

> Questions that I am looking to get feedback/comments are:
>
> 1. Is my assessment of the problem and understanding of the
> .shutdown() and pm.poweroff() correct?

Not exactly.

> 2. Does the solution #3 i.e. detaching PM domain after shutting down
> device on shutdown path makes sense?

Yes, it does (to me), but no, it is not sufficient to address the
problem at hand.

> 3. Are there other possible approaches to solve this problem that can
> be explored?

Yes, there are.  See option 4 above.

> 4. Do we still have the performance concern about the shutdown path? I
> don’t think anything has changed since that thread, so this is
> probably still true.

I think that it is the case.  Whoever had had any performance concerns
regarding this before is still going to have them.

> 5. Does the use of sysfs attribute make sense to let platform control
> if it wants to detach PM domains on shutdown path?

That would be clunky IMV.

> Sorry about the long thread and thank you so much for your time!

No worries.

Thanks!
