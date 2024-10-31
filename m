Return-Path: <linux-acpi+bounces-9166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40E9B738B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C43E285A4F
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6FB1465AB;
	Thu, 31 Oct 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PIpjrCoI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE3145A07;
	Thu, 31 Oct 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347837; cv=fail; b=YX+WRON+t+LhMahN7axoT2uJ8Gb/Q9/ijUEgG3q3adKcozRPv6qF1RMviy87kvnBWeAmMkdcrYGXj9u9UbqAsQdsiY4EXSz1775aYoarixw+H/Nma/bj0m+59wnwbtdMCF+41U/C1539w3mtTM8TR1+4kzrfhcq4jMjbGEj/ARY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347837; c=relaxed/simple;
	bh=lITivSxWn7ZJIFuNDUnBiffU95HVkMnsOulfhflcTWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6XAdYAXUaiqPUsNjzChrGNNuPy6WhMJeQufKT16tmy4REf48n4Gfo+lXIcmn0DumnRZ73+3hh8DIgLg6Y7GR6UYXwIRBjqQ9j3ngEm+8unT1bDBuMsB2SdcN2qFMwj2VLiwdySOoK7cq2zGvcu76P1YmaHoX3OeLxPONYqqKHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PIpjrCoI; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS3ShhxLyPD9w9da3mfGmLzNIwXfNw7d5pE7p6mtY25ue6oucefNpEJ/ZL7y0+HEISbfxcBFt2CAVU3CJRlHuD3wXvBBhUZw8EMHSqEDk/BYZiR/04o9XCN5lgv8H8Cim9KwACV/zLeeqGUlNLMeEHWGucVDVHQew/ytbHMPGEMgu/A4TERP+cPVfFBHv5rnTfFcr9f+UmMxCPUEQWYhEvn5oz9BpSjeScSCb3Syk6GDyKvzuhc35ahk+jSTmyAiS+d7xigFFqbhc5qM2FMb2lpp9mxUGk3niyP/nIjaqkHpsllVCFqWrzt6E5dXr/Q5GHkxQNz/fQvrshD8GKPkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhE5ZoBZMfpPu5FgwOwo7akoVYoJAzzRoSOpdj2fwyc=;
 b=avxHlnf7o7bFCuv6qwfqvgBnzrn4kwgbrJRmOLHXKA2UWAmmH6c2KesLb5eeUT8fDMG63yQTci7eri3Qs7/wwXuhveuEujdwVFWHs3e+wRJygSNSdK9Zt7+BO8cXDIVLi4z8QgKWI1has0jDA1pfPnllIZmef1oKRalb+lm28wjxwMyWsT93L8PjN4xoke5AyIAst6s1HnuUaSvTx1LNqlcmqMYyD0jUqrjEz2W+35RWB2fFdWzucSSE3fepn3UfBS2tq0ITEMYijqai/00GWG7Z1W6pBQintHDMkiI7fq4wmK/rk++r45HL9F4tb4bZTstXUo/J7EBRXTLGQfhetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhE5ZoBZMfpPu5FgwOwo7akoVYoJAzzRoSOpdj2fwyc=;
 b=PIpjrCoITtWN8KQj2TVgQWuBU3ppydIB7UrxonPyUTx+eSpVVDmDuPUVT3nQHSWIN7T3BwHiTLruxTfsZEw43r5964ohefDlE+EsUcJSItVeIg3V7nlEZM50aE2Q/+y7aZanusS9pA1ddgRFzLlJ3agAMxUtjpNHkWeqRGvSMA4=
Received: from PH7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::31)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 04:10:32 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::1d) by PH7P220CA0072.outlook.office365.com
 (2603:10b6:510:32c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:29 -0500
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
Subject: [PATCH v3 06/22] ACPI: platform_profile: Move sanity check out of the mutex
Date: Wed, 30 Oct 2024 23:09:36 -0500
Message-ID: <20241031040952.109057-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fad3cc9-6d33-4798-305c-08dcf961f6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+vPwNnOU0BeVwvUil2u2doryU/luHtN6PAFO5+GUcX5P4qWpTuI41izdn/t?=
 =?us-ascii?Q?7oHj5+jV6azQXILWbJVpqY6LNFOhwOjlUHqtsMDIMFGzHu2mTYaToAm/L0Ak?=
 =?us-ascii?Q?nNhOxg7d/tgX3jcC4egoFT/qZVWRPtMhyvd072ghPNgqunrRD084buc4SoHB?=
 =?us-ascii?Q?7Ers5G/abT2qRPQjbTRT+DsbGm67c3MOwKKsdmkPoR0oLqgnjfX9tgEsvPuk?=
 =?us-ascii?Q?pVnB4tHJm/U3BjUZAUrM5jsV3aDZAUwhYKhsAVq9VRTvs8LwwK3W9nrkE9PM?=
 =?us-ascii?Q?oozuVjiaLcA6oz7NwHOTw2HdpBegt5I5xQlFilMkxOPg4YRFSLXOIOzP3zWs?=
 =?us-ascii?Q?ZhcPQ1apnM51cW3NQ+0S97+gbH2rIQPVgsdXtTT6NdNE/cubDLuv7Ufcmxv2?=
 =?us-ascii?Q?7bLaNhiGHlXl03Zp0gwvD1Dig1JULyp2/Eot5Qhq712GWbfNEGzLkDS/cSB3?=
 =?us-ascii?Q?BelHCka264P5XECnytAMk09j9RHVBRduSYUU855MYYSPAbZawUfx3BZe6ciZ?=
 =?us-ascii?Q?TyrBqEz/27TPd/uz5ARpmC/xuCTf1NB6vrw6fvf7FgdfPCpOhUwPDbfrbsiG?=
 =?us-ascii?Q?MzmDpfuUMEtuIn+MUgu4f0KrWhkf+xAjqDkTVCKBAdYrjyR1k5rEbIcm6Ywg?=
 =?us-ascii?Q?4rPVcAZqOGw8G+3WjsRYnlHWgo3CzRrsQr0KwZ6HRPHEs4w7lnp4JVVbDkCe?=
 =?us-ascii?Q?IEvbLdOL8vnYZfPFB0fDFMx8AmLR/wTsuw3ceTVrnw43j18K3MidXJE9B5SW?=
 =?us-ascii?Q?hMummSTed6EhMn05opWeyix0cY+BbjMHTcKkDmFxeGFb4I4J+C9/amxW6iIo?=
 =?us-ascii?Q?f8Hv+C4mWjUUqG68BKhtqD5hWrT8UjaeKaatu553zpIKYka/aGkbIdRnn4ce?=
 =?us-ascii?Q?lxDpftW6b5gQ3FOsLCZlEnijmwHBCuU5TOeyA2EkrReBzZpWM0nM4Dek/vj1?=
 =?us-ascii?Q?DhBKRYKS2hmSsXQTo9Gt61DnjaMN/oLx0Y8QeXvYwj/PtBPnr7dYPECsIk+/?=
 =?us-ascii?Q?i2Ho3BdRUWWuvpSoslNTHhdzmL6eIUqyFD5DA3+d8vkTX6qmym8Eb0SAbPw/?=
 =?us-ascii?Q?1Syndt6ImPswoX1BbMkBvP/jGQC7ROSe6oKoe4LTtX7fbvo61+cLUJT4vy/M?=
 =?us-ascii?Q?XvjL8C1dSRufw8aUnGRUoSksH0X4EKldtk43GvZnuPIwhvXcRFLPdHj0BOXp?=
 =?us-ascii?Q?3yNclYrttiOxEc5Z0B1cKA5P90T6khW6rPe9+/6vJd6WgJ8C+dmsiCkANLhJ?=
 =?us-ascii?Q?DXNkxnm2vyT6YXgVMWcoHvSGUG89ryQ6ockrakr7++AuxEaEVV4JAmSgiGZm?=
 =?us-ascii?Q?bCARJ2l5zuKIUWgug84XN9mu+WcdkhpHmQWK7cHtW6DalGHdaQ0aZrNsobWR?=
 =?us-ascii?Q?3fKlQyCWT7eYY9HD68sGd87AONStAc3JhJy3MWKmGXncnVB4Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:32.2951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fad3cc9-6d33-4798-305c-08dcf961f6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

The sanity check that the platform handler had choices set doesn't
need the mutex taken.  Move it to earlier in the registration.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d0198d2ccb551..f2f2274e4d83e 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -180,6 +180,12 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
+	/* Sanity check the profile handler */
+	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
+	    !pprof->profile_set || !pprof->profile_get) {
+		pr_err("platform_profile: handler is invalid\n");
+		return -EINVAL;
+	}
 	if (!pprof->dev) {
 		pr_err("platform_profile: handler device is not set\n");
 		return -EINVAL;
@@ -192,13 +198,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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


