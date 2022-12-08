Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB077646645
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 02:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHBJr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 20:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLHBJp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 20:09:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6609F8B383
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 17:09:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMepFltpRHcdEjIe0bd4YyEhM07sfJmA6FZtqLhUbQv570DY8Sz/Y5ryNu5DIk6BF9EzARjoaBnGmK4Qxs/aHyfw9bnwXnnYXSItvSJ6kX1hSidiPRT2OXdsCXyj9ePG7ft2fqY2X3NhVPeBEzoJ1najsqUKXDo9CC4cQ6mt9Eh8h0FjMgnCVp1o92ECrQZbWPbJRmK7fWZ/ElPrMea+VIAMcPKe3NtZMdK6dlKHSXRkCdJW/46+ZEFIYdzAIR57jzAh+gLrBT5i7JOcUg/+L2Fq0ooxGe262oCAaGTaDZ0Kva2PrqrEsl5ne7efsA1xZ2PTaXKv1BdgVNDoY6gPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y3Dug+Vf3qRWQgKngqx3hIKZWxmrS9IvLJ4th8FhAI=;
 b=NMPsiLpoLZt1jGUPp+DIxPVl4zB0BtZrBxg2TF+lJSgzWwlVonfIvm5gB+KMuO/B3HbBNWtPpjTkYYPl0s8R7bAjuzu1ofyIvzvHx/t15T2PEL8iN+cXBM9jG3t4SKTNtGe6CPxBIDA/YOFwalsruLncw/dGwHpcd57i+Q4awmwL1lK67EAfX1fiy8I1x+skZn8cAoWU+z5T+iAMh1SUJXrtVt646aNV1KnT4RgS4JK0voYmkQsHLlb44Z16sXJ6FQM9UyDQr+HtX/aD1c7bOkYwSRNorcr2vN6xuyMo5tGZnUos4tvh8CrYpgS2TWvSRp1BxvSf48N2Y6Yj6xUoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y3Dug+Vf3qRWQgKngqx3hIKZWxmrS9IvLJ4th8FhAI=;
 b=qb6wN0alITFZwKNv+xzOiM2YDOKS9Lo4zFOw3zE8I3RiE2nmTV0YAe1g06gVfRXorlb/c5OWMlooRc/me0AqyHpBAwphz8D/jrHIErQg60fBl4ihp76ZzR9ft9WBBbKi5BIjLhVE7a9GyoxBGb09KnMMOO7RQ2lfw5F3tFq6NIA=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 01:09:41 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::f6) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 01:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 01:09:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 19:09:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/3] drm/amd/display: Report to ACPI video if no panels were found
Date:   Wed, 7 Dec 2022 19:09:09 -0600
Message-ID: <20221208010910.7621-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208010910.7621-1-mario.limonciello@amd.com>
References: <20221208010910.7621-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 50aa6e6c-ef64-4f8f-624c-08dad8b8e276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdKfOP2HDi03WGXXTSF2hRmrpMASlpAeBEARaRbkcS2ew6CUITUG4Ed8umi5vJDHpqEDtUKBjt+9nlpmGm+bUJO1qR66O9qc0z8gD2IdKDwFc1AHB/V8sIRMdqvOEt94cMjbtJ+B+JAPpVdoCunh0ZXCxhzwMet8zNoDAiQc/1i629rlyuNo4RVPCKDuLeGH3kF3xCpjlIU/t4KknXXr3SfM3+VhNbV8EJ5p1VsypxKFexGNNHXUy4lH2O7AB/mWMT/GZNlqDKj9hcy2XCLegKgcL1d3Zs6vseJ/xIiCfgdZdA7Zq+ni81PI2WePoi5jR/wXieVauCnIdkNQt37OQLyTGT1VVSHmYNb+98cCnn7MsM06/AGa5V/CbzVuoy57SoqscGcXAiwQvMnbhcBPwHzfhtAK8jfjQdFbZv/pBgCJiphnZaJ7wFAMZuMVVwbX/DV6ZvJU3LS6YoLj/L5j1KPdalpX4LHZ1HuG0Pia306wZRwyOlXr/gVFBDHIEa0HnmPhmz35pMc1El+eOn8yJP5BpgMkj5WwCeDuGS5R4YKhvCkxT9ePEweT+a/ZV4kvmGtCv8CySuQQ+lPs6ZaXUxQL3Rs8tbrYHm8q6i5gXOAHGSNMaloa/qL4vXWLPJbWN7u/jUjmj8jKukNq+hc73dw3TYYhgNK2N4yqeY4wrE8AV5OaO0o9KzyXYy41IKnwZzmWJNRBwzITVIwNsfaeUuU2sY8DAG/t2KtT2a6BM3g8eXxQMDbgNvSKxcRvLi9W1YBcp3bbE7oHGK3d9/t9YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(36756003)(82740400003)(356005)(5660300002)(8936002)(82310400005)(41300700001)(186003)(47076005)(44832011)(2616005)(86362001)(1076003)(336012)(36860700001)(426003)(83380400001)(16526019)(966005)(110136005)(54906003)(316002)(2906002)(4326008)(6666004)(40480700001)(70586007)(40460700003)(70206006)(8676002)(26005)(478600001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 01:09:40.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aa6e6c-ef64-4f8f-624c-08dad8b8e276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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
v1->v2:
 * No changes

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

