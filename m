Return-Path: <linux-acpi+bounces-1955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E57FE6C4
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E2B281A56
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05581426E
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3Fyl+x8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C1E10D3;
	Wed, 29 Nov 2023 17:10:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiEU4CYxCxCMvETPUn7OkArhjhsix3Xvy/p49AHMHPmM4C8P1Xhl+vrPGo7r1gs5BucfOdRAPS3cIVoAaW2gXBrcO2ypGxbJtMN9nW/ZcB5cbiiG5BN5zCzhrYnzefe/mvYFkbmNxzXP4KXYVfone7Vx+jysPmBBhw+J9tJIFvc5MaFKsr3Mqsod8Br3/wIX92toyAGoLiFNgUyZG6+NqooSWltb++gF/HUK4KI2MVOP12q38cwQqtIhR4M4u0tBZ8szNcE0krTKYjo0+vEmdlGLkAraHhs9RTsvkmm+/wRfOQ0rxBXOf2F66MKQbGRzKE6KeTjfv7AQ8Y6d2iC4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1KisvyhyyfD/zj56awPrs2Vc26WKPVJEkpLqxbG9xM=;
 b=jvB9n6FVaRvLpJXI0m0aZpeZZxe3vqDKY4y75eZdDA2jbdBv7C/Pk6y7dAKkzhquQToZQSzbcIgCqQMjWJihY7bynA9xNA/EDAQV5iIwtCuOgEol/AkKkMu2CNzr8FzdyTZQBEdNlO+G99DNp5hH1gsLs+hoSqqVq6epeLuFbK4uPhz3CxXhXqtT1uvkEUOE2ITA4Megdqj4JehI5EuxFYxnkCGkVZ3MPnyT9iZProPj51jXD5/6ZCD5pz63Bsf0oN2DM2oqq+uoHGuIlWX7D+MI4W47pH7qastkkEx7caynJ5vFHnQRW01obvGNXnmKN87y45YyA0Vu3U+NaNu3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1KisvyhyyfD/zj56awPrs2Vc26WKPVJEkpLqxbG9xM=;
 b=W3Fyl+x8fai9FMBMKPC8eR+Ucldqg5DjbtgRnhci8MOQ/CDggJ/mTeKSsR4568XpSuHyp2jhFuoOobjK6nAKj9WDEbE6PcoY763WS/v2Q7n56hJN63nSeXFZZ70P6E+e1mh3hBUKEIpip8xTyuSdqfb2aDVTL+YAr45f/k89BSyZaHWea3oxbvBwdZSo7vzVJIrgL+RP3Uu0gTLi4HE/czrPOA86gnIpIrLDMnheBnJsEK7K9lX3EUXh9pVzjAgWv6NN3AbZp6ddXs2R/9x6zOJR0F8fIWQNHJhoSkeoYv6XbeOgottdgQ9fp0ONrkd0snk6ogyX3OisSqFBJgslfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:46 +0000
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
Subject: [PATCH 23/30] iommu/viot: Add iommu_viot_get_single_iommu()
Date: Wed, 29 Nov 2023 21:10:30 -0400
Message-ID: <23-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d41282-ade7-4f6e-da64-08dbf1412b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FcqJkDaYCRW1+7dfxPXuWx2kWu3henT4khNouNcMiZc7W2186WW7W3Ve22iiLrIZOVelThuER0SrdP9LSLVLbGxImJyfpOArdiQhOIVeAOU/MklT2rTP6/jMIa6dqGjhLtVyz91ogokFhXWUatoGtgaU5YNNoy2WT3z8iVwmhlOHP0oFrtD5jrpSxuqPQadDBqkM2RtYaAjkJR7P7pBZggnYqtPgQ2Vi/ckrMb15v2BezzyJkbwp9bvIiOvh0wKw+1xjZCXyOdjHzmQDF6pTkzLlHhFGXidDLWI4j0EHa3vVI0XBFRaXKE/u2imXHXmK2SHo6nbdzFOkxQxJyfAWnaf9QkhsB9dqpfveUm7NBHed9nx10BAoLe34E8U6J+9t13xw22+aimw8qOor1CQsrrILgMjCcpukkh9m75rGRhCEHGEb8zqIBd7YHoVNY0Vo+XcEJgsuiLp4NVBYNnF+n8Ji6JhODtuAOA9ObYcndIseS/JGH01Iq58bFqbmoSUWvc1TDkMy02O5ta01xtdvD+9gQ+C32aW7Nf/CtwcLhbLZJVK/TGyn+V3RmaK8pc8W2JaTWVAw1EivjOmEFIH2ERThjXCb709CVG+0u32ewfHpNxlMw85tyDqpJ0U0HVN9TPhy0mCHQN6Mp3wI52bAog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?db4P0KPYS+8E+xzoxKDLUd3iPFwRqT+I9RIQsox54u7ajxrminkGT4Po5eV8?=
 =?us-ascii?Q?OHE3Bcxm1wg48v24Oa7Srr5QECWtQ/QuaALN9hIR52TI0pB0dIMQ3opN+N4g?=
 =?us-ascii?Q?GiOYasYXArQ3/75FQNCD6+Dvxo1Nfv4h9eCU7lLrBoArSCgi90nbGor9bSRw?=
 =?us-ascii?Q?C6EwbrCmb45ILpHeORA/GCO89yY5xpuiCnvywlY/rVuj8TbM0yD29aLJCWlL?=
 =?us-ascii?Q?t/O/DxQmq0hO9TIPfkyN7WSEXYShu3Xs7TjdIgXf6Lh31/pW7xh+zkGfoFQN?=
 =?us-ascii?Q?FWLNKZg8ohrbFoz8nwExW/VTanvfim7j94wMj8Tg2qfUplKuHjLN1CNWUchD?=
 =?us-ascii?Q?sxAISnaL9womVz9q+1WtShngbHI2vstOHVJWi3YwGslAQOS3qGgjuty9sjrB?=
 =?us-ascii?Q?ef5F4kivpflsS/X235CpA2coJBCmcmPLbL9bueEy8z+PBYycnpLH+FBthsX4?=
 =?us-ascii?Q?Gug0XOcuAA21/WnTwTFYzSDgQ34Tf1J92h75PLwfvfruLPtWHfo7jSeM6ri+?=
 =?us-ascii?Q?yjXDP7nTV3IMjpRinsbyBjfILNXcKwbYtCRSRkaRi6CFK1d+bioQiE55rl+M?=
 =?us-ascii?Q?adUf3SGSXL437QUZCJmJmbHIjITOLJbzET7rk4yGFdpTzDiNTU7lHy1GQ/Gd?=
 =?us-ascii?Q?0cTPRvtJc7srlM3yII0HUPTpIVyKQc8pRGR9aOxnETUWdDGdGGNNb4/ppwFU?=
 =?us-ascii?Q?vPyTNZSLgtP5mapQRC9U+r2/DkfWIK+3R9eIjJL24iFT3uSbKXDaU+jpi9nl?=
 =?us-ascii?Q?bbz72Sq/uKS3rLnlajMWf04QuPdis+FCwoPcq9i+X/eSdhNezOX7mXJ+Gc3b?=
 =?us-ascii?Q?sFFTwEiNXU4FVenfjZO+dffO/Eq9wYG9e2eYIDWjJPOsMOQuPPo6eyk71Ovu?=
 =?us-ascii?Q?/uDmIMxwmc5ONDcbVOwQVhu0eht+bdkFZhCgAQrEsXn3HL2r0efV//GMiy6G?=
 =?us-ascii?Q?Mrs7iOc/hQc4DTc4sfVk/4GIu66Clm28VEyOMYpLYkqmitSF3su9YZEN0Tzt?=
 =?us-ascii?Q?JiTApufKKhzeYvE3SYpHj8XpWb8uDo99ar32swu147JmzgREuwm7GUNOKALX?=
 =?us-ascii?Q?aFemdjN4YZk1Sc/rdDYJAqzFTkWtlzNMlFb9fyx0qN912l9BSonp+9/DjDQ9?=
 =?us-ascii?Q?ufifHD+YivOCoQGJ/J1Epf7KtZQRCxHf+VXZGTitLptxrSdwiaYrYFdbjmhN?=
 =?us-ascii?Q?7Q0F1fQZdxz306Mb6xND3PUdILOkOcNIHFWWi5LLvza1ZctzWH13QPajVDyg?=
 =?us-ascii?Q?WQtBlY9CdgUyaKlPL+Zm/68zMWoqjXMefXdL2qxZbtEOfw6ekWr/m+tT2sxz?=
 =?us-ascii?Q?T/nGFlWQWDqALwJfL3sFLrsyOjQml2gd0X5eC2nMKr3j/XjyA3bTei3znMPs?=
 =?us-ascii?Q?VjFCRiemZeMaizbPiHLBzExmyV1co+Av+QoPDw8g5KupGhsXQfsalOjBEqhv?=
 =?us-ascii?Q?8t6NAn2OLGhXaHogYakFKiXbrfVwXkz4gUHLxEqzobCKD0LdPVXvM/+CnARX?=
 =?us-ascii?Q?pTpjT0DCteKZjUyf+6lxg//SzorSt9VV0MKNza4M4yEwYh5gUvusktaU/wx6?=
 =?us-ascii?Q?Fs6kFZxzizF6cFoRtyLj+ZRTC+oT0vk3XkCUOHZE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d41282-ade7-4f6e-da64-08dbf1412b3c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33NPhtelYllkoQCYFic3Jpwc/yPXINMej/xnKpzw+033M/3F2PXpsGOi+A0YlHle
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

This is the ACPI VIOT version like iommu_of_get_single_iommu().

It parses the ACPI table, confirms all entries points to a single
iommu_driver and then returns a pointer to it.

Also cache the u32 id list in the iommu_probe_info and provide a getter
function which re-parses in case we overflow the cache.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c          |  1 +
 drivers/iommu/Makefile       |  1 +
 drivers/iommu/viot_iommu.c   | 70 ++++++++++++++++++++++++++++++++++++
 include/linux/iommu-driver.h | 25 +++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 drivers/iommu/viot_iommu.c

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index de36299c3b75bf..9ec01196573b6e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1571,6 +1571,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	struct iommu_probe_info pinf = {
 		.dev = dev,
 		.is_dma_configure = true,
+		.is_acpi = true,
 	};
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 95ad9dbfbda022..9c35b106cecb2e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
+obj-$(CONFIG_ACPI_VIOT)	+= viot_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
diff --git a/drivers/iommu/viot_iommu.c b/drivers/iommu/viot_iommu.c
new file mode 100644
index 00000000000000..e35bd4099e6c6a
--- /dev/null
+++ b/drivers/iommu/viot_iommu.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/acpi_viot.h>
+#include <linux/iommu.h>
+#include <linux/iommu-driver.h>
+
+struct parse_info {
+	struct iommu_probe_info *pinf;
+	const struct iommu_ops *ops;
+	u32 *ids;
+};
+
+static int parse_single_iommu(struct viot_iommu *viommu, u32 epid, void *_info)
+{
+	struct fwnode_handle *fwnode = viommu->fwnode;
+	struct parse_info *info = _info;
+	struct iommu_probe_info *pinf = info->pinf;
+	struct iommu_device *iommu;
+
+	/* We're not translating ourself */
+	if (device_match_fwnode(pinf->dev, fwnode))
+		return -ENODEV;
+
+	iommu = iommu_device_from_fwnode_pinf(pinf, info->ops, fwnode);
+	if (IS_ERR(iommu)) {
+		if (!IS_ENABLED(CONFIG_VIRTIO_IOMMU) &&
+		    iommu == ERR_PTR(-EPROBE_DEFER))
+			return -ENODEV;
+		return PTR_ERR(iommu);
+	}
+	iommu_fw_cache_id(pinf, epid);
+	return 0;
+}
+
+static int parse_read_ids(struct viot_iommu *viommu, u32 epid, void *_info)
+{
+	struct parse_info *info = _info;
+
+	*info->ids = epid;
+	(*info->ids)++;
+	return 0;
+}
+
+static int viot_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	struct parse_info info = { .pinf = pinf, .ids = ids };
+
+	return viot_iommu_for_each_id(pinf->dev, parse_read_ids, &info);
+}
+
+struct iommu_device *
+__iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops)
+{
+	struct parse_info info = { .pinf = pinf, .ops = ops };
+	int err;
+
+	if (!pinf->is_dma_configure || !pinf->is_acpi)
+		return ERR_PTR(-ENODEV);
+
+	iommu_fw_clear_cache(pinf);
+	err = viot_iommu_for_each_id(pinf->dev, parse_single_iommu, &info);
+	if (err)
+		return ERR_PTR(err);
+	pinf->get_u32_ids = viot_get_u32_ids;
+	return iommu_fw_finish_get_single(pinf);
+}
+EXPORT_SYMBOL(__iommu_viot_get_single_iommu);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 632c7b4a389abe..ce0ba1f35bb5dc 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -45,6 +45,7 @@ struct iommu_probe_info {
 	u32 cached_ids[8];
 	bool defer_setup : 1;
 	bool is_dma_configure : 1;
+	bool is_acpi : 1;
 	bool cached_single_iommu : 1;
 };
 
@@ -188,4 +189,28 @@ static inline int iommu_dummy_of_xlate(struct device *dev,
 	return 0;
 }
 
+#define __iommu_first(a, b)                              \
+	({                                               \
+		struct iommu_device *a_dev = a;          \
+		a_dev != ERR_PTR(-ENODEV) ? a_dev : (b); \
+	})
+
+#if IS_ENABLED(CONFIG_ACPI_VIOT)
+struct iommu_device *
+__iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops);
+#else
+static inline struct iommu_device *
+__iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+#define iommu_viot_get_single_iommu(pinf, ops, drv_struct, member)         \
+	container_of_err(                                                  \
+		__iommu_first(__iommu_viot_get_single_iommu(pinf, ops),    \
+			      __iommu_of_get_single_iommu(pinf, ops, -1)), \
+		drv_struct, member)
+
 #endif
-- 
2.42.0


