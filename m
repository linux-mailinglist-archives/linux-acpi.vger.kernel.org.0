Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394D98F37A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfHOSeX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 14:34:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38982 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfHOSeX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 14:34:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so3062137wra.6;
        Thu, 15 Aug 2019 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlVguU9XpgwsYUA+9hxlWvJwepLXZJiyhWUMhPLxtJU=;
        b=nFJj2RJysrbujouemgWcvH+rthi9Gn3IReFReTGfCZ7pkcyb8fVOcEZaV3NpXxBRfo
         3IvIKtwf26fF96Gr0SANwOcGwnKLF7CiOUiYs3kVIQ/2K8iGwHXLlJD1NPqz9mlzPHpi
         U+t5c2qQsGDELMj0ARpQlNcAAjNTmKFY6BwzGiToVX5+Q2Yh8UpCUQT5ejpcpZg2+bci
         SRCfOJSvCUTE1iijQRQ8dxFBIb1asehXC5g+ii3NZm77FxjHQp5wAWPmRPV++RUgHc7G
         mF0WyAtDnAlST0LrJPbec4Jp7Q0PTm4gGUZe0iCGzWkfisDZ0HhfHQ32rV6snu+aFqGh
         qPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlVguU9XpgwsYUA+9hxlWvJwepLXZJiyhWUMhPLxtJU=;
        b=t1+u4DQFtNMZywjkeHeW62nLwiS1neIl+vd0AoWKZ1zD1pkFL7KPg0xzwAbyHKCm4u
         5i2o2ydlKTurI/StCBVSojqEF5b7bDUbiDtQ3Zyi2tso8iFTyo/LFC3ACfoQDH3fOuS1
         Oo7exdMdqT7vjxUIvwC29tdVFt0jUmfTswmhacheARRY3rsCbaukD7M6qCwj950QIXIX
         7yW/K8x5seOS2cRu1Lf8kSSS/FF4K4eJGNkA2y8O0ChBcrt8ta/lUMtCyNC1ZmKomd8J
         6QmOys41GhtT83y6hLZiVgqqyz3U0+34THMNc/zLJmvTiDkQZKAL1Qe+1BKvvmMGWbeJ
         b4Wg==
X-Gm-Message-State: APjAAAVkWFIg8mlSiz+hYAxGZwZk9Y/fgFVbTtBYC6fC6Oru/5iPcC8x
        KmUrG7FxxeSiNLV4g9zNkZCWW3sevADlWecm8/8=
X-Google-Smtp-Source: APXvYqyEYQ3MDWckUx7xMxV4vAgWCFUTxdu/OBl8PZlVVNfOq+IDthemb8Lkhb3bespAR/hO1pGNxfGZ4U16NcUBy8U=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr6707303wrw.323.1565894061188;
 Thu, 15 Aug 2019 11:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
 <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com>
 <CADnq5_Nv6tsW0J20td5rQSLq048HtTcw1b4c25jP6ZR6XWZ-eA@mail.gmail.com>
 <s5ho90qa34m.wl-tiwai@suse.de> <8724585e50004bc8b6f310587555f4a1@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <8724585e50004bc8b6f310587555f4a1@AUSX13MPC101.AMER.DELL.COM>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Aug 2019 14:34:08 -0400
Message-ID: <CADnq5_NKyK7=C+j+yvxME4u1eN3XEB7n2QnVPEn2QqvwAhquDA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Mario.Limonciello@dell.com
Cc:     Takashi Iwai <tiwai@suse.de>, Karol Herbst <kherbst@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 12:19 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Thursday, August 15, 2019 9:57 AM
> > To: Alex Deucher
> > Cc: Karol Herbst; Limonciello, Mario; nouveau; Rafael J . Wysocki; LKML; dri-devel;
> > Linux ACPI Mailing List; Alex Hung; Ben Skeggs; David Airlie
> > Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
> > enable dGPU direct output"
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Thu, 15 Aug 2019 16:37:05 +0200,
> > Alex Deucher wrote:
> > >
> > > On Thu, Aug 15, 2019 at 10:25 AM Karol Herbst <kherbst@redhat.com> wrote:
> > > >
> > > > On Thu, Aug 15, 2019 at 4:20 PM <Mario.Limonciello@dell.com> wrote:
> > > > >
> > > > > > > There are definitely going to be regressions on machines in the field
> > with the
> > > > > > > in tree drivers by reverting this.  I think we should have an answer for all
> > of
> > > > > > those
> > > > > > > before this revert is accepted.
> > > > > > >
> > > > > > > Regarding systems with Intel+NVIDIA, we'll have to work with partners
> > to
> > > > > > collect
> > > > > > > some information on the impact of reverting this.
> > > > > > >
> > > > > > > When this is used on a system with Intel+AMD the ASL configures AMD
> > GPU to
> > > > > > use
> > > > > > > "Hybrid Graphics" when on Windows and "Power Express" and
> > "Switchable
> > > > > > Graphics"
> > > > > > > when on Linux.
> > > > > >
> > > > > > and what's exactly the difference between those? And what's the actual
> > > > > > issue here?
> > > > >
> > > > > DP/HDMI is not detected unless plugged in at bootup.  It's due to missing
> > HPD
> > > > > events.
> > > > >
> > > >
> > > > afaik Lyude was working on fixing all that, at least for some drivers.
> > > > If there is something wrong, we still should fix the drivers, not
> > > > adding ACPI workarounds.
> > > >
> > > > Alex: do you know if there are remaining issues regarding that with amdgpu?
> > >
> > > There was an issue with hpd events not making it to the audio side
> > > when things were powered down that was fixed with this patch set:
> > > https://patchwork.freedesktop.org/patch/316793/
> > > Those patches depended on a bunch of alsa changes as well which may
> > > have not been available in the distro used for a particular OEM
> > > program.
> >
> > FYI, the corresponding commit for ALSA part is destined for 5.4
> > kernel:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=ade
> > 49db337a9d44ac5835cfce1ee873549011b27
> >
> > BTW, Nouveau should suffer from the same problem.  The patch to add
> > the audio component support is found at:
> >   https://patchwork.freedesktop.org/patch/319131/
> >
> >
>
> It sounds like 5.3rcX won't be a useful check then.
>
> So am I correct to understand that everything related to the AMD failures
> described in this thread should be in linux-next at this point?
>

Assuming you mean the missing audio hotplug events, then yes.

Alex
