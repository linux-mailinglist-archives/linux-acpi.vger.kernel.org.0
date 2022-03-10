Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BC4D522E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 20:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiCJTSg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 14:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343503AbiCJTSe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 14:18:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1F394;
        Thu, 10 Mar 2022 11:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq9RtItqo2u/p2s8THNR//SXwQGKKbYXmROtksaBum145Qm+OA2pPzqgjFx4hJClEcvfYsSUzSNheQcjqup9/9NcO5ux2ITMseTDanzM0W/gib95pEX4wu/WBqo3hvzQRiTfCkAY3wtFa0CssI6D6krpCAh5stxJ8Cl8CEhP+8BWf/PYwDF1CqkVtAQZdvF2jE6JbzigmbsfH+JTaXjwcRHeDVZFu2KMRtcHI+q9+/xNBkg2ZVZx9SR7z2o2siqbGGCrZ0Syp8zdgpC4GvoWLE8pAGiU7ev3mnT5duLjd2TYSD6+N5aLIG2L/1+9fkCihwRW5i23A0bx+jROQlPQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qICJ6p/yDX/mZ3paBS3atf3sqcokoK95hDIGa4eeC2U=;
 b=ogQB3AYGtU+o+oDM90LgSIQvnzEsLbd8BX374BhON/Dip3iEicoJzfK3JP6MZBqOE2OBJU/CbOdsrURJCcKL6plbKzPD+d+P9MM/Dko4ksS4TCePehcVeOm7r54gNs7+hUBVBYYJP4cQ5DV1xsxKcDrVebYoRd8Ie+p2Klmeh0MPcMzZkoWMBHHfcXsHowl10nMjkTAyXpUmx9GhLdmoeE5uzFCS1MbVRlqK/syuM6NTtdWTOlrx/QD6g3MKUGiB3SbDWB3ogtV/SWhmrHWo8nDrQvj3/WQLDnrXQSFBZXjddJHLvnIqJmjlFhgRemcCJ4LitL1+EFTncZrrE+/KuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qICJ6p/yDX/mZ3paBS3atf3sqcokoK95hDIGa4eeC2U=;
 b=zVPqf+lWiL/9p1EoYThgIljxcLkQxt0p8ZGJM0YkR820+yO9pGkBA2Etgk2e6obsWChRt6AEKmR1+LW7AkdE8ooG6ZIQuS4w7OQ0iflTPI7kHVqXZRggh6wSk41kf1t4YGGidvmbt5Ptf0Bbhp134uJpaHYQxyF+Lzc/Hl8rePU=
Received: from MWHPR14CA0030.namprd14.prod.outlook.com (2603:10b6:300:12b::16)
 by DM6PR12MB5006.namprd12.prod.outlook.com (2603:10b6:5:1b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:17:27 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::c6) by MWHPR14CA0030.outlook.office365.com
 (2603:10b6:300:12b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 10 Mar 2022 19:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 19:17:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 13:17:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH v2 3/5] ACPI / x86: Check LPI constraints by default
Date:   Thu, 10 Mar 2022 13:17:22 -0600
Message-ID: <20220310191724.1440-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310191724.1440-1-mario.limonciello@amd.com>
References: <20220310191724.1440-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38761008-462d-4219-0f28-08da02ca9d43
X-MS-TrafficTypeDiagnostic: DM6PR12MB5006:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB500689AC6051FFB5F63098F6E20B9@DM6PR12MB5006.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsgtV3r+8xKi8nXvdrAevIL5jduMfnkM5veYeoEaorxvavouElSmbCsiotlQl8+3+Dh1vQXtXDB9cCXmhT+jNdPMknowSCWYvT1qIxdpNUkhp2nClSIa28JnvIU+83hdjaBgPYRy0UqPOKXFW9L0Og+qLX+KNAqcagbxyIAn1rM1QeveJ19vNYfn3y1Tb8m3HL7d7z1PgnH4eeYtAtCK8pKdP8a7PQRwHddzwHUG9pfAzskAQuvwvq4nzapfETwIWgBCxZ7FVpZ/8giMSaaQb0Gra0hMcnqwe2MwlJIz5XdMINoRLs2AWqc9h9bfDuWu1XXuPlD7+lQDbIkt0SxK8tTpBQK6FCwW/eUmsKCtAhFgHXP4hH5aqk8HIpBOKjAaOH8U6vq/Wu16S1/ZV9dgHc4MjN8aXZM5jU6WLjk6lUC2kdxd6UIkAHni/b8hge5ivjKG8cFAIbSt5WMckK+GXcjN9tXEXAXrOs1B71XRBnW7ypfQGl0NX4HtHg8r3v4tLJxb5m+Vsn3KW1pPlMrDZM+MUA8i3oBPXmY+LgrKjU5CJAuBdwWCPwYVM9+LDF8/wnEQk6GghPZ/+PP7sCsaYSMHi10o649/skQ3vyYhUKhERg8pxO43KADV6NhaZnJSVVzqr+tMwN5+Ctbi4p010JXLMicm/VU2x49zGVQP5C3KcREb67n1fddomqUHbENfHeEKqwsSjCDSIzlsyd3p4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(356005)(1076003)(83380400001)(508600001)(86362001)(36860700001)(47076005)(7696005)(16526019)(426003)(186003)(26005)(4326008)(70206006)(8676002)(70586007)(2616005)(82310400004)(36756003)(44832011)(5660300002)(8936002)(2906002)(40460700003)(110136005)(54906003)(336012)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:17:26.9538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38761008-462d-4219-0f28-08da02ca9d43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently LPI constraints are only checked when `pm_debug_messages` has
been set. They are mostly used as a debugging tactic.

As the results of constraint checking will be passed to consumers of
the LPS0 callback, ensure that constraints are checked by default so this
value can be trusted.

Suggested-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v1->v2:
 * New patch

 drivers/acpi/x86/s2idle.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 808018bbab90..3236bd66f499 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -307,16 +307,19 @@ static void lpi_check_constraints(bool *met)
 			acpi_power_state_string(adev->power.state));
 
 		if (!adev->flags.power_manageable) {
-			acpi_handle_info(handle, "LPI: Device not power manageable\n");
+			if (pm_debug_messages_on)
+				acpi_handle_info(handle, "LPI: Device not power manageable\n");
 			lpi_constraints_table[i].handle = NULL;
 			continue;
 		}
 
 		if (adev->power.state < lpi_constraints_table[i].min_dstate) {
-			acpi_handle_info(handle,
-				"LPI: Constraint not met; min power state:%s current power state:%s\n",
-				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
-				acpi_power_state_string(adev->power.state));
+			if (pm_debug_messages_on) {
+				acpi_handle_info(handle,
+					"LPI: Constraint not met; min power state:%s current power state:%s\n",
+					acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+					acpi_power_state_string(adev->power.state));
+			}
 			*met = false;
 		}
 	}
@@ -456,8 +459,7 @@ int acpi_s2idle_prepare_late(void)
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
-	if (pm_debug_messages_on)
-		lpi_check_constraints(&constraints_met);
+	lpi_check_constraints(&constraints_met);
 
 	/* Screen off */
 	if (lps0_dsm_func_mask > 0)
-- 
2.34.1

