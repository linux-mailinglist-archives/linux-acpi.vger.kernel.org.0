Return-Path: <linux-acpi+bounces-2609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9B81DE73
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Dec 2023 07:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920BB1F214C5
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Dec 2023 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82751106;
	Mon, 25 Dec 2023 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i4MCTpvh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60210FE
	for <linux-acpi@vger.kernel.org>; Mon, 25 Dec 2023 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj2DEOE3x0ntS36Rf/orvBe7NEUmBZNPSmydz/CWBadI7GenF55W/I+P/Xp7m4HlrB/nDJ/V1W0eeeLQBhCTR63A8KXWK7V0hEFypNcQ8c6Oxlx8AaKOYV+7JpNAaKSAjr+Ww4CZkHFFD97tTb3WJrdOwlOzX6LdPWs7JStwQLz0ChKpzifB0Q33DjXMNQZAlwDnX01p40q3dO2LU2Lk6k8GBgjHIZU+4svzhFWwwAY3dnDAcSmGN51mvWizh+HGyw/UpAMcoPijxr3sLQomlizl+C2iS1cTtLg8e+NjQlVEgP7YAbYbXWE3+qa+KGnN0O6qDrJiFre01GrxqWuAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQQtxH0+WwnTDOvZ83GMwn8h4r2TtRcU2sbvRhZxK94=;
 b=fpwhjI+d7wkAbyooWVxp34Alg+WhpUPgxU91SZbLNBPNPtA+hEeg4+nZvyLeOkr6iIxEkUxee7z8NTD1Wz0Gd6dErv1pc0l9cpnfPhZ+3A8QEqE45b+2862uI1/KjFWP+MIiCqcUcPj4Xhb4lRXZ5yUPm0T3ShPMDUisK/k+t3BIc8EW+f9z3xQY6wy0Jv0JQ4OKsvLyJ7Enbgp+P4D2kOgHob572HiJAiOScYHjoVnOiTivZN2txNWHvDzplCkx0CIUWcmtp74WrdwTVcpe1XyoIwRSVVSbPrXiXH7+hETx5ktaShePgR1OUUTS0AzpveyW0dKwKe6ruHu3UBs8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQQtxH0+WwnTDOvZ83GMwn8h4r2TtRcU2sbvRhZxK94=;
 b=i4MCTpvhDDYUBQTjSlv8i/vjxxQOuJPW7ve4GyQxZ2XVGARyKT1KG1BSQQ2mV7BmbVkKjIl/UkCzl5V7K13yGwbd07wICmyfqkrxTkTTlVOzpWg2u3Aj92m52zuH2Xul4/MxltJlJi6EqG5gcHFbMDEFmg+4t0VN1NlgwNYGatc=
Received: from SJ0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:a03:3a1::33)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 06:00:14 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::2f) by SJ0PR03CA0388.outlook.office365.com
 (2603:10b6:a03:3a1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26 via Frontend
 Transport; Mon, 25 Dec 2023 06:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Mon, 25 Dec 2023 06:00:14 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 25 Dec
 2023 00:00:03 -0600
From: Ken Xue <Ken.Xue@amd.com>
To: <rafael@kernel.org>, <andriy.shevchenko@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <cwhuang@linux.org.tw>, Ken Xue
	<Ken.Xue@amd.com>
Subject: [PATCH V6] acpi: button: trigger wakeup key event
Date: Mon, 25 Dec 2023 13:58:35 +0800
Message-ID: <20231225055835.1052555-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.35.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9b45bb-3c33-4a54-7a6f-08dc050ec368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2dD3W6+jQmFvJgZc1bkuvMRf9qYay7ElKjTg2JEcyX/QK/Sgl/ukBYj46juf2zrr+800nole4CtykW5fbhgexA4K7Z6z2FAILRYnXgNLXp+dNtGQsvdj3b/r0gEp8YAtgoNw7M2teoCs7tEXM+IWO29GbEXuqG1W22eAhe+bJOuPSRolRMj3z8gnfY8yseB2yj8vRWE8PAgmeF8lzmKKp2lWuU4EhvZzJlDiIFnDEBAMXFszQBf3nUvoHhwO270ziAtH+ywzWwou6lw4RFahelLdsOxcClo/NDMjn20gagIeeLuBIh7kcFqKpn0FpRb5hhzmgugIQ67+jQVP2ML1QgZU6/Q8dPpmEeUN/yaXYYPlJ9i+XPKxF1MkwTLY53Zk+rtrrSp/s+Sv23AVk1rF/gXU7jDLKgZJXrmY/2KJxBxfpd/irxgzMXFqzITeQ1OP+wOn0Few/YQUQ/g/CRc3TuDaBb3N/As4wPqzxqD8VVOYUu3FY4FGjhxFalBZt9AcueyjUIGSSRotu8uuRJ0iOfThYx/7QpcgMu2sY3OdS5C5TqrFDV/doSmY3j4MYGU8qeyqfEYW/ezO4BPlyxYt0Lq45E64qNeb0kKL6RNDDTBojM9NGkV8iq2A5O5xa/3ZquQYbJAPMkrKDiUfzaoyRJNKY5VW1Suv5KXz06lQ7QYtit4J2YKqw7oJyE0OqadUtpdlDu77X5FC1xigC97updTI2q3DVELtYhd/4sIVrHgpV52E3FRLUHHjiQ8pHAOMtAItNlPAk8M8aG+tzyL216E8WiLxQ+RpSHZXJ6Bxb5jurqjA747ej3LwVppDryCk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(1076003)(7696005)(966005)(478600001)(6666004)(426003)(336012)(16526019)(26005)(2616005)(81166007)(82740400003)(356005)(47076005)(36860700001)(41300700001)(8676002)(8936002)(110136005)(54906003)(316002)(4326008)(70206006)(70586007)(5660300002)(2906002)(40480700001)(36756003)(40460700003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 06:00:14.5071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9b45bb-3c33-4a54-7a6f-08dc050ec368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942

Andorid can wakeup from various wakeup sources, but only several wakeup
sources can wake up screen with right events(POWER, WAKEUP) from input
device.

Regarding pressing acpi power button, it can resume system and
ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS are set in
pm1a_sts, but kernel does not report any key event to user space during
resuming by default.

So, send wakeup key event to user space during resume from power button.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
V1->V2: fix some compile warning/error caused by lack of
        "struct acpi_device" declaration by including acpi.h.
V2->V3: use "forward declaration" to fix compile warning/error.
V3->V4: refine coding style and commit message
V4->V5: add "select ACPI_BUTTON" to fix build error if CONFIG_ACPI_BUTTON=m. https://lore.kernel.org/oe-kbuild-all/202309150947.YLjvs2Vv-lkp@intel.com/
V5->V6: report WAKEUP event from button driver instead of acpi sleep.c
---
 drivers/acpi/button.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1e76a64cce0a..cc61020756be 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -480,6 +480,7 @@ static int acpi_button_suspend(struct device *dev)
 
 static int acpi_button_resume(struct device *dev)
 {
+	struct input_dev *input;
 	struct acpi_device *device = to_acpi_device(dev);
 	struct acpi_button *button = acpi_driver_data(device);
 
@@ -489,6 +490,14 @@ static int acpi_button_resume(struct device *dev)
 		button->last_time = ktime_get();
 		acpi_lid_initialize_state(device);
 	}
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+		input = button->input;
+		input_report_key(input, KEY_WAKEUP, 1);
+		input_sync(input);
+		input_report_key(input, KEY_WAKEUP, 0);
+		input_sync(input);
+	}
 	return 0;
 }
 #endif
@@ -579,6 +588,7 @@ static int acpi_button_add(struct acpi_device *device)
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
 		input_set_capability(input, EV_KEY, KEY_POWER);
+		input_set_capability(input, EV_KEY, KEY_WAKEUP);
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
-- 
2.35.1


