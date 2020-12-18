Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D602DDDA1
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 05:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgLREJo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 23:09:44 -0500
Received: from mail-dm6nam12on2106.outbound.protection.outlook.com ([40.107.243.106]:34177
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbgLREJn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Dec 2020 23:09:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+G6BRGR0+qDn8w42D/B1PU4Z3x9k8gVqHOggtyV4IoXBGtYizRcgTcq+2eKTOOik99Y8eMRSLfYynsz3VDQnNqeRSZDEd+qavaQ11nFpUj4DaqrfNjSqcbEiYsF3l0A/bNa8nJax3Uk7yFK7C3glJrZiYyijJkLtpBGHC6bv9wvJS1+imMfrtSc+jhc6L8PVlOP+Lc90WaXNQtxSaoQeleJ22XJ7av6Qlt1tVRAJWORtqbhfqOj2Fa61IiAbrh7tExrJzdhZgRfJYVG09Dm7dz82fRKu9Nidh3FjO7wAIXr0Hl2H0qs+7lI7knyeBayEtrOVrl89g2LAQBGoMJsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHyGVToNyCceEqLuNYWC5gJT/9bTKhLAvVw0KH067rc=;
 b=eGUUUr1g2q56eqj3MxQmdWYWyVpUqV7fqBNUbK1ZB4B3tg2a6EAQ957PaHv0LtcUubW7POmo7s+Vnd3MrRE77PC9Y+9d/GDN1Kid012ixmz6i/CzRC6TQhW+jxTK3Xfm5/tzCsmYDP4+VLTxGMsRBvqaInKtB8eAAEN8zrpX0VFpe7z3RaLjOerOeYPS9jvie/0dR6MTFNtt/jd0sxppOzTL+e/LaHBbg1QQGnP0exc7GMW+rhbowYtAbaXxU+RsZSuiO3ozjk4CYe/d0xZsnJoIiW8dlhj3gE/OoDxluBDfoXoyTF/5WPC1yJCY+JN7BSM8PcuYUsVVh/5wFHMc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHyGVToNyCceEqLuNYWC5gJT/9bTKhLAvVw0KH067rc=;
 b=GnXlybknL9gJHrLvsjA0ljOEgQWc96czAftsoW3G0xIrRDMcn2lxmnZMOLuukMrwUsD0bEvWPDqWFV1L2oDB17kaXXKXnCv14Gcl9CbCFJpeq4CfLULDQJiLcJb50WKah+HpMCGoJsIvB88190C4+dzVgCeBVhrVoaAzSPZj/Io=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:207:37::26) by
 BL0PR2101MB1009.namprd21.prod.outlook.com (2603:10b6:207:36::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.5; Fri, 18 Dec
 2020 04:08:55 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369%7]) with mapi id 15.20.3700.007; Fri, 18 Dec 2020
 04:08:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com,
        mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, wei.liu@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer overflow
Date:   Thu, 17 Dec 2020 20:08:26 -0800
Message-Id: <20201218040826.57203-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:0:3e21:8394:8c1a:bef2]
X-ClientProxiedBy: MWHPR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:300:12b::18) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:0:3e21:8394:8c1a:bef2) by MWHPR14CA0032.namprd14.prod.outlook.com (2603:10b6:300:12b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend Transport; Fri, 18 Dec 2020 04:08:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b34b651-88e7-480c-5103-08d8a30aa2ed
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1009476972C93D7D40161E7EBFC39@BL0PR2101MB1009.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6PwMPVPTR44LJ6HBr2lAzavSy2TIYbf9FFECnGyDivUO9vNP0DfZqpsjTvimxbPBN/UJFR+qPMzaV1eq6G9/UcU0rbJgIEa7HAHjRfGqxXdJuvFZZSspnj43UzgV3fjkPQZWxW4Yw/od1cA1/3KFam8NBhNTveaNbQlMmUnM4k1IJyFbGCxFnWmlYyHsBnkLh481McqPmVNj2JdMeyXcmIkjCOt5z4k+I3Z7GhiJY2lxOtyZ+pX++nFiasYm7CzjV7UvJJbdC4k0FoQNvGx9/GRW0WoBg9B3zAcbB6+T5VSYHiFPKa3l5ex+rzom02gNNhiXyOIYEnAxBdkz/ZLnjrRx2+I2Trb5xpbortXvdt63uPri36CzalxQ2pENxmPrQ7cBylh+klxudBKdVNvwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(82950400001)(3450700001)(107886003)(316002)(2616005)(82960400001)(2906002)(10290500003)(66946007)(83380400001)(5660300002)(6486002)(16526019)(4326008)(86362001)(8936002)(52116002)(6666004)(1076003)(66476007)(186003)(6636002)(7696005)(8676002)(478600001)(36756003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YzZC5kwZKa5QbXJeRoObB6gRE4MhIfQ6UGkokDdriX65kiOJeP4HtwomTVhP?=
 =?us-ascii?Q?VWCEsmf/idEGbGdjRN9Aw3T7qzUEVShNpCy9vaSLZq5n53JTExWXCOTUbn3t?=
 =?us-ascii?Q?1l8RdA+MNKQmGvkIha7r22nkqc14Ah+ADbbnvfcbLtta32xRD8QMTpeKF084?=
 =?us-ascii?Q?5mxyywnyYWZzZUzgpQY78A7+QWgx/emUqNwYE/+DM8vuHVELYDHqZetVlJJx?=
 =?us-ascii?Q?XLJZeEaQYCj6RLk4ZQOK7U3qHx1XUF59wwzap3dZYke/bvBbDZtYQ7JCslnR?=
 =?us-ascii?Q?Le66p4bRgWFdXHcjM5P0vAQlrVfNmq2af2BxAAaL5wTRpgsLm9yL6h5JlBrA?=
 =?us-ascii?Q?4u/SQS4MDz+G7p5pZOVkx0HikRAtNQ3qK5hWmZHSr6aS/mLXbkc+2bMlV272?=
 =?us-ascii?Q?Pm6FZjZOmKf77agXngqKM9XQxXE871qIi5T4nzplCpArtY9pzj7g4O4PcWWx?=
 =?us-ascii?Q?P5cfgifGzWgqp4VtPORquywlavI/QRxB5ziJ3BCwI7UBWJWrbri+fqH1xNx3?=
 =?us-ascii?Q?6RNGc1MfuAasNbT5REOzoqdIzNmFOMB07moIdK9a8wUxDyzbIxndmkBhR1/d?=
 =?us-ascii?Q?Ml1PvS05nnkbKA2ti7KwqQaGr3jt2Ex2Mnst8raMf3XZWEsbNHedT0fk+lXY?=
 =?us-ascii?Q?f4S3aJ2i3qxpwaR8uD+y4uATtbaXNrpIerWjtc4+Mhjz1ruSskX3t02dPsYb?=
 =?us-ascii?Q?pJEAOvwe8di1qWs3/I05SxxF4ERfHDU6DVvEF38XAfXol1b0CNKOytkCZ5Yq?=
 =?us-ascii?Q?H6+vzZZ8CAtAYgvYdtggCYpkHZHj6JBpal5vXLGI1l0kzTjO0owU4vNMKyeY?=
 =?us-ascii?Q?Nb+0v0H2OFJhQ69jsAfncJlTroVukVyQk6279I6fL6YqmmUKYP5FtWqUk9i+?=
 =?us-ascii?Q?yhcqk3GV37wDVCUwhstTmtIdamj/6O66g7TakU/0TFVXIl8aLT3un/lU8ZIO?=
 =?us-ascii?Q?/QOjxjPBVxaqx8B2/WArW3uUhe2pMdJMaPnCLTrsXrpWPT1XdlmpHn7seALq?=
 =?us-ascii?Q?BlcUo6WbuPAsVBiw1PwZWB/CsaoURlg0zvFqR1hMKI79yOo=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 04:08:54.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b34b651-88e7-480c-5103-08d8a30aa2ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iB2DIlUAWWpW6c/QTIa2ZBaFNqhCCqZnEheiBtJFGIwqy3lwkTy0d3YmCdUJfBxDX/O8XKtX5JONTHJZuniD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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

It looks like so far an ID string of >=15 chars is only seen in the guest
BIOS/firmware by Hyper-V, and AFAIK the ID string "HYPER_V_GEN_COUNTER_V1"
is never used by Linux VM on Hyper-V, so let's just truncate the string to
fix the panic.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/acpi/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a1b226eb2ce2..b801442b6b1b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -674,7 +674,8 @@ int acpi_device_add(struct acpi_device *device,
 	}
 	if (!found) {
 		acpi_device_bus_id = new_bus_id;
-		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
+		strlcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device),
+			sizeof(acpi_device_bus_id->bus_id));
 		acpi_device_bus_id->instance_no = 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
-- 
2.19.1

