Return-Path: <linux-acpi+bounces-11918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2319A55B1D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513CE7A4CDD
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EA280CE6;
	Thu,  6 Mar 2025 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BacQ/N6y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EE280CC6;
	Thu,  6 Mar 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304939; cv=fail; b=G5HKUQVmRas5DB0ELhBae6kFv4ZUaVM1ZFxyt72dBYbDAWTpGtnfK+ilIndXd0vnAKy+XlQS3c69FRL1QsdObW64kPCOrfDcxKzF9e49EHfD38hQJ2bRH35FHkTvL43oRTetXvjRxcro8zl5GfncZSxYkmnPTkmM9+vCQHUsSY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304939; c=relaxed/simple;
	bh=y98HZz+zzcWdMhuHxdodZldEsHpYDN17tadSgqLMSqE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/CECyrPvDlSecZPfuyXj5SYWNLSpIwffFXApwsoCLcu4jCnZ3b86KBjB8xmJRtHm9PD+wK4kjrJRcoxaBiOQOSQwWF4BwGUJbT80CxiS8WQen+4Dw+EBJmVN103V3afYKQgLbIWSCGJZMlIjjWeTv4fjf0lyi1DxGLkcAN3jB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BacQ/N6y; arc=fail smtp.client-ip=40.107.223.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u17FjqrMvEUfqoLJSDzyGOnEpPBMufHUCgOuGjzunZz+IEYlcu40oREGMq6ng/TBBTr3pRi2BPOR8/MxbbZvVE+v4V7vTH0CXAJ9Mlj6sMi63+LNrz2GvaUrbaO4T4URtJfjSpq6G2rSyrs045qfidwWlC8NRb++Mglcsdi951qlf+QzFJVOarqerHfLB/PmmJFoWwSWDDuRWub5Na38oRf3BrGVa00Ro9PLJws6Q6B/7l7RzThgMDUUkhhWcjKX/15YpEI9eI3FXM8fpK6pZbFjfUu1eK1WPGM1tfU9pCn+o/SSTsIHPBClupQvGLygjQaX+zg6Ur941AZX3/zfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pJiYHlwfQRmcCIedmE7X1eOCQSmMb3DkoqEsIoUb18=;
 b=ifAsoePDbGv3S8VcBxlUGjquhblIxQrZdyshPINboNc8eyGGtdgzyU+dJPTDX2NRmgRPmQVusCq9wOXv+gp45LJXBDzXUq7YOHG2zqGwi0k5lnrjwpFITnE6GCPm1HMtb4PGat+ziUARrEg42oXsB4IlE7OqldHB02NbeQOvzoYF+yMfHqzzfyoUDED31wFagQQSI2f0jQ4qxZ0PyGzwKAMIMF5GGRqXplIuMvtfaIzIETVDnaMM52EffYzfLowdPiNBsloepGsb5pJ1OOolh2cWwvuPj55qD8TAOVZ1yLd7X7BjFFN2WjpRUqiDL+2i0GlSuSp8250Gn4JfLdND/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pJiYHlwfQRmcCIedmE7X1eOCQSmMb3DkoqEsIoUb18=;
 b=BacQ/N6yjCw6VYL5Zke9v5PLd0BQxAHePG7HBfvAPSX5WOdPhZtTPUnfNSb747PlCApW4wiB+kLRxTT3GVgjRz712Kx9auacovhEDU+Xy4zUWAjSgvrmetRLgAVmvw6CjVpGIl6voHS0TbzfEQcmNxACfYzK5t7oB/otAiq5C3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:55 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:55 +0000
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
Subject: [PATCH v4 9/9] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Thu,  6 Mar 2025 15:48:10 -0800
Message-Id: <20250306234810.75511-10-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DM4PR01MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d321be2-e2b4-4cdd-d805-08dd5d0974e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y1n2Rn0LwqvLTVlu7UWidpXMbiy2H6cxlbXZn52JJ5hMFYRGxo9dbC1kBUZ4?=
 =?us-ascii?Q?BkLlG99PtjtlWajWUEgVL16Y2Fxeu26/VAro5byowwJnY27cMsuzShFWZ1QD?=
 =?us-ascii?Q?RawKDUyt30/5bSpEJ/eX+M/4fei8sGBgF9qae19cnl0piUpJYzvfgA5pZYD7?=
 =?us-ascii?Q?2VLlVXcq9btioElJhwATOKX0tKEJzCpZ4jt2ODBj100v7sllX9X397isG1hr?=
 =?us-ascii?Q?CWL+W2uyI8SLndYCg3i8NMrUvgu2bqmFsA82JHjTCrakQoAkx0tz9WpCFxXK?=
 =?us-ascii?Q?UjlxBkRoLl6r4/WmSd4KYBROrXiZQ5WmzB2ua24Cv+DpDAPsUz1jkX5qKQT2?=
 =?us-ascii?Q?WyHk2freXGhBGQj9dESgyNKcLV5BTrKu5yUBsyq5uvax9WHbIkob/NJvtE7u?=
 =?us-ascii?Q?noROpiLSL3xnmJdOvIh/Ge+Sy3zokMN29NyebhaZAjNUUd6RF4l1RNNSDIam?=
 =?us-ascii?Q?KzS3pjjXttqcTb4PWE3OAmSeRdqaG23VTO7LQm63BdzdN1p8bZHM1BOE7g2X?=
 =?us-ascii?Q?65q6GJiCDpYiH7dS8qMXHrGb8Rat6Y0K1dF5SX8Eoy+Ad9Nh0JZj/288D5tK?=
 =?us-ascii?Q?mCX2BTqrcarsi2YzZR76Ul5UlEDa4rf5EYHfL4kOKfUU43Dl16Iz9a4L6D9r?=
 =?us-ascii?Q?88loJiHrQs7MQVUWHtynK+UVpUw8emlMgmR9UBAEQl501nOFqEr5d3vtDskB?=
 =?us-ascii?Q?miOlF1udCpgZYQ5ECzAWIgsfBfVTEkVdvVudE7Vz/gCgnZVe9vKQ98G1Mpdn?=
 =?us-ascii?Q?Ch5nn2TI03LR3dUqH3NCWaAfdSEhcqUBSB6yaGL02emPnomVjgMBvmpr7trp?=
 =?us-ascii?Q?647WI584bFgDttwPyQ67Rq2pjrfXo5AS/kJwx2ByxZHwpjUMRudOssqkbtM8?=
 =?us-ascii?Q?wZ44IQq3deYRxhyJnZRbAx7a7yKMejE0npIG3J6KtY9JnRwf9TtZ/j2v0xpP?=
 =?us-ascii?Q?uFuRj8Mir/fQlzB8VE6kr9ig5OxSQbFv46IqgiuWvYf+v2qU7C2f9DxLzWwP?=
 =?us-ascii?Q?xWrPNYImpbIeCc5mQ2jME42iONuO/Irco+BcCAzXaAGMh3qfCzkMgsTwrUGL?=
 =?us-ascii?Q?SYIdJHrDTU/Jpi5GZiK+XNdiBPqPwE/mt4zXApWCuMU459N2zUBjpInPlFlJ?=
 =?us-ascii?Q?v61ceXJmdtwbAvd/dxEu4A8hAqr8SkKMGJFCd7d4iAFqdSeTkDI2TYrX7DKj?=
 =?us-ascii?Q?/RSIwIFK1QJDt1aoLRYYmy/2Jokd38JM/1eV+CE6oi8Q4wnQ8hU8xrPzGVE6?=
 =?us-ascii?Q?OiYgocJNr0QxVgEZtTbARMm1dKroDlJDykUkIwdBxHXPs0VqrzA7T9vJ49Yz?=
 =?us-ascii?Q?cOGXAJHPdX2RFKvf8B5CAyAiKNb9XxZ2rQBuoPsaXgs9PcwjvxVQbgHhwQ6r?=
 =?us-ascii?Q?xqLtDLnRD/amB39aw2c8DLnSaPlRPc+MF/N7JR1EVcPK+/6KlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+nyo6Rhy4fhCzKio1iRQviApMWV98I2pRgzm6arX/aQMLiXUJ1Wt6YMIU4jc?=
 =?us-ascii?Q?lf2P9mvPAOJ8R7XM9LqGxDxYdqBUDrmcYhnFX9Dr8Qkybsyo0RDEWrKF8SXr?=
 =?us-ascii?Q?+Mpv9Dfsvb5nBq71I9z125vPFWFCpoB+AJogOSuewl7cfQkckRddfb4oRgG1?=
 =?us-ascii?Q?Wj58BrxHS1mqL5S7aHFzPJUafEcPU6qbzG+qW52Q9zodfhpWx0AN0obuwsSP?=
 =?us-ascii?Q?YUyENd8/2IyTxFwhASInHeRTe50kOCID4QVqSVw8/lhR6Nav2U+0yY55984N?=
 =?us-ascii?Q?HqaEpaLbpjMOG7dHqaa4LZJ9HfTp2adxi7kGlycWYWrLniVaKbhJpwkwptP+?=
 =?us-ascii?Q?/r14m0H+h6dfuXCMepcTZ+cYooCFq9sPf02EtHKY+0UmeGsl8888hdmPPpK7?=
 =?us-ascii?Q?LQi7hN3jRxyS2IRkW3RIU0XEUOk/Vd7I930WzkGa4D9wMvqv8zMtElvq4AW/?=
 =?us-ascii?Q?6s056KkWlyzbUPJtLyoDDt/6HLG1rUW+yLIfgYYC01a7ePit25qrbAhdWGtb?=
 =?us-ascii?Q?Ia4BSX67+tPcPiLd75mnIT8ngkjC22srWXt9x4nD2POq5pO64W0Qed6ttzFc?=
 =?us-ascii?Q?asYt0e0+azht9fKVCO5+AOUDvBmM2nUU/+2Z95V6uyF3Deg2BaONvqu87NTr?=
 =?us-ascii?Q?Oo2P5//cU7j0mQfxfksL1wZPw+MqFDquFZK+PhtyJfvsawsso4ZgoqKPsER6?=
 =?us-ascii?Q?HSHzCmTIgM0BGAl/6omLKAoPgRMAzG28OYx+dH92e17P0yU4n301183V782e?=
 =?us-ascii?Q?BrnDzthBmwSax/6arj1TfiHDcglGXcFlJ5USw0fPzHPREkGIp5YQRFGnV8tM?=
 =?us-ascii?Q?yDz7/Jde3Fwpane+93hT8rg+YVFM4OZ+giu5dzD2phjBWwpfOe7Btw2kOsxZ?=
 =?us-ascii?Q?nFXqov6m1J7l4Wq1ODhEQxHVAYI34TGQfb4F14L0ylitsj2OkDOoh5ud1WTw?=
 =?us-ascii?Q?DP/Ei4paI605Yc1zKO/loH/ZxGotF4zPLoBOE77hhq1HanNU4tubrx1FH30Z?=
 =?us-ascii?Q?BWd26AYKr1NXLpbVAt06iRcmCH5ZBsDo2c3mHHq5gA2QQvGRNAqpTz4kEvxV?=
 =?us-ascii?Q?Sp3f5LPNw0PAlUbl5c4MGnJMsE7HHBkeJmVfo6Zzl+zKE1IbsR9pMJWvd/XT?=
 =?us-ascii?Q?WqqrzssrnAhcF1eSeClFis7Wi4oCoG3ihuvqituL0vRREAyivW/K012QdyJx?=
 =?us-ascii?Q?yGJnPs/bt/XUJoxr4CSvL/WN+IuVWCGvsibNRJLH4ZgOJTu9UxXgbObK5Y9G?=
 =?us-ascii?Q?RGSRuO6XbN0CPVrgVpTQB67Z6M1CHUptyMm+40kh23OnQRC7i9QPrOvm1Ikg?=
 =?us-ascii?Q?CTgGvy/HotFsp99bSm+xiaV/X5Ov1Ei118F9uzvKugirQV5E7ZtoXF8gS86G?=
 =?us-ascii?Q?cyM5T49/tmcTfdMbU9wjpZBG1qqY/VJBOx3rlfAi6S9JeSlI7E398XW5F4FN?=
 =?us-ascii?Q?hthqEHddfPfhPSFRz+OVjFsgzAnr5ZWrLY+Atoo7AqDs8EQcOSPkAV75YSNC?=
 =?us-ascii?Q?q/l1e1BGXVBTG0nTeoIjwaykul3Wi0yxRBL7HPCTsvvoitMu8q2uI0Glid13?=
 =?us-ascii?Q?2Da5kVHfbb04IsH/11a0K2qwfpET56VJxCYfrcr6s5qiftEE0NKwL8FMO/02?=
 =?us-ascii?Q?UZTaMoJPgObalXFde3pbQAU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d321be2-e2b4-4cdd-d805-08dd5d0974e3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:55.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vk5F/BMIc7XA5B1CrM+BxRozyK+J9A9Ts3jor3zCZiyA3cItGjwywlnUmKCRFpACxY+4qNm7+IfDvXclkcOdroHgdJKITMpRiOnrB7p2LuY5Zlm38atbHrg0cQ7SfEPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

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
2.46.0


