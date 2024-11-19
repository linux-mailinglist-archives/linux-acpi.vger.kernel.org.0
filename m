Return-Path: <linux-acpi+bounces-9675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A529D2C6E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFC1F21BEB
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAD1D4169;
	Tue, 19 Nov 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WjeZsJO7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7311D2B39;
	Tue, 19 Nov 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036881; cv=fail; b=TQjkCfaZQjx/8K1blWiZuL4/OeeVFz5BO7FJ0wxg7s8MuSGNjuIaCGrawEdbCIA6bXQ0NtB1wMq7t49gp2XbMhq4JvktwXlfDK/cV2Uqd9oM2Ot5EOo3+akwp6RyOBOannlm5S3VVR5i2ku0EWkxY4qYCLdrVzk16drN29oixTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036881; c=relaxed/simple;
	bh=PNUcu1E/82BSOFEj+1FIiCzavwo3sGsVB9Qtl0r0bJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4MohyV75Qts4gepyzq9C99o4MmC7WN2gqBNapAi9SJhiz7iitLoF/0n2mZV58A6CHg0WPxzX7mVaAS1PA+VPYAHTbzJIMagtHAYUV7olRKjmb+VzxUaapDpf8/ERoBjo1zlmqw010mieTEBOlzB9fmtMd3oPwYynWBsxJPADjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WjeZsJO7; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI3zuUMXXupObyBcpAAgDea/pwfX2jmSvXJJq5c8zo993CqnPaz3gOllyHb1KJ96r/UlErkv54zVreB+vSK8FCwJoyhJI686bEvPX9WoQVgJSrOC8ku1GJQXA5ix30ayrbsX6nNQZJF0ld5JDD7uHX22YgMcPkDby0AZzN3oN35wy87QavNznFNi1J1QDESCygnG2XcMk1b+mE4zlrw24YXZZ9FeI6XWbJsdUdv/d9VchvYWgdZBT/EBKYw406jgs/6vY1lMQKaABPGnvVuJVo39k8LiURkNcQPM0BlrIk6owh4UpwefVPOKCOgFicBLOD32HQq0buJN7XtUbuztZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0B2bHKyeeoDyHW0ot5xsOyAVBTpI6KiIUFRqxBndXA=;
 b=EhpYZHOnXnGpC7WUxgHa2muIpifR7vP2TyUfFz062HYdO6sXSXOIWDBpCDU1K4rWeicWbDY+TM7sJHtx8bwOcsJa8V5ftTLEMN/lSNJzwKp8EuZNcTsvNM5q+XqWL5odqX1zZZfxs4rrD44DAKqYhqgwFS1ZurPKijXBBw/RSKe/OsqogTPmRzr4KzveD5N5pHDuq8krpehWEgEUgXaieFlnq/Ab2NYLqJGOm1kAvsusxKjyNe5I4iPD8IHMmcRehHladURyuJKWAeeMonmFKuPNvtLv74olrXnd66z+Bp9z2NcxT4Mrn97S0U0uPKkAXmVjmjDAvQXrI6LmOMgDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0B2bHKyeeoDyHW0ot5xsOyAVBTpI6KiIUFRqxBndXA=;
 b=WjeZsJO70YT5SJ8FK1VxgwPLZoUlKU1ElUkQRDE2HfCSBZJ8cAVOuB4gmJ6mK8rcclXOVCthU+ojJdt1zDXsYTfrvXWdKb85AH3sLBIi+iBZixpfsBX1caIgolrh4H7JcwgUv4RiVYTC4LOFOKo6L2dSzTFZzakQlu1zqHhciuQ=
Received: from PH7P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::12)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 17:21:15 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::b3) by PH7P220CA0043.outlook.office365.com
 (2603:10b6:510:32b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:11 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v7 09/22] ACPI: platform_profile: Use `scoped_cond_guard`
Date: Tue, 19 Nov 2024 11:17:26 -0600
Message-ID: <20241119171739.77028-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 3efde092-5d25-4967-1414-08dd08be91fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHZIZHEvR1I0K1ovTzVYdTVrMElMZm9yU1FrNnMxYnRGSnBkanpZcjBkVndM?=
 =?utf-8?B?TzlYdnh5LzdpalNZVTJDWmlSckdIWFJ3eEJMZlNsa1hwYmlPT0hobms0Z2dW?=
 =?utf-8?B?RkpoOFBnbmNjS0g5K2dMS2tNamxKd1pIL2FrNE9tR0tDMnBtM0RZK1VGd0JV?=
 =?utf-8?B?RlFESVRjOUZ0WUxLelNQOXRTSXNhSHBxVE5PekpMMXUzWWU0SE5acXJ1MG85?=
 =?utf-8?B?bzN2OEtSeEFYWks5dnhvTU1Va1BXbFJtbDJTVjlNa1laNkpydFpXSHdvbzBp?=
 =?utf-8?B?eXJiTjdTNWNDMXlVSkJHNG5Xd3FEdGdaTHY3MHM2citrN0hSeGRnbWdRY1J2?=
 =?utf-8?B?eDl4eEQvYU5PM3V0KzBrNFpLUE9KT1oxdWxVbXRKV2xPaUVNdFhkU0RtL0Nn?=
 =?utf-8?B?azlQQXV6eHY2ci9PcXN6WjVjWkNXVjV0djdNajFmV3p5T3lnWjVWQjhodk16?=
 =?utf-8?B?NHJrWDdaajlxdmRGaHc2MHVVZ0ZxU3ZtLzB6YTFYeUVvazFMRXpZelNQSDZE?=
 =?utf-8?B?akp3VzJzUGROaGd4ZVEzMlIweVBvQ3FEWVhTZ09MOGxyNGU5NHFTRFMxU3RE?=
 =?utf-8?B?MUtvYjlpRVNJOStXZDE4YkNKU2trei9IRC9SOUtVTzlmbEhRb2ttNm9PaVEr?=
 =?utf-8?B?NUhnNGF1NDBmWWJHQm5JbmhMZHM1eStDdUE2dVd1bjIvdVNYWHdIaGZGZCtV?=
 =?utf-8?B?ZUdwbmNGTVdpbFV3QVNZSXlHR0FrRWVKSEFBek96clFhNmVKM1pocVhUc1gw?=
 =?utf-8?B?T2dmRzNMRHJEbUwraDV0VXMrb1pUdVlZL1JQZnMyN0Jrb1EvVEN5YzFmdDBV?=
 =?utf-8?B?ek5lTEtCOTBzMEg5d2EvLzQ5WU5TZDEweGtSR1gyVm5yeDVObWpoMENmYlov?=
 =?utf-8?B?UVAxVEFFQzVlbDFBOVNPZTBOazJyUFRzUU9wUmhPVStyQWNVVUplbm5RVFQ4?=
 =?utf-8?B?Y1I1UXVOeXlza1lIQ0NtRFZMNitjeTZSOGdIa25qT0MzWHNHM2h3QlArOW5V?=
 =?utf-8?B?NE1kOWVjUWJMQ0dZYUZzMUhIWFRpbVZ4VS9VMld3MmV2OFhTU0tMcWNLSDFw?=
 =?utf-8?B?VFk5d05lWk03WXBOOW9tSExmSlBIdnFUY3NZR2pGUm9Nd240akFhM1NNWXJv?=
 =?utf-8?B?U1BlZlIxaFYxS3d2c2h4TW54VjAxcFY3Mk1xMHFHaEVFaGhLQXBVTmtpc0ds?=
 =?utf-8?B?WG1idGxlNGtFN0tiZUJNdXVyT21rbXY1M2lzZG9JTnlKZjN4NDFVMFdmbG5h?=
 =?utf-8?B?Vm42Vzl1TldUaUJTekRPK2ZDRUx0SVBRb1lKTkVqVXZXNnA5QVdjV1B5Q1pV?=
 =?utf-8?B?T3dhSnlsRkMrR1UvVWZoMEZkL3lTSHA5R01Sck40QTh5Y1hsNjZHckxKdXMr?=
 =?utf-8?B?WGIyUWJpVE5NRmlRR3k1SElMbTBtZHFuR0ZiYXo1ejJMOGRlb0JOWTVuS2tJ?=
 =?utf-8?B?QytPRC9DSy9oUHpwMTQzR2V4c0JZeVJLU2sxczBLUGFCK2d0R2Ztc0daQWxl?=
 =?utf-8?B?TWswdmRGTE5XUnRIMWQwWVJ5Sm0wVCtORHpEQWdUWDBSU0xiTDdaenpQbDlV?=
 =?utf-8?B?aUJSTjBydFhEcldXS2M1MzFNdk9hUmJPSzR2WEJHSWJsMnkrSjVhd0ZZaHdv?=
 =?utf-8?B?Q2RDSDhpVzE5Y1hzMmtVdk1mK2FRQ2p4QVlhY08wd2I5b2ZNZm4ycXhWZXh1?=
 =?utf-8?B?aTlZVCtDdVpMQjd5V1Ixc0syc2FlQlZJSStURjhHUjhON05yeXZ1VVlkelpW?=
 =?utf-8?B?c3FwZFlSVzdCRStyZE83Q3JPRW93c1RJRkJtM0Fvb0J1UkgweFU0clRXVGNF?=
 =?utf-8?B?STgxbVZLWXhrWHlybVUvaHI3ellDMi8yUjRxQlo3L1NGUnFsN2M1a0xXVEJL?=
 =?utf-8?B?ZHEwd3F4QTh5TXczSGRaYm9McTNaTmpja0VWUEVaZjN4L3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:14.0341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efde092-5d25-4967-1414-08dd08be91fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994

Migrate away from using an interruptible mutex to scoped_cond_guard
in all functions. While changing, move the sysfs notification
used in platform_profile_store() outside of mutex scope.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Add Armin's tag
---
 drivers/acpi/platform_profile.c | 111 +++++++++++++-------------------
 1 file changed, 43 insertions(+), 68 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9729543df6333..32affb75e782d 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -27,25 +27,20 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 					char *buf)
 {
 	int len = 0;
-	int err, i;
-
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
-
-	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-		if (len == 0)
-			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-		else
-			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	int i;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
+		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
+			if (len == 0)
+				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+			else
+				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+		}
 	}
 	len += sysfs_emit_at(buf, len, "\n");
-	mutex_unlock(&profile_lock);
+
 	return len;
 }
 
@@ -56,20 +51,15 @@ static ssize_t platform_profile_show(struct device *dev,
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
+		err = cur_profile->profile_get(cur_profile, &profile);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
-
 	/* Check that profile is valid index */
 	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
 		return -EIO;
@@ -88,28 +78,21 @@ static ssize_t platform_profile_store(struct device *dev,
 	if (i < 0)
 		return -EINVAL;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
+		/* Check that platform supports this profile choice */
+		if (!test_bit(i, cur_profile->choices))
+			return -EOPNOTSUPP;
 
-	/* Check that platform supports this profile choice */
-	if (!test_bit(i, cur_profile->choices)) {
-		mutex_unlock(&profile_lock);
-		return -EOPNOTSUPP;
+		err = cur_profile->profile_set(cur_profile, i);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_set(cur_profile, i);
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
 	return count;
 }
 
@@ -140,36 +123,28 @@ int platform_profile_cycle(void)
 	enum platform_profile_option next;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
+		err = cur_profile->profile_get(cur_profile, &profile);
+		if (err)
+			return err;
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	if (err) {
-		mutex_unlock(&profile_lock);
-		return err;
-	}
+		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
+					  profile + 1);
 
-	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
-				  profile + 1);
+		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
+			return -EINVAL;
 
-	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
+		err = cur_profile->profile_set(cur_profile, next);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_set(cur_profile, next);
-	mutex_unlock(&profile_lock);
-
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-- 
2.43.0


