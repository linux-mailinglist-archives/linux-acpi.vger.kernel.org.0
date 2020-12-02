Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCEF2CBBCD
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 12:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgLBLq5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 06:46:57 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43696 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgLBLq5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 06:46:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id f12so1321338oto.10;
        Wed, 02 Dec 2020 03:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY5+FPr0JumqKQLNGVglKvtcRgToANWbF/y1ZsXODnY=;
        b=eI3GrgI5QnNCIRT28L4L5tntUtW4IAk177ZFMWNgqHSAsgjBvj0gc9hAHAS+0PfxM/
         Bbu4e0JQrLrmVhbXaMGzIg536a+3btvVmJxvOdtMcTpIq8YlnSR8cjIm9WzSs+Tt20mU
         yZbTDk4r9CI/NOS4TctVJHQLtO6F0alcL5lU8VqQNtE7z2aVF5dyeKfg7dUIZOcQcXQe
         UxCS3R4WsrlYirB+zlQ/11hqeVVyjzyZdGz5Wki07CTOFOGIeNg24pJXUyTORiPC17VV
         H5TYsUOVedjf2ovCgKuC32OT7MdkOOXC796qUOc/mNbhPqJf/gYcBSZyn5sOhwnoMAoU
         p66A==
X-Gm-Message-State: AOAM531eD81wTYBQAUqEaFpUnk3jXYnfaNssPOefE6du88rmODpvMzxr
        bqQOGvFZKg1/KzwHjHihVYQkiKg/UUFVG1v0Vx9Xx1JWlnQ=
X-Google-Smtp-Source: ABdhPJydIJia7HpSXbE2uB/RZzjy8q2/skrADm1OvKUYvjFKPf1hJxMSj1FDUuY84YyJyaaKhLZdv/+AIczAW2LPZLQ=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr1432188ots.321.1606909570220;
 Wed, 02 Dec 2020 03:46:10 -0800 (PST)
MIME-Version: 1.0
References: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
 <CAJZ5v0hqU-qiM8ddYUT_u0Lm3RNM19gNcXye_s5v3DeCHr7mZQ@mail.gmail.com>
 <CAEGmHFFxxOxNBjut68azQ5eMh71J+ysJeX9SOak6WwNetuJnwA@mail.gmail.com>
 <CAJZ5v0j_XWiJyd4zyyuUf41WDEcu5TEo5tT7cYXi8FFqXpBzfA@mail.gmail.com>
 <CAEGmHFE6EfUQ-RE+sXEppOGKxPJ3i9hUSWUDPAGXDjxYm0P_kw@mail.gmail.com> <CAEGmHFF22xg70hZ-jmL5-RnC+PZPXwsT=dHcQbh7SaEOLDpPXA@mail.gmail.com>
In-Reply-To: <CAEGmHFF22xg70hZ-jmL5-RnC+PZPXwsT=dHcQbh7SaEOLDpPXA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Dec 2020 12:45:58 +0100
Message-ID: <CAJZ5v0jAFyGekZ4Qboihucxpbufos7=PYdghDWXNFNYHriO2zw@mail.gmail.com>
Subject: Re: [RFC] ACPI PM during kernel poweroff/reboot
To:     Furquan Shaikh <furquan@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 1, 2020 at 10:38 PM Furquan Shaikh <furquan@google.com> wrote:
>
> On Wed, Nov 25, 2020 at 10:29 AM Furquan Shaikh <furquan@google.com> wrote:
> >
> > On Wed, Nov 25, 2020 at 9:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Wed, Nov 25, 2020 at 6:43 PM Furquan Shaikh <furquan@google.com> wrote:
> > > >
> > > > On Wed, Nov 25, 2020 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Nov 12, 2020 at 8:19 PM Furquan Shaikh <furquan@google.com> wrote:
> > > > > >
> > > > > > On x86 Chromebooks, we have observed this issue for a long time now -
> > > > > > when the system is powered off or rebooted, ACPI PM is not invoked and
> > > > > > this results in PowerResource _OFF methods not being invoked for any
> > > > > > of the devices. The _OFF methods are invoked correctly in case of
> > > > > > suspend-to-idle (S0ix) and suspend-to-memory(S3). However, they do not
> > > > > > get invoked when `poweroff` or `reboot` are triggered.
> > > > > >
> > > > > > One of the differences between suspend, hibernate and shutdown paths
> > > > > > in Linux kernel is that the shutdown path does not use the typical
> > > > > > device PM phases (prepare, freeze/suspend, poweroff) as used by
> > > > > > suspend/hibernate. Instead the shutdown path makes use of
> > > > > > .shutdown_pre() and .shutdown() callbacks.
> > > > > >
> > > > > > If I understand correctly, .shutdown() has been around for a long time
> > > > > > and existed even before the PM callbacks were added. Thus,
> > > > > > pm->poweroff() and .shutdown() are supposed to be analogous and
> > > > > > consistent in the behavior.
> > > > >
> > > > > Well, not quite.
> > > > >
> > > > > ->shutdown() is expected to be a lightweight operation also suitable
> > > > > for kexec() and similar situations where ->poweroff() may not work.
> > > > >
> > > > > > This is why runtime PM is disallowed by
> > > > > > device_shutdown() before it calls .shutdown() (i.e. to keep behavior
> > > > > > consistent for both paths). However, in practice, there are
> > > > > > differences in behavior for the pm->poweroff() and .shutdown() paths
> > > > > > since the shutdown path does not execute any PM domain operations.
> > > > >
> > > > > That's correct.
> > > > >
> > > > > > Because of this difference in behavior, shutdown path never invokes
> > > > > > ACPI PM and thus the ACPI PowerResources are not turned off when the
> > > > > > system is rebooted or powered off (sleep S5). On Chromebooks, it is
> > > > > > critical to run the _OFF methods for poweroff/reboot in order to
> > > > > > ensure that the device power off sequencing requirements are met.
> > > > > > Currently, these requirements are violated which impact the
> > > > > > reliability of devices over the lifetime of the platform.
> > > > > >
> > > > > > There are a few ways in which this can be addressed:
> > > > > >
> > > > > > 1. Similar to the case of hibernation, a new
> > > > > > PMSG_POWEROFF/PM_EVENT_POWEROFF can be introduced to invoke device
> > > > > > power management phases using `dpm_suspend_start(PMSG_POWEROFF)` and
> > > > > > `dpm_suspend_end(PMSG_POWEROFF)`. However, as the shutdown path uses
> > > > > > the class/bus/driver .shutdown() callbacks, adding dpm phases for
> > > > > > poweroff complicates the order of operations. If the dpm phases are
> > > > > > run before .shutdown() callbacks, then it will result in the callbacks
> > > > > > accessing devices after they are powered off. If the .shutdown()
> > > > > > callbacks are run before dpm phases, then the pm->poweroff() calls are
> > > > > > made after the device shutdown is done. Since .shutdown() and
> > > > > > pm->poweroff() are supposed to be analogous, having both calls in the
> > > > > > shutdown path is not only redundant but also results in incorrect
> > > > > > behavior.
> > > > > >
> > > > > > 2. Another option is to update device_shutdown() to make
> > > > > > pm_domain.poweroff calls after the class/bus/driver .shutdown() is
> > > > > > done. However, this suffers from the same problem as #1 above i.e. it
> > > > > > is redundant and creates conflicting order of operations.
> > > > > >
> > > > > > 3. Third possible solution is to detach the device from the PM domain
> > > > > > after it is shutdown. Currently, device drivers perform a detach
> > > > > > operation only when the device is removed. However, in case of
> > > > > > poweroff/reboot as the device is already shutdown, detaching PM domain
> > > > > > will give it the opportunity to ensure that any power resources are
> > > > > > correctly turned off before the system shuts down.
> > > > >
> > > > > 4. Make Chromebooks call something like hibernation_platform_enter()
> > > > > on S5 entries (including reboot).
> > > >
> > > > Actually, Chromebooks do not support S4 and hence CONFIG_HIBERNATION.
> > >
> > > This doesn't matter.  The ->poweroff callbacks can still be used by
> > > them (of course, that part of the current hibernation support code
> > > needs to be put under a more general Kconfig option for that, but this
> > > is a technical detail).
> >
> > Ah I see what you are saying. Just to be sure I understand this
> > correctly. Is this what you are thinking:
> > 1. Extract hibernation_platform_enter() and any other helpers required
> > to trigger the PM phases for shutdown into a separate unit controlled
> > by a more general Kconfig.

Yes in general, but maybe not hibernation_platform_enter() as a whole,
because it contains hibernation-specific code.

> > 2. Add a new Kconfig that enables support for performing PM phases
> > during the poweroff/reboot phases.

Yes.

> > 3. Based on this new Kconfig selection, LINUX_REBOOT_CMD_RESTART,
> > LINUX_REBOOT_CMD_HALT, LINUX_REBOOT_CMD_POWER_OFF will be updated to
> > use the new paths instead of the current lightweight calls.

Maybe not always, but depending on the platform or similar.

> I am currently exploring this approach to see how the components need
> to be organized to make use of hibernation_platform_enter by more than
> just the hibernation path. Please let me know if the above summary
> doesn't align with your suggestion.
>
> Meanwhile, I have also sent out a formal patch for detaching the PM
> domain: https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/T/#u
> to ensure that this addresses the issue with ACPI PM domain.

OK, so let's see what the response to it will be.

> I will continue working on the above suggestion as well, but it might
> take some time for me to get a good understanding of the current paths
> and to cleanly implement the support for PM phases during
> poweroff/reboot cases.

Sure, please take your time!

Thanks a lot for working on this!
