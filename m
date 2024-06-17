Return-Path: <linux-acpi+bounces-6472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16C90BFC5
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 01:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE57B1C20F97
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25A2199E80;
	Mon, 17 Jun 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6tx5H8/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04173163A97;
	Mon, 17 Jun 2024 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666683; cv=fail; b=d5DdsI5lGTSbxcpy53rS+iQjtHwzEJevTmF6glyJMUK1erEJIv0WO/C0LW3HMSklxy1ThoEEKGQr/16wFL3oS2PiYLpQ2uR/323u9wgTazsfqI7bgSJGsKjPJAy3iYbSZBw3EwLLbhDXw8FRzRczLBuzylL1nGfALVFp+udsd6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666683; c=relaxed/simple;
	bh=ZJzP3KBzYKwkMiOZy7OhLCtIFkcBpqG/eLxFLd67rFQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZpiWXhEiP5rMlDlgk9sQB2he4KTzvb0gFc92nJ7lqybqzPmbiz91nQyLGeK2OdYKSgnMCURKGvfwLi1CtrK9r57DpD7gmV/YPJCBpBpATOcHHEH5BEiQkQRfzZRZp5oDhO9X69w/kWEqYUeYPJYRtoh+enWO9ssbYldHH2JLP4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6tx5H8/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718666682; x=1750202682;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZJzP3KBzYKwkMiOZy7OhLCtIFkcBpqG/eLxFLd67rFQ=;
  b=i6tx5H8/vfck5XGQ8i1yYZ1IFm44n140teXKKCYUI+qosg50kNjS5dNB
   qFCQAmBDla8jOrXs6k3s56RGyIPQcA611hMTsSkZpey3CXSi5ExfWH8rc
   jvO+5cMIizl+PB4qLBeelWIH4yXEje2xgyPPszv49YuOXv6Rc4pwFjo83
   K2pxkBfyRy6fPtsbdAogsvpEsbdmosBpEy+JEXykKj6g46VgZGvItMEpF
   nabnfWdnU1/A0yq75haS3wSVG6UER0AA0bNMuDXI6FHxGC6EnI4Cf8Bql
   cQ5PZjJguMLVkenCoAVuzZ67f/pqRWkwnDD5pBGki0EJiCowubcQXhvyd
   g==;
X-CSE-ConnectionGUID: XQtbwmdFRqaHXeR/bxUZog==
X-CSE-MsgGUID: gUtfG+2zQUqy29nSYQRqaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="38041703"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="38041703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 16:24:42 -0700
X-CSE-ConnectionGUID: sM58h6cyTEG2Khm+4AwtXg==
X-CSE-MsgGUID: uXDJakx9QRO7+ZEach/+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="42048111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 16:24:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 16:24:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 16:24:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 16:24:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu9RVOan4LUzycYG5/aoMpMzwhK801p4psLQnM33clcfEerLmDwYSo0ag8X3YXr9SatdIHazHzgFojm2zR/0GpXW3t2/HJJFgPKfw0F8OzpU9ODJB7Qy7asuUhkLab4wIdaPpfwUxZkndeNpTSFTZOsQ70rr13Ut2q+jUMvrHggpUvxTwVt4WqLzqRu6b0+0vA5KoUMNkvQAPqvR7rcZNhXpF8HHwKUjvuhVlH6x3A6l0FqqF2w8ZOJKqtqt35hV9q8jqKamvchpqW2zqzzkTglflv/Yx4sr/JODYq35L9LWo/iIG9Ek+Jk4M8TJDFIKNZz3mScqO22RZLAKAUvkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mM6VYu3FHo1HxVhLz37UamBqPP7pUvm1bjdbmPx+C8=;
 b=XKYuG8Yy3E+5Va7G0WruZu9VYosUIoVwKGVyWf1rIKIZ/LK4mOJLKTAjjr3SzZwfBuacQgVLHNKY5PCMwKHqiXnVboRTNFfGJJUrW/gODIHpc1a6EJHz7QykRFPg48LXHAvyZaUqeMW3WTQYy7nLc7J1sKwkmhWpDe6mwr0lGi9Qw3fkymsEeM9PyNQ1aywZufQnZanjbzgmykOPu8NutuiKYmzV5vJhwTwX/WGPRORCuYZriLmbhVFfw2WkMmqjGCkLR8qw4t/wj7EI2/+n7Ygr7BBC6v9UO/i0XGtLET6gcZSULoOWp9PwQkaz1eWg6MJuHtTn39dyGN4+VcPv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 23:24:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Mon, 17 Jun 2024
 23:24:37 +0000
Date: Mon, 17 Jun 2024 16:24:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <6670c5b267a79_3101294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240605101012.000041e4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605101012.000041e4@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 1155adb3-6eaf-4e39-35d1-08dc8f24a773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ZmsCWYGfvZSHhJwBz05W1cGPtR4nVDtT5ppqyK6ElpJhXXX7vsPRjPmHjRT?=
 =?us-ascii?Q?BFYBNeN6swD9G5Oc0BL3853fkPu0apXYxbEwPcBY1Qe+uqDh/o3yuqcOncsi?=
 =?us-ascii?Q?90INntMHUPUNXov+Em1HSl9PlcZCDIqNOiCtj3N7lJQ9P2gO2SHSOEUQrJdD?=
 =?us-ascii?Q?xHV3036W9kb6Q29VE6WDcwGCZX+ondmGnfEVxVRexEwbB+E1yuR+u7RZ7IZY?=
 =?us-ascii?Q?uZHItkChCujsO6prUmFfkr9aKsr6/R7PlUz9HVg1GnrRuBOUAmHrkJKTBojO?=
 =?us-ascii?Q?skXqLzve1Fi0xEkDuu2Xhlha2Xd2OTOnTZaL2ShnoDc/n6bvtvLuWQHuNfIF?=
 =?us-ascii?Q?Jt4kDouc4Qbf9+S2Y+lYFps/xRgsX00VawxeF8jJDl4ABIsUKR6g1aHpmgpz?=
 =?us-ascii?Q?EpeYIdZ/y38wcT3z4t5S5x4i9yRlP6ZdwA7NE8d+GX31YTb+UY8AUbqDDPtk?=
 =?us-ascii?Q?TsgWh1+37G4wU/C2NVzE0aVhpmqlMA1cshUdqaMWp3DokNGHcgToJLw0kMjf?=
 =?us-ascii?Q?OmIUFtwSZff3jpWsrhWqgSmjTG4FZrQIfHMEuOvxoX/8ShBKr90SH4wnqWQy?=
 =?us-ascii?Q?lxEt2kTUWkdBCCZEchCLOh+P1rhmqHWHXlQY9/sI2bhHUX9WMYE7ZHWKFruC?=
 =?us-ascii?Q?himXp2WaqAzIasweWDeYhiqw0CETIRPmdauCwdkNe/1EXyBlPFkmJDhIsFaG?=
 =?us-ascii?Q?K7MM2nYNv232lraqJEuUrWia7coRGSg/z8kt5/AjIE9AylOZL1gWj59cDf5E?=
 =?us-ascii?Q?YPuNS0hc0e9E5V21gdehuXMPLzNJSaJIxB7TplixH+z9PFq2HRWxy2A/aAlH?=
 =?us-ascii?Q?7Q+cvC+tdDeCC9bj7prnIxgiOhfdYkRWLoXvLIJrfRi0Z3FtQzc1WsVllDlI?=
 =?us-ascii?Q?bmtHHjMggcpm1kZBi9gJCbdAt3KHe7fP5deWnEG8rA/HpmQJw7O9Hql7Re1g?=
 =?us-ascii?Q?Dw0UziXCNr/F54qyQZt4psgTdVseTnbT9NWpU2eGQYObY1znMnz19AQdWJNg?=
 =?us-ascii?Q?8LvGcux7rQ0DW1VzaNAi14rzGcy5u25Y0M89u6ikP5WcaORwrDVp7S8/mUnC?=
 =?us-ascii?Q?SJRFMjGgLmjTgxi2YMQEytfcIE4+EfhDBChWoe7OQ7dGII+eABzXGpo59RHX?=
 =?us-ascii?Q?dcsRKU/rj3JHxE/LtW5cpuwZm+xpuyrrnEZL3I9zl82GFoeuJmvnw3HEQMwD?=
 =?us-ascii?Q?yG7CqYOHgYTzGTBQdOVTCF45sjj9xyTjQP53iSYo+fS2mAa2QsHPOxH20e1R?=
 =?us-ascii?Q?5nJrL4Z+qgxn1mojPm4y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOFa8TRxdy+oqvFZbd5JY3iqHRzZPXzcAI/IRAwYS1MW/kOtmMFb6z1L+Wl4?=
 =?us-ascii?Q?dGEmCrlrc0wRxngB6tya2UWPsLd3xHYwfC40gVo5226YniHdIze4Yp036iYY?=
 =?us-ascii?Q?Wobeasxal2pEDexJsUO4ah5irzHOZlT1mNNWfku17w3Oxw8d7cCQeYOtYc4L?=
 =?us-ascii?Q?FOhOl5FkF7caYhpsoFJ0DMqkeVooeewpK0hxVoA0ncQqP+jlUD+1qSZnxs/w?=
 =?us-ascii?Q?1idndo5tqOwfckiJaEh9/RlF3r8wC7vti8p5qhXJZXaswXKYfNAGk43Ma4pv?=
 =?us-ascii?Q?B1JLac7AJ/HmntHAOEXMGAh+J9D/hkNLDqVoscMY9NSSMM0E1bg/YPyokyx/?=
 =?us-ascii?Q?71Svz7Q4EAR6MBPhQrAMf0sj2A2hEAxQjC+p3dhK5tac65gBKueTW5JXOBrR?=
 =?us-ascii?Q?F95ZlyHleGPcK0DV21vzBjzhZWHIyZa0XuCD0IMk64EzqJo0x3ebvmNoWKvm?=
 =?us-ascii?Q?LYlmAL6B4u7uWK0sBQVNQ3oZC8c+OYXWbjWJz2ig8mFXdncKwGm/HrKGT3ur?=
 =?us-ascii?Q?V6DYk5GnNPsH/uY9rnZ4KLUP3+f5CIb+DYN/kz2ihcZcizA3wxMyU2CwzcPB?=
 =?us-ascii?Q?V8ZSA8ZTelGtSXOQwkJJuwB7XAWtnou5bzXEkC2i0lHOVXrMB9PM8WZYttHT?=
 =?us-ascii?Q?ipqaR1DqtTzLP9Pf5WguMhzAPmd3/BfUZU9qcM6pKE7CIREVt1+ZLnQXhZLA?=
 =?us-ascii?Q?Y9SUsGCXJYp1/SR5cRy3bHuFtwOZKkV0S+VFZONuGSdn82zo70KS9c2WoYuc?=
 =?us-ascii?Q?WEKiaaVykA2aydv1biZKJD2fXnhhY3TFQ/Gre4zjuHVedM/CTHfzduAf7MS/?=
 =?us-ascii?Q?wWT1E03ac+UuLedn/ekKSE0EoOfAHdZLXyENB/7KSZFTTytn796h/s0Tp730?=
 =?us-ascii?Q?7N5ePuOtkN4TJK3e1BUUoCUP/vkMVMOBowg4sD0AySeKlHUcy+0pkh+u+2UB?=
 =?us-ascii?Q?gyYjWiA8gtz8K9c5Etw+Qlf+34DdtLySBxOneeS0+eKs+8x3BjphohJSnnqj?=
 =?us-ascii?Q?0ybeQDUiICwu+GMkDJ07LzDegg1PWQwn50KQVJ4t0KLn+j75XPW9mDvv75nb?=
 =?us-ascii?Q?c9st//DCciGlp9s2zg0oGzkq3UVc+WPgUJZCXF5nx4kvMupoC22kcnPLZ+gJ?=
 =?us-ascii?Q?JK0QzUAjaOkwYqm2uaDjrDerD1i/xpqwxQ3XSPmG59JGX3L9LySlmKf1LqBS?=
 =?us-ascii?Q?uKKo/Eu333UHbT78lvllFLca8a/dPwPCKGgrqdekkflA0YlsgPUZ4gzlLMFG?=
 =?us-ascii?Q?1OHSb4e2UwY/MpoS6q1Qp8+FjN6A6pVPvfxjIKNQHN7ZMKxnIQhpAALraVXa?=
 =?us-ascii?Q?cj11DYa6LwKPiKzYp9eP9/VQcZ9UFQLoe2m5qoDTzdy1xT2iJB6U2UpQoly+?=
 =?us-ascii?Q?0J8u8nu1t9zPoDCw/a9xWAsIf9LZ8mxmzV/GuGv7YqY7ivqjqzGqILYt3LL0?=
 =?us-ascii?Q?Fi/L7g/S8MnFh+hBR2BDTiS8B9KSLucSE6ZDSAIIARtkK/fMThU4291QnhlT?=
 =?us-ascii?Q?GR+PjlqbntQ6ZvhvznmwPapFt6vcv4CMMf+4I8+GrxSTMj0DdEY8uQxdPuCO?=
 =?us-ascii?Q?XPkGZS30xTVf6Wt5EYdMikTzWCbrIDBfO52/OfZLfD9NYN+oSGuJ+FbdYD61?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1155adb3-6eaf-4e39-35d1-08dc8f24a773
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 23:24:37.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11JjgQZcSjsHA4dkrD3l3wT1fIlELfWV/y8bmEQ7HUAdEjq8i7mpe2e6f8P09t/2bKuefZpV/xN5RHCDCz54s594UmMf0zM28lojBcH1XUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 24 May 2024 12:05:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > # Title: "Extended-linear" addressing for direct-mapped memory-side caches
> > 
> > # Status: v3
> > 
> > # Document: ACPI Specification 6.6
> > 
> > # License
> > SPDX-License Identifier: CC-BY-4.0
> > 
> > # Submitter:
> > * Sponsor: Dan Williams, Intel
> > * Creators/Contributors:
> >     * Andy Rudoff, retired
> >     * Mahesh Natu, Intel
> >     * Ishwar Agarwal, Intel
> > 
> > # Changelog
> > * v3: Replace "Inclusive Linear" with "Extended-linear" term, and
> >   clarify the SPA vs HPA behavior of this cache addressing mode.
> >   (Jonathan Cameron)
> > * v2: Clarify the "Inclusive" term as "including the capacity of the cache
> >   in the SRAT range length"
> > * v2: Clarify that 0 is an undeclared / transparent Address Mode, and
> >   that Address Mode values other than 1 are Reserved.
> > 
> > # Summary of the Change
> > Recall that one of the modes available with persistent memory (PMEM) was a
> > direct-mapped memory-side cache where DDR-memory transparently cached
> > PMEM. This article has more details:
> > 
> > https://thessdguy.com/intels-optane-two-confusing-modes-part-2-memory-mode/
> > 
> > ...but the main takeaway of that article that is relevant for this ECN
> > is:
> > 
> >     "[PMEM] is paired with a DRAM that behaves as a cache, and,
> >      like a cache, it is invisible to the user. [..] A typical system
> >      might combine a 64GB DRAM DIMM with a 512GB Optane DIMM, but the
> >      total memory size will appear to the software as only 512GB."
> > 
> > Instead, this new "extended-linear" direct-mapped memory-side cache
> > addressing mode would make the memory-size that appears to software in
> > the above example as 576GB. The inclusion of the DDR capacity to extend
> > the capacity visible to software may improve cache utilization.
> 
> I'd skip the cache utilization point as even with 'may' it might just
> end up rat holing!. Capacity seems enough a justification to me and
> requires a lot less justification.

Sure.

> Perhaps something like
> "The inclusion of the DDR increases the available capacity whilst still
>  providing benefits of a lower latency cache."

Per above will just keep it dryly associated with capacity and not make
any performance claims.

> Up to you though as I'll not have to explain that utilization point
> to anyone whereas you might.
> 
> > 
> > A primary motiviation for updating HMAT to explicitly enumerate this
> > addressing mode is due to the OSPM's increased role for RAS and
> > address-translation with CXL topologies. With CXL and OS native RAS
> > flows OSPM is responsible for understanding and navigating the
> > relationship between System-Physical-Address (SPA) ranges published
> > ACPI.SRAT.MemoryAffinity, Host-Physical-Address ranges (HPA) published
> > in the ACPI.CEDT.CFMWS, and HPAs programmed in CXL memory expander
> > endpoints.
> > 
> > Enable an OSPM to enumerate that the capacity for a memory-side cache
> > extends an SRAT range. Typically the "Memory Side Cache Size" enumerated
> > in the HMAT is "excluded" from the SRAT range length because it is a
> > transparent cache of the SRAT capacity. The enumeration of this
> > addressing mode enables OSPM-memory-RAS (Reliability, Availability, and
> > Serviceability) flows.
> > 
> > # Benefits of the Change
> > Without this change an OSPM that encounters a memory-side cache
> > configuration of DDR fronting CXL may not understand that an SRAT range
> > extended by cache capacity should be maintained as one contiguous SPA
> > range even though the CXL HPA decode configuration only maps a subset of
> > the SRAT SPA range. In other words the memory-side-cache dynamically
> > maps access to that SPA range to either a CXL or DDR HPA.
> > 
> > When the OSPM knows about this relationship it can take actions like
> > quarantine / offline all the impacted aliased pages to prevent further
> > consumption of poison, or run repair operations on all the affected
> > targets. Without this change an OSPM may not accurately identify the HPA
> > associated with a given CXL endpoint DPA event, or it may misunderstand
> > the SPAs that map to CXL HPAs.
> 
> I'd like something here on impacts on firmware first error reporting.
> Given we'd like that to work on a non CXL aware system not aware of this
> feature at all, I'd propose multiple CPER records, one for each alias.
> That assumes the firmware has no path to establish the alias.
> 
> Can certainly conceive of ways to implement a probe-type setup to allow
> the discovery of which alias has been poisoned etc.
> 
> Perhaps needs a note somewhere in 18.3.  Something along lines of
> "For any error with SPA originating in a range, where a memory-side cache
>  with address mode extended-linear is present, multiple error records
>  should be presented to cover any potentially affected aliases."
> 
> Maybe an OS could opt out of that multiple reporting via _OSC or similar
> but I'm not sure why it would bother though. Easier to just allow for
> multiple events.

Makes sense to add a note about the "multiple CPER record" expectation.
Effectively this ECN is about allowing native-error-handling to do the
same.


> > # Impact of the Change
> > The proposed "Address Mode" field consumes the 2 Reserved bytes
> > following the "Cache Attributes" field in the "Memory Side Cache
> > Information Structure". The default reserved value of 0 indicates the
> > status quo of an undeclared addressing mode where the expectation is
> > that it is safe to assume the cache-capacity is transparent to the SRAT
> > range capacity. An OSPM that knows about new values can consider SPA to
> > HPA relationships according to the address-layout definition proposed
> > below. A legacy OSPM will ignore it as a Reserved field.
> > 
> > # References
> > * Compute Express Link Specification v3.1,
> > <https://www.computeexpresslink.org/>
> > 
> > # Detailed Description of the Change
> 
> Probably need to up rev HMAT as well.

I'd let the ACPI working group make that determination. I am not clear
on whether repurposing a reserved field mandates a version bump.

> > 
> > * Section Table 5.149: Memory Side Cache Information Structure redefine
> >   the 2 Reserved bytes starting at offset 28 as "Address Mode":
> > 
> >     * 0 - Reserved (OSPM may assume transparent cache addressing)
> 
> Can we make that assumption?  What are today's firmware's doing for this?

The only shipping example I know of was for PMEM.

> I'd drop the 'may assume'  Also after this change it's not reserved.
> 0 explicitly means transparent cache addressing.

I am just going to switch the parenthetical to "(Unknown Address Mode)"
because "transparent" does not give any actionable information about
alias layout in the SRAT address space. So system-software can make no
assumptions about layout without consulting implementation specific
documentation.

> >     * 1 - Extended-linear (N direct-map aliases linearly mapped)
> >     * 2..65535 - Reserved (Unknown Address Mode)
> > 
> > * Extend the implementation note after Table 5.149 to explain how to
> >   interpret the "Extended-linear" mode.
> > 
> >   * When Address Mode is 1 'Extended-Linear' it indicates that the
> >     associated address range (SRAT.MemoryAffinityStructure.Length) is
> >     comprised of the backing store capacity extended by the cache
> >     capacity. It is arranged such that there are N directly addressable
> >     aliases of a given cacheline where N is the ratio of target memory
> >     proximity domain size and the memory side cache size. Where the N
> >     aliased addresses for a given cacheline all share the same result
> >     for the operation 'address modulo cache size'.
> 
> Probably need more here.  What if someone has two such ranges of size
> 
> Address 0, (512G + 64G) , (1024G + 128G)
> And decides to pack them for some reason.
> The second one will be aligned to 64G not, 128G so modulo needs to take
> into account the base address.

Decides to pack them how? My expectation in this situation is 2
proximity domains / memory-side cache descriptions.

> Do we need explicit statement that N is an integer? Probably works anyway
> but having 2.5 aliases is an unusual concept.

Easy enough to add "(integer)" after the first reference of "N".

> > This setting is only
> >     allowed when 'Cache Associativity' is 'Direct Map'."
> 
> Other than these corner cases looks good to me and the new terminology and
> clarifications help a lot.

Thanks for the feedback.

