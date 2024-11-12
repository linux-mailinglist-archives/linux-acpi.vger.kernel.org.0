Return-Path: <linux-acpi+bounces-9513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2929C63A7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 22:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E69285824
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578521A4D2;
	Tue, 12 Nov 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0jGwwZ/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B08219E5F;
	Tue, 12 Nov 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447738; cv=fail; b=VWdfAO+i+V9Ry4+ZszfzMKP7U4PmVkOdrWnvAuUBX5IwzF5vBKZdG7zZDTED0RA+nm9j9Lu5OozZ3/CqNQSlUhn/9ad3VAIX3yVxtekQiYeWE48UfZBzcI9wn7hI8t7VvxwO8OuycwsKVe7YAHR9bS/ySGrfeO5u3lzlNm5PXs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447738; c=relaxed/simple;
	bh=oB49ytUmxatmffVBPuu92ADpmfzOrBFCNPaOlyI2Zeg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=giLEznkvq4G9MOZZ0nqlI2vr0L/nqJIiCQhUybxDmtO4Yn8//kTNsmNxLG+h0fD0iQCSW26JEO0H2LP+ZWmQEy/oJSWfeO7oqLQcc6djGwvJE/ud+/y9rwOFTZNo6KlvFzVX2iyOfyJxKeDe7xBLq9O7tCBMg4mdAl9KzyKmdSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0jGwwZ/; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731447737; x=1762983737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oB49ytUmxatmffVBPuu92ADpmfzOrBFCNPaOlyI2Zeg=;
  b=B0jGwwZ/abMoPs92KzlxCzIThiFlQuVYvgVrNDgAz2waQfk2r0vmFbHz
   oT2AvGDI5AM8eTNE3NTEyq2cISaVervf+dVeMmmiU3OfQv1wXB7VI0ycr
   Ucgkbr8blpHNqQOuelHhPTV4eulQKf6hO+1UXMmE85+mz4jEURRPAEHmU
   6oXsaDpsMfiZnI+WbrK9PIClfNLqw3fVLopc0cegiaOxhDTiFAA28d4FJ
   sWreOIjHyhiidITP0vUpmowY3/pnhl44BkbuNFzulJRpuqvsqhnl2zAKC
   qz+7Nu0vKhkeVahl3gVF8c32h6p7cj5T9fPcYHNlvyUWpd/vJpFqLSY6a
   w==;
X-CSE-ConnectionGUID: AcVBWZrZSxaiHDo5uLOeFQ==
X-CSE-MsgGUID: 6GAEunuVQfeRUwpFJPomRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31081486"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31081486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 13:42:14 -0800
X-CSE-ConnectionGUID: SsojwrxoRP2Bqzr95LiZTw==
X-CSE-MsgGUID: nOSVc860QZGPos2SHmEO8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="87817107"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 13:42:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 13:42:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 13:42:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 13:42:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDr+cp8FExKGCNEprCXJGwwmy+2kGhO1mo0FEKctYbvvW6fsn8epdJ9zjh6EpK5ZskA0kfUVNbGRj90HkDQj3pqVo17d2SAf/9valYtMd4rDh2hFHGXiNxWu7vuEkgaj2/heIFr7t7CH40UgW/jjOCxJcnO5flARn84su2kCDRncC257RcSAoBCfCkEo66rPwdzgm9DI6HX+lblb9yWfRo91srPhBGbztuIJFQWbPvrvoUExre5KsEfYH387HN6t13/eiHbyIUgvpnH2TIKP6XuRerkI8iP6C7Psy1hP+Lx13HjvUx2Zd7jvwoqImHkoJgt9NAIaANdYw66Poe2Djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97+VqzIvg55akLOvL0zhR9UMJ2Zzsa2a24VbP1PcrjE=;
 b=tQD6iZscpdwOMaUd7q9IRrCV5UjRUMRfKJc6z2s5PpqAc/zRZTUTr3waWVZUIhdPxS/hHfN5KGSWaCsrhQJXInRLZwMXSE/BBebt0VVgXF88aROPMi2PRQSfXyf4+SP3s7jg/Y3DaGT8G3D7YE/0uYJNryj/7h4wwRhPM35/Aojhh7+Kqls7Lrg3J30sZWI8UHngS2OIPdWAPcQ+chHrfWiSBoj4t8jBfUv553hCfgb3QeaE9csAEA5PYR6RKa0wmfqFh9tPIyJztmW2N9e41JeiijQlocpE/yWcv2jYJvZt96oAE1U+IxdXmM+UNKu/ql3D/Y73Utozmi3gXd7jYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7705.namprd11.prod.outlook.com (2603:10b6:806:32f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 21:41:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 21:41:59 +0000
Date: Tue, 12 Nov 2024 13:41:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <linux-cxl@vger.kernel.org>, <kernel-team@meta.com>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>, <Terry.Bowman@amd.com>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>, <alison.schofield@intel.com>, <gourry@gourry.net>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <david@redhat.com>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <rppt@kernel.org>
Subject: Re: [PATCH v6 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <6733cba395c30_10bc6294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-4-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241106155847.7985-4-gourry@gourry.net>
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c223e98-e040-45d2-f3b2-08dd0362d616
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OWjcqhUnMhj6GcdVYJc8QtVYd/k4wxYjEwwU4ENpC0oReVjGv4XYMmzTIMtJ?=
 =?us-ascii?Q?PutGmw6fiJ438rByOLEK80VfLr5tr9CxKMrdzEGivDqMpg826xdFh6jUR0pU?=
 =?us-ascii?Q?XMDbJ2fN2fL69aG4XqicQt4vdh2wDJkfRFbYHEdXjojZFgpdfn6giKmRW2Nv?=
 =?us-ascii?Q?xNphGANheY8ChcJEL1Vl4AbfLZ3+x+xuS9WVPABL587g7il0A8a07dnFRfCm?=
 =?us-ascii?Q?Q/NMo847VFmhJD9cgyxad01tKVlNZcmU/aQnT/SLkigbdxPZQbPPLSJGF1l3?=
 =?us-ascii?Q?nVGwge0tA64Hz6jujmmm9uG1sMba8HlfiDd73a1dYBYOz6lpPyVm3RvH8Upc?=
 =?us-ascii?Q?pn5XOIJvEKVKRNVcg6UbWTycIybOaRce0fY9BEKySsgbtH/Covcl9IlntpJw?=
 =?us-ascii?Q?aVooKOaQ+159fO8FDSBJ7xZqVglPCI+0Vy/yQeBFBnEDijauUlG9UBJnG+uI?=
 =?us-ascii?Q?5oxTaJrtZzCBeltH0mb7Cw5/pZeWAQP8Jc4Xv2xKKZ0u4w8g5WL75z8EwodC?=
 =?us-ascii?Q?ngxtTsuiDgEnsfjQXZBRlnTwLP5UvPlvfpsnUOCF7TQ0dyths9EOlY4j2YDo?=
 =?us-ascii?Q?8LALj4Yk5NMlqD8RjzfCW+P1A0Dn/06htB+PKNajuPK93tqYhi9dItC7fD+r?=
 =?us-ascii?Q?tiK6UpISXY+9MqRPB1pDVCGtUiL3QsprlF7KbwErx17vWXw4jCxmwpKs4huU?=
 =?us-ascii?Q?UyAU2D4A4C1dA+nXoFPtYmWBYmVGT43tQd5HH8jcOQ+GxNaHzLMCXHR+R8Z7?=
 =?us-ascii?Q?PsqXj7vQdvlTzExBGQXaN3ZtxTF+TUkY79/9Z+0tpTvpvTmF7t8/y5KMaMVN?=
 =?us-ascii?Q?VmPEfg7dALhglZMXnrgfQkjdNBXWIp/i1qVBbm7Pu/xQKwjiBJ2BmYUdFLZP?=
 =?us-ascii?Q?npt/wA+f7Me71coRlhfSBI9FJuOGofS3encG1mSMX/paDELVkTmPHxagcthc?=
 =?us-ascii?Q?b3d8VY7ghoEBVGQEFExx4aFxcUkgA1K9jOW2+gQCtyIjKv8RFvN3IN5pfdZe?=
 =?us-ascii?Q?FtVYUl94qPgld359UkRZwQwezKR8LaYYcToItsogl6GVDn0WqN3xr97tEmN0?=
 =?us-ascii?Q?esjNAzUjCZghMX5dr0Zen33xs8WpD0CDjVBytbLJYqFPzV3GzST7rRVY84vY?=
 =?us-ascii?Q?+oCRIHE1FNffDQEpV+SqAhVvCMMEUGL/Y1uFOb/9iFdAGp2gCsSXW9kjTAuo?=
 =?us-ascii?Q?rK/fFTbCAPG/FNodNj/cxnNGJ/WPOeyLL1P1AYK/l0lgXG/5zglvPGfSZx93?=
 =?us-ascii?Q?hQDNg6fBzgVdmcOhoTgsP4NVkwNHX25TzhmffR/uLoVsgpF3C4gje9lRelT9?=
 =?us-ascii?Q?tDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plOOpkgCSBvEwnPDUNf0RjmYQ4o7PZWp9EZjEBpre4jYmmBVVFG9xtq9AWVJ?=
 =?us-ascii?Q?/e3jDWxlTdJYR5xoTrc0k8LLvqQRmlsz0xfxML0WLXhWsbFVIE4Izy2wYqhq?=
 =?us-ascii?Q?siq6ZfEfX7jbiRnJWUiHglBu6qCR1wQ2DKQe/XBuPJ62OfLwGq+PAGQV2W2u?=
 =?us-ascii?Q?HvmmSH0ZZepQRVk3gSAdXMVV078Zht+xlm8GslHy8Fxgi3AJdjn8pyIqOZ+A?=
 =?us-ascii?Q?X239P8l8fIrGUVwYVusevFs7yYROkoo3eiyWrAw4j9zdM5ffwHhsRa/FNKp5?=
 =?us-ascii?Q?t78Bq8gGAPFEwpq7On92a249GQa2ETbozSMlYhM+5FBC4sGUDZmS/xGsM+bv?=
 =?us-ascii?Q?xPYhsYQo9zxzqQCIdMAOVxSfDwbtirf8oeume+NTMjO1TqTzGA21iCwUgGRc?=
 =?us-ascii?Q?Qc44XLUgaiaW+zLKAJaiNNTQMyz/V6+jrDtPiN6BsChzhk38+sfS67W1zWHh?=
 =?us-ascii?Q?+Y+GVyJIFy5FLJ5A7OcmYtp896z82rdV9GBUxIIXOho8OewtetPrBgsrlhdd?=
 =?us-ascii?Q?A6WO7OJanLrt/RznYnstXPAwBUJ8hpVa+78+V+Trk0OCFN2H+fhQxbOWA54u?=
 =?us-ascii?Q?fvkJSk/WuJBtaLjRPjnkpYmcYVCghQGXfhLzR/wm3roGr8XxLFWACyCX6YM4?=
 =?us-ascii?Q?QghNH8OR02Yu+fXauCHlva62P3bNwyhUbljf8qUTSMzXBkoJeeXdZg68ERm8?=
 =?us-ascii?Q?Agq4UJKIswzhC7bbhhIN2HjvKfLUnr1cVHLmXhH9vmIYeOgA3M+CVGoH4SjJ?=
 =?us-ascii?Q?fQItJ9bjOiNcI9PplqQzmcrxEJX97pFwlbFJjTqEWOaNJpNFv+1WYTiFEZKH?=
 =?us-ascii?Q?OMN1ro1AuuJQKtvwy1mnlDIdrM7enas+Zl7lxYtHTPJnaAAQkjd1asQqLLgj?=
 =?us-ascii?Q?VkqZLKasDWyGEItEQ4L81GAX3v4wnmq7/C4YHGlHYNZk8SG+A0s+w0xbKSeg?=
 =?us-ascii?Q?LUD1PI1NBIh+ZJ6Tqn3mO6xj+7gBy5BZU9ahxnQ+XJKZtExWcT9yp+YQdjmY?=
 =?us-ascii?Q?hKGnzoaa3w1yHm/lpR4ZS+kM7rHoIKInsP5N2T/tuWk2mx86vYw9lOWEAwK1?=
 =?us-ascii?Q?+SPdtyp6nREp8vKyQh6e/3k4+SOJH4y46JJSrS2DcF35J8YLJ03/+F4ydt4w?=
 =?us-ascii?Q?Wap08btA+/nO4V2aMujEuao4Aa0jIUukEIORQKOpXrIkuwzX6yWZXomJcrsE?=
 =?us-ascii?Q?cH4vLSe4ZnBRu43Ng+kFrbkMDTwwYQ6Gs6/9kXCQGKKzYAFsS23IdMEim3L+?=
 =?us-ascii?Q?dl5sJ0cfj0zOWvK0MacZeWbbCCsyjq1M3aNIrTsBWHCmPd9/kBmA6HK7eM7l?=
 =?us-ascii?Q?GBiugX8OGacorsFrqawgQhH3aAWxoPZNWgn1XCRbz70pfrfctNgaX/yRc6Lp?=
 =?us-ascii?Q?chQ3poHEd2j2MG+hteMJ23YbuaQa6gUrhFunI3sPawd9STwjtia4Jo+4cW8U?=
 =?us-ascii?Q?bZK9vsmbC8FVMbm/zjFRMai1wzpUzBe1tm6SfT0ii0+sAU5RWzPoyD+7OJl3?=
 =?us-ascii?Q?oz+NbyB9BNtxyTYaxQz7G4M2SJICbftrBCyCiU8GDu8DkTqQG6igMtWddqAd?=
 =?us-ascii?Q?Q4ZeFXCTmUgwc8ycDZeie5JosnDBMlvAwQCPcZ26sOFmi/NRDTPq5q16KdmL?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c223e98-e040-45d2-f3b2-08dd0362d616
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:41:59.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qGWHDB5wxDtvCbUGNA9yGhZv8/FO+O5joCN3vg/wdhU5txasuBCAFdgrfhHNjbP7N3pto20t2EvKROMHOiWuGESM9Oq6lfpdriet96K/kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
> 
> Use CFMWS base/size to report memory block size alignment advice.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/acpi/numa/srat.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 44f91f2c6c5d..34b6993e7d6c 100644
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
> @@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  {
>  	struct acpi_cedt_cfmws *cfmws;
>  	int *fake_pxm = arg;
> -	u64 start, end;
> +	u64 start, end, align;
>  	int node;
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> +	/* Align memblock size to CFMW regions if possible */
> +	align = 1UL << __ffs(start | end);
> +	if (align >= SZ_256M) {
> +		if (memory_block_advise_max_size(align) < 0)
> +			pr_warn("CFMWS: memblock size advise failed\n");

Oh, this made me go back to look at what happens if CFMWS has multiple
alignment suggestions. Should not memory_block_advise_max_size() be
considering the max advice?

    if (memory_block_advised_size) {
        ...    
    } else {
            memory_block_advised_size = max(memory_block_advised_size, size);
    }

For example, if region0 is an x4 region and region1 is an x1 region then
the memory block size should be 1GB, not 256M. I.e. CFMWS alignment
follows CXL hardware decoder alignment of "256M * InterleaveWays".

