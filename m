Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F079485951
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jan 2022 20:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbiAETj0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jan 2022 14:39:26 -0500
Received: from mail-mw2nam08on2074.outbound.protection.outlook.com ([40.107.101.74]:21600
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243639AbiAETjZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Jan 2022 14:39:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/0WwMCSVeqddtbulmupr/TD0Auy82BVF6L+Cf0hoaOrRQDjlvL3+GlrcURKfHyvUVmC3RvLP8/Zg3OFbsbelWVswYno6Nju/pImXGHJY6RRec1t1aDiIbz6Vb95dpehs6anSXX6VJZVE5HfMenA1xZbZULSFSxa+iq1uWPJ1fHOFe5Y8jVkDBFxeC3szUQ7c/oEJMGtNPdAl5yxX/5qUG/qSf4BmEqvdanZSPKT92Gg7AEnm+kRlz55w87abDJyTd1xNLDODjRjdRoOZouuwjXU5ZdCgzgrys/T109uGjVs4OyuHGQ50ihv3GWgd4FKcc309Vf8B7HSkjVxuS4UPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7S/pG97lAMZbYfoaJ+qQYTGd2DpLTCMRSSQghQkwuI=;
 b=nBKgXvUEi+zoUbfPg7UoF5J3xbWU/uQRuOACVTret95VCeGcWtAnKlfWsRd3PsvPB/+CkLJBGC26xt4HvJq4n/mfiNpucyTqIW+ZkNR4fujeT2DimdVhyPDxA5H50HeeN3bKI4v56DxvV1+6DxnZ0/tn6595atBlYqEYqM2ouaRUpeQthGD4nrJ/SYkJkXrADGuL3/k6Rt1cc1ne2LPksslS6JBtpBFGArRYfDAz+IhbKdDu0yR4UYcEcn7ve9R1wcrhb9yY2zYWZGFcakMwNqFL2aB7rHV9w8RYS41+KWhyxIcM9NzSDq4sHeOLUVvpWjIv+xlsGUrTCoRZjoDF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7S/pG97lAMZbYfoaJ+qQYTGd2DpLTCMRSSQghQkwuI=;
 b=OQO7E86XjxXJchThjFRZEY9uD/kXB8IPaGDGIf77s8NZXRLfcHjbTPuo8kXh5cg7r/B5apKKnh/ymV1PD5g4ujNYcG9WgryM0iDBO1LMLrGplt+7OkvYbS8RGJd++LvaNKibuUPqypNKqDPYXi5l16zbyEbrehjWZOVhHEj14AM=
Received: from BN6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:404:f7::28)
 by MWHPR12MB1679.namprd12.prod.outlook.com (2603:10b6:301:f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 19:39:23 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::1d) by BN6PR11CA0066.outlook.office365.com
 (2603:10b6:404:f7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
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
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 19:39:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 13:39:21 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] PM: suspend: Move some structure declarations around
Date:   Wed, 5 Jan 2022 13:39:08 -0600
Message-ID: <20220105193910.25678-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68e7b90f-7a90-4e8b-8ff2-08d9d0831320
X-MS-TrafficTypeDiagnostic: MWHPR12MB1679:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16794EDB5BA89521D26B4310E24B9@MWHPR12MB1679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmn1OKJaYq3Zq/+W5UF/aWqVHmHmMEo+gVcSWlmF8Dx4sXnCVgwdFHLLM360TnPkJYCu9ZhgKnnqztydjwzSqskevgaFUSUY3+uSCphZ1qoXA/9Q+sTaC2YwVZypcdVVxRimZoDONVtaljgN/UHrr6n3ytL7ybsOWwrY8G/Gu2Z7iChrRLCkNEG2QA0yj0W+bUsn2+hoouxjqmF+Uq541/1OItm9Cuh49yCviliNsAHW0zfWmncloV8dpSGyGYsSMyB9qalIsTs/6sw3/c7+KYkv6gzSZUFLQrqGxtEQvAnlG77a5ZTqT5dVdqTUuqMBWn20cOA/VPtQy3krrnFhHywIC+Z8uvjkk2G1Nuw04ptG08RpR7nUhmPqDtyxmg33xINovq4YV8W4HX4vDNytwd2110UlOzl0HJf2CdNzt+2PZJnDv5lYIFhPbAjSfZypeG4v+ODGxFtnlvUZaPGQLMyJfyfJUW4ALd77E4NFKTaqpQNxppAUbEdCM1jd8Uc4KT0T+v4u3T4rZPx2ESdXM19Y/yoUnL5FDdgQzwEjo+Z1UmPVg7IRewPxxRvCkcKYkZh/1uMz6MlQpIlf3PuX/63hsG6s1pQTSYakNR7nnaLEQZizvl0IVNJNOhew542EbSUrutlmlGmm+/69sd0QfJ+PjW3sntGlC3LP8aK31AeYODuXyIIue/o465riXKhUx4WIUrjCZqVVCtgQiwK5lM8Fwn/Phl/BRKn6m8SvwNXHB8wE+kEUaBfWqcr5NhDga7zL71wJ8W6cy2AdJxTIebJXOfRYYBcAXM23LkwrtbU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(2906002)(6666004)(70586007)(15650500001)(1076003)(70206006)(5660300002)(82310400004)(83380400001)(8676002)(40460700001)(508600001)(8936002)(4326008)(36860700001)(47076005)(2616005)(426003)(336012)(44832011)(186003)(16526019)(7696005)(26005)(110136005)(86362001)(54906003)(36756003)(81166007)(316002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:39:22.9361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e7b90f-7a90-4e8b-8ff2-08d9d0831320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1679
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Future patches will modify members of these structures dependent
upon these locations.  Move the structure declarations first to
make those patches easier to consume.

Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 20 ++++++++++----------
 kernel/power/suspend.c    | 14 +++++++-------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 1c48358b43ba..32ab4ba5adb9 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -361,6 +361,16 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
 	return ret;
 }
 
+static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
+	.begin = acpi_s2idle_begin,
+	.prepare = acpi_s2idle_prepare,
+	.prepare_late = acpi_s2idle_prepare_late,
+	.wake = acpi_s2idle_wake,
+	.restore_early = acpi_s2idle_restore_early,
+	.restore = acpi_s2idle_restore,
+	.end = acpi_s2idle_end,
+};
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -508,16 +518,6 @@ void acpi_s2idle_restore_early(void)
 					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
-static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
-	.begin = acpi_s2idle_begin,
-	.prepare = acpi_s2idle_prepare,
-	.prepare_late = acpi_s2idle_prepare_late,
-	.wake = acpi_s2idle_wake,
-	.restore_early = acpi_s2idle_restore_early,
-	.restore = acpi_s2idle_restore,
-	.end = acpi_s2idle_end,
-};
-
 void acpi_s2idle_setup(void)
 {
 	acpi_scan_add_handler(&lps0_handler);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 80cc1f0f502b..597c5e65aa45 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -73,13 +73,6 @@ bool pm_suspend_default_s2idle(void)
 }
 EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
-void s2idle_set_ops(const struct platform_s2idle_ops *ops)
-{
-	lock_system_sleep();
-	s2idle_ops = ops;
-	unlock_system_sleep();
-}
-
 static void s2idle_begin(void)
 {
 	s2idle_state = S2IDLE_STATE_NONE;
@@ -169,6 +162,13 @@ static bool valid_state(suspend_state_t state)
 		suspend_ops->enter;
 }
 
+void s2idle_set_ops(const struct platform_s2idle_ops *ops)
+{
+	lock_system_sleep();
+	s2idle_ops = ops;
+	unlock_system_sleep();
+}
+
 void __init pm_states_init(void)
 {
 	/* "mem" and "freeze" are always present in /sys/power/state. */
-- 
2.25.1

