Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7E339AF4
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Mar 2021 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhCMBz6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Mar 2021 20:55:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32976 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhCMBzy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2021 20:55:54 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D1sA5v119657;
        Sat, 13 Mar 2021 01:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=i+jmbPl/6rl9DWqnAzusEK9EyBSAduMNZD91xSeRGRA=;
 b=a6f2Z2gj2H9aGKe2WFYD6kkG/ZsEa88SdxbYZdQ7VnCFtgBfTov5LyJwXMaPI6F7fJB8
 M+v/GGDEgHJLCR95k0HXN87e7qKkX+K8bFwqWjOPuiWOKDdkuPWSGqBdtLIEyzwrv+D8
 3pdAkDIsQJPSdUw1V2gu91EzFM8PxTfqQKOag7nOePPlrYN4V4tCeaW6khexERIxONgS
 uSiNHuWJEEgFfv7ymgDgxk4RfAqkJyi7wez0q7m3CpAT+tjY8PobauPM9+fqG1QtsSLD
 FUFp4LWvjFPja6CkH+Ik6jHYZp5W9usv4L8ebElwXZ3pt+PTu/f3iBTvN65hxRnrp2W8 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwb82bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 01:55:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D1tb0t191493;
        Sat, 13 Mar 2021 01:55:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3030.oracle.com with ESMTP id 378jgtepd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 01:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu0CyYLCy5XhOxT4aFxxstnf+BpXQ6r8bj63DUt+D6ZS985Brxj81qIVio9VLqEFbsxTHZWs40Et/nk3RcWY8lycA8vLDIltGyeIsivsB/UR2iO8D173KSI0ZlukJZm1CTLv4BweIPP8Eehn9jpN3cY0noQONRMsr+eqjAu8U16OmOTNODEpm4IIK8aiyOrU3sEDSNGt++/J5u+OwDfEqznCtr5vu9NImIaKyPpJVacKXTFyyIVm1vfUdYwcShJe5p2Pps1Mv6w95YEV2rsLB7eBAkT8e0UNG312UBTvyT7JUnl6MzdYPDbQaOB73v/6IQEXGYf79ZUyCwYbaWW7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+jmbPl/6rl9DWqnAzusEK9EyBSAduMNZD91xSeRGRA=;
 b=eyO41gPTOwrb6+5/oB+OXmjL7oqcDSu7+3eeg/8EDKxu9WMOf2WVRq5OPlzTaMHu/UxTF+3ssc/8Ipld/kHVnnshACygMbN3UU/K6e5Vij0wkzcklr0hOh9vjcmcg0b/gUK9FvfWVXhCvTcr66oKPDBZ73SDhp+ag33oqpj06WlHV0YKHYE4MuHIiTLy8FVF58QkrSo2RInwoGYx7C9gkUnjg3NOteGUbo8bZWoktNAlms8xOhWgDoP7PI3VacCRmz+VgG9AVjHqh9Qf91hNAxo0M0bY+1UR0RyzXLuXYW8jwFyKkq/hfihFTISEGoZqrNPhto2cKo2zlB/3ZgNsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+jmbPl/6rl9DWqnAzusEK9EyBSAduMNZD91xSeRGRA=;
 b=Tq1U1eHOePBZHx6srjvBUvNU8ufjg9LEIZaHIZ13ojEYL5nufSx6qcF1EXyJquCgWH7XoLaWycpxM+4QRtVqJIVzwuQbhcpanxzphvQ2PkPHqFBBNWvs+OM/7WLr9YzwqfYJ7awTaKuxG3TEXQSmSo8WuRdeIWJiqaDlghWEy9A=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Sat, 13 Mar
 2021 01:55:42 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 01:55:42 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tom Saeger <tom.saeger@oracle.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, trivial@kernel.org
Subject: [PATCH] ACPI: fix various typos in comments
Date:   Fri, 12 Mar 2021 18:55:35 -0700
Message-Id: <fa193b3c9e346ff3fc157b54802c29b25f79c402.1615597995.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.30.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8014:1041::12]
X-ClientProxiedBy: CY4PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:903:117::29) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8014:1041::12) by CY4PR02CA0043.namprd02.prod.outlook.com (2603:10b6:903:117::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Sat, 13 Mar 2021 01:55:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cd07836-86da-4d59-5f2e-08d8e5c31c1d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB42266C081F0DDBA4831A0C1AFC6E9@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVYvGzrYy/5awluU82/RX5i3hvDZ+eZ5iyND25YeO7jMr+G/t1LH2OgPtfwOMW92LxiH1xoT03iO5ixoKX5eAYLTxvKbP5aOHoOezrv42i0HiaX4NUmPM97NSaAujgZEHJchOpUSmCfKwrz8yoLA8uiqOwNt7xGLF087PdenAGK1gIwkB2f/4ZiOHKfCJpEYqOo+u8vnsFw6B4UP/hcI2Xry/aJWhNkYTakFh/vJSJI6wr5puyPfkh127810eZVTpFXEedVBX7r3Sv2MBNF7OKUcHkMHqL/tzLSJZi/j+FAWOL3DQPerBzqHcxc2rndJ8uZ6EdBBVM7eZtI1PjPSTZIJGuAFwXOtwyNoQGKok1knF8oetYZx++dasIzLfbTPYQ7cMtAJVxGWbMhiu/EKlBRU0gAK/Lx5mJSn8QOpcJhTDQrZncoOT01pDqFLifdAHo3qd32vZSyG5VnIdikSmLiD5Xuz7juYyAkkbMO5XtRs48tcvG2Xa3tY5LuXjhTryAPc5LuC6un29o5E3eP0BVEZgpKC5EuZT/UxGqhfbCGHs5KHrrDc/bD3sCLsRGQxMYOZXCNlPVF5CMTgFrapKLSVEa9tDYv+t66PzuL/Dwdpw20+8oQ0iHu/mOmlsIiL2MYSJIwlS1cEUipxtvbmX4dU2ardwAq5xQ0zI09x15/9gLpJqWkyLDeb46ZD+dxO+rm4u4bj/qmQaAJddhL2FFUvyqV2HHPjZ9u330lts9ZLQomPLQqa7ZTKKl+OQkD7nJXQvdLj5M+Srq71WAjZBryKTZ8nDrffM0c2//qNQ3FHjmx3c86xfbO00QJM41oV7nN+uvgKggv0fzzX2QaJ6jao3wOWDJGoveMr2vt3dPS5KOb8gNpAnhsBqzuCoNPXK2dH8X774PtxPfxz0vo8gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(66946007)(66476007)(66556008)(86362001)(6486002)(52116002)(6666004)(186003)(6496006)(16526019)(83380400001)(2906002)(54906003)(478600001)(4326008)(8676002)(2616005)(316002)(5660300002)(44832011)(36756003)(8936002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Sw9R1N8l01tPlj3TG5hiA8OQJL3b3BWzU9yrNpNHZ05pl0Cb/uamyUdtyFZE?=
 =?us-ascii?Q?0+VrHfHO82oaLWun5EgW1qxeoG5U1qh2lrU5trUC4M5BYEIzT9ipJcZPcNOa?=
 =?us-ascii?Q?G26tfJZ3sg4m5A/VSbRGA+h0tcVlaO5wop/pBU76/jaV/mrbgII45utyhbDz?=
 =?us-ascii?Q?+CGjD4B12D7OrSYzk8wDtv/YfxMEg/b4sjSMmopdTwoTVcRYwy07Y39ZgBxc?=
 =?us-ascii?Q?LMBXhPTZViNucMAVhcFRKraBUzNFxMrKCOUF7TWv4VjKhJZzdqcBLMFgSD+k?=
 =?us-ascii?Q?a9PRH83JgcGLc7TbiSgx3D36afB61e+tbp04RrywknSfr8n+DCeOzPi4UofL?=
 =?us-ascii?Q?DQDlKT2AvxrP15BMfJGZt6QOY2UI9tHANm/eOUHk8iDPSuI3i81SX/gOmm42?=
 =?us-ascii?Q?crr/47tcaFUk+Rk/8iz0iXh0/HbvwUF+lpQHR0c1io9uWA8gJoGr+sOz/Fqa?=
 =?us-ascii?Q?8eabSKBfo3WBvsnQPHA6jWnQ1f4F5Vl4WG1ka8FhiPDQgCwLs8HRZN2PwHyR?=
 =?us-ascii?Q?r4s5ObsOWDaKtfgofFYsiND7V2AUxmNGbJ5IgWbaWCBDNcuaLjL94NwfjYeT?=
 =?us-ascii?Q?5r7SiG8vXN8d3oHftUKWnrgTyhkRhWUyufUF6V3nm3dwka3RilQE4UgwkQ6x?=
 =?us-ascii?Q?LlV0bgrqHFVS0pIGqb6hmW73XpPl8F+nbPg8Byx0hQ7V3LhZdsFJqdwVEZmU?=
 =?us-ascii?Q?qwWdOAKAge3w/NbPR5Zip2Ldpbex6EVc35YKshfkCb8zNu32Uhi2xsGZTKEZ?=
 =?us-ascii?Q?LaLTl6Ga8aWN9PG99HeowajhCxDvX60ph91HdkxQ8VwfxvcVXg/y7Z7Sf9LG?=
 =?us-ascii?Q?GTZDYaG/rSXENLc6ubybTPvbFp5S6yojWWAosKbNAEWW4fOx9dlAtWIvx5Xb?=
 =?us-ascii?Q?SFiPVBXV3rhixaNuACd0MYFXm9fknSJG9DdnmkoTgLG+eB7M+PO3E+/gOCXN?=
 =?us-ascii?Q?JFfcvOvV5DBpBWh6jKgorhqdhQQuqSUq83tqxi3l4r9A/oGyZpWbmwA78sMV?=
 =?us-ascii?Q?/pXPH40+Z8mPdAHp2rrzxESmj9AVGcmDNHncUsR8V8o8ty/Sud3Pt5J9aqhg?=
 =?us-ascii?Q?7I6ZSnU3TXmz9xcXvXjGGnW7kbygLaYcO1W2qtPfYkxlbElUGafUB6CzBMXs?=
 =?us-ascii?Q?U9b3WL66SAuEf0lvH/uR2FeB5l0jYkqvFl5ZqcvjrQrZuQy2uw17/+eZjLth?=
 =?us-ascii?Q?TDVvirXKJAPrE4kAiDZI0on3K5B0fzEXCEI5k36AJCHc8RGHsFEjuUVYbiVF?=
 =?us-ascii?Q?1E/Y7nY+639adScXnaj6eMV8BB35GQlzqeLyjjncJmEEdIZ9iGD30O8BTwJd?=
 =?us-ascii?Q?+f+yfGyMtC63Fkvo5SzGGRs3ovcPzXUf4yo5aip6JUa6jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd07836-86da-4d59-5f2e-08d8e5c31c1d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 01:55:42.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voWzR4wbEr43tynbUygk/Yksa8zPYiWWeU67ENJhO9pCWpdqbyeXf8wH6/RbqJkuzQovMJKQtyV4VqHqYaCnJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130009
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130009
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix trivial ACPI driver comment typos.

s/notifcations/notifications/
s/Ajust/Adjust/
s/preform/perform/
s/atrributes/attributes/
s/Souce/Source/
s/Evalutes/Evaluates/
s/Evalutes/Evaluates/
s/specifiy/specify/
s/promixity/proximity/
s/presuambly/presumably/
s/Evalute/Evaluate/
s/specificed/specified/
s/rountine/routine/
s/previosuly/previously/

Change comment referencing pcc_send_cmd to send_pcc_cmd.

Cc: trivial@kernel.org
Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 drivers/acpi/ac.c                     |  2 +-
 drivers/acpi/acpi_video.c             |  4 ++--
 drivers/acpi/apei/erst.c              |  2 +-
 drivers/acpi/apei/hest.c              |  2 +-
 drivers/acpi/cppc_acpi.c              | 10 +++++-----
 drivers/acpi/numa/hmat.c              |  2 +-
 drivers/acpi/pmic/intel_pmic_chtcrc.c |  2 +-
 drivers/acpi/power.c                  |  2 +-
 drivers/acpi/processor_perflib.c      |  2 +-
 drivers/acpi/resource.c               |  2 +-
 drivers/acpi/scan.c                   |  2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index b41180330cc1..b86ee6e3baa7 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -187,7 +187,7 @@ static int acpi_ac_battery_notify(struct notifier_block *nb,
 	/*
 	 * On HP Pavilion dv6-6179er AC status notifications aren't triggered
 	 * when adapter is plugged/unplugged. However, battery status
-	 * notifcations are triggered when battery starts charging or
+	 * notifications are triggered when battery starts charging or
 	 * discharging. Re-reading AC status triggers lost AC notifications,
 	 * if AC status has changed.
 	 */
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 2ea1781290cc..698c67f06e90 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1392,7 +1392,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 				break;
 		}
 	}
-	/* Ajust level_current to closest available level */
+	/* Adjust level_current to closest available level */
 	level_current += delta;
 	for (i = ACPI_VIDEO_FIRST_LEVEL; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
@@ -1555,7 +1555,7 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
 
 /*
  * Win8 requires setting bit2 of _DOS to let firmware know it shouldn't
- * preform any automatic brightness change on receiving a notification.
+ * perform any automatic brightness change on receiving a notification.
  */
 static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
 {
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index b9597216d021..242f3c2d5533 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -54,7 +54,7 @@ EXPORT_SYMBOL_GPL(erst_disable);
 
 static struct acpi_table_erst *erst_tab;
 
-/* ERST Error Log Address Range atrributes */
+/* ERST Error Log Address Range attributes */
 #define ERST_RANGE_RESERVED	0x0001
 #define ERST_RANGE_NVRAM	0x0002
 #define ERST_RANGE_SLOW		0x0004
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index f220bb00e91b..277f00b288d1 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * APEI Hardware Error Souce Table support
+ * APEI Hardware Error Source Table support
  *
  * HEST describes error sources in detail; communicates operational
  * parameters (i.e. severity levels, masking bits, and threshold
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 69057fcd2c04..12478e62d8d1 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -101,14 +101,14 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				(cpc)->cpc_entry.reg.space_id ==	\
 				ACPI_ADR_SPACE_PLATFORM_COMM)
 
-/* Evalutes to True if reg is a NULL register descriptor */
+/* Evaluates to True if reg is a NULL register descriptor */
 #define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
 				(reg)->address == 0 &&			\
 				(reg)->bit_width == 0 &&		\
 				(reg)->bit_offset == 0 &&		\
 				(reg)->access_width == 0)
 
-/* Evalutes to True if an optional cpc field is supported */
+/* Evaluates to True if an optional cpc field is supported */
 #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?		\
 				!!(cpc)->cpc_entry.int_value :		\
 				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
@@ -1330,7 +1330,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * is still with OSPM.
 	 *   pending_pcc_write_cmd can also be cleared by a different CPU, if
 	 * there was a pcc CMD_READ waiting on down_write and it steals the lock
-	 * before the pcc CMD_WRITE is completed. pcc_send_cmd checks for this
+	 * before the pcc CMD_WRITE is completed. send_pcc_cmd checks for this
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
@@ -1355,8 +1355,8 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
  *
- * ACPI CPPC does not explicitly specifiy how a platform can specify the
- * transition latency for perfromance change requests. The closest we have
+ * ACPI CPPC does not explicitly specify how a platform can specify the
+ * transition latency for performance change requests. The closest we have
  * is the timing information from the PCCT tables which provides the info
  * on the number and frequency of PCC commands the platform can handle.
  */
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index cb73a5d6ea76..a84d85d8333c 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -722,7 +722,7 @@ static void hmat_register_target(struct memory_target *target)
 	/*
 	 * Skip offline nodes. This can happen when memory
 	 * marked EFI_MEMORY_SP, "specific purpose", is applied
-	 * to all the memory in a promixity domain leading to
+	 * to all the memory in a proximity domain leading to
 	 * the node being marked offline / unplugged, or if
 	 * memory-only "hotplug" node is offline.
 	 */
diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/intel_pmic_chtcrc.c
index ebf8d3187df1..2900dc3074d2 100644
--- a/drivers/acpi/pmic/intel_pmic_chtcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
@@ -15,7 +15,7 @@
 /*
  * We have no docs for the CHT Crystal Cove PMIC. The Asus Zenfone-2 kernel
  * code has 2 Crystal Cove regulator drivers, one calls the PMIC a "Crystal
- * Cove Plus" PMIC and talks about Cherry Trail, so presuambly that one
+ * Cove Plus" PMIC and talks about Cherry Trail, so presumably that one
  * could be used to get register info for the regulators if we need to
  * implement regulator support in the future.
  *
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 9b608b55d2b2..a6498c9dc28d 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -935,7 +935,7 @@ int acpi_add_power_resource(acpi_handle handle)
 	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	device->power.state = ACPI_STATE_UNKNOWN;
 
-	/* Evalute the object to get the system level and resource order. */
+	/* Evaluate the object to get the system level and resource order. */
 	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		goto err;
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 32f0f554ccae..a2a9371cff49 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -98,7 +98,7 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
  * acpi_processor_ppc_ost: Notify firmware the _PPC evaluation status
  * @handle: ACPI processor handle
  * @status: the status code of _PPC evaluation
- *	0: success. OSPM is now using the performance state specificed.
+ *	0: success. OSPM is now using the performance state specified.
  *	1: failure. OSPM has not changed the number of P-states in use
  */
 static void acpi_processor_ppc_ost(acpi_handle handle, int status)
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 20a7892c6d3f..ee78a210c606 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -596,7 +596,7 @@ static int __acpi_dev_get_resources(struct acpi_device *adev,
  * @preproc_data: Pointer passed to the caller's preprocessing routine.
  *
  * Evaluate the _CRS method for the given device node and process its output by
- * (1) executing the @preproc() rountine provided by the caller, passing the
+ * (1) executing the @preproc() routine provided by the caller, passing the
  * resource pointer and @preproc_data to it as arguments, for each ACPI resource
  * returned and (2) converting all of the returned ACPI resources into struct
  * resource objects if possible.  If the return value of @preproc() in step (1)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a184529d8fa4..dc97100ee6a8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -561,7 +561,7 @@ static void acpi_scan_drop_device(acpi_handle handle, void *context)
 	 * prevents attempts to register device objects identical to those being
 	 * deleted from happening concurrently (such attempts result from
 	 * hotplug events handled via the ACPI hotplug workqueue).  It also will
-	 * run after all of the work items submitted previosuly, which helps
+	 * run after all of the work items submitted previously, which helps
 	 * those work items to ensure that they are not accessing stale device
 	 * objects.
 	 */
-- 
2.30.1

