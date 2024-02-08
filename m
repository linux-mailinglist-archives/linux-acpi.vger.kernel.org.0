Return-Path: <linux-acpi+bounces-3306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C784E93E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 21:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520DA1C21AC3
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041F538395;
	Thu,  8 Feb 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CJLQjRny"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FC38384;
	Thu,  8 Feb 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422483; cv=fail; b=aQNFQl/Ij94Gm3uj15kie+S2/MgFBzdB1ZyWXDEhztMn23wFRKPsbOlSK9VAquBNXmo/VaW6ZA6+nOIo3OjdKFuKSAEzYvudm1Cca8o/dDlZ30Pniu1g2DI+8eLLHNLxI9jtxFdW9jvTCH+n1jo/10guvyewXemMpF34kQ6wzNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422483; c=relaxed/simple;
	bh=aW5eIXAX1w7tS76EAB40NyxtptHQtMhlSs9hkvp7gRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reBnYJRTijYb6kbZ0nQTEbVv6p3vraGDK1FPuqC6dMAyDskPG6qk9Jfe2izgu1E+OqTvqkz62qS5b03GkqiQ3PAblilb2Qn1x60da+Npd4kxcfB5tfbEuuQj79mMCyuX17nCdI2V9pu4GLGIDE4Nym66s7GDPpYdD8vUn+56JB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CJLQjRny; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxjDaKVKqlgT0XTjgmps8aC1rq+9seRuSSL/H/WERJa/QRtq6D/OX+dnc+NaT/AP7hRtqE6BjgAgJOE2Tp497BzmM5wd6PX891vyEA15WUKBH8hYUSZ+Z5ZJ0/wgB5j3zNQgW+jP/zQEE9guj64fqg+tjo7c6cpupYRdcmESpmWLaDR4ETiPPkDQmA3eUlloSSOWmZhJkRxgrw3cUHd7Rolou+dR/1aJ8kd2seRwlrrfGbUQvisVpI87nqT+rYDXqWwTxkVoHzLvOgx2K3hk62/gliQSHLSMcVQDr9clpdZivJYbx9g3+gZhDlrQAvEl1hBT1/TBCH+DHMkBgWHB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91x3nv/rdM1PcgpsJvnF85Li/f7Wils1B7tOq2o+4gQ=;
 b=nmCLufNim8SVz5pIeNdicdHTxY6p39JIrB+aHHqxAqqrl7dnkgcrrCLGyPGdkQFuCb2NRvY4yIBgj1mU1wKlYF9zntLUgjzlUN17g3mVOd5KKtxVJD3BGDL7wdkNmjjds/mtWyTCJXgVVFgxpV8ViebXfe1DshZlOdMFtyorfRvzeGQUw8MKUpDVifh3OY5MhLGG/3lM8GOd1OFHpK6vG2ERqN9aZxrKOTrSbsJ9UNsLD6So3v7y0WcWwovovaQ4rep01NaAxZu1GQFRPTkSmiMTlR9e7QNtidJBzAnGbGvisLy69C60OBE6GI+Cog6a32yA7RPJumgedPJhRX0azg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91x3nv/rdM1PcgpsJvnF85Li/f7Wils1B7tOq2o+4gQ=;
 b=CJLQjRnygHNt8JDM07ABwWe+RyOpktUqS5xOG+hrPbg7ZxgMWFO1fKyx4EFnPba003VOOzErh5K2iOx5DMd4uCjQS5eq00REckEpAssv3wMEPsTQZWg6W4hM/woUzNPDosoCiRHWZUFYBDAy4ENKURUeP0jn+PJ4GmKjW+hZLZQ=
Received: from DS7PR03CA0146.namprd03.prod.outlook.com (2603:10b6:5:3b4::31)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 20:01:16 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::8) by DS7PR03CA0146.outlook.office365.com
 (2603:10b6:5:3b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Thu, 8 Feb 2024 20:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:01:15 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 8 Feb 2024 14:01:14 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v11 2/4] EINJ: Migrate to a platform driver
Date: Thu, 8 Feb 2024 14:00:40 -0600
Message-ID: <20240208200042.432958-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 384d5824-6c78-4499-e068-08dc28e0b540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4HLZn/p7uT4hO/MjVrzUG2uj7roMIl/Ee4RUnaDOlegisMBaPqH5r66l7TdlAkImKwFFUWNtOEjOu/JIjCBA2a0g0PHz+BUmmqImN1bNIstCVBt6KwtTHjWski4Wc/VjfgFTJ5tVK0LRChIKqWZh5qb2iLNZYr9OTVKNBlxXMUoEVOgr6p4bj/7mEsStIPXO+kcNKxHbN34Lkx18U/lAW2d+pruTvT2nfzlYzYGG7vZFnXP0B9Zfcf8peGdmVrKhzOlvbkAk2pmupe1IL96R9+cRsdlUyCYQ8465zKnIISYMnIMX0rg7T04uPij5tPq8aJD6RON5YgLan0fcoy2/Xl7ywbb/6maWU8gIzcw3r53lf+znRrnhwLpakFUg8M/2V+EqsSEWJdKby0Txr/TCKSVV4fI9ztRk4t1j4T8v9YiiKXLkxRYy5ZKI47Jzu4q91QZzIq9Yx5MH5BylgAwqSeqkk649lrZBKxbyZTGV+NLKRj89Le4dIGs63DsjOFgoS0PhSBzr2St4WWmJ6Aqr5DPlDZwqNqMTM5kpqiQ9OcGiV0pnwP3BqHCaoNubwQHavXzzIHlH1329QFv44SaJYl2/ZbjaOewRJSNLzKGymQM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(230273577357003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(356005)(83380400001)(8676002)(316002)(70586007)(54906003)(70206006)(110136005)(4326008)(8936002)(82740400003)(7416002)(41300700001)(5660300002)(36756003)(6666004)(86362001)(2906002)(7696005)(478600001)(1076003)(26005)(2616005)(336012)(81166007)(426003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:01:15.7387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384d5824-6c78-4499-e068-08dc28e0b540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790

Change the EINJ module to install a platform device/driver on module
init and move the module init() and exit() functions to driver probe and
remove. This change allows the EINJ module to load regardless of whether
setting up EINJ succeeds, which allows dependent modules to still load
(i.e. the CXL core).

Since EINJ may no longer be initialized when the module loads, any
functions that are called from dependent/external modules should check
the einj_initialized variable before calling any EINJ functions.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 44 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..73dde21d3e89 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,6 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/platform_device.h>
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
@@ -136,6 +137,11 @@ static struct apei_exec_ins_type einj_ins_type[] = {
  */
 static DEFINE_MUTEX(einj_mutex);
 
+/*
+ * Exported APIs use this flag to exit early if einj_probe() failed.
+ */
+static bool einj_initialized __ro_after_init;
+
 static void *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
@@ -684,7 +690,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
-static int __init einj_init(void)
+static int __init einj_probe(struct platform_device *pdev)
 {
 	int rc;
 	acpi_status status;
@@ -782,7 +788,7 @@ static int __init einj_init(void)
 	return rc;
 }
 
-static void __exit einj_exit(void)
+static void __exit einj_remove(struct platform_device *pdev)
 {
 	struct apei_exec_context ctx;
 
@@ -801,6 +807,40 @@ static void __exit einj_exit(void)
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


