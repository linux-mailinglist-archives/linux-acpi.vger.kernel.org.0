Return-Path: <linux-acpi+bounces-12717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CCA7B24B
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720CA3B9AAB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439411F12E7;
	Thu,  3 Apr 2025 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WFUQ4K3D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BF1F09AF;
	Thu,  3 Apr 2025 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722049; cv=fail; b=eTWUrto+6YeirTB88uqYYHFuwRXYnieLMIFQGzrKDwOF2hzKgqmLAtfU1Tkc3bc6OIHExYX5R+p/W1i+6Z+Z18cxYhaDH8ZB+43dOysq5VGjLv2NM3B0IDxCxt1wXARAy3rr34I4ZCoCQZ4Skz+CNMQVVhKT5mgmQa+xGqDn5a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722049; c=relaxed/simple;
	bh=lstlSZ7XMXsrplDA+YRXXh+sh5eYzsb+Bzo5Q8i9r8Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rmy24WEmIRjym4U29dt97j5KKCm3t/7TYRUnU4c1MkkGiTrHaD7EIPCLm4UeV+v1aePC+HouPT44tBrwvirr216hSx22S1rKu0jElbKFjD2CFTDaZK2erVxpwk7gIsnzKB8oe3XApodNsE3jEWmkPPkiPPqkigZX3p+d3Mtaz/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=WFUQ4K3D; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+bqjCSZfOPjViZVhc3Kcf0P1JS9cLkvqAnmm+cH5WyfV47JylFG6+MlFQfGF2n6OeysdGCOI5q7FxpBEBD/cGDyHUhaz/2xEbsMRRP/cf1IajEquFukWYOLefqbouh7rtt4fK+xPD3EHHXg0sCLHhv8jWXFdQhrt1xZ895+a6ikP5FdXnaIqkvdW26YcsSEf2LTrk/GHlDnt+fHBimaqIYBrOKPVmq24b8ZBk4EN4d6HibtJ0wKGdfltCAB8xxFydH2kyThaMqtLMOx5X4p/zFDgIYe220FIy6LLgcFt2hxUwNI8al/tn9nd2yVmnKuT0DcYlQvEhsO6S34UMzAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFeP4KcucCQrGcRiL65WcPBiuZolI4awpICQrs9qdlE=;
 b=LIVm0Vr7za06jA+//8Ow1TCSRvF+9QEbc3G0j+RxRyYiA8ncvFBqt6bejYF5nC4SnsCf2ovfhXn64oBVEHR7Du2m3JzZIgmXMU+CX1D8WjOGECFgjjO3K97MWtxi5XT0lpx2iKpJNEJa/0F/5+3MUsJs2WFNgMYyqF6dqLcq33xhX+VrldtDCqq27zKxUKyPOi8U62M5XURryuGjiA4JsVYRb25BQ+OQD+j5+FE/DaMfSCx5/qylidzgUOelm3jXroeoFzjVS2igL2XOzsiS5oyIZDUHpUBCot7OFuwZtt0sUKCeIlZvkz7ZUeP7FeMAH/8TwIeYgkXk+qS20tY6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFeP4KcucCQrGcRiL65WcPBiuZolI4awpICQrs9qdlE=;
 b=WFUQ4K3DVTkCSOn15rKto/lJ0hN7MDV4fID04lDPJSzGwyVBlVM9KLk/ff7mrXO03B8nAENz81Pr41R+QaJ43IFDkHLkS9TRCNYQpZiIasTs3akME4sfYnH88qs528p8XcQSRWV6yURhVkEiL7qYTsdtDZ2jyn9Uh4qpVXCl420=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:14:02 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:14:02 +0000
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
Subject: [PATCH v5 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Thu,  3 Apr 2025 16:13:37 -0700
Message-ID: <20250403231339.23708-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0d4ff25-a240-4fc7-0b3c-08dd73053904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PXlyNA4xgTIKzqnWbPvH4VeHBnpAC+VL7jmruEzTV6ARHx/jsLPNrrxe8wj/?=
 =?us-ascii?Q?Xe8EmXTe6GSQjiBwxIfFKh5iYEezgJiJlR4ToKmjeM1WOUI3ESoJIUNWS7+D?=
 =?us-ascii?Q?YlIkovFlz1WA00QJmxsbkQvZ2DvONS4YA0FfKooFR+pLD9x9WpRFFoT8v8l0?=
 =?us-ascii?Q?fENc9ow0FmIzXKKFVu2odClVsmBK/JssS6QI7u8rVQRsjHA6uUSP2XiMh4X7?=
 =?us-ascii?Q?E2W0g9f4gNw4BIjOkg7gKhysUxr0bv1S+YB3shRe5KPre1R9bLRnREXO4dqK?=
 =?us-ascii?Q?QCOhl2Qdr8IA0OhT9k+enntCt4T/D2G2PCsEANYKeo/YkmcpP8299eONMZJa?=
 =?us-ascii?Q?aPz6mZvJHhSqQ0BFSL33+loyWrMGe8EG8FAlRn6IK/5yHeNJ8Js0fesX4aPX?=
 =?us-ascii?Q?z3NP17MFSGmDigJID/aSE6hYf62SR93oKtWsTKyGGBzZss2/3d55W+gqn/tu?=
 =?us-ascii?Q?x65Ge8IEO9JffX8Gk+rIMMtbJZjIlozx6qo0+9axjc0r7Fz35HEq6M7JW5dC?=
 =?us-ascii?Q?NNGz7aTjl/zjpKPFbRrO4j0r0pOVIKqKY6gF3DzoF6gWhi/LJJ2djCqv9T+s?=
 =?us-ascii?Q?lDOr+FCwuEiEDg81w9etIsUe4ObFw/gKDvyKOvVz4d78K1WlXpkItDLPk9xi?=
 =?us-ascii?Q?Lg7U4IlvTx5myIoih9NnBElI8v1kIs2qLua6onCrai+i9FjEgI3RuIG+SSaW?=
 =?us-ascii?Q?ZBTv5ssKfQamVuKiVybWPZ+1vFs8kGE2CMHWvR+Cpy2pXv7HEdU7yOf0gwT0?=
 =?us-ascii?Q?zvJ1aUYHbe4F6LPOGlr1pR/GawvZXyuflblq/SljBN5azn0z735RU1eejbA6?=
 =?us-ascii?Q?uQhOoTed8QJyBqUS2EcWi8SH7TR7t1QNk2wK3GHAobtukz6tDbpWR1QRIRiG?=
 =?us-ascii?Q?sA9EowSJEYuRx9NqdS22HVRmP2w81jcxdBM8IxOiZk0tODqvm/MeLPtUl0Hj?=
 =?us-ascii?Q?vZtqWaxGqsUs2WtBluUQIkMlMnWQv5l7KMpZdzBB3sVU1EBP/zZ8cvWFxGjt?=
 =?us-ascii?Q?XZKMO4UTXWtZ/cK6A2OFpCOLD9uNsFyvgKeIQsnrTuAbz3/qs+QxeFD0yQQx?=
 =?us-ascii?Q?UzLu9Ub/HIOHGCMh7NkfsIIWNzWJwknxKap02AcTRpSgDRXClf5ht0zMVnQh?=
 =?us-ascii?Q?u+frqszEtkaUm3UNOfGWfDLsRNH/Ha5P0H8FM2urYE6Ay/AACv03KzqXzQ8v?=
 =?us-ascii?Q?K5IhhWBhAERtTpVUwChQDh999vDf4aaMhhCTbYnhMw41lkkUIYuAHTrtpD9j?=
 =?us-ascii?Q?67pR9o6+24KsR73jHvVLfrozaLqzywZGrqfDXenFgn++RplebYWfuM4EPJM9?=
 =?us-ascii?Q?cVZE1/OEmC786TdbwDcrTkGBdaUbpAm8IH6sC7o3fMjFSNXcLoCz8K3GPqAC?=
 =?us-ascii?Q?P361h2HG3iE7+bkU4Xexp7iI/ibnKGVsW8cS0M/RvHvTcMRHcsDvhcT/yl7y?=
 =?us-ascii?Q?83z3s8hfIr59SEauzt5olOChfMlk/XFgAx04l4lIjUlc4M+HSSzTGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7V3RYkeTrBCoIFKyCbgvOM6fVEVfQ0yHy6kaIcwFywx8ykijaUyR8ygJ1ydT?=
 =?us-ascii?Q?mwXjEFiaJ07sMT4rEHEuDMVXZaWHzJIlK9KQem/R9veigeWUqoBPaPVzv2dv?=
 =?us-ascii?Q?s3Z5mg4GsMuV2gMXZK1ylwGpS7p1TEHEXzZAglnA6ikWtF6eqXyQ05eR0Jw1?=
 =?us-ascii?Q?SajhZSfUtRCij3h77Xu3TOy2j3PQzON0flXguDqyBm46a5xo5tp4j9EucqQ1?=
 =?us-ascii?Q?7rE6JKoXI5Yp4yrL3pZu4tbDSRP9YGkrawz4kiqnIfZwAMAa+Bw9xrBNKdFH?=
 =?us-ascii?Q?TbdKwTMaI8+cgzkqjQAzcjLrvTUh62904oScGhiL99qPgNTXRc1aXv3DR82H?=
 =?us-ascii?Q?U76X8JoU6vBEI/fi3auzr+hSnVHL6K1rUwT0o7h5nnGQ1o30ABKNufWw/WmG?=
 =?us-ascii?Q?/vxnJ7heDHhvxhNlnhXlnxaRVPQwxwSsp74OleKaZ/Bhfn0I2kiPG6eceOP8?=
 =?us-ascii?Q?SMhYCfRWGQdFrVLeN70fX8jv6QweLJ6DS8Bnn7NBtjpsBC9IgnJjK7ACneXu?=
 =?us-ascii?Q?RBxbrjARrzhZMto1N5pKTn/Ch5kJCEn2PJYDB1QGYMEeKsTPtUUiU7jS2tI4?=
 =?us-ascii?Q?Q3lR4yP08aA4GPHFbS/vxsoMQ4IVoge3CimhrZGfciD2gP1BtyhOWlqDXtR4?=
 =?us-ascii?Q?7kUzlFPeCJKE9xfrHQqor6JyV7ZXgtc7i1hoKeRvPqKuXPZMdXgp3bahNfGS?=
 =?us-ascii?Q?v2U7fFfGmZP6FDc8JoHnJaAr+CsnzAoTouZ/nNy6ijnBX2Oi1f4JNjWRfUs5?=
 =?us-ascii?Q?RlGrOW3rEINX4/Bu/zQBrUUff3zxe8IMuxQ6G4trmVPwQhwkp4FmDY1M+2P+?=
 =?us-ascii?Q?b5vdBSyeesKzk+ebdyD9/siq8umuROT9K9EMUVKwMW1qDeZSpEreRpRIzw5k?=
 =?us-ascii?Q?toplykTftCvMUlewI0czDTE1D4YRdaivqXHVil2PuiPvcnnjN7gAe+qGwclb?=
 =?us-ascii?Q?wCprlz+7s3xprpLwNmCz5vcqD/qZMYkKOeJW8FxLYNLG5Cb9T8/RYmFfv2aw?=
 =?us-ascii?Q?oKy+Q2VbDoGOvTQS3Mpyag3gpiIw14jT8f7JS1lSyktBaz0PIzeBdyXKN0RG?=
 =?us-ascii?Q?owTHFFJiYwsIF1YtWWA0D1zfU1ppl6/TZksTUgnmFPnGRvFcSQmDKKBNjU+h?=
 =?us-ascii?Q?1Aw3QjDXNgOJkeqBJ2OnHcZ1I85XWa7Rr9oRoixuiA+TPtiinYDuYYnh/2ii?=
 =?us-ascii?Q?IkYtIPv2ZebHI1J/rftX7BU97e37MkcKBEyxxfDHXmogwP2fiwDVN/9P4+Iz?=
 =?us-ascii?Q?Cwv/HgiDv2GEa2YysV2KZZJCXO0jfEZPXEQhRAgynOv3kj2G0lpRkImt0q2O?=
 =?us-ascii?Q?Lx6N+tT2EvTLDEQ2GQFKVGp/AiSExnuvYW4GP58L9q3yqm7rLax6OqVRjTsU?=
 =?us-ascii?Q?UKis9Te+myPT08l8Xl37B6c1lKws1drO9kh4BkgMswmY1MNNHJBteB/KDuCz?=
 =?us-ascii?Q?MkMCNg39cZa04yik1DFpuSvN1zdd2/r6U9tKm2KVcThw2XMBdzsIWPXzmRwj?=
 =?us-ascii?Q?/RZRhrEHkqoYN5Dn5ZmNWdYvWSjvtz7n/zlJO0+/k94IgB7L5a+ggcU9p8GF?=
 =?us-ascii?Q?CFdp9G11pk96Y/SecoBcsGWHHSapPk7m1lH+Oye7HySC59ByYPwZ6NRr4RbI?=
 =?us-ascii?Q?0LgZuuOXKhOeh8XbD/sqwtA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d4ff25-a240-4fc7-0b3c-08dd73053904
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:14:02.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Icwk+e3P8wga1vTwWYf8GhaSsfpNEtQhm8xUGfTNkTn9VfybXttUfB67NKdJx9cdiztoRxBLJbwPV4fwkWfhCZ3B6QyYnCDnOaexZW2w7I8CB2zLSyQVRhgiRiwBBkyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index d1ddc82744c7..dd7626da360c 100644
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
@@ -107,6 +108,8 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static struct debugfs_blob_wrapper einjv2_component_arr;
+static void *user_input;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -890,6 +893,17 @@ static int __init einj_probe(struct platform_device *pdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
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
@@ -909,6 +923,8 @@ static int __init einj_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_alloc:
+	apei_exec_post_unmap_gars(&ctx);
 err_release:
 	apei_resources_release(&einj_resources);
 err_fini:
@@ -933,6 +949,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
+	kfree(user_input);
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
 	apei_resources_release(&einj_resources);
-- 
2.43.0


