Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6EB4C4E5A
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 20:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiBYTMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 14:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiBYTMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 14:12:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B128A20B158
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 11:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEIs2NoGNgWbrpcoIH9elWklkPEksnHztRfA9c4SogJWcy/8JM8kwT8Hi/g8iqojZtJfCXPkWASfoVeJAfQyxgLzbz/o6v9cjEqGACji9fNW9pDk35e1anJoVX1VXFEbZy+kw9jSPSmNf5QdZXtw+vMAoYqdOeFoop4TKC2yVucB5MgsKaN1jru3XecSK/R5PDXit5xG6nuGd2F+nwkb+jqHTK67pAJjYUQoxxUm1Ztp5oo7CABFUt6vbeb8UQSpbcnJpG2GKBE8ZVP02q0mfSB4vWsdGEeF6QXvw4mXLXhmgNJsxplzidYQ3sBC9/H7dPHQkEVUK0G97HA2G4ztZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFNwR9HA7cfXXcR4TFqE26sXJ8hX3VdOUfIl8Ta3Cy4=;
 b=E1eBfOeWAdPAHL/K0iHwRlJArXaR/iyX8ERtsSkBb0J+AX/yYZhNhVKr+C54HjJK2oGJZv7U9L4StcVloNHIMBnCbiGMBKaagOnVhKscHCk7Crj88yQWMq5mSEWXbtb3Iyr6JuyEWChSdzptxgEhAkbu5SslQGG82vzlzXnvcL92WtAxOB6C4Vr7JyxCxCXCSHvRvujJX3GMB4nvhOknIJfNQrhyk7wUmAabNxwKliDhGEN4iyxG/KiLLKJ93HZ5pA6g6VeN/bBl8QHsjUQ6grjXUHpzE0tCuo1iPgtLOdYGmDLbtlAA5QSgcY4MA4MdsK0pMC+QPIFBKQv9TvR42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFNwR9HA7cfXXcR4TFqE26sXJ8hX3VdOUfIl8Ta3Cy4=;
 b=IXLLacalorUpo8OQJvH+qmeK92OuSfwqWxzuNfq40MblezjcLJU3D4uSlund/THqH7v4L5sHXg6sLI1efS6Gpm/MQ7o0ms9sgJd9AZrsywte+A0c4v9mrWIXF4rfKZAQfL0CNdGOkzA8iC2KLFVQ58Y8UYWPpmmBywTpQ2b7zj0=
Received: from DM3PR11CA0010.namprd11.prod.outlook.com (2603:10b6:0:54::20) by
 BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Fri, 25 Feb 2022 19:11:27 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::75) by DM3PR11CA0010.outlook.office365.com
 (2603:10b6:0:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Fri, 25 Feb 2022 19:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:11:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:11:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 1/2] PSCI: cpuidle: Move the `has_lpi` check to the beginning of the function
Date:   Fri, 25 Feb 2022 13:06:45 -0600
Message-ID: <20220225190646.1045695-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225190646.1045695-1-mario.limonciello@amd.com>
References: <20220225190646.1045695-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 983be2d5-cf8a-4314-fe21-08d9f8929ec8
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB23886B724AFECBEC0C486A8EE23E9@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJ/I8YFDiDaZint8Fr63x3jKjTevRieovmYA21SyzV6w4/WUjmpIR/MYqviOIL2BRbCrJN0PJBE2pGDp94U4I7Ug6QU/7rkFteUjvpQwpg63hdcVVPf36HqegOIoC3pTy+qzI+LpKO2pINbRCa9v3+ZnJeaPV2OnvEXCRenN5tyxN0mkUgdfAxeB+RVx6wMuiVucJOLURU+qrOLENcSXZoku7BqjM1dcZtsmQcU00CQ8qoKSPGL6WjQalXDBddC4K4cEuMf6x0///Z/6cvzmrp/qmpDI1Ei5LQ16Dqs65aUi2p/p/X0gfiMF49SDMRf7boB1l/5V5tvIzVaapBu/es2QH1wRrc1VQ58j2hNpSUG0UVpq4cgHqTDvfATs/wVEfCoK1Qvm+J74vaqT+3FaR7wKA49k9Qw2zWpXsLi073juNyt7GxqIzQe+4IQpz+P0rxAJ0xk7pR8DmIoUFcSwAKCo+T5CiYzhv7KHbacoR598+e1M0yijNThnpPvPnSXsm1YZI4i2gTgat2nZA3MIqWbKsHUBdGpQ3AuRvPN64Fny0hDPzbERhLZ5hjAWtn6OJQeB1Qj7Kq849u+aWMaOqdxW1lFLt8BiBj+wqre8EQ9kCE6ZSd913KkKGbV73ONl5qIH8RfWceo+HH/gLEL6uh5qjI+Ev3b0DPBOIncF9sUbEfbb9+7YLKuI6RPajljRKjPj8bmYpMbWFMmWRSlhHK+XjFz2BWy2KfGFLpC30TI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(40460700003)(83380400001)(26005)(47076005)(1076003)(186003)(16526019)(336012)(426003)(356005)(86362001)(82310400004)(36860700001)(81166007)(6666004)(316002)(54906003)(110136005)(36756003)(8676002)(70586007)(70206006)(508600001)(44832011)(4326008)(2906002)(8936002)(5660300002)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:11:26.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983be2d5-cf8a-4314-fe21-08d9f8929ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently the first thing checked is whether the PCSI cpu_suspend function
has been initialized.

Another change will be overloading `acpi_processor_ffh_lpi_probe` and
calling it sooner.  So make the `has_lpi` check the first thing checked
to prepare for that change.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/arm64/kernel/cpuidle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 03991eeff643..3006f4324808 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -54,6 +54,9 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
 	struct acpi_lpi_state *lpi;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
+	if (unlikely(!pr || !pr->flags.has_lpi))
+		return -EINVAL;
+
 	/*
 	 * If the PSCI cpu_suspend function hook has not been initialized
 	 * idle states must not be enabled, so bail out
@@ -61,9 +64,6 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
 	if (!psci_ops.cpu_suspend)
 		return -EOPNOTSUPP;
 
-	if (unlikely(!pr || !pr->flags.has_lpi))
-		return -EINVAL;
-
 	count = pr->power.count - 1;
 	if (count <= 0)
 		return -ENODEV;
-- 
2.34.1

