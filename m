Return-Path: <linux-acpi+bounces-14145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2040BACE6BC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910A23A9ECE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B3B239561;
	Wed,  4 Jun 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JT2GeHhW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2112.outbound.protection.outlook.com [40.107.95.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8B238145;
	Wed,  4 Jun 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076715; cv=fail; b=WycXIACnq1abAvcNbtoFUVByiqq9BzbtxVdy/Aqp1E8O6i9KrNmUc5Md/vgBsd4kXZIHhyplQfbBP1wyo2Fl+xJPOHpdDpLgJSEibko84T+AincpJf3GlTnDAkJzBB5Hi4tvGajT6fhcgstPSZwzI/qFSJYcG1fk2Rv9CjWr9JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076715; c=relaxed/simple;
	bh=S5MFl7qJyrXjMKV1Pg6ZvP++H+Ve5SE/bKzN3YvBnRI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXZepYJt1E0BDMwJ5onkmUZawB0L1tBK8VLXEwYZeUNl2cQ5kH464hAcoJPSVwduXupF8wexA3OyRThyfBlESLDCCDO2pTZqS2SZ65TCPA2AhwOOckWpAXdAQ7rAE+bvOgdOK1qQ4eFklo4GNmItMoxAQCXi9fxjD0kUSWaE+UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JT2GeHhW; arc=fail smtp.client-ip=40.107.95.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi8v0l3isYb1OltnMFMsfpRxAm1W5qjM1vto1WM00a6hCQ7Ljs4JbcXxwSRfjj2vVR5rDWEMCza5OnCqqjoqW7LtUvJY6aDgYUKpTspYvBnkhfc0sunILkUEI4rfOWve61T6cGwbbctaaS0jcXroOHHRsiCCbI6mY43zsbhb2NJjJLq9HurrWBTJM7U2xe7vibebCiS3OVeLPKMeTBgjrN+YTjMZ1ZkC9lSRsuN0SDi/J1C5PvpXZyCcl+UkqirBfx5R4xR9XkPuulQRSIKnrYRnUrciLtLNBZlyqaea89728B6JhhxXRc0xJaYe0upRH9Lc0pmTlppLhxMnxPY/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMJ5KZlCGZbDXeG5C9rHhhJNGgxquCB/8omiaqsyoBY=;
 b=X36YV/WgbBKc6PTU39Bg4eaDBgCLdMiuwabHhNaItSLW3+asuBX/iFVC776Fhu3w7ujZFCG+zRWfaSkLZLL6uX/cezwhtDHGzqLwc+RBDsCYMTdF9RFkAxpAdzfoMQg92fwqEGbMfM8/1NtGs+/tGqcrOZDbUIA5OAHc4ygbYjbyYB3ym+Mjw/1RU3i7nF4VUmWTMARQc681PHMSRJV+wga9mWyiojBDp/tSibkTqiHw9Ahe5P9fZvnHIA8rbkSpCbXwzJB1Ay/1iQdQb2crrH5+1TSVAIS/JhGZHDXSNn6pwsh4JAswT+SbjIWYg6EQv62iRw/O5jkS7ciLO6hS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMJ5KZlCGZbDXeG5C9rHhhJNGgxquCB/8omiaqsyoBY=;
 b=JT2GeHhWwSi+J5rgnVf66X+kRTc3ZUoxnPUcMbsu0MyGMo/gLstDhL84MnJ/bj1/epInAiB+kaXmNgweWkpE9AC4BSX2pFrbVsj2g/dit6wlxTWJ+gPYNpyPUda8AQ3VvsKhJ3U1oHBN/sEMapF1fEf+xvx6beuGbQnO2+8ADXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB8159.prod.exchangelabs.com (2603:10b6:806:333::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.20; Wed, 4 Jun 2025 22:38:30 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:30 +0000
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
Subject: [PATCH v8 7/7] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Wed,  4 Jun 2025 15:38:04 -0700
Message-ID: <20250604223804.842501-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa1e1b00-e243-405e-5758-08dda3b88796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UI7obmK3SCnMXylYD0RKmrqQHcQSkOOb/7yYaEYvcRb1njl+3pOcValyQnox?=
 =?us-ascii?Q?YL6xKTP7AKljfBZMPFDyn2mt0ky09xim0HgpdvoHp7opahCNP+8EuAnhfc/y?=
 =?us-ascii?Q?g7ptrWWVQTBZvJfHgjrTtTDId9FS7JpBkUZhadpwwy4HLQwxwXnAhpaePpvl?=
 =?us-ascii?Q?UYxL+Mc4SDHQ03NB6T+GHATucKuEjaS96knwJi46asjRgE36gnIODt9KPf3b?=
 =?us-ascii?Q?aq+Zo6JbfvI15Lkf4nchWYG4Oock8RBEPlEc3f0vdFwLBxEbvvReAqtvYt5f?=
 =?us-ascii?Q?T23ZyzatawlPI49xCfA1x0X2Q+8J4PrwzhSySjjMXRM9puygA98c6+NXotjA?=
 =?us-ascii?Q?XkzSRam1ywh7JihOvMKTlXoFRRnYx7JRoDWl7tpb0uHPMAzbD3TGVEZBoqwS?=
 =?us-ascii?Q?+RNan5EG0tj1oUqLuEfFGhmTVaY8rAWBDua+d0CkPeHOLm1jaIBlkLx4rTuh?=
 =?us-ascii?Q?/y5W25kamIddmXyZk/T+12ynGWEad1eyxcalcqHPjKa22mUBiWrh6s54dZr1?=
 =?us-ascii?Q?9n9zUEF5ZbvP00c3WmfXnrlJt3w+oF61u+7rXCE3UpxWiw6e+yTTej3uPYeM?=
 =?us-ascii?Q?+HsHEhAy24CQEJ3iYdPPoDpia7OPotjqczoFYXrEQXZDiif5No/UgQ0+fm5H?=
 =?us-ascii?Q?k2bPDHhtdTigAE1crXolh0m1Z2/9V/4Zx6ktlOdpV7XdVUYL+1ha1OAZ2eJP?=
 =?us-ascii?Q?UHKZdP9mZMbE7y7qudDovmOyF+kpI1GzLSDWk0aOuvIw/x66CV+Pr48UCQRe?=
 =?us-ascii?Q?j+A3TBxXhFImiObxfdAZKiXH0RmQ9Ly5tUX9EGmV3Tg5+6Z/0VVioJjKYzEn?=
 =?us-ascii?Q?JERJ+bkGli/RfL5rBALoX7oWBQovZ1hyOo+ytEBC3peUVuC5mDWu3D7pDNjT?=
 =?us-ascii?Q?kwMZhhSSXjmY+jIgr4obyK5rH+JDsy+JJ5N8ibRbKIX3fNotduYtDpC5uWJ5?=
 =?us-ascii?Q?bHOozWODxymR/i5bGmpnUdlMGt54b7dypwwpa87COOQtWa24ejhrQJknkUKq?=
 =?us-ascii?Q?mhyXZTGCNNc5MaESQ31wHfOHqqz5NzU/S+SMnEpEdR8OHBPrIP/iwkWyVAcP?=
 =?us-ascii?Q?EUHsAQ4kTfXfGNjj0S3nWpa41cMVtxbHXaghDDTz9el1QNr02TqdR+BudD56?=
 =?us-ascii?Q?xhDZvIfAKDojwu4d3f/nJ10XBAfgM0G2f9JJvsFmcR0z91YDd1LRylfpG5S5?=
 =?us-ascii?Q?KQSr/wWBVafjm1y9CRjiM7js4saifknJc1asKXA0LAsMYnlYeBkGv0bMSWiS?=
 =?us-ascii?Q?t4B9h9dRAD7nfrMcIqno/2W7ipG/BBVXU4z3olyDoUDREtDXliwColkaGo9t?=
 =?us-ascii?Q?X5b8rE3hf4p//UYjzk9CBo1uSeQ9iZZU77/JuMV0SkcJ+ngHrHm15y+oo6pN?=
 =?us-ascii?Q?q9oa1cgED7LNOaMI70HXmsb6AU6EauOKHdztEwMh9dJPqEo2/VIUPrLGPldI?=
 =?us-ascii?Q?MQHZHzviBmOYokSbWgFQTxyTjr2tiFR8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z3L86e4Nzy7GZO6J4yR2IWchNvFwr1rCXN7H7cPnIB2eKFI0MxlViuhceCuW?=
 =?us-ascii?Q?lvfPiLORn9Lc19ZdVGY0bosPz86fKXy4YmS5cyqclSL7hx3lDVsjpv/bV035?=
 =?us-ascii?Q?T75x2CsaFcJpbOamyxPO3QrTLLDkw4BcOmQTIYSr3s8tegh4v03y2iCjYE15?=
 =?us-ascii?Q?AuzJiih4qkR+ZaCdnailOwXY9MuejVqRqTbux5z5g/H76xfocnJfp9vCZ4L0?=
 =?us-ascii?Q?742+bs6W3dbRHQ9Wnkp4PLDe97A1o/IdlO5lLaTrmvDZNmtJi3v5ypljqPyw?=
 =?us-ascii?Q?ratvOg+Qg7AEYTKaP6Hu3DVF5h2BSvuP7TsI5F/SjL8lHudVJC/X2Phy5nMG?=
 =?us-ascii?Q?luzf7izGJ2euG3U900qCPjxk9+DVgpL6aXxKMarM75A+wQgR2ph0W/TLvOxU?=
 =?us-ascii?Q?ufZzhaq/nFLzSyJZF1crYADm6LARcDZsEWllxbEN+UiTpw1BFdk7zAbcfh6z?=
 =?us-ascii?Q?HZTdJIDtKAsIIFLj0+vvfpk35I8sC+KdMPKfJ284PeoQkL3prWmqjSy0hCDc?=
 =?us-ascii?Q?WaoSlUjMHCpVLpo736uTSrFdWp2aWTmxLDXHT/4WFeJyLDnF927jNuF7TEEI?=
 =?us-ascii?Q?ZekMULhr3JSUHr4jrNQdYC9FVOTqqFMu8CseE+O9iaVaIBHkWW1aSr+UcVT1?=
 =?us-ascii?Q?LFGIYHnqI7FyPpEkzgch09mI3xlt3AecqLJ1hvhpTIkGEi6mjZ+ZJRoKLUi0?=
 =?us-ascii?Q?f8NII7LB4Bby2yWBXMQJw06Fx7LlOzaSqsM+ZI4O2yeRH8C6CJmPwznSJYzK?=
 =?us-ascii?Q?1gQQLjPdV1S9pN1YnAWCGzvxXlAFt77ADK+BxIKx53tqS1zojxVxYv6M6KPD?=
 =?us-ascii?Q?JBnFC/Vz/a3t+XU/5jle8Q8ia914A1YEWZ3hYjD9pS7J6iE9F43rtxWcYp52?=
 =?us-ascii?Q?kePVevOu29d7mpHne3r7ZA7aUiNGpxZobw0Kxc29nFVzPx5dsE3xkbWqEctH?=
 =?us-ascii?Q?GwHsTjYywUWlHZGqdoOE0Q7d1Ix8/3Rf5uiOsIQ9Ovw85EdQObSLX8enpxZy?=
 =?us-ascii?Q?dtcd1xcTIjRgwXA9qf05WCy6sjptw7VPv3dNESopLlJbtCVqewiEoWLHQPS8?=
 =?us-ascii?Q?iOYF4/wpFmFAMHonGypb9CrubpwIgMXbGSu+njIUfN3P0F6a0lrLJ6Y5gqVt?=
 =?us-ascii?Q?JuvxBF0pYfiHjx16tsorOwwcRstqGhvm5wz55lOCXXDbrFyvb2z3r9FKLYbw?=
 =?us-ascii?Q?9dVzxkyYlkGr1Y0bSjckjBMNwsBbjrqOOFm87O5q5veLVfYg/RH4SMq2X/Q2?=
 =?us-ascii?Q?84PM3wQnFo4H5t6+ts94Gzhfq0ZzBHmSOylfDPrYf5lMmZozZo5maB7ip16E?=
 =?us-ascii?Q?fgzU09uAwkEbcGOZA4WPWls3kzZvGEj1woYmcqoPaWVHVrcPxOu8GAIZXC6V?=
 =?us-ascii?Q?iZbn2tK3oR9HlF7VLplTU/N8BFFG2CQJb8ZEkkvZjCRQn3Lxo86dzrTR7Tqw?=
 =?us-ascii?Q?LTEcYAydAckaqSVxz0Y2ZMhf94NxBBeyZGDWD3tbG1Zf2mivwA/YSGMDN1+i?=
 =?us-ascii?Q?P5otyDYwyIqI5hJw9goYt91n0p+hUFwGS5XmbEi3A+cVzJZJumhBURMI2t9q?=
 =?us-ascii?Q?3ho0eVkhszUfHdZ7ylKG8l4y0pzH01ouER47yDtHVMyrrlyoPXUINm1fjeCX?=
 =?us-ascii?Q?ybLNIwtQUuokO/WVRzoEGCQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1e1b00-e243-405e-5758-08dda3b88796
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:30.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMnuX7ljNbAC2bU1pJBRAHbGp93Yam7+QpS1TWvjSgGoNqSs6jwq1Krf1Jx2/sywyILSeuOqy1DAr3PvHh8JvZKZDB8DOcVtAne3UabbRjlDu1F4t7JnBC5m37iQGKm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8159

Add documentation based on implemenation of EINJv2 as described in ACPI
6.5.A specification.

Link: https://uefi.org/specs/ACPI/6.5_A/18_Platform_Error_Interfaces.html#error-injection

[Tony: New user interface for device id and syndrome]

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c52b9da08fa9..7d8435d35a18 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -59,6 +59,9 @@ The following files belong to it:
   0x00000200        Platform Correctable
   0x00000400        Platform Uncorrectable non-fatal
   0x00000800        Platform Uncorrectable fatal
+  V2_0x00000001     EINJV2 Processor Error
+  V2_0x00000002     EINJV2 Memory Error
+  V2_0x00000004     EINJV2 PCI Express Error
   ================  ===================================
 
   The format of the file contents are as above, except present are only
@@ -88,6 +91,8 @@ The following files belong to it:
       Memory address and mask valid (param1 and param2).
     Bit 2
       PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 3
+      EINJv2 extension structure is valid
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -122,6 +127,13 @@ The following files belong to it:
   this actually works depends on what operations the BIOS actually
   includes in the trigger phase.
 
+- component_id0 .. component_idN, component_syndrome0 .. component_syndromeN
+
+  These files are used to set the "Component Array" field
+  of the EINJv2 Extension Structure. Each holds a 128-bit
+  hex value. Writing just a newline to any of these files
+  sets an invalid (all-ones) value.
+
 CXL error types are supported from ACPI 6.5 onwards (given a CXL port
 is present). The EINJ user interface for CXL error types is at
 <debugfs mount point>/cxl. The following files belong to it:
@@ -194,6 +206,27 @@ An error injection example::
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
+An EINJv2 error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type			# See which errors can be injected
+  0x00000002	Processor Uncorrectable non-fatal
+  0x00000008	Memory Correctable
+  0x00000010	Memory Uncorrectable non-fatal
+  V2_0x00000001	EINJV2 Processor Error
+  V2_0x00000002	EINJV2 Memory Error
+
+  # echo 0x12345000 > param1			# Set memory address for injection
+  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
+  # echo 0x1 > component_id0			# First device ID
+  # echo 0x4 > component_syndrome0		# First error syndrome
+  # echo 0x2 > component_id1			# Second device ID
+  # echo 0x4 > component_syndrome1		# Second error syndrome
+  # echo '' > component_id2			# Mark id2 invalid to terminate list
+  # echo V2_0x2 > error_type			# Choose EINJv2 memory error
+  # echo 0xa > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject			# Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.43.0


