Return-Path: <linux-acpi+bounces-14314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD7AD7ECA
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761903A11A7
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054C2E2EF1;
	Thu, 12 Jun 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZZtYv0+O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023101.outbound.protection.outlook.com [52.101.44.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CF2E1759;
	Thu, 12 Jun 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770033; cv=fail; b=oWh6bUxrKxjJAuf5dXp/BgIVfjh0XMtn7/FL4+BMW2g4kxHEuYsTVnqvxfEDcgRVUdoi/tmoFgsILJWQ8uhj8b7kmZI1m180w4zQzn/U234TJYPVcnA1FmJNLxsc7a8yKGmdSODLF9nuGFEo4LhoMdU3Xqp0WATIJqp/L7emr0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770033; c=relaxed/simple;
	bh=clFLvbJC5Js9y3RhwUbikYdlJBkVml2Y9Fdjt/yDoEc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIhVeB6G8QlzueqIZE/JmM+I/LBfjgmi+wJvpkYIH4RbC7TxFfPqQjW1nqLLoZaCJE96GUeroMG2yEaC+3QqMgGmqXSiKzzSDq1CTLOXG6lIYYvLSV9AoYxwpAWoQq8q3Z2ATol6OOPylWyOg3vNtOuELLGpKzVCJEro6g5f304=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZZtYv0+O; arc=fail smtp.client-ip=52.101.44.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiUpLTkVEi+YHvdUZ+DQhBYBDzCn0wArms1AX7HnjBfA0ww9tQ4Q2Afj6UyL9iwZXSGI0SScSe29yI2X/LBbzyCP3rHG7uix07eH334cY+bIyGi6nqaY3YvQbs3X2mKscHXqs7CIm3Yg4rrfsBBiaJbya9mXXW9LTOiC+pYr/yaTHczaOvCy80VHlsH6fZWoMfMfF98FIbcClUuTXs/TkOMZdHcg+i3zHQqlA2UVmM6W8MHydQRulukUbQeHgP3MxLMM9IiDFJG4bo83XZFKIiS5/AB2w8nZcLOCkYn9ZSefPru2Qr11Mds/R/5XYMdKbHz5gLUQ9NkEcO0j+LY86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnpjU/5erDTMU0FOiBoKfz4SW2lHS2hC8wZP4mFVIeE=;
 b=elgFDFWsgbby2x2s+0g2PEDQG6Q/pkwUxoFLL/xESKRWw32reAl6JmzcBK9H58p3B7XduADOJaZzP0+7XXjLTAiB5Af12kQAJDjSZQGZme5z+sWXtm+9rseNthjabYC115dKwB7WqQGUXXc8/2B8O2vwBffEK5+76cXQ4oPxucDQFv+CjRQW13RmSKZ/0Nx33blCSI/YfteWM0i/HvH4f70t2Bjqvk8GP0vBxAYRlbmMVNQddDt1sfLu3GL1Ws3OX8cMQ+hEtwG08C/gCvbJznhIlD2s8P73RZTVQAAPhKOsnKmBRd5Eo0Y/HwDjQav3Ow8A0RbwdcWbehcjksLomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnpjU/5erDTMU0FOiBoKfz4SW2lHS2hC8wZP4mFVIeE=;
 b=ZZtYv0+O41MCj/Cej0rS6ud3BYs6g524jbBxfelzgbiXqY5BLBoCx8fzIHdG7z+UnSAkeW0T9PYgoFLQYlY6WaqtDtTxfWu5/iiFWalx6WKHD2mGjflCxDHE1wRZDpSeMqXUuBWhXZK/6Sp4ZYR/obm+H1HsDKja/pNoUMZ30UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB9364.prod.exchangelabs.com (2603:10b6:8:24f::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 23:13:49 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:49 +0000
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
Subject: [PATCH v9 4/7] ACPI: APEI: EINJ: Discover EINJv2 parameters
Date: Thu, 12 Jun 2025 16:13:24 -0700
Message-ID: <20250612231327.84360-5-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: e10ff6d2-0b14-488a-5839-08ddaa06c9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhA7fnfdVetw0M8kYae+iZGeiZcVSpqzEwKFKJqLb1xt1052uGKHmdyqBs5P?=
 =?us-ascii?Q?X1jXE/jI9wh1xT89O+PuhDUfrHBowW5pAvO3w3mkG9aFNZpkSmPbD6pUtP38?=
 =?us-ascii?Q?O/nBLCxO1SVXhM4UNoRyg4TZ/Rdsd3bodVdzfhtSo1Bv/XQ3y3RHpwnO6Tmc?=
 =?us-ascii?Q?NwOnrGu5PBcg8xZhXVARJMbme/+lavHEAlP4JtqYOBN9Dyoy0Uk8Zeh82qfT?=
 =?us-ascii?Q?OemDpG45g6A0HB9mItpjey86rt+UMWSItDSeODzoa9uPfSUkxOkun7mem43x?=
 =?us-ascii?Q?9HP8Uyy0Wv3BYFAwQSnoSxvTBESn2HKsF6WaHiFHTslXoa06LIzWA17iQ8dT?=
 =?us-ascii?Q?SoZ3pK1xuMaMfGhLEQxdqbH5egAbGKPYflawkrOaMtEH1z5gLDVkhABeNoQ+?=
 =?us-ascii?Q?KB0RjLsP7RZWei+7o3XQ9o1pnYA6q0X2TjjzFxVCfc+u5B8ud+Byshqn9VXp?=
 =?us-ascii?Q?p3Vb733L7r6j3ffJ19gyOSaKNsGQF2V89BL24DpKtNI2ipuOLWnr6EOw/G9i?=
 =?us-ascii?Q?eqoJpZxvEiqaX3qIhIP/W+YXeIAddu+ihAvLqjCOIzHvzc2DrysMrddhDcg3?=
 =?us-ascii?Q?T2KL1lYqjzVU5MwRhPmoUPI9WITY9163gRXQ+OB9RlIRLN5R6xkV8fFFbYPo?=
 =?us-ascii?Q?u0knCo/P/fXBVlooQeuL3NSIivUDo48PZ6HHgv6D1Sf8XjEsh1VKlDNsEr4R?=
 =?us-ascii?Q?tYZCv1ny0T0MQGwtJiTNpVp5WijcsxYuV5kBJ3wcPLMCb3/icww/onUQSoN6?=
 =?us-ascii?Q?/cfT9FqChYVsttHwta5wA1jUYSwR/ynqCrw4I58cx6AmFOiOg8ROFdyxHkAN?=
 =?us-ascii?Q?W0TeECaVKarqicJNXOJ4AA1De4v4aV1IOGnfY44ceb6UkU88jthG4Z0uYq04?=
 =?us-ascii?Q?9MjtGA7Gssu0lTTY/me1DoOl9Fzya9rKwyLdHpVSj31Zppsi+1iC6pnC8tyE?=
 =?us-ascii?Q?DP4iMS4yhcgwO3p9A28GmuA1eGR72HdYNKxfK+US04id0Ky1bvdvsrk0GmQ3?=
 =?us-ascii?Q?CMiy0ynOeWmCCbgZONIMUT1S01Ze5bx5FLCEFlaBbPaNbHnfovCrKxYCpwJQ?=
 =?us-ascii?Q?ufxSwkPsM+GTVhlx1KKZpcKb5pwny2gDqIFnO7tLufpp18CDjbdiDC6oiUCM?=
 =?us-ascii?Q?Bo7c2TlLmsG3N31ljACYlee98r++vzTvkVVVOUbdMPb1MmwoYhIYc50X72lm?=
 =?us-ascii?Q?G8x+HtwV7fCoHDiUszVAqnuQ6uEnij4KhlxJN5mQPVUDX1EOkR601oPeHylb?=
 =?us-ascii?Q?vOBBhhzhxTdT501ckph67Ys+wxo9Rxc/QXpebilG8RxvULpc7piJsdXNLQto?=
 =?us-ascii?Q?G7NcSCi+kn+OxnMhMTfcwk8cVix5Lsa9zMrDmPQZ0KK33zRA+a/bttgLv9CK?=
 =?us-ascii?Q?acWXxzhnfbr1TSAb4UqkQgkAw7Q0FA1DqVYPWNNeaIxFIrGykKIfnQTXQbfK?=
 =?us-ascii?Q?e9+NthSw4mkqSSmh79ZUMAsWy/3MkGoeF3vadX2wRVvrfFkcq7IsE5SKyanR?=
 =?us-ascii?Q?oEBxXSvwPiaGmmw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4nXoX+99BKLANSomjhUzbVliVH/JI+0lGACnZ/xcqfy82iCdk50pyxTRUTZ?=
 =?us-ascii?Q?BGnFJ2aEb3hxL6b+A5drlsEU90OYaSq+z8P+/+1W8cWkS0VDbTf6WZGzoLmG?=
 =?us-ascii?Q?JIjigowW5VF0UMYZFzt9YMXC0ukMOSpkdYre3IoPyIgeCaWKZv5XWvutcHf+?=
 =?us-ascii?Q?G3pHKf96s5wDWp79ysmg4IU/t4ue9rFfzZniAn3g0gOPsD6MYhfomME2bEbL?=
 =?us-ascii?Q?EmqilNGJMgvpiX3x/E4XsIxvE7ISSB81Bf8dkYCWZJsltPbVCVEa4C3Lm7wD?=
 =?us-ascii?Q?1NQarhvxuIIJJhqbh24TPgHi1gb/1qmO5ySw3LdHLuBmo8aaxLyk0HZVVTbA?=
 =?us-ascii?Q?sYSbE15kqZ02BCXRjkKgrFP73rm5Al1rQS6vgDJLUsAOHElU0X4P3/52+m/u?=
 =?us-ascii?Q?4Yjb4oLtDkyPFbmDDYgUtSWeCOdUJQeMLNboillOoOsS6HlPKLlpqdfylSXB?=
 =?us-ascii?Q?8xDU6lueLHFqyYkzOXMTTC6AFZo2Hy+kr02FFkamxD+wPVMG/AsYGf9Y5ocL?=
 =?us-ascii?Q?hSNTYjJYGMYeaeUM8E7F956+Z44hYNJeBCW/bhz2P7Lex3mgo8cdsEc2ncX6?=
 =?us-ascii?Q?7CEHY+We4ML9KXk7nUMmOO2lsSo3lanox4ES+JZ/38xj4EutAaBuJE++hgUe?=
 =?us-ascii?Q?dPocG3ive3Uuai4cPYpgPOKlVOsRMH909EGbEZOCS7/ndFpcgT5jaBaJwCIJ?=
 =?us-ascii?Q?BaFT03nOT/Bs/qEMTtQdOtjtPiYUIcLafH1opOVCXavBRgqRSdS9K+zqt9I1?=
 =?us-ascii?Q?NbJYOxZo6Gr+g1xaEdbph1ntj8oKad5av7crgR+AsgLGeAjTfvXdZ9zeTCVj?=
 =?us-ascii?Q?8g0JZWaqcs2aSnH0ppmP6bhB3H25TkQlJaso7+upZ632ypBBium7YDLuDP6d?=
 =?us-ascii?Q?ZvMXqtIxBHsdUro6FzM9vHmdeUdz+qbPnhYbZZwWxK+43AUnpP2MBypuHzqq?=
 =?us-ascii?Q?Z9Pte2DLZop7RrbG3lbhP6+qDnM9g4fF/2MHh2qVIpr3buBZp3+vS+/mVSM1?=
 =?us-ascii?Q?CT31b23QpJi5r5RrQCqCeuewX5fJ9F7o4O04K9eiAaOibdDIw5B/0s8tLqKA?=
 =?us-ascii?Q?VQU9XhZ971un441PuebKhb6wYzVb2l4cMnMLZwKoV5UTm3Y/yJWVaSbifWnP?=
 =?us-ascii?Q?BXMN3R6quHh1zLEFgP3d2ixDyLF5O5ig6LCHyFCOKngRTbxpX2kyuQLQzVwE?=
 =?us-ascii?Q?OkrzsUHmThaez4cfHa0NS5QOtSxbQETW9AWUsOhDbBZiI91dk01kwf5VDHIW?=
 =?us-ascii?Q?mtyPnrHLafWpZ+5HyyPT5xCyPIMWmap97bvs39bCfJUCHJqwpDQhCblVTP5A?=
 =?us-ascii?Q?2wErjbmizebX+bwwc2MX1/uTR6o2a00CLdY8LNcNjD3svNgJaxJXUy83N7Dj?=
 =?us-ascii?Q?9EAMpnV9wlN3Ec0YXm7JIs1VwrI6BcTMfk3pYsEZTAAAu/j/jjpVhGvGRhtp?=
 =?us-ascii?Q?YtjPuUDZVfldUaX8l4VJyjUU9a33NxxnFlTYJMZtnmxzJtpexJ4tUhE5QVFd?=
 =?us-ascii?Q?xr9XRwmb+2/qWldRv/5kVuFnns0dqP/OMgzYb9gQ012nVYi3fT4Z7XZ+xbif?=
 =?us-ascii?Q?kXQUR+Phr63l6MRo4hehzvaq+i4ETaql93fEwE095GgXqO1J7dWDN4WL4fzf?=
 =?us-ascii?Q?LTXSoCZjnZucyl3+GzNO4pw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10ff6d2-0b14-488a-5839-08ddaa06c9dd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:49.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5c3DjdgGnX7UXzY4Qoo1SN9xDZjoV7PmNJzWjk6GeQlNSkF+7Z9gZPlHcHPR5XB0xxYxVwWOireXrOGxbcRSX5JOwaQzVBILcczBIkG1+4WI1SOiTFrbczg7ogwHQQTq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9364

The EINJv2 set_error_type_with_address structure has a flex array
to hold the component IDs and syndrome values used when injecting
multiple errors at once.

Discover the size of this array by taking the address from the
ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS entry in the EINJ table
and reading the BIOS copy of the structure.

Derive the maximum number of components from the length field
in the einjv2_extension_struct at the end of the BIOS copy.

Map the whole of the structure into kernel memory (and unmap
on module unload).

[Tony: Code unchanged from Zaid's original. New commit message]

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index e74281f5044e..08cac48293a2 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -107,6 +107,7 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static u32 max_nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -177,6 +178,7 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
+static u32 v5param_size;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -301,11 +303,31 @@ static void __iomem *einj_get_parameter_address(void)
 		struct set_error_type_with_address v5param;
 		struct set_error_type_with_address __iomem *p;
 
+		v5param_size = sizeof(v5param);
 		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
 		if (p) {
-			memcpy_fromio(&v5param, p, sizeof(v5param));
+			int offset, len;
+
+			memcpy_fromio(&v5param, p, v5param_size);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, &v5param);
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param.einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				max_nr_components = (len - offset) /
+						sizeof(v5param.einjv2_struct.component_arr[0]);
+				/*
+				 * The first call to acpi_os_map_iomem above does not include the
+				 * component array, instead it is used to read and calculate maximum
+				 * number of components supported by the system. Below, the mapping
+				 * is expanded to include the component array.
+				 */
+				acpi_os_unmap_iomem(p, v5param_size);
+				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
+				v5param_size = offset + struct_size(&v5param.einjv2_struct,
+					component_arr, max_nr_components);
+				p = acpi_os_map_iomem(pa_v5, v5param_size);
+			}
 			return p;
 		}
 	}
@@ -932,7 +954,7 @@ static void __exit einj_remove(struct faux_device *fdev)
 
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
+			v5param_size :
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
-- 
2.43.0


