Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027498EDEC
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfHOOP3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:15:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39863 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfHOOP2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:15:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id 16so2126140oiq.6
        for <linux-acpi@vger.kernel.org>; Thu, 15 Aug 2019 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9jb062JktpIPx3XCuJv3YXZ+jyDnT3aSJG503OYARU=;
        b=ZPfknyeVkNGUtc0WICbS5DTtG+IXH+R9lJLngg0AePNQ3gQmyvdRLnl1rwYQ3lSNd7
         /JWY3o4vK+eilYnWmkJfzciNqAYi2zqDuG40xvGUWGlrpHQdCGOXeevjoZK8FciCN582
         LGfa1OFtuCynYzf1gGXXLFNCucoi851rylO8g3vxcENXLW3rBWrwAxU6rA2NDZrQ3qU1
         qMiC3hl5mYTwErAKHi7MSrnJdYgOevjcOwR+YswamdHcCXDOftqF2MgdIOwF/HvmZjAH
         nDbaqwdeInmZb6SbtPzjD5sWYn32u9/WsxT9vS8czNxRM2RaLcPV7OJa7ejlxY4w1cSQ
         oWlA==
X-Gm-Message-State: APjAAAVw/iW/uFHeitkavjdeLtu7t46fFp3F7gSc/s4ESNYuotwN2Yf4
        rBdttxSWnQHavxmODaT4qVQF5pVoRLjjLSIDgy0iuQ==
X-Google-Smtp-Source: APXvYqxpnadQ2kgqSZUiV7ajsvFWIFx/uIZmcJ+cCemlrXrZgp22YXUqzkttXhECALkTzksoff48J80wrn/BFUt2Yt8=
X-Received: by 2002:a02:69d1:: with SMTP id e200mr5260698jac.138.1565878527612;
 Thu, 15 Aug 2019 07:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com> <CADnq5_NUox3vvg6Mt3i9erA+AL2MfotpNBZQnWWknn4j+j-F=Q@mail.gmail.com>
In-Reply-To: <CADnq5_NUox3vvg6Mt3i9erA+AL2MfotpNBZQnWWknn4j+j-F=Q@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 16:15:16 +0200
Message-ID: <CACO55tty6TqEo4UBkX5YckLuP-XhHXKVs0ew+Q8__sKMi1BCbA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 4:13 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Aug 15, 2019 at 10:04 AM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Thu, Aug 15, 2019 at 3:56 PM <Mario.Limonciello@dell.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org> On
> > > > Behalf Of Dave Airlie
> > > > Sent: Wednesday, August 14, 2019 5:48 PM
> > > > To: Karol Herbst
> > > > Cc: LKML; Linux ACPI; dri-devel; nouveau; Rafael J . Wysocki; Alex Hung; Ben
> > > > Skeggs; Dave Airlie
> > > > Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
> > > > enable dGPU direct output"
> > > >
> > > > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > > > >
> > > > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > > > >
> > > > > The original commit message didn't even make sense. AMD _does_ support it and
> > > > > it works with Nouveau as well.
> > > > >
> > > > > Also what was the issue being solved here? No references to any bugs and not
> > > > > even explaining any issue at all isn't the way we do things.
> > > > >
> > > > > And even if it means a muxed design, then the fix is to make it work inside the
> > > > > driver, not adding some hacky workaround through ACPI tricks.
> > > > >
> > > > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > > > >
> > > >
> > > > I think the reverts should be merged via Rafael's tree as the original
> > > > patches went in via there, and we should get them in asap.
> > > >
> > > > Acked-by: Dave Airlie <airlied@redhat.com>
> > > > Dave.
> > >
> > > There are definitely going to be regressions on machines in the field with the
> > > in tree drivers by reverting this.  I think we should have an answer for all of those
> > > before this revert is accepted.
> > >
> > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to collect
> > > some information on the impact of reverting this.
> > >
> > > When this is used on a system with Intel+AMD the ASL configures AMD GPU to use
> > > "Hybrid Graphics" when on Windows and "Power Express" and "Switchable Graphics"
> > > when on Linux.
> >
> > and what's exactly the difference between those? And what's the actual
> > issue here?
>
> Hybrid Graphics is the new "standard" way of handling these laptops.
> It uses the standard _PR3 APCI method to handle dGPU power.  Support
> for this was added to Linux relatively later compared to when the
> laptops were launched.  "Power Express" used the other AMD specific
> ATPX ACPI method to handle dGPU power.  The driver supports both so
> either method will work.
>
> Alex
>

thanks for clarifying. But that still means that we won't need such
workarounds for AMD users, right? amdgpu handles hybrid graphics just
fine, right?

> >
> > We already have the PRIME offloading in place and if that's not
> > enough, we should work on extending it, not adding some ACPI based
> > workarounds, because that's exactly how that looks like.
> >
> > Also, was this discussed with anybody involved in the drm subsystem?
> >
> > >
> > > I feel we need a knob and/or DMI detection to affect the changes that the ASL
> > > normally performs.
> >
> > Why do we have to do that on a firmware level at all?
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
