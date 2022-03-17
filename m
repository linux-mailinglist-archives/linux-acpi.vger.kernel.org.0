Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB774DBF96
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 07:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiCQGoE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 02:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCQGoD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 02:44:03 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C31CDAFDB
        for <linux-acpi@vger.kernel.org>; Wed, 16 Mar 2022 23:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE2QyFnPBBJLqG/VCWo3WYlJaWAiQwaWsod+BUgjljZqvXdjXZjJEOVfEaye8e80/zIrSzqQR2nluMfeaa/yTf7OrvLOMoJNgz5u7HzDkGxgmI+2jltYc43Yg5W3vDorKWkpa9XVD3ObZ7iT81FNuKnsD7PYMhbMSmfPIgYCLfDXqQlBzD8AFEDU1ZILjXPcj9xj6iZim8lHsD9IxSWF9Pe2Zy/wv5OzvWNrPHvv7BccjPAaGEaM5rZ6VFuoTstKuFxdbhwg7sG1D/0i2IJPaLPAbazT8oGs7bUuCEUuGqi3j3l4PkygobKxuJuGNooqOV3imQkb/zUKy6l/irOscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPjcM9wKPTIFv5ZzllFhKijAMJplzUjjvhlbejGLE+Y=;
 b=Ekg47AXSZC4srDb42YQbPLKGticuPrK34sSCUCF7J09fpU8wEc80Ch6+f49VCSVgOul1njRzPFQK+ehth5VdadzHNPzYlS6nkbxy2KoVxER6hsxygA5Ia0rK7LelwdouXks2cjimvhFisq7FYyZC89zVM8uecmqJOXs0464LdJh1SWM11TZQLHsFUXDWx5MxYEI3F5b+YIeA+aw3tKohoAlT9NnaLd7W+cGnjYK5pXTPJfk9JCwmLh5dKovwDzSnfCRlWezd/47bIRlzLzFT3QSCn6e0jbtDO2LEbyFtO/pHH13TwuLWgH7t+tNx2lRSISr1Zjc2L+4FC66VMnjhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPjcM9wKPTIFv5ZzllFhKijAMJplzUjjvhlbejGLE+Y=;
 b=Yu+9yY4Jk5LTnRcyzqMct8/ad4hQD4NLPqYm48rVy8yfn+8BSgsosdG1uo1+5IGmZ6R3ZUEfGLLIWYKM8go/HQgIVRAphgnak3aa+/ngRJkSQ/jyylUDBa/0fETnAPtttUGAEaW4jB27fQL6OcfT+b7lpGWF92TILvOLCF+kFeU=
Received: from BN9PR03CA0282.namprd03.prod.outlook.com (2603:10b6:408:f5::17)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 06:42:45 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::b8) by BN9PR03CA0282.outlook.office365.com
 (2603:10b6:408:f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16 via Frontend
 Transport; Thu, 17 Mar 2022 06:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:42:44 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:42:36 -0500
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     <rafael@kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <lenb@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
        "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2] ACPI: Fix LAPIC_ADDR_OVR address print
Date:   Thu, 17 Mar 2022 12:12:20 +0530
Message-ID: <20220317064220.287048-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6dbcfe1-a2c9-437b-4193-08da07e157f4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4134:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4134BD9495BC3087AE320F6887129@CH2PR12MB4134.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8FvaKUoCulaewunSO9BueWmDrmw5jK3Jg6RYEeqyGbDv5Ygzeb3K61DNq4LS4o/dnpmXPsGT7OuBlBY6XnnqpCsBb6goc1IL9zvifT99cXSu65AKmuvmXo/Q1upVfLIqNH3oEjwrxdYZeNNzdUkZd0tdIlfNwufmg4VdXMOi75/mWv9jyODaHwAQuDyPoBMyOOWnVKM/qR+bLJ+tbw4+nd+UZlGYNHk94vIM7fEvOyGzjdWpVKPwHAqyCTik7yJGpBKCDWk7YDs0zIiUSxT1u0MwsjaQzGF7rzdG9n9n13cmvQ6sw05WcAn78GK6k2hUXxQSFTQ4IaPH0tGANC4NKvh5Jvu+04NeBsjdYMZEcVWz5FdphLjg8RpSyh2zhlEzA5QD06n2CUKVLUty4zlMe/vmoANcXvtBak4Qkq9s/wDvLOYPGPBm2Yr9YA0KGWv4fJW53s/c98npuug0Ztp5LXV2lc/zZXe8QviS/xbVtua4n4zU70LAdnTSzjEWGA7VxKzJrpb4eHb3pstJttMnG8v6Oyqm+nXLTR1b1wQWqCpRXXRoEr4b/ggNrCjYE7hSMn8dxtZpXCfJO0ko5NON7RVlNsJIN3vXxyES7omIA11uVHQ7SVUrZdQyBHg2mL3Rimch7zfxSVY1ut9MeJMma4wka1BT1hRWJFhGG2+XuRv54tc/IbMOZlQlyYPvM5dgKn6pU3qiaghvc1W8nfi9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(5660300002)(4744005)(44832011)(4326008)(54906003)(1076003)(70206006)(70586007)(508600001)(2616005)(36860700001)(8676002)(316002)(186003)(6666004)(86362001)(26005)(16526019)(40460700003)(110136005)(36756003)(2906002)(47076005)(83380400001)(426003)(336012)(356005)(81166007)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:42:44.5851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dbcfe1-a2c9-437b-4193-08da07e157f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Without fix:
  [    0.005429] ACPI: LAPIC_ADDR_OVR (address[(____ptrval____)])

With fix:
  [    0.005429] ACPI: LAPIC_ADDR_OVR (address[0x800fee00000])

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Added Missing Co-developed-by tag - Thanks Rafael.

-Vasant

 drivers/acpi/tables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0741a4933f62..550e9512534c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -151,8 +151,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_apic_override *p =
 			    (struct acpi_madt_local_apic_override *)header;
-			pr_info("LAPIC_ADDR_OVR (address[%p])\n",
-				(void *)(unsigned long)p->address);
+			pr_info("LAPIC_ADDR_OVR (address[0x%llx])\n",
+				p->address);
 		}
 		break;
 
-- 
2.27.0

