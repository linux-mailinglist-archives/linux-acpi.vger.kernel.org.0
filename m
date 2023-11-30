Return-Path: <linux-acpi+bounces-1971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B601A7FE6E5
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C90D281F62
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D24134A6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZh9rBNd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE5310D4;
	Wed, 29 Nov 2023 17:11:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6BT3mC8pRCBcmPjZ3m9iCDlon+xEbfYM9H/MaCfIqpQE85/2unDlBVYRWVf/ST9/1GwgebWWjkzqQH/woMWt6j10jM60GSrN8Tq+FEApFIsmJaOJdwGmooeaX+rQkF5yT9lL7WpfnknLLH2KRzTuAo2Zw3GzmI6RuyqupdOycJRHPIAf8qhpL5nVEnxAyDKInprLxLChYJocqMx7qkbcnUzr5J8QoJlZ5O4MjcrJogp02IcLWhU0/2KsxFPXMclaDszDdBLYt7zJCY45WSrTeWczncIB/y2rmEnc7f0VAc26GYdBL+amNDrEXkhUHr4B9xor00bvNMKnGIUe6t8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=472sQygPvvhZhJ8WiOO2/mkS7+2EbUYdhDQB/DwfKZ8=;
 b=P3nKEbUEmulvJPr08xzSdAYDQPXj14/iwWuLPobaQhTPJ8Z9NKqzbRyZaQYl8uyvjBOndSI1ZUElx8SxY1Zq4Fk5a2gIlH5fzNLM56RrQ1udYvrvihao3KmAWi6T7eRD6uEWGXwBc9I03FDj/dKA6xKvrbvHFv4VJeR6PHL2h/TXsFFLM/WSVyi+7jXbKWWr6AAXs25ZBg/VDC0z2Hg4GKT7lpyGOJFhRyruFAbrYWVLIcBLjkg5TAMCf7Bs6CKB1f0Y77QbatMUJvxnolCZWzFF8TLjbl7rTAfgTEnBQRq0Yo3ZjC1GpHTcbzH4NwdUlq4KzjxG2FleDoz9Rmk73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=472sQygPvvhZhJ8WiOO2/mkS7+2EbUYdhDQB/DwfKZ8=;
 b=FZh9rBNd9QOgiK1jfedV76ae5bGLRy62Sr0iclxKCTOlv8VIxQrF7CC8B8GJqd8QmytVZTjW6ghMXhqtp7/kbwMYER2lt298hf6GFlKngmTN/F58zVqrvCLAQf9GBZDEU7QWvCGZKnGjKgau2xA5L/docGUu9G9j/mZRQVu7gIumCUCFWKni8lCpV0mfqObwWhjgpOCzhJtelH6lT8Vpw8MWwj1a2xOZiCCSSrQIfdB3bAE+Gd0uPeAJBDftSAvfyAqCPqy5rNDsSMXQJ9jCAvbxd2lS6MBi86TpAMLMZc67Wcowgm++O+WEx9cYQ1vPWj/J4TkiWYKULJsihHVqew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:54 +0000
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
Subject: [PATCH 06/30] iommu: Make iommu_ops_from_fwnode() return the iommu_device
Date: Wed, 29 Nov 2023 21:10:13 -0400
Message-ID: <6-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4423ce-a64b-47d2-71cb-08dbf1412c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BKbzTr8Riy9oQOKVDyyb2L/xUi7wIbXVOt54dMcq2oA4OOhPzsuVXq/ML4UZ1oieEpabslKrnNdm4mb29lPIiJHhw9Qum6GWnTGFjXFWxk0p8vsS9iP11BY+juvk+oyeYloZoXUfdX0TtLYREekrEA5CwNXJ6qmy8wFKTN6Xl+YrDXV0bdjym5yGwQXthCTbujW6URtQ3lqrIoYUCWEXHQajFYSJkINTIRAD+kKGS7r7NzZWhzXDxwZEKjiojn1cov597uFk/bmjbW7Trr6eTtz+myasXaYknKFf0fnMZ8JMFgoEJcyVxFze+8MMG6BVTcESssecPYvVAT9AwhmZ4Waaj3N9wRuqxTYwUnJqnZXcH9Wxe1/ec2y8+naeGzwOGA28XN3bj1zklPC5ZDjxxPmVVkpMVLi0zU9w3W2bSQEwL1l4+QBfEb98LQxDrGCXIp6tohR+0E4klMZYpZ1Ue6hU84mG6nrPsCPvGUn0sB0GimqaORUs/Q+Zcem/iYSOEzABAZShmLoR0CfkE8DOoO2xD3k1qba1mPEwX7P5L1J6NeJ5MS/qb2H2xaF6+TbYc10vQPyGY4wRC8hZgfK249cCx5PZeSRIvdcRgoNYQUyPzAb9nXUlDOyRSsRD6VIOj8F0KkhmjC84czE1J4cSVJSUEJBSnIqSp/3wczJiQKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74u2vI5Qz9MrU+SN3zzghPjql7uGI9iK6HP0c1j9n+r9JMYrfqsjBtZnthyX?=
 =?us-ascii?Q?PmO70BLmE8n9538yYCoNcQYlwRtf5d4G0pLmTr0IWuQa0ZNDcuHbgnSoOPpO?=
 =?us-ascii?Q?BOX/3529vnMXbFe4piANMTQFVu1h7W8L/9VUz/iJUkeL0Mb7X3B7d1THD3nJ?=
 =?us-ascii?Q?IfqN5W7JA9M1EmBQhkxkRfWbXiDP+Jnzi+HmRnGWgY8kztv7p9YYTRgw9mok?=
 =?us-ascii?Q?03DX5+ZuhsUmX2UdamFrd0gcEH5Ka05YAJWMCPyIH6qSUBGQl39VZY+Ffluu?=
 =?us-ascii?Q?CXYrmz0HVsfqhjrGDJe7y+AUCBnaUUby4GBs4zev/2SKj24QLde4bNNCnJkd?=
 =?us-ascii?Q?uP34kIFuuNTQnx3oyXNJDd9t2dfE8SyGSUL3f5xxiPmH5XlMmQ/Ttpye9qpe?=
 =?us-ascii?Q?uwteWPR3fTxVMVE3xRGqaKHZukrBifaZaV7Tm9ZTOYOb29J28iNrqmmA4Twv?=
 =?us-ascii?Q?q7F2mEh0jpt00ZBmgC2i55fMa2sAYuFwEakoShrALQXV92g/92MnAQ3ND4ac?=
 =?us-ascii?Q?v7C/gxWucjCWhed6nAX14pl7Lxwv7uI52/Lxeb73fy8+41aOQUPsigkp8DIg?=
 =?us-ascii?Q?C+j/2pYVmss+JOY3xhA1AN33NGbM5N2t/AAI65DUUT9xUUcBI4CfPshRqCYZ?=
 =?us-ascii?Q?URugN0c0LVNWEoFncNG6MLib71UGMpxaM+7kxMbUzccE21OyTWCGlto7V+U8?=
 =?us-ascii?Q?x+lBbBNpg48WOGsgy18bp6OJXik6zmBN6HZ2rjAN96wYL7udAnNdtS78f3qX?=
 =?us-ascii?Q?tLzgCiS6pkVWi0exYXpUFAJvLmdZXP4qZMk8c8+Z80+aRyOOLFHUBSiHAA+h?=
 =?us-ascii?Q?0Uz4Vak9wiWUBJqseyNsMMfPUzwRiJbvZzb7KmL1Hz+n8SQormWGQ6msETCk?=
 =?us-ascii?Q?Wk7c8DTznTE5HE5rRZXiN9T9a8DhdVxHbOT4VEkf5GzxudDkXtz0L9fbDnYv?=
 =?us-ascii?Q?QkGDZ6uV/fSn/Z7QlrxXqpER9UCwHGLQxp5i2dcZ2Si/GPL6q2TSCm0DD0cA?=
 =?us-ascii?Q?WM53wq3OOeSF+O0HtGDUuvUbQMDrPeSWulCP+40/QwsD27HhlpGZi1bijb3Q?=
 =?us-ascii?Q?H4H4qjHt+o9WUotO7ddsVd0lBpi2QlsultTDuKAv2hi59yfl//DQ34g+/py9?=
 =?us-ascii?Q?d92e3CQVhGpzEdJ2AVDD4f/BOIreXihvEstkHLoHFf0Nk0uBrdZUTfENOruO?=
 =?us-ascii?Q?Exl6+n2Www1yeyfbyuAmFfuju/EdTgO4wIhAIwgkjQw7+i5gqS0qLJ3dsxG3?=
 =?us-ascii?Q?WYTjFx9lSUoguhhW/IUnVlyiccCwHReU52bQpgmWDktBph45yBAeVsu0+xA2?=
 =?us-ascii?Q?tb3eXXyr3mD6tj4VS2NjC016oRC7yyd2OxIDTuOPqUJxWAtZt/ZPDvR2vZTQ?=
 =?us-ascii?Q?M4XG8exvS9/q7FGjUjjE2iakt4lYXOpfcUA2w1VdneYJvNsCvySCmxpJZ0sc?=
 =?us-ascii?Q?SINf4QVXF+AxuWOiQWcFbGj0fqhekubkxne6raQ2Kso+tvHW+zxGp02/DCz3?=
 =?us-ascii?Q?fcvs69Ze1jkEaIyZmjIYWAFk1MOmzsZzEyMxIxBX/rqtmu7ZQ8ZhB6BuueIx?=
 =?us-ascii?Q?KOwOHXpS2LifUXGFHEDh/fmWfmzsvNzR42P5PwVq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4423ce-a64b-47d2-71cb-08dbf1412c62
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC7T+5CVvgnAF99X1JXCvOTjBqexX/mK5SnV2QcR9gngEP0DC2Z/kP6u/tx4iQwE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

Return the entire struct iommu_device instead of just the ops. Name
the changed function iommu_device_from_fwnode().

The iommu_device pointer is kept valid because this is always called
under the iommu_probe_device_lock.

If iommu_device is valid then ops is valid too, the module refcounting
is pointless. Remove it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c    | 12 +++++++-----
 drivers/acpi/viot.c          |  9 +++++----
 drivers/iommu/iommu.c        | 20 +++++++++++++-------
 drivers/iommu/of_iommu.c     | 16 ++++++----------
 include/linux/iommu-driver.h |  3 +++
 include/linux/iommu.h        |  7 -------
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 93e30f2f5004f0..798c0b344f4be8 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -797,6 +797,8 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
+#include <linux/iommu-driver.h>
+
 static void iort_rmr_free(struct device *dev,
 			  struct iommu_resv_region *region)
 {
@@ -1242,7 +1244,7 @@ static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
 			    void *info)
 {
 	struct device *dev = info;
-	const struct iommu_ops *ops;
+	struct iommu_device *iommu;
 	struct fwnode_handle *iort_fwnode;
 
 	if (!node)
@@ -1253,19 +1255,19 @@ static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
 		return -ENODEV;
 
 	/*
-	 * If the ops look-up fails, this means that either
+	 * If the iommu look-up fails, this means that either
 	 * the SMMU drivers have not been probed yet or that
 	 * the SMMU drivers are not built in the kernel;
 	 * Depending on whether the SMMU drivers are built-in
 	 * in the kernel or not, defer the IOMMU configuration
 	 * or just abort it.
 	 */
-	ops = iommu_ops_from_fwnode(iort_fwnode);
-	if (!ops)
+	iommu = iommu_device_from_fwnode(iort_fwnode);
+	if (!iommu)
 		return iort_iommu_driver_enabled(node->type) ?
 		       -EPROBE_DEFER : -ENODEV;
 
-	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, iommu->ops);
 }
 
 struct iort_pci_alias_info {
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 7ab35ef05c84e0..9780b1d477503e 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -21,6 +21,7 @@
 #include <linux/acpi_viot.h>
 #include <linux/fwnode.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -299,7 +300,7 @@ void __init acpi_viot_init(void)
 
 static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
 {
-	const struct iommu_ops *ops;
+	struct iommu_device *iommu;
 	struct device *dev = info;
 
 	if (!viommu)
@@ -309,12 +310,12 @@ static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
 	if (device_match_fwnode(dev, viommu->fwnode))
 		return -EINVAL;
 
-	ops = iommu_ops_from_fwnode(viommu->fwnode);
-	if (!ops)
+	iommu = iommu_device_from_fwnode(viommu->fwnode);
+	if (!iommu)
 		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
 			-EPROBE_DEFER : -ENODEV;
 
-	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, iommu->ops);
 }
 
 struct viot_pci_iommu_alias_info {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 76b245973cfafc..45e6543748fd46 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -520,13 +520,19 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	 * ops for probing, and thus cheekily co-opt the same mechanism.
 	 */
 	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec && fwspec->ops)
+	if (fwspec && fwspec->ops) {
 		ops = fwspec->ops;
-	else
-		ops = iommu_ops_from_fwnode(NULL);
+		if (!ops)
+			return -ENODEV;
+	} else {
+		struct iommu_device *iommu;
+
+		iommu = iommu_device_from_fwnode(NULL);
+		if (!iommu)
+			return -ENODEV;
+		ops = iommu->ops;
+	}
 
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -2997,7 +3003,7 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
+struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode)
 {
 	struct iommu_device *iommu;
 
@@ -3005,7 +3011,7 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 	list_for_each_entry(iommu, &iommu_device_list, list)
 		if (iommu->fwnode == fwnode)
-			return iommu->ops;
+			return iommu;
 	return NULL;
 }
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index fb743ddd239e0b..cf68cdebc9f318 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -21,16 +21,16 @@
 static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
 {
 	struct device *dev = info;
-	const struct iommu_ops *ops;
+	struct iommu_device *iommu;
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
 	int ret;
 
-	ops = iommu_ops_from_fwnode(fwnode);
-	if ((ops && !ops->of_xlate) ||
+	iommu = iommu_device_from_fwnode(fwnode);
+	if ((iommu && !iommu->ops->of_xlate) ||
 	    !of_device_is_available(iommu_spec->np))
 		return -ENODEV;
 
-	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
+	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, iommu->ops);
 	if (ret)
 		return ret;
 	/*
@@ -38,14 +38,10 @@ static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
 	 * IOMMU device we're waiting for, which will be useful if we ever get
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
-	if (!ops)
+	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
 
-	if (!try_module_get(ops->owner))
-		return -ENODEV;
-
-	ret = ops->of_xlate(dev, iommu_spec);
-	module_put(ops->owner);
+	ret = iommu->ops->of_xlate(dev, iommu_spec);
 	return ret;
 }
 
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index b85c9f15cf478b..636b5b5f18f76f 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -14,6 +14,8 @@
 
 #include <linux/types.h>
 
+struct fwnode_handle;
+
 struct iommu_probe_info {
 	struct device *dev;
 	struct list_head *deferred_group_list;
@@ -21,5 +23,6 @@ struct iommu_probe_info {
 };
 
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
+struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
 
 #endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cf578b8e0b59a4..f0aaf55db3c09b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -819,7 +819,6 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
@@ -1168,12 +1167,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
-static inline
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
-{
-	return NULL;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.42.0


