Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899424D7A09
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiCNFFX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 01:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiCNFFL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 01:05:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36831FCF9;
        Sun, 13 Mar 2022 22:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGjmufnPVbQH0VIyFbKCrWnA0E8e5oAbD/GZTywbmT9AAYfzPjblyBTZ+qOi48wBHBBlrcjGjE//CKBUuuWnh1/NGd8jV15p3UeZqopkXl1mefSVtw9oxy/vHKY1wbSTf5XOG5JZdAB+T3S2cEMokJfLf7RZZfEaweR348DjxhAyJ97IQ30l+HVVlHR0uOe2BNwBOIKiIhu0d+VVbErhUzse6yKCeTEr3cWOsR/y2V+BJB/mNoRbCFufNjS1Zv5QbS1WJvUEueJ+1i0GSPw8jn4fZwI/nRXEZqORTcaYJI9jZsf97NDQWFs4l/5AgvTKKJCSdWaezdxCw+SntmVDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0PmCxo5s1WmeS6fNhQqbGqYI4krHJuKe8IKZYdY3lw=;
 b=RjrXCjMdg9nFvgA+A8//V1I6I8HUn4LKDQ2Y9UC2e5xflchImriOe+NLp0QblnL6v4pwBHwyiShz3dh5G7ju/V0DviWfhMBMPcQAkMdPmhWTbjvGIEF+ScnHst6gqcN7dc9jxiF+8Va7+xOonHU5tNIBzMYuhYHVm8s5W1+40uSJyayc4QgSuuy5o7oPKYYT+IFrmggbKJFdzbITZB+TtVIN69OoH358wCslyyT+yVNzjY8SS5XnVaT46o9DgewlutttkE4e/vqCQlWPKcC1u2+aFjCjNJLoi2UI+Ao7OeugwlI+BkK9EeEhQf/r2VwTydFDlYi0gajrLy27iH8DfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0PmCxo5s1WmeS6fNhQqbGqYI4krHJuKe8IKZYdY3lw=;
 b=AsIvsfXvSAi7gjIwdg4zH9Aan5xCVPXUggWlprPxwoEwFotdO9XpjKr/d5Yazd/Fp7vuNj/ZnobJg4Vny9uRPxsQky9kL+OzCERXkkY2VLE62NGyvZs5DlysHECE8kjA0IK3mKjOgD44qrigZFl7nV2Ii7V1Ga5AK2rQ9FrwOwM=
Received: from DM5PR18CA0087.namprd18.prod.outlook.com (2603:10b6:3:3::25) by
 BL0PR12MB4674.namprd12.prod.outlook.com (2603:10b6:207:38::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.24; Mon, 14 Mar 2022 05:03:55 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::cc) by DM5PR18CA0087.outlook.office365.com
 (2603:10b6:3:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Mon, 14 Mar 2022 05:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 05:03:55 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 00:03:54 -0500
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
Subject: [PATCH v3 2/5] ACPI / x86: Pass the constraints checking result to LPS0 callback
Date:   Mon, 14 Mar 2022 00:03:36 -0500
Message-ID: <20220314050340.1176-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28a601a3-dbff-4746-a354-08da05780a53
X-MS-TrafficTypeDiagnostic: BL0PR12MB4674:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46745D749E3F1C6D3D5FCFBAE20F9@BL0PR12MB4674.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAncFr9DM4umKGkl8dfbqrziYe78s0oCco9rWWpjeOe8+La+NHE0UcQIS0cfUqqj5hFDLBYTw3pqUg3zZggr+LvpoaOBU5ZT2hxBoq65AuM2OLDR4q3sslYPf/eVrKzfwa047zIC/1TaoV8k7ZmXhfA4TwU1uEVmRrSrMI4c1NY7PtrS6CgHbkgpHRxBhktieWzgSuYtOcQR6KXQeZ6zDqMrUQTTXQyxAWlCp7ol1X4gyJXuFafI/E+vCTl8dZZNzNQA0r/0/KVY8ihfxeW+Ow6zFSh4plm+li3GBjK8Vdw7ohAJlKu0Kq8qz1dWLbgbS/gq2HdY382Z96qc2sh2nyqru0MrWGL3I5XSDbdzDBrpwnngYhRNY5asSenwai2SXr7jSDQsLAvKx085HgQ/haSzgfzBgJRUSEBz91hn3jp7eFydOnIAAYXyOXkEKicWMDa9embcb4KaDKkdZRVj695S+s9r444ettirMF5iiVYsrNtuQKDKI/1N+PcQok2zp8hPI7UgSkUSfmEChyHf/RjpCFqPBteznybkNaWaDbrYsRZ3g4HkviZ3f4aKdWfnhO9OAahig1cXN4gGYo2ae5c4AV5umnUP17zCruni0OWwWVq7WuzBKJqRlzDw+XpVV9AWlQh9w2xW8AviAvyJ+zjBGX7fcwg7ihSTmBTAExtB+lRupu9kGYQ+ARZXk1AFiOgTRWKuuU0aClVZcZsQUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(336012)(36860700001)(4326008)(16526019)(70586007)(70206006)(54906003)(110136005)(47076005)(8676002)(2906002)(316002)(82310400004)(86362001)(83380400001)(44832011)(6666004)(186003)(508600001)(5660300002)(356005)(36756003)(8936002)(81166007)(2616005)(1076003)(26005)(7696005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:03:55.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a601a3-dbff-4746-a354-08da05780a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4674
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
Changes from v2->v3:
 * rebase on top of changes in first patch
Changes from v1->v2:
 * rebase on top of changes in first patch

 drivers/acpi/x86/s2idle.c | 11 +++++++----
 include/linux/acpi.h      |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 69008c4a86ea..646faa117c70 100644
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
@@ -484,7 +487,7 @@ int acpi_s2idle_prepare_late(void)
 	mutex_lock(&lps0_callback_handler_mutex);
 	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
 		if (handler->prepare_late_callback) {
-			rc = handler->prepare_late_callback(handler->context);
+			rc = handler->prepare_late_callback(handler->context, constraints_met);
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

