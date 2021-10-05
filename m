Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2CB4223F2
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 12:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhJEKzX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 06:55:23 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:48462
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233514AbhJEKzW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 06:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRTACiTR7kRG6XtaEmNcJOzPcVqteUmabC44oVXCeY8cuXy/25/slIOjc12JtFI6bS/2hRvjoHwu52uvEiA+OKtqzvbBvgnA1rO/y9rxraCZA31DFYyHlgf0qc6uoXJKnU8KUkmcqjCMI1UGbfYq1ifgadS9LIrdy+slf5kRM9SqHT4Z8AZuWQmFnz1F8Wi1zra3r9xQNCvkoGBdq2ZNW4eySUOHDI+9as8t4cHpaGXPBEA1p+7MB4silNoLuV8hgcrbhiQKsub7Ul7jKc9DE7R4oZQcvOSJ/ytzVByv/YNGHCs6vmV75opxQAe+vwwT6WQgVKBoKtLA02sQja+TjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi3vmpZGMJeVTWi07dY1NYSnQz79LDUvL9bOVz8HlJE=;
 b=fvjwT4hs0d6X9xWJVjHisvCUeh+nwygyB8g/wEr3zWd5pa66cv9D8CZjcxnp3tUIIKriOWJZ8RHgliOtRXS46+/jIzklEeGzV9hXcnYseYHLjuJAun6fJ296rU1MaFLEWEX6boWHNL34g5t+MZIVQj1H92md4NQe+hyDP3+UFdAGhgHsVegcoJOWC2G5ZIxJ49B9YsnznCqTYCY2tbLc+HcZLPKdVI1Rvyzirba1Av/NKp0J1oXq77AB9qcLD2s5X9iPvD9/fLdiYt0pZpeAusnuI3N9HqmR7KZ6xf3B5kP3dXJCV0hJROIbpaRog4hET5z2A08Z+3EwRE/ErswrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi3vmpZGMJeVTWi07dY1NYSnQz79LDUvL9bOVz8HlJE=;
 b=PRadvTactyElZcqV+6MTSCtVjgvzkkbJgzWVZuCljl9A/2CeZVsrsy5FzCDOpGQbb1UiEWrZ87DDArpYKCHELJGMUpXSrlrLt0FOX0c+EIa2YnUtiuTZjiINAIMO7WO39WgcaqL0RA5uPm5wWDm0UuGNyplTfETrDLQScUXikAA=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3394.eurprd04.prod.outlook.com
 (2603:10a6:208:24::22) by AM0PR04MB4673.eurprd04.prod.outlook.com
 (2603:10a6:208:77::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Tue, 5 Oct
 2021 10:53:30 +0000
Received: from AM0PR0402MB3394.eurprd04.prod.outlook.com
 ([fe80::8434:dc2e:591e:e105]) by AM0PR0402MB3394.eurprd04.prod.outlook.com
 ([fe80::8434:dc2e:591e:e105%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 10:53:30 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Jon Nettleton <jon@solid-run.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
 <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
 <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
 <f3fc713365f7465e966aaed7cdd8870a@huawei.com>
 <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
 <e02a00a10ea3440dab1f9f9320de42ad@huawei.com>
 <CABdtJHuRB29Ufryvz=kCO7b_xgVb1D-7y3RQgCkKvSmshkkH1A@mail.gmail.com>
 <534a04a9fe9941b28670f00222f58ec3@huawei.com>
Message-ID: <f15c308e-5547-6005-e56d-0700246a75ef@nxp.com>
Date:   Tue, 5 Oct 2021 13:53:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <534a04a9fe9941b28670f00222f58ec3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:200:89::16) To AM0PR0402MB3394.eurprd04.prod.outlook.com
 (2603:10a6:208:24::22)
MIME-Version: 1.0
Received: from [192.168.1.105] (188.25.99.54) by AM4PR0202CA0006.eurprd02.prod.outlook.com (2603:10a6:200:89::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Tue, 5 Oct 2021 10:53:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c300340e-b4c0-4fef-2b07-08d987ee5e5c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4673:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4673EBF01712619902D9D4E8ECAF9@AM0PR04MB4673.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzbF3b1o0njDoiFD8G+thj11fOV8A1CoTpV0XwzPike0G5UxALG45NdqSV1Q5POUc5KnPplOdmbxFB/bv5AEaF3TGAD8jrljid5E5Q5gTygoqVuPhKwS9LegQw6e+ht9Wb4iWfeIBoHM8GGKabRuzn7bx3WZmARyPY4lBklFckFe7uqDn/scrPaktwESWjk68JMGAqCda7ujB3zmsQsqoNVKeQyKGYjlu/FpRBP97HB2CimpG68YRMFYv7chLHuXnjk7viIOt+V57LIuhGG7xQpGHEspJ08vjjuh3cWBKTp5k+wB+gLkSMMCktVwCn2oECtW81G4z0Pp//nJoAGCiNkOcx2BrAPz7w82ooBhMkY2cRGTJ/X4eKTwu/9HCOszSTrzLAsNv1OUtat91sczj++kUti9+RRIrY8JMngOiVpJSc5Q7ixr0aWUCMAgrfrj5nmw9zpyylNWM1Ou3dlqlk1vfbNOvZYM4x6jdAW3YmA980Q3AxY6Ogi5LtgIa64BiGXmnWsNHtWv8Nk3aXM6g4ZQqicV4XXaW+Ellw7ZDeOKaoObcTyFYe1afR5tQCjNXmF8aRwXHMEo7RqluhoQ0ibgzBFHAKDf+T3OqfpCHJlipJ+uqlkdMcoEP9m0dPfmaidms2vm+pLvqDkhBpO3/HSwum3365RvRoEJI3ZeRktEznx13MvHzYUkAnKkiSN2m09MSWJmZ2FiAyLT4UUHaBqThEtsPtAGOqrN6LClT73MMDUxxX770ppeVR2AKclwZ01B4iF2Ewo1v2xxPMY4tytUpAXFQ1jhGxW3s4/pVhieaqJU7XfS/xRidCFmjYSsFiGaB4Mkx8TVe1zgtHTI6MG5O6ck/x0oTB94UWBlCYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3394.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(83380400001)(8936002)(966005)(8676002)(7416002)(66556008)(66476007)(66946007)(44832011)(110136005)(508600001)(31696002)(2616005)(5660300002)(2906002)(52116002)(6486002)(86362001)(31686004)(26005)(186003)(956004)(316002)(36756003)(16576012)(4326008)(53546011)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9XMXVNNi90ZkRsSFhESFcvcFRFd0pTL0JhUFlWUkcyTDJiTk1lU0t5NnU4?=
 =?utf-8?B?bFk0MTIzMWt6Q3FKWWp0R1hmdmtzUGV6RXczSGxjRTNDYXNnZjkxdFhzaUNo?=
 =?utf-8?B?QVhnc1NWV1ZTQ0hjaXErMGg5Mjg5ZGZMSzZQbmNCVDNuMFNGQzFPbkl1cjU0?=
 =?utf-8?B?bGV5Z0M4cXpqOFdvblVkWWVmRG5mL3JoVmZRYW5lR3JsYkhwVDRqS0FlYzBD?=
 =?utf-8?B?VnJsemoxY05BVDBNSEdETTFpcUpIYmEveGJpVmZjM0dmekE4Z3l2TFhZZktm?=
 =?utf-8?B?RDltOVFsdWw5WHg5M3NQbGs4TjdSUlB0UW1vbUpKenR5U1EvTEhzRFZ2aGE1?=
 =?utf-8?B?ZWhjMEFYMEg3OXFUUXJBMm9TUDJhQ20rL1FzVndLWHloOTU5RkVtM0FINkYy?=
 =?utf-8?B?eS9nMGlndy9JcVRZbnZxdVRydGhxL09ZZmtEMENWcGlUckVTOVh4OEpLN0g1?=
 =?utf-8?B?TVNUb2VkRnJvb0prUVl4L0t0RVJCNGRjRG9NbmlWdTZmQ1pBS0FiRmkxU0Vt?=
 =?utf-8?B?TFQxNENweXhzMXVvaFpUb2NtTjBreGVKTExsYmxKK1VERjFmNUFKaVpYQWNw?=
 =?utf-8?B?RWxWQmtnUHR5Z1JYU1NzUUJ1ZkFOUE5TMjFiRFMvNnN2T3RJWkpaT3JocDJZ?=
 =?utf-8?B?OFNpSlpSTExhSkdLcktwQkc2a2c0U1pzMU1SRnFDR2ZiZkt6R3dDc3FCRWF0?=
 =?utf-8?B?UmtuYVQ0S3NnZFd5WXdFcWZ2VFcwOHJ3RjZmSTlNZlRHUUZJRGF6VFZjYUwv?=
 =?utf-8?B?d2VtN1FlMkV1WDNmSFIxeWprZ3c5RHFLM1dyaGlMSFNKK25qcmxzOCs3NVNG?=
 =?utf-8?B?d1dCeSs3MGdhMFQ0akowKzRWK3l5eVhBTy9TRWJYN1dtdEg1ZE9SdlUyOERZ?=
 =?utf-8?B?amFuMUZCMDBBclZiSEdWMWtBcEoxOG82QkhjTTRmbFBzSitBclpMTi9GV2Vx?=
 =?utf-8?B?WEN5NUFaY2VRWFlOQ3Z6cENPeWgzR081L3pMTXcyMGR5ODJ0KzB2bmVsa3Bp?=
 =?utf-8?B?c3YvRHZCYXAxalR5Mkp3OVFKOWhSQU8weENsK2c2bmd4RG1ZZUhVV0dMSzln?=
 =?utf-8?B?SmszT2hOTmNpaDlGVEo1VFVCbVhkVzBYTWp6SEVJdHRNaDFibU9FL294VERJ?=
 =?utf-8?B?YS9kK1ltczZsbmRQZXBLSHJMMjRDMDBRbjMvWDI0aVdnbmRFR2JvdkpzQnZi?=
 =?utf-8?B?emhPbEExNk9Fazl5SmM1M2lOajV1a2lZZzBSdlNDK3JjTjZtVWEvOVM4dytO?=
 =?utf-8?B?dEVtSnFQZG9rVFgvS0VEWCtldDh1Q2JGRTljS0pyM0VucW92TVZ6cGoyVFRL?=
 =?utf-8?B?QnFGbGZoV2RBN3JNY2VVNU15SFBKakxYU21vSHlLQlB6TFBFQmZ1VVR3eVlP?=
 =?utf-8?B?bFcvclZwQmFMSU5BME1zbitGYm1vRnVOUzZXcTIxZFVtQWxzZFA4M0NPVUpy?=
 =?utf-8?B?OVN1eWF6aEw2RmpEZ0xNbGxVTnFST3l4YklXaVdHeVc2aitzc3pVcFZIRXF5?=
 =?utf-8?B?WmVWNHNUVVEwREtORk9jUjlKQ28zSkxNU0lHVGRRK0NET3VpbHZXMGRBT1pX?=
 =?utf-8?B?RzFyUmNNcGx0cVBrYk9EVWJXT1kyV3VNcFlJcGVSZnU0TlowWmFmbDlvQmN0?=
 =?utf-8?B?Smh0eE9iN1NkeTZpbXg5eHZMVW9ycWZ2SVNyMk5qRGRWTWV5MkRGTmV1amly?=
 =?utf-8?B?bnBIdW1MZ3gzSzlqT1ExR3E0UlRUbzRZK204dmt1VGFqbStWbXd4Y2NjK29i?=
 =?utf-8?Q?+fujIn2VRAxOCwon0n+aqL9UMY/DX491eIuSzi/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c300340e-b4c0-4fef-2b07-08d987ee5e5c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3394.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 10:53:30.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3M0iyXtqfk9vpzN6t9iTlzLO/3CNdjZQh1EHDy2R2B3KGhk+CWeWec0Kof96DnvCTrx1Q82DQQsBc4jK0ndJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4673
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/17/2021 2:26 PM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Jon Nettleton [mailto:jon@solid-run.com]
>> Sent: 16 September 2021 12:17
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>; Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
>> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
>> List <linux-acpi@vger.kernel.org>; Linux IOMMU
>> <iommu@lists.linux-foundation.org>; Joerg Roedel <joro@8bytes.org>; Will
>> Deacon <will@kernel.org>; wanghuiqiang <wanghuiqiang@huawei.com>;
>> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Steven Price
>> <steven.price@arm.com>; Sami Mujawar <Sami.Mujawar@arm.com>; Eric
>> Auger <eric.auger@redhat.com>; yangyicong <yangyicong@huawei.com>
>> Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
>>
>> On Thu, Sep 16, 2021 at 10:26 AM Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com> wrote:
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jon Nettleton [mailto:jon@solid-run.com]
>>>> Sent: 16 September 2021 08:52
>>>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>; Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com>; Laurentiu Tudor
>>>> <laurentiu.tudor@nxp.com>; linux-arm-kernel
>>>> <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling List
>>>> <linux-acpi@vger.kernel.org>; Linux IOMMU
>>>> <iommu@lists.linux-foundation.org>; Joerg Roedel <joro@8bytes.org>;
>>>> Will Deacon <will@kernel.org>; wanghuiqiang
>>>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>>>> <guohanjun@huawei.com>; Steven Price <steven.price@arm.com>; Sami
>>>> Mujawar <Sami.Mujawar@arm.com>; Eric Auger
>> <eric.auger@redhat.com>;
>>>> yangyicong <yangyicong@huawei.com>
>>>> Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node
>>>> parsing
>>>>
>>>> On Thu, Sep 16, 2021 at 9:26 AM Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jon Nettleton [mailto:jon@solid-run.com]
>>>>>> Sent: 06 September 2021 20:51
>>>>>> To: Robin Murphy <robin.murphy@arm.com>
>>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Shameerali
>>>>>> Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Laurentiu
>>>>>> Tudor <laurentiu.tudor@nxp.com>; linux-arm-kernel
>>>>>> <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling List
>>>>>> <linux-acpi@vger.kernel.org>; Linux IOMMU
>>>>>> <iommu@lists.linux-foundation.org>; Linuxarm
>>>>>> <linuxarm@huawei.com>; Joerg Roedel <joro@8bytes.org>; Will
>>>>>> Deacon <will@kernel.org>; wanghuiqiang
>>>>>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>>>>>> <guohanjun@huawei.com>; Steven Price <steven.price@arm.com>;
>>>>>> Sami Mujawar <Sami.Mujawar@arm.com>; Eric Auger
>>>> <eric.auger@redhat.com>;
>>>>>> yangyicong <yangyicong@huawei.com>
>>>>>> Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node
>>>>>> parsing
>>>>>>
>>>>> [...]
>>>>>
>>>>>>>>
>>>>>>>> On the prot value assignment based on the remapping flag,
>>>>>>>> I'd like to hear Robin/Joerg's opinion, I'd avoid being in a
>>>>>>>> situation where "normally" this would work but then we have
>>>>>>>> to quirk
>>>> it.
>>>>>>>>
>>>>>>>> Is this a valid assumption _always_ ?
>>>>>>>
>>>>>>> No. Certainly applying IOMMU_CACHE without reference to the
>>>>>>> device's _CCA attribute or how CPUs may be accessing a shared
>>>>>>> buffer could lead to a loss of coherency. At worst, applying
>>>>>>> IOMMU_MMIO to a device-private buffer *could* cause the device
>>>>>>> to lose coherency with itself if the memory underlying the RMR
>>>>>>> may have allocated into system caches. Note that the expected
>>>>>>> use for non-remappable RMRs is the device holding some sort of
>>>>>>> long-lived private data in system RAM - the MSI doorbell trick
>>>>>>> is far more of a niche
>>>> hack really.
>>>>>>>
>>>>>>> At the very least I think we need to refer to the device's
>>>>>>> memory access properties here.
>>>>>>>
>>>>>>> Jon, Laurentiu - how do RMRs correspond to the EFI memory map
>>>>>>> on your firmware? I'm starting to think that as long as the
>>>>>>> underlying memory is described appropriately there then we
>>>>>>> should be able to infer correct attributes from the EFI memory type
>> and flags.
>>>>>>
>>>>>> The devices are all cache coherent and marked as _CCA, 1.  The
>>>>>> Memory regions are in the virt table as
>>>> ARM_MEMORY_REGION_ATTRIBUTE_DEVICE.
>>>>>>
>>>>>> The current chicken and egg problem we have is that during the
>>>>>> fsl-mc-bus initialization we call
>>>>>>
>>>>>> error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
>>>>>>                                               &mc_stream_id);
>>>>>>
>>>>>> which gets deferred because the SMMU has not been initialized yet.
>>>>>> Then we initialize the RMR tables but there is no device
>>>>>> reference there to be able to query device properties, only the stream
>> id.
>>>>>> After the IORT tables are parsed and the SMMU is setup, on the
>>>>>> second device probe we associate everything based on the stream
>>>>>> id and the fsl-mc-bus device is able to claim its 1-1 DMA mappings.
>>>>>
>>>>> Can we solve this order problem by delaying the
>>>>> iommu_alloc_resv_region() to the
>>>>> iommu_dma_get_rmr_resv_regions(dev,
>>>>> list) ? We could invoke
>>>>> device_get_dma_attr() from there which I believe will return the
>>>>> _CCA
>>>> attribute.
>>>>>
>>>>> Or is that still early to invoke that?
>>>>
>>>> That looks like it should work. Do we then also need to parse
>>>> through the VirtualMemoryTable matching the start and end addresses
>>>> to determine the other memory attributes like MMIO?
>>>
>>> Yes. But that looks tricky as I can't find that readily available on
>>> Arm, like the efi_mem_attributes(). I will take a look.
>>>
>>> Please let me know if there is one or any other easy way to retrieve it.
>>
>> maybe we don't need to.  Maybe it is enough to just move
>> iommu_alloc_resv_regions and then set the IOMMU_CACHE flag if type =
>> IOMMU_RESV_DIRECT_RELAXABLE and _CCN=1?
> 
> It looks like we could simply call efi_mem_type() and check for
> EFI_MEMORY_MAPPED_IO. I have updated the code to set the
> RMR prot value based on _CCA and EFI md type. Please see the 
> last commit on this branch here(not tested),
> 
> https://github.com/hisilicon/kernel-dev/commits/private-v5.14-rc4-rmr-v7-ext
> 
> Please take a look and let me know if this is good enough to solve this problem.
> 

Sorry for the delay, I managed to test on a NXP LX2160A and things look
fine, so:

Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
