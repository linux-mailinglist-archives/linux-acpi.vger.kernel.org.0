Return-Path: <linux-acpi+bounces-10971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BE5A2F756
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003113A779A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21C125A32D;
	Mon, 10 Feb 2025 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TPc3/DaU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020075.outbound.protection.outlook.com [52.101.51.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF452586FE;
	Mon, 10 Feb 2025 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212660; cv=fail; b=utOTTHroXo/E2JUZVuWghiDNYhXASGy/Rp0swW269zPjE+V+GNt1ZmmvT9Dv58bRXJ+hNOZDTmCLvDOZ4ZqQ5d8tyZMVG4zPxBr/AX+iZlwTWpWpRF7gxBRe2hz7rcQZd67w5qQQv62eE06LI3fueQyMb+Dvz4/2KwGss0a52lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212660; c=relaxed/simple;
	bh=/z1Rdg752+UKZqdSJGSD46xmMCSeXzosOZjYYfWvdPE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+foyphXjM515k36WLHMXMkmF07iBMP9rugASQE1JCabeSfCtgmxXyDXSl4ACKNSxatFNlt1O773uM59fPTh2ZAt8wFVXZIyjUGIKXveLT5sBRfhSBhErf0HbfVFUD+ILEes+DFUF1lUmBp8hwiRhWEr9TFY8HvdQ6kuW2GRNZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TPc3/DaU; arc=fail smtp.client-ip=52.101.51.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAJ0M+kBLOFB6UQmD4cciaZn3vqg3ym3VoPmKFu82kUCNeSqFj3meKs3f5zrN16xubHbebFjoTpAEBWXOGSf8M1H/J98uw+HCVytjTuNHYlIZnVXy4n/1ZLWPriwhFSqKQ9CTl9iMbydMLFQY/oDk70egvaRcTALNgZ26kg315Jol9LqCatjm2zMtMtIAXSYVs6fGdR++p3uRr8c1u3w4rA19gy+Qls5NG3yfAlNhjiPz//U1iacMTq+isbUNYH0OkYUSA7GHNBeH9kfAfMZwcxhat9YSGyrsf47NwO/LkUNiP6EQsgpDOJxK8b54NLN7o9931+1tOyrYNeRUgw33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lomov2SNWNDMX/XeUAqAy0A/bQxxCr5ceyO9obMmNzI=;
 b=fTOi18E6sKkGnKXQstPzt2NBU0ACsu6vYB7AKmCd6lUPwGeeJutWyKo0ZRaWi8jd5Ws+q4VPv6eOMlc2sKWmXIAtgHL/oJQSnKnSc/UqH9mfbSkUi6YCyDrSEk7Qz2QSdMuuuVsyhWgOUlAkAgrq5L8/4E+pDpUmbjV8kTVYJh7Zl/ltb2GF5ADwNX+clgV6WBsGiqRybHK7fNjbvonvzvbgH9NRPqd0vX/4s4SZwbCQys3lfFj25aBTQ43IE5kRNsDOuHT0vjKArUFVw+Zc7BxfT27qwUaC+BBGqpirnnuZCEY0JMda3QURQGO5TzcV6xO88MoRiRAtftGiOLP9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lomov2SNWNDMX/XeUAqAy0A/bQxxCr5ceyO9obMmNzI=;
 b=TPc3/DaUGztgD3WgdWY5fMJIr5a9GQ9/9eRpSjSPiqWvYH0JkAzkxX/19GzBYIu40q0Kt/vddk5jWvTnzHgEfQpfjVssQp81zIa87v/k9WRGuU/6+9Fq2OrRgoTEDgYw7KChqsm3JcYKVxakwGEd8l9QjVU9QJZSJS0f+/bmhT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8345.prod.exchangelabs.com (2603:10b6:a03:537::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10; Mon, 10 Feb 2025 18:37:33 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:32 +0000
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
Subject: [PATCH v3 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Mon, 10 Feb 2025 10:37:04 -0800
Message-Id: <20250210183705.1114624-9-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ2PR01MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 63161d41-f4c4-4f51-97ba-08dd4a01fb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?syt12xUFlwJI6Ncakb19C9UeCseTqjP4Tfdqshg+1Y7h2JOI8WmNluttlkIz?=
 =?us-ascii?Q?ZxGuDGfiIP11U+5zjCVQh5+KdH49hBjjJjBkMacPOJTUfuJJdg6japq9SoyQ?=
 =?us-ascii?Q?Mu3V4JbFvkoCvi2IA3Tsu5uD6/NI7PFz2laiYPvWttJVwlsGylIyQazOn/q9?=
 =?us-ascii?Q?Uv89PtPTfCO9qAHCsL319FqXE4vMR3LbRImZvznY0VrJwSKKpgjFXW9y0rfq?=
 =?us-ascii?Q?spIYx9o/xegtRmC5v4mORRDIFzQRIM9+qPRTbz+EutDD1D4e2qcstKVcU9jD?=
 =?us-ascii?Q?f9xg3i9FFqpgbzU4JTalzcTwQpc52yl0tLZiNcQNYmIDhCnMlOkQTVT+OIfd?=
 =?us-ascii?Q?2XhZ4uK6LkGdqx9ZYcqn+Sq8iwQegtPPBKZ/QJsrpA4nNab3Ak+yMi3/rRfb?=
 =?us-ascii?Q?Qr0bJdOQWZQqkSLWOATxVL1O67LvR3csRvVtBHTewKFxuVtIOw1o8cL0VRVK?=
 =?us-ascii?Q?XrZKMB/HW4EaAFz1/ykPur3noVNfm4pJ6Md2qo+/Hlct78F6ImvKxLqniIuU?=
 =?us-ascii?Q?nPNnkZBjuXBBiDsDnajvvQ4rOY8MAO0eMNu40qTy0gT9/QCgfbls9R2xioj4?=
 =?us-ascii?Q?Ec11wmwsJFmvVW0Ee+upGJtMEUkLcWvR6CIn8yW4aPSWFz+YTqTZA7cY1iWu?=
 =?us-ascii?Q?yJXR6+47ZitmxFQbH77GK35HLKgc5UOnvQu22cpbWOzYaAo6Fkd48P5jSrHs?=
 =?us-ascii?Q?5hwW/MvyU+wMfMt84CyjUIVRQizo1U6z+xpnNTtKlLdERFLHeRoFR7opTEb8?=
 =?us-ascii?Q?ENDb9yQRl7Gxbaapah/c6D5YeFMZOht0+5VfV+xT82GLDTNNy+Zpbmz9R2bq?=
 =?us-ascii?Q?UHS5woKUFklxVjRqR6qnf1txCrTkFxcjHts435Ae12GjhASbZZQMKB9PRuEd?=
 =?us-ascii?Q?Rf5tH2GsjyE2A2zFPmGoghNaTXgReuu23FY8JhDkv6jMrfy+kIXk3CbTdBeU?=
 =?us-ascii?Q?8Pe+OqXjuv2w3xjHOxQdxFeP8V7Pl7DCFOrUe224IJm8K1rzszD79JAjvr+T?=
 =?us-ascii?Q?ckeQ6BWQSVdxncTq7UMe47Hej0R7gzFx6xiVG+mpzbYlONW3HFYFq2SJ5v+S?=
 =?us-ascii?Q?SCSafx003T7sAz2IzOU/EYFmgnnugSvgJSa3SCXLP+Xf6SAgxN02JdVSGAaH?=
 =?us-ascii?Q?XjR3kssKtxqRwtddDcSueQzupPAm35grXuprovIrD5viVONiTCM/TJ5Y96WB?=
 =?us-ascii?Q?l9LZrBQSbWzw58tm6jDqGFLPV5IpXoXdGnSSsblKY9ZgO3bC98pSA4P8OWMA?=
 =?us-ascii?Q?wj6U33o4oGKMV2tUA8eEhitNXaCFFX1BLVooqCjtaEbF+yhfxPvaVC445AE8?=
 =?us-ascii?Q?+7xpq4vYlXkmKMXeGA66lAQnmlGcXKi5Y4+GmY8V9y1X/RYVmIdriYZkHjGe?=
 =?us-ascii?Q?B12LpOp9sSW72HWTpZpsqvHvnVTcuIGp+QueJW9XGMZ5+Kh/pu+YkEx/nLXA?=
 =?us-ascii?Q?EmrX4fq12RCFkejIvyyCSZNDQs+GFDM+7drmqOfLgOy4xCqN+DpGiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4JoBSoDy+cTs9mjCepTc9Lby1HI5NX/sZlu1NAm0wcHm1V7wWPZAXSAnzVH?=
 =?us-ascii?Q?w1kKdQv5oKho/r/T5QFKTuLi6FNcWH/YBtR/Fsre9KIC7V6QPNcNtzinw73V?=
 =?us-ascii?Q?QQEJRgpudR/RoexonqjQt1fkCLJvHBf3cZpEwRvX9M3jBo8A5u/c+9SC4CZr?=
 =?us-ascii?Q?k97pRSXfXDdY8OMfGqLey+Na56s2MAbwDaCvUWWfOj2+bNgF0vDC9FGcp2Rp?=
 =?us-ascii?Q?ucH2VgwTglTUPBQsbFTsFiZMu6MCLCoYmLGNN2EeGlO1VF424V3pw5AlhjX4?=
 =?us-ascii?Q?eu/CkIhGPrUpw7uf2aUtdW/paK1/y4ybfwPogLwYwl8ZWIDE05ZweNQQSLYC?=
 =?us-ascii?Q?Kh7solAscGqlqs9WIbyyNNbEb+PHvMcWU26OGbS5lYPXAyIPw9DsR8lUsj5C?=
 =?us-ascii?Q?N8DXmXYTPRiO0Jwh7dEyhKho9+E1mCIMy8iCFoiS1Qic7kG8R0CxeFCti0YQ?=
 =?us-ascii?Q?mC3iIhvrQI6+/KInRwBYj3RoXUcUhK16H8GTrKS1jAR8hGSY+v40J8167thP?=
 =?us-ascii?Q?6lzMZA9FTblcLMPSuTpfYla00mSpdwibfzf/TPwB24buxDLOo66WMXOBJgNN?=
 =?us-ascii?Q?tOJuRvEtnETgAOAOuaERiOiGURgoHpj8Bl0dq5zzdclhj9B9G5Fhc7HpO6K0?=
 =?us-ascii?Q?by33wpTpd/06+YlnuI5xi0fa5WKooUr/9jGEOlp/Ui/8ZuE2Lndspltz1PWE?=
 =?us-ascii?Q?nDZK7rJPi1i80vJemmS4sgnYZrWC0ZldBcpSvXRTdwfG/fj/S/qey642o62X?=
 =?us-ascii?Q?81zlKaVc4SUyoAVXtov+CQ3fd9nN6NQXXn9bXJGAn+4DZJHpE/po+aZoqusj?=
 =?us-ascii?Q?m+q2e3KtDKAJ3oBIuh92xpa/qHGiPfHWeJzQEG09HMljfE3hybtCcFlDrKcO?=
 =?us-ascii?Q?YZW7EmwVqlOIsQTqVaIyB80pvIkJAz+SigBNWRk3BNKCUcjQ8Ee8GNPEvnVP?=
 =?us-ascii?Q?BoDyebtB4S7imax01lyi4fdfYy9o8RD4e9LzjSJB0JdbtytOT3G/xIwHZDSe?=
 =?us-ascii?Q?hxbH9IKUfUEHW+mmZwd07GRT1DXqeKzg/wz3adZPpD4y+LY2FzqmAFtzS+EW?=
 =?us-ascii?Q?HtrhbZUECNR6ORnIsw+1yfKVQja0y67vbAdB4evfcMY1+ischhHkVQ4nHuns?=
 =?us-ascii?Q?w/HG4BO9Z+eUT5vJyVIv4shasWH/stc/rKWEnxiPhaSE/V3pOfLBMRKU7WkT?=
 =?us-ascii?Q?1SJTCHk6dICNzhkPkwwBheNTclbOHRIfZksxVWYiysHEwmqKm0mZETfpBGCN?=
 =?us-ascii?Q?Q+VDXnXCViHYml/5ZSjvULDWquPPNvvk8CxCLUlOagJiAd0U+tRziNsYdMDX?=
 =?us-ascii?Q?3Bs/NVS+ZpmFbQp1X+TEllIxEAAxOA94AiP0NSJI8pNM01JsrJrKepYifop3?=
 =?us-ascii?Q?m1UwdDp6FTvDEIg5WPLaDP1iGL5Ol7cNMfcC8EuSiwqgeBflYri7Z1ogmEyv?=
 =?us-ascii?Q?WdHOUbYkLs7G9KLi+Y2ivr9KKOr40ugBLazcmXYWfEYNCKipnmTHjMTT8pi8?=
 =?us-ascii?Q?znzmXIkaQMbKU2duLBx4aJn3Hsrvn80sW8LjbvcZxPik7ZBp7kyK8a5kKHWx?=
 =?us-ascii?Q?cmPysctyD1MxsAYHSLicUHCCoeUVEISLGeUAtrJqU0wpG2Rmfb7lv43bjsl+?=
 =?us-ascii?Q?AsCAh9jdSvPS0kYuOfQeF5I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63161d41-f4c4-4f51-97ba-08dd4a01fb3f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:32.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 374nUIG61L4tsVCIheN8pprkzuCi9iWRYKfkd4SX5uWSgSv+o80bbsKZdHwkEDpE+eb0llUN6Bd8Q/ZpZoyQjxoLOg0wJQXomyhDAmf3EKZVQexMu+3OolER/qCKTRwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8345

Enable the driver to inject EINJv2 type errors. The component
array values are parsed from user_input and expected to contain
hex values for component id and syndrome separated by space,
and multiple components are separated by new line as follows:

component_id1 component_syndrome1
component_id2 component_syndrome2
 :
component_id(n) component_syndrome(n)

for example:

$comp_arr="0x1 0x2
>0x1 0x4
>0x2 0x4"
$cd /sys/kernel/debug/apei/einj/
$echo "$comp_arr" > einjv2_component_array

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 103 +++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 40ebdbc4961f..46359019ca03 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -87,6 +87,13 @@ enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
 	SETWA_FLAGS_PCIE_SBDF = 4,
+	SETWA_FLAGS_EINJV2 = 8,
+};
+
+enum {
+	EINJV2_PROCESSOR_ERROR = 0x1,
+	EINJV2_MEMORY_ERROR = 0x2,
+	EINJV2_PCIE_ERROR = 0x4,
 };
 
 /*
@@ -111,6 +118,7 @@ static char vendor_dev[64];
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static u64 component_count;
 static void *user_input;
+static int nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -181,6 +189,8 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
+static u32 v5param_size;
+static bool is_V2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -288,11 +298,23 @@ static void *einj_get_parameter_address(void)
 		struct set_error_type_with_address v5param;
 		void __iomem *p;
 
+		v5param_size = sizeof(v5param);
 		p = acpi_os_map_iomem(pa_v5, sizeof(v5param));
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
+				nr_components = (len - offset) / 32;
+				acpi_os_unmap_iomem(p, v5param_size);
+				v5param_size = sizeof(v5param) +
+					(nr_components * sizeof(struct syndrome_array));
+				p = acpi_os_map_iomem(pa_v5, v5param_size);
+			}
 			return p;
 		}
 	}
@@ -486,8 +508,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (acpi5) {
 		struct set_error_type_with_address *v5param;
 
-		v5param = kmalloc(sizeof(*v5param), GFP_KERNEL);
-		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
+		v5param = kmalloc(v5param_size, GFP_KERNEL);
+		memcpy_fromio(v5param, einj_param, v5param_size);
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -507,8 +529,49 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = flags;
 			v5param->memory_address = param1;
 			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+
+			if (is_V2) {
+				int count = 0, bytes_read, pos = 0;
+				unsigned int comp, synd;
+				struct syndrome_array *component_arr;
+
+				if (component_count > nr_components)
+					goto err_out;
+
+				v5param->einjv2_struct.component_arr_count = component_count;
+				component_arr = v5param->einjv2_struct.component_arr;
+
+				while (sscanf(user_input + pos, "%x %x\n%n", &comp, &synd,
+					&bytes_read) == 2) {
+					pos += bytes_read;
+					if (count > component_count)
+						goto err_out;
+
+					switch (type) {
+					case EINJV2_PROCESSOR_ERROR:
+						component_arr[count].comp_id.acpi_id = comp;
+						component_arr[count].comp_synd.proc_synd = synd;
+						break;
+					case EINJV2_MEMORY_ERROR:
+						component_arr[count].comp_id.device_id = comp;
+						component_arr[count].comp_synd.mem_synd = synd;
+						break;
+					case EINJV2_PCIE_ERROR:
+						component_arr[count].comp_id.pcie_sbdf = comp;
+						component_arr[count].comp_synd.pcie_synd = synd;
+						break;
+					}
+					count++;
+				}
+				if (count != component_count)
+					goto err_out;
+
+				/* clear buffer after user input for next injection */
+				memset(user_input, 0, COMP_ARR_SIZE);
+			} else {
+				v5param->apicid = param3;
+				v5param->pcie_sbdf = param4;
+			}
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -532,7 +595,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		memcpy_toio(einj_param, v5param, v5param_size);
 		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
@@ -587,6 +650,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -597,10 +663,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
-	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+	if (flags && (flags & ~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
+		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/* check if type is a valid EINJv2 error type */
+	if (is_V2) {
+		if (!(type & available_error_type_v2))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -750,7 +821,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -763,12 +834,14 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
 	u64 val;
 
 	memset(einj_buf, 0, BUFF_SIZE);
+	is_V2 = false;
 	if (copy_from_user(einj_buf, buf, count))
 		return -EFAULT;
 
 	if (strncmp(einj_buf, "V2_", 3) == 0) {
 		if (!sscanf(einj_buf, "V2_%llx", &val))
 			return -EINVAL;
+		is_V2 = true;
 	} else
 		if (!sscanf(einj_buf, "%llx", &val))
 			return -EINVAL;
@@ -792,6 +865,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_V2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 				error_param3, error_param4);
 }
@@ -944,11 +1020,10 @@ static void __exit einj_remove(struct platform_device *pdev)
 	struct apei_exec_context ctx;
 
 	if (einj_param) {
-		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
-			sizeof(struct einj_parameter);
-
-		acpi_os_unmap_iomem(einj_param, size);
+		if (acpi5)
+			acpi_os_unmap_iomem(einj_param, v5param_size);
+		else
+			acpi_os_unmap_iomem(einj_param,	sizeof(struct einj_parameter));
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-- 
2.34.1


