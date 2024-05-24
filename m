Return-Path: <linux-acpi+bounces-5977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A68CE943
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 19:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269C5B21697
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C72231F;
	Fri, 24 May 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSWhmQ/H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69E8493;
	Fri, 24 May 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573004; cv=fail; b=R4vsOvsiN5ZnJCo6piXIDeXvGXHkUtElC6V0Yg/2PgWJ+MVjh1No7Yf/DKarqma2aHB1eiQXFEcj6sxa0TGRYpAlUOECPiu09nPjOhWoAbZ/384Fh1G+tTLLwSp3mPZmQNIX6DwlSy47B9Nbr17t8uPeSGYalSYWuXILgsrlx6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573004; c=relaxed/simple;
	bh=zDHGlC96OXFm3p+fcDQMB9VsDHpdrbOF0i+TkOLNBCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ukq5qD4i5b8bL7wxb3m7fs3OYRyI47MyKTTH48nTVS0H8MO5G+Yixo17K4bzmq+lE8fngKPf92zDq5pW3Gts3MSC+ZpbAZRAcpv6WRr79sdjNq/RKGJi5FtpmHgWS8ttPMtUj70Nv72blL9sIgRkNvbPO5xAunJDQnYiRzHTFhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSWhmQ/H; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716573003; x=1748109003;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zDHGlC96OXFm3p+fcDQMB9VsDHpdrbOF0i+TkOLNBCo=;
  b=fSWhmQ/HvNO4V8ROiDxGG7K2/JKlGL3cnJC4s8T8fsguQmQy6E6hcpaJ
   DEjXdZo0a+BhaVniWRTEzQdJ1SmKnSYAaesshs47icSCpK4jjsLeGrDez
   08DyPnKVJcnBskdwhi+mnmjA6d7lgb1XYzWbfngTbfZ+5a37rjuv44do6
   DWOFPxjDrHJiIzouJXp46u/SndCOdl6h7y0IcoESLhFD42NqTjCjrOmFW
   nNHQJE2N/CVMh90b1vBL8rFATXrrXmzskmKwOzITdFKMyVLTUxAtBcsXA
   T41TuNCKFqXJlmJahZcYTvl9ieMkDZQUjR7cGNst0r/UfaDqD3Hl4a1tj
   g==;
X-CSE-ConnectionGUID: 5JCTLq5ARxanRpIx6XuQsA==
X-CSE-MsgGUID: rjH7Ff7JSd2Ncoj1dxTWiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="16797775"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="16797775"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 10:49:59 -0700
X-CSE-ConnectionGUID: uH8+27ltTIW4vh8mfe9g3g==
X-CSE-MsgGUID: eFmpLAYZTgisgBnpx5QhWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="34111161"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 10:49:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 10:49:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 10:49:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 10:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI57OJLhhlfzwCnPu4kLGBGU4S9LzdP7DmgP029obVQvea0ptltVuXjTp0zQhEw/H0l2Ci9Cu6AYnx/uDTGsHIyTFuSS7+VGxAQPn/m9qsFMWRCEG6cdKN4kcavyNfWQGzv8Xv7xyBsGksQJ+kVa9R+xoYPTbARYm1HKJedNa5B5pZmsR75jM8u8nbI8a4/glUP8ya4kpkoY+gsXaxrY3S3rAbtTQG9TxxLngr3yskgh0krb/LW3PNF5S4IEiw2bENxv05cZ/K47WPt0mxhzYX0h2Dmdw7DTgKkruOEUQW4uosCH9vfviO6mTRDk65ywNopahVuRMqMGcTNzICPbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMhmT4WtvkmPS9Iy70IJ81PdapvhTCejbiDRrPzUZhI=;
 b=XVllVUhAluNxf9T5EBC65H2QcIDCGXPB/fD1oQc+1sPd8yAqzd/lMapzBywVTGk0W9+BfAX3/cbRg48p2ewt3PmkemkM1l9V9l7tg2a81Ly7Xc8ldZ3HRcLUwn5bRuJqHLgBPpXqR3zaqp5sH7lvBPyUY3DGFQ/72FyAhFPoSJDxYreoNjvq11OeqXbAGqPiw36yZxXlvgiz/LPoITQPxLrvMP2drRoYa3jtV/W95F9YzdTK6JiTT2V6gZqJqMHUNEnORv44wbFNk3IuiswfVLRxgCyDJe9oRdo3jVjPMT6+LCMfZfJjQxAgoowu0M4GiSOzfS3+5pP0UmDTN9ehRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 17:49:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Fri, 24 May 2024
 17:49:57 +0000
Date: Fri, 24 May 2024 10:49:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] Enumerate "Inclusive Linear Address Mode"
 memory-side caches
Message-ID: <6650d342bb1c9_6ec3294b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch>
 <20240517174550.0000242a@Huawei.com>
 <6647bbf6c88e3_2c2629451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240520125333.00007a47@Huawei.com>
 <664cc3a76e7d_2c2629462@dwillia2-xfh.jf.intel.com.notmuch>
 <20240523124947.000034df@Huawei.com>
 <664f707125537_18c429438@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240524123155.00005b0a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240524123155.00005b0a@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 105b7ecb-e540-4e0c-cc17-08dc7c19ecdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DsI51hC4frni6LABazqfGVabz6pDc9E2gJ7+Tk9cO6y7E7WJkR0rJBI43iKD?=
 =?us-ascii?Q?M0AvtsIEFgwVeewXn2UNy73JhRZrRtzl9gzcdjdmEGsAHgz8XmrTEyykenyq?=
 =?us-ascii?Q?p3KRqBceIWFDUA8WzH24RGv6wWuPRQU92ONC/PxnKSwpVQ5bBhdaYWQIwRk/?=
 =?us-ascii?Q?usfWTsHZN9+cBs72zNqI665acg+z7R0zq+o96foGge2MYfLlvMo4qT3lALvp?=
 =?us-ascii?Q?wE3ndzbOkzpVnWbsHEeCgjdCaEI4SoJwD74LhPdrPyGxEQgxQZ+HyOwbOw3e?=
 =?us-ascii?Q?MJcpdYMgFrQ+N1xwiZ0RJhb8vOW570V1JjtV/IxkEks5vCKlw7GJ6bNxizrk?=
 =?us-ascii?Q?iQVtd808k0lgOXSmMI2f4ra8Z9EH7uJPn48ymAXRX29L2Xdh2UN3uuvPXCeR?=
 =?us-ascii?Q?+w4O81s0MM9f2CdgqCsdHyeKIgGcfGbYoRdAcjEmtPlL39MYggrMtuMRGOm5?=
 =?us-ascii?Q?ohotCmEBsZiee6KPluEp53QjdNyEQywMFtVZSu/uxM++cpDsN6LMo3rzdfcz?=
 =?us-ascii?Q?fhYjlXKMA3Wx8ld9MfVqNeKcbXvq0inpnQxkxuIGOhQEuW2+XdaYI7uDuzpU?=
 =?us-ascii?Q?87geEkHhN3jRCM5mIwgrU0lHBJb39HDQ6MuuuQw9ODg+sFm4+W9CwjkxnQz7?=
 =?us-ascii?Q?re5CRmr8iDJT6AGRnwYr4+M9DiILJeXV0CBNKMI9gPv6mDgH0vA6f/ks3Jks?=
 =?us-ascii?Q?s0jXxr+On7+Cb8kRGS2q9i1WevsDLLh3EdoPMOQGQxw4kSLIlVxkJlUEtIgd?=
 =?us-ascii?Q?ZZ72I4IxBhwDoI4h0f/NGwcTx3TjCQ+gPgXYkmwl2+A0//Ikns1SApiwOkfA?=
 =?us-ascii?Q?lQAvzxCHCC9869/TjfNU0wxi7ti4kY6wL4AX5+ka3+zqbovaOKVdqClvsToV?=
 =?us-ascii?Q?79qyhke0Ib5lsPuRbY+ewTWiOuz6pXMOYvG2DkvMqc6MLcqh7Mp2YTjwDxTl?=
 =?us-ascii?Q?3Usonjb5LPqq1wvkFHwY76pWORvKJjxGKdeAEJIb70axQ0SIUD7oZGvdvOfr?=
 =?us-ascii?Q?I3+HNE15Mg4rprbtRG9ZLTasNZHI1p2fyGVh29BJDbX0bUfwo+HX0jxu6OPy?=
 =?us-ascii?Q?FuaP31bWvz6YWN/3NIkMzjDj6p8R/61hlP+LdgBir9hRdGM80jWm3+wGIE8G?=
 =?us-ascii?Q?lYxcJ1fwSu8W6GFEnpcZwpO0fm1SBE81vRkG/FFkimJw1YCHpINXaFq+E93Y?=
 =?us-ascii?Q?3n4fQIDvxBMNFCR8VKoPR3QPq+EDYRi6XVKyy0v66ojQUls2sJuKkXC+KIOZ?=
 =?us-ascii?Q?8wAYYgbibU7gc3tdRIJr0dqifdibHCWvGimNyLOu5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dLyOiXXeZBOzy+ld5CtH7CtzS0ZKBZoh37nnk9F36r21y2mh+fjNqhn4CoT?=
 =?us-ascii?Q?YatRY7kJcJeAB89Z7gF11+nBnPFMx/wQA/3naO3IXfG49Xhe11CgTtvIliM4?=
 =?us-ascii?Q?lmg1srARAgNcq/pH2SsBO94uoy4G4dChTwR/1inUh1KtoEFqfkGNfOK36nLG?=
 =?us-ascii?Q?LPqNmHHRZhd1C4EHYWpGVtyJfMWfM9a4v13tEq8EAw1qhDmXSoV6v/XGND5m?=
 =?us-ascii?Q?IP7gk3veEEbe/KtjVYaYXXz/oyUGiPqq03t55TX5hE2RCXlBO8zyP4K/gyPE?=
 =?us-ascii?Q?lpT0Kgeu03E1Bg0+A1C7AJOVpnwHSolfNnSFO/5+XY3RzN2oZzdR9MMQJjBJ?=
 =?us-ascii?Q?ppPfVlOEPu8x8krKQ9pVDzWhcbEHnAz0+45bUIZBMatwFSMmB6bASb49zQde?=
 =?us-ascii?Q?LbTOuD1S9sassWpNh5iVZzwjY9nF8irU17PE+E6JstKIt7lBCHWRb5R24mDw?=
 =?us-ascii?Q?kxSQ9d4LKTg7VaOfxSPeE4t9PtDcuMdYi/SdPdFK/AfdBRSId6kJjAGfnF7V?=
 =?us-ascii?Q?NwhdAnVKP9oL92CSGBhM8ylXa1j4wEXpwuobIVhZxPd3d1k8wgrekUzVlT1S?=
 =?us-ascii?Q?sPBFsMLrsEuCqNAm0QguFwNN5SwY0nti93brdKRsIW2REVbBMLSaEVycHuc1?=
 =?us-ascii?Q?vue9IvXesfaxa/hnIRGQe+cl2bdGSbYgzMlFv64n4ZHeTmTo0Gt1cJ0YbkIJ?=
 =?us-ascii?Q?vDGExmwo9+rMCPRGGdq7OTSKl9OWTfzwD6JGtHk2va/Yf1+5KkmgWNwxoA0o?=
 =?us-ascii?Q?ixAF9NMNId2yEEJXTdCxQDt00Sr2ONR7a27IIwCulwsOneSaqUOW0w2ygjNl?=
 =?us-ascii?Q?gflCMtUO+pdrwwmqfZnw8Gqmy1/AT6clqmYYBoP6zyrwTgwjVS6o16m/NX7Q?=
 =?us-ascii?Q?VHAFkCt7THInwEtA2jUYdqpFBa/pauw7v8p79pprNealJaKhf2SjmIuJmN7I?=
 =?us-ascii?Q?06xzetoVc2C4jjUZj/egqM8Jl6O7oICLGqT4qETdEeSLulACP5rM5EPFKdx0?=
 =?us-ascii?Q?WIWBPABFBJynJ6wbALgVeEhfwEb9SwSqo6JsKp6mGkJt7kO+YoRdSZD88do+?=
 =?us-ascii?Q?OIIXsvkJ2D33NW+aLRIRc6+vVgd8A7zfDTwJ3p4JakWDZsL63r8V5Zmf/MtJ?=
 =?us-ascii?Q?d7DbzH3SQVUqU08NEoGgsY7WDSjXAgy9zniejtsI3tDZqdiRUam0v/Axohl5?=
 =?us-ascii?Q?6XlJWONOu8P4eggQE67dQ9AdS9k2wa/cDD9/GRHkes5Lwv/ip2R4TXcC0Ojt?=
 =?us-ascii?Q?ufIWQsivf3Wj50z5eDMMM87Zjn9v3prDDB7eNfoDZUCTBG0wo/FlYFUpcFo0?=
 =?us-ascii?Q?Vnf3/kCARE2TWSQVLlRUsxndlT8QMAgg0p8zsKKSTFXLcrRoCNnh6j63RuZv?=
 =?us-ascii?Q?5XIW8KjJpyaYJFOVMh0ChbjzK+25ZPPHaeR3hAYKHCw1VXrJqn4gOYC0sw+i?=
 =?us-ascii?Q?t86TZPIz6G6lrgwd4f2N8ZiR9ASQcTKv75nkabsX7YDyL06uX4Q8Hy4m6tap?=
 =?us-ascii?Q?HOEg2TTLucDRLXCuBDLucg0pX0XC5QTRFddeqhbdFe5trYRsHmBQ85sQyrgi?=
 =?us-ascii?Q?lA4q0j0zmcvTxqHtjWLXKBZUwl0BbDaZfI/uWuyyBRBPDN+VcpkFB7I7GtOm?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 105b7ecb-e540-4e0c-cc17-08dc7c19ecdd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 17:49:57.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVB2RZd5zLFXgBgxbDvaF/nUbIgyU2RdJ1Oel19KHlTclyatBli6VFEeYlLRtwRh6oaV+jW9yFPav+GQ3j/jAgX/0OcrQwvXoGtJ9XQU8Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > > So should the text say anything about decoder address vs (SRAT / HMAT addressing)
> > > Maybe reasonable to say it's contained and aligned so modulo maths works?
> > > This is a bit odd as HMAT wouldn't typically provide this info, but this addressing
> > > mode already incorporates it sort of...  
> > 
> > SRAT portrays capacity, HMAT portrays cache and address organization.
> > There is no need for bringing CXL decoder concepts into the HMAT.
> 
> Absolutely - avoid any reference to decoders and we are fine.

Well no, because the implications of this addressing mode relative to
CXL decoder settings is the whole reason why "we", Linux CXL community,
are motivated to submit a code-first ECN proposal to explicitly
advertise this addressing mode. The Linux CXL subsystem needs to know
about this addressing mode because of the mismatch between endpoint
decoders and SPA ranges relative to endpoint HPA decode ranges.

Will try to make this point clear because I do not to see a path to
describe the motivation for this ECN without talking about the CXL
problem.

