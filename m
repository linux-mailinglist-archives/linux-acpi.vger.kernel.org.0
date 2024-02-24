Return-Path: <linux-acpi+bounces-3928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82C98622DA
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Feb 2024 07:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5FF285767
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Feb 2024 06:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89A14282;
	Sat, 24 Feb 2024 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5efHcyj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1C168BA;
	Sat, 24 Feb 2024 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754874; cv=fail; b=RJVU4b6O7/jG9zpth3THcyWGHdPSullujH9qIXr7LwFCKp+argtjhxplzA/iLIE4DDr4Wd/Yqb3b5bKkQIaIKIWKMPpthlLcv/3UQ+6xJUmaGziewhJTFNswj8elWLJGVOtvStQx0gq/OQpvYlAoG+pa3NoFj9MSPJt31vDuP6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754874; c=relaxed/simple;
	bh=BMQOltmuL+x6bQZMFpkm1LGDn0+n3y8nGA31j43uTH8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s5G4mwC/Fza6WelRW/vbf3vq+BdyiatGqeLfq/bGvwY7M98IJ4G4r8+ByQdDfXPHNXiKZpRSpexgeIlaV6Y/Bw3HXXtfd1nltAdOmsP7C0KEK/Xclkwkj5vyKNjo2eoNMVjHOkV89sMRtFN+6sTSdWoDqQ/Sq0GwOYtbYmifSE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5efHcyj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708754872; x=1740290872;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BMQOltmuL+x6bQZMFpkm1LGDn0+n3y8nGA31j43uTH8=;
  b=b5efHcyj3Y2uQrSDffBZZ4yNThbq4zIhxKf4qbWvosRfa7Q7uGFM4nfb
   t4A/Vv9CItPOQ02mwptBpsfblm4TvN55a5HvBQWmTaQYGGWqvXowG2pZW
   LflV7kwpk/wUndctVT8vF4lhuOAzk5xvu2EtA6yNGD5klDvELmutR0H/z
   ytWquYlcP+KwpQwJx0Zyl+2h6H14QnPzN+sPpczMakPRNfOA3Rc+DtHKt
   Yv6ejUzsRuy+MsS7POlQ5zxkPcB0u8YfB235I/wLyQzgrlPd9gRhVMLAj
   xGSKkMItTbvqefUMaMchHamwoCcYfLrnjnpEI6k2XiPH5UoC5NTK1iauq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20538515"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="20538515"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 22:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="6356265"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 22:07:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 22:07:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 22:07:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 22:07:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 22:07:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIzGbh2j5zuWYE4I6S3pUs1zRnN9rzr9S673hIt+Dfbm07WVA3/laNijjbLNqcBTP8qkHQjgCXLSzjg005hc/PWerT6mVCSdtar2A4O52aePtuXpZoBIqAKEZHuR4mP1QM2kmDvykIVwUzbi02ihoEytOg9Nwc3qmy8jo8yUbBtzZYqhe4wgJOtQKYKdVtFUNbEbdc+6xvaOFpu/Uud+wIS9ZQQuajNrn+L524qLYXCreHW3+UvCpJLw4PiCI7G9XDe1FTo8yGIrIMJjXhZGQJindeaUmvuZc3uGEtZL/pyUB2UTOXgynfSkTbPTiBbYYYA6SoSJskkyRVD2h/aLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2qz6gg/Ol1WXeipfpvPu0/DQdK4r1pGGpgljUF8IJA=;
 b=YvuJoOYs6Qw9QBoxdRDE8SZmYwOmohnyffpcIHsR2IHlSFOjgIdG+BuPTbhJhCzndbdhVy8ejVBvi1vKp61Bc27CsZl9DB+hLmPCInE2jKlvmBKO1qWmUF1gS44XauVloUq4Y3y6fXpc2EysLW2rtWdj8I8Cu8XhgGERHp/T/mUTbQKxongQlNYY1ZOCA5ejZU3n8FnlzO62xtCqXTAdMi7DxXVFThf9/bi1P/lnPC+/cX5WKwQDmLxiHo4ZO7pxA0XKeXHw4hse6P7lavh3tDobaKOUzibqneBc9IZ1WJsoZNDRTpJz7IM9u4sBTgc8V5YyJZ2vFtFJI0+5eCn4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5494.namprd11.prod.outlook.com (2603:10b6:208:31d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Sat, 24 Feb
 2024 06:07:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Sat, 24 Feb 2024
 06:07:46 +0000
Date: Fri, 23 Feb 2024 22:07:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <65d987b04e98b_2509b294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
 <20240219124041.00002bda@Huawei.com>
 <65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240223132829.00007741@Huawei.com>
 <65d8eeaaeb302_2509b294f3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65d8eeaaeb302_2509b294f3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5494:EE_
X-MS-Office365-Filtering-Correlation-Id: f78765b3-3771-4098-e1b1-08dc34feebd6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmtHQVB4jIpIDPhT2slqwEkJPhk4psqbwIlH9onn5eJGESAW1ai6O5WK/Ig/X5rjldh9I5fyWUe2ZR2AQABaZHdIZzECpdiLnNEe8RV9sVdCLvlW+5KBOfj9Zuvg4lBfBn3S0NhqwoDkknAE/TF0ogINvFUUwaIZkjznIShBn6hL+l7I/7sq5VcHL4ml6eOsutAxSh6qjuIF5tdCxQHnN015/keUP8u8KW8VNDkn8W/S9v6h2dBox7V3612YiOhCFtvlU1IQIlLp00+U59FbVNj0byi8uqZjlJ5buZz0rFYDGao8ZdHiRxStPAfO7pcS2KVelIDIrquHUIxtEGFLJaZKl0amokSns1hXoehSRLahdpGOV8mYypLweP4//rPFo8z38hibleb9iqceiImm8E6olPjicuRht35YHfCesbsvreAbyGWODhri/tf2Wbv/7lC0KWo1YpMwecZ4FJSpb/ZA9pU9kyra4xpbM8RZVv8w4Ht1tU9Rk9shAhW8ehRiyispupRz8uS0qQszDiE9omNvN6HGzFbikCCoKRNYAxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFeFQYPY9WokBmPRRYYCg+VM9dD7m15snZ/qDR2oz6VJLmSgyc94Elz+0Hco?=
 =?us-ascii?Q?A0X5PlP3IS//L3oAnh9S+h8GA3pbLeW262zb85QCM2CqqgSAzXgxCXbV0/bh?=
 =?us-ascii?Q?u0yiKMRLiw59jsD4JJH29L3QhlVIeV8a0RB3PJd2vfoszGgVXQtnR0YCTTgb?=
 =?us-ascii?Q?wm77SZdQTH1c1pFo7iBZR12PmMQO4dHBUKA4V083M55YqP4u2s1ZNfsYkcP+?=
 =?us-ascii?Q?/1betvPs9MCvMdfEc1uWVApJIDk5kfmxxRYs+pzzzrSd4JdZYBz9n92ERywy?=
 =?us-ascii?Q?5URO7i8qI14o1qUE0U7buFk/+zvMAj843NuRf80krQA189GGPSTmIALsN0Pu?=
 =?us-ascii?Q?q6p3KGZB0KRRasmTfKqX3rVAf/Fe7tJmtnEGJ1K6DAFUB2GttvJ/8t35NjH7?=
 =?us-ascii?Q?SQX4uUPXSAUFL53L6LB+zNkYTupDhKbOW/YYul2P8MC6G3WmnDOi8q+so5Ay?=
 =?us-ascii?Q?Sloh+FMNt1GlPehbDclIBiNvQXlzkzzQxPrVHosG1p4T0vQAfpmV4fbI4/AH?=
 =?us-ascii?Q?o3a30m2atMDHfmZOre7NteP9hTpBHEopR1Bhg5Piwg2u/dutsGSBSLQtczSa?=
 =?us-ascii?Q?BKvZ11m+unIRhbjCGnv4sYFyUk3pYIn8Ss9y0q4+ApNAR2ujYJZPFTNYWsFq?=
 =?us-ascii?Q?n3D6nGljEoPDbuWaVPr6cDt+nAyh7U0aD7FhIC9lzzShJtNMIpfsQJp16w55?=
 =?us-ascii?Q?gNU/QyE6uNYEcR6wpjQsitxie/ZUKMREMKLN9TuFbH4bDdqtuBCvuNLleDGt?=
 =?us-ascii?Q?NB+QoLCCshOGe7lNKaNxpqwG/1eBqSi4WJQ+srhOUZMaDLXLYhuqZzyioeg/?=
 =?us-ascii?Q?DF08TO6XBqUqHInKGbWuIrIXFZiQCu/U5F1IpeWdf+PW8/aT5+jv+gSV+XvV?=
 =?us-ascii?Q?SDm2JHFp9R30fU89aqkzbtLQY+hY6STNPydzAAGAR3s+yuQJg8uY0Zyois+Z?=
 =?us-ascii?Q?I2AFY5MrKGZIizeJVl8wSWA/0OPJMugvepd/XStFg3U2DYt9YGUdAtWZ1AtW?=
 =?us-ascii?Q?w7FoKdYYKa6h3zenrSDMqL3rIpbrmiDV0tkRssD67kd5gjZBq3OWiadRa41H?=
 =?us-ascii?Q?vRu2pImRTz81Xp65UIbhzs9lUxq5oGWOHJaev7ysIFjeaSZlOx8Udj/ea0z1?=
 =?us-ascii?Q?O2vEyEq3rheWrkcQxjxTHnQrzKaVPhzgkGl7fE7wU79/Ip9RCmi+ktvFE/o5?=
 =?us-ascii?Q?dV60QAf5Nu1xdhC3/XZXT9d8mxuXPmO3/HymcO1YRgwX10ZHz2wIKscbm943?=
 =?us-ascii?Q?+iXDRSqsKuNRkKAEJMYggW96UpeLZYmckDFjvVfEVTvXWx4yFb3noWWG6BoE?=
 =?us-ascii?Q?UFdCLj74DKBVzQZQAJCraFVEQ2/lBtGhlpcN/Ju0fqyc16loegzoTlynylsA?=
 =?us-ascii?Q?3zvhaav+md1KATz/pR+PuJsco/uCJFlFziBVQmrICE5U18M9HlXf0J7Ms7n3?=
 =?us-ascii?Q?du1TQaDO8264W08Ze3Gch5azZKdJOw8YlVydoVk5U5LNNhihWCvB9A8uMFtJ?=
 =?us-ascii?Q?tXHdnCUHo3+pDa2Jh9uYO0jW2ifCYXC40IqlwUTXUGq3XYHGmIIGZfqiZjiT?=
 =?us-ascii?Q?dWYRmQiqXWQ75no1CUiTsePMu52QNUAu0/1noEQ5jmsd5LgdKExjkmBqP/O8?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f78765b3-3771-4098-e1b1-08dc34feebd6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 06:07:46.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQzN6PJBe/CL1V6BFv7m/C8vFpjlpOgdAuBlpgWlHP6WoHwV2hkyGtPu4rjexvHGqh4PHmFocxei8LCDZbrB6yIZy2ugRf/XOrYZNFUZ2TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5494
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> > This is definitely not nice to read.  We are randomly setting an
> > apparently unrelated pointer to NULL.  At very least the __free
> > should operating on cxld then we can use

So, how about this... I don't hate it:

-- 8< --
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a3e6aafbdcc..94ff38960f99 100644
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
@@ -328,16 +330,11 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
@@ -348,29 +345,31 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
+	struct cxl_root_decocder *cxlrd __free(put_cxlrd) =
+		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
@@ -378,8 +377,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
@@ -399,11 +398,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
@@ -411,18 +409,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
index c2d09bc4f976..9bf242e22191 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -77,6 +77,29 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 #define return_ptr(p)	return no_free_ptr(p)
 
+#define __cond_no_free_ptrs(p) ({__auto_type __always_unused __ptr = no_free_ptr(p);})
+#define __cond_no_free_ptrs1(p, ...) __cond_no_free_ptrs(p)
+#define __cond_no_free_ptrs2(p, ...) \
+	__cond_no_free_ptrs(p), __cond_no_free_ptrs1(__VA_ARGS__)
+#define __cond_no_free_ptrs3(p, ...) \
+	__cond_no_free_ptrs(p), __cond_no_free_ptrs2(__VA_ARGS__)
+
+/* 
+ * When an object is built up by an amalgamation of multiple
+ * allocations each of those need to be cleaned up on error, but once
+ * the object is registered all of those cleanups can be cancelled.
+ * cond_no_free_ptr() arranges to call no_free_ptr() on all its
+ * arguments (up to 3) if @condition is true and runs @_fail otherwise
+ * (typically to return and trigger auto-cleanup).
+ */
+#define cond_no_free_ptr(condition, _fail, ...)                           \
+	if (condition) {                                                  \
+		CONCATENATE(__cond_no_free_ptrs, COUNT_ARGS(__VA_ARGS__)) \
+		(__VA_ARGS__);                                            \
+		BUILD_BUG_ON(COUNT_ARGS(__VA_ARGS__) > 3);                \
+	} else {                                                          \
+		_fail;                                                    \
+	}
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):

