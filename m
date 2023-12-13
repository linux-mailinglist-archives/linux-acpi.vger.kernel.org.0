Return-Path: <linux-acpi+bounces-2412-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B18812194
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 23:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B92282733
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D678182C;
	Wed, 13 Dec 2023 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YKBEB0X7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B177EB7;
	Wed, 13 Dec 2023 14:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOGTtzGB5PcImjAaeS6VmNYu3NmHKY4/ly2j3VAOi+HcmJmA6HF21qpdUu3rTTPNVx8KISIXqEV42rb3Naqa5ywkpxnPMO2CGBz3FbG/HrGFlaPhlt2X8QwgPrNtdWpiizm3IfpPPJC3wAEEQLV1OhuR/04wyOGSEu36VEi2JDoONYWimc2uF6Arm7pdqzGjIZFPlw1H5/efqT077O3smFbLovhk9u+A9qjsU6nyWsAe7n/fss5xNM1ITL55nvXP1+BP5ncZf7r74HN1JUZwz2f1DrbidDB9r/zMEQ+xIGZE5AaFzNBgbaQmewpir7+p6n0zhNER7IHjmqWu5zl97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGCosEJlZsZ9F9LSEHMlNH+Z2wh9CZVnjMMztYZq3dY=;
 b=nvxigRDnsE0/WxxfpcM9rJj/LGedMGbDINk0zYHqXTGiUdxY/zqBUVT+O/MksJ2wIai/GSXIBvUUcxfUumv+fM0a5q9vHZlk8Ol3j1G9ZCILP/TtImqcgN1hIoqwkpJUSc90TkXqNo7IZ05LmAfoGZ9UMYmRLqarIz98acMXrVvGEI7dcYh0yg/WG0H//vJ7sW/2BfV8W05WzAqgSCr6kIxQQX7mVRwgsLYcdWmPIhqBF26sr7OyV8gu/bXrbGCFyuMrEPRXV1DWmrPom5Q5ASRtg21HZkVz8TIvFow6IIeta6B3++bkfH+mLpW5v6jXL8BttfZP0bLDLxzvwRe+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGCosEJlZsZ9F9LSEHMlNH+Z2wh9CZVnjMMztYZq3dY=;
 b=YKBEB0X7A34+iY20rTAmYBfnV0ltrVMKon3E4L7HuCKoThdyb3/c0eo5eXjiMZLQ9/LyTLwrZ/iKNKZnA4sLk0+J8V0cyPH0sIh7eRYKuaNuLGjMGc9SOlTrGAds4bk1v/Q9vjE7TTTV0NHtykv9rZiYvmkckczf3gfvMOVa4MA=
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 22:37:44 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::98) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 22:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 22:37:43 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 16:37:40 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v8 2/5] ACPI, APEI, EINJ: Add wrapper __init function
Date: Wed, 13 Dec 2023 16:36:59 -0600
Message-ID: <20231213223702.543419-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 026c98ec-9d0e-4f2b-d980-08dbfc2c1f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sTuds1FUjtmXMt0EDqYMODiHyaEOwdLJBngEH7Z3lP1yf1hRktp58yDsb5OT3CLGmfkpZducBlvEH/Vrha7zKuX2utjaH6w1Gh0TGBpNAxH2V+ghPUGySwK0WJfVJ2t1lSv1fJA1nNcMiPRdSuNo0XhdbiSZRZHRyoC0AdGXUcMDa1aghRVNsi1cwb+AaqdFnmvdA52NNZCBhgZK9kPlo+/iDg//SngRX+x/NvqLyHnXbbvKrJLC1dVybJLZS+7pDDlx3GA5L2xTrdesLfzKTGsX/tNixaHeX3+FaWmHuq3+EGi4wclwmabGyvnM5anI7Yv2XZ3kIUUK7ispKZ1RrCRgrvhrFfotqaqT4fZu1G4a/2sq3coOoya55PQBXybOhYFvuDakOZh6nhiuv9s6TZIB5FDpvgniGeknwAH68oeNISsx0gTCxwpL3YWHLjLpgaJXDuACk/ycPFblN+SXAPP0o7FiSvjAF/2aoJEmj5VjuD4xqnEo6Hf8A2AJG3CopDnhw/1Vbm8ihVEo2CfuiUIBx+1KKgep/Ll5ggR7tgcE5x8rZCAdSzF5I7Ll1pYww32hjXewovNxFA/AStH+XF3Ppq6Y7GSmb+9R6qPFT9AeuL/ZjetTSrIa/Uede/e5zpSefel+f1/95BU1t3UtQINyvsP36MDWSVjoPBTLitc/ej0q4ORKBPLy3mJv5/50zfiwetwBuLOLUeA3JbkQQUgy1UtWHMEfi+7IZ+XNY3I0RDUr1pVYDN3nHwNg3BRflDY+s0e9bCcmzh6fPijX+MkVlch3UavMlPcbdXAocT8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(7416002)(2906002)(40460700003)(86362001)(4326008)(8676002)(8936002)(316002)(5660300002)(41300700001)(36756003)(478600001)(36860700001)(426003)(16526019)(40480700001)(2616005)(1076003)(336012)(26005)(6666004)(356005)(47076005)(82740400003)(81166007)(7696005)(83380400001)(110136005)(70206006)(70586007)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:37:43.5929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026c98ec-9d0e-4f2b-d980-08dbfc2c1f46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051

The CXL core module should be able to load regardless of whether the
EINJ module initializes correctly. Instead of porting the EINJ module to
a library module, add a wrapper __init function around einj_init() to
pin the EINJ module even if it does not initialize correctly. This
should be fine since the EINJ module is only ever unloaded manually.

One note: since the CXL core will be calling into the EINJ module
directly, even though it may not have initialized, all CXL helper
functions *have* to check if the EINJ module is initialized before
doing any work.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..26a887d2a5cd 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -615,6 +615,8 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
+static bool einj_initialized;
+
 static int error_type_get(void *data, u64 *val)
 {
 	*val = error_type;
@@ -684,7 +686,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
-static int __init einj_init(void)
+static int __init __einj_init(void)
 {
 	int rc;
 	acpi_status status;
@@ -782,10 +784,31 @@ static int __init einj_init(void)
 	return rc;
 }
 
+static int __init einj_init(void)
+{
+	int rc = __einj_init();
+
+	einj_initialized = (rc == 0);
+
+	/*
+	 * CXL needs to be able to link and call its EINJ helpers
+	 * regardless of whether the EINJ table is present and initialized
+	 * correctly. CXL helpers check @einj_initialized before
+	 * doing any work.
+	 */
+	if (IS_ENABLED(CONFIG_CXL_EINJ))
+		return 0;
+
+	return rc;
+}
+
 static void __exit einj_exit(void)
 {
 	struct apei_exec_context ctx;
 
+	if (!einj_initialized)
+		return;
+
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
 			sizeof(struct set_error_type_with_address) :
-- 
2.34.1


