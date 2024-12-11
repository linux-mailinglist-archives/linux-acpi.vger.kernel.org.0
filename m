Return-Path: <linux-acpi+bounces-10076-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49D9EC464
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 06:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C088165620
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 05:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2871C1AB1;
	Wed, 11 Dec 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7QjWOTu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE424A0A;
	Wed, 11 Dec 2024 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895641; cv=fail; b=l7sTGvs0IYTlC08l/VDVGKTL3v4/9NhVfjm1KjGJ1IYeEQEHQW/Z50/fLEQRHo/hxMwCRdVuFl+iBW2G2m9KpbeVXRNR3c36dE6YozAIlt2gqdUIZ4yWKDkNksVNg6vlkBUo3eo1lFlB8wXyC5ICs9bTmOO95scAT8vWFlA41NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895641; c=relaxed/simple;
	bh=L9Rq9iffDexj0ls7CeWWwwDN3tzfA7i8yDpvonStWms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7x6IPkfCPBcfJDqU4XMR7uA7TDjEWpalWftc98KfWLr2W0SvtZoKSjR9eoXgZfu9lNN6LGvMiv9rwZTTwYwLtUnVgKGWhAyHIEAN4YrEVGCoOSvt+cA+eqwJGgIKzgq+MHE3ZGDZ7wOaQpwGv2u0EAGKcqOx+3gu647rSbf2Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7QjWOTu; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733895640; x=1765431640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L9Rq9iffDexj0ls7CeWWwwDN3tzfA7i8yDpvonStWms=;
  b=C7QjWOTuWUauwF6DxDnKwGon8Y6VDUDK5Nr+rdh9AgPX8Xbqo2acnHxu
   f5b0LqqO5E7akNYzf7skcHbdX7ihEdhItFGFfOSB20sK/8f+kw8/vMIUa
   THH78E/5eder4+bcAXa9Ucmg1HqFWUwSSHZ+AO31+v4CoLtZqOAWdWrG6
   J3izizVFIGEB5iAn9y6pzzmsSEqcegwsnPV7xHkg1I49tu+O0yQ5ACNOu
   4deZxe8l4Jw6UtTu0tTokNmQtih08pjit64yLxgjVYmpo46lxBNwLy82j
   /w8rL+EPG8BQlsoNf2i6ZbsJS0HZ1fpS6+9R9T9cV5Fg6wtqjmQc4IHtL
   g==;
X-CSE-ConnectionGUID: fO2K7NgZTumYO0UrvVQfzA==
X-CSE-MsgGUID: ajiS6rZ4TZCDeTgMBojjrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34185366"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34185366"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 21:40:36 -0800
X-CSE-ConnectionGUID: kze6WyXnQLil3gbjwVYj4Q==
X-CSE-MsgGUID: goMqlBcXSa27L7sAZe60Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126591338"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 21:40:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 21:40:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 21:40:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 21:40:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4ClUnxeN93ZGyU9PYNQkzZKTcl3ZL9lCw6axrcrtiG+QL1poy8Wh6aNmja2FF2kzwvu2+tzbrMRpzVHOzv6Jd7xaCgFJWz7MrFIs61UqK+Zf/u8XSQkS5QgBsvvkqa9eQ18owoi1zuacpZlQQXxUsaPNqhA0nqnJkJqdKwvWJt+WvDW0VKUoLxXXdukw/RczbkVG1eoFK2dDjJU+S1zTUTx1xzNZWX18TQ9Ra5jLngTvieHwhayKfClNJdlh+VBK57RW2QnIK/ts/blxoYjtXxufE41B15Qh5Bo+oX3sVZUklJ71DI5dX1FfrTb1il9UtHKwYsr5bZXgfgJbhBE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9Rq9iffDexj0ls7CeWWwwDN3tzfA7i8yDpvonStWms=;
 b=U2I9SLt9r5RbVB7SzgnposL8yielWh+TUNfIZ++exNJl+6VBYp86+gSpE53f0F+mTMSvHpOOG9QxjIY4dGJRstEiY4iWhUwMhZgPFWCMM8gg/YDx5ExUa7xXRbs1xhuEu26Iz9o6BZ5yGaLnQ73TOVYltvZcnlHtVucVNY6xSi0ad7btYN5q9Fc0KJTY9mxewOb+BV++6vVHMoLz6I996ITze4+NZG+e09SDXmtkzrLBakeIPlQh+TG7s+wvjZifjn4egEsZ2IAjpNGUzZ2LMWyyqx6QRmjMZRjJiLOFBhDS0uoGVIxg18XtaikkBAnfU88ByAssizNw6fwcRRRl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 05:40:04 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 05:40:04 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org"
	<x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "jmattson@google.com" <jmattson@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] x86/acpi: Fix LAPIC/x2APIC parsing order
Thread-Topic: [PATCH] x86/acpi: Fix LAPIC/x2APIC parsing order
Thread-Index: AQHbJBfPE5GlMQbP7U2i2e7FaKk1o7LgY+oAgAByMQA=
Date: Wed, 11 Dec 2024 05:40:04 +0000
Message-ID: <104d086f51d8e297e26fa52a1ebd091041ec2312.camel@intel.com>
References: <20241022001712.9218-1-rui.zhang@intel.com>	 <87zfl3b18t.ffs@tglx>
In-Reply-To: <87zfl3b18t.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BY1PR11MB8080:EE_
x-ms-office365-filtering-correlation-id: d56e6f69-a5a4-419a-cb61-08dd19a6435c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3ROMUlMVFFtVHBjc1lnYm9KQTVsbThWTDcrb3hITURQUmVuTVI2N3FyWFNu?=
 =?utf-8?B?TlZOVXVVa2dmR2tFTDNobFpVdnFLd0grcTlKMzd1cWovZENacHljOUN5Wm9t?=
 =?utf-8?B?L2JlVDNpTHlWOEVSa1Q0T3ZmK1Fvc3dmNW1TMVVoaWg1VTkwMUhZYUh4REQ5?=
 =?utf-8?B?czRLbkFVMEt0VVBwSFRSWWJ3RnVvRndJOTF5UlAxOGdXSWdFYWsrb0EvdUtP?=
 =?utf-8?B?aTI0TFVxSXJlSTBTTW94V05YMk9vM1Y4ejI5N2JZZG1kQmU3QTlHYnYzK202?=
 =?utf-8?B?VG53RUkrNkJOb3ZmL0w3L0E2OGVTR3I2STdXSWZIS1FVMk9YWlZPNHVzRXZK?=
 =?utf-8?B?NVZhTkd5VkpaNVlmbXg5ZVdIczZsZS80SUZXSk8wTktHby84NzNEUVFpeEJX?=
 =?utf-8?B?aGZTQUVQN2V2anhNRGpTZHIxQWtSWVk5N29jWDZwK00rZ2JBNDF6Wmt4UTN5?=
 =?utf-8?B?Qm8rdlY0Z3Z3TjkweUlRNnJNSEE0MVRhZFpLZHhjNENtZWtNU3gxQU9QM2xH?=
 =?utf-8?B?V0VTVWE5S3Y4VHQxZ0I3R2ROMmNTZmlFVXBEYzkvMks4ajQ0UWJyVHdkMnlz?=
 =?utf-8?B?SzZWYkJnNWtHdUtVY3MzZ21qaG9wSERXU1ZGS2hrZ254UUFiVW1PK3NqRWRs?=
 =?utf-8?B?SnRETS93S1FRWEdGeG5Xajg0c0hxem1mdWUzV1hEampxeE9qaTk3VDhDOHJq?=
 =?utf-8?B?R0NiM2NrekFtOVhDQldWb2VDZDk5N2lhT2RsWW0wcVdaVTVSdytwOEUxUG10?=
 =?utf-8?B?UlRhSnVlM2FYdXlnVjlPb3VWNXIxMEhtZUsvZWZINDN2aWpJdkE0OWtiMUdD?=
 =?utf-8?B?b242eTYvZGs2aFhkbnBwNDQzRnZPdy9IM1hVZGNWbkVUM0FORElJYWFQdmRZ?=
 =?utf-8?B?VHNiQ0dhSFJsTEl3Ym1RVXgrcEpUbnZJV0k2ejYwaGRkbDErUG9aRnE2MFZG?=
 =?utf-8?B?MDVsYjI4QUZXazBwV2R1cEs3amZxZWdjOTJndE56NjNGUU5raitRMzhwUldI?=
 =?utf-8?B?a0lMNkhOUzByemR2RjVsR3hWc2I0Zk91VDk5ZHNCQkZ4YUFjOWd3RlRmbThG?=
 =?utf-8?B?cDF4aSt1cHh4dWgzdzRhVllwcDZQOCtVQThMalZLTkVNcy9LVW12Yi8wVnBk?=
 =?utf-8?B?b2hTMEh4WXlIMlAxQjFvSXdXc21MbWp6bFZzYnZ2SExWbFdCYTIwWFV0V1ZE?=
 =?utf-8?B?QnlHWnVnS0U4c016cHFQcDZyQjZheVptcmxBZ2hmcDAva1BKa2lWS3BzN1ZO?=
 =?utf-8?B?ZWhmUnFOTDJrWjNBVzJ0T0pRWTJHbWxOdks2VnlIQ1Y1dzdPalN4Z1pGeWRJ?=
 =?utf-8?B?Mk5LTjQxRjNBSXVTTTRSTDJWc0w4cm1OUHMwWlNTb2RIQkRjd0pQdVVwSkV1?=
 =?utf-8?B?TDB2SXN3UHNsVDRMT203Vkt3YnpISS9aMlg1Zm0wVWdIMUhFc25qc1lNdXNJ?=
 =?utf-8?B?T2ErRlZQdDJMYjNLakEzdTZQV2VaN2NnRXRSOW45UVVyaWV5ODM3SzFrTlYx?=
 =?utf-8?B?TkZxcWlQVW9aOGJUK20rNjRNNnVydTd4ZUNvL2tzQjZiYW9qQmhUcVF3Y2FL?=
 =?utf-8?B?Q1pMN3B4Um4vQ1M5ampzMjRYVElrUUFnSkhpRzlKS24yUVp1MnZhNDBNdEVs?=
 =?utf-8?B?T0s4czR3VTBMcDk1TmpIN1pLVFltS2VzSDA4V3h4R1VjS1k3U3JBWEs4RFNj?=
 =?utf-8?B?SVZHbS84cU1STzdvdHBhLzhPV2d3UlpCKzltRGp6R2lOSC9kTnNWOVZOUGhQ?=
 =?utf-8?B?eUFQL1BDR1BoTXBzM3RKeUlQZG92bEJFeTJWa1RZSXB0bEdRbWs2Wmc2eVBv?=
 =?utf-8?B?dDhLMEt6OWJWemJrYWdoaTgwWjlFOGxBM2NLY095bXZpaFB2bDFoelhFTStD?=
 =?utf-8?B?QXJCQlZCUWphamhHZkdsS3ZCU2U1SlZvaWh3dW5QU3E0VVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTVSNmEwb0ZQUXFzQitpRlpKK0xBTFk5d2RNY3l0N1Q0L1JaeE1uTkViMFk4?=
 =?utf-8?B?KzU0NDVaUitpcjRTYTdBUzdFT3Q3Ri80Q0hpcjVWQUoyYnl3aFREbnRZblJl?=
 =?utf-8?B?NFp6UEFZUTZRNWR4UzMzSWZXejlocFlFUGVMU256ejZ6WDJZM1lhQXU0RDVu?=
 =?utf-8?B?VGVSVzhsZ2VhK08xQTYybytkSFQyWWttdXZYVEZKUzJhN2JKMW1ySVRGVzZD?=
 =?utf-8?B?R2YwZFptZ3pnZ0RWaW5pU1prTXRGVGVXNVljVWxaNnlUTXhHZGcyTUNTTkhT?=
 =?utf-8?B?T1M3TmZ5VWhrRzlJQ2RMbHRsV1h0emZyMWl4SVo2V0NuQWZmZVJZWnJEUnhL?=
 =?utf-8?B?T2JxZk9za0l3TUtWUnNwM2FjQzVWQkdxU2lMY3hzMmlJSVMrUUJWWXBSek5s?=
 =?utf-8?B?czcyUlk4Z3FMbW5ibXZVMFFUc2ZXVVRMenRwakM0Q3RNZ0Q0T09zZ2lZQWg0?=
 =?utf-8?B?MEE3S0d6clZTcG9JMmgwRVlPTVNxUkt0RGlLQUo0V0g4Z2h1aEtOZHBWeXpo?=
 =?utf-8?B?OEhPUEFBaTZCUHNJSE5EWkMwbFN4T2dYNmJPNXRjVTVFcHpvWWZYZmk4VWcz?=
 =?utf-8?B?TjhHSXpOV2VBQlgvS3FES3JQSHE2V3ZEVFRYU01hQ1E4cTUrV3NNN0tMYTVs?=
 =?utf-8?B?dnN6bHEzU0J0dWFaTFA4MlFaSU5TTHdFS01PVzZyYW5IbjN0b2d5YmVqVVRo?=
 =?utf-8?B?QzZEUXY2Nml5ZzhvUkVKOWNRMVdIejZmMzBpeG1zWnJKcWNqcGRFRjQvQ0Y1?=
 =?utf-8?B?UHRwSDFlTGRxMXpvczkrVEczSUZ6YVc1eUREN3ozQzRxdFgvSUtlRENLMFJC?=
 =?utf-8?B?YURxVFVHYy9YdUw1UnYxOEdBNzNRMXZhYjhHUHBxK3oyanlxalVQSVhPR3M0?=
 =?utf-8?B?UDBkcWxDUStjdFJuQ2F6Wk5uYm5BdzJnbWFOTUJGUytRdFJqMW5pcnZyTEJt?=
 =?utf-8?B?bEJiSytlOG5abXgxUXljWUxBbFNRalJoSXVVcjlQWGpHSTlHWmc5L2YzbmRt?=
 =?utf-8?B?bDdSdWNsdlo5KzNjWmFqOXp3a0ZETWpMdmp1b2k5QzBEblpSVG1pU3pvU2N2?=
 =?utf-8?B?djgyZXBLSThCZmU5cW1wV0lUVjVvRDRkLzhnSmo0UUxxN3I0Yy84UUpScmQ0?=
 =?utf-8?B?MTREL3FrbVlkNW5pVXNYSjkzNHNEYmhoSWdYMUpLeVRJM2Vtdm1LNjJyYmdU?=
 =?utf-8?B?RGtpdTUxak0wRzI1NkFCVDVCV1hyZ2NFM2FrVTlsNCtIbE96Zm1ZWFR0U3ZS?=
 =?utf-8?B?cXc4ZHB1d0dnbUVMVWZoNnRHMUFna05rT0tuZ3JNRDBCYzhaUFAvSHc2M1B2?=
 =?utf-8?B?d01Rcit6MGh4ZlpJcGFtZkVIVXJCbklVMFZ3L1dHc1lEZExWeXRDdElUbVNP?=
 =?utf-8?B?aytLN1Yva2ZyU2ZHZ0F0a2R4cmtiT1NoTUVBNkdTS09LVTJBUkZJMEx5ODBV?=
 =?utf-8?B?RzNVODR4ejNGallsQ1IwOTFUa1lwbnBHbWZjTFZYVXVPWEhFWWgrRTNSM3R2?=
 =?utf-8?B?L0xiQnd6eTBIRU9pbnNxK2E1dnU0RDdXTmpJM0x3Y3BmVzVGcnYrZVdmcHU2?=
 =?utf-8?B?alpUMDV4N1JxRm9JRnY5UFc0cUFxQ1VtUW5NZWlwNTZaL2ZZblc1N1pkRlhl?=
 =?utf-8?B?TkpqT1pDNjh4Y3cveVhweXJwaE1hTlJVeFdIWHR4VTVFcmxDRnA5eVUvTDlH?=
 =?utf-8?B?Nm1GS1Y5MWNhOTB4Mk1TLzE0TnJMVFNLVE9rUkhZSzZGcEJFcWwvcU85MXVH?=
 =?utf-8?B?RXJjZ0xZU1VScWNtOEo3a2tNcUE3S1RJS2ZBYXNQRS9iY002ZUloL2toVjdp?=
 =?utf-8?B?KzhkY1NnZ2xwV0JNN2dtc0ZUSzdGMUNsdzBNWjNWa1REZUU0R0g4ZkNsWXVY?=
 =?utf-8?B?V3h5ZDl4ekFOUVpZRmYxNUhjMGY1ZVg1VmxZajg2ZlNNNStSK3hMMXVyWnM5?=
 =?utf-8?B?Y3NmWWhwRUJ2elNyUXdiYlAwR3pZc0lRVTZ4dmJFMHRNUlFPUFVLTnpvUEph?=
 =?utf-8?B?TmN5enNwQ3orQU9wUFlyQ0lKS2tYNG1KdzFjQ2dIeTNLSU5xSGhqdmhDV0t5?=
 =?utf-8?B?cDVYYk9NWThQclB4V1JKMkc0bmhpbERQRUlqY2dWbHZsbEpLV05ZSUZCeHdQ?=
 =?utf-8?Q?OPyboH4/GuJKGFyKXbZQfhIdD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DE49DC3A359B9478301126F4B432EFD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56e6f69-a5a4-419a-cb61-08dd19a6435c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 05:40:04.1494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYtj1u0kQG1vK7+yube1L1wU9Uf388euH/lqH18wLCeXTEViwcYJUriyQgByqu2VTJfVf7saSQjAS1X4qiNx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8080
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTEyLTEwIGF0IDIzOjUxICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgT2N0IDIyIDIwMjQgYXQgMDg6MTcsIFpoYW5nIFJ1aSB3cm90ZToNCj4gPiBP
biBzb21lIHN5c3RlbXMsIHRoZSBzYW1lIENQVSAod2l0aCB0aGUgc2FtZSBBUElDIElEKSBpcyBh
c3NpZ25lZCBhDQo+ID4gZGlmZmVyZW50IGxvZ2ljYWwgQ1BVIGlkIGFmdGVyIGNvbW1pdCBlYzlh
ZWRiMmFhMWEgKCJ4ODYvYWNwaToNCj4gPiBJZ25vcmUNCj4gPiBpbnZhbGlkIHgyQVBJQyBlbnRy
aWVzIikuDQo+ID4gDQo+ID4gVGhpcyBtZWFucyB0aGF0IExpbnV4IGVudW1lcmF0ZXMgdGhlIENQ
VXMgaW4gYSBkaWZmZXJlbnQgb3JkZXIsDQo+ID4gd2hpY2gNCj4gPiB2aW9sYXRlcyBBQ1BJIHNw
ZWNpZmljYXRpb25bMV0gdGhhdCBzdGF0ZXM6DQo+ID4gDQo+ID4gwqAgIk9TUE0gc2hvdWxkIGlu
aXRpYWxpemUgcHJvY2Vzc29ycyBpbiB0aGUgb3JkZXIgdGhhdCB0aGV5IGFwcGVhcg0KPiA+IGlu
DQo+ID4gwqDCoCB0aGUgTUFEVCINCj4gPiANCj4gPiBUaGUgcHJvYmxlbWF0aWMgY29tbWl0IHBh
cnNlcyBhbGwgTEFQSUMgZW50cmllcyBiZWZvcmUgYW55IHgyQVBJQw0KPiA+IGVudHJpZXMsIGFp
bWluZyB0byBpZ25vcmUgeDJBUElDIGVudHJpZXMgd2l0aCBBUElDIElEIDwgMjU1IHdoZW4NCj4g
PiB2YWxpZA0KPiA+IExBUElDIGVudHJpZXMgZXhpc3QuIEhvd2V2ZXIsIGl0IGRpc3J1cHRzIHRo
ZSBDUFUgZW51bWVyYXRpb24gb3JkZXINCj4gPiBvbg0KPiA+IHN5c3RlbXMgd2hlcmUgeDJBUElD
IGVudHJpZXMgcHJlY2VkZSBMQVBJQyBlbnRyaWVzIGluIHRoZSBNQURULg0KPiA+IA0KPiA+IEZp
eCB0aGUgcHJvYmxlbSBieSBzZXBhcmF0ZWx5IGNoZWNraW5nIExBUElDIGVudHJpZXMgYmVmb3Jl
IHBhcnNpbmcNCj4gPiBhbnkNCj4gPiBMQVBJQyBvciB4MkFQSUMgZW50cmllcy4NCj4gDQo+IEkg
cmVhbGx5IGhhZCB0byBzdGFyZSBhdCB0aGUgY2hhbmdlIHRvIHVuZGVyc3RhbmQgaG93IHRoaXMg
Zml4ZXMNCj4gYW55dGhpbmcuIFdoYXQgeW91IHdhbnQgdG8gc2F5IGlzOg0KPiANCj4gRml4IHRo
aXMgcHJvYmxlbSBieToNCj4gDQo+IMKgwqDCoCAxKSBQYXJzaW5nIExBUElDIGVudHJpZXMgZmly
c3Qgd2l0aG91dCByZWdpc3RlcmluZyB0aGVtIGluIHRoZQ0KPiDCoMKgwqDCoMKgwqAgdG9wb2xv
Z3kgdG8gZXZhbHVhdGUgd2hldGhlciB2YWxpZCBMQVBJQyBlbnRyaWVzIGV4aXN0Lg0KPiANCj4g
wqDCoMKgIDIpIFJlc3RvcmluZyB0aGUgTUFEVCBpbiBvcmRlciBwYXJzZXIgd2hpY2ggaW52b2tl
cyBlaXRoZXIgdGhlDQo+IExBUElDIG9yDQo+IMKgwqDCoMKgwqDCoCB0aGUgWDJBUElDIHBhcnNl
ciBmdW5jdGlvbiBkZXBlbmRpbmcgb24gdGhlIGVudHJ5IHR5cGUuDQo+IA0KPiDCoMKgwqDCoMKg
wqAgVGhlIFgyQVBJQyBwYXJzZXIgc3RpbGwgaWdub3JlcyBlbnRyaWVzIDwgMHhmZiBpbiBjYXNl
IHRoYXQgIzENCj4gwqDCoMKgwqDCoMKgIGZvdW5kIHZhbGlkIExBUElDIGVudHJpZXMgaW5kZXBl
bmRlbnQgb2YgdGhlaXIgcG9zaXRpb24gaW4gdGhlDQo+IMKgwqDCoMKgwqDCoCBNQURUIHRhYmxl
Lg0KPiANCkV4YWN0bHkuIFRoYW5rcyBmb3IgdGhlIHJld29yZGluZy4NCg0KLXJ1aQ0KDQo+IE90
aGVyIHRoYW4gdGhhdDoNCj4gDQo+IFJldmlld2VkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4NCj4gDQo+IMKgwqDCoMKgwqDCoCANCg0K

