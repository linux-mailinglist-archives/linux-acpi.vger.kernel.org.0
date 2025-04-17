Return-Path: <linux-acpi+bounces-13103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D23A92D0B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AB7924787
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA721C9FD;
	Thu, 17 Apr 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kHlfZ9ry"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02821B9FE;
	Thu, 17 Apr 2025 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927244; cv=fail; b=G7LxqRbQ8lBuFPIgbIsYvGys57S5bcQp9Q2ch/Trq/piWCmTX+SmYXZkhhAaqPIgRqA+STGeBdnO3XnAfRLtjvz3wj31P+RvXxsTkysKYnpskvsBr7gcIYBj+TmgUo3iLj+kEfC91sebqq0VhipZtmNE6KsAgiyM9FTaNeHSl6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927244; c=relaxed/simple;
	bh=qbj2ic9DFcR95UlSmV/SlbkwSozq4Aypl7Hj29ek1xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhKZwUwm+K/4PpSg3YnsqZnV3wLbSx8Z23PxoHqRoas5NrICaqsXu4+7M4JdqWjyv+EmCsDQQhZ9MdlRjhFKbCV6T23f6t3iFv9X26lBNOzvCM4Y0r0kW7bkZHtmqzNEEv2ygArE5jUYOOTp90LAPOOv062eJuQMZgKmd0WhDiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kHlfZ9ry; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azFtfI+5iYIa5osqBrY2HXE1b/HMUdiUT9x5tH25kqc6lqzuapcddz8yFtjnhJDzMQPkawcRlUoc+pilWrnBDWPkQrmAWq/r4IIMIHs4yjvsPKOATMsy/g72VNHLTitYgrmpC+gXlWCV4V0Z6tV2Zw/5xf0Yx0PJPMM4tft1Gm9Us+guqQWsfcm2QxDjRqMOS+vnuqcQQnkvKqppEy+AA2IUlJA764c9EEyOGMp0vPwN3k8WYtC2dzG1SFInUdX8x8GBhhKOmMWR0/b15w70NN5zBiHHHFxW6apEW9enLKPP7PZTs85ASfzdyY3BAr6+3FWptFI3fzbEEiwjvJg5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIAXxYe2m9bayZnYl/SBExfOG0ZvM3VquWhAHr7BmGI=;
 b=O++MwknBzknSR7KizAECI0c8XfkLWaEeGdXyMO1pMxqv5xh/aoQBSM2+JUkWWNotYTBYdGD3gqouJotGKxO3FBN1JY4MnOJZiJoq2lgzHKncxtMsfRuse9C5/2Kazd6af32V8ul81ZNF+MtWSw4gG5YYPGQYWHLfE3rb7aZtg/b5kqRBwR0RCC9TYo9DnuObl26yQBM5/ATXKVQAuG/m/kP2WhipbO9uEG2OpjjVeRpFIdMqojo61+Io6rglTyAZPBYzTs2hXthPt9mWH2/LLlLJ/Jkkn1yGzK8R6pp78CFkDvSIlrDhPymiWdj+sUTkgbPXNrCLHTL49SgS2XvYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIAXxYe2m9bayZnYl/SBExfOG0ZvM3VquWhAHr7BmGI=;
 b=kHlfZ9ryvJUWE5IGh04SECLbXVf/Y0vFkPhhtD24T60p5bhjixv4omsL4bcxa9T64YqZbGmVuqyPjoG3toe1QmbFDv0ZkxSuYOniDWduFJm1EzN9EG6N04F6kWmN9L8h+zr6gWTgi5ktnGZdy/poEXQNeoztOnbDAMZX14Gso8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB7327.prod.exchangelabs.com (2603:10b6:806:1f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 22:00:35 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:35 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v6 3/9] ACPI: APEI: EINJ: Fix kernel test sparse warnings
Date: Thu, 17 Apr 2025 15:00:13 -0700
Message-ID: <20250417220019.27898-4-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
References: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA1PR01MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 25017924-4589-42a3-94ac-08dd7dfb479c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o45gTLeM1df85+TmcJVUP0yKbxJvn2LJTsHRKZnMC0Uxc5oMdeJVKtqvbKQS?=
 =?us-ascii?Q?D5hvwdXRbkJao0rMY/qjYjmUfb0UW/8NIFD1wLVM0NetaG2thmkc3/imjxlT?=
 =?us-ascii?Q?lanEFoHhxmtp3Ls3KVvuzNEqtNFoyLlSDvX4Xdu2h7v5T9nHz0nAs2O7b6GO?=
 =?us-ascii?Q?ONqjv5HIPqDa+cpLt9f1cF31HMQjxMiXi2L/cPG8zyA6/AfSn3Giv27uUX34?=
 =?us-ascii?Q?a9kcb2DA3KbimdM7MqUchvWHe2btw68yMm3eSnmL+g5WCKNzSaINrzu4dBTp?=
 =?us-ascii?Q?zXLDe3GtPTTVW847qkrTjqyMxT0UtuN/ljobTIhlTzj5wEvNU2X3I922oC9q?=
 =?us-ascii?Q?ulIOUbND7L+5I6C2TKWU2lv5vnD+mesXpRDBgZTDSUs0mce60AjzM7KJekH4?=
 =?us-ascii?Q?YlQ0DOpAQhUIpglVlsevBN2o3Di9nIc/AwUpOYw7+L51G1og9ksO+ygkv4ny?=
 =?us-ascii?Q?Uvh8zngEZJ0Ki64n3jRTCzt0fMvVGVutbIwUjM6zAF3msQHMTW2n4V+7yW+h?=
 =?us-ascii?Q?WT2diV8nepWWokkVDST8dQhK+BLWJo8+qIbHA5V58BHdcCKxJVsyhk4e8noB?=
 =?us-ascii?Q?RY8FH5FRWwcl/eqW98/clQrDVIA6IDf+nnd+aXBWzsX4b9tBNfRkXa6kWpa1?=
 =?us-ascii?Q?WAncOzHoPABYTQJW8ehSHmKu11jbXgs/arKHo5izW4Aq9IAS8aadqooTX4vG?=
 =?us-ascii?Q?JJpeaU9h8ADGf5xsdw5Y/iFU3ju23XVxy/EiTT+KxkxDmwlNlaBBMjiUF5yf?=
 =?us-ascii?Q?yZj48i+S9U4lGxgK6g24xkkuZzBMe4Qtv1K0hpbeOnlHgUWO2bnPXt8WM3Uw?=
 =?us-ascii?Q?Gmg4nHPrrZOb9NNi0rzJDNDfkGQPoG1JIPqS1O8Wz0en/HUhEV3yCnYIHkkF?=
 =?us-ascii?Q?W5B+kOH4mw/sslEkZEQ3tM52Mk7dm7rqiFNm2+XmbOLvHE3b04NlF25AJf5K?=
 =?us-ascii?Q?aE40Bm/M/VBFeITiCMTK6SQzi7JcEv42XsOTdHhd88HtApT3IEYk3iN7P7qb?=
 =?us-ascii?Q?eXUOy3u59tW7NU7CVpl92goChjp8IQXLBeuq6mvz6E9HQiCxk0wYiHJ8E45T?=
 =?us-ascii?Q?F/tKZBOjVvQ4w98ArkoGH2fkljfqNIDqto5izNJOC11CiGoak7+u4Z6wnr/h?=
 =?us-ascii?Q?t1iBWdFeugfiGF2r3U4LXJuPdQObLzTAVnAhBhD0UWnyVcPmynhnzwnSUaNt?=
 =?us-ascii?Q?UPyD9QL3BhlAsMtupxBaoct1/lXNytDTIx9DCRCV95eFTHGcyixMILv6sd7C?=
 =?us-ascii?Q?up9gO07N1Z+jmk6mkDWVKc7/4Xn3+H74q59+hm0GpUPMg+UXf2xW/lUKgbDC?=
 =?us-ascii?Q?ohJJTvRsa1HTBYAaWLxWf5HFCNBkmqwhQVE6CP0OkfTTTTf2KJuQY+riJlWg?=
 =?us-ascii?Q?aUj6izfV93sUgipJIGUgnu9J0ZPpX+jKg7lsuCpkG1lhwfprCvcnqwuwudKc?=
 =?us-ascii?Q?ylG3kqJcjnwfHvPWasBoL4U2bNCJieGe8g/a3jcibMZt7CQ95iv59QaTBHZG?=
 =?us-ascii?Q?srgdKwFC+JeDiGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E6DxtIAy8YyiV+ztaFKhha+aYOZoH5QU4hDyNTsoV2hekus8PhVDff8ktMHm?=
 =?us-ascii?Q?xv5OzyJksMq2NXPnmmsxFFyOInAmCUlJEc5NC0Xz5YZ+Dw9VytAq8mUHKWDw?=
 =?us-ascii?Q?g4DlkJWAr0mmaqBXEOogu/bxJga0+bkjWwSmrqf2VHllxbaL3UIFpujVMhP4?=
 =?us-ascii?Q?wU/TVbAkNn2MXTnEFwqTaU1harjg3deito1VVhajHHrt+H5inKp2hYYL7MrX?=
 =?us-ascii?Q?WPuYxnvaojU5XNvY76cpqek4DoXtNnp9EZJdRavD5Cjg5ACmF4dTpkGeJtJD?=
 =?us-ascii?Q?H2c2A6bw9ynPHcp2H3X7d5qqgSE8jdwhy7tilgnvOw2cS7Tvd+V9yX7eJxUu?=
 =?us-ascii?Q?aaYZ8Ybkz0tDJNpoCGohtu88dwqqCCETeKsQiuYDYRU7FUITB6ENPY+mfJY4?=
 =?us-ascii?Q?r1aydvvXE7rtyqk6aVcen5TsnFzDEFiOnag7Cp9K/YfAhHPIiNIFbF0haL53?=
 =?us-ascii?Q?33zex18JKebvxL9DdmiEd0fbgb/o0ueJCJSMmHfMxb126bxQygIZ3q35t82W?=
 =?us-ascii?Q?7MNvlzwWuZA1CESk1WEotp/mHoWhObvRbPEgSrjDLAAy++jRKpqeXypVia70?=
 =?us-ascii?Q?apRMq9pWfKAM0AMWNsvw6WWkYvARanjWV5gsbgjCJ9wYRyZlOaHPdJzzcXFw?=
 =?us-ascii?Q?fJguGEd7hCjjTVaRzBfEKHaDHMSKSOk908kb+FsxGq0KYcjQqJKVQl34qRHU?=
 =?us-ascii?Q?jHH7Z7Usyn0WXotI4wCKTNI6M/z9jq5agmKX+fK5PGNMEJlcMg7PzRMLKi7S?=
 =?us-ascii?Q?D9rIotKH7RduWNbqslE0ZxWMkWQ32EgTXvgTmZAYUykjHg1k/YEIpFBwwtrs?=
 =?us-ascii?Q?lw8XCjqUqVdJmZHd+nn+3w24r4so9qbIyScOxokZkuiwJnjA3BfEYhoSszXM?=
 =?us-ascii?Q?tcyJoxfbYe9m0B5KFdVy9W0hSnYElvKWbM6mNwejHFNxsI8IPSk93GusOG1d?=
 =?us-ascii?Q?iM734W8B3vUgQ2aWWwukqdKNisI065NWY+A5V2804Ke3oi+j31fnNDNh4RWA?=
 =?us-ascii?Q?9bKgkGJVeMLcJ1I+MRltSkZZopvQSV+1Vq7U4yqNxO067WzSStkTEtBtLHLM?=
 =?us-ascii?Q?qVGcvsntmFXAkk7v+SzEXGlCoKDPqtVKYo/I5FKgmea7eMx8ubpu5DMGeuS/?=
 =?us-ascii?Q?ITERel+Wwm5+yUc8yQ3NhdMB1FMsxv0s4qJLVzVmNvuHhbrCHLLkX2Qxjl9j?=
 =?us-ascii?Q?DbKd9lmY3aFIhbl1ni3ROOCQ0xRwDeJX39XWUfuAodqQAxn+2zReKiFcfflx?=
 =?us-ascii?Q?it1LQi+2u147jMzMfiVe0qTQR1NW7TFzyEFAEdl8vahRwfYJ/LKr8+DIAwzD?=
 =?us-ascii?Q?74FnNzUa/ERjDeWcQygCLwv+wII6L78PlNQu0vkTTu8LpVHmAdNmHxzoAkJn?=
 =?us-ascii?Q?yjOHvBJKDwIMIImHPAZ0jJmesuViG4yJf6ewVpwmj/mDM1PkKPMLQM5kFhGM?=
 =?us-ascii?Q?zdrCP5SYUFDbVXzN068efkLoIdneJDDX3yjdBGNK8dX+oc8kbBfKbGZkN4NB?=
 =?us-ascii?Q?8ZClEtNBgTr/jH4l8eFeNLD1UrOfOzm77HmstV8DW5NzP8gpBXyw9pjynZkS?=
 =?us-ascii?Q?4hhAp4GOgtQcuis+mgMLpSn2LA3o93Oe/h294M3pS4Bkeu+haxuXeqQbEOkl?=
 =?us-ascii?Q?maJJOF+/VbNxGfU04ASGfY4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25017924-4589-42a3-94ac-08dd7dfb479c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:35.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSyu8LaAwx0n11rW5y6M05SfbUUpR3KcUz7mTCGjvsSbxyukYwZgo/ryLQfYFl7Exlr7j1vnSbply6byYWwa+yXA5/BmubN97IJxPNZWU+6RPP1k59SrPecxfPShywt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7327

This patch fixes the kernel test robot warning reported here:
Link: https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 106 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..47abd9317fef 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
  */
 bool einj_initialized __ro_after_init;
 
-static void *einj_param;
+static void __iomem *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -214,24 +214,26 @@ static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
 	int	offset = v5param->vendor_extension;
-	struct	vendor_error_type_extension *v;
+	struct	vendor_error_type_extension v;
+	struct vendor_error_type_extension __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(*p));
+	if (!p)
 		return;
-	get_oem_vendor_struct(paddr, offset, v);
-	sbdf = v->pcie_sbdf;
+	memcpy_fromio(&v, p, sizeof(v));
+	get_oem_vendor_struct(paddr, offset, &v);
+	sbdf = v.pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
 		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
-		 v->vendor_id, v->device_id, v->rev_id);
-	acpi_os_unmap_iomem(v, sizeof(*v));
+		 v.vendor_id, v.device_id, v.rev_id);
+	acpi_os_unmap_iomem(p, sizeof(v));
 }
 
-static void *einj_get_parameter_address(void)
+static void __iomem *einj_get_parameter_address(void)
 {
 	int i;
 	u64 pa_v4 = 0, pa_v5 = 0;
@@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
 		entry++;
 	}
 	if (pa_v5) {
-		struct set_error_type_with_address *v5param;
+		struct set_error_type_with_address v5param;
+		struct set_error_type_with_address __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
+		if (p) {
+			memcpy_fromio(&v5param, p, sizeof(v5param));
 			acpi5 = 1;
-			check_vendor_extension(pa_v5, v5param);
-			return v5param;
+			check_vendor_extension(pa_v5, &v5param);
+			return p;
 		}
 	}
 	if (param_extension && pa_v4) {
-		struct einj_parameter *v4param;
+		struct einj_parameter v4param;
+		struct einj_parameter __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(*p));
+		if (!p)
 			return NULL;
-		if (v4param->reserved1 || v4param->reserved2) {
-			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
+		memcpy_fromio(&v4param, p, sizeof(v4param));
+		if (v4param.reserved1 || v4param.reserved2) {
+			acpi_os_unmap_iomem(p, sizeof(v4param));
 			return NULL;
 		}
-		return v4param;
+		return p;
 	}
 
 	return NULL;
@@ -317,7 +323,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
-	struct acpi_einj_trigger *trigger_tab = NULL;
+	struct acpi_einj_trigger trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -325,54 +331,57 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
+	struct acpi_einj_trigger __iomem *p;
 
-	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
+	r = request_mem_region(trigger_paddr, sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
 		       (unsigned long long)trigger_paddr +
-			    sizeof(*trigger_tab) - 1);
+			    sizeof(trigger_tab) - 1);
 		goto out;
 	}
-	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
-	if (!trigger_tab) {
+	p = ioremap_cache(trigger_paddr, sizeof(*p));
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_header;
 	}
-	rc = einj_check_trigger_header(trigger_tab);
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
+	rc = einj_check_trigger_header(&trigger_tab);
 	if (rc) {
 		pr_warn(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
 	/* No action structures in the TRIGGER_ERROR table, nothing to do */
-	if (!trigger_tab->entry_count)
+	if (!trigger_tab.entry_count)
 		goto out_rel_header;
 
 	rc = -EIO;
-	table_size = trigger_tab->table_size;
-	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			       table_size - sizeof(*trigger_tab),
+	table_size = trigger_tab.table_size;
+	r = request_mem_region(trigger_paddr + sizeof(trigger_tab),
+			       table_size - sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
-		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
+		       (unsigned long long)trigger_paddr + sizeof(trigger_tab),
 		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
-	iounmap(trigger_tab);
-	trigger_tab = ioremap_cache(trigger_paddr, table_size);
-	if (!trigger_tab) {
+	iounmap(p);
+	p = ioremap_cache(trigger_paddr, table_size);
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_entry;
 	}
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
 	trigger_entry = (struct acpi_whea_header *)
-		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
+		((char *)&trigger_tab + sizeof(struct acpi_einj_trigger));
 	apei_resources_init(&trigger_resources);
 	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
 			   ARRAY_SIZE(einj_ins_type),
-			   trigger_entry, trigger_tab->entry_count);
+			   trigger_entry, trigger_tab.entry_count);
 	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
 	if (rc)
 		goto out_fini;
@@ -390,7 +399,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-			trigger_tab, param1, param2);
+			&trigger_tab, param1, param2);
 		if (trigger_param_region) {
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
@@ -419,13 +428,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 out_fini:
 	apei_resources_fini(&trigger_resources);
 out_rel_entry:
-	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			   table_size - sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr + sizeof(trigger_tab),
+			   table_size - sizeof(trigger_tab));
 out_rel_header:
-	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr, sizeof(trigger_tab));
 out:
-	if (trigger_tab)
-		iounmap(trigger_tab);
+	if (p)
+		iounmap(p);
 
 	return rc;
 }
@@ -444,8 +453,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param = einj_param;
+		struct set_error_type_with_address *v5param, v5_struct;
 
+		v5param = &v5_struct;
+		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -490,15 +501,18 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
+		memcpy_toio(einj_param, v5param, sizeof(*v5param));
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
 			return rc;
 		if (einj_param) {
-			struct einj_parameter *v4param = einj_param;
+			struct einj_parameter v4param;
 
-			v4param->param1 = param1;
-			v4param->param2 = param2;
+			memcpy_fromio(&v4param, einj_param, sizeof(v4param));
+			v4param.param1 = param1;
+			v4param.param2 = param2;
+			memcpy_toio(einj_param, &v4param, sizeof(v4param));
 		}
 	}
 	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
-- 
2.43.0


