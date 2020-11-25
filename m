Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DCB2C42B5
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgKYPLb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 10:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgKYPLb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 10:11:31 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B227C061A51
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 07:11:31 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f11so3167002oij.6
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 07:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KhouDFsqki7Gy7e25xqYBbfXim5cXw795bT1eo81Xzs=;
        b=DhKi5OC8Ur4Zm2+OE+tFBLFuXfc8do+T1RzzHNu+Yog3JYYT2iwU28JYwWKu/qP8uz
         plmqJV23D3qj1oFDX56KAJP9TsfE17RFe+hi4MQpRFAvIOWK1zxDGkykUkIDA71H/Ve+
         Rsk6IS74+XnrhOWM9cGTKJzylovB0TXD4nI7inJjlCGKQCYfB2TIt88o3Ha8RJrCEUni
         LUObNG0RGxeBKniI7QDu7Rh8j+Ye11zOPLJmXLUXXzc6kVpQyUYXVsUg7iWGyzx/DhOa
         /Fo9AejZsd79AKZzl6JifI+9yJoozeEMTE00D2p44b7n6Ir2GhMlC49hdAgxjgsMga02
         SzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KhouDFsqki7Gy7e25xqYBbfXim5cXw795bT1eo81Xzs=;
        b=MumdzTB/EsKVMGbHkQOqkA1lvOjl2HhollHIwuPOSepk+aes7NZCJkHxKN+4MP7+b3
         GmoemaisrW/O3mKvxC11YtPBsFbEEM5mQJmQdsL7x/uEfmsd21aADv3MtaIjgrYL+tHc
         w9BYz8Tu5yz8IQ+TGxfmtF17f2YVjCq+UDWLkU7tEImivsBKVhkaTC2GyICaZxywbA5n
         XuoBEB1h88j9xZz5xZxibDmU84yjRsG+vq1zGErgX44pCWnBkO8p+7/UiYLQ6mR8L8vt
         sZwJMSVZdeMVwgaSlLFsGuMe9RPQEoEaTpZpOrc8a8HnFscfGK5PHF6aU1Xzue3cuaQH
         XZcA==
X-Gm-Message-State: AOAM530+Duq7v4gZcCdDCvxjwcs2bkWRQ5Zg+LFLqgBVuD5abuSISoT2
        nmW4RDHX7kX6mpLjOUcUsjl4tZFhwRjw/9bIUFCcdw==
X-Google-Smtp-Source: ABdhPJx1C0mlZ1qHr6cS5D413otFJ7/k79MvTeKPZdG1JtfzZ4qqY9mjd3ubV4DYwBYgm4SdocaDNnM002LY6xZXrFo=
X-Received: by 2002:aca:1110:: with SMTP id 16mr2489983oir.12.1606317089916;
 Wed, 25 Nov 2020 07:11:29 -0800 (PST)
MIME-Version: 1.0
References: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
In-Reply-To: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 25 Nov 2020 07:11:13 -0800
Message-ID: <CAEGmHFHmYujYMRLxoyF8Vj4-HAWAqLwu9zCw2FJhJdgh1SKL0g@mail.gmail.com>
Subject: Re: [RFC] ACPI PM during kernel poweroff/reboot
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 11:19 AM Furquan Shaikh <furquan@google.com> wrote:
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
> consistent in the behavior. This is why runtime PM is disallowed by
> device_shutdown() before it calls .shutdown() (i.e. to keep behavior
> consistent for both paths). However, in practice, there are
> differences in behavior for the pm->poweroff() and .shutdown() paths
> since the shutdown path does not execute any PM domain operations.
>
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
>
> Out of these, I think #3 makes the most sense as it does not introduce
> any conflicting operations. I verified that the following diff results
> in _OFF methods getting invoked in both poweroff and reboot cases:
>
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
>
> Questions that I am looking to get feedback/comments are:
>
> 1. Is my assessment of the problem and understanding of the
> .shutdown() and pm.poweroff() correct?
> 2. Does the solution #3 i.e. detaching PM domain after shutting down
> device on shutdown path makes sense?
> 3. Are there other possible approaches to solve this problem that can
> be explored?
> 4. Do we still have the performance concern about the shutdown path? I
> don=E2=80=99t think anything has changed since that thread, so this is
> probably still true.
> 5. Does the use of sysfs attribute make sense to let platform control
> if it wants to detach PM domains on shutdown path?
>
> Sorry about the long thread and thank you so much for your time!
>
> Thanks,
> Furquan
>
> [1] https://lore.kernel.org/linux-pm/HE1PR04MB30046668C9F4FFAB5C07E693886=
D0@HE1PR04MB3004.eurprd04.prod.outlook.com/T/#mbd80804857f38c66aa5e825cdd4b=
61ba6b12317d

Hello,

Gentle ping. Just wanted to check if there are any
comments/suggestions on the proposal above or how this problem can be
addressed. This has been one of the long standing problems impacting
all ACPI-based Chrome OS devices.

Thanks,
Furquan
