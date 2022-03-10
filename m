Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29E4D4CFD
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 16:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiCJPWS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 10:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiCJPWJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 10:22:09 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265921301AE;
        Thu, 10 Mar 2022 07:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPf6ZDqlJgVBUy3LCK5NgohJDdrKYdCQ6URR5JBYjJc8BjMx0Tq3b6HlyhAqPdGxrWzoVjQcW25dAvQgU0P+PGguLeFyKHix4gmKJcXeGQPGMg0WryEcFI4KbEyxneNRPtA68DKRq5G0Z4iyMGrMwvaHnMhQpNZ5ohcAzOkBe9twJ2qg8mTCug0MKlm7UCB6lRGUwejHUegtsEYQs33zyZVyQUDIOAWb0Yn/WhS4EYs9t6hixXZ2qszbpSeqCzQT/ECLqKp21f4J+vdpfYrdf0eJTGk1ROJwXTjRfrdZ0s8BBbe0hK3T+mwtQePrMPgYs838Mep/7r9WrXEBV5ahhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC67LfcbIuMORF6/jtsq5rbnDdCdck1fGDZ+Tyc1E+k=;
 b=FvA+2Tuh2olbRPfE4fWMuI+UT0nTta0jq/DU99Q7Cdo5BC6fBeBy2QO8UPWS0EQUSARh/NIfjDSKXHWocEqdOFn1U0y/Zp3U1qY896jAf2Ih3fkURecvLmKpE23U/zgCz134+yssUypu985yhpz9DWk9qquQEnZAJjlxF/si7cz7yxSnjDL3OMRbbM6ySQQwHYdzJ5XEvDAu30m4SjXtQA+CYm93PTMvj1hESB1GPnn3Zh2bgnN25mUVU2XKaUPijUYKPN1vrsVv3De9ih5IJuWzhgsD++h6/aUj/WQcVjdj9AHtec5aPlczVnisHXTetgSE9kC1O7xzdBtklvrxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC67LfcbIuMORF6/jtsq5rbnDdCdck1fGDZ+Tyc1E+k=;
 b=0l+GTyGXjLjN7B2Z3ajyYxMzwjxQCnfcWWV31yRxoJEwn9dwvG9aJlMEqvTBopN6Dy5G/ovJtS9Nh1upCujZUeCtqvBXkRx1XZ2tGZYtzJlUT4JGJa4Le3WXXdFFoLocgM8md4hfAZy3ESPIjM2JMv3g0crVHmzZcVjh1XB+T1g=
Received: from DM5PR06CA0084.namprd06.prod.outlook.com (2603:10b6:3:4::22) by
 MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 15:21:03 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::23) by DM5PR06CA0084.outlook.office365.com
 (2603:10b6:3:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Thu, 10 Mar 2022 15:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 15:21:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 09:21:01 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/4] ACPI / x86: Add support for LPS0 callback handler
Date:   Thu, 10 Mar 2022 09:17:02 -0600
Message-ID: <20220310151705.577442-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0379178e-664c-4e8f-0669-08da02a996bb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4502C745F8CB9C1ED92D294BE20B9@MN2PR12MB4502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: um+5Y/yWvyqRicx9k1rX+0iAZSm2XAu2BY0F0efEPGuj1TpRKUbktdn3+UWRLcD3sTdIZcjvgz/49pfFGt6r6GPecokJbJTw6eQfBMV7ojsguqHOPI4TFL2yKNNxh+vghCGPHOeZb+H7CjPr4WTmC79nUpwwmn+/mpB2/VZXmNt3RuDDg5zg0xQlsWlpzKrZvjI53RWuHi7VNp2OaiPshEcmNIw8qUBr9ILrKsYsuhlNx+FCImq7UDn/aG06QGIF0QBZ1MB3AaVGycdbcEVWXgLLpByCbD/qIR/C8rqmXCPF/MqpnZIEN+K1qvBaBIEDfSZjsYDEKx3Ngaw7EobwQAG0jCXLpi3YeDGgssfYqkLUkj0+cQWA+QVRFR/tHQsk9ju17ikHg+I+KFFYPps8ohBz6BFiZPLuVZlDfwI6hgmDzFxe50wPicg+6vPqBChskR4RM+SQ6u1ojt+gZmZsxTizVt6r2Gx8grQ5OJeBwS4UklQz1rCRhc/FIb+DlSRB7gptRp2zQj6eN5eSqEynL5q/FeuYeKZpKX0A+lJuzrbn+IAKAqSnd0U2sJp60Y3gPOX16hK95+CnHQSyJqeNQlShhe6uDNEDI/giNl7OuQqRH6lvgmbxoiM3EJVGJ5+WpjaOJWvJSpPuddEfarYoXdYvkEFIC2c3uo6APIEN34B///8G+hJV+B84D2EGwhRK0nTT48B7QCPpIJUxWZIKyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(81166007)(83380400001)(356005)(36860700001)(40460700003)(36756003)(82310400004)(8676002)(4326008)(86362001)(54906003)(110136005)(70206006)(70586007)(316002)(44832011)(8936002)(5660300002)(16526019)(1076003)(26005)(426003)(2616005)(186003)(336012)(2906002)(45080400002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:21:02.6976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0379178e-664c-4e8f-0669-08da02a996bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currenty the latest thing run during a suspend to idle attempt is
the LPS0 `prepare_late` callback and the earliest thing is the
`resume_early` callback.

There is a desire for the `amd-pmc` driver to suspend later in the
suspend process (ideally the very last thing), so create a callback
that it or any other driver can hook into to do this.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 76 ++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h      |  9 ++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index abc06e7f89d8..652dc2d75458 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -86,6 +86,16 @@ struct lpi_device_constraint_amd {
 	int min_dstate;
 };
 
+struct lps0_callback_handler {
+	struct list_head list_node;
+	int (*prepare_late_callback)(void *context);
+	void (*restore_early_callback)(void *context);
+	void *context;
+};
+
+static LIST_HEAD(lps0_callback_handler_head);
+static DEFINE_MUTEX(lps0_callback_handler_mutex);
+
 static struct lpi_constraints *lpi_constraints_table;
 static int lpi_constraints_table_size;
 static int rev_id;
@@ -444,6 +454,9 @@ static struct acpi_scan_handler lps0_handler = {
 
 int acpi_s2idle_prepare_late(void)
 {
+	struct lps0_callback_handler *handler;
+	int rc = 0;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
@@ -474,14 +487,31 @@ int acpi_s2idle_prepare_late(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
-	return 0;
+
+	mutex_lock(&lps0_callback_handler_mutex);
+	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
+		rc = handler->prepare_late_callback(handler->context);
+		if (rc)
+			goto out;
+	}
+out:
+	mutex_unlock(&lps0_callback_handler_mutex);
+
+	return rc;
 }
 
 void acpi_s2idle_restore_early(void)
 {
+	struct lps0_callback_handler *handler;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return;
 
+	mutex_lock(&lps0_callback_handler_mutex);
+	list_for_each_entry(handler, &lps0_callback_handler_head, list_node)
+		handler->restore_early_callback(handler->context);
+	mutex_unlock(&lps0_callback_handler_mutex);
+
 	/* Modern standby exit */
 	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
@@ -524,4 +554,48 @@ void acpi_s2idle_setup(void)
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
 
+int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
+				 void (*restore_early)(void *context),
+				 void *context)
+{
+	struct lps0_callback_handler *handler;
+
+	if (!lps0_device_handle || sleep_no_lps0)
+		return -ENODEV;
+
+	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return -ENOMEM;
+	handler->prepare_late_callback = prepare_late;
+	handler->restore_early_callback = restore_early;
+	handler->context = context;
+
+	mutex_lock(&lps0_callback_handler_mutex);
+	list_add(&handler->list_node, &lps0_callback_handler_head);
+	mutex_unlock(&lps0_callback_handler_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
+
+void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
+				    void (*restore_early)(void *context),
+				    void *context)
+{
+	struct lps0_callback_handler *handler;
+
+	mutex_lock(&lps0_callback_handler_mutex);
+	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
+		if (handler->prepare_late_callback == prepare_late &&
+		    handler->restore_early_callback == restore_early &&
+		    handler->context == context) {
+			list_del(&handler->list_node);
+			kfree(handler);
+			break;
+		}
+	}
+	mutex_unlock(&lps0_callback_handler_mutex);
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_lps0_callbacks);
+
 #endif /* CONFIG_SUSPEND */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..cae0fde309f2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1023,7 +1023,14 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-
+#ifdef CONFIG_X86
+int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
+				 void (*restore_early)(void *context),
+				 void *context);
+void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
+				    void (*restore_early)(void *context),
+				    void *context);
+#endif /* CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.34.1

