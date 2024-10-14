Return-Path: <linux-acpi+bounces-8754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5EE99CAF6
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 15:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B92B226FF
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666FB1AA780;
	Mon, 14 Oct 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIlpD7Q8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246F16190B;
	Mon, 14 Oct 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911152; cv=fail; b=cvk7rKV/ag199J8o8BubOVkan/erYlvTgrM5eveLu8wcnGxK9Y6eFR7tQaA5AFwTzcGleNsoyWha1ikTUvkGOBFhM9xLazmndoBzDHhc5znpAulsue7yhlz4MTYx67+j5SsTiHqHp6jslk2tqDnaqI3pwAO/4qBe6iFTXuR7cnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911152; c=relaxed/simple;
	bh=fy+phpO5KeU7BTJAnoZe3M7ihAXS2XONEY//fGK87VA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9WJQnJGzkWYtjgYtyyq/fbIKJuklcQkZhMtDDcZEfYrHF8OeKpqtGQLGohvwKiHUzXXvqLp8DFuV5dzzUkhT5jylYdTWML5zXCdnD7bTWxwE852DhTeq9/EwfP8rQoYZvK9PFazkfgYvDCgYckBskHXNqyiBSOXuAzqN2kIXmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIlpD7Q8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728911150; x=1760447150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fy+phpO5KeU7BTJAnoZe3M7ihAXS2XONEY//fGK87VA=;
  b=UIlpD7Q84yG6aYBrRoLjDq2mTbc11RsMOeIk2ix4OFLC4xgoZEX2FPM2
   wlHIeiy4jvlrDeNjC4cQK+wAyTMNWC/OQzbZrVTu6Wqe1tDYWn2zwb00y
   3t3Vo7hQyvEIgXjtslXPDqDthHsvSaRCaDYP0G5df5CEG+mftIygyriAc
   8JHoV6KrRE17q9BT9ZdXwP3dsdJYj1CcbybbfGP8RPzgqpBNWizOtsyx7
   3VmpmpfIs3Nq+RV50XYLeKIVRs9U9mOwzyZaW+/G+tdhQrim+TXWht42L
   TfUMXBJvqtgY11N53zVMOHXscETEA0S7IazqN2Y1d7ZS++ECYgq5Ijx3Q
   Q==;
X-CSE-ConnectionGUID: yx+j0V6qSMiZ3QzTf431Og==
X-CSE-MsgGUID: vwQ5zxxVQy6trG59GdrDdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="27746030"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="27746030"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 06:05:49 -0700
X-CSE-ConnectionGUID: a2t8ToHWQGy7/3e+U318ng==
X-CSE-MsgGUID: r7nKTXEgR1qaOoHaolAcXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="115024179"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 06:05:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 06:05:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 06:05:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 06:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gANc/XuHl5rJ0oKahjPUfkWzRxMWtrir3DYoRqlDA4IOk21dMZcRV3SML78i00XV85Jx9XTkFG2DS7YE+xAFXktMK/vq59yB6ivWrrdFLJTCFKKA1UDHL+1mwA/JZfwEJ9tuyxVMhYDoNZfL+H/laCUL/i0TlfkrlKLjK+NsmGkup3xGLexXQZeDm0bh15oDjAQZxtg4fUZLa8aNw2YvOugsshiCaqqRQMsvexxEkoR9FLQkd2o+ZewJ0jAfH11S1RwW1u/U7BKYocTbdTcxB37CtBXsc8UXPJup8L5IRyg42c6nt/A3Uw1KgQduXpryrpYMPbovrEk3HEXMyPHKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy+phpO5KeU7BTJAnoZe3M7ihAXS2XONEY//fGK87VA=;
 b=mbTU+O8bk4iEkPFFeGHcOsqXP9FfjBZg4EXJGO91iFCxmuVpwkcpD4Rx+6y2RTYFZssnU9cPJy3fysOzdIQzZXYQu6Rmg4TbT6ACHmVFrhgwLO63/K7dppChqrDwLm1Nc1pP5pFLzFtgmT9hJEAwvqjY425LRoJgNNcefsIxJnkmsZGxLkAGsReVjQIKvgiSsbLUbWW21DigYIbaoXLl3K413x8HceCuWElKO09e6pxwPDzsc1qOgk7CYZARU4ntuRu5PiR7WYlW/+oGwJw0azTASpT9voyS4H8jq1GZfgKZmdV8hNw9ClhZMkKV+dx7ieNO2wt6zMZX/G4snEZlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 13:05:43 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 13:05:42 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "jmattson@google.com" <jmattson@google.com>
CC: "ajorgens@google.com" <ajorgens@google.com>, "myrade@google.com"
	<myrade@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Tang, Feng"
	<feng.tang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jay.chen@amd.com"
	<jay.chen@amd.com>, "vladteodor@google.com" <vladteodor@google.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHbG1vT9lbwQmPJwk69cBdGq4KcNrKAxaAAgAAYfoCABV6zAA==
Date: Mon, 14 Oct 2024 13:05:42 +0000
Message-ID: <f590669a7fa8d3e3f4d24ae3ed2d864ac14fbef8.camel@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
	 <20241010213136.668672-1-jmattson@google.com>
	 <f5962c02ea46c3180e7c0e6e5e1f08f4209a1ca2.camel@intel.com>
	 <CALMp9eQ9v0Ku0Kcrb2mwz6hb5FJRPKT1axyhX5pQ-nhrLzBY4g@mail.gmail.com>
In-Reply-To: <CALMp9eQ9v0Ku0Kcrb2mwz6hb5FJRPKT1axyhX5pQ-nhrLzBY4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BN9PR11MB5258:EE_
x-ms-office365-filtering-correlation-id: 89764ee1-ffec-43b9-a528-08dcec50e8dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dWhsT2ZlL2xwYW1uKzhoK3ZGWHdDZEFpdVV2dWlGR21INy81eFRPUUl4a1J1?=
 =?utf-8?B?d2FaVW94VFY3NFFoMzRYSVNHYUFuSWtRdGovL09NQzFzbGk2WmN5OEFlZHlK?=
 =?utf-8?B?U3JFMTdPKyttaXpnL0NOWFlKNTUwcytKdkg2UENCbW1kZVVmR2trTGZhSlFJ?=
 =?utf-8?B?K012ZXJYMnlmWmtPWjMrSFhDZkwxSHAyUEZ4YkpGelBzeUEwdGlNamtpMG9n?=
 =?utf-8?B?M1VHdzdLUEJkc0owZk1IUGNOeC9zdUpHWGk4WkVpWDZ3OVlYcjNrdW9ueFM3?=
 =?utf-8?B?clBKUGw2QmlUcTNDT2RBNUVDRVRoUkxPU1B5RWZvd3FZODdIMnFkdUNDZzBW?=
 =?utf-8?B?eTZtb0orUnJ6eWhaSEFqZHhFc3RTcitCSUxMWmtveG1yclV1Qk9pREV2SEV1?=
 =?utf-8?B?M0F1WERvN1l2T25rdkJ1T1lhc0V5MVQrMWJIeUJ2dGU0bi8xRVVWSXIxVG56?=
 =?utf-8?B?Y0cvY3pLUU13NXNmc21JNC9tQit5aUdUNXNOK29Gc1VKZytnNEJPelJPR2RS?=
 =?utf-8?B?ejR4R2tZL2Uxd0Mxd09pSmxHZzdVdXhmK09yY29CV0M3TDhMdFZBNjhlRm05?=
 =?utf-8?B?MXdGQ1VBWVlwUUoxL2oyRWxhVFJobVhjSGxWMWxRWmVCNkRONE9UV1JxUEYy?=
 =?utf-8?B?Z0N4bStHVHhEUlNPWGtNdWxhV2hlNnI1ZjR4WExaL1ZUQ1JVOE9scjFmU21Q?=
 =?utf-8?B?M0hFV1VZanArN0swa2NhbnlHMjJ4S2JlOC91M25PVWhSZnlvTEZib3B0TUZu?=
 =?utf-8?B?eE1WaTFydzZhN1dES3ZZSEc4dWdvYXhxZmMzWkRrYWxGUkRqUll4bWhjc0ZX?=
 =?utf-8?B?b29FdWkzRGJJSkFmZXNtWERta215Mi9PeDNoRllUQ2FPMVNPZXg2cUlLK0FD?=
 =?utf-8?B?aXhIanllMzZIVis4QVVzbXB5YkhZSFNRMlRUbjRpbEFGYkZRYXRCMCttQjJ4?=
 =?utf-8?B?TzZnSXozOWtVUnNOZm81U0w4MUdhNzRxMDVpbnVkSkVFRyszN3JVVTdnWDdr?=
 =?utf-8?B?N0J1T0tSQlhlR25xTi9QTHVYdjJndXJvRFpsV0NXRXRNeHpOdHBDeUpqaE9m?=
 =?utf-8?B?VnVtZE5qL2R0aXQ2bVB1WEV5c2J2QVF4RFBzblp5em04VGRMSGt0WDRIZ0hv?=
 =?utf-8?B?V1BtQ0hZZkkrYmJvZ0NYUk95L2REaXM1UllkOFpNYVJLMGJ1NDZod1B0dHlX?=
 =?utf-8?B?SHFoTUx4Y2ZSNXdVR21IUmFONldVUDlVRmxKRWZubkk2N2liM0QyRkRUMlBn?=
 =?utf-8?B?ZjZSUDQrY01SUlp2YWo3RHFmaWRKRGJiTCsxTzFDVTk5MmJabnpZVEk1RWl4?=
 =?utf-8?B?bDh5UEF6a0dJSnBmN2E2R3hlMzhlTTl3T3I1RkxyV1Bqb1oyaDcyUWNPdUJz?=
 =?utf-8?B?Wk9RMWo1TGtZRFpDWWQ3dlp4QmFqSy96Tm9vRjMyTmJ3MjBBU2tBYTVrSUEv?=
 =?utf-8?B?dXB4clhjTVZNUk5aaEQyZ2s1dDllSU1MREZWM3VyTEJZTHA4eW8yeE5uYVdI?=
 =?utf-8?B?U1drS0RkU0V0b3BWK1orOGZRejNIU3NaV3FyZFZ0WUJGQWJFRWpBaE5SV1hx?=
 =?utf-8?B?WFdkek9aTTBCc1dmQUhGSkRubHBmMGIzN1I4MCtWZDBjaVA1b3p6aUpTcEVL?=
 =?utf-8?B?R3YrNjhCMmhLRCs0Z1daS0pvQk1VWUJsb3JDdDNFMTExUnowVzJKQTVsMUJV?=
 =?utf-8?B?N0V2RGd3L2ExNnpsMmlNaTRLd1prMkROUXVhRmNTYlRVaUdPSjArUStEdlh2?=
 =?utf-8?B?NmRDZ2g0SG5qL3czSkpUbTVGRWlNZU9QMDQzb2g2RDNSQWVNM0p4SUs4dmo4?=
 =?utf-8?Q?JKdV1LBaMiQd2ic6MBES46LT2SCDur2tt5AZY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGw3U0FUdnZwRS9aV0ZmUzdTaldzdEJuQmZHM1pIUTJpUTN4WEh5cVR2dzVH?=
 =?utf-8?B?QlBuczA4Y2FUaGpvNlEwQlFOd0ZmendPUXhCUklSK1Z4LzFHSzVvUk5ESXlV?=
 =?utf-8?B?TG9NOTBWV2p1VDRBWUh3TlhZSXAwaTFueHlHVFB2QlMzK0lzaWRYbUFPS0xZ?=
 =?utf-8?B?YzdSU1FJS1pObUptZlZPcjd2Ny9LbzZlNmExbEp1YW81M1F6VzRVNWZmck5y?=
 =?utf-8?B?elVQeXhFeXB2M2xNOG1NOU1CajB0U3pWdTd1anRwRlpBUXp6aWx5c2N0MFdI?=
 =?utf-8?B?R2dEQU50SUxqVnVGUDZjUXlRRmp2TGEybUVva1FsWlFxTjhaSFdhNTRpRVh1?=
 =?utf-8?B?ZzlQRzUrL2FJRmVBcUkwY3FNbTNwdmdOalhYOWt6ZDIxYzZLNHlzUll2NVVB?=
 =?utf-8?B?VVU5TCt5cU5MRDJybmhuUVZDczhudmw2bjV1bmhHY1pHQ1BiSkVJU2hTYnBn?=
 =?utf-8?B?dUgxMzlVZTBXUUJ0ZEVsdnhRak9sakxyWEFOZGFXUFBhU1Q2Y0FTZkZmVm5p?=
 =?utf-8?B?c01mQ0RMcjVrYzZsc2dJeU9SZkRNK1ZSZEpSTGRNQmV2Y2I4dVRQbklHSi80?=
 =?utf-8?B?Mm1qK3Y5dzRHbjN2bFV5SVJxcDVqVUs3Mjkxbm83c2NZek1qOEpNUkIrc3BO?=
 =?utf-8?B?VVIwdFZtemVXWmpSUng5QVJMVGxtQWNtT3lVQmwvbmpSUDlCcHRCclpoMFox?=
 =?utf-8?B?MjhvOHpzbkZUM1dYKzQxOVhReTVzVHVNVkZvckxSVTQ3ZkdFSy9JcnJMYVNK?=
 =?utf-8?B?TWQ1RW9zaTIvRERqLzVPbU1sQldkcG0zS3pSYUk1V2FBeG5YRkV0emtYeVFP?=
 =?utf-8?B?RG0rdmhBUWxaRHhuS1pvMDBEWVhQalp6QlluakpOT1ZFOWF5RTNBOUxQVjE0?=
 =?utf-8?B?OStheUFOcU96RitrZ3BUbTNJWDJheWhLQVVTekg2T2JzTFhFcXd1L0QveWxN?=
 =?utf-8?B?Y2JYdmFSNm55VkxYS3Y3bmwvME9nakYvK2V0UUdBTUhEay9hcENYMnFXVXVH?=
 =?utf-8?B?bENVemVsMVdpMnhaQUVXZ2FBbCtqdG5icXM2QjQ0MFFoY21rVElxQ1VjVVcz?=
 =?utf-8?B?VytsYlhrZHYyODFVbjA4UFZ6eE84bVRxMnY3K2hTbWRhREdQdWkxYlNZRXVY?=
 =?utf-8?B?RE9rN3BNcEVmNGtXT09QWW5iZmNZM0RDKzlXQ2QzOU4zMXdRSEE3dzk3Vk1m?=
 =?utf-8?B?OHZuVVJJcE15UkdJWmhRbzBMZHQ3N20ybC9vemFQL3ZycWJ5dHdNRHVYWEFp?=
 =?utf-8?B?QXp5VWduVEI4c2M3THVMY0FyMUkyZWZGdWV0RXF3SnYrQ1J0ZnA0U293VXZC?=
 =?utf-8?B?R1ppTDNLdmNMcE5ZbnJtZmlQQllmV3hRaStKUnFyai9HbUZzc251aWNTTzFW?=
 =?utf-8?B?a0Y0Z2NVaHJnL1dBbGxDU3lNcjlHcjFNVlBIVll2ekF2a2hESVRxUWlYY1Fi?=
 =?utf-8?B?eTQwUExwN28rVHlJdXhWRk91SEJaNGovZ29PTjk2ZGRCYTZEak5SYUtOcjRX?=
 =?utf-8?B?WDRuem8wRWRFSGMwdW1FRElJUHNCcFdsYTFudm12Zld5cWlSWjJnQ1lKRHlT?=
 =?utf-8?B?NE1kb2w4aTN1dWdCMlVTZ1hDZXFWYWJ0YWtmZ3l5b0JMWnhxaklzRU5lZnVa?=
 =?utf-8?B?a2JLVjJBMHVKTVJ4OGEzcU90dHZvdndkZEtSdnZLdEVKYVc0Q2luVS9XeWhm?=
 =?utf-8?B?YlVJMWRZNTFRV3g2V0tyY3Q0WHg3VDdRQUZaRDJaL1JmbG94elZSUCtWcmN0?=
 =?utf-8?B?dUhTY2hpellleFZMOTBrR2xHb0IrdXVQTHFWYlRGenR1dHpEYmppS0FGN0k4?=
 =?utf-8?B?VW9jV2dOSUdpa1pCU2lkdlcyVTlNc1llQnJJK2xzVXpxZmUvb3RVMHlFeEJF?=
 =?utf-8?B?dXFYR3ZiM1hGVkxRNHcyMzUwend6ZGhxSjVJTUJ0TUExOEt1ZS9iYlJLaWVX?=
 =?utf-8?B?ZEMzVWJuODRpVE9xS1F3WU5HcjR5RXgvUkw0NDhqTm5BQXhPUkFvYkNITE8w?=
 =?utf-8?B?RExyWEF4Ym02REg4SUlXZEcvZ2E0MnJxRHBXcmdQUWxoTlY0S2ZVUHpqOGly?=
 =?utf-8?B?WnVPd3Vpc3NNa0c4MGxGcnJQcDJwS0tsUkdlRXV1TVFFZDJObVQ2azh0aElk?=
 =?utf-8?Q?xXmWQxTLdP+7rjIxs/Lgtj+0c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2397B1F415DAE46944247A1D6744D78@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89764ee1-ffec-43b9-a528-08dcec50e8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 13:05:42.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+IZQHuUJVvVmqbkf2j542PiLeE0fh0pRUHqRQqBuMX3EOQ0t+FjJSNjhUFEjHJ7uNmhsxbWJP4WZdJRWZKzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
X-OriginatorOrg: intel.com

PiA+ID4gDQo+ID4gPiBUQkgsIEknbSBub3Qgc3VyZSB0aGF0IHRoZXJlIGlzIGFjdHVhbGx5IGFu
eXRoaW5nIHdyb25nIHdpdGggdGhlDQo+ID4gPiBuZXcNCj4gPiA+IG51bWJlcmluZyBzY2hlbWUu
DQo+ID4gPiDCoFRoZSB0b3BvbG9neSBpcyByZXBvcnRlZCBjb3JyZWN0bHkgKGUuZy4gaW4NCj4g
PiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvdG9wb2xvZ3kvdGhyZWFkX3NpYmxpbmdz
X2xpc3QpLiBZZXQsDQo+ID4gPiB0aGUNCj4gPiA+IG5ldyBlbnVtZXJhdGlvbiBkb2VzIHNlZW0g
dG8gY29udHJhZGljdCB1c2VyIGV4cGVjdGF0aW9ucy4NCj4gPiA+IA0KPiA+IA0KPiA+IFdlbGws
IHdlIGNhbiBzYXkgdGhpcyBpcyBhIHZpb2xhdGlvbiBvZiB0aGUgQUNQSSBzcGVjLg0KPiA+ICJP
U1BNIHNob3VsZCBpbml0aWFsaXplIHByb2Nlc3NvcnMgaW4gdGhlIG9yZGVyIHRoYXQgdGhleSBh
cHBlYXIgaW4NCj4gPiB0aGUNCj4gPiBNQURULiIgZXZlbiBmb3IgaW50ZXJsZWF2ZWQgTEFQSUMg
YW5kIFgyQVBJQyBlbnRyaWVzLg0KPiANCj4gQWguIFRoYW5rcy4gSSBkaWRuJ3Qga25vdyB0aGF0
Lg0KPiANCj4gPiBNYXliZSB3ZSBuZWVkIHR3byBzdGVwcyBmb3IgTEFQSUMvWDJBUElDIHBhcnNp
bmcuDQo+ID4gMS4gY2hlY2sgaWYgdGhlcmUgaXMgdmFsaWQgTEFQSUMgZW50cnkgYnkgZ29pbmcg
dGhyb3VnaCBhbGwgTEFQSUMNCj4gPiBlbnRyaWVzIGZpcnN0DQo+ID4gMi4gcGFyc2UgTEFQSUMv
WDJBUElDIHN0cmljdGx5IGZvbGxvd2luZyB0aGUgb3JkZXIgaW4gTUFEVC4gKGxpa2UNCj4gPiB3
ZSBkbw0KPiA+IGJlZm9yZSkNCj4gDQo+IFRoYXQgbWFrZXMgc2Vuc2UgdG8gbWUuDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiAtLWppbQ0KDQpIaSwgSmltLA0KDQpQbGVhc2UgY2hlY2sgaWYgYmVsb3cg
cGF0Y2ggcmVzdG9yZXMgdGhlIENQVSBJRHMgb3Igbm90Lg0KDQp0aGFua3MsDQpydWkNCg0KRnJv
bSBlYzc4NmRmZTY5M2NhZDI4MTBiNTRiMGQ4YWZiZmM3ZTRjNGIzZjhhIE1vbiBTZXAgMTcgMDA6
MDA6MDAgMjAwMQ0KRnJvbTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KRGF0ZTog
TW9uLCAxNCBPY3QgMjAyNCAxMzoyNjo1NSArMDgwMA0KU3ViamVjdDogW1BBVENIXSB4ODYvYWNw
aTogRml4IExBUElDL3gyQVBJQyBwYXJzaW5nIG9yZGVyDQoNCk9uIHNvbWUgc3lzdGVtcywgdGhl
IHNhbWUgQ1BVICh3aXRoIHNhbWUgQVBJQyBJRCkgaXMgYXNzaWduZWQgd2l0aCBhDQpkaWZmZXJl
bnQgbG9naWNhbCBDUFUgaWQgYWZ0ZXIgY29tbWl0IGVjOWFlZGIyYWExYSAoIng4Ni9hY3BpOiBJ
Z25vcmUNCmludmFsaWQgeDJBUElDIGVudHJpZXMiKS4NCg0KVGhpcyBtZWFucyBMaW51eCBlbnVt
ZXJhdGVzIHRoZSBDUFVzIGluIGEgZGlmZmVyZW50IG9yZGVyIGFuZCBpdCBpcyBhDQp2aW9sYXRp
b24gb2YgaHR0cHM6Ly91ZWZpLm9yZy9zcGVjcy9BQ1BJLzYuNS8wNV9BQ1BJX1NvZnR3YXJlX1By
b2dyYW1taW5nX01vZGVsLmh0bWwjbWFkdC1wcm9jZXNzb3ItbG9jYWwtYXBpYy1zYXBpYy1zdHJ1
Y3R1cmUtZW50cnktb3JkZXIsDQoNCiAgIk9TUE0gc2hvdWxkIGluaXRpYWxpemUgcHJvY2Vzc29y
cyBpbiB0aGUgb3JkZXIgdGhhdCB0aGV5IGFwcGVhciBpbg0KICAgdGhlIE1BRFQiDQoNClRoZSBv
ZmZlbmRpbmcgY29tbWl0IHdhbnRzIHRvIGlnbm9yZSB4MkFQSUMgZW50cmllcyB3aXRoIEFQSUMg
SUQgPCAyNTUNCndoZW4gdmFsaWQgTEFQSUMgZW50cmllcyBleGlzdCwgc28gaXQgcGFyc2VzIGFs
bCBMQVBJQyBlbnRyaWVzIGJlZm9yZQ0KcGFyc2luZyBhbnkgeDJBUElDIGVudHJpZXMuIFRoaXMg
YnJlYWtzIHRoZSBDUFUgZW51bWVyYXRpb24gb3JkZXIgZm9yDQpzeXN0ZW1zIHRoYXQgaGF2ZSB4
MkFQSUMgZW50cmllcyBsaXN0ZWQgYmVmb3JlIExBUElDIGVudHJpZXMgaW4gTUFEVC4NCg0KRml4
IHRoZSBwcm9ibGVtIGJ5IGNoZWNraW5nIHRoZSB2YWxpZCBMQVBJQyBlbnRyaWVzIHNlcGFyYXRl
bHksIGJlZm9yZQ0KcGFyc2luZyBhbnkgTEFQSUMveDJBUElDIGVudHJpZXMuDQoNCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQpSZXBvcnRlZC1ieTogSmltIE1hdHRzb24gPGptYXR0c29uQGdv
b2dsZS5jb20+DQpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTAxMDIx
MzEzNi42Njg2NzItMS1qbWF0dHNvbkBnb29nbGUuY29tLw0KRml4ZXM6IGVjOWFlZGIyYWExYSAo
Ing4Ni9hY3BpOiBJZ25vcmUgaW52YWxpZCB4MkFQSUMgZW50cmllcyIpDQpTaWduZWQtb2ZmLWJ5
OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQotLS0NCiBhcmNoL3g4Ni9rZXJuZWwv
YWNwaS9ib290LmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgYi9hcmNoL3g4Ni9rZXJuZWwvYWNw
aS9ib290LmMNCmluZGV4IDRlZmVjYWM0OTg2My4uYzcwYjg2ZjFmMjk1IDEwMDY0NA0KLS0tIGEv
YXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9i
b290LmMNCkBAIC0yMjYsNiArMjI2LDI4IEBAIGFjcGlfcGFyc2VfeDJhcGljKHVuaW9uIGFjcGlf
c3VidGFibGVfaGVhZGVycyAqaGVhZGVyLCBjb25zdCB1bnNpZ25lZCBsb25nIGVuZCkNCiAJcmV0
dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyBpbnQgX19pbml0DQorYWNwaV9jaGVja19sYXBpYyh1bmlv
biBhY3BpX3N1YnRhYmxlX2hlYWRlcnMgKmhlYWRlciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQp
DQorew0KKwlzdHJ1Y3QgYWNwaV9tYWR0X2xvY2FsX2FwaWMgKnByb2Nlc3NvciA9IE5VTEw7DQor
DQorCXByb2Nlc3NvciA9IChzdHJ1Y3QgYWNwaV9tYWR0X2xvY2FsX2FwaWMgKiloZWFkZXI7DQor
DQorCWlmIChCQURfTUFEVF9FTlRSWShwcm9jZXNzb3IsIGVuZCkpDQorCQlyZXR1cm4gLUVJTlZB
TDsNCisNCisJLyogSWdub3JlIGludmFsaWQgSUQgKi8NCisJaWYgKHByb2Nlc3Nvci0+aWQgPT0g
MHhmZikNCisJCXJldHVybiAwOw0KKw0KKwkvKiBJZ25vcmUgcHJvY2Vzc29ycyB0aGF0IGNhbiBu
b3QgYmUgb25saW5lZCAqLw0KKwlpZiAoIWFjcGlfaXNfcHJvY2Vzc29yX3VzYWJsZShwcm9jZXNz
b3ItPmxhcGljX2ZsYWdzKSkNCisJCXJldHVybiAwOw0KKw0KKwloYXNfbGFwaWNfY3B1cyA9IHRy
dWU7DQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgaW50IF9faW5pdA0KIGFjcGlfcGFyc2Vf
bGFwaWModW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICogaGVhZGVyLCBjb25zdCB1bnNpZ25l
ZCBsb25nIGVuZCkNCiB7DQpAQCAtMjU3LDcgKzI3OSw2IEBAIGFjcGlfcGFyc2VfbGFwaWModW5p
b24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICogaGVhZGVyLCBjb25zdCB1bnNpZ25lZCBsb25nIGVu
ZCkNCiAJCQkgICAgICAgcHJvY2Vzc29yLT5wcm9jZXNzb3JfaWQsIC8qIEFDUEkgSUQgKi8NCiAJ
CQkgICAgICAgcHJvY2Vzc29yLT5sYXBpY19mbGFncyAmIEFDUElfTUFEVF9FTkFCTEVEKTsNCiAN
Ci0JaGFzX2xhcGljX2NwdXMgPSB0cnVlOw0KIAlyZXR1cm4gMDsNCiB9DQogDQpAQCAtMTAyOSw2
ICsxMDUwLDggQEAgc3RhdGljIGludCBfX2luaXQgZWFybHlfYWNwaV9wYXJzZV9tYWR0X2xhcGlj
X2FkZHJfb3ZyKHZvaWQpDQogc3RhdGljIGludCBfX2luaXQgYWNwaV9wYXJzZV9tYWR0X2xhcGlj
X2VudHJpZXModm9pZCkNCiB7DQogCWludCBjb3VudCwgeDJjb3VudCA9IDA7DQorCXN0cnVjdCBh
Y3BpX3N1YnRhYmxlX3Byb2MgbWFkdF9wcm9jWzJdOw0KKwlpbnQgcmV0Ow0KIA0KIAlpZiAoIWJv
b3RfY3B1X2hhcyhYODZfRkVBVFVSRV9BUElDKSkNCiAJCXJldHVybiAtRU5PREVWOw0KQEAgLTEw
MzcsMTAgKzEwNjAsMjcgQEAgc3RhdGljIGludCBfX2luaXQgYWNwaV9wYXJzZV9tYWR0X2xhcGlj
X2VudHJpZXModm9pZCkNCiAJCQkJICAgICAgYWNwaV9wYXJzZV9zYXBpYywgTUFYX0xPQ0FMX0FQ
SUMpOw0KIA0KIAlpZiAoIWNvdW50KSB7DQotCQljb3VudCA9IGFjcGlfdGFibGVfcGFyc2VfbWFk
dChBQ1BJX01BRFRfVFlQRV9MT0NBTF9BUElDLA0KLQkJCQkJYWNwaV9wYXJzZV9sYXBpYywgTUFY
X0xPQ0FMX0FQSUMpOw0KLQkJeDJjb3VudCA9IGFjcGlfdGFibGVfcGFyc2VfbWFkdChBQ1BJX01B
RFRfVFlQRV9MT0NBTF9YMkFQSUMsDQotCQkJCQlhY3BpX3BhcnNlX3gyYXBpYywgTUFYX0xPQ0FM
X0FQSUMpOw0KKwkJLyogQ2hlY2sgaWYgdGhlcmUgYXJlIHZhbGlkIExBUElDIGVudHJpZXMgKi8N
CisJCWFjcGlfdGFibGVfcGFyc2VfbWFkdChBQ1BJX01BRFRfVFlQRV9MT0NBTF9BUElDLCBhY3Bp
X2NoZWNrX2xhcGljLCBNQVhfTE9DQUxfQVBJQyk7DQorDQorCQkvKg0KKwkJICogRW51bWVyYXRl
IHRoZSBBUElDIElEcyBpbiB0aGUgb3JkZXIgdGhhdCB0aGV5IGFwcGVhciBpbiB0aGUNCisJCSAq
IE1BRFQsIG5vIG1hdHRlciBMQVBJQyBlbnRyeSBvciB4MkFQSUMgZW50cnkgaXMgdXNlZC4NCisJ
CSAqLw0KKwkJbWVtc2V0KG1hZHRfcHJvYywgMCwgc2l6ZW9mKG1hZHRfcHJvYykpOw0KKwkJbWFk
dF9wcm9jWzBdLmlkID0gQUNQSV9NQURUX1RZUEVfTE9DQUxfQVBJQzsNCisJCW1hZHRfcHJvY1sw
XS5oYW5kbGVyID0gYWNwaV9wYXJzZV9sYXBpYzsNCisJCW1hZHRfcHJvY1sxXS5pZCA9IEFDUElf
TUFEVF9UWVBFX0xPQ0FMX1gyQVBJQzsNCisJCW1hZHRfcHJvY1sxXS5oYW5kbGVyID0gYWNwaV9w
YXJzZV94MmFwaWM7DQorCQlyZXQgPSBhY3BpX3RhYmxlX3BhcnNlX2VudHJpZXNfYXJyYXkoQUNQ
SV9TSUdfTUFEVCwNCisJCQkJc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX21hZHQpLA0KKwkJCQlt
YWR0X3Byb2MsIEFSUkFZX1NJWkUobWFkdF9wcm9jKSwgTUFYX0xPQ0FMX0FQSUMpOw0KKwkJaWYg
KHJldCA8IDApIHsNCisJCQlwcl9lcnIoIkVycm9yIHBhcnNpbmcgTEFQSUMvWDJBUElDIGVudHJp
ZXNcbiIpOw0KKwkJCXJldHVybiByZXQ7DQorCQl9DQorCQljb3VudCA9IG1hZHRfcHJvY1swXS5j
b3VudDsNCisJCXgyY291bnQgPSBtYWR0X3Byb2NbMV0uY291bnQ7DQogCX0NCiAJaWYgKCFjb3Vu
dCAmJiAheDJjb3VudCkgew0KIAkJcHJfZXJyKCJObyBMQVBJQyBlbnRyaWVzIHByZXNlbnRcbiIp
Ow0KLS0gDQoyLjM0LjENCg0KDQoNCg==

