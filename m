Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1277F2C4708
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgKYRvT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 12:51:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37405 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgKYRvT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 12:51:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id l36so3006254ota.4;
        Wed, 25 Nov 2020 09:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elu3KlNVC7Bg7FcxXAr74RB7sxITSb5AYSQBm3//nXA=;
        b=beWQN8onTUYNFUYTa6P8+z1L1jTXpwkaj8xS51K3lqpO3Z2Y+CzgfZuH7ge4EAHs5D
         3AFD70PHWRXGxRx4FycXD2UmV7L+aLnSnOscsj348hV7Czc19zkYHdigxPkK6K+bpZGm
         JFVQNkyFTXFoPnYZs4JQg2og5w5e9I8xqe/XhiAmkeai1hC7vY7/eHDObbh08/STDRn8
         1UDjqlBFe3bjoZzd85EUWkhL9hLpphDVpZ+z0LxxzVjNdMWgy92FU0VBN+/SQXw4HWkm
         3gTdHeMkxau8fL/DMebvSDKFJX2K3s8XPBtZ/ySumjB5FAn+frAlbB5iVNxUdCs2WAP3
         62Tg==
X-Gm-Message-State: AOAM533Rga4n893dIS264pMbtn+xFTdmOyiHVc8urXsGyXmUdn7Kdww1
        rlmNEKeLP5EpE/M1TkRa6C+c98//MC6HKmaTI8IBi5fA
X-Google-Smtp-Source: ABdhPJy3TYQnIgNSsI/pUFfNm/TlPAIKgVy7WMXog1byvFcqjVW4PGXLfygTOaQMHVgC21TElPnlpuxH+nZRsQcXHBw=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr3661192ots.321.1606326677463;
 Wed, 25 Nov 2020 09:51:17 -0800 (PST)
MIME-Version: 1.0
References: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
 <CAJZ5v0hqU-qiM8ddYUT_u0Lm3RNM19gNcXye_s5v3DeCHr7mZQ@mail.gmail.com> <CAEGmHFFxxOxNBjut68azQ5eMh71J+ysJeX9SOak6WwNetuJnwA@mail.gmail.com>
In-Reply-To: <CAEGmHFFxxOxNBjut68azQ5eMh71J+ysJeX9SOak6WwNetuJnwA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 18:51:06 +0100
Message-ID: <CAJZ5v0j_XWiJyd4zyyuUf41WDEcu5TEo5tT7cYXi8FFqXpBzfA@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 6:43 PM Furquan Shaikh <furquan@google.com> wrote:
>
> On Wed, Nov 25, 2020 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Nov 12, 2020 at 8:19 PM Furquan Shaikh <furquan@google.com> wrote:
> > >
> > > On x86 Chromebooks, we have observed this issue for a long time now -
> > > when the system is powered off or rebooted, ACPI PM is not invoked and
> > > this results in PowerResource _OFF methods not being invoked for any
> > > of the devices. The _OFF methods are invoked correctly in case of
> > > suspend-to-idle (S0ix) and suspend-to-memory(S3). However, they do not
> > > get invoked when `poweroff` or `reboot` are triggered.
> > >
> > > One of the differences between suspend, hibernate and shutdown paths
> > > in Linux kernel is that the shutdown path does not use the typical
> > > device PM phases (prepare, freeze/suspend, poweroff) as used by
> > > suspend/hibernate. Instead the shutdown path makes use of
> > > .shutdown_pre() and .shutdown() callbacks.
> > >
> > > If I understand correctly, .shutdown() has been around for a long time
> > > and existed even before the PM callbacks were added. Thus,
> > > pm->poweroff() and .shutdown() are supposed to be analogous and
> > > consistent in the behavior.
> >
> > Well, not quite.
> >
> > ->shutdown() is expected to be a lightweight operation also suitable
> > for kexec() and similar situations where ->poweroff() may not work.
> >
> > > This is why runtime PM is disallowed by
> > > device_shutdown() before it calls .shutdown() (i.e. to keep behavior
> > > consistent for both paths). However, in practice, there are
> > > differences in behavior for the pm->poweroff() and .shutdown() paths
> > > since the shutdown path does not execute any PM domain operations.
> >
> > That's correct.
> >
> > > Because of this difference in behavior, shutdown path never invokes
> > > ACPI PM and thus the ACPI PowerResources are not turned off when the
> > > system is rebooted or powered off (sleep S5). On Chromebooks, it is
> > > critical to run the _OFF methods for poweroff/reboot in order to
> > > ensure that the device power off sequencing requirements are met.
> > > Currently, these requirements are violated which impact the
> > > reliability of devices over the lifetime of the platform.
> > >
> > > There are a few ways in which this can be addressed:
> > >
> > > 1. Similar to the case of hibernation, a new
> > > PMSG_POWEROFF/PM_EVENT_POWEROFF can be introduced to invoke device
> > > power management phases using `dpm_suspend_start(PMSG_POWEROFF)` and
> > > `dpm_suspend_end(PMSG_POWEROFF)`. However, as the shutdown path uses
> > > the class/bus/driver .shutdown() callbacks, adding dpm phases for
> > > poweroff complicates the order of operations. If the dpm phases are
> > > run before .shutdown() callbacks, then it will result in the callbacks
> > > accessing devices after they are powered off. If the .shutdown()
> > > callbacks are run before dpm phases, then the pm->poweroff() calls are
> > > made after the device shutdown is done. Since .shutdown() and
> > > pm->poweroff() are supposed to be analogous, having both calls in the
> > > shutdown path is not only redundant but also results in incorrect
> > > behavior.
> > >
> > > 2. Another option is to update device_shutdown() to make
> > > pm_domain.poweroff calls after the class/bus/driver .shutdown() is
> > > done. However, this suffers from the same problem as #1 above i.e. it
> > > is redundant and creates conflicting order of operations.
> > >
> > > 3. Third possible solution is to detach the device from the PM domain
> > > after it is shutdown. Currently, device drivers perform a detach
> > > operation only when the device is removed. However, in case of
> > > poweroff/reboot as the device is already shutdown, detaching PM domain
> > > will give it the opportunity to ensure that any power resources are
> > > correctly turned off before the system shuts down.
> >
> > 4. Make Chromebooks call something like hibernation_platform_enter()
> > on S5 entries (including reboot).
>
> Actually, Chromebooks do not support S4 and hence CONFIG_HIBERNATION.

This doesn't matter.  The ->poweroff callbacks can still be used by
them (of course, that part of the current hibernation support code
needs to be put under a more general Kconfig option for that, but this
is a technical detail).

> This is done for a number of reasons including security. Hence, I
> don't think using hibernation_platform_enter() would be an option.

Yes, it is an option.

Having "hibernation" in the name need not mean that the given piece of
code is really hibernation-specific ...

> >
> > > Out of these, I think #3 makes the most sense as it does not introduce
> > > any conflicting operations. I verified that the following diff results
> > > in _OFF methods getting invoked in both poweroff and reboot cases:
> >
> > This won't work for PCI devices though, only for devices in the ACPI
> > PM domain, so it is not sufficient in general.
>
> That is true. The proposed solution only handles detaching of PM
> domains. I understand your point about this not working for any
> devices not part of the PM domain. The issues that we have observed in
> shutdown/reboot paths have been specific to ACPI power resources
> controlling the sequencing to external devices.

PCI devices PM can use power resources too.  For instance, this has
been quite common for discrete GPUs in laptops IIRC.
