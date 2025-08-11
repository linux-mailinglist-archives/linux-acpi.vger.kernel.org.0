Return-Path: <linux-acpi+bounces-15587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9CB208AD
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 14:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013113B5E1F
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF8123C518;
	Mon, 11 Aug 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wr3qHhfd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013002.outbound.protection.outlook.com [52.101.127.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35AC3C17;
	Mon, 11 Aug 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914973; cv=fail; b=beKI4e0QZw/EgqKxo3KOUz7cW/2NQ6ibEc8+Oh38IfMSgkFyPDv0gfEYvruI57ZhfOw9R3DjIvngG++BxwIMJpK/PhceeduyHVrFFj/OzVgphfAur2UmOw8OyFT5rEI64wdHnD2FZplYkHtlnG4a14KtfeJJOsoVvIIwvMQq+Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914973; c=relaxed/simple;
	bh=kX1mxjIeLSW8i8OUBFKTR5K4EeGQ32zHDxjXTsd7l0E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BKuR0qjfEfoGPvZA7fFMNkV4Eyp6YkMWSM4FR1njZQ64K0yW4waxmP9PhWovLvowDIpRYPpzgWY8cZI8kt8nTfz9lFxWUu/wka0VpE/cbDosA0dIqWDoSE6i1pAyrhDTXtNisBlGCiB4X5CHIYPj1XkG4HjwVLWUBidjEUPQn/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wr3qHhfd; arc=fail smtp.client-ip=52.101.127.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2Gn7rYW7P2IIzz6QY/Mmt5/uhBKPcBBiRPa9CjkstYirFhZnNJ55Vjtr8knbRfRcfpVm4pxI2aDWwUihtrJWv+T/CpjedGFJP2aBF7mppZWXSJVTlSLjfKMe7kDYe6U6/rgz+ADEAl6iiDJPW+3RNG6JxDxh4wk0Mlln6yz94GWzOHIll6VuHT9iCB9oNSZqoZvVX1IC2s03kThB480tp+UBqBSuxPAIXWIAJuXU0isxruPL+8ZoYPqMgG8jctm+NeBIqAH3SUunrU4JhBkjcbL775T8Xl87t4kUOR8q9QDzIrM4iqrGd3/6M3CuMNPBCvpcLjgV/KyIpB/yDNz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuapaoUvG8iVFOVKXsYisWQtKWhvok7LOdC/PRndDB8=;
 b=Vt+JDV4swbgz0YFCUfqgwKMmhSefDkZaTwaq06lw9A7aJLluBBjqWbOsNNTk6Ia8ul5BkPndwF7a4gZIs7RKLFPcYHYK0myv4TAs6AioQek1prH2d2fJvcJSayHaqmjGQylzd6OEfCcrcGctIualkexybfTLDTtuUAtzt4gxdVznU/EEDC1N/fnqUtB0DnoLFmRgWAFVl2TrtoqkgHuD/gfYwK5kwInCXv3HgYyJN9oRizM//+iEsdOXqDQSGaLDB747r6fXSMywR91x/Grp5+XED9dxm9+GYGj4WlvfClam6/YV8FX61M8LbFGK10g6h6FTxDvhhPTG00TTtEne1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuapaoUvG8iVFOVKXsYisWQtKWhvok7LOdC/PRndDB8=;
 b=Wr3qHhfdcTH4ngS14PGOZm4oEbkWT30xsxWG+DHIIT/SCmnKYLvtix8DfJjwa4V7eI3hUf3KOEsUD/kqmPWo8reMrROngacqrTpDBQUVkPkbyd1zDsP54fmam7bY20VTy6hAgQ6FXvSp1nOmHOKFyW3twW8NUOfSO9/db/69pKJSM/Rt/YHOCSSRqecVRGamVHTBu0JZwEghosmpnXV5puB0uRliLzGD5ExOLTR7Ht2J5OFqRClJANUICDr/s5WPVzYPf84/30K/gW9fODrXxYp10gHYrwke25dc+5I3kp2vBdTlnXl7zJnE1LI5StkE2MtXVFvcB0GiRI4gyPxA/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB7172.apcprd06.prod.outlook.com (2603:1096:405:b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 12:22:49 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:22:49 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: rafael@kernel.org,
	robert.moore@intel.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] ACPICA: Use str_plural() to simplify the code
Date: Mon, 11 Aug 2025 20:22:40 +0800
Message-Id: <20250811122240.541469-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 8050b602-e0b9-421b-fbdb-08ddd8d1c901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6KdsgEZHPvbdDaOoWjU4bWj4Jo4MbJw5WCV/6Z61W47TTkl1yKdDXQBLbKfp?=
 =?us-ascii?Q?46/tNOm4g9nsLBiJ9U0u0Sd9EIUrdyWCp4yitAsFgxtOSDZKrQ1AOQEFUSy1?=
 =?us-ascii?Q?jCa7eXZyOAefXtTYPwUlRI02Bd6Y4BiCtHzTOFh/MBWqRBUL2QoOEd9oSonp?=
 =?us-ascii?Q?OmQNhsn/8ccnBtOGXIKs//IPQ89JouyZmtTcxuklogbuQibF0AHyWvECHxCg?=
 =?us-ascii?Q?V/jUtVzQb260vjcjKJsqJqyXuZQgNcIYHS/VeF7q7XS9aalYThn1sg5b7bMN?=
 =?us-ascii?Q?zYuWELphU8791sLLLNdQetY/c5iPvwCIrebmtYoUOHCnotqnd9q6BFvqmSU+?=
 =?us-ascii?Q?y2eSjpFhyWoGnSPw38g63XGoVRJ2T3BRvy8oKQCEKmseA8CIkAJmN7DXA46t?=
 =?us-ascii?Q?7AcH0yuikbA43o7/Sd2FJFRzKdDRheSvLxLzIRoEyFMokfKSNr8nKpOh+XCv?=
 =?us-ascii?Q?8Jh90OVg1k4LnUPoORvPtsl1Ki6ZOG2a0hAX9m83J8w2MzoRbVvXIyjuUh5R?=
 =?us-ascii?Q?CZ61iGdwOdTkg0WOMe8CEi/2TRocFEfoaFW9o6AxWGjiI5bdBO4rnrDgoujw?=
 =?us-ascii?Q?j4wuprsRkjcTK4hX64w6EzXEILEbeBeHRmi5FWSS/3Y9JCkAGtC4tD/VXJUm?=
 =?us-ascii?Q?HGr51eAJsMmvv+honDXmzyLXVGVnRUyCCJ4r3vhfDZNu7ZXhKF0Pd/3pWs14?=
 =?us-ascii?Q?YGJeMo86Z++7gUBFEVUmF9luw+sXBs4uM0vMS3dtvBGKwUP2R+MS42V+jWNm?=
 =?us-ascii?Q?p4lVfyIDzUwMuBDf5vjExyT7fZuxiO1iHVgEf9AlIWm8elfmxVRQ2P/1R1wj?=
 =?us-ascii?Q?Squ/xc0YHOF8wCaC/IKDgP8PEr/swt04lfPkfNmO0BVV2QJ/cn7kwVLI/BLs?=
 =?us-ascii?Q?5O3kmyIzuf/MtNkIMqmwHXRaJJrGT/Azzofzg+LmC2scjwAauJYsNqCDTHpi?=
 =?us-ascii?Q?qgYOJckEpl1ObCPYmjRVeSCWzaPyKD82w9vICFG9d8PyDu8QFw0TPrDBtCQU?=
 =?us-ascii?Q?5qLE+ksYP7ajhMDHS8OKm/8fNHt3w0o0oekhssH6BCmmkKpK2t/yEVRs40Bo?=
 =?us-ascii?Q?s6SMB48Q1mNHsehZBzGxvFulV/iLnyN9wRkIwrkXh9ZJl9qk/tgEK6upHi5I?=
 =?us-ascii?Q?CdSADTeom1wxKnhKdcHDiroccZw0enhg3PrrBHkdjTslFjR9/tnr+NBnMDub?=
 =?us-ascii?Q?vMoVYIIi/tPQvV9sOnaCOKXqQw3kFsRpUF4ryVoyPEmzBtQEnupY5ClEZdSm?=
 =?us-ascii?Q?i/0JaIO8Jzny5KmSsx7ZaocW3voQn9SWHUELpv3SiAuAbsdEbV35BLUUv703?=
 =?us-ascii?Q?1aYf1RimKfxrdxIBJdD32Paf8Rwzmq9a8SgycUhaR+z/FmrtCZU9Q1KXE06K?=
 =?us-ascii?Q?t5EMfzPlgielFIfIybjpXknPQsiKd7Lmbirn1Ya2d6PWel91GhPm/BXyzhtZ?=
 =?us-ascii?Q?50F5LkyHGPsLeaOBXtmOnTn4OSz0SM1lKM5dEX3l4AwoiPJvi+r5Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3HpIElfryo1Zs+YifGsLGHxIBVo6zl0bWm/OekSw3Ukaj35zgMNxYzO8+cgz?=
 =?us-ascii?Q?/KiHmUPzlLNR+En3q6LDXIqCz2Z2cIDx4V0RXQYq49rE1R4SBsplLcbzW67A?=
 =?us-ascii?Q?QyAkPRRaScbW3xa4VUuS8YTh2/Vq4VJlItou5Q2d0mYDxwAmTlQQ4GDyoylw?=
 =?us-ascii?Q?VtPuzaeAz16/4f5O77tkqtL0NxaClmM9AUrPF7UDj32MaNCqTcWkMy13meyH?=
 =?us-ascii?Q?MD8G+k5q3OPEZl3Ew+McTvLSbvpK3AchLpSOGYD2C8v9chkTvgKUmtnsG+Sb?=
 =?us-ascii?Q?nXidBFlScQE/cJ7eUV2y+cDKtu7L6RJbjgeDwRUVOhs9klRhoJDswNVmNA4R?=
 =?us-ascii?Q?jEe0Y4/cTwg5SD5WmBbXXdthj3VyD/R/4RMoIZaxb2ky9Ww6tLILk0mZQpfu?=
 =?us-ascii?Q?wRoYc0SYTPxlRA9mab6VfFwRfOJBvzBF8iIUtvdYFNdNQWt99yKK3MnhNcDT?=
 =?us-ascii?Q?euhfoKYgGrMTDgfxhLdAJk1Q97uuRYOET1UDGN0a111Zh43q9tJMHR76a0Ow?=
 =?us-ascii?Q?0eyqoR9Z2Q5vcVm72v6o6BISxAmF3+MEcdO0Ghz/V4uKm+uPwLK27tbHeodI?=
 =?us-ascii?Q?cap1QKyyaIAvgI7tUEUD65EhnIoEg96mbIa8reFw/U5a5jRwEN5tn0dYMl7J?=
 =?us-ascii?Q?FM3Zzq+Gu/51sAzEGtAwejyXZ9Dw8GRhc14WFSW20xgDqAcQPh4D+KNeN8DK?=
 =?us-ascii?Q?mavZFrdWiAkFEgJHV1aebgVJjNHg1fS29jtHnQqhajgyHr+yBfkxU53Sb17Z?=
 =?us-ascii?Q?z81DMp8Kanr2BQ2PAQo5/zWyfanoOTPbOP2B06n1qrrqSn+KZXd6Syn7R1lA?=
 =?us-ascii?Q?CpLuiSXPLYVPLtG240JuqU51/67nyQopEyUDtP4QmFczP3HL82vFwAapKmo6?=
 =?us-ascii?Q?1o3XNIycELuqEvEWS7V+d49gQ06k8MqhIlatCxT0BjpIMkZYfYQwmaEw1e+g?=
 =?us-ascii?Q?QjvdVOvPqK13Uq/zs+0Ft84FRii+CRGrh0WpVS/tYAT77WUAsXpPSrNksN87?=
 =?us-ascii?Q?0k/PgFPAsG4elhqF6+AY6T3loIQDM4cGnKiO/616Zi92CCJ1hD5XuOkdCpUy?=
 =?us-ascii?Q?Ufz+JVkjlQQaDmmxyrobIfOjmBYORs3i27lRKuP+ISnc7W348VF+netLKh8w?=
 =?us-ascii?Q?ix/8Y4DxSpzFD9ICb84SKU5xXh1mykEKUVcYeLCZwZHeRszF9hfFfjbLPycI?=
 =?us-ascii?Q?opsyOf3LNVcSBhEa/LFzgNeRAfguDxCYyI8ygDnLikqfu8SZTiwgmKjmkAd2?=
 =?us-ascii?Q?cod3RtTLvsC0a4hfkEdvW6To6ZDgtYn24fNZutGCRZ30c6a/vunCkVlGjemY?=
 =?us-ascii?Q?QzDG582+E9IcVWlOTzfUD7WD3VPwIl+ffiOooCAv9dUDvV0pTBcjcr3F+6aM?=
 =?us-ascii?Q?iaycp0poOgbLbytTYdbajzK2g2n/7tLHw++P2/A32xI76meE4hUTaxr8hGY1?=
 =?us-ascii?Q?e8meiH+o4FcKfuJd7EwFnB8Kv4lEycPmiSgOldSfKw1vO2EkHJHzbDDkXGz4?=
 =?us-ascii?Q?ZbAUcdB1hJ1KHo+OgnlzoIumSDQXFTfo5YThXKlITzJClbr8wxWq/01/OWR5?=
 =?us-ascii?Q?lGblzUaxraGSvKTdZ4Zr6SIOd2mhRboBIFJfD/a2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8050b602-e0b9-421b-fbdb-08ddd8d1c901
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:22:48.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 403tjxlo2szxJE99GhOz6U5mPFnv4Db/7jNrCRxaaFz46O+A7NDBUyq7MzJ0cDs0z6XnpGr3yQ0NztRgYTOgNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7172

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/acpi/acpica/utpredef.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index d9bd80e2d32a..658aeb397111 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -248,7 +248,7 @@ acpi_ut_display_predefined_method(char *buffer,
 	printf("%4.4s    Requires %s%u argument%s",
 	       this_name->info.name,
 	       (this_name->info.argument_list & ARG_COUNT_IS_MINIMUM) ?
-	       "(at least) " : "", arg_count, arg_count != 1 ? "s" : "");
+	       "(at least) " : "", arg_count, str_plural(arg_count));
 
 	/* Display the types for any arguments */
 
-- 
2.34.1


