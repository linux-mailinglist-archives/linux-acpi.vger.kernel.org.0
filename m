Return-Path: <linux-acpi+bounces-12713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064DEA7B242
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AF189B91D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3B1E7C01;
	Thu,  3 Apr 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qpWHjDDP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8171DEFE8;
	Thu,  3 Apr 2025 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722041; cv=fail; b=DKwSOPTcWO/VwKRmUTH/p4BrKCrZCgzPwqg/IuKVw34Wk/CQ7tFlYJ29qnzp4dZwDYy5C/R8ZKqAqM8ECWmGZOyI7prukojhGk/VrzpYqux9KVwXXDELUxmuRJc7Wt1FmwE7E7W+tdN88QjZqXh23OHWIEtXyp33aMYr04FbC5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722041; c=relaxed/simple;
	bh=VVAdpMoKtq5r10b4NlijRtWYcVfAC2m80muTu6gRq0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGoDRnPHeoxl69Pdu4JWW28/vV5gkji2siFS+uPP8jgXDnzk+ZPKbRTbDvSyLNM2NIQsjOdd3/mCs3X7z/xVKJqg+d94Pjzg6mQm4YUUtYqSMmeBMKGKGpc3uoFlx8ko91tofDqV4ns9hZWCWKGDF9LtW7t66eTOIj7EOu3nEC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qpWHjDDP; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdjRfgse04K1uQB8kvcpGpZWXilkHO9QqHpcHtEZFnbWbGgXGG0VOFaEX6rE34oQvGGaRzIB/ssz9gfOEIxJMK+LwCw7yMoMVO/UxdTHxyJFyWzRu2guToSOb5E4dy8gctnszbR/qNU6/GlC+gUAIGJE6uK4ltKwrchdQjw7UEG2JdA8AC/EqwPptSsawD2sMLrR8MC5+FZ6ra4Mu5xp4nKvz56eWSvP6e+o9JJXP6w/tPZuIf3iFl7hzsS4lOP8L92efZ9/4cnuOfoRvabJZhtxDghVmPcVFVM8FFd4cUKcUjfFuI+CjZ7AoS+8g8eaZ6DOAwjAA8fIWQfmOrQagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1rt2CLKIoLvqMTWoPf5gSooH/yfnRwwg7rs65ofnSw=;
 b=i8n6hImL9nGwshxWsQq6HccE1SsXDEEBFkvbHfWYLTkvhseMpAAMAuzRE1SI9EbRkBuL3bHhYVsYCzr7sS2lHD3yGNOFe9mc4sC+wbYFKPI4JwKIJzaCfJ4n9kbtS0797y/PxBJwbDl4qjRPkVuzMkQmQsBhSRFps11uz30gNXc0glYrMpC5h0tCuDRiDHvX5Ze0EGgN7Ncq3epZsPqup8Gc28qADREDd9YfZRkff+X+bcHbhxF3P43tqzHhhlJeqpJqHh7DWssPNg5rCqP6O4gGzJIYjc0uApUD+AREEtQLDKxtbHDYipc8DdEIMNlCdnYhNTmu2WdLUVYCcFbP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1rt2CLKIoLvqMTWoPf5gSooH/yfnRwwg7rs65ofnSw=;
 b=qpWHjDDPC5HhepmU5wl13L4iiy1oHv5FJn0dBUtEoQkX+tdQxziP1xDds5VwRxzGabIqBWtbwkZ7QUMjxgf32E4LOFWUvA9J0uJLqvfEDADWdb1mS/oW1yqShvB5kKi+xJZiZXsGmuDOgDnfJQcq9WHIkwUqkl4s0oG1/6PH0dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:13:56 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:13:56 +0000
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
Subject: [PATCH v5 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse warning
Date: Thu,  3 Apr 2025 16:13:33 -0700
Message-ID: <20250403231339.23708-4-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 750e9ad3-f457-46af-752c-08dd73053506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LJIM/Qiv8Y3DTiof97EtN6iacVRS+fJ4h1gJNFe0aHI/QEYG2gh6hhMO3dFn?=
 =?us-ascii?Q?ldjvAgin3k37jwGi5nlGNHik/yaY+tVSGrLpilKd6oaxEfTXPydOyyaFuZHa?=
 =?us-ascii?Q?uG/CT+b7c2rQ41shgVAirTs9GecxrGRJ+I58pmwQJyhL0NrXmoyICmMHZzeW?=
 =?us-ascii?Q?aq3ZOXi8yItql3H9Y593vW9W4Fke9zCMMjqU8R9K6yC8ET/njQYl25YjyJfS?=
 =?us-ascii?Q?+0rPeVaLo8lJrPSHlhW/uZUSkUSB/FKdU561PcXM/SmetzYD6LdvLcPRv3hd?=
 =?us-ascii?Q?mGFFSIzMBekhGyNxJLczDvWhMkg04wuh34RwAoo9SmjVYrTwrcNQcRIVQTeu?=
 =?us-ascii?Q?m4dtmcJ6H6YxqsGiXjmEKR+rK02SsRjfNlI/Zp77ExGBJMRWIvyyTZaA8Cz4?=
 =?us-ascii?Q?BGbMVXkQgeO8RlWl/d6YLqBB02hJ/vd0Z5VR7DXH0szhAiYSxpPpvq0bvors?=
 =?us-ascii?Q?9bGdeuEKM8wAIkkCG9I9kfdZjOTcfFeWoY73fU3HpKZ8VbU+S7Ixm/vSynlA?=
 =?us-ascii?Q?kHL58PgAUpzzDdoZiAftEdw3fDHWkBRayRLm/URFYpfaUGKM5y9T3P6v6nvc?=
 =?us-ascii?Q?c6CxaT3wzJD+P1dwbOasogDcHgc6bD6vZzpCw19hzdilTl6tofyGeYFKvW7P?=
 =?us-ascii?Q?ZXaHW06hqgD+GOm2J4f5OKrxKfeqGbSVW121TAHTP2OvtJNawvXBBs8yu8t2?=
 =?us-ascii?Q?+JEBpgO6M/deRr16Ppt2fhrpEu7GwLWE0g5qMEZToJCFNDPpSMlPaohWmLx8?=
 =?us-ascii?Q?IPQ04gKzSFqrA27BL25FezacMfW0F1qTh/NxS1T03ok4RORJMMcLvHn2PsY7?=
 =?us-ascii?Q?xV4kfeqpcvV7vbx8lWR/Ppr+/8FhLv8EAiYU4/pjM4jAyLV7VxiI8dNUGeJp?=
 =?us-ascii?Q?OGJCoCYwtneebUqOQjp2pHLcbyQDi4+WzQEgYZDvP/dEMW19jymhYoIQUMv3?=
 =?us-ascii?Q?j8V8jl0AAVKuSjY6vL5KoMpNClvZFL0JuFQ32PQNLJUGHgs+HmhctJ2rski4?=
 =?us-ascii?Q?4kyII+HwPMhRzpkmNzD3By3ojfv0gYfftg6EAyPD4dgGR0K9jqc3ipv6LCdU?=
 =?us-ascii?Q?fGJ9+n2naNEmzq7PEYpriHW1mX13KT8Ac9+rBpLrYs5uUKgqgsjtMvnS0Epc?=
 =?us-ascii?Q?X5PNb1BnA8HNeM5JpO/VrVqHNHDupidttnX7okq83uM9cSG6Mz7I1LY5X5du?=
 =?us-ascii?Q?N/1erCzfNjUxfiDOFRCYKkzP1qYLE63Ye3JLRGT8D9foAGXBnJ5ljN8GSJkb?=
 =?us-ascii?Q?+cF5GqWoPV11bT4eNzYn1k4Ry8Z5OblBTHQXn3qPEWBeE1SwnsDIGH71iWsi?=
 =?us-ascii?Q?I/SiS9vDIhA7pjRlW6lM0qdCe4AIdKF4JMn/sSSrGrY6/9UgwWCJU9lDYoHq?=
 =?us-ascii?Q?d8yg6yZxu3RdFKKD9z20aW4VJDSVxAjCDKIlZwPbHXuUc/veT+cQmvTvz2eO?=
 =?us-ascii?Q?L3sP5p1ruotV5Nm+JYncQl8VtKKnVa45SarKos2jOoMqf1cQNJ4p2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXjd2P+1utnoU1ckbQXGhxXVtTRcTa4tRe2tEAJ+HvR1RqwpoWPsoXm/6lDr?=
 =?us-ascii?Q?6eynXCXIs/dvDx0Ojp5ZPNLtn1R6o4SlKM05c2g4Lgcm46og9E4uTLdWU3nI?=
 =?us-ascii?Q?yVrCOD4RDcoC9gRMH0rGW6l5RIMvLM41p9eCoe5BCbZcJKFHKiHkKU84bpel?=
 =?us-ascii?Q?EFykk9xD+d38/Tjrg8YkOFe9Ra2+KE02YbrCNLL83+RBibahMSSYlbT0foLR?=
 =?us-ascii?Q?oi6nISF9XU3cbgmmfyZ3Jr9WMSrTRt9C0dRH4F737EmpqfkrwCmxq9zKMOb3?=
 =?us-ascii?Q?pjChUeaLujvjF2sBsKmB8/QMzpboZAOnod1OnZpfxYsmiMh5T2xpRxtVuH6M?=
 =?us-ascii?Q?clMbhsGktKBuh99jWcdKIQPZEPRHHr9Njn9cGNwkz/ajE8pA0BzNOXYdGnnq?=
 =?us-ascii?Q?45AY7k94kd73alFEAdBsK18SBhuvWNNaN8385b8q/F+r3M+EQUTfT095hH8p?=
 =?us-ascii?Q?8thxPHKF55qEb5LTTbMnUig57QwPrf6hEJOqBYO4i2heiRBGK3Lj9Lvt/oZ1?=
 =?us-ascii?Q?4JDwzCaXo3rdjf8s8JLjda/oFzrHtgfnFFsbg2+7mQZDdDPFWLyyYD5iQoV4?=
 =?us-ascii?Q?S27fdXTMWC2bc+2bp1J1xFWtXm8omkIRaTeD5qSzXPagNvjj5XFHqnzo9lC6?=
 =?us-ascii?Q?9JtspjmkQUNqilISSgHFaCR2DG/IBKVLTDfxQP0qjRaTpaNoa+tS9vV8t6T6?=
 =?us-ascii?Q?QIYktDk/Prun+g8mD7mj5MKmC1f9X8bysEG9dRZ15y1Gri5u54TdEuWcIohK?=
 =?us-ascii?Q?ibHKZ6B93fu+fsQ2RDjlqTplZuEWv7lmqtTNP3DuMlOZSuTanwYkMYzMgDKd?=
 =?us-ascii?Q?O1Oh52bko88c+W8SNJQhei0FVlfzSyUnlDCd1EcLJJJaeGvcFjRbiq/rvJbz?=
 =?us-ascii?Q?zpT5qw1qauvItX/9IAOLhm5BGwOTghvOvdmjh+/RJmtUuSTu56VA8nqto2xt?=
 =?us-ascii?Q?yK3A3B4TMfYvMoZWLIX82vBdixcsRjRLKi7GdRFmXnwMjgp1LJktYxiEPu6L?=
 =?us-ascii?Q?PPFgy2DOHZYeLueowtKfQ6livfvElnqfxB6GESQm1Pr8KLcisfGjnXKRKHsi?=
 =?us-ascii?Q?yygrE1Rt5z2DwER+UzUpttxLbxf5V7Y9AJI9DZAN8mcdpEeKZ33d2BX6lAYB?=
 =?us-ascii?Q?awUulQ4a0nYZmk7GKAFnzeOze4xmRiSSygRCC7wcHBaBAZdvI1oYRNlPQEB3?=
 =?us-ascii?Q?QUCitXqk/op/BJCkUoZL9+aIRwH/zlPIU6PwcDcuOBicgC1HDBYIW2/g6iCl?=
 =?us-ascii?Q?DQSLACa6q4o2sdNnfvK2wkKal03WUgee5IDoZosuNtsn2xvWM5A2X/JOvKgH?=
 =?us-ascii?Q?MjIUiNh8gF6mK+Cx6LArAwq47z4rc8f6kFl5qwir/ghrOVmdmr8pBysqaRWw?=
 =?us-ascii?Q?jSiqSqmne3Kss+Vkag1+3irODXSF0aSeg0lj9Cjcf5J9aKEoCM4hdCUL73lZ?=
 =?us-ascii?Q?/Q7TgGqVMTwyXh3rmPaS+Ie9Ifxods0SHM2a8hAGenrVP9QUqpAVRXziCuF4?=
 =?us-ascii?Q?oFJ+idF5Yd68jH15qRXx4OEHjrW22XpsFyxAnOVtqubiqiGnL2v+OX8kgLzW?=
 =?us-ascii?Q?Omsr4pAX5tBYcvzUEIR3m6rjDbFf7xg0y9ZOg6K93rJSsZhLppMbp3BXztSE?=
 =?us-ascii?Q?LfvLuzY6BEoF/2K6Fa3npkA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750e9ad3-f457-46af-752c-08dd73053506
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:13:55.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGAsLviV909sqJbDZ8wYjfVK6IK+kg1EyoYCfVAsDEtLQHJCLBrUKd2Kl4k+M0ZpK87sCPSD+wh2oY1OaLRcV6c5v+1K/Igf8UAv5WAgnAp6wd0ZkscIgoo6iTyJ0KQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

This patch fixes the kernel test robot warning reported here:
https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 106 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..47abd9317fef 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
  */
 bool einj_initialized __ro_after_init;
 
-static void *einj_param;
+static void __iomem *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -214,24 +214,26 @@ static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
 	int	offset = v5param->vendor_extension;
-	struct	vendor_error_type_extension *v;
+	struct	vendor_error_type_extension v;
+	struct vendor_error_type_extension __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(*p));
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
 
-static void *einj_get_parameter_address(void)
+static void __iomem *einj_get_parameter_address(void)
 {
 	int i;
 	u64 pa_v4 = 0, pa_v5 = 0;
@@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
 		entry++;
 	}
 	if (pa_v5) {
-		struct set_error_type_with_address *v5param;
+		struct set_error_type_with_address v5param;
+		struct set_error_type_with_address __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
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
+		struct einj_parameter __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(*p));
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
+	struct acpi_einj_trigger __iomem *p;
 
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
+	p = ioremap_cache(trigger_paddr, sizeof(*p));
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
2.43.0


