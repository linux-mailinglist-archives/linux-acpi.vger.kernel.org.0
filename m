Return-Path: <linux-acpi+bounces-14422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1DADDC52
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589E31940C04
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94562EBB8C;
	Tue, 17 Jun 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O9KLEO3b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150B2EA755;
	Tue, 17 Jun 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188651; cv=fail; b=SU7EzadV1D3/hIPri494+q8ee5qReekvDheKqutuIi/i+kzrbx0SwC53l4nDKhwcyKf6D/ldzxy7/EonyLgcWjIy92Fckm53fHIfJWcZoJtB/lx2XU34OQtu4wq2zZQ0zFqQ/wwJZiqelKIYOEkABWe2+z4sU9iqJMw1Il/RyPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188651; c=relaxed/simple;
	bh=4BP1XM4kEwjLAH/pTTeIxDND98D9tU1HE1VKQIuYTG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxKjbECZR/KzO8sdtwLILPUE/FTE3416RxpoVcdV5ktw4SYJi4udBemN+PUbi1adFoP2dVqp0noyYQEdKGkQbAvqX8/0yz3P7vza9/gUlBsEl6bzkyoRXLGMbdNxIPmdUxMfTkCw5O2k3nSL3B0Z/SKwhQhFYZ3kDYKE/YzsYcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=O9KLEO3b; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI4NB50acDp98FP03Q0Aezm+yAd7fnEPWIDynoccrVQjn438WnJTgbv17xNbd/CqDgnn50dMycYxOrowedHJwp6d+V3vK33QNMZujZ31FKQF256hDoCTskbJla0WR+znKejoFBSXK1mctEINKBQTDcTp21cgP1/f5WMBtBJyfsE0vh+cZfpTB1768h2MziAOgWnywlr+XdYOLkJcYDrDp4QgOjQFuonSxFgJqdMjsdsStkQ0VBNy14SLLj8n1MQT9hS9aAIYyJSj+oBSg7GUzJ34I4GS8kmRUWphx7ikUOoOsG3IUaSkuzCdPUOMr6xlfLxeIqYX7EZMqo+/g6fl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w9rKx0eJHAmpJRiZ5WpEulFSzUbifMdHGa1gp+Pb4Y=;
 b=xHDyWujzrsYmDfU/ACMX/WkNZbE/z7ivkvQ/T1O/pzO3CEQYnwyVQjFepiLJOTtiJIIuQl5Q3vfyRPXsOkhHPWJIzsP0xSLGLd25rUWt8Pc03O5XksHwFizu2oLejaKRq+TNgZDRZXtPnL5gGXKILgU+SsPBUZf+TqUScNBCGpjEIhClr5X2iwRRVobLPQqg8RG9Q3+n6Sqc5XdwJwoT1pXveM/aLU50lOCvWvV+4GEdI61WJ4V52izbsqnWiJ02lR+r3oGCyVKlSWReU5P0YwuETojVBsgkgTfCTwWUZCH4YIo9HyyatYNgY00LavyjvVnDmdT9QwLGEmtXbPeZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w9rKx0eJHAmpJRiZ5WpEulFSzUbifMdHGa1gp+Pb4Y=;
 b=O9KLEO3bHzPFhVheXMZvzrwNo6xxd8qickBbm2f4U6Ei4VIwOscyKV2U/BgtRHwlzBZ720HNldEUaNZxpYHhmjxa1Z6yzvbTBNNVflFE+B6qiMftAiCYZNafUFiUEPmb3AD5tVysE0pEkfOm5PN8SPR+zrLB02blhh0XcEsBFCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:47 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:47 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	ira.weiny@intel.com,
	Jonathan.Cameron@huawei.com,
	viro@zeniv.linux.org.uk,
	sudeep.holla@arm.com,
	dan.carpenter@linaro.org,
	jonathanh@nvidia.com,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	benjamin.cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v10 3/7] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Tue, 17 Jun 2025 12:30:22 -0700
Message-ID: <20250617193026.637510-4-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
References: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS2PR01MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0d80dd-acda-4104-500c-08ddadd575ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dSho44K4czx+SLQCSzPSDOjsP36Sd1xeO1fDV3N9lad3qbn3f8UEBF998Ea0?=
 =?us-ascii?Q?y1Ib6zxuF4FugNrG4n/uo/OUgZrvJMXG1iMxnW+O5GHZHZI/2VZVFPZHnC26?=
 =?us-ascii?Q?wi2zlmgCCsChP8UxqRqD6eHJcUYDdYZTOg0nB6khlI/UGPhbnX5yJad7l3D8?=
 =?us-ascii?Q?tYa8U8p81aanRw/uDjKNPwmfE3J0V0kvsMCpZk6Qy2pU0S1ZVzJhrcZJIW5k?=
 =?us-ascii?Q?3akQHTYP6mCIRjUTqe+9Wu++oGGhtmHiLrOwY5ZkTC4vzEKvpTNQrZ0GPxQd?=
 =?us-ascii?Q?6I4I3MtG+B8lSL6K4AECZj+d6p9X1OaCwWcIqeiMsaKbaz8hOPOtB1vMv8rW?=
 =?us-ascii?Q?4jz6hmR+vuWT+V2iw4KENMP4DUxZtGsZ/wUX0EEH+BuFlv+8b2BWvkYvnozO?=
 =?us-ascii?Q?scroJmLPSKzcRGiOdVFREXMA88Yb5UoGP673Izg1p+zFUGJClXq4INocILDB?=
 =?us-ascii?Q?KZLyaERyXSv192Tuq//UUkRPE0sWVl7gKi+qq0QwjUPkqfZS37Sa4qC8TF8V?=
 =?us-ascii?Q?F3m1Hb2I1daTknMuJyK9OCsnpsYrBsMwyZayeGAvDmSLfny1HPvwcp5McUI7?=
 =?us-ascii?Q?pFGamjmVx9GWjLa2bdfApluBBCMTzqAnPxjbg6Hyp9pOqc9Gawe9A1WkYsFn?=
 =?us-ascii?Q?4rSmaREtQoiYtm5laCQyJ/L26RYcD9ICvVxdwJmh4hbe/PIRTlBqc4nZM9bi?=
 =?us-ascii?Q?9ux+VZgTH8ROGHMxEfVJItN1lX3mHTe5k6ukq//9pa9paoQBT+sUYmTCn7LT?=
 =?us-ascii?Q?Mie/LFcMhdWR20JDj9JOKzvAZXR41cD4rcNGq6BAlXuE7EU4Uf0DMYcOj+qE?=
 =?us-ascii?Q?HUciBP9ElZi9vshXmxKbRs3ovSVYkCJ5AZ7NRYa89p04MzM1mPjLSRDGHuRe?=
 =?us-ascii?Q?G9ybC/R4+AFrGUj53WpBNDdPCsySpMujZmIPFxCl0pod2+rpk0yF1WI4Squ6?=
 =?us-ascii?Q?P+szsnzhGdxnwu+z5d/iC/C4NXlBxcCKQbn3gPbyNFn3w1qPoDldI922YDVa?=
 =?us-ascii?Q?LZs4WUM2DhZfexUiN5AYoJ2XjHrhL6oV61S41nP08bO7O37apHJqdGms06JJ?=
 =?us-ascii?Q?+LC8xaI64tL2yeWMU2XxPDP+NejzzzDVpaqPj+tTIOhaUSMyYmagZw68N3dq?=
 =?us-ascii?Q?/TwM3vSjY7QWaQhMSuORosHqlMoyVbBCauLO75tKsP386z00UG/R7iDRILbP?=
 =?us-ascii?Q?Z6Zl27l31YOKfg8CtoOfLBuEhfhtJWr+XZwFbZp9ewHHC2bOGwH6GKq71U2W?=
 =?us-ascii?Q?A9YySmwYcedRQKcshW+YzN6exs80TwVU+embkg3EflZoRDMx6hxIuANz1Lga?=
 =?us-ascii?Q?80diJdo+58SuFW1CHaIGGi3ShqEzFlXgCIxTgqg/IC7PMwXUDWL2qx2u0JjL?=
 =?us-ascii?Q?dllC258JwxjhLMaAmWYUKlIVksxDrpuK++un5RsBdavJ1RTbnIX0bS/TRI66?=
 =?us-ascii?Q?1zOlOOVUs3rFV3QShBeie9TF0L7nYrYB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lM9+z0LcCFlUUAgMMjsn7nrJoIi0lgDZNMvV0dzC/NmuBQbm0cIMODYYNzKl?=
 =?us-ascii?Q?vauCrDaJERP/YROJE7FTSoN1AMObmvmSH0RWbC+Hvr7fnXymFEIxbxN/+b6Y?=
 =?us-ascii?Q?XCfli3jNtU/RDMKOW3IURtXN0tOtDOxTeB/7ybq7jDrAN6kX2KUCzkPg/gnC?=
 =?us-ascii?Q?jCHEw219LvG/2kpyrEfsWX3mWI3q9KraqqlafJL6vfAc7mop/DzccNTNTzFk?=
 =?us-ascii?Q?ZeCW+mu8J6/zXKZmHvRWXiNivf5+CR7x47nHkX50yMEAA9/UyfxHgcVZ66zL?=
 =?us-ascii?Q?lDRArej92gss8Tq5tkV9Yd/7kg+GjUefcUNFuyEWSamLGR5UTe9XdRwWavtF?=
 =?us-ascii?Q?7h5ATbuLSuPXfA6+VQRdRMy7aHN1a8haeRpPPrFq0iZiN4YW0tHJxVHFeEF8?=
 =?us-ascii?Q?LhQEHgoPD75vfv+lX0Gw+IYG0XKdoqK5hUoo4+xDH/f0SU0TGpQExfxcu1po?=
 =?us-ascii?Q?3/yFGv5Lb5wLP5znOEEQKftu2RcWiWJLpCmuiLAhJUp15Uq5o+OYORvSqj//?=
 =?us-ascii?Q?vxyLBEB/dgx4rwVBGAwfjKLAeO0osyOeVZyrUDsP8e1bvBByDIjjXKct4/xV?=
 =?us-ascii?Q?ZNKcFEhXs3RcbbaJPSY7e+pgFkADp7nx/cRRdVBvD0CVk2C2+QC7UqRZzL52?=
 =?us-ascii?Q?RQrjGBL98jm+MySFV0pOMB1oobdSbyMOHIIl95tZE5dDuQbvSjgkq7EbUnPo?=
 =?us-ascii?Q?UmhX+ubbWKARjiFnzasgrgX7Fhe/0hAQ3HSFhODLnovtdxA5Vsp3R+Ucdwp7?=
 =?us-ascii?Q?BOTO+Nmjtmuba8C7mKjVhlcFhRHtEU/EEPSc34yToOP4Unif8UGmtKGhmV06?=
 =?us-ascii?Q?GF0uX48owRXWLQKf9lswK0yO2cAFSrOQB+kbEn/uzbyOwFlSbzZzsYWDd/kz?=
 =?us-ascii?Q?tlxCLvg9SZGxbMozZyYU3beaIQDzbRUPMIPh1DMaVViOpQ+CTCIP4omHRXgh?=
 =?us-ascii?Q?5oNnmJQ9JK8T0+blKLAmoSorsnicjlPPIda/2p5AdmuUKjXft4NGcXd9/tc/?=
 =?us-ascii?Q?VJJq2JU3a+0MzONwuytE1yM+8R4otId2qubVureDG8uIXv2b84eyurxAiPV9?=
 =?us-ascii?Q?aX8V4ltncdHF9TmQ19KC8NgUrfMw96h+lWEcNSp+3mJ30VlSR98qK0xpWbGP?=
 =?us-ascii?Q?Uz4Y6uf6zy8BxB6Sto7p2ZNTVmSf+/FqibB9wf6oEKxEdtFuGHaSw/X0TWnY?=
 =?us-ascii?Q?u2CGtg7CGERYDrSHgkBQJCINaOgTzvWxlvlNpdCNLswCP8GxYTXZUoKpAep0?=
 =?us-ascii?Q?ucs29VaLiVCCRJQJbjTZxDAIFPyrxoz2sAy7XhJvSw3AdAnCNCpve+K4Jitv?=
 =?us-ascii?Q?NRrVAbdYdECV4NeRPNXGSqNHRb/Vi/lVzYEvGuvFyRxHELGTw0xx//EyaFUI?=
 =?us-ascii?Q?D1vKav/H0k4/o4r0OqX4wDLLXfH4N9nIhTXbmRTQ7UvNXgufsFQxSVXfjvVm?=
 =?us-ascii?Q?qqVCn/2Uyq1m4XoECfQ7yWGcxk91xOP6S6e5xlPv0e9ufy16TBMdrOilPU0l?=
 =?us-ascii?Q?jTUjji/4Deqc3pFiY+J1Fed91Izo9ITC9C1Gxnx7umL/jDO3RQd+QJuXZs/p?=
 =?us-ascii?Q?ASYcCzoS5n1crB0WFaJ/a5cEhpBODILzsiEF3E1r9Q8Efpo3/I4QL5KfOZA6?=
 =?us-ascii?Q?hUsy22ECW5taYbyVJ91FiN8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0d80dd-acda-4104-500c-08ddadd575ac
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:47.2282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAOyUnM+bQa6NVLspBhyjusc4pE+ouYycq/56tYM87jJXdm+EBB2e8wTiSJUlepy9ANbsI3oNc1jPWEBiXQtVEVV9PUHFBydyJZWVTMPj5bd4RjIrGxG0ypVkDj9G4HE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications[1] enables
EINJv2 by extending set_error_type_with_address struct.

Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#einjv2-extension-structure [1]

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index a1ff42c226fb..1ffe8270634c 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define COMPONENT_LEN		16
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -50,6 +51,28 @@
  */
 static int acpi5;
 
+struct syndrome_array {
+	union {
+		u8	acpi_id[COMPONENT_LEN];
+		u8	device_id[COMPONENT_LEN];
+		u8	pcie_sbdf[COMPONENT_LEN];
+		u8	vendor_id[COMPONENT_LEN];
+	} comp_id;
+	union {
+		u8	proc_synd[COMPONENT_LEN];
+		u8	mem_synd[COMPONENT_LEN];
+		u8	pcie_synd[COMPONENT_LEN];
+		u8	vendor_synd[COMPONENT_LEN];
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
@@ -58,6 +81,7 @@ struct set_error_type_with_address {
 	u64	memory_address;
 	u64	memory_address_range;
 	u32	pcie_sbdf;
+	struct	einjv2_extension_struct einjv2_struct;
 };
 enum {
 	SETWA_FLAGS_APICID = 1,
-- 
2.43.0


