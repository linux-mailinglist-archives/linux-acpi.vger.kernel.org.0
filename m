Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D5D43A431
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhJYURI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbhJYURF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2021 16:17:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8873DC08B9C6
        for <linux-acpi@vger.kernel.org>; Mon, 25 Oct 2021 12:44:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso250666pjf.3
        for <linux-acpi@vger.kernel.org>; Mon, 25 Oct 2021 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Op5woeUcNd5YIo94OUhEYhJ/e8D10wgpr999fj7xy9Y=;
        b=Q2BJTeRQVgapELodN4LG7Xbxr6Mk7ky24zG7VbqxQ6O57kSU9K/UC/VUE0M5v6yU/U
         D4KM3ZhVMfcVUfohsWohjCdEjJmi9la9LeWuYuyqEj39tOmAFBGRSIYJQDgWYk+1sO2A
         aulnLMMVHeY3lSNK3EzAW4j2Yt6m0x9xuT3TGL+5YwoJJdy3IGWjEuP40kngRvhCsNx5
         ypVZLWU/cpTZZi27KhAjBbAbgF1ROXitA8U4TMsG4akwUi/38eBVwTBOQPQzgmj2BWga
         1BJ5yoFIVzL/pCqvDmvboc4lSXItuW2uRwgiYs6yE8fcoTQ6gELdC4qMnzceK0ZgRltk
         AiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Op5woeUcNd5YIo94OUhEYhJ/e8D10wgpr999fj7xy9Y=;
        b=A0IZrviy+ghYtJ0o0hw761rkrC4uhoEB5zxyadzP2CSdAWPYFFEbraBYW2Crk1iaZf
         jI9Zbp7gH/Z5oLBlxfIxmDzVcpjvfd9Od8idsI1VjgNUGO48f7urYH8SlTVY4tsJ/N2K
         4rzBNgOdvONqO6fh4T9g/qfloQU2E6l6JHoC5gxP34L/PNIxpGAtfUZiPS5Szbk09Qgj
         MmZCLFcxpOVlpewQWTw8HmVkEIHB6zDFZzTCujAdXyoHyFmELmtrPwwXzmuPm7+TBl7V
         fU4MXb4Wi2kQpwjiRC6uoOi9ZDoD90gsOu41pZVlNYYIRXWTthPtB/sh14VlJb5kv9sm
         Iwzw==
X-Gm-Message-State: AOAM533JsTgEKhLHaBH7mfLBvafJq0mxibIcyZ9YesSY1eVTEdtzGTAu
        LWvtYiqnstVz+pAhzNuHREKYmQMhU59Pxkt1XQSNng==
X-Google-Smtp-Source: ABdhPJykpq5tf/ZEXlEMEEvg169QdSzMdZ+sHGh4WT2ukUC0Weeaw/RiH8kd4uyfoR5aWJ7xvmvocYP0rmVS8zMvXwk=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr22405988pjb.93.1635191039965;
 Mon, 25 Oct 2021 12:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211019050908.449231-1-alison.schofield@intel.com>
 <SN6PR12MB2653CF7BEF1DA0A97B029396BDBE9@SN6PR12MB2653.namprd12.prod.outlook.com>
 <20211021010023.GA457926@alison-desk> <SN6PR12MB265309099EDA5C3C1311C6B8BDBF9@SN6PR12MB2653.namprd12.prod.outlook.com>
 <CAPcyv4itUbyi253=9zw7NvrQnUJzkM9ry3NwW9+ed5aSGgdOLQ@mail.gmail.com> <SN6PR12MB2653B4B690DEB00B4F506656BD809@SN6PR12MB2653.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2653B4B690DEB00B4F506656BD809@SN6PR12MB2653.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Oct 2021 12:43:49 -0700
Message-ID: <CAPcyv4g4N6=CD1Xhtxgc74HxS64QwyGXGYBQ=b56QG+o6i2XKQ@mail.gmail.com>
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

On Fri, Oct 22, 2021 at 2:58 PM Vikram Sethi <vsethi@nvidia.com> wrote:
>
> Hi Dan,
> Thanks for the detailed response. Some comments/questions inline.
[..]
> > My expectation is that Linux will need to handle the full gamut of possibilities
> > here, i.e. all / some / none of the CXL Type-3 devices present at boot
> > mapped into the EFI memory map, and all / some / none of the CXL Type-2
> > devices mapped into the EFI memory map.
> >
> Agreed. IIUC, if FW has initialized HDM base/decoder HPA in device, shown
> device HDM HPA in EFI Memory Map as reserved based on CDAT, and shown
> PXM for Device memory in SRAT, kernel can validate no conflicts in FW HDM HPA
> assignments vs CFMWS, and then map the PXM from SRAT to a node ID.

The kernel will just trust the ACPI tables. I.e. there won't be any
CFMWS + HDM validation before the kernel assigns a NUMA-node for an
SRAT PXM. Just like the kernel does not validate DDR memory controller
registers before trusting ACPI.

> The CFMWS DSM seems unnecessary for this case to get the NUMA assignments,
>  right? Type 2 Driver calls phys_to_target_node() and then add_memory_driver_managed.

Right, the QTG DSM has no production role for the OS if the BIOS has
already done the work to map the HDM. It could still be used in a
platform validation test case, or for strict consistency checks, but
otherwise fall back to trusting EFI-MAP + SRAT + SLIT +  HMAT if CFMWS
+ CDAT + QTG-DSM disagrees.

>
> > > The desired outcome is that the kernel CXL driver recognizes such type
> > > 2 HDM, and assigns it a NUMA node such that the type 2 driver
> >
> > Note that there's no driver involved at this point. Alison's patch is just
> > augmenting the ACPI declared NUMA nodes at boot so that the core-mm is
> > not surprised by undeclared NUMA nodes at
> > add_memory_driver_managed() time.
> >
> > > can later add/online this memory,
> > > via add_memory_driver_managed which requires a NUMA node ID (which
> > > driver can discover after your patch by calling phys_to_target_node).
> >
> > Yes, with this patch there are at least enough nodes for
> > add_memory_driver_managed() to have a reasonable answer for a NUMA
> > node for Type-2 memory. However, as Jonathan and I were discussing, this
> > minimum enabling may prove insufficient if, for example, you had one
> > CFMWS entry for all Type-2 memory in the system, but multiple disparate
> > accelerators that want to each do add_memory_driver_managed().
>
> CEDT CFMWS ECN says "The CFMWS structure describes zero or more Host Physical
> Address (HPA) windows associated with *each CXL Host Bridge*".

The next sentence clarifies that a CFMWS entry can interleave multiple
host bridges.

> So are you concerned about multiple type 2 accelerators under the same Host bridge?

The concern is multiple disparate accelerator HDM ranges with only one
CFMWS entry that they can map.

> IIRC CXL 2.0 only allows 1 type 2 device under a host bridge, but perhaps that was
> under 1 "root port", and you are pointing out that a system that has multiple
> root ports under 1 CXL host bridge can have multiple CXL type 2 accelerators under it.
> Future revisions of the spec could always relax current restrictions even under 1
> root port, so I do see the problem about multiple type 2 devices under 1 CFMWS
> window wanting their own NUMA nodes. Apologies if I'm mangling the
> terminology for host bridge vs root port, but trying to correlate with PCIe terminology
> of RC/RP.

CFMWS maps the hostbridge (RC) interleave, the upstream port inside
that RC maps RP interleave. Yes, there is nothing that prevents ACPI
from describing multiple NUMA nodes within a single CFMWS. However,
setting ACPI aside, if you hot-added multiple Type-2 devices where the
OS has to do dynamic assignment, per this patch they would only get
assigned to the one NUMA node associated with a given CFMWS entry.

If the OS wants to do multiple NUMA nodes per CFMWS it either needs to
statically allocate more nodes up front, or rework the core-mm to
allow dynamic node definition. That design decision is deferred until
it's clear that one node per CFMWS (for hot added devices) is
determined to be insufficient.

> > In that scenario all of those accelerators, which might want to have a target-node
> > per target-device, will all share one target-node. That said, unless and until it
> > becomes clear that system architectures require Linux to define multiple
> > nodes per CFMWS, I am happy to kick that can down the road. Also, platform
> > firmware can solve this problem by subdividing
> > Type-2 with multiple QTG ids so that multiple target devices can each be
> > assigned to a different CFMWS entry sandbox, i.e. with more degrees of
> > freedom declared by platform firmware in the CFMWS it relieves pressure on
> > the OS to need a dynamic NUMA node definition capability.
> >
> Let's say there are 2 type 2 accelerators with the same latency/bandwidth
> properties under a given CXL host bridge. When the DSM is executed on this host
> bridge with the latency/BW as input, IIUC you're saying FW could return 2 possible
> QTG IDs, let's say 4 and 5? And for that host bridge, FW also create 2 CFMWS
> windows of HPA for type 2, with one showing QTG ID =4, and the other showing
> QTG ID=5, with each having at least enough HPA space to map 1 of those devices?

The DSM just translates a performance profile into a QTG id, so if 2
accelerators share the same performance it does not matter where they
are plugged in they will map to the same QTG id. However, they can
still map to different CFMWS entries if they are plugged into
different hostbridges. If they share the same hostbridge then they
will share the same CFMWS entry.
