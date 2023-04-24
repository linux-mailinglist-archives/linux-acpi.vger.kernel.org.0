Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF32C6ED841
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 00:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDXW74 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 18:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjDXW7z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 18:59:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED99001;
        Mon, 24 Apr 2023 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682377194; x=1713913194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1fihdQCrm4MdTNuxg5VQEqbWhzfsHfpSwgDry2wXrWw=;
  b=i6LbPqmoexPqTOi0r9CtBAvhixmOqup2FW/VaTQ6QM9d7ymQwW2T8irb
   MxeRxXW0RohmtGtdOO9coBiQzwfA2D/ASt5Q7kyBN64Zqy9mTfRAq1vfp
   KOOJcjOacDl3RVsguVnwcXIZoqmhZ2lnn+mSFQcmRXqephXGsNUe3IX7L
   UM969D6fMXoOceq3nbYVQryVD6KeIQCyLOhxaFFWc91wqKGHxKw7/9ys2
   h4EV0n+/2vlihxXuhz7bwOjqSvkdkusxfXCWh2yJFoCItSlfLNlJAICHD
   bAFOwGzMZgxCuy2UnN7dFDSTsKcQWmtarYkzCeQ5TdNz1HMGkHf1dKWBF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="330797338"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="330797338"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 15:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="687088019"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="687088019"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.106.191]) ([10.212.106.191])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 15:59:53 -0700
Message-ID: <e9e3fef9-1051-7876-1a09-40940b849cb6@intel.com>
Date:   Mon, 24 Apr 2023 15:59:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 06/23] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193569717.1178687.294428469465996536.stgit@djiang5-mobl3>
 <644706c631bb8_1b66294eb@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <644706c631bb8_1b66294eb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/24/23 3:46 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Provide a callback to parse the Device Scoped Latency and Bandwidth
>> Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
>> contains the bandwidth and latency information that's tied to a DSMAS
>> handle. The driver will retrieve the read and write latency and
>> bandwidth associated with the DSMAS which is tied to a DPA range.
>>
>> Coherent Device Attribute Table 1.03 2.1 Device Scoped Latency and
>> Bandwidth Information Structure (DSLBIS)
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v3:
>> - Added spec section in commit header. (Alison)
>> - Remove void * recast. (Alison)
>> - Rework comment. (Alison)
>> - Move CDAT parse to cxl_endpoint_port_probe()
>> - Convert to use 'struct node_hmem_attrs'
>>
>> v2:
>> - Add size check to DSLIBIS table. (Lukas)
>> - Remove unnecessary entry type check. (Jonathan)
>> - Move data_type check to after match. (Jonathan)
>> - Skip unknown data type. (Jonathan)
>> - Add overflow check for unit multiply. (Jonathan)
>> - Use dev_warn() when entries parsing fail. (Jonathan)
>> ---
>>   drivers/cxl/core/cdat.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h    |   34 +++++++++++++++++++++++-
>>   drivers/cxl/port.c      |   11 +++++++-
>>   3 files changed, 111 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 6f20af83a3ed..e8b9bb99dfdf 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>> +#include <linux/overflow.h>
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>>   
>> @@ -124,3 +125,70 @@ int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
>> +
>> +static void cxl_hmem_attrs_set(struct node_hmem_attrs *attrs,
>> +			       int access, unsigned int val)
>> +{
>> +	switch (access) {
>> +	case HMAT_SLLBIS_ACCESS_LATENCY:
>> +		attrs->read_latency = val;
>> +		attrs->write_latency = val;
>> +		break;
>> +	case HMAT_SLLBIS_READ_LATENCY:
>> +		attrs->read_latency = val;
>> +		break;
>> +	case HMAT_SLLBIS_WRITE_LATENCY:
>> +		attrs->write_latency = val;
>> +		break;
>> +	case HMAT_SLLBIS_ACCESS_BANDWIDTH:
>> +		attrs->read_bandwidth = val;
>> +		attrs->write_bandwidth = val;
>> +		break;
>> +	case HMAT_SLLBIS_READ_BANDWIDTH:
>> +		attrs->read_bandwidth = val;
>> +		break;
>> +	case HMAT_SLLBIS_WRITE_BANDWIDTH:
>> +		attrs->write_bandwidth = val;
>> +		break;
>> +	}
>> +}
>> +
>> +int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
>> +{
>> +	struct cdat_dslbis *dslbis = (struct cdat_dslbis *)header;
>> +	struct list_head *dsmas_list = arg;
>> +	struct dsmas_entry *dent;
>> +
>> +	if (dslbis->hdr.length != sizeof(*dslbis)) {
>> +		pr_warn("Malformed DSLBIS table length: (%lu:%u)\n",
>> +			(unsigned long)sizeof(*dslbis), dslbis->hdr.length);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Skip unrecognized data type */
>> +	if (dslbis->data_type >= HMAT_SLLBIS_DATA_TYPE_MAX)
>> +		return 0;
>> +
>> +	list_for_each_entry(dent, dsmas_list, list) {
>> +		u64 val;
>> +		int rc;
>> +
>> +		if (dslbis->handle != dent->handle)
>> +			continue;
> 
> Oh, now I see why the list is needed. Update the changelog of the
> previous patch to indicate that the entries are cached to a list so they
> can be cross referenced during dslbis parsing. At least that would have
> saved me from picking on it.

Jonathan had the same comment. It'll be updated for the next rev to make 
the connection.

> 
> 
>> +
>> +		/* Not a memory type, skip */
>> +		if ((dslbis->flags & DSLBIS_MEM_MASK) != DSLBIS_MEM_MEMORY)
>> +			return 0;
>> +
>> +		rc = check_mul_overflow(le64_to_cpu(dslbis->entry_base_unit),
>> +					le16_to_cpu(dslbis->entry[0]), &val);
>> +		if (unlikely(rc))
> 
> Don't use likely() / unlikely() without performance numbers. The
> compiler generally does a better job and this is not a hot path.
