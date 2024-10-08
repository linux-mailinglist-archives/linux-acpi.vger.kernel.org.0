Return-Path: <linux-acpi+bounces-8610-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B7995208
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30531C204AB
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E21DFE15;
	Tue,  8 Oct 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGiZ3LZm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC901DF998;
	Tue,  8 Oct 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398333; cv=fail; b=sSKXr1m4Uo5uc56FxCVFyxPuU2WHsk6g3uWQakULr6Kzl8oEjzJg+lruUMxG/+StanTLvdfkvDjR6KizeSA0Wq+Q6X/0TPC0wN/AJAdwYFeBHU/eXADLS/8uoMKJHHfxutdkKBOWSrS73vOmvXfwOAT0qiX/XMvrh+gUPEdxoPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398333; c=relaxed/simple;
	bh=LOHZttBHAacEXuoRHlGDe1WQJmrg1OdO45QcjAy2OLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FBIivQ/VlXt9hm4THZZGDnsnoJwqeZisbGNv2trURDly4LoG0xXvkwowi64ogZPY2b/KnI6B9Mj64G0+kjjNifa/sT5Uo5wbgB6y6UzIpHlSRgXDC5JGhMz3DQVhuFHMGFTkM8VrCaLJGrXmpdseGV7+IfInYDWaB595Cvje2vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGiZ3LZm; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728398331; x=1759934331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LOHZttBHAacEXuoRHlGDe1WQJmrg1OdO45QcjAy2OLM=;
  b=SGiZ3LZmpMLtqWKjxoXwKO231NSzWFcf7Dx9xdCeZKCPVh5APwqp1m3c
   xXojQ3sQDDVkeJW5TUgxXXt4MhVZFp9t+DUDaK3ivc7SgsHz6SK4/hYLO
   RFWiwjhcx8+va4j3+0BCL79EZ6GNUY3pLu2Os6ReUlMWssgMsx765b9YZ
   bUMF/f4z4AZRqIHdIH7YEjJ/97CtMoqzAp3LCdqOWgsK59GIaOkDWxJEz
   K32hYYBxEofn24w83vZkzYPzbLNh6pItY0+OwXA8v7mPHtFGHBPjVbmix
   QFxn87ijWn3Ip1/fd1Pwiq0Q7IMPzWfeaeUv1p8zqS+lzr7vLHHd/2ApC
   w==;
X-CSE-ConnectionGUID: mh4kzk6KQnCuYgvY+/w8lQ==
X-CSE-MsgGUID: 9P7bx9JMSoCbBMdI7c6gqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27759761"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27759761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 07:38:51 -0700
X-CSE-ConnectionGUID: ec12kozQR3+UrX2LG+xdcw==
X-CSE-MsgGUID: 907psh1OQsOaId+pNoikzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75958898"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 07:38:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 07:38:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 07:38:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 07:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV9yK4HBZBuAdYI045g2jMUCqEaA9uJ3RfogfmyaseVBHjR3vD033gr8IbmX6kBOM33sSrURrh4M5j8Sg8xZKioJilXKJFdqhp7Ia5sDJT65xOn9VTsA+TTRDaT57ac7nowMrW8Pdj5KY678MLgNUnuu/26Q0K5Eq7W5j7gjvB6yC357ZxbjxL+ZdAQQ8tPLbGRXvbH3lFVwSycUZmCyZuL3z5frljxOSnvpPeE17cpZ+uamAm4P/zeeDuiA99yOLuvZmGTRrZOJqUeSwQM89hP+JiGbr/vixKSqB0RC9gDT1pw2jtJzMSPXLNI0cV1NUqtHJCpBsTSIqQOFTfhD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUFz2tj9xs4C86Z1aryTCA77Jan+8omK7hM7HLmqRcw=;
 b=sdyn5NQ0su/0ZMqlfIPRJEJ9KA93iHEQix0YuNqrSXkAeHupm+NVf4s2Dsg7NhcWjtkrZ/YcRRH4rmZgdXXv2JTxKgxNx8lDDzYyAHlWGRrC+lgZnJV/ihlVcm4PWF53cLy5jglzC4HlrsVzeoNOV50ucLURh8T6SkNCQVx344YCq2U45wPcwlGpUhhl0dtp7uOcob5VoYgen/Xa14DcWkpoEjWZX0Iw/Rv1N+5DrmTNdLsm3pSIMpiEdf+LwtFkRLnSqmtm/J3hvFA1bZ+t9JtF9Arn3oVxP0CethmDkz6XrB10rCBUrZ5VhcMT2GbTnrxyjRW51JICiKrzfVwUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 14:38:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 14:38:41 +0000
Date: Tue, 8 Oct 2024 09:38:35 -0500
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
Subject: Re: [PATCH 0/3] memory,acpi: resize memory blocks based on CFMW
 alignment
Message-ID: <670543eae94d9_125a7294bd@iweiny-mobl.notmuch>
References: <20241008044355.4325-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008044355.4325-1-gourry@gourry.net>
X-ClientProxiedBy: MW4PR04CA0323.namprd04.prod.outlook.com
 (2603:10b6:303:82::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: e6226d66-f2d8-4941-3f37-08dce7a6e72d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?38ckod7cVGg6RWq+4579dcC/r54TsZ+qNaprZbC9eVDmVPIfy/YZ1CI5QWvi?=
 =?us-ascii?Q?VZACu8chCgCYiyyaUayCgWL+csRLs5ynJJ7HBDv53J1PoS9FNHRMVgvF3jed?=
 =?us-ascii?Q?0UKunlf3X7TJyVxofrY63mPBH1DeENxonFRDv8JXiUhWWZokw+ycdKSDmo+d?=
 =?us-ascii?Q?16s+j51WhqecFXoHvKagmdj02utvDChVHY6mNYw0oNdu0PgoxvWDImxlBeiu?=
 =?us-ascii?Q?7O13CO0aOd0wB1gZRb7LEb1funPXhFz2LaygAIryzb7hno2vVfGDFev/u6nc?=
 =?us-ascii?Q?L5DQKkCnjBFDX/dwSduc5Uv/9Mta2oKTjJj6FZaWMUAe3/P4UxoVl6btE4v5?=
 =?us-ascii?Q?98eprBiSPvz7zs2tpwLpgEIpKPEMYfK3udiccTKoYYzYnv4WGswDhgScHDEN?=
 =?us-ascii?Q?CJLaO/DzVZ6PyHffk0szjbSk9c+2un+AJLjNeSoBbsEZ9FMxoeEJVUMIHRM1?=
 =?us-ascii?Q?OtpWgpkDUfG5lTskVYHDVT1U0xFbeypgz8OQbkwzKk0kdklwxL04NQfCEFV2?=
 =?us-ascii?Q?0HbKAtN+i2iV6oHzOvF020C92MUw28xMkgkIySeXHP9pT72H3TW5J6dTpWCh?=
 =?us-ascii?Q?khOL7ic8IiRAEWuWUz709wRFyFpjZyyDtPV0MK62PETVePkPiqvs9sZplQoH?=
 =?us-ascii?Q?OVP7dWwpVSdJP8p5v1Fs+zo+CHVZZInfUks0cjMWKBBeKRPWK6CViX9vjMNh?=
 =?us-ascii?Q?3s5Px5b6kUxy1eLBEVl6VsRmmFo/sh/4lbbFLjV8oWZCBS+cYBnGIuVwNE67?=
 =?us-ascii?Q?kyCVADjNnsn1P6S06/nqE4BFAKsvXyO13akYTAZ6CMwfiLK38DgiV5P9TFB8?=
 =?us-ascii?Q?2e3nLkaEnH4BKmzLJF0rIzUUCdJCMqpAuFHSKp24Cqmn71DLz5j4qmFpS45Q?=
 =?us-ascii?Q?ue+SMrKwt9D4fRJauBxSULvVM1GbwFB+9lVVoZu2ZskabeiKbY6C8FBYpeJJ?=
 =?us-ascii?Q?pRQ8CdrJX8hdIAceDnC2Clh0pjb4zmdML6lO+0hjxGeh/tlZJfsYRQ5f8Yjx?=
 =?us-ascii?Q?Md4e67Cfmbs1JL86YypXmITG1ohIopC7gbg59DjRrYJCU0savYXYfA7UFdHe?=
 =?us-ascii?Q?o3+Jde2Dm8qmD9CcwywqzJWKMCQX1Jfk60GDzQk5oNwPUM7vKFy945j8I6+E?=
 =?us-ascii?Q?kZ2zBwNG3ub0KeR8KdrLa0TI1QvXO3WIM+nphNql62DnZ/YlgtBvC/8U1dsI?=
 =?us-ascii?Q?ssPQlU0ShugyLaCIELMK3x926Xg+sAURgxfTMBcDd/XQxWjoQbcm1jq8+e5t?=
 =?us-ascii?Q?9mTzjm1zaKdfRhN0eVsMuCgZAIHeKNQ/P6JiyF6atg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SAagpiSaLnABd2Er30TlEB/fpvVIzBy/9kL6Y/4y1AW0KrLu/WhdqYaDhyXx?=
 =?us-ascii?Q?f8icKXgi1vPGcDALTtdxIp58LSa2FmHCQK4i/Q9J8mFeLEgcmsbSGvIcwB+x?=
 =?us-ascii?Q?2kSwfIMEotCyeBFEWDEL5G8+lTr8OtZUBYymUhQkGiH0PlAWodCZgdsF9MLZ?=
 =?us-ascii?Q?Ag2uFsmZmWDWs4DFBX2i/F6B2GGF7DalZ+TjBBHXnRwgO4rO44G9Y07BGM2Y?=
 =?us-ascii?Q?eWgx1ZO2U8V/gBqIEf4NpPMuVG31XsTJ3Gl5Q2xOqbPS98SDpQY3nMsNPzQn?=
 =?us-ascii?Q?Px8X6A/0/BFuQCBgOSaIC5+5cEzW8fONF4c/7A0+hz6zMaPeO22AhpsQ/6wB?=
 =?us-ascii?Q?WMdf6lL8TrjDYLF+aPf4fpm45lA1HF1e6McdqJJ0q7W7YnYAgk33DmU5Wzxu?=
 =?us-ascii?Q?nSPp3+DENqXW4Itf01+KEMQKdB6Qe2PDrTS0WwKtTlOKW/+v2KawAsEkHCyc?=
 =?us-ascii?Q?dcu8J+nHFy4VJJzY1VfBzP8h5TRq3/XuPHfjGiW1ZzXFjdt9hu6OrjE9uMDe?=
 =?us-ascii?Q?aO7K3YN8hI7vklAukLEAnIjkOWKt8uGGdJf6IkNXAD/UtMawhD4ibTGUVxv6?=
 =?us-ascii?Q?ygX67CMSydETH2JCu+iqDz0hm63qICEXnSHJ3eLQ0CbfZ5fSVZdvydsain5d?=
 =?us-ascii?Q?VfI+BrnC5zpcJany57bXAnR7JXv55L10nAQPrz+yrgh62gmFjTAvPS31Cm2M?=
 =?us-ascii?Q?bQ4AlvPs/Y0sFNYmf16zJROexwfwT5q2uKwBB4DLgpSzs1nK1wJuzC/1nrZ/?=
 =?us-ascii?Q?ghiijetLilucOY5vmOVXnpeCQbbpuYjpbwSUzsWCNPTjSeb+Xuss5V3AARGk?=
 =?us-ascii?Q?AIgVEZxBAoyFVBm/aCz/ljf5UdsC+23uRlkI1QV9OIH4wBeDH0qCglgQhRJk?=
 =?us-ascii?Q?NrR21is/E4N6qaHkHTV1DdOrpNdiagg6A5FHr5CZg3mKF63nv/pHp9wdqve0?=
 =?us-ascii?Q?0d0JcmnARpDQFDRAkGGZrGoPvo2mLqRhUSfYyw2JHn9inf0uFiLwFM7JZRQv?=
 =?us-ascii?Q?E0elgmjDx6GUDnLRWK/8sl1JrQmxqDCW+AcaGtRntyzNSj9OBgQmceIM3rN7?=
 =?us-ascii?Q?DYV64s81eNNkyRY5CYttFHqyn8sXraFrOy7wxOiVqBde+Ezxb1shkS/sKfQc?=
 =?us-ascii?Q?XKBIIKRGEbCSq7quUmyHFnaF0G8abcgG8q9CANfbILtJs+uoX1Lrfy9se3gN?=
 =?us-ascii?Q?2kbV6IR7QD2AgnAFLv5LnNp9k69z1K53/mso63uw2Cp0qiMYmmiMHXIdBalW?=
 =?us-ascii?Q?kbq6EOYCK0SkPRmzeK0X+H9fUzn+umA8WpqI9n18EvKYIvSAlz2ezupCFTC8?=
 =?us-ascii?Q?BxlAqlykMQ6udw9n2pB5K8pcWE9JQ/wvreBCLOO3jQ1SRAgDcaGjRKiZnAct?=
 =?us-ascii?Q?UH0YhSTIMnHwEeTv4E5pCKwj46PFAv/5HvzfYWjUZ0v/vNZJgVvRlFdDEbbd?=
 =?us-ascii?Q?azGwUxgZYYJBgFoDvEKjSatjbIeK0l3oX+05wW1WmQRO+hT/PRJGoqnMf1Fb?=
 =?us-ascii?Q?IregHDlmBzgpy/VFWEjuVl5NRKmVf0MIjnUKLORxbLCE4LRvV6+myg2tpGDz?=
 =?us-ascii?Q?bZd+p+AN95RteEQu4FSs/V65Ct5PGh6r/ZSkAf5Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6226d66-f2d8-4941-3f37-08dce7a6e72d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 14:38:41.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFQSGf81wJbuFvNyxMA9QfCRWAA1LB8aebvg2YJc5fXf4ATGD+2thOImwhz27i/42hz+847f69UZe/6dZ78Rtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com

Gregory Price wrote:
> When physical address capacity is not aligned to the size of a memory
> block managed size, the misaligned portion is not mapped - creating
> an effective loss of capacity.
> 
> This appears to be a calculated decision based on the fact that most
> regions would generally be aligned, and the loss of capacity would be
> relatively limited. With CXL devices, this is no longer the case.
> 
> CXL exposes its memory for management through the ACPI CEDT (CXL Early
> Detection Table) in a field called the CXL Fixed Memory Window.  Per
> the CXL specification, this memory must be aligned to at least 256MB.
> 
> On X86, memory block capacity increases based on the overall capacity
> of the machine - eventually reaching a maximum of 2GB per memory block.
> When a CFMW aligns on 256MB, this causes a loss of at least 2GB of
> capacity, and in some cases more.
> 
> It is also possible for multiple CFMW to be exposed for a single device.
> This can happen if a reserved region intersects with the target memory
> location of the memory device. This happens on AMD x86 platforms. 

I'm not clear why you mention reserved regions here.  IIUC CFMW's can
overlap to describe different attributes which may be utilized based on
the devices which are mapped within them.  For this reason, all CFMW's
must be scanned to find the lowest common denominator even if the HPA
range has already been evaluated.

Is that what you are trying to say?

> 
> This patch set detects the alignments of all CFMW in the ACPI CEDT,
> and changes the memory block size downward to meet the largest common
> denomenator of the supported memory regions.
> 
> To do this, we needed 3 changes:
>     1) extern memory block management functions for the acpi driver
>     2) modify x86 to update its cached block size value
>     3) add code in acpi/numa/srat.c to do the alignment check
> 
> Presently this only affects x86, since this is the only architecture
> that implements set_memory_block_size_order.
> 
> Presently this appears to only affect x86, and we only mitigated there
> since it is the only arch to implement set_memory_block_size_order.

NIT : duplicate statement

Ira

