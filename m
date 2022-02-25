Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED98E4C3E17
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 06:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiBYFzk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 00:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiBYFzh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 00:55:37 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E41E503E
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 21:55:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsWKraWgHRpQbbwKgOOIZxV9kWLs8tBX9jn9pkD16K8sjmOHYNmJBMuG7ObHJzNWRf1PDT6EGmf+sbKTRQnQWIOh7tXK5Xl1BKzB9/6Gv3W1TUJsd73Gs7Vn/+XnqNTZPyHMkd6aG1udOOG2ZqtS7sg2Xq56V8E7g4x5jY2cWaeLF6wBSjIY/hiBqicuxPzFDXx2hEHX+9wL9ej0iTatu1GnSooU0a6U19oIIVuwSk6mCoRNmezeVo3kybDdGSwa0BiAuentvpHdX1H3/+UfyExTMHfhWtbJ9ITWi59aN1GdvoCBOG4mBjaC28RiUDuVFLuFyAZuP5Akmtu9PhDQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OBDk2CixDDxle2CMpNWbhGD7JENbGtfR8HptFzWZfw=;
 b=CrXYKBz89FCPh8/da1tNztisrJx0DKsTrDj7E3qaBHplqaDEKK+l2wb4OLrZQwWbh/dSC7RESSG0jHQ9vs+Q49f3lzN0oleEQc72HXHuLjVcNzFOH8lMbS7zsHUNaC6gZHGp8U/uIo9dUJY/tFhIywZPxypK+c2K/ZJSjhJxNRPwxqh7vTy/2GPkcl/zMeWri0GQh3WKdgATGyx4NYbAT0r6M+yfSA3t492OaNF5472XNYBDUu79UyIKlGysjT2v4dy08nopyfsgzXS1vqVsVzpnlAb29cLn1NZZ2KH5OhghkeZVVogan2FKYSdJzypjP0eFGd2NtEHqh6nvjJYNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OBDk2CixDDxle2CMpNWbhGD7JENbGtfR8HptFzWZfw=;
 b=aMQ9rge+bjDZvrvPBN6mx4SJEtM5d1b6ejJS4H7RrlawRf8sleZqc+KuNcOZagcE0NVtbfhgYyXRaFY7SvwyK0sgAfsOskRX4B1MiB/iP9fYdZ5hERcLMA1TdrfSCqm2GlAeyuwH2AIxdLkcitoLDIvTks0OsKuCGk2VuOsMjdI=
Received: from DM5PR18CA0090.namprd18.prod.outlook.com (2603:10b6:3:3::28) by
 DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 25 Feb 2022 05:54:54 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::57) by DM5PR18CA0090.outlook.office365.com
 (2603:10b6:3:3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Fri, 25 Feb 2022 05:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 05:54:53 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 23:54:52 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 1/3] ACPI: APEI: Adjust for acpi_run_osc logic changes
Date:   Thu, 24 Feb 2022 23:52:22 -0600
Message-ID: <20220225055224.190669-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e63818c-a354-4d3e-0da8-08d9f8235853
X-MS-TrafficTypeDiagnostic: DM6PR12MB4863:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48632D3DEB297C42ADB4D614E23E9@DM6PR12MB4863.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGoSXdPnUAU7SbGl+F6qEZZlUvbL+rqQ+f4k3t7aU+semW+CtKiS1z+gOUVkpeZW8kM4NxzpoZNVtnvkdH1hPv54p44/hzy3BEAKEfEsF9KBTm3TXra7RtLgiHcThhHqjNy/x4F3vZ9FP1gZ861fN6OaoVL+fdayCeoiHtYV0zRY54TuvtJnq0599Ar6qdoDdnSwS5IAnpfgLLjnkm1YgWTctMtx3J2SE0erAl4cOhjtIm7gz1G4mJMk7G5e9DDFB+oCxvBT8CT6slgufO4PFQ4Eeb6v+99yBpQkEzugWU9GbMoOzZwtGU3FwrK6Oqd8pxBARWRmzekpc+JaQs0D7RteiV9xfVAMKBkA+eyeloSfdvItHLuyRSdDCf3KgfAa1lKtuvZzUdoaiG2fUqMDBJ/vQ/DplRbzILZJGRPLq0Qgui1OiryPuFdP0gFhkI73asy79ypS1m2RJKT+7dMAauH1W9ZgpdFdL++yxBVdZGRBSXqGz8d0XusNyj7UZM/RyQl7Zc3BORSvdzm4t4BpRLFV0jdcO0mpWWrH9q64wGUo+aKH9ViGVVrKhCTJ8f0jxbwg4QiMc3p/1AhknI9b73AXYH46adyOoVhvDW8h7LjhN3fnQSddcV0FSZ9uhK0QWfmZwitOkcPXUEZ0THGXf9bSGNsD6CVWpFPZWJ3m/yrQxJpIo/mnSRKet0ZVrNjeTt8YY/TDOgTxUEm2Uoy3LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(316002)(508600001)(6666004)(2616005)(1076003)(82310400004)(5660300002)(86362001)(70586007)(70206006)(54906003)(110136005)(81166007)(26005)(186003)(356005)(336012)(4326008)(83380400001)(36756003)(16526019)(36860700001)(47076005)(40460700003)(8676002)(2906002)(44832011)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:54:53.7924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e63818c-a354-4d3e-0da8-08d9f8235853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As this function calls the OSC with the OSC_QUERY_ENABLE set in
OSC_QUERY_DWORD, ensure that it continues to operate the same if
the function has returned AE_SUPPORT.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/apei/apei-base.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index c7fdb12c3310..f7d1aa687fd9 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -780,6 +780,7 @@ int apei_osc_setup(void)
 {
 	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
 	acpi_handle handle;
+	acpi_status status;
 	u32 capbuf[3];
 	struct acpi_osc_context context = {
 		.uuid_str	= whea_uuid_str,
@@ -792,12 +793,12 @@ int apei_osc_setup(void)
 	capbuf[OSC_SUPPORT_DWORD] = 1;
 	capbuf[OSC_CONTROL_DWORD] = 0;
 
-	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle))
-	    || ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return -EIO;
-	else {
-		kfree(context.ret.pointer);
-		return 0;
-	}
+	status = acpi_run_osc(handle, &context);
+	if (status != AE_SUPPORT && status != AE_OK)
+		return -EIO;
+	kfree(context.ret.pointer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(apei_osc_setup);
-- 
2.34.1

