Return-Path: <linux-acpi+bounces-8912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F29AB8B6
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FE91F2432D
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9EF1CF281;
	Tue, 22 Oct 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HV+DKD2h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F71CDFC6;
	Tue, 22 Oct 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632888; cv=fail; b=D335iLPVHLETVRLtlXmHBKel/l1zq/hSyd7I19s8FIOXpMx1UXHU2DTrN89W1uPTCE73gxD1FoGF0F3eUYNEgJOPEE9wTJ206KNKr6xEAN9wDQiEb+oRZ5d0xtO0DNxjVNfcnFbWO0ra8YbKV3NS7yjfkA2GHI7WJ10dOxOxNI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632888; c=relaxed/simple;
	bh=nscLSxZrHlX6/Ql5pEchg3Uhvc4a3LRGrb8W0x3KwTI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3aTgqCQSJMyYlKa4ADh/cOhCUkEc9OSvhztXJWWz8ijw1O0ZpvI3XgpdVnKIgtHvCrfDXqNEQMLFn3YR9bIbVz6lEEYQN49MruNErqo56sTFX4z7wjjC4vtYNYz4pCnoXQmITyDGL9gGaq+uFidUQ/DxiAdQ4dNMk/sDqMXN1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HV+DKD2h; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nE1f4tISi8W6dZ8FyCt5Pe00ljtv3cu7uTkfwx86c9yTnHvbRQDXFdWctYvSSPBy9YT2Dxddl4Z7JRLw2SviZqjJHPpC4Et+Wrqi4HSpnCaHixiHAyPcqPrfo0097+V5/nUnW2bqEckLIJTVNGTz3DF+VXmZZbjcPk87L6rFL0e9XEDr9iKRUNMIFMD3DUPi0Fo4kZl/hY1831JB9IS8QcDV1IaGuFjEI0Ixj4Mc7JzT0VNG/Fhlxp70xPoKgjiaOWb4ugh1sGv5S1AioHvESZtcAWmaC1nZ5qW4Ci/dwr8pOsKUnu9NFcDhEzh+N97R5a5ancGuD61ULbb8BNrAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUKHikz4xNHj1OCwUUwCaPbdlF9FmPccUjEAqlP2Hsg=;
 b=GH4oqjQhDR/eF63DSP63+0nInuYq5NAk8wlaLMkhtvTOuGIspiUYxN0woFkMbgHQgpU8i4ByPHFoLvjOoDOIdv5CbVcilOfVSldW14hEQ2StiQr3lWqgeQp1eKaze7KWVp3o/eZPbAfkb48ee4wj2MBieabbtEbi6B0yQDJ1SMssTzR8qduAhxtpkNgPCA1vwBTnx6hnF0sggM5IyBStWNu5uAIbIc2dLNAoKoc5otBxDbNX03xvkNGWuT/JW5vf9t6XvVZFSa/dj7snnYXm2AfJDoZLEXcaQPqd6lWMDLlBhT1OSCSmcuReB7kT5QCzY58Ck1IbM1q1Ci4NkAzXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUKHikz4xNHj1OCwUUwCaPbdlF9FmPccUjEAqlP2Hsg=;
 b=HV+DKD2hjFZITtirpE7SO7PVdHBBMn7C725h4q3RKzls1hm6DnwIGEwBYYXvkuWrHnArwk58i8DHkEsYfyH1zgiUpuC+foYLU2pE0TteJDEXGLpKYah3oowmOpgYDCLdJKHBghv0dMkqWbiqE3gSNYUqENk7LFIxqFv9PoCdY48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:43 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:43 +0000
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
Subject: [PATCH 2/8] ACPICA: Add EINJv2 get error type action
Date: Tue, 22 Oct 2024 14:34:23 -0700
Message-Id: <20241022213429.1561784-3-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS1PR01MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a7b9fb-c52a-4d8d-66fe-08dcf2e1578f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kgmyYlrzo0F7eEcxYgqsjpMo6iaTwWAGR44U4r1z5fUaRo9DTUJ+f3ovWc/l?=
 =?us-ascii?Q?q9WJ7fHUd2VWyGMaq8lQKVXyc020SUze8Pya03bsGx4SVI4af+Hi2gAMggxa?=
 =?us-ascii?Q?4VTIGsGe+bVt8gag2B19tveAerhq4sBRXboMZhQfuJCdjg+g4WJcFcYIdrE9?=
 =?us-ascii?Q?QsQFMWyoEdP62uTIYDqz2AoiCs+1zL1yfkFvRLt6ZrIpdWD1nX1uNAYqAW2s?=
 =?us-ascii?Q?HmRvp7J3+hoqdDNf199rt/WFp42s8puiWdYDziUsGnTUtsghD6xen/nrgYQf?=
 =?us-ascii?Q?gVAlNJ2gkgJOs6rAIe9xBdgoJkpwSdD7XS+SrDftnRzmkW1+NiP9PzaQCbuG?=
 =?us-ascii?Q?cVk2qACE8/Ijc4TrgXIzBWue4W1+Y0sWzNUBC16HwA+j1q5UFWIozDsdUJEs?=
 =?us-ascii?Q?DrVi61Jm2Y89wmpLlj6IeplCh6uFZ2lI2+Nq7NYM/MWO1vCsCvBOGQ09nB+j?=
 =?us-ascii?Q?UuKZI1V/sip0J61jER/sO9YRK1iwItRziUtZdXhT4vhlJ9HE6OHqIfTU6EZY?=
 =?us-ascii?Q?A0EVAL8I73z8itiZ8vierWlKB9xxP8cxt80f9sRewg46APTg3sgOIwfNImJ9?=
 =?us-ascii?Q?PRPtpJXzPHjlI1gs82V8wsarbZOw2DE7sojxqVMlnB5xVZ0tuGHK2K6xVqFN?=
 =?us-ascii?Q?vvIKAPtQZyDKnlMyvtvVq6Uc3pTaW4sVrSlIwoFN6vgIRVdM0ygpS/CoQrAg?=
 =?us-ascii?Q?/j4izxfQCdlNgDlI+kW4gK2puJV4pvVadoGRGtFoRFzWjspwBRc/b2nm8Lug?=
 =?us-ascii?Q?QxaEstz8/gZHNYeauybjDr9iYoadr3ZJsY5uLv7y4ntPZwIcGJQb3gONN9/y?=
 =?us-ascii?Q?5gwcw++7EnCM1h4kLCIPm7L/0lBouv1d7Nez1srW6Yy0SGtBYeKgZOCdqQSF?=
 =?us-ascii?Q?VPln4AlWsZ6UpUHVi34dQfemypFepD4XtwUaZ/T7BqZvDV/KdINIe4RugEnC?=
 =?us-ascii?Q?HNkGoJP/9RNEmMWHcgosPxonPDEk7XzRqJG65pQ5odiMu1eWx0/haWsBQ6l/?=
 =?us-ascii?Q?Jxi4VnJ0nkC0KBtcs4kpO7bppcH0ddr/fza1j8LrvGGjzws2zoEOW/iCxkFj?=
 =?us-ascii?Q?1QKG3c5yZPI8MjsOELGLxTgLUGxRfcGPPvOilJAhtpuJa3NzJLdxXd1VFbxK?=
 =?us-ascii?Q?wqNAIqksvRxMAl5I+VNjBdB88DTylR2sk5eMN0oy+cYBduusfLe31ti5lbRV?=
 =?us-ascii?Q?qTwcNpMNKdd+eixWh4srHQu4YHYa+mzVJ0HE5QFKP6Ih99VyI88uxGz0DDpz?=
 =?us-ascii?Q?ZgifFFSNakFYHTGaJT1OYjftKv3ewnvpaFXzf3hX+fJbo9xVZHWNcEkoQCO6?=
 =?us-ascii?Q?Ywk3MFcmjVf/HvKkun13/AN3op1wEpXPHIn+voUQNLN+cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AaZGVuY2yPHOhqVEi/q60b7WMmDT06uzrg9sefjHidwGScwA77n9dREU8nJU?=
 =?us-ascii?Q?k6lSlVhacGk0NBHELfWkzXHDTBNZ1MhdyP8sa879l7HWCdju1r4Bb5Ct0DBp?=
 =?us-ascii?Q?r8Ntmp53PBTot0F2mBZH3OBZRveQzMYU1+TmUN1oCaNF39ftlLpyXrcfKOzX?=
 =?us-ascii?Q?L6nfsMBdEZNMSF3NNCu/JEIqMbTap79pfzNC17n/kQo7LYTb8o33uP5flcFz?=
 =?us-ascii?Q?NHxET2ub+pp1zowyCWLYsC36DPrSFUHLOOYi8DDufyVRh5C+jL3gv6BwqLPJ?=
 =?us-ascii?Q?U0KKjqPTSbEa1j7FqvQT4kDLdjnD4yXRZ/dqzriuugeOhrayXcDuHSp/RcE3?=
 =?us-ascii?Q?0anWvZuNLseMqSaxqHwv3HiwMl/hnDAzrC2DENdMIZTcmuSK/AGDJbnDNsOD?=
 =?us-ascii?Q?yaKguw3wxrzWcV1ogNNbLbP2oig8BbnJJsAJx3UB5H7TI6stWwSdEWqtxmr4?=
 =?us-ascii?Q?13YAD7TO5WNqSsVedT+shvMXemkykMhrmtHlMubQFXz3y5eWwwz5zkhaDYoT?=
 =?us-ascii?Q?CjfthU8nlBLr+zKl1I4PrkKKrS2F5mhkLx5Y7dE38QEOSNh0+R6oj2Se3AAy?=
 =?us-ascii?Q?Sbi8D+6ijQ5VI/3soOI76h3WrwFLBY0UYFrJuKaAtBK+KdZ0W922DeauZcQm?=
 =?us-ascii?Q?MxeHxi9NWipJIR4+QQp77BFz9vG1x17tZXMGz/fXvggwDEx8M1b/Hrs4ZspO?=
 =?us-ascii?Q?7zL8V2rjcycDZK3rmbx0GuL6nBDtV2vqOm40sh7D1xxMXw6JCIaH379Suz/L?=
 =?us-ascii?Q?Z0zTBPA1GUY87MpEcc+2+mfHWPihwx/JOVdgj74+2WKJrtiEairhEu/3rv+g?=
 =?us-ascii?Q?nERbQAAvorH7Cs6E1ZqcM8IVd5Zv2pJu+igr37wit/swY3ev4rWRuWX6yT7V?=
 =?us-ascii?Q?dCxMoaZaud4ufTsyupO9gSvZN5mqgiHLpCIAN5v7iafr9cAmNNdjUXx2ju8t?=
 =?us-ascii?Q?U5W3rHDta77yHbXvz69UJESLs9TIr+e0TmxqLWTqBvvqWa1HPpCJk2NL6FHg?=
 =?us-ascii?Q?jSGt5UbhFTmYUXxmCmgc4YDDw9hy6px1xLHEX9/eCvZVqmsMR4nHVZi1nnuH?=
 =?us-ascii?Q?OSmVrbup2pr4xhCa6gDFQmKDU318aUfmdosSm9LA7XA5nGLnTnSl78WlcClW?=
 =?us-ascii?Q?nazvn8+UUIqjRgHh4UN2BHhGajTSgS7SBXeN88/i5XsrUzF5WlDmZf9AMm9w?=
 =?us-ascii?Q?z48Bhp+KD2xzooS4R9Y/9Kvr4TVX68UstMhSS695hO6ACLSXZj3Q7qB4IYrB?=
 =?us-ascii?Q?FXV4r2/wS6102rafYCRXt6+3XBqGVi38NHhyL+Il6OhqrDk3DpRtvDPwkWCz?=
 =?us-ascii?Q?6UX7sH747rNsJqBukSAYrie+WV58ORgtHs1i39atN9qbEImZK/2x+JNMcMNr?=
 =?us-ascii?Q?zq94k7PniR3uvGPNdEywteB4sNQ6nlGPIBe6Nb4n8ef4z0y8iHhKIqpokWSZ?=
 =?us-ascii?Q?7UeMRPkIZx3OlTuPYu2H4tR13ndHWvOop5cTNsXW+rGM4uq7YHHuwEfglRte?=
 =?us-ascii?Q?p3hhypx2WmXRyn7iwMVADGL2Ov/LrXtrVv4KI0MbWO9VuiBdq3TXzmu1TknL?=
 =?us-ascii?Q?Lq9oeHvBuW3RN9lknLy4AvdyozTUcJ6Tp5vrNsVJQUzXDmEoH6JabjreDcOl?=
 =?us-ascii?Q?6vhOlEA2RSnhhdtblbOu7RY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a7b9fb-c52a-4d8d-66fe-08dcf2e1578f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:43.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxzockKxtoC1lymli5IgstzBYSiBpLYIpKcfKYcxgfvvxOSnXz4WVWd61RXs815CUjTCTjVMEvidb1MkvuH3dogdA7hsQmODoV/bnBuhD2Mb4YlFh1nUGEwGzVho8Ncj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
specs(1)(2).

Proposed ACPI spces for EINJv2:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521

This commit is not a direct merge, it will come from ACPICA
project, see pull request(3).

(3) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index ba177b79a2b8..66a71b6619ff 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1032,7 +1032,8 @@ enum acpi_einj_actions {
 	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
-	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJV2_GET_ERROR_TYPE =		0x11,
+	ACPI_EINJ_ACTION_RESERVED =		0x12,	/* 0x12 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
-- 
2.34.1


