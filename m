Return-Path: <linux-acpi+bounces-12877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2007A81A27
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 02:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D237AEEFF
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3A78F5D;
	Wed,  9 Apr 2025 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkRk+wlc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6ABAD5E;
	Wed,  9 Apr 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160064; cv=fail; b=kK6yIZzbgU+vJkF5N2FAS1XFQ089Jzd/+rDJZL2NsM2lsIfoXhzhw6KtRddNvq607zkpRiu4gBnfWTbJ8F8uWj1RM4yFXxFrwhb+q47RogonvPstf7ZJTkfHtE9I0cfWhGF/C4Mtc+16+6471WFaxds5qT5DhuUJRMIKHr09b3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160064; c=relaxed/simple;
	bh=Vry+/EJYog+ha4wdCQK7e0ADyFeZFyCIcPz9CvZ8Gwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K2wREdZ77HAykemWcrAmf9xDqUunDdi+tgNVx+fRZ+Sxf9PoFEtQQbOfSznb6UhfyOa8myUxGwcg7qjjHpTC0uWBola3erf8JsOHH3Fvwobso9pefrH6JHHwggIwEzP7eba48eyU4WifeGqi7QC5HUiIo7UezxnSTVqEiL1THlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkRk+wlc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744160062; x=1775696062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vry+/EJYog+ha4wdCQK7e0ADyFeZFyCIcPz9CvZ8Gwc=;
  b=GkRk+wlc1cH/qaSpuPh4IbQCPzTb6ie6M/2Nfi9nnskUMVbwthG/TYvq
   wDD498WOXWjSfv+JEmJI1yBYGQodR7cyOpys23Dhat+0ngF4zCpz5qd/y
   XViNjjquRGyMRrnZxvDOu0rVZNSFf4BpdofbXBe4s7AW/h0YU4noT5MrF
   BZdNnDcFvJdWWeeNsw6fsQS+UmcsjTCVyr4TVduuMIRm5E4II+2W2Y2bJ
   OcnJ2SAQLPajkcyKJdZvI+eyEN7dIs2nHT/OungYARi1Vmu7B8mu5lxB2
   /h+IQtIpxQESZoyFntLLX5XMkJL8wYvnVcRcAaF44TJ+uOFuApGiZBzX9
   A==;
X-CSE-ConnectionGUID: A3MYWZpuSsWKMLQLGZhvLQ==
X-CSE-MsgGUID: 3X7I4CLORe6AcZ3GUz6FxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70990415"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="70990415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 17:54:21 -0700
X-CSE-ConnectionGUID: dRhZu/pSR+upVsPfM4GG0g==
X-CSE-MsgGUID: NKZYkQbyTDKYM3/iL4ViIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="132554316"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 17:54:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 17:54:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 17:54:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 17:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzkLJ+rkF/c1NoyaMa/o2CeXODQ7WRxHaacVN6edS9hoKHJgtWhbL3wFALHQeh2QMQvLRMS+z6gw7cKrDV0UpuREUgpibP52wO7pTABW2NSOLcNwXVlnuainwfcxZxJlnLntBjB4PXMhcE0n8po+1+SVeYnjzPf2Tw9QcCr2TnlwK1n/bKqx/kqjSByHZ9mY0iAXSKs/3k13uocuW1/KihP2IYk6tDS1KvuuJgOQ+9Bmp54MFWh9c3vkz1c/ZtXJzlXJJ8XzWgyRv6EiGBGuVXK53/644oWCgOLZTpgSoW5F4vQmTP1i3khjxhgi1fOUVR5mlwkvPDvvPVJscRuBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vry+/EJYog+ha4wdCQK7e0ADyFeZFyCIcPz9CvZ8Gwc=;
 b=YOFMvpiqk5lvEGj3F+QzCD10Q5/hep+XDaKtUwegZ4hQxaPVoth0BR+N1xVFoQJvDLWBR0G3OeMpEMQL+zy9/PpaWKeF/AF9ZBOY0nVB+wYFSCye2UczLcFvnoz/TUSFTRNcuqE4l6+e1VkexWhlLcs2C51DlzG0KWR82PpBs8o0bw4BI2SIlycJwYM9A7j1EaK2OS0tC0aFC21ImWocrDcRjzNnZdva6PTgKpYeTjZg7nsTD5iMixHg9BHXXikKw7i6R3DOqK2GABE2PfXK84k352w6GRqdEOuO9wazFrSZ4ONLGm04/LYul+X4qvbfM9cEiwsS0yTCCPOmEGunWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 00:54:17 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8606.028; Wed, 9 Apr 2025
 00:54:17 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ggherdovich@suse.cz" <ggherdovich@suse.cz>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Topic: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Index: AQHbn+4UZ+9FL9Dg6U2jNOmvmyjByLOak/iA
Date: Wed, 9 Apr 2025 00:54:17 +0000
Message-ID: <b29519a2da5b85f484b0f402062df2b58ec38afe.camel@intel.com>
References: <20250328143040.9348-1-ggherdovich@suse.cz>
	 <20250328143040.9348-2-ggherdovich@suse.cz>
In-Reply-To: <20250328143040.9348-2-ggherdovich@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB8151:EE_
x-ms-office365-filtering-correlation-id: 0ea223e8-d752-42e3-fcfe-08dd77010e17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QlI1YkY4Y24vc1J6ZHlZQ0RTbDB0TzVZS0pybjJwYlVWbzdLWnhTcnNVSThn?=
 =?utf-8?B?VlFDV1BpekJyelA2M0FoRTFuMDZCUVBjc1QrazRZaXk1VEVtVlg4THRNODNJ?=
 =?utf-8?B?c0FJaDdiWVhlczFod2syR0VNM25rdUk0SzVuc254VTMzUS9TTUQrTlhGTHQ1?=
 =?utf-8?B?enVGZWE2Nm9lYlVaeXhhMGZJUGNXZEpuT1ZiYVd3YzZySzZUcFZ6MkZtQ0RT?=
 =?utf-8?B?NGo0K2ptN0VkUUtpSkFxeUpYbERGN1ExSjg3NHQ4VUpoR1p4aUhBZSs5VTJ4?=
 =?utf-8?B?TlU0RGhqNi9oNThTSHlMenhQTVYwa0lqbUlpZGQyU2ZlOFZFUUUyZXRjamUz?=
 =?utf-8?B?b0JpSTNvckV1VnBGdjhjQlpHWkR5L2kxcDg4MGVYQjErTHlNem5UVlY5NlRi?=
 =?utf-8?B?eGh4WFZrNlhHVlo0QlYwZ1RKNGh2amwrcEpoU0VYbzhHaXgzZGxsdTZaSHBT?=
 =?utf-8?B?SDFOaDdldEYvYjRUYjR3Z0IvMTZGY3QzOXZFbjB4Wlk1dlp0czRHS0pENEdZ?=
 =?utf-8?B?dE1sSUhkVFllMng4VGw4THdYeGdtT0FVRWlFZzVPZjlTamxOV1oxRGdjMmFh?=
 =?utf-8?B?a3FOdFI4NnlsSGwzRFlkbHRxWk15VHRYWkIyZFhjR1lpQTRybncxZkFtOFZH?=
 =?utf-8?B?NkNVaEdHMU95SkhuSXc3WlRZdUtvZXptbEFTVnQ4SVRUVXYybTlKYmRVMmdt?=
 =?utf-8?B?MlpIcHhNNVk2M3Z3N1pwNWNQN2tod3NFWnJvRUpnNmxTZUpqUVdUcGRMZERr?=
 =?utf-8?B?VVY3QzcxVUYvNGh6UWNSM1JoM1B3QlpEeUx3WDd3U3phbEZJRnNYbVo2NHJU?=
 =?utf-8?B?UFF6djFXVW1kVFpxWHhFRzNZcmlDNUpwV0ZoOGdRWlRLb0VFQmRzWTF1N3o5?=
 =?utf-8?B?RG53ZUN3dFkvRkRuRkN5SXBoRkplRHhOYWprVzJrcmd4MkdWK2NFSVRvMXJ3?=
 =?utf-8?B?TlBHTi8rdFIzSk9LTXE5Ylg2Rm1PZFE0b2dmNFpYQmxWaWpVWjNhQVZ1Qk5X?=
 =?utf-8?B?NlFRRWpaUStZWWRlSVZ5N2Q1NlQwMjU1ZmNkNEpEYTcwUGk1Wm5xVFlQMGJt?=
 =?utf-8?B?UDZYa3lXN3ZHNGMwVGhnWlA4a2dGQzFWQjJSRmd3OVRFTnBlejhudzhFM3hH?=
 =?utf-8?B?UzVrRjA2SnR2N1lOLzRnWklaY1VUZnMyMlM4SGVKOVllbTFhWUFsVk1xMFlt?=
 =?utf-8?B?V1NUMnAzek82OWlXQldSMHdZREhvT29oWFNYcWdvVFBoZDRsQk1nMzR6N3Z4?=
 =?utf-8?B?TkhSNXBvY3h0R001UGV6Zm1OQjRKRmg2a2VGSEgwS1owbTFNcGRxaDU1cmNH?=
 =?utf-8?B?Y290RHcrUll2Y2I3cytlb3IyV0NldGtkUXpobU5VdHN6MjZGNVpuOFNsMTJu?=
 =?utf-8?B?c2lFSkYwQnZ2U0JRS09oZEwyaEFBNWhEWllQQWwwcDRXaVQxUDFIMXd6eS9H?=
 =?utf-8?B?NDBNK0VCMFN2UGN4a3haTzlCVHcxM2dPNlM4eGp6VzFuQUNBODFyQ3BIZ0dO?=
 =?utf-8?B?ajlLWjZzeDNCZE9uL3k4ajhBUVNGNUIwV2cybWZkUFk5YkMyTFZRdVJlbmVr?=
 =?utf-8?B?aTlzdnA4NS9DZUdVbWR5UmlCbDNLODhWbDU5eWhlZnBvcVlPWUNURXYwbzZW?=
 =?utf-8?B?bkNBanpqaTZZbGVBbTdIbWdVelVXQms2dUhCVFBEalVJWm50TitkN21GVkcx?=
 =?utf-8?B?NW5BQ2Y2cGppVTVTK2Uvc1l5anhxUVYyc0h4cEw1Qkp0S1YvTXF0ZDdpMDJq?=
 =?utf-8?B?MXBvVURQWUIvZStnWjZmQkphdExZSlNsQzlta2ZEZERBcFdFNlhnTXFwSFRH?=
 =?utf-8?B?TDF0V2dqaVVDZVprYzVDZ0xaclRHZGtrT0JWOFFrT2lMMEdHZnhySG5jUUd3?=
 =?utf-8?B?eE9QazkzdDFQKzY5MVpDcHhHeFZDZUdqVzdOQm9icE9UMkkwV1ZRNkJ4WGpw?=
 =?utf-8?Q?Seq5rKQ315jHIaMCAuxnRXsInVe0wyKp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXoreW5rMGZubmxlVHZrdzFRV1YyRDF2V2dEZTV0Nm55amc1bTltQmpxT3d0?=
 =?utf-8?B?eUoyTmsxbUI3aVpaU0xIMldGVEdXeWVVeWpVeW5zR2JIVFFPS0ptWG5kbE5m?=
 =?utf-8?B?M3hYb29QQzJTVDRmdHRJVG5KK3owd2l6THhqNTd3OXdISnM2b2ExQUpJanZY?=
 =?utf-8?B?bDRORzdxaTFjZklHYVN4UHFFb0VQTWpjTjhZNElIVXkxTllNMWhPNDdtbHFQ?=
 =?utf-8?B?S0NJZmNMd2dVbzlkU0V1ZisyWldEQ2x5dTRxcmFtUEtoZ09sU0o2Z1NTeDEz?=
 =?utf-8?B?dGpaVzJOS0lMZUluRHB3M1JUK0VJQytSb0c1bGZDVjBpOWRldXdzTWVDUWRK?=
 =?utf-8?B?T3JWblR1MXExL1pMMkpQekZBU1U4VEJRMUlnNmxWb1I1R2ZtR3lDQ3VuZjJl?=
 =?utf-8?B?aXJubDV4aHE4VFUrY0gyaGhsR1ZDNEVlSHpsNjJqUVNnaTJDdjNLN1QzWS9q?=
 =?utf-8?B?eVp4SHVPVklWNk1oaGM4a3RkZGpFNW5aakp1djhqcmcvbjBTQXI1bVlGSk5N?=
 =?utf-8?B?SDBtMlRoeDVWbG9NcndacjlweUs1VDNxQXVSUzRtTTcvZ2d4a2c0L1NrN05F?=
 =?utf-8?B?WVhXaGRLbFpXV2VXTHgwK082ZStaZGVCdHdyZEYyMkVGM3FzUHYxQXZEMFRy?=
 =?utf-8?B?THE1SnNSUUxJTFFvTXF5N0doVEhDajRHNnIxOThWQlQ3OGtWU0xFOSs5dGR2?=
 =?utf-8?B?NXV3eDM1aHN5endrTHY1KzRKR0Mya1E5TkFVRFp4Mk9Rbmw5WEU5RTU2Tmp4?=
 =?utf-8?B?Sytoek5kU0psZTc2T0diZ0VuV21ocGZiLzBNaTRGUHRTZUVCSVZ2Rlh0U09i?=
 =?utf-8?B?RlU3QXd2MVp5WjlHUm1iQWp1bDVZYmYvRjAzSzBYTXNKbnNMbGxJS1JyUVUr?=
 =?utf-8?B?ditkM2loa1V0a0NQLzhiNGZuYmUyeFp6c1ZYS3UzS1gzVSsrQm1EZ0VBblVX?=
 =?utf-8?B?ZTVFK0JneXpOL2JPMCsyUEV3eXNZNzdnZU95RUdGMEFGc0hBVnR1UHNuNUlx?=
 =?utf-8?B?ZlFRRVV6dVp6WUV5eWI5QzlVSHNNZno2NWorZDJnU0RRWTRVVWxvUEF6citP?=
 =?utf-8?B?ZEF3ZGZ2SGJjbC9IMkt1Y2FrUFplM2FybkdBdmdvTnJaTEllN1dqK3h0MVNB?=
 =?utf-8?B?Tk1QazBEb0pOaDg2R2JOaldWRjJINklIVTZzTmUyelU3VXJHcEtoU0laeVRs?=
 =?utf-8?B?cytveVJWWGxlck8vTzJGNmFYY0dHNGpDbE14My9wVlRiZ0o0MU1zVCtMVmRZ?=
 =?utf-8?B?c0E1eDhwMkJhVUptTXhnZFdqb0VUN1M1N0p6MjFIbXgyeWVPYkE2ZjRKRnJE?=
 =?utf-8?B?UTlrSUJoOExjbVZMVzlpWDJTbDFlMEdMOWYvZnpkdzdGY0FUMlVOWE92YWtJ?=
 =?utf-8?B?d0tpKy83YmhhMmhNWTllbjR6VUVwRTBIZU9jL2k2N0J2YzJFWHY5dVdLV0J6?=
 =?utf-8?B?L3BYN1Y0c3F0YzQrN3V1VytObTZGZ1BYbzkyMlNhWVZEQjFyOUx6ZjltMHlw?=
 =?utf-8?B?azl4NVJQbjdCa2lTS0xYQSs2KzRLK2swN2pqeEErZ0V1c3FIOVZvUGZ6MWE2?=
 =?utf-8?B?cmZ2UjYvZXpjb09QazhXWUl1NWFndmFrR2RBUGwrdGlzOFFpc3U2dW1MbFpC?=
 =?utf-8?B?emlIQmV6OXhpM2J2bC9KU0VRclNCcUQ1YkJzVlNtdm1aOEhmREFIUDJOcVZY?=
 =?utf-8?B?NGN2NFFGU3pZb2ozeXlYQWR5M2t0SmNaY29XbGtZTUIreUJHOWhIOTdrcmlj?=
 =?utf-8?B?d3BVV3ByV2RxSkJMQnQwd3FFcU9kRnJqS1ZIaHFtbW9PVkFwUWk2S3dVY2hY?=
 =?utf-8?B?OGdJT0I2TmVWVTh0WkRhNUxxR0ozU0JCNjFuZjFvMnVUQlZuaHM0NFRCdXln?=
 =?utf-8?B?QWxsMzVodDgxS05ZbjYvN2k2WmVyU1dVZlFYa29RUWFnUHBDUDlrSGVBRmZm?=
 =?utf-8?B?VEtLZjlhZXJzTG0yVXBGQks3QVM2ZlZPcmJ0TTBTQ3dtWEk3VThOTmVNTGFi?=
 =?utf-8?B?QTRkN016c3dKUVh2Z1FYWHRzaGptL1lhMVpxb1NXZWlvM0xwei9RbjJ0ampE?=
 =?utf-8?B?V3diSjFCZzBwdjdoeGduRGVtNXhhSmd5Vk9oYnQ0UDNadmlBTWRnaGJraXlG?=
 =?utf-8?B?VURMZHJTT3NJNVJTemxMTnZjeFIzWkluR055U3Ywb2NwL0NRaVY3YXcxTlVl?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B912AD7A08FC841B1A9A642760F629C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea223e8-d752-42e3-fcfe-08dd77010e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 00:54:17.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4BzrMJAD0pCIVHKT2dPETC6Dv5Pn90gKqEUKUGe7dwUtbcW8Ygc20tcRSsl2lJXnS9YUPkJvXKbtVfUmMuw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAzLTI4IGF0IDE1OjMwICswMTAwLCBHaW92YW5uaSBHaGVyZG92aWNoIHdy
b3RlOg0KPiBTaW5jZSBjb21taXQgNDk2MTIxYzAyMTI3ZTljNDYwYjQzNjI0NGMzODI2MGIwNDRj
YzQ1YSAoIkFDUEk6DQo+IHByb2Nlc3NvcjoNCj4gaWRsZTogQWxsb3cgcHJvYmluZyBvbiBwbGF0
Zm9ybXMgd2l0aCBvbmUgQUNQSSBDLXN0YXRlIiksIHRoZSBjb21tZW50DQo+IGRvZXNuJ3QgcmVm
bGVjdCB0aGUgY29kZSBhbnltb3JlOyByZW1vdmUgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBH
aW92YW5uaSBHaGVyZG92aWNoIDxnZ2hlcmRvdmljaEBzdXNlLmN6Pg0KDQpUaGlzIGlzIGEgc3Rh
bmRhbG9uZSBjbGVhbnVwLCBhbmQgZnVydGhlciBjbGVhbnVwcyBhcmUgcG9zdGVkIGluIGENCnNl
cGFyYXRlIHBhdGNoIHNldCBvbiB0b3Agb2YgdGhpcyBvbmUsIHNvDQoNCkFja2VkLWJ5OiBaaGFu
ZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9hY3BpL3By
b2Nlc3Nvcl9pZGxlLmMgfCA0IC0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiBi
L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jDQo+IGluZGV4IGIxODFmN2ZjMjA5MC4uMmEw
NzZjN2E4MjVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0K
PiArKysgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiBAQCAtNDgyLDEwICs0ODIs
NiBAQCBzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2dldF9jc3RhdGVfaW5mbyhzdHJ1Y3QNCj4g
YWNwaV9wcm9jZXNzb3IgKnByKQ0KPiDCoA0KPiDCoAlwci0+cG93ZXIuY291bnQgPSBhY3BpX3By
b2Nlc3Nvcl9wb3dlcl92ZXJpZnkocHIpOw0KPiDCoA0KPiAtCS8qDQo+IC0JICogaWYgb25lIHN0
YXRlIG9mIHR5cGUgQzIgb3IgQzMgaXMgYXZhaWxhYmxlLCBtYXJrIHRoaXMNCj4gLQkgKiBDUFUg
YXMgYmVpbmcgImlkbGUgbWFuYWdlYWJsZSINCj4gLQkgKi8NCj4gwqAJZm9yIChpID0gMTsgaSA8
IEFDUElfUFJPQ0VTU09SX01BWF9QT1dFUjsgaSsrKSB7DQo+IMKgCQlpZiAocHItPnBvd2VyLnN0
YXRlc1tpXS52YWxpZCkgew0KPiDCoAkJCXByLT5wb3dlci5jb3VudCA9IGk7DQoNCg==

