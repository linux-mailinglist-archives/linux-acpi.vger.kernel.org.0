Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B8391D9A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhEZRMt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 13:12:49 -0400
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:39686
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234158AbhEZRMs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 May 2021 13:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI7TqKGZOrlFSA9H8FbpIRhbHRZpKm2h007U+5kX/oDQK3b+R0SDioiUR0Gi7+P0m3QWkOEAePB9Nkq74QnwtvlssfPFXf1+p1UFfPchd7hWmQEtqTf5brGp7IgTvGQMPg0FJk2Ui3jXddkN3u2oFrPHnvpCZ9vIidIAD0Ro6V6sJ6tLDmgUnpYHEYe53GV1Gj1JMV6puxufDBxsIhTFH4dVNwdXQrnidEwUAfvVDwF/7q2ZMja1REUJnCIMxtTxgOAXDrwXtmFF/aOUlz92sAAbYVd6ZeV37eBveqgWNQFndfqvHG5GcoyIfU/ywSDFqZ/s6qC2fbyDoXhovGjgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVAoxhJYG3ZZwsabrisFk7UibJKKGywi0+DZSjDF4cU=;
 b=HgmgJBRlyntNFkbeb0ihf+dv2dwFxBkpsywg6CMRqfxwwNxx+d2gnuG02qdFAW/5Q04DILe4KDG5epbWPpMlTFXbUZkZdah8wrC0x2Nn+XFGLchE7YEoEd3pGDHhYwhySS3ibuXh8IQ+Mt08u45ZfmI/4FeB5xHO+tBzSe7m7H+9DhxIhcoge7lGTGUje+AoAZ8Q+aQHwwd+nhDBFtZzgvh6kmxfrugply9rFmF/rPGWY+FwjnFrCN6pxpA1v7czcGjmKXs+7nSu/yWSNpZHcU6PrnhoRA2squGvEjLf/gTOch7oG73ayNZUjLuB/bf1UVP0b0KgyL2w51j1cvj9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVAoxhJYG3ZZwsabrisFk7UibJKKGywi0+DZSjDF4cU=;
 b=h18Dxj7Q/u7mkA1zPAKrwIN+qQ5HfT74+y31gW9s84fGi1I0eeZt6cFCeJKtdt9L+n/EjVb8ShdFgFegfbuD8gLDJaE8C2S3XZzWvJ0bHYjUs3hFyV4Le2XfQD659NNl9/g8qBLvPzSrTrBf8Xfv94EHSnDyqaRuUs/x4OidabE=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4048.eurprd04.prod.outlook.com (2603:10a6:803:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 26 May
 2021 17:11:15 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa%3]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 17:11:14 +0000
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "jon@solid-run.com" <jon@solid-run.com>,
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
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <df3ac090-118e-6ee4-80ee-798cc3760775@nxp.com>
Date:   Wed, 26 May 2021 20:11:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <260859e85c854b90b513599f4febfbad@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.123.59.16]
X-ClientProxiedBy: AM3PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:207:1::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.108] (86.123.59.16) by AM3PR05CA0093.eurprd05.prod.outlook.com (2603:10a6:207:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 17:11:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 038ba444-0d1d-418a-7e59-08d9206944b8
X-MS-TrafficTypeDiagnostic: VI1PR04MB4048:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4048B48B9F034719EC1AFD51EC249@VI1PR04MB4048.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKX7tpjOjwJXQbQSNpKrZpvhlx2TyXYlt/z3pXW6N+1FgFR8uGeKstAHmSM75kkRI6fxWh1ULWAmZzJJi/iosQOYMuX9apIqF17Dovan663TqILSWwokcn98NUegLzSPqdsj8M3js/2A0rroXi+IdCUjoVPR+jvEF9VjSnZTAeowWjEcOPjcK7IL5kqUtNqw26XsVxXKkhtzuFtgjwj2HuulItQPameBYPPDTUylqbNJ9yT+fpzhRmcbXabJF94MV4BNzY85lfrEvu/c/3770vbnM+FktZAJKXvo5tp096cOmt3SBwZObR7PsCy0OKbOwmhi4IGDsVMpDz1Xgz5PCML4P3kow5P2yAd1zjNB8wl4MMRNCc+Q7CegossrfikINOZfJjQHkjKwwovEdgUFTFa9a+HxwjBFkjBSpLEKfbaunITTTgHC+VhLLTmEPspd5LouHpingsqX8nb55DTgKdJ4aXtqhHbWoZGqHP8Tgxg347ftscqurd0Fox7mP14AOkj3z943NgU+nG83igZGbZKSzytdSLtKFPeGGqw2spD2HVD9zWuWMeTSE1PX6qpgTboQsSKqWNci9pTei0oH2rcx3Lbq/e6jNJF6GAe0aOK20F6oK2kx06z+X22GxzhwBRTNbIQm+7vk6P3c40nvct1NpZ8zd3Q51v6v/jtCA5sIbKut71jZROnbL93v29bQ63IdSAfBMYMJu8zJytvfcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39850400004)(38100700002)(7416002)(316002)(956004)(16526019)(54906003)(44832011)(8936002)(2906002)(5660300002)(31696002)(26005)(38350700002)(83380400001)(4326008)(16576012)(66476007)(186003)(6486002)(478600001)(66946007)(2616005)(8676002)(66556008)(36756003)(53546011)(86362001)(52116002)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZVgyUGNyOXBTK1pNUGNOQUc0dXBUdXdIMi96eTdJSkZLbEtjaUdBbUhmZURw?=
 =?utf-8?B?Qmh3VGRCSUhRbXllanBNVWkwS3ltbEFKYlhGYS9yaTFPcE82MCsyR1JLNWhp?=
 =?utf-8?B?empEckhDRktFenduWnptaFAxRlI4L0g3c2VuVlR2QzRzN1Y4ODZ2U2dQVE5M?=
 =?utf-8?B?UjBWc3N0dFdwczZZL21PbFEwbEpjdDBlZ2QzbzEwc01qdGlzbFdQazAzU2Jp?=
 =?utf-8?B?YXp3YUxGTjkvUUFzVFlidTlWeThBdnZMc0tGbEdaeVp0RnZmYXVOZHJNYmpu?=
 =?utf-8?B?akRkZnNiN2pnZFFvYWpLdmlzRmZ6U0pyL2Ntc29XWUVSSTFEUDRwdkFjbXJ0?=
 =?utf-8?B?eTVFTXBmdGN3NVgyR2RpMjRGdGEyaHM4NHpsTzZVekt6eFUvMjIzYy9LZVZy?=
 =?utf-8?B?bC9hRW8waWUwWlI3KzZDbVN5cFU0VW5uek5UWUVON3kxeHFGY0ZWQWVaTDY2?=
 =?utf-8?B?S0gxSEJzWnRRcnpsbGkwMkxzaVBOUzdzUDU3L3luby9DVC9qTVkwUlhJYUNr?=
 =?utf-8?B?NUhkSUxLaTlFN1NETmRINDZHOEt4RFpRMEhsN2ZJcVJtK3pWRDdCRkFBRFg2?=
 =?utf-8?B?ZXB6R1llc0w1QkxXWlRwQmQvYmxtcXY3T2VJMXkreSthR0NPU1dYdDBITjlY?=
 =?utf-8?B?bVVDZi9sb2JSVXVFMW90UFdjeHVzUUV2UVBDOE9PRVB1dkxqbmVYRFk1dlgy?=
 =?utf-8?B?UUlheVZMVk9pQnRiN2ZyYWFSZXo2VU1nRFhEWGUzaTAwdHRBL1lZdWtOL3Bw?=
 =?utf-8?B?M1pIL3ByM2ZpTWhkU09nOGNySm95c2d6Z3pZMysrQzlIdVhCMCsvSXcwdVlu?=
 =?utf-8?B?R0h2d1pHWTZYQUFZTXBPSEVtYmcyNEFUbE5VOGVGSEdvbHdBa3JYemcrcndS?=
 =?utf-8?B?V1FDVTlYQlY3Y1VhejhtaXZEZnFkaVhwL0F1a2FhaHN6WVoyem9FQUZqaVV5?=
 =?utf-8?B?b2liVUxub3pHcDZmYVVNRVcyRFUxVHAzSWRxQ3c4SVNPaFF6dFBQa0YvbFRF?=
 =?utf-8?B?ZmJmZzlVRnUrUkc0cGJpOW45NFdvZkNYSjhDTGtUaGg4WmoyZkZvMWZkalVw?=
 =?utf-8?B?WUVGeHpXUmFqVzR3V3puRkFSVVFkQTBWY0FqSUJQODlHOHNmQ2ZxbUloR2xJ?=
 =?utf-8?B?dHlxMXFTUDBwWjVUdkMzYTc0QUNKZHdDTGl4TktISzlUVDVWUy80ZjNOUTh3?=
 =?utf-8?B?eDlPeFRrQzJDVEhhdEYyTnI3b1pIT1FYOHNpUHZpbzNyS0EyTU1pYXZDVzMx?=
 =?utf-8?B?QTNzV0p1N2ZleGdISERGblJ1amRPeUxKbnN2U21neHNjZ0dTMmozQWl4ZU52?=
 =?utf-8?B?Y2VnNjhXNTloZ2grZHFOOUFBS1dWMXdic25TOXltUjdJcWkwY1I3ZWRLQkp4?=
 =?utf-8?B?VWtTY010T3MzWFpkby9WMVFHUTgvbFJmYjVxeGh3dVZxQ1VXMDNnbzluaEZ5?=
 =?utf-8?B?dmd5Y0NFazE0WVdaVGtOMllMTDZVcjg0QVF1bUt6Y21adE9YSHF0WWVmTVA1?=
 =?utf-8?B?bU5mSW41ZUQyWnN4SmlhTzhpeHREb0hTS2xGd0FwWHNXaUgzTmt3NzQ4a3Bh?=
 =?utf-8?B?MHRaMUlXakpmdFdvTkJsQ3dQKy8yUkppODh4V0hRM1pnMDZmU3F0T2xQY2N6?=
 =?utf-8?B?WEZ5aEhyTy9zcndXUDdkdmV6Tkpld0lhb1I1bDRrbFErUVlpREM1VGZDcVpK?=
 =?utf-8?B?cWRKQkVVcmdDeE82MXNESFpYbndTMFlmNlRxOTdHUjFkVC9vc0JCNEgvNFll?=
 =?utf-8?Q?2G956FU5J4fgk8hLN+Z5WxfOlLrmdzz2qubNi1p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038ba444-0d1d-418a-7e59-08d9206944b8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 17:11:14.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMp/YdIoCqcWPEK9SJKUtMJm9FnJsSA2qVKtL7CNd1SWkfQlLzDZWTF2slHNQsbrgdfw/weCiqvNX2AIIq4zag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4048
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/26/2021 7:36 PM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
>> Sent: 26 May 2021 08:53
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
>> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
>> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
>> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
>> regions
>>
>> Hi Shameer,
>>
>> On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
>>> Add a helper function that retrieves RMR memory descriptors
>>> associated with a given IOMMU. This will be used by IOMMU
>>> drivers to setup necessary mappings.
>>>
>>> Now that we have this, invoke it from the generic helper
>>> interface.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  drivers/acpi/arm64/iort.c | 50
>> +++++++++++++++++++++++++++++++++++++++
>>>  drivers/iommu/dma-iommu.c |  4 ++++
>>>  include/linux/acpi_iort.h |  7 ++++++
>>>  3 files changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index fea1ffaedf3b..01917caf58de 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -12,6 +12,7 @@
>>>
>>>  #include <linux/acpi_iort.h>
>>>  #include <linux/bitfield.h>
>>> +#include <linux/dma-iommu.h>
>>>  #include <linux/iommu.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/list.h>
>>> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
>> device *dev)
>>>  	return err;
>>>  }
>>>
>>> +/**
>>> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
>> IOMMU
>>> + * @iommu: fwnode for the IOMMU
>>> + * @head: RMR list head to be populated
>>> + *
>>> + * Returns: 0 on success, <0 failure
>>> + */
>>> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
>>> +			struct list_head *head)
>>> +{
>>> +	struct iort_rmr_entry *e;
>>> +	struct acpi_iort_node *iommu;
>>> +	int rmrs = 0;
>>> +
>>> +	iommu = iort_get_iort_node(iommu_fwnode);
>>> +	if (!iommu || list_empty(&iort_rmr_list))
>>> +		return -ENODEV;
>>> +
>>> +	list_for_each_entry(e, &iort_rmr_list, list) {
>>> +		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
>> IOMMU_MMIO;
>>
>> We have a case with an IP block that needs EXEC rights on its reserved
>> memory, so could you please drop the IOMMU_NOEXEC flag?
> 
> Ok, I think I can drop that one if there are no other concerns. I was not quite
> sure what to include here in the first place as the IORT spec is not giving any
> further details about the RMR regions(May be the flags field can be extended to
> describe these details).
> 

That would be great, given that some preliminary investigations on my
side revealed that our IP block seems to be quite sensitive to memory
attributes. I need to spend some more time on this but at first sight
looks like it needs cacheable, normal memory (not mmio mapping).

---
Thanks & Best Regards, Laurentiu
