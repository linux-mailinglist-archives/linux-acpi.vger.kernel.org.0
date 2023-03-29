Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F09F6CF57C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjC2Vo3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 17:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjC2Vo3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 17:44:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9F49CE;
        Wed, 29 Mar 2023 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680126266; x=1711662266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nl2eZ8371bZShe5BwqT6h6KQFXiLhTzoBeMhYRfUJps=;
  b=Gt90IOKSSOJeqPbsWzjejpP3WSIC6oeYCiQTwrjG0wpA7/wN2gLLpOXd
   //KT6L0FwhgKjmWE00fGjMeXB5jzju7nfjZQaru+FxnwGk8tU/W8VNbpT
   acLIHNvzx23taNQUiVHWxM4RPiZfFQMJ3UML0rUca7/xpMsyo8q+SE1Yu
   oCK7FwwBVv9c2+1o0mosGU6XghH1p/pw1oBS5d0jBbRVjFJHrY4D++uY0
   FyWwpea7cwVlls5mHNvnI4/lB1HpuqSBjjENTyBb9h54uj8mLoISHUXhi
   4+XFcI2WcWuraHESbRvaluDoGQ1CeyPd7njiHri+Bvni2F87U9u0obu6H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="324925159"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="324925159"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="661757611"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="661757611"
Received: from sandrew-mobl2.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:44:25 -0700
Message-ID: <d8fd7955-32c7-58ce-5498-1208643c8ca5@intel.com>
Date:   Wed, 29 Mar 2023 14:44:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 20/21] cxl: Export sysfs attributes for memory device
 QTG ID
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995356611.2857312.4634198260468536572.stgit@djiang5-mobl3>
 <ZCOT9DS9/PhVGS4R@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZCOT9DS9/PhVGS4R@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/28/23 6:27 PM, Alison Schofield wrote:
> On Mon, Mar 27, 2023 at 02:46:06PM -0700, Dave Jiang wrote:
>> Export qtg_id sysfs attributes for the CXL memory device. The QTG ID
>> should show up as /sys/bus/cxl/devices/memX/qtg_id. The QTG ID is
>> retrieved via _DSM after supplying the caluclated bandwidth and latency
> 
> calculated

Thanks. I'm running codespell with checkpatch.pl and not sure why these 
things aren't being picked up.

> 
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
>> +Date:		March, 2024
>> +KernelVersion:	v6.4
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Show the first QoS Throttling Group ID for the device.
>> +		The ID is used to match against the CFMWS (root decoder)
>> +		QTG ID so that the memory range under a hot-plugged device
>> +		is assigned under the appropriate CFMWS.
> 
> Some of the language in the cover letter seemed more descriptive, but
> I guess it's a bit squishy to me. (ie. 'some guidance' and 'appropriate')
> 
> Would a spec link be useful here?

Hmmm...I've not seen anywhere in the CXL spec that provides a complete 
picture of this. The memory device software developer's guide provids 
the most details I suppose. Maybe I can reference that here.

> 
> Alison
> 
>> +
>> +
>>   What:		/sys/bus/cxl/devices/*/devtype
>>   Date:		June, 2021
>>   KernelVersion:	v5.14
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index d2605fc39240..974eff833edd 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -106,12 +106,27 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_RO(numa_node);
>>   
>> +static ssize_t qtg_id_show(struct device *dev, struct device_attribute *attr,
>> +			   char *buf)
>> +{
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct qos_prop_entry *qos;
>> +
>> +	if (list_empty(&cxlmd->qos_list))
>> +		return 0;
>> +
>> +	qos = list_first_entry(&cxlmd->qos_list, struct qos_prop_entry, list);
>> +	return sysfs_emit(buf, "%u\n", qos->qtg_id);
>> +}
>> +static DEVICE_ATTR_RO(qtg_id);
>> +
>>   static struct attribute *cxl_memdev_attributes[] = {
>>   	&dev_attr_serial.attr,
>>   	&dev_attr_firmware_version.attr,
>>   	&dev_attr_payload_max.attr,
>>   	&dev_attr_label_storage_size.attr,
>>   	&dev_attr_numa_node.attr,
>> +	&dev_attr_qtg_id.attr,
>>   	NULL,
>>   };
>>   
>>
>>
