Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76C44C77D8
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Feb 2022 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiB1Sdr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Feb 2022 13:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbiB1SdC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2022 13:33:02 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD1563F1
        for <linux-acpi@vger.kernel.org>; Mon, 28 Feb 2022 10:17:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7PntFQQT6bGLkbPFhe015UA2A9E53g/rbmFsbqEeGS0sywsSh0zTl8IaISQXyHrcvPehf2fBefHXuccu2g8Jzj4gyEPJb4Cj0lMuSW/eMx45Yqs3jHl4NKZkMOgXkvkX1JHFEHIeI6qrkx5rL/inKPAs02F6cCpp8bQGRSSYjvE7PugRASBzgzpIkwenW6eyHCnPb7kYaNMUWJ66JOYl6hlw1QD8WV2+HiRQF1pjuDOu1Eebga3uFosEcFxAQdQyrKpdpMFM6NZNJ9nDoQfE49kUP2bdMJDnyZh8sVraVYsgS3CMQu3PEXr70YbHYUF/X6+lPJBycWwFyCpp49igQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBesWYYmUYYZHELlWJnEDrwMQIVJsJyf+5vLt+beZx0=;
 b=mMO5Q9gJxhqQWJOJ+GKSgaA8eS1g4LU3uy/KhwpZlIsIAD2g+Gu7wrqi2oFb5abKhcfLsd9Puu8mBBXDvLIkpFuZWFQecB1gJpozCjFKkQsQ2YmxNWi25AsqhZEQzFImCj25tQYqUt38d8VBU8lNa3NlPEQzfqWle5uGevSWeQIsq4XPj/wm5vWsSe/t4xdcacSKqT70aWsk+JQYWeCn5xHOkLWVhIaS1u713l0a/7gagiLTq0gfV8pheMbYXvvpX2QCRTTuXUKNgS08lJ+XNUjgXoCUuAiMp73Kym/eDIl9tLH01hGR8Y0wENS8pmz5Ab5g4fQzakVPT10cqTNF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBesWYYmUYYZHELlWJnEDrwMQIVJsJyf+5vLt+beZx0=;
 b=pyChwr/O+bbdITrWgjDHIkvqvtfPJV2K3v/KQb7YoMr3y9Q0dI5SyYUytgzd++sRZlAMWmwXprzM4TM38OpReJT140dKLG7ajvC1OJY2uqjMmTl6ykqZKtR8LXRXj0MZjGrqGRMIveDjuUMdSzlDan0zaGLk4m8WkZh3WR5gN2Y=
Received: from BN9PR03CA0515.namprd03.prod.outlook.com (2603:10b6:408:131::10)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 18:17:10 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::52) by BN9PR03CA0515.outlook.office365.com
 (2603:10b6:408:131::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 18:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 18:17:09 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 12:17:07 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] ACPI: bus: For platform OSC negotiate capabilities
Date:   Mon, 28 Feb 2022 12:14:46 -0600
Message-ID: <20220228181446.1975420-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228181446.1975420-1-mario.limonciello@amd.com>
References: <20220228181446.1975420-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee99bb92-87e5-4e43-45ca-08d9fae688fd
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3937193CE0750F5CAC8C24F3E2019@BY5PR12MB3937.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++uJ4gCUslVy/VK3sNnJAyb5SwmV9TzaFkWG9wUrxJ688LWaBEAvwJGCem2lQC6anCtaVKjmm8F3ajXa6i5TV5E6l8T59cODRBAQ7CNfnjYJalngQ3pi7BFZHQpPtqaxwrk/4x+Xd7gjzvj9QeLMh3Gb/SGMmCrT/i9x/g2lFqTWt7lbcfUeuFk5sqfnr3kAH49R0w1E8nY7sS95I9K5e1wVRuk8rIcDq1FYsODQK+qrvGoLcRKabDkGRFSouR3ri0xwlYxKAin2f6lyV3tFWuzn9FPjuaHgby7CO2sQGA2IAOhrHxVQktUCw1Sv0J0sBcosm0OqyVxMtwvuJUk2N8gvCEq2r2HFfscDDPJjODkTMYjAXjRU+l0q2gcXCYikN0Tgyr243tXhmWjEbG8irsm8JtBHca4ay7iqiUs6wSrk063N5MY6zgi0Gn0msREDa/2of2oq0fRP8nq4s2MqeQuhnQigoaWnU9oOVe2P3lxHxv8vu1DjW2FS1OHubXqlEE2Vf5RWB6iKAR7suwpNMU2OTo0kkgS+o1WJsdxKFKiScl49I6B7H0mgrEyNSjKikhKomros1G7jsRIKUEcBoUsayFK/BtffVg+yiePQA1AhrATjczgmAGHSrH49Oa+zsvZKUSRUachvh76jpSUzjm/Kh5yKv5iMg+w+i8RqBsNhT2GIcgyeJXShTLXf8OTcHF/pL4K15xanki+qgxzzaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(36756003)(54906003)(110136005)(40460700003)(316002)(508600001)(83380400001)(2906002)(356005)(44832011)(86362001)(70586007)(336012)(426003)(8676002)(70206006)(4326008)(82310400004)(16526019)(186003)(6666004)(5660300002)(26005)(1076003)(8936002)(2616005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 18:17:09.6732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee99bb92-87e5-4e43-45ca-08d9fae688fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

According to the ACPI 6.4 spec:
It is strongly recommended that the OS evaluate _OSC with the Query
Support Flag set until _OSC returns the Capabilities Masked bit clear,
to negotiate the set of features to be granted to the OS for native
support; a platform may require a specific combination of features
to be supported natively by an OS before granting native control
of a given feature. After negotiation with the query flag set,
the OS should evaluate without it so that any negotiated values
can be made effective to hardware.

Currently the code sends the exact same values in both executions of the
_OSC and this leads to some problems on some AMD platforms in certain
configurations.

The following notable capabilities are set by OSPM when query is enabled:
* OSC_SB_PR3_SUPPORT
* OSC_SB_PCLPI_SUPPORT
* OSC_SB_NATIVE_USB4_SUPPORT

The first call to the platform OSC returns back a masked capabilities
error because the firmware did not acknowledge OSC_SB_PCLPI_SUPPORT but
it acknolwedged the others.

The second call to the platform _OSC without the query flag set then
fails because the OSPM still sent the exact same values.  This leads
to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
tunnels can't be authorized.

This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
same capabilities to the _OSC regardless of the query flag") which subtly
adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
with query bit clear").

The _OSC was called exactly 2 times:
 * Once to query and request from firmware
 * Once to commit to firmware without query

To fix this problem, continue to call the _OSC until the firmware has
indicated that capabilities are no longer masked or after an arbitrary
number of negotiation attempts.

Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
the same capabilities to the _OSC regardless of the query flag")
introduced, explicitly mark support for CPC and CPPCv2 even if they
were masked by the series of query calls due to table loading order on
some systems.

Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * Fix up commit message typos
 * Fix up comments for capitalization and punctuation

 drivers/acpi/bus.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 81647591ec27..be5a20913eaa 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -308,6 +308,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		.cap.pointer = capbuf,
 	};
 	acpi_handle handle;
+	acpi_status status;
+	int i;
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
@@ -343,10 +345,34 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	/*
+	 * Check if bits were masked, we need to negotiate
+	 * prevent potential endless loop by limited number of
+	 * negotiation cycles.
+	 */
+	for (i = 0; i < 5; i++) {
+		status = acpi_run_osc(handle, &context);
+		if (ACPI_SUCCESS(status) || status == AE_SUPPORT) {
+			capbuf_ret = context.ret.pointer;
+			capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
+			kfree(context.ret.pointer);
+		}
+		if (status != AE_SUPPORT)
+			break;
+	}
+	if (ACPI_FAILURE(status))
 		return;
 
-	kfree(context.ret.pointer);
+	/*
+	 * Avoid problems with BIOS dynamically loading tables by indicating
+	 * support for CPPC even if it was masked.
+	 */
+#ifdef CONFIG_X86
+	if (boot_cpu_has(X86_FEATURE_HWP)) {
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
+	}
+#endif
 
 	/* Now run _OSC again with query flag clear */
 	capbuf[OSC_QUERY_DWORD] = 0;
-- 
2.34.1

