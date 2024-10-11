Return-Path: <linux-acpi+bounces-8693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B558999998
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 03:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE241C226A1
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 01:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA21D299;
	Fri, 11 Oct 2024 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="js8YjVyb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53060FC0A;
	Fri, 11 Oct 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610677; cv=fail; b=ePZiqgCUA3cNLi0tIxz4cE+Sbf4OIPWm7gmo1V7RekH525Z7o+LYcnhm6TwXisbp8p/gB2lM6WrJsIGSTQsOwD9POEU+lTNQ25uwkLhueWu/oWNAbOiLrqCZofjNM1ZHhkU1IUpiZ1Xj6+yIbHOkUS6wI9upmyrEqlKSi+dBh7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610677; c=relaxed/simple;
	bh=+z+b6/4+dttT+82K+TXxeCdJbKSdAWrqVcZlag0d2ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LolOFG4EaIl3ZIGj0sL/WULWWbL9lIwjZj9CZi6Fp5+j77xHnR/YnKduq5Kg7UYfCBl5Pnl0Tb89E7vNBgQTA7mg0sytdTHueMXN/M8sVGVzPIX7pM4ZLpXL0T0OkBI9ozgIw4+VexDi+9UmDOfoAVm0blhHUYAWfCEaWSG9rdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=js8YjVyb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728610676; x=1760146676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+z+b6/4+dttT+82K+TXxeCdJbKSdAWrqVcZlag0d2ko=;
  b=js8YjVybLuMnS9xTuM1mvrNI9lV9+Ge5heJ6uLmKHvz8Ydkzik+ZzGn8
   XtfGffel21K+kP197d/ocqcdhSps2/ozts5JzZZ5a9tgkyYV2tyekrPRr
   cNXdq1bfgznOHG4WJDAi9c3ByD5CzsWjt58rP+8ixz5NjV/isyLDBjkGU
   IJ/ml2sz+FjZgTs5GerHEeQOQtT0Lfk12n7HavWXY8BACPvWS6oNi8eyM
   H+1Bw9OsFiiOgGWObU9n3aX5v5mevQh3Smd22+Kg+CDYEJCOn6LwUeEDa
   PRiqIukbakIjaQyJJ60jhtDPEMl0IHxBXGXkgxlwebbQLe+mlAmLHrdTT
   A==;
X-CSE-ConnectionGUID: rk71rx6aSveKf4R9nL3+Jw==
X-CSE-MsgGUID: rguMgV2fQJqPGhfJuWrPcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39393789"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="39393789"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 18:37:55 -0700
X-CSE-ConnectionGUID: 6HXzIcTpTcqchiHx8YzeWw==
X-CSE-MsgGUID: nlLyvkY9TASK9ouuz4Kr6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="77081217"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 18:37:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 18:37:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 18:37:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 18:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2lYGjTxWmg/BlEYAQxEtdCh7mtaBeNPiZWyqR2ccOsnKT8bDRDPRTZcpKVs2LLTwjNc5Sq33SdRQJ/BcuC/2mvkJHj1CldwbPEm6MUNHnSOdoYM1heBE3p8GNWgVHJxQ2dPuldJZveaa0eJrXYQKRuNUHN7N9PILcYuusjh/Uqv06ZGjyJOxFqE/FTTlhdFELJoN9Hp7dEIM5BnLNROgq674nOTNxE+B4UgeJo1/Y56fG52vM/io4BpC34fHkSavx6xnqisdkYnnVloF/PRVbaYEWrb5dh0NkQl4gx+/uYu52/kq2PSQKQty7cM9JL6cu9y7kitiz/KM7J+UUKYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z+b6/4+dttT+82K+TXxeCdJbKSdAWrqVcZlag0d2ko=;
 b=r+NXvAZb4FqDDFtJqfDcYtTwaqx6T10mSHoIUJIjOhpJwkBDgql0T+cxMtey8R3jcYPTifWjtW+OgdFEoMOmOoA7HzBmmIPCokCs1QNh+xntGZsCrxFIjg6kyRDcTREN9qfFto8W0nJbx8ukCbVTqhzCORZTjssLmbCIKVvhkq0v5CVU4K/NUW2i3Zb6UEIRq8IbNuwnKjEb2JQBfkJro5ReIyYZl2vauhYIJWMFB0PpEoTwK9GgR3M8OZGemafugmkb27aP4QfPn+N5rQo4nHPffAIqYyao7zTNsXsHYCoWtRa6k0Rsi4Xnkx3DCwezVfVX1j+kl6GrqaiHdwre9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 01:37:48 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 01:37:47 +0000
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
Thread-Index: AQHbG1vT9lbwQmPJwk69cBdGq4KcNrKAxaAA
Date: Fri, 11 Oct 2024 01:37:47 +0000
Message-ID: <f5962c02ea46c3180e7c0e6e5e1f08f4209a1ca2.camel@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
	 <20241010213136.668672-1-jmattson@google.com>
In-Reply-To: <20241010213136.668672-1-jmattson@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: ac1a93c0-fc8a-441e-8794-08dce9954fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TzJ5c1dSblVNbE9EQVJERjNBOHVGUTZqa0pCV3hlaEU1aGtTSHAvRlFFd3hW?=
 =?utf-8?B?MG9EWjVVd0pyT01mb09mRjlJNmJKYWtzdzQ0WkIwV1k5RmdZZ092TlUrMDdv?=
 =?utf-8?B?cVgvbUtzQnUyLzhzQnF5NEVSWDJRcFhuK1dVRHZjaUdIYmJ5dlBCeGRocGp5?=
 =?utf-8?B?RmtUc1k1d0UwTm04SEUvNklWTnhKN213UFNXQUhITnl6UE03Rnp1dXl5dVZF?=
 =?utf-8?B?S3FyemZoL0ozcDR4UkRDMmJ5Unc4YjdzQ3gxVUt6MU5PaDFkSDFueVBmeDBW?=
 =?utf-8?B?NDJKeENhcmIwSS9wVkVUdXI3aE4vQlVzTjdoSTZvRWdSdGVXOGRjSHdBZ3dV?=
 =?utf-8?B?RlE1U1VMUG9iL1VPWHdHeDhWU2QvbUJHdjAyOWZ6UWc0R1gxSzQ4a0xOMXRs?=
 =?utf-8?B?aGFDVVo4NDZyajVJb0Z1YTRjVTdyamJQdXI0bHZCeDA3UGVmZUpLYUs1NEd4?=
 =?utf-8?B?RXpwUkxvbmEzYUNtdXdxaXlFS2FMVlo4ekZNeC9VMUpHTTFWbTZEUzM5aG9K?=
 =?utf-8?B?Y05kMmlDZDJVM0wxVnNiOXJzaTFwbGg0MnJFbHhOVnBoTGpvREUvd1dHVmha?=
 =?utf-8?B?dXRlOTAxdEhldFZBOEtRUEZKSzBBdU5mdERQMnlESkpBTllaMm5HeUJRNjFk?=
 =?utf-8?B?UE9pZGZUT2FNbVJwWFdGc3R1RndRdWZ0VEVybWgxVEdjWnFTeGtzdENrdXJl?=
 =?utf-8?B?VVpPVG1kNnJTQmt0aDk5WTlObEU1a1B2OTJaaWl2bDVNT21rVmV2WUFBZ243?=
 =?utf-8?B?RlZJRXZ4NlovZXBhbFVpUDhxZ0VmOWtCVmI5SitMZS8raHEvdFJSa09SNHEz?=
 =?utf-8?B?TWJYMkYyS0ZMLzRqRitOMis5RTZpR0Z3Wi9PSzkrbmV5L1dkcWgxOXdSSDVO?=
 =?utf-8?B?QjdIeU1UVnRXNHlLcEtVM1FPdlRuSVkzSlRpTW9Odm9lTzhicWIrdk10Vkww?=
 =?utf-8?B?S2UzYUovK1JzbUJBTU1OOUt4TVBSUW9IM3EvUWRJYVNzSjVoYVViRGx6OUta?=
 =?utf-8?B?YnlwbllTVlk5a1UxVVJnMkFPQzFlb3ZHckM2aGNYUUtMQWRYKzhvK2M5NUdG?=
 =?utf-8?B?WllqRkM5QXRaVSt2QkJNM2dBMFVtbHFQVmpFN1czMHY4OG42Sk9LNmVDMjk5?=
 =?utf-8?B?SWpaTnhJNXRlL0RSd1VqL2taQ1hDS2FrYm8wdWdMczdTazBGMnJXcVAwMVk2?=
 =?utf-8?B?bGVYQU1aUlZJTFVOUjZNdXI5TVZDRXVybUQ1bE1hU0xYakk5VVN3VDdMd0Z3?=
 =?utf-8?B?TnZ3WTc1bitjb2VVOVhjRnZWTzg3NXNwc3RLYUFSeTNQeE9BMHNqaTQzb3Nk?=
 =?utf-8?B?OVN0VVA1WFdMNEplNW5UN1phRU1NM1V5VUZacXEyczVVa2ZHcE5WL0R3eWh4?=
 =?utf-8?B?ejhjNmNqdHhvdHVrdlpRaUVtQk9TR2x0WnRxajJ2c0htUW9rZU5IcmJwWGRL?=
 =?utf-8?B?Z3hRV3BZT1pueFN2QzRjb3ZzWWoxZEZqVGNJdTE1THd0cFNVejBpY3MzK1Rh?=
 =?utf-8?B?SWZrc05wWE1ob0JrQ3NrMFRKVjg1VjhGMktuWDkxRE5xM1E5QjJvRlFqQ3l6?=
 =?utf-8?B?YzV6dFJISzAvWm51OXBPR2F4ZEFmVy9wTFgwUC9HYUNjMmFJMEI4WDgzWSsy?=
 =?utf-8?B?dFRrcjM0QWpVUGNCUjJiNDNqblJTWmJNU1RITFRNaFVtOGNybXJGWmJGbUpQ?=
 =?utf-8?B?SzYxZ1FtYmJmYzlZa0N4ZGp3Qmh4Wmsyb0cyQnRLWnpjQkRuU2htT3g2ZXha?=
 =?utf-8?B?RjVPRjFVczA2emwyUXhpcy9ZK0VvajFRaUlGRUUxa05yUGNwcXU5S0NxWmxK?=
 =?utf-8?Q?ufb7gBBLhjNOc6dTu+na02FEHN6Ua4FEfQv70=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L21FQlNWM2xsVU55Ym5aaForMFZGSHV5R3ZlbmRtNnN6d0VydGFiVEJUWTRC?=
 =?utf-8?B?bmdMbFZkd2JuZWNpU1pEbk1KZW9PdjE1YUh2UnNCTHRYUCs3MVJKQmhSWU5E?=
 =?utf-8?B?VTM2RXVYUVZzTU1RV0h6WFJUditWRXB2TDY1OFMrRi9yRjBIQ1dRbTJBemV0?=
 =?utf-8?B?ZkUrYnV3c0MyRW9hNzZTdkNHaTZiTENsbC9YYnNwMGpHN0l5RkZpMXJiamVx?=
 =?utf-8?B?c1Y2MVd1MnBXcnpxV1NDWTZCM2FEa0pDU0NXbE5NM1o3alBhMnJxbzFQTFV0?=
 =?utf-8?B?YUp6b21QUXJWb21zK1NHdjk0cm9LL1pRcGlTRWtLM0VSdXV4S1RaekNBaWxZ?=
 =?utf-8?B?NWtGL2FNT09lUWFOSjcwZVRIMnhOblkrZ09ucExjT3J6UE1PUUh4V3hNRzRo?=
 =?utf-8?B?Nlc2U2VkaGF1RUVnVUhwMHBsMVljbVhLeFBaMGtIRTU1QlFKOXFRMEp1ekZX?=
 =?utf-8?B?YUZOL3BoU2hhQ2JjODJDOGVMdWp1VDQ3T05qOXUzdEEvZEJQZWdCbmFtRFNZ?=
 =?utf-8?B?Vllsc2VBUE05SjBRN2NxOUJ2WnhtOXBJSld6MVdpZWFLUnovdUpIcGgwekl0?=
 =?utf-8?B?cnFvQjloTHBjbW1yb3U5R3J2M1RuSU9zK3JvVTFTZXJHclNjUXlvWEJPejN6?=
 =?utf-8?B?SmZ5dmVtMm93b0FudXF1cU13aWdyRHgvSnIvQUJXWTdZQTJMUUErSmM4cGZr?=
 =?utf-8?B?ZVkwYm9NNXp2YndjZlZKcXNaSXpnTHNzdERsUzVEUjFZVkJjYXBmUTByelV2?=
 =?utf-8?B?UTdTR0hSNXpZbWRFYU5DSVdINzV0MjFxVU10UXQ2cWtxait2Y2Zub21yMVB1?=
 =?utf-8?B?bFJoVlhZenIvRGtHa1JlNVFBRVhjdDMrczk3MW8xdlVNU0dYTDRxS2RWNWNT?=
 =?utf-8?B?QmQzdk81cFpZUkhuSlZUUHh5bWJRaExYc0VNak05Y1Z4VUkzNC84OElUeWVC?=
 =?utf-8?B?aHFoYWZCaDluWjJuTC9jQisxcjNROHR4M3pYa1doN2wyeVFldFoxcUhaVFdD?=
 =?utf-8?B?dnNrMUdvQjgwN2d1UHlVUXBHbVNRUHF5TWNVQU9pOUZhazk4cHhGQzdxTzIr?=
 =?utf-8?B?WHlNcUlPM0xzOGMxZWg2SUFYMlU1R3p0a0Q2TXUzUENXdmY4cnY0WVJzWG0z?=
 =?utf-8?B?TThLTURRejc0NnF4bjdMY0VNeWUzTDE4SDRxajcvb3FZcmFaMVZKZzJ1TVU0?=
 =?utf-8?B?d0w0blREVkR5Um56dUhNYXcxRW85NkhGTWtDS25OTkloVHpqOWlqaDF1S0xm?=
 =?utf-8?B?M3l4MFhwQXpLVW9qT2lhODFvTUtLdVhzWk1ETlkxMUZNQzVxRmpQQ3NMaTBp?=
 =?utf-8?B?cnRINkhpV1E3OGpRaG1qYTlieU5ZL3h0SnArMURvTC9pTUl6TnRGWEtZbFJv?=
 =?utf-8?B?K3F0NXdOUnkxK3M5bEcrTkZpTjFwL0ZCWTRRSFZIdVJzRWlVb2wycjdmbDVl?=
 =?utf-8?B?RWEreXNFalZ6dGFJeXd5VUh1WTlaZi9HZ1ZxLzdEdkM3aXZFd28xWngrUDZT?=
 =?utf-8?B?WjdpOHlRU3luNTZrV3FXcXZocFJLZzFJRU9oVjRCZkRWMWs4N1ZkMWNkZTlm?=
 =?utf-8?B?RDdmaEJvREtjS3FmOHhYZFllVWVrNDhUVFBSK2Y4WVJKSENOQm1RWmkrNlht?=
 =?utf-8?B?cnhRV25NVTBCeTFDMHVjSks1QWFTemxxRmQwZ2EwcnhUaGlEeWluVVhaa05D?=
 =?utf-8?B?a1pIek93VjBvb2JoUjRtSG9DZURhbmttcTNEeFl4UXA3aGtPTHl5MjBqd2lJ?=
 =?utf-8?B?NEk2cTlaNmNld3VSaTFGU09NdU96Z0xNV21wWUI1NVNiN0RkSjEzU2NhNUpQ?=
 =?utf-8?B?YWErTzFCNkszbVh6SVpBdWR2NHRVdzFUT1pEVlJZTDVGNTJSTHZZQlhvNnRN?=
 =?utf-8?B?amlzV1NJZEpLQ0RRazN3UHd5UnFvUkVvZWNZMW1LUG8zTTNWY1NhZEI3aEpu?=
 =?utf-8?B?VnpUVzByN2hLK2ZPZ1RSVktJM3JON0RLNE5USndteDcya1dWNEtXcmtSQmpS?=
 =?utf-8?B?bEtDa1FSL1gzM3lpa1l2UGhLY05RbDRESUJTRHJaT2VYdmYweXdpM1pEMVBE?=
 =?utf-8?B?MGpGWDkzcnlESXQrakVJc1NWeVE3ZGlDYW81S0J4d3VzZmpCdzkyN3FpQm5T?=
 =?utf-8?B?dWdFU0ZIbEI0V2NlVUpxNzFBY1M5Nmd4L3huMnJkV3ErQTNDL1UyMkpld0Zs?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CEC7EA2A7880A4A836901D7B309380E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1a93c0-fc8a-441e-8794-08dce9954fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 01:37:47.6492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1APENbJUPyKO4wsUNxTIvWfsI6FvfwHsT2kZCTxa3uzo18mogOolYUhNMrqz0ycaZ7X/aOMgOSCWZhunWK3qbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTEwLTEwIGF0IDE0OjMxIC0wNzAwLCBKaW0gTWF0dHNvbiB3cm90ZToNCj4g
PiBDdXJyZW50bHksIGtlcm5lbCBlbnVtZXJhdGVzIHRoZSBwb3NzaWJsZSBDUFVzIGJ5IHBhcnNp
bmcgYm90aCBBQ1BJDQo+ID4gTUFEVA0KPiA+IExvY2FsIEFQSUMgZW50cmllcyBhbmQgeDJBUElD
IGVudHJpZXMuIFNvIENQVXMgd2l0aCAidmFsaWQiIEFQSUMNCj4gPiBJRHMsDQo+ID4gZXZlbiBp
ZiB0aGV5IGhhdmUgZHVwbGljYXRlZCBBUElDIElEcyBpbiBMb2NhbCBBUElDIGFuZCB4MkFQSUMs
IGFyZQ0KPiA+IGFsd2F5cyBlbnVtZXJhdGVkLg0KPiA+IA0KPiA+IEJlbG93IGlzIHdoYXQgQUNQ
SSBNQURUIExvY2FsIEFQSUMgYW5kIHgyQVBJQyBkZXNjcmliZXMgb24gYW4NCj4gPiBJdmVicmlk
Z2UtRVAgc3lzdGVtLA0KPiA+IA0KPiA+IFswMkNoIDAwNDTCoMKgIDFdwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFN1YnRhYmxlIFR5cGUgOiAwMCBbUHJvY2Vzc29yIExvY2FsDQo+ID4g
QVBJQ10NCj4gPiBbMDJGaCAwMDQ3wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBMb2NhbCBBcGljIElEIDogMDANCj4gPiAuLi4NCj4gPiBbMTY0aCAwMzU2wqDCoCAxXcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTdWJ0YWJsZSBUeXBlIDogMDAgW1Byb2Nlc3NvciBM
b2NhbA0KPiA+IEFQSUNdDQo+ID4gWzE2N2ggMDM1OcKgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTG9jYWwgQXBpYyBJRCA6IDM5DQo+ID4gWzE2Q2ggMDM2NMKgwqAgMV3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU3VidGFibGUgVHlwZSA6IDAwIFtQcm9jZXNzb3Ig
TG9jYWwNCj4gPiBBUElDXQ0KPiA+IFsxNkZoIDAzNjfCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIExvY2FsIEFwaWMgSUQgOiBGRg0KPiA+IC4uLg0KPiA+IFszRUNoIDEwMDTC
oMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN1YnRhYmxlIFR5cGUgOiAwOSBb
UHJvY2Vzc29yIExvY2FsDQo+ID4geDJBUElDXQ0KPiA+IFszRjBoIDEwMDjCoMKgIDRdwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFByb2Nlc3NvciB4MkFwaWMgSUQgOiAwMDAwMDAwMA0K
PiA+IC4uLg0KPiA+IFtCNUNoIDI5MDjCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFN1YnRhYmxlIFR5cGUgOiAwOSBbUHJvY2Vzc29yIExvY2FsDQo+ID4geDJBUElDXQ0KPiA+
IFtCNjBoIDI5MTLCoMKgIDRdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFByb2Nlc3Nv
ciB4MkFwaWMgSUQgOiAwMDAwMDA3Nw0KPiA+IA0KPiA+IEFzIGEgcmVzdWx0LCBrZXJuZWwgc2hv
d3MgInNtcGJvb3Q6IEFsbG93aW5nIDE2OCBDUFVzLCAxMjAgaG90cGx1Zw0KPiA+IENQVXMiLg0K
PiA+IEFuZCB0aGlzIHdhc3RlcyBzaWduaWZpY2FudCBhbW91bnQgb2YgbWVtb3J5IGZvciB0aGUg
cGVyLWNwdSBkYXRhLg0KPiA+IFBsdXMgdGhpcyBhbHNvIGJyZWFrcw0KPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC84N2VkbTM2cXFiLmZmc0B0Z2x4LywNCj4gPiBiZWNhdXNlIF9fbWF4
X2xvZ2ljYWxfcGFja2FnZXMgaXMgb3Zlci1lc3RpbWF0ZWQgYnkgdGhlIEFQSUMgSURzIGluDQo+
ID4gdGhlIHgyQVBJQyBlbnRyaWVzLg0KPiA+IA0KPiA+IEFjY29yZGluZyB0bw0KPiA+IGh0dHBz
Oi8vdWVmaS5vcmcvc3BlY3MvQUNQSS82LjUvMDVfQUNQSV9Tb2Z0d2FyZV9Qcm9ncmFtbWluZ19N
b2RlbC5odG1sI3Byb2Nlc3Nvci1sb2NhbC14MmFwaWMtc3RydWN0dXJlDQo+ID4gLA0KPiA+ICJb
Q29tcGF0aWJpbGl0eSBub3RlXSBPbiBzb21lIGxlZ2FjeSBPU2VzLCBMb2dpY2FsIHByb2Nlc3Nv
cnMgd2l0aA0KPiA+IEFQSUMNCj4gPiBJRCB2YWx1ZXMgbGVzcyB0aGFuIDI1NSAod2hldGhlciBp
biBYQVBJQyBvciBYMkFQSUMgbW9kZSkgbXVzdCB1c2UNCj4gPiB0aGUNCj4gPiBQcm9jZXNzb3Ig
TG9jYWwgQVBJQyBzdHJ1Y3R1cmUgdG8gY29udmV5IHRoZWlyIEFQSUMgaW5mb3JtYXRpb24gdG8N
Cj4gPiBPU1BNLA0KPiA+IGFuZCB0aG9zZSBwcm9jZXNzb3JzIG11c3QgYmUgZGVjbGFyZWQgaW4g
dGhlIERTRFQgdXNpbmcgdGhlDQo+ID4gUHJvY2Vzc29yKCkNCj4gPiBrZXl3b3JkLiBMb2dpY2Fs
IHByb2Nlc3NvcnMgd2l0aCBBUElDIElEIHZhbHVlcyAyNTUgYW5kIGdyZWF0ZXINCj4gPiBtdXN0
IHVzZQ0KPiA+IHRoZSBQcm9jZXNzb3IgTG9jYWwgeDJBUElDIHN0cnVjdHVyZSBhbmQgYmUgZGVj
bGFyZWQgdXNpbmcgdGhlDQo+ID4gRGV2aWNlKCkNCj4gPiBrZXl3b3JkLiIuDQo+ID4gDQo+ID4g
RW51bWVyYXRlIENQVXMgZnJvbSB4MkFQSUMgZW50aWVzIHdpdGggQVBJQyBJRCB2YWx1ZXMgMjU1
IG9yDQo+ID4gZ3JlYXRlciwNCj4gPiB3aGVuIHZhbGlkIENQVSBmcm9tIExvY2FsIEFQSUMgaXMg
YWxyZWFkeSBkZXRlY3RlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1
aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gSSBkaWRuJ3QgZmluZCBhbnkgY2xlYXIg
c3RhdGVtZW50IGluIHRoZSBBQ1BJIHNwZWMgYWJvdXQgaWYgYQ0KPiA+IG1peHR1cmUgb2YNCj4g
PiBMb2NhbCBBUElDIGFuZCB4MkFQSUMgZW50cmllcyBpcyBhbGxvd2VkIG9yIG5vdC4gU28gaXQg
d291bGQgYmUNCj4gPiBncmVhdCBpZg0KPiA+IHRoaXMgY2FuIGJlIGNsYXJpZmllZC4NCj4gDQo+
IEhhcyB0aGlzIGJlZW4gY2xhcmlmaWVkPw0KPiANCj4gVGhlIHJlYXNvbiB0aGF0IEkgYXNrIGlz
IHRoYXQgR29vZ2xlIENsb3VkIGhhcyBhIDM2MCB2Q1BVIFplbjQgVk0NCj4gb2NjdXB5aW5nIHR3
byB2aXJ0dWFsIHNvY2tldHMsIGFuZCB0aGUgY29ycmVzcG9uZGluZyBNQURUIHRhYmxlIGhhcyBh
DQo+IG1peHR1cmUgb2YgTG9jYWwgQVBJQyBhbmQgWDJBUElDIGVudHJpZXMuDQo+IA0KPiBBbGwg
b2YgdGhlIExQVXMgaW4gdmlydHVhbCBzb2NrZXQgMCBoYXZlIGV4dGVuZGVkIEFQSUMgSURzIGJl
bG93IDI1NSwNCj4gYW5kIHRoZXkgaGF2ZSBMb2NhbCBBUElDIGVudHJpZXMuIEFsbCBvZiB0aGUg
TFBVcyBpbiB2aXJ0dWFsIHNvY2tldCAxDQo+IGhhdmUgZXh0ZW5kZWQgQVBJQyBJRHMgYWJvdmUg
MjU1LCBhbmQgdGhleSBoYXZlIFgyQVBJQyBlbnRyaWVzLg0KPiANCj4gUHJpb3IgdG8gdGhpcyBj
aGFuZ2UsIExpbnV4IGFzc2lnbmVkIENQVSBudW1iZXJzIHRvIGFsbCBldmVuLW51bWJlcmVkDQo+
IExQVXMgb24gdmlydHVhbCBzb2NrZXQgMCwgZm9sbG93ZWQgYnkgYWxsIGV2ZW4tbnVtYmVyZWQg
TFBVcyBvbg0KPiB2aXJ0dWFsIHNvY2tldCAxLCBmb2xsb3dlZCBieSBhbGwgb2RkLW51bWJlcmVk
IExQVXMgb24gdmlydHVhbCBzb2NrZXQNCj4gMCwgZm9sbG93ZWQgYnkgYWxsIG9kZC1udW1iZXJl
ZCBMUFVzIG9uIHZpcnR1YWwgc29ja2V0IDEuDQo+IA0KPiBub2RlwqAgIzAsIENQVXM6wqDCoMKg
wqDCoMKgwqDCoMKgICMxwqDCoCAjMsKgIC4uLsKgwqAgIzg3wqAgIzg4wqAgIzg5DQo+IG5vZGXC
oCAjMSwgQ1BVczrCoMKgwqAgIzkwwqAgIzkxwqAgIzkywqAgLi4uwqAgIzE3NyAjMTc4ICMxNzkN
Cj4gbm9kZcKgICMwLCBDUFVzOsKgwqAgIzE4MCAjMTgxICMxODLCoCAuLi7CoCAjMjY3ICMyNjgg
IzI2OQ0KPiBub2RlwqAgIzEsIENQVXM6wqDCoCAjMjcwICMyNzEgIzI3MsKgIC4uLsKgICMzNTcg
IzM1OCAjMzU5DQo+IA0KPiBBZnRlciB0aGlzIGNoYW5nZSwgaG93ZXZlciwgTGludXggYXNzaWdu
cyBDUFUgbnVtYmVycyB0byBhbGwgTFBVcyBvbg0KPiB2aXJ0dWFsIHNvY2tldCAwIGJlZm9yZSBh
c3NpZ25pbmcgYW55IENQVSBudW1iZXJzIHRvIExQVXMgb24gdmlydHVhbA0KPiBzb2NrZXQgMS4N
Cj4gDQo+IG5vZGXCoCAjMCwgQ1BVczrCoMKgwqDCoMKgwqDCoMKgwqAgIzHCoMKgICMywqAgLi4u
wqDCoCAjODfCoCAjODjCoCAjODkNCj4gbm9kZcKgICMxLCBDUFVzOsKgwqAgIzE4MCAjMTgxICMx
ODLCoCAuLi7CoCAjMjY3ICMyNjggIzI2OQ0KPiBub2RlwqAgIzAsIENQVXM6wqDCoMKgICM5MMKg
ICM5McKgICM5MsKgIC4uLsKgICMxNzcgIzE3OCAjMTc5DQo+IG5vZGXCoCAjMSwgQ1BVczrCoMKg
ICMyNzAgIzI3MSAjMjcywqAgLi4uwqAgIzM1NyAjMzU4ICMzNTkNCj4gDQo+IEkgc3VzcGVjdCB0
aGF0IHRoaXMgaXMgYmVjYXVzZSBhbGwgTG9jYWwgQVBJQyBNQURUIGVudHJpZXMgYXJlIG5vdw0K
PiBwcm9jZXNzZWQgYmVmb3JlIGFsbCBYMkFQSUMgTUFEVCBlbnRyaWVzLCB3aGVyZWFzIHRoZXkg
bWF5IGhhdmUgYmVlbg0KPiBpbnRlcmxlYXZlZCBiZWZvcmUuDQoNCmFncmVlZC4NCmNhbiB5b3Ug
YXR0YWNoIHRoZSBhY3BpZHVtcCB0byBjb25maXJtIHRoaXM/DQoNCj4gDQo+IFRCSCwgSSdtIG5v
dCBzdXJlIHRoYXQgdGhlcmUgaXMgYWN0dWFsbHkgYW55dGhpbmcgd3Jvbmcgd2l0aCB0aGUgbmV3
DQo+IG51bWJlcmluZyBzY2hlbWUuDQo+ICBUaGUgdG9wb2xvZ3kgaXMgcmVwb3J0ZWQgY29ycmVj
dGx5IChlLmcuIGluDQo+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvdG9wb2xvZ3kvdGhy
ZWFkX3NpYmxpbmdzX2xpc3QpLiBZZXQsIHRoZQ0KPiBuZXcgZW51bWVyYXRpb24gZG9lcyBzZWVt
IHRvIGNvbnRyYWRpY3QgdXNlciBleHBlY3RhdGlvbnMuDQo+IA0KDQpXZWxsLCB3ZSBjYW4gc2F5
IHRoaXMgaXMgYSB2aW9sYXRpb24gb2YgdGhlIEFDUEkgc3BlYy4NCiJPU1BNIHNob3VsZCBpbml0
aWFsaXplIHByb2Nlc3NvcnMgaW4gdGhlIG9yZGVyIHRoYXQgdGhleSBhcHBlYXIgaW4gdGhlDQpN
QURULiIgZXZlbiBmb3IgaW50ZXJsZWF2ZWQgTEFQSUMgYW5kIFgyQVBJQyBlbnRyaWVzLg0KDQpN
YXliZSB3ZSBuZWVkIHR3byBzdGVwcyBmb3IgTEFQSUMvWDJBUElDIHBhcnNpbmcuDQoxLiBjaGVj
ayBpZiB0aGVyZSBpcyB2YWxpZCBMQVBJQyBlbnRyeSBieSBnb2luZyB0aHJvdWdoIGFsbCBMQVBJ
Qw0KZW50cmllcyBmaXJzdA0KMi4gcGFyc2UgTEFQSUMvWDJBUElDIHN0cmljdGx5IGZvbGxvd2lu
ZyB0aGUgb3JkZXIgaW4gTUFEVC4gKGxpa2Ugd2UgZG8NCmJlZm9yZSkNCg0KdGhhbmtzLA0KcnVp
DQo=

