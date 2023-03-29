Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B986CF49F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 22:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjC2UmD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 16:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC2UmC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 16:42:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915B5BAB;
        Wed, 29 Mar 2023 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680122521; x=1711658521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iSyV0ehDFak9QQXAgOyi/XJ6vJSbq2f23ALBwakUg0k=;
  b=DxQEpJe7h1M3FGM0i4RV0W/2Fq+ryKuN5A63jKx+NNlTWxl+8d9DXChX
   7fALAoqQqAuYece1leXTFB+n3iSNybh3iLA6qu5GPEGbubVtUtkJZOg6I
   zdoJu6/4b/O6xH0nlF3KSK84oUw+NyRG8GRBUDxD6BmBsNxs6eIAVZFlp
   JNWK33Jl8+QMt4dhx1w0lCic6hqqK2tV/IRVxnM0yENE/vSso8gEDUHws
   gXWZUnZF6crjPc4UqKn+guoOE1oiy2jh0Ew8axsNA4MjR6D6hlB2sKR02
   pRcyNtbLgDDD8Wk1m5UiVUTWMLUNX8McEFrgX3Coo5jBy6wRBYun2I2d2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368769997"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368769997"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="661747701"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="661747701"
Received: from sandrew-mobl2.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:42:00 -0700
Message-ID: <cd54fc74-95d5-c950-4d61-33a152c43937@intel.com>
Date:   Wed, 29 Mar 2023 13:41:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 05/21] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995347254.2857312.246180486952683569.stgit@djiang5-mobl3>
 <ZCOEa0Y7OFU4afxK@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZCOEa0Y7OFU4afxK@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/28/23 5:20 PM, Alison Schofield wrote:
> On Mon, Mar 27, 2023 at 02:44:32PM -0700, Dave Jiang wrote:
>> Provide a callback function to the CDAT parser in order to parse the Device
>> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
>> DPA range and its associated attributes in each entry. See the CDAT
>> specification for details.
> 
> Are we going away from offering spec section numbers or links?

Ok I'll add.

> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v2:
>> - Add DSMAS table size check. (Lukas)
>> - Use local DSMAS header for LE handling.
>> - Remove dsmas lock. (Jonathan)
>> - Fix handle size (Jonathan)
>> - Add LE to host conversion for DSMAS address and length.
>> - Make dsmas_list local
>> ---
>>   drivers/cxl/core/cdat.c |   26 ++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h       |    1 +
>>   drivers/cxl/cxlpci.h    |   18 ++++++++++++++++++
>>   drivers/cxl/port.c      |   24 ++++++++++++++++++++++++
>>   4 files changed, 69 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 210f4499bddb..d068609fb6f9 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -98,3 +98,29 @@ int cdat_table_parse_sslbis(struct cdat_header *table,
>>   	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
>> +
>> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
>> +{
>> +	struct cdat_dsmas *dsmas = (struct cdat_dsmas *)(header);
>> +	struct list_head *dsmas_list = (struct list_head *)arg;
> 
> cast from void unnecessary ?

Ok will remove

> 
>> +	struct dsmas_entry *dent;
>> +
>> +	if (dsmas->hdr.length != sizeof(*dsmas)) {
>> +		pr_warn("Malformed DSMAS table length: (%lu:%u)\n",
>> +			 (unsigned long)sizeof(*dsmas), dsmas->hdr.length);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
>> +	if (!dent)
>> +		return -ENOMEM;
>> +
>> +	dent->handle = dsmas->dsmad_handle;
>> +	dent->dpa_range.start = le64_to_cpu(dsmas->dpa_base_address);
>> +	dent->dpa_range.end = le64_to_cpu(dsmas->dpa_base_address) +
>> +			      le64_to_cpu(dsmas->dpa_length) - 1;
>> +	list_add_tail(&dent->list, dsmas_list);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index cc3309794b45..9d0e22fe72c0 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -8,6 +8,7 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bitops.h>
>>   #include <linux/log2.h>
>> +#include <linux/list.h>
>>   #include <linux/io.h>
>>   
>>   /**
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 45e2f2bf5ef8..9a2468a93d83 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -104,6 +104,22 @@ struct cdat_subtable_entry {
>>   	enum cdat_type type;
>>   };
>>   
>> +struct dsmas_entry {
>> +	struct list_head list;
>> +	struct range dpa_range;
>> +	u8 handle;
>> +};
>> +
>> +/* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
>> +struct cdat_dsmas {
>> +	struct cdat_entry_header hdr;
>> +	u8 dsmad_handle;
>> +	u8 flags;
>> +	__u16 reserved;
>> +	__le64 dpa_base_address;
>> +	__le64 dpa_length;
>> +} __packed;
>> +
>>   int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>>   struct cxl_dev_state;
>>   int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>> @@ -119,4 +135,6 @@ int cdat_table_parse_##x(struct cdat_header *table, \
>>   cdat_table_parse(dsmas);
>>   cdat_table_parse(dslbis);
>>   cdat_table_parse(sslbis);
>> +
>> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 60a865680e22..c8136797d528 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -57,6 +57,16 @@ static int discover_region(struct device *dev, void *root)
>>   	return 0;
>>   }
>>   
>> +static void dsmas_list_destroy(struct list_head *dsmas_list)
>> +{
>> +	struct dsmas_entry *dentry, *n;
>> +
>> +	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
>> +		list_del(&dentry->list);
>> +		kfree(dentry);
>> +	}
>> +}
>> +
>>   static int cxl_switch_port_probe(struct cxl_port *port)
>>   {
>>   	struct cxl_hdm *cxlhdm;
>> @@ -131,9 +141,23 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>   static int cxl_port_probe(struct device *dev)
>>   {
>>   	struct cxl_port *port = to_cxl_port(dev);
>> +	int rc;
>>   
>>   	/* Cache the data early to ensure is_visible() works */
>>   	read_cdat_data(port);
>> +	if (port->cdat.table) {
>> +		if (is_cxl_endpoint(port)) {
> 
> How about reducing indentation w:
> 	if ((port->cdat.table) && (is_cxl_endpoint(port))

Yes. I got a little disoriented around here from the v6.2 to v6.3 rebase 
where this function changed drastically. In fact I think I'll move this 
block under the endpoint check below to avoid another endpoint check.

> 
>> +			LIST_HEAD(dsmas_list);
>> +
>> +			rc = cdat_table_parse_dsmas(port->cdat.table,
>> +						    cxl_dsmas_parse_entry,
>> +						    (void *)&dsmas_list);
>> +			if (rc < 0)
>> +				dev_warn(dev, "Failed to parse DSMAS: %d\n", rc);
>> +
>> +			dsmas_list_destroy(&dsmas_list);
>> +		}
>> +	}
>>   
>>   	if (is_cxl_endpoint(port))
>>   		return cxl_endpoint_port_probe(port);
>>
>>
