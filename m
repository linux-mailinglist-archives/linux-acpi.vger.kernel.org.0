Return-Path: <linux-acpi+bounces-9968-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1BB9E5FF2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F19D165212
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6C21C9E2;
	Thu,  5 Dec 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Wb9wpsG8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020128.outbound.protection.outlook.com [52.101.46.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077E1CEE8D;
	Thu,  5 Dec 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433558; cv=fail; b=XhBTgWIRY9VHBo5Bj2mxIn/KmO5qAyY6T+N4J7Lal82W07Gu0mXo2UnF2KqBQfpJaDoapPBBf08JJfEAT5pXhKKz2JpPqf/e8JZkgLGHTmGS3j0h3nSGEizsZIomm9wxb+UKX65P0EOxNy4fDgQzW9ptqk6IKGbKsgkauq4g/iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433558; c=relaxed/simple;
	bh=Sz7MauQ+i3s88IvH1p7ZasZ/NJqE3OcNkXyiZjMfmB4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cylmrEgIEKCJdsJWxVa8+X9bdO4TPMh4rqiRjoPeJFEv/fuif8RbJMKXrTVZlfoqJCbVvWyhR9kLD/OltutmfGoNiEt9xLlbER7csp56bpZ76N8Y/qlbW8oFpl2VE2Nz4RovbPCY4egyRX3eYveE8X0PCIl7pzan2WNNZgsbGgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Wb9wpsG8; arc=fail smtp.client-ip=52.101.46.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF6I8x+CNcuxW19PNFp8XJv3TSzg+/V9KV4Zad1jkLQy+efVT3dBZvbQk9ydjLcb+NPby9/dQsyow35O0ul+N6Cr99mEKFA5xflgsQikNqykRHPfaXpFukkjEZNQVm3RWNFcbSaC3+eIjk9eXdiP2SR7gKIK4SbuDKj3gXIw+QHdtMxzwl94lQH6bgYZYcxZS1gtIp6P35whTQLsj1paFmbOxHTAb4q1inO+hVVQqfcj3Sp6yfg6BvMg/bRoU4vYVKeH5gj+ysrd1oPEauW8UmdP35bhLBZgYOkoN2b+om9gK1c3+XFLrCkxZNSF+C78ROp/T1WW/lxXrvWd/U3PNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J12NBPNL1F68tAUE41e1CX+dm/Soh3SsBMp6tTLrPeg=;
 b=CBxbPAQLpFrdbisOZUEvKIl1L05FUPiCfkc1pWEKqfiCh1aUMQ5gs91jOs9mf/2U31l5GLZgCZezChgMhYKDpW7WN7BJdfdxKhQZibtdYmZFUgIM5kOviSYRDMS13wY7UxqJKdGBfxEvafE/ByykUR+dUUjQkC5dz1qsVHNUuE3Z/j30dcmxtso2VPJ0DLHLTXxX+RhrpZzbgW2tr2Sqe3yA5M2mDzRKwWCQcVFoya8DqfuoULNP0Npi7pVejkMLwO0TjytxXTlfHvrmWMjhkgOO4hk91R6dig/79zKyGiX/tqomo35A3t649csZUJv93XBxZ1ZmLYZm2svUbNqY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J12NBPNL1F68tAUE41e1CX+dm/Soh3SsBMp6tTLrPeg=;
 b=Wb9wpsG88uVeev4U8ZhS6v2gurNjiWDMH7T0e8ok4QKqcPa5QL3/Jzlsqc8Yb1y+JNpYuUFwY1sZQ4MPFpVw/DWDMgqnP3/c7rWfCT0a/DZtzYjeQD4D1yKaNRueOt2mx75izC8McNOMt3EGYQAttMTDsuScEhqkoLmZZ1K8xQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BY3PR01MB6625.prod.exchangelabs.com (2603:10b6:a03:36c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.9; Thu, 5 Dec 2024 21:19:12 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:12 +0000
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
Subject: [PATCH v2 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Thu,  5 Dec 2024 13:18:50 -0800
Message-Id: <20241205211854.43215-6-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BY3PR01MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd2ff5b-285c-45c2-2df7-08dd15727721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJRHc5sWGTrq+b8AQJtcwqp2JY7zi8ySZwfoBGGaUbfZxtd9QdeokHm4z/B1?=
 =?us-ascii?Q?Tc7LGqnm10m7pE3Yxnw+eFRdzU2oELzqtdby7iYe32A5bP9/QwbvhPBoT5Kh?=
 =?us-ascii?Q?bPrmL7f3IA1HEEIzGhXYR02bAZYfneFUU3cdIdWt39bW/VTsDzcQO0Oc9dTI?=
 =?us-ascii?Q?cZzhLCLQ1A0WnsxUylaz2DMRkgWVrQtq3dZy0cibUzkUzauMUXTwVHGD940p?=
 =?us-ascii?Q?eIjb0u0+9hX1eTV4vRca1nZtVpuoQyI8sl96l0TbAR4G5yyyPWG63YN58akX?=
 =?us-ascii?Q?Z4j52fCRij9mGbCKKMJwnG62vZT+YOxEeyWKSoeidmQGCDObyONCO/1zT7KD?=
 =?us-ascii?Q?YrBFdOe5UPyBhFCfuUwD9xy/0BrISoRoNg+xVlCI4dEL8xcTxiHDwZ8gEgLZ?=
 =?us-ascii?Q?aqy+TnspjSlNJmemQpAe9LHaAnxixLYzP9w7je4W5oe41kldFM/nuln/NW52?=
 =?us-ascii?Q?i0bhmVtn55WRIAQgnMa8bBUls+6uIClOjwiNCF4g1zWz7x+7y6AH3extmFKu?=
 =?us-ascii?Q?r5wb+OHbAjaA8pBG7XZzK9ck1XpU0WrOz8zr7/NouOf6p7Z+s+wagrpc94ud?=
 =?us-ascii?Q?/F3MYLah3HAf7EJ9Xn9Xd2B7XJcQaZC0jxhTCc6qwDRPQcQDKxQoD8a5161U?=
 =?us-ascii?Q?EA4dUYDvC/x5+7L8voYfZdgnnm3+c9sgW9jcsZBNdhpf/VWUrglOZaD6Qa1x?=
 =?us-ascii?Q?D8zzOVysX9MoUhwluPf2p2lXSOPDSfW2L2sASGjrtOiG4FCHkTF99FbVbayQ?=
 =?us-ascii?Q?Mkm83Ur/vp2slEcfl94TV988oG453uToVQuEkR2U5EoU6yBuBD9xjTg5bahy?=
 =?us-ascii?Q?aQ0GcyeEgOtsMKnf/Bt1t+i9/tj6kZXIBuL/XHfezqXG/YOeCS5xgjEgDNLt?=
 =?us-ascii?Q?3DuWJRkBmDzi7Ng6BWqo+CzGNP/rkZyiwrBB/MpdlkLqihgFKV8AQoEdmy0+?=
 =?us-ascii?Q?KVM9EaupSRSBy/oTew+czcHNqSUZo9xOhvmBCln+/3Mjne6JBuGIxD9rDrwH?=
 =?us-ascii?Q?jYt3OoEE+/Aoafw+htY37ygwQMW+4Yhf7Bgkz9Qf5zkfb5V9l/u4wNHh/ttV?=
 =?us-ascii?Q?Nl30ffAY/gEqQ5h4apAbSn2pdNi5RFAhjbAFVymLrZzWskIhxhWjp3EUlCiM?=
 =?us-ascii?Q?NzlqKj1vv/TVyd/MqGO3k8v6KpnUrU4085gJOH2sPOavJ6bfkVnzQC2T6fCe?=
 =?us-ascii?Q?+IA5cqlx6BaHB4ZAYY++QlZg3y/EDGqOJoCSSG2FbvObpAHY2RUoWGIF0RTc?=
 =?us-ascii?Q?ym1yzITwLb8ENEvCVF9ttvSDHE8tC7yDwUyKSZrU9G4ZEu4rdgHVENFJ3TV6?=
 =?us-ascii?Q?rsT0gA6Qq5wihoSIDEvLjgfa9higcYTyCz+FQBPM3PV1lX4wmaTHasl0FhNo?=
 =?us-ascii?Q?rjQ3ss9d5y0FeNMLosWuwpfutcv8ZelWzJ4s9VF1Uz3MyE6xA1dzXDv1xONc?=
 =?us-ascii?Q?JHrFiHrKJkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1+/SSngAF80TYBcXd0NCGFzqANGK47Z8TaEGBCSFRZCc9s0V8e9ODwUQprG?=
 =?us-ascii?Q?HXakhnuAPEOh2UN0M2VspCZkpPl7CjSjrX7qlcK2jwyhIzeHeIF3SZQEJtK4?=
 =?us-ascii?Q?h6XCho314FssaX5I5rEBpSvoTGDIoYJgS0nrVwkpI7sgIVsVzOml8Z3dReCF?=
 =?us-ascii?Q?aRbJ8euMBw952hrFKNV1mVnDd6+y/1oO/H37PXu2rPUrg9VIAXEMTIDZu4zm?=
 =?us-ascii?Q?+yCTF5M9qTXNjwF+ADfSGEHJtE2hdp6QLA7rJuZhRPYA4Leoge5HwQBemf2L?=
 =?us-ascii?Q?ACF/odtbfsG5y90HPpwgcZsypLWU9ZvT7fNrmUJ3F164O3DZx4lvvTOcJIjk?=
 =?us-ascii?Q?V3bRaIoasfcMozc3WOa47uPXX4m1yt2xnl/+MTzUQ6alVz6+14LeTxuHHzVC?=
 =?us-ascii?Q?ZIPpx284OLTSwbiZc6LkxGDUWBNRrtgujlpHV4l9UGLu/SgJ1oF7tk3SXR/H?=
 =?us-ascii?Q?lt3FVk/5+94lrZeNRa9POkFhMlbRLPuJ5IQc2RTxRHh6fxXCPFLS611APfD1?=
 =?us-ascii?Q?NhKzztTJyNNC5yjvR4Z9JG6PDsZXHwMAwFTzy3rcFvs/v2RcKwF9eAMzHKt8?=
 =?us-ascii?Q?0m+AQhASlH3P3hlBMFc1lx95z64XOTOYbKqPRFoOTedfihYepyli230UBi0u?=
 =?us-ascii?Q?+If7MFG4IQn3eAIyimLAqtdTud7toW6kOHP+kTlhs9XeI0zZMaP0Yd+AoFPN?=
 =?us-ascii?Q?LsvglEM0nl2skAzj11t2PTDs/PaF5XBwG9Yi+GE7JulzvjvvPk14EYXMghtP?=
 =?us-ascii?Q?qSMJ0IpAErBHz8oSOWmO5HD73tMl6Mi7TgnLwMcrltPpdhxVLXmXB25E4+Ww?=
 =?us-ascii?Q?UJ0h38ZHEBC5eTHvwubsG0hdLLkHK8QcOBRRuYj2+dsDWIUpcdYCiNmdV8Vz?=
 =?us-ascii?Q?nbJ4bfxYJV9+uvv2459I1RnpOZM6GHWo2oMMN46ZYJ76GExu+IEb8QixdXbq?=
 =?us-ascii?Q?U5V9BhA5/49vNH7YUbghX41FNkfWw43Y9+CRa3e88uPAgWq9S2zX1x3m8uRc?=
 =?us-ascii?Q?XyhYRj90DVKTZnLvXL2uIAf2JuaaZ2IB4jaMbqOA8uNyZpnnguUbF2wDJCpa?=
 =?us-ascii?Q?vQkyb2NdRQqrBzlr25s9MHss+AypMTPfT41XRnjNlFgWybUzrQ/GxkLP7krK?=
 =?us-ascii?Q?Z+TwZq6+4ZFHa8svNSHQ40KV0URWpOK7daZUeMGdW1cS1XnDSHVDJ/EPfVKa?=
 =?us-ascii?Q?Ylk9WoW1WNVrYAVMO6YV9ILEGukI8s4dor20HVksnqdQOhdGBmQU5rnqibI3?=
 =?us-ascii?Q?cy+U6NyTlWyMLdxTTl3sWC1uFssIgHs8lWazOe3efGFDFPZjqH0fcGUpvAxt?=
 =?us-ascii?Q?/MNwl0SetKUmO1483sPxdB0QjS/j0vXhNYLLLHEfbMDvmcgeN6FXiAdL4w1Z?=
 =?us-ascii?Q?0GxhCZGf9qeGLEP5glRoidx24Igz3jRy/ABcBoqX7nJu4V9NaEbGaa1BtjfN?=
 =?us-ascii?Q?6va5CeHY73rfaPcHOXrAR4mEFEjrn8RRMti7dIKsL5iWb7TaZO8KI7F8On42?=
 =?us-ascii?Q?0eqYlALoA7AXjUMLJ6VrhNRolU2dbgvn8rAiVyT/bBx61HVq9vbsRSlrgfWq?=
 =?us-ascii?Q?QuVbacf9i9NLJZ+J8K/1KkRYTxl4jvMnV4c0Xy+KN+7jSuJV4iv4xSVZ2uxo?=
 =?us-ascii?Q?4W3kMg3ica3Pcm04tMv8ERc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2ff5b-285c-45c2-2df7-08dd15727721
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:12.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDKlyUjUf+D5g5iJxAmRMCKMC6+51JPSOlMyLM+vaK7DGiNzEO8l+799JxYqnUoh5ILuXtZMHETcGEqQMYD0gGRTNqWchLeOXf/7l6a6gRmi46E9eyzzkDeBJ92+Ezq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6625

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

This update makes the driver parse the error_type as a string to
avoid any ambiguity with EINJv1 and EINJv2 error types that has
the same value, where EINJv2 error types has the prefix "V2_".

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 70 ++++++++++++++++++++++++-------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index cd2766c69d78..9a3dbaeed39a 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 
 int apei_osc_setup(void);
 
-int einj_get_available_error_type(u32 *type);
+int einj_get_available_error_type(u32 *type, int version);
 int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      u64 param4);
 int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index a6b648361d96..2c57e25252ac 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
 static u32 available_error_type;
+static u32 available_error_type_v2;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
 }
 
-static int __einj_get_available_error_type(u32 *type)
+static int __einj_get_available_error_type(u32 *type, int version)
 {
 	struct apei_exec_context ctx;
 	int rc;
 
 	einj_exec_ctx_init(&ctx);
-	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
+	rc = apei_exec_run(&ctx, version);
 	if (rc)
 		return rc;
 	*type = apei_exec_ctx_get_output(&ctx);
@@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type, int version)
 {
 	int rc;
 
 	mutex_lock(&einj_mutex);
-	rc = __einj_get_available_error_type(type);
+	rc = __einj_get_available_error_type(type, version);
 	mutex_unlock(&einj_mutex);
 
 	return rc;
@@ -641,6 +643,7 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+static char *einj_buf;
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -656,6 +659,11 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(11), "Platform Uncorrectable fatal"},
 	{ BIT(31), "Vendor Defined Error Types" },
 };
+static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
+	{ BIT(0), "EINJV2 Processor Error" },
+	{ BIT(1), "EINJV2 Memory Error" },
+	{ BIT(2), "EINJV2 PCI Express Error" },
+};
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
@@ -663,18 +671,22 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
-				   einj_error_type_string[pos].str);
-
+				einj_error_type_string[pos].str);
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
+			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+					einjv2_error_type_string[pos].str);
+	}
 	return 0;
 }
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
+static ssize_t error_type_get(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
 {
-	*val = error_type;
-
-	return 0;
+	return simple_read_from_buffer(buf, count, ppos, einj_buf, strlen(einj_buf));
 }
 
 bool einj_is_cxl_error_type(u64 type)
@@ -701,15 +713,28 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
 }
 
-static int error_type_set(void *data, u64 val)
+static ssize_t error_type_set(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
 {
 	int rc;
+	u64 val;
+
+	memset(einj_buf, 0, sizeof(einj_buf));
+	if (copy_from_user(einj_buf, buf, count))
+		return -EFAULT;
+
+	if (strncmp(einj_buf, "V2_", 3) == 0) {
+		if (!sscanf(einj_buf, "V2_%llx", &val))
+			return -EINVAL;
+	} else
+		if (!sscanf(einj_buf, "%llx", &val))
+			return -EINVAL;
 
 	rc = einj_validate_error_type(val);
 	if (rc)
@@ -717,11 +742,13 @@ static int error_type_set(void *data, u64 val)
 
 	error_type = val;
 
-	return 0;
+	return count;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(error_type_fops, error_type_get, error_type_set,
-			 "0x%llx\n");
+static const struct file_operations error_type_fops = {
+	.read		= error_type_get,
+	.write		= error_type_set,
+};
 
 static int error_inject_set(void *data, u64 val)
 {
@@ -778,9 +805,14 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(&available_error_type_v2, ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+	}
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
@@ -828,6 +860,11 @@ static int __init einj_probe(struct platform_device *pdev)
 				   einj_debug_dir, &notrigger);
 	}
 
+	einj_buf = kzalloc(32, GFP_KERNEL);
+	if (!einj_buf) {
+		goto err_release;
+	}
+
 	if (vendor_dev[0]) {
 		vendor_blob.data = vendor_dev;
 		vendor_blob.size = strlen(vendor_dev);
@@ -875,6 +912,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
+	kfree(einj_buf);
 }
 
 static struct platform_device *einj_dev;
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 78da9ae543a2..e70a416ec925 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
 
-- 
2.34.1


