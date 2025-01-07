Return-Path: <linux-acpi+bounces-10407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13691A045E1
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F233A1645AE
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785AE1DFE00;
	Tue,  7 Jan 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dinXXqEL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D517B50A;
	Tue,  7 Jan 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266802; cv=fail; b=lsqS4DQ7kcy0eO7+V0JWAyy55tm2wg5U+HAn1vfrCfNO5w/6rZWt/Feq9o5UpE0f4QjPcm0znkhakusLw37mvzJE+YpjUDF/oVl11IJ36dMAXf0gSKSm/UiyTEtGejtdPogJAKxmuZdI7ypkUrX6jckfWBS11yXtep53dzBtHV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266802; c=relaxed/simple;
	bh=JSELO7I5ZrUeKujxoXn37hxBDloV/8Kvyr6dgJPRfCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8JrZmnYBdo4pp6upDWFRkPDxwju+IOxNDegfZepI6ZrGVLf//ailP5ZObI+9imt+kr5kYnOMDYRjAoOm2DPbnYBjcH9QQD1+JVSuqC6NxamhS2XXNvacwNIpcPTQY040FI36gaopa33WdXGg/5JC30lPguCXCBXJAtCDFJxrpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dinXXqEL; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twZZliOb8Aw3f/bITC6ekhCJxXy+kJp9jt8NAeWKaFWr8QWSsciZQJ5oUsFeuXRssngeGeoLTRRC/8lFPM9IUvnlaEGgq/qWrhF9oHMV83u1l3z82jzxKj3zm3sA1QcA5iLDtnU6gLYya9oNY2u+Va3VlhbP1uFsqcdF89OagB5jGS3QTH1U7tg8eq3sCTKp+jfSY1df9WR0n+vKVzydJRwY/42z9GxvLXpH/4rnl/UIEKBX4TIF+AfHVuNr3xXU6eat4Tgh7E1Lu1Q+jve2Uy3wG8I4/jtJkKb6coUKSjJvqk6NeprHUj/K8GIbQ0iVhD70L3P4ni93vxODZwkz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ct90b0Fv1P59bu0L+iMDE6rWtcdUNXCZhdW54wlwbc=;
 b=otCTMJyIEJnvVbaWs5bpy2+YO0KblXCUG+z4oOiBNI6CbVrbAy2jSMK3T4WjcbZobappsJAG7J/9v5x72yBe+jiOj+X18euopLD5i9W3xAJxgR5zhyJBvgGeuZUw8Au7ckhrOzvJprb6GaPM68HjT+e1daCZl4RZ4iFpFWW6FnoOk2qUEDLLClnIL5r9LvQWAM5U93BXFsSJAVzjELC01TBw9pFG13LGFS+3ey1BL5itc1aVSY6obo/vqJjIIJKM58z7CY6Z4E86xqiVsigcGJu6Zq+KwED2YpXkinXpRW8csCivIyqAz0RmqKFmL18zynx3B6/v8k9DkHUi8FBmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ct90b0Fv1P59bu0L+iMDE6rWtcdUNXCZhdW54wlwbc=;
 b=dinXXqELNCmAdarOAcQ/Olbz5N48x4M51zHq+U3GYDyl5bxhVhOyivln6QfqasfkFwsVtkdELeYynnKWcebf3RflBb6OKmc8fGnJ5WYfb4gKr4HgWknVQYST611Q1DNcPSDR356l29RP/VIvcPa1P83rKkLYhO5DubZW0WbP1aU=
Received: from BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 16:19:55 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::1c) by BY3PR10CA0011.outlook.office365.com
 (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 16:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 16:19:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 10:19:49 -0600
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "Yazen
 Ghannam" <Yazen.Ghannam@amd.com>, John Allen <john.allen@amd.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: [PATCH] ACPI: PRM: Fix missing guid_t declaration in linux/prmt.h
Date: Tue, 7 Jan 2025 17:19:22 +0100
Message-ID: <20250107161923.3387552-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 294a8789-ec61-4306-f2a5-08dd2f371ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3NzT2llVzk2elNhVTJKS1VCWE1LSUl3NjV3dnl3eFpTVzV6QXN5NTZoMFIv?=
 =?utf-8?B?dWlJZ3B2WngrTE8ra2gxd1hCV2RsYzZ3dUpqaTBCNzVUY1RyalozNjVsSGtF?=
 =?utf-8?B?OXJIYkpFRHVhSU9ZUC82bHVsNC9QMmRQY0RiQkpxdjJGVGN1bmhDKzBRY0dq?=
 =?utf-8?B?SEgzQXhGTmcwN1Nma1RJRWNITURlMVVjd2hxVGpDUUd4cHZkdHduRnhiSk0z?=
 =?utf-8?B?Z0R4N2xkem5uVnZCeFpOeW5rZGZFZ2NJNXd1TzdUZlRjeEVwU2Q2OTAweERt?=
 =?utf-8?B?dExScDlPNTR0ZDBGZE0xVlQ4RFlLYjJjdmtlYm5lV3dMeDNrT2UrckVXNzUv?=
 =?utf-8?B?Ni9iS2RFbVB1cjB1UjJkWEVoc3lFUkFHRTByeWNJTE9mUlpJY0FQWXNKOGxD?=
 =?utf-8?B?Nk9nQndQNllwcHoyTHRMMFB6MlJZTHRseVNoV3hrbGZxRDRLNkRQVTNwMUEy?=
 =?utf-8?B?WHlUYVU2ZUxvNDgwQ3VmeDR2bmd4ZkQ0Z3JiVmYvS1RrUFlQY2YxcnhhLzd0?=
 =?utf-8?B?NHB0eVhWSnJOKzNjQmt6MzI2REpTS0d3WktMU1NzdjdsWkRPTXFxaFlXOSsz?=
 =?utf-8?B?eS9QVmx6TktrWlkrSmE3L2xiNmpUY0RpUzk1K1BQeTNWVHRoUmEvZng0L056?=
 =?utf-8?B?dThtSDZ5Q1Q1aVJ2VEhTb3l0cUVmaWg5YytuaW9oZlNkanhISGVkZk9qTmN2?=
 =?utf-8?B?MWI2SEQ4WER5cWZBYno0bWtXZEFhSHcvcWt2QzBiU3VCUk1RZnFkL0MyQ0Nj?=
 =?utf-8?B?VlJKTElXZkM1bGNUM3h6OWtBUlB3N2h3SDRHUElpKzVmd2JKbzVaTWdlRFlq?=
 =?utf-8?B?RHJabDExM0dnS3dOL1VKdkE2MjdoYWpYc2U4Wk5IQ3NGampVT1orRk0xN2Z0?=
 =?utf-8?B?V1BjMlRlaXJkL1h1QjRaMkw0cUduZ253cnlsWVZGd2FUQkZWR3lQMkxDcXhh?=
 =?utf-8?B?ck1BcDBRUjFXRmNiTUdYbkFzYmJOckc2cHI2bW9pRGdhNjVYL29CMWtoN1pG?=
 =?utf-8?B?TlN2eTVTVzRrYUZSMDlTcWRxeWYrdVY0RFl3c2duMkhVcVA4ZzIvRHdnRXg2?=
 =?utf-8?B?eHFxWktJWWpVNHYraDM4TXdBMStCM09DYkVTVjA5Q3h0cndWNXJ0NmYrQTU0?=
 =?utf-8?B?dTFFdXVRQTVsV0pZU3QzUWxGSmovMlU5LzdmMVFmRzBWb1prcG00K2RiV2pF?=
 =?utf-8?B?d3Z4UWE4RzhLSkVBWGhGQ0t2R1FmVnUrallCeVY0UkJXeDQxdGg1SXYxK3NV?=
 =?utf-8?B?bFZGbVhadjlUNXpvQjEwRkhVMHV4ekVkRmtZRy9NcjNSUXQ5L2dLYSs2cUEx?=
 =?utf-8?B?ZXZPSHhVRzhNM3RKZXQ0R2VRMHJjSDdUM0ZMVjN3UXJCTFErNmdOVDhGL3VT?=
 =?utf-8?B?VWVRbzE3RlBoMkpqNTlRL3I0bUpQbkZScERKZVN4Wm5JcG1oaGtrSWlZdXUr?=
 =?utf-8?B?bTNoL3pGVU10dzhZeTBsTW5DMVZCYnFITGFHQ3NlK1Zwa3hYS2hKS2c0aUtY?=
 =?utf-8?B?ZkZoa0xRc2cvVXNVTE5PUmVGM1l2RjVVQUgzb1IvVjJTU1NKM2NLZkYxUm9y?=
 =?utf-8?B?U1hUcU1IVzlteUNVRzhwVTFyUXNoUmFzcURndWxnWmNuWU93aDRPRGNJNENP?=
 =?utf-8?B?TmhsUVI3R04xdk9YOFBJS28yZE45YllOakRyc2s4WlJCZ3dxczRxcThWSWYr?=
 =?utf-8?B?TEtPUjJ2TkNNQXlnakhBdmhIZENSSDRsMkVyN2hjNkczSEtpMk1GbmllVFlU?=
 =?utf-8?B?V1VKRDJtbzhEU2pxTVJTbGtOTzJxY0xFcUZhbVhza21vNDk4eHJSMmJwSDNY?=
 =?utf-8?B?MzJQZGMxbC9HWDNDaW0xanBOMlI0WnVrL1YwT3pSL2tVSGt3SkZIRDdpM1Y4?=
 =?utf-8?B?OVJkR3BZdFIwSEU0WTBkemxJR3htOGZDUGo1Rlo2R2laQkdJaEJ6SXl0QUc1?=
 =?utf-8?B?aXdWcGI1ZEh5LytUKzg4aTV4R3gwNFl0K2I4eGN3YXI0L1JQS0FzUjN3ZzlV?=
 =?utf-8?Q?IcQmUluObGYeryfmTQffeefTEQOX8I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:19:54.2525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294a8789-ec61-4306-f2a5-08dd2f371ee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

Seen the following build error:

 ./include/linux/prmt.h:5:27: error: unknown type name ‘guid_t’
     5 | int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
       |                           ^~~~~~

The include file uses guid_t but it is not declared. Include
linux/uuid.h to fix this.

Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: John Allen <john.allen@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 include/linux/prmt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/prmt.h b/include/linux/prmt.h
index 9c094294403f..c53ab287e932 100644
--- a/include/linux/prmt.h
+++ b/include/linux/prmt.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#include <linux/uuid.h>
+
 #ifdef CONFIG_ACPI_PRMT
 void init_prmt(void);
 int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
-- 
2.39.5


