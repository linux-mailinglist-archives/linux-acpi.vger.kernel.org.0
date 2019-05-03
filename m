Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39C113632
	for <lists+linux-acpi@lfdr.de>; Sat,  4 May 2019 01:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfECXfR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 May 2019 19:35:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37287 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECXfQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 May 2019 19:35:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id 143so5712737oii.4
        for <linux-acpi@vger.kernel.org>; Fri, 03 May 2019 16:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLniKeyCZOpahcUdSYJAe+ot7SuFR+G7B9LsqPznig0=;
        b=HDskn1YS7k1QYZ+dsJLnQNeCPcK16/2pTj9ez8EsQ+gInQ3GZ0BR0iMYwxt27t5Q08
         hqpBaeBjwOKtVQgCsUJvamW67feFI3qlTGT1KcmHb1GNFq6dCzpwgWTQP/JzQUPCoh2n
         gh9O0YLeaKKrsmhKadRh0K76x6bY8P9sjfUVyINU6ITXamAF6EGiGsKDgBzi64vXN4ct
         bI3LFVghfyoCDK7Dz4t2VyfzUyc9GObLwk+M40fnSIHaNJsKpyVb0A/uTNBX6Qn6G0yU
         J5rd391xjjIx53CQ+uUMu0rkwlGPR4eJbG8SVKyh/iDNDWmPx94d8aD8Aa44bL92YFsJ
         CikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLniKeyCZOpahcUdSYJAe+ot7SuFR+G7B9LsqPznig0=;
        b=XOSbMDPvlLiL+x0yiC7ldlS53tw3VqdFWyyWlyTiBaexxrLpxm51oUE1ybKnZnpdbn
         U6hofHnZWZ93dGvKEaNZQqgs6xtDQdxp2o1KVdvapuGV99BlzNqc5J0rXGa07RbJQqg8
         SeosWhyzZlav8OXnwC9aYWLodBn38EgbKNKHHUzRQo5yQm0493odAN4H4JWXx+nOKvCA
         YRdb3WjBbQd23VDPqHIsA9DgrOAEE9ZF3a92dU26TZu7BRGR/VFYmF61sVSCSmZVt3lT
         SwXWeYc6/aiQ85efHv0/44E6Zwni0XwguLthYwDxXgG+Jeuxy6tA06kBtjo2HvB3RfJP
         BNVA==
X-Gm-Message-State: APjAAAXfmYX4osJq0ZxM0nsG6xNlaDxAUmY0UlCLYgk1NCv0ctDlQjF5
        L3Y2pNdh++V2xfkurCF0K0FUtBuIdkKyigasbyoGPw==
X-Google-Smtp-Source: APXvYqy2Lu0/rrQmCa8ADPuIDsyZVIbwSsApFiDq4fylfiz6mfnP/sccRR8UgWJBV8TXH5UUr/Z/vBw+6dAjjeorUoo=
X-Received: by 2002:aca:4f10:: with SMTP id d16mr875911oib.17.1556926515368;
 Fri, 03 May 2019 16:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <s5hsgu0ihyg.wl-tiwai@suse.de> <EksOpJxc6GB@mike.franken.de>
 <20190430090021.GF26516@lahna.fi.intel.com> <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
 <20190502114839.GC24696@kroah.com>
In-Reply-To: <20190502114839.GC24696@kroah.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Fri, 3 May 2019 16:35:02 -0700
Message-ID: <CAEGmHFFGpUmK1VitkUxqXL29dBrKwbceT0pEOeR_7+_4+eLzvA@mail.gmail.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and thunderbolt)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>, mh@mike.franken.de,
        Lukas Wunner <lukas@wunner.de>, Takashi Iwai <tiwai@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, ckellner@redhat.com,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 2, 2019 at 4:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 30, 2019 at 11:37:48AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 30, 2019 at 11:00 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > +Rafael, Furquan and linux-acpi
> > >
> > > (The original thread is here https://lore.kernel.org/lkml/s5hy33siofw.wl-tiwai@suse.de/T/#u)
> > >
> > > On Tue, Apr 30, 2019 at 10:39:00AM +0200, Michael Hirmke wrote:
> > > > Hi Takashi,
> > > >
> > > > [...]
> > > > >>> I also have XPS 9370 but not that particular dock. I will check tomorrow
> > > > >>> if I can reproduce it as well.
> > > > >>
> > > > >> There aren't too many changes between 5.0.7 and 5.0.8 that touch
> > > > >> PCI/ACPI. This is just a shot in the dark but could you try to revert:
> > > > >>
> > > > >>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi
> > > > >>   t/commit/?h=linux-5.0.y&id=da6a87fb0ad43ae811519d2e0aa325c7f792b13a
> > > > >>
> > > > >> and see if it makes any difference?
> > > >
> > > > >OK, I'm building a test kernel package with the revert in OBS
> > > > >home:tiwai:bsc1133486 repo.  A new kernel will be
> > > > >kernel-default-5.0.10-*g8edeab8:
> > > > >  http://download.opensuse.org/repositories/home:/tiwai:/bsc1133486/standard/
> > > >
> > > > >Michael, once when the new kernel is ready, please give it a try.
> > > >
> > > > as far as I can see, state is back to normal with this kernel.
> > > > No more error messages or crashing modules and all devices seem to work
> > > > as expected.
> > > > Only thing is, that the external devices connected to the Thunderbolt
> > > > dock are coming up a little bit slower than with 5.0.7 - but this is
> > > > nothing, I'd worry about.
> > >
> > > Thanks for testing.
> > >
> > > Rafael, it seems that commit c8b1917c8987 ("ACPICA: Clear status of GPEs
> > > before enabling them") causes problem with Thunderbolt controllers if
> > > you boot with device (dock) connected.
> > >
> > > I think the reason is the same that got fixed in v4.14 with commit
> > > ecc1165b8b74 ("ACPICA: Dispatch active GPEs at init time") which the
> > > above commit essentially undoes if I understand it correctly.
> >
> > OK, I'll queue up a revert of that one then, thanks!
> >
> > Erik, I think that commit c8b1917c8987 has been picked up by the
> > upstream ACPICA already.  If I'm not mistaken, it needs to be reverted
> > from there as well.
>
> I've queued the revert up in the stable trees as it has hit Linus's tree
> now, and will push out a new round of stable kernels soon.
>
> thanks,
>
> greg k-h

Thanks for reporting the issue and apologize for the breakage. When I
pushed the patch, my understanding was that the device drivers do not
depend on stale GPE events to take any action.

I am curious to understand the behavior for the thunderbolt device
since I do not have one to test with. The failure seems to be a result
of either having a edge-triggered interrupt or a pulse interrupt which
indicates some kind of ready condition to the kernel driver. All the
runtime GPEs seem to be initialized as part of acpi_init before ACPI
bus is scanned. So, is this some special kind of requirement for
thunderbolt that requires GPE enabled before the device can actually
be probed. And so the GPEs going active before being enabled are then
used as a way to call into ACPI Method to enable something which is
essential for probing of device?

The other question I have is given that handling of GPE events that
were active before being enabled is required at least for some set of
devices (e.g. thunderbolt), what is a good way to solve the original
problem that was being addressed by the patch being reverted i.e.
stale events resulting in spurious wakes on wakeup GPEs. One way I can
think of is clearing the status of GPEs when they are setup for
wake(acpi_setup_gpe_for_wake). What do you think?
