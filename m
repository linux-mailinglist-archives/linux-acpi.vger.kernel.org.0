Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681638EE5F
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfHOOhT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:37:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52109 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfHOOhT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:37:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1469628wma.1;
        Thu, 15 Aug 2019 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPQ51ux9FIpcBSeRyi+l+v24f1Z1qLlUHJqhkNZGZbI=;
        b=IBTtv4/Z5fL7OlNtqvr0o6XLgpRtPHAJZKUU7TuLy8fMgtOMqKEE9Qt0aK5JOTVTBy
         0bBTv8jzN78r1wq6nfmfl7IIXsbxPPm0E6B8tgwkyjiZyoMK9Zxo5iCSq741dVIGVQzN
         SvEZoHciKmSHxvxGdNzXOtoIq56U0D/rJKIJUC0Cs/t1K+EUuDbZfx4XzmjRErSQ0Krl
         4GbkaQxkS0ChXuzKKc+UGC1+DUP+SieNzV46TVJGMQrs9xHotbhbzVnDKgF05q8wTxrA
         ww54jeQ24Sc1jnP1OCaK3eBLvbIuTc1edo5eRgloz4NQyFHTced8rBciVi9XbOqiwH+z
         h6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPQ51ux9FIpcBSeRyi+l+v24f1Z1qLlUHJqhkNZGZbI=;
        b=CXIF2/zcsGFe+m/RwyuMHYGrkbrXL9e7knZAPpuhk+kuTuizUA9SWtxOmC28BxK9mt
         nylvgZpS+6NVVn05lvWw7qplQW7TvrdxaWfO977CjtsKY9rOCmW9dKA4V7AskwAqDkV3
         qzb7IbdGnVhGKeNCbstHv2sKUwkfMc3yJ3I+ALcMGjlXIYTRFaekLrUE+5oWkS2Pu0il
         Dan+lrpAhNZKYUZbyzVG9aejthY79j7X2+wDDG0qZ8EQACe0Lq4n5ZN7hk53jKhsxMfA
         A636y/JmhV9NLlLDVvQpYeHMIvHHZeZ90c/Rd+MTk9j2L5McUsgOwmKTEelPstL7+Vsg
         pxoQ==
X-Gm-Message-State: APjAAAXtsdmFAHY+nwEMYkWNyXuYDlIKI+/ptaJ1N4Qjo7LCnq/sY9H+
        OJ8/AuXPElGoC9VTNIx3LO3X27+fHGTwQDDhFbs=
X-Google-Smtp-Source: APXvYqzk5hmmCfQL2ZVsJ4ebPcL/pgxAQ1FKmKW3rsIE8Vek+CCGrUwG+yxiTrreuqAg8XloqspNVNWuV8kv5ECT8fQ=
X-Received: by 2002:a05:600c:352:: with SMTP id u18mr3077889wmd.141.1565879837306;
 Thu, 15 Aug 2019 07:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
 <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM> <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com>
In-Reply-To: <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Aug 2019 10:37:05 -0400
Message-ID: <CADnq5_Nv6tsW0J20td5rQSLq048HtTcw1b4c25jP6ZR6XWZ-eA@mail.gmail.com>
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

On Thu, Aug 15, 2019 at 10:25 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Thu, Aug 15, 2019 at 4:20 PM <Mario.Limonciello@dell.com> wrote:
> >
> > > > There are definitely going to be regressions on machines in the field with the
> > > > in tree drivers by reverting this.  I think we should have an answer for all of
> > > those
> > > > before this revert is accepted.
> > > >
> > > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to
> > > collect
> > > > some information on the impact of reverting this.
> > > >
> > > > When this is used on a system with Intel+AMD the ASL configures AMD GPU to
> > > use
> > > > "Hybrid Graphics" when on Windows and "Power Express" and "Switchable
> > > Graphics"
> > > > when on Linux.
> > >
> > > and what's exactly the difference between those? And what's the actual
> > > issue here?
> >
> > DP/HDMI is not detected unless plugged in at bootup.  It's due to missing HPD
> > events.
> >
>
> afaik Lyude was working on fixing all that, at least for some drivers.
> If there is something wrong, we still should fix the drivers, not
> adding ACPI workarounds.
>
> Alex: do you know if there are remaining issues regarding that with amdgpu?

There was an issue with hpd events not making it to the audio side
when things were powered down that was fixed with this patch set:
https://patchwork.freedesktop.org/patch/316793/
Those patches depended on a bunch of alsa changes as well which may
have not been available in the distro used for a particular OEM
program.

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
> >
> > Folks from AMD Graphics team recommended this approach.  From their perspective
> > it's not a workaround.  They view this as a different architecture for AMD graphics driver on
> > Windows and AMD graphics w/ amdgpu driver.  They have different ASL paths used for
> > each.
>
> @alex: is this true?

I'm not familiar with this patches in particular, but I know we've
done things with OEM programs to support Linux on platforms where
Linux support is lacking for in new features for the target distros.
E.g., when the first hybrid graphics laptops were coming out, Linux
didn't support it too well or at all depending on the timing, so the
bios exposed power express which was working well at the time if the
OS told ACPI it was Linux.

Alex
