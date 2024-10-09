Return-Path: <linux-acpi+bounces-8665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CFE997181
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 18:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EF01C2224E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA51E2848;
	Wed,  9 Oct 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kD+e2dRl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05B1E260F
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491020; cv=fail; b=jo68B0D5buIYjyJoB3KjE8EbpXPV0mCyGq4aNvfydgKqVmN84lYabQL+KC6eBA5/TCsNGe2Uc6fxT2mOGrJrO183yK7Cn0RZ89OsW0yUxH5dS9rkD++eL4eR3OwC+D0vQe9X40HrNDRVPl3RbL4cKWjR+5bEzISeZXNsM0Wc+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491020; c=relaxed/simple;
	bh=13XIPhzPixZBnmAScrwHpiKjtNd0BnIIDm76rCNfJnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ox/yOKAgTLOy0bfJdenquLTbOkd3AEWUCO2j71Vmgze2xLc3UK1Z7cnaW2G83vDY/ZA+Oro/k+4jjmkIqK3s3xrsdOakvdTIIG6oTKIt9r8rTWsWcwPTeROPixYF9TfRI7K/Hvk3GYEX+djZfN0jkIFxUsd3eq8nkAxRdBBea8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kD+e2dRl; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSmVXoM08drGa4OfD/E/HbhWBlZfk8+bmuhm/kUdDXdfyfhE7gxGdnSILi305KfEHGC9ZxJIq/Qcx7JU1Z7ZHmfzpiEETkb/J1Zpo6iQEWO9+KQoczGvbsFxx66OKIkt+NcgCh0hlN2XElrgVrwTygqSvH12/tH0pszc77JG0/NiPwKajK9F7alNMN94EmLp/uWh63Fs3kujgJK6lxi/plGZ8xshQiABPfFJ89mnMP/WFZ1yOhHGLhZ8dJH1kgS1vZJWbqHUXNycrNx/KV0m9VDd+W4eKznx2Ug+MTDafkd0eES9wirYYdRDqetOg0SLFYuJE4BW9kCzjpZLaKOCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzkew/fTCrQzoPLzoQu5qlbNv+Zi5AHyETLlK5w1NyA=;
 b=acCOOcZRir9GS2BIlqFmboJiZQP7JAOZTSnnNBzlj3we8WiUQ2ScCpuUggy4v6m7J1FPTvVOGRhGHo86FvBMDyC5+8tVbu4j8i3/nQZC5lKOHYujoWP0Br0lXPONBTmCEEA0T2B2fZYOW2aNJvuCqfLZr6jIUr0rqqcwjpCXHMOoaSRpyIDJrYsFcz8KgkzYVB3A3/W7WBgzz/749V1ItrBxrvqmWGX5SkIhuLGLQ+dXMTympAzZ0oLmVsbbX1bVr3xPuPuxy8WNLhHKN+jywZj69dtRVsxvHlnvrPsBPlU/vhokMmUyirtQMoU0mDmkFDMIeRV+hNtJS9RStZl+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzkew/fTCrQzoPLzoQu5qlbNv+Zi5AHyETLlK5w1NyA=;
 b=kD+e2dRlNg0rWVOcg1LToYNERSHJ6WWMWRjA9O9rKHgGczwC6i5JMJnXRNdr7sIyEqEOreiblaF4fC/+ikWB+KLsXjpA0Vr3Ug7KN4wn8ARdKInKmoMkuY4LYdQ9w1XTm14wszKaizFvRZM44xhujc5c0CghUdpdoL5l9EZtn+rMXoes8Iv/lFiXnr7CYAvq2IUX+7kvFgb1LYTbNvWz6ReC/N43cGc1TjDEDgZkaD1kgIOwAgG2wVEGhZfIepQJPa/RNHznLvyu6dd59FgU0QjC7EvBQoj1XqEFnlIecBtzSyf4NnsEL/5vBDBmdA3tMxnJa8qY1dL6qR4CxHUXiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:23:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:23:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH v3 1/9] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Date: Wed,  9 Oct 2024 13:23:07 -0300
Message-ID: <1-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
In-Reply-To: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF0001641F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:f) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: e155ae1f-5390-4456-fc52-08dce87eaf7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPCKF8SZ7rNa44WlWAahBoRgalYQgwIP6a5BHxqI11Cig7Pt27KSEOO66Yvw?=
 =?us-ascii?Q?R/zSxl4L4HJ4VmW1dR+aaE1DkWBYjh0YqNCaB02sANdxNnaYLCX8CMQYn4rQ?=
 =?us-ascii?Q?/nF6NaL4SWSjCVoM/XwNpokuQ63lgCkbZoZyKxMTv5IvKxHEOg/92vkAA7fp?=
 =?us-ascii?Q?3+F5FnVwEivgsrzsfyrmrTeLi63AKnnsa1JeOPc7aefAaeCo4qHefBeDJppr?=
 =?us-ascii?Q?9JOwnwoKzYzSANWybR5bAiDpH5s0RLucloAROmamKrix9u5l6yyA0WEsdIxi?=
 =?us-ascii?Q?bYR6vUUeymOGSoVyKE+Ld4hf4MmXIFYNTEoqKrlxxLJqWI1pgPaLs8DoFLlk?=
 =?us-ascii?Q?tKfmygfUtq8Xt7HETy7Nkdc+vpkPZQwDSF2XXkJwtrN5Aj0YP39qBLoxST3R?=
 =?us-ascii?Q?U3Ha+E1UTFTBPW5gBBckKRz/A8IoiSGmjcp0arFinkKbD2qhfijhJI4GAAIM?=
 =?us-ascii?Q?bpdtJbSWG7FYgKojgAPNQbqftNK1dX+ju6y4sUaATwU6kYwzMyvZtmO9hALy?=
 =?us-ascii?Q?N0ELXetMdNiLI4M5uBauRc+IGiU81IxYiNHbGtyrFlj4VP6A18BSHUeMHPp5?=
 =?us-ascii?Q?zAdh79GvyRyQZd9WcmQFsc8UY91VaH+PJg/QgmMZsz0LjYzuSPvqDab4XdCJ?=
 =?us-ascii?Q?ViTcN3v7mrXNrltnXa4/+moPEM9XeOEhT9dX/Ikprb1Ahy6oGdW3jhvtNGYH?=
 =?us-ascii?Q?CALBXIhQtOCBXuWxuBqamOgfUbc7sEkOgQhpwslMrlBftm+8tV5+aKNU+eiQ?=
 =?us-ascii?Q?WdOPV8Wz95ytzWaqVzhWJADr6eNzHmqp2TeLTGLKBgZvvqGG6xu164sfpg3m?=
 =?us-ascii?Q?lpcvtu5B6z9iAP9fMVtxWMTjdEVE0lIutUacXizLM3xKRsTTnJ6v+8cUZyFr?=
 =?us-ascii?Q?VzPCBI4nFv8WaBiEa0Yu1wDSOGaV6d6veJrmblpHxTQcESM/DLbCd/lGhNG7?=
 =?us-ascii?Q?fsi5WOtI/7jxZvQ3GRyzaBDQx58eTAcB/JgZxD4aIFVfqYsIvnR2QMSYjAmG?=
 =?us-ascii?Q?aNqMby98UNnpzoppbBDH7gCDBXNPALgHX1zNSlbnFsrBWF7dFeOgHkKTqhQv?=
 =?us-ascii?Q?Zj7VaAKbFs9L+P748g3czJCXyCEP0LkhAqhBrC9tQUDxgrHrQYzxAG3vIAMr?=
 =?us-ascii?Q?R0mACSj1lS75MPE0XkEvdIQhIzuHO4UnPb+yGRYNkSiCM/kVPLHKeT2QVvUo?=
 =?us-ascii?Q?nVBbXg9XG0CGUx8D9yJq6YyRRG6Ji4F0zVoMmSXU9lcmvnb9N8scw2BdgKlX?=
 =?us-ascii?Q?VpP995DbusJyZfKu6g7iO94V+4BGOxwyb+8Hg7s1zdS0aRoH7I6CALVLgp1w?=
 =?us-ascii?Q?Xe0eBgebrM02zhFe/ext8V1D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BwOzHulyjHUPjnoTNpClEdcELbQhxA4EzHYkXaRcRLuwWdhKINkWzAQM6Xt?=
 =?us-ascii?Q?T+Nvg/Rd5yDtCofjcg2vIctdXfoZchU/Tpi3em4KEQgxLS6GS6t1eyVGcOKe?=
 =?us-ascii?Q?edlJSl3KlIAUOGJZqTVhPnnBbqwmp7gfMuUFi7P/BF7EXogMEZmTtyKFyH0p?=
 =?us-ascii?Q?+PlY9TrvshOrGwBT3xQerMdcIukeeBt+Q3h57dUSXcPeUDl82b5L9JK8eC6Z?=
 =?us-ascii?Q?gBgOKrXC186+16yFZKdS2HrwOFyh4bZb0DN6HkaowiPaIEK1t3l8LzCEyiRD?=
 =?us-ascii?Q?eQqa7tjuYJ4sHgc+y7sXt7EJXMOK5wH0FpjZiH4G9iNn1S4D4vxm7TQxXnBG?=
 =?us-ascii?Q?ekTocKjcsq6bQmujPlf1KDJ7PSKSd7qjDHUBxPOwts6hyqouy/WUgHC5XVG2?=
 =?us-ascii?Q?tM9TOGowYGf1VIQsdCW13buDieMuHWPacHXkxynUGVZEameLNqIZO/6xLshB?=
 =?us-ascii?Q?8HLdMuwpLAlEcy+C5l6qE3/KGQGu0G7ilyKjYyaeZXCoL2wKQBGSalqV34Y5?=
 =?us-ascii?Q?CR79ARjjq3yUQ7VlhLT7zhSASJTWrTk+z40sqkF6TI6mnGj0AtSj1fS/dvSx?=
 =?us-ascii?Q?Qseln5OhnPcy9z5DmrTH4B5o19B1dcPSo7clWKi0ml6XL4hFxGp/KnkFz+ev?=
 =?us-ascii?Q?RAMz4xkrBZhlYoN92+Cs6w83zvR2jZdnKJ05xe7L66L3eNXj6qFgzC7GQgZ5?=
 =?us-ascii?Q?WnvVQXImtEZ/CydualZX2D5HsPVxZFyI4Y8+rBDBANHBsVP2XnnczZortfoC?=
 =?us-ascii?Q?eipriQlb9OO7gbmvulBu35mvnuE6Yx3RVtXgGPVdKEPWYGNlhdMvsITng/r8?=
 =?us-ascii?Q?bvIMCMhkeeb1PEaKTG6Fl9liq00eH+sT+LOseiWdvFggXq23kHj33b+Mqs7+?=
 =?us-ascii?Q?2sW+QWzh+1xJHF4IjjLT4wwYx1D2OS+QtAgVtclHwPDd3q9YccTsIa4dLW7S?=
 =?us-ascii?Q?1VKtMaHsqPKsmW6rVTO7JZJUqyBfAJtvNLPTX6FuQ49sEGCozTlb6s1Zmth+?=
 =?us-ascii?Q?hOs3aJElSHfPm6QoSBPN19WQctf1SAA4pxF4N5Xyrn90FJYq6w71zxOkDyZi?=
 =?us-ascii?Q?YS66SEnVw0kKIG6id1Ml0XelnPZQ4JZ5Kk7GVdocVucH7bYbxx96zQPmOJ0i?=
 =?us-ascii?Q?hWRr/e922tTtG+TKd/4xTu4rN5hJFu3yhx/OE1yL2yey33axJKvqyFnOAWwU?=
 =?us-ascii?Q?y3ecPcg82pB9R6ncv+l3zwuU7qkWs1umGC6KFs24+Ztsv3anYsi6GPQle+R4?=
 =?us-ascii?Q?dBJgVjPhKGmPYJrUezHozFRRPlZMHMz61tKeCyzMzT8+VS5ffFcYpztb7nsy?=
 =?us-ascii?Q?UXZhVtDfOBpkflSLi5/sAeK2osYWU2+Fv44xEYuZL5IKuYiWU5VLEGm6NNtl?=
 =?us-ascii?Q?rU0q0ka8Pg1LejL00TlWPA0nitD2fX/ROVayC94lqvAIzvOwbOBUo8Zlhtng?=
 =?us-ascii?Q?JyzbAwlf1CM1HWkNstf9+67gkQWCu2Gtdt4OTkf+i+8c/Y/6zSAphU26KtH7?=
 =?us-ascii?Q?VvgeFT1Qdpm+fus0kShB5TSdJsGB2rM96pD3ujkBw5p7WjKN8fktuNaHU9Ht?=
 =?us-ascii?Q?lJYnCYDdSoZUsndhw6k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e155ae1f-5390-4456-fc52-08dce87eaf7a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:23:18.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cycn3a0f57uU8wOGgWZJin6a208dxnAuRyfYd8lzQzEF6W1kB0jZsRqCuMDSD+o2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

This control causes the ARM SMMU drivers to choose a stage 2
implementation for the IO pagetable (vs the stage 1 usual default),
however this choice has no significant visible impact to the VFIO
user. Further qemu never implemented this and no other userspace user is
known.

The original description in commit f5c9ecebaf2a ("vfio/iommu_type1: add
new VFIO_TYPE1_NESTING_IOMMU IOMMU type") suggested this was to "provide
SMMU translation services to the guest operating system" however the rest
of the API to set the guest table pointer for the stage 1 and manage
invalidation was never completed, or at least never upstreamed, rendering
this part useless dead code.

Upstream has now settled on iommufd as the uAPI for controlling nested
translation. Choosing the stage 2 implementation should be done by through
the IOMMU_HWPT_ALLOC_NEST_PARENT flag during domain allocation.

Remove VFIO_TYPE1_NESTING_IOMMU and everything under it including the
enable_nesting iommu_domain_op.

Just in-case there is some userspace using this continue to treat
requesting it as a NOP, but do not advertise support any more.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ----------------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 16 ----------------
 drivers/iommu/iommu.c                       | 10 ----------
 drivers/iommu/iommufd/vfio_compat.c         |  7 +------
 drivers/vfio/vfio_iommu_type1.c             | 12 +-----------
 include/linux/iommu.h                       |  3 ---
 include/uapi/linux/vfio.h                   |  2 +-
 7 files changed, 3 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b88235510..acf250aeb18b27 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3378,21 +3378,6 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	return group;
 }
 
-static int arm_smmu_enable_nesting(struct iommu_domain *domain)
-{
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	int ret = 0;
-
-	mutex_lock(&smmu_domain->init_mutex);
-	if (smmu_domain->smmu)
-		ret = -EPERM;
-	else
-		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
-	mutex_unlock(&smmu_domain->init_mutex);
-
-	return ret;
-}
-
 static int arm_smmu_of_xlate(struct device *dev,
 			     const struct of_phandle_args *args)
 {
@@ -3514,7 +3499,6 @@ static struct iommu_ops arm_smmu_ops = {
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
-		.enable_nesting		= arm_smmu_enable_nesting,
 		.free			= arm_smmu_domain_free_paging,
 	}
 };
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8321962b37148b..12b173eec4540d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1558,21 +1558,6 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	return group;
 }
 
-static int arm_smmu_enable_nesting(struct iommu_domain *domain)
-{
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	int ret = 0;
-
-	mutex_lock(&smmu_domain->init_mutex);
-	if (smmu_domain->smmu)
-		ret = -EPERM;
-	else
-		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-	mutex_unlock(&smmu_domain->init_mutex);
-
-	return ret;
-}
-
 static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks)
 {
@@ -1656,7 +1641,6 @@ static struct iommu_ops arm_smmu_ops = {
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
-		.enable_nesting		= arm_smmu_enable_nesting,
 		.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
 		.free			= arm_smmu_domain_free,
 	}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c588..dbd70d5a4702cc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2723,16 +2723,6 @@ static int __init iommu_init(void)
 }
 core_initcall(iommu_init);
 
-int iommu_enable_nesting(struct iommu_domain *domain)
-{
-	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
-		return -EINVAL;
-	if (!domain->ops->enable_nesting)
-		return -EINVAL;
-	return domain->ops->enable_nesting(domain);
-}
-EXPORT_SYMBOL_GPL(iommu_enable_nesting);
-
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirk)
 {
diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index a3ad5f0b6c59dd..514aacd6400949 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -291,12 +291,7 @@ static int iommufd_vfio_check_extension(struct iommufd_ctx *ictx,
 	case VFIO_DMA_CC_IOMMU:
 		return iommufd_vfio_cc_iommu(ictx);
 
-	/*
-	 * This is obsolete, and to be removed from VFIO. It was an incomplete
-	 * idea that got merged.
-	 * https://lore.kernel.org/kvm/0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com/
-	 */
-	case VFIO_TYPE1_NESTING_IOMMU:
+	case __VFIO_RESERVED_TYPE1_NESTING_IOMMU:
 		return 0;
 
 	/*
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index bf391b40e576fc..50ebc9593c9d70 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -72,7 +72,6 @@ struct vfio_iommu {
 	uint64_t		pgsize_bitmap;
 	uint64_t		num_non_pinned_groups;
 	bool			v2;
-	bool			nesting;
 	bool			dirty_page_tracking;
 	struct list_head	emulated_iommu_groups;
 };
@@ -2195,12 +2194,6 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_free_domain;
 	}
 
-	if (iommu->nesting) {
-		ret = iommu_enable_nesting(domain->domain);
-		if (ret)
-			goto out_domain;
-	}
-
 	ret = iommu_attach_group(domain->domain, group->iommu_group);
 	if (ret)
 		goto out_domain;
@@ -2541,9 +2534,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	switch (arg) {
 	case VFIO_TYPE1_IOMMU:
 		break;
-	case VFIO_TYPE1_NESTING_IOMMU:
-		iommu->nesting = true;
-		fallthrough;
+	case __VFIO_RESERVED_TYPE1_NESTING_IOMMU:
 	case VFIO_TYPE1v2_IOMMU:
 		iommu->v2 = true;
 		break;
@@ -2638,7 +2629,6 @@ static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
 	switch (arg) {
 	case VFIO_TYPE1_IOMMU:
 	case VFIO_TYPE1v2_IOMMU:
-	case VFIO_TYPE1_NESTING_IOMMU:
 	case VFIO_UNMAP_ALL:
 		return 1;
 	case VFIO_UPDATE_VADDR:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f47363520..c88d18d2c9280d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -635,7 +635,6 @@ struct iommu_ops {
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
  *                           specific mechanisms.
- * @enable_nesting: Enable nesting
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
  */
@@ -663,7 +662,6 @@ struct iommu_domain_ops {
 				    dma_addr_t iova);
 
 	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
-	int (*enable_nesting)(struct iommu_domain *domain);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
 				  unsigned long quirks);
 
@@ -844,7 +842,6 @@ extern void iommu_group_put(struct iommu_group *group);
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
 
-int iommu_enable_nesting(struct iommu_domain *domain);
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 2b68e6cdf1902f..c8dbf8219c4fcb 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -35,7 +35,7 @@
 #define VFIO_EEH			5
 
 /* Two-stage IOMMU */
-#define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
+#define __VFIO_RESERVED_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
 
 #define VFIO_SPAPR_TCE_v2_IOMMU		7
 
-- 
2.46.2


