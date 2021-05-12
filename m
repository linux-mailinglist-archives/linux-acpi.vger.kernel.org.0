Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C637EF89
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 01:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbhELXNW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 19:13:22 -0400
Received: from mail-sn1anam02on2053.outbound.protection.outlook.com ([40.107.96.53]:60098
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1443141AbhELWQk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 May 2021 18:16:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/bVneCSMmDudH/dsXbS6HjybMyyF7d5ORjtm1RqUOZNOZTWmRQANlGM86j3e2c94w3o0R3sccudqA/944NpIBqKsAfRw2GAHhNuzFfGzIq9pHow9kluzWimdu70uuP5mecIu+LKDm+BdQ64cJiG/fVv6wYFoPzf3IM2U44k+rsF7jxxM2DoBor2pPzBrVodXXm/Jm31YqWrmjhjKf++PYee5PPggPZ+RYtYOtwvS/t+hUhVwrCOUi36ELVESVi9PNXCjYVKaY53mGjo2BCggvr6f5bsui7MUeMGjUItec4TAfHMTA6GLYieu24Y0CmKBczvYbNPWY/ufJsqERYD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHGwal23M2Akhd+VIY6eFT58qLrDXf2K/w3/Cco05d4=;
 b=HtVpfFi8qJn6DxhwuZMVUGQeu7/blix/Ru5T3GCVN933KZeNj77ttzD/jEFdaJgaB1Tkzj+VNBWESrkpGZwWwSWKrzFHRR3HUeb+n8+7NAeWX6gKPagFwRQ4xbG/xE/ozyUj7/hP0Ho+QR8o3xdMhxmgzZYVJf1Od0Oj6UYrgjf42mrQc+39d7Tn/l9hSyA8aKS1/HFBdQLMwyp/EJTsVUILA7nLeWbDbo7slk3ZyIldQe323OfpycwU7fqZ+2nIa49W83pb+hf4aPFFf0RjmTnFUQuholXaBxruScAMLXOc6bju3U8fJdCTQsOujSZ9RyLmOhj7d9Kz5xsxASX7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHGwal23M2Akhd+VIY6eFT58qLrDXf2K/w3/Cco05d4=;
 b=wuYzyaFHIlbk7uDIUE3c3VvNndcmORE3Yuy5/qBMxhvfYOacbnWV67tU9nRN/i6Rk8cGJt8OjvMM0l6MqOYPomTJQxLUfEu1wqmd6V6+LKuAGGPBNZdpYmi2NdUt096qh43Oj0rKWKpnPSzQwe+87hKtIs3hm7FNWsrsVUgJkNg=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB2774.namprd12.prod.outlook.com (2603:10b6:a03:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 22:15:18 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 22:15:18 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3] ACPI / idle: override c-state latency when not in conformance with s0ix
Date:   Wed, 12 May 2021 17:15:14 -0500
Message-Id: <20210512221514.32038-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SA9PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:806:27::29) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by SA9PR13CA0144.namprd13.prod.outlook.com (2603:10b6:806:27::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Wed, 12 May 2021 22:15:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89c7f79f-fe9c-42da-4e2a-08d915936d13
X-MS-TrafficTypeDiagnostic: BYAPR12MB2774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2774E910DD05CE8447FE79B6E2529@BYAPR12MB2774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wg47XJ/OA5LyL0MnSNmwr4vVqLHRGFr6b8k3yKVaCeXgcOTM+gthYMrhepIO0sP6SJQx3jnksAROLg8yV9Jcr0JFeMb+0uKL5cK1F5nuLqLlvGXpH/WFQltX+QnwBHaaaS6BPUlMQXyiuXv90xAtfPzOsjrwPQ0sDlV58f7XM+TZPnhJr6GXhS/j1dytuf5BPcvWYVuQI+3YY4mlgdIlp2KLDpV0ePB7pNS/zIz6qHqO6cq8oIPDea+Es6YQnxboVnd9IgwyjAWF7Soi/g3dphBt4yo9NrJ1BaMqFIJGqP469oCGzYXsuUVfPEufQ73ROzPN/WiHmRHN2dYHDusGglsH6nG0Yr85MjEyn/9y4U7BAOWRrCDX7w3A6JtCgZ/7/0RzIv2CjHICNGRR1rOnpP15klZur1Xk38cuEr6N+xw471eKv9EawBVq9lsDonXsZqvkOPzBROvg8QIkbyVfWrP2tR4F6G7TH5sO7pxVY2Ljq80A/5drEuPewpejTxggzA5/uau6FBU01cyO/VzDGDHVcY3zIHOJ53TsiJ+isVijvHFiMLzrJgyEDPDWewMRi4o9YpwRA0MDXobztbfukpILxv8j0uLaK+u+BWgJ9Bfj46kl3NINNMBzjdw9FqF4n1Gw3yuquqW9QPn08xDsKs9Wv1MP5oHdzCm8kESDcFQl0XdhfBDDw1hN1YkSIkHbz50mJhqH1vxMyOh8/yupPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(2616005)(4326008)(956004)(44832011)(66556008)(66476007)(38100700002)(8676002)(2906002)(38350700002)(86362001)(8936002)(83380400001)(26005)(7696005)(52116002)(5660300002)(186003)(16526019)(966005)(66946007)(6486002)(478600001)(36756003)(316002)(110136005)(54906003)(6666004)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ShKA+bZdcwXKZ+u1znJEQpaPXP3P46vdS3TmgoCaMhc0Dk888yE1ynPsLRbD?=
 =?us-ascii?Q?eXxBfLkIC9OL6Uw4DoRiwTLPDqEPROiCVSZ6PfF/7eU8kK7Q4pLekL1G9Ott?=
 =?us-ascii?Q?addWvqAJCWND1Whp3V0EgYg4umxsdz52jjW6G8pqwOH3E3NGf2um17od6oso?=
 =?us-ascii?Q?vaIc2qC3Ccsn9RzFNzcajHEhCqpGvKIprm9OmTo8ZK/AOua9Zv8OnA2lu/mF?=
 =?us-ascii?Q?3fR7fAnzbGdatelEvL503W9AbmSODkyc9VOcA1mRPBuNYdjs08oz16GE0Vzc?=
 =?us-ascii?Q?advJim9KVVo6qV/yxq46VBdk0DjdAkTSEhwHC4mkRrSqlh3ikdQJLrf1sx5p?=
 =?us-ascii?Q?oHEIFkRXlOBwv+K2nTd1oJoQQIMX0r2xYPFaKVq5cb8Tw4T+SsSLz6QHo7fP?=
 =?us-ascii?Q?6wMInc8WxoOo4Kq/+rUEyB9KJyHAYi6iZkz5qMv+En91AdRLolkxwL9bl8d0?=
 =?us-ascii?Q?dgC4MNf/lQZZUw9R6tXx1g67tLYvXAy3P32dHf2Ve++/fS4thv4oFNjwm/UU?=
 =?us-ascii?Q?cjjfh99WCd+/kzEEsI48pOqjLfghFkaUio19WgEz3H/l5hus6Sl0LbKtR2yh?=
 =?us-ascii?Q?b7MD4FAQ691va/wldpnS2wQFfQAmVi94kPV28Bgxi74M6NLhuI1jXDlwjgrG?=
 =?us-ascii?Q?tE7XILsA+VcOlOjWb6pQkFQcVsHYSds2pYFVEqMkUQVJHgUUX7zQpHw4USPw?=
 =?us-ascii?Q?gt7JAf1ZMR67QfQfcHJDQia2J4724K1Az1Pccu0TwzcN5/kxxQbM1oNKUi2J?=
 =?us-ascii?Q?p6w13+AbSJHG9V5OuLALAmNZLWZ3RpeB6sDF95NBHFU+qPeyuPFx7ywhlLot?=
 =?us-ascii?Q?CNAzrkBK7OFGykHkqd8e2VegmIPVYG0vrrQRNkaztgnkxUsiIRctd77UJtcb?=
 =?us-ascii?Q?vl8KUKbCzAIDDYtyhHnSAxcWR7xhbMoYqGVsUIvdkuwKVJi1pBU7kok1DBYx?=
 =?us-ascii?Q?X2kuqMb8tLwc8F+FgwUaWlExZOXdepXkbA9DvgsjK10udchnLPrbkmtLZ3CC?=
 =?us-ascii?Q?DofVKt4rsiaJXZgnCNRBM3cTsmopAGhMSH/fgVfVEAKkAsxt3VuHV5zMyWmn?=
 =?us-ascii?Q?AmiaEadcgsaeIMu/IjhtOlKSY3gAwaOuLqEv0IGdPtioNSWKpzlwr+h0AVkS?=
 =?us-ascii?Q?KNyrtc07fp5/QR02LFcjHEIVnAFVCBK1Y8xbbJ2AR5Hv2/vGecYnu/bnLuJn?=
 =?us-ascii?Q?TRDEG0WAVDLvmg7A6z/Berbd45+8Eqr4oU7Fz0Bnh3W+ZalY+1u3RjnFKd6i?=
 =?us-ascii?Q?x+hPdbq5yCoaldYcjr2py3p78MOxvPVgmZmAVpL2LnmDDpK5KjdkaeD4K9X2?=
 =?us-ascii?Q?QJ58UwLPCjE0B5lnnfejXSv5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c7f79f-fe9c-42da-4e2a-08d915936d13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 22:15:18.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E60NYR7hQncaeuP5sNbKDOGwBoFK3GPVOwT5yLtn94cOk5/UHSlhOaQTjiNEVz1MYROSAwiwYcbPJgus6RYnpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2774
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
index 4e2d76b8b697..6790df5a2462 100644
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
+		if (cx->type >= last_type && cx->latency < last_latency)
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

