Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282B6E9FDC
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 01:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjDTXZo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjDTXZm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 19:25:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5251BCE;
        Thu, 20 Apr 2023 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682033140; x=1713569140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0dMzj/lLtMMkNBPgF9b2G44D4Ywa0hMNXweVaOkgE9Q=;
  b=JYGJoLoWJL04liw4Mqpg3cu/GeEzaUyojQB1sd+SIifKJuGHqHZV4TqK
   oXfQI5aQPISYeGZz0FBYmoS2bYWk/6WZINtSxX2LRbJjzsJ9xCoYSmgIM
   f9U4N8mEWL5LE4GJ6PifCW7HastGiZEPOvGirXZ/ZHatg8pDjLf/iJJEM
   0mV3aWQwnpHucqF9kAULqpZAj8TTo8PnlZao7Ye70gwJAjBL0uHIz42kD
   NO22E+PB60UZfXaljFEMY766rmf1cedTDZX1PEviCM9eUtwwbwFsEqlYo
   LLYWGkaR08KBSx/m5p7gURh8VJ5i3HYHGWLxxYTGusJwfFkZ4botYMdCt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344628237"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="344628237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="722566963"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="722566963"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.11.57]) ([10.212.11.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:25:38 -0700
Message-ID: <6d59ed8c-7bb6-b4f8-61e1-229894c33f0d@intel.com>
Date:   Thu, 20 Apr 2023 16:25:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 06/23] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193569717.1178687.294428469465996536.stgit@djiang5-mobl3>
 <20230420124043.00004e0e@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230420124043.00004e0e@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/20/23 4:40 AM, Jonathan Cameron wrote:
> On Wed, 19 Apr 2023 13:21:37 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
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
> 
> One comment inline.
> 
>> +/* Flags for DSLBIS subtable */
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
> I'm not sure this is worthwhile. What was your reasoning for it?
> Also wrecks typing that arg argument as I suggested earlier...

I can remove the macros. They are patterned after the code in ACPI.

> 
>> +
>> +cxl_parse_entry(dsmas);
>> +cxl_parse_entry(dslbis);
> 
