Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B664D539A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiCJVbM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 16:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiCJVbL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 16:31:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E6F190B41
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 13:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNhEU5pH52J1Zw0yIeuNWRZTFvTpCUQnX7qqe8fQtJwKv1odK210p9h0Z/RhpOuR12SyjQvCY6L5/YEsaOuJe7HuRMt8DgNvhpEJe3NXiFlege++6O3eLwNjHv/JmfER4uh/Kjr9Cz8KM1xE+xMlGP1kRHk8G23V/stUScXYwP1R826V2z+KY+4kiMhk1UBmUDBTvmyhJDFstAmHQyn3yycwVzKWs68tSHHtUgmmtgd+tBsctPdvNFGkJf1ruS3eCQWWZYlFUXayzz5PKtAVWb8AZc7Fbgom5asFnq9jDoEmqNJR3AhNWfpbLjnbNUrNKnGFA3uYSBbtBx6Ijyhz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5y6kQIrSTGBftt/Vy0b1SEZr6eyxmvJR9TU2UfemE0=;
 b=QzEKjNLu2OLEpA3jY5zeRS78J1T09ocnodmpvyRhaQLT+xZQeFbtAJKHttR+sMQf815xrEbuz/GG8h6f7vwQ/1hip6n7F11FPIVXgbz6d6bS8YJ6jvDrcnuHxSNMkHRANVQ/xJQ9iF6PNhjKSlJRO6cPhDsAULg6XcUwJ9k2uyIRQ3Dz6kCwuIliRhOvJf7RuNiVHLC/gg6CXvwwd9wJV0se60pARNFya6j6vgGMQpk0E/3v0a3xOKe4YZyVh32/dkTSOxggSYG0V1pjgINFlyKb2FlNn1zlXhEKki4P7oiiy5Nuz6ggkfrJ6dM3M4hpRzveAA9JiJa+Iiug923y4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5y6kQIrSTGBftt/Vy0b1SEZr6eyxmvJR9TU2UfemE0=;
 b=HTnfeRWj9FbNfT7q89jWKjBteLhzvhSsh6uah7JMRhZ39eJsAcW3Ni/EpRB0MNGei/f5/BSWA8hpH8oF52Y/NrVVsl9W96dVXdjunZ7KU2DsfrSyAUuBdJhL5eQLBheZXUTZndF2Q6R/GisQATMMRkQyzRjol020852ixehOd8A=
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 DM5PR12MB1467.namprd12.prod.outlook.com (2603:10b6:4:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 21:30:07 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::ea) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 21:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 21:30:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 15:30:05 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
Date:   Thu, 10 Mar 2022 15:28:05 -0600
Message-ID: <20220310212805.3786-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f436668c-e2e6-40f6-a709-08da02dd25fb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1467:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14679661808A8E2CE9D35724E20B9@DM5PR12MB1467.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXwb/sYVqkjedRm9wq0cFlGvpAg64N2Klgt1Nu0TKRRqija+sXku9prP/kx5FKX6gfy427o4hbZk6Dlc91AV+JYXsu0GuMp4o7HxaETPUxeeb6Kr7RxEHxDSJkwR6wUtszN9Ew/vi0iHhiidW8pcw8z0S5wNPWcS3pDY1RIZE1yn8qwMV0Tj1d+nFX6Cnwkt4HxAohh6/jfrVX4OD3hobyh7r1v+qyvykNlDSwakZsEoqdUCfDZv+ZU2qH9gVeCLPyn8trc59il3MWC//fIZANBoH5CNDfq/pKDn7Jj1mJFI66JC9WCjk0xA/omTdYir+g6bmLyZvpRIf767fYehEa2x0v+HU2fnmEuJ0OQtkX32DbyJcDiC4HNHErXFgvw9fxa+RQb76/AAeorZEUKP8wuk0iPFrKJaV+SYjYRL1ijYmb0nyrsGQbmE1sGuXsMI2t+aRCP8IP+GrdgWJMvZN9XV6pUlkZBIO3R+3DPicfJWLPIHFjr5UW7jfbMgXCkS6QifazEKCArIXfZaf0giLZEH64EPzqoB3qknVDI3ihP8Gb+9Av6HDa1EDCelHq8LjJ80iPS6WrqzNySa7yknojw4oLxqKXkyg1a+QzuE7XeWuMfafW2hjky3StZmgVaSUb0jr0tSfNC5u2cW7v+UgyMUMEOQpauQ2oFAcUUxcqzqQrAYbw6s2HsOXYX6LXbFaTGJXUEa33Gna7m7DiiaQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(44832011)(81166007)(8676002)(70206006)(4326008)(186003)(2906002)(356005)(82310400004)(8936002)(36756003)(54906003)(36860700001)(110136005)(316002)(70586007)(40460700003)(508600001)(86362001)(47076005)(16526019)(426003)(2616005)(336012)(83380400001)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:30:07.3530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f436668c-e2e6-40f6-a709-08da02dd25fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1467
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
indicated that capabilities are no longer masked.

Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
the same capabilities to the _OSC regardless of the query flag")
introduced, explicitly mark support for CPC and CPPCv2 even if they
were masked by the series of query calls due to table loading order on
some systems.

Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

changes from v5->v6
 * drop mika's tag due to changes
 * negotiate until support result is empty
---
 drivers/acpi/bus.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index ec83c4f6d628..351bac98f70c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -330,14 +330,29 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
-		return;
 
-	kfree(context.ret.pointer);
+	do {
+		if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+			return;
+		capbuf_ret = context.ret.pointer;
+		if (capbuf[OSC_SUPPORT_DWORD] == capbuf_ret[OSC_SUPPORT_DWORD])
+			capbuf[OSC_QUERY_DWORD] = 0;
+		capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
+		kfree(context.ret.pointer);
+	} while (capbuf[OSC_QUERY_DWORD] && capbuf[OSC_SUPPORT_DWORD]);
 
-	/* Now run _OSC again with query flag clear */
-	capbuf[OSC_QUERY_DWORD] = 0;
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
 
+	/* Now run _OSC again with query flag clear */
 	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
 		return;
 
-- 
2.34.1

