Return-Path: <linux-acpi+bounces-10965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC5A2F74A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00F0167F63
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694025743C;
	Mon, 10 Feb 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PlqyvzyU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020127.outbound.protection.outlook.com [52.101.51.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B12566F6;
	Mon, 10 Feb 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212649; cv=fail; b=q3ACmGEAh8mC55yrTet3TJ4rZ6tRfEgjOeB5VaVFm07dZT45eU7t3VIjr7Vj6r1oSLEMZa0x17XVNQoeJ+8kcdxprJtE9jtNsBvqIZzUQJHTE+GEX5m5ioObfAJVcsWJ8vmqlX06lzgKpyIz+J2yyg2kJ5cLLIU7P00oP3ku8m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212649; c=relaxed/simple;
	bh=eYb6BNbGVDjKyKbVR2zuXx7Au93uvU7fZ7K4fioag2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGofns2kChp0tbqW0RlNCJzJFVhZBnpdKUPRLbjeQamFEcMc0wnJ5N2t57fS/h27M4/viwTb6CxG1JXoFvYuDXdp1sTHWkB0QHpAOV6qIB58t6d40++DmARIElzqSMCMhyjHrZF9hr9tPHWHYc/GQfDdGnJ3CUcd8iMwKGAMhIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PlqyvzyU; arc=fail smtp.client-ip=52.101.51.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWP54MjrZj27fDtXTKCf3Qkcm9/3SGRgx+4SGdclatBUuV7uNr7etyKEMGDqOtNrW7DI+AnBDjrcnQEmyahuPfLTaVBnYDJdc8s6/fyo7iQNMdYqlTMidsOv7ji3L5CmTeXWKUP5N+59MjTMNUjrH6eCmlIL94kEB2jjKTkVtmfOFg6db87YEyHdDavywYwj+5Pr59CqN2OL8rrxbhX2bwqN5kc9OBCTGLFo3MJaUWYOR6zk03hPP6s0PalTaGwrxyrbf7JrbYRuV7YGBihUIBrVMSztSnJXMbGP5dw9r6kmMpTfDWrUZpzslTO/TjonzjfRekARhSbUS6Bhzydr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhvf2Dg0tPp7GDOQtlUeR4Tu1f4jCnswHeGRkongp4o=;
 b=lzc3ApCXmsbfjup+H7U8JjfyIBgnh8os7ZjvoXx69KH5FTJvuF3XAoyD5dpIyfuHnXoi5ENdxTfpmwLIhruLq2x2uouVGRkeVqr89eLE2UfaLeukjdyIgMJFdUub+Td0EjvjkPN5xiHqPonf054ugZpWAk2LUlabTZe+TFFK5vmnWN9St7LN9RfyygjdqbxlD+L+yC1JHzFByE1r9tExzQSvgmAR2YhPK/wt3PfZ2TEemWbUojes5OGgzSgeEGan+uQ9ccF9kntW32AovYYTG/R1/GxOg6wzv8o1qI3BqoYb+nhoGWnRw246rXfMnU4CiDlCUZFIRMiLUFZgkNTVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhvf2Dg0tPp7GDOQtlUeR4Tu1f4jCnswHeGRkongp4o=;
 b=PlqyvzyU1p1bgv4l+PguJjGPwS9cZss2jfrqguibGZRxY8KrRuZ+JRc0cr+myuWy4cKYEwTFD7jcJsWCGlnsrVf+osdyM1bk3KJy8mbmRovOdkWVdw8CniX7QuBLwPCtJGYmWxfORuHAoyUmMZZQ10++7tV9L8fbRTkRsP7/hOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 LV8PR01MB8678.prod.exchangelabs.com (2603:10b6:408:1ed::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:23 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:23 +0000
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
Subject: [PATCH v3 2/9] ACPICA: Add EINJv2 get error type action
Date: Mon, 10 Feb 2025 10:36:58 -0800
Message-Id: <20250210183705.1114624-3-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 09c72090-98c6-4b06-46c9-08dd4a01f58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oa/V36/vEj9SisbUy6ODQBKtRikkLv4DpHfITRXKS5g5TmdNY2WaAAN+vUlm?=
 =?us-ascii?Q?nXtbEODI3dFRBiAbjyRZlU0N/VDA/MsYm5AemebPs5cB7yvkisYkAElQtJCm?=
 =?us-ascii?Q?ZBdJdg/qIbSRantOG51gnbBkWmLk5iN8+eKo8VLm8udmBQEzYjvA2GApknmS?=
 =?us-ascii?Q?OBEG3nf6IXXZ0xWGtYVx4x34i2rmGm9pOnYtu8DdxP0GNcBVwa8a0ZXbSXB4?=
 =?us-ascii?Q?q+4vaj1yThH0h0AYL3QWTfhQ3h5khqpofUpukT35gCAMoNX2xHmZaOwmyQE/?=
 =?us-ascii?Q?j2gmVtWAr3Fk6FkV1sOyD8j+qJ9C+1HiDXX++2ZbAf3fqEZLwjCWgVQp7EOB?=
 =?us-ascii?Q?00gSyWok65YpxEBATB7EGvipxPcA8tKkWN8GGAI0VwMIg2IGHYlcyrZU2syf?=
 =?us-ascii?Q?yZ1P5xP4YQcGjbEUriZ4B9fwKzftJyrrPvXEksjCB7v4iU6stbXTSZo5aLgW?=
 =?us-ascii?Q?MsMLZtNLYG8tN9cKWug9jDae3Rt1Ovk7bNiaOzpqD6LjptgPk/gN2cc4q57L?=
 =?us-ascii?Q?gdTODZ5l5bc2QXOWlJxDSRlbgxsEqdvoK7eFhOajfZ55KApmdzV9VQad7uVS?=
 =?us-ascii?Q?ZPrCM2RdPEi4BBxASaEkHJIicEkvToeAwuDTH1xqBVUbihbVV2g6lpC2fqKi?=
 =?us-ascii?Q?XkwELRTx9zcs+VSA7qW9qalZNdxH4WKDq4pn1mFPihgJDaoi3M6JQ2Ybr8LR?=
 =?us-ascii?Q?VNThFmE7appMlv2Q0mP4jYXYrZ07y5r2+gbRmwtXoqxG/ox6W3xE/nFRweNa?=
 =?us-ascii?Q?YaYOJIcqAw/t6HmGGV2Uk1UNpaE7kEwbng9JYezFWJ+QBDZb1pDHUJMCN71m?=
 =?us-ascii?Q?GPdoo64tQZvwatYfVrsVTcju4l1q8A7oOJLYgOYl6Uf7KoXIaEb1xvfHG/l5?=
 =?us-ascii?Q?Yr8dhiPn1yVNt8OKyCNmjZ+djWo9xe3RAGPTuyirenhWxqC9d3BaSk7wfABE?=
 =?us-ascii?Q?u8BvzM6xO27a7Hb+tsWWKQsUAaqNippzJYiK3kQqhwUQ4OvnRUT6thMKxHrq?=
 =?us-ascii?Q?BpkmH+Ftau82HeENoNh6X6oz7bEkYYlXw+/nayyXWUhM1pAEkVCu1BF868fT?=
 =?us-ascii?Q?8j+nBD13KerjmnVvAICQK21Nhu1RkYTSnZOrSWGI1GXwgfG1afF69Sw6YRXQ?=
 =?us-ascii?Q?bj7SVqXymoQD3OU5qq1vkdTQ3XpFoVYm5x3teqI/9XEXBDObJOaK85aRxf6Z?=
 =?us-ascii?Q?5Sgp14m0Ibn4bvMsiQgaCPZRDkmbaUkf+uwYgP8W254zUijvBychJdDMv6tq?=
 =?us-ascii?Q?oS7GJ6Upa1mWkqdw7+YiYymQZIJQDG+BK0y9yU7vXoYoyY9EmyLx1juy6Bv9?=
 =?us-ascii?Q?eQiDUo/Pn1b8PTqRG56SiSYRkBHA7SvwIhYOnqYf2IetnVZYtsiOkuidt+QY?=
 =?us-ascii?Q?FtUt8TBfwqTdAw+z9zakm5PuFCCpIijGVRsFeaN3QUcewC6nEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91RNror2auvNl652i15l7mi8/DMfpPDfKVNDT95Zjrmzm1G8eZOGuGrKRzH+?=
 =?us-ascii?Q?dVqRnCP/6LyHlvIjrs9dhEIiDBwvFmlNBzyjdHbjKEJRcRUf357AJY8OnGD3?=
 =?us-ascii?Q?8zcQanuNaK1cpm8eZiqzu1rUnxLnB2+j01najcb2cJf8P5HAy7imyzQuhxLk?=
 =?us-ascii?Q?vdibOcvk2DEvxjL7oDsgnlQgYVxMdG4XutIpsDEJtWVviXU+Ov9Qc5pZH5dt?=
 =?us-ascii?Q?6NtwcI5w0MCa63PcayLLxG9p1YOOTJxsz4l5V37S3I2ZHL5qkqoNhu4Sk1GY?=
 =?us-ascii?Q?0YgO4CYvu35RvslnpVRf44av8hSja78TFXMXQbQt8uxsF4yq+Y6Fl3WxS5Fy?=
 =?us-ascii?Q?UXgiKrCtcDKk40c0BwW6yfliPqt9WUVvKcENZzGuwfa1UMq4Ws+KmLTVjvZC?=
 =?us-ascii?Q?kPMSPEcVHmr33VswyHbxj2+7an/BlFvtQtoZYzjt4vpslrjyX/14tEiZtAJv?=
 =?us-ascii?Q?N+OM+Tg+m9cyIRJPzrMYNdp5TTQ4OKH9qerU0rMY3KeQRM1xvQ4kdjz8oPCa?=
 =?us-ascii?Q?pMSv6qiD5lSos8ggt5JXco6SqFc84Vk7YJNo98XpAttMiV457rq5KE1BbqO4?=
 =?us-ascii?Q?wf48fbCRGnw0mHncvdVYdD+0HFsN/USlO/zH3LwRiMdP2EOd2bBiDuq1C7by?=
 =?us-ascii?Q?zFSCqkTvlihcuKap3By3k9f+2nlxhnqmqqNhkTFA3bhYfgGe2BVxdU62jfd3?=
 =?us-ascii?Q?8XcznoojHZDA/o++YugVppgKPOpjg4l7UOM9m+0Fi6gSEIDTondjc1Y0Edts?=
 =?us-ascii?Q?PEVKyWEmBaWn+CkWGxw8/Fa/KBxVr3bzZOPkZT1gROoNWQD9eifxT2/+rLpt?=
 =?us-ascii?Q?ZQ07IdJ5rs0OgxKwjv+/QcYzeKLYOBhjokeaYmpovDn1ha19oDMo8N2HkhnI?=
 =?us-ascii?Q?ipxXCoXfCAt+iOkAKlYC++6g6uCo+YlPqEL2ZBVG8C+AQpzTzRhd7zR6g9XX?=
 =?us-ascii?Q?yZnZZGnsrwksAHhLS5XUI2qXgI+dta9IGbcBubs43xDy/zGZA4HSIephVV2k?=
 =?us-ascii?Q?M5c3XKsQcHdx7g8Vza1RpLOgkM6DE82Eo1GQRcVuVvu+sscSRNJKyTuqJFkM?=
 =?us-ascii?Q?oqXfAJ5iCU+xNfVFC3DD9gBEu4DcNxdFSo6ZIieFi9xApj8veSGZtKR0yZjy?=
 =?us-ascii?Q?Yquf6+/pS8kGF++lBMdTZ7JQzG5vZswH0N1hHqXRijLjZD0affRX/4xrb1Gb?=
 =?us-ascii?Q?+FlNs9Xx3Ucg5va/aGRZPEutvOT9OMZYZnZjVMg4AOx6QchZR53AkrIbyZmx?=
 =?us-ascii?Q?VJdBMZrMwEirkgXmBk5IsTekTsXuYfwdfrnKvfb+fXtq4EBK24WZn7X7zyX5?=
 =?us-ascii?Q?kNhXluhfcnfUcFlXvPiDSiqWdTvEF7N/EDAJ3jn47BuKvrX2+OQcNVlMSDPb?=
 =?us-ascii?Q?+gCrWwtbzHlgeX7wtr9N+IGAmor3nD7aIRgxOk5+qsCqgBlgYJn3VlS2a6ax?=
 =?us-ascii?Q?gPmn03pwQiqu6x/QFTR2pIl5HHhNT6A/p9ONFfmhR+ILjIsSOaFlnPK3eb9w?=
 =?us-ascii?Q?6cFMuaC2Vgc9RLVndK3OS/xTqGXZZmnxNE4b3CdwnVoafSejcjF+XmUxoYSK?=
 =?us-ascii?Q?bZUJTovLlgYElyGBSupMAZu/02NaZNS7dKHrBWTBaoupU+GNPKkfeKkEsXV7?=
 =?us-ascii?Q?U+yU8HeYMvAzn/5awUgaQ9o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c72090-98c6-4b06-46c9-08dd4a01f58f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:23.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImS7OT6tUGvz9unDDKRQd0fZp/748lO/zqRuOyDf2M4WuXToqv+yTkEfsMjAGdLgTSwDwXb+87c9YSyT6aNTDQVOJMEelToNv4T11hIBX/7NEwIvFCJSc2FZGMDR2Uq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8678

Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
specs(1)(2).

Proposed ACPI spces for EINJv2:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521

This commit is not a direct merge, it will come from ACPICA
project, see pull request(3).

(3) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index c701c434976c..f52d5cafaf76 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1034,7 +1034,8 @@ enum acpi_einj_actions {
 	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
-	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJV2_GET_ERROR_TYPE =		0x11,
+	ACPI_EINJ_ACTION_RESERVED =		0x12,	/* 0x12 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
-- 
2.34.1


