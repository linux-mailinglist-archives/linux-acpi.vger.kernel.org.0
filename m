Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F086C4434C2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhKBRrB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 13:47:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4052 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhKBRrA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 13:47:00 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HkHHw2w6Sz67Q4R;
        Wed,  3 Nov 2021 01:41:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 18:44:23 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 17:44:22 +0000
Date:   Tue, 2 Nov 2021 17:44:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/6] Introduce acpi_table_parse_cedt and extra nodes for
 CXL.mem
Message-ID: <20211102174421.00002ae4@Huawei.com>
In-Reply-To: <CAPcyv4g_c1mF6WvsMHC7-US7YybSprk=GX6cFWjoGOVa+yLx9g@mail.gmail.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20211101120055.00007383@Huawei.com>
        <CAPcyv4g_c1mF6WvsMHC7-US7YybSprk=GX6cFWjoGOVa+yLx9g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 1 Nov 2021 20:41:34 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Nov 1, 2021 at 5:01 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 29 Oct 2021 12:51:27 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > Hi Rafael,
> > >
> > > While reviewing "[PATCH v3] ACPI: NUMA: Add a node and memblk for each
> > > CFMWS not in SRAT" [1]. I noticed that it was open coding CEDT sub-table
> > > parsing in a similar fashion as drivers/cxl/acpi.c. The driver open
> > > coded the parsing because the ACPI sub-table helpers are marked __init.
> > > In order to avoid the ongoing maintenance burden of a split between
> > > "early" and "late" ACPI sub-table parsing this series proposes to make
> > > those helpers available to drivers.
> > >
> > > The savings in drivers/cxl/ are:
> > >
> > >  drivers/cxl/Kconfig |    1
> > >  drivers/cxl/acpi.c  |  234 +++++++++++++++++++--------------------------------
> > >  2 files changed, 88 insertions(+), 147 deletions(-)
> > >
> > > ...and 15 lines new code not added are saved in this new version of
> > > "ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT".
> > >
> > > Let me know if this looks ok to you and I can carry it in the CXL tree
> > > (i.e. after the merge window, for v5.17 consideration).
> > >
> > > [1]: https://lore.kernel.org/r/20211019050908.449231-1-alison.schofield@intel.com  
> >
> > Is it worth the complexity of the __init_or_acpilib and export part?
> > Seems like a fiddly dance for what looks to be minor savings...  
> 
> It follows the __initdata_or_meminfo precedent that identifies data
> that is normally __init unless a specific driver needs it. The lesson
> from the tinyconfig effort was that image size dies a death of many
> cuts unless care is taken to preserve minor savings. Yes, it's likely
> trivial in this case, but it's at least a gesture to avoid bloating
> the kernel image size unnecessarily when the kernel has gotten by so
> long with this infrastructure being purely __init.

I'm in favor avoiding bloat, but this is ACPI code so rarely very small machines
and very like that all distros will turn it on anyway on basis they will want
to support CXL (hopefully!)

I guess let's see what Rafael's opinion is.  I don't feel that strongly about
it if general view is that it is worth the small amount of complexity.

Jonathan

