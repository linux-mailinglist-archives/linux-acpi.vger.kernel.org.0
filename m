Return-Path: <linux-acpi+bounces-9809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4B9DF0C7
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82810281084
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9901A9B59;
	Sat, 30 Nov 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vwyS8QH9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037319E810;
	Sat, 30 Nov 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975545; cv=fail; b=DowBcg1y5AOChr84a8GrYsSFZNUhU09P3PHADHVQNj9tfYgQmR8HhgxbdnhZIOi2ritiTr/zJmKftUB1zD+pjQe+Id/kjBMNSJPZCTq1VCCU8pBRpyWgH4jhpJNuQy2bQKijizrbC+SjQYxZMGIxOMp6Vlr6BABTwKka1zXwJRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975545; c=relaxed/simple;
	bh=V3j6Quiii/WwfOPqQqSXcjQgntdEWqh0e4XnsPoRYZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lviAeeV0U9L1VX+hkr6ri4GT33BVkwfX0zQLxllv3nzbhuE0r2zbDAPf1P/Qa4DsJx6YX6yKVgLCVKOIRtBslTZ69OYSR0CLu1oH6T+cUKTUW+VMscTuxyoK5XfpwyjCIhGP0LYn3zpylRhsOtqcGOyI0Z/Sr7nInQC+0kB62tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vwyS8QH9; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPDdZcHTH6aUjoE8I8HJ5UuSv+kMDAiI6BM0c8PT+6vM7S1VXepaL+hbkr/L3ZrL/kdTdfaDyCuZZwt4BS9m53zSmo73mt8WFAfEg5BIORgH8/XPHsJUb7Gs52yhTMuSn6vgfqSlCgWYbHhi6TghWC5aDCE1fjGd6YtwBwrTrZOQ20Smt7PbUqmUNzUdF64E9V8pG4kV89GvwdU0S0k3PYqUpAnFtGEfzt6kkgUKNxo9KvDxpSdXYT9gTX2X2UGMqA+C8KOgKx+dmgQX5dPN+uZQ4GQzjY9xGXzH/13SVZQ7aSuu37S68T3NPFtGOZ37xnZFFPX5gsUhVuQdS/c8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFzS4aCzkKI1sKuTsJPHF2D67+jU+JB8yqsEk0kOkA0=;
 b=im0yF9FdmnEYIz1EDgSs84Iw5tyYms+5SOA/rkluzN1FWOAnS2Nzk2go4gfQA4RQxi/6aZYGgK23lBRDGV60LvmLWDzsSWAv1XJej+cLx3niYmDyKDDhebS7W1XMTjzh3Rie7TFjciBJknGiB2Wih5oZCWMmNoYqNgkRBfUOC57/yFTT2j4SC6VC/OMAgzZeJsw7STDhNqf5leXExw6wV6oBnDHmcmgMJx7m6l18F8fHDdSOeEuYBu8M2bR0lZ5OqP0GqgqE8r2GYqKKniTkxzwcWVSOtUxGSlwX/x8HiiORUuzI4xs4PQSoWn0mZ0pHGJy8ujMcdXGLyDBjjuFpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFzS4aCzkKI1sKuTsJPHF2D67+jU+JB8yqsEk0kOkA0=;
 b=vwyS8QH9hrRqL2PP3N6VhxJmTYPZ2Uabf3FU558UuLJv5FMdhaoiU0liBJKl2Ws0cfbs2Gd5rdZrsxLGbLxQn3eJd0WJlXArqA5ajB2PGolZwhtpfQQLbdjkuXQOR24Ru/cMpURDsb/1o4jN8OTXfriApgnnvcREntMGBd4rwWI=
Received: from PH8PR05CA0014.namprd05.prod.outlook.com (2603:10b6:510:2cc::7)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 14:05:38 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::fa) by PH8PR05CA0014.outlook.office365.com
 (2603:10b6:510:2cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.6 via Frontend Transport; Sat,
 30 Nov 2024 14:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:35 -0600
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
Subject: [PATCH v8 09/22] ACPI: platform_profile: Use `scoped_cond_guard`
Date: Sat, 30 Nov 2024 08:04:41 -0600
Message-ID: <20241130140454.455-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e2d806-bfcb-466c-debc-08dd114810ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG5PaDZnclVFNTdvVU5WV2R1SFljQ3VxT0YzbzI0MHFXbnkvd2JzVlU3WUg3?=
 =?utf-8?B?cXBKelJwYng4T1NodHZZc3hELzhDWTFQUGJTYmdzUlpqM2xRdUdMdjFzMjln?=
 =?utf-8?B?TmlWeEdKTjB6eGNwdHpHZTZKbS9sYzgwV3JzQXhwTmZ5RVpyWjNoa1VjZ0lx?=
 =?utf-8?B?c0xCOTIweU9tbXcwSnFiN0RPUE0vQVZIUEUwUkpKcmhFc0JZSlpLcmY5MCtq?=
 =?utf-8?B?SnJmeWJ1YUVHaHRnLzBWQjdOUUVwMzJCV2wwd2JtOE1Ma0d4WTRaNFp0YXpG?=
 =?utf-8?B?ajNlZkRURmFtK1R0Mzl5NXJDQmphRjZwNHVOUFVIcEJUSFY4TGhpcUlSdUxQ?=
 =?utf-8?B?Y3EwVVlHcVpyMjhGWVFIZTZoLzE2OEo1MkE0dThJMEV1bndYMzNWQnB0dVVp?=
 =?utf-8?B?SmRMRGszZFJia1V2bTF2NFpvUzVRNVJQYXZzdHNGUzVKV01DVmcxVmZpcTBh?=
 =?utf-8?B?TnFSSmk1TWNKZ0FWWitHREpQbFdXcWdBRmZQVGFpbG9YTTlSQVo2VXVjQXh1?=
 =?utf-8?B?MzhxU251NExpeDJyTlVWNHhlb2NLeG1qQ1VQa0UrUUF4RFBjSlk2ZEJaaTFY?=
 =?utf-8?B?UzRNWFFHWmdqK0grZUZHOTFoR3EvdUU0OStUb3BhM29XTEVwTHpHWUsrUXZV?=
 =?utf-8?B?UmhGdG5SZHVRR1QxMVoyaVBoQ2JHVkNoUTZ3SVhnUzk5TStkS3pSRHVpOHgx?=
 =?utf-8?B?UU45KzB1SGV1ZHdTSnlaYjBkWk5yYmZIY2p1YjRzUmljNzJpa01GbVZEZHVN?=
 =?utf-8?B?T0Z5STNtZUJIL2FGU2FtQVNMa09hb2VTcXRWc3dBd2RVNHZQY0crSDl5QjRE?=
 =?utf-8?B?S2FJR3ZLQlc3YmxHeEtsOHk1ZllQd2Jta3cxb3FnZzFnQ0gyM0dEakM5bk54?=
 =?utf-8?B?Y3QyTy81L29uVUZON2xBSUVNRmN2OE5mZ0pEdmNNVHZPbk11QTA1bkV1WVZT?=
 =?utf-8?B?TDF0VEE1RG5ZLzc3QVcvekdEVFhwak90anF5QTJ0UUxZSnFaaTRoOW1SeTVw?=
 =?utf-8?B?dkRUVlZzalgzTzI3cWxuU0Z5cFVUTXRtdG95VGp2YlBJMFN5TmRJUzB1dXI4?=
 =?utf-8?B?aEhqa2xHMHV5VE1OWjFOcm9pWlBkZFpGaEpMdTZadTd4eHladlMwUHpuUDNV?=
 =?utf-8?B?Vk9pNlVpbkhldmZnSWlkMGF2NCtpVVRVc2lZclZGR2tQcXZ0SHg0R0dDbGZO?=
 =?utf-8?B?dERnOWJRQXhTaGorYkZIbEhQZTZYaWFWSjVxYUQ1czBsY1A2aGU3c2E4ZVRV?=
 =?utf-8?B?d1N4QXYwRnluN0NBY3RrSk5zZTJMUVo3akZ4SjlkeU9yNnhHbGNvcElVVEFF?=
 =?utf-8?B?NGNCYVdTNnJPemlXenA5OHYwMHNsMzFhTFBJNFd5ZXF4U2J3Y3BpQTVHNXFE?=
 =?utf-8?B?dld0WWppZVZ0TGdkS09RQ3lPR3hkUUxCd2VNRFkrc08wbjMzdDhoY0FiRzRy?=
 =?utf-8?B?RGtzZUxLV1RXTytoNEJZenVsTmh4K2RHVDc3TzBSTm5VQWFMQUhjZkRvVDA4?=
 =?utf-8?B?OHhhN05QK0tpdWNNS2dXZDJqbXlRdFZDclFDaUpaY0dEdS8rVmQrTkQ4bGNU?=
 =?utf-8?B?RllFOHlIM0NGUFBTeHVNYjhtZlNXSHp6U1ZDcERacXIzZjVJQjg1MjI0dzZj?=
 =?utf-8?B?R2dDMGhjT2RMWTJ5WVRneFViRnVlY0pTY3ZRdFlObW1nazJtNEwzUG5wQlRh?=
 =?utf-8?B?QjkrNzNLN2t0SlV3U1UzZzhPSUJhWlZBYzNXWllpM2VBbjc0TVQ3TDdBYUJh?=
 =?utf-8?B?eFlDTHFaR0lkSmhDV21wT213eFpLN0tGMTNSb1AvK0k4cGVpYlRhVXNDS1Iv?=
 =?utf-8?B?UUZFUVJNSXVWaVNIMzdGM2hlcDg0Y3F1MGg5RGFSbkpocVE0Ump4Z1RDSEw1?=
 =?utf-8?B?T2ViOXJEVmxXRWlyUCsrOE5HOFFnOCtSdzYxd0Vjd0hrR281WTVjdW5CKzNT?=
 =?utf-8?Q?aXkTdQuiQzqrwuLRdnpZ6vz8dlUIZv8K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:37.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e2d806-bfcb-466c-debc-08dd114810ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Migrate away from using an interruptible mutex to scoped_cond_guard
in all functions. While changing, move the sysfs notification
used in platform_profile_store() outside of mutex scope.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
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


