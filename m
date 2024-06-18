Return-Path: <linux-acpi+bounces-6508-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5390DEA1
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 23:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D72C1C22D73
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77B17836E;
	Tue, 18 Jun 2024 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lq8GwDFy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546A1741F5;
	Tue, 18 Jun 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746972; cv=fail; b=j08KbAXvcN6+4EQ7yx5pFbMMq8G6GhhH19/qpTFXzla7Wd3WOVS01WoME15QRTq4ZCEx/urOo5MU76ndciVpUskZrN7s6ilCtOioEEZVqWGzi02uLj2fmT7GDO1vU7tjIOzN1u0CTDHxCvtTtGK1k1jyqPqTYNS0gX9aXPmx1+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746972; c=relaxed/simple;
	bh=0Bt8DW+pbLv5M5znzAfv8IkVl+4TChHBV6rsqybSmE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOEwXtcYo5K4bFEfwqfCdTDS6w5ISlRpclbTZ9alfSPaQhzASVqQiV61waDYCLPnUkz2dXE5mOxu//MYwd5ujfDelgj1jjMOewJe1YDbL7P23ZHcE5XoNsUXXv1HOO8kwTT19CHTb/++QLwc9IX9v2r4OtIx2r/6g9uZscxC1ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lq8GwDFy; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU3FTGcWueeMd3vfJigmcrfJA5hXrvT3O+0fUGa/tw8q5h5PgMapBfh1ixRdO9chquKKeWevcGlm1KTjD1fR7+YMRbeHGEOx0IEbGEsC7/HpT1OsxUjAa1A0T9DIko7O69JSfEsJtA6rbFmGGP9HVcY/mEWgOoVXB31CGsW9MpoVhGSDzzhp416k8AVrNNpRWk0vRYyFuIdgzykldN9JZirvZztj+ZEEGlbjAT10vnBTUxHiqy2dcnebq/Yemq4NEjoADfZ6SRihZzcCSz/7Ur8J6iDz/wsJ2wDjDhl6yiEBJzANqhOdewY5E56qjrR/eRAUid9CD0pnElBiQOPcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCL5xGFaEJBJ1kRHx+rqDvNUM372PR9z4hSbk/nBFpg=;
 b=AEqf4w3YVVhqLFJsbYK4oEiyZPjbrB9GzxtGtYwYOIZQPqYJnap709HwCG+i+rcoHxMO3ln4HgfYba215I7N5ZNBWuNwe0LuRx5p49lGgFQh61uTqzSWQcDYFFQEgrDGEJiTnItoY931Gl+QCXzmnUQtOrKuKFK258UZaWL9iB6AmH9UfzPQl06sWj1UkvBltuZFOzNdnQ44X7PLLT2cJ8tUBKjQSa3ItOKgzGeABViB396G5ys5LFzQgMhG/IFHAgo9GXkDfWKrSZicUqQQz9KrbD+mFDD3s4XEyNopKQozRiQCjB3Fs9TgOuQTrl5nido2XaIehChMB9RBfj/ZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCL5xGFaEJBJ1kRHx+rqDvNUM372PR9z4hSbk/nBFpg=;
 b=Lq8GwDFyZeF26jF47mW2an+ZdYUHWrI6VFxLSilPPby0+FCtDy8TSesCdYAVsrl2YuVh0U9gpX0jRgHUj2bxrfeBRfoLHUiqf984rMc2THOGUBXbDIkCya2+sYnwyrEXe0W6JnAdyTHgOAGzyToNwM44CIQoEXCFOxTktJeIC5k=
Received: from DM6PR14CA0067.namprd14.prod.outlook.com (2603:10b6:5:18f::44)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27; Tue, 18 Jun
 2024 21:42:43 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:18f:cafe::f4) by DM6PR14CA0067.outlook.office365.com
 (2603:10b6:5:18f::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 21:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Tue, 18 Jun 2024 21:42:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 16:42:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <clin41@lenovo.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2] ACPI: Downgrade Intel _OSC and _PDC messages to debug
Date: Tue, 18 Jun 2024 16:42:25 -0500
Message-ID: <20240618214225.50953-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cac825-73ca-4cf9-056a-08dc8fdf9595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXmLTeQwXQHykOXsVIWn9DB5kkkZholuV4ti+m3gy/A6Jvv9dz7wIKyBO132?=
 =?us-ascii?Q?t8T/jgPYvjq0tnejKH+EhQZQY262Q7PFS+ghtE/1SvpKGjYjPKSsbGsEmlkl?=
 =?us-ascii?Q?OFFGGvY7VqyGNHXp9tEYWyt773e9ISWRLML0XfWcP0sOcohW9ma3/AFsssgj?=
 =?us-ascii?Q?cTsg8XXRBrMyqgk/lcHtntQbLmlIDA5HMkN9qYU5510zL0vVwaUUSLk34/+4?=
 =?us-ascii?Q?f7zkYP6wlAkQNoPZWT2pZURCIeDxy4qfLJMRwg3q9z/uMcnLV/fgxfqe1fn7?=
 =?us-ascii?Q?5U2Sssvc8ywzcOgkDchpJo4pirUsHcy0yHQ1Egf1wEB8K4jz2+xqkwWwlboV?=
 =?us-ascii?Q?FcrZRo/AWpjlwXQ3fW0rEDi/d9Yo3ER1VlxZV9iU+kmReyVVxFSoB1pMZDng?=
 =?us-ascii?Q?LugRqXeNSrh0j/fIk5NjmxXpC9YRSac8w/9Hg3MIYALKilT7mim/SBPyGxla?=
 =?us-ascii?Q?N9JqdpAbn340iY23VxKUVybV5HCH51qUWgDHa5dsD4288FQC+S+1DvB9PTKp?=
 =?us-ascii?Q?MTP49k2l/SLsJ9EaUEPABdUeC31jV0ZZwkC1iVfo/yVrEi/7Yi3BExYKXkr7?=
 =?us-ascii?Q?ZcB3mX7Z8fF12v8PeXQT3nUO13yU2xwhjeDmV3Oyez7DZSisaSN0w4qT4o4P?=
 =?us-ascii?Q?lPag/CMEbAf9L2IhEX+wY11/n2kXZlg4JPhfGdnFIofh4+lfOucEVbDGWdE2?=
 =?us-ascii?Q?7jZOHQxgbxWIKI8TlKfx0BYrPVmg0/BjN0xkMqFseG8H7bCBk9cXCjj1MoRL?=
 =?us-ascii?Q?X6XsFYhiWYXqrgk1biQ7keWPy7kt3q5mYrWxLXJQR4muN6EyH3F4v6Q91BVP?=
 =?us-ascii?Q?3nOyTDoLIcJsSsP8l4aLqOZxjKOcSMpAnzlVeL8njjvqh2bO3E+sJzIgE64r?=
 =?us-ascii?Q?JslToyG3HOIrIuBDjaSjoMKDinINE7Ro8aZim1yg0rNHbgtwSQxjQbMAgEt5?=
 =?us-ascii?Q?GnAhR/WGqICEocUsIMeaSa2reVT25hOoL86RTVv+I+MgBfC3U/MKxqSQxH/w?=
 =?us-ascii?Q?Rgu+9izmQkr/F5/nevwEIldy/10se+tQQ8lmwU4Rmr5CpuIGcOF2wD/JVLI/?=
 =?us-ascii?Q?Z8nimbVVJmaNuzWxLLBPZBjpG5z4RRRBZbNTjQjIKi4T7fSuJgWYQCf2zNzL?=
 =?us-ascii?Q?oDYUQrWukHVZX8shqWp4v9yWen4YT80AVPq8a/p1u0+4H1xyczeQ2N3gjakA?=
 =?us-ascii?Q?s1DN2oLfi/cxnWGFNUd31vLgrf4tjxXHsrN7ErD2DUAmI79luLv9nROUhCcc?=
 =?us-ascii?Q?GpIKNtYvs+OsgBSteOE8xu5rCoO+qL5Vgw+ZDmAIrijzMHJ8q9gqwe5W6m+Z?=
 =?us-ascii?Q?QL37N1IedGDFthTpynR8Dzm5EcNHGHLerh2ysCleDfhdVgtVetF+N1lGDm9n?=
 =?us-ascii?Q?DNw66B95vEa2J1GHytGpQ92hQMr/1jvH5o5b/TcnE1FhILFQlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:42:42.8880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cac825-73ca-4cf9-056a-08dc8fdf9595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

commit 95272641338a ("ACPI: processor: Use _OSC to convey OSPM processor
support information") introduced messages related to determining processor
support from the firmware.

The UUID 4077A616-290C-47BE-9EBD-D87058713953 and _PDC methods are
only used on Intel platforms, but all X86 platforms emit the messages.

Attempting to evaluate them and showing messages on which are used is
unnecessary for most users.  Downgrade the messages to debug instead.

Cc: PradeepVineshReddy (Pradeep Vinesh Reddy) Kodamati <PradeepVineshReddy.Kodamati@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/acpi_processor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7a0dd35d62c9..e82ec4f126bc 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -598,9 +598,9 @@ static bool __init acpi_early_processor_osc(void)
 void __init acpi_early_processor_control_setup(void)
 {
 	if (acpi_early_processor_osc()) {
-		pr_info("_OSC evaluated successfully for all CPUs\n");
+		pr_debug("_OSC evaluated successfully for all CPUs\n");
 	} else {
-		pr_info("_OSC evaluation for CPUs failed, trying _PDC\n");
+		pr_debug("_OSC evaluation for CPUs failed, trying _PDC\n");
 		acpi_early_processor_set_pdc();
 	}
 }
-- 
2.43.0


