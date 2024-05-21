Return-Path: <linux-acpi+bounces-5925-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6468CB52C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAE61F21C2B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCFF14B95C;
	Tue, 21 May 2024 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lsHaM4uP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8E14B094;
	Tue, 21 May 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325868; cv=fail; b=Hoa+mepW3koLrss4/Zv7Ay7uECiffZI/+iMin1GVXDWWeFCkvTMrMdcnNIe0rDhfiq5kHl3WyvWI9VMewvbPszi4GOSOazIoMU8TKhUzyMVTamhvD697MHNKSGGeVy5ZyAAUGcK2X3MKFKLbwn39u50/190v96YR0ebaxCtvWXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325868; c=relaxed/simple;
	bh=eH4bs5hw72vLV3DW4bCjbm8AOR17nolv6dF4AeNrD8s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Basx9ALovmz9Ijg+udEVAEn8UsvI+KtCpXFUFdBGGwhKGcja24Kl3t899L7MF1oNGiRQCCBgOapPfNpnHv8KL8CqpSi4GUn+Ox1Z2yhHNLCsgHXlYwuCdGifhIGHSiJMILI/v6BnLW1o6y05hDH+F+kCagDwOP0vIDgMofRbRu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lsHaM4uP; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4U21rnEnZXm+0HJdytW2BU3BW81ZHPC8NxKi9vaOCB7mWfQKR0myXkbtII8vmYlcyQ4LQuxBKsVvy1zUcxyN/CVeBrHGnxb5f4iEarO4puoEsgDDQW6mGg7LHGVAAzFNNYyCOzYXZhqHHyndeznvdsc/nzB5uLEQLcXT0Wg8NoYQauae08UqZt5SyzuZwN9Mkpu0ZJERCsSaHbWSUy+gdH/HuysW+8TMQk0fOzEbeJ2aUa14cD/UFiv13KWAM/L2U4E6bNnGqjDlVpJ2WJRGC68gvHClZbjN2BTz9lwjIhoQbOH85C0oNfGfyVXeGiFMFUXier4XBxsWz5SDrxNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWfHkAE1FxrGrsWlP6B8OPhEEiZWMDnw6UGyw8od9Hw=;
 b=fePhwJFOg90qtKyl2xLRW1rAvC8yj3xDqiGvnWSO0eyaMMMce+3t35n8Ss1ZoEc9bUNRdqRJAWJh80CvoxoxEEriJMLvgRGheTDO5yjntbnoa9zueu4E5r4kERiUXG5L/1upGPolRgNPIXdRewUIrLnXHHJpnlDrQ91qcMdtF9owmJYpXLj8uXmCAsGvnvsmNabzlXVJ3t9zB4ONkw6NFy+1RJvwQvO6Oe2hyAo1z7foEXmzstNO2Uf0qdaQcBBsHXSdBCQnwolXE0KFPEK0i4tkg0XLAXfOKHql0v4DdKh/8HgRzJgnFsQAt9XTwVJLWYpGg3WizGU8tQJi1DZAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWfHkAE1FxrGrsWlP6B8OPhEEiZWMDnw6UGyw8od9Hw=;
 b=lsHaM4uPxe0NA2VZsqrXWjrBOtLCbH4/7MjXino/s8qiVVtSlQydKq6q9/ZugQ0sZRUMddg0Qve2ygEMHHyjghbGDqVb9YP3wph0I8UR8ngqIEwC3+70TpVTtTsakkfnCDPSDdpAi/zHdlQPg6PVkZCy4hEaxtq71kqo8gaDkyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:11:00 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:11:00 +0000
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
Subject: [RFC PATCH v2 4/8] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Tue, 21 May 2024 14:10:32 -0700
Message-Id: <20240521211036.227674-5-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e04e0dc-d303-40c1-7172-08dc79da83d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZdhg9Unf5R17QsOiuYgCD4zd06Y7OAe0g+FOIemNRM6j+Fh0CS8e4kfGLuj?=
 =?us-ascii?Q?js/aDdNFN3U3M3si705Vk0RBu3WfI5V0mEJXxE9GziP5isB18yYeGutyMnYN?=
 =?us-ascii?Q?/xRuVxgARk6OKTtnUoX8WJPIFH/AlulVMPF/agDWIq1RbIhWt3jx77wgYVSP?=
 =?us-ascii?Q?If2KXxygyXFgQoQql765Ii8Wjgk7E9hB1L+9tJH08ETkH3tY8PaSqAXRJhvB?=
 =?us-ascii?Q?czbqfP2fRUjX9/swMqn5dcoJrKKPUr7EAEdOe0cPwpSxaI1li6Bv8vek7nlN?=
 =?us-ascii?Q?wmZCYeyYRx1hx399E5Gib1yREJX11EukGLlZYyF5gW8yeIceKTHkxL0hMU79?=
 =?us-ascii?Q?9ZL5ma4wiyE1Fgh86Fzk3ukr85nUsOD5Gn20vZvLOdO0hHRl/RCAbYNwaUUi?=
 =?us-ascii?Q?6tAYQ8oOap5lZhFFe781xGA7lLSX43HaNKlzLYIwmzIm5u2B3R8x9sPXrKHU?=
 =?us-ascii?Q?w3UcV/U9P+v8yfJPDM2QW+Afkw3iyEz8GHYrbleKwuI97cJXwu34elYeVEyR?=
 =?us-ascii?Q?B+4Y3LlYtT7ORFbuhznM21SPyVWepC2o2BjB1SqQ/Qt7qlkLFjEtOB/ed+Hc?=
 =?us-ascii?Q?MuH+SKz7rkJvhgbmJUshuAH/4iMLBh3gWO8bi3U3K9L0hM4hzw1TTCDlBmQV?=
 =?us-ascii?Q?bAizRrd/V6wBnukyOeHYbYk6zHs+8lOQGH1PAsQzq3n1fLLLTk/3FePryrz3?=
 =?us-ascii?Q?hG4cEx76eimA6UyskHjKWuj1RyREcidQTwLMMhAjW9bVhsaKYcgu+zPlyfvr?=
 =?us-ascii?Q?EQUUBlgyRW+XXgCzQePReqSX3EAeBgxk8dTOv8k5bjCU1fXM4NKlv5mfvDPd?=
 =?us-ascii?Q?CrWboRKHHkKtaOLcHeGhAGu4WRJjaHMvq3ZqMauUdHIHZU/va4evSdDFy/K7?=
 =?us-ascii?Q?XUyYTpr3V2iisklW+mXP7sFd2exOFl11EqhMDLdnJpK9AvTX9ir5UeqxJjG5?=
 =?us-ascii?Q?JIuGcQCMaYCf66bcZu9YWEwNpsvlTNV/G7yNvbu6wrza13P5jwvi04ILWLi1?=
 =?us-ascii?Q?oSeDlxKOOTkWNQN4zMWbzyOzfNsz79mE9xfU1mVgDkMK1k9XT2oqNoHLbH9f?=
 =?us-ascii?Q?6o645SpRO2g86KIg8QRbEO/2GnMdiwsdAuU7gtjduEqYpFuwW3TW4pq8Wd0k?=
 =?us-ascii?Q?7qO7JoD1xfqqCqz5sdNPg0mazjj3Daikthe58FEI9Hgaut8FP8GdL41icRsT?=
 =?us-ascii?Q?QxA7flmiOiX9/qhNfIXKD/GvPBHEUwWQKts62axt1orphcrOwRtI1p7u2hLy?=
 =?us-ascii?Q?z63E5anD1g3ZUzVN2PDoyRInfnGxijEjNU94p9UxUZFF/srlfWmw0UdfUKXF?=
 =?us-ascii?Q?TR718LISta5tnHRHq65FpMVJeWDoIuW0ki36IBVpxUkSp7fXkgL6dA9bJWze?=
 =?us-ascii?Q?Hed1Vso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+z1uvhle1T6uEFuCV73ETYljzIC3KUmRFOfeFOpUH1ks0EufxgUMwnCmnkTB?=
 =?us-ascii?Q?v2zdPrTSqWMrzmcW8XTEvZQFmis6RbQ6kcwgR5aOBFUJsqut9wsyYZGT0p6e?=
 =?us-ascii?Q?8Q6ozNzaZ/4AItTY7pvnFkLJPCcoFx45ZFhoIIAjvJEgk8Ik1+zrWLagIA1C?=
 =?us-ascii?Q?+A47+NeYXG3GN3sEJOE3Y+jkR/AE2zCwtpm00Us7bteVajsjay9FVkWv+Hpi?=
 =?us-ascii?Q?bWbK4dKLwEBmeEFbeyUmZwiC8lU7jRYx8QnWL6Yk/BgbOq5tY9kEkUaibFVQ?=
 =?us-ascii?Q?6ndquBT3iI2RdTnEpW9XdQCLewfKi/ScwFdUGGR2mw/zXE3qHY2E5AeiO8iT?=
 =?us-ascii?Q?MoKW8zCcjC5PvXikFbPa7h8bij0Ry8Hdnn4t8Es+I5FDq76+dZPt9xzMCtRO?=
 =?us-ascii?Q?Onc5shiqFI2RQOjb5ZYpto2ne4HBTzOZJEtgND829EvcqVVvMZ5aH0gvK1ER?=
 =?us-ascii?Q?h7DFQIqf+jxKY8CzfBIPRZodwaYrcs/lCijP6Ms/wdM0EjfN7qdru0DS1lGu?=
 =?us-ascii?Q?ctdPTIXIKNkBK4/mPPMUBNPRu9U/GWStwqqEd4/LiEZGr68dhxv3/lssItsy?=
 =?us-ascii?Q?kd49Or8lFZpjeYJIdnoGPudgo5Mr8GzKUBVA5SqvpUWi5sN+Hkd644BfPWPp?=
 =?us-ascii?Q?9pn7MDVHi8khjmHZJDf+Jf3V/rM84dJM/aaEtysnAs2xac0EsMJ1+bra6Vjg?=
 =?us-ascii?Q?qa4BtrvjV8u0C7w227416HW6ZTZiWE99dERuI1axhQvoZplAQCDPwwar+3Vd?=
 =?us-ascii?Q?4F6y3trm7gXH2uugalp3KFfa99Dj9M/8zClDHFkgNxRnHH4BU2ZnFGgqXlT8?=
 =?us-ascii?Q?BYaqzuRaF5gkcYJlg2olXP15FKNjxH+pbgzCA/ZdozLRLCRcCovuT+kty3/W?=
 =?us-ascii?Q?TvI2HQAacolCdbadWnc+UYZDkt0EJoJxf8FSFoI40ODXjqDSsaxi9+bhwyQh?=
 =?us-ascii?Q?u+QT3OmjlciVT2oKGoJjel4YAgHoZxHv4rANrz9fzYpRkLFsIxT8gshtG87R?=
 =?us-ascii?Q?SJbPJfMwE6p/wYD/DdVGzYUFvETCxZdskaL49Nqn4b3ym+XR8V1OE8U0y3UA?=
 =?us-ascii?Q?dGFlHBrqOQNGsWnvcguv8S7XEGO6mbNRx9xYUYT1c2vNwFEkyi1F1rRNnsG2?=
 =?us-ascii?Q?HCy83peKyHytEtnw60y7/97U2jIVfRd8gxD4dvh3b1PCGRPJGwcMOz6XDbfg?=
 =?us-ascii?Q?yuJTgCNI9/TfwgoLI58vtPnCy6qN9TC8UJl8chlSAjZ9vlFTq84YoADU2ppE?=
 =?us-ascii?Q?vkszIqrU4CcPjw2WTMzCbmb2mEXUKQ0gYdAq+lwl2OddHtsuiyfff/uDo+KZ?=
 =?us-ascii?Q?xWhu2J+APOlmNmEClxgpZEcojY4mPdvHa33RyJIf/d7K2YU1NGfnrawuCNKZ?=
 =?us-ascii?Q?AZmVVQ31aZ90dXlPenzrisum8ZhfaWTmFb1VKXfST2l4IGm88GMEScM9il3F?=
 =?us-ascii?Q?krwMGFfyRMIQnFTFUT0aXR6K6DZVoBcXzd8BADKRumQjbQK0WaIgBqZI0o9e?=
 =?us-ascii?Q?jVyMd8em42IAb8y5W40I4CY9UB7a67yJha345C9ahAlUpRdcpXAgmkpFAt8h?=
 =?us-ascii?Q?GOvQZuavL2oUs0z6yKyeL9yhbaWo0EQKppsNludOYIzkLnZkSVbU85l/jNhI?=
 =?us-ascii?Q?Cn726StDl+P++ynu950AhPU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e04e0dc-d303-40c1-7172-08dc79da83d9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:11:00.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tnFjKtvhZiDavVCfsu95ScgQUSVWUrKJMj7ojMBKTf8WOM+CCcqM7jzV1eLZCJTKV9ok44HI6HvCMzLa9ptaJbusnNX7k0ATRNWVv7KKNfp2A3W5ABtibYPh7mAsi1G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 35 ++++++++++++++++++++++++-------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

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
index b1bbbee9c664..cc5ad1f45ea4 100644
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
@@ -647,15 +649,27 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
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
 
+	seq_printf(m, "EINJ error types:\n");
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
-				   einj_error_type_string[pos].str);
-
+					   einj_error_type_string[pos].str);
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		seq_printf(m, "EINJv2 error types:\n");
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
+			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+						   einjv2_error_type_string[pos].str);
+	}
 	return 0;
 }
 
@@ -692,7 +706,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -769,9 +783,14 @@ static int __init einj_probe(struct platform_device *pdev)
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
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 8b8be0c90709..25adc9b03d18 100644
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


