Return-Path: <linux-acpi+bounces-9178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09C9B73B3
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB08281B56
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4031891B2;
	Thu, 31 Oct 2024 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VJw4xBId"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155891465B4;
	Thu, 31 Oct 2024 04:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347891; cv=fail; b=RKDtR71MRKWj9vdoid5lKtUC5RCG3WiVzK6aTbfXn02JeTDq3ol89FMNQf79Epj0QmDjBkx6HXA1WmtA2lcIMJftmSaU5/FEQ6ZAixG9/FgBDMI8CjGLbl1qEKNIaxTPgSbJP8kNfjizWSeXikJBVjMEexNOx+HmXLKUFiPRoac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347891; c=relaxed/simple;
	bh=6UK4KPOkTBXgHgJ757at4Kltmdl+cBgVmhDqbaSTfAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbsCvE15b/8mzr8NIl6mOHYhmBGXaiPRIe1QdKKuls0IU6o595YiCq6fopxGtDZgX/ivUk5YoE6b12YTpDQfVhS+fGC+gLm+tZAO9rIz7Rk7HfO6aLRoXw5UTNDK68BjvFRxNYj5IKUDSfiujc5mN+QSIPz5UoMeSTu9/str2SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VJw4xBId; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIXEVH5xQ7CSs0V5Du2JP4uhbWWEuOEZaWEAOYEG4/+qhb0GKoEsfpOJlFSvQ8OTE14JZH+aEM3FMxdZmUnHzMJ4t5ojAXKJ/BjpDzzdpOK3K141/TXV2155DdGTpMs/IDuUb21qPYxcDCpWAXphlwGAO8+zeXaDpABLm27AKYd1QRBscgVv9NR46kNHAlL1Q8Al9EEaTzJ8cCI/NPFEpaiHTXRODBiNfCLT2V2Q5belW6xcR+hTTq/57Ng1rrsgGCNe/uThu4YvYRH7gfG04maauyppEl1czxsJdWVV8dZH87xgXMhzCWT/aEPXrxvyqpMxkmveLd7GYaknemxffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tym0pi3XMzZvhS+YgNcghEe1i0+BdOuSCGVmlPuXgk4=;
 b=VLexYoeq50g6vU3QhgcNSifhvuSIJGIjXfcFfS2SE17714BqzUKD+6bbeYO7dZNeKeSXFundm5Yo1vJB8fA9MclZebqN0OVQb1gtfUt5waZpComDsfIKcMXzN4+ud358/DKrOCcuzi0mTy2lmrJFC0CdXlgdlkI9P7eoLu3Oi2EiWQlN81YwQTBBbbw8/+ulUPMhGOFrlPK4doLbbK1KV5CjmsL2EJjr612FG6NjF5Dv8PU+g+X8Fg66i0g7GthfUtxqCCr+fNh3rVNwVx8ql0Xj6otZE9Rgdu3lZmKFbhfUiVzQerNURGHgr+ADe9uEScNcT02DhhPOcnI0eXEhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tym0pi3XMzZvhS+YgNcghEe1i0+BdOuSCGVmlPuXgk4=;
 b=VJw4xBIdpdZ4H61SJ64dpUAkNaejERKl5NskEEzo5WbGhI2FdMkuOm4+Fgyes5svRG/KCLUuBI610gGgjwmkRPyQJ47QgK1HTkeFNpSnSFsI4g2M9YsONFAA2xb1o0KzI1yds2cgqVIQT2gs5eK/ExzFwWXcSTRn7fLEQZa9Pw0=
Received: from PH0PR07CA0047.namprd07.prod.outlook.com (2603:10b6:510:e::22)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 04:11:24 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::3b) by PH0PR07CA0047.outlook.office365.com
 (2603:10b6:510:e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:17 -0500
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
Subject: [PATCH v3 18/22] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Wed, 30 Oct 2024 23:09:48 -0500
Message-ID: <20241031040952.109057-19-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 05034412-6068-40d1-f1cb-08dcf962154e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhQ9T9EzHilgkvtcFne34U90eEKTfK8DAI280sPo+ARnFFMRFTOdoRqAyo5F?=
 =?us-ascii?Q?JRmNXzOn72qS/8m7oUtIl1VOWqcFfiferIhIKBNxHxPwnaNy+TR1ttDtfrNx?=
 =?us-ascii?Q?ALqpogz31PEGUSBNZ9fpMrUlAWdJdBenL9AwkuD+4QM22p3v3EYjAh/lDXHr?=
 =?us-ascii?Q?Ez5oykXN04IeVjCBPbPE2jBdUUlybFRdmFeXE55QNBdLR8IryVw7YbArrIKs?=
 =?us-ascii?Q?7BA5FqvboTXeAKb3pd3rf4xXJWfxzEVL7p1vlKVlFPCFKiy1NJfebh59n3/r?=
 =?us-ascii?Q?kDqtuadDS/6ovTN0a1ptDy0KHi7BXz0GHyXeJajUnh5lME8BAplcrM2CEiVz?=
 =?us-ascii?Q?1a++xsXbnOlqK/DE5A4Z4I8801pmS83s227VCZDQXLUOoPit1cpF0FgqL/3S?=
 =?us-ascii?Q?m9u3/Q9b/X/D1qj9fMvRY/kn++rWSjZ3oeR4j5ZuzP9kCzJPOMK3FytxGQy0?=
 =?us-ascii?Q?G2Ldo5utD2x91UeKY+6x9VRB1MPMUnBz4XncnPaRYWVeNXW1UCd9VbNbSUpq?=
 =?us-ascii?Q?RfnmpyEz05VV4e0OJXkxISFJeG9TInWJXY+uxsY1ZrUJYZmgEqWCKpe1Uvrf?=
 =?us-ascii?Q?Krjfkw6qowZmWKwOa74DgwkJauOoZwjC6FIO07pX/lpHle6GrBpIgUAzmxSs?=
 =?us-ascii?Q?pLbMyiQ+BQ/qtH6NS+d0JyrFDLo99HqyXR1FvUew0jbZhWmDW7kmNWRKqkNp?=
 =?us-ascii?Q?xkFUGVQNDAxSBl0+p0u9tfMjCro2ln1sveThmDsCMX1gR4cfjlcfovhXzqGe?=
 =?us-ascii?Q?wIcbIhfPhBINzhGe3hJdnPK8rGZ/2bCOEPYJViAZK9NOxjFS4xrcY64XIAjr?=
 =?us-ascii?Q?ha1zvxc93YvSXsehjUGtGlVekB+QnGxT4WWzON24R2vhe+sQbi9ODPE161jy?=
 =?us-ascii?Q?s4VJaVo8Tdh+MhAj95Im0gr+I7KQ2zp0PqhAd9npOWzjzAtLFpa77HRNZezy?=
 =?us-ascii?Q?eD3wXituh4avaE2RlXAHMTSOzbddQRighD6CEFxA71yYzGndndiermHFSdTF?=
 =?us-ascii?Q?yBBEX8Cnz1c/PNhEQJuAMJ8NUNpZtcMdFmVsDXQEBV7RYlo9uRbycQkc3EGZ?=
 =?us-ascii?Q?sBFWqVDUU8vLwdtDhIenUFbqZ8y6tjb9HbH1BjwX/pDWu/uNNfvECDChyfGv?=
 =?us-ascii?Q?QKkbDM5r5cOOtLUN1jv1Q0ItjKlav14lIVrrBDdCgYc0UyPytgbxDWFK0HQr?=
 =?us-ascii?Q?o53LOec5tVKYA4e1a91smb1xbvmF0W8rRsEcgQqxLBwF+l2hX3kXyiMD6EKD?=
 =?us-ascii?Q?0yPoPsmC9fzF8YsDMl2EU5HehAkKSBvv5gYcYzmv+gDz0t+8CSIbCsYBJ5VJ?=
 =?us-ascii?Q?ZjFO6coq/zzIUgzIo/JAgUnCxVc918wixGPLdEYnBII7n0B9cpUMwD15kDx7?=
 =?us-ascii?Q?jwufmJhWby/PP5JLfnS4q+wp6gXkeRIMm6ho2MRNCL1Z/Q8TXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:23.3124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05034412-6068-40d1-f1cb-08dcf962154e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

If for any reason multiple profile handlers don't agree on the profile
report the custom profile to userspace.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 39 +++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 3128bd16615b6..5baac1f9a9c0e 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -51,6 +51,36 @@ static unsigned long platform_profile_get_choices(void)
 	return aggregate;
 }
 
+static int platform_profile_get_active(enum platform_profile_option *profile)
+{
+	struct platform_profile_handler *handler;
+	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
+	enum platform_profile_option val;
+	int err;
+
+	lockdep_assert_held(&profile_lock);
+	list_for_each_entry(handler, &platform_profile_handler_list, list) {
+		err = handler->profile_get(handler, &val);
+		if (err) {
+			pr_err("Failed to get profile for handler %s\n", handler->name);
+			return err;
+		}
+
+		if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
+			return -EINVAL;
+
+		if (active != val && active != PLATFORM_PROFILE_LAST) {
+			*profile = PLATFORM_PROFILE_CUSTOM;
+			return 0;
+		}
+		active = val;
+	}
+
+	*profile = active;
+
+	return 0;
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -81,18 +111,13 @@ static ssize_t platform_profile_show(struct device *dev,
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
+		if (!platform_profile_is_registered())
 			return -ENODEV;
-
-		err = cur_profile->profile_get(cur_profile, &profile);
+		err = platform_profile_get_active(&profile);
 		if (err)
 			return err;
 	}
 
-	/* Check that profile is valid index */
-	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
-		return -EIO;
-
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
-- 
2.43.0


