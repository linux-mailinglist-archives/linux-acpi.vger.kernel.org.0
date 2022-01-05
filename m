Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AD3485952
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jan 2022 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbiAETja (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jan 2022 14:39:30 -0500
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:59232
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243640AbiAETj0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Jan 2022 14:39:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elQLb+IbbXcfxzQ+93c0NOoL9vDTVdipi7SrwAjSXHqzF1/Q9BX23zyWUBtPrHt4l6QlGS/10cRlFIr2/1RLEAgYVeRk1sWKRfwSsTuDxsvozpBWhgagPMd5f698MvgkUwGLtjH1FO+XNY4pLs46+bCbTw+LN0J2mDHfeB95wkfFObynu0zaOUR4832WDzs7m2qlDKeiOT3oSVQojd2iomaXzN86BvWEHY4EBW44Yt1NmpfSefSsL+IL/mFWpYAHuHbVJ1mXnxoKHDbUBZcX4xM4/3WX6ToKoEovWlHNbRaA8s59GKiPkTqxv/vAJ6DYrgbb9nW1ihiA8jwVaNN2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJUOJzhiBaiIdybdUOa7lNK/TvtNbP3Zw3njr6zslJ0=;
 b=ocD8xyocGe4/+QYnY36G+PN0oFRvJrS9aY8M30QJHSd5pL/wGI9gg+othfL4Qqw1MU5fVKUlEoUdNhbIIoDwfOD+44UGfY5UlfhR/kyxpkRXXD5MdMcUyRsfJ7uaUYels1SrGu8pybeSchZ0NzDP24xT3hji83CnZW/QSDGtcje5Xmrwcz67RUIQcaWfpYuCJHWGMJVJFaa1PrPXITw45q9WStCzfG9ObPDXEUi3vOi/UexVFDMIz+01b2GCxzlNI1ytpqC5SN67js2z7mxAlszMzgf1DYMteOlD3fY+bVS3sTisfcTBTY1Fe2tozoT5tev7aWZJgF2gLjuWuvDgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJUOJzhiBaiIdybdUOa7lNK/TvtNbP3Zw3njr6zslJ0=;
 b=hr5Q0MKihOLKObVruMeN6MW671xxZQ5nO6NHSzRTeegFHQW7JRDMw3JqKO99WbVavV3gGqN0WjhXXUHXwaHl186NrGR1C1Cm8uYXl2UL8DG9gCwi6sSfvgntCXgJJsL9Ry6DAO2edjpdoYNnG4yVuyX5P9UgIbP+JhzZPQYfb5s=
Received: from BN6PR11CA0058.namprd11.prod.outlook.com (2603:10b6:404:f7::20)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 19:39:23 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::19) by BN6PR11CA0058.outlook.office365.com
 (2603:10b6:404:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15 via Frontend
 Transport; Wed, 5 Jan 2022 19:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 19:39:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 13:39:22 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] PM: sleep: Don't always assume s2idle will be enabled
Date:   Wed, 5 Jan 2022 13:39:09 -0600
Message-ID: <20220105193910.25678-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105193910.25678-1-mario.limonciello@amd.com>
References: <20220105193910.25678-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12a19a06-c870-4e90-4e9e-08d9d0831382
X-MS-TrafficTypeDiagnostic: DM6PR12MB3931:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3931C7B23FBCF040E7057E40E24B9@DM6PR12MB3931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPrlQ9KmHxvnWIeSN8cBUOwiNWrYY2s5BPSgxG43ytyUYDETN364C4GF6hbOBEy0XSa+pDZ6Jx5CUximHE1WYVhZnRX3WZVtdMI97clQzVmKhcjtN9sGo06I9QCQZ+kpQ7J5Q+0xVSQJEP/pCJCuZr738IsTaZj60UAjpxLfThkIWIxHidZI4kgZ9+jPHfVdCDc5j/0YzVa4eWEx/GPxC+I8PYdcVEfYuN9Jmx1fPoI4UPLtFRszFpUw+PhFQTYSmUd3EgCWE16zEoV1PD9QccbXWKNS4i9FBEBjqo3uc/9a9sPPUPjaALSmLCkbBWf8TgVgmNfNwH2b/qp0ZoRHxWLszmgCaRFGhmzN0K7BcwwdELnzRHQr7OZK1dTy5g/D9RyYxvZi13hinDxWxQeEucvG96YnbBjCvBqjKsSMcvJC82k2Zcpm5wYlrB2ceTr9sbYgh4EPLGpcEGI1EgMaHwMlDpJ9ovlA/OM/3my8aSmAVpBgSxqtjiFCKaIELpQnVUPUMmFWgk4Z82uQWN9/juyeT1GHeAHgL9JmbjBL5Qlj1DzBLJV5l7hWtT6fY3jXiLtIGa7yBGaogrk5+9kgL5FQYy+dt+H/AAU7tfq3uqO56bSHAPh+cxi8IKS83FsYaqcFoRmbEshRhgKNo0taBe3ocv8HQOTGadsFxxn4LsCPK80LYgf+XA1BPnack0yfW7571PsueTQI13rheWvNss1JdIaD93nLo9vKfinf6z8ZwjVx4JE2FBqRNuBMPpi5lDPGiMDUiulFfIiUKgoSgSG6qVeEkutJXkxhfLIJD+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(110136005)(70586007)(7696005)(426003)(36860700001)(2906002)(508600001)(70206006)(8676002)(4326008)(16526019)(2616005)(83380400001)(186003)(316002)(44832011)(1076003)(47076005)(5660300002)(36756003)(82310400004)(8936002)(26005)(6666004)(86362001)(356005)(54906003)(336012)(81166007)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:39:23.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a19a06-c870-4e90-4e9e-08d9d0831382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some platforms may require firmware support for s2idle to work
properly, so allow other drivers that set s2idle ops to decide whether
to offer it on a given platform.

This should be no functional change for any platform.

Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/sleep.c      |  6 ++++++
 drivers/acpi/x86/s2idle.c |  6 ++++++
 include/linux/suspend.h   |  1 +
 kernel/power/suspend.c    | 27 ++++++++++++++-------------
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index eaa47753b758..9dafdaafa5dc 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -800,12 +800,18 @@ void acpi_s2idle_end(void)
 	acpi_scan_lock_release();
 }
 
+static bool acpi_s2idle_valid(void)
+{
+	return true;
+}
+
 static const struct platform_s2idle_ops acpi_s2idle_ops = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.wake = acpi_s2idle_wake,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
+	.valid = acpi_s2idle_valid,
 };
 
 void __weak acpi_s2idle_setup(void)
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 32ab4ba5adb9..a1626737e5e0 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -361,6 +361,11 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
 	return ret;
 }
 
+static bool acpi_s2idle_valid(void)
+{
+	return true;
+}
+
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
@@ -369,6 +374,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
+	.valid = acpi_s2idle_valid,
 };
 
 static int lps0_device_attach(struct acpi_device *adev,
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8af13ba60c7e..51e5bdd9be23 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -195,6 +195,7 @@ struct platform_s2idle_ops {
 	void (*restore_early)(void);
 	void (*restore)(void);
 	void (*end)(void);
+	bool (*valid)(void);
 };
 
 #ifdef CONFIG_SUSPEND
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 597c5e65aa45..29d6f1738359 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -46,7 +46,7 @@ static const char * const mem_sleep_labels[] = {
 };
 const char *mem_sleep_states[PM_SUSPEND_MAX];
 
-suspend_state_t mem_sleep_current = PM_SUSPEND_TO_IDLE;
+suspend_state_t mem_sleep_current = PM_SUSPEND_MAX;
 suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
 suspend_state_t pm_suspend_target_state;
 EXPORT_SYMBOL_GPL(pm_suspend_target_state);
@@ -152,6 +152,10 @@ EXPORT_SYMBOL_GPL(s2idle_wake);
 
 static bool valid_state(suspend_state_t state)
 {
+	/* PM_SUSPEND_TO_IDLE may require low-level support on some platforms */
+	if (state == PM_SUSPEND_TO_IDLE)
+		return s2idle_ops && s2idle_ops->valid && s2idle_ops->valid();
+
 	/*
 	 * The PM_SUSPEND_STANDBY and PM_SUSPEND_MEM states require low-level
 	 * support and need to be valid to the low-level implementation.
@@ -166,6 +170,13 @@ void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
 	lock_system_sleep();
 	s2idle_ops = ops;
+	if (valid_state(PM_SUSPEND_TO_IDLE)) {
+		mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
+		/* if supported, update to suspend to idle for default when ops set */
+		if (mem_sleep_current == PM_SUSPEND_MAX ||
+		    mem_sleep_default == PM_SUSPEND_TO_IDLE)
+			mem_sleep_current = PM_SUSPEND_TO_IDLE;
+	}
 	unlock_system_sleep();
 }
 
@@ -174,11 +185,6 @@ void __init pm_states_init(void)
 	/* "mem" and "freeze" are always present in /sys/power/state. */
 	pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
 	pm_states[PM_SUSPEND_TO_IDLE] = pm_labels[PM_SUSPEND_TO_IDLE];
-	/*
-	 * Suspend-to-idle should be supported even without any suspend_ops,
-	 * initialize mem_sleep_states[] accordingly here.
-	 */
-	mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
 }
 
 static int __init mem_sleep_default_setup(char *str)
@@ -236,11 +242,6 @@ int suspend_valid_only_mem(suspend_state_t state)
 }
 EXPORT_SYMBOL_GPL(suspend_valid_only_mem);
 
-static bool sleep_state_supported(suspend_state_t state)
-{
-	return state == PM_SUSPEND_TO_IDLE || valid_state(state);
-}
-
 static int platform_suspend_prepare(suspend_state_t state)
 {
 	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?
@@ -346,7 +347,7 @@ static int suspend_prepare(suspend_state_t state)
 {
 	int error;
 
-	if (!sleep_state_supported(state))
+	if (!valid_state(state))
 		return -EPERM;
 
 	pm_prepare_console();
@@ -478,7 +479,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	int error;
 	bool wakeup = false;
 
-	if (!sleep_state_supported(state))
+	if (!valid_state(state))
 		return -ENOSYS;
 
 	pm_suspend_target_state = state;
-- 
2.25.1

