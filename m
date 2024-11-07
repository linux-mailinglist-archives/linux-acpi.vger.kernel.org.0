Return-Path: <linux-acpi+bounces-9392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D19BFE02
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE51C21EA9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED961D04A0;
	Thu,  7 Nov 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pPsp9J2C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89182199951;
	Thu,  7 Nov 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959424; cv=fail; b=s+BDBWPSxqu1QJpZZHyMx8HcB9hPi0ow6Fb0qs+nVIzqh7+EUNkcJxczZm7ciz6hkfR2j+sC1w2mzBOQOGQq8QffSN244xUDQbUVwftu28mgkRM1+0xim3nkM6gsrtY2IxbZkwT+Ne0S0BzVYgl5TLAuc+z45c4V1Ifug04zHXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959424; c=relaxed/simple;
	bh=Eh7GbAEhOApPgwe7sJ19hDwugoPdNvuFgJKEBageevo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJluHLAa3ISo5iznx6e/QLWBZxuqqohfDWzMnpzL9RiKKNfGQVuOxgZG2eMvDM4zaD8ZT0uq4xedOc4PbTRbAve9t/e4bSYc3IopZxAjG+bTg11zDkWdEMxY0bhfakZQOcJqt1WHUagDEwtn3Lg4Fik6MGdX6RJJbA3zHRKgMq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pPsp9J2C; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp6yA3uyIHUbiNA2u3UPhPt45ry2qCNqqvumWw7q5BTi3Srs79BbK27UwodCrPAQCDz+4stZrJX6+7yBWWFqUlRGXQxZJnvkk5TZ82EoAlRLNNJshuZItGUt5vRBIEZzgJthQXlDVhPNVS2Jul2NB7ZmFnmG5ClFUSb6u7pJNhAqmcl2vn2eUz5NthfAtctUrSmOhFmMZMiIoigJqP+rU2H8PgG2MBqxCDgEmmYUMJG7w96BcluFUbrNvJJEj1XVZ6mdVOvzob6yTJqdDbluLUJFSwpv3XqVAX9fMDtq05AAp3dd5XsTWglrlupVMXSDEHs7Z2ZPKE2vM3Rue9ohdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o78hvHLjyjWYhzj1ketM61l/Z9Bnrn7JPtZ4EHIBTBE=;
 b=yVlfBSqG1vY07IuDrRzMzF7/F2dNxbtGXDw1ZsBaMD/DvVzCYDhSEZs6Usch01igGTKBMAmJe4YERRcq/8T1sM6KoQZozGyLnPRtQrA107wSitqanzTrWeFGiJ1AcarvqWjpFn2fRVqmfTYsz/a6hXQr8vR6hDJx5o1PeD0n15C7qx2/3gfDAeF64u4eZ/yd0CqahK7E6DekLPV65JAWA+rCUpD+8TpQVwXDsGaW2JPyB2UHj59VbOgr042y3vLzCmQuHGetn6iz3KIa261lBQHBliv1TKmLfdFPKI55dKBrPpR2BdMdYwyIo8f6dzKVYZAAZ1S0PLnbct7wACQUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o78hvHLjyjWYhzj1ketM61l/Z9Bnrn7JPtZ4EHIBTBE=;
 b=pPsp9J2CEdSAOVr5c/iRyGfdAu91HjHewI2mrOpwcLAX/F88ghju8eOcrAF4KRFibVdmnq7zd9xb9qFh3M+xoHNe5Jn4ZtRDZw4WrCTWApe9fGx0dgonAkWos/SMHq298EG4JZB68KN9EmZfrKRFweAZzsUqTpUHxAHp41jSqUg=
Received: from CH0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:610:e6::6)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.33; Thu, 7 Nov
 2024 06:03:38 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::1c) by CH0PR03CA0271.outlook.office365.com
 (2603:10b6:610:e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:36 -0600
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
Subject: [PATCH v5 07/20] ACPI: platform_profile: Use `scoped_cond_guard`
Date: Thu, 7 Nov 2024 00:02:41 -0600
Message-ID: <20241107060254.17615-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: a8809ab8-8428-4f4b-7896-08dcfef1ec3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEtXQ0IraEFGZWpHK3ZYT2s0bmRqREY4M1d5UE5pS1FNcW5BamdMSjd5VXE4?=
 =?utf-8?B?OXJnVkkvMHNxblB0UThrOXUxYW0rUlNSMkNPMitZZkRZaldPbmZWek5jUGZK?=
 =?utf-8?B?bjNFOVpuNWdiK3IwMVBsR2x3WGlvV0QzTzJac3lkYURFN2V2elpIVE1HMmps?=
 =?utf-8?B?Y0YrcERoOXQzZHJDN0srVDlhRjI1Yy9DOU5xekFJenBhd1IvZ3FsVzdJaXMw?=
 =?utf-8?B?TVNVMWFYa0VRa0dGYTZxK0JhdTRQV2dhaUdvUkNHaGZRSjZHdTFwK1YySWlP?=
 =?utf-8?B?bzk2dGM3LzNOYkRtcVloUGtEVFNFVVNCdUs4aC94dlNCbFV6VnloZnJBRGZX?=
 =?utf-8?B?anlJTVpkTlVVVkFkQm4wQ3c1RVZlNWpzZUJsR1F2NDArN3hzQTM4RE5pcHAx?=
 =?utf-8?B?WDE4cGZEcTd5RkpocmVQdXhEbkJsSC9PUUZYRWdFYWVJdmpXcDYxcDc2UnhB?=
 =?utf-8?B?TjljQTZrRG5ZZExqWmNxdEswWTFaNFZReGtoSWdpZFlQVWtCcmtVTzVpZWxS?=
 =?utf-8?B?QTkrZG5NQVUvYVBQeHMyRHBYaE02ejVmTlArNHk0UTZVQ1oyM2VNMlMxR0Zo?=
 =?utf-8?B?Ny9ibG1TbERZOHpXVXpORTRmWmhHdEx1SExBcGt2b0hSK2dMY3MwQXozRUVL?=
 =?utf-8?B?NXNtYmI5b21BelY5QVVET09UaXd5N2ZFV0FkbDlOdVE4NmRjVUJRclF3aGpB?=
 =?utf-8?B?WDI3UmNPeFdFYjY0ME92WHd5ODJ0c3c3QjVJVkRGQzBGcGlzTnR0NXkrOVJl?=
 =?utf-8?B?ME9QdUdRNkFVUVF0QjhWZVZZSDlKSmIra2tiNFhqRHViVjV3QmRDSnowL01D?=
 =?utf-8?B?enV4S2JUdklYbVc4MFZWbFN0aXprWko5Ky9RYUdJLzFPRDBUMHBDSG1CN1FF?=
 =?utf-8?B?aVJzSXJ5QzJQek4yZ2VkUFNtS0VNSWk5LzFmTTFKS1ZyU2t3MVZYL2RlMGo5?=
 =?utf-8?B?d0g1US9LTS9XK25yTGpDOHhRdlF1bEZZZUZ3UTRTeVhqYzlrZTB6K3QzOEhQ?=
 =?utf-8?B?Y0JxUDNmT3lRU3JDYit0ZUFoNHBLVU4xdWhZcFFYeGtlU0VzYkdjVUJMdC8w?=
 =?utf-8?B?TnNnS0Vub3BLeks3OFRwM1U0NC9CL2pqRFZsVEZldUt2aDlLZy8zOG5YbnFz?=
 =?utf-8?B?OEc4elV1cnhhWG56Z0xqcmFkc2g1NkQvakJ0SHJQQmc4WVV0cEdXNDl6OCtF?=
 =?utf-8?B?bUJKeVRkUm9KSzFHNlJNM2RWMUhhbkZ5VVV0QzhBcEFDakFvK1M3RSswSFRO?=
 =?utf-8?B?YXhmTW5vL0IvZGdUMkVnUm1VZDhRNHNudm1rbFpvd2xuWDF4UEw1TGFHZzlw?=
 =?utf-8?B?OFpqVTVDSWJLd25xb3BwMDRnZ25HL3FDWWJnQUR1Njc5bTg3bWNqMkJEUHVS?=
 =?utf-8?B?Z0xtc1prMW5RODFsbStrZUpoYTVQSUgzaUJkRWhYdUdSTmhCVG9OQVBVdVhL?=
 =?utf-8?B?dzR2SnpNalRKcHJpQ2s0bHVmeG5STllnUWdCZVkyODZMaTlQVXhQZjgrOHVy?=
 =?utf-8?B?WTVETm1HMEVVRTFvTEdtYzEvUVZsKzhVZ1pqSDNuOURiOXdrS3d4Y21nQTYw?=
 =?utf-8?B?L0xKbmZ0QkRIS2ZvVEg0MXNrL3lRNno0cDd2MStNWEZXbS9MOFJVTkxKVG9B?=
 =?utf-8?B?Yy9DQVdhbm1LdWFETS91ZzJRYnRubTNkdlZ3RnQzeE55c3NZclRkTDVGdU5n?=
 =?utf-8?B?TVJJeWhyaDVoTmJhbUpGYkJTSUE4U0YwUktkN2d6TFZkbkZKMjJGb1pCTHFt?=
 =?utf-8?B?ckRVVW5PTmgrZ2RvOFltVUdMWndTRzlNY3NYNWJ1NmZhU3Z3bm9BR2xkbGdz?=
 =?utf-8?B?VjJpamtFNlVhRzV4WDI2cHNwSEVicVMvUmp2bmJucmRIOGNqZXF1dlM5Z3lF?=
 =?utf-8?B?NUd6aFI0V1pHczhnVDh0VHNGV2dlbUhIMmdFZ00yWjhTRkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:38.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8809ab8-8428-4f4b-7896-08dcfef1ec3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653

Migrate away from using an interruptible mutex to scoped_cond_guard
in all functions. While changing, move the sysfs notification
used in platform_profile_store() outside of mutex scope.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 114 ++++++++++++--------------------
 1 file changed, 44 insertions(+), 70 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 548eb99253958..0450bdae7c88b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -27,25 +27,21 @@ static ssize_t platform_profile_choices_show(struct device *dev,
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
+
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
 
@@ -56,20 +52,15 @@ static ssize_t platform_profile_show(struct device *dev,
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
@@ -88,28 +79,20 @@ static ssize_t platform_profile_store(struct device *dev,
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
-
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	return count;
 }
 
@@ -140,36 +123,27 @@ int platform_profile_cycle(void)
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
-
-	return err;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-- 
2.43.0


