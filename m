Return-Path: <linux-acpi+bounces-478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6697BBCDE
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD30E1C202E7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F5028E03
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aO5R1PFZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1427720
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 15:36:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D14FB9;
	Fri,  6 Oct 2023 08:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYFaIc+AS6WNpzHTATnxQxE2Itoy+y26JZo0xI4tmmVWp5RoVTo/+mASHW1VIcMgNAZU91oT24PP3wM2kT+K+95JakpWnRkbLseM1YjQxJP5CqmV/1Esc+ZaeslBR0gyX5BuRMCNXRa+TDz+nnuNgN3padSmv0TAk3uOuoJCEit7klsZgF3Lin498S0Lz2G6Bfz3q5b++ajUnwfFmzCrOGYTbTW3Jlvp2ZbapL9X52pJsbWdD85nPEVj0pnBBbm07c000yZmcQ5+XQW8QZN5FwyY1PKHTchI+kVfzZ7Bkzlrti5XfsW6dlTQ0iFlKd2n6ufQdi4SVn2Sn2VRCNoyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpUzc01CtR0FJ7te3EQlmI22h6FVe43zjYPuGst5XsQ=;
 b=LkVUklv9G5nrQk+FbzgBYXi0S5+gvjYI6gP9YTccXHt6q8MLgwPOqut+jWaPwvf4OQ+F+mGAYBirwVeMn7BtmmtUrwi37ZE8LJ07tkEh9QVPfSerUP5I9+jNkb6wv1RS1BmAYmsC3+7lPDUdaKuXODL2ev0D8awUdhdQcTFo/9LZqTormctKwgHKDS45BeaPj2J1H+ncKen/NS6qFQk+n708CtXul8CU34R4VTEg2mQpfcW4+zsGrmQ/DxVroIXevcJKK5Dda88S34W5C87q4pM8T677R8XhvQgBmIUPB9cq0/8GjYeQ701+zYPphpvIKBFJLpUBpJ2HZDc2lkWMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpUzc01CtR0FJ7te3EQlmI22h6FVe43zjYPuGst5XsQ=;
 b=aO5R1PFZNchgtGfEq3dxvBwqF7Z0Xx6T/d3k61QgelY7etQoyYz12bYO2KJzs94P3bdUW6opTl7H8UQEH2tP7A0oHeUIg1hDDQeuVEjAfbgdyJEMMTP8fDC46JhUPhRdiMQhYzmVgYFIvm919qRDuLv66ym6TNSHMOwNHWQ8nI6eHth586xS0xeApgiPvcgUyE2XFVHvo3ukdGjbETnl/uFxE8UpLddyT0DAxp8ZD+1XjTN7yULixXcmDE0Rb8E6B0Got/2lZcjRYdQHyPvxEc6/z9hvAeKZl5BulCcBedB+DW3DHcU9gXN+skUfbn6VnotK0HsYDDNhhnRRaF1BCQ==
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by SJ0PR12MB5455.namprd12.prod.outlook.com (2603:10b6:a03:3ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Fri, 6 Oct
 2023 15:36:51 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::5) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33 via Frontend
 Transport; Fri, 6 Oct 2023 15:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 15:36:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 08:36:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 6 Oct 2023 08:36:36 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 6 Oct 2023 08:36:33 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
	<srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v3 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
Date: Fri, 6 Oct 2023 21:06:12 +0530
Message-ID: <20231006153612.5851-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231006153612.5851-1-sumitg@nvidia.com>
References: <20231006153612.5851-1-sumitg@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ0PR12MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ff46d9-8fdc-46fa-2115-08dbc6820f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8JZTbTCdhRNVI9J6zIUgLt4j+xqCaC3O7xbaD5r5ZtMm8tHTUuEnIjUExi3DEAwDvhr7DLDpHBoyNRKpZvGd9jDKMnTUXNFfbx+Tq5rG5pg1xXUG4QpG+ffNESKxlfE0QmI9W6ifaUB5Er/WSXShAdYIvEF6cwKQAjSVilcSCqp+RhMaAQl8j5162Ak/XOp1TcDcKtELIfKJYm8m2qZSGE9mwBK9424+29VSREzF+K+ibg+RyyYiHzgmlC6ztXYaNfkkiuUezTKGg3+/z88VnXNBKviV84IC/N3kLSzAvVVlprFw/YvNe37FJghSjyPdk3mPDvjFIHl1+5PMWhs6Q3D1evjRDTUHPCJ3NaRAM6aCUezv99N7+rxzC5n13keTZGhdNaWZGRYgftfkNtiEUvCx4Bn2lbp6EibKhy2gdSDBUkgCNKnna941kx8jN+wEfIGbTvv/5WmGa79/tAwuJ7HNaioOChn0PxvHzSdDhHlhCbTd6DFW4SWVRyBlWEAJYItXAcZSjEsdr0BUcb34VvAq3AagZTRWjLEZM2t2wvJkoyOmI1kjaIEyb6av0EBv6kVN4N/Chqq+u5j1BsvaJ7LZjNDvUubLkPNNYwudnGLNG7lBEJWj9R6gdvG7oWjIPEaeW4uS6GdvH2Nd5L5g2kQ4PSVPZGjPGHWc2GjW2Frv4A/wQ244ii1thoPUciTuou0H5XBwmr/TlB6HAwz3s0Df9oDtVC7eJIKoIDXyLFCptMvxTRxjoG2ByxmMFBMb4wFDL3kPN9ygo7KqYLq9Yg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(6666004)(478600001)(83380400001)(36860700001)(47076005)(1076003)(26005)(40460700003)(426003)(40480700001)(336012)(356005)(7636003)(82740400003)(7696005)(86362001)(2906002)(4326008)(5660300002)(36756003)(8936002)(110136005)(8676002)(41300700001)(70586007)(54906003)(70206006)(2616005)(316002)(107886003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 15:36:50.5812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ff46d9-8fdc-46fa-2115-08dbc6820f4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Srikar Srimath Tirumala <srikars@nvidia.com>

Current implementation of processor_thermal performs software throttling
in fixed steps of "20%" which can be too coarse for some platforms.
We observed some performance gain after reducing the throttle percentage.
Change the CPUFREQ thermal reduction percentage and maximum thermal steps
to be configurable. Also, update the default values of both for Nvidia
Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
and accordingly the maximum number of thermal steps are increased as they
are derived from the reduction percentage.

Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/processor_thermal.c | 43 +++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index b7c6287eccca..677ba8bc3fbc 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -26,7 +26,16 @@
  */
 
 #define CPUFREQ_THERMAL_MIN_STEP 0
-#define CPUFREQ_THERMAL_MAX_STEP 3
+
+static int cpufreq_thermal_max_step __read_mostly = 3;
+
+/*
+ * Minimum throttle percentage for processor_thermal cooling device.
+ * The processor_thermal driver uses it to calculate the percentage amount by
+ * which cpu frequency must be reduced for each cooling state. This is also used
+ * to calculate the maximum number of throttling steps or cooling states.
+ */
+static int cpufreq_thermal_pctg __read_mostly = 20;
 
 static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
 
@@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
 
-	return CPUFREQ_THERMAL_MAX_STEP;
+	return cpufreq_thermal_max_step;
 }
 
 static int cpufreq_get_cur_state(unsigned int cpu)
@@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 		if (!policy)
 			return -EINVAL;
 
-		max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
+		max_freq = (policy->cpuinfo.max_freq *
+			    (100 - reduction_pctg(i) * cpufreq_thermal_pctg)) / 100;
 
 		cpufreq_cpu_put(policy);
 
@@ -126,10 +136,37 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+#define SMCCC_SOC_ID_T241	0x036b0241
+
+static void acpi_thermal_cpufreq_config_nvidia(void)
+{
+	s32 soc_id = arm_smccc_get_soc_id_version();
+
+	/* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
+	if (soc_id < 0 || soc_id != SMCCC_SOC_ID_T241)
+		return;
+
+	/* Reduce the CPUFREQ Thermal reduction percentage to 5% */
+	cpufreq_thermal_pctg = 5;
+
+	/*
+	 * Derive the MAX_STEP from minimum throttle percentage so that the reduction
+	 * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
+	 * the CPU performance doesn't become 0.
+	 */
+	cpufreq_thermal_max_step = (100 / cpufreq_thermal_pctg) - 1;
+}
+#else
+static inline void acpi_thermal_cpufreq_config_nvidia(void) {}
+#endif
+
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu;
 
+	acpi_thermal_cpufreq_config_nvidia();
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
-- 
2.17.1


