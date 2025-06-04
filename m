Return-Path: <linux-acpi+bounces-14143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BBCACE6B8
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F1516C171
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9322367BB;
	Wed,  4 Jun 2025 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="j5VUyeJs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2112.outbound.protection.outlook.com [40.107.95.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF75235063;
	Wed,  4 Jun 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076711; cv=fail; b=V+930RLDf1wcY1Mf7F65U9K6P9py5rdVd+2vYRzXNaUvaMfrQ62gwBfYhyVvUEjjiAqBQ3EG++Uoqvl0VHimUgj1jNTHleYrvTkyjiIiGUd6L3gQHXRbHIuPT94dNZ+L40FDC8wGFhMvqf9cvUZysIFCoMg3KM080gd10+XK2E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076711; c=relaxed/simple;
	bh=V9U2ofPXcXl2bwBTBgsgiwGaUWDsU4OgBKDxIqiwoc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGmyqCZ5GnkusOQj9N5W6eSdH3Lf4couPxVuRlaGq3pR2FM1jIb65u+BqLOiTyruJ+Pyu/haJ1eiqUBaXSNrHv94VB/4S0QCc/Dg6IOwiKN9Xq/UujzP3A9uaCiipuo/TIJomIx4yH52aABOFlu60WADccudyU2BIOgQMcrdJxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=j5VUyeJs; arc=fail smtp.client-ip=40.107.95.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLXcQZAU56vDWeDnFokGlz58h0iS5kawRO3jEs/jANz5GRVOzVgjTn+UjafbhZ6HmV5ihw4+1LeKSh1CkaGJ8vU3dUvjJ7+qaMnQ9iKqLdG+X1sNDMaZ4/ISgY2yh33IDabwe4H2oujN0fwaGZq4FnasK3sRYOZxzByPaH+NnUSPl1UZH7bvCs+mH5ecX6NYgrJ0vtIauVzuSazKT2BNqPOgX3vzOfBlkbapedC6ylC10z6q051U7beufDcuEQGb5nnWy8ByacVbi1A4/+1ScZc+gXYFAeFicH+h+4NVIEPobxGYUnM4FGA1QVC3fxXrbLbgD/tP5JjFZq9Psm3RRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XauOU2c0mMuNL62IKtfOCX0kRc5J5kWcsCzvFYwB+mA=;
 b=xo6PeE/MryvLfpOIBaB4gFXZhg+hismW6kuOoFKV8bqdoklbBWzlxyqlHNvq9rYJvcZD3rR9B+OkLbBACOsjfNcWxsXYgTP0xAq5Xmo/XckBW+0cEpu9IkCEeDYCOhjLe/vzj295hSA3HtELyJVtS5Uy41l1Q1x32+5ffbgk7c4ZEQ6KsjKbCTfudX+HRBICaRxUVTBWEvHaIM2K+C6r5iDYVB1vedXPa/08JFZRrfYa1WMib/0Kttdur+yT95JRz2rqIJd24YHGv2T08odaAQMCYkhsbjB6GgeTDLF2HyB63Oeis2bR1w+IvcWgbwMQcZ4kFmhX9ifoPQzwWS3L3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XauOU2c0mMuNL62IKtfOCX0kRc5J5kWcsCzvFYwB+mA=;
 b=j5VUyeJs2iiIiffu89RcrsCiUE+EX0fNXmXkJHeB3p/LV+xDS4S8q/3ANQLxuPadKETjo+Aj+y5Xjfutb2yL3NDifGXUAnEPckrpq9IX+/txkTtEsiGyDWkAbFgvGS2q7kNc996ZsKh9/4dczWRL483ziCEFuCmeKoeys4EHe00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB8159.prod.exchangelabs.com (2603:10b6:806:333::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.20; Wed, 4 Jun 2025 22:38:26 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:26 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com,
	u.kleine-koenig@baylibre.com,
	jonathanh@nvidia.com,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	peterz@infradead.org,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	Benjamin.Cheatham@amd.com,
	dave.jiang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v8 5/7] ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome
Date: Wed,  4 Jun 2025 15:38:02 -0700
Message-ID: <20250604223804.842501-6-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
References: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA1PR01MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f93fce-0c2e-478e-86d5-08dda3b88578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B3ZE1vUUwTB5CaTfrim8Ow5byv9Kxobb92LwqLb5E1H9zNsPtmaOmd4M1S1B?=
 =?us-ascii?Q?p7OMa8N2iy+vnt/ZcQs1SNNn1Qo3mM6DuKOPW+O8Ssd+qQvbu2JzEKwzoJra?=
 =?us-ascii?Q?Bvl2S14bzH9mKGlVjeIQ+0xiNz8tGO6TzRBzBq/uzGy06R4uQPpnkQCtcbFv?=
 =?us-ascii?Q?zI2veNVRR12ZrPRbF2E79pKkMMnWwUDJSlrh9TmorteY4+KumZMz5vNNQFKt?=
 =?us-ascii?Q?hmj7BcImIsOFCtE1LUttCHWpJPeRju6QSnL0T9GiJ0oi6t6rQauj45EhI8w4?=
 =?us-ascii?Q?/6L4jV/p2XTqkgZ646CnYdQ0xc4/5/AoLUzjm45ryxJPPuyx8ElWmwvdVuNF?=
 =?us-ascii?Q?qmy3c+GveZygss2nlKlh5VNnMGQdWZQHtXfah6A+Gc8AIxEAhzNqxyhGbUez?=
 =?us-ascii?Q?B5/fshpPdvrtLQtHXiOjDa/GF1DZmB1i2kkSJZGh6l5LsvmxeWF3XUxkbwIg?=
 =?us-ascii?Q?F2PEA4322g90dkZgrAOmU2bOaDmJbrYhSgN6awpfPvxlXDrEdxpkUuKrO/0C?=
 =?us-ascii?Q?B9VC5lAN0hQAnzmS8AOzmZPzwp+NZ2d7cC7LoL4aaygPfLV25W63VeIhqcGj?=
 =?us-ascii?Q?D5TDfC3BykuIhIpV6PXN+qYYGq03COQ+alrmTV7Fr7JKbQ9reST+d4BlOBvG?=
 =?us-ascii?Q?/2PqJx4O/5B259+Q++DWbYNUXX47Y6lDDvk3+8+8ryNF7nkTOkYv15anSOxL?=
 =?us-ascii?Q?EbI+WKeYxFfppFyNRbyEfPgqU5OY74F1UF3KLyjP1sY109pmdxsMDKpcnlCC?=
 =?us-ascii?Q?Jbr31mxZtOjYLJlqZmb/LjDGWTlPjfTQ8xs3vRaf406v3AfrYxwhovnyDRj9?=
 =?us-ascii?Q?GUdVvArcKSXkJR2+C4P6y+Zcv4qIfHewnlDIvZRKdqvDO1kcIsgKJ+W7XpV8?=
 =?us-ascii?Q?xvLT8T56aGGzHeFnXpwoQOYlPrYo7KBj7y4aC46hi8HJQceZ+fIMuIp73m+X?=
 =?us-ascii?Q?XwiyYaoVXMp/y3IrfXOaJDvRRcSLxQNjQrDLMgNi9DDobtVce84UZbA8pLfR?=
 =?us-ascii?Q?xBVrT1HlJC1OvJIbmlUP/MgxSuQXv4ejHeXFYU8MUjdph+QQrgl/S21i22/2?=
 =?us-ascii?Q?IbQ3XUCPSOWZ81s0ZFKUqz4NkwPYpgov3L6Jw2Wm/BY/mhmgFIinTKrsaZ2M?=
 =?us-ascii?Q?D+E1YM1wtYmFF5a8frpRQr4VJ6RadXq3a9Wfa2Z0+AEcKTAHSdNU3Z/DFSRg?=
 =?us-ascii?Q?z6drRbhJZ5mYacCc/9AzcRLiNVwoenkkWlCMOqdSxH6X+onTKt4/OEg/JGw6?=
 =?us-ascii?Q?h+rJ1yZimpYtIa2B0zsFN+f9UNfo+TD2WMtfgXTKUv5/VH+M1PR84CVFfIs8?=
 =?us-ascii?Q?ovAoEtSBq12iJyS01DIC+RsiZhXTHk+zSARYOljYUpzYokuBX0RYZ+mZWA3l?=
 =?us-ascii?Q?sgliqeqYgXgm7GibfIaFBFoN2CFRsDNwsSfNO6V1NC9jRoZaSxOvsbM5nNnr?=
 =?us-ascii?Q?OVdrGxpK3qSwxwEuSIhePuBRTrImlsOiC7v1R5BNGnda2UXnFe5lTX1BqJ1d?=
 =?us-ascii?Q?d7r92jDeMFruL7w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQGIrggTkfAXjqU+KFJhih1ULGZcTzzuNA5htSor8cF85qF+iNzokbQSJA29?=
 =?us-ascii?Q?3i09RDv9U6Ntcx7avYfoIDD9WLyENDcTCxAD1FccZxUxzfibi+DEnvqtHwei?=
 =?us-ascii?Q?7is4eur3FXflgOl2XwRQgOsoGZWeBoSFpK6kFTqQgtB2WiOVSo4tSvZPfmhf?=
 =?us-ascii?Q?sUGoUUM3+mfl4TyRVShSQga6a70rARWihzTVtsJsx8E2rVcWDvZOlFLUIpv+?=
 =?us-ascii?Q?/bEoyslnKO/jTYk2fGyx7lsR3oLrjINFb5mXc6Ho1SjNf1vkYNtR0sSIzn6w?=
 =?us-ascii?Q?z6kQm9wAn+26yYWcTZXgRpHXboh7ug3xZvulsoIKzfkNo+RPkA5htqtyDNKH?=
 =?us-ascii?Q?4THE00QsLRyzolsnsIK+OOz60SlQPhThdh9GdF34sQLGKtOh1Mh732R7v5UV?=
 =?us-ascii?Q?hEnDqrobxToXm0rXokHYcAHPyaqAUASjldObWscrAEHqpqoXvKTnztOezbt3?=
 =?us-ascii?Q?ETFGidMVh1qEupI0t8OIeobBNCpDxByJGAO9OX5BcanY6YVuMFEBA2lmeFTg?=
 =?us-ascii?Q?HziIsfrMAhT3BoXdto8GhyxyfVw3lqEm51OwPCZID8kOSZ0BwRJsbvu/j6kD?=
 =?us-ascii?Q?0P0+xSGo4RKQE1oti9/9RvfYiQMWiZI1wpKWmcL3aEqwviSopaPIVnRn2PfO?=
 =?us-ascii?Q?9VxeHGKAEu5H07l61CGPF2Xj2xs86HEqkbfyKmUPjKjrrMTSOIcpZT5RUH5G?=
 =?us-ascii?Q?P2C8jiGFM0zfAXfbdtnQVLpsJDekowREFglvVq4OsKuJDnZJxM0828dvaiC5?=
 =?us-ascii?Q?Db9ZGALnz+a/CmJKoOcFo+OrIcWMRTuPzc9qBDG8NszjIYv0cAN7WI0RRCWn?=
 =?us-ascii?Q?cdgSSHh12z5tEPGxeAsyXp4OGRFr5lK/J4CrkSrxYvL1QwbQ7YFw+1vf286V?=
 =?us-ascii?Q?myogyObnPp1HUQQHH6V/jrct5NiNa/WLEHGTxCMdDmN1eObHTgyy3d2vqHf6?=
 =?us-ascii?Q?s9jUQtzvtOrFd+4Ba0AwujpfdBNlxLse0bPMkoCxJGNXoSSCzCYRwVa9WUFE?=
 =?us-ascii?Q?AaHl62zSFP6oq5XYbbbiazbJD2Zz0aROkteJpiPE3ApQzamT/qg8NlB0bSGa?=
 =?us-ascii?Q?/DnZXcEQu0/PM4X9pm3aie3dJJtdqlE/zqrASx5uX9i3j0e5vVtj6sS5H4BL?=
 =?us-ascii?Q?n9VsCmIUcfBEB3gdN/evzzsLCihEaRko6wK9Gez/Uv+B7zE22ri8VqPF8vCL?=
 =?us-ascii?Q?MXZLtuq6uTkQPzFcVTJfDIu+glplb7ULSrhuqdlqnaOcUYAGbxRh89pQ3exc?=
 =?us-ascii?Q?Zle71ZzkGyZyOfQ6835Ny7T3Tk/F54xhrbHeSlGd3PYTq2jzu7vEJQlovoPc?=
 =?us-ascii?Q?+X3PA14bXQgZPZOzGVeDan2+y/DzDbln3YiT+0EBLRRsXk1TqEk/Mk6jUBVF?=
 =?us-ascii?Q?fpDH1A6tHwiGNCNDOf8bP0AMuFSPfV5hqB571f08kRUy5so1y+qR6+TLrsdp?=
 =?us-ascii?Q?cNvYY1YVFczjePYUGlJ4Yt/9+Ce0vyxuuopzpf2f5CevXrB1E8d28qiUf254?=
 =?us-ascii?Q?+UTdWFLQd8HwyRRTAO1BDYT1TyJy2jTZJGlKei7av8N0v+zPSgQPTPqIJOBk?=
 =?us-ascii?Q?TY3d6GGfPdMDFzUWqkhG8s9pncpEBsJ8ga7w9vc+5dSjD6fh1itfVAbcUdMa?=
 =?us-ascii?Q?L3mA6lTZSaiVpTVeYPV5xNg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f93fce-0c2e-478e-86d5-08dda3b88578
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:26.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHia74M2Bhhb/gT6MVwnp50QbCrUXCLhjZPW3Z/00foMfNB1E0eHIXjJPlteymun60XKs93un44Sd0Q0FFfYBXEL9JQppZwMoC9NsvG3rQobs3aQWnj+/9eU+b49TZ/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8159

From: Tony Luck <tony.luck@intel.com>

EINJv2 allows users to inject multiple errors at the same time by
specifying the device id and syndrome bits for each error in a flex
array.

Create files in the einj debugfs directory to enter data for each
device id and syndrome value. Note that the specification says these
are 128-bit little-endian values. Linux doesn't have a handy helper
to manage objects of this type.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj-core.c | 99 ++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 08cac48293a2..2f46f1ace67e 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define COMPONENT_LEN		16
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -63,7 +64,7 @@ struct syndrome_array {
 		u8	pcie_synd[16];
 		u8	vendor_synd[16];
 	} comp_synd;
-};
+} *syndrome_data;
 
 struct einjv2_extension_struct {
 	u32 length;
@@ -711,6 +712,7 @@ static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
 static char einj_buf[32];
+static bool einj_v2_enabled;
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -847,6 +849,98 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
+static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
+{
+	char output[2 * COMPONENT_LEN + 1];
+	u8 *data = f->f_inode->i_private;
+	int i;
+
+	if (*off >= sizeof(output))
+		return 0;
+
+	for (i = 0; i < COMPONENT_LEN; i++)
+		sprintf(output + 2 * i, "%.02x", data[COMPONENT_LEN - i - 1]);
+	output[2 * COMPONENT_LEN] = '\n';
+
+	return simple_read_from_buffer(buf, count, off, output, sizeof(output));
+}
+
+static ssize_t u128_write(struct file *f, const char __user *buf, size_t count, loff_t *off)
+{
+	char input[2 + 2 * COMPONENT_LEN + 2];
+	u8 *save = f->f_inode->i_private;
+	u8 tmp[COMPONENT_LEN];
+	char byte[3] = {};
+	char *s, *e;
+	size_t c;
+	long val;
+	int i;
+
+	/* Require that user supply whole input line in one write(2) syscall */
+	if (*off)
+		return -EINVAL;
+
+	c = simple_write_to_buffer(input, sizeof(input), off, buf, count);
+	if (c < 0)
+		return c;
+
+	if (c < 1 || input[c - 1] != '\n')
+		return -EINVAL;
+
+	/* Empty line means invalidate this entry */
+	if (c == 1) {
+		memset(save, 0xff, COMPONENT_LEN);
+		return c;
+	}
+
+	if (input[0] == '0' && (input[1] == 'x' || input[1] == 'X'))
+		s = input + 2;
+	else
+		s = input;
+	e = input + c - 1;
+
+	for (i = 0; i < COMPONENT_LEN; i++) {
+		byte[1] = *--e;
+		byte[0] = e > s ? *--e : '0';
+		if (kstrtol(byte, 16, &val))
+			return -EINVAL;
+		tmp[i] = val;
+		if (e <= s)
+			break;
+	}
+	while (++i < COMPONENT_LEN)
+		tmp[i] = 0;
+
+	memcpy(save, tmp, COMPONENT_LEN);
+
+	return c;
+}
+
+static const struct file_operations u128_fops = {
+	.read	= u128_read,
+	.write	= u128_write,
+};
+
+static bool setup_einjv2_component_files(void)
+{
+	char name[32];
+
+	syndrome_data = kcalloc(max_nr_components, sizeof(syndrome_data[0]), GFP_KERNEL);
+	if (!syndrome_data)
+		return false;
+
+	for (int i = 0; i < max_nr_components; i++) {
+		sprintf(name, "component_id%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_id, &u128_fops);
+		sprintf(name, "component_syndrome%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_synd, &u128_fops);
+	}
+
+	return true;
+}
+
 static int __init einj_probe(struct faux_device *fdev)
 {
 	int rc;
@@ -918,6 +1012,8 @@ static int __init einj_probe(struct faux_device *fdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP)
+			einj_v2_enabled = setup_einjv2_component_files();
 	}
 
 	if (vendor_dev[0]) {
@@ -966,6 +1062,7 @@ static void __exit einj_remove(struct faux_device *fdev)
 	apei_resources_release(&einj_resources);
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
+	kfree(syndrome_data);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
-- 
2.43.0


