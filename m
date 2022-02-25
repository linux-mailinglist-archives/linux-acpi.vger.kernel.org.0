Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33314C4E5B
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiBYTMG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 14:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiBYTMC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 14:12:02 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3520B16E
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 11:11:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIMflcJat8FYCEoXO5Uphc0Qu99ebnkEZTOggCgnoSCM/9HXlVJF7m938croBZHpXkuYHLIIzZuHDOYYTuhEWfS1y695zOrmNeZKUgIQUwo6K5eGegephKIwyjjQZNvCVQSgbf0gCFqyXh+c1FigB9UYH320a9TKqoxuxoSQkLqnWf91eaRqBj55by7368KtjHr7TWq07SVEn/ZLCWMmhzdTwd5z7JudlnjphCmMi61tfM+N3GVKOrQBmXwIxAeMopMRryYsH0cw9btXvzXL5EWRMJeW/ALFyv/bRkRdBMNGXz+Twfatg1rb3JDari6GhoEAbtwhaA0o2D45gnQQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeD0ZUQO6Dd9eBcVmI7HzIlHpQJOjM8wWdoM+Hi8Fx8=;
 b=N39p4CHO+MVAC+Nc9Ro1DXIGL/0BiHy3LoOzz2qsmlOpCWAaa6E/dcxLb9Hb+XPhS4s1xLIK2Evm8ztV7yDtHthTJCRUN9zCpfANm6wIVN0xOHFWYLlWBg5Te5wnmxrauthB5WptBjqKtjEqr4zcs3NvwAwvShepruTNMQ6qJM8jdpvSoyCS9dp3WvezOYIOANe4GCpn0cLkJHcV7qZhEae4Uk8Uy0eBO6GOjeongriIK2YewYwCFsVTJbSSSoBCRdugSyDQaTTVE6jhxg9UxohA+BV+LYCdqA9AdX8KFO2aACOnmnIgskdQG7OyZIQ1ec3W7yOsTd3X/Ipkfmb74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeD0ZUQO6Dd9eBcVmI7HzIlHpQJOjM8wWdoM+Hi8Fx8=;
 b=nrggVf9zu3MUK2cFkEU4odB5b3mhBN2fy5PlQSIWUW00SsvaW0OeEGS5SK+dnzqTudy3JcgjspovM/kC/baRGpQKFIiRUOs3ga1PKTaikA0DjTC48vUff3cxz5Qg7nr2dW0mFXP9eChY6G4hECPxd2laPsv6cpOxvtHzwmJTXyQ=
Received: from DM3PR11CA0006.namprd11.prod.outlook.com (2603:10b6:0:54::16) by
 CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 19:11:27 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::82) by DM3PR11CA0006.outlook.office365.com
 (2603:10b6:0:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 19:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:11:27 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:11:25 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 2/2] ACPI: processor idle: Check for architectural support for LPI
Date:   Fri, 25 Feb 2022 13:06:46 -0600
Message-ID: <20220225190646.1045695-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225190646.1045695-1-mario.limonciello@amd.com>
References: <20220225190646.1045695-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c340fb-3280-40ea-9e97-08d9f8929f55
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0184:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01840472A2C8055C581E87B1E23E9@CY4PR1201MB0184.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17WWnhZisehKXqS18JU2FRIXpQ8zgxNuHWomDSKsL6N4vM+LT5F1a6Lr/Q2XxNAfgHzanoVOwtGyK3l9Hc2IiZFnSieMStHrtt565f3DT1LIroeEtEidNNczsUhYAhysb3dU+1ysbNJGAkxKY4Z0E9klWcmY/IWrMbqLIGO7v/xmGg2XiiLEelm2gfvcvrtFNWEfv97zzLO/ElR3751ombQF8uVYTV1uZ9Fwo16kcQiEcKxO7TFyEurHaTDM8YjCoL2FZ0AMmrXEvkxGd/kjyGJKfd2gkpUy5ug7RW0JZgDMgNRt1MdmuT2QFsYAdQY+++nBcrcS6SDGFbcWUIU4ojz4jtFHlQqawsttLhW4dPLlV6dZhLf79J0XqkCR87bhmDcdmgfQHf837FY3Jy15+3jW9dwaogyJfhsAjlM+K/2RqD3lDcvQCoQID9A8HH5KfnlGQzALsC7OXR9sEFB1j+IqEyFSSdjnkKYHV4V30Gnjv53Vx3Ws7250305bordm4Q+Cu8KpA/p5rXBT/HPnt4LKNoouRmqsOswPIPA65Zk5fK63xUIVROSPE9TuhALxQR7djDrg5OJ494uSFkZm8Y7XNUYJTc6DMM7HZpq5pwD8JWWlvQBYtGqL4y0nicDFtjIu1789aXTS2aY3b3Grx8qFt6yEJIQTlc9jMXi9z9FFkWn8BPG9fcyWq5+fVhi6FhNBhwvsxtfOVt/D/d02iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(186003)(83380400001)(36756003)(356005)(508600001)(54906003)(110136005)(26005)(16526019)(1076003)(336012)(426003)(81166007)(86362001)(2616005)(40460700003)(70586007)(4326008)(8676002)(70206006)(2906002)(82310400004)(47076005)(6666004)(8936002)(5660300002)(36860700001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:11:27.0644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c340fb-3280-40ea-9e97-08d9f8929f55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When `osc_pc_lpi_support_confirmed` is set through `_OSC` and `_LPI` is
populated then the cpuidle driver assumes that LPI is fully functional.

However currently the kernel only provides architectural support for LPI
on ARM.  This leads to high power consumption on X86 platforms that
otherwise try to enable LPI.

So probe whether or not LPI support is implemented before enabling LPI in
the kernel.  This is done by overloading `acpi_processor_ffh_lpi_probe` to
check whether it returns `-EOPNOTSUPP`. It also means that all future
implementations of `acpi_processor_ffh_lpi_probe` will need to follow
these semantics as well.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/processor_idle.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f8e9fa82cb9b..32b20efff5f8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1080,6 +1080,11 @@ static int flatten_lpi_states(struct acpi_processor *pr,
 	return 0;
 }
 
+int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+
 static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 {
 	int ret, i;
@@ -1088,6 +1093,11 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	struct acpi_device *d = NULL;
 	struct acpi_lpi_states_array info[2], *tmp, *prev, *curr;
 
+	/* make sure our architecture has support */
+	ret = acpi_processor_ffh_lpi_probe(pr->id);
+	if (ret == -EOPNOTSUPP)
+		return ret;
+
 	if (!osc_pc_lpi_support_confirmed)
 		return -EOPNOTSUPP;
 
@@ -1139,11 +1149,6 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	return 0;
 }
 
-int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
-{
-	return -ENODEV;
-}
-
 int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	return -ENODEV;
-- 
2.34.1

