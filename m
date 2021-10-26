Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C7943B8FB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbhJZSIR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 14:08:17 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:22784
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235285AbhJZSIQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 14:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7R3FMQJoMPK20pGO24vbVjYb6KkBh/XrPSM0dGjJ4zFmrGOJZuJCk1SvWgUDOnHr670BYjxkwi9lhLTsrjes7KKAQJsC1TdCoAT1h7PEWsbf/RIWWpmWcBbuZtDPrlM0lUSoTi62ODX0Fmp0ag5jcgEK8U++AOO/UzolddozBYPqX3YHVxWYovPjDigNFuOrdrVUYzXRa1jE9VMhDT78ImOjP/P56PnwD4Vu85jXJcf1sevhjeKHdeaJ9FWEDtX4yQbe4JjaiXc4WFy/y9w3tMnvyYqO5EHGBilZ3m3mofFmM6M+2J6k9imVG7l2PTJBiAAs/61hynzHGHasOB/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFXyanS5qIJCxEDQK8/CI/S+tQfLvHHL8zyRDL4b3TE=;
 b=BQVk9gleLSBaAp7jFiXvh29+WiJdsGmh6D5fhym7YfZmnQB94jPY/X01ltG3rk04vEIIyCiR5x6MGv4Hrm+5skMN7UuAnd6LY+kTlBLe2BAsBHMLdDuyDELv598v+gMlJM/hPy2SOpgwBlyO7cB1xAGBECz+eFC7YFl4oltLohDgMHF9PJqAP93R/3WgtoQ1XfbS/6nPo9Dhyd4Q2hJuaezh3UJwAAvNcU2gqUejJvUvWV1J/fYSL1k923HnytUHhlDA13PP4D4n3Oj0/w+pKbvB5x7enloHB5N+k5L5WZ/mTfYVAEOXyaIzZy/nKtqldgrrGlmFhCXC62C08kdurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFXyanS5qIJCxEDQK8/CI/S+tQfLvHHL8zyRDL4b3TE=;
 b=ZSq2JQSwbkrTw+4Lw8gJN8EIw/RXrbPfK7gRTsYlJwxiVm1qn6oPebKaWw1GAAr++lNOVysdKzy92Asuh8t3TatvnO2HkD+ODQO6fLYprC2rImI3BFTJ3WaSZwY4J5DcXCTh8JFgcIYJ0UxJTxAWU4lu82qCV7gZE5kVeO5qeYg=
Received: from BN0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:e7::18)
 by MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 18:05:50 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::7f) by BN0PR03CA0043.outlook.office365.com
 (2603:10b6:408:e7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
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
Subject: [PATCH v3 2/3] platform/x86: asus-wmi: rename platform_profile_* function symbols
Date:   Tue, 26 Oct 2021 13:05:34 -0500
Message-ID: <20211026180535.9096-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbe34b1e-ff5c-45c9-0a16-08d998ab3ec6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3933:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39339BBB239253DEBA8145DBE2849@MN2PR12MB3933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXUri7ID4pTpvellAO+ZcrOeRVWQOz7PbWoUaOJxb436+cu8+PpvfvSr7eHX0KZxULDjHfhOabRztg6yJ0WueCjV+D4GCaUuuPBCrUeWwpAwR3VVL4jPgMY85cRx8OUcisd8+oG9Q5KfIyEfNnZQJZCDffA3QG3GMXwVfzh3TRhnv02rv5K9axzwoXSgTXyoWDoy2x1uct/nXiWWJnJh4TlJ/NbHErg4pTBXffCVwq27KhSbeVvmdaEiyv2OHYLGVLO3DoofDgusG9pnATSP/P80O+NfQlJetGEjc4ZSr0we9VeZpKrfj1v+Bt8IXyuRj5J2FSC6aq05k6LykHwuui59GtfCatSgWHeW5e6E3CEKJckX1PNEM/gc+BivsytncUZBp0Wi5EpvskhJYsPvVCWr2uBdkJqBCS1EIdKUm7zs5RcSw/BXBjlZ+gRVWU1k9CPvu92AOorKnJnDf/DbWYIcnznQykDYk/6MjycKcNGz3EM+V+HoikIhRz3/cMaPWZwZIXA0B/B0o5oTil1vbXVoOpBfxECJ5SF85vYQqXpdrbT7G1NNhrjZxZE84JcNXq2+NbAnK5WqGMu/3ryD6Zsh6tVcQprkOcTmXA4WQsmwcVM2WJDbenJXSIMxkqMZ/ave7STHGsNNjEGlkm3ODyaBhWqdRj/tjfKw8qLDM1NKw5jan49xiqQqbBUzXEYnmPd28eUL6YEiNZsZ5hAO6WBv65ok1lRbThcLsBgnoM0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(110136005)(86362001)(82310400003)(7696005)(8676002)(426003)(336012)(316002)(508600001)(356005)(54906003)(6666004)(2616005)(2906002)(47076005)(81166007)(70206006)(70586007)(83380400001)(16526019)(5660300002)(186003)(36860700001)(36756003)(1076003)(26005)(44832011)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:05:50.9191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe34b1e-ff5c-45c9-0a16-08d998ab3ec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3933
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

An upcoming change to platform profiles will export `platform_profile_get`
as a symbol that can be used by other drivers. Avoid the collision.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/asus-wmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e14fb5fa7324..8f067ac4e952 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2169,8 +2169,8 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
-static int platform_profile_get(struct platform_profile_handler *pprof,
-				enum platform_profile_option *profile)
+static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
+					enum platform_profile_option *profile)
 {
 	struct asus_wmi *asus;
 	int tp;
@@ -2196,8 +2196,8 @@ static int platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int platform_profile_set(struct platform_profile_handler *pprof,
-				enum platform_profile_option profile)
+static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
+					enum platform_profile_option profile)
 {
 	struct asus_wmi *asus;
 	int tp;
@@ -2236,8 +2236,8 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
-	asus->platform_profile_handler.profile_get = platform_profile_get;
-	asus->platform_profile_handler.profile_set = platform_profile_set;
+	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
+	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
 	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED,
-- 
2.25.1

