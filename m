Return-Path: <linux-acpi+bounces-5929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39AC8CB53A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EDF1C21A01
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FD14F124;
	Tue, 21 May 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MWhx7ZI8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CB14EC4F;
	Tue, 21 May 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325876; cv=fail; b=s6TzLFK0sx0gO1XVuehVtfkih8x85DmgMq+wwBlz2Eu5WJS2qulFDbK6EmosYxbsIltbmz+yBHTqU4Mz8GMsFeuE5MirI78S8soFK8k+uP53pC49R0P+D+e8FMvjlQLyZ2kf1btYz5AC8JI7wYd2lkTH1GjaGlGuYFob45ElD3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325876; c=relaxed/simple;
	bh=+Y0C+jXMR3zm/uBeSgrAXMu/Af8xuurmZK3k6rENf40=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZqy6QF/kqLjXKqUxtsOaL/w3cZazlA1jhtkbvjstQQGwPNO3Dk8NwppIewNIuBfzUnRaNIB/drY7BU2O/8uvA44GmEYvgUZ8xA6bjQLTOp0eqmNOv9HBKaIh1YUJKJPTgv2S0GdCUO96i5z0CydY9Veaa1PH7EI6v0SDcizqSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MWhx7ZI8; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS95xuh4+q27Zm3qEfRzfPRIeYZRNrEmFd1sZWPfB+Xj6U7JN+HVRQk1g7qwx7s+PWHUD+0t01sG7yazWdw9c7wfaxB933YhUWL4XUNgW5r9WL62og+JlkGqJNh8CD6HWPqBCNGtXUM6BXGFn3p72wfQA+0x8Z1WkZvguUkHOA1RhiGMsR1ukMrkH0f7oNbpS4PaU+3Eh+4lpEBDsPy27LvviQOd7XsgNDmVRxPt+ghcNpFfHvxlIy+zWckVIk5B7UTYSbGo5D3w6iFEasV+4XoLK4R8CPcKgIf/j48wmtcDjndrjLm9np1jmiJvtSocVP3kd4Vc74vxhMdSG+C/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba4/majp9gwCEXlY6qSxsX2dXjHxs+2H+BqN/OQDXgE=;
 b=b/gtwHUKaUI4Zak9eUMlxtJ06Az1rbJPM+GPEyl0o1Pm0cgtlt7aXyHWWiwCrAdPobFaVV2U54FBVg4oEqeUWIYknc3/wljUGMfJ0zS1k4FW99B7iK4xB5CZZHMsg9/xuSH1KDxZx0KeSzfBweYlADqIvI4HMYUbZql24TPrHjQWJXJFTBq0HXvCoDQAg5RdAZCNOSD+We1eWPWLADnchiJG1bcGSg2ZYjjlMm41IiADTgaVOu8oU4IU2YaURXd4vKhPIYPBBdSGjKMwa/HH35SPcMrng8163BMJqK6VqqClBqFk3sXKAcySFulHMwBuagajDi2Tn/7IwQCNu4m9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba4/majp9gwCEXlY6qSxsX2dXjHxs+2H+BqN/OQDXgE=;
 b=MWhx7ZI8k1gevJyV0LBr8jQBlWvTjlaeucS03Ywrpjh4Fr2/DwDt+F/kZU6s+fqRuZLwBFrfmhTLPtkXVUucOX4xRXUeCzmvV03y3ZNFLdpRLN+wdQB9qI4us4Zev2Cs87BbZx5JUWEJRAfaMJpDmFj738TbIx2xhnivPXfX2zM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:11:07 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:11:07 +0000
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
Subject: [RFC PATCH v2 8/8] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Tue, 21 May 2024 14:10:36 -0700
Message-Id: <20240521211036.227674-9-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f5d6aa9-0922-4d14-3e0f-08dc79da8771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Az1aAadhbHh7Om7+mzRQN3eDbu2rQq9tSwsCR8Rqd401TzRdIhr3re4yEqaf?=
 =?us-ascii?Q?vGcsUbfCCkBRDn3XbtCe0TaEeUxTnm4ew9Sej1SKKwLjL3BmvwKtQWNEJBZt?=
 =?us-ascii?Q?kk+0ikP8TG6t47xQ5VYZDcdQp1eBDzz37P3CCYciQgMo18F9rYcFGAmcRYp+?=
 =?us-ascii?Q?Cwt70Azd9pEyCUQBxcveiySzcgvED872x0FFj3SoDfRDUwcZVpq7A6STyF18?=
 =?us-ascii?Q?+YgyVfrRS8vcbszWm3eo1NSaJ0693QfhdS6+S4UwNjNmcVpMbNORufD7Ex0J?=
 =?us-ascii?Q?gjYICVnfkt6YNO7sab0h+XHWqLiI4+IHSb6HD6swpw/MlaJzi6ARi2qM6uMu?=
 =?us-ascii?Q?kV9ZVxcVQsenxoRvDUmmRFFQQYOLX6uzz9TvpTjsoJs1CAcpUnqkP/gOZflx?=
 =?us-ascii?Q?VSRERJdUlmDSj2GZy8fZafXvu7fX8UTspyx29BbcHfS1CPUKbEcW/9OCmjBN?=
 =?us-ascii?Q?pMwy5m4Je4Rw71fFXLZYArG1OMliPEDkWIj/4QI8O3i/4b1jaHJfPX+06jlC?=
 =?us-ascii?Q?NEsacbcceEBIrwZbkU7zhfofzTW97uCxhOhFi3viCczVU8HxNbYBW3LhfZZ8?=
 =?us-ascii?Q?rDiMjPXczWKWs1Sg+QnO+i7fjemHkHaHEoQ00ztW6QmRFH4DUInrYHFrZeiW?=
 =?us-ascii?Q?2omzRPTWKgWRCCkEPAuhC0U8t3e4nzqi7NDtr3hMUHC2/8fskrVrbx47nKtJ?=
 =?us-ascii?Q?KmXM6rIsKRVGeLMY20lFE7tosfl9Z4TgzArN7QQnlINGKN1TIoewJIsh2joB?=
 =?us-ascii?Q?XFx2hBQbD1qs3LhFAidpHnsXaiffh7RcgKA/oFXXjoPpK44whDFTfYfmQbT9?=
 =?us-ascii?Q?MlOZybaCstRAmisd5rJyPDd5mBkMWsOFcrwxBfPRFQCZ6ODgaj/fAd/P3sjF?=
 =?us-ascii?Q?pg5XewWdHaCS42q7Qyl14YKe6n9e23sdDEDNtR+flIl4V+ixe8VqJtpTtLYu?=
 =?us-ascii?Q?15zGaX9hTyNHrrKw8uU+45YSYyGwwilnlSQtRAfpHEFjs/1Rz+nlErLLqMg0?=
 =?us-ascii?Q?8O+sN5wc2JUfCw3zrviNv94UAmKN4UG+pDa8nYdUmVI5ODk5xsjnwHdbNqQT?=
 =?us-ascii?Q?tJ3D770RuB+c9BeWcQjYxrA1JdylcFImm6QSehp+RzV+BLlJ5rwflcj+PHTs?=
 =?us-ascii?Q?8WMFI5CF6S3Ab2LkQUXPv1MCAZgyYAyJYvjKvyMDd+MzRBzrBlOCCiDY47pd?=
 =?us-ascii?Q?PbnjBZwo2ShPOv6U5h1efACjLnxZ7qKZllgZ9zlfAdzYtxl/xfMvb0wuVgq2?=
 =?us-ascii?Q?C/2klddUnTlWBqWTIm915c/0uFd+3mGdRyiIrekNZKx4C3HWSIIfvpqLmqgE?=
 =?us-ascii?Q?TrYyUuikXKLCAtME0FSdIUCZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?huFoXxV++igu/XjaV6Svd9B4c43+gu9t/fWZdPgCCMt95RivO52G367iVMAQ?=
 =?us-ascii?Q?2/1O/IYWHxoPXaj5Mj56xn0gPT8d0ClXWcaFCFUImro+pO9ewv8HG5i6h9FZ?=
 =?us-ascii?Q?5sctE5HTTarDWCdHW1WjvVon8bNHQcFqImha7egKPTVRcYLPHZuxoMpyuG1Q?=
 =?us-ascii?Q?XYOWw19K71yFMTdG7K0+bEdwq1MoK9qODKh/hncxOoPpyXsrij3GPKNket+N?=
 =?us-ascii?Q?9L09QAlj35knt+m0h85gfji2JXV8yz91ZH24njcM8DuhZJ25IuaIouhPv5kv?=
 =?us-ascii?Q?RoW3nbBQkc7t+zT+hS71xtudZZy3wR0ZNbJREsL8fGhJpjiWGNpmt9xJn9gS?=
 =?us-ascii?Q?JIQXUdoYgDGPqDROHcfFnfmFbiC7hisUjFPXT5MCvFxzVatvWcniVFQwABn+?=
 =?us-ascii?Q?WXuyDOJmPpq7eMw/gcHXcSRl8fcAoUMAJIsf0lTXU4X/y2ZpsfG8rZUoJBrK?=
 =?us-ascii?Q?pvE9Zty0Pw3RKjfG0Frxh1Mrw+wzXd9J0GkgZy4v4B+hAclKGXNACPJH+mif?=
 =?us-ascii?Q?h0NLv2d1Ljtx9Pp4gSpfKY1TdE4vE5+1wMdSk5B2u9sa9JQ0+t9j/tD8HfDs?=
 =?us-ascii?Q?mPL+iqcaUWR+8G/0fsiW8lGeYE47T76BMDQQt7/Z4TSB9KordJpmAkSG1TQW?=
 =?us-ascii?Q?wrqq6falwmPwjmk/WGee0LW3xk6au1gXtS1+v1MbZBtl1YpHUmy4EbgtOavV?=
 =?us-ascii?Q?YEcyb5savw2xnJ5+VH+O6DCNYZ/e1zSA/I5QJKlzt/+juahsb9LB5d05ScnA?=
 =?us-ascii?Q?458o94XiR9AiUxc999lTmOkqJK49k6XKVQkUhtIdQklANoEemGWvjPanhhIp?=
 =?us-ascii?Q?yTM0O7+kUMNgySvbZW70UPqPzE5KU6LcMvVIDj0TFEcfITzTNETM4Ur/UzN+?=
 =?us-ascii?Q?zzo105AVJy4a6+dq1PXnCcncU4Oeo6JrwyVQ+ttW4Foly2v/992ZovqEsbkg?=
 =?us-ascii?Q?o8UInqy28QT+UXP50i7OrAUVCp2LgMaK3hASWF4b2tkVRWRyWqjKPyGLxHG7?=
 =?us-ascii?Q?2yVTaSgkGk5ItIwmwUx1jGk90fVszekR0bw8Xl27jDSdCLLxLSaVAgKMwrzj?=
 =?us-ascii?Q?uxP/0doeI7DlIiKhlqB66bK5DhHbYvMkYaAS1VeFMZPy3MmmY7kDMiYeXbyS?=
 =?us-ascii?Q?BSSaF6w83vBP4eOCse0/qBiCEvIWlkqt2nGXAOpeuA83BZwEq9QrHTux273W?=
 =?us-ascii?Q?BrkGDYPWxkgkceKjK5hxI8HLaWKMab2YA+zWqb/g1Jbh+tTvciTxpBsyGltX?=
 =?us-ascii?Q?i6ukvA8Tc8pzdQoEokX4nUBOu+aQLPJ7FrYtQZuYBCFzyoV9Mhenx86hmLwR?=
 =?us-ascii?Q?uOvAnRZyHIScFf7qTZTSIzG/DOEEbLyeBR6gJVZpJeXo7m4YE5C1IU7QEqYm?=
 =?us-ascii?Q?U45fwCrCPNUDyemsi0WkMJOee8OxhC8J8Brzj4j5eb6U4BrmeHB1NazhtuoH?=
 =?us-ascii?Q?PG/KYZR1bh5qJ+qDyIJhrdUhFqR7Cbvo/QMiPj3W0P8EaPgXjKYmIAgU7d2z?=
 =?us-ascii?Q?UTMX/eWViuw9CL/kWvQ+zjzxVW/aUoFCd0jOoI2BRWzkQPpJJlnPZuhTAuAC?=
 =?us-ascii?Q?+d0ln+ab0dmTPaYeF1glAQBy7AMO02y6BtnicJfIqnTzU7SaZmgb6tCgdDv0?=
 =?us-ascii?Q?blNxcyWEBjCKUJbS8S2bwzA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5d6aa9-0922-4d14-3e0f-08dc79da8771
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:11:06.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMVQxIDGqO+/45Q50cQcGgreP93HY8Eo3fKSYQ2meTW/wAMWcGdq23wDRoFz4RB4uDw+57/wprl5f+l5HVS3hZTrEQ9Ya6Pzbz819vrbiGYsC3ioc6T/C8fb+JcO2Ay2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

Add documentation for the updated ACPI specs for EINJv2(1)(2)

(1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2)https://bugzilla.tianocore.org/attachment.cgi?id=1446

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 51 +++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c52b9da08fa9..f2751cee9698 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -61,8 +61,18 @@ The following files belong to it:
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
-  the available error types.
+  the available error types. The available Error types are discovered by
+  calling GET_ERROR_TYPE command, and if bit 30 is set in the returned
+  value, then EINJv2 is supported by the system.
 
 - error_type
 
@@ -85,9 +95,11 @@ The following files belong to it:
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
@@ -110,6 +122,7 @@ The following files belong to it:
   Used when the 0x1 bit is set in "flags" to specify the APIC id
 
 - param4
+
   Used when the 0x4 bit is set in "flags" to specify target PCIe device
 
 - notrigger
@@ -122,6 +135,18 @@ The following files belong to it:
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
@@ -139,7 +164,6 @@ is present). The EINJ user interface for CXL error types is at
   under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
   must use this file.
 
-
 BIOS versions based on the ACPI 4.0 specification have limited options
 in controlling where the errors are injected. Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or boot
@@ -194,6 +218,27 @@ An error injection example::
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
+An EINJv2 error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type            # See which errors can be injected
+  0x00000002    Processor Uncorrectable non-fatal
+  0x00000008    Memory Correctable
+  0x00000010    Memory Uncorrectable non-fatal
+  ==================
+  0x00000001        EINJV2 Processor Error
+  0x00000002        EINJV2 Memory Error
+
+  # echo 0x12345000 > param1            	# Set memory address for injection
+  # echo 0xfffffffffffff000 > param2            # Range - anywhere in this page
+  # comp_arr="0x1 0x2				# Fill in the component array
+    >0x1 0x4
+    >0x2 0x4"
+  # echo "$comp_arr" > einjv2_component_array
+  # echo 0x2 > error_type                       # Choose EINJv2 memory error
+  # echo 0xa > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject                       # Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.34.1


