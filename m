Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447F6E8E68
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 11:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjDTJn2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjDTJnB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 05:43:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00D40E5;
        Thu, 20 Apr 2023 02:41:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2CGF2BwVz67qqr;
        Thu, 20 Apr 2023 17:36:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 10:41:05 +0100
Date:   Thu, 20 Apr 2023 10:41:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 04/23] cxl: Add common helpers for cdat parsing
Message-ID: <20230420104104.000065dd@Huawei.com>
In-Reply-To: <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 Apr 2023 13:21:25 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper functions to parse the CDAT table and provide a callback to
> parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
> parsing. The code is patterned after the ACPI table parsing helpers.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
A few minor things inline.   More than possible you addressed them
in earlier versions though.

Jonathan

> ---
> v2:
> - Use local headers to handle LE instead of ACPI header
> - Reduce complexity of parser function. (Jonathan)
> - Directly access header type. (Jonathan)
> - Simplify header ptr math. (Jonathan)
> - Move parsed counter to the correct location. (Jonathan)
> - Add LE to host conversion for entry length
> ---
>  drivers/cxl/core/Makefile |    1 
>  drivers/cxl/core/cdat.c   |  100 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h      |   29 +++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 drivers/cxl/core/cdat.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ca4ae31d8f57..867a8014b462 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -12,5 +12,6 @@ cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
> +cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> new file mode 100644
> index 000000000000..210f4499bddb
> --- /dev/null
> +++ b/drivers/cxl/core/cdat.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +#include "cxlpci.h"
> +#include "cxl.h"
> +
> +static bool has_handler(struct cdat_subtable_proc *proc)

Even though they are static, I'd add a cxl_ or cdat_ prefix
to these to make it clear they are local.

> +{
> +	return proc->handler;
> +}
> +
> +static int call_handler(struct cdat_subtable_proc *proc,
> +			struct cdat_subtable_entry *ent)
> +{
> +	if (has_handler(proc))

Do we need to check this again? It's checked in the parse_entries code
well before this point.

Also, if moving to checking it once, then is it worth the
little wrapper functions?


> +		return proc->handler(ent->hdr, proc->arg);
> +	return -EINVAL;
> +}
> +
> +static bool cdat_is_subtable_match(struct cdat_subtable_entry *ent)
> +{
> +	return ent->hdr->type == ent->type;
> +}
> +
> +static int cdat_table_parse_entries(enum cdat_type type,
> +				    struct cdat_header *table_header,
> +				    struct cdat_subtable_proc *proc)
> +{
> +	unsigned long table_end, entry_len;
> +	struct cdat_subtable_entry entry;
> +	int count = 0;
> +	int rc;
> +
> +	if (!has_handler(proc))
> +		return -EINVAL;
> +
> +	table_end = (unsigned long)table_header + table_header->length;
> +
> +	if (type >= CDAT_TYPE_RESERVED)
> +		return -EINVAL;
> +
> +	entry.type = type;
> +	entry.hdr = (struct cdat_entry_header *)(table_header + 1);
> +
> +	while ((unsigned long)entry.hdr < table_end) {
> +		entry_len = le16_to_cpu(entry.hdr->length);
> +
> +		if ((unsigned long)entry.hdr + entry_len > table_end)
> +			return -EINVAL;
> +
> +		if (entry_len == 0)
> +			return -EINVAL;
> +
> +		if (cdat_is_subtable_match(&entry)) {
> +			rc = call_handler(proc, &entry);
> +			if (rc)
> +				return rc;
> +			count++;
> +		}
> +
> +		entry.hdr = (struct cdat_entry_header *)((unsigned long)entry.hdr + entry_len);
> +	}
> +
> +	return count;
> +}

...

> +int cdat_table_parse_sslbis(struct cdat_header *table,
> +			    cdat_tbl_entry_handler handler, void *arg)

Feels like these ones should take a typed arg.  Sure you'll loose
that again to use the generic handling code, but at this level we can 
do it I think.

> +{
> +	struct cdat_subtable_proc proc = {
> +		.handler	= handler,
> +		.arg		= arg,
> +	};
> +
> +	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
> +}

