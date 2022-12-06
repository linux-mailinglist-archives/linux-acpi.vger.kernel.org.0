Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67F644D8C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLFUxS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 15:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLFUxH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 15:53:07 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702702AC40
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 12:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QncZRaIcDJhazSkfRfqkh6dXvprrG3f61b7RX2XXAjJ6opSOodu84jis+hdLoLl8ghcKpGhUrt0XVKATogeqI+PJwWfbaIj+Z6807fps0eVAntH5Rjh/5ZDin73QwfAoAHmXAdq4ug+48pS6mzJefzIRK1lUmjg8aRh0fuXY+0YxRK11A4zcnp0GqiFyGp2u+B6UDlLQxPia3Pw4FgYa+1mIJUIyZpyv8twQ5APHLMJGfB9X55N69TeguIiBQMif80wja/U4r6gNxvq99gf5n5qRWVgrIXk6lwh6LPJ0ctoVVy8irIaHE8CzH8iOuGv14QBCT9rOTfpgoAMgHvXVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tWagHjL/wHCKvP25krqJQf3A6ssjBZ9TqKb26JZQiQ=;
 b=MI6wHR/ADut7jmZJ2ViI6QPg0JZz7OPGVRhAPuM/5hlgRB4lflk39GZks4aHef/RUYl3olvkF9ZT7+lUI1+Gszkvd+qtIHSRGA1HbRl9yRX/QKb4iyDQ98i+UeVnClTR92x4jAcNqsN0Vyvk6VZMW7dRaZpIRVRGWqG399lr+YSaimh4SFEkgz6Ob6IVdmL3GfPaFnCZntjQtcDgR0tOTDZYUH6eskVt8p+6Z85+SYs1Mc27j+v6bN8+iBDhQk80Fj1cRyY+v1q528srsxT3CHPkW0DMdNhES1a5qeuiycKC1cl7HYWB/iOtdWvwk8vCcATJm2QK+bKuLO2ihfkYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tWagHjL/wHCKvP25krqJQf3A6ssjBZ9TqKb26JZQiQ=;
 b=0StUHVzy7Xvuzr6FkxI8ec3eH0Ysv3iRfKJ7cUj3wz6wW9bU50zBTfuuDSbDtIPAWQF0Y92HGojDBDkzLQKvqcsI+X9M7d7HZ0bM463FgtWZMGXwn6UydDxTvgkXHveXXqtyNNIZsPaiKviaXnnryRKgN0gbI83LbFJCeH0xrUA=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 20:53:04 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::2a) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 20:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 20:53:03 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 14:53:01 -0600
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 1/3] ACPI, APEI, EINJ: Fix Formatting Errors
Date:   Tue, 6 Dec 2022 14:52:32 -0600
Message-ID: <20221206205234.606073-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e60273-1b5e-4cb8-e334-08dad7cbde6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhzS8qRW1f8j+9m8TgLrj4HfxpHNlDXtWIDjOQr3ujRvUay5cjycKIPmfQ0hOu9coADd+Cj5+tvl04T3t5Q7VB0O5lMEOlvwr9nRHuGd9P1Fw08X5kDO3RZUd4FWBmDOJsk2Xp3tGN249GzU1kwTZJmGKilF4buMFw3SGDYcA9euoce1iijFE2qoF2MREYJKGdZhC6D6CXpaWhyeqrJqtbgvecwI0cThe/UKi9Egx1y7dzG5SM3ZhWIVoAJ3mGBYSn2Z0AhDENfz3q6pMhr6bYOtf5rf2BfP0bBqh1+wQRY52umrSeVbjIpzflhJh2RuYCYB27eBXNtGhM+Jb8Fk6jIEcvxxqhbpc+RyG6/Dp8Kler9RlkG/JVZbd4sUiqN1gC+uCk4lZNbwfk0VwpNetYDMJuxgLt8WzAJowY8fvMY3RqGZcOXENcI1qUdOov9aTGvkUpZiak2owCZ1qMfAL7a6OOmpsM5WyeNLr5VMi9S6o2gkaB000gHUvQlF+7SuWxFIC6SQOtBs0P+GjtBqme8qURyhzN+b8UQDVeaQtEQ/VPPmKgXqNdb6OKBYhenhFYNncPRSEx/BIX0CDDYDMYujlgesDbIBReXCFyqeCTacT2GqDXZBtOhOIbSl3EG0JUXTj/y8KVpTMtrwa3wWjeWmh9UFO+ZtVIf2C86RO0AEzejA5J6vx4x9YEYXIn5oaanxwfp2Yi7iWnWvwjOjxuxN5vTvLrfZboKa358RlMM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(81166007)(2906002)(86362001)(356005)(70206006)(70586007)(8676002)(41300700001)(4326008)(8936002)(82310400005)(5660300002)(40480700001)(26005)(7696005)(6666004)(16526019)(336012)(426003)(47076005)(186003)(54906003)(316002)(2616005)(478600001)(40460700003)(110136005)(82740400003)(1076003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:53:03.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e60273-1b5e-4cb8-e334-08dad7cbde6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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

Checkpatch reveals warnings and an error due to missing lines and
incorrect indentations. Add the missing lines after declarations and
fix the suspect indentations.

Signed-off-by: Jay Lu <jaylu102@amd.com>
Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 6b583373c58a..1a2641937eb6 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -358,6 +358,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 */
 	if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2) {
 		struct apei_resources addr_resources;
+
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
 			trigger_tab, param1, param2);
@@ -432,11 +433,11 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			}
 			v5param->flags = vendor_flags;
 		} else if (flags) {
-				v5param->flags = flags;
-				v5param->memory_address = param1;
-				v5param->memory_address_range = param2;
-				v5param->apicid = param3;
-				v5param->pcie_sbdf = param4;
+			v5param->flags = flags;
+			v5param->memory_address = param1;
+			v5param->memory_address_range = param2;
+			v5param->apicid = param3;
+			v5param->pcie_sbdf = param4;
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -466,6 +467,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			return rc;
 		if (einj_param) {
 			struct einj_parameter *v4param = einj_param;
+
 			v4param->param1 = param1;
 			v4param->param2 = param2;
 		}
@@ -689,8 +691,7 @@ static int __init einj_init(void)
 	if (status == AE_NOT_FOUND) {
 		pr_warn("EINJ table not found.\n");
 		return -ENODEV;
-	}
-	else if (ACPI_FAILURE(status)) {
+	} else if (ACPI_FAILURE(status)) {
 		pr_err("Failed to get EINJ table: %s\n",
 				acpi_format_exception(status));
 		return -EINVAL;
-- 
2.34.1

