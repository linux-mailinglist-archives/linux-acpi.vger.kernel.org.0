Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC127485953
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jan 2022 20:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbiAETjd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jan 2022 14:39:33 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:64480
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243637AbiAETj0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Jan 2022 14:39:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENZ3xfRD1wKcUNP+qYDZXfHbO6Yz2djP4/gXLzhMFJWrVZDiEmruv4TgYCXZ0hbsyb6+wPifaXL7aUSzQCSfvKv6e0B8XWGB/r/25J8/BhAPGZ8P5VEzGID16hjJM0qAgYbq7MBU4OD9jdLILPfSdYvQENIO4lDhQvDv9Gn1lRoi4Jelh7chceUnB06CoJ82KQiAW+xdrItbVD/2iOA3HRsKgAs0bi7xuiT4b0KNQVkizM3Ux4Q4u6562EmNB9nfRUJwKwsW1HOfosZEus/g+aEbK9jLPBRDEIUQ0BBvkydUINYC7Fr6+uw8OutfSdcHrYUQOYeqq41eM0cI5ijsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUrtyua+9vr6MOy5LGEurzBGq4GVpy9OLs6KqgRe/fw=;
 b=balMOo9w6anAXvGSzhJwHAaIljX8ZP6zC2hYLAij+KWtEunu5zN6uF6tEIsCDwiZ4KGX44Qz1rSO1eBvhxd0DZ41dQbF/L/YRp5yn6TLW+SdWfktbwSSMerxibmsMbwHaogtqlLRkaak+gg5ntcsIf4wUrMZWFlDjo+Qzaz+WXxwyez9dN+XPY1UBLV2HC9MlUTy4SH6J10Qmxb7WJvs9b/oXdrqrivxj/3OGjj7hpJrircfwrsBP+7622nhAM/mTqJeBMt77Sf8lF7l3dKsF/xktFxNNgp6lrX1M9gukjfhxZxRlXAY4JGO9840UcDRrmxxDAxdUJTytlaxquBABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUrtyua+9vr6MOy5LGEurzBGq4GVpy9OLs6KqgRe/fw=;
 b=bOOhyn6RC6cp996VAuEfwHODp3muh4IYXf6E9Os5nOuoHw7X8qAa6UtNmH5iXvLNj1lYh++o0ceOQSxzMDIcuRk+ZgVFlXoxAZe9NH6frFSRE3h1CywouOf3FtwHsP4jKA596bNesKhiTYmXNG2zZ887afwhZ+Y0cDORZKLshoc=
Received: from BN6PR11CA0062.namprd11.prod.outlook.com (2603:10b6:404:f7::24)
 by DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 19:39:24 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::13) by BN6PR11CA0062.outlook.office365.com
 (2603:10b6:404:f7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 19:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 19:39:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 13:39:23 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjoren Dasse <bjoern.daase@gmail.com>
Subject: [PATCH 3/3] acpi: sleep: Don't offer s2idle on AMD platforms without LPS0
Date:   Wed, 5 Jan 2022 13:39:10 -0600
Message-ID: <20220105193910.25678-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105193910.25678-1-mario.limonciello@amd.com>
References: <20220105193910.25678-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a8f8a1a-4d67-4686-48b0-08d9d08313df
X-MS-TrafficTypeDiagnostic: DM5PR12MB1705:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1705248A1F05E499D3E5C9E3E24B9@DM5PR12MB1705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVMSiKGscuNS45TFaNoOP+sDwgkMXuJ4SgF8RcS1xmkVoOKy/QnPDwHlT+0nnSxFs1mzfFIu+n8U+jgRNDDdhFDkvXmd33xUGchuQhMXQeeQrt/MmQClHvGBRRY2YOqKSUIWmS8NtMKxhQTAZOWnK9lGUijuVWGYdqU0dAx4wouJ1tFMLHBDu8ZEwAjqIS2U2yutb+cc1HCvGLSTaGodoFfXHcH0iehI1IjcRiNmBFTIPi2eqRP0ZXIcE1c12JeG9Us9DnbyIIdwlwCJFgxqrYoEQlzt5xk3bVIDQOHG79NDIoIHY65B/LNx2yWjkyAjHPzp22IPv2Ykz20W/zb0S/eWB02YHZoFOXKVdgycH2mkRF4jzPG7Oe/bWBxvTBjrvwPzf/JNUjGA4ZB4WlfVEhZxco0MegEie0tUcH9G6Fdi7oDzNROMnZP4Xn6zarlfktimGFcjfkC27jQ4fYA64FjPDCZTsbEBgNjjS9ch+8cvaQBmV3fy5HFxIFfJAyiLH1IgIULmIodBk+s14AuxtyqGt2dHcVekelz77FHZplggIxPQKm1NWWhw8mJ74HWVYaJGdbj0QBNVRVyMKLThpNPx822Q0KrEI2TR9s5fsNTRF2PipPkVXRL74xzEQruEYrcn0qaMjyuiSUz8Bu9XVcwx8o/qsKWJxBaxTYcrETMfrSHSYgzWLyb+GSgop3ob5hdYlq/XdG0ggGZ/aB6z532lGIKYr/tF5/47IOcWFENBSXlz1xKavJpP+6sMuQApnu/k2FB/l2y0sZoVJRPmjyQqZP3RMM+ymAqLxlY+EndB0wkL36pFOVLOcvf6gBo5E3KTVyQMlmENjl1uwvoR7TXJ61yCBhsRzt6j4NXSYnegawnAlf1ylgDCeU6bOj/w
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(8676002)(44832011)(83380400001)(47076005)(40460700001)(186003)(36860700001)(36756003)(70206006)(81166007)(7696005)(8936002)(26005)(356005)(2906002)(966005)(16526019)(86362001)(1076003)(508600001)(5660300002)(70586007)(336012)(316002)(110136005)(6666004)(82310400004)(2616005)(54906003)(4326008)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:39:24.2016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8f8a1a-4d67-4686-48b0-08d9d08313df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some OEM platforms a BIOS option is offered that will set the
sleep mode between S3 and S2idle.  This option will change certain HW
behaviors.  When in S2idle mode, Linux works properly. However when S3 mode
is picked but the user chooses S2idle in Linux the platform may not be
properly resumed.

To avoid users getting into this situation, don't offer s2idle on AMD
systems missing the LPS0 device either by a BIOS option or by using the
acpi "no_sleep_lps0" module parameter.

Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215387
Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index a1626737e5e0..c3d35a42ac2f 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -363,6 +363,13 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
 
 static bool acpi_s2idle_valid(void)
 {
+	/* AMD systems must have low level firmware support */
+	if (acpi_s2idle_vendor_amd())
+#if IS_ENABLED(CONFIG_AMD_PMC)
+		return lps0_device_handle && !sleep_no_lps0;
+#else
+		return false;
+#endif
 	return true;
 }
 
@@ -450,6 +457,9 @@ static int lps0_device_attach(struct acpi_device *adev,
 	if (!acpi_s2idle_vendor_amd())
 		acpi_ec_mark_gpe_for_wake();
 
+	/* reset these so we update valid */
+	s2idle_set_ops(&acpi_s2idle_ops_lps0);
+
 	return 0;
 }
 
-- 
2.25.1

