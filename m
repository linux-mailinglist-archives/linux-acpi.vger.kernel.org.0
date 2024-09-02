Return-Path: <linux-acpi+bounces-8071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30241967F8D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 08:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9BE1F227CA
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC4B1552FC;
	Mon,  2 Sep 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN6WtLXG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA47152E12;
	Mon,  2 Sep 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258986; cv=fail; b=T1Nzlum9FB9Hc1lspydwlrzoB+NQ7yuwYWRnOjKZrGvobVvFyeN3m1FFlI4DUFHBA1qIW8j/st8LAOEUDHngTp7MYXyaROUBpH4XKUmTrHmK466WBo7FkVOF9/abh+N+xkdkACIp9x0SlyMGuV11TpZy1W9WEaniA0Q045pPhcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258986; c=relaxed/simple;
	bh=ENghiUm5ZAl56A/jCTQzqsSWs1FL4rxpGTac4aaRZEw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbncwq9FY058cBqo0eKSVW1FbXtQZoAcLk0LigsiaSvNekOwT3O2YGZnPf4pTq93H3sx+uWYdKhSdqhbj3uBc2GD64XxHwyWAJK0/+UhtDKPECr3I1GyVCFHUlUHZDBalEKX1QG128AcptEes/6n6bM4VGuzHXLo7MsEm8o7ax4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN6WtLXG; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725258984; x=1756794984;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ENghiUm5ZAl56A/jCTQzqsSWs1FL4rxpGTac4aaRZEw=;
  b=YN6WtLXGvNgY5v+vRuRnXnV+jRF7Dx9Nqmb+YUgD3afZ1yc27tP58olF
   A9v5PfUaMcuWyCcX5lmYRBjoKgdayB8uDrGW5vIiibWQYvEdSSssHCtI9
   NLnUEohW0WX2agb2teUH1B6dC5JvegORvE0pY8y7y3YND05Khu7Lrfcnz
   VoqKJLkl6Oj5502wlE2fzjphIWq6MV8Udto+3VbwnawfM+clnKeNwx5l5
   xeREqsAGvnRGWqqe7wMWA5qNdNVWKkjXbFC9ozG5JegC0zgGUMBy/c0MD
   kN5NKwNtnJ3p73rxIf33C29DwqKdvmGDvua3mV6qrC5Zus11qlI1Tlkxq
   A==;
X-CSE-ConnectionGUID: DaI83DK5SjS2pm94w+yI6Q==
X-CSE-MsgGUID: XfdIwng7RVqnUO68xwbsoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23983784"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23983784"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:36:23 -0700
X-CSE-ConnectionGUID: 5YePLBENRZWG7k7uQuRUuA==
X-CSE-MsgGUID: uCEkCmqeR8OyQhnfSCbBfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69321248"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2024 23:36:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 23:36:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 23:36:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 23:36:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 23:36:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUSalaDE2bqdxZTgF+6MsnxZ/1JszV4ePhx87w/l5YGPjR+PdEi6jUwkf6sP7WvovZWQurUB2m6QJY5HUa0XvrlmqKPU6QZ56PUGNAbSCpln2QIQsTAfl5K5AEadvHDas56hakrf4ING7eNQ5eQuTDWtA5C26T2HA+1/lrZOsHiKkdJfx2aMYDIAi5l71RlxZ3EaHCKUDCqvEaF3Fob3tamo9zIDa9jFVI48pfa1pzUHyWpEGnwkQYUSM/5go3NqziJwNpPNNSoxsnl5J65HpFzKnEL0Dj5QpOJ7+pbONCG7LDVg57nFGsbgaUc/ACDjLMxeeeVcCZNeyvyJqtiCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENghiUm5ZAl56A/jCTQzqsSWs1FL4rxpGTac4aaRZEw=;
 b=yHrC5XIdx0LoAk6rky63FVpeinKo70fA8yiUrAZKODyYpsGqwm9gJLJlF2YhlE5H1IVk6ptpMrkcLopYHaM4Ka9bU2/cqMdW9Ny/HoHXDj6HuaFibf44nUp8ZA9VmbRDEA1ncMog5FPQEcvEJIwVOa6CxDA8gKosWmGytPattd3k9VDbxBLuMZeBrYZjJi79qsCSPRJz4XPx26wXm68Dmsu3kixqikgjIK0mDN0m1WH4ineuZaepIAy0ySnBW81/emCECyv1W3NNtqDCICKNjDZdxuXh/isSo2VIhkgzSYcGZO96PYNOoA2feW0npfU/Po+hAeTCuRpF2OU1LdyYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:36:18 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 06:36:18 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "james.morse@arm.com" <james.morse@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"Ko, Koba" <kobak@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH V2] acpi/prmt: find block with specific type
Thread-Topic: [PATCH V2] acpi/prmt: find block with specific type
Thread-Index: AQHa/Is/DIZncRYkx0q3AFZrj6bMprJEC72A
Date: Mon, 2 Sep 2024 06:36:18 +0000
Message-ID: <afec8c0c7b92de59469e789cff4ba8a11f631217.camel@intel.com>
References: <20240901162255.1302358-1-kobak@nvidia.com>
In-Reply-To: <20240901162255.1302358-1-kobak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW5PR11MB5881:EE_
x-ms-office365-filtering-correlation-id: 40f6ce49-6811-4438-da04-08dccb198d56
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WG9QMlNDTERseVBoNUVTTmFuanhTUWVSVTJHdFBzUHNGNXVqbnFRQnpnZnlL?=
 =?utf-8?B?WDZjVzJQQnQvRTRWWEtCNXFYOGJpUVMxUXhsRnBYbTYrdkk1L2tZbUtNTHBI?=
 =?utf-8?B?Rjk1SkxlWFBzNDNaUUN0NGhaZzBrUnp2TStSZHE3UkpSdG84RzRGVVVYRzM2?=
 =?utf-8?B?Z2VuLytNQXNkZElnYmRHZWVKU2pnMGJ0c2JJK3JIZkdFMkxvOXZYeVlIY0tH?=
 =?utf-8?B?L2JKVnpaMGlxU1VrV01nTG9JV2NCbWVXaFczSGRtd2k2UkRvNVcxZktHYXcz?=
 =?utf-8?B?VHJsRSswWUU4RnNRSzVJS1VNKzAwdWllc3pOMDF5aE9tT0NZRXBJdFFlSXEx?=
 =?utf-8?B?dEF4aVk1MVNiQzdSdU93MDlmZzBlZ3NnWng0Q3hOeEI3TXhRZHdZZFNPQVV6?=
 =?utf-8?B?NDc4eDZsZ1ozWkRyck1lRWFjSnNOSFlGRytVdmR6V25pRC93d0tRZHlYVE92?=
 =?utf-8?B?MmNkSFkvVDJFT20yL2IzbEQ4Q0lsR3pwdXo1cHVIYWptMlZMMWxuU0JKcWtS?=
 =?utf-8?B?T2ZodWszR0tqT3FSSEFqNHRUVmFsQnhBcmI2QzF4YWpwRkN3bHRTMDJPYmgy?=
 =?utf-8?B?ZjdpYWJaMmxiNE43UisvQmdzS0VaNjViRi91ZFdKRHVHMFBlbGUvMFEyVVYz?=
 =?utf-8?B?S1F0Qklsbk91Qm9XbE10K1hZanFTdlNJeUsyYjZSSmVaYnp1S3JTU3c1Vitx?=
 =?utf-8?B?eVBtOE9jUDA3L1lOeEpRK1AyaWlBM3JuRlpzN2h2aTVGdWcxM2JDWDliNHh3?=
 =?utf-8?B?UzI1UWNjdFBKUUltS3dOVTd6c2FhbVpFQ1lPYVpGYTZwMTRaRWlZSnhneUNN?=
 =?utf-8?B?VEc4M0xXRitUWURhQTVuT2RBNjFKbnlmSEtvNlJqcVlxWWxsdXAxbHJGM1Bh?=
 =?utf-8?B?MGMzSGtVcncrZ0c4SmJPR3JhTjB4MTFHajJweFVGenM5b0VPRk8waVZhZ0hE?=
 =?utf-8?B?UStUNmRNU2l4cFhEVldjMEtiM2gzQnZxTnpQUDRqZjk4ZXhFZHljVFZBYkFW?=
 =?utf-8?B?K2N3WXk2T1g5c2MyYnlkUWZidUtQaGVFVXhLcDZOdDhzdW5ocEhEZlJ6YzZF?=
 =?utf-8?B?L1k4Q3BUemFpbHB4eW96dGJNZ2Y3M3dRSkgxbTRCelBMMTBlQTJPODFQRnVn?=
 =?utf-8?B?RVp5T1dUSlUwZTZQWEhBdFpMQWxYcWV6d0ovYnhyMjlEUUllbDZGK0FsUkRE?=
 =?utf-8?B?dGw2a21UdGhRc0FxalQxdkt5aDRyQ2hGdFBJekVVandrcjlPdnhnVW9ka3Vr?=
 =?utf-8?B?OW9TaHhwSjd0dGxUZU5Qb0VvM0dlM1F6NFJURHh4eTNPT0hULzdxQ1RuU042?=
 =?utf-8?B?NkV5M05Mc2JTVThGMDdPRjhqOGtZeXhiaUo2Vi9XSFlOQXo2eDJMc253VU9M?=
 =?utf-8?B?YXB6UzMzTGRMK2l6d04za243bHl6OUJwT1FSZFhjY1hPVFlQN1l4T3NBaWJs?=
 =?utf-8?B?N2l4Y3V1ZmdEUHk1dGplcklWM3pJYnZSQmNwYXZOaEVNOUFsYyt4dFU5bHR3?=
 =?utf-8?B?a2JlTDFIbzRKckF4ZmN1YkJrS0V3S0haSjQxSmZkNWVYeHM2YklyQkplaklJ?=
 =?utf-8?B?VVp2RW1vT0tHb2lubU5jTFdwM2xxbnozbU9zK0pEQ1Q2NUJCNElTT05TblBF?=
 =?utf-8?B?ZlRaUjc4MjM3dFNVdmxCb1grSlJTSEkybk5RSE5pdTIxbjBpODlRWGYxaHpj?=
 =?utf-8?B?Z0VtT2dLQklIeVF4RldRUGpGb2ZUcXp3VllkVlVmTXRxdkJJRFUxOVdveVJU?=
 =?utf-8?B?bmkrSWlEVkw5VE9Sck5OayswQUQ3SXpRcytNMEpIQzhWVGhHZkdCVGlONlNO?=
 =?utf-8?Q?qtupvuJWS4Qqtl0HWGPTrQn9ECLS+f99Zz7lg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmxLc3AzM21qU3JFaFRwaUtFMkJ5UnM2ZXlXb2txL0VJY1MyYXd6YkplZHR3?=
 =?utf-8?B?UUI4NHJwb1g2TGlnbnRYeVFGN25DeG85bS9JZ3ozbmduRjloS0NEeXdDYzhw?=
 =?utf-8?B?TWJYZE00emxYd1NSaGFuTE90dkUzamJJTE9yUlFuN1hMMnlMMGVGZHJyV0wx?=
 =?utf-8?B?dkFFdFAwcVRvTTc4TTJOMjVkK3RldFNSYnJndGY4S25yODFNeVBkWmhYUjEv?=
 =?utf-8?B?QURPTmU3KzZ2SDhMT1E4dXZVeVZvTFlUanhlYVJKUEcrVDU2UEFidFh4L3dv?=
 =?utf-8?B?L3BwMzJicjc4VHpzMlQyZ1hDMzdLZkJKYndzd2R0dFNlWFZNZjBHZEJvNkV1?=
 =?utf-8?B?UHhtSFFKeGJmcEFQeHFsaytxTTNpUFl4OVNIU1lJc1pXMjRaM0Z0RlBBZjd6?=
 =?utf-8?B?RzNFSldUQS9DRkxpblY2am1OYm1hbHRrMCtKeUtoZ0xCaHVUWGwrUGNEM1ZG?=
 =?utf-8?B?eUpJOFgrNGNqWG5kbE9FbHh4SkkvL1JEanNjc0VJVTA4SHVPY2h2SENyanVx?=
 =?utf-8?B?bUVnUWtZWmZBbzVzc0V4b3V3dmg4M09QK3orRmJYOWNBbjY4WUI0cHN3Slgv?=
 =?utf-8?B?RVNlMjRLVENLSGROOHpUVXlvQ2xTNFZmWUZueXhnV2pwU3VHVmM0RDhrZE1B?=
 =?utf-8?B?SE9ZWVcyN2RBL1dIbVhsVksvcXlPV1h4UVJTM25DdWI5SW1PYjQxNDkxdXUy?=
 =?utf-8?B?SHB1aWxNS2JNcVlYWERiY0FJUUY4MGxuR1NKZ2Mya3cya1ZiYm1JclY1TGRD?=
 =?utf-8?B?Nzh0UlF6TjVDMjJZTFdvYkw4RzN5UWpEeUx5NnZ0SkJFVFBmZFdTd0VhbUFj?=
 =?utf-8?B?bXNsc2hZakxZQkdLZ2IrRWpQM3RjQXZHS09oWkU4QXNCMHhaMVE5WXBBcUV1?=
 =?utf-8?B?Vk41dWNLdWFBQ254Q1hhRCs0YWJPaVVCcUpNK3FWVHVEVGpDTGs1ZTBqejhP?=
 =?utf-8?B?SGtrVFdwZlZwc0xibjhiZnRBeG9tOHkrOUl1Q3J3SnZxaDZ6U0RyeEhrT3U1?=
 =?utf-8?B?RHRDZHhuZjFlVzdpZk9NZGR0bUlCakw4ek4wK3NaSnVCaDlwQ0pKZDBwdzVF?=
 =?utf-8?B?NkNyQnMyUkpUZ2RaZHhRbHBaemx4bWUzYjVhaDFldlVzQitVMm9TTnZERHFx?=
 =?utf-8?B?NVYweWdWM21jMk9UdEp0NmE0K0tUTFZ1WCtKWi8yVFQ5RHNjR3laVWtxS0Ro?=
 =?utf-8?B?YURaVFRBUFZSRW1GZ0p2WXdLUnY5dXRGUkhJQll2cS9WZEZnNWlIY0h2WEtz?=
 =?utf-8?B?QmxuZWdTam9lQWNWSmlNMmlxRTNpSmdILyt1bjN1aTUyRUtIZmg4Nk5vZjE2?=
 =?utf-8?B?WTNuZFJvK2IwTjV2ZVBmUGVtaUpwb3dOVDIrdHdRdVNVbUtMRTRGS041TUMr?=
 =?utf-8?B?TlRFeHowZ2srQWlvTW5IT25UTHQycmhhOCsrY2Q3eEZkbkNHbHlqOVFUb3g4?=
 =?utf-8?B?K000bFA4ZS90V1E4UVVSZE9vdjNQdzlGamxhOVpYd3RYaGNJZTBYajU2cWZp?=
 =?utf-8?B?ckYvUDBPbzFIb1hGNXQ0VVVJTWFBZDhUaHpKdlZ4VkR1MWxpNWhyZUNPbHZt?=
 =?utf-8?B?cWpBODFCb2R1dTlmc3lWeTUwc3BvME5vanBsUXY5QUpUWHhndndHdU5RbXFG?=
 =?utf-8?B?Znc5OHc1eG5IOHBWbU9UV1d4L1RhNGV0YTladkVxMm5LQkVwSmZWbXd4MnhW?=
 =?utf-8?B?dVdmUmc2ZHZRTVJoRkFxT1dGMVpZem01WlozTUk0VEtYNU50SFlUOGxwbjMx?=
 =?utf-8?B?bDR2M3hqNFdkTW02L3pyaE1CeWRLalFRNGpXdFJBaWhhcUdGbU9BODZiZDdP?=
 =?utf-8?B?Nmo2SlAwakRzWGI3QjB2Y1I2ZkdpSENsN0xZWEhMZEoxd1FwRHBDcGZrSW9a?=
 =?utf-8?B?YXM2VEZFWUNZT0M1ZnpNWGFmU1d4TlJuaFc0c3B0clduYWlGUURISGVmSFE2?=
 =?utf-8?B?Q2I3VGg3M1AvdXVWcCthb2NyVXZrUVh1L2t6RUl0NnlxbHdjZ0pQZGZaY2Ir?=
 =?utf-8?B?bWFRcVpEcVZIZGpCeFo4STFUUjJPRWpkRDh2djZEVGNzUGxQOUVhdVIrYkFs?=
 =?utf-8?B?TFhJNFBaOVNZVjBPSmlqTnZDSWxiclJoVXlZQmNRVzNOQTF4WUJsMUFBVDly?=
 =?utf-8?B?TGFVNDdGWTBkamZrYUhWY2dXSm5hc3hwVXNkSTdGamhUSWtQNWZ3Um9UaUxi?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF6B7C666A468E4BB581D30A33BE60B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f6ce49-6811-4438-da04-08dccb198d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 06:36:18.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a47VFsZAN5VGk5MEtZFg3ZE0fIhjssUmN7G8H7ttO3NCreRd4+oZ4QLh0wevsH7N3bHbLpsabnEC31v2EOm+DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA5LTAyIGF0IDAwOjIyICswODAwLCBLb2JhSyB3cm90ZToKPiBQUk1UIG5l
ZWRzIHRvIGZpbmQgdGhlIGNvcnJlY3QgdHlwZSBvZiBibG9jayB0bwo+IHRyYW5zbGF0ZSB0aGUg
UEEtVkEgbWFwcGluZyBmb3IgRUZJIHJ1bnRpbWUgc2VydmljZXMuCj4gCj4gVGhlIGlzc3VlIGFy
aXNlcyBiZWNhdXNlIHRoZSBQUk1UIGlzIGZpbmRpbmcgYSBibG9jayBvZgo+IHR5cGUgRUZJX0NP
TlZFTlRJT05BTF9NRU1PUlksIHdoaWNoIGlzIG5vdCBhcHByb3ByaWF0ZSBmb3IKPiBydW50aW1l
IHNlcnZpY2VzIGFzIGRlc2NyaWJlZCBpbiBTZWN0aW9uIDIuMi4yIChSdW50aW1lCj4gU2Vydmlj
ZXMpIG9mIHRoZSBVRUZJIFNwZWNpZmljYXRpb24gWzFdLiBTaW5jZSB0aGUgUFJNIGhhbmRsZXIg
aXMKPiBhIHR5cGUgb2YgcnVudGltZSBzZXJ2aWNlLCB0aGlzIGNhdXNlcyBhbiBleGNlcHRpb24K
PiB3aGVuIHRoZSBQUk0gaGFuZGxlciBpcyBjYWxsZWQuCj4gCj4gwqDCoMKgIFtGaXJtd2FyZSBC
dWddOiBVbmFibGUgdG8gaGFuZGxlIHBhZ2luZyByZXF1ZXN0IGluIEVGSSBydW50aW1lCj4gc2Vy
dmljZQo+IMKgwqDCoCBXQVJOSU5HOiBDUFU6IDIyIFBJRDogNDMzMCBhdCBkcml2ZXJzL2Zpcm13
YXJlL2VmaS9ydW50aW1lLQo+IHdyYXBwZXJzLmM6MzQxCj4gwqDCoMKgwqDCoMKgwqAgX19lZmlf
cXVldWVfd29yaysweDExYy8weDE3MAo+IMKgwqDCoCBDYWxsIHRyYWNlOgo+IMKgwqDCoMKgwqAg
X19lZmlfcXVldWVfd29yaysweDExYy8weDE3MAo+IMKgwqDCoMKgwqAgZWZpX2NhbGxfYWNwaV9w
cm1faGFuZGxlcisweDY4LzB4ZDAKPiDCoMKgwqDCoMKgIGFjcGlfcGxhdGZvcm1ydF9zcGFjZV9o
YW5kbGVyKzB4MTk4LzB4MjU4Cj4gwqDCoMKgwqDCoCBhY3BpX2V2X2FkZHJlc3Nfc3BhY2VfZGlz
cGF0Y2grMHgxNDQvMHgzODgKPiDCoMKgwqDCoMKgIGFjcGlfZXhfYWNjZXNzX3JlZ2lvbisweDlj
LzB4MTE4Cj4gwqDCoMKgwqDCoCBhY3BpX2V4X3dyaXRlX3NlcmlhbF9idXMrMHhjNC8weDIxOAo+
IMKgwqDCoMKgwqAgYWNwaV9leF93cml0ZV9kYXRhX3RvX2ZpZWxkKzB4MTY4LzB4MjE4Cj4gwqDC
oMKgwqDCoCBhY3BpX2V4X3N0b3JlX29iamVjdF90b19ub2RlKzB4MWE4LzB4MjU4Cj4gwqDCoMKg
wqDCoCBhY3BpX2V4X3N0b3JlKzB4ZWMvMHgzMzAKPiDCoMKgwqDCoMKgIGFjcGlfZXhfb3Bjb2Rl
XzFBXzFUXzFSKzB4MTVjLzB4NjE4Cj4gwqDCoMKgwqDCoCBhY3BpX2RzX2V4ZWNfZW5kX29wKzB4
Mjc0LzB4NTQ4Cj4gwqDCoMKgwqDCoCBhY3BpX3BzX3BhcnNlX2xvb3ArMHgxMGMvMHg2YjgKPiDC
oMKgwqDCoMKgIGFjcGlfcHNfcGFyc2VfYW1sKzB4MTQwLzB4M2IwCj4gwqDCoMKgwqDCoCBhY3Bp
X3BzX2V4ZWN1dGVfbWV0aG9kKzB4MTJjLzB4MmEwCj4gwqDCoMKgwqDCoCBhY3BpX25zX2V2YWx1
YXRlKzB4MjEwLzB4MzEwCj4gwqDCoMKgwqDCoCBhY3BpX2V2YWx1YXRlX29iamVjdCsweDE3OC8w
eDM1OAo+IMKgwqDCoMKgwqAgYWNwaV9wcm9jX3dyaXRlKzB4MWE4LzB4OGEwIFthY3BpX2NhbGxd
Cj4gwqDCoMKgwqDCoCBwcm9jX3JlZ193cml0ZSsweGNjLzB4MTUwCj4gwqDCoMKgwqDCoCB2ZnNf
d3JpdGUrMHhkOC8weDM4MAo+IMKgwqDCoMKgwqAga3N5c193cml0ZSsweDcwLzB4MTIwCj4gwqDC
oMKgwqDCoCBfX2FybTY0X3N5c193cml0ZSsweDI0LzB4NDgKPiDCoMKgwqDCoMKgIGludm9rZV9z
eXNjYWxsLmNvbnN0cHJvcC4wKzB4ODAvMHhmOAo+IMKgwqDCoMKgwqAgZG9fZWwwX3N2YysweDUw
LzB4MTEwCj4gwqDCoMKgwqDCoCBlbDBfc3ZjKzB4NDgvMHgxZDAKPiDCoMKgwqDCoMKgIGVsMHRf
NjRfc3luY19oYW5kbGVyKzB4MTVjLzB4MTc4Cj4gwqDCoMKgwqDCoCBlbDB0XzY0X3N5bmMrMHgx
YTgvMHgxYjAKPiAKPiBGaW5kIGEgYmxvY2sgd2l0aCBzcGVjaWZpYyB0eXBlIHRvIGZpeCB0aGlz
Lgo+IHBybXQgZmluZCBhIGJsb2NrIHdpdGggRUZJX1JVTlRJTUVfU0VSVklDRVNfREFUQSBmb3Ig
cHJtIGhhbmRsZXIgYW5kCj4gZmluZCBhIGJsb2NrIHdpdGggRUZJX1JVTlRJTUVfU0VSVklDRVNf
Q09ERSBmb3IgcHJtIGNvbnRleHQuCj4gSWYgbm8gc3VpdGFibGUgYmxvY2sgaXMgZm91bmQsIGEg
d2FybmluZyBtZXNzYWdlIHdpbGwgYmUgcHJvbXB0ZWQKPiBidXQgdGhlIHByb2NlZHVlIGNvbnRp
bnVlcyB0byBtYW5hZ2UgdGhlIG5leHQgcHJtIGhhbmRsZXIuCj4gSG93ZXZlciwgaWYgdGhlIHBy
bSBoYW5kbGVyIGlzIGFjdHVsbGF5IGNhbGxlZCB3aXRob3V0IHByb3Blcgo+IGFsbG9jYXRpb24s
Cj4gaXQgd291bGQgcmVzdWx0IGluIGEgZmFpbHVyZSBkdXJpbmcgZXJyb3IgaGFuZGxpbmcuCj4g
Cj4gQnkgdXNpbmcgdGhlIGNvcnJlY3QgbWVtb3J5IHR5cGVzIGZvciBydW50aW1lIHNlcnZpY2Vz
LAo+IEVuc3VyZSB0aGF0IHRoZSBQUk0gaGFuZGxlciBhbmQgdGhlIGNvbnRleHQgYXJlCj4gcHJv
cGVybHkgbWFwcGVkIGluIHRoZSB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UgZHVyaW5nIHJ1bnRpbWUs
Cj4gcHJldmVudGluZyB0aGUgcGFnaW5nIHJlcXVlc3QgZXJyb3IuCj4gCj4gWzFdCj4gaHR0cHM6
Ly91ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9VRUZJX1NwZWNfMl8xMF9B
dWcyOS5wZGYKPiAKPiBGaXhlczogY2VmYzdjYTQ2MjM1ICgiQUNQSTogUFJNOiBpbXBsZW1lbnQg
T3BlcmF0aW9uUmVnaW9uIGhhbmRsZXIKPiBmb3IgdGhlIFBsYXRmb3JtUnRNZWNoYW5pc20gc3Vi
dHlwZSIpCj4gU2lnbmVkLW9mZi1ieTogS29iYUsgPGtvYmFrQG52aWRpYS5jb20+Cj4gUmV2aWV3
ZWQtYnk6IE1hdHRoZXcgUi4gT2NocyA8bW9jaHNAbnZpZGlhLmNvbT4KPiAtLS0KPiBWMjoKPiAx
LiBmb3JtYXQgdGhlIGNoYW5nZWxvZyBhbmQgYWRkIG1vcmUgYWJvdXQgZXJyb3IgaGFuZGxpbmcu
Cj4gMi4gcmVwbGFjZSBnb3RvCj4gLS0tCj4gwqBkcml2ZXJzL2FjcGkvcHJtdC5jIHwgNDcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+IC0tCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYWNwaS9wcm10LmMgYi9kcml2ZXJzL2FjcGkvcHJtdC5jCj4gaW5kZXggYzc4
NDUzYzc0ZWY1Li4yODFjZGI1M2VkZGIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9hY3BpL3BybXQu
Ywo+ICsrKyBiL2RyaXZlcnMvYWNwaS9wcm10LmMKPiBAQCAtNzIsMTcgKzcyLDIxIEBAIHN0cnVj
dCBwcm1fbW9kdWxlX2luZm8gewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcHJtX2hhbmRsZXJf
aW5mbyBoYW5kbGVyc1tdCj4gX19jb3VudGVkX2J5KGhhbmRsZXJfY291bnQpOwo+IMKgfTsKPiDC
oAo+IC1zdGF0aWMgdTY0IGVmaV9wYV92YV9sb29rdXAodTY0IHBhKQo+ICtzdGF0aWMgdTY0IGVm
aV9wYV92YV9sb29rdXAodTY0IHBhLCB1MzIgdHlwZSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKg
ZWZpX21lbW9yeV9kZXNjX3QgKm1kOwo+IMKgwqDCoMKgwqDCoMKgwqB1NjQgcGFfb2Zmc2V0ID0g
cGEgJiB+UEFHRV9NQVNLOwo+IMKgwqDCoMKgwqDCoMKgwqB1NjQgcGFnZSA9IHBhICYgUEFHRV9N
QVNLOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGZvcl9lYWNoX2VmaV9tZW1vcnlfZGVzYyhtZCkg
ewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobWQtPnBoeXNfYWRkciA8IHBh
ICYmIHBhIDwgbWQtPnBoeXNfYWRkciArCj4gUEFHRV9TSVpFICogbWQtPm51bV9wYWdlcykKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKChtZC0+dHlwZSA9PSB0eXBlKSAmJgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKG1kLT5waHlz
X2FkZHIgPCBwYSAmJiBwYSA8IG1kLT5waHlzX2FkZHIgKwo+IFBBR0VfU0laRSAqIG1kLT5udW1f
cGFnZXMpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIHBhX29mZnNldCArIG1kLT52aXJ0X2FkZHIgKyBwYWdlIC0gbWQtCj4gPnBoeXNf
YWRkcjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKg
wqB9Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBwcl93YXJuKCJQUk06IEZhaWxlZCB0byBmaW5kIGEg
VkEgYmxvY2sgZm9yIHBhOiAlbHggdHlwZQo+ICV1XG4iLCBwYSwgdHlwZSk7Cj4gKwo+IMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IEBAIC0xNDgsOSArMTUyLDEyIEBAIGFj
cGlfcGFyc2VfcHJtdCh1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMKPiAqaGVhZGVyLCBjb25z
dCB1bnNpZ25lZCBsb25nIGVuZCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRo
ID0gJnRtLT5oYW5kbGVyc1tjdXJfaGFuZGxlcl07Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGd1aWRfY29weSgmdGgtPmd1aWQsIChndWlkX3QgKiloYW5kbGVyX2luZm8t
Cj4gPmhhbmRsZXJfZ3VpZCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoLT5o
YW5kbGVyX2FkZHIgPSAodm9pZAo+ICopZWZpX3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tPmhh
bmRsZXJfYWRkcmVzcyk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoLT5zdGF0
aWNfZGF0YV9idWZmZXJfYWRkciA9Cj4gZWZpX3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tPnN0
YXRpY19kYXRhX2J1ZmZlcl9hZGRyZXNzKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHIgPQo+IGVmaV9wYV92YV9sb29rdXAoaGFuZGxl
cl9pbmZvLT5hY3BpX3BhcmFtX2J1ZmZlcl9hZGRyZXNzKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdGgtPmhhbmRsZXJfYWRkciA9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAodm9pZCAqKWVmaV9wYV92YV9sb29rdXAoaGFuZGxlcl9p
bmZvLQo+ID5oYW5kbGVyX2FkZHJlc3MsIEVGSV9SVU5USU1FX1NFUlZJQ0VTX0NPREUpOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aC0+c3RhdGljX2RhdGFfYnVmZmVyX2FkZHIg
PQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWZpX3Bh
X3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tCj4gPnN0YXRpY19kYXRhX2J1ZmZlcl9hZGRyZXNzLCBF
RklfUlVOVElNRV9TRVJWSUNFU19EQVRBKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHIgPQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWZpX3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tCj4g
PmFjcGlfcGFyYW1fYnVmZmVyX2FkZHJlc3MsIEVGSV9SVU5USU1FX1NFUlZJQ0VTX0RBVEEpOwoK
d2h5IG5vdCByZW1vdmUgcHJfd2FybigpIGluIGVmaV9wYV92YV9sb29rdXAoKSwgYW5kIGNoZWNr
IGZvciBhbGwgdGhyZWUKYWRkcnMgaGVyZSB3aXRoIGEgbW9yZSBkZXRhaWxlZCBtZXNzYWdlIGFi
b3V0IHdoaWNoIHBhcnQgaXMgbWlzc2luZyBmb3IKd2hpY2ggbW9kdWxlL2hhbmRsZXI/Cgo+IMKg
wqDCoMKgwqDCoMKgwqB9IHdoaWxlICgrK2N1cl9oYW5kbGVyIDwgdG0tPmhhbmRsZXJfY291bnQg
JiYgKGhhbmRsZXJfaW5mbyA9Cj4gZ2V0X25leHRfaGFuZGxlcihoYW5kbGVyX2luZm8pKSk7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gQEAgLTI1MCw4ICsyNTcsMTggQEAgc3Rh
dGljIGFjcGlfc3RhdHVzCj4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0
aW9uLAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoYW5kbGVyID0gZmlu
ZF9wcm1faGFuZGxlcigmYnVmZmVyLT5oYW5kbGVyX2d1aWQpOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbW9kdWxlID0gZmluZF9wcm1fbW9kdWxlKCZidWZmZXItPmhhbmRsZXJf
Z3VpZCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghaGFuZGxlciB8fCAh
bW9kdWxlKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBpbnZhbGlkX2d1aWQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgh
aGFuZGxlciB8fCAhbW9kdWxlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBidWZmZXItPnBybV9zdGF0dXMgPQo+IFBSTV9IQU5ETEVSX0dVSURfTk9U
X0ZPVU5EOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cHJfZXJyKCJQUk06IFBSTSBIYW5kbGVyIEdVSUQgaXMgbm90Cj4gZm91bmRcbiIpOwoKQXJlIHlv
dSBzdXJlIHlvdSB3YW50IHRvIGdldCB0aGlzIGVycm9yIG1lc3NhZ2UgZXZlcnkgdGltZSB0aGUg
YWRkcmVzcwpzcGFjZSBoYW5kbGVyIGlzIGludm9rZWQsIHJhdGhlciB0aGFuIGdpdmUgYW4gb25l
IHRpbWUgd2FybmluZyBkdXJpbmcKdGhlIGhhbmRsZXIgcHJvYmUgdGltZT8KCnRoYW5rcywKcnVp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
QUVfT0s7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghaGFuZGxlci0+aGFuZGxlcl9hZGRyIHx8ICFoYW5k
bGVyLQo+ID5zdGF0aWNfZGF0YV9idWZmZXJfYWRkciB8fAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIWhhbmRsZXItPmFjcGlfcGFyYW1fYnVmZmVyX2Fk
ZHIpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1
ZmZlci0+cHJtX3N0YXR1cyA9IFBSTV9IQU5ETEVSX0VSUk9SOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfZXJyKCJQUk06IFBSTSBIYW5kbGVyIG5v
dCBmb3VuZFxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gQUVfT0s7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQUNQSV9DT1BZX05BTUVTRUcoY29u
dGV4dC5zaWduYXR1cmUsICJQUk1DIik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb250ZXh0LnJldmlzaW9uID0gMHgwOwo+IEBAIC0yNzQsOCArMjkxLDEwIEBAIHN0YXRpYyBh
Y3BpX3N0YXR1cwo+IGFjcGlfcGxhdGZvcm1ydF9zcGFjZV9oYW5kbGVyKHUzMiBmdW5jdGlvbiwK
PiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBQUk1fQ01EX1NUQVJUX1RSQU5TQUNUSU9OOgo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtb2R1bGUgPSBmaW5kX3BybV9tb2R1bGUo
JmJ1ZmZlci0+aGFuZGxlcl9ndWlkKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFtb2R1bGUpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBnb3RvIGludmFsaWRfZ3VpZDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFtb2R1bGUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJ1ZmZlci0+cHJtX3N0YXR1cyA9Cj4gUFJNX0hBTkRMRVJfR1VJRF9OT1RfRk9VTkQ7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
QUVfT0s7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1vZHVsZS0+dXBkYXRhYmxlKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vZHVsZS0+dXBkYXRhYmxl
ID0gZmFsc2U7Cj4gQEAgLTI4Niw4ICszMDUsMTAgQEAgc3RhdGljIGFjcGlfc3RhdHVzCj4gYWNw
aV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+IMKgwqDCoMKgwqDCoMKg
wqBjYXNlIFBSTV9DTURfRU5EX1RSQU5TQUNUSU9OOgo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBtb2R1bGUgPSBmaW5kX3BybV9tb2R1bGUoJmJ1ZmZlci0+aGFuZGxlcl9n
dWlkKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFtb2R1bGUpCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGludmFsaWRf
Z3VpZDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFtb2R1bGUpIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZmZlci0+cHJt
X3N0YXR1cyA9Cj4gUFJNX0hBTkRMRVJfR1VJRF9OT1RfRk9VTkQ7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gQUVfT0s7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKG1vZHVsZS0+dXBkYXRhYmxlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZmZlci0+cHJtX3N0YXR1cyA9Cj4gVVBEQVRFX1VOTE9D
S19XSVRIT1VUX0xPQ0s7Cj4gQEAgLTMwMiwxMCArMzIzLDYgQEAgc3RhdGljIGFjcGlfc3RhdHVz
Cj4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+IMKgwqDCoMKg
wqDCoMKgwqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEFFX09LOwo+IC0KPiAtaW52
YWxpZF9ndWlkOgo+IC3CoMKgwqDCoMKgwqDCoGJ1ZmZlci0+cHJtX3N0YXR1cyA9IFBSTV9IQU5E
TEVSX0dVSURfTk9UX0ZPVU5EOwo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBBRV9PSzsKPiDCoH0K
PiDCoAo+IMKgdm9pZCBfX2luaXQgaW5pdF9wcm10KHZvaWQpCgo=

