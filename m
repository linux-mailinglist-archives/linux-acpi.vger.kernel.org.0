Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9811C43BA60
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhJZTLR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 15:11:17 -0400
Received: from mail-dm6nam08on2061.outbound.protection.outlook.com ([40.107.102.61]:59621
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231531AbhJZTLR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 15:11:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV3MEKwmeC3dOaNlph3tQLLYMlCqarC/gtlv7bIioS2pi3NmGBcfV5sTfe1ZTTysbQbTAwgZLT8eUjCR+66G0OYPnXw24tbnf7jpUm4VTXjvGvo2V3C/TC5L8BvLIthzZyBRemAS9hZQNO/atkGfX5K5YZWbNeHvYhFJe7ghSI+BbnReQY5dwhq4pvMm1N0eI5CJuL7As0Bgk4v1TUeifYKc3f85+GJLMQYKC4SB2yHZrDTxqv2uYiyHJylaMIRPL3gQBJvZa5nF5Yh2QUIH5/xr2Tqjvof0kBe8ROPTiHMP127W2e0XvKmzSWr+uM00tdM6s03M439o4PgQoKXb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFXyanS5qIJCxEDQK8/CI/S+tQfLvHHL8zyRDL4b3TE=;
 b=jJGuH9NkXCkEXEXoYEycW8vV9AXaPXSLc0yu1jd/FJ4Uc+o9mfv67iMi7qule+coTttix+2ONvZtC7uMiEf1pQXZVC/LV5OdX3zYu9xjqAg69oFbxvXXkMYXUJOsjzDFJu96EfLfElCzWGdb7C6NJtoqQziTZ59t2ugsSzyvnrn1qao38ckDzZ36/7dJRBHS4iRh7MRp28ulXta86cSellCY6xymob28EKr6fKiLrADSvqdJh66ch6AeN0uniueMFxJopoa4LjWgiLFydP+YnXFtnFV+H6N9HP7t5YXJ8rn1hGTktdFqbC1XjW7Y8aEJDpGmVOFUrRQvhmbSOiWhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFXyanS5qIJCxEDQK8/CI/S+tQfLvHHL8zyRDL4b3TE=;
 b=K4EFvoN848ylL4eKYVh/Mxjd4zdp1vRE6SDmYvMK/hpU2y7clfAAKApnAwYwr4+znoMx4EQGaqV3Lz4sI2L6v/d0XdoneTAxCL84U0QogLyXbiHELSYgK85+ZsU+0hleUfKaYwbdtFrBBFwtRc4rt5yjHtMeQFlw0U13cXGKoww=
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Tue, 26 Oct 2021 19:08:51 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::8e) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Tue, 26 Oct 2021 19:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 19:08:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 14:08:49 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <markpearson@lenovo.com>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 2/3] platform/x86: asus-wmi: rename platform_profile_* function symbols
Date:   Tue, 26 Oct 2021 14:08:34 -0500
Message-ID: <20211026190835.10697-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8aa6c99c-fef8-4c04-ea53-08d998b40b61
X-MS-TrafficTypeDiagnostic: DM5PR12MB1546:
X-Microsoft-Antispam-PRVS: <DM5PR12MB154632EDF88447837EEA00D1E2849@DM5PR12MB1546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87gT2C9QjLEfCmDgW8ALAA4ivF4sj9+P38xMEKD7SqwTv9h55DAvSpLbnjaXujt14SRtWGf93v5mr+10qadNPH90wx/LiPwaZ90VD8aFfaliQ/qUHmC9VXqtg6RBAy+IE6iWn29pHhSPtYQe2bVqNbojnk4mCOACdaBa4VdvZ1PHntEwYeyxHnm2rRCbTlKl1DWgtRHF0x/414/jfi1pQuGsdHM7sDss5so71d/9sTCBvm0Oe97LUoGGXi0qY46Lt9AkQxI3ZUehXTtLuQQJD4azzs0i+jhrUyoa4+snAK5UU0q6Gy72bgzELqkiATqxulMFMjN4MqeG0T94kVIma9GF74L112FMQyX8kp/BOaD0D9/y76pxz5KFS/SOepZsZXQeMY6pvCr+KWAANSZnX64HQeEK/Iclo7otB2rw+6MZe9iZ338nYV44Un8OdVfCfwIYGEO8lBXZGdQoPD1lRJrlE1f+v5h4hNXK7s6t2MStyS5p/l0DH+yTSucuN6OO2rWdM5p7xtYcu484YEefWdBaPbQElv0ck0L/Hg4/XJKEMN0BMFzKKjLxOdwDUHh1f5eSYzTL/Xl6mVt/cv9HHcq09nAuUJy71LRLVkQ8EbhAsZalnKI8Lu/KRns0zjzSyvbvgSOyKNe4ZF9icSEcCHLkAapeG/kD0b4MBqZDGYTRJHfTCOMKNQ3/uAq9/uLn6+aWd3HGfV2ZqvQq+vphwreSqGwb4bQeiGcFrwbtX7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(336012)(26005)(16526019)(36860700001)(508600001)(47076005)(4326008)(82310400003)(1076003)(110136005)(81166007)(186003)(44832011)(7696005)(36756003)(8676002)(8936002)(5660300002)(83380400001)(356005)(70206006)(2906002)(2616005)(54906003)(86362001)(426003)(70586007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 19:08:50.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa6c99c-fef8-4c04-ea53-08d998b40b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1546
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

