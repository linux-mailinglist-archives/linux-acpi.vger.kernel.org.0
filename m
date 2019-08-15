Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4BB8EED0
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfHOO7X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:59:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32829 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfHOO7X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:59:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id p77so1192588wme.0;
        Thu, 15 Aug 2019 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEoiihgfqWUe3ZoUXL4XK4SNuss4X3uooLaEcvpyGVE=;
        b=M7wMkduAfusSeOrXSO6pVR8ElCfcK2BWDzneYnMQryY5Y0rhUjuctKHFo8yuXhsAe1
         lONO2Kp+qR3j2K+fhCx4irZbZ1aN4T6Qx+MPtR/FBuTcz2C5K8RxKlGXITBASJq5rVr1
         ERl85HXAoFCfl5FZVh+h5nhkjkr9XHED98fJvOdJa/J5bqu/V3CHvvBv/B1AjNqTtqky
         q5ZT8ujNx/26Fw/zaCclLg5GrzK2Up/z+KD/Oi5vtSMCE5CxMShR/WzHCXWY5xnZRFKu
         ZUUKGL5DKQqyt6/eMC+R4mIzHyt8Jr5Lwr8WgQmi8C18XojrxgQTYx9SRmMPm0Ldi85J
         aKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEoiihgfqWUe3ZoUXL4XK4SNuss4X3uooLaEcvpyGVE=;
        b=M9bPeIdygVvjFOD5TKBnRTXxEgDpHiFtJHEfMJdO1GGXG2VVoLZJN1MQo9UCXNhO5I
         zw+JVd7Jde+LvCRjUTNjYlKXOsn64iJyc++jJK97B1w7ft4dcD2MHMQ2AB8lEYhrUCB2
         TTsFBgEO/PiPjV+LG5wTcdwwAIpTO5euTA3vg0Lsl97OmsWyT1gghHFaclC2l3jEpA01
         ElP8GElT2KiqvTTCMOcBmD6ASbMZ10E9QpdwQd2E1XATo8eTAx3jM6fUZSq0kGR82Yta
         IlyzJkyjmSJ8ZsAKg6TccMhbWDtV+iMEy0+3nprxbNAFVTK6YGGf4RE4b7mer1SkTFLb
         C5Ww==
X-Gm-Message-State: APjAAAXfNv5e4ng3db7z1tc+Xs18uOXPQOwo0uCLzXLSpe1gj2uHYIJ2
        B+t3O0fwH6ZQ6WDZCfD+MSkqRD2wEkrtTQxMXNM=
X-Google-Smtp-Source: APXvYqzOJKvOEo4Aw/+I/NXXfXKxeMLMU/eP2LAGZSEPkkphZ36bVSOCsC64JbJOgeSpIbeS5NdJOb3hNAkOJ3fLIfc=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr3280114wmh.67.1565881161065;
 Thu, 15 Aug 2019 07:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
 <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com> <CADnq5_Nv6tsW0J20td5rQSLq048HtTcw1b4c25jP6ZR6XWZ-eA@mail.gmail.com>
In-Reply-To: <CADnq5_Nv6tsW0J20td5rQSLq048HtTcw1b4c25jP6ZR6XWZ-eA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Aug 2019 10:59:09 -0400
Message-ID: <CADnq5_Oo4CMSx3Bi-41xXDCYKB9RRX33Gke9UyvAGZq1i+VOLA@mail.gmail.com>
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

On Thu, Aug 15, 2019 at 10:37 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Aug 15, 2019 at 10:25 AM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Thu, Aug 15, 2019 at 4:20 PM <Mario.Limonciello@dell.com> wrote:
> > >
> > > > > There are definitely going to be regressions on machines in the field with the
> > > > > in tree drivers by reverting this.  I think we should have an answer for all of
> > > > those
> > > > > before this revert is accepted.
> > > > >
> > > > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to
> > > > collect
> > > > > some information on the impact of reverting this.
> > > > >
> > > > > When this is used on a system with Intel+AMD the ASL configures AMD GPU to
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
> >
> > Alex: do you know if there are remaining issues regarding that with amdgpu?
>
> There was an issue with hpd events not making it to the audio side
> when things were powered down that was fixed with this patch set:
> https://patchwork.freedesktop.org/patch/316793/
> Those patches depended on a bunch of alsa changes as well which may
> have not been available in the distro used for a particular OEM
> program.
>
> >
> > > >
> > > > We already have the PRIME offloading in place and if that's not
> > > > enough, we should work on extending it, not adding some ACPI based
> > > > workarounds, because that's exactly how that looks like.
> > > >
> > > > Also, was this discussed with anybody involved in the drm subsystem?
> > > >
> > > > >
> > > > > I feel we need a knob and/or DMI detection to affect the changes that the ASL
> > > > > normally performs.
> > > >
> > > > Why do we have to do that on a firmware level at all?
> > >
> > > Folks from AMD Graphics team recommended this approach.  From their perspective
> > > it's not a workaround.  They view this as a different architecture for AMD graphics driver on
> > > Windows and AMD graphics w/ amdgpu driver.  They have different ASL paths used for
> > > each.
> >
> > @alex: is this true?
>
> I'm not familiar with this patches in particular, but I know we've
> done things with OEM programs to support Linux on platforms where
> Linux support is lacking for in new features for the target distros.
> E.g., when the first hybrid graphics laptops were coming out, Linux
> didn't support it too well or at all depending on the timing, so the
> bios exposed power express which was working well at the time if the
> OS told ACPI it was Linux.

FWIW, windows does something similar.  I don't think windows 7
supports hybrid graphics either so if the OS tells ACPI it's windows
7, it gets power express instead of hybrid graphics as well.  At least
on laptops that support windows 7 in the first place.

Alex

>
> Alex
