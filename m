Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87475647481
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLHQma (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 11:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLHQm3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 11:42:29 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92B4E417
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 08:42:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBiWmCuT9/8gHazUhJNKQDaG0E5rok8FWbsITF7aQBxZ+P8Yx/Xsk5bb9UCK7NXbSaPQbHnT4DljwmicP57W5n4uy1REmyAQaEebcCfELVQo+rxN0Ae8ygZZNwZhK/xWYIjKCJkCrAR4prM0nqBInvN+5IvVT7FRJeCuEeFLNBPdEQpTZzvcuIlKT3V7XTA4begu18Fu25LIr7BSo9rwMCKUKiztHEiBX5MlhXLEUtZpQjZtfilbDv+K+ezOpwtuMTEmU0Uzns1gyFg55XmVBgTRw3MOYSIoxG66BVLAtRKWbBUSEy9Nf4DfkX1unH6XfosIbv+rBmUb3ErjD7WDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytQKvfda0NEOJhvrhlW3S5MbyVQgIA4XN9XSJb1ttbo=;
 b=KuU0twLmPCEZMD1MIkFqmGGb19pOWGR3TfuqVCQUhLN+Zph6js683O0sZ6S1+dgDEUYd8vYZg5aFezGSf2jzUgHWuMifH7OSACMjUmuCKlsSyff3un5THv7rDT0w2lk29xjvI5d9haBW5JexuJ+3gZdbvRbgAhKiUgDbH0+212SGB02cljBQGnJDo16J4b1N824FVeoR64F2V7CyAKmKK/aOG84JPS7ijvSBOTTG5yOJmL7mRLxdI/pP6112m0X2QTqEm6iihkhigJ1+pq6gBlM6e2h0kaO1aPEKyAVnpuvn6vDbhqZN+kQKLP69CKcvL1wWIc1bcChCMytcPpYbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytQKvfda0NEOJhvrhlW3S5MbyVQgIA4XN9XSJb1ttbo=;
 b=FkP0uFQi+QpfbO4e1uQJ1sRymOPtOoODeOpSd8XmAM0hPmYY4aQgtFTZimM+WJEHO7N6GEFOpyMndUCoZrh4FPqeTEu/PHLOzEDoYOhkmcVqo06Ab8ZcBONVLdV3ujhn40y0eCq9+Wrfry9Lx2GCJIU0v9mTwjpWvjDhzmbPa9g=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 16:42:26 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::80) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 16:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 16:42:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 10:42:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/3] drm/amd/display: Report to ACPI video if no panels were found
Date:   Thu, 8 Dec 2022 10:42:06 -0600
Message-ID: <20221208164207.13518-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208164207.13518-1-mario.limonciello@amd.com>
References: <20221208164207.13518-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: f10bae81-92c5-4a13-9bdd-08dad93b3097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPPSxNPuU3YxrZxOD8CodJWlETRchbcjUYciaRRPeb374+mrGn1xRwuiBE1dkoZk59L8FQ/GQS458ARrmkt6ITzo1iOjYK/5hp7Ws0rolCMuNigN9HLX2z+YeWvw5iL213oJ6h/Do2AzD8fTrHpM49ujLoPRNYxY7ui/qBV1YCkwvUwnWN0h8Pe+hY2r1mthDxUQ3gsrCUSE3J8FayFZNil3/NGBCZflqBIkGEW6C87EFJ48qxzUMM5pn7+ei+/w6xpzcGE82LbGbDJyskcS25a0FspmIfkUEsyKMTl6kBjqRyFcic5RU9kZkosI8vxxfrob0Gl7Kvo9XQq8ASLfxdKByRmhb464iFW87qaWI8YVpXoWv30qxfTr7DZbk3QP/H03K5eVqdzRyh+15s/Sh833HxvIvYLn6cydn68QroYDiK2ArqytRP+zJ8jw5phM8VktfFbVCYrZNgy5zX8VEX/7LFxHHTiL9ONdwN3M1mlwBa6beCAcHCshvn9yZ/3MHQDDDYHyqbBa4waZTZaNDu+GcOkpVmFpA83/JiCMsVUGz45O0RDR2bKlgN8TJrAgG4zXb3t+4jN2FUYdw4ERdKR5vOil+CrNFDCF28otQnJn3lSSYtt/d0cNREfkfXnr/38dCMPlItKtDmRbReAP0B2hD0zHHDUsEU2tjbwt+HKJqsuIgfIk5YlJcdWR51iYHQR7Qi+9l6M+cn4o9WCQqLq8oXj1CbNNR6rXqhwzFQdlXApff90a8M14WkL4UQ0QbttU9iAe3zJhs8Io2cKD/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(70206006)(70586007)(40480700001)(8676002)(4326008)(6666004)(81166007)(966005)(478600001)(82740400003)(356005)(16526019)(110136005)(86362001)(2906002)(26005)(336012)(186003)(83380400001)(7696005)(54906003)(426003)(5660300002)(47076005)(36756003)(8936002)(1076003)(41300700001)(2616005)(316002)(40460700003)(82310400005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 16:42:26.6167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10bae81-92c5-4a13-9bdd-08dad93b3097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2->v3:
 * Add Hans' R-b
v1->v2:
 * No changes
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

