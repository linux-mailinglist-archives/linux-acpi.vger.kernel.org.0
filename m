Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4745D8C6
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 12:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhKYLKf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 06:10:35 -0500
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:39265
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231773AbhKYLJN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 06:09:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv6EuwEUpTX2NHbJQZGBLOK6HoHLiHqhx6MuoUEV07A+dwjOBIhZKDPyh04nmu8mEA1HIqaCcmEhByluA2K4T3vApTcDpmDyqxBiQHlgOty9CwZIkG6Cp6sCvdY3ScAHKCfrzpr1KkgqcSSjqFn4TECA4wlGKc0RlvY3JOtTqpiwa4IXEgRsjPKN4f360pYWDwfnq7FEwkkz9sabz37wFi226nEcwi9dBdUI3TDhHrz9CCrIZDbc8EQkzr+yFULBVFu568tNSAIgvNmvqkHXWeE8A6fQmfDECPWsGtp5M/7ImsJzQmtZ6x0n5CrCTNNqNpqxciHkGimGCA6Tabnc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=BtMXXVZc1QxQIK39bmDPv3ftezM2C+SriQnDjSncGqDGrNWxnsq6KlXp9OXNSW6fSxnmWqavjCVylqZNK8SpRP4U3kqJ/tOIUV7/E+3i8T/3b2e0TsTdKGUItNsahBy0Bl6pPT9eD8WNMLqpt+bTCS4/SDjADjAw+8rP2Dk3R2RfnLZ8eZ+D2yq5znae5BJpSTTi8qdK6G1go7mYvmH/Ph280x7OMc/1TnlFSoWoESBmz+62QNr+t1o4i789NNnqJBcucfNa5z9TrNkqbDDNeRqTwdH4Erfi/ve/siXYLDGy/pxFIzjWqsjgL2vcYziPq0HD3yyf6QrkjNJHzSItPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=GsIoAMoyi5JiE5fnf+7/3YF4ErppgWgOWIBuG9vgkVEzSTEVGHZaVYlMM9KQ/RBm8OShKnQo93diBW9N/K+3CI0v+HtSzIporMI3NQ4FvQRtg3PFfxwYxpPX0pVTWGaWIBM8kKHeoaSR4hSq+Fjg/S8vGVkVe5y2jufeOOyOSy8=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by MWHPR12MB1805.namprd12.prod.outlook.com (2603:10b6:300:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 11:05:59 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::90) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 25 Nov 2021 11:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:05:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:05:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:05:58 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 05:05:54 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/7] ACPI: APD: Add a fmw property clk-name
Date:   Thu, 25 Nov 2021 16:34:43 +0530
Message-ID: <20211125110447.1188073-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5dfa3f2-994b-4ff8-c8a6-08d9b0038fc2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1805:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18059B11CA2AA51E82177BD282629@MWHPR12MB1805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sDG9te9uszSucZ2+rO0zx7D3gMO/LKAQ/vg3fqRM0JNlDUs/DvuWPfysCyyr1Ei6Bz3ruKVGLJUIRVDPoLd6z2bGQ6pigqDvASvVBKX+bAiTdgbEHSL4wfVRfqrj+gK2pdSxcva8lDXi+rkgrV8P+ozKv4mYO3VJb0lp8//LfezbvyuNlFZu+gQUlIppaPs4h78FLPVxcLwxe9fz840Hv1Pp10ohFXuKu9eNfEc/twxavXyKCPI3HCSpP1aRkGw5q8E/gzaDPrmbuG5ab7cZgDYIovvjc46g/tC3lD8rHQ89U61aCq6I8P0II5aGhQrcdWbrjixD7M/+f8H+p/sD92dIHcThesOhcb9t+yeq6Y6sH4/K5I53yoKsdJBdqzSJAYnSy0KdWwzAfAzQwijNoNMYg+g0mqSahqgqj+2goohQMQ2La+nJR1rvDY1hp5fVMUImBh3rx8QAoBsWELW+5xGjawkpXZ9X/w6dOUVV8c4vWtDpe1MLRkcG+CxlPTycDxYeKGIpmUr9PUWbI36H8Nv0ZRzDt4OFNOEwIUc+oDwIeIfkCXtqPo1iXzD6Nrq0Bb/DFYSEXYgQHkLORVZmcZEqyoOPuhasBsB4q7cu3sQRXfIDLH6AhOUpoQRHjdWV3JfWba/s0WkbwD/0UezCWuvVLBQmAPIu2fq0I/wJzkkwlEGazd4rcJqVs+kRyFE9G6QFcAtjoo9gFbfaExQWFnf8nMfU6GTpI8KMIf/8jg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(5660300002)(36860700001)(86362001)(336012)(8676002)(70586007)(186003)(4326008)(6666004)(2616005)(81166007)(8936002)(54906003)(26005)(110136005)(47076005)(1076003)(356005)(82310400004)(426003)(508600001)(2906002)(36756003)(7696005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:05:59.1376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dfa3f2-994b-4ff8-c8a6-08d9b0038fc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1805
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new device property to fetch clk-name from firmware.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/acpi/acpi_apd.c               | 10 ++++++++++
 include/linux/platform_data/clk-fch.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 6913e9712852..2b958b426b03 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,6 +87,16 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
+	if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
+		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
+					      GFP_KERNEL);
+
+		strcpy(clk_data->name, obj->string.pointer);
+	} else {
+		/* Set default name to mclk if entry missing in firmware */
+		clk_data->name = "mclk";
+	}
+
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
 					      resource_size(rentry->res));
diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
index 850ca776156d..11a2a23fd9b2 100644
--- a/include/linux/platform_data/clk-fch.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -12,6 +12,7 @@
 
 struct fch_clk_data {
 	void __iomem *base;
+	char *name;
 };
 
 #endif /* __CLK_FCH_H */
-- 
2.25.1

