Return-Path: <linux-acpi+bounces-5924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F08CB52A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF191C210D6
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84114B090;
	Tue, 21 May 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IC2O5HyL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28B14AD22;
	Tue, 21 May 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325866; cv=fail; b=VqKTRRZSJTFZP2q9dqgQuXry1+Nqvuimpl/0QU3SHHW8mhpzcDqXjcn9aIaGSY9K+pWJ+cDHjekNykxqZ32G5L5mJRtp1V7F7udrqzIf+m2F+0Sb6qAlUaGe6jv0z5xpco6m7buZidA5USJy3fSCC0200yhM2vdVYvxi/mQleSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325866; c=relaxed/simple;
	bh=uq4IcG5HCUE6QdyCtbz4oaLKnF3G+5PpH4r1x4ry7mE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFeDUp3ijmi9gzk2gfvTSrcIZmaF/JX0XGTSEASPlyUJ+Gu7viLN3cccpPKe0+DE2pScOK/OK5LksX/d5yfZz6JG/mekHWJwPo68JUtKlHmPSu+sbOPfgNZpFZxjRXOSyqY6ASoXZXqZwZyDeyBN6EJ2H+GAWNRpCe2Bk2zS4V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IC2O5HyL; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV+2ey1qVQJg2+n74RL2+vxnAKtuvEohSLq8KtLx/gVbO+YyI+Dbu6HJ5xXl7uDOQ28ao1PfozehTzm/FNiEdAuFrJ7Eg6+K96rtq/TGE/+7cAhUBOMPOIcSN8Zy73LbHUj/JrE5ZYKN4nCp/3dbqBZvzHwBrHw229jiwi5ZfiYXeeNf3bvHgtVCEwhZrpzjBwa50rbH76Oq3lbobA4oOsz9ieVMbtvFdxlrDZlWt10GoUmrafdPj2+KprQuF8kZzDCy1wcG1FzYcDHzBTvDOB7FyaaAjrULtYOmF2E3cdi1zMt/JkZ/JnJrEU/UOlJXOsHarg6nYS4FJO7vaW9qWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwjgzv4Ksp5Toqvjs3j2OOVbu3Qc9B3qpD9jb0eEpIg=;
 b=WVzGmeWkl+I0YrSEgP0Mye+zIXyD6lo19wkfdTbz8Ygz2kaASkCT02y/emHd2p3fa6ghPW0jGFAapkZOI38opSUmQ57BlJfFxN/QOO360yGkDM99AvaD4zNsssoqVQWT5WwM9SAzWeD83qaVgel8m4oJOiJfZqmbRIa//i/PZJ59CSOLrDB9zXE2pVG/uB1Cbs1zK9qNw4aF+XeMVvJzIKOVquTaD6LwbMjidzQHB0VjKwZl6cMSiXoT8vcnpsbpT9x78xGDnVK8tuY/xXa1pD3O9JOsFqWC3HJ2g/DxNSPNlN8REI3Lrjicda9iIUotItszdSpDyyPnUpBIw+RG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwjgzv4Ksp5Toqvjs3j2OOVbu3Qc9B3qpD9jb0eEpIg=;
 b=IC2O5HyL/TUJdLl8W2OhpVSmgqDImni7pFWI40ZP2Zta3M4/WDuxh0BiarpzDXEdTxDFlYmocagEDw2KJw646qxYN9pd2sbEEU8CL8ibBnC4xKqvWqn6Wyr1N2IgA3ScsuaycgzqWyerqHMGsmfk4Fufi0rePp3qK9WGilxbshw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:10:58 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:10:58 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH v2 3/8] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Tue, 21 May 2024 14:10:31 -0700
Message-Id: <20240521211036.227674-4-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MW6PR01MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff43bb5-8961-4345-07f8-08dc79da82f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tb+bNbfhamn2r7c3cCktcPhfvubbPGG83EwUrSAt5STzNV9zGzZAT6dNW8Yn?=
 =?us-ascii?Q?l4o3V2xRVd9nkOiL5M73gzcCeEn2h8kMAxc8j7aBL1TesqhD/DAqn3cq6ixt?=
 =?us-ascii?Q?rJexEdxXo3v+LexYn8ex2QB+WaFIs9gYWqprKbXKywdb3ZtVsjnQKjQWm0Wi?=
 =?us-ascii?Q?LC8kjQSQJmA1R4K4nD4zCSc/P/witW9ZuI/I9xi5Ml4AWBaFKViQOMgEELFq?=
 =?us-ascii?Q?wjb+JzGR4FCqcZQa+o/l53z1TqZgOqXRe1J0ry6tigj5n+Knxj49yVpUuwx7?=
 =?us-ascii?Q?rX49af2bombLkZwp1m2jfPxldNlSqmd7OHdkaZhznxdO3LsOY5qcuK6eTvdE?=
 =?us-ascii?Q?me1coXdx60eRFGH4RaqsNt2X24Y4R6680rTnl7zl1HxIeAih3exo/6c6iTEF?=
 =?us-ascii?Q?6R3I36WWAPtJW/OMaLZioM/rSffGmimykafE9ey55d7rR2n6x4Rbdz1HFl4k?=
 =?us-ascii?Q?3MxfWNEq5no/oAe6hSuDnm7H34q2VMBHAmRNapUBv+OKbMm/UjJHU4DyeSQA?=
 =?us-ascii?Q?ygb/GEcSB5XMYl+a9TmaQChdvwI+TuhSMxZi4n5aoiDfQksKx2ClA/PkuLxn?=
 =?us-ascii?Q?AfLCLiet+pVK6NYLY6fjGPqyNCKqpNhqtJRfZdlB+vicFW7KXW8CfuxCdJWx?=
 =?us-ascii?Q?gqhMH1WqYCxGVdlySbsips9jMXi1Pbw07PjBUaS7QncN67H5c8e5i5syLbAv?=
 =?us-ascii?Q?FENwgbxaLWEneTFob1J4Kbepw3r85TSC2MrPz11K5syBsfwvISBV/utojaDm?=
 =?us-ascii?Q?KD4NJM9AUopXuFhhZrgscbX7o7CZXyEf+Nw7+mUBWmEovBeAztkirOXVOd1+?=
 =?us-ascii?Q?49GVF106wq7pb3EJdRRH4W4hefkvfTh3hHPpZWrqpdd8F3cxxmoGGg7J6Xx6?=
 =?us-ascii?Q?PWHla/a2yBUKGdEKvCpjXIlTBYrYOvZPNzOmQT4D65Jv5bwK2tkPAZMlY1lH?=
 =?us-ascii?Q?MqiAaWoub531U0ri56DCuCrBkA01ckqRJLCgntENscTjHL/BXZVh3bRJRB7w?=
 =?us-ascii?Q?9XaMYwJb8F62jb2TG1ApcA3Ro6nMSUTrIEWsngg6HT2eaAX1U4WHdhUGaK3K?=
 =?us-ascii?Q?2+aFH3Aus3d1f5smDhTwnXvCYkqpG5gjzQMtkHgmPLNNXiAmzuVgtQI7gh6S?=
 =?us-ascii?Q?UZwMvEK/7yleARcU/fSB1NS3zQ3+as0EjMw7O0eWfGkSgV1DEscYNfMovdgd?=
 =?us-ascii?Q?zNUyOvWxf3e0gOFH6eLIBKrXxk0OhLSMlZP/nS1CvWLTBNDx+Hz3Lx45XcIA?=
 =?us-ascii?Q?7EfYHgVgA2VaTXh0bp/pcnkywTtQRDXpBheby+WWGfuBc7ZeUf6zaoPnftuk?=
 =?us-ascii?Q?lmVOG2F6s6lSMpraAh2kotTkIKg9WWlmQe29EhZtnJq1F71oQnXhzCqdCE9G?=
 =?us-ascii?Q?vEmd334=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lg0+DXOT6eZb+ZZaYhkLirVZvAGnOqU0hEidEiGwbLN6RURejCbJO57rQHSE?=
 =?us-ascii?Q?paYa1g1mj+xh6JwpWBhPDxy2IVqAPpscEflcGu8vDXsWf5nbmMapKQG4cNT4?=
 =?us-ascii?Q?UB1sk6qLrOJPZPXLSZpyv9PmlQUSoBUPbV7z4x69GyIOyZSWeGYpQTftv/LR?=
 =?us-ascii?Q?nh8Iuc10ULseqr6MieQccchkXgdu/oCrIHuylKeddBR+stMajnM0w6znazEP?=
 =?us-ascii?Q?ynK+LkfAASdKftQH/K+cZ5nlYQ70fZfmfdtm9JHTKNJHYEuFTCqJNH8b3p/8?=
 =?us-ascii?Q?LL6sK6F8vjIsY2Uuh7ZRDpcW82FlouwNaPldjFsK1LDuVNimIFV5pd25ResP?=
 =?us-ascii?Q?+1DoSJ3ciyfVQbNWLvr40YyHG81nFuNPhWggDsK73I3j4+hFzRo6mZzbHex2?=
 =?us-ascii?Q?tX/HJdsaxhiiYr0lF80vyf1cLx2r+fWIUiIVhyUJz8oFI1cn3AXi9tT8KYRf?=
 =?us-ascii?Q?SWIwEkvCai360nvoQ975Xw0JphWPTTFzvoqc57DOLA6wLKJ4C3uU73+EbDD3?=
 =?us-ascii?Q?su2xAmAFYRPR1+LuYFjvWiQeEahCvIF5+C7gjC/kSFjIhEpbuZB4P1Lhciab?=
 =?us-ascii?Q?DmT2QQMtF6/ftSp5OLcR4eqE4/4hT+vH4xMn4v9ralx/5+iTS6/eAweErZa5?=
 =?us-ascii?Q?N1crmBXyVXHyKpaWfL6St/Mt3zF3GnFiP7TpcgGT7ypPYEjCte2jwYgZgCkV?=
 =?us-ascii?Q?CFZ42tzYDlp3E6tmEuOdaVqHRdyHKKLl2mAHm0YtVcDWpU24bdmko0qqoF4D?=
 =?us-ascii?Q?ggWhP552Tcx4oPH1ZL6tvk8mj+LEYMR0ZxgrMjneuUjk1WIiU/2zZBxOh1GT?=
 =?us-ascii?Q?gL+c4/4gdMkFsvUrQ9zYQ6Y4HTRX9lKW718Z7bH7rBIdCnz1pS/IorpIFSf0?=
 =?us-ascii?Q?EX+Sz5kGB/8zDGGZVZ8G4ntERnSOIFyD+cvjG4j+hYMOc3/M2AcB3FrucRY3?=
 =?us-ascii?Q?ZrZDRLD9FkM+wavGEWhFkcrXNiBTDJaLXJYQLNUHEGDR+94WNStRcb+D2gKi?=
 =?us-ascii?Q?ZkfAvNqJbhGM7FEPtFLCMvZfvX5X0cAK3pJ+7EpPGe/GT5fpA9cWpD8zfB3x?=
 =?us-ascii?Q?iHvhyhknIKhewnmTn4ofUSo2tNb2pwELZNds54jczmqQihK4iUnc8kycuk2x?=
 =?us-ascii?Q?0suYpxhT2apgcLM4YRULbBVAiA9JoDRyj2yvgEXNWLmlqpcoLatpgf8Crbxy?=
 =?us-ascii?Q?3Gx4Ix6/WGPbx4U3Rfb1tj+3SN2msGe7dxir0JN/lXK/eHu9aWXjZAD3Ijze?=
 =?us-ascii?Q?/S558FgyGV05R+ehsUnqFqUM0vRpFBfQ6QqGdc7zlKvRFX7RSngPyUwmZjSX?=
 =?us-ascii?Q?kFH1GFge8XJX7GnaduflC/j5F4BtHt2GBZEvdPF7Jw9wU1i7zYWXkeSCMWHy?=
 =?us-ascii?Q?diU0PLYBsZCWpDufL0Kq6yj2FdFM/QS1rQTRXZO/oOOHFvmMrjYrEuBbkWcQ?=
 =?us-ascii?Q?aYuigVGjU6fcBAx19+MOm5n8NUCrx+FO2w+fgV4CfMYavjfSPEIaGI6oLmu9?=
 =?us-ascii?Q?FmwTY+rR5HlXlPQVPXHughKseQt8hXmNoYG7l3CqunXEbPLP7IUxCMEH+2TV?=
 =?us-ascii?Q?lmw7lWC4MtCPTxsNvbWln29IoQhNAdF8Rs6ucnAsAF63dXEqSe4dv3HuJEEH?=
 =?us-ascii?Q?hO/RRW3d2KDJf6zWTqq52Cw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff43bb5-8961-4345-07f8-08dc79da82f5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:10:58.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF33iHZj/8X5TE4rKsI8AtO7vgsxJKaOv38aBd7MiVIXIEq9qeliMNqMF768eauM2WbPlTw5hvKOub4cJkky1zA83bGjumEYkBgHt6n0f36g6wA9WQZs3miLNrqclofC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

A single call to einj_get_available_error_type in init function is
sufficient to save the return value in a global variable to be used
later in various places in the code. This commit does not introduce
any functional changes, but only removing unnecessary redundant
function calls.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 9515bcfe5e97..b1bbbee9c664 100644
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
@@ -648,14 +650,9 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 
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
 
@@ -678,8 +675,7 @@ bool einj_is_cxl_error_type(u64 type)
 
 int einj_validate_error_type(u64 type)
 {
-	u32 tval, vendor, available_error_type = 0;
-	int rc;
+	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
 	if (type & GENMASK_ULL(63, 32))
@@ -695,13 +691,9 @@ int einj_validate_error_type(u64 type)
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
@@ -777,6 +769,10 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
 
-- 
2.34.1


