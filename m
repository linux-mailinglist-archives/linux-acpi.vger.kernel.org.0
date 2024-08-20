Return-Path: <linux-acpi+bounces-7715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E433095862A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CA1B25492
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0C18E75E;
	Tue, 20 Aug 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ol4GAoHW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0F18CC0E;
	Tue, 20 Aug 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154814; cv=fail; b=EF2bYky6p5zlC8/q73b4UUbzlye7eS8x/nMREtEJhb/1MU0+z1Kq9a9HwGPnaAQeYAwyI8du50KMH0se0EKBBPvpu33j7yFb6t7rM/RSbPY6V+MTMXBz3qfk1kfhbl2d7WCOhptt8It0k3tvmS8VZQbYWH1lygk9zN7U7L0nwhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154814; c=relaxed/simple;
	bh=gP/rjt7Kijk42yT7X0XGSD02QzkkQlYNV2xGgfIM3Lk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YSG6dWD3tIzAXlVx0a3tuk/4CLG+6BuCkmNirUraT6OmpPV/nATxlZTuGwVOgm1VYTHwtJwx+C1RWGX23RkQXtYGk1LwmGnM3G+xE8PQk65zyb2YJPdJDLo0z0C3suH+N7HI9HhcPrkIj0CM4EUBQfB+zLd00x7GwpC4Oxkwerw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ol4GAoHW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724154810; x=1755690810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gP/rjt7Kijk42yT7X0XGSD02QzkkQlYNV2xGgfIM3Lk=;
  b=Ol4GAoHWRb2mGyizzb0QxkYG4lauxkhx+OeI+30DmTkgznNLDU4wf3Dc
   fQVMbX352Ooq7B2NN5a2UiUpEC12+Nc9aJaY5fAa3LZoXRlfYauUGS/Jb
   swj5ZpYT/zC80MHTthmMQeNdNQwQkgcg3WduWOLwD/qwTbPKId9Cfc+7L
   HSMHOxD+fdzPOv16vTYhkuH1cDZFbczEUn8cGhsCXdfz4QheGmxU2E89N
   k21tXkHIZZzY1kI53pSQ+LtkcBKZUm0qKhQdARUfEt5D6SNTQMOTjeF9L
   nGpsBL95QtQliBGpQGOFnAv+nkHbyz1v+776Z/HS+M4B7v0T8rFtbKirI
   w==;
X-CSE-ConnectionGUID: 2z6RCo/KSfyaOE1eDRgc4Q==
X-CSE-MsgGUID: aqqrgoNqQC6NT7Aa/aQ6+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="44972425"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="44972425"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:53:29 -0700
X-CSE-ConnectionGUID: roXPP1P8SWqKDtUAUx8g9Q==
X-CSE-MsgGUID: eBrtH4PES0atFLHqt3p9iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="91427734"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 04:53:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:53:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:53:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 04:53:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 04:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkGQJ/2Y977J531yz5unZ5MkV5DC8sLl3WrMFxyXhYBhDu+0mxa1CYgD7Fs2x3SN2ed/UiQshEhGejbYYqegkX5zHQAhhOxQQZSICtVqDA99uPsBkLbRWgez4qImJEIvubLO13opPnz/ZOXJQqQ525hBVn84qCEjsfxvglzjyysasgJTWybEVoFvWyUQG5QYgfdxAY8pTblt8Xrf7KBjPYct7f5wAxDmQROtWdfXua8Cef3NOvmP5z4lywgwSpd/qd9TEBn3DK2sR53pJtg8XFVd0XYBvsXNUCxCqe+2ZptubIuYfJ1gdnPajK7po2jK1dR5tayzlmdSjLh+zSoZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP/rjt7Kijk42yT7X0XGSD02QzkkQlYNV2xGgfIM3Lk=;
 b=II3KjqFSYGUTeOp5tQYeWBnlHww6tdYrE/w58DAHdDZgwtUQfSdkPfYHquX+89nSf8l9UX/S7s7rS+6BGT6TEQfcqJsSfpb2yZ5pfU07jiAkg/4PdEnwE6WDqWBDDHz0j5pOju6SbEO0RCs6MY/Xhf2A++J5GE6gsiE9uXpmRpXkwoO65jY03/nQDULBQ7PXiEI/F9HZrsvBFJHqPjuRcj6NBLeZX3OdnaYJyX9P1/HwNvDrB2MAzZvzSfTv8Or2aAwWE99IwJpz5RxZDPkcR24MrQGf64l/uU8hxrJzEN3yxNvAwH1aFRwUV/D9M1PgobZgprN2oAbDpJGZpNuG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 11:53:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 11:53:27 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "luto@kernel.org" <luto@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bhe@redhat.com" <bhe@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCHv3 4/4] x86/64/kexec: Rewrite init_transition_pgtable()
 with kernel_ident_mapping_init()
Thread-Topic: [PATCHv3 4/4] x86/64/kexec: Rewrite init_transition_pgtable()
 with kernel_ident_mapping_init()
Thread-Index: AQHa8ga8L1xqRZNptkeofJU19+A9ebIwCxEA
Date: Tue, 20 Aug 2024 11:53:27 +0000
Message-ID: <9138b3b3c792b599ec9840adebcf736394236842.camel@intel.com>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
	 <20240819070827.3620020-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240819070827.3620020-5-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL3PR11MB6363:EE_
x-ms-office365-filtering-correlation-id: 716ddb9d-b6f0-4535-fda0-08dcc10eb3eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dG9mSVMzTjRuNVNWZnlYOVQrc0U0LzRZbUNKeFBsYlNlTlQ2czA2cmlxclZG?=
 =?utf-8?B?bjVMMUlKOHZlVURnKzEzSGREQzA1SThrQ0k0a3VsUis5UnUvT1BoWjB1UG5V?=
 =?utf-8?B?Z1VwWjFVdXpPRGwvbGdDcVRKM1hJNEVBUEtwVm04L2RJQ3R2YWd5OTZWVmpa?=
 =?utf-8?B?QXRTY25IaDd2TjEvcGtFM2VQNElWUnM1ck9Ib2w3azNGTkZnRVR1M2dnM1lC?=
 =?utf-8?B?T2MvVngwV0dsOWxhZE15ZGdYc1N1R20vRjF2WHdEcnlEOUVvUGZzS1Nzc3NC?=
 =?utf-8?B?amk3czJiOFJBeVZoSm9jUEhYb2hGaG14ODZucDZwZi9OOXkwR2JvOUVrRUpZ?=
 =?utf-8?B?M2FYbGVKV2ZRUEdjU0ZrWGQ3L3Ixb2RRNTRway9yeEVqMFZmSzZCMEMxOWdH?=
 =?utf-8?B?TnBKUmZXdEFUN2lxNzhYbVlIOFRYR1hLTXdtSUhGMllLV3plUFdGcmt1T0xC?=
 =?utf-8?B?Q2l4UE1udlh0dlEvcnJzRmNCM3RuOFhHUlZhalpEMitCZGpwMHJ5OHN6Mnlh?=
 =?utf-8?B?SUovMFhFZnpSVTcwaWR6STJ0ZmdkNEZFYlZuZEoxSEhZYmV6UUh5dERLMkJr?=
 =?utf-8?B?Nmp5RmdVbjJvVlhnWjlWeGRud1ZEWllIak1OUDl4dXBIbDlCVDBzbkdRckxH?=
 =?utf-8?B?eEJDdVo3ZUlJQ09ib3gvdGJHZWtrMml0ZVBUZWs3alFYZSt4RU1TMHI5TlQ5?=
 =?utf-8?B?b3dNUC85eFpiYzhNZG5Ha09CQXBSSlgyZzNvZ1F2RWZnMkQ5aGZZYzA4OERT?=
 =?utf-8?B?MjF3b3B2eS9CNlRSQytlajR1T3k1ZEMzbk84Nk9PUGJRVzQ4U0JSanRWNVNn?=
 =?utf-8?B?MW0vbTJ1MFhHV25BZG9WVWh3M0dvVG9OWVVHS1lhS0JGbE0rem9YODMzZjJo?=
 =?utf-8?B?SXNBaVVBSms2TWd6NmRuVTNqRThTMnVrbHZhcHoxbzZRa0pTV1ZxWXQxWlMr?=
 =?utf-8?B?RE0vQ09QUElBSU5kQlBDczhsMUw2U1BiblBSOWFRRVVDOHd1YlhkbEU5K09a?=
 =?utf-8?B?TnZmKzlBcHRnc3kxTHBNMThzVjF2Y0VaL3NiUVV3dmNDbUNSelNiQTFCMlRp?=
 =?utf-8?B?bU5iNWpSZ1Jjb0UycnBWNTQ2YTBvK1g3UEl4ZkVoRlM3UEdJaEc2SFc5YkNk?=
 =?utf-8?B?SENEcnF3WW1GK2lHRzdWQ1M1b3ZxeDZJVThxbzR1NlROS3cvTkZwaXJZTVpU?=
 =?utf-8?B?RE9mT01aYWpDMHVSeUdhV1VkSFlIQTd1YndvWGgweThKSFZUU3RmNmhaanM4?=
 =?utf-8?B?NUNSOGFvK2RjM25mOW4veUcySzhVS1ZaSEdRMEVkbmFYLzFwblNiREZRaU04?=
 =?utf-8?B?SVUxSnp5bjkwRzNGbVBJMTJyREFUQml4R1pVQ3o5cDY3MUxLQkxldUhyTnQz?=
 =?utf-8?B?TStKQUtDaFFlM3dadGUwT0hvaVlLWjhMUUp6S3JVOGV0STc5ODVMNW8wRmhX?=
 =?utf-8?B?TVFPM0cxYnZuQndNRktYcFdDcE1kdUhzRndhVVhxME8vMmJiQ3dmaFhMSkN3?=
 =?utf-8?B?cmVEdyt1QVBQVHRRMTRLbDdLa3diZkdXTnVJWDM4TXhrRXJRQldoNmphQWdt?=
 =?utf-8?B?Q1loMWZNdWp3Mmpad29aMXZaRHFTdzNWQTN4UnQ2OTIvSC9GVGI3YzhWdGE3?=
 =?utf-8?B?QVZvSnlnNzMxUjlqSEh3d2krbmtjTzAyMktoV2Y3Q3Z1N09CMWU3Y216ZHMv?=
 =?utf-8?B?eEtXOFpMeTN4NUtVZVVaWTJMY1FrNGJVMFZJVUc1ektiVWRteG1tcWFVUU5y?=
 =?utf-8?B?VFN6QWNERmU4aXoyeFh0ZGlBTkpERXl0R2EybHcyNnNsYlFtSllXeDNGcVZ2?=
 =?utf-8?B?eDVpWWljYkxrS01PL3JhUE1NbVdzY1JuTGNCM2FHVlFuT25vc0JLUWV3bU8x?=
 =?utf-8?B?Q1hINjMxb1pFNWNQUXJqYm8xcmhEbDVWZG44aWw4eHhsZXRUMWdURlhRZnpM?=
 =?utf-8?Q?ToC/+x/BDDU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3ZEYzBqdEtIVnJoOFBlS2krck13S3NrdG1MS21MNkdiWFUrK3dweHdsa2dh?=
 =?utf-8?B?UGJpL0VvVHBBckpsRnZPZDZFNEwyUERsMXJiVmFDVklZTGlTMXRwbUhKbXVG?=
 =?utf-8?B?enpSR2VvL2F2NWZMVGlBUDY2LzdTNTVRQVI4Z2FqY2tuYVZGUEppbThnYTFH?=
 =?utf-8?B?MCtVZFFIc1UwTXhteGNBMHh6MlZsVytYQ0hEZkJPNmZPdy9ZVXdLM1QydlVW?=
 =?utf-8?B?UFdyZlRTUTIwYVVGY0VmNmovanJQS2xIQVJIOEs2aCtCWUdwVCtGRzg4OUlw?=
 =?utf-8?B?OWdKRzVLTS9VMFFmakptSG5TblpFWDByWllQbWpnSE51bmtTcHlLV1JkN3Q3?=
 =?utf-8?B?NjZ1SFlsUG4xWU5JVEdud25aRU5iWWo2bkdBRHA4bjdmbEhiV3ZhWG43TnlG?=
 =?utf-8?B?ZUJTUE41VDVOall4YW9QYUxMV3BESVQwL1F0MWtZQm5veENhU3h2OUZUZFNh?=
 =?utf-8?B?RTRpdnliWmI2S3g4QVN2LzFXdHF6K254QVVwYmdNbktUd0p1SkRRSm85SzlE?=
 =?utf-8?B?WU9aV3BiN1g3NXdmSEttdlo3ZElDOGhQWTQwMnV2aGZmWFdUQ3hRMnNodHY0?=
 =?utf-8?B?WWlJaXlQbGdvRklMNFFaM2Uxd2VlYXdVYVdvVUhKUFlwaGZpRE9hd3dJWjdK?=
 =?utf-8?B?SWVuK2ZjUVlRODd2WERJZTNkWDZzRStyZEllUTdXNFhqN3NuRExlVjBNZlhn?=
 =?utf-8?B?NitWQUVCcDZVTkR1OEYzNlFJRW50cVJraDFIQUtrYjJuSktKanQ5eG4rd1Z6?=
 =?utf-8?B?MFQvZjMxVnJxL0dNU3pXeElzL3JUeFhrQTRMRWNjU0xXSjV3cnB2aTkzOGEy?=
 =?utf-8?B?ZWJpbkVWM0hrN0plejB0TXNPQk1sMkFsOFBOV2h3RDdpK21ma2d6U3p0YWt2?=
 =?utf-8?B?eTJINUJmV1U4SlE0T3FqUlhPZTBaR1NCQmJicVdFT3hBVlRDVXZRSkFSSity?=
 =?utf-8?B?RjVxOGxDM3VTVVpiZm9GUmtnVTM3OGtpSTBXZTBPREpnM3pnU01GVkw4Tkpu?=
 =?utf-8?B?Qm1TelRKS3JVeU0xa3FTMTV1RUxxL0ZQd0lQYjk5WjhBdG5RRjJYdyttREZt?=
 =?utf-8?B?b1hIMVk0cWNleEhDVkU3YWdpUkxwL0gvOGJ4U1l5c0U0eHo2OUxqdHZ4bHZl?=
 =?utf-8?B?Ky80MklnV0NCSi9TQWxVeVpwUDJ3WVhwOVpQcFV5QmNrUC9UTUdheGhCZUs0?=
 =?utf-8?B?Nm93azdmUnNrQnl3Z2JJWjBsZjRCWXJiUHB6VWlUSHo1K2lxalpkQjdTSU1K?=
 =?utf-8?B?bExraGN6U1JlTTdiYkN4ZG94RlVZWmdxZmVsemFHM1JONEhPbWU5RjJ6U0tP?=
 =?utf-8?B?cFE3Y3c2bk1WVGZQaW9HaGpkbmtVczM2MERmUWVkWjN3WU1sSTY2YlpwRDU5?=
 =?utf-8?B?elMyMXlFYkhLWU5pTzZ4RGlrd1VFc3l4WXI4anI3REJWdjZGcFluUTVFdGFO?=
 =?utf-8?B?SFMvL1IydUNuWkF4UythamlGNjVodXpkeWtXZFdlT09RdXo4MEk4dlBoSHpU?=
 =?utf-8?B?L3FpNUdJbWZIZ3c1Qks0SGI1cy81cy9hbHhDK01KdHlvOUMyWE1JV3d1RzdW?=
 =?utf-8?B?YVFxTUxLQklkbENrRFdZejVjQ3Z4RTJjeUx3bkRKeGhlMm1sajBCeHB1c1dq?=
 =?utf-8?B?d0VWbkhaWXFlZnZZUjIvU1JSOGV1QzdVV0pRaitEZ0xXQlRBVjJCbzVxMkRV?=
 =?utf-8?B?bFIvK2puby96dTV1OVlLQmgwZGc1di9mQm1nUlZ1b2NvbWN2SjFQemsrVHVj?=
 =?utf-8?B?NXBVQ1pCanRURTZzNUd4WTRZMGRybEtpWHJHbCtrYmRiT2tiMlJLZ25mR2o3?=
 =?utf-8?B?Z2lyaklMazM0TzFUNzhaQ3RLNUdpRFhwN08wVElwMjRmRTU2VTIxR1o4SEEx?=
 =?utf-8?B?OGZBT0p6bjhPc1piSVQySnJDWmcwYjlzUDhoclU4Q2ZKWFl2TnV1SlpIWksv?=
 =?utf-8?B?R3FPaW55dUlCVnVycjk5dlk4ZHBmRWQ2dkg5WTRENytTRmxNUkc3NnlaMExt?=
 =?utf-8?B?OXQ0aG1KUGpUSVoyaEVYWXJpallSVzNnd2h0cStWOFBZc0RyN080dllLclJQ?=
 =?utf-8?B?WHdwR2paQTUzOUZNRmlzZXVRTXZsQ3NWUjFENzVKQWVna3h1RGFlSHJxU01I?=
 =?utf-8?B?ZTlpd1Z0TllSV1ZDVkxhQkhEZjdHYmRLdDdjRXYvZi9lM1dpUitZSXZNbmFC?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0348FB3B2ACCC42BCA2ED1C5AE3FF3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716ddb9d-b6f0-4535-fda0-08dcc10eb3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 11:53:27.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GHbBVmHGMbyaSPyoKaDyTAY0iSxwPnKzhkUoKk1LPNoWY+xWqPdLXHldsXB2PoXrmsFgdUmIH0hjYxL2136Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDEwOjA4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IGluaXRfdHJhbnNpdGlvbl9wZ3RhYmxlKCkgc2V0cyB1cCB0cmFuc2l0aW9uYWwgcGFn
ZSB0YWJsZXMuIFJld3JpdGUgaXQNCj4gdXNpbmcga2VybmVsX2lkZW50X21hcHBpbmdfaW5pdCgp
IHRvIGF2b2lkIGNvZGUgZHVwbGljYXRpb24uDQo+IA0KPiBDaGFuZ2Ugc3RydWN0IGtpbWFnZV9h
cmNoIHRvIHRyYWNrIGFsbG9jYXRlZCBwYWdlIHRhYmxlcyBhcyBhIGxpc3QsIG5vdA0KPiBsaW5r
aW5nIHRoZW0gdG8gc3BlY2lmaWMgcGFnZSB0YWJsZSBsZXZlbHMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+
DQo+IFJldmlld2VkLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0K
PiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==

