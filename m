Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807E26B57D6
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Mar 2023 03:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCKCg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Mar 2023 21:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKCg0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Mar 2023 21:36:26 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C779146256
        for <linux-acpi@vger.kernel.org>; Fri, 10 Mar 2023 18:36:24 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PYRmp0l3Kz17KL5;
        Sat, 11 Mar 2023 10:33:30 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 10:36:21 +0800
Subject: Re: [PATCH] acpi/arm64: Drop extra (struct resource)
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-acpi@vger.kernel.org>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linuxarm@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>
References: <20230301170938.9278-1-Jonathan.Cameron@huawei.com>
 <35c719be-e224-e3d5-3735-75df2d44f4aa@huawei.com>
Message-ID: <b669468c-34eb-a578-e606-9419674574e2@huawei.com>
Date:   Sat, 11 Mar 2023 10:36:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <35c719be-e224-e3d5-3735-75df2d44f4aa@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc Catalin, and Lorenzo's kernel.org email.

On 2023/3/2 9:54, Hanjun Guo wrote:
> On 2023/3/2 1:09, Jonathan Cameron wrote:
>> DEFINE_RES_IRQ() is a wrapper around the DEFINE_RES_NAMED()
>> macro which already has the (struct resource) for the compound
>> literal.
>>
>> Fixes warnings:
>>    CC      drivers/acpi/arm64/gtdt.o
>>    CHECK   drivers/acpi/arm64/gtdt.c
>> drivers/acpi/arm64/gtdt.c:355:19: warning: cast to non-scalar
>> drivers/acpi/arm64/gtdt.c:355:19: warning: cast from non-scalar
>>
>> Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be 
>> compound literal")
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/acpi/arm64/gtdt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index c0e77c1c8e09..24bd479de91f 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -352,7 +352,7 @@ static int __init gtdt_import_sbsa_gwdt(struct 
>> acpi_gtdt_watchdog *wd,
>>       }
>>       irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
>> -    res[2] = (struct resource)DEFINE_RES_IRQ(irq);
>> +    res[2] = DEFINE_RES_IRQ(irq);
>>       if (irq <= 0) {
>>           pr_warn("failed to map the Watchdog interrupt.\n");
>>           nr_res--;
>>
> 
> Looks good to me,
> 
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Catalin, would you mind picking this up for 6.3-rc? Andy also
reviewed this patch [1].

[1]: https://www.spinics.net/lists/arm-kernel/msg1051744.html

Thanks
Hanjun
