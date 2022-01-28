Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB14A01F8
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jan 2022 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiA1Ue4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jan 2022 15:34:56 -0500
Received: from mail-dm3nam07on2057.outbound.protection.outlook.com ([40.107.95.57]:43361
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230427AbiA1Uez (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jan 2022 15:34:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OByCmTXz2WVqn0jA2iL5Egbp1HBELu67BiY1Mx4QhwdYXUqfQHCILqhQNZEOjDK1GdGg3v2cAMdc/qjxyw3a5cgsRwprG2Kef50CzEMVbUa3flo2V8m0fbGPips5m15rB1BlKK6Z8y9Kmmit3HRTr8yAD5K4GJsNLOuqblUBRhudEEbkVf1wvv+YWNoR2XyP2QmkjrH6T8nLksGMr1a2Be7jFWjBKs6ZeXHowm4UT02k3h/P6alzOuKCmI5TEQFtKZlmQwFlPDVF0DstHdibhjY9Hpl4x+dG4xDI7yEPb594tnGdTJkXlzJOBCxvRHnKWXvpPwUYF+8TBmdgj97Ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p3cVoVnP6h6smfrBLCTWAvj0ZdLb0hCcHdMdh4GNwI=;
 b=bpa3mx3BHjJmtWvQ2+DdP12ZtMvgfIwky+dpL5Y2452+oqu+bVk3cbmOio6yCYpkh47l5C/pmPhelFIAtCF46YfeqxrW+8X06lXux4jXKN3urrsgSKTSj/dcifxEcQpiyIpe1r1cfggiVR1jTxADUer77jLE52HsBUAsJykHM2S/03rIwZ+xmRA3v4iHy8K/IuYx8W3MGi4EsfSqR8nA/lC3ugBl8dl4lgHozsZRa5GwKRMhgGK4wu2/Y4n10Af0BxQn9nee9kN5pNg/JdhdzpZNNzv8p2I3dT7gMRGLqT6Wdiswd0JhbUXGQ/JjdNmppusy1n7Y/FG6ALE6tKaLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p3cVoVnP6h6smfrBLCTWAvj0ZdLb0hCcHdMdh4GNwI=;
 b=R5sE8AeZ0WfZKc9q4baozK4WVhIe2iLw7rHUATe0NfV5isvHtG6LrMAcDkXJhgzrAg/IXrQofOLQ/oyd27EtB3A3HWGGPgbnIyG/5eVCFlcv7moDqWu0gbB+o2fhOM9xaGAEZioBmrqr/u0Oss/twKtSqEDf0GYZt/vveUtoTyo=
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 28 Jan
 2022 20:34:53 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::2b) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 20:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 20:34:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 14:34:51 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <acelan.kao@canonical.com>, Aaron Ma <aaron.ma@canonical.com>,
        Hao-Sheng Lu <kevin.lu@canonical.com>,
        Bhutani Amit <Amit.Bhutani@amd.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Gong Richard <Richard.Gong@amd.com>,
        "Nehal Shah" <Nehal-bakulchandra.Shah@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: PM: Revert "Only mark EC GPE for wakeup on Intel systems"
Date:   Fri, 28 Jan 2022 14:35:03 -0600
Message-ID: <20220128203503.17962-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc84221e-08fb-4be2-6d2a-08d9e29da38d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52852A05AC962FB13757B0C1E2229@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02Kvn6GBnNkdLrRVv3scq26OpkTzLDBdDOCPyPguGAKcVvL8S+r0hPf1mpux+NJ44gbss+TizueldkuG84GxetHNcvwsJJTBu7iVjkALVQjHg4XiXdSFa12KHiFlOrG+xV5hQGuFNHelolJcTkcoqh886jeHiAVb3IPErpEElM7MQslqLR76vWj4E3T3DWQk42eBJX9t+Mh7lFWkJYv7el4WfHYuBHVUoLDexgpHuZUJguqSZzWfESNANFhB5z07JPorS24KWBUpRZd08jKeZpLha10Si1ov7OeRYO19ou1BYUHiQLXtIJVFTxLMl4xjmYWs17oeMowfN6LMYF8j51y7QNCFj+079HuLX7xQ11XPjCMfwqWppRViAu8rP2zK5k/keFibZ1bkjS05+Ki1JaZ/swxgdD4o8yabDAt0WSNDCREwITdqqlMqJ210Ork7UKuryHhgGLcSc2ormq6oCL91L3Gu0AeoSPxMCY7HcA3MSr7MMFNo4UW+bEcHjyt+uq6e6Yb+NqizxLXM5m/QRU1bUuOqIXCRGFDvevOSUDh0xJKd4H/Zlv9fMgHleZ2vuxiYLpB6r1r0BCE5dZPP35QFUyW8caMZUDUlvHVuxGHwWyNrjj5vW8VreRQFFGevmcL/rOjs9MHVi82GVRDu8EAfbHj3HBKA3rL3ByYcbSYg+8uuKM4Rwa8qxDvwf3NCcop3eLGXbXgTfx7mdML03a0Biuqq3jyvG6e4qHsr41kZeiwHlyh3d/ODLWd2pNXeSvJn30j2g9DpkEOUTYL4k792re3ZhQ2qo8UBXQ3OQes=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(6666004)(70586007)(7696005)(36756003)(2906002)(70206006)(356005)(36860700001)(44832011)(2616005)(336012)(47076005)(54906003)(1076003)(26005)(83380400001)(82310400004)(8936002)(186003)(16526019)(40460700003)(8676002)(426003)(81166007)(110136005)(86362001)(5660300002)(4326008)(316002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 20:34:53.0239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc84221e-08fb-4be2-6d2a-08d9e29da38d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Testing on various upcoming OEM systems shows commit 7b167c4cb48e ("ACPI:
PM: Only mark EC GPE for wakeup on Intel systems") was short
sighted and the symptoms were indicative of other problems. Some OEMs
do have the dedicated GPIOs for the power button but also rely upon
an interrupt to the EC SCI to let the lid work.

The original commit showed spurious activity on Lenovo systems:
     * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
       sometimes the power button event doesn't work.

This was confirmed on my end at that time.

However further development in the kernel showed that the issue was
actually the IRQ for the GPIO controller was also shared with the EC SCI.
This was actually fixed by commit 2d54067fcd23 ("pinctrl: amd: Fix
wakeups when IRQ is shared with SCI").

The original commit also showed problems with AC adapter:
     * On HP 635 G7 detaching or attaching AC during suspend will cause
       the system not to wakeup
     * On Asus vivobook to prevent detaching AC causing resume problems
     * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
     * On HP ENVY x360  to prevent detaching AC causing resume problems

Detaching AC adapter causing problems appears to have been a problem
because the EC SCI went off to notify the OS of the power adapter change
but the SCI was ignored and there was no other way to wake up this system
since GPIO controller wasn't properly enabled.  The wakeups were fixed by
enabling the GPIO controller in commit acd47b9f28e5 ("pinctrl: amd: Handle
wake-up interrupt").

I've confirmed on a variety of OEM notebooks with the following test
1) echo 1 | sudo tee /sys/power/pm_debug_messages
2) sudo systemctl suspend
3) unplug AC adapter, make sure system is still asleep
4) wake system from lid (which is provided by ACPI SCI on some of them)
5) dmesg
   a) see the EC GPE dispatched, timekeeping for X seconds (matching ~time
      until AC adapter plug out)
   b) see timekeeping for Y seconds until woke (matching ~time from AC
      adapter until lid event)
6) Look at /sys/kernel/debug/amd_pmc/s0ix_stats
   "Time (in us) in S0i3" = X + Y - firmware processing time

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index a2f16d4ecbae..665a89e2c940 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -427,15 +427,11 @@ static int lps0_device_attach(struct acpi_device *adev,
 		mem_sleep_current = PM_SUSPEND_TO_IDLE;
 
 	/*
-	 * Some Intel based LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U don't
-	 * use intel-hid or intel-vbtn but require the EC GPE to be enabled while
-	 * suspended for certain wakeup devices to work, so mark it as wakeup-capable.
-	 *
-	 * Only enable on !AMD as enabling this universally causes problems for a number
-	 * of AMD based systems.
+	 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
+	 * EC GPE to be enabled while suspended for certain wakeup devices to
+	 * work, so mark it as wakeup-capable.
 	 */
-	if (!acpi_s2idle_vendor_amd())
-		acpi_ec_mark_gpe_for_wake();
+	acpi_ec_mark_gpe_for_wake();
 
 	return 0;
 }
-- 
2.25.1

