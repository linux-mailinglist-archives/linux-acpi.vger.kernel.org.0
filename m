Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445242C47A7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 19:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgKYSaB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbgKYSaB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 13:30:01 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252E8C061A51
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 10:30:01 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n12so3137552otk.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Veno44/33te6T5lrpYk+J6jOlOlNleQplyEwHwgUesQ=;
        b=PAe1RcAOojRSiku7TXC7udY08ozLfLQ+F8nlRCWfCs5aULe+GEZwPKIK3tVNGTJ9iL
         0wb1snSoRz5UbIu3Vdfc+65dBd1xvZMlqJ2aJKrBWmkoxmF9hfh6arfBU6P8fVXg3lAz
         YKMt/4SFwqGqYNxsUJfHTmdwK7igdc1gCbSNAagNA/bOqtC39OaSqvL43OGxR5Ijarhl
         oTLZArtE/qszhn0X02WZ+SaO23ZrIqRS+I/b7k6ds/gkxYZsSnllabg7MmIGCtPNigNY
         E+UdiUa6NyYT6woJ/gQeV/EWsxifxD1TFQObkwPM7SfzgW8usx5QsLzaA9UfOCgxp4Q8
         IwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Veno44/33te6T5lrpYk+J6jOlOlNleQplyEwHwgUesQ=;
        b=XeCYdyJ6oYD/PPr89n1L+tQ9luFT29PYtD2EUU2jvwLM70y8x3bhmntZv8pHWnXMxS
         SkJpEReeaTrumHPodFcCDZXRSYQ+GYBW4tuLWxW35AtUsyZQV9vl3pl5Imzic+VOKU5q
         ni1kKqUOZkDQXnvwLxiaytFM16jCurcAwL1UGjBxNEQqPZWaCZRB5vgCiSwrrbPZi7KI
         7dE3HKKO7cFzK9bPVBpHIu0O5z/oDKWGyUKOWvuYV//nCS0YJMPr4XBffU1DSJ9Jym1k
         7+s8mYfDGQOa52S1GhF+bADJULSaVhPl0TcbH+x1Pw/lpRYIkDiWNiykNMIrxe7qVroz
         aH6w==
X-Gm-Message-State: AOAM532RXCwaUIBZCfOqEsr0zh9IEwGz0PNCk1t1p/cdn66E0L8qdPia
        0NmuhoHok7dX6NSb/El98FTuXLsSisTKq873JZRvbQ==
X-Google-Smtp-Source: ABdhPJx5TFaj9TYPhw4LnPzBAqsv3w+L5iV4Fafgkq9HeR5SAeqAOEXjVa/wPc0eaUlWZ4HSjfREwY1/iRwjoLnO3zM=
X-Received: by 2002:a05:6830:1e7a:: with SMTP id m26mr3901039otr.104.1606328999288;
 Wed, 25 Nov 2020 10:29:59 -0800 (PST)
MIME-Version: 1.0
References: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
 <CAJZ5v0hqU-qiM8ddYUT_u0Lm3RNM19gNcXye_s5v3DeCHr7mZQ@mail.gmail.com>
 <CAEGmHFFxxOxNBjut68azQ5eMh71J+ysJeX9SOak6WwNetuJnwA@mail.gmail.com> <CAJZ5v0j_XWiJyd4zyyuUf41WDEcu5TEo5tT7cYXi8FFqXpBzfA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j_XWiJyd4zyyuUf41WDEcu5TEo5tT7cYXi8FFqXpBzfA@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 25 Nov 2020 10:29:43 -0800
Message-ID: <CAEGmHFE6EfUQ-RE+sXEppOGKxPJ3i9hUSWUDPAGXDjxYm0P_kw@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 9:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Nov 25, 2020 at 6:43 PM Furquan Shaikh <furquan@google.com> wrote:
> >
> > On Wed, Nov 25, 2020 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Nov 12, 2020 at 8:19 PM Furquan Shaikh <furquan@google.com> wrote:
> > > >
> > > > On x86 Chromebooks, we have observed this issue for a long time now -
> > > > when the system is powered off or rebooted, ACPI PM is not invoked and
> > > > this results in PowerResource _OFF methods not being invoked for any
> > > > of the devices. The _OFF methods are invoked correctly in case of
> > > > suspend-to-idle (S0ix) and suspend-to-memory(S3). However, they do not
> > > > get invoked when `poweroff` or `reboot` are triggered.
> > > >
> > > > One of the differences between suspend, hibernate and shutdown paths
> > > > in Linux kernel is that the shutdown path does not use the typical
> > > > device PM phases (prepare, freeze/suspend, poweroff) as used by
> > > > suspend/hibernate. Instead the shutdown path makes use of
> > > > .shutdown_pre() and .shutdown() callbacks.
> > > >
> > > > If I understand correctly, .shutdown() has been around for a long time
> > > > and existed even before the PM callbacks were added. Thus,
> > > > pm->poweroff() and .shutdown() are supposed to be analogous and
> > > > consistent in the behavior.
> > >
> > > Well, not quite.
> > >
> > > ->shutdown() is expected to be a lightweight operation also suitable
> > > for kexec() and similar situations where ->poweroff() may not work.
> > >
> > > > This is why runtime PM is disallowed by
> > > > device_shutdown() before it calls .shutdown() (i.e. to keep behavior
> > > > consistent for both paths). However, in practice, there are
> > > > differences in behavior for the pm->poweroff() and .shutdown() paths
> > > > since the shutdown path does not execute any PM domain operations.
> > >
> > > That's correct.
> > >
> > > > Because of this difference in behavior, shutdown path never invokes
> > > > ACPI PM and thus the ACPI PowerResources are not turned off when the
> > > > system is rebooted or powered off (sleep S5). On Chromebooks, it is
> > > > critical to run the _OFF methods for poweroff/reboot in order to
> > > > ensure that the device power off sequencing requirements are met.
> > > > Currently, these requirements are violated which impact the
> > > > reliability of devices over the lifetime of the platform.
> > > >
> > > > There are a few ways in which this can be addressed:
> > > >
> > > > 1. Similar to the case of hibernation, a new
> > > > PMSG_POWEROFF/PM_EVENT_POWEROFF can be introduced to invoke device
> > > > power management phases using `dpm_suspend_start(PMSG_POWEROFF)` and
> > > > `dpm_suspend_end(PMSG_POWEROFF)`. However, as the shutdown path uses
> > > > the class/bus/driver .shutdown() callbacks, adding dpm phases for
> > > > poweroff complicates the order of operations. If the dpm phases are
> > > > run before .shutdown() callbacks, then it will result in the callbacks
> > > > accessing devices after they are powered off. If the .shutdown()
> > > > callbacks are run before dpm phases, then the pm->poweroff() calls are
> > > > made after the device shutdown is done. Since .shutdown() and
> > > > pm->poweroff() are supposed to be analogous, having both calls in the
> > > > shutdown path is not only redundant but also results in incorrect
> > > > behavior.
> > > >
> > > > 2. Another option is to update device_shutdown() to make
> > > > pm_domain.poweroff calls after the class/bus/driver .shutdown() is
> > > > done. However, this suffers from the same problem as #1 above i.e. it
> > > > is redundant and creates conflicting order of operations.
> > > >
> > > > 3. Third possible solution is to detach the device from the PM domain
> > > > after it is shutdown. Currently, device drivers perform a detach
> > > > operation only when the device is removed. However, in case of
> > > > poweroff/reboot as the device is already shutdown, detaching PM domain
> > > > will give it the opportunity to ensure that any power resources are
> > > > correctly turned off before the system shuts down.
> > >
> > > 4. Make Chromebooks call something like hibernation_platform_enter()
> > > on S5 entries (including reboot).
> >
> > Actually, Chromebooks do not support S4 and hence CONFIG_HIBERNATION.
>
> This doesn't matter.  The ->poweroff callbacks can still be used by
> them (of course, that part of the current hibernation support code
> needs to be put under a more general Kconfig option for that, but this
> is a technical detail).

Ah I see what you are saying. Just to be sure I understand this
correctly. Is this what you are thinking:
1. Extract hibernation_platform_enter() and any other helpers required
to trigger the PM phases for shutdown into a separate unit controlled
by a more general Kconfig.
2. Add a new Kconfig that enables support for performing PM phases
during the poweroff/reboot phases.
3. Based on this new Kconfig selection, LINUX_REBOOT_CMD_RESTART,
LINUX_REBOOT_CMD_HALT, LINUX_REBOOT_CMD_POWER_OFF will be updated to
use the new paths instead of the current lightweight calls.

>
> > This is done for a number of reasons including security. Hence, I
> > don't think using hibernation_platform_enter() would be an option.
>
> Yes, it is an option.
>
> Having "hibernation" in the name need not mean that the given piece of
> code is really hibernation-specific ...

Sorry, I had misunderstood the suggestion before. I have attempted to
outline your proposal with some more details above.

>
> > >
> > > > Out of these, I think #3 makes the most sense as it does not introduce
> > > > any conflicting operations. I verified that the following diff results
> > > > in _OFF methods getting invoked in both poweroff and reboot cases:
> > >
> > > This won't work for PCI devices though, only for devices in the ACPI
> > > PM domain, so it is not sufficient in general.
> >
> > That is true. The proposed solution only handles detaching of PM
> > domains. I understand your point about this not working for any
> > devices not part of the PM domain. The issues that we have observed in
> > shutdown/reboot paths have been specific to ACPI power resources
> > controlling the sequencing to external devices.
>
> PCI devices PM can use power resources too.  For instance, this has
> been quite common for discrete GPUs in laptops IIRC.

Sorry about my naive question: Is the power resource not described
using ACPI in this case? (I haven't run into a situation with PCI
devices using non-ACPI power resources, so curious to understand the
scenario).
