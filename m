Return-Path: <linux-acpi+bounces-9301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36259BD077
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71581C220F4
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F1153803;
	Tue,  5 Nov 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uxuHjSst"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF0146013;
	Tue,  5 Nov 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820823; cv=fail; b=roODfQo6V/LBWMWGviPV5yIYAZcLa7x9D/4Da9Q4dRiNgM+UR4zZPejR0xrYPfmeIpnznKWTappgezQK11i5++WBEXwyN1XeKDYChlm9jxXa7S8KHDalmocK6muiyejM4XmPbyHCJdPlPAazCk16PjMpfHV8p6tDDFHDEFhFC+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820823; c=relaxed/simple;
	bh=coqx1ADwMrtXqO17eBAIJiGtY0S3w4Hi1a9kzpKViqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIbnnMysoFNQrP8xktuYpy58m7elMZde3iLYqnhR6YXHottRhwhxUERKgWogzZ/BrcK7zsKprb58zNIzNw89SSxy91TiGqDaBiNt7ijJbTNaDhwJrT7bMZdrZ/zYpNEkL1TGSa11nyg5XuGRMCbHyDCWZav9m7AeLIYk6UK1oIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uxuHjSst; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUV+yMW+v50dewUWpC6Z7HviLSDYEMVy64xTuOkqXfPM3gWbI8Eb4Hy/61hA7jbvZflYfGwEM93nK6ffUpZ3vbTxSjqWVv/AOufSqjIYynosOUzrdQsR6vcRWbknjmq3gNOuzNZO2JAXRoIzrxzCGozAzlGcl52FeXD7xdjxlg9cbhF3FN0vWfNzWmAsOLvv4i55UdzbKcX17pNBRRg2Fu97bvdl4kCoOXlJawDncFejtTJwoDoVjUaFkNlaqZo92L/SMkFQs0Qmcugs6yNOJ5DIwUqDqIS5FW8nXj0byRpbsKoaEpqNhuOd2O3VZKORxe88DPMDnT1wEw5EqjryiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgdRMEm5b7ecUIgJRgBzczX2TCGPfumhFWdIRNlizFc=;
 b=zW6zxLHRPaEowdqX1idz2imKqkiKr2lwpAT/0KjYQNy+RAFJVUv2UODqnMdNetFzURkHlJegfoafHUmUb892kgoALUTqKR4lzTUl5UKZTn4esie7ETYRcbYgnO4xD7Y1ANaBo5QGIeXklvuOHzTj65Xbyv/O9106MzF0NOs8O2lUkM4OtNV+3Ha8RwAL6+GqjMc+FLj6lMaVo+t1tXw92BiITnCcr7W+kbRmfJ3G4j3jS2su7L05UZyel/w+NVLnF9xcL3eFHPQxY4u7ix2sEmn3EsEOmp7XZNg08ZL/rBC60pqFKxwxRqIIZmkrLQKPBKUKBGlY80781aUDAL5vSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgdRMEm5b7ecUIgJRgBzczX2TCGPfumhFWdIRNlizFc=;
 b=uxuHjSst+FHZRO9Y7cwG21Xjy4+2FvmHpWdeUx7zwEwH3D0RdtHVo55JpIKvtXZVhlPhBNyFND8wCXOUXHyYeXw/91z4DdP0UIfizSalySnQHeZ9gsxxG7cMhnbJPhg+aTV+HPOG92ZFhaqti+A/UiICT8MTTw1yQy7oBaitS7U=
Received: from MN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:52d::27)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:37 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::cc) by MN0PR04CA0028.outlook.office365.com
 (2603:10b6:208:52d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:34 -0600
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
Subject: [PATCH v4 05/20] ACPI: platform_profile: Move sanity check out of the mutex
Date: Tue, 5 Nov 2024 09:33:01 -0600
Message-ID: <20241105153316.378-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: c50279a0-0a90-4a09-8509-08dcfdaf3782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnY1MG8vUG8yU1VEL0p0bVVldVlaN0NBZkk1YTczcEorNkJFOGRpOE1ZelRv?=
 =?utf-8?B?WGVZY2pWbG01cWZYQzhadlBEV1hoUncyMVdPUWFHYmw3WGkveURxbHNOeE5j?=
 =?utf-8?B?dC9FVFh3UDVYTWo1QVAvQi9Yd1M2RVkzcFEvUGd5ZEtkRjY4dVNwUjhWTXRa?=
 =?utf-8?B?dTdCWlRKZ3ltTTFNaThpMzc1a2pZdTYrY1M0K0JIWHEyOTc5aVoxeWM5Ujln?=
 =?utf-8?B?eGxBanMzcVpaQmxUKzJMVGZVWU5LNTBNUUNPWE0zaUo2RElueVI0RTZSbU53?=
 =?utf-8?B?ZVFOOCtqVXpvOEJpbndoS2wzZVVFTEIwMThSU2lPcmNRMWo5RjdSRVhvTyti?=
 =?utf-8?B?MDVYQnpsY3ppUUw0ZkxxT3BjK3JEMzJYdGlmUDZHbXp2YWRFVzIzSmZUVU1T?=
 =?utf-8?B?Q1pCMmFBTm1BMUhReEdnMGRZbmxMNzhMVGg0ZDVPNkJDYUtGNkZSWDI0Rkdn?=
 =?utf-8?B?RUs5NmNGMFRsNjlDMjlvNEVnQW1YckVIcDM4Mm5VOHJjeFI4UWdMMFZYQ2FL?=
 =?utf-8?B?bFF2c3Y4MHVrb2hucGJNK1lnZFRFRFM0Y21UUHdxMm5DYW03N1Y1U1V6SkI5?=
 =?utf-8?B?Vjc4eVI3RThiVkEvaFhFekt6Sy9Ickp5VDFDMkN6UEdlSjhkcU04ZXNSeHQv?=
 =?utf-8?B?YWFoZGE0N0pLTnBqeVJZMmlvRnBiT3BvMHJWVm1hd2FkODVtVjBqY1pBYkpw?=
 =?utf-8?B?VTJPY3l3bUdlTDdiOHAwdWtCcFBuamNTcjdBc1QzSVVhN1lDYmFYQnlDc1pr?=
 =?utf-8?B?Z1ZSNFRrYVFYb2U3ZjlhNGZxc1JZREJtS1F1OUprbDVLcEh2ckhSUkovYlAx?=
 =?utf-8?B?L1lLaE1Xc3ZhdExBTzBhREROK040eStValhGRVFlK2l0QjlCWFFxQS9ybFRU?=
 =?utf-8?B?a1UvMUVwTmpZZnJGMnlvcmk4ZTBXLytKVUpYZ0NYSGplcHpXd2wrQXJESkNv?=
 =?utf-8?B?NWd2T1AwbHdydGw1T1ovbG5rV0doNElMUHduVEFjTDhnc3NEZ21od280UUlh?=
 =?utf-8?B?dFFNN3p4c1o0aTFwSUZwTTdmNUV1SXptQ1JFcTZrQ2lHZFh1ODBMQXE1akRK?=
 =?utf-8?B?K3BWTU54Qk5SMFY1SUZvaE9IaTdPOWNHRXBjYzFqUkFWYS8ycFN2WFRFTlpW?=
 =?utf-8?B?ZDRNaDFMUXJXQUthcHIvS3QxbS8yQ1h6VS9BMHVzcUhtTkhsdTRTRW9lYW9q?=
 =?utf-8?B?TE5EWWMwUE9zUzM0cXMwQStxMmNveEdiZEdtTktmTWROZmJETEdid0FULzZJ?=
 =?utf-8?B?WnZOWmg1cWNETTZFZFgzWE5KMlBwaHFXM283eG5uMlRJZXJKc1dsLzFuNmxU?=
 =?utf-8?B?dHExd0UrU2JJeWJRdmlCa1FzUGlIcE1rVjJhZkl5QlJoNFQ4Y0NkN2ptSDFt?=
 =?utf-8?B?N01Qcm8zOEZsTGdpejlCbzI5ZThmUWJ2TjZtYVZrMUMxdXVXbHpYSWhtQU9v?=
 =?utf-8?B?ZUZDUkRHMjdjZmlvYTFFRm4vbzBxdzRYMTBiR2F0N0F0T0ZadTAyS2hWMGVJ?=
 =?utf-8?B?MGdvQU5KbVhZcDQvbVNoRXE0SFV0WTljaVNyTlkwczBQY05qWHlaOFZZeGtx?=
 =?utf-8?B?S1VBSFE4Nm9JM0Z5WGg4QzcwLzZWamYrTXRrZ2UrSkpHM2FnZmdnaWkwYXRs?=
 =?utf-8?B?MzVIQm5VNTk4NEY2T2hFWGU5cW5sTXovemtwNEhxOTRpSE1BTVZNeUNSZ1Av?=
 =?utf-8?B?S3BsVk16SUxNeHJVNVVZdWE2aE9heW9CMGZwa0lUZUJkbU5USXhQeUxOVmhm?=
 =?utf-8?B?OEhsVE5wNG1BaE16cFI0bzNtK24wbnFFN1huMHgvT1JZKzhyeVRCZlI1QUZ0?=
 =?utf-8?B?VmJTNTBnaTFVZGh1cTZKT05Fc3dOdmZERzJ0Y2UvL1hmYnVNZHJuTHpwaGw5?=
 =?utf-8?B?TUxsa0Erb3dOcHFNM2s4NnlDR01iU2k1bjZwRllqaE9Lcmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:37.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50279a0-0a90-4a09-8509-08dcfdaf3782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795

The sanity check that the platform handler had choices set doesn't
need the mutex taken.  Move it to earlier in the registration.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c76b8e3fdcde6..4e8a155589c21 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -179,6 +179,12 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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
@@ -191,13 +197,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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


