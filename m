Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2E64C8C05
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiCAMxF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 07:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiCAMxA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 07:53:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0A99ED9
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 04:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldsykWY63y34kYgQXK3nQ8By9rOlps3bUZ/DBeipo66XpJRPtuhf0hlei3YK0rBnfj0J40hlT9VwZRnwop4PDAmfYNIkKwV1PL7QJKzBD6xAqRTS7zASd89EElIXuYZPQvfxQHrPsYUGqBu3nrAaKmEfvpGCnfJpsdEQCFAh7xFEbL3A6hwME24YJcB2E9xgkmOoPOeT4IiZzZU5c8evf8E5b56C4GtjwM4VPFtaC+QEDmS+EXZKoqs9ux5OcdgU0fHQwglNGaNpwaAaDJKfUhEyf/p71ELZ0p0PuiU8P32QAYYOKEC/7wrlFAz2kpSfm20ExRNpRCewEVi5y38L9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inIVfV/M2oyk6iS0VTYlUHhAKyb0baVA9oL3d9sC6+s=;
 b=ltnftWQPf2V0Phx2h53Npx51wOqowSHcpLFoObd1OFyG4wp1Xw6EvRvBqdYRH3zffHyUZQTrxIE5euZFQbLZdDTLgqzqYzampFhrvf4trt+DF0zDDpFLppSK6kSmGvKjE38XTv+O8BoAo1lFce77yPkGVsF3c/L5jYZXeu249caPYVgp/N9IoHn1bAufsqJ85KWBcI8ARx/Mae5lCClfY4j5kPS87d72/FTOc0Tcy2dkjcQXj0NhoX6oii3CKXUa7Wnw8M3AbDI8b6wwBiKjY7XRQXnbaC3HBeS23q+cq2BwTUpOdlZHpVEzCPq5NA4cSitOmnNsH2Kl7u74tkuFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inIVfV/M2oyk6iS0VTYlUHhAKyb0baVA9oL3d9sC6+s=;
 b=EqtHwsJyDOkTE5WWpuVn+rzKV4+NO2SCcNLIdTTHdLGZkEb7S6BfdPozJUcQ1UkGY7rZhvxGtXZrMsrLWprswqeEf9ReVqVVR1iWdLS8rS76WhwhrHrZYfHzlWFSkIA22XwAwCqhzURXo0XAV3WqqUU5Lb3U4zyxKouPKtxbbwg=
Received: from MWHPR18CA0063.namprd18.prod.outlook.com (2603:10b6:300:39::25)
 by MWHPR12MB1712.namprd12.prod.outlook.com (2603:10b6:300:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 12:52:14 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::86) by MWHPR18CA0063.outlook.office365.com
 (2603:10b6:300:39::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 1 Mar 2022 12:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 12:52:13 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 06:52:08 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v4 3/3] ACPI: bus: For platform OSC negotiate capabilities
Date:   Tue, 1 Mar 2022 06:49:08 -0600
Message-ID: <20220301124908.1931221-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301124908.1931221-1-mario.limonciello@amd.com>
References: <20220301124908.1931221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1acbb9e7-d9d9-4420-a43b-08d9fb824ee1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1712:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1712941B96E6D6C8E757A628E2029@MWHPR12MB1712.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmNO1FOCFBpmVhQfQ5ccEedvtVyktZo85UEzrt+8sR6pjHzbcZLfdRUkhRCwLGgM9yHjVvmFhpCtwRNdcP3BCraWF9RRC0ZN0oej6OJdTZqUhY2kS30qYB09yfYP4Mvxj5fXn6HIK+vqTaXLnmjR/d4pmGregMDItnAn62QQQGkHTpBCO+BAJ5dK+d85/s0FPsBG/tATlxsTY1IpT11cgWlJFdPQfKMVk9kLDBrALQUMHAMk7QHLfKeZU+E/QShloCip+acei7PmPOaDAqSpsAu5qL0b+XWK2Y9oVoVySpBIbRSxeV4NJfd8n1yxWRoRFjGcE0mqzmKa5FlQEIiaDxAlB++n+U/WztFcw3lrYHme+Rg3v79cpjvKOEAarp5wWSKJMjKgU4o22PcYxo+m8TeKIVJdd2D8t2kRqg7mRU2JiGrr6oavfZswujHTvYDI3MOoE35ZKF3K6UfcyhlBRUuumyr0M+BAjmnX1SHz8EXFSrP+Xrr+24/dJAY0g2jIVVtJMM3C0JY0K+ExCHbUMRgVOMteW1zmyBtKLV2vRXsHZzX4O1zbYTFaUx4dTzccsQFA/+bPkmVnFman3VgQvE81dj4oDYCSa5cFbcEgHdQRMTYsojXfB51lLVw6ztJlhqrrOz6Yzz/WDVpBjQBOrfTgoqSLMJ6yfCs14uL3X6Qj746RoRIHi29qXJwKMAv7BGfyxrPyQKKO5RBXvw8iDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(2616005)(356005)(110136005)(82310400004)(316002)(36860700001)(8936002)(2906002)(336012)(426003)(508600001)(47076005)(70586007)(44832011)(70206006)(40460700003)(81166007)(36756003)(16526019)(186003)(26005)(5660300002)(86362001)(1076003)(8676002)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 12:52:13.5647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acbb9e7-d9d9-4420-a43b-08d9fb824ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1712
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
v3->v4:
* Don't use ACPI_SUCCESS macro at all to avoid confusion on acpi_run_osc
 drivers/acpi/bus.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 302619ad9d31..c60c7c7e0149 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -308,6 +308,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		.cap.pointer = capbuf,
 	};
 	acpi_handle handle;
+	acpi_status status;
+	int i;
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
@@ -343,10 +345,34 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	/*
+	 * Check if bits were masked, we need to negotiate
+	 * prevent potential endless loop by limited number of
+	 * negotiation cycles.
+	 */
+	for (i = 0; i < 5; i++) {
+		status = acpi_run_osc(handle, &context);
+		if (status == AE_OK || status == AE_SUPPORT) {
+			capbuf_ret = context.ret.pointer;
+			capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
+			kfree(context.ret.pointer);
+		}
+		if (status != AE_SUPPORT)
+			break;
+	}
+	if (ACPI_FAILURE(status))
 		return;
 
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

