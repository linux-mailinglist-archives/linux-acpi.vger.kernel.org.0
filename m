Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2C710B50
	for <lists+linux-acpi@lfdr.de>; Thu, 25 May 2023 13:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjEYLnx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 May 2023 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbjEYLnv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2023 07:43:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E90AA;
        Thu, 25 May 2023 04:43:40 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRmNV2TjhzYslK;
        Thu, 25 May 2023 19:41:30 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 19:43:38 +0800
Subject: Re: [PATCH 3/3] Documentation/arm64: Update ACPI tables from BBR
To:     Jose Marinho <Jose.Marinho@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        nd <nd@arm.com>
References: <20230518105202.451739-1-jose.marinho@arm.com>
 <20230518105202.451739-4-jose.marinho@arm.com>
 <0969894f-d653-482c-f043-2a085ee3b404@huawei.com>
 <e9918d6e-ca5c-5a3a-6ff4-27acf7f73b30@arm.com>
 <dd0114f5-2e9c-40ea-8722-93fdf3f57b87@huawei.com>
 <3dcc08c8-f8e8-69d0-7ad8-e8938f4f2cca@arm.com>
 <DBBPR08MB6012B565A6B819C2506E62BF88439@DBBPR08MB6012.eurprd08.prod.outlook.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6a6c2018-6e90-e11a-113d-a0459e5fcb1f@huawei.com>
Date:   Thu, 25 May 2023 19:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DBBPR08MB6012B565A6B819C2506E62BF88439@DBBPR08MB6012.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023/5/22 18:55, Jose Marinho wrote:
> Hi Hanjun, Robin,
> 
>> On 2023-05-19 08:10, Hanjun Guo wrote:
>>> On 2023/5/18 21:40, Robin Murphy wrote:
>>>> On 2023-05-18 13:07, Hanjun Guo wrote:
>>>>> Hi Jose,
>>>>>
>>>>> On 2023/5/18 18:52, Jose Marinho wrote:
>>>>>> The BBR specification requires (or conditionally requires) a set of
>>>>>> ACPI tables for a proper working system.
>>>>>> This commit updates:
>>>>>> - the list of ACPI tables to reflect the contents of BBR version
>>>>>> 2.0 (seehttps://developer.arm.com/documentation/den0044/g).
>>>>>> - the list of ACPI tables in acpi_object_usage. This last update
>>>>>> ensures that both files remain coherent.
>>>>> Thanks for the update, some comments inline.
>>>>>
>>>>>> Signed-off-by: Jose Marinho<jose.marinho@arm.com>
>>>>>> Reviewed-by: Samer El-Haj-Mahmoud <Samer.El-Haj-
>> Mahmoud@arm.com>
>>>>>> ---
>>>>>>    Documentation/arm64/acpi_object_usage.rst | 81
>>>>>> +++++++++++++++++++++--
>>>>>>    Documentation/arm64/arm-acpi.rst          | 71
>>>>>> +++++++++++++++++---
>>>>>>    2 files changed, 139 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/arm64/acpi_object_usage.rst
>>>>>> b/Documentation/arm64/acpi_object_usage.rst
>>>>>> index 484ef9676653..1da22200fdf8 100644
>>>>>> --- a/Documentation/arm64/acpi_object_usage.rst
>>>>>> +++ b/Documentation/arm64/acpi_object_usage.rst
>>>>>> @@ -17,16 +17,37 @@ For ACPI on arm64, tables also fall into the
>>>>>> following categories:
>>>>>>           -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>>>>>> -       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS,
>>>>>> FPDT, IBFT,
>>>>>> -          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT,
>>>>>> SPMI, SRAT,
>>>>>> -          STAO, TCPA, TPM2, UEFI, XENV
>>>>>> +       -  Optional: AGDI, BGRT, CEDT, CPEP, CSRT, DBG2, DRTM,
>>>>>> +ECDT,
>>>>>> FACS, FPDT,
>>>>>> +          HMAT, IBFT, IORT, MCHI, MPAM, MPST, MSCT, NFIT, PMTT,
>>>>>> PPTT, RASF, SBST,
>>>>>> +          SDEI, SLIT, SPMI, SRAT, STAO, TCPA, TPM2, UEFI, XENV
>>>>>> -       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT,
>>>>>> MSDM, OEMx,
>>>>>> -          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>>>>>> +       -  Not supported: AEST, APMT, BOOT, DBGP, DMAR, ETDT, HPET,
>>>>>> IVRS, LPIT,
>>>>> AEST is ARM Error Source Table, and it can be used for ARM
>>>>> platforms, so I thinsk AEST is not belong to "Not supportted", "Optional"
>> instead.
>>>> Can you point to the code in Linux which does anything with AEST,
>>>> optionally or otherwise?;)
>>>>> and APMT is the same.
>>>>>
>>>>>> +          MSDM, OEMx, PDTT, PSDT, RAS2, RSDT, SLIC, WAET, WDAT,
>>>>>> WDRT, WPBT
>>>>> PDTT and RAS2 are now used for ARM too, please move it to Optional
>>>>> :)
> The 6.3 kernel does not yet have code consuming either table.
> 
> Perhaps the categories {"Required", "Recommended", "Optional", "Not supported"}
> listed in Documentation/arm64/acpi_object_usage.rst should be defined.
> 
> My opinion (which may be unaligned with the original intent behind the categories) is, If a table
> is consumed by kernel code, then it is supported, i.e. in {"Required", "Recommended", "Optional"}.
> Otherwise, the table is "Not supported".
> 
>>>> Ditto; as stated in arm-acpi.rst this is Linux documentation covering
>>>> the interaction between Linux and ACPI. It is not some kind of
>>>> generic
>>> Hmm, let me see...
>>>
>>> OK, I checked the arm-acpi.rst, it is saying:
>>>
>>> "Detailed expectations for ACPI tables and object are listed in the
>>> file Documentation/arm64/acpi_object_usage.rst."
>>>
>>> So if I remember correctly, it is the guidance of ACPI tables and
>>> methods usage on arm64, to align with the BBR.
>> "The purpose of this document is to describe the interaction between ACPI
>> and Linux only, on an ARMv8 system -- that is, what Linux expects of ACPI
>> and what ACPI can expect of Linux."
>>
>> I don't see how it could get much clearer than that. Yes, phrasing like "ACPI
>> on arm64" is used elsewhere, but remember that in context "arm64"
>> means "AArch64 Linux".
>>
>>>> ACPI-on-Arm guidance whitepaper. If and when Linux actually supports
>>>> these tables in the sense of meaningfully consuming them, that is
>>>> when we can document such support.
>>> If this is the case, we don't need categories of "Required",
>>> "Recommmened" and etc.
>> Certainly the distinction between required and optional is significant and
>> useful, since Linux may fail to boot at all if a required table is missing. I'd
>> agree I can't really make sense of the "recommended"
>> category though - it's not like firmware could make up RAS support if the
>> hardware doesn't have it, and whether SSDTs are appropriate or not seems
>> to depend on the fundamental design of the system, rather than being
>> something an OS should dictate :/
>>
> I agree with Robin that it isn’t clear what "Recommended" versus "Optional" signifies.
> Maybe the distinction should be better discussed, and we can make those clarifications in a separate change?

Looks good to me.

Thanks
Hanjun
