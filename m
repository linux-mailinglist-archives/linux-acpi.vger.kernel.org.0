Return-Path: <linux-acpi+bounces-8613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A239952A5
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DE71C21680
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711C1DFE27;
	Tue,  8 Oct 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hN+6WSCE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E51DE2A2;
	Tue,  8 Oct 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399533; cv=fail; b=alHwIgkh8GgaAcm9lG0QJtjNB1HpOu1JX3BGKt/aeiRlCRw+XWKD3V+mVEsByE494n4jsp7kCGuCzbr74fwna3vvL+gDi3lO4cxFyR6nqm/kEONrJQA31xvJ5U1UR/0rH5WXjAkKSKUbyDJUHOxj6/xvZ4uw6+Pb4uJWM5KAuIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399533; c=relaxed/simple;
	bh=zKvvGQrBWu63d0PZymISPFcoA7FBqD9dlsnVoY1naV0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=By8RV9NU0/rGN5KWe7fwlYFF3khcADauu7scV32+o1BKhdxe/fVSQSNo0dQAXdcJ4IdotDehl07xGZiT1UCqzCo2zhGatMOC54eLge3m9QJ9udy38J9uuDNL60yWK5ue2TqWAfH5+C4PDOTCi7/gdaSOFEcNVlvodkilvkmhG5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hN+6WSCE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728399532; x=1759935532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zKvvGQrBWu63d0PZymISPFcoA7FBqD9dlsnVoY1naV0=;
  b=hN+6WSCE8gVBlvcJVMnm9I5ECv7UYGTJveGh+qO3lL+X2taptc5G7Rfy
   puptsC0fVvM7myh5xvm2vVIphPAZGttdkNkMOjBZ1F0uihd+WQEhebkzt
   IPQ0ypgbAVvc2ASUS5qUy01glAY5oayo5jNIglqHfEm8JdgKI/RsLV64F
   9jcR8/kYx43p/nYbDuVE5McnDQNZbESv1pIdVlpjbfh+ci5HalTmDlKXr
   XwjhylBZI1HaCKBCY6HpfMQXpq18XYud0cf4nGGjRsGa0HrS/ZRhBKzhn
   CkP+lkMU9c5tiHwm5mEdJYWsUV5NiR5sOaNR3p459Y+wqZVYJBwOKBcyg
   Q==;
X-CSE-ConnectionGUID: jCpfdySMQ9264lPDjYkBZw==
X-CSE-MsgGUID: OfwTWADhRBaJwnwJPYiGXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27722789"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27722789"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 07:58:47 -0700
X-CSE-ConnectionGUID: oNR3Dcn9RPSFxXKZ+pVR2w==
X-CSE-MsgGUID: K4rlAb0WSsyuy8xoPjyAIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75733219"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 07:58:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 07:58:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 07:58:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 07:58:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 07:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2BknTzTgBgdyIElcHI+9SxS3raLoS0DwiS8y7U23G3B1mT6UlQQmLxUjcOuH2bYXueHmq8UHjN8d3iFVYx/GT2cU5Yi68uuMdNIyjQvq3HJFujkv66PJDwkaM4irf7XE6miDyE0FREic/kvV4kssqtiBKHlpMhHNvQMJrZfK6ChR1wgnaDD24pMwnAFuAQ7W62Rcatve17oolP/n7Xs1vfUtmQzBBfGYqfuxj7OFbh+ROwZNpgJONa0BA45PkG60syyH0wYddVNQ+f34mpFMW7skwydaRxBC3mo3zT3nQK+SxBxVOx1do6RaPTT/9V37vxXT7dRBXAaYubPQI+Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDVEi7RPeqjN41aHMmPY+oXOkXm0JH9izotJJ8ILPio=;
 b=RxUnMRSwEH+wgQxjY2X6NeZgUatb8tcrHkTkwP4HjSmLx3/rx3HBVGLd1QO8E2WkKbGYylm6ZoyYi95Q1jkE6TowK2Z93bTxo27cirNhSHYTlJNuzVO73SDdSZudNXNb7d3i7HOteuXZVwYs+4rqmAjCRFSRvvEO8xi0ZfL/52uMwjuSWKIFi9xzGMunTkOV01KsHfkKOQNg4Rqeq4qSrL+X1ufJLM87Ps9C7OzrUaqTir0fqX4kA4xw6AoroEOvpXbgU5r5VWxKVTg1uJT87DVq0edcs0eNH8jZ6nYubcXYbt8kA5ZvCP5ol33cvFD0T6lJN+LFBXWPlPAUNyOfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8491.namprd11.prod.outlook.com (2603:10b6:806:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 14:58:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 14:58:42 +0000
Date: Tue, 8 Oct 2024 09:58:35 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>,
	<x86@kernel.org>, <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>, <david@redhat.com>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>, <lenb@kernel.org>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] acpi,srat: reduce memory block size if CFMWS has a
 smaller alignment
Message-ID: <6705489bdc79b_125a729415@iweiny-mobl.notmuch>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-4-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008044355.4325-4-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:303:8c::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: c02d05b0-230a-49c2-f0d7-08dce7a9b31c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?30GFId6fRShqaN1k5MCiVWVwZxWlkJugU6G5le3LvFVywBh+K1vos/ndWdKw?=
 =?us-ascii?Q?Tl2eXbUCf9GTMjdX5/Vl1lALb8yF+lpJ98rWXfeCiDv7alz3RJqLa+uG+2Iy?=
 =?us-ascii?Q?4gsDCE38HBWovgtHoSQkjA82pNbSXxJzdTUuJHRfUhK0ufgpquRB0VakQ08S?=
 =?us-ascii?Q?sexjARsOkZslOjqGf6u7+Oz49nLiuy+ldNcX/y9DtfJIl7i2oyIpGj+Rs/Mo?=
 =?us-ascii?Q?FjStzrXs5yqfZlcoOWevilafnBVZVPMbAqyNJSD2tDIJj8Frg+HTFAp3sc4l?=
 =?us-ascii?Q?Ke/nEKEunjoDD0NBVo0+A3ahukO6ZvnPPOCYutgqAX+guU69U51/jU0t+7XH?=
 =?us-ascii?Q?pn8tZmwnxlD2wH9HMeFinrZ6buAOj6DS/drSI3tOe6VUiG9RiC2vJKgh/Y62?=
 =?us-ascii?Q?STMmu2y16eu0+ey10QkcTyqYQnRr5wgE+EU6tBGlAgYSTYWWOjYsz3QUaMqz?=
 =?us-ascii?Q?+0DJk7WIrEVx7WoPkZ4nXllcXoEPN5wHyo7OqHj399GKIl0PJXpaqzY/mEHo?=
 =?us-ascii?Q?7xLw49ZE67yg70MkT1UbfTapJce3q6757XBfDaWtM24AkwtrLnxvEeSdxjv6?=
 =?us-ascii?Q?EYytsowMwauzV0QpNUlYNp7jGpf8Pedp3rP7mZGzaNCSep7+rBx4kEPJPTHt?=
 =?us-ascii?Q?aHgDChtUR3JKIyxAg3udWBgLDpgEIabm3zb9UOLWHenMoTrZcw5xGTX4IxD4?=
 =?us-ascii?Q?pk1xqsABUaBZfxHuc5krHdVpaFdPkC5j3R+Dts8VA4K7eV/q7Gb2MuT9MtJl?=
 =?us-ascii?Q?ZrXi5TyBHPx2b2zoSAc6F/FttPvsDO2OWq5QauzgIyAa8yj5Gs9hIeQaIAKT?=
 =?us-ascii?Q?lI9ufoeiCdHF1s8J5Z9WE8SstEZvAxpaPr4EApJInvOvCEyzKn8d7zo5PYCH?=
 =?us-ascii?Q?JEhkw+FRP3QuZThJVyVl+YQbpCP88NED6IxAjLk4LF+PNLIpqHEOWrAB1Jd7?=
 =?us-ascii?Q?zpi+T+UOmgbjHe1Hjss1Vv+gTZEqBNsHJTzkCT9Qw6wo+lXoMsFLSHBIU4ld?=
 =?us-ascii?Q?SXLBsLUwhMiW9UkqNx0ME0alY+gA8Khak7fr7DnzfRGyWr0cxToWqxI1p9mo?=
 =?us-ascii?Q?znQVoCsM9WieARUBUN0Ykjle/EmfhEIsrQtU24wtNg1BZAqye6NVszkdUAh3?=
 =?us-ascii?Q?yLJVIqbMf0elYFSsficDUd2XjtUq6tmPiYA8Ek176w6XP/L/MUtJ/0Y5GyFV?=
 =?us-ascii?Q?OwYIw9lMAmje5PFG1jrvsK2iCMkwSXfRt5BwGRwls2PdRd0bfOBc8L/Ts8n7?=
 =?us-ascii?Q?EKU5jcJftSxuJTJ3TzJjZeYiyRupr/BOXhhJLcWKUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EbTahfJb99uwNjMTBDAexhoy80llZx69r9KXKcWP2CxO+3QCxGKOsoTG1LCV?=
 =?us-ascii?Q?l01UMOQGsJrt1ezMp7clPBIE8JkjulzcIjxtxHFOXL6BDe6SmbeRU8NbsbwE?=
 =?us-ascii?Q?N1n2tc6qvauc2bioLW9Xle2BQ18N8xeH33fdd3obmGXEPZ3HfZ9MeJOtNLRf?=
 =?us-ascii?Q?xOSetf6H1AJELSaNE45lfDa6uPtIXzoH1dKO86LpdRenab/KULtgU9hTpPuh?=
 =?us-ascii?Q?YZxlkt+xFWb6TFYyh5uKrxpXv/u6yVlDGQfaiKS0ec+OWpOSqrFnArqF8667?=
 =?us-ascii?Q?EFCo9E/L2nba89w70pmqjdtkkJI8MNHs2Xm18CzIhoLwe0LtNjnkn/VooEvp?=
 =?us-ascii?Q?CsPspgm4axLbSoOPEzhi7pq4ddruz5iV8f4ZKBV53o/4OhFcCFUjk8o+5X5H?=
 =?us-ascii?Q?JtPYRGmRTAwP+mhjj0NkPmqPlo2/JiId7fBAdIA82DXbCezPBvzv4tlIKRYM?=
 =?us-ascii?Q?1gjOkx5kMBTO9ButJKKDHKVgg2M5pCyN7Ks6upOgbZJNYOmt3uMoSwvrGPaF?=
 =?us-ascii?Q?XhDs5mEsR5pDnHFMC68Bnh4h9RNfOpUUbTR8z46dA1gJJ0N92JQyQgDoAm+k?=
 =?us-ascii?Q?qsQMzRtHfPsrvbndHno6t00rAhAgRejZwtTYQZJFYHZnDWEmww4P9q6OWo2Z?=
 =?us-ascii?Q?mdcwrQnxouBKAHztZsu6lXr1o8m+V8PI8Db006gdElOosqU5RvFOS/SDaxvU?=
 =?us-ascii?Q?XKo21SMj2HEmc6eIBltcqpwI253nnBFN0uG8JFBejJNtpghaYCSs0tF2ix91?=
 =?us-ascii?Q?f42B2zR0ovYy3gPNTnHKpKDbI405illCHNnjh7VR/akLv1tNogYYnWpmrvV5?=
 =?us-ascii?Q?SjoXRzqhXYogq7mJMhKjL2jfNwvdus/m7HPM8kJjNDceq06JvNRY5zhVIUeP?=
 =?us-ascii?Q?Cdaogzs0K9Ppj26Af4qzYE2Zz6Dgir/Xy12AmpPSh5zvguP7FWVCxAl1CHaS?=
 =?us-ascii?Q?vE0DWS/9KNl1jzOgqmvvyj4TiYXA4vPn2GtR1KKCJXjHceiE4PCgorQ/Q5Ju?=
 =?us-ascii?Q?qdFYnAHx2sbv6ZibUw0DM8vWCGsqUEUhrOHbwaOt7K0/zaX9t+gYX39s3OXl?=
 =?us-ascii?Q?6HBCnaU2PdPZTiMISlZjlH9gkrgZsxO9xeq2wkb7dbZh9/qUT740gimre+iT?=
 =?us-ascii?Q?xUEhuL6wTpkPAAT+mB+AS1q4KRKpKLO4k4WEC1vumitE6UgJuZomZMWOH1/r?=
 =?us-ascii?Q?aU03NQHvubdYj4+DnhzQ+ioTV4kzVCQaBRIXoJBx2IT7aYVsxHnrwM7YLtin?=
 =?us-ascii?Q?hF76/MPcy+ltdBqAXTUH2fXJXYMsxPZaGZh7QGwRdXLRZoCxYy4QbVaGE62C?=
 =?us-ascii?Q?Ymawsw84apILmFUnzw9FD21ZJ4VcJlvTULSAFBnpldJPx9GXLza04MMsW8A1?=
 =?us-ascii?Q?R5o1/6SyBeD9KyIW0AzYI0SrPPegdHneVVu10V+L4q6p2oLZGBiX6r0Rt7/O?=
 =?us-ascii?Q?QYwiyJK1WMrXszUvDN8qPa1kpBxzuORi8CrJcuZZYtizR3KTr/OYEeyKFbJo?=
 =?us-ascii?Q?b4uy2upVc0QUyfwrJ248G2/h8AgMn/eIEV3Nb5TDGpU7Uj00Rexjxg3MMSS6?=
 =?us-ascii?Q?JtXY2Wtk4IS5JJODvc0yhg6vB1KAJkOt3dc/IKab?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c02d05b0-230a-49c2-f0d7-08dce7a9b31c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 14:58:42.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hALBjgLi1QhFau0myvvdUKNH+dqgiU38ioERUkDwA+JYJXXltfZnbdRpWIlONEPrfepfiAMeb15ji2Dk/skCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8491
X-OriginatorOrg: intel.com

Gregory Price wrote:
> The CXL Fixed Memory Window allows for memory aligned down to the
> size of 256MB.  However, by default on x86, memory blocks increase
> in size as total System RAM capacity increases. On x86, this caps
> out at 2G when 64GB of System RAM is reached.
> 
> When the CFMWS regions are not aligned to memory block size, this
> results in lost capacity on either side of the alignment.
> 
> Parse all CFMWS to detect the largest common denomenator among all
> regions, and reduce the block size accordingly.
> 
> This can only be done when MEMORY_HOTPLUG and SPARSEMEM configs are
> enabled, but the surrounding code may not necessarily require these
> configs, so build accordingly.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/acpi/numa/srat.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 44f91f2c6c5d..9367d36eba9a 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/acpi.h>
>  #include <linux/memblock.h>
> +#include <linux/memory.h>
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> @@ -333,6 +334,37 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> +#if defined(CONFIG_MEMORY_HOTPLUG)

Generally we avoid config defines in *.c files...  See more below.

> +/*
> + * CXL allows CFMW to be aligned along 256MB boundaries, but large memory
> + * systems default to larger alignments (2GB on x86). Misalignments can
> + * cause some capacity to become unreachable. Calculate the largest supported
> + * alignment for all CFMW to maximize the amount of mappable capacity.
> + */
> +static int __init acpi_align_cfmws(union acpi_subtable_headers *header,
> +				   void *arg, const unsigned long table_end)
> +{
> +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> +	u64 start = cfmws->base_hpa;
> +	u64 size = cfmws->window_size;
> +	unsigned long *fin_bz = arg;
> +	unsigned long bz;
> +
> +	for (bz = SZ_64T; bz >= SZ_256M; bz >>= 1) {
> +		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
> +			break;
> +	}
> +
> +	/* Only adjust downward, we never want to increase block size */
> +	if (bz < *fin_bz && bz >= SZ_256M)
> +		*fin_bz = bz;
> +	else if (bz < SZ_256M)
> +		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
> +
> +	return 0;
> +}
> +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> +
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -501,6 +533,10 @@ acpi_table_parse_srat(enum acpi_srat_type id,
>  int __init acpi_numa_init(void)
>  {
>  	int i, fake_pxm, cnt = 0;
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +	unsigned long block_sz = memory_block_size_bytes();

To help address David's comment as well;

Is there a way to scan all the alignments of the windows and pass the
desired alignment to the arch in a new call and have the arch determine if
changing the order is ok?

Also the call to the arch would be a noop for !CONFIG_MEMORY_HOTPLUG which
cleans up this function WRT CONFIG_MEMORY_HOTPLUG.

Ira

> +	unsigned long cfmw_align = block_sz;
> +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
>  
>  	if (acpi_disabled)
>  		return -EINVAL;
> @@ -552,6 +588,18 @@ int __init acpi_numa_init(void)
>  	}
>  	last_real_pxm = fake_pxm;
>  	fake_pxm++;
> +
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +	/* Calculate and set largest supported memory block size alignment */
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws,
> +			      &cfmw_align);
> +	if (cfmw_align < block_sz && cfmw_align >= SZ_256M) {
> +		if (set_memory_block_size_order(ffs(cfmw_align)-1))
> +			pr_warn("CFMWS: Unable to adjust memory block size\n");
> +	}
> +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> +
> +	/* Then parse and fill the numa nodes with the described memory */
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
>  			      &fake_pxm);
>  
> -- 
> 2.43.0
> 
> 



