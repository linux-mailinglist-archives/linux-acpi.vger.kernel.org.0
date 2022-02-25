Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995064C3E15
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 06:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiBYFzd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 00:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiBYFzc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 00:55:32 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199B1E6952
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 21:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imk/hoNvpDMiOjKTKsi46+A8psMwzhN2M8/Ua8YTjAOpYWe1YZhQ0HfrNJzsSW35XeHmqFmAnCFFg3sCK4svz1GAe10bNO6nLirlRcS05vRrxYxuaGjIffSTf2C7uWLDcaWDf+hO0JuFpAARt7UWUZwn2Z2XCjMLt9kWp5e4eUiLGcvMU2CxIgtMmiQbBkQmKKbrNoHu5k1ykAQFNg1sX/cKIAyh4cTkzGbQ5dXLaTy69A5XeZgCKHtH4GhSRFa4+dzdQSFUjl91jVjTDg/b7hs3+jqB3GMnMllp7h2/0JESOAkXGPt8UJlEPJ+kI86HdjMxn5YdkEbacgnGZtH8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frZvKWmaoTF0EVYxxU6RmdMb4B+USrX3720BxL3BKEg=;
 b=GqJ3bic+0lYxMBZJr58WblIxoNLFS/1tCHslHVkXGblCnvjBQx+dkjCY5YgnU27VqXRyfypP7H/QiQxJ2Tnv4kQVP8JuDLVQywuaT7NuzmTmK7gJeUZ+6k2ylut/D7ga+3G9XrOb990ulYmti+DerBBPUZn3XJkYHPNzYWxDBHuqAki3xb4bknrYjUe3eJu2fPBYpjs513cJk9iDl7iTxFje8Y3NUs+bMCQ9Hgkxcb5zjdNhwTP4jflbJi+qw2m4PM83wJMxa1a+4M54T0U17RAisRpQGmxTBRZKEoiA6Xj3pKxNM+VTxhdBTCb2MH8eubFokY7MOBDJ9l7Tb3PsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frZvKWmaoTF0EVYxxU6RmdMb4B+USrX3720BxL3BKEg=;
 b=2VCzAX/YcbWt/99T4r7Uj/MRtMPA7zUwOz07uu9jRVOq1zeNvtjuK/tjvMJVI6yFDuy3TstvRKI7Uv4i9NQLN8hcrvpvh70+fVFoBnpKlD8Uy5RHLwv2n/UTcl8eQoTX4mlGKIgif4YlFHIYk+4U5wl5vQsu8nhqxSex5R8qwLk=
Received: from DM5PR18CA0090.namprd18.prod.outlook.com (2603:10b6:3:3::28) by
 PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 05:54:59 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ca) by DM5PR18CA0090.outlook.office365.com
 (2603:10b6:3:3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Fri, 25 Feb 2022 05:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 05:54:58 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 23:54:53 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] ACPI: bus: For platform OSC negotiate capabilities
Date:   Thu, 24 Feb 2022 23:52:24 -0600
Message-ID: <20220225055224.190669-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225055224.190669-1-mario.limonciello@amd.com>
References: <20220225055224.190669-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d62c59b-568c-45a2-0165-08d9f8235afd
X-MS-TrafficTypeDiagnostic: PH7PR12MB5686:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB568622BE4CA33D66010153F5E23E9@PH7PR12MB5686.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3LVBCu2eEu7tBTjAPL43bBL0QuVWR/d5CPNTRn6KrcWOp4HcLOA4XaAvPhB2Chd+F+d5BhyhWZZE/XTLoZlcrrD3wr33Ix3KRFhNPJK4WCHxpQV8jUTk83fp0m3iCvWk/VP3ZldXSI1cFZsZwc3vQXRxmf5wravbXho+/amm1aeFZ6s8Wi0kxsFJ7OTLBbYKN/4PoB9V+4QCGL+W5RwbeJ99DBgAU4UtbPqb732p/2BI/Deq7DQURjUpqeuauZwVImimmhb/9OCtO8PS4wWjSSBThFnwpbZgCLoH8kxCxJzac2UYy3k2lI2s4sUcFSs9ZMat3nmljzPyl3Jkd4heRTtnu2mmYnC9MgdYVRgJ361egHgtk4R02ZW17P1DAGVSQtT7fkpEBfqM2QJxOmG/dKPetwgOtEgTb1NpDfN+pLYjI3Do8PYM/5xrySRRJ17XUmO6rwj+fTNadewY/biwkfgkArJwNhHLs+bbcUoDOFvQr1gmb3johAqb5+uj2jhfEaR7ziAd09WUU/ispO2p4MzCxz2S6ulOt3NbENxetIBPjp2igp31F0O5KImeUSpSdH8SmHOfgnULzObAq+y7DPN71yPlqjaQTSFiF0dYbF9GpYR7XE0hqRwzXuL8K31+sa8hZCWqLEyYV9Rv9pUy8pt9+tICP/AJGURPInXG9eUbMBvcFR12RpqEwDa0T7jeqipb4SOxWxA8wWnHL46qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(82310400004)(356005)(40460700003)(6666004)(508600001)(110136005)(54906003)(2616005)(316002)(16526019)(26005)(186003)(86362001)(81166007)(2906002)(8936002)(70206006)(8676002)(70586007)(426003)(44832011)(47076005)(36756003)(336012)(36860700001)(5660300002)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:54:58.2772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d62c59b-568c-45a2-0165-08d9f8235afd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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
OSC and this leads to some problems on some AMD platforms in certain
configurations.

The following notable capabilities are set by OSPM when query is enabled:
* OSC_SB_PR3_SUPPORT
* OSC_SB_PCLPI_SUPPORT
* OSC_SB_NATIVE_USB4_SUPPORT

The first call to the platform OSC returns back a masked capabilities
error because the firmware did not acknolwedge OSC_SB_PCLPI_SUPPORT but
it acknolwedged the others.

The second call to the platform OSC without the query flag set then
fails because the OSPM still sent the exact same values.  This leads
to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
tunnels can't be authorized.

This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
same capabilities to the _OSC regardless of the query flag") which subtly
adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
with query bit clear").

The OSC was called exactly 2 times:
 * Once to query and request from firmware
 * Once to commit to firmware without query

To fix this problem, continue to call the OSC until the firmware has
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
changes from v1->v2:
* Fix a NULL pointer dereference caught by 0day CI
 drivers/acpi/bus.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f0f9e0934c10..489cc4f6b6e6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -297,6 +297,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		.cap.pointer = capbuf,
 	};
 	acpi_handle handle;
+	acpi_status status;
+	int i;
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
@@ -332,10 +334,34 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	/*
+	 * check if bits were masked, we need to negotiate
+	 * prevent potential endless loop by limited number of
+	 * negotiation cycles
+	 */
+	for (i = 0; i < 5; i++) {
+		status = acpi_run_osc(handle, &context);
+		if (ACPI_SUCCESS(status) || status == AE_SUPPORT) {
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
+	 * avoid problems with BIOS dynamically loading tables by indicating
+	 * support for CPPC even if it was masked
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

