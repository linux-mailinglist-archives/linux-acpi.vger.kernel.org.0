Return-Path: <linux-acpi+bounces-10970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BF5A2F754
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EE43A2EBE
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F782586D7;
	Mon, 10 Feb 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FCxD+kA/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023100.outbound.protection.outlook.com [40.93.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6E257AE1;
	Mon, 10 Feb 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212657; cv=fail; b=SPJWceLmvOdscQyI6mXOZ60Ft+EXHtE8JYXS2XYG+bPOHGJx7y/d/STqpQzDWPn58o4I53iEw2FyvIAVNVtbU9CHLd/x1jMUi/xS82BcmzoQcNYr1B6djKl/9XSot639dS1VcSNW6eNK6h9RZR9fRooAPOraROCxO2/SzVbiwKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212657; c=relaxed/simple;
	bh=tKd3Wdmdfi132DLlASdI3LwYjH7gIYYd9wK7aaDg5Og=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFYsbYwQfq9MXU34X9G4AEL8dSuUIULEjssqJlbLk/9UVMq+HkfqZzre/wwUeFcjOABKaj/I5rinhGAzi6Vk61Wo8vfLLB615DKuGSlpsdPcuancQ3S9kEu5AAcG21cK9DUvnVIRIXEreegG6qPgHCsH0bY8k4F9tePYVQyuB7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FCxD+kA/; arc=fail smtp.client-ip=40.93.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ+lujOqrsC6GwZc3fGw41BjwpQ+/P5acSOeQEDmeLWR6WN5V0OFZyzOpMCiaFaNQvVTLOh8loo+oLmeNn0q0vBXER9teautwaeKdLcra47FzM60FN7Pq8+np27IVy7kkwYxVtnz232iCgRgP69L508mw49tP6pE2oO8CQziOJcXWHJY6gww6/g52CjkYBZ9HrI999Mz7j2g0FTbWEWIuPtdcNbCSjbWyoaaf2e0Qfa5oAyAGaOE9aOj8PHUggpb5xSrpnC7t5yQe4+0WSn8XITfS1XxQCULQ/EUhftNhOjUuqtgBdyhMfSiO2igIuRRatxZ3DVT5qoLlMCkwKUhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xzvbLKQRiJVuCe6o/6LenFFF0By9BCZ/ocwJbsVw/A=;
 b=fZRg8a+VZOPkrJzdHjPk+1Nq6JMPeEIJ+gAs8B7RlHNejvRq+t7kznbQnrUsPEB8x6DdqWgyUQy7g+d3GxIOz/jKG9vawO8InnS40QzXAGx06RR8uUsPyvXhqT/8okNsTINb7417Oyj4R8QEiGwPlb7/Ti0mFTYih2U7dNNhRTlzLEi0cLlVZHms0O2u4SpvKGOxjsBRNSR6CALYTK35vaNHeqXwVhIsTBiMw4gRt3prDYyEvv1lJsoF+rJfkw9hOtJtPTQ/qreaFxRJiWdpIoiMgXkY3t39VEr7wUWoafTitl/Bh9TQTmLuHR8Xdi2c8AQ7jHzIaAUsFzUlOu+sqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xzvbLKQRiJVuCe6o/6LenFFF0By9BCZ/ocwJbsVw/A=;
 b=FCxD+kA/04yCu3NJJmXBz8p91db64O+WdO19NlRedXq4ysnYlFFNAc/uAtnW9iBxLGIJ1OS9ezF0kr7U4vd70ZhciSJBaqmp9r2LLhjVq/b8NUYk2HoxnNHc52IrXQ/N9k5EOUrmrXy5lRHcHxqoRIjZOyczQZ+wchEjmf4Wj4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB7101.prod.exchangelabs.com (2603:10b6:408:150::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:31 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:31 +0000
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
Subject: [PATCH v3 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Mon, 10 Feb 2025 10:37:03 -0800
Message-Id: <20250210183705.1114624-8-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7e4328-325e-489a-2a06-08dd4a01fa48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KfyopRmojiOXLKRF81tlRMGu1NHuSIIMzmaEQJQWIl6/2LgGLlgKxQJbbfEv?=
 =?us-ascii?Q?kRSfMh0eexGWvB+J0l9g37QGTqUEAKY1qmzNzgWOJgaEsvRFIXHxZ42f4N2/?=
 =?us-ascii?Q?xZcmb2gLv/fLCWd0x0UBESHOOmnbf1qNnHVXqQxACGD1aVE391KpXrKUQE5q?=
 =?us-ascii?Q?ZG1KOr4OANdt4CEu+nl/56lkkwfkVgJySMN/MURBQMvJ/6CNkAblhlWKsmku?=
 =?us-ascii?Q?COnHxo+Od6KunFwY1EvsGjmfI3a88aQCS5EYkMosPt0/0KGsJWrckeDidMoM?=
 =?us-ascii?Q?0eNCNQVXRybb1RMJ0kDOgv+NJSeWF1w0wsuSOw/6I/N+TtyInvjZuNhbhd94?=
 =?us-ascii?Q?wlOGJAVyloHZ+GePuaQ5MVtibrpf7ljAdiwhjmk4CVyIJpXjIg4BGHmpmcrJ?=
 =?us-ascii?Q?2NQOEYeLv5PkzY+dlnw3x63fw+jYLWFxPjfHtQTuPnIJTdevnLWU8vJEZRWT?=
 =?us-ascii?Q?cUTuiwTUFJUXqHN1WhLVnc0Al58RwhywM+WZU4EcvFZ4LX1tQL+asAKlP6AP?=
 =?us-ascii?Q?o04LF2rAtuVJTRffGI55r6m7DTzAQhxuft6vhBehatLdAumrC2hTJ5POxQBK?=
 =?us-ascii?Q?Ma9meaMaLR4CW6W1Ge2zXLLLUHVYB4HP2/BaZE4dceoe937BXryxuzentrmX?=
 =?us-ascii?Q?ZNpfe4ir788vFbWJcKDYIMp3wmAxt15eBfgLNSVsqqpmVD/OTb3WjACabBhT?=
 =?us-ascii?Q?ZnA25arj1EKA545QHJAaabGllJ23i+wXyMB+ipuwfaCQvQksZQrNuZHiF8wl?=
 =?us-ascii?Q?Jd2x+nTuuKx6eIwYoNX5JCPwfPbcUS6fY0KHyeN2Y/w3pjvkkW0pWVyWk9Rp?=
 =?us-ascii?Q?R92BBV6LyE4FzUxxrheT6w0cHP+Hj36As5XAhdwY7DxX0d8PJlU97Bf+b9Mv?=
 =?us-ascii?Q?3LaHvUZqsF44aX8AKa6p068xVcIOSsq+XhXCzR7gYQ9j3es1VHe+lFaitYUP?=
 =?us-ascii?Q?nPsVZ207oXrPelHDC4FKCgWpaVaDKOQkBrfUxcq4m7/c4URFhWDVG29E2sEy?=
 =?us-ascii?Q?VxAz0F2nRBXiR4t6n84sdVDF4ZJdDVLuWkbOCX7J1k3cf4/BlfN5jf0vg3Yc?=
 =?us-ascii?Q?kp0EO5fH9P3faHBUXJhkcrS1L9QIZJJGu+C9ryi2BxoI9g/9SCTpcSKVuEmW?=
 =?us-ascii?Q?iYQbA5HKxCP0j3e+4GBIX854hyLf9ksHV/frGApCOZo1J0ghPZb9kDb6qeS8?=
 =?us-ascii?Q?B7x+SuPy9OTM2hTchHYE+mTQpNWt4x8SvSnzOrUc+1Ni/V15Dn1tDJEXzJ+M?=
 =?us-ascii?Q?LWG0Gh9DvxmTnpwvxX+vJG6fZFaXBBCd1jI2a/MHGp4XIzUEPMUkEuoTPoZm?=
 =?us-ascii?Q?eYFb1rnnGVaG64YLV/7ia84TFPRQX19CgP5IWexju7FwiDiHr/NBP8cMzF3R?=
 =?us-ascii?Q?dOm8gyytqHnS5pqFyeQK99zIpMbiqXaGPDQLmLQaoG8j19FQmkn6/X5OAeyi?=
 =?us-ascii?Q?FD5kpiIZOIsA9nPR4naQ9FU7gfl4EIfA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGeTntpSaL0lm0N6VXyMNmZKLPf6Por9H034lqlAYpc8c16vS8kIsfffNqWB?=
 =?us-ascii?Q?RwGAgY2hdK8oPR81/RTvDWEuZcVZ74cS+Gs97tB8myNNQ/5qxvLBPFayc2V+?=
 =?us-ascii?Q?7zzT4qYqe+mWKlftlmuVwwakzFx7x/Ak0TbeFl36MckSUvj2RkIjWZtm6kfz?=
 =?us-ascii?Q?BSe8Z8Gg9puE/84UPwztzlFtObaWPb3m338xRZKmxmtSVFHeO4MKSDYqcq8O?=
 =?us-ascii?Q?JiAUNd45mmP388oGzrSQKaLKl9zs2TNmEGtHwWiFwxdTgFC55onTgaKG7BZi?=
 =?us-ascii?Q?DGiu3ZMMpYtlLNi3Hab+rES254fY/gbWYiBhaQHMfN2r2iWwhzGDDFff9ESU?=
 =?us-ascii?Q?1YfPTD/jOsYvdZduM1TgNUecw11HnlQ4jesG5m1rwZHtBxdDXrUHTD6RK5yl?=
 =?us-ascii?Q?nok6RI3CT5l+5otL/HOn0/zQ1OGxsQVUOGyWYmhdaLjNGWSrKukiN5vrntla?=
 =?us-ascii?Q?iE3nkigJh86YOQ4U1+OSBo7WrM6tPUQu90e4DFl2681wVkmscTEUMhuTCcKA?=
 =?us-ascii?Q?Byd/wPcYCeqeQmFmOa0mUmVEOINrFQcoGM27shsUiorWDT8tNs9mwHB0jOWs?=
 =?us-ascii?Q?1woB+bhVSuZq4AhGWF2MEJmfwK2dLkLRSQr/JyvchI1bfqouxXPzpNBDLK7v?=
 =?us-ascii?Q?kzBEYMvCTs1OPSCI83n/NiaSfcp9LXi77/63voB8L/klDQ212oR+eGVMhHpH?=
 =?us-ascii?Q?SmzwzOY7AMTIb3D1YkrH8trtmIb6toWpkdNp5oaxd4NWg60SjNMB+w8c/HjL?=
 =?us-ascii?Q?cfqcPi50f2XsN7XAv3qOY5BATZFBxZ2DRRJGKUlHI368D+TJThkhMxEmXFzb?=
 =?us-ascii?Q?d21Em1PpQyGuR5ej5ez/2/tHfXlqgNJRQ2hE9T3wxtZhjBuz8KLTccjuZHTq?=
 =?us-ascii?Q?JMY+1yPpxx/9XEDF/x7sPmTZkkSigRrAlBY0wiBQ1u/TFG2EfZC7+TcA/IHH?=
 =?us-ascii?Q?bS5tOqzTdVs+odApPhuqYEdjAOF37xV0Osa3dK+SdFoIg3EQfMZBxeie8AFv?=
 =?us-ascii?Q?2jQqBsQH98i5Hl7w4D4KoMO45edemsIlWQX5MQxbgnf8E7nTcONV8R80mHAy?=
 =?us-ascii?Q?nPvzfjVuYyusfGkNObLHUsEQyLZJEz0lNF1xnsxtyBojXLMTBgUDw7obYsC0?=
 =?us-ascii?Q?ts2DQOdS/l39iNd3Z8NNvy8Am0E0ufaNym5lm8BbA3Ikx70XLprNRK/AXX1F?=
 =?us-ascii?Q?nmARn+UFabTPU6cBQYFPLOvScLmVjeMcvubjF3VMHRQsgu4xQNVGZ0cd6MfL?=
 =?us-ascii?Q?oLXaiR/1wAlVs9uqqMIdcmtzP21q5AitzRPe3j9NE3XmnsAs29a7h6A2q8HD?=
 =?us-ascii?Q?pCuyK7x1Y5/7RdgMaiZeLWY+Q6VYz1sSTDSwGYvkx8nNBirIYZIp4R4hBiqt?=
 =?us-ascii?Q?FLOTJf4CEnairwiUdoGqCRiUjfHgqpa0SRoHjtxP80RjTg/+3kZM94tio3ZN?=
 =?us-ascii?Q?SbTaxgAGwokUWF/AibZKcs4U4dtdm+2+JPk5Df/no/XYTdEDyvlaMmJat5bf?=
 =?us-ascii?Q?+6Q5Rxs2kANs0hhXoVZ9QrLWeS35fWJk3q6FFgebbpPGc9OTNrP1yuADW7ev?=
 =?us-ascii?Q?EgL9yteKW2ET2WrH2BYuONsexUXYWk1ZE3691VEFWg1X8HNorlvJL2tyiswu?=
 =?us-ascii?Q?EI3P1RNSgb1JwaBUjNCyVo8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7e4328-325e-489a-2a06-08dd4a01fa48
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:31.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVBGoXOEonoGRqz2NeE8JW7ztKDIvZD5iXoKzMhNUyWnQ/jtPCh1CkzJ98Dt5AN+nqJChtvUBC10n6DP3VsE0IcVBw6W1WVsMUWyqKhmFx1e/b9CgdUTITE49CngVhfd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7101

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index c604aa875644..40ebdbc4961f 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define COMP_ARR_SIZE		1024
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -107,6 +108,9 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static struct debugfs_blob_wrapper einjv2_component_arr;
+static u64 component_count;
+static void *user_input;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -892,6 +896,19 @@ static int __init einj_probe(struct platform_device *pdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
+			debugfs_create_x64("einjv2_component_count", S_IRUSR | S_IWUSR,
+					einj_debug_dir,	&component_count);
+			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
+			if (!user_input) {
+				rc = -ENOMEM;
+				goto err_release;
+			}
+			einjv2_component_arr.data = user_input;
+			einjv2_component_arr.size = COMP_ARR_SIZE;
+			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
+					einj_debug_dir, &einjv2_component_arr);
+		}
 	}
 
 	if (vendor_dev[0]) {
@@ -941,6 +958,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
+	kfree(user_input);
 }
 
 static struct platform_device *einj_dev;
-- 
2.34.1


