Return-Path: <linux-acpi+bounces-10966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8DCA2F74C
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660517A1B27
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264325744B;
	Mon, 10 Feb 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dIh91L/0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020127.outbound.protection.outlook.com [52.101.51.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA225743F;
	Mon, 10 Feb 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212652; cv=fail; b=YZNR342RfQTet15MjS3H8CfOX9FO0V+Vh6v2jhhsE/t4VqV7OB2db69YeDS9BKBhSxe/H4n9VqyDh0Xtga6n3WMmn35BV3ZtQrzaauTsXJ7WNSQHwEP8EOy0yq0UFzDlNhn+9i1sm4jQqXq/BrLsTgFslz3CTL7a/xybDjMERlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212652; c=relaxed/simple;
	bh=t53Y+qSJy2Wb1nGLQDlxoBz/8pGXFSM2I8XNjA5lzOg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mdDdIj8v6qIspJTyemCiJUmti0dLUWWHZRC5v2MSmra5ZzCowslwTD4LlxmFxsiWwpFwW8o3A54ydS+fBB280pToe5nPE9UiBY3Gg12TecN7TnFy2i8PTDBHcCyZptmGCYOYTY+hSsbht0zpQscMIDD7sqgSGuXmtWOUf3x28X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dIh91L/0; arc=fail smtp.client-ip=52.101.51.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVd/H+lhqbIbPgCgbLL5iZA41G2luTCh7Eulgfm4QrK/+re9meG3a22YfvpcIsbEeYM1MC/ZuZO1ZgW3+p2QOC27mklADR6N+eVd8XPOTk1+zTqmQuLXag5jwoeTijbu+yhXUeicArX9aR/CAT5BfFY5cii0ECqOe3UnlVqA0v2OZzKidFR9bU0j38RTVdyHAcdXDch9Hz9bB6pT8/hpv5o+9xgoA+/+JVi3avyiJRAZZDTHdMRopcqpBIqtwr8yHPZ6SxU2ppXmx+ju4PA75xANdSfKVtL1mc63N9BC1/o1p30g+HTD+nWHVxZjujKHcqBJ9cbEsegFRB9FRVGQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkOhofAN+D1otD3tHgzZkTUBEDgrVUS77PAwXmnJ9sI=;
 b=LZr8vx8NIn7+ymb8oeDebbbKA8fZV53v8HiOJMxhF9ms51qceew2VyxF+RNJhN4Kd1P3e/EHu7svrAXkkNSaq8XeIg07u8rAsua7A/3IlHbeHX5rQ9l04wL8GDFNqJqf34pv0wE5pYTnRT1RVPmy/2PUDRi5Ti7dSL8T7xHP5g54IymCOpy9CD5deODPv8U/cU56KvLBctmwmcTyId7ZnVCb63Blps1S7nrItB6/XBMBpz4mJPM/5kSzsNRLfl0lZHqybAE5W/Cf4ANy10/GWLl4lksq+v+4pe+rPzZYZBNJ5GA3RDFkbVl1X8VqRO+Qr9XS6ydeV2sRDlB/HWizIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkOhofAN+D1otD3tHgzZkTUBEDgrVUS77PAwXmnJ9sI=;
 b=dIh91L/0PsGkRr9ALNfjM12RpJtYk6nOQurMcxTbTC8Lw1pTplTOHDCT6VX7XoqAXSNXwU7xJta5pjzYF0HTkRBKkW0PDze0fyy+Yi4SchYLgHzk3mA2Mcxu4u/ZXH/H7LgILA7G66i40pGTee0/Ep2YytmTZvmpUbGtIUOjM8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 LV8PR01MB8678.prod.exchangelabs.com (2603:10b6:408:1ed::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:25 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:25 +0000
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
Subject: [PATCH v3 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse warning
Date: Mon, 10 Feb 2025 10:36:59 -0800
Message-Id: <20250210183705.1114624-4-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|LV8PR01MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bc412f-8d66-48bc-83ec-08dd4a01f674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPKNnykOyBDukQ6IHTrK9X3g94Y1+IxVDJ87uN16tuFz3uxxmlYcaNu32jIr?=
 =?us-ascii?Q?n/XUzG1Izcizq37p9fxMTDa1AFPSl4oMhg6NC3t08ItPIaOV5bjv7T7sltGd?=
 =?us-ascii?Q?dEzV5S6Iit3n6l/RqkrKszyy7uHIwb8XPzbz3L24sNIuXIqZmtIXATOCxPMx?=
 =?us-ascii?Q?7OXRkZArOXyKObOAr5djss12pWP2HeFVFUOG0pQ7gIo7l6NNL0TeE0P9+RWm?=
 =?us-ascii?Q?NAxMevm89YRmNmqgPly0VJS4eTnmUzZerjaboFfG8FZ/doW64bRJ34kzPWFd?=
 =?us-ascii?Q?3owkiOLNq6Cs9LpI4U3FfEW41WziWkeFZKPiRLAueWsPbqF535HN2Rz9oZv2?=
 =?us-ascii?Q?WH5UyQuQoNHIkVV3ZE1jyUFx/oiB0pnV2iLUg719fvoGAqLdLOm31AGo4Al9?=
 =?us-ascii?Q?dTPiARjHDbuv97J7jtRAh76KTyS1Ka8yVFGieHkf779ql6nGelXog1AX+0Nm?=
 =?us-ascii?Q?Rh1fIijLADDfPPYc0pWuRyjp8hPQMJyWsMAUsOOBhUtb3QnJoI/xc5Zm1Kkm?=
 =?us-ascii?Q?UOoMBuOaptdQbtWQnRoAn8SeNifhbayo9IFL2znMDMqNagJCVDNTdVMP/f/S?=
 =?us-ascii?Q?VbfgA2QMbznDf9VyehCMqVbeK0UbkND8mKNjsdwCv23ZYltYn4Hgi1Bh/m5j?=
 =?us-ascii?Q?JG7JqqLqdkK+301AAH+3LSZ6Dex8EDh9Jvzeu5F63jCDqOEP9Cy5nKVftLj4?=
 =?us-ascii?Q?oXCw3xaoaF+fLeOX111wPy9fFP1QX7p603Ib/+1HsfNDSKiaKLSR41FEXCEe?=
 =?us-ascii?Q?pIy8v18/d76WSQZhfE683A0n7+g8de+3UdYp305kw6dvKDvL84SDZZKRtLX2?=
 =?us-ascii?Q?/NQs92Hc9TIdvcWT/W+HyZoJcZdZ/DuUZlkKw8AkX1xVSCLLAsTK5Onrm9KV?=
 =?us-ascii?Q?g0R9eQGIALkSSzf+BT21IZqj18jm8VOy2nXJy9q5tHyEMrNNi81N2EFSnEcc?=
 =?us-ascii?Q?PG63Yo4VekYcoys9IIShT02hSGdzRhXxY4RxvVIV0mA6hdaqekTeI+I0KGvO?=
 =?us-ascii?Q?7Ws8cp6WDi2HScoqOGhO93kZ+mejd7zq6M0Pj78KGGEUB4P2eZ7+6JLN2I2X?=
 =?us-ascii?Q?ysUFrhS0yKqeP63UjRdDkRWBgZ2PooFkjfbbZK3A6dkI3EinozdkhOER3doy?=
 =?us-ascii?Q?76BYlDrfKIH5IJaDxstVxwzYp63QswcIQX/CmsQ/aB6h+Y8tLZGoFsvvWoOp?=
 =?us-ascii?Q?/vd0sBA8dA1157ljMtE5JDMXUguMc2GrcaDKtrt3wQD0SZu9GuUYPtA0p2zd?=
 =?us-ascii?Q?NQArlPGfIOEn1GITHBylnDzrwQpyo9iIb0A0UGHYFVWB+hAHih+OqJFnAtdm?=
 =?us-ascii?Q?usA1NoUyv84mzwfsCsbtN9eCki5y8HjV8ceVjnFYMYLhT1VNatyZuSXnqvel?=
 =?us-ascii?Q?PPLEokATi2Hx/yn2afV0owHYjBSWGay0LkQ+qMFXyT2EczMfk935VoNNmJ7W?=
 =?us-ascii?Q?hLtkN1Y3jTyNLpLRRFc0NeN2uQInoDK/eAive3lVXEczdm7IhCIezg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHNZpmiwV3iHdo2Yr53nDGtdz6049oFvo/Iix44HYx/+4tueKfNv3V40u298?=
 =?us-ascii?Q?lutKC5BzlHMmW2pgBC5DF/VhfNWvFNrMg7c9h0SHbSRVQ6Unu88V+l8+Fz6m?=
 =?us-ascii?Q?+gktfpq4BWHnGVoDjBmtBQX9gT+a3RRanQilyqpLO68ooxj18R78G4gJx3mV?=
 =?us-ascii?Q?7XLqIGc0KV6Uhomn3wskrhHSlbLcEn/4RuVh3YXcmubaQkkYje4JNDC4DBfD?=
 =?us-ascii?Q?bg9xHaoTnd07ry3dNHmpIO36f7sVtbSMqaJcLPcyS7O15DWWH4J1g+jBIpBh?=
 =?us-ascii?Q?e5BjUF439fTuqDUwyx/UNypwbgJ7/W3Bn2SQOme4MZtOvOpIl5O4ZSp9Ui7y?=
 =?us-ascii?Q?Th4tDLxE+PJGj8CbFn8ce5M4oJqjOt1LkccykQdgvJZ7i+C7kS7O/PdtFjN2?=
 =?us-ascii?Q?C9D9av7Un0YAn+e05iQqDQ9NUOc7L5PrgHo1VUMYbG3wB7JsDy0Dtghskmh/?=
 =?us-ascii?Q?b9BHO7Op/jwTkK3UR/AEDpYuryb1cTG3h37KAsmn/wP6BrVczCySubP06D8Y?=
 =?us-ascii?Q?d8ixOv/QU3tdVDo619RAz0YyEYV8O3LY+fxC+ym26IerfWOCb556wEkJv+CN?=
 =?us-ascii?Q?1YiI0LaVq9RrrMLMl6GWZ9hrEaMxD3NTzE2lursaRmWwjYnfHwFUimx289w2?=
 =?us-ascii?Q?mny6zBXhk8Oy93j3zcPFYJKXCbQQ8YFDrUBWbvZQ5e+y9Z5q74ElLavIFLxg?=
 =?us-ascii?Q?SeXCU6+P4XrmUMoEOhEUmronvMCHZETmG1OwCX6GXMyTw6vCv9ziR87PttBh?=
 =?us-ascii?Q?nEUzg+bXk6appySbNHYvDeGsBwQTteFvkdn6/JlxMOI/2JBwyqaHfKCjzUBk?=
 =?us-ascii?Q?q7Eo0gwXgP850LinvaoM3oOrmN0XQZAEVE34s4Joh9StKt9vGXCjEgPP4ANZ?=
 =?us-ascii?Q?s36+ozdU1JE4Zo+Qkb+9yyy+5ma/LEb060QFlbLfhhmZXr3pFGwkBDwgkESS?=
 =?us-ascii?Q?xqH238rWXo70zKcM3cM01g2idnonU1Rnnkkfc9tmku4nK7TQq0irWkSfhARC?=
 =?us-ascii?Q?stSiKUJ7ZxB+nR3BFzDaUh4SBsleXU9C0GJ7mctGfFqOqBEqGLqcR+Tro3Cy?=
 =?us-ascii?Q?xupEGt7fuMzAGocl0uSWgtThsShGay9zF24g42cdLASSLY/Y8iTk7k93m3D1?=
 =?us-ascii?Q?TpvjDlHzcKG2xMhJuYwmkS6I6gT8FZFE70/pv1Q4ibOJgYVg+XWIbHbwUnVe?=
 =?us-ascii?Q?oImr2S+q0SQ7Ir7MeeGsQ30yXsN4E5rn+w5aNtRDlyOaf+natrgw2oPODkm7?=
 =?us-ascii?Q?oY+wP/1d78UxbrsRa+sKp2xGYUAgWw1Wt8BLnj6VzuPpHDklR2VtIDOGp+2+?=
 =?us-ascii?Q?X4dsy6128k9g83KhK5snTgONyupsrHc4w+VZq0h4m816jYZ2K7Zv+ReovDnJ?=
 =?us-ascii?Q?TnqfxUI749bkSgsqfC+FSjiH264EDB5hOoj5L/YnV4Wf3Hdk2g8by3QGYLtW?=
 =?us-ascii?Q?fMyGMN0CjCRbdVDcknrM2S2qrpR1HmHOwLBJpwih61U/6btTOU+oY1ZjNrGd?=
 =?us-ascii?Q?SxOT9kIYLVSVvxHumptaywjr3orto2sbAxSWxDLCLxaEYm7ZJHOuKEO4aH3I?=
 =?us-ascii?Q?o87MKUS30jeMYI+4txmgqaItG7A/lw2Wj/bUk4fd5kQ/FaTlqUr1DobLivWK?=
 =?us-ascii?Q?ieE/51pKS6GlipzRtffDrEw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bc412f-8d66-48bc-83ec-08dd4a01f674
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:24.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM0mQPeMtBm85qIFcGba8tYypdiAobqknGcwptg8qvu5MK7hlmFN9l5prvAHpAv3SldxUyWR4IlueW7njF+G4yaQK8REDf9P19tOOw20KHZ+c7UTbT5SUbtxppaczR5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8678

This patch fixes the kernel test robot warning reported here:
https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 103 ++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..a28310aacbba 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
  */
 bool einj_initialized __ro_after_init;
 
-static void *einj_param;
+static void __iomem *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -214,21 +214,23 @@ static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
 	int	offset = v5param->vendor_extension;
-	struct	vendor_error_type_extension *v;
+	struct	vendor_error_type_extension v;
+	void __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(v));
+	if (!p)
 		return;
-	get_oem_vendor_struct(paddr, offset, v);
-	sbdf = v->pcie_sbdf;
+	memcpy_fromio(&v, p, sizeof(v));
+	get_oem_vendor_struct(paddr, offset, &v);
+	sbdf = v.pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
 		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
-		 v->vendor_id, v->device_id, v->rev_id);
-	acpi_os_unmap_iomem(v, sizeof(*v));
+		 v.vendor_id, v.device_id, v.rev_id);
+	acpi_os_unmap_iomem(p, sizeof(v));
 }
 
 static void *einj_get_parameter_address(void)
@@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
 		entry++;
 	}
 	if (pa_v5) {
-		struct set_error_type_with_address *v5param;
+		struct set_error_type_with_address v5param;
+		void __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(v5param));
+		if (p) {
+			memcpy_fromio(&v5param, p, sizeof(v5param));
 			acpi5 = 1;
-			check_vendor_extension(pa_v5, v5param);
-			return v5param;
+			check_vendor_extension(pa_v5, &v5param);
+			return p;
 		}
 	}
 	if (param_extension && pa_v4) {
-		struct einj_parameter *v4param;
+		struct einj_parameter v4param;
+		void __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(v4param));
+		if (!p)
 			return NULL;
-		if (v4param->reserved1 || v4param->reserved2) {
-			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
+		memcpy_fromio(&v4param, p, sizeof(v4param));
+		if (v4param.reserved1 || v4param.reserved2) {
+			acpi_os_unmap_iomem(p, sizeof(v4param));
 			return NULL;
 		}
-		return v4param;
+		return p;
 	}
 
 	return NULL;
@@ -317,7 +323,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
-	struct acpi_einj_trigger *trigger_tab = NULL;
+	struct acpi_einj_trigger trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -325,54 +331,57 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
+	void __iomem *p;
 
-	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
+	r = request_mem_region(trigger_paddr, sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
 		       (unsigned long long)trigger_paddr +
-			    sizeof(*trigger_tab) - 1);
+			    sizeof(trigger_tab) - 1);
 		goto out;
 	}
-	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
-	if (!trigger_tab) {
+	p = ioremap_cache(trigger_paddr, sizeof(trigger_tab));
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_header;
 	}
-	rc = einj_check_trigger_header(trigger_tab);
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
+	rc = einj_check_trigger_header(&trigger_tab);
 	if (rc) {
 		pr_warn(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
 	/* No action structures in the TRIGGER_ERROR table, nothing to do */
-	if (!trigger_tab->entry_count)
+	if (!trigger_tab.entry_count)
 		goto out_rel_header;
 
 	rc = -EIO;
-	table_size = trigger_tab->table_size;
-	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			       table_size - sizeof(*trigger_tab),
+	table_size = trigger_tab.table_size;
+	r = request_mem_region(trigger_paddr + sizeof(trigger_tab),
+			       table_size - sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
-		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
+		       (unsigned long long)trigger_paddr + sizeof(trigger_tab),
 		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
-	iounmap(trigger_tab);
-	trigger_tab = ioremap_cache(trigger_paddr, table_size);
-	if (!trigger_tab) {
+	iounmap(p);
+	p = ioremap_cache(trigger_paddr, table_size);
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_entry;
 	}
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
 	trigger_entry = (struct acpi_whea_header *)
-		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
+		((char *)&trigger_tab + sizeof(struct acpi_einj_trigger));
 	apei_resources_init(&trigger_resources);
 	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
 			   ARRAY_SIZE(einj_ins_type),
-			   trigger_entry, trigger_tab->entry_count);
+			   trigger_entry, trigger_tab.entry_count);
 	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
 	if (rc)
 		goto out_fini;
@@ -390,7 +399,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-			trigger_tab, param1, param2);
+			&trigger_tab, param1, param2);
 		if (trigger_param_region) {
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
@@ -419,13 +428,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 out_fini:
 	apei_resources_fini(&trigger_resources);
 out_rel_entry:
-	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			   table_size - sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr + sizeof(trigger_tab),
+			   table_size - sizeof(trigger_tab));
 out_rel_header:
-	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr, sizeof(trigger_tab));
 out:
-	if (trigger_tab)
-		iounmap(trigger_tab);
+	if (p)
+		iounmap(p);
 
 	return rc;
 }
@@ -444,8 +453,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param = einj_param;
+		struct set_error_type_with_address *v5param;
 
+		v5param = kmalloc(sizeof(*v5param), GFP_KERNEL);
+		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -490,15 +501,21 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
+		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
 			return rc;
 		if (einj_param) {
-			struct einj_parameter *v4param = einj_param;
+			struct einj_parameter *v4param;
 
+			v4param = kmalloc(sizeof(*v4param), GFP_KERNEL);
+			memcpy_fromio(v4param, einj_param, sizeof(*v4param));
 			v4param->param1 = param1;
 			v4param->param2 = param2;
+			memcpy_toio(einj_param, v4param, sizeof(*v4param));
+			kfree(v4param);
 		}
 	}
 	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
-- 
2.34.1


