Return-Path: <linux-acpi+bounces-12719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C4A7B24F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180D63B9720
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13781F428C;
	Thu,  3 Apr 2025 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Hzc0VsoI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022079.outbound.protection.outlook.com [40.93.200.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC631F3D58;
	Thu,  3 Apr 2025 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722053; cv=fail; b=bl/JR5I+9IisYeAIJ1PRXDk6w7iVzeib5PiJ7fw3RdEOXP+5DvAIlS9giJK96A+cvyZXZ6HNQI9QKkausbHg/ZRmnPMOpvVEHwvVvAxo+yQQHDHVBQdROX9XRpW31mgWoZqC/tOTS9ZTlRy1++j3aGNV0KhXuu/PNSL4RwmaLxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722053; c=relaxed/simple;
	bh=8l1aecv3m3Eye5jGNqtGIg0tv5Pp21pIoCRGocqzii0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTlcthY8Z74TQmMneQEE8DsbsR8HhmVRLKTxP5nPLpk0Y8gLO3kq3KnVK0sh0R1luHvrpjC8qcuFRopBcLHqRs43W3U+VJRZ9Yg0cMmG9rQFNJEQ+4Pyi8hdWqPeNd7CFAHftawRA00xdRte72WqzaKKf2tqXx7ayT2Dj9qSguA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Hzc0VsoI; arc=fail smtp.client-ip=40.93.200.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBTVC3OBMWncK5xAYjNWdye7uQt0cFBS1jDEAECNsYt3lSWDPjzXWE/aLe14PR1Vip52euEr8BMPLHDs3JX8cxznPehXqoxOvmJ2PLIy0tY/zroGwyzcBJ+u07Ln/CDx65rajOnnnxsbWznlsdQc6J2w6CM8Sj0j+qXC2mVRH09qCW+7plWBsSGynGHFox0CV/iYtNJ9yXxgRY9zbqQCnplvipOWu2itIkgC0HCTEBrmeHI+ZOLXjTt8LoryRIE0xIS4NfjUCzn32hNLOUmP+6XfMpBkHK7kcsb0eSrk9aIMb9JD0oROyVi6BNmsgajPtmMUJhCuZSdnm8VzDT/xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaQEEJnlTyB8l5akguvmwyT5/C8ipo0witpQc+5/aw8=;
 b=VZKucTgjh2vTJnDZjGHtTOyNRhwUu7pXJlsUIhsBxc3IlwgbAs3PUi121rNSc1oWYg1ciCDF0WSoTLxLLvD9Yko/LrIQRjqmMoQjGhX3ozR1LVV9ZjR4/py008XV+yLorU8ePGtQwf04eu6KrG+XE0c9xQ4okFkir7tpXPHaEFOisWe5OR9U3ofZntRCiaeNTdnBYI3Blvp6VSqEAXuN80w2gzdwakP6FoMQdThd/IBU0S8Fi6ozI09UHfzsOw6wsyB5z8VsOZY9By8JrkoqhyHrqD+el6H4dvSdpZ0vCeRW4dEf6U2I0kWXJ/dFfOPxHIq1WssR09zsX2CAwMbCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaQEEJnlTyB8l5akguvmwyT5/C8ipo0witpQc+5/aw8=;
 b=Hzc0VsoIxvodlX01iHKOkFhea9oK5NZT2aJQCd8b2v85gqPgMVSdVRojXo/+IBtjzgqHEolqP6hFtfNH8Gp6llViqhsfQmYy093lzurdAUstllXTFnRPw8Gm+0tPObs5qoGUShhluFTgXc/H5u93M1XnrkoR2JDGkz7pht+eoUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:14:06 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:14:06 +0000
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
Subject: [PATCH v5 9/9] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Thu,  3 Apr 2025 16:13:39 -0700
Message-ID: <20250403231339.23708-10-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: a078f4ff-5066-4dbf-7fe6-08dd73053b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1vSB78m5Mhybd6piYpGGiIhVr49+ozsp3DX9VR65WcpPhpDdQdk+e5s6BZpe?=
 =?us-ascii?Q?OHaZOy1UlbKYKA3PmHfQbdxiW/Hd+ZmLuhfD7mOLSCr0CA5L6CN+sPqt6C6s?=
 =?us-ascii?Q?meYNuzj2fUrgVgqhz8pitToLxlDqITznGUMSmt6NkIF0JrGktp7UXvTLgXOX?=
 =?us-ascii?Q?oCx0FCcOy/qnmzjIMr8LsDJymnUkw866SAXVEEikE5ExIpGjA5go5U8rB37W?=
 =?us-ascii?Q?76m4jXfKdGrsQH3mCyyqzzHYbFzTvbkiwd34V0s5sfIGd+B94PQ+xdWTXCxX?=
 =?us-ascii?Q?QsDKIwD3nRKu2UqqKWcyhJXGynnTuh4ydW3Hx3vG4eM5e5+llsrYhCmMYad+?=
 =?us-ascii?Q?PZmXQfSohWehJOMahMXYmQk1leaXfwwCk+XlFf+P5KNxmrSi2GVe8Xagf2f8?=
 =?us-ascii?Q?Rht+CMG1PyxGdq21J1ingguMF/ikoj+hDWhqDuSgQhgz2/hxWVrpIaI9kutB?=
 =?us-ascii?Q?Vjyap20QgMCnNekLh2zxoP3StX/VFV+x7ZJULYsuinVSVxyfSmRV3tKD5AxV?=
 =?us-ascii?Q?mBXzCN84P2s62AH69sa52+bwOEKJiTQPt+bKHa+02B+Oq2vRJZPsXWN6fzoh?=
 =?us-ascii?Q?O1XnNeUaysgZWPcZ2XHvRVpViKM30Nh2Oos5ZW9JuXSEADMj+PMiTFNThaBP?=
 =?us-ascii?Q?Scy9bUQMaQlYJED3o7+gEkAEvF26Alt0nYq5ve2id02tGHMOT7jIn/PmzXmy?=
 =?us-ascii?Q?oJtAN3Y0vnL7mAdiwGeYnmy9LkxuNp9ermyB5dbKxypXXIX3hc/6fFb4QgwT?=
 =?us-ascii?Q?L0QB+Hzw5vauBuyPxaX+mo3eeD4vheI7ldhP2L8wLY/NfgVy+GObcYRJqNq/?=
 =?us-ascii?Q?CuLL9PP5NUAS8lvh9k6NdTMjQDd3xAZgO6QkxX0H2BWQinRgyY8F2tbEiMH/?=
 =?us-ascii?Q?y7WwY9AIbNTal5BiU6tXhdiTkjtQ6YAx7UfFeIIGEn1Z8xOmr8lXVokDcsqt?=
 =?us-ascii?Q?HEG8oqUR7FpoHVynz3Wf8UGreshQ8NECVRe5mh4sFGUK2oqDhutuTymYhNfG?=
 =?us-ascii?Q?T5MgR5pziBTvhCT3EiqGz0e+p4js75whzCZvUK19fJFR/t/wC72ekSGEcV+/?=
 =?us-ascii?Q?DtHE0EK2cVK5itSmvBdQE6t5sgPxMUjvidQtQlerKqHsvyfB8h/8aeSYAFgP?=
 =?us-ascii?Q?lQA1fyKtZnB15PSg5jswe96jO4/4zKb5zZn1Sx+0n3EHI+GAMcDCJpFxOfKC?=
 =?us-ascii?Q?rLsKbdG/Lw74tkFQKdO/vz3pm66kfnxoD+Mq7Tq1B2EtuIYfikyJkHpRMwzd?=
 =?us-ascii?Q?vSglGDnOdnSRQNNuCIPT47TuopDFee9eCCxEPR5C3/amefZrJ1fWcltTB30A?=
 =?us-ascii?Q?X8fay15TioRTLrn/Q6pERWOYtmFYiA65Xm1u9iU8ifMnRa2rMSIUJix0QKau?=
 =?us-ascii?Q?xRV34jzyQHgms7a/K71sffl9qAtrfCI8846bepCdw3jDrtebrL2d9As/6cZH?=
 =?us-ascii?Q?tIOa3Lmp6JEw289rcO05zKzVbzFzmZ28vgU7YV+GgFExI3F3/qPtCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajPLXcBq+PbjblvLFDX4Myys1EsUZ3rc6f26E4gn7qMxcGPINbkdwhaHK8nb?=
 =?us-ascii?Q?duiv72n/INKdjS359qcY/avmsViPJXgvZVaAg+pDNFU9TwntVd2PHOVXZ9r7?=
 =?us-ascii?Q?VLawnttLW4IiFUsELQLj/xlSgHU/KUVy5elV11S6tJbSmeR6aHYvZkYciJQZ?=
 =?us-ascii?Q?mdiCE/pbJscb1XxB7FnGC1I32rlcDyIw8tb6VImtbVktkzgo8SAHmdl/e4YY?=
 =?us-ascii?Q?79pHnJgpddccWSp9W2ak3+Lw3QkgTvG/485ZLfAj9gSuT9O4E/+r5osYZxfR?=
 =?us-ascii?Q?pv4COBPJlxheRuH8vK6WXTqsSWgI0a6YjuSlnjHXSLXKMUIqTyyzhF4tKoi+?=
 =?us-ascii?Q?HJfM4gcoimH1yJdgAalheQElylmYxsfSwyMSBdhIebm9ltK0zQsaiuIpi30A?=
 =?us-ascii?Q?g9A5xbzc2FQCnd7kPXTtTCmrm4mf7drBkfVBt1ZVyFEMlRAtPFuqoW3uzr9F?=
 =?us-ascii?Q?Yu+/1gbiwAnt91QT76vtyTj4kaZRudSEBG8fZd26qWl7GMrPiBsjr4PZ8n7t?=
 =?us-ascii?Q?fKr5WtlZR08w6v/Zq63vs2gp3BeCpU+qNzlKhW9sdI3mjO6mtdQwYlzDCdpp?=
 =?us-ascii?Q?HvVw+kBpO/VKGTAiGmjCPZ9dd46NkmS0tfyVAeKjjH15xmBUjmCQbBe/ojBk?=
 =?us-ascii?Q?zRUvz3DhJZ1i6xQA68bxtw2866SNkaaEVy2jrj42/3P6gJWLIQiNAeoVHCFx?=
 =?us-ascii?Q?QQsS7dQPrIELGm2hA+f2cl0AoH9qXlQL/MKMP/Vl8bRVosIm4uFKUfiboMaW?=
 =?us-ascii?Q?rvlGqFnnYbgl4yFwLpv7eQKg88uU3YtfXvGavnEn3gHap1lsLXSdwLlhwuI0?=
 =?us-ascii?Q?4EmJ3zsgmSSEqwlmf1D0Xzj7xBjkbNiZBn1JBOfvhVTBsLbu2bhES/uXzkpv?=
 =?us-ascii?Q?uWOejQPbGLbicHIRnD21ZMC3rWGfgulBhq/7h8GSsoC2OLes0BjUZEc2gGXW?=
 =?us-ascii?Q?o/bR62XFMNTkV4EBbyYdGR8UMgYhQieSwN0zJPa7WT8QikgAf9Uhv8qjFtP9?=
 =?us-ascii?Q?uw36MYthTJPQj2O+8AhMscmypwEKt/5D+d5ZwmYUBCKIySac9jxLe5vkL18J?=
 =?us-ascii?Q?p9i0zzj7FrW4GcJgtYlLgcrre7zvtS3XX2RwfSG6iuJNddCYoS4HQtQRxB0g?=
 =?us-ascii?Q?EyiyjeXXgrFMKYYvkZqSt3gpoe9s/r7sw0osv11+rtwsWo2RGtQ6HZ+FGOQU?=
 =?us-ascii?Q?EA+QlnejIlc8WIvCBsYLeIJveV54/rhK4y/owd6MBx07DiZKlEVsrBouyCRC?=
 =?us-ascii?Q?FLdBRDe5NF+dS1Xd5fy/9hGtU+Hu8Fp+Pc/C5tQL0vsQmltg06Eco3mV146x?=
 =?us-ascii?Q?z+lEfI3sr5ojGTruz+7y283J1in4M0SuwEpsyjnhgS27Fj+JCXLvTUE3dN13?=
 =?us-ascii?Q?4BinN2ViQy54tOFyABFrKJhPKJgjUma9StufbHAbLGDvjGiINScwz5ujXnPj?=
 =?us-ascii?Q?H+SgegB66PJj9p3MpxWO7sqG+uU1c0Bt3kAzWZEW3Nca1FB2qSrVk83cACCD?=
 =?us-ascii?Q?3X21pmr7ctw9eJ78YI7ZBRH15xgWSNpsU/5miRXVqUD64q+Rpg4twhQ2n8TY?=
 =?us-ascii?Q?eKJQJDchG/m521DdN26aZhP9hMU0uQMg8yvbCoMkI9tQWTF87atZEnalOnWl?=
 =?us-ascii?Q?j2BMVv8h0B6kfK1YvvxltIQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a078f4ff-5066-4dbf-7fe6-08dd73053b1f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:14:06.1842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pirHuQ1Bv+IhGgtj7AiWz7/Zm+uEkZPxs6Ion8j+ZQGn2aGuXfDRGKJ/ysXpWVdjLKVbBx6Z0JMBPpd2Gvr3u8eQfCcncPwufKTh8JeI9SCKcgvAOWTOcv51Na8lpH5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

Add documentation for the updated ACPI specs for EINJv2(1)(2)

(1) https://github.com/tianocore/edk2/issues/9449
(2) https://github.com/tianocore/edk2/issues/9017

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


