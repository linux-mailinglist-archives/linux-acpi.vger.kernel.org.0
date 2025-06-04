Return-Path: <linux-acpi+bounces-14141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C966ACE6B3
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF643A8732
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD223372E;
	Wed,  4 Jun 2025 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aAqcw5B7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021134.outbound.protection.outlook.com [40.93.199.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A017215075;
	Wed,  4 Jun 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076707; cv=fail; b=STOzBFdlxh1rnWA8n/JB2Pb1bU/Mh4lyU8V54bFUSgGDYsKXJhuil9q95HSHyISCODrGxoiZOKvsRNzCDq5N1A8Moa7QKiO8FGkva2CfDFCVyxLAc8hr/JKVq0lciT7cmoCtO6Gs4fUjxxV3UoRbBhYzS0rXTJjbL/vf8HPCwUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076707; c=relaxed/simple;
	bh=MY7zhydBwQr5OVoF6PEWuCZ6Hb4iig1+gq0FON0GARg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2hs+PceLI5QZN1/OTi+MJGHT6CDmJ71eFPVVLmDit9GZhpvI5bEaV7j0PGczRmQGVLD5jg7D6z52BsokqKRS66yP6/ex9gufuJPAikCpuiGClbM1ukhklmecMgB1A8jMIo9KYdvAykNpsorLaZ1cv/hHbL3EQubFb89An1Puj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aAqcw5B7; arc=fail smtp.client-ip=40.93.199.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5NmlJA4gA5Xfxt7nel8lFubPNzGlCt8I0DDDjYVCYa9LAOKI4OlpZPu1Xg+DalJ9P4aQ2qz/UrTQM7s5IDB96GxVSOTFvnIgmlGbwEAHxsXju4+ItVVxq4uYvarY/MxNyslTQUMAg9YFeJnP8KnLDW7eEqeq4SxE+uVNnzuuQmb7o6Ozku3N0u0aXdmWhBdlxhwGh0juCiEhSC0JDVGdQJ7YDeMO8MvIxA/rFQD1DS+avY+Z8vkviz2N/xJ5IT3TEZhifl+2EBE+YkAprcLW88n1csztCSQaIylZsu0NMOBr4n8pmi1SyFfhjTRDH72/sd8/SBEU2MJi2jjbxD0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqzwdDBv/ypc4ImH4iMG1Y3qlSrvinZHmdtYUIt+6HE=;
 b=sGqixeh7KTOKxLPTrz4i0jD3s9f+k43CEYB099NSZYdZGFoqgynvENxWCJSdMmBZGAD3YOfoHwa6UUHf9MdmRZLh/AJFhFrIXT9WYVC7VLOolZzZVkN6Ewzi9pwqhXCrWIZKoH7UkD19wjLUBYxMhajD8wpswpKZFGh3p/fuEJecT8xBuKQlhFag6KI2AMaaWdIf0uDIK+GaQ8/PnvB2Y85Q6cVxpwUN66r0pzFF3zfTx10Zd55zNgXSyEjm1aAVEDacceEuV8H2kVoktn2rkhXzJFfv6MKRQZ6eu6dDp0+8mmVChUsZWUz9tilKIUe4kDEIzUyot8/vRwoQ3A+rdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqzwdDBv/ypc4ImH4iMG1Y3qlSrvinZHmdtYUIt+6HE=;
 b=aAqcw5B7LDOZJuotiZuX6Tdace8fwsVJmr7LwgyoI9BjZFfrn8HASmlYGsEyb1NUUvlXNbd82TE2lAwFYiBYMWCy4E5dBAnRFj9Q8d1RMVNyJbXSZDnRenfVDIbS8adYiu04Ie607WW5lS6uivqIicr0cl1Aay/b11XUmGMtR30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 CH7PR01MB8810.prod.exchangelabs.com (2603:10b6:610:24a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Wed, 4 Jun 2025 22:38:23 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:22 +0000
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
Subject: [PATCH v8 3/7] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Wed,  4 Jun 2025 15:38:00 -0700
Message-ID: <20250604223804.842501-4-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|CH7PR01MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 990efeba-1cb1-401b-6207-08dda3b88345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oDfPlmXLJF4wYgnAxFfi28l9Hq5WCDt6MbMsiJ2mGlvHkJScWyKR37wkaH2L?=
 =?us-ascii?Q?tYyGG+0pqr6nhXvM9Hg2Nl4JYEhdtdmewdTmHHr6JeRVx9V46AQn8U9P01yy?=
 =?us-ascii?Q?qlN1P6qG+SPC1cJ1EJtpo7yYpN0x2VEAIS60MXO5A2eO7Uu0GLu8aqfn5nER?=
 =?us-ascii?Q?RchqA7wrt8dOKN71+tGU6Z1SpiVn8YZuLAXeaCduXQ12QMPT0YAmZXgG/dqJ?=
 =?us-ascii?Q?Dp71AJSTLw0HhRnRphfTIO+hRe7SvxxUwvfPK++ocCfnv8SlpY4H3LOQIl++?=
 =?us-ascii?Q?C762bMtFajlLPknUbgk0GJ+A2fm8FUpQIwbxiHzPIai0e/KT4QG2M7oReDPa?=
 =?us-ascii?Q?+H6ZdQgaiex+CqiwOU52cOBmHihFx5DlPZ4rXThUy5iBEfnwm2gmWi5JKHoF?=
 =?us-ascii?Q?aqGW/hhpTLclCZpkGc/DBV+Zo074efbqB77o3P/vjNM5lo8v6lmHVuWVnWqr?=
 =?us-ascii?Q?Qp9JCkeHL0vGi7j7QL/Csrcx4R1byJIH/xN8kORMbkSyPtmZc4ajSo0fSbcX?=
 =?us-ascii?Q?7H9IwQCQpyRqqLh08IvjlgCf+qNE9Wp2o9KaQPY5u9gYjpK5KoFAz5yKDD58?=
 =?us-ascii?Q?xeyD75yTAlozs942k3V/EjZS+y1xSrmQQcDf4GkwVPWab6k6Gd0lzSKJmuDi?=
 =?us-ascii?Q?R1owPoCYEv2NjJiptJLXbYHstkQla5YayOnYVwG5cbgwoQy1Fr3AAgb5rDtn?=
 =?us-ascii?Q?nqq2J9P+s9ybgyqc/sr0EZ2gShP8OhDepZog6cANVQ9F3ypaJmnOkQuAIO8x?=
 =?us-ascii?Q?02+24PgaG0Ue8FPA84JZXKyHrUx1QndmnsE2yKMhZR5wdbrh8ntXEIc7sBPm?=
 =?us-ascii?Q?/W2hFgMGesHj+4HOVNzb2CqHVGgvTAlbcL02kECgfWRAnlSBqRXsO1GNiG3v?=
 =?us-ascii?Q?Y7aHfmFkci32dKySA85xe7pZpauoQ29XJ0BkCNKpDPSu4wpSB6kiQKwffAeE?=
 =?us-ascii?Q?XyX/o/Vp/K9zoqqyk8Y6MRPTRjlWa6Ej7DZIzNr5DkV93wabCwPqpy5q5n/z?=
 =?us-ascii?Q?YLdg9fz1n59Adjv9Y87QsuFTkZqOeQo0HxI8Ns4OcaYAMiIvYcXZS8SYjGB/?=
 =?us-ascii?Q?5RKajYvyjQiS40+OsUmR5t18tyyqX0AZQOlGvIiJ4oVCb4qYOqss/ZPQfocT?=
 =?us-ascii?Q?cgR5u0QHALm34nhMXKL5XcJlRYpUzJNfolSCz8a+B+iwgtF3fjqvLHshqN+O?=
 =?us-ascii?Q?AEhHn/2EgOdwdNTs/Hw2iAHR0MebQACtRqCgq/TBXuDYsXRbi7X9ccjDF5Gc?=
 =?us-ascii?Q?uS07flF07caode6mT5xzcQiCqSe/Dny7nNPulc25wxxYdBIzrHdCUlhNtoru?=
 =?us-ascii?Q?9E5SXGjEuLfRFFJDyNwrls0UlVrZq2DUsJBRMl1WjUrxf3dPTrKdj6WDzBJB?=
 =?us-ascii?Q?CDgz/4X8NYI6MVNImJuWzYNUgE7yjW8yEneeeL8tSZiy0Vc8BpZyH6V91Qmk?=
 =?us-ascii?Q?9YOxZsohaN2dgPqiJVBV12YLfVT37Mvi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CathWYdqWtqCeJsBO5qmv2257UGzEzSIS67OTp76L6zRBLEV+T/x/TKaL6j?=
 =?us-ascii?Q?vBgkeFEF/XIh6iFDJQCkrp8aTRMRppeGn8N1bR9WSWxG0nXJF0BDCVLf4gOy?=
 =?us-ascii?Q?ojmmWnJG4quUjRwuthd4s/2BG8TrIA9qEopcePs0MKy+gyZsyYglR6B1CP7C?=
 =?us-ascii?Q?Cgosd8r+zwgKVCo48JVWqrmiUb//zroqrmn98XY3R3YQz8LDsUKtD6Onc0uG?=
 =?us-ascii?Q?uN8HB9dJYyptVbi4rH3ehoeo1oIc2t6d7fGs1ZsQS/W2KNXKJPztENLwVOL4?=
 =?us-ascii?Q?dIuq8UgaQNjmPgEIWYVoXNDRAq1FvOUJfNYmBSscj6T2/CFsmqJQY1vqpVWw?=
 =?us-ascii?Q?jbub3DeunckEeyA4azfn/pxv0r4myVz9rY1o3qobRqdNb926KgI9rkKcLOs2?=
 =?us-ascii?Q?NAgwzjKUofjaO/F5CTbtZwlWS2Jf1Jx5TZWZvdy2S8xpZIjYRfqSPASOHo3/?=
 =?us-ascii?Q?cgzyZatusv+Whk8SAhxrZ7laa0Ovk5/93ssgEC2v44ntTAe4SGwVCmBsdbZC?=
 =?us-ascii?Q?dSnPHgFRRNsfIKGCZBjERN3OXnm6Jkh9JHxtf2blOJ3pVwILE8e2FQs76N4A?=
 =?us-ascii?Q?Ova1S4Ad71zGKQ/cqVKCak4BhPOIMO6c1NlVtzfDkG+sanyWFII35xxBziVe?=
 =?us-ascii?Q?z2rF9NnNOn2tkL7+FyxlvrO9c/Aq1VzZ2gedvv+N1iGKVtHvCnFubFNn0sJt?=
 =?us-ascii?Q?DoYyqKr2vhvsvyv43HJmVj5egV8f8xSLvhYLKVrDc0odRfpUjkyOcdYfah7Y?=
 =?us-ascii?Q?a7u7b5UDjBmqaUg0OjYTT2mdVPM/dU/iseVgNHEzRQzJUfO+QwNL7VQWtS35?=
 =?us-ascii?Q?EAK0GUBNM9mOZsNMRx/DfcMjuUj5as2G2flE0R/IMo77fyIsM9/Ln84rvvjY?=
 =?us-ascii?Q?eYu92Lx0nUn3WiJ9GDSQjLFNyCLTajz6VNSJMZAlTvLVpgNSFSnbcd13EGE1?=
 =?us-ascii?Q?UGoImEzbEcuXlfLf7CM/y9FYW14lhh1/Y/Fxmq3f+LFY6lMe701MJCzuPHkT?=
 =?us-ascii?Q?PPeyXqZrIWkWU48+UbY5NGGWI3x6bjBmgyaE4QeBwlACOIE6cwkzDuuUy4xL?=
 =?us-ascii?Q?422BqWyyYUND4a/8VMPsBa6Myq0lzQIlpaPIrGCG76t0JyUMPV1k8C+ohNPx?=
 =?us-ascii?Q?cJvc+hCDPq36SPTL3nkbszZGznFWyI3thoLvdM6yNmbMRXcnYDYWWjlELgMo?=
 =?us-ascii?Q?PzRyL1qHr84SonSTDbCI+yKTTTQ4PGgGPH1ieoCtt46/fhlO5gY0xwqpNeLe?=
 =?us-ascii?Q?sBNvvCMChsIbJ0Uxs2TcLpHbl/dR0tUFfwXE31gXrtkV1LRN8QaCvFOz5rxy?=
 =?us-ascii?Q?rRRSrQ3eB1F2W/XHpoLxZEHP29xD2rc0CGM7Fzvm8dtKHG84ss3+joobuwl6?=
 =?us-ascii?Q?AvRjosmOf/x9htOVCsEx2zTwygEBaKJElGHFdwUi7Wp2YtZe8irIhG5wE+WF?=
 =?us-ascii?Q?HNMVIKCxR7J1dU0GaVhbImqE2n5gMbMUl5TzqiizWHiZDtT4FO+PocZHfFfv?=
 =?us-ascii?Q?+fSKaFYnNGPkyGeL1z5/tg+O54e2uqTUDpn+hUZixlEi6d6cW2AWc6JIV6Jo?=
 =?us-ascii?Q?rfxA+UWdLJhE5k/gOFOnUx1ApaI5RuPq6zEyOkXRz7kJs/zVTHhKJ7DB0hBx?=
 =?us-ascii?Q?6ldHDaVdWW0mVmDAXTPInao=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990efeba-1cb1-401b-6207-08dda3b88345
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:22.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+M/+xa4fLGsQbAeFubMxfd6TO7LbQHvI/vdgfK5kXrIea51PORitP00sHOQ9kjB6DB1VwldkK1iFaeyw9X5PP0Rtil8zK8Zxou3RrojBt9ukwJbf5lp1RvIH6bmku1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8810

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications[1] enables
EINJv2 by extending set_error_type_with_address struct.

Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#einjv2-extension-structure [1]

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
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


