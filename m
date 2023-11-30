Return-Path: <linux-acpi+bounces-1946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD017FE6B9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146BA281E76
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39D134A3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FCgE9t3o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1553D7D;
	Wed, 29 Nov 2023 17:10:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgdG6WMU5tRyo+pu8hMHlBvB63s+Qf82sgIF5JKsUmypHk2HTVBtV12ItkQbz8+kN4n2ItL81qChoZ9tvxNS6mMvzpevjf48abgUAzCsFTu5BbSrIUW5+NkKPD+GXuDj6te/PCpVVoRbdOj1gQDJJPo+HhOq1m1g5NJxj37KrxfiGyMl4e6A8Tzfgpk6s9wLSyG8ay5xqtb8crQSeWHS8UqDWzEcCb9vBBK0nQEOXCHaLbLs3/q+vR5VpVDaRnGGhgj2hqVmZL3QNUxSeJZsAYafDYHtHukWpJ+6M06sCJkXAFqmMuhbAWKbI52vXc/dzpS3/I6znk8l9etMdNF0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em3umxu+TrgBsDrHGwW96pPsBzA9rtgyJQRI8gBte78=;
 b=lULuIsxwC5byjV71CeEwJzenNNsw8IF/Woi1hMHCO0kyFMd5pwAXCZJYX4eAUitTSAEDXc3fCeLSqhFgEF4pWScioUWpGbNB1JkeS+sjYM2Ms9c2K0RUz7aLaD8lm5PvD6OQA7rHVTq5etYYnSfboIaH3yrd7sL1ns5wCbNBummU0v8qK5VZ8NSO8cplW2NYszN6zP6O4XiNjdTk2Z6N30b7l+6LxTPXttzhCXCdT6vHuyWOhiDkBifMzb0EDc/ugpMK/JLXlTLdTKvW62o9UbI7ofzV5WtEep9XPWoSCl3UWG1HEqWKoLDMOI+TIqHLeGZcpceer5JzE776P3A/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em3umxu+TrgBsDrHGwW96pPsBzA9rtgyJQRI8gBte78=;
 b=FCgE9t3oSP+BSi+R9rMlOousaMLCXfKCzdml/A0zH0wwGGzu1RBLGHwiG/Zlce904THeVhNTL5bJd+kc8XIp1baJ18FW0WhrWMTcdr6ghET9HbMxvrNlZkFcr5/5dXgc9oKmNQ+BQVjyHETX9JZ6lME+gFiP4DALyNDSIIgW9vEEl9YkfUYSEke+ZIKW8+o/DGbnI0U8lzKSI94W1pqVcPV5TrVbNvjkoHJytldV52yfi34l7kYecc1JuMFuzi+/OGaUTplgc7tkYP1qrzeuAxs3FWVOIIrWIp2iez5yfZmgP38BVfHAQF2+KEWNtJNSx1hbiwlc/5DtM3kUlNjVdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:39 +0000
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
Subject: [PATCH 15/30] iommu/msm: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:10:22 -0400
Message-ID: <15-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1221a765-a291-4493-44d5-08dbf1412a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vQUJtwMzpKbiN/x6qAz49eIAv7c4i7aj6n6Pu5q5HuPH6JQwvAkMQ4YOyUtO+evP23+MtCFsnqTCJmevSMU2vye73fyePNX4hcirTy+MclDVS2gPVSKoZq/Y6qq9tJV1eLw2yS5tqbYbaCSFLGMeUUF72Yj/rAocm28MfWejlYBm5pD295oTWbRfyCpe68qWcSRCt3DZa2/N9KjXN7yttsxwjH7pVbM63fQ19I9FzPlfOtQQB/dR8UJZNpZUbECfxw+yJf1jI9DayzACXacfbTEN6gdr1GSDNlvD5bry/RgjQIhnIaGKBIdbNjx3iZmYX24n1twbs2W49h1YgYNya+Z1nTPkLNnUbbLbcAC7OCjpJhWuU9S1P+BoypMV7mr8+jmVvwxzbR6DQ0eaaFfkBeY8lHQSyVOZsuPyxuK4AjAdpL4z1saB7YATBqaGP+etW1guvs0yVGXbgsniv4NEiWq9wiN21r3ySGCLn7weriOlgsYjtC6J619iNbIMbMURHBkPhO60dsmvmyL3kk8mXc9mQi4OJI+nXyCyRsFMGnn4T564hiI+PNY7UaidL4lQj7Ko/To/r9Pf4QGNKzseCnErRiLfUke4/rJx3lGR0Pg/TsfxepBhxmZMz9JY5//DnrZJSPdeTKXlcK9rOfhV5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(66899024)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1z9nljq3YwhKkQLW7r3lOZa1VrRpPUzgK/sQ/NLsmZ6cz1YyPenNRkYNj9zN?=
 =?us-ascii?Q?lv0gXvhlYdLXbYMga9l/G/YHnsl6JTWWIm9t901St/UCxH7nMldMQ4Q1eMEh?=
 =?us-ascii?Q?rJ4JJwva6khYeZvuK04jo2WMMIiVoPuVwL8d6Gdpg9u4SKNQKNyFp86DCp3q?=
 =?us-ascii?Q?hNMNi4/4UrHAAoUJ/0EcN6mALgTdxpg5TO6OfUEd/1UzPmpHc1zYeHq5bdpV?=
 =?us-ascii?Q?1nqoJNZ61R6afR001Mk/X7s/RGX7C14VQpWNLxmXE60Yd8VxMw6VP6afSNRL?=
 =?us-ascii?Q?ZJ5byuEtzb7/Tv3/W0r+xqVXIuEGG3QHprZlLQ9SIvZ0Zz9Qxez28Ht/6vJ0?=
 =?us-ascii?Q?9BgB/ZNq/nP3toe3hAS36YhUqUorIzC7yVqX57Iv4Garf1jExDRdrVopFo+t?=
 =?us-ascii?Q?R+wJQYOjR7dnX11kBzLjGmry2V6dne8gD1Ep5KZ4HP/N8eWQUcr8y7sc/CUU?=
 =?us-ascii?Q?hXg6kD3xy2BaNz4F7eBo8iMvhx7KJvLEnnCi4jQxmCKBGuHAGptklUCYNiKm?=
 =?us-ascii?Q?gwxfIqD17vWEladGstNOx2R3SYH/N7dPEOz/an3Y6AqSKXApdvn5UyLvfCb2?=
 =?us-ascii?Q?L+kW+b1NHARcyEzvIn++nI7OMtiPZd1Kv6uM3PEaBI69iw4AgyUMDOOkCRgW?=
 =?us-ascii?Q?/ftxPeMmiD9b7uXY6WTXYinzlllwJ26vADhMyok+9WNjr3MjCa2jJNx6V09+?=
 =?us-ascii?Q?I8AU7MW5n3HrmrZACDKsY98MPIMmqzXOWgnSikXUdbklFtmp2xytgU0dl0RL?=
 =?us-ascii?Q?2butV5+wiBXJAaqnb1VlmkuddjJxmfGl+Ekvuif14QM7ckoI9xdDJ3InZv74?=
 =?us-ascii?Q?3jsVRIx5EAdT6dKtJKyWX/lYlXj34o9Cy8L5dBEM3zH627aPrquR0h4qoLTu?=
 =?us-ascii?Q?1Anmt9GorLpQrMQHyENKP3CSgJA3Pwvo72bONp8qv31V2t40yKSp+J56anqj?=
 =?us-ascii?Q?HUGlCT1NmvNZrJbGXrvbWTYZ46FwTRukrjnkMvyaAGUEdl1LCLuCnVcspUhA?=
 =?us-ascii?Q?GeeFciIo9f0ZGduiWxDpIFj9Zde3PR5rLPw3WyNEnBYxw+iGk+6VvDeVuKH+?=
 =?us-ascii?Q?0qEr/nd1rkpYYY2tQxmIC/ez7gEZWE/cSlLXYQsDyQNWWor47uLQgf7GW650?=
 =?us-ascii?Q?itfZt1FQuAPYDpVnXN0L2Lb23JzROuPUlEkskiIYm00sj+zPwa5Yf8ram3LA?=
 =?us-ascii?Q?oRVsqd9SlYPBpaYd73Q6WT/ygGNwgxl9WiMKq54BCseYDsTFybnk+TrI4ghb?=
 =?us-ascii?Q?8TC790M1qvr6fuocc2Hv7Qb8lfrsVFHGccUX45u+rRULoJMY0B+9cH//zQSO?=
 =?us-ascii?Q?9lC0vPn9eX0S2WMvsBTFhfcWHn6DOID1pZwFeXhG8nWA6jwS/T13pRwZcyuu?=
 =?us-ascii?Q?ZxRZGstIvLDKZu3GoGWKo4CKgtsonET9ob0wUW46vthBU4bqr6XF6R+50Qjm?=
 =?us-ascii?Q?3pVCRaGHGhqzvD9xTJnwQEXlBrqtITyWX4ow+E9RXpQ4pf7FVEiw7LbaQd5J?=
 =?us-ascii?Q?Wvg/85pi6mSrTN5W7T5FxlfQ0Jl3e9oW3vAJW33VKD3AeWI80tNgZZWgdo9p?=
 =?us-ascii?Q?Ap4uAXroDOaXm3xunMz3XzcXBVDe8MeXhsf74tAt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1221a765-a291-4493-44d5-08dbf1412a2f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:38.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqKM7lR3SnpMu9gDv/MPVPNew9e4qSPTtWyAIv1UdK05CNjfSVrsO84rY1P+1Sa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

It is confusing what this driver is doing. The insert_iommu_master(),
especially the list_empty(), doesn't make a lot of sense.

Based on the dtsi this supports an iommu instance that has exactly one
device attached it. However each device may be connected to multiple
instances with multiple stream ids. The iommus list must be sorted by
instance or it will not parse correctly.

Ideally this driver would work more like dart where each master allocates
memory for dev_iommu_priv and records a list of the all the iommus and
stream ids in that struct. That is too big of a change for this patch.

Keep things basically the same, but rely on the core code to discover the
iommu_device and stop confusingly using dev_iommu_priv to join SIDs into
the same master when processing the assumed-to-be-sorted iommus list.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/msm_iommu.c | 93 ++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f86af9815d6f98..6f21eec857c7d7 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
@@ -37,6 +38,15 @@ static DEFINE_SPINLOCK(msm_iommu_lock);
 static LIST_HEAD(qcom_iommu_devices);
 static struct iommu_ops msm_iommu_ops;
 
+struct msm_xlate_args {
+	struct device *dev;
+	struct msm_iommu_ctx_dev *master;
+	struct msm_iommu_dev *iommu;
+};
+
+static int msm_iommu_of_xlate(struct iommu_device *core_iommu,
+			      struct of_phandle_args *args, void *priv);
+
 struct msm_priv {
 	struct list_head list_attached;
 	struct iommu_domain domain;
@@ -357,38 +367,17 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
 	return 0;
 }
 
-/* Must be called under msm_iommu_lock */
-static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
+static struct iommu_device *
+msm_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct msm_iommu_dev *iommu, *ret = NULL;
-	struct msm_iommu_ctx_dev *master;
+	struct msm_xlate_args args = { .dev = pinf->dev };
+	int ret;
 
-	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
-		master = list_first_entry(&iommu->ctx_list,
-					  struct msm_iommu_ctx_dev,
-					  list);
-		if (master->of_node == dev->of_node) {
-			ret = iommu;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-static struct iommu_device *msm_iommu_probe_device(struct device *dev)
-{
-	struct msm_iommu_dev *iommu;
-	unsigned long flags;
-
-	spin_lock_irqsave(&msm_iommu_lock, flags);
-	iommu = find_iommu_for_dev(dev);
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
-
-	return &iommu->iommu;
+	ret = iommu_of_xlate(pinf, &msm_iommu_ops, -1, &msm_iommu_of_xlate,
+			     &args);
+	if (ret)
+		return ERR_PTR(ret);
+	return &args.iommu->iommu;
 }
 
 static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -596,22 +585,26 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
 }
 
-static int insert_iommu_master(struct device *dev,
-				struct msm_iommu_dev **iommu,
-				struct of_phandle_args *spec)
+static int insert_iommu_master(struct msm_xlate_args *args,
+			       struct msm_iommu_dev *iommu,
+			       struct of_phandle_args *spec)
 {
-	struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
+	struct msm_iommu_ctx_dev *master = args->master;
+	struct device *dev = args->dev;
 	int sid;
 
-	if (list_empty(&(*iommu)->ctx_list)) {
+	if (!args->iommu)
+		args->iommu = iommu;
+
+	if (list_empty(&iommu->ctx_list)) {
 		master = kzalloc(sizeof(*master), GFP_ATOMIC);
 		if (!master) {
 			dev_err(dev, "Failed to allocate iommu_master\n");
 			return -ENOMEM;
 		}
 		master->of_node = dev->of_node;
-		list_add(&master->list, &(*iommu)->ctx_list);
-		dev_iommu_priv_set(dev, master);
+		list_add(&master->list, &iommu->ctx_list);
+		args->master = master;
 	}
 
 	for (sid = 0; sid < master->num_mids; sid++)
@@ -625,28 +618,16 @@ static int insert_iommu_master(struct device *dev,
 	return 0;
 }
 
-static int qcom_iommu_of_xlate(struct device *dev,
-			       struct of_phandle_args *spec)
+static int msm_iommu_of_xlate(struct iommu_device *core_iommu,
+			      struct of_phandle_args *args, void *priv)
 {
-	struct msm_iommu_dev *iommu = NULL, *iter;
+	struct msm_iommu_dev *iommu =
+		container_of(core_iommu, struct msm_iommu_dev, iommu);
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	list_for_each_entry(iter, &qcom_iommu_devices, dev_node) {
-		if (iter->dev->of_node == spec->np) {
-			iommu = iter;
-			break;
-		}
-	}
-
-	if (!iommu) {
-		ret = -ENODEV;
-		goto fail;
-	}
-
-	ret = insert_iommu_master(dev, &iommu, spec);
-fail:
+	ret = insert_iommu_master(priv, iommu, args);
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
 	return ret;
@@ -690,10 +671,10 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 static struct iommu_ops msm_iommu_ops = {
 	.identity_domain = &msm_iommu_identity_domain,
 	.domain_alloc_paging = msm_iommu_domain_alloc_paging,
-	.probe_device = msm_iommu_probe_device,
+	.probe_device_pinf = msm_iommu_probe_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
-	.of_xlate = qcom_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
 		.map_pages	= msm_iommu_map,
-- 
2.42.0


