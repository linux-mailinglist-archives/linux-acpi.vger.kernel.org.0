Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B39644D8D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 21:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLFUx3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 15:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiLFUxW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 15:53:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09AD2AC49
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 12:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVJ+XkEjM6E+LxZxwaV5FhsBAfLZyX3HJ0ZT2OsAurB0bczEOAIFubfxxJKjkdEeJBAdBGmCUyXAGY5AOEBNRBiDz/QahBclSCkR2tVG0P2Do9EM5ISb07uUzxHzdWrqC2Er2YUi1w3uoUzFd4TX8WxpH+Uu1NdseHlN7dRKL/NMwXjiG0wL+uZgrjOMSVBC+WVfGY5ndPi2Fxu5nd8vdvhkkcucxO//aQFEtZD96Zuw7YfxBm0QDUIDDgpVaa+o34Ux3zvi9QPrFjgdVFfUqUwAzX7tFc+lBBP7bFs9u0i63aVK91zXacWwZJA3REjQJr7h/EJiPHkXtCk2+7DDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugemoZyC3JJW2RuXwkYk0SUA+nGXaEAPU53ZJuvlZpo=;
 b=OelWYI0XnPbE3dyP+jqI8iji4JgGCJulQTb7fk6KQw5il1s4/lv1wY6WBXtRBJeBNwA4oVTkQkWYfsxdmmyvqnl9TpTqbNWj6vqjh+ARQX4U9x3SsT0tVx9eNNhY7n8i23y+Gpx3fVtPsIB/jIWLXPZIzv8ZnB3dAuQ83OI1TlTaZdqSDJKVcbGJOm20ZTverWWIgaFQuqr+6+zej7jkMeJHciKEAlkzVEHywhZIVtJUSpa5C39a4obNqo2i8vCuur7N3IGBZm0G58hXrW8xPfIVRhQbJP9ue1ZBYmZyDUdw/zdylBnsAKb22hIo/IqNhp61NmvnhT93zg0uaLTEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugemoZyC3JJW2RuXwkYk0SUA+nGXaEAPU53ZJuvlZpo=;
 b=Gv2ad4/Fe4Ojf4Wodengv6SoiNm0Xmqxl8rXXEwj7LQ1kHIh5sH3EEb2TH6G0RG7vV1h9Y4S5iQmffTAZe0BXi2pLgucVWKn10f/68wsxrcbD1PZOzrERHhzWXTj1gbkpRzzq53X5ntIv43dsmeaa00RoMUdURasPhi1QINSc9g=
Received: from BN9PR03CA0613.namprd03.prod.outlook.com (2603:10b6:408:106::18)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 20:53:17 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::6) by BN9PR03CA0613.outlook.office365.com
 (2603:10b6:408:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 20:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 20:53:17 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 14:53:16 -0600
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 2/3] ACPI, APEI, EINJ: Refactor available_error_type_show
Date:   Tue, 6 Dec 2022 14:52:33 -0600
Message-ID: <20221206205234.606073-3-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cf634f-2d8f-4016-e9b1-08dad7cbe6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGMXuN2R2WEH81gBokQSmaUlAkMlzI1nAzIYDcSOiex1ThGRuiMseH0RpARe4quuUbyPL7Er2WJXZ7yVQ/shRfzhWmdhfB2bpvDTSWUJnruiaL14f7Ko80wdXsTagWURVgOfDOo4rZtFWHRFDNDalIiVSCdk532gB+IG9zt2huEhrJwbds3B8pVfGPvLJ0xlqSHG9NoUlCmFDc8vVzdsXREY3Zr9MbaVtKOzDUwYJcDzv5ec73+PPE2bXmjcyN+xOQXFyLeF1yRDpoypG/1GL2+PrEWJ9kjrzwgnLCXLisuf+BpnMCzEA3kvrxvEmtEf1uexNlPCyfKVMoSL0oFzcyyqqRCc4EZPvk7Tj5AU3i04VQMe5TvIlc3B4VQWjWtmIOUfsZ8rEaBQfiqDNL8otdSVqLi95pBc7s/j2hamchRFBr6wvJirZ6t424kuQ8o9csDk0OfF6ubOZ+Zxf7wWASWbM5oeqaFtC90nbhXeaA6jLsK7EG/3v6Pn9nSxHN3AOmy6ZormHw8B3xZczA0XSqcQdK8RKDSCSLhuV2bySEqxtkRN10pv455snbCrEnlg4f1OhMxtRLNbgt1HaFSup1tRsfjByH3uaF3c6JTutYX3EUUOEUK1/iT+ccZ2ik9ZX4KyQhoLmDfuQvpZAWzmSXauWD7Bb6v6jrYRfxg50zBF06XxZcgWniREcxwVjhm2v9pZ33WXB8A5INEZW3QSUrEFc3bIaNRHD/QYWXqCkp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(82740400003)(86362001)(81166007)(356005)(70206006)(70586007)(2906002)(8676002)(8936002)(36860700001)(83380400001)(316002)(40460700003)(110136005)(1076003)(478600001)(47076005)(426003)(186003)(336012)(54906003)(16526019)(2616005)(4326008)(40480700001)(5660300002)(82310400005)(41300700001)(7696005)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:53:17.3581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cf634f-2d8f-4016-e9b1-08dad7cbe6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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

Move error type descriptions into an array and loop over error types
to improve readability and maintainability.

Replace seq_printf() with seq_puts() as recommended by checkpatch.pl.

Signed-off-by: Jay Lu <jaylu102@amd.com>
Co-developed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 41 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 1a2641937eb6..ab86b2f4e719 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -571,6 +571,20 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+static const char * const einj_error_type_string[] = {
+	"0x00000001\tProcessor Correctable\n",
+	"0x00000002\tProcessor Uncorrectable non-fatal\n",
+	"0x00000004\tProcessor Uncorrectable fatal\n",
+	"0x00000008\tMemory Correctable\n",
+	"0x00000010\tMemory Uncorrectable non-fatal\n",
+	"0x00000020\tMemory Uncorrectable fatal\n",
+	"0x00000040\tPCI Express Correctable\n",
+	"0x00000080\tPCI Express Uncorrectable non-fatal\n",
+	"0x00000100\tPCI Express Uncorrectable fatal\n",
+	"0x00000200\tPlatform Correctable\n",
+	"0x00000400\tPlatform Uncorrectable non-fatal\n",
+	"0x00000800\tPlatform Uncorrectable fatal\n",
+};
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
@@ -580,30 +594,9 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	rc = einj_get_available_error_type(&available_error_type);
 	if (rc)
 		return rc;
-	if (available_error_type & 0x0001)
-		seq_printf(m, "0x00000001\tProcessor Correctable\n");
-	if (available_error_type & 0x0002)
-		seq_printf(m, "0x00000002\tProcessor Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0004)
-		seq_printf(m, "0x00000004\tProcessor Uncorrectable fatal\n");
-	if (available_error_type & 0x0008)
-		seq_printf(m, "0x00000008\tMemory Correctable\n");
-	if (available_error_type & 0x0010)
-		seq_printf(m, "0x00000010\tMemory Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0020)
-		seq_printf(m, "0x00000020\tMemory Uncorrectable fatal\n");
-	if (available_error_type & 0x0040)
-		seq_printf(m, "0x00000040\tPCI Express Correctable\n");
-	if (available_error_type & 0x0080)
-		seq_printf(m, "0x00000080\tPCI Express Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0100)
-		seq_printf(m, "0x00000100\tPCI Express Uncorrectable fatal\n");
-	if (available_error_type & 0x0200)
-		seq_printf(m, "0x00000200\tPlatform Correctable\n");
-	if (available_error_type & 0x0400)
-		seq_printf(m, "0x00000400\tPlatform Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0800)
-		seq_printf(m, "0x00000800\tPlatform Uncorrectable fatal\n");
+	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
+		if (available_error_type & BIT(pos))
+			seq_puts(m, einj_error_type_string[pos]);
 
 	return 0;
 }
-- 
2.34.1

