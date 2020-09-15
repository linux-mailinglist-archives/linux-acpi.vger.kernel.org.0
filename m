Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BE26B36B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 01:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgIOXCi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 19:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgIOXCY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 19:02:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE370C061788
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 16:02:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so4241329ljg.9
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9scBHPNix+y6Pwr8cQyVX+xDYS3UrPPXINpHzBknN4=;
        b=ZVyYyQFG1iBiLFuKDDQuAPmiBZLpB11LhmJ8YIOtjnryLAEf3A4zUrMoifNnYRWJlf
         8GcDcZvPM6I43fh/hfWt5Ij4L0sml+BEcbwcrw9YG7Yv4MCF4a3iTKVN2+zx/6t1Ok/U
         EztiiWABfLBG0/pmN5Vl7Cj2fE6WIAdiGdue7cOiCXYCIRSnnNjhvCG039/GlTc80TRj
         aqwQ3MOyvtANK7SvVzqwtpY0bPLrbyc56t1ojaXcJdWtPVCALRtamlRtUIQUeZZ3HY8z
         BDvzFgB0IjGoamrNzKeAtkR8T1BKPA8B09P9hDpTiuNjtQyYdb12iJHIbtSbTSRWvjFY
         sX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9scBHPNix+y6Pwr8cQyVX+xDYS3UrPPXINpHzBknN4=;
        b=V0WNdUOhufoiYoJGYZCJuih0TJGqp4Pyo+H6HEOt3x2i6rYPpAqMJ5J6no0NSuQIwR
         5iOfi0cKRb2hJtEF+LcaH0LYDmKNL0GLY+NUHlqt1Eqm9dxEQtAH0+3ehe0SEdvWA5Qz
         DO3Tg8JLHoikBVd4gIT/lOi8bAAWjtqxh2Pe5b6hLyTfPS5/KL9qEV4OdDFHCw17JyCt
         nb1Urior46JmtlF1iwCxzlbG/LyDZEh/RlRxA7DofU3B6eMNgs4v5fXdC9LQ0787oGBU
         KQ+JePZqE23008uG7MCJsQ5DgaSvVwf859zuuwmw+F6B3yjPb9xHl+rBRYohyMnl/RPF
         IgLg==
X-Gm-Message-State: AOAM532ODpowsWj3mL3aBCGGBGyXuGS5PETZPtsQcROa4MVJ/Oy788gS
        6WWhrcMBWEirWCbA8qJTpU6Ld7oP7sVbun34v2v1UQ==
X-Google-Smtp-Source: ABdhPJysOqFs8iJIdAa5maQ13XMna1CrI/NRUUz9V4/qRiA3nA6/D4LifyuPbfI1VmRc64fhlM/srS8bqKradXWp+OM=
X-Received: by 2002:a2e:9992:: with SMTP id w18mr7963973lji.301.1600210941914;
 Tue, 15 Sep 2020 16:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
 <20200711195346.GA132330@bjorn-Precision-5520> <CACK8Z6HP1VHs4P=U6-+D_D8HrQ5D1P679P_=saNqUMXE-bNUjg@mail.gmail.com>
In-Reply-To: <CACK8Z6HP1VHs4P=U6-+D_D8HrQ5D1P679P_=saNqUMXE-bNUjg@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 15 Sep 2020 16:01:45 -0700
Message-ID: <CACK8Z6FgCZR+PrW88myVsy=ZEq-rCD=s7xV5tDGOM437=1apMA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Bjorn,


On Tue, Jul 14, 2020 at 1:19 PM Rajat Jain <rajatja@google.com> wrote:
>
> On Sat, Jul 11, 2020 at 12:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Jul 10, 2020 at 03:53:59PM -0700, Rajat Jain wrote:
> > > On Fri, Jul 10, 2020 at 2:29 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > > On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > > > > > When enabling ACS, enable translation blocking for external facing ports
> > > > > > and untrusted devices.
> > > > > >
> > > > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > > > ---
> > > > > > v4: Add braces to avoid warning from kernel robot
> > > > > >     print warning for only external-facing devices.
> > > > > > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> > > > > >     Minor code comments fixes.
> > > > > > v2: Commit log change
> > > > > >
> > > > > >  drivers/pci/pci.c    |  8 ++++++++
> > > > > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > > > > >  2 files changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 73a8627822140..a5a6bea7af7ce 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> > > > > >     /* Upstream Forwarding */
> > > > > >     ctrl |= (cap & PCI_ACS_UF);
> > > > > >
> > > > > > +   /* Enable Translation Blocking for external devices */
> > > > > > +   if (dev->external_facing || dev->untrusted) {
> > > > > > +           if (cap & PCI_ACS_TB)
> > > > > > +                   ctrl |= PCI_ACS_TB;
> > > > > > +           else if (dev->external_facing)
> > > > > > +                   pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > > > > > +   }
> > > > >
> > > > > IIUC, this means that external devices can *never* use ATS and
> > > > > can never cache translations.
> > >
> > > Yes, but it already exists today (and this patch doesn't change that):
> > > 521376741b2c2 "PCI/ATS: Only enable ATS for trusted devices"
> > >
> > > IMHO any external device trying to send ATS traffic despite having ATS
> > > disabled should count as a bad intent. And this patch is trying to
> > > plug that loophole, by blocking the AT traffic from devices that we do
> > > not expect to see AT from anyway.
> >
> > Thinking about this some more, I wonder if Linux should:
> >
> >   - Explicitly disable ATS for every device at enumeration-time, e.g.,
> >     in pci_init_capabilities(),
> >
> >   - Enable PCI_ACS_TB for every device (not just external-facing or
> >     untrusted ones),
> >
> >   - Disable PCI_ACS_TB for the relevant devices along the path only
> >     when enabling ATS.
> >
> > One nice thing about doing that is that the "untrusted" test would be
> > only in pci_enable_ats(), and we wouldn't need one in
> > pci_std_enable_acs().
>
> Sent out v5 with this approach here:
> https://patchwork.kernel.org/patch/11663515/

Any feedback on the patch above? It has been waiting for feedback....

Thanks & Best Regards,,

Rajat


>
> Thanks,
>
> Rajat
>
> >
> >
> > It's possible BIOS gives us devices with ATS enabled, and this might
> > break them, but that seems like something we'd want to find out about.
> >
> > Bjorn
