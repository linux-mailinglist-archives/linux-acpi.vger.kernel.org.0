Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4C8EE1C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbfHOOZT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:25:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42375 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732588AbfHOOZS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:25:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id j7so6207865ota.9
        for <linux-acpi@vger.kernel.org>; Thu, 15 Aug 2019 07:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1srfTVVrcLRgd7+YxvKeopiwdoMN+JSwzxmbw7BufKY=;
        b=aw9n6pmjP4bKiVlWCFJcp9p/iqKUgSIFOvfO03U6Urc8JPvJK/DRfOZqnbW1tBBgi0
         tV+nTmaHdMzU8Itl+VNAlvQuHjCvoe/iKpn928eG7GJW+R5Q7UFu3yyGK4YAiQS3/TD3
         ovDBB8F1DbW+PhtxZVf3wAc8ysmpxXLYoQ5Y1DTMlYoap9p7z1Q/FsmR90Jxy+RdsUL7
         axpVEyHb8UToWJ+Gq6HBiWGRZIcTG+t74UBTIG9TyZNCM9scUSbj+7aniKBNjlG1r1YQ
         mPjQWs3DR8nBkp9Sf+d7cWTj0h8M/Es97l8xSV90Ao3BxM8JwXtFntUb4BTZ5+pYoXI/
         GSYQ==
X-Gm-Message-State: APjAAAWcEh+y5RU5nsqVIyPtgjKhoH029vP2zPKI5A1Q7mF6a0JzSK/H
        tOcQAVRDZkmJZ9Yv2p9WBTT/xwR2KE30ju4LL2f0xA==
X-Google-Smtp-Source: APXvYqyrsllK46/iEpgqVrPevhv4r81hiZTZAIlyGy948ydui3IANnmoo0w+/y8635P46GWeANx/Vo/sumdoLjxDBXo=
X-Received: by 2002:a6b:7606:: with SMTP id g6mr5795786iom.288.1565879117968;
 Thu, 15 Aug 2019 07:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com> <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 16:25:06 +0200
Message-ID: <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com>
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

On Thu, Aug 15, 2019 at 4:20 PM <Mario.Limonciello@dell.com> wrote:
>
> > > There are definitely going to be regressions on machines in the field with the
> > > in tree drivers by reverting this.  I think we should have an answer for all of
> > those
> > > before this revert is accepted.
> > >
> > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to
> > collect
> > > some information on the impact of reverting this.
> > >
> > > When this is used on a system with Intel+AMD the ASL configures AMD GPU to
> > use
> > > "Hybrid Graphics" when on Windows and "Power Express" and "Switchable
> > Graphics"
> > > when on Linux.
> >
> > and what's exactly the difference between those? And what's the actual
> > issue here?
>
> DP/HDMI is not detected unless plugged in at bootup.  It's due to missing HPD
> events.
>

afaik Lyude was working on fixing all that, at least for some drivers.
If there is something wrong, we still should fix the drivers, not
adding ACPI workarounds.

Alex: do you know if there are remaining issues regarding that with amdgpu?

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
>
> Folks from AMD Graphics team recommended this approach.  From their perspective
> it's not a workaround.  They view this as a different architecture for AMD graphics driver on
> Windows and AMD graphics w/ amdgpu driver.  They have different ASL paths used for
> each.

@alex: is this true?
