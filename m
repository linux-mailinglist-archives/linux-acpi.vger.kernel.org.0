Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116E433DE10
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Mar 2021 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhCPTrf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Mar 2021 15:47:35 -0400
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:25249
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234528AbhCPTrC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Mar 2021 15:47:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf8ncIkhdhYhDnBX/XFfk869ZzqsKBDTHHr+T4vYpZ7uWaK27I0NNgsKM+1Kp6OypFfYZ2Ib4EmxyeH6DcPpKYdTdzG9T6JeoicYmyVgkOpZRev+MzxcmX5ZRkAJII/h291LDfwIeeCpHDrA3HlYVwYLpDYHD5XhT2inQupvxhKZkE+v+F/pbQwg+o+4AeCQL4oYMCoqKGroNb0RsNzKvC77yZT+kedTfRf7vk3bIw/I6NxsQSSjF3J8QaZxpk/vh4nTDAGpDKjP5H4RFGyusWPC6f+TLJh0dCOX9fpCttNtjukjkv7mxNiIAWHoamQD9+KFykQn9MXz9t2/jHzYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALupFmd1yOCHnSAf4AxVDiJqNlftjI/Lsh/6YNPBGCQ=;
 b=eoo+kw9o62jUBXPfZ4ctKbITostyygglJXYksXeqMLQ4LP/bpEtXquGswnLzdZtvZLi0qFz0OfgEIcf1lTCgFmK0s1hXMXSGx39PYnoufLHdzT0BnYBUc7m4uC1L5N6WEklMSr5mnL+sw1w/1zLVcLDsPpwQarsMqSSqJhRlUVJWonaBHE05uet3ACCedwMpRqekmsJRaZa1Pmx2LoC+nc2w35JZu1gNqw3GPk7n0BwNo3A4ObCSjLbZoeaKG2DCNIiwLbN6HXdc9vwNCbXiLrCRxRvdOHO3Dyx0k4ISRR7Kj4GJxh5LF7qr5s+7qW399U9ex8+32esS41TunyLYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALupFmd1yOCHnSAf4AxVDiJqNlftjI/Lsh/6YNPBGCQ=;
 b=h+Frrwesl70I/fhCAWQBwe61hka1kwTr5VFvG2hwa87LburjPcU7Qd19IBMSKScoSgefPWgHPhgU/UIfq5E52T3SrsUKGxQ7oE/0+J8452rD7kocB2wdUCwSg+bqwd/oxvIXRdvg0cNmUGIZspsdVwxdfZEDdf4CDqmVN1WtWn4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3743.namprd12.prod.outlook.com (2603:10b6:208:168::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 19:47:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 19:47:01 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     hdegoede@redhat.com, Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Marcin Bachry <hegel666@gmail.com>
Subject: [PATCH 2/2] platform/x86: force LPS0 functions for AMD
Date:   Tue, 16 Mar 2021 15:46:39 -0400
Message-Id: <20210316194639.287216-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316194639.287216-1-alexander.deucher@amd.com>
References: <20210316194639.287216-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:160::17) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by MN2PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:160::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.9 via Frontend Transport; Tue, 16 Mar 2021 19:47:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0a77144-6fb4-4473-ad26-08d8e8b4441d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3743:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3743A75531C71D6A00D4BEE7F76B9@MN2PR12MB3743.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jzIKnoowcOVKHYRY3MhZCHqiBcSvrmXu90wFOLakyUw1DLwb8cje6TeLY9Zk6EZGsh8HUp657xTjFbydo6FXR2RUNs3b9px1NXg2BTJHJoAqguxosuYewPAFI644k+bW/c7JLYMAAyhP9NdvQWxEpJld31PXsv338nCsV1dA40tlKb5TA0U+VlkEtk2wZ3GjxTrRMP+PLmMbuVBikzr2O685TnhKjY48Pk3PqSqAxYOh8BOxdLcIWZ3e06bqD1hCgIZ4CcMrU9vfbywqn+RKpQjxZGP1LHgSwnmaL5raSO9eROpLJDVU+/4h6u/L6mNX1Ij82FTA/CaNShJfmQd5kfjiLBHju0ISmCQZsuTiIaGeYGB/s0v33B4aGD04L+fAzbxMBbCr3KrTAgctsGdAOcZbOAamCaucS4OILnP/dYMSFrti0eUNUitEWLW+2aCqKU49TT4Gx+dSAugD/PCgXDIUBp4Co08Lw/Qgxpi7tTx+xEbSp4f5BYf4DanZV6LobKm45H5rhseTAPx78hcZxHNfKA2DtOM3AhvC8ryWSDC/dm7DqnD3bKnWdEMjDIEs/jC0LBT4OsX6S5KicnGU5W2N3p40aFaM5/KkZvBUL4g15dtq/viuaAb/PxoNLrZ0mdntV9D6QciP5uKP65IEAnp+QjdaoYiZEzRfOg2xYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(6506007)(36756003)(478600001)(86362001)(52116002)(8676002)(5660300002)(26005)(6512007)(69590400012)(4326008)(6486002)(83380400001)(8936002)(966005)(186003)(66556008)(2616005)(6666004)(956004)(66946007)(1076003)(16526019)(66476007)(316002)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5Osx2i8Ck/yhTDAAHjl+e0HGbW4MhtLioG2MaE4nGM06O0ar8OuaeWCJCZAV?=
 =?us-ascii?Q?wcTPnXxywMPliXavvyGF0sI/QhoCgSZJRdS0L+GvVFEML9uDQZ+m57Q+BYLA?=
 =?us-ascii?Q?/MngZeFeXNsIrgHb6LS9LorrGQXL5drWqQlgWwR7WoPKonXoXpKcnB9h3yoM?=
 =?us-ascii?Q?3gZv+jT5fbj43j38BYHmOvQqeREiMCte6sp4pLMYbPUaZ2lI2B8Bmy9jMk7S?=
 =?us-ascii?Q?KUGcIzk8SeySjczfELP5hQfhvH4CkxIYVv4VZ3axC9PKHCpFkwSxBKBeP7YT?=
 =?us-ascii?Q?8clPO08W0Z/sw2zciYgmHv0/uCVn3RrfTHKbLutzO56G5pMEzZBZQzYIQgJb?=
 =?us-ascii?Q?Xmu7WR/dHSdqSOn9NWe74FiSlDspsuIdpPgbRxtiqkeLrpI4DNjc6IMGlr04?=
 =?us-ascii?Q?IUdINfRd95r1JHWEni02+x3VpPY7orIJC5g3uTMptdt6NtWQO2i+Zz0zkpq5?=
 =?us-ascii?Q?RC8XLX+hiEPxdtHPO0szN2WUK/5gl6QnLsp9+qMRenAAe9RtoZCDzkhUDFGN?=
 =?us-ascii?Q?zpy626yo7A6rKJUo+NnsVm6vm7fm/HMEf6WXHirg49Ztjxyvthnib/Drgsdn?=
 =?us-ascii?Q?M7QUqakqa15zHvkNmw1fImbU167SnmVqNyGop54S74+oXqgVeM4ferHRNB/L?=
 =?us-ascii?Q?huZyTIch+X7aeGW/dDwmAZob4YJ1dkAhGLfHIFI1Am89TGymwa1dEfUkF/6Z?=
 =?us-ascii?Q?ezHZn+OaArPvJWFx+xKgmpceTys0PYZCke02fD6KsJnauJYKLjbF9BPC2Ffd?=
 =?us-ascii?Q?m2RjZ8rJMDyQ1WPJLu65ZKBrqbCZkTqNYSsMG8UZMU9/Dng41nFN6vXHEedA?=
 =?us-ascii?Q?ViSFlnb+5YnImIg3ysPRs+vyYIBeIVY3ndnrdCt8wDh8JgtcB4NkjkzzI42o?=
 =?us-ascii?Q?QvFAPxnMcuw28j1tO+ZdMWYSO1yA8Kci8Hmp4pXjibob+IfQi5wRMLoi7B+i?=
 =?us-ascii?Q?vFgUNtg1U5M3BN7sVbYdsQsuiwBztvxKcB4O8yrss1UA31ufJJJKqp6Qfc59?=
 =?us-ascii?Q?a5Vw699vo9TfJKmWo3q8YaCyg7fDFcQ8j53c1dSAJbNeksIOWftHD2j7HS60?=
 =?us-ascii?Q?Kb6x1/9U0yWsoUKOVbLPptctSgKmaDXExCCiu4Ah0wfkfmR0JU9dpBghSRHi?=
 =?us-ascii?Q?8zRqZeGBpgqmrG1/uvXAP9YWKYfvzfIOSpZyVdKSa0+gs62L/E8W283ODH9K?=
 =?us-ascii?Q?HUzfTgUKqvpw7XM7jJjXLzsp/lHVbWabtYuGIWt68XUzf+PKRpiSlsFqYSkm?=
 =?us-ascii?Q?Y9GT6tvX7Q/BeFIOOX25c7C+7AXJsAR5Rhp/mhrUa17lF5XNdEfSE1TAp5hB?=
 =?us-ascii?Q?lhXMJv4D7KgTndqPO/i5KACA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a77144-6fb4-4473-ad26-08d8e8b4441d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 19:47:00.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoLCxP/IZnZhmyUOmTU7DmnyvkYYe9QrRxS5g/Eeif1mNuA9qmbacmTL6IsHpQLCHtSuH8xjKvO+eoLKwZ2a7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD are supposedly not
required for AMD platforms, and on some platforms they are
not even listed in the function mask but at least some HP
laptops seem to require it to properly support s0ix.

Based on a patch from Marcin Bachry <hegel666@gmail.com>.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Marcin Bachry <hegel666@gmail.com>
---
 drivers/acpi/x86/s2idle.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2d7ddb8a8cb6..dc3cc021125e 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -317,11 +317,16 @@ static void lpi_check_constraints(void)
 	}
 }
 
+static bool acpi_s2idle_vendor_amd(void)
+{
+	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+}
+
 static void acpi_sleep_run_lps0_dsm(unsigned int func)
 {
 	union acpi_object *out_obj;
 
-	if (!(lps0_dsm_func_mask & (1 << func)))
+	if (!acpi_s2idle_vendor_amd() && !(lps0_dsm_func_mask & (1 << func)))
 		return;
 
 	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
@@ -331,11 +336,6 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
 			  func, out_obj ? "successful" : "failed");
 }
 
-static bool acpi_s2idle_vendor_amd(void)
-{
-	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
-}
-
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
-- 
2.30.2

