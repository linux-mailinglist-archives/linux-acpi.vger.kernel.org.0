Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569F63EB9E5
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Aug 2021 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhHMQTe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Aug 2021 12:19:34 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:45920
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhHMQT1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Aug 2021 12:19:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9d3K+8bvqKoIkbB+I8dAVHaEUayuilY3fnzYZrDACpmZgKSkbUKKGLcnpaXlc67bmo/neXqbm9rx5qdqC9V7hmceh/So5xGxpM8rypXAfZxdMT4Gad8RxAQWEy6AeMj9d/aPCQHjqAyuiaZGfzJ9gK3OhB5dpI3iMZGzX4YNWYZ7+HJFYHNktZq3oDQNDcZjfo4nBbH3O80hiLDHwLnVuzGE07JDYGZKtF+fKKmC7yfQHYL4xecxRSSlvg65P7YVC3yrpNy16hVkpirQHbsgxEwvodaDi3/s6BbYX0WqQZs7saj4klIGObWk5zD1K4ODknO9U0DmPqzTNTcXMD04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qetdpuan4maFT2TZnKtfwxRHJlO1nP3L1dO3fdAwtgM=;
 b=VpID+HAwEm4xjNvVcuCJsQSkkQREiiN2Uherr98rOxfceM6ASh1Qx3sgHrts1+5IC9oq3GNvotYG4H8tFlHifHS5zSRxbog1zEN6JOjg9VUcTf84Q2pLp90y31Hesalc3OgO+sqn2uwR/mNzhFbgPE/L8cJNJxDkmkJ+jCiRvAdZJQUwgx9FgravsipiUOJ77mVDGJM1asni68jdDWoAP2fLwHsKqeJg1YWff9WwAI2P/BxGTg6tWPFOwWWm32q4W7athK6QqB5QilZY3bMl+UjWrPqhC6O1xZHs7Sp871FBFtTMcKXXSDng7G4kenOnEGRCi15rpFAWiI9vd7pWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qetdpuan4maFT2TZnKtfwxRHJlO1nP3L1dO3fdAwtgM=;
 b=EAjgDOdAV/VwlgZwt4ds9/RUcMza0RgU4VlT5+udxMQrbHk2vBovvLGFUGK+r+mb9nizlWHQ618c0nwXyiN/s017HDeCcL1Y7QCFo771GG89UVy8DPolIxzRe0FfedQ4aQ8mMEJtYbeEaAqglq4H1ShxWjOC0CDGOCzDrmWqSz8=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2832.namprd12.prod.outlook.com (2603:10b6:805:eb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 13 Aug
 2021 16:18:58 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 16:18:58 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Deucher <Alexander.Deucher@amd.com>,
        Ray Huang <Ray.Huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
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
Subject: [PATCH v2] x86/acpi: Don't add CPUs that are not online capable
Date:   Fri, 13 Aug 2021 11:18:42 -0500
Message-Id: <20210813161842.222414-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41)
 To SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.77.11) by SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 16:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9144290-eab9-40fc-fe8b-08d95e760d9d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2832:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28326A71E172A8E0BE7142A9E2FA9@SN6PR12MB2832.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqdc+DN5eA6m321YnlmOjvI8DvGEY/wq1+YBvrxkBqlKMOh56qTgPt8vWLB22O30CSvn4hXoL2qxQlauqp7LRaXXJ2gzjSIt6rJh5NrW0hvzl+3DfO8XLHVbfS9c6uIy7cEcl6nyQKS5NWd4seQuttUDE+uaBmLr/1+RRsClcqyyt7Sorr8UOIFSMLyxjYnXd9p6ObHoyHGZ9ci6MI8kSADS+vbAeRYnevZgZw9OgM8QlQ3UaaxAzixYbtIyQxivptqdMTpFlnwM05THXGjamg9PjHcSy6abvzZYg/Y1HSMJ+X/2YDyAtz1I58asLD0BCUn8v1uVHarTwzB2AV4GnOgBwwHhbDvkDOHRpB1ZPxak3k7kZ7Z4XpbjuTEhX4LGbvf+Lpzu841fiIwXi3ktGRUevnKAp35vc9g30t7xZ4jdjvLBMDwGlGPdDoLCSTp8OfmFXmcs3toapKPytdmEJ+eCYR7E5FcZpPNEp4giMzCXk8RziuwKkze01aGSzk8MS3NKZFTnY4CsqKEcU8N0dG/yVE1yEFBTKEASkGgOBxHZ+AVh6I5ymzOE6dsAw2JBJTLy/Deon0aLlmiA3zytQhUjwIomTcZ7jQWheRMsTZg6JDjOcpmjUS97gQLlwRyWgmeNXo9wTjj+3xHwzrQavWxKhsmhGv8RHOBCEqhH2yAgKr7AQAOtggfa+tNsfuiqbxMPGP3DUt9MjWuBzb2EFd5debxld2vw+7GaYl/aUMssb2T3wWomgvBHvDhbmXe8gtZIaq5xAs82hqUfzqZKZdBvlZOA4aOnkp2BKqHsb2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(5660300002)(52116002)(7696005)(66946007)(66556008)(66476007)(1076003)(6666004)(2906002)(6486002)(316002)(7416002)(110136005)(54906003)(478600001)(83380400001)(966005)(36756003)(26005)(4326008)(186003)(86362001)(8676002)(38350700002)(38100700002)(956004)(2616005)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rvO0nXsHkDcUP6uA/clXq5ck3YIN3BdurPhNmR+KbUcxLirz7hC3gTE6EbH?=
 =?us-ascii?Q?XMuYjsWqxAEHJWqKBt+rfArkBS2pCXv3EclcJQ1dNOovWgVpb2GM1dl7MHk3?=
 =?us-ascii?Q?yCl+dueSeLDM1Z++JXkiPn23G4DClTGP7+E78LK+736f+/J7obUPecoSPymO?=
 =?us-ascii?Q?qUejujXdG0AFklU4gpJTOttbLzKQOfKDv82zEU2klRKPENsDD8HA0Z6zuMZi?=
 =?us-ascii?Q?XkIKRQjA/OGZMs4XnZI3B9gb/juCW70ZLF0y+WfRZHCHrtGnC6scNci6k2A4?=
 =?us-ascii?Q?ZD6rnC7b6XwsRWmeKUTBqjf2ry9D9Dz1yS944LYZnxvWIZDOEyGwA7HDDueE?=
 =?us-ascii?Q?yBYqz7eDKGgj7E6ZYwsS7obnVEaCe/xK5oYv0wmORkx46+CcIBIwG2JkpOhK?=
 =?us-ascii?Q?6YkS8ho27NzTzJy2cBtYeXXLmtX4eOuVwKIBW7hVuboanAURHxVQFCdQrvbd?=
 =?us-ascii?Q?eVZvazHtGXY2otltFOWvCYYliairGvRJHtvQX+cnqvYXMJM+DTxZ/bkgCVIl?=
 =?us-ascii?Q?rg3pn/WzEXa9kHm4avYapwdahpbe+SwmT+Ai0BqC9b+GUJYs/gHN4KBKm8pb?=
 =?us-ascii?Q?Op7judfQDWDJKq2RX4qRZTIOxRHKPw4d/wJf4Gu0QgMvj1Z4ve6z8lW2GYiE?=
 =?us-ascii?Q?5vFrfq7IPJX4t6yMb+jW8tRm6ZwQWbK443hw7WabD6XV+wfULBU9IDq+dffj?=
 =?us-ascii?Q?XV0weO98S1Xqjl6hEyt5dJK8ZIuv4NjglHASimmeoDWRD8cPTsYGl2aOM5Qs?=
 =?us-ascii?Q?BYX33FQw7WLsLXK3ju9f6P+gQDDe7AIEjFKtB4v6KPLIbc3aYjxPEuZRS8ZW?=
 =?us-ascii?Q?n4adZK569gY4ttIERtCj9CSSq9eUUhVnsU/2KAasylWVaYO+UXyEZboVBG0C?=
 =?us-ascii?Q?IkyAD5QpUu0Nvulnslr5OlECjUipp0e00bCufvcQ7SfD4St4jtuLtAWbLArI?=
 =?us-ascii?Q?CSSbXSBCgrXur0Y9k/q1D2gHUTcJpEJOVtqC2GcIL/E/biZq50NycW9YAILG?=
 =?us-ascii?Q?hu5DtWIfZ30RMVIvwMGXIQqqM2wSqPHUBElgGFiXJTJEVNFBurZHPevMnRNS?=
 =?us-ascii?Q?6Tuz3ETKv+Z90IhDLHKyuNi8m6ig9TfqaEVLRwgMwbpU+6MMnbIewPAayz+y?=
 =?us-ascii?Q?/Axo6i8bfCyev77wYLAYBeaQQtCO+Pfk1KiHaM0T9UdDo9Lov17CbKvONF8l?=
 =?us-ascii?Q?RN1hvd1gjx91iGkJB1FVlHK/gDodMmW0jvCAiLpIYfj7jbVghgyNvXJ+0iQr?=
 =?us-ascii?Q?gOsLf56+XB9J5KzRhPj5mRUe0znHu6m+bHUoTZo3XoFPkwld/YpCf/7MGcFw?=
 =?us-ascii?Q?dH648stRwlpAApVPfuDMee7/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9144290-eab9-40fc-fe8b-08d95e760d9d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 16:18:57.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tAdeXycTsIiegn8RIFM6Ywv7xuBQzpBQQWXwu3XRBdyvJSg0VpOP5Hq+FJpGVl864Kwjaw5NBJ+rllUlUmzyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2832
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A number of systems are showing "hotplug capable" CPUs when they
are not really hotpluggable.  This is because the MADT has extra
CPU entries to support different CPUs that may be inserted into
the socket with different numbers of cores.

Starting with ACPI 6.3 the spec has an Online Capable bit in the
MADT used to determine whether or not a CPU is hotplug capable
when the enabled bit is not set.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/boot.c | 10 ++++++++++
 include/acpi/actbl2.h       |  1 +
 2 files changed, 11 insertions(+)

Changes from v1->v2:
 * Check the revision field in MADT to determine if it matches the
   bump from ACPI 6.3 as suggested by Hanjun Guo
 * Update description

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e55e0c1fad8c..bfa69a5c9c0b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -53,6 +53,8 @@ int acpi_ioapic;
 int acpi_strict;
 int acpi_disable_cmcff;
 
+bool acpi_support_online_capable;
+
 /* ACPI SCI override configuration */
 u8 acpi_sci_flags __initdata;
 u32 acpi_sci_override_gsi __initdata = INVALID_ACPI_IRQ;
@@ -138,6 +140,8 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
+	if (madt->header.revision >= 5)
+		acpi_support_online_capable = true;
 
 	default_acpi_madt_oem_check(madt->header.oem_id,
 				    madt->header.oem_table_id);
@@ -239,6 +243,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 	if (processor->id == 0xff)
 		return 0;
 
+	/* don't register processors that can not be onlined */
+	if (acpi_support_online_capable &&
+	    !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
+	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+		return 0;
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

