Return-Path: <linux-acpi+bounces-11097-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CCA326A2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 14:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C316B3A74A5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E04A20E01B;
	Wed, 12 Feb 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZstcHlGM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7291209F4B;
	Wed, 12 Feb 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365864; cv=fail; b=HTKS0644qaBPn3jm1yb8JQyv+mPohjkppfz9HZ1tqFBR5qeO7SPgntYHMLMFHLaMLMFv8cZocTLJG2oUYzIEuv3hSoqucdvkrR/2w5RdWchFoHuONAazOiTxzA+LTT2EWzp6ydQ/+TSwWIKDphni2FNR9KcqqP5pPOnYUnUZ6TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365864; c=relaxed/simple;
	bh=CVblMh1xIpqfW+t0uYbO0JKj6IxbZN3K8Q2vSGgz6Dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fbn6u6uD5z0BWGgRe5dK6+ze424kJxhxlVB3qQee2+4mmlni0xD1GvX/7UZ2zkjPW9uoZSfJxqtEce9lWaP6fL+O8srSkuhNwF6sdVR3VRFn77U7WERlUgoi2/AxW9qxakg14D95CRRLaGsA4pykVurSX5R1MxPXaChDkNePaWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZstcHlGM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739365863; x=1770901863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CVblMh1xIpqfW+t0uYbO0JKj6IxbZN3K8Q2vSGgz6Dk=;
  b=ZstcHlGMSVR1HrA7e640YfTFTnVa+lB5Q1TOeKj6fapNwTQNZmE44zd7
   B3n7iUOaniSSiCqEidS5G6hZkj32cV9hlPd0y5S7K5FVGc1vYJDnMntP7
   ofDipYk1LzOuOReLc1SEKY0FxQIW4RwekRhYLE1efoHEvWZi49pKVTnLS
   JSG7kPyugUcPHr9NLAmqnemPzalnoPWlPD+FT4kiUpW24hHeGlr2vYHQt
   W6B1/pjbKRsgHKH9vj/HUTx7N+y5jr4NcjlH6P+ZXH/4BYwstIFjP8PVV
   7sbLn4lm1OmT/Xl5ujCvJ9l8xgabvUtOlfkqXc9TzPYQSvwMCcDYlkVrZ
   Q==;
X-CSE-ConnectionGUID: QOBgBHLvSauL8tH7qQ/YAg==
X-CSE-MsgGUID: 9T18aTyYSs+LFb7m3Gikcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39943197"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39943197"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:11:03 -0800
X-CSE-ConnectionGUID: Wu8ncdBxTduw2KJldokdOw==
X-CSE-MsgGUID: 777DzTSKQRqHCbdf6N856w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136084688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 05:11:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 05:11:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 05:11:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 05:10:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwCLVGUlpMDzdeFS7NACNgYqAxorHlr4bM5Y2IZMBovlG56TycS0f3RK08j2zVQdOobzlHPw9BwaFIPSMJ0/o7jKAbaFz9HbEVAWwxiVr433gcJ3fcAJ1UePM1PlT/gSNKlwl0fSYajz53+DhKuXWUsrpSMY2VeMnAgJ8EKLLzzuXF/8d+E82Hq7ggv2gXGzV9Ll/dvAeUkQue5eLarTVW12C491vBGW25EhXIssaALEoaMGrpd/WA/iNkDhhYLkjlSYx3FHsKJ4VVaeygxGPYUhRqE+xFXqk0IUvU7BlcnaBLYapE5eR5K+VjlauDANwbWne4rgDKMPbz7baBxUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVblMh1xIpqfW+t0uYbO0JKj6IxbZN3K8Q2vSGgz6Dk=;
 b=JljpWWKLYclImE3YzOGTMNcC0Xx4KZ9BPSNJfGpSszs+Le8kuVGPEh24/DxbUTqkRxk8fgoq7yfHwIzA0it3o1clBD4kUOuBdj8snXCdAdU2gR7bmITPWLWuwHRMuyY5CNKt6s8MegsiGpkWsrw0olysAD5K8ImktVcErPXWj77Q/1VvBoaE9vbZ10+fiGAujJnN/jmEQYY1N+iMDtdkoguBAaN/gM9ncMkdbnUB8Ta0nhklcm6tE2T/xE9/7Ltje+YocflOm5iS4hLw5ClWaNMxrsTLxBO9Fh7XH7JEHK0BGknReejYhgsitdRUvWma8O6AruWhnfWhKPkrQqv4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by DS0PR11MB7831.namprd11.prod.outlook.com (2603:10b6:8:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 13:10:57 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::91a:711e:b675:edac]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::91a:711e:b675:edac%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 13:10:57 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "irogers@google.com"
	<irogers@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
Thread-Topic: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
Thread-Index: AQHbfL2rjK1vhQiYLUq3fbVp1YoV0LNClfWAgAEPqIA=
Date: Wed, 12 Feb 2025 13:10:57 +0000
Message-ID: <0a5f0c0e1a8dc7b76edabfba4bc8bb61a9db3cfd.camel@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
	 <20250211194407.2577252-8-sohil.mehta@intel.com>
	 <23e24c79-96ca-45da-832b-83a9b6456208@intel.com>
In-Reply-To: <23e24c79-96ca-45da-832b-83a9b6456208@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|DS0PR11MB7831:EE_
x-ms-office365-filtering-correlation-id: 511ef63e-4c50-4d03-8843-08dd4b66b02d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QlVxMS9FSFJnUEp0dFR3Q0xUTzNrK2puYWdvU2Qxb1BWdXMvcmhWRFp6MmRX?=
 =?utf-8?B?Ym9jSzFBd1FMSk9iWlZra1o4NGJwcWRLN1pNK09nOFlsdUFhaGVLOHRPN1JW?=
 =?utf-8?B?cHBTa2VPd2RNKy8vV0c3SG9jR2haOVRwZVorenB6RTBiN2VuQi9CT0pxWjR1?=
 =?utf-8?B?VGwzQTByVXBZSHhETElwa29PRzRFTUFxaVZDSWZuS0lGaWJVSEZDTGRLQjlm?=
 =?utf-8?B?dTJuZnBLOG5JQVI5K2NDMmw3R3JNTnRqS0NoM0tJOXpCd1NCQytsSTFreita?=
 =?utf-8?B?SElqMWdWVVZiVWZES1g5ZVozNXFVcEtqRXYySlduUFdNWVpPUFEvS3Y5NlBn?=
 =?utf-8?B?L1haTUNKSXYrdmxGUHRIR3FyNW1MTGtzTWMrMUdyaUJMNHg4UXYyb0FsYUts?=
 =?utf-8?B?b1Q1Sko0SVdFT2tSMWdFMEh3WjlUTWJRa0JiSE1jK3FQTEl4M3pCT0FUZVFX?=
 =?utf-8?B?bmdSVkVpczBHQldCUU5kN3BlRzRJbWFoUkJmd0IwR2w0d1A2bjgrMkdYRWg1?=
 =?utf-8?B?anJKczY1WTlmeVJrejBZeldwanBYN1dDTmxZbFVYQnFOMllyM0VqM1pLdkFZ?=
 =?utf-8?B?VU5FcklBU1B2SDBRSHlkNTJOeitTMEo2VndlSGI1M2E5UmdSeDg0dm9KQmFp?=
 =?utf-8?B?R0dLdWo5djFadUtkVjVXcjJadXR4bE5nZ0lwUWVGNnRqLzVOZ3NhMDJaR1hk?=
 =?utf-8?B?d0ZzVmFOanJKeU8yZDdqQXl2dlZ0ZGxYSExIWmpXdGFXSFlqVDJPMUJBamJX?=
 =?utf-8?B?czVzczErZDRGUVRnd2I2TWZiT3BIcVZiNzlvS3hyNVl0cU5qWHg3WWptQ2VC?=
 =?utf-8?B?M3UvOGM3QmlMVHhydHhZVGZQTkZWb1JmemUwUGkxeThqckMwc0FmMGFlMHBC?=
 =?utf-8?B?Y1BLbXBwRzhZb2VQZm1SWEk2UlRkZE9hdGcxOFBINEN1VGV6M2VPamxpR0gx?=
 =?utf-8?B?bDlsYWFaaFBrS3lIcFNkY1VwcjBNcitoVmJlOWdnV1JCVEZ4U1hOblowTUV5?=
 =?utf-8?B?NzE0Qk1rbjQ0dWw2VElEQ0NMdFlXaDhJSmhjR1ZZN1puank0NjJLaXREd2RR?=
 =?utf-8?B?bm11RlFNZGNoUkJ1bitBWTFoeThnMDVhUS9ZbDZIR2FPZTlUL1N0YTltZkxD?=
 =?utf-8?B?N2s4MWo1ek5MTG9KOGp5VTBFejdISWx5bHB5RXZkaTNOZFpQWG91TDY1MlFq?=
 =?utf-8?B?bXBsZzVqOUR0RmF2ekpsSGZudWNCejBUdnExM2ZNZXlIV08wTVRiZG9oVzR5?=
 =?utf-8?B?dnl2ZTVzTlpvNkV3Q1kwMmt2WmZ5TlJTdWlCeWpaRmpNL2M2NHY0MEsyK3Z2?=
 =?utf-8?B?aG54QTFQQkRlMjBqK01tcnFFY1habHVHYVU2emVoTDdWQmNaR2xTVVpvSlVy?=
 =?utf-8?B?eEIrTkRIcFlMUXpzNThjWXZUekRObUtoUjBqLzFZcGFlUWptRGNKUlUwbUdn?=
 =?utf-8?B?N3YzaVo2S2FlQ0xCNlV1N25kZ3RaTmZZZkpvbFVWV2NQVW51Y1dRTUR1YU8v?=
 =?utf-8?B?WkdmeHYySS9ZUytJL1hvOEFpcWZmMEQ1UTRTd3hob3YwRzlnQUJ1VmdYcFZV?=
 =?utf-8?B?YkYzZi93QVYwaHMwM1dtM0s3VnlqdGxxOFF2SXFCTWd0MGJJTE9LMk05L2cv?=
 =?utf-8?B?YVNXQ2VJTlh2WUJzRjArVlhmOGNRZTZqdHZPZ1FoZ3hyWkQvdFBQcUZNcGNu?=
 =?utf-8?B?K3BJWktNRE1vVjhBMmJueGMzazE2a1RGRGgzSjVMakVheTNwVlBIRWExR3l3?=
 =?utf-8?B?cW1qUnJxeXFCbUZWSlFsVHV6WjlLbmthaDNWa01xTHE5RTU3UmlFYlA1Ym5s?=
 =?utf-8?B?WHJWT0NlQXJTdTZtcHB6TDViWmhJK1A3VEFvYzlLVFNhYmJrTVdzMUM5VTZw?=
 =?utf-8?B?eUlRYVNOclpHTjJZQjlBZjRZRjNjN1QwY3pJYXkyeUFDb2ExeVFIYkZhUVRk?=
 =?utf-8?Q?EEC1GBZFsAegaY8rBft8O5OQVryFqQIh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzFGQVZ5QzBWV0FvOGtWcnBKUTd4TUxRTno0ODFQRWc5VHcyV0hnSS90UlYz?=
 =?utf-8?B?SHNpVEZ5SVVWNlA4NS9LSHVzcVpsYmZnN2N5RXpJL2F5RXlHN1NnOUdTdm9H?=
 =?utf-8?B?QUJXRVozWERFMmNSL1Z2OGxGV0htTnJYSDB5WUVIUHV0T01RVHVaZGxlY3Fh?=
 =?utf-8?B?RUdrSTlad0VzSFdkc0h4U3M0TUdvZkJYVWR3QmhmaWhJRmZSR1FmNHJBRkMv?=
 =?utf-8?B?TE5hZVNQMEZhUzVmaTA4ZTQzZGF2ejZSRU1jSEVzUnhYT3FTZnV4T1dLYi9q?=
 =?utf-8?B?bUMyUXBkRGJIaXgvZmN2SkRIbkRPdU8vSEgrQWY0aVlGbk5YWU1lbWFXUFZ2?=
 =?utf-8?B?VXp2SGhWQ0ZMUW9yWWlDSFFac1BzVU44bjEydTU5ekt1VituMGdtRmtiblZX?=
 =?utf-8?B?bUJYc3FLK0VPcXYyQmlFOGZRcUZkT0JNemxrZFJzaGcxRnlrVXZ5d25iMFRm?=
 =?utf-8?B?c3NWeWhSbytiaUlQWUx3MmVyays0ZllEMHBHd1kxTGVqUVdCTkl4SGZrcFhz?=
 =?utf-8?B?RHl1eXhkSzhRWXNBQjVWNURjZjZpdUZGQktxN3I3d3pjUk4rWDhyZzRObmM2?=
 =?utf-8?B?K085UWJNY09ldnp4RUhncXV1aGVOM0tHNWpvZ2Y2eDl0UHBWMkNNbGYxdGd4?=
 =?utf-8?B?WHV6SDl1RW9SNDkzMENIN2xIWFp4elJmUXF5U1BnUHBUL2lDbFNHOGFNMG1O?=
 =?utf-8?B?bGQ2ZFJvQ1NlOWxrOFB6ZUZpRll4OXJ3QXcyNXN1WkJFQkRoeWhtaHpMa3gr?=
 =?utf-8?B?QUtrS3RxRDErWVFzTlZhTXFxSzJ0bUpjc1htbW5Tbm5nZ3NLaFQ3cWtibVVy?=
 =?utf-8?B?c1FOMyt6SlNNOHZ2VDJya0FtcUNiM3hZb2lGcHFEaWNiVyt6UG9LaGg1WnlI?=
 =?utf-8?B?YUpBM2tqUlVtaStESTBSOGQ3QmgvQ253RHBnY1hQYlFLOFV5elQvQ09CNXBO?=
 =?utf-8?B?MVJ4MWZMUDBEYnZuOUMzV3ZEckpLOEhQRDI3ckR3Rmd4MzJxQXluZ1g5Ykk2?=
 =?utf-8?B?RFV3VlY5L1NTNys0a1dtMlRlc1lTVEhxN1JndDVLRW8zL3RESnFma0Uxb2pV?=
 =?utf-8?B?RU5qTzZPbzJXVHR4NHlRMU9DYlVzUUFwR0VtWmlQOVk0NjhBQzhCbVVNeVBJ?=
 =?utf-8?B?cVNqZ1RqR2t2WlVybFVOUit0NkF1MWxZYlpxVXkrMHRxVzAvcGoyVDlWaDZP?=
 =?utf-8?B?OENvQ3pib1hYcFcwMThPK0w1QzczVzhMTGxMNXR1SlZibG4zNi84UkZwckYv?=
 =?utf-8?B?dFI3NFIrSWQ5aVFmNVIrb0VXVzVtRVhaa090NUpiVnppZythMmE3endpUElT?=
 =?utf-8?B?NHNVL1NyQUhuTzV1QkNqbXl5bTVCOE1SeE1IUU5TQUJpejFUTkxLdmtxQWdr?=
 =?utf-8?B?ZVovYWRiTzFIY2Z1M3Q3enBWeVRJR3FkdFJHakx2TTJBNDN4OFVJcGc3cEpU?=
 =?utf-8?B?bWp5dTdyeEoyMVFxa3BxVmdqOVlXWDIzNUp5T3ZXeEh0akEycC9YZS9WR2xR?=
 =?utf-8?B?V2pRZTBycnZMc0pZMU11bGp3Y1hjenFlejU2MkVKanFMWHpCSmFkdkFHZUg4?=
 =?utf-8?B?S2RUZDdIUWhnVVhEZG43d0JISXRBbE1MSUtsMk5uMXNLcmpnVmhuODRsL3Bn?=
 =?utf-8?B?RTl3aDhyV25KMW81c0lUbGE1b2hWUS9yckFDQlJ3RnlpRzY2N0U4MWJXV0lX?=
 =?utf-8?B?OVgyVG5mcGlWZWJSMlErMjNUOVVvcFVNM3Mwb1RXdVRWZjUxR2R0THhjR3dj?=
 =?utf-8?B?TTJqbHFwU0RRNFUwZ2s3eXpIQWp3UkJScDdzVmpnNGtUNTV4SEUrQmRKY2Q5?=
 =?utf-8?B?T3NGMlpyeTJjTm11c3JiejVuZ0xEaGlFYXhSY3oreEUrVVVvanZLREJqZHFo?=
 =?utf-8?B?aHJZdDAxSkE1TWh5dW1VMnk1YnZCTWs1YXFwYVM2SnhSVlpra0E1bC9DSGoz?=
 =?utf-8?B?bGRuWE83SGR0QVcyVEorRnlGS29LcUJ0ck5nWmxPeURyNjljQkZSb0h5Q1Jh?=
 =?utf-8?B?MzM3dzB5YUMrT0JrcE92bU9zOTVlVUtWSEVsUG02eHpZaEZ0ZjN0R2Y3cUR0?=
 =?utf-8?B?Vy91cVdsaUJoVktFK3NzTXg5RDhWRU01ZGlXUmVaNzNrWk4xNGtxM2wzLy9p?=
 =?utf-8?B?OHBuWCt0empvZ3BQeC92S1JxQUFwcjJOS3JTZWhkQ3cvNE43RmpzVjAzYVVO?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBDFDDED4C4655469D7283F8C36E7AF3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511ef63e-4c50-4d03-8843-08dd4b66b02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 13:10:57.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhcDoE42SLIBfLHPze2bcyi93NbiA2SkGuGRaiTBM5VMSXme73M+nlTdZ16JHfkZooA7B8qqMChQiX/qt/N1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7831
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjU4IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToKPiBP
biAyLzExLzI1IDExOjQzLCBTb2hpbCBNZWh0YSB3cm90ZToKPiA+ICvCoMKgwqDCoMKgwqDCoC8q
Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiBSZXR1cm4gd2l0aG91dCBhZGp1c3RtZW50IGlmIHRoZSBG
YW1pbHkgaXNuJ3QgNi4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSByZXN0IG9mIHRoZSBmdW5j
dGlvbiBhc3N1bWVzIEZhbWlseSA2Lgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKg
wqDCoMKgwqBpZiAoYy0+eDg2ICE9IDYpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIHRqbWF4Owo+IAo+IFNob3VsZG4ndCB3ZSBiZSBjb252ZXJ0aW5nIHRoaXMgb3Zl
ciB0byB0aGUgdmZtIG1hdGNoZXM/Cj4gCj4gVGhpcyBpcyBraW5kYSBpY2t5Ogo+IAo+ID4gK8Kg
wqDCoMKgwqDCoMKgcmV0dXJuIGZhbWlseSA+IDE1IHx8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKGZhbWlseSA9PSA2ICYmCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgbW9kZWwgPiAweGUgJiYKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtb2Rl
bCAhPSAweDFjICYmCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZWwgIT0g
MHgyNiAmJgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vZGVsICE9IDB4Mjcg
JiYKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtb2RlbCAhPSAweDM1ICYmCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZWwgIT0gMHgzNik7Cj4gPiDCoH0K
PiAKPiBJJ20gbm90IHN1cmUgaG93IHRoaXMgZXNjYXBlZCBzbyBmYXIuIFByb2JhYmx5IGJlY2F1
c2UgaXQncyBub3QgaW4KPiBhcmNoL3g4Ni4KPiAKVGhpcyBjb2RlIHdhcyBpbnRyb2R1Y2VkIDEw
KyB5ZWFycyBhZ28sIGFuZCBpdCBvbmx5IGJyaW5ncyBhIHdhcm5pbmcKbWVzc2FnZSB3aGVuIHJl
YWRpbmcgTVNSX0lBMzJfVEVNUEVSQVRVUkVfVEFSR0VUIGZhaWxzLgpTbyBwcm9iYWJseSBubyBv
bmUgaGFzIGV2ZXIgY2hlY2tlZCB0aGlzLgoKdGhhbmtzLApydWkK

