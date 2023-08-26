Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70427893D5
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Aug 2023 06:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjHZEhk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Aug 2023 00:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjHZEhe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Aug 2023 00:37:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08517173F;
        Fri, 25 Aug 2023 21:37:31 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXkXV6YXxzfbw8;
        Sat, 26 Aug 2023 12:35:54 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 12:37:28 +0800
Message-ID: <ffd6004f-f30c-8bc3-096b-e3bce93ee864@huawei.com>
Date:   Sat, 26 Aug 2023 12:37:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] ACPI: NFIT: Fix incorrect calculation of idt size
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <rafael@kernel.org>
CC:     <liwei391@huawei.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230817091124.915407-1-liaoyu15@huawei.com>
 <a29d4ef5-fba2-b1f4-9c48-5c125dbe0e27@huawei.com>
 <789c18d7-8227-4dfc-438a-2959448f9547@intel.com>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <789c18d7-8227-4dfc-438a-2959448f9547@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023/8/25 23:09, Dave Jiang wrote:
> 
> 
> On 8/24/23 20:59, Yu Liao wrote:
>> Hi,
>>
>> A kindly ping, any comment on this?
> 
> You can add my review tag to both of your patches in the series. Please cc
> nvdimm@lists.linux.dev next time as well for nfit. Thanks!

Thank you for the review. I'll make the suggested changes and send you
the V2.

Best regards,
Yu
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
>>
>> Best regards,
>> Yu
>>
>>
>> On 2023/8/17 17:11, Yu Liao wrote:
>>> acpi_nfit_interleave's field 'line_offset' is switched to flexible array [1],
>>> but sizeof_idt() still calculates the size in the form of 1-element array.
>>>
>>> Therefore, fix incorrect calculation in sizeof_idt().
>>>
>>> [1] https://lore.kernel.org/lkml/2652195.BddDVKsqQX@kreacher/
>>>
>>> Fixes: 2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace
>>> 1-element array with flexible array")
>>> Cc: stable@vger.kernel.org # v6.4+
>>> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
>>> ---
>>>   drivers/acpi/nfit/core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>>> index 07204d482968..305f590c54a8 100644
>>> --- a/drivers/acpi/nfit/core.c
>>> +++ b/drivers/acpi/nfit/core.c
>>> @@ -855,7 +855,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
>>>   {
>>>       if (idt->header.length < sizeof(*idt))
>>>           return 0;
>>> -    return sizeof(*idt) + sizeof(u32) * (idt->line_count - 1);
>>> +    return sizeof(*idt) + sizeof(u32) * idt->line_count;
>>>   }
>>>     static bool add_idt(struct acpi_nfit_desc *acpi_desc,
>>

