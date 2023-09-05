Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA99792DA0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjIESrK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 14:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjIESrI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 14:47:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C204DCA;
        Tue,  5 Sep 2023 11:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTPssoOVzTK5ytEW9l2Rv7OHiLd0ThLBz9orFVCDIPbKAFiqc51gRqzH4Qt7wseS3yycCbDq3yQOs1eNryZyRYKMJjIqQUbHwDiqAa1jdjhh25hjGa2SFIwqWuKr0Cegyqp4ckyQBoYTZgIgEfsQ7ImgFnjVzlP0NwDQaVcWBA06bBM8LEIZhyGzVQSRaB3IZf2rXkwXbwioG644FF5YQWisu3Lzf7AU42OZJYkhLRtY4oKHfL6NKdE36SNmxxna3zzn/tAcP3/3Z0Abpv4FcpVtw/VU1KEJQZk32yoID6ZQp0K1wYr0iBT9e5i84EYT5vXxqYDroDeT3KyPlddHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tho27e6ZPLTry52sgHkeluZj8jTFnbbHjGUqdTHNTaQ=;
 b=PamJqlakl+qs6w6vB/iyCZDk1k6G/tp4Kc/d9BF1+3Crt1nyOkUDGPHuD3RHjLKdpwCv2tITRqqyKs+kPlKx9tihz84M6fREm35ZtXZHkjOpHFzDK+Gx2h7s6xjmsLmzREcl5p5WGKT+ebCbj8sPG9s/recL+ZTR2Jyn1lZfcjiddC0fTEkdZIZID7b6Y30a1eVzeUeqNiMjjqnwYeo5X0yEqGJhGadxvUPPVBq1T/b3Nor5rrskqjU/V16jbejkjkR1LIxCSqfuN1TuWU+7dijWnp7PzalrGzpX+7mu9Idz99MzVhVooGd3vQ+ntKzzVfnxoTbfHAjNTdkleEIzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tho27e6ZPLTry52sgHkeluZj8jTFnbbHjGUqdTHNTaQ=;
 b=e4Q5nQKl4RsGBlNYxfFbjtV3HRcOLenxGfC7/x0dHoh4gQrzOb65h8sts8aWb9rumJGNrpHBzwTHYM6tqWxQTmRh7wiqNlE1wxW3KUB++IC072RzcHTgWYuGts2F4sKLKT473XLqEFNkpcddTH4AYFgHqE5r8w77t27cSXoJtdk=
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:45:11 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::9a) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 18:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 18:45:11 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 13:45:10 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v3 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Date:   Tue, 5 Sep 2023 13:44:06 -0500
Message-ID: <20230905184406.135851-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905184406.135851-1-Benjamin.Cheatham@amd.com>
References: <20230905184406.135851-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH0PR12MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: 97219117-65df-4b28-6d26-08dbae403c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICpW6HgL2tKddmcmuZ2ddhk7OW/EZSuAX5fFOBJ7fAytSPZqy/ZD1N/Mpj254rLD+KBjdrmcxu8nhqU3rIjwQ1BMsINhMkQQizzbHY4RWukKgbZ/8aeyYWHs2kEsu6GssfibeMCsXp7XstZn+pHiWxFrRZzLuob6m8gUNG0xc433fypFQAJFGkiNZuG2wxhU90mQitOxYq7H85wGBmN8Ryvs2Nn86KBpFR+CJgunjJQ+8Q8HE2DamHeYXhyrGjwVenXasF3qwyyuuWChebXWGcmCLgnSPrYk8L/gXa6hPAor9DU0a9VZ+4DuCTDH2xfgwxzxl1r/wPIfqoIlbQ3xXNyy6mP81tOt+drCOeog06mu+BlP4r43BOJ4aAemPQWbfL/Sbsi7/mVQnd7ALbap3lnIAIeTlocEKMiFg/CK2jFSeWZrkiFZR+4Zg2XMLD4Kf9bQZaRi1cca1m5Xckszq3s6E09dXdp7H4QdI4/Osmvc4Xq06be1PdgI3HshJcCAuGb9SwkiwVw0ieuhG7IMBXyEvJf1avGzP0SpJTM35l5RmCO9E+thDRR+aDaFVS7sEktzABcwYqzH0O0KMdXRck3AUrp91cI7IYDQv+kywFcdbPevTDjLJh2/bHrOV9PlnX6OeK887jQmG6SKwfRktEtJ2AlLCoRRJbbA4+2KBkPLp1rvn52Kgt0Ugav4HVL2tKv5uRrHWmYDOS/61Xz4T0JWBRhh4I/Ter3C8wHROe++hQNK790eLbDs4L6gdbcBfzfs3QxJyyKOoAAHKnTEbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(82740400003)(356005)(36756003)(6666004)(478600001)(36860700001)(7696005)(81166007)(5660300002)(15650500001)(47076005)(4326008)(8676002)(8936002)(2906002)(2616005)(1076003)(110136005)(41300700001)(426003)(83380400001)(26005)(40460700003)(316002)(70586007)(336012)(54906003)(70206006)(40480700001)(86362001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:45:11.3056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97219117-65df-4b28-6d26-08dbae403c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Update EINJ documentation to include CXL errors in available_error_types
table and usage of the types.

Also fix a formatting error in the param4 file description that caused
the description to be on the same line as the bullet point.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..20ae49ec4eac 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -32,6 +32,10 @@ configuration::
   CONFIG_ACPI_APEI
   CONFIG_ACPI_APEI_EINJ
 
+To use CXL error types ``CONFIG_CXL_ACPI`` needs to be set. If
+``CONFIG_CXL_ACPI`` is set to the "m" then ``CONFIG_ACPI_APEI_EINJ``
+also must be set to "m" or "n".
+
 The EINJ user interface is in <debugfs mount point>/apei/einj.
 
 The following files belong to it:
@@ -40,9 +44,9 @@ The following files belong to it:
 
   This file shows which error types are supported:
 
-  ================  ===================================
+  ================  =========================================
   Error Type Value	Error Description
-  ================  ===================================
+  ================  =========================================
   0x00000001        Processor Correctable
   0x00000002        Processor Uncorrectable non-fatal
   0x00000004        Processor Uncorrectable fatal
@@ -55,7 +59,13 @@ The following files belong to it:
   0x00000200        Platform Correctable
   0x00000400        Platform Uncorrectable non-fatal
   0x00000800        Platform Uncorrectable fatal
-  ================  ===================================
+  0x00001000        CXL.cache Protocol Correctable
+  0x00002000        CXL.cache Protocol Uncorrectable non-fatal
+  0x00004000        CXL.cache Protocol Uncorrectable fatal
+  0x00008000        CXL.mem Protocol Correctable
+  0x00010000        CXL.mem Protocol Uncorrectable non-fatal
+  0x00020000        CXL.mem Protocol Uncorrectable fatal
+  ================  =========================================
 
   The format of the file contents are as above, except present are only
   the available error types.
@@ -106,6 +116,7 @@ The following files belong to it:
   Used when the 0x1 bit is set in "flags" to specify the APIC id
 
 - param4
+
   Used when the 0x4 bit is set in "flags" to specify target PCIe device
 
 - notrigger
@@ -159,6 +170,13 @@ and param2 (1 = PROCESSOR, 2 = MEMORY, 4 = PCI). See your BIOS vendor
 documentation for details (and expect changes to this API if vendors
 creativity in using this feature expands beyond our expectations).
 
+CXL error types are supported from ACPI 6.5 onwards. To use these error
+types you need the MMIO address of a CXL 1.1 downstream port. You can
+find the address of dportY in /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
+(it's possible that the dport is under the CXL root, in that case the
+path would be /sys/us/cxl/devices/rootX/dportY/cxl_rcrb_addr).
+From there, write the address to param1 and continue as you would for a
+memory error type.
 
 An error injection example::
 
@@ -201,4 +219,4 @@ The following sequence can be used:
   7) Read from the virtual address. This will trigger the error
 
 For more information about EINJ, please refer to ACPI specification
-version 4.0, section 17.5 and ACPI 5.0, section 18.6.
+version 4.0, section 17.5 and ACPI 6.5, section 18.6.
-- 
2.34.1

