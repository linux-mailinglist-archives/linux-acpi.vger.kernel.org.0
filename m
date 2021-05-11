Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F30379D28
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 04:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhEKCwE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 22:52:04 -0400
Received: from mail-bn1nam07on2065.outbound.protection.outlook.com ([40.107.212.65]:4561
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhEKCwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 22:52:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD+am7zIAvDNmgmjZ9m2OfVoBfo7Q8yt6uMRXU7Fn0lIL2S/nDELl5JkXljKKRFWZ1IyCGda0uihdKJUmzw7q6indPrrmO+IAHd+TVonqYOyH3Ak8QNbUAqzZGVhlRdZuzo4T1pfPnJPSKH3BRTxcvakEox2DQp5OtS7FICbDDXy220kVpL59RIE3ce0LvDq0kxQWJrd8Pj9HhQeMTHDpup4N1jBZ/8tImT+4kf7dGzcX8ee4JWR5y0XP+TOIJC79rIiDGvfE3H7fPqY/labW2lq3ReaOaZBWneuoJD4mTEEtYRUDT8QU70zZ8nO8N+LfKRARDvHtbPW36GOK3FalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UVgncnA2m11dhjevGInWLk4uQyffQV2AupqfX0Vk9U=;
 b=DgMUYvXY3l5xpAfx+0gEEv2Tp0Ou9J1iUBBrviOtlH9JkPS1Om3FvAlF1aVft4nE/m1RlT3rF2yU87AkYPfloseenO1Ggr5VjBiOROrH8blyT5mNe2Xon33bhCdcE0S5JyUKIk6Qx5/vfPrsLrhBivBr6sGK12u5PzWSYs77aj2Pdv4Ki6HyXntImBUitdmiyT9aM5jJ1bSa89YW5tth1OQo1bhqfj4Zv/ru+PoMNwsjc7/MjKTsVJTacwb4nrMS+u+QiN1wJn7FZU0sEAiciY9vy46bTzzKuDoYwkLTg6eG+/Ym4YPv2M+lek00vnDLmFn4m0Mg0iZULLeOohHZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UVgncnA2m11dhjevGInWLk4uQyffQV2AupqfX0Vk9U=;
 b=n99lX9VFHlWpr17iWBsx5+xJxSsSH1paxcAXg5PyPb8+z3FRc8czeopbeamRkK7b2K713g1zHZBSJssF1ZNN0+7ZcsDco+0ZywKqYnH/N0sY9pi8RJxzstunvtxedj+8dQs0UduNyAXWoZFjiKKSJiMgMms6jd91GgIE+WBjS6Y=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB2648.namprd12.prod.outlook.com (2603:10b6:a03:69::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Tue, 11 May
 2021 02:50:55 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 02:50:55 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] ACPI / idle: override c-state latency when not in conformance with s0ix
Date:   Mon, 10 May 2021 21:50:24 -0500
Message-Id: <20210511025024.10083-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:806:6f::15) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.77.11) by SA0PR12CA0010.namprd12.prod.outlook.com (2603:10b6:806:6f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 02:50:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 961a400b-63ae-4df4-e23a-08d91427990d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2648B008C75D4D8C48CF011BE2539@BYAPR12MB2648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzzMwt3bq71tIuSH6k0OySVjO17yDls5OPzAJQ6A94F2XypUHq6ra1cy7yzZaXZMWsXkBC8/0EtQqnJoXj9HRKtBBjwCAtiXOMY8xzN0nQBNUhiLyW2XbFcrqJuNJaivQItaD8s1ui741Qg83iK2fX55/wKgGepDvNX37qpXASvfuss+MSxust1MSxX1jGrtYd2zcdWy5u4RdK7YODYV+hbO4KoKL7WcdQgmtxRhT/lPv7e3YLewXTF17Mk33fMPSh6bWTBqkooO4AKFVrW6zVYLBBJK7AkSh5/5bCKQZ7qPUCOqysCjhZrOnlHebvvlMA7OZvZ+9UYgccRzt8DGznDgC7QgEBXyv6TDyaqSfaTD1RaQ8di75FuMWBJFRhLBepCSyXkIZj1kZtJu0B1TfBR3wVHLBxGK0hItweyUnPcebu8B+x596apdPJWiwux4puoUkOsLQoyx3GZsyWoFUKt5tp3l5UwxaeMpFXLC59wXFk1L4gPR8LqXbftIP93nEtBZjW4RGEVQBaUDoVJIz0wRHT0vnc4qUxnC/7Xn9DhjkhvFAfRSRzFySFl68g3diEAal/G9sdgFKJ2ONgPorc21qsVasgvvakljptu/6jVlfYl1kN7FEnG72nJHJfSPcvF28uPHWiZZLqxsX5yjBLrrcee50i5gPy5AWFZ/v3GR438G27+nnvF/DJCZaKPSU+TOF+xqDx4pzmkOHHU15w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(2616005)(6486002)(66476007)(66556008)(16526019)(478600001)(36756003)(83380400001)(44832011)(5660300002)(66946007)(4326008)(52116002)(54906003)(86362001)(966005)(186003)(956004)(8936002)(38100700002)(6666004)(38350700002)(8676002)(316002)(1076003)(2906002)(7696005)(26005)(110136005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?thvb+rEXM8391iTV6nlr5Q/TG6t2j87q05BhG0ILod38z+09d4ETHVnhHGQ0?=
 =?us-ascii?Q?/82LfZyIvHw7CKxDUYjn4MZgAOa6DKD4Xe0+gI5Z0arEuZOtMKSPSi512wgh?=
 =?us-ascii?Q?tYsfSI/GVYm/kYtQpHLUsJ2iINecf/9VfwNjA/E0RlNOqh5c0K3WHoTGHOJp?=
 =?us-ascii?Q?WpjVNkqzGJApINLtd9pc54hc7djDDRH8JU+rMGt35sZYjZLzMF0I53yrw/8d?=
 =?us-ascii?Q?miwdg7MRt5rhqGEBAW6yZzPIgpiof0q8k5kY99F4SWSn1hqdFar53ndd/2mB?=
 =?us-ascii?Q?2aciHAXpzJmzeW6antQJy+iYjMhpp4+koPhQgQwrWn7uLlvEgzXPOC5m4ptB?=
 =?us-ascii?Q?KeJEsx5ypkdr8URBDJsHXKeb2n1IA7/DHXnxu7Vq7EwARYNM1x+GKg+0scog?=
 =?us-ascii?Q?d9hH4Buqboip+otboLa6cLbaiMKQrdt22TPSNQRQtswDxCjP3FCsUkvdVQ8H?=
 =?us-ascii?Q?pJO5EbLcRIJUCxvmrEihvAgdDYenSdyG1ya0rcNT4POHK0UXRYzq9rQEn93K?=
 =?us-ascii?Q?x1MppdLI/ybsrpSsiTBwX4CJwovzhG+HpT82IYPHSMnpQ+KOLS4JFmzzoM78?=
 =?us-ascii?Q?Hamv43JJp9X7BSfmiwOc4IwNLdzc1far8e0p4Kmk69vFgwKu2HOZzcT0fTXz?=
 =?us-ascii?Q?egZ69LYn2ZHXvOD78CIhl+c9TadM72sNEEHxWsXaNGj/dbwNjFHKWkxlBtOr?=
 =?us-ascii?Q?M8HjApm2X3WfK0p4aRAteTemcEzPqI52qmFQuysBCQg4OTZoUiGRdpyZTodT?=
 =?us-ascii?Q?VIE7QguE4yU5obngwyxIJLRq0Y+WKYnIo8hQ1j9fZy/DXidrxPsnat5b5LS3?=
 =?us-ascii?Q?gNbGFt8rMSvz2o2xsFzFMcgL1OgwqbWm9CCVpWAwROI+83bFu/rWl90ze7iY?=
 =?us-ascii?Q?ispbzPcKLWz8lSXZjYhbawNjvFTvDrw9g3rpnunT/MiVkELaspziMGOzr1Mc?=
 =?us-ascii?Q?Ews3XNcMl5PRQRq9tWfH9MFfcE1bMwOECsFiOsjS9q/LkpdtfPwB/HnlnzUu?=
 =?us-ascii?Q?26S9Fu6ngc074VLzu1uxOn4mg/FYEoc12kycFWS17wn+mnZ1TAxnvR5ZrfCo?=
 =?us-ascii?Q?Vzfw3cZZqS4jxPgaV4n08Yo2BaYSmBr5mbHwtcc3Bj5wbbPHDJYrw5nSN/MF?=
 =?us-ascii?Q?fdix+zFR5htLQp0wJdgLjz14n9OM14UfpkR1zxvxAfCg9O6+fCqC+EaFdidE?=
 =?us-ascii?Q?VmJFI0dQZui6+wrsF2SkDZr+8P3eWOEkpkEb56vkX2nfQrGIP485J6xgXqWb?=
 =?us-ascii?Q?zFSvZr4vyDDbmZvs1T2AxLfS5tns/GCtEtzJgJrirzkuxuYJuzjQlR0ElgDU?=
 =?us-ascii?Q?Y1RUaC9qigdYD/TsmlERs3q3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961a400b-63ae-4df4-e23a-08d91427990d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 02:50:55.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjA5FansLbUf2Ht99gn0kQ8TOvbXTpzC/KTh7yAcvn/hX906kAXBbuCmfR9JDt2418WNiyfKteJVerCGy+HUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2648
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Generally the C-state latency is provided by the _CST method or FADT but
some OEM platforms using AMD Picasso, Renoir, and Cezanne set the C2
latency greater than C3's which causes the C2 state to be skipped.
That will block the core entering PC6, which prevents s0ix working
properly on Linux systems.

In other operating systems the latency values are not validated and this
does not cause problems by skipping states.

Link: https://gitlab.freedesktop.org/agd5f/linux/-/commit/026d186e4592c1ee9c1cb44295912d0294508725
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_712174
Suggested-by: Prike Liang <Prike.Liang@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/processor_idle.c | 68 +++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4e2d76b8b697..9d468e0e0cd7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -30,6 +30,7 @@
 #ifdef CONFIG_X86
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
@@ -203,8 +204,73 @@ static void tsc_check_state(int state)
 			mark_tsc_unstable("TSC halts in idle");
 	}
 }
+
+struct cpu_cstate_quirks {
+	int latency2;
+	int latency3;
+};
+
+static struct cpu_cstate_quirks amd_cst_bug = {
+	.latency2 = 18,
+	.latency3 = 350,
+};
+
+static const struct x86_cpu_id cpu_match[] = {
+	/* AMD Picasso */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x18, &amd_cst_bug),
+	/* AMD Renoir */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x60, &amd_cst_bug),
+	/* AMD Van Gogh */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x90, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x91, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x92, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x93, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x94, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x95, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x96, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x97, &amd_cst_bug),
+	/* AMD Cezanne */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x50, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x51, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x52, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x53, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x54, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x55, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x56, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x57, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x58, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x59, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5A, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5B, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5C, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5D, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5E, &amd_cst_bug),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5F, &amd_cst_bug),
+	{},
+};
+
+static void acpi_processor_check_quirks(struct acpi_processor *pr)
+{
+	const struct x86_cpu_id *id = x86_match_cpu(cpu_match);
+	struct cpu_cstate_quirks *quirks;
+
+	if (!id)
+		return;
+	quirks = (struct cpu_cstate_quirks *)id->driver_data;
+	/* correct some OEM BIOS that mistakingly set C2 latency higher
+	 * than C3 making C2 seem like an invalid state
+	 */
+	if (max_cstate >= 3 &&
+	    pr->power.states[2].latency >= pr->power.states[3].latency &&
+	    quirks->latency2 && quirks->latency3) {
+		pr->power.states[2].latency = quirks->latency2;
+		pr->power.states[3].latency = quirks->latency3;
+		pr_notice("overriding known buggy C2 latency\n");
+	}
+}
 #else
 static void tsc_check_state(int state) { return; }
+static void acpi_processor_check_quirks(struct acpi_processor *pr) { return; }
 #endif
 
 static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
@@ -447,6 +513,8 @@ static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 
 	acpi_processor_get_power_info_default(pr);
 
+	acpi_processor_check_quirks(pr);
+
 	pr->power.count = acpi_processor_power_verify(pr);
 
 	/*
-- 
2.25.1

