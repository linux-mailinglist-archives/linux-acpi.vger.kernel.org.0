Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E054D7A03
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 06:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiCNFFJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 01:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCNFFI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 01:05:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277C186C7;
        Sun, 13 Mar 2022 22:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTdwguk6rEtNBGAXkA6JXxw86EPfvYTa0c57Fj2lZpyrvabZR7hRlBP5/v2AfTOrg5UmAn6lR7pdkvb47uce1kuoA0EBYa+90zBmpidQLWdhpy5DQBodi6bUEPXI/36PdVNkVp1HRXwvvtttSNkOllxp2BNuwbF4GIZuAwWQ0iv5t3I609Ztq57CNAEkznjf8svjlx0GmumIqkX9avoNk7He/MCS5H8YkJGmg5ybPPDduNkFh8tHD8DShoUB5S8UWrdji8/0M634Rf/lyVjumdXcIGtHlFkfNkjX4MxYFUBdYJdQ1Wy+57QHr+V2QnmHgAsrdnkIOdbZvASDCCPctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EEwbJtm85JwU+uDBFJr1xPlI+JYWu52Zzp13D1ABwU=;
 b=B1vWaqMYXbr+MjeDrxUxpKD27EcgLMBHkoKwkh0pcRlwV1PsA20PBjWg71fMgoYHZmxpNVis9PsNKrUO2gUk/cgHsXjG+vGD/YAHf3YVJrc2NR7wDut7efY+BhunDbsZFyEYCB+9BPmtJQQi6oNntlL+Ofxi04sJamquccc2QuvesXckEBcfb8IfodEeA2b1xjAeKVw4I5/tCATKI6CFgesQySv2n4nBA66KaCI1ymo2DIy2m8WYNIMdLkyPoHGSCqYB1wfH++TKX9xQFd53a995KqrScK3D+EcbgcsYIlpsMO1AB9jXtD5ixdSmlGMVChdhOiE62AuqZbzrhHS96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EEwbJtm85JwU+uDBFJr1xPlI+JYWu52Zzp13D1ABwU=;
 b=Bz6njrxkTE1fcXnu2gscfpF7Pb01YVYCwMDX6WxX5bLH5WLVWOhy1qRmm3I7jsZ+tGmVk5ZlJnsRQoUj2SleBPG5FLEUu+hN4B4Gs4g6/0Vo8CDzq6pTzKRAS8P10Yr5Hyq45Dfe607mnXVzK37zjNBuB/TtBTh7fgQ1tjOWYKk=
Received: from DM6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:5:190::37)
 by MWHPR12MB1615.namprd12.prod.outlook.com (2603:10b6:301:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 05:03:57 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::c9) by DM6PR11CA0024.outlook.office365.com
 (2603:10b6:5:190::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Mon, 14 Mar 2022 05:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 05:03:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 00:03:55 -0500
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
Subject: [PATCH v3 3/5] ACPI / x86: Check LPI constraints by default
Date:   Mon, 14 Mar 2022 00:03:37 -0500
Message-ID: <20220314050340.1176-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314050340.1176-1-mario.limonciello@amd.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50e7f0e9-94f2-4699-be46-08da05780b36
X-MS-TrafficTypeDiagnostic: MWHPR12MB1615:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1615E556BFF0E39621185184E20F9@MWHPR12MB1615.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKH1nCyElxa4FYU95Nn3HSF0Ro+Me3uLxELjY3VSg8IXcSHBC1OQ1E/MKjIc2PRjI1BweLGid1NlzUY9RJeMUBiB/claH9+o6TqESltLT1uYKITbb0Nvdx415F7JAUPypHIWVNUQl1mc8rrjTGhoQCCNJmIp314mVsWTIxzisyzAE4qvlBv2chL5rjH39n4sfeEe1DFV0xZ40LrDN40LwJO7eqzcfnf9ouTQWozBZuc+ZhaOOEg3AV6R5380TvncGdJg6FUaWDk10ylc/Gh3pyDzSgzZ+XiitX54QdYhoWeDRjVNwCi8MxJs8REGgGBm/3LEwraHSJBG4wgWNlr5LcTwpWOyJMlM/Q/ma0RZ4TJpIRl6SrMoh9eJ3K4L4PjHISY1b3lJ9AnabN+O2T8d7Lahy1pU/QMkSJG67Ewpmn8zwqfkaGz0BHVqQ+jN3Vl8g0UMzeTPeynwK3MH1w+mJPz4+ScV/0maXccbB1rOnPC0l15aYbz9DyYUefKvjk+OJWZ1vHcnLvOepKlsr1qlDvuaybKlT3T8eABB99jhaDIsRGUcz5LHnnL182ysVI0PefRSBEWAeXjtAXWIVPKG4uAP2SiQqDnpqzTTweYFxkyUxoQHvUibTbIXF/sSfTmqV2jfpgNQvoDYrXUhgX2k/2yD7ZY8LYU/DbOqYEvXpThd0eB4KlqXsiyznfWegmCbM2ehzEo73vp2DmzC1X2JFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(36756003)(4326008)(2906002)(54906003)(110136005)(70586007)(70206006)(8676002)(6666004)(7696005)(8936002)(5660300002)(508600001)(44832011)(47076005)(356005)(83380400001)(81166007)(2616005)(186003)(426003)(1076003)(16526019)(26005)(336012)(36860700001)(40460700003)(82310400004)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:03:56.7604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e7f0e9-94f2-4699-be46-08da05780b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1615
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
changes from v2->v3:
 * no changes
changes from v1->v2:
 * New patch
 drivers/acpi/x86/s2idle.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 646faa117c70..2a15e61406a3 100644
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

