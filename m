Return-Path: <linux-acpi+bounces-1953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD17FE6C2
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE2B1C209B4
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF61426E
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9gOcnp5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4E122;
	Wed, 29 Nov 2023 17:10:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI/VfW3KtQ7EqonoVuReX+ki7gGguNa+xXtb9Ut0viJOYRFTE0+duS7jEYWql0dcE4npCFIWLnHvrUTN7aPDYgop4bkIJcIRnDZNFmQYUp1Y52UOq2WC6kqtrS14AFMTx0Wu2Yfa6oel7TeI/pA1YlgZ4JWipuRs8esiGAefWFpBPe8iqeMXiD566QpiJdLneosJhSC6oS0BdWvAAHC0lrduXJ4+FVcuQtr5ogyES7tj/iaM5ieDtr790OFqujmqN1aPuyO6TnGKL8nH/l0X/sn2CefqHsr7aCfIGKBJtsQxwIL7OdDMAG07poFKXakzuiwwDgvIBJzOsmggV9qhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq1FeEtZzTGLjMBeHZUc8BYLNkFyjkdrYErvAcq9nLo=;
 b=hXJDpoI5IYejF7WlvzmfI8OJDgrWDEKPwgs6t25gTIIcSDdoPfv8SOL+/03U3Ji5M5OirW6etXIorCtEXUTjSJZ89cALV8NQ0OxgZKQ/nxrcyGrrGT+1lGGELg33gZ2JWXMaDWMjRrvSHuRN9LAoze8l0zXR2dIzWSkvi/Veun258Wzg4bB3KMoUjGRk7vWoGXY2RLlRzOWg+cGOIfi/oPTLZueAt98/WrBHINfVj5ijMA8g9BwaKSleiaCkkj6Q5ftwAXMBkI9g3PfusOJ2pZSJdTONHKIqKkUsTpLKJa8tCnS+YWbGSX7Iso88hQGUI+GlYFmYDuhKu/0MD9u4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq1FeEtZzTGLjMBeHZUc8BYLNkFyjkdrYErvAcq9nLo=;
 b=U9gOcnp5oO9r8HAidfMReXIo1XzhUGE4o3PomWs81JGYy+IdSZhvYv/WNGyxFH4blWT3Self1X0hhgQSGUG+OKKKkp5Nsnl5XY52hvreHHTIsaBmgMW10jDV3nng2OcHf+aBaQYM79cd6P/PJydRHKDtmkck0+7ZJOb6UoqIwPOfrggdaMETncjk4a8m1biciL27uqK6oM/7InRjBZIQyyOb4Puwj8Ngmy6iGVvWR4p3QEzzVRrKfDDWOEbbKD6fYitkOFvBBY4PK6t/dOE66QAhFMbvqnCtIEYYObZQicwiOOiac3AcM35t1+rKvA2BuNSQrGhDdvK++rP3Y+sM3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:45 +0000
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
Subject: [PATCH 07/30] iommu/of: Call of_iommu_get_resv_regions() directly
Date: Wed, 29 Nov 2023 21:10:14 -0400
Message-ID: <7-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:805:ca::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee7532c-6dfb-446f-5483-08dbf1412b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AXq8fYjKL9dbUcjYCNOjj6vXNKTeHyIkdK3aYWhZRReP7duFWnnmKNml6DIQ3iXQdULihAb8beV9w87+ZjSgyINMih1g6nxrYlXjhGPRliw+P0OVZfpxSrlbZ9b4bXTy+/fQUvMmKjJs0QR1mGa0Mi/uH4+qtxtCYAFpb6rAo8Ykmr6iMtNWCaxqvdf23kd/qMC+qBCyIcsM0XgZX6MiJewSCtD5On6icq0rbww/09ITksupiU4gcRflF7D/M9+P8rX+1Jg0JA1KntvOgWAqnOXxjgeMXWIUs/6YfuJulTteCoRI3IAYxsYzoPCjB5/f/Lhy7PktnkCt9qklrxdY1cWemj8rza3BGBUQIzDy2/PZ2of0uTz5UVttSOLxuEtOI1DJLf/4M/eoSEKE+uiclHfvcy7n9VLu36H7QIn55EHPKHuC5VNYWG8DZHm0FMIjae8prmiVzk7JsX01zQNy4Wgzz6jktyvGFrFO8ZSgiQDiXRxZmDD3hPHGCHkmrKqCpnCq+L6skUBinHblKdZlNbkCPsBHT7zDPA9JurwEaXhF3UN4p9box/3W40/MohsatznS6LEnkkMWZQEdb/P4SDNV81PCmDbpLVEaetFdiouvz5z+B81q+HUuksVovxIqoAWc9vU4UkhNNRHdBEKSPo9fmUHQpAgD6rbsoFAOKBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sgcxk6+KWDiWJ1iVCXCRH2MvIRgNTbyE9s38/862qwL+JO52WQtuzdHDyDP6?=
 =?us-ascii?Q?Zl23hu6xcOMNnpAD6AeoJb8ABv85I6oOuTONfpSorlCSC4+A3OTo++lSYKno?=
 =?us-ascii?Q?tWk8LKznWCs+VCOOMSTc3DsBxVD+O4Nj678xlujskfBtMhw4emeHQWpdCK3f?=
 =?us-ascii?Q?J0AcnNMVohiyIO1OvTTatWlMhMzAXGqyuGiMRSoOCnZiXPHKAMXZ7KPQ1YDB?=
 =?us-ascii?Q?LkpjuzqKTeyMymZNbDmv0Dc0h9/LMO4ZmnDxiUYC7CrRPJlKUxV3qFBVLDJO?=
 =?us-ascii?Q?ooZLOcfVvrffnSoZxYI54uQbm3go20oRbRqtOFhXSXvEluSXrjH37ymBBo3y?=
 =?us-ascii?Q?kZdFrb6lcADSEIFFpzmY3xZWLbNbpFPj18rV8Eajlb8vVvxohNqrB4hv2Sa3?=
 =?us-ascii?Q?r8/ej6mseXYltoasEDmAtnuFfU45cq9pO+tdLxQ5/bDmvDSOej4YHEXknA3j?=
 =?us-ascii?Q?pIR88JlAkBOJaKz7B7lJWKnghK3mPcDjrtz4EM4PvGhE3wX8Rpbj+kCO3G3z?=
 =?us-ascii?Q?z5Zll+SvSA/o2aSXiMxQFuEZB5KX/lrzeRNwwSHxdEGmz5YG7gtWBGo5fkn8?=
 =?us-ascii?Q?xlTPL22ZOli14Vetv0tfOnthMdT7Wn1Pao8nIfzoM0Qtist+WInbf8R3kdCv?=
 =?us-ascii?Q?VlguomoP39U7E7vKv4jeUOSt7W0lRqzZGHgCNQXIORP5eiGU9uBLC96FOSkh?=
 =?us-ascii?Q?L9AWGLPoJw/zzwxF+pgzO1EBfboyD3EdzTiipRIqYJgxBio+rEgkq6zbWgmQ?=
 =?us-ascii?Q?GBjggbNovwbRq63P0akscaWtJLLkUmNLRIFJGIE4gIICFmRtW/DvqeARYHD1?=
 =?us-ascii?Q?1/zvpmJWWO3HRxqBK/yi4uMypz27G5iru6SWZMB2ZR6GFb93Nhfkneo+n6EO?=
 =?us-ascii?Q?tIiQzAyxcEQ7Nm0a8x7pw8GkrWatHpeHanWXh1qWG5MlkvuEKUnODfEMiZRV?=
 =?us-ascii?Q?Shu1wUeEYj/VSGP46lCid53edsmrCRDk+LHSmRBXVRuredzOJT8AfmVdVu51?=
 =?us-ascii?Q?0f7RmaxWmO/7oTnrb4cYxZw2OoYm0ABcV22bOTCz2g2Fd/ftOdg+PAOCZHhM?=
 =?us-ascii?Q?TgCD2jhEd5mxklOH2B6ExfyJ1IpleHfqjblcdSvB5GLdgK6MDX0AzUGKXs7V?=
 =?us-ascii?Q?En1zyaLzYB1huCk0PzjdYlgYmQB2TzHZnSMkgqX82AcK55rJd1+jtbiKT8Hq?=
 =?us-ascii?Q?yT/5F2WLTr1opNmE9n8K7hPBtYoDG/dJvSGgW0vB2eTYiO+lLYQpFdAuqBBa?=
 =?us-ascii?Q?LHM35fJnSy6dhu9G7vwlVS1NAcLSO6+BuAGNPv7bCNDdd4JYlzTu35yOVEAh?=
 =?us-ascii?Q?B2b0KUgfeR1YZXOydzgINyRE/5mFvscLV9NLfCx+M5zZj/Ss9SD4aml84nez?=
 =?us-ascii?Q?mW2C3b2DulvhOZLXJk/WOl3xvdaI/w/Z3hUHWEAPc/5d/xAGeHWmhyv/jCpB?=
 =?us-ascii?Q?O/PJQ8dPHoY2X8MUdTcwtIMGUDjZGZxzYZiEWyVu/zmT3wuqWlJ4HcpSRJg+?=
 =?us-ascii?Q?leGwXr4pCsPSGdEjP/QZR9J2sfF9+RHK4JW8xYK1QqLBY2kACjCPR+2musJ5?=
 =?us-ascii?Q?flnEMi5E2hIIARDdyspoeiJBFhBxr1THoK4UJQqv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee7532c-6dfb-446f-5483-08dbf1412b1f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2/HhoRl557r94rBEGYCPMXl6Q2MU3jnXM/7ruIL9f7tTdYCOp+PY6ONSjmnGbxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

virtio-iommu and dart already parse the ACPI firmware description in their
own get_resv_regions() callback. They just need to parse the OF
description.

The generic iommu_dma_get_resv_regions() really just knows how to parse
the IORT ACPI in addition to OF.

Directly call of_iommu_get_resv_regions() instead.

Move the declaration of of_iommu_get_resv_regions() to iommu-driver.h
since it is now intended to be called by drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/apple-dart.c   | 5 ++---
 drivers/iommu/dma-iommu.c    | 5 ++---
 drivers/iommu/of_iommu.c     | 3 +++
 drivers/iommu/virtio-iommu.c | 5 ++---
 include/linux/iommu-driver.h | 9 +++++++++
 include/linux/of_iommu.h     | 8 --------
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 25135440b5dd54..bb0e5a4577fc03 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -32,8 +33,6 @@
 #include <linux/swab.h>
 #include <linux/types.h>
 
-#include "dma-iommu.h"
-
 #define DART_MAX_STREAMS 256
 #define DART_MAX_TTBR 4
 #define MAX_DARTS_PER_DEVICE 2
@@ -972,7 +971,7 @@ static void apple_dart_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, head);
 	}
 
-	iommu_dma_get_resv_regions(dev, head);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static const struct iommu_ops apple_dart_iommu_ops = {
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d644b0502ef48e..5a828c92cd38b2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -23,7 +23,7 @@
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
-#include <linux/of_iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -475,8 +475,7 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 					    fwspec->ids, fwspec->num_ids);
 	}
 
-	if (dev->of_node)
-		of_iommu_get_resv_regions(dev, list);
+	of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index cf68cdebc9f318..20266a8edd5c71 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -217,6 +217,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 	struct of_phandle_iterator it;
 	int err;
 
+	if (!dev->of_node)
+		return;
+
 	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
 		const __be32 *maps, *end;
 		struct resource phys;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 34db37fd9675cd..b1a7b14a6c7a2f 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -12,6 +12,7 @@
 #include <linux/freezer.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -22,8 +23,6 @@
 
 #include <uapi/linux/virtio_iommu.h>
 
-#include "dma-iommu.h"
-
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
@@ -969,7 +968,7 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 		list_add_tail(&msi->list, head);
 	}
 
-	iommu_dma_get_resv_regions(dev, head);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static struct iommu_ops viommu_ops;
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 636b5b5f18f76f..c572620d3069b4 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -25,4 +25,13 @@ struct iommu_probe_info {
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
 struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
 
+#if IS_ENABLED(CONFIG_OF_IOMMU)
+void of_iommu_get_resv_regions(struct device *dev, struct list_head *list);
+#else
+static inline void of_iommu_get_resv_regions(struct device *dev,
+					     struct list_head *list)
+{
+}
+#endif
+
 #endif
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index e61cbbe12dac6f..9d5532f2f11486 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -11,9 +11,6 @@ struct iommu_ops;
 extern int of_iommu_configure(struct device *dev, struct device_node *master_np,
 			      const u32 *id);
 
-extern void of_iommu_get_resv_regions(struct device *dev,
-				      struct list_head *list);
-
 #else
 
 static inline int of_iommu_configure(struct device *dev,
@@ -23,11 +20,6 @@ static inline int of_iommu_configure(struct device *dev,
 	return -ENODEV;
 }
 
-static inline void of_iommu_get_resv_regions(struct device *dev,
-					     struct list_head *list)
-{
-}
-
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
2.42.0


