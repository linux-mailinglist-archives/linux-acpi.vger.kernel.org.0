Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575FA644D8F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 21:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLFUxi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 15:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLFUxh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 15:53:37 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253BD2A978
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 12:53:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXMQ7TjS68/Muov6hVdvndP51+4hLCefslQvpeJJJvxHiOoAqCQo75gbK9ADfXzIrOVlshhjIlOmJHs8Uwqg6MU6APJP0oJyEwYj6XBEQuOshiA563r5KmmKd4+3Z4Ryxgd6en3q7u6MCaQLNGzbOcON0lAEDcuOxZR0cwoyE49UfCmPfQnx41LJT29oATPArD+nGV1XSfkmaFp+WwA4zyym1HeclDO+G+Cz81IvX1uk7uJP7GZ0h97pydLy2mGOl0dKF+TNkyH+2j1AApxQukLv9Vtt4poUx4I5mfruKapbP4PkaD4rQBBn+FN1IIrTCSs5s35hNPINVMP/WeCogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT0IEdNcvUABdk5gCPsOsw4Tx9eQ9FeKbnpnLfASHdo=;
 b=N9LPpVO7N5ZoAeYewv+Sf6f8dmNtzR++4IcBHC1XIl6LY2wyS7SOG821ixEXC6sKurhVql/pS6WLP4rZPoVCWCeTnpDADac5VOupOX3Ba7n1rCzzzQi9nT728bYa7nhfCgCPJxB1rcHdFIsAsWLq0fGi/6H7KERWl1Vkqktcr2YtVLQexkikY9P8kGnZ+gjV2y6CdIrhxlZh5dqYhVg8XgcI0JXdjrKX3kqJjE68ES0L16A4T1U5Ud/o718HuZMd785t0d4ZSPMJH6g36KHsXTot88/PuaAjrgu37M2D5ZgCET1xfDC/Kc39wgVEdJXsJz4pcZkLqXNv4vtX5nfwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT0IEdNcvUABdk5gCPsOsw4Tx9eQ9FeKbnpnLfASHdo=;
 b=xRkmc64tZQBOUWGNFjSx+dEjNx5phTRRYg5KMyLO6mmOPXRYl/vjmexGmEgeY3rGpRXIH/f7tt5smtEyaOYQndBKUCTwHlwDMXf+n+A6r77TApWh70NOryJBoL6URHAaiDtMku3BQTdde/ZuMTBd9EhhnMRKkt6uZhHTG4QCOPQ=
Received: from BN0PR04CA0195.namprd04.prod.outlook.com (2603:10b6:408:e9::20)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 20:53:33 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::90) by BN0PR04CA0195.outlook.office365.com
 (2603:10b6:408:e9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 20:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 20:53:33 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 14:53:29 -0600
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 3/3] ACPI, APEI, EINJ: Add support for new CXL error types
Date:   Tue, 6 Dec 2022 14:52:34 -0600
Message-ID: <20221206205234.606073-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
References: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 70614f95-43a9-47a6-6ea8-08dad7cbf038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCRRpKozQnFIMvMXgy4ylCt7xjxCpqWGbL6qUIoVFVcMp8WCJOwy7Nv5UID3Q6BGsnqW+vgYz8sK4GJ2ELX/L0lLJpx4IT1KG2Q4U9T97AsQgO5GGDtJ4rORQeIrDrEcFDfAl6R5qblTxJZugc0+Q1Qz0rkQnSthjOyhAIFiwtE5UJ6kXCXIKzvpjdmCTgDpp4Rg27kU2CFh4H70Q0Xgzij++bf6nFdbgN1x81oLUQk3ZCzJ0Ubj1QFSeVG3I7K3r7iAwFp08SNx4IqeTNW2YFhKwxA45QrqgRf6oNbVtFtUixJ9dwWp7mF5Oh8xOEQi1n5OH/ySIfuEKY58r7uoYnAanIAILdeuNbCOuE5HTu/fvd87PYxABrf8VgIe+RjUeQiDej0x6AyLG+KoXRLwBjsVZoV8gGv/ZENHLkt06ZUisE2cTIxROr3D1xU15W2yJZivv3Im8q0g7wMCFVnK0CWvMyh5vITJ0iSSFxl32ywLvM5mECP7qzF5thEW1H9UYzcitpj6WZ3AiaQR7/ulCDFAO62AaouItM0YwnRBo7KQHbUdF0FFFduYKIcRY1OGmVInpiq+8keeZ3zi5oZS/DzwK0SxtDB21VxT5RTONkkrwdxfvdlDSOuDXaLycC5OjmBi1dygDvk67uiSt5fnANCfQDDQj/qqkra5EAIOcCkObwoia8B0SNDbe8SaP7CYDS6V/ZvabtIAVOrnPzgAXylIm5fxV6DB71KCvImwhe8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(81166007)(356005)(8936002)(70586007)(2906002)(8676002)(82740400003)(36860700001)(70206006)(83380400001)(41300700001)(110136005)(40460700003)(1076003)(186003)(336012)(478600001)(2616005)(54906003)(47076005)(16526019)(4326008)(426003)(5660300002)(82310400005)(316002)(40480700001)(6666004)(7696005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:53:33.4440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70614f95-43a9-47a6-6ea8-08dad7cbf038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jay Lu <jaylu102@amd.com>

EINJ module allows new CXL error types to be passed through sysfs
interface, but it doesn't advertise new CXL error types in sysfs.
Update EINJ so that it displays new CXL errors.

Signed-off-by: Jay Lu <jaylu102@amd.com>
Co-developed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ab86b2f4e719..82004abb9643 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -584,6 +584,12 @@ static const char * const einj_error_type_string[] = {
 	"0x00000200\tPlatform Correctable\n",
 	"0x00000400\tPlatform Uncorrectable non-fatal\n",
 	"0x00000800\tPlatform Uncorrectable fatal\n",
+	"0x00001000\tCXL.cache Protocol Correctable\n",
+	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
+	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
+	"0x00008000\tCXL.mem Protocol Correctable\n",
+	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
+	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
-- 
2.34.1

