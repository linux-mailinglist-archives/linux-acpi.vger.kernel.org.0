Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E944D24E4
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 11:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbfJJIvg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 04:51:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35198 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390103AbfJJIvf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2019 04:51:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so4204992otb.2;
        Thu, 10 Oct 2019 01:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WNy1ElvBlIaPl/GDmtgPQ9owV2ns5U1oFv7ORu9uBU=;
        b=daVNcE/EVKPZW/LOWlMEgA2sMtNhSisWzXtx24MPYhrcprVMg8tQSbDn9ybR9wzD4m
         hu1h9il3eQXNkx140R02v9VoejoOMA6O0mFy2+8293nNpP9nKElFvEkJVIpzewace0WZ
         +K3LlU6b6gi5UwOR1d1KAY3igzfB4DC0Rf7OmtneT3d0YpuN0+32HjZeeVvWoBGK0+6G
         wrSRiy0OGBLCK+yG84B2g795q7c16DYsNX+scmUNK2oqUiJy6u6KkHEAwPXwwSaKL9pX
         9ab63t+7oLgErHZV+Rb0HuU3+mQR/tGfe4q1rGVG6iv10N+pJl0MAhPN0mc9PSAp1fv7
         19Og==
X-Gm-Message-State: APjAAAWH16C6Ru5oS+trNhYXSiowmK4iF4pCgXUUMY2eoAJQHwNVRXrZ
        yPxePIVYRx3kD19ipPp6IHHBraTi7heufZUTS8Q=
X-Google-Smtp-Source: APXvYqybut8NGn1i7VK/T9RwJi5vdWmQ2cqbahMnWy1naHR4DNpIcCrBdMB7F4wtF7phljdYiF7/SfohwtDZ7o5VOz0=
X-Received: by 2002:a9d:459b:: with SMTP id x27mr6529097ote.167.1570697494577;
 Thu, 10 Oct 2019 01:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <1569514137-2307-1-git-send-email-mario.limonciello@dell.com>
 <97e66464-8407-fd58-21a6-aeb7736dec7b@molgen.mpg.de> <541d9bfa3ccf45b5b07e35e3eebb72ed@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <541d9bfa3ccf45b5b07e35e3eebb72ed@AUSX13MPC105.AMER.DELL.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Oct 2019 10:51:23 +0200
Message-ID: <CAJZ5v0i6tApHQ-QUS3PNo8BZ7CHaqpZea+z=Layyzt0yhGjVeQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Revert "ACPI / PM: Blacklist Low Power S0 Idle
 _DSM for Dell XPS13 9360"
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 8, 2019 at 3:44 AM <Mario.Limonciello@dell.com> wrote:
>
> > On 26.09.19 18:08, Mario Limonciello wrote:
> > > This reverts part of
> > > commit 71630b7a832f ("ACPI / PM: Blacklist Low Power S0 Idle _DSM for
> > > Dell XPS13 9360") to remove the S0ix blacklist for the XPS 9360.
> > >
> > > The problems with this system occurred in one possible NVME SSD when
> > > putting system into s0ix.  As the NVME sleep behavior has been
> > > adjusted in d916b1be this is expected to be now resolved.
> >
> > 1.  Please add, that it was the Hynix(?) SSD.
> > 2.  Please add the commit message summary of d916b1be.
> >
> >      nvme-pci: use host managed power state for suspend
> >
>
> Rafael, let me know if you want me to adjust the commit message and resubmit
> or if you would just handle this task.
>
> > > Cc: 'Paul Menzel <pmenzel@molgen.mpg.de>'
> > > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196907
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> >
> > Tag it for the stable series? d916b1be (first tag v5.3-rc1) is not tagged for stable.
> >
>
> Although Dell arranged a lot of testing with partners I don't feel d916b1be is a stable
> candidate.  Rafael found a corner case with regards to ASPM configuration last minute
> in 5.3rcX, I found a another corner case related to order of events and timing around
> PC10 entry that's getting fixed in 5.4.
>
> > > ---
> > > The particular failing configuration was reported by only ever failed
> > > for Paul Menzel, so hopefully he can test on his failing system.
> >
> > I successfully tested Linux 5.4-rc1+ with this commit last Friday on the Dell XPS
> > 13 9360.
> >
> > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >
>
> Well that's great, appreciate your testing and confirmation.

Applying, thanks!
