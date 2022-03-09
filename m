Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047794D377D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Mar 2022 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiCIQrc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 11:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiCIQpq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 11:45:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BABDECC43
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 08:40:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaWPR2iL3KpvhClpS4N0+fb5r4c1jV7yOXNajB/qlTuIyiQDlQrTJyP/UlPVK1rIBGqlBTknHoZKBHmks/qTaLSITrLSHXT/Z0E1vAU92ea1D2tEON+DO+cEq5Nx5tyveX5yKC7OZHjrBGC3VJOG++RiUkUDTNw67fU76BPm+ECIT6rhquCZ59tMaozgfqofKL40YbDJCMAZ0yLkS1FY9LRuG49l6xbDO+jcQ3qc2FYFa3nk9k3lY4ndmuqWo6LTVNomhkIu5fAJn/+jnQh1F+TtYVrsF5LczC1QysbPKumk3WTcb29vlGJUjopIJqaYUsTLO9pP0ERxwt0UggdoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGCaqkqBKNbJ6yjT85W4ViRLLOW2mspP2tEt4G3FMqc=;
 b=BZNB5BqcUgZiL0cXwOxPGA1rrJAwHkZsgNos8Ip9YqiT2ltoCDgYSfreQGULfGsfuXeIKUN98njFjOokbHg6ga9ZYmbfmJgufIk7Sp7NyIM3Fvcm08pj28pl58bWmhWgzdhitgzb7Blv3TjRZx5HL5X4zB01JLJxD8FSBxAO09HKGc8SwPiZw2d26GjzemhOITRa0qT2z75ksJsdg+KYKPTvRt7PzRnxdINjEEWKiyjirTL5L9p0vew+iJRSlOKr9VfqZ7w/atoMznnydmj1TI89bFiezwllwtEhYlHPZ2yOzyVW4bqbNnEn6SAPCgsvOs26t5u5sCJunEzJVorS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGCaqkqBKNbJ6yjT85W4ViRLLOW2mspP2tEt4G3FMqc=;
 b=Ve2cxm1OyRO7Nq+DLI0pN85ajxS7PoRqdcj3vBpFQujKlaxvqde0co2UHsI4cw47wpJ51pBPGZb4b6nYdfQBGkVi1KDRW8vPyT3a7+GsRbPSQLRYYJ4rtF38BgIKxVtVbSvhAFiNduzrUIm9PEa6ZLNxNBxA9dNOpdLQYOChwPI=
Received: from DM6PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:40::45) by
 CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Wed, 9 Mar 2022 16:40:15 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::e1) by DM6PR03CA0032.outlook.office365.com
 (2603:10b6:5:40::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 16:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 16:40:15 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 10:40:12 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v5] ACPI: bus: For platform OSC negotiate capabilities
Date:   Wed, 9 Mar 2022 10:37:49 -0600
Message-ID: <20220309163749.773474-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4fcef1d-a039-4ca7-5ee5-08da01eb7cf6
X-MS-TrafficTypeDiagnostic: CH0PR12MB5124:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5124DE48125C7D65E00538AEE20A9@CH0PR12MB5124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: so/HK1JjYzQPwuGTzn/2wQdW2s++7U9DEtEJ7wR5ZUZqG3HitgUqr22ySphsupgh7ToAtu2JNeGPk6E1SGBiW8WaFxLyDglN+ukiYk8o0v18qxCEhbhtYi0XVI5JUTQH8f0ezyVtaeW/wF/V0eZGOwB9VAJlZFyYuMUGN60HMTFeuzxBLDNO4/GBiDaiXYVxYvjmLc5hVTLtTZKjJtd5cOt+LCMfIMMeVmKxof8AtWbJZ4D3h1RKBSM2l7sydSEmKyLKKNdXnd99D2uGAnxVNeIQ2qiPinuGEYd2yhrUt1NWUiyUccGAjBx75bmmHId9DDZd08FF314qzy8I6oqzoGSZ0VN0rv4djYcoA3cKOaecCBtQCSqVgzSmfmiIhGKYAAUf7CnJKY5KoSOxvAdx4mCdJc5gNomB+v0FMqx4aE8ee8LY/D+e/k6tw/sUJY0+dyiqy2ArNXZp9MLEq8pTQFoYEHYd/pPYVyNqqwl7b1UUfUFTe22pzKjDI0JLHALiKCFtTaE0lMip3oMgZ6zyVyDNgyD68/6U/TAlEZNwdcj55wV2LWrlxQuZEAzz/uzVP/pGbTwOBO/hfgZGW83sT4PS0uaHq4fpzbL0uVhbOGQMfczvxPFNYYpCkPsi04pKB0pb4yMZCdIVjehNy7dvW4eG/ZZAKZ7xGFEPZLf317eaI63BhCf08VbJlqJ1BgqlOwfTktTSFDX8AptjXBc/tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(356005)(110136005)(54906003)(316002)(8676002)(4326008)(86362001)(6666004)(81166007)(8936002)(508600001)(82310400004)(70586007)(70206006)(36756003)(426003)(16526019)(336012)(36860700001)(26005)(186003)(47076005)(40460700003)(1076003)(2906002)(44832011)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 16:40:15.0716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fcef1d-a039-4ca7-5ee5-08da01eb7cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

According to the ACPI 6.4 spec:
It is strongly recommended that the OS evaluate _OSC with the Query
Support Flag set until _OSC returns the Capabilities Masked bit clear,
to negotiate the set of features to be granted to the OS for native
support; a platform may require a specific combination of features
to be supported natively by an OS before granting native control
of a given feature. After negotiation with the query flag set,
the OS should evaluate without it so that any negotiated values
can be made effective to hardware.

Currently the code sends the exact same values in both executions of the
_OSC and this leads to some problems on some AMD platforms in certain
configurations.

The following notable capabilities are set by OSPM when query is enabled:
* OSC_SB_PR3_SUPPORT
* OSC_SB_PCLPI_SUPPORT
* OSC_SB_NATIVE_USB4_SUPPORT

The first call to the platform OSC returns back a masked capabilities
error because the firmware did not acknowledge OSC_SB_PCLPI_SUPPORT but
it acknolwedged the others.

The second call to the platform _OSC without the query flag set then
fails because the OSPM still sent the exact same values.  This leads
to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
tunnels can't be authorized.

This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
same capabilities to the _OSC regardless of the query flag") which subtly
adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
with query bit clear").

The _OSC was called exactly 2 times:
 * Once to query and request from firmware
 * Once to commit to firmware without query

To fix this problem, continue to call the _OSC until the firmware has
indicated that capabilities are no longer masked or after an arbitrary
number of negotiation attempts.

Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
the same capabilities to the _OSC regardless of the query flag")
introduced, explicitly mark support for CPC and CPPCv2 even if they
were masked by the series of query calls due to table loading order on
some systems.

Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This series was accepted but showed a regression in another use of acpi_run_osc
so the series was dropped.

Changes from v4->v5:
 * Move negotiation entirely into acpi_bus_osc_negotiate_platform_control
 drivers/acpi/bus.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index b96c54813886..86d88bd72c07 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -294,6 +294,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		.cap.pointer = capbuf,
 	};
 	acpi_handle handle;
+	int i;
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
@@ -329,10 +330,34 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
-		return;
+	/*
+	 * Check if bits were masked, we need to negotiate
+	 * prevent potential endless loop by limited number of
+	 * negotiation cycles.
+	 */
+	for (i = 0; i < 5; i++) {
+		bool retry = false;
+
+		if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+			return;
+		capbuf_ret = context.ret.pointer;
+		retry = capbuf_ret[OSC_SUPPORT_DWORD] != capbuf[OSC_SUPPORT_DWORD];
+		capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
+		kfree(context.ret.pointer);
+		if (!retry)
+			break;
+	}
 
-	kfree(context.ret.pointer);
+	/*
+	 * Avoid problems with BIOS dynamically loading tables by indicating
+	 * support for CPPC even if it was masked.
+	 */
+#ifdef CONFIG_X86
+	if (boot_cpu_has(X86_FEATURE_HWP)) {
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
+	}
+#endif
 
 	/* Now run _OSC again with query flag clear */
 	capbuf[OSC_QUERY_DWORD] = 0;
-- 
2.34.1

