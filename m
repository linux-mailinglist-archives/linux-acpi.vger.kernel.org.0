Return-Path: <linux-acpi+bounces-9686-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06D39D2C87
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795A21F20FC4
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FA1DB54B;
	Tue, 19 Nov 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0+a4u+3O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AF1DA2F1;
	Tue, 19 Nov 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036897; cv=fail; b=JIYZP1grE+jedfFiW/ZRtSW/JBV13NdUXuHgF9bHnK0xpKnXzDpCVNssHZuJk9z5ULlJnjD4nWQGsPtMFE5b2C8PxQMCLk/cvzeaEuP5pUDMKVnbORxGDsQoPeZ5GhXrYEI9zpK0Mgvm5fFFG62oFDNt1xicLxvYio61Goc0/ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036897; c=relaxed/simple;
	bh=tPk8iBelMkozwVP4JFH/dleWnueKOlHY6NqDmg11oOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWSGv8b7Xue6JIbr0E1PA2mVreqpAAmD2LsSuIC22jqEeTyr8GczayQwVmp+JofOEDEGRTRbg+/2siPRDPbGffOFgDUajtw8wMy7aX28KYGI1KrRq3dA/O7GrYKlYid1l8T/NXBcYxceG/yLdmqLRnItksN4t7B82zhZVva1k6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0+a4u+3O; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMIxtv5F4lBCpVRzUuD7cMEjYmNPc33gESPv8p52DfkZFPh8tPdIePCL0C+ksbT4/Si1qPNSvEEeekxBP6+O3O7RXRRi6OIUGor4FPjWl7bwPsLtsRuFtsUo9vE84FIGyHhgiS4GU2qcM0byeSdYGegVg9IKR1yeAWt/7D7FtK/6Z6K5mvsR2xPUQuDsEEgCBEOeODEFeE2mU0MXuS/nZ8wR6e3/RbyyiBoXP/79951GcRg9T8hAHYfW4SfLVlcKIujq/XiKrleVKyO5ufDXJ3RCpx7RaKE80ItYWS9C5J2afmGwI751Gf27ZzPZWH2RmzCCmRAYTPrIsFtMjjAKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdw4LcMjSmWQqzwh5N3XehtHblWWjBa8rpF+/nMuPGw=;
 b=PVI9GEukSHWDD1AUOAhdzF/Y9JGZH5YcJLpbb3HY+g1O0HeCTndA21vvrWb+/rNC6dzNNsw7opPjQuoIPPHlU/UjzfuwITI7E3bmLZzBODhQN45qRZxzFRmEG9arfwA6M0pwVlj6dgG/NW/D3EFh7Zsj5jx1tM7d0LKgS6CTI68VR1iwRv4RBRiLF2xZBZ6dIA1QgzCKZFxdUJNP+rPpUuiAPQ3NU8hxeSdixoLJobw8UEtEiZp7tgbCTJwLf1gEwIcc2M7+y8dw1FVzidZ3wb70bafIUSovLlu+fIF4vAdoNYfmkbNcwyZ95OysWeRcrGuvCi4/gIUYZLFJkCbZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdw4LcMjSmWQqzwh5N3XehtHblWWjBa8rpF+/nMuPGw=;
 b=0+a4u+3OnOgOiBRVFpA41Vd20k1OL6bIsKcIbi5UjpjuaZ1q3nMA2PJi9Xi233wgvdVGcLuEUY3EHuAsNs4UAWx7vK8CZY7kLy9NKwrQY9GBDVf0W+MbW3uXDIFs1zUhk0tzIkQOaFh5ktxFrfbwpgGTovd2ph7TqG15vtU7hRk=
Received: from PH7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:33d::31)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 17:21:33 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::37) by PH7PR02CA0003.outlook.office365.com
 (2603:10b6:510:33d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:30 -0600
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
Subject: [PATCH v7 20/22] ACPI: platform_profile: Allow multiple handlers
Date: Tue, 19 Nov 2024 11:17:37 -0600
Message-ID: <20241119171739.77028-21-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: f7072b11-5d1b-4295-8829-08dd08be9cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mAeT9dXHfaSZ9oBHtIGsi473jTnBGCSLDgqIbRPc3CKj/gpKNcuw/ropT06f?=
 =?us-ascii?Q?hKywW85CG5UWXfpIy9cb0w+kaTy8Z4m0xWaDQrIJBKA1oc2MJaPtWy+8gOvk?=
 =?us-ascii?Q?31EAF5p0U7+ezOYyuX9DYXGtX1OKWH1gJO7XIapbaTGa85GDBz3qQh0jA7Be?=
 =?us-ascii?Q?OMErGD/xk0D1iOdLx9LPoPSCfOF44gw8G5gXYw6s5AS4qNlte4+sLKRhLfJm?=
 =?us-ascii?Q?5iRlCUN7Yr6spX1JjemdMEoU4AcyMK14NRQkjvn/rO7ojapyI/BNjpH5D9Wr?=
 =?us-ascii?Q?vTSnq+ZcKhvsgPEsMR+59pnA5OvmqQJhHun0l2XYRjYScYSMRDJebGSZHAvN?=
 =?us-ascii?Q?hPOch6L5pLzBBaKt8E1eixjtW7dcntcQgMWxsYN5Qx7hbWM6hRe+ceNlhsA4?=
 =?us-ascii?Q?0ze9tLRqr0FU+MLKC83QM+NquVxJHmMo78RNsmVQ8NBLIiS8ADHZhAb2yhOG?=
 =?us-ascii?Q?6LiMkPeo7BAwQ/Ol67tCdyGQcnklkeM0E6yG6wSceaOmucZ0QdVO15QHCLxE?=
 =?us-ascii?Q?C0RzTtkeFcKOn4X5ZpuNeeHinQWVofNbvgB6euZHaZpa2jY0W7vjFgtj+48V?=
 =?us-ascii?Q?2E+SdkzU1ISefeX1Uw4rQLTcdruwog72GqJ3jpoVWUvTJiu6ThGg7plnI11T?=
 =?us-ascii?Q?8kt6r5kd03XcmrFdpb6IB1ENL/DQ0eagVHsTfkmS+4YHSYWTw8pHQHATy9XQ?=
 =?us-ascii?Q?2VWj8ar+Cm0AJ3k/KojyUA0mQf1YhOifm6GuVWhWX870mHSwqSeMkbO9wHCT?=
 =?us-ascii?Q?C4jAp4Ny+kQAXFa3ozBzWBW6sKec2JMQIn5NDLNCpJaymPorQTAY8c5O4xm5?=
 =?us-ascii?Q?C4OpqThYHeMtO0HLjIC87B0XgaTJJkV4pLZ82k606M5cQ1xKXa0xfTwAaXGW?=
 =?us-ascii?Q?mVNFGxflDWXgKSZYtrNnkFy2tU78ujrVNXf1fEafT4sLSTKYEUhRm6bAMQX8?=
 =?us-ascii?Q?OhYMLhu4x6Pnb9rXpUNEfCupPH0KvXKGTd30u0ND7w7q/kvhFyltwglabDge?=
 =?us-ascii?Q?6sz9Gae0DU/T3xH6vLK0uhLKLP+1saIFppfibPeep2IaIUUnzDT1f8eC11fV?=
 =?us-ascii?Q?AZm+E1VlnR4PicEaIWo4+DSq1aKxqH+J64Gt+SGueklgTMCcwWev5cSGfQcr?=
 =?us-ascii?Q?yTjTGhn9K+DshiLUZJnDsCaqFjWImmTkaqJssb+8rVnzoaLJxlxlAqQ3hNc4?=
 =?us-ascii?Q?O/ox46ZkamKShkHF7jpN3IpmomqlRtLWqJm8cWn0f35406WICuBOds+w0083?=
 =?us-ascii?Q?/bxUmy+wQvNYuh5fEvjmkXOLQ09HPuJFbC1t7IaGdIyCxIOKBo3q+ozNv2I6?=
 =?us-ascii?Q?HriXrScRPcblCtwhb5u1ZcIk7fHosL78g7VgnaYIzQ1w4iAs2RvFBLf4RTnB?=
 =?us-ascii?Q?rl8jqjgxU0eTD3b4YOHJiXHirbJCygsw58/+/4adogcIPHM0UQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:32.5716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7072b11-5d1b-4295-8829-08dd08be9cff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

Multiple drivers may attempt to register platform profile handlers,
but only one may be registered and the behavior is non-deterministic
for which one wins.  It's mostly controlled by probing order.

This can be problematic if one driver changes CPU settings and another
driver notifies the EC for changing fan curves.

Modify the ACPI platform profile handler to let multiple drivers
register platform profile handlers and abstract this detail from userspace.

To avoid undefined behaviors only offer profiles that are commonly
advertised across multiple handlers.

If any problems occur when changing profiles for any driver, then the
drivers that were already changed remain changed and the legacy sysfs
handler will report 'custom'.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * rebase
v6:
 * rebase
v5:
 * reword commit message
---
 drivers/acpi/platform_profile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index e88b355a72112..7d774c43f4fa7 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,7 +10,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -400,8 +399,6 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
 {
-	if (!cur_profile)
-		return;
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
 		class_for_each_device(&platform_profile_class, NULL, NULL,
 				      _notify_class_profile);
@@ -465,9 +462,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	/* create class interface for individual handler */
 	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -483,8 +477,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
-
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
 	if (err)
 		goto cleanup_cur;
@@ -492,7 +484,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	cur_profile = NULL;
 	device_unregister(pprof->class_dev);
 
 cleanup_ida:
@@ -507,8 +498,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	int id;
 	guard(mutex)(&profile_lock);
 
-	cur_profile = NULL;
-
 	id = pprof->minor;
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
-- 
2.43.0


