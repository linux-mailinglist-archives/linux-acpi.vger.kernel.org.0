Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17722436FB6
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 04:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhJVCDq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Oct 2021 22:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJVCDp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Oct 2021 22:03:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C710C061764
        for <linux-acpi@vger.kernel.org>; Thu, 21 Oct 2021 19:01:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m14so2269046pfc.9
        for <linux-acpi@vger.kernel.org>; Thu, 21 Oct 2021 19:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdDiIElvnKPLA94/FK2yojxe1sqkknB8xpHw6h6W0Jg=;
        b=y91dDeL4MKGbK/ayIZcOYmPKJLfEo0i3L58yZ3mr2X1Ne7oOx4hs8nTEGZPu0+ITQY
         FN4Ulxw3k7tw93hz2JY4fd3D+IIdN243OFg6hJ7QXWE4ly38lKR7UIX6hJZs223wsXOO
         mVTiKLWf3iUO/2/n2X3Fyh0WCb6zjSW1hrYyJ2CcbOh7kAy/iS/v0IlpKXasGFu5Gjpc
         T2eGokWEaR5+9b7AxYHzv7RdW2dC5ZzXitja0njppjgRrlc29hjn/2aa7QB62rTiwxoD
         8vNyorHnuhHEt4DCiI7mjv3xkp+RmJrHVQ+ULm64TU+Zx6m4V5AJK1IZySYwdmjN96LC
         a4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdDiIElvnKPLA94/FK2yojxe1sqkknB8xpHw6h6W0Jg=;
        b=gKhcAHgSo5U5iVz5P24xdo0C9JHl9mWSx0dWycbu2oQLAiJs/x4eXzr5ciYH30wf16
         yPj5HXRHgWLW6YJH6QeyUf+mauy0+ffftFq8AatH/S3MJ0/ZsLyAWWcW0TrWDucDVXol
         UgZg8Ygy3nInV/NCYmGXA4BlnyNS3gcnQJA3Fl1woyJP89sXxQ53E9rRo+8cnT3KTcK2
         tkHGRCN7B/XGGgv70IUgk22xZEelAFeqiDfxFZfBILQszJjVcXW67pwmHujN1b26Y0xu
         kJi/NWP+ja7RrbPcFtldzeKo2luvqVnKsR9zssYRxzq1g+V4H8Vm0A7zDCbRc2qKTSW9
         FsUA==
X-Gm-Message-State: AOAM531fxhQh0XzGKLw3KGN7nEYBxfHn2CL+KYkGopspChb2+p+h0yW6
        qSMaS5ek4wZsqWCshYTvfHsA6Iz85JOZYHmj9VZWRQ==
X-Google-Smtp-Source: ABdhPJxvEl+CLUV6eLd6lpbW/zom5fl3VUE7+Tc6zTWSSZoDMxkvoehx+ToLGAurU3uLphIR1dE1QxUtP3tnff2A2lE=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr9237634pfu.61.1634868088718; Thu, 21
 Oct 2021 19:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211019050908.449231-1-alison.schofield@intel.com>
 <SN6PR12MB2653CF7BEF1DA0A97B029396BDBE9@SN6PR12MB2653.namprd12.prod.outlook.com>
 <20211021010023.GA457926@alison-desk> <SN6PR12MB265309099EDA5C3C1311C6B8BDBF9@SN6PR12MB2653.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB265309099EDA5C3C1311C6B8BDBF9@SN6PR12MB2653.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Oct 2021 19:01:17 -0700
Message-ID: <CAPcyv4itUbyi253=9zw7NvrQnUJzkM9ry3NwW9+ed5aSGgdOLQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 21, 2021 at 8:57 AM Vikram Sethi <vsethi@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alison Schofield <alison.schofield@intel.com>
> > Sent: Wednesday, October 20, 2021 8:00 PM
> > To: Vikram Sethi <vsethi@nvidia.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> > Vishal Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>;
> > Ben Widawsky <ben.widawsky@intel.com>; Dan Williams
> > <dan.j.williams@intel.com>; linux-cxl@vger.kernel.org; linux-
> > acpi@vger.kernel.org
> > Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each
> > CFMWS not in SRAT
> >
> snip
>
> > > >
> > > > Consumers can use phys_to_target_node() to discover the NUMA node.
> > >
> > > Does this patch work for CXL type 2 memory which is not in SRAT? A
> > > type 2 driver can find its HDM BASE physical address from its CXL
> > > registers and figure out its NUMA node id by calling phys_to_target_node?
> >
> > Yes. This adds the nodes for the case where the BIOS doesn't fully describe
> > everything in CFMWS in the SRAT. And, yes, that is how the NUMA node can
> > be discovered.
> >
> > > Or is type 2 HDM currently being skipped altogether?
> >
> > Not sure what you mean by 'being skipped altogether'? The BIOS may
> > describe (all or none or some) of CXL Memory in the SRAT. In the case where
> > BIOS describes it all, NUMA nodes will already exist, and no new nodes will
> > be added here.
> >
> My question about skipping type2 wasn't directly related to your patch,
> but more of a question about current upstream support for probe/configuration
> of type 2 accelerator devices memory, irrespective of whether FW shows type 2
> memory in SRAT.

SRAT only has Type-2 ranges if the platform firmware maps the device's
memory into the EFI memory map (includes ACPI SRAT / SLIT / HMAT
population). I expect that situation to be negotiated on a case by
case basis between Type-2 device vendors and platform firmware
vendors. There is no requirement that any CXL memory, type-2 or
type-3, is mapped by platform firmware. Per the CDAT specification,
platform firmware is capable to map CXL into the EFI memory map at
boot, but there is no requirement for it to do so.

My expectation is that Linux will need to handle the full gamut of
possibilities here, i.e. all / some / none of the CXL Type-3 devices
present at boot mapped into the EFI memory map, and all / some / none
of the CXL Type-2 devices mapped into the EFI memory map.

> The desired outcome is that the kernel CXL driver recognizes such type 2 HDM,
> and assigns it a NUMA node such that the type 2 driver

Note that there's no driver involved at this point. Alison's patch is
just augmenting the ACPI declared NUMA nodes at boot so that the
core-mm is not surprised by undeclared NUMA nodes at
add_memory_driver_managed() time.

> can later add/online this memory,
> via add_memory_driver_managed which requires a NUMA node ID (which driver can
> discover after your patch by calling phys_to_target_node).

Yes, with this patch there are at least enough nodes for
add_memory_driver_managed() to have a reasonable answer for a NUMA
node for Type-2 memory. However, as Jonathan and I were discussing,
this minimum enabling may prove insufficient if, for example, you had
one CFMWS entry for all Type-2 memory in the system, but multiple
disparate accelerators that want to each do
add_memory_driver_managed(). In that scenario all of those
accelerators, which might want to have a target-node per
target-device, will all share one target-node. That said, unless and
until it becomes clear that system architectures require Linux to
define multiple nodes per CFMWS, I am happy to kick that can down the
road. Also, platform firmware can solve this problem by subdividing
Type-2 with multiple QTG ids so that multiple target devices can each
be assigned to a different CFMWS entry sandbox, i.e. with more degrees
of freedom declared by platform firmware in the CFMWS it relieves
pressure on the OS to need a dynamic NUMA node definition capability.

> Would the current upstream code for HDM work as described above,

Current upstream code that enumerates Type-2 is the cxl_acpi driver
that enumerates platform CXL capabilities.

> and if so, does it
> rely on CDAT DSEMTS structure showing a specific value for EFI memory type? i.e would it
> work if that field in DSEMTS was either EFI_CONVENTIONAL_MEMORY with EFI_MEMORY_SP,
> or EFI_RESERVED_MEMORY?

If platform firmware maps the HDM the expectation is that it will use
the CDAT to determine the EFI memory type. If platform firmware
declines to map the device and lets Linux map it then that's de-facto
"reserved" memory and the driver (generic CXL-Type-3 / or vendor
specific CXL-Type-2) gets to do insert_resource() with whatever Linux
type it deems appropriate, i.e. EFI is out of the picture in this
scenario.
