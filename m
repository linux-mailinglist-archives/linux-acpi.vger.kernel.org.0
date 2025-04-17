Return-Path: <linux-acpi+bounces-13105-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54794A92D10
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D601119E4218
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F2221568;
	Thu, 17 Apr 2025 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="R26q1/Cu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253CB2206A9;
	Thu, 17 Apr 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927248; cv=fail; b=niqZ50hem67M5qlrSCOYBc+TDFa0s4oUrz/h2yHQgd1crNkMFaOlTrTi/3yBSlZXXCvYOELEoTR34v0olJnbCVSHa0yOwnQ1buFNnoKx0sweFMVvZz8AFgT9Dt2+fn9c3AJSkKOzbheDSTUj9uXw80wnzL21Pb5vBW6Lovfd7h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927248; c=relaxed/simple;
	bh=JSSrtsqsRyvX01RBbM8bdvj8Qw0UrOKUtJAUXwQWBgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iX/UHLlFoI4RUZs5H0S38Maem91hrxF9BMgoJ/S8PWVEPbXfNaPfzLMlSjlFPSbqhYqhkVOkttF48o6GRA63JusP/CU6YeUltSxSeE5tZ9oO9uQ8NtxF0G5L49eyVi8E+7XQ3AEQ1cimAqc/bbpZPls/YfcPFuCpVy5lyrKxaK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=R26q1/Cu; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuvYFxXzRfQ2L/UgSRuyYyalW4iBw5sEp19UYN/AX2Z2TqSscfJld4YC0Yy1tGS/hLV2D2CeJ7V0HVraQp3her/5E+xsLwOGHVgdWntlJAJijN52/MltCvQ1MvZHcmbJuDq9Es3z8LX/aPPBMpTykNZi2FSKHIuXOXG+5O6tauiOgxWd/BiC++35kz7AZlKx3ASFex/Rm+LgYjfyJ9GiQqBTzz2d9wCL/qqz33CjUEE6cz8V9IhzK4Gdu2myKxXYkcCspSRrbamFYgWoXfxVxGbFFpDtQUhJrZ9Lb2fEiHsvg8kDhF7lWILo5nGW2RwlD4boU9jjJ1x9oXgt5GHJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLRIkpncdXVbPDJ6s4857M4v3iSy/zEUTPsB9bHH/xc=;
 b=Kz8grtlYW1lQHH7zDKTjBmpeQxKyln40qSFKbTbRIgBZ9Ms32lWEAYSIUGAYhDL83yq9F06TqT5UyAOne7hzFBPtT5yIwi6FnAMk6cc+azwnh+8qDF5AFlwb+/4qRRJ4u++Ftl64TzqtI6DRMT1IQxmDkZRGIKr0jEpOaC/yqAVSrx/jnHLvRUBepyGGeMSbceRnzvc2r1kum+bgMISUPkf6gR2vsFoMznMx3GVjUtl8oGuC4LfdooXanUvZ4yZ5jvtYbGAmS/3J3XaO7t0gtcWE8cZltakLYNUlVihtHe2dh0TfwnFi1sP25LACRe3Ek2hxNTLvDsWi91Haad9UJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLRIkpncdXVbPDJ6s4857M4v3iSy/zEUTPsB9bHH/xc=;
 b=R26q1/Cup2lJ27rmcAJNIYFVBVkXmMXh1x2YgsDxI+2Lj5bTbn+Rfpmi9GkP3epCrYj9kVJBaz+hTPW1v6TUTHarBNEcpTOJkEJyygwLpnFIfEABJn0UnL/EBPmD1Z9wLRhWcZf7JqZ9BX/+PQKkwxUhe8KWs4EWooo7XtM+HKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB7327.prod.exchangelabs.com (2603:10b6:806:1f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 22:00:39 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:39 +0000
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
Subject: [PATCH v6 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Thu, 17 Apr 2025 15:00:16 -0700
Message-ID: <20250417220019.27898-7-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: da6a3a3e-afef-4bfe-8ed3-08dd7dfb4a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2Yzmnw6Z+MzJIKvCc+PNDYagslmYOukBn0i8ZBQx8YMfGqa5Jw9NIvme84M?=
 =?us-ascii?Q?nSZYtlv+XyfkLGiUYBO7OsoUAZITgLrr5aQIIOqOxg/WTNwhiAqCySp1ERTm?=
 =?us-ascii?Q?rKIlPQsD/uLMON4H4yibLf1OpF077b+K5XBX9e4XqaMsZwX/rB9wuy1TeViG?=
 =?us-ascii?Q?lWrXle85kKFZ8gklhvd3GoE0xmT4li0RrTmW0UnHUKcf38zS47p8Z5sEWe5o?=
 =?us-ascii?Q?AoGc++EW95o+FyCnTjrv1y55j6cZscFrAWmXFQ/juVL0wk3DX9pPTnV4LAZl?=
 =?us-ascii?Q?QBKbrCbU3DOSPMMh/NjhvFSJQw5wFyRoUgU225kSCgqs0S+ZWljXwT5tp2W4?=
 =?us-ascii?Q?dvJpFbU345kwBVatxejsZ3emEnVfOHCEmM3WRL0SrG88MR2dKLTeu6wJjO69?=
 =?us-ascii?Q?8mxg4vgHknz5hSU77aXR3ohZ5mWIm4x1FWzO1RdwcTZ2iGf3QbQBCgKPhAp2?=
 =?us-ascii?Q?H4fhmsMGVTqguI+vb9NOcYGWF9lyDbTovg7hcqzXVKOUBJIzXGcuJ5P1FrRX?=
 =?us-ascii?Q?CuBLoiDq4lNubs0m40e5txmaSGs/2GF0h/+E2/JAcs/ZicNQKmGRmvq53/ON?=
 =?us-ascii?Q?cMJ/iQdOGbFchGwEk+fAT/tdUtdruphfU3yOycHFS/PUxv2mP3SPcz0ZhdpL?=
 =?us-ascii?Q?m2dU3BlVyiK6WJr9TOuQhgxjl1VjElNLMVjJ6umCTDKbxRmc2ykLy04xu1vj?=
 =?us-ascii?Q?K5B+PAgH3UAneez0QTufvxc/SFFSRyqd2sFLhxejpOYOp+mEWG7lIAtV543Y?=
 =?us-ascii?Q?hznFGrxq0X1OySbRO1TKwzRE16inZyMrwHpospjwRlwnC6pg8Kd7T6Bmi5nv?=
 =?us-ascii?Q?qyR8NwutyEMNboP0ah1AZsRdG0whcjDxGkgIp+x1x3HjRh3W51L6uQSHoz/b?=
 =?us-ascii?Q?qYseWDiEebUm3JZPIypuJ65njq4tOzyUlyNaaDHGzNWdAUbNFHJcr0UeckC4?=
 =?us-ascii?Q?uxoGVJpCdF8JPuLdWvfV8xmYdefyWzBA2ulOVBvVbtUxX57qYLeAjx50NjSo?=
 =?us-ascii?Q?XbD6KFm2M3II9DBtv5bdP2SxPm37uRzV2YDM+jIf9FaIo4gH5U+kKxJZW4a/?=
 =?us-ascii?Q?Z8WcXYCyoFgZwvB4ynEE1OfdidPT+otd1gtlD1dpx9a867cxCF9vXTZsT+l2?=
 =?us-ascii?Q?DjoCpMorwovKn7AeQK6DDlvLwYh+OpOI46pFfU8dM+TVhVPl/3VGjha9LTiT?=
 =?us-ascii?Q?sRzrxm54uSAZU+nE99o2muLs2u0brC4I/L6hos2q1F56gJGbyyweeroewNKq?=
 =?us-ascii?Q?V8HGWbW4wN4JZxskVhFQhc4rrT0alfWYnUqUGRxhI+yfzTbbD1zJgoBzp5am?=
 =?us-ascii?Q?d9ZPoa3WPcQMwAPSJGBpqFmCdQG/zwHyDtxsrSqKDEIn+vVy6OcmWTSeUzEA?=
 =?us-ascii?Q?0U5b9xmWUGDCVdTC7Uo//uYafPc5jEW25sd+p75aeQ2992H80hs2+Q5NqryE?=
 =?us-ascii?Q?R08ubg7vBXwMjSRkAVJmu3hI95f/X9OSl9rZ/cl2yFQ4T/Nqh0RN+PyeEcmZ?=
 =?us-ascii?Q?Z+z4dPktRHbYWWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zFLVKFYHRSanCCjcFjRe2fgo6MdiDSQ/fffdr4zaJbtACdvR/gQPkPcNb4kR?=
 =?us-ascii?Q?SjOtT3+pxdmkwDSaUhIiJSgUdoNitiUdrsARheUNkQkvyVr/6L2hMnPv2q0E?=
 =?us-ascii?Q?7mj9o5OZz11ZQyyIlDT2psSBUlZoch1npFUIq04KHjzCQgtOpL5IfwQkcDpy?=
 =?us-ascii?Q?WgYDsB8GFC0ehoq5bSzYwruGYWiQJRpHjZucuRT9kVirEBxJ8svX6v/rbmJS?=
 =?us-ascii?Q?MlUD/h61c6QyJ2urGjZ0ULYIMbq9Y+ZamG9IN27nT/jf2TNJoXQpSBSaznb5?=
 =?us-ascii?Q?gmbMFAtqBvRobczhPjZ4V/UFLuCcZQd6WVWQKsvAsDO5VOaR82d9n+kldF4E?=
 =?us-ascii?Q?PZpxb+nOc9lzQruCfXbf/0HFDRfsDtjoGCp587JgltiBA7EI6u4kCk7Wkk2M?=
 =?us-ascii?Q?aSs/RD92AxWU6fhWXJRftwfYp+6buJMIUWLAv2B2kH1voM2r53dESIgZCmfw?=
 =?us-ascii?Q?tijcTfPMkv1b6nSWVB3quudTX6KeG4jda8O8kYqa/bo+fBSZ1Xe3cI0cAzBd?=
 =?us-ascii?Q?xNGPN3Z0dgq5BH4vxncCxtRTJ2Gczr2WTOxi80t3pu91J7yowwkomQF8Z93W?=
 =?us-ascii?Q?Mkjp+KGc5mTknh6N1v9xK7KQ8o0VEn/hy7jFQ2WstV2hpyWGWu8qJ8LPUYop?=
 =?us-ascii?Q?jEAxFKlGdUwC6Npmio1yZYC5IBGnNjXxn6CQ2edUZPxq12faowuiBoagQdTn?=
 =?us-ascii?Q?RtYo0ifbGmyDXLbGIHBXfFWLLdYgyNz8HenpNv2/Ycw4uOpv4ZQuIBtjOl7s?=
 =?us-ascii?Q?QlimsqUtBlQtq8KoFhhxlDJZczKBMSCQwubnBGEahvEAXZ3Qhb3JR255BcH0?=
 =?us-ascii?Q?t8BvGaT3pHozGf20iaKyGJAtJulSkOSMf/fBFhmttCpw04n++M3lfkH3gpZu?=
 =?us-ascii?Q?HKBa3BNwUA0iFeWPE8vrR86mYIEggIKkfR9j+KxSGRcdgDShbSEB46ng8Lg9?=
 =?us-ascii?Q?wMi/oXP2rC3LCJj2KsM79J83SWlOgG4nkXbOIf8yV36qlpbfgtN/hoFuNPAy?=
 =?us-ascii?Q?CD9EyMjeUV7/3qR1Gdk5YpqxGQJgJ29GOIrLP/c7PKaButuc76jf6LZm68hN?=
 =?us-ascii?Q?fHl4szFxwlqAtFfJ+NyqmUQu1ktpNWlGkgfK2eEau1yicyy/7NiwYNZe3LnL?=
 =?us-ascii?Q?Ctlmw6cOIYomoaJtG/Jg4+RLTkXgQFYhnE42JDR5pQsAebb/A73dLmyXRlrz?=
 =?us-ascii?Q?fbfBtouS/b1/WqbiAgtLgXw1X4y6++Z+7IZTonODqTleNM08O2QaBpWqtGQc?=
 =?us-ascii?Q?vGtCp7K/Ni4OoOM9pCVtfhP4drKeWEjpladvdITy3OgUZ4xoOGTrIRmtGAoN?=
 =?us-ascii?Q?NS09VuXIuNnNeLPmyQAuKbqLn6ydmr72BsInWHCmwpYEVQbpi53+GXjcb76g?=
 =?us-ascii?Q?S0T3jCupLnC2i8Bnur4CAVTzal4yhDH27oJ8uucn87PIXEGPJmhvRWZF0WVB?=
 =?us-ascii?Q?Fm7MowLbhgZGEhMZY+tsEs1s/cyd7KLR4DcE8xGEfN0339zBwUY6ps01Rm6+?=
 =?us-ascii?Q?DvjbqKdE7MeClB6HLdt4UyVzj93uYtHLVW8WdShXx4Y87aYlUmV/Mm9DYzgf?=
 =?us-ascii?Q?KdBnQ4TlmWCKdgePpgiPTCEuGFFYXZvzP4zkz8vvrWa/yn0YpCNV8ryasVgM?=
 =?us-ascii?Q?gE2CLQ2QVFdEkuStVOYwkJk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6a3a3e-afef-4bfe-8ed3-08dd7dfb4a74
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:39.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR1rIWyZqM2Nsks1lraI0Z7X6qDVKFkmeXoAgE4PfJciBojh+sxa6qJOkv8fuGpMGUR6QD5L2jRGUaXtnYbsZa8asPdVuKJrD5ZmJCPMwltZPvCyDv2OSLnmoyyuiVN6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7327

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications[1] enables
EINJv2 by extending set_error_type_with_address struct.

Link: https://github.com/tianocore/edk2/issues/9449 [1]

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index ee26df0398fc..fde6e01f66eb 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -50,6 +50,28 @@
  */
 static int acpi5;
 
+struct syndrome_array {
+	union {
+		u32	acpi_id;
+		u32	device_id;
+		u32	pcie_sbdf;
+		u8	vendor_id[16];
+	} comp_id;
+	union {
+		u32	proc_synd;
+		u32	mem_synd;
+		u32	pcie_synd;
+		u8	vendor_synd[16];
+	} comp_synd;
+};
+
+struct einjv2_extension_struct {
+	u32 length;
+	u16 revision;
+	u16 component_arr_count;
+	struct syndrome_array component_arr[] __counted_by(component_arr_count);
+};
+
 struct set_error_type_with_address {
 	u32	type;
 	u32	vendor_extension;
@@ -58,6 +80,7 @@ struct set_error_type_with_address {
 	u64	memory_address;
 	u64	memory_address_range;
 	u32	pcie_sbdf;
+	struct	einjv2_extension_struct einjv2_struct;
 };
 enum {
 	SETWA_FLAGS_APICID = 1,
-- 
2.43.0


