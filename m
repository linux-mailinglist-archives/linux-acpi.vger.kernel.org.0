Return-Path: <linux-acpi+bounces-9667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD09D2C59
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DB6285CF2
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F71D1F5D;
	Tue, 19 Nov 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pej4slrF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190661CF295;
	Tue, 19 Nov 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036867; cv=fail; b=YTXoqfJe7Qmn9Hnijr4lXDuibKqKdmxw3wSfjZvJaT46S6IJbRmzVDxUZlUb354EBZ3K3Dt9eYJdc+qn57PiZyzuGsl967YT/Q3XfLLUvgYZhDiusHrCLKER7e2wxVqz/DhuPIHmKCnEDfS9ghuNbs4YO/7ADBNXne30kRouHIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036867; c=relaxed/simple;
	bh=4acWOBTgKXkQXKJ2F6QknLiWxVdZF5ne9UoVI1gHNM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qg5PFMIJ8x5oqLoqilsTKnKKq/DLTZeYUYyN2H7Vm7TBQDqeqrlnf3+7H20vc3q/4AscP8nQQg3ewvUfHxYUJsKlS76/Cny4Md3ZhvJmBDD5f1y2ZQvwd39XIAlrwigBtkY2Dnq9CmdZb66ZL5IX3v7A5nrur3h6LSCtMEds6T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pej4slrF; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mww5h4w90RZwvp9TiMEuLq9dg7pQ5B/iXG4C+mtp80/KZ2/sPC4XXDce09g63fWLJ6j/y9266jIsgUaDMkALjwlfjzLbDJ9dR41tVl92gp8t5r5m0fV6fMo8dgBXdlltpDEJZgSsIkmakTsnK+FCexszKQkIZsTNA2vk2+qOcEAS2MtbgisjgTkBafh5vIBIXReshJJEjTqtLgsf4y4EHF0BL8adBJCizCYbcfhQ1JVKrYVrtTYSGdmIOEfaHBADQCZRQu4moaH42K08oQgX7YeQn+ZL2By8NmB8tlDKNEJjwGI7wxu896erX5XeErUSL2HDxYzjQo5BaNoaGHPNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su0YGzELm9tFqAipf3MGeeTvz0dxYZurd0guxOY8Ulo=;
 b=nI2zXOCoZSVrGWT95k14GuEnjJt9VaOK2MdAKOrvteoekdeOSbcnssy8wD/1brsF3+TqHazbBL8o1L9J1hzv2zpIfIpSvpVOs1FyxuXCnIdDwYrXqcq1tRtF/lNGTV7ONCtIFZgP6ElVH7HGXpMDl/CkVdwy/ejAH8gSiUVPacg/bg6aIqiQy9m6fQdi3J1fWZIzDrkFMKf/HbWZVT5qFJjygd0SWiTTEZfB6b6dPe3XbvdjUzJ1Tze51xtNWFooqIO7z2l5qJ25VWMdVrIftdtG0fyXl9LjVopNRfGj8iNuf01/HCddtPZFGWu9ODIzTJTzVHTATt41a0MMJg2rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su0YGzELm9tFqAipf3MGeeTvz0dxYZurd0guxOY8Ulo=;
 b=Pej4slrF05r2B3F3ePkzy7uhyBsS5dPTlmJSijtSUlczlfcjTvd4xS0lL7vBIo+5XJkOThTZzOuygsRfiZK06pBuo2wOIm1jAJmJrPRFnt70CSqNISyF3uoInG9SXC5MEDIDq7okUJ4/FIQOiuuEp4Jp1itmNw5TcOolYAXVdCo=
Received: from CY5PR15CA0257.namprd15.prod.outlook.com (2603:10b6:930:66::21)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 17:21:00 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::9c) by CY5PR15CA0257.outlook.office365.com
 (2603:10b6:930:66::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:00 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:20:57 -0600
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
Subject: [PATCH v7 01/22] ACPI: platform-profile: Add a name member to handlers
Date: Tue, 19 Nov 2024 11:17:18 -0600
Message-ID: <20241119171739.77028-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 358bc359-8a5d-451e-d154-08dd08be89a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlJpNDM5bE5kdDMxMEt6RlljbjZUakpENTlZcnVvWlF2R1haU2dxeS9SbDVV?=
 =?utf-8?B?bXYxdVY2NFFzdTk3Y2RacEVBZ2d0NEdMSG9CMjNSTEduSHBHcXkySTQ5N2Uz?=
 =?utf-8?B?NnU5SS9oZWt2SDYwNDJVR2wxNERRQkpjUDhWQWRLV0xVR1krYk5NNjdzQkVm?=
 =?utf-8?B?Y1FybkdERkhpSncyUnBRKys2V3NqWE5SblVJdkE3SU5vS2VLYjh4NTR3NFZj?=
 =?utf-8?B?Wk01L3lOYW05N3ZxNjJEc3JyOUU1MU1JNEduWEIzaUdhdWxYK1duRVNFQXZ3?=
 =?utf-8?B?VUpHRnBPVUZIUmpqamsrNFBiL1A3ckdZakgvdEVZTlpaZi9nM0ZOcmhOQ2NS?=
 =?utf-8?B?STRhMFhTQlZ0Um1IZnYwU2JGbTdFdzl2dHlDUERYZU81enBKdnlGby93KzJP?=
 =?utf-8?B?cFU0WURuaVZnQlE0KzhuS0k1ZjNWK25GdW5tRis0akRGTnhxRURLcFl5YlR4?=
 =?utf-8?B?MkRlc3d3TnZjZTc5KzRBWExIM0Z2djdZeHp4M1JvMURKV2xaa2x1bjFZdDJW?=
 =?utf-8?B?SnBPcndIcFkxa0h6cTB1eFBvcDRTMWhkTmwrNTRaVkMxbkp4a09vT1JzRnR1?=
 =?utf-8?B?TkhEK1luSmRCWkhZbkFyWUhLTHJVRDZHRTdJcHd0YWZRaGJpRG9FWkZsZzBz?=
 =?utf-8?B?YU1EVElaMEx2eCtlUVV2SmRGUGtyUGV3TzV6YWpZYklGbkY2dW9BdjNkT25m?=
 =?utf-8?B?aWtpMTlvOWJieWcyYVNiWExxZ2wwSHBVbFhjNWhjenVIRzJveUdRVVQ5OGk1?=
 =?utf-8?B?SVBUbWlQOHZuTFFTZkJKczlyMEJQcmdyd2V0MkxhbjZReXlLbjgydXhNNmYw?=
 =?utf-8?B?UHljYjh6YUgveFVNK092clk0QjM5cDhoZGl0NjhKMlhqa2sycnMreXV0bFJI?=
 =?utf-8?B?SUZIdUFjdkNXYklRSkUxQy9BZkFkbnBFdll1SXBaZGp2Mjl1L2hOc0x0K3lm?=
 =?utf-8?B?REZyTCs2YWJobkxOTmpCaEFxanY4bHZBOTJVN1dEYzhyRDlMSlo5S1ZJeGpt?=
 =?utf-8?B?ZmZhVFU5VHNxRnpLM3NuMkRPTUdpMzVSMGQ0RGRDRzNTOE1hdXFRNTVkQkRt?=
 =?utf-8?B?L0czYzl2RDg3V1llVUg4STJMRG4valZhN0x4N0c4OGREQ3VURC9LMTl6WEZh?=
 =?utf-8?B?RXh2VllHbmpBTU0rYjdWRUNXdG5BSnNYSzFiUTB6bU1tSTJWN3puZE9SVHg3?=
 =?utf-8?B?a1RVY2FuMGdtNFFEWW14SW45WmNpd09LZWl4U1cveTAxck92YzFCamQ5ZEww?=
 =?utf-8?B?a091eTN6Y0owcWluNHhNa3BsN2hvQnFNeUZaNGh4NVV5WFRrMWFwR01TOFM4?=
 =?utf-8?B?cE9qT3FRSmk1OEZVVkVVaVNrbzdmNXFVbG5zM3hnbzJvTHZNLzgxQW82SDdW?=
 =?utf-8?B?QjNIK1RkRkxjQW5kTlhQMWVrUUFmUGhXQVV6U0ptcmVVaUE0dGl3eUN0Wnpv?=
 =?utf-8?B?S09tUjJHOERzTVljMjY1ZlJxZ3IySytHRDduL2ZUOTNWWGhMcHYzbFZrNThm?=
 =?utf-8?B?aTIrdFJtejJKbUJOdmJHNEFaTzFzTGU0TXZDa2U2NS9XT3RuMTJyS1dKTFBY?=
 =?utf-8?B?M0R0QkJuZXVodEl6SW40UG5LV0tYeDl0RHRmc1gzRGZaTnZwWGNCRFhKTmhN?=
 =?utf-8?B?amlTUFVnWUF3VmdSNUJJcEU0UmNyUEozL3UvZkxjSkZRTGR5bjBuSmxYdmpw?=
 =?utf-8?B?ZU9SbjlucGhoUEk0QitrbFZkS3QwbFczTVJKcEt1eEQxQ3ZGWUI1WjlvTFUv?=
 =?utf-8?B?K29kZG1GcW1HZnViVEpzQ3RwSFA0Zlpzdnk3RFEzdXQ2ZDhIbVNVbWwxQXF3?=
 =?utf-8?B?UGlwWnJnRFRWb2dkUTZtT0Z0aDUyemhzV3BId3hxcERoMUZwdStwNURCcWZR?=
 =?utf-8?B?UkQ4WElxZDRKbXJSeTd5Y3BZQTc1Ry9aK1M4dGsrYW01TEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:00.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358bc359-8a5d-451e-d154-08dd08be89a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * pick up tag
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 1 +
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 1 +
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 1 +
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 11 insertions(+)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 3de864bc66108..61aa488a80eb5 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -211,6 +211,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->sdev = sdev;
 
+	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index d09baa3d3d902..53fbc9b4d3df7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1878,6 +1878,7 @@ static int acer_platform_profile_setup(void)
 	if (quirks->predator_v4) {
 		int err;
 
+		platform_profile_handler.name = "acer-wmi";
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 92f7fb22277dc..e2d0cc92c4396 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -405,6 +405,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 		amd_pmf_set_sps_power_limits(dev);
 	}
 
+	dev->pprof.name = "amd-pmf";
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f15c7ce37b256..c0ed9ffc3913b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3866,6 +3866,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
+	asus->platform_profile_handler.name = "asus-wmi";
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449b..f88d898447511 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1156,6 +1156,7 @@ static int create_thermal_profile(void)
 
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
+	pp_handler.name = "alienware-wmi";
 
 	return platform_profile_register(&pp_handler);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 972385ca1990b..3cf79e55e3129 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -247,6 +247,7 @@ static int thermal_init(void)
 	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
 	if (!thermal_handler)
 		return -ENOMEM;
+	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 81ccc96ffe40a..26cac73caf2b9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
 		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
+	platform_profile_handler.name = "hp-wmi";
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 9d8c3f064050e..1f94c14c3b832 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1102,6 +1102,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 
 	mutex_init(&priv->dytc->mutex);
 
+	priv->dytc->pprof.name = "ideapad-laptop";
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 8440defa67886..03da2c8cf6789 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -177,6 +177,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
+	priv->handler.name = "inspur-wmi";
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 4c1b0553f8720..c8c316b8507a5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10549,6 +10549,7 @@ static void dytc_profile_refresh(void)
 }
 
 static struct platform_profile_handler dytc_profile = {
+	.name = "thinkpad-acpi",
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
 };
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f5492ed413f36..6fa988e417428 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -27,6 +27,7 @@ enum platform_profile_option {
 };
 
 struct platform_profile_handler {
+	const char *name;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


