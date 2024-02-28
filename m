Return-Path: <linux-acpi+bounces-3992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF386A830
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 07:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5698DB22045
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8CB219F0;
	Wed, 28 Feb 2024 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2bf7wPb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F321379;
	Wed, 28 Feb 2024 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100260; cv=fail; b=bprdz+WXfNJvQRuLmzzy46POAQ+hkXfhtSPsOaImQiGQqPAie4tM8w06Mpp+S34KJeEVQvefhnVvlHtobShy4AUqX82h31YV61/XO96/fr/pKQjjFcXgXQXBrDI2lbz8TFikx2VUmqpOwaQLNyS+VKVeHNMMmqizV5cn6vrrJzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100260; c=relaxed/simple;
	bh=iUe2pNAsWADQDPcH9IahjQbFJ34nLSLYhxKdje8kJOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qm/OQbi7Vn2EoYtjbtTtbID5G3gMUOdrd0nUBAnHhx8DFy6VRaY+wSfNu8LhAsAKh0RR4ALng1+zVStP7t3dbYX5wKptSyE5CdUCxlHPTjQZeCFrxAin/DKujR5PjWlw2Qwu4TpIsLg+ADBldREhYhTV1AbAFcrSgSpB/1AqttA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2bf7wPb; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709100259; x=1740636259;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iUe2pNAsWADQDPcH9IahjQbFJ34nLSLYhxKdje8kJOg=;
  b=h2bf7wPbjhARRJLpyN0cTYRGeNto685P53gSvvpK6068vN5s9xcQA/rA
   SMrEuBfni8FARdQJ2rj3DL8oF4s6MCczR3r5an2THk6M36EIvUrQ4bnwi
   NLLRP+KF9lwX3vPJcIrIHoFqnYJ9gSZi45+H9lcGHnnyoJTsQJbOgyhDf
   14p3PdAWATFPJk+H6fRS7DFJkfb5vSWqJ6lgeT7Gkv4HQn3WW9soHFIC3
   P3Is5vGQU1LhjzqKGQYyiMpMVcvQFROb7EZ3SJphHitxW1xcvVgnlh2cD
   VRX2Qsoi6+D+fLXOCzx3N1WDgUVJpdkQocA00hJnRSV8UvAh2Vlkn9Qnf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3327146"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3327146"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 22:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="11904487"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 22:04:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 22:04:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 22:04:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 22:04:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUMUM6I/+DLpcUbWoLRE2Zjox76h9BO8hjmqOEQ1Xl+ZRFMGQ/BT8iEqcar5OZmaG+ON1q+ki5eolqx18jAmzAEi3qtyKZq9n+hqGt0gIb2PgU2lgmIJdVVcVmsMfE8bQZkNP5ZTMlLhp9sWINJVbNEE9rVMMFsRdMsJ3JPP8PsbzQ/M7H+UCf+fg6LpKGpvGFlqN/dohx4Q+pihBti//oNX214D5a1rBfgz4E6v1of8Y0eiEj0cCbgT6/MhPVMMIMfQXNbTyRV/oP3WubKj9Xm5rwtZsYaz8nDJkQ+Y8xWYEFYRH0owleqDKnBGNfWkfGeajFFtL4Z3gUlQiSbdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ioh1BOvwU1gx7/fJKSDhquXpcaVBToEr/vNPFsd1Ls0=;
 b=XOb7ZJFriWlbZW3/adyXdM3l+cmmc7wnTHro/tte//VX7xdTi7gSsPqAYxn4Xd5NdeMEH/IfSNRD+PkJ7KvBgebSDUUCtkj9fmlNt+G5kVKdTF0g8tUr9wQF2n1Zhtx0Lx52mRf9+SxBSXQ2S6T/ObEmusMWTOPHrOSgdhEASqF4aXVoKCChTjfDv9+It1fwba3Bth1doOYgM+gxJhcGoSUi+T0AnZJNUWGtaZ+9N5Vk/JnhAeAgYbL+id2kHm0WZqU+bb5Cv4mAP+6gcPRecPnEYK5vm8pPZTKpGG2li4ErC+jUU+WS6YDNX1OCjCGvusNBpQM7/oT9UObBueijTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Wed, 28 Feb
 2024 06:04:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Wed, 28 Feb 2024
 06:04:14 +0000
Date: Tue, 27 Feb 2024 22:04:11 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Message-ID: <65deccdba845c_3651e294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
 <1e7673e9-8e30-4d66-a86c-bb768cb69f9d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e7673e9-8e30-4d66-a86c-bb768cb69f9d@amd.com>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: f78a1fa4-4848-437b-14de-08dc3823171b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vIhmIvEVekoojL6CMQOfhNGD1uzSpQbEr53QeDKlu8ohNP/u+I9xvbahxeCKKC9sAwhNNPTUNjtQVoh8U6t6Mgn0SlV8iQBBOuxVa0CyEdpWMtEFmckjjonYx6SZnvD0RXWnic8gf/eOy4FhtMUw9JVmRaN8qS5wLItg6zXnn9pXf0FfOuk1nUHKo1j8k9svY2Vv9EDFyakgeDKEOqJrg3AeOzIQolcdJ6eanN1UF6DSmfx2DDTqdmmUK7owcfnHKOGOwocF6OS4kWTabsR3x6UbEtyhpzMZashjBHOXDGh7LDxRQLiOeC6iHr2vJJH1rHghZJogpnMTsMIiAqm4sbOaohhB3tJd+/rpjuSE2LpYZhYDvk19/9VHKlKnli54lbYT1DH6wF54OTrGE+6wDq0ISfmDcq8Mn+kP4DoMuj1NPIFp95S7Vd+x4AVfD9I5P3GzugrKcvWLBG2xA+b7h2wz8RPmI2FJOcdrFHPe87zdS6s3DXW5E/1x1VAIEdEqW1Cm6/2Q+1p/4vIIxPsr5AX4dJ+FNM/MM0K7gVWUVcU4RUuARiFu0OGzUCJ2drDo/nBy64Rsl4wWFefcF2EsxlLFkEoxBIzsKJNhrHqI5ySqWDNYFP03sCdG8onBCXGSWBNNu4to6rVnc3gAF9Y8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z4bfSAY94rn6/rCYDYjdY4U5Nniy5VdFcDg6BNDAg6AMYYE0FzVO33Tor40+?=
 =?us-ascii?Q?TOjx1xkbx1x4ysvY57Wgopsakl6q1MrDx0stv36+glSPBOLvEn7EQhhAeK8p?=
 =?us-ascii?Q?/QwqqmCbjx13/gHRwOT6mPmmn14PDqGymT94u+37CvwamYA7SnB7c0VHazP1?=
 =?us-ascii?Q?dvBxEpjRl3sQYCd5gCvQhexigZjkWX54oxeFkd49q5ihEljbFo37IEy5DvcI?=
 =?us-ascii?Q?T33Yd2BVoh3+Xl8XOJEeFyEcmZOligjGp7AK9HpJyMFiExjJcaibWXPO+NzR?=
 =?us-ascii?Q?NX0cdVb2dpdq+hGb5AY3V2eQ0RgB6MNDN/HGsOA4tIMSzA7yznB6VMkXey1T?=
 =?us-ascii?Q?928mkfz4a7BrYBxlcFPUJgZ6eriA3X8Sbb3Zsb5k3KZ8sYYCCJkUybh3fLZ5?=
 =?us-ascii?Q?KljHCHmTBWHxgD+5VlgB+1bVzuTB8LEZpZso8ksAuPt3z95ZAr2NPXqcPqjC?=
 =?us-ascii?Q?xEcYPAbU+VRiOf+kXs6uS+wDvAkKvyTr6RXAYZ6+U9KNuRrSa0Q4Pm49wVmA?=
 =?us-ascii?Q?Mbmj3iL2LQ6ybCpvNrjyr9049i22lkZ6cumlmpRbLRmZ2HKAG7E/nOkoqUXt?=
 =?us-ascii?Q?XjS/DmJgHChrMjSovgwz3BQuqKBZuQgh1eUpxyQQav8x+vNzI37nQfyzFxHp?=
 =?us-ascii?Q?IAZ9XfWY4bBv0EmkgTbIdxjeuQV8r3P1NIZGpPMms356Ll1t1j1+XPgQYkyN?=
 =?us-ascii?Q?9q83CDA9ZtvQ7QDGmb4SwBrjkDjPCb/2WkQ4ZNVkwMoSbpYyH7WqsCOmjayd?=
 =?us-ascii?Q?8akUury/OwlT9rBuhtdYRAZn/e8Z5b7QvXs9Z86sktxRT+QvlJ5+aXHKSD7M?=
 =?us-ascii?Q?5fhpEzNbqSvET87nlCYFwDFQu3EU/osTn/LkYDpaSs0bPsKNZWS76iJKVMm2?=
 =?us-ascii?Q?cpmA8pSv9zdu0cguBHJoJY/jC87t0a1rPq5zqlwxCEstS/gONOPzTCz9EsUN?=
 =?us-ascii?Q?JExRkMiFVeQbJmiZGsSGM1GQNbNwWjahOZaN0CG0sWq9tHwCWgTn5xK37zJA?=
 =?us-ascii?Q?RIx4yQ86J61bSNTzVQVH+5M2D2IqQChEnOrXVRcqCwfcoFM5N3SF4sQRZrtm?=
 =?us-ascii?Q?rLtWErsvkyDt9bS/G9j1kViWidva4dkSptwHFIyKzJ+Xlo3qdOjMFcI4djty?=
 =?us-ascii?Q?D7Hy1xpPLFzFeoNHI8Jj0gw1Win8duStapo34FDwt6o8lwkYWrbxT0gzR5s0?=
 =?us-ascii?Q?HarW6H3zgYqORjfxvQEUxxYoqLhOKvtgWUUtjyRk/5ReErZ+zipgAU96LBHH?=
 =?us-ascii?Q?JMy/6bszmmWnRGPWHVEcrYktGrPsvp+fGTNJ9rmpYtrh5beg4EzbPQj0oysV?=
 =?us-ascii?Q?ZpsYupNp77AwJ8FeYabPp4iPeG70h108ViGEeO9Okg1bzG+xR8D03ciLOtcS?=
 =?us-ascii?Q?fQHg0jcKwLiEcwg0QbIWGHxEL7npXf4DhDYlAlv5ep+GYjW7fYLkFzSo6aTW?=
 =?us-ascii?Q?yTWi55blTOcwLxB1V6foCAv0WONdQ/D2+yOXmfDWBOCqZ/GXaAiacAuA1DPx?=
 =?us-ascii?Q?SzpIkpCvz3Fc5EvuKhSMz0lBlkpoLDxSn+kBgnErClusNFWWOJXxktXvnfGR?=
 =?us-ascii?Q?TOlylIWXnMFJirt681Mv7xn9szFxoYi0ivJ/Xqdk2M3AXp5vo0hQodRZOVgb?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f78a1fa4-4848-437b-14de-08dc3823171b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 06:04:14.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDpA9oc3JNtfO7cvlQDCBRZahh8EvoZ9d49ZP8JCSLbGOFwT5wckL68raBI58CkCi0Y/x+s6vmSmXYZqKcBOg+WuL/FTmgDTg82xs0een6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> This patch had an outdated commit message, so here's the patch with an updated description.
> 
> I also realized that I was wrong about letting CXL 2.0+ error types (discussed a revision
> or two ago) and I wasn't actually letting them through. I've went ahead and added
> the ability to inject CXL 2.0+ error through the legacy interface. This pretty
> much amounts to returning an error for CXL 1.0/1.1 injection types in einj_error_inject()
> and instead routing them through a new einj_cxl_rch_error_inject() function called
> in einj-cxl.c
> 
> If this change is too big I can send in another revision, I just wanted to avoid
> spamming the list(s).

The thing to avoid is sending too many versions too quickly, and making
sure that upstream can reassemble the set with minimal effort. In this
case now that I have a few review comments and the fact that b4 likely
has no chance at assembling this correctly I would go ahead and fixup
those comments for a v15.

