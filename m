Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F284DC886
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 15:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiCQOQf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiCQOQd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:16:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE41FF20F;
        Thu, 17 Mar 2022 07:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bksMLw3LCyRGvXEQqIZ+jcTAsS7SeyjsTflh7BxP7j1YIZZgakbHO1Jgn/QLaVgaDdEDLF7vCgk9lg6rMzbw9OzSYUgAcXWvy70rP4JqwDH0oPNg0mu3KT5+2XfsEihuwNUJO0HADq4+IQxhfPAhdpokynVfGMhiSLqoQHU5TvvzuzZL3ECDJZFFPJ9HYcmhYOanOIZkB36QLCiIEieaCNnYVrZXvyJmHyde+55v8tYd59OkJRCtrKOssgmU8eXmnYaVze6ib1Od//NcEeYqLqXH//aPeRt6hYh9//qkV7yw8EHhpv4t0GabIbb5EuWqX4PRW3glwZfbCeB6q863QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M1gV9LyFfFREVAC03lv8Ez2TmM1MkdTR2uk/mA5ePY=;
 b=L1deEq7pnFaFoURakZU/G4h06dDu0X26TfpetxOJuDWYRm6i0G/5zDN/Bctp8JBh4UmQkqzTXiWs4aXpSiv1f1TSdLEEr2Jjn3zTYU3ElvKatnnrc7P0smgbg7DQwwpUATDzrBhXor9B7HlUH+5JbofkYVmTtLAQ8abQ34ns+uT6sNsG3nGqBdTv7aynkeAEVfkSPh1+/4Q3ZZhq5RO7LEhZIeTFuHfkGl4LytgmvOexnBbz977T//lBXWqf1rvneXGeuetW90qQiBfWIhlEfaYMFdKQ+CvBQ4XeS+XibMh4BIWWUzj6N+9QUI/0KnH4Zff30HLJPE9coi9Ms4VMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M1gV9LyFfFREVAC03lv8Ez2TmM1MkdTR2uk/mA5ePY=;
 b=2Sq1UoVP4E0QE7FxkH7yBE4k6T0dDdvnuD+u7kOALDMIhzVVkFHl8sfRTggAC+Au/03S0yMhpyFQNEU9sjJ/vMFOXkXKviTOGgSjTAU3olbbHCg5ToVeqvyZxE/t/AI4ZfuP0cbDBV+w/Wjim1Hghpw8tuNoVIR2MURHPGc/kLg=
Received: from BN8PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:d4::20)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 14:15:05 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::1a) by BN8PR04CA0046.outlook.office365.com
 (2603:10b6:408:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 17 Mar 2022 14:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 14:15:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 09:15:03 -0500
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
Subject: [PATCH v5 1/4] ACPI / x86: Add support for LPS0 callback handler
Date:   Thu, 17 Mar 2022 09:14:42 -0500
Message-ID: <20220317141445.6498-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c380edf7-26e8-4b38-1cb5-08da082088cf
X-MS-TrafficTypeDiagnostic: BY5PR12MB4856:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4856A907ED97DFED0F78C358E2129@BY5PR12MB4856.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M94LIrEtwXTuQ0pahOEVN897a9dZ+rvo4V9ea/mR/2i7wUpi8Rf2J1NWbBgO24MG9EFJaaubn8hZcG7Chh8+94oASnMqG/d1hgWOn13lwgToKYJ8Yr5ec/dv3i3nbpFLsqtdvntsLqQQpyLni0SyYZjvhONEiPiMdMW2t5eio/IBKfPv0rdAMWPswRuU5Qipxe25rgTmQsM0cq2KVMsABMr9a7InyY+fPpE+LXEzD3V/Bimu0vyBejimllr+wpLbqM0cv7xIH8v4v9jeAnbYCxUMWEDeySKomwYp4hZaDZlp+7pXSabDFbi6NmPr0MsZbyfSBVVMqNQmMymMBEZG2I9tErhxW+w5QBRAW/sN4+7iUYHwfwG+wdC/IWtPgKR8tMn7V1WOcadjEplMGhpMGcH4197facv9/eAeFgnZ61OE/I1JRCxbYOpazRS65p8MKxeaQc0zWTodkI8VHMNGRMpNuZ65Ee/lm/yTwf5yuFKtqL+uK1+U4Nc1MO1I2+KZN6PZTs3+Uy1xR7z5uI8LSriFRluc3XNL40Opq+xq781VAx0GT7JpC/DpHlUo1N7x+Tl8jOjoJrq8oWwMVtEa4bGg0DsBIlohz9LQOo4QDW0YT0lKmLZmDK9clWhO3RWR8XfKKSHcpS5N2X03lE/r6a9rAkYDpkGdp8EgwSFv+H213APgvoU2xOTRPkCZErlrc4JvDE3TmNNmz5ow5ZqB1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(336012)(426003)(54906003)(16526019)(186003)(26005)(316002)(7696005)(36756003)(6666004)(508600001)(45080400002)(2906002)(44832011)(4326008)(82310400004)(36860700001)(86362001)(2616005)(110136005)(8676002)(70586007)(70206006)(83380400001)(40460700003)(356005)(81166007)(5660300002)(47076005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 14:15:05.2971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c380edf7-26e8-4b38-1cb5-08da082088cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
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
changes from v4->v5:
* fix a check for handler->prepare
  Reported by Dan Carpenter <dan.carpenter@oracle.com>
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
index abc06e7f89d8..031b20a547f9 100644
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
+		if (handler->prepare)
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

