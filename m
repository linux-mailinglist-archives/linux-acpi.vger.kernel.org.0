Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016DE3AB9D9
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFQQov (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 12:44:51 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:6999
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229671AbhFQQot (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 12:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeubTgy3FR0DM2YYB7yW5U1QkPwwpBOmm/vKZesrLZpC///IvHOqB85Xf9PfNldBOU4iph8Lm8XvmNvkUKe15DDqLCBf1iGgiD9BoLEktet4PlMsiuq6X544zvrAOrjkHnJC9MGqc0N/98bo5xBtP62SLA3LjjqP9JmuA7yXIIhvJecsWwi7UdfhcfpBAawlIKuIxuClDE1usPCQjBJmmhkjhCCq/EY+EXoHDss+RwFYd/IZFP4Ib94d4Q7/b6a7T/laUeVKl/LsHMwlq5z2COGNi6dBSNR6C9/OpzTOvxvU7B6tym9PMq2ip+GMidHcY+PP74gxuBnkyXyt3HH0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+P7onBhNPYsohbIu2M6AO5t48gCJPl9Z6d/Baar4ww=;
 b=faVlKneIJlYcd1Dmj3TVmdkQDa3oNcX1Q49D0/+drAuDAtzGwwzr1g1oYjTk1wEEaSa5HwL3M32mYdi/cg+zgWH3oAUdnINDw705plNTvE4pBzWXOFS9JBHVrMEzLW677sK8lcQOWiNkHpRX2u77qjlo59Go4UOGXVics7gv+sQoL9JPjWcLAQVXzGz3yKQcdrfnlLFhIX41k6lMP+KFsJgOa6zH4EYxr/tynGVgZBqLkA3983uG6iOm9v/Nef51uTVwT9VXq5Za8aBzPKeS40rA+Mnud94JBnBpafAvsFtCtk4NM0XsZStxFrqTWh0+XQZSYvxVPWNJBMSp7g6uEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+P7onBhNPYsohbIu2M6AO5t48gCJPl9Z6d/Baar4ww=;
 b=mNwZ/3UGOZSXge9PVpcJuYSwOyoT+rw0IzuFbszehthb7eWgQEL4c2pNUjleHlomwxgC73CzI9Qs24D5UoLlMH5YaR3wRmlQCEqP5mtXrhaSVDKsIDiYwiSk0g2dGnyYYiNDoCuKVjMekJK4ugzB2ibg4NegyP2Jo11UXKYAo1E=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:42:36 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:42:36 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 3/5] ACPI: PM: s2idle: Add support for multiple func mask
Date:   Thu, 17 Jun 2021 11:42:10 -0500
Message-Id: <20210617164212.584-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617164212.584-1-mario.limonciello@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN6PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:805:de::19) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN6PR05CA0006.namprd05.prod.outlook.com (2603:10b6:805:de::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 16:42:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc07645-10e1-4973-e748-08d931aee9c4
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4671CC5893FB8A6AEE146DA2E20E9@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHS0r95dYNdD9B49hxu3CviX9ArD/UKFzkxn49BPfsf0IZWd6XkgrcQvZ/ON58qBQ6XS+qDHiMPjJ0pVxwgG/Y9/EeHDcKVJ+M1rR5g/4K2wujbNvqjvkhsIEGVNunvZJeLPiWk+xl6KV2bGwkgHht6SwO6bDEnhtC+wj4yc1AO6dX37j0pPUtlBapunrPNs0F0+bW8vT/0FbAuGgKCZtrVzS1j9xqPEfWLi1QcOV3FaxUvjRTkKW5f1aT+E8SxKiXRgoxltOZjSwDVLiOBltIporPODB0ly77Geo+DGGQqqBwQA1KrxfN1eh81hgc/3n61+/lE98YJtlWZ8xKlHiew97nuoApycMmovY0i8XXcFs8/2tfpeaqyS0uMN8BDPiLCb5WZTc0ZLw0lpgu0VyEQowR9RIdNce8ptxKYWMHVyPO9u4aIjzwD/FzIi5rPz19emXE5Fl6nhYHycijw8UYX3cYPDHKrO2Dn+/FwTbaGHNC9kpl+dPkw7+AEUXbpKJZSG7w0NFIuLbZJG75T7BNmZ4yDAVNR/RlLROVlsQjzJvSxSL10pWfKtDS4aVFJE1/ZDGC3EspSRSHm6RgI2JGt6K74XP5ZA3d+QA5BCWfnRQfeP4rzHO234aeZWKr074dqmzZC39TI/m+cW8dyt83L+8isZBjzYdOk7SNXQB/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(316002)(8676002)(86362001)(44832011)(6666004)(110136005)(38350700002)(1076003)(38100700002)(4326008)(83380400001)(52116002)(2616005)(2906002)(5660300002)(7696005)(956004)(8936002)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZsve+dxOqi6Iih7PziTpXbkPVRhrvlP0v5+x5S6YJWYjs3vIJtTIsG1UZsY?=
 =?us-ascii?Q?fHhlDiKWOvHlGV9Sulj0jCRVyNhprCiIaxcxEfCUF/Ig0lUg/ieUBalFeiLc?=
 =?us-ascii?Q?N8J8YRG6wa6yQTD192oSMV9xp9vF+H3umi1+ypBjySTDoHJKbx0rZ5Ns8nIk?=
 =?us-ascii?Q?yo2E3IhGZsjnhEyeeoslD1qLPn5R52BwbaT5CSnKpaabXYRT2oaz5TJZOG+w?=
 =?us-ascii?Q?etreIR6ERQgqd+MNCLyhj+PiJPZoZyZk+A5ZEpAqi2Wgbq9Mw5oCOLld8AWN?=
 =?us-ascii?Q?y1H3PDaSDiqIU70IVMN7eYi7VOjsFQmpXJl/rA3i9p3mvUBNeKAIVDYBHptb?=
 =?us-ascii?Q?LQTwk0vrAK8dIqCCd3BK7U6iJcVanUtVa0M4rRexgtGTwYVNYse39jNPa/4l?=
 =?us-ascii?Q?XTBQYYL640MetG3UucTY8jHD0hsaEv8xvSb4B5tphxb8FIwGjR3oBr3AjLps?=
 =?us-ascii?Q?E5aAy1o1HVNBGk8uylAelbHexGpCZ12g0V8LhcB+tC2KvshyFzLtf3avlhg5?=
 =?us-ascii?Q?huB+ONVVlX8X6Yx6IEXk/CL3IH3qTRimMsitauqjlYWDDYAiXD8cnOd9fCaY?=
 =?us-ascii?Q?Um/zbkBkMhvZTPfnXoNQv7g+CFwqsYGeZQQeKsz16DXY+LDHhh22SFrPFsx9?=
 =?us-ascii?Q?fGXDtkXA1GcztxrhUqLcHpwUOmhpmLHkhEltd57BYFKEwaa5h0CUCKm8mG9B?=
 =?us-ascii?Q?QyeevJIw9awrGP/WuWIFSZVxBy2wMzeAhMFP3aXJkPtvDf9otUr4nfCD7BwG?=
 =?us-ascii?Q?y/9L38kxm3COsSjo/3YWxypKHwjnSZO8FtAxXIHy3L4r2F/NUP9Y9qsyglVB?=
 =?us-ascii?Q?mU8Q5DLfwh1v/64BMvuf9FPg/cAzz8UDmUjvTuYLNzbAqWOp9ReeV+6xBgYf?=
 =?us-ascii?Q?//NVJrAM8xmXELJ0xQHQRFixL1L5cWWQ4Z1HdsgLHQVGypJ/bB1kjIlAUioP?=
 =?us-ascii?Q?J6u4Ydu38sYbiZHxmURnD6efosPwOw2DpCeKsz2xKFaQMwO3TTobGFaDBLHX?=
 =?us-ascii?Q?0r0IKceMbSoPNcOj9zh6gWO/PA7EmIQqdAXCuSbbH+fQWQuCZsMd2VkhdmHv?=
 =?us-ascii?Q?bf2HPL+f9Nqj43E5qjKktOToUcSXbZBR9MIOU6+/po4Z9kbseu3/x2sUVRoP?=
 =?us-ascii?Q?bLpkPwmZuCyJD6H0yBHJAQgl2ZQzHJJzwhk/doE3NJuuPvOYXu+xnu3ZqETi?=
 =?us-ascii?Q?HlPmL1DVI8yYJ33EBAV0V1Jrkn6SC+4QMpVYptCx9VVfAaXj9ShJylhQ8Kjy?=
 =?us-ascii?Q?VuBgIaJLAK023Xn+ncs+WvPoM3ixLp0I3NsgZb+k1qZ5kKYOpVhATmLj1ci9?=
 =?us-ascii?Q?jId1Z82vTgjF8fze1jHOj9SM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc07645-10e1-4973-e748-08d931aee9c4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:42:36.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coAzDEjMUd4E+YECbw841cMeq1IqYOVuoVjRyo1wsRfttwrAhrLp2qnff3M+OxqXToib7KbnWzbZPzX3DBfK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Required for follow-up patch adding new UUID
needing new function mask.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/acpi/x86/s2idle.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index c0cba025072f..0d19669ac7ad 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -309,14 +309,15 @@ static void lpi_check_constraints(void)
 	}
 }
 
-static void acpi_sleep_run_lps0_dsm(unsigned int func)
+static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, guid_t dsm_guid)
 {
 	union acpi_object *out_obj;
 
-	if (!(lps0_dsm_func_mask & (1 << func)))
+	if (!(func_mask & (1 << func)))
 		return;
 
-	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
+	out_obj = acpi_evaluate_dsm(lps0_device_handle, &dsm_guid,
+					rev_id, func, NULL);
 	ACPI_FREE(out_obj);
 
 	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
@@ -412,11 +413,15 @@ int acpi_s2idle_prepare_late(void)
 		lpi_check_constraints();
 
 	if (acpi_s2idle_vendor_amd()) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
+				lps0_dsm_func_mask, lps0_dsm_guid);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
+				lps0_dsm_func_mask, lps0_dsm_guid);
 	} else {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
+				lps0_dsm_func_mask, lps0_dsm_guid);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
+				lps0_dsm_func_mask, lps0_dsm_guid);
 	}
 
 	return 0;
@@ -428,11 +433,15 @@ void acpi_s2idle_restore_early(void)
 		return;
 
 	if (acpi_s2idle_vendor_amd()) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
+				lps0_dsm_func_mask, lps0_dsm_guid);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
+				lps0_dsm_func_mask, lps0_dsm_guid);
 	} else {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
+				lps0_dsm_func_mask, lps0_dsm_guid);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
+				lps0_dsm_func_mask, lps0_dsm_guid);
 	}
 }
 
-- 
2.25.1

