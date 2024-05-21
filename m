Return-Path: <linux-acpi+bounces-5926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9B8CB52F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3395B21ADB
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075214BFBC;
	Tue, 21 May 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eoO0kvF3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5014B943;
	Tue, 21 May 2024 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325870; cv=fail; b=q5M3dyQ/IyzUTVYASkodQHl3/kK9q3Rfsm9WESylE+FWSrzdLCHP8PtJLZZqOh0EsztauH+TNVg52brrnMW1MvSHy4thILzmrTbACQOCVmsx4M92oGWfPmu8FpYStvDaxgNIqzZfLnDDB9H09qvUXh5c8CKu1EMZQZeM73uSLAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325870; c=relaxed/simple;
	bh=+d5xcI0Ilcd8r/y7RedeJ9DnaU14cJBRP1qcbPJh0+E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCZyHcNtDOZjxlDg6qkmk/8xhvqupGW4eIvwKtY7KDlOJyPo94NPiTyhGvxryXh9t5KZqK2QCqn0CwzKtc2gyHxygWN1Tm/Og/HgLJLnQn0QQ41hkPwr1jgE6/iAuhEo+3SwJJ50+4bxwBN9WNHhW5e30K5cJkGsabAtQtBGsIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eoO0kvF3; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbhTIeCaWvoZDgkemAl2kKtyZXyfrpqgcxZSDCxTrLxdhBthUcxdGFA5sDaiJuxm8vPglf+3qoQqejZgiCk0mZywCM0I7NB4uenJF4/hiKlXZ+2+AsrX+lnZCUCTc1sZJaInHGtLPR7RuDRxUxHlVng7ttaThAASJHT7CjIgqq+/X98wnmXuuvWY/PfciJLlPjHlDKvuNJetfXjawGyqgJ7NDXMtSNb/jC+/nfrl1gXbKwbcei3PSH+U4EG9M8JzG/fYxTqkHNqoA8Gf5Kwtp/DsD8tJuPi9Q4i26ZX67GhKo2seJRuZBcFudP3kQEC9HYVhpoWhiz0aRIgidkcVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgCBw+/T2xaPa3/BxR5tMfRjnio5A7CpTBjc/NzfajE=;
 b=f+PchoNba5lf805oPEx6+COi9+EEgvKS15doFHgSYuvlw1IACL8QHdX2hH2Br56RLGN1TpHwGdXE07Uxo7rPR8YGx8tXiD6n773VcrW5hPsbiX0O0qsR5PP3oO61CscNe/YHHsbTiAkDOPfRaYMjGaAhvBVMn5t9s4kSXeLIsMTuu6lHNEoY8P7zgF/g8TeEwkw/ftXFMr+MXC2KIbs8GX2nzH7VX1eqv5+Vriq8a/js0LvMx81OnMhR1w45Oo7mfY3h0rM1+oT4B2bnjJsHPLKd+9ZLtgeoGOq75g4EU4zMWVnPSRhYqQA+ipgcFC1VMOrV1/zIltn59h4rD8TwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgCBw+/T2xaPa3/BxR5tMfRjnio5A7CpTBjc/NzfajE=;
 b=eoO0kvF3KJInwtbtKdGQWHBlBTy6Nk0CyiELXbR77GLOUVIA7pOijEaI3hs92dUJxLWNW6SGn+QEzs2lvdKHcRrOITGgEWGNJQ4nf+y21LF5pDmMdDAEAVf68spNmZLo5w5M6M/cQqhzqHjnel60jTazGfHmptRgpaBVdMFUmT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:11:01 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:11:01 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH v2 5/8] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Tue, 21 May 2024 14:10:33 -0700
Message-Id: <20240521211036.227674-6-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MW6PR01MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 80987ad7-2364-4a3b-d56c-08dc79da84b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rk4IqrF+5N3sfSXqen/W11x0Ostg3zszO7hIumErOsRnE9tK6fRsi3rQIJwM?=
 =?us-ascii?Q?Jjrr+2FB2BL5u999SMncf8+05R/D1p2ZkBWYKeoW8SpskI7r6XaI9NQzmU+W?=
 =?us-ascii?Q?6Uq6tH22Hzie9SbS/qzWOme2Dijd7zlTWXB8PL1oYM2akBjwGfRliR2jh4Fu?=
 =?us-ascii?Q?NEfxTsaSHxiBLsFhj+avd2+W8at+wx4ALVv+041dyjCQPocfNWPtS2cGAgNu?=
 =?us-ascii?Q?lGR6mUerclgPV2kCP4FtC3wmdcspw5SIIx7K9mXb8dLWWA+SlXevw5Vv0UOw?=
 =?us-ascii?Q?esqMBnDCe6U37u5swHRS1/8S+FEe9MyU61QyC08FxedJP4ZT5pppAyhUqyAH?=
 =?us-ascii?Q?90PNqdx1ko7HLfmW7VsSpF6UlhTy2QQ5sQfGE0ecUDDUdzEKJmUBFjGihP7Q?=
 =?us-ascii?Q?jPhRjtAYkOTwwHh4QTsVJhKiWsJaEnlwTJFkI3GRbJZzup0tQYHmyVk4DEuQ?=
 =?us-ascii?Q?aKXJEzE/QSJriGrc81RwKYxxzxcn1A0e0UWQhD7sQUQmfXCieTnFIfgucyJY?=
 =?us-ascii?Q?S6nq3Jl3mhObNvAhjq8CUT6zkkwxZNynMMTLE89gdxGAZCXbYOfZvKuLIwSv?=
 =?us-ascii?Q?RsFv5Nd3EDNoqSX1s8Wqdmvff51gfDRv0y2KA4kNWIdJ4Gc8lN4LzUIlnqUH?=
 =?us-ascii?Q?bGtkF6F98h6eminSORVvp9MJJbNf1Bpo3bbSiDuatJVISahWDCFCTE2wMNgG?=
 =?us-ascii?Q?k8W6xOrceInjf4mnKHR7RfXGv5pOQ3nnSaNd0t9khTG6c6qr3jrjjo9pIF3b?=
 =?us-ascii?Q?xqHNRwmyKE3hjBue/6ujMk9wyggfy/Ii/xzEWhVTPANLaZ52DoDWImtakgso?=
 =?us-ascii?Q?+13PIX2/a3lfG5P/sG3iNK4r1uLui3v38qCeQhyFEtaRbiBKuYc/yTXheSE8?=
 =?us-ascii?Q?yjM4FjxUtCM2r+KTKLTPl80A3s9RWYfHvVWsPDoYjucPAiQrRiUo9WtEbPZy?=
 =?us-ascii?Q?F3gS3IJE/icvDX98Ipqg31ayx4z8PL0CDpQ1gx17U4p28HIZ2vXzmXkTzXQh?=
 =?us-ascii?Q?iRYsBVXFdWALJPSTh1akzySy2M+xYVmI/27pl/kF0Iy6l1S43GZMR5ei6cPq?=
 =?us-ascii?Q?U2pdEFBQkkQJtRxXUffZzSUF613arh0AcbGCgUPcO3dUPhMrG25HMeyG/v+F?=
 =?us-ascii?Q?M0SoQhOgfT1JmhQJwnPzyyODMflUPXiadDmdNJzV7g3KKv18ERyuRv8+I3Gw?=
 =?us-ascii?Q?cNUNzZ7PCSrNZDCNMuzT/mLXDkYHRQc0z5noVC0UiIaLh5EUiZ5lfOurq6A4?=
 =?us-ascii?Q?Qj9VmakGMOiNrE4x/rF4Rku/I3EVo3SNV8OvtLGnvlrAYXw+IQPBCvrVD94d?=
 =?us-ascii?Q?QRQnhQPaW6SGXLf7FHnnGK3D6Lp4L+b+59J2d+rAtlsPOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ao6Bc9doaY8M2HelZoDYNuZgkz0DtQzj7P+iXldLYbM1IRMf4JpRhLLITf29?=
 =?us-ascii?Q?E7fAhXxeLgdiI/YMplewrhAgoSFBhm0d+WBzRx4gYBRykjDbaayK75updFtO?=
 =?us-ascii?Q?nVVQqVflhfK8njmUWhxJoQU3/PL3dp6qTn/q7S9GphcIjOqOO0apFug8qCBO?=
 =?us-ascii?Q?WqznxDL5yfz31mXJCUpTlDGSA6KJF4FA5SuSghjCWqnjMC4vYcJVCmqf/85y?=
 =?us-ascii?Q?v/qB4ijVqCcNmB1SRffg5oDsXjYNBS4Xz+n/vhJM9kA7mHMSpM98Cs202FZE?=
 =?us-ascii?Q?6pSPmkVl7iAWpjbJKwjEHwc59FEC0qADeheN2FAZB6pfEkckrPkgVurB/7au?=
 =?us-ascii?Q?4dl07tR0xbwmj4g6KYB3GdO/JfLaVB4bRFTGqiJYkfhHEeic1aay5bSoeWS+?=
 =?us-ascii?Q?CRVvAR+WR1s+r/TbcriS3YC+p3R5a1FX+tlrM5EqfyvmrLaK/RpDB1BJwUbC?=
 =?us-ascii?Q?5/bg1SwdU9UK5xak5AouD08XCAJKXg8lUMQvYpHQgxcvtJXPxyDWvF9TkndD?=
 =?us-ascii?Q?2CdVXxFO1Idxd7XVmFagfTX3FlYKYnaXzN1RzYSzwjXbVPpLrEO45EeJ3VC1?=
 =?us-ascii?Q?JllYzuMuw697mXnFsKKacyv/VMEPWmdCVBUIZ/DHesI0rzoCii29uopP/PgU?=
 =?us-ascii?Q?VaU5GFB6LPWi3jpU8UvPG9He5wlMRPoK/9spj0Wgu5ZbRe/xZbzcG8WGlnYJ?=
 =?us-ascii?Q?byzZV6sTlYvp8qLXJW4WvcJ1avqs+xiwUjFxRLoMKHNm6q2b74BMg7VqW8HJ?=
 =?us-ascii?Q?KB7QtFhziQb4YtJDTEnlM7gAvUMd+Dd13GHkHlQVJP/VZ1x2AjhMDX0981HB?=
 =?us-ascii?Q?vbLQTX226ileJq+fEbu9Qzswj0sPWS07xJTgOel9F/x4uNlcaScPSqqzFw7i?=
 =?us-ascii?Q?dNnYctb8tpPwqiBh2IUg1Q9Gf2nlPaJOPOQDa3DLC6oKgQyiVVBFnCDbMabh?=
 =?us-ascii?Q?Agk1tbJkPmM6l0JhJoWuO+P33LWNqLRpO66Tr0p/npdphjR7qLxP9HfuEHOx?=
 =?us-ascii?Q?KLw58a10DiZ6k7bAPeTxnNaGdTVGcqZcVM/IU5M8qfn9VUFjJXXXhFAiD7FV?=
 =?us-ascii?Q?zZIoA6Xjlld9+LRHIJU6+kCU6yjB1rxso5NNS4qwHANUlZD0RyXY4pWg+3fd?=
 =?us-ascii?Q?K2SYIsAe7CYPR7vgHoDUgh+Ox/d/A5V8Ytrzhfq9ADeh1ZUv3NdBV2thgTcS?=
 =?us-ascii?Q?5pH+Zad0DGpOxva/F07RlawwIjWPKGqDS0Pc/0+kd991swlfxP2Flvs+V1U1?=
 =?us-ascii?Q?CDw7p0OE85MQCY8ADKVEdyKmvcShfdKe+z5fIxYWplKGBN8bsC7cuDoTOoOK?=
 =?us-ascii?Q?hxnhnIT8PqX1iOL4Eq/Z4Yr662T1kqLo6R+x9vPa3FrP2YX7Gn7Yn9hBcvt1?=
 =?us-ascii?Q?pl/VGCOAD66Ca3t0wb90skMCs7oOzkBmsh3FcfLPC5qEsgwJwdjk+gnjZLys?=
 =?us-ascii?Q?ClfFB+A3V7L7UsVERj6cbYaSXXXthTTOo2mJgWxpjGwlp+G1g1iiPvVTtIR3?=
 =?us-ascii?Q?5rxdE9vaUHqxxL/xHkP56UmuzUrQvbTseWjUhXVU/nuiFr3kqeudcD65wBMM?=
 =?us-ascii?Q?AiHixg5v0wM283rrgV6+XjSa0L1ZZu+1GT93dJ/AiEZq/ubQdExo+zrQZ8mF?=
 =?us-ascii?Q?sHLrjhbOY5J8KPqa4LnhEe0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80987ad7-2364-4a3b-d56c-08dc79da84b8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:11:01.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBRbTqLiE9GNfFLOLmxeg1gN3vllAYwVvC+b2ID1K6F//GI8lg0wrINKEmrD3Oji+pHLPNWksHi5x+jhL9EyFQk4FqXz9z4aepij72+IQPyiSkJ2sKGPsgQHUhBRf2S+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications(1) enables
EINJv2 by extending set_error_type_with_address strcut.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index cc5ad1f45ea4..2021bea02996 100644
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
+		u8	fru_id[16];
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
+	struct einjv2_extension_struct einjv2_struct;
 };
 enum {
 	SETWA_FLAGS_APICID = 1,
-- 
2.34.1


