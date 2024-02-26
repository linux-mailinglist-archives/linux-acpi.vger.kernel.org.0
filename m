Return-Path: <linux-acpi+bounces-3960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFBD8683B8
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 23:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E75F28BD8E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C65134732;
	Mon, 26 Feb 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHNrxI7T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80537132C2A;
	Mon, 26 Feb 2024 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986463; cv=fail; b=cfzBSxpVUVttr1uOCxFRFygld0SwVIHQ1aVgIOt8Mgoe8TRjDvDlSuh1DXEnjVIMDhTpvdm29do25MZeaWpgUfHtNbD5aqVZxM91oYxLEQEaJ/arjon9Vi817AHaZxjZOIwJBGX2rr5xAQqeeHPA4xc7AtlEd788MGb0uRhVNoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986463; c=relaxed/simple;
	bh=2hwaJ8e9qQWyGwPIKY/lKedGV/2rnKpvY1/D7E9lxig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rf9svipnJQxEIPVXx8SftMMfvtsTir2I9B+qTczJlFv9UeMANgg6qQvSGGq+aX4CRkN4dayTKvjihFw+ust16fwkpRJGJiVD9MW/mU18ap3bJy9RCyAeIrxIJ+ue4EaHISXr5mnDUuT7I8dPSBXiMnSnD8yZqKF9Db0cfI10FCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHNrxI7T; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJU6opDY+pox1zjCanBEQHs+lC9Z42FjPwKhDMsjUfIMxgJTsmFXIpw2zEvEEGi4zKcQYloKPT+Iic2vRP9MOG3IdKybwptKPgleYGWjgwYMnIQ/NjLW5qfAFcwUFvMPVWq/tB1DrXRm9Gq8Yknr31yJnLemYbsa06abGbftlddb+/4pXDs6xnoOw5O9cUaEP8u9q4yFG8ymo7BwCFxp2QLgB1Vw5Fx8j/A+NR3AED0/vd2moCGMmkQvduga0ufTA3Hu/KWbXSWeLViK1DHFss6NDuDO5CmsYnj0dQ0E7o3+F+lw1JkDQzuErO2j3W9DA7ajGG7nk3UlOSIDjGjrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBZUOZ4/q9CTxMtpNhn3kQanHJCWCdAej3tYZHaDaHs=;
 b=oS+AL8HojTC6RBTHW5wSClJ6kT7xpyOLNZVksIN66p+h5ecw42X3xCP4mdZvsYyo9DX0LvMdb1aXbkBFzx6t6UxGdhtcXlsVXBHCINxx+4xXmoTwZW1Z30TW1ia35e11nRm/mZG98mxe6oeJ+PY68R1vx1jgFhzv7m9FQJTFSfegOjI/4G7MhtMKggeJtl7RDYqcHZeauCMdFSjw9Zyk8drMEuViUkbae8amsE/L9w1Dq3A77PdLFi9qnDx3BaMn1aDxgsj7ZvM4mtGIanSljq0MH+WKjskJl8XVME7oUBeOQNECpEPiUr7HjIcIza6usbYIZfG9LEDvT23FFZtdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBZUOZ4/q9CTxMtpNhn3kQanHJCWCdAej3tYZHaDaHs=;
 b=KHNrxI7T7OPXEIwjXuO/f63TDaD8fACNNBnKtcpvMFNbqE2WwYriNwYuueiT0Y4fDdnqHzbu37NthNAjAlMwY0+2mKFGJCe9/hQxC66Qs8ywdNiuOrKegXomiJqKe18/DKBshbnilyRdgsq/fFlgtqIG8IZTJlif/bMXjtOIpTc=
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 22:27:37 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::b1) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 22:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 22:27:37 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:27:32 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v14 1/4] EINJ: Migrate to a platform driver
Date: Mon, 26 Feb 2024 16:27:01 -0600
Message-ID: <20240226222704.1079449-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MN2PR12MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fbeef9-d18c-4d7e-ca2d-08dc371a22f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HoPwtKDTDB+DUgfnFgbGq+VDFSYCXg9rhn90sNQzukM1WWzJo1xY7qmYDaFhO1ga4f+cUm1Pxcx/DQRQuIuD7MhoDJWztQAMUrQyceqIsTVGLZ0j3LHYlxuzeE8qAPpJbNWLYsYkJc+tyn7uD39GlsrHERhT78Of8vmDuTdrnYEljjUEC1vM+iK7sqPEwky8B266/X83FDe1h52jYN0fqEl0lmy5V8ytDoaHqxeuWJEFaVA4g4H0QygGerCBv7+bYkBCAESPkOadmv1YOCAWc2ZfOAaJbceYR9UINGvYKiOA+UXp/pMiCr567NxPX0eqc3LNWQ6UWaOnt4GvbKSbTb0vqfHfpH1uEf9T3CT39D9s/a2Z9uT+5l5DyaijoHoT3EaHdr9ta+tQcdZQ1zWcEJBtP770EHo1lmNdolaZzTLxLlvUzBjcg7q8SdALH4fIut5QfWgo9GYZFLK714DGxhsZ0yPNJSSU7Ca6Mv3y+K/KIzUBsb3Rrn6LWvrkutpfy9uKTkBQ63PonTevpOeGMzexnnat8CyKbAz0gKJyI4OZFTKo+UxhkODL++GPAJWy9Ji54LxtYiV7fyU65P4ZqS4RTf924fIpvgbLmlAQaOOc5uk32Yl3abzB0/4tBnQmOg4HQ8U86s0gvGq8zLe0xByaPrr30oIMRgyVYi2pBCKTzKa0NSV6mynERAGo3MhqufehwXvajdRH9AHzNosIU4pou3GdL9PfWqTdk7td6LSollwh1i91TE8SjtTxEc9x
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:27:37.3990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fbeef9-d18c-4d7e-ca2d-08dc371a22f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519

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


