Return-Path: <linux-acpi+bounces-3736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8585CA7B
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FB91F24977
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09DE152DFC;
	Tue, 20 Feb 2024 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0JG0Yf5t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66A151CCC;
	Tue, 20 Feb 2024 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467140; cv=fail; b=DQwf6olNIrlWYt72vMd31/kBzGoZxA0evJJNpxp2V4NMM/YmBi878+voXk5W61KyV+V2sQvmCgKXY3wLRu/2AW+irAnpqQy3qm7S9AbID2ZKRkBHWS5w7sYTYem3KBBx35cgPW4dj37HBjbzaXIKYJHQ1XtrAnel6jzgj+oZFcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467140; c=relaxed/simple;
	bh=bo0W7RURdjbWh2jl9SLAat3vjoTI0HvOCgUrWAT3Iiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoKK1TgxNErCYX67Kh9JcCtWB6hI7rklCrW7wYa3kOylT4xRX3p+PF9vbCyITiJjktnbgRSJ1BRS0CFiH+wbvgKrJMHGr7YJX0ctfqW/ttAv8Q9GYp9dUtwSA2KEHctEX6fGy1poTj7oyo4tanZwKaAUuSLGjLLQHHXIb1TrzFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0JG0Yf5t; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw3qnPY2MqJm5axl5HECxwBpHoGQOcb13Tse+y2MsBeIu9ywX3X+JFWuxuWamvmdufq8P39QWSGil9VGR0cfUDCKmyKFt7mUDU2rtVsLO58J/rasJRkJhxyqLwzz7vii6ko6PooTJ12gnBpZhn/TzDS3Cec1C5BDSoCKCiaGnUXOLoMSHyTUQXHwHBS4/iQ/Urf8Rkh0ciiNsT+6GSDXVm+7rkuUhD7qMAcg7SymZ0Pv/Ozsoeaz4wk2mGQ3pAsoxUvfiMqHZ6lOjC0sHzv5L0m1E6NyjpahWSZ6dyCPWCTf5P0K7b1NV8Qqr4wIM25k03NQZ6M199KAJyh0m8lYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK8uDivi4yRjU50+Lb4hnVSOoT4btSlih40OFvD8EqI=;
 b=YGr2xYIxxsS/pxY9J0rHfLE6/4u64wjiaYQVirCTePoXfMqMuqhJqIAZGHxARFl8w6yYd/iZ5w7m0UTEO0GVVpYjlkg7Xzm1hCirSTxR6qlLKu1P0PPXSNR0LydFmz6ZJ1pxv1UyOGFPX5FjasqNsbbrQ3UcKGscVePdXiuULYcc2EVO8B7HxchAEpRXIKb+DSXRjHnurK8XLtbBSJbOghnBBxYRx59J8Fv5xF5t65hFCmL4MdwgAZjRPrwg4RnI1FbRYZdsSX8DWdx4Omh4jKB1cYBvTIg7IHJG+gVtbxR2uLJKK5B0zVHSe9XhdQwwNp5y5n/nI3RMgEC94TJhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK8uDivi4yRjU50+Lb4hnVSOoT4btSlih40OFvD8EqI=;
 b=0JG0Yf5tv7Rf+RJ3PTJZ9oi9iLXOqPEgDaiU8aMlwqxCDngvx+7woGxkEA6H+WXvZ0lSshVDEDqCqVkuebRMulnLAXNqJ9tML4iRp21yFdZ4GNIiLIiphAt8Q9wMapY60mbK4GfCybtmY44GZKcbJkc70dzqmytXfmR+RGPKiCY=
Received: from SA0PR12CA0001.namprd12.prod.outlook.com (2603:10b6:806:6f::6)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 22:12:16 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::d3) by SA0PR12CA0001.outlook.office365.com
 (2603:10b6:806:6f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 22:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 22:12:15 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 16:12:13 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v13 1/4] EINJ: Migrate to a platform driver
Date: Tue, 20 Feb 2024 16:11:43 -0600
Message-ID: <20240220221146.399209-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f9b10b-65f4-4a99-7f81-08dc3260ff24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Rx8UgpqY8Q4eJSGT9KXfZwlCx4BBymNvXgiw7plRBXS/8D1CbN/Jo+dA7noiLs/bl2v3PrtaDKhqBZSjByQom8KuuNLR8G3GH2IuDlakmSME0HThFiivsGeM3np45WAUch+oGN3wPF8MyQDxNwOXoXI8+HxSbn01zRLRMmkbP+xEFreLd7dIrvrDXNkRADpK2UUJoK15YmN76Jsga28DE+cJk67IqwfrrqSCK6/2buFQ05tBGkfLv4QpQlHieIo51mr66xRCt1j+vGuD/oxCiTCiVR3KcOGh7xLrOBi2dHf5NUmxLR65AzZSfkPvf6GWSuDJoMY3yGxi08DSBxRJK9Z0iQVgA0OJ64J55gUMl/E+0X+wmkPMRqyVoPrZ6Vr2SZ3IdjtIglh+wtKgTvcY71QFHUG8QZ2EjMHo+W8pR29wqq0+Yh9b/103+ekxJKMSxMV2eQHNMW4vOcHX6YvSQSQZVP1sfKnkznJDTW5OLpeNxgJ6o3ANsyqd7HGi6LnBdoXlxsE9tcKHIVawVSZ2KB394y6u+W33NZnIsnmo8Puc5M0xgN3aK2Gv7wqtZ4bztju+BdYCp16HFsDq741Us92MbfVMQXZ/yFHYnKIjnByf1en5guF3JPRLJn8HEyRBw4sLsLdpElQ5Ku6pX7JZhWEiNO9w+f/Zv7fzqshRsU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:12:15.7817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f9b10b-65f4-4a99-7f81-08dc3260ff24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

Change the EINJ module to install a platform device/driver on module
init and move the module init() and exit() functions to driver probe and
remove. This change allows the EINJ module to load regardless of whether
setting up EINJ succeeds, which allows dependent modules to still load
(i.e. the CXL core).

Since EINJ may no longer be initialized when the module loads, any
functions that are called from dependent/external modules should check
the einj_initialized variable before calling any EINJ functions.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 46 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 89fb9331c611..6ea323b9d8ef 100644
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
@@ -717,7 +723,7 @@ static int __init einj_init(void)
 	status = acpi_get_table(ACPI_SIG_EINJ, 0,
 				(struct acpi_table_header **)&einj_tab);
 	if (status == AE_NOT_FOUND) {
-		pr_warn("EINJ table not found.\n");
+		pr_info("EINJ table not found.\n");
 		return -ENODEV;
 	} else if (ACPI_FAILURE(status)) {
 		pr_err("Failed to get EINJ table: %s\n",
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


