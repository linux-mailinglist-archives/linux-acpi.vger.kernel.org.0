Return-Path: <linux-acpi+bounces-9854-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B099DFA61
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B3816311A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC571F9F7D;
	Mon,  2 Dec 2024 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1HzgFpkC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF51F8F0C;
	Mon,  2 Dec 2024 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118708; cv=fail; b=A+GQfiitKFFLqOHsIi5g8OFJt2ec5lvnrAncB11olslCyrkwWvWE88Px7oiNKVAQ3qgclsiXJPaOm88avq6Smv0aRTcl20eB85O2BRT4vKB8io6a53VE3dnoe78vW+EVkWuHZUNSPhLFbW3WbGfdkTzsktmth7nsM8u6v55IE+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118708; c=relaxed/simple;
	bh=+SmEl9EtJQuPngttNL52qZ4Ot6LKWQLRIQrfYzO93/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f82NAlbw8JSIy00jyvcGlVgFJJ6v9VXmmkskrWIZQj1txRkxLdGauCXyTeoPbCg326vJz0mdAfrZsoR3hvixjYdB3bzQYj+SL+9fgqc1SogPI1uBjQOFMxm5LzDya46PmLZjIRcpghUra1sEE9R1Capnydq6WxUXjOedXlPwpkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1HzgFpkC; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXlMSLFMaESb6/UoTWJsm3gLheS9DqUzBHyGLcg61sFNa6GJMXfrqT9xkx8ieVZCkFZ1sPizx9d/61zAgx75/OHA4A/8zVs6jnnNsQTD5IsJo1uJxHWzMWDs20t1yNtY6XsIHq4Mm5g0fG8pc//nCwrB6CaCe3HuuWNbhZCvwaHcaPVhTjmaRuxsSGFENBRgIbU6X3DtsKrLvEFCgwiJyuLoOu2Hp+HREF8mwEL+WwGplt9yx7dGch8y2FnbQKzEw0/2v727nK3M04ZEeiYGmDToweBkfmAXMJqwa6TpUndT1J3swYEIe0/DsRXcXNHMV7MPEA45yR/96gFNvaMSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ThrWq9BcObnUtyryd2sft6WajqDMk+OpNUD+dK4UC4=;
 b=BqjcppN+eJPoqPGJtlt8RptvnSZz/VL5CA+N6CvbbZOvUC0pI1flJVcH8jaSFb6cDeOsVjxbnJiewYgROjTeL9SbMyLsHAORciZ6SYks1RPe8BMUF8T+5/uBc5/hdxv4d0ssIQ0H3U2wodgsoYqhovtg7nrBL3RjXgj5dVkkN4AE1okwZkSFP1tAns4cyE+ZB/PIbuwE2pVchwV7CUw0W9u61WFlxqBtAaMcQ2VIqtSVjDyF2sYUOX74EV01WyoTuO0k+D/oZ+DuGds2pq4sKANJt0cXPhgTaUf3tpcGM7k6y3e6MrEOKMCAfe+KgCq/GxPJguS5X890tXwN0elYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ThrWq9BcObnUtyryd2sft6WajqDMk+OpNUD+dK4UC4=;
 b=1HzgFpkCFvM9375cOMDd04LuaTzrLVn9psUBB6GMuRmr9UGjxYX+ghXYpJ47vDgHTyNvuF8VlV+cxTSiqdiBkPimSLk+JJNYS+EmXwbMWPCeWrf7aNgx0CwHms8DK6wcp4SXuTUwc2QdgnvJAJtGohSKhUni7DechymEPP4ZfT8=
Received: from CH5PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610:1f0::14)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:51:42 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::1c) by CH5PR05CA0022.outlook.office365.com
 (2603:10b6:610:1f0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 05:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:40 -0600
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
Subject: [PATCH v9 09/22] ACPI: platform_profile: Use `scoped_cond_guard`
Date: Sun, 1 Dec 2024 23:50:18 -0600
Message-ID: <20241202055031.8038-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0f1eb2-96a5-41cb-9109-08dd1295660c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWFtYlpMMzRnTVpNM1JkK3FoaHFEa2NkZS8wVmRuMzRod1k1RkRJeVFROHJH?=
 =?utf-8?B?elhSRnlzdHBkcUxldjl3V1RrR1VIeGVFQ0lQS0ZjWGRkRkhXQ2M4RWhXcE4y?=
 =?utf-8?B?TUhxL1pZSVpSNWNBTTZ4NEVJL3N2VU9nMW81c1pGZDZFUE1iVkJVeGYrQ2da?=
 =?utf-8?B?eEpaQ0t0a3ZzcmozZm1GdVpRYlFraks4VXkwNThVaGdBd2JPZVp1dWJHTzhT?=
 =?utf-8?B?bDVpdHhkZUYweHpPdU1LenZNdDRDUkY0SnJIbkVSR0Q1NXFNRVloRldYaXY2?=
 =?utf-8?B?dFZrODVuU3pQSXJZSWFYV1Y2bThUVXJERFJxZFdkblRma0xRaGdWUTF4aitE?=
 =?utf-8?B?U3o1QVhKdVM2dXYwOENMdTlnc0NxcjNldWZGNEI4NDFJZHlpZkhyVG1yZXZX?=
 =?utf-8?B?MjYzUWliNDJmSEgwV1NzN0llQWE4eUxwM0x6aFlyNkJSRzh0ZzNmZG5zcEg1?=
 =?utf-8?B?T3Njd1dEUmdISmRPaXFraHNGdmlRNXdLUCtXbHhOZkhiVU9LZytaNFlYb1E3?=
 =?utf-8?B?V3JoV2xNZjZHc1lodm9XWm9GaCtnRTY5bW9vR1ZISU5Nc2hMeTBWSldWYnpR?=
 =?utf-8?B?anVCdTVSRHhSbFJSOU0vcnBUZm5UUkJXVEt5RkQvMHBDWVVRMTZ4VzRjaUsr?=
 =?utf-8?B?clNpelcydW1oZmw5ZXExV1VHNWNHRVBVekRVWXFvR0pQUnl1a2F4am1PQVdp?=
 =?utf-8?B?aVd2UXl4RXcvaUtpQ2oyeFBTUnFWemRHc3plc3ZTaUEzbHNyMWJoZlZzMXdx?=
 =?utf-8?B?T0R6ajdYNnc5UHBKdHhaUnZNVS9VN0gwckwrbVhWRUpXc2Z4QWpORTJ5NWZ3?=
 =?utf-8?B?RU1BcjlkVTJZY016bDRKN0xQb2Q5bDR2OUduVERqVDFqY3V6ZHBKQXNML0R2?=
 =?utf-8?B?Yjk5Q3l1YUxDK0ZoTmJIeVVValMyb3VIS2NaaXRZZ2lrT2NrQTUxdFlYZkFE?=
 =?utf-8?B?R21RcFBlNnlQTXVBR3BMdVZLblZVMXFXTVVqTW8rajZ6Smk0aWpXdnJiUGkw?=
 =?utf-8?B?NjByc1dUN25IUHFjckxSS1A1MlhocTA1MzNGZ2lWR1BMeHVmSm5kUFp3Mnow?=
 =?utf-8?B?WEI2ZGpjcFdKaXd3SGhxaktrTkdkNnk4S2NiQjYwZ3R4TS9pU2Q3dHZaWDdz?=
 =?utf-8?B?VE5LRUJUWGRBQ3NIcTFpK2xIdGpzVDU4blZPS0hEK2gxWjRra1pkYkNOVmJj?=
 =?utf-8?B?MlNKMjhkVDVtU3hndHMwb0pMb3NIYVlxbU1rbXBwNXFQTDJmbTF3WVQ1OFFT?=
 =?utf-8?B?NWVsVWRzUU44NXVJV2NES1BiN3lXeHI5c3kvbUlzREw4c2RkMC9TaDdONEpn?=
 =?utf-8?B?MmJtRzBjMEM4NFRka2dTclBvcmo1WnZCSGJpbE56S21UZ093VkFUUVZpYjZY?=
 =?utf-8?B?VzkzVUtvQ1dOdHdXZ2tOb01XYldEcHVYVGlMeVpJMjQ5ck5Tei9XaUROMVFH?=
 =?utf-8?B?WXdQMzIrR1JqcWEyV3ZXSmhCNnhMNis4V1k5MHN0M3pUaGlQMVIzZnMreHk5?=
 =?utf-8?B?L0RodTlFRWViVkY5eVNzRnFQaEtGcGJ2bTNkZWFheENGUmhQWk5BelBmTXJI?=
 =?utf-8?B?c09NUkxnTjVsR1dLY1lXK1c5bURlWm1acFJLcmRiM1piZiswcjVZZlpRZTl3?=
 =?utf-8?B?N29ZeGJxNmJpYm5EUlkva041U3dBOWZIZFBJTnhFK1FsOXVLOWQzWGdaSlFM?=
 =?utf-8?B?OTlZUnkwOTIwV2RXTm0zVkQ4N1VScHh5Zm9MTGFlWkVHeDRmN2ZvQnFzUkNu?=
 =?utf-8?B?NTNuWHVSR1U3N2diK1kwbk9QenY1TWt1NHY2MmxXb1BsQ0lqNEh0Y2M1bUVI?=
 =?utf-8?B?cWJkeFM5eE05Z1YvK0U5TFBXL3hTVjdqbjNNMGp5NjB2c0N1dzZibENaNnA0?=
 =?utf-8?B?aHoyVkNTVnVIVDlRWGhrNlFnYnVxcmwrcU9pZjBJam1jaU9aYWx0cXkweUxY?=
 =?utf-8?Q?qotmGEe64TVkRINAgGXMLzfelhqQMtIP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:42.7223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0f1eb2-96a5-41cb-9109-08dd1295660c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

Migrate away from using an interruptible mutex to scoped_cond_guard
in all functions. While changing, move the sysfs notification
used in platform_profile_store() outside of mutex scope.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9:
 * Simplify platform_profile_choices_show()
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


