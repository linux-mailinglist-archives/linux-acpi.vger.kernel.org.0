Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FDF307642
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhA1MkN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 28 Jan 2021 07:40:13 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35111 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhA1MkL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 07:40:11 -0500
Received: by mail-oi1-f180.google.com with SMTP id w8so5849677oie.2
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jan 2021 04:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lQErjhPkqTw8CRCzdodac9Xydu6fs/HgHxwFdSO3950=;
        b=Jz9rqXQx+tmnek5vy2l5yJkd8TmAjYzF/Xff29fCB7wnU3zrNlR6DJxZUHD/oMHWgO
         4Kibl1MzaZbQGBf/GrioMtP+/P++I04ff2wy/kj5PMuoy8ZdRXgnhKrmde+szRsavhrw
         RjOlgYsNd4kNAYTfjQpC8hHJ1WJqfxXr59XIlf350FpAwH+83v34Q33IxStOlPu5P6Bi
         1L+EsiuKOluumwJGFTdMUZltRHbKfaMkeJPztHzGOsKl/D6Bdu7yDlMerOxUrtGDFBw5
         +z3aExC0VpzFBEMJkbtqoAHf43KKWsvsh4DE7ZJTr86FStGKEI0UQ8DxuElvex21k/UF
         UoZw==
X-Gm-Message-State: AOAM530HzKVKmA8XUE2HRxPswGOSAcNxnbIfdP1OKo/qcQFO/4LH2UAN
        +A7YSWxWUWaT2cs/R2aotu4b1oZOeW4O6Xfnm9eIbInJWz9YpQ==
X-Google-Smtp-Source: ABdhPJwO5DBZGJxD7QE/KqAG6r4f21DlomRXLWO3+62rgqV4ZO1wx5wC+f7bc0kG2uPkcd/bxQju657sMoOWUiHQ1cU=
X-Received: by 2002:aca:308a:: with SMTP id w132mr6121105oiw.69.1611837570696;
 Thu, 28 Jan 2021 04:39:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Jan 2021 13:39:19 +0100
Message-ID: <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 28, 2021 at 1:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 27, 2021 at 8:19 PM Marcin Ślusarz <marcin.slusarz@gmail.com> wrote:
> >
> > śr., 27 sty 2021 o 18:28 Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> napisał(a):
> > > > Weird, I can't reproduce this problem with my self-compiled kernel :/
> > > > I don't even see soundwire modules loaded in. Manually loading them of course
> > > > doesn't do much.
> > > >
> > > > Previously I could boot into the "faulty" kernel by using "recovery mode", but
> > > > I can't do that anymore - it crashes too.
> > > >
> > > > Maybe there's some kind of race and this bug depends on some specific
> > > > ordering of events?
> > >
> > > missing Kconfig?
> > > You need CONFIG_SOUNDWIRE and CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE
> > > selected to enter this sdw_intel_acpi_scan() routine.
> >
> > It was a PEBKAC, but a slightly different one. I won't bore you with
> > (embarrassing) details ;).
> >
> > I reproduced the problem, tested both your and Rafael's patches
> > and the kernel still crashes, with the same stack trace.
> > (Yes, I'm sure I booted the right kernel :)
> >
> > Why "recovery mode" stopped working (or worked previously) is still a mystery.
>
> So for clarity, you've tried this:
>
> static int snd_intel_dsp_check_soundwire(struct pci_dev *pci)
> {
>     struct sdw_intel_acpi_info info;
>     acpi_handle handle;
>     int ret;
>
>     handle = ACPI_HANDLE(&pci->dev);
>     if (!handle)
>         return -ENODEV;
>
> and it has not made a difference?
>
> And the relevant part of the trace is:
>
> RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
> Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00
> 48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f
> 08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
> RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
> RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
> RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
> R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
> FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
> PKRU: 55555554
> Call Trace:
>  acpi_get_data_full+0x4d/0x92
>  acpi_bus_get_device+0x1f/0x40
>  sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
>  ? strstr+0x22/0x60
>  ? dmi_matches+0x76/0xe0
>  snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
>  azx_probe+0x7a/0x970 [snd_hda_intel]
>  local_pci_probe+0x42/0x80
>  ? _cond_resched+0x16/0x40
>  pci_device_probe+0xfd/0x1b0
>
> so it looks like we got to sdw_intel_acpi_scan() with a non-NULL, but
> otherwise invalid parent_handle which then was passed to
> acpi_bus_get_device().  Subsequently it got to acpi_get_data_full()
> and acpi_ns_validate_handle() that crashed, because it tried to
> dereference it via ACPI_GET_DESCRIPTOR_TYPE().

But interestingly enough, sdw_intel_acpi_cb() calls
acpi_evaluate_integer() on the same handle that is passed to
acpi_bus_get_device() later and it also calls
acpi_ns_validate_handle() on that handle which doesn't crash.

Moreover, it asks _ADR to be evaluated with respect to that handle and
because it gets to the acpi_bus_get_device() call at all, this appears
to have been successful.

The only explanation for that I can think about (and which does not
involve supernatural intervention so to speak) is a stack corruption
occurring between these two calls in sdw_intel_acpi_cb().  IOW,
something scribbles on the handle in the meantime, but ATM I have no
idea what that can be.

Marcin, please boot with ACPICA deubg (level = ACPI_LV_INFO and
component = ACPI_NAMESPACE | ACPI_BUS_COMPONENT) enabled (see
Documentation/firmware-guide/acpi/debug.rst for instructions) and
collect the log.
