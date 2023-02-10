Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871D6929B2
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 22:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjBJV5z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 16:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjBJV5x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 16:57:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA67DD22;
        Fri, 10 Feb 2023 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676066271; x=1707602271;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vPxF1JseRSs4g26NzPX6yAqIVHYMWM5zfMZbpc6cPmA=;
  b=ffdXpIX5PeC7qhusKogCYaQ1tyEcCXMSGoFzAUOW2LE/Gv2LBQAzygge
   R4ksVGTkZ3k9DC9Qb2elnBQyJMMAZfyD0UZNkCb0PV6DFriDZlKpHOqCQ
   TgZjYh9J9BIwUTTccvsNIJrndt63PWrK0AA7FVKrhctvz+UV/o6QiYUR4
   2vv8XUMYuZqlhwIV21O3MAn1eipX+pX5N20EKMfEf/fYvfCg2dJbeQo3C
   PW7Zj8UVdzP/6fVfGu2diRTHXVADo0Lt2IyDepKATqB1rsWLA5/uvxzqt
   obuKgNAfZeOVcswO9MKDxa7bSXE9ehdgXfNCDTbgm6yykJqV9I2SRROSE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330544827"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330544827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:57:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700616193"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700616193"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.190.133]) ([10.213.190.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:57:42 -0800
Message-ID: <368f047a-b722-504f-41de-41b3f10cdeb8@intel.com>
Date:   Fri, 10 Feb 2023 14:57:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 15/20] dax/hmem: Move HMAT and Soft reservation probe
 initcall level
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167602001107.1924368.11562316181038595611.stgit@dwillia2-xfh.jf.intel.com>
 <448c17f6-cdfa-9422-c35e-cf95e1b99604@intel.com>
In-Reply-To: <448c17f6-cdfa-9422-c35e-cf95e1b99604@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/10/23 2:53 PM, Dave Jiang wrote:
> 
> 
> On 2/10/23 2:06 AM, Dan Williams wrote:
>> In preparation for moving more filtering of "hmem" ranges into the
>> dax_hmem.ko module, update the initcall levels. HMAT range registration
>> moves to subsys_initcall() to be done before Soft Reservation probing,
>> and Soft Reservation probing is moved to device_initcall() to be done
>> before dax_hmem.ko initialization if it is built-in.
>>
>> Tested-by: Fan Ni <fan.ni@samsung.com>
>> Link: 
>> https://lore.kernel.org/r/167564542109.847146.10113972881782419363.stgit@dwillia2-xfh.jf.intel.com
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
>> ---
>>   drivers/acpi/numa/hmat.c  |    2 +-
>>   drivers/dax/hmem/Makefile |    3 ++-
>>   drivers/dax/hmem/device.c |    2 +-
>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 605a0c7053be..ff24282301ab 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -869,4 +869,4 @@ static __init int hmat_init(void)
>>       acpi_put_table(tbl);
>>       return 0;
>>   }
>> -device_initcall(hmat_init);
>> +subsys_initcall(hmat_init);
>> diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
>> index 57377b4c3d47..d4c4cd6bccd7 100644
>> --- a/drivers/dax/hmem/Makefile
>> +++ b/drivers/dax/hmem/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
>> +# device_hmem.o deliberately precedes dax_hmem.o for initcall ordering
>>   obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device_hmem.o
>> +obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
>>   device_hmem-y := device.o
>>   dax_hmem-y := hmem.o
>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>> index 903325aac991..20749c7fab81 100644
>> --- a/drivers/dax/hmem/device.c
>> +++ b/drivers/dax/hmem/device.c
>> @@ -104,4 +104,4 @@ static __init int hmem_init(void)
>>    * As this is a fallback for address ranges unclaimed by the ACPI HMAT
>>    * parsing it must be at an initcall level greater than hmat_init().
>>    */
>> -late_initcall(hmem_init);
>> +device_initcall(hmem_init);
>>
