Return-Path: <linux-acpi+bounces-11916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B6AA55B19
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0B93B1891
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3A280A32;
	Thu,  6 Mar 2025 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EuLz0xzZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350B280416;
	Thu,  6 Mar 2025 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304935; cv=fail; b=mDnajY3GoVlREQ7EtFhjZHHLa7AZ43efcxUTyujCYxPopyrBMufl+8WON75hucZ/PIaSTFs0gwzxlWWtRGao0U2yRonwfK3c956P6lfuFxecFqOfpUkzGhBdb0zvz2IMm2yST30AMK4keYe5WVy3TSAxiue4E3CDig1ypjlYLbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304935; c=relaxed/simple;
	bh=ZjZviXPIirAjDGN3oriLz/ms4wufBmbwEVpvXjJOSz4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HhRysIzaCa149U8FOIiHfvcZfdNXLXnloQ58ePb/tX0+wta33Ld51gPpkXWYfRToY5pBv8sdzrq01PKPMPLgXqTOUMsIf/z6UpyFZXD62lGBB+TndJtGF8DGDVxOIVbmHmDpjx3LDJs2wdLUgM2S4DlZSw9thwKS+GUFxMWb5MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EuLz0xzZ; arc=fail smtp.client-ip=40.107.223.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx7BEWqpLD+LEIzia8GxBjAK7yjC9EdKVBu+pR8w1EZD+Uqx6EG3w38ZIg3lY0PSLg5HLFcM4I67YtXDIwJEWrUZkvNosqz91pc5jY8voBykPDZnqLvH0AWyQ9yNX8ezQhDrIcSEjSHSB+0tfqBQWDCZ4DHq7WvH2iyCvuRDjDdJrbDHkq4/cw7Dkhr6X1qOd8/L55ue/brpnxIkQ6m06SeboWOgGpcptE04FVSrVlr4ug6ZzoPqEF6k16wrSNvfl7THG1BGGKi5i3VaFdSJDhF1KYRZWCpyEdFAZSKmv0fA4hHcyST4nF4KCDEOCxvx6h9EObQZTHZj9ZsHaWqKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHlHK2klHplIGnlYIBeFmW6Xv2FRBa0r4MdoPHsl69M=;
 b=DylxHhs3UiqRbv2drv+S1OeagepNiiaGLJsBvD1WEkHWF/Wz3/FE0IyMqrJ8rt2EWMPPXhAeP/5QBVOVIREPvISDFrZV7x4IjxjVMnN8Agt9bp3G6OoKwwNe+KtI4xNcorTxXRnkyGrjtyh77ASN5xeR5KY9If163n6O0nrkTg7nWLpuFIEv7mA8X0HT/drJz7/UBzssu82lIoAF70tTfsPh/RcD2/3ByxBBf9+4qEdoAWAlW+awU3iSUT+8OyyND08snvkAIMoL+dXq2d/6A+53nOIXOipCxXKNelSB8D+sMjFnKw0pSii+AIzYeEL2aYuHyj+TIEbFBZMqwRpzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHlHK2klHplIGnlYIBeFmW6Xv2FRBa0r4MdoPHsl69M=;
 b=EuLz0xzZZ54jc6Mg/KdltAxz5wruyxWzmnfq2xPGLWI8NLvZPrcn1Kxt+ht5/mDTkeerO5U3B6H8zqKs+VO4Bwyd1YIsB+mYLwIVLj75g8XlgF2qO0/i0CBI8zh0NjCwBTVUmGBVBH+8VtqoWH7pc8jXA2n+bUF7OBIMTyHYH+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:51 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:51 +0000
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
Subject: [PATCH v4 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Thu,  6 Mar 2025 15:48:08 -0800
Message-Id: <20250306234810.75511-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f5e4e11-46c9-45ae-bd62-08dd5d097281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p4aduuz1UQ8mlR8sNv/7+VxRPkgDbiiWcUp1o3DzBr1y3d7zf1JjWGaVCH11?=
 =?us-ascii?Q?CwWQGnA1GBfuvOiZzpv4ZbR70cy0rXwNyFhbN5fT10GTgUPL1rk1mpYaVFWA?=
 =?us-ascii?Q?Kf5MNXFr1RTKBR+RyDfYKMMzyn9bsIH9zvjUbbywfQQn9I6m6poflZu/P2Xh?=
 =?us-ascii?Q?e6FZGode2lBWKE8mV81KT1NoxxEZNxi5QiC58hr9sBEUrDnmD+8jS+n+szWJ?=
 =?us-ascii?Q?yJvgaym2DC+GlzNzcy33qHJJEx4Lmx1rPJbvUI4YflDiIwrb8pIRXTJXBsnE?=
 =?us-ascii?Q?Bne08X3/fMbxKFOxBLGjlznCJ2eHCmQbM+2TqUFtjDoAD3kPPInI6NtBj8gM?=
 =?us-ascii?Q?o9dAHt7o2kieGSGa6YoGfAnewn/OsBD3U3g8fniYGNmqpj0Fb69bTtZi2pzc?=
 =?us-ascii?Q?GJWOvmPtD0BNVqWwiaHI1pLzr2vDX1KaG409F/ISk+e68wPTfaKN5yLhot/R?=
 =?us-ascii?Q?mSbKc7zXoWYoB/NU8rUQgbAUCoHO62dtRTw5l+rYOy7LSLrUL2x1Gs02okzO?=
 =?us-ascii?Q?xhK+ywuIfChy2j3kP2/coTXl4hpTApCHvhSwoGNJu7en8aQlbPOXn26doinf?=
 =?us-ascii?Q?ifOYxfpWX+yaY7wXVbYAqc4/LvPOgQ3lAxiPxxdyEGLGihpArJsFmGT2A1Wh?=
 =?us-ascii?Q?gNx2H5PA5i+ymZGR6Gf/hTwzSvLM6zHp25f+fO44GDiByRO4IZ546B8T77x9?=
 =?us-ascii?Q?Y05ePO6XgwgI0awILH3L2h8w9JySHndotqsRUcl4lJCtW6tUEM0fxD211UaQ?=
 =?us-ascii?Q?jX/ABjSXMtcEjP3NGEHLm0Mgey9sDlbUhWKSV9TRSBUJViFTg6a2YbSVQ43l?=
 =?us-ascii?Q?9lGZji3MhKURxIGMCvRhXzXMZ8eX+Mo41VRx4Mfeuto5pocOYyLGJBdPYh4o?=
 =?us-ascii?Q?GA0IDGQhXeplf2wWhu4NfSeXvx6TFwd5R6CQeL5kERiqp23I2V/foz05AS24?=
 =?us-ascii?Q?LVc+Rr02axTbySoQUxNHaLBHFY8XfOH7uFWlrlOERJ+R0w/PV/1r/l9SjVPl?=
 =?us-ascii?Q?ohdSWvgGwb6bfCbBdWbIto2XjEdmptaP6c7Nx2MJBkug+gUw5mU2WQzx/Eic?=
 =?us-ascii?Q?WExOUDVYbT9h8v7/9Ec6rlla2HYvU7qNFuiGfEiDannbz3UNJSkG/yK+HsfR?=
 =?us-ascii?Q?CJ9Lju0KTXgR2L88/n52CEEwFgkJgslhohUVthIS6IzUWEKX1sQUIdEjGUx/?=
 =?us-ascii?Q?IwoRIqBeXZHYpAHltcKLDf7NBsP3If/LKwJz6Tuun9+lqUHayBHlrkwnYucK?=
 =?us-ascii?Q?WyDrpvifiBFs1DDn3EVAuMQ58Z6J5PO/0WorV1Ed+uMXbhfvgrFbOZsQexFJ?=
 =?us-ascii?Q?FNC6EpRLBq7LLMPd48/wP/imhmKk82v4CfrjwM1sOLjeTzsGt85hF0ErEPPc?=
 =?us-ascii?Q?biLJDCKzj22JgElF6ySabNv9H8J6uukbBc52X512+98FDH8OdcmFOYCE/7+r?=
 =?us-ascii?Q?UBxd0+Bm2u/ey1cl2Ga6/fmoyvHfVGrS6JRA/VdqvEPVD6Ufibg2nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ifbghp76C2eXF89uk/GtwtJ8o3dylcWnnxeZJ1eQygG1ixSO7QPCYxOQbqd7?=
 =?us-ascii?Q?I3lAcHyelGtslqdL/J+Gu0gSg2Nt5XASwPsBTeBgqtGddLrMIPJKXTDZxGOf?=
 =?us-ascii?Q?7jRg7iRVJZ1xzleCHGwSAHi6dujIR+rJtq57IeJjOZSpKZOzW6Wg61venf/m?=
 =?us-ascii?Q?yFevaq8O3JxJq9pWBgStIF+qjw+rCmBXSHVVimEeEUwO0QYQfijspaD1gVNi?=
 =?us-ascii?Q?klsVsGq2tgtGVROoWvpOh7pCplGpSKrZ0+xhKWBOqsTyr/LQtQxPSDhW6lIa?=
 =?us-ascii?Q?mLZZkQvAkS69p6fJBMDHkYXWSJVMRn/MVD5E0ivChFhKY+nJ9f4rXNyFm6fX?=
 =?us-ascii?Q?S8z0zPFk/JEtvAAMOp6DS43zRx4Fp485NqGMDWcw1M02omvLMssIssF4G59j?=
 =?us-ascii?Q?tgGgMPGVRdetheD1oWz0RJpa+WuZnpgWNrmq+tD1ijLOF+tiNtLKi4TVSuS8?=
 =?us-ascii?Q?2AeCvNKT191mLf6ZsmI+76Guqs4k+ixfZpz3c9M5fL5xHwakD9otE0Ex9rBG?=
 =?us-ascii?Q?cOHCvhoRdkXwsls7RU4ea32Oub1ytskPCW3BZIuDwrHgjvR0UoA2XvP8HUpX?=
 =?us-ascii?Q?E+Q+Ekb3VW5294V1gUu8p2udQYK/dR7CEgjqHeS2eKyFzcTBns+5oyBEtHxT?=
 =?us-ascii?Q?ZRrEPmlNJcjxYx33O9OYyh1I8wZZgrogqDU+b+CVrUyva/dvInVRDCW60+ja?=
 =?us-ascii?Q?iSL2WLeFgMWCoToMG0TjLP6qfoV/tVAka6OshfRabfi1OBtCG1SpHPEWjWes?=
 =?us-ascii?Q?Ry8HkN1sFNZm424hlk4P5newBAkeIc9UR7ycBCxQ4UQaHxom7FWo61SxlNBh?=
 =?us-ascii?Q?Ujif5jVJvEJbwfx+ZEDHLPJvIYi10miaXkJuFjKw02RXAB9eJoN2iOTiA+/Y?=
 =?us-ascii?Q?b2m16E33QifqcGirKlLDtCGhj3Jyx2PpvEmps16FCRnrYmv7NMsw+49WyYqj?=
 =?us-ascii?Q?Idoqmc6wLiPzeTEVlFisQ7E8zO7ggzkpbhb+29+7kwOlwYLw7EgfjqC1ZCam?=
 =?us-ascii?Q?sLrNMIsEAGEMRP1kLFDoxluToMqUcm9+3iPxhD9SwNWPP4hTlzW4j9xjaemB?=
 =?us-ascii?Q?AQGhZj0IXurvfOwWBv6cVtND/k0oIrZqeMh9E4AVZxKSFsXeFGsXpWyYQ5Ef?=
 =?us-ascii?Q?8HUO4BErWw5PnY6jBhc1iio9oHYc9UvWXc/g2wDTk5+YZZUEnWU5qkWKNltl?=
 =?us-ascii?Q?X75vEhQ+XuManKOZYXURF0IQiqogdArHFM+Wd02qeJOEHpPFzylQ28pG8A56?=
 =?us-ascii?Q?noBIA/EEK/Tb92rSRChBtBb4mOtwYi4xIDtRKWbRdo6eF1qoiQRUSyJZyd2g?=
 =?us-ascii?Q?nMRcJNUEfbqe/IglGCUlCuSxIUtya83WWmLOMo5FvrRKI+CMwz4OThkjmvNg?=
 =?us-ascii?Q?SQ541RlD6540rqDSrPoVQcD9p0LOBXK+S6/CXdvMZBIV8Zj/aNjZ9IFAhwwA?=
 =?us-ascii?Q?omqtJy+vd0GeILrR6ZNTFuWIZE5Rfz3Fl3VlqdMAPH5lQX1N6SufCaPaqOtF?=
 =?us-ascii?Q?DZrVxhTXT2hD5cs60srWBoh47M5cQUs3hW47tR8AhAXTaIF+vFzj85dW0hY5?=
 =?us-ascii?Q?KvF6KmccrMWdJU2W6JLVICbR5a7Z+BDpUQwcYZ3wvydx5EHyGPi+b/AKJM6U?=
 =?us-ascii?Q?sZg6+NzWEg2UbfHR73Q+eMU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5e4e11-46c9-45ae-bd62-08dd5d097281
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:51.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr6G62VKtnQkZbF5qYuugJBpWOeh7AJXHs5VU2sm7cZIcS7mdHqnNkeNV8XKvqFT3iH7UR29T8lAMqRTYaHXWjusn7M3m5pC02Le3OTtAFmEr+jzElr0dcZS45ytVQa3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 32b8d102f399..4c748fa0a479 100644
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
 
@@ -890,6 +894,19 @@ static int __init einj_probe(struct platform_device *pdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
+			debugfs_create_x64("einjv2_component_count", S_IRUSR | S_IWUSR,
+					einj_debug_dir,	&component_count);
+			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
+			if (!user_input) {
+				rc = -ENOMEM;
+				goto err_alloc;
+			}
+			einjv2_component_arr.data = user_input;
+			einjv2_component_arr.size = COMP_ARR_SIZE;
+			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
+					einj_debug_dir, &einjv2_component_arr);
+		}
 	}
 
 	if (vendor_dev[0]) {
@@ -909,6 +926,8 @@ static int __init einj_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_alloc:
+	apei_exec_post_unmap_gars(&ctx);
 err_release:
 	apei_resources_release(&einj_resources);
 err_fini:
@@ -933,6 +952,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
+	kfree(user_input);
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
 	apei_resources_release(&einj_resources);
-- 
2.46.0


