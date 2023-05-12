Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BFC700CE4
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjELQWt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjELQWr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:22:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921F49F3;
        Fri, 12 May 2023 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683908564; x=1715444564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p23Hz3wSB4daiPRrxrAPIsF3CynauoD6ehPBvTW974w=;
  b=BiozxcaGSuQ/9IPWKcvPgRlCLSaHw8SVPkmR/HJriZFo5QzNSgIpI9yd
   q3oIoaoI3PtqqY/h5/hceBvUiXNa9sD0X//++v2iA7u92QTV7P9GT7xC9
   Dwb0fBWM5KS2//s5XNfHj4JkNAsTKrxVXxpoGe8868+3t+8hZ3XAlQFPt
   h7bNuzv+4qQr/jaSMmPI4BcfO/MVNCuKyXwP34Dli3c6PVM/cHFEb5rVy
   zHDtZvVMY1ErDjUdD9LrmgG9ioJZhZP419Hl6il9NpSZJUPS6s5jh06un
   VHIoVRFKPQ/AFBZnoXXmg6pjwmp6TyNqITf14d6kqpEfAPg2cf63S/SBi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="340145725"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="340145725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="694285296"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694285296"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.160.55]) ([10.213.160.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:22:42 -0700
Message-ID: <eda488c0-f244-a6a8-2800-8186cd0e42d3@intel.com>
Date:   Fri, 12 May 2023 09:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] acpi: numa: Add setting of generic port system
 locality attributes
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de
References: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
 <168333152832.2290593.17409054392013117865.stgit@djiang5-mobl3>
 <20230512171643.00001700@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230512171643.00001700@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/12/23 9:16 AM, Jonathan Cameron wrote:
> On Fri, 05 May 2023 17:05:28 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add generic port support for the parsing of HMAT system locality sub-table.
>> The attributes will be added to the third array member of the access
>> coordinates in order to not mix with the existing memory attributes it only
>> provides the system locality attributes from initator to the generic port
>> targets and is missing the rest of the data to the actual memory device.
>>
>> The complete attributes will be updated when a memory device is
>> attached and the system locality information is calculated end to end.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Strange question for you.  For now we have it easy as we only have Type 3
> CXL devices using this.  Later when we have accelerators, then the generic
> port becomes both an initiator and a target (well proxy of one in both cases).
> We'll probably want to map the linux view of a generic initiator (CPU less
> node) on top of the accelerator using the access characteristics from HMAT +
> other parts.
> 
> Any thoughts on how to extend this approach to that case?

I have not given much thought on it. But I'll think on it.

> 
> I can see it might need another access class so that normal memory for example
> can be the target of a generic port.
> 
> Maybe it's worth predicting that and renaming CLASS_GENPORT to CLASS_GENPORT_SINK
> or something along those lines?

Sure. We can name it to something more specific with an eye on the 
future. But we can deal with the rest when the time comes.

> 
> Or just leave it until someone cares?  I'm fine with this answer if you agree ;)
> 
> Jonathan
> 
>> ---
>>   drivers/acpi/numa/hmat.c |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index e2ab1cce0add..951579e903cf 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -60,6 +60,7 @@ struct target_cache {
>>   enum {
>>   	NODE_ACCESS_CLASS_0 = 0,
>>   	NODE_ACCESS_CLASS_1,
>> +	NODE_ACCESS_CLASS_GENPORT,
>>   	NODE_ACCESS_CLASS_MAX,
>>   };
>>   
>> @@ -368,6 +369,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>>   			if (mem_hier == ACPI_HMAT_MEMORY) {
>>   				target = find_mem_target(targs[targ]);
>>   				if (target && target->processor_pxm == inits[init]) {
>> +					if (*target->device_handle) {
>> +						hmat_update_target_access(target, type, value,
>> +								NODE_ACCESS_CLASS_GENPORT);
>> +						continue;
>> +					}
>> +
>>   					hmat_update_target_access(target, type, value,
>>   								  NODE_ACCESS_CLASS_0);
>>   					/* If the node has a CPU, update access 1 */
>>
>>
> 
