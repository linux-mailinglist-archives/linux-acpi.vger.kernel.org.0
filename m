Return-Path: <linux-acpi+bounces-14139-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C84ACE6AF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1246F1899586
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E422D792;
	Wed,  4 Jun 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Xp+sEbyn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85E213220;
	Wed,  4 Jun 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076703; cv=fail; b=cJdP2BR1739U4oObs0XtolYH0p8sa7XTYLX/rQsq0RHHDGh1DkXg6mzEiXvwBP6d5anr4WG226VXO7m7ZN0zxxvf9vrG3jIUABN9Md0809WRH5ynsG1LDRxaCLLKda96KYitFgeUojX5gI/FrGoeFuTMWNDRa3urtoFcOUMIL2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076703; c=relaxed/simple;
	bh=q09/G6gujr2DP9gFYjlnU7Wiw8ziZ4QgoXCESk1J8Wg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+UWjxbrLBsgGJUlkH7KdosSeGX30FmJ6MTwjk1lDJPzc+K0UmFKNCxjuLRvkqOxwOWnWTvsDXD3frQgmVFwOQypZnf2UR92GhVznY/o3agIdGfGSN+rocvIQ3Hs1NY+b9u51JinHVyG0eqlnnH/R9rje3qBakaW1x1njGOx8HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Xp+sEbyn; arc=fail smtp.client-ip=40.93.201.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMnsnmAVLOpe9WVALZ1sYnljdthboZ6HN6d0yKB+qDVwnF0l4yKJX+3WArhEMH6+KCd2L6IMwI24nojd29Y9GPp+HDard63oRUttOK6o6oOFuUX9BnLBgXBQ+Mwi6SzHuRYeUW6zjtUKsvmXARFLxCfWdbemgt+AlAkUrm5OHaNf8hDWbIRcyrKU1r3rM3sfOOytPtHuXxEErd6xtbJqgM3tBvbtrdHjvt6T23AGvZwfLigqAQzXex7VIhq7/i0RCzhNIuxMkJ6LJy41E1LcQixG8VFPu6UbWBHbToBv+p4LyccRvdmucfoe0oNtybZrHhbnCaGW5H2fUxUW91AKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqQ2pH/ZH+5sUkOfH6ltcAJH94eurveAuVDsjoJAleI=;
 b=mVFyJzEv7o4btA4T9eYpM4budoWXLNEFQAC31YS8bOMty6oCcZ2Wtl4oWrcHNCEgwbAK00dhM7TaVPJdq1E1oAn/foc8ys9z/Rjnio9G+Gvi1LdpLZ4l4j3UL8/p+16NvZpvHoPrxOFN7glBZebmhhplzP7He4tV5xN5d8HnQp8JcIYsh172WnB9oOKWlzfkh1aqdVzfYPEpT2Awrt5/2WgA99I/DmPPr7BF9iNwB1bGGjqt499nYk/Yhc5w9gnbdHp8FlZagYkS7bSXYKqGxxRe3K54L92iPBlu+G4H22M/rFn4/wLr8tH1bxWQTwgavcsv0j2AHNL7gUKELEZ7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqQ2pH/ZH+5sUkOfH6ltcAJH94eurveAuVDsjoJAleI=;
 b=Xp+sEbyn9vd/ngVPvIx1UmrgcFYihrIKSj75eUP2BiWebhpXA78i9M8C2xX3/+nuA+9coyC/fVQuqWrS4KkS6C4fni0KVKWwS1MKIazbB+MWerdiYmlnuzmxmR9A6QHotLDA2/iykMXMR042y6Zx9Nf/Y2aO+ZdmEBqtWTkCt8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 CH7PR01MB8810.prod.exchangelabs.com (2603:10b6:610:24a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Wed, 4 Jun 2025 22:38:18 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:18 +0000
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
	u.kleine-koenig@baylibre.com,
	jonathanh@nvidia.com,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	peterz@infradead.org,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	Benjamin.Cheatham@amd.com,
	dave.jiang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v8 1/7] ACPI: APEI: EINJ: Fix kernel test sparse warnings
Date: Wed,  4 Jun 2025 15:37:58 -0700
Message-ID: <20250604223804.842501-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
References: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|CH7PR01MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b35e6e-1309-4359-ec32-08dda3b880d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aKx8D9C+wIS5FLzqbCTOUrviU7kQoldxFaqEYDQ5e7f0oagshB6l9qmmUu5a?=
 =?us-ascii?Q?feAYSqtgXdb7e9Gh1dOpYxaRMSSkFiTTGe1n+Msiq1OnzYe5KWCEfO+UN/1v?=
 =?us-ascii?Q?fi9ZJl+U8BnKKmeV10I94liPnSDRBjRB3rGByax2HSikuTraAF2tt9d2uSIs?=
 =?us-ascii?Q?DzaYMNc/ZKwb+Ix50xU05kgedBc3jVdtDSyDb4iTy3yoy7crZ3ZeWSurJcXq?=
 =?us-ascii?Q?WU9m/dSfT24sP7ak1rn2uGf/n1DJs5pEVk2cuonECYgX+5hPi3yT2eJl1Kb8?=
 =?us-ascii?Q?IUq5dKpfSGThae/cgYoRRr7215kCtBMfZSljM6/ngpHtNzgDrMf9KbAMo9Qt?=
 =?us-ascii?Q?Z03PIkRVdoxDT9I3dfGbA9HBqlqtKQuAsnmUiuvnhNeszrs1Y+2lQDo8KFza?=
 =?us-ascii?Q?Y6pcd3l3XHynpAljGgPFb0Hv63yFjMEVWFSVaVTGT93dXalAEqEYXgCM5vjU?=
 =?us-ascii?Q?25d1PuNiQOPOYyBrCFis00ZHVfjhKwGJGB2Pp3V2Js/WtEOXmKlqTRx2gVsh?=
 =?us-ascii?Q?cGeDPJBhF9awN/HJPiS0rtSgeY2cx6oPmFDUEA5pF+p/U9ucsl8jAwTZ69Zk?=
 =?us-ascii?Q?P7Tn/9j04e50ysqCIDC+HALn0eiy3y/TKAovvL7jBf5C/VJ0mgOUnDIzq4dN?=
 =?us-ascii?Q?zzpwATmiAtblPJPq/uVN08YvAn5mgIHIG+612WJrTprGLjqa4mKT95YM/G4f?=
 =?us-ascii?Q?u/Hv+0+ZFucs9WIJ+atu6Has35autFPM4VCVZvcynuyqVkJeq18WvTgMYgXc?=
 =?us-ascii?Q?iPbVv9uWZGbBun6Wc69CVpGH89xcvrNb0IRXg8kz18Sp7fOFgsHOEQn10RRP?=
 =?us-ascii?Q?vx2XDf5+i5T4DO5vOqeRNTlLkNR1nMV4QOmH3UVYqwGQ+BLxywf5eQXmlh6o?=
 =?us-ascii?Q?kmmnmYro+cGa1GrJI2hCKXM0uOAGwmbZp7r++zyC6mgoRAD00mg01D1jzXI3?=
 =?us-ascii?Q?vM0v8d+WHny/lafzOK0bT+BfBt17+gvKpjfvJdxbbYoFbaKOk4ODWFbjipQa?=
 =?us-ascii?Q?sqrfk5IxXCpF947mWvWA+Ukfoliu+5L0yVAPnXsHnP9+119qEijmLhtszzGY?=
 =?us-ascii?Q?sB68JljD1l6tUMt8zyRlQYE/Kboz7NojHtpw4uAupipTEiCHeFC+2NvFK9XH?=
 =?us-ascii?Q?sZWBPQK1JOotf+4HP3zV3DWVK5ZVa3C2bTr4ZbT1UqQpv5HjrmSc8ecHLRLi?=
 =?us-ascii?Q?wCGoCsx8BnioQqplw5id/FObtA6cjG/+A/Pi2qDMBTo/ZoII8wfIf4mpjaFv?=
 =?us-ascii?Q?LKdKeXwvIMmDx62J+E3GTgMdrO6anXsweuE2iRxA7SPEfMgTDLp7EC6SabSv?=
 =?us-ascii?Q?RvlDNwe3oByDw9yxZ+kP1kPu2zgTOZl1gga4148nVsjz4Oui8Y33K9vO4WXe?=
 =?us-ascii?Q?1A51mXQfNQDh/dnZWzyrEtKJuTz0FgtlcAo24wwItq5wl4s7ZSW2+Wk7V0AX?=
 =?us-ascii?Q?WJp5+l+SCbDuEynI9S7hhTgmx7IRoyVD7SVVRy2FE8cq8A6sgU20KlNAr+QM?=
 =?us-ascii?Q?7vqdcRJZYHItIG1CrqfVzvyxQ76XQFJrZkU7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iHL8b4+B8Y/tvO2xDAuE9lg1WQELoXe43ov6uhrC7gqWnLEc6xu4OSPzx/Kj?=
 =?us-ascii?Q?T1htvuP9hKdDryC/G074LRf7kZI6p3h5kNwXC9hFnDwA+rJvizrz6s0zOiRE?=
 =?us-ascii?Q?9S9f+coup0WVQLzVbSDctj/vIImG+1J8QsYhNjpgyITYXgwlp9IYBRBZs0AW?=
 =?us-ascii?Q?3wxkzLna5c/Ja+CdHbMaE7bGNaXJ0pvZpVfr9Bg4v5ml3CGHzENsTso54Uuq?=
 =?us-ascii?Q?iPjzRAETFZgCmfBGl4euvLHtLiobR/OhF4CyEYZiSV6V57tnjHkVJZT2Sl9q?=
 =?us-ascii?Q?0pu14FqJnr8k+lg0241nXBIyB8qxNqbME/LDMNlsFsWQSgfoyIfhHPGZJ44W?=
 =?us-ascii?Q?K1NVeLrxuXOHneqHISsO1z5jcymZYgsrPMwClDTd1j5TL6wX6P+IxlJFUnSV?=
 =?us-ascii?Q?OEia/jD+Y81LSJ8ciZTDLwhwvPyD9pAbOS/CBdUeBE7jJdIw+gy2QK9BuF3T?=
 =?us-ascii?Q?ynRxYPk3tXp5+0WzJAnTITbQKu/XuEzBW48Xe0iIV79vTZluWRomonPIXi1k?=
 =?us-ascii?Q?TV/Aghe+9bcLoAcFj5sts5olrN/jCojNxFGatbJbF6xBRtYxkWaIGfkQSwlw?=
 =?us-ascii?Q?4468iIbz/BKPC7O+ReVKqjllzoW/Wp9qU7GpaU6y48Pl/gbPvX70gwFh5Dw9?=
 =?us-ascii?Q?cdvQ7+R5dcr+tWOJlfo77FYdwPWJPTLAzmeaMlq8ftCiTLQfabJ5E6OXKBAy?=
 =?us-ascii?Q?czzzOwJoINFZ1jDU/t7uVxrcw/GekN0vOKzurq/QG52ouwR7u3lgU4Zc4ujv?=
 =?us-ascii?Q?wSzfYF+nIl2wHsHRoMhgGax5VsILYzMZSUssDJ7JRTFuZRI2tllluS82SjB1?=
 =?us-ascii?Q?9ifEsP0pWxOxcuDh+czfZco/H+jbYDUfqvy59icey7L1JxtkRWGrbQGA176e?=
 =?us-ascii?Q?V/h45Skyg/9P3mkZeiiHY1n3khU8H+MLnu5s2LkNSb2KY05WJgSjs5wQwkDX?=
 =?us-ascii?Q?ie5r+XGwR8ObEiN0cBwhKK5tlPvomQOMmWPWw9g2V4MN4uxUMj/EwBPjPBRy?=
 =?us-ascii?Q?Y9esv8sDSC3dx2OiS1ihvJt9/t5+XLs59bpuoeu5iVPOvW+2LKlzJbPNSza6?=
 =?us-ascii?Q?4+MytMQmWqaUQ7g2aJSIY2bPUM2iUNAjB/rzML+hQq6QOQAHBckiC7RG+BpW?=
 =?us-ascii?Q?mZpgWttILnrs5CEh50BJWtK+uMPNOggP0j3ZgxhbdcNYw2rIWEM6LCI41Uys?=
 =?us-ascii?Q?7qPViLi/thPGrkHhP8XD3wh+ilEEPosRC28AILEdZELpYZ8gZhKQRgt9gJmv?=
 =?us-ascii?Q?+ZJeRuK85fRnHoCR1w5MxmgFlWKn8I0Wr5G5UCpImCJBx7Upsf9spvEakcEl?=
 =?us-ascii?Q?XkYnJWKpfjs5NSGZo0EuM0sQkW7RadZi6RnZPExXkHYrE+THQqvURfI4PnG/?=
 =?us-ascii?Q?iE4wdvrWkuMrkTgkClvxHQ7ccb8MNUi5ZUndG9pq3lM9woTarUja23SdmI9t?=
 =?us-ascii?Q?OYZm1EBKj53KUOjYV4V8VgU5e0JnV9yiwzAsARpQlMPspY9IgM2LSHIZCmBW?=
 =?us-ascii?Q?JR7WTbrlIwecnd+OK3GA8/I2KAc4qZjbcUaJ03Z5532GUgVlt0PjfXeWgzHr?=
 =?us-ascii?Q?LlxU9KQLN+xQlD8j5Y73MmxPRVRTW3HytVqAqNJRhWFvXrnGx33b+tgiFe7f?=
 =?us-ascii?Q?sHg5NqBKajsbLgoa3SmK7jY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b35e6e-1309-4359-ec32-08dda3b880d7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:18.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmgH2y/S500qOTjNoRwrfqern9vXqR+jV9ljEPJljg9wBhnaJFdP/Lb3fXv19t90xWMwmi1EyNtUZo/0JvScZLDCozU0DoqPbBd4Ufreg++eFidPJXN+YCBbG5rk1KGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8810

This patch fixes the kernel test robot warning reported here:
Link: https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Use pointers annotated with the __iomem marker for all iomem map calls,
and creates a local copy of the mapped IO memory for future access in
the code. memcpy_fromio() and memcpy_toio() are used to read/write data
from/to mapped IO memory.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj-core.c | 106 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index fea11a35eea3..b9cdd3e44855 100644
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


