Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23898DEE6E
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 15:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfJUNyW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 09:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfJUNyW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Oct 2019 09:54:22 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F31D2C0495A3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2019 13:54:21 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id h10so14158336qtq.11
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2019 06:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2G1xusxf4dns3pndHNTvCsxrH/ysqq3dgJVBnbwKIs=;
        b=CfLwi8/RkjiqDpg5Cj4PzAdymUo4v9EDLipEsB2HZ90U9tno/ein7yIRNLdu5+3yHL
         J09Q3izE64PAociFhnEjzWws9/DWv0KmM8VeG20mzT5zY8cD577yZ4JxCsjnM2NVypJe
         9/NbFrvMwSQY/5Lx0kfggnM3gN+5HnPDMiBVJbx/8oM0o4Cmma5I6B2FQ9TpdXj5RQNy
         agUdMveKPiQMI88+3kFwc5I3FHz9i0uYDjgyjcl/gpx9HzlcDI504vQgf02M2DZraMdy
         AOgZy7csaWwjwpXMxOjcKYEeugKKoBR/BLNLcTtWiqm7CDxdrba+iFfbMLsbNhItn/ut
         PGIA==
X-Gm-Message-State: APjAAAVUVFlIQWeRUIe614+y0/RMbSzsISI2qBpcRAzBI/rtmJcV04We
        fASGaHAMYk1Q3AtPT3I3TxAM58O2RUP4Imv6gzCiAgQbvhpVv3Y2yR/S7+PQPRUTx3z8XBCUjrp
        V6cHhupIR9VhMYOs0Wn+9uwMJMu5yr+yrw6gqrg==
X-Received: by 2002:ac8:664b:: with SMTP id j11mr24827246qtp.137.1571666061242;
        Mon, 21 Oct 2019 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkFGgGdHL5wN4wh/Zt1E39qBLM+0KoKUb4VD7Jy4sRN04D/L8vg7pR474/ZE01oLpPOfhqewZ/sebaQYyV838=
X-Received: by 2002:ac8:664b:: with SMTP id j11mr24827222qtp.137.1571666060943;
 Mon, 21 Oct 2019 06:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com> <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com>
In-Reply-To: <20191021133328.GI2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 15:54:09 +0200
Message-ID: <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 21, 2019 at 3:33 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Oct 16, 2019 at 11:48:22PM +0200, Karol Herbst wrote:
> > On Wed, Oct 16, 2019 at 11:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc linux-acpi]
> > >
> > > On Wed, Oct 16, 2019 at 09:18:32PM +0200, Karol Herbst wrote:
> > > > but setting the PCI_DEV_FLAGS_NO_D3 flag does prevent using the
> > > > platform means of putting the device into D3cold, right? That's
> > > > actually what should still happen, just the D3hot step should be
> > > > skipped.
> > >
> > > If I understand correctly, when we put a device in D3cold on an ACPI
> > > system, we do something like this:
> > >
> > >   pci_set_power_state(D3cold)
> > >     if (PCI_DEV_FLAGS_NO_D3)
> > >       return 0                                   <-- nothing at all if quirked
> > >     pci_raw_set_power_state
> > >       pci_write_config_word(PCI_PM_CTRL, D3hot)  <-- set to D3hot
> > >     __pci_complete_power_transition(D3cold)
> > >       pci_platform_power_transition(D3cold)
> > >         platform_pci_set_power_state(D3cold)
> > >           acpi_pci_set_power_state(D3cold)
> > >             acpi_device_set_power(ACPI_STATE_D3_COLD)
> > >               ...
> > >                 acpi_evaluate_object("_OFF")     <-- set to D3cold
> > >
> > > I did not understand the connection with platform (ACPI) power
> > > management from your patch.  It sounds like you want this entire path
> > > except that you want to skip the PCI_PM_CTRL write?
> > >
> >
> > exactly. I am running with this workaround for a while now and never
> > had any fails with it anymore. The GPU gets turned off correctly and I
> > see the same power savings, just that the GPU can be powered on again.
> >
> > > That seems like something Rafael should weigh in on.  I don't know
> > > why we set the device to D3hot with PCI_PM_CTRL before using the ACPI
> > > methods, and I don't know what the effect of skipping that is.  It
> > > seems a little messy to slice out this tiny piece from the middle, but
> > > maybe it makes sense.
> > >
> >
> > afaik when I was talking with others in the past about it, Windows is
> > doing that before using ACPI calls, but maybe they have some similar
> > workarounds for certain intel bridges as well? I am sure it affects
> > more than the one I am blacklisting here, but I rather want to check
> > each device before blacklisting all kabylake and sky lake bridges (as
> > those are the ones were this issue can be observed).
> >
> > Sadly we had no luck getting any information about such workaround out
> > of Nvidia or Intel.
>
> I really would like to provide you more information about such
> workaround but I'm not aware of any ;-) I have not seen any issues like
> this when D3cold is properly implemented in the platform.  That's why
> I'm bit skeptical that this has anything to do with specific Intel PCIe
> ports. More likely it is some power sequence in the _ON/_OFF() methods
> that is run differently on Windows.

yeah.. maybe. I really don't know what's the actual root cause. I just
know that with this workaround it works perfectly fine on my and some
other systems it was tested on. Do you know who would be best to
approach to get proper documentation about those methods and what are
the actual prerequisites of those methods?

We kind of tried with Nvidia, but maybe having a more specific
question would help here... I will try to bring that issue up the next
time with them.
