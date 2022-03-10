Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1004F4D51B8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 20:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbiCJTSi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 14:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343501AbiCJTSe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 14:18:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A6391;
        Thu, 10 Mar 2022 11:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu7+rsRgyVwj8BeK2mTD40ZuQ/TLcMlVaj0ZajsD86cjuU206WrmKGe6Rq64uKDKISwpSmcf1fbrsOl1f4G7BYmgqiYH2N/knpONfvT9kXrptqFa/XzdxszVXrb/LyyFTxDFtedld3WBX9fQ/JODn2C9s/MF5JCDT9NEehbAqeGW9ktJSpd0c1LpetAlXc4eoHT7fdPKPS6Sayd3iJ7jt0uVoT4ewMesUef4JG+klATxfFQsSZgkTQWBQC3wEEZgpbQwg6uTLiS5fFvTH8ifrqG97H/xQOH8jhqg5RxqYklsR0SiSZURT/Bb3JBmOE+cNTl/uYKZ0H5RhbgCjeioCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UVPXHj1MbkdL9mkUZ8PKoQD87dvYue0soenZ1PHc2M=;
 b=WhsS5nyvKUmzgwxuZJWPQMMo0rgLTidTmSHSsFQDuyFFVN/IIRNIBMRos3zGWG/Tf0MXRfYfrZC1O7ggeQYWBukLd26w6chb3HJGOL0I8MvFKoxZJSsgR5qeWSJpOyndShsDiEMpWJaHGlEO5O9H1Zy/tJIZbBWFUV+HD1RoSUnVvn+2IPMRKngsBfXDr0xPeDM0L6xs52cpMu2T7c+tSB9tpLZ54UnGH7p+DudgzAbWAf8chzSTK3y15K1EKKYoXnfEAK9Qbu1WuGyVKxRBEaCJihuDE6yayQalVbRDQe6dGJtRKaJ2HZH7tIOaGo8MNQEHWvWg/jrViDpKR8SavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UVPXHj1MbkdL9mkUZ8PKoQD87dvYue0soenZ1PHc2M=;
 b=m0ujLMWp044/gWitlkpeRnfWrhh+jfba+VK+Ajwmk8kfvTBKgLHjck6acC1pW1PbEqS+pxiQW+i+23xRhL2kp+lzktROHcYecscWp8npM6EvuVsQ/79W73eXwnW5UoWrg8wLRIT6wb9yiebiVxvNAX7gYDcQqS9duYgbieFZrIw=
Received: from MWHPR14CA0033.namprd14.prod.outlook.com (2603:10b6:300:12b::19)
 by MWHPR12MB1438.namprd12.prod.outlook.com (2603:10b6:300:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:17:25 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::ab) by MWHPR14CA0033.outlook.office365.com
 (2603:10b6:300:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 19:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 19:17:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 13:17:23 -0600
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
Subject: [PATCH v2 1/5] ACPI / x86: Add support for LPS0 callback handler
Date:   Thu, 10 Mar 2022 13:17:20 -0600
Message-ID: <20220310191724.1440-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e68dcb9-72cb-4613-cf76-08da02ca9c3c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1438:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14384A3330B974CE1FEDD53BE20B9@MWHPR12MB1438.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/vvkC3kssRCsSUIWtEWtZZpFfX/41bft1gZPtQyLJ654delyGmcb7TJ3zccigXAV/mYQ2ZFpqa4KWOgaW0C1yQ6i+GtfnYqVGzKV35WEUQv9i10lfb3sflEYJSpKFz3KGCasFl6G4oji9WKG/01oSgFybQ5oIwD61mV98EERLwcshugnS/srvIHVBYWiiYC9XGXcuAOv78FgomwrMt2/5qGPGGnwybxIB6f7E523ozAgz00feVDuN59zcz8TS8qMIiZ7X8Td0hQN/35MoaILPILXl2li639DoWGo8zGpWpou3sErML3anWmcVAFMKbS6eFNznMHwDwQFFr9e+/AhWcrIsxeKKtmS/CmP+p4WDHmBjpjcChrdb79/Bc5aJsh9bG9gMAQaH0Iy7rw46ipF7dnRR7ETIVGPzIZHT5OJLqDLtDvQfIja3Y6rggs1FB/yzVcDzKPqs+rCOgrf/KRGJOAReNf3YyTrUhWIHjh1HxXeCGnU0SK48u9u6iH3MGW62hfBgZLm1FV582/o8mi6O9ghIhUTP8oRb0IBOYlvr+slS7FzdTvQLuFOv1Oo/SAHNEY0iWFt2LMcsxR/UwwN3mG2ysFutuMEajWCJ8QTOXPBl+YFYsUTYqR2cfCaNcmSvOY45Vu/n0UMSbpve8nrrXEayiuTa/HV642IvAYjXr4XilQjbPCeZCRU8D68XXsPG8Z3vn3fX73Lj6ktO58hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(8676002)(4326008)(70586007)(70206006)(7696005)(356005)(81166007)(316002)(82310400004)(86362001)(508600001)(36860700001)(45080400002)(36756003)(40460700003)(110136005)(54906003)(47076005)(2906002)(44832011)(5660300002)(8936002)(16526019)(426003)(336012)(1076003)(26005)(186003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:17:25.2351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e68dcb9-72cb-4613-cf76-08da02ca9c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1438
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
changes from v1->v2:
 * Change register/unregister arguments to be struct

 drivers/acpi/x86/s2idle.c | 65 ++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h      | 11 ++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index abc06e7f89d8..7418443580d4 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -86,6 +86,9 @@ struct lpi_device_constraint_amd {
 	int min_dstate;
 };
 
+static LIST_HEAD(lps0_callback_handler_head);
+static DEFINE_MUTEX(lps0_callback_handler_mutex);
+
 static struct lpi_constraints *lpi_constraints_table;
 static int lpi_constraints_table_size;
 static int rev_id;
@@ -444,6 +447,9 @@ static struct acpi_scan_handler lps0_handler = {
 
 int acpi_s2idle_prepare_late(void)
 {
+	struct lps0_callback_handler *handler;
+	int rc = 0;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
@@ -474,14 +480,31 @@ int acpi_s2idle_prepare_late(void)
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
@@ -524,4 +547,44 @@ void acpi_s2idle_setup(void)
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
 
+int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
+{
+	struct lps0_callback_handler *handler;
+
+	if (!lps0_device_handle || sleep_no_lps0)
+		return -ENODEV;
+
+	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return -ENOMEM;
+	handler->prepare_late_callback = arg->prepare_late_callback;
+	handler->restore_early_callback = arg->restore_early_callback;
+	handler->context = arg->context;
+
+	mutex_lock(&lps0_callback_handler_mutex);
+	list_add(&handler->list_node, &lps0_callback_handler_head);
+	mutex_unlock(&lps0_callback_handler_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
+
+void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg)
+{
+	struct lps0_callback_handler *handler;
+
+	mutex_lock(&lps0_callback_handler_mutex);
+	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
+		if (handler->prepare_late_callback == arg->prepare_late_callback &&
+		    handler->restore_early_callback == arg->restore_early_callback &&
+		    handler->context == arg->context) {
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
index 6274758648e3..df105f5e03e5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1023,7 +1023,16 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-
+#ifdef CONFIG_X86
+struct lps0_callback_handler {
+	struct list_head list_node;
+	int (*prepare_late_callback)(void *context);
+	void (*restore_early_callback)(void *context);
+	void *context;
+};
+int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg);
+void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg);
+#endif /* CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.34.1

