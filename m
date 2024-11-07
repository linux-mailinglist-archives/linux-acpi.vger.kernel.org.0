Return-Path: <linux-acpi+bounces-9399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061F9BFE16
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52C3B2387E
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE9194A65;
	Thu,  7 Nov 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D8WKsheZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27A1DD525;
	Thu,  7 Nov 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959436; cv=fail; b=XpMOKZ+C4KWcs+emPaMnLilWVItYevmyOB1bac2ngQShm4rahy9i13uKNc8dFBpdmz8/S/feyN0li+zn+mSb/XhrANTElruJRf+CILj14yOqBF0UTCfUL60c8C23cTnXtzZmm121mllGVV64VJgmJ92ZBpyF8mLVIMFdZ2Sbqd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959436; c=relaxed/simple;
	bh=CTLNKCXi/cTsX4LriEwKBmAvKy6FoN1XxY8tEauqe5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCe3Y6hleGsWHiiMkZlFB81jS6DlFffOwN9+wnMtRh+N/vvpX0+Q9m1Ln7fuQcwLNwTOoR5kKujJwOKPVF0C+qlFCtsFYcKORPTlj7YL9i9giYNSIFOQMFetqNDSHTzZ0pJozHSaGStj9SGV3QnXLxRa/xxX2CHxWflx8cI0rC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D8WKsheZ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdL1Knf0UGpiuc7UzbfzFYNboJw3VQxlEUjAqaKS1VLEl6KDnriNgGna/gJkxbFhFZLQceBRXFSmIO+2B9PKY+aZmOJYXVrixupINlJpWRkBx8uDZ+SK0uOD0ueWUUrN7cWARzoL271fc32Ewwv7jtQ0cEZILja6yeq5XVrQzHyTSUrHmU0bJSMmcnASF/D9Ppi9fPw13Zct+/bwPn4CRr6IR6o6hPb/0mGX1RsKkPXGZvXobw85thc4MDkRmpidMyqIkmxb4I9h7J0ZlHxVh7MfRicZJ2ZlKlRtLQ8OcA0W7gMH4bL/6skJ8MZTO3CPXa6/fyLdxTchCqOO7u0JjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef2WNmNYKfJfZZJpNE5oKPFeLWiXbAbe7aodPN6BEec=;
 b=EBJTBXOC/dBeGCmTrN+0aphuym1RfnwrHyTXg346BKknl3CyTRKaHiKVCZVjhyrXnCelYQ/AnG9nPicQOCUDEPDTAEjIMsAkr3DdKv05eJG3J0Dd4tsqyKIPsk3oFID0rCMdhWZza/FuDxXn3Zp5ZC5JEg4wuuQdB2bwAo1WDPxoQEIe0ZBWoZwQtyXbq2ayqafry2+Adf+duRhmOBfU2fqn7AoexpyOD6Nby1zx+iSZXOZzsoISadklZvUtYZLr3U+ym8c+gRQrAoF1nkz4+jA/uqzROOu/d+JjLW2yKXqJd8V/YRIyMQZwp38UFfGT2OvRwfCW+jcbOsXuvKjwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef2WNmNYKfJfZZJpNE5oKPFeLWiXbAbe7aodPN6BEec=;
 b=D8WKsheZNSMTu7ntmhdrQCJcXWBy2ZlHiwxRNSPIh8rgGmMp4mCBXw1PMa8dT5qd1WUgB9HnNIk2brU6BjbquUON5nNRpV4HP9wOP1fgKZWL9oHo0QJ5fBBIAFQb0+2L3cU3mM9aFUABu4D9D/DNHn+eJTnC2/T4ZIX6ql8Qr9Q=
Received: from CH5P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::18)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:03:52 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::17) by CH5P221CA0024.outlook.office365.com
 (2603:10b6:610:1f2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Corentin Chary
	<corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, Ike Panhc
	<ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	"Alexis Belmonte" <alexbelm48@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles
	<soyer@irl.hu>, open list <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:MICROSOFT SURFACE PLATFORM PROFILE
 DRIVER" <platform-driver-x86@vger.kernel.org>, "open list:THINKPAD ACPI
 EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 14/20] ACPI: platform_profile: Only show profiles common for all handlers
Date: Thu, 7 Nov 2024 00:02:48 -0600
Message-ID: <20241107060254.17615-15-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b61abe-03ec-4110-c9d8-08dcfef1f476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?53lHTZo8s/T29HjqZxqr2mzb11uv4fTAjocPEKBfpnZWnICJ3ADG+krNYcw2?=
 =?us-ascii?Q?0d6Sq3BIw807iIMH1UFleTjijEMPwjBJOML8qtGzWEV5Tux1wMJcwTCBUeYs?=
 =?us-ascii?Q?igSfMv0UgOy6cyVLRDB9yh3/zVvcA/A1pSzZ7GsLvGVrttLXYgykJNeTAbdi?=
 =?us-ascii?Q?3m/bK6VLlLcIS1IQ13R1NInBzWEEFPcoYnpnXm7hIuRG+H/A7fqb1CPwkh0C?=
 =?us-ascii?Q?ZR9/EICVARjRxR4dJOmtzQgfJK1WAkGShjYJiFBn9stCXV+9xG8uKz41c53S?=
 =?us-ascii?Q?jlwJf2/VWL/GlvA6guxUPMjFsyx//8KObX11jrr1iXfibZyzI8oUqL1rsGIU?=
 =?us-ascii?Q?oECJRi6XSLe0ZBJQpQE8I77RolpQ/OOxP3jbQKwg9yskn/km4pYyGqVtq+g7?=
 =?us-ascii?Q?pTk0csfz4AZkZRQ6OLOAJHOlpC3ppJb5R8rFZGWAzJjM7UDqkt2D8WDuaSJ9?=
 =?us-ascii?Q?8JmdwcBDPJUHiGgULL7oQTo3I1zgFQVbpQ9VYtH+R4bVk45kQTlqxSWSI8qZ?=
 =?us-ascii?Q?P65Q1fA2hXLOn1kcWavxjLr+iW+aZRX3Ten6YWDu2GDpcPAhH9kLkryyrtu0?=
 =?us-ascii?Q?glFc/Q9BwMUNelmWfklyQdMdMRRL/c61zBCHkxAmjda6OybE8MLl6qjTNmUn?=
 =?us-ascii?Q?iojGgcHu3W1+HbdGnEeMgK2EKvudf2NrQzHbdpVY64tU4FGTHTb7f8Hkqc7j?=
 =?us-ascii?Q?mDg3VIskZX4+aoVHbkGrEsJr7wzM8aeZDCe1/xyi31ugTBKOilWAXyZjRsiE?=
 =?us-ascii?Q?WssGpblMkL0njoW3xZXwoAy2TQoblBF3NXsmmBq0+jcaM1QRPn2NVQzLmLDV?=
 =?us-ascii?Q?23zbuFKn0+uY7hQ1vv1OwpHtX3PGfmKTfz5MP+6OBhZeRuRjAneg6CXOEMSI?=
 =?us-ascii?Q?mALJwTgGE9VE+DvyrTwhyvM6ot3/iZCgQhPlktf+Q15RDdEkqLunDo8qywod?=
 =?us-ascii?Q?4AvoZ8sr41tLUo7uyGKIs6XpgmDnaTHm7p7AK+39g1pA7N1+pkn/4FNYYJOR?=
 =?us-ascii?Q?x+3YiugB1E4QIu0ptJ1XycoLbfcazT7ItUM3Q0Pp1NukmcK6QSn5UOd3UEUL?=
 =?us-ascii?Q?uUmrO0Le7mhkBA8ruR7Z0GhI4jrC3dAsxmCFrsCDOWPTzuq/yo0yNiSQC/NB?=
 =?us-ascii?Q?QJALYQ957UaoRqSfy/AB1F1zLbDFjac+stivSpy/vVq3ckfzDb3ou+hcNfVR?=
 =?us-ascii?Q?gIVyKaTIt3NKPGk3b2XxvkBR1Xsis82dqBhcZHgYyKn7/gTkHD88XdO5pAz/?=
 =?us-ascii?Q?9klHuSaNY9b0kA9+/WFjKxF7731W99cZfwrihRt1UTVz9+GxTubazBVB56BR?=
 =?us-ascii?Q?qnMZIk31z0CK4Lic10csQT2VIPhLX/TtoteaQQZvRvcuC4tL6ErIqSRs59TF?=
 =?us-ascii?Q?L1ZKtAQwqSql/372KF3JJMRP2Tt/CNtIe9uWfElK6ZFMmeXUkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:52.0360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b61abe-03ec-4110-c9d8-08dcfef1f476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * adjust mutex use
---
 drivers/acpi/platform_profile.c | 59 ++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 510e1435d3980..2ae0437623abb 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -231,27 +231,56 @@ static const struct class platform_profile_class = {
 	.dev_groups = profile_groups,
 };
 
+/**
+ * _aggregate_choices - Aggregate the available profile choices
+ * @dev: The device
+ * @data: The available profile choices
+ * Return: 0 on success, -errno on failure
+ */
+static int _aggregate_choices(struct device *dev, void *data)
+{
+	unsigned long *aggregate = data;
+	unsigned long choices = 0;
+	int err;
+
+	err = _get_class_choices(dev, &choices);
+	if (err)
+		return err;
+
+	if (!*aggregate)
+		*aggregate = choices;
+	else
+		*aggregate &= choices;
+
+	return 0;
+}
+
+/**
+ * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
 static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+					     struct device_attribute *attr,
+					     char *buf)
 {
-	int len = 0;
-	int i;
+	unsigned long aggregate = 0;
+	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-
-		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-			if (len == 0)
-				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-			else
-				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
-		}
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    &aggregate, _aggregate_choices);
+		if (err)
+			return err;
 	}
-	len += sysfs_emit_at(buf, len, "\n");
 
-	return len;
+	/* no profile handler registered any more */
+	if (!aggregate)
+		return -EINVAL;
+
+	return _commmon_choices_show(aggregate, buf);
 }
 
 static ssize_t platform_profile_show(struct device *dev,
-- 
2.43.0


