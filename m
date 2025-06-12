Return-Path: <linux-acpi+bounces-14317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFEAD7ED0
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84623A1588
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C792E3393;
	Thu, 12 Jun 2025 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="d8swLLh7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F632E3385;
	Thu, 12 Jun 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770042; cv=fail; b=XBZrch46bI6xmYF9/juoNrqQ6i5dkYxSKsVFPbh8A7XIF3mh63S3iJ8kJOufxtZp1JuXYTgaZsrqJJLQqm372k64UU0zM4FfWCfKp5ub60c9vyhVVcSjQpiwq9oOxZL0tS0cg6ycPJEaJkbUXLkooVxnddbfLAFxkRptQ8vhuP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770042; c=relaxed/simple;
	bh=oLJQbI1EF4mkNGO3lt/Qbq+9IYNag87qeJ9lC7J0GOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+I0zH5tOP42aYt2GedUoaigMTkZx52J9ZlE3UZ95gk62yyUJBxbb48yjVneb2Rh6876iWmvvg7ABDB6N1/dtVRF57FK1g+Uc6dXHK5FPInqolZuuPvH+GUByEgIpDLi7YPcmIOhbD3DhNPmZ0T0zrsW8uHZ8nrd/WZLIfOyJOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=d8swLLh7; arc=fail smtp.client-ip=40.107.94.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Axfv6Ei0SKBKFnVSAtRqrhFymwo0yRQryrxLUAtb+6F0gL5SSU4jdt7XXF+7SbrF7QLjoEc+nXmOWs2AHPzp6GQw8BoGAq9yBh9fDYKdHo3JzrD7kkqVtCQbq14Gr02r26Nrkj1A6oYx6TcoW9SHCWps+Haf1ONvfkKSGXK/POKeY+Ia6l7HT782vwz8O0K7xuAnaEnGclUH03a5QN/vfw+i95epgpOkhNkWXynf+s5u+aZVzSf0KtxbQl6ICaWW+KDbxXYNOHvoRFlo+Pj4jZc9yL8dz+ylCpmIlZE8xG2JmPavxntG9BWFgSqtRJNRMLjcGXCfoyXj63/lRpMSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSPKTTiBIc8YfRhqV87VCulc/UzyuXW8QrhaqF3yRAs=;
 b=DPa4Su07uFIXnF59huDOic4v876PlYR+05wV4Sret/7uMK+9+V1IPu49wh0lxG16FjQFPJG2UaIYJG01plIn73CaSan1DQzRMD4Cra1u3TfDs+XgGkRcN63Djnai/IvZahJIFgZdjzKjNwhKUt+mCkIYxwZh3KEwaM+iHAxfkkwsNiclsS+frscKbfWprj0eMCVDvTWOE+VEjr4LcAUdRZMDXaP2Su9Xxc2duqvtVlnmUJ64FFTsz5eCrM4Z1gaJYEKJIRr16YYGcPZ3uH+AJf363DtCyiTZjUhYvDIasze9nZ288rEl6y1ZtMI1tKkjIEMRZ7YoLwfFD+hUoY+D5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSPKTTiBIc8YfRhqV87VCulc/UzyuXW8QrhaqF3yRAs=;
 b=d8swLLh7YYqkx+jzzwT02uAtIjta275pOo0tZ6mYihfdbvHEDgkCTpmleHGevGS/zniImdfO0pa9quPodgTRi+xpPqFR+AJmeWA0Y2AjHVS8JunrlNcODWlE/LmZwVb7MeivZZpyNuQ+W5rWnguc3jTkmTnVhX0IkkVu2AbwWjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ0PR01MB6382.prod.exchangelabs.com (2603:10b6:a03:2a0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.18; Thu, 12 Jun 2025 23:13:55 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:55 +0000
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
	jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com,
	dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v9 7/7] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Thu, 12 Jun 2025 16:13:27 -0700
Message-ID: <20250612231327.84360-8-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ0PR01MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e46b068-b58c-4217-5110-08ddaa06cddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Oe5GaYeFqOsd9vdsyERNhTdGpqN95l5qVTkphTyKgoTyV89ZjUzDqFSSpEt?=
 =?us-ascii?Q?dRQNRT1l5oKFCHGsp+hp0j5DwvPd0hTkTslXa7fRYVeFyfRyLssmlmh6ElzR?=
 =?us-ascii?Q?mNo8uGHbFCKvzE8hVnUZMdbmZCH+IiFod5w2O4qbd9BgF9Xnur+6X73WVqcc?=
 =?us-ascii?Q?d9HVcwZWWiJvXaEwzko9ET3cmtO8sjew6SYFzPO4V1WCktM+zXNdCqQMuWni?=
 =?us-ascii?Q?5fJfU3OnkVaJS/lNF9v1Aj3nJMdnVblJKcj79xnYgZ9YTlqeIK0dpsM+ko0K?=
 =?us-ascii?Q?dOlnFe4+DNJ3KPh5DRoZMcvdMXCUuOrOQhWgGzGdgP23L/LAumX0pSVxMFkC?=
 =?us-ascii?Q?+UWyXI8015GLW66q7PSsujNHqU/0Q0+akcDvTnjcDemY1RqDnWikpNbS9/d4?=
 =?us-ascii?Q?y2s0wtnZkqvBYX2iuK1xwgnIC0e3fjvlplvxGe29j8NvfnmDv0x3QyBvTpqO?=
 =?us-ascii?Q?X5TKar4hi8CV6sA+ZZhnR6GQaONB9eVlrZxGk2ixc/GqhaYJddMcSOnXQi8t?=
 =?us-ascii?Q?PGGR8bckKRRsVURB3F3Ei6uiS6cgv0nYSC4STwdKhN7z/tYTjb4OKpT0mKEC?=
 =?us-ascii?Q?xCJV5Czu6wk4ZcNxk5R+rVyJPygiKuxbkWlCFL3eHFATJSq6Xw8Or0E+t/rI?=
 =?us-ascii?Q?b0CErHrTLCuZQvf/w36faKjY6E7Un/aiCnuvZMA1XF4EcoXlO0spxRh6nOf3?=
 =?us-ascii?Q?sE3LqFWx/+Rilj/CToSOg+DDI62lRH15bmDYvMJUtbIe7/40z1Hoq21SqG/G?=
 =?us-ascii?Q?lv6NRNyKAuM3JbDHc5FXY23Np8ArPNr2+0nKId8s0nh4wCMV5Xqjaj2O2hR+?=
 =?us-ascii?Q?96cTHm68xqNvLSEmjLDIq5X0xNgE++l4XHgpc9l6wSH3m8PzivaAo8EpAQ+t?=
 =?us-ascii?Q?a2Xd+i7LnfcQyg6VkhC3S5WGH47XtAEA7ec3UIgh9hOG8cibd9hwwSJxO/60?=
 =?us-ascii?Q?TTGHFDlUq++9TCDULg9O3FINRLFxLVaYy9+7BHOdASI1sBxIWXbQ1AaAa8OO?=
 =?us-ascii?Q?0BHIx28+MKnjloFNmBKe9J/EzTNIm5KsE6Drt7CKtzMurERS8OduR+ynbz05?=
 =?us-ascii?Q?45LLcY1Uxh7gQAjVBCUGDw0NYuJquexdNpW+0bfTrvuJ+Z+QAmqYVwXq48v6?=
 =?us-ascii?Q?FTXa9cIKFprSsyxNoRQR40DVR9biddmBqZZ01z29FNaNG4a5YhejL3HvXF8h?=
 =?us-ascii?Q?49IQTFjsiIHYUOCjIHcUnJE9OuAwFraVg711YS55BIR1In6YPcA+cW+GZrEM?=
 =?us-ascii?Q?F5uKZhYFPwLMwjkDi5ZyN89b38bnTpve3oddIutQ0JpnnZ87Ww/rXieZduwQ?=
 =?us-ascii?Q?lO3CI4W7tW3jOFfc/8V7RJbOLLEJGzhPFS48iffHmbormJt/qRWg6lq9fxDN?=
 =?us-ascii?Q?x/dU64v5GGbUDBRfr6LvpLA9rtPh1tW2f0u2WT5wEVk8D1r9zdG0i/asbheX?=
 =?us-ascii?Q?4HO7cMteYwONWP/bBp5pOPNdHhfGU/LL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bz8K52AZcd3xdbSxDRN0JBZDEhYrNwe/SW8OP+7f0Ss6wFPj4gOFh/GlTURE?=
 =?us-ascii?Q?XcyIiolc8OXgpE8/uz62JzUzm0TgFWY3lfgYUTK3wrInVFUOoEe/SQPtHxw4?=
 =?us-ascii?Q?+wBdJZ/a5+sNvuQ4jPW7XZgPFG01fj9KN8W75qIhH5WTUi722sS1PgZiHN5V?=
 =?us-ascii?Q?A0x2S1OTePq9PHtVPYqCHc2YY1Kbl0KWKdMfhfR1SilV0Ys5utLP3Xir3MV5?=
 =?us-ascii?Q?7VNdRRsLSW8ijL0/0GAGLOmXWAgH8C9mcoed+SRzzJVEWr3sXQW+OI6SDQ4c?=
 =?us-ascii?Q?CCuWn7qGWpYDT72v/RRfyLb2CBFJTsQGgupbpe/1b6OgUvAstwfxps5ol3IF?=
 =?us-ascii?Q?FsnnjP8Q5VLSa5kgorzGzku0KRTFez7Z2VX+j/ekOaZ7r4skD/CW3YitIVwX?=
 =?us-ascii?Q?9mKqpa1jiALH5hs+wjbIw8huGshL0iM+ye8QGXExkhJo3bmkJMevytNTQ3RO?=
 =?us-ascii?Q?Vy/SIYDI/cYCx0gMAJHeMh/Swa84mtRtaEAg3wPFr/5lmVLwcE/G2ZxySTMc?=
 =?us-ascii?Q?QcNXlneTSzOrjBzAaDvdCmx68DgAR9yhScaDNYSo/jLkd8r2R6N6Kd9XjO36?=
 =?us-ascii?Q?sjNAlFWmv8PRKFmmXCDUiJbF1j6lYcVwl4E8fDP+T5SisJpjIPIBqhWR1UDv?=
 =?us-ascii?Q?GJneBF/4QKZSorW/JD82CMtS1OVbxeyRpph48Ah1XQAC/fB9w/9KhEmEtfLK?=
 =?us-ascii?Q?4PSs8osyrNBoohoBC5pLh/1hqvgvKuwZH6UxS6QXe6Yr3Wu64XVBDh78V0ms?=
 =?us-ascii?Q?4FGMwAimCxY4QLC3ZytGHHdfg0brkpSyMCkTHbPe1j02H019AASpxdlkj+7/?=
 =?us-ascii?Q?KSGudXhfsvizKHaa0tWcWkt+bjinWcIm/x1W37Ya6Py5AJs3lcAbVfoG1+aK?=
 =?us-ascii?Q?vY2VndqIwst8Z3R9ar012Ra3czpsfihVKbeSDfflWD1nAZzcH/XzePLgoGQP?=
 =?us-ascii?Q?t5fmV0xQEdvVQneVayRm7poyIxqiUPEIM9N1K3txBGeUD4MHBS+7FgluOxy7?=
 =?us-ascii?Q?DiYSHO+mxgXCyFEJTTOUcrR+IOpG38C+WZdTWhhez3VBrL3fR+wH+fjlSPnQ?=
 =?us-ascii?Q?1XZG5OcnCc7Ml2ODLWjxvlpNAYNL8fwRfNzUrXxDV+VoK4qnnYOg6kI9XiVH?=
 =?us-ascii?Q?j9tR/K+m2rC+tU9o+0B6n1Qa/+9hDjj99c9UNfAwATo1ySKiEBBURI6HYN5q?=
 =?us-ascii?Q?/XrRyRyT6Q+EIEEIadxP1rXF94w+1EVhfWVoMrSuWBYpv4CiIs6fcNjh33xz?=
 =?us-ascii?Q?wReRjRHb0ugNvayOQd5EPJV/aMkwjBEeEbMYVYLcwvgMWLSxsISz3/5HcQ1Z?=
 =?us-ascii?Q?hBO9D+BTX2d1atq83zokgAWM8ybJaeA0WNVIZRAhi9JnPIX25zOYcMhnBVHI?=
 =?us-ascii?Q?7+RSEpNyFNndt2msp6F3g11Ygp5CX0O5xF4RY+Jxn7Sjd8AqT1/JQ57NusbM?=
 =?us-ascii?Q?+KFpXAjaI4J+oePJcgPyCx5v+nBDDRmaGhUWaJ7tKLjSVsx4vpU9f3Xwy3bU?=
 =?us-ascii?Q?FgKNrVMtvuqM8RFUrv0wjhSmwHEOjceyd+JzfUSn13Cb3L7R2/vLm6btTAL+?=
 =?us-ascii?Q?KCl8HmYHpUOJNI1ChwSYNqK31C1wVeV7L7tKcOx0cWsVrtmILK9wpuI4sIwR?=
 =?us-ascii?Q?LrMcCbQDV2K+I/WEqSibuoM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e46b068-b58c-4217-5110-08ddaa06cddb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:55.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oGhP7uwEzG3Th9QXQRDiqOuk7IaJEkFtPHjn2edLBemaqv3iqtQRfVKVrD7yGMsIok+ckwYtSMo6kl4kjU8QAVpSBEri0HNEKJ8kje5h58JuHOZFCHs/iLK646NgLGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6382

Add documentation based on implemenation of EINJv2 as described in ACPI
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


