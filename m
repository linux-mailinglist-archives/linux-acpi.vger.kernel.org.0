Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03A6CF4EA
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjC2U7Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC2U7P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 16:59:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66E469E;
        Wed, 29 Mar 2023 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680123554; x=1711659554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IamdS8OA1uHiWmN9yWxaZE0+aZhZezyeFHqKFQ8yc/k=;
  b=JbI0KbWPXmtO0OWF/0dNzy46bL3LeQZpLaRHkGu2049dDKrVAvMWIqXy
   BC9MEoWTWo5hAMw6D+JPaOAPtPzCzgADTgn+f3Q5jNMkUXkyj7SHz1kdZ
   vt2NsBYcazmZ7oYDfsn7zQRfTc97FFptQ6RXLaTPFuPaH+kVp37iLA0WB
   Ninq76pT+LdAJMRs9EMJJNCLt9Uhve+ESb4iHwIcnN/QwHXnU3EXksi1R
   2q0xt1fPmkZJSIfcdLFuBY/NOX3NregBLEAWMZftfxOcDdAdAgyzvF3ST
   k9N7820zeNB15PpzQhpdp+szixL1Z4o+ffCKwhP2KLbZkGwOY1H6CnNaz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="338499716"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="338499716"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="748911755"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="748911755"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:59:13 -0700
Message-ID: <4f51aade-faf2-fa63-2795-3207d82c14aa@intel.com>
Date:   Wed, 29 Mar 2023 13:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 06/21] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995347963.2857312.11781710463537827645.stgit@djiang5-mobl3>
 <ZCOJ8+k4K8jIco57@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZCOJ8+k4K8jIco57@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/28/23 5:44 PM, Alison Schofield wrote:
> On Mon, Mar 27, 2023 at 02:44:39PM -0700, Dave Jiang wrote:
>> Provide a callback to parse the Device Scoped Latency and Bandwidth
>> Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
>> contains the bandwidth and latency information that's tied to a DSMAS
>> handle. The driver will retrieve the read and write latency and
>> bandwidth associated with the DSMAS which is tied to a DPA range.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v2:
>> - Add size check to DSLIBIS table. (Lukas)
>> - Remove unnecessary entry type check. (Jonathan)
>> - Move data_type check to after match. (Jonathan)
>> - Skip unknown data type. (Jonathan)
>> - Add overflow check for unit multiply. (Jonathan)
>> - Use dev_warn() when entries parsing fail. (Jonathan)
>> ---
>>   drivers/cxl/core/cdat.c |   41 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h    |   34 +++++++++++++++++++++++++++++++++-
>>   drivers/cxl/port.c      |    9 ++++++++-
>>   3 files changed, 82 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index d068609fb6f9..0e88973e9f38 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>> +#include <linux/overflow.h>
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>>   
>> @@ -124,3 +125,43 @@ int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
>> +
>> +int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
>> +{
>> +	struct cdat_dslbis *dslbis = (struct cdat_dslbis *)header;
>> +	struct list_head *dsmas_list = (struct list_head *)arg;
> 
> cast from void ?

ok

> 
>> +	struct dsmas_entry *dent;
>> +
>> +	if (dslbis->hdr.length != sizeof(*dslbis)) {
>> +		pr_warn("Malformed DSLBIS table length: (%lu:%u)\n",
>> +			(unsigned long)sizeof(*dslbis), dslbis->hdr.length);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Unrecognized data type, we can skip */
> 
> /* Skip unrecognized data type */

ok

> 
>> +	if (dslbis->data_type >= HMAT_SLLBIS_DATA_TYPE_MAX)
>> +		return 0;
>> +
>> +	list_for_each_entry(dent, dsmas_list, list) {
>> +		u64 val;
>> +		int rc;
>> +
>> +		if (dslbis->handle != dent->handle)
>> +			continue;
>> +
>> +		/* Not a memory type, skip */
>> +		if ((dslbis->flags & DSLBIS_MEM_MASK) != DSLBIS_MEM_MEMORY)
>> +			return 0;
>> +
>> +		rc = check_mul_overflow(le64_to_cpu(dslbis->entry_base_unit),
>> +					le16_to_cpu(dslbis->entry[0]), &val);
>> +		if (unlikely(rc))
>> +			pr_warn("DSLBIS value overflowed!\n");
> 
> Must this be shouted !
> I have a vague recollection of being told not to use exclamation points
> in user visible messages.

ok

> 
>> +
>> +		dent->qos[dslbis->data_type] = val;
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 9a2468a93d83..1429de49e0c4 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -104,10 +104,21 @@ struct cdat_subtable_entry {
>>   	enum cdat_type type;
>>   };
>>   
>> +enum {
>> +	HMAT_SLLBIS_ACCESS_LATENCY = 0,
>> +	HMAT_SLLBIS_READ_LATENCY,
>> +	HMAT_SLLBIS_WRITE_LATENCY,
>> +	HMAT_SLLBIS_ACCESS_BANDWIDTH,
>> +	HMAT_SLLBIS_READ_BANDWIDTH,
>> +	HMAT_SLLBIS_WRITE_BANDWIDTH,
>> +	HMAT_SLLBIS_DATA_TYPE_MAX
>> +};
>> +
>>   struct dsmas_entry {
>>   	struct list_head list;
>>   	struct range dpa_range;
>>   	u8 handle;
>> +	u64 qos[HMAT_SLLBIS_DATA_TYPE_MAX];
>>   };
>>   
>>   /* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
>> @@ -120,6 +131,23 @@ struct cdat_dsmas {
>>   	__le64 dpa_length;
>>   } __packed;
>>   
>> +/* Sub-table 1: Device Scoped Latency and Bandwidth Information Structure (DSLBIS) */
>> +struct cdat_dslbis {
>> +	struct cdat_entry_header hdr;
>> +	u8 handle;
>> +	u8 flags;
>> +	u8 data_type;
>> +	u8 reserved;
>> +	__le64 entry_base_unit;
>> +	__le16 entry[3];
>> +	__le16 reserved2;
>> +} __packed;
>> +
>> +/* Flags for subtable above */
> 
> /* Flags for DSLBIS subtable */

ok

> 
>> +
>> +#define DSLBIS_MEM_MASK		GENMASK(3, 0)
>> +#define DSLBIS_MEM_MEMORY	0
>> +
>>   int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>>   struct cxl_dev_state;
>>   int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>> @@ -136,5 +164,9 @@ cdat_table_parse(dsmas);
>>   cdat_table_parse(dslbis);
>>   cdat_table_parse(sslbis);
>>   
>> -int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
>> +#define cxl_parse_entry(x) \
>> +int cxl_##x##_parse_entry(struct cdat_entry_header *header, void *arg)
>> +
>> +cxl_parse_entry(dsmas);
>> +cxl_parse_entry(dslbis);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index c8136797d528..6f2b327f7128 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -152,8 +152,15 @@ static int cxl_port_probe(struct device *dev)
>>   			rc = cdat_table_parse_dsmas(port->cdat.table,
>>   						    cxl_dsmas_parse_entry,
>>   						    (void *)&dsmas_list);
>> -			if (rc < 0)
>> +			if (rc > 0) {
>> +				rc = cdat_table_parse_dslbis(port->cdat.table,
>> +							     cxl_dslbis_parse_entry,
>> +							     (void *)&dsmas_list);
>> +				if (rc <= 0)
>> +					dev_warn(dev, "Failed to parse DSLBIS: %d\n", rc);
>> +			} else {
>>   				dev_warn(dev, "Failed to parse DSMAS: %d\n", rc);
>> +			}
> 
> I see you touch this func more than once. Maybe some earlier nips and
> tucks, makes this more readable.

Not sure what you mean.

> 
>>   
>>   			dsmas_list_destroy(&dsmas_list);
>>   		}
>>
>>
