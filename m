Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEA2EEDD3
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 08:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbhAHHYz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 02:24:55 -0500
Received: from mail-eopbgr680114.outbound.protection.outlook.com ([40.107.68.114]:61317
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbhAHHYy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 02:24:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LazP9oXHmrsJFLEtB/Dnm6Z22m/bi58EH1ecYEdj5HfJCRTaWg8stT4I9/O5yL5QCyd5RK2ZMTRjVQW+Bp1FsbXyeUwZLSEGkhzGIbu5/QBsxY8zy9BKCqS14Ha0R8LosnUNDI2JvGW/WgMuo/gFtjDK84QwrjcJcIwTBOw+8TKoxK4xJ/uufT7p8AGpFSdO/1HFZMSotyfgqsAPok7RWozdzNZlUqQaU7d6hH9n7GDUoG4oG9nQgfN1bG4lk4dG1r939D8fS7DmcI8ZYEj+VoApDrLBBkXiXfatX6qGS6TAb65bm8pPXkQIYyTMEdKzI7UXsbvL4/ZO/mGcFMNv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj3ed6d3IMFdKu43Ze3G9tDXsMwOvWFFGDAtMdCDFLU=;
 b=jw+U5qhNv5T5+9m9Fi/8qbKfAy/5E3+0guaOIv3ZcCpKVKQCHmmbduLgA7eET/0a6aHXnENZ8BHVOXtbVpxyPWy16Adpqlf1LTzrXYIWm6iAGprmru4T2w9LDKj3/5V/61UyKef7c4cd/uNovCOC+MAIrZxvo7XeOcmrbfLVnHY+DX5Kjqvy3eVsI3ehGe7pfRUvLTEEdscWdRuRhNA26Z7+PAdznNFEem/0ueqSJzm0SJ1bAf+xqlT2LSZfvqQsA5SC2JI8a4ObyQIKF97W2j75uj4Iftsmj7tKoPk/NTYqhM0hworD1MSvOzgAU7Ww8n4CZC7LvUD0pxy4EtB4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj3ed6d3IMFdKu43Ze3G9tDXsMwOvWFFGDAtMdCDFLU=;
 b=PgpQtc7dFd2jNtMCuZgLsbFHKGY/6FNl8zpE9kN7Nmnk6hbzaINUcHGBIpNyWHKOq3tGGZtm45BbmEoCYH77vDt8DjdUq+WTRNjz7rW2TAnzxI6vtHzPjomdJIhCiP5fPDMHvM7S++UpsH5IbkaDb8U/fTk6b4wPxHDKrKtpff4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (52.132.24.26) by BL0PR2101MB0995.namprd21.prod.outlook.com
 (52.132.23.157) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Fri, 8 Jan
 2021 07:24:10 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369%8]) with mapi id 15.20.3763.004; Fri, 8 Jan 2021
 07:24:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     rafael@kernel.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, wei.liu@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com,
        dwaipayanray1@gmail.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer overflow
Date:   Thu,  7 Jan 2021 23:23:48 -0800
Message-Id: <20210108072348.34091-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:f:c886:430:9262:7eed]
X-ClientProxiedBy: MWHPR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:300:95::31) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:f:c886:430:9262:7eed) by MWHPR13CA0045.namprd13.prod.outlook.com (2603:10b6:300:95::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.4 via Frontend Transport; Fri, 8 Jan 2021 07:24:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2448e752-7f9f-4a0e-e9d4-08d8b3a66443
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR2101MB09954DA98C5F5652E95FA6CEBFAE9@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0758nWrPtz+UbwhfLcWzYdpHAXerVxJTQK/eS4A7vTdboJGeqPorePNaS0h6ogWA7qoeY+CD4Y8d/AWnTRbYWJZFWlC4xYjefMK8lDs+ssh/QkK50F+GvFTml9MD3nFzqXO0CZkKkw6zMEEtfEyXqvNJCZ6MG142YQ/zt0zxeLE3JwdjrMKwDZQF9pswx+EDGqgdnkpRphXHQ3TolmpxCuKNP/ZT23AouXoxOVkBmWjp8kwJ7GAGIByyXsV5abLF1xsBUB2/evF+Za3SHT+quhaxs14S51VWzG8j/pl5UqJG0sJDiXNQQcrlTXZIyAqX+ebM/OT7Yetz15wxrwQqThZeS2gbvZIU9ZXMe0N6xRGLNlwJmShf1jLUODDvQIJevCH4Y2EUi2GFs5ZA4pPQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(2906002)(66476007)(66556008)(3450700001)(6666004)(66946007)(52116002)(8676002)(83380400001)(7696005)(4326008)(107886003)(186003)(6486002)(478600001)(2616005)(36756003)(86362001)(1076003)(10290500003)(5660300002)(16526019)(82960400001)(6636002)(82950400001)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Dz5Z0qZ0sGcR+YqNVRqD4gZ/+57+Z5KPbsQj6Ia3BtGpoty3j7r0ZkRCA05r?=
 =?us-ascii?Q?8Uwn0dqL27YpaQoAlZn4Bz+XKB1aO3AxJez0UqaaZ2rEaB6wuJgRkpZHJT6r?=
 =?us-ascii?Q?ngc9jedA6yFeO6GhAp97CoPgjhslCP5aDf4kmwdtqVNYXqN+EqjgCKfirH4M?=
 =?us-ascii?Q?QygMYOvFIAlykv+XYoahFt3vTk5qiu0+m0v7COo2uOWIWKTYzrP2lMmPgDQ7?=
 =?us-ascii?Q?BMnr4FEPQFDMI/gBaB1Ry0o7pFy0Gq4HYBJYvWE2EFrir3GB/h1lw2RXdSnt?=
 =?us-ascii?Q?pdpAjSQGDz8dzO1Ujv0349X7bOGxlgmv54NkAPZvpXLo71YF2HwC8EOY6zxA?=
 =?us-ascii?Q?VYktH+d1OtayFW4pu/fDPzwBm63MnJxbNu26JIm2gThX97tvYX/YJKw1GIwH?=
 =?us-ascii?Q?Oe9mLUnFWLZy0xvfDqz3tbKnCZ4SsT4vLAe8/aF+ErIIkVHWvjHjpfVp5b83?=
 =?us-ascii?Q?9Fp8OvSqUqh4hhLpt1+SNKpas+bd5iSbLTcBwzf5/rUcAONQX0RzB5aYXxMC?=
 =?us-ascii?Q?RLSDkE07F7iB4g5gjwKD0Omai4w10HH2U0+4FxVLXLna04y7aDB57pTSo0Hy?=
 =?us-ascii?Q?iV6y9emyFFq5JEqizkWeWojQ4e2vnm77RbmZXHBo1DnVm9wHld8fwA0Nj748?=
 =?us-ascii?Q?+TpVMsgWv/I1VF5CwjzBWDce0SeEEvKIv7M0WlPPf0fBTaVuATgV0UyoyqX3?=
 =?us-ascii?Q?9qIelx9jVppZs+kWLAhEIgIbFJaJVvumLyggnHZ9YpiEMPlQU+yfgGJuYhxC?=
 =?us-ascii?Q?O24Xk8JILC+D+I5wlFaX9PA+2yLKhkMlBW8uiuXWAKZO+YOaV95ZOTK9c8FY?=
 =?us-ascii?Q?xjV+rk+GNIjZociRVF7/EE6xWfQlg+bzfFZ1zFBeUA3i58YWPlg3g2Q4xTh2?=
 =?us-ascii?Q?O2346Oj/4sIWzFJ6rxi+vnALTJ/ddBkHr3wSPD8Nl3+1fQU0YqvAYA33rBd5?=
 =?us-ascii?Q?ElM6E2bGiefavwwxnctPr2GdwiuKIR978R16+ftHK1PCfAyyG6+0Fn7YleUZ?=
 =?us-ascii?Q?iNNOQImzl/9NmgkPxUl4kqZ0SqZJJ7iomSU2rX1HuBH66Qk=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 07:24:09.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: 2448e752-7f9f-4a0e-e9d4-08d8b3a66443
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGN28ZThZp2cMEAFX9sq17FUbEmg8KHtES05cpHdCsP7iMBhREPnuGf8Xq1+SWQOXGfbYWlp9nQ/SjUqHLG/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Linux VM on Hyper-V crashes with the latest mainline:

[    4.069624] detected buffer overflow in strcpy
[    4.077733] kernel BUG at lib/string.c:1149!
..
[    4.085819] RIP: 0010:fortify_panic+0xf/0x11
...
[    4.085819] Call Trace:
[    4.085819]  acpi_device_add.cold.15+0xf2/0xfb
[    4.085819]  acpi_add_single_object+0x2a6/0x690
[    4.085819]  acpi_bus_check_add+0xc6/0x280
[    4.085819]  acpi_ns_walk_namespace+0xda/0x1aa
[    4.085819]  acpi_walk_namespace+0x9a/0xc2
[    4.085819]  acpi_bus_scan+0x78/0x90
[    4.085819]  acpi_scan_init+0xfa/0x248
[    4.085819]  acpi_init+0x2c1/0x321
[    4.085819]  do_one_initcall+0x44/0x1d0
[    4.085819]  kernel_init_freeable+0x1ab/0x1f4

This is because of the recent buffer overflow detection in the
commit 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")

Here acpi_device_bus_id->bus_id can only hold 14 characters, while the
the acpi_device_hid(device) returns a 22-char string
"HYPER_V_GEN_COUNTER_V1".

Per ACPI Spec v6.2, Section 6.1.5 _HID (Hardware ID), if the ID is a
string, it must be of the form AAA#### or NNNN####, i.e. 7 chars or 8
chars.

The field bus_id in struct acpi_device_bus_id was originally defined as
char bus_id[9], and later was enlarged to char bus_id[15] in 2007 in the
commit bb0958544f3c ("ACPI: use more understandable bus_id for ACPI devices")

Fix the issue by changing the field bus_id to const char *, and use
kstrdup_const() to initialize it.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
    strlcpy -> kstrdup_const. Thanks Rafael J. Wysocki!
    Change commit log accordingly.

 drivers/acpi/internal.h |  2 +-
 drivers/acpi/scan.c     | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index cb229e24c563..e6a5d997241c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -97,7 +97,7 @@ void acpi_scan_table_handler(u32 event, void *table, void *context);
 extern struct list_head acpi_bus_id_list;
 
 struct acpi_device_bus_id {
-	char bus_id[15];
+	const char *bus_id;
 	unsigned int instance_no;
 	struct list_head node;
 };
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a1b226eb2ce2..8d49d192d1c1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -486,6 +486,7 @@ static void acpi_device_del(struct acpi_device *device)
 				acpi_device_bus_id->instance_no--;
 			else {
 				list_del(&acpi_device_bus_id->node);
+				kfree_const(acpi_device_bus_id->bus_id);
 				kfree(acpi_device_bus_id);
 			}
 			break;
@@ -674,7 +675,14 @@ int acpi_device_add(struct acpi_device *device,
 	}
 	if (!found) {
 		acpi_device_bus_id = new_bus_id;
-		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
+		acpi_device_bus_id->bus_id =
+			kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
+		if (!acpi_device_bus_id->bus_id) {
+			pr_err(PREFIX "Memory allocation error for bus id\n");
+			result = -ENOMEM;
+			goto err_free_new_bus_id;
+		}
+
 		acpi_device_bus_id->instance_no = 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
@@ -709,6 +717,10 @@ int acpi_device_add(struct acpi_device *device,
 	if (device->parent)
 		list_del(&device->node);
 	list_del(&device->wakeup_list);
+
+ err_free_new_bus_id:
+	if (!found)
+		kfree(new_bus_id);
 	mutex_unlock(&acpi_device_lock);
 
  err_detach:
-- 
2.19.1

