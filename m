Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563E74B75F9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 21:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiBOS4N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 13:56:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiBOS4M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 13:56:12 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0EDF4BD
        for <linux-acpi@vger.kernel.org>; Tue, 15 Feb 2022 10:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZddHIJVIu01qmZGi6Zy+BogYDo8UuBV5aszaM/pQcYd+EeeRy4Muj0SBbxECsEVhThhSIwANnidpcf+u67YKmdHoCVyLIPdGG2qBwtabOAhHZE5OTJiINCtpIORgJ8ZxQNWBUytozLwZngFkYcLJbZJCoNOn2fI/+8gvdvs9SkX6E99PLqm+171kL0Y3S9C2fcR5lLK9X9Kr2+yGs8zm2BAK2TBlMBiMYwQreoXulOkPeDbo7xu8AFYLBFPNOPNIymOr2+FuXWp9/xm9T4m/I07F+BzBm5QAohIfom7PBQ+5/5F6gGa91tp+mrdaXoYEHKEKbhx9hYbdLjU5o7a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OBDk2CixDDxle2CMpNWbhGD7JENbGtfR8HptFzWZfw=;
 b=j14egbPk5J0EFlWjt2dfpCS3XyLhkR6+GIPQyeaziMuExTqZrHVy89ZQ05FnHSLp8g6rRzMj3ibWBh/5L3gvpUrRGucorkDKxNqZp4PFkZgVGacIBYNtJRzxpwz+1G0s/sH/qcWxf8csblDIbWLSgtX2RD1YZYkyv2H/uyKCukSwHaOlZYKHd3W0hB197uNVws4k9gOoVR/tnUMoQxUgM+1oZPKvRhenrYhvJYIEbdyMyrNqHFp9wZUWb7wne97Z/9kpyZuYiiKQP7yYgkOYAYZzkQoQhjeV0SZDG5OL1P4T3ngKDTn2AehIRLzNnlu4TaoqPmpGO0bkOFa9lP5MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OBDk2CixDDxle2CMpNWbhGD7JENbGtfR8HptFzWZfw=;
 b=CpxEZHBZKYF6PtTa635leOOBbW8b/55lfKzHYFMBg/UkcILgvfauxWMrZUczQVNpZ01UfKX4j89Fu/dOZlrrWA7Y9s8Q3/D9g8wwdhV2wEie69WGlB6TR1YSQRqNNG8k1A3VG45qlR0fEvdgRuGhI0kPZmZigiO52mLqoq3Rz5Q=
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 18:56:00 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::3) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 18:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 18:56:00 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 12:55:59 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/3] ACPI: APEI: Adjust for acpi_run_osc logic changes
Date:   Tue, 15 Feb 2022 12:52:07 -0600
Message-ID: <20220215185209.1046551-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed765410-9eb6-46bb-9290-08d9f0b4cec9
X-MS-TrafficTypeDiagnostic: PH7PR12MB5688:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB56884945C708C6FD307C0275E2349@PH7PR12MB5688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdRq5CU6FZLiYEgqsYfzZ1m9oz9eVtx0KMX4HI6sf2S/fmqmngYBmGnC/y1WXjsQXdwnnIOf21bGpMN6Oze1byK/O4LLkYcrU44JJoTO+kvmeN4KlQ43Fwmszep0buafvPitrD0hasgo4c1fGKacvXbFbTOrXOa6qVUcfmG6CGPkLFsbFIjm3rhn+Y/ftvYeYX8238U635gw4LbI9EmCY7CffRqpiMBirUm0SsSUWP4VslKl8IwvJp/85xanW6Q34ZjJXqWtXs4XvajBEu+NKeWc5g+uI8LzXAXjlPthQXB1vCIPyydTllek6nX7S+qTDlJqZgv3B33LRWzVsZI9eJf8Hddw67UC3MyzaoP4NHUlvnaCmqtQmGRwHDGXjakDvffZSRcS5Yz4qLDZRJKtACgP1AClVZVNri1IpZbCRrUJR3vyAHU/qrbS3BqEZdv60NwAGCyC/D3dMCuXeVX0USu95cy07FJWQ7+Dz7CJS3HIC4sKD/0mT/H5kLnYdzm1YX56PsQVIx4EXOPIQpMVY2rVFNhbwbis3QnTnEeDovxwhhnLhlQJFjkGlzrKnTYpnGIJbI4FQo5n2ZgLskFPHBI6H7X/Iyelc/NZ6ETtq5EsxFwpeFRqPwxW7yOoOm3j1N0kif4Y0yoOMkCga8VYAMzMNSgut3ot9S+y76jS7FT0VmaFSoYe9i7K9tjWfnPosoyVrLRmTG7eFa9CrMu0pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(1076003)(26005)(316002)(2906002)(2616005)(110136005)(186003)(4326008)(336012)(36756003)(44832011)(8936002)(16526019)(86362001)(83380400001)(8676002)(47076005)(6666004)(81166007)(356005)(70206006)(70586007)(82310400004)(426003)(40460700003)(5660300002)(36860700001)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 18:56:00.2950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed765410-9eb6-46bb-9290-08d9f0b4cec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As this function calls the OSC with the OSC_QUERY_ENABLE set in
OSC_QUERY_DWORD, ensure that it continues to operate the same if
the function has returned AE_SUPPORT.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/apei/apei-base.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index c7fdb12c3310..f7d1aa687fd9 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -780,6 +780,7 @@ int apei_osc_setup(void)
 {
 	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
 	acpi_handle handle;
+	acpi_status status;
 	u32 capbuf[3];
 	struct acpi_osc_context context = {
 		.uuid_str	= whea_uuid_str,
@@ -792,12 +793,12 @@ int apei_osc_setup(void)
 	capbuf[OSC_SUPPORT_DWORD] = 1;
 	capbuf[OSC_CONTROL_DWORD] = 0;
 
-	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle))
-	    || ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return -EIO;
-	else {
-		kfree(context.ret.pointer);
-		return 0;
-	}
+	status = acpi_run_osc(handle, &context);
+	if (status != AE_SUPPORT && status != AE_OK)
+		return -EIO;
+	kfree(context.ret.pointer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(apei_osc_setup);
-- 
2.34.1

