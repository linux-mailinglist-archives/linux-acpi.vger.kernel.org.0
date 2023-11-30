Return-Path: <linux-acpi+bounces-1956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110A7FE6C5
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F891C209A9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345B1427F
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bt72uduo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75E10D7;
	Wed, 29 Nov 2023 17:10:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHviIIoeYGnFvTiRuP4hmMzCpBC1erusmHD//dURo3osiQ0nIWcAKYj9QktHk8QAD2528PE6Iaxr0rh9kusTlu3cBF8VFa59X3Wj42yihuiNCwpWbW6W130YmiWjCyJeiEqFYehK4RJ7VPUoYTybGq54JsezFl2Uy3GwyvtkZNSyDdbiSKVDmzka53QMJ/HpXaephtgKiHH984q/H4snhUys/o20JceuJuzLb6ulbknWu48dUiTjtbWWTtclouSu9sIPcmTtfVrVaRJAh9S3xE2L55WiruJhYGLJ+kXULIQAecnXF1hUTVNa/jnPxJrYmZh+SG10g8DQBH5V5Ly68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH0gW84gOXxliY71EzUBCEAqil4815K+q+c+KD8Jig0=;
 b=grpc2QHgqMoqmavTtArDjqOThLx6m0b+fwvSpt11L5rBUQ8m1b8/GVNTbYKtmE6mPpFengzd+x5wQdW9h6kVe11lj602EQ4Ob8e8FqHJTRiv+XBttyFoCRC0hvs2D4eH944nijo6/aY6SAUHdPXGDsd7fRpoBZ82QKHsS4dDNdtvMMkAsOKe17dj+j1cCXYmpZh/njJxZqoWaPq6OycqUQMq4BVt99lCuwu0wgmCgEvwul8HxYE2GFiGYXJWrgJ8W9ct+C/U3XLWARtDPQdnj/OU9On9inFcXVWWT+QTKR+FK2sRHC1WdzX7+Jgm1F8L25R+XspdXz+hJQiP2ZzsZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH0gW84gOXxliY71EzUBCEAqil4815K+q+c+KD8Jig0=;
 b=bt72uduozeMkhtIrVviUsicUctr6C6o5YJ0GvT3SQhYkQAZN+9Sz3IVs7fJ0MsiXt8wQ0+PGWpczdvbt92fHpO8F1JMaivnwyVFT5dGfxCHUNPPvL3tcQQjP4MIhuJvKKNLdPcxUtaHKUGbL4KJxSk1PKnBfD18lweBTSV2MSIzwmdLycn0lo9RagI5nHtZQB24eZzsnfYINr8I2YVMqhSnT8Ua36PUdIU7XZCtAnfcoikbWOSWPKEBNY2WC/dMR7nEqoXKOC1et/tsDB4zwGwSZ1kOdDIYf6LsGYruWtiwurhiyLOnKOBI+f4+XsgTlmErQrA/bnOnzpLkMYWLfaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:47 +0000
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
Subject: [PATCH 09/30] iommu/rockchip: Move to iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:10:16 -0400
Message-ID: <9-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7ed155-37f1-4855-5c7a-08dbf1412b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	umO1ddYmJzHiPe/jglh3QVymxKzgOl3MVjcBhSWQDjWMRKWR8HZVwrI79C7ISCJr9SqH/28vyXDldPiqHoxK4wjKpDqIRfITgrO1HNCUqi+cqE3NfriRJMPlCMD737cdyI2IywQiD2HW2l3RV06Axv5ENsUPcDtd7WeW+PRLqh0p4Nyj9tMR5O+U/kK3lfsVhijwxxPkdyxR6FByxCIN6XssDr1ncHGfbXl+fvaiyBwVQGWCYvzBcJ4EH3og85kOP6+YebkGlapaQNdMEWDR5fUine7h0o57M8K+ZTYLHBJN3tSlX0S5qlvIfQXBmptAjdqq76AXo+if7d1cXg/Vi1F2AmIRlwvgNEO/Vbxi/byaz9tfWho0USuyrmtjec0a8Cu6tbCRAOm/cBZRAgUaIrzgkA/iCyy9NtHqunAVHrE0XsEXfhUj8OzKPrY6z85T6BYeJJFyAeXTuzAUR2fMPieYLQDs2kqEjay3aW0cV3rgNDDdapLoHCY6UnDIJV9EUyOHbKNPHChT2S/rUdFuR7b0aTjrXaghzPn4wGtyUS8i6fKHUiy6ZDX4BoT8zGcKvjierkteLZ9f8wpmxqG49KIf1byjgxkK8cQD7QtFttKijq/LkAW6mjLVdhWMGOCW/6Jh6gpuEmpOpDGc8pOav6AnI+iJvTCV6sNT467zjMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RvweIR4IeBPVT59G+mnbsZU6UEVqLrPN3J6FlzJYjO7J+iz1H9Ah/TTZnpLV?=
 =?us-ascii?Q?bzzXdnsYfu73hOvVyIhyFFy2Y9iAVTmQOGBNtfiNqHatKLecwWkvRnGucJYl?=
 =?us-ascii?Q?6ayVdDsEhu6c09vb6JX0jl/6ylYdM5BnKZHVZMExj+31UkSpqyN2FuU5uT2X?=
 =?us-ascii?Q?r90Ueo0jXA2Z03kTEU8ch32Daa+DHzVEBQgRavFpjPYfxw5GRN2DMKctlHfm?=
 =?us-ascii?Q?DFTmqw1mRmxXrKmQxuow1xsXgnt6IVv2HLHLfEV6J5u1iWc3eX0RFwewgApD?=
 =?us-ascii?Q?ZKmbxceJxhnuc0WMwnkzRKtis8NmuvwPf0/iTYocY1FXnBQMmQZVDu1YYw0b?=
 =?us-ascii?Q?giWqcbhhxouju/phOCCPrif2M0x8xucKxsDN1fjHrSKbJIrsyfaPlYahaJAd?=
 =?us-ascii?Q?hgdvt0N+bbbSCcud2mG3QNAxEyZZiJ4aL184Yk4Zd88dgS6DA6T9o2uGWdhQ?=
 =?us-ascii?Q?LG/bOKomviLNB5exuz9DaGsBlXCQs7430xqlvDvrGsZ1/mQ1zoqyunFnNfny?=
 =?us-ascii?Q?8Kou2tXkB3/vYaQ4/qTYAVWVuWsF+QGKpktcPneGCR5n7RGeeB4xV1Yh1m4b?=
 =?us-ascii?Q?9hz5c23dJhHEA5a7RqEWhMMm2GNBSKL+tczXWR7OJYloObO47zOY3IBp+qWa?=
 =?us-ascii?Q?oIXXLAmE7e7yqh1h+lVJUgGWuF35ywfY+uhqb/44D8xTB/TnYBIE4yoeiq1A?=
 =?us-ascii?Q?jP9XQzew3lYb47TrHhWG7a57SHpabRxwdHJzlLFsCp6qWdS7TTjMYgp3Mb5T?=
 =?us-ascii?Q?iYlRclucUXccEh/OhDKbShwAgWkBcCO6R4OCxIwWsSdVhYtaUiBkwAoGZY1s?=
 =?us-ascii?Q?b0fD0Bq9TpDj7oyB4j6Nkm1uCcdbtCaz9GNCAOGCKHmogx610igV0IfQfp8u?=
 =?us-ascii?Q?knMZkaDo6EcP4BHPC0/jdpMfRNgvvgMwSyqAwJQj/v7JQXXQ1l19Fp8hOKI/?=
 =?us-ascii?Q?hYJMhq0+B3t4WbpGYuKWyrOEtTzE7hNq1vUJeLfVejwY710Xd4mb2UZrmrZy?=
 =?us-ascii?Q?L+e35o8YcnGMnCwakua1HE94aRpW0sTilCvXyoTZGMkFmJXMUvTF7YJ2nYBR?=
 =?us-ascii?Q?nzgeGrgcmaKpbL3tqtPt1HtwwNPnOyR7e1sFaip6WXk84n9Ci5NiYzdpKxo5?=
 =?us-ascii?Q?ycWSzfSmeVlfe7p+yaYLSWVmH5/0GKCH+Td3zX2OXiEc4yK0DBYRQNfPww5K?=
 =?us-ascii?Q?CYBUfMPTn+jTaGAjyXunmxpKxKVL8qkexOOVeEIOrp9RhbO0qRfnjH2yuZaE?=
 =?us-ascii?Q?L2Ex85uF1huZMYmdsAym1TA5/HArddMm8fheg5PcwfD23SIPODEvBaumCKG2?=
 =?us-ascii?Q?tTTFWcCdcCZ6B/BVKf0yXNzelhSF1EUIPbM3a1VaRWG1jK9wY12IIqkypXGc?=
 =?us-ascii?Q?sARUQ8cBzBvRpn3OnspuU7z4+nV0P7vklV94icGGoExM5hxz/RShanrOe5mU?=
 =?us-ascii?Q?Gc8dt1fPi/77DPNR8ksydGyBX/CSpVWg+KLHtR/u++VBpfPB95h/3vBI9iMb?=
 =?us-ascii?Q?swdR4273IB0fw9RKasdHtw+MqMsJjdI0idrWTtSQIdXIqD5yz+7fuL9Kptqe?=
 =?us-ascii?Q?cViBCNaE4iZQwJTPGd8D5aTKbWX3FPdzKxCVvKbl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7ed155-37f1-4855-5c7a-08dbf1412b4e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVtzl/qCMXCu7rm7n3eTwSdj/9QrQ5oeVSrwEHZuO+Yjour4vrdh6fDtSjtcF5io
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

rockchip supports a single iommu instance and does not support multiple
IDs.

Move the per-device allocation from rk_iommu_of_xlate() and completely
delete rk_iommu_of_xlate(). The iommu instance is obtained via
iommu_of_get_single_iommu().

Don't use devm to manage the lifetime of the per-device data, this just
results in memory leaking if there are probe error/retry paths. Use the
normal lifecycle with alloc in probe_device and free in release_device.

The comment about "virtual devices" seems out of date. With today's code
the core will not call attach_device/detach_device unless dev->iommu is
set and has an ops. This can only happen if probe_device was done. Remove
the checks.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/rockchip-iommu.c | 74 +++++++++++-----------------------
 1 file changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2685861c0a1262..4cff06a2a24f74 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mm.h>
@@ -123,6 +124,7 @@ struct rk_iommudata {
 static struct device *dma_dev;
 static const struct rk_iommu_ops *rk_ops;
 static struct iommu_domain rk_identity_domain;
+static const struct iommu_ops rk_iommu_ops;
 
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
 				  unsigned int count)
@@ -896,13 +898,6 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 	return unmap_size;
 }
 
-static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
-{
-	struct rk_iommudata *data = dev_iommu_priv_get(dev);
-
-	return data ? data->iommu : NULL;
-}
-
 /* Must be called with iommu powered on and attached */
 static void rk_iommu_disable(struct rk_iommu *iommu)
 {
@@ -958,16 +953,12 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
 				    struct device *dev)
 {
-	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev_iommu_priv_get(dev);
+	struct rk_iommu *iommu = data->iommu;
 	struct rk_iommu_domain *rk_domain;
 	unsigned long flags;
 	int ret;
 
-	/* Allow 'virtual devices' (eg drm) to detach from domain */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return -ENODEV;
-
 	rk_domain = to_rk_domain(iommu->domain);
 
 	dev_dbg(dev, "Detaching from iommu domain\n");
@@ -1003,19 +994,12 @@ static struct iommu_domain rk_identity_domain = {
 static int rk_iommu_attach_device(struct iommu_domain *domain,
 		struct device *dev)
 {
-	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev_iommu_priv_get(dev);
+	struct rk_iommu *iommu = data->iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
 	int ret;
 
-	/*
-	 * Allow 'virtual devices' (e.g., drm) to attach to domain.
-	 * Such a device does not belong to an iommu group.
-	 */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return 0;
-
 	dev_dbg(dev, "Attaching to iommu domain\n");
 
 	/* iommu already attached */
@@ -1115,20 +1099,30 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 	kfree(rk_domain);
 }
 
-static struct iommu_device *rk_iommu_probe_device(struct device *dev)
+static struct iommu_device *rk_iommu_probe_device(struct iommu_probe_info *pinf)
 {
+	struct device *dev = pinf->dev;
 	struct rk_iommudata *data;
 	struct rk_iommu *iommu;
 
-	data = dev_iommu_priv_get(dev);
-	if (!data)
-		return ERR_PTR(-ENODEV);
+	iommu = iommu_of_get_single_iommu(pinf, &rk_iommu_ops, -1,
+					  struct rk_iommu, iommu);
+	if (IS_ERR(iommu))
+		return ERR_CAST(iommu);
+	if (iommu_of_num_ids(pinf) != 1)
+		return ERR_PTR(-EINVAL);
 
-	iommu = rk_iommu_from_dev(dev);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+	data->iommu = iommu;
+	data->iommu->domain = &rk_identity_domain;
 
 	data->link = device_link_add(dev, iommu->dev,
 				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 
+	dev_iommu_priv_set(dev, data);
+
 	return &iommu->iommu;
 }
 
@@ -1137,37 +1131,17 @@ static void rk_iommu_release_device(struct device *dev)
 	struct rk_iommudata *data = dev_iommu_priv_get(dev);
 
 	device_link_del(data->link);
-}
-
-static int rk_iommu_of_xlate(struct device *dev,
-			     struct of_phandle_args *args)
-{
-	struct platform_device *iommu_dev;
-	struct rk_iommudata *data;
-
-	data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	iommu_dev = of_find_device_by_node(args->np);
-
-	data->iommu = platform_get_drvdata(iommu_dev);
-	data->iommu->domain = &rk_identity_domain;
-	dev_iommu_priv_set(dev, data);
-
-	platform_device_put(iommu_dev);
-
-	return 0;
+	kfree(data);
 }
 
 static const struct iommu_ops rk_iommu_ops = {
 	.identity_domain = &rk_identity_domain,
 	.domain_alloc_paging = rk_iommu_domain_alloc_paging,
-	.probe_device = rk_iommu_probe_device,
+	.probe_device_pinf = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,
 	.device_group = generic_single_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
-	.of_xlate = rk_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
-- 
2.42.0


