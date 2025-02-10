Return-Path: <linux-acpi+bounces-10969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C2A2F752
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4A1167FD1
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C479C257AFD;
	Mon, 10 Feb 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EeoWxIIi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023100.outbound.protection.outlook.com [40.93.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F51257445;
	Mon, 10 Feb 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212655; cv=fail; b=ln/i2xJMwvf6N/+9npFbmNJTTzx0uJ8ZxiihhjXbpWE/qPeoTL7TNaQ1nfkcyQ+3sOf8pgvd+cO1MlHaDt6wJT62I36nPiG1oJ+rzQkbcn0Q3O+M+NOQhe9CTNyyxcI8NguFDwyXUG5B6mVQh4wlT/Nw107BcO/SnyTPptg5qMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212655; c=relaxed/simple;
	bh=t5rhW6KAMOQgMyec5zk0rjO7QxdrR3TGaBpPrvKdLzk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhAnVuRg+lEy3szPSPE7wPK8PxsO8R9RFHlcFsqlt62Ub3nvqiQFl1bsG1qMhDBAIbFIf+oAwguy8EWuBxwJrMNcYW9HJ8xwnQmXcP6ZW3cvtIL2/CqkbRQER7P1zw9f1X/WhzI/zAr01gdY8S8bYlQ0q61rgwl8TWNdMh4gAgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EeoWxIIi; arc=fail smtp.client-ip=40.93.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPHS2n42eZxVf0sgQpXj0bXsok2S6MC2cE5+EGL0DKz/9pnc2fq9ha0ZYBBo+xtr2K+govOW0rCad2cybPkAF8Gm2SufPm6X+bozXRNCc587hsjDu6wXKQ4Ic+oL8lPrNtK0Yrncc5k5S3rOQTqPVaA07WfP7ym9eYl4pIR72Cl9VhjDSxWtj8zCoJGiRyAgqGe73Gp4g4J4+/eXcdxEGiLYZhF2S0ZAA80TuqwXFK+tTkhMBnh5/2fy9vrR9yp25/ztRLY8qhR7MXELhYqh1W5z0I7shrkewKNHPKV/fLO8HHiFG/vs6sMCm0cgeMSrRCGNWC1Q+ZcTqRqp+rssQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7bBzpfivojaVWfG+RabJmYbBMMNRoLaGegAz5C92n4=;
 b=lyrTd4yVj8MX/S3ikAiilF3dNH6pnZH+fbqc5HveC80WUnOhoHKIJJqTRs2niVmyjzNSlDRnRT4hdiwLGMFEhYy+M+RkiMj2YokvqItR3iNtKyYzaAim0ObdZhRgy/X4uRZRFjErj0OfYr8ZzZKGXyJZqj/56xlQ2JXivdVVDdxBCLKT29jrEF1/OaWuNbR2d0fNdvOqH+7eAaS/cajwUPk7L568sEwL3D96HMKnxTmaGORJKifIpp3XZba3oP5/mLJWxmi8ozAFhjVhfFBVUHDWQrw+nQjuL5NDRbErx61tCMZM7Ql5NwfPbTVgE5pa+hQx0RljSoSHQtCzVjJ+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7bBzpfivojaVWfG+RabJmYbBMMNRoLaGegAz5C92n4=;
 b=EeoWxIIiI5qxBGj5hjchkxwtbCC0BNA65yUdOlWRqkNbDTcq9g/MXfPZjPTSveIAzqoDFn62Bb41Ue4bh2nnLty1BCLDJd4dC+OPULmWhmmDBI9Q7/YHlEXtv2Z52dFkFW9x3isnw2PeXQc6/49pgk32VLo939JvF8YBRQfUgdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB7101.prod.exchangelabs.com (2603:10b6:408:150::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:29 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:29 +0000
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
Subject: [PATCH v3 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Mon, 10 Feb 2025 10:37:02 -0800
Message-Id: <20250210183705.1114624-7-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: d55ad548-1ba3-4d3d-5650-08dd4a01f954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8C9XRXk7TXbJPBsCgp/+f8w7TH/OlzXRcT0Bqbf/UtAFlhg21RZQkkzzLaiI?=
 =?us-ascii?Q?v3pqI9D1BMgTwPuJDw+GMqalVYOAjPKfkOhIiivkie2ApsqDQ7c2ph9kEGoK?=
 =?us-ascii?Q?g0LLAY90VkKmDwA2TEmfOYC5MwLJBkXzJhSejlD2Hf5Mo3c519cCFPE1GGE/?=
 =?us-ascii?Q?uZU/rLJJM2l3YrXHbHBg8hHIndNJZGgX4ziRaO75AuNp/vVMAKUnj0kMuDsJ?=
 =?us-ascii?Q?61hmfzDNBYpTYc75WLWGhTZoHWLymSSzDTbgx+aSsqusvazC+B0ze6UyvElC?=
 =?us-ascii?Q?iAHmp/O8gn7TJlAk6YoAT8+ZD9fwk9BVc8gUbtIO7bwyVEHezMJVEWFjWrg2?=
 =?us-ascii?Q?Bw4Moi4rzg3ZWz7g2nVM8VM1uXKph+JnkFE4/E9FFoL5ohc09eBrAIgD3ZRn?=
 =?us-ascii?Q?lGtROdFIxQ/r/2alORKaSVGfZ8b3rcVPgnXSj1KHsWfIhMY0JwY4989iepJ8?=
 =?us-ascii?Q?feNupFzspTeyI9IGY6n58cXEC6p9KJydhUuPrNjtoa3009Qp9rDz6KJn05hW?=
 =?us-ascii?Q?jbjYb9MF4FReESV6ydmr1WvVez8i2oFUF9AN9n23LP9P3eFWU2OBlKqx6JlT?=
 =?us-ascii?Q?NNynJXQe6zyZEiybjIcB3WmQV8xjHVxGNMZgiYR53SfXuCD86ZZ2FM9lunF1?=
 =?us-ascii?Q?aTVMILlJal9HxK9zpdSVA2vVeP/FUV+UaIbgPdjgwArspD7fJF6WC0LvKVCf?=
 =?us-ascii?Q?sJrrGO+c/TJL8xRfa7Sy7DcWuIo0wZ1GwdD4rWLOmBldxUyv0q69fzUl3r3l?=
 =?us-ascii?Q?HHaFCsfl/D8d//fQ76t56hmRpw6MHPWo26mnFyRjl7+aLrtxXUHFZmUbQfCo?=
 =?us-ascii?Q?mmQdnnX0ySOwIdDOS/cH3+Cg5rANvyL54z+wNLTTFWMi5IyKB8K8TcQzuEkQ?=
 =?us-ascii?Q?4Epqw+UWd5LGFtnzFaMsHWeZzOLSFREuSN1Sc6zGyauLC8GewShuXWxC3l1J?=
 =?us-ascii?Q?Mgn8Fu1zD9YTij0YF2DzsV9+SebWBjSDQkGDuRiKpmJ03FQSDS8NP9XdG1Lw?=
 =?us-ascii?Q?UPHSSUsdumDHNvVGma2Zx3LD2khIx/OPgHhHY1ye5ckd7/+dAbQjNCHkFJtZ?=
 =?us-ascii?Q?DTGtNPrUD4t8Ylo+fuNqJfmwZEf43n3r6x+Ezb3IAzSe+YFBtX0IC7qR/AxW?=
 =?us-ascii?Q?HAGLMhATGHxUB3Ov4EUzLA96zB4B3hcR0EQ/c+hfQ+fO5X5IKU0nvWzmBzIj?=
 =?us-ascii?Q?JMuRp7BvonnnJ2lekVXNfJLiiLZXK0QpYpjxfgyXuj2uRrxhoY1+AtHLSMDo?=
 =?us-ascii?Q?gRb5e5t908TZGP9L6sNnHpoN8gSSQNPAiIU9DU4patP8qITfyNdr5ywFpH3G?=
 =?us-ascii?Q?MpS6ta0wgXIE8jSMI7nYWUqdvNu6XjVEu84MGoLO6tI6yyHWRiPs8bchCBHK?=
 =?us-ascii?Q?zIqdp+vhVgWfhU6Tv07UOETPghuM96wNd1jslp4XuYQW8m2Rtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0BKol0lwHIFMbsFP5vNllrGMoZle4d4H8QADdKV38At9MzCnh/mDm34UJrZ?=
 =?us-ascii?Q?Gniw3jh089HfrlvTOdTQjEwOfahqLS8IO793HvnpfWiG4VJ2a+zv7oYEMnWk?=
 =?us-ascii?Q?/J2jUZNjphn/RHvjle9shbFpQURQS7DI2axzIMSWERxb/cneMvpHx5c8r/S+?=
 =?us-ascii?Q?A8bVceW1T2h+URrgCcUgVmbonhroe5KepTR9zXTdQvgM1zOMDi012h4wBcIV?=
 =?us-ascii?Q?+8/jLh5TpuV7aXe2ThAqtyVffKKMNDyLQjwjji7M1B8v3Q6DHykWlcUurULG?=
 =?us-ascii?Q?0ronsxN33TuySgG6LdBRJtRh8lp+ajMw7HJ9VqKTFaUiAFfMfWaTNkr7wj2T?=
 =?us-ascii?Q?jsCMgJnAxg0yqTQbhB+0yMRONxyaPZ2wur+PwZwGMmJKPPozqoAE9fS1WWOd?=
 =?us-ascii?Q?di4oAwauoZNEHSTmLl2ccFfqzFPls0Z5eWq16xLWoFLePmVXkGW4p/inKcll?=
 =?us-ascii?Q?G+xqiSwI57S0AW2ISeNIROsn2dq1dBrkD8l8iBvXSaANmyysOHtl7cKf8aQn?=
 =?us-ascii?Q?NS0c/GQEAv2wWbpiMVjMR3quAmqV/T87GwPkkgsRYU7b7vD/ig6N9t5Iyj0C?=
 =?us-ascii?Q?vQy5rgbyldEq+kaer2nhxBO/ATeLiQGve3Ob99pHFb1kAn58vz4LSXMCOFft?=
 =?us-ascii?Q?ccJ+xjhVWgZ4oX2olelQ4830QIQXSNiKrLYzpqYzfYmLsc3vxs4sh2eXFNp3?=
 =?us-ascii?Q?1vBv8xtKSi/yGBSQdN8Tf11zHqG76VGyAQSwg0dmhE0OzPrByrX4TmIaQkmh?=
 =?us-ascii?Q?GV7NBHQ6d9wuC5XRE65Pka+1icHdBdgEu9Kw4ij67Re7KBEqeo480YKL/5LH?=
 =?us-ascii?Q?PRl/Rvi3F1zeVVdrgFyXnVFG+r3jh2wpRCm3vsOHo2F6LVr67Hb3s+Wi47bG?=
 =?us-ascii?Q?bP1S0jYv5q0sm+yTSKvjEf0DDuZW/4yr1hX9j0VpgcoFiF5cpuUppLJlgQi4?=
 =?us-ascii?Q?Y67zfdtGnWDSV9ZosfaBK3TFRrjguaOe6faD6oh1M/dkOLSxTwSh0V3/aII0?=
 =?us-ascii?Q?k8nSWOn6YI4oSRAdiGevfw9Io5y/dKeebElYnUTdF0TP6s86n0rua/jtPfGx?=
 =?us-ascii?Q?yreeS9mFY1nk0At0YAD/2gobu1kuQsKKr+xOit/DUqH4b96Vezz3k6E/wkBX?=
 =?us-ascii?Q?yyz5SLH/M1PnEPP8nFT2JJ5rYE2zB22foF3HXQncjgdV7Lb8SqjS6yrL6cgA?=
 =?us-ascii?Q?Lqzdv1zfdLN8azQeeTK2VtTzHb6Sl3789Y63nk/o9v5nrVg7jFg+ds6558aK?=
 =?us-ascii?Q?BvsghZ0h2wLS4iIpGuOK81IKB86Xq8O6wv1dRok/KZu6QrwOffb7teNtf38I?=
 =?us-ascii?Q?BITfxGmiG+46dJLlCZqiFdkiAIFaTvGOLO+0ImtsJTQ5ddaKAgRdj2CtVXGd?=
 =?us-ascii?Q?64AIvMVjivPEXnztCJ8XbxhYqCaTaGhst5KSLPYx1izUxf4unCcyBEsJCSiw?=
 =?us-ascii?Q?6teWtT0w6+BaGe4P37MUOiRvXG3IRhfk179uk44CQBeY7Y4yQhEG/ZzuAgL1?=
 =?us-ascii?Q?sKU0GXy3a+FCTyR58wVtt3wH4+yEEJxTNbWph2P2xVzYafDu7giieiV0RjXT?=
 =?us-ascii?Q?f95BWTDQsMCEeiKseQrNxvCyhhyeMpez99xJ46+o9bk5/CFONsZ5uJ6osQ4p?=
 =?us-ascii?Q?gA53PWIxz0Y5034zg2jOBxo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55ad548-1ba3-4d3d-5650-08dd4a01f954
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:29.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaomEF2Hk6kE2/BE7KVn3Ose3TYxU5zXK8L5ALP66N1ATlN7zbXAzKTKDH2OLZt0XV8VR8kYYWAIRzD3wPakmkugHz1bE7ecQppghzfNPUodMCo3KePXa2YuwQFLXlcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7101

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications(1) enables
EINJv2 by extending set_error_type_with_address struct.

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 369d92e410c1..c604aa875644 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -50,6 +50,28 @@
  */
 static int acpi5;
 
+struct syndrome_array {
+	union {
+		u32	acpi_id;
+		u32	device_id;
+		u32	pcie_sbdf;
+		u8	vendor_id[16];
+	} comp_id;
+	union {
+		u32	proc_synd;
+		u32	mem_synd;
+		u32	pcie_synd;
+		u8	vendor_synd[16];
+	} comp_synd;
+};
+
+struct einjv2_extension_struct {
+	u32 length;
+	u16 revision;
+	u16 component_arr_count;
+	struct syndrome_array component_arr[];
+};
+
 struct set_error_type_with_address {
 	u32	type;
 	u32	vendor_extension;
@@ -58,6 +80,7 @@ struct set_error_type_with_address {
 	u64	memory_address;
 	u64	memory_address_range;
 	u32	pcie_sbdf;
+	struct	einjv2_extension_struct einjv2_struct;
 };
 enum {
 	SETWA_FLAGS_APICID = 1,
-- 
2.34.1


