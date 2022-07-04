Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13922564C32
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jul 2022 05:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiGDDva (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jul 2022 23:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDDv3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jul 2022 23:51:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9C2632C
        for <linux-acpi@vger.kernel.org>; Sun,  3 Jul 2022 20:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExPa1Tyu/o8VnSohD3bn0nNebuHvFtGeZ/fzi9v356AGBGIyNbQ29/3drJUM25dMwLRX+m0/r7rbPLYd+oyb1Kh3VQ6VMG4u5zKaayY1R00MDc9CKNb7oGx20dajRIrYqRoSyTMltIYjTefhRB6aeiD9+/y1YvMzcW+J3azpd02YDtPJrraWTkLh4BpfmVlm4tbx92e/1B9Y9Lc2XdCJ956RW5gS23ESRiLLJ+O/KcnFo3Kko98o7FjHa1nS3GQ6+siOemovOir62qbRiZ9E/FrWFDh9UJDPVQa2q+QfpcGWs2DYFhYwgeSh+IL3nIfINohpl82JwgdrWCfhKylVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APSkVBkS3LOjSZGphVghR9p9G6w/ciW7madj8Ih5H0g=;
 b=M7AQXOjHZVL/DpL+r/erFjPJxajVpb3h1lKSfNmqda6Gr2lHUWfJJDgMfbzsZZZV7l1sDWlqTEPmMJNg6wWb1MM6Id813ttMtfpnVxzhsJddgKM+66RP1GPTYSCJvJE7JsoM9gMLvvjW+G6ziVrcFfW8SGduhtwQFF/tM32LvimQnW5kTAcH2I0tqn3enw7wIoiPX77Syml3doBy03yciJBU6X40iKBqx4ZS9mX8T1UjXiq7WafpPkmY+aZ5P3yt0sJEbxEQyGcDCvI9ywYG8WveOAzV6ZCR6IPG1TmFF635h4dTY8P++S40ux4rGIpRkO0492iZ6W64QxcZS3KmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APSkVBkS3LOjSZGphVghR9p9G6w/ciW7madj8Ih5H0g=;
 b=piXnXKV1t7qNOuA2/B21NuW1tBtPHDBZNPHstBnByNhFClwgN1c9hbkSkNaty9Yc/WTzB2M2B+ftqDvWhc1h3N1v1zmE1bMuVDmeWkbv5XQjjdGXAZkI5Lp0lHK3T6o3qxmYCpC84hoRo1BBXuwjOgjL7q9mg9NAVc81XuQ7i9g=
Received: from BN9PR03CA0489.namprd03.prod.outlook.com (2603:10b6:408:130::14)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 03:51:26 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::71) by BN9PR03CA0489.outlook.office365.com
 (2603:10b6:408:130::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 03:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 03:51:26 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 3 Jul
 2022 22:50:53 -0500
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <mario.limonciello@amd.com>, <hdegoede@redhat.com>,
        <nakato@nakato.io>, <mika.westerberg@linux.intel.com>
CC:     <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH] ACPI: PM: s2idle: Add support for upcoming AMD uPEP HID AMDI008
Date:   Mon, 4 Jul 2022 09:20:17 +0530
Message-ID: <20220704035017.54513-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f7ac4b5-cab3-400a-8cdc-08da5d70787f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPNbD4secaG4YJhT7RBDSgvF/NbJBYpehgwRrF6h8A2kJBr49pEGVNIOd2BFvz8TTHcPM8wyLaqi2+eKQtTqNC0faN0w6Iuk4ZJxMWh2AVFHwCkDDNgXWbY2PGTiieaQUhw9qYttUvF6RmJcTepskpf/mgIX17c48OWa6uenGvPHnE3xZc8zWhtNAk5BdUejWcWDmz480ckTZ0z+pi253r6K2Wk8MNT/8oEBLC6Au8LU14hNKe0NhGw7mwEFvcAbmoZYyH/1LhP5tPXkhrc/wG0iOlFfGL8i2qbTvqplzSONrAHmJxuM2OdX2vD/mn6OfJCP/uljesO2+tUW9MVx5KGP0WdyKEYY/POHPC6eukAh1no2i6u39pmML/WXHx+l4PfPBJgKi5togCoRgFRZeOxHW9v4xAy+4rd7Dnwi3SaAGQLPsFHwiI3v00pmdMOq//MY+so/tZyMfsqMJyzpeG2gwA8LOD/bDyN/jEW/v97lfLYnymgZAq1YZ2xU75ux2EQN7gwfanteXgWhnGPLIJiTDKnwYHjhlQDXRCQOr4wSQhcZ1YEKphsleq4TMA8uIMPE0jVQzt4c/3Eg53KxbVnjD/bwAHNFZ07EQ60lAwAuoZoREFujGKeZaDJZ6zFZ297W+VoMjuKQvmAKzqH8F1H192jbPRfrN2xcgRSWEkEZttxB1QeYE3EF1oz03qkUbPLVvMkAvIzTI0dNdx24d8jIc7WkQdShNLGgYTC9CnjDkXD8hS195pvvAWLHIzJHCw3uwLPpUREMDmV8ub72Ba+2cNfWh++qc/CoH7GMRS24KhHCffXfhGz+fg4aqUrxn1WRiZ6jrdXoS4JiMdl+I21pTMcXUm3qTSPlwDN0ZqVTP0HZ8zQdBGaWIubWYA+y
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(478600001)(45080400002)(16526019)(186003)(2616005)(1076003)(336012)(426003)(47076005)(40460700003)(36756003)(40480700001)(82310400005)(41300700001)(34020700004)(6666004)(86362001)(36860700001)(5660300002)(8936002)(2906002)(4744005)(110136005)(54906003)(81166007)(316002)(83380400001)(26005)(70586007)(356005)(8676002)(4326008)(82740400003)(7696005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 03:51:26.5066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7ac4b5-cab3-400a-8cdc-08da5d70787f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

New version of uPEP will have a separate ACPI id, add that
to the support list.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/acpi/x86/s2idle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2963229062f8..392f75157f34 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -397,7 +397,9 @@ static int lps0_device_attach(struct acpi_device *adev,
 			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
 			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
 					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
-		} else if (lps0_dsm_func_mask_microsoft > 0 && !strcmp(hid, "AMDI0007")) {
+		} else if (lps0_dsm_func_mask_microsoft > 0 &&
+				(!strcmp(hid, "AMDI0007") ||
+				 !strcmp(hid, "AMDI0008"))) {
 			lps0_dsm_func_mask_microsoft = -EINVAL;
 			acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
 		}
-- 
2.25.1

