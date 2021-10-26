Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60D43B8F7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 20:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhJZSIQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 14:08:16 -0400
Received: from mail-sn1anam02on2056.outbound.protection.outlook.com ([40.107.96.56]:41109
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238026AbhJZSIQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 14:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE3/vy1GGoqGrWgEYXYAE10jsv93d/Xab2GcVbfsLMvhvkXM+rc7FPPVwjnCXZseTU9Zg3jeFcfkYNlwSH/OjbT2UIXsW64hgLQXyf5A/sgajgn9BEqyFfBJDJZrQaz1NfMbhuNE4BzFz64nGRzEfVay5jCgVGsmaKxb1z0HDkNX1qwUx913gjsYQ8Ci9hzAqPcUoDM7uHAwx9jW1fBVlXKNEaan76LmJvsUccR/tDYTnJ+S62mbbsmyx2R83TqlZAk3vok9A86KAkJR6404U6jaiMz8F0f54gcMYca3yE893h1uOqC8AHMgjBL3wzDnjBdbDVylqSSLKaCbqgKYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeF7G1pgoE3Ng1jcK7IffFPRROYm3Cw9dBN/zBLIgUw=;
 b=K/pKHPAbauGXe5zeL2NlmThVteMgIvt5KRvMPBPugZSqqM9wkb+59mJDVT1U6z+6iXnADSnTB5ERaHj/30ROVen5veuYOLwnPM8oOH629P3Z8jEM1beMgB3sJbzlwe8WlElTtzLsGyKTvCMHIYKVuSd3aJcDZwmxdv0lQaINeJYo25s1/HWpfgPjERwXcwRo5Asn8hozw9E7NAN+KvRNj3614cNBePGQnw3sENSsAck3faZlBIxZKTjrV6xzCq5PEvR1HpKVHA2mv0VRE31vT3HFL+Z4hXnZ1KdJ5heHcTWn8adjVq96jYZnlfKYBkhp5Xq2qy481gbiQCa/8l9+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeF7G1pgoE3Ng1jcK7IffFPRROYm3Cw9dBN/zBLIgUw=;
 b=z51cvq5Jk94y8vtg1Hb/bq76RPS2gry3sJ9buEbxqNaE0FJdA6hDU1YnYR0pekMrcvEmWRj0SKa+CqDFYaBsSk1cFn7Ec+h9Ycj4rS1YBPTSWVEtRlWBvv/es/3p4hpSr//3mkFYIziPKO8laGlPgYZFScfwVNASUM5WPYYzTqA=
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 18:05:50 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::e) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 18:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 18:05:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 13:05:47 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <markpearson@lenovo.com>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/3] platform/x86: hp-wmi: rename platform_profile_* function symbols
Date:   Tue, 26 Oct 2021 13:05:33 -0500
Message-ID: <20211026180535.9096-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026180535.9096-1-mario.limonciello@amd.com>
References: <20211026180535.9096-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b85a77a4-cff7-4fb0-0a4d-08d998ab3e89
X-MS-TrafficTypeDiagnostic: DM4PR12MB5038:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5038A66CFCB83971F6C2D936E2849@DM4PR12MB5038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yDpMBHawRFIiv5tmaStcZ3ME6CWZ1YFweUtCcU+dLyh3AR4roqwgIjIeeycrk3moMqv+vfcTT1pLRaBxeRBHKZMdcSARzRCXR9DRpjp3tADLyMBDzVcJUBQcOOZibe7mxfz/kxgzUCeue7SMH8/L7q1j6vfFsBL3PFDiK8ZvY5xg3t5gAkr93MLCwG3RrGVy/M02oQovHMHYha1CSyfijsg4/LYaLEVCpoxTdy15sZEX/r0ImSzwMLEhY0c1+8YuVxRJPmxWimIj0Ey8lg/LHxR/fJ8e4crvyUQx/e1c+MdlkXSNuls34NUpJMTvro8rEBy6j/1Cjjc86aTzcpRg9faOPD7zwYlH+Qni+JF/l+qXxugplqgdhsEYgYJi8Km9YkHwBtdzEVeSFfGXT7p9pUWkcZoR0PQfbXdm026oD/L0JYwcoXHYb2vDBl2YnlwG8l5fyhLNozkkfByXPBpkaklZRWcGX3wPnsZ+HyVUQmp7b2W4K7Ce/ILvHql221x1u1Li63NKKZRjb2BDvVKYtQvAftIAvw4BabRNWaJk8AG7QCCgSqfUvp/ENpjC+fkHKQP5cH9VWhg6JBeQxi6ZLLm7xDmWl+TtMlnjBOjsLvmCmAIk1M34Qm4I2Dd0yLITG8gjuVzfuG3lMg3oAecSOQKKkUr8mu/CbHpWrcbTWPnJSzVG3IUDpJ59ZDkCa9p2tfSFJBRA1f7xfkXAIekUoqCX5CjHEVNeo8qdCDOoDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(8936002)(47076005)(54906003)(36860700001)(44832011)(36756003)(70206006)(186003)(16526019)(2616005)(70586007)(336012)(7696005)(86362001)(83380400001)(426003)(4326008)(1076003)(82310400003)(5660300002)(8676002)(110136005)(6666004)(2906002)(81166007)(356005)(26005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:05:50.5184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85a77a4-cff7-4fb0-0a4d-08d998ab3e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
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

