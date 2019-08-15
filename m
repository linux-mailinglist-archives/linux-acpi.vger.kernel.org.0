Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94E88EE5A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbfHOOhG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:37:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37838 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbfHOOhF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:37:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id a21so2240314oie.4
        for <linux-acpi@vger.kernel.org>; Thu, 15 Aug 2019 07:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlFIaDmZ+sHHQP0mYa1mFOngV+vFJdYPAInzrgtIt0M=;
        b=OcndMqxtCcX25w64KBolaL++K9RdwxoelaFyE8ZglECgM01QRzUn7hYTma7HBhRQTh
         VW10Ysjfg6jAal4b2LH5HsRgntL6tKu6woVfS1Sb/HJjCaSGpcFGbx4p3SJM8V2jRmhs
         X1Koux1VYGIhPbxmCANOTRz3qFhegujnkQPDlouHzdadAoQpvXzkZj2Z2yWRcJIT476h
         fBRfA10mFaET1byO9RzTGi1UM6iGWYGEm85YHyJT8evLTAlzhIMgFz30eYvKsVy1Y0QL
         +eARxMrXp1rpeemABen+PO29vPXYCsRlbNuuUlfTNYh4RhOSrDFR7q1/XQZfoZqP7CB9
         coqQ==
X-Gm-Message-State: APjAAAWT6dLYgsRNDT818cTsJ9bazepBDLFgG06yHJBG8z/uZQ0ijQkf
        pGaMwo0b+StWvu13OS/VXnNBtq1CGXsOV85WNUGXMQ==
X-Google-Smtp-Source: APXvYqxgZqfNjbixzTHbLRjdTOD1wqqdFX6azztBPpwrX8nyQmZuIbb1CWjlCWpdontsW35jrvxftk//41Vlnhpur4Y=
X-Received: by 2002:a02:c487:: with SMTP id t7mr5232047jam.99.1565879825035;
 Thu, 15 Aug 2019 07:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
 <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com> <54add026bb6f45fd94a2dc2bae4adf9f@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <54add026bb6f45fd94a2dc2bae4adf9f@AUSX13MPC101.AMER.DELL.COM>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 16:36:54 +0200
Message-ID: <CACO55tthEUVKJN_yCuGU95e8Zc+q-sJEsxML+ZYz7rpU9zDGCg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Mario.Limonciello@dell.com
Cc:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 4:34 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Karol Herbst <kherbst@redhat.com>
> > Sent: Thursday, August 15, 2019 9:25 AM
> > To: Limonciello, Mario
> > Cc: Dave Airlie; LKML; Linux ACPI Mailing List; dri-devel; nouveau; Rafael J .
> > Wysocki; Alex Hung; Ben Skeggs; David Airlie
> > Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
> > enable dGPU direct output"
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Thu, Aug 15, 2019 at 4:20 PM <Mario.Limonciello@dell.com> wrote:
> > >
> > > > > There are definitely going to be regressions on machines in the field with
> > the
> > > > > in tree drivers by reverting this.  I think we should have an answer for all of
> > > > those
> > > > > before this revert is accepted.
> > > > >
> > > > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to
> > > > collect
> > > > > some information on the impact of reverting this.
> > > > >
> > > > > When this is used on a system with Intel+AMD the ASL configures AMD
> > GPU to
> > > > use
> > > > > "Hybrid Graphics" when on Windows and "Power Express" and "Switchable
> > > > Graphics"
> > > > > when on Linux.
> > > >
> > > > and what's exactly the difference between those? And what's the actual
> > > > issue here?
> > >
> > > DP/HDMI is not detected unless plugged in at bootup.  It's due to missing HPD
> > > events.
> > >
> >
> > afaik Lyude was working on fixing all that, at least for some drivers.
> > If there is something wrong, we still should fix the drivers, not
> > adding ACPI workarounds.
>
> I don't disagree, but timing is frequently a limitation if you want the hardware to
> work when you put it on the market.
>
> The whole idea behind the OSI string was that it could be reverted when the time
> was right.  From this discussion it very well may be for systems with AMD GPU, but
> it needs to be checked again.
>
> >
> > Alex: do you know if there are remaining issues regarding that with amdgpu?
> >
> > > >
> > > > We already have the PRIME offloading in place and if that's not
> > > > enough, we should work on extending it, not adding some ACPI based
> > > > workarounds, because that's exactly how that looks like.
> > > >
> > > > Also, was this discussed with anybody involved in the drm subsystem?
> > > >
> > > > >
> > > > > I feel we need a knob and/or DMI detection to affect the changes that the
> > ASL
> > > > > normally performs.
> > > >
> > > > Why do we have to do that on a firmware level at all?
> > >
> > > Folks from AMD Graphics team recommended this approach.
>
> I should clarify this is from the folks on AMD graphics team that interact to OEMs
> like Dell which are not necessarily the same folks who work on the drivers directly.
>

yeah, I understand the pressure, and it might have been fine if we
would have this discussion upstream, if it's about pushing things
upstream. The commits itself didn't even make the impression that
anybody with the drm drivers involved even looked at those patches and
this is the worst part of those commits.

> > From their perspective
> > > it's not a workaround.  They view this as a different architecture for AMD
> > graphics driver on
> > > Windows and AMD graphics w/ amdgpu driver.  They have different ASL paths
> > used for
> > > each.
> >
> > @alex: is this true?
