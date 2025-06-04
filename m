Return-Path: <linux-acpi+bounces-14142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D4ACE6B5
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7AA16C30F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A84235071;
	Wed,  4 Jun 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="udLpOuKf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021134.outbound.protection.outlook.com [40.93.199.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80123315A;
	Wed,  4 Jun 2025 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076709; cv=fail; b=knphDN8QV708q6gbfcsCbyb6AxlWX++Z/AY4iv2JTYfi5oQYXhI1Olu5X+VEmvo3PtkwMxIoqizWfwHYYyMrC+UnArWO28APs5J3o/gyLFg0OgbeHICB2qT9xLCHyx7UG+xwzIOH7ZEkG+AhbTB0DQNReztrHmS+KyKXTYJDsJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076709; c=relaxed/simple;
	bh=P7POluSR5lR1HcAphPdE4NxZm+3Jfy7S9jucuoannb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbiWbZ3+Tj0p1HAoTSE6IeEifz2qB7mA7XwJ3zVsZGUw0cgS90czWbsml+0hETSV30nC92oa5Gj4uK+Xv7Z77uNLuRpUwC8J5nlEABao+QuHR5ZGNfTOcNeI1hBe0LIlW6puUw7/CxkFK3ndI0qQQw7IBhzLg57fKpHAnlzUgjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=udLpOuKf; arc=fail smtp.client-ip=40.93.199.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP6JdDc+5JGwuIvX4sIUC0ZdVKdFsyA1zyUndzFOkGWb69eU1THLP2lz1aaTBB5t3pgp/OrHNUT4mXEn8Qbhdl/GSCG8RERJRZ623fJ0nJeJpoWZP6OXbLRIMfVjlJ3WJ6Q8Zvj334HwuWG01J0jGW0dLnCQFj4r8WimOIuFATv3lxfzz/8IlBvo7XQSX427z1QkzPtifQJtMa8KtbCLX/8nNI6wznJvof1yixJKQz7lXaAWvnpCY8zZU9B4gfey3nidxFttQC6W3HaTgXVf9rwMX5vn0+JACI9YZiaH3w2Mbr/dhfOOfWgYbPVIEmXFL1aarubHjyPy8x4cHWHTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cOwpzADnERGAtsVCwKSoGTzd4fWgQxgIRe3OokAwJI=;
 b=CB8STu/TtrGmr89iAig2vMn4yYSYV9s1KYFbs10x7euhOUamVjiwdXM6U0PUUu40GqdL+YbDazgOKb1SV4V5+ZdbkjCaTJ+c14xy1aOwHUbdmWqWNXeJ86dqWYHXJUwuaxxC3wk9bCxLxkbRaX+DUyqlrtYl9FM70lhkSWnaH2XKYNCX+nte54WIWlYzjZgpoIOFfj1mlzE2PY0scz6AkHVkqyo8wgw2Mj4LNwnDY2HDYJvquTyjdjml2muSRAFawJg30L5wMhxbgSCmSwGhe56ZNxgxN5Xw0oAZuGMhVeBTpurnv1zkxLSWIaPvWVEPeHspJ1Zfril6jUAzK44HKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cOwpzADnERGAtsVCwKSoGTzd4fWgQxgIRe3OokAwJI=;
 b=udLpOuKfsUCtttP5QqBjwhyU4QXTYDmHQr/enc6Oa/qkdpPW4QI+oTbEG2zAm4ohklKb6b8MxFWsqoFWkG4zGSo+FKNfVAIDLyi0NJaxDHKiQHmB2tNf7FCYvs7GuwHobxHsXehh0BVC16i7jq5QuVEIRa1VpRizKTfOlzlxxfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 CH7PR01MB8810.prod.exchangelabs.com (2603:10b6:610:24a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Wed, 4 Jun 2025 22:38:24 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:24 +0000
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
	u.kleine-koenig@baylibre.com,
	jonathanh@nvidia.com,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	peterz@infradead.org,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	Benjamin.Cheatham@amd.com,
	dave.jiang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v8 4/7] ACPI: APEI: EINJ: Discover EINJv2 parameters
Date: Wed,  4 Jun 2025 15:38:01 -0700
Message-ID: <20250604223804.842501-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
References: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|CH7PR01MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d939389-7aef-4f4b-2fc3-08dda3b88456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tnCzrD/Ku6Wn/JkD72oVb5lQAmSYYmC/nMy6KAq0M6fnBDD3X7MrUslf3sMk?=
 =?us-ascii?Q?IUIaRURjkR+3+gLQKSF+U6uSwNk+/YaBHKtaFLxuux4ATbshoRbmZBJFL6PG?=
 =?us-ascii?Q?lKPi51lNmzdiET/KEktEymnS9Tas/Nlpcl0SMosIiAYUM01d2J1u4ctW6Uzy?=
 =?us-ascii?Q?euTQZcLgBKMGG6JojhcGF8UjGnfuMa4lgptPiPsPaGjsjZr0ngO9+beW/yoA?=
 =?us-ascii?Q?ARgYOGL4wi6WxMQiUmcvExI9jmpwx2tob5GwRcKSj+3FFEKRtBvO4qKEVvXD?=
 =?us-ascii?Q?HGhhLOLGaE6Welpy3BAowYz2MKqKIdqfXD0BsbBUEU/1ZCgkukjxp128VCKt?=
 =?us-ascii?Q?X0rY60viBdBL+EfPudYejjQD6OTiSDrOaR9Dhwv+rfgTeiKQcrnoG2VLa34s?=
 =?us-ascii?Q?fYzZGxiYZR/edRY5RPJNlDQFk7AylOIV9EhUb10uiNa2EK2JLNuDeY99Hp0N?=
 =?us-ascii?Q?yVhw2PzsJspjDQvWEnUE9+iVP1IG8h8Nq6+EqDIzVX1RJwLP+jJ1szh6G2YO?=
 =?us-ascii?Q?WhaLofvoFJx4Bwq3KK8UlhyayIAMyc8FWIHMWZEpTzZi6hGI0+7sFc4KQ8+5?=
 =?us-ascii?Q?8Sfd/qGAicIviYqlj8/s/tEjC0H3KgSg8BIVAUm1PpD1EaBdi8q7CiN3ZqnN?=
 =?us-ascii?Q?jql81oOgIoIQTnoEnpIipYZHny0XuEEqyJRGVwwHR5XacLbUtVacBSu78Zeq?=
 =?us-ascii?Q?yJQKR/CfSLWiqR0UQq/cgCSzP69HwWxLiZ032arwFoboGonuHnp499UoEqxV?=
 =?us-ascii?Q?RrPyGGKvHXwpBsYmk/p0p4aEZ29zbtUPSCL4evkBCYLA6rqwgjl1rTtmpfZ7?=
 =?us-ascii?Q?zJMMYXN0mvdP5XXW6aOFy3nwzIlPHEOV9ksHUWlsMcTQRQ5o8aiPgBIKbJSc?=
 =?us-ascii?Q?n/dWI97uWb/wDZWXJaQaquuoEJQOZWstZfoKijelpb8hhJMzAknX+hzgi3iD?=
 =?us-ascii?Q?BW4c5Go26wx5F946iiQGXUpRFvNqYI9dJsMsHcbEJ9n274XCSBpYoyyIYJx5?=
 =?us-ascii?Q?QpYD+2TqcGm2/rK8V98oEleQQjl8xv2SEwghK251WFno0wJpGimRq5JqQyh/?=
 =?us-ascii?Q?1zTt2JKUktCoyzgzWcTYC5VX2wnVWr2g1iFTPR3/UkdxXKwkHomrCkh5Pn11?=
 =?us-ascii?Q?wuGXq/2G1TZCWF+S2uTiQlhp9lEXdxanKau5CRMhr878KJjsd/O2jF1Jx7Mq?=
 =?us-ascii?Q?8WdCqPez68c8LBG0AsLMlFI3cOd15Dmf/7xZzExHVHlGXX0itqZjBHK2RBGU?=
 =?us-ascii?Q?H/Bm+0O0rPW0lfFnutMATM2+6gjM9iTV1Nt5SGOFtKHz1bPN8YG+/r05Kxy9?=
 =?us-ascii?Q?Y3FaMr9PKBy+xKEKTx75bb2U+uDb1yGe3vVeL89gEitpHpvpj5ZAle+g02WB?=
 =?us-ascii?Q?BC/ptlV08N9e40ekm0YeG2gAdTRO8iBmHMRnSMoz8q82Kfjp6qtjVcAzULGY?=
 =?us-ascii?Q?Rgjthq6ayPNH6zUO6IzAG2Xw+VS6oj/kQTGTYOWyIGL7ImHLNSc+4kaJ86SF?=
 =?us-ascii?Q?s6WSkDrV/VyxCQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3gIW4g5HPzLaSscCSId+QHcGxuLdYGcHEBtbyr29GQ7fJS0E42BvziVxaJq/?=
 =?us-ascii?Q?2k7GhYCDtr50/gmrS4454HZbbxYWkX1p895J3cYGhFro66pCvawrdqf9t07v?=
 =?us-ascii?Q?SxMXpCwQy7tKLUCWZqM7f3xPgs46pVkVhMa98yd1si/mnlUNndc0zZ1pAaRw?=
 =?us-ascii?Q?ERPDcvZEY1PYWaUZTaOmF6wtF6YArw2MBZvUkVcRlNAxnHTxZ4isCUachTnB?=
 =?us-ascii?Q?KJ3Z5ZaeYd72EYdqe4CiubY5BMoKhL2FoB9iIIaOk6/0pgLMAWCB0iSuCX9l?=
 =?us-ascii?Q?/tywBaj9xqkAQPCeWVYw6OSzBual7VL8WScxM1LzvsqrHZJQE1JNj5eIdT79?=
 =?us-ascii?Q?30GyK5l9L6uYCPUok1zSifSLxnfjopqsRnXFq0m3nVf2cfJPvhcHSPaIoPs7?=
 =?us-ascii?Q?cKTZVJ3WpdDIOHBW/YWRqGn6vtbFoV3EwaMcstqwBFRhetWWrbpXCnkGsxoR?=
 =?us-ascii?Q?nH+Vt/PlSFx5TlVlyxFxCpfoHaRe/b9afV0p2zvOtS+9bQxfB1HXQ/8sxFRI?=
 =?us-ascii?Q?G5Wjl72L8SQOQxmvjJdmRZ4nESuScvZpELA2tpLTwhSrzaSgiUNGyNS2FM/w?=
 =?us-ascii?Q?M8Z+qzSigu507qoAkF2buI7ggI8+0BcRZAwunxyfVEhPIB8f0LxuEnTAr6dY?=
 =?us-ascii?Q?Juo3yYvDSbP1tKK3WgbxO61kcWtsGcy+NCrcl5+QRkdgXREZ2VvJ06WsRrP8?=
 =?us-ascii?Q?zEhDRFJ8UcW4wOhBGMAJtidWg1MIxuRUKasFdT7Jl2XCfON6QfJQJTZEtLMy?=
 =?us-ascii?Q?U4jSVGz7VsZzStmny0hl2ggeeR+/W12dwUdFZuEyD8wUAuDLCpbhxvh4BYr4?=
 =?us-ascii?Q?qij6YuFLThyo143d4vmfv8D6Acyaio7ldaB/KSYt87oga91qpMzuMBoPOt11?=
 =?us-ascii?Q?+oLCcEK5Pq1p1lVJlOBolLa3o5N6SUsKW18OEIGP0rxnMLc3CJEtABYqNmZA?=
 =?us-ascii?Q?xopISm2KbHiM5k46xQn1uez71EHID/XF57Tq3tokyQWcRa4RT7Ggr/3x5g3l?=
 =?us-ascii?Q?N6eNJnh0+Eud7LUx0LhzsO+dTeES4j0CYlyvrZWVsrJN2ugnu6LBr8k7bbSE?=
 =?us-ascii?Q?zr0Ah+E67x9QpJzm165FW/MOEktQ6Q3UOMqaBLHYQyQz/R+iY29/NZA4W9C7?=
 =?us-ascii?Q?dOK7T3QWOp0BGp2uMNgCDkqg3GXMWEAP5K7PBMlVDzq12Go2/8uVCw0BmpCl?=
 =?us-ascii?Q?K+9bHRY3VIptXK7e/zhKkG1wEvpF19tCcojoV8Xn8mn+ztr4ogfZHB4vCnWn?=
 =?us-ascii?Q?klyokzLJOVUPGXQor1ajD0V+resfpuFUKR8eNOQZBmydw1W/efwcZWyp6GXQ?=
 =?us-ascii?Q?nyOSDrpCX0Svd5ENv+3OVymNuVTM7jSobYj4mh19rZOYy8EVhuoZRd31k8/5?=
 =?us-ascii?Q?LA57Vg2GKgPt17F9G2HQFArDAhgRRcYd8bMFJuJkOZDQYTq47YEhdYDriNMr?=
 =?us-ascii?Q?XZhBBpU6tgVlZyz0IeaTmhMS5/R3H0I2HM4OZJMNJB8DvwhfEGWpmv8Lqe5X?=
 =?us-ascii?Q?pqy0L7LvjLikoSFnah3ma4Xm75glFwT3eC+iri3xoekErGEQFUaT/lhVAPna?=
 =?us-ascii?Q?fksi6YXYMv4UzvuSyB5s/GmD9bUPKnthlDt6iklX1omV60dui2N1N/JeFI38?=
 =?us-ascii?Q?GjWSjWlrBHHLTwg9wy4t6lo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d939389-7aef-4f4b-2fc3-08dda3b88456
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:24.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjQjQUUtXIqFKL1IrlAOEdQ+TvMc7rgiFtJIK0SMq5GWjB0xmACRRYT5EZsjB4/Q/PI0Th3sgdd5qr6ne5HHQ8R3usfoKq11szwG8c/WgJuxLWsppwVhRX2frUArpgzR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8810

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

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
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


