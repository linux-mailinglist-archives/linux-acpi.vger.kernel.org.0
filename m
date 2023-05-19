Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78069709027
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjESHKP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESHKN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 03:10:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A85BE4A;
        Fri, 19 May 2023 00:10:11 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QMyY40KWHzqSZG;
        Fri, 19 May 2023 15:05:44 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 15:10:06 +0800
Subject: Re: [PATCH 3/3] Documentation/arm64: Update ACPI tables from BBR
To:     Robin Murphy <robin.murphy@arm.com>,
        Jose Marinho <jose.marinho@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
References: <20230518105202.451739-1-jose.marinho@arm.com>
 <20230518105202.451739-4-jose.marinho@arm.com>
 <0969894f-d653-482c-f043-2a085ee3b404@huawei.com>
 <e9918d6e-ca5c-5a3a-6ff4-27acf7f73b30@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <dd0114f5-2e9c-40ea-8722-93fdf3f57b87@huawei.com>
Date:   Fri, 19 May 2023 15:10:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e9918d6e-ca5c-5a3a-6ff4-27acf7f73b30@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023/5/18 21:40, Robin Murphy wrote:
> On 2023-05-18 13:07, Hanjun Guo wrote:
>> Hi Jose,
>>
>> On 2023/5/18 18:52, Jose Marinho wrote:
>>> The BBR specification requires (or conditionally requires) a set of ACPI
>>> tables for a proper working system.
>>> This commit updates:
>>> - the list of ACPI tables to reflect the contents of
>>> BBR version 2.0 (see https://developer.arm.com/documentation/den0044/g).
>>> - the list of ACPI tables in acpi_object_usage. This last update ensures
>>> that both files remain coherent.
>>
>> Thanks for the update, some comments inline.
>>
>>>
>>> Signed-off-by: Jose Marinho <jose.marinho@arm.com>
>>> Reviewed-by: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
>>> ---
>>>   Documentation/arm64/acpi_object_usage.rst | 81 +++++++++++++++++++++--
>>>   Documentation/arm64/arm-acpi.rst          | 71 +++++++++++++++++---
>>>   2 files changed, 139 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/Documentation/arm64/acpi_object_usage.rst 
>>> b/Documentation/arm64/acpi_object_usage.rst
>>> index 484ef9676653..1da22200fdf8 100644
>>> --- a/Documentation/arm64/acpi_object_usage.rst
>>> +++ b/Documentation/arm64/acpi_object_usage.rst
>>> @@ -17,16 +17,37 @@ For ACPI on arm64, tables also fall into the 
>>> following categories:
>>>          -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>>> -       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, 
>>> IBFT,
>>> -          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, 
>>> SPMI, SRAT,
>>> -          STAO, TCPA, TPM2, UEFI, XENV
>>> +       -  Optional: AGDI, BGRT, CEDT, CPEP, CSRT, DBG2, DRTM, ECDT, 
>>> FACS, FPDT,
>>> +          HMAT, IBFT, IORT, MCHI, MPAM, MPST, MSCT, NFIT, PMTT, 
>>> PPTT, RASF, SBST,
>>> +          SDEI, SLIT, SPMI, SRAT, STAO, TCPA, TPM2, UEFI, XENV
>>> -       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT, 
>>> MSDM, OEMx,
>>> -          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>>> +       -  Not supported: AEST, APMT, BOOT, DBGP, DMAR, ETDT, HPET, 
>>> IVRS, LPIT,
>>
>> AEST is ARM Error Source Table, and it can be used for ARM platforms, so
>> I thinsk AEST is not belong to "Not supportted", "Optional" instead.
> 
> Can you point to the code in Linux which does anything with AEST, 
> optionally or otherwise? ;)
>> and APMT is the same.
>>
>>> +          MSDM, OEMx, PDTT, PSDT, RAS2, RSDT, SLIC, WAET, WDAT, 
>>> WDRT, WPBT
>>
>> PDTT and RAS2 are now used for ARM too, please move it to Optional :)
> 
> Ditto; as stated in arm-acpi.rst this is Linux documentation covering 
> the interaction between Linux and ACPI. It is not some kind of generic 

Hmm, let me see...

OK, I checked the arm-acpi.rst, it is saying:

"Detailed expectations for ACPI tables and object are listed in the file
Documentation/arm64/acpi_object_usage.rst."

So if I remember correctly, it is the guidance of ACPI tables and
methods usage on arm64, to align with the BBR.

> ACPI-on-Arm guidance whitepaper. If and when Linux actually supports 
> these tables in the sense of meaningfully consuming them, that is when 
> we can document such support.

If this is the case, we don't need categories of "Required",
"Recommmened" and etc.

Thanks
Hanjun
