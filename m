Return-Path: <linux-acpi+bounces-9464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09379C29E9
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1569284530
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6B146D76;
	Sat,  9 Nov 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="COY1Kx2t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53802146599;
	Sat,  9 Nov 2024 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127354; cv=fail; b=XUuJx/walmlLl97XovPlVRskS67g9RGsUZBf+jIBE/Oz8KKGn99FV6JjyN5YqCIE+XIDRjMMWRIIfbQpL53hrzCoNDwnhHtuorCkGSndJ/OaIqbZHgu3oLc/eTBgO/WQtBZhXfrp1qALId9M1UJX4u+qNWxEw9hRWetJAtwA98o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127354; c=relaxed/simple;
	bh=qxZR0ioXhz7I9mrAT8p2DAj4zP/orxCZ1guCEIlDwcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSTsV94rXmO7iqJAXrtcD0a4gCdFxRU1Nb1gaNfIXaiNRISghYThNemstTCywv12Hchz6exk5toIiwon8xW+lNwCzZjHOv2W+wJatmBc8iG8vfJb05pSodFDViSwoIBuVMLHOWwRsdtuC4VH0nxoSkVpKU9jDkQiXX9MwElgbW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=COY1Kx2t; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlWCXY+RH7u32d0IGO/F6E6IqpCTRvqCnWX3mMztgEyE89c396Nq/SBaSUWYWAb0jKlCP3LiTM/xhfqKX5hCas1KtOFw3JpaiaKhe/o5c8+oxyon5Smf4CjMLCQEhXZPzIT5ABwEVfm7C2sy+MkfinJu/Zgnb7oBj7CzF/cO9Z62k0PRLxpdv6Ly5jPxB7Ve0xAX3xGWXAQISp/MAi8xExslPKVLWwAE8TJz7AsGYEuTsCNpqm8LQc31QgCwlXWcWiF/0VgK3YA7vU8eIQCmf+p+5gdEwVYebU6X0U2dGmGQnY1yhlRPM6DddAGu+5XAVONlKqf+x80/khZX7rn4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb96Rfxdmtyo0JIpdtirBRC/6HMVRjTmHsGHHm4KVnY=;
 b=HSCBrXYmByMYaxv44Ge+K5uiA2OZTxLLggZ82lk/CR6cQFlM5JbWx71iFREU/Ovl//chIFXLPO3W3/1guSIR8Vtx91lyV7jiyNsz+cMjMFBJzLI42O/G2BmiOtZtZrrDEa8LRtT1oThcTotQW/jjMEVP2tMa2APj6jXoXe8xdnCuEgD+w89hDwS3vOLKpLYIHR29xdakjAB0z08lgxSjrn79NiVWNMjNvCuJyegW5QxwkUffwqOA6xU3lsl4FyGudTbZ8Fa2HRd/kNjN//8fMAO8JbQSObZEN9UJtjcTMM0laAHweDZBC8C2oETP0k2JSbbjsSKvXzsHFL/ur8sOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb96Rfxdmtyo0JIpdtirBRC/6HMVRjTmHsGHHm4KVnY=;
 b=COY1Kx2th7qMioNVYodIB8AWqiSubSJipJpeisBY3q2JYEG7UPG75Wmjldmi44SJRnXFpxjY75sGGX8VFKkJDONzeNIobNP3mxRi3k8XWg8Rt+nlysnrYEOR/Xxyo/bmZfmXshG1GaugLbUTa1QjQMtb+bHAMxfTcBcBWvhcxMU=
Received: from SA1PR05CA0021.namprd05.prod.outlook.com (2603:10b6:806:2d2::21)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sat, 9 Nov
 2024 04:42:27 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::55) by SA1PR05CA0021.outlook.office365.com
 (2603:10b6:806:2d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Sat, 9 Nov 2024 04:42:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:25 -0600
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
Subject: [PATCH v6 06/22] ACPI: platform_profile: Move sanity check out of the mutex
Date: Fri, 8 Nov 2024 22:41:35 -0600
Message-ID: <20241109044151.29804-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 9365be0c-e2fa-4cb1-428b-08dd0078e9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFppb2RNUVQzaEhXdDU3aXpzbXlXNUl0NllQcCs2Skp6SXMxbyt1c2JPQVFS?=
 =?utf-8?B?SGkzTVFsZDQxSWE2YlZCeExVUFhzZkErVUN2UEY0YWt2K2d4ZUVsY1BJaHFU?=
 =?utf-8?B?dFhISVJtRjZZUWd5V1gwelhJN2tKb0FTWHlWenl5b3VZZVg0b1RHK3VvdVlo?=
 =?utf-8?B?OU03cDVCVXJMR3YrY0UyUmpZa1p1NHNwc0V2YlBDVXNXeFQrWXZSbG1JRFU3?=
 =?utf-8?B?UjkyN3NvczAwdTIwMmVYQ3JvYVA0QW5lUjFjcTdTVHQrK3NZSDc0K2tFMFF6?=
 =?utf-8?B?OENXZnJSRnFZNTljUncvUDhKY2s0NUJhUm1LbmhjekJyQzh4REVOVzFlNkUz?=
 =?utf-8?B?TElHN3dEaWxsTDVJcHJZKzdCZTNZdEEvdzVXVis3d1pXWC8zQVZYS1FyelNI?=
 =?utf-8?B?N0dHV2s1WGVZc0JpMGNUUCtXTFNvZDhqWFU4ZGV3NDFlWVEwU0dTMHowWVBG?=
 =?utf-8?B?Snh2MTJWYkV4c3lKbVBNVmE4UTJOUlZCODlZYjRsWnZQUjlRem5wa2NCbDhJ?=
 =?utf-8?B?S2VsQzhOU3dJSExQNTRJT1BhQjNHclRTejdvTzNWVkp0dVREUS9FdzdtQ0p3?=
 =?utf-8?B?MXordTIvdkx6S0g1RC91eS9DVmxxZnlybUZlTWFaOGJNdlQ1SWNzVDZ5VHRz?=
 =?utf-8?B?TlNhUlFScm11M2hZK2ptQzhlNWxPNHpNZnNleEdmRnBhTHE4cDBFMytZSmFk?=
 =?utf-8?B?ZTc1UytRV3VzYUZ6S1lBbVQ1NmE4YzZQaU5wR0hxSzN1Y1RzSE82YVV3Q2RN?=
 =?utf-8?B?REtQU3RuSTBDNG4xaGl5aTJkZGlMQzlPVE5aV1oyN0hOU2o4UEt5clQwZ3Qv?=
 =?utf-8?B?Q3RvU1dHMWh2UXVlOTViL1lvTlNySk5KYWxyY2k5aEFwbmJWdFE5NjJlL1FY?=
 =?utf-8?B?TVI0bzQyZWEzTEI3YmNyUG4zZmhjb01Scjg4NEpjeEh0ZjVuV0JFTnZCMnJQ?=
 =?utf-8?B?TVNWMG5wUkpKU1IwN1FPMm8rYzFzL1d5UFFGUFVmditjSm15VGhuRFExdGVJ?=
 =?utf-8?B?K2JKZ0NLT3duWWdWVldoSldjTXMwaUZaeEJycGxIZFo0UHpsWjJZRDBNTUlX?=
 =?utf-8?B?YTZIZml5UUd2cnAzWXlVZ1BrMDM0SFJORWE4aENoS1M0NXhmUCtsWGEzOUZU?=
 =?utf-8?B?K1l0VE9GSWlabExlMWQ4em5iTnliYTBWSlp5dzk3czd0OHRqVjdpZENiUmJj?=
 =?utf-8?B?RHhkUFJheFZocVhZSFY0MTIzZUNZMDA5M1Q2bDNINkJPbEZmTnUxWGR6Szla?=
 =?utf-8?B?ai9reG9LdEVGQ3hmbXNCbkE1eVI0T01GdU9tb3F0SXZNbXlTaEhiaXltNFZZ?=
 =?utf-8?B?dFpqSXRJNEJEbDRmUTFkY3VTdnRMOFJRWjd2TmdpWTdKU2d4SHNGc3cwZWlG?=
 =?utf-8?B?VHR2d0l6VlR3SEVXYjk3dWdJbnhEZzYwcWpZdGdPemp6MjZibG9pK1htUkY5?=
 =?utf-8?B?bUZNelI0M0FPd21RazVTUW81SGdKSmxnSmRQRFZURDlZUkt6N0FpQlhKZXNJ?=
 =?utf-8?B?UEJUc3hZeHdZYzhCMTIwdDFXZmZOVEJvK0IwdUs4cTc4VGJyTXRVOFIxamU4?=
 =?utf-8?B?eEJUY1lvbG9iV2Jyc2tmY1gxdktmUmtNZGlyMnFGODdubUdQdHpxSWNTQUE1?=
 =?utf-8?B?SWY0ai9zR2hzNUV6K2NBdjkrSXc3OENQMzdKN1Q1VFRQU0tzblIxT2NNUTNC?=
 =?utf-8?B?UkxacDV1Ym1VclBwSkpQVTM4eVQ0eUgzTkZ4emlISjBhQVlLalNBd1ZpeHRw?=
 =?utf-8?B?eTN6SjNKSWZuVDl2amdlcGdEcjg2Ly9OY0JEN3gzWG0xWkgweDNxby9iTlRo?=
 =?utf-8?B?TlBrRXZ1OXNMVWdFRjVZcXZJdHNiT2pmMGpRbVExWHBYNEVDdEIxci91K1Qy?=
 =?utf-8?B?a09oaVkyTXYwRWZrZVVuS3dkTno1c28xNHpPWVBTcnpqSEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:27.5495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9365be0c-e2fa-4cb1-428b-08dd0078e9df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446

The sanity check that the platform handler had choices set doesn't
need the mutex taken.  Move it to earlier in the registration.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
---
 drivers/acpi/platform_profile.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 927a2f7456c9a..4f5623fc27c09 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -179,6 +179,13 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
+	/* Sanity check the profile handler */
+	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
+	    !pprof->profile_set || !pprof->profile_get) {
+		pr_err("platform_profile: handler is invalid\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&profile_lock);
 	/* We can only have one active profile */
 	if (cur_profile) {
@@ -186,13 +193,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EEXIST;
 	}
 
-	/* Sanity check the profile handler field are set */
-	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-		!pprof->profile_set || !pprof->profile_get) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
 	if (err) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


