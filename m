Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C04C3C53
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 04:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiBYDQx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 22:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbiBYDQu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 22:16:50 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B611B762B
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 19:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkJ4vnwEa68lmpL1QZ5RtO1tZ1JyBD4FpVdhr9F3sR4fEhZvnA7Vm8TDLHPfOxC4Hrhy0OyfpXJ5mWKWxdjcZ0zx8HXfWKyJGPGgnQAhchKR1eRi+PgbsZMoUmf9F8/alw5f4fUatqi0QR1dvYbt3hjQxWNDie2S6bt6sM09bmUKz2oT+9a2cwOl7jqbKWwxtx2ak88BAEOxuKGXEQK257+T4R8dLTvgVYYLCwKlJQuqpEvMM8KOOjz8nH6FyKtRLvqxqKwEWbmvio1E4nJJmmkkPGSdjLm+ui6/YglZ6yDemYVFB3O2wFtI1F1jLkqb2m5KAdNb2EmQ1E3E5rJrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWuTR1UVYaf0lVNY3KJdtO/oL2LsxbNj9vuPH/3JVOM=;
 b=bRdpEXPgep0lJeyoPhKNmxJlwkKyWojbTVJxbTXgRhDoVwzaJK7imQY2CjwVAROdtPtQWvGg5jP+stZUYKSdoJ8dySpBZ9MBFvB503D6nVQPfzJXM5UWdY8TYqsTkHfej4Wv5YxHNjZKvigsQjWuw863BZOCQTuZL4sDbADZGNDldx/2DwLJEi1y92Qe0pb2hgpNlDrCqxYEzy5mCsUHdfYXxk+z9mZZ9CLk12DY3Yop+Ew2vXlyFZ/i1nZCdiW3FnUA9rVvoAYBgrp8BbGLYK3x5XLQ7KvN70Sm69tqWwp+i8eCGHfP3u7E02QXfxqS/6vHk12oxFaXt92gjrqWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWuTR1UVYaf0lVNY3KJdtO/oL2LsxbNj9vuPH/3JVOM=;
 b=n0fyxP03pKuSb4803hQujoB3l14SOdhYbA21G689+/Uq/uYotZZlN9UGvm/5dt5Ir/ofo4eBQJMMEC8wpSbNtRm+1olhemsidStsftLo3j05p0qOHe3+JGFQK1+l1Q09fFtYbE5ii+4Hq6vE3j0C40/dW46epV+aiKp75JRzgKU=
Received: from DM6PR07CA0078.namprd07.prod.outlook.com (2603:10b6:5:337::11)
 by BL0PR12MB2435.namprd12.prod.outlook.com (2603:10b6:207:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 03:16:17 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::eb) by DM6PR07CA0078.outlook.office365.com
 (2603:10b6:5:337::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Fri, 25 Feb 2022 03:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 03:16:16 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 21:16:13 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <Ray.Huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] ACPI: processor idle: Check for architectural support for LPI
Date:   Thu, 24 Feb 2022 21:12:55 -0600
Message-ID: <20220225031255.3647599-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225031255.3647599-1-mario.limonciello@amd.com>
References: <20220225031255.3647599-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61402018-c336-4381-d28f-08d9f80d2fd3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2435:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB243521D45AC351437825E739E23E9@BL0PR12MB2435.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZa5ed9V+fdx199Rqv3irp2Q+HBqfMLtLhxtMRbn55m8bSp8MAOR5qvSUEdTXIRtB1OuMqilJkayDoa4+t+UhkNFllP8Oij4mLZzHciqT9XU0GvJ9jmU7nDUKx4NJXsP3NgTxq7nGVHdee/Ezv5esGrCSZQ0/8szQ2YLZzXFnK7IomrybBP64neFiJWr+WdnHUZsROon8OFPHvWLCKhdPKvm/h9lASavuZpYbJDOQvrohKX4zjQ21vtW/On6E4m4M0SA/W9Ol2iurO82yRgbYNZmNCMjYPvktKQEPukCmYQa9Uk7L4jetRWyQCsI4+bG+jT/neoZTJykaPNzRTAA1Auhy2yzS0EhCknOYCvVavRQ1yrssDHo3CJqbmmcQDNngBLgpBf1X8QZB75QnQiYlkReB1g5x6yYbT3PEKo6Z3DBjP1tChaHzixCWqqKWVQhYN4As36UKvm2K2trKJ7RZRhWxhIFGi9RR+CADLYDgH5WUjjdwT9ZDn/rcV/WHqojJGcERIDMPPYOFPp+GsI5nKu7k2F5iy4SMGPgGAloXYSWQnslSrr+tH2P702qmYKPP+BxGJAJ/hU2m6isS+xZfUx+wPdOcLDHgJSDWdoj36RNCixK6ocfQO4e5X2eWVzdkpLOEmdIjMzMJa9WwUOxan/W4d2aB5rGKmw/frEhF87ZasgEH1JFOmoPCt/yyNAHYkc7xx7vieVawQJwtTnMkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(5660300002)(356005)(36756003)(44832011)(316002)(8936002)(40460700003)(4326008)(70586007)(110136005)(54906003)(2906002)(70206006)(36860700001)(508600001)(6666004)(81166007)(16526019)(82310400004)(426003)(83380400001)(26005)(186003)(1076003)(336012)(86362001)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 03:16:16.9372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61402018-c336-4381-d28f-08d9f80d2fd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2435
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/processor_idle.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f8e9fa82cb9b..0092fd479527 100644
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
@@ -1094,6 +1099,11 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	if (!acpi_has_method(handle, "_LPI"))
 		return -EINVAL;
 
+	/* make sure our architecture has support */
+	ret = acpi_processor_ffh_lpi_probe(pr->id);
+	if (ret == -EOPNOTSUPP)
+		return ret;
+
 	flat_state_cnt = 0;
 	prev = &info[0];
 	curr = &info[1];
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

