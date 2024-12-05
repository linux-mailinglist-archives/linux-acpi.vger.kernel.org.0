Return-Path: <linux-acpi+bounces-9970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F4D9E5FF6
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E413D16567C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922322E3F3;
	Thu,  5 Dec 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aohVQAax"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020089.outbound.protection.outlook.com [52.101.61.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32625221462;
	Thu,  5 Dec 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433562; cv=fail; b=u0vqyi2agHVlPznzjc3tyv0MeNE2xa8A+nrZytMZGjpT4lDL9LatQtcUh13m2luJn0iv4N+wi5ZwCLq1VLklHtI2OGr6XiY8WOdCSl3DB41awp6MB/ZRSfhwTzGBiQEjxqgAeDfX3YUTFL929k5OYuYr0+43d5wtpDCoHdayf+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433562; c=relaxed/simple;
	bh=SNtIs0XtfD/yrsSlRci53oQzjxXub0v+h1cIjU3VsU0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6KNsLE4oe+sOSAd73/mDEgWgXcJNpwZkG7Gp3bbiu4XdqtMl6cbocRRjoHBGG9KI8BiOdRImxdgPMHhhVYqvNMxPEx7I2grBhupGEP4fxWCeqLrnU0qOTDjq3qNjnQILH8Lr9FrKW2mSRun6GkfY/2weJXGsFcv6jTOVQIKclk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aohVQAax; arc=fail smtp.client-ip=52.101.61.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naEtk/wBIAnpXtrtNcasNLMlwItcaJMjeX1tyTLhx+He5FGRUAX/9O3pDd7ttW3/MdDL2ISDjiKSadJCqqEaieaLji2AXYOLYGDHs7pa94BGxPi1u4vj2TLoGWX6gSHtlwPa8kaAiJU3yV79e99jiyrt8m9TSvaEfestzUMXczlZC3fR/k2XDHikhvZD6lesFbbQQFBCVQCw6P67vuWcrhduGCbrL7WIM17ulCPre30dZlE8AqGiYJ9/QVRfpmM2OwmjYauJKOf9c85g8zY03p4iRsJ60M9A5bvRg7QrHt4A6K+x6LEvjrStXaIkkAijJq0sjRB4F3REYuNnkRQMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAKjeHp/9zQNm873+MIF/dMakedIeOxmBryMnSByCow=;
 b=iP0wxqMRO76E56phgdYqgYFJhq3gWA1HxOqzAHpCMSm2n0IW0YyZf+oql0jV040K2+CwOY5pHBWIMYNNlkmU2LmKPRLRhhoL9b1fiDUBfXZD/5t34ulPaBn0WCjwNFRLTt7lrjNKD3+uhJNyPsCPVt4aQ05PAMC1BKg8hB1ZGimg+Y9gWan0gioWKxlx9LmPmBs6fCgzmHpNhmAmwco2PfcgM+Ev3/Fq5ZPfi2ewfDZj3huMvQ7RJ8vZE2QMvTTqwCK8P9IHW0dV5L2j2L6FMDCeYogfv5cQoi8IuEYnm0C+bT1cX8yePf/zFsGQ9DLMdYrBdQ3wbxdfAnrLob1Tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAKjeHp/9zQNm873+MIF/dMakedIeOxmBryMnSByCow=;
 b=aohVQAaxGDeuO/i3bBJv7zes4EsyBfQBIa/EyuYD2uLF+vjL9lDoQ1Toc8nRVyrLHtcZzqDRS+k1PXBefoCvU+q3rJUcK20IOXLgA8g2JD0xK+m/AOsVH8tCcAZl+TjJC5nJgPxueTryiLwko4IwTcxZNdFY2m4z0703oS+QZhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB7759.prod.exchangelabs.com (2603:10b6:8:7e::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.9; Thu, 5 Dec 2024 21:19:14 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:14 +0000
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
Subject: [PATCH v2 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Thu,  5 Dec 2024 13:18:51 -0800
Message-Id: <20241205211854.43215-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS7PR01MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9ab2c8-8d10-40d4-1f18-08dd15727802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?105GNUukKHo+N3lvx0Y3IRq3ZBTMXJ286D1SGElfX0W6C8nxX/uRzhSFiaLc?=
 =?us-ascii?Q?i7qwtbOCluLfpUGdCbAoC78k7l4+1FqjHaQxYfQc1oaOdyxUXj4ii8odVCmf?=
 =?us-ascii?Q?skqFijGI97IXAf+z+dIGTs1PlnxkbeIHL/NXkwY7Kf1P+dKFBE/1SvI0j9Ph?=
 =?us-ascii?Q?tH6+9q1iG8+lvEeDnvMJlb0UCYY1XD62LGFp9i1yScAvdvaA85E7m52RlIup?=
 =?us-ascii?Q?/4QUTaHjYWxQBmzo1gsHr9g0DvGA29xi9cxshzblL9MduhGtcZGfs+c6M2Yd?=
 =?us-ascii?Q?AWF3V6joQfZI4sxgJsZWjJmP50pbQh96DzJJGMJFHBettQI6fVj1zUFXTSdn?=
 =?us-ascii?Q?TsSSI+AfDLcCLvLs8fH78+FMnpkx+sLqNhE0t7PmhQwSP3F07vQ1F/VLz69e?=
 =?us-ascii?Q?JxNWMlo+HfAJpGQIinXmFI3apTS0DpgxlhRCIGHDZFq7OMT6otTs/DFejioK?=
 =?us-ascii?Q?gUDedvmERRzZ4c8tdSgn6+NAW6eePg0FfRcXcvJomQsVBsskM/r9//m18YPR?=
 =?us-ascii?Q?ckA/H1K4GLxp/v/mmSYQgzCC54j1pb35pMTo1fBLwSpTEdPkd+q6vVHBoIKf?=
 =?us-ascii?Q?HbRAdy7fMSqpVJ8dlffetJPCnuK+vnND/rMq/bLUzbuWWkgEY53f22POP0mu?=
 =?us-ascii?Q?XrAebbIQb3pSS0dZTjoe92o7FyapnnsXcuLFeqnpiGDHj3DYgoUcUcTgrlva?=
 =?us-ascii?Q?Iiz4sGQGTbPLSIfavDjJls073VJMbeSmX29pNSDXPOg0izXdXnseOHG8KBl1?=
 =?us-ascii?Q?cnjDWE00PuCIBZ6ZofU8fwHcs+OPZRukTklxMw3pFExFWnXrbHVPvFe6x2Yt?=
 =?us-ascii?Q?H/rbEU3wtMqk09VybYFf0EoY7xsrbyKd5RWpf/x7Ow/KTv7PokHlJu1GggZ3?=
 =?us-ascii?Q?uVY1fYXVEmFEMet9nG3NXGEySyFAkoOsUuclNLEVNWaOb7gmI6bcjkPNKev0?=
 =?us-ascii?Q?rx1frvXL+X5cgsvo1hI6TOkJD4+ihzzaXzRJ3NRKSun9Q198J4i/9Joz4C3X?=
 =?us-ascii?Q?57Tt54b+MVavpUdtBf75vh4kIL3dKRbbUdMn2SNEX+xaOPS0x8GsW0ZBVIwh?=
 =?us-ascii?Q?aFHzrjAf2XGhtXzu/NmsrqFw/WVlRQEzEG9Qe9vYBolSQmZL+XgumPKu+16Y?=
 =?us-ascii?Q?bDEhyElFDZrobLdZx8hNuqS5xHgSRYTsPzFfnkKfaCa7NDnI2oKtLfUn1mln?=
 =?us-ascii?Q?uwB96Mq7rLnr8FwGTcPWANcNttpJ8wsjmTWcV2/LsRJP0PVskmHPGOPm9/Lg?=
 =?us-ascii?Q?5/JHmyIIrzD46YPotZJI2t/QWMTyMTgSsY9Y6niGbsWOmoYujR5TKz4f0PSg?=
 =?us-ascii?Q?+z4JrQSTMCxxdbU9/Ak0Y89tsq3R10bb34naOjkbi6iNiyv1MEY28p5Q1uR0?=
 =?us-ascii?Q?AxrqOr5Wk3Z7M3z4le8FnJXScXxJzOeKkhvTZdvm2UcImNed67i5mQnmhaHS?=
 =?us-ascii?Q?MlzMtgtewsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eL2noqJYlVLIen4rBE83zFKSRRB/Q1NgTam6zYZE9CpgTFE6ZZcPVE++A16C?=
 =?us-ascii?Q?6yIcxdISp+B9gxqK3fICqFOx6yvVXGSZNsL47YO2nZbGwkY+44yVRq2F3aZy?=
 =?us-ascii?Q?VoIj4Cxjxy4OFXn+lKsQYCvWBHlOYFUbqxe32hRn0ov/Na1sC4tJWo53ihnY?=
 =?us-ascii?Q?bo/+2aKwUHCqYNYoa5wzkl6rb9J0YzJ1gUaMQTVB0B57Dqo4CH/SSDVGmh8+?=
 =?us-ascii?Q?4dlbpp7WrK6Q1N9NnQQogy7Qdjc95TV4R6ysTBuMUtqGsQ74F5pyimU65u1G?=
 =?us-ascii?Q?Ojf98lzpFO3jRJ6VgQOjEl1WumaLdAey8zsf0fjntWhnYMZJ3nxdpFmL2p4r?=
 =?us-ascii?Q?GN1JuLgLCacVId05tpqOE8IbPK6O4Akithyh1PjaTTdp7oiNLUESY3l9okdN?=
 =?us-ascii?Q?81dBwXJthzv9lAvPudu0qFvHgpNeniJl1IwO9Q2Ao6dwc2f5NLP/96t70ghw?=
 =?us-ascii?Q?tSRsqy2Pz1vKWBxkeVjxSqA0OwaxjwEgUKziPjAu0CDtqobdWXSf0lehtKJy?=
 =?us-ascii?Q?srpBw8ZkDTl5bUMEhZ9zsZBesWwc7FN5ix+2GiV1LYSiJ+GICIYYkgD7MFBc?=
 =?us-ascii?Q?zUSj3BBDuAUx+1P0aRyol5Wio67zBkDCeDG6WJWKtx3C7G2tvSWe+yyxWWog?=
 =?us-ascii?Q?halHQO1eT6nDPiHU5ZddClY3lPnltTfNBN0n2gphgQrw1VxVKPHmmvD8DVlN?=
 =?us-ascii?Q?8lHX1yajLf8+VAmYm+zbZF97K5zkD9Q0MQtXra1F925IrgzXeGNAl+0aM4H6?=
 =?us-ascii?Q?xC/uf0cFPJLje+JVuLK6eOrPZQe2BclwMx0QmI72uA92fVzn7xrUItkF5s/y?=
 =?us-ascii?Q?1UPCvofxLUDhG7oJidepe3uY6rGpDgMNGYYQPP57pcDY67b1dCi5puNEf8Kd?=
 =?us-ascii?Q?Eb9sYAUsr8KtW+XZ99krp3/I5hKAqHOXOuEiAxFKByZcyr7LSk4paea5w32M?=
 =?us-ascii?Q?uGrBac0/bksHCXORMUHbHKQ3DJsywicjXoU1m9cMWN9exXsDw910lrPmx394?=
 =?us-ascii?Q?rChLboeQ4nC/IuGsl8+YHkaO1vM/i/8BJjV8YMnGEijIeDB00Y9blzW9NKgV?=
 =?us-ascii?Q?iM7pPwhITcQHc89FZZ9PbgtQk4GHqlcdlr9eFH7jRCMjJLKpYKlAy18SILl4?=
 =?us-ascii?Q?2ny7WmK/MVMD+xGwHn+1f54qlFNgvi+C/xC5ZpLMr4af7Li6kmX+laNPz7IB?=
 =?us-ascii?Q?Y27jlzhKqa7Oz8TfwcrFxuSKCGRJ3NQIUuz+OQwDEI4/jfGfUlgTbcD0lMxn?=
 =?us-ascii?Q?wL5pJMYCnqN2GowA0jVR/Pa2wK0KjWA3QIQrpRcxEgqq0lFKXk5pmnlMsm98?=
 =?us-ascii?Q?sWOSVLwuXhwfC1zM2iDFwktigs/GFHhqV9IWzezx5AvrpIqdLEKcfzPmS3HH?=
 =?us-ascii?Q?M+6EuEpkoD0OMUORYy6HxhdZJcvaAMcZYPhZMXalx/mIqmm8spiTxADhsxAt?=
 =?us-ascii?Q?q5zo7bwCSo0U1l6t90tqR3KmsJxyWqvbqmITD38pBI0qtPujFAxzaAW9s+GR?=
 =?us-ascii?Q?b4BwfaLOzudnek9SREczJ7gw6KgMgjUh9u4hdFILpY4Y7Ido2xLsiR7HwLwM?=
 =?us-ascii?Q?KZAUKr7KcY3AnUWl68XmkeEaJiFd/S9REx27rau6/LJRjNDB4Mp5l37r+qIq?=
 =?us-ascii?Q?6jmahCGzkm8XComUqPsf++E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9ab2c8-8d10-40d4-1f18-08dd15727802
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:14.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdvsLfw9FG3c3PcmszuMHju+j8xXvs3ab+DJUYhuSC50/6wYDNhdsb72csFm56KgStOPgSm5lzDZXJa6T0KJAR6IqbRSAgH2aJH+CBENUm+SHE4iwpfFABSXO0Xq4Xae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7759

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications(1) enables
EINJv2 by extending set_error_type_with_address struct.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2c57e25252ac..039d36472342 100644
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
+	struct syndrome_array component_arr[];
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
2.34.1


