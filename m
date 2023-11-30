Return-Path: <linux-acpi+bounces-1947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4FB7FE6BB
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A09F1C209A9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A2D134B0
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IQjX7i/l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F010A;
	Wed, 29 Nov 2023 17:10:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNwgJ9M0f7NHybi2UuKUbLbc/hViKCX0JdfFD4LKzmJEg6s+LP8Y9AZUuKbRNOl7yDPWwcHU1nLAi0/9wk0tqyTyShrSZGfs8teEaS7F1gURJZdlLOLIxtTtOh82QtnTbjnjD8KSdefGkuKXVvmUFcitXnfPXDyH5s1mRVgVOpADG1fzrKOXwFmUjV1EaA3NjT1ALgL2VE17RJaf4XiAMIEW9RH6DOynB3ERhCNusPdvYlWj18Eaoajekj97s/SDd2J9Hsta+77QUj163kPqcUhz8Q653OXSApzTaLoNj2XfOMaxNQVIiGGf3vcTqpEeH5jidNlKKhggxHqfm7VYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7r48HdaFD2m3FjojzyB3owyxRtlpeFZA78h2PReCEE=;
 b=k7uIMreIE5QccI3QJKd8el4wYJ+423L2GNMZq/rj2mSAo6QgcxrgtW+wu/JZTPPlh5jH+GqwImX+Xn7Vr/Y0kIZD2/DIfPE92/5NtSLiBVzNy7gjXAdOaRLoDdlVaTNphnhRdmWous/Z7L3BzoF0THBSBY2bP/uvArmeMtrdCUdBRABQqBEhM6/UTG2A2FMwIHQZAlA/SmKzczDzEzh/RmCls2f77HkdECDH2KeZiaSfyMDqhoPpikcEeHwwg4Wn+hjFCdzL78tNJrvDR1vRE1HZBQQ8i2Ujfq2QjH+BHZkk+E02fAo2okPZaaOpin8/XG119qtPPKD1PE5UxJQvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7r48HdaFD2m3FjojzyB3owyxRtlpeFZA78h2PReCEE=;
 b=IQjX7i/lv+Z8mK2447t1yUT/Sna9CuJqhyRNXlZjIfjeLlhVKevGVzk0bHpEF3wADhFGrWz1o/yO3ZAD5UFOVqVPDZo/CnvwdGhSvmEqFrtdE+JLCBD7Y27mzk6jfrkHWlyyvG3eUusL2mY+GGR6Hbcl0OkA9YAakzZw1Nmffbhat/ylH+gIV5wpkjz5IB6K+Us4L9ZHTsHint02NxqaJYuXvJ5MKzBADQwNLKCEn58whZ3YGCX8nNUXOcwP2yssEwwn1+5VpDLOG5/aVaplgBIXv6VBHka0k3F3rnXYdVdNB52CYIJUVxe3N9OhindYi9JY7B0MhZbmFHVXSQTs5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:40 +0000
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
Subject: [PATCH 05/30] iommu: Add iommu_probe_info
Date: Wed, 29 Nov 2023 21:10:12 -0400
Message-ID: <5-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0106.namprd12.prod.outlook.com
 (2603:10b6:802:21::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2d4ae6-9622-4cea-e3f7-08dbf1412a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/wWspF/FaTgWBVwC3jzSZmwVrg9el1WqTPJImdRwDrEM/jzXqgmhaJE0/icD4hBsG3L0Ez+/ZJyR1WRs5YMcYFZD9Ck+7ls/9OJoF4odI2zvRSTUFA+aCYVn1vcz7NvpeMUgYE9do2TydLJIkJBawiz0zMENmQalX3Jm0rUKKSys48D8AXC68dUUGYZ53oDxF39YC5eiNMbjwJ4STl4ha0+dfeK/7F5vJ0BzzBxhUXJADiuTGutv1oOfTrClckCOC4+3q075y0M6SUQwTSLr285vcTTTrHJ9j9vYQAnnLBfh5zzA39o4fJD9IemL3IiN58iM7bggWCPA5p5Kuy4Fu53f/FE5veH11LlmSOL/k9fp5kZAijrbe1iWY57ESPKTOuTSt39spVJM/IV3YXslnTRlG15IHh237t9V+rwwroo71q4qIJGfvnkNKlaVmC5+DrqaOkY8Jz79dtTfWyDDbgH/mJlEhglQ+Go0qMLYbWtHJczbSjzf/VYhXLom5rftjcUGCaPdEFh0lU2IoMPPLma11BZHvtlXQxoZ5WGPTKRQJIKxIjcMBCGq/l6jfshgKxQdOxYU9SP+RqctYqqSfsYxPDQo79jKMtWGRwBVgrpm7SVmk4Z4Kfb2gIMezmwuXXS64EvJvTzr2xmQroKgBDUlxBWwXQG56UcHd0N2v4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MU0MdKuBSJB3CE4W+zHAs8QPocLSd6QOFhUd8whfIz7Mlq/5Fejr99reHWi?=
 =?us-ascii?Q?yA2kd1cqZ6t2Z65rMpvmH3hfSRO8fC9m28Ub3rfzTmcwP9rAzn3A70SdPHRD?=
 =?us-ascii?Q?KuFzOKBRPR1wkQtkVyOgj4QXwaH8wo63bKL7nOjg0LMRXUC/F9Ml4zK8oFdF?=
 =?us-ascii?Q?amK4OR16dRiCFljG/V/CPhRGDsIOyeaa9AQNehwXshKGTsmO6P7iisHLiwKS?=
 =?us-ascii?Q?KxsD9SFB/POLtRg6lv7SNl3lu25gcqnq48X/OHeImwCPCC1qa0bxWphcCHxO?=
 =?us-ascii?Q?1PJPwALXCZBIqEdH93lIz2pQ7d4Q6y4xoiniUACBMwtbumDkwYEf8zegp70O?=
 =?us-ascii?Q?ZWPzc+IyV9icqaceQyl0XY6zp3SVphMfswzB5YMRlc4Lbv+NyAnHuzkj50Gf?=
 =?us-ascii?Q?ap5PqYjzBDee99GXAEcWV2O98+rxLBIyOaVh2/EZoI2MBGDQG88ZAFq8LbC9?=
 =?us-ascii?Q?J/GOZmN1C62KMRYH5gwTrsIMyaw/3KoigyGyu8HhPBV42MjG3sJpeZ+38PD6?=
 =?us-ascii?Q?ungFH1K3DIS0K23vq7alpwSNDL5oyMwR52yPuy2lQT48oofpyp5yHR82dgys?=
 =?us-ascii?Q?nenKCSr3gmi+0RDpoaWoVwA4G1wHQFsOAJdz3nQ9AQLNZDsnguEOleXoMCLi?=
 =?us-ascii?Q?W0R/h7mPc3EAByu/RExa3o6fd3zJ0vhQHDn+sYRpwvjGM7BrrxvjX44nih5I?=
 =?us-ascii?Q?R7C/w+p5WkVd8UsIUOuiJvq+yFYj0DmbLdgJTPlPmEQrAwZuW8hY3KT64DUw?=
 =?us-ascii?Q?qjHI3cSYB0t/3X85jgvAyR21PHqBoF/eDmPkTlcCOGp8VZ71Xk+wt5AwAoOO?=
 =?us-ascii?Q?a80PokXg+GaaFyIigPAIluAzY746OtjADWvD7LURjnyqtSGzzi97SxIzbcAB?=
 =?us-ascii?Q?o1+JmjBgPqIUBnbTgFcPJyWgtRwY8oH1186cXU+jSsBLi5F1Kg1Vc0WK4fSf?=
 =?us-ascii?Q?JVcBj+UONUimzsUSgRPb5MukNlBXeen7bH3Q8ef4ygHG6Izk/mUpdy5BMBEm?=
 =?us-ascii?Q?Ftmwzzk6K/rVKE1mceHaYd07YipN/cRDcf2RXVQpFQiwbfcLclotGN6ExPjl?=
 =?us-ascii?Q?YmN/VcsTHVikLqaZQRtYiYwaQs8dwFWGIgznDmUbczWzn/3K0DCGpEfK5ZNE?=
 =?us-ascii?Q?I+JgCXfPk8MANZ5+oVLlo2Qa1W8CU1fa9KlUSMvKuAKStpfg1TQOdQrPV6tJ?=
 =?us-ascii?Q?bWMf0b/hqHDHfwCgB4BVbiv0tYH68MbjNflQXFx7Q04iV0/hyzX4gFmBYQan?=
 =?us-ascii?Q?uMZEkfr7UQkvw67g1XL2MALRSbimigZXoxpBCFmYFHXErNLMS/bGe6e6rqhQ?=
 =?us-ascii?Q?iSMj/jTj5C0L1P2VKc0+Qn0t7d+KfMNZz6qGmzjizdTs9QkJGZ80Weyp5owM?=
 =?us-ascii?Q?khZCl2aqzy6jY1jl0wLKI80Dc4i+9JxwjR0kvrLaZ03Zji8KFsIfZziEFyzx?=
 =?us-ascii?Q?7ifhlzcs+1GbAbpouNxdKXVv86rqUB/s540n4dQdVgFMvZUWH5HfpxarlciQ?=
 =?us-ascii?Q?ttRKQUNdeRWxKlkJYCOL42Ztrihw/6cxe4NrXBKEMSVNPyxE5BlK7bkrn555?=
 =?us-ascii?Q?NPUZgnVrN7mzoG6dGtRY6mdWNW8Wmy69Iu8jtOyv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2d4ae6-9622-4cea-e3f7-08dbf1412a4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:39.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrLki78ZDAKoF/Un4eAP9aiZ8Zf66eXHu3kHgx7W0YNmcQQ64OceHRTRzbybAF6o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

This is a stack structure that is passed around all the parts of probe to
allow them to exchange data.

With the new design this will be a place for the FW logic to cache data to
avoid reparsing and a to convey the currently active call path for probe
while we work on restructuring parts of it.

Place this in a new header "iommu-driver.h" which is intended to help
isolate APIs that are only for use by the drivers away from the consumers
of the IOMMU API.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c          |  7 +++++-
 drivers/iommu/iommu.c        | 42 ++++++++++++++++++++++++++----------
 drivers/iommu/of_iommu.c     |  6 +++++-
 include/linux/iommu-driver.h | 25 +++++++++++++++++++++
 include/linux/iommu.h        |  3 +++
 5 files changed, 70 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/iommu-driver.h

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 340ba720c72129..9c13df632aa5e0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1543,6 +1543,8 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 }
 
 #ifdef CONFIG_IOMMU_API
+#include <linux/iommu-driver.h>
+
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode,
 			   const struct iommu_ops *ops)
@@ -1566,6 +1568,9 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
 	const struct iommu_ops *ops;
+	struct iommu_probe_info pinf = {
+		.dev = dev,
+	};
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
 	mutex_lock(&iommu_probe_device_lock);
@@ -1589,7 +1594,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	 * iommu_probe_device() call for dev, replay it to get things in order.
 	 */
 	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+		err = iommu_probe_device_pinf(&pinf);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9557c2ec08d915..76b245973cfafc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/pci.h>
@@ -399,8 +400,10 @@ EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
  */
-static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+static int iommu_init_device(struct iommu_probe_info *pinf,
+			     const struct iommu_ops *ops)
 {
+	struct device *dev = pinf->dev;
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
@@ -413,7 +416,10 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		goto err_free;
 	}
 
-	iommu_dev = ops->probe_device(dev);
+	if (ops->probe_device_pinf)
+		iommu_dev = ops->probe_device_pinf(pinf);
+	else
+		iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
 		goto err_module_put;
@@ -496,8 +502,9 @@ static void iommu_deinit_device(struct device *dev)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
-static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
+static int __iommu_probe_device(struct iommu_probe_info *pinf)
 {
+	struct device *dev = pinf->dev;
 	const struct iommu_ops *ops;
 	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
@@ -533,7 +540,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (dev->iommu_group)
 		return 0;
 
-	ret = iommu_init_device(dev, ops);
+	ret = iommu_init_device(pinf, ops);
 	if (ret)
 		return ret;
 
@@ -557,7 +564,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
 		if (ret)
 			goto err_remove_gdev;
-	} else if (!group->default_domain && !group_list) {
+	} else if (!group->default_domain && !pinf->defer_setup) {
 		ret = iommu_setup_default_domain(group, 0);
 		if (ret)
 			goto err_remove_gdev;
@@ -568,7 +575,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		 * that need further setup.
 		 */
 		if (list_empty(&group->entry))
-			list_add_tail(&group->entry, group_list);
+			list_add_tail(&group->entry, pinf->deferred_group_list);
 	}
 	mutex_unlock(&group->mutex);
 
@@ -588,13 +595,14 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-int iommu_probe_device(struct device *dev)
+int iommu_probe_device_pinf(struct iommu_probe_info *pinf)
 {
+	struct device *dev = pinf->dev;
 	const struct iommu_ops *ops;
 	int ret;
 
 	mutex_lock(&iommu_probe_device_lock);
-	ret = __iommu_probe_device(dev, NULL);
+	ret = __iommu_probe_device(pinf);
 	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
 		return ret;
@@ -606,6 +614,13 @@ int iommu_probe_device(struct device *dev)
 	return 0;
 }
 
+int iommu_probe_device(struct device *dev)
+{
+	struct iommu_probe_info pinf = {.dev = dev};
+
+	return iommu_probe_device_pinf(&pinf);
+}
+
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev)
 {
@@ -1830,11 +1845,12 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 
 static int probe_iommu_group(struct device *dev, void *data)
 {
-	struct list_head *group_list = data;
+	struct iommu_probe_info *pinf = data;
 	int ret;
 
+	pinf->dev = dev;
 	mutex_lock(&iommu_probe_device_lock);
-	ret = __iommu_probe_device(dev, group_list);
+	ret = __iommu_probe_device(pinf);
 	mutex_unlock(&iommu_probe_device_lock);
 	if (ret == -ENODEV)
 		ret = 0;
@@ -1977,9 +1993,13 @@ int bus_iommu_probe(const struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
 	LIST_HEAD(group_list);
+	struct iommu_probe_info pinf = {
+		.deferred_group_list = &group_list,
+		.defer_setup = true,
+	};
 	int ret;
 
-	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
+	ret = bus_for_each_dev(bus, NULL, &pinf, probe_iommu_group);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 3d4580f1fbb378..fb743ddd239e0b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -7,6 +7,7 @@
 
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -139,6 +140,9 @@ static int of_iommu_for_each_id(struct device *dev,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
+	struct iommu_probe_info pinf = {
+		.dev = dev,
+	};
 	struct iommu_fwspec *fwspec;
 	int err;
 
@@ -167,7 +171,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 	if (err)
 		goto err_log;
 
-	err = iommu_probe_device(dev);
+	err = iommu_probe_device_pinf(&pinf);
 	if (err)
 		goto err_log;
 	return 0;
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
new file mode 100644
index 00000000000000..b85c9f15cf478b
--- /dev/null
+++ b/include/linux/iommu-driver.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES
+ *
+ * This file should ONLY be included by iommu drivers. These API
+ * calls are NOT to be used generally.
+ */
+#ifndef __LINUX_IOMMU_DRIVER_H
+#define __LINUX_IOMMU_DRIVER_H
+
+#ifndef CONFIG_IOMMU_API
+#error "CONFIG_IOMMU_API is not set, should this header be included?"
+#endif
+
+#include <linux/types.h>
+
+struct iommu_probe_info {
+	struct device *dev;
+	struct list_head *deferred_group_list;
+	bool defer_setup : 1;
+};
+
+int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
+
+#endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c24933a1d0d643..cf578b8e0b59a4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -43,6 +43,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct iommu_probe_info;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -347,6 +348,7 @@ static inline int __iommu_copy_struct_from_user(
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
  * @probe_device: Add device to iommu driver handling
+ * @probe_device_pinf: New API for probe_device
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
@@ -388,6 +390,7 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
+	struct iommu_device *(*probe_device_pinf)(struct iommu_probe_info *pinf);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
-- 
2.42.0


