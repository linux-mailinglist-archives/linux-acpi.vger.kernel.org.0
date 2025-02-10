Return-Path: <linux-acpi+bounces-10968-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B24ABA2F750
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EEF7A34F2
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F134257AEF;
	Mon, 10 Feb 2025 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eR5k6H97"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020127.outbound.protection.outlook.com [52.101.51.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7B257ACC;
	Mon, 10 Feb 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212654; cv=fail; b=U0Y30c8fUnozLnGgzXaUxfR99A9QcZBQZq7k4SnvuYrBIwWkyQGqqB3W6MHOOeMnoBn4OX714hBA7O0O4HlxO9I9barO5nIzXh4uVPjgQJCAm4crOckUi5RB+DbXf672uA09m/8omXmg0oz5BTa9QrB1Ybvh5M+Rw6GykWzNveo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212654; c=relaxed/simple;
	bh=wb+6zwOUHamv3Lp4FzkLc0EtZR8ybKeZqz9+id0I9Wo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QO5dugk/f80iiwks/TEe8TLUzEJNK545XefBSVh1XYoatXRt8EMMtoSUvntL4GGkYws88Js4GIJe0eQxW3ZFiVHjUBNkoJap7y4I+LtaPK4utb9Ae8pxxN/exivZaomyIdD8+jmV8umT6ObI9UTZvpFDa9jjoqukyDgtdxZ29r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eR5k6H97; arc=fail smtp.client-ip=52.101.51.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRtinojjb68Ntg5aelkEppVVWetOkeIK6V5gNoj0vEUjolZrXFn8abMjlbH5g6HlzZRiXzeFspabLXzQtX/pPDbaFggPrUbde+E3lKVLeaAwW2ss1WIEtjjkCrQTyyFBmz8P0Y+W4E2oOdifw+jpVXPYzsfrUBG8LkOYoe02eIx9PqefRbbatjdg5bW8GGZsec8Jgx5Xcnb7J1Vyv9rkq8LCHaNnM6mRfFNmcz1v//BawuFozofoKeVi2YoH+jiAqZKqyo4s2PKSE9uA1zK7tUV+CmxprT336vWbY0ugiTBisVpXKVRjEmVuhWXbNNtbOcPltuwiMRchAVlbSfKONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGSIynhi4rznCnJ6IboaYGa4qTRUqOLmKGp7pZWG7RQ=;
 b=WK1njGqO2+9wtPvRu/Wyy78VI/SX9Gvj4ycFVY1C1ApcegersbSFiSOdEP7fZH7D3l93m5F5CyXCXXMHA51M7WIZ8giIe82pfJVoK4QpkYvWAfGy7s2Jco8pv5dU9jpR/KH0CkY+t8jHVFBb58Qh+oL9pydi62gy83H3C+mKnriNq8qQFwMavhVZPi3CHrjFVq1znexUG6VyWnS1BOqGZ6UuTNajFdS3fhlexCzoEKYIv7qHgPFRvEUbB09LnlTLeDJxsHmdeB6ihGIdMpd8Fi0S5DwbuW4VFevqhlrjGwcDoxfFvuyUt5MwrQRnyK4tW4dsputU/lMEDSPOoANsYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGSIynhi4rznCnJ6IboaYGa4qTRUqOLmKGp7pZWG7RQ=;
 b=eR5k6H97orypD7lQr1DgMlxESp8M8LCrr1kw97yzxt3ezH+Y4Rz59rXyaNkDRDHh6HgPJPe/G6h+XvY6LWs/UL3JkH9Xh5KWQCQeim+aVJSdNFo55eS3b+lrIaqEPXuOE4movUkkgy53yhEPdQ5kbIBSPcLHKKViL7MnY2vQgYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 LV8PR01MB8678.prod.exchangelabs.com (2603:10b6:408:1ed::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:26 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:26 +0000
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
Subject: [PATCH v3 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Mon, 10 Feb 2025 10:37:00 -0800
Message-Id: <20250210183705.1114624-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|LV8PR01MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8a311d-3242-4383-95cd-08dd4a01f786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKrs8yfaBJ4vpM5M3HJ0vm0/l/pGreSJLx+WVuvE0BbOpKlAL+tlh3neYh/L?=
 =?us-ascii?Q?hbTYDXpmiW56eVl+N9ae/H4UDU1UwHVWCEAEo3X6wIjxUuALyxPUEkwDiNfS?=
 =?us-ascii?Q?DRKtf3A9IlB5ggnN0xcVLrk0TvQMZAjiDSao31m3T41Mb4+LIIlNAkvqkGuS?=
 =?us-ascii?Q?k9diwNdxWTHX5xeTyhI+nnfaCfzmcuY6nYCVxZ59yfYNcJ9WgvtxJh8yd3sS?=
 =?us-ascii?Q?VKW4R4CXdkh5U8Khsf5RFgLxoXCMYQeVXaLIaaGdZCAFjm3fs90stouluvu+?=
 =?us-ascii?Q?tTy3QJLnRzkYgAHSfS56rSccruwnUQ+gV6xqQGHe3Qm2ZFGms4WVHh+m7RH8?=
 =?us-ascii?Q?FSexPiQFD5nrjxIvLxSWAh5rsdh/1nMrRUauEgIBhjPUshK6/KvwRgEw1te1?=
 =?us-ascii?Q?sJIJCzf9+keeMoWcsKagHAjurWT1rWr6K9ZLsEz2GT6l5V/8iPKJpi7zt+sW?=
 =?us-ascii?Q?PG149LQT21qY+4/Lr54XIbvf3XynVxKlgqneI7I96FtZVWreKdzVdImYgQsB?=
 =?us-ascii?Q?zQ4HBq+cNtwSFZX8A+4wh4W/e4aaYKqSTdFGHgy04iipAsaWo9niz+gNDlgO?=
 =?us-ascii?Q?F/1HosA7OA1bAZPm+ocsfiohRHFr567wKgzhmyWimXsCxAL5DGkaK+4ykGw4?=
 =?us-ascii?Q?x9sAuTz1uhlyvwNONPy+JhWKAdkdwWyZPv66/QfmbhgFYoztq3FVIajsYNJj?=
 =?us-ascii?Q?RvNAhhE4e43PxOy9QI2vcYzzNrqoTZdtIdDwcAfTNh0hmZmdxUdrhrIsrTXp?=
 =?us-ascii?Q?WTMiD+vUDv8Gl6ywrsOO1kC3Y3MQJNRPS47OkEVK6Iwm4RKWPHHJNP2bP4xk?=
 =?us-ascii?Q?jIyky2lytQf5YHlMz/9e7vQA8CNAjqxCWAei3Blh0Oylrx/bYNL5KQEHk9p8?=
 =?us-ascii?Q?hHQlDyro0V7VPnkENX1iEmbGt/U5YiWch2x1s7LR3nKVQ8UD7Q5LBOt4L1kk?=
 =?us-ascii?Q?nbyGUNxFry5OSiv35nvftILqCiJ1Ln6CvKd9bw/0pYTus4V7ns8rH2IDdL2M?=
 =?us-ascii?Q?LbUnJC41MUEd3WbCiZGE6bMlTJo1MfXA9miOrHRdUjah+cMfY/bUXoxY3Jux?=
 =?us-ascii?Q?2UYCdwV1xejJl6M10UEzSAuTM4IoSyay9U6sYKee6f+bjXfvnX1UX0Z9hLGA?=
 =?us-ascii?Q?O4DWG9FKr+FSH3Jo/NSne316Cw6LrICJ7crBGvTtu+nYmyxm8FpSpzUgnSMr?=
 =?us-ascii?Q?OTl9Kew3US30mnOgDWfsy4PALUKsUbjcu4B55T+MzcM+JzfK/IMgtswM8oiA?=
 =?us-ascii?Q?GrDr0TacAFzK2t/LFDxjvg/uSRnJMFDlQh2q/b3JRnWaWtGaTm72L7/PvIwx?=
 =?us-ascii?Q?AC6xBk94hFFPx/ec/KjmJUcwJVbq+5JXoUFOEdVAQBS4kM6qVcZ8y39gJNmE?=
 =?us-ascii?Q?QXE1oW5SjOJaXqbvmx7LoW013oLRLwaf4j35Zr3a23kkAiLGM7T+l34ewdPp?=
 =?us-ascii?Q?RFd/9xjf8nsR15duH1Ph60lBOfQ/mQLOWHvLcWCE94kvZUAc8As2lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eyZTdDLexIjvWUTjltXx10dey9HvpQPJo0TJ9OhslNWt1ki1m2XROqE5Kbw6?=
 =?us-ascii?Q?uEsPc+40wyRlkgwNvTBH5K22OltluK/qBWsZzuy7dWOTsqX2G662xtUJfuyl?=
 =?us-ascii?Q?RQj0Y2YhwP1KoQhEU+gjOwIHzaWAGEoeZGY7Dei9vfbRxeWT9yHUIue685am?=
 =?us-ascii?Q?o/9x2qPgMjEGmKFUbiFjUJgUm0G67f0HWX74oXsIOGwIugvTIXFOW3nJBtuQ?=
 =?us-ascii?Q?OaeJsGstixoiiQxEJ5ygbq9hZWRaTSxUOTdhbCGCGsw0//6599KYKcEyqhG8?=
 =?us-ascii?Q?H0R7OpPUyiIFHD1U+eSYh48EbM3cQACATMQuqZ5r9/YjPj1Mc/XOMVOLgLaq?=
 =?us-ascii?Q?nrEO0iHp3zbX8Bqs46EK7jlD6UcbijILV0FDj0Hk5trdT4UZC6ub6MrXw1VB?=
 =?us-ascii?Q?JYxTriqHOe7iTwDIyJLIEZE0eGr2NIORA/Ke45bn5b/EMjrVJfoaLS9k5C0r?=
 =?us-ascii?Q?BfDU9+p8BO71UqbfDg38wuMetkEq2VIqf4hwze7jTVdsbjdPla/P8PekqnQJ?=
 =?us-ascii?Q?R/VUEKkJ5Aj1DICRKgCE0HV06zZmXEmw6r8g2YRXaA8MnDWKcn2PoVH0hErp?=
 =?us-ascii?Q?WorP1bsBdGGYdTff9u+442QjmZDxI6YZzfQISq+ZE8ZRj4F/ehYpHEYzJMMG?=
 =?us-ascii?Q?a/vxjt/IEEHSZQMXOS9Veoyaw+Sbueylw3xC2/fM2mVcCw8yCqeshIOEzBqN?=
 =?us-ascii?Q?iNlCxmNByccMt+ehn9ykBCN4005IxyIXHQrxV55Q/ZO+CahtKntKRugX2fdw?=
 =?us-ascii?Q?uvlNyRxCrora/VRR6S6Fg/NS0NgbI4wJA27ggy+0leb708bGtVsLUCJ0gwt8?=
 =?us-ascii?Q?vRLbcPKkXkohdyCa53rSIEzrMvPxlJVqgR8gxshUOULpFkk8LUp0XVtFbEVH?=
 =?us-ascii?Q?bRiaHLo3ToYz+0gKueA51hIAGcUz+wjgOtQKYTfFcWSGFruSZN5G+N1b/L+6?=
 =?us-ascii?Q?GuUWqJoWlHhU56WBOhtOXTJ+y0hfck9Dm8sZmDUNbWsEkiLVrz5jZ06jmSwC?=
 =?us-ascii?Q?G4FxP6DJ7lMXu1Z+9urVUeequHDN/mHIu2nyFfhc234hZrdW/vp2Hie3ukjo?=
 =?us-ascii?Q?1nEi+LTDO5/MHp6QxnX+eCsqKD78He7UcSuw/vjwWliMzS4RVm8IAXFdi9+p?=
 =?us-ascii?Q?w6rrEOrd7Lj495rYwKXQ89WT+2BYFhquRAQWULb6G0euSlKJtD5s960/JJEP?=
 =?us-ascii?Q?Mp30qQHCajnKaEhuB9gRFra9EnO152ko/lM//UXpxD7RUbZ0ymSUsSt+WYZ8?=
 =?us-ascii?Q?c2sBeCOVNS7D/rzX53VEte2VLYUEUGm2AbNrLXtYCyfq5m5rrahx07FRfbyA?=
 =?us-ascii?Q?R8dgMA7FLQXdVs0pdlddoPklNXt7nOenTG25gzjPC3csU4azjyxD2jkpbtCI?=
 =?us-ascii?Q?k180DFUcVSWC4FEKBZVot2qHnoIXbC9bidIvseqOOZuusVBvKrxRjHfCg4kn?=
 =?us-ascii?Q?+yd1YosrzzMtu6QZxCmlTMNL6QGxRSsae3YL47vvRR/bjDQYI4TBXO4cenkC?=
 =?us-ascii?Q?vR9f4i0yJefUqIXQmeXXXXkT71MEvqsjcDDnjG9N/IOYkdiYZ8Dl9x8/RPcR?=
 =?us-ascii?Q?sm+yP48O+c4sWP8PnpROwVVaXHlnXGhLGLLhgcMn0jsnDDuCuRQdErwDSaaq?=
 =?us-ascii?Q?diMgg198sVE3UHWymYJRYHU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8a311d-3242-4383-95cd-08dd4a01f786
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:26.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mNygkKtPw5PrMYj8PuCbJKr0ugIWnzPpBQew2SAVHAyMDgqltDt6wEX+L+x4CCi6DPVni0j3F828mIqcoZmqlOFzEPFDYTzlZxHcaX3nr3fJ0WKNl5dpZnREzYT3+cb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8678

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
index a28310aacbba..0f65e8bc4c30 100644
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
@@ -665,14 +667,9 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 
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
 
@@ -695,8 +692,7 @@ bool einj_is_cxl_error_type(u64 type)
 
 int einj_validate_error_type(u64 type)
 {
-	u32 tval, vendor, available_error_type = 0;
-	int rc;
+	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
 	if (type & GENMASK_ULL(63, 32))
@@ -712,13 +708,9 @@ int einj_validate_error_type(u64 type)
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
@@ -794,6 +786,10 @@ static int __init einj_probe(struct platform_device *pdev)
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


