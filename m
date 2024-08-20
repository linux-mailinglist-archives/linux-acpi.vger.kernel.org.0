Return-Path: <linux-acpi+bounces-7712-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81815958564
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 13:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D6281309
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF618DF71;
	Tue, 20 Aug 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKe8aUoW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CE18D62F;
	Tue, 20 Aug 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152004; cv=fail; b=p4v/YSxupnLpuz+wTnugbePExENhe6DUpLVI0rjFNrVaytzFvbyL9okTTb7XNrUzcG0xcbjapgJHwa4IkYN5zUS7fHpHQlVgGfkvNUAlELIlu437dE5I98dVRCRiiEZ1DFaBwOgXMt4t4B98Kg81OQ62Df6sHIXVpC7WvaF1JhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152004; c=relaxed/simple;
	bh=jcbeFXgBB4Uy95y3yCv1pY7FCKSwNgx1HhyIcIS4/o4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxwlECDYYDi+TqHbXz8Zem9A+Szdf86UXokORQTtm863HdcL1ADjQsNaWQBbab12Di9A19N+gw85YzSJ/jyrVMaVUwP6XB+HxxV+w1zomyZpI0rRMQ136o0v/hXpwrjGxPvRGt6YbYhcjyG3IVuC4W9/hTiz6lm9MoQxG/aDblA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKe8aUoW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724152003; x=1755688003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jcbeFXgBB4Uy95y3yCv1pY7FCKSwNgx1HhyIcIS4/o4=;
  b=GKe8aUoW5KIfCN/FytDkUmhLUT2XrllUq6Ha4L8Vqw6Ek+rC1zEKemAu
   kHtKwNdtAQuvCCbZpdjMFlwzg0s6/Dk/CtHw3VD3ygBT982QvcUVygAAM
   xYva5baQzaKFGLzLJuYJiGK2bO4vyLbp4TGX79EbXoLvHFpQ7Ncl65Vd4
   TE47WryOI0+Ya+3VqOrh9cutGv3dacqOu/VP5ePbJSeHILvSMbnbSykHp
   6ffHPYlBBDO7sTIP1X61CGsoDFZH2g3equQuprDOBSn5Me0Mb7qUa4OdA
   OpHmEZ52z00xY8URWxOtRjcKn5mgSlOvCgBcTRaYD+3zNU/GP8s3YxdQz
   w==;
X-CSE-ConnectionGUID: 7y0QKnDgTpKtI1XjD0zAmw==
X-CSE-MsgGUID: 98YJmaiLSfCaPa9UZaLiUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22250554"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22250554"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:06:42 -0700
X-CSE-ConnectionGUID: tdPIM7sIQyeFirretxm2Ng==
X-CSE-MsgGUID: OGBPYlpiTsisgRLY6wFR0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="61242667"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 04:06:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:06:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 04:06:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 04:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3SK93rF0K27Qs9qopg8u4FCqTJmdtHfI/Uh08pHQm65DlWAviY+0cVi5HMdfOwxQfAom5o4ZS52+VPmU0y7ToWm9ztnBXG7RIIGL2gA6HUlFPTLLEhaCUO+5FB5dk/GyOB7i+1N21iKj1ZREJoPAdeqO4S2x7E9dMJP9BHZ0vVlsNTnz9omj8kXrWTd+xFc09RYIma8R5VUFsmegVBLpQr6hMHqmwg0AhBtTHKvLoHPff2/c3ZS9gjPbjgwMgxPnS+RH7+2sXM5l58y9JuDNLeK3yu9pw22MYx1eop23qQOb8wZuxaJHgs+LOJnWS4y/yL4yvTgeXBzJk9C4n6oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcbeFXgBB4Uy95y3yCv1pY7FCKSwNgx1HhyIcIS4/o4=;
 b=YK/Z5RBGE/Xs0t/BnjTSxfvCLieCeStfCrYmcVQHyRxqm5Ve05c2fk3Qahv9q7Jmn8SOeT7P/wIzCdEILjv4oBbufHkyx3lVqFHR2r949fpTbOYcdY2cCk/WFxX0N27UsK+nfgxwAd3zvNbVIQampJnf9CbZLd0fq9KMprFgrXpm1VEAZFgSLHELADwBDPGCzJjwmu1xfl1fmjPkalk/ajklO9jjE2lbS6A5/3vmqq5dZh7FF7XjgfNqEhYf1eGlFJHHOr8H6QhA2lHomS5qsO/X7awVa00RrwFWadU+EeW9IpIVykXSBctS99wKop7/frxri9f2puPP4ho4rSmTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 11:06:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 11:06:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "ardb@kernel.org" <ardb@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "bhe@redhat.com" <bhe@redhat.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Topic: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Index: AQHa8gaplxIQHt1FDUe8BCwalB/rOLIuboSAgAALTQCAAAvBAIABaZEAgAAO1YA=
Date: Tue, 20 Aug 2024 11:06:34 +0000
Message-ID: <6464ab0f43f51f4526666f8924921262e8144027.camel@intel.com>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
	 <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
	 <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>
	 <hr7kym77uhbtj32eymcdp5mcbpid7euoiiszhx6yhkrbw5riag@lcozqjayilbo>
	 <d97a17a53cb7550134ec521e3d22177d6a6ad05e.camel@intel.com>
	 <jzqh5j4w4w23xuigqj5bggbmx2hgte4u5tvbss3hqi3vjeodhl@rnmirwt6biol>
In-Reply-To: <jzqh5j4w4w23xuigqj5bggbmx2hgte4u5tvbss3hqi3vjeodhl@rnmirwt6biol>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8361:EE_
x-ms-office365-filtering-correlation-id: 0bb5ed5b-e8be-41e4-c5f6-08dcc1082727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bTFkKzh1d2I3bEpKZmxGR0l2aERNd05KWm1xTHF4ZTJ5OUEyVFVsNlRSWDEx?=
 =?utf-8?B?RVhSZHFHUW96M2JKV2dyVDY0bXRpM1N0bjFiWTlOb1UrWThZZk1TaUZCMm5C?=
 =?utf-8?B?cm5Dc09zYVpsVzNmTGRPN2MwczB3b2tnaWFPWmZaWmJTUm56MGNsR3FIQjNa?=
 =?utf-8?B?MVZhUUtmYTFGbGdRY0xCYkVCM2w2R1Y3RDUrVkZINHZTUjU2K0RZa2E5amFO?=
 =?utf-8?B?ZCtIUldPNHVxUFd0RFpwYk5xK2J3K2VmVTlZOXFqZHQ2dFQwRzZEYlNBS0h6?=
 =?utf-8?B?ZTI4ZWk1NlJRbms0YVdqWmRwbGdnL1pmWWFTVElYZ0FvaGJoVTA2cHJUUitp?=
 =?utf-8?B?V2xiYnl4WmhJNnVheHlhMnFQU1hNWHROaGlSQnpuYnV6MDc5V2FWTURGcjNl?=
 =?utf-8?B?dkQ1d3VubUMrdmh2MXl2Mkh3TW9wTE0waWJLOU5XN3BpLy96R2JnUitYcVg3?=
 =?utf-8?B?U2ZsVmxuejRRZll1YTdqQUNvZmZma0dObG0zVWUrYVlUbUFaaHNyWDdsT2tW?=
 =?utf-8?B?TXZ4U0Z0c1BSUVZLZk0vU3Bza2lPZTNqNHh1cUlIUUNzUHZXeG1XbElNSDZ4?=
 =?utf-8?B?L1hBN0xxZXpvYk80L2RRL21NQkkrdk5wU2xuTnhoMXZrMEhEckNXTk5TcHFD?=
 =?utf-8?B?QlYwc1Z0M3poTUNuSzY2RWlBVG05ci9BTnFEeVJ5UGNXdkZGRmJNN0x4M2w3?=
 =?utf-8?B?OThJODFYWG10Q2dpNXlHNzZwM0RXVFdQZHkxZmhkMXBVcHRNUFBPRFhRc1ZX?=
 =?utf-8?B?bkNHSHFZMzVHWWVyRC9NdlBtOE1LRThha3RvdE1qakUxRzVES1huNW9zZG10?=
 =?utf-8?B?QUpCYjlGYlgzQlZGdFU5TkEydWdITEFXSmxocTJid3hqQktLVlFqeUllRmQx?=
 =?utf-8?B?TmlZV08rRjdJbGEzNUhFVk01S3U3TmFEVGJ6QVBkYllZcmlWOVJsV1Z2WmVn?=
 =?utf-8?B?a2xhd2l3SmRHeVY5RHBhcVA3TzExbzVmSmpIb0Y5S3krUDBwWkpyV1VKWjRx?=
 =?utf-8?B?bmd4T1Z0QXRjRy90czZuUloxQWcwWXU4UUlCTlp1Y0pOMk01d2ZqV2pzTGVG?=
 =?utf-8?B?bDlhbVovRGZUZW1XUnN2R1JEZDNzZHhWUUpEMzRrb0ZZR2p4dE5KdHg0b2FG?=
 =?utf-8?B?c2ppV3BvYjMvT2Jyc0UyOW9UVzVxcmJGVzZZNUhoN3RPYW02d1E2SG1GekdV?=
 =?utf-8?B?S2YrbnVwT2JLdWdud0JvVnRqa21WS1VJQmFJL01XV2RvbHoxQW52U2hwaHcx?=
 =?utf-8?B?VXh3T1ZZQjZjdUlNemlTdDIxSUlVemx5SlkyTDRVbUVMd3NrMHhuYkR5aG9O?=
 =?utf-8?B?MkxZK3Z2enRJcXA1bUFqQkJqTlVzck1DMUZpUC9wMTl5MXZRUGU1YndvcGMv?=
 =?utf-8?B?SnFwTFhTNTd4dk9YaXVlVllGNHpwMFNBVWNWWnhIREd0MU5DSjhsZ3FyTFR6?=
 =?utf-8?B?OFJUYmRQcHhSby8yLzRBWHJwdFA1MEMzalIwOTF0WFRHalBwUFo4aEoyWGFs?=
 =?utf-8?B?bERZMURKRFZNRGJyT2ZRVTNSR3NtZzNhU0ZDT0Y4d1QreTk0MU1JU2FvZGZY?=
 =?utf-8?B?ZFl3bHVsN0lLTDNOUkVWeXplRTl2QzNqYTdFY1hmUFRjWG1OWU9kR2pWUWJx?=
 =?utf-8?B?WStuSnhYRzN2VEQ0U1pxT1RJeGNqL1NSaHZJVEJUSTBWS3RxK0hranRXbFpZ?=
 =?utf-8?B?eTV6Z05DRGxNeElJUGEvTFRqU0JqYVppaDc2MTYwZExvVlIrZDlCam55Qmdm?=
 =?utf-8?B?cEQwdzZiUFc2OXJtaVZJRldTaXFMTDg4WHU2bGJQejNBRHZFZ21OR0hYMDlm?=
 =?utf-8?B?QWMwQ1Byamd6K05qUzh4aTR4bjA0Z2FiYjgxaVZ5Nllnc0g5K2QwT3ByeTha?=
 =?utf-8?B?Y2g0SFo5RWlOTzFESHE1TDhNT3Z6YkE2OHQzTk1kNVBZNGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXdpTmJRd1lYQ3A1U2JjOWtQcW5tWGQ4bDdDYUVTeWpYa3dIWDhja2lCMERB?=
 =?utf-8?B?NXUxenJNYm8vc2hGS1NQenU2amVDd2xsMkhiTEl0bjhmS2lQNGhUQTRTWUdO?=
 =?utf-8?B?RDRFaHBoYUhlRS9YL2pYMkhLZ2lhZm9Ya2NtTXNoNGZrNC8yUWk0YitXaEtj?=
 =?utf-8?B?OW84ejNHdTQwMy9TVjZNanBpTEJKQUt1UEhuV3UwZWFQTVVobFZBU3M3dlhw?=
 =?utf-8?B?T1MvS2pMODVlcGpmeDRVV25TaDNkUWNkVkFuWnZjS1lZSDYzR2d0OU9mY0ZU?=
 =?utf-8?B?TVdUazBpZUMvcU5RaGVEOWxXejJhc3pZMFIxTlhURmxDTkRjNUxrNGx1UzFh?=
 =?utf-8?B?ZWViNXhCTk9JNGhsakdXbGhUOVIrRFQ1VE1aZjJMVlNEb0o0Y0xGT1RpVkxh?=
 =?utf-8?B?Uk0rKzhsdzIrdUYzYTJNSXZxaWhNVSs1NWFibFN6TU1kWjdOcnNDZjFxRUt0?=
 =?utf-8?B?aU1NcFEzR0F4T2R2TGRaSXlFSkYzVm51SXJPc2ZxZCtzOVJFSzZSeXFqcC9n?=
 =?utf-8?B?dlY5U3JVVG5HZEIvcmRDdExsLzVrYTBSRVd1aUtrdjQ1QzRxUlZVbnh5NkxO?=
 =?utf-8?B?S20yRmFWSWJVVjBQZXI3WWY5aGFCVmtWNGZqN3pvMGE0bHJDVlJ1anMyc2Rw?=
 =?utf-8?B?YnJ3c0Y1NXZxRmhpS1FCMXFQOW9YZjYxVittQTNTSDJHTU9oMThyczNkUUFB?=
 =?utf-8?B?ZzlvYklSOXlLMjNQeGVJbk5qbU5MVno0SFR2UDFCbkxyZFZ3eTg0OUxtUmhV?=
 =?utf-8?B?OEx1VDArYk5ubWtqTFN5UE9sVFREM0lSMllUM05oU1ZPS2EvODJjL2ErOHZu?=
 =?utf-8?B?UzVBY3dkcDA0Y1RVTVRrVWd1VWloK0NWVUZ1QlI5OE5zRTNaQ1lYeTVhVzBB?=
 =?utf-8?B?ejhqcHRUS2FBUm4yUkpWM3lQb24wMC9yK21iL3dNUUc5MHdoWlNmRHdFN2hG?=
 =?utf-8?B?SjhRQ053YURJMGlKTWVnWkhMRVRSNzJBdUFkNWR0UllSS2hYWncwNmwxa2xw?=
 =?utf-8?B?WGdsTkVQNG5WdTZZSFZmR1hWKzNzL2ZjQlJnM0g1b1dnbmtBK212N2QwbHF4?=
 =?utf-8?B?RFhtUm9VL21YTFJETkpxbUdPOG1nTTFHMHExb3dNY1dOekRscEdIU21QL2Nu?=
 =?utf-8?B?YzErdzJEajQyZCt4WHEwdG83MEx5S05JQ0labWIvN1FySSt1Wi9iMlpkOWZs?=
 =?utf-8?B?TytDZlUrLzh3d0FiZmtmR2FYUjdiUjQvVjZpb0NEYkNtNnovVUlQSmw2djIz?=
 =?utf-8?B?aDZWMDdvNXRPUUNsbzhPNE5CMlBjVVpNeXRoSW44VWNqVVVQcjBaeVFRazV3?=
 =?utf-8?B?N3BqZzZlWjl1dml2eGpMdjJ0YlFxVS9Ic0xKdlVpZE9WWGRvaDhuNk5jMWQ0?=
 =?utf-8?B?TFJqWWJqbVBMeXl4NmtrQTFGbVM3bGMzVmFMRUc0S2Q5NHQwQzFCL1F4U2Mr?=
 =?utf-8?B?WmhJbUJxWFgxUklxS1ZjUHdwLzAyVFdNWFlwZ2c5amVIVHJoWWk3MnJQdXRI?=
 =?utf-8?B?RnJsZ3NoZ25SZ1FLd0FYblRDaU9scFAvc0krejZ6WGtJUTF5K01zcnFYWnhD?=
 =?utf-8?B?dFVZbFhhY0VDSVFTMzJPalZnYUpFNXg2bm50bXRWcEFzT3NxNkZtWVBNSHcw?=
 =?utf-8?B?RjRWRm54T1RXbFpyVjFMS0V4NlNIQlltcC9ZVm1EQkZNU1JUR2J3SGVFTmVp?=
 =?utf-8?B?V1NDbUswSVVZcTFaNHREdFcvc2ZnQ2hXRSt2ejVESW5HSmhCVW4rSWdPSkI5?=
 =?utf-8?B?VHRXNXFLR0lVcFFZMU1Ia0JBS0NGbi90SlZBN0FNV1JKMmpvMVF2OXc0UElE?=
 =?utf-8?B?T21SWXZ0WTRONWxuNnoyZjdRU1kxbThnd0lRa0ZhMDBXVkUxdG5nM3FISmN1?=
 =?utf-8?B?YzhSTTJNOW82d2dTR2hUNjhiYmJRenBxZzVnenRvbkFIYkdyTGNiemQrZEpP?=
 =?utf-8?B?RXlzR1ZHZHEzOVlvcHhpSktIT1JsbWRtaHNPS2VSUzBma2JRakc0UEZlbWVa?=
 =?utf-8?B?bUh0WWFZK0NFRzlha2FJQ2dScXdFWmF0eGFjY3R3cXdGeXQ1S2JsU3JXWkEz?=
 =?utf-8?B?N0MyTWNGRlZMR01OTitNNmhaamdra2hXK3lhTmVUVWhoL1FvYmZKZkR3ZjRO?=
 =?utf-8?B?d0RzSWlKWDVxeUtaVkZTZmMyOHpQQjFTR0tPOUpEdDU1MFdHVms2Z2ZBZGdm?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDF7416C8165A445AA0FBF038B03F913@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb5ed5b-e8be-41e4-c5f6-08dcc1082727
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 11:06:34.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: re/WYs9a30d3CVnZluQeyd1cr5JBQqUiiLiYAh0SkyEsyhFSt20wbiVCQpNdNutxhAkz0Xgy6chZMMdFNI4zrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com

PiA+IA0KPiA+IFNvIHRoZSAoKikgY2FuIGFjdHVhbGx5IGFjY2VzcyB0byB0aGUgY29udHJvbCBw
YWdlIElJVUMuDQo+ID4gDQo+ID4gTm93IGlmIHdlIGNoYW5nZSB0byBtYXAgVkEgb2YgcmVsb2Nh
dGVfa2VybmVsKCkgdG8gdGhlIG9yaWdpbmFsIG9uZSwgdGhlbiAoKikNCj4gPiB3b24ndCBiZSBh
YmxlIHRvIGFjY2VzcyB0aGUgY29udHJvbCBwYWdlLg0KPiANCj4gTm8sIGl0IHN0aWxsIHdpbGwg
YmUgYWJsZSB0byBhY2Nlc3MgY29udHJvbCBwYWdlLg0KPiANCj4gU28gd2UgY2FsbCByZWxvY2F0
ZV9rZXJuZWwoKSBpbiBub3JtYWwga2VybmVsIHRleHQgKHdpdGhpbg0KPiBfX1NUQVJUX0tFUk5F
TF9tYXApLg0KPiANCj4gcmVsb2NhdGVfa2VybmVsKCkgc3dpdGNoZXMgdG8gaWRlbnRpdHkgbWFw
cGluZywgVkEgaXMgc3RpbGwgdGhlIHNhbWUuDQo+IA0KPiByZWxvY2F0ZV9rZXJuZWwoKSBqdW1w
cyB0byBpZGVudGl0eV9tYXBwZWQoKSBpbiB0aGUgY29udHJvbCBwYWdlOg0KPiANCj4gDQo+IAkv
Kg0KPiAJICogZ2V0IHBoeXNpY2FsIGFkZHJlc3Mgb2YgY29udHJvbCBwYWdlIG5vdw0KPiAJICog
dGhpcyBpcyBpbXBvc3NpYmxlIGFmdGVyIHBhZ2UgdGFibGUgc3dpdGNoDQo+IAkgKi8NCj4gCW1v
dnEJUFRSKFBBX0NPTlRST0xfUEFHRSkoJXJzaSksICVyOA0KPiANCj4gCS4uLg0KPiANCj4gCS8q
IGp1bXAgdG8gaWRlbnRpdHkgbWFwcGVkIHBhZ2UgKi8NCj4gCWFkZHEJJChpZGVudGl0eV9tYXBw
ZWQgLSByZWxvY2F0ZV9rZXJuZWwpLCAlcjgNCj4gCXB1c2hxCSVyOA0KPiAJQU5OT1RBVEVfVU5S
RVRfU0FGRQ0KPiAJcmV0DQo+IA0KPiBUaGUgQUREUSBmaW5kcyBvZmZzZXQgb2YgaWRlbnRpdHlf
bWFwcGVkKCkgaW4gdGhlIGNvbnRyb2wgcGFnZS4NCj4gDQo+IGlkZW50aXR5X21hcHBpbmcoKSBm
aW5kcyBzdGFydCBvZiB0aGUgY29udHJvbCBwYWdlIGZyb20gKnJlbGF0aXZlKg0KPiBwb3NpdGlv
biBvZiByZWxvY2F0ZV9wYWdlKCkgdG8gdGhlIGN1cnJlbnQgUklQIGluIHRoZSBjb250cm9sIHBh
Z2U6DQo+IA0KPiAJbGVhcQlyZWxvY2F0ZV9rZXJuZWwoJXJpcCksICVyOA0KPiANCj4gSXQgbG9v
a3MgbGlrZSB0aGlzIGluIG15IGtlcm5lbCBiaW5hcnk6DQo+IA0KPiAJbGVhICAgIC0weGZhKCVy
aXApLCVyOA0KDQpBaCBJIHNlZS4gIEkgbWlzc2VkIHRoZSAqcmVsYXRpdmUqIGFkZHJlc3Npbmcu
IDotKQ0KDQo+IA0KPiBXaGF0IFBBIGlzIG1hcHBlZCBhdCB0aGUgbm9ybWFsIGtlcm5lbCB0ZXh0
IFZBIG9mIHJlbG9jYXRlX2tlcm5lbCgpIG1ha2VzDQo+IHplcm8gYWZmZWN0IHRvIHRoZSBjYWxj
dWxhdGlvbi4NCg0KWWVhaC4NCg0KPiANCj4gRG9lcyBpdCBtYWtlIHNlbnNlPw0KPiANCg0KWWVz
LiAgVGhhbmtzIGZvciBleHBsYW5hdGlvbi4NCg0KQXQgbGF0ZXIgdGltZToNCg0KICAgICAgICBj
YWxsICAgIHN3YXBfcGFnZXMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCiAgICAgICAgbW92cSAgICAkdmlydHVhbF9tYXBwZWQsICVyYXggIAk8LS0t
LSAoMSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgIHB1c2hxICAgJXJheA0K
ICAgICAgICBBTk5PVEFURV9VTlJFVF9TQUZFDQogICAgICAgIHJldCAgCQkJCTwtLS0tICgyKQ0K
DQooMSkgd2lsbCBsb2FkIHRoZSBWQSB3aGljaCBoYXMgX19TVEFSVF9LRVJORUxfbWFwIHRvICVy
YXgsIGFuZCBhZnRlciAoMikgdGhlDQprZXJuZWwgd2lsbCBydW4gYXQgVkEgb2YgdGhlIG9yaWdp
bmFsIHJlbG9jYXRlX2tlcm5lbCgpIHdoaWNoIG1hcHMgdG8gdGhlIFBBDQpvZiB0aGUgb3JpZ2lu
YWwgcmVsY29hdGVfa2VybmVsKCkuICBCdXQgSSB0aGluayB0aGUgbWVtb3J5IHBhZ2Ugb2YgdGhl
DQpvcmlnaW5hbCByZWxvY2F0ZV9rZXJuZWwoKSB3b24ndCBnZXQgY29ycnVwdGVkIGFmdGVyIHJl
dHVybmluZyBmcm9tIHRoZSBzZWNvbmQNCmtlcm5lbCwgc28gc2hvdWxkIGJlIHNhZmUgdG8gdXNl
Pw0K

