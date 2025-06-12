Return-Path: <linux-acpi+bounces-14311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC2AD7EC4
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB23A0B7F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88F2DECB8;
	Thu, 12 Jun 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="B9B+/EOF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023120.outbound.protection.outlook.com [52.101.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CA239086;
	Thu, 12 Jun 2025 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770026; cv=fail; b=l+bYdg9xtPmMTbWdH8/WdO0AB0WWXQpEI5Q4LSFnKQvxlQdrCxefO4y090aSw90GI7cIfttrKNxO2IJgupxHtxlTpsdz3wr5rlTd/D9WK/kK647fJ2N6pIMA5s5kQbfvxOTR1HCnNHBVBpxfyQJCQDm43MisNwFuBehK8fM1xec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770026; c=relaxed/simple;
	bh=QM1UNGN060DdhZ7pRrT+W2lh5wby0/k2Am5el3qMIFo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tTNYCOen/Ithyx58GAsW2D1rBcIu4tAGIr2enPV8CePK4+uU9xxWyyqvmnvqBQoly7GOnFrX6w49oF3ajVE4lJYu6jQgj5D5rtbhC+jrHTfflt42n/rP4X/9B9OPxCsl4lTfHb6skN80SSB71dM4+3KoXNspAtGwxfbAAGCK3+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=B9B+/EOF; arc=fail smtp.client-ip=52.101.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkczjY7iOpkcE48+nyNeyQRbL4a14v7mnG30Oav99+2kQnBD8Yq/k3SJN0rCXj29iMGVJdQwXa889x84mbc9wKLtt77v+OFG88DDAKxaYDxcOlQCh1SznCs7zZIUb/TmgO0su+Q2Pn/ReTslhmwe+ycjB99U8vgWSJmmjCwNUo1QJipqPsuzizbw+rkzBpKTKo35ajFYuuUctaUlzKjXIAvCwZ00Os3i6xdM5ujI5n9HTBGkoLwT8bea0n3pcQfIwQbiO7AnjQp2R4NU1T7CdA+KWr+kDiu0LXRM30Srv/m6Y5EoZPxSmN1LhHs8BoM3c+AIC3n+vxOHkruXPU0yFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtJFPzhU6u8qB61le+DYlFjq16maaIcIziuy9WWYJKQ=;
 b=fNJn088L7ydQRRE5fjlOhIjf7WzZiMG/iteFAAKmkvvF/hOnBSTo/olcVmeHVoGLPy2rEengFT8RbzTVPXysF6/fRs7WhERFvudAWe9ZfTItr4bmn/UG1BXJrweX6saBhLaot+PhHKvePF7zezwWJsKuLOGYP3jhMQExl0N72eQYHb5gc0AEY8DnnJ0mdCsD3OKKn/lIl7MAweZplK/jA9T9FBCyhdJjCH9+5XQHHxuwbZmMFEVY9W9T7I7M7wYj+R+koDZzLZhA6Y6x3vXCWpayclvEEUkmjJe4Z3bFyjAqKpovof6mAhZ61Tx8v/EMjVj8XZC0gXnkv6lNW6ic/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtJFPzhU6u8qB61le+DYlFjq16maaIcIziuy9WWYJKQ=;
 b=B9B+/EOFAtSoUwYZLT7mbDHwxxI5ozQQYlvLT3aF5pCUj8+/CgaV68K/pQ9/65EO1tP3kcJcNT1k/AclGg6eGC4mLuezqDa78/mee7pK01V4R+v8cfuUFGIEBo2hiZAlhMhdBo2EQHD3QlvfIORI8KUFEs02SFadJqX1EPuCRZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB9364.prod.exchangelabs.com (2603:10b6:8:24f::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 23:13:42 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:42 +0000
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
	jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com,
	dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v9 1/7] ACPI: APEI: EINJ: Fix kernel test sparse warnings
Date: Thu, 12 Jun 2025 16:13:21 -0700
Message-ID: <20250612231327.84360-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS7PR01MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: eb97100d-6d53-4bce-fa22-08ddaa06c592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ViorSQRkf/CWpuA6UMV53bvSczSxA6xty3zfvmi44hywBk33XRc7jALTVybr?=
 =?us-ascii?Q?57rWzkABNPf2xTseuVf3lUdSLgeZ+ItT1zZg9C6x3qS2cAbLmkyPimVcht9C?=
 =?us-ascii?Q?HSAlEMpygbtRzbGBOcT9w0HwrlumaCmkknbp6kzYGBsIQj/kRgcbUkiE+ann?=
 =?us-ascii?Q?XET46NWk91iK9Vk2o23ahIEszRQMFSHzC6wFrplLEyKzmWcXcCpnc4dg02v6?=
 =?us-ascii?Q?FRCGV+HiJqUvYncqtSkRl32NDBdMakkiOIWNpBzqEz9XCUbiqNeWLWFmkQOx?=
 =?us-ascii?Q?1LlCz1RNTtgD5FaKBy/snn02LjhpW60tZ3wxoVsycRjgMUKSzHWfG+M6pkM3?=
 =?us-ascii?Q?uJpblU/HYHceM35BDBkocGvNtzXLb9GGRuv6ZPpEDP8yfUqkcUJnyIOpu7OF?=
 =?us-ascii?Q?vwR4y+5FEccqUIg6Ei+v/oWkDe+KWooTRserrntP3VZwowZhZWCj7AGmbV4X?=
 =?us-ascii?Q?lbY4btJUL1bVt5KMNn9P8Zv9cIOQQpzjM1nO/wFHPmVKJRwLh8ws/vuk+Wxy?=
 =?us-ascii?Q?JAq7lmFjdBMme290k6WIKBwlEpcl29rx5nPZPpvQfVOIZM/wH2pW+HdtsItb?=
 =?us-ascii?Q?xLzClHdRQH2eaO8FJd4PyYTfsZkMRjpbdF3rr1x7t6gCPcrdOLjdL8IvrABq?=
 =?us-ascii?Q?Q8Wwi/DXHzQbKGLi9UzwdsjGAcc76yCHlhQGvlkGiYRwlQkXyeo0Pc61dwM3?=
 =?us-ascii?Q?Ttfe5Mqn58m9MYp7SCbP/ut8HuCNJIoOFu2G16efEZo/KHm6OoXvIg+C1sXW?=
 =?us-ascii?Q?cABLJ3S5Hqa9a+g1FoDBxo7qRdlaYRtcnZC9nPbqsCXvMFlzAwcixUYPoeG6?=
 =?us-ascii?Q?Dy64Uzm/fGE0066eM3zyztFqBEdwJt1dmdBKTbW0xm81hgXfTkdBR10wMkzB?=
 =?us-ascii?Q?wa9sf/vsWmAS9knwjUiVnF+5TArrnooit0jFZ3TgxOZDLHZ5s5cmKq/aMTq0?=
 =?us-ascii?Q?9WPsR4CdhL/a12YrhXBwHLShpHeCfJ2JchEduJXTC8UyjXQOE17uXmZAPFZf?=
 =?us-ascii?Q?RpeZ3GH9I3x7DLXZtuWVQYUrrA4Mfu7qdbcQVIUkHlFzGhHZa4NEihJZO/hF?=
 =?us-ascii?Q?Mwe82Ji6oBJrxvSyFvVJYZifWvgig2QzhGV6Dhamo8y+X6008gfhgYxtB70n?=
 =?us-ascii?Q?fZuT0JDsblzD+qqJgGIpnKB9x4WCW1WIwqzyAW9GcVjX2M7hNdq62y73GwNI?=
 =?us-ascii?Q?VWt0nRF5qbKZL3J+bLJsxYuLBHH2M9+FPIN4j0EUUGPfZ0ufvTKz2BWRdrTA?=
 =?us-ascii?Q?aRw1yRRtdcTWMmBY0sbRdspXu+QxBbgppbbxwkQeqJNjrDU4O0uCrGCKOPGT?=
 =?us-ascii?Q?pYglkixDJTgF6ez4LSzyc7YvRS0KAca2NHNO1zFDYyaEPzg7Ua7mnwXAgUqh?=
 =?us-ascii?Q?5maabcw48fk/gozIqIHGOdCtq3NtdfJ6ct2eTYEUhyywWr0r/rcUMXbZ20wS?=
 =?us-ascii?Q?LlyxVjg78Lo0nGceutdTo/DAr39xX9uSQNtJCdxYwpRGmwiaUDhlMM+IHf4p?=
 =?us-ascii?Q?3WDGEsiFZf9oF/sbgT6bKapYUVbSEeefnCor?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yn8H79ibKjN9HWZ01/WgVSdbg+5zfvHA5yC9X8czPW7YMqKPyhhwEjWPDWLn?=
 =?us-ascii?Q?z80b+ABEw4z19EQcoNtfGH6b4+oiYP+F2sUkvYLiqOG6gBQiIyuVD5txZj4o?=
 =?us-ascii?Q?SPr3KjdygmwF3itT59kkoFPP9/oQbcE6VUrpXxL5ouoeu/R96xqKBmeK1No9?=
 =?us-ascii?Q?6jZZ/HFp/LakNJ0Dw+y7thf59TW4WZF2tnjwxxTr4c88AU9xP99m4ZoP5SiI?=
 =?us-ascii?Q?2ejT6Td9AzVWpTOdNjzuMDJW6j0vjLKq1CNgFipInUzjoHMrslljHATOjf4K?=
 =?us-ascii?Q?/Eh7oVXJsYNvdZ1FQEsScqixA1R3w1YvA6+MQMvXj7tAkzgg96zpPmj2VejC?=
 =?us-ascii?Q?xhaoA2FlbdFdTAh5ngqJ4zYBdooH6N+pbAGrS3JaITipv3E+LgDgBv5q2485?=
 =?us-ascii?Q?KuXEsZ8ZkuAVdVxbZ/xAcTlXB4lSxOWf+PyJ9g3KOcW/c8yDdY2scjaLgmvr?=
 =?us-ascii?Q?axBF+Wtd5zET5EcLZpmUvkrWpEMy+Do/kSJhdj/SBkhWKa/M1+jh6ktqjk/R?=
 =?us-ascii?Q?76YL4E2HxL2YOuIIZ4nSIdVK8y0vcHxh2UeXR+MNDHIq0q+U64eFJ8w6uznN?=
 =?us-ascii?Q?2i8oLboXT+QrBWCtJiCLBolx4jbbTGFFMWqBop30nGTmjWSDVRTfAgVq1tYC?=
 =?us-ascii?Q?u8X2X9L8T7+8Fk5NcmtR4Bh9I8TfiRmqHOOKPjD+w41vI3Y8omrveDOZd7kj?=
 =?us-ascii?Q?3rraOvvjn38OuHyafLndwHLXbjolUvYZp0YOuwRRjh8sS3mfHth//5AzxAxw?=
 =?us-ascii?Q?CbMEt97LebPza1fo36qM9rhCl2XiO9jKtRaCrtEtMA+x/kSE8fpYEU0yiNyS?=
 =?us-ascii?Q?+lOP5RKToiZduQx586tyurlyWCDvn1i7suKcrYNdGwE0F/EI7SptJXpleHln?=
 =?us-ascii?Q?qEzO3DMOV9sTNylsNXZ53j5QDIOIKDt3RNwyiceSYUv6LkfpMt7MfZYRAZHe?=
 =?us-ascii?Q?cly2cX6B8EGRDa54InSS7Jkhlyu5FXc9D4nu88Zf+bYNeuQvOlLE7+W5r5Br?=
 =?us-ascii?Q?Yd1TuZtGBW2CKQ6aVr3pC6i7CVTTC/s4COBk11tQK378sdTlTVtCcjvWWzOM?=
 =?us-ascii?Q?PzeGbvXQSHmrhEUYNYesaCQCG+U+DA8Cvd4UmeUlUPLvo7fde0lzp6vySXRJ?=
 =?us-ascii?Q?nv5b5VhUeLgImA+9NXdsRpD23pLyH60IusYIfnc1s9/j1yZA1nNTGLtHSMyD?=
 =?us-ascii?Q?EX8PmGiKKOs9VTkgRnogMq2e1xefs8S5zSkdeyylR3ORCzeKhvmunb/w13cB?=
 =?us-ascii?Q?Jp0p5Xhhv6D/iGI0H0bTqWany1o9fiitET0NYJt60rha66rLxXwsZDF+BXo1?=
 =?us-ascii?Q?dq6RZwmyUdWcntM5kwJT4gFUkdVVm16rEp0UCeqjhXJqTcNr6Te3PkBG8KUH?=
 =?us-ascii?Q?UviCArkHvojkNXarHHsgcOkUf+V2b/TjStLM3btrum9dbSRGjDE1yvfzoPws?=
 =?us-ascii?Q?fhGY9t4EliacwX3AekvIBulH9au75VLnMeiyFHIGhcw/WkKnYlm3K8Nzohmb?=
 =?us-ascii?Q?TR+ZXRenUl0F5C0XWfGhKeWOhhXlg9H1vi4vsXSnNJedbktI/XFONbzAm8+0?=
 =?us-ascii?Q?2YOh9anpRpIpqLedWdTy1+RArUVDu+WkS7wAOmuRmUQcgqz17HPURtFK4PPJ?=
 =?us-ascii?Q?rD4BdyMcBJdfDlxXRq9wrg0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97100d-6d53-4bce-fa22-08ddaa06c592
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:41.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kc6RnUWWzHO8xgd8XxGVG9YH6FJRwTABe+Wa6vStLid/qPClpq77sz7Ait+UEDJ3cArhVqxAFI85i/HM+E7IxrnLuudpx1+auLjbcHX6Fa8C6und7+7e4sUEH+wZZRKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9364

This patch fixes the kernel test robot warning reported here:
Link: https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Use pointers annotated with the __iomem marker for all iomem map calls,
and creates a local copy of the mapped IO memory for future access in
the code. memcpy_fromio() and memcpy_toio() are used to read/write data
from/to mapped IO memory.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 106 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index fea11a35eea3..b9cdd3e44855 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -151,7 +151,7 @@ static DEFINE_MUTEX(einj_mutex);
  */
 bool einj_initialized __ro_after_init;
 
-static void *einj_param;
+static void __iomem *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -216,24 +216,26 @@ static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
 	int	offset = v5param->vendor_extension;
-	struct	vendor_error_type_extension *v;
+	struct	vendor_error_type_extension v;
+	struct vendor_error_type_extension __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(*p));
+	if (!p)
 		return;
-	get_oem_vendor_struct(paddr, offset, v);
-	sbdf = v->pcie_sbdf;
+	memcpy_fromio(&v, p, sizeof(v));
+	get_oem_vendor_struct(paddr, offset, &v);
+	sbdf = v.pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
 		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
-		 v->vendor_id, v->device_id, v->rev_id);
-	acpi_os_unmap_iomem(v, sizeof(*v));
+		 v.vendor_id, v.device_id, v.rev_id);
+	acpi_os_unmap_iomem(p, sizeof(v));
 }
 
-static void *einj_get_parameter_address(void)
+static void __iomem *einj_get_parameter_address(void)
 {
 	int i;
 	u64 pa_v4 = 0, pa_v5 = 0;
@@ -254,26 +256,30 @@ static void *einj_get_parameter_address(void)
 		entry++;
 	}
 	if (pa_v5) {
-		struct set_error_type_with_address *v5param;
+		struct set_error_type_with_address v5param;
+		struct set_error_type_with_address __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
+		if (p) {
+			memcpy_fromio(&v5param, p, sizeof(v5param));
 			acpi5 = 1;
-			check_vendor_extension(pa_v5, v5param);
-			return v5param;
+			check_vendor_extension(pa_v5, &v5param);
+			return p;
 		}
 	}
 	if (param_extension && pa_v4) {
-		struct einj_parameter *v4param;
+		struct einj_parameter v4param;
+		struct einj_parameter __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(*p));
+		if (!p)
 			return NULL;
-		if (v4param->reserved1 || v4param->reserved2) {
-			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
+		memcpy_fromio(&v4param, p, sizeof(v4param));
+		if (v4param.reserved1 || v4param.reserved2) {
+			acpi_os_unmap_iomem(p, sizeof(v4param));
 			return NULL;
 		}
-		return v4param;
+		return p;
 	}
 
 	return NULL;
@@ -319,7 +325,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
-	struct acpi_einj_trigger *trigger_tab = NULL;
+	struct acpi_einj_trigger trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -327,54 +333,57 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
+	struct acpi_einj_trigger __iomem *p;
 
-	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
+	r = request_mem_region(trigger_paddr, sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
 		       (unsigned long long)trigger_paddr +
-			    sizeof(*trigger_tab) - 1);
+			    sizeof(trigger_tab) - 1);
 		goto out;
 	}
-	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
-	if (!trigger_tab) {
+	p = ioremap_cache(trigger_paddr, sizeof(*p));
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_header;
 	}
-	rc = einj_check_trigger_header(trigger_tab);
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
+	rc = einj_check_trigger_header(&trigger_tab);
 	if (rc) {
 		pr_warn(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
 	/* No action structures in the TRIGGER_ERROR table, nothing to do */
-	if (!trigger_tab->entry_count)
+	if (!trigger_tab.entry_count)
 		goto out_rel_header;
 
 	rc = -EIO;
-	table_size = trigger_tab->table_size;
-	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			       table_size - sizeof(*trigger_tab),
+	table_size = trigger_tab.table_size;
+	r = request_mem_region(trigger_paddr + sizeof(trigger_tab),
+			       table_size - sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
-		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
+		       (unsigned long long)trigger_paddr + sizeof(trigger_tab),
 		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
-	iounmap(trigger_tab);
-	trigger_tab = ioremap_cache(trigger_paddr, table_size);
-	if (!trigger_tab) {
+	iounmap(p);
+	p = ioremap_cache(trigger_paddr, table_size);
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_entry;
 	}
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
 	trigger_entry = (struct acpi_whea_header *)
-		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
+		((char *)&trigger_tab + sizeof(struct acpi_einj_trigger));
 	apei_resources_init(&trigger_resources);
 	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
 			   ARRAY_SIZE(einj_ins_type),
-			   trigger_entry, trigger_tab->entry_count);
+			   trigger_entry, trigger_tab.entry_count);
 	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
 	if (rc)
 		goto out_fini;
@@ -392,7 +401,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-			trigger_tab, param1, param2);
+			&trigger_tab, param1, param2);
 		if (trigger_param_region) {
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
@@ -421,13 +430,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 out_fini:
 	apei_resources_fini(&trigger_resources);
 out_rel_entry:
-	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			   table_size - sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr + sizeof(trigger_tab),
+			   table_size - sizeof(trigger_tab));
 out_rel_header:
-	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr, sizeof(trigger_tab));
 out:
-	if (trigger_tab)
-		iounmap(trigger_tab);
+	if (p)
+		iounmap(p);
 
 	return rc;
 }
@@ -446,8 +455,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param = einj_param;
+		struct set_error_type_with_address *v5param, v5_struct;
 
+		v5param = &v5_struct;
+		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -492,15 +503,18 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
+		memcpy_toio(einj_param, v5param, sizeof(*v5param));
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
 			return rc;
 		if (einj_param) {
-			struct einj_parameter *v4param = einj_param;
+			struct einj_parameter v4param;
 
-			v4param->param1 = param1;
-			v4param->param2 = param2;
+			memcpy_fromio(&v4param, einj_param, sizeof(v4param));
+			v4param.param1 = param1;
+			v4param.param2 = param2;
+			memcpy_toio(einj_param, &v4param, sizeof(v4param));
 		}
 	}
 	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
-- 
2.43.0


