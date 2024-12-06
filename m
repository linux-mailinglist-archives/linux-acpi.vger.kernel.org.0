Return-Path: <linux-acpi+bounces-9999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BDE9E64F1
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B46216339F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD191B4138;
	Fri,  6 Dec 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oA2mXP/l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED0197A7C;
	Fri,  6 Dec 2024 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455558; cv=fail; b=OtWiUJci0DhWLMK1hWE/B5rrNMdU+IkSyqarhKuDa9HtTYaUodiaMDb64XCkY0FTumevryCknTNCD2gDfC48D4cAG9PdjSDrJDQaCKngY9WTIZoERbjibi0/zBZJN85l2w4llIAY/ZXik36w4gGRx+rKD8d5tuyCrYQ6ekpFFF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455558; c=relaxed/simple;
	bh=ZJTxHbpEK+5mOLXway8/LK6Isqc3CD2Ph/03ojflfd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juMcOe4qtzYrXP0PMJN1FT/J4yUIc4OyGE7glRBy/TKeef/x1/65oNRWjg8o6VeFGb4rnxw5+2qshU6BORKx2DIR215vzcD00r1oevPD96nTmGTo1pq05vjbTR9dd9l7fg5LWRFVqtVtZOqCvfy4UhiTLtPT04ByyVUD316IOo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oA2mXP/l; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GA2rcQupTnrmxEqnz8QgBqO+CGyqCn0w+bS+3JnelYYHKcSoxuaYPtZgU5b++XTAFs4ayfq4jyjn9iz9npzIGGfo5HHibvY5/XBbMGl5joPa5ZMwzoSozkvaMIXmNX/gvCLKsqRRVb/Pt84702MPCoBY8vQc4unJCeH/rMIFBwlO8sN5UZKHGGh0fN218cyCnlvniozZ46OXkmkYbMO88OKJcezDlMLh+2hSkP6KG1Trrgzn1n8OVCpmA8BB/WOt4Qa2hqx91xMeaKtR0JkJiwwsPmyjD5CQqYPWdls7Srm531D0Si6/d3zdBbVFrlIjnnBHNswr+r+b1F7KdmmFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92gntFMECLO6ocWI9qMwLT9+vn6CDeHjsVI2pMahJZo=;
 b=ob43uLLBgCkCZ/k8ht7dEqwB0E3O1P0zFHkTgP/FSDGtTae+o4jCXnX4SjUdipUJbE6cAeM1G4+rEgXEMtieGcYGnfJJsbRdhu9+6UV5ltQ/Kj8bepXSoKwkbhjK/aG8aIzETp4RXtfTH2tR6ndJ6gUWfC58GSPyJFe4+EriINgvZUn43Az8Yn3aXBJt2BZ62dOoC8uMhStYuq6FoJ1FjYx/iWAPuno8T5o+um0kQCy9+ICKBK4n8Ad2cHDIcIrRTpdcM+IwcbRb4DFwvbHddzhuNUCZ4U9SzaFVX4UQ10ReAEiBFjsJLPLS+gFyme7/Ebo5ZCy+EYeHtpQQuzvSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92gntFMECLO6ocWI9qMwLT9+vn6CDeHjsVI2pMahJZo=;
 b=oA2mXP/l3Ca0R0MSPwDnLaUlsMUg4dFtZDhRwbEl9Fx80avENy8o8XoTcncp4UCbZcQejlnUuKqMsDpLysKy5mxjSEqH0mit2pAFjEAQtFCwvMW1hQIfI9AgElPrHvLHCRmrbALVI+xTnO5iVev/eFQgPSk7tRxnYd7KcxKYWAs=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 03:25:53 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::6e) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 03:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:25:51 -0600
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
Subject: [PATCH v10 14/22] ACPI: platform_profile: Notify change events on register and unregister
Date: Thu, 5 Dec 2024 21:19:10 -0600
Message-ID: <20241206031918.1537-15-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a3f5e5-53cb-4cb8-a20b-08dd15a5b082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WlEPTzoa1a16vJNAwtyjeN0uq5lmBnJlmU/Jye57SJSFbVaGgwRsh6HHyjxf?=
 =?us-ascii?Q?0FI8R7MQFN1CzXDbcSX/vreakgTuc1Oj469Vj00EezecUk+PLkf5D45IAQG0?=
 =?us-ascii?Q?qO1NLnIcJ8Q1leaxuPW4XBpf/XfLZTfST/lqEVvCA4dMc7m7qdlt0kXcMEeS?=
 =?us-ascii?Q?O2mH/CHiMK2rg/LnUx4p+jc90ASmu32p/63x6mfC1IiOt+x4kUh363MH62bi?=
 =?us-ascii?Q?EVpQKv7vX7OG63v2NO1gEDkFyCtcFOec8d1YkQCftRlabfQrlwtHGR6qnDuG?=
 =?us-ascii?Q?DIwub9eCbQZZRCVNwYJzjZGM9oAXW7VWxjFhsNWHdSSb62TYS2t+rP+sksLD?=
 =?us-ascii?Q?n1oPYB0q+4ulYTq++CBuZ8Oalp7ncpKXmc34sk3HMwbEwvvEk6C6CklSLlkf?=
 =?us-ascii?Q?NP89U6m6ZZ45/UKnBY5UUSp7f+Bd9uvcyYhB4WZvTzT/jYB7EBvNLvEfSwtN?=
 =?us-ascii?Q?ay9T1SHfQrd/62KcGOnJMyc7qcxm6ILJut6GflGgHcI4yCOqnXdxvdqMWDzS?=
 =?us-ascii?Q?gn/QhtH6dRP/OzkMidTEPy5xQL8gLaNvoH3/ugW+n4aCBBxRF2S6OPkJImiV?=
 =?us-ascii?Q?9S9+QZ5XxdSIcAZNBL7qs9vuGaRwBvtq7Tt5a9JiL8ZLVt0zIg5bc1ZoNHQU?=
 =?us-ascii?Q?TqlOhoQzP35gaiLMd1p5W+5xkAdfOoFbW7aGTk3Tr2Wust/t7gE7iTN2HmDI?=
 =?us-ascii?Q?94BXsRTFoHFtjekU/d3MdXkYVLHbQjJW5XUYCSnR6mW5bGf+P85j/o2UdL3z?=
 =?us-ascii?Q?z5fjTMl2sFwWkwB5shSmOdCcPHgT1IrReFxLqA1V6tXjBj4885vg60dFdlED?=
 =?us-ascii?Q?amYeHL4h2vB9kyDhGO8mJsJFN8+33eTLAKcAGshWXVu5b/BPdeghU3QymMeY?=
 =?us-ascii?Q?FQBvqoTwq1EicZQ+7Slg0HdERZJ+WnL7cUii4nqyROc0OSYyT45wjWk8o/UH?=
 =?us-ascii?Q?WkxjFkcxU1Zblb1S36ktJQCHowdiwgdpURTCWTmEq1Qtb2kcI9gJFcXjY09Y?=
 =?us-ascii?Q?y520G+h1lJMS0OSibeYLWZuXEKtLeDFAdpgeYo0jiflpQtZdNKRn1YPHO4z4?=
 =?us-ascii?Q?jQABhhnAmA/2lbiVn5KQIqaak0BUn/ARevqlqwYsqEiz/F1NZKF1C7W0bkaC?=
 =?us-ascii?Q?01tqgLLYnM/NaRK9ETWZ1g2V1Onnd7mxaSnMN4jOK8uYfplHNObgp07sg6Ai?=
 =?us-ascii?Q?XwPlaiIorDWWSbGRUil1Z/FOtVd2QU8IA48fvYHNQh3sPoolAU+wibFr6XkG?=
 =?us-ascii?Q?4HaTSX/pWtiZtYEDEL2VUAw9AbbbhEVVgBPHS0vnJVyW+eTYGg+ZABEVXQeQ?=
 =?us-ascii?Q?Tuq4mICyn6qA1I0UMRH7simtVOEItxYEsChA2CkH2299ACeQJk2EMNimEeTn?=
 =?us-ascii?Q?6Q/23i877gpybpSTMTDDqnIOEGfNZrRlely/dhbrYsDdPha9GCkrFxDtPkpi?=
 =?us-ascii?Q?/0BNnHFq/6OekB0miYbHbGDdA+lFRBeq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:52.9898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a3f5e5-53cb-4cb8-a20b-08dd15a5b082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2c83cb258296..2a4f067c3c5c1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -361,6 +361,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		goto cleanup_ida;
 	}
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = pprof;
 
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
@@ -391,6 +393,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
 
 	return 0;
-- 
2.43.0


