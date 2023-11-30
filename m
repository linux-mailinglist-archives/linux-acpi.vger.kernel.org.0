Return-Path: <linux-acpi+bounces-1944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80137FE6B7
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBBF281078
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B2134A3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChwDYoAE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C8122;
	Wed, 29 Nov 2023 17:10:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny8U4BXRGrjsTjqBDBev9XGufVXNkkea80vTxOxuuAskL2MghKThfFf2Aylc3OJ0K0o0eKKyWJTe++DWtyA0oMauMb27O6fXZpAX1ToeEsv88hkVDDbT0xU/rjvcDiQ1Xsj84hSrUnlrSUAip8IiYRXSLcIAWe04l1FwSJG3Vz82cneGUL4DwlRJoa7JIjHdwvrqAdrMGbdUildZAcH9aBWuoEDg45UKTpd3VZH1cOzH1Kd0fau+SxxskPO2bPsangqmdfBVdID/aDYT8akKT/RwnNJwzuxw2z4i9VCitDsQr8NFPKp9nZbHnR8ym4xFeYcbmqyXHxx7VbxJuZUpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSoBvw6bu/xIaykTkLxhOIj0UNzTY38fiGKG2fa6Hhc=;
 b=g8NWH1EKqXATOdoLLEsykmZ/aR+i6jj5yPbcd731zAy2K5RaeGm580LMhImyW3Y+izpdgDXM2foFwi/obQ8/CRBX5brySchiOt/Uzf70di5XHmvknTfm1h/4V1bge8TF+VUZeMoEviyeqXV1ElcgmLPITjX7yWy4zBPdNipMRn+1NzvSKwTbfyQpQcdkL1YVlK/x7lpthPHs40t5QpMX5wQLTE6Kq+L101nZQap6+1AnvGq+m+A8Av6gM+0xt1jXxgkBSfEiGnk3rUWmDMhPXaUKbp+9T/b1egF6tTaQgPJ5EUnZN3aRm4yX9H9ZTh/VQ1wGCPgqz00QA8D/glvKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSoBvw6bu/xIaykTkLxhOIj0UNzTY38fiGKG2fa6Hhc=;
 b=ChwDYoAEExL5k8t7Bdhf33CtKVr5qwJwDio8HL3c0XNprZEp3Q1yQ+qcM+SMXYLQKR4kOFYjUglbOzDEAxJ1c9OkD6F3OdmD7Y49Fe0iXj803VoqMW+YOMCUinXXqZpadxtfnpg4gvW55ySDuE+bZGf4fMRdWQpf9UGoYeN3UX4km8gKm5A03QYql85TT3fJxaGgcjBpF6tl2vREqbFlNYemgi+ZulQ9nV6oJ23pDL7Lz9y31FLiax58ANYpLQuPkCgTkbgcxQ60i24zg+J2VngqUflaC5p5EBo7g82gK4hKSpJl+D65J9J/RRZjPeGnDaOjMIQNhzUhw3W5WxX6Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:38 +0000
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
Subject: [PATCH 14/30] iommu/exynos: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:10:21 -0400
Message-ID: <14-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9142ec-ed01-441c-9964-08dbf1412a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5/KQURr1SqdpVFCpIzQqkc3bWuhgfsoIg3eAY1j6KzGuEap6fFGi5AGHmNU7LaTrc8ikZlfTNDO4/6tkiP6kz0dA48rXEop51rHHDvEbvmaqVbDRzZBC+xX1vbVvlIFq9DGCFH2R3K9y9c2JeEFMxfKmeQUJ4RR0Dqb7haCjKshrSCpfYndyflzAjegs5lOZgpsT6rc0pz2+MrBo5B8H+YCQGI/W5cqmwhk9EsCavV1+RsNQj/wgb9DBKF4A8p2p89Wk1Yzh94hrGo8P5LfjVHuVlRwfNn/8Gyz6QecoSIXNpqvIzjnXQzw97mTLQfX86ahtoA8vmuy3T8aKX8Mp28Mo+j7Ibr9ZTbW1KPLiBvvivimiwcYUi5/uKnE78TJUfb+Dqwd0hckN+MHj2aeu0U8KKWXX1AF3zW92Zf53wGbTz0a7Nld6HE6SEorY5LP27EalIVRXZFc0ndOV/iMOWYILYDvqS6KVwGqMJr+v6gvoUqrbVxmFyZf/zbfz5bqT+G+5afwbD/vbt8A/enjn+tcA8t8bEGrF55nzKC77HIlB0WTbcqzMOW8za4Rpmf+5hPQNYcS7475CpPcRuZyqKCLKq9MkW1+h8AZ5LjLmtDmSWbyzncGOXyMisufSdO8FzJBcGFLaixh6AjLKCbwqCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZWXqKIWHWInPTY+5qeAm9OIgYb0NNVUk/pxR1RhzdMYjOc0c7+IJF9kBckD?=
 =?us-ascii?Q?cs+mO2DyRJaW4eGlY5tZhutxPasw0s+uhytnC9rxCV+IkM1HYawCjObohj8x?=
 =?us-ascii?Q?X6o+rgFCHVKv5n2oTvmcQ18En4+5r4Fg1QV9HAG2topLuHjPob9Bb3ZmAaEb?=
 =?us-ascii?Q?HLNEBdAshrm+/PFw5NFD8GkONmu/AwcgSpfEFw4kTZ7W4Ib6Vmq17RzJKuP9?=
 =?us-ascii?Q?Tsq+lyr9HN5AODI9cIiYK6R+xXDbEWKVLp6/Nim/Ckn7sR45c6Kvelqm77Y3?=
 =?us-ascii?Q?prexvCak7S7CfTalkcmXPuBzt0VpKVb10MFQP6VG63Rw8VFa9uJLKfEvq+dm?=
 =?us-ascii?Q?fsmQ1PVHCp7oQjuSH2j4yBGguPNqBCULOnQc+fRwU4PJpVWFwdc6B28DB6Ir?=
 =?us-ascii?Q?g1PfcLF4AEDguqs5Nhl8KIXzcBGwoBWjvPoB6C3cK7S6jIs6/UAv9mZ5U+AU?=
 =?us-ascii?Q?1AVm8CXPRp6FT4n/Coj2wGczYsm3EYFB4EtJ/1ZO3AXdaPqApw4q0Bg/zj6R?=
 =?us-ascii?Q?KXk5D2H0YjHPpGLwGl4Z2auJY4BUYc6ty191f0pwsNsyNb85ayIBLnmaNbRJ?=
 =?us-ascii?Q?bmAsX/YN8iwKvNthe7/xBcg/WRHfl+uEdBYgsw2gfeVme+Wo4VslXX4R1sAw?=
 =?us-ascii?Q?vUjCkz1XYAgjhMF3xSPGnnAyyKFCYcMaxN1vsAL6LBky1odhviPk6czL306l?=
 =?us-ascii?Q?Vwh0PczHsji3RUbOY9sHY9HplpQnerkbSQfh4cDi6BC269XpTyRM/eGnxjJx?=
 =?us-ascii?Q?jsQdTxYAfiYVn2BPHgBKCT/w52Dh+ZPqsMOAP15snJpE9/tglUGNPJ9rWQ1w?=
 =?us-ascii?Q?3HDdiKC/nNrFFFy1mCXG7i36+otWFqDIxuqgaaH2wqkhY8PhFIEDdncebRRa?=
 =?us-ascii?Q?sM2M1Ytu7jRd6T+QoGT8Oz76/0erqbepdr1wb3Vd6FIWanaFh/plBjgo5ApD?=
 =?us-ascii?Q?8tqQz069aKje7zNpB26Q3Loqietcd5jhv0tPrVFQKMHrYPEFXePWkam1UuGj?=
 =?us-ascii?Q?PxQNUce6Qw3rdntQfHO9D6aJ6UoJ0oDGRUCazUk5ssSULgaQnMcxMNa9blEP?=
 =?us-ascii?Q?7h5En91z+h9BqD6PAHgTaDzWbEI4EKFfpzQ7wpMs4+gXRQNP5mU/UejntI8a?=
 =?us-ascii?Q?C69vcgGAe1bJW+1X4TPm+gTUv8e1wdQwtwpRFEVb/5o5xwkYDCXejI5KFz8w?=
 =?us-ascii?Q?kxXdOS5XwhwBboBaQFKgJboIxCRDzzFba0I+xUSL5luxVpQKKXWu0Wk0f0cK?=
 =?us-ascii?Q?8ezxJMBSVNUMXYqOr5/LmBuo7jGEYVjYpbl3291YSTa1Qbjmq5VltJBc7RnZ?=
 =?us-ascii?Q?2vo/lS85YdXJ17tATnL4woIdI/4eXouROA2dRA1KC0qx0dKR3WQfcGJWU3q7?=
 =?us-ascii?Q?A1TFi+7NJ/ruq2bcUO0TsyBo/VLPqY7pj7mvo5IpnZdg/MEznO/zAL5wjwBM?=
 =?us-ascii?Q?vS0Ik0LB7C/ivAcsM2t0DDIJBhSxD75kdDCgtsSZcBFWZxUIQzRz4glq1loA?=
 =?us-ascii?Q?FxRk/Q+I27GJZW0CBp8GUOPnKBdKvyI+17nOpM/D8RfEo+/XjqfyI8US7Wbl?=
 =?us-ascii?Q?D+/iAwQ2KHPi9thiZZHWAZeMO/tYA5NTJt/QQV5p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9142ec-ed01-441c-9964-08dbf1412a25
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:38.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Deblvtu+OhvbUyusQHTkQo0j4X2I8nR8y/aO6w+mQBX6yk8ZVJSGI5i6Bge1KT4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

exynos allocates a per-device struct in the of_xlate() that can point to
multiple instances of the iommu. It looks like each iommu instance can
point to only one device however.

Move the allocation of the per-device struct to the top of probe and use
iommu_of_xlate() to fill in the linked list. Rely on the core code to
locate the iommu.

Solve a few issues:

 - A bus probe was failing by accident because the of_xlate not being
   called left a NULL owner in the priv, and other code tended to free the
   dev->iommu. iommu_of_xlate() will fail bus probe directly

 - Missing validation that the node in the iommus instance is actually
   pointing at this driver

 - Don't leak the owner. It is allocated during probe, freed on probe
   failure, and freed in release_device() on probe success. Previously it
   would allocate it in of_xlate and leak it in some possible error flows.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/exynos-iommu.c | 79 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2c6e9094f1e979..c301aa87fe0ff0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/interrupt.h>
 #include <linux/kmemleak.h>
 #include <linux/list.h>
@@ -26,6 +27,9 @@ typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 static struct iommu_domain exynos_identity_domain;
 
+static int exynos_iommu_of_xlate(struct iommu_device *iommu,
+				 struct of_phandle_args *args, void *priv);
+
 /* We do not consider super section mapping (16MB) */
 #define SECT_ORDER 20
 #define LPAGE_ORDER 16
@@ -168,8 +172,6 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V7_CAPA1		0x874
 #define REG_V7_CTRL_VM		0x8000
 
-#define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
-
 static struct device *dma_dev;
 static struct kmem_cache *lv2table_kmem_cache;
 static sysmmu_pte_t *zero_lv2_table;
@@ -779,8 +781,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, data);
-
 	if (PG_ENT_SHIFT < 0) {
 		if (MMU_MAJ_VER(data->version) < 5) {
 			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
@@ -1393,15 +1393,29 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	return phys;
 }
 
-static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+exynos_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
+	struct exynos_iommu_owner *owner;
+	struct device *dev = pinf->dev;
 	struct sysmmu_drvdata *data;
+	int ret;
 
-	if (!has_sysmmu(dev))
-		return ERR_PTR(-ENODEV);
+	owner = kzalloc(sizeof(*owner), GFP_KERNEL);
+	if (!owner)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&owner->controllers);
+	mutex_init(&owner->rpm_lock);
+	owner->domain = &exynos_identity_domain;
+
+	ret = iommu_of_xlate(pinf, &exynos_iommu_ops, -1,
+			     &exynos_iommu_of_xlate, owner);
+	if (ret)
+		goto err_free;
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
+		data->master = dev;
 		/*
 		 * SYSMMU will be runtime activated via device link
 		 * (dependency) to its master device, so there are no
@@ -1412,11 +1426,17 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 					     DL_FLAG_PM_RUNTIME);
 	}
 
-	/* There is always at least one entry, see exynos_iommu_of_xlate() */
+	/* iommu_of_xlate() fails if there are no entries */
 	data = list_first_entry(&owner->controllers,
 				struct sysmmu_drvdata, owner_node);
 
+	dev_iommu_priv_set(dev, owner);
+
 	return &data->iommu;
+
+err_free:
+	kfree(owner);
+	return ERR_PTR(ret);
 }
 
 static void exynos_iommu_release_device(struct device *dev)
@@ -1430,42 +1450,19 @@ static void exynos_iommu_release_device(struct device *dev)
 		device_link_del(data->link);
 }
 
-static int exynos_iommu_of_xlate(struct device *dev,
-				 struct of_phandle_args *spec)
+static int exynos_iommu_of_xlate(struct iommu_device *iommu,
+				 struct of_phandle_args *args, void *priv)
 {
-	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
-	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
-	struct sysmmu_drvdata *data, *entry;
-
-	if (!sysmmu)
-		return -ENODEV;
-
-	data = platform_get_drvdata(sysmmu);
-	if (!data) {
-		put_device(&sysmmu->dev);
-		return -ENODEV;
-	}
-
-	if (!owner) {
-		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
-		if (!owner) {
-			put_device(&sysmmu->dev);
-			return -ENOMEM;
-		}
-
-		INIT_LIST_HEAD(&owner->controllers);
-		mutex_init(&owner->rpm_lock);
-		owner->domain = &exynos_identity_domain;
-		dev_iommu_priv_set(dev, owner);
-	}
+	struct sysmmu_drvdata *data =
+		container_of(iommu, struct sysmmu_drvdata, iommu);
+	struct exynos_iommu_owner *owner = priv;
+	struct sysmmu_drvdata *entry;
 
+	/* FIXME this relies on iommu_probe_device_lock */
 	list_for_each_entry(entry, &owner->controllers, owner_node)
 		if (entry == data)
 			return 0;
-
 	list_add_tail(&data->owner_node, &owner->controllers);
-	data->master = dev;
-
 	return 0;
 }
 
@@ -1473,10 +1470,10 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.identity_domain = &exynos_identity_domain,
 	.domain_alloc_paging = exynos_iommu_domain_alloc_paging,
 	.device_group = generic_device_group,
-	.probe_device = exynos_iommu_probe_device,
+	.probe_device_pinf = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
-	.of_xlate = exynos_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
 		.map_pages	= exynos_iommu_map,
-- 
2.42.0


