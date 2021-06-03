Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799A639A0FE
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFCMeN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 08:34:13 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:16206
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229876AbhFCMeN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Jun 2021 08:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J90ufYmVNLI6+euFaTieCCBoc6yg5HhWoDEzMbM4JR5OUy6rtwTkmvY8cugeWlsWphhDs7ltJYc8dOnNFj5EnEfs6ZfHabbQY+BC+Td9jQGwa4ZLZ//OuOl5liUunawu9xdIjrRNj1xdg+l9oLX/QWiTFK2EwO7vqnipXBMiJ9whpQQDICsI60T3wbT2MJ3qBBlavpnKJwkDPPtvSpJ0AKDm3TPk68V185l1DCT9Tr4AerxUltagMFqFYBoCFJ0McJOUbpWtumc1lRllFz+Ukeh31RqSUpN+WNJkl2zbRJ4FZeoRnd/DjnBlJwiBoeGVYdl+oWHuSLd+rdibBBUT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRgz7Xzt0ndCSGb1Ki3qnZYrGH2CfzWRKtLS3W0cRzI=;
 b=HbXYXGJNJNJKyhJbDfzfVeKpMpNFC1XpcCdXS/hxCxYrMzeefTPHvWsuKPI+E+QbeH5nK5kM9Mho1Nl8eYoVpX0Ikn7S0Un78Redkv4W++4Wpoz+xFt+TSim2oMMb0yCxH54lL5Se9/6xttE2u2TEhgVfQgVRTWl00pEGy3WMfKoPgowHwih20vxgwFyen/3YW+fDa8D6gFmsFaQjfMbzECtF+Ry9BO22I1Ip3F5w+EzcGQ/n/vFoHH1yBNC9hDbOZfPIa2w/iqbGFGa+KdNDtXqAEmwJEG5P10Ug2hQfI70W+yonZkfZwYTLS0uPmXtvLFMXI2lLgw2tyqXp3Pr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRgz7Xzt0ndCSGb1Ki3qnZYrGH2CfzWRKtLS3W0cRzI=;
 b=CdnaNT8xjekF3YdNn9WQhYWVezk9kQTrbOY3wpNk+OqJm795VVZasdZLnB4pIPU7QZp6wMFsFr2rIdVArqjd2eHtsxB7rlUNkfKJRGlnwIbtAwGpa1um8zUXaJyQvpN4dLWo4TA5zT6jQ39W8efg5GKTe/gRvaAY5hdUruTCgSw=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 12:32:25 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa%3]) with mapi id 15.20.4195.020; Thu, 3 Jun 2021
 12:32:25 +0000
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
 <260859e85c854b90b513599f4febfbad@huawei.com>
 <df3ac090-118e-6ee4-80ee-798cc3760775@nxp.com>
 <CABdtJHv2QBHNoWTyp51H-J_apc75imPj0FbrV70Tm8xuNjpiTA@mail.gmail.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <3cad15bc-d755-3b86-a3a1-684caf8cb14c@nxp.com>
Date:   Thu, 3 Jun 2021 15:32:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <CABdtJHv2QBHNoWTyp51H-J_apc75imPj0FbrV70Tm8xuNjpiTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.123.57.130]
X-ClientProxiedBy: AM9P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::9) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (86.123.57.130) by AM9P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 12:32:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a31fd7b9-5759-4757-b489-08d9268ba485
X-MS-TrafficTypeDiagnostic: VI1PR04MB6989:
X-Microsoft-Antispam-PRVS: <VI1PR04MB6989CE42091F349FEAB54726EC3C9@VI1PR04MB6989.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBu53oiLxZIjy2adQf1EM5SpFGJ4/+asyD6msc3B7o3Qln53o7fQCJCTlAy1NdzdmpKnGWujVE+eHKy6Nm5W89oO819IBxMIINvxzT4uZ4LA2uTPy+SV0IHUy85L6FAt4OqnOxbQA5r70oqdUYIbRT5AbfR/GqZIft9LHMZhhph2NqIFWA0iV8UBd9cmKOI8ixnM/cw2DLLUI6q1jZi56lT1MHtHQeC3p7W1AkZreDnH7/hZyMIiQpNoxsFAtcBhmbYSQMgN8VpAKkk5yYcH1iLUf/qbBMqu8uy8VJ4KUg8FJp0uLHaTpkx1XHu9CuCdghqMeQdN7fCOgV85YeJOAz0x3RqJGnmAfW0HeZ5NVFftRvKZyWRJwemWHRNFGbgjexw2tGWs8scGqN9I0LKkIUrxyl+l5liHpTUtgsU/zKDwb8G+KU5pR1oJ49mv6jy4lRjDKVKBxFoIxMwJnqeWXElleAY2BUr5wstzU3jqNeSGbxw5+XJMdu/9a8JXTGXjT2V/oM2k62NC9MdFOg7fxKylACkLNVB4adP8uYp7jvqiNibI/+nGgGMElRW11abizDcm+/mCEKVoO6A2CtUca1oVWncH9C0OnesBwMRUY0xNwUNHDxc7/ti5ISwcWc3i+liqvE9mmqbGjD/3is96tHs/SWwQ6p0i+P0UtUiP+UclSPdiQcFuOldBFyCBHRjFet7HvR4sCnbKJaMwZaCpbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(53546011)(38350700002)(38100700002)(8936002)(316002)(36756003)(4326008)(16526019)(54906003)(26005)(83380400001)(16576012)(2906002)(52116002)(66946007)(86362001)(5660300002)(6916009)(44832011)(8676002)(31696002)(478600001)(7416002)(66476007)(66556008)(956004)(2616005)(6486002)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RG1uTzZOYkd1VnN1OHViMU1BQlJYQ2VXV0c0b1lYZjJYVmg3UUxsWEczUE9L?=
 =?utf-8?B?cWFVemVvWGJ3c1p3NXNtaVoyMWxOblFBcEVobkd0Vk44cnl0THdOZTNWcEFR?=
 =?utf-8?B?NTNDTHc2aDd2TWh0OThIR0JTVlZjYzdBOUtobmdiNGM1TG9Ca1ZPMGtia3Zx?=
 =?utf-8?B?T0JBVGROZ3orUTByaWZzWDJITkdWRHdBck93RFFaMHhwcVovb0UxdnNCVXpl?=
 =?utf-8?B?L09CcjV6OUgxSmczeGFjaytLa2NmcHUrZk9ySFgvUUdPeTRjcHFDaDFhTVZn?=
 =?utf-8?B?OFVoSmNQZzhrRlBmVlljeXMvM0dOaHdxUUNrdm9DWFRrMFJOVEVYb2toL0Nl?=
 =?utf-8?B?Tk5iQ0pEdmRxdkJrZFgwWUpidmdDdjh1aE9sSCtPT1JwTzhpaTlNK3lyWllC?=
 =?utf-8?B?ZlVoWXpFKzlIelFYWWZWZWYweTcyQkh5eldNWWlMajJXOHBCejVOb3pMUDV1?=
 =?utf-8?B?Z280Qm03RGhITnpicmxyVjBpbmNlTkJMWldSUCsyUTJqbThtVUQ2S1o0VUxO?=
 =?utf-8?B?alYxQWFFS1BTU1FkU21Yem1hL2dpcDB6OHFiSm54ajhsc2lTd2NHVW1WajZ5?=
 =?utf-8?B?N3VRanhrMWk1dnpEOFpMdExGZWhsK3FnUHZZY3RialZFRElCVFFKOUwzS1c2?=
 =?utf-8?B?YnRmYzJkdCtyWFJNeHFaQ2pIT2hMNVNjT05ZVk5KQlh0cm4rVlpRenRGcUdP?=
 =?utf-8?B?VjY1aURSWCtiSGlRcGthblJYcDk5ZERaNGdZTW10SmRQQi9CZDlYVXpwaDh1?=
 =?utf-8?B?bjdoRTRrSElUcWJqVFcrd2g2LzIvdnVDbVBwUzRRbisyZTE5aE9KMlFQWlBo?=
 =?utf-8?B?UktkeTRkdGQzMmlXNytIa0p0bkl1eXpXclVINEFML3NOVHlmazBxWGdpdXE0?=
 =?utf-8?B?OHhRMFBwcTZrWGpDWEZvOFpxcVpKOWFicm5SdUl3ZVA1QXlRSnVzdzJOSk9D?=
 =?utf-8?B?QVpRa0xoVE5TWHRMaTJKeGxYSFQ4TzZoVWNVazNiZjM2bEZwb2RzODZNVmJM?=
 =?utf-8?B?djFjN2I2Q25vMmF3OW1CSVg3YnVBY01TUGlkZVhHcUZTYnpWNHNqSlloMHcr?=
 =?utf-8?B?OThXRkdlZktzK0RpYWxrdDQwVXRNaVhUcXNXa1NndW1tUmdGenAyLzRxL3JN?=
 =?utf-8?B?Y1gxbVViV0FLSGs0RnhSZk5QRlNUZ01pbUd5NFVLbFI1VzRNZFdpbWVsMy8y?=
 =?utf-8?B?c1RSWmpXSWtFRk0rNGEzMm1Tdy9hRmx4NGM4OUJ2TDVWR050bkJkenBNa3Y5?=
 =?utf-8?B?aFVMay9EWmtOZUR3NHlvajVUZVFvWklIU0hNTmZmS0ZiejB6Ny9ja2tnZnd1?=
 =?utf-8?B?MzBmZ21iZU1JT3Q5eXdsRXUzUGFtZllPNGRmRmZwY1F4UE9hbEdyR2FESVpG?=
 =?utf-8?B?aEdmTzZ2U0EvSzk4Tk4xL1ZteDhJTllQQlFFMU1rWGVVWUlZRHhrQ0gwN1VF?=
 =?utf-8?B?MEJqdVJsTTcyTVZSVzZtMUpaYjBTWEJhcCtDc2d3ejNXYnI4UmlxOTA0cTBI?=
 =?utf-8?B?TFBISlR4ZTJIbjB2SHZyNXJUY25wWGZMU2VDekh3YXVDMVl5T1RaQUhhOTFE?=
 =?utf-8?B?R3pOcStRTXJnelI0SVRZNnI1eGVFbjBPMloxNlU1L09JYmxtVmlxYTJsYW1s?=
 =?utf-8?B?aEFDMC9OQnFPcjFUbzZtS2x6bjhoU3BXcTZBYzNTb2pkdUJtWEpYWG9VajAx?=
 =?utf-8?B?ejl6eldDR1pvQW9aaVI2UVBhUVBKbSt6OEFldjVZVHVpdk95MlM5K2I4bzV5?=
 =?utf-8?Q?7C8W6gOvzWf8hoCP6XzDIBiGrjlytQa5keeoYC6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31fd7b9-5759-4757-b489-08d9268ba485
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 12:32:25.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MF/I4KpeQoeeoFR49AZwQiAT7/c/mwrLP2M+wScg/8lG0Ld/Ja4bXRzCOzU55CQ0516/o/UHjqaA70lNoQXf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jon,

On 6/3/2021 3:27 PM, Jon Nettleton wrote:
> On Wed, May 26, 2021 at 7:11 PM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>>
>>
>>
>> On 5/26/2021 7:36 PM, Shameerali Kolothum Thodi wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
>>>> Sent: 26 May 2021 08:53
>>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>>>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>>>> iommu@lists.linux-foundation.org
>>>> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
>>>> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>>>> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
>>>> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
>>>> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
>>>> regions
>>>>
>>>> Hi Shameer,
>>>>
>>>> On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
>>>>> Add a helper function that retrieves RMR memory descriptors
>>>>> associated with a given IOMMU. This will be used by IOMMU
>>>>> drivers to setup necessary mappings.
>>>>>
>>>>> Now that we have this, invoke it from the generic helper
>>>>> interface.
>>>>>
>>>>> Signed-off-by: Shameer Kolothum
>>>> <shameerali.kolothum.thodi@huawei.com>
>>>>> ---
>>>>>  drivers/acpi/arm64/iort.c | 50
>>>> +++++++++++++++++++++++++++++++++++++++
>>>>>  drivers/iommu/dma-iommu.c |  4 ++++
>>>>>  include/linux/acpi_iort.h |  7 ++++++
>>>>>  3 files changed, 61 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>>> index fea1ffaedf3b..01917caf58de 100644
>>>>> --- a/drivers/acpi/arm64/iort.c
>>>>> +++ b/drivers/acpi/arm64/iort.c
>>>>> @@ -12,6 +12,7 @@
>>>>>
>>>>>  #include <linux/acpi_iort.h>
>>>>>  #include <linux/bitfield.h>
>>>>> +#include <linux/dma-iommu.h>
>>>>>  #include <linux/iommu.h>
>>>>>  #include <linux/kernel.h>
>>>>>  #include <linux/list.h>
>>>>> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
>>>> device *dev)
>>>>>     return err;
>>>>>  }
>>>>>
>>>>> +/**
>>>>> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
>>>> IOMMU
>>>>> + * @iommu: fwnode for the IOMMU
>>>>> + * @head: RMR list head to be populated
>>>>> + *
>>>>> + * Returns: 0 on success, <0 failure
>>>>> + */
>>>>> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
>>>>> +                   struct list_head *head)
>>>>> +{
>>>>> +   struct iort_rmr_entry *e;
>>>>> +   struct acpi_iort_node *iommu;
>>>>> +   int rmrs = 0;
>>>>> +
>>>>> +   iommu = iort_get_iort_node(iommu_fwnode);
>>>>> +   if (!iommu || list_empty(&iort_rmr_list))
>>>>> +           return -ENODEV;
>>>>> +
>>>>> +   list_for_each_entry(e, &iort_rmr_list, list) {
>>>>> +           int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
>>>> IOMMU_MMIO;
>>>>
>>>> We have a case with an IP block that needs EXEC rights on its reserved
>>>> memory, so could you please drop the IOMMU_NOEXEC flag?
>>>
>>> Ok, I think I can drop that one if there are no other concerns. I was not quite
>>> sure what to include here in the first place as the IORT spec is not giving any
>>> further details about the RMR regions(May be the flags field can be extended to
>>> describe these details).
>>>
>>
>> That would be great, given that some preliminary investigations on my
>> side revealed that our IP block seems to be quite sensitive to memory
>> attributes. I need to spend some more time on this but at first sight
>> looks like it needs cacheable, normal memory (not mmio mapping).
>>
>> ---
>> Thanks & Best Regards, Laurentiu
> 
> Laurentiu,
> 
> Is this regarding the mc-bin memory block or another IP?  I am currently
> running this patchset with IOMMU_NOEXEC under ACPI without any problems.

It's the MC firmware needing EXEC rights on its reserved memory. On my
side, with IOMMU_NOEXEC, as soon as the direct mappings are created I
get SMMU faults triggered by the FW.

> If so maybe we can touch base off list and align on the implementation.

Sure, just let me know when you have the time.

---
Best Regards, Laurentiu
