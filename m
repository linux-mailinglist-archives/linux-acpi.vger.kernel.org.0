Return-Path: <linux-acpi+bounces-14425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC226ADDC58
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EDA4A066C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795A2F2715;
	Tue, 17 Jun 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RsQ9xocW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01012EF647;
	Tue, 17 Jun 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188657; cv=fail; b=fUMel7l+fUG3qA6p1VIeDgXiXRxCTE9IDA2hI+ROCEa06IK6J00g3gjOCDMegOtmXEJym2KvNqIa5+g/3I9ltCqWiceH+e6PT2fIORY1bhy2MczGT8kU/mjh8ws4p6OpQrRA8jcpCEBp/aKgwJlHMmwQdaV0HVHtHUIe3PcPNio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188657; c=relaxed/simple;
	bh=2ad3rtYF0r+FF1FZ+U4gMXrKbcnFn85cJWSicsBUbEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q73l/xgEqDpyrdUQ6evPxaX0g/YMzzo8IW/GUItOC9/9TzEcz/+/LWUm8eXUQOqT7HAotjTGZkJPI20DMtOAoFGNH4HJuaFYXBRK1fiBVRg/e8+7yNJmkQudw/XZaVvQuy5kG7r7yTyyRZxhQyrOJW4uHWhfW77cWaO3yl+Q/Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RsQ9xocW; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wolJ1aABJ+yslkTCnlmLSKTO76eor18zskDo53f6uq/txhvwQguQ3lw0LPbcuvWLfvmmFnUIMUJRNQpgITPc2LBGN/D2ZfZCFIaL+hDrxDjIqfg3IL3xZorM0xPYfhgUab84ZkTZ5ccguH6hyeaMgh1b48nf1tHqjJ6jmM5J5/swZyZ5K3CvTTpqnG4hgY8sz/NTE+QEuV8MICndfvsBRP9yQauENMgJsfwZUt1U42IefDkOguhGSQ6W6RjP4P0nwBxktXh+VkXwJhr2wL8Fx/H6hTb/9KlqY/b597UgRt1c5DTE4a80vYm4TXIp4AyCeAyV5ugSrsjPryh/uI4VDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvaJ9Nu7p1jh2lTgyznJoC7BexqRkwttw4Ye4eXk4g4=;
 b=naqdjxlW4EIaLyaddtijEIbemm1if+o9kzKe6OJIZhx+vTLJ8yPFmA3P6aBbL/Umf9Ki0ubDPMdrfz9Xauxf8ia5zBmeMyj2doIUakwfM5t4myO3WUfVY0rcNyhQnm6qCKKiOKqPL6hb9Ju7juXs19im5JSGgqE5mcCYEwq5SvoFlQqkgn3lO/6JwYzZU+NXSqHPWnDfjAgP0o2CXo3iS18dK5fgSAfRkze+ZOs6VKrLG6/VCFJuzgCJsNpm6U9divhn2QDpH3r0tOkA0xJQW6x8jvdL+sX7pgPknrKcq3nqKdxTM0KPpVv1pwWwy0GCxNkVAl5QAPz1BqE+yEW+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvaJ9Nu7p1jh2lTgyznJoC7BexqRkwttw4Ye4eXk4g4=;
 b=RsQ9xocWNgRNY2vacpxD3BHPpiW0ZMNIAJBo9VmLqYzHr2RVfUc7Ubgiw9PwdkmiB8VZuMcvW4X+bbbn6gf5aZNTHIreNHxBbQkyE/PT01OMpD9QZzrljakj8WZD/I9tbK/1NW62iI8Kg7cx+ictWGJOPKudVrpTHTenKVZ+SSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:53 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:53 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	ira.weiny@intel.com,
	Jonathan.Cameron@huawei.com,
	viro@zeniv.linux.org.uk,
	sudeep.holla@arm.com,
	dan.carpenter@linaro.org,
	jonathanh@nvidia.com,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	benjamin.cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v10 6/7] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Tue, 17 Jun 2025 12:30:25 -0700
Message-ID: <20250617193026.637510-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
References: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS2PR01MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bfac72-fb12-421d-7365-08ddadd57952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9RGozveik48e8YsfJXSOuPFQ+GbR8xGVg0F3auM/t3lcgE55Z+VV2XGFQcG?=
 =?us-ascii?Q?kmfCUgmLnqq49S48KOviJcrDdNFQfJjduMiIemjYE6q2phlKnUHhZJtGc/c8?=
 =?us-ascii?Q?mkdE9J2Zr4yn9i/AKE9VQ7T2rKW8yqK7La5eN5zc2GjMPnzcIhgC/2qG8mWf?=
 =?us-ascii?Q?lpof/6dfRKaZsmQTX7c51wDNQJIO4SUbXUY9HtnLuY5t2XfCf9KGFaymDyiy?=
 =?us-ascii?Q?IuGosXIduZE/QgCV2DZ6YZddCtYLdcDq490L1XdO56oV5wAynGtYBAsBDaM1?=
 =?us-ascii?Q?kQ8b3luF67ic6WH9UqqWhh7ZsebaVqmqflQcgS855c5Zd2JhqTjNmMGAsBnK?=
 =?us-ascii?Q?8Fy709UPLi4tTAhaloc28EZmIGrKy/HXBVVOKVkwU+8Z/HlBPvjDB0KQA9ij?=
 =?us-ascii?Q?tLBvM2juDIndBGRA3Vx7HxRno+i9XM2WFcau3J+G82VmOAFJCdlJkcWunCIE?=
 =?us-ascii?Q?6spJKhcncu3kCwjfTRlNPvzRs/Xsrh8gg5kBAmpm9rahbqlhwzlWO8kkPVIC?=
 =?us-ascii?Q?b4154J1hAS5jGG4ASG4VdLPKQ/R+b0pSRRXooWMIN9cqDjJSSH61suLQYf43?=
 =?us-ascii?Q?mPQ5V8ozSmHuQO5Q6YsmYxhnIWSzf0JbsT3Gq6bjZ2Pb06t+z4asd9CZ7NWw?=
 =?us-ascii?Q?qxhmKR7/0/hMR7GNiM9/bv46D90Ryqi4kH0+Rc8CdO9SMkNyFxGr0gpNm/Dl?=
 =?us-ascii?Q?QlrE4sYsmI8OMF2UM4Qsn4G7TmiRMIS7yoEV7S4xNqSaTTXbOPHc1/00IHdw?=
 =?us-ascii?Q?NCTz7ZTUt+1FZaYWgdZfHvNoCn+R6mDTjEaOrnxOxplAXd1oo57Cwwak/2AW?=
 =?us-ascii?Q?26L0s2wv/uFJcmjI2PpA3SvN68IBqacbG7GBYR8rF2Z2NKZ00rJiE9OqAOc3?=
 =?us-ascii?Q?Ad26Q4yfHOcqEQgEmXDXg3edp88QCXs+z9j4IImtChXnllIY5V3H3hcFA11S?=
 =?us-ascii?Q?lm7byNxXwTBtPKILTvnQ9+Eg4E1Wsa0fGQMkviDxL0oMpNNCR2sjfdWYt2sN?=
 =?us-ascii?Q?OvjrnIhIuXIgS0pljkVxgpsAKPrqjpAyezhySV5C9NGRNw+ZaBO2LTZXnnx2?=
 =?us-ascii?Q?kJtZE/6o06O/V25ascgEnHhz7OCV0ZBer0Jyl25TK1YbfZ8JkrMNfx1ppOts?=
 =?us-ascii?Q?44lnbuhYHJxLs4HigmDkVo6sO0gRTQgCg9rYtyy8pniYu2hDocTmYmyPWsYK?=
 =?us-ascii?Q?zbQXW3G5EEikG875XubNH8xnaxlmmZv2l9zVXyr3YidJL48KLTIi8GXv8C+R?=
 =?us-ascii?Q?/psPM7vL+QjIqYkk58beeH2tk/8ZLAMKKAdPiQJL2D+6PdUzxHDbuP0Z9FNi?=
 =?us-ascii?Q?vdxJHOvtEoxXGN5kbUOggS+7DoH4jp42SLFezlvqH/u8hr2jb7u/LFm3xF7Z?=
 =?us-ascii?Q?YDO3QT+me5e0evM8fc+WeD5LU1w6nBxZ9A+HeAiDVIMm8RpP/td4lD3zp62x?=
 =?us-ascii?Q?ZPA7Bf8XEJzAWhNFU0L+30nZSu8AgNSNbnbt3ttp00uVfKjU74/MGYburfNv?=
 =?us-ascii?Q?yWVU6mg38ZVWBRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q9JGivdt3oOEWIK9eoX6Q+2pzXTATqmrkt2a0fv2Rrj47G2XmyImAWo6ggaQ?=
 =?us-ascii?Q?rolj/MM8sTtaKYk2nn2hKLw8HdG3s5gIKGiFc34wAaEvtfEGR9I5K8LQkuPr?=
 =?us-ascii?Q?wF5kyQ/fFBE75wbNg9n+iurXkoUkV2l/XlMZyZ7MokxLkKAJtGwOpcPx2jz3?=
 =?us-ascii?Q?vxXf6og4CzoBLWVjhC1TZ1FYCR8zrhY3BhqV3gRiyW+eWD8MKlRQhg1O60NP?=
 =?us-ascii?Q?gBtfOh3xSEOlCsKGbxRmMvMx6bSWPyKHAlOkHxtGvGY2PVcwo9XIDf1hY0sr?=
 =?us-ascii?Q?bg52kYmaBRZo7u2BM3/GJ2BfBPsPMuB9SHsOq+2IJVahSObB/2qw5dJrii3g?=
 =?us-ascii?Q?y4eNF3o956YlrBuw+d2ue5KvuNXD/JWbSkuyFJX2oIvECN3/ls+Jo7ca81W9?=
 =?us-ascii?Q?lCCgXcnRMQ0jRPdHslUclXUffptKlKzKFRc7vNG/I9+HtK5qCAQrXd2wl+m8?=
 =?us-ascii?Q?ICNl4YOaLK9L5EMn58G1uVeuCOTpXxSIstEFgf80lsmKlJwqS1yf2oBFDJVb?=
 =?us-ascii?Q?CTrTsscPLywRlQF0BZC76TzTY78EYe4GWqb7oUkFlGmv3cjwulIBzitzFALq?=
 =?us-ascii?Q?BkGjw+t/xTtLcgB3gf8b6/XhXATTO+NPWPIQXQ3poIq5vnRAPyEBw6hQxWLY?=
 =?us-ascii?Q?iUpLTaowfmsEHKQLbQ0R/rC1O4bK3JLKJr0kWrjkZojKPx0qMaZF+OTauD4q?=
 =?us-ascii?Q?1HwXwr5irHWeF26VFWgWDti5v4FDYSarZV/q3OY6mpq6pKj4FJH3enIOtqPX?=
 =?us-ascii?Q?Br/0OCAxi3Idcwb0kGRrGD0L2r1zF66ep/Akg1ebVXL/zeZYQbPvht/iGWBz?=
 =?us-ascii?Q?MIigr9mh6dn3vXQVDA2PFIRjFj7z3JmWJsjs/NmwTlQ6vaLu/Yvjozu319dt?=
 =?us-ascii?Q?gbG3hNKaDkQiLmTeOyd49Cp5pM0j5Z/k0cpX43fNAADgna81LIhUFPX44BHr?=
 =?us-ascii?Q?vFd42Dz+GwZ9L0XExHquygj44ZhgPqXlfxvg+MM99lt9X7JZ2FzLUSKoH4mW?=
 =?us-ascii?Q?TT+K7DnDEgscAtriVxXbvC0ufl4RABo1rfBoEyKm4k0mLdQwPRBnMhVNIBV0?=
 =?us-ascii?Q?awO07cfj9K8/8el6JzbWgkSFwpoQHwDc84WItfOpcbdaRZ8+ggcTqqAKRGdS?=
 =?us-ascii?Q?1x5734+2rzPuxMexrXavZu27Q5+vnJr/pk/GOoEg8qCEpB2sSmFaZCk1Wgwr?=
 =?us-ascii?Q?KfSr9lV7Gfbc2JQGyxNXHmdxdV6hE02a5AqWlhvmmxBCLknO8p5lEqN6gOlI?=
 =?us-ascii?Q?8DnRNoOoicrHlt1Ea+s6/+X9KhHqdGK6eNp144CKH4yjX192DWrMxA1Ml09B?=
 =?us-ascii?Q?Ne0Q7YlI4VOVJrilbWxCg/cUGIOLCVxSvfJ3Ut1jgi/McgWBIS0sbNB6NFjx?=
 =?us-ascii?Q?Ipvl9b2sFo7GucP7yYA/efUCGYDxBTo3GtgnZ584V6E85b3EpkL+3W3XNj7i?=
 =?us-ascii?Q?KDsHONBkCna13dd+6k3kqsH3KcDcD9FcJAEaOuDJdWZRi1L82n1YuBKONYJ0?=
 =?us-ascii?Q?eVJ/BMT6p6W5QnLa/h+HhR1gm+rr4b20WGRFmGKMABSR4KGwr4xf6PKMjrH5?=
 =?us-ascii?Q?nDvw3g6cWmuzPL4IjnFKy3hkRYOnLLM+z7WUN68125FCaS399n4juhG6JqUV?=
 =?us-ascii?Q?51Dn3sWqZq6Hn9aYUM95zyY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bfac72-fb12-421d-7365-08ddadd57952
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:53.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9Rq8V1BT1hvuJaoeaONr1vW/HE8DmByQEP0HKMM8gEMUyGJrVmReWPXtQ+OpPuNdVo/A/u8Dl+uEu+O8HVSFWqLmXaqHPFMVfk53ZRrAGsolgxPkQe+oAAG0h+jaHDY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

Enable injection using EINJv2 mode of operation.

[Tony: Mostly Zaid's original code. I just changed how the error ID
and syndrome bits are implemented. Also swapped out some camelcase
variable names]

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 58 ++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 87f1b8718387..d6d7e36e3647 100644
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
@@ -828,6 +859,11 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_v2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+	else
+		error_flags &= ~SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
-- 
2.43.0


