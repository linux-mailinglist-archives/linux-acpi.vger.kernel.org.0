Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6432D4D7A06
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 06:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiCNFFK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 01:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbiCNFFI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 01:05:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9094192BE;
        Sun, 13 Mar 2022 22:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqIE+xicd8NV7uCvernlFiaaxV4cHk9F0+Tp9lRhhyh19dOf++wkqf1yId1kZiw0+/bf7+VgLGp6EyLA7nzkgIRjqI0nzpi6Khs/USxcCLygCY4BaxompSxBfOIt4zkWC7Y6LvUyJs+sg7y644VyO5o6meeF+E7J4IMBo0U505ipJIv6Pdt9ZMG3jDyMQm2Hhq7OChlh/84UoqZA2mMv6YZOFBg4Ii02FQ8sbdPWlE96/eJ/oiA5qAj0JlLmjfQHcUbggwfymPdMYToHFBQt6ks3roTwG66WTAg1FfHK/Xel8hB7XVwTx0I9s5i0awrFJkGXFTn5vkYLdLTfrlWVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keGXAkxIhkzNmyhoEHRQISMmI4hpLQ04cLXIxEoTJ8M=;
 b=b9ZsnVx139w5oz90BctCl/Xsoh5t0hFOUFRuGFJ5WLOF09z1rE9ERZ7g2W9SQtG9k9E+SbXT0OX9/YdbTj8eSA9eOBjtGnK58O5vPwrevI1OQFEw1BobA94EbwzXqYhtynH93vlpeFt8rvZKRSELPiNbApBx/KupsVEA2gGoUKaHv0AHglmmqZyrRPC3eK4fkXab7UVEUA0Uqy0Cmf4jdo2cmBnYSVaWRjpNDsv0vDVdJzUEo+lgh/WzalgOxsriSaW0OynaGTr6X4F9eYyVloZ7aH2+o4CSforZu7k1L80pE2XD47yWT/AtH0SBHzPDGbatxHQH4oYEO1W+PbNUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keGXAkxIhkzNmyhoEHRQISMmI4hpLQ04cLXIxEoTJ8M=;
 b=zz7TpWSW6L8iex3XQ7QP1mKEWsExVuR8CLogU+s+7CaKaNH8jjry+2CnYkr8Qn97C1LvnW7C0ToCdSvl8Spj+irBjgVylVlu1YSvS8qVP21bUWNtI0bTJe2OGyBMOnzAFk2f6QDuIqALH55c86pGyoxUsTGDLuksy51C7bwt1+A=
Received: from DM5PR18CA0074.namprd18.prod.outlook.com (2603:10b6:3:3::12) by
 DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Mon, 14 Mar 2022 05:03:55 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::a5) by DM5PR18CA0074.outlook.office365.com
 (2603:10b6:3:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Mon, 14 Mar 2022 05:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 05:03:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 00:03:52 -0500
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
Subject: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Date:   Mon, 14 Mar 2022 00:03:35 -0500
Message-ID: <20220314050340.1176-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4084c863-811f-4987-224a-08da057809ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4864:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48640E112D3DFB3F0108A518E20F9@DM6PR12MB4864.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8HesGZe7+eMWEiYWuBrKlAk5KWIRlc8m6cQXMYSyJhE/WH/8a3BAEIJFSJS8mOguRbpHCmXxUQlSXKgCaWeon/I6gxMFhqYA4JdjLyJQjLGNGiSVJ9YGr2Ioz/cPpNtBxQf1aTZH0aTS+9fuCloR9rHE0kBOpCXKTNAYwsVNqbAY6i5cnYGZru/GncfmguemNFZHwGYz50RVOGXFgutLbMBCK/UMP0/mQ1K/oPCwLjPvtAeA8CpOfT2REOtpzatSl2G6x/RnkMN7fyUb4QrbDhfCidh1fOMAY4nkjUyLHIDStOW/T81gvH+KoTW/xgIT+JzdVfYoIYnR/PQnDQMmOWKWPWcGqZBNsgx5z7FpNlfFPo76Qwtk+OqoEy/8j+8d00EGvLn+Ei1uqVtZP+Fs+9Rtlg2praJAuM/z+A4FWKZ4EfVkg2S60HthWt9kRSbMn6kNrSVzvJtmdCuOFC+lreZzykir7M7srR7BNRHeXLymwS8y+uiGbyoimEwohK61AnKNiETY/F5CwWGtv6IYt+CNZQrcFalgAWO9AP6WotwMMQvj6homkFuFxE4dpa1bg5q++LgA6uj3jo8E3ATNxekUKP3Ntzt7SYkbopt8CVNe2huhvp7Xpx0uqG8ZF3Y1jAfkDyLfn9gdc1rjV2F39+GQS3+bhv/qPYU8B4VU7CKO5Qsn+Y3JKYCZbLofX+tH55eJ1PLC0coR/DVny0BTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(8936002)(6666004)(356005)(45080400002)(1076003)(70206006)(70586007)(508600001)(7696005)(16526019)(26005)(5660300002)(81166007)(186003)(44832011)(426003)(110136005)(54906003)(36756003)(336012)(82310400004)(2906002)(83380400001)(316002)(40460700003)(8676002)(47076005)(4326008)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:03:54.3971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4084c863-811f-4987-224a-08da057809ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
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
changes from v2->v3:
 * Check that callbacks exist before calling
changes from v1->v2:
 * Change register/unregister arguments to be struct

 drivers/acpi/x86/s2idle.c | 68 ++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h      | 11 ++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index abc06e7f89d8..69008c4a86ea 100644
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
 
@@ -474,14 +480,34 @@ int acpi_s2idle_prepare_late(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
-	return 0;
+
+	mutex_lock(&lps0_callback_handler_mutex);
+	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
+		if (handler->prepare_late_callback) {
+			rc = handler->prepare_late_callback(handler->context);
+			if (rc)
+				goto out;
+		}
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
+		if (handler->restore_early_callback)
+			handler->restore_early_callback(handler->context);
+	mutex_unlock(&lps0_callback_handler_mutex);
+
 	/* Modern standby exit */
 	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
@@ -524,4 +550,44 @@ void acpi_s2idle_setup(void)
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

