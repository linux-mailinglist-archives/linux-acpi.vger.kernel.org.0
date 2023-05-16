Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD9705047
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 16:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjEPOOJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjEPOOI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 10:14:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB99AB;
        Tue, 16 May 2023 07:14:02 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QLJ5504b1zTkbX;
        Tue, 16 May 2023 22:09:12 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 22:13:59 +0800
Message-ID: <f0733521-2557-fdaf-e59b-b10d515c487c@huawei.com>
Date:   Tue, 16 May 2023 22:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <huangdaode@huawei.com>,
        <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <20230425103040.znv66k364ant6klq@bogus>
 <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
 <20230425131918.5tf5vot4h7jf54xk@bogus>
 <db6c713c-f99c-fa3f-8d38-9a5d50889cc2@huawei.com>
 <20230515130807.pdvx7bxwjkfdsmsr@bogus>
 <aa5b1919-74c6-1f97-78af-ab5f0904c3ce@huawei.com>
 <20230516122931.il4ai7fyxdo5gsff@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230516122931.il4ai7fyxdo5gsff@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sudeep,

Thanks for your reply.


在 2023/5/16 20:29, Sudeep Holla 写道:
> On Tue, May 16, 2023 at 03:35:54PM +0800, lihuisong (C) wrote:
>> 在 2023/5/15 21:08, Sudeep Holla 写道:
>>> On Thu, May 04, 2023 at 09:16:16PM +0800, lihuisong (C) wrote:
>>>> I'm tring to use CRS with GAS to report PCC channel ID and get other
>>>> informations driver need by address.
>>> OK you had pcc-chan-id pcc-type and device-flags in the DSD style bindings
>>> to begin with. I haven't understood device-flags here so can't comment on
>>> that.
>> We want to use the 'device-flags' to report some information by bit.
> Please give more details, until then NACK for the idea.
ok.
>
>> Currently, this driver requests PCC channel and use type2 to communicate
>> with firmware.
> OKAY...
>
>> But, if some platform support type3 and PCC Operation Region, driver can
>> choice this method to communicate with firmware.
>> So firmware and driver have to use this flag to make compatibility.
>>
> I would rather add such things to the spec if it is any sort of limitation
> with the current specification.
Agreed. but I think there isn't any limitation for this with the current 
specification.
There is no strong connection between PCC Operation Region and type3.
Driver can also use PCC to communicate with platform even if the type is 
type3.
In other words, it depends on driver's choice.

Here, we want to use one bit in device-flags to indicates that
firmware and driver use PCC operation Region on feature platform instead 
of only using PCC.

Sorry, I have to admit that the implementation of this driver about this 
really needs
to be optimized to make it more clear.
>
>>>> I found a way to obtain the generic register information according to
>>>> "Referencing the PCC address space" in ACPI spec.
>>>> And driver also get the PCC generic register information successfully.
>>>>
>>> Can you elaborate ? I assume by that you must be able to get pcc-chan-id
>> Yes，driver can get pcc-chan-id by below register.
>>
>> Register (PCC, RegisterBitWidth, RegisterBitOffset, RegisterAddress, AccessSize)
>>
> Good to know.
>
>>> right ? You must not need pcc-type as the pcc mailbox driver must handle
>>> the type for you. If not, we may need to fix or add any missing support.
>> Yes, PCC driver doesn't support it currently. And aother patch [1] we've
>> been talking about does it.
>> If it is applied to kernel, we can drop this pcc-type here.
>>
>> [1] https://patchwork.kernel.org/project/linux-acpi/patch/20230423110335.2679-2-lihuisong@huawei.com/
> OK then we are good, no need for pcc-type then ?
If driver may support more PCC types, the type also need be known by driver.
Because not all types have the same header size.
The PCC type can be obtained from the PCCT by requesting PCC channel.
 From this point, this pcc type here is unnecessary, right?
>
>>>> But I don't know how to set and use the address in PCC register.
>>> It must be same as what you would have specified in you new bindings
>>> under "pcc-chan-id". I am confused as you say you were able to get the
>>> PCC generic register information successfully but you still claim you
>>> don't know how to set or use the address.
>> My confusion about this address is mentioned below.
> OK
>
>>>> Where should this address come from?
>>>> It seems that ACPI spec is not very detailed about this.
>>>> Do you have any suggestions?
>>>>
>>> I am afraid, I don't have any as I am failing to understand the exact issue
>>> you are facing.
>>>
>>> Let me try to ask the question explicity here:
>>>
>>> If you are just referring to just the <RegisterAddress,> in
>>>
>>> Register (PCC, RegisterBitWidth, RegisterBitOffset, RegisterAddress, AccessSize)
>> Yeah, this is what I'm using.
>>> then,
>>>
>>> RegisterAddress is usually the offset in the comms address associated with
>> Communication subspace in share memory of PCC subspace?
>>> the PCC subspace ID specified in AccessSize. Yes the use of AccessSize for
>>> the PCC subspace ID is bit confusing though.
>>>
>>> You can either list all the registers with _CRS individually or the driver
>> List all the registers as following way?
>> Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>> {
>>      QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
>> NonCacheable, ReadWrite,
>>          0x0000000000000000, // Granularity
>>          0x0000000098190000, // Range Minimum
>>          0x000000009819FFFF, // Range Maximum
>>          0x0000000000000000, // Translation Offset
>>          0x0000000000010000, // Length
>>          ,, , AddressRangeMemory, TypeStatic)
>> })
> Not sure if you can use QWordMemory here TBH.
Above way is what you say?
>
>>> can just use the PCC subspace ID in AccessSize and keep RegisterAddress = 0
>>> but access individual offset based on its own knowledge. I haven't seen the
>> Following words come from ACPI spec.
>> -->
>> As an example, the following resource template refers to the feld occupying
>> bits 8 through 15 at address 0x30 in PCC
>> subspace 9:
>> ResourceTemplate()
>> {
>> Register (
>>      PCC, //AddressSpaceKeyword
>>      8, //RegisterBitWidth
>>      8, //RegisterBitOffset
>>     pcc 0x30, //RegisterAddress
>>      9 //AccessSize (subspace ID)
>>      )
>> }
>>
>> If the width of the address is 32bit, set RegisterAddress to 0,
>> RegisterBitOffset to 0 and set RegisterBitWidth to 64 here.
>> Driver can access to the ((void __iomem *)pcc_comm_addr + 0x8 + 0) and
>> ((void __iomem *)pcc_comm_addr + 0x8 + 4) address，right?
>> (This virtual address = pcc mapped address + header size + offset within PCC
>> subspace.)
> Yes that's my understanding. I remember seeing the driver is just fetching
> pcc-chan-id using DSD style key-value pair, which means you don't need
> any other info other than the PCC subspace/channel ID, just have address
> as 0.
But I still need the device-flags to report if use PCC operation Region.
If so I have to dig one address register from comm subspace, right?
>
> Also I see the driver uses type for just rejecting the type 3 PCCT. The
> question is will the driver probe and run on a platform with type 3 PCCT ?
Yes，some platforms may use PCC operation Region.
> If so what is the problem running on such a platform. I see it is useless
I didn't found any problems. But this driver should consider the 
possibility above mentioned.
> check in the driver and can be dropped. Also the comment above enum
> HCCS_DEV_FLAGS_INTR_B is confusing and  so is the way flags is used.
Thanks for you bringing it up.
Indeed, this HCCS_DEV_FLAGS_INTR_B is not good.
I'm going to replace it with PCC operation Region flag.
>
>>> full driver yet but I assuming that's how you would have used if you went with
>>> your DSD pcc-chan-id proposal.
>>>
>>>> On the other hand, we think that System Memory space + method can also
>>>> achieve above goal. What do you think of that?
>>> Again I don't understand what you mean by that.
>> Sorry, here is what I want to say.
>> -->
>> OperationRegion (CCS0, SystemMemory, 0x00000002081000CC, 0x04)
>> Field (CCS0, DWordAcc, NoLock, Preserve)
>> {
>>      HAU1,   32
>> }
>> OperationRegion (CCS1, SystemMemory, 0x0000000201070410, 0x04)
>> Field (CCS1, DWordAcc, NoLock, Preserve)
>> {
>>      HCGE,   32
>> }
>> Method (_DSM, 2, Serialized)  // _DSM: Device-Specific Method
>> {
>>      If ((Arg0 == ToUUID ("b06b81ab-0134-4a45-9b0c-483447b95fa7")))
>>      {
>>          If ((Arg1 == One))
>>          {
>>              Return (HAU1)
>>          }
>>
>>          Return (HCGE)
>>      }
>> }
>>
>> Driver can call _DSM method to get some information, such as pcc_chan_id and
>> device_flags.
> Big fat NACK for _DSM for the above purpose, please stop abusing _DSM or _DSD
> for such information which can be obtained with the existing _CRS.
Get it. Thanks.
> .
