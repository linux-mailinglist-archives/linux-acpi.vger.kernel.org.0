Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365AE4D5208
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 20:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiCJTSf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 14:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiCJTSe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 14:18:34 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27552BA;
        Thu, 10 Mar 2022 11:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEuf4mSyHN8/HZ+qU8MjN9C1QqNee/4CDhsjhr2K2XYDDx+K1vSrWXI/c3L9JGEBVdIinkTw3XmGw76I3D6mdjL7bJPrandBpaN0o+j9vBYrUAlRsSGFPRMhGlkfXEVuwJ125GhLsreEhrbAR3vWR5T70WDiaO8pM2QH20W5qqfunDVsnJlKNp3/YNx92k1XDXRfNiTA+WeHMN1D2pKaLO3b/X2P3CPNQr6UDUfRTPTc9xoIsxH3weIdokW2L3D9pA0hJ8mepWydeqPDJESOMIXG6EIZ0JdxEWtJpuO0b5RqX0oU+k4trS6xpii76tKRj9p1hsMMRMRlCvQFHfMoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jRRPkonHidepZmgfkaTFkoBgoAmRLDfAZgQBeG0+J8=;
 b=T3zL5Bmzm0/UkvdpoSXOjC8eH5uzi/XAAa+M6wSlvxA3wmt4vgzZKpnjC4C+7zMoUnCgAmjG1rg3RGgyViB4FCF6/hq3Xv18+j3yWylt0YQcble5OgLLJ/TDNVl6IPakVBBBBP6TM32aVVeqf3piEI2cY8kd5d+FbxNzPdvM3l2tLoXbN8IweHB5k/395F1aoGJH1pwoJ+NbLl1FTmiubBUmzRmiO/FkewN0AbdZhDsA5CHC1pNH2/z+PZ6PmVzZDCeeSNAga9H+12s6eagweA8HfTTHrAuIl6+CJjQr2i+ILet26cbqM1pII7IGZepQpJ1GBCtCAYJ11OxYMCiOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jRRPkonHidepZmgfkaTFkoBgoAmRLDfAZgQBeG0+J8=;
 b=RtHLA5ytRZ1W+sDJfHV9Yo1FRkpBTuXaoN95Pf6eSE8ZeUftDLBo+GpnE5Yd4ylG8fwpGn4Brey6ubi7ERjdpa5Uyx3vpfksm846cyGaYHBWjzl4KCDuDCRufOecMEa0tlifU7uj1bj1urVTjQMzFMh88j5JEFKSuqxzjVG97zo=
Received: from MWHPR14CA0046.namprd14.prod.outlook.com (2603:10b6:300:12b::32)
 by MWHPR1201MB0013.namprd12.prod.outlook.com (2603:10b6:300:e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 19:17:26 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::2b) by MWHPR14CA0046.outlook.office365.com
 (2603:10b6:300:12b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 19:17:26 +0000
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/5] ACPI / x86: Pass the constraints checking result to LPS0 callback
Date:   Thu, 10 Mar 2022 13:17:21 -0600
Message-ID: <20220310191724.1440-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1942461-0e63-4a08-2a07-08da02ca9cbb
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0013:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00133AB6D257FE7134C6B2BDE20B9@MWHPR1201MB0013.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrT3MlZ4p3t+yUA/bpY6E0b8Pxq7BvRqkXbRcomLg6NqDwtJw7p9MUO7r1xrLgLqiqQG19hwd4C6VrLdrL/EvNdASyJGFOhbXIlEmbIl8T6dByS8ec5KLTszLNuEX7iT9wo7JljhaM7EDtgy+a5e2IDM5tB+G2teS7V0COK9BenjsOPXF1ogCZ0l6rk+9R6nidcGkU0ixcHC+LLr5ukc4sqaoKswBu1Q0XURKRqGmvSnNK+w7KzYzOyN6n2SEt84yA1v9dscsQOk1Ra+1Q83WjuGQGfkA4GfqIrvmNctOm0mRAAu2u9daO+yLWhCc81+tQnPrKLcXn12NxF7fIZlaYzsGIFeRr3Vc5YgdRWjS82n4sAGn5M/9FzRltCRbhu5f8k/DXZXe13QcPg7nq2TgsLCirBtITuT5fmJ+HWTLFzkkuqIbIhQNZuF0gtwD9XxNXUtkHVnSIuquR9uDaFFurUBLF5zvupp+5Dr77uRBPpJicdddtgqmLqXVbp5nVfcvFDyqICZHzuk3R9nTvnKyEmgZ2gg5jX4e/XiKwtFbWD0HIVzoiTCCG0gE4cN+owXb4mWJkuQTYLM1tHJue/KN6wqiPM1zhhVoMxxxTTtNbFrSuEdUSiattOxXYc7XgcI1Tt17scz2Tw57dD7Cr2Qvh9iecEoNQZ06QAphjg/KhJQelBQezMhXx/7XYKsT3Sy0dwTnekkiqUy/+lq81Sc6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(44832011)(7696005)(81166007)(86362001)(83380400001)(8936002)(54906003)(508600001)(356005)(8676002)(82310400004)(5660300002)(70586007)(4326008)(70206006)(2906002)(1076003)(40460700003)(16526019)(426003)(336012)(6666004)(2616005)(186003)(316002)(26005)(36756003)(110136005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:17:26.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1942461-0e63-4a08-2a07-08da02ca9cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If constraints checking has been enabled by the LPS0 code, it may
also be useful for drivers using the callback to make a decision what
to do.

For example this may in the future allow a failing constraints check
preventing another driver from notifying firmware that all required
devices have entered the deepest state.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v1->v2:
 * rebase on top of changes in first patch

 drivers/acpi/x86/s2idle.c | 11 +++++++----
 include/linux/acpi.h      |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 7418443580d4..808018bbab90 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -290,7 +290,7 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
-static void lpi_check_constraints(void)
+static void lpi_check_constraints(bool *met)
 {
 	int i;
 
@@ -312,11 +312,13 @@ static void lpi_check_constraints(void)
 			continue;
 		}
 
-		if (adev->power.state < lpi_constraints_table[i].min_dstate)
+		if (adev->power.state < lpi_constraints_table[i].min_dstate) {
 			acpi_handle_info(handle,
 				"LPI: Constraint not met; min power state:%s current power state:%s\n",
 				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
 				acpi_power_state_string(adev->power.state));
+			*met = false;
+		}
 	}
 }
 
@@ -448,13 +450,14 @@ static struct acpi_scan_handler lps0_handler = {
 int acpi_s2idle_prepare_late(void)
 {
 	struct lps0_callback_handler *handler;
+	bool constraints_met = true;
 	int rc = 0;
 
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
 	if (pm_debug_messages_on)
-		lpi_check_constraints();
+		lpi_check_constraints(&constraints_met);
 
 	/* Screen off */
 	if (lps0_dsm_func_mask > 0)
@@ -483,7 +486,7 @@ int acpi_s2idle_prepare_late(void)
 
 	mutex_lock(&lps0_callback_handler_mutex);
 	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
-		rc = handler->prepare_late_callback(handler->context);
+		rc = handler->prepare_late_callback(handler->context, constraints_met);
 		if (rc)
 			goto out;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index df105f5e03e5..4906db854554 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1026,7 +1026,7 @@ acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 #ifdef CONFIG_X86
 struct lps0_callback_handler {
 	struct list_head list_node;
-	int (*prepare_late_callback)(void *context);
+	int (*prepare_late_callback)(void *context, bool constraints);
 	void (*restore_early_callback)(void *context);
 	void *context;
 };
-- 
2.34.1

