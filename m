Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE76461BB
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLGTcK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 14:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLGTcI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 14:32:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCBD28733
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 11:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRSzbosRSEr9WVYtQ+rYiAyf1ypIQThRnm9WiryN6tl44rEJYZ14tp/IQBM48uCb0A2jcsXQ9HWg8RNQe7UbuD6NWrDs92f+/kQUBlPBnlxaGoGNhXAaSljqvV5fjLtTz3aDGV8yzEYvoDUvdr5i2BwBiHB4KQLnAENz3Orif5v939UaHGWnAlAtqYwuRIAWGWrUR7uNjQ9LoUQMB6yz4JPUtFj/yuaqfRk1bepJ3hyZ/O1RoQ+8TsscJbNA4fPpK2Wm8/b4TS6f317nYP/SCL7NqzXkDgQcfVU5+mIqCgLKyASlcCaKG1x6iyMqtNoUqZYmxVosgD0U1uE3SQ920Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6c3pRldaf6r/XYNRIM+pTMlLPrBmAT1utBk0eBOsF0=;
 b=C6xPo0YBv/owOA697yGdI1BKtG9rzc+SRwt1vWLL+RyeYFD0L24txZ40M/KaOrVtyowUn4EPJ8N3K8kh+zGXV31gCF2hipEBQVELS5xDk22j4Cx8fYHv4yKaBrCTnAGwFNcpt5cQlNsaAcVECsR9KV9fnhcRUNUq5SX4DBsoW4FFKTmBpqpJNi95B21bGA/YkvB+T83DWg4gCtlwM91aJmsl7MShZ/AZCAoRY+nfC92/G85pwQBewAtVzO4bjj7JAmcYmoYTHHYRKlIGclRN42zSteAAv9SC3XmsDty1VfThZrJmx2Q916Ikuzax16O+BCcRQbMyrnSYH0n73uL1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6c3pRldaf6r/XYNRIM+pTMlLPrBmAT1utBk0eBOsF0=;
 b=NzQ59hcBRYtSezYLVNQdUSA3P5cis3cFJfuagmNtFWjQkjvJA8Cd8W2sptzm6iRQOcsTPhNeT6TyrrPOV3zj+vqkwAqGI3KgBy+tIEacIK6T3DoyKYbEMzP2YrZTQDXLLSvBSec4S2kkdMLztW/05bJsMomTzmHKL+r8LaJaC2Q=
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:32:04 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::94) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 19:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 19:32:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 13:32:03 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Avoid creating acpi_video0 on desktop APUs
Date:   Wed, 7 Dec 2022 13:31:32 -0600
Message-ID: <20221207193134.763-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DM6PR12MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: f5422d82-306d-436b-2df0-08dad889b85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0goH/Ur7n/wBZLPoPRFx1UvnWS3wnI7PxWy/X2WSKko7ygFxj0nEMRsxHZblABMmbCWC8zObN52NZvpTWWsSAQNusT7OoE21ahDwqPu/g8tiIAKgx1/qNBt7JFpWbDyNASDKEbc8dhoYGOdKjhesqoL45Mjvrnc6PRG7Z8eF2nufzd3p+yv+cMbOPVldeBnD1CoVNmdofbG4nbEZeCWtyUq9yrFatIVGiJWmLGltAR/ewriW+yt7fCy05MgJDW9AXtblRLBlZsfPkSD6FKubTvyWGLXbHQq7pprxEF0HAz3GgK9Vz1nakDhBaEz9M0InDOSq75j79KvJ9eBqyUkX/XyNQczTl5BJdW4oDf1gbns+4SdqKnw8gUqXW0zFV/vyZ+Ti4KxbKroXmVkVQGgDFcxXZGdXHwsdnXsj1og21D3mUzCvhRtxB8LFkU44+7F8+oNJaybsGjSN5tTs2QuA/SPX+cHSboQDSBT6ezKiMraOxhAVZnT8pby5Sj5ms/cCBueTrJ9+cIhVbd/4iqJ8Gi3jIHx5vX5E8FneQS8b6f+oR6yNFQwlojMRSzW0wmqDYtIehzUHbA8O5MEtAhE+Y86zd+vfz4R5t8ICU85o5UrJXKSps7tWBTxzIteV8syA4HXXN+G7xGN84qyFOY1CQyudpc7HIxO//Z7B6P0C0VL51EDbiw1UxVdoEfHDqDr+bOqw67Hms3q/SDU/i3fmy8/FSqm3KiBGbFVHSWizSCo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(54906003)(2906002)(81166007)(86362001)(70586007)(8936002)(356005)(40460700003)(5660300002)(44832011)(4326008)(36860700001)(83380400001)(478600001)(316002)(6636002)(110136005)(2616005)(82740400003)(40480700001)(82310400005)(1076003)(47076005)(8676002)(41300700001)(70206006)(16526019)(336012)(426003)(186003)(7696005)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:32:04.0239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5422d82-306d-436b-2df0-08dad889b85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
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
there was code added to cover the "nomodeset" case to still allow
making an acpi_video0 device if the BIOS contained backlight control
methods.

This fallback logic however is failing on the BIOS from a number of
motherboard manufacturers supporting Ryzen APUs.  What happens is
the amdgpu driver finishes registration and as expected doesn't
create a backlight control device since no eDP panels are connected
to a desktop.

Then 8 seconds later the ACPI video detection code creates an
acpi_video0 device that is non-operational. GNOME then creates a
backlight slider.

To avoid this situation from happening add support for video drivers
to notify the ACPI video detection code that no panel was detected.

To reduce the risk of regressions on multi-GPU systems:
* only use this logic when the system is reported as a desktop enclosure.
* in the amdgpu code only report into this for APUs.

Mario Limonciello (2):
  ACPI: video: Allow GPU drivers to report no panels
  drm/amd/display: Report to ACPI video if no panels were found

 drivers/acpi/acpi_video.c                         | 12 ++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++++
 include/acpi/video.h                              |  1 +
 3 files changed, 17 insertions(+)

-- 
2.34.1

