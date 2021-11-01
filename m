Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8C441AF7
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 13:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhKAMDd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 08:03:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4047 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhKAMDc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2021 08:03:32 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HjWhQ6DhMz6H6rt;
        Mon,  1 Nov 2021 19:56:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 1 Nov 2021 13:00:57 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 12:00:57 +0000
Date:   Mon, 1 Nov 2021 12:00:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/6] Introduce acpi_table_parse_cedt and extra nodes for
 CXL.mem
Message-ID: <20211101120055.00007383@Huawei.com>
In-Reply-To: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 29 Oct 2021 12:51:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Hi Rafael,
> 
> While reviewing "[PATCH v3] ACPI: NUMA: Add a node and memblk for each
> CFMWS not in SRAT" [1]. I noticed that it was open coding CEDT sub-table
> parsing in a similar fashion as drivers/cxl/acpi.c. The driver open
> coded the parsing because the ACPI sub-table helpers are marked __init.
> In order to avoid the ongoing maintenance burden of a split between
> "early" and "late" ACPI sub-table parsing this series proposes to make
> those helpers available to drivers.
> 
> The savings in drivers/cxl/ are:
> 
>  drivers/cxl/Kconfig |    1 
>  drivers/cxl/acpi.c  |  234 +++++++++++++++++++--------------------------------
>  2 files changed, 88 insertions(+), 147 deletions(-)
> 
> ...and 15 lines new code not added are saved in this new version of
> "ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT".
> 
> Let me know if this looks ok to you and I can carry it in the CXL tree
> (i.e. after the merge window, for v5.17 consideration).
> 
> [1]: https://lore.kernel.org/r/20211019050908.449231-1-alison.schofield@intel.com

Is it worth the complexity of the __init_or_acpilib and export part?
Seems like a fiddly dance for what looks to be minor savings...

Jonathan

> 
> ---
> 
> Alison Schofield (1):
>       ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT
> 
> Dan Williams (5):
>       ACPI: Keep sub-table parsing infrastructure available for modules
>       ACPI: Teach ACPI table parsing about the CEDT header format
>       ACPI: Add a context argument for table parsing handlers
>       cxl/acpi: Convert CFMWS parsing to ACPI sub-table helpers
>       cxl/test: Mock acpi_table_parse_cedt()
> 
> 
>  drivers/acpi/Kconfig          |    3 +
>  drivers/acpi/numa/srat.c      |   59 ++++++++++
>  drivers/acpi/tables.c         |   87 +++++++++++----
>  drivers/cxl/Kconfig           |    1 
>  drivers/cxl/acpi.c            |  237 ++++++++++++++++-------------------------
>  include/linux/acpi.h          |   34 +++++-
>  tools/testing/cxl/Kbuild      |    3 -
>  tools/testing/cxl/test/cxl.c  |   68 ++++++++----
>  tools/testing/cxl/test/mock.c |   30 ++---
>  tools/testing/cxl/test/mock.h |    6 +
>  10 files changed, 304 insertions(+), 224 deletions(-)
> 
> base-commit: c6d7e1341cc99ba49df1384c8c5b3f534a5463b1

