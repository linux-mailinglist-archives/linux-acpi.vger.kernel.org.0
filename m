Return-Path: <linux-acpi+bounces-13512-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE7AAD046
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EE6174C14
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA823E356;
	Tue,  6 May 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jcr8Y4Yb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022121.outbound.protection.outlook.com [40.93.200.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7523D2B5;
	Tue,  6 May 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567518; cv=fail; b=WrEgbea/9wg5qup67mYkhxhGzUob+E4OZAGvwAnKDeAuAThCA3V/JeuUr5NLjFmOw6z9FcoKzAkMYKjLiJq2yoqkSykojaAB6ithUv9mvNcHShciprjWz9HLb0xNvDqI7JuDkmnsN4fYvcWIjVoJha0HCwS6UF46vUTtAr4OWlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567518; c=relaxed/simple;
	bh=+FeQw4Ql1K764YHCLl27B6uJPctl4rabWjWohYjgoqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZprh8TpUN0hhq4+2j5xz4GCQUYjYeUaIwKmtk57l53rPr0vAJk7RDSJNY0blOfz9pd4LL0OCA+tFSPIMk5Y6flvVe85DwWlYj6tLPx/QngCfK2LUuHOAw9RklxEfx4fZ37rCzh/iOz3pQvP+wpKpkmGtWHmcs5X+JZq/vuViYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jcr8Y4Yb; arc=fail smtp.client-ip=40.93.200.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krmQAI4bbYpCjjUFZWw3s+zBqPIeCbePEjln4O725hdRWoNIh8dHFTe26vboYBKc3/IrTj8ElpnKNPls2mHUdgparDt+rYeS9Za0ol46MMLWk1uf3xydyjTDLNZ/Jas2Hgx/PFw2EKPnW6ytoeIvD61Qy40lkzGE9KI/T9Y76MxaB3EYQwggvFrZ6nAvjSoF9/kg9Ill4WCc3xjkZ1KIUsZQe3ZySBX9WNUwPDMwnYgcbY+LSWihQElsLpHDwQRGjmRu+TRvVfvghR9Lej0dkUPDTRkU1Yy0fjbRHPYQmSod42E1stxOYslJ8yF9vAwqfu5Emi8uCiIcFFDHRDl/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4s9zAKLfpA5cMBdhr7Ndjv1wq90/iZNU52xRnv0I4M=;
 b=qR6L83WCnj33r65vyZIz9kStIzDSZJR3AxT6W7puaqsdI0ywSTV9mPK3lMcMwK8B8z/n4B5ouP1okNOnicRlqWPa58o1kZLIzMzdOsmXjhVWf9da0Z3jJg3+AXCt75MYA/qxLWiYnzrODpu8XU95iHdCCCuU7OqYK+4CtHlvcJGR5FJDYnZLzt2xuA59OQJEE+KrYiqKs0Zf4VroU15JAhHPqIPebgmUHES5AncmjWsqfCMOdsD3zfwN8pM3yMyg7isCZ/ZUcnwgtDO/rJ54TLxdTm9gABGPxnEDl2ZWIUMOXopyWx4y1zrdUADiN6XVio8JMX+MpnpKJgaAdDr/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4s9zAKLfpA5cMBdhr7Ndjv1wq90/iZNU52xRnv0I4M=;
 b=jcr8Y4Yb8CSt07bP5pYmTL2i6mNS/7zsoV9KY8ANzNgMHj+rEZ7cPRqfJCTpJU+FpOx9+NTVgtDJh6xa4Cq2ii3lRWBIAUKu78Is+8BVQOdl87ElHKXYp0XEbeIIsBTiocGnpjmNzR/Dt6efzUe5FQsL+pR6Tnm7vpPHdlSn6gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA6PR01MB8904.prod.exchangelabs.com (2603:10b6:806:430::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:33 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:33 +0000
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
Subject: [PATCH v7 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Tue,  6 May 2025 14:38:08 -0700
Message-ID: <20250506213814.2365788-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA6PR01MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 153c1ddf-46d9-4ec4-cd65-08dd8ce65990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?skEneNcIJWPyZxLW8DTpXKOxsgK2ZKyXYn85xqOdo8okD4b6zd3lM3BxtD5o?=
 =?us-ascii?Q?u1ToHCsEbfdvsA12XgFUayQaswXOLQRNC5oaWV513rEE1a493OfedeYdpniy?=
 =?us-ascii?Q?x6J5cteDMyihy1OL5/rkzFDheUqi//FBAnEX76brUIeHqoF6ptB9HbZ3BVoM?=
 =?us-ascii?Q?ES6r7CgAnYvvNEe6memB0UEHfVE6Q7eF36o3V22mo5atl83gCjHwfqyazzQt?=
 =?us-ascii?Q?+mRous0JhuXd3NusOf2vlVfMKrOWJtneXsOjoltq56NKpEaRp76S7W/21T4A?=
 =?us-ascii?Q?V75wijq8+YyrslLzQcIw49ceNaYTN0Cs357LCcTrZGFORqsFYu+iPY5WZ9ff?=
 =?us-ascii?Q?wgWK3Z+hAXNa8Kfws+/neSJ0p7iMc5IztNoToR6SWXH7c7fyPBH0Ix4i0Yka?=
 =?us-ascii?Q?jSZodVf+521OK8NSmpW5KOGesxkcFKky1n9lTmjRaLb0/4ZwXHt5N00isw0U?=
 =?us-ascii?Q?vCarIkrqzLtJqXbDS7ZIisg8gNIEsWT+ag2JHG92bUUPCHTdQdPrbi5J5ZJ3?=
 =?us-ascii?Q?v2xQA41KzRx7UyqDgNy+dYiZ5jMxdYNx1yR1jSsDzZakBamKwPlFzxMejDKG?=
 =?us-ascii?Q?tFBvDf+VG5yeWgfbIaDY4Y4jUvFADJ/7sEpC6k0LVsy7Atj2MJFNubjUG6Ku?=
 =?us-ascii?Q?lSnFQ8JDpuxkAdYOqZitlzBtu1n4Zw7IkLVgmqkaEx7cBbYXELrszrOux2oJ?=
 =?us-ascii?Q?2A543wbGPKXZsTUjvZSfsBrXAxu2bTJNi486aUsMOj0y6UsPzp+7ePaki6WG?=
 =?us-ascii?Q?dVrmvVLRSgjE12JSyXjOXDaNOiQtQJl6P/UXn/WllSGWrfuBrF6iBGEbMeP/?=
 =?us-ascii?Q?k29D5iVVX6zLvBtjc5wELJcypnvOoFcZGo+H1dlJXTLBFd+THZGH44nQQTnB?=
 =?us-ascii?Q?nbBf9prpWQrm+1WAbMpqiMJxrS82Q/3v3rWlgJ+diSBssJ2Od+EakFU2amE9?=
 =?us-ascii?Q?OQu8tQ8D0p8pBChOP0UjJ9RbE6KpIPcQOA5UnFP0NdwGO7clja/Vk6ZZ/1HR?=
 =?us-ascii?Q?7KxgScdDxwoWmKXk5hBhV7RYU+Eg+A4Qpd7YCKcytRkqs63qTUZ4XL71aOXS?=
 =?us-ascii?Q?l28bpm0Mwm8csporLO+1oe7GhM79T+iWCUaFSfXHp44K8/9kJsqZXW9Ea4dO?=
 =?us-ascii?Q?ufGX7Gj3GBLVHVgk4a6E7EX8q+HEKoxDZ8twYwFU7cEJI0R1XvHPtu/Eig0q?=
 =?us-ascii?Q?lYmD3O9hcdg1+/Zo7YhGndypu8zVAbKWmdazC8LOsNhj+g65YwC527Thv0aD?=
 =?us-ascii?Q?JdHXd+IS5X/tZPFsnvNRn9qUPP2oqFLc1P7tNOslGT/opP9QZoDjEZ6E1zVR?=
 =?us-ascii?Q?Q2+RaQcrotPM1h5ha5iNCGtRUh+M9HQ3ZFVdZzL+mVBoYvzQsGhhJCCpi9YF?=
 =?us-ascii?Q?kyqEVXTZzbt8HrMt+5bPLXqYmhNcrp3JfkpnpgdgTL+p/2R0NrfErVU4MN3r?=
 =?us-ascii?Q?17W29CkLWL9It/IV8hrMKApZvKBYUg3ajsuh9u7Y+4MdGIV7iG8EgrbdlEid?=
 =?us-ascii?Q?IlQbpC8PRv6oHtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QYpPOVS/ICGv4vkiLuYoCG0jm3SukbXR5R6KuD45/eXXP9koGwosnaakT5ai?=
 =?us-ascii?Q?TpWA8CmMIs2PvqXlDR/fFzewDv8814DjaHN/6xg+fj2WJhLD61X+o3E1QMVJ?=
 =?us-ascii?Q?tV20LSyEKLcr/eYkPAurNSMYXwCU1BENIdHvjZmAOxYuBDoz766k/Y/BQKaH?=
 =?us-ascii?Q?ugpTt6808IreisqZ7nLZ77X+75hqjXIwhsrIWJDpew6/zc76SIn4rRP9ibeQ?=
 =?us-ascii?Q?ON9QL25iS4kot2eNmDBB9NgDKFmq91bFtqu7/ZXRPp96cLu9oe9n1RivT/6G?=
 =?us-ascii?Q?hB292Q6Vi4oEWOgQg5hb9XKR/GalOizTZT2+fWJJiVmp741u3kgRp6J+bfoR?=
 =?us-ascii?Q?4KwkpX+/bfoMwOQfalzpZuASgZFmp7TJltzieh9YLhJsX+UJIUqY1WXXpsj/?=
 =?us-ascii?Q?lLjKnPI/y9mmkQTF31y89DbeqgilXgbYswHCCgDl7n+ENm363XH+DmPpERbC?=
 =?us-ascii?Q?vIUFoX90wEhH5MZKm6VV9IA5/Xlw2ZAibOuRSFdWBE98+5amw55qZlJx8e01?=
 =?us-ascii?Q?LSrdQ6LzqQnKdxMie9GH1btjqyz7ow8Luj0t0/Jrszu+nGLG2jV5MmGBfEWI?=
 =?us-ascii?Q?pzPsLeX/y8Jw6z/t6m3R+qiG1gciJdrylZymd+F5jTpXpH+jMqtDxsa23x+3?=
 =?us-ascii?Q?wPUP5ABV7Ak0bEpLrt4DsqD69FT+lPIG+1JC/+BJxplL3arIJ19XH0CWOHl7?=
 =?us-ascii?Q?NnOty+SUhhH5mp3k1QOM5xNhOqfqP7ruOpCooe41JpSLI4FbFhvitzgsSLzu?=
 =?us-ascii?Q?1X+nIAsLhXU3OejGL64ueKj5ujrR4iLurzPb2H5NkXM+K6G1ttYCLOHircow?=
 =?us-ascii?Q?j3fWnKgy3hteXcec8pJ/NVrxgBL//ypgxEMiB/lJXg/C7+PZtlmYJpL6Lzy0?=
 =?us-ascii?Q?b2QGCGjsqR1kK3brPmGzk/ymqSHRZN6PazTANj1QQYM5kaGPWwjF8OBUP6cu?=
 =?us-ascii?Q?6pC6VMEgBBNUUPDL9Eynmuw6jcgck7AB4q+TWbV3Aa3hm58RrOdhK2fSqnqj?=
 =?us-ascii?Q?Dfo1tRJ6f473S1tzQnr5IqViRIckCeEhzfdsqemTLrLqKF27Y+WBoMnjX2gz?=
 =?us-ascii?Q?41QityIYyWejGcrBP+iSav9q7ho2s4Onyz59USazZxp3UYYEqPIV8VGtDmVP?=
 =?us-ascii?Q?Mmy0kTbkjF+T1PkWcO4krtcPUIDSTAjVOOtOvNoHjzEsw9Zr16vNLOELnDik?=
 =?us-ascii?Q?urt97aqIS2w7qktJZ3PtU/lebf2NsRK8Ui/BOLKwToEXHTNgM5uoz5MMP1R8?=
 =?us-ascii?Q?MB2oUDwbP+Q4TO0diO6VrqKQxanufYdi5H0/vnn3ChVnYKPRic0sLuClI0l0?=
 =?us-ascii?Q?Lafc7vGpTUelvD7jjWZHxyOEX9jld0YVAF0an1K043MKc4eka2Zx39sQu7IP?=
 =?us-ascii?Q?TiKQIaQvSAQOUJSrogXlAnHrPvusZcQQQJ4DYjWKuCD+/jw3EaVU8rJjfbBE?=
 =?us-ascii?Q?1t7FPUOW/3/VRXy7Xzbw7xvi4CJNofT7ib2MRyeS6fjvoAt+1nVp07wQOu9S?=
 =?us-ascii?Q?8sDgy32LKwhrs+5/HDN9kF+lesMUbROlSXe53PLrxez644UVNgbbJ24L8MVR?=
 =?us-ascii?Q?6+flEPAaWI6xDE+zyVG+gEuqU9KJ71+GtKK2zmhJZCxB7QfVaDFVHoOchECL?=
 =?us-ascii?Q?N/p/8n4ustK6m+YoofgWoss=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153c1ddf-46d9-4ec4-cd65-08dd8ce65990
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:33.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNRBTV6EU193DXfTKTIXhlt2V7yVVHH2FuLW6kYSCvbxGlOQYUcc4EP1mnqA8yWz/klY3Ok1m+n2ML49BFUJ5JODoJbxQSvRP5daJs6ox70tYtui43p0Dq4yhM9GL+6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8904

A single call to einj_get_available_error_type in init function is
sufficient to save the return value in a global variable to be used
later in various places in the code. This commit does not introduce
any functional changes, but only removing unnecessary redundant
function calls.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 47abd9317fef..ada1d7026af5 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -83,6 +83,8 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static u32 available_error_type;
+
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
  * EINJ table through an unpublished extension. Use with caution as
@@ -662,14 +664,9 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
-	int rc;
-	u32 error_type = 0;
 
-	rc = einj_get_available_error_type(&error_type);
-	if (rc)
-		return rc;
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
-		if (error_type & einj_error_type_string[pos].mask)
+		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
 
@@ -692,8 +689,7 @@ bool einj_is_cxl_error_type(u64 type)
 
 int einj_validate_error_type(u64 type)
 {
-	u32 tval, vendor, available_error_type = 0;
-	int rc;
+	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
 	if (type & GENMASK_ULL(63, 32))
@@ -709,13 +705,9 @@ int einj_validate_error_type(u64 type)
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
 		return -EINVAL;
-	if (!vendor) {
-		rc = einj_get_available_error_type(&available_error_type);
-		if (rc)
-			return rc;
+	if (!vendor)
 		if (!(type & available_error_type))
 			return -EINVAL;
-	}
 
 	return 0;
 }
@@ -791,6 +783,10 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
 
-- 
2.43.0


