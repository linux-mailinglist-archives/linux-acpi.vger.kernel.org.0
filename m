Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD91541F207
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhJAQUz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 12:20:55 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:42529
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231950AbhJAQUy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Oct 2021 12:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7X/QX2sGllyQ1OgSl844BEh4XUHwwUbwC3VP83c51HcNcKc4hHjKM9v3TowvJwVumiCNrio1B9p/e8sioOKlKB+wqlswAT/595pbkX1fAPS65ty1Qky0OATHCn0Tv16Vghu8NA4HDltJ5h0EgnGmVv8N1yTROpEUJBNubLZjBL6Tl1CB9mB1Aybwr5AML2iJJ1hXA7U2ZPe9b/egvoQqYVnlIltaoC0qVz5uK7ZqjY7ffF9c5LA9EhzfKXVYh0BJYv6lR8iQ0hlZl6YF4TFS5TBMjqSeXOcQE5rJ5sK5OMPCLxf1oQ/vEtGg6rvkz6b5udiKUaS4H+ZHopnrJxC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rfSCndkQFvYHg+cZ83axU+yqIcqY/wNUJlFM0p3LrQ=;
 b=OCn0AanTv1FYAsUpx98QZlJN2cq67KJ+XnHYyscT5hzzk4aVFtbX4VIyuwjSggi9yTAkOIUUnfY1sguICc3C8et7Wx3HlvpigsfyAY3oSSW6+rpVpDx9rPnOL0jmXYhV3A2jiFOxl8oVnT3qxrYMCWcXAGYJD3lStBuncWGgryGOg4PlE8YFA+Smv2d5j325iqmAeoCoWohwVhD4a5IOucHiOOLRIdIdHiG+zyX7RHz9HG2W9mrUQ3UHJMrqB2O24QdoijfVJEPWLQlHKKydbJSwRHVgX/EBDwsyFGrJ39YSpvBa0jua/GgTUm4p2dmNGvCK6K0vu+KmM43ksEb+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rfSCndkQFvYHg+cZ83axU+yqIcqY/wNUJlFM0p3LrQ=;
 b=edEGNiXEqUHY+kYHYVEyWIi3wsB+H0NttxsUHkn6wjtahaa1TmDm40XfwtJErqrP/JnYcmoA+GCpmw7mfGbt1CWdKaKHcmV+fn/B5WFkc1yGpdVcXhbZM4GZt6iOuviuWrQIeMSVY409UvIewiBjGCCX0GkTBvnvWvqAIfcX7/Q=
Received: from MWHPR10CA0021.namprd10.prod.outlook.com (2603:10b6:301::31) by
 DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Fri, 1 Oct 2021 16:19:05 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::fd) by MWHPR10CA0021.outlook.office365.com
 (2603:10b6:301::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 16:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 16:19:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 11:19:03 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC] acpi/x86: s2idle: Use constraints to enforce behavior
Date:   Fri, 1 Oct 2021 11:18:54 -0500
Message-ID: <20211001161854.19802-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e918346-a285-462e-4c9a-08d984f73054
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33702E03702E87EC0E7BBA2EE2AB9@DM6PR12MB3370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwXdlXWfpZ5ntnI1srxKb2derWC7u8GMY0Rm/eE0CW4ikraniSgu2vGM7aMeAa2NqAsPcMhJRrISdJVxN96AjKa0PjSrpZHCdBMGwcksp6BCEXzbCtXL5B0VpvljhSHvgQf9BMXULXujnRUdV86YflfcFN89AySmR3QIXX2dYvJ2c88ADbP2a+f8acdgF/ReM5ie/QV9UFNZW410hxxnRfaHszkgBkIb7ruaFYKc89I0IXqaYWIIQCXuii7V/VTpUrA6XG8mWu6Ll8G6tdQ+lbX4kRl7vqtrpGG9m9HAsk819No2WQpNrM+pjcsVSMx4gipeoWZ+0PamtGqiulkjjNRdj4Z4L6GqHoVpoPu4CIbdQ1aGo8xUgsQwqQ9dffXMfSWQV7+7GLpEJVs+kcUIGqtnDjV14tx+nB0DQ0cIh8kRQ3uUKakX5rcSkws73Md2YEYvuB21SOLHxTAqqGdyGmhRBVzo66+Of2hpmL20wx7dyc/JAph2sAEpm+SzICXMck0tnJ5ifh22uwn2wDMKLs7RzlfUrGN/jTQ7tjCJ8WKZBevUr2DOI5kuRWSL3J54ncG82YM5DD66js+Qsnd6m6qgflNznB6SJ5iMV1jGY3mDIM9y738WOGSx8GWmJ2Q/vmCK4wiSDnDvOrfdv7l5oSCd5xKMoc+RDhCmMlOeA/0FlZnNy5xZlimPCa0g3N7hm03hOye8pNSkM8I/zJcqC29/S+6iDKIm3/o51ofS9Oyhp4P6SdarlxtPodI9E3CfoY1fqQ6OITuz26hksGPgmVjijqLCkcNEsdTxhEzrUZiLNkdG1JG+jrb8IGAj90cC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(44832011)(83380400001)(110136005)(36756003)(82310400003)(316002)(47076005)(70586007)(5660300002)(6666004)(1076003)(70206006)(86362001)(2616005)(336012)(186003)(2906002)(7696005)(16526019)(81166007)(8936002)(4326008)(508600001)(26005)(356005)(966005)(8676002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 16:19:05.0786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e918346-a285-462e-4c9a-08d984f73054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently s2idle constraints are only verified when pm_debug_messages
is set.  Although useful for debugging, it does have a tendency to paper
over some underlying issues.

Of particular note, I found a case that a system that has two physical
SATA controllers that share the same ACPI Power Resource.  When a drive is
connected to one of the controllers then it will bind with PCI devices with
the ahci driver and form a relationship with the firmware node and physical
node.  During s2idle I see that the constraints are met for this device as
it's transitioned into the appropriate state. However the second ACPI node
doesn't have any relationship with a physical node and so it stays in "D0":

```
ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
ACPI: PM: Power resource [P0SA] still in use
acpi device:2a: Power state changed to D3cold
```

Due to the refcounting used on the shared power resource putting the
device with a physical node into D3 doesn't result in the _OFF method
being called.

To help this problem, make the following changes to the constraint
checking:
1) Make constraint checking compulsory but gate the output on
pm_debug_messages
2) As part of constraint checking verify if the ACPI device has a physical
node or not.
3) If a device doesn't have a physical node, but does have a requirement
set the power state for the device to allow shared resources to transition.

After making this change, here is what the flow looks like:
```
ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
ACPI: PM: Power resource [P0SA] still in use
acpi device:2a: Power state changed to Dcold
<snip>
ACPI: \_SB_.PCI0.GP18.SAT1: LPI: Device is not physically present - forcing transition from D0 to D3cold
ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
ACPI: PM: Power resource [P0SA] turned off
acpi device:2c: Power state changed to D3cold
```

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index bd92b549fd5a..fbfac40733eb 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -304,14 +304,25 @@ static void lpi_check_constraints(void)
 			acpi_power_state_string(adev->power.state));
 
 		if (!adev->flags.power_manageable) {
-			acpi_handle_info(handle, "LPI: Device not power manageable\n");
+			if (pm_debug_messages_on)
+				acpi_handle_info(handle, "LPI: Device not power manageable\n");
 			lpi_constraints_table[i].handle = NULL;
 			continue;
 		}
 
-		if (adev->power.state < lpi_constraints_table[i].min_dstate)
-			acpi_handle_info(handle,
-				"LPI: Constraint not met; min power state:%s current power state:%s\n",
+		if (adev->power.state >= lpi_constraints_table[i].min_dstate)
+			continue;
+		/* make sure that anything with shared resources isn't blocked */
+		if (!acpi_get_first_physical_node(adev)) {
+			if (pm_debug_messages_on)
+				acpi_handle_info(handle, "LPI: Device is not physically present - forcing transition from %s to %s\n",
+						acpi_power_state_string(adev->power.state),
+						acpi_power_state_string(ACPI_STATE_D3_COLD));
+			acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
+			continue;
+		}
+		if (pm_debug_messages_on)
+			acpi_handle_info(handle, "LPI: Constraint not met; min power state:%s current power state:%s\n",
 				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
 				acpi_power_state_string(adev->power.state));
 	}
@@ -446,8 +457,7 @@ int acpi_s2idle_prepare_late(void)
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
-	if (pm_debug_messages_on)
-		lpi_check_constraints();
+	lpi_check_constraints();
 
 	/* Screen off */
 	if (lps0_dsm_func_mask > 0)
-- 
2.25.1

