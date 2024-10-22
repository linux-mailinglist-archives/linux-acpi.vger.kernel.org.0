Return-Path: <linux-acpi+bounces-8921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92C89AB8C9
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C381C23400
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637A1FF7B4;
	Tue, 22 Oct 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JWZTQiKq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BF1CF5E6;
	Tue, 22 Oct 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632899; cv=fail; b=mqviea2Jfmf/OpkZV6Co90vOrBbYejiYeSnX116WVRE5TrJikpXlOeyIJQ+9I/6ZQw+9nzlSuiwlIFeySrN3maicWIp532VkEu8Ruu9fUxvsb+T0dGazDJrHKuA0VQJegF66tSca7MdDd3T04Sbz2ZFxWZ5r/+xeDeDAYrYcuME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632899; c=relaxed/simple;
	bh=iHnv+npEb3r+z1QzrBsfyz29acI9VLmO7cSjsXE/b6I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgqGwG2EUEN/m7pTWIiTBy8yjQAzSl0ZnHVHx/tTQGPyaD153SPtRuuQqs6PAfbgxsaZCzPbQH0Vur1aSjJzdNeEgSbk20KX40SYkUyiyMAVZrgLolM3DPPcp8fg/dEuIR+tMCJrZkUL/irquzalNhHo1HW7cBdtFKVpWVLPWF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JWZTQiKq; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkzROVvCUuioLi+KKF1Eu6d4oRnXjXN2jbAJy4E8QbBTfwUBDEEd82QAloekLiXv/LcqwYwVmxVdL9D4CWetx1PBIAPUleLQHN5JC5/UIJoJnc+8Sqb1BSkfi8+vGIpcFms/OYXAHACuipmbf8I8kRbBJnKGPhvixtLMVWmMpIkm3WzticuXW9pksQbgjUaZX3eZE7uhkPXChf6YFgDY9eL5DH0OLb1o2lVEQg1APfPGiuHVFnJs5g/ggkDcbRzAusMpOMAnZIIMqNxzqrvTeygHp/ASr/WZSMav1kFctyHuJGYGePdEKGoVoxUzqVYzStNDPraZDpIcyTxvA/Wxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6deruYvRe8MdBxifjr6eImpHSrNQnDP9yNtvWcgGjfQ=;
 b=d7UjphpFxSvRSwwzcDSnTcIPKXgDqpMMnwohTGggRjww65N3KHysHlM+8ZWTODcOOaf8gIustCyU6B4nn88vU6UscZP7QfHywYZHkSQvYD86FXqhHuOG7zCwFqjN/uw/3YLN34IhfRukpkBAzROtYU+muwHeizPBHy62F7W10vD/AVfxNUi9hvI2jDkJqJC9B+zNIB4Lsb3jwQNauJUBT8baBUsh4L1mlLnfPpafbDvZGIVjzlwvIDMfTuzHLBAABpvsMd57SIDSMc9fWCtt1a+KeoBedxl7NYUQTwuwmuohUuZ0OiqitZUz6Zems//cGLb5EUDEb0SpPuiOaYNggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6deruYvRe8MdBxifjr6eImpHSrNQnDP9yNtvWcgGjfQ=;
 b=JWZTQiKqJrGwmcu0+p7/zxL6v2vnUvgxBhCdSxmpIia4mQWDLi2jEWWNtkL4rcJEm3izgo83IJT+/gl3zAH2nFi+lyHVgZzbEg3QXoXZoRp4+SAzcxFiaYHSEVgoJfM3jlx/6xL0GPRSL7H+svP0gBZv3pFn1BEexXXMgPlRdX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:52 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:52 +0000
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
Subject: [PATCH 8/8] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Tue, 22 Oct 2024 14:34:29 -0700
Message-Id: <20241022213429.1561784-9-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS1PR01MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d0e2b0-d617-4689-1fdb-08dcf2e15d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lK4R6qGanLMimTkA6dC1N01HoVjcaftACYQHGallws/4uW8oDeelAO5Amv3l?=
 =?us-ascii?Q?k3tnjf8IOwGaOUQRyrcKR5woeeZ3Wadas3dq3BKIs3zyeMDz66b9wcWzkHj+?=
 =?us-ascii?Q?0srKkc/OuVB7gBs1GNuANVkipLpeMl2Oa0rOdm4Es5nnB2UXVWSARsbSzXZz?=
 =?us-ascii?Q?kDyJSHXRnp7CegM/1GzCL4d4oEbqn74GAyWbYbwx8/rz8uzI8Gh52lpEYO+D?=
 =?us-ascii?Q?Mk/MoO9l8IZ5Q/nt5UThEQI607UZ1xDsAHSDF+2Btvci02/aZzEpcAS2H63J?=
 =?us-ascii?Q?qSSRQY23XBTFxgh9h7mHD69vDqELF5/APeWLh3z74mQmYCSLH5dRZ0PukheH?=
 =?us-ascii?Q?Ax1H3Ls8CXvGjuIT0ho6OBrE0J/75AoRh7P47XIYbUL6jQmtFzXYb32lAJqy?=
 =?us-ascii?Q?fF9FO9yR0AAJwmdvM6pVBN2jeX3qV5dOG4V5RR7QDHFx8WCICVuyJuSlmIhy?=
 =?us-ascii?Q?FgRct7bMOJyArlJGyOkNZ+DdwGbI7uiiFx8b1PyGsxbsyDEgbx3czuhR5gWM?=
 =?us-ascii?Q?HUb1fwSUWrDAwOlqIssyKoxETQY+YxMF1xRGdXM7JFfQ2poOGcLtVjN37h8m?=
 =?us-ascii?Q?hjQI/Ws8jOQdVc/SoztF6ziHoEPZ14X8O0wyg4BrLLluwGRD1HRyz+1hk2LC?=
 =?us-ascii?Q?L2VSPaUX7xy+7DNB2jDu/yIyXiPY8MPHUL/MgapXn5H6ZRdMKAqvs2+o5kFf?=
 =?us-ascii?Q?yZsr0kzhg5M0+WcdclWgflSyDlIwhW9THGuV6Ie91yR0xuKU60ViYYdIazU2?=
 =?us-ascii?Q?8sI992ncaeLzhPD38nisv4+hnIBWWeQItk2xwKY1sUbYxvkCAY4j0gvXtcdE?=
 =?us-ascii?Q?yPVrOShcawhF8vmrBoaT3QhHbQz/yetB7vZLQdlu0hK5OhbkNDkTJXnqCVeU?=
 =?us-ascii?Q?PVhZjkFWbAvpzzHbNb7NOswIW2pqMf9Iqs12PUH8sC1FnfTz+2r3ND9MOzCR?=
 =?us-ascii?Q?QBc+hFtvSnFRAQsGTtWKsnqlZ5BkARRZHRyA0g3inavC0mVuE/eFfFMIvEXu?=
 =?us-ascii?Q?l9rehIQtUCsKGnb887PlfdpbA/fIbOGnlF2yBmvXzcReV8qrAthcgK4sXJco?=
 =?us-ascii?Q?VayN/EzbS38e3ao65pIOfmr/bgmAY0BDoc1gXy5fHZr1Ba4qAYtBH6v4aX+u?=
 =?us-ascii?Q?klOpnuje/yPi/nB9X6fNcscZmZb9mgg/qd1NjXFlilryzpExdY/v2TctDmud?=
 =?us-ascii?Q?1Hal8C0E993wRa6kCB6GRSIiQ0jR7QUHlrpC/4YNznObJ3vVuEkIMTBEp5MF?=
 =?us-ascii?Q?1rUfgrgc0jOYpzugMP9EO6qOxcVeJSDCeMAz9YVy4jt9t2O55ZU9mdAJPpZK?=
 =?us-ascii?Q?31GMPH8qoHU2PzWUZG7fCURitWkZxNlS8oVbCfUusQxfrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7KMzdsZItmbjz60o8GT2pnsilOsD7OZ5k4vxH8xVPfSnM92gQmINqybYeSl?=
 =?us-ascii?Q?ROaoD9/RzoMUETOwDOrR66+ujv3Ztbz4Ht9UJ506NiQ5Fn/idOdjQv1eOWZr?=
 =?us-ascii?Q?w2PXzopo/s5QycpnFZDPR2SLMXJwHpKBasswQef9WC5QS8vZyRY5Ao6Sa2ym?=
 =?us-ascii?Q?3eXqY7uk13kdk+oZGjhqqHR3Wch+zbfGaDIYO/XUHaye+uMTDMTW6EJz79mC?=
 =?us-ascii?Q?cwFDhunUhjlYQ1UTYycaDUxeSpbncu+XQVjfwRJcqYkD0Vj83I3ni6pn056X?=
 =?us-ascii?Q?NL2Mr6BLY/T7SaRIHn38QJVHcxqmWUXOsSTH8k2TUERcmiPFxx2BDc3/8JaV?=
 =?us-ascii?Q?8Nfvn7mMdsXG4RqHjB1O80CdtSgQfAuG74wUGLaRiimnJ7qyfiTdT2zMxBZd?=
 =?us-ascii?Q?3YeHSFyl713pZnN+FaPEUGRn+z67BBOn+NjXKeMus0N+LkqkAYeAmztbmQfG?=
 =?us-ascii?Q?JPyVZmV1GThLJjIJDdy4y2Jw+dgz/jkejLPNEX4eqe1PtNRhmjPOasvrFL9H?=
 =?us-ascii?Q?OJ2M39I5Q51n8k03NDHaNzMEqPaw3axFtf18rAxbChPswAv8JLmJZgxy2mYu?=
 =?us-ascii?Q?zhCPir2tItsuFv8GCORCKA52jIX08fjEMz5T4p4oWUAU2Zb4qdcs5YY4h4UR?=
 =?us-ascii?Q?IfW5zq2M6HDhMyW9wy9MYd620iRehVna2641FZKuGYFFjKgfRK0+NuDgDgXC?=
 =?us-ascii?Q?aWu/NAi1EhMt++1C3kpufUUS1IzqE17QzpR2rYRcUqH0EXPgOrHn1BZzpvEM?=
 =?us-ascii?Q?C/x6FmIvPaVro2Nk29uDD8oYOaV6VvDW5/kVAvAbtppbVAIip/MmGBRSxW9z?=
 =?us-ascii?Q?VsJ0zkHi28OGEtant4JL55nVbnj+a54fvqRGhlz4sD+d4Eql25QRowQs72lP?=
 =?us-ascii?Q?xQQ23rMUs7IPo9BUA/KNg+xC5D0kU/lOaEGlKbH9X9a3TKdSpWSZg5ZTp9YZ?=
 =?us-ascii?Q?FaZ/gxjC6bZIQpX6DfhD3ieqzL1kvsN686VlZJ+/NcrVD83d3uGdVSWIss3l?=
 =?us-ascii?Q?nYcMOBijkewSK1gSjdhs1wXUY6J3TqjG0EI9wQGQ1Fq9CChmVlYK8WX0KRIA?=
 =?us-ascii?Q?hA7lDSmK+TQvgiqzxzblZlVdGpRZwJHP2EY9iQWirSbroLV/nJzu+oZ7gY7/?=
 =?us-ascii?Q?si/bPpTgdj1M9FRR/7ROIJg3xWCwbtpSIMVXcMVNUgswb2qNQsCS5wwfxC/u?=
 =?us-ascii?Q?XYFrRvJ87pJobOCv56C8N10omwVwMEnGrZOWBEqOHQaDvvh4J2GS6yH64Swl?=
 =?us-ascii?Q?t9rqs3mdF7/agL6jREmjnZeqcjgQxKKrn2yTa4byjyXqHrrPHsIIqLT7pEp/?=
 =?us-ascii?Q?znGypvhKjRtPdirmJoZwlNyvrZmKipjFRkZva+DfflYve55Qrkqgl/vwo79m?=
 =?us-ascii?Q?xeVjDz6SvOnRy+p8bTXEfLFgBrjJyhi015RTxMLJIpzuj6Cvms0zisuSaDj/?=
 =?us-ascii?Q?0s5nMX+zwjAsBBp3XxIkpxzAMLoqEjhautZNBWOd4mdmjZmI/hvVe8RuSbvK?=
 =?us-ascii?Q?t4C9fGOQjT6ag5pzzK1qoKPJNFIIQyxblydAFLWGPzgNSblmWfwSxnQANgPu?=
 =?us-ascii?Q?JjhLYmPGG/PlxpwzWhkc7NhKPbVTCHjeWdVHdwaqFvmpqwYUY15SVGogSvP4?=
 =?us-ascii?Q?MMU9Q+xBbQ3S2KCzdGNkhzk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d0e2b0-d617-4689-1fdb-08dcf2e15d01
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:52.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyTECuYg5rsLvhPyLRBCZrq9UrVKvkFvoZ/uI4KUCXIRWO1TOk5aJIm56FgRzL/W0/t9nOpMKmBLq97+8NXiv2P738021pJ7CHlKIgQgnSIb98va4op27yMLqOQkILSX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

Add documentation for the updated ACPI specs for EINJv2(1)(2)

(1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2)https://bugzilla.tianocore.org/attachment.cgi?id=1446

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c52b9da08fa9..3ad092111035 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -61,6 +61,14 @@ The following files belong to it:
   0x00000800        Platform Uncorrectable fatal
   ================  ===================================
 
+  ================  ===================================
+  Error Type Value      Error Description
+  ================  ===================================
+  0x00000001        EINJV2 Processor Error
+  0x00000002        EINJV2 Memory Error
+  0x00000004        EINJV2 PCI Express Error
+  ================  ===================================
+
   The format of the file contents are as above, except present are only
   the available error types.
 
@@ -85,9 +93,11 @@ The following files belong to it:
     Bit 0
       Processor APIC field valid (see param3 below).
     Bit 1
-      Memory address and mask valid (param1 and param2).
+      Memory address and range valid (param1 and param2).
     Bit 2
       PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 3
+      EINJv2 extension structure is valid
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -110,6 +120,7 @@ The following files belong to it:
   Used when the 0x1 bit is set in "flags" to specify the APIC id
 
 - param4
+
   Used when the 0x4 bit is set in "flags" to specify target PCIe device
 
 - notrigger
@@ -122,6 +133,18 @@ The following files belong to it:
   this actually works depends on what operations the BIOS actually
   includes in the trigger phase.
 
+- einjv2_component_count
+
+  The value from this file is used to set the "Component Array Count"
+  field of EINJv2 Extension Structure.
+
+- einjv2_component_array
+
+  The contents of this file are used to set the "Component Array" field
+  of the EINJv2 Extension Structure. The expected format is hex values
+  for component id and syndrome separated by space, and multiple
+  components are separated by new line.
+
 CXL error types are supported from ACPI 6.5 onwards (given a CXL port
 is present). The EINJ user interface for CXL error types is at
 <debugfs mount point>/cxl. The following files belong to it:
@@ -139,7 +162,6 @@ is present). The EINJ user interface for CXL error types is at
   under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
   must use this file.
 
-
 BIOS versions based on the ACPI 4.0 specification have limited options
 in controlling where the errors are injected. Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or boot
@@ -194,6 +216,26 @@ An error injection example::
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
+An EINJv2 error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type			# See which errors can be injected
+  0x00000002	Processor Uncorrectable non-fatal
+  0x00000008	Memory Correctable
+  0x00000010	Memory Uncorrectable non-fatal
+  0x00000001	EINJV2 Processor Error
+  0x00000002	EINJV2 Memory Error
+
+  # echo 0x12345000 > param1			# Set memory address for injection
+  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
+  # comp_arr="0x1 0x2				# Fill in the component array
+    >0x1 0x4
+    >0x2 0x4"
+  # echo "$comp_arr" > einjv2_component_array
+  # echo 0x2 > error_type			# Choose EINJv2 memory error
+  # echo 0xa > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject			# Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.34.1


