Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4744D4D78
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 16:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiCJPWW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 10:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiCJPWL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 10:22:11 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774C131106;
        Thu, 10 Mar 2022 07:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOMXfI+y8wZrotKQToOj8j+k7EJmS4O0xblcTgsmI7OG5Drq9Tzh1xna0mfW5QzaNipSyjIhXVpvVPJY34GTTI58R/o8WPAMYoD+QJsF9KLdJUvyK4IL5rDKH71iFPyD+pmX6SmJkG9pe0s9fdu2g9vdTyGoGGO4ZB/GDhRWIqqIxvSuyFPyfXMN5OQIuChCbi/XxRB7hetDYO1TjuZL2Ti55nLkUyToKTPY6DrBn7uQgq0uNbRomVcV4FSCpZo1Xi//ZzT36PIcNeBkZ3bBKg4yASzeyGnIBnhoBbomwCa+CDMRvHVxVjXLmN//6jgV3Cii3d240U/zqUKKGE7clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw6kypIgJG6AFEHTAL6YHWj6aQf/I10GRPNj901bof0=;
 b=KEwqPxy2g8gzzXNDRUE+GCoOPfw0kjiNPQyc1PhPwDVU2JTAP91wptr5gLhWN8reON/sroHBtoDuRwZrp4aBBZCwXDH9Q7HlPxo7g8MrKv3q8LGPCdVlCBxCGXfiQgltb4eecyHIbFUUM6tBTDQYeDFxS2LJ7AI4MhxHwYFgf3dzGnnbCnecZNWeQw7bGK2KdWEZmFAXzn7Ev+zg9NPJ4x595YE1z9DVs4jDLvO1Uu6TyhD/NomPSIziExuGlkhnPK2XgTh1jo+1U8dBJ7k1lBKVvgDSHfZr8H5f70MmZjy+Wl89kPVwevaKYZNtKOmSbatJPJ2KrGtSwriVLQ24cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw6kypIgJG6AFEHTAL6YHWj6aQf/I10GRPNj901bof0=;
 b=itxhJ2ED7TixrAxHwmGliBF06KdSaj/eqmYw9NNUvG9mIdb4+IqRVqkZuWKWR+q5+BGqwAVjyh/Rjybn6Xt9wCpZ/PP2VXSZHbNuuZrHfPEkGNH6yAqnTJW5RXsg2ST8t6myKQeEulvnnrKbmDf7P7YQB1CadJ0Qg1dwiupVViA=
Received: from DM5PR06CA0087.namprd06.prod.outlook.com (2603:10b6:3:4::25) by
 DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.19; Thu, 10 Mar 2022 15:21:04 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::e6) by DM5PR06CA0087.outlook.office365.com
 (2603:10b6:3:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29 via Frontend
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
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 15:21:03 +0000
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
Subject: [PATCH 2/4] ACPI / x86: Pass the constraints checking result to LPS0 callback
Date:   Thu, 10 Mar 2022 09:17:03 -0600
Message-ID: <20220310151705.577442-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310151705.577442-1-mario.limonciello@amd.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 369ba85a-23e3-40f6-c329-08da02a9973b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB258430D8304BB6541F002092E20B9@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jLGlbFlKTTL14kYue7XLchZf5LT1z/EmFO0jjRaYxYwcgmXNVh8r3gpyxofZDPmNTzCi8ScglKb2O34KOYVIlJrSi5Z8RIfQJLfQ25GHZcojVCxjfZMQPiGBYFBiDx9h0V+thWEa+IoE4Y2dzTb5pr5vkwU6lZaUkqPH7Vqge9SDiaLAW4nRV7w5mN7rfrs5He7xC/sp9Z8LzHBPdDcw0KqHT9KO3kTbDrN3vy39SizvJXAE6amz94vc9b//fX8cByNpT4Du7rmJsCuhJtzRAL0lbl9pZulr4YTfASg4E7T1b+aAA325SbShebFhLKZbZJBtG+egICJEC/IUrKZFsJNh/Ij7WMlYNBPqzugWmaXyrBGj03K2i6AxRqs/FTLNKekA3cmav+au6uK3WMbRlYMtaJOryT/dMtu+tHOMab6+R8M3My4roRFYfduqxf3lgWA1keiqjnMiRcCfAnhtft4ktgtNYnUwR6zzwIRmbbnjXRys4obQZ6sclq2Dcj2Pkt5/xH6RiSqJSkTUW2OkMPHx8swyLwKHzHLF1mG699QW3qGXMXjp7ukXonvk8A2Dt3M3ckAuuxPtCB8fT3cU+rbQ8UuKU1OzzycVaw4Eg8t48fhG5L/xcS//BMJ7NeIZFEbPNaP96zKlKiDfACUF09E9POczWA+TflyUDOUWwEJu8ohpFsQTQDVCyg7AJ9ZVpT8L3UO6suapRQKTwoF8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(40460700003)(2616005)(186003)(26005)(1076003)(81166007)(356005)(70586007)(70206006)(36756003)(110136005)(8936002)(54906003)(316002)(16526019)(8676002)(86362001)(36860700001)(2906002)(508600001)(5660300002)(47076005)(83380400001)(82310400004)(426003)(336012)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:21:03.5257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369ba85a-23e3-40f6-c329-08da02a9973b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
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
 drivers/acpi/x86/s2idle.c | 17 ++++++++++-------
 include/linux/acpi.h      |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 652dc2d75458..c737a8e5d5a5 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -88,7 +88,7 @@ struct lpi_device_constraint_amd {
 
 struct lps0_callback_handler {
 	struct list_head list_node;
-	int (*prepare_late_callback)(void *context);
+	int (*prepare_late_callback)(void *context, bool constraints);
 	void (*restore_early_callback)(void *context);
 	void *context;
 };
@@ -297,7 +297,7 @@ static void lpi_device_get_constraints(void)
 	ACPI_FREE(out_obj);
 }
 
-static void lpi_check_constraints(void)
+static void lpi_check_constraints(bool *met)
 {
 	int i;
 
@@ -319,11 +319,13 @@ static void lpi_check_constraints(void)
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
 
@@ -455,13 +457,14 @@ static struct acpi_scan_handler lps0_handler = {
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
@@ -490,7 +493,7 @@ int acpi_s2idle_prepare_late(void)
 
 	mutex_lock(&lps0_callback_handler_mutex);
 	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
-		rc = handler->prepare_late_callback(handler->context);
+		rc = handler->prepare_late_callback(handler->context, constraints_met);
 		if (rc)
 			goto out;
 	}
@@ -554,7 +557,7 @@ void acpi_s2idle_setup(void)
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
 
-int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
+int acpi_register_lps0_callbacks(int (*prepare_late)(void *context, bool constraints),
 				 void (*restore_early)(void *context),
 				 void *context)
 {
@@ -578,7 +581,7 @@ int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
 }
 EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
 
-void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
+void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context, bool constraints),
 				    void (*restore_early)(void *context),
 				    void *context)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index cae0fde309f2..5aae774670dc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1024,10 +1024,10 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
 #ifdef CONFIG_X86
-int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
+int acpi_register_lps0_callbacks(int (*prepare_late)(void *context, bool constraints),
 				 void (*restore_early)(void *context),
 				 void *context);
-void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
+void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context, bool constraints),
 				    void (*restore_early)(void *context),
 				    void *context);
 #endif /* CONFIG_X86 */
-- 
2.34.1

