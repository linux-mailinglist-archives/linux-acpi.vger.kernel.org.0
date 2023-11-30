Return-Path: <linux-acpi+bounces-1968-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BCE7FE6DC
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232BA1C2089C
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006512B97
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oa1cpIGp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66E10F2;
	Wed, 29 Nov 2023 17:11:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nktyx9JA0I562JHDUrqi82NUMQtWGrgvwLSQzncwN6YV5QgOtmkWjH32V5fbqYVzaqXUNxXlnjD/iOyVU5O1z27fMUqjbyo+uGrRpIwLHlvxcawZiD9SoAvUIhfJyyMzUy9EepVe5o4m/6NE91SjaKeDMWSLhpgzYE4k1nJKNqyjOVjIKja52WP2Uf4Bq4fU1kvXqXvHGVXwxtGGo4VzHQ0qOI0EWGTOLRBOSBHJhGEqEcgihIz/kI8D1MCl+pkTKCZkuJxDoO+JZ9VFO323V45ZLd7mNUaPGXf1HYKT1WzVU7FUMBa/KTf/t5nXauqQ4TgS2uWtKO8WSaTDwJmPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqEzauI1AR2owm9HEl6HCb3Z9hfFMw5b5rv0EaUHXus=;
 b=JCHEKOTANhMjHvs+0ng51OS4jbdBPM/IEbXBYMqDrukIeNSmK9r9qK4u0KHzi6hOJiBCD4xGjtytSWoj6r5ocpQzOINiSHrXH44HGnTDuFxewcBdXqSdgrgn9Ab/kLD/hQbVoBhiEhRyjZA2NZfKwCjYJ6vNnlf3eQqgS4rt8IaABw2YtuCoYua8pbN8/BwFXP4GkcO+EPeTWA5Ek4uP53VWF7F9gEOIrvXRNPvyIh4mOfRrJq8lHAkDAZXV5yCqmS/hlq/7v7v22x0QVK2i/4S4+3EfzatzfgKFGr/Q0uRM4mIy4+XhqbfxEzkC4db7DNYIT6Sb6PKH1/HTDrXceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqEzauI1AR2owm9HEl6HCb3Z9hfFMw5b5rv0EaUHXus=;
 b=Oa1cpIGpuG5KCyGfODKBcoVPfpSKDiQNs/TEM8nYLpi4p1XDMZCa8Lt60WtmTtaCwHhIVy5916fYZhmG+tCi664qOSfDc0mSySoCo2RQDZL+Hr97ZrwOvrJnGi0Qt/KU5dLUosuMreIY9+9oI+pS6aACy6IbcFXrvzPqixZ3fP1q8TjDxgvmLPwaOm5rxwXKeUO2HLd8cGlr1jWxSy/b1TKQfucIHuqsm5qc+Ju5k9W/fyUO1dUkqosnVzjUNc3WM41YX1IbB1ZbUItoSyfNGE8KZeIA03j4IBKeustVWXlU281J/T121S8Vq0sVmJ+TCs+FVE+fRLveQj7RMFGSDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:53 +0000
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
Subject: [PATCH 11/30] iommu/sun50i: Move to iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:10:18 -0400
Message-ID: <11-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 202f467c-ccd0-4067-7ecf-08dbf1412c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wDaTT+ItBQkwfzcOkVg2Mm6eY2SM6MzCUmBpSQHf6eTxjKudDQ3FJrLtC7843i5IRrcwn8Wp3kyfu6/Yh11FUDQgsLe09RbqFC9c2+iHarhPjCgkaI2RwUCtNnHyx1f2GX4soqsXrPW3tZjeHuhABq1xMhcgDnPvrLZmLnuXL2YUzE6qEmHYTRhSCwDecEzEQqk3k0mZwtI9954N7vcDEfs3+s9793mSLR4FCD88WcYY3N9tSP7mTocrA7xWY9eF6jrtozd+HQst/hJospZz6+END6XGVPatK4VBOXB+imY7adaFenJ0MD1QGaumMJitErYRDwzrgCZmy418ZXqH30+cb/9zNzH/WcPrjxVK6W3kB0g6I70noY3NnRRyoT+NB7EWk3sYMVTq8fa6KlOPD9Pdxw/aOkJBCKwhLrM7al2n1j/5h3LbnyhJv+auY8lm0VOMlHMs97bHEXNDGBCVdGQcdHjui/H76ko5oarfbYDoF1fWy3AMooL7COYFS0X0YRtuzPAU+5RhjGp++wmJmXcNTrW38ZWCR1NwdSydhfmm8OyAUTknpAzEaWoLPV75JG8gvtcRUxLH8XQmiu9vkE7ux9a9ykBt+G4RepwDKzVS2XNyaYMOAz4Zl7eop97FzmS+T70+iRR9y9s9Oo4HCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wWcuxQ+bqZ5gr7soEwznyBgBycyNZqXKcFDlwc7STj6auYzuzroGafPTSpiv?=
 =?us-ascii?Q?IwLxcXuyAoaQVLZ6IfPMCSvSqVvc+2/M0h6wJLXdgA9MQBYFSH+z/3Evzra7?=
 =?us-ascii?Q?w2Aqf3rzO82n4GtdJo5pb0Eq1lCLtr/+m0yPelra2eVek7ZBOxGFOrDvAsLk?=
 =?us-ascii?Q?89czFKtigbQw3ogWsAgRjTlhJsLudryGaq97tLfKg+GvnVP3aqsxJvMJGR1T?=
 =?us-ascii?Q?i7Ky2fr+8RoRNWeDguYNt7XHSrsnCzy4oGVUHJFPsaa4rmt51GZ6/BLrhv5o?=
 =?us-ascii?Q?+0/B37CBhFKeLNT6Y72w8hkl7sMZ1Qf+lpZOW0dSNxXnS/Fd7nLg0wfFe6Bg?=
 =?us-ascii?Q?FjUfo8grRg2Vik/WiqLn6mQnvMvWvkFac0l9Vww722EeE/Nm1W4+q/OEurTF?=
 =?us-ascii?Q?fwrw2qldfQL5up6pTVSGf1tH+6Ppx1DFeXBd93LkHUb6bCddqBslvFnev1Dh?=
 =?us-ascii?Q?Ic+t6rSPBiiM0wo8cXd+4mVrV582BsXOfvXucezKbMBNAc6qMH+SmEioDZSP?=
 =?us-ascii?Q?JbCRJTkiA1lb3hfhH6Lq/Zivt2j8DugFo7YyFOXu8/JZDd2sgUonx0LqVPmI?=
 =?us-ascii?Q?hxq6sC43aMFfoDNB4sB0VYfHE6ZcuEWDEszyrahpHYVlcSAPvL5VNHi1In/X?=
 =?us-ascii?Q?9EiFfaDGEGgVSo7++9gG0iuPro3R566N3C8ftrSJtrOmpbzTmRxeNfzAB5rn?=
 =?us-ascii?Q?hxyfwxaYxvAkFL1ST4d1+4FjfYWJEDiDNGRQ/AkgiRb5e93aPtRQ6eWAtFsl?=
 =?us-ascii?Q?9mTmtbcvc0WR2WJ95frA0979Zjmch18U7McnZ+4CthhaHY8uHBWuwq2/q2T/?=
 =?us-ascii?Q?CtdfxFtbjx/7zD6eAMoUQ0E+1klw9aFI4pTv8bsev37W24cWlQAD5ntr9Ixl?=
 =?us-ascii?Q?fEGWWe3Es1c1zpCWeMjmAKi/3Yz2dEk9DGKyjfuzzYdO/bIY8RcmvzfylpnH?=
 =?us-ascii?Q?KVsIqdSm863AKsFlR7UC93lbZsHYDepY3BZFmFVhYwdxDGp28dfW9luiELXO?=
 =?us-ascii?Q?a+j0ZyaMK3J/9/14i3VaH6sULWA1dZoqy0YJBAMgOpcKD9GZ63TzlLG1Z9s3?=
 =?us-ascii?Q?6cUvswWBuYOrUEtfaN69cnXinClrdVVr1nK13HJSIgpP1OkiIpGPr7PZo+Fa?=
 =?us-ascii?Q?xwU0wDIVJtl9slL8E1pDe3fnelSGlGSfuA8fvLNbnl5trv+hgofCTicScRgu?=
 =?us-ascii?Q?IIQvEV0XS/gCsnKj944zUANMLSugalmGuGAuLHTE5kCWQPI4BHaiShXbAemH?=
 =?us-ascii?Q?+QBVCNNWaFI+5YotCOVM3721IVlPIQWd25ANil9kSiX7IyXalWLP6O88+YoT?=
 =?us-ascii?Q?gbG6+mrUS0oQFffU+R9YXI62lfgmd9Uk1HzljQm4tn6nCCc/FmROrOo/Ueqz?=
 =?us-ascii?Q?6Im6pDAO7mPOQKT4ToaPakFOfgJEUVTe0n1CBZSHwzug5Qjmkc5dTRG+W5Tr?=
 =?us-ascii?Q?WQA/oa7bn6YYSV/Wr9iJSWVmGVVPAng+YHBcOpQJ4MYNTHNeBh6vumTi0y6m?=
 =?us-ascii?Q?dUtAD9KPgo3I0eBCtQpAwBP8EdehOjkdPFIOMX39FvxKwZjRaIKs9+alpM5i?=
 =?us-ascii?Q?W5h9pqHqgw2wb2g7IPGhxJ5hW1GLk/3ZOdArN+Vp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202f467c-ccd0-4067-7ecf-08dbf1412c4e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBIHLWUjNcLd7jknHW9Ss0txa1WTmqIItJzPMglQflJMXkc9yvM+62hk/Nml2vr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

sun50i uses a simple binding where a the OF iommus's can describe a single
iommu instrance with a single ID, reflecting the master, on it.

The driver ignores the ID from the OF, it looks like the instance can only
do a single translation as the entire thing is managed with
generic_single_device_group(). Since there is a single translation the ID
presumably doesn't matter.

Allocate a sun50i_iommu_device struct during probe to be like all the
other drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sun50i-iommu.c | 60 +++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 41484a5a399bb1..84038705cf657d 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/log2.h>
@@ -95,6 +96,8 @@
 
 #define SPAGE_SIZE			4096
 
+static const struct iommu_ops sun50i_iommu_ops;
+
 struct sun50i_iommu {
 	struct iommu_device iommu;
 
@@ -110,6 +113,10 @@ struct sun50i_iommu {
 	struct kmem_cache *pt_pool;
 };
 
+struct sun50i_iommu_device {
+	struct sun50i_iommu *iommu;
+};
+
 struct sun50i_iommu_domain {
 	struct iommu_domain domain;
 
@@ -128,11 +135,6 @@ static struct sun50i_iommu_domain *to_sun50i_domain(struct iommu_domain *domain)
 	return container_of(domain, struct sun50i_iommu_domain, domain);
 }
 
-static struct sun50i_iommu *sun50i_iommu_from_dev(struct device *dev)
-{
-	return dev_iommu_priv_get(dev);
-}
-
 static u32 iommu_read(struct sun50i_iommu *iommu, u32 offset)
 {
 	return readl(iommu->base + offset);
@@ -760,7 +762,8 @@ static void sun50i_iommu_detach_domain(struct sun50i_iommu *iommu,
 static int sun50i_iommu_identity_attach(struct iommu_domain *identity_domain,
 					struct device *dev)
 {
-	struct sun50i_iommu *iommu = dev_iommu_priv_get(dev);
+	struct sun50i_iommu_device *sdev = dev_iommu_priv_get(dev);
+	struct sun50i_iommu *iommu = sdev->iommu;
 	struct sun50i_iommu_domain *sun50i_domain;
 
 	dev_dbg(dev, "Detaching from IOMMU domain\n");
@@ -786,12 +789,9 @@ static struct iommu_domain sun50i_iommu_identity_domain = {
 static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct sun50i_iommu_device *sdev = dev_iommu_priv_get(dev);
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
-	struct sun50i_iommu *iommu;
-
-	iommu = sun50i_iommu_from_dev(dev);
-	if (!iommu)
-		return -ENODEV;
+	struct sun50i_iommu *iommu = sdev->iommu;
 
 	dev_dbg(dev, "Attaching to IOMMU domain\n");
 
@@ -807,26 +807,37 @@ static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 	return 0;
 }
 
-static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+sun50i_iommu_probe_device(struct iommu_probe_info *pinf)
 {
+	struct sun50i_iommu_device *sdev;
 	struct sun50i_iommu *iommu;
 
-	iommu = sun50i_iommu_from_dev(dev);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
+	iommu = iommu_of_get_single_iommu(pinf, &sun50i_iommu_ops, 1,
+					 struct sun50i_iommu, iommu);
+	if (IS_ERR(iommu))
+		return ERR_CAST(iommu);
 
+	/*
+	 * The ids are ignored because the all the devices are placed in a
+	 * single group and the core code will enforce the same translation for
+	 * all ids.
+	 */
+
+	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return ERR_PTR(-ENOMEM);
+	sdev->iommu = iommu;
+
+	dev_iommu_priv_set(pinf->dev, sdev);
 	return &iommu->iommu;
 }
 
-static int sun50i_iommu_of_xlate(struct device *dev,
-				 struct of_phandle_args *args)
+static void sun50i_iommu_release_device(struct device *dev)
 {
-	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
-	unsigned id = args->args[0];
+	struct sun50i_iommu_device *sdev = dev_iommu_priv_get(dev);
 
-	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
-
-	return iommu_fwspec_add_ids(dev, &id, 1);
+	kfree(sdev);
 }
 
 static const struct iommu_ops sun50i_iommu_ops = {
@@ -834,8 +845,9 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
 	.device_group	= generic_single_device_group,
 	.domain_alloc_paging = sun50i_iommu_domain_alloc_paging,
-	.of_xlate	= sun50i_iommu_of_xlate,
-	.probe_device	= sun50i_iommu_probe_device,
+	.of_xlate = iommu_dummy_of_xlate,
+	.probe_device_pinf	= sun50i_iommu_probe_device,
+	.release_device = sun50i_iommu_release_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sun50i_iommu_attach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
-- 
2.42.0


