Return-Path: <linux-acpi+bounces-10972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7FA2F758
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44763162116
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4AC25A33E;
	Mon, 10 Feb 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QvEDKpFO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020075.outbound.protection.outlook.com [52.101.51.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6425A32E;
	Mon, 10 Feb 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212662; cv=fail; b=drznXZR1/wRehqXmjXyoC4Qe9s5DeR5dzlEcL0HmdXOgCq8J31F+GNzKqZ8iHDng9xlmrxCB0e2824itxuzttTk2KbrkO97fIVOhuHDRZOJ7MxPw4DEI1Bi9NRxfQPn9VxYmSUPz/HfoEhf6vZZI0ImiAM7xOiyPc49AqD6vX3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212662; c=relaxed/simple;
	bh=HFGpSnVqdwh27kg14ZYtLnXiSSUZprUdYWdrklY/46w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRAcTkmALU1xPdVQ3GJ11Yv2Kax+/8kqi9mRHnl1gvjf+PdtR+5LchnQLwQo/2rltIZo/KqLq4S5zBEmgkeRIRNw41w6p1B8UuArVXnrTxJGM5ud2oBtm2tVRweXcSeFDIPsm8xLWdKOkpPulojOJyjNpFCbm5UIQxlFkqCcYH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QvEDKpFO; arc=fail smtp.client-ip=52.101.51.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THdxd2fc1u1xw9wmKgYUVw86hEqFZ5VSrAZnGyoV8JOtNacOLD9+kcDBp8ZKXWmzNJB6ACD7DKP6Yr3hWlGktuLPUXcJ2SovH2tEhXziXwtjVteisZ3o2eiJg9B/ctEBn26sK8uRlIAnGp65Y8LeiKZ0RFcJdiOK/l7G9uTmRuv9kkA/VOcP6WyaOf6BYrjbxXYAz19d8iSJ+xbnbxkpwr2dMLRLzK9vcuMhI5gsUCH9geZkGpxseHKBo6920cXsFgZ8NGALfzxc7cBGUvk23XYXmt/lxJ7frrtfRPFRbCyxSrU6pWflfFKtglt1Cs+glyLKX1R0KdJD3IwgbvaHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbV7nw1lh+s5v8RWnN6nf+GCGenZXbF2orvHXj+eoMk=;
 b=vFhTpo6vHYD/TMnnnXmyJuA6G+9rq1U0aueuAwmn1wQADStU4nb7T4ayHSbIsMUbHZcRBBVi/eiUmVF1NVoQWJegNEg55iLyB0AW21ZWTrhh7sGQQIpJnJUg4/luNUZnKBCz5GWJW1EH0Bw8GThxY1dQZCNpSzSbOM8XqMLqd6GqAdBohhPwG0GEFuVE76cWMviz8zE0JshBCzmK6U/Met84ramBjg4A747qA+1/x9gYXiXVG9fMZ4Tqbr2K8hxVRmosKsJ1O1earRYjCU6O2F7I32Sqpfh7hJuEM/OaIhhNDLOZEnAZPm01IziTeEsB4P6RumWK195aAYGP3P05zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbV7nw1lh+s5v8RWnN6nf+GCGenZXbF2orvHXj+eoMk=;
 b=QvEDKpFOQkkBnJMFyxsKiGnFop7K8UZC2PpUzcKHi1yeZKWyDIHgfnPlDBUIhw3rNnTQNn34UoRCuTJpaWWtRVpz/KDRyK17BsNuIYOLZuC+e/h1ntMmxiPoBwFhapliTe6JNj1tQ7ny4wSgrT+yvgpqp+2v4Nl/kyg8GRWYYFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8345.prod.exchangelabs.com (2603:10b6:a03:537::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10; Mon, 10 Feb 2025 18:37:34 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:34 +0000
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
Subject: [PATCH v3 9/9] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Mon, 10 Feb 2025 10:37:05 -0800
Message-Id: <20250210183705.1114624-10-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ2PR01MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8988fe-0244-4094-2119-08dd4a01fc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omejYKyUgaNQFjr+My0w5RQB1KujV+n6trQMsym46rPa28ZppWN7gGY+TWJw?=
 =?us-ascii?Q?LJqfgxo8QrHfZHZAlepWniKZJx34sGKUN58DLldsoP2BHpu+FGBoxhmnooyk?=
 =?us-ascii?Q?GQr4AC722xgWWBTkIAj3DLwiKmEQqiiiWDqpnxm4CIn5QYhJI75KHXooDKBk?=
 =?us-ascii?Q?xlXRTKq8cSNSX/rWt22Z4nfXuEPXb4dzMHdcm/qVqcGHndZXD5pNXrFXVMd5?=
 =?us-ascii?Q?8/M5Fa4Mpkdvaccp6c8YfVB85slR9/nw7dlrZBhQ9S868p96tv3pcc6Ayukj?=
 =?us-ascii?Q?8Wqsj3R2vTdpf+Xm8QVN00BbmB97emUmJmZQwerxN7vXbgYbto/jik/+V3qe?=
 =?us-ascii?Q?dR92OCjV09U5yLPUuUaHOGMhUOmE6C3UBJJdUSsK+6sA+Xg/wBPzyFiIbQMY?=
 =?us-ascii?Q?XmBkWeIVt0p49TSH8RMSsJWhhUkZZw0B0238pIXfg8r1r3hUA0rlN7SOAVgh?=
 =?us-ascii?Q?LHm/UVcjDSqY43WkR+ZDDj/G+3Fe31FjmejLCgnPDqlfPUg1JOWvsdI+2Mtx?=
 =?us-ascii?Q?6b4tE+4PTy38xeyoU0134qQN4YFxLxRFAo6u+R7SKFS3HWu7zV2IEeB93gJ1?=
 =?us-ascii?Q?3Z7CJ2Y4lLnw8CgF/gdpf9sGMR6wRCnolsZsEVO5OYmF1KfYZfVyRE2hSylV?=
 =?us-ascii?Q?zY7HRB4Fgel4I8wFLzEJ2TXd4U1LMnOK63HBbEBG9QRtXPbq/BhZYClY0k25?=
 =?us-ascii?Q?KH1O43+twvd50C/gz/TRkKREFMuT6vn3dtD/0kL7G0LhRT9kGIvbW7H5g3SP?=
 =?us-ascii?Q?3pjlT01x1/P287avJm41j/yJ52E2SbRWfgWhlWOYf8InQEVR7zmiCY2t0IME?=
 =?us-ascii?Q?TLnyWTpZYwdrpjY6UpmNLpd7+gyUaMWOJkGMJOzb4FZLJttE53XPwsiY9Nvw?=
 =?us-ascii?Q?aQg1c7TjmFpfnZKj0K0Yhyx/8H7Vo6SwsDjMKehT77xHP3IIAmpSkLEXCezs?=
 =?us-ascii?Q?nTv6AMi9vFkf+ZmLwK4jlgHVhJlb4TaxQPWrJcAHIgjcq3RL/emlmz7dLiB0?=
 =?us-ascii?Q?Ks42uMCyTw8+NtDJWyhyNDFnSz6idkAoLWd1dahCljH0zt8T4A6nKiF6+3oH?=
 =?us-ascii?Q?yq8WN/7joqclX7OgIqGZxypvYeiVJIkM2jrCorX8xW2V72IY68pROLL4IHSh?=
 =?us-ascii?Q?hfYXYtxYHCxgW3bxkUd6cWRans6l44VYCcKA2Osbqsp4ihwP6xzJSF3kX1Ye?=
 =?us-ascii?Q?gkM87sfNvt11IT69AdmsvckYN6NFyCSHL8zU2gtv/ei7CCmoTvVvlbINfCMO?=
 =?us-ascii?Q?rfcdSvHOuoq2XlDAgh0TOUtsZ7qsesaCW3EX+pwu2xqtxg8YkOW7pDOMqJQB?=
 =?us-ascii?Q?yCzkxlrjJBhhpD8k+Z5CjLZ4SDxnHu8fwspzXwxCmD3PtHVpb8lwA34iHLs8?=
 =?us-ascii?Q?kXNoVvKfZ0BbWFJ7k88IEGcpLB4yeFMdpThQ8S3A5PPlKXOeBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5BKKtTaXQfh4yZ7LteJtXzUEdvblwk/dvCJQ8Nq7WLsMqbmJzKT7kvupneB?=
 =?us-ascii?Q?L8j/CD2WhI8vvaHmQtT0OtlgspPaYuHWGxPO5hEgi7oH3zN2YuzPvZ9ZuXBp?=
 =?us-ascii?Q?r7/gby1jDm+0uYP4Mi6DEf2CLfY+bi0ojk4Chvet2OUPr7CRMLnwAssWhXSn?=
 =?us-ascii?Q?6CpraZlaOjRQvNPBby+iFMoTTWKrLsS+dOpBgu1spPYf2WZK8n4s8UM0Sc34?=
 =?us-ascii?Q?sQahMtYna1kCbWCcN26baxIh0Eh8A1W2ri0Osk6nDb8JwY0ihoOmM67OzW4s?=
 =?us-ascii?Q?ChAiP9MpJHKKibkOhsxJZdD+BIN3Fv4beG6u+ULBJ51OwGPB+nXxYcmUwrWS?=
 =?us-ascii?Q?wRqKmwQ2xvuN6/9XpV27X20oqmZus8iomPEto+MDZiotOkMx0lglzzDPuiXs?=
 =?us-ascii?Q?apvqHjKSWOmAUTP1bp1nKZYxtbc8p4PtZy4uAORMPH7HOBtr/ZPcTFzuaTDo?=
 =?us-ascii?Q?knJHt4LOpt4vapvAMDyoG45Mo5XvJ2J1G6nJ9RYRZJPHxJh60kLXuX5F3/pd?=
 =?us-ascii?Q?LOEOQsrlDaZlTq/7bE6Yzk2jTmR0Y14f25n2RLZBsgEYAhyL0b3kA/Gfs1q9?=
 =?us-ascii?Q?h5BXuGJn0GcGHtznO2w9SFxNKxz7KfmKAW6+z3GRBfIYs2+GNTiyUELXS/lp?=
 =?us-ascii?Q?mZSGHO5xRaYg6JI+EXq6AWUKict/L3Frot00FBt99+u+EV76tb4tfly6dsm+?=
 =?us-ascii?Q?95rCOB93WzkYnSoAcvWWdwPRqRvYgMnexfdgamj+oSBGGb85Uq+lFhkgpQKU?=
 =?us-ascii?Q?S2nJD4hWCBKy7rcoT5+AzG1WRvSHfJfzh5ZwCBGc5ZJZDiVQgSW3cUpa1GTy?=
 =?us-ascii?Q?cwySbT7wbaiNUAbrOIUbjOZiq+ANsOhPkPiuFfL1XonPNcAkP7R/lVBue4X3?=
 =?us-ascii?Q?Q6UZaV+jKf3cf7YDFl0Lw3QI2bt63qajaOE41O1YF3zS0tIo+u3UTdvOflfp?=
 =?us-ascii?Q?EhU/vQ1T71Dp+rMGnWE42CD8SVUjAEZ6S5oinGgvhiI2tjaH2MBbelZVDhyN?=
 =?us-ascii?Q?mcaNlEe9fwl5jCMCMzvJahKxwMzrpM54dqD2ezXsGuwcCDpxIJgPLk0lroIL?=
 =?us-ascii?Q?Px815hdzBVHd7NPqVem3F4m9rUu2X/rtLTmxuKL5hXmjgHFqMNNylaCe8mah?=
 =?us-ascii?Q?g6J7oO77/g2RZ0rM+EUP1s3+PJmkTP1qvFa079MFMykLftIVCF/Jaar/GL0e?=
 =?us-ascii?Q?g+7pnc/JA61QPLkk84gWV29syd6MA3X+/CO3ZOQ9Gk+UxLbKkFV39/xCYNc5?=
 =?us-ascii?Q?jTbiNeXY0CDKwxUFdw1KGv9Bl+u0WHld8m+Wzzk+FQWhqssPI904cmRQ6OFC?=
 =?us-ascii?Q?iu/i05jdrZBVyrE1HkhG0alF0CMtvZvKo7QlkJuwa781UpLtFJmXcX0KVC05?=
 =?us-ascii?Q?CgCgfZcIP82VY32Avqa0XyTXfBe6pFNuoviaA7LxAEosHBJKT7ZVZGIaOrl4?=
 =?us-ascii?Q?WjsOmicOLPy8yF2j5ESjd099lUEKZO28NAwehsDnMipXwtboEUa4D+btTnDa?=
 =?us-ascii?Q?NKeJebNUK3Cs7bmwWB1CPAznG+Bau7wRG+KTchlKkkvqKbA1Vd6j35rIRb0L?=
 =?us-ascii?Q?KGRw0uc5LHqr3INsIwySmAA8FyKg3yQmLfOqJUCa6MueAxosu5IRFfcz4OVR?=
 =?us-ascii?Q?bqA4eYw/LvTOsT6djMaGSdc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8988fe-0244-4094-2119-08dd4a01fc2d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:34.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOU4b/hLuyKwEkedGnMblKCW07XepuPAfSmmMaPyG2sNZ4gkreXlV+Xv7ccP1OQOsEisOee3iFffZj+TK5AX+hh+ds0QN9ivaIyiRyBUWjImQm9E8l7NnLY1AAV5jKcn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8345

Add documentation for the updated ACPI specs for EINJv2(1)(2)

(1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2)https://bugzilla.tianocore.org/attachment.cgi?id=1446

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c52b9da08fa9..31c848183af0 100644
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
@@ -85,9 +88,11 @@ The following files belong to it:
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
@@ -110,6 +115,7 @@ The following files belong to it:
   Used when the 0x1 bit is set in "flags" to specify the APIC id
 
 - param4
+
   Used when the 0x4 bit is set in "flags" to specify target PCIe device
 
 - notrigger
@@ -122,6 +128,18 @@ The following files belong to it:
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
@@ -139,7 +157,6 @@ is present). The EINJ user interface for CXL error types is at
   under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
   must use this file.
 
-
 BIOS versions based on the ACPI 4.0 specification have limited options
 in controlling where the errors are injected. Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or boot
@@ -194,6 +211,26 @@ An error injection example::
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
+  # echo V2_0x2 > error_type			# Choose EINJv2 memory error
+  # echo 0xa > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject			# Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.34.1


