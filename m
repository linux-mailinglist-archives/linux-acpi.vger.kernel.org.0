Return-Path: <linux-acpi+bounces-9391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A999BFDFF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3837B284605
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122B1990C3;
	Thu,  7 Nov 2024 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="238mT48P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D28197A7E;
	Thu,  7 Nov 2024 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959421; cv=fail; b=oilVhqzBSdS9Tdhsgksd9GxIeiUS9kmJoX0mm6JktV98lha0/0D/SYtx7sXYFx/9Aa99qLu5BssNO13TJBfdiIuUVJTrlmacPvNqCkrq9scs0hhqQ4ooU1M+iCWknnZ0zDz9dS9y/PZFHFc100Izyd6kYNj+erbKz3ORxesKvbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959421; c=relaxed/simple;
	bh=M8a3jlvXTMdc/FFBVebMJsQ8wdXj4ZIXAyA82jD0/18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSl9IxJYTBT8iURUy9L1+YLsfnV6k10KAtvnFWNPzgoyCRIvCkqpSPGFQ26NKh1HT+8QVhhpt8XT7QtNpiFeb9klCqSb7fd7bgkNC0z8ZjZSarZuIW0Y1Thye71ZGF9+KU2V4dF45960fC9kKrfTdQb0QiNgnQqLUw5RIwFx/Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=238mT48P; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeRZw1Wkad5JcdLYb/sm1BCmjkf5mk4KvQbNkm621xCcY8bgTlAoddXoD8umq5NpIQPxUNw8I04Q/EPPCVMZp3LuxxKgXvDDxDLh+457sWOIHQ0vxoP1xgAXt/fO44Gy9gqVmaMSy7tZqBiI/HnC4/3JDdIRTFPA51NS0KlEHQfYZ+CGge0iNgwEUcM0d4oohmgw2UdmfV9nB4Cp+yxtdrulJfqfwuaFLx+OBN3jaQBp2fVRURe1sXajDKN8I1AE9sYGROWd5STl6f8yQ1NkgMQ9tOzcfSf/XVtUGSbvccRZnkAcL5riEm9+yicdNfvRs413gNHW7dvQqHfvOxKGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnfyT3tMCL5FCDOuR+WuRHGXHAYbYss7SLrNrf80Y7w=;
 b=oRG10fke0HdSeqABf1E7OnkTJIVm/6XWHE1wke04MKIaFVqfXtA5oWXssWls+fFtALUXED+AXtN6QCEeTHUnAUEBfPlGfVtoEb07DE1hO/61kAZrxQ/vmSq1+pBxMkPCSXTXGXEcKH6oG6xkx2XfJYHmwg2Tald8a81vfOC831t1QZ6Fp3hGoMdqbE6xZmOJrPvJ241Zywd5ukryM75Mlu1XiN7PrZ+m5AR0dWjCaBao3r9TcZNNvWUGwpeRVXVyfRdXXw1Vf5EPeOM0YoEWcK8RQzF4+8+Na7bEbBiVYgGlMq3T2Q+fO7eg/4INmZvsONaDLC9KS+ggu23lzlePpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnfyT3tMCL5FCDOuR+WuRHGXHAYbYss7SLrNrf80Y7w=;
 b=238mT48PuHuV111jTjNXMa0+Ba9qdw8j5a9JRiSQhxNXvHgyogPSM5CL4VQCNCzDPfuw82EtJ50dtGc2orHHGMZniFgEG1NemOhgMJ3o9N0FbSMIRChCmPwkZRSXtvvd+rMJZ1ZDb2hwYgz/ZtQsowm8gaQ1BBoTR5+BT6uPhyY=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:03:37 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::4e) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:34 -0600
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
Subject: [PATCH v5 06/20] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Thu, 7 Nov 2024 00:02:40 -0600
Message-ID: <20241107060254.17615-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: d38d4228-dc94-45ed-99e1-08dcfef1eba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alpIcGNyemxtZWJYOFpBeVdQSjBuWnRqQ1VjTnRUeEhlSjY0Mk9sVVc1dmJC?=
 =?utf-8?B?dmVKRSs0ck5sS1BlR0pVbnlYTnRaZVFVYVlJMlRsakR3d3RPMnpMVUhlYlVG?=
 =?utf-8?B?dzlJUkxoUUhyNDZhN2ZaZHN6aVBBaE9yZUtTbUJpZldUTVFiMllGVEd5dUpF?=
 =?utf-8?B?MitxTm5BdnM3Wmp2RWZNL2YyZmlaQmdTN25VNnNVOEZXZnEwSFhSM0xNc0hT?=
 =?utf-8?B?NHRBVTZORlV0bWhJTkhWZzlpRkdEdXVOM3A3SzlyNSt0T0hDMkNHOHozLzFs?=
 =?utf-8?B?elN4elpVc3ZvRHZKMEtITGVxNE0wUWxCZmFabmJGc2grSE9MYnZ6Y3MvUDZ2?=
 =?utf-8?B?TlVSbkdadHdzdW5hYmZ2aG14bFdiakl5QnpxWndKRXZyWFVYSzRSUGtubTFl?=
 =?utf-8?B?TFQ3eXRldVVORGk0UitvVTRBbkRSN0Y5YXBVVXF3RCtaTlFXSXdDOFZFTHZq?=
 =?utf-8?B?ejJmQitaU0c4S2xtbGRGeXRJNjZZdWxLdUZpeHhLTzh2VXUyRG9RcUZMUkcy?=
 =?utf-8?B?b2t0SVNTMmtNbWF0elVuY0l2ZGhzZno3V08ybWZsWk5IY1VmOHc0ZFhUUGFV?=
 =?utf-8?B?N0R6Rmx5TkdObmN6aU1mVnNlRzUxRlMxeHJjcW81emFsYkJOZ2RWWDRzeEVy?=
 =?utf-8?B?MzliSW9DYXErSkJqVE4vV0xFV1lXYkdiY0JHMVJvYVlMc084eDgvV0oxdVN4?=
 =?utf-8?B?Zkg4Qk5ySUgxRFU3SllEWmxSQWlZL04vVnZibUNueHJKeFIzS1FZZnpBRStz?=
 =?utf-8?B?NFJCdFRrNFAzT0FyY0tYekN6OTUxdkdadCtNN09BUkkwY2t5YUIxYksxMUVX?=
 =?utf-8?B?MWNIR09VdTk5bUZmampmcjFSbFMyejVXSGdadC82VnJEVkE0bGl3OWtkVnNt?=
 =?utf-8?B?OW5TdHB3aHNUUXZoVlhPSFlHNE9LbFpmNDFxbnF5clR2SHhGYjY4dld4Mm5M?=
 =?utf-8?B?eDY3eE1zeFVSa0xieWhHa1pZb3BmazlFWnRsY1krNFpSd0ZNVjErMnYwWTlt?=
 =?utf-8?B?ZzZFMjdQRXY3VHRBTHZmaFd1NE1obEFvL2RhdThpbkNhdnV5eTNaR2RQVW9B?=
 =?utf-8?B?ZmVaSFh5MDJwczVRT0dGeTlXRjczcmRwTU11dHVmU0lVbDhUTVRJaGpORlFp?=
 =?utf-8?B?RFFxV2tydU5tSDFJUGgvWll0eXJTdkNFbWNHc250Zm5OWWRzMFNvV1JUUzZh?=
 =?utf-8?B?Z3NwRWViZTdMLzI3WDNQQUZWdm5EbHBpUmYzUW83YVpicXExSlpVQVMvMVFk?=
 =?utf-8?B?bWlDWFdmZnpGWGF1QXEvNTdBNlBqQ1BudE1mOFg0K0pXUFNGM1NQNWNMY3lH?=
 =?utf-8?B?YVVRenhEOVVWZjJIYklSZFY4UHhhRkVhZ2xmSnN1OGk3b2tsVXMzSEFybTY2?=
 =?utf-8?B?VW9BWWJONnlMdlQrMVl0aGZxWHRrUFU2a1ZZTUhKK29Sd1phWFM1WTdxYlpM?=
 =?utf-8?B?dmoxOGJ0MXJ6TWFibTg1cWhadCtLYUFqbnVLd1pzZUt3OU5zSWE0UEMxZ3pk?=
 =?utf-8?B?VFBRVXhHM2tnSC82cWZSL3dFLzdyMHNscGRTb3B6TjVjeWZCK1lNRVJRVHJn?=
 =?utf-8?B?Qk5lWFJFZGxRcTc5SXJmVytadGFpZzRGbDlxRjZidEhYK2dwSCtTUDRZMHlW?=
 =?utf-8?B?YUl0WTM2Z1RBSkZBL3dwMFZNeHVIWi9vNkVCLzcxSE5tOWZlTmo1S3Z2YS9w?=
 =?utf-8?B?bHV2TUhzZEQvVTRxMlViRG5WdFlsdW8wcWgzbUdjeGUwU0xTQnRqYWNSRU90?=
 =?utf-8?B?YUk5SFM3OVVuSVg1bVhxUm42RDV5ZW1qaGpPbHg4SlFjMHV4dGN2YkhyaVQ5?=
 =?utf-8?B?UkUzSUZNVzgxRXVvb1NKc05jNjA1WFZuZlFPZGcxMHZaMFhXWW1wOUkydnFE?=
 =?utf-8?B?ZERuK1QvOVc4cmo1OG4rT2FMMUZ5dEtET1dOUlA5TFpUL3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:37.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38d4228-dc94-45ed-99e1-08dcfef1eba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519

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
index fbdf3cdf1141d..548eb99253958 100644
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


