Return-Path: <linux-acpi+bounces-14316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663AAD7ECE
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD413A0EAC
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29F2E3383;
	Thu, 12 Jun 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HgdARVkJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088B2E1759;
	Thu, 12 Jun 2025 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770040; cv=fail; b=p91WWMarrd65mTC97yS5JAgbbSFDJ7ugt61XrpZ6Dal+sqg/WypNx0z/ALhG2jEL5jEuDylbUMjY19/P7iIgkzBa7cTJyCQZ4KL4UojsaQwkUnMDgTR98yvpFuPhkEIeBdtPrFyBt7684EAc3g7zRb87IXD+3QCBfOIQtVM3qwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770040; c=relaxed/simple;
	bh=75wpIZ6Te8LkEPmcVHvuzGO4W8cYfdVxWbM6hs9pm3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvUo1Dh2rIhGUbvvN7nHkfiffSLh+83mmTYnMbJBudHJRaKKYxZX/WBLVgXb6Lg9yf/Vk1tgkPb2qqDKx/7qOyK5fVkip8fd1awZ8dvM2njjtNlFWx9vkBmOySAudDRddk6Sy1jx0m1hYn+nYMGj3JL2Ql06zjEP+usYcujP070=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HgdARVkJ; arc=fail smtp.client-ip=40.107.94.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTFxDSbuhUlw9pv/Ks+5JJLSNFicFaw8ybhX2E6zbIKwW5HQ9BKyDh0Rjs21lt3A1MG6l2tzbSqc5z3GFzR2f5gb9muLydUX5DLFAR3FjiIZqWK9vLcjG3hnwGZ75fIHNl8Xl61V+pD5mw3yhhKPCUHimFIXtUQaACgAz0qN5jglbqUGxHwNpZSsb2E5PGNQjSOHWJ/SNijWlasG4xkM4qbeURYJ/+hmXuArbc4rBvRDxoKitteiQEiO8wWhBIB06uerogDJGaQOgjSq1zakgJRBS/IYhn+WkdNANFXJl/44qiYLenljvj91VJ/VIRZIRn5KmpdCmVECveWGhTd/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pmjJ+WmZlRIODULlPCaE2smD2KclfxSOQh9AnYSwj8=;
 b=Po9e2YeTgAZHwSUAPt87tKask1ovbF9qzQ9TBxDwWuTJtGuvHhrKgYA4ZmA8gkEjOy5kqypg0Pz4XA2e546vyPMzECR79AnjlQW+uwS9ujZpys9gZOU4cCGm8I+PCaDMjzVTnPlKVexBas/6867b30MdfDzMWP9RdpvTqHiHrYa58OMK3htkfzubWNvYklBg5MpjmX/02EyBCX88SJxAGUjm72+xqY+uRwEDkR+D3NZIwy6GPAshu6Dy7PAdyP13e4jsB6PH6QvV7NEQjJiZULxkDxU2vIYOp7itvJnZzycauYWmcjTxNm31kN2twLHy8M90tDIFh/ih/MCEp/F0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pmjJ+WmZlRIODULlPCaE2smD2KclfxSOQh9AnYSwj8=;
 b=HgdARVkJoCdEQdepqLyMtn7Z0uU1njvoEsR1iTgln5ZY3HEuSnocOw8wn9fdTPuSdkD5wioUYFdq+TrH32SCkV8R957xJ9Fy/DuYGjcdzclXUZAJe0VPhRdAxbEyIFX/z8MoPebPe/CBd5uJYuRMaFspJaB0oxQMhMmInRzRWHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ0PR01MB6382.prod.exchangelabs.com (2603:10b6:a03:2a0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.18; Thu, 12 Jun 2025 23:13:53 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:53 +0000
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
	jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com,
	dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v9 6/7] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Thu, 12 Jun 2025 16:13:26 -0700
Message-ID: <20250612231327.84360-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ0PR01MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d13148-32f0-4192-5d05-08ddaa06cc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rA4jGIAF3d2XTFD1U/DYqbxxhbFM7W1anmETtOLG+BM/avVbAdKhLvoLxLPc?=
 =?us-ascii?Q?7l8SMA5nPO0aVZLAhHlrlYMs4dvwWIx2AtM/AWcZ1WH8FtyDht2V48ea7iGr?=
 =?us-ascii?Q?ZI8wuP2DVR4Y8X+zGDyR+zCWZ/zKvL3WaxEJfjvyu6GPdNv/AiBwqU2OzT2T?=
 =?us-ascii?Q?LhCIEi0XON73i2JHWordNGoY4OhjfIolFY0+KKk1muO+0CauL7yF3qB4HIER?=
 =?us-ascii?Q?PhmVoQgc7WKCHW2LayQcDf871Kmllb45bBbpazXDKAHlbwZ2UV9pCZ9RbHRz?=
 =?us-ascii?Q?wQBfAt2M+glIOzH+9xijO1EH/2cNmxUjG2yNgHDTfumpWhN9ggtWrowWZyNv?=
 =?us-ascii?Q?zck96AOsLbwLXlZbI7mlPLmyrXsiWh+rcxgdtZFsHgDBwTCSi7zTbFTOrSy7?=
 =?us-ascii?Q?v2IpIgycW6//lrsLVa0p5m9/jT1dOdWzYNVDcsSsFzwSefUbz3ZwCkgQlj8Y?=
 =?us-ascii?Q?2tLU1euo0q6nUzUhLErjaqEfciYZh3dvgg/tQ+Wrx6S3A5zQXoNtnfejyR7d?=
 =?us-ascii?Q?zYV728VMhsMrAon2cnnhzpcSMz4s8tSNcvW9Ee+3clRlVuZvoQDxehlzzkn9?=
 =?us-ascii?Q?CIaUVEVRs4ItK2h0H21ofJ9fFt0fJ0Pi26pNkgekFP3JlLOGNLeKYsS4Yymr?=
 =?us-ascii?Q?KmYpcvZoRlh+XnjRqfZGsoDkqRFGhTporqQSYlAnnQ15ToUqu9tAVLvPDujt?=
 =?us-ascii?Q?8tX8bORItTKw5ymL8mSkcfLaLjRgt1aF8wQQ2lsuvgKLufPecnTZ9780hVtF?=
 =?us-ascii?Q?iW3rJtumPMaujZufhHLvCcW8/axAS8J9ANhnPsODIv/nwHEWBv0MQgi+fqj7?=
 =?us-ascii?Q?Ru39lxY3r7meXhyEYLpYApGwkazGgknnB0N58+HeszADs75Y5aV/iGvCqqEE?=
 =?us-ascii?Q?L1mGBOpFlPruU1PCQaQXc5wZAC2xFKEFZ2mcvzciwcPXkvTfdeEv8WYYC/Ag?=
 =?us-ascii?Q?j0ZGV98cNWPP/T2wKePTF3AhvDE2bESXhIhpUXJk4lUgY7Yvf2oNYAJRDI8q?=
 =?us-ascii?Q?tj156XSSw+DOtB1lFe2zNAmCBuYpjAk0QC+0+R3VGxY4e1N9bUAkfWky0RH3?=
 =?us-ascii?Q?3H/w7NsJ7+UIvm7BgAZkHEwdrMFZ0hb/AAUg7NS5blTf08WzDqQ6QaK1Tb2v?=
 =?us-ascii?Q?U6Xs3Dme0EZ8xbQ4I6MkLob3CsfImXTJQVfMSmz/kMAiDzotKS48n0c7zAws?=
 =?us-ascii?Q?ZUXTUPV03rSSmzlVrQnvd4tRzOcBIibL4q8jcG3PC/MEXKDwlrDWj/YDgYyc?=
 =?us-ascii?Q?Ui2o3R/+vIAd/nYImHAAIydBZ7mPncIE++75IEFcLQI+JCR1cbRScl3Ruv5q?=
 =?us-ascii?Q?y6ctS/T93ivI452UnbkOm65P9oHzOSTyTmlMZ2MHOFIncR9DL4i/GSeNEscY?=
 =?us-ascii?Q?XAzRVnbslrHJNrMR3SkDz1ND/ABPHXQ11AF7t2vxJCjFcFTRrTgBegJLJqEU?=
 =?us-ascii?Q?d8TpJg8Oh5BT3v6Lw6YGWD5gOrT/OtskOim+jFL6tbHWBc81QDFqyOtrVeQk?=
 =?us-ascii?Q?SK1f9x+Ndz63GOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RuV9Xs6oaol2iGJs+sSrmuv2kQ6iZCXzvSva5Ht+zfCdRuVdw4TzOQpi75j/?=
 =?us-ascii?Q?aSxU7zjyKcyQBtWy6gEUzKnG0rluy2VqIiQ00KZkA+jK/Gx32QhOIsySXnYc?=
 =?us-ascii?Q?cLUmtzROgcZdGdl0fDCMr38ancpoxvvdYHHJmLmHFG7AOY7qc/qZHr+NLOCW?=
 =?us-ascii?Q?K7t1tfdgZLh9d7HSjFp5wTbxJmA3XNvQKQKrAqreDFQiB9FpP1hjdsvfThxy?=
 =?us-ascii?Q?/bYgx9BbmKFS3XJ+hxHA+QVYhVQUkdVVb9NI2lQz+kDw6jfa9QvEm1/wIx0O?=
 =?us-ascii?Q?XrUhpOW3nKnKuhcBTId5fvj2pWfNDSGtpgTTc0BmdXttVgxkIgLgiHPuO9mU?=
 =?us-ascii?Q?49w8QUXPMRZ2rPskYZOgrtDi6/RQxeC1zOqrv32sQU8Vs3vUqkW+zXDGbjaO?=
 =?us-ascii?Q?XCmQ/KoLyXisAVa8IuwsNznZzBtyDT5vdGWN5sPoPQ2toYEWHV1R4kqazj80?=
 =?us-ascii?Q?4pt+mvCIn4pIRMOeTuNnOb5JL7bR5HFD47l8RAGV47XKAJ3/ZvcTq7+jB0kH?=
 =?us-ascii?Q?JMcO9Yim2AD11uRlacKGrvw5JGWLME7ZRGYgd8fGwXchwnYB3MNXI9IE9A/o?=
 =?us-ascii?Q?jimB9avIP0JJDBqmYI8qTl20wB8DGVPCs9JL3KzjJvAoCjoOetqtqhq/7yld?=
 =?us-ascii?Q?G82nqifn7LQrJsp4YM9VaSqe2S2F0dd1iU9Ov+10N/dKjcHgOt21MycUJaJe?=
 =?us-ascii?Q?krdGPCivrY4FH7/WiDUz/T+B1MzAmdjM3Q+L7PHfdf6azHC64/8Zd6FcRszP?=
 =?us-ascii?Q?OpwBEmYuTgQoMD2O3Gkg2Fo0Im/khNK5b9xUtCDhQtLCIiHEdYS5pfc6KMbh?=
 =?us-ascii?Q?eBEiO26Lm+BzwayEd4KM5nuDIGHyti/xII/9UWCvbKIYG1/w7/WJcPOOz5Lg?=
 =?us-ascii?Q?JgfZXgh14RxlIcb/SSiZmRwrTgkfyxpGDXgY9iLfg/TUHMsPvDhMEocXhKrf?=
 =?us-ascii?Q?SgeONW/qgfvA4HqtDsvhplQ4j/FGYnX4xQc5yvJGD4zuiLa3+Uu/OXy7Fy31?=
 =?us-ascii?Q?+Qwm5xakHT9IMYtjA6QovUkNOqJRDcLcZD7Z1dPmQx+bY/kLPZtHnWpFdOXo?=
 =?us-ascii?Q?cRxRqG2v5il7wemQ08tQPxWH+4TnX37GdFC2xjcRR4iaMc6P3HyfWZF0Z/Li?=
 =?us-ascii?Q?yp2upsPvUxn3h9RgU9pCJqNCVoVhiz/2MbJwBagjtxjErivWix5lqY4/Peex?=
 =?us-ascii?Q?PKzGXqt6WtD8txO/N2m0+VfaCQ/2C4efhTmOgWIV40Nxy9aTFlEX3F/+smqC?=
 =?us-ascii?Q?otY6cqTvW8hGd+8AnJAvgcjWK3zMjOMtElgQqbWp071c015TEOmCJ2X/NJac?=
 =?us-ascii?Q?UF0E/4QogqHWmbKG0BdOjHvYcBs/Xsc41LkGIZWhgWV9QUPp9VYclEjwADzs?=
 =?us-ascii?Q?Co6Z0EqWw+U0XKv3lLbW1r9VskrT2/BCVUs99m4S2Lgpz6hiiVIs2kKentVR?=
 =?us-ascii?Q?efn1X0LqhCuvaS33/bSxT0WjGsVuAmpxzBISHVNQ+22tEG0rLPe6kULDscCF?=
 =?us-ascii?Q?7tc91D+7fn9Te8x9O8Gdb4nPlFabLEtoZdQ9DQ47+CML8rRNh8fDSiZ/893A?=
 =?us-ascii?Q?RaqU6xbb9vXFwqk4eZNZcgJFon5s1ZoEkgsMe0LEmbg6MuT1xjjIj7KPM9mp?=
 =?us-ascii?Q?ZjOuNl4hPP1ECMlsLwZn1JU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d13148-32f0-4192-5d05-08ddaa06cc73
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:53.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H4kUiM7igu0t/TMrOKT+RXMT11z99BGFVxwFaiW0843LxBzB4ZBfo2JYsANMlHtOXFMnkHODFpaOXpdSt7rvev9J7nZmxY7svWaYfXK4ZvYorX9QJeOOLB5VMaTTSCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6382

Enable injection using EINJv2 mode of operation.

[Tony: Mostly Zaid's original code. I just changed how the error ID
and syndrome bits are implemented. Also swapped out some camelcase
variable names]

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 56 ++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 8d60e5f1785c..7741c2082f33 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -87,6 +87,7 @@ enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
 	SETWA_FLAGS_PCIE_SBDF = 4,
+	SETWA_FLAGS_EINJV2 = 8,
 };
 
 /*
@@ -181,6 +182,7 @@ bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
 static u32 v5param_size;
+static bool is_v2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -507,12 +509,20 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	return rc;
 }
 
+static bool is_end_of_list(u8 *val)
+{
+	for (int i = 0; i < COMPONENT_LEN; ++i) {
+		if (val[i] != 0xFF)
+			return false;
+	}
+	return true;
+}
 static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			       u64 param3, u64 param4)
 {
 	struct apei_exec_context ctx;
 	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
-	int rc;
+	int i, rc;
 
 	einj_exec_ctx_init(&ctx);
 
@@ -521,10 +531,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param, v5_struct;
+		struct set_error_type_with_address *v5param;
 
-		v5param = &v5_struct;
-		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
+		v5param = kmalloc(v5param_size, GFP_KERNEL);
+		memcpy_fromio(v5param, einj_param, v5param_size);
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -544,8 +554,21 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = flags;
 			v5param->memory_address = param1;
 			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+
+			if (is_v2) {
+				for (i = 0; i < max_nr_components; i++) {
+					if (is_end_of_list(syndrome_data[i].comp_id.acpi_id))
+						break;
+					v5param->einjv2_struct.component_arr[i].comp_id =
+						syndrome_data[i].comp_id;
+					v5param->einjv2_struct.component_arr[i].comp_synd =
+						syndrome_data[i].comp_synd;
+				}
+				v5param->einjv2_struct.component_arr_count = i;
+			} else {
+				v5param->apicid = param3;
+				v5param->pcie_sbdf = param4;
+			}
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -569,7 +592,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		memcpy_toio(einj_param, v5param, v5param_size);
+		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
@@ -631,10 +655,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
-	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+	if (flags && (flags & ~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
+		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/* check if type is a valid EINJv2 error type */
+	if (is_v2) {
+		if (!(type & available_error_type_v2))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -743,7 +772,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-	if (available_error_type & ACPI65_EINJV2_SUPP) {
+	if ((available_error_type & ACPI65_EINJV2_SUPP) && einj_v2_enabled) {
 		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
 			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
 				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
@@ -785,7 +814,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -804,9 +833,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
 	if (strncmp(einj_buf, "V2_", 3) == 0) {
 		if (!sscanf(einj_buf, "V2_%llx", &val))
 			return -EINVAL;
+		is_v2 = true;
 	} else {
 		if (!sscanf(einj_buf, "%llx", &val))
 			return -EINVAL;
+		is_v2 = false;
 	}
 
 	rc = einj_validate_error_type(val);
@@ -828,6 +859,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_v2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
-- 
2.43.0


