Return-Path: <linux-acpi+bounces-1948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7787FE6BC
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23C31C209A9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371FB13AE3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CFU4n2BF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C192122;
	Wed, 29 Nov 2023 17:10:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEOSp8LojpsztFQ8MpYwW1O2ZIAzxkf4yNWGaAHXOP3wtasQGMdqQIgQOwIn75VVsPxrC50hZIav58EgbboU7u3p2yy17WNg66fUqW4ya6IAfIK/SzFCQQ+alGIpySdIviym/D5LjAuB6/IRml9+I9bW+ELetDpfrzVnOPU0NBMvET7dzsyrN/GaPsvGw/2uMPzefJ3ArzCf5K5miJZIZN1eHibC5i5rqc6jKDoq/bkFf2G5uWnP8xHhyiUyBflkEquteOzK91GB+x4bRWFbkYXIEKMXW69qi3b5DOBRtGzWdjgxJaf4UEmCv8V3wEN1KNjs4MJzEMk33dho0dq6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjJdDHI+AITYfSvxiqF0GgwRht7dfBc7a3uv3e45GaI=;
 b=GKLgIPTMxJQ7NkYjBKcLmz51v0Cys/F/zSlUN2ttpMgFJQ8RZuQLVpirZUB7J7uevu3d7SZ+OmW43RYnrBiLChSCx/TnvwHJJ+rEr7oY1xxKfoUajs2LK2ZymxQucQl+cixGXFQLt01DmM4BwpCqsx88sKfj4XAlUUZSEbndwmK1EWYV/BBPgLm6QRg3FKzYTpv3f7sq+BTUBUT21ule5K8L60DMSgJkMdVmv6B1BGxZacRCP3cjXsT4nfkpM1EuhjMsgHgLtwYag401qwMO2Up16wq7y3sjjzRh3aAjY5EnCvK49turPnnksVoq3/DfyJRkPYLRqGoEUZC93lzaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjJdDHI+AITYfSvxiqF0GgwRht7dfBc7a3uv3e45GaI=;
 b=CFU4n2BFkMtpGDmXngCQHuDXXqTcKhUIr1Fq4tJ7qnavTr79R6AefH0F8r/rN76tlm6OhOtfiM8t/i+B2Os6faeQ7vDe8LmIbp0b2x75f2/ypOhEef+21WrroxQPpV0XP6jSc8G1J9+18bV6/aexU9rl36nwOqsSHD4b+ykq7dGCBRkx3c5oK3tLyYmJNyLIZs0BLq9xNp37fX5ZUG+RaY+Nt3Pfdfc/Asi9hidM+IWKMGrH/3RyyDA7IIgvkfX01DIOl71EDOTjonuz+zdcltMG6tJvY0CVsh1tqRavKct4/b+Oh2E+n5dEPb8j4SdouM8t7DMyCjXOO4xP03euQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:42 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Andy Gross <agross@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Bjorn Andersson <andersson@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	asahi@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Kees Cook <keescook@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	virtualization@lists.linux.dev,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	patches@lists.linux.dev
Subject: [PATCH 20/30] iommu/ipmmu-vmsa: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:27 -0400
Message-ID: <20-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:805:ca::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e29a214-41ce-4329-91e6-08dbf1412a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/RJ2KekhIZ/9FvZTbwgp3tGsaW2gq7WODqPGvmzeDxCk+0v0u/c+Y89nkoST/WWkvPvCw7SkEPScltSJiufLl47hdBiukrGJY2Z1yDudK8eAL0LJyiPad3WxmLLzrcOubvSAK1c1MuVqPcVWGIqSRJ0kiIabj32gv+7TlGvPFElgqC7JOaHXTvlWqUxcARkiQS0z6serUy2ChPT5HNJZWeyRhAw2mXwnw0uzGy5Cw4DYZJMbIhOeZHUE8oDMo9nKwRnPcuhYSogcdGq9xMoWNuX1qCOorYwlRZB0atcD3xytrcHGBNi+GVvBKWkaPYnHTzM33B1Vm/GMqeERd4N6inrSJzeIJkR/aEgsUHrQny0z/1SFYdZwfUnqWdIqyuNaTcDvx6cjyToqnKF9zIfNMaDawLV3rWzPCc4YMsQn3qGBW21RakgZlXjlyKcswcJYJsozWZh3n1gvN8r03yg8Px4+svQ39E9dnlYUhozPpLZh3ZC4ONIQyn6/GJQtlMIKv7rWgDg466eD/7pSmO45S5ra9tdb4dh2aroXjSfOXrLZ1PEUYnelXd+7MEHNK5u2jMgmuy7b8QxptGJEchwu2fSus+ZNFSj5kK/83+eClCfKH3nRjafLNSmj+Aya97MntnoQMSkwKhdvVDAyTFCOXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbImv2xeatnCFPsd9Do35WSABEP6L5JyzhkK9KNTExS80+lNlERWh60T46o0?=
 =?us-ascii?Q?8+1tBoKrM/maC37DnacXdjqL//8bPhH19ucd82MKskkSGgjoSDxjg3AfuDtu?=
 =?us-ascii?Q?FCM0Q0/7+h9UGVjexvBp1MVrxS1N+xVVQRnMwximw6LuswtoTDxCcP4McOhn?=
 =?us-ascii?Q?2OeufuizSoO7lnmvZ2E9GOUNcGTQEkXDdWO3zv4DPMQ1ZDFMidS9qVL31DKd?=
 =?us-ascii?Q?V/EgKgC22fYRW5Nhw74BhuCuE4W0ODM/LgupUzmsgBm2+cmnDvvkd7FKV7vD?=
 =?us-ascii?Q?BYJ6RonLsrR20nm2NW4tH6W9OiOgy3wC25/7Xba7jaHnT7DhhVu/TThZbiyy?=
 =?us-ascii?Q?5DYIQIpyIme2EQKVf2CMH4bF6ypVshgUSh9bEc8Ku32zZ4IRGXLR8sCu+P3q?=
 =?us-ascii?Q?7tJbBc2Q6aEE0+Y2pHRiHMzvtZt+tM48s7KKVUyMzdio2lBHWeKdLY1TOm9P?=
 =?us-ascii?Q?JDhVOXhJ3eGHN2M2XGtqr+HneC3mo1nJDOfLk97OrtVL+bbffZ7w3BX22P25?=
 =?us-ascii?Q?+DM9ePBSb02PeuNLEe94why6eP13hpjXz7AoFd7rCDGKAGcVxmwHL5JneTe3?=
 =?us-ascii?Q?dO7Dkd5Qw0YP3Ddb/7tNRWAfgR9GgGAIvIDOG6kjFnZMhzntzwy5+wukj2ty?=
 =?us-ascii?Q?X2ELazEGa+Kd8aMqL9RLOAV4a1c0c70jJawRWOxlBrbRf7eQyns2yxn1VCHa?=
 =?us-ascii?Q?3XpS6EUUYsvM0nrChxiXVL52xCGleUamUon6dsyUO9xAxzLVj4Uz94fq9Ezj?=
 =?us-ascii?Q?7OMzdQvupPhrfWz+TOP56A+YWgEJbKSg2SxNri032dje8VBrhsLYi3eXZO+o?=
 =?us-ascii?Q?evJld/uNwT7/Q6QZl0A7AFjpeBxHn7uuwN70s8xIfYds9Oytbh8myqwT4nk1?=
 =?us-ascii?Q?rXhciM4rXn1m28pFYwXNsv4wN/UjEMhb5+YAT3fPukQfBs05ZAsZ5n16Qs2+?=
 =?us-ascii?Q?+Bzif8RFG/QlxF71rYLGh5FZq/D1+uD2q7rdvEQECx1242W0BR4SD9skg7V5?=
 =?us-ascii?Q?6t4A76rEgf5diPUro21F6+GaTNmrUhSoSPaYFddcTxUi0y4dmdkHSSNIpY+N?=
 =?us-ascii?Q?1JCpEXFwPuLKnn/UbRp1K4Knxl//dTXGDgCA9Gq76Nw232FCy+fcXA2YUmVp?=
 =?us-ascii?Q?PLoMXUNxt+Hka/slaumbCk64R+G6St7OpLptWdByI8ux2iXAi0CKJK5meEJ0?=
 =?us-ascii?Q?pJGHB3uQR1rPYpQy66HVyN1iCoSLD9skLca3PPWlJTW/HcnWOfpMCfbYuXP9?=
 =?us-ascii?Q?fqP+CIY+IwKJ07V99f6YyTLNDJBEvoed8KWBZxQBhr8r5+q3Hy64R4XyuPDA?=
 =?us-ascii?Q?p9atbM+aGceMBhPsWNZNSOrhJr2gPvkMoWLcmDskiCSZ6DdIy5hb35lnwvm5?=
 =?us-ascii?Q?kjx3pFVCInuBxdfcsQM7REmRVeS6pmE8VsBEx/h7cjw5qw9yuZIf0PQN5hYV?=
 =?us-ascii?Q?zI75RP7k7xiZNmZTdW9ElxXSRBXVW/6OV6wbl70fk2bquV3dSOXGoI/IMjEp?=
 =?us-ascii?Q?BcRzYYfaHL4y8nfvzBwMIkcBWaXcwj2m3b2DjR1c+5Y3WBNnuySl9NkumIRR?=
 =?us-ascii?Q?Br1UN5+J2vcDahmj34GFZeiQQPjeYzG0IOSRgBR9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e29a214-41ce-4329-91e6-08dbf1412a6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:39.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPEmXM+q46raBIV/5oEHOHBYtvZgcViHkkaCMolPMmkVRH+fJO7gv4pqjqkrRr/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

ipmmmu-vmsa supports a single instance with multiple ids. It has a special
check if the device is permitted, move that to the top of probe. Use
iommu_of_get_single_iommu() to check and obtain the iommu device.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
ipmmu_of_xlate(), ipmmu_init_platform_device(), and to_ipmmu().

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/ipmmu-vmsa.c | 96 +++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ace1fc4bd34b0f..ba984017065f98 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
@@ -38,6 +39,8 @@
 
 #define IPMMU_UTLB_MAX		64U
 
+static const struct iommu_ops ipmmu_ops;
+
 struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
@@ -67,6 +70,12 @@ struct ipmmu_vmsa_device {
 	struct dma_iommu_mapping *mapping;
 };
 
+struct ipmmu_vmsa_master {
+	struct ipmmu_vmsa_device *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_domain io_domain;
@@ -83,11 +92,6 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
 }
 
-static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
-{
-	return dev_iommu_priv_get(dev);
-}
-
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -591,9 +595,9 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
+	struct ipmmu_vmsa_device *mmu = master->iommu;
 	unsigned int i;
 	int ret = 0;
 
@@ -629,8 +633,8 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_enable(domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; ++i)
+		ipmmu_utlb_enable(domain, master->ids[i]);
 
 	return 0;
 }
@@ -639,7 +643,7 @@ static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
 				       struct device *dev)
 {
 	struct iommu_domain *io_domain = iommu_get_domain_for_dev(dev);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
 	struct ipmmu_vmsa_domain *domain;
 	unsigned int i;
 
@@ -647,8 +651,8 @@ static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
 		return 0;
 
 	domain = to_vmsa_domain(io_domain);
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_disable(domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; ++i)
+		ipmmu_utlb_disable(domain, master->ids[i]);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -708,20 +712,6 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	return domain->iop->iova_to_phys(domain->iop, iova);
 }
 
-static int ipmmu_init_platform_device(struct device *dev,
-				      struct of_phandle_args *args)
-{
-	struct platform_device *ipmmu_pdev;
-
-	ipmmu_pdev = of_find_device_by_node(args->np);
-	if (!ipmmu_pdev)
-		return -ENODEV;
-
-	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
-
-	return 0;
-}
-
 static const struct soc_device_attribute soc_needs_opt_in[] = {
 	{ .family = "R-Car Gen3", },
 	{ .family = "R-Car Gen4", },
@@ -772,24 +762,10 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 	return false;
 }
 
-static int ipmmu_of_xlate(struct device *dev,
-			  struct of_phandle_args *spec)
-{
-	if (!ipmmu_device_is_allowed(dev))
-		return -ENODEV;
-
-	iommu_fwspec_add_ids(dev, spec->args, 1);
-
-	/* Initialize once - xlate() will call multiple times */
-	if (to_ipmmu(dev))
-		return 0;
-
-	return ipmmu_init_platform_device(dev, spec);
-}
-
 static int ipmmu_init_arm_mapping(struct device *dev)
 {
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
+	struct ipmmu_vmsa_device *mmu = master->iommu;
 	int ret;
 
 	/*
@@ -831,16 +807,27 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 	return ret;
 }
 
-static struct iommu_device *ipmmu_probe_device(struct device *dev)
+static struct iommu_device *ipmmu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct device *dev = pinf->dev;
+	struct ipmmu_vmsa_master *master;
+	struct ipmmu_vmsa_device *mmu;
 
-	/*
-	 * Only let through devices that have been verified in xlate()
-	 */
-	if (!mmu)
+	if (!ipmmu_device_is_allowed(dev))
 		return ERR_PTR(-ENODEV);
 
+	mmu = iommu_of_get_single_iommu(pinf, &ipmmu_ops, -1,
+					struct ipmmu_vmsa_device, iommu);
+	if (IS_ERR(mmu))
+		return ERR_CAST(mmu);
+
+	master = iommu_fw_alloc_per_device_ids(pinf, master);
+	if (IS_ERR(master))
+		return ERR_CAST(master);
+	master->iommu = mmu;
+
+	dev_iommu_priv_set(dev, master);
+
 	return &mmu->iommu;
 }
 
@@ -857,24 +844,25 @@ static void ipmmu_probe_finalize(struct device *dev)
 
 static void ipmmu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct ipmmu_vmsa_master *master = dev_iommu_priv_get(dev);
+	struct ipmmu_vmsa_device *mmu = master->iommu;
 	unsigned int i;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		unsigned int utlb = fwspec->ids[i];
+	for (i = 0; i < master->num_ids; ++i) {
+		unsigned int utlb = master->ids[i];
 
 		ipmmu_imuctr_write(mmu, utlb, 0);
 		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
 	}
 
 	arm_iommu_release_mapping(mmu->mapping);
+	kfree(master);
 }
 
 static const struct iommu_ops ipmmu_ops = {
 	.identity_domain = &ipmmu_iommu_identity_domain,
 	.domain_alloc_paging = ipmmu_domain_alloc_paging,
-	.probe_device = ipmmu_probe_device,
+	.probe_device_pinf = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
 	/*
@@ -884,7 +872,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
-	.of_xlate = ipmmu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
-- 
2.42.0


