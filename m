Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB86A37CFBC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 19:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhELRRB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 13:17:01 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:38081
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240048AbhELQZG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 May 2021 12:25:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHPbF9e664pLOk5SU/498FfKSv0TnHZerb0h26Vd1SMZrUCMJiT4F5x4Hf7A85x1TPL1OhzCgAqkaETtmVt+UHig2gmU88aU3zxWrWNvTBZhp6VZkXf/AbXywYfUDQDnC076YyOBFPQgmEDFAS9GUWt4siqFn9ttjVqaL5Eo+XmZvqsvq8JQNtToPR8cspTAYSHipNPXk7e+GkTrc2Upc8Hxuw8KybrWtj0y9EwughN9bO5s/sboTJeH6SyDt106vEZURX+WfICrWszXEczCh+2HjwMdGNhM4VhntcxhVmLimhSDU/rdrU2+ty7YlQTf9vTUlscWnhGvESnhTIkRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAO5U4PeFGB8+SD22M+2LFqihtyW8cCAU4QcnrLJ47E=;
 b=mAm5XiLfmpT5qntzBvwettTPjGe5B8bQGIPh5EqYsNKE7MqK0FRhWzVTYjyVnzXR2gaR4liVUiYYZwg076YTCtQa+3emA2zaOvhAO26TN5GK46ljF9QVwQUpaKHegpOpCJkrMOyBDqeckod+YUbRI+ACDXyu58KtcScsubgd0NMXAzs6ovMSqTje2iXe550a01Ct4V6JVPsbvHuz5VFtZonXgF0pUjDWjGhuM2+gd4Mev5A5XyW28s3DC4H75tl9I+V2bWTuPmRiC8/hgK+rPs5DeOrdBHgU1ZwD5h0i4dbfuZQ47t6Z6JXtpH+Em1PqqNzqlTnxeaicUs2Z4PZ26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAO5U4PeFGB8+SD22M+2LFqihtyW8cCAU4QcnrLJ47E=;
 b=JyYfYLUd0zkDrPw+7ZKzfmF4iESh38tnG6JbMVzDb+C9A5v4VWdwHtnCoD7SGYYwH9zd3g3bXavf98GqseZBf2u1nqPrBaD2xCrCxqTlkYTRz/xQYHgfgv0FkGqVIpdZXi7140Ok5hMCuxY/Ke8pRDQK8BNCplT+Nwccq/dknxA=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 16:23:56 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 16:23:56 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2] ACPI / idle: override c-state latency when not in conformance with s0ix
Date:   Wed, 12 May 2021 11:23:47 -0500
Message-Id: <20210512162347.23550-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN4PR0201CA0072.namprd02.prod.outlook.com
 (2603:10b6:803:20::34) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by SN4PR0201CA0072.namprd02.prod.outlook.com (2603:10b6:803:20::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 16:23:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e49ab671-8f45-465c-c833-08d91562572e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2760A603FAB01D34D9BC0AF2E2529@BYAPR12MB2760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnodWtTVQmVUA9KwKpZcdj4Nht5XkmOcDK+TmOvU3PmX2lAevhG+VMZ2NJW5Ow6aFp+BDfQl5jQh0Z3LPXI8VsN8U4qgwC0I0poN3SxRi03NG0ovR4q1xscwun5bhqnYMCDnpLBEupX6vQQ0ce6TJqJxZhYwNm1YRdocSwcOvMMYcJWO/2bTfzOmfolUi7q1uKTeh6B3r6Yg3nHvZ3Z0RLeoT39hwklxWSaH8yoGFK82vAdovrVBCRmfHg6bidUml4BTOZulA6T5cTOGx4LVyOuDdo9IlGwUjF/qA+fNrCTd8Ia9rBHN0cycC9r9rciw/77fxakc+rVEZPw+++1Sd2V5DNn0ZyV1dmfgQifNd9RGB+uvWvoB3Kwm+odxiUu+mSah9MwpW7zqvUPGUjBc0Pt3wh0sgHtA2GAS0V2EZK5QC2ivLQ6i0yANUHV17Zr1qX0GNvU2yy7xRdKoVUblN4GX+iUDGkjMYYihr1eBo7tfHayXmQNKI0mW0Wv11KjaPzyRyl8hQoWyUXfQjeHbzl1FLdxgMLd+yIYKKFY58pJiktuEVhGQhD6HCDB7acOzVd/mwvougNemaZVoIKmCruh40Zaw6Yjlu8VyY/ubu9tUPRsWON92SJxxA2V+fqBzXjekYrTMtFXXX4GFWWjgJmT5S7deD3pHWkTXM0KeNIeKCfZHTpV/viqXsmMjgH9973YFw9ru1UM7tPh5N8kmOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(52116002)(2616005)(86362001)(38350700002)(38100700002)(83380400001)(66556008)(6666004)(66476007)(66946007)(4326008)(2906002)(44832011)(966005)(110136005)(54906003)(6486002)(8676002)(186003)(1076003)(16526019)(956004)(498600001)(26005)(5660300002)(8936002)(7696005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uCfX9uZ6voMDYVoNwHSPGRHHzy3o/iiI0BiAPaKZsrUK6hZDY0S5ZTqXS9FY?=
 =?us-ascii?Q?fqAfJ9qz22xBpgUkdVb9NwT+mtkLE0Ioj7Bq2YX7A7kSUZDqBUqKJLq/joxx?=
 =?us-ascii?Q?cYMYXpP/ML8Ozqu4VqPRKxcGc7SwP1rPhrSWkkyGVY/8E7qWgEV7gHSTx71n?=
 =?us-ascii?Q?hZnQm8hHLNCYQ+G2EsiqYMl3SauwPIpCShYrph0RJw9XDXZwMWDlRUyIuyA7?=
 =?us-ascii?Q?rX14BQ46QwEXMd3Tb5L/FN7W5DqBxTTBXuzMD/jXSb1n64CHNXxt421GCH9x?=
 =?us-ascii?Q?OcpKuPsDsUDllHD/G7rjd9qLGwbAObLYzJ4nuuSHwO+04plrE291dW/eiRAl?=
 =?us-ascii?Q?WNzKVh5UXBA6TQV7e2xN1dOgN+gHlaefv2UKGTm5SEqLG3w+HD/f5v4aKAXr?=
 =?us-ascii?Q?xCLCt3enB/x66MQ/nJ/WxitA4/MKZeDzrFhXZ7M1PUc484GNrQvWu8N7+qHR?=
 =?us-ascii?Q?NKs5BlS7YT4XnyBA9ombXY45hcknGRgS4i8cFIuYJASi4EuOBnr+bZUlUv0j?=
 =?us-ascii?Q?8t20ILiBhmA4mEdW8QrxN9tSVWB2jTnz9xvqqzLHCD3lOToEQdOTPotJL76u?=
 =?us-ascii?Q?ZKSggedKQD9XCbmSQfwzon57y6wZn3IbE99mNxC1PiO9C0w57RUMvcwqvIWA?=
 =?us-ascii?Q?GNYbgooyCRlOnoyNJj2y2B8yu1hV1EZil0EuHlY7PL3xXWGcTser9M8cFYx7?=
 =?us-ascii?Q?qnr4scj3M0q5m2DoshHz0EWvhJ+sS0zcGi+dFHZGaFjwSp/IcIkarDafv5a6?=
 =?us-ascii?Q?PkjN7Ld6Bh5ml6444UQkUin088BX+Zdo08A6DGg0rPf7hb1dp4WKeBDORN1z?=
 =?us-ascii?Q?gXMmQjnhDfu+xqJybfIJiCZwf13Zs+jFCTu43NifOhgVCEPaEIX8xCxEggEo?=
 =?us-ascii?Q?U/U5Lgw6GNSdZzCyvBvDa0sk1aLC4JIu87kR6l5EUeqkjmi+2h1ynhFepJNv?=
 =?us-ascii?Q?tFlbwOH0VU6HH4u3Bz23/SE+3FdtZHHHE1pN9qUy8Au1KoK7QQe1zz6GVhd9?=
 =?us-ascii?Q?8YQyRdl8gil9VCl0qtq4pNfU9Jfdt1o9XAj7+v2qCgKUQfcvTp3mNpcgOsDs?=
 =?us-ascii?Q?/35b4mhZ6tcFdRcLnitC3yghoYvjLBq5C3oe5mJB/I/HBXoNFFe7BDdtHF+e?=
 =?us-ascii?Q?uY0kDEDA2n+fNwh6PGNxSf2P+PeB2tj4QMh50ZAMnLQtU2d0zj3zODhb8o9Z?=
 =?us-ascii?Q?TjWVAyokdkKvAczA6UhyQaDmKDZcyPPKyXY9RC65DOVigC1dbt5tITsi8C51?=
 =?us-ascii?Q?j3kjLh9CUw7DBLBJ6ATKL3k236q+UHoTVa7rX8i2CZPFB7Bsi8ihByWMVBWU?=
 =?us-ascii?Q?o5HdU2lcLhDGjHZ7IQIaiWl1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ab671-8f45-465c-c833-08d91562572e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 16:23:56.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yvzhr+rUpVooyH00nmEB9BABEKCUFNnp39wi8gaxoL7JqeJ/ZNxZGxrL/CIrBB8uCh/qSo7aFKjtt+r0JMAGJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Generally the C-state latency is provided by the _CST method or FADT but
some OEM platforms using AMD Picasso, Renoir, Van Gogh, and Cezanne set
the C2 latency greater than C3's which causes the C2 state to be skipped.
That will block the core entering PC6, which prevents s0ix working
properly on Linux systems.

In other operating systems the latency values are not validated and this
does not cause problems by skipping states.

To avoid this issue happening on Linux, detect when latencies are not an
arithmetic progression and sort them.

Link: https://gitlab.freedesktop.org/agd5f/linux/-/commit/026d186e4592c1ee9c1cb44295912d0294508725
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_712174
Suggested-by: Prike Liang <Prike.Liang@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/processor_idle.c | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4e2d76b8b697..c1f52c5ceef2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
+#include <linux/sort.h>
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
@@ -388,10 +389,37 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	return;
 }
 
+static int acpi_cst_latency_cmp(const void *a, const void *b)
+{
+	const struct acpi_processor_cx *x = a, *y = b;
+
+	if (!(x->valid && y->valid))
+		return 0;
+	if (x->latency > y->latency)
+		return 1;
+	if (x->latency < y->latency)
+		return -1;
+	return 0;
+}
+static void acpi_cst_latency_swap(void *a, void *b, int n)
+{
+	struct acpi_processor_cx *x = a, *y = b;
+	u32 tmp;
+
+	if (!(x->valid && y->valid))
+		return;
+	tmp = x->latency;
+	x->latency = y->latency;
+	y->latency = tmp;
+}
+
 static int acpi_processor_power_verify(struct acpi_processor *pr)
 {
 	unsigned int i;
 	unsigned int working = 0;
+	unsigned int last_latency = 0;
+	unsigned int last_type = 0;
+	bool buggy_latency = false;
 
 	pr->power.timer_broadcast_on_state = INT_MAX;
 
@@ -415,12 +443,24 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 		}
 		if (!cx->valid)
 			continue;
+		if (cx->type >= last_type && cx->latency > last_latency)
+			buggy_latency = true;
+		last_latency = cx->latency;
+		last_type = cx->type;
 
 		lapic_timer_check_state(i, pr, cx);
 		tsc_check_state(cx->type);
 		working++;
 	}
 
+	if (buggy_latency) {
+		pr_notice("FW issue: working around C-state latencies out of order\n");
+		sort(&pr->power.states[1], max_cstate,
+		     sizeof(struct acpi_processor_cx),
+		     acpi_cst_latency_cmp,
+		     acpi_cst_latency_swap);
+	}
+
 	lapic_timer_propagate_broadcast(pr);
 
 	return (working);
-- 
2.25.1

