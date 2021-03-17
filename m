Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1733F30D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 15:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhCQOjW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 10:39:22 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:59457
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232171AbhCQOjE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Mar 2021 10:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEGs2ATiqojVH/bFfCfAUQVGAVtzWSm48xZUzICavSpBrIGfu6gDcJagu8YGwTINcpcl7a9+9Uvh9Bd9AYz2Z2/vYAQpTTJd55UEP0zIT18jyAdlnzKyoyF/C5ItI1BadqK0n7wd6FsDP8ZVDhstGqucyZ690syupIVTRG02qxWKxArSH88j3uGE16+m9/W2npk+ZduYW+Ser3eEe3z5uMVK3BLcqnkPH2kXnxsZlNutgnhQZaWAgYoPSIkD5U2O6B7YynIqESXPQePZ8iWU58fxPO94lqhfUv310x5rSQwcz72qLAp9hiVqXf2dPAojRBCNVFYi+5PiCdGqeOcyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVEWKR4pJ6PrNPeMKH8XS0LPqUmM65wiEvRRSSkt2xo=;
 b=e95A2pK5z/ZIeFuPTPdHq3tVB/yx+iqY0P9fcC9NGE03mMajuRxops+rSczyQalGuptiHQOamDZE9b7V/A4KRbzwvnLKKItE8znZisMCYVurlMvO4qETU4XYbcE/4QYo5uWOV5izzhaK9mH4dLCdtMEldXvqgDAvudCifNaoYqvhcXwXaa03tpx2TqxG3NIY6EK8KM9+P8c6zrP+9Hi+GELY/PX1qjIJo9Wv2kB2sseIA7ZwSCz+19HBmfDmoSuI7HEZdakZafKdTikzugkv2nHgFcrtgC50XR2SqiErbWgqspL6cBicyYlblyN/8cQQPW/H5BRfSoWBNb6W0Rh0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVEWKR4pJ6PrNPeMKH8XS0LPqUmM65wiEvRRSSkt2xo=;
 b=AHANGBt+sSzjFn2Ykx2TOUg3Zkpei3AYYSQnx+vMyv75ks0N7+DRUE/ZTP61bPW7FIrgstMOPVcwyjjlVK7v6LyrX8+x1Mq8ptATo3pHfaePjBETPpcTglO8/HAri7/EuALFbQ7AKf0I4HO6EVnoLvAnIdlI2IBCvJNqL3v4lsQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 14:39:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 14:39:01 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     hdegoede@redhat.com, Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Marcin Bachry <hegel666@gmail.com>
Subject: [PATCH 2/2 V2] platform/x86: force LPS0 functions for AMD
Date:   Wed, 17 Mar 2021 10:38:42 -0400
Message-Id: <20210317143842.786380-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317143842.786380-1-alexander.deucher@amd.com>
References: <20210317143842.786380-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:160::36) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Wed, 17 Mar 2021 14:39:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a4adc4f-fb7b-4946-5f9a-08d8e95267fa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4423EB6DD595EBD157ECB46CF76A9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qB4OMO2up7gvXKvdWfZr2MnxkvZ3X2z2MGdLe+W/UlsBsmmkpe2ibcMoHBXlPkGENHoJmXUN7YxeD/KMQUevDwFjTB7XPpaCFsNOyLe3yDm8bxt05kzSypzx0X73yPw16PwORiRK2bMneiSmvx64fkHYZdrQ1hmubbYhx3hYz54pvA+B1fdQkwvMQji0QIk7zjL3AVS6rvGGlmKDQS+cnGLOKopOT59Ti5brlj3dAKKftYhnti6xjZi2U6zMeaAAg6xOwrZtzpKRdGHsEnX/sermAV59e3OGFmSmo6hukXzTjjNiZoCW84YxGB/407o/T83/KoFq2y6m3yFll6vlQha+ARQf60k+0ZXNaWJqb7W48Zd9N7flNODhY8dGEUVKB5uHo8ZxyUOrk+pBy5kYxUDV27Tb8Vc4OIcNARNA1ADRAEvrNmneSdJ8XafgazyNTA8HRRMdYh0xkR/1w20sv2FCCRmlEUgmwOKv+lIyiyrWXS//5NgRd0o/QdlNKunnNFgfJvachrTJmsLoVLq4VVl8EpFl8vlg5kT18JcmCzgq5rfm8SH5M8ThSBVOwhwb+VHGfFM0T8VB2UoLe2F6A7Jjm7kw/UtAyz77CIa80012Hs6AsCJlaCVLfHRsIEiYXwPwMSjymqWqjpw9Ppx22VyXr1f7QVH3diyAHHAeRLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(16526019)(6666004)(6512007)(86362001)(8936002)(478600001)(966005)(186003)(956004)(2906002)(69590400012)(6506007)(66946007)(5660300002)(6486002)(36756003)(66476007)(4326008)(66556008)(8676002)(54906003)(1076003)(316002)(26005)(2616005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z9HTFVlWEMxrKbB0yhfSk2Ird8UtXcmVoewaxaNdbI7OoGtJuo1wUCmYYNMx?=
 =?us-ascii?Q?+LPmEJDNKETgsWFupjff6L56csBzC2eZuQygyELxB15m7hTRjr/vZk0PA4dC?=
 =?us-ascii?Q?bkXuMyq18TJVMdJuYBElUz8T/8j3tvngukhPGAT5/E185zl9Z7dcuPLxXpqV?=
 =?us-ascii?Q?g59AXIUD1mTV+UbaxW6TYw5IRtA1p7E4P8aZ8RvaLY7sdtXyFiiG5mHtZpUm?=
 =?us-ascii?Q?Ri3RFFW+5DDHN6Uw1C13dcA45w8ch/tz2Cfml9rpo4Mgr1Y9433jnCLt5JqE?=
 =?us-ascii?Q?1YyLYV2fLUBhlVG7AyM9fpOJIsfGm7ubmZI0yp1Bttl+BFq/J+rpc6kSY7xt?=
 =?us-ascii?Q?JtearpdKVLubdr2ypL4rU5XGYnwQDRLdI4J1oMAIxVG1zcB3Zvdfmbi5Uajd?=
 =?us-ascii?Q?jPI4NUzyOsu5KQ4z6Knsp+4ZQOOEaVf1Lz6LjdwC07J2uL1pLtMJjf+6BTCi?=
 =?us-ascii?Q?XWKzAWdQf7bxbz5klrKe1kNePQ0bqMB0kM48GE0X4wznCuiMRsIgwcVP36Xj?=
 =?us-ascii?Q?T2Y4E5GTZIz40DEjk+S6ym2tMJDWrcwJbPyUuxBmMb0EBfKg9/Oz40kscCAP?=
 =?us-ascii?Q?uJPMRMqUeFklnKtIKuGCKi18tdSSZvC83jMkDVZv1DOFnARGTTRmLWUrvBTW?=
 =?us-ascii?Q?yz3Ec1+TM5702qcm1OW137VEJ4SFK/DoDmmyV6j9ArHAu/bsJ0r2bW+yu0lF?=
 =?us-ascii?Q?ct0/P1kApEQwC1C56z/o+75ZXME58kwk1fhTsoaeKJhnvfRyYXvRBIK5BYr+?=
 =?us-ascii?Q?QlVqBtHUBkmXn6ounmHVArubpTcUg4hgYGiIOrUb2AvqQhMgjzqOhOJ8SnQr?=
 =?us-ascii?Q?j60isEkPHtVLwD1xkIsLS7XzEsKRtd/Ym0eIL0XxdGI3c8x4c/O2b8GuTzmJ?=
 =?us-ascii?Q?C6SHU50iDLA4ZWNjcKi7Oxp1Gz008RPr7QJz/77Mul/9GAtSybIWk+eVlCpZ?=
 =?us-ascii?Q?k5YT22Y7hKkcBWM8Kuu6ejjk08MWhbyDo8a/c7VboRpxeDmpbdNG/wIpcbFH?=
 =?us-ascii?Q?uHCw1wuhpuURQY3AQ+dEA1McxxQPpuofJnfhZRC+P0wQiaZXdu2KkdEBne6z?=
 =?us-ascii?Q?RO5bHOeILdz6m2rOX2c5GUFcLC2IsY6adMAE48NJ8YJchI6fFryiUMcBeogh?=
 =?us-ascii?Q?idNU5MN4hc8Iu7zAgZY4/dEyjOYt+ozuHOxfDmG8YrH55azrAf/gktsMJIcK?=
 =?us-ascii?Q?ScvSKCQxlDmKbNuIUCZBjBtDmlBBuFmmid0XTQ00MsFH7BKbMEU6aiss4rcr?=
 =?us-ascii?Q?sg/Ql26u57Lem95GajQDNr8oYEw6cBrjwz4GsdkhzYeIy2AU1do1o5wk94tA?=
 =?us-ascii?Q?iGsHQJrnNflyacL2+VG8F31z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4adc4f-fb7b-4946-5f9a-08d8e95267fa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 14:39:01.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOB9gD4/F+0m+Njdj0okpuEi5r6uEo6PakrHBbnmvFfaqb84tqCE98yGiCwAF0pSEIoyDEgblV4jBSJNIz/UYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

V2: rework the patch to just fix up the specific problematic
    case by setting the function flags that are missing.

 drivers/acpi/x86/s2idle.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2d7ddb8a8cb6..482e6b23b21a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -368,6 +368,13 @@ static int lps0_device_attach(struct acpi_device *adev,
 
 	ACPI_FREE(out_obj);
 
+	/*
+	 * Some HP laptops require ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD for proper
+	 * S0ix, but don't set the function mask correctly.  Fix that up here.
+	 */
+	if (acpi_s2idle_vendor_amd())
+		lps0_dsm_func_mask |= (1 << ACPI_LPS0_ENTRY_AMD) | (1 << ACPI_LPS0_EXIT_AMD);
+
 	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
 			  lps0_dsm_func_mask);
 
-- 
2.30.2

