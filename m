Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED7F43BA5E
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 21:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhJZTLQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 15:11:16 -0400
Received: from mail-dm3nam07on2089.outbound.protection.outlook.com ([40.107.95.89]:43777
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231531AbhJZTLQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 15:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV9JyG8+rk4GVmfDjLiRR/LAAfMzKReAFNyMh9O5Uh7gBMDqz6o28t2uGDe5VW1okKyf5K7n+s1vz03nEqDIsLIGt8HnaJJVRAcBh2AHJoghk/RJrYfSV0XZfM3XL2WeKXlJrfz3lvWEbxvYatcE+wh03Y/fpC5qleFNyUBSMR5dHnjSewBySu0RfRCRhQrxrQipFFkSEP8pkgXuNyscIpbaME5FWP6lYKCNhsA3oGfd80ihtNM5qIyWSdaz/OCKtHzhUsOKQxHXmJ3cCPe+OSKZjmYKeB0kx83wdPNbiXZACRwJ2pJHcte7CYSOdYOd2CgByUM91sE8WRm+M9nDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeF7G1pgoE3Ng1jcK7IffFPRROYm3Cw9dBN/zBLIgUw=;
 b=YyxJVKclx38eNoOK1d1M4CRqzq8Yotr23Dbz2jgo8pUHRibKqtlI1x8bslQl5jhhjUuHAykogI5bkeX4kSLBA7MnQNqJTiMH1wGKBrxSBFhPgsje7dYI7xfYvpLPF+/6pPRoHGt737eK3nibJQlGnnJtwkUSrvElcEsn5gpJVStNCJ4g/vdNY7TONz9NakAUgkvM+SUMP6/tl+ooqmOcyi/e9b38qJBZGWRDcvSqnv9V1hYcTzhboQz8Cov9SuVVQOjWQ/jf2AI6uEVT/7cO5FnoV4RJd+Iojh83GxhyIu0OW9k1MUqx6kSVhRbNdEJar6BuzIrfdQmrshK0dp2F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeF7G1pgoE3Ng1jcK7IffFPRROYm3Cw9dBN/zBLIgUw=;
 b=T9y5gyEukXwGfB8XQ/goLMzp7pG4V/VeIF40/42yXUd+GKDCLrEvre9LUSG48VS/reD1Vn5QJDfN/TZx/tydqHrF3MUx2m/1mtgtsAJoevjJuSYZIkJoRdAxlU+E2AIJzpJ4nIVZ9GSlH64GGgeA5kWcAQldlbZqzoDEkP3f/H8=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 19:08:49 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::8a) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Tue, 26 Oct 2021 19:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 19:08:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 14:08:48 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <markpearson@lenovo.com>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 1/3] platform/x86: hp-wmi: rename platform_profile_* function symbols
Date:   Tue, 26 Oct 2021 14:08:33 -0500
Message-ID: <20211026190835.10697-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026190835.10697-1-mario.limonciello@amd.com>
References: <20211026190835.10697-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e53b228e-8992-46d5-cf5f-08d998b40b30
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:
X-Microsoft-Antispam-PRVS: <BL0PR12MB238824AF7CC40794BC711761E2849@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0570HhMeiA1tLxXJW9J5ZZfEcUnl3xyZV0xvxhFTWYOs/KUYlpjq5d/foE70dArgRqaz/jOe/8nDZbCcaM5/d4AyoBTgAGc55x6XJqhriWKL5/uDPeiFLdKvWM5p6hRlKFI/wfY5GWgfPzarOF9/Brh+y+fo2L7HqB3NtRFwha3qZME4Y7Ugf4Jk1hoIr+fKi7eXUKdWam66CX9r3hvAhjy4jdb0sl6ikQ8nQ1k5h1LVDHI+QYI+zN9egbTJR8KthegQO+YnJzB4H2TGyAaYLY6bsNabw3erpe6Gqkq8OGp9GARvbW1ozh6HEiwybyufCkOeuB+8azDjhIaxCPKRH226FWuETxU3UVM0zmp1bsNleDuzrKoPqGlB/C/gwMuS3CGktN6YyVk4DDj0PsxBg4H8Ctdf7ZGOgcNSodzQiwlPxIqvuTo+ZqZ4YzjC1FW+f2lDzzFiM9VyJCoNdxHnGYTM3O9E4MhOkRs72s5axTLwl92jaD00VjgsLVGgMX0qZaHpMgDaTDjPHHGW8rMK0tpyhc/h/H1aKuTBByTOqxXSzwMWtsydlIci4D4i0TE/OBH235KqtYGrXMcyxcICTjvLE66gXIebSz9njIsCuOe8JAUQaRxbuPkTIUqJ+kdm3h51EZxeiEkYaT1ExcqTlzb9WORLg8u0bP6nnLnw1CROWsmFOP0/AzpHJUwtQSbHHKkIbAnvkiZC4JPrlnPHcEJhF1u5yq+hStD4uthJW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(7696005)(5660300002)(8936002)(426003)(2616005)(86362001)(508600001)(2906002)(47076005)(54906003)(26005)(36860700001)(316002)(356005)(83380400001)(36756003)(70586007)(81166007)(6666004)(186003)(110136005)(1076003)(16526019)(82310400003)(44832011)(336012)(8676002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 19:08:49.8479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e53b228e-8992-46d5-cf5f-08d998b40b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

An upcoming change to platform profiles will export `platform_profile_get`
as a symbol that can be used by other drivers. Avoid the collision.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/hp-wmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 8e31ffadf894..48a46466f086 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -1061,8 +1061,8 @@ static int thermal_profile_set(int thermal_profile)
 							   sizeof(thermal_profile), 0);
 }
 
-static int platform_profile_get(struct platform_profile_handler *pprof,
-				enum platform_profile_option *profile)
+static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
+					enum platform_profile_option *profile)
 {
 	int tp;
 
@@ -1087,8 +1087,8 @@ static int platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int platform_profile_set(struct platform_profile_handler *pprof,
-				enum platform_profile_option profile)
+static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
+					enum platform_profile_option profile)
 {
 	int err, tp;
 
@@ -1147,8 +1147,8 @@ static int thermal_profile_setup(void)
 		if (err)
 			return err;
 
-		platform_profile_handler.profile_get = platform_profile_get;
-		platform_profile_handler.profile_set = platform_profile_set;
+		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
+		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
 	}
 
 	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
-- 
2.25.1

