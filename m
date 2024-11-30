Return-Path: <linux-acpi+bounces-9808-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A2F9DF0C4
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A082825D3
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086EE1A727D;
	Sat, 30 Nov 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m52Bt791"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87F1A3BD5;
	Sat, 30 Nov 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975541; cv=fail; b=ndmoyixBQGuF5rh8Hz9NbS+W9Yw9+fgoZopMAPz5hLvvi7I9vmYtzKBFWEP9dZurrnQ+9DOiegzcsZGMEy0EiHz3zmXDOGhXxhdmkyy31bt1Tv15wfMApAhPEDc+TSvBve6ABuq2w3Wfoml16d3JRMksHUbJ9Wo2wutIRUDg9XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975541; c=relaxed/simple;
	bh=JewyXTxhFRqy6h34+YKrMpsgMeLgKwlZqckAx0I+7ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnGAvPnnkdvFl27xmRCBJLJSFCRblOO+2GFhIQ9Qtz/of9GFRu2G/PdK8VCjoaI/nn6KEKlkfKFgqrxZM+bSgUXk93EyYkg8r8eW1itb5tRqh8JIzOYhZmpfAKVMHocvO307hJ7954qDFOBf9JUHPBEADn2dR1mJOK0ZccX6rQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m52Bt791; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfyC+9Wbopz/4uHDjVZSOvvKm5zNF/U8HPEgHD9lJRY3eeI/T9a1UGSJzAOiRxfcyVgY2EEFUm1P7WjqYsZYlQc3VxuV+NLEeQKWM76r5aWQmCcsAQwsOtIBF+BxXbiflDmHzRLbHjXjF/rjGQCFOPFtSJsn4WSj8aJCl9bwvKfaeV50OrPfIEyoVaEFebdGA96udJkC50efBd5mwXkkBiNirRYNhU9D4yBcIiqTOVyubrDjNUHkVPMbNsEmJQkuXZ5ToEjUCTYLkaLCCUbO+C8Sbhrumt1/suonOr4ZJ4YilEJ9xp9iFWBqtTi6qJuorPLCRwfeuHUZ0Kjf4if3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=v3A5Z8ubVh/LDkGRq2Yu90KeZHSpUBn/nrLIrWCndB31hPZujkmMm6s2oR5BsWi8NH0/HklTk8XIniDgnYfgnzjKYoVh+qO1lTKQhAxvdud8cF8B9v3/r2rfo2UvcuYPcyY67DXDru6+iFsfqkKl4ZNZb7wXba668kOlxIw2DOfbvf9ZYZpxQgysGAG2d9fW8v5aw2RVhqx0HDFDtS/tYcr29txs5cRpeIq32qqpYAeH60oobQW/yweuxDBIp2pj5MPl5gGssxqr/obRPiCZgNqTy9ile3XtX4nmKbU0uBWx+esZLkPvHQsE3C5mTCx9LTaMEn1/4vzDTkrz4+JJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=m52Bt7913zToxC+muJtg0I39rGFlwczGwiHm+E2MdqAKfRx2Zbe6w0uw6tPowXtRZcsEdtt51T1ANwfhlG5IqllTXXuSZtlcNxg4De3zQ7BTb+/PKf2cYXW54PcOfsVFTQc9yKrwt8KZFRyW4Oz0bxBRZqw1O51Cg/YnJgMzCZ8=
Received: from PH8PR05CA0024.namprd05.prod.outlook.com (2603:10b6:510:2cc::12)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 14:05:36 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::c) by PH8PR05CA0024.outlook.office365.com
 (2603:10b6:510:2cc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.6 via Frontend Transport; Sat,
 30 Nov 2024 14:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:32 -0600
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
Subject: [PATCH v8 08/22] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Sat, 30 Nov 2024 08:04:40 -0600
Message-ID: <20241130140454.455-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: b412c357-174c-4657-ac08-08dd11481038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjZhU3Q5dXpDNE10OUhaVm82dlhJdSs5b3Jwc0orcklRSTh1UlY4a2thS3Rw?=
 =?utf-8?B?U1VBVXE5R0V1Unc4VUczeW1UMTd2RWVZeFdUaTRlWiswU0RxNU1mVmZhRlZt?=
 =?utf-8?B?KzB5TEdQV2FKZWNpdU5Bc2FORXU3bFhUbEptbXEwOWM2bmNIaUI2NStsWm1u?=
 =?utf-8?B?VmlFREkybG00eWMwSWN6R29wZjBKbnY2YUw4VS9ML1I1NVlDbGhMNHVVbkVr?=
 =?utf-8?B?U2lYcWloZHYrL2ZmN01xTlpZeUNXbXV5N2tvbTVwZFpzVzJUbUJMNkVnVVZY?=
 =?utf-8?B?RmtiQnNVcXM0L1VqVGRhUExYN2hQdDNONzhYRW9xdFFvcWRibnhzZUhuUkE4?=
 =?utf-8?B?TExmQ1pYeXFJcGxoN1ZqcXIvZWxvK0szY0lYRU5oQTZiWHpUM3hJNFQ4VFJn?=
 =?utf-8?B?eXdqamZrZVNEZEVnVHYraVVDWG9lak5KNmFsWHhDN3dZV3pPZDBPVWpvdUpm?=
 =?utf-8?B?UXZoYVVBSzdtZDRCUTRCdG5UWG5FNTJ1VzhzSTQzS0JzRUdqeVp4SlphNEd0?=
 =?utf-8?B?TWdBMkdYTlFVU2g4NlJyUTU3ck04UG55WFZCdWxrbmFIMFhhTExOaEtuT29R?=
 =?utf-8?B?bkwzK0YzajRzSDgxV1Y5ZEZITW9kWE9FclkrZmNQTDlma1k4QXJGekk1V0JO?=
 =?utf-8?B?WUJWMnFZVktMb1hXVTZuQjQ1UGpoWGxTN0R4V2lwT25pWFRFdU4zWUE0eE5B?=
 =?utf-8?B?dzVNRzl5U3FkMFZEZVgwVmZLRW5yeWs1M3MxQ0FhK0p5eG1KeFJDZGdvQnhx?=
 =?utf-8?B?ajgxK1NKMEtGQkpoclZSSWdtNzZXUGJMTW1nSm9zVDVYSVNhOUNtYlBDclJu?=
 =?utf-8?B?a0pJVzVwWHIrMmdLU0ozTUJQU3czUXZ3T1hDZDB3aHpvNFF6MjNXN2xUN2Za?=
 =?utf-8?B?QXc1MVU1alFoZDZFVDRaSGpZT0d3b0E4SVVqejJnMGVKeDY1UDVUS2Yvakt1?=
 =?utf-8?B?M0tqVmVwTVR6NmNuQ0FKTFJmOFNENGlIZHlrU01Zam14MmdVaTBvNElhcWNB?=
 =?utf-8?B?ano3cTQ4OS9JZEl1STBxbXgrVlVUUGtjSE44dGJwRkFLa1ZpRGFIOC9rSTJG?=
 =?utf-8?B?eGt3WXRmUDBIc1FOVEtnRUpqaG5hQUZYanJJdUhaeURjcjVJU1VvdENYbHJ1?=
 =?utf-8?B?cnVHd3pUTm5jUUhKYkwrZHJreWJBRGRDdFdIa3pwd1JZcTFCVm8xSWg5MEpB?=
 =?utf-8?B?cUY1MkhISnBoNWZuSWdUNVNiTTg5cTREdlNHb1B5SDIxUmZPaUIwSUtFQk9Q?=
 =?utf-8?B?REZBZm1RRXBYSFhVUUxoRHpxNC9OMXdTVU5jZmxUSWNMMFhteEs4cHFYNFVB?=
 =?utf-8?B?ZEpTYmhSLzN4aldhNGNrVi9JcUhEeTd3TlJmeTNmMlNFQ3U0Wng3Ny9xNWdW?=
 =?utf-8?B?dmhuaU5nTStSVjE4d1IrT0t2QUlIeG5tWGJVV3lVMDRvMy9SSEIzREJvNFFl?=
 =?utf-8?B?Rk1EcXhFZnpUZzhlYTBXNFlsWk5DaUprNGx0djV0ci9SSm1XVjFzT0VpeFQ2?=
 =?utf-8?B?R1ZoRzBWVzU2ODUzcWdJcFlvelNRTXIraXlvTnJuSzFZR1lQbWhxU3IzazZQ?=
 =?utf-8?B?aEdDcjFLWE9UeEVlM3NwN3NNbTduZnVQVFhQRjhEY2tlOCthandreElkbFpE?=
 =?utf-8?B?U0NsRnpwUFE3eFJUUXFDUHZhcGpnQStweXEwVHRkMGxrUVY5Z2NXVW5Rd2tn?=
 =?utf-8?B?eURuOFNzZ0dSQWVPY3pQZVEyNjJTdWFXMlE1S2lqYWtKUHMxVFMrL1NLWXR5?=
 =?utf-8?B?MGl6L2o2YWs0QVJvOTR3OEVHcndPQTBTSVVhRE1sSFdpTW1iQnd0TVZBaW5X?=
 =?utf-8?B?NkNDWFhPTGZSYmkvQnpZSFBKcU1yN1Z0elVMdUVFUnJ0UlNtMzd5MmhyNGlU?=
 =?utf-8?B?S1FnOFNMSkE1SjBQS01uSStrbUlyRGNRd3dEdWF6Nmx1YzE0TFhrZTBvR3p3?=
 =?utf-8?Q?dPVzIKByGisgSFJjzOSZ1HDB23aecLXK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:36.2226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b412c357-174c-4657-ac08-08dd11481038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 45ffd85a71dd5..9729543df6333 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -184,32 +184,26 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EINVAL;
 	}
 
-	mutex_lock(&profile_lock);
+	guard(mutex)(&profile_lock);
 	/* We can only have one active profile */
-	if (cur_profile) {
-		mutex_unlock(&profile_lock);
+	if (cur_profile)
 		return -EEXIST;
-	}
 
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err) {
-		mutex_unlock(&profile_lock);
+	if (err)
 		return err;
-	}
 
 	cur_profile = pprof;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	guard(mutex)(&profile_lock);
 
-	mutex_lock(&profile_lock);
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


