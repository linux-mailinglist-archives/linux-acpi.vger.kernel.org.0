Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24462CAEF8
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390497AbgLAVjt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 16:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390405AbgLAVjr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 16:39:47 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E0C061A04
        for <linux-acpi@vger.kernel.org>; Tue,  1 Dec 2020 13:38:46 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f11so3427782oij.6
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2020 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SGbCKhGi2huBUmw95S0mXDfQK1a5orR6k2GE3LGlmE=;
        b=Haszwyf/uMk7AS86p/zU0UNha6DqLHcVBpPAgQ+RfKiwbUK26DC7EwwxS0gRm+hrgY
         9qlo9fnWAbsW585b50DrpcnK5vCeTj3nMIbXnXeDZ2wejI/yvDJEngCGV/gAI7ylKpg2
         g0r8jB4LzkeclowFN2co0viC7ZwlDvVkkEwD24B4NQ6ZTRlkzKCMnMoXAIyU1/gHK7QB
         4ITTesNYOMpDfpHzn4voozpE8B4aj+kPzlUEL+iD0w6/BTD6n8M/wUlewaS5LW8UN+HE
         /uIXdsikc1t3/z7UpAekAxCjYKc7iRHAXsQqmfvWx7m76FMOkJFk7Oqo3qOlBZ11sOoT
         KjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SGbCKhGi2huBUmw95S0mXDfQK1a5orR6k2GE3LGlmE=;
        b=G5hvn5h2NkVIj/0TBKZSbZelAEHSwBGaAAJxPY2xTgoXQ1yWmyi4Csh1GvxUm3ePVQ
         mnjjuY5y7xx+aFN6uzlQXpCZiAd1IHR2PaI81K7JdqxaffiQGJSNFwa4d9o99yI+s5Bb
         CTxZTkZggcAwgpudUPCJglAH150x4en41rjVgFAvWrD75DiGC5QEEdBhnRxQVyaFSlYj
         FfWqK1ZJG4V8SHzIM78/C9hn158zEgoiVC9Hk5yfz7EMQupQlQpYpm2rPY0G35AKAa1s
         VmmS4EB8C95qOnrmBzVJCD+n17lh+27XNJGdTcI+bMMJDQ8UQHrgu5xBzUwlIrRl0/UV
         zQ9g==
X-Gm-Message-State: AOAM5339jzHkIDP9Kyodg6FTBtFT028KTgt57tXaZqh0uFXxfaRvT7Kd
        TICXele24pGkU0joRUZBFEabNdw+/74mWCGuAHr5FQ==
X-Google-Smtp-Source: ABdhPJwYstjfUJRRlBmUq7Rd6D/Ggg4PvkXLcIIe2s6yBc7QXhsFvm/Mp3rU8qiiP59Hy6rjv/gD6MbsEImLxmyoPK4=
X-Received: by 2002:aca:bc84:: with SMTP id m126mr3078556oif.169.1606858725694;
 Tue, 01 Dec 2020 13:38:45 -0800 (PST)
MIME-Version: 1.0
References: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
 <CAJZ5v0hqU-qiM8ddYUT_u0Lm3RNM19gNcXye_s5v3DeCHr7mZQ@mail.gmail.com>
 <CAEGmHFFxxOxNBjut68azQ5eMh71J+ysJeX9SOak6WwNetuJnwA@mail.gmail.com>
 <CAJZ5v0j_XWiJyd4zyyuUf41WDEcu5TEo5tT7cYXi8FFqXpBzfA@mail.gmail.com> <CAEGmHFE6EfUQ-RE+sXEppOGKxPJ3i9hUSWUDPAGXDjxYm0P_kw@mail.gmail.com>
In-Reply-To: <CAEGmHFE6EfUQ-RE+sXEppOGKxPJ3i9hUSWUDPAGXDjxYm0P_kw@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Tue, 1 Dec 2020 13:38:27 -0800
Message-ID: <CAEGmHFF22xg70hZ-jmL5-RnC+PZPXwsT=dHcQbh7SaEOLDpPXA@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 10:29 AM Furquan Shaikh <furquan@google.com> wrote:
>
> On Wed, Nov 25, 2020 at 9:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Nov 25, 2020 at 6:43 PM Furquan Shaikh <furquan@google.com> wrote:
> > >
> > > On Wed, Nov 25, 2020 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Nov 12, 2020 at 8:19 PM Furquan Shaikh <furquan@google.com> wrote:
> > > > >
> > > > > On x86 Chromebooks, we have observed this issue for a long time now -
> > > > > when the system is powered off or rebooted, ACPI PM is not invoked and
> > > > > this results in PowerResource _OFF methods not being invoked for any
> > > > > of the devices. The _OFF methods are invoked correctly in case of
> > > > > suspend-to-idle (S0ix) and suspend-to-memory(S3). However, they do not
> > > > > get invoked when `poweroff` or `reboot` are triggered.
> > > > >
> > > > > One of the differences between suspend, hibernate and shutdown paths
> > > > > in Linux kernel is that the shutdown path does not use the typical
> > > > > device PM phases (prepare, freeze/suspend, poweroff) as used by
> > > > > suspend/hibernate. Instead the shutdown path makes use of
> > > > > .shutdown_pre() and .shutdown() callbacks.
> > > > >
> > > > > If I understand correctly, .shutdown() has been around for a long time
> > > > > and existed even before the PM callbacks were added. Thus,
> > > > > pm->poweroff() and .shutdown() are supposed to be analogous and
> > > > > consistent in the behavior.
> > > >
> > > > Well, not quite.
> > > >
> > > > ->shutdown() is expected to be a lightweight operation also suitable
> > > > for kexec() and similar situations where ->poweroff() may not work.
> > > >
> > > > > This is why runtime PM is disallowed by
> > > > > device_shutdown() before it calls .shutdown() (i.e. to keep behavior
> > > > > consistent for both paths). However, in practice, there are
> > > > > differences in behavior for the pm->poweroff() and .shutdown() paths
> > > > > since the shutdown path does not execute any PM domain operations.
> > > >
> > > > That's correct.
> > > >
> > > > > Because of this difference in behavior, shutdown path never invokes
> > > > > ACPI PM and thus the ACPI PowerResources are not turned off when the
> > > > > system is rebooted or powered off (sleep S5). On Chromebooks, it is
> > > > > critical to run the _OFF methods for poweroff/reboot in order to
> > > > > ensure that the device power off sequencing requirements are met.
> > > > > Currently, these requirements are violated which impact the
> > > > > reliability of devices over the lifetime of the platform.
> > > > >
> > > > > There are a few ways in which this can be addressed:
> > > > >
> > > > > 1. Similar to the case of hibernation, a new
> > > > > PMSG_POWEROFF/PM_EVENT_POWEROFF can be introduced to invoke device
> > > > > power management phases using `dpm_suspend_start(PMSG_POWEROFF)` and
> > > > > `dpm_suspend_end(PMSG_POWEROFF)`. However, as the shutdown path uses
> > > > > the class/bus/driver .shutdown() callbacks, adding dpm phases for
> > > > > poweroff complicates the order of operations. If the dpm phases are
> > > > > run before .shutdown() callbacks, then it will result in the callbacks
> > > > > accessing devices after they are powered off. If the .shutdown()
> > > > > callbacks are run before dpm phases, then the pm->poweroff() calls are
> > > > > made after the device shutdown is done. Since .shutdown() and
> > > > > pm->poweroff() are supposed to be analogous, having both calls in the
> > > > > shutdown path is not only redundant but also results in incorrect
> > > > > behavior.
> > > > >
> > > > > 2. Another option is to update device_shutdown() to make
> > > > > pm_domain.poweroff calls after the class/bus/driver .shutdown() is
> > > > > done. However, this suffers from the same problem as #1 above i.e. it
> > > > > is redundant and creates conflicting order of operations.
> > > > >
> > > > > 3. Third possible solution is to detach the device from the PM domain
> > > > > after it is shutdown. Currently, device drivers perform a detach
> > > > > operation only when the device is removed. However, in case of
> > > > > poweroff/reboot as the device is already shutdown, detaching PM domain
> > > > > will give it the opportunity to ensure that any power resources are
> > > > > correctly turned off before the system shuts down.
> > > >
> > > > 4. Make Chromebooks call something like hibernation_platform_enter()
> > > > on S5 entries (including reboot).
> > >
> > > Actually, Chromebooks do not support S4 and hence CONFIG_HIBERNATION.
> >
> > This doesn't matter.  The ->poweroff callbacks can still be used by
> > them (of course, that part of the current hibernation support code
> > needs to be put under a more general Kconfig option for that, but this
> > is a technical detail).
>
> Ah I see what you are saying. Just to be sure I understand this
> correctly. Is this what you are thinking:
> 1. Extract hibernation_platform_enter() and any other helpers required
> to trigger the PM phases for shutdown into a separate unit controlled
> by a more general Kconfig.
> 2. Add a new Kconfig that enables support for performing PM phases
> during the poweroff/reboot phases.
> 3. Based on this new Kconfig selection, LINUX_REBOOT_CMD_RESTART,
> LINUX_REBOOT_CMD_HALT, LINUX_REBOOT_CMD_POWER_OFF will be updated to
> use the new paths instead of the current lightweight calls.

I am currently exploring this approach to see how the components need
to be organized to make use of hibernation_platform_enter by more than
just the hibernation path. Please let me know if the above summary
doesn't align with your suggestion.

Meanwhile, I have also sent out a formal patch for detaching the PM
domain: https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/T/#u
to ensure that this addresses the issue with ACPI PM domain.

I will continue working on the above suggestion as well, but it might
take some time for me to get a good understanding of the current paths
and to cleanly implement the support for PM phases during
poweroff/reboot cases.

Thanks,
Furquan

>
> >
> > > This is done for a number of reasons including security. Hence, I
> > > don't think using hibernation_platform_enter() would be an option.
> >
> > Yes, it is an option.
> >
> > Having "hibernation" in the name need not mean that the given piece of
> > code is really hibernation-specific ...
>
> Sorry, I had misunderstood the suggestion before. I have attempted to
> outline your proposal with some more details above.
>
> >
> > > >
> > > > > Out of these, I think #3 makes the most sense as it does not introduce
> > > > > any conflicting operations. I verified that the following diff results
> > > > > in _OFF methods getting invoked in both poweroff and reboot cases:
> > > >
> > > > This won't work for PCI devices though, only for devices in the ACPI
> > > > PM domain, so it is not sufficient in general.
> > >
> > > That is true. The proposed solution only handles detaching of PM
> > > domains. I understand your point about this not working for any
> > > devices not part of the PM domain. The issues that we have observed in
> > > shutdown/reboot paths have been specific to ACPI power resources
> > > controlling the sequencing to external devices.
> >
> > PCI devices PM can use power resources too.  For instance, this has
> > been quite common for discrete GPUs in laptops IIRC.
>
> Sorry about my naive question: Is the power resource not described
> using ACPI in this case? (I haven't run into a situation with PCI
> devices using non-ACPI power resources, so curious to understand the
> scenario).
