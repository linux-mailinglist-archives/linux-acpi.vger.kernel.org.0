Return-Path: <linux-acpi+bounces-11912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5663FA55B10
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC92189480C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13527F4CF;
	Thu,  6 Mar 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aTUWlDYW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E727EC74;
	Thu,  6 Mar 2025 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304927; cv=fail; b=ub+tedE5NCLLCSy8qaccdzzOnoCffpWAm2SzSMJuLWVLEzcWC/G67YQVCBn2mCjNWCHab+OPXB1/I1uxt0D5Ke8kIwRj4k/lPAjJ3+SrelaMZKhZorjUaIYSUu0L76h5qHmHrgRKNSoFoIU8lkvHem+kkPbNUDeoG1JVLEmUeOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304927; c=relaxed/simple;
	bh=Ced8ikWUx1YCNtm7PzL9InNERcOwGA/AGuqJ112HxFU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PbLlFS2Qr7kBhGc92HJ5fHnqbQrP9IaILUz5faAFqb7+OBxqjO2DxZwDgQSmJGDS1FSo2f/6hQGgZ+88jBI8zxKoNd7BfSqWNwoVT2qFQTzJyb/ryDJLmiy8h9OaAp4UjOZqNQOMl/YLurqmJ51hqrwwqtc9fgE2X6NZ/y8HLbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aTUWlDYW; arc=fail smtp.client-ip=40.107.223.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFwrS7xsWHGwLsU4NVJ8UKRxNcn1pW9m7zWPygicztoCROOIpTm03OnMq0I0z0mQyouTzI1qylr98BaSzFutCZ7LIuLnNAuk6SP8Vcl2zGGMGeBsANQaa3EnkjXmxqpsH/cew+OMYFqOrK6horIlryC02S66khTuSbsuqSTxOsQqkZKkdLlQKHh8GgqMp1B3CDrQ3/MS9zxjShXkAvpHWU4pvu0oul8lYRxlTIUSxL8WMjvARz+Hxdia5YUKWSdA4sC9PzywqEDei+yhsfGPIeMD4QA7Ga8N9JksdXknorBWdL8xsy7biQtfh5ufw+8o850ixkxFQquBid8uxhmmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXzLcuUqo7+AF/UtRxDdHSWRujKYfIde2RbiJYVsY1A=;
 b=bWhMmbCvw8WCfP7JnO/NQeDOUmL8ICLR/+vtr4lVt6ZX9RygGCSO+5ClWox4IM/YyeAs1ggMLojDfWrKz7uL2kDTn/FtS4fFabq28DU/VeW3/RHTT3R0Wian/xqsK9iWr4i9GBp1puwknVlRrnQFrUol3JBMIyosEQfPLhApW1nXF5b+PZjvhviTZxT+WHBjask5D+FHQl8jwERPjItFIl9l1wGwKEDcw5yuQB6UhdKKpnle1VlI/qbPZaa+r6A5NcoUBkB91DA7M1O5r8bEFsfuPySm1A8kSJmbvEf5u5MSOp+372gCG119esWnbEJW1TX7uzTrcDJwh5Pl+4eRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXzLcuUqo7+AF/UtRxDdHSWRujKYfIde2RbiJYVsY1A=;
 b=aTUWlDYWxsVi+7QnJ40k+B+Rkpd2kqz8kvZ+zedes9WiKdXYoXqOfSSVh1JRlAQL5t3FzM2tm4qSUZU0dCKobJ0k81WupMOpYzJdtT2XKepCM9nBWnRFyooqMvZ//eAWGTwZXG3NwSlyHRuZsTCAGYn5/siqf97joOML8J/C/rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:43 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:43 +0000
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
Subject: [PATCH v4 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse warning
Date: Thu,  6 Mar 2025 15:48:04 -0800
Message-Id: <20250306234810.75511-4-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: f66d2427-e208-4ff2-9341-08dd5d096d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tIWtIT7LM0lQVxI9377jWoUW6WTn06NyYEE2/1eNu+IJp0OZew7tmXeeOIuK?=
 =?us-ascii?Q?pAa32wPPsSyyfDp5vKOj5JcEXVYVNlDy0Ytup9fcF0/EY4wgbIGug7uIO5Vt?=
 =?us-ascii?Q?D3an//OZi/d7B5vHLU+rFTRbnXZYkMZ28Nbd+JnPYT7kSaVpXrUZ5OJjXi7n?=
 =?us-ascii?Q?j78rn/scuT6drZMLRTAEnjGSGUudYh8Cl/msmst2u3WjWKP0crOIgkRRSxQE?=
 =?us-ascii?Q?r2OeRLAc/3+sCeGH1TJTlDXhbxsJl+WvOEq4Jk1zxF282ypatL6gRj0zunNo?=
 =?us-ascii?Q?Aml9fTnt1SxF1XDjODxxihYkC8cGRjcL/mBrBAV7Jzh7/edeQN5vsd+Q/xpD?=
 =?us-ascii?Q?5m9yrk/IqWUjogzXnxo1Qw2S6AiSavWSYssXIZWMFFb00QhG3C0VC22qGGcy?=
 =?us-ascii?Q?o5L/ELP9BfRGf2OuVLCb5yv0LQ7UNlmQBNNvqQAbgSZK3ubA4E4WQ4t7izMy?=
 =?us-ascii?Q?ycS9Z6DW3A6uHo4eozn4mOG6eYnyZyWhs3mCnS1pWytRw49da7Sek+7Vi5M5?=
 =?us-ascii?Q?ChziIG9YJGA7ZoA5Gjt1jD6GimYxEXbon1eetZKr3W+d752Qu5UmBgUxz3kK?=
 =?us-ascii?Q?dnJGH/0vDuiI8dOJnseJ16H6yNwJjHEIAeuJdaxUHf0m4e2R+tUkPEUSL76u?=
 =?us-ascii?Q?McoSMupVOGA5ICUHIwH52WLJTAK2KWBJw7e45vl4BJ6vH1mLMwJmGPXq/4wb?=
 =?us-ascii?Q?RQrlldEiXwshVeSKdZ0k7KfpVPb3EpvA4hIlaTGTr+2/ORaWu9SYLS7amZ4E?=
 =?us-ascii?Q?dVoenkw62Zdva9eziCXvvpsNm+UtjoxVLRJ6TbJxiLcIPrxy0AVT7ihG/d83?=
 =?us-ascii?Q?IjJF4RC0WA2JXctWloJwhJwUZCcskPiybYRZMdb4lGVo0hZJkbjNOKte+5oE?=
 =?us-ascii?Q?0tIjQdnAnZbWAhx8gXVk4yuGMoDBTqOXwQFGOd0KJgp+JxwgP8ICZFza6T5g?=
 =?us-ascii?Q?fIP8YTb1j/nJM2WTZaEDtPB098+/NQeVKGWIto6/7Laq1kGzG1ywwXKy2Uua?=
 =?us-ascii?Q?T/V+TE6E4Dogwc1C/Lomw3kBNiE70699qXACzekvihzgMHTKOhGPp/MOrfKD?=
 =?us-ascii?Q?GVYSSKAOYFx0vVFf0wWAhzRF/OkxjKsasSlEnFYebf/+gYO/YwLyWUbHOnj/?=
 =?us-ascii?Q?eynHY9tBSMJN9LE9J+k9lvtODnbS49NlRJ/bNr1AaJPlW3CRc+9yImy8WnRv?=
 =?us-ascii?Q?UzJHUk5qzycfv/dUEV4itBtPUAlGTm7qejgBUrcVEACiH45WgWdhVT0JWR4T?=
 =?us-ascii?Q?4PB45fuzkZxUrNN2o6b4Yw4NDGENywg4AyPNYGjbIOZSgpeTT2CjMCYatIi7?=
 =?us-ascii?Q?8/Kwo//YLVlB+NF1T74VWN1m1FAdP46FpF8hxaH7Eco8/jdHgdvnQ4p6BT6y?=
 =?us-ascii?Q?OGvKeiwtVCrGhMf80kUcSv/sEWeIQ5nmJNimTq98pNzHVrR4jrvfYhtHVI+g?=
 =?us-ascii?Q?7UbYO6m2R4QB1wpZqfYsOapVC91cRniBrabWj4yGLntktCzgL5jz2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/3ywDtUru0LUKeddOjWTfN7amQjZqvkQ7pt5Mp+VBV986JwmnpfkyOOyJlT?=
 =?us-ascii?Q?+6FOOOdlEWlkEHouSXTQcBIF/eWHyrLYl38s48YVXIbLCAIFfQyWe+Aum4Qc?=
 =?us-ascii?Q?wTEi1gE7yywii4LPtM8l/XsMSzaAq2+tqmznwP8qbeEWQmh+XF5Iv8GYS67Z?=
 =?us-ascii?Q?cy8DS8Hk7ZIwrNvjSRB6fu335+GkWuHMhWgUuvC37nmdgM3/ND+Uz1e/D2EO?=
 =?us-ascii?Q?hk5nqhzuZOBXsxkcP06Caq8DAplptgGSKTqCyPzHDtX8Yl/9+yn8OKZ5lVN8?=
 =?us-ascii?Q?YnrXh2+V1+r97JYEgo4PuFZh+bQwXVOPD6Hd1/DmGAR/r10a/a43+YT5rgP8?=
 =?us-ascii?Q?jDlPkredVG1lPvlpX/0kL8Jh3gxfz7I2fSGpF0ukCHE6Vo/rV9xB4mJy/zEU?=
 =?us-ascii?Q?m4bwWllaFf0CJBTqh1T0k4e47Kd6CJEif/YgPSy3Bhvho9nQF4phHGRKelJ9?=
 =?us-ascii?Q?/SvVyBQmwlPjszyTilo8UgOBJ8QOn0zKDQd7QJ6s2XltbDDkT6IEAx+B36Df?=
 =?us-ascii?Q?qY92Z7rF3DX9SJ4tKxA5ZpEWwJIHJVJvKI+9wIshYnIHw6TOoV8Nif9C55Jp?=
 =?us-ascii?Q?Hs+KwBJF6vVl2cFroFvzE+W2GAnxxuzQFXmgB0f4MWb85PHWJQFOQbRFUngS?=
 =?us-ascii?Q?8friKmQwX7p2aReQr6z8M1VxjJOQP2c57YXXQD3q1Mc7bTJ8yMBeTzN73KPv?=
 =?us-ascii?Q?8Qrnrqz4HLoVlBS2DY1gaVArvSCDyTUZa5vxDjz6OD/E/l7Sm/t6UAmRNMCk?=
 =?us-ascii?Q?NwINJlpyZIkQm/RqQSRM85titOzL2XOb7/uyP/EzIer49/6js7nVq0lpIoi+?=
 =?us-ascii?Q?71DsE5fDD7fBMX9sfGC9jhRm+MmyGduUURgvdeRZLNmnZfJVqu5rMYP2VzRE?=
 =?us-ascii?Q?9zEbsM983y7RD+5/ZSyTKcr4om/r48zpn9wUXb+U9dcP27bxQr/cf73wkTUs?=
 =?us-ascii?Q?emgcnvH1XtIXObjjiUPkF5+aj/SuZzz+nzshlXqmYyFUN1w2sRAFHDDTzeZU?=
 =?us-ascii?Q?g4Gyj0LGOAJRQ7U9dTTKGjDom6bOTzOBw+ZKubU3BwM4f2ME3EWXFgnsdFSN?=
 =?us-ascii?Q?UBD0xZH4ygfE/s0gKJkr15wJkBd8pv0fCOw7auAnIvlBKWk7wW4s0nnSipzC?=
 =?us-ascii?Q?kNYO+Rl2uEy1OoiCK5mvIvu1pUotjNLFeec+Jc2cr9CvHeWE2OchzwdP4315?=
 =?us-ascii?Q?QJMJqIsPQi19QI8VCMMpLlCq53gCi0l2Zph9w3O7mI4LYNut+jK8bHH67njm?=
 =?us-ascii?Q?KB6EbML51wTr8+3GkRR6ZS/SVYypYH5FtcTseYiJ0PyzzRuj/Oezl4rVknri?=
 =?us-ascii?Q?wpWyhZa9CbZLlrUFOSibjApVVW8dEyrk1kIFYgHE7K/b1IrZo1DjirO+EoDK?=
 =?us-ascii?Q?8msdq2bCFM5LTcKLmXJSv3ytYJDowvIaoFhqSHbSFl/MmFn2mMg+b2Ry/l4C?=
 =?us-ascii?Q?zORERq5KxmMT38yxK2oCZUUnHjkAq1iu0NHP+tE7KO0Oa2oVy5wRq7oPiYnQ?=
 =?us-ascii?Q?K7sdjn9tuqRoyBTc6ytBgZWtO1zZwny6KJy0kyyb2Gyxrc+qCcV2brN8FXUP?=
 =?us-ascii?Q?ITtiZvQZXwQUnftjYdIR8qF4MZUtk/VAWevHgkUPso7kLRca5oYQMvhyw/k5?=
 =?us-ascii?Q?rKYM7y/TCnI0C+KYtwqvJ+s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66d2427-e208-4ff2-9341-08dd5d096d69
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:43.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fa9094+EPWqKYgnvpfiG3P5J/nWAPIke0CI6S9nKqnvOADOzpXRRT6Gr5yhgQWLZdxuRkYHprEkHdp5Cvklh/xJ915szDHNHsaia2uxTJXRWdts37xgQSV93UeslF/Uz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

This patch fixes the kernel test robot warning reported here:
https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 104 +++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..b40ed44c4983 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
  */
 bool einj_initialized __ro_after_init;
 
-static void *einj_param;
+static void __iomem *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -214,21 +214,23 @@ static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
 	int	offset = v5param->vendor_extension;
-	struct	vendor_error_type_extension *v;
+	struct	vendor_error_type_extension v;
+	void __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(v));
+	if (!p)
 		return;
-	get_oem_vendor_struct(paddr, offset, v);
-	sbdf = v->pcie_sbdf;
+	memcpy_fromio(&v, p, sizeof(v));
+	get_oem_vendor_struct(paddr, offset, &v);
+	sbdf = v.pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
 		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
-		 v->vendor_id, v->device_id, v->rev_id);
-	acpi_os_unmap_iomem(v, sizeof(*v));
+		 v.vendor_id, v.device_id, v.rev_id);
+	acpi_os_unmap_iomem(p, sizeof(v));
 }
 
 static void *einj_get_parameter_address(void)
@@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
 		entry++;
 	}
 	if (pa_v5) {
-		struct set_error_type_with_address *v5param;
+		struct set_error_type_with_address v5param;
+		void __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(v5param));
+		if (p) {
+			memcpy_fromio(&v5param, p, sizeof(v5param));
 			acpi5 = 1;
-			check_vendor_extension(pa_v5, v5param);
-			return v5param;
+			check_vendor_extension(pa_v5, &v5param);
+			return p;
 		}
 	}
 	if (param_extension && pa_v4) {
-		struct einj_parameter *v4param;
+		struct einj_parameter v4param;
+		void __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(v4param));
+		if (!p)
 			return NULL;
-		if (v4param->reserved1 || v4param->reserved2) {
-			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
+		memcpy_fromio(&v4param, p, sizeof(v4param));
+		if (v4param.reserved1 || v4param.reserved2) {
+			acpi_os_unmap_iomem(p, sizeof(v4param));
 			return NULL;
 		}
-		return v4param;
+		return p;
 	}
 
 	return NULL;
@@ -317,7 +323,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
-	struct acpi_einj_trigger *trigger_tab = NULL;
+	struct acpi_einj_trigger trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -325,54 +331,57 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
+	void __iomem *p;
 
-	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
+	r = request_mem_region(trigger_paddr, sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
 		       (unsigned long long)trigger_paddr +
-			    sizeof(*trigger_tab) - 1);
+			    sizeof(trigger_tab) - 1);
 		goto out;
 	}
-	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
-	if (!trigger_tab) {
+	p = ioremap_cache(trigger_paddr, sizeof(trigger_tab));
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_header;
 	}
-	rc = einj_check_trigger_header(trigger_tab);
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
+	rc = einj_check_trigger_header(&trigger_tab);
 	if (rc) {
 		pr_warn(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
 	/* No action structures in the TRIGGER_ERROR table, nothing to do */
-	if (!trigger_tab->entry_count)
+	if (!trigger_tab.entry_count)
 		goto out_rel_header;
 
 	rc = -EIO;
-	table_size = trigger_tab->table_size;
-	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			       table_size - sizeof(*trigger_tab),
+	table_size = trigger_tab.table_size;
+	r = request_mem_region(trigger_paddr + sizeof(trigger_tab),
+			       table_size - sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
-		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
+		       (unsigned long long)trigger_paddr + sizeof(trigger_tab),
 		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
-	iounmap(trigger_tab);
-	trigger_tab = ioremap_cache(trigger_paddr, table_size);
-	if (!trigger_tab) {
+	iounmap(p);
+	p = ioremap_cache(trigger_paddr, table_size);
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_entry;
 	}
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
 	trigger_entry = (struct acpi_whea_header *)
-		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
+		((char *)&trigger_tab + sizeof(struct acpi_einj_trigger));
 	apei_resources_init(&trigger_resources);
 	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
 			   ARRAY_SIZE(einj_ins_type),
-			   trigger_entry, trigger_tab->entry_count);
+			   trigger_entry, trigger_tab.entry_count);
 	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
 	if (rc)
 		goto out_fini;
@@ -390,7 +399,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-			trigger_tab, param1, param2);
+			&trigger_tab, param1, param2);
 		if (trigger_param_region) {
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
@@ -419,13 +428,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 out_fini:
 	apei_resources_fini(&trigger_resources);
 out_rel_entry:
-	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			   table_size - sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr + sizeof(trigger_tab),
+			   table_size - sizeof(trigger_tab));
 out_rel_header:
-	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr, sizeof(trigger_tab));
 out:
-	if (trigger_tab)
-		iounmap(trigger_tab);
+	if (p)
+		iounmap(p);
 
 	return rc;
 }
@@ -444,8 +453,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param = einj_param;
+		struct set_error_type_with_address *v5param, v5_struct;
 
+		v5param = &v5_struct;
+		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -490,15 +501,18 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
+		memcpy_toio(einj_param, v5param, sizeof(*v5param));
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
 			return rc;
 		if (einj_param) {
-			struct einj_parameter *v4param = einj_param;
+			struct einj_parameter v4param;
 
-			v4param->param1 = param1;
-			v4param->param2 = param2;
+			memcpy_fromio(&v4param, einj_param, sizeof(v4param));
+			v4param.param1 = param1;
+			v4param.param2 = param2;
+			memcpy_toio(einj_param, &v4param, sizeof(v4param));
 		}
 	}
 	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
-- 
2.46.0


