Return-Path: <linux-acpi+bounces-14144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1AACE6B9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5857D3A9B86
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67F237717;
	Wed,  4 Jun 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GHR6O0HF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2112.outbound.protection.outlook.com [40.107.95.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D82367C2;
	Wed,  4 Jun 2025 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076713; cv=fail; b=GvUMai2tzIEg2OYtC7n3GkXN2loeCtK4ACE7Njb1+QX7S6idyyx+v9vGG68WMcvs2GvMgE+Q5GZdu4MFka1hNR9IV2ZhErWQJgArAz+RRf84MQZuGJmN4FzNGObmH7s/doDJVaxVV/fJRElYP5ntioHYAcQ6aF+HKhxm+LxyEAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076713; c=relaxed/simple;
	bh=yhE8kJsOAJoXTs3fz9nQOtD8mZSVr6QWnNaPEbagHts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rcqg9eYh/qojrZQirpLFVzNAdKLiqEwcVR5xJkwfHfTPKqs7Wfv7P/Y4RI1PkAipdBDPZI6pqDyvNnecHZO474TRkfXBRhVpmoup4iGZcZiUe0/eOuCXcu5l1zSeKDAjGQIbbCkSZQejEJPpdpgX00bCmxgq9Y4Zjoq7dewHRm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GHR6O0HF; arc=fail smtp.client-ip=40.107.95.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7p13DOLMPP0WFuAtXJNh0RDiSumSF6qHoWLWt25pd8ChTxFH2M1L8QDlT4zZX6R6XJEdM7E1I9+ijZLpZCRBW4mKtdH2hu2tzTktFrnCp5Xmg4auUtAkrJtJ4dI8rCzfgPbarUvt2MGg29ljYjCjue9/M6LChjkKbK5NcbQroIRWRa9UOKFQoks+Qc0nYxmjthAEKxflmP9H3b/KRlAsBCDKbsXM+YylhvTOImbFRHhPYESEepubBTda74oZnJWxo4ESNUzE2DR01BkPPYErNSBvKM1g7KJ+3eAhf+UyYo0MeX++MQTw6M3vTd2lMN5JhlTKJWKvRdYbF2R6dyETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW5A92Rpo2eqgDJQ9O/tx4Ie39m5jazA5TCka31O43Q=;
 b=Tjk4Ba37EG+/bx0OTeVkEAL39yUynMVQCmlzmvtQrufNOsOYLmcqADqeP8KEPLBlr24n66hGxZ9KqJhjKam4qayUSR/VN1DftuXHcF9YIE58EsMn1+yOlpy4+pvZ77ce+1QaRL5s/ZtiZXVxXAgiFQF74s/6JNlv6OY7m/6xOOLiAuE97kOYbpZWv9N76d+H4siCOKd8boRD0IHQeZ+AJwCl64gskotM0QeqCquCcijstQ0Q18l2cLWw+oB+I9JJfyPn8Pc0/997NkDtXLWhlpe2+KncMhnTO3svIcJ7AoaMGNsrUqOvtwXtlxhTJI3yPZZPtALiTvQ7NNgr/IeaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW5A92Rpo2eqgDJQ9O/tx4Ie39m5jazA5TCka31O43Q=;
 b=GHR6O0HF4Q78yMxpm+9V/2z6+WP9F0C7TSlx+yhFOoTmPpHX2VQt2823btCRfUs22UyZJ1PpEpbKcIQ/hXj0yjxqRvaGXlwW01svCNyFb7Uv8+CMuD5ovmP6r+papF8WWPXTT/cEJTyBedH6CjUZUS/qya3KeRnA/oi5Q5Ubo/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB8159.prod.exchangelabs.com (2603:10b6:806:333::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.20; Wed, 4 Jun 2025 22:38:28 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:28 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com,
	u.kleine-koenig@baylibre.com,
	jonathanh@nvidia.com,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	peterz@infradead.org,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	Benjamin.Cheatham@amd.com,
	dave.jiang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v8 6/7] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Wed,  4 Jun 2025 15:38:03 -0700
Message-ID: <20250604223804.842501-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
References: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA1PR01MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1492a358-6a63-45e7-1755-08dda3b88688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tyrv27jucbH0IXIHys0zTlNOO03L+NmagXQ8wTwWPGCTXOTDc8y3TKH+pPez?=
 =?us-ascii?Q?Njiy52u4rn92aM0k/uB1kpP8gg2bIRJZfKE/bChTpEDOaKNy8Dza52cs6JzC?=
 =?us-ascii?Q?pYAMRpDpDStYCnOu81B79AuIpPqKc8jswOo7oCW5HT8bShIFGWCBr2lXfZq5?=
 =?us-ascii?Q?ZcHZ+Bf79bpILUTE4MS6kia1nmOCvdcnjc6amztuN29REbe0uws2ez8k7gBE?=
 =?us-ascii?Q?pHrJtR2Wt0T+7BDWbdU2z9/jH/lz6YKr+1Pr+jkxWeIhEfykW73fwjVnZMVy?=
 =?us-ascii?Q?JChC5IeRalrlmmkD1xSCPgovBR0cJuFZ1xwh64FpbAKSkeEFw4VOp2x7SSRz?=
 =?us-ascii?Q?RmJ/PkhYLhgJDj6qj6ivPnufY0RjwWFAndxFBjB8m9IOZit95d37x4ORGHVA?=
 =?us-ascii?Q?mj3CIvQtaWqrtYExvBGFN8NmIQJPLl/1Lkl+SDf5vFux/zIjE49yAQR8rl2g?=
 =?us-ascii?Q?i/c/NxKy3r4s2Dp1/j2JTyV4sbC1KV/piODkwwwUVMG/Hc6OCSyFzkjQ+mTb?=
 =?us-ascii?Q?Vmw/eXaELlEyg+bLKcr57CTozjbwkyVBv76bCBcfPrsyZhqtrN7dxNwfpV7C?=
 =?us-ascii?Q?QhgtTCWy/irAxBsB0nEn8svF6i+e3n+0S2QvvRz2sUvkDFjyuZLiQPweraii?=
 =?us-ascii?Q?ECPbA/Hu0HsbbUy0qJ76gyZZkBKS7GtT3RXE8RHVLaWDA7kcegEgz5DZ+FtK?=
 =?us-ascii?Q?2sG3vKaRP7jj9Tj5NrKJVGWei1HQcERF7hsXf2tPyxF4r3lMTJ9J4K1yVqPI?=
 =?us-ascii?Q?Ot7zwHy+5mT9jnhYsh5fi45fA59P3I2JnuF2FQo1quk9Jg1Wd8p3U2FKc0Og?=
 =?us-ascii?Q?QNvBMMeZs09gDLULvCAylcgWJALNyEjZjLAlgeHsKGZV40xBEFKZEvjitofS?=
 =?us-ascii?Q?HPKg8cRT3lRfPscZJvSuItd6XEkbZJ257IpI+dUBMY5BCBFVFgByo1m9sVK0?=
 =?us-ascii?Q?APEz5mrHyeQntn75M5DDTAo1u7b2RSrYGAqrlDe2+y0FoEbjU8HfcFHmVxJX?=
 =?us-ascii?Q?KABpHZy1OnRy0qzPVbvsplHnt3Knf2TY+2S1P3y0hO56Nk7oDYY9XR8mPp1e?=
 =?us-ascii?Q?wG4MSaE+8VtO+WcxpeDX3aF9du0wiWFmLkyXSZvSrQt2hZxyfFPYaErBUgnQ?=
 =?us-ascii?Q?qctCICrVrshrP03yvLfaPtAyZh83SjlF++OSYFI07QbehzjnqYkTraIzO0YP?=
 =?us-ascii?Q?xOe7ukt7muDGvkmUTAdIhriMizoFzp6nxqcC3yeSJ/Gb5ru94ggtm5MtiwNh?=
 =?us-ascii?Q?UM3Ug9wGylMi7pHHAiUKVcM0dBW+Gu5Oy+BZg+R5vK3f0bMfB9QkAInH+AZI?=
 =?us-ascii?Q?rOOnF4pmdz8HzXlEyq4i0FQwxfAHELYQv+UDxW2GqjDrDwrQEA5RjUDJ30a7?=
 =?us-ascii?Q?UdWv7imHE9XQSF1BtKsU4VMy7P7RhJdXNnlu3P4iBnPo9OkvpdxDkiyjLn36?=
 =?us-ascii?Q?DRtYMnuIRe9zvOVPHcTVQHHYG6UoVyia/reuPTo/i6CxpCuXthEZIPB7aMlL?=
 =?us-ascii?Q?ZaaMCsssLYdeQ8k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GGN1BafmDoiYBL0xwZy2R9eBJWusEIBPiazdEwjDb15OkgM7CRHXt0wyHp53?=
 =?us-ascii?Q?dY0bV/ynLyLaz6Z7Kp98kzAA1PK5xcwYqmUXhdaAY1LgVFyds5ayVJjSHXmT?=
 =?us-ascii?Q?Q0eSP0ViSIOGtGd94CtQpgClmIPmOxnx5fa8OoiboS4vrNdgdYgzr+CjXqO8?=
 =?us-ascii?Q?Bb8Yj2tvOUVeGA7S/c+TkdAWTmkx85nFfwEadfmv/dZLRSPJAoA/sUnkRSG1?=
 =?us-ascii?Q?NrvX+nUstSaCY/Q8dqrYFGNAzJjFdRLs+d49Dozb2vQy8ycO5S+URI63OFcI?=
 =?us-ascii?Q?uNfYE8VY9CuzzDGmYRbLZ7sBinDW11ekBUMqeglqOWhyUWuaxWPjFGRBMwiq?=
 =?us-ascii?Q?BW9rty2L3e1xJjl/wmyna5WpF8B+tw+6KiZfu54nYu3B3lmlp2x0rnlfZHcq?=
 =?us-ascii?Q?/d09dnsB6qUzvy7I5zT+BH+qhJ29/mfMIKn161fdT8eQThs1ovdH5cn505/U?=
 =?us-ascii?Q?egMnZRCU1xONjMsvh9mbh2waiGmWNrTQjT8DOmAk95tWgbpJXWwSN/mLqFzR?=
 =?us-ascii?Q?kNwkceUbCYQxAA6JYPEZdhlfVELkwuuCJripkx9/NC2i6qOw+dUxUk44XAH+?=
 =?us-ascii?Q?87z3UN9s/YFqawwDxJTni8ddexFoVhDazqds98L+rxuG7Oq9MJKGg5OtYYS3?=
 =?us-ascii?Q?tpWxP9jUHbNKfxBBd0oy21pv0Wgkeshd5gc6Hm0INGnHd5Q/+0/jT0vNQxFt?=
 =?us-ascii?Q?CaIvudQr4tTbsb+xp6Vj64NLPk8SLC5kBVVGnG4RJmsTfM3+HvWzdeKSpYRb?=
 =?us-ascii?Q?ugj3+fajRs0yZQCeW7KPuPt67zIqEMnED2bc71caGf//OnCkXPUD4xuLrLis?=
 =?us-ascii?Q?aiVMbGlobSM5uQQ9szyXou0JGp0IJS+Mc44E50pKMizXxxDjvsswAjVklO0X?=
 =?us-ascii?Q?/K2guFW/1Br1rc7sHdTAh38jimhUDZLMUhTlwR41V77l/So5ehCLXX5rBdDy?=
 =?us-ascii?Q?fw+zVENx3HV04Das7sk6WKQGynjXIHgO200Q9GSPIFaUc2dixFfhVqEx7orL?=
 =?us-ascii?Q?Fef4L2RTisZogjKSgLhs1rLeoaTy1hGk9VsOlxUW6Xh+rr00+psNwYXB34uo?=
 =?us-ascii?Q?rUZWR2NIGhD/5tnLy5a+8t7CkEn9ex9PEOlaFlbA1dnDgf6bYtyeoj2Mscgk?=
 =?us-ascii?Q?qEIJdbmbxUosX+4ujjUxNWWJHgQPFlpstbwPU0QkrdZtHXmEyobyBRj5ZJdZ?=
 =?us-ascii?Q?M55LuCFIkIP4yXqjIHCFrC5FYLwb6/mtLbr2hOpYFeWSzNEBdPkl1vsataBl?=
 =?us-ascii?Q?Ft4IOcqU20iZm7PqCBsQKtA2PSlzJQDiUU+LcLrHpf2HV9l/HopCify2ljVS?=
 =?us-ascii?Q?DsXKtstRB71X6/+9V2Rl3zVFQMoilgVaFiihI/gqBGpdwrno0Af+GLCnNKBV?=
 =?us-ascii?Q?NuxPkVYZapJATyKZehSiw2VEHCdyW0HAMCEk3H8AIdDZXnnHGHh/+zBii2i3?=
 =?us-ascii?Q?VHFYenC11v5H4SuJgvssrxZ9yCF1cC1pJeaNoWwi2cqkvR32yb7KYe/LpXre?=
 =?us-ascii?Q?CgGfbbcIsHXZxx5wHMwyN9XPbjZFyPwJTnBjAzs2u3aalf7FDLl37vvfhIGs?=
 =?us-ascii?Q?CgDKXPmAirdlA/lUCROzTn+zqSSMAW1ogZqw9wVnsxQiWsWkkd5jFOe8QADl?=
 =?us-ascii?Q?8HBx4thaRkaHbSDaiIvG38g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1492a358-6a63-45e7-1755-08dda3b88688
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:28.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJTf0FgsXyRRLniYo94iak8eV7WCSpUnO1jyTmpKvI73lML2iKnySOfm+g3i9wLozLNUW6NcmISIycAGm9BsahupsI3jfmVWp46FkgVpWVpRH2ALGHb8+SHUY3lEtMA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8159

Enable injection using EINJv2 mode of operation.

[Tony: Mostly Zaid's original code. I just changed how the error ID
and syndrome bits are implemented. Also swapped out some camelcase
variable names]

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj-core.c | 56 ++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2f46f1ace67e..3b62dce5acb5 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -87,6 +87,7 @@ enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
 	SETWA_FLAGS_PCIE_SBDF = 4,
+	SETWA_FLAGS_EINJV2 = 8,
 };
 
 /*
@@ -180,6 +181,7 @@ bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
 static u32 v5param_size;
+static bool is_v2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -506,12 +508,20 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
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
 
@@ -520,10 +530,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -543,8 +553,21 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -568,7 +591,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		memcpy_toio(einj_param, v5param, v5param_size);
+		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
@@ -630,10 +654,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
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
@@ -742,7 +771,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-	if (available_error_type & ACPI65_EINJV2_SUPP) {
+	if ((available_error_type & ACPI65_EINJV2_SUPP) && einj_v2_enabled) {
 		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
 			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
 				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
@@ -784,7 +813,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -803,9 +832,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
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
@@ -827,6 +858,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_v2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
-- 
2.43.0


