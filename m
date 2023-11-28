Return-Path: <linux-acpi+bounces-1871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F47FBF71
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71062281B7D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280305E0A8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k8R4mEOy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4867131;
	Tue, 28 Nov 2023 08:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnmpAtfg8add3M11QLlgDROU39iuMrdBUK89/KqwycI5UNziyEDGhmLCr5HrC3CVCInTRUoghVnimGINth9eOkdCsonewxuxJ2MTsfp2ZDhJN3VqXVqzW/r9RPFJ+XswvZaV2KTUa9/HY/d9Sb/sr/UUG5i6lF7G3YWpqOVXwngQ0SgBSxaU+UaNRmSjJW+/1lHXSm8I0Urm8LQI/NYSavM3bQfABkwLjWPaa/XPx0AybU8h7lu7l9vL1QjmEiji5mgJ9pMn3WsKcd+Rey1ioTA6UAvhPhBi/2BwLYqg0nxvaeJUucZGjjJefFFyV3Sg+UYSCPuz5MlUYU6zj3qdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoymjZeBWJv98iRBUeXbhYNTbtjnAJrzXYv9neam/zE=;
 b=ZEzD/RsggO9IiD4U0ASPlMgJMYSaslGfglz1xiPTWqyvZyqOxKhE6hCiTlCXuhdt7tzvH3bHT0qK6RDSNHVD5nQnhz/3X4v2y1toy/j7M3tYC1nqHWHtCJtWP/Xpw/ki2VHqVvuhVhWYKjxBB5J9Jm8nwWb6QNWZi9cK5k7hG9PpWC3Lu9q3sjVtF93cijuisS9XleC+lU/7xErehCfqVMo+dj2XJK3j9NNJkXdCyfomxh4u5RUl6K0u6zGWsjcwYp66roiTf9naOI9X+5iD2TlxSZBNQaKFIxX5g0Dzb3P1IAoROdaXqqBtL/IJ3AaYIw9+YPYsHhRt9/zqAd5u0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoymjZeBWJv98iRBUeXbhYNTbtjnAJrzXYv9neam/zE=;
 b=k8R4mEOyyICQgFYuhjBdNOYJoNEQD4hUC9E8NUqWuFIu136toWTp5DX8aKC5p82bINUC4ZbT5XtsKLVE2NhP4zHchzUglQgWirz1lE2ONEFHvtf5DdoRazvf6LwyDX5SZL6ZR58RajE2oAM+6L+LDpDeyL3NUA2sRpJ7ixjIGvA=
Received: from BYAPR08CA0067.namprd08.prod.outlook.com (2603:10b6:a03:117::44)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 16:07:40 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::cc) by BYAPR08CA0067.outlook.office365.com
 (2603:10b6:a03:117::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 16:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 16:07:39 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 10:07:37 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 2/5] ACPI: Add CXL protocol error defines
Date: Tue, 28 Nov 2023 10:06:53 -0600
Message-ID: <20231128160656.166609-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5d0b65-41bc-4a51-3fc2-08dbf02c256d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ofs+7zBr7SG1ycGQFTqGVjxtthREMWWTtSqPW14WaLqI7glRU+aw2Pb3xjwFawOJQSIlC0BE69pREqtj3edmuopFO7PQqB1rAiuUQrq7t11ytXpe0RyVIUiv3Lu0uBz2AjBDw1ZL0giz21mLNrbICM6KnC+SUHQXDDoXjA+19rMLBq/64kv5PMzJ8Asn7mEFwtC32otMQ6o6/vb2Q5gvFXhy6lTTTNFalT73DJ8yyAFj853QIYVomLYdcg+KEEGfpptYC1gV/uggLu/3XyoOEJNOpx/wtWVwnFfq/NBHgJteQHIL8NVF2tvyflbu5ORTzO+4AiH5goXkMB6jalu9Y6V++Rv83/Wz4UKkcypdhv4D+QebmUZtbnwVZYFGuHnen7iZuP/DcDwbXHV1UJJ2537pxR7sqS+bXgHd9qF5FkuT0uBEL0QZjqMyQpUzMDR+Z782QZDeGhW2nyjje3ZAhCt6VgM9FZMIqUE1bdKv3xJCMzwKQ9dfNjYjdh1XCbB8mYvx3I8n8VnYXkVVI/LwC8uZwf88Hc7VNXpgeFELM/rt4KESPiAeq4ni+HJusT8aenrWiVFWP1Ug4Ce/R4TKBjwKgT9lsNVR7AFhSH+SSgwd7Si9pSFsvMHzl3hpE8Os2xODiw/2ETYQgOndZlP7viHPiPWctCiYzmEEZvC7e+++qALE3B9DFM2gn92np1jv84oZ4rSU9kDUpfmejDZnDqyMLrMl1LrlYRv9pNIsWRHazxm2Xo7AiJlgRVGbBYjJmCBOJnZghzMgASDUtkhRJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(7416002)(5660300002)(70206006)(70586007)(110136005)(41300700001)(8676002)(8936002)(478600001)(7696005)(6666004)(4326008)(966005)(2616005)(316002)(16526019)(426003)(26005)(336012)(1076003)(83380400001)(54906003)(47076005)(40480700001)(36860700001)(86362001)(40460700003)(356005)(81166007)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:07:39.9419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5d0b65-41bc-4a51-3fc2-08dbf02c256d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005

Add CXL protocol error defines to include/actbl1.h.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

---
I made a pull request for adding this support into
the acpica project that has already been merged [1],
Feel free to discard this commit and use the acpica
changes instead.

[1]:
Link: https://github.com/acpica/acpica/pull/884

---
 include/acpi/actbl1.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a33375e055ad..1f58c5d86869 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1096,6 +1096,12 @@ enum acpi_einj_command_status {
 #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
 #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
 #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     (1<<12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   (1<<13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           (1<<14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       (1<<15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     (1<<16)
+#define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
 #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
 
 /*******************************************************************************
-- 
2.34.1


