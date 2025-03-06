Return-Path: <linux-acpi+bounces-11913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3898FA55B12
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193091894836
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397827FE63;
	Thu,  6 Mar 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NcgM6m2d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7627F4D2;
	Thu,  6 Mar 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304929; cv=fail; b=D+uXfjgU+13UML6eT7zHvbA2wVRT6qV5Y7OQ+0xTiSwjxAEYLXvqOuPH6O1bSWXjpx5cRubdWgIytEXkb6qQVod5VfpaZZ011maE4OJENjHrh+8yDZHAe0PhJeDdE6XxpWJ+/WOK/fVtR2VoCFzJfTeuUNF/xqX6eqj3Xqw8Sj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304929; c=relaxed/simple;
	bh=G8KR6mXK/za5F1cxMoKSljSBlc31VDqxrVCOjshrNb4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJ80+AAFZiTTLfIl3sjiqs7fNcxCS1X3SXzKRvduCEa/QAf5FmNX6rbLHBseDRi5eWsPHGlbAiDG4Umd10xESHdDNG3h3nke9ZpgfbfUggVlS8H6W8PNCTZttMQnyH3G5SaSP+tnxgB4EnbebiR3Ojbnwgtb5tWtoZtj5mrbMSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NcgM6m2d; arc=fail smtp.client-ip=40.107.223.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfHOgrFzlcIquA8XG8wneuV1xFnwTrMYnFgiF/7O8KBHYT6Y1VnQE3Kuq8ghxBqWcEi4p6zzVZnwPKe41PAJtOXnDREQq4kHLp+i5sxiyrcbnLvZtCE13oX6iUVI/1GVOCBRnk3fLJrFD/RtXjhDvzwVOSxL+lqg5FEVjCn0DAH46Vo9h0i8FEfwpbPWZqz5pP0+gf1SRdWEAUinm2ESoH1sHMh/HLCf6a4CvIp6HhkIi1E+AMyLPV2F+qv9xwhSMTTbker7Rsaeu4RdaVod1/kDO9gLkCoUAtez4W15P6U2T8aGZPxfrZQUEvDbwtBRRK+kgH40ssWUCTFRyVmLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8PmLEnnZgHvvLPsNY6IgLpuHEDH3FwMcehILRkWA3o=;
 b=a10Rft11iDBI7sueZLBMR/civHbyTdrmAgODB4JKkRRlpDyhmSJNil6bQIyVmUh6PXc3+Lsd5OJM0GviewET0kFA/QfQG+g8UYz2mxLC1k5Fca73yXrfgSkYnxyB0JwtPIN5KZjJecxn1e0/57O4IcLrQ8H2Tb9ZQopH0HDwaa3gGYLIFN10MtkqGVLCQy5mrY5BnaTDwBkdRgIWA1WhCMOULbAezE3NodDQWy3jsHkROwLr24RILnRHve/j2TK7kxjMTkKAX+RQiEJn6zLBq9v+3lw9xUN5HPWWjFbsiMbJtHDyAeCmhawzl1Lr+Om1dg9SjQvUo+QG58j5niA9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8PmLEnnZgHvvLPsNY6IgLpuHEDH3FwMcehILRkWA3o=;
 b=NcgM6m2dWe4M8q1YYrhf5hBjIefhPwAk7Ri+GwpdNTMQnPEdTSUv9bnnTxF4mAdPddkYepwKFBIcwK92Rcb+Ts3/Vu/kNRKEqfpWNiUsY5C2usY18nJR8CYDmLCe34VkpnrE1PovuZWgnOHhrdpSms2M00srlMBhB4yJ2LIBcnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:45 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:45 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	dan.j.williams@intel.com,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk,
	arnd@arndb.de,
	ira.weiny@intel.com,
	dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Thu,  6 Mar 2025 15:48:05 -0800
Message-Id: <20250306234810.75511-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DM4PR01MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: f558addd-9a49-461d-86f7-08dd5d096eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrF5wHxM2+B919qiWee7hZKKWle0x23IGQueNCLqA6w0Mzq8SgYSxPMMFUCb?=
 =?us-ascii?Q?rVCvfTMOyKIirA99N0pyBnleTC8KJ0BMwjRbp9u28dDknR8VQ6FyZ7o6b9cX?=
 =?us-ascii?Q?cYpTy+VCBL9gU4K10henvi+edAIUahjEUFu7rEYQf7PVzUZMG8f4KPy+BKyk?=
 =?us-ascii?Q?xEwI7kPi61nZgFuwyQkXC98cz08MuYWNpkO6IfS/mTTb7+P74DBPLCWVzDIC?=
 =?us-ascii?Q?9LzIVCUq17NeKZdCLWa6PQZGeZ+tlQGupcwiR9Q2O2xFgcfy1qNJh6bu++Kl?=
 =?us-ascii?Q?vR0krHKyFxEYI56z+kMcu8o+iV6CfUVDDoLS5CIlvgnsVRJRQ6FaHwt6p8ia?=
 =?us-ascii?Q?pd/lveMHeDDuAb3vnB3NCRBUBAjsGutQMvDgQKtyZy7uTWv2z3MA6fpxslWR?=
 =?us-ascii?Q?wEjvC0QuM7ntBAUHnk0+FHeCt8BsN0vloZCq+kD+7pMaWGDh/b1mhh65a4WB?=
 =?us-ascii?Q?OSHIWYvGFNB856j9cKC2tpy1CLBIXK4+iAiRTF2rawGyHD4nu0qjCzAwyvei?=
 =?us-ascii?Q?Iu/3pMA3rdYr5d7ZVriiFRkBLq8p1dFFklALPBKxazApYPw00n8McBJNikiT?=
 =?us-ascii?Q?qV8f2UzVm0Hav59STjR1DYsQccyXWX84dTxQoVo+6KE1gBtXFpljqJSDGoSj?=
 =?us-ascii?Q?MDzC/zLBUyuns54E6THinhBJWLxODBbwuDzTwukMD9qx2UDKQQnipopPu0kp?=
 =?us-ascii?Q?6WdCLrmq9WhZEF1k0pNkTwt0S7/dM2ysS/tqNQGJPasUePGekLKAPn+0QjSo?=
 =?us-ascii?Q?jrFu0yQwYNaLc0VJPXhSJm5VFx7HmxYnVpIgelcYFAt0g9jaCUbFcB2goRQH?=
 =?us-ascii?Q?QVIahFgL5LPcAj3FeSygC0FuzlIu3zQ8R11g4zxb9gcBf3w2UNdKZ/34B9Ht?=
 =?us-ascii?Q?hOnb/K0TEpVpilStsEwJIXPuBzTg8WvwVNR9v2lh4pigz2K2U6pBNqotLlkv?=
 =?us-ascii?Q?6flSmU/snKyAl6+H9E1x36YGkut+r8fpSCQ6q27DCbLi7GFZnxitogrdiT0s?=
 =?us-ascii?Q?B7KYvsZMw3yJmqv/HrCUKD1wY6pm+HILTL+YoJYFFwgv9kqe0GuIbNRoHbCh?=
 =?us-ascii?Q?X7IpzVtm3alJgGMqaPxLiEeIOQwaI7s71x5T0ro70wlYGLTYoEogmoJq1dmD?=
 =?us-ascii?Q?UFMnrfJIkF9PjwgAzw3BncCwFsNBfTENIwQWEJ63eZEsBkbGqh6A5dh1ueLf?=
 =?us-ascii?Q?ZGXEcP9s7IQ/fAHsfNTCiSdIhJko8OZTobww2/+y1jcWW8ZWxvGZhVWUdrxQ?=
 =?us-ascii?Q?GJ8mHdw6x1nILqq9S6JSjmObAcqayeP8Pg4DwGYwoviqHQsToVEAJ+4HmGgK?=
 =?us-ascii?Q?6Lr9TYufvFtOp77oy8MBLimKWKbV93aWulccUASw1Y2/W0FD6sXZ4aj9ZSp+?=
 =?us-ascii?Q?gHiZkcLqd3zo+1WW2OWIL2PJc2TfuCQLpm+78DKKi8R4gL6ve3xWAZsxFOmj?=
 =?us-ascii?Q?OdEsZwhh0nNqEuCM+Idr/+aEye9RvwNg15VsMzm3LrrsMk5NxC6TyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HpInN6OR2nhZpw5Ide17gSv6wKuRyKZOl279vvwOoYYRSoG0ba9CoD6zAAFx?=
 =?us-ascii?Q?28+xSuw2xot88ruUbyKweXTCIJWXwpfELLHOzHHK0LO4gvkSOATPTG+yMtGn?=
 =?us-ascii?Q?pa6nicEKB/oROruvTj2lzYAORvNGC1PRIsRWZJShnaeUEv7jbIek+4ozCqzc?=
 =?us-ascii?Q?S0Zw3x+k3oC7U5XIrnAZbpPvt3I/IeULqDGYPzPpKK4QEWkxVzPhVGTvztcM?=
 =?us-ascii?Q?CZZ8eMBiQ6c5PFzRT1eIBt6iUQPXMq+EBTRBk87UeuLHpPbxDQDUhwRewwzj?=
 =?us-ascii?Q?/vU33170cHh6ne/GpDomQP6q8rn7/OjajTIiJiZp628e9Wim/tC0eHfgnEI0?=
 =?us-ascii?Q?71c3kRHNWuhwdf7CqsuDte5O3rpcZE4NVJSAVYGxdUs8B9PRUisngkafeSlD?=
 =?us-ascii?Q?kwEc6H5RAxRiiZhcnQnj1toTO7Z7KFr+LOUPpFLo9uRCeNectITtCOKebiyb?=
 =?us-ascii?Q?p87h0imHhVhGl+ut/TlRinu7vX4pxhG9EMw4cfOdL8u90p7mRA2969SvHcfW?=
 =?us-ascii?Q?HaGBQNu7WeXW4DOUDCGGxeQuvn7mSKXHJGT970u3t30lsbvgKzuS2M96lS41?=
 =?us-ascii?Q?DK+Q6nfBtJfPRhEcjujGtFGAWlrUXaGDrHxwFp7J7qeVHUQk4eR4wKmZly79?=
 =?us-ascii?Q?earW7pT96u+5RKwtx/jpsLOKnv1517GfakHeh69+PQOcHQ+AnskCDMwtFuAn?=
 =?us-ascii?Q?BcAp4b943Em9w2QhNcQ2c8W2SOXdywH1lmxELdrlQbAfVUY9hkyFSL+Lx3oO?=
 =?us-ascii?Q?IeyNOmxSkN4t5NoYHE4bQY0MpEEcACLCSHawaYRun17h8UOFbPD6dqqhR0lg?=
 =?us-ascii?Q?1ISNdalBRZvXX7Avzq4taCGZYeXRqigktkDjWtkOT79ELcEygJQ99FNwAtVZ?=
 =?us-ascii?Q?RS847/oXdzsYjBhE7DRJ+gMdphaBKMvmUw+OlZmA8OPOVNx5qg3pPNi0g80N?=
 =?us-ascii?Q?wsj1eZFc4NWqRVN8QGZFTNrul+TQmEI4Skg+Ui52LwWPDeKY0S7PweF/k8Em?=
 =?us-ascii?Q?SQDQccrjRcrFpqXiAjWkocdzEqeiVnS//L6xEOuK64sg0cOMYPv+bcNJeaIz?=
 =?us-ascii?Q?ToRH4GBSzPeZ6VFd1rPQaZhM0zwItDV85/5V7VX2TpMXZm/lPDKBvaxn8X2D?=
 =?us-ascii?Q?Y7od9Ieim7dv4h67RYmQh5c7rGtNJgngyjcW3gg8bhPU98q6wbilZTm9QZVV?=
 =?us-ascii?Q?2JsFN21i6fgPxbZkgc+kmd4TWM5UBbe7DkM7/fnErVKs+slmLw6zj3ABnWcL?=
 =?us-ascii?Q?MdXWqwfk9Ax6EuEHX+CC9DACwaWJs0UPB9e6SlCr29uJEH4wPQ7nXfewxCnL?=
 =?us-ascii?Q?CHxpizA4MAfMhT/RR/JgJRJuhd77dgC8fqI/eCAZNkt3is3PXaSGYo7xJTyn?=
 =?us-ascii?Q?MUHhjlP++J8U9uLK9j68pQ7i6iaPS0REu6hcvci5mS2XC5mLQPAXB8EfgzaO?=
 =?us-ascii?Q?uFRnmr+kehuCwaGZPYD5JLNW2tZPyAHLp6E4hAbjMrTlA75CISUyClVnigNq?=
 =?us-ascii?Q?k3C9DQQMdq81vgBr+2keBIiTuit6CLWBP1cB0BUy6L+fAr2V9/JMI/N6GluG?=
 =?us-ascii?Q?OjPktJggyHXCoMM2eMn5YKJhI6pUSlNXQ9OlFI7RuYLl55If/kMLHHkqtpwq?=
 =?us-ascii?Q?0UQgAioUYIsE/5oxXwwyV/Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f558addd-9a49-461d-86f7-08dd5d096eb0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:45.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G3yhnIA6PHky406KGOB4u6mOsLO25fFu0PvYkWUxVKUl95WeTG/fDU5HW2QjXj0Dgz5DadoIncdLM6AR6xhCP54oGN3hsZmH1AR+8Z7v1xwQEt+CWc6f8jhfY/H6/5+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

A single call to einj_get_available_error_type in init function is
sufficient to save the return value in a global variable to be used
later in various places in the code. This commit does not introduce
any functional changes, but only removing unnecessary redundant
function calls.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/einj-core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index b40ed44c4983..3f828f9265a8 100644
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
2.46.0


