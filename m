Return-Path: <linux-acpi+bounces-11915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E7A55B17
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568283B1661
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862D280414;
	Thu,  6 Mar 2025 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZSQtCSEE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C52803FF;
	Thu,  6 Mar 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304934; cv=fail; b=EDDCg+P5uH1H2kld1dpVSTDxRwpXbZ1XxpvRzAnWoXzk0jSyHKlIbLcUiz/u6KVDCUCzaEIP1NjjkN4Mw1tDwqA3PKx60KVVPeODJ+3zIdnMPWbFnoo578NIeBC72EDjxA01upsxFnFl5GwSFVy/9nj59YgUhOQSHZS7GQy1seA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304934; c=relaxed/simple;
	bh=zsSzYn7iPE25/PPmNA3qAMgUShVj7gB4A0ku7da0YOU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=du7NlGyFv1KWa2dA19paYwVVOlnu11CcY5odXrEQX5el5em1MoQq5vAvWojlY1Fbnnbl1uB/W7q3OJSgvI2fsKPvmJ/UbZyHtGdi3SVfrWm+fOnwFErCQ+vHa8pxQF6ivwLYMUlhOvTdWZsTSj//VUP9yBac3nDopoCO4ym5mkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZSQtCSEE; arc=fail smtp.client-ip=40.107.223.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuSziSdV/cBJJ7K+MyR20xucxy6w5xU6ZDeDqMjt+ilOfgzXfhCADKygQibiz5y6GTKBFHeYjo7kh4DZswVEQBQesVjDbQVoqASQHV3ua6CYzUqPOlrKBBHM2nhaIaL5ujIwCQsN0zaLct/PzdqN54pye3GjPhx4ZjQJKvZpFSAON3+ojyRBVNoMRqfRSrizZpCIrugUnRCxweIWhOY0FMBmczjFqKEKyE30uVGG8iM2FCPCacbch2qQYRcnp1n8DLAs28DmWXwdPbgugoqid0vJhWKD1DuDysbpS5qazTsf8VQ8yRo9Cqt/XU+y6FG1WeW/oRAqO9iql4AQsj1znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc7pltCS/egeR/FzqtWP9au9iX5g3im6t69uwJIBO9I=;
 b=rUlZYYXNRvBytk8r4gfcZJB0k1R2IkraYKTKVmVHUkstk+Tb9Up037HbovzB9QjBghqK/+KZ7/sR3Dq1khP4h2wYgSIwzP6Bk03JwobhivH8kdN21VKU+nn5HYX0WxPuI9AwmxfPte9Oi2oLkiAdQXBoCifYYMl2nWBksawSbbgAoC8wM7QlKhHk1a+3a8VkoRi/HCgAp3APKw5qt38845jUBto/4GqVXE5X81SQNz8VOKFXaQq1hiZ6EWNB3n3Ir4yjSD+SYpWJgOezg2Aaej/kO9raw2mG09AgyzmDNhV5rwvgckRostxBJjha900XmV3m9PRBn+N+u7bOpnV6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc7pltCS/egeR/FzqtWP9au9iX5g3im6t69uwJIBO9I=;
 b=ZSQtCSEEo579vBV1wrTMIIzAsN+1NG4gNP0437IKh4mP88JXWiGJRmcMt9K8ynWRwFxJM6+5rbZuCoHYY2qu13qK1zb3aT6UMIEapkNx/mtKyASfrjlWoqLvpnbmnwNGTdFURfI+03Qf9E8JRGZoYBcS0EvO1eWYJI1sKbp3h+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:49 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:49 +0000
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
Subject: [PATCH v4 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Thu,  6 Mar 2025 15:48:07 -0800
Message-Id: <20250306234810.75511-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DM4PR01MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b75a838-abfb-4b5e-2a73-08dd5d09712b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBl4Tw4xpbMgou0FXocsdINR54omSgDD9bDqj2GbWUTdWLE2T4SH1Tj0d8lP?=
 =?us-ascii?Q?e6bSWTH2edaDQkFHJi2FcNIU+0KvWi5Eo+o+HRtumvlIFTAKiRVhSbEqb+79?=
 =?us-ascii?Q?RNO64U6ik8fQgLHBGGBkHjJ3viCcAwnODf/nw6VYPPwPZicV3wl2n+Dtlm8L?=
 =?us-ascii?Q?SsR2RGLAL9Q4T58pS/fmv5WiZk2BM3DZ4sd3QWL4NuP7KVcscJ2S9uEvQoAw?=
 =?us-ascii?Q?fNFjMNRSnkg+lP/66ATphIvyqXgOdqMEYH0qRbRw0xZJUcwk3Po0N69ywR2k?=
 =?us-ascii?Q?Oyh1aes9sqz4rsbpmdsrv1MmAtuEwws5cY5GQ4T+2U+ohX11rmuVNkItrElh?=
 =?us-ascii?Q?X5ZIlm9Zzluojq/Q+utRw3OPw/w413UYBe7E/mfCBaWV+zaCEJXL33mj5aR2?=
 =?us-ascii?Q?jO0KkzTnnGWcGwiH6YS4sGmorWqaCsnBJUztip3FtLVj9aq/6LBy0ETS6XAG?=
 =?us-ascii?Q?gxsZIpHaY/SMqca0x+FUfkJoR06ahgV5WnHWQlC6ul9t0w7EWQmb2IJ2c4gY?=
 =?us-ascii?Q?spgOb1UtWOzSM8r/sY7zK/q2hAAVSoIrtasNpTBracFkXSiHNDRQt8hl2xYW?=
 =?us-ascii?Q?NgYM6h4q/I2inyeT5GFnQ/Wy72AqsuvOKV6nCb+RjXsTPkzSdwOZhCddfm4g?=
 =?us-ascii?Q?hSFdmnS2OwmoeuTpi7Tb74k8xAotkHUMasJUi9wOOmk4rSWPMEjjR4OhjW0W?=
 =?us-ascii?Q?R6Jxw0edUcZQt3JlArpL9hR0q4HzpVgtVkmYnA9D7LDFhubqFqH7Kv3Bsp0o?=
 =?us-ascii?Q?19l5+o4kOVBGVnqGyB8wM45NHDrr5J4onPmhRRdUnJrTsAUmLI6t7qb1Jkwk?=
 =?us-ascii?Q?ZroxWAQLbli0kL4mbtkzBcHGKOCstsj9oFSLh0/lZUX61vdI8GuMU3D0ZjlS?=
 =?us-ascii?Q?mkQPg2xmhOjPFsE8WJqXmlQB0J+NzgmwbTdpsTW7pEGRuptfMzpDsNUy9eT/?=
 =?us-ascii?Q?0Y7SvwBDByLzz/fhdc9/kSI0j5S1olZ6PbI0Jtaehv53wIlYAp5rkwb416Zl?=
 =?us-ascii?Q?1H1PIGXjDthvMbSLSsjbddVfwzpfZPiNKYt6x2r/5oTY8cCSqyInAY6/m/sy?=
 =?us-ascii?Q?8uU7VCy22G/z7jcSQQpClKR1tW7k7FRJnNtlRGIqmDFR9CrgNZ/R4Og0Qfdc?=
 =?us-ascii?Q?lzmH6B/H2gaP6aGdhoGg1Vh7NilCE+tALJIFCyd1VqMIEfzUsfaDQqWqmwby?=
 =?us-ascii?Q?eCkwhrHShrOLfNKkKVkMR2ZeaX7S8GYTfikVQIaWZaBzTeincfpdcmViB7BT?=
 =?us-ascii?Q?8LhLkMHe7AmpgxlXZDTUlRpyzsRhpNQYi6ztww1xKppvxtFHaprtNhLrY1Nk?=
 =?us-ascii?Q?t9SAtitu3vFFrdWDbUFpRO1fajTExYEg+2ooXg7c9mvS6J0XioViLbi7JCwy?=
 =?us-ascii?Q?vNNn9AFUUK7zWrcgyzCrFhWAXy87OygqMTLox7+kWRzgg0tWFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KpNYU096kMBzkMrbixtJaggcIDAhWJ86rf1uePKxHdAlEPx/I1TFTmNxJalR?=
 =?us-ascii?Q?ewsePBUikq6aiA3y70BUmDcJ33xYmMuRBVEMf9p7zvo4ECZwTGMQQQIFoVDc?=
 =?us-ascii?Q?MArFif1scDPuFgJCE4zKNXfC6p/8omXR8JvxkwUr8yLqxiXE1ZfrD9Zci8MC?=
 =?us-ascii?Q?aCgvuUKXzkKr2SMxqiIOEFq+FNUY5nGGxGEtICFqJMoD+QcaoTWm6GY6pzUA?=
 =?us-ascii?Q?+R6fVmCnBFpWk5r9JAjZxnPQaQrMy0auVIkKAbDiqdnwrbxDJrqUMBHF9pUp?=
 =?us-ascii?Q?8LzYROQoTpB2DGytEMzsp+cq7c82wUDe/0M+6tVRsqOupIfgGy5SZ0mh3vYp?=
 =?us-ascii?Q?9/mdrFotIquTAWe6d5ygraBjYI/AeMMkDL8IFGLCAY+Bhekn2CNXeObOJClR?=
 =?us-ascii?Q?wO2q9HUrgKlq/7Eff2PfqrRNniAiFbNosqszGq/Q0AlFb8vF5OboczLU1/pc?=
 =?us-ascii?Q?AlFYYzcdob55ShoeurNNcnp5rF5355GKeYajyzo8Mp26jdVS4HVDkAK5IaPO?=
 =?us-ascii?Q?zl5Tdf15e6niMqBhQPSuYBjzW+W8eMgSW7kajotbRgHX9w9l+M2VkrKR3sqK?=
 =?us-ascii?Q?vJ8s70ZzhATrorXHJ2pgOMfgtpoLzdC3DApP/IYqKc9STrqX0Mt7tmMnv/+V?=
 =?us-ascii?Q?7YXPwwZOWFW7+ZQaRIYaQ+545/BxB9N5+PnmkOe3MdILE2AmDXCsvjM+47CK?=
 =?us-ascii?Q?V/xQNfS3gwkj5nH/LvC0ERaj1B2W1Rp5NWSN84Fi188j8nzaNeikX3kI9OIX?=
 =?us-ascii?Q?3UEv68xkWUZ1xcJXzALPesR11QaYCNopp0W/3yr7/9P1OnPd9dGpHhUVerFU?=
 =?us-ascii?Q?GI2BHz4/xdt1XwZ0/s/qA9Ky3Cz84oYr7KjfY5IIbnc0qHJdsl0nrFPOGhDl?=
 =?us-ascii?Q?PF1IZF8yDxG/9DvrutjsdeTwFhmauF9IBhlF6bK0AVVtMGeAMamPOEfhyqHo?=
 =?us-ascii?Q?BBNRllBmvG7Y4WHVTZMYIcinMVxzflVZB5eoUhKijPA3sw7a/v0JqCK84dmB?=
 =?us-ascii?Q?w4kD14Cc10UukP7TaUwGnFhIdFi5axsFZl1fEMTfPvs7cX5YgKzFEx1AY9Mt?=
 =?us-ascii?Q?boXBRy3JTeJzK2IXyRg4L/P8F+22rah/ur5od96Y+WEvYcoQgwgTpqJ1O94m?=
 =?us-ascii?Q?WUONTkqh4lDByqFttidf8cspLqL+BZoRHri6YZAi+pzH34FQ15TMN4ufqnFJ?=
 =?us-ascii?Q?q/mBI/K76AjlS8DOoou9QeuLzWSDufxIl2bnqgO8ZZGXIRDFHAPjuPkmejJQ?=
 =?us-ascii?Q?ft/ajJpLF+b15edgHYmESAox8X6EIgfFPUTghTZEAa4r5UOXqjP5STY7/sHQ?=
 =?us-ascii?Q?owXsWUWST067gFQKJUPp5PEw8pZ2NAm/VL49odGzrIRgo+/MKmUxI/kJqWRr?=
 =?us-ascii?Q?otCTUX/QNxRZewFfnV8PfXyEu3kYTYGw9tT9IM1ZJeAWOwXUK6yOsuNVg4gI?=
 =?us-ascii?Q?MJqkprRpXylDe+sO+Ow3Achanr2M8o5BX33Gu6YStutqZukJJaK8UMCUdlAe?=
 =?us-ascii?Q?XrjGlnZkzpk5ecrShl8Z6ApETgq35lTlUCP4oDesmqQegEzel8s2moFJQvdW?=
 =?us-ascii?Q?UZa2C/YBuM7n7ks6hJtCVKftx7Phzs/GvQ8c7822TN/DP+d7g8uS7AovduMi?=
 =?us-ascii?Q?IFzUkS1Oax3s7B5032LwQGM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b75a838-abfb-4b5e-2a73-08dd5d09712b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:49.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UjUXNYHqlA9YeKh0DyHL9S8V/kOR+YvVHzEPCyETzEjmc0btlaQfuqRN2J5dssMKxN7p8rkx86HEZ2IFK96Y0wrlj14u3WwHrFJ7+teW1vHupdeuDVPXOof6VJ199aW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications(1) enables
EINJv2 by extending set_error_type_with_address struct.

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index aee9a7b17313..32b8d102f399 100644
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
2.46.0


