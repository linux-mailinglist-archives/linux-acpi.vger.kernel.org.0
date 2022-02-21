Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA3A4BD4D4
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 05:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiBUEoo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 20 Feb 2022 23:44:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiBUEon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Feb 2022 23:44:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D55F517EC
        for <linux-acpi@vger.kernel.org>; Sun, 20 Feb 2022 20:44:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaLT4y4vk1VkCaNoa+u6yC7QU7QYg3RqYWriQblQn1HwMBvGpYLZrj4bwaE83+Z0JOLgs/cpG8rHpuxQb6EaLIQAWHkKBvSpaKh2P1WYBCv4QDZPIfRyeE7QRShreUsNrMbKYLAaX+AqaKXOMRfihg6xGpI9niEcVjEETjcmMkpOEvm4uytcQgFBtKWWxMDKGCdxkO5jTJshCHgviNz9OthFTqoKE3wpIGOhf1++i+o9D88Y5NfkqPlfcmi/2DsF+rFrHUz4s6fms0VI1tnC/9ENSQdHEIz75G7vjIMiXU6M+s0JgbA66zLzimjRqLieimNMhtrq4ulD1N50s++hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2A6NF1DhNKbyA1J4X8JZ0c9NwjeTUHhjRH77sSyl7M=;
 b=mKvxXj5GOksYDNWrY8250hZL7oyAfOgPAl0RHYMiCCrW+sxV+EGK+yR7EDolz3ztawvmWHvwMlb/2FdzS7cNYntskslW1Ew6xSGT1I7BI8TixNSHI05tKKSGuagXIAEnTebN3GmqMFfgopIIY7JZ97oQcMz8wZ65s/rqCAvqCy3KBVLPUUkBh9u/qEXJO06mSEdKI2lzvRvYAsEG1R2G/JmVN9n9MfKEbz8fB+EqxRr4ofg4zr8m5zri2XNR8AXDSvSKifHfLEurjcuqwz5lPoRGNDbtaaa6PSjBBQcCGJu+Rc8lHrkY0pzLm0CPgkwYKTPK7OPlQtHsmmtwRZwQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2A6NF1DhNKbyA1J4X8JZ0c9NwjeTUHhjRH77sSyl7M=;
 b=ZTXQaZnsWnPdh/PeySbLB44vw3ryWpbALoiDYZBMo9J7VRr4oH53xNTl3D+6VILG/+KUXl5kHob63D/H81H2SMB7lffwZ/GX7rVt0+bCQDJlgrn2n7SjFDXAWb+kcHHy/rw7uyyC/U0Cqs6qRfJ9OsdoDs2zGVipBEWYEeW7pEs=
Received: from MWHPR22CA0061.namprd22.prod.outlook.com (2603:10b6:300:12a::23)
 by BYAPR12MB2741.namprd12.prod.outlook.com (2603:10b6:a03:62::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 04:44:17 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::37) by MWHPR22CA0061.outlook.office365.com
 (2603:10b6:300:12a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 04:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 04:44:17 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 20 Feb
 2022 22:44:14 -0600
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] ACPI: Fix LAPIC_ADDR_OVR address print
Date:   Mon, 21 Feb 2022 10:13:33 +0530
Message-ID: <20220221044333.19149-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d8b47e2-9f56-43a5-2f45-08d9f4f4d19a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2741:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2741EFB745BB68199AF06C86873A9@BYAPR12MB2741.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztkn7jHKCEI+LHBY0JBlgjYQ8G4JhRYEqv3xpCWc+6sylwjAUtAK3afblxOewb51jGD4spPKj5y9ug3Ja7G0pJiclWjr88xOAXclTLG8CaN5w+U2/CJxcl9CA2z8DAcLrjc5r8CgRzrE2CelTHHLIKGyE8KwkAqdltsnbh+4jCdnSNLJ1sbEWycagvlNs+fI9myJqX5vZbJrw7jA8gU67TxJjcc+bpcMtpDGmTIJYLRz1UhYqmZEMaR9o9ATNhLq7exKG3+IOqrjM5SdKLfZZjnfNHAdb+wyoX0zzq8vNLPJXrRngcEPR37r/1pbKsu4o3eARiuVlUTGhJlAQFd0/bH1ZwfWmndMz7+UZicvE/EF6LagC0Lzic4KIPmMRzR6W3edjwGkvLqYUaVH+I6sfT6E5Ulc5mXglf7v0cH78Sxb2MDZoMXtM92bOLl+iWjUtHpNZV2NIIzgeIOMssIPPKHuT856EuNExFKVXusJBxRTMn5eZ37v9ALFcIl9qw8erObZ2qdrziRfDkPcP5kN2nVo0yJBEef0zCmyc3aPOPfM+vLJ0sI72PJcUGDjiEcCEJ0qTYZdEwwHMslN5zSOxx7rtwuMWvHkYll6I1S1+U+Xrb70Ryl+65Cp4YQzL9TiWHPDfGUlS1aO6R9PccPIHKhXtXB93VefRXhYOAGnQAd1Hv8n7YPsfFPTRprFHRpNCmiD7QwVrt/qYnZFdDR1vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(2906002)(86362001)(82310400004)(81166007)(356005)(6916009)(54906003)(16526019)(316002)(2616005)(1076003)(426003)(26005)(186003)(336012)(6666004)(508600001)(70206006)(5660300002)(4326008)(70586007)(8676002)(4744005)(44832011)(8936002)(47076005)(83380400001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 04:44:17.3501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8b47e2-9f56-43a5-2f45-08d9f4f4d19a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2741
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Without fix:
  [    0.005429] ACPI: LAPIC_ADDR_OVR (address[(____ptrval____)])

With fix:
  [    0.005429] ACPI: LAPIC_ADDR_OVR (address[0x800fee00000])

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/acpi/tables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0741a4933f62..550e9512534c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -151,8 +151,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_apic_override *p =
 			    (struct acpi_madt_local_apic_override *)header;
-			pr_info("LAPIC_ADDR_OVR (address[%p])\n",
-				(void *)(unsigned long)p->address);
+			pr_info("LAPIC_ADDR_OVR (address[0x%llx])\n",
+				p->address);
 		}
 		break;
 
-- 
2.27.0

