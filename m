Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAD6E9D79
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 22:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjDTUxx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjDTUxv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 16:53:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A07B5BBD;
        Thu, 20 Apr 2023 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682024021; x=1713560021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cvj+ILNYZGWWXN3xG7OpWQeyQLsRNeVXfrmyUktW864=;
  b=JiSBi6WXepj21D7lKIufwP1Cn9OSV7QUfIvhqQwy20bx9gF1gXSM4pUN
   WmHJLpmlF5LtMYiu6dM5ynBlj7YPeXy4FTbTd2c9YSmVzCEil3/yVpSx5
   Pm2trpt7RfaZ678lmJ4SMEqr+/5vvExABjiD1CUGLQCMuMH6y6Ha6cd3z
   EOOMchvQYA/B8sg7b6+0BHy9DCQKSi2Ogax92McHOocUYEuexjty5bk3t
   LRMetOfY7bvnvykMdf0EVXdC3v+e9X9+FSEFngP/U1/H4W6ensfZAwzwE
   0B7eG+jxVQzr59cbc6gMoTgbzf1H/Jh/vjgdMT0XCN1phDND8dHVd4Xt4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334717770"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="334717770"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 13:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="669489158"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="669489158"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.11.57]) ([10.212.11.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 13:53:40 -0700
Message-ID: <12596980-1ceb-0427-cf5f-a61e0333de7d@intel.com>
Date:   Thu, 20 Apr 2023 13:53:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 01/23] cxl: Export QTG ids from CFMWS to sysfs
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193566778.1178687.6009753728429815467.stgit@djiang5-mobl3>
 <20230420095152.00007ce3@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230420095152.00007ce3@Huawei.com>
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



On 4/20/23 1:51 AM, Jonathan Cameron wrote:
> On Wed, 19 Apr 2023 13:21:07 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Export the QoS Throttling Group ID from the CXL Fixed Memory Window
>> Structure (CFMWS) under the root decoder sysfs attributes.
>> CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)
>>
>> cxl cli will use this QTG ID to match with the _DSM retrieved QTG ID for a
>> hot-plugged CXL memory device DPA memory range to make sure that the DPA range
>> is under the right CFMWS window.
>>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
> 
> Bikeshedding alert:
> 
> Why not just call it qtg?  What does the _id add?
> 
> I don't really care either way...
> 
> LGTM
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One (more) completely trivial comment inline.
> 
> Jonathan
> 
>> ---
>> v4:
>> - Change kernel version for documentation to v6.5
>> v2:
>> - Add explanation commit header (Jonathan)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
>>   drivers/cxl/acpi.c                      |    3 +++
>>   drivers/cxl/core/port.c                 |   14 ++++++++++++++
>>   drivers/cxl/cxl.h                       |    3 +++
>>   4 files changed, 29 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 3acf2f17a73f..bd2b59784979 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -309,6 +309,15 @@ Description:
>>   		(WO) Write a string in the form 'regionZ' to delete that region,
>>   		provided it is currently idle / not bound to a driver.
>>   
>> +What:		/sys/bus/cxl/devices/decoderX.Y/qtg_id
>> +Date:		Jan, 2023
>> +KernelVersion:	v6.5
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Shows the QoS Throttling Group ID. The QTG ID for a root
>> +		decoder comes from the CFMWS structure of the CEDT. A value of
>> +		-1 indicates that no QTG ID was retrieved. The QTG ID is used as
>> +		guidance to match against the QTG ID of a hot-plugged device.
>>   
>>   What:		/sys/bus/cxl/devices/regionZ/uuid
>>   Date:		May, 2022
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 7e1765b09e04..abc24137c291 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -289,6 +289,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>>   			}
>>   		}
>>   	}
>> +
>> +	cxld->qtg_id = cfmws->qtg_id;
>> +
>>   	rc = cxl_decoder_add(cxld, target_map);
>>   err_xormap:
>>   	if (rc)
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 4d1f9c5b5029..024d4178f557 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -276,6 +276,16 @@ static ssize_t interleave_ways_show(struct device *dev,
>>   
>>   static DEVICE_ATTR_RO(interleave_ways);
>>   
>> +static ssize_t qtg_id_show(struct device *dev,
>> +			   struct device_attribute *attr, char *buf)
>> +{
>> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>> +
>> +	return sysfs_emit(buf, "%d\n", cxld->qtg_id);
>> +}
>> +
> 
> No blank line here would be more consistent with local style (based on
> a really quick look).

I see it going both ways in that file. But I'll delete the line.

> 
>> +static DEVICE_ATTR_RO(qtg_id);
>> +
>>   static struct attribute *cxl_decoder_base_attrs[] = {
>>   	&dev_attr_start.attr,
>>   	&dev_attr_size.attr,
>> @@ -295,6 +305,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>>   	&dev_attr_cap_type2.attr,
>>   	&dev_attr_cap_type3.attr,
>>   	&dev_attr_target_list.attr,
>> +	&dev_attr_qtg_id.attr,
>>   	SET_CXL_REGION_ATTR(create_pmem_region)
>>   	SET_CXL_REGION_ATTR(create_ram_region)
>>   	SET_CXL_REGION_ATTR(delete_region)
>> @@ -1625,6 +1636,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>>   	}
>>   
>>   	atomic_set(&cxlrd->region_id, rc);
>> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>>   	return cxlrd;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
>> @@ -1662,6 +1674,7 @@ struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>>   
>>   	cxld = &cxlsd->cxld;
>>   	cxld->dev.type = &cxl_decoder_switch_type;
>> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>>   	return cxlsd;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
>> @@ -1694,6 +1707,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>>   	}
>>   
>>   	cxld->dev.type = &cxl_decoder_endpoint_type;
>> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>>   	return cxled;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 044a92d9813e..278ab6952332 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -300,6 +300,7 @@ enum cxl_decoder_type {
>>    */
>>   #define CXL_DECODER_MAX_INTERLEAVE 16
>>   
>> +#define CXL_QTG_ID_INVALID	-1
>>   
>>   /**
>>    * struct cxl_decoder - Common CXL HDM Decoder Attributes
>> @@ -311,6 +312,7 @@ enum cxl_decoder_type {
>>    * @target_type: accelerator vs expander (type2 vs type3) selector
>>    * @region: currently assigned region for this decoder
>>    * @flags: memory type capabilities and locking
>> + * @qtg_id: QoS Throttling Group ID
>>    * @commit: device/decoder-type specific callback to commit settings to hw
>>    * @reset: device/decoder-type specific callback to reset hw settings
>>   */
>> @@ -323,6 +325,7 @@ struct cxl_decoder {
>>   	enum cxl_decoder_type target_type;
>>   	struct cxl_region *region;
>>   	unsigned long flags;
>> +	int qtg_id;
>>   	int (*commit)(struct cxl_decoder *cxld);
>>   	int (*reset)(struct cxl_decoder *cxld);
>>   };
>>
>>
> 
