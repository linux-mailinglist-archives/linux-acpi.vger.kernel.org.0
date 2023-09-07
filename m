Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31D5797CA7
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 21:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjIGTV1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjIGTVY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 15:21:24 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B4DB2;
        Thu,  7 Sep 2023 12:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFmuySvtx4CWRzmCM5c7kEpg1cQ9wEpAsMtAySXXVB8BWirEnjEF773QYsqJJqVdd74D5qU5cpfh3dzB0mRqeKB86uo3pi/FZobAHi4dpjVYXeIX72qPRSYzWJcIY0Xym5rVEZiBfFjBs9jmvyjj8T4vvlXNoM0QDuWYgizEJ5kUiyE0LVB9ZUGo+stt8hGqeSLedTFM2X/leDw0tGWh+Ql8dzhr9zrxzMBnr+XVxhIS4LN+K1zJIJlSFBz8Y+DVZlV3T9nzxu8Y/rRMfFMvm2ckQEcNOYu/WpO5dwsoMbw/vnUxWYcknpJCQl6uFIdd0aBtuEmprEwIXsJJ0pauDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbKk1/q6uJY2Ni8c20DS7c9zdFz6tOATL3GvKDZU4Mk=;
 b=T7aQKP7LWBMqlpQfSO+kLRR+ujL1eh7bJxRXrVmkNL6goGRT8fp/yz+b3qRJBZgwFvSUSdyp93sCb8iyem+ToZ7ziLwf4yCCx3istyIxI2PkI60Xp1Oa/4wOOhESPJtu5W4r1HDyxM9+SIkrxBco4JPfQ/WfoWiuakeiNdJ8roZMnkXQFxkcfeQc4GzC8wvE7cO9HznUxerXm4YoR4Iv4ao0qZdIFKiWAOxOzbxizKjLU7OnYphqHoo9NnVMdLUSi8ECx5erramcU85t0U10vKpuaMPwOLyJOT2B4iRxfkaBEcoj3r5pxaXHepw66PJSl52A8c77Kn4Qu0zXdIkZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbKk1/q6uJY2Ni8c20DS7c9zdFz6tOATL3GvKDZU4Mk=;
 b=LCnUVvOdCXk2Yk7AEUI3RX67Myz9qyB+2qkwi+HEzpXrckRLxMHVSQwmd3QP0ISeekd/T/XvHZR5zIfXmpbNY1KzFNblB6cC3WBwRfGdpgweEJ20kvi/XOpR5Bfui3kLc/crdDm2yoh1Fh4N5p8josYxnNGMhuXYMPTzj2fGdOg=
Received: from SN4PR0501CA0018.namprd05.prod.outlook.com
 (2603:10b6:803:40::31) by CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 19:21:17 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:40:cafe::95) by SN4PR0501CA0018.outlook.office365.com
 (2603:10b6:803:40::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 19:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 19:21:17 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 7 Sep 2023 14:21:16 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v4 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Date:   Thu, 7 Sep 2023 14:19:56 -0500
Message-ID: <20230907191956.674833-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: d942d87a-d100-4da2-b535-08dbafd79c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VyCryCPirrgVzZctKLd8onlrTMf9Sp+61Jpf2wJs3HEAC/jpaaqJjZQmjcu7eazjnCStDzjz6AUOGb0tn1tjpE8MvH4C8qnySkARqReJY1e8V0tkB8jguECXBug4O8ReXoLGxd+j3DigYEseN+eRzboFIJ1jKZ0ufxmzMWv6yb3gCRUBl/9ZhBAJBoCGRkdIRbg22yG3Y4rflZYd9q5dnx68eAPnz0xNSxVS1MG7nJav8vVS7d6wSpTrFCte7ZoZwkT6SgUbkWah21FjppfbS3NUUm3ic+hzDWd20LVAGpaY0teQ1SX87gAVftpHZwJymVO5aDRAUg7d1oM0GyitGPnOMwQ94vLcDKHiOc3pQXm1/mP5b9UuziRtmNRu9BxXtJcSyOlbCy/xz9DzK1PYHPY5d9blnHsviuABpiy9i/dl4ZgFdJ9yOJGfz7OQJfIKryWDNsNiMbYVtTjnJxodh2mQaAut0cVuyaES/66kdSkDO9/GT4PvRbAMWqFxlOHJkrbr+BShhY6R8HiPYiZgJAQO5nddtTJ2clb2zO4EOdDqJwXAoAOlxI0+hNF0QAX+nYRMxJPxaIegNPEHN3H1/P5tmXK+ASyJKLAlUCtpM0JmweP55Y+9CIYxYyJ5PsUfbSowbaqUYGSLtyoSvlmNdMt4mMwr1KIi05sW/Zc7A+ZLs907yXcFIs13xasp3toxn5XJ9QLgaV2iqkXiS5OBR/dEyT7axjdxvx5n7F0dea81CxItys7xoqL2rijyFyaRt7DD8TLKfctEV8Rk3MATA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(81166007)(82740400003)(356005)(40480700001)(36756003)(86362001)(40460700003)(478600001)(110136005)(2906002)(6666004)(70586007)(70206006)(4326008)(7696005)(8936002)(8676002)(5660300002)(54906003)(316002)(41300700001)(15650500001)(47076005)(36860700001)(83380400001)(336012)(426003)(2616005)(16526019)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 19:21:17.3995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d942d87a-d100-4da2-b535-08dbafd79c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 .../firmware-guide/acpi/apei/einj.rst         | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..c6f28118c48b 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -32,6 +32,9 @@ configuration::
   CONFIG_ACPI_APEI
   CONFIG_ACPI_APEI_EINJ
 
+To use CXL error types ``CONFIG_CXL_ACPI`` needs to be set to the same
+value as ``CONFIG_ACPI_APEI_EINJ`` (either "y" or "m").
+
 The EINJ user interface is in <debugfs mount point>/apei/einj.
 
 The following files belong to it:
@@ -40,9 +43,9 @@ The following files belong to it:
 
   This file shows which error types are supported:
 
-  ================  ===================================
+  ================  =========================================
   Error Type Value	Error Description
-  ================  ===================================
+  ================  =========================================
   0x00000001        Processor Correctable
   0x00000002        Processor Uncorrectable non-fatal
   0x00000004        Processor Uncorrectable fatal
@@ -55,7 +58,13 @@ The following files belong to it:
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
@@ -106,6 +115,7 @@ The following files belong to it:
   Used when the 0x1 bit is set in "flags" to specify the APIC id
 
 - param4
+
   Used when the 0x4 bit is set in "flags" to specify target PCIe device
 
 - notrigger
@@ -159,6 +169,13 @@ and param2 (1 = PROCESSOR, 2 = MEMORY, 4 = PCI). See your BIOS vendor
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
 
@@ -201,4 +218,4 @@ The following sequence can be used:
   7) Read from the virtual address. This will trigger the error
 
 For more information about EINJ, please refer to ACPI specification
-version 4.0, section 17.5 and ACPI 5.0, section 18.6.
+version 4.0, section 17.5 and ACPI 6.5, section 18.6.
-- 
2.34.1

