Return-Path: <linux-acpi+bounces-115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C557AE050
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BC83328164D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E723763
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848D179B4
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 20:02:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E139B;
	Mon, 25 Sep 2023 13:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guegc5P+FzlUKLi2vSa553SMeWNy8Amz3sKZaNolDAOI6A0M5/Wb85QTnNKtH7aMc0dmEhfeyTYH/rCRZp5s/Ke1+LR7NRY++GbftEAb1+H3tn1MBjm6HtsZyQfGu5aQS5I0SUrZGUc8N5z0bJVPgxOsZL+PC2HvRTj8AnSjeLYz/Af3BdBzg3o4yq1wqJE0xmPQfYZIp48HfPLEh0FXx1XRVrHq2WK4WyV9Nv2PcipUnp3Dktwv2yK2pnRqGyhC7h49Rz+IartzOW0Q6Pz8QRykcmUUqxTgfvZpj+U81XoIfhLjIr1AezX0/1HXg6va4q0t0hgzZ08Nl9TL8Hs/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbKk1/q6uJY2Ni8c20DS7c9zdFz6tOATL3GvKDZU4Mk=;
 b=FC1EnNATfbVg1NNuo6PnkQdX8t9awwIO8R97V+ZrgobcpgU6RLLD/NMFRIw9VOwGg/DM/dIpUIDY5b7Sehd4rw845pUXRrudsNJeIpzTnyJo8olbsQyIRJoSHdm0opnfcqFNcCtRWVgM+Sq0/iC57N4CvmRxI9fnKphnGwHFFbzDDDZZAJyn+YqqAb//0eJopF9i+cFJLqxnNiW3khOHzvoG3BHVKc0Fg+wUQnhMHMuaqxnaCSvuxL8gumpd+8evuuNjBEg6PJ9pcrAWPTvwA8Id5/1kfXd2HV0M2GaErN7kzxORcLC9Z5A6J/JUtS8uNB1++CeAim9wepZosM7EdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbKk1/q6uJY2Ni8c20DS7c9zdFz6tOATL3GvKDZU4Mk=;
 b=BajL0BB9jJhaYgTmlUL/jnYM+fOxMojg2IMK+vvwokGGkZZjf++Jaloyf7Uumldg82rBvDl35t1wMtuEkt7AjBYl7FBTK8xRB239yqJk0NzMpL0UJ/vRuekBNU6IN5YDSVOUOjQOBSpZDyacutDbBuC+d3++vVYPigZa/hnK0dI=
Received: from SN6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:805:66::23)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 20:02:29 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::28) by SN6PR08CA0010.outlook.office365.com
 (2603:10b6:805:66::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 20:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 20:02:29 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 25 Sep 2023 15:02:28 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
	<yazen.ghannam@amd.com>
Subject: [PATCH v5 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Date: Mon, 25 Sep 2023 15:01:27 -0500
Message-ID: <20230925200127.504256-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: e907ed87-3cac-41d8-e18a-08dbbe0258db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DHnrg01fa9STopqxB+/HepAs+xs7+8JdC4/SA4y4Q+uD07PZEWpU/drBdukm+xg8f+2xJF180SSlN3y2ffp9WtwGOHAl2oZdkvWQi35j1rCmOLksJhtwDlv4PbgucNLHsLLsiwVqnke+GndlykCt48niDwJKcPvg64jeZqnMJI6IQXvu+HjYf3/rhRhsRN0my89K67zNiHPFUmS+W2ruLsTk8+vSkdYuuPasYAixkyUxU0QfenOX0QlOja3gzAWMsK+cePLQ/PDiic/zFE44UruCc/xu/rAaptM0iTjvv7uQDp+vAObS/qrgYpEMrJgcRlXsjjNbDNUId/aPfpjLJh18t++w3usX23Axx6Cnw2zFAz+vEI0z8WPRN8IVws3VhiEWQC29/qJwOTkSaSRTLodCc5ITfiQlem8QbOlzIKtbOBvUmMIXzMCMmKqsHeb+nwLJbWZE8qzP/RNiNApC2Grjuy7wo3UUtpeHiJmK2JKIp6zNpNBwSmKEEMguaKDBlst5zuwudsBWN3f2+YN9mN4SOZ0nA98kDL5d1ezQRqMREa7PXQKHAu5YnNWKSEJkpiTRZgr9HzE9MV3bimwqqP2hG29DHM3P/JefyOLQqJNYpqOKJjrAacTM3lqOzbFCZ14RWnOPzXeQseMKwpLHLvQnn9LEJoIGq8XRsjCa1TBG3Uj7bYiYL9VirdnkWEZRlbzddvA/hrefu1/VMRY3aNeyGkIOB1y0Z81frro76rgZMTWYfFrOW5EaLswPW32WpTRJH7Z/bP8NI4qs0SNB4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(8676002)(40460700003)(40480700001)(83380400001)(4326008)(86362001)(70586007)(81166007)(54906003)(478600001)(110136005)(2906002)(70206006)(316002)(8936002)(41300700001)(336012)(82740400003)(2616005)(16526019)(5660300002)(7696005)(47076005)(1076003)(36860700001)(15650500001)(426003)(26005)(356005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:02:29.2293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e907ed87-3cac-41d8-e18a-08dbbe0258db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


