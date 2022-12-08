Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6C64663F
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 02:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiLHBJp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 20:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLHBJp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 20:09:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D28B382
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 17:09:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2rzWMw9WeJFmQQkbU0kFPxuJQpaUGTSDtf3Hb7VaKyR8HqyypDkjVWGLq22mvMIC9W/pQxmGkyAfj3uAmhwKgj2vnChj7Rpa23A/VB8SghGu2QaBEAbI/fPUChcFSwYR30m9pTXurQc/1QLPhgCnQ035KtW7SXQmZxy8dcN64ZaDzhcGIaLjN88xAQ9BnZvHDUoeSzY+g/qed6McPnWe1M1r7zMH0NkKnmveQLn14r3NjXzAtz3ewDzn/M5g08rqEhdTnwCAOzTAlB6zMsQD/mtKRmysrrqRu3/va2j839zNRgqrbuct2GfYNYRKqfE33sKMTjvftKc19e3VCrhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LDHwK/wRnCGWgM+7VSXlwcn8bmcIsBzNhRY5FcA0/U=;
 b=KvJBU5upFeaapoEMnkwnNjwwRPmcThAitlTixIoeAM2/ucjX2dJxJCLtdgsWMh5y1E54wp9QdSzsLpuhe3CFpZBRSmwwYCR7HpV6LQtpJp8iz01ECpPYrUrWeHJmJeJTxB0DAiRjzg4T9z7/q0ZV+0XlIGMXxpiu/cavhhdxrPSddTMqp2fPX/JMLBseYh2DaVTkLHpwOk46OwFb/BSF8+w2TADq9oUyJMLNLVaj8i2NpCCzgjX5cN+rXSxxdeLavN3+UexvHFv44i2YsuGLuN8X3EOVKiaFaoR3fxU0bMZlIhoA8DW4jnXxx0jUdIZwr7npqxT2KUiymZeJgD5CMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LDHwK/wRnCGWgM+7VSXlwcn8bmcIsBzNhRY5FcA0/U=;
 b=gO4Xp8JgOblDbvFRg2lK8XsgWBEUPIilHziLJsWmCwJ61D92PQ3s9TnD5BvvIuTRTw1wmWN5M/j1WE8I4cVznY/+GnEIhr5Qh9LiPrTfU1MjffgNSKG+1QzBo2EAv6T6NkDc+VmJwMjpfBl9TpPq42kpEw224FRWhu3IvfmDU20=
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 01:09:42 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::15) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 01:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 01:09:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 19:09:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] ACPI: video: Don't enable fallback path for creating ACPI backlight by default
Date:   Wed, 7 Dec 2022 19:09:10 -0600
Message-ID: <20221208010910.7621-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208010910.7621-1-mario.limonciello@amd.com>
References: <20221208010910.7621-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 969463f5-9bd1-464c-e3bd-08dad8b8e2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aw8HYCkqUpHwegsRGVSIcpuAK0yhtbvKYgO2MCOgMkDy3StvaNNow0CtNeVkBDiQ3apWl7f1S9/fiMSNEjRn7C2qXmf3ucPkHNyUot4E/kIcEQiNglsofalkh16s3b3crunk0inC2OEbAlUPsjH268B6hOVjQVx8B1mE0VsluZGtsXkCzZYErssSFuUVZT97gVBM0EkCOmyv1ChqcxKEaf1KnPZZag7gWICWZtgLVlvAOLg3i9vw994LvPoNOwR1AG3ingGHy08gDpTDlqijdfem3TBqPw3wuY3MV4K0i678TkWNhH7RPKiLeIzeKUbIR7ehyUZB1dYowUIS+W4mvRkEuBzb8QLZuD36xaJ1Ls5w7uVwr5kZhosCxBfNf3YLIEA64suYvJxDPRkhN9KM+ykZrmNeF7AbIonNiY4AF+IoPc0u4ruUpVLDBXspSjN81kwxbmJyBMA3afn2C0yJflaKMVzCPJor0QpuI1qBraMVA6jlaJ/k6tPUM4ddqhe2vywVW5IPCe4kkvCclGx7g3H5KwLIYapwQFzlzZr4dt6hJ3HOY5EGqlmsJq2EYnaCVlYA5lnm5WZwSVAcgh0SmzQw210auITh4if4jk+dkFgIk3Ej/6Dp4ZKHhPCXET01bSbsJ6HYiDYEl5St21E2Cyt/WWpBBTWOoYshzDdFhEL2F8OWtfMWjOrTERdzomqzDA/RNRIpysaWmDJbfLcozSHU/U+iUdJ42VNMdwl+JSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(54906003)(36756003)(2906002)(86362001)(70586007)(8936002)(356005)(40460700003)(5660300002)(44832011)(4326008)(81166007)(36860700001)(83380400001)(478600001)(316002)(2616005)(110136005)(82740400003)(82310400005)(47076005)(1076003)(8676002)(40480700001)(70206006)(41300700001)(16526019)(336012)(6666004)(426003)(186003)(7696005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 01:09:41.6181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969463f5-9bd1-464c-e3bd-08dad8b8e2fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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
---
v1->v2:
 * New patch

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

