Return-Path: <linux-acpi+bounces-4248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A039B878193
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167751F2425B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBA3FBBB;
	Mon, 11 Mar 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZZVqabQS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B03FE23;
	Mon, 11 Mar 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167147; cv=fail; b=oniv86J8vXi/WtEmpn5yaq+RbYWyICGyUkeStAbifiM2IdEShGh3AhdVKSQBqYUDEbMSrE0kcrzBgYvm5/t4IUNOnO2SUWuizUOq5PNpSOkD3bfcQZV73OXzAzbDv9KbjUPMTPdx2b5ngP0e85aKq5VwYxdhV8Sxy5Sg6DR5XbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167147; c=relaxed/simple;
	bh=sFGwGwu5MQGwMP+3oOQzkUnb/byrGrkWfJaqi+5lKpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5xgyUjnpd5TSDJWfuVI53i7F+SLOPw4EkxS393ch8QE/dIfcxBT9kzjYkyJz1KOK003KKUEghv9KuafAe5H2MDCnjBGpKhcLL7zzICEUmjWgFmYN37fRf8N8kfnU51dNwrYXm/PP7l7jcXzlnEEbUzQcmXA0z/kYSlIAZXZk3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZZVqabQS; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuNj7z/qMpSBWlp21JCusmn8uxfLkXYxerGLUESV3hvUpRY772wH/U06GKWgKW0aZwk7zV6ATQLM4uN01X+tYQsnxnHlnGLJZuDDA3P1q6XcetfX3BX++q4iVoKSNg3uHGzNgYollRe39/tLHHTNNsNZZjO6BO2k0LiEoGB4+R/ctaZ35JJ8wAjPe3YAqaTVFrxzQI/SjdPvHJDTgll0W2lNRtPtTHuaDGFrUphnB1w2vo2I4jRDGey3d636VxbMTHdipUhSX69wl/vtT2X8POIXDPSXLwBwoVJY1yE5Vpn+lYpW1NAQOobQZLwVd7Y0eMD7CcXDQWtKsTcI1lvDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+KyVWWjsLAqYd3gMPBtA8GJc0YoJPaq66WclNHHAGs=;
 b=moAe810sqYbzCa744Y2Eg129qN14SzCJL0ilyDAsIgAVxA0Xj2SxABbgBE11wEHXQ03KOMk0Yzs7rsoEboba6ELa09EGea0yZHHSGuVz1slDH/dPJHyn16qs8uq+JTH04SNT+uMek4GchPP1NC0lMKxO2qUawH+4wmljAl0wYh1/c1WemZbF4jk4og58CaVg0UCVr0TldyDVZxxsO/HwLW+cv7nkp3UD9oHMc77FHf0JbOiXoBYTDmCu8CCd8f8loWqzWDuUKEzo+z6PqBidYPnEUPO3p9gYZPZyhzGn1HmPeRtj6pvD2TTLawTHdMgJksZh5r6MTn1WA9LCnUjyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+KyVWWjsLAqYd3gMPBtA8GJc0YoJPaq66WclNHHAGs=;
 b=ZZVqabQSoZKDAzt1BxQebzJgp891p5ZwVD0hRNKDeCw1Yo6fu9mPeYJJ8FydMpw52UtnQ2+RFzd82jESxNVTPDGhkG5hPg0nCx2/ILWjZk6oZfRIGzRwafP5h3E/thy24CYuveZjlsgM8KaXiFUBwhFPEi2EwGH0yL7JdZMJMwI=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:25:43 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::e9) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 14:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 14:25:42 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 09:25:39 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v15 1/4] EINJ: Migrate to a platform driver
Date: Mon, 11 Mar 2024 09:25:05 -0500
Message-ID: <20240311142508.31717-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: ea22b7ac-147a-4b36-9abe-08dc41d72249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oaDujucjVI24kq+JJSN8X9pI3JydsZDYR/Vd7oTxiUxMnKZdBluJtxhsReiJ3vJLNWTV3tbbNEaUCIgo5vu/uVXpj9PA/abrerZazczacMzG98CZre4RmAG7aOiEG8EWpBdJ3Glg5A41CSby/oFxG2JC4F7qJi90dTMbXRLLrcwDbpbbTR/q7GbeJmFbpVtcffGlj7WK//Bu2bhg2ZJGZoMmC+n4vGf10v2oaTe8CY7kDUAmvEtdIchf/MBKR79XjbRJfr19iKal/FdRvrMhAfeg5mrOwR7buMvu27Uydr4nnF/AHCPN50codXtj6kOZw1NXdQf3jPxm/7hkI3QxGEwuZ3+ksMTn1+idA0V5ojlAlkHpY4ufeS9hvmEIEi16TlB38Snd4TJdzvfENIqugbn82SWhkj/P+7fSK5hQoocpCg1nMU1bZ6BdRdVP8Z+xV4f8kaciQf5VprItGTxHKZBPcPdFIDHSPimV7MTWm0THbcnY9ryEWzHFdC/lO+AMwBs9kU7u5TDs/hP2/gD7aKvyOFWAe3KtgfXKb7MaP9D6NIRqwl37RrlLhbWh/3L7Kg9mnkeqf4N/jB+gVwutRCLQTQMNU+F01QabxxRVE8MuTjg2j2Tce57I9i6+ze2HYXDB7cVdYncmcdrX3FYjBGToZQcY+bbYMIcyVVuNJSStycykTnQ67sAdC/4rmu7RjdSXsafpqVBTjT3xIKZFxZuC+hswkJMUEE6vhD3D+cJ/IE42o68oBetI6K4zYzhc
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:25:42.8322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea22b7ac-147a-4b36-9abe-08dc41d72249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

Change the EINJ module to install a platform device/driver on module
init and move the module init() and exit() functions to driver probe and
remove. This change allows the EINJ module to load regardless of whether
setting up EINJ succeeds, which allows dependent modules to still load
(i.e. the CXL core).

Since EINJ may no longer be initialized when the module loads, any
functions that are called from dependent/external modules should
safegaurd against the case EINJ didn't load.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 48 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 89fb9331c611..937c69844dac 100644
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
@@ -703,21 +709,21 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
-static int __init einj_init(void)
+static int __init einj_probe(struct platform_device *pdev)
 {
 	int rc;
 	acpi_status status;
 	struct apei_exec_context ctx;
 
 	if (acpi_disabled) {
-		pr_info("ACPI disabled.\n");
+		pr_debug("ACPI disabled.\n");
 		return -ENODEV;
 	}
 
 	status = acpi_get_table(ACPI_SIG_EINJ, 0,
 				(struct acpi_table_header **)&einj_tab);
 	if (status == AE_NOT_FOUND) {
-		pr_warn("EINJ table not found.\n");
+		pr_debug("EINJ table not found.\n");
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
+static struct platform_driver einj_driver = {
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
+	if (IS_ERR(einj_dev))
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


