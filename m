Return-Path: <linux-acpi+bounces-13461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B8AA9A2F
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 19:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC91B3BC08D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB12638A9;
	Mon,  5 May 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbwXldzl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579254279;
	Mon,  5 May 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465141; cv=fail; b=NbkIk+wsUJ6bG3REKIY/0QzrAOIH64UP+YC4S9jkHSr7420rTSNuNYCHekRsn+11TzmOG+xsXhn3SBdinQd0OZaSN/O8PhmnCRVAa83LWl0J9IrhekU0ckm8MwYENL1yqo+HQY5cEB7laL7X1U1g4UkUo0vTF6w1l31mhFEbaak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465141; c=relaxed/simple;
	bh=85eWq9Gdyy1AlDg/aQwFi7268LP2lMpK7r3DopmGyjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qKyRPeDWpYHeZ8l0t+eKtQs2pFXH+uQtqHfwKVMhLuZE322NdvFsuNGGceS7yFkfMs3pLns0dTMsccrjesglfz8xxJ3PCUlm+4fa6Gem2+Ga7qJ2+4P47O8qAGnVMZa7852ct4TKqazvAuUVySJsrNCe+Vp8uDNlSZ1JHYfo3sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbwXldzl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746465140; x=1778001140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85eWq9Gdyy1AlDg/aQwFi7268LP2lMpK7r3DopmGyjo=;
  b=XbwXldzlfWbN9cOeRq+w9C6j4ooMCtbZRN3kDrDunWH7aEaAq+VJNNpj
   8+rMxXvfoyK/ZiU0xkPLhRonynV4QzEdcBleWal0sNYjxrlBLdWdZjGmW
   bCcQKZWf2Dpn9Isyf5NB8qxBOyVmv/lDS0ZlddCLTDtde2JmJqrAPFVBb
   UUX1DP7/SKC5YyVS4ej8xrdjD/9Zc71Mw4KZD+U8cn2EVWhM57M9TYITB
   i32tVDEPx+27KX9SINAqvyo5T4BgrxF+iRAXnG8N5UZFS8TuT9+xSaKKW
   HVwwwEbsZHMpU9uS12U6zkgPX4FrH3PQnHX1foxnT6CQMLhjWSRNlMYti
   g==;
X-CSE-ConnectionGUID: zUwkP/VBSCOEBzpRnutO7A==
X-CSE-MsgGUID: 18OeuXtsTmuUNY/f/CYfGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="59075871"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="59075871"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:12:19 -0700
X-CSE-ConnectionGUID: Vy6g1A2PTTyAMGbZY/qXdA==
X-CSE-MsgGUID: IbCf4B5gS0mDVsrm79fi+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135669149"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:12:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 10:12:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 10:12:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 10:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX+9AnbH73JeCcnFLOwxle/cG5Ah70L1NnIwFQxw+TcBiqb05tVIwg9O0iX8BySoIH4iR/rfkQFoS0JZ1FwjEA2L7lj39zQoHdkmAtPl7z0bng2OJBP4x+vwxA/GObLnD/jOZfjln6nmYzwEpeaWfj/x9C8q0cEm3/BANILJ4AaH3D0JbqrjKWt00e4Q12WFXn+SXaUtWnSyR3RVvmJIqvB0gCwzTZ2fhKaKgXgjAgo5N9I4k1EoRtvXw7HbhbwrPp3LUqGKOPuJCkAq+Wu4QBzLHqUUdJITTG2f5+H3+aSR36ARgnlJ8BaUq32ER0J3QbBLAlWUkF23mKnjiVac4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85eWq9Gdyy1AlDg/aQwFi7268LP2lMpK7r3DopmGyjo=;
 b=qi6yhfgmprRjbhTOoye5QobBruKDxImiSE3hypvW+uevbGl5GV3F43O9XLFYipkDTVuZL0GubQ6cIsAbFLBxal35p3cWP65Fm8nJOQ3xbjXe1q73zjeLdBw+yZZnaR4efDQJr2xkRCW6ATNFSkHntB7VaqOCIyyqG5wpuISaxO2SJizVSqBg62d4jXMS42THt197eATUS22LN19ufV/HTsfYR+El4wA+O+icyK1eJKT7El7J/bb/Ft9no1GThinJ84i4I767QtqxseiWzwKQugb3CCLuvStF4Tr8kmN43SJEIkm8kv0p1oZNGGaS4HJpOiCY0DDHE+jsrZgMx0rXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS4PPF267298081.namprd11.prod.outlook.com (2603:10b6:f:fc02::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 17:12:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 17:12:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "Keshavamurthy, Anil S"
	<anil.s.keshavamurthy@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v4 1/4] ACPICA: Define MRRM ACPI table
Thread-Topic: [PATCH v4 1/4] ACPICA: Define MRRM ACPI table
Thread-Index: AQHbuUS1PfmNff0EgU6B+XiUSpTa77PEC9OAgABB0NA=
Date: Mon, 5 May 2025 17:12:00 +0000
Message-ID: <SJ1PR11MB60833EFB63D1356DF14336F7FC8E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250429202412.380637-1-tony.luck@intel.com>
 <20250429202412.380637-2-tony.luck@intel.com>
 <CAJZ5v0ju_Xirnft+5C=-GtG3hmT9xGjVqNFPRugXR7o1RzfHrg@mail.gmail.com>
In-Reply-To: <CAJZ5v0ju_Xirnft+5C=-GtG3hmT9xGjVqNFPRugXR7o1RzfHrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS4PPF267298081:EE_
x-ms-office365-filtering-correlation-id: 5ca1ad38-7a0c-4679-d67c-08dd8bf7f2a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bWdDV1QvNVliVVdzUERaOXdYcFRxTFRRdmpFQ3Bva0swcE9FSUlMVG1laFR3?=
 =?utf-8?B?WUV1cVpFNDNUU0hENHdKOGtDY0F0QVJWYlljRmVUNDBZSURwNk4wejJ0VDZp?=
 =?utf-8?B?RzJ6dHVNZDVYQmRKSGJzejRNeTdnNnJIVzVaNVBiYkpOT3hxVXNPd0lybXY3?=
 =?utf-8?B?V3lXNXlxSTFRWC8vRUVmR3JLY1hkZHpLMkxOU3hEMVdNWXFPbEw2OG5KNC9i?=
 =?utf-8?B?SUI5Nk1lTHVJTm9SL1Zhb3JVOFdydk80Y1lLdzVaRFRiL09yam02RTN3MFhK?=
 =?utf-8?B?Vk1jTVZMSGdXNWdMWmdvQmhnTDl6aWZiRWdpSHNzZkVQN1JkTU9mcnpYQWd3?=
 =?utf-8?B?K3d5angrcUZPR3ZUUGRQZGRUdUhBMDE5WnZreU9pZnJpempVQlVkN1IwTzFQ?=
 =?utf-8?B?c3BiR2w4U0F6QmtlV0lXRzJmeUhGc1UyZFZoaGJOZWVPSzFoR1ZKQnJxamN2?=
 =?utf-8?B?RTdzck4yMGVSV0hpWi8vQTUwNThoMzdDT0JhY2xCRDJURzRQK1NlN0pnajFQ?=
 =?utf-8?B?QlhKMGpmMlB3MGh4OGRrVkxWYmthbFR0RGs2K1c1ZWRRdHhUSitUY1pmUXVV?=
 =?utf-8?B?OGZaZmlneWFtZWxiQ2tlRVZjNzk1ejhTRWFRdjNxN0VmTGJZQlRHRkdQYk9M?=
 =?utf-8?B?b2x1cjQveE96WjVyaktLc1FZSDE3QU9kZUNXSFI4R3J4cWQwNmtOdmZzQytG?=
 =?utf-8?B?ZmJORlZ5cGFSYmFFS3B1TktTcFFVdWpKNGJUWGFzeS8zS3RGVDl2U2xoQWdU?=
 =?utf-8?B?aWtZVnd4RHUzbmRnSjVQMWZ5bTVQc25MV0pvWjYrWW55T2hZeVROeTcxUGpp?=
 =?utf-8?B?bnVCaGlOdnVySWZyVm9VdzFOaEdJYzVXYU9GaGlEeG96aFBrNWpUUXhZbW03?=
 =?utf-8?B?WFZwVmlZc0dVRXJpMlNmVEg0aEYwTEZpWk4zU2JXZ2NXR0lDTW9uZklRTXl5?=
 =?utf-8?B?K1VpSHFvZXNiU3BrNW9CQnYrcXFIdE5lcW85cEROT2d1Lzl6cEMxcm5XZjlF?=
 =?utf-8?B?cUFkcWFGbWhJY09HVWR3U2FTeGpOdnIzRWVjRzgvcU1JZnZFandCNk4yUTdS?=
 =?utf-8?B?TEc0cktFMmMzQjBmM1ZuV1FOYUs3bTlwcWc5WGlNMGJyUzJ3VVh3OW1QSWJF?=
 =?utf-8?B?bXNwRzF5ME1wT2ltMUlKWkQwaXNDOElHZU8xNVZ0NlhWYTg0N2JzOHljc2E2?=
 =?utf-8?B?dExwd0krSWNaaVk4cGxKNWQ0d1BqTURoZ3dwUUZ0cXJyZ0llS1ZYK3NNdHJ6?=
 =?utf-8?B?S3cxbzFFU1krS1ExWGJQc0w5V2FaUTJlcklmNjQ2Y0R0bVpNclJSNVNVN0ZG?=
 =?utf-8?B?YWkrNDVna3hBbjEwTkxGYW0zUmk5WitVNStGZ0RJcGZNS2ZveHptTVdvRy9X?=
 =?utf-8?B?NGNoQkVVak9Sc2JYcDB2NlRPQml1RzBkZi9nV2hqbkhEemRkK3J2WVZjaTJx?=
 =?utf-8?B?M0d6RHdFNWdrSzJtNkIzSzhyK1FjUmxDRDJJRWduanRMK1l1Qi9qM1ZGamZ1?=
 =?utf-8?B?V09vRkVHMVZXNmpsY2FkVk1UL0dpbDR1Rm1paHNlaHFXcVNEa2ZQamN1MGpG?=
 =?utf-8?B?TlpPejFqbmM1aEhObTRGN2VqVjJOZ0t0MDNCazAxTVFreGJsQ25xRUl6eWp4?=
 =?utf-8?B?MWUwTXZ5UVNEdWRUWGxibEdXYUJ2U2VWQWRaQ1B2ZzJwZmoyczNJYk1XVzVv?=
 =?utf-8?B?ZnQ3UFRmSW8vWVJpQm9vMEJQOEF2TVFnd2luK05yWXlmWUt6ZVBSNFAvM05p?=
 =?utf-8?B?cUVYVGVqT01NRk9Ta0RvektraXhoTTFkc1pHbHhRU2NNMUlPcTZxemNlS1l3?=
 =?utf-8?B?VXREQ1A1N2gxSWoxb3M0RzY1VENBcjgxRmttUUNjaE9ad1JSd084OEo5K2dQ?=
 =?utf-8?B?S2RtREg2enp5TmdCa2lQQS9oTFgvSWRuNXlCVERtanM1Y3pYZU1hOTF6SGxj?=
 =?utf-8?B?bVFXNGJPcDlzK0g5T3paUFJXbHNyVnhjbVdLTEFEWEMxbC9xaXduSURWMUhk?=
 =?utf-8?Q?+/VGhk//okf5maGhTKOmzqcig71xAA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUdtWVdJd21QckVTa3dwWVd4clh0a1dRdzhreW11RTBNT2Y4Z3A1RnBQSEE2?=
 =?utf-8?B?RXc2d0RpalFyUFBUNjUxWEhRcEFERkdJKzN4NjdpOXlIS0krTjVscnBMclE2?=
 =?utf-8?B?VnJ0Z2RLV0tzaEptaGQydXZvMzNNUnczNWRHZjQyZUpzdkExaTNLRlNCMzBs?=
 =?utf-8?B?YzZuQTR0b3FlMlFUUWFzNDNKemM4UmJzcUlkQ2MxUU9DVldGNVZKM09pcmRS?=
 =?utf-8?B?V0xiRHBvOUdaclNBendJTEg2WUhDeS84YWxtU3YxM3hjVkJPSzBCd3lyY3Fy?=
 =?utf-8?B?YzZFT05hMlFhV3RyYlpraVBEVGhEVTlSMC84TzdBcGRpbE13Ylo0clBQNUMy?=
 =?utf-8?B?cGhNTHpkL2JPRjZiTVAxSUUrdTNNL0djSHRndjJuaUNxT3FIY1VoNStpMWxo?=
 =?utf-8?B?WWRYY1hCR0sva2dVM3cvMTdtU2Nsc0ZvVWh6L3cxYkV0MG1aQ05VYjV6c2hG?=
 =?utf-8?B?M2xNRjAxcHUrNjdUd1lTTWJZOVE2VloxQ21jemUwWTJoTUV4SGgvNVZDQ3g3?=
 =?utf-8?B?WDZaTTNpVXo3dFE1cHNNQW1iYy90bUliclBRbFFYMTFtcUJBeW1rNjZXc3ZZ?=
 =?utf-8?B?WUkvckxrOGpOQUFlaVFRWGRwTmViaTlFZjBZUEYwMmhUbFcwNERTL1BDQi9t?=
 =?utf-8?B?NklkQzl6a1BQcE5vYSsvK0l1YUNxeXNCdXl5aEhQSldZUnYxWVRaN3l3MVA4?=
 =?utf-8?B?NEE4NkdrcVpZeU5HVlp3cXNXVHFIVkN5em5FRlQ4RG1iSEFLRWJKMnhiYUJa?=
 =?utf-8?B?c2ZtL2VVYklEcHBmdHpNd1gwa3FobURGMWUwWVpQR1VDS1g3WnZoaUY2MUs0?=
 =?utf-8?B?bXA5a3laV25hZjFqcjM4SVU2aXRkallaeUlsSk5HcmU4L09pUkZLNldwOHFB?=
 =?utf-8?B?NVBIbkhCTmlDTU9pdm5PN2xVR2JGam1BRkd1Mm1vWVppK3MrVnRveFlJK2tz?=
 =?utf-8?B?d0VJNnZFcW1kK1EzOEZHZVA4VHFIUWNVbHlNczdFbUd1c2ViNk9USmxqZFg1?=
 =?utf-8?B?OTZTT29Idk5ibEJkM2dqKzlSa2haVEVXZGRvUTB2N0FQTmh4ekJKMk4yWDEv?=
 =?utf-8?B?SGJCaDdIVjdEU2RhNTNNNW1idGFTZDV2R2wybnpnZDJxYVBhR0ZSSlpuWWUw?=
 =?utf-8?B?VlowS0M5dm5vSGFBS1E5a2s4dEpiMzZQTk5UR3kyK3R2Wng4ZVlEUUlaZjdU?=
 =?utf-8?B?QVJsTXY4WWloaHhuemswb1NNcGc1MTYwZWN5aGp0Y2tJaGV2dkp3bWtxT1di?=
 =?utf-8?B?TmNHSWNkaVVHMmFyT08vNFd1akJPQjJoZWxEYkxDT3FiMnpQYmRQMlhEMDli?=
 =?utf-8?B?UWgvU0xjamJWU1F1WnBnL3hNeVhwTEFOV1JiZDdGUVJ4R1lGUDcrZW5OaElW?=
 =?utf-8?B?anVTR3BMb0VpQVZLQTliUDMySC9zcjM2eTJRV3FNMlRYUHN2aTF1QnExbjVv?=
 =?utf-8?B?QUxFcjJMb1NhY3BBd1hSbUJkNG9ieXB0R3pGWllHcXZLWUVBdjgxSHRSV2ph?=
 =?utf-8?B?R1BPNjZvN0pGZ2NQbGFJd3VrWmFpWklmejVYbmllUjF2dUpwZ2RBTU5EMnJW?=
 =?utf-8?B?Z0dPT0IyWXlaendsRkp0Q0pmME8zZWZPU21LcURoMU01RENuOTF3Y3k1Ymp3?=
 =?utf-8?B?NmR3dlhLYUJXR2dQYVN5a0VtMEUzSE9aTkJUL2RORXIxSEFvZ1NuT0xMWW94?=
 =?utf-8?B?dmhOWloxR09MMFJybmtqZnR4cFRQYmhtWWNsdDE3SU5MVS8zUm1VQlRyNE9I?=
 =?utf-8?B?d3ZWSk90dkVDSzZkaVJ3QnFDQUwzNTFSNVlRa1BCNk44TENheVRPOTZha24y?=
 =?utf-8?B?bkdhU1VFUzNjdmFwdWFEeW1VVU9BS2RwK3ZwNmNJQ3RoVFQ1K295eG9ESkY0?=
 =?utf-8?B?WDhtcktiMmF5M00rMzdEa0w2NTdrVTEwWE5BNzVZZlU5aWdCZGNXUGNmZUJV?=
 =?utf-8?B?eE0xQ2w2d0piYmVFQ2RRam5vSDEwR0Vyb0pkMFdmTVFocUp4SnA0eC8xMFZ0?=
 =?utf-8?B?dDRaYnphQVp4bHBoNHRrcDNCS0Q5Y044Tm5xMmk0bnZCOTA0dTJMRStnVll3?=
 =?utf-8?B?a1pRaWV3MWlJbWh1MmdnTFpNRXlkN0pFbmhENjJlTGVDUG9ybi8vWGs3b2ZM?=
 =?utf-8?Q?rR3Q5xsUPYZKO5yV8UzuKps6U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca1ad38-7a0c-4679-d67c-08dd8bf7f2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 17:12:00.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/mjavN0k9z4cmLOzFQykTREmXGZ1R/yczxJ8sRPWhAPZ2KAKnM24CCXIFw9f3w2gA8bvy+yjdAawja11GBslw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF267298081
X-OriginatorOrg: intel.com

PiA+ICsvKiBWYWx1ZXMgZm9yIHJlZ2lvbl9pZF9mbGFncyBhYm92ZSAqLw0KPiA+ICsjZGVmaW5l
IEFDUElfTVJSTV9WQUxJRF9SRUdJT05fSURfRkxBR1NfTE9DQUwgICAoMTw8MCkNCj4gPiArI2Rl
ZmluZSBBQ1BJX01SUk1fVkFMSURfUkVHSU9OX0lEX0ZMQUdTX1JFTU9URSAgKDE8PDEpDQo+ID4g
Kw0KPiA+ICAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiA+ICAgKg0KPiA+ICAgKiBNU0RNIC0g
TWljcm9zb2Z0IERhdGEgTWFuYWdlbWVudCB0YWJsZQ0KPiA+IC0tDQo+DQo+IEFsbCBvZiB0aGUg
YWJvdmUgZGVmaW5pdGlvbnMgc2hvdWxkIGJlIHRoZXJlIGluIGxpbnV4LW5leHQgbm93Lg0KPg0K
PiBDYW4geW91IHBsZWFzZSBjaGVjayBpZiB0aGV5IGFyZSB0aGVyZSBhbmQgdGhleSBhcmUgY29y
cmVjdD8NCj4gQWx0ZXJuYXRpdmVseSwgcGxlYXNlIGNoZWNrDQo+DQo+IGh0dHBzOi8vd2ViLmdp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9yYWZhZWwvbGludXgtcG0uZ2l0
L2xvZy8/aD10ZXN0aW5nDQoNClJhZmFlbCwNCg0KSSBjaGVja2VkIHRoZSAidGVzdGluZyIgYnJh
bmNoLiBUaGUgTVJSTSBiaXRzIHRoZXJlIGxvb2sgZ29vZC4NCg0KRG8geW91IHdhbnQgbWUgdG8g
cG9zdCBhIFY1IG9mIHRoaXMgc2VyaWVzIHRoYXQgZHJvcHMgcGF0Y2gxPyANCg0KRmVuZ2h1YSBo
YWQgc29tZSBjb21tZW50cyAuLi4gdGhlIG9uZSBhYm91dCBhIHNwdXJpb3VzIGJsYW5rDQpsaW5l
IGluIG1ycm1faW5pdCgpIGlzIHJlYWwuIEknbSBsZXNzIHN1cmUgYWJvdXQgZG9jdW1lbnRpbmcg
dGhlDQptZWFuaW5nIG9mICJYIiBpbiB0aGUgQUJJIGRvY3VtZW50YXRpb24gcGF0Y2guDQoNCi1U
b255DQo=

