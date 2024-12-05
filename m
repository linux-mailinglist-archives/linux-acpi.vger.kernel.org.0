Return-Path: <linux-acpi+bounces-9966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606B9E5FED
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35708284D40
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F61CEAB3;
	Thu,  5 Dec 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kc10d+Ew"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023133.outbound.protection.outlook.com [40.107.201.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168B1CDA01;
	Thu,  5 Dec 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433556; cv=fail; b=MzJ0ojl5QYw/VQNTolQ+62G5Bwb5QL6QsRfRRoYVJzTYGKzkTlv/htbNJ8ZQ7vLi7CpqCkQsy4j807W4OqiFvD2Ta/gtRtoovpqCrpt+XzIre8lNhVc/Q6Oxc9lTWqY2JLSagvJqV4Id5srcgoVonSndVlKUyI1HXA80SLUp8rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433556; c=relaxed/simple;
	bh=UaT58DP0kOvcS/VsNjE0OuNQAbLJRuVNKyGNi/ZslXY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pup7qu+movtI3amdiO0En840sdF1rKi+LPWFvNexgfBNfDjcpu/RjBU+tcyElct/0uqbF6s6cz9+k6nAiBMEtlcNTmQyH8CdUTT/XW0p5Dw//m6CbTP4168tcKOhXnWJeIUEnybtKlEAF0/iTSLcs0dp2lVcDpGrjc2dxAmUEpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kc10d+Ew; arc=fail smtp.client-ip=40.107.201.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkQLm3vS9sMO7JdKHW90veZBMTzpJDyV+a/id7otcgbYpThnfWCgrgSMrlnIwISmthgJPmRMUTGSPjsi/jNq/0KYMWVqGK8vYFGbrHv3aK6uo98tzzizVp7XLyaMyCXPl+n9Obx5wSMIhpGQA4LTW6Oj0d0Jw0OKtcJVY8kIJrmXK6f18f1efK+xgajmdlSjN1wkuwcxQ1TbiEdOgvd85nkcpjxXWi8QDHg/9KDQkSzZxSGkZtwyLgIYmv6dUpYmCGQtjk3FAmsZTax8pVtQmoluDCuacO1bFtMQ+HJRUBJmPbC+LVtXCRmKH+R8heh2YmFpua+gqZzsJI/8GGyHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW4N+EIxUmjJYGt9UOP9yQ14wcV9A+UQFx1vcP+1tyU=;
 b=rH2OhsavgCpejFEAV+UiEFgcCjBFnCF5wom4zllBr82ZQqyeUD8OzZY27UY+N+EYN77ftawgmaH7/aYthQh6V63yOG1lEP8NmmJmyTpEAiqwqvETVCvPfrFEDy9kUhbZL7A2cY+/A/yYRrHxWYz4Fa6dWU6LWx0n7lIt7FaDm04G5H8FJ64FtXbNsU1Rzmok9/NAjGeIBcMMaVgLjQlai3+sRXdKt+O/JXnjNS+he4xJowH4XgLZ8V9iM+CQArDWaLFuKXGxXpCxqHW7R8jzS62DIkfWj4Kx/043SOGmXbawD3ewwm1n2+cjKjSzm399aL52aFXmDNEjiVQuFjrEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW4N+EIxUmjJYGt9UOP9yQ14wcV9A+UQFx1vcP+1tyU=;
 b=kc10d+Ew6g9J47SaIye1Vr0LKgVR3XEK+EW+1Rv3y7yTSvKysu8pjmnLwCHTEPybZhwWcvckXtjuaNY1l7iwkjMeasoN4+gzSAleX78YrdQ0Q8s6ZBfkmCIWc8lE1a2pZv9ElorJW7IGk6kgAzIWj/ukrtVZYkI3dOEvUrMRVyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS0PR01MB8004.prod.exchangelabs.com (2603:10b6:8:145::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Thu, 5 Dec 2024 21:19:09 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:09 +0000
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
Subject: [PATCH v2 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse warning
Date: Thu,  5 Dec 2024 13:18:48 -0800
Message-Id: <20241205211854.43215-4-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS0PR01MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b603027-296f-4820-f0dc-08dd15727553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dNmOJ9mzlAMt10x/gcabY3/JOvDF1xxsxqcd+LI2PsO3QIhGGWpMlhqkqtoQ?=
 =?us-ascii?Q?ih1V1d8nxV1HVBHinQUg5ssmTDNs3kHB0NPgjR5yL/J42+QP9M/fBTVymiVr?=
 =?us-ascii?Q?E0F+WhqSl/F5MBy/KO16ra9TJV7F+AhrtKp6smSj17LQKtS0k7Xx/N7MToY0?=
 =?us-ascii?Q?9ux8abPqnDlnDEuG8BHa+CTI+qp7XD8SlP6+ANMg2/DZGmQ560q8EYx/EvOa?=
 =?us-ascii?Q?hwN6pTtzb9nez1PTI1j76zCDPFFPJSa71Zw2rMnuT+HPkYkQdtzAtyAYGGdj?=
 =?us-ascii?Q?I/OZ8i4lrt+VHYsmV/IKLhdC/y0VR2YWtI/9xhGx7PXDu8XIUiBD6JlS8cMC?=
 =?us-ascii?Q?eWnxWqgDXzzDkwQ+0j2FkoN/zW12YMRMTq5cRx96M9m3PZsq932LG5c7nYst?=
 =?us-ascii?Q?OMCuxtWdBZ+L7WnuysGMcCHYEEv2xRBop1NwpZG2+khBt5vwmJnBpqQ4DpZ/?=
 =?us-ascii?Q?VAbG5AFdgCCyrXt8wC3SsJETpGosTeYQsIjY96XOW9cIq2ZHfmJgXeo5gofA?=
 =?us-ascii?Q?GvamliuEqSBHj/9Onm6KAW7vaC/4+tDS9kUUgour00BJ+rnHxZ584ZwmVE61?=
 =?us-ascii?Q?+rSkJegGj61/edEY0lBxKVt5VDVm7HHNlwEOrlX+I3z5GkQAx0uz/jzC+Fub?=
 =?us-ascii?Q?jI5dbwB/NFdzX3o8tu6SqhwTBOWy2OHz7peOZPcPAkrGGiiJyF5bVniWu3It?=
 =?us-ascii?Q?xfKu+erccAbZfyFX3xQqTDTpYxuA4+ulPfhZQbTZFiEQADs6+miMysB/apFw?=
 =?us-ascii?Q?TQ/3xYkjh1t5srjphoRZRXCW0gmUJtk/TpePwoqRGahpLLurDdsYFpYtjRhs?=
 =?us-ascii?Q?0vTc8J6wYhMwqigAH86/jez9A7H3/sAcLnQAmkYkgdEtEKaVmtbiR8sPda+p?=
 =?us-ascii?Q?WkdoXVeup5SFL4vZTfYC+dikEVYmhLHJxg77yQV34lht5cLrbyZ9iJCwcWPW?=
 =?us-ascii?Q?QnUpA5gFFnzY04Bx5UI1vRR6QTfvSS4Dqw2cJx6NtrWo51QrPU3NS9k0HDkh?=
 =?us-ascii?Q?cWxafXSkrMDeGeW0WeOVT5J0iY2JfnVXCE4kRQnaBknYoajPxmeoM8f1vKCZ?=
 =?us-ascii?Q?V57IQCtpxZ27JSqTsDwVzMEpKvqq795nplRVIiR/aNHsJsyurUMimIboWSRB?=
 =?us-ascii?Q?tJl98kInNSTzMNHFNkRhbFnFIc1P3hHx04qmXYo5xON1aCDl5GyzU+PHGi3y?=
 =?us-ascii?Q?O5JCvKqfqj3gt/6K9kbwDStPceaEUTzeApo8U2dLodAIWOZEDB7ouyA9OYmg?=
 =?us-ascii?Q?U8ETuhLEqMCBbgFAwCEM5psCjnwoAwZ8QVxXTv6bU2VtwywroC7MPjr6NtHE?=
 =?us-ascii?Q?LQq3GquKsRRf9q8le/ozG6smXsFH6gPp9eBML2D9jXnugP7GySn4V3p+4tqb?=
 =?us-ascii?Q?g2hM4IgZncHfBzw22UH9GRSJ0egLWqDXn+KZJ7m/rEppLe4fM3ndJYwiymI1?=
 =?us-ascii?Q?4lquaDl8fsU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2mHNEoAXXIZ0ifSafKFgoqFQvNfpHwhMYpWh+AAkEmgYwF6+r/byrraF4T5?=
 =?us-ascii?Q?HXlUYQMBzfftZX0u/2PMHRdG/Np8qffNGGbwfs/1tAY9HiOxhkTiTyk0l1el?=
 =?us-ascii?Q?cbp7eumhJjQApafJWB4dZYOm1MeJdZJJd9wTyaaiLe6M4kahfGoyaizo9h7C?=
 =?us-ascii?Q?FMuuElbxoOzZc38mVnUxupyru3tavT5En/Lxnf1KKtTbESjSvXwjhCwBebw5?=
 =?us-ascii?Q?SD5hG9vl+1Bdy+eeC7APYgVEA5LIqaxABHMHY1OjGBhhfr9aXE+P05s8hRb4?=
 =?us-ascii?Q?AUHAwwF/Sw7FO7fwl2cFlkGouoUfKOvApE2Apw65hZLVE4pik1MPwFHvJ5/+?=
 =?us-ascii?Q?WwJ6GL3TGkPmAr1xcDYRW0gMT3bm0afUjVsLu+o/CA01ixELMg/ZYVQ0rw1m?=
 =?us-ascii?Q?T60Xhyn1JIGQiUTYQIIZor4CmKoEWsXr1/05bMqrFO7TimWanoLexhH2eaLQ?=
 =?us-ascii?Q?YMGB+thuLq0oICYuppCgeia5erGNr6gYsr8rJ8V7aJlECKntgK5yif/Rdlf4?=
 =?us-ascii?Q?f6DQRAiuqeohqhIqoNY+Bmb4AD4bTMDx/51TghMQXiZuAcMLSUxHVh+0X/IA?=
 =?us-ascii?Q?+MjoR0PhSgvPZKeUFv8GINaytLF7VaflaX3yhZ7M6nsPjZzDkvbqaULjMK7N?=
 =?us-ascii?Q?stWCsWzVDLsbiRwWzj5PpaC10msCkIXqNAH/i3Qe2ChA9ptt0kR9IuzvCrSe?=
 =?us-ascii?Q?1JcpIOu0G0OUnNhkQugevlhwyMHnOX2XeCsaq/6hhN0cMo+iJgfEMi8/lahA?=
 =?us-ascii?Q?DBOMLUt3XZ8vKH2sN6P4DPuSR1QHSF+lEosAH4YSWfAY+pNVy/5Zl+Cs/iqc?=
 =?us-ascii?Q?MnIW2nH0Sno5xNeA9DjmpO8duXAaLLPWArmStsFgoiWHPsjHDu7kJm1cLVL5?=
 =?us-ascii?Q?PUFxBXSq/G7VKPtzeleSN1LBscxbygl+jgqLsyRVnCnWcPEbILq0H4ntcvzs?=
 =?us-ascii?Q?Ig/atYYXfW73aV6q0pD7OfK5T24WlNCn3DTdtJAIgk0z/BNnG9FekfI4R9eU?=
 =?us-ascii?Q?S7Ryhhh/bICbJWPg38Ejo/+LdqIHhrcnwbcob2ioPHREzLftsUPR824hK7yc?=
 =?us-ascii?Q?vRQaE7gHbDf0uETVRp8C+Rcj+FPKh72zfDgnDLHpzlPC1OV4ghHAeJRUruBw?=
 =?us-ascii?Q?FHGROTQldCBAG440P6umYUZU3TWz5BkvhdAd/plWempBRTIZtBdZMlDQoGds?=
 =?us-ascii?Q?GBHIshGKV1MW3o5nAgMB6QCktbaYOZdNP7MN6TNNgfXQqU6S+oz63NNyQvmz?=
 =?us-ascii?Q?tYP7YZdj4TiMHIVrKW3J5oNfoci0i9fvFMM0XGFnY9SivnIYjC0y8OQvbe77?=
 =?us-ascii?Q?bpQY4ginqgy/843uXy7/hEEw1ZzCwGsFulUiVJHusK3QiPppTKJA6boCz5Wp?=
 =?us-ascii?Q?0z/b0flT4In5StQSCulw95+4/U2Xt8HDf+lfwBFuWSFvff4w249y725Nx9g9?=
 =?us-ascii?Q?mhk7H85XOlmUY2kwD60Fs0s8YizpcKyES81WX3YPoJrV9eYc+SsIzuZ1hMyY?=
 =?us-ascii?Q?Gob9y8tvTdNBTFMeFOAu5NzGIUwwm1D0y8XsD9MjI+kLUb5DrW5r2xruvd2y?=
 =?us-ascii?Q?LCtYwnOYaSERtzWAYbanjcWWIkMJqNh5/YldYX/VVTZZgmUbZxHW/tf9Ky/W?=
 =?us-ascii?Q?bWoV3muc+qZtWSICTFuCjy4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b603027-296f-4820-f0dc-08dd15727553
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:09.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI6exUnfUlV2QGUsF3By7Bqwefyx4Dr915LEPK60DxG3H83KjkLvBTbxKQveDJpVO2cUJvBeFGyaWGcWtggKw+rJThx79rUF9/qqwRu2+Br49JWrPH3IouM2as6Q+vd2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8004

This patch fixes the kernel test robot warning reported here:
https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 41 +++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..74dfb3daba50 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -215,20 +215,22 @@ static void check_vendor_extension(u64 paddr,
 {
 	int	offset = v5param->vendor_extension;
 	struct	vendor_error_type_extension *v;
+	void __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(*v));
+	if (!p)
 		return;
+	v = __io_virt(p);
 	get_oem_vendor_struct(paddr, offset, v);
 	sbdf = v->pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
 		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
 		 v->vendor_id, v->device_id, v->rev_id);
-	acpi_os_unmap_iomem(v, sizeof(*v));
+	acpi_os_unmap_iomem(p, sizeof(*v));
 }
 
 static void *einj_get_parameter_address(void)
@@ -253,9 +255,11 @@ static void *einj_get_parameter_address(void)
 	}
 	if (pa_v5) {
 		struct set_error_type_with_address *v5param;
+		void __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
+		if (p) {
+			v5param = __io_virt(p);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, v5param);
 			return v5param;
@@ -263,12 +267,14 @@ static void *einj_get_parameter_address(void)
 	}
 	if (param_extension && pa_v4) {
 		struct einj_parameter *v4param;
+		void __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
+		if (!p)
 			return NULL;
+		v4param = __io_virt(p);
 		if (v4param->reserved1 || v4param->reserved2) {
-			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
+			acpi_os_unmap_iomem(p, sizeof(*v4param));
 			return NULL;
 		}
 		return v4param;
@@ -325,6 +331,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
+	void __iomem *p;
 
 	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
 			       "APEI EINJ Trigger Table");
@@ -335,11 +342,12 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 			    sizeof(*trigger_tab) - 1);
 		goto out;
 	}
-	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
-	if (!trigger_tab) {
+	p = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_header;
 	}
+	trigger_tab = __io_virt(p);
 	rc = einj_check_trigger_header(trigger_tab);
 	if (rc) {
 		pr_warn(FW_BUG "Invalid trigger error action table.\n");
@@ -361,12 +369,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
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
+	trigger_tab = __io_virt(p);
 	trigger_entry = (struct acpi_whea_header *)
 		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
 	apei_resources_init(&trigger_resources);
@@ -424,8 +433,8 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 out_rel_header:
 	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
 out:
-	if (trigger_tab)
-		iounmap(trigger_tab);
+	if (p)
+		iounmap(p);
 
 	return rc;
 }
@@ -860,7 +869,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 			sizeof(struct set_error_type_with_address) :
 			sizeof(struct einj_parameter);
 
-		acpi_os_unmap_iomem(einj_param, size);
+		acpi_os_unmap_iomem((void __iomem *)einj_param, size);
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-- 
2.34.1


