Return-Path: <linux-acpi+bounces-5774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A938C338C
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 21:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E0B2123E
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C020DF4;
	Sat, 11 May 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MNgjzpo2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2053.outbound.protection.outlook.com [40.92.42.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD120B04;
	Sat, 11 May 2024 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715456166; cv=fail; b=VbFF63+r0B3c72QbPkNAFiuhvi4QwlBl0m5w5RsMtZPUw3GuR9xC6hfC8g1OsG4CTvJ3gdVX0zLvAZTidnMufo5AdLH0G55uiE04X34hz1tBVsSa6ldxWpqq9BQv72QBo6U6H14YZh6gvz2ePheMI27SPNatGBe0IQBE+pchgCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715456166; c=relaxed/simple;
	bh=oi/JtqXrq4yZJOxNcygVxUeWyKjjGvrFdFGtQpW5Ojo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VW5Yj/JfVVxcsQBIbABTT2p43HKLC9o/3j0aJhF8hsStskS25OEToR+abDVqAxiRtbaLYqEvrXbh0/2A1GmySt6RTVvYKKZT1PotfYMU1iNHb0BwHQLWgLyymyWr7NBHjSmoni7svqNxJgPvVi+u7cF9W+5iM/RL25x9UEfprQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MNgjzpo2; arc=fail smtp.client-ip=40.92.42.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BchJ0LYROhrhiBjnHClnCT88/6aUIjHM7mCoA7lyE4J8HgL0xaOaANgokhDyS+vz+pMKLWDaCGzZS/86aQcXd3Ih8oVxb+7X4Dq7A/onRSVFK+le9Di/2p2gEniOLdFrqTgw3qRgmOHwc6sBKdkacA5pz2fqobG6/+2jqnV3O/j9HX7mnlDOo4ZkxvIgrtQrrzHCoqoKlEvkzpg6Mf6Gp+TiNPW8Ki2KniwsF0jbAzkGf3B6y1wmhRFDMbcmRrl2gNW0JGzwPzK+Bd2teM42nIbYJf2TBOJKc6YmGAXrlwwOeHdaAkkwWH6Z+GAvvLrkHIygcW1p/PvNg44xtCUbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTEHevXtBALILTvZFXdYnRGQwap0ECBwbib+9ZL11qs=;
 b=cFWfQhVakATiVNm4i8vbuBeLIbL7+QpF6XrYQb9P8HVS+T/9vkUYLpBQnygArbiEp6hmqlhUHYHYTzjV5TWpEhsnGomx+RAyn56a8aY2HJGmtpWvsyyVQci/vDqPZf6FrvJLjigNhsouycsy+KNQ2DOGskUWmzhUyXhL+DEmmBoRzpEH6aGF6qJIr6VFiEpRhjWBrRgnK40MxAFWx8hi6Ool9diRKy2N5aYodXE1uCvllWL8NZX6tuks4Rq8x7LDmw0QFa4z8nYRRG+LWGZmfVF44VhQBIMDnKT2tcHoLzsLZhjeuXffDLPwvXQNcqIxSDjCTK+B+zyj9/pctWfObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTEHevXtBALILTvZFXdYnRGQwap0ECBwbib+9ZL11qs=;
 b=MNgjzpo2DkV3G2A2zs+mYGG+c9DSBy5+mb4UM94GOrHuAYlAHaKPxcj3ejWRqatQ/6R3H2fp4OV78zLSpcgVfYeDpGa0ibA6aluYeUgyWTHvpmjTzQwv7ls4uuN+fTX3XBqkMtFefm2NRhx2iQR8Qaio9vZiJZys4eoCsFi7CD39k2hUOeq4ZeCqxVmT0bpzC9iu1xTbk1bZuxqEzwU+MZd5VL1qXV0s7107LHo6KUodfyIUfRjhfV2enWre+ae4aOZ0MLuoSpJARyN/219f51NHvh6A+jsus+JnEd4BqVavg5kPzAsA+5hqohzQVbfqwbx/OvUzMJMiIDqwSRh7lQ==
Received: from BYAPR03MB4168.namprd03.prod.outlook.com (2603:10b6:a03:78::23)
 by SA2PR03MB5817.namprd03.prod.outlook.com (2603:10b6:806:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 19:36:01 +0000
Received: from BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a]) by BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a%6]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 19:36:01 +0000
From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	lv.zheng@intel.com,
	rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>
Subject: [PATCH] ACPI: scan: Add missing check for kstrdup()
Date: Sat, 11 May 2024 19:35:53 +0000
Message-ID:
 <BYAPR03MB4168E7E5A2616EB82D3883E8ADE02@BYAPR03MB4168.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Jmn7bo0UqbPoR9JU8HOsHK2e9uh/CRwq]
X-ClientProxiedBy: CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::18) To BYAPR03MB4168.namprd03.prod.outlook.com
 (2603:10b6:a03:78::23)
X-Microsoft-Original-Message-ID:
 <20240511193553.47448-1-jiashengjiangcool@outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4168:EE_|SA2PR03MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1bceef-bb9d-4e15-a208-08dc71f196a9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3420499023|3430499023|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	dIMjw1Z28Vha15pwWKSP12uHYX7/ITtvZHXT6VRCDGslC+gSj6Rg7BYNSSqWOW4GztniQjUpGRjQAQdqdJ9wmV+mYU7E5gA7YXq3Iy/Y82quzOmIHNYi2PpZTuq/mwiPZXipADhPQL7YSUhRDw2MOJr7vpMBEYJ3WFz05xI+5niV28ZUjsEh1/maoTwjg/9PmxhNujfyx4qxoEujLiT0TlLspfio4OIDIVdzC2QfLhPjgJl8WQ5Av5w8xgDoYE261SuJDwEC5w6aD1SQbYonEZIdXbdGvi1z6LRki98OkG3PVRgbFvmsU1Ou7kHnI646KlJkvPtehyHHKTBpBHrOOMl3qemRBcMSPR19bhRE9STfg1g/z97gGK2ULPpMPQp80oT+TJ8NMGXeGODXWITNvjVdXdI7OYgsYPqOEn02DMooOmImcuVXp5kKg8oQW0szpi3jcPYPS6wH5pCME17HBid1sb/1KPjoDbHDqzzQLdNuvDDV6v1Vum3Tn6fEH7hvqxZA0I0yZsIXIsmCBPDyxPe5MNkxDY7hkjvbSU8u1kdz9MOsFyQtKe6N2ZpjnRYcMwbxfRdWjb38YO1zNRRQnjhmqqhEXRuFA15ENcZ0JzKcf8sWiKddxbup6eEbN8n4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wYzHVad8Ym3keRM4aTePZu1HWb7QLy8fPIfQsXHt7753mW/19mV/9xHcZtHQ?=
 =?us-ascii?Q?09y+3W5Mjd05F2eQ03HPqhtHC0iVKbBJziVGUWI7KnwDGv4tyhoNcOuHLpow?=
 =?us-ascii?Q?62uBDkxjYdOaoDDHmQ/VgEV9f8ie2N8XCkn15H9ulWtXCtGrQXKa8UtDE8yM?=
 =?us-ascii?Q?blOCu0SPmc9xpMsD+cdeUkG28rymV6rSy4IBxOucJ+4f/gdSyhqgE3X0XISs?=
 =?us-ascii?Q?MK+ybYd5YqPt51NPg+lo0ZbPL9StDe5UTz9u92ZcTMl7aWiOMkukFRA0y6mk?=
 =?us-ascii?Q?Pawpoyg2ra8jQPdtnhapeaw7JzOW5ixthRAHoG0OT7ime8hdKfHlsfu5Erae?=
 =?us-ascii?Q?o9lsyaGR2mMXPw9dyJ0HYbz5/sHOzZ3HCbVyqbFvQcQjw1OFQ1zgtlFinFiC?=
 =?us-ascii?Q?2PYQ9XQKAg1IjbDey6Cttz8LoZqhznyIIBw1JoURakURsVDPRbuo6EBwXhCy?=
 =?us-ascii?Q?AvbeqfF1LqEQYRaKMHshcVZKhFmB0K1b+gVA7h6UF7ndUqetU2I53gVh0VEs?=
 =?us-ascii?Q?5+lwn/EKBrM3G4XIiZiyypiZXgFRqzBtrOU3TZZzeY7MRNX0mTN5nAOQpA23?=
 =?us-ascii?Q?79yJc1Dj003OeipUzTFAvodV/E22ujPlXczG8Dea17NNAT1dcu29Pe1Lrez6?=
 =?us-ascii?Q?nUJpzAKY6EvuY1/Ic7kwjLl4y5Cw/o3FIoSi3q8xZ6XMOHdZ3IXzBVEx5tbA?=
 =?us-ascii?Q?xq1tRkTFA7Ve67tOhW4MY6M6azQ3vt76lFlDGt/m0NSy0yrCi5uolLjPhnA4?=
 =?us-ascii?Q?s1exIoqwBMz9kGEq5evE8bc8/eGptQ8Ov9E+/IN8Cpff9MEqVqftFX75Z9xi?=
 =?us-ascii?Q?/+PaxndlX59hrqh9yddDvSEAPSJw/NpXL2tCqg91CWkm4xT4ZD8t2Mlcj3tG?=
 =?us-ascii?Q?QyeQLkrnNTxo6b0j31kBvbuIkmEKa1E7+2hhzRtbWSG5oRV2vi2D8GLD1P9J?=
 =?us-ascii?Q?yL831ssI4MjgGjLfkAEl3Dy1yDPCICKIFIAfDViYFuGvLCZrb1E1tY1SdJUK?=
 =?us-ascii?Q?KkM8S28e/up8yv096thqGfH6PfM6pN0te/twnI/wd32Ryb/NgBkKsJ8+hOoj?=
 =?us-ascii?Q?mI1hsXbwdhHqvbqWjtTeoTKFZXM1Uy/tD+9FuecheJlWvsAg3pzOLFyTCldL?=
 =?us-ascii?Q?xKfJ3Cdkn0uilpaSbixc6+pFhIIGlR1zAUPXD65Im59CuKBFpDjX2UBGN6gp?=
 =?us-ascii?Q?GXqo4I4an0cmZFalM2LHYNuHCBR9IsBQBK5MlOkZrQjeiozoPsTUdFNLhqGU?=
 =?us-ascii?Q?y34Rl1SqIBnvInNsLX/X?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1bceef-bb9d-4e15-a208-08dc71f196a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 19:36:00.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5817

Add check for the return value of kstrdup() in order to gurantee
the success of allocation.
Moreover, move the code forward to simplify the error handling.

Fixes: ccf78040265b ("ACPI: Add _UID support for ACPI devices.")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
---
 drivers/acpi/scan.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d1464324de95..59246757a207 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1385,6 +1385,15 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 			return;
 		}
 
+		if (info->valid & ACPI_VALID_UID) {
+			pnp->unique_id = kstrdup(info->unique_id.string,
+							GFP_KERNEL);
+			if (!pnp->unique_id) {
+				kfree(info);
+				return;
+			}
+		}
+
 		if (info->valid & ACPI_VALID_HID) {
 			acpi_add_id(pnp, info->hardware_id.string);
 			pnp->type.platform_id = 1;
@@ -1398,9 +1407,6 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 			pnp->bus_address = info->address;
 			pnp->type.bus_address = 1;
 		}
-		if (info->valid & ACPI_VALID_UID)
-			pnp->unique_id = kstrdup(info->unique_id.string,
-							GFP_KERNEL);
 		if (info->valid & ACPI_VALID_CLS)
 			acpi_add_id(pnp, info->class_code.string);
 
-- 
2.25.1


