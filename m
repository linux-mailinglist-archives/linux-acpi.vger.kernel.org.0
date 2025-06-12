Return-Path: <linux-acpi+bounces-14313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C130AD7EC8
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C43A97E9
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE752E1741;
	Thu, 12 Jun 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="j2A1i5DV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023120.outbound.protection.outlook.com [52.101.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEBF2E1720;
	Thu, 12 Jun 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770030; cv=fail; b=BHyVGrKwkGkWMyk4d74ci99w2VFngrFKCMHuzKHqM8G9JGHFSfw2MS3GfVxAH0tt/oZa9KuhYH3As+eHkeuY01YKO+NR1ksc/zm2A7xzI14oScL+RMG8/cITbMInt0bqS5sDehd62KkPks5lY+nADx78mG3N+5cRkANZ1I3S9EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770030; c=relaxed/simple;
	bh=xgI3jeDtaD2/q4xq3FJpaOuIeBpIb7N2i4WLk9hKe1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sne/13hUx0Xfud1D94nXHTZ4/0u6hvmQEaq4ehFivFRQZBe6xmdfPe0FogBcyf4owiVt1s1U5mRmZqpWgn/yH5ZsSc6i7IyLB3Tx846fvhzyUmKAnDF70NuijdL/P+JJ7MkKwrwFHViCsX8G2sNN3lQW6P4bYwqj/g3EGPfhSoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=j2A1i5DV; arc=fail smtp.client-ip=52.101.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH46rTmPReFbazvE+pbG+Q2mUNkR51DcH1CbbE5V1dESGsYC2cJznvHP1B4SIW9uEdbyyNymE2VoDFPXMMaKxy5UbbeJernIIKScD2+mEZTs2iNlyuxqurNCxgjyuPw2Ywy8UCX+QFWhWNk8/qaQ3aykT8hdX4Jynn+KMmDPaECko9FB+nOC24aEgERNvuiB7X1RNLDxF1MTn8mNcyWE0oyMwiisOqwhtLKUXACd2m0KQRcAvK1VuExt68La+j6oyeRcKjRPcUdCZQJZY2zBKovZ0zqhHO1hgsv/nV++kEbXY5/lkCME3zSn4hS9LLWOijvFHAybJba6Am/vqSJPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0o/WDau3piXchYih4pUzWzLIaKvM1V/8K5qhhdLFzw=;
 b=brqOhiEPGHqiMPc0OnMSsmSZkEhgnbZKwc6leYYwIKJB+1oyOZz2RlPdp2H5eGX7Xo0EmoMt6cWl/ghSE9z8uzOcI2JXYXoXwSHiSsdM/6KUHWTYHREJM9P5USz70883fxzmDJ0I/dgmaZws/8vKRJ7cXuSpzRqqX3ciwwhEFmrRx526M+whc2KfL/YadVZlssk+t/WI2FlxTMfXNSjrC7L8e+XjLZgA46Veov4irifS4rFAXjrH89H1vRKBUtOlCUTgu457SWdFEfUdE8CQh0ysV91XzcfVAjo6Yqtcol/szffIZRY/XG8OIDFgR3GnnhmsN8fnx53mts/gFlL+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0o/WDau3piXchYih4pUzWzLIaKvM1V/8K5qhhdLFzw=;
 b=j2A1i5DVTpTSwKhrHERfJeK+/FXZj8HkdVhpjNvbRm9Yd12HAsbA+amUb84JTuZydiPzVYY+dF1P/ao9F8KYv0sIwWJpPR7a6EZO2O5GNUmscXkgXYEJgPpAd8WWi0ZsLuzrdwuCEo89HJZtd9KMUhL6RS4R9w7K2Kh1A8cjJI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB9364.prod.exchangelabs.com (2603:10b6:8:24f::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 23:13:47 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:46 +0000
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
	jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com,
	dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v9 3/7] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Thu, 12 Jun 2025 16:13:23 -0700
Message-ID: <20250612231327.84360-4-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS7PR01MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e18c859-7983-499d-5826-08ddaa06c888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UOJlD+AAEBcsideVWruxdWAfztR3fk8nPYwF5mUVIvj6b6yjycBJAN2X9xov?=
 =?us-ascii?Q?baaAhEVPE/dXDOrdekkiYb/yRsP8NMjYWG4z4OMkiV8S71pMc3QoSj7dxT7d?=
 =?us-ascii?Q?dCJW1V8EeuvfbVArV4MjwMO3vzgZce8RPn+y35TVNKju+MmL2OkelBMmjC8+?=
 =?us-ascii?Q?rdUsXdryOiKBQTCrRHYSdznc2YAFjYce+gI2uWS9cITEt0EUyyFCjiRPOF57?=
 =?us-ascii?Q?XOyVHDJ4cyVlf/COlOMZGReQLkjCwTk5GMHCsxo47bsiw8KG4DePbq1vKI2x?=
 =?us-ascii?Q?WbeJpyaE7b4jcrMYK2+gJ1ywPjtmIlUBSAhpoVHpQoMzkgnlkHjeYRudsUAf?=
 =?us-ascii?Q?KGEzm7TXdhfVrjo5TRRcoSbrTBs57YR3ND/Rzb5D0kiRijRJV18buPNIDPip?=
 =?us-ascii?Q?M35kb0ZUaK6OiyzJ1jzSle/mI+0DhzwFSEB5mrycZ5L0r5Xo7PRsFGYM23PQ?=
 =?us-ascii?Q?UcxV879pUIM7ZpapcAcNkqnkMunvKMLsUteTHbBtxJ/O1H2ELF5vPzsmTSPq?=
 =?us-ascii?Q?Yq0oR4OR2mxQNQzpDW444JqdP7uEjaojc/fs9zsHkGkh+hSuZNxX4cPXMz/v?=
 =?us-ascii?Q?Q085OOuGNBviG2BBvqhNzUMet4U3ljOHkP6RI1nCDEIHD0Neodoj7Fk9KRYI?=
 =?us-ascii?Q?RxX/4GehGG0EyLusB2Qws6Wu8haodxTTqrYbHY9t8pf3TqdqiJkLGknYJKG4?=
 =?us-ascii?Q?eH6W6Ipp8DFVx1covWtSl4r50Wu5oW1pe2UCPfOhjJqoZ1lN4mwMyuyRKBq4?=
 =?us-ascii?Q?7vU8jZ5DstBbICYZc/nrD8YQyKU4jAMFLvCCkYqLJYrdzpNrmTKabjyekkQE?=
 =?us-ascii?Q?TrdlniQWEuQQPb3NU6Vq074ITz973vpNQTv/3vCcWMMQitPEfKnxOdGTjgIa?=
 =?us-ascii?Q?wjPH7m4dcPlK0HPH1/SoMnoH2bVkuwJ5Ifxg1R47fwUNVI6FVAaUk42CjcVc?=
 =?us-ascii?Q?B0bVXVXNLyRaTnXKLMjZaDpGS4f3/6uheA+uTXzn7QrfK1jq1vOQ+1fuyDgs?=
 =?us-ascii?Q?gexQXDy5yx/YY/EhwN2RsKB3QfqTAhEUx4Nm92tJGP07GAUJV8WjQqAj1ifo?=
 =?us-ascii?Q?xvOzlsG7Rmirh6aKbHhJyL+XUIb1dJ9G8fSnk8l7RupWB0KTdGwEbIT/2v7Q?=
 =?us-ascii?Q?IV6QXaIsWh2N6F0quHBPytqS9+6OI9MJBWFjNni4YZoAldHll4qBGBlqyTi3?=
 =?us-ascii?Q?ikkcFSqm3RwYbGWa3k36pUN/zme/j2LfC457MzWaZXgrYI69zDlM3duQZuFP?=
 =?us-ascii?Q?XRWpxHHha2pLyAbDtQmHUn76p68CbZ9fikSIMjxoiX76WAWXrBmPEVcB1+Jt?=
 =?us-ascii?Q?elhVsOYTkA07YCSdl+0mx/almUl5B8SAbI/Dis1ia79vMHZkpgJF43Toknb+?=
 =?us-ascii?Q?IocNyMBMrAChb+6pU93THEbWibPr2l+EYLeD3CUbnDUkqlStY+db5D49phdq?=
 =?us-ascii?Q?5YMhyfmPpqn4KKm/k03nB46TM0/N90k8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nl4Dx2syYPHiH05+eHVSeOO3GW5LUHFtlRP/USs1BnvS+byDk3m+1/FHuT81?=
 =?us-ascii?Q?Pqwk1Se93FjGclMOnuJII2YWZXTQig9d/Z+cOFDrq5oNeVoKPEBZKita9Kz4?=
 =?us-ascii?Q?jmJthovm3xiiOFLsVsdveCsf5p1/dBHN/ZtPepzHeBD26PrjFpD22aIU2/1p?=
 =?us-ascii?Q?esnJnimKP5VT+TSzp7CV2csBvDpGx2GsLrl+1mHacTbLVhIW4KCco7r6AgE5?=
 =?us-ascii?Q?q891AH4sxIAjlah5NzoI2QMvNgDVZiNfVXg3S1P2d3wMZ0Br1roqw3s35cjR?=
 =?us-ascii?Q?W3C3iU7gX6ZJSV0bDF2RGABhETMy7wO3L4U7wB7OdlQphtW6hSoEPh5X2W9i?=
 =?us-ascii?Q?xzhDAjX2AHj65QGw9zDsp4hTAPah9qm7FAKB1ErmY+TfswGGLRKqzuh1dPEv?=
 =?us-ascii?Q?IEiY6FkMfc6wJeEQ/NBbtqK8erw0r40A2lZF2bDOjU2rVfksy9smMH0liuXP?=
 =?us-ascii?Q?nMHIr+bi1hGGbGTgOjSZDQDR8fwwBhaJ+9z2xVP2HaBtwUjJO80OfWVybs3d?=
 =?us-ascii?Q?t1FivB32xqjXcLCcWsO2ZHjpKwAVN/74ap0xk/MGDCbgi6cxdsoVQJKQbpJQ?=
 =?us-ascii?Q?OofK/xvk8q/+LQg/6qeRx1RAIimbYFBMKdAa4S6dcWHl3uQhh2DmH4x/Rzdq?=
 =?us-ascii?Q?IxdWiGcrdyHUJ+/hl//FoVyQjuOvCebVnnmeg4He/7RXvvRwilYGGF9qAMX9?=
 =?us-ascii?Q?IsQYEOiD+W6A7OmLmriTVs4nFbd3rVFWQp314mufssZAFdrdCmXC+bSLAtSO?=
 =?us-ascii?Q?H2tLhkPZHDlgQ/p5AIPwRLQk73ZTCbQJ5r59+FzMxY8n0+p9XaTgMNuOezcj?=
 =?us-ascii?Q?e1MAaguP/OoG2yH4FsYmUZhSxpGYct27dROm2Fsw4m4s8ug2SmZSOdRskvgM?=
 =?us-ascii?Q?gUEh66HPpDn/BN0D5F+hSxuQxik+uKxwWst2OdrmYf1qD1rmik5ytX+Z9mf2?=
 =?us-ascii?Q?JMWW4P9exbpE9u9HrhJf2IO3Hyp/oUfxCYLoJYVP6BLM6H5qZ0jqgp2++iNG?=
 =?us-ascii?Q?UTavLfz06RWzo1B3WJ3pzguS0xedcllkbU5WSuCzwnrtzFIb4C9RUzZsbUH8?=
 =?us-ascii?Q?XGoP0NNJVEGvnjdASdUC1/1n4zaGDLV96BHMKx8Lmuke/LRHM0L/3gY22BE1?=
 =?us-ascii?Q?dUiNNHKVRTssq9crKnTuoCquVwmwRJzqCT9BIMe0Bo70efRznj6KnrVusaso?=
 =?us-ascii?Q?fC4kRs286ufme6UR7KrAWREzWTJGVVbwO8Kso3CleTpnuGK/z4LIFLHp100Z?=
 =?us-ascii?Q?3M7/duLArswkk+BdbWArkdDwOwEZer9WDCbfUWYR/LroNINFSY9oKwf0S266?=
 =?us-ascii?Q?1+qqKCVLvs2ZiqM3l6nWGrrDe2IgMe0ZnUMKoCYWrf1ahvzHOOxtZP665cBF?=
 =?us-ascii?Q?RNhG/v8CS4LsXFvSf/r0ieJ36vddHXHB5bTfFG3zMt2/yn0IViUb8mDrw6J2?=
 =?us-ascii?Q?49cEub/ZuxvK9s7gmWDhuWgzb8286tWAVBxZlJ5xjpbOPqIiIHehcNG+UVTr?=
 =?us-ascii?Q?86FwSxeJVreUM9bSogsH/rYSDFKPkr/2ZKDwdI9InLm6NsyIOOyG9tdSPQxe?=
 =?us-ascii?Q?S7nvs+pSS/otgGrAZhoL5CDDbDG15/YFByz6skA28X29YbitUYIGZ4X6SPUr?=
 =?us-ascii?Q?xck3e3JAI4mAIwz/6mFB4/4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e18c859-7983-499d-5826-08ddaa06c888
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:46.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbC/4iantws2cXIXu7Usyh8lpuwlA3Gj17oJKx40mAf680OTHQk1j5cNLR5WRh2Q4sccQFdL1nk48CD1nTNYVtrTV4Xb7R89hTJAKtJusWJdQIN5JpQ76wYTkgCbb1GU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9364

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications[1] enables
EINJv2 by extending set_error_type_with_address struct.

Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#einjv2-extension-structure [1]

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index f018d3970de8..e74281f5044e 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -50,6 +50,28 @@
  */
 static int acpi5;
 
+struct syndrome_array {
+	union {
+		u8	acpi_id[16];
+		u8	device_id[16];
+		u8	pcie_sbdf[16];
+		u8	vendor_id[16];
+	} comp_id;
+	union {
+		u8	proc_synd[16];
+		u8	mem_synd[16];
+		u8	pcie_synd[16];
+		u8	vendor_synd[16];
+	} comp_synd;
+};
+
+struct einjv2_extension_struct {
+	u32 length;
+	u16 revision;
+	u16 component_arr_count;
+	struct syndrome_array component_arr[] __counted_by(component_arr_count);
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
2.43.0


