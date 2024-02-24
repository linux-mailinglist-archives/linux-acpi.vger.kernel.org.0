Return-Path: <linux-acpi+bounces-3938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB58862703
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Feb 2024 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F496B21731
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Feb 2024 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C618481B7;
	Sat, 24 Feb 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHlAUxTc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E94EDE;
	Sat, 24 Feb 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708803036; cv=fail; b=NgR9uRzPyjeOQoFjdAIwAruxhVyZWyJo1wS6O+vAfWBzzEfGSV+pPukvnGeKtIkCdqZUby/uAo5zcwKpb8HttU52QOIgaoxfRrN3C3KZ7TF0v2rCmZlrwbaQlF9YOJ8iZhDJPJqWrKNpDT/M/QvHqZtRqREiR71ZCC1MCFX96hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708803036; c=relaxed/simple;
	bh=daAYhDSRLWb8+w+p/v4GUG7cuKR+kbyOAJ26/UYyumQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WmLkjmnN2rpLT/o7By3Qy9SHbop5502jpyhTtnl69jF0wqBcDmsGHjDcjcL0DGNtf2hrv7ENENrGkLv7BdltWI7RlnXdSCVct6zagca1cM72+UPRYMNei4U+EYlDyXQsLevfpeyD00I4gkIk11cWY+aS6mYn8SjgTpBwd45cBRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHlAUxTc; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708803034; x=1740339034;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=daAYhDSRLWb8+w+p/v4GUG7cuKR+kbyOAJ26/UYyumQ=;
  b=cHlAUxTcRcAH5i+hSjTrU2BFCwgdIbCchYo5qxRIHZegBrSnlxGhqrOw
   pTx2OEv8xaLu5q7X+zB6OjcrNptfeqRqvh1lx7OCZsbxSJKahMQ9CJh6X
   ilAxKRAgRM8Guk9Di+WsoYElVkX0Gh+eiAdxLhqEDbUFrv8nWsLU6tBMS
   t6b+P6hrC9SrUe5bDDyBBd8pQ64qBI8c+lw4cdps2B2ScWDR2N2sersjX
   mA3zsQv/HA8IOgn2gWVbOCgJrLHuq9YNfDsKNJ1nOje7gNtpMVXPfRIn9
   QbVOJlHQqjTZVLlSCk6rbZI2gKy1vAouF5lgG0OkUYEOJLWTejQErvSpL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="2986753"
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="2986753"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 11:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="6225159"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2024 11:30:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 11:30:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 24 Feb 2024 11:30:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 24 Feb 2024 11:30:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd0Sez7L1VNSMkp7nFYSfrvUMJdrx04lSdQ9EQgxAiwJMnmEDIvN089fva1D6+fl9haE234eYZIk+IkRXbq6ERRxDayblPwmkkSaMos5si9gb1WDNkMlbuC1knwxs2Q+1wSjs/FPC2CcGkX/A46Pm7W5p2hs7xeGQR35FSvt3xzdvHQb23lanZm9VLqWjjRFEs1pq6ZD4nHj2luIaM0hnVW1CkUe5yrQ+6zjfTcTrk6Hknoj9KtEQK1t4PpibuVNDdLK2b4+nK9DHG4K7QdjNQxavDAvEizoT9QCqWxOLC57yHbN75jGW20qeg2vQnsVvGjVjBKxvSkfalt172HZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofVupcdBK0RfBOsKGfkr0d2v4utbav6eTr79JbEEy+w=;
 b=UvmzCnbU/ljXsKXCkhcixChCloVrLAJzMsaccEUXXOghP40tMIC0n7ASxBBbIaGWlGziCRPRJUYEoR0zaYu77+NnSv5qGU5XSPwoYBammtSopuKTJaZ71lWAhTsMEGWxnJy8O/H5LJ9sQ4ETqhEwdg8UQsCEfdMzqQacwXB2RjtX0NtBmdqj9+FbrBPuZh5n3nbqrHdSIyY4VngwYbIKYZhz3Xq6dvvKKdk+wbkyrYD525eiNFL0Ax2ZAw0k9tEy2yGqvJhzQ02jDxCuB02SpMECQZWXbZvrC7TszV6bcR+1PMGInTW0+oFg8475j2lKDQ9sf+HQZmGe93RIaAGXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7059.namprd11.prod.outlook.com (2603:10b6:930:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.21; Sat, 24 Feb
 2024 19:30:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Sat, 24 Feb 2024
 19:30:30 +0000
Date: Sat, 24 Feb 2024 11:30:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <65da43d38df20_2bca029483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
 <20240219124041.00002bda@Huawei.com>
 <65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240223132829.00007741@Huawei.com>
 <65d8eeaaeb302_2509b294f3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65d987b04e98b_2509b294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65d987b04e98b_2509b294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7059:EE_
X-MS-Office365-Filtering-Correlation-Id: 166a488f-fcb5-411e-54c8-08dc356f0fb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9KbvvqOEoBDclUPZDAvSH180VEi0tTOrFQSzIxfZTEgihuCQsfjC4TGjUKIRo+wygw1Q5TLNT/uvt3stV95m/6obJncidJ/iG67BpRiPSFZ9vyCuci6h3H3+OjMoHCdURgJhWAe2J4OZTnqtn01/nxzJtZ6kFROT9sNI+jJGDHTXtoRDUkmOwSW5bIWQwKhPMiqO7Ke+08aznq8sGYuax1r/51gqfILfjk0BsPq462Cj0mwLCCKNz6+qQLYSqUG8aehYqM58tFieQxoo+cRdMB4CcZrtPAMA3gDA8ayClAm0pyGEpqz5YB2Q1UFVGorIzco2vOc0CmN0s7++FOMyNvTDGT67lQSCept6LEFm6tNPE6yFEoiGj0xwb4PbSUwN/hFivvtChjRGP3waCRJk8c4jbN5mUZcg9KywcK1USHigrhl3XihMz8Pfm640mppw9aACncV7XMyACLFyJyeJEhi2OMh7mb7+LuwZZA9BQqBVELt46r/4/z36tNO4z7q9Xrudmn0XdqFRxaQkPml5WS+pWSLKbfHRGEpRv1x6XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YCFsOAbL9OevLj7MGy50T2MOdntMTA6jKaJFBjSGA/stIWZY0FsBLQ1geLX7?=
 =?us-ascii?Q?xRt27AX11EtHYkRf2614nmL7d5koDBW91KsjzGFzAPvAoMQ+jCu94Mj5vU57?=
 =?us-ascii?Q?iXEQxgVPe+jRZ1FaGf0it/OEkybCHDjZ68nucpz9V1pKK+Fc0H5aysiZH+y/?=
 =?us-ascii?Q?K3CT+O2dMqTB9jv75dOh3ixiWnKDxGpHZLoFnE+5AtupqSIPqWVhdkvc39e+?=
 =?us-ascii?Q?M+HXKvpY30/ALq8iYV6kEeK+G1yv0ZlGz0AuoPrbHYUDMP4S4VNYoT5f6P1V?=
 =?us-ascii?Q?d9qu34OOrptSgP5wsNmjS8rEkf9LwcVTKINk0qvNkFgSLI19s7+fJnK42c21?=
 =?us-ascii?Q?ZVpGhE30tlWpPPZLsKt/3XhnNN824P1oy3miMDKphMz7EdkwQGDu0FrJXgzP?=
 =?us-ascii?Q?IgKNHgKp3mUxkLmsutXq8xalL41NZOYVwXThYl2HPgY514Rl3gvRutFx3ogn?=
 =?us-ascii?Q?YZyogE9cLBB9bhTXstIBQ2w5eFfS8ovM4PJEFDiL1gC/1fXWiRBpbHGUZeb+?=
 =?us-ascii?Q?utz03KikDZj5VX12BXoSBjVBkRXnEad5QRp2ATFXu4kRgFGphUpTPNlzCsAx?=
 =?us-ascii?Q?5Gz6mYW7R27fvkG/8+WF9qW8p3RWPFG2W+ZBa2FZqci58NFM3FUCmRhX9/Q9?=
 =?us-ascii?Q?+MXoGXGgXHadWNk5NMvNF5G6/8PRbLD3zktosp0LxBvLFfEqXdaGSp3IaAgY?=
 =?us-ascii?Q?jyJF2QJ0Xjbhs4O0Ii3ZbC91OZUODeMRTax37AmRyx5cZAL4FuEmlEETzNVN?=
 =?us-ascii?Q?8HL9KF+eh2zIvEoM0PoIo1l5SvtakJI5A2iwWIrezNVvkohHs7xQInsjGA36?=
 =?us-ascii?Q?IQL08LX7Jm1Usf7d8pvDuoTYxKNe5HsnIKCK3jArPFfvcaDxvA2TAydgvtUC?=
 =?us-ascii?Q?LAvPi5a5r+rTctFNibli6JceKmgri4m7EYj9NlfbYwYBbl5S7nz84lGajPpQ?=
 =?us-ascii?Q?y4tK2P9ARA4uLfyF9a3++jqpEIHctIBis1/eS9M7FvLpcTCguLhqxBJ7CWER?=
 =?us-ascii?Q?onv6bYrqhG3l6ieI8ZG31bcMCFLMsS4a1Sff51UwUx7QRUBcU0o/fu+4MoSa?=
 =?us-ascii?Q?6saw81eTtDwmRW5K9q/iMcNq4Lt21seMMvbW41Ky1zA6M6MfyuChuuI7Tm4D?=
 =?us-ascii?Q?RYsWUVFr132DLIA5CiUNYaNpsSh2srzK1r1It2gc2EQxIfwwiYsAM123D044?=
 =?us-ascii?Q?f/i/0SWGX/o/95hUxsLyxWfIORlgZYUJSpEHrKSoiCMnQAfNBWtDeqBao6cF?=
 =?us-ascii?Q?Gq3HGIHmG88A8o6+NM/YUY8rTb/S+Hx2Y36OUmAgLSdpXtqymtSzRuIsL/qI?=
 =?us-ascii?Q?AEnKeIL7rS6F+EM/Drhid/Z5ebNnm08PGGxtCKuWtIL5nBeMZ3xUFMgyWNX3?=
 =?us-ascii?Q?sPfrpO3lHakhPZNM+XMYHOsn/VVKYQ9Kt2AY4pqRczTXRsV4R1AeKZ9vem41?=
 =?us-ascii?Q?gP6cejUkr9B8Ww/D4Wo9RztcCN+PMg8pFggOJVA0uUd7M2Iiqw/o8CcI2NMA?=
 =?us-ascii?Q?HnV0Au5eJEfEESBKS0t5P6U1iRK+mQqt/RFIPaL6/zSJ8A02KUXkODZWTwUu?=
 =?us-ascii?Q?G5YYxYQzfpjXIPJOOQRVKmAaXtfDoFea2j5wquYSryspwXdupewE2f3r6h+R?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 166a488f-fcb5-411e-54c8-08dc356f0fb7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 19:30:30.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eV3rL70v/XxxdhfkCUX6KySsDCufKnTCPrsnfjSWgPVQ7xPRbtDiP6rlarSoYxnrocu09/OeuzfNiHGCXMKC7XY9J/PJYtXy7ENP45IaEuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7059
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Dan Williams wrote:
> [..]
> > > This is definitely not nice to read.  We are randomly setting an
> > > apparently unrelated pointer to NULL.  At very least the __free
> > > should operating on cxld then we can use
> 
> So, how about this... I don't hate it:

...and the version that actually compiles, fixed up cxl_root_decoder
declaration and dropped the BUILD_BUG_ON() since it will naturally fail
to compile if more than the supported number of variables is passed to
cond_no_free_ptr():

-- 8< --
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a3e6aafbdcc..5c1dc4adf80d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -316,6 +316,8 @@ static const struct cxl_root_ops acpi_root_ops = {
 	.qos_class = cxl_acpi_qos_class,
 };
 
+DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
+	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			     struct cxl_cfmws_context *ctx)
 {
@@ -323,21 +325,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
 	struct cxl_cxims_context cxims_ctx;
-	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
-	struct resource *res;
 	int rc;
 
 	rc = cxl_acpi_cfmws_verify(dev, cfmws);
-	if (rc) {
-		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
-			cfmws->base_hpa,
-			cfmws->base_hpa + cfmws->window_size - 1);
+	if (rc)
 		return rc;
-	}
 
 	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
@@ -348,29 +344,31 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return -ENOMEM;
 
-	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
-	if (!res->name)
-		goto err_name;
+	const char *name __free(kfree) =
+		kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
+	if (!name)
+		return -ENOMEM;
 
+	res->name = name;
 	res->start = cfmws->base_hpa;
 	res->end = cfmws->base_hpa + cfmws->window_size - 1;
 	res->flags = IORESOURCE_MEM;
 
 	/* add to the local resource tracking to establish a sort order */
 	rc = insert_resource(cxl_res, res);
-	if (rc)
-		goto err_insert;
+	cond_no_free_ptr(rc == 0, return rc, res, name);
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
 		cxl_calc_hb = cxl_hb_modulo;
 	else
 		cxl_calc_hb = cxl_hb_xor;
 
-	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
+	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
+		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
@@ -378,8 +376,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
-		.start = res->start,
-		.end = res->end,
+		.start = cfmws->base_hpa,
+		.end = cfmws->base_hpa + cfmws->window_size - 1,
 	};
 	cxld->interleave_ways = ways;
 	/*
@@ -399,11 +397,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
 						   cxl_parse_cxims, &cxims_ctx);
 			if (rc < 0)
-				goto err_xormap;
+				return rc;
 			if (!cxlrd->platform_data) {
 				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
-				rc = -EINVAL;
-				goto err_xormap;
+				return -EINVAL;
 			}
 		}
 	}
@@ -411,18 +408,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxlrd->qos_class = cfmws->qtg_id;
 
 	rc = cxl_decoder_add(cxld, target_map);
-err_xormap:
 	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(dev, cxld);
-	return rc;
-
-err_insert:
-	kfree(res->name);
-err_name:
-	kfree(res);
-	return -ENOMEM;
+		return rc;
+	return cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
 }
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..8bc044a4a965 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -776,6 +776,11 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
+static inline int cxl_root_decoder_autoremove(struct device *host,
+					      struct cxl_root_decoder *cxlrd)
+{
+	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
+}
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
 /**
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..e156fed88f51 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -77,6 +77,28 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 #define return_ptr(p)	return no_free_ptr(p)
 
+#define __cond_no_free_ptrs(p) ({__auto_type __always_unused __ptr = no_free_ptr(p);})
+#define __cond_no_free_ptrs1(p, ...) __cond_no_free_ptrs(p)
+#define __cond_no_free_ptrs2(p, ...) \
+	__cond_no_free_ptrs(p), __cond_no_free_ptrs1(__VA_ARGS__)
+#define __cond_no_free_ptrs3(p, ...) \
+	__cond_no_free_ptrs(p), __cond_no_free_ptrs2(__VA_ARGS__)
+
+/*
+ * When an object is built up by an amalgamation of multiple allocations
+ * each of those need to be cleaned up on error, but there are occasions
+ * where once the object is registered all of those cleanups can be
+ * cancelled.  cond_no_free_ptr() arranges to call no_free_ptr() on all
+ * its arguments (up to 3) if @condition is true and runs @_fail
+ * otherwise (typically to return and trigger auto-cleanup).
+ */
+#define cond_no_free_ptr(condition, _fail, ...)                           \
+	if (condition) {                                                  \
+		CONCATENATE(__cond_no_free_ptrs, COUNT_ARGS(__VA_ARGS__)) \
+		(__VA_ARGS__);                                            \
+	} else {                                                          \
+		_fail;                                                    \
+	}
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):

