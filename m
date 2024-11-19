Return-Path: <linux-acpi+bounces-9669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CEB9D2CB7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F089FB319F5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAB1D2781;
	Tue, 19 Nov 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VojsyqSA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817571D26F9;
	Tue, 19 Nov 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036873; cv=fail; b=EpnLgkhfCSAZtCBCrf4n2zDBqgF0ri5hX10ildfXW3q5kmmeadiqXJp/EPcLCTGyEsIn2eqk0h3whCEDYRIZXVR/I8Li8zXfw+oa5SOljGZCqUTD9Ab6jNvI7pps2YV/vXDiHKFcit7UGlkyMvIz7h/WDoYngREtfjVh2b/1sQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036873; c=relaxed/simple;
	bh=tJ4DVdV7cYXpMcLZGQ2X1sYu4uUhOwjck0xtfjKy1Tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H72K2V7Z21gha7nv1i97xumt2hPHIj6x72Q4Ei2F12x/yYE+vjzWvhSjh3PH4GDNXS6ASHOMeOxgANMmYjO2kw2nrGXOTmvlc4jvfOqXI4oeSEEWZtv5DFbAZwFMKqERO6EYshpF0tvnZAyYufDJ5NQUnBE3ftg7H6jv7JqRlW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VojsyqSA; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDlmVAt0lzqGj4HtHEo0+BlJGPvh5Bm/Ga0gqkwolZw0+hH7LWhcJ3n+QwFvpGlkR/DHk0pYbqzBvzF2RgGtbAaf7wAv3Lg6GLJMA1W0RZRtRXYZQVoaMsg1aI9eLLZGHtifEeniHFL2ZC1kgWwT/5f3Y9m/aPpOOoFakRW2YNtFlNSNvch4+T2VMWjZqP1M/+zeT4hiGUwGIWLEx319WkIo3n8HStnPgpWykUI16kmny2PGmOCk65Qe85/OuClECt7jEu/9vYmF+iw9m0c64X9RBg5mIhFNCNcmkesh1ov6OtKwHragUCU3TB4wKPwXOjOUwphkbUJi+1Gd3L7VYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxHNLh8X+PGIiA3w7kI8/pf3Usx2TD2JwkiwHrhZM6g=;
 b=kmgRT8O0vgVQ3zYYpVYjdRYrP2rYJVts49C1a2y17aun702W6G9ffDLTERR08p00YxLgHhxGmZcDCuHnbAyDf/Unu/uEwQ8MwSiiX+yvy0ipMfglhQWVQenEFdnmHR0E091H2P5byZ50mGMECUYhBC0aCWPwP2oWDtN2N7EQx3iv+IQfg+y3otzdIpas3I5RGVYvF56QLt3TJdYWxq052fIWvV9badTvsc2xSgW9jZsf9hNnnT3ZKD7zIg8xOub2TClWTntywEALbpnFdNA9c5lFuXB11MvYwNyp82EWFfW416hdVxxybO8aQqjruBtQrS50xhZrxbMLWKjVebE0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxHNLh8X+PGIiA3w7kI8/pf3Usx2TD2JwkiwHrhZM6g=;
 b=VojsyqSAqUj+KnzjrHxxwsWnKoHCzVVJOxaHi99SIoOFMS8TObLNUxZ7rFyt9Bh5fSw0Eo38vgZ1aXPrLhHw/FbjvMhgFSXC7XfIlrfbryXf5wEu28zTEuEFjZ2bNeuMNWrCQPX3/C25kO/8CvG18eSwDLyM8Ydn2tsSMQnr7D4=
Received: from SJ2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:a03:505::9)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 17:21:05 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::64) by SJ2PR07CA0023.outlook.office365.com
 (2603:10b6:a03:505::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:04 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:01 -0600
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
Subject: [PATCH v7 03/22] ACPI: platform_profile: Add device pointer into platform profile handler
Date: Tue, 19 Nov 2024 11:17:20 -0600
Message-ID: <20241119171739.77028-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c52dd9-1a41-497a-114e-08dd08be8c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHpnc01mVGZqRVNNRGtDeGwrSXBESE1uRTkwVnYxa3ppM1hYNEw3ODQ0RFZG?=
 =?utf-8?B?WURqOWtrZHVMRmZ0RjBINnkrM3ZPMCtOYzFiZXNVZWR6Tis5ZWlkbHFWMHhR?=
 =?utf-8?B?Uko2UGlZK1ZlOWdLUVZtb2kvRjNBdVl3Y3p3bVl0NytzTVY3SnpvTEtHY0F1?=
 =?utf-8?B?Z3VhbGcrdUhKRWVpYWFaVWJLQWtvQW4xSWtwQSs0T1VVbkJWMHdXKzk5RHM0?=
 =?utf-8?B?bGxJbzBNWU9SMDNha1g2WU5LSWdoTE1PcWFZOVhuZ0NoaS9IMjZpMDhCbWZs?=
 =?utf-8?B?R0U3V0JyeDdZUk5yRmwvOXRpcmtHT1JqOHUxRU5GZndheUg1cVNOMW43c1RS?=
 =?utf-8?B?ZWUyRUJiTmRWSnVJb1BibzgvbnZ2WlhOZ0Q2bUJkSnBLSkNoN0MzWDlWU25G?=
 =?utf-8?B?QkthcHFQa0tNN0xCaFJMM2RuWVF6R24zS0I2SW55UE5mb1pVQU8xVjY4VHh4?=
 =?utf-8?B?NU9hb2FaK2diaVl0ejBaYzljNXlTVjEzc0RhNUowQmtoYnNQUVJ5eEMxUElu?=
 =?utf-8?B?bTR3T3JWWHFrVDZOeHBCWWlNQk5qUHlzK2J1ZzR1Y2lWUm00aXFhc0Q2RGlC?=
 =?utf-8?B?dXdJUHVPNVk3aXMrL3MwZk5ROEU4L213Nkg0ZEV2K0QzbEc1TUFUQVpEalJm?=
 =?utf-8?B?NytaUXk4ekJoanIxc3R6MW5WRm5lRkFEYzRSelAyY2Fta1FTQXg4WG5yOC9P?=
 =?utf-8?B?ekdSL0dOd0VTcjRNaytrVThvcGFCdmhOc0lWNUluVGx0azFHZVE0WkJDd0h1?=
 =?utf-8?B?RGhyaTF0TTNXQkRtTHpHaEJCK29TK1E5YVg1aGx5aTRBZ0FSSk5qTFk4QmtW?=
 =?utf-8?B?c0lNR1ZKVnpKanJXYTIyMTQ3V3hTbzJlVTBwSllpS1kxRlRhRkVSVjhyamNS?=
 =?utf-8?B?VFloeEROSlFzalBMTmtQL3hGZnpHS1ZRdTZJTStBRk5LalovK0I3Qmk5a0V3?=
 =?utf-8?B?QlRKWlFqMExiR1pEYVp1ejR6M1JGRitrcjlaQjVKT2lOeEN0NndKNFY2bmN1?=
 =?utf-8?B?bmhyYUFqMFRobEIySDF5MCtPN1ZZSFlkM3dVNlp1NnJ5d3pJL2ZKcTR3R25J?=
 =?utf-8?B?VWpsTkZ0TldjTGdzL0tCZkdLdXNHaXFhaXdLT3U2R0Rnem5xRjJmY0xQT1RY?=
 =?utf-8?B?dTFhdGp3QURENFpEc2JXZXdkMFcyWWg1WExJeGg3Qkw2RzlFR3lYRm43QUtn?=
 =?utf-8?B?cGFPVmF4bXhCOHExV0ZOTm1vQkdiVFN5SVh6N3RsLzVXdE4xUHVva0xCaHda?=
 =?utf-8?B?dlBSNWpLZDNYYWNoRlFXMnN0SW1xbFV2WTVId0ZVMjNxRElkU1p1YkxpMmR2?=
 =?utf-8?B?RFE1Ym9nR2lRbzFMcXhnL0k1clhJZEpRT0xNRVp3R09MLzM5cURzLzlDUkFx?=
 =?utf-8?B?NDZnWXJ5dm5qb1FXMGpnbGtLNTlkZm9ZK1JtUTBwL3FtalR1YTFYYzdpZGZS?=
 =?utf-8?B?dGJCTFkwemdLbWZTWG95VVMwbHNUOG1Sdzl4c0E5NUZxZmRJMEFYZGl0alZw?=
 =?utf-8?B?TjlVQVhMMGUrTjZNcTZrQWFrVU4xOXg4dVBUVHpnSkJtT216VmJ4ZjN1YmlX?=
 =?utf-8?B?bE1WelViRFUvS3gzM1RmekJuemFqZjY2N2Q0VlgvaGxoM05TRXZ0cXF0aitD?=
 =?utf-8?B?UkV6clM3bVArYW04enc2cXMzVlhSanpSUXB3Q2RsVVJKeFc1Q3R2VGkvVXlX?=
 =?utf-8?B?ekFtVS92ZzVtZmtYTTF1S29YZVNUTy9qdzdVKzZOY0s0R2hCdW14Q3ZPbExI?=
 =?utf-8?B?MFBGUzFadjFkWVBCUkRTRjh5eGxTb0dWT3h6di94MzdWdUVldlNERUF4cDJB?=
 =?utf-8?B?U1Q4VTlQWGlEdWdTTkNHbDBtRW5SSFFjVHRmOVRSRi9PVmR1WkIvTm1LaFMy?=
 =?utf-8?B?cTlxdnhvVnkzVFBBL0REOWJVL1RYNTlvT1cza3NjNTFDNGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:04.6124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c52dd9-1a41-497a-114e-08dd08be8c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128

In order to let platform profile handlers manage platform profile
for their driver the core code will need a pointer to the device.

Add this to the structure and use it in the trivial driver cases.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Add Armin's tag
v6:
 * Don't require to be set
v4:
 * add alienware-wmi too
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 5 +++--
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 5 +++--
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 61aa488a80eb5..5f45f8e8cd69b 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -212,6 +212,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	tpd->sdev = sdev;
 
 	tpd->handler.name = "Surface Platform Profile";
+	tpd->handler.dev = &sdev->dev;
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 53fbc9b4d3df7..aca4a5746bee1 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1873,12 +1873,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int acer_platform_profile_setup(void)
+static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
 		int err;
 
 		platform_profile_handler.name = "acer-wmi";
+		platform_profile_handler.dev = &device->dev;
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
@@ -2531,7 +2532,7 @@ static int acer_platform_probe(struct platform_device *device)
 		goto error_rfkill;
 
 	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
-		err = acer_platform_profile_setup();
+		err = acer_platform_profile_setup(device);
 		if (err)
 			goto error_platform_profile;
 	}
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e2d0cc92c4396..1b94af7c0e0c4 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -406,6 +406,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	}
 
 	dev->pprof.name = "amd-pmf";
+	dev->pprof.dev = dev->dev;
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c0ed9ffc3913b..c15fccf5131af 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3867,6 +3867,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
 	asus->platform_profile_handler.name = "asus-wmi";
+	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index f88d898447511..78aac76132788 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,7 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(void)
+static int create_thermal_profile(struct platform_device *platform_device)
 {
 	u32 out_data;
 	u8 sys_desc[4];
@@ -1157,6 +1157,7 @@ static int create_thermal_profile(void)
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
 	pp_handler.name = "alienware-wmi";
+	pp_handler.dev = &platform_device->dev;
 
 	return platform_profile_register(&pp_handler);
 }
@@ -1225,7 +1226,7 @@ static int __init alienware_wmi_init(void)
 	}
 
 	if (quirks->thermal) {
-		ret = create_thermal_profile();
+		ret = create_thermal_profile(platform_device);
 		if (ret)
 			goto fail_prep_thermal_profile;
 	}
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 805497e44b3a5..e5724e76a2082 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -257,6 +257,7 @@ static int thermal_init(void)
 		goto cleanup_platform_device;
 	}
 	thermal_handler->name = "dell-pc";
+	thermal_handler->dev = &platform_device->dev;
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 26cac73caf2b9..ffb09799142bc 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1565,7 +1565,7 @@ static inline void omen_unregister_powersource_event_handler(void)
 	unregister_acpi_notifier(&platform_power_source_nb);
 }
 
-static int thermal_profile_setup(void)
+static int thermal_profile_setup(struct platform_device *device)
 {
 	int err, tp;
 
@@ -1625,6 +1625,7 @@ static int thermal_profile_setup(void)
 	}
 
 	platform_profile_handler.name = "hp-wmi";
+	platform_profile_handler.dev = &device->dev;
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
@@ -1664,7 +1665,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (err < 0)
 		return err;
 
-	thermal_profile_setup();
+	thermal_profile_setup(device);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1f94c14c3b832..24367c3590c99 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1103,6 +1103,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	mutex_init(&priv->dytc->mutex);
 
 	priv->dytc->pprof.name = "ideapad-laptop";
+	priv->dytc->pprof.dev = &priv->platform_device->dev;
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 03da2c8cf6789..5a53949bbbf5f 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -178,6 +178,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	priv->handler.name = "inspur-wmi";
+	priv->handler.dev = &wdev->dev;
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c8c316b8507a5..222fba97d79a7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10616,6 +10616,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	dbg_printk(TPACPI_DBG_INIT,
 			"DYTC version %d: thermal mode available\n", dytc_version);
 
+	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&dytc_profile);
 	/*
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6fa988e417428..daec6b9bad81f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,6 +28,7 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	const char *name;
+	struct device *dev;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


