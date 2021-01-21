Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD872FE2B5
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 07:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbhAUGYE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 01:24:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43315 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbhAUGXt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 01:23:49 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l2TMt-0005zm-Lo
        for linux-acpi@vger.kernel.org; Thu, 21 Jan 2021 06:22:55 +0000
Received: by mail-lj1-f199.google.com with SMTP id z8so363302lji.8
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2021 22:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=286+aLvFTV4FtvBetACGVIfc0aQZT7xsQ6Fn1YFzNWE=;
        b=U9cXZzwXjkf/H+Yafm2AjgmK+YmnYTH8aiudEOw3U8m5wlIzKE7H5M4rGTW7XA1rBr
         qeGkv8632rdsRRB/Tz+LtKs4PZDPGHKB94wlDA/vmfr6ug8KkRZwbEWd6JFFeEjxW70i
         KbugS1uOwuyOSMe4U99oX2kdumO1FtNJ2qtDUpW/gD9v5cnMhRd5s2xTbBKSD1hdnZRV
         kSgM0QM7lqf5Rvhi1hF4D0aGefe8alUaiSNHan4/ZbIJyBG5de/PEAnhJ5GbZTDqFcw6
         7hRnW3ktBJdRQ1V77Hpe2V+IjLiOLB0mMu8av3o1uSvEeLGekxZAWstP9j9uZuVv79MG
         SOjw==
X-Gm-Message-State: AOAM5321IRbZ0kNQFidPiYWYPWTgj63B23CGDOGN7/rlRMqvalceEGOx
        Kc4D4KOVRIc76FB9oN8PAs8cc+qEStStHo4QsnhFngPJvRFxq6g5LaFBXqfGS5PtpSn2OAJWxKJ
        izlTZCZuJ8F0V/KCXMwmKwCprTXhZDzrPxkjYRj/V9OJnFnbBg+fH9Kk=
X-Received: by 2002:a2e:8947:: with SMTP id b7mr6258780ljk.116.1611210175164;
        Wed, 20 Jan 2021 22:22:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCYbbieVYKMHA4ivsq3wSRzf1SDvF4od/jM20SWLxethLb+Wu7rnFyvpDvgKmiBX6k5moAFl+6vWRHEoXwphQ=
X-Received: by 2002:a2e:8947:: with SMTP id b7mr6258769ljk.116.1611210174921;
 Wed, 20 Jan 2021 22:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20210119081513.300938-1-kai.heng.feng@canonical.com>
 <YAaXz9Pg5x3DsCs3@kroah.com> <CAAd53p7tdFiARtW1RXsjN8+OwRXWzMnok_rfKHDHCh-JSam3cQ@mail.gmail.com>
 <20210119094159.GQ4077@smile.fi.intel.com> <YAa1ygjr2L3VxBKF@kroah.com>
In-Reply-To: <YAa1ygjr2L3VxBKF@kroah.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Jan 2021 14:22:43 +0800
Message-ID: <CAAd53p4MTSzuPEp3Y5=wP3HwguTOkyTrVZpi6xOCS0_Q1qcMdQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible" modalias
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 19, 2021 at 6:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 19, 2021 at 11:41:59AM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 19, 2021 at 04:41:48PM +0800, Kai-Heng Feng wrote:
> > > On Tue, Jan 19, 2021 at 4:27 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Tue, Jan 19, 2021 at 04:15:13PM +0800, Kai-Heng Feng wrote:
> >
> > ...
> >
> > > > Who will use OF_MODALIAS and where have you documented it?
> > >
> > > After this lands in mainline, I'll modify the pull request for systemd
> > > to add a new rule for OF_MODALIAS.
> > > I'll modify the comment on the function to document the change.
> >
> > I'm wondering why to have two fixes in two places instead of fixing udev to
> > understand multiple MODALIAS= events?
>
> It's not a matter of multiple events, it's a single event with a
> key/value pair with duplicate keys and different values.
>
> What is this event with different values supposed to be doing in
> userspace?  Do you want multiple invocations of `modprobe` or something
> else?
>
> Usually a "device" only has a single "signature" that modprobe uses to
> look up the correct module for.  Modules can support any number of
> device signatures, but traditionally it is odd to think that a device
> itself can be supported by multiple modules, which is what you are
> saying is happening here.
>
> So what should userspace do with this, and why does a device need to
> have multiple module alias signatures?

From the original use case [1], I think the "compatible" modalias
should be enough.
Andy and Mika, what do you think? Can we remove the ACPI modalias for this case?

[1] https://lwn.net/Articles/612062/

Kai-Heng

>
> thanks,
>
> greg k-h
