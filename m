Return-Path: <linux-acpi+bounces-2867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD982DE61
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 18:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB024280CE4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9118041;
	Mon, 15 Jan 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q9jTaIE9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD917C91;
	Mon, 15 Jan 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiANAB8l0Y5krQ/BJc5jmtGV323UBtfRBPJWDSO9rEOh+FTqWnrCxmRZQi5yl/u8SicMz/MkDQK9ldIBYTnQM1R4iECkOSihdLzfPweQ95CCcMWBqUm9JFFdAwqIcAFaluAptA6np+psMxvewORI/s7G/U3GQ2xJJj2bE1i9xCKshz287BV65r92sdjKCTIBKpfqheAAjJNpizA6rYhaFtMVA0RqjIxqzlAdPAoaBVqkznrT0EbTMLgmsF2cINmicG+o2s1tr5hyBzdMWLFghWr/BWnEFqv/J2gJ3AO1b4yqJws3laRFJfi1cRFjhL0kdoTHAf45SJLdAgUumMGrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJyjJYbCMD2x8Xb2JmY1Wencn+Zl2nLMRH1pGy0ldVU=;
 b=lvfR83RkELlfhuCToFlqFHLQU29berxSiksJFXd+AXEpKzLL8YIrfdJ8EXwq6CwWgVCgmpKErY3eHkTcaRTSudO0Bg/bT+yl2MGJSj2Cnv6+YHh26sX0MEKmOQ+i4kSmVBP/xZ90BbrZeLWbbUwDZxK7ifTjWLotAqA5Jqv0PggQN35OAczlJdET6QUjrv5FhteTdnjSGUH4vPVLDmKskUmMJCMpImcU8mk6fHLxB2Rp5nU/uPvtVPO7GSicXRPoKdSxBqZuZZg/raQN23MA+p/DD36mFD+g3BZPVkh8xZq6zzzmwXA6xhUF79guPo1RszfuaQv57S9roSOarnLE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJyjJYbCMD2x8Xb2JmY1Wencn+Zl2nLMRH1pGy0ldVU=;
 b=Q9jTaIE9XBonv9EGBWEMU58TLmYnf4cFBXmUdqQUZfl1R95frEiewXivtVkN7rpaocAOJ50DetXD9rzoIFQoww2Cadi1+eyXyDH/ufbwQK1G/uIGUe32w9tah/qq6gyu1gw4CBMTjDdW0kHaIwWmHtrgdVCMyXTnEdcy9InrL9o=
Received: from MN2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:208:120::21)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 17:21:23 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::f5) by MN2PR10CA0008.outlook.office365.com
 (2603:10b6:208:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 17:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 17:21:23 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 15 Jan 2024 11:21:20 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v9 3/5] EINJ: Migrate to a platform driver
Date: Mon, 15 Jan 2024 11:20:05 -0600
Message-ID: <20240115172007.309547-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 304e2bd4-9343-4c8a-73cc-08dc15ee65ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L0aGiq2OcxtMYbaCt0nat4pghH9LIetkCCY87K2c2a5iDaiiOX8rGMUpP0UfdKfQmyqOz5XFpEnu5kzNoOKnu+8B7HEs8mqpobIb9dRxCeKgRG/hq9Gm9HB+wQOA3jkpuIglWOyrxXNx6Oia+e4kXsvot8FFMJgCkTrgxLlTrWwL9S/veBunYhM4PfDBUtMNCFdkoJdJ1ot7KEnxnMvShijKtnXcuXDe/Vqz8rYMBtcAD8KCBS+gWg5bEFsUhar3Yab8CTNLHziN0O7vbEHUR1qDgxHV7yfJP9RG2sH/Q8Ceo138MBkIQeOzMLGh3xJgMMFYONoSaX996cFcs4OujmRBrd4diquCQsRFsk9T2MPVfKg+89/VzGxHzH09xTReDDhuHEST/2IVr6TXeu25f42+pJ7T4ieZoWOW4+TgK1/pLf1jmIOLm2zYsKMP8VlMRAzQ1IB9x72QYAeyFfFSb4ZXU9cMCE2rMcyHYNgxTTxbifmV7JcQhuSLZuZFxBOBU+AU8V+lm5AshfX1HTudDRCw6ZotafWVsI8Y2Qpinnc52XzyVM8p+ySTQrSQ4Fv8/ECy13UDjbf57R4tzZ/McQSbhwirsYCmIw/sv2dpMpuL5abcOhTi1pslZ5MhGTaOOBS5LkwRnvLoTdnexpn2hwTsrOnfwdFJWm4wkzvIsTA5Y4lDl221pB7FbFrT7iJaMy/OiWTQKPepFgsA+nO1VkLpUyTwu4V/ROKkdRc8NuBIihHJQg1xHmcqa5i1CHzgApXmlCS7t86Zkc8AqrKJ3/Pp7ULz2UpzW/is+BEr24QwPsFPHoStPRILvjI2stmp8m4IIRRQVwQ2jpKetzJdHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(336012)(26005)(1076003)(426003)(47076005)(7696005)(6666004)(36860700001)(16526019)(2616005)(5660300002)(8676002)(4326008)(8936002)(41300700001)(7416002)(2906002)(478600001)(54906003)(70586007)(316002)(70206006)(110136005)(86362001)(36756003)(82740400003)(81166007)(356005)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:21:23.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304e2bd4-9343-4c8a-73cc-08dc15ee65ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083

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
 drivers/acpi/apei/einj.c | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..10d51cd73fa4 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,6 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/platform_device.h>
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
@@ -136,6 +137,12 @@ static struct apei_exec_ins_type einj_ins_type[] = {
  */
 static DEFINE_MUTEX(einj_mutex);
 
+/*
+ * Functions called from dependent modules should check this variable
+ * before using any EINJ functionality.
+ */
+static bool einj_initialized;
+
 static void *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
@@ -684,7 +691,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
-static int __init einj_init(void)
+static int einj_probe(struct platform_device *pdev)
 {
 	int rc;
 	acpi_status status;
@@ -782,7 +789,7 @@ static int __init einj_init(void)
 	return rc;
 }
 
-static void __exit einj_exit(void)
+static void einj_remove(struct platform_device *pdev)
 {
 	struct apei_exec_context ctx;
 
@@ -801,6 +808,38 @@ static void __exit einj_exit(void)
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
+static struct platform_device *einj_dev;
+struct platform_driver einj_driver = {
+	.remove_new = einj_remove,
+	.driver = {
+		.name = "einj",
+	},
+};
+
+static int __init einj_init(void)
+{
+	struct platform_device_info einj_dev_info = {
+		.name = "einj",
+		.id = -1,
+	};
+
+	einj_dev = platform_device_register_full(&einj_dev_info);
+	einj_initialized = !platform_driver_probe(&einj_driver, einj_probe);
+
+	if (!(einj_initialized || IS_ERR_OR_NULL(einj_dev)))
+		platform_device_del(einj_dev);
+
+	return 0;
+}
+
+static void __exit einj_exit(void)
+{
+	if (einj_initialized) {
+		platform_driver_unregister(&einj_driver);
+		platform_device_del(einj_dev);
+	}
+}
+
 module_init(einj_init);
 module_exit(einj_exit);
 
-- 
2.34.1


