Return-Path: <linux-acpi+bounces-13106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42164A92D13
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31E6188DB99
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D02221736;
	Thu, 17 Apr 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="f/7K1vdz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D62221577;
	Thu, 17 Apr 2025 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927250; cv=fail; b=qO7MLgRin6QEXWhp6iS3TO54/5aDjxZvqjsCisArLqM9SxVgxnPVILcIOACZcUANRsUVBmG+rX3B7phFnT5+M6kd2sdURoWM9IgpKUVjWb2/qqAkdHJQiyu8OSPLuDC5E7ysTGZc1kAQROfpZKvuXZLFGjgj3v9XEJP3XvzQW3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927250; c=relaxed/simple;
	bh=HESRGjfbYVVJKi+eLvJZkbNDnJS2bwpLvNLcvMU/aA0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTAoIrfr3q0P8mPaFwbFA1BbA7VeRPXcbt43NiPzAKI7Sk9WKjuUWGsjaCGypv/1otXovCjAL+4zHJhKc74D2OzOzeTQxVtu/kLKVJpBdbObJrvGB1DZyIsqZRPiSR6eTdKN1sPTa3sZls//0Q33EmVVWvba+Zjm1w/1UFPxl3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=f/7K1vdz; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI6slOqAu+uDBkAANZlP56eOyr7MmGyx9KmXKICNELGbeHUv6GqI35JZNrFnvF/trpNXDwaF0D0B7MG87LQnSvShd+SpunCy+Ku558nt/wB9LoPTnUvEvZirzGLn0L0xWett08aEMNbrPdiGQaT7Nmap7DnsxIwgKl0Q64O8W7mp/6ArTIGGhzLGshUQw+jvyj79/B8P5CiaS1p6IAa/L6/hsmPtewKEVT/Abhdhn/lzJBHciAYtNIwgkM32mdszX+v740wmJlzNl1LGA8EdFp9Xnk1siKheixe2+Vu3M6JW0Zl9EDH2P4S6t/uRFY+N9/ctPYGyXfyry7fMcFRhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+s2chpCcfgm454VHOiaifyeDxInp+Kp+bsxGCxZVo0=;
 b=lYdQM3hLHq4KqokbdKuezg3ySfI9HZcheAEn8uHkVKixPwkkciWAXlo9GsDy32tqq6eYt3S6SXhFJxzQprRKp7ByA0ANAXhDqdPH6rcsE8PoUUWGUGopa4CV8ilHWuPZpBbq7lmhjT9YsSfSoY5a4T6WqmmFxSCkub/Jts1J/BFt4jw+gyAFoZF2lyQKsZup9SPuhS09DIqH5Jyfg8CZGsAkyuj/hi4p6DI1AmAXcT30odEzjI8TFUt2JO+MBSFTtizEmWOR6Vy29c74NviDCSPVELZpkDFL4xVmOyavcCjWM9q7sDxMaE7lwSbAGsroCufO/Z8AtBA1pEzu6K4UuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+s2chpCcfgm454VHOiaifyeDxInp+Kp+bsxGCxZVo0=;
 b=f/7K1vdzWmljp2dbxDkQIhTfWgQ7QslgDU4w4QCcQSuils4tPENZZPPuPqAWkJllu67pa3TlwzCeYkihtNED1YgPHHWnZSIC06Q6fWLmL9kIRs75wmlgb3qqx5mvAzy3gYIF5DBfy3bOrJrp9ewIDPpL4oTRDxv+RojT1l/D8DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB7327.prod.exchangelabs.com (2603:10b6:806:1f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 22:00:41 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:41 +0000
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
Subject: [PATCH v6 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Thu, 17 Apr 2025 15:00:17 -0700
Message-ID: <20250417220019.27898-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa6781f5-16e6-429b-285d-08dd7dfb4b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dY5waXHTybDUdcBoT4vrMvLpPVyk6IzdOxQWbyINnrmsYx48nuZvz6jnOKO9?=
 =?us-ascii?Q?7AonNYouBU2qxHGCrhb5YJJ65D1CDHhzbA/o1Or8t/xLPUWz3o6uZBblNdGz?=
 =?us-ascii?Q?uWurbWw4GIp53lYYDQii3BOkdvUGe87HtFcUFUA0uKJSs2R9uJ2/mfXlVmTj?=
 =?us-ascii?Q?YpJgZXDyi5I9qCP9P28bGUEfm15X8tCtOFMBh3XuOznD6NgDZXkVdaNuPf+U?=
 =?us-ascii?Q?OEcJEVYOMfZI7NrsWhlIKcCcuXAelFW4Dz5fnkgfg+OLWhihIX7CVVws/TXn?=
 =?us-ascii?Q?vpWdBuBVgHmkF4UJQctSZAhNgily4sJtszlvB89ci8AtQKCaO8Y4XVyH6xkJ?=
 =?us-ascii?Q?DwbqGGAbg9Xt9lMHk+I5xm8OYr5PoYlVrhclaSYxd0eW5HRzR39lJ1uOSXEa?=
 =?us-ascii?Q?ZBiPyU6apG4g421xSFp6MKM7FupHvVyb8Sw45lSzLf6928eVqqb+cBVj7vKz?=
 =?us-ascii?Q?issdiNJc2hDpi6aFiRsJPRxzfw5rdekIXVgOAtAC+g7bg38Z8++vuImrU6hX?=
 =?us-ascii?Q?JRsXYcntyG+9I6pFJl3TNCMq1gAgW+Dea3WKPFYg9S2FhVRDfBpJ1H+gTUy4?=
 =?us-ascii?Q?Kct6deQKKovBpGLU5R0FhdzwhVWo6wLApQgLMIOLcBksr+2Ltx/4TeSj/3Yp?=
 =?us-ascii?Q?sufjnPcJMt+35Z69SuYOtsN5vh/s7eZV3BbZXGyFsAXvsPhwbQHdKvU5U7fE?=
 =?us-ascii?Q?vkpTQmwzyLyzcFfRg4wa9L1y2OkMQYkhSY1EuUUaCYZixM1KRXBkX4VeEZrL?=
 =?us-ascii?Q?FlgB9yflw7TwqrjczqepNHSHBV3xFBByaMjBd1x7Y2zYA1Yz/TBiWdQyuSOf?=
 =?us-ascii?Q?L9kCGEaDb2SWrMLC67DPNplbPfxFOf9YA11Y539wXzCTOXE59L6dSPx4+3p5?=
 =?us-ascii?Q?32BQ0N5TqW5dLVUj8LiNORmmbalSsDvHHyt4GJUEP30kZIDrAz1f2Y3p0kT0?=
 =?us-ascii?Q?8E5RfI6CLmmodkkSVw5RIDp+ndxHi0FNDOApQBnaHRtg5booTDgpsW0RreZW?=
 =?us-ascii?Q?pANtw9/HicWENdn34/OoBXjcPmOjufpnPvlbriLsx8CCZmHf7DqEFJjRI/1y?=
 =?us-ascii?Q?n0LPDXNThfnQaYIgil6mDRQiIjxuNSIEIR+k/OvASkC4atIoeK+TR1wvg5Pd?=
 =?us-ascii?Q?n085y61RX9Nw03j7XFaL5cNOCVBJ1j8MZaLPRcHxeo1Hi/YcRzXemBTCtyMw?=
 =?us-ascii?Q?N0uZRyW6dpdLTMWVdUzji8elyrsbj+q66QdlHeT1l0M10dW1OyUy8D+5QXP+?=
 =?us-ascii?Q?pfzqhNTiGve+XYqqG37iyDGUGt+OYQee7OvTyeG9Ax8urb96C6EJ4u40ntqx?=
 =?us-ascii?Q?hIz51IbQ88C6Xbep5O/8mFiW4q5fAccer5QvKg+hrZd2XHo2esIc2cEjZiM9?=
 =?us-ascii?Q?9/oKt/14xgg7JSrAqUljguZ2fZ2s0qW04dfJZaPoASm0aLOp6nNgu9xThijy?=
 =?us-ascii?Q?G98MPmP1dwi2zhc7r+1SK47kAXasNPdDSGs+3A47zljdjkrDhGLXF2AxQ0Xx?=
 =?us-ascii?Q?295PMuUDwuvQnzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTk2DoiJB6XrpiMDC3JZNAAA+wYU0uHvQ3rL/+/cUnFl+RlmJfhAiqyjoh/U?=
 =?us-ascii?Q?rkGcYmUgIRg5D7WzOx2SQvbkpnZ5EP5R9fsvgj5oNwGa4tAp/dr2gkcBAIsX?=
 =?us-ascii?Q?vD+weV2lUYpQBirfoHkzfS0uzmqC2+kwzcEPq234kTr/MiBaqALNGDAXqaSp?=
 =?us-ascii?Q?KYUPxlFEyBrmVFmVomDRuK4E/9jctK/wo5eO2bjsdfvNU9Y7lAVhRuttKcT2?=
 =?us-ascii?Q?ArfLRAswi3evGooSfFsPRNlMorm3Aw8Rfwmv6jQwMkOII6Hw6v3sFk4Ls57o?=
 =?us-ascii?Q?sKB4QUxCJk9K5tknQXSvCzE3wOtj4ZJu29FEe1znIP30pRtL94EpQLBpNUR9?=
 =?us-ascii?Q?EjMGbxnormivm+YXYf7sd3C+Me1eGxQu1XJtVI+HCFgkKgGWeSaTC9sKLMAs?=
 =?us-ascii?Q?jcrvIFcW50rc0aaUDgtrJwIfprmOKnbRgIPP2FST2UblXBKMY1iPL/J9pb+A?=
 =?us-ascii?Q?8OZT5+aV0XL4g/y2f+keULCJWVxoblk+hn53ZGqUajBULFHijOUxr5Slfv/t?=
 =?us-ascii?Q?vOCo0yqJ8Wa0u0CY1oc35mQtlMUrvvqmjnt/2j1MEW8fcCLq/KZmAy+HQSDU?=
 =?us-ascii?Q?/DVH813Je+V9ulQ6NwyEbMFzikgvru1Dyw/AobZRY5sL4Denu18nzmkVPYej?=
 =?us-ascii?Q?n01ZEuIqv+JPhYkf61epaS8p627gU+KxCeDEzy7X4RoAKIuhuQGUYuKhYZPm?=
 =?us-ascii?Q?HvLFFB/wOxugMXcGlQ2nwn9HdXnEKM5WCXNJ75Px31XEW+7ub/UiMSwYCg+9?=
 =?us-ascii?Q?+U7SCW6Bi7vwuT9vdXMStCYTQBQo90g4fWKDpPkm0GW3l1jQnlfgTrnDo3XZ?=
 =?us-ascii?Q?dQ40yDaXCODF/zXDORfLlEG8FFFuT9ztK5ILw+OVad952ujh0RdJugUCJAeD?=
 =?us-ascii?Q?O3j1fUB83QdGTrtZ/dH2P0AHBNQ0yQKTdE9EDa4skysmeypBEQjDWi+2V1Z7?=
 =?us-ascii?Q?47VCaS2LXC0V033bAgxxkketsBnHRYSN3Y+TckAzmVxs0RsKrn7WBgQGKJq+?=
 =?us-ascii?Q?yiRJDfOohIVifTN7I1fYJKtDCHAQLsQZtMVHjWIczVcQyA+k+ltCn9HDWwoa?=
 =?us-ascii?Q?K4JYp20ZVBkb+r0kUP1LICBiwTub5+KUaLLPR/iEipODwAmtZQ8I5KEKaw0s?=
 =?us-ascii?Q?Xru/Qd+ObZXz28/qsSQjBAqax7EJzLIhxZPBGQ7pGkqGBh1mOvZ1hscvIqwh?=
 =?us-ascii?Q?f4EviygRB5KKM3wrJRddzTHcaTdBuiAIkn6+0xrPhbUNKwKeUt/xF0vuZGtP?=
 =?us-ascii?Q?6Myjch16i1mKTLjxBU+J2R/nSmwS8ps+VuLDy4BXsyWP7UiWhIICqZsrrucd?=
 =?us-ascii?Q?vLAGK0U4WSs87ZOcwrTtTEkU3QBeAEkGv/kTdeghg5ImSDtnrxsTWzehfYNz?=
 =?us-ascii?Q?qLa+hGOrt9yB07ZcE3QdOY04ilSDa1hRMlX09lORS5XzrkUNe56EoIwX/eCO?=
 =?us-ascii?Q?gUpCzsEHIxHbm79pOxsDeHRzg6HHq7Weh+0H+TbKk0jKF0FIsAmMwE9UwA3t?=
 =?us-ascii?Q?wYM/xUNYLhlxRQgpcIqIzd5buB42/Xm0cSWoJb9Ge58Pb4/vDb8ydC1ONeDG?=
 =?us-ascii?Q?ftTGoRvYghDyrQs/rjBBw5bpRVuxAKaGGXUMylqhUVR67IPnkCbJzl5uKSvE?=
 =?us-ascii?Q?+wD5x07iVuUK1/rnKPHjCo4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6781f5-16e6-429b-285d-08dd7dfb4b4b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:41.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc900x8kHshDrHrQa/Q3KZlW5V+q9rt95QBn3YD/r+51mOQVACbsp9esb7FCuAdQLp9LbB7jVUuJuJol5OQ/XdBgymvjGEcw2ZC/V86aYdnkUSfMp1GKgBimFVEj8pYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7327

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index fde6e01f66eb..2c22615ac72c 100644
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
 
@@ -689,6 +692,7 @@ static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
 static char einj_buf[32];
+static bool EINJv2_enabled;
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -718,7 +722,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-	if (available_error_type & ACPI65_EINJV2_SUPP) {
+	if ((available_error_type & ACPI65_EINJV2_SUPP) && EINJv2_enabled) {
 		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
 			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
 				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
@@ -901,8 +905,22 @@ static int __init einj_probe(struct platform_device *pdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
+			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
+			if (!user_input) {
+				EINJv2_enabled = false;
+				pr_info("EINJv2 is disabled: not enough memory\n");
+				goto skip_EINJv2;
+			}
+			EINJv2_enabled = true;
+			einjv2_component_arr.data = user_input;
+			einjv2_component_arr.size = COMP_ARR_SIZE;
+			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
+					einj_debug_dir, &einjv2_component_arr);
+		}
 	}
 
+skip_EINJv2:
 	if (vendor_dev[0]) {
 		vendor_blob.data = vendor_dev;
 		vendor_blob.size = strlen(vendor_dev);
@@ -944,6 +962,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
+	kfree(user_input);
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
 	apei_resources_release(&einj_resources);
-- 
2.43.0


