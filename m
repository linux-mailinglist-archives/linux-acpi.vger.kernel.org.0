Return-Path: <linux-acpi+bounces-15150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFFB04690
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 19:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA2F4A23B4
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B627265611;
	Mon, 14 Jul 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hx1M/nYQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BF265298;
	Mon, 14 Jul 2025 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514459; cv=fail; b=V8yRihTaj9qCosbaXrqUsYHKoLOdlG1771UBQoQ5sPnSMnAhns3p5xWZey89uBwzk6No1vnL0jR8NuuMwMkQaAfFtdn7VU1eE0/wHka03QVRlDrbjoCkgNOcsGTN9b1WxR/TGksQcx63UOicUTwVKl/2DFQR1IX0oe9qlGfAid4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514459; c=relaxed/simple;
	bh=LtZHh2Iqz2ulrhVnCvHcOOwvless+kMQT6zONJalQw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTjXdCi4qB2Yh1ATAW6na3wKtqLrFUDmpiFqNatQe+W1g6ckVikLZVeKEq3kqRT6kikhEdud1QPW2f5QDfwCTA/uXlaRkWxwNv9d3gMeqT5U2gEFVdENs+ZrZG/jzrgRUDKkrV7RfWe/nzqgecw7telLXfB6lu0AQv5Vpn9BPgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hx1M/nYQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752514458; x=1784050458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LtZHh2Iqz2ulrhVnCvHcOOwvless+kMQT6zONJalQw0=;
  b=hx1M/nYQGRtWLajcPg+qSrh/HAY8SuLbkam+E9UnL2/BM/jAGj/6BmAK
   Snuk5GGgHXYOM7Q0y8PECvjXC66dr8nr5Tgvhp7bS3uZPuK+VBZ35jH9Q
   zqOxjbUu1vAOlVbDDyyoMO+Wf64jwOnWrI9x3uRUi/TjU26Btol7gbIEg
   5y+/jRSdieSRIxvZ2vV52WrAgWb7ubSBj4GHQb1CHi/aqoA4MKDthdXlA
   cgvqP4t6kOMkxj0Mup33vZeikLzwrBGkXQBzjQMjym1fLVRzIWm17/ABP
   kMWSqocPQjnVLDX9aMwrTBr1BWN7gPEo+f1iGIypO6JEqLItf2l3nOskx
   w==;
X-CSE-ConnectionGUID: rL1rKpvyQ46ms4aRtfXnUA==
X-CSE-MsgGUID: IlKu2MzDQw65nOtorgsRgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54424191"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54424191"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 10:34:16 -0700
X-CSE-ConnectionGUID: o4eCNl0hSO6KtcIOX3n2Og==
X-CSE-MsgGUID: kAyhd689S3a2viRW8tE/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="157337715"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 10:34:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 10:34:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 10:34:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 10:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2pAh8tan65DlB/Vam/91WCAO8+l9QBgxVG1taW3MYBOo9T5U5vCYiG1m6mxqshSJ3M3vk9XRCZNIba3LXazuRNpYgJNRsQiMTwdHAgnrobHAFoI+/qB2+UHiIZZ2ZeH15nSJW+6Xlx6Giq8kPt7ob3SjnVH5Dwt2FEFUI4FXDy0eUmjHUoHJaAPTuCz27HzI+6MzMZ+YwB75m5ckV2DN6GyBnB4wnL20M5HCT7bAuaot+thLLC+VlXoJWx6nJZZN1CXSXBXAggi4AfhRZ9SRINNEWHAxqx7HbEMsHXWANM9H2Y7qvY5NivR2Gf4SfopF4KF3BtrolbUhYORduzW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtZHh2Iqz2ulrhVnCvHcOOwvless+kMQT6zONJalQw0=;
 b=cbwvO/Xukc3gWMU94eOG0COyZs6/i9l7udbMNMfSudKgQQFD4+2A+uM96z2LY0Q0DYKXENoI63sIMuyhtVnGSrvI6WHLtmxKp6nOHvxzQgdQJa492B2SaamO10gch4I7em7sezwiWRo93FVAdAQDw3CN9xJytcAmIO8FdMK29fuwW28CrYoHKvuXWY45unVLRaNbM8KgJzQZ7ZhBo4b9KDhBL7ykDH4lngnpCzrY+FF4SsxlX5VkdDjCgRmngNrlrybQZT7HcEVpLQtyfBWsegJCMLzGCEJMC6ulBQwcsxlpen/iDgGw2SVKhB5G1mTRgwyK148frbyh9kqBPX5DOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB8832.namprd11.prod.outlook.com (2603:10b6:208:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 17:33:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Mon, 14 Jul 2025
 17:33:45 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, "Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [PATCH] ghes: Track number of recovered hardware errors
Thread-Topic: [PATCH] ghes: Track number of recovered hardware errors
Thread-Index: AQHb9OBy0msNHAJLb0CCMVEuXQ5eELQx2rEAgAAFjlA=
Date: Mon, 14 Jul 2025 17:33:45 +0000
Message-ID: <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
In-Reply-To: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB8832:EE_
x-ms-office365-filtering-correlation-id: 1b142fa9-acf3-48a1-3b90-08ddc2fc957e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cGtVczZsVVh5TXM1SkU1cFZ0ZWd1bUtLS0s4VFFYWEhRL2ZpbDhOUDE4bnJs?=
 =?utf-8?B?TFJPdmVuQmg4SlBNcmxiTk8vM0x0amNkQmdVbG53RVZlUkFHQVFORnVFQ1BH?=
 =?utf-8?B?eFlHK0kvZGR1TVpxTmhhK0Y0S0ZXZHoxdUVwNTJmR3pJaUY1bCtWUS9xUHpV?=
 =?utf-8?B?cmsvWUI1UWE5VEN3aHJYS2lGYW51NE9YanVsWjdVMFAvNGpTL0dpSFR2MEJQ?=
 =?utf-8?B?V2JlV3U0RWhhdmg0M1hlTCtodlViK3R4cS9rbklWRFY5YkRVbEFpcHJIU1lE?=
 =?utf-8?B?ZmRKODR1dHBCTFVhdGp3TmtSa3EwR0FrZzlIdnh2OGJldmVLaTZyU2o1SGRE?=
 =?utf-8?B?eGdMQ1NRQ0VvNmtYeWlLNEVTaDFaOFVLNi96bkdBRW5XTmdzVTJLdWpaaXZr?=
 =?utf-8?B?WEhQQ3psN1B4UmxRYkx0VFVhRFFKUUhtaWs3Nk1neXZ2c2N4MHFuOGRWTUMx?=
 =?utf-8?B?VEN5N1pLdlcwRXZIT3Z6dHh0UHBqVTQ5ME90SHB4RURVa0pQYTNOcFJ5UHY5?=
 =?utf-8?B?elpST0IzdkM3WDBJc3hEVE14K3Z3Z3hMcml3MlFudVVGSE5aZFVObWorK1dh?=
 =?utf-8?B?YmZ3S3RQb0xCWGc4WklMN3p6bU5rWW94MGpUSGtkUGVCSGxCbXd2TlN6YXo2?=
 =?utf-8?B?T3V6S2NuRmtNamp5U2hSQS91Uml2TlNGYUl0UGxJNE8wY0J3NmRyeFJ1VURZ?=
 =?utf-8?B?N1hHYjNXQ0lTbGppZEVVK3dqNDZSTUg4TXpoS2UyOVFmTEY2Z2NNUGxBUkVu?=
 =?utf-8?B?d2F3OUNYaFl5WlBDQU8wQ3hHV0grWExGZElyckxBc1VLVHlERTVvMThmS2c4?=
 =?utf-8?B?aUJRNUdaTjhmMzdWZFJUcHVyNmxEeTJjMnhrdE10SndzajQ2bjBvbngralhv?=
 =?utf-8?B?dkZNdFdzb2hQbGFHRFQ0TEpreCtlRFcyWDNxN1FNL1ZlNmFHc0kzYkd1bTRm?=
 =?utf-8?B?MHh2YnBaODlBcGJNaExOWGxLa01vU1BVd21HbS9aUVJESnk3VFYxZTkzb290?=
 =?utf-8?B?c3dpbGJEbnZ2RXV1V29CQi9wWksrZlJ2a01HSDdnWjIva2h4djV4UGlnK292?=
 =?utf-8?B?VDhEVnU1MDdaRm00OWhhQlpqYU5UOHFLaEdXV1N6NjZJbTNTYWhZRER3TnV1?=
 =?utf-8?B?QnI0eThka3RSMTQ4NzYrREtzZGxhcjhBOENhT3Y3aG44Q3lRNWxSMFRjcjFr?=
 =?utf-8?B?RTNsNWMwY0UzZTQvcmhZTEp2S3V3NnBMK0ZFUHdwQnhmb1gxV1NZSVNGMGlx?=
 =?utf-8?B?MXk1Mlo3dHltU00rd0h6VktkY2JRRGw1Yi9PRUhCaHVVYW1iSWlIUU50SWRF?=
 =?utf-8?B?VEVRM01nZ29jRWtsZ3h3c3l0eVU0YlRkalMxMFcvWnZKWE5FeTcxSjg5TVBR?=
 =?utf-8?B?STE2c0J5a2kzb3hBRU42ek13SU5uR0pNaUVkMkd3Q0JIczV2dVBEMzkybXBF?=
 =?utf-8?B?Vlhyem1haGwyRjB6cmlnNHNlYzNZcWFvbWcyVGtSd250NnNFbXNzbTJxdUky?=
 =?utf-8?B?cDNwdGhqWE83Z05HUUZzZm84WXBsb1RvTWJMVm9iazBINVE1a0ZtM09RTVdo?=
 =?utf-8?B?dHhsc1h0QTcwRVZKbUhkNkpyQ08yUHNiK3d0OFR5ZTN5dko2K0hXTlgxTEN0?=
 =?utf-8?B?L0E5NFFCS0hkUGg3UXc1YjIvd0ZjaG51L0RVZjBkR1lzamZUK2FTQi9aaVc3?=
 =?utf-8?B?SzVhMmcyakpNU1NGWUU1MFlCV1c2YWN5QjA2bVJCUHROZTkrbmpCQkV1eHRs?=
 =?utf-8?B?MnBmRGg5enFwb1k2c2R5cWt3djF2RVJ0cmVYVGdtbFRURlB0bk5SUGlzdlIx?=
 =?utf-8?B?YmFVcHd6S3hRSUpiU0tuazUrc1Z3R0o4TVorcFA5dDBWS082ZUdVaURVTzlY?=
 =?utf-8?B?cmZjcm1qSWpiMWRoSkNQOHBwcmkzTlRMS1JEZkVyeUI4OG05NmJzTjZLb2dT?=
 =?utf-8?B?YS92UTZHcFJobkc5RklNMlJBb25EUDdIOXltOXc1eEV0NUFDOUJkYW15WVBF?=
 =?utf-8?B?OGRydkpPSGFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1lQZXQ5b3Q1dDExVWk2Q28xZ3pQNzZ0RTA1T3JiVmg5YVJYbmgvM3N0RTJT?=
 =?utf-8?B?QVpPZVk0UEdsNEY5ZFBzSG9SSHk1K1ZaSytoaUdyeGdXUjZoVnNJMit3VDhE?=
 =?utf-8?B?S2l3WmNnZ0g2dmtmU0ZJUGVweTdDY3pBRWo3Q1lMWm9EaE9rMVRCa1cxMDA4?=
 =?utf-8?B?TkJMallENTRVQUhGcTZOZHN2UnVudDZ1MzdRV2ZsRm13ay9FUHl4K1FCemF4?=
 =?utf-8?B?OC9qSmFvWm5xay96SS9MVXVncDlkRnMwSmttVGg0OG5MMnhwMGNvUEsyK1BK?=
 =?utf-8?B?UHlzU0RHV3IrM09jZmVGV1VOczZFNGsyY2pEbzFjUm5vWkpBVDAxSDZpRkxu?=
 =?utf-8?B?dHpxQk8rTGFPdGMrSjl0ZUc2YVpTM2t2SU90a0x3Z2ZMRkNTMjhtUUoyQ2VU?=
 =?utf-8?B?cXgzV2xsQjhqQ1MzQ0lXb0ZybVJEMHZ4Q1RONmd5ckdxS1ZUMUZYMmZiQjJo?=
 =?utf-8?B?UXJXWmI0N21qMjhpaG9qcjR4bnlGdjQ5bHVWUlp6K0ZxTWhldnNPeE5ud3lu?=
 =?utf-8?B?eFVLdFhwa3VhRytiNjQzZmE3YjZNTVVHbEp5azNEWEUvRmRvbC9Tc05jSm0w?=
 =?utf-8?B?endGZzZXNnJiRlNjUzhpcStJSm9xRWFUN2ViTXV5TnM2RFMveTR2TzVDQ0U3?=
 =?utf-8?B?KzZiN1N2bGhoZm9mT0F6RmtWaFlTWVgwa2RUaWRlcHZCdXdHWTlGcjVPd3Z0?=
 =?utf-8?B?U0VMc24xclVXSUY3eFhoODRvOTVaSS9TN1JnS28xSm5HZHF2bE8wS2FMbWR5?=
 =?utf-8?B?R1FWWFJZOWRLYjFmZWdnL0NkVUE2RkcrSDBXeXlVVG1VbzNLUGlZdmRSWHh2?=
 =?utf-8?B?cHYzeHlPTDFRSzRSeHBwaXRNaklmRXFHL3FBUlFjK090ZGJWWjVydXFxNTU2?=
 =?utf-8?B?TlFVWThXUy9VSC92bDJOdEtkOVBKdEN5RzVoYTZETlNXTThsOFNkVnQxZnpr?=
 =?utf-8?B?RXNjZFE5VFZIdTk3REIvWm5BZkRIOTNsT2Vmcm5odkNzWVZwZHlHeEovWnEv?=
 =?utf-8?B?dVhldnE4NVMzeTFIVGZRS21XcythTkFrQWpJWDBacEFXeVhTQVV2Z08weVQ5?=
 =?utf-8?B?cXVESzZGbGpjYXNGMjVoUkIrWTdhNzBZbEpLNlkwR0FWRDhSRzRlcHh3LzNa?=
 =?utf-8?B?Qm1hWmhDYWtZWmI0RG1hejl1Yk02N3U4eFowdHFONk1GQjVmU1FwZ2QwZEN5?=
 =?utf-8?B?aGVVYnF5a0dMOW5WenBaK1FqeTIxL095THc1aXpiMTViNmY0SElsS1VxSWd3?=
 =?utf-8?B?UVRvU0liRGFwTE16TGtWbEtMQ281Z01Ga0VuT2dyTHdIby9RNnI5dVZQUW4z?=
 =?utf-8?B?SWVZc1hid1p0QU5kcENtcWFzUFcvWUsydjBCc0hjdUw1VEs3ZmIzQ3FHdTdY?=
 =?utf-8?B?RGcvMGxHSXpiaDUxTTRNaEptVnBtajg5MXBYN3p5Rkl4OU1IcXRwMExkRjhw?=
 =?utf-8?B?S1pTN3l1ZGVCZ2dTM09WeVRNZW03ODhYSVpKMEJubmpCclpsMjU0enltaWZa?=
 =?utf-8?B?ME1pOHdCN0xaZVA4dlR0MDhVbHpKUFBGSldxeEp4YW1UUXJucjU3aTY2VkFG?=
 =?utf-8?B?Z09sZ0RNQlp1bng0VkYyR3o4bHVEWm1tRzJReTQ5YWdQMVE3Y05rc25vSG42?=
 =?utf-8?B?cEFNL0lRcEVnSkM5Qm9PWmJsZVB1NUlvbkZ5TDBVcHZIMzdyTHlJbkVxTkNx?=
 =?utf-8?B?ZnM2VzhoVnAwNVJ4TzQ3MHBmcUFJY0RUVXlEL3RsU2JSSkFKR1pkWnBUL2sz?=
 =?utf-8?B?WWYrMWpHakF3ejFXQzBlTmtQMjNnaXhXYkY1cFRuWXpuQXlJSmZkcldqWlBh?=
 =?utf-8?B?SjZtK2ZnQXZ2b1VwRnB2SWhqYzBDTkNSV3NWbVJiNXR4TDljMVp2aDhKaGt3?=
 =?utf-8?B?Nk1NMmFwWTVYRFl2NGljRlZ0N1VtOWFnUFZWMEgwOVdjRC9zTEl2cmFvdEpK?=
 =?utf-8?B?MGFTL1dvRTlLbXJJNTUrbWsvMmVRbC9RVm1zTEJSaEtUdFlsdGphWmhZaGNR?=
 =?utf-8?B?Q2hBcS9acFJwV1JRSzhvb2l0WFZOdGNCakZOTEVyemNVdWdMYVVpYXFsa2pn?=
 =?utf-8?B?N1hZUUZ1YzREamtPWno4YXBtN0pHNzBiTGwvSzljd25NNnhOdHJpTG9EQkc5?=
 =?utf-8?Q?1NSLhuwFdA1l80VQt+AzmHiT7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b142fa9-acf3-48a1-3b90-08ddc2fc957e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 17:33:45.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Po+wTG9ldxhtoD02BIaufNVhFD+SOcmb4oiaipTj+0BWSx6fInnO1DLwjxMfyV9SerYXT37g+wHaMYbA7wl6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8832
X-OriginatorOrg: intel.com

PiBJZiB5b3UncmUgZ29pbmcgdG8gZG8gdGhpcywgdGhlbiB5b3UgY2FuIHBlcmhhcHMgbWFrZSB0
aGlzIHZhcmlhYmxlIGFsd2F5cw0KPiBwcmVzZW50IHNvIHRoYXQgeW91IGRvbid0IG5lZWQgYW4g
ZXhwb3J0IGFuZCBjYWxsIGl0ICJoYXJkd2FyZV9lcnJvcnNfY291bnQiDQo+IG9yIHNvIGFuZCBh
bGwgbWFjaGluZXJ5IHdoaWNoIGRlYWxzIHdpdGggUkFTIC0gR0hFUywgTUNFLCBBRVIsIGJsYSwg
Y2FuDQo+IGluY3JlbWVudCBpdC4uLg0KDQpOb3Qgc3VyZSBJJ2Qgd2FudCB0byBzZWUgYWxsIHRo
ZSBkaWZmZXJlbnQgY2xhc3NlcyBvZiBlcnJvcnMgYnVuZGxlZCB0b2dldGhlcg0KaW4gYSBzaW5n
bGUgY291bnQuICBJIHRoaW5rIE1DRSByZWNvdmVyeSBpcyBxdWl0ZSByb2J1c3QgYW5kIHJhcmVs
eSBsZWFkcyB0bw0Kc3Vic2VxdWVudCBrZXJuZWwgcHJvYmxlbXMuDQoNCi1Ub255DQo=

