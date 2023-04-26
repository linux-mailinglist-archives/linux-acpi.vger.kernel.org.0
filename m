Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9086EFA0A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Apr 2023 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjDZS1Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Apr 2023 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjDZS1X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2023 14:27:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3851183E3;
        Wed, 26 Apr 2023 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682533641; x=1714069641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RWrYD36Z73aepbAKAQ1dpXIwMhjDuM3H1Roam6xDyJI=;
  b=OMNGk3HjPNsJFznsJv+2ITjsC+d3A+qQM2C29Ys4YgFH0f38zxueUIyf
   kh8Ox8oIux1d8RS9fIYFFxBozX4soupREyKGm46w86l2Qvni2sYbt1dxl
   QIwhWeKHI8qAU61ht6au4aRj7rfNChzzeXwpoZxl07qkD1+6ShRMv0GsR
   kOf3vuFzboqItVyP/6Kh6qvwMpv5+RcyuvNeKqBZAjoq+VA5eI7Ox2AUV
   Lj1QwoqgcyuPv5xahuuBqqzTxxPFJS1y/V92ZTqsuEsd4FEFNQXt7a3wc
   tmyYI5yjYJeeDfG2PhxVkFtoBtGAL6Whgvgl4Cgpi09jomYFskuIt4cLl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="350016624"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="350016624"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 11:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="758715732"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="758715732"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.13.43]) ([10.212.13.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 11:27:20 -0700
Message-ID: <b04301a0-7b63-f3ae-a15d-debaa4439574@intel.com>
Date:   Wed, 26 Apr 2023 11:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 05/23] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Content-Language: en-US
To:     "Li, Ming" <ming4.li@intel.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
 <828de4e9-3b8e-ef59-5e7f-6a12307a1127@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <828de4e9-3b8e-ef59-5e7f-6a12307a1127@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/25/23 8:44 PM, Li, Ming wrote:
> On 4/20/2023 4:21 AM, Dave Jiang wrote:
>> Provide a callback function to the CDAT parser in order to parse the Device
>> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
>> DPA range and its associated attributes in each entry. See the CDAT
>> specification for details.
>>
>> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
>> Structure (DSMAS)
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v3:
>> - Add spec section number. (Alison)
>> - Remove cast from void *. (Alison)
>> - Refactor cxl_port_probe() block. (Alison)
>> - Move CDAT parse to cxl_endpoint_port_probe()
>>
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
>>   drivers/cxl/port.c      |   22 ++++++++++++++++++++++
>>   4 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 210f4499bddb..6f20af83a3ed 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -98,3 +98,29 @@ int cdat_table_parse_sslbis(struct cdat_header *table,
>>   	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
>> +
>> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
>> +{
>> +	struct cdat_dsmas *dsmas = (struct cdat_dsmas *)header;
>> +	struct list_head *dsmas_list = arg;
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
> 
> Hi Dave,
> 
> I saw you didn't store flags field into dent, it is not needed or missed?

Hi Ming,
I didn't have a need for it for this patch set. But I think it may be 
needed in the future for DCD. I figured when we do, we can add it.

> 
> Thanks
> Ming
> 
> 
