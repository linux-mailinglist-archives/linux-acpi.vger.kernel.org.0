Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90699380D3F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhENPfc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 11:35:32 -0400
Received: from mail-dm3nam07on2049.outbound.protection.outlook.com ([40.107.95.49]:53217
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231352AbhENPfc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 11:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/JBcUE06zqDSaCdqTUnwlFAzmfCf0/YxJ7x+8usyp2f5kmXOTJNpTObszMavUoE9xMkO9SEaac4hwGBAUGE3fXDapw3bdl6WjSAD+1xt4Whuw1Ypxx/W3x7T5R2eiZtZ0gBhDjrYmx4+7GDcJxJjg8dIyB70K0QIXmSh521rPkYAzbATsoYc3BO4ORlPVjXgSsoikPZu8NHTTtP/JSJ3PpH5fMsUZBtul1gp7NSJ5z5y88JgQM+b1+FTU9Sn6gAVNSdBGCvbeKKFI2Sff3FbsiWYFXC2yWqLR36ETgvR5W8PCNxtuqsEsbJL9S8B2rkGLIaORsWR5RmVWUCm+E1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXeKunu8NC11l3ENFF1Qu0NF6k+l2q67bBe49ru1+kI=;
 b=aog0f2qqu9tO0ZA9GmfHvNthXeKnKKD2ijUmFVsi/JPRncLZEqlcnFMloW5HfXp0rojY3k2IqutUNjPWkZSoMemQexQYD3INcYus5XJWXh5n8MeH8oi7PB/J2ueaEDxjRO7W/uhih6Y3dBdAuVdQE156q/03+3p4QPveJzoj6AqTPtacsXNPn2hCmEZGDnirsN4JV5s3EcmxdvVJuqwMt90srVO4OkcdI5CI1U6cxSY+Axu9DDPl84hYE8dQd0amwa8YBrDkeC+QY1VrhSimGWcTgXCPagJHbnnXSM6M0dp3sU7T3KNOYuOOomae+dsq+F3u9Tu7EtTONL5LXmqktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXeKunu8NC11l3ENFF1Qu0NF6k+l2q67bBe49ru1+kI=;
 b=Sv87gAddj5zKxevFFb/hsMaQQ/Wy1dc3ybCv3QRbH3XfSR7ovOej86ZuDmHzOzioANFHHuo5R5640a1w3FxSynTUI4rX91N2sXCM56eLuLurl8q2RVfxOEtiSyraSBD7LH+6HtbdDZyW59tIF9R1oYsVJEwkJlp03NKauuWyPn55nttyYE4bMzhMzj76EDMvYaV06Cqz2xYcpdpEuCy5Tkga9fjPKus4c+1qCwPmgN2zhAfgNVrpleOjxvXGEZuVohWoXxeI0wSqiDz2eM/6eBa7e1J+Jy7VjHaji7M8rJB4KiDSbOz8VkU7sJQ3bxF7uBUt1pfVwRZOGktBfIVl5w==
Received: from CO2PR04CA0188.namprd04.prod.outlook.com (2603:10b6:104:5::18)
 by MW2PR12MB2537.namprd12.prod.outlook.com (2603:10b6:907:6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 15:34:19 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::cd) by CO2PR04CA0188.outlook.office365.com
 (2603:10b6:104:5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 15:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 15:34:18 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 May
 2021 15:34:18 +0000
Received: from moonraker.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 May 2021 08:34:16 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ACPI: APEI: Don't warn if ACPI is disabled
Date:   Fri, 14 May 2021 16:34:14 +0100
Message-ID: <20210514153414.847902-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0241fc0a-c06a-477c-5192-08d916edbd67
X-MS-TrafficTypeDiagnostic: MW2PR12MB2537:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25375324F5EF103FADC9ED6BD9509@MW2PR12MB2537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkD6fa9yjToeCHdVVqRiLBFwNni9nP1kdJxV781ZGLhZ6FXHnBd+NHD2HL2K1CgUwDGw3cDCaGrngzAIWQZpP8R9KRgd0PgGBaTdjXpZz96fJTxjliLmPRAUAZfGl5D0UV9YZrGGzzz891EVkqf4GEI/SMaxmQwOR+P6vJ+0NiMl5W6SvaXwpBT9grJNvq+KRAM6jOfjtn4V2uRWQsiwtz+NCS75gbKFRXlvhapov+FPtEw2ex31WfZJPLl8Wnb8BZyUGgIV/z8irpIeJcFlBAKx7iIhJCtFf5HowySuaVqZ4Fxedy89h4+lJsACNCJ4OQjNwLarRl66yk66QgoX+xqEVxiLDpEpFawcHa1zZsCVl46FRI+1CkIcGZ1j/FCJ1r23FQ+WD/kCez5WH7HXkulWFGEh0KQR3uTBeelsXtTRCURwNbWeItohrdyZO4NK2tIl4ANQ/1k/3bW+ICAnjVy0l1VUYllAffAfckiyaSdLu2EkP2KLBtMs/VOtuyXZ01RnbzUXPuLXbAihpe8hLQbwg88iX7OnuMI6GwrmFS+C9YvGhkFTKwXeoZP6lLN25Iouu5aIdEeIb0xlDZ3wZwvgdCvo3QPE0TK10jD5IH6VkictPwYjsq9OZxjLgk8/H+0MHqKTssj8UITMDkyXVdvvRz1FxXc7HGqGNrn711w=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(5660300002)(8936002)(36860700001)(478600001)(70206006)(70586007)(86362001)(82310400003)(7636003)(47076005)(26005)(356005)(82740400003)(2616005)(336012)(36756003)(2906002)(110136005)(54906003)(8676002)(36906005)(7696005)(1076003)(4326008)(186003)(83380400001)(426003)(107886003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 15:34:18.9221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0241fc0a-c06a-477c-5192-08d916edbd67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2537
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If ACPI is not enabled but support for ACPI and APEI is enabled in the
kernel, then the following warning is seen on boot ...

 WARNING KERN EINJ: ACPI disabled.

For ARM64 platforms, the 'acpi_disabled' variable is true by default
and hence, the above is often seen on ARM64. Given that it can be
normal for ACPI to be disabled, make this an informational print rather
that a warning.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Please note that the motivation for this change is to filter out
any warnings that might not be actual issues. We have some automated
tests that we run to catch warnings and errors and although we could
add this to a list of non critical warnings, it is preferred to make
this an informational print.

 drivers/acpi/apei/einj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 328e8aeece6c..2882450c443e 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -673,7 +673,7 @@ static int __init einj_init(void)
 	struct apei_exec_context ctx;
 
 	if (acpi_disabled) {
-		pr_warn("ACPI disabled.\n");
+		pr_info("ACPI disabled.\n");
 		return -ENODEV;
 	}
 
-- 
2.25.1

