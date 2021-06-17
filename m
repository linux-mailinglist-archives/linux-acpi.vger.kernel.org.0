Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564F83AB7C0
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 17:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhFQPoO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 11:44:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:61391 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232540AbhFQPoO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 11:44:14 -0400
IronPort-SDR: Z8QBuhE89bAgtQR6igJgWGQFnv+7RZvVjHKnPKVRpuCvbjfYm8/HlIxn+keDWD87PPZf/V66Ps
 0DG5mIOuGeVg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="203369145"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="203369145"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 08:41:37 -0700
IronPort-SDR: mytfaOilOdXvYMEbtHvbfBDM13SCmLv/Wm7VsvDxgcKC++yQ4jC5pJb8LDnGmrew5xiPiW01Ps
 Py9rX4QwFM+Q==
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="451057047"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.138.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 08:41:36 -0700
Date:   Thu, 17 Jun 2021 08:41:33 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/2] CXL ACPI tables for object creation
Message-ID: <20210617154133.zb54zf46foxcss3c@intel.com>
References: <cover.1623890468.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623890468.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21-06-16 18:11:06, Alison Schofield wrote:
> Jonathan - I updated Patch 2 so I didn't keep your Reviewed-by tag.
> 
> Changes since v2 [1]:
> - Warn and continue, rather than error out, on these acpi table parsing issues:
>   table length mismatch for either CHBS or CFMWS; duplicate uid's for CHBS.
>   (Ben, Jonathan)
> - Update flow in cxl_acpi_match_chbs()  (Ben, Jonathan)
> - Improve naming cedt_table->acpi_cedt, cedt_base->cedt_subtable (Ben)
> - Emit debug message only if CFMWS is greater than its expected length (Ben)
> - Update the dev_err messages wrt the CFMWS expected length failure.
> - Remove blank line before error handling block (Jonathan)
> - Rebase to the CXL pending branch [2]
> 
> [1]: https://lore.kernel.org/linux-cxl/cover.1623800340.git.alison.schofield@intel.com/ 
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=pending
> 
> --
> Parse the ACPI CXL Early Discovery Table (CEDT) and use the CHBS & CFMWS
> when creating port and decoder objects.
> 
> CHBS: CXL Host Bridge Structure - Patch 1
> CFMWS: CXL Fixed Memory Window Structure - Patch 2
> 
> Alison Schofield (2):
>   cxl/acpi: Add the Host Bridge base address to CXL port objects
>   cxl/acpi: Use the ACPI CFMWS to create static decoder objects
> 
>  drivers/cxl/acpi.c | 217 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 212 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 21083f51521fb0f60dbac591f175c3ed48435af4

It might be nice to add a header kdoc for acpi.c now that it's become sufficiently
complex. Can be follow-on patch.

Both are:
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
