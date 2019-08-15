Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F638EDFF
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbfHOORb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:17:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46681 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732211AbfHOORb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:17:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so2327409wru.13;
        Thu, 15 Aug 2019 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hR2oVEeRE+U1aLSfdfNg62NTQOkO5YChFCkngTDgHeM=;
        b=nI/VjGd/mq6T+65tzQ7x4tkebtyS3PxvHyhLkdm2i/ZFYP1cgiJvNNMeJ0PPg29XJx
         HwKn5LxRP3UwZu2uWNNmU4CANGdJgMKClTQ5ribhEYvLVdihDi6sq0xDRBWdCNQRTE4H
         f1wIrktxqFPC+xvZsi0AxeLU5q1dfN2iKkKfzmOQWDTjVvqZemKATl3bLR6Hu9WcS7yD
         1248flZzbmcN9exUx1bE1g/Kvcu6z6qJ9cjFx4/IsiMEJVdNPITcbw6946P18Vu6xmAB
         7WJJZ2VyaxQmhLmTLbys+3T6/cfw0yrGX3zHPGBbiDKWUeqbdomaIHmDnFTVxTup1EDQ
         CHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hR2oVEeRE+U1aLSfdfNg62NTQOkO5YChFCkngTDgHeM=;
        b=cqDDOwVDJ5+0o+hCTJ4o85LpdBiDkLUI/4XlfcumEcqmb6Ngle5XxWPhdhdBeQmeGY
         34Ke7By5F10OkmngvRQyuyODXh/D5sE07Wv+7WKs1HvBvZ0bR26XJ/pBg90jz9ZGQz0b
         IcwCLzQhVLN1l+BbxTsqq0TwUZlf7dUAXbZ/Imbb9HiRIsQ03X3TsLcUEcEFR8N/posy
         aNOhztrjAVHaEh5thQjSVcsIiM19RYow1mYDEcqezjPRJMbur0ovuFkGTOUxBXXeRJwD
         hdwQtG4DvkGzPyrBtGrEzvNXA7z6MMalWeQy8ScUVegu8frPtT1+zoCIeePegTWqZ5pb
         W3/A==
X-Gm-Message-State: APjAAAXyyaOh2DZFUuEdejs5GUis4u2SppyM3Bxix5g1kEDYGcqEPsXa
        LLz3EeBtWHEDz+3iFLkKccCVDf4yHQixHEqofiI=
X-Google-Smtp-Source: APXvYqwgEG09J1je3EBh7rb1fgFE0/whIpdRqyy9bANab2t48jig1H2inCjfGhuD0Pl/LhVva2b5zoj8pJFrogTe+KU=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr5599295wrw.323.1565878648396;
 Thu, 15 Aug 2019 07:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
 <CADnq5_NUox3vvg6Mt3i9erA+AL2MfotpNBZQnWWknn4j+j-F=Q@mail.gmail.com> <CACO55tty6TqEo4UBkX5YckLuP-XhHXKVs0ew+Q8__sKMi1BCbA@mail.gmail.com>
In-Reply-To: <CACO55tty6TqEo4UBkX5YckLuP-XhHXKVs0ew+Q8__sKMi1BCbA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Aug 2019 10:17:17 -0400
Message-ID: <CADnq5_PWuLU0pcG549-xThMHy3W0P2+fAO_Ledk6FP2TVG3+gQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Karol Herbst <kherbst@redhat.com>
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

On Thu, Aug 15, 2019 at 10:15 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Thu, Aug 15, 2019 at 4:13 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Aug 15, 2019 at 10:04 AM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > On Thu, Aug 15, 2019 at 3:56 PM <Mario.Limonciello@dell.com> wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org> On
> > > > > Behalf Of Dave Airlie
> > > > > Sent: Wednesday, August 14, 2019 5:48 PM
> > > > > To: Karol Herbst
> > > > > Cc: LKML; Linux ACPI; dri-devel; nouveau; Rafael J . Wysocki; Alex Hung; Ben
> > > > > Skeggs; Dave Airlie
> > > > > Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
> > > > > enable dGPU direct output"
> > > > >
> > > > > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > > > > >
> > > > > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > > > > >
> > > > > > The original commit message didn't even make sense. AMD _does_ support it and
> > > > > > it works with Nouveau as well.
> > > > > >
> > > > > > Also what was the issue being solved here? No references to any bugs and not
> > > > > > even explaining any issue at all isn't the way we do things.
> > > > > >
> > > > > > And even if it means a muxed design, then the fix is to make it work inside the
> > > > > > driver, not adding some hacky workaround through ACPI tricks.
> > > > > >
> > > > > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > > > > >
> > > > >
> > > > > I think the reverts should be merged via Rafael's tree as the original
> > > > > patches went in via there, and we should get them in asap.
> > > > >
> > > > > Acked-by: Dave Airlie <airlied@redhat.com>
> > > > > Dave.
> > > >
> > > > There are definitely going to be regressions on machines in the field with the
> > > > in tree drivers by reverting this.  I think we should have an answer for all of those
> > > > before this revert is accepted.
> > > >
> > > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to collect
> > > > some information on the impact of reverting this.
> > > >
> > > > When this is used on a system with Intel+AMD the ASL configures AMD GPU to use
> > > > "Hybrid Graphics" when on Windows and "Power Express" and "Switchable Graphics"
> > > > when on Linux.
> > >
> > > and what's exactly the difference between those? And what's the actual
> > > issue here?
> >
> > Hybrid Graphics is the new "standard" way of handling these laptops.
> > It uses the standard _PR3 APCI method to handle dGPU power.  Support
> > for this was added to Linux relatively later compared to when the
> > laptops were launched.  "Power Express" used the other AMD specific
> > ATPX ACPI method to handle dGPU power.  The driver supports both so
> > either method will work.
> >
> > Alex
> >
>
> thanks for clarifying. But that still means that we won't need such
> workarounds for AMD users, right? amdgpu handles hybrid graphics just
> fine, right?

Yeah it should, assuming you have a new enough kernel which supports
HG, which has been several years at this point IIRC.

Alex

>
> > >
> > > We already have the PRIME offloading in place and if that's not
> > > enough, we should work on extending it, not adding some ACPI based
> > > workarounds, because that's exactly how that looks like.
> > >
> > > Also, was this discussed with anybody involved in the drm subsystem?
> > >
> > > >
> > > > I feel we need a knob and/or DMI detection to affect the changes that the ASL
> > > > normally performs.
> > >
> > > Why do we have to do that on a firmware level at all?
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
