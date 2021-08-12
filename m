Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06553E9DDD
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 07:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhHLFS0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 01:18:26 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:7425
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233593AbhHLFS0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 01:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjQkojgs+st/kmKhAcYiKvGgqPFgZV3Nv3NKl34lhRo4w6BVK6uhcl7Ie+RS8G23xbYoEsmLrPEAyRdM0ljxiJzu1KJKhrW+AB8EeUeXovbJp8vS8MFDrG4BTmgDkfa0J2+ISBI6WvwEnta344QbxK4Wa80RWfI8GLvjCMGlKp088L1mgZJ+nS+N525ac7+PPGMh5XkskNKSpZyPu+Fn/BJREAyFHJq9Cyew5Aa9TQMJnYzQYG/ZeK7w2QEcdHkKCn26vsP30VboHOwpVVtj/QGitKEd6IrmLdZ6havUBNNVqkIkeY+VygymN1L8mDvUlvUx723ZEYKV/pC5RHlPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJQ6yhOXxbkobBSK2JiQrkC8m+5RXDQbZPAnM0+6n2I=;
 b=SoPkZRdF1FfO9++tSl+b89f/dzqEvcqUGlPSG5DAYieZfQmB8IZ+DxvZSUsqtIBHlAWqeJDt8oK6f+v/53jYlmUxXqDDkKKaATELPTdPLklzHv3ifEFzr3BPyW+Zrn7kPX4pFynai9OBDIn40D5D/4o5yAbyeT3i6/JYknpDYuez/ZZFQ2cIRI2ZGDOl34U8WpTxyRktG5W4bxuKlVlpQ1VUrszIQtcvcUq1NrmqceC7ekfHPAs1TSQJMYQbZnkTuxLpK4QO1IH0olSNtr/Dqpp0Ap9kU51ScTo6ClBFVhuXGsMSUyqgS72HPaiSrrKWSeuShPb35YyVWps9uBWi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJQ6yhOXxbkobBSK2JiQrkC8m+5RXDQbZPAnM0+6n2I=;
 b=gKeSynvMAz+ozFsFi79V1chZVbMKZ9wsY53OWer21vwa+KBKJtmqQtUXX1r1B0JMCIrC5spFbBaaM1FOJ6RS/kZgemk0eKVBAmQk2iyVVIlOv1FfDoAqbshyuoqLHiRE574gEVXEsvIHtWRYqadXwAImthjtwNheuOTIvs1yQtQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Thu, 12 Aug
 2021 05:17:59 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36%7]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 05:17:59 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), linux-acpi@vger.kernel.org (open list:ACPI),
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA))
Subject: [PATCH] x86/acpi: Don't add CPUs that are not online capable
Date:   Thu, 12 Aug 2021 00:16:56 -0500
Message-Id: <20210812051657.28605-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0053.namprd05.prod.outlook.com
 (2603:10b6:803:41::30) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN4PR0501CA0053.namprd05.prod.outlook.com (2603:10b6:803:41::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 05:17:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b0f44d-d9ac-441b-e513-08d95d508caf
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB46718E33B910AAEA8EB5262CE2F99@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvdSnlbQWJ6jzz/7WUssea61g45Jysd6Zx2LPKLawxm+3bjdgzYGEs52DFb7Qyxb0IT115Wmin4m6TMCE5S1UeaqXaZbrV5IxT6+JXKvHjzNw/i4p7NaZXVvu4UPSu5aqw9RSEpHd+TKkegzdnffnPQM6uxxTx+qc7djKyBKxd+Ho+vYvvwt4apVmeWpOedQ/cBoxsZBE8hzzSBjlZvgZMuIuapvyx0QNCyNVXzisL5wyxSU15spYz5b2Ji9iU49FkJkAuCFyWNeWlSeeSRHFHovJF+B3fC2QVnvzVh3L5AR5oxkFLKsWWe4d2YaDkjTQkwkQcI5ye9we5o7xksH9G92trU0gDi43Ic3xe4jNB3DOjSv2E/Aszyf4+x/O568RNoFHT565ZcP+xR1f52MBhIW67qbfr1gH6jghQGlwgHHg1kl9zirCt+ximuUsnPgaCE3cN6g8vo6kGUySM/fIN/YkiNDj6YkDWdMPpSiLnPchq527z4W4mCYJ8YXbNGsbnukr83rmq2FXELwgytmDrnYh6va/tnS8VdrkfXRo8s194hmMwM1kYo6PKctmmrSiSR/xfhSgXe2PsIjwkgX/vB8wMfGYpOMzAsClbZJAs5UoNCFgurK5rDyN/3kVQTklzNFsaSbg6NNN0c1nZtTdKV77BjovzCp5BTvHuApJdDvDP2xyiC6oO6zeBkHRiD/XbcWGUkUxcSFtl5TwrvQSN45l4T6DNXsKljUp7N51ifWXvUM+n2DyLBkGrtRYoZpxfoBG6sAURjdJEMxzUSKWCudxDuGk5pbyFrw7eMJbwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(86362001)(8936002)(83380400001)(316002)(478600001)(36756003)(66556008)(966005)(66476007)(7696005)(44832011)(38100700002)(38350700002)(66946007)(5660300002)(52116002)(7416002)(2906002)(2616005)(956004)(186003)(4326008)(110136005)(26005)(8676002)(54906003)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QAyVv+yKh7pIhDFETsb1YNAt8/rbbHQ8Mm6/L6IMsMtOXRtJAZ3yXfIXjnjZ?=
 =?us-ascii?Q?GW4PzIBIe1xlQbogfbaIG2Mt4mcrwn0rhIqkrDmZKJzWNfcA0jjLCe+qHaA7?=
 =?us-ascii?Q?NJRqnfUGsBaH5x3lER57ccW6edf246M1/S3HNG7foKXKKufBOK6768C/wKvk?=
 =?us-ascii?Q?0Hn86yKqzX1rLsSgroSh4uMIw7kRd7JdA6xE9SFcevislZaIQYSTqgXMAI/A?=
 =?us-ascii?Q?gGM16DZweU2mwZfuGihhVassnYmvbltCnII37/4VconrEpsYtG8DW5GgzJoj?=
 =?us-ascii?Q?6/o+zOW8Pu6b1KKyaT+ev/df0npi7x1zaNkEooB/E9WN5A2+OpYTR36YbVuf?=
 =?us-ascii?Q?RQq94YjM9bIgCuIGEXpubkCiR9NmbbtxL8s+aM4rKSCctXUCqoL4CU2tD6uK?=
 =?us-ascii?Q?rCpX+XdDBIFigNNwr9TL6WEfK6IZp8soJL6h14aEJaKvcO8FCAYS0dqLS5Pm?=
 =?us-ascii?Q?N4sh1WR7l0/MZzknZv6otBjb0c8s3VJCGneyWEPhGp2mLVHshZXK69awpj4u?=
 =?us-ascii?Q?SrlBMZPDudqpSkwcZQVAPqHdfXCZnrtCD+ErORqpwN2a7h0CaZ3S/Fn2tkCu?=
 =?us-ascii?Q?FKbbU/svAMYGle+3ss7m4czCBqcY3u3jrN+xvrK17nP4Zt/WagugGJvZGs9x?=
 =?us-ascii?Q?+TrYQ8w+MJhCVI4ncIZmYEDJD3UlIRmAog3kHga+ajY/v2EuxeTduwR2oHoO?=
 =?us-ascii?Q?Od0Q2gksXLIDhPEIubr9bo0F5ePDSLfHiBYyJPJN0QHDK1rAtfPW6+fsaQhs?=
 =?us-ascii?Q?X3/XYzdx/oONu+CWCvvhytluN8RXgEhfmllYxkdpbCtOXht/A3nYbNAi3o/X?=
 =?us-ascii?Q?JJHgaDpPRd1sSqh8Wcg/N+RFYVkbXEVw2dJSze6GOuITqJPIfjFOmyEN2+KT?=
 =?us-ascii?Q?nkjuQnRRgQl9iTfLkxsYgjpJRZnmMwbAXrh7traxQQ2/J9cblB9zWusxqPHA?=
 =?us-ascii?Q?9Cd7ostiaEbGS8RsrLgD8VY5ZOvtPQciB+2ZfIcdF22burAtrmPJO1we4Gt3?=
 =?us-ascii?Q?oV0uMa4i33o0Gyi7H5vbvNmv9+r7PGEuc5Oec0SS6BZ3Rh/P2r8EhImk1wN1?=
 =?us-ascii?Q?fmzqtNgpeS1k6OBZR/TY53XijkAzVTjxZT65MEFfwbIe+Ashps9KzuY9RRtW?=
 =?us-ascii?Q?qjeeq5JCgD9EDcjeSur1lmAK+nOC2RU+crjEC/FRRNKbZoRKd7mgFmpA8ivi?=
 =?us-ascii?Q?0USOvlIjpg3YyUjH0TcvydRMGphVrVRGvaZFtjn2sIcOlkxVQVHbr7D6FPv+?=
 =?us-ascii?Q?SeLe+3z6WoOUl4crt8YhW2fuf52IBhUeU2qZ4dxYJcyOe/tf8yvr9eZWz4my?=
 =?us-ascii?Q?M+jFo7kGhgCNHwpQb+S/jiCU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b0f44d-d9ac-441b-e513-08d95d508caf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 05:17:59.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqitZgf0I9nADpy8bdyQ+VNmsBymOTw8CeSwfxA1JAfAuGAnREGSNXSvjE5tcg9bQ8Fgyuu9J/koh9Wpn0XBdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A number of systems are showing "hotplug capable" CPUs when they
are not really hotpluggable.  This is because the MADT has extra
CPU entries to support different CPUs that may be inserted into
the socket with different numbers of cores.

The ACPI spec is clear that the Online Capable bit in the
MADT should be used to determine whether or not a CPU is hotplug
capable when the enabled bit is not set.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/boot.c | 6 ++++++
 include/acpi/actbl2.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e55e0c1fad8c..eeb10b27d6de 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -239,6 +239,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 	if (processor->id == 0xff)
 		return 0;
 
+	/* don't register processors that can not be onlined */
+	if (!(processor->lapic_flags & ACPI_MADT_ENABLED)) {
+		if (!(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+			return 0;
+	}
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2069ac38a4e2..fae45e383987 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -808,6 +808,7 @@ struct acpi_madt_multiproc_wakeup_mailbox {
 /* MADT Local APIC flags */
 
 #define ACPI_MADT_ENABLED           (1)	/* 00: Processor is usable if set */
+#define ACPI_MADT_ONLINE_CAPABLE    (2)	/* 01: System HW supports enabling processor at runtime */
 
 /* MADT MPS INTI flags (inti_flags) */
 
-- 
2.25.1

