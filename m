Return-Path: <linux-acpi+bounces-1958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52E7FE6C8
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDDB1F20419
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627051427A
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q5s5GwYE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BAA10DB;
	Wed, 29 Nov 2023 17:10:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMaX4Tx9vDBKa7I9rBQIVRYCNB1Q2n+ZttlnycpSfsZwsSZ/NQTzTbHiH0JXXRXOsgV9iDZM86YCDaOLAQTVTti1Vv6ts5diGgEEqFFHGbm0doUr0b3uEozqLAsr+OLB7tgYsakz8rz5Sbr/zC3bsMURKOb6jKMQHsft+ApJY/kwhfg+De263Gh4ABrHQcCmBnEf1W21axmZ6QcVTQh1tX/wi8T18gUmNPPReIWKnkHkwXWM/ATToz2/lJ2n5xkW6ekdxJGQf9xEeroz8rVNQjzFVl9rsGw3sJ45FOp0BcVTphaoE9ovOZb3aw8NypptNEgh9fUhGv80OpL9pq/rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpeNqsmcMauXdixm8QlzYdUa9vz4mLMc6TLXvjWdet4=;
 b=cYt8xDvqmHoKgcIg71OQjPW6VY2vBCmTcEkGYHO9uXBKw03j243eMQTNVu5yNqqkSUaupq+9oihZBHJ3CLLHhx6fqENFPyFs9T32vX41RUMokiXfTXxzhMsCJ7M1QutVqB5fvsTAYFK/LT/1C29BWyeFfC6XVVFsn9cV88lO/9mBpzreSvYpxIoyYFnSUOn+Jgx6ZvLkPAc/dJxyKBRSGTqG7NQ+3ipdApjl/8nsxmoN8WQMriG+GXhvf6HeDiTNUFAMRbwDRks+liGWLyECkpfqYO+42dlOYjzA2L+9E3do3FeHKLZ/VAHSzMZs+g3PRLFJuwpBhg57iSCKqvQ4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpeNqsmcMauXdixm8QlzYdUa9vz4mLMc6TLXvjWdet4=;
 b=Q5s5GwYE0m3R5dLpeUooCHUWM2nSHqqih9byV7HB+PlQEbJTTKFo6EGTnzjcLh9K0NAAqq1rBg68bDHsGWdLD7jEYLTfAT2GDx7n6W+Hjk0fbJzQOPtJthJW8J2lDCGNfqjaPdWvB4a3SJPQPYkONK0pGBwpfuctBaEwReDFzh+VaPg2Uz6vbM2GHvhxDJ2rUbgowJeTpN8TnuJTvYAZ1dZPxDiBxqbsgTyOA+m00xBsdeQspzTWNqx2CU2M/SbDXZPoiPoW4qjLSwc5E9YV7Aj5bMmLEnYGEHSPOIPRv53CBv77ReFbEQRHyXzL791aN14eNBuMXfoyVY/tfDhIZA==
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
Subject: [PATCH 25/30] iommu/iort: Add iommu_iort_get_single_iommu()
Date: Wed, 29 Nov 2023 21:10:32 -0400
Message-ID: <25-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba4ed4b-c8b8-4b73-6c85-08dbf1412b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2JeKNRlI6vQmBvNqI3r/MC2iGwy98kh+yqTFTheuJ/cA4n/03zJRILbuuiDEw9A5ByJYqzcmEIH/0B/41ldDouMvELZwBYlQ85VJTT4IlfMEaGEwxqFxzxqrCAuoMd/BgPdmJrSvNbpFbFkZU5+Xp6jjBUleRg8Iqph2DZ7yC2rC/W7O7BTZU+b6IKHnlUKK9M6MMYrh1CC1w7LUKfSxgEZHTPvVaoKB2YZFpkau2GYCjuVjvxNXRFSXZyQ7X/oJF4Y1rWl18BN+wqXJp6rzW3va+8ECDJ/FS9A9wuQNEExja55s/avbZa8/dUATA0fvijYIGaSdVgrZdHt1oLHMYuhc3QD5QDTt63Oij/0bucxrj0KOU+OfwXESN4I/hCYJqlJ3ilti63alsGhgvqg1wmxnfvgd6+22UnJ9oCYA4RPakyqVUexAJZ0alFG747F4dhZ0XHHmzWSqKCmjrkscoXMfaEwiqxfT7AtXpTfA1pPJFLYmJiPJKWOrED775HnupYgOc+bWB9oX4Wh9J/17amBZ64CwNqnYlrY5k/uvtHUlu9fvGZQKiLmgS0XveIlPMgKeGsvCmfToC9PVGTrfYzIIVdfqUivMN62DODe/sStO3etVABOJ4pV61JFMMx7YjS+o7XmBvXStWJvgE9j7Dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+DDY0B7tA7PB0dRRBXyE54dSkQ0AmSQcYgFiz2FZb1NHkGPaUzdec4FSkiYN?=
 =?us-ascii?Q?wpxwSjfTnKSf6tREttknkmX6iTtSon1wC75j+GyMDCxBE92Pjzj9xGjyJbek?=
 =?us-ascii?Q?wTsaQhB2vN44Wnp5Hml+5yvlMbmhndXKCFAsPeMS4gCG++ECIZdZ1KyIKBV8?=
 =?us-ascii?Q?CvR7aNdrIk8pQsHKJwWzmbNVZDKuMQvm6oT5hftMZub4VppMA+73lFTR/ev0?=
 =?us-ascii?Q?imkt+O8BWmYVykaoQIiDVQD5o19OM7txglBbhMgDMdjrINkglUabxpPMFomg?=
 =?us-ascii?Q?RHTIW2JT+yGrYezzVnNAMJ5brZMlu1Ad8edmP+R2rfcRtqZyKU35oHvR794V?=
 =?us-ascii?Q?Fr5PYBBeUU15oXxeqeigZkCvGqDwU7V93VPUV9OJUhgN3aa/6TQzA0WJazb2?=
 =?us-ascii?Q?4VeIWkolrWOBAu0RgwKgC7vRLyBDx8dEou0ZEB8ISmI2q66KgyIusfa2hyku?=
 =?us-ascii?Q?CoxKtoEtjP7CqRKvJO3G/wPIVxuFMF2NTA0d5e6KOMMOmVYhUAWRZ3DcGzZc?=
 =?us-ascii?Q?o8t3oUo65dFXQMRgbuubCR6rrKRAdoNLYvi0XRtujrVWX1q/UlM9/oNMUoOd?=
 =?us-ascii?Q?ryarR6WlwdSHEZOIax/8vRsOmGDByLct0Fddpi3pfwwerKL35H//n3l9ly1H?=
 =?us-ascii?Q?8iKPtsMFyXe1aOkLw73si85AdRROubo9K+bo971gBumTqdwfJmNJFi8nB5KW?=
 =?us-ascii?Q?I7iQNp7MjwIH3N41AkRQ9dAQ46KX2EMqsvwR+7hw7NRYTeUF8QNaPEEKDakI?=
 =?us-ascii?Q?QLY0whT1SoWXa7XxI7vT8cKfZEhJMo/khN9PSAFbUy6lEoHGTHbQYE+5ciA7?=
 =?us-ascii?Q?TaZDI7QDJJOh+ww4useldU/mDftwfuYNbOeUmVCBLOwYzFTAVwOlhN7wAK8j?=
 =?us-ascii?Q?NRannpcCUmOsbSnclGaXDpupinuTxk4whBLW+Zp3lwdnBpfLUenJbpTMc940?=
 =?us-ascii?Q?d5tkXiMT6XCGNQyjFfwxAmZVouFDOSoQ9k+FODvLoE3FFuGvxaI1iNUrjkQP?=
 =?us-ascii?Q?jogvb7UqaTJvdVn0PmYpRT7Rri08TrRFUFq2VVDK1wgYXVs++p2RrPdgGzK1?=
 =?us-ascii?Q?g3CLyvQGcLxI2FRRGkL+I6i45QArP4zWa0i+DB6hUCSk0Dkk/LCZ+0BUQviP?=
 =?us-ascii?Q?OUa0kmVnlTFC1g/wJSZ8yUFyALKA+c3NnPPoF8yrKckIx3HsOUf+tlD+jlW4?=
 =?us-ascii?Q?GXQxvUl7hPqS3CI0DILqkb/94D8YlWkVeycE3WDjZ9l/PBKDKGbq9AjKNhNA?=
 =?us-ascii?Q?mZT7QtJ4YmDTwHuv9uker7jj5ZfBIeSA/Gj247SI1sm2rs2omunZju3kZrko?=
 =?us-ascii?Q?Yht8XKV6QNDq3nGd+b8tJrSH7Lx9rVlB8/YSLGb0ms49bdPuy9zmUx2jlnUF?=
 =?us-ascii?Q?8iI4MUTs4iukSKky87SbPfvV/lEb7ZJkPHVbgRjQA3zsKBZImjD8ifwvKX8Y?=
 =?us-ascii?Q?pqFKHVbA+y9myucbWetzo97TyPyKSN7qanqNUcnfPYEQ+UsXAixgCLB26DqL?=
 =?us-ascii?Q?O4y49mEuckrAC3WLtteWoACWpg32sBcmdx043pSjtqI1mFkeeXZYgV0o3Ew1?=
 =?us-ascii?Q?GbGOds+cgqLh8gd6RNsT+mGl6cLxn5E6zxM3GnBz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba4ed4b-c8b8-4b73-6c85-08dbf1412b2e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1ptQ4YEgwN12VSPI5d2e8VoSf0UaubtgfJzy2NZU2EGMrMwSithTO2wuZ6PAL3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

This API is basically the same as iommu_of_get_single_iommu(), except that
it will try to parse the ACPI IORT table if it is available.

The ACPI IORT table can return a flags value to indicate
IOMMU_FWSPEC_PCI_RC_ATS, return this through an output flags pointer.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c    |  3 +-
 drivers/acpi/scan.c          |  1 +
 drivers/iommu/Makefile       |  1 +
 drivers/iommu/iommu.c        |  3 ++
 drivers/iommu/iort_iommu.c   | 98 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h    |  1 +
 include/linux/iommu-driver.h | 41 +++++++++++++++
 7 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iort_iommu.c

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 798c0b344f4be8..6b2d50cc9ac180 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -79,8 +79,7 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
  *
  * Returns: fwnode_handle pointer on success, NULL on failure
  */
-static inline struct fwnode_handle *iort_get_fwnode(
-			struct acpi_iort_node *node)
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
 {
 	struct iort_fwnode *curr;
 	struct fwnode_handle *fwnode = NULL;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9ec01196573b6e..eb7406cdc9a464 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1571,6 +1571,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	struct iommu_probe_info pinf = {
 		.dev = dev,
 		.is_dma_configure = true,
+		.acpi_map_id = id_in,
 		.is_acpi = true,
 	};
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 9c35b106cecb2e..ebf6c151a97746 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
+obj-$(CONFIG_ACPI_IORT)	+= iort_iommu.o
 obj-$(CONFIG_ACPI_VIOT)	+= viot_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index caf14a53ed1952..7468a64778931b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3030,6 +3030,9 @@ iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 	if (!pinf->num_ids)
 		pinf->cached_single_iommu = true;
 
+	if (pinf->is_acpi)
+		pinf->acpi_fwnode = fwnode;
+
 	if (!iommu || iommu->fwnode != fwnode) {
 		iommu = iommu_device_from_fwnode(fwnode);
 		if (!iommu)
diff --git a/drivers/iommu/iort_iommu.c b/drivers/iommu/iort_iommu.c
new file mode 100644
index 00000000000000..9a997b0fd5d5f1
--- /dev/null
+++ b/drivers/iommu/iort_iommu.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/acpi_iort.h>
+#include <acpi/actbl2.h>
+
+#include <linux/iommu.h>
+#include <linux/iommu-driver.h>
+
+struct parse_info {
+	struct iommu_probe_info *pinf;
+	const struct iommu_ops *ops;
+	u32 *ids;
+};
+
+static bool iort_iommu_driver_enabled(struct iommu_probe_info *pinf, u8 type)
+{
+	switch (type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
+	case ACPI_IORT_NODE_SMMU:
+		return IS_ENABLED(CONFIG_ARM_SMMU);
+	default:
+		dev_warn(pinf->dev,
+			 FW_WARN
+			 "IORT node type %u does not describe an SMMU\n",
+			 type);
+		return false;
+	}
+}
+
+static int parse_single_iommu(struct acpi_iort_node *iort_iommu, u32 streamid,
+			      void *_info)
+{
+	struct parse_info *info = _info;
+	struct iommu_probe_info *pinf = info->pinf;
+	struct fwnode_handle *fwnode;
+	struct iommu_device *iommu;
+
+	fwnode = iort_get_fwnode(iort_iommu);
+	if (!fwnode)
+		return -ENODEV;
+
+	iommu = iommu_device_from_fwnode_pinf(pinf, info->ops, fwnode);
+	if (IS_ERR(iommu)) {
+		if (iommu == ERR_PTR(-EPROBE_DEFER) &&
+		    !iort_iommu_driver_enabled(pinf, iort_iommu->type))
+			return -ENODEV;
+		return PTR_ERR(iommu);
+	}
+	iommu_fw_cache_id(pinf, streamid);
+	return 0;
+}
+
+static int parse_read_ids(struct acpi_iort_node *iommu, u32 streamid,
+			  void *_info)
+{
+	struct parse_info *info = _info;
+
+	*info->ids = streamid;
+	(*info->ids)++;
+	return 0;
+}
+
+static int iort_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	struct parse_info info = { .pinf = pinf, .ids = ids };
+	struct iort_params params;
+
+	return iort_iommu_for_each_id(pinf->dev, pinf->acpi_map_id, &params,
+				      parse_read_ids, &info);
+}
+
+struct iommu_device *
+__iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct iort_params *params)
+{
+	struct parse_info info = { .pinf = pinf, .ops = ops };
+	struct iort_params unused_params;
+	int err;
+
+	if (!pinf->is_dma_configure || !pinf->is_acpi)
+		return ERR_PTR(-ENODEV);
+
+	if (!params)
+		params = &unused_params;
+
+	iommu_fw_clear_cache(pinf);
+	err = iort_iommu_for_each_id(pinf->dev, pinf->acpi_map_id, params,
+				     parse_single_iommu, &info);
+	if (err)
+		return ERR_PTR(err);
+	pinf->get_u32_ids = iort_get_u32_ids;
+	return iommu_fw_finish_get_single(pinf);
+}
+EXPORT_SYMBOL(__iommu_iort_get_single_iommu);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 13f0cefb930693..bacba2a76c3acb 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -40,6 +40,7 @@ typedef int (*iort_for_each_fn)(struct acpi_iort_node *iommu, u32 streamid,
 int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
 			   struct iort_params *params, iort_for_each_fn fn,
 			   void *info);
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node);
 
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index ce0ba1f35bb5dc..c4e133cdef2c78 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -19,6 +19,7 @@
 struct of_phandle_args;
 struct fwnode_handle;
 struct iommu_device;
+struct iort_params;
 struct iommu_ops;
 
 /*
@@ -39,7 +40,9 @@ struct iommu_probe_info {
 	struct list_head *deferred_group_list;
 	struct iommu_device *cached_iommu;
 	struct device_node *of_master_np;
+	struct fwnode_handle *acpi_fwnode;
 	const u32 *of_map_id;
+	const u32 *acpi_map_id;
 	int (*get_u32_ids)(struct iommu_probe_info *pinf, u32 *ids);
 	unsigned int num_ids;
 	u32 cached_ids[8];
@@ -63,6 +66,21 @@ iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 			      struct fwnode_handle *fwnode);
 struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf);
 
+/**
+ * iommu_fw_acpi_fwnode - Get an ACPI fwnode_handle
+ * @pinf: The iommu_probe_info
+ *
+ * Return the ACPI version of the fwnode describing the iommu data that is
+ * associated with the device being probed.
+ */
+static inline struct fwnode_handle *
+iommu_fw_acpi_fwnode(struct iommu_probe_info *pinf)
+{
+	if (!pinf->is_acpi)
+		return NULL;
+	return pinf->acpi_fwnode;
+}
+
 typedef int (*iommu_of_xlate_fn)(struct iommu_device *iommu,
 				struct of_phandle_args *args, void *priv);
 void iommu_of_allow_bus_probe(struct iommu_probe_info *pinf);
@@ -213,4 +231,27 @@ __iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
 			      __iommu_of_get_single_iommu(pinf, ops, -1)), \
 		drv_struct, member)
 
+#if IS_ENABLED(CONFIG_ACPI_IORT)
+struct iommu_device *
+__iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct iort_params *params);
+#else
+static inline struct iommu_device *
+__iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct iort_params *params)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+#define iommu_iort_get_single_iommu(pinf, ops, params, drv_struct, member)    \
+	({                                                                    \
+		memset(params, 0, sizeof(*(params)));                         \
+		container_of_err(__iommu_first(__iommu_iort_get_single_iommu( \
+						       pinf, ops, params),    \
+					       __iommu_of_get_single_iommu(   \
+						       pinf, ops, -1)),       \
+				 drv_struct, member)                          \
+	})
 #endif
-- 
2.42.0


