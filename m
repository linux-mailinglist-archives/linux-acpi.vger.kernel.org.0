Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622E36461BE
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLGTcT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 14:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGTcL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 14:32:11 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A4B10FD5
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 11:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPbG+F7HhHA0dIpRGgXbM5xSp5rNnvBSeU+Tq3fHrHZxtogikwxdSOHwq9KhF/KsyvyqJsOnPlKbJSOesWh7tGBemcbuyuCP096DzfECFlYs72Vjj62CVgsseXAE8joS3X3FRJCtwIG1DYi/j6MNJKIMJMMc6RdrUNr2cxU+G7cn3MfTK7brnB29Yi7zRoBe1ubysOxYl+6mpBujcNNXyfAY9257KcGA/Tpl/nlYhZKxj8zqFBLPjtmnCzB7O5am8+miAlOE8MLA0pE0xT5UIaSRlVfhP/XY/rxevqJdxJeYKyV2GbGpP11DZI5h+IH7pzPURfhHMbr8MCE1/wDg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aocV6TuwUZFloBrc3oz2m9I9npUQ51Pe8QlrLnbtLE=;
 b=cnmsHwCfa8lF1toAQX1nV2YgJnstp/xG/y/J0kO+h3afrVkdMyzzm1f4/iITGDWLNAMXw1iQLszWc6qViAJJnmm2x5uamtvS3tmj9IeqqdS12Wyo1lw2dCihKW8r21aE2G9ov0CGv4Pnlu5vmJc2h0+Gd71UDzUghuonxEOfF/2RLaU4DaqKwN8Rpbrni2XwDZGnNenLwEo++n0NXfEln2rpGNWBiG0knCxz/Rz9R4XnleTQ62lrQUkgIQREptdQNDGG85g4hhepyH5qC38HavVC/zCMK+r5Ez1+ySUUY8t4F4SCS6U35tFu5eQFoPWqJ3DRbV04IqwbEL1N7tFIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aocV6TuwUZFloBrc3oz2m9I9npUQ51Pe8QlrLnbtLE=;
 b=xMIcVo17VsK2Dc3IWH6zJBivdM5cNGjjt/nNot9EdrgcBvbc57mcl3DcpDJG/UkXEcr2BvK1lmKoPqFDtYqHKudN9cZ4WBuAxceJe1neT8fTVuEcvRU0/nd5I0KHmD3Ztm1axI3hvWWmsxJYhzqVElvA94riGsl5iutxMEFTdTE=
Received: from MW4PR03CA0190.namprd03.prod.outlook.com (2603:10b6:303:b8::15)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:32:06 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::5f) by MW4PR03CA0190.outlook.office365.com
 (2603:10b6:303:b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 19:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 19:32:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 13:32:04 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Report to ACPI video if no panels were found
Date:   Wed, 7 Dec 2022 13:31:34 -0600
Message-ID: <20221207193134.763-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207193134.763-1-mario.limonciello@amd.com>
References: <20221207193134.763-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 82067bca-e163-465c-ed52-08dad889b9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIzxVNgF3Ojjf8NBx6IgrdeZAbQiZ1caPO4tYCy1IdM31XDvSGaIz5wbLej/vMlhNxV3Ze+kSNWH3ZnQc4vSNIqNyDBVebsTBl9nt7+/S6NjZY5zvgfecIiWz7MMLoVl2IrXN3FPlM4QmWajNb05E+onHb3JkKJg0/PWYmTui2SIhDQrDqVMWtNXUOGUmSTwj3WaDUrBqmU+OeZxOyc20C0L5XDPOHdE8LVKOgWCHN0FqgLwt2ABgc2VzkmtJEmwKgcer3JQ9dmsSDZcLb5ackLOj8bOAFYcVMbnLcnBqdyR4xbeL5trxK3xtlkdNVjZkQsCfoiEWPqIBIM3YH2o04rKoqCWbt3Y+6F1wEpjF5ExDZps8i5vWevjJFi+OYOzLy1VHa3M1A9YzMHqzRNA47k2oSoWLqA25Q5P2wAnSLVxBD62TR8N1YVVdDAcVj/5fYmtHaio1tqmiHmvnkBmKTNqrOjhdBLFkDpXllATOClN4P+mQ9b08mccJiROGqNtk+HL1RCupFEwX3hyAmGcDtj6t6VbD6R7i3vAGTEalQBpDzoOSUHFuQerKzmeo3E5duNz2aui0Rsc7YdLZzg9F/jy8AW5LuoCvzBDXd56+iD35ZVxfV0ogLrkW3aADCheJzXbC2xbwDM7tKkesxEAuY9oQzPpH2v7+vqrgy2NAI58GNCpPefLxxbK5ZoMpjyRnUeq2m2K720eg6XFhtaznk1Sv2hLervd1ksHpPqiZ49l2ZTXB3kFUcmkVu7XSs2+iOdw0XgSjxwyv98cuQHnEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(1076003)(2906002)(16526019)(110136005)(2616005)(81166007)(356005)(8676002)(41300700001)(40480700001)(4326008)(70206006)(186003)(70586007)(26005)(82740400003)(7696005)(82310400005)(36756003)(44832011)(36860700001)(54906003)(8936002)(40460700003)(316002)(5660300002)(6636002)(83380400001)(478600001)(966005)(47076005)(86362001)(336012)(426003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:32:06.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82067bca-e163-465c-ed52-08dad889b9e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On desktop APUs amdgpu doesn't create a native backlight device
as no eDP panels are found.  However if the BIOS has reported
backlight control methods in the ACPI tables then an acpi_video0
backlight device will be made 8 seconds after boot.

This has manifested in a power slider on a number of desktop APUs
ranging from Ryzen 5000 through Ryzen 7000 on various motherboard
manufacturers. To avoid this, report to the acpi video detection
that the system does not have any panel connected in the native
driver.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1783786
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 512c32327eb1..b73f61ac5dd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4371,6 +4371,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		amdgpu_set_panel_orientation(&aconnector->base);
 	}
 
+	/* If we didn't find a panel, notify the acpi video detection */
+	if (dm->adev->flags & AMD_IS_APU && dm->num_of_edps == 0)
+		acpi_video_report_nolcd();
+
 	/* Software is initialized. Now we can register interrupt handlers. */
 	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
-- 
2.34.1

