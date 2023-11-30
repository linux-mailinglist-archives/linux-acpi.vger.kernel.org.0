Return-Path: <linux-acpi+bounces-1973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FF7FE6EA
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DA2281F20
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC954134A3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMogeSyr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E99D6C;
	Wed, 29 Nov 2023 17:11:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFiLaMzjGL4xIELbk/3RnaadF7Tfu+iR9VKXWTKEAZ2F4ja/LfZ4GKjSJXZOo4IpXkFjmMkFAkd3cy2bChiCBonNSGFhXtDuJRyPRqzdGlZ+aAqxwRCy53iNBmi6rGWuBIMVnFO0SkdOD68iJHRYhA7wrZbpbwsXFU8r7C9CEHJWk6LWyG+3Q5pUgjaCTBTpSsSwoonItEClzOTo5kAWy8390o9KOHgxh3mWO27guITry31ANIFLHGZQKUUX6uEt84z+RAMIPDVc4NunFbYAASpygbrWG9woLFBq6BecMicXCjCuX+6MOw279GRS76AVF5ag/j9n2oyLiSd6TMqbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmT9sPIBC3zysKQfnRxRs9D8QedigHbyG5FAziwg6D8=;
 b=eVAvxlujyys66sXmYOzrRr2jGzvDJ6zo/9AnBODykRvLM9MfsxjMXSHNtehLYidXTq417ZbS2fGXyQuCeqZkKp0Dfxi8Kdzcax3CNm3rmR2Q0GoN2et5ZfsSxkxq35BfAnFreZsSjDGjFNfo7kMJ6ka6nM/yRMjRjS4t98hHIbCc+1V7P2losR4bDaad5Hp88/f3oVCuA3K6BFdMXwh4nDUqLC7/rhoO2vsnc0B2eMWYUu0p6vA8YqynS5NyrcbHG7bg5T+4gUTE9kCjHfFf1Y8oUYTpJPtAWk95MjBTNr4RdJ4oJTOzrm7HHZaEKlFUl7gXhC/mnPmCv+aNu9ErUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmT9sPIBC3zysKQfnRxRs9D8QedigHbyG5FAziwg6D8=;
 b=ZMogeSyrHSb0hQo0F0XwNRHvcxtaitvVGc6td5a+tfeWbdR2ZeIvH2CbNy6j0xUfCqjMBvlPI8YPtw11U56YuMYIYe60a2eU0OYmPfNA+8yg844RJjKPzcq40ecM89e2ZE6v6Fe9EWfqxIFuMzMxPS7KH0LGQhGf/H2plldfHJTv3dwr1+IxoJGNqW4RthYy7FDZKWDN+Ketg/tEDE4jiMLI1j2Kc4YjRMdixA78x6W+ed7nsFWdxoqHzC28JPxK2HgT4i0xUoZqOfW0/a3HZVsIrtpbFAN2hboLMU/9id0K7jjaD7L8kem+W8Mi6Zh/Vi5wusRGuk7dwGHl2Ik9eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:52 +0000
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
Subject: [PATCH 21/30] iommu/mtk_v1: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:28 -0400
Message-ID: <21-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c71b8dc-de76-4503-8d14-08dbf1412c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a6a2zUzjdjhRFCvzaWHAMi0z+IrR0x1ELp0Z/kqamgLbcrGLNLm5x+99P9dFvMlK5kyCHp4CSZOvcBHxJdGwqlmBgR57ITxcianUOMXJKfIuA0lQbdzxme/r8bblr/xIPN9DujxMJ5dOF0xsGqxI1nqmLToNPmI7h8iyrAxcbtRVKtogWNzMK3H6KeXbaUQaOPWKg+Q9ud1hGMibZNWu3MBXNqWXW3nn/Z7BX6qb2YTwdO9k+2k0KvyOcboo/+QydAuhFeCocGAd1IzlDsIGrUa/oOUwPb7WV4PDE/MP9h2+DyOWc50COWmQ2W6Gq5YxJmSJ3EuNANDMSepEtuZ8+M6Cx6FrR4Y0QS5jL9rsQMtpJM+/ZpRfsfNIeZpq2Tl9yzhXEhrL5JuCuppthJd62lc8SI3BEWMaVf2f6+cahOa4hAYZeIHOen527AEZCDtP91W133xAsGEU5aAWGJowK6YsqRG5Btbstn4foLy7QVHmwUJsE+qSe825JAjZM5Kxu7/8P3EeGeg2W+cw51TgrWmD4lU2km61jCaCzrUYx9hhcwJESZS54FQthWWT5dB5nawp7c+Z/pg5YFOnwrE8AtbrqRxmFOR6214NVjNqwF/Gvp5fk1yG5jxOl6YDt+tIzSpx9/tRdQM5tnWqsUX+WQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhN5h5ieux9M+dWgHi4UApksQ0EusFtgK1UZAIVELUXyDe1tP3dmpPES4iuN?=
 =?us-ascii?Q?EvcD7oGuslGk3KrvnSaJCkv6kEfwhJYthX/LLhVXPbbiuDIK1AM9RlvncOpl?=
 =?us-ascii?Q?NHHYq0x9JVWmtbt7hmkdt2JP95C7cXwW9YT661iQzw01fn67su7f/7Xun81K?=
 =?us-ascii?Q?f06jlu9QoM/ye3xEKzq/aYk1S/S5QbAtGMViHyHERD18mwJPbJHcWuy/7YjU?=
 =?us-ascii?Q?tKvLtpsbl+F3PMxKx8IxdIqCq+RhIODlP3ijl44ZdiSnQqpUSYBu2iT3/LJs?=
 =?us-ascii?Q?d0MQWCmqylOk+CLU595VM5rrFLr63dFpKNW8lFMy6J8frFO0JXN2xds6XhzQ?=
 =?us-ascii?Q?JLet8pv/58BGRVbflDGTjT1iek2RW8rCxIInt4prGmWDmO/X1aglW85M4532?=
 =?us-ascii?Q?vIV2rLLvBkf3G3NtlRVq+UGMWAaawrGDT4vIj4Q7yMaMC+/ys+NpSzXxAVcM?=
 =?us-ascii?Q?9Y3qtJqwfWHhywVFbxVkXl5WgkEjmTYD3tWAcNzrknntLJ9l69zicZtxW0h3?=
 =?us-ascii?Q?KAYwXsNGunfQ4FquPbl116mnX5mfBcv75v3Gp/PJbQ5PpZiezZ60sHby2c8K?=
 =?us-ascii?Q?lGIsGHLMAFIFQcOCybgJ+JOYh0JfMikj+JfRSCWJ6MRkSioFecUL4rlEPTXI?=
 =?us-ascii?Q?Onbg+kitAJzH46wl8/Kd9/kafU0711KDF9s88vwf2/WH7Kk5mUNIwLatGsDr?=
 =?us-ascii?Q?UM4aXisW0+Tr1KJbGsSw8Yodl63iXm9DLFHD/QmND+fmY0sSCsRzKoF1fMBX?=
 =?us-ascii?Q?8tIOY1tUp/rUYS0U2iz+4vffh5ZWW/qby01V0crlZ0gIeKyfBwy+sJVT1GyW?=
 =?us-ascii?Q?+SwgoGH0zc2xTwwyI7pBJZqTuYOIYzfbb3dVovXdBhZYoCIy0inujeL7ONBd?=
 =?us-ascii?Q?cGE28mX4Rb4Z4hBgHIg1/1w2ZXam0kHeBlOM9i9k+Pl4lXI2UW9DCJinybbe?=
 =?us-ascii?Q?j5Akjq6jwypN6dr4d9qZLGNPiEYyCyN+fjKac1DrF/o493sKT660HuuwOgpQ?=
 =?us-ascii?Q?tTRNcFwG90rZJokbWk5N5yEiNtYeWW/xiZ1W8fnWjWSgK4fI/CYj3QfnU6jI?=
 =?us-ascii?Q?2hkQkehnXVUcgbpAwmu/JV9tAm/SAoJoW7gEU5pc2QI0qQvGof0mC9fW3RyH?=
 =?us-ascii?Q?Zv/L9Yvh080++5wnPDy7lpYL8kGfgWuYFTpGuPaF8vfzIJKxn+y9u/4P+oZ2?=
 =?us-ascii?Q?l8ZBCamzvAp6j/QHJZAr4vnvAsfS/glOSBqfEAwWKnsT588lx96k21xrDidW?=
 =?us-ascii?Q?fHkOUOYB+lBSp/OwEshB/0cKpEut51cABZOkrc0Xe1/4BF7K4+kxphRQf8Gg?=
 =?us-ascii?Q?UmnG7O78hVUrY9lzIYTbBYnuoYou45bhFSWCt1HQFc3mXVN4bIBlO48ZeYSp?=
 =?us-ascii?Q?x/tN8zhkbmPuuGz9hWECWou098OEUm8kvfm+VLUsKlNraHLBM+1gHbfTGhXe?=
 =?us-ascii?Q?4v6nvBCeGzat9Cs4C9EEMGSk8h8YLzjVJVSTLNWNQUPG9PRXzPYyq8DZSkCI?=
 =?us-ascii?Q?+Py/qWvZJBOpk5BTE//wxfHS/sdGqxbDo1mYDFD1F8d4KAB/wOoGeVlXKFGT?=
 =?us-ascii?Q?UUWdBOY9wnu7+fmf2KgHTGbzhphf2dAl7FVq07Z9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c71b8dc-de76-4503-8d14-08dbf1412c30
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lrE0VFQK0CIwfE+Q2VPQVeLKyz3T+ah96t1DC1KIqTlf0zqIzfcMYfwD3xMmls2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

mtk_v1 supports a single iommu instance with multiple ids.

It open codes the fwspec parse inside the driver, remove all of this and
just call iommu_of_get_single_iommu() to do the same parsing. Using
iommu_of_allow_bus_probe() so this continues to work at bus probe time.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Fold
mtk_iommu_v1_create_mapping() into mtk_iommu_v1_probe_device() as it is
done only once per device.

Fix the error handling so we don't leak mappings on error paths.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/mtk_iommu_v1.c | 162 +++++++++++++++--------------------
 1 file changed, 67 insertions(+), 95 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 25b41222abaec1..82f500a1ad74e9 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -108,6 +109,12 @@ struct mtk_iommu_v1_data {
 	struct mtk_iommu_v1_suspend_reg	reg;
 };
 
+struct mtk_iommu_v1_device {
+	struct mtk_iommu_v1_data *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct mtk_iommu_v1_domain {
 	spinlock_t			pgtlock; /* lock for page table */
 	struct iommu_domain		domain;
@@ -232,14 +239,14 @@ static irqreturn_t mtk_iommu_v1_isr(int irq, void *dev_id)
 static void mtk_iommu_v1_config(struct mtk_iommu_v1_data *data,
 				struct device *dev, bool enable)
 {
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		larbid = mt2701_m4u_to_larb(fwspec->ids[i]);
-		portid = mt2701_m4u_to_port(fwspec->ids[i]);
+	for (i = 0; i < mdev->num_ids; ++i) {
+		larbid = mt2701_m4u_to_larb(mdev->ids[i]);
+		portid = mt2701_m4u_to_port(mdev->ids[i]);
 		larb_mmu = &data->larb_imu[larbid];
 
 		dev_dbg(dev, "%s iommu port: %d\n",
@@ -293,7 +300,8 @@ static void mtk_iommu_v1_domain_free(struct iommu_domain *domain)
 
 static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	struct dma_iommu_mapping *mtk_mapping;
 	int ret;
@@ -319,7 +327,8 @@ static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device
 static int mtk_iommu_v1_identity_attach(struct iommu_domain *identity_domain,
 					struct device *dev)
 {
-	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 
 	mtk_iommu_v1_config(data, dev, false);
 	return 0;
@@ -394,128 +403,91 @@ static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_ad
 
 static const struct iommu_ops mtk_iommu_v1_ops;
 
-/*
- * MTK generation one iommu HW only support one iommu domain, and all the client
- * sharing the same iova address space.
- */
-static int mtk_iommu_v1_create_mapping(struct device *dev, struct of_phandle_args *args)
+static struct iommu_device *
+mtk_iommu_v1_probe_device(struct iommu_probe_info *pinf)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_v1_data *data;
-	struct platform_device *m4updev;
 	struct dma_iommu_mapping *mtk_mapping;
+	struct mtk_iommu_v1_device *mdev;
+	struct device *dev = pinf->dev;
+	struct mtk_iommu_v1_data *data;
+	int idx, larbid, larbidx;
+	struct device_link *link;
+	struct device *larbdev;
 	int ret;
 
-	if (args->args_count != 1) {
-		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
-			args->args_count);
-		return -EINVAL;
-	}
+	iommu_of_allow_bus_probe(pinf);
+	data = iommu_of_get_single_iommu(pinf, &mtk_iommu_v1_ops, 1,
+					 struct mtk_iommu_v1_data, iommu);
+	if (IS_ERR(data))
+		return ERR_CAST(data);
 
-	if (!fwspec) {
-		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
-		if (ret)
-			return ret;
-		fwspec = dev_iommu_fwspec_get(dev);
-	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_v1_ops) {
-		return -EINVAL;
-	}
+	mdev = iommu_fw_alloc_per_device_ids(pinf, mdev);
+	if (IS_ERR(mdev))
+		return ERR_CAST(mdev);
+	mdev->iommu = data;
 
-	if (!dev_iommu_priv_get(dev)) {
-		/* Get the m4u device */
-		m4updev = of_find_device_by_node(args->np);
-		if (WARN_ON(!m4updev))
-			return -EINVAL;
-
-		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
-	}
-
-	ret = iommu_fwspec_add_ids(dev, args->args, 1);
-	if (ret)
-		return ret;
-
-	data = dev_iommu_priv_get(dev);
+	/*
+	 * MTK generation one iommu HW only support one iommu domain, and all
+	 * the client sharing the same iova address space.
+	 */
 	mtk_mapping = data->mapping;
 	if (!mtk_mapping) {
 		/* MTK iommu support 4GB iova address space. */
 		mtk_mapping = arm_iommu_create_mapping(&platform_bus_type,
 						0, 1ULL << 32);
-		if (IS_ERR(mtk_mapping))
-			return PTR_ERR(mtk_mapping);
+		if (IS_ERR(mtk_mapping)) {
+			ret = PTR_ERR(mtk_mapping);
+			goto err_free;
+		}
 
 		data->mapping = mtk_mapping;
 	}
 
-	return 0;
-}
-
-static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct of_phandle_args iommu_spec;
-	struct mtk_iommu_v1_data *data;
-	int err, idx = 0, larbid, larbidx;
-	struct device_link *link;
-	struct device *larbdev;
-
-	/*
-	 * In the deferred case, free the existed fwspec.
-	 * Always initialize the fwspec internally.
-	 */
-	if (fwspec) {
-		iommu_fwspec_free(dev);
-		fwspec = dev_iommu_fwspec_get(dev);
-	}
-
-	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
-					   "#iommu-cells",
-					   idx, &iommu_spec)) {
-
-		err = mtk_iommu_v1_create_mapping(dev, &iommu_spec);
-		of_node_put(iommu_spec.np);
-		if (err)
-			return ERR_PTR(err);
-
-		/* dev->iommu_fwspec might have changed */
-		fwspec = dev_iommu_fwspec_get(dev);
-		idx++;
-	}
-
-	data = dev_iommu_priv_get(dev);
-
 	/* Link the consumer device with the smi-larb device(supplier) */
-	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
-	if (larbid >= MT2701_LARB_NR_MAX)
-		return ERR_PTR(-EINVAL);
+	larbid = mt2701_m4u_to_larb(mdev->ids[0]);
+	if (larbid >= MT2701_LARB_NR_MAX) {
+		ret = -EINVAL;
+		goto err_mapping;
+	}
 
-	for (idx = 1; idx < fwspec->num_ids; idx++) {
-		larbidx = mt2701_m4u_to_larb(fwspec->ids[idx]);
+	for (idx = 1; idx < mdev->num_ids; idx++) {
+		larbidx = mt2701_m4u_to_larb(mdev->ids[idx]);
 		if (larbid != larbidx) {
 			dev_err(dev, "Can only use one larb. Fail@larb%d-%d.\n",
 				larbid, larbidx);
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_mapping;
 		}
 	}
 
 	larbdev = data->larb_imu[larbid].dev;
-	if (!larbdev)
-		return ERR_PTR(-EINVAL);
+	if (!larbdev) {
+		ret = -EINVAL;
+		goto err_mapping;
+	}
 
 	link = device_link_add(dev, larbdev,
 			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
 	if (!link)
 		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
 
+	dev_iommu_priv_set(pinf->dev, mdev);
 	return &data->iommu;
+
+err_mapping:
+	arm_iommu_release_mapping(mtk_mapping);
+err_free:
+	kfree(mdev);
+	return ERR_PTR(ret);
 }
 
 static void mtk_iommu_v1_probe_finalize(struct device *dev)
 {
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 	struct dma_iommu_mapping *mtk_mapping;
-	struct mtk_iommu_v1_data *data;
 	int err;
 
-	data        = dev_iommu_priv_get(dev);
 	mtk_mapping = data->mapping;
 
 	err = arm_iommu_attach_device(dev, mtk_mapping);
@@ -525,15 +497,15 @@ static void mtk_iommu_v1_probe_finalize(struct device *dev)
 
 static void mtk_iommu_v1_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_v1_data *data;
+	struct mtk_iommu_v1_device *mdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = mdev->iommu;
 	struct device *larbdev;
 	unsigned int larbid;
 
-	data = dev_iommu_priv_get(dev);
-	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
+	larbid = mt2701_m4u_to_larb(mdev->ids[0]);
 	larbdev = data->larb_imu[larbid].dev;
 	device_link_remove(dev, larbdev);
+	kfree(mdev);
 }
 
 static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
@@ -580,7 +552,7 @@ static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
 static const struct iommu_ops mtk_iommu_v1_ops = {
 	.identity_domain = &mtk_iommu_v1_identity_domain,
 	.domain_alloc_paging = mtk_iommu_v1_domain_alloc_paging,
-	.probe_device	= mtk_iommu_v1_probe_device,
+	.probe_device_pinf = mtk_iommu_v1_probe_device,
 	.probe_finalize = mtk_iommu_v1_probe_finalize,
 	.release_device	= mtk_iommu_v1_release_device,
 	.device_group	= generic_device_group,
-- 
2.42.0


