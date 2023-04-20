Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009016E9DA5
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 23:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjDTVFo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjDTVFm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 17:05:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECBF44AF;
        Thu, 20 Apr 2023 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682024741; x=1713560741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f7FPDTER5Qxseh44CIXFaBn+y02v/86uQbUd/8s59hQ=;
  b=PeAEqxdHblzGiqxPX7L8s9b/LdO+43fdqFtKXLo/8J3lsWciwegHtcrk
   7bU4g3CrZT7rciumxPhFwzUh3bjh8lTlKmfR8sLECRh3aFb+As39XA128
   5BnVLB5SJkSoZbtX1rNRkM6Nk7Ub34xhQDUgfUU4CnKnx7LfU6hFPX0rL
   ZdVPx9+F0ucA1zzCnc1kiaESQ6ZrWNoxDrMct899xfOWNA4wWD6BRJXi4
   zjrd0rAMjEgDi5ZRVgdbMDznAakqP6TR3sK7h2vl7FKyizRIchBVdOUBM
   4azYcTbWqVm/DtrfOFnHvQ3XK167pjspkhjkSQMbgrWJx2eSL8So5o4pZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="347747345"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="347747345"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 14:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="835916566"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="835916566"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.11.57]) ([10.212.11.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 14:05:40 -0700
Message-ID: <71fb1962-7029-119f-f12a-32849dff659a@intel.com>
Date:   Thu, 20 Apr 2023 14:05:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 04/23] cxl: Add common helpers for cdat parsing
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
 <20230420104104.000065dd@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230420104104.000065dd@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/20/23 2:41 AM, Jonathan Cameron wrote:
> On Wed, 19 Apr 2023 13:21:25 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add helper functions to parse the CDAT table and provide a callback to
>> parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
>> parsing. The code is patterned after the ACPI table parsing helpers.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
> A few minor things inline.   More than possible you addressed them
> in earlier versions though.
> 
> Jonathan
> 
>> ---
>> v2:
>> - Use local headers to handle LE instead of ACPI header
>> - Reduce complexity of parser function. (Jonathan)
>> - Directly access header type. (Jonathan)
>> - Simplify header ptr math. (Jonathan)
>> - Move parsed counter to the correct location. (Jonathan)
>> - Add LE to host conversion for entry length
>> ---
>>   drivers/cxl/core/Makefile |    1
>>   drivers/cxl/core/cdat.c   |  100 +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h      |   29 +++++++++++++
>>   3 files changed, 130 insertions(+)
>>   create mode 100644 drivers/cxl/core/cdat.c
>>
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index ca4ae31d8f57..867a8014b462 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -12,5 +12,6 @@ cxl_core-y += memdev.o
>>   cxl_core-y += mbox.o
>>   cxl_core-y += pci.o
>>   cxl_core-y += hdm.o
>> +cxl_core-y += cdat.o
>>   cxl_core-$(CONFIG_TRACING) += trace.o
>>   cxl_core-$(CONFIG_CXL_REGION) += region.o
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> new file mode 100644
>> index 000000000000..210f4499bddb
>> --- /dev/null
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>> +#include "cxlpci.h"
>> +#include "cxl.h"
>> +
>> +static bool has_handler(struct cdat_subtable_proc *proc)
> 
> Even though they are static, I'd add a cxl_ or cdat_ prefix
> to these to make it clear they are local.

Ok I'll change to cdat_*

> 
>> +{
>> +	return proc->handler;
>> +}
>> +
>> +static int call_handler(struct cdat_subtable_proc *proc,
>> +			struct cdat_subtable_entry *ent)
>> +{
>> +	if (has_handler(proc))
> 
> Do we need to check this again? It's checked in the parse_entries code
> well before this point.
> 
> Also, if moving to checking it once, then is it worth the
> little wrapper functions?

Ok I'll call it directly and remove the wrapper.

> 
> 
>> +		return proc->handler(ent->hdr, proc->arg);
>> +	return -EINVAL;
>> +}
>> +
>> +static bool cdat_is_subtable_match(struct cdat_subtable_entry *ent)
>> +{
>> +	return ent->hdr->type == ent->type;
>> +}
>> +
>> +static int cdat_table_parse_entries(enum cdat_type type,
>> +				    struct cdat_header *table_header,
>> +				    struct cdat_subtable_proc *proc)
>> +{
>> +	unsigned long table_end, entry_len;
>> +	struct cdat_subtable_entry entry;
>> +	int count = 0;
>> +	int rc;
>> +
>> +	if (!has_handler(proc))
>> +		return -EINVAL;
>> +
>> +	table_end = (unsigned long)table_header + table_header->length;
>> +
>> +	if (type >= CDAT_TYPE_RESERVED)
>> +		return -EINVAL;
>> +
>> +	entry.type = type;
>> +	entry.hdr = (struct cdat_entry_header *)(table_header + 1);
>> +
>> +	while ((unsigned long)entry.hdr < table_end) {
>> +		entry_len = le16_to_cpu(entry.hdr->length);
>> +
>> +		if ((unsigned long)entry.hdr + entry_len > table_end)
>> +			return -EINVAL;
>> +
>> +		if (entry_len == 0)
>> +			return -EINVAL;
>> +
>> +		if (cdat_is_subtable_match(&entry)) {
>> +			rc = call_handler(proc, &entry);
>> +			if (rc)
>> +				return rc;
>> +			count++;
>> +		}
>> +
>> +		entry.hdr = (struct cdat_entry_header *)((unsigned long)entry.hdr + entry_len);
>> +	}
>> +
>> +	return count;
>> +}
> 
> ...
> 
>> +int cdat_table_parse_sslbis(struct cdat_header *table,
>> +			    cdat_tbl_entry_handler handler, void *arg)
> 
> Feels like these ones should take a typed arg.  Sure you'll loose
> that again to use the generic handling code, but at this level we can
> do it I think.

while DSMAS and DSLBIS takes a list_head, SSLBIS takes an xarray. I can 
create a union.

> 
>> +{
>> +	struct cdat_subtable_proc proc = {
>> +		.handler	= handler,
>> +		.arg		= arg,
>> +	};
>> +
>> +	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>> +}
> 
