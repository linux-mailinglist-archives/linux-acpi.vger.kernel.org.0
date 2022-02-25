Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90D4C3C50
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 04:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiBYDQu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 22:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbiBYDQt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 22:16:49 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1E1B762B
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 19:16:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXTL5w0iIvXcjeQ+duL/uJO0MNdsCGNtAaP5nRSYtNZKzlCoo0EJln6gmFZoV5tZklH4RAEMzsbFPVIWGsKxW7NHXy9WFcv9bmQG0o+MrXKmAkAs1/lLc932cI88snUSZ9N9QL7agqdBkyLI0Ddx87wPXRjHvYDKfoMY0viw4JKmN9XQRmM9C8Rg1TCfHg5d4XndtBE7wosYQnGJREmkHmhmCWXL4T3/H2QRzpc8f5sHCbVn3anEquTQDOzZTKtYx8Veth5vpg5t5CYMnAOUB+aXgxF/tmdXHRWM4zMJVv/DccWtIZ2wGaliDiTNpuYz/b5SJUvUwmf6oCUgQ2uGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usRxm1psKlCW2pLnE89AELlc78b02sx22mNjgIKawAw=;
 b=WVID+us/ruHMV85TAElS7tXIBalJLqMdkNMpLs4cILYga6ev8SYSzZGfHwGP4Y37D8tEityvh3+gEl4j3H9+biBkfijskqlq0WfTz1IilfjS136RWs70SlVIEujGckTSALlm0G0YLGveBzZDL7Z2jUHHnJuMv+wNzc+K7sEDNm74d+KYZaMxL737u/ZnV04UBciSYTtR8fQy7P2EctpTr+b8SFKW/Y6NgNnvVtOuoKja9GZaaYK6GfkjJgOWoe3VlADPaFW/9LpedYVEjfz/IwcExTVgh8o1eyzD4wt6aMAqfGMV87+SbAryaeHKdhUHdBmj7uH4mau/XrBJv3ZzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usRxm1psKlCW2pLnE89AELlc78b02sx22mNjgIKawAw=;
 b=u+asl9qewJOCaSLU0oek7dxdYnoiEJNRBAuOQWAy7jAmWqtZLzdnr/bIENYd/suNIiNK9EaZirR7d7FcJdmz/DVZD+CMSNkdgYLpXyTARlwnb4kuOut7F3m3UEO1Qq5JsD314tTsV2xVMAX4Xy7TlkYFLZ6KQ9D7r7hpUERWQmo=
Received: from DM6PR07CA0096.namprd07.prod.outlook.com (2603:10b6:5:337::29)
 by DM6PR12MB3146.namprd12.prod.outlook.com (2603:10b6:5:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 03:16:16 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::c1) by DM6PR07CA0096.outlook.office365.com
 (2603:10b6:5:337::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 03:16:16 +0000
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
Subject: [PATCH 1/2] PSCI: cpuidle: Move the `has_lpi` check to the beginning of the function
Date:   Thu, 24 Feb 2022 21:12:54 -0600
Message-ID: <20220225031255.3647599-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 19277486-605e-41df-63c9-08d9f80d2f61
X-MS-TrafficTypeDiagnostic: DM6PR12MB3146:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31469C625A65FD901CC6F94EE23E9@DM6PR12MB3146.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ds3CpDX+3bgKr7gad11GhEnd4HGkmSYKx7Q5BxuP0pcu4B+C1P2Tst7FtMnRywb27v7JCMjyQYCNfJdQq1TorwAqsLuy2y9fHCQot7X2RAHfZUESDl+7PjF4mJipMZhGEOEmNLNfI2VbSGfpcCiPV+aIqmmPFQaqJl3dtJ9TChP8g+RaFcUGBGN6px4OFYxIODiSSDtxGxRFI65OIUEY1sTB9q9TpsjB9z4D0eiRnvsckyd5bjRLeWNlpKLpYhNvZqjHmg+2XCm4cUEQUafHlkAPtNDJD3vHCeWehuTMM0BpxBgkALCfVGaWZABrIf4aG7fJG74ZOjzxAU3v3CrQOTPBpE5cn0++mLXM84BcPeKPmwsqVDIrtISWu8oVEx6xCgyLNy6loHNUI5ivGyImu9MaSKW8dFcI7dmtAsb7OQF4OrTlv3bTIcSo8H5BZx66LNtp4bfQ3EuSESSZVVvbcoWa8bv+6GqlcqeBSEJozuR+XMf0vsbruLDkO5/wnaqWASi51fyw0c/wg1yn+DsG5iDbdbaKF8uLapS+EYfTXYl6Xu+JtwEjX+Knwi1Ti10xod2/Jkf+XFo3FlTudCXW9xjCG0jp9v33CHs748YX0C3D0ApZz4JKKmsk8FlwMkKXq1dIJT77grhwE8x0EEc241qye8S8QE2cFIHy3tWKKn4veFZANYu1sv/Xg1dxBIS1ZJurptwESBc+JVDVxHQQQdPhJOK+KP2JkVMrX41Ept0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(47076005)(1076003)(2616005)(16526019)(8676002)(4326008)(70206006)(83380400001)(26005)(110136005)(54906003)(336012)(6666004)(426003)(186003)(2906002)(40460700003)(36756003)(36860700001)(5660300002)(44832011)(508600001)(86362001)(316002)(8936002)(81166007)(356005)(82310400004)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 03:16:16.1873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19277486-605e-41df-63c9-08d9f80d2f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently the first thing checked is whether the PCSI cpu_suspend function
has been initialized.

Another change will be overloading `acpi_processor_ffh_lpi_probe` and
calling it sooner.  So make the `has_lpi` check the first thing checked
to prepare for that change.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/arm64/kernel/cpuidle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 03991eeff643..3006f4324808 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -54,6 +54,9 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
 	struct acpi_lpi_state *lpi;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
+	if (unlikely(!pr || !pr->flags.has_lpi))
+		return -EINVAL;
+
 	/*
 	 * If the PSCI cpu_suspend function hook has not been initialized
 	 * idle states must not be enabled, so bail out
@@ -61,9 +64,6 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
 	if (!psci_ops.cpu_suspend)
 		return -EOPNOTSUPP;
 
-	if (unlikely(!pr || !pr->flags.has_lpi))
-		return -EINVAL;
-
 	count = pr->power.count - 1;
 	if (count <= 0)
 		return -ENODEV;
-- 
2.34.1

