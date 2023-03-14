Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51C46B8764
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Mar 2023 02:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCNBFr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Mar 2023 21:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCNBF1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Mar 2023 21:05:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F5486DDF;
        Mon, 13 Mar 2023 18:05:26 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PbFby02gXz17L0h;
        Tue, 14 Mar 2023 09:02:05 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 09:05:00 +0800
Message-ID: <a66f99e2-256c-e4e5-09aa-7c5c5d9ed0eb@huawei.com>
Date:   Tue, 14 Mar 2023 09:05:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] mailbox: pcc: Support shared interrupt for multiple
 subspaces
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <robbiek@xsightlabs.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-3-lihuisong@huawei.com>
 <20230301133626.gchca3fdaqijxwzq@bogus>
 <2a165476-2e96-17b1-a50b-c8749462e8a1@huawei.com>
 <20230302140216.m4m3452vexyrnuln@bogus>
 <020cc964-9938-7ebe-7514-125cd041bfcb@huawei.com>
 <20230303111407.zdgqdwqik4spnq2o@bogus>
 <718da090-bc58-0762-c901-cbbfc3b78d5f@huawei.com>
 <20230310201453.5fd3wv4ydarq5yin@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230310201453.5fd3wv4ydarq5yin@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


在 2023/3/11 4:14, Sudeep Holla 写道:
> On Sat, Mar 04, 2023 at 05:47:28PM +0800, lihuisong (C) wrote:
>> 在 2023/3/3 19:14, Sudeep Holla 写道:
>>> On Fri, Mar 03, 2023 at 02:33:49PM +0800, lihuisong (C) wrote:
>>>> Sorry for my resend. Because I found that my last reply email is not in the
>>>> thread of this patch. I guess it may be send failed.
>>>>
>>>> 在 2023/3/2 22:02, Sudeep Holla 写道:
>>>>> No. I meant a comment saying it is not need since only one transfer can occur
>>>>> at a time and mailbox takes care of locking. So chan_in_use can be accessed
>>>>> without a lock.
>>>> Got it. Agreed.
>>> Thanks
>> already modify this comment as below.
>>>>>> For types no need this flag, it is always hard to understand and redundant
>>>>>> design.
>>>>> But does it matter ? You can even support shared interrupt for type 1&2.
>>>> BTW, type 1 subspaces do not support a level triggered platform interrupt as
>>>> no method is provided to clear the interrupt.
>>> Agreed but there is no harm using the flag, you can add a comment that it is
>>> useful only if shared interrupts are supported. That will imply it is dummy
>>> for type 1. I am avoiding too many type unnecessary checks especially in IRQ
>>> handler.
>> Understood.
>>
>>>>> They support level interrupt, so we can add them too. I understand you can
>>>>> test only type 3, but this driver caters for all and the code must be generic
>>>>> as much as possible. I don't see any point in check for type 3 only. Only
>>>> I understand what you do.
>>>> But type 2 also supports the communication flow from OSPM to Platfrom.
>>>> In this case, this flag will get in the way of type 2.
>>>>
>>> How ?
>> It should be ok if all types except for type 3 do not check this flag in
>> interrupt handle.
>> Namely, these types consider it as dummy, and do not use it, anywhere,
>> Right?
>>>> Whether the interrupt belongs to a type2 channel is only determined by
>>>> the status field in Generic Communications Channel Shared Memory Region,
>>>> which is done in rx_callback of PCC client.
>>> Agreed, but do you see any issue using the flag even if it acts as dummy ?
>> I think it can work well if these types completely ignore this flag, like below.
>> what do you think?
>>
>> -->8
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index ecd54f049de3..14405e99193d 100755
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -92,6 +92,13 @@ struct pcc_chan_reg {
>>    * @error: PCC register bundle for the error status register
>>    * @plat_irq: platform interrupt
>>    * @type: PCC subspace type
>> + * @plat_irq_flags: platform interrupt flags
>> + * @chan_in_use: this flag is used just to check if the interrupt needs
>> + *             handling when it is shared. Since only one transfer can
>> occur
>> + *             at a time and mailbox takes care of locking, this flag can
>> be
>> + *             accessed without a lock. Note: the type only support the
>> + *             communication from OSPM to Platform, like type3, use it, and
>> + *             other types completely ignore it.
>>    */
>>   struct pcc_chan_info {
>>          struct pcc_mbox_chan chan;
>> @@ -102,6 +109,8 @@ struct pcc_chan_info {
>>          struct pcc_chan_reg error;
>>          int plat_irq;
>>          u8 type;
>> +       unsigned int plat_irq_flags;
>> +       bool chan_in_use;
>>   };
>>
>>   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>> @@ -225,6 +234,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>>          return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>>   }
>>
>> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
>> +{
>> +       return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
>> +               ACPI_LEVEL_SENSITIVE;
>> +}
>> +
>>   static bool pcc_chan_command_complete(struct pcc_chan_info *pchan,
>>                                        u64 cmd_complete_reg_val)
>>   {
>> @@ -277,6 +292,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>          int ret;
>>
>>          pchan = chan->con_priv;
>> +       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
>> +           !pchan->chan_in_use)
> I would have avoided the type check above but I understand your concern
> so let us keep it like this for now.
Thanks for your unstanding.
>
> Please submit non-RFC patch as some maintainers may not look at RFC.
I will send V2 ASAP.
>
