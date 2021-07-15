Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A763C9BC3
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhGOJ3h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 05:29:37 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:7937
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235370AbhGOJ3g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 05:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuBujq0NtXzahUs8wZyC1s5DP3kqHa3BGRWWq+1/jxiPp1BHMcQ6q6osNztYMBiiysqHzG61p+EFeefLj41yrRDLE2vl2tXhUegGhdgNBh8gP/1lG8/IZdCQIqoOErYnp8N9lNLKD5Q/l4kyL9tNAu7U7UWPOseV6WLNlULZyGGxqL8hQbFwysMA8wgMeFO4jJYNDdlCZ2Og4w0BW2oP6GCuxskhA5CXbhhu7jMcflN5QJHX1pvV9Lizxj26Ls2QMlJdHaVt+WZr0dJ8M0KJ9kyWSVT0pNKEmsSR2D3c3eRlyGHBJJ1A5XZR3ULv+KNI9WlLg3lPJprgYrd2fNKJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqmGiOIaYty+R8nsdHp4XJI7uJ6960WnmkQigc1Cb78=;
 b=jR5cqz60BZ8ap8WmJymfBha8bmlDHjcyNZ+UO3DIA5BcMpQ94UIgNgtaBzbj15n76K3E9faJkMkrH2ghGHpYjOSS/1Z/sO5uxUWcYOzdi2sScljdT/AEtnS7dq5g9ooTbmKxMnBFffyjhhH2DvB+ZCJ3JasAGZX/aoZZK4Cnp7ifL5uZTD2/ofYMbbQU9/TY6LQoxIgqnjmG7TsZnr7OhMUDmxxA93ay0MkMIvwyTLTB56DpCp7MFHWA6xCVTEsqw876Vvhq2QjGzpl2yIpTYqne5qLzdUmwOHQSITAYXKuyMtuDY8NK5u7PKIDolMkBnrrnapvKMbWAGmSH+jS4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqmGiOIaYty+R8nsdHp4XJI7uJ6960WnmkQigc1Cb78=;
 b=cM4NtjPrcO0/+YinGokxD8F51fZwxD/dQ/d4dhmDjOeF6Q0mMqc+uKbYDN8iG4zkDEzGtOPnNlwLIDXdIiYNgGE5/kcoclLVocfnqJXK9qsUfg1tgkqceMn5lJ8qQY1WEXOvMtqfXbDlLjLVvy0v/pGmzGJJ5jIiwr7XbXlu8cE=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM5PR12MB2568.namprd12.prod.outlook.com (2603:10b6:4:b5::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 09:26:38 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9178:207b:3b1b:fdf9]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9178:207b:3b1b:fdf9%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 09:26:38 +0000
From:   Robert Richter <rrichter@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: Kconfig: Fix table override from built-in initrd
Date:   Thu, 15 Jul 2021 11:26:01 +0200
Message-Id: <ad9c50c54887bde41ae5de782248231c06a527c0.1626262835.git.rrichter@amd.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::18) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (77.11.111.27) by AM6PR08CA0030.eurprd08.prod.outlook.com (2603:10a6:20b:c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:26:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c4a9fc-489a-4efc-6b6a-08d94772a57c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2568DB628691849DC67B0A829C129@DM5PR12MB2568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mWBbjLMsy3ZSOa2Aw1tG2ZCRkcBousUIkpmqXsklDyswUPpzGwR4wxJ+DQDUN5LmrZN5U6/RBmKM/TZrF5csVytikgNW+u7vmGQwkGIr2WfbBzCmwPqVlkCBjGYgxGfgoXHQ6vGxeH9/sHDw33QFhl/oVPgPt++x3Vy22FF1nN1cvl9vJrvaRR+PggCgc06UBSI7JK0cWoiXSSo8O1/OJk3PcKZYiWOwMFKTz/qY2hLha5hNLQLZzp9P0hH8lUtuGHyYETL/fmBUImZ0x8ZKJzlx7IVtXPOVZQzvN29q00h0lOPDy3Fi0Zn6ULyqQnCfmpkcUgE2ibZYatvdwzuUvVO1fzUvxzA9/QSuAwVFreNJIiPeEzSgLwM5T+eidqC4t7qpPXEO7XRq31gzC7e4OsQL3r3DQifHelmX46jleShoFottEseeK8bwAnntD9E0ZFOF7voA+gVXTmotRTee0uOhSjHn+c8Ilj0HQf7I9JAH6vot2BNZNL2kc6XXnBEs7kkORX2TUExwrxvueWsSZdyQmJg/z6iYpULoCHV0XTNKZTzciX6apfm+f3LlmQl4+HnUV5xXaUEDI/gdyEgr3G+uVXc3H7LybQGqa2UhcHhPscw/77AnjMB7WFrs3YgfZzFC1XIqiWORaTVac8cpHj6adAEZ2BQvfysGRISJCVEOihtW8cniRqxF/lEIhQEXftmmFJyGzsqTtzVezMVLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(5660300002)(478600001)(6506007)(66476007)(6512007)(66556008)(4326008)(52116002)(2616005)(83380400001)(66946007)(2906002)(26005)(38350700002)(38100700002)(8676002)(186003)(36756003)(316002)(8936002)(6486002)(956004)(110136005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3yjK4cJgsSdoSsRW1ojsAgM2REsJ2kfSEkCJxZA6x9Fu3Ewv7fjWfuenwDn?=
 =?us-ascii?Q?LVOzOkE1F9WtazSIf8yhnM7REzHBDegQbZVlH/ox0T1gcxXCHYs3ozmwKtsy?=
 =?us-ascii?Q?3V4c3IZBNY8UzY3UH0b6mtVlP6AT8X/nmzuDbY8gUemYm+wimqKStsFVKn+U?=
 =?us-ascii?Q?iUcPIi04j2maNl3oELbgAq9Lr56KrFnqMoKvwe9LHBgYnh0O1EdQk3r+KOs5?=
 =?us-ascii?Q?UMYWL0VhZeVxBi8dp3zkR2tvHjV09Yie58Lzl0BMUCy5c0RR9qOA+MIESB8N?=
 =?us-ascii?Q?eLiwO8VAHbGQzqTsBrBsZRF+MWTek1yYJIZQPQuveuxA4uIWHECduwJFuK/0?=
 =?us-ascii?Q?sEu4UfLoL+1boLim3pOL6JgxNZZLSst59N+nGxpTKCZ10eiXPsKxyGEiNkGA?=
 =?us-ascii?Q?LYcNWvKBQ6X01Sob0RX2VyUVSjn3G9tWMNK5xZIDqU8g31dfnh1OobRVPbwk?=
 =?us-ascii?Q?SMT40QXz946eXHhuoBlnvwsWBzrH/lzvhXcjXxEUWbV861/K3C09KbnrYavY?=
 =?us-ascii?Q?x2lclJlyedAPPtEEEuYjyohFok2tM7izuLPrkB0QUEqax0Ksvu9WmVWXMLxP?=
 =?us-ascii?Q?qAMcE35ciAzIXYdjvctU/T/omyfHVSlvk7O1PXeiZUBWWmNTmE1M4r4X3pjy?=
 =?us-ascii?Q?wQKmTXXXhK9edYOnyB82c6HPy7Lrlw2IynpMnI8Hbe24NpAJOyU3bxJMd4VA?=
 =?us-ascii?Q?p1X7KFWKCPqHnyWLjjCKVZdnEz29z2NtaeEs7yrniFGJFXECAqu8FvINi8r0?=
 =?us-ascii?Q?sAtHSewoz7STnn/ElBblNb/5oVPiCgrWLC4aSI4b8cbNohv6BTGD0sAl8QsB?=
 =?us-ascii?Q?/hMI1JESZNlxnxAHKJ03bcRmz3ORjHPdJ/GEmr8uJijslJuTRwxvlBmWXBTb?=
 =?us-ascii?Q?f+vxuRmbSz0jpcD8HWos9HLWBBq28hFF8rNNiMu6oLzYvVj/7DCz3jvTEiqu?=
 =?us-ascii?Q?lx59NqN9uGkq/UDlstSB/ExTw1bfTkLiNSGPhe9wtpkW902ighYqVm+EwRjn?=
 =?us-ascii?Q?n9/acToxm64yk5P98hvhMNhupbPTIDpy+N+KQ9zEUgmbyfDy0USTzeZHHpCb?=
 =?us-ascii?Q?ZZVu+O2pgy6UPqogBTa8maS/SqfiC5PulZKRAsy5abI2Lu3mID/atglyoghL?=
 =?us-ascii?Q?Yr4OL3Lb/l3MHqNPUm4CthwGssKknj/KtTBmkU8U1lVwBfL5CzLAG9OcJgRb?=
 =?us-ascii?Q?N0Qa5rVmEpYgTiTjJZK3loNQ+xwbd9Sbb5LljvZmWjBW0RGpCyjU5BrICHOD?=
 =?us-ascii?Q?MXmU9k2nvyAsI+TVPm+1tgSDe+pzcfQg0wEGGt9mmJ/S3B5yhxUi8NYsrCeo?=
 =?us-ascii?Q?gkCeKkL+vn+7R2Zb+Dq3ui8V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c4a9fc-489a-4efc-6b6a-08d94772a57c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:26:38.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isIX5MQBhF+MHDx9em7Dez7YQ/SnkN5GYpRbvGZNAMTvlFEgZbYchHTXgPVEhnU3k4J20EGofNYmlep5mzz/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2568
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

During a rework of initramfs code the INITRAMFS_COMPRESSION config
option was removed in commit 65e00e04e5ae. A leftover as a dependency
broke the config option ACPI_TABLE_OVERRIDE_VIA_ BUILTIN_INITRD that
is used to enable the overriding of ACPI tables from built-in initrd.
Fixing the dependency.

Fixes: 65e00e04e5ae ("initramfs: refactor the initramfs build rules")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9d872ea477a6..8f9940f40baa 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -370,7 +370,7 @@ config ACPI_TABLE_UPGRADE
 config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
 	bool "Override ACPI tables from built-in initrd"
 	depends on ACPI_TABLE_UPGRADE
-	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
+	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION_NONE
 	help
 	  This option provides functionality to override arbitrary ACPI tables
 	  from built-in uncompressed initrd.
-- 
2.29.2

