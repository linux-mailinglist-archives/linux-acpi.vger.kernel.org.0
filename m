Return-Path: <linux-acpi+bounces-9467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4B49C29F3
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D8E1F22817
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676FA14D2B7;
	Sat,  9 Nov 2024 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="glxb5FWw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270314A0B3;
	Sat,  9 Nov 2024 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127359; cv=fail; b=OGpvk/Dkhxsp3wJuYt5zqJZ2j5ZyDx3JKNbxHwSSHFoEj/F33vbhHIDIbIfUZrCkIApxsCeKD+7N5gulSsPPqK8kYiKHNJVFrtY+en7JxH3i8/oipc6HFFHr8tDGRnQflIupXJIdnFWq9AFBKE5lJxMVhHBRb5cNl1F56hphVhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127359; c=relaxed/simple;
	bh=eR/kuOWvhZLZUdUk6IKGkBbP0bE5GeKHJI29oIiDKh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct5+rp4Jjk9Ao1RpYUxQeNvKE9xnMVIX4m2Novqe4p7j9qabWaE4IuOHUrSZQ7u/40mJkUBmIu0lRztY73ARmAWGzY8e2izg8ssEwB24Efwx0Z4rxp8RRsCe9/KVNhKdwLI1Fa6gHYlHsOYLHQDgZps0oHatHES+POTPse/AON4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=glxb5FWw; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ+VEQEXf053cNlNoGJtAvGngmYgOusnrFuLfg+PdASwrH8gMtKUjTlvKIuqpWsEE2i6kf7V7ATFB8oO8BkpkDbQnlGUq8vh6Pw1/4hTkItNSzGauGLVHTbppmYGoAwLGKRghfRcED9f5fWun9Lu+cjQ5chcgcSyUh4tToIpbpIN6/vEa8bNViKdiU+hBDmz6aYGdzbFRZ35S5R/orHaBY+gY9j4BVEGQAIp7IcbUVHnh5RwvaHRYgvrFok/AuoKEfXNsd2zGh98BakqxsdL2KDgtNBjLx7luv++AVZaMFD+eaB1Q0OpDJfZFmSVLhpU/FWaTWLJ+mDNCQEgGbkYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLQ/qcNQHbvVxO8H7Dy9mDWXqRfXGHQv2or+UNEXmN8=;
 b=K5mENcUVKgcfvXkr8sBIH2mZuFUs3dEamBfQmv4n4/3FQ5NxAprCKmO8hvxFpciMBX0xQlGwTNMCUx0A7/EsHGEIhIevM8z7PYQNip4Wlc7WDcK8NCficpQou6L9vtnqTS++NanBZy6iLMcVHtPQxKOeAKL+lzRaI6THNQuPL4u5P/ZxcN8eYfj4wUzFq6nYIPTUsMlQFtpVRyJ99awUv5P7q1EpPp2yWOom4ngUicuSBYaYQFh/Svtjc2AsYe/GlCLM26ReqZDnymxaetTpTWK1k/tjl+fJY1VdrT4VBIGi4HvCLqXLID6leMtSqJNRCNbzx91ukUdoeGwE1MLo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLQ/qcNQHbvVxO8H7Dy9mDWXqRfXGHQv2or+UNEXmN8=;
 b=glxb5FWwNDw9tUaEEe3P7h394JNT/F/LFCFKqXb6rC/Zb0m0kmq1fufy23sE4fauxaNeY3JfXln1EU8LV5lcO3NSrwT82hu3tO60adphaMihoyBznNYLFC3JrsP4Algw9hYoh0sIz+q2rYU2HbXhYStMd5RLuDc8aoa6Bt6XaVg=
Received: from SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) by MN2PR12MB4335.namprd12.prod.outlook.com
 (2603:10b6:208:1d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Sat, 9 Nov
 2024 04:42:32 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::63) by SN4PR0501CA0069.outlook.office365.com
 (2603:10b6:803:41::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:30 -0600
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
Subject: [PATCH v6 09/22] ACPI: platform_profile: Use `scoped_cond_guard`
Date: Fri, 8 Nov 2024 22:41:38 -0600
Message-ID: <20241109044151.29804-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: d15dbcfc-e2c8-4129-30c8-08dd0078ecfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzIxS0RtUXI0Y3Z2TGE3RVp5ZGhJTEZmcGFPQkozSGFNdlpIWWdFTE5vRmdp?=
 =?utf-8?B?RXJPemwrR1FVUTZJa0tydTVtOFF6OEwwYk5HRHVIeDFRZVR1ZGhVVWswdGRB?=
 =?utf-8?B?bGtQWXhmUnZHSCs3bTJFME5YRkhGTHhLeXpjYUR0dXM2b1I3dW9ld01LeGFP?=
 =?utf-8?B?SkdvaXdocUt3UVJnNmFUQm1hSHRnSkxMd0hwTGt4U21McUxEeThCTlByYk13?=
 =?utf-8?B?QlV6YnE2YmtXOFZ6ZTAvNi95MHNIVVNtU01XTnZEZkJNNkxOS3d1b0tTWEFE?=
 =?utf-8?B?UjR3WktWeklVcHp4Qm5qL3hVK1g2d2haN3lGYVFlbHplVjc5UnhFRWo5cGdn?=
 =?utf-8?B?NWNybE1CTWJLU0swY0lTZlZjUXNtOXJNaHExQk1wWk5ncEdxNzFaY1BOTW5X?=
 =?utf-8?B?Q2w2QWZhdmh0OTF5MUYrQmljU2VhY2Z6TytRK2laNXFKckNPTFp6UWEySldr?=
 =?utf-8?B?MHFTNjYxK2syNWtRL1FSdFptZlpKR3k2YWg1RDFtdXFBMVZHTGt3aGtmT05Q?=
 =?utf-8?B?eWQ3YjVpRlRnTWd4N0IwelZEUE5sdlNlYURzRnRibVJPZkp2d0tUNE5ndmVW?=
 =?utf-8?B?OWU0cVNXeHE5M3k5em1Xam1NdVNrcy9WR0VmS3VtVTdBSkt2NVNBVmpUeUxu?=
 =?utf-8?B?QmNBZm9XV2RYa1RCQ2ZSZEVxbW9xYndvNDcvR0ZTM0dmV0kvODVnNDh3eERt?=
 =?utf-8?B?R2dHUmo1Y2pTa1M5SjJ4b1RBcHRiOUFSMmFBL3VrRFRqRjIvNGgvWktweU02?=
 =?utf-8?B?TEVkajlLWjRnNzl1UzU1dHd0TEkxeXlzK3NVZFVaLzlDRGJXYW80Sm1aNDcz?=
 =?utf-8?B?ZGhQelZqTzhMV01OUjBKN2xUcEZYam1vZVFzalZDT05MSzR6MFVuQnRnS0lN?=
 =?utf-8?B?VHNxWkgwam0wZ1V1STB6WHR1MmU2RlJ5MXAvL0xHVk14czJVOW5vWUxpQlV4?=
 =?utf-8?B?dnlTWkVQcGUvTGhMTlFKZ3N5TndWZUhVRDY3VHVraEF0K2RFYUtrdGhld1hZ?=
 =?utf-8?B?ZklCVTVCcTRiQUd5Z0QxWUVXL1JMZWhia1I4ejFiYS9ZVUd1UU9lcndsM0V5?=
 =?utf-8?B?UnM1cnZ3aThROFJWeUtYVng3Mm1yNVI1N3dXbzMzNVFud2hBcEN4TERjRzdr?=
 =?utf-8?B?VGVxTDI2THNCejU4dlYxbDBrMStyOUtQQWlVbUZxOUJhcFM2UHB5R2FkMFcz?=
 =?utf-8?B?bXlZLzUwa1VIQmVnb3B6VDMyb1BlVGZhUUZESVNIT0g3b0NMeDJoRVJseVNL?=
 =?utf-8?B?eWJyQjBTdXRwSWRZUjZXZXhnUE9pZ3RURG9EelBTbk42cGQrY0FxazZ4MTFu?=
 =?utf-8?B?b0FkNHUzb1JOYjRpQjh3bnpOcjBPN0ZYWndOd3E1dzVGUktsTG1tZE8xeG5E?=
 =?utf-8?B?bEhSZy9Oc2NvT1o3WThyK3NVNjl6NklyMkZwZW5MZkEwaDBuMEtlbHp5a21J?=
 =?utf-8?B?b0dOTW5qTm1oSzlBUjR5L3lCTFVqWmJhbE9XUlZpKzJxeUU2bU1tYzFyYzBO?=
 =?utf-8?B?U0dvYVFBdHBMNWE5dDkraXNWV0JMTEQ2SnhlQUMwQW11MnVxN212TFRIcGgr?=
 =?utf-8?B?UWR0NmM4M2JaUUp2ZldBYVhzNUdaaTRLYXkwKytJMmhqc0M4dWI0MlZRTzcv?=
 =?utf-8?B?cWdUeTl4S1YvSnVXVC9MY0VyUHlIYkwzcGozeFJWbWJTbm95TktPdFdyTzRq?=
 =?utf-8?B?S1RrN3dxQzRibkp3b3k5Yk9la3BjRU1NbWRtNDdQUUJjNHBnWVgzdWZuVWto?=
 =?utf-8?B?N0ltRkExNS9LQXNGcFY2aFpvSGlZVEVyUlNtZWFmK0ZoeUxMVUV1alN2Q1I0?=
 =?utf-8?B?RlJ3Rkl4dFpQdkFYeHZ1bVJUWm1ra1prTmg2TFY0YWpRTXlIUGZOYWlCT1Vn?=
 =?utf-8?B?aWpFc1pXYSt0MGJGWjNPcVlFUCtuNVRDU1YrRnA5MEpRZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:32.7501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d15dbcfc-e2c8-4129-30c8-08dd0078ecfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335

Migrate away from using an interruptible mutex to scoped_cond_guard
in all functions. While changing, move the sysfs notification
used in platform_profile_store() outside of mutex scope.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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


