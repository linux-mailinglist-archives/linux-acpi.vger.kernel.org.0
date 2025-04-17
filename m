Return-Path: <linux-acpi+bounces-13102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3986A92D09
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6423019E879E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253B21B90F;
	Thu, 17 Apr 2025 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="X5jwVCGp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2C21ADAE;
	Thu, 17 Apr 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927242; cv=fail; b=OJxYqdY2vn4ztvwbfNB+dzdNkFH6+7dHfWEqCVro1GjF2Nkv1oggkU8bqG7p9WB8LbVojsvfTn2zaMvGs8zyEEuNoRAS00EDY4QBPXtYDF2ncdt4lFev/ffKxEfrlfhkUIe1RM/esZUTiC/0mHOCWPjByX3IHGVeZppERzLtvFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927242; c=relaxed/simple;
	bh=+FeQw4Ql1K764YHCLl27B6uJPctl4rabWjWohYjgoqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvMgvgVql7ZUnnNHGIsQoDWJdUv58hABOSGMubnI9g3XLJED4N3GUjxJ+Lo5g2s+7Qbuw6qEIFx6ukXa/YDNZcU91eTFIIhaWO8XbtzKbsYvseFv5OGwkZTLt5IKsjRdYnRGUM0x8mUgS2F8rj1LPwROCr1jBR0Ubo+AhENR+KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=X5jwVCGp; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRg5dWrYsLrLAqcwNSEVTtP2BYSUVZIqwFT0LpE8hq6Kz9DOOaxLsQIpMYg5OM7qslX6zIEFJLj7W6c/9U2hyWeLwV2rybnwkZv9xtFD3nyga62UNAjvtUh4uigKSFKro/aoGdpWvGUWU4cnUsMhtYjITsXD2DHnf/OVvzndG9Va/CQ+t3bp1lth+ZyO5LkvTBnREmRLTQNvgPyA7+5jARV6VcC8eOzUzdGXb/YelI3zY0rieh2mkS/dQLN+i2Oo7ccGZ9/G8VfRDPnxVe6acMFzLblGzaIzjiysU7fur7CFtCp355oBH8HSQ0HNkhLrKjcHrD9gwup2oZkUPgCnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4s9zAKLfpA5cMBdhr7Ndjv1wq90/iZNU52xRnv0I4M=;
 b=MyHxLJ6jE+dJFGaIvOfhOOhBTQeRWZIsyVO58iuyyxHx2M/9cXxdQaKD7HXY3mmhSyzDbM/c+hEPD9CO/aAa3ljMw7LYFEO4f1T9icUO8Ibas6tbGJoxNUwDYDExmLgzuBAbZUdKUaiL3Yk5s9E/RlM5qBixpDbKaGCKPbuWZqcuLiMu+a2awTfebttQ/kCa0Rcpkj5WkXE9XavNcl2owBntXPBGjjVPkXRnNli1LSdHYUymvG21rUC5ECOCNMOXeJ3qLsM8P00u9mK3s5htivu5fS4fQEavAzIuOZ4cCKMoWgsduCytNElI3azRHrZVBiy5t3pRVYK4gP5FoVXb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4s9zAKLfpA5cMBdhr7Ndjv1wq90/iZNU52xRnv0I4M=;
 b=X5jwVCGpg/xpxskOaiQgnpA4/53vE6y8lcMPrnRJD3JFmPktWA8gfmdB/Og/p2F8hrkHEtL1KBuPpov2IuGS43VE3cr/XJ5npY8z92WLlHrFlmk7Ur1xk54gs8UrC/p/HqTDckgsnbEfyLMT1Og6FUHSAMTooaIXZ8nxGBa+bso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB7327.prod.exchangelabs.com (2603:10b6:806:1f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 22:00:36 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:36 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v6 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Thu, 17 Apr 2025 15:00:14 -0700
Message-ID: <20250417220019.27898-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
References: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA1PR01MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 1700a51f-8c91-47a6-6d00-08dd7dfb48a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOcJ7ij2vuJWF62f+yxfuCHVukF8jauCY1G/5udnuCXAeLlxqKLwjiV+eV4r?=
 =?us-ascii?Q?ubs2CU04VYXdvEiRWXQkBT/vgE4zle9e2T4OsCTlTbw5wfNuVz5SyxOiECC8?=
 =?us-ascii?Q?lKefZgHKd4FaNBo1BkL2BdQ9xmlpnr202Hcj7E4wwKRtzWhdMmjvAfT3hE4Y?=
 =?us-ascii?Q?NQJEGcoLdV6vXP/aBDgtK1uOiqIHPNkmGAdBDfgldoKudWi4ZrtbufbLFqrC?=
 =?us-ascii?Q?mfd5tqz085Wa56IKYK7xVgD2DEoeUCl5BFZngeBJ3zF8gGPXjI+njAcHZ7zd?=
 =?us-ascii?Q?YFBLiCLV8a7EVSenewOi7Nzp/yQ4O87hko6932vj1CR2HDlRSYgHhUqoVA2k?=
 =?us-ascii?Q?3G/9KnNVXyA6BMSn6PZW9TDPOT352Og/ILhlXiIMiumoj7/E0VpiZN3dWHw5?=
 =?us-ascii?Q?I1VNGcVyIJMDFtky5wn5SnwWQlkKHDsK0jIV2hByuvIq+qiwitbTu6KdiG8p?=
 =?us-ascii?Q?8A5ZwQzpADE8pawrfMB0jFjuKOhk3/fTHrp53GcM4cvmCYJf+Q4/32UcT0wR?=
 =?us-ascii?Q?TcDuLQjZtfLI+Z3lf1XG8f22wLtjF0cC85C8TzhlYIG9LBwQC96Hw/lf4tjT?=
 =?us-ascii?Q?1pH3h9nDbxwwGV8z40seaNZZQUWdeUy/GMzyPC0wj3/C6Kiw/8ZROY6NYHFE?=
 =?us-ascii?Q?mwxDuC++W2bmuIHQXXK6z++d7NwByMqiqDrFyPE5FVGhHCgBwpl9GsWi29lJ?=
 =?us-ascii?Q?Ce7ngXSN0SG+Ho5aUm6BWBTz6jbmAhTTU4QARmGJN4OPFy5R7CObPEtStWz5?=
 =?us-ascii?Q?BGNG9KDju8ycNWkJ6Lmcf0b2txmKaa6+OuVKI77rTVTlH3sMj+CZ0w7xAP/V?=
 =?us-ascii?Q?QQmTMgr30uzTO3KQDX8mIvQ9VBHjrz+jmIKiYmdpVH/6Hlak1e5XrsMLyVJl?=
 =?us-ascii?Q?Y0h5P1IWT5xuIgQxMHLDze/poPsDkCHDn//BIy2CPbo3nnE5U9yKgvGzknEX?=
 =?us-ascii?Q?u8+G7qvhQ/Rp/2TfpX5yejVF9XNRZraa4oXahHh1v8NQZvE67IQl7WV4wNxl?=
 =?us-ascii?Q?gjL18CTsp/YIaojhvVBMm1lf6Yxs4PtAed8/8VR0Edek0Lf3XS69ls2RF5XK?=
 =?us-ascii?Q?L4pR0abvsTmyozRXS2p4TpZ2TkbA9uYOflH781IYNbUL5fDC8e+hkkdOcY9K?=
 =?us-ascii?Q?rAp87xqNvFtmLcW8FVqjyUnKgTKCITVWaeepm/1yEzroQfceb5qVYyVGKI7c?=
 =?us-ascii?Q?nvHxyHpHe6Aha6jzdVGrzFp0WQKW9615IkbmV4qSaRcsSlxMvPXCfaMQTJ94?=
 =?us-ascii?Q?+b749q9L18Q0Cka3nx5RyiHSMfoHEc2RYfLrJjXKWdY2yu2aDoACgy3SybYY?=
 =?us-ascii?Q?rvSEVzM4C2P+C8jrnuIT09KLzz6tzd/nuNE3Smh/OKv5lEWtYx1DT50AlN3K?=
 =?us-ascii?Q?f5anUFPk2StAgsIFgn+aMyephgTApKPbpgXZYBrjeC+jj3CETlkQ7Q726f/3?=
 =?us-ascii?Q?UL1ok0FFfLj8HZWIPJktjQ6foJVMcPBsZPKtx04jAaUqwv5VQ5Ks2rS7vc9A?=
 =?us-ascii?Q?Z7RnQskn2puCL3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hSezOW90DHxJyCtX9XOaBOq21M/L7Fjsq9lldFcRsSKDnhwr31KpWWUbFWL0?=
 =?us-ascii?Q?n3+nUYKwlLQsCidKACqipiEq0Ug0TZp0cN/4EBt5KlSfSM76Xb6Gq6yST3Bp?=
 =?us-ascii?Q?sNfOBMxDWRhoi2qiZlDKelLfsprd3MZmg1ASGdRpklG7o/wEB0JVJbFrmWpF?=
 =?us-ascii?Q?+qZGpte2Be9RLFweOiYrPWIcVOfEsRWfgpGEOlaU2n3B534CvjHne6Tc+GUR?=
 =?us-ascii?Q?7NPzHwFFWGfKlZQpN6lCgGLuL8DHV53FsxicQ+h1YPkKl3NlVq4gGvSDXTFP?=
 =?us-ascii?Q?PW/qN5/RztUt2NBi3cO94Vv6G/R8/BMPqhQdyZ87uHkZqhqMMaDoWPLrTL/y?=
 =?us-ascii?Q?9tciA9nSba/fFlPPKABZdeyIFVTfF/pTgCowD2qS5Unlw8z7t5JzvwrhDfzg?=
 =?us-ascii?Q?MmL5HuPE0m/KEarbUHQ/B5FA13sr10AzZc7+1YzL02Atxc+ug0Az/J5gODoX?=
 =?us-ascii?Q?21LHT5SUGdgchSuMqdXSCv2x0o0deNceYcGIuGHJNDpP2Gq6HF4vy7+pmco/?=
 =?us-ascii?Q?wvKblEuCLzJIjjUDXeSj/64C5JwzDFvacmdVv+CXnlG9RvpH6cBx8f7OAZ1P?=
 =?us-ascii?Q?sVfnpzVbGIqAlWwWNsAxKBvYJ8FEUuA5dCY+3pImcFcZJ+jDebzR0tUIgxI8?=
 =?us-ascii?Q?GTe7whU7MiF/hP963mDoei7J86SOdFwSbNU3BU6vAxMwBAqQy2jb5aVxiiWk?=
 =?us-ascii?Q?GpJBpTmZihSgje1iD78hB36hC2BAYYHAAyA2ybC9/87xH8E8njFEsISTVg7h?=
 =?us-ascii?Q?rUsTvUUCB1Lf0vhEPT2QHo4H/J+ZBTNELIA1c01dhg6ZhhzkWQfFftjvhdIK?=
 =?us-ascii?Q?wMx+gxqgtttXM1vaysbG8U5crh9zgpOthb0PumLp7E0rlaEyqiogCKUjceO+?=
 =?us-ascii?Q?DdsF0MTEVo+QFo398Y/pBu7d42ci8cvgi50dhVFlFlmBRP/8+ZRvoTYji53l?=
 =?us-ascii?Q?lM8dJWjWW/OKEqwcXvDZ1+5IGsi662HcoTi++5JkzS3LYhKUtoi7N+r9cTB6?=
 =?us-ascii?Q?/uiH/FGQaXFmIjx38sJABmYcWhPmc414S77lM6nM4jF6JnygwLRhDv7GpBYA?=
 =?us-ascii?Q?KEAD36pY/B99CxDLzOS9xoDaZK9z/u85I6t1JpufAgXdX6Gqe72WOunO8VMG?=
 =?us-ascii?Q?6NoI1y3+U0omLu8CbAORDhqgYxFkpiKy9Y6BytiW3nLOVfWQ0taKLoSwzdjW?=
 =?us-ascii?Q?JFv44b6UHvoUnfikkFVfBPeLrSL7RVxtyxRD/UkrHmSgtZchCmHcmQEgwZL4?=
 =?us-ascii?Q?HiCnGAo5kuF+i9Tv5n4M6AV89n50K5w6nxxyKqwjp+4wFoBgecWoTuflB1cD?=
 =?us-ascii?Q?ykFg5L5Lc8RRmXLbljByGMQlkN5L6ezbazoCKkUgnCCz6sCiZVaojnlGtYI5?=
 =?us-ascii?Q?LoZOZEIQwbvCI4bmKwQEtQ91xv8vtjW+6SwYRy090uj2BUdR+BlC6sgya4H6?=
 =?us-ascii?Q?9hQyLf/uU79hmOaQcy4/HQTFyv7twcV3Z7KO+BRErmxQit25DGG7Gy7hI+UY?=
 =?us-ascii?Q?887k99F7g9qgZB/ZLepu8EJf5e/ZvAhZgcE3mNo6amrAQW0NuQScBwbsxrSN?=
 =?us-ascii?Q?hQthCB31MayMF8GNUTjds4LAmEJ1V79+EfTCnxdXQpML1Z+OlGY7qRUJz1M4?=
 =?us-ascii?Q?hzAcgZNU43+65bl8yIilgsg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1700a51f-8c91-47a6-6d00-08dd7dfb48a9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:36.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmXPOBKF8vVvWuLufil+6O+W4a3PYSDVwfsRjzTgVjo/Q9B7OgiyMku1YzsbiL82kkX85U4HBzu60gaoImLjOaQKTbtU9i10ZB2lIh++TmvuHnidD8HEiqXbg1cj88DC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7327

A single call to einj_get_available_error_type in init function is
sufficient to save the return value in a global variable to be used
later in various places in the code. This commit does not introduce
any functional changes, but only removing unnecessary redundant
function calls.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 47abd9317fef..ada1d7026af5 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -83,6 +83,8 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static u32 available_error_type;
+
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
  * EINJ table through an unpublished extension. Use with caution as
@@ -662,14 +664,9 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
-	int rc;
-	u32 error_type = 0;
 
-	rc = einj_get_available_error_type(&error_type);
-	if (rc)
-		return rc;
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
-		if (error_type & einj_error_type_string[pos].mask)
+		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
 
@@ -692,8 +689,7 @@ bool einj_is_cxl_error_type(u64 type)
 
 int einj_validate_error_type(u64 type)
 {
-	u32 tval, vendor, available_error_type = 0;
-	int rc;
+	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
 	if (type & GENMASK_ULL(63, 32))
@@ -709,13 +705,9 @@ int einj_validate_error_type(u64 type)
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
 		return -EINVAL;
-	if (!vendor) {
-		rc = einj_get_available_error_type(&available_error_type);
-		if (rc)
-			return rc;
+	if (!vendor)
 		if (!(type & available_error_type))
 			return -EINVAL;
-	}
 
 	return 0;
 }
@@ -791,6 +783,10 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
 
-- 
2.43.0


