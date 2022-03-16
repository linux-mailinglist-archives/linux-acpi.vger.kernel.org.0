Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A394DBA16
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 22:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349245AbiCPVap (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 17:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353348AbiCPVao (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 17:30:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16851DF48;
        Wed, 16 Mar 2022 14:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chz8nECzZA7vcmVqvPOTVpmMCa+RoFvvyf864dGXbUJ3kJbyo/PXFp3xpX71Pk1va6FNEUFA8e5oeUlaFWEpvkbLPsjncpJSQ2/kv/L4xKt4ljdRW7me1xTb1z3Yhp5RHpqeG1t0YhBaRxLneHbnXanJYPIlx3eS2CfXewxK4HAUwCS3Uww0EHnOorZMonvss2oIuIDU6WLmPlIEliVHR0SQrFQNLkMSx1+lVWpZw9Y6ZLZobfpPoc6OiluTu8ZcjFcMTOx5iOivU8j8zdPQJedeAJYfbmePeQxww9PN6wKkfOLbyHQ2hblVUtv4a9rdeAdSJVm0O8vuQQW8nBABfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQHgj2XIH3AS3K15Zfd9j+g3jFbR+XyJyRd3uJRrA4U=;
 b=FZGH2z/yaDxBdyLbBzSDz3PlRRD+3wleUec3x0pLPqZf35tEVEVPLENX5LXtCfmNE90pVj/LFQr4Q86nObEE0MJ2dSP9zMPpMKmNVMp6wROxTboGn8MXwh3VZUCCSub3bO040iqZoQylZjvM37Vm353IKrm+q/DAd5phL0pO6+fzyd+OPtaGYPi7qdvqkKWPGrKSLHWa1FtKaf4KobllXCyMuARJUkw2TOjwZjRrm8TvfURm7VNb3G8hAIR95darVBYclMBgMSF+1+aoQnZP9p6GyVHNC+QPm9FNrdQ1DDnmfnuzQ83EhSoaoNsxLtaQLHgJmIhGgeWclnC2DwX4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQHgj2XIH3AS3K15Zfd9j+g3jFbR+XyJyRd3uJRrA4U=;
 b=PWxPgODPQmzyt9q0zbCB/Dr9P8PRHBWNcAIbkxnDmy6tC9+2yHtocLwjPqBpFO5Bc8CTT4R96aN96U11U2P+eE19Wau8RC6CMppTkHDEeo7CBUTcHRXWKHP1PyNu1gHb+qQpxEjNJGgqOkWmrTP+khTkHbRaAvteNYjjinp1nsk=
Received: from MW4PR04CA0134.namprd04.prod.outlook.com (2603:10b6:303:84::19)
 by MWHPR1201MB0159.namprd12.prod.outlook.com (2603:10b6:301:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 21:29:27 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::59) by MW4PR04CA0134.outlook.office365.com
 (2603:10b6:303:84::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Wed, 16 Mar 2022 21:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 21:29:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 16:29:24 -0500
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
Subject: [PATCH v4 1/3] ACPI / x86: Add support for LPS0 callback handler
Date:   Wed, 16 Mar 2022 16:29:22 -0500
Message-ID: <20220316212924.5619-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6106d8f-fc6e-4410-b065-08da07940c70
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0159:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01594E13768CA38421E3C68BE2119@MWHPR1201MB0159.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bp818+/TQ0eCJXfd9uYbJTenAtoyuMPzqWTbPhXAaA8h4PuKFDlnn6vtTM6LvLBf6e3SV6Jevpa44Kf4HSFGp6CPbcDP7i4HmmZCl1IR2/hTnciH4jRf4tuFVHzQydWgpdpAWYpKL+X/RO3pPZMBtM9r/OsFF0eSyGDefwmZZQOnezRXh6nRRO5NsgAA0QWAWRrCdvaaG4vPw3bP75qr+wgFSwRWsoWwkIfZXydU0WsSoIpmndrqcYZ81b4nsta3SBhd2IeT1B8xEGkES47FG5kKjvE7Ik+e9PM7rTC4WkqkAWX1TYHKcArRGgsiAFshHYGf8s7YPEvNWdwm+0Xp8clH8NEkqcNPZ2EKP/l7bMv/S91UWkYlEFkv0zmQU15KyOtPRGk7/VdfThodUcT1BuA8bpFljqI3NL8V6pfGulRNN1n4u0wvU40m8zV2E8N8g1pC8g0wCqPXzui2Dg/QnyF3vVhc3gcKjEAlmTFsBKArJy7JYbpXi+IfW+wnT+ms/AaKQUaV7AK7sJs1tNYQj925Dygc9BY8m6DkRwFABe0Dmcs8rZQ5ai/xL+ZcojWoAH9YqR6kPqpwf8ZFokrbRK7mrvBLNpIhRLsH1iWK63upsWaP5kYMqKndSJmkj3RhLW3cDvHtBHiFFzjRI52sSddhJU/F+jJJalNo5REPPIqGWWZzWxRftkhjqnXuX35HrG7tXJamoF0ovj9+mY3oBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(110136005)(316002)(70586007)(36756003)(508600001)(82310400004)(45080400002)(70206006)(36860700001)(8936002)(44832011)(5660300002)(2906002)(40460700003)(8676002)(4326008)(356005)(81166007)(2616005)(86362001)(16526019)(47076005)(426003)(1076003)(7696005)(26005)(83380400001)(336012)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:29:26.9737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6106d8f-fc6e-4410-b065-08da07940c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0159
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
changes from v3->v4:
 * drop use of mutex, use lock_system_sleep instead
 * don't pass argument of context, driver will maintain this internally
 * don't allow failing prepare stage
 * don't allow unregistering if sleep_no_lps0 is set
changes from v2->v3:
 * Check that callbacks exist before calling
changes from v1->v2:
 * Change register/unregister arguments to be struct

 drivers/acpi/x86/s2idle.c | 40 +++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h      | 10 +++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index abc06e7f89d8..8cd9a1016368 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -86,6 +86,8 @@ struct lpi_device_constraint_amd {
 	int min_dstate;
 };
 
+static LIST_HEAD(lps0_s2idle_devops_head);
+
 static struct lpi_constraints *lpi_constraints_table;
 static int lpi_constraints_table_size;
 static int rev_id;
@@ -444,6 +446,8 @@ static struct acpi_scan_handler lps0_handler = {
 
 int acpi_s2idle_prepare_late(void)
 {
+	struct acpi_s2idle_dev_ops *handler;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
@@ -474,14 +478,26 @@ int acpi_s2idle_prepare_late(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
+
+	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
+		if (handler)
+			handler->prepare();
+	}
+
 	return 0;
 }
 
 void acpi_s2idle_restore_early(void)
 {
+	struct acpi_s2idle_dev_ops *handler;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return;
 
+	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node)
+		if (handler->restore)
+			handler->restore();
+
 	/* Modern standby exit */
 	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
@@ -524,4 +540,28 @@ void acpi_s2idle_setup(void)
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
 
+int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		return -ENODEV;
+
+	lock_system_sleep();
+	list_add(&arg->list_node, &lps0_s2idle_devops_head);
+	unlock_system_sleep();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_register_lps0_dev);
+
+void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		return;
+
+	lock_system_sleep();
+	list_del(&arg->list_node);
+	unlock_system_sleep();
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
+
 #endif /* CONFIG_SUSPEND */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..47c16cdc8e0e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1023,7 +1023,15 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-
+#ifdef CONFIG_X86
+struct acpi_s2idle_dev_ops {
+	struct list_head list_node;
+	void (*prepare)(void);
+	void (*restore)(void);
+};
+int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
+void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
+#endif /* CONFIG_X86 */
 #ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.34.1

