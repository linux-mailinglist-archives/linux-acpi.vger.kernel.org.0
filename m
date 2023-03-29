Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1A6CF615
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC2WCg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 18:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjC2WCf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 18:02:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433CB4487;
        Wed, 29 Mar 2023 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680127354; x=1711663354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8qbCLZyMv5InazHImnb42m/tWQ0Bd8jvL4EAvt1o0ww=;
  b=dUcQIiSmUcAZ8I1dGOhRYnw37Ef+SavrlemaRFocQ6Qlof0+NZt9Z+S1
   rAnZ5NGMDC3P3F6nASdWl3XdqQ967QPYt9Pixmy3lma5DUCLGAiff7yMa
   GhrJf9e3eGre8KUbw7ozLbPkQhRZ4BS84MjVV+7b2Wu3gAinwDB9W0WKh
   cuOLQFvKW5AlJVHw1mMXIXJdvY4Htl+ywflTQriCYb35boLbvKcTYS/zC
   AQWPIIgvS5CH07Kef/FslI2QA+hkIIHg5i+FYb7oREFQW7IUTCShMg97w
   T6qBdwEjhrJQcGW49rw8/ptR5HRRZnGXtBOUb0zdt/zeMv6aGAkXf5Kgw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403651428"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="403651428"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858664356"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="858664356"
Received: from sandrew-mobl2.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:02:33 -0700
Message-ID: <6e282177-8084-78f8-3650-f9423d27f859@intel.com>
Date:   Wed, 29 Mar 2023 15:02:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 20/21] cxl: Export sysfs attributes for memory device
 QTG ID
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995356611.2857312.4634198260468536572.stgit@djiang5-mobl3>
 <6424b3e14b1ac_c722294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6424b3e14b1ac_c722294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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



On 3/29/23 2:55 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Export qtg_id sysfs attributes for the CXL memory device. The QTG ID
>> should show up as /sys/bus/cxl/devices/memX/qtg_id. The QTG ID is
>> retrieved via _DSM after supplying the caluclated bandwidth and latency
>> for the entire CXL path from device to the CPU. This ID is used to match
>> up to the root decoder QTG ID to determine which CFMWS the memory range
>> of a hotplugged CXL mem device should be assigned under.
>>
>> While there may be multiple DSMAS exported by the device CDAT, the driver
>> will only expose the first QTG ID in sysfs for now. In the future when
>> multiple QTG IDs are necessary, they can be exposed. [1]
>>
>> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
>>   drivers/cxl/core/memdev.c               |   15 +++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 471ac9a37078..a018f0a21aca 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -58,6 +58,17 @@ Description:
>>   		affinity for this device.
>>   
>>   
>> +What:		/sys/bus/cxl/devices/memX/qtg_id
> 
> Oh, I was still thinking there would be a qtg_id per partition type,
> just not a multiple qtg_ids per partition type until it is clear that
> those are something hardware vendors are actually going to ship, but I
> expect a DSMAS per partition type will be common.

Oh ok. I guess I really need to save previous changes. Time to revert. I 
hope I still have the old cxl cli changes as well. :(

> 
> So I was expecting:
> 
> /sys/bus/cxl/devices/memX/{ram,pmem}/qtg_id
> 
> ...and when the DCD patches land that expands to:
> 
> /sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_id
> 
> If someone builds a device with multiple performance classes per
> partition then it would become:
> 
> /sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_id
> /sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_id[1..n]
> /sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_range/
> /sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_range[1..n]/
> 
> ...where I am using CXL 3.0 Figure 9-24 "DCD DPA Space Example" as the
> delineation of the possible partition types.
