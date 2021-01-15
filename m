Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25532F7EA6
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 15:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAOO4X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 09:56:23 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:40250 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbhAOO4X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2021 09:56:23 -0500
Received: by mail-oi1-f178.google.com with SMTP id p5so9793199oif.7
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jan 2021 06:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YibjyW9Ukkd+ZGavzpOosG9J6pqgrKhVoIx7H8Bbo8o=;
        b=c3iVwJi6t623bqQ5VL6HQq/9MblL/itLuGz34bqHID6RYev7pNMDb94QCvBg3ZKjCW
         /IjrtP2k5wrZMxDvytGkDE94U0Rrox8GG68wMuUG3RsZ030ZY/H2AIiAwwqsAu5VM1nl
         mQHGJr5/y649G/O6klBQcCkOUjL1Yck5isR5K7xAdDSjaQIQ5bXCDTN0vfPHFlfAI4XH
         /p4tB0wFDX8BnrUEZdlIWYZBnSK2RE8egXvGL2kZ21HMy8robaC4Rk2kG1nMD5xMApc+
         kiEcn5AhrBlBNz1MHxuxSr+gwp80SThDwKxctSxmk3r5dvwNWO7qNZcmpqQd1Xw67630
         hlKQ==
X-Gm-Message-State: AOAM5304VhBtiM0AuIpLTH8Fg1Rltb8oqsRI+vMotqlV/vb+L591tAa6
        U4HSqP2EV+okr/TMS+6UfIEAwKlrGvaS0IPvw2E=
X-Google-Smtp-Source: ABdhPJwSWQKzsQg5CL9ZEydOGx78Cs8BB8nj2TlSBh9FfHt97gvFkYOuoF1reKl18z13jSWNvLJ1Djmipy19YHlJpaI=
X-Received: by 2002:aca:4892:: with SMTP id v140mr5939498oia.71.1610722542068;
 Fri, 15 Jan 2021 06:55:42 -0800 (PST)
MIME-Version: 1.0
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com> <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
 <2473340.5W3TeCB90J@kreacher> <b56e75b7-2cdb-dd82-e9eb-f05414b8a970@linux.intel.com>
In-Reply-To: <b56e75b7-2cdb-dd82-e9eb-f05414b8a970@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jan 2021 15:55:31 +0100
Message-ID: <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com>
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 3:52 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >> Yep, those 'hacks' solve the boot problem on my device. I tried multiple
> >> times and it's completely reproducible.
> >>
> >>> And can you collect an acpidump from the device and either send it to me and Rafael
> >>> offlist, or upload it somewhere and send us a link ?
> >>
> >> will do
> >
> > In addition to what Hans asked for, can you please build the kernel with the
> > debug patch below applied (instead of the Hans' debug patch), try to boot
> > the affected machine with it and see what is missing with respect to booting
> > the kernel with the two problematic commits reverted?
>
> Sorry, not following. Are you asking me to apply the patch below as well
> as revert the two problematic commits? Or just the patch below?

Just the patch below.

> the boot process is stuck without the reverts and I don't have a serial link to
> see what happens (closed form-factor).

The point is that the patch below may unstuck it, in which case it
should be possible to find out what is missing with respect to the
full successful boot.

> > Also please send me the outout of "dmesg | grep "Enumeration" from the debug
> > kernel if possible. >
> > ---
> >   drivers/acpi/scan.c |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -1951,7 +1951,7 @@ static acpi_status acpi_bus_check_add(ac
> >               u32 count = acpi_scan_check_dep(handle);
> >               /* Bail out if the number of recorded dependencies is not 0. */
> >               if (count > 0) {
> > -                     acpi_bus_scan_second_pass = true;
> > +                     acpi_handle_info(handle, "Enumeration skipped\n");
> >                       return AE_CTRL_DEPTH;
> >               }
> >       }
> >
> >
> >
