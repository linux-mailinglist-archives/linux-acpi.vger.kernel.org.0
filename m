Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1637905F
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhEJOMw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 10:12:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:10136 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhEJOKv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 10:10:51 -0400
IronPort-SDR: kYNFAjg4gnCARMVKlJ76rgY+T62B1JBwGVvBvbfLqMhzCrTbNR+rCutVm6fKszn1xjS67Rx7mE
 mpRlvOz2dvoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186336215"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="186336215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:59:10 -0700
IronPort-SDR: Qy/oHL1TVOSlrsImmiNyCrMpER4rTXwU0Pno6idTgppirj9JU+/P1Jsnee9iJFAVaqPjh45wbP
 Q6huqACZHsnQ==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="436153200"
Received: from chuquanc-mobl1.ccr.corp.intel.com ([10.255.30.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:59:05 -0700
Message-ID: <bd4d1d94a4497a4c7407ede70eeae566ac343f23.camel@intel.com>
Subject: Re: [PATCH] Revert "ACPI: power: Turn off unused power resources
 unconditionally"
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shujun Wang <wsj20369@163.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Date:   Mon, 10 May 2021 21:59:03 +0800
In-Reply-To: <CAJZ5v0i8RnOg2HgEmLze7d3rYvofVDFDQORMOigNc0vEhLW16Q@mail.gmail.com>
References: <20210430124224.6383-1-wsj20369@163.com>
         <0e480ceabe4d42d79bf49a1989c0f95f@intel.com>
         <CAJZ5v0i8RnOg2HgEmLze7d3rYvofVDFDQORMOigNc0vEhLW16Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-05-10 at 14:13 +0200, Rafael J. Wysocki wrote:
> On Mon, May 10, 2021 at 8:37 AM Zhang, Rui <rui.zhang@intel.com>
> wrote:
> > 
> > Hi, Shujun,
> > 
> > I'm experiencing similar problem, and it should be a BIOS problem,
> 
> Right, and I confused things.  Sorry about that.
> 
> If commit 7e4fdeafa61f2b653f ("ACPI: power: Turn off unused power
> resources unconditionally") causes problems to happen, this means
> that
> the platform firmware implementation doesn't follow the ACPI
> specification.
> 
> > which can be fixed by a customized DSDT.
> > Can you please attach the full acpidump output on this machine? I
> > just want to make sure if it is the same problem.
> 
> Yes, please.
> 
> Rui, can you create a BZ for this please and can you both attach
> dmidecode output from the affected systems?
> 
> I don't want to revert this commit completely, so the default
> behavior
> is spec-compliant, but there can be a DMI-based blacklist for systems
> having problems with it.
> 
Done.
https://bugzilla.kernel.org/show_bug.cgi?id=213019

Shujun,
can you please attach the acpidump and dmidecode output in this bug
report?

thanks,
rui

> > > -----Original Message-----
> > > From: Shujun Wang <wsj20369@163.com>
> > > Sent: Friday, April 30, 2021 8:42 PM
> > > To: rjw@rjwysocki.net; lenb@kernel.org; 
> > > linux-acpi@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Cc: Shujun Wang <wsj20369@163.com>
> > > Subject: [PATCH] Revert "ACPI: power: Turn off unused power
> > > resources
> > > unconditionally"
> > > 
> > > This reverts commit 7e4fdeafa61f2b653fcf9678f09935e55756aed2.
> > > It may cause some NVMe device probes to fail, and the system may
> > > get stuck
> > > when using an NVMe device as the root filesystem.
> > > 
> > > In the function nvme_pci_enable(struct nvme_dev *dev), as shown
> > > below,
> > > readl(NVME_REG_CSTS) always returns -1 with the commit, which
> > > results in
> > > the probe failed.
> > > 
> > >   if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> > >       result = -ENODEV;
> > >       goto disable;
> > >   }
> > > 
> > > dmesg:
> > >   [    1.106280] nvme 0000:04:00.0: platform quirk: setting
> > > simple suspend
> > >   [    1.109111] nvme nvme0: pci function 0000:04:00.0
> > >   [    1.113066] nvme 0000:04:00.0: enabling device (0000 ->
> > > 0002)
> > >   [    1.121040] nvme nvme0: Removing after probe failure status:
> > > -19
> > > 
> > > lspci:
> > >   Non-Volatile memory controller: KIOXIA Corporation Device 0001
> > > 
> > > device uevent:
> > >   DRIVER=nvme
> > >   PCI_CLASS=10802
> > >   PCI_ID=1E0F:0001
> > >   PCI_SUBSYS_ID=1E0F:0001
> > >   PCI_SLOT_NAME=0000:04:00.0
> > >   MODALIAS=pci:v00001E0Fd00000001sv00001E0Fsd00000001bc01sc08i02
> > > 
> > > This patch was tested in Lenovo Thinkpad X1.
> > > 
> > > Signed-off-by: Shujun Wang <wsj20369@163.com>
> > > ---
> > >  drivers/acpi/power.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c index
> > > 56102eaaa2da..8bf10abeb2e0 100644
> > > --- a/drivers/acpi/power.c
> > > +++ b/drivers/acpi/power.c
> > > @@ -1004,9 +1004,18 @@ void
> > > acpi_turn_off_unused_power_resources(void)
> > >       mutex_lock(&power_resource_list_lock);
> > > 
> > >       list_for_each_entry_reverse(resource,
> > > &acpi_power_resource_list,
> > > list_node) {
> > > +             int result, state;
> > > +
> > >               mutex_lock(&resource->resource_lock);
> > > 
> > > -             if (!resource->ref_count) {
> > > +             result = acpi_power_get_state(resource-
> > > >device.handle,
> > > &state);
> > > +             if (result) {
> > > +                     mutex_unlock(&resource->resource_lock);
> > > +                     continue;
> > > +             }
> > > +
> > > +             if (state == ACPI_POWER_RESOURCE_STATE_ON
> > > +                 && !resource->ref_count) {
> > >                       dev_info(&resource->device.dev, "Turning
> > > OFF\n");
> > >                       __acpi_power_off(resource);
> > >               }
> > > --
> > > 2.25.1

