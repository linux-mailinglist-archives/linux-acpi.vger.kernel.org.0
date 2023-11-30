Return-Path: <linux-acpi+bounces-1965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB47D7FE6D5
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAA1C20756
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660F415485
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qUzNgBO+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B310A;
	Wed, 29 Nov 2023 17:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USTuXHmK9Yve50+rPdo4WGbIIiOmphE+Th3lmWyNB9fKIhzYZWaqYFffCAKvhey4k0suO1/Idem4tgdD7VLTDmwdvj/K/Zc/4tLUigtwcd/y43+e9yjqdo4+gq6kkdvTUzeeeezN1gGv8RjeKrBuEajHJ58NmDHQ5SL4aE+nBNvbCzPQ17fSjXCFnA9jzpsDcTPoo13NOS2IfBwp0YuRIP3kCbLBonQzJHStxg+EvYwANjuCpQ19Fj1Lve/qr2B5rha4EpMGMsQW0UTNdqt+21oD/uYL0UeZTV1ELRu/SqA04J+s//h8oAWCF6zlsJ32yWB5YdDyvvuuFULnpv+jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVSr9+bQP69hK+Giq+u9FoxDlVZiQRDX7oYqcWOEYLw=;
 b=RfuNUbceIX+fMVB/97Y19iu5ygkF5v5OMMyjLkYVPv5zAbbswGJRtbcXLJy0plggwoR1ofaMwXZZBbMi92MIFIwnqDSwVZeEuAdmcpxYkEM09pf2RrpySoQuJhU4gEcpvzLb/P8X6Lcqy9Oz3/rKO3Y6JyvxApgwD8sMxvBBDDTeZhEgEkpBtmu81IKCeh37YcvfEeJiZAnPchRuMpcMqFIZjVvQNotpwQ4ZCIfo1Fe9Wmr+tT+Qpg95EQR+cqu95s5lZnYmqSUAfvOXS357aNJ6byWmJx9pDWVE9LjaEUdauRPkyJxRO1APrSqErSYWGkG3PeDCWQt2dmqwfTuF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVSr9+bQP69hK+Giq+u9FoxDlVZiQRDX7oYqcWOEYLw=;
 b=qUzNgBO+o7gXJ1qy8tdR1rnxs4iyg4ZBn7GmWgXmnhP2WMGfJYK2NhgvSm0AqDPuPGbX0Sz5PaeGEPeRutml62wF92HXfVT5nHA5PR+PyULp44S6ER4d+8rPBwch4KPdxum5ITHjapFNaGS1B37+PTulaGnE55N0Gqe5d3GaMn7x6kk9YlrWzo8K4djwWMdoAnLrwOhaP+JXIvAA7kOPv7BBpcZaugR0CbkUbnPdRrocg8Ve5qmkw+ZiVrtd6aFprMs4hkf5zryIBTpp9+FLmSMxxa6cA016W9FY5KlhE+N38icGnuda3TAsLuG29RtNRjmGcAYHiizAiHlJ3JjU5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:50 +0000
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
Subject: [PATCH 22/30] iommu/qcom: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:29 -0400
Message-ID: <22-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0110.namprd12.prod.outlook.com
 (2603:10b6:802:21::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 724c4ab5-7a07-4e75-5bae-08dbf1412b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O+TTURoAd06a5nhc1hEqPMI3UF8xNQp/QEVs/OUUBk0iMdto60WmWpf0sfwLRxPgM1BswcDjOFzMZx/5EE0DCvqWUNUGIP7cP+8bGBieThqSlPuA7qKb3DdTBxPgZzWsZ2ad4o0usd2s0iGKLXdw6Duqld/uNibwRtS10IRhkVxe8pgTKJ6pThePbAAEHB0fEYNbAWAlFKa9O1+jrjKeYWMvt4cxZeW0Z8fuoV3BmuRIYGYy+YNxYJs3vp2iJsmrKj5gm5hVv8/yMhSH/6OteNodtVk5QWub0hg2h5ZAZv+h+jh0GrLCYG5ZKTs6g2rB/1Lxc/+enNHqRU7Q8EOiF9+Gz7Q9LJ4MzLcH+7lI6NuuK8pK0V0pytzM1220Y0lkDfjhkEfVl9KVlKDTJVozKo2kF6vsiKI1Ge9F2dNdGYQULwTsrwWExe4do2X2vmy96DkOrRTU88xIqPrYguEMepRXMes+ZNJFZxi6uvTl14mdPgjlnA20EWX4kSQ4Ju8Z+JCotFAx7NmaYU48A3HT4bImxGGSX3ucqu1HrY7cLGw2POV7xR26GUCGvUy+AbU0+LGp+FdyU432yfHwR+G2oWxy5QQqEPD1HvuDmcdEKqEdH8TSnDlyUCBdWo1xi40I6gAo8qPCbXlrfA7NClCCsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(30864003)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vEIPybqBLOiEuo3wsynDBlSBXaFbdYbgJaHD2oWwfj+LAKucVu0ZJpP3YhRq?=
 =?us-ascii?Q?X0PGwcQOcTzO5ihXrB46zlTwSqguYit90dUKLwjVdoOuNPzhYAipOMOb+4Lm?=
 =?us-ascii?Q?bE0pnGXxEQ7sSmcBHtNYr/wSFjYvmXSSpY/CPvf+pIaJqcWB0MRWc8Ma+og2?=
 =?us-ascii?Q?CipW+bze01eNmWb2JZOqUCMNh9CPFRwj1xsIHzSzGcZ84ssKj4GRrUaKkTAW?=
 =?us-ascii?Q?/mdOvwdX8PmdvTffsjNZqJJe5bJA5vjCSupEE6aHODwB5JLf9A1v4t7Xo17o?=
 =?us-ascii?Q?M2GFVMZQw3Bpvrcj+0CNIeukF+KDsWsCTTNb+iFBg2UbKoOl1gDNqjkt+VJu?=
 =?us-ascii?Q?jaOWwaD5xtiA2Ud56vA1e7aXFU/+NDM/DvCmhRweJ2FV3B6UQVoPPqBG5Fhp?=
 =?us-ascii?Q?2sUygZqUVZ1HWIW3/UE/JhYvhRB943UGO3GrfWleyY/qmCBLKc5tI08eukC3?=
 =?us-ascii?Q?hPpxiWKs3umDUHQeIM4VZvSOzOXVDEm/gNGFBtCGRoGOcF29Ozfx3dqFL80z?=
 =?us-ascii?Q?w/Qic4xYFBR0qUdA+uS/RL62GwEO0wU5WwJRfyj9d5kY5+o3wIPp0c0+xTJg?=
 =?us-ascii?Q?pbJ9L7HMdoruiBRaQos9Bmi0pE9TQbANrJ8i0sEZ0smGeiKKKLNOrzPT5mQk?=
 =?us-ascii?Q?tpEXGyacpSS+uqiCr0sAITBBn9oWYVZgdejrnDodhliZ6qWn0cyBKp0huiJs?=
 =?us-ascii?Q?wQclonOJV9Gr7Swx8QvXH1TC9WCO8KWOC6R+Qe52ZBq+LI47S92ccuchTKTq?=
 =?us-ascii?Q?ORKcf+l8GkZRDKUv9sSs1NsTtvOU4k/M48X2txz3i5Ertm2YS/GOi99/Rzzu?=
 =?us-ascii?Q?6FFjMNHV2R5amjd+AaRYTM7VEdwpqrU6aD5xRbsJMHKJZj/CKHf6yYKeCMRL?=
 =?us-ascii?Q?SfSb/X5cLern8NsVvR8eLxy/WZx5vbo3SfjUFqah8S2sjf7D0qRBcUwnKf0i?=
 =?us-ascii?Q?Ih+dwPV+pUhtcqjIflfYC9NhKKBqBl1g2Y2AGIqXnWdYzQVvkor7o5kj/h9h?=
 =?us-ascii?Q?czJC1QlS7xSm2F9GUIaCy4AxLlqtc9Pz3nE9EiULD/Ppe+bXceBRf6GHnvuT?=
 =?us-ascii?Q?d+bxm23VJ8UYRwouOsQyzhEN3CRgHc1ipRERxmhyUn77WAI+HtusSeofn3ki?=
 =?us-ascii?Q?RcKiEnKqMSWiwdLl7f5xbhi7n1CudL5CiuvGhn5DQMGlgZ+8kBqw/bzF2Ggt?=
 =?us-ascii?Q?V3uCe9V7V2U1HjZvgNblTMReqd/QlWVc+AfPaONwwXLSKdKR8Y8Iwxk/Ag8G?=
 =?us-ascii?Q?kYOODVGlRFrITOj4h7G56UM8K6oqkpuxIso+bQO6CuIowpCLZnnSgUb6H5O/?=
 =?us-ascii?Q?uXaBlpPQb/9QKo8qw/C3FB/Q6oQ4BDa6DQTOQ8oFWfvLVTDHoCxeIFWqDVIQ?=
 =?us-ascii?Q?BNBGymISE3KF2l4w3lfMWhfyzIiH8A6oB3Ml4V5SE4OeEJyWFvETCMvJQZmg?=
 =?us-ascii?Q?GSfp90tVOPQvuMLPIk5XA6scj++xIh2Y3wj9TY7cqgEmSfWlM6B9MaOkItm/?=
 =?us-ascii?Q?PIbls66OU8DWYA1+WVwMevvxeDZ/fwpURfbyjeqfadUKrdMV+E+9i5l8M7SL?=
 =?us-ascii?Q?rznQxtKTDoqjeyh2iEKdjK5Q2Csv0oqrHtMYzXp5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724c4ab5-7a07-4e75-5bae-08dbf1412b96
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:41.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHNY0/XFKudzaiQDGPMOffWaW/5YTl7Yg2HEy+dh2h1S10ihP0NQa7LaOTuM9PsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

qcom supports a single iommu instance with multiple ids.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
qcom_iommu_of_xlate().

This already was checking that all instances are the same, it is now done
in common code.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec. Store the per-dev data
in the qcom_iommu_domain instead of the iommu and fwspec pointers.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Remove to_iommu().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 161 ++++++++++++------------
 1 file changed, 81 insertions(+), 80 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 33f3c870086cea..4baca45df99971 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -17,6 +17,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/kconfig.h>
 #include <linux/init.h>
@@ -54,6 +55,12 @@ struct qcom_iommu_dev {
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
+struct qcom_iommu_master {
+	struct qcom_iommu_dev *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct qcom_iommu_ctx {
 	struct device		*dev;
 	void __iomem		*base;
@@ -68,8 +75,7 @@ struct qcom_iommu_domain {
 	spinlock_t		 pgtbl_lock;
 	struct mutex		 init_mutex; /* Protects iommu pointer */
 	struct iommu_domain	 domain;
-	struct qcom_iommu_dev	*iommu;
-	struct iommu_fwspec	*fwspec;
+	struct qcom_iommu_master *master;
 };
 
 static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
@@ -81,7 +87,7 @@ static const struct iommu_ops qcom_iommu_ops;
 
 static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
 {
-	struct qcom_iommu_dev *qcom_iommu = d->iommu;
+	struct qcom_iommu_dev *qcom_iommu = d->master->iommu;
 	if (!qcom_iommu)
 		return NULL;
 	return qcom_iommu->ctxs[asid];
@@ -114,11 +120,11 @@ iommu_readq(struct qcom_iommu_ctx *ctx, unsigned reg)
 static void qcom_iommu_tlb_sync(void *cookie)
 {
 	struct qcom_iommu_domain *qcom_domain = cookie;
-	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
+	struct qcom_iommu_master *master = qcom_domain->master;
 	unsigned i;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 		unsigned int val, ret;
 
 		iommu_writel(ctx, ARM_SMMU_CB_TLBSYNC, 0);
@@ -133,11 +139,11 @@ static void qcom_iommu_tlb_sync(void *cookie)
 static void qcom_iommu_tlb_inv_context(void *cookie)
 {
 	struct qcom_iommu_domain *qcom_domain = cookie;
-	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
+	struct qcom_iommu_master *master = qcom_domain->master;
 	unsigned i;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 		iommu_writel(ctx, ARM_SMMU_CB_S1_TLBIASID, ctx->asid);
 	}
 
@@ -148,13 +154,13 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 					    size_t granule, bool leaf, void *cookie)
 {
 	struct qcom_iommu_domain *qcom_domain = cookie;
-	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
+	struct qcom_iommu_master *master = qcom_domain->master;
 	unsigned i, reg;
 
 	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 		size_t s = size;
 
 		iova = (iova >> 12) << 12;
@@ -218,14 +224,14 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
 	int i, ret = 0;
 	u32 reg;
 
 	mutex_lock(&qcom_domain->init_mutex);
-	if (qcom_domain->iommu)
+	if (qcom_domain->master)
 		goto out_unlock;
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
@@ -236,8 +242,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		.iommu_dev	= qcom_iommu->dev,
 	};
 
-	qcom_domain->iommu = qcom_iommu;
-	qcom_domain->fwspec = fwspec;
+	qcom_domain->master = master;
 
 	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
 	if (!pgtbl_ops) {
@@ -251,8 +256,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1ULL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 
 		if (!ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
@@ -316,7 +321,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	return 0;
 
 out_clear_iommu:
-	qcom_domain->iommu = NULL;
+	qcom_domain->master = NULL;
 out_unlock:
 	mutex_unlock(&qcom_domain->init_mutex);
 	return ret;
@@ -345,16 +350,16 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 
-	if (qcom_domain->iommu) {
+	if (qcom_domain->master) {
 		/*
 		 * NOTE: unmap can be called after client device is powered
 		 * off, for example, with GPUs or anything involving dma-buf.
 		 * So we cannot rely on the device_link.  Make sure the IOMMU
 		 * is on to avoid unclocked accesses in the TLB inv path:
 		 */
-		pm_runtime_get_sync(qcom_domain->iommu->dev);
+		pm_runtime_get_sync(qcom_domain->master->iommu->dev);
 		free_io_pgtable_ops(qcom_domain->pgtbl_ops);
-		pm_runtime_put_sync(qcom_domain->iommu->dev);
+		pm_runtime_put_sync(qcom_domain->master->iommu->dev);
 	}
 
 	kfree(qcom_domain);
@@ -362,7 +367,8 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 
 static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
+	struct qcom_iommu_dev *qcom_iommu = master->iommu;
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	int ret;
 
@@ -382,7 +388,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 	 * Sanity check the domain. We don't support domains across
 	 * different IOMMUs.
 	 */
-	if (qcom_domain->iommu != qcom_iommu)
+	if (qcom_domain->master->iommu != qcom_iommu)
 		return -EINVAL;
 
 	return 0;
@@ -393,20 +399,20 @@ static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct qcom_iommu_domain *qcom_domain;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
+	struct qcom_iommu_dev *qcom_iommu = master->iommu;
 	unsigned int i;
 
 	if (domain == identity_domain || !domain)
 		return 0;
 
 	qcom_domain = to_qcom_iommu_domain(domain);
-	if (WARN_ON(!qcom_domain->iommu))
+	if (WARN_ON(!qcom_domain->master))
 		return -EINVAL;
 
 	pm_runtime_get_sync(qcom_iommu->dev);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+	for (i = 0; i < master->num_ids; i++) {
+		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, master->ids[i]);
 
 		/* Disable the context bank: */
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
@@ -461,11 +467,11 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	 * cannot rely on the device_link.  Make sure the IOMMU is on to
 	 * avoid unclocked accesses in the TLB inv path:
 	 */
-	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	pm_runtime_get_sync(qcom_domain->master->iommu->dev);
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
 	ret = ops->unmap_pages(ops, iova, pgsize, pgcount, gather);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
-	pm_runtime_put_sync(qcom_domain->iommu->dev);
+	pm_runtime_put_sync(qcom_domain->master->iommu->dev);
 
 	return ret;
 }
@@ -478,9 +484,9 @@ static void qcom_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	if (!qcom_domain->pgtbl_ops)
 		return;
 
-	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	pm_runtime_get_sync(qcom_domain->master->iommu->dev);
 	qcom_iommu_tlb_sync(pgtable->cookie);
-	pm_runtime_put_sync(qcom_domain->iommu->dev);
+	pm_runtime_put_sync(qcom_domain->master->iommu->dev);
 }
 
 static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
@@ -523,13 +529,38 @@ static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+qcom_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
+	struct qcom_iommu_dev *qcom_iommu;
+	struct qcom_iommu_master *master;
+	struct device *dev = pinf->dev;
 	struct device_link *link;
+	int ret;
+	int i;
 
-	if (!qcom_iommu)
-		return ERR_PTR(-ENODEV);
+	qcom_iommu = iommu_of_get_single_iommu(pinf, &qcom_iommu_ops, 1,
+					       struct qcom_iommu_dev, iommu);
+	if (IS_ERR(qcom_iommu))
+		return ERR_CAST(qcom_iommu);
+
+	master = iommu_fw_alloc_per_device_ids(pinf, master);
+	if (IS_ERR(master))
+		return ERR_CAST(master);
+
+	for (i = 0; i != master->num_ids; i++) {
+		u32 asid = master->ids[i];
+
+		/*
+		 * Make sure the asid specified in dt is valid, so we don't have
+		 * to sanity check this elsewhere:
+		 */
+		if (WARN_ON(asid > qcom_iommu->max_asid) ||
+		    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
 
 	/*
 	 * Establish the link between iommu and master, so that the
@@ -540,63 +571,33 @@ static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
 	if (!link) {
 		dev_err(qcom_iommu->dev, "Unable to create device link between %s and %s\n",
 			dev_name(qcom_iommu->dev), dev_name(dev));
-		return ERR_PTR(-ENODEV);
+		ret = -ENODEV;
+		goto err_free;
 	}
 
+	dev_iommu_priv_set(dev, master);
 	return &qcom_iommu->iommu;
+
+err_free:
+	kfree(master);
+	return ERR_PTR(ret);
 }
 
-static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static void qcom_iommu_release_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu;
-	struct platform_device *iommu_pdev;
-	unsigned asid = args->args[0];
+	struct qcom_iommu_master *master = dev_iommu_priv_get(dev);
 
-	if (args->args_count != 1) {
-		dev_err(dev, "incorrect number of iommu params found for %s "
-			"(found %d, expected 1)\n",
-			args->np->full_name, args->args_count);
-		return -EINVAL;
-	}
-
-	iommu_pdev = of_find_device_by_node(args->np);
-	if (WARN_ON(!iommu_pdev))
-		return -EINVAL;
-
-	qcom_iommu = platform_get_drvdata(iommu_pdev);
-
-	/* make sure the asid specified in dt is valid, so we don't have
-	 * to sanity check this elsewhere:
-	 */
-	if (WARN_ON(asid > qcom_iommu->max_asid) ||
-	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
-		put_device(&iommu_pdev->dev);
-		return -EINVAL;
-	}
-
-	if (!dev_iommu_priv_get(dev)) {
-		dev_iommu_priv_set(dev, qcom_iommu);
-	} else {
-		/* make sure devices iommus dt node isn't referring to
-		 * multiple different iommu devices.  Multiple context
-		 * banks are ok, but multiple devices are not:
-		 */
-		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev))) {
-			put_device(&iommu_pdev->dev);
-			return -EINVAL;
-		}
-	}
-
-	return iommu_fwspec_add_ids(dev, &asid, 1);
+	kfree(master);
 }
 
 static const struct iommu_ops qcom_iommu_ops = {
 	.identity_domain = &qcom_iommu_identity_domain,
 	.capable	= qcom_iommu_capable,
 	.domain_alloc_paging = qcom_iommu_domain_alloc_paging,
-	.probe_device	= qcom_iommu_probe_device,
+	.probe_device_pinf = qcom_iommu_probe_device,
+	.release_device = qcom_iommu_release_device,
 	.device_group	= generic_device_group,
-	.of_xlate	= qcom_iommu_of_xlate,
+	.of_xlate	= iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
-- 
2.42.0


