Return-Path: <linux-acpi+bounces-9971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C509E5FF8
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD91654B8
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAACD22F393;
	Thu,  5 Dec 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rk4Vut46"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020089.outbound.protection.outlook.com [52.101.61.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8C22E3F4;
	Thu,  5 Dec 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433564; cv=fail; b=NeC+f38QA+4OSOnQ3U8qXaMAyf/CWDMpAWR8s44Q/N9cn1CR2SN35oxKlW8e9Isy4ZDm8hXhwiLeVvU4/dHoYSADJHaw1p5/WgiTyOvOOwhWcco+gKukpDjfOr8kN53neK+g9D5tWxuxCXqhPFFPIrnA9GL7Fwwm/6WgegcQxkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433564; c=relaxed/simple;
	bh=75MbbhawtGZacziqN4a8wsYv0goG9fe3a5B8ZWPxnj4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3X2vJ2zsItyIq7PE2yjM2hTYA8pWh2CUPJjiZYuH4m8LERy7CzX+3Odj7Iz4qh02Kftfj8m1aw8NwZlLzQvHaQs98K54LFuwbOiOXvAxXpEfy1IRqVG7rAdKeKpEzNE/zoz7yzEqQ7ztMt1UsClX+HeXw7meyuvPwEb9ylnas0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rk4Vut46; arc=fail smtp.client-ip=52.101.61.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2a/gQp2FhimbDilLCrITzMN2G0c03YCC6hDtThz+xqWJrZpiTP4kttONNgDpfMsX9RcIn2w9cI5eJrvwy7ynJtxr8KKrIn6iS/1WSML1YThqXPt9jCaVsjAS565c/dZIZjboJiu74WwDJzl25N19E+S95CXLe0IJKnL6y/KRcPIYuZ9OhRx5iF95KiDhBiFTZc6ryG7wCxIJqQdewAbKeVe41g47wIWflqfJXysHG17IyGra800eXkvUr/qKX9dpkD0u3AYfZY9r/2ghMuaHrdH/hUTAlpsL3nvVZKwU8Hx0uI0+NiMf/KdLiPXbv4Uwpki4OvgNegLBEJw/LyQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFLNFH3QAqV8EmDLAB4qIre31uG6xw0XfnVsvqqC5i0=;
 b=u/EeP01DvitGHqufEhArn4XaYFL3wkJkojL8rSlRW5IvrCvCwkXuWp6vEYfMTfV9n8Doyw+y/vp7VVRu78Mx0pE4AvOoJLfbi3xU8aomvBHLmF2IUJjmbmywXaU1pfCWvD0ScbjS1vSIt1yTKv25lEpNRHULgiUS1CVHX+r6yD2yNe2WQbS0bhX/yiY+2wLqgSFe0byZPtaaEW6DgKuwT5jnwFMpEowP0Q1dgY53rfNlHAsnDbeYgMgbSqbciJ4o6w2UKwAhAF4Mb3BPSaqpyiQw8REwT51HP9bxg9GGQlvHGk8bWMlrNqmASSM/fXYknlLinIhpZf7DRNNcjOn1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFLNFH3QAqV8EmDLAB4qIre31uG6xw0XfnVsvqqC5i0=;
 b=rk4Vut46ZWEMGNYprabpkzIWvs2HPe59nGajOfS1l69/l3Sb8sytzJIUwcWByyTr0w7Q/+u93x1vFeSTrYFFM3SacA1IsyRn0A6rCLGVnHQ3EAovs1vDLq9ctK98Ih+LFgRF9OVATn/Aq4bTgZluac85YzVBjqSdS4FSfgYjIms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB7759.prod.exchangelabs.com (2603:10b6:8:7e::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.9; Thu, 5 Dec 2024 21:19:17 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:17 +0000
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
Subject: [PATCH v2 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Thu,  5 Dec 2024 13:18:53 -0800
Message-Id: <20241205211854.43215-9-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS7PR01MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: cccf5c1e-6d96-4fd9-bb07-08dd157279fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4wRvSiiOpu3MgMuFzrD1JR/cXeNG8U37CpqAP22cVr3j3/x26+ORqvugHQAd?=
 =?us-ascii?Q?GdIjNs3C1H6JSfILQ+2YCbaDWU8DmVh6BnWOzejEC6hd64DzrXLeE0q3SP//?=
 =?us-ascii?Q?BsZm/ORwGdawlwZDDdaQ26wMzmO6NvitrESAizJUSOoWSuLePxghwbrjhO+X?=
 =?us-ascii?Q?gt+ZwjicKXZnECmzdJf0m5R4R04mwE2tIpFmdo95iFku7adKZED8RTVp7dBT?=
 =?us-ascii?Q?mSHphMtSHaBBJy8Sepn1M1b5ngzGtaZ2FjBEtoXZhbfaMJhckNDW1M6BBmA/?=
 =?us-ascii?Q?Pm4KbwMMOKzP31eBIp7vYZ20JkoVDBHHPBiOtW2UPfgaDBB+hmGqHFLexGzG?=
 =?us-ascii?Q?CvnyvWkoiMrbs9ikPYj2GTaXgta6LZRbhtugvesz2rJXMA74ePOExFk9HT12?=
 =?us-ascii?Q?F0Nw4kGAylR/BSKzjZC3qA+AOCOsdpR36CnpqPhykvg2UfdGTutuIASQSce6?=
 =?us-ascii?Q?bxkDOVhyi/DdwacQ2dw+2JWdtVPaDv1PiPltfD96p7Z1ZLFn5dEdGS46myYU?=
 =?us-ascii?Q?4VM9pIn+oaxtlqrkXIyvUlKLDfB6oJ92dqyFenM92NsqqLy4LsZzJ83+C7n3?=
 =?us-ascii?Q?/SfakFWdVJu7NWmVshKKNO5sj/w5OwEo//jvslrU6gndepzE+AkVvFHXLIh1?=
 =?us-ascii?Q?I5AehWO09YJUf7+CY+G9imdZJmPNLHTq/tY5uyrRAscG3IjzCQGs3baE7iht?=
 =?us-ascii?Q?E6xMTeCUD/6AXh7CL56BYgtcQdYBYBUfDuAlxQec10UsWV5H3p97TtnUPiwx?=
 =?us-ascii?Q?EFgbxdQFQ+eyocrqxPv+w6n+4ngSIjbeHuOmabTei8NfCrQJ1KyDRQr4O12C?=
 =?us-ascii?Q?s5F8AfZK2qE5Uh4+zJFg6+dbGX6aNlzzWamAZC8qrKqzKtge93LR4+f9o+FB?=
 =?us-ascii?Q?juw18M0t2KDxoKGLjAAL1IDTUMS175Jw6+Y6QJiQLr8JEuvfoHgqe0Fi8n+w?=
 =?us-ascii?Q?m1G2lL9CB8p4hD5eq9ZMLzZjVdVac3bsNxnREhpnVzuGJQ4N22QsF+dFZgec?=
 =?us-ascii?Q?docwXKfgEa9vVNGKaJiXKuN65HIXoMf045j5oH2d/hX7am60Y+cQ1dajoJyR?=
 =?us-ascii?Q?Buo9kRL+b0iu3ShH70hrkNpV97fW8g7+WpUathuiNM/Ai4HWQoXVOGwvSvZK?=
 =?us-ascii?Q?H9yug7EY6y4bympB6dqyVEeD/KZXSt/FkpFArqM7b4fcixWlFuVI6C4y3AO4?=
 =?us-ascii?Q?aDTqmKheMqtE19ljnshCdyjalL/aSJR1o66mrSM2L1AUnnnfWlzSB7b3niOU?=
 =?us-ascii?Q?7ouV59UDUuyrUoLbJaA4TX16S6Zup+woH9MzHOJgMiTi58TDXmdSw8eI7nln?=
 =?us-ascii?Q?7dRaXH8VIAo+UYTIFNc0/Cx6JLKUmEdIese4xQ1mcT6mxb5ozmi5gnWjXe1O?=
 =?us-ascii?Q?hz/aSobFSNEIbo+l2zSqcQFlG+klx/aM1A605XtRXKmcao5ZGCH8dJGgtQaH?=
 =?us-ascii?Q?2DA0s/b+0+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qa7KsjrAVC+Id38kGzkPbsQlPketbVGcMQXUqQDYLIjdUSsi6XJvspp6xxgZ?=
 =?us-ascii?Q?EXL20EAUtWWJSzxIhPEWZ1QqeOlGuYgrpNJUMad7WaA57C3tHuM0lUG1cJRM?=
 =?us-ascii?Q?con17s6pbmyFBPTYdGU1JrT1p2m1ZoeJqGE0wEWN7AhrYq+ZrmNFQ+hLz8By?=
 =?us-ascii?Q?TBlsl80fxnoyPULsQMiVQONvBjtw8nrQoqRlWyej5Ujwq1eOdZutE+epOc5l?=
 =?us-ascii?Q?7la6yJ+AawzIK2wyMh9rxd61AlmrWVt9QVuU7YtgGlwD8RtNqaTTbmRs+ZJB?=
 =?us-ascii?Q?yE4wfn3x8Z3DhKBmsCboZH7kIJjPkif2VKqNmCMc9m/hjqioUTFAEsv8dQjD?=
 =?us-ascii?Q?iOGLI9XUohap1cjzmAvStf9XMRf0c2RDsufg3peVNbgG9253si2Iu2y6Vfsg?=
 =?us-ascii?Q?lGC9b9Ga7Vjf8nQalDqMJcQlUjL78PcZUA7AoS+I3kflVJ4ecvsQnACfwSg3?=
 =?us-ascii?Q?b9yn9MtKDtekzWLq/Av0yXIwTdbEZErwYsW1EJaDPA+yqkgwAIM2LrBZ3YVt?=
 =?us-ascii?Q?yehkeyN469ZGmcRkSUE8O0bfQ3dMKFj9CgYCv3i7Cj+NCbchWRgMKecjIzzI?=
 =?us-ascii?Q?a9HBFygKvF2SL8KQd9KnanN+eEavvQBOUvj52r4HYE6nxwyOBgPlwY9K8AWb?=
 =?us-ascii?Q?l0mGI9/ynVNkq8SzD2jU8rX6ldk+OKt1k0Z0f6hGSxw7Vl+xJF7Crkq5uXFt?=
 =?us-ascii?Q?FJouqqKdfHovF76V4CXN+KDLKHTiYWpyV7F0jQN5C37TTg8nx8WAua5PRdYk?=
 =?us-ascii?Q?FMkU89CA2v7VGc5IY01DMakWqlqpl5AiQd+ZlbWNzTpe8d7hQ47th9eMXLXZ?=
 =?us-ascii?Q?hvBJgiN7PP1mG8NiGITnuqhCzhH3X9Rl2gQ0z30WuU4MCprIxW820bhTgQ89?=
 =?us-ascii?Q?D0u20jxQ+awjzp9QOCNTadeJZko+PtdEismvndbG3u52dylXyyVJJJxhixvS?=
 =?us-ascii?Q?r25HEQnsaIwbOLycfmxmAbdopoduI2SrHf/ErKMoZeEnY7FwtuVW/TnZI1Cj?=
 =?us-ascii?Q?uDlrsczMW5ScXCJddNpnUYMf2Nli6R+HyUF8C7dfnivxoW2QzdE40hNxyhDW?=
 =?us-ascii?Q?MdJkizzCMdUc6/qM2BUOrGLZW3Cxi0rDHw5N3CcPDMoKzxG58WRU3i2n/+2c?=
 =?us-ascii?Q?zCBzLKu88TN00MG0dkMe2M/coqjmrpEwxRQbZQbiIq0crXrFqB6DFdnPt2Bf?=
 =?us-ascii?Q?OKPq0CtBOHm60RQyaL91bELx8JBdxthugPDXrCCLxakicvXh+10/L6F3+4nx?=
 =?us-ascii?Q?2FFGzMww17pNecsXwRHD1MSKAy6kiQfsT4Sd+p/RgLFxoHYTXLsHvTpNDBsP?=
 =?us-ascii?Q?y1wQTAMtaXikBRAhcNK6vU+vF5OgbiVGvkXEN86d8GHFLqceDNkpEbrZ4AnQ?=
 =?us-ascii?Q?sBcO4plS1dL55XrF2VaKQBlr8+WKhEj3j/vg3bPBqqDa0etBI7slorB543sc?=
 =?us-ascii?Q?mJLBrtsI9FnmnEjN4Zl34ByELFLDDHbmbV7FGo7zxqIhqrVSRDJhtRVl+vgK?=
 =?us-ascii?Q?zjjTwg01gdmGN//1RzGOCMOktL3GMbX2A/FA4KU6Y6Bp56TIvkwHrtgihCaI?=
 =?us-ascii?Q?EBd9/vyx1xgk4CFFLSvwNZkx/tat5tqLHgl7VC+bIfVizlXF5dWQdvFF/ge1?=
 =?us-ascii?Q?p8sk6gmGNeMwoGT4xL2Xp6U=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccf5c1e-6d96-4fd9-bb07-08dd157279fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:17.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlhDbLc1Xv/WXmfIIVO8OnfpyTR3/1+9LkwYZ+bB4WPAUw5eGEtV3djUh5A0vfAcPILiWgc6TiJPX0e3ojoimi32i3Ass8SDYB0GlNAxxO1nqamSb9XBdILnGjNKPD+0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7759

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
 drivers/acpi/apei/einj-core.c | 82 +++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 1961f140ada8..d8ce859e6b5c 100644
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
 
@@ -181,6 +189,7 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void *einj_param;
+static bool is_V2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -290,9 +299,19 @@ static void *einj_get_parameter_address(void)
 
 		p = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
 		if (p) {
+			int offset, len;
 			v5param = __io_virt(p);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, v5param);
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param->einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				nr_components = (len - offset) / 32;
+				acpi_os_unmap_iomem(p, sizeof(*v5param));
+				p = acpi_os_map_iomem(pa_v5, sizeof(*v5param) +
+					((nr_components) * sizeof(struct syndrome_array)));
+				v5param = __io_virt(p);
+			}
 			return v5param;
 		}
 	}
@@ -505,8 +524,49 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -579,6 +639,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -590,9 +653,14 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/*check if type is a valid EINJv2 error type*/
+	if (is_V2) {
+		if (!(type & available_error_type_v2))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -753,12 +821,14 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
 	u64 val;
 
 	memset(einj_buf, 0, sizeof(einj_buf));
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
@@ -782,6 +852,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_V2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
@@ -942,7 +1015,8 @@ static void __exit einj_remove(struct platform_device *pdev)
 			sizeof(struct set_error_type_with_address) :
 			sizeof(struct einj_parameter);
 
-		acpi_os_unmap_iomem((void __iomem *)einj_param, size);
+		acpi_os_unmap_iomem((void __iomem *)einj_param,
+				size + (nr_components * sizeof(struct syndrome_array)));
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-- 
2.34.1


