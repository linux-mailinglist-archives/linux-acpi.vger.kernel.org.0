Return-Path: <linux-acpi+bounces-9996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45EB9E64E5
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A23C28706F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71547194A52;
	Fri,  6 Dec 2024 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FAieoQTt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87521193081;
	Fri,  6 Dec 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455555; cv=fail; b=u/3W/jqYF7ooRdwPYO7y13VBeEWP9WFFXlm5q6yh6tftVb8GH+rqbL0+ENEAHuv+fjh8T2fQdo6kzA57ycT9KpqG4moczS1IILR9yTUiL1dTgvE2kdsL6QKXWUQV1Dq0VFHUkzvJSWF3Ky0DmWLFvjqArEoCQK4+OZsM9nhYXCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455555; c=relaxed/simple;
	bh=/qmctw3i+Wn7MreEBUXF/bnvNkGTZZxbxd5qgq8OyVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK2rDeqsLDdri19n0yxwYvXEPwtbGpqizBlDfNwYpklifAzMgleStjqPTz1l4MXaELCCtPX2HBqZG7nkL8jlDetk5UBO+TjvQ4rsu9fQmYs+GaETgSZfFNP1g9p+bnWfOZb8qMaacQRO6KPGuYOTTey5dRniOe0uubxkSqSqxO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FAieoQTt; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agOQ7weqXfaJ1IdVC3lR5bWT6Yt59Q4P2dNEuw0C4bHABOzyLCzqhg5i/moe6DnAvX7SUiRfD24a7n7jWoOzH+DLVCHQaM7MyqQIOVQiT4bv5/nCBmgl05UhyVWpfWIzxMNiJbwxW1XhF1OOpU8aa5R8OyaWk6csrhe1UuZ6gKD8cAdxkA969M3m/w+tMeTabyJUB9cuZJWbf65ynMHXY6HfAe5HsRaJjlfx+5fI4rn0Pt3FRiGL8hD0aQurXtmmJcQp3RpFIl4/eLW8z1aLn+OUhFDPw1ph8I2gCg2xuNB4ZAd8OUZYMHPkv8OuGqgyBqclm4LzUo45HKjHxIK9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co2MBzyi5zV9sPvcG3WQUc/xYGa6VyD13j/k/x+NdOw=;
 b=Vj6g9OHZJIAVany2mN4ALQUDI3+BYYeHS8A7UTIr24o/IR1+KEW29Y7rUOXjfb9qLIdvDTJnvq8pUeRE2Jgdv+FraMp7rszCy+d7XMS+mYuKVmQ6XN5dFjQJpZrmxQlXAmHy9iGCycW6pH5cSz+56bjQG8GfdTlVB0zFsZVi+GwkCbik1AkeNoRo40ni9rNbO8H140WGdCuzvO7RHEZCKGqU0agFJrGqK0PMWrCYdjE/esn4KBMic1m817liVzHmEkWxkkOD3holzGHlw/7HBSlFWH78PtJ3ttrdGrxte/p+jVkCy/p0zAv+NOy2oiEf+vgULQyBd37iyYjIcyYrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Co2MBzyi5zV9sPvcG3WQUc/xYGa6VyD13j/k/x+NdOw=;
 b=FAieoQTtwtuROXbDPE16w+T5kxoNMHscXSB9Cx3GByF5p3tuT0sT+N4DX9Z6GrsMc/D5hG3TD3Uatenz3T7eX1tNPB2+U5hdHEk66GJderuEO2CdFpW8rMUa8oGxnhOM/jfRQ1qFwJ6mimhrpBykxWu9V3esiFQACBanvtqkZ9Y=
Received: from MW4PR04CA0052.namprd04.prod.outlook.com (2603:10b6:303:6a::27)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 03:25:48 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::1b) by MW4PR04CA0052.outlook.office365.com
 (2603:10b6:303:6a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:25:08 -0600
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
Subject: [PATCH v10 09/22] ACPI: platform_profile: Use `scoped_cond_guard`
Date: Thu, 5 Dec 2024 21:19:05 -0600
Message-ID: <20241206031918.1537-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: d54a01b3-c9cb-4012-dcbc-08dd15a5ad31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFl6OTBMNVRZeXArQjNCTFlvSElzazB3SmtTUHpZYWVSU21uYTRjVExCcmZ5?=
 =?utf-8?B?ektudVY4OGhIenc3SFEvY2ZMVHdoRUxiRG50c2UvMkw5SDU4M0lObXdxckFt?=
 =?utf-8?B?N3FKSVhLN2JZNDdFTHBwTi9sVTZXdmQ3NGRTVG5GZVBjQ0wxaVpLWS82MXRu?=
 =?utf-8?B?aDBIRkJiN2M5MWNrWWo3WGxNRUttMDZDTHhiVzYwaFRCR29ZYXR5RHJwMzJa?=
 =?utf-8?B?KzFyOHVRSEV1dEYwV3hrb2IyU0pHK3NyTzRXLzNveVRsMWhtdFlJTWNzcFVl?=
 =?utf-8?B?UktkNnlMZ0dCcmg5TDdtOEZTUjhWLzYvQlVrd2tnY0tSQngrWWpjSEh2TVpa?=
 =?utf-8?B?bStZV0N2cWdsSm1DTlY0L05xSWtiRFNYeDl4ODc1MHAvNWU3blVDNDlBbE0v?=
 =?utf-8?B?c2J2bTVqNVFiMXA1MTUyZWEzTnlpVVNiU2Zvc1lQbFJYUkt3MFExUlpCZmVq?=
 =?utf-8?B?dWNmVEQ4dzJFYkRzZmgrRzFKbWM2bTZUanRUTW9SREhGUmZrTUxaTGQ4Mk5U?=
 =?utf-8?B?cTJGZDVYVDRRQW1oSEpPdU1xVGpCcTkxV25BMW5UVFJIOHFXaTErdThEM3Zj?=
 =?utf-8?B?b0hiUFhLdFAwRHM4bmdJR0xMeCswdEkxcjFGYzdJY0grTDd6a2pJNlFLSHBC?=
 =?utf-8?B?VjFIM2h4MDhuWkI4bW85MnRTNnZsZkVaaFpRbGkxcHhxTEk5ZDNTYzN0Rmo5?=
 =?utf-8?B?ZEgyUmxWUTBQL2g0MnlZY3ZHVlNOcElXTURXU0l4SzV6YXpHdVB2NFA2c3Yr?=
 =?utf-8?B?eFRJWDVBQ0FwbFFTdjZXZnFvbHlnMk1ROXc0VmtuWFgvMy9QaStyREI3QUk4?=
 =?utf-8?B?ZC8wSjBsSnFaaWNDTVVWU2FvM000SHBOZTlKeDlFVE9mV0VxY3BpZ1padHdT?=
 =?utf-8?B?VnB3NmhtQnJCUm9xVWVyNGNOSThBb0EvRFJNWjZTNGdVMEh5WiszQndlWmUw?=
 =?utf-8?B?RmNyNG5PcFRaVnY5ei8wbWhTMzBtMVduTVhXM0dwTVh1WGcwRXdhbmFreHRX?=
 =?utf-8?B?dUpUcVFycjFhaTJ1L2dsSFo1Q05LR3hmQjRWb3lQMFB6SS9lRE5MeXlqUXhn?=
 =?utf-8?B?VEJQNXozWXJQMWJBcHBpbXAxR0xVQUNKYWlWK0d4SjZIbnJOU0dJZm5TaUxM?=
 =?utf-8?B?RHpkVm13MkJLZTVjeDhhU250NitBTFBhMUEzMnp6Y1piVFkyalBwSTQ1T0VG?=
 =?utf-8?B?b1UxVTArWldFaWtibnk1ZHFkVTdnNGdOd1lnQlZVMmw1QjBFMnRkQm1nSGtE?=
 =?utf-8?B?eVhNeXpmd3daOHFJUEpsMS9lU2ZUNUovSG8yelZjTTUza3pGYms2Uk5sME9U?=
 =?utf-8?B?ZmdrSHdlaHd6RU9ueXZXRndPOFF1dTk5L1BTMStsc2dVMFArUVV3REh1WkpF?=
 =?utf-8?B?UGVISm42U0hicTdhMWxWb213VUl0OTVUdTBMRk1UOEx0bjN3czViSHJJdVB3?=
 =?utf-8?B?NkhTdzZDRWRST0p2UTVzdkRMRHVKajZRQVpITHZhRGhKdDc1aVFnVTl6dVZa?=
 =?utf-8?B?dUJqcERZT0tWSE9tRTFwaTVlVmhLRmIwZmYzUmVSYU8rR25NU2FaOTZqcUM5?=
 =?utf-8?B?dzhObXNrWnlZQWNXMDRXRTY4Q0ZLTmo3Q3B5V1ZqK0t6SDJQSjJhakFIMkd5?=
 =?utf-8?B?VFhvMC96dGw0MHVGVGlTVGFZcHU2aHZaSUFuOEpsdVVqckhVM1gxTmFDSDAv?=
 =?utf-8?B?bkU0bm5oaTNPSUgrdnlHK0p6a29uT0c0N0o2YjdRTVZsWXNFWGtGSmdlY0NH?=
 =?utf-8?B?WUlhRUZNVWR3Sjk3M3hhYXdXOU81ZjBtRm1MTnJrUnB0VndINmdiTXN0YmY0?=
 =?utf-8?B?c0IzTEpvKytDRkE3cE55WWJYT0t5emNUV3lmVGRJK1ZjaEo2azlNZUJCS0tT?=
 =?utf-8?B?Zzl4WTJRd2dMM3ZlRGtyUGtqeUV4NGpjQlE0amp6ODh1akRhdG40OVFEaXp0?=
 =?utf-8?Q?G2ehTilX8/+xZgjfwnKH/EfCentFck3E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:47.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54a01b3-c9cb-4012-dcbc-08dd15a5ad31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

Migrate away from using an interruptible mutex to scoped_cond_guard
in all functions. While changing, move the sysfs notification
used in platform_profile_store() outside of mutex scope.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 105 ++++++++++++--------------------
 1 file changed, 38 insertions(+), 67 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9729543df6333..a1f0378f15e62 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -27,25 +27,16 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 					char *buf)
 {
 	int len = 0;
-	int err, i;
-
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	int i;
 
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
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
+		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST)
+			len += sysfs_emit_at(buf, len, len ? " %s": "%s", profile_names[i]);
 	}
 	len += sysfs_emit_at(buf, len, "\n");
-	mutex_unlock(&profile_lock);
+
 	return len;
 }
 
@@ -56,20 +47,15 @@ static ssize_t platform_profile_show(struct device *dev,
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
@@ -88,28 +74,21 @@ static ssize_t platform_profile_store(struct device *dev,
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
 
@@ -140,36 +119,28 @@ int platform_profile_cycle(void)
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


