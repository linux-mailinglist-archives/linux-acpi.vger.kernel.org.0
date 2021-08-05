Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01073E1B70
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Aug 2021 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbhHEShk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 14:37:40 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:52838
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241380AbhHEShi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Aug 2021 14:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLj/KQBXjIB3vg6GFHTph6fW7r3oB07syq2qJm4h8s/BDdoxOjlVBkmkXxii6nBhNAZiMDbHzN4OwHBbyn3ZQqDOOdUXnLT2Izyd2gHPgF+/nKLVobZS6e8HSzf2OtDLUWUft+MBxy3jCC1/F8mt5IsgcE3oWpm8tpMjzY+QcoZz8RicVJeKs2WCzzDAxlToX0p4TQPmDUz/PyWNnUX9eCz1Ygco3LPKnXfmwWtGULTXD6tR3m+lscFA0XFDiBzN4JCUmtvj2EvsRVwXgz2botLAbpMnyyrVCFOBOGfSJhKYVAFm319yKlFom4LTUarfQChnbha+pD5gkrNADuf87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtPK1GOIj2xs0RR1zbRQZSC4BAJ+t4e+C2dJh3A1uas=;
 b=KqZ+mrXLPCEh4CZdJy0mRTjv9XvflYILHLgJgkH2Ws4ZRwqfvr4Bp2TFf1dNwf0Ks0r4jBnVPbhOaZczmFtuizSxULJWKQh+J0QL8d/cTObKdsrXkeXVw7DduySgffeEJknNU7Z1wtH7vUL9ev1d2LTMD6fZD+mvXNLXhWL6U9hYgCK5PbfFBbqmMA8bHw3DoLS/hPC6NXdPl1OxW8u/IUOlmUOhKPfzkDCMKd3GEOTQQ87zMLSK9eiuDCX7AOTeJaGCeLrloshawikN33VNBPriXlaqq7QbV5nKVpyGCK/WwaOj+p7oyBJt0GVpfn+Sg/YAifakmspmuHVMFfInEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtPK1GOIj2xs0RR1zbRQZSC4BAJ+t4e+C2dJh3A1uas=;
 b=kQsvJc/eDUJpvzlIRZCYmmvRuDE4sJa+LWgaZjHDA2bagqTOVuFa1waq/1KtkreqDOWvAAGmZjVK342ATovinAXOpSsrAdcJDo5KJnnim7McdQnnks/tTMIc8ItJac6v/xFNW9POgN9PchaHW6l1cL2yqDoSSNAWTP67uxbEqaE=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 18:37:22 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 18:37:22 +0000
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
        steven.price@arm.com, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <610d523d-6bc0-bead-4bc0-00a4d95658a9@nxp.com>
Date:   Thu, 5 Aug 2021 21:37:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210805160319.GB23085@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0081.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::34) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.105] (188.25.99.150) by AM0PR10CA0081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 18:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f525b0b-4510-404a-2907-08d958400fed
X-MS-TrafficTypeDiagnostic: VI1PR04MB6813:
X-Microsoft-Antispam-PRVS: <VI1PR04MB6813EC8189CD421F9D28A715ECF29@VI1PR04MB6813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGyNw/vBZcw4v3eswMlYSBW9lWE5qyInbTLS41pEhvusWvxwToII/HKcKopJ2ePCa1C9FFG0rkGsapIeq0qAV5E1LUT68Ql//jzVBTEt8D6KgAg24xceyPzuWcRIxGhSwhkjDNkeGahttI2EPfuGAf2e5quIFqy2BLCv/McgFkA6GufReqNPXB/irwAYyTItzMWlTE8ZN/tg7LgeBSYuwJ7tKJbBd4LkVnSRwPXDeN20oVx9X5ZYraUjQ5UkHdZZlp61cIthbo7osLolD93jjdgb+Yn9QrKpOI4/CQc7IqaAqGfeBlv8g5Q/hLZgSZuutbYw14q27oo1b+Wai2Z/43aTw9HFpNGCXwdafjVF4DFVfPAwuExHKi4uh8iDRQ3t/wjoIvPwr4fO0SabRiVehnzhfXhcA1Ok3HTyNTusp/D/mZWbnBGqPzscabqvAHTzXoJIZkN4aHNGXsVzStOny7LbZi+JKxrkz2gWFSHTeNVV8D7/0aH41FUSVQeW+TtGSpgCNS22+My+X1bo+DpRgd6V+QaPvzR+nW/ZZDZR2zncS4WLLAT7B+p/OFuNicqG+h7Ar6q0stX2Nq862e5Xa+cwYmaEIG7fvmgFWJb3G2rpg99ljv0bgUAxyn0yWsrMyFHWlBvhBWKkLGVKWEDzY2wyTUMDhXP9BRXqSVqPXgeorcYvGRPPlYVcRai7kQiSwOOHjnZHF2WjgQ5PjaCl4bv0s7Qd0ge5BwMDeoMrwQ95T23VawAvu8jxCkYvrg9I6zGsydiT+3TMVVSRHjqxTlqzn4sf98cUJ9ykUnBqDMtdKBkSdFlLU2gWO4ifivSQLuN+CT8lpC1J/PEaPD8UZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39850400004)(366004)(136003)(4326008)(2906002)(7416002)(478600001)(66556008)(5660300002)(966005)(66946007)(66476007)(45080400002)(52116002)(8936002)(2616005)(31686004)(186003)(956004)(83380400001)(44832011)(26005)(8676002)(38100700002)(53546011)(110136005)(16576012)(86362001)(38350700002)(6486002)(36756003)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEpwM0pwV2Q5S2YrdjRqUk9VWVREYmM5YzcyZDFqWUVZTEljOUxnVnlHN2o4?=
 =?utf-8?B?UEpnMno0RDBGVDRDdER2bWtyNW52TmpMUTlrT0hKbEpxeFVtRXE3K0Vhb3Ix?=
 =?utf-8?B?YnpIWWxMYk5reWFjZitVZjdTbHdOQWx4QTN6Zm5yYlBjVFVkeWFqd09IZ1lZ?=
 =?utf-8?B?TWhWd0tHNjBvSXAybStQbGR2YkZDY1djQWJBbWhNZ0ZNaEp2cFI5UDNxZm5Q?=
 =?utf-8?B?UXlicFdtV3RqZTNxb0x4Rm95ZFZidUpJbUNjUWRYOXppM1FlT0oydy9CeXF2?=
 =?utf-8?B?MHQ5MHNjclVQamJMb202V3pOd0Z1TzFZeDdrWmtxalpDQ1l1RllST0JHNmly?=
 =?utf-8?B?QkRhU2hLY2p5M0h4bWpxcGk2TU1xbjlvS1pxbEZCdVg1cWlBdDF1UmVPSFZB?=
 =?utf-8?B?cGlJb2xURUdLUmtDWUpOZ0plK2RhTmVRVjkxektMYkUvdFk3SmR0aTUvUGJj?=
 =?utf-8?B?NGthbmVsSTIwcDUxSHBTelVqYVB2SkdYcWtGL0Y3RCtWRzFDNnJySGZoSnhI?=
 =?utf-8?B?Uk4ydEZJTlByL3E4MXRPdjk3MnVMVll2L2VFRkx6dlVKaENCc3dGb0ZPYmND?=
 =?utf-8?B?Y2dON0MwMjc1Y1JEODR5aE5ObE0ydjdiZkFIbXI0Yjdta1RoRWlzamNIbVVq?=
 =?utf-8?B?cUxTeEVDTzZQdCtmYnZiRVpFaURQbHhUSFgrQkJwc0VSUW5MdnZWaXZqQmRa?=
 =?utf-8?B?YWt6TWlHSTZmSG1va05kT0lhdU1mRkZFN1pTVzBQc0NzenhmTnhqb0RwUXRx?=
 =?utf-8?B?N0RPZDVwMDgwMUpadFJ4aU03M1FyUTRmMkpid25tcnM0aHZVQm1nQjBIN0o0?=
 =?utf-8?B?NXUzaTZRZjBpOVBGNFVud0ZmQUNxS0w3d0s0elM2dndrd3poTG1MWEx1U2dC?=
 =?utf-8?B?aUFVZGpZc0xqVHFyMStrL2lOU2dGWE1adXB1alRvMVl6aFlJQnE4OFBCekhu?=
 =?utf-8?B?ZGhiWFJiU0l4SllTSE1lNjhUeWZwZHpNS2c1YTNUcml1eUM0YnhrNXljcS9w?=
 =?utf-8?B?eDJlSHFkcW5JOCt5TGhXS1hKVUVESFFYeHFadWdOVTB1R01XaTRrVXowOHlO?=
 =?utf-8?B?OHQ4VmZaMU5tUUM5QmhGSlBYSjc4VUxFbWFDWXBWWjFQNm9kSitXQVMzWVhQ?=
 =?utf-8?B?OEtvNy94QTFwVlI3QTdrTXY1RzMyQWg1ZlhLY1BEc291a09ERElHUERIN0xM?=
 =?utf-8?B?VExZK3p4eEtUajVUL3RCUmhiZWM0RWlpMG40a0dLekhxa2NDYWR2UklIS3Zk?=
 =?utf-8?B?M1p2UGUreXJtekJDYWR0OVQ4MDJ6WG1PYjBJL3pXRUE3UnNHWXVyNGdZZHhT?=
 =?utf-8?B?emlMQ3dpUFdYT1liNmxmaXNEZGtwQkZqN3Njdmd2NEQwRFRZbzBES1FBUmdJ?=
 =?utf-8?B?UXFzTmNBNEVmaGNqTFJkVVU1UytWQVkzaW1kdFo4UmJiZElsQ3RmWTc4K0lM?=
 =?utf-8?B?VTVYbFB3ZjZKREt4VEZNR3YyWHNzdGw0c1lOaE5aNDYwclREVFRZOWhWWUdH?=
 =?utf-8?B?OWVlT1Brb2ZwclJ6SXNjZnpxUm9mVkpHN0oweXp0RWhMclhDT3ZyRUc2TzY3?=
 =?utf-8?B?MVlHNDBEQ0M4T3VWV2NDUHlwU2FQZmpUd1didEJ1K2ZRdEtLS2dDeFo5R052?=
 =?utf-8?B?a2NRQWlocnRZSm44dHFobGlHNC9wMW9ycyt1ZnBnaUl3aVMxdU9SSkRvdTl6?=
 =?utf-8?B?ellQRHU0RVYxcEcxY1BuSGVIdWg1VVJIL0h6OUtYVVM1UmlKbjdxNHNtYXlZ?=
 =?utf-8?Q?TSc5kpFg2+Gywvhtk0TAihI1xdnMwyrUKBu/ku9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f525b0b-4510-404a-2907-08d958400fed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 18:37:22.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX/zn5RFN2JmgL5I0AGiTpj/e+gBlPVlaw6MdhPA/Z14PK1EeuFk5x4i7tLwlEkdxpIA++C05CyO165bSW2meA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 8/5/2021 7:03 PM, Lorenzo Pieralisi wrote:
> On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:
> 
> [...]
> 
>> +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
>> +{
>> +	struct acpi_iort_node *smmu;
>> +	struct acpi_iort_rmr *rmr;
>> +	struct acpi_iort_rmr_desc *rmr_desc;
>> +	u32 map_count = iort_node->mapping_count;
>> +	u32 sid;
>> +	int i;
>> +
>> +	if (!iort_node->mapping_offset || map_count != 1) {
>> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
>> +		       iort_node);
>> +		return;
>> +	}
>> +
>> +	/* Retrieve associated smmu and stream id */
>> +	smmu = iort_node_get_id(iort_node, &sid, 0);
>> +	if (!smmu) {
>> +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
>> +		       iort_node);
>> +		return;
>> +	}
>> +
>> +	/* Retrieve RMR data */
>> +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
>> +	if (!rmr->rmr_offset || !rmr->rmr_count) {
>> +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
>> +		       iort_node);
>> +		return;
>> +	}
>> +
>> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
>> +				rmr->rmr_offset);
>> +
>> +	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
>> +
>> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
>> +		struct iommu_resv_region *region;
>> +		enum iommu_resv_type type;
>> +		int prot = IOMMU_READ | IOMMU_WRITE;
>> +		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
>> +
>> +		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
>> +			/* PAGE align base addr and size */
>> +			addr &= PAGE_MASK;
>> +			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
>> +
>> +			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
>> +			       rmr_desc->base_address,
>> +			       rmr_desc->base_address + rmr_desc->length - 1,
>> +			       addr, addr + size - 1);
>> +		}
>> +		if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
>> +			type = IOMMU_RESV_DIRECT_RELAXABLE;
>> +			/*
>> +			 * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
>> +			 * normally used for allocated system memory that is
>> +			 * then used for device specific reserved regions.
>> +			 */
>> +			prot |= IOMMU_CACHE;
>> +		} else {
>> +			type = IOMMU_RESV_DIRECT;
>> +			/*
>> +			 * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
>> +			 * for device memory like MSI doorbell.
>> +			 */
>> +			prot |= IOMMU_MMIO;
>> +		}
> 
> On the prot value assignment based on the remapping flag, I'd like to
> hear Robin/Joerg's opinion, I'd avoid being in a situation where
> "normally" this would work but then we have to quirk it.
> 
> Is this a valid assumption _always_ ?

I think we enable quite a bit of platforms with this assumption, so IMHO
it's a fair compromise for now. As per Jon's comment and oob
discussions, in the long run the spec should probably be updated to
include a way of explicitly specifying memory attributes.

---
Thanks & Best Regards, Laurentiu

> 
>> +
>> +		region = iommu_alloc_resv_region(addr, size, prot, type);
>> +		if (region) {
>> +			region->fw_data.rmr.flags = rmr->flags;
>> +			region->fw_data.rmr.sid = sid;
>> +			region->fw_data.rmr.smmu = smmu;
>> +			list_add_tail(&region->list, &iort_rmr_list);
>> +		}
>> +	}
>> +}
>> +
>> +static void __init iort_parse_rmr(void)
>> +{
>> +	struct acpi_iort_node *iort_node, *iort_end;
>> +	struct acpi_table_iort *iort;
>> +	int i;
>> +
>> +	if (iort_table->revision < 3)
>> +		return;
>> +
>> +	iort = (struct acpi_table_iort *)iort_table;
>> +
>> +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
>> +				 iort->node_offset);
>> +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
>> +				iort_table->length);
>> +
>> +	for (i = 0; i < iort->node_count; i++) {
>> +		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
>> +			       "IORT node pointer overflows, bad table!\n"))
>> +			return;
>> +
>> +		if (iort_node->type == ACPI_IORT_NODE_RMR)
>> +			iort_node_get_rmr_info(iort_node);
>> +
>> +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
>> +					 iort_node->length);
>> +	}
>> +}
>>  
>>  static void __init iort_init_platform_devices(void)
>>  {
>> @@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
>>  	}
>>  
>>  	iort_init_platform_devices();
>> +	iort_parse_rmr();
>>  }
>>  
>>  #ifdef CONFIG_ZONE_DMA
>> -- 
>> 2.17.1
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fiommu&amp;data=04%7C01%7Claurentiu.tudor%40nxp.com%7Cb020e5093dee4374ee0b08d9582a9238%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637637762131278563%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8Q%2Fu5qawL94YhbKLujOAlJjTVEWZircjviccWnnqPxs%3D&amp;reserved=0
> 
