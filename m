Return-Path: <linux-acpi+bounces-1967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC37FE6DB
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFAE1C20844
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BB1427A
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wx9x3nJa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F82D7D;
	Wed, 29 Nov 2023 17:10:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7rGNXqgfgJjOqkjeCl5vt8LOlzcnalB8wxI9aoARl8eDPSibutQvyYDlog0AQE6mFGfB7kX++7/xB3VUzvvqLKMrQ81dbYuTKX4C+WvM6muGLg9n4GrxvmO+dHsGO8sWHdBK1E61HsktgrXvXqWiXW0k2Y2tpM8Hhfnl7pBm2/61LjsYXpUacPFpPVryv8vJD6s6ZyT3RoJB5ulq/sqmwCxwoVWQXb1M+ecduObSVgDInhYdZaw1gy+prqfoksNntCI+hzp0VTwpVfZO8Pz0crjV9x0cNtPgDJMVcdjX0DtOIzQmWEJS7ISc67os3cSMsUsh5C1+QR4yY5fcALikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVfjFiF2fSnhxlRRXNND7TRJRH/U77+j8K1B2oK4udg=;
 b=N8afihFThkQHF/yPelNoYXCtPKglsc0j9IOqlPwEwv6Wdy12wD7uOafgFseIpWxSgdx5UIh3eK+sXRlTjLo89IDw9bOIQNlivAPMa7hHnyOWWp+T3BMRzo6kGEK29RmPvrUPXPWLpN+EJ0tYnzAH6ovEA8gVRQY3v6URtw6ADnneW2EGcb8Ji5IEotkOKWOZtV1qmm5dGCrsCH3ky+adQizejpimiC6jFsnzTAwfRVmjxGkg3azOGrj3eHQVwuZMFHR5GmpryKEiT1Ib87N49o1lUmeWyElLgglO8gDxVO1v8xRQ2zWo+FrdsJlQudbVyLYqdrN3DZ+0z76BmmA0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVfjFiF2fSnhxlRRXNND7TRJRH/U77+j8K1B2oK4udg=;
 b=Wx9x3nJaMbXLoBI9ECOgZcWNcQf3038G8tZS+Bv14TMC6WUj91zZwf3Np4/wo5QbwYz/O+KAMH5Rs8VxlSfvF68u21D+UK9CDHxr+UFi5plsj0Qdrc20n0KvO2G58O0fIPWjrrhEuJYpzIx6gqnHUfzQZBDTa3quI9jDScrNGaleZed3IDMbZAfI0stv++qjLPlWjM+R3a3fxadrlPLExaQ/QkG39mUoPzn6BT7xHNk4Tbat/6h+cXv2JXEnuyDkVHKrXkFkQOeGiDuJ46F4ZwhsAnVB61jF0llpsL6MxWIj+4hDsNYVpIVUTlJUN6fUt1HteQHbZJ4n/4b+29mw2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:49 +0000
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
Subject: [PATCH 27/30] iommu/arm-smmu: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:10:34 -0400
Message-ID: <27-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0134.namprd11.prod.outlook.com
 (2603:10b6:806:131::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 1945286a-540d-467a-13b8-08dbf1412b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EumLFNss2oLG+ZZ7Q+mKLqv4ZGj0yVj9O/upQk/owSSUhlz3VSWsuwREjDOKrBnJSIznAUAohZ1rW24i/r7BrhiwT5IQEJU4leyHBAY76r/gSf4agwa1F6Xzl75N1+fe1tji408/9ARGF1X58a0+9Wz0skI8yZ61+rQ4RG3QsKRIZW/64Jf7ULYONCH35k4LbXqJNadw5eErtN7MS3TDTR3uR8KwYifp7Pvfkm9cfxDMy8LVBlBntpWKGNLGRSSysg+RJhy2ivjUzUwpzgofP34+X55tN8kGBqLHyx+qgRsUh7CAhi7RGjjR3FLirL5uQjafX7PGn4iYljPQuHHgH0PHvZQLUyhj3gGTkwKn3WDlbENSAubjUGf5oi0Dpzi9X1OPnmvXl5pmPXuyhyLLUU2qe0bhRMFc5WurQARipcUkEqepNZZDR8jbdAQuXrAB5GlerYfHHOgPGHY/d6NDPdy73RU2/5YolxcfqBeEpSLtBdtSSW1K9BV2uGk576iU+TgqTBO4IUuIKJgm5AvRctYQfv8O2Az+hwxykdZ607Svk4KKPPLwbs2EU8OX4haJp1ZHngT8QuanCKHDso0vUrRCZWugdtQLc1WlevTIDusAUJEjfSwW9pUrS8lalefeQIOYqqlyWUxMcoqR32gOjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(30864003)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCXf/pNZ30FYKhzYGjHjkttr2gWAu7MD+zXo8kgVAXwbMxu0AkG7T+IuUc5X?=
 =?us-ascii?Q?wvhsztfwB/5ViLSeblTHvCx4pQ5FK8ihS41h0k2u174nQO3b/hGwAxGRbHMH?=
 =?us-ascii?Q?nLlJAWRoRCAo5gPaycxweFMRZfcBJgu0/SLBYO3TxRXSF5G86XZRwAPKpbK5?=
 =?us-ascii?Q?JemKZDrO6rjA59/OQnfSc9WBWmv4Vz965WOhXwXmGVmXpCrOHDa3tzD0ZMjF?=
 =?us-ascii?Q?pn/SU4xaY2yq01Gh03P6V4uK+9BmPbxTQhurM/FU/5rlqQ3nBwpyJOOJFm6p?=
 =?us-ascii?Q?a90aFbciEsWZQZSdom+9vRnJUGv/y5/njWSr9wA4oZd3vLJXhJ+pDEVDetth?=
 =?us-ascii?Q?SmFhZtP0iLZDZEIh5KsL6Bswd83yXYpnQ8oIbyYAad6Vjo9ohBp43CYIXWFk?=
 =?us-ascii?Q?S3057j2KcV0nBqbi0Sj1q/QwpPSsik05Mxp94zAoWMD5IJy54OAv4+B4kH5V?=
 =?us-ascii?Q?oU6I0baKToh+MhLe07uVuyykLafe4TSbBmXhsi/vCNVRXmdXATe25orAd4Lx?=
 =?us-ascii?Q?K/KT0K+3XJ9+r02sXYT4FGfzGnScQgfC/+QiA8ns7LTVDDmjkMIwPLWnRO6X?=
 =?us-ascii?Q?+n5+WlAkar2LKoVj7wUNYspkpEqevxGLNUgAaHJ75Zde7Kjz2PNPozgpx5NX?=
 =?us-ascii?Q?3KAjkpXb+eq1VQQwvQ5iGRslUjwbc9AFD+pfyj7ut4unHObz3Qf1RaTV6huk?=
 =?us-ascii?Q?3qj9eaRWr2f2lw66x2O1C4w/CwzF1+iiEy8lPSws1Clk3t98xq9eS0d8Cgt/?=
 =?us-ascii?Q?WGQMxHIRWiVeO/VO4CR6jFrt/HlesXxjvf86FfsE+lCPKR+gCbwx8rSJ92w6?=
 =?us-ascii?Q?FfGncLvW9Y5yj8d/Wd7hCnFLFYUIPnIWRcIbYhwls6XvBmhJ2ZFVceHS/0p5?=
 =?us-ascii?Q?azngLEsuy0iI7ho+UWYtWj/MO30sH4NE/u5q4HvVuPDl5BIiwLb/fRpalHX/?=
 =?us-ascii?Q?pKgbWQPEQfRoBs0sLq6roVCNIJSSXg06UI93CaQ8+ciYVs89p/y42E8yQ/LU?=
 =?us-ascii?Q?9eyBZN2uH60kuE31ZKF66fisjexMfOAAeHoviFNp66eLF5ZKIYEzR6DpQdgy?=
 =?us-ascii?Q?DxbTP8Ca5khrTwnveY/S2fMF0hs8y25bH8v9jTXMn8aIyaZFD60HOZtDH2x9?=
 =?us-ascii?Q?1g0b9kFAa/rZQK8vCwSdL9YjKOybEXUV284iVclkEMfK+SYpXCRYz+AviWE3?=
 =?us-ascii?Q?6KQGJC744OUjZmR6EHniFlZ+1mDOKVDdzJFYQmgc2GJEBBaH6uWyHoLyDIHo?=
 =?us-ascii?Q?AQbS6Xceugqf7RpwdDSTfE3fV7jqWhkLUZ+fI+39CqY/Ze3xcXq2hUemvezE?=
 =?us-ascii?Q?wdaqI2LwWgEAQwpxF0d09JcMVMkxRUj6tOaLEcUkbRbK+80nPtiuTaMhbYOA?=
 =?us-ascii?Q?3Q5+cpZ4+PAcon79jNK7gGcobCLqFGqaNxAoLjN3kEAepxCB3WV48BkcWQfT?=
 =?us-ascii?Q?AnmuWCONOC8Q7DAwTTshP6WcbeABaAILmuRc33A4UfmMOTJX7ciG8TL2zf96?=
 =?us-ascii?Q?k3DgcIOM0kQvB0KSLoumWNaAdEMv2KtBcQqYeacUwBoK/r2EpkbJPAlBg4Fl?=
 =?us-ascii?Q?2Jv9RUJgYmqhM0Y3uvSfrlwnZA/A0NGPTQ5XYadc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1945286a-540d-467a-13b8-08dbf1412b80
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:41.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqfUjf6+JZKBQgp7fJUPNnUzaw3I+ZlleFlAmAzIN1Rhie2ZJ4umh5si9CV3mlsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

Compared to every other driver SMMU supports a lot of different formats
for it's firmware description:

 - The legacy OF mmu-masters with a 1 cell id
 - The OF iommus with a 1 cell id
 - The OF iommus with a 2 cell id
 - The OF iommus with a 1 cell id and stream-match-mask
 - ACPI with a 1 cell id

They all get reduced down to a single array of u32 ids in the driver.

Store the id array as a flex array in the arm_smmu_master_cfg, and change
the smendx to an allocated array. This allows using the
iommu_fw_alloc_per_device_ids() path for ACPI.

Have the legacy flow just allocate the cfg of the proper size and copy the
cells into the ids.

The OF and ACPI flows all call iommu_iort_get_single_iommu(). ACPI will
use iommu_fw_alloc_per_device_ids().

The remaining OF flows will make another pass using iommu_of_xlate() to
parse the complex details and format the IDs list.

Remove fwspec from the other places in the driver.

Directly call iort_iommu_get_resv_regions() and pass in the internal id
array instead of getting it from the fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 205 +++++++++++----------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  13 +-
 3 files changed, 118 insertions(+), 106 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a681..95199de33ca865 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -101,15 +101,15 @@ static void qcom_adreno_smmu_resume_translation(const void *cookie, bool termina
 
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	int i;
 
 	/*
 	 * The GPU will always use SID 0 so that is a handy way to uniquely
 	 * identify it and configure it for per-instance pagetables
 	 */
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
+	for (i = 0; i < cfg->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, cfg->ids[i]);
 
 		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
 			return true;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 02b8dc4f366aa9..f18d40532af433 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -34,11 +34,11 @@
 #include <linux/pm_runtime.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/iommu-driver.h>
 
 #include <linux/fsl/mc.h>
 
 #include "arm-smmu.h"
-#include "../../dma-iommu.h"
 
 /*
  * Apparently, some Qualcomm arm64 platforms which appear to expose their SMMU
@@ -89,6 +89,8 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 
 static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
+static int arm_smmu_of_xlate(struct iommu_device *iommu,
+			     struct of_phandle_args *args, void *priv);
 
 #ifdef CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS
 static struct device_node *dev_get_dev_node(struct device *dev)
@@ -126,21 +128,21 @@ static int __find_legacy_master_phandle(struct device *dev, void *data)
 	return err == -ENOENT ? 0 : err;
 }
 
-static int arm_smmu_register_legacy_master(struct device *dev,
-					   struct arm_smmu_device **smmu)
+static struct arm_smmu_master_cfg *
+arm_smmu_register_legacy_master(struct device *dev)
 {
+	struct arm_smmu_master_cfg *cfg;
 	struct device *smmu_dev;
 	struct device_node *np;
 	struct of_phandle_iterator it;
 	void *data = &it;
-	u32 *sids;
 	__be32 pci_sid;
 	int err;
 
 	np = dev_get_dev_node(dev);
 	if (!np || !of_property_present(np, "#stream-id-cells")) {
 		of_node_put(np);
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	it.node = np;
@@ -149,9 +151,9 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	smmu_dev = data;
 	of_node_put(np);
 	if (err == 0)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	if (err < 0)
-		return err;
+		return ERR_PTR(err);
 
 	if (dev_is_pci(dev)) {
 		/* "mmu-masters" assumes Stream ID == Requester ID */
@@ -161,26 +163,20 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 		it.cur_count = 1;
 	}
 
-	err = iommu_fwspec_init(dev, &smmu_dev->of_node->fwnode,
-				&arm_smmu_ops);
-	if (err)
-		return err;
+	cfg = kzalloc(struct_size(cfg, ids, it.cur_count), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
 
-	sids = kcalloc(it.cur_count, sizeof(*sids), GFP_KERNEL);
-	if (!sids)
-		return -ENOMEM;
-
-	*smmu = dev_get_drvdata(smmu_dev);
-	of_phandle_iterator_args(&it, sids, it.cur_count);
-	err = iommu_fwspec_add_ids(dev, sids, it.cur_count);
-	kfree(sids);
-	return err;
+	cfg->num_ids = it.cur_count;
+	cfg->smmu = dev_get_drvdata(smmu_dev);
+	of_phandle_iterator_args(&it, cfg->ids, it.cur_count);
+	return 0;
 }
 #else
-static int arm_smmu_register_legacy_master(struct device *dev,
-					   struct arm_smmu_device **smmu)
+static struct arm_smmu_master_cfg *
+arm_smmu_register_legacy_master(struct device *dev)
 {
-	return -ENODEV;
+	return ERR_PTR(-ENODEV);
 }
 #endif /* CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS */
 
@@ -1019,7 +1015,6 @@ static bool arm_smmu_free_sme(struct arm_smmu_device *smmu, int idx)
 
 static int arm_smmu_master_alloc_smes(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = cfg->smmu;
 	struct arm_smmu_smr *smrs = smmu->smrs;
@@ -1027,9 +1022,9 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 
 	mutex_lock(&smmu->stream_map_mutex);
 	/* Figure out a viable stream map entry allocation */
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
-		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
-		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
+	for_each_cfg_sme(cfg, i, idx) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, cfg->ids[i]);
+		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, cfg->ids[i]);
 
 		if (idx != INVALID_SMENDX) {
 			ret = -EEXIST;
@@ -1051,7 +1046,7 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 	}
 
 	/* It worked! Now, poke the actual hardware */
-	for_each_cfg_sme(cfg, fwspec, i, idx)
+	for_each_cfg_sme(cfg, i, idx)
 		arm_smmu_write_sme(smmu, idx);
 
 	mutex_unlock(&smmu->stream_map_mutex);
@@ -1066,14 +1061,13 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 	return ret;
 }
 
-static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
-				      struct iommu_fwspec *fwspec)
+static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = cfg->smmu;
 	int i, idx;
 
 	mutex_lock(&smmu->stream_map_mutex);
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
+	for_each_cfg_sme(cfg, i, idx) {
 		if (arm_smmu_free_sme(smmu, idx))
 			arm_smmu_write_sme(smmu, idx);
 		cfg->smendx[i] = INVALID_SMENDX;
@@ -1082,8 +1076,7 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
 }
 
 static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
-				      struct arm_smmu_master_cfg *cfg,
-				      struct iommu_fwspec *fwspec)
+				      struct arm_smmu_master_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
@@ -1096,7 +1089,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	else
 		type = S2CR_TYPE_TRANS;
 
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
+	for_each_cfg_sme(cfg, i, idx) {
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			continue;
 
@@ -1111,24 +1104,10 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct arm_smmu_master_cfg *cfg;
-	struct arm_smmu_device *smmu;
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = cfg->smmu;
 	int ret;
 
-	/*
-	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
-	 * domains between of_xlate() and probe_device() - we have no way to cope
-	 * with that, so until ARM gets converted to rely on groups and default
-	 * domains, just say no (but more politely than by dereferencing NULL).
-	 * This should be at least a WARN_ON once that's sorted.
-	 */
-	cfg = dev_iommu_priv_get(dev);
-	if (!cfg)
-		return -ENODEV;
-
-	smmu = cfg->smmu;
-
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
 		return ret;
@@ -1148,7 +1127,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	ret = arm_smmu_domain_add_master(smmu_domain, cfg, fwspec);
+	ret = arm_smmu_domain_add_master(smmu_domain, cfg);
 
 	/*
 	 * Setup an autosuspend delay to avoid bouncing runpm state.
@@ -1325,59 +1304,85 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static
-struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
+static struct arm_smmu_master_cfg *
+arm_smmu_probe_new_master(struct iommu_probe_info *pinf)
 {
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
-	put_device(dev);
-	return dev ? dev_get_drvdata(dev) : NULL;
-}
-
-static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-{
-	struct arm_smmu_device *smmu = NULL;
 	struct arm_smmu_master_cfg *cfg;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	int i, ret;
+	struct arm_smmu_device *smmu;
 
-	if (using_legacy_binding) {
-		ret = arm_smmu_register_legacy_master(dev, &smmu);
+	smmu = iommu_iort_get_single_iommu(pinf, &arm_smmu_ops, NULL,
+					   struct arm_smmu_device, iommu);
+	if (IS_ERR(smmu))
+		return ERR_CAST(smmu);
+
+	if (!pinf->of_master_np) {
+		/* In ACPI mode the smmu uses the usual u32 format */
+		cfg = iommu_fw_alloc_per_device_ids(pinf, cfg);
+		if (IS_ERR(cfg))
+			return cfg;
+		cfg->acpi_fwnode = iommu_fw_acpi_fwnode(pinf);
+	} else {
+		unsigned int num_ids;
+		int ret;
 
 		/*
-		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
-		 * will allocate/initialise a new one. Thus we need to update fwspec for
-		 * later use.
+		 * In OF mode it supports several different formats for the arg,
+		 * pass through arm_smmu_of_xlate to extract it.
 		 */
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (ret)
-			goto out_free;
-	} else {
-		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+		num_ids = iommu_of_num_ids(pinf);
+		cfg = kzalloc(struct_size(cfg, ids, num_ids), GFP_KERNEL);
+		if (!cfg)
+			return ERR_PTR(-ENOMEM);
+
+		ret = iommu_of_xlate(pinf, &arm_smmu_ops, -1,
+				     &arm_smmu_of_xlate, cfg);
+		if (ret) {
+			kfree(cfg);
+			return ERR_PTR(ret);
+		}
 	}
 
+	cfg->smmu = smmu;
+	return cfg;
+}
+
+static struct iommu_device *arm_smmu_probe_device(struct iommu_probe_info *pinf)
+{
+	struct arm_smmu_master_cfg *cfg;
+	struct device *dev = pinf->dev;
+	struct arm_smmu_device *smmu;
+	int i, ret;
+
+	if (using_legacy_binding)
+		cfg = arm_smmu_register_legacy_master(dev);
+	else
+		cfg = arm_smmu_probe_new_master(pinf);
+	if (IS_ERR(cfg))
+		return ERR_CAST(cfg);
+	smmu = cfg->smmu;
+
 	ret = -EINVAL;
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
-		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
+	for (i = 0; i < cfg->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, cfg->ids[i]);
+		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, cfg->ids[i]);
 
 		if (sid & ~smmu->streamid_mask) {
 			dev_err(dev, "stream ID 0x%x out of range for SMMU (0x%x)\n",
 				sid, smmu->streamid_mask);
-			goto out_free;
+			goto out_cfg_free;
 		}
 		if (mask & ~smmu->smr_mask_mask) {
 			dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
 				mask, smmu->smr_mask_mask);
-			goto out_free;
+			goto out_cfg_free;
 		}
 	}
 
 	ret = -ENOMEM;
-	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
-		      GFP_KERNEL);
+	cfg->smendx = kzalloc(array_size(sizeof(*cfg->smendx), cfg->num_ids),
+			      GFP_KERNEL);
 	if (!cfg)
-		goto out_free;
+		goto out_cfg_free;
 
 	cfg->smmu = smmu;
 	dev_iommu_priv_set(dev, cfg);
@@ -1400,15 +1405,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	return &smmu->iommu;
 
 out_cfg_free:
+	kfree(cfg->smendx);
 	kfree(cfg);
-out_free:
-	iommu_fwspec_free(dev);
 	return ERR_PTR(ret);
 }
 
 static void arm_smmu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	int ret;
 
@@ -1416,10 +1419,11 @@ static void arm_smmu_release_device(struct device *dev)
 	if (ret < 0)
 		return;
 
-	arm_smmu_master_free_smes(cfg, fwspec);
+	arm_smmu_master_free_smes(cfg);
 
 	arm_smmu_rpm_put(cfg->smmu);
 
+	kfree(cfg->smendx);
 	kfree(cfg);
 }
 
@@ -1438,13 +1442,12 @@ static void arm_smmu_probe_finalize(struct device *dev)
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu = cfg->smmu;
 	struct iommu_group *group = NULL;
 	int i, idx;
 
 	mutex_lock(&smmu->stream_map_mutex);
-	for_each_cfg_sme(cfg, fwspec, i, idx) {
+	for_each_cfg_sme(cfg, i, idx) {
 		if (group && smmu->s2crs[idx].group &&
 		    group != smmu->s2crs[idx].group) {
 			mutex_unlock(&smmu->stream_map_mutex);
@@ -1468,7 +1471,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 
 	/* Remember group for faster lookups */
 	if (!IS_ERR(group))
-		for_each_cfg_sme(cfg, fwspec, i, idx)
+		for_each_cfg_sme(cfg, i, idx)
 			smmu->s2crs[idx].group = group;
 
 	mutex_unlock(&smmu->stream_map_mutex);
@@ -1506,8 +1509,10 @@ static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate(struct iommu_device *iommu,
+			     struct of_phandle_args *args, void *priv)
 {
+	struct arm_smmu_master_cfg *cfg = priv;
 	u32 mask, fwid = 0;
 
 	if (args->args_count > 0)
@@ -1517,13 +1522,14 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, args->args[1]);
 	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
 		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, mask);
-
-	return iommu_fwspec_add_ids(dev, &fwid, 1);
+	cfg->ids[cfg->num_ids++] = fwid;
+	return 0;
 }
 
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
@@ -1534,7 +1540,10 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 	list_add_tail(&region->list, head);
 
-	iommu_dma_get_resv_regions(dev, head);
+	if (cfg->acpi_fwnode)
+		iort_iommu_get_resv_regions(dev, head, cfg->acpi_fwnode,
+					    cfg->ids, cfg->num_ids);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static int arm_smmu_def_domain_type(struct device *dev)
@@ -1553,22 +1562,22 @@ static int arm_smmu_def_domain_type(struct device *dev)
 
 static bool arm_smmu_get_stream_id(struct device *dev, u32 *stream_id)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	if (fwspec->num_ids != 1)
+	if (cfg->num_ids != 1)
 		return false;
-	*stream_id = fwspec->ids[0] & 0xffff;
+	*stream_id = cfg->ids[0] & 0xffff;
 	return true;
 }
 
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
-	.probe_device		= arm_smmu_probe_device,
+	.probe_device_pinf	= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.tegra_dev_iommu_get_stream_id = arm_smmu_get_stream_id,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec11f..ba8224751fdcdc 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -378,7 +378,10 @@ struct arm_smmu_domain {
 
 struct arm_smmu_master_cfg {
 	struct arm_smmu_device		*smmu;
-	s16				smendx[];
+	struct fwnode_handle		*acpi_fwnode;
+	s16				*smendx;
+	unsigned int			num_ids;
+	u32				ids[] __counted_by(num_ids);
 };
 
 static inline u32 arm_smmu_lpae_tcr(const struct io_pgtable_cfg *cfg)
@@ -446,10 +449,10 @@ struct arm_smmu_impl {
 };
 
 #define INVALID_SMENDX			-1
-#define cfg_smendx(cfg, fw, i) \
-	(i >= fw->num_ids ? INVALID_SMENDX : cfg->smendx[i])
-#define for_each_cfg_sme(cfg, fw, i, idx) \
-	for (i = 0; idx = cfg_smendx(cfg, fw, i), i < fw->num_ids; ++i)
+#define cfg_smendx(cfg, i) \
+	(i >= cfg->num_ids ? INVALID_SMENDX : cfg->smendx[i])
+#define for_each_cfg_sme(cfg, i, idx) \
+	for (i = 0; idx = cfg_smendx(cfg, i), i < cfg->num_ids; ++i)
 
 static inline int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
-- 
2.42.0


