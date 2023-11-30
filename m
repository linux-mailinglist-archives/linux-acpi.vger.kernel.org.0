Return-Path: <linux-acpi+bounces-1945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798AF7FE6B8
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8DA1C209EE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B3134A3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wd3GQfKU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526FFD54;
	Wed, 29 Nov 2023 17:10:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5DU661SRsmHA8CiOKQdRZ8DbqSu8OFEE48kOA0RmlerWUfsoDXE4Y1joDpaacFrU6oNTdY2nCTJK89W/CZ8vH9Q6Ly8AxR0pFqRf3zQNKM/1h5Nn9wGNuRQEI4QQ72l/oNnAN/BHiUsKRfQc7vk+uRCiMVyhGfY94+Xu1alXjoSpik/KoHPdPR9AGFzVTYj1WEcwEO+GcJNyQlxghvu8iyETHaQ+SszAJL2xu8B2x0Yy4JZ6Okec1cdNo/fIyA2wij6pvorVhnRU2cQI7AFZkchjOMpXkXNGS/l9mFhP+mAn5w2gMAMZEgzkKfNOPf6fR+N8B1ZL8nAncATf4ubaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1/2RwZb1BvcKrWpjq41xk6R0wcBobygbj+9IidcnE8=;
 b=Agd/dlrnkFVoUeVayIt9ibYudFujJ5s2Kj4hTuKT1d0gPI1h32WyOi7zFfhRJIFQ27Vtu3YlX1z0RCimsbH5Sz62fzeA2b7/RmSjT2chrxICujq6mQfF4mrBZOaXlHoywtxxTCOxlpXzHy/Exj2/7k8Ppb5gpCYaLVJ5efAwQMl7RheN+cYXqRlYtY8Hc+WvgOowWb3m4bDGbWW0Mvy4QARQc+TysrE3dgmnoB2eNINK9P0/jsZDayBiFuWEjY0B3I1mYMrLDtt7omW68VedFZzoSuwFz1JUWBp5SU22O5IMd1FFkpL9EyBDpZs9aEnaX2YjGNIDAot0rq+mnBkM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1/2RwZb1BvcKrWpjq41xk6R0wcBobygbj+9IidcnE8=;
 b=Wd3GQfKUtdMv1PJC8DKrRfs1e1pu+1GrORDA9mw/Xe/WjUmrRFKlPjsn1CrCx+g73L4uWk9ZJRpMClkXk0lJFRuCa5ZlbBRJZFbBO001T28yQsXTqUYF7Z9wr0v66t6vKDf1sleW5b/vmbpgXG4LdU30EpuWv5+qLI1H3OkOeakQd3sA+8NN86eVYHny5ylOVA3PUjlhGK24/viXa76WZAB9SQM/VhnuYL0yCl2hjsHGZtWZnbZd6lirHoRnDOIvgM3O0yDZS3qNFp1r4TgDjbwvCN8dHhxZC28VFu+hSjEWjQYbBhDTYf2hvL4BzfbWWdMJ+ymvvf279JY7Pkor7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:39 +0000
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
Subject: [PATCH 04/30] ACPI: IORT: Remove fwspec from the reserved region code
Date: Wed, 29 Nov 2023 21:10:11 -0400
Message-ID: <4-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:806:125::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 799948c1-d494-4ba0-9962-08dbf1412a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HOwkopNGa0CBJ1OiokLpJXaWRObisYdz9OliU1tDVjJR2EnhrrKcMvn/tZ83zBYOOidiSi8ak9+LyDk0jrjNScorLATqTch+cK3eZEvCvHa9OJoe5YHgi5ryCfuHinCcJG8s5XKJSBolN6DMZl5JG3dM9HvzzfGFcFAZs6iV5V+QD3MdcEzrkWle7chIpMx3D3uJG33V1z2xUdcxzRxOA6bBKQRvTzJUJRCZ10g1HuL5tIFYzqGdsCv+MezcXMViedA2D2f/dkVQqD7s+QElsnFAS3QsMbsnhLcbguhk7k9fziOPCgn3B/kqidMU2YZorqB95rHis9lRV1uCshslD8buIhDwtYviVktRpgsJZgXGW89iPbJi7GEFipUARuQVyBUqisXCxncXwRVW8RhjpJkret/3sHfo76HuN+mj9HfKQa+rccIWWT9NqG3fhFuklkM9i6H+ysP2p047dM/5L5W+fGt+KDLyRY/eLHbTPYiBv/jZ6Esvw4h+gwP8dK7Qq1uEu1WtSXjrEorgJpM+ZiKsrE+FD1KMABgO+J7O5sg5CvDJAA7uCirdJRXqOL6qOiXaF8q0zMBZMUx6YMbFoI5tdk3RhlBthpaxCd53dhMdIssQl62wLdeMF8zQqr/zMgPYaZUM2YzPfbRig3Hcw2QxVxeWSr0HzzwrHGkMjk8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2mhjeIC9kP2zwjJ3vrYUZ3jAaoHBX2IY3xBPl32LW6cQIx4sFAdbPZhmnG4F?=
 =?us-ascii?Q?uurHu6p3/dvANUAkZDtE0qDPN/ou7YhPs2tsbok7mpuaXMcMfO0M7bPh2A1f?=
 =?us-ascii?Q?z3T9E6fJegXZa+VGcrfhLiKA+jZ1fvOie0oeI24UrywXgLEvy9hKFky4Lgxo?=
 =?us-ascii?Q?vLqk+BfisoJ6k/bwUbt8HNn8j7mcwjVMqBLC1Mw2z8zYA5HeoThE2HMrRqb/?=
 =?us-ascii?Q?kYRYE/nGY5+VghO/EJ/FyJ1PUmgPonmaL+Hng6hRhEZEshsd4k+BCVryJtnl?=
 =?us-ascii?Q?rqQdQbNzqZ9+k/6kHfBir1tuwTV/Y1xQs6tqFRKw7LZCv9U1i3jqtRW+Fj0A?=
 =?us-ascii?Q?CuaX5q9QkXG47MKP1qC2Hd0IBYb8lXYczGiWDp3Jq8LQHe7DhOvMJtZX3Iml?=
 =?us-ascii?Q?fvrqcjIMhjx1LrFK/DIafD+7Wd/YRY/uaYyVFQseOvBsoPapUNoa1Qj5O3KE?=
 =?us-ascii?Q?LLC6x4avNE2/HIR2EXaav1KvNkU7c7gCrEmnoVeEdbxzKHbLv2VjJCbP22IT?=
 =?us-ascii?Q?97ChwhkZUSYdvOw34KlafoIMGRDv85ONLD9vAuF7pfIRBwvTDqjeMmwES+rE?=
 =?us-ascii?Q?AmUMyzlwieNm4DCpX1Ea8yKKkbJlz0CriJQwsfFTncnBtlHLna74Vk4+u5xt?=
 =?us-ascii?Q?pvX64DJLMgg1XAVJ0JORy92xnyC7+UkgX19i6PYaWlkKhcxq4QGf4hYC7nzZ?=
 =?us-ascii?Q?1oS5Pp5GEwMmkp2GEjFNs3cgFawMlWAWCZ2iwkHfGy44qxaptAZWc07/kMbm?=
 =?us-ascii?Q?FqEbkAHPYFkpyCJKmPv7tYsAiPJJ3tErJIbT00MvmLZ48jtfiYiAtnwqDBEe?=
 =?us-ascii?Q?4FqQQSryvmb/5E8mHCbXWNWQNPJp87DNTCX2ve0mvEp/VytaRQSrgaMhcPV5?=
 =?us-ascii?Q?D6Hqc9HCNLyJpmeUyT7r8K3k6F/Mh7qpYaCn4mgiEQ3wjzWctJHnLEdT8iQC?=
 =?us-ascii?Q?DYmV3QIDp492oWMRyl7u082Jr4tU6fBOgtBHUb5YVoAMOUEpieV+cf3sfB4c?=
 =?us-ascii?Q?/yyw3i51kX/t8PkwNrgBGoaLtgXID4g/XFV2q2WpS3rUAe12l2QBr7rz0uSC?=
 =?us-ascii?Q?02jcAA+C/NwqWcsyIAT4p39aYlDAgnkJA/CJqy39gJoye6JJdN8oVmTjamQp?=
 =?us-ascii?Q?XfouVPGCX5WnC9DbXNl7QyhY2OEZCPW2q/ybiZmpni6jiwMqKaCA9vqgFVSo?=
 =?us-ascii?Q?K/hD0MWCZCgUsUN5SdiTLxjc6j31/FUortrzLHg+K/8kiAnxrLpb0c3vdxVn?=
 =?us-ascii?Q?J4QDTj3fJJnO4ItGF7nZOKRV0jPbsWbWGfB4BKXmbdE5K6KJ+y2eKtHJcIz3?=
 =?us-ascii?Q?mq12uyq5AstKy6Ci2Xw7V37Bdq2e4kufxiE7s7cFf7YC8E0/8S5hll+U/9KA?=
 =?us-ascii?Q?XsWsCQFhIg33RhYxdEnQz5IYeHc6PrmbffrrQfqoMz3SXtyAKT9Wy0DHKmD6?=
 =?us-ascii?Q?a74EDs4xwTpZa95ZgScZVVRXkoJt/ocLubU9iM7yTus6mwV4jn1kKEI9pyad?=
 =?us-ascii?Q?9Wcb4vjV02TEj6LJ5wNQ3Te0SKYbTb4hapAl3cCabqW5+WgszKOoMDPTKI9N?=
 =?us-ascii?Q?V+v3CMATwO3SJvm8uXDPHDgRo5qRDg6XL5qKBYxI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799948c1-d494-4ba0-9962-08dbf1412a25
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:38.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmL1HXjHi6e5JgKpBsPqhhRc8AtQttGvFiUIYyPn2GmuaV9VgchKVr2DtiYJqBGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

iort_iommu_get_resv_regions() needs access to the parsed id array that is
currently stored in the iommu_fwspec.

Instead of getting this from the fwspec inside the iort code have the
caller pass it in.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 88 ++++++++++++++++++++++++---------------
 drivers/iommu/dma-iommu.c |  7 +++-
 include/linux/acpi_iort.h |  8 +++-
 3 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 5c9b4c23f96a87..93e30f2f5004f0 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -946,11 +946,19 @@ static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
 	return new_sids;
 }
 
-static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
+struct iort_resv_args {
+	struct device *dev;
+	struct list_head *head;
+	struct fwnode_handle *iommu_fwnode;
+	const u32 *fw_ids;
+	unsigned int fw_num_ids;
+};
+
+static bool iort_rmr_has_dev(struct iort_resv_args *args, u32 id_start,
 			     u32 id_count)
 {
+	struct device *dev = args->dev;
 	int i;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	/*
 	 * Make sure the kernel has preserved the boot firmware PCIe
@@ -965,18 +973,18 @@ static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
 			return false;
 	}
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		if (fwspec->ids[i] >= id_start &&
-		    fwspec->ids[i] <= id_start + id_count)
+	for (i = 0; i < args->fw_num_ids; i++) {
+		if (args->fw_ids[i] >= id_start &&
+		    args->fw_ids[i] <= id_start + id_count)
 			return true;
 	}
 
 	return false;
 }
 
-static void iort_node_get_rmr_info(struct acpi_iort_node *node,
-				   struct acpi_iort_node *iommu,
-				   struct device *dev, struct list_head *head)
+static void iort_node_get_rmr_info(struct iort_resv_args *args,
+				   struct acpi_iort_node *node,
+				   struct acpi_iort_node *iommu)
 {
 	struct acpi_iort_node *smmu = NULL;
 	struct acpi_iort_rmr *rmr;
@@ -1013,8 +1021,8 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
 			continue;
 
 		/* If dev is valid, check RMR node corresponds to the dev SID */
-		if (dev && !iort_rmr_has_dev(dev, map->output_base,
-					     map->id_count))
+		if (args->dev &&
+		    !iort_rmr_has_dev(args, map->output_base, map->id_count))
 			continue;
 
 		/* Retrieve SIDs associated with the Node. */
@@ -1029,12 +1037,12 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
 	if (!sids)
 		return;
 
-	iort_get_rmrs(node, smmu, sids, num_sids, head);
+	iort_get_rmrs(node, smmu, sids, num_sids, args->head);
 	kfree(sids);
 }
 
-static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
-			   struct list_head *head)
+static void iort_find_rmrs(struct iort_resv_args *args,
+			   struct acpi_iort_node *iommu)
 {
 	struct acpi_table_iort *iort;
 	struct acpi_iort_node *iort_node, *iort_end;
@@ -1057,7 +1065,7 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
 			return;
 
 		if (iort_node->type == ACPI_IORT_NODE_RMR)
-			iort_node_get_rmr_info(iort_node, iommu, dev, head);
+			iort_node_get_rmr_info(args, iort_node, iommu);
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
@@ -1069,25 +1077,23 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
  * If dev is NULL, the function populates all the RMRs associated with the
  * given IOMMU.
  */
-static void iort_iommu_rmr_get_resv_regions(struct fwnode_handle *iommu_fwnode,
-					    struct device *dev,
-					    struct list_head *head)
+static void iort_iommu_rmr_get_resv_regions(struct iort_resv_args *args)
 {
 	struct acpi_iort_node *iommu;
 
-	iommu = iort_get_iort_node(iommu_fwnode);
+	iommu = iort_get_iort_node(args->iommu_fwnode);
 	if (!iommu)
 		return;
 
-	iort_find_rmrs(iommu, dev, head);
+	iort_find_rmrs(args, iommu);
 }
 
-static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
+static struct acpi_iort_node *
+iort_get_msi_resv_iommu(struct iort_resv_args *args)
 {
 	struct acpi_iort_node *iommu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
+	iommu = iort_get_iort_node(args->iommu_fwnode);
 
 	if (iommu && (iommu->type == ACPI_IORT_NODE_SMMU_V3)) {
 		struct acpi_iort_smmu_v3 *smmu;
@@ -1105,15 +1111,13 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
  * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
  * associated with the device are the HW MSI reserved regions.
  */
-static void iort_iommu_msi_get_resv_regions(struct device *dev,
-					    struct list_head *head)
+static void iort_iommu_msi_get_resv_regions(struct iort_resv_args *args)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_its_group *its;
 	struct acpi_iort_node *iommu_node, *its_node = NULL;
 	int i;
 
-	iommu_node = iort_get_msi_resv_iommu(dev);
+	iommu_node = iort_get_msi_resv_iommu(args);
 	if (!iommu_node)
 		return;
 
@@ -1126,9 +1130,9 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
 	 * a given PCI or named component may map IDs to.
 	 */
 
-	for (i = 0; i < fwspec->num_ids; i++) {
+	for (i = 0; i < args->fw_num_ids; i++) {
 		its_node = iort_node_map_id(iommu_node,
-					fwspec->ids[i],
+					args->fw_ids[i],
 					NULL, IORT_MSI_TYPE);
 		if (its_node)
 			break;
@@ -1151,7 +1155,7 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
 							 prot, IOMMU_RESV_MSI,
 							 GFP_KERNEL);
 			if (region)
-				list_add_tail(&region->list, head);
+				list_add_tail(&region->list, args->head);
 		}
 	}
 }
@@ -1160,13 +1164,24 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
  * iort_iommu_get_resv_regions - Generic helper to retrieve reserved regions.
  * @dev: Device from iommu_get_resv_regions()
  * @head: Reserved region list from iommu_get_resv_regions()
+ * @iommu_fwnode: fwnode that describes the iommu connection for the device
+ * @fw_ids: Parsed IDs
+ * @fw_num_ids: Length of fw_ids
  */
-void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
+				 struct fwnode_handle *iommu_fwnode,
+				 const u32 *fw_ids, unsigned int fw_num_ids)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iort_resv_args args = {
+		.dev = dev,
+		.head = head,
+		.iommu_fwnode = iommu_fwnode,
+		.fw_ids = fw_ids,
+		.fw_num_ids = fw_num_ids,
+	};
 
-	iort_iommu_msi_get_resv_regions(dev, head);
-	iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
+	iort_iommu_msi_get_resv_regions(&args);
+	iort_iommu_rmr_get_resv_regions(&args);
 }
 
 /**
@@ -1178,7 +1193,12 @@ void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head)
 {
-	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
+	struct iort_resv_args args = {
+		.head = head,
+		.iommu_fwnode = iommu_fwnode,
+	};
+
+	iort_iommu_rmr_get_resv_regions(&args);
 }
 EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f68..d644b0502ef48e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -468,9 +468,12 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
-		iort_iommu_get_resv_regions(dev, list);
+	if (!is_of_node(fwspec->iommu_fwnode)) {
+		iort_iommu_get_resv_regions(dev, list, fwspec->iommu_fwnode,
+					    fwspec->ids, fwspec->num_ids);
+	}
 
 	if (dev->of_node)
 		of_iommu_get_resv_regions(dev, list);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 5423abff9b6b09..13f0cefb930693 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -53,7 +53,9 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
-void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
+				 struct fwnode_handle *iommu_fwnode,
+				 const u32 *fw_ids, unsigned int fw_num_ids);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -72,7 +74,9 @@ static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 { return -ENODEV; }
 static inline
-void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
+				 struct fwnode_handle *iommu_fwnode,
+				 const u32 *fw_ids, unsigned int fw_num_ids)
 { }
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
-- 
2.42.0


