Return-Path: <linux-acpi+bounces-1949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06957FE6BD
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B7281FCE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1484F13AE3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HQUzZjYH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37540D6C;
	Wed, 29 Nov 2023 17:10:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIB7myq+wy1HkVTiYfCrsjCYGm81Ntqt911tXQnYbVUBhPrsOZ9B6JMD8d00KgW4OmR8HwF5E4Ui0TvBCnVqhUbUkhrmQGex7RwMvUKAcFK7DadepjEeGMaKSYkuDzzsksdC/7yzZ4MCwJa6ofdfUDRZEySwlrHIFyZf4O7oMu4ct4g1id92TwhQp1VQMngp+HITAmXPr0ETSPMR1sYR6k/EVSSnUeakurvSsCf1GMcjMIWmIdTTi6yByWX2rVRgEd//rRbQLl7WmqC4rIiszPuRUBLWqAP2Ueb6OVLb5YD6mYWQJ63rc3cRg7dHKhWrEAPm3Zl/txnd/AeL4nW2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3gvB8+jcuszFrOcv/8o0zSHcCWgbZ8CoZJyYlaYjMU=;
 b=Q6LimCsOr0kUXJUFznTYQz/iBsAD2IjR/7EdyRDcsfFzgfi7bOtde7Gm+BUHmlkav+DxrxRkFcrLjSc1a/HA5svPoGghGzU2UjVENdSSQ5M8NZUUNQU2lBC8qZ1TVyYXm1AQGBxHMHXt73/xfIWTPro19m+/eAXprS7ZKhVXYoC7FCwooVElvzfoRc7Bp0H33BcbC+VE07dafCG0h0jRuf8cYYFF3AcvxPgdJlugcqh3nvezKTSUD2vdb8u1dhyMs5Cak13+jSGd0jkCwnbJfDo+MRlQsZgrnF3avm4Uni2l29GY2wjft+yNqeumPVEFsEwrQGWDbKBwTdXxZdYozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3gvB8+jcuszFrOcv/8o0zSHcCWgbZ8CoZJyYlaYjMU=;
 b=HQUzZjYHJ5o3dv42aVGSYQkTZUqN01+cI3GhktoqxXXgW1vG3oqy4VVJ9KAA8iUZBWmlHhDiDReFQ5dvycFO+xsGG1b7fIjJArhWfddxhP/fdrr9B+pAz+sZyc5UblEHpxejZUjA3kYv0IpMq1pWCBTjMOPonih4HAPShGqHc+DKzGnIaAzanGDUFu3Y2s0r+6fTdlpu1wOt3btUG/LkhkUEEdBUd5W3iTuQqllkAOB5YMaJHUpQXxn3bxcviC0BUuNiQuRmXuZ3FK9zY7waquVuDHWJnXEH3PibhNO0xm/m16sSMMmi6q+f8A73Jr8dNkRQr7xyOWyAPfQUFHcAwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:41 +0000
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
Subject: [PATCH 18/30] iommu/tegra: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:25 -0400
Message-ID: <18-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1432f4cc-9e44-409d-cd33-08dbf1412a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	70m8ZkXBhK9E+PSknZOffPHQt4gitZ0toaCp5TG9m8aLfwY3XAfraLbChk3AOuqyHrSxpHQRUkQXAzaZx4VqcXSuSB8zVZxBPEX1CrYUhSny9FAivS/fR36DnK9P5uRsgMyWWogRgZgQyUAMx9iiyulVCwZi/myWcvxR6a1odl07qlN+rux34xqtvKPuVnUZV93RYebbipByvgO3uADD43zjIH/wbqooPYMrf9fXVS/B/MWxOFc0invNfLJtM3t/2kcTti5+tf1HOtpvq/572wgQ8yFVmqH/SkTeST+B33+ZU5SovLu2R0QZD6LlEQDtklUXDzwm5Dq0tYGMCyCHUrnmvqrYlu3+wZGFJ2pIDFDfotuzjisYQyziLjV2frhBJGwSibJ359Tk8Cn1hldO4twVDor5kc1flASEStmQ4Um7g3ioJYFb8WUqqSfl2phEoV4/36JplSPFxReKGWvPZIc72iX0EQBm2xjrUtGvCY+iHHANQP38VQ8NVl2XQ3pDpVCNnMqUW8QWLfJOAzFn0XiqqEszrtEqFbwSbqhvFjM4GIoz2LjzFqppV5ObDdoeYaZ5KZmiikZXEvM6venf6BJPKNJ0Tqpcly+hp9jabbrs47km2FtvJcoEtTRh2AFkEnzkORuitnBNERYZcmMwTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdW7pmWu21ZWoAqVQ0tg3WLJd0/rYyWPpS7VgoiC4MCb2qEVqPtaC0jDH+zD?=
 =?us-ascii?Q?BpwiNwQhNEkOPv8sXrOwSlXIcIWfMdjAvPipOVOePQzmr4t/XQXb4I/9dZC9?=
 =?us-ascii?Q?YaOyOnhxtoSjP3aHUJuNQ1GsE07GAIznHG/A/zgxkrSxngIqPRljW9M2e9+W?=
 =?us-ascii?Q?BdPJPe73z+LFMyW83Ki8IG+7PGHZkUQmC9Kb/fgpRZq372Npg1WHo/wdDoKH?=
 =?us-ascii?Q?zk3eMVXu3eDjm4PDaefNl+V0woNaQh7I3VWVsLobnYl8P97LQm/TMq4/K4VO?=
 =?us-ascii?Q?o6sLVrxSOT33sg/gNmIN406Al4GWzl8oGch+O7jTD24oW4BCKak63yKPOvmD?=
 =?us-ascii?Q?o0DETl9NfhK7F7E7FpBrmOoUj5ZQen3h1/tTBHzYnXENrAROBgAz0Nv31VOb?=
 =?us-ascii?Q?a5kRcYeVVcDBe6CljTgtvVxdfG55lm8BpcG/T18KebQHhUT2krw0ahriDCi+?=
 =?us-ascii?Q?kTj4RRl89i5Si8F0aJNHSDtE7C9gHfg+0jdIYHfY9x8DON2K8mZkB+PukKwR?=
 =?us-ascii?Q?G2jSRp0rd2B6m6Tic5rU63GPfON+yDOrc6Qc365q4RBiJ22yFLHYy8Jvt/bu?=
 =?us-ascii?Q?/KACZ7vmW8QWTo8EuhhrpGYk4YgUgk5HVJZQKVCg0PqrGQLsv9D9E9svsMzz?=
 =?us-ascii?Q?Bw+N7cwl8y4/2utrjabqIvQvEy85Nl9Zq1ZBerruZnuMNKh7BRT4m3T3n1y5?=
 =?us-ascii?Q?paic7NNFdFx/PKRlhuLr1idQn/Sg0/wjGxdNsQf0EY3gX53kYYT6Q98Ncob3?=
 =?us-ascii?Q?4gbSB1YMBZKa58tfHTqZqtrQ3qK/bGAe6ZgVW9j/Hl9hojtQpAA3DzMIXMm3?=
 =?us-ascii?Q?zvXg4oRpnygC5QLvIzq6TcOc0s5WTbSUNIBVLENbuqZ0HjcEkvigGaYn6+CF?=
 =?us-ascii?Q?4NL6JNqEusOugle0yD48fa0kbmC7U0YosysBHr0ibkmLJRfDR3nHdta082Nf?=
 =?us-ascii?Q?1bPtO2smC19iY/2FHMISaWslkW7pDri5v/KKdm9CZA0l/UZW13Ll/ifolMkO?=
 =?us-ascii?Q?vbxo1dJvHSdGO8lz421+lf15KDna9AxkbODCpBoQDGkKx8Q6EbgtjoiNZFuB?=
 =?us-ascii?Q?eL1dzgZv/n0hNzr61TIxA6XZDOFFCjt4l0cMqfoY9JsOzS2cklXE3Un2l4cC?=
 =?us-ascii?Q?xNIE55pGfggChiUs7OL/mDoKyL9eKjXPoCYpmmrhLMK8HAFGCw164j7nIUIO?=
 =?us-ascii?Q?FRciPu+zIIdoD/AlVZllMpni7ywu+GuXWYjhErejtwQ7w05HGjl3KY+yMGZH?=
 =?us-ascii?Q?TSUpBRdIZinTIeXyaDzOpEnhJ95jyeP+cTtKeaiLEgoH5H7SGZwby2E/NmYq?=
 =?us-ascii?Q?1ObjntJbLMBt3N1S2zF/95ISZg+KhgbDULtNzM1coZcB9z70d9dfcNaCc/gV?=
 =?us-ascii?Q?ZPWo7fZTilVHQ+AUTMrxbpQJPAt6ndIDnKbNS1e3zmdrOrgfsUcjDIMKK5Bc?=
 =?us-ascii?Q?7mmwlf3GbH4AjMyGkN/tEIVnnU0E4pfA5HBs0IMhTmXHsAr/TmrumUv+Lftf?=
 =?us-ascii?Q?tjSlaUBu6h9KC1lJTDDdCE0fkPU70Z1XmT+79YmiYHagjnTUXtBsKHzk7uhD?=
 =?us-ascii?Q?f20cxGHl6B2Y3w8CwvmCu10qms5w6mcK3TVSIk5d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1432f4cc-9e44-409d-cd33-08dbf1412a55
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:39.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ubwf2F8qyqpmX8C6Oow8z2AdHECCrVGP8JL7N9r1AURPcZNzYxCnY4lRVugm0y1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

Tegra supports a single iommu instance with multiple ids.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
tegra_smmu_of_xlate().

This now checks that all the iommu instances are the same.

Tegra can self-probe without having to go through the fwspec path because
it self-initializes the fwspec. Use iommu_of_allow_bus_probe() to achieve
the same thing.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 154 +++++++++++--------------------------
 1 file changed, 47 insertions(+), 107 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index cf563db3e3b48d..1daa92f524452b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -7,6 +7,7 @@
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -19,6 +20,8 @@
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
+static const struct iommu_ops tegra_smmu_ops;
+
 struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
@@ -49,6 +52,12 @@ struct tegra_smmu {
 	struct iommu_device iommu;	/* IOMMU Core code handle */
 };
 
+struct tegra_smmu_device {
+	struct tegra_smmu *smmu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
@@ -477,21 +486,18 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
+	struct tegra_smmu *smmu = smmu_device->smmu;
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	unsigned int index;
 	int err;
 
-	if (!fwspec)
-		return -ENOENT;
-
-	for (index = 0; index < fwspec->num_ids; index++) {
+	for (index = 0; index < smmu_device->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
 		if (err)
 			goto disable;
 
-		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_enable(smmu, smmu_device->ids[index], as->id);
 	}
 
 	if (index == 0)
@@ -501,7 +507,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 
 disable:
 	while (index--) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_disable(smmu, smmu_device->ids[index], as->id);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 
@@ -511,22 +517,19 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 static int tegra_smmu_identity_attach(struct iommu_domain *identity_domain,
 				      struct device *dev)
 {
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu_as *as;
 	struct tegra_smmu *smmu;
 	unsigned int index;
 
-	if (!fwspec)
-		return -ENODEV;
-
 	if (domain == identity_domain || !domain)
 		return 0;
 
 	as = to_smmu_as(domain);
 	smmu = as->smmu;
-	for (index = 0; index < fwspec->num_ids; index++) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+	for (index = 0; index < smmu_device->num_ids; index++) {
+		tegra_smmu_disable(smmu, smmu_device->ids[index], as->id);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 	return 0;
@@ -811,77 +814,34 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
-static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
+static struct iommu_device *
+tegra_smmu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct platform_device *pdev;
-	struct tegra_mc *mc;
+	struct tegra_smmu_device *smmu_device;
+	struct tegra_smmu *smmu;
 
-	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return NULL;
+	iommu_of_allow_bus_probe(pinf);
+	smmu = iommu_of_get_single_iommu(pinf, &tegra_smmu_ops, 1,
+					 struct tegra_smmu, iommu);
+	if (IS_ERR(smmu))
+		return ERR_CAST(smmu);
 
-	mc = platform_get_drvdata(pdev);
-	if (!mc) {
-		put_device(&pdev->dev);
-		return NULL;
-	}
-
-	return mc->smmu;
-}
-
-static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
-				struct of_phandle_args *args)
-{
-	const struct iommu_ops *ops = smmu->iommu.ops;
-	int err;
-
-	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
-	if (err < 0) {
-		dev_err(dev, "failed to initialize fwspec: %d\n", err);
-		return err;
-	}
-
-	err = ops->of_xlate(dev, args);
-	if (err < 0) {
-		dev_err(dev, "failed to parse SW group ID: %d\n", err);
-		iommu_fwspec_free(dev);
-		return err;
-	}
-
-	return 0;
-}
-
-static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
-{
-	struct device_node *np = dev->of_node;
-	struct tegra_smmu *smmu = NULL;
-	struct of_phandle_args args;
-	unsigned int index = 0;
-	int err;
-
-	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					  &args) == 0) {
-		smmu = tegra_smmu_find(args.np);
-		if (smmu) {
-			err = tegra_smmu_configure(smmu, dev, &args);
-
-			if (err < 0) {
-				of_node_put(args.np);
-				return ERR_PTR(err);
-			}
-		}
-
-		of_node_put(args.np);
-		index++;
-	}
-
-	smmu = dev_iommu_priv_get(dev);
-	if (!smmu)
-		return ERR_PTR(-ENODEV);
+	smmu_device = iommu_fw_alloc_per_device_ids(pinf, smmu_device);
+	if (IS_ERR(smmu_device))
+		return ERR_CAST(smmu_device);
+	smmu_device->smmu = smmu;
 
+	dev_iommu_priv_set(pinf->dev, smmu_device);
 	return &smmu->iommu;
 }
 
+static void tegra_smmu_release_device(struct device *dev)
+{
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
+
+	kfree(smmu_device);
+}
+
 static const struct tegra_smmu_group_soc *
 tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
 {
@@ -907,10 +867,10 @@ static void tegra_smmu_group_release(void *iommu_data)
 
 static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
+	struct tegra_smmu *smmu = smmu_device->smmu;
 	const struct tegra_smmu_group_soc *soc;
-	unsigned int swgroup = fwspec->ids[0];
+	unsigned int swgroup = smmu_device->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
@@ -958,27 +918,6 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	return group->group;
 }
 
-static int tegra_smmu_of_xlate(struct device *dev,
-			       struct of_phandle_args *args)
-{
-	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
-	struct tegra_mc *mc = platform_get_drvdata(iommu_pdev);
-	u32 id = args->args[0];
-
-	/*
-	 * Note: we are here releasing the reference of &iommu_pdev->dev, which
-	 * is mc->dev. Although some functions in tegra_smmu_ops may keep using
-	 * its private data beyond this point, it's still safe to do so because
-	 * the SMMU parent device is the same as the MC, so the reference count
-	 * isn't strictly necessary.
-	 */
-	put_device(&iommu_pdev->dev);
-
-	dev_iommu_priv_set(dev, mc->smmu);
-
-	return iommu_fwspec_add_ids(dev, &id, 1);
-}
-
 static int tegra_smmu_def_domain_type(struct device *dev)
 {
 	/*
@@ -991,11 +930,11 @@ static int tegra_smmu_def_domain_type(struct device *dev)
 
 static bool tegra_smmu_get_stream_id(struct device *dev, u32 *stream_id)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
 
-	if (fwspec->num_ids != 1)
+	if (smmu_device->num_ids != 1)
 		return false;
-	*stream_id = fwspec->ids[0] & 0xffff;
+	*stream_id = smmu_device->ids[0] & 0xffff;
 	return true;
 }
 
@@ -1003,9 +942,10 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.identity_domain = &tegra_smmu_identity_domain,
 	.def_domain_type = &tegra_smmu_def_domain_type,
 	.domain_alloc_paging = tegra_smmu_domain_alloc_paging,
-	.probe_device = tegra_smmu_probe_device,
+	.probe_device_pinf = tegra_smmu_probe_device,
+	.release_device = tegra_smmu_release_device,
 	.device_group = tegra_smmu_device_group,
-	.of_xlate = tegra_smmu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.tegra_dev_iommu_get_stream_id = tegra_smmu_get_stream_id,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.42.0


