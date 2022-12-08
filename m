Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224664663A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 02:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLHBJ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 20:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHBJ1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 20:09:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85718B1AA
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 17:09:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5EXDSFqtSTcLu8LX7FdJn7EZDKBhJUqsd4MQz5Mb6FJM9egDbdBpobSEv570E/vEUNeiFmdPmLgmVHrqKu7+faHO+fmvwI9ZUYJzL6eU4tezMe7+Hrhinc2r1S6PocjBr5H8gi3th83XQWa1UN9j6/Vdk90PqDg68jatCjtS28cHAOAQ6mBGmW1CLFSFgp7ugV5i31P/79Dv+0HFbQ39FwWXlvxQJjJkBbzJAo4JXGLgTroEVaGYSANoSgKQouXMUzrajkKxCiCAXF72asxXET4DJiwzsbb6s1MNK8h07ZNpPSjaIMG9itK5cCR8+tM4z4CQlyE6W4tQ4CheJ58vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrAMD4pga7pS6VzHUhgAk+gPyuEseriCGOsv6uRsocU=;
 b=TPyvJpMRadlsdrPKsXCzBfFeGYjgtUuXT6Jxpi1xnvOWlCNTwlbV05jrJvBVOymiKwdRK7W7OQcKZHkx/qv7UEyJ9LhWUjU+PpI2iKK8GYblf6g5PLH/k6dT4eetXxMfOwQGeiRc6XlqIFdEKZpyAd4krqIZQWLS38fwEs/I3aXBwwc53rmE759r+Av6yKUdTuxOEj1KEE3ynEWbesgNflm/Vev352+pN5HCVs2TQRi/qoQcQPc72vHCYrpM6Rbof6OzDCOBjgi7tbcJcSl4EN12Exij/gPOWBIg727DZFf3M0HckdO6DvqQ8WamRA5hVuqweRvupC4vIuwCawwrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrAMD4pga7pS6VzHUhgAk+gPyuEseriCGOsv6uRsocU=;
 b=VHxGjFhHte1X25GCizv1Uab6r4RbvCGD4qUnMiJLs8tNlpjbz1ThsAWqmlpS2deM1hQU92CQPH0CjpOM/TaLegQJUk+IawpXgpphrCZxmn80NfEzEf+a/XrlLuQenEy5bkFZd8eTTAlnelhWnUIa4kvn5IPIn8fiSpYJtBJh5T4=
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 01:09:24 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::c2) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 01:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 01:09:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 19:09:22 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] Adjust ACPI video detection fallback path
Date:   Wed, 7 Dec 2022 19:09:07 -0600
Message-ID: <20221208010910.7621-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 374d1d87-48a4-4b04-fcbb-08dad8b8d85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMLhywaSTe7MGVF5PzGwsOI+jEd/c6DvrEIsiR3HcamNW/lxRQxfGY+dC/R/8veIrA9Pd9DosPejlPKvl3Y5seHP/GB7eCA4j27tw2u21UlLpGRdVtTpjFeKZkRvyC7TqUICntUKNtpbQo/461oZ52S8Mrd3hchL9OVs8NA9ToXW2I+FzwvgX8Q1LOSrpv3EeyIEzDArIPvSTQ5snJJXpdMtAFAeg1cQJFgekz/hiw3jpAPPuKTDwpNbELqZrahuQtH/RKmK9LbCMmglarCBFyfsdviY8hfN6UgsXrIr8KTDaoldvONZ+uXmrpsNLrfaDJW20QY1/akZ6lqcICLSo+9VA+T7YQ9NV5w9PhHw/RE3bnvEDr/Va7EbAvQC1yff6UduHjUsb4KK/Iz95m/CILuFDA2iB91mKRY8e7w2bdlLh55mKbqtLQ7E4dn7JNoQclzyWTmEmTQdVCZEDEf/I5+HFo7IC7mqRCCmrhQwc7caELJ9IIqWWMaI/BAqAT9C4aZQNeTxKMsNnL/k98hdxnaOuZeuirJ0R2xnduYWm2T5Q6AL/w8A6UMmSRVgJjHDh3cEjjOWP7O3a0Slcg+p3QkdBpc9Qq3lO4qXtN4RBdIgf95mhgEfICZiBvacnmiYu0aX5jbR0DkE1MgNalFUOOkwARIL182UasCIceVAexe0BFkTXWQVlUOqmb0Plw3QJ/Th389r0i3ROhzLzJ+Mlbiz7+zr32axgdJCKSU/Y6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(26005)(7696005)(186003)(54906003)(316002)(70206006)(8676002)(6666004)(478600001)(70586007)(110136005)(2616005)(4326008)(1076003)(83380400001)(336012)(47076005)(44832011)(36860700001)(426003)(16526019)(41300700001)(8936002)(5660300002)(2906002)(356005)(81166007)(82740400003)(40460700003)(36756003)(86362001)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 01:09:24.0248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374d1d87-48a4-4b04-fcbb-08dad8b8d85d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In kernel 6.1 the backlight registration code was overhauled so that
at most one backlight device got registered. As part of this change
there was code added to still allow making an acpi_video0 device if the
BIOS contained backlight control methods but no native or vendor drivers
registered.

Even after the overhaul this fallback logic is failing on the BIOS from
a number of motherboard manufacturers supporting Ryzen APUs.
What happens is the amdgpu driver finishes registration and as expected
doesn't create a backlight control device since no eDP panels are connected
to a desktop.

Then 8 seconds later the ACPI video detection code creates an
acpi_video0 device that is non-operational. GNOME then creates a
backlight slider.

To avoid this situation from happening make two sets of changes:

Prevent desktop problems w/ fallback logic
------------------------------------------
1) Add support for the video detect code to let native drivers cancel the
fallback logic if they didn't find a panel.

This is done this way so that if another driver decides that the ACPI
mechanism is still needed it can instead directly call the registration
function.

2) Add code to amdgpu to notify the ACPI video detection code that no panel
was detected on an APU.

Disable fallback logic by default
---------------------------------
This fallback logic was introduced to prevent regressions in the backlight
overhaul.  As it has been deemed unnecessary by Hans explicitly disable the
timeout.  If this turns out to be mistake and this part is reverted, the
other patches for preventing desktop problems will avoid regressions on
desktops.

Mario Limonciello (3):
  ACPI: video: Allow GPU drivers to report no panels
  drm/amd/display: Report to ACPI video if no panels were found
  ACPI: video: Don't enable fallback path for creating ACPI backlight by
    default

 drivers/acpi/acpi_video.c                       | 17 ++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++++
 include/acpi/video.h                            |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.34.1

