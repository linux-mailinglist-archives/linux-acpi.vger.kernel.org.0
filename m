Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C1391196
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhEZHyx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 03:54:53 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:15414
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230416AbhEZHyv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 May 2021 03:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leraoZU3izU57XyyCkU+upbhULLZUliPPB1EEEgeC+JIAtU1Uumcg0Tyby+8kkRDI1abZPHQRLXlUyFrD7ZO9eCVBIe/fePQP/ItrcaeSH6UNzk54jZLwJRDOA8PCHiSZJVlIygheK8DJvOokfREFyX+h3pB37+8Lq1XV4VYxM0h5L8lIi/e0KzLwMhnWGMfB37KpuEFc99eQyxdg53591aafhECbc7UBliONf0Hwc4j0Z0Ufh6nVIj0irYpL021wtU5ryiGX+I724sTROLrXkwt1r4CF2lS3dv7hGUWa5JHoxvFz0jZTaw8Xc5jzJmbJgFyWONrctkdGS5mKaDG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeBA2Sq0shKEPUWD/dFv/lD2z1hKHBPVjO8MMJjKWWI=;
 b=GECRYESa4L1HI3+1LvaUELmqp5Bb4vvEq32I7C5Gdf/11Jw0ZQsio3e8cKmOxumLoCnOy5LYx1QoOUEQoB/PlsDhWWSrNCIK6UVoXT6AyQysFDsiQsA/02mdYGHZZBQYW+o35FY3OZdjzH++L0Q1sF/qWcc0qxJmBDuB6Wkjk9BKhlHa7ZyofuieD3UxiA/Uvdq2OCkkGLXwbCMJQbYRddhcGdva5rKCNeEtmKhfOedm3vGLG74x9Zuh8oCw/Lh3Hz3GOcKHOwZ5JHnyhnRsrZJ+jjPY/pBzP05r6xa823gi5CkZrYpIQyBrPDM45eccfUvybO+60AiAMVKxdvkZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeBA2Sq0shKEPUWD/dFv/lD2z1hKHBPVjO8MMJjKWWI=;
 b=MzSsMSA+N5RPbI9Eu85MSZSWRP5/m8uiNulCgwBbw/yl5sbtCWx4mN9OqnZqyV8wBjSvYr2wKkEufV1qgdR0YdboOWhzF245CfDQ+pzcbX7IRkwjiwvoXPwnxU7dz3aB+49ZFgQVXj42H1Elf+o1tGx9t1DFigiddMmE8AJOvuk=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 07:53:17 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa%3]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 07:53:17 +0000
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        robin.murphy@arm.com, wanghuiqiang@huawei.com
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
Date:   Wed, 26 May 2021 10:53:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.76.2.204]
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.29] (95.76.2.204) by AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 07:53:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cc9eaeb-9fd8-4ec6-c88f-08d9201b528e
X-MS-TrafficTypeDiagnostic: VI1PR04MB7085:
X-Microsoft-Antispam-PRVS: <VI1PR04MB708527D5CA76C8EEE257506BEC249@VI1PR04MB7085.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhQM1x4LERB9Wcxfvu/JqnxWK29DwJpjHGmgFjxAZMCHxQqlsiYof50o3BUkjqXvWNVQl0nig2QJxcV5UjDx7RPejA8D9osHQR0AsQQqOnKwgcWtWJBc6gqKUvx6R4QatSpfhfMx+ioGhbKTKN34empjvh8tY4hlynfhwrGK8Dvr5rtg6dbnQJEfSfh+gmrR6CD4EIMCJ+Oatz91/qS0Rn6WVS7tIDltQYk+JSD7kqX1ITIXIYmjlnPn1S9HHXLnTeHBNCL+zTzsi3lQxYrgHuFjdTJe6mZNDRFJcOO9jfyAs66QcYMH09n5yTk72draSccFmWz2rmTSEIbpSU1eHJYrfgxeLclzVCN5rZlpmhv6Y9HDOWS4T3DIKQHT28sKPgtWKojZWz2oFZyktg8czpUpJxhBACHOpMjyLFKReVGxaLhcQsMe75pFV9Wo497W1np3zzvtHdV87sOc4/U0VzKy41AHmLCwYXSae/rUlXF2vUBZmcN03sTb0FdCTSeT03LCq9kqR++ir1hNBDsEjNVewJw84nkhiK0ZTs5F+cn6l2wLFUx0sXbX8l/zZVm/7iOne6aWmzFQKWv6TD7vM+9hWt9MsBhbCGTm3+fPP/j6+s930RYQ4y9dx8ptQNF02LlqLSVlgZaogG0CfP+CbxIkzwnnVc6yzkdsaAXEkdy0k+/3cprG0q+JJuJG3D3K0AKI5YlAd22qdw3rRZ72BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(52116002)(83380400001)(86362001)(316002)(26005)(7416002)(53546011)(6486002)(31696002)(16576012)(44832011)(8676002)(16526019)(186003)(8936002)(956004)(478600001)(66476007)(66556008)(31686004)(66946007)(36756003)(2616005)(2906002)(38350700002)(5660300002)(38100700002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TERUbWh3Z2pKZCt6LzVDZUJKby91V1FJbDRvWWgrdDgxQmtCTk1qUjZoZXVq?=
 =?utf-8?B?eXhWbHFubTBGSlpzT1ZGZDljTHJmaGhSR3ZpTGRGLzhEM3o0dUduL0duWS92?=
 =?utf-8?B?bzI4clZ2OVR0MFViMGpUNzB2blZydFJjbE93RU5oQkNaVHJFNGNIdXJITUNz?=
 =?utf-8?B?TlcxcSttY09ZTXhUUHdXVWNQc0ZNUzlxM005SGdsZWNxV1VqK1JIeDlha0I2?=
 =?utf-8?B?RkFTWkNVOWU1Y2hLRlc5emdSdU10OExaVmRiTmQxd1FhUk9yTEU5WDlLR3o0?=
 =?utf-8?B?MExTVDUrZkl6UnlHV2JRTU9idHBxMUFrRko2N0QyVS84WWxnTUpjY0ZZazJl?=
 =?utf-8?B?b0lPRlpOaUN6RjlJb0FMZWZqR0dPd2grMkxGdTcxMENONHdsRnIxUUZWRmlp?=
 =?utf-8?B?dnd3WEgvU0h1Q3BxNEhTVUNWcTFYVmxUdmhHRXQ0b1JzU3YwZEZtUnZndzA2?=
 =?utf-8?B?RGtKTFRSVDdnZDVYSzJEMTQ2d0J1K0NGVjlKQWhlS3ZBRFFwL0pyc2VrS3d3?=
 =?utf-8?B?cDl3VFIvRTIybnNabFBycVl0NHpweWpkYzJDRk00YkNaTldTL3NaNzBrMFpm?=
 =?utf-8?B?Vi8yelIvdXFDRTFWcUZwNUN0QnMwMFlhakg1Y01yL2J1bFFvdXVSZndWUTRT?=
 =?utf-8?B?ZHNTZHRUUTVIOVBrZXhmNWRJaU5xMks1alI3WWhGMm03MXJERU5ubmZYdVpW?=
 =?utf-8?B?a1FLSkE2Vkg1MThteURuNC9ZRVdkWEYyNnZQY3U5aVZSN05uc3lvY1VlYkJu?=
 =?utf-8?B?UExLdlR0cG9wT0REUmE4R0NLeVFORkRVQlNJVE5ONERZNTh3Uk5iTnZDUCtC?=
 =?utf-8?B?TytZeXJsQ1hsa1FUcDFvWm12a2NJYlJJOUVlS2tyUHJldTNpTGU1NFZJZFB6?=
 =?utf-8?B?QlR0ck1ROXFjTTZWT1J5eWZRSGlacmhFRWI2UmxEcTRsMXdCbTVuYUpCUU50?=
 =?utf-8?B?Tk9mSjAyZU5YZWs0Q210K3ZPdC8rTDlFZHRFaEpxc01NTUhmYWRhZDgweHBy?=
 =?utf-8?B?ZnFqNjd0OHl0eDBtMFNyOXJJRlpvTnBocUQyM05RQWo1VHV2NG9KcHYxeC9U?=
 =?utf-8?B?Um5UeTk3bm03QlU4L2NIV3lvVTRNaUpSR0JJK3AvSWVubU9mUjU2VGJ6OHhI?=
 =?utf-8?B?SEdsbjdyUmd2MkNUbHB0TTg5MGFGMGdXQWJuUzdvZ3JodEw4WWQrZlFKME45?=
 =?utf-8?B?a2V1WDUva3dKV3NXTzRIdWtLR21vRlprTUw4NHNLdXIveEdTMlN0YjI4RzlT?=
 =?utf-8?B?ckNZM2dRRXg4S1V5TFRKYkptWHBuWU15blBSb29aRDhQMkFacUVDSHhoMUVr?=
 =?utf-8?B?OThkd3picy84dTBnOHlyWWFNMlZaMXNhKytUVmxUSkwya252TDBsdjkvY2JF?=
 =?utf-8?B?S0U4T3p4d2dUV0loODdUMTQ4Z1NhSld6VjZxYXUySTR6QTR0ME1ZdXI4Ulkv?=
 =?utf-8?B?N1Q0T3FTNXBBdWZ6TFFHV3BWUmpWMTZZL2didWFlbE0vOGFwdFBXbHlPcHB2?=
 =?utf-8?B?REV5eExyMEE0V3gxanMrUC81aDc4Sk40VnptUldzSDZlRDE4dSswUWlSbVhY?=
 =?utf-8?B?WU9EZnFyVVZTZEk3eDZ4RXdJMTNldXZYY29DVnZQejFwYTl3Ri9WVmNUL1hT?=
 =?utf-8?B?bUtDakROSTVpSlB2VGFWV25DVThaS0JBV2xMUXJjVFZKZFhFOEk0QWJqenlm?=
 =?utf-8?B?eWVFYWlJOEFCZGc4bmFodStrK3NicFVQN0hxZ0hPTjVSdER3SHYwaTlUZXBv?=
 =?utf-8?Q?jklx6FN9E5Mi2auQdrx+ljUIVwhuLzV28znwEiv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc9eaeb-9fd8-4ec6-c88f-08d9201b528e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 07:53:17.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLONwqrqTCtxdzRxpX7Vs8d/vRaQbCZGhOYj4yYEnmnAvpSOX42JGEIxY4m3VANxU7g2hX0Fvs+fihH7YIY4jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
> Add a helper function that retrieves RMR memory descriptors
> associated with a given IOMMU. This will be used by IOMMU
> drivers to setup necessary mappings.
> 
> Now that we have this, invoke it from the generic helper
> interface.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 50 +++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/dma-iommu.c |  4 ++++
>  include/linux/acpi_iort.h |  7 ++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fea1ffaedf3b..01917caf58de 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/acpi_iort.h>
>  #include <linux/bitfield.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct device *dev)
>  	return err;
>  }
>  
> +/**
> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with IOMMU
> + * @iommu: fwnode for the IOMMU
> + * @head: RMR list head to be populated
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *head)
> +{
> +	struct iort_rmr_entry *e;
> +	struct acpi_iort_node *iommu;
> +	int rmrs = 0;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu || list_empty(&iort_rmr_list))
> +		return -ENODEV;
> +
> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;

We have a case with an IP block that needs EXEC rights on its reserved
memory, so could you please drop the IOMMU_NOEXEC flag?

---
Thanks & Best Regards, Laurentiu
