Return-Path: <linux-acpi+bounces-9865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05209DFA83
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CF2281BAC
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47E1FC7C5;
	Mon,  2 Dec 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TrZ0An3U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD11FC0FC;
	Mon,  2 Dec 2024 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118732; cv=fail; b=dI7/XD/12y+aR87mrPWCTODuRItpmDvE0f8CpsQX/ugcLDKGDBKpy28/+ouTqUyXPlYSUUEJq9IapzG+Q1QZCj7C7VEDopNtJIzi5YKJFCdYmY5W0B0tATdXzG8Hp7aB6wzmBjbu9CpFKGelwcV0/GJyfHIvSZbXm7DyRP5e+4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118732; c=relaxed/simple;
	bh=Ic1kSez1p5RhlfYjfiCieTuIGQgUojglIYTT9+//idM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skuo9zPGdYCS1NYmQnJd8EB9cZrRfsYEfxUFWcnJxRBV2ormG17jVJekFqef5oHL/PLB3Ba1xPrDamfB3YFBzof9y9FZwtwzUoP1J9V4Rp2daN+PMi+NvVjWBJ/5v/4QoP46/hxG7G2tT0iKDrWf2U/eLWCfLMIuzcBwYcPCx4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TrZ0An3U; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRjPPivATxZTlQlv/GQ1RdScJ3M0WTmXhsGjS6TAT50VfGqzdCMOQaKPFKpRBEC2/Q2UvOvn0QrL9CbdQj072Dp3zCyUQ2M0wBD/K5iwhXccRfdmYt8CiOGaLEYB1RMcZRYpogL3Yb8UXeVQlk9NzRR4/7chASS2QrGmaHIB+vLhkT2LS/BFpjjnSmpCvdEZtUA7yGtIrJ+lW/m3Fk9Uh5xDOBipTI53sW2Kmghzn59gbyiSQUoHHYHvyl3CY/g2kAT8FoCGwlyM+kWCWhHhJIx0exmMGU5ByrBVVmdc2LMrzu1o9DUKgiHJrgbrGIrprsmBtugsvrpvAAjO5BhBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZygNqvmrqxLlOcz7KlrmxmajDRP0uJQIhejUlstLa6Q=;
 b=wvI6K/0NCmNtG0MYczf3hWG6YWeuuhXr+22RZcdFA76cxWXfC7QfXc8bwH4Pyw8RUpGdb3LqraDQ+JzqlmvekIxS+XA/ERKA2NY6QxvWPSUBJjbtH/jJS5p8DG5SFXSdzmCVqabHjLl/j8cAYoeGiHeBPX3KDqdfzqOsmX1ew3xyGMYM+bxUPvNJL5ItVl9llZkCtTiaMlFypMkosM4DWsHpA77ferLYI5Ms/gZgYVvfrRzMT72afHiwhslme3X78fdwbAZMehOBJs4TTPataba/IX1g9I9Cdjmf2YVxKXzeu5cjzKsFcLfuMCNkzYktqZKaGMLmvEylFkDMbCca0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZygNqvmrqxLlOcz7KlrmxmajDRP0uJQIhejUlstLa6Q=;
 b=TrZ0An3UN7w6I3wBedGZGhh7/tjMA2vc/81b/DEN9A80DCGt9j6DUGFiarIhYYdSF69gSRgthGmsojkplI5QDpIGG6t5vYRUfv8QNjBxiqtLThIhxXpkWur3oCsAGfE4ThZeTN06ho9ehAfpprgEBE/UQYAn/XFCKl5JZySKy/A=
Received: from CH2PR17CA0007.namprd17.prod.outlook.com (2603:10b6:610:53::17)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:52:06 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::75) by CH2PR17CA0007.outlook.office365.com
 (2603:10b6:610:53::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:52:05 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:52:03 -0600
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
Subject: [PATCH v9 20/22] ACPI: platform_profile: Allow multiple handlers
Date: Sun, 1 Dec 2024 23:50:29 -0600
Message-ID: <20241202055031.8038-21-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0d80f8-4799-43f3-09ae-08dd129573d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dTXJGJ0QkUll72ZrlLNjoqxHiW3Wq0BUTn2ADfiBx7l0NyB3o02DIPnXiF6o?=
 =?us-ascii?Q?YHANMAYwBGgC5snvEHlfApyw+8F+JAy3Lvx6Fu0iO11olWjYcwH1Nq35n/YV?=
 =?us-ascii?Q?nSoM3+WDC1j64ByNCbF7lNCc5/BYFVRqWFrCjFE+8IMtjxbtnjR8c0/0wtP7?=
 =?us-ascii?Q?RH93uilx/zDIbSTBBKjH67JIL3e6dsWI8XOCnUcvhYh+Wo2xAoPeNFBXaMvJ?=
 =?us-ascii?Q?iDSKhJrYN6S9b8Nzp/GL2ij1H+E0SV9JkTFIySubvCW7uaCKMk5ib3DzaDUR?=
 =?us-ascii?Q?hYXApbhX4GApG/8UE7FDCeenSL0AjhApTpaY3uAUag7lW1jHKC/n0ihYqIUh?=
 =?us-ascii?Q?dBjdagvBAaQWu1+kxkVqPkHGVlzpj8EeP8CNsPtWXOWayFh4oBXlzTJ66afB?=
 =?us-ascii?Q?pxOZineMMUVfekNaIaIK8qwcUbBhTh3Lc+zU0tQtLgj5BCtBoRHBFigcWyk1?=
 =?us-ascii?Q?es6OUX6BOc+iZl/0Hc8mwCgghZ/Iux3BR5N+oIGUR7WEC1ktTYAVDzyv5+UJ?=
 =?us-ascii?Q?0LuRLMKMWePQsNCYIxDmyFUpDS7XVfjHpTlBzbnWI64KWTkfY6oye1Il09wG?=
 =?us-ascii?Q?PqsEDYVp99jAVhtUZwSe/+VCgZz1DKcJAUzgv+NdCqwYoO16N4z83JByvvqo?=
 =?us-ascii?Q?sCialKl3cB1FVrFJJg8TczGj2QsbIVXd3u3I+AF9WTr4PrHYIELHAqkkUwmm?=
 =?us-ascii?Q?ltndavsaw6Dhb/3ZG8PlZrkraYWs/1jibFFk6hdw0FGDLwslAp0QaWsh6Y7L?=
 =?us-ascii?Q?7kp/Emd2Nad4pWsDG/C6NFIngJK7cFjWMt6onCx7ZpVNK0EE7J+vjLgzlON1?=
 =?us-ascii?Q?jSLZOaCewDjMxYS823ElbsWQgohIyJ8u4uSYlXvpuH/3dHPws8Q5GX2/Ymlf?=
 =?us-ascii?Q?2TP1XMtKpxoYOUjBW+G1OYuBUinOomUw8AunV5HAtatQmKdmKpEFoQplHZL1?=
 =?us-ascii?Q?wyrq09nOoRBr6FkCAvetcz1HXNfKZYnAX0VQS0y4bqXT1F8APYJc3gOO7iim?=
 =?us-ascii?Q?YjXmvtodsQoKlZJGZDpwtk29KWeIedzmpERmBQ9EK+3sqZHUe8+H51yhLpj1?=
 =?us-ascii?Q?KeAXY5veiJhrnUbJTQ6eH2Q26G/wmNYaf/yMLjmJwIQKbxec3A+J4OtF3jiM?=
 =?us-ascii?Q?FfbJGheCb9yHGVGMzYYfytevw38LgMhT55+ItjxTT9FwHWKIhm7eY6unXG9u?=
 =?us-ascii?Q?7fKMxUQVC9R+ScJ6EyIcnaz5WondTAe8jSCr7TAFQPv4OUwkLGnaeVXoYbv9?=
 =?us-ascii?Q?h1A8+FFWa75ff4uE+aUHYkVu1V9MzOsS6cPwrAd4RjAGUiY4uYASxwr4uulI?=
 =?us-ascii?Q?VVOkFHf2v0FAJfgjqaYG6+GzrFYcjvBKXZ/tmdLOXWT7BAZsr77f+Hr9+Mxs?=
 =?us-ascii?Q?+EyTagjaC/SpTBOXCSNWlJWXFgLnoTRrPpG2lNk8VXLy/VK4SQbJEgBe3uur?=
 =?us-ascii?Q?mMGP5yFPqcDxF4EEZV2QvBMdyjPI+Ov+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:52:05.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0d80f8-4799-43f3-09ae-08dd129573d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

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
 drivers/acpi/platform_profile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 289b5d43638ae..2e38aa410b3ad 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,7 +10,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -399,8 +398,6 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
 {
-	if (!cur_profile)
-		return;
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
 		_notify_class_profile(pprof->class_dev, NULL);
 	}
@@ -463,9 +460,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	/* create class interface for individual handler */
 	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -481,8 +475,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
-
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
 	if (err)
 		goto cleanup_cur;
@@ -490,7 +482,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	cur_profile = NULL;
 	device_unregister(pprof->class_dev);
 
 cleanup_ida:
@@ -505,8 +496,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	int id;
 	guard(mutex)(&profile_lock);
 
-	cur_profile = NULL;
-
 	id = pprof->minor;
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
-- 
2.43.0


