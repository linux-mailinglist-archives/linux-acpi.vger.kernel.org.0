Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375EF6CF590
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 23:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjC2Vtk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Vtj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 17:49:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D7BD;
        Wed, 29 Mar 2023 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680126578; x=1711662578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V35QH5Kgwe39OlsfWAGea/I8Kp1v5cOOlAp+co2ZWWQ=;
  b=nA1O0dquklzzvX/nfFU7x/K2GNf+fAt99qv18JB0N4DmmAMhH3iEckc7
   Y8RQLgxyRtCE28YR6CBmT8GBVzmcsblj/0eqr46L1bxKElJD4NCndse2m
   tU3Wbi0/Rzjmcy5ouo8qKQF3S8L1FLmGZCVwVYql0lw0pZOHwI1rwoW/7
   46BD4cN9cwjTRKvCe7HiKjnAfA0wq+SmRIePij7oM4unCcTtjNazSNJac
   wBjW094NCA0u1kaAq5AY5TTpDoqFjPUx6gxODvvSLrtJ1eat0m8iC9+h/
   JtNUjUfuEHvO7zFxrzKl/3XkhqouyUl8aNcaQd8lGh5w1ibMzoUaFmNH4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321393737"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="321393737"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753756468"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="753756468"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:49:38 -0700
Message-ID: <15382e13-e8a6-3f08-6389-313833684767@intel.com>
Date:   Wed, 29 Mar 2023 14:49:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 21/21] cxl/mem: Add debugfs output for QTG related data
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995357195.2857312.5279274659737251140.stgit@djiang5-mobl3>
 <ZCOQxrpyXNABVbsK@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZCOQxrpyXNABVbsK@aschofie-mobl2>
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



On 3/28/23 6:13 PM, Alison Schofield wrote:
> On Mon, Mar 27, 2023 at 02:46:11PM -0700, Dave Jiang wrote:
>> Add debugfs output to /sys/kernel/debug/cxl/memX/qtgmap
>> The debugfs attribute will dump out all the DSMAS ranges and the associated
>> QTG ID exported by the CXL device CDAT.
> 
> Do you want to document these?
> 
> The poison inject & clear inflight patchset documents in:
> Documentation/ABI/testing/debugfs-cxl

Sure. I'll take a look at your series to see what it should look like.

> 
> Alison
> 
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/mem.c |   16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 39c4b54f0715..bf2cb5a54a7f 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -45,6 +45,21 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>   	return 0;
>>   }
>>   
>> +static int cxl_mem_qtg_show(struct seq_file *file, void *data)
>> +{
>> +	struct device *dev = file->private;
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct qos_prop_entry *qos;
>> +
>> +	list_for_each_entry(qos, &cxlmd->qos_list, list) {
>> +		seq_printf(file, "%08llx-%08llx : QTG ID %u\n",
>> +			   qos->dpa_range.start, qos->dpa_range.end,
>> +			   qos->qtg_id);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>   				 struct cxl_dport *parent_dport)
>>   {
>> @@ -117,6 +132,7 @@ static int cxl_mem_probe(struct device *dev)
>>   
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>> +	debugfs_create_devm_seqfile(dev, "qtgmap", dentry, cxl_mem_qtg_show);
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>>   		return rc;
>>
>>
