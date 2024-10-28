Return-Path: <linux-acpi+bounces-9025-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE79B224B
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCC81C20D9C
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA018455B;
	Mon, 28 Oct 2024 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YwME/gla"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED618E744;
	Mon, 28 Oct 2024 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080950; cv=fail; b=Y8z5vAvvO/JnL7yQ8CZ8GjxbkdkiYHtpvb+L8niE5n1lJ+L+zz5S2B0oqeg1ePnCN1wzNih3ZjNXbtK9Bgyhl2NvGDK9gXjNikGxEX+aJ0M8ZNjgX3jvyf9vDSABdYYjdu6UcG2YtRwCJ+i+LqHEZAACk/7PMD+c1kOSLNUjxpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080950; c=relaxed/simple;
	bh=W+fSgJhDtdVD/6141uj9L3PIS1UUOjhO6wr49vbQxCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkNzaRtLvnhiLM7G3H48FAUAtNDculsXgu4XyjJFBkqWle2OUKKZKnXxwIwWosW8tHDj0ClT0cS/AzUTfBITtjeWgcsQWiIFm5fSPGqVuiilp3IvWzrudiljkl7ZaxaII6WUULHR82XnhP0YEgoRasz2mNBrainKTAnc/mUhlM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YwME/gla; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud8LDt1DfCaGlX6vj9gODJOr8PWwVYV5yydDOGy842G56JUZTkYvhQ+pGMGUkvBzC7ozP94Uy3cLWS7EZXetkFJyD67xg5cimG8+2N83RbpTOr/A6YZruQT9hD9iLdh9OHmwx06xT2jWaiJ1DNCz48kTrNK3awnyE6P10k/gyMzSifgJ5P8JFQGIA5y6vnye+Lnx98reDO2VJteK+a06I9bPek6IN0r7XuC9KwBCGm+VNjnR495YnADLNnvMIzqW9bx6C4bRshEHP2PmrOt0JGQ8ZKbLNER/D2QjbqUtyemu9TDxlggXArrgCM3LZacrCyBkeuBBwr24/nJb3mamIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql6c7Js8FYvAm4PiZo27iRN5a3gxXJfJtHYC8UW3PnU=;
 b=VWujriMC88RZTwIFHkk5VFpTQVOT3Pa2bAwcbJ5cJJgyvA6/JEgUOlhp1y4Ti1t2fqWm5Iz6BzH7L4qB3925Bry55ZiE/Bgj4I5FE817Qzy9CRlfbfVegWPgSx/JJsWwRw3Sm6yl1GrlXfoMPSZGDst6Mr0i5VWxFx/x2zYtKDEejy3m2fzjX0FlR9ov0BEOTllhhmeJLBW58+SB+f72KM59+JqAcBA99SbaZLvR4mGEZYrpAsFevS2T3BSGwavdZzvKeYWAg73gOiz+Smt96h1Zp3mPTRbBc5w650gWzYvfywujYzf68z24ZiWQ29u4Ugt/b9Q/ehVubeM5qL4sBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql6c7Js8FYvAm4PiZo27iRN5a3gxXJfJtHYC8UW3PnU=;
 b=YwME/glaOTxtVRGLsZB7lRpOTK/Dti9Q8qaZdYY1iQZi27WXEvvMlpvwZByuPLswqbmmbJsQB+7PaZlRs8uIE7L4X1nLzTsdQHOKshqGVsFbOLdn1Zo8QB7ZSGIaYmzmAtlotJZV9U6U5KPFbPxsm5dpmi4GSLq+klkhLrX/KTM=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:02:23 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::65) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:19 -0500
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
Subject: [PATCH v2 12/15] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Sun, 27 Oct 2024 21:01:28 -0500
Message-ID: <20241028020131.8031-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020131.8031-1-mario.limonciello@amd.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8f6d72-da6a-4415-ef45-08dcf6f49024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZEz8A4/nGThEAHyxIFuDiJkcyaAkVMKVAEO+aeZNU401bbghYKV8myb4lTNP?=
 =?us-ascii?Q?XbNvQh6pv/ZFwVNfFzqq0FAwdQUaX5BnrCMrO82xA5uq8CAfdYC/sS1MuAcL?=
 =?us-ascii?Q?pKInTolNFgOcJiwcWe+CTyxHQjCVnns8NefBgFOLn1t6MuCb/oBLiCkHyK65?=
 =?us-ascii?Q?DhNUa33z4m9b63dAkN27dPjh5Cu82dbYqFQJvCFVOciE4nOwkeyL3hn9e8+k?=
 =?us-ascii?Q?zCnOd15bZM/IKmgbuZrsPJEK4MZBVmRAqO4M6HJUkiygnPG2yAO6ZzwnNN2X?=
 =?us-ascii?Q?ugDp6Sb7x5ZhPRXT1YzEw9MjxqVdm6bYcA+90m41J3B6FLfPy27yZnhXkbJP?=
 =?us-ascii?Q?CKTB71Egmw+rs/PE0ylXrkHTHBm9u8XeEFnbYifQ4cA49Dunxhf6NVJ8aav2?=
 =?us-ascii?Q?XbuJsCfjVR0SQGlkYHrGXeQbGu2L7G0txDzCuTWyGfI1Y7Z0YiGLf4bqVZMn?=
 =?us-ascii?Q?RdPDjGG99QKK5ET8e/9YIfArbB2rAnP1W9JwmGrR5KoGOgSNOJlY64eR7sW/?=
 =?us-ascii?Q?A8fRD1qVrWtFr36Z0RrqtiLOgmXBJf2+PwFhxbem7QPLtzX6rvOoal1uoPM6?=
 =?us-ascii?Q?JHhnSzWzJpO05kKNwgvwya2SWxUSm1kiBZWzH6j1pct2jzQETsfzrl0B+GHN?=
 =?us-ascii?Q?ivYmp/85aj6usKHB+q67cfNPHnUfsGHZKhA0NhI00oyaGTKPFx04SIy98uRK?=
 =?us-ascii?Q?4oKP5Gxx42fAOx/Hk4vim3BDJRyH2JEIOCXfaKxCcMVq8VI7kEhCnnRSgN4V?=
 =?us-ascii?Q?rn388Mo+mLIwyaxtjIz7RM47yIX0uVZ9g4wbjz4NZ2D/erDmhk8fw3OXP77q?=
 =?us-ascii?Q?emMhZyf1w9LbDNOc4U+f3g2mZEL1Jr1j+LgsL9kj+91dwzQir+rvIwSd6PJM?=
 =?us-ascii?Q?V6jXRO1Tv1Bi1304wa3/ZOWS971jGgV/a/LJeH97Z6ciVeGGC+bqbAsaiCg4?=
 =?us-ascii?Q?TVnm5LdSdwhGqIdjbPlTYiUq/eks1Y6RxM0Fd001YYibmmzOdFe+JYtb4zCH?=
 =?us-ascii?Q?hlsC4OexUqApa0QDp18lNZ4aOI1RHX6zDOKVHehSYxWT1FufKb/3cGK5mzDJ?=
 =?us-ascii?Q?Y6FjcHO4xqrcbvgD74nw6KUQAhpjky8RgQVAkY4WxLrTJmBcriWsOgzMlRx2?=
 =?us-ascii?Q?WjKS7QTS59bu2aOgYYU5pA4OPGaFEJSQ6TitkxdpgaHwvMg89XchvIYw8ytG?=
 =?us-ascii?Q?zy/oRKvxpl1+9Nl7IPHn6yNW1DoBNMkOC+cUAM+B+2Y6MlA2xkkfam0c01d3?=
 =?us-ascii?Q?PEHDRnGOUl2kG1EVkNFhQz4logzOgclsYf7M6ISnDAeN6A+DMkIsYPeCpyuk?=
 =?us-ascii?Q?tUNyaKLqk0FHj9GUCwP5jRiXhp5E/cRvyL+iZ+b6IG75QJMiJIHnS7dnOJSu?=
 =?us-ascii?Q?LXNKH9H7muUf1D+t5EjBV5RLoWrz59rdxfDtmWeKsQMxl+Pryw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:22.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8f6d72-da6a-4415-ef45-08dcf6f49024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

If for any reason multiple profile handlers don't agree on the profile
set for the system then the value shown in sysfs can be wrong.

Explicitly check that they match.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 61 ++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index db2ebd0393cf7..d22c4eb5f0c36 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -51,6 +51,45 @@ static unsigned long platform_profile_get_choices(void)
 	return seen;
 }
 
+/* expected to be called under mutex */
+static int platform_profile_get_active(enum platform_profile_option *profile)
+{
+	struct platform_profile_handler *handler;
+	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
+	enum platform_profile_option active2 = PLATFORM_PROFILE_LAST;
+	int err;
+
+	list_for_each_entry(handler, &platform_profile_handler_list, list) {
+		if (active == PLATFORM_PROFILE_LAST)
+			err = handler->profile_get(handler, &active);
+		else
+			err = handler->profile_get(handler, &active2);
+		if (err) {
+			pr_err("Failed to get profile for handler %s\n", handler->name);
+			return err;
+		}
+
+		if (WARN_ON(active == PLATFORM_PROFILE_LAST))
+			return -EINVAL;
+		if (active2 == PLATFORM_PROFILE_LAST)
+			continue;
+
+		if (active != active2) {
+			pr_warn("Profile handlers don't agree on current profile\n");
+			return -EINVAL;
+		}
+		active = active2;
+	}
+
+	/* Check that profile is valid index */
+	if (WARN_ON((active < 0) || (active >= ARRAY_SIZE(profile_names))))
+		return -EIO;
+
+	*profile = active;
+
+	return 0;
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -80,24 +119,14 @@ static ssize_t platform_profile_show(struct device *dev,
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!platform_profile_is_registered())
+			return -ENODEV;
+		err = platform_profile_get_active(&profile);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
-
-	/* Check that profile is valid index */
-	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
-		return -EIO;
-
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
-- 
2.43.0


