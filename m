Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5F217A34
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 23:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgGGVYe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 17:24:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:25844 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGVYd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Jul 2020 17:24:33 -0400
IronPort-SDR: iDD+kPed5ojICKj0nHWqbLxBvtsS/pZqzHF+kp9i2l0/o8HlNYv7bZ+Rb5R3ZZzwaiAw/vvgNu
 bC+amjnFA9iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147705274"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="147705274"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 14:24:32 -0700
IronPort-SDR: Qkmn4wSntn37RbEtWnsNsY6QDV+ZNtUJJ3Wg94H9QgCsFTy1T0uotSF9/siKuUkKAK2apt4DUF
 sb3LTU32mAdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="483202700"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2020 14:24:31 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id DAF5E5807C8;
        Tue,  7 Jul 2020 14:24:31 -0700 (PDT)
Message-ID: <1c75a6ba5d0b84dd868e350674f8565fa9154147.camel@linux.intel.com>
Subject: Re: [PATCH v4] drivers/nvme: Add support for ACPI StorageD3Enable
 property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     shyjumon.n@intel.com, Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Date:   Tue, 07 Jul 2020 14:24:31 -0700
In-Reply-To: <CAJZ5v0hC5OZQ+SpP4Pp99OvMjQCQ8M6_bkfMd_8nnuNNSh9q0w@mail.gmail.com>
References: <20200612204820.20111-1-david.e.box@linux.intel.com>
         <20200702225011.10932-1-david.e.box@linux.intel.com>
         <CAJZ5v0hC5OZQ+SpP4Pp99OvMjQCQ8M6_bkfMd_8nnuNNSh9q0w@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-07-06 at 16:57 +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 3, 2020 at 12:49 AM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > This patch implements a solution for a BIOS hack used on some
> > currently
> > shipping Intel systems to change driver power management policy for
> > PCIe
> > NVMe drives. Some newer Intel platforms, like some Comet Lake
> > systems,
> > require that PCIe devices use D3 when doing suspend-to-idle in
> > order to
> > allow the platform to realize maximum power savings. This is
> > particularly
> > needed to support ATX power supply shutdown on desktop systems. In
> > order to
> > ensure this happens for root ports with storage devices, Microsoft
> > apparently created this ACPI _DSD property as a way to influence
> > their
> > driver policy. To my knowledge this property has not been discussed
> > with
> > the NVME specification body.
> > 
> > Though the solution is not ideal, it addresses a problem that also
> > affects
> > Linux since the NVMe driver's default policy of using NVMe APST
> > during
> > suspend-to-idle prevents the PCI root port from going to D3 and
> > leads to
> > higher power consumption for these platforms. The power consumption
> > difference may be negligible on laptop systems, but many watts on
> > desktop
> > systems when the ATX power supply is blocked from powering down.
> > 
> > The patch creates a new nvme_acpi_storage_d3 function to check for
> > the
> > StorageD3Enable property during probe and enables D3 as a quirk if
> > set.  It
> > also provides a 'noacpi' module parameter to allow skipping the
> > quirk if
> > needed.
> > 
> > Tested on:
> > PM961 NVMe SED Samsung 512GB
> > INTEL SSDPEKKF512G8
> > 
> > Link: 
> > https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > Changes from V3:
> >         - Use pcie_find_root_port() instead of
> > pci_find_pcie_root_port(),
> >           changed in 5.8.
> >         - Remove "Cc:" emails that ended up at top of V3 commit
> > message.
> >         - Fix changelog numbering.
> > 
> > Changes from V2:
> >         - Remove check for "not yet bound" ACPI companion device
> > since
> >           this will not be a concern at driver probe time per
> > Rafael.
> >         - Move storage_d3 function out of PCI core and into NVMe
> > driver
> >           since there's nothing the PCI core can do with this code
> > as
> >           noted by Bjorn.
> > 
> > Changes from V1:
> >         - Export the pci_acpi_storage_d3 function for use by
> > drivers as
> >           needed instead of modifying the pci header.
> >         - Add missing put on acpi device handle.
> >         - Add 'noacpi' module parameter to allow undoing this
> > change.
> >         - Add info message that this is a platform quirk.
> > 
> >  drivers/acpi/property.c |  3 +++
> >  drivers/nvme/host/pci.c | 55
> > +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index e601c4511a8b..c2e2ae774a19 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
> >         /* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-
> > ba72-9bf5a26ebe5d */
> >         GUID_INIT(0x6c501103, 0xc189, 0x4296,
> >                   0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> > +       /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-
> > 99a5189762d0 */
> > +       GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> > +                 0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> >  };
> > 
> >  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-
> > 1319f52a966b */
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index e2bacd369a88..a3d3a82b0437 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (c) 2011-2014, Intel Corporation.
> >   */
> > 
> > +#include <linux/acpi.h>
> >  #include <linux/aer.h>
> >  #include <linux/async.h>
> >  #include <linux/blkdev.h>
> > @@ -94,6 +95,10 @@ static unsigned int poll_queues;
> >  module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues,
> > 0644);
> >  MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled
> > IO.");
> > 
> > +static bool noacpi;
> > +module_param(noacpi, bool, 0444);
> > +MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
> > +
> >  struct nvme_dev;
> >  struct nvme_queue;
> > 
> > @@ -2757,6 +2762,46 @@ static unsigned long
> > check_vendor_combination_bug(struct pci_dev *pdev)
> >         return 0;
> >  }
> > 
> > +static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> > +{
> > +       const struct fwnode_handle *fwnode;
> > +       struct acpi_device *adev;
> > +       struct pci_dev *root;
> > +       acpi_handle handle;
> > +       acpi_status status;
> > +       bool ret = false;
> > +       u8 val;
> > +
> > +       /*
> > +        * Look for _DSD property specifying that the storage
> > device on
> > +        * the port must use D3 to support deep platform power
> > savings during
> > +        * suspend-to-idle
> > +        */
> > +       root = pcie_find_root_port(dev);
> > +       if (!root)
> > +               return false;
> > +
> > +       adev = ACPI_COMPANION(&root->dev);
> > +       if (!adev)
> > +               return false;
> > +
> > +       status = acpi_get_handle(adev->handle, "PXSX", &handle);
> > +       if (ACPI_FAILURE(status))
> > +               return false;
> > +
> > +       adev = acpi_bus_get_acpi_device(handle);
> 
> This function needs to be exported to modules for nvme to be able to
> use it when modular.

Missed that they weren't exported when I moved from pci-acpi to nvme as
it worked with my config. But looking again I see there's already an
acpi_bus_get_device() that's exported and should work here.
Unfortunately, it would be the only function that's not stubbed out so
per Cristoph's later comment, this will need a CONFIG_ACPI wrapper.

David

