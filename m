Return-Path: <linux-acpi+bounces-13108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260E3A92D12
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B9C46599D
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130A2222D8;
	Thu, 17 Apr 2025 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Wg/TxSKm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A92222A9;
	Thu, 17 Apr 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927254; cv=fail; b=ZGwIbW2QxOHENFjwXi97rJJlGdzIaXY5et6l5FKl2YBg5mtXp5EZHbnpoH/EcYCzGt7FIC9tQedtLr/DfUezsQSaaudwCE/QQHJVco/RG9YlzD2v+lQZxI+35+408jWdXsyNqU6a9wEO7I/oSSFpZJHQVra1ji5UyVxwtqK1I9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927254; c=relaxed/simple;
	bh=PNEcV5WXaTl89tmntZbZ26Jmw3XvbC5UpGilY1EoAuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=le+TTvsvQ7Y1fr1ZCXGm9PshInEAYIegy0qUDd/Oj350NJpqb4QCIpPn4ltwctbWGIKckQo7k/SMQJ13XXEQCzoDAIvI0GGVy6Y0HalsGMj3zX917Rv3uu5pkcOD5lb9+4AJzzO9l2WhpTefUM+6jAFdNYfWo1S9N6tbcVZti6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Wg/TxSKm; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKucfasMLYTGVnxZz8qJs3PYUhXhBFp8voUXXWyKLU6pwVuTl8W7NZLQdTAWhBpIrmXH2KNE13XEZTh/eQf9/Husctr1SahJPtsFYsZ1w8nlbQXOiGeSRJnsQfCTX/Q0dnn3par5bsMkMGkYyj1u5IB+fWl7WsOYVzmsEkwc8XoT8fxM3Z1QCduK0gvnY/7ZVii7VrlBae7C8LLA7Nq0CdofHT+ypOLGQekLt4LT7dAxObHAohFxvbjAyoDgf9n0yRawrNsu8ruqYSdyTjD1Gv/mnPQI+FT66HxF/IAeZmosFNmQkxtPjKCa+crQOeLEszXbOdj9V6WeiNurAn3zpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cP6oVO+3xZZqXf12B0fYcRcH/7BiO2oARAWntCa2is=;
 b=FtcvDOxrAoweb1kBonZHP0W7tsqvnliNwimEYwNjH0aPwac+HlkA2bepwl171XPrQG0qPOfLYdyU728yl8ZLHMOJXS7vukMHBlF8Q887f5r+MGj2azruN12egtZfMpvCtrCDWxaofJjTaq8JDkH64KKZA2WtYWcYkrQQUM8KJBhKzDMYXtvOIdz5QnA+ZRAF1z8omuyWWjdBYN7oBJtbaBscMxt+fCKv9WxrOgdoaDKkoyIyiAItBXAL808i8voDq4hVxwvIx54f3y8YLjWigIh7n0wULnwWf/1CpLaKSKZ+0yaoqUhGTfZTTUUid8WbnLG2FIKv4rhLI3VpTiIYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cP6oVO+3xZZqXf12B0fYcRcH/7BiO2oARAWntCa2is=;
 b=Wg/TxSKmtWi2m7HI+6mPtUfzK410/qZ/ymDUDb+iwVSPsrpwQicFgRBS3B5kyrZ+qQ8BdgGKww7+2hi0oUvNq1rSJkJtRSXipSgwRckfKUVJ2y4fGdQDqYwG871Pbb2Xm3RsJZ17J5B6J5wPDnQt8LVpV12qQBSrlIeAgMUV0B8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB7327.prod.exchangelabs.com (2603:10b6:806:1f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 22:00:44 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:44 +0000
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
Subject: [PATCH v6 9/9] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Thu, 17 Apr 2025 15:00:19 -0700
Message-ID: <20250417220019.27898-10-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: df13f759-c2ed-454f-22e2-08dd7dfb4d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IgPWr8M8OM3bURzr8Ulb70ALTZZsc55oca/6QUAW1NFf4wNWPs9tmJLx92zj?=
 =?us-ascii?Q?xepiKGK5t4Dj3FjjhmkDSoOHlxIYqIqJyqVeuPXD3VLgGSw9VFpD6BvHA6ev?=
 =?us-ascii?Q?+ARSjvmVPnyCSHtLpzHHWf4su0qdg/7kYICZYfTyGJu6hGvcwtHD2ykn5Rk6?=
 =?us-ascii?Q?l8YnkYtHYEt1rajdgDByM0aPm+5NjFsycLcd07BLGTa0Bpo31ShQ4jDoymz7?=
 =?us-ascii?Q?e0J0yPWaMcUNYU6tYYfEjc4fwlbjaW5RnixSXQwnUSNFZ0Fbz1ML4LlwPVTE?=
 =?us-ascii?Q?SUHQqR50qidVE7BiYHDiEfJ5JqMXv6HR9FSkr3SGn1dO+U0a8JPw2InnvePC?=
 =?us-ascii?Q?ixetkX86SX/ZD/KQNLfFljoser1gxqbpOYM7oTjbG0owM/7+h56c9NCakuTZ?=
 =?us-ascii?Q?XX9AECxs/pyPvYBuWrrwtFqlI7sEj6FKZ8GYjXlK0Ol4YYEUxk2nno6XF5Ps?=
 =?us-ascii?Q?cAbIcHH7+Z8F76lvsVjYzdPdDHXlBeaJLBtjUzX/JACZfF1i8S5HFAMuc4Vh?=
 =?us-ascii?Q?OIu9T90ftSffQvdI/o82XBsF01Dbtl0yanrhFnW2pnwfWbcOcDgyH9VoLedS?=
 =?us-ascii?Q?uevV0wW67a8r6ELPbX9GE1ClsVkgJKpMQ3RiM4PPqB96YEjNWdgwsawzTtDQ?=
 =?us-ascii?Q?P3p0sWBwQvpIvqPTa45BBfGvdabvjmtR54bQV59CHGpjJ8EjZLVlIYaqaDtj?=
 =?us-ascii?Q?MHVZp5EbX9CzHWRWFX6cf8Vi5QcZ+n2WGYKsto+NKSBwfSFJEeqBFJbo/nlA?=
 =?us-ascii?Q?Tq/YYJ0Saa6CFWHXEgwIzD5S13bYdaP1dALfTVgVDSeZO42+ncg2fNKZcWh5?=
 =?us-ascii?Q?Wjq3AKkxMZ+NYedZx5xLpF8kNgtMR3OVeCKqMbCJZTRXqsqVOqR0fMnhJGc7?=
 =?us-ascii?Q?4MB4ZSTW/QX0zIf1f4DyrCp+t7MZ0z32C0HlcMJ+yE5br4cwtAnZoDLea15K?=
 =?us-ascii?Q?1QjevK1XF6WHi+4NYaq4LPNfAzENUvMA0/dRdhVv450Jdw6O4XoH/ibd1Whn?=
 =?us-ascii?Q?f5gTtL7ZFM9UNaGWE4b47F/SRRIKQFdCIwhtQmkghR8KmFdfq5d5KKi5nKiQ?=
 =?us-ascii?Q?ytttTR5F0tDJWsDpNhNJOOU616E9sr9wH91OGyCUoUWAFNj73dDTFRfTxEh5?=
 =?us-ascii?Q?6W8qE7WEOtdIgwJdBRaQv6Ftqc5bIqE+FwozRW1XHPeMUcBW6shYOV8eG+mP?=
 =?us-ascii?Q?IBsxS7JXlSs5OXFfET57lONbf0RkwhxfVXMNDsAE+RR7WkwjmctSCENqGiV3?=
 =?us-ascii?Q?JS/+PX/rectuZ7yeMwe1Ul7m5ttkypR2YLsdY+31mWKMR1hYYqyj3i5mCaeU?=
 =?us-ascii?Q?32Nq3butAbYCwV+w+qL13gXRCM0FlyhBW+sUUEfQ/1QSJ3IPIzKeDbVvdpWC?=
 =?us-ascii?Q?Kkf8GJuYGZIndP+MFgyKCkDuYAmYUmieQ4OZRVU3MD0U4VX7TfGK0Sl7ZpDI?=
 =?us-ascii?Q?CIuZpDbKuWNPOic6d8bCClQeju4KZHwcBzZNaD7o64/S1tXb4/1q541VZ+bb?=
 =?us-ascii?Q?EGpXggNCIdr+wus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZReYtMhjspJ4Ds9GhOcypMNEN4dBrmZ9tvrH/PdHkFTNNz9kVpvxbiJyQwc?=
 =?us-ascii?Q?wKKf8uPRdkGY8jnCxFTekFaq0somhnHlU83vDkokrp6lgV0X9Qa1DHyAg8Iv?=
 =?us-ascii?Q?miKmpmlAHBz7xRw1ClbuaK4K+cPyCX+CUOGcKRww4ZymenevQH53AGLitqf8?=
 =?us-ascii?Q?lMOoAIfM3VfSbG3Snnw/AcSA1wITfY9YynJ1jWjGIbJ4tptb0Z1SvMSCB6PH?=
 =?us-ascii?Q?NE5QSV0o3juBG3Ngyo6PFXwCCkjCNwpezbplLXXzaYq93NpDl8jRV36FdZ6l?=
 =?us-ascii?Q?og8L8yuenAT5lJPcDQkpHvcfGoob+Gws9G/A4FljdU54Ta/3VZFBfvIHFsAg?=
 =?us-ascii?Q?4zafsyIiGISIjs6atu61ht9g1oy12kuV7Gk+kzzeQesWSbROcdvU8Zwfz2Y/?=
 =?us-ascii?Q?l9gIESxbJD/RvKyusYBKYn0LcBJksSc1qs80wuBfxBXpk9iXMJN0mfc6EhxZ?=
 =?us-ascii?Q?/OfrAsKn8QUi8h04B8DnPI4XJJpWsUAf8u0s03A+2LuTl002eRilxkhxssZI?=
 =?us-ascii?Q?JQJd+eb3VrXw94VP//HJ6uVeWr/UMM54qaPFdXmiQP5tHAUvl+ZbDhWNqtiw?=
 =?us-ascii?Q?5VVUShy0LZmjF1cJ9HcMSNGpTpnpMR1vTgPlb/oERcHJ2cI/+s1os+5TSl3B?=
 =?us-ascii?Q?2E+dsZPFFiEn+o2KiOO4PQrD4VWeSCZyg2VLxcLj6bpwroWXtk6DSFwrBwTO?=
 =?us-ascii?Q?dMkWM6akIFAh6bfVH4OwFhRzi6BdGyVPJOzAXGqTq+8Om0PL6arATIKGOkVW?=
 =?us-ascii?Q?deoMxNz2aZ0HY/2DjV1WqO6EJKsg9g4dPADZ3ZrwYjgzQCOlc4JZlmioR5ba?=
 =?us-ascii?Q?vxC7gTG/FN6j7sugXKISJh/MDZriDDe5WYAwZ8vkg/1o519OugP9rK9u8ORZ?=
 =?us-ascii?Q?mwtPReT4OeqA9QuvnwR7ENsDZQxokDMNpSNeQDDE2eLjQQHoubdz2xnHrsJF?=
 =?us-ascii?Q?CPzAITySblvrjiBHiIJqsMmb+aX8GjCXx4LYBCD7/ZPB6lVmGmtm35iVf/1H?=
 =?us-ascii?Q?7k1O/6MjJ1Yh++CkFfZuINXLgVZOsXheTmy5fuPCYQxRbQiJCQNbBXQjMbeH?=
 =?us-ascii?Q?Y2Xl8RArq8tKWSY44Y7IF8mM1kGNw4dXER9wZ+TZjSLqdsCbubv8zNNEmwtw?=
 =?us-ascii?Q?mw6CFTIQUwpJAP9oOWyTy4CThmP4T3ihfdcwUUatQfUHajopAzdVOF0eBYLO?=
 =?us-ascii?Q?t2292OLfdhX2fLMYb9ae+v9gfw7JD0NLLie8mLqNH+WHBT5rkedGNVBXQYmz?=
 =?us-ascii?Q?EnNrCQlQM+tX/jm5+cp12AiKnT/CDyfODNu4CTH4kYO2MFxReL++/7eXwCLy?=
 =?us-ascii?Q?MUcK6LKgWIRZphcGwSKefQeqF+ZHjtKJUDWCKWZ5gEywQ6eK6Alpl8cqngaW?=
 =?us-ascii?Q?Jrc8en5QP0z9fOj9Jm7XIUgbm+9UEj/pv023KyPP6bvp7VmW6d8lVHZGfIZX?=
 =?us-ascii?Q?E/wOkJbi7hUNfxdtU/OiSQuaeoA4uFI3OYnIfvbKkHeUyFdbj9cMe0rOi4U/?=
 =?us-ascii?Q?V3IS476XnVQLChSnmX8eJCeTtdRdy4lR5kpSmDmHMNHHAJshaPQ25IRHm/f6?=
 =?us-ascii?Q?DX+6VQzDh7XLffNGfJbYi1dBoVgaikLNuL9fAmCjZoFW5KWTppDglqsDh8su?=
 =?us-ascii?Q?2lkggQCe39wdc0yi7FZTz/E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df13f759-c2ed-454f-22e2-08dd7dfb4d20
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:44.2860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I27XIyI3Cfj0fGuV3aaNYlnAsJTuObcAVEt3w1Sty7sZfI8ph74wVKm2d2ORKEjdEBv3/I4g4qdiC7k1vUXmAtZ+XzM6T+kQi5CCANHbtoIy/JMe0JPiFIWyG508oAdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7327

Add documentation for the updated ACPI specs for EINJv2[1][2]

Link: https://github.com/tianocore/edk2/issues/9449 [1]
Link: https://github.com/tianocore/edk2/issues/9017 [2]

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c52b9da08fa9..edf3a2165e75 100644
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
@@ -194,6 +206,26 @@ An error injection example::
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
+  # comp_arr="0x1 0x2				# Fill in the component array
+    >0x1 0x4
+    >0x2 0x4"
+  # echo "$comp_arr" > einjv2_component_array
+  # echo V2_0x2 > error_type			# Choose EINJv2 memory error
+  # echo 0xa > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject			# Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.43.0


