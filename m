Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE10A39BDB1
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFDQ4E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 12:56:04 -0400
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:13536
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229791AbhFDQ4D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+jJtR9XqlPI37KeXmJ5Y3Sb5zQrE1RHqpCCxjEp2k7gObw+ItNkHyj/qJU24vE/67phXWEiXNY+ipkJm0q1/Koqk5PqVrP+45RCmDIKCsIC+Dxpfcv9Cbq4jUMgP7RPLm7N4dd/wQJok/Qs8WXrrIrmvdRDsDEBDFFIdQgCdRxCqT+m2vzsDDy9vxy90tSz2hgd/mHIzO1oLTPon231JEnALLTPiXsqID8L5+hq2RCca6gR2jWAJm3IGhPTcAW8DGcMkQKNm7gd6QqDZKkxrCOmcB1TOhkg6wMopLQ7VJ0ELLDNDQT0utedlN+FXICDtJHhNxWcEcgx+VDIcqt7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tebu7UCegpIF78+PAQXUUeJzxyPaP7+3AanOc+DrZI8=;
 b=QvkZr4D7EHy2OnQWufX2NhJV4WaXVOlctPYIuosdJf/f8O5unfreihzf2f627MV20dL48TnJ0qnnrH/4ktGisgKLEGqFg0mM+k0MdPo6PuaxCO4Eu2lFrEPCX9QQBqmRBcD5M90pDz8xGFv1YXyVQn29o8eVzqvp+U7tKimaWiMlOuYDN5A+EkR3DTg55UD2YygS2NxYxF8T0hxH6JoZzRgp3JCEBC/xcEf2rpLsqBGqoxrMN1ljJhYfPBrj7dAnNAuML1ILYWvuHiT0aBOc9fTj1ipwtGkyLUUSXM8BA9LGGYmhif+tB3Az3ZwM27AYuAeyi/xn2n0lzgcoEIQ3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tebu7UCegpIF78+PAQXUUeJzxyPaP7+3AanOc+DrZI8=;
 b=vjKowhxkSEcP7GnoOZlNV8OYFFNYe6LH0UA7XUHtkXOh+ssNhgzi3WgQSKrDJYQjbMpyP//GwJ8O4RRxUtvp/XivqTX4bOtK3U3egqrcdCx31ShANR8YvR05HpjFJZfKNQ4i7z5y8e9+TMRHnVrokRLKiS9CImIzxx+rZsWByro=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2689.namprd12.prod.outlook.com (2603:10b6:408:29::31)
 by BN8PR12MB3156.namprd12.prod.outlook.com (2603:10b6:408:96::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 16:54:15 +0000
Received: from BN7PR12MB2689.namprd12.prod.outlook.com
 ([fe80::c529:c932:4b33:9b60]) by BN7PR12MB2689.namprd12.prod.outlook.com
 ([fe80::c529:c932:4b33:9b60%6]) with mapi id 15.20.4173.032; Fri, 4 Jun 2021
 16:54:15 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julian Sikorski <belegdol@gmail.com>
Subject: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint
Date:   Fri,  4 Jun 2021 11:54:03 -0500
Message-Id: <20210604165403.2317-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604165403.2317-1-mario.limonciello@amd.com>
References: <20210604165403.2317-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::29) To BN7PR12MB2689.namprd12.prod.outlook.com
 (2603:10b6:408:29::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 16:54:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daa31387-5141-4eaf-0ef7-08d9277962a4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3156:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3156890B213B2EF97FA9E3D5E23B9@BN8PR12MB3156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yx5xX6OgNAbiOxTL4uZ70WqpvKtJPdWMvuZRKlQNIUODmkxuIYqAWX0Dyvvdj6eqVqiadWVOq7ERN+5aVthbwEV2pazF4qkU/t3pYhdp/k1quq4FWCf/sVbq9PtW9VL71M1bQasjj3tjD8uXNgOcE1icY/HjnAkSxrwCndx42MW7f/Z4RBwzZfxbsWuD6aM4o3t3HEjFF31kwU1OfnTKlnmaRJkVyx6AQUInC2spE2OcTEI/fzt37L2+PZnST6UUDbUkZSipuO8+sOg1YxNKO7/d18Qn+umYHHt/fekmCMUeMeGRtkHkloxo2lkSUUVtLtmlzwyUUyG2zc0s/MFAH+iQAnYB/LxPhJGp2pQ1FiGvW0Yiic0z0cGWssPxagBR/+TOIpMctVxpBtl8BL4JX5MhNG5psbN9FIchiDBbOg7/LU+9ITjIhVXOh7xxJ5KBlyggS22ZS7mTDkMseVxi2EHofZ++9UG/lq5ZOoEGOCVrZqgLCdFZaARGt6Amtyf7AA9V9fu9pPBTxtzg4dyUz9OSnOa91oQEpDwz+0LhgpjfloizXhAh/q8HHqNJqjTIBb86zl9kmJcVDDd3fi78JkzSrcZ+bd9SZ5xCKO5iCVtxKymcIp3TaSmeW8brDGqZxPdiHP4/ihskMiVFvmg+LcysczEBsGbrcTlgbzLPKUCAPL9H7B94NosfvdbCh88E4qcCyahnIL+Mhm0APymp+U5KtlQlv0BtQ1vN65u95nMS4BkvmBzc9HpBZyVJPIgy2sDaPbHg3IaaFfLyOp3b9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2689.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(7696005)(52116002)(44832011)(54906003)(2616005)(956004)(110136005)(1076003)(86362001)(83380400001)(16526019)(186003)(6666004)(66556008)(36756003)(38100700002)(38350700002)(7416002)(966005)(4326008)(5660300002)(8936002)(66946007)(498600001)(66476007)(2906002)(45080400002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Rq98QQFDW7Ne6/aBcqeqKPlnzv2f60hneDWD0pMu6sE+Ez5mYCTev5J7V8P3?=
 =?us-ascii?Q?lwY0RMRWMnZn7GuCKc+cczUDi3rGlWyt5+8Qnvz2wYTOE+8mlIU3DG25ZmI1?=
 =?us-ascii?Q?0b+6BJsz9kHexFfwxSTzf9zyTmkLjfsE+ZTH1L9Pk0Pp+WTkCn1wJjrYv7t8?=
 =?us-ascii?Q?tVKRhO0m/saLoQpFYahKUcP6QY/iNcs+udpGKpIplhg9ofmns2LmvaGjYqVM?=
 =?us-ascii?Q?+JoBrNiG1vjnlqEbpl3zXdirQeXutoCdzzUj+dJamIdBy7c5Azb2a3dE08kN?=
 =?us-ascii?Q?94Y5WjCIbiuOTFDOY/nHAqOI3n4lzdoFISvEtuDrg2mRHvhRFSoVOwudB4QZ?=
 =?us-ascii?Q?z9KL75EpPVJqb9ldDL7rLWJsSDgNaMph+LtEewHItJyPKYNPNOwmEo507eWC?=
 =?us-ascii?Q?WdBPHUIFN2So/rAtG4gyYP4YRxo6Od5ngEmsUHD2chIJmiH+zvwVdmh+piMT?=
 =?us-ascii?Q?xI7vVObXEU46bVVFZVcIfEXmBhXx+lE9prcVM961a9yOZyDtNq/iDfj4mK1m?=
 =?us-ascii?Q?1A3LxvzdtRj4O00hwKDxhIkdpNGKAFBTCqH4IvPdxjWIyZh5X9s6lXZahFbY?=
 =?us-ascii?Q?FeiueSMjLTij3NG1gDamDuw5WzlBbVck04YG+J+0gFCIlOL2Ba3SyJtOAjwu?=
 =?us-ascii?Q?BZcpWtH3gdfZ0XLvN/jWJMLEpD30DNErdL/CuKxc81FcESpw1QFcHyzwMnBZ?=
 =?us-ascii?Q?YQUotrj5pSnkM987GvPlnBAZebOirPd+Lj1kZJ8ixLEYkK46HHMWTyWcgvzE?=
 =?us-ascii?Q?QUGJM8YOeR6KzlPLDFLMr0hEfNhHveto9KmKAUzQcxUD57X+AffxHS7FDZmj?=
 =?us-ascii?Q?AwZAmTfWPOR6I38sw7subE9w0a+KTXAO+QpFSA0jj5Nabqg6HhFJctfrVCOS?=
 =?us-ascii?Q?tAYZgwSZplJ2gPWQf5RmVnsU7FbXKrzizww8fQ6jXE/9Gcbf9H0wLTpE1Gkc?=
 =?us-ascii?Q?Yp/HOYUMFWWUhopr7fffksUUOXSCvlkkNDZq+Cyir0aD1Dp9D+Xor716yUnD?=
 =?us-ascii?Q?PQ+roGi05gb8KrbxsvlsizTGSR0ZI8FbbxiJo6jFDHuuY1AVmEFIplgd/644?=
 =?us-ascii?Q?pUt4421fLF9hrgMOfB1w44U8IptazTI1V3b1QFSl/xLjgWjoEDHttEKVx5df?=
 =?us-ascii?Q?4KQcuVQOgVoEtgeCH0gOdsRbwjz0oj5Bnl0Kv+RjVBexHBMV67GeuX3XVbFy?=
 =?us-ascii?Q?gtq2VKOwqnQSrVfQFqJBIxG0lorhNJkCU8rFfQuuYnK6ajIAPLxdULT3Tsun?=
 =?us-ascii?Q?Eem8nb5miNoAd4+/R8gktU5LWmVKUmTXLCP9tL690ECB/Glq+waJ3sSVzwwp?=
 =?us-ascii?Q?xe6Uy+CtnfkABWnfLik9dgUJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa31387-5141-4eaf-0ef7-08d9277962a4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2689.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 16:54:15.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiECHrlU936A9WOz9Rf4+LeM+/chvWB2qtCT4lv4wUfL9TmqNtI7FI1EATq/V9x8k43Dsztus2m/2JFBlzFrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3156
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AMD systems from Renoir and Lucienne require that the NVME controller
is put into D3 over a Modern Standby / suspend-to-idle
cycle.  This is "typically" accomplished using the `StorageD3Enable`
property in the _DSD, but this property was introduced after many
of these systems launched and most OEM systems don't have it in
their BIOS.

On AMD Renoir without these drives going into D3 over suspend-to-idle
the resume will fail with the NVME controller being reset and a trace
like this in the kernel logs:
```
[   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
[   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
[   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
[   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
[   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
[   95.332843] nvme nvme0: Abort status: 0x371
[   95.332852] nvme nvme0: Abort status: 0x371
[   95.332856] nvme nvme0: Abort status: 0x371
[   95.332859] nvme nvme0: Abort status: 0x371
[   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
[   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
```

The Microsoft documentation for StorageD3Enable mentioned that Windows has
a hardcoded allowlist for D3 support, which was used for these platforms.
Introduce quirks to hardcode them for Linux as well.

As this property is now "standardized", OEM systems using AMD Cezanne and
newer APU's have adopted this property, and quirks like this should not be
necessary.

CC: Julian Sikorski <belegdol@gmail.com>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Prike Liang <prike.liang@amd.com>
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/device_pm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Changes from v4->v5:
 * Add this patch back in as it's been made apparent that the
   system needs to be hardcoded for these.
   Changes:
   - Drop Cezanne - it's now covered by StorageD3Enable
   - Rebase ontop of acpi_storage_d3 outside of NVME

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 1edb68d00b8e..8fd2a15bf478 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -20,6 +20,10 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#endif
+
 #include "internal.h"
 
 /**
@@ -1341,6 +1345,15 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
 
+
+#ifdef CONFIG_X86
+static const struct x86_cpu_id storage_d3_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
+	{}
+};
+#endif
+
 /**
  * acpi_storage_d3 - Check if a storage device should use D3.
  * @dev: Device to check
@@ -1356,6 +1369,12 @@ bool acpi_storage_d3(struct device *dev)
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	u8 val;
 
+#ifdef CONFIG_X86
+	/* Devices requiring D3, but from before StorageD3Enable was "standardized" */
+	if (x86_match_cpu(storage_d3_cpu_ids))
+		return true;
+#endif
+
 	if (!adev)
 		return false;
 	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
-- 
2.25.1

