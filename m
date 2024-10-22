Return-Path: <linux-acpi+bounces-8917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7559AB8C1
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C781C233F1
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FFF1FDFB7;
	Tue, 22 Oct 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q2FahM8w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1091FB3F8;
	Tue, 22 Oct 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632896; cv=fail; b=Pw7OiyIF1vntuS0aQdCxDUZu2EqptWyw0xv+hHpmxnpN5bk/FT8ceySf/pdoYFJzAdS58Om0Cn3w+r//KG2eDB+gSFRJHdmggAJrbhskMhWMmkLbEXZGZMnZ/NEe1sNAFSolPxmVeyUmItQfp9niOeUgP+EZOwOwMGME5rRYZ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632896; c=relaxed/simple;
	bh=xLb/rAoVAFvQeZJ2UUh3DkSCfUUw1oR4Vh4V6xDf0jY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUGyI2C5d/pK7rIla/zuVsShtHT7rNMC6dPojA4I77ANqjt7Rh/GiUiO/U77Evwxm4809zrHjkkrNhvMNZwh68qkDFqVnxlssIVOk5fsyLRsPJIXQddalpdVXHZZZYEoxzXQY5PVZHRlEI0xnmqDCiBA9gCo/eqNaaFfi0ZFYIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q2FahM8w; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwxz3oIL2O/w/+hS3jACSF9BmiiOPu//2yq2J/xgEI7vYmihYpKXK8MBXOfFO9gl6U3+WXpgrqfABJMgS3/Msi6E/DBdYcYhQ+s3DZTwUuqjRxPqreG8TpWAKiKyqTZS++oIZcCz6uOY4AuekJTCT7APaJSc7aiAdlbMCOVN2tIGfEevuFkpJ3m48ATf7EX5f813YiyEBxaLTBKzYoZSZM306ltbiOeAuOGNXnHI660Al6gPnjBvzAzfMTFKqrRIrXaLblSpW29dkbHZufWJHneael50zsN6eYsH84guOuV9/VJO5v19oyVWOpJvRzDTGOCDn9Fo/yqeTxKfflweGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h1gd5ujYkh21FhkeF6/fcIKV0vmkyIgGaZWBOxJPFQ=;
 b=OXSP/vSHWGat2zEEMXTAfFJ4JRawHd3Ztk/3joMANTcBd6KA2fVY9C0hLzsTS4PAJc+92t2QkpwejMfjRMwvWOvm0xpPmSZCKQJTfwtr0gJS+ke9RmZYf9XXA1ejZbsX2+7ON158AeXeTW247aWS1UcjT3thoZCVOthal5qtSUMxilpQR7N7jN4rONJDpI+P/4C8yoZk0MTbeF12T51pnjfoWnWFoAc3vL4ud2bL9H9lTi3R2b3qjHN5oTcRpOUwd7B3WfMgXs2VSDOH1+C0KXix5uJzY1wp2K5Qc58BvBinmm+Sma3chgkfKFpZc0h2mIBby7b6p0K1viFhKtjAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h1gd5ujYkh21FhkeF6/fcIKV0vmkyIgGaZWBOxJPFQ=;
 b=Q2FahM8wnPbKnEtHJ55d7eh9dEdbenhvHiXoh9eLA+tHZzApxSz5nShY9ZKVVE8wsFeFOypUpt3iNHFExXVk/OA+HIoMsxSsR9xO4J3RE/bTTCy4/Mj8Nxm12tOJvzc2kwqLfbZmZXAFB7jB8n4P18Y2QqvUNHi5ywY0AqzHuAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:49 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:49 +0000
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
Subject: [PATCH 6/8] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Tue, 22 Oct 2024 14:34:27 -0700
Message-Id: <20241022213429.1561784-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS1PR01MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: e19714ee-d77a-45d6-8be8-08dcf2e15b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?que8s7NswWdER17tAUj2tqvEzv7BQl93uVN/zvWdlL5FsBiGiwZ7j7R2WC7L?=
 =?us-ascii?Q?me19BnXnMUhYnJ7rs1CIcYbf1ic4rvekOY9VE+RH/qxEiN9Jku1duUC70n+z?=
 =?us-ascii?Q?wN6kBS9UZR6RdDzKtwXAxMpfW72lMpF9juG1ZKYXXXdWM6Npt/7NTMPbUDeD?=
 =?us-ascii?Q?2DGOMvzxoMAhroi/hE3j03An3WmPWzOuv2tsUWOUuYrza209xQng7bqDKFm6?=
 =?us-ascii?Q?FxBJkZHfh0lV4REuiJEzcQkR4XmGGecrObjVyFkgurtNnQvMbxIZ2WYOjZfb?=
 =?us-ascii?Q?W0ZAGWL4UwWYpgCUpxQCjMedbh1shFO/YTtP6zEI9qIxWXzRwZl6HaSmkmjp?=
 =?us-ascii?Q?4P2j5lBW5dKp0X/hSLucQ6cqd1k0Mam42LrudlvIvS/UPLdx7GIJCdycE+A+?=
 =?us-ascii?Q?ZH0wrXqNGA/uC4RXMYGtot50RzrDmLe8C0Ct2hAj7YP/3NrdgMH3poQTZ+Re?=
 =?us-ascii?Q?/H3cRk8TUGh3S8r96KPDJdx1EZpFEv1LsOyyi0rOwoWZtnYEj6+kA4m2XdOB?=
 =?us-ascii?Q?hfXgsLzlcce1cLTcPM/sDAvxDx1XWIBnaToEUFjEBWQT7NYQtrbHhBmobhdm?=
 =?us-ascii?Q?N+SiHh9NN/xAkVT2xEn6e2by7eIbPAdU0Wisq5G/pJx1+Gn8yo6zyjMGXFYd?=
 =?us-ascii?Q?VtSd+ZScexL+2sZWX5d22W48eODkYVfWh3oPBHDuAOegfysssN1/wJ9oBxrV?=
 =?us-ascii?Q?sW79blOMzn7Nq0Ci7tL9QZlC/xgSUI9Vo1Yu5mpDPIyIJeG8VQiDV6pEBngl?=
 =?us-ascii?Q?yKZhU/svKfSujxeU++I2R8KfSxDARcfIH8V2oLIhf01zIK8taUdCFC80N47V?=
 =?us-ascii?Q?wBLRMD4Tyk3tgVs+bb4OrlATsjoOapFsbEWen6JK70RWG7BtKbfHgJfasfeB?=
 =?us-ascii?Q?Va17hRjorRkyVFTi1E7lEdUE0AzvLapK/SVB80cPJ6m3eoX71vk9X5YT+NEd?=
 =?us-ascii?Q?oB+Pbo8OQQ76TU+yQv275gBZHLgjMZ4oMTq+bIqlYej7V/7BHv57mUWY0pmH?=
 =?us-ascii?Q?c8SfRBBiERTCQuPsZ3hq5D1radiqgZVneYBLm9+RtrMdUlnEoRpbluKJJBSn?=
 =?us-ascii?Q?7pUJkrtVWRIMNguCXg9epdmQXTZ2rn64IPjFETEcI9zy+rHp+xB6i2W9DrYq?=
 =?us-ascii?Q?xV+lkijudHjywvlk0MU9zA07cgCUZTWtTZUZ7ef1qh/bd+IfOA4GY2GI9gR5?=
 =?us-ascii?Q?g8Wqq1cO6PJmHVqp+y0qagmoIYZEurzuHtPuBmHNsEih/x3an6COsqWFhrfu?=
 =?us-ascii?Q?92jl0tvoOFR+9HT4N8epAJcj6dUHugtt/LV0QmwrJSUqSg4IT83n1VQBzfJe?=
 =?us-ascii?Q?ZwudScb0OWxQbBLzFXun/dBgz7GBh2zM0soVYz0nNHHSdfptVJXGgrFw/j6a?=
 =?us-ascii?Q?gp2uT3Yw1NrXKXf62FcvKm+Z9UgY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a936a7gGu2RJnBy/SkGlQ8ZqbZHDa7WBqHjm9iNcCKXeVBzmNeHWjmzl3WQC?=
 =?us-ascii?Q?niRryrmLmDobXOLvNbp8x0ggMHr+SFmih6bChlPktjIYZnyy0G66Q+j46m98?=
 =?us-ascii?Q?4e5P/xktMm7sI6ZCEqIcVItGXiHGTmK0kaEb4ETEjajvLsSynMIaAYR1bFDR?=
 =?us-ascii?Q?rmko8fCJW3tETSW/RSIXuuyKy7X5Ur92dJdhAx00gt57wSduS8D2ky5cz3qB?=
 =?us-ascii?Q?U03iXOgvtgQKbDHw6zYlXN58LyyCbmg2w+3ExQ5QtNuiWGoJURwP+zSFr/9Z?=
 =?us-ascii?Q?C0sWjmKU5qIOMdVj6fSj7Ec5/e87rUB/VO0ICppvpkRy0ZhGQOoNS7PFb1uD?=
 =?us-ascii?Q?LisAZF6pTSFh+oO2eH/AFQHyhztW5SsuPDjPLB0Y7Ii7QaFnHB+vJtiQJx7f?=
 =?us-ascii?Q?qnrqMiVN8ZUDn4qCLvRcjOcEFe9xZYb5a8jR51vAy8tOxK8+pWTJMB6Pb1Lh?=
 =?us-ascii?Q?ePgETHh8U0pPiz5bc/LCR7qXi9KgYWFbXSmkeq3WC49e8VggWh7XrJhRG1I/?=
 =?us-ascii?Q?YIBIoBtOstxzGTDfWZGSPrDWRuvmNsMb+OI42qu690ZM8IvXmV4jEqx/jZlz?=
 =?us-ascii?Q?32xpcSpjNe76l6FCaPr4UmFXWxKlTCLUjkgCrnSkt7dCFU7d9vMC5xgp5uNn?=
 =?us-ascii?Q?xX8AmU1F/nK7f06wzRNa9Wsvx0LTYk8KINNBC08+u/fEVgN1Ywqhf+RpJr1S?=
 =?us-ascii?Q?X4df3AlwdzAxXezCT6vFF8nJC6w9TurlShekdqS1enDHaFp/LrDIyZo1TnQH?=
 =?us-ascii?Q?u7Cw514Hcj/3OozVhWAQvmBON+mHymKVmof9HqRIauL6bVW3NJpd3rA+wzYj?=
 =?us-ascii?Q?OYYt8gPW6tUao9pPczvdOCdZMLMuOMuYhX05e/BKJrWb4RpzblvtIsKtRH4P?=
 =?us-ascii?Q?z4eSSmMLxv2A3zv90irBqDf+kYnAK2lfm7DZDvcqZU5Vi46v618RGMpQl5jk?=
 =?us-ascii?Q?WAQBrOilVMNX0+O8e1c/Tm73w6JS7eW+L5UOsIJHW6b8fPrxWBIU9LYEXtzc?=
 =?us-ascii?Q?6f63VUZRFsukKc74Xp8v4LjHS2vtvQ6Q2leACzh7jcZq765emKwqpmvf8WBX?=
 =?us-ascii?Q?BK51lIhdDwHTWV1BIs4WBMFrGmVJ9VqeQTU0UGZm74g5ta+GY+8+WbV6Jh0L?=
 =?us-ascii?Q?ccOSwvGx5lnIikb6JXuBCYP93RN+2z4B0FBjPE0ezXkzF/jR5aqmwAjBtb4h?=
 =?us-ascii?Q?ukluWAxtg1/h7a9jx8yrAXqgB+k/CQGknKC16U/DVmd6SJRKHZm0v3pFzVk+?=
 =?us-ascii?Q?FMTXKSY+w9pMjhljvbV6YOwzVLob/lsx5hgIA6YX/tz4+ksue/OvX6fHGnt9?=
 =?us-ascii?Q?eKKf489W7G7XlbUb6SoqOP26ThMqrlHK9aeZwf4NGGYhtJeVqg0Ud0kfdrw8?=
 =?us-ascii?Q?lNZWFoAp8+ZAFSToIv5kGZiQht85JwSbpC9TCWW5+IGLq31+bj0My3w5H4N0?=
 =?us-ascii?Q?tY+titmR7l5LeYVMjxe9TvvDHgkM1usHX9ACYbInzdvgOexXR3lcPFT7Vz3H?=
 =?us-ascii?Q?1WqKTDMK/lVEVIGleuokKvbv2tB+4ECnO6kc/Dvzq1QnO59L6Z/H4WrHjCMt?=
 =?us-ascii?Q?dC/lByNbop2Msed7OiLCOpcGgpAfXzRbQtxxkf8Enx0hpa1gVwT3COVAhTAk?=
 =?us-ascii?Q?y9zgznsAi9Enqxh7ymaEoVk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19714ee-d77a-45d6-8be8-08dcf2e15b22
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:49.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdPoOvxBP363pie88LQX7rqjVFusOfzELCTmduN3msrR4jBdtpOlFykvCqWrkvO/yYugsa8olrhbxvt2s2dPS2/VnhXYvnoPfv3lR+j6dmVCSvK6Dvo2a8TBQSwsdWBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 31a13ad6c4e5..bd46a611eef7 100644
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
 
@@ -857,6 +861,19 @@ static int __init einj_probe(struct platform_device *pdev)
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
@@ -906,6 +923,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
+	kfree(user_input);
 }
 
 static struct platform_device *einj_dev;
-- 
2.34.1


