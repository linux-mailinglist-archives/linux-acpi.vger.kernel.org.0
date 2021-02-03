Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C306430E30D
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBCTGv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 14:06:51 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39388 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhBCTGt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 14:06:49 -0500
Received: by mail-ot1-f42.google.com with SMTP id i30so927980ota.6;
        Wed, 03 Feb 2021 11:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaRJ1lKGsWrtOjLJdmIxwR8/35nJtXRBsV7NRKg4JS4=;
        b=DCA8x8OMT0D9aNqbZXCvT/wqgPzjgz/X+LV9CoXM6/3lDMl06Tz+B3XYSDv3WMx52n
         LO4AKmXdB1lBTwSqEI65iS4Ou5sni9x99F74Jta6iB8obgjRpUaPB+096R5TXaPrm84u
         YGzrZYjN6lDPI7zPK8b9oQIQLRu/rOoepP/DKJk7gIrLIPr8nSsioWDMiPpAw83uApJy
         EG47q/gPUi9tq75nbg0s0oqQXpBxSPaTmduwh2OpqhoP+qvLK7smN4SJ3oZjeOVhJCdn
         jQyjxn4mGU6uyU/yZvt0hxsuzEDpEVnkRwjvHd5VM7yqDBS/hiBNTcZSaMpi/OkIMORU
         Gr9A==
X-Gm-Message-State: AOAM5301zVH+ZjpQ81G7Nh0E+rOFUpjQis50d8/yjZRrkgudpW3Xi+6G
        8GXvBKvC/ga53amgtldHUfG+aqwf05Pr5A02PRs=
X-Google-Smtp-Source: ABdhPJwxVmHWTe6WXL/HamSHiGCXnc1IH+H3WDU1pcGT6kVvMfM7RUwopT6jBaIUANzkFzMrD9KV4ay6L9cYkQcKQ+I=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr3133692otm.206.1612379166407;
 Wed, 03 Feb 2021 11:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210126082101.GD4903@dell> <YA/xfxcwCabETug6@smile.fi.intel.com>
 <YBhLuNZ7xmHdhurU@smile.fi.intel.com> <CAJZ5v0jQLZ7hEn7nDN8AADy7djnrQRrC4jtXKY-YqZiO609_2A@mail.gmail.com>
 <20210202081519.GY4774@dell>
In-Reply-To: <20210202081519.GY4774@dell>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Feb 2021 20:05:55 +0100
Message-ID: <CAJZ5v0hJ94YM_bjOQ=bB7esLaxJjErSfGeYk+y3HOybBEEDOWw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 9:15 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 01 Feb 2021, Rafael J. Wysocki wrote:
>
> > On Mon, Feb 1, 2021 at 7:45 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Jan 26, 2021 at 12:39:59PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 26, 2021 at 08:21:01AM +0000, Lee Jones wrote:
> > > > > On Mon, 25 Jan 2021, Andy Shevchenko wrote:
> > > > >
> > > > > > This is a second part of the Intel MID outdated platforms removal.
> > > > > > First part is available as immutable branch [1]. The series has functional
> > > > > > and build dependencies, so the mentioned branch should be used as a base
> > > > > > for these changes.
> > > > > >
> > > > > > Note, that some of the drivers, that arch/x86 covers, seems never appeared
> > > > > > in the upstream (like msic_ocd).
> > > > >
> > > > > What platforms stop working after this removal?
> > > >
> > > > Intel Moorstown, Medfield, Clovertrail.
> > > >
> > > > > Are you sure no-one is using them?
> > > >
> > > > Definitely.
> > > >
> > > > > I wouldn't be keen on breaking Janet's PC that she's been using daily
> > > > > and keeping up-to-date since the 90's.
> > > >
> > > > They never were in PCs.
> > > >
> > > > All of them were supported by Android and Janet won't update her phone or even
> > > > Android tablet for sure they never ever run any kind of Linux than Android.
> > >
> > > So, I hope you are satisfied and we may proceed with removal.
> >
> > Speaking of which, the patches here are requisite for SFI support
> > removal, so I'd like to route them through the ACPI tree if that's
> > fine by all of the interested parties.
>
> Shouldn't cause too much disruption.
>
> Ack provided.

Thanks!

This series has been applied as 5.12 material and will show up in
linux-next on Friday if all goes well.

I can export an immutable branch with these commits if need be, in
which case please let me know.

Andy, please proceed with the SFI support removal submission.
