Return-Path: <linux-acpi+bounces-12715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668E4A7B249
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45614177471
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CD01EF09A;
	Thu,  3 Apr 2025 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BUCucobP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D561EDA23;
	Thu,  3 Apr 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722045; cv=fail; b=ifBDNsyxh2A3J3y2b/GOWN+YVtlbWeO/YUJZw0E5dHGE0NqSpHnSxO5uu3fvxbxgVFqyhjXtDVcAhqmcggYgDiHbMm9P3g5v58xSccU/p/8tP6osXq7eUQd3W71gDjG3sZv/oDVbekHjmXHkOhx5naGLQR3ai8Eaq1fNnOHgLDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722045; c=relaxed/simple;
	bh=cNaw6M13aVwe2UTXqUqnQ1nmCgb+Zj3YHACRyVGKY30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=puMyYG9fluw3Bhmw0AnWbNL9ltZg1sazEyeR95zxBJqTY1GBHzulfwCvABqe9jM8k3MTAcDC4ZuPm4c3ardr2e4lNEgTG0leSTw/WyrgXUl9waLGRFNWS+mnHCBd8uWEyAXO6EwImDtIWGETIVDWeS683OaEieaAFS287Kvozl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BUCucobP; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUnt45Oj6wtTj5wYvoxkYINc5TCQvDI6XzAt8KmekecRyLV5bvL4UT7oSBFnAQ+2X1obbUv05eMcOLYVI82/0+fWmgQDgsrJleXe5Wqet/d1SjTGBthDBqyC0td92m0cAJC9zQvYhIJv+DwgBLWQA39lQUpVYUrvG+AjylumJ5lieaVUoekEKvDECnpITZqWlOzRsfkfpzWAaXZcJKcm/y84rPsvlChZyaFiDjc+2qEZif3zx6gWbEiVAB+pl/XXDAFQ1m+iB0+WsDq0WkNPzQJp/+XaoBf42F7EFN0RyfyNaj6UOmhxNQnrf8Ad7MWKCoUzn4WGw3PKHeIN+qSsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2Yls5G1bkQlJDqGKWWgLAA706BgvYQKQ3x+rT4Hgo0=;
 b=B6g9Zr1+Dm9azSMGQc5uciDWsDnZ6hUSDCZpO+wIuqjG14DXOkXNpBf/QVZQzv/6nRfKBS8ftPc7eeC3RJ7qkvYA+IRDt3apfPD8Q+nxpz4D3W2QZ27EV/gxcrmGyxOelCtkoU0ItryUI/VAihFUqI1WLiwNXsSilUwL3SOH53ydWVbYekjHTRYgrr3z7gfJQCk/D5z7pV+zvMtmUPPKopkkoCrjqkUVuFMsfsn5Ll1vJ6J0JsJYKyC/unGEBn/lRhZ05N/4ZhXQKAVN/bRly+1bzHeMCI6VASdsO11hk63a3X8f4bri31tfrAkBfKJZsHSBJF0cCwoF/dHvVPm33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Yls5G1bkQlJDqGKWWgLAA706BgvYQKQ3x+rT4Hgo0=;
 b=BUCucobPCayjR+6tQ9vOtjOINeY7M4XR/+V8LEEjGT/ekeFnJrVtcb9qXybzLAv/F9VC4JHrDkoeclnixHUmqjMW5TFDRb1YUw4S+OW0UdwiKXsPDIjur1xqieJo5HgEoruQO9O5sQuCd+DHv63TPAmTYohEg58MpiHVg9Bup0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:13:59 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:13:59 +0000
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
Subject: [PATCH v5 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Thu,  3 Apr 2025 16:13:35 -0700
Message-ID: <20250403231339.23708-6-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8bd5edf9-a4f7-4526-76f2-08dd73053708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ohgRZsN7AU5GaMaMp9/8CpaTw6m6l7yC/D9f/30eauIGorSnvDOOWcauH1lO?=
 =?us-ascii?Q?MZm4173CkyV4Z3evz2EdtTah39vDmSpAhKjOIN4Yrl8T5NTFF/3zDqVj6fGi?=
 =?us-ascii?Q?HCK4lOj/gjvV+8FTYBfsdjlmKJqqUyirQ6U8jKevqdjcYc5hZ4IhpMZ9ZvRY?=
 =?us-ascii?Q?bQgTKMtVXQHSEEdfZx1mdq5v5OFZadXiUalvXdl6adYhLC1pIBvrkZeahFW9?=
 =?us-ascii?Q?nYAyn0OTSjgJFjhDTTu14yREH3adBFlXUrNNouormsnT/1ySacEoVXFWLrBU?=
 =?us-ascii?Q?iZEo0j4XUSwRcy81/5LNSqZ122i1WnFA81rhX62octdtSW3CpnEWJRD90D6U?=
 =?us-ascii?Q?Kpk/107JLRRDeeuvGUhC+rda9S4ttVQQIWRo7cw2MbRXBmJY0AAIGR4aGUjj?=
 =?us-ascii?Q?x1LSfGLjNneQPOAEU0kJL4botZubY3RR9LEAl7ecEprWXEonCLR8F7ZmsI+7?=
 =?us-ascii?Q?+2Htiw3EVy6pforkn60wrP45zOeQTo1j40BA3D3i+4yq0myQDghKLQJVOUgG?=
 =?us-ascii?Q?6aE4D4NNg7YAgHcgsY/LoWPu0/n/35H6wfjGJjnMesVpexYMvgUxrjbWNval?=
 =?us-ascii?Q?ZBQmy4W+1rxRi2x7rEBMwx7zctOKEgLaPSck96NKI7uom5VtZhT+3HARFzbq?=
 =?us-ascii?Q?AbmO6ilPwGHU0ucRKJfPoNh0X5r07jg+Lp7NMyfGGuUaTnEYTf8GTGdflj0m?=
 =?us-ascii?Q?oXTNt0ld+XQi8dGUfbXrfyEwFXVmjfAWq5/Ghia8YD5bvWbw+1RXkZR4AxSS?=
 =?us-ascii?Q?WEt6A3SQPBSc8IylxqPBlPlpdmEbZSige0cl82/GIO0qqnGDi1K4NdDtcdby?=
 =?us-ascii?Q?OcQ6BwxZ6mvCSaWNJjIdZlT88Bh+5xPrcapcBxCCXjyx6bQxfg6RzSJDO8rl?=
 =?us-ascii?Q?/m4A9IOucS7Q9Cvbik38UYAXTMVuraDkBqwO0odRiJSS9eYYnC/hJN13y9q+?=
 =?us-ascii?Q?ZDqDjp2U70+EyBoNll3/EiI+4mc4QC0xVYAmrMBXc6v0KmHhClwuHQc7N31Y?=
 =?us-ascii?Q?leC3unihnGtFPPYQlEakdYc/rBT26KLSwoecRD6DY89ag5gJ5Qf6zwv0i/BP?=
 =?us-ascii?Q?W81QG1pua8MLjZzYHu8VKRlawqAIrjNwrMp5USLvSVOJNtEjxQEWyP2kX9pS?=
 =?us-ascii?Q?AUEf50XygQEYiZj0B2xWO6rQWAtSz+Y+XSLEp/W79LHfXXBYQyFMvgFFGnYk?=
 =?us-ascii?Q?1m1YWjfIYpm/gXFXFsckRuLT113+7zOB8+tzGUWcSENhxUZ2fbzHWGctd79o?=
 =?us-ascii?Q?m3au01ixxv8tBU2qyaNMlXfh10bX2jyGdT94MhaOfj1nLBkBM6hJRGe+jVqS?=
 =?us-ascii?Q?nOzuo3Uap4ifz+mAK6FWmYtmh+aZN9rNlkxj6OI3k9UghmnmHrkz4I7YHNYP?=
 =?us-ascii?Q?PnZCcTPlcnuIRArFWFuxffFxxtmbzW8RFzFEZ/obeTHh2FGIZc4T0iXNVc+G?=
 =?us-ascii?Q?1RpGlTm/joCvGoX7mqWctsSAttuKYuhVskz4o+QjMUQF2HvdGe68iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HUNWJ6mE2el8szIbZeZ0jTGFx3TEDhGu5bFnbhG1nWEENG1K8f6DeZcIrilu?=
 =?us-ascii?Q?nJZaGlTHt95mCLYe3WpEM8euKMcMFiRs44sTR33TB1lld4RgiRJZ7AYNuaa4?=
 =?us-ascii?Q?Gz/jVlyFYTILvB0fCTPmiUTrQateqybrvmli0cmEAMrRWQP7pO1bBgcgPDBH?=
 =?us-ascii?Q?Vbna0SpbuhbX6myFMHHVwbaZtIqEO8JjdF4ooT40b0F3RJvSmecopVYmjOG7?=
 =?us-ascii?Q?Hr7N8ndCwxCUUS7ERCoOxw2D100CrBdbEMTR7q+bRRu7SHhbVFcAAFKz9cbB?=
 =?us-ascii?Q?FHl283pyuE3rXPzcdAm/XbYiP7vcAYFG4jarrRptWAdSlPIaxq5CEsgJh1Gv?=
 =?us-ascii?Q?6BdK7d4SMrXu5oAoIf+CmxeZtVRk2eo2Onzfg7yuK0RhFua6XmGe75G0bE4z?=
 =?us-ascii?Q?UNsRddLKnC6nWdTt8mJnTTlEcIBf8l3FUgCaJHsWJGby1bKG3owLagi/tFVC?=
 =?us-ascii?Q?H8CpF9yi8r1tX68/w9N+nbGK2VyG4ftycScSKR5bk/bqEXwNSjQuJNjI7ujD?=
 =?us-ascii?Q?HJjyzZGi5teGVIolCSwi/yJKLaAUl3anFpGczMpiB7zTlZlYjFQWmgyaVyBx?=
 =?us-ascii?Q?eZMpcdUbWSf1+jqnX5yJ4BBV6DaG5MQlmnO0ZxdY6eIVVEZKo1bqaLkKFAT0?=
 =?us-ascii?Q?o8iGHX/XwTbmrDcCQ/b20zbDSi1ypVILUleXNB8uEIwv5JZgVSWrtnZS6dn7?=
 =?us-ascii?Q?m2hvWv7ocPDju8u1doK64DXE2n4sH4OXuL4n98BsZukoj5ZITVrRtlI4JRPB?=
 =?us-ascii?Q?LEV4e0Irb2EHFEku4YjiN4Jbgbui789xyZAD0mveIGZyDiT93mK5nPNa6Ibu?=
 =?us-ascii?Q?R7w1nd7Q4vrwVo/9/U5lExzOEReGSZesKt7JOfct2Rw14yWskrsgaqG7uiND?=
 =?us-ascii?Q?a9UaFqnCsMFnnaT8JLWkYu1+rCovbPhN/NKOB1zYHtVvxoT53/1NV87N+ugl?=
 =?us-ascii?Q?9XmihS4PJ1ytkPr3ZQygYU8TCExZD+zea9jxnbOBqARNiesbHD7Qt1WGy/vf?=
 =?us-ascii?Q?VxAtIXpmFIhUPZE8/YVvfX6yOQ6j88J07eFwxYGYZoesjLblbNytsgUV/4qp?=
 =?us-ascii?Q?F/gnYPi0ABIcCyULTnixoOO/xemG3hhrMscnWM95WZJ0Y9ORsaJCQPryABrv?=
 =?us-ascii?Q?hEO5fAeCZeOiuI++WD3LnuNMFZH95gZk0WiW29i3d4FSAwyZKGlr6QwF3oN3?=
 =?us-ascii?Q?sAEItcrVV1+bPn5vse/Qj6NTYJQeDodpPnQJ60Vk0Vbaj+MoRjATN3Nm5cG7?=
 =?us-ascii?Q?cS+fbiDW18M50SupRrqPNysB95t3ox4a3eKJhoERnpSTtk0X0hs5wCFg9rif?=
 =?us-ascii?Q?cHEKTxr/ktpBLbLi6yOBxFE3lbGJeVkw8LNBIFaiM/uSXPQkJBEwPNYs7Y4r?=
 =?us-ascii?Q?/rQF4lDBznWOpCjObtSSamUZqBTyhBziQ738ooh5UXpHv1Ngtad8UUwLNJHa?=
 =?us-ascii?Q?NJWIsTeFZmRsmJcljSjAZzngSrdI2Tgf2Fp7NZ3QSTHtVASQUNmkmXYDDjiP?=
 =?us-ascii?Q?ehRXKkAPK/Yv1lhCX6Oo8LzUxp8jrqpedtWB24BdUNH2C2taC2NUW8Dy8imr?=
 =?us-ascii?Q?n/F5uAGXsf8X96A5chcO18Rm4SMvFLqDOnLcsPlra0pm60IldLmBP3amqPNR?=
 =?us-ascii?Q?Zwfoz7vbDo3wMJFAvuiTqpk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd5edf9-a4f7-4526-76f2-08dd73053708
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:13:59.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hcu9l6fPZ8Ol9jIw0CIJNdZtwqV1bH3elOOfHc4a6LQHuRYgE0oqlrnVEKva3oV6R1QM8jyOwPCAzt416NJjVUZdV9dTEvRsNmk+i1rp8RPn87SLA9puX5YkA7Xi2om0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 64 ++++++++++++++++++++++++-------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index cd2766c69d78..77c10a7a7a9f 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 
 int apei_osc_setup(void);
 
-int einj_get_available_error_type(u32 *type);
+int einj_get_available_error_type(u32 *type, int einj_action);
 int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      u64 param4);
 int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index ada1d7026af5..0d99f9951c03 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
 static u32 available_error_type;
+static u32 available_error_type_v2;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
 }
 
-static int __einj_get_available_error_type(u32 *type)
+static int __einj_get_available_error_type(u32 *type, int einj_action)
 {
 	struct apei_exec_context ctx;
 	int rc;
 
 	einj_exec_ctx_init(&ctx);
-	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
+	rc = apei_exec_run(&ctx, einj_action);
 	if (rc)
 		return rc;
 	*type = apei_exec_ctx_get_output(&ctx);
@@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type, int einj_action)
 {
 	int rc;
 
 	mutex_lock(&einj_mutex);
-	rc = __einj_get_available_error_type(type);
+	rc = __einj_get_available_error_type(type, einj_action);
 	mutex_unlock(&einj_mutex);
 
 	return rc;
@@ -646,6 +648,7 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+static char einj_buf[32];
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -662,6 +665,12 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(31), "Vendor Defined Error Types" },
 };
 
+static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
+	{ BIT(0), "EINJV2 Processor Error" },
+	{ BIT(1), "EINJV2 Memory Error" },
+	{ BIT(2), "EINJV2 PCI Express Error" },
+};
+
 static int available_error_type_show(struct seq_file *m, void *v)
 {
 
@@ -669,17 +678,22 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
+			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+					   einjv2_error_type_string[pos].str);
+		}
+	}
 	return 0;
 }
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
+static ssize_t error_type_get(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
 {
-	*val = error_type;
-
-	return 0;
+	return simple_read_from_buffer(buf, count, ppos, einj_buf, strlen(einj_buf));
 }
 
 bool einj_is_cxl_error_type(u64 type)
@@ -712,9 +726,23 @@ int einj_validate_error_type(u64 type)
 	return 0;
 }
 
-static int error_type_set(void *data, u64 val)
+static ssize_t error_type_set(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
 {
 	int rc;
+	u64 val;
+
+	memset(einj_buf, 0, sizeof(einj_buf));
+	if (copy_from_user(einj_buf, buf, count))
+		return -EFAULT;
+
+	if (strncmp(einj_buf, "V2_", 3) == 0) {
+		if (!sscanf(einj_buf, "V2_%llx", &val))
+			return -EINVAL;
+	} else {
+		if (!sscanf(einj_buf, "%llx", &val))
+			return -EINVAL;
+	}
 
 	rc = einj_validate_error_type(val);
 	if (rc)
@@ -722,11 +750,13 @@ static int error_type_set(void *data, u64 val)
 
 	error_type = val;
 
-	return 0;
+	return count;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(error_type_fops, error_type_get, error_type_set,
-			 "0x%llx\n");
+static const struct file_operations error_type_fops = {
+	.read		= error_type_get,
+	.write		= error_type_set,
+};
 
 static int error_inject_set(void *data, u64 val)
 {
@@ -783,9 +813,15 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(&available_error_type_v2,
+						   ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+	}
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 78da9ae543a2..e70a416ec925 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
 
-- 
2.43.0


