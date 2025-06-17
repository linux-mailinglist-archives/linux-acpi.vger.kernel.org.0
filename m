Return-Path: <linux-acpi+bounces-14420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B253ADDC4E
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A034A007A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95528C5A7;
	Tue, 17 Jun 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZSnedqTW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26925487A;
	Tue, 17 Jun 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188647; cv=fail; b=VtY8wyTM9M5/aXRI/AHngat4hVGQ91AMkAqLNHnUwkxjIn1ybTWXHgJVveWJiJP4djrNDmxkmsL6nr9QBkCRR8QUiJ87smDw+lWvi3Pct1IXfHwO6iOlcZSqu1uThXzSb/m0Z1mkTiQlsQw20wrPjFJ1x8WGVQVQtvimdDl5mGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188647; c=relaxed/simple;
	bh=/aiYS3BfYKyKMK7MbAvF/1FjWUAbQ9tXARf//f0vbUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJOktzQESS4ivEc7jFTPwFeXg7IYqTbIRUSK0arHrnCKDPFgxgutSKelScjsNn+KgTBfcTc876Pg6bBwwgqFuVeuMXijMfQpo1vN3hOIelIXnBOKyRQTSmiRV6/yefhoSR1oR8uriGA4whaAJaNRo3d3NJxdo5KEfx2SQdZ9n/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZSnedqTW; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhK8Bq3uJO2dEp7x/deGKDQTE3eKs1rLXYmMI5Ir+pRjThuYwMu/3lE+LCdxZxx2PQn+lMIskBcYRRRS+QlFAW6QeL3JQa6/68TfX6SQrlHNvqD3u70+1CCCVVNdIW701kAWE5LNBbRbrjO0pNU7XAZjdf5VO4VtmZQkTavLr3r/D4agup5gFt7G4DrKKoJnG4OewQ7hVuVEYBBpdkjr0fv5QqtN1L73gNNIEYe/B2DKYMCd6mn9rY/YChdG548oeil2R64OBrUSTl0IkcteIDVwaKk0IP6K2jGCqwOJUuepq9lbsGXwtI2vh/dTWanJh1a7J9LDQsAun4B7+rI/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xv7yhUuhZnFuKmDRXKrboPqFRyX6w/BTiJ4XNjUqSE=;
 b=MStBMyrCw82RLAxqtjO/4bhUh5GPmj8x50xewts7RnS5gBiKMguAHLh2pLWeKvEa6/to4U5pPSKK1cFWVmGlgkdVs15DH2UrAmUKHfDb0jorfLCelyB8Qw8pa+ytlly77tOaJaABBvcqDOBHuHVlMalKHw2xTdM72GbZOqtI61+Z+AsWot/r84YnEhM1yB7I1zRmAD4UUX4lvHGOu4oC//pIyfSbakmIPPflkpO2igde0RiFfKh5AAhIS11s6N733OCovqFJ6UxvYSnFQwxI+tPG2csOUih96zFiEEUH5clvvP6TEK5vkQOdPgQXqFgRNzXt+pkdrsdQOnvyR1TRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xv7yhUuhZnFuKmDRXKrboPqFRyX6w/BTiJ4XNjUqSE=;
 b=ZSnedqTW2DoSCKmb6s609WOvKjESJjf5+UcWGKtkTdnkFeSDVvijfNN/lZKXyrZIS/H6/a304zsxEmQpZv38Ke8ihAkSSDjKd1EO80Ry0PYtuqONX+uZgq5y5sLRqs888amrx/q4UkCeFU5CI4JNRXPr7ejy+FXzzla7qpVcd90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:43 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:42 +0000
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
Subject: [PATCH v10 1/7] ACPI: APEI: EINJ: Fix kernel test sparse warnings
Date: Tue, 17 Jun 2025 12:30:20 -0700
Message-ID: <20250617193026.637510-2-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1b8daa1-b469-4c94-0537-08ddadd5730d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?toKlOdECnaChXTGrtdgw3WguZpMRXNqZJo6NnnRjgStn5jAnNrz5m6pgOJCy?=
 =?us-ascii?Q?EEpd8Q+USaOdY6dnJrQMWmCTt7SzJwVZkZMEQ/uEtX93sjYybnHE+536xazD?=
 =?us-ascii?Q?ZWzkuniGdEsGMotjJ5JEwO6aWpoHFy0bY/13KgT2r3kh2YZaicaUm5NWSwJH?=
 =?us-ascii?Q?QkGBZFtCGw4kFqN5QpDfZyEZtIa69dozNf5AvOs4nwm18x5yG5/Ce1gQSq+v?=
 =?us-ascii?Q?QJjOb6YT2YJgBmtSDTJGheKoYTzdv3u7Lzcl7ZR09DB6bEHS13hVMRsTR0I4?=
 =?us-ascii?Q?b+ukQnvQn6hDbPsyrdcaglkTm+7yysuJOnUt1h9w2L/IOjNFDTvqrP6k78TC?=
 =?us-ascii?Q?HCloGGKi/IqAdZF+YDxtdRozxsEVAKK+Ii1CTlgKdfq7m6qOQvHzWpsBXAeo?=
 =?us-ascii?Q?D/plDfgAtqgIk87dG+gcoI0B/uBEo/z2Nh6ecckDy2Kydk7b2bJufsJlIL1Z?=
 =?us-ascii?Q?oNCf3f6nwW3suHDSOuPI60x0Ffw76sgeX1F7n4fSJhTjNSXsmAYZS1h/PS6b?=
 =?us-ascii?Q?+11drfhnqujn6cmbt0Kk3X9y5Bdw/seMzxqlB9sHCRs0u2u2RpMFZVvQNOux?=
 =?us-ascii?Q?Gr+D4l+hWmqP7aLD+CHD0/0eVA/GsZjubxvUaYm4B2y+2kZrIQN5COQeip+R?=
 =?us-ascii?Q?oatF3vhGGoGbAEzgsvCKVX3NXIInChGHAkW79ZQqBuY3IHiwJmGQc64l884I?=
 =?us-ascii?Q?t9bDmAJWsswdZI6l52ghlxD80895D7cBUnb2It9+Xp13c2/NPTPMT2w5n1z9?=
 =?us-ascii?Q?9TEw2IRWtGKpbawEa3gXNB42jxCYFYV2tCdZthYew9AhIYYJ9QLruyPL+51l?=
 =?us-ascii?Q?+K3GZUVwuOgGyGZXe6XElk9AeqyxUWFR6yXIUi6kHOVndTH0ovMDVPtAEKON?=
 =?us-ascii?Q?iO+cYXshx/73nhtOeYon6appMILnC7RfMB8cxnGnHn/il4zyK6OhkQ4Zxgu0?=
 =?us-ascii?Q?N/EALAWAGty4iUILwQhnP9fZA6dT8C+iN9G3f8TGeV7rC3yO5CfWiqdK6e2c?=
 =?us-ascii?Q?1OVVqTgxKdwsEijtohe1uNi8MGbYXDZttsY7ofSrjxOTktFWBJnHEOV743k5?=
 =?us-ascii?Q?YolNDkOZuLnnjYSRagX68jKeXNi8dc73Xb025AVBTiSQP7C9L9hZrRBo/a+k?=
 =?us-ascii?Q?pztS/lq+iJYVw5e8rZboCLxJldGD/8WyTlOiVHKh8aP2pVa2qwkrd8r59aR2?=
 =?us-ascii?Q?xVt7VDkUxOAHjqENDMx+gh5+DmmxJMeiqnGDrxmlyGXRXEX9XkGRHPwWkU/a?=
 =?us-ascii?Q?+SCRcI5PcysR3wovBixslhoeY+1U12rMmhaAcwEPD20+NiVvoc9LFm+FPk8O?=
 =?us-ascii?Q?mXG8JlJrp4ccs8UGtAuzujY6oDjrGhfbDElMA0aTDg9pD1zy2iq88dSGa91Y?=
 =?us-ascii?Q?3nScPwG67IOVE40OIfbk8XwsDHLv/pw3VoN7GZXDU7bC2NIdehhy5dLEvzWI?=
 =?us-ascii?Q?kVjslFRlFysxq/fuEqLya1v2k/25yDMOjNebzPBWz0xx041RbEfQMvGy0hDw?=
 =?us-ascii?Q?I89FBH4nGto/ot2ZPwDKKktxKbsZPF148ozM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40cxRAfVBGIJdxVYTXz+AEiwrRaRv7qSLWSwf83RHZRCvpOe1EOaDbRV47XE?=
 =?us-ascii?Q?2wPxDQj5sUL+ZvnPnxSwBQfbP3voQr2i8quAx/UIXUDSEGJ44wuOu1FZLjme?=
 =?us-ascii?Q?smbjqvPOLaiXfyTn3xdedmPlO/7xaEPBsq8YPgeQJlY96XG3YAvSAGuXOGZ6?=
 =?us-ascii?Q?nCz/p+M9PRVbyTzjCpNz/n/jjNjzKMWHKsgN7kDM41jgPb/q44RcKbFwLwl7?=
 =?us-ascii?Q?kYhtgxiYmOsqdCfUyrZB06z7sbgYYw+YY8JQo7t/0nss7WzFKZ6MY77MuhSG?=
 =?us-ascii?Q?/jelyWfOabBeOFwyQXanA/exD0VxAO6IVt9Osk2qj3IUizgT6nl69I3pYrnL?=
 =?us-ascii?Q?gf8gdOx6JTG4AgoBNrmqhRCstHRSfdrBH5WHjOeWauqGMxi/NLevpdURvHFd?=
 =?us-ascii?Q?AuNc2OopJw/XqNPiZqWLlQ/w8DdBUzkimO4Jd84lRJvJvb8fUiXHl9kdr30P?=
 =?us-ascii?Q?ooI5kxqzARTWkigg0LDZAXAuroTBq6yCvluifbDmt3cqmJDql8fkguKP3S7i?=
 =?us-ascii?Q?DcEDtfl9lGo6Pp0Dy5brLczYt9bb1IY/z9+PNjPdmPNBpIDsoQRSBDl+wK4l?=
 =?us-ascii?Q?06hHhdywDmjWQMDl2VkVf79k4YWrG7ZWFLKhITaA6QgeOFeLHuVr/6PNaNJk?=
 =?us-ascii?Q?9aQBVcaxF+g767XUp/JJE10+ISdvyw/K08S0XB+7Ovpe0Gd5R+5U8nHUWthI?=
 =?us-ascii?Q?tahd8vcZBuY5VK7dnLHuWmBncAccHWgR32kWVGIgYqHNL3dd6NsDJct1fiQ/?=
 =?us-ascii?Q?MbJgY/Zkd3/PT0U1+MSNpV+OmYTmhUt+wJALf1kVR/mlpg629aDAQS+GLa0D?=
 =?us-ascii?Q?Gw55KF6BC6cUoLNAn1Ek3WrpwIRua9WVyqRfZamHL9y9OnJ4V5nf8nXUSKIV?=
 =?us-ascii?Q?I6ybVi30nzlQA/oUEXAU3pGchOIc9x7J639efUTYOAVi9y3RBeS21rcc+aYV?=
 =?us-ascii?Q?wX+29kFUXUcgnCh7Ckr3EnsFzG8nZvASiJLw1fKZy2lFvBBpp8P7K4RVyfeo?=
 =?us-ascii?Q?/UBvV9i2Ofje6pa3xCzVxzih55bf7HWqwsidho1e8xZCtmEOEaEIoXrNtZJe?=
 =?us-ascii?Q?+3fcsD8rJXlQ8khVTWuHXalPuZKEI7L7n5EUsfdR5mToqrLBs3KFQuSRgpAd?=
 =?us-ascii?Q?e7HPTBDThoRwvHbKp2jAELEczn0vlQf1UD1JOuKSgMdednCTgpiLrG42FEvv?=
 =?us-ascii?Q?EwgbLKuOSMjnm/melorRvE7XBspi3KJ3avQPzyiVQ528gExM1LKkXmPBcqu8?=
 =?us-ascii?Q?0Dio/OjXGDGySW8LaLqIwxGvgVWbVEuqMwOx53Ikg2sknHBWSBI5fG8vgrZH?=
 =?us-ascii?Q?Et0G9bgL3DEscjzxpTaUNvJx6YuucbFeWP7QpH0SUvnQhTbOFiG6L4qZVQSL?=
 =?us-ascii?Q?BlhvlG4KF4IIgIhiJecNqrIYG5SokZEW3/7BKrhilwC/z9RfqMh8kWJTiQ//?=
 =?us-ascii?Q?xduZYPTiQSUkklV2rWqqNaBlMFGFzxW+8dEn7G+SmZdGaAZ5aQpwMeOJd67o?=
 =?us-ascii?Q?5D921Y9oDhLnrp5SA8Tb02exFP0BiNAKQAtmG2UjmJZGytOcmU0DrJiQcVC1?=
 =?us-ascii?Q?8NqOM3/ZDkPVVkViNPgURSfQM5XDpqS0nRwWSuFfZat3110Qovshq3x2PS8l?=
 =?us-ascii?Q?SQj6NHXN7AHbxn0bksqVD2M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b8daa1-b469-4c94-0537-08ddadd5730d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:42.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ6qOBr2C4OB9yEMeYVcQRufaAsLwZAhGso6C1W24ih+HLc0uQsoAWCybCB87ZX3edEfSxww9a0lqMwC+6Tuuh0Kcrc3Mm44dSdnUBKUCDnoopuj784dm6xwTXIpsCfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

This patch fixes the kernel test robot warning reported here:
Link: https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Use pointers annotated with the __iomem marker for all iomem map calls,
and creates a local copy of the mapped IO memory for future access in
the code. memcpy_fromio() and memcpy_toio() are used to read/write data
from/to mapped IO memory.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 106 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 9b041415a9d0..e4fb4405deae 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -151,7 +151,7 @@ static DEFINE_MUTEX(einj_mutex);
  */
 bool einj_initialized __ro_after_init;
 
-static void *einj_param;
+static void __iomem *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -216,24 +216,26 @@ static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
 	int	offset = v5param->vendor_extension;
-	struct	vendor_error_type_extension *v;
+	struct	vendor_error_type_extension v;
+	struct vendor_error_type_extension __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(*p));
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
 
-static void *einj_get_parameter_address(void)
+static void __iomem *einj_get_parameter_address(void)
 {
 	int i;
 	u64 pa_v4 = 0, pa_v5 = 0;
@@ -254,26 +256,30 @@ static void *einj_get_parameter_address(void)
 		entry++;
 	}
 	if (pa_v5) {
-		struct set_error_type_with_address *v5param;
+		struct set_error_type_with_address v5param;
+		struct set_error_type_with_address __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
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
+		struct einj_parameter __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(*p));
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
@@ -319,7 +325,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
-	struct acpi_einj_trigger *trigger_tab = NULL;
+	struct acpi_einj_trigger trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -327,54 +333,57 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
+	struct acpi_einj_trigger __iomem *p;
 
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
+	p = ioremap_cache(trigger_paddr, sizeof(*p));
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
@@ -392,7 +401,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-			trigger_tab, param1, param2);
+			&trigger_tab, param1, param2);
 		if (trigger_param_region) {
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
@@ -421,13 +430,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
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
@@ -446,8 +455,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param = einj_param;
+		struct set_error_type_with_address *v5param, v5_struct;
 
+		v5param = &v5_struct;
+		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -492,15 +503,18 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
+		memcpy_toio(einj_param, v5param, sizeof(*v5param));
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
 			return rc;
 		if (einj_param) {
-			struct einj_parameter *v4param = einj_param;
+			struct einj_parameter v4param;
 
-			v4param->param1 = param1;
-			v4param->param2 = param2;
+			memcpy_fromio(&v4param, einj_param, sizeof(v4param));
+			v4param.param1 = param1;
+			v4param.param2 = param2;
+			memcpy_toio(einj_param, &v4param, sizeof(v4param));
 		}
 	}
 	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
-- 
2.43.0


