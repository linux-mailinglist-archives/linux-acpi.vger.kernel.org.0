Return-Path: <linux-acpi+bounces-18617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC347C3EC8C
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF6E74E5F01
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A530CD84;
	Fri,  7 Nov 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IPxRVGZc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E530C630;
	Fri,  7 Nov 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501378; cv=fail; b=bJtq2Rr5LvMmrs8MLChxHaprg9rNjFfH+knmrHIzWkHlY61bDr0+eNJm0JyUkwhS13kb/rCJsSbReQbr/SKNOcxlLr0WNEGc84AjhqWR5qyzIfSBePxNR9dnOQX/bdfMbzHrpeAavF3CMY1Drj92P81OYdpJQowmOCndW9Jznzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501378; c=relaxed/simple;
	bh=PmFEeqilhVg2taOfEmUde87eDZoDgmnfOGFjdBh4xBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmnKsesqyR6BWHxZIkhOzS2FZ2YQJd7CugDdoDVJVEoF5P7Ts7vUtksgUh9pPO8DuAZ9LPoh4BkwDse0cfdFy7aJa8EEdMqJs5XIul7Ymr/FtiJdHBgpBXt9AheTwT6bl3ZhrnYLHaFDfyWgiBPtQFR9/cc7rMM1Zjej1OfttK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IPxRVGZc; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or95x5jEAwleJUmYUiUsdt+aihSwNmcObdX7N8f9GFgejcZWiXauTwXcnxBgkdJLaVa7UxnXiVq5SDVQnrNk+h2b2mRg97kTBerGfakvmv/jtzls1hwI/0Ph8IENpzdNahvProHOdwjMubVjb0LO8djGsSBg3d4xiuOAYoYFUkSMr2/OeazPLBIMb2bM8TEYdG0tHeG8ejYwmH6KSs+STO6hmVMa19sEBym9d44kwBRlVdXHRrJbcXiYo5B1i6nRjdaN2WklmObJkL0Pc1plwyUG2BYscnufeSKNz+UpDVpVnaWQHfzl3c1oMy/XIYSdLvRgNqseVq4wYUNcTHm1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYTrw7wbpyKtHQVJCg7QkmvxauaVucuZWtktIncC/I8=;
 b=l6wq3GGGV+lPBmRIudNTh/mNjkIAwTgDqkow4/JcOxVi6GBO3Y/64S+47b4TvUoUWUXziVwW/lObJM0feEWbx8J1ir/s97vV2DjcvbBxj6gnNeOLLBp5bQ4e4JelQWlN2MTPDhJIerslgViFp9ttYSKpaHcmOAjjbpJbsN7VZogqP8BI1lAYnd+rn8PXpZWik9ZkAoAQO6X+k907+WF5U8VqzHwOe5T/sGTgKPVB0xq3IQKqg/fqsO262/frp8OLJCYLBV1IOdo2zfrKEiq+vb4t4VCyoz2nezTOx5v+VVR9ufSTWGn0jrXYPXo3Pq1EfStTWvsarM4/Aw0n8HnrEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYTrw7wbpyKtHQVJCg7QkmvxauaVucuZWtktIncC/I8=;
 b=IPxRVGZcg6ayH1xGxw4tdBwt8ANnXSfrUVAKXaMVt+WHO0kSGSJI37/1u7xzRIVt7/OGQWn6S4YaHCm7y0IZN9ns5Jlin06cwf6n3l5GyTaHfVpGmW1b/eSmkG9kBb5N7qpjFgEGzDr62EWd6fQkSokjRJJdajmyf/pHB2m+rdc=
Received: from SA1PR05CA0008.namprd05.prod.outlook.com (2603:10b6:806:2d2::15)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 07:42:53 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::60) by SA1PR05CA0008.outlook.office365.com
 (2603:10b6:806:2d2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.8 via Frontend Transport; Fri, 7
 Nov 2025 07:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 07:42:53 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 23:42:48 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "Mario Limonciello (AMD) (kernel.org)"
	<superm1@kernel.org>
Subject: [PATCH v2 2/5] ACPI: CPPC: Check _CPC validity for only the online CPUs
Date: Fri, 7 Nov 2025 13:11:42 +0530
Message-ID: <20251107074145.2340-3-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107074145.2340-1-gautham.shenoy@amd.com>
References: <20251107074145.2340-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f316b86-62e8-4786-8e15-08de1dd14297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QTxf5cjxRWAtovt9/nRxKhf2rHuMruZeSX52LF0Jg+o7pVboy8xwqPceDW6M?=
 =?us-ascii?Q?NQ94iBbTYPtQLrZWSQIiG0rkQ9w+s3SYTmFlyLIgORALWjGdl0fZ5+bdFEBj?=
 =?us-ascii?Q?dWtmExd4SN+Znt/2l80TLp+SKGGyefTIeSdaFjj9UG9YIl+P+RzjcQuf0bso?=
 =?us-ascii?Q?NuChYvsGN8R4GJiFZ+ELxNwRiLzvUjQ+R/ItKadgkL31V3+MiGq0oxHq6mow?=
 =?us-ascii?Q?dpJzVJc6SsOszGlwt+zD7Ar9MJSVMB7WoCA8qWdd20W68rArxGaezYGK48hC?=
 =?us-ascii?Q?zGPFk28YuVWSGTnhb3Fc0IwRVsM5R3mw9gY3rxTpXvD/89t2BVgDOA0q5XnS?=
 =?us-ascii?Q?JzwgC7W+pzOZPE+e0s1Iq6YAI9kFVXLNQd2o6YSAeJ/1rGiuNNqJiWBmGCL0?=
 =?us-ascii?Q?69EWBmZa2y2pgjFiaFDdQ2T9TiiagAZiTGIAh8DkKq+RJvhBMryxX+DdNxB5?=
 =?us-ascii?Q?M7fowDlipsF1T8k0JE7s2lJlrTvuGNNmOYmERvBesIDFW3ScXaCT6Xc8n+1V?=
 =?us-ascii?Q?yqocvGoz0kKuQo4xM6mb+9SfcNtxF86kPCZuevGTcKgTLw5WAz471dgjQwsc?=
 =?us-ascii?Q?KcjKldjSqt//AdDm0zFGaY0PTLJ15Yx94j0admC5lSMj3B4mLKKFJvwITyUM?=
 =?us-ascii?Q?db7lfFGOgpF079iPIJuLHvuIvL6lun1W7IgItEvbUah7hz4Y9Lgb/6IUFyvO?=
 =?us-ascii?Q?oZ19lS9sHnoVs+b+H6bGQbHyp05oVLhkG6bfH7O+BetFKUy1UGObpDZu6rmB?=
 =?us-ascii?Q?mdvvXe2I6gJDXVEn+9zeAKVGlvhLjrLL/EtZ7LCcXoYvq2M9W62AeJALSTlC?=
 =?us-ascii?Q?+7QL5iyouBnO8KGXvcAG52X0X+8TG7xCkMN82qU1Mm/zIyuncCsiGZp8TELd?=
 =?us-ascii?Q?hvEfev1OwBscEbc1fZeCkgyABywdWoPXw25oIciKi1M1Q1Yj5z3FJ3o/W91V?=
 =?us-ascii?Q?MFterGin3JsW5urFyGJmyEronV20tfFij3gK032z7i9zl4DMHJVjjCWXdDJU?=
 =?us-ascii?Q?Bj6eDa6V+AY7zmYOixoBJkAo5/32OuJ++XwnxnJ3GsOoDk6rVcrb5MkMzYdv?=
 =?us-ascii?Q?lVA9isiEBW3VPzU0yVMPpmI/gQM+WcET0f3IcjiIAA9gue9BTfjT+FSBGnB7?=
 =?us-ascii?Q?AItKCoSf9Vmw8QCHtv9znXUAtzRuyEbtiy+zd5jZM1N68cbSWGJ8Ao7QoEgL?=
 =?us-ascii?Q?y605fHfsHMvoACSTbUKMjYnKqoZVixRsBlIng8tS9VUCPDi5sLZOtWBlWITZ?=
 =?us-ascii?Q?R7sFlob1Oy2hyYeKcO2lXJzZyH6FxCsXTIc2yXSDvzuCaodhHQhLTRMP8FaG?=
 =?us-ascii?Q?53b5nr95/2ofjj9+xFbPEIVmDtDgFqYVeKjCMih98h18piHq8BisjxUGktwP?=
 =?us-ascii?Q?/wKr/2aci7aA+YFeN4EtF4O5VLjHvZq2ID4yzJoiH1uDLAaey/hE+olnIAlS?=
 =?us-ascii?Q?aerIa9oD5L/zVn4d93CHqEcPHmHpMClmmvGblhDKNApNKx/lYOaiMZCvBqaM?=
 =?us-ascii?Q?FPGGO7lm1g3oef7sIGj+xvZrL2ZD5AoLCH9sI/EbLnkzqeHsXkqY1C6cxwTZ?=
 =?us-ascii?Q?0takACIeusHQW4f8LhddOSd3NgZTWBOhAyKIZssQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:42:53.5103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f316b86-62e8-4786-8e15-08de1dd14297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPUs via acpi_soft_cpu_online() --> __acpi_processor_start() -->
acpi_cppc_processor_probe().

However the function acpi_cpc_valid() checks for the validity of the
_CPC object for all the present CPUs. This breaks when the kernel is
booted with "nosmt=force".

Hence check the validity of the _CPC objects of only the online CPUs.

Fixes: 2aeca6bd0277 ("ACPI: CPPC: Check present CPUs for determining _CPC is valid")
Reported-by: Christopher Harris <chris.harris79@gmail.com>
Closes: https://lore.kernel.org/lkml/CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com/
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Tested-by: Chrisopher Harris <chris.harris79@gmail.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ab4651205e8a..50e6348b511f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -460,7 +460,7 @@ bool acpi_cpc_valid(void)
 	if (acpi_disabled)
 		return false;
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
 			return false;
-- 
2.34.1


