Return-Path: <linux-acpi+bounces-14426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABCADDC5A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31C31940BBE
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B612F272E;
	Tue, 17 Jun 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rVBvlRmd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951412F2717;
	Tue, 17 Jun 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188659; cv=fail; b=sTQ3zeVp/+dmRHC5RSe5XNVQND5W0y89xzbWikuX+y5ftJ3pZHfNVKgcggxf3RoPl+V5g5c8ept4s8VNwWaw+SYIbEwNKJ+I8flR/6qHOW5tvDzn+n91PZhtdG9dxUliXq4GCaifLI1wI+7S17vcmpUffYmFTg8CPdstGWTjQbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188659; c=relaxed/simple;
	bh=D/XazX5aC7b2ef+GsqZJ2uq0XWVcymdjPiB/jocYShk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7i7Cz4Nnq4rtfoYTeeULTA5DUYzj+yJRTdVQ4CLJfUbAsCRAHzZ+OuDeC3M/JhdbZ6f7wLAXKn/ul/uUemtUw0iNFFPACOujQunYtuCBlQYldaHOmRWKwG3MHjQKuLhzdRCYDHrlO+D8t/FNTe2BwcfTUO+4MC0XeQp55Llk+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rVBvlRmd; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBQGnMz1Pm9F/ulst4yWNsizjQHyiBt/lPTDbPOSEqeByzD4wLwMHM3ZaSGeIw8G8zIw1WkK1wHJRnuGQzLaHxn4Id9eKrMLBwvQQbpXoxmKYoRsPUS5VNSP7q5GwgQ9Gt3UO8ggSV6tt15sTIowxX/n4xPFy+l8oHD+ZgVE628bu/n6GoCH/jfwirigfJnCiNLe+d5JTlzc60Bly1THaEoT5R+g7yvNjWtfvyG7KGQOqnBYslBCGWD19RgM/d4ZG5WAmTZzpiqjmsDA6QgunA6/J66YzDxL6kf3COvdlkWpq9uCZBTC7w0J508DM4SdPifaiOcXUXyadXbhTFqF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/OE9pc6iG3bYQh/l1XPeBfG5hBLjZnfuRmYsj77Q1A=;
 b=REfe7ujfLfD2K3WIj/W4hNzlr9QgjjS9Q1AIUykTExsyYckjEw/gXVwScU6DOts6MltHtGe3OlsBK4wSabGlCRbvnrFd+TBDCEFblWebONgmUKztWHsCwZUtITkLfZKJrZmetZqNcjAhHAEfTJLgP5mLW47uHTii7IV95+Rwl8qq+WY76JWHPojqCUa36HE1c/3Z6qRAJuhdvFQ7U5D5xiGt6nj7+jYs6hj92iEJzYZ3tKC+4aPivVkgzpKn7WSqplD1RlNGTI49PnuW+8HwSIOQuQsVen1Ceh9tHwCA+TprC/JRbzBUYVNC8cCkKldNHQpMxquNGKiYtYfJAVaPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/OE9pc6iG3bYQh/l1XPeBfG5hBLjZnfuRmYsj77Q1A=;
 b=rVBvlRmdZkNODsY+E/TBW2e04kXWmPoJYMS9N+TCcCVv2A2HjhPfuQH0YSdTm1fjeB0tKK10BVFcSZsi5n8cbYECWqy9BGH5Zcyl336g+d4Sz00ckNl0JNxNmuVrNpj924Ud3fbUWVZShIPCxipsmkc35v/iQIIMtOilLeQfhdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:55 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:55 +0000
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
Subject: [PATCH v10 7/7] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Tue, 17 Jun 2025 12:30:26 -0700
Message-ID: <20250617193026.637510-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7548b17-5f7f-4321-c5ab-08ddadd57a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6V4XjFgMmeHl6oG/cDrCk62MaaNTZL9E/ISLpSnjK+L5IOJAwgaiJcCqOmdI?=
 =?us-ascii?Q?vYbSrkozBBaxbRx88PhYIU0qGe4bEA2dvBBDPLsbxrThTeApcKsuRn1szabM?=
 =?us-ascii?Q?9o+OPZUNz0RNx+K1gUyuXshxnlEk6ij8kKe9Jsf3eYL0ZiGBGUjE4FL9hwGV?=
 =?us-ascii?Q?F2Y6BmRgnY313yBM/Fblbl+TH4qcJJWADc1x8a0frvXPU0//ysC/suzUzFPT?=
 =?us-ascii?Q?gFp6dLNQvFSYG+cblBj5P0r/2IoOaFKHHecSihGSVzFuJQumuYemiuCVizpp?=
 =?us-ascii?Q?7Q1IXqewCFhvu76Nn4nw0v/B+NCDPAfNiMas3+t0a1hdc+afwp3z9ZPvCd0P?=
 =?us-ascii?Q?biaBY3B/uRuWg4qFSxMshb2HQ0+nJOf4LQqaI9zU7XkYFktE4D5mZoNp7mrJ?=
 =?us-ascii?Q?VajhkDKDmH4nw1KBJeDcP5EQakudgi45akYZ5cr/69nH7spJx9jjVNmsZCdG?=
 =?us-ascii?Q?jE744E9y8HLPilGt6OgSYfnK3BEyDTClZxY0pD8f8JaRB02TEuPmGJUxLOei?=
 =?us-ascii?Q?m+MsFV6jZFLWPPWttj9ioggfeqe7O2VpcMcAV6pDuUB1o5v2qpVZyZhmTfG6?=
 =?us-ascii?Q?WAITETZhMifKWWNIOLYjG7DLBdlFlu496KF9IXGOrgTcKTiI31SfuoApaQaT?=
 =?us-ascii?Q?LsNRV6BXrW2O4qYhkr3y0F9GtqyJJNqG6zlZWeTYnQadLVOVwZURJxH8qAov?=
 =?us-ascii?Q?gx03lTQNS8oNEWpcRy/pADZqI0VJmwpma9OOOnWSPVWOmWc2i1/XhWjetKC8?=
 =?us-ascii?Q?hMY4yjrUvhWMJgnn/iyuydOU6D9X6Z/IsyTxJbTVMpKGsQOKWUngmJy86TgZ?=
 =?us-ascii?Q?ZpEQ44EaCLcGmsfb22JCGVzf41zY6AeI5YPiCIQq+WSWwcfPZVzZhdqUmYCG?=
 =?us-ascii?Q?95igTK8oJfj3z0mAbnJ7YYIQSjaurSRRDuw30sVdVeszdE+vU24LjAgcr6gF?=
 =?us-ascii?Q?9ueH0uFu1jP7sGh/buQbvrlJu9CUrUwQedqb7eTFwPfW2wRW9Rohl0xeEL6U?=
 =?us-ascii?Q?7v4y+WRCzh4dofah2V8FAMTexHUnC7x0RsdKgPQ8+53kWFg8WvbbVo86kdyE?=
 =?us-ascii?Q?ACG1Exup4nnZkRrAaw0grMfBOQ3dcipmteMagXT8gqFadk+aGhw6Tni29jd+?=
 =?us-ascii?Q?VBLcIAN63iydvoqqF1Jcrp9OleiezzgDPXHkObdlqQZnyQBWGLmJIx9lZo3K?=
 =?us-ascii?Q?SE8r81GrWk2CDYVIXPm1H/V4TSGRNOVE0Xecv+t748WvXVf8hah+K4gW6Ddz?=
 =?us-ascii?Q?LMuex40LvqjLIdcackPiVANxrKHqwWuqH9jh1aPsOI3GN0IBsMtOthKEEN00?=
 =?us-ascii?Q?eyhcuQkmDNs/Iz8+s+Lgf+tlONnDJaQXintQRUPJC7bFhdUzVQsy7dUnOLPS?=
 =?us-ascii?Q?pC+5ApozcqMVlbPAupN9wZbhUmZeGLvWaTVMpqT/Rp4Z0yJwo2d7TZi5hkQY?=
 =?us-ascii?Q?1QPPBaGvqWt6fsbO+uD5uPmCIXBzPIru?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEvrg4LIT+R8yR4O9Hi5O8wjh4ZGVPYZCJ6+QUsb5XR6cYXEd6Fveug0DaNb?=
 =?us-ascii?Q?+1Ji64Zoo5rbK3q9bNMoQrD8otwj9jeutpi1HFFWUYFeTjHmJjdHAdNQsZA/?=
 =?us-ascii?Q?0XsJRHIrsqn2ay6pDG6VLQnN3aU/CUZyPTqy6LcCXE8Sh54FqAsVYdYImoqm?=
 =?us-ascii?Q?tQ5/AfkKaQLYuzEdw9B+tP1Rziy/uraMM4ZOXtVdNQ/PAoFVlfokpxZqXveg?=
 =?us-ascii?Q?a8SHb0LA60PcEj7uf0q6QtxLMoaQPsjrVqjHG5PwSJ3g3WuefHKStLeugwOC?=
 =?us-ascii?Q?YHaDxBcFFa3iNCx5sapoLiTajHeGbyJ9xPk9hRRW4/poWbIRbsNw7MhmIEMR?=
 =?us-ascii?Q?VE8BUZ/ziYCceThjELaiUPNOGzz0gCXZhWIFfBdOc04gawpwXbECJCZbS1jG?=
 =?us-ascii?Q?jaMiXFQFMoL9t9R70o+HB1n3dMymd508tT3gJvVCnPtH4qi6WnNDdYNEgPnv?=
 =?us-ascii?Q?iWH4mj3n8K290fe+QrHPWgM17ERZ2L5GNfklkfBAEM5bltZO5YlDr8fITxa0?=
 =?us-ascii?Q?/HW4v/BUQltNe2st7Jz/Yz3r1LISA3uWjgVhiMejVKBAhdQ2Uc8oBVhdzsJD?=
 =?us-ascii?Q?gJJr0Vr49RP3zhmr7+6eEpkej+NPUo0k742OvJnAWgQH4YQJWdyGh7rFqRyX?=
 =?us-ascii?Q?3+MGuG3bajtTz/r+AIrTK/aBWFpevNH0wd2tNM7cLXxmJGIOmoPaw+bCEzXp?=
 =?us-ascii?Q?qygVv4F5eZypqJumX+CVqoHo/H/PRGcwDH6pnwhU/ZGxiW8nFQZFBNrE35LO?=
 =?us-ascii?Q?K/h6qOtvEMr2Co9dxEM2nbItVWve8MiHQ7hLEW9YcNMDblGKCy2Ztzb33o8x?=
 =?us-ascii?Q?IyOjm0vdnUmdUBZsh4QXi8nxB4SDQ2OrDGCjQ4Cz1EtZF0XSVML9Ggycwj3U?=
 =?us-ascii?Q?C7JqcFQvBhPCfEBx8Wej9YtcUDghkkOYXdXFOs43l9Ng8LkrKuPp5JGtEr4M?=
 =?us-ascii?Q?13LvJnotMpxJqhdV8pjkKa7U7LFqB3Wu1EqD+isXFPL1iDsVvoVz9PlndI0A?=
 =?us-ascii?Q?FOQ2bJzw+R+3Jmg/I7cP3NAtTCRuen9Qxkzsrhciq1jZ5eXmI7LRdbhkDpeL?=
 =?us-ascii?Q?Fwe9uoIv9SL0uAOvi5vo2XH9ciSW6CG61ps9gZSAFU+vzMaP02p1oPQN/VP0?=
 =?us-ascii?Q?ZBjekhh6w6HfP1epfQhRftVXb68N3dlgctUyy6Xh13yjI85IPQBB6xofPLCl?=
 =?us-ascii?Q?HzWjVEeDV3bTMk8nue8wK9habWJtFH5enuwAQ3y/roOhc3npRheFwk4rQ0bi?=
 =?us-ascii?Q?tC1S6iFVBdy5r/4xiEHoYBywF1ids+o1EwuhCpFCrfQ4l+SFZeMlGDHSWozg?=
 =?us-ascii?Q?ldPoXV7IBy6Z4KUdMK0bcyvsljx7+lB4Xij8nBgaOePzeVlZXTBfsv/nPiTs?=
 =?us-ascii?Q?HVS1g7u7YXxMK6MuZP3Dugdkq+fnAC8rSAKJn2j5aSDJjVkMlmTw9mG7CTe3?=
 =?us-ascii?Q?RtMQxPQ96BVlzwftb1R7BH2keWAlOxXzrx/0eJUIIiR5EeF+jvwWIHryNx1L?=
 =?us-ascii?Q?H/4dJbe6sPuf9Hl6d8sGB8X5uicwuf5jU/6joQb+PbJ24b5AxM9bIIlAg34m?=
 =?us-ascii?Q?fNNyb8X3TZvUxinlWDesGjnZyKGj55nlwhHiacOHXgIhWMzhAkl457tOW/Ud?=
 =?us-ascii?Q?qb8iLX0Ic8GUU6ROaLz9kVA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7548b17-5f7f-4321-c5ab-08ddadd57a7c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:55.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej335QnsurGgHIKo0Bt2qI7FYUWL8I7iG+LKPZJRHwuvXBKfNMCHxtXmykiWEO2693D/fw+9X70Ubv7NMt9Vzd+7ZxWN1AjQVEGG/3QNBsuUh65bTr2We6Jm05WJ2Cdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

Add documentation based on implementation of EINJv2 as described in ACPI
6.5.A specification.

Link: https://uefi.org/specs/ACPI/6.5_A/18_Platform_Error_Interfaces.html#error-injection

[Tony: New user interface for device id and syndrome]

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
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


