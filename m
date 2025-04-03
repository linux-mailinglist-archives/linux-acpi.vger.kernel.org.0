Return-Path: <linux-acpi+bounces-12714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B62A7B246
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EC83B9A4A
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52B1EB9EB;
	Thu,  3 Apr 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UUSM7tyI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142D1E7C28;
	Thu,  3 Apr 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722043; cv=fail; b=NK+DbhjQ8/W7PxFGtjy9OQ2GY0FQX3hx/Jr8N4j52tjK3WpfnwXcTS09bpwYyGmzLD7ktEhxOofa892tZLA0vrWTjCEF211hZxsYPjTowBUuthsGayx0KyqxVu1iNYcIfqe3bDtI3GqIl9RWBzLiq/BgcLVMDpSOJT1QLumLymo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722043; c=relaxed/simple;
	bh=YDQSp9R7+JMkLmQJLGg7mO66m+pzZMMvwOjXOctAby0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R9kDxtPio7FjFlIqWKZTXN9mOYZtRnUoWyxOS5F9XbFAw/RmjtCqSFYFPWHZLZZ8yIUkhLB0OMjiPdSq5pax07fg6oHyZMXblO9stp09B4hqKtuLKxKOBzQyDeX4CSHnWrkzUu0V23cPRnegINlOw3TW9PRLJfxLC7V9MS5iwA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UUSM7tyI; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLxc6HPVYcv/bQERJbnC8LUI2vT0FZ2TlmBSvnbPk6qfuqKGvJJLvZcAtZAfpEhmgvvPjPnn/YmtQX7dxwnn/LvaF7MCuILkN/Ld9IOBuRnvctgWBoN79d3neodkBAiwtemmtLoU5pALhkgos2Z88dLQzEc8WAGdPJ0ohYCX2ZcwNrPHpdgnX16zaQpwjirz5gJpRJ5MvGlX+s3Opu10/4gfLoBxXz1Ovfc+vYiX2IKi1FKKLBsNKmyxObl7+C8lbXvUiHdySA2ND3R7c3cmbbz/8Sih1xrV3VUXzIdRkAgvP+HBAHg5EwKcP/v0B1rczkyIYd5/Q9QyKihqSeOVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwmqqIQL/vrDMoYIKeju7fvcFrp/HmvPD+PE5/qvbO0=;
 b=MZ53pQSVpO53SvWNcae5TJVptBlAKCuTGlBrrHqJ7PFmC8IGhOXzHQETxMarwxGhZZwPc+cIPibe4aZ2v9X+0JInSKFEeTc4GNZi6ouiZ1y8QM7jLQiHsqcj0ZdFynk09K9sFKYIosos8x5t+AydbVQ8PTm3qnSUp94wbCpo9BbsTotJsNHh+MyaepuhlVq3OwZJf/OYAxz8GEfB7bIZMz9Y7nSdnnybsWHp9PTXVoBX4himU4kwtGLto/xVG7IeMbx06K+L0l/tFhDDNPhJRzAG8pdwwMpyW5VXLQCCQmee/SGbQLyyd7tEB4JKjX5qavgBgx9NlablpZQIQJ/Ccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwmqqIQL/vrDMoYIKeju7fvcFrp/HmvPD+PE5/qvbO0=;
 b=UUSM7tyIITjNQ0riInK8hCU+nzKUbSE3kDFrHFDhUCWnqhNrpe/Rh6CCPuObn69jG323g0PmtOQaHa7BUn7SJkhYY+X5BVQhXz9/oIJoQCOTus6srLbnyBIoDRIAd4PW6lWI6PJV90PVqzr0oMlHJxTBsUQX4mwjqlT40DJGxqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:13:57 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:13:57 +0000
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
Subject: [PATCH v5 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Thu,  3 Apr 2025 16:13:34 -0700
Message-ID: <20250403231339.23708-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: eeae6055-214c-45ed-a5f6-08dd73053604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1aVUDx4A9yQaNkX/WNatNPzV+jy6K6ksci5k3yYSMB0tuHGHH06Tsf3E6X/t?=
 =?us-ascii?Q?mJNnUGkd2mQNCAdLwOee7taXO7MVrF15coUoKQOi1wP88z7LSXyreOCLwRnR?=
 =?us-ascii?Q?wd9rGpTVB5KItO3n5bwmutHUTvCsZGi3gRJ2W79oeHRDuCmMWSF0MJA2eIB8?=
 =?us-ascii?Q?hlCthRBkrVtwv/Y+HnDTGVTWAxjJjO8wNIpmcxbGeO2i32foICdSFeB3bp4V?=
 =?us-ascii?Q?Z1n7uHKhRWUkRT6PCn5J4lLMWJnpf/nmEBQjMicdDh4DQzgMvE9ACbSlU05R?=
 =?us-ascii?Q?U7XFwjK8QtaWEbKT4D36fOYG3+xKvHnACqij5X6M0hxDjCq9pgCOZ6+0fw6G?=
 =?us-ascii?Q?++93sQUXkxfDNVVoIiONccSN2Ff/zzMedfhRezR6zNTIDQEtn6laGi6nzZAO?=
 =?us-ascii?Q?dklYPIR1uxdCC9Z014H1i9m5lQ0GxT0EmS5Eax8VtVi5unYBuqgUHYXrzPRH?=
 =?us-ascii?Q?6MlqZRJ77AAeCFjMzDAthwMmxw8N9JExY3tItAagJ8ejg7Sevmd2LK2zn+M3?=
 =?us-ascii?Q?rPF7G5tlPKHkS4iBmumkrMZZqASfCwQzhm4xqTeRfO0+mt15JeIKpgGAkZa5?=
 =?us-ascii?Q?ahi/hX1CvU9MxH7bhQQKewHzWIXuNzOnszQ32TBr/H6ApKvxkfiPvQAjaH6a?=
 =?us-ascii?Q?IqeWcH+qHOQL+Pl9gEITKjcow33Jlvi/iZpMELKyHJ4VXkWMWWeKWTmZHcUl?=
 =?us-ascii?Q?UV/UmnwXtOc0ZeOMV+oR4UEk5Uabm5V0zWEQvh6o2P8pRyn8MF+i6U90lw4H?=
 =?us-ascii?Q?dNY0RH7V2giML/lLuN5WPG73xpUNQ3vZYNLmqzEb7a/e9al9TwcBpXsoOK/E?=
 =?us-ascii?Q?6fX0v2j4o8HtvfIN3JpS0AEiRaK09S96+riUhq2nXGrondPj4vV6GoluDnmq?=
 =?us-ascii?Q?ggdmENESz55n2maWJY40oMT51E3O7PweJfFZbZxfsTMeuwxDHEjdGAiW1gZm?=
 =?us-ascii?Q?h9MpBpwVs/33VzG5RDd2CrHkdMe+y3H/G/Yc+T4lz5oMv7SP5bibiPW7YTRr?=
 =?us-ascii?Q?A7mcq8jDC+dKJ1iAlzPiRXxKUNazUyT3S3x8L6AHLYFC5yzZI2OsCBEPyJOR?=
 =?us-ascii?Q?RhOu4NsR+ECs5nIojS/RJMZ2X/Z6rs5o5AmruLC3kUTPduDngzsTARQ56W2+?=
 =?us-ascii?Q?KD47zFlKFDnlmdNmGhaPXIqTATU25BCYLW47hq2wvcYdJ2Xu89mHM2+vJVg9?=
 =?us-ascii?Q?82w7ohuXkZLvBuo9eIaJ3gmaEyTSZ02Bn+UATRbhbYVrjHm9CCy0Bre1kxO7?=
 =?us-ascii?Q?UYtY90WTu+CvyNVVqE/IzWyAXNmu1LyvAx190RznphFbqGqx4Nm1t2Mxsxyv?=
 =?us-ascii?Q?n+0iBlP6TzpSMME4Y4OgaptTuJTM9kXWeQGBVZgOv3oa7I/aNQ1eQ1Sxxyhv?=
 =?us-ascii?Q?GdIx7cvLldkUArsMzYL8IrC2IEViJ6nP9Wtbzz7lwS6PxjENyAZjpdjboteN?=
 =?us-ascii?Q?vgdWuFIrTvbcdYbU9/50CJAvszbolWZ2omaMGAutUjLXV65gYpUN2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lEk0FGbewhEnkvi04uYDcHCjblty3Z5THME0Kb3yB0X8zlE0svN+JT4l2s07?=
 =?us-ascii?Q?btkrTrhrTHT1yYLocpqjjJ41XVKRUZuXpmBouTFtXE72NByb5Vw0Utax78v2?=
 =?us-ascii?Q?mXTzec6eD/Zs9jsdHE4Y5kaSmfU2EU+BizXm4Rh3Pc6V8p8ffFYJUPSdL2ot?=
 =?us-ascii?Q?XhWt5hg76rHZLzkcVUHZtzwBzHWGy8J1uHmaf5oO57fQ1GtTO4xr9/UPQ9Q6?=
 =?us-ascii?Q?WP+FwkFwDzk2mRjREn736R+J0Nl7ZNbVCv/VMsmzCzUin49WVlsGO3Aybkhy?=
 =?us-ascii?Q?Vhl6ttR1UAyF0mtonEZ+c+0XqMof3EtRJBcQ6KPK2Tv4gN0Hl0zd/1fe0Bs7?=
 =?us-ascii?Q?qJTBRj3axDSlFbMU+PjxkuW/2eg8x3DkHpvv1qmsqDrB2hva/LMgc7M0n9Cn?=
 =?us-ascii?Q?bjYONXMiy7VbEDQkuAbJRBjGpe1RPim8QbNrNjacEAHtlk+KEc295OqOVDEX?=
 =?us-ascii?Q?Yckp6rDi+PZYIjubzthBywkswtmVvE/SVKC7yNF1VVglo9TUMl1itauewc55?=
 =?us-ascii?Q?NwLjqfOAXsnL4oa0I+4pvT8EndbpwiaKx5xpgNGVyPXKojOSdJQTCx/tb7Ga?=
 =?us-ascii?Q?Zv68ZT7JzorNjHPsKtJIpHmBeCxSTBCTZDkbg4XDtdEjiLQC1hhaww34WMAl?=
 =?us-ascii?Q?hMu0bV4+qEeXH4AR0AiLQpw8G//fHGaLYNXAtTDwwct9p+Gb8eoMUwJBDf3S?=
 =?us-ascii?Q?JXV+eqkO9ciCX7Eva6azbHutLdMrF7drLfBA/1JWbefHcU5VrtBLf3yoXB6s?=
 =?us-ascii?Q?ajtleNz22FyKRZXIiPtw43+5PgeZGqNYkG++hpMtZM0n+NFpvX3EYVOYgpKN?=
 =?us-ascii?Q?G24PsXIsgkWjDlZhUDjNsch1Wf7x0oSFtQrdQUDlweGZ30WRgn9dG/fJ0HVk?=
 =?us-ascii?Q?g25LGmYusgOfnKgUbV1/m0Y6bXCMn9w7Jwqjtk3IOnm9S1bUTVYB7bWDe9EA?=
 =?us-ascii?Q?KEn7Cb/54W80jbME8+ChKPGnXla4/hI2dsiHS2btjZ+GzNNIHKGE/MvU5ND3?=
 =?us-ascii?Q?cC0JSn8doeANP+H4FKYVdROQ5yyixRiHlXDz2bM9y/S1EntkrdomL73jm/91?=
 =?us-ascii?Q?7v+DlnJvSjeO9WNjZo37R8mhE4Zr5rcxzBuGFzAlvw9JyGgdL3wUpA3yvL17?=
 =?us-ascii?Q?DrrJd+ANMnm13B6nSODsVs8hSDMOGzZHQYJ14glIOIoVUihUaWAXAyedq+ox?=
 =?us-ascii?Q?x2iCoY8JPZgivg1G/pQUm1xlSBRf92AeHXtp5Q7wLHZ26XpJU60vLpp9GURY?=
 =?us-ascii?Q?LbH33Sg53GJoJJQ2ByPPhY+HRT7vNxFijKl+hZ2yA3SAWz+AvY6YfkK6tCTd?=
 =?us-ascii?Q?PhFvgG4ATDSZxSr5fSkjVUezWnA4bGNa/gZ+04tzzQPduc5f8WzGtGDTMVN8?=
 =?us-ascii?Q?PBfTb7hFU00staicCItN1M+tmQr3gIQjc0guOaR0Ki+pjhKSWB56yJO04BuG?=
 =?us-ascii?Q?vfsjYztCGjW6iFiIJCHG0PMgigLkWuZTM43T32Vlm9jN3tuVGQ709JcSNZTZ?=
 =?us-ascii?Q?qhTtQHylqV8eB2dRmhk3Jt4sphaTQRL5Ldis7ZoVKxBHdo2w0oAdNL7U3VJP?=
 =?us-ascii?Q?GasphWaytWFB1/ep48XgtqS5dEkkBesSZ4XoCWmgtk038Obez3kEObXa80YU?=
 =?us-ascii?Q?KuuQO/ucaPQ+RBDRKpMcQFg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae6055-214c-45ed-a5f6-08dd73053604
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:13:57.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn1irnWO6YqLlqZKUtd335BSGIPe1opCtf+IB/5IN1sTdj4RFpVKi4DS5xjnXF+3Qph1I8tBHEMOj0anjkicD9CVrdZcdYDTMouVorYl9n0Fxm37njMAkM5ZGeovvecN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

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


