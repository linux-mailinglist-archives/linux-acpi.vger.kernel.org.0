Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCBC32C445
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388577AbhCDAMN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:12:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33198 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387982AbhCCUJt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2021 15:09:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123K55KY170308;
        Wed, 3 Mar 2021 20:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=irl0Wmw77dUcKBbs9ktNXRLfC/1vMgA+MscayiqGvsI=;
 b=be8AnYvBwwuFiQygB34ldLGM0ucGZn7Wr3JwS6EcvXa2bh8mbBPPJbaJ0Y+brJeIIVz8
 et50xHPX3ODLFMEcFqjGXtzI11iDT9iwr52MnCnK/Agt/OJcxR54Rwef4FLUFVrlBRmz
 32x7acc+/Z88hwFTJ0Pnyjef2NOh7bHiLMti83zLdWF+KP11XXAPFByi3tHa9U2Yj4mz
 zQidSg83KO+Kb/O0WEY3kOVueuqJz+lnQkfn4RtLR0FGr3UNpQEp3SCw9E+m6yOubj0h
 jWlOWK8dAV5mQ1oqKhcXn3dgD/gNJ423PkxtsBiDEjTyQyi8RLeIBCa11qJqMChPGMMI jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36yeqn4rmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 20:08:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123K6c5V148193;
        Wed, 3 Mar 2021 20:08:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 36yyutwte5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 20:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FArvrqW18J3kWQGQ3zyxoGXL8g9zSf5VAKAnR62cXvKCPlKgKLIksjxI1UWxUKL+98LxK/M+7B62fktpuJmIxkKXbKUdaJ+o0/gNBfGJnjtpj4L2Rd8FlxooPL1Jbg2p6chTNnXCdyPnNALZJZEfKQISQuTGtREYwaTZbN+b/rJkjH1hd0M5vfaiYz7JNoKyF+2Gy/3opDX4ces59T7/PhE5sF1rZaibAZWSUltXtLzsGrKMBrRLql4pzFIK9ySwlN0tyr+HKYMTMvbB+JV2GJonGUHYqk0TgBofVjdgjYdg4Ti8KQPmpLMBhhdaAYMYoOiWGkajv0iXY5WrpHyrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irl0Wmw77dUcKBbs9ktNXRLfC/1vMgA+MscayiqGvsI=;
 b=dYSNNJd799AQK6PN/GLkRGGxOOURNEemCxphatW+i4uhzgnox9f9rsRgLPlw2c3Nz6EhBGAAsmEonTxKust/gU44hRbIuBYWHI/OnxBOHLrM5JCvJ4mVKiCOjQHXwlHA1ovMvoTyMtCSUHJe7vMuPN4bQq3wTLF8FU8pC8I9T2AU3Psyfk+rSuTGly2puNRPoT15LcGznZDj+FudKKSX17X1JcQhx4Oriorx2lDdf8B3R93593KnREurIujkVTE1enPA5LwmmFEetx6XKxIACe83b/jHLhR4AYbtDVcB7W/eboxpJePnCwwkvS4RmD9ghmjsZRI58ogoCqPoi0ZF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irl0Wmw77dUcKBbs9ktNXRLfC/1vMgA+MscayiqGvsI=;
 b=bRYXAmhOts8C6Jx3KoEMdVE0YVN6kAygw1JetdicT/ztSXQ1w1JJ1uMGeOPLP0blBrQVWa5C5hRbOu1FaNYHYXIK3k+Vno4sak5HHAZas8hRHeaWVDfrh39LO5M9DW1q3voVeINUEv/G9tk1I5HaPFwqnd2TyVZdFr8ilo4R1VE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB3436.namprd10.prod.outlook.com (2603:10b6:5:63::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 3 Mar
 2021 20:08:56 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 20:08:56 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        konrad.wilk@oracle.com, dan.carpenter@oracle.com,
        dhaval.giani@oracle.com
Cc:     george.kennedy@oracle.com
Subject: [PATCH 1/1] ACPI: fix acpi table use after free
Date:   Wed,  3 Mar 2021 15:09:20 -0500
Message-Id: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [209.17.40.46]
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-152-35-102.usdhcp.oraclecorp.com.com (209.17.40.46) by SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 20:08:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd3aaa83-d220-44b8-eb00-08d8de802ca6
X-MS-TrafficTypeDiagnostic: DM6PR10MB3436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3436F892D5AC7542EC8F0A4EE6989@DM6PR10MB3436.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ddqy/hQ/q2aySQREiOb53H+AZwfDCwYBAM/cwl4iekCxjFz9GnBswiSXMWsnBNrn1WUeyvhTGqzI8Ppc7r1TC6ASuThvtXmcFARE6YSjp440HLQpDcjKt71Z1IYNH/nfDLU+KvlI8000vO1HI1Kzp7iLQaAZbzl+xh9XNy1jQQqJ3jXa0XOrRD+VUtYRSpkPKvnPZ7UmpSOSUdlQg1dbRsX7KtXmUfGqr6zomOgH3FCwMsgMy2WrhMeCCKgCPqTyQWwuF9G+AoZM97nYY5iKdSQYSII3244vSPgGVfbOBERyI+bQRY8ODPwDMTvHj2vGWQgW0pswfP0wIE7CgQ5GGKTjLAvWE8xncj86STuDSdsFMH9CWuRhIDf+vxA3YYu4Q23mqKKF2BsKoz14r5BHwtuBY2tJYWcstgTVFOoW8GkhPvO++BdlBvUENMunm97QtYXT4WL/jLVa7yzwonnfOjXU7lsr6CTjnTVIhgSW9TkUd4YctuATor9RjG4WpTBh6ohyhLO+p5fIbPbHIZcXVI2n9EhEYqatlI0pGEhd4BcRI++Lsa4VtcsTIpVOqExd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(6512007)(6636002)(186003)(921005)(478600001)(2616005)(6486002)(52116002)(44832011)(66946007)(956004)(36756003)(26005)(66556008)(83380400001)(4326008)(66476007)(6666004)(16526019)(2906002)(5660300002)(86362001)(8676002)(107886003)(6506007)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/uRxzvEzuoCfGkaLGJMr3mmmP9oedMNK8q3LSsrU1vdbiOMqCTmYI1/Dg20y?=
 =?us-ascii?Q?TSc1rhA4idvZgmxr3bwzQqBMwpNs4wlX/REkDekZnYLZIqkQL1rl6txGqnN3?=
 =?us-ascii?Q?kSnE7X+atTWoMlNSgOOMCnnLHMgTkayd9Y4RDjJClATZw2V7CjFDaSqXjlc7?=
 =?us-ascii?Q?uyg6cHRzAutd6es8Ko693wkdwBIQ2rBkeIkIg+fQZOsVoPh8ZPWs5CKvwA64?=
 =?us-ascii?Q?f5c0V7aUxRlg4vtsuA4TjzuMjpEKvQTntT5w5vNtpniwXpuI3GWadM3ZwVHV?=
 =?us-ascii?Q?kTf8x39blhMIoUoNW3YcOTA3Uj4slvn1tc6TBh/8CBnz0moiWSRiM8Qe4CYW?=
 =?us-ascii?Q?BDeMczg7k3GIpVmnzq4epm+y7FBfTTXGhQ0sywBNDAoENt8wOH62dYmn069L?=
 =?us-ascii?Q?B9eP5MsmwfGrhuv1H+XnKE60IcZH0lYaQAGWUmHEVBGvLKRGQr101Aua+DqC?=
 =?us-ascii?Q?pdhwwt27QPfPFqTAERxr7EbjEr1zcOg6YdBy3CgHYXwCPoz4D569bo6sRPpI?=
 =?us-ascii?Q?fMdMqO4F5Tj+JavG7BfwgmdtyYjXV+K6lyzH/BxXD6CCw3WK38l6pJO4NJbA?=
 =?us-ascii?Q?nSdI/J9dPekgmXGlXIdmnSNTBCrhJWE0MTU3MVIFvKMr9t8mwooPJHkRv/oL?=
 =?us-ascii?Q?/J/8Lnyd3KF7kqr+DkKvMo+bMDlcRM/3BAOq3gxMHSprQWvqAPhZJ5bM6iCr?=
 =?us-ascii?Q?t6saS+o9ie0dzInIohHD37FDhCTrig+Wkgvu1Ic7vqZQ9/9sZqvnKaVYqXIe?=
 =?us-ascii?Q?WUbUPOs6dXjkGVAGIedL/kdsum5MEjdcaG8ud4xUBneVeL0VD8rAQp6ePyiw?=
 =?us-ascii?Q?nUoNBmMUI8pH32qmOC/rbHk2Z6dJYktxhlDACu0lM0bnbgibkcNd9nFUGCXd?=
 =?us-ascii?Q?7wh8e135iAcBiPCuc3DwjnI2f3UoSUHRA5w0WewBfQ6evecdqydFpWRHEYIn?=
 =?us-ascii?Q?pMqRiXwGL3h3k7jmQ+pLPiVSPriBXI4zP9lOP+CR72uGzBQ4cgYalhxWrser?=
 =?us-ascii?Q?thvSHJ34N1No7ZNVTGzA9G7PXTpLiXvnDQl+w/ZaPwLPdvwUlD9j4iKZdOeE?=
 =?us-ascii?Q?c6rH7x5cw19hcK5Y/BgkMjewT1HRV8knS8TikyxtBb7iUogs6KwDfOCegf+3?=
 =?us-ascii?Q?MLdiRkkDf1Xu5JRzhw60Oej3r5ipustFEWG2Aypb6eR+Kcmuyw+/wywuwMJU?=
 =?us-ascii?Q?9su8AU6yJmssLeHxdNZEHZUQJtkaxly9fn7A3FKCKsOPMA0KpS7VObzV+kvq?=
 =?us-ascii?Q?wyNYdAmi/A+TmTazNn2LKSF1XGn73oXmExYprdLUi5HrQKa2eyZoXK4EDis+?=
 =?us-ascii?Q?yRH9tnz3K0INcjKgxjzhCjVq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3aaa83-d220-44b8-eb00-08d8de802ca6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:08:56.0641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXh+CWKhXvzuSyTU0Ej9FvcvqjxVadrxJvGHX1MO/Q8saR6KatLjDzDje6+Fr+oSprncV2FYZZ8jMjImv+zujIDw5bGZfElTv+h8Q7xh+Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3436
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030142
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
in __free_pages_core()") the following use after free occurs
intermittently when acpi tables are accessed.

BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
Read of size 4 at addr ffff8880be453004 by task swapper/0/1
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
Call Trace:
 dump_stack+0xf6/0x158
 print_address_description.constprop.9+0x41/0x60
 kasan_report.cold.14+0x7b/0xd4
 __asan_report_load_n_noabort+0xf/0x20
 ibft_init+0x134/0xc49
 do_one_initcall+0xc4/0x3e0
 kernel_init_freeable+0x5af/0x66b
 kernel_init+0x16/0x1d0
 ret_from_fork+0x22/0x30

ACPI tables mapped via kmap() do not have their mapped pages
reserved and the pages can be "stolen" by the buddy allocator.
Use memblock_reserve() to reserve all the ACPI table pages.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 arch/x86/kernel/setup.c        | 3 +--
 drivers/acpi/acpica/tbinstal.c | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176..97deea3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1046,6 +1046,7 @@ void __init setup_arch(char **cmdline_p)
 	cleanup_highmap();
 
 	memblock_set_current_limit(ISA_END_ADDRESS);
+	acpi_boot_table_init();
 	e820__memblock_setup();
 
 	/*
@@ -1139,8 +1140,6 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */
-	acpi_boot_table_init();
-
 	early_acpi_boot_init();
 
 	initmem_init();
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 8d1e5b5..4e32b22 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -8,6 +8,7 @@
  *****************************************************************************/
 
 #include <acpi/acpi.h>
+#include <linux/memblock.h>
 #include "accommon.h"
 #include "actables.h"
 
@@ -58,6 +59,9 @@
 				      new_table_desc->flags,
 				      new_table_desc->pointer);
 
+	memblock_reserve(new_table_desc->address,
+			 PAGE_ALIGN(new_table_desc->pointer->length));
+
 	acpi_tb_print_table_header(new_table_desc->address,
 				   new_table_desc->pointer);
 
-- 
1.8.3.1

