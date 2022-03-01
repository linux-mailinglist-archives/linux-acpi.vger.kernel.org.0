Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C34C8C04
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 13:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiCAMw6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 07:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiCAMw4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 07:52:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA8C99EDF
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 04:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3YwUd1C08akCeDUBGKG65y4eNqrKX6iprZGVvysPyFQUttmS4lZ0vtmCrdl6bxUCm3I1AfTS7ShmMEgCacSv1hUfUdCZ2M2ptHWwpssPzHbABAqMkoUY0TuwaPM5UavX9a7pFznqwFp8o13mtCsVJzrDXbkzxVZxBJM+lNTrbp93PEKUAYFaICjw23RmS+b36WMaHmD+KqBoEBwg7G0A1vq6azJsQF920WmRzhmbkXKbUaN7cV3XAGEsYvEXmSVBhzFxabFrldsVAdK3UGyosxaHkR38Eu0ICIbWoIt2wXOi9d+BOjhnXA05rJ/RIg/VuuHLMJXhYCMq2xFJtpQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLTaHmlcaRqtqRwNxhXpiJj2uP0A0sBXEMVgOlVJU6U=;
 b=QsEYML/5QIoEuDmStN+9cFuLHSwQV5W2d8Fg9e2uy5uV0uUT63lqIU3v8wDNPXuLa+qxVZGcTQ7VtY0rnaLfgyQzdj2x0bbrnADSAXbYDFpbJnagbO4ajSUmSmVnkSPNjK7CLU0FlsLq82qmwQYPqR58tMaDQ+nT5UAhaRd6sXRg4t8w0d4LP8HCidoltGYznbnWOLdILPM0uF5fTt5DhyE3C3Dt5HBXkyRvFd0EDtFLs5GfqEtDfoLCqwToTTpq93b9hPKe8JOFhacYQs1HFSMR7dUYjQRs2I56fOgsJ3iFoE7wQkNZTSmL1AZC5ErNSL77b6Z5lYEKDmL5OFmsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLTaHmlcaRqtqRwNxhXpiJj2uP0A0sBXEMVgOlVJU6U=;
 b=yYTwO7CfjUiduzmhnztRSWBCoDEB519LeHbND5/KcYvVEJ8SsogRnNV4vs7MNT2pH2ATcagnuTLNMwxgJg+gSa5y/egBluy8fOr+dUhBgI8dPkyLBkcGS32Dwr140r03OggAKlo/FPEkxQTb5XLsCeER2hKce84VjYDk9FSkWFk=
Received: from MWHPR18CA0051.namprd18.prod.outlook.com (2603:10b6:300:39::13)
 by DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 12:52:12 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::16) by MWHPR18CA0051.outlook.office365.com
 (2603:10b6:300:39::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Tue, 1 Mar 2022 12:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 12:52:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 06:52:07 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v4 1/3] ACPI: APEI: Adjust for acpi_run_osc logic changes
Date:   Tue, 1 Mar 2022 06:49:06 -0600
Message-ID: <20220301124908.1931221-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 943b0dad-5e55-41b9-a7a8-08d9fb824d79
X-MS-TrafficTypeDiagnostic: DM6PR12MB2635:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2635DA87E7C8E1D19BD17DCAE2029@DM6PR12MB2635.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNJk0of1Z+R4te474E/o1Q16rWcUd5ee7WE0Zz5Tq0rxm3VvtfG1HEqdhCNc1LZkq7ot9fQJx/EINIrpsKU7MUj3lWAvorQuNMW/xpMxCZ/PGpOqrsbh/bbF8o1NRedU21fmKrYzbjA25aki1JKfrzazLSLkAgOQNY+k6zm0NfO8qlBZwy6KkcW78NtHYnMKs3Oal/cP36mDi0qx1CQIVyM7bTW1wBPuN7zGg1UYHzZTXa8jffMoH81K2/V5HsV4J2qVgjfCxtZv0g0j/ZFp/Nbrixxni/rN0mQEpF8e1qQk5KtBdT8Zx4G+sJTPFPqQUzKZjCuKH7BO5i3X8u1u4KoMjyH/O4N7YgXuCuOfk91gbb32zbhJpTcgzPVQ3ETHamRIWyndyIbvxkqBdWvdnks1CnC7DCozU/xKrGgFWdPdAX3V/jOuywUXTlGv82jolw6h6gitau+vc0g8y002YmtbCFspn1sFU6SZGhXex/wNAEnbmLITBM/CJgXdmIpbidqGbYAqfTLb59b3IkMg1FbKV5Et8Ng0hoZeW45PJqxFr5RoAe8Dpl61wLCmuO+ifTgrw14vROZWKFDRuDNhvmsYVzM7lMO0I0vbbGoZeNnBsSwOWaSvx5YvLcbr5SJiHV1VB66pFWw3vDx2eCa3WE/sQYcqm1ED+gx5jTwnz1/GfmtQmGWZwbz7nyz+J9m35UoRjreZ30U6Y23zIjxK+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(426003)(336012)(356005)(47076005)(36756003)(2906002)(44832011)(40460700003)(2616005)(16526019)(186003)(26005)(1076003)(36860700001)(5660300002)(70586007)(70206006)(86362001)(4326008)(82310400004)(8936002)(508600001)(8676002)(83380400001)(54906003)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 12:52:11.1899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943b0dad-5e55-41b9-a7a8-08d9fb824d79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
* No changes
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

