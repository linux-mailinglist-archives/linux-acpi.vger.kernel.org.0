Return-Path: <linux-acpi+bounces-14424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8329BADDC56
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267494A08B8
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A82EE99B;
	Tue, 17 Jun 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NImDP1Rb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13412EE97D;
	Tue, 17 Jun 2025 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188655; cv=fail; b=aFJurrBGZkZ4LxVuzWd1ubsV2QemW+tDdvZO5PNa2VWcJOftq90+F2WKU7OKKJ/ArX+Tkkn6e9K3EBp0XvjIXrulzcwfPodXhqxPF4E3ALRTzQBfkBPjywZXwpTEO4w8Q5izisw/G+aBKVZP4VJFuPvPOucEWmvmjOVXLnepgzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188655; c=relaxed/simple;
	bh=r10Is6OKg6w1iFphxGRpn1SZm+Tp4uPu8AKrJn2O+kU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjgGIPuhPGte1jnmniZzFFxAvwVMizN+BbRiaKmimPsr6KrCNOnwl3P6Al3EaS4fwOx+Vy/pSRpgg4giai6vaQMMPzAJ4e9VgakekQHSiFDnW0MjKjgu7MkgDWhtmo2iZ9q4BMrhFHt/T/rczQFx8RnqyWHkQBJ4iWFwgpqyv5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NImDP1Rb; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqbpePbIobnTnKoh5426CBOzLMuuuYtWNAKNdh0pAlKsk+WfNpX0+uJilKyzY9CAwaCUbwHxe3168aoiSGePtQQq7B7nxodbo174lEHPlUyyRra5lqaqkhe3F8J12paXcvKoYa5DrGheiECLa5KKBULo4ZPTX0Aveh0NqRJ2KMtIeorl194Cu1ydJQOlNBl+U3RnLD8dQ/BoUIPxCk0qiOiUZ4c14OjRdQhBehg9elgNktq73gI3/GriPfDgK7zUPQRMKeQFkIyQ77NXi9A9btbUoJCP6JDY+sYweMAN+RMQjZ+9FOB3DMMe0XQKFACayGu2Eobr3mPJqinepzoYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEQ64DogGe7zApRNjYrHuC1t0WBVDourq3EyWpLopn4=;
 b=sTdXPTXvA1KdXMzVnXt4yrkNe6HdOgy7I6ANce3r6SU3KgUQGL6yf+jBBHdMyx2lUXUjrgiHvcNDFPXCNRNCFkvFKxIIgTPrQo8V58gzFnTFUC3hxDzbypR7r6vDszFD1Kiox7uZmFxf5l/N8Z1BdaS9XS5sqeIjvDOjSJZYwX33D0WwGUs7paucWshdbCgbuAt54qXU8sF7k4mzQv12A46cwD0INfwZRKV25yWWD4LGDO7tvSpC9I0ZoyuKBNMn4U5D1dt/3fW4ZXH0Q6Xig4NIWOjXobi9pp3ZsO0v2jKA0ncKd0KTqrssRBLcqtlBLHjeOzSaV+MqjWfUWee6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEQ64DogGe7zApRNjYrHuC1t0WBVDourq3EyWpLopn4=;
 b=NImDP1RbnlzumTu90YrTgvuhvS8OS7ByZjfA8Spk8phb+/N/rbsZzdM5OUCO6xkmWXtGiHkVFFxOIhe4AzKAQLNH9zZkccKi9gCNyWfe3KI4s8AqTc/Hw91IB/3Zm+OOOrFZdenWRVtFo31JmB451Unhkv9FNwHxLKEKj0zGD8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:51 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:51 +0000
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
Subject: [PATCH v10 5/7] ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome
Date: Tue, 17 Jun 2025 12:30:24 -0700
Message-ID: <20250617193026.637510-6-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cc2c9dd-4638-404b-0d10-08ddadd5782c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y/BeE1ViGTU64vhKrKNU6xKlNNBw++TtagG8qY57RYSONQfK77HlGvQxKrmZ?=
 =?us-ascii?Q?KPhRRfAOEayYccpjJbxnWTRTLpaakmaC04QA/rmxBoLS3uw+MWVoOPwHxPJC?=
 =?us-ascii?Q?iiTeEz50BsvzwAOWycADyd8C81pF5ztNLmdpUoVOXNxgREAKdOgmBDuS+7BW?=
 =?us-ascii?Q?r4BwwxhhXQy55FQU5SV11rMDhZctmjK5qMgvaLsI8A8y1nddAl4JKXcd2uUd?=
 =?us-ascii?Q?SJrdMk3Q416WGSqOTeFbzZPUsN6sDCYgm/2BHGKVC3NIZymkMbsaklWfabIR?=
 =?us-ascii?Q?87Z5Pon8aYGMz+2RQHj8MYBh7wdcpMrlLdu3FoHAsdDMVpmXEr929hnRA31z?=
 =?us-ascii?Q?Mg/CcVbHBTkWUhV/16CH9WMeNw8GrYC8g370z0wPVZ8kyJc4K45/yTGuyQtc?=
 =?us-ascii?Q?6aGq2oWCZ6+U817ogtosF/u4M7T7V/1mdtfl9wtcKp8I1+GfOJpHmITdajIL?=
 =?us-ascii?Q?DZrAWWaGAl+VQc8ORv46dcF6fLmk5g0qsbuptzYzcztnjvRyjpjrW8PrKWxs?=
 =?us-ascii?Q?wCr7Li6G5Ss71ClmnkRIDplem+EraH/Ulisdd34OgY+G0UEHjsJ26ORGPH3j?=
 =?us-ascii?Q?BgZ5OrKRdHtvaFUtt/1qXMhekMJUQIW0cXaX1Sc164qv3m/r6YR7jvyYlVPo?=
 =?us-ascii?Q?4UTGbQPwqKQ2XKkyXwMHT4bzDTmIsfjI7RAIeLKkE33o3zXfwVk3EwHvESLK?=
 =?us-ascii?Q?7vxA+ILPVpRyI/4Auz/8uTWgwT2iItW9I5o39zSqqQ5c02omaw69ZXmYKNHi?=
 =?us-ascii?Q?FBMq122ud2jibllNAeh7tyrIksQwpkZz0aCc4CPXiCaX2CEzsceoWYtbFPDe?=
 =?us-ascii?Q?HoTFpamAwwpHALku/1vMsp3oH+cYGWWw0HLRAnKtuEwvrIULRe1yJvK5g9XD?=
 =?us-ascii?Q?uw4UNhMMeFDeSixjV8+YLnUC7DST7Rez/wJYAF1EakO8HawUMsns7odCWKk0?=
 =?us-ascii?Q?NeV95UNgJtsD3LoB9WiVr8RLX4G0i7VbqH+BFGdf0JuN3HEVPn+L2Mc1ytbD?=
 =?us-ascii?Q?3SexFSfJYijZvoCyi2bhotxyXXvRZi9tXuGN+pjcMM08kLqm9nd9mikc8I42?=
 =?us-ascii?Q?MFhg4zrUPFH7Gm98WlX3f5CUQGfTH3bFkVhq1SbaKG1pwml4ngzhv9/jlBk8?=
 =?us-ascii?Q?Ii+oCpzTNd/aWevaDgpv3BUhikdVTk+mZbiiJx5FUH7VfSEMPkiPy2UbIv3b?=
 =?us-ascii?Q?apGE1545uClBh3kBx04v9dP5XTaZr4OUNAX3Rxexd0VdQUFcfh5tpaCp2hGv?=
 =?us-ascii?Q?Mh992vqLCEZKQOsh+QAVOZ//jnTyuPS5XZM5nRE0ynm6v5luzHDJ6toReOiQ?=
 =?us-ascii?Q?oADeGeKyQhvMPAsXswy2ogOADMZRt63FLKEYj4vPofCXhV9fZMaVSI5o+GvY?=
 =?us-ascii?Q?MjqhKBEqhqt/sGJReFYjaSnFESR97qYAygy0iCi5IOJGfclfrxAWPc7Y5Ydv?=
 =?us-ascii?Q?PBjMvUJuTMNOjCmQyDV2WoyzDitP/vNgBR7UJoxMLiQ11MOGuuNomVH9oX6u?=
 =?us-ascii?Q?PUwruilsBhgZoKM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XAZ+iuXwtONG0KFUS91jgir4blLDn6rp/Dimgp7jZVXcMBUSXcvat63F14rG?=
 =?us-ascii?Q?rszUbmWabVVA4DD5p9/ELOrskP3QicWJ5XTKvognBKa8bDeCPLgO0qyDuaZV?=
 =?us-ascii?Q?dLUPP5rKLzoQi1psnYmuAwbT+Duiqo3IEKYuOL9r/EUEFGc7ultjEo4kgSo/?=
 =?us-ascii?Q?o2RkCTCVjbhlRuyg1W/cIz5IgaBKAZuFoZ6mJYPBi5DyBoL8E1kUFC806hVg?=
 =?us-ascii?Q?eDPWiD1n4KKBhqfJfJvzVw38SquTcn7D0nbTYnzILpbiGh0TWJyJHShJzXNK?=
 =?us-ascii?Q?3GqPf/gre55bAvOCqhRu+RCFCk7geT6KsSdCiN49gjGFIqU87pivrVlY2TH3?=
 =?us-ascii?Q?dw75EL4Zd0k6sryBpCNKzeS1JvN+sMre9Wuj7D3H+Vz+Y7PuyUd7Y0h4rvUg?=
 =?us-ascii?Q?IB1KBPSdLHFRvjKuNJpGyMevaFFtTMaaDbI/YuKm+C1ZN1V9LvmzjZ+ztMAV?=
 =?us-ascii?Q?4dVhhgvLptNIr4fWlvCIaJwiFyN9VaMrp/c7+Im7i219jXTkxu3PC2jqV+fY?=
 =?us-ascii?Q?6+X64+DXXhTEVbDuvrNwiyUNIJIGeeP3gEjp+SxLyFrhEDub2byc5ZZfv9La?=
 =?us-ascii?Q?Klt5XXM/wlpv/5276yesaKi+3y0KlxBVIy3UushBYU33kTWeK0HnsjHP71x5?=
 =?us-ascii?Q?Efh3RZsEWZzJzLpjXJYlBo6Sqd05+keQxY9h5G9gUIwSSZSaqopQWWy5I8di?=
 =?us-ascii?Q?MB2IchicCgs9cmzE1bZhpEBmVeNphW3lLr509BMqGWzo857UP957usJjQ4BX?=
 =?us-ascii?Q?h0PdUPfMiZSXIFFru8xpL31X0laLOGzp/GcYhunSRGRGbMm0fT0PCL3imf2t?=
 =?us-ascii?Q?S9dD3NUZWBqyNeyReXDIw5n0BXmGyIrmj0/W8pDL8wRXfmJ+ZzH/BSTlRNw4?=
 =?us-ascii?Q?nDHWJ8/D8QRqlAb60G9ttZ/SgNcrOIkTE+SC31xEmjinUDiFIJh77YJwjTpN?=
 =?us-ascii?Q?HbCcvlE3s3UxOuQUBhOBfAAcg8yT5LrI0X01wCXwFgZ2u3adbcPOXFvonziq?=
 =?us-ascii?Q?S1pz9WQjS/mBCC0jOrdQlGGgeb4mRKAJnWHAOanlnZNcB9mZm4xjmC7ebMEV?=
 =?us-ascii?Q?m9PlMJxw7SOP26GqyDTbHLKNQIkwJHLcnl29l72LZtAboEiDkSavNNsm85A4?=
 =?us-ascii?Q?oC3KoLj4Lv6c+pircORv2YNVRPRHV0h0wLqwfSo793weJG2+cSlvASfw6KJs?=
 =?us-ascii?Q?6X1+Sj06z4ayLTDIhj0Ot2f0tqSp17K5reG+9MfI7ePzoPDxqA7xEyogVy8o?=
 =?us-ascii?Q?EUAyKdrNoeFNHmg/2CT2Feyum4A2hQKT6CxhRajdj+3eXNuBzzdU2S+LATU3?=
 =?us-ascii?Q?qUC+YnR37cj3CHQFJtdnZVJHNUroZXMcsrQ1+5+c9uVXQ8fhWPLyuouiG2nr?=
 =?us-ascii?Q?LvIZMInWknlZEP9LQu826hAWZpFLU1uXG/51SnNurDW8j90T4L0eOMeTrjZw?=
 =?us-ascii?Q?Al79yEHXuVrXRfLj8UpYOwzR7VujFPgrC20GVvQab5pZwRHv4u8C08U0xuAc?=
 =?us-ascii?Q?Sq6YZ3pK8+xrwFUrTCKxfwp7uccfvheP0WwPKXLpFEj/aoRNq43bpxpM39SP?=
 =?us-ascii?Q?16ohOkhRe/W+jZsJ15v5Ad6MlJILePevV5jn8jrZGKELozDFMQMhPdF14mvy?=
 =?us-ascii?Q?Yvi9In81Isi4E2s5xr/lrDs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc2c9dd-4638-404b-0d10-08ddadd5782c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:51.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI4kmV73bJQlDYoc9fx3T0TfJ8uGZcsiHroh4rkkFWGLiW45w1vUSZsqwYz4KLtwGQc2IKBNnm+BFB4fN+M+d60ec5jmATqcQZlKG9SVNoAnuiNIYLUENU8/85Awv6Ml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

From: Tony Luck <tony.luck@intel.com>

EINJv2 allows users to inject multiple errors at the same time by
specifying the device id and syndrome bits for each error in a flex
array.

Create files in the einj debugfs directory to enter data for each
device id and syndrome value. Note that the specification says these
are 128-bit little-endian values. Linux doesn't have a handy helper
to manage objects of this type.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 97 +++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index ea6fd4343e63..87f1b8718387 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -111,6 +111,7 @@ static char vendor_dev[64];
 static u32 max_nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
+static struct syndrome_array *syndrome_data;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -712,6 +713,7 @@ static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
 static char einj_buf[32];
+static bool einj_v2_enabled;
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -848,6 +850,98 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
+static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
+{
+	char output[2 * COMPONENT_LEN + 1];
+	u8 *data = f->f_inode->i_private;
+	int i;
+
+	if (*off >= sizeof(output))
+		return 0;
+
+	for (i = 0; i < COMPONENT_LEN; i++)
+		sprintf(output + 2 * i, "%.02x", data[COMPONENT_LEN - i - 1]);
+	output[2 * COMPONENT_LEN] = '\n';
+
+	return simple_read_from_buffer(buf, count, off, output, sizeof(output));
+}
+
+static ssize_t u128_write(struct file *f, const char __user *buf, size_t count, loff_t *off)
+{
+	char input[2 + 2 * COMPONENT_LEN + 2];
+	u8 *save = f->f_inode->i_private;
+	u8 tmp[COMPONENT_LEN];
+	char byte[3] = {};
+	char *s, *e;
+	size_t c;
+	long val;
+	int i;
+
+	/* Require that user supply whole input line in one write(2) syscall */
+	if (*off)
+		return -EINVAL;
+
+	c = simple_write_to_buffer(input, sizeof(input), off, buf, count);
+	if (c < 0)
+		return c;
+
+	if (c < 1 || input[c - 1] != '\n')
+		return -EINVAL;
+
+	/* Empty line means invalidate this entry */
+	if (c == 1) {
+		memset(save, 0xff, COMPONENT_LEN);
+		return c;
+	}
+
+	if (input[0] == '0' && (input[1] == 'x' || input[1] == 'X'))
+		s = input + 2;
+	else
+		s = input;
+	e = input + c - 1;
+
+	for (i = 0; i < COMPONENT_LEN; i++) {
+		byte[1] = *--e;
+		byte[0] = e > s ? *--e : '0';
+		if (kstrtol(byte, 16, &val))
+			return -EINVAL;
+		tmp[i] = val;
+		if (e <= s)
+			break;
+	}
+	while (++i < COMPONENT_LEN)
+		tmp[i] = 0;
+
+	memcpy(save, tmp, COMPONENT_LEN);
+
+	return c;
+}
+
+static const struct file_operations u128_fops = {
+	.read	= u128_read,
+	.write	= u128_write,
+};
+
+static bool setup_einjv2_component_files(void)
+{
+	char name[32];
+
+	syndrome_data = kcalloc(max_nr_components, sizeof(syndrome_data[0]), GFP_KERNEL);
+	if (!syndrome_data)
+		return false;
+
+	for (int i = 0; i < max_nr_components; i++) {
+		sprintf(name, "component_id%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_id, &u128_fops);
+		sprintf(name, "component_syndrome%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_synd, &u128_fops);
+	}
+
+	return true;
+}
+
 static int __init einj_probe(struct faux_device *fdev)
 {
 	int rc;
@@ -919,6 +1013,8 @@ static int __init einj_probe(struct faux_device *fdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP)
+			einj_v2_enabled = setup_einjv2_component_files();
 	}
 
 	if (vendor_dev[0]) {
@@ -967,6 +1063,7 @@ static void __exit einj_remove(struct faux_device *fdev)
 	apei_resources_release(&einj_resources);
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
+	kfree(syndrome_data);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
-- 
2.43.0


