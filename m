Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D403CD5FA
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jul 2021 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbhGSNFA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jul 2021 09:05:00 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:60896
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240082AbhGSNE7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jul 2021 09:04:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhE7nKv+05R41E7kJwuKZgDAabejP2VazOyHnIXipspoe00yHXosjLH+0O9Vwg0CJpeVNN+hpnZWpEvojKOR3UGHADu5bbpyPU7hYfJbDfi0zxuZ48Qtin/kKL3ahQTd+6bJ+oR30uB+XTJ77VY1dspf8hoBZIC6czPLXmlxA5g5oojNQUf9ZrfEAt+b27WJ7/taG9gAidx3ec2EbNPrHcg+8iNYNewllFbkj1MJveHTFjNfYWl3cOUUbt6pKEbINMEyeDh/A6Y8K3W0FhKr7WfqR4q9SoNSaU2SBrOLd51sBwJZ9BMAkHmlnH/RTqeJ44rHvQxj2odwrz9Tc7RRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMyIdAPFJo/3gdiPvscOdNtFoK0ziJ9yMuo0i9ODrj0=;
 b=nR5axgzDs7oXq0I5cr2buPuvea5+ovvHJsiwUZpmPjr5DWAKvBe09MutbXcnBhti4mXQabFL619XvcfWpYrpowJPOz3eYEsSXMIejWEOor0vAekWvXbb1bvqrmqzNSP6hT8FZ1EXgYi7BxLWKsFvrxGr/KzKCqPlQ2kcNi/7Evg2jmWJ7befmPuBj6b113pi3/dAOuKjshIbeLCN0o+VQpMD66O+1jgjgMc+uq6YRri/KG8ozONZhkD/mWe1w4ukoSYY1oPe6qV70An58gCBC3X/+TfCu7vR8Q8kMX5JqQDMvayrEFspYCG0eM4U+Ff/3wLOVs4/zVJGL4nVKXPRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMyIdAPFJo/3gdiPvscOdNtFoK0ziJ9yMuo0i9ODrj0=;
 b=TgixWQM5I59aWszjtFRasefsIIx2+mjnjd5whgIdNfoqnTAWX4Xt+1MbLl7uOfct8alL3/GKCxo0bAtjcNlgZoI2NxWScBrqWqTXnWtRYgLd29LQp1T9L29QekLlyVg3QObcwEA2vClPrVLw+52J+mpsaHFfeVfhfR6ckIrRDCI=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB3311.eurprd04.prod.outlook.com (2603:10a6:802:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.28; Mon, 19 Jul
 2021 13:45:36 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 13:45:36 +0000
Subject: Re: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        robin.murphy@arm.com, wanghuiqiang@huawei.com
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <35db3320-d6e2-721e-8d49-e5e2e80e2359@nxp.com>
Date:   Mon, 19 Jul 2021 16:45:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (86.120.185.232) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 13:45:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e80a487-eaba-4641-bedd-08d94abb7cdc
X-MS-TrafficTypeDiagnostic: VI1PR04MB3311:
X-Microsoft-Antispam-PRVS: <VI1PR04MB331139F666C51A3FEC5E33B7ECE19@VI1PR04MB3311.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQADlS6lUtYVmjhpXBmRwWKeug3kcWrnGyP00LqrWdjenrB9UK8blQHr3qmXmsk5EPgnhD3hjuEqm0/KI3Iw6DCYMpSjihWzo+dkYtVxDU7q7BHbUlTf0Z2auXIWgbhXv4iycX1KYDggJRPGnCb6Xb+p6nHeSnHmjI/sHuQGJWADo1vdUFx9mnaH2EDtfce8Wmfv3srfh1+Lix0HHcslVmQvg18PiC65vaAnhoshU9Gjkt4mKluniYDjpVoWB8I2ApLOIehyH91dj+ehaee8prM8Nq6kYj2vQiqdgDC1O1Sr0OoWXgfq4Z4CImP2rGed2+xZb07CV2U37Z5BNKS+5zEZ3XujMzyyHC8q2mXpM9pCazKNQUJBIIaabPWkM1FN5Kauk6daABVWQZoiV8vrIq7yshcx9ysGj+FIHfxrH6KGB9Q8+qk3Fcjk5sXG039GYkYAEz/5IxFkgmbEOCO/VHrB8IO5vXsh08q6UU+bi+/FYeCnfBjBRBgmhC2nUZ+3Bm+/BJ7ynu+pu7o5rr1i9A6HzKEy8HSrr0xXfM5TbTSH/eYb3j4Wrp6wTxQVSFvNRa3ZMuIlLdt0OYyxUivYA8qCQAQrssyczA5RbegdqJ913AXhgktnZxdXKrP9BtnVMrhNZDYOCVZ3NHu9e5CUB+Qlu3J1bWzf403UFlmWek+2Eq4q1RYxdXxswdWelnv0Ge4LBSQeK8jjdMJQiLiDq+9Fo3UjkUkg8kbBxjzwniXk2B1dnX0WjgFnFb6mFP7G7llZULmfT8vqteN5mapylQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(478600001)(7416002)(5660300002)(36756003)(316002)(31686004)(2616005)(956004)(4326008)(38350700002)(38100700002)(2906002)(6486002)(16576012)(44832011)(53546011)(8676002)(83380400001)(66946007)(26005)(186003)(8936002)(52116002)(66476007)(86362001)(31696002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZhMFluSDJEd1VHeVQxSVM2K0N2NnYrS25maHJKaWh3aitGV3RoUG9aSUZw?=
 =?utf-8?B?NnoyS29ibVRQZGlROTZ2NG9MaC9xdXpGNmttb0c5RFM5M0doV2Y5ZVRZYWpi?=
 =?utf-8?B?VXUrcTlXc2FEcjFlL1g1OFEwQ1VrZzlYdm00NDlCejgrQ2pBU2FhMmU2MW84?=
 =?utf-8?B?djNVM1BjQ3F1ZkFhSWcwVnI1RzlhUDRMQUd5RnJPcUJkdGRCd0l5OFR1NFF3?=
 =?utf-8?B?WXBlZlI5aTVLaWpHMHhybWFCRkJnV0tJVnBYUVhVT2ZvTDBmZHR2VHBEbnFj?=
 =?utf-8?B?dHdJWmp2eU9vYy8yU0JkM205cVFNc2RvR3FKcnZ5NExvbStESHMxNDIyaFFu?=
 =?utf-8?B?WU82SGI1ME11c21MNnJ2cXdYTWdpT2FDQ3IxQUhkdm51YnlmTGtJeFhKTTA3?=
 =?utf-8?B?dnBFamIvSE12VUU1amF2d3NrOGtPY2ErS1RlUjlidk81WGtpOUNGMzlpUGdC?=
 =?utf-8?B?bDl2WkRWQnRUQUJoN0RQcll5b2owbDI5NjYyRVBFNnVOa2QraGRDajIvTElV?=
 =?utf-8?B?Wmw0cDVIZlVJeDlWZy92V0wxUTZZTVB1ZmJGYVIyaTlaQlhFUlJjaWZ2a2Nh?=
 =?utf-8?B?YzJBSkk0TjYxZVZRVXRFcTVLd2xMZG5WT1lsck54cEtWMlZTdFRidDFaTE0z?=
 =?utf-8?B?ODhxVU1aazFlVmVFdjdtM3MxRlMrSVBHYUVNZng4d3VwVUFtSmVXZVNlUDBH?=
 =?utf-8?B?aHd3b1N3UnB5a1ZveUhUdDFBaTRLSksxUlkvM0puQm0rTXBLcThDZEg3UVBK?=
 =?utf-8?B?ZEFmajA1YngxTVVBVHREZEdEVitjaGlERnd0ajlZek50M01zZm5MaHZyZG83?=
 =?utf-8?B?TVBNK3YzWWpZZjkrZnE4RkFYN25MS2VoNUJtVTlWd3h2YWF3amg2MlNoMk8v?=
 =?utf-8?B?b05ZTnV5N3JwMmtHcXJrYlNRZXAwY3J5WVRCK1J2TTB6bmt0c2s0SjE1d21t?=
 =?utf-8?B?ekFqdmFUSjA3SjQ3YUhTakIvV1RaSE5NbG9OMngvSTVxWE5RY01DaFpyZEI1?=
 =?utf-8?B?bkpRdEpWazFyUVhha1hCUEZCais1RVVVc0RRdkpHNnh0eEpSWldvNFNFWDZS?=
 =?utf-8?B?Nk1zSEVWQk1CekthTnpJajZWRURtNjlhRXFiY2ZSMnVJdDFiYzc4Yi9Mak9P?=
 =?utf-8?B?elJ2WHB3ZWtEaTdmb0JIVkRpZXFuR2NqZTlzd0VZczRheTM4NjdlTGlsUDBh?=
 =?utf-8?B?ek91eUxpODZMVG5xREFRMk1RUDZ1REhEQ1ZyZHFFcS9tOTA2U2J6c1ZqbTEw?=
 =?utf-8?B?NXM3M0JkUGF0YjZscys3S0NsMDNFWnNUN3pyNVpvYVdVcHRqanZqK21LemxX?=
 =?utf-8?B?dzlSQVFCWHlOL1NicHh1SHh2d3BPR3ZYYUVKMXlxMEtrZndraVZZUDRXOWNQ?=
 =?utf-8?B?VWdyTEtETUpWM1VIT29aVFZRaWhLTmkyUW9CQTJvOXBoN25FNEpUMFc4M3U2?=
 =?utf-8?B?SGx0QXNDQnhwNW8zQ2xCSmc4bm5wYmYyNEhSZlpaVS9mNjNvOGw0WXRtSllB?=
 =?utf-8?B?bU0yVzhzNWhYYkdva250cjZBVURpSXkrYXIrMVVReHR4TzJISGZWRVViMVdI?=
 =?utf-8?B?VFAwWFlsRURtVStrQmRmcGJkMVM3OEZjdWxCbDRKN0YvbFdoT2daaHhmN3BP?=
 =?utf-8?B?cnZxT2lzMmMvR0IwSGk3ZEhkbFBVOUpTY0Z3RFgwa2F1bjhrYVNqSjVReXg4?=
 =?utf-8?B?NXJrM25vRWYxMWMrKzY0OWN5T0JYekMwMXFRQ0dSVlV0NFNHNFRCb0dzV05K?=
 =?utf-8?Q?hYUnChVg6p5r82FPxkPPf5+MPOZ6nmY8OJkIPco?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e80a487-eaba-4641-bedd-08d94abb7cdc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:45:36.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4WVInvvSg9itRpBGQOhsYTEGsUw9t7EdPwaGx1QyM8DPrVFegUFQB6iuPuzvQ2XBjd684DYgcrwWul9SR9oZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3311
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/16/2021 11:34 AM, Shameer Kolothum wrote:
> Hi,
> 
> Major Changes from v5:
> - Addressed comments from Robin & Lorenzo.
>   : Moved iort_parse_rmr() to acpi_iort_init() from
>     iort_init_platform_devices().
>   : Removed use of struct iort_rmr_entry during the initial
>     parse. Using struct iommu_resv_region instead.
>   : Report RMR address alignment and overlap errors, but continue.
>   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>   on Type of RMR region. Suggested by Jon N.
> 
> Sanity tested on a HiSilicon D06(SMMUv3). Further testing and
> feedback is greatly appreciated.
> 
> Thanks,
> Shameer
> 
> ------
> v4 --> v5
>  -Added a fw_data union to struct iommu_resv_region and removed
>   struct iommu_rmr (Based on comments from Joerg/Robin).
>  -Added iommu_put_rmrs() to release mem.
>  -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>   yet because of the above changes.
> 
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>  Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>  more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
> 
> RFC v2 --> v3
>  -Dropped RFC tag as the ACPICA header changes are now ready to be
>   part of 5.13[0]. But this series still has a dependency on that patch.
>  -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>   PCIe).
>  -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>   discussion here[1].
>  -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
> ------
> 
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
> 
> Shameer Kolothum (8):
>   iommu: Introduce a union to struct iommu_resv_region
>   ACPI/IORT: Add support for RMR node parsing
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add a helper to retrieve RMR memory regions
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/dma: Reserve any RMR regions associated with a dev
> 
>  drivers/acpi/arm64/iort.c                   | 172 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  76 +++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  48 ++++++
>  drivers/iommu/dma-iommu.c                   |  89 +++++++++-
>  include/linux/acpi_iort.h                   |   7 +
>  include/linux/dma-iommu.h                   |  13 ++
>  include/linux/iommu.h                       |  11 ++
>  7 files changed, 393 insertions(+), 23 deletions(-)
>
Validated on a NXP LX2160A with SMMUv2, so:

Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Thanks & Best Regards, Laurentiu
