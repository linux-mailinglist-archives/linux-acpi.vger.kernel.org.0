Return-Path: <linux-acpi+bounces-3496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43758553A3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 21:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BC5B272FC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAE13DB8F;
	Wed, 14 Feb 2024 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E4mWmNAI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B813A888;
	Wed, 14 Feb 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941266; cv=fail; b=q4bciv1L/R0TWShFDbLs05dt4NUubC2icKAsHE3hXnKmaXym0mcP4rTFBXkZJDSiBhBsx1eWG2KfpnKmJwuKUn5R/2In25WB4b+xhG5Fd5WdIfexHUyugx4/RYPftYv8uYojF7r9JTmBN80YRbCwPQ2NdvWeFDCtQyoRviSzpWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941266; c=relaxed/simple;
	bh=C7jzfMXuRumJlb9qtDiWXKLmT3iWl9yfwv3+BtHC+9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMj07jF9QiGrK40z+eIZp7w2aPScYK1CkPcWsbYi4/P7a4DcWWdCX8T4vNh3beb6xvCYDegdKDK/V6AID+llLsJkHjG/4+YnkD8pCq6DWgPuRpMhVHgmpiwe77F60fzptw+taEW+mYNXZXup+Isdxw3QwEwaqmLsNPwPAUWUZEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E4mWmNAI; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVbl8pYUilVWxwSFDyAT7lWzVV7HHwmM+tzlJ2g/8nXYlksK3kX0cbxmb0yvMAjsQpktMF9X+XqhOoe+gipnbip9++3T3CYvCeEgpqy78OHk7SwF4W6tjx/s6FDarTbcmKQjJUTL4/2ae5oB0I7RDqB556lkQJ/guG8IoKm7A9hwkrWH1Pb4EVjxqKFxoy/fwHEODux5nDNZsNbYh2AV0TCOUUPjWqr95Zd0lZgUMp81AbZkaWFJbRrDh+RtKWIXgPOwqL+63/bsB5Vtzx5zmj+6Nx5uT1uSSLUvrIL83jeM3EhsKp4h382UXTqHjkVecZT3IVsHxkF2Zr0PoF2X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zJZHEirmr94X5XkjQx7Zx7WS1qS2xqUGwUolbIXxHc=;
 b=GkF2AyIWOecMyjiel+U/mkoHc1E+AxnE6Rc/PdHWwBOzBArCtO66otcEJLjxWKl+JcCgG7RgEc76ioskb984PCVk91H+fpsrZzYkRaXkrfmV63UV6TdPH81tz35ocSBNpzjfjJ8aQsLQ0fcSQhznoD/yJPQ6zDXU1tO3WM9iff4us6zudGsAsw+sqDEpjpdGCReD/wpqQGVOYBzfPwhyqt23al+roF37PRFQhhQUSMiBC2JS0//zcn0acKHnPuNEMmw5A+yHm94D/YFVziYuHzklv36vRMaS1Yc9YwEuPb4H5nOLMTyubXThvlNQkGnt6yIaEw6U47S4UPUa0XbGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zJZHEirmr94X5XkjQx7Zx7WS1qS2xqUGwUolbIXxHc=;
 b=E4mWmNAIxny780F9uR7XMJtjlwK21CvN0Arn7wH5w+OabgwbU+mAirCJeudf/yrmL0rl2RPJ6rdvPVD/W2bHVWm+mhgAmxKHqvyVSYyUttOklbFnS565GnLV+bB33FV/ctEVRGp3KcAIvy5rHR7PK41uG1SJtQ3crAKN7hglSUc=
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by BL0PR12MB4929.namprd12.prod.outlook.com (2603:10b6:208:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 20:07:41 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::22) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 20:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 20:07:40 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:07:37 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v12 1/3] EINJ: Migrate to a platform driver
Date: Wed, 14 Feb 2024 14:07:07 -0600
Message-ID: <20240214200709.777166-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|BL0PR12MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: f61118b2-96d3-4330-ada7-08dc2d98995e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OQ83INFBhhepbayNDRnJR0GEpq8VufVFxbiIHrgqcrMGo5AhdsNq7nNb+PB2B5BnimFlIvRJU9nwi8KDvaELp5sfTGNwepddowokSE6fF3orhyjjVv/3a03UuhwrX3bD+von111iGBL+whBzw5Q7iEy9rFjGScCV+RiVb3LOmCgcBG5Y1BKdrKXqwlRNZwnGVlnjC8qBP9Qp909LGXWPpa0P+AubcfoYgiCNKMHQ4QbxusG5FhzLUWt7MrtmMNcRRLfKJvJLr1nvTMX9ncjQRHbQw0ISEGNrPD19VqSf4upoPU1th1L5wPelIO+t63wL486bZlRjMvEO7IHSZXCvXEexX/fjMs/bjZehyhDKbHk4lGualogpAkIrgzoN5AL3XbvGMHJOxqD3ARulKFWL2+A9zlcQfdn/eANeoNI5DThYwdUBMu+MGynbv3nyU90wKbzxGt9z9aj92qtpWM8r9vkR2wUfLuo2krwW8dzym7khGFCyTMn83pfwPO3k4rYQBBCVv63/QLonBStl/0j54MdFMUaKDoshC2FbTI7OITJh+c9zwVSqHH7hSiLhCMe4I7JrTk+tqJAxjEnYZPvZ2ev48E3xpT/iuNB/xQ2ZzXw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39850400004)(346002)(396003)(376002)(230922051799003)(230273577357003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(6666004)(54906003)(316002)(110136005)(7416002)(5660300002)(2906002)(7696005)(426003)(86362001)(8676002)(8936002)(4326008)(70586007)(478600001)(41300700001)(26005)(1076003)(36756003)(2616005)(356005)(83380400001)(81166007)(70206006)(16526019)(82740400003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:07:40.9914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61118b2-96d3-4330-ada7-08dc2d98995e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4929

Change the EINJ module to install a platform device/driver on module
init and move the module init() and exit() functions to driver probe and
remove. This change allows the EINJ module to load regardless of whether
setting up EINJ succeeds, which allows dependent modules to still load
(i.e. the CXL core).

Since EINJ may no longer be initialized when the module loads, any
functions that are called from dependent/external modules should check
the einj_initialized variable before calling any EINJ functions.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 44 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 89fb9331c611..4782ae0a0832 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,6 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/platform_device.h>
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
@@ -137,6 +138,11 @@ static struct apei_exec_ins_type einj_ins_type[] = {
  */
 static DEFINE_MUTEX(einj_mutex);
 
+/*
+ * Exported APIs use this flag to exit early if einj_probe() failed.
+ */
+static bool einj_initialized __ro_after_init;
+
 static void *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
@@ -703,7 +709,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
-static int __init einj_init(void)
+static int __init einj_probe(struct platform_device *pdev)
 {
 	int rc;
 	acpi_status status;
@@ -805,7 +811,7 @@ static int __init einj_init(void)
 	return rc;
 }
 
-static void __exit einj_exit(void)
+static void __exit einj_remove(struct platform_device *pdev)
 {
 	struct apei_exec_context ctx;
 
@@ -826,6 +832,40 @@ static void __exit einj_exit(void)
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
+static struct platform_device *einj_dev;
+struct platform_driver einj_driver = {
+	.remove_new = einj_remove,
+	.driver = {
+		.name = "acpi-einj",
+	},
+};
+
+static int __init einj_init(void)
+{
+	struct platform_device_info einj_dev_info = {
+		.name = "acpi-einj",
+		.id = -1,
+	};
+	int rc;
+
+	einj_dev = platform_device_register_full(&einj_dev_info);
+	if (IS_ERR_OR_NULL(einj_dev))
+		return PTR_ERR(einj_dev);
+
+	rc = platform_driver_probe(&einj_driver, einj_probe);
+	einj_initialized = rc == 0;
+
+	return 0;
+}
+
+static void __exit einj_exit(void)
+{
+	if (einj_initialized)
+		platform_driver_unregister(&einj_driver);
+
+	platform_device_del(einj_dev);
+}
+
 module_init(einj_init);
 module_exit(einj_exit);
 
-- 
2.34.1


