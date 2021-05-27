Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB83924C1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 May 2021 04:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhE0CVw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 22:21:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:18360 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232381AbhE0CVw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 May 2021 22:21:52 -0400
IronPort-SDR: dVw/L/rwZQqLf3tdHwF67NFLm0T16uOCnOATzDDqAgVUglFAT1cbcADEeh8/aFDzVlphHRFAh9
 grVcPpGzrifA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202393990"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202393990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 19:20:19 -0700
IronPort-SDR: X5tiL5bGbeMSUCGwUzj1NUtL3LRhKOW0imPkCZWEere0YkfhPBcvR1C371yd66lw7ZZsPESvaH
 gD+fCBxUTNmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="480359159"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2021 19:20:19 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.174])
        by linux.intel.com (Postfix) with ESMTP id 729D5580514;
        Wed, 26 May 2021 19:20:19 -0700 (PDT)
Message-ID: <e0e8825cfc564a4b4bb9858b0d02f5d710cbe101.camel@linux.intel.com>
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable
 property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Raul Rangel <rrangel@chromium.org>, michael.a.bottini@intel.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, dan.j.williams@intel.com,
        shyjumon.n@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Date:   Wed, 26 May 2021 19:20:19 -0700
In-Reply-To: <CALRirFRy9ijyc2Du+z3589WtPD3xaOXeMHVdgUWSTDij-gq0=g@mail.gmail.com>
References: <CALRirFRy9ijyc2Du+z3589WtPD3xaOXeMHVdgUWSTDij-gq0=g@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Raul,

On Wed, 2021-05-26 at 11:53 -0600, Raul Rangel wrote:
> On Thu, Jul 09, 2020 at 11:43:33AM -0700, David E. Box wrote:
> > +#ifdef CONFIG_ACPI
> > +static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> > +{
> > +     const struct fwnode_handle *fwnode;
> > +     struct acpi_device *adev;
> > +     struct pci_dev *root;
> > +     acpi_handle handle;
> > +     acpi_status status;
> > +     u8 val;
> > +
> > +     /*
> > +      * Look for _DSD property specifying that the storage device
> > on
> > +      * the port must use D3 to support deep platform power
> > savings during
> > +      * suspend-to-idle
> > +      */
> > +     root = pcie_find_root_port(dev);
> > +     if (!root)
> > +             return false;
> > +
> > +     adev = ACPI_COMPANION(&root->dev);
> > +     if (!adev)
> > +             return false;
> > +
> > +     /*
> > +      * The property is defined in the PXSX device for South
> > complex ports
> > +      * and in the PEGP device for North complex ports.
> > +      */
> > +     status = acpi_get_handle(adev->handle, "PXSX", &handle);
> So I'm curious why we need to directly look at the PXSX and PEGP
> devices instead of the ACPI_COMPANION node attached to the pci
> device?
> 
> I've looked around and I can't find any documentation that defines
> the PXSX and PEGP device names.
> 
> I've dumped some ACPI from a system that uses the PXSX name and
> StorageD3Cold attribute:
> 
>     Scope (\_SB.PCI0.GP14)
>     {
>         Device (PXSX)
>         {
>             Name (_ADR, 0x0000000000000000)  // _ADR: Address
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }
> 
>             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("5025030f-842f-4ab4-a561-99a5189762d0"),
>                 Package (0x01)
>                 {
>                     Package (0x02)
>                     {
>                         "StorageD3Enable",
>                         One
>                     }
>                 }
>             })
>         }
>     }
> 
> It looks to me like it's just the firmware node for the NVMe device
> attached to the root port. Is that the correct assumption?
> 
> I'm wondering if we can simplify the look up logic to look at the
> ACPI_COMPANION of the pci device?

I believe so, but I'd need to confirm on our systems that it will work.
I recall trying to use the companion device and not being able to
locate the _DSD. But that was on a preproduction platform at the time.

> 
> The reason I ask is that I'm working on enabling S0i3 on an AMD
> device.
> This device also defines the StorageD3Enable property, but it don't
> use
> the PXSX name:
> 
>     Scope (GPP6) {
>         Device (NVME)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
> 
>             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("5025030f-842f-4ab4-a561-99a5189762d0"),
>                 Package (0x01)
>                 {
>                     Package (0x02)
>                     {
>                         "StorageD3Enable",
>                         One
>                     }
>                 }
>             })
>         }
>     }
> 
> The Windows
> [documentation]( 
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro#d3-support
> )
> makes it sound like the _DSD should be defined on the PCI device.
> 
> I can send one of the following patches depending on the feedback:
> 1) Additionally check the pci device's ACPI_COMPANION for the _DSD.
> 2) Delete the PXSX and PEGP lookups and only look at the pci device's
>    ACPI_COMPANION.
> 
> > +     if (ACPI_FAILURE(status)) {
> > +             status = acpi_get_handle(adev->handle, "PEGP",
> > &handle);
> > +             if (ACPI_FAILURE(status))
> > +                     return false;
> > +     }
> > +
> > +     if (acpi_bus_get_device(handle, &adev))
> > +             return false;
> > +
> > +     fwnode = acpi_fwnode_handle(adev);
> > +
> > +     return fwnode_property_read_u8(fwnode, "StorageD3Enable",
> > &val) ?
> > +             false : val == 1;
> > +}

Go for 2 first. I will check on those systems again with our latest
BIOS to ensure it works.

David

> 
> Thanks,
> Raul


