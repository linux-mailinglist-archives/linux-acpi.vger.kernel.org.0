Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9D64747F
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLHQm3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 11:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHQm3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 11:42:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4513AC15
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 08:42:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q04GZRynYQiZRLFBpy4DRGG/gCkuVhCeVFR0VwtIV9ozPnniA2zyNigEri1ooo0ACz3iMvdc+8JvxrpHWEMAbeF7P6CVl9jtEo7fjgov8rW3qXRETNgv+K9jwt2GWaLV0b7JeawjOUsiJ8ZwkwVXhk2N8r3HmoGV72qEepesWL0rLDYcfxIYmNsn2zky6lmt9VTwq0LENuqu76DUt7eHwXa8Gm86xS1dz5ppJQf274Nx3KQQY4RtH5IPBIarwCv2Y8G6Hbrwqy3Oc4oy8u0VcoFiHV7uTtC05Mtp2sBednneg9Ka/E/iK+NSZ3dbzc0ZsBum2TSwO/Tp0F3jrRNlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rCKyf8/s18ctIjfri6tBCLPXV0rQy6CCjPK31h0/QE=;
 b=VHFEWlwCXJdbSs8hzRZ5sQROp7C8TX+V1lTkDtLFYKegiya4ZmFGSfSHu/9X1aWLSrIt2HqbuNPeBriCgzcHsNpCyOLrKGed0IzXUWC+U+f0Z8HsV0VDfW0vY4N8RcPnY7FRFdDK3PFw02dG0AWDKpprS/93ktDTMME0+GQgi45/A6e5OTM8bQJw2tHIzJ+q6TT9NSllJDMSAPScLxsMMuajHoEl0gcP/FApitEHaH3SqzUbYUWnqVUklDzup7rDOjn9q3zlqgnDwSwyVNI2HoVqgyAGlYEvSkzFM0NXBXkWvyKi6s8NleQVYoucSHju1pKJBcEOQJ7WytuubdbGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rCKyf8/s18ctIjfri6tBCLPXV0rQy6CCjPK31h0/QE=;
 b=YOgoCjM0oKv3o1DZecFCqu+EbKGUo+Zg7REMdcoHIXGxh8Z71hKcQq5hJBNE0sQn99hGfQR0YHBGP9Y+sX9OcI7RN1FxXk35JMbPvf8G0KtVs/cEmKBiA2RR2s0jumD+bzHZi5I1bRzpVa+n+RPIP0zCrL+d0hTvNoj5JkVgYBA=
Received: from MW4PR04CA0389.namprd04.prod.outlook.com (2603:10b6:303:81::34)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 16:42:25 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::29) by MW4PR04CA0389.outlook.office365.com
 (2603:10b6:303:81::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 16:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 16:42:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 10:42:23 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Adjust ACPI video detection fallback path
Date:   Thu, 8 Dec 2022 10:42:04 -0600
Message-ID: <20221208164207.13518-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 081dc279-cf83-4437-21d6-08dad93b2f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvTzegFhq2T8wJL55T7kb0Py8xoVzS5WYkT0gCwvDWCK7tHMQa3uT0lBbs0yTbD137JxtD8jVBvc/Lgh3/plJZH5EcrJJGpYV5rgNPg5StWDqMcigFKy4jsSxjuewYvTEKI7IBCpLHklFaqv2a35y3QO2SQ9CIQI5yfFBZGd7W09PHkwQUU691WhrtOLV+hjihkGHdbBjVmVpPpCgoD0xhMn1XQ9RibuKh/NOAhV2nFoD8YQ4b/63JFswKup9WvIIBxnnCtWojEbPy9riP18G0EB+mK8ueKDY0vaa+UwIORmyFugw+wslzRJFpfDyCqhlbAReN+vnxAAvHm7J4dGo7iqFjN3KCzNqlgXSmg3LCbAf5bPv2HgmM1idUeUsK3tayaMCJVg3DjeiVDyrbOWEBHgIU1kx0XFywkZNuix57UQE3oRty3vNcTTlabU9G6Q8qv33J4aNDGmsxgcEQ1Hv8leHO2sgAv/dE+O2tooBdwl7ipob4T6oxC9/fRNb91QgV6V/+4gkFJI7CBwIloGqgu8XkxWVqeCIOkxgKkkMUIanUNZkurma/euSNDdzE/YppCwT3k3VgiuO2hc9QgPp+NVgUDZ1whNuebwr2FyRMh8XtxyAP9FYXgjdPxsRv4rl3vCNjXFPAIhah4x+0AdmqPyksAlxuEHMLmavOAsAysGatv3IRoeDkkMs/5gYe6wabDd2sw4yGixSJDrAQ4Nu0gjMNr5KVy01Hfho1z3HIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(86362001)(2906002)(2616005)(336012)(47076005)(186003)(1076003)(426003)(16526019)(110136005)(83380400001)(478600001)(26005)(82310400005)(6666004)(7696005)(356005)(82740400003)(70206006)(44832011)(8936002)(41300700001)(40480700001)(81166007)(5660300002)(36860700001)(316002)(54906003)(8676002)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 16:42:24.9293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081dc279-cf83-4437-21d6-08dad93b2f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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
 include/acpi/video.h                            |  2 ++
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.34.1

