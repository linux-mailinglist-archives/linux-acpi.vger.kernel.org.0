Return-Path: <linux-acpi+bounces-2920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC2A830D6C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 20:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB8B1C2182D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD3249F0;
	Wed, 17 Jan 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afBybLZe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEA22EE2;
	Wed, 17 Jan 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520772; cv=fail; b=nMYBgoqPO8u2GVpBx9rdCzrLzOcQroKyLZoMR+9USuoiZqZTqs5VeyuthVw7Ka7S0OEYgBhQJP6kCyLDczrEt86t44Vfoi8qDgOMK5DHo/TQVsM5G2LjmRGnXunCrX/1GuNOFjLigS7nhwreu6MallBpdeK/Y6nENTX8/X9idqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520772; c=relaxed/simple;
	bh=7ZRZC+tpGUvS41uE7ALwvyFXZ18Bwbz4IJzaqFIHdOE=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=f+rDHtQfF2u/8FOVkPb1NRs5xR9iap8qmwbzUJJzeUDOa3BBydUBabiHlfmAvBqUyQgTn3NcypOoQhit8gtuTGRFBj8A3u0WBnOgW9R4lxWCmgPR7ah+JHotYYC2eYNthqKpPQiqX3MIRIsck6536zCqTHErYcQ51VRgY4rBxqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afBybLZe; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7wSci2GGJeHwe1iz8BPKeqPBUKUV1bNKryx+xbBQN3GyQgPb12rDwUjwje/l5ulkyXDxaTDfjQyxfmfsjf2/vWFAbNZu/f3IsDm7thr18tEykL9NA7WPZbwkdGYq+EkcHufYFv1Xig4Pv/B7ZDK3ZuhsLIerXHQyAEq5zOdX0P/Egw6jHQT6h5JZXjn1Tp2T7n9ojenAnUxnafmrJazXrFAPf2D3dOXWVC02SgO3WR75/2cm+vqtlsDKF65ojjzmnU7j2brTdBVyCzGfM8dLidrAnC1WwUmr8Kv4Jes8esu/2HcHUYoBSN6UCh9Xy6DL9I9qIdQG9PvFw54EqMCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV4Ih4fAFHU0BmhY/boSFebhMyv3kTOUahUSqKGm/HI=;
 b=oRPEcvtmEgAkL+PmMJIdKLCi5jv830XVe8p6iatJQqshVdGg4hdpbQrdvmbMsBe/KRMtE3XVjeAyzcSVEgGKVY8PZbbar09kLNJuK5lrOxkYlVZp6uRNYO8y6RnpWbhn0a6CtnAlYrGxX+ura1Kjo6GgZ6Pa9JqpfxbB/QY+YaCm+zYHWmHIDYR+Ubzk6Eqq3WNDfe+sNpHQDyHE0Vh4n0/DoHqAkOLXfPBMIhUlvFrlCVYYG5RWYOvf0Qw69qpOSgqa75yNoNSTsDv7boSiRyExL2p/BIJXXsEaMvrKigPm31fRlQ/NZMojefBZgD8g+UrXhwKPGHoEacTKMFjB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV4Ih4fAFHU0BmhY/boSFebhMyv3kTOUahUSqKGm/HI=;
 b=afBybLZeEYWVPDtLlyacWCKHvkTzjhObcZun1q22hNrbB7NlxH1E1WqVF3GXbnsGwwQw6NWGi35+CSaE8+bWkKJBKzgFgvYT4WaooJHDNV5nyfshaUeDtc2kB7QvG3CV8WwI72eGZdQHguFkqxTfF/FK39bzqjYWGtDWf5Cp4nc=
Received: from BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 19:46:06 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::81) by BLAPR03CA0023.outlook.office365.com
 (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Wed, 17 Jan 2024 19:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 19:46:05 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 13:46:03 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v10 3/5] EINJ: Migrate to a platform driver
Date: Wed, 17 Jan 2024 13:44:59 -0600
Message-ID: <20240117194501.298233-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
References: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d53c8f-645c-4d79-8a52-08dc1794f1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rsMdAktbLsk20p8BUAc4XyApK7+yxFdksAkU6cpJIztdg9OuMyMgJ2YRZ2EQvG1qp7uhdPCFVyvmsX6bMloq119JX7d9FuXVoiuIkfLw9i84UNjkUOftltJQ5iIB24+8/B8pfkPKhf27PwCadWjerzwygipEEFyUesDqHbb8hNQG/pfa+ggs5yB7tBqceFC1j+ipYuvqulEcFqKLzGzQtBHaIAi4+lPr9K1siuj2+CRec44KvMXvZGHU7JqGz+OFlPkycpuIb7T1RnP9INJZvFiOtwi6XA2qaVBGj1P/qVUtjXQrv5oYt9LsePG0Q6T55kaI3GLAIiNfHPvyohqD6/d5xJsplSbil4wTTmr6ZfJGaA1Uu4TI/Y7mEzin2qfDdO8PmjYz8XiMcPpd+SJXSv2dUBtKPn+Nso8DHfgZgnoNxuc0d92GiwPrN5vgcNOReqMMU8xTOO76/m0ZkLBpVvYo5H7nRYQGDQcDzXfb2HoK6C92kgzCH/PQSiJGDMo3tSflg9+K+CcM4Bz/SB7fkJJjrLA77lJQBGFWtSykconGrd4YQChUliQ/3Orx4cwWsd7MWUD7JTI2fYWkcRXeGpG1hiDzbIkAcsnL9DMo59gTKQORtgLZXlz+OOE2AkF12vqpxn/uFbtOlnYNs2jGK+U7+6OVKSfZzIHmf0B3RcZc5Ul9PMpc5Ps+V/LIxvTttIE1o5jYJ73ashHUmDPPwh+lQ+GJvvtaN0OpqmsO4M6+2ekiv2NxJjVxtgPtoNeP3G8VM4JYVTJcZntkDhkM9atE2GZsxijWUbgW+059cPBLOzSkyl31S3MZbb/uP2nlALmqGHVEmwTI8nSNUM/pfg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(16526019)(6666004)(7696005)(426003)(1076003)(26005)(2616005)(336012)(86362001)(82740400003)(36756003)(81166007)(356005)(83380400001)(36860700001)(7416002)(5660300002)(2906002)(47076005)(478600001)(41300700001)(54906003)(4326008)(110136005)(8936002)(70586007)(8676002)(316002)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:46:05.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d53c8f-645c-4d79-8a52-08dc1794f1bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219

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


