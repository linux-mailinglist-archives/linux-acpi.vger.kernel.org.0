Return-Path: <linux-acpi+bounces-1952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6117FE6C1
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3457B20E7C
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC11426E
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrHVtnkN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EED7F;
	Wed, 29 Nov 2023 17:10:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph6Y0TDGKfYsXDdQSmbALLvMUMKS+Cn/AQ9CxmrCBemkMPo94kuZ4aD2TIDp6wieURJKWCLPGcl+pW2Np349cNP4NjhU0BvP/hhNPgP65H9aAiPJbKpws7X5u2GJUoq4j/Tvc7/UO28rw7OKc1+f9/0JZYlOCo4tyoImoWydZouh9tAnMxR5f8uzcFJutRh5L0GAOUkwSAcdSfumBQRxIi98THjpGffPOhNYFwqYkzcSrnOLnHkAzTVhTxIvswVT6wXVAjOAvbXmVTvCd4HOxymggJUyhAVEy7Ljy+ebP5bWiJzUoUVTT5xVeeoVxJNsGqu+RzZnv69cZopE0zlT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXjpmP7B5IXGBNr1m7J/QuIsLVIPvAV2ilVtcRlro38=;
 b=a7MaYNd2k1apltwaLBv2Dp9bbri47KvSoAvDT6r+ZDElO8PLoD6W1gwFUG4f2uGu8ASfh1yTPH3MFM7+mjpK+LEzQW7hTtGdveaGI3F8GL9X75VDH7JPQRrJUDTLygephqR8BuePPeFBUxHju+2feVigBZTXmAtrf3A4W4StEzNk17qta90Qx0v2ef6DSN2TBx+Vq52Bn7C2hhN6J97Vru5Ay94nG85octFN67Y62pUaHqgxZd4gTn2GFfQP1iuZ8kKx9qNNUpHzQvVxFNMViv7LY/WUhjh9RDAHhrOF5l5A4R9iQvHJXdQHcktry7JFpo4Q1zGDO0IwveaCiRP65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXjpmP7B5IXGBNr1m7J/QuIsLVIPvAV2ilVtcRlro38=;
 b=GrHVtnkNkesZP7N37XdbYLMO92J0aXq1ByvSk9FZFfawvdsHozrADXtV9h6xhjFzhiWImFTpFGIwl2hFYmZu1m0qIZFfeTt8Dom3oce/uFb538QsNZtJa44asfBg8jNIA66Gc2Dt3dOhEPliO1v7G1SgXzfGsXw8SiIBNf40ZnSwar5r9Na1pvHnHcqf9JnaT2XJywr6QPuWJG8F/DAEAqmHuE0L3dbtbkYBTGkLyAvJbg+E1Wo03xtPwkcjZM89IEdlPCjy/KKJwu5ICzcQ5TFVOuy83b221Zo0Jwo4gffjOPzet51STQwuD5NutSrMnkHbsbrGCZSnsVwKyYIe7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:43 +0000
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
Subject: [PATCH 10/30] iommu/sprd: Move to iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:10:17 -0400
Message-ID: <10-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0079.namprd12.prod.outlook.com
 (2603:10b6:802:21::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aed4a1-bf58-47eb-12ad-08dbf1412b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W5Nxve/hqSj2fuhMm2GUE8Ugqq65w6lrhvAxJlDuYQAoascTZndUawxgYmMzPHUTROjaxA17hQEA1WAPy+gO1UeMF1jbAXKWgYt2iqL9YM6PyhRidYbqWuw0SXYp5rrrekwfvsduFWkgME8qJ8L2B6hZViLqSHqyBJzIkqRIHXGcGG8UqHIiXZeJdhq0S/ZiTbfdXC6UeZ4HcMXitUVnf2+RpEkQO9ZtW4Omer9YmPz26v4eZHDaVhkk1ZCq/YOt0JGDxQSpNNZKDnnm1QmPaPhjajk4x9R500US9vnR6Bk7e+z3DRo+sZyjfISmuxrLSUIxcGkpgPu0gY5OSRcDTV0/lU2MCJuQASBxx5ZxIGiAvXAJDgL9jmoAAFgwyBfVoTxS65dkMzhuelOVPoMe1nzSq8HWy1bVuDPYyhnTsEhKtvA+ICAI4GiwZ6yhBsAszJzHJyUoAInLT03gQRbzo8Uh8oz5bkxxEwc0lix2/WNL00WryIpk2SfjSCwPMmLMeQ2VsHcZ+4FyjJ0lZ7K8lEsqdhfU5pvYEMTRRen8dPhOFV2IxXRVI7tuHM/5AZxrhMlCV2np7AD/VRIzrd5NFMgaRrJHpmcR4iXOVU5hyb/zzRfbKPnOv1xAoLtjr02ZYpYx2ZrTLhd4jwPWuULtyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5j5KbY0xHJ94YSN0oEFEhn+lLo7j7xo7/c6H3tHrg1HpeRqz4yUGA4TZ8Y23?=
 =?us-ascii?Q?3YrbRcuowllYoHvNBVkulCaqkMi58Gsoiz+HgOEOAuyaCAgtiXJvp64j4+fc?=
 =?us-ascii?Q?6VrfezNBuKgPTnglm++deyPCIVlBg4w3ejnuUEZWJ8zY8orQLQ8L7yPenUVD?=
 =?us-ascii?Q?k3BaRmdv5aaxBJiD4RgQ9nGxUZGR3ESi9+U09Q8A/ucxmwSESdpmK1yAwm9a?=
 =?us-ascii?Q?PS0EOoSJJm3ijCJ1wwVzyxw5iDGLft6D7LWsxFnyNM51Brqdxn+ROdNuWB2+?=
 =?us-ascii?Q?tl5bGn2uNxkfEOW/n87Q6sxbDlTHaa7/Qj8teTNK3Z3vURZ6ep7Plf3BK5/W?=
 =?us-ascii?Q?c3ZOQLAb/IepDYWRhHOZ5Iz+KIIxdq+OlX7jpv/twzd2zlxSVOMsE5fcMs8t?=
 =?us-ascii?Q?RCQKo2dGCVs/GqhlXJT0ltmSmLvsy7k6g+Wr44gEjDQzLs1hHhXMJURG723i?=
 =?us-ascii?Q?lhrEWNFn00SjpXxsYkLN4AJkMlPhgKV7uIKPNtWWPvaWt3OXZIRtMqpjc3ar?=
 =?us-ascii?Q?lZbAJhUFADkBO5yg8l9gPrvNQreQ0GxT5Qd5H80nur9MwYqHkcW9LCA5cUep?=
 =?us-ascii?Q?5W2KuXytJ2aDkxR6544c+3B1MqzMvZuSDvJr1WvFH3ky3ljJ7BXczj9OTUw9?=
 =?us-ascii?Q?A4e1X/3FGxQwqLmdwxXnOcnUFUUp1zFVKMNXCdzOAFwmPeaMRCg+eCUvaFH8?=
 =?us-ascii?Q?krz7geNKxcCXV2k+iME5rTDdYPP1GebTGbsI30y7FFNhQ+NmcddyY5V4wdhA?=
 =?us-ascii?Q?/ioHoMONjrhz8Ba9tGC/EkW0qGnqWUTQvdal0frVd7b1zOoN+g92c64KIYLW?=
 =?us-ascii?Q?252azzq6SkwzNdI2z9+NxzZOM+/IX13KzFg4TIKJWMqcYlNOtBiicijYOmda?=
 =?us-ascii?Q?4+SfdWF9ehMUb9LmkX3ZwB+5qye030ZLU84zwhy+nSkEU+9dEpJcOnX622Kl?=
 =?us-ascii?Q?G23KAY/EkZCDzMyL+0Dvb9u5ZfZxtdYq2zJnSbX0cJP6TjgL/7czlfa/8T5B?=
 =?us-ascii?Q?uQu7NI9YrCroiEygbECFa0W6FKK2siugg/K9sHHqpts2XVDQJr2LBnOvVTQW?=
 =?us-ascii?Q?sFWiH8/PL/whAGzvux+9zzOBIbBkkzCERlqQ4ocUEU7JVf6mUb466rarda8f?=
 =?us-ascii?Q?c2vtEnLs/hh8ZJFR3HPpB5+QiK24qqN2A5HIvDHRbh+awlASW5abf+NZwIEe?=
 =?us-ascii?Q?Hjk7LwsPIxJCbd2lkP/rKvO1dlEXGUansYFblkgUWBARmlTcr/WqY+Kp15dB?=
 =?us-ascii?Q?mFx/5i+82GuVsAdkOLygWMqjxXta0Xr4H1weIQQ0rVlrpFFf9DrCAZNKu1uz?=
 =?us-ascii?Q?ZaImIaS0gOWGXrVCPpx8iCDYfXq601fIPKfNV+/3RKLM/94io/A2Tca2msLl?=
 =?us-ascii?Q?7Om2/XDoqRSUuFl7ncHEvDvFNu6OoPNCiKX3rWpwx7P/1OzYOnrVhy0TC2zZ?=
 =?us-ascii?Q?cmbSm5zbsZw6y22HqjEkkS+gWu3UBq3H6+el0LGPBOWDnD0FwW6C4r4WAgkH?=
 =?us-ascii?Q?sGw/4MNSEmBoHq/R4NVfcotafuKDhLVjYHJmZgFad/SbnxPrqVJqtzlf99+m?=
 =?us-ascii?Q?hkLt22RJ6t8irn8YBrPQCLETf6EIBZpYrDbBNj//?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aed4a1-bf58-47eb-12ad-08dbf1412b13
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RImw/klw6uR5u3kIEI5FDYwuyW8PkAy+C/GVi680wwYw6hU0nSKvh/ViUO5uWBs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

sprd suports a single iommu instance and only a single id. Parse it
directly using iommu_of_get_single_iommu() and remove
sprd_iommu_of_xlate().

It stores the iommu, not a per-driver struct in the dev_iommu_priv(), keep
it that way for now.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sprd-iommu.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 537359f109979b..f1b87f8661e199 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -11,6 +11,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -383,32 +384,27 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
+static struct iommu_device *sprd_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
+	struct sprd_iommu_device *sdev;
+
+	sdev = iommu_of_get_single_iommu(pinf, &sprd_iommu_ops, -1,
+					 struct sprd_iommu_device, iommu);
+	if (IS_ERR(sdev))
+		return ERR_CAST(sdev);
+	if (iommu_of_num_ids(pinf) != 1)
+		return ERR_PTR(-EINVAL);
+
+	dev_iommu_priv_set(pinf->dev, sdev);
 
 	return &sdev->iommu;
 }
 
-static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	struct platform_device *pdev;
-
-	if (!dev_iommu_priv_get(dev)) {
-		pdev = of_find_device_by_node(args->np);
-		dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
-		platform_device_put(pdev);
-	}
-
-	return 0;
-}
-
-
 static const struct iommu_ops sprd_iommu_ops = {
 	.domain_alloc_paging = sprd_iommu_domain_alloc_paging,
-	.probe_device	= sprd_iommu_probe_device,
+	.probe_device_pinf = sprd_iommu_probe_device,
 	.device_group	= generic_single_device_group,
-	.of_xlate	= sprd_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SPRD_IOMMU_PAGE_SIZE,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.42.0


