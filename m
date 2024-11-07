Return-Path: <linux-acpi+bounces-9388-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047F9BFDF7
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D8B1F229B9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398F1953BD;
	Thu,  7 Nov 2024 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qlpJPxdm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66B194ACA;
	Thu,  7 Nov 2024 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959417; cv=fail; b=NgjLj1OQ+QGBAdt/NPaiELcEgAq/wSreszASZK/A13tHLyG6JmhPMXt1oFMrS2vOKEBttH56+pEZnzhIfC0Kj17DfWgsjCbh8g3K9BNlQT+r39uGT3Orw9lpoVcOCwi4E6whrlT8bdsJumM9wFPGVYha45tLvz3QMjvFh96r9yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959417; c=relaxed/simple;
	bh=qRMkcNUifXAtXpphjU+checUJ1PxliYj1y1hj/6MSRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChXBMTmthbxzRUK43LphI0kvK26iEoaZEM5S3nc6zEpCPmRN4A30zSLK6sc/GGKiVgfcpSgiYwt4XBUIfR6wOfzEOsHgbYrHiMXQAu/h05z79/WQX8WYjgwnve7tpe9TGhMnMXDoYOdNVY5Rehf2QZahPboYItIH9WfDJlK/xnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qlpJPxdm; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSK1urzYDmKgs/r5nGXyd7HdcdpEyEx0X6gCF5L+nuaIpXjg14FIVmWaQYoBX+pwntEqubvKuX+k0/5oQDeuLrAnNweOgd5yHpU1EEEb6SS3emQhJNUxFl5ytgOuuTXuHQuxwBbalEJ3Y8sEdIfj6llLwqrPQkyLh4Yne5SaquxOYMuxfG4naknJ7j3sYzRqai6ayIbIzP2+XgyCUXBj+HrSP6JwHvaURGDJ9ONtN4txL59MYjpmTT3A14m+8lJI1ANDC8s2M1DjejWowZkbWdY4NZB6wQjz9hTPJw++HrxOdxg2o7vgevZ3bJs9a+ZrWb3T6NXjlPaq2IdruD/XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT2khbTtZ2PklkeQ8e6PL1V7vzlpvNCYOcZuzpHGU/Y=;
 b=Ol99oQuH9K9Fe7xpe1y+lYhBoIT/q9k8ll+nzK1BCOGqfAqvtG2Kx21WC513CZGDLxN96/4VzlaVNZFTOj5Lp4dTS/8gkQs7jHlPKO+rA1+DPG+HzcVyvCnMKTBqZnevwkjbGgidNXTQC8jg2xH4879ePQLSm5pteK4PMHQktJUV41wyNJO1PEK01J2GWW65lYN8d2rzZZ5SV/JjVSo7/CpG/5750EcDz/Oka1u2Y+eCT/GS6Op+U4gYKK3I/kmTjnzoJZg0ZyrAB3CpohJJ7k50UxFWxhEYTz3soqrcsnvJWq8huJhF+Ach0Wwp0jXmJImWx9jbShYFVLvk4D+0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT2khbTtZ2PklkeQ8e6PL1V7vzlpvNCYOcZuzpHGU/Y=;
 b=qlpJPxdmBUtzsThAkjfbpDODw/hrTZoe7elO7vSaiwCTeweMQUmEDsPleyOP7kdL4a2IQo34asn7RMIi9EcIhFL9PCDS3SfGnFJ69lVIdiWsXgUkXRqAhP0I+50kyRSSUWHRvz+MR9tqw9EoSwqoDqmla+s6rbU8FEh21+LBWms=
Received: from CH2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:59::19)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 06:03:33 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::ce) by CH2PR03CA0009.outlook.office365.com
 (2603:10b6:610:59::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:30 -0600
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
Subject: [PATCH v5 04/20] ACPI: platform_profile: Move sanity check out of the mutex
Date: Thu, 7 Nov 2024 00:02:38 -0600
Message-ID: <20241107060254.17615-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e1fc26-143f-43cf-89c4-08dcfef1e930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0lBZWJ2Y25BU0hnYnE1UDUwN2oxbEFrblAydFczQlEyL0prei92VEZWakVJ?=
 =?utf-8?B?UWY2LytHWUdzODdnRHdleklKZmQyR2ZaZTY4VGdPMkRKSzBEOVY1Rlo1VGx6?=
 =?utf-8?B?alVVa0U4bmtlTFEyNWpKa0wyMkdnK0RTLzZROVNFTUJ6NllFckJsNTF1akN0?=
 =?utf-8?B?NGFjeTh0bHNtMllPSEllZDVtOW4yeGYxSFN3U09tY29TNVpXdWUxVVpCRDdL?=
 =?utf-8?B?TWxJTE0vd0JiejRqYXBoQkRyMDRVaGxhYU16ZUZ6TXh4blEweGxkMktyb3RQ?=
 =?utf-8?B?K3VNMVp4UnFrbGxkSVpsblhYZG0xTDJ6ZWdNNzV2dFFkdzQzUEtXc3RBSlEw?=
 =?utf-8?B?ZjJPbW1WVGNqNnJXcHh0eWxvSmpLYUxubGlyN2wyUmFYSlZLbGhYZWhtbElU?=
 =?utf-8?B?UkErQktES3lOUTc3M3BrSEc3Wm43Q3UrNWFFUDlDQWhaNkRKQnpna0JtUHJw?=
 =?utf-8?B?OVREWUJQWmFOL285bDJVSXJQTnEvU0E3RU0ySXEzak42aHN5Y1hOTElINWdz?=
 =?utf-8?B?bkpPd282QStPaERMVXZGbHNyak5qMFBWTVArWStDK0NCU1IzM01UY2ZaYUYr?=
 =?utf-8?B?RFlPWjN2ZG9BUWNINml3ZnhHUlBvMEFpWUhSU2JYRnBWbml5S1pmYXRTMjNi?=
 =?utf-8?B?K1RUbkhUL2xKai94eVUzWlBybXp3VjMxZzRFL3dzTVp1azJ6ZVRNcXBwQWR2?=
 =?utf-8?B?cHNiMGVMUmZuNFUwbktwSDdvMHNqUHFrRTJKeUZDdFE1L0EvaDREbS9SSTBq?=
 =?utf-8?B?bWpZbWxOUnBOeU1FRnZxd2F0QVlyUHIwTlZodERlUHo4SjNMODZySlgxeFNl?=
 =?utf-8?B?WTZ0RU9iMURHVGF4cDU1aWJSUmZ5YnFtSGxEVzRoenF1NWFrYkt1UmhCNkVx?=
 =?utf-8?B?RDNlRE5mLy9nbWhRWDF5bm1TMnBZV1dWNlNpNlJndk1vWlRNZ1ZyWVhyckFV?=
 =?utf-8?B?YWo4Um83SUFIbkZtME0rb3lJTTZTa1F6REo1UzlsTlZkdDNmcGVCR05NNXRD?=
 =?utf-8?B?aHd5eEFYOG9mZEZIbkxNNTdoWHI0WGR3MWRUb0k1Z2ozWDY2enFaV0J1ZlR2?=
 =?utf-8?B?Y1pWaWlMSUxNb3RkVnV3ZExhMERnWnRiakszekFENUNrV2RrZkxaNENGYnpW?=
 =?utf-8?B?OE5PNHo2ak5WTmVIbWo5TXZBQkI0bzBtNGpVSWFYT3IvMHpwVlpmQ1JhRjNL?=
 =?utf-8?B?TllRRk1VNks1Vk1Bb3BySVhCMW9tRXhZbmhRWk1yN0RkclFSQWsrQnZncGlV?=
 =?utf-8?B?VlJTWDQzYTF3cG9Ka0swdHR2ZGZkaDk4eUpBS1d6V1ZFN3BZTktrdCtDNWxZ?=
 =?utf-8?B?OTBzSjYzZjEzVXhsYi9mZDlFdHZVVG42aHJsNDBxamxiRXBBeXc4ck83ZjdQ?=
 =?utf-8?B?TW5IeFhBczZpczRTV1Q1eGNFSTlOMlVlNnhHS3A1NWp4Tm92THkrSlcrQlZi?=
 =?utf-8?B?bi9EQ2Y1SVhldnViczlYN05BNkxxdUdvYVJsNmplRVF1UXpBeUt5YkNYZVQz?=
 =?utf-8?B?eDhBQktEUFg3NkhYVlhMVnJ6TktyRlUvVW50Rk9GQVkzTzZUTzBpWVhEWVQ2?=
 =?utf-8?B?dXZOR0dyc2JVK09aSHplczRRSmNCeVhBbWJ6SGxUWHBjVjgyRWRTM1lIMGh6?=
 =?utf-8?B?QkhydUdkRnEwRGQ4dlB3d2RNejFTeWpsc2VrRVY4dXZ2RldlbU9FUG80WDRz?=
 =?utf-8?B?UWo4U2NSNHBSVWhOc2Z3UkJJV0IwbzZiR3M2S1VWMXVNd3UvZ2cydEo5Tk5u?=
 =?utf-8?B?RDV1WTRCbVlzZ3NxS1E3M251d2lkV2poQkxoZTVwU0VOek1nTXd1dk9HbGxU?=
 =?utf-8?B?Z0RRTS9qR0RUMm41VHNXWDVqeEJmc0ZJbU0xWVQ5S3VONEFpRkIvNWlMYmw0?=
 =?utf-8?B?RUYyeFRiZ01lN3hobVRpWjFnYlBRQXFSZUxocXdCQ0dEY0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:33.0894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e1fc26-143f-43cf-89c4-08dcfef1e930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

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
index c24744da20916..ce3aa1361721e 100644
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


