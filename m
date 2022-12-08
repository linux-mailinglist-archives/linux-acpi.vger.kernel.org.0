Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6CB647486
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLHQmq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 11:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLHQmp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 11:42:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF90B13DE7
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 08:42:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4hgNUcsKulIWBa7Y5WAa5xFuLPMwKqJvCVr5O7oppuHjfZ4NC8dwL+HLZKnK+7n95VcBCuzciD8lQaAJFtQIOd/HA+laRS5Bt0sc9p5X6jqpNTcGPX9DZmNEoFcq02vaVi+8GIm25HDf3X2iu++DX9T9bomq1rcPlOs95rzH52V5SICNu5X4xYpmCsx1E0OgTjbwp2KVL8MZmnOxFO9v01F0K8KILdQhOG9weZY0yaw0vkxbg0sE1W1bT7k2wcg6MvrWyE4UHeu82xgnYgN5So5xTK8ShEkkzeb8C6VZd8iWszAJEoT6jLNT7lQIgoxBuFQrKQYhOa1LNSN9PdOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S55bNDPeGdOCZxbCyAmWx1sJTYmGm/iCBQwhMSyqvHw=;
 b=ocLeZVBNY+Tfp6lYHamlnT/ub7UBndQ89eg76JIat+KaucADXeT6loXXzIIl7T4bXS0bVfYLI+NWaQ1nHbW18CioTCB9tiqsMd7/0pTJ8mmARb7AbuZ3BBDgA8vyULHSJo/omWGAdnGbwtUzBzhFIPoTQDoMItNLZOAgiyqWX6aIhsaWONPaB9BqANw23nB3cGvh9uN0JeTHUC6hqd6ZpuM8G5Jiqj9vhJUQfm4oBICdll0abjbPpLKsP/uCRYX0ZSiNqVRSu0QxPXIJrxgioIOexgrOLG3oQXV5FTbQwGzDjlS1wC4B54jtOF+7BoiwOgCY46aY5e51Pk1DO/8iSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S55bNDPeGdOCZxbCyAmWx1sJTYmGm/iCBQwhMSyqvHw=;
 b=WEcoYm8gX6b+BvaQ/Ldkd3H22evruXLyU2pCi3rqVYbPFlpAEcHr74S06iJx/kRbAVx1ac4Weo0LIQkX99xR/m5Idy5xIwRsfj3hz9GPYMHGoOh6gGVaGR93K/C70xDBK9Iyazp6oWgG5YLTjxMtkO4BwtLV0z1fohzp79CUQCA=
Received: from MW4PR04CA0371.namprd04.prod.outlook.com (2603:10b6:303:81::16)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 16:42:41 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::66) by MW4PR04CA0371.outlook.office365.com
 (2603:10b6:303:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 16:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 16:42:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 10:42:25 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] ACPI: video: Don't enable fallback path for creating ACPI backlight by default
Date:   Thu, 8 Dec 2022 10:42:07 -0600
Message-ID: <20221208164207.13518-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208164207.13518-1-mario.limonciello@amd.com>
References: <20221208164207.13518-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8add979e-4e68-4607-683f-08dad93b38e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqVDjJuA6ukuTDK5B49eF2LAQYwpne7RHEzZqKoKT86SXKn4QzyByxhc7hceK7E49L7G/cZ+vciqBCrE8XR8mqBPwgS+OnMhW2bxflpow09CDwYiCZsOw3ekoDe3UED5fAQzly7gDZHJiOvaANIpScfgQgL8e0a7RBGgXlD2uxCpQuYa5lCEFBH3PJbgX3M6CdASrU68vbctY1xZmYlYLsQX+9TfzsQU6EipLbQw4YnZm3TKVJSNquJTZm5gHQzUdXdx9m+VvVHU3z4sm5jWD9NdaP0T4Cp0HBDPx3Nr0j6oN3fTei/2iktBvgaMMFzcWUDe9ICGIJflnJzxfDhEcgzEX2/uktGW+8+EnBqi3NRmfGmGZhUCrKutXSWwxs2nBYW674mRXgxDzGcztoTWAre3yphIzZuqe1u74GW3JpehliHbnmaOmyJtkLqJtEY/bcSJiz/0UHFbyulrOFFENuF0gD5pgSufKhNDnh1BB/rnWCWsyPIN4tfl2xrmbKZ9/spaKJbx0n3ahnYh3k4NxjlCRVRHXPo9ldSNeHIfQa/6Cleq/rs8r7byYt7chhBhXeUNqBDPGwG9FFZlceocD7on2yaMOeZqG2/zY9R9D9Z9Fo8DjI59kerAFaI/R4Js1h33l6Z9//q8IrXk0tl4JbcunwkiMcRworz5VTl61g+A9QAPkRwjYhoz8da7e5FVcBuobLOolUNDtNyjV8c6XMWraDlL/ekE6hOO8F7YoJU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(40480700001)(426003)(5660300002)(41300700001)(36756003)(83380400001)(8936002)(82740400003)(86362001)(110136005)(2616005)(70586007)(70206006)(44832011)(54906003)(316002)(8676002)(4326008)(16526019)(82310400005)(47076005)(478600001)(7696005)(26005)(6666004)(336012)(1076003)(36860700001)(356005)(186003)(81166007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 16:42:27.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8add979e-4e68-4607-683f-08dad93b38e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI video detection code has a module parameter
`register_backlight_delay` which is currently configured to 8 seconds.
This means that if after 8 seconds of booting no native driver has created
a backlight device then the code will attempt to make an ACPI video
backlight device.

This was intended as a safety mechanism with the backlight overhaul that
occurred in kernel 6.1, but as it doesn't appear necesssary set it to be
disabled by default.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2->v3:
 * Add Hans' R-b
v1->v2:
 * New patch
---
 drivers/acpi/acpi_video.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index f64fdb029090..0c79f463fbfd 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -70,11 +70,7 @@ module_param(device_id_scheme, bool, 0444);
 static int only_lcd = -1;
 module_param(only_lcd, int, 0444);
 
-/*
- * Display probing is known to take up to 5 seconds, so delay the fallback
- * backlight registration by 5 seconds + 3 seconds for some extra margin.
- */
-static int register_backlight_delay = 8;
+static int register_backlight_delay;
 module_param(register_backlight_delay, int, 0444);
 MODULE_PARM_DESC(register_backlight_delay,
 	"Delay in seconds before doing fallback (non GPU driver triggered) "
-- 
2.34.1

