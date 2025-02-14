Return-Path: <linux-acpi+bounces-11185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37917A354A9
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 03:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6553AD506
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 02:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F5146A63;
	Fri, 14 Feb 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGx6pZTD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA413C9C4;
	Fri, 14 Feb 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499799; cv=fail; b=PXSZgOFsPp86JCoP4ShHf9+WirERqe8paeacfah4UxtTE+flIxsMm7nvkrbTqWj653rc8Ngt/2QXU5wKQ/kiEfQ9xeQ5gcOicco63g64kCTvb8nsCma3tQMPOB2jI5meXeOh/g49bhBaBigej7dhZsovHrCMsFHGtUmRI3rVYh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499799; c=relaxed/simple;
	bh=68KYM5RPEpCxMQ0kMmaJNzb2+sTSDmubJ/QqlcM4pHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoUsf1iyE9p0yPfJxQaSp3RYZ/gcj8xTx9rNeMFDTguB7cx+tir+6239UGbNJS4EmFa7m3vPY8xcuS/JkX9vy0iNd7zEyWF4G4jxvmJbIcB3fwYIyz5xYz09svZ4Ymw5OcDJauMi2fmnZ0SGHeV/2q6A1AM1ZsWj+X0vJwc7IMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGx6pZTD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739499798; x=1771035798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=68KYM5RPEpCxMQ0kMmaJNzb2+sTSDmubJ/QqlcM4pHU=;
  b=QGx6pZTDDIf0RQSkJxloM5HNQ3Fg2GBfVNQBuYLlUcMzCAODEDVl8gfC
   cG6SLSj74N0jH/Y5Yd09VmwbWa8KSX7rqdAW+0dK2sb3nWiVqRdlbOeTD
   5nUuBwa6/CG4IgOqE7ardv8QKerDYzkO9Fi39xMlYrgd4gO1md5/+Wey+
   ERnnPm9wg5jPCQKyPH0rHGgJusr3F4ufnUF2esHDUe5DuYORUcJYnVYJq
   CrGEwwdLDXwMCHxjfJx3jtAslQW37wc5urDkHXvFJk4W9m+28aDPIf8+W
   gJreVFPKGTSt4+X/tO/x1pckYpFNNebFw32QvEIUqTz5fv6506nvt2U66
   A==;
X-CSE-ConnectionGUID: yFwPmYODSY2gMCJDn/2cUg==
X-CSE-MsgGUID: 586WWl0CQcm4lgzTPeWycw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40497472"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40497472"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:23:16 -0800
X-CSE-ConnectionGUID: Fkm4eT0/S+q70c1ZFjJSkw==
X-CSE-MsgGUID: 8fs0D/RRQq+YIli8wRouFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118340129"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:23:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Feb 2025 18:23:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 18:23:16 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:23:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjMsNJy4bEyQGVY2aKeDuGumhHwl44xquaG0hOCxwhHVBeUqpH0UHGxhOVpRzNKOLOee8WltI6mhCKCScZJSWUGLpUmFw/LsQLl/KpytpNL4sLdrGRJnyfJU79MlxfU2S2yiyhO+IX1o1+Hj07OkX58v6PwW/eoU+UMpbtV4VflvG8cYxbEV+M5POmvq38uchJDHsJQLazrFPv4zMyi3690vgu7SkgyIejBI2vXBVmN5bX0VQnxI4qEH8fNuIXKh+MZP8nqL6+aHdsuwAqkGo8ZzH2d75GZ5ZfZdSxXDpK7fxEM9/am0zIZAMSlrjH4ekSGc8DXNNtv/hMsfcXl0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68KYM5RPEpCxMQ0kMmaJNzb2+sTSDmubJ/QqlcM4pHU=;
 b=Y9nG2maM5tOj4qW1oBtfg5KOmumq75v4gO1mU9l6TB21Er6C1sz1tw1GdMuzaVznwWEvHuNMAkPQ6ovxILawQVALygQz7u888DPeDcvj1MVGXRP8ETQroJfSliEWK0XlhRexOsCs8sk598gw4ZfY2Jj7QTHHzeEHsDRIjlPiFSb6IJZVpHXVptl1obg/+sDSDkOHQBerBzYZwPIOqWvDGDxuauD4d5109mMo9fD+jOeYEvJ6AtfAo7PQYlmzkWflhzVmMZ+AnduHJsize3DJDfBxZWghkvERynfqn8dumkpIbG2lQegsLIdlOHK9p800ibodiletM9J3AHaDaqn4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB8141.namprd11.prod.outlook.com (2603:10b6:610:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 02:23:05 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 02:23:05 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "luto@kernel.org"
	<luto@kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "irogers@google.com"
	<irogers@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "lenb@kernel.org"
	<lenb@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "acme@kernel.org" <acme@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
Thread-Topic: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
Thread-Index: AQHbfL2rjK1vhQiYLUq3fbVp1YoV0LNClfWAgAALQoCAAQ14gIAANicAgAIwboA=
Date: Fri, 14 Feb 2025 02:23:05 +0000
Message-ID: <52278458a9c3e7a1f8a1ae03165dd34ebcdba36a.camel@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
	 <20250211194407.2577252-8-sohil.mehta@intel.com>
	 <23e24c79-96ca-45da-832b-83a9b6456208@intel.com>
	 <882357df-7600-4aee-9fb1-4a118872f1af@intel.com>
	 <273b9080d42bcd2fb36fc4510416f0e111edee62.camel@intel.com>
	 <78895061-6f1e-4d3b-9481-95f47f97ab96@intel.com>
In-Reply-To: <78895061-6f1e-4d3b-9481-95f47f97ab96@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB8141:EE_
x-ms-office365-filtering-correlation-id: 3572da1c-c474-441a-2ee7-08dd4c9e83ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlgvSWd2Tk5tU0tKUlFiSXlESmdHZW5OK3UyOUh5bVlCbnhxS2luZ3BpdlB0?=
 =?utf-8?B?bzBvOUsydFdabHlLSGhRMWYxZzRIUVprdThJY01maWU1V1hhTU85THRvWlBo?=
 =?utf-8?B?R1dsTGFHTGlEdDVNcFJVdGwyVkh1bUhjQVJaWXNuOXJUOW0rM2d2YjI4aEIy?=
 =?utf-8?B?c01RVGU2ZVpZUG5HQTR1RXl4cmc3WGtxejhwR3lsMDREQ1U0MG1WU3RTMmRY?=
 =?utf-8?B?UGpYUUJ5RTh1NGNIVmVwanhmSnFNdGdVZ0FQaHFqQ28yNVhwaldOa0xBTitr?=
 =?utf-8?B?dlo5dE1aRWdVZmJuc0NnVE9hd25jY1hVRFVVbnU4MlJUMjRmVmhzRDMrT0g5?=
 =?utf-8?B?ZlFBZ3ZuZDh6aDlaZzcrdGw5TVltbmZtU080cCtOZDlGdkVSYmJQNzNBMEFh?=
 =?utf-8?B?V1phYlpHRTZFTEEveDM1RTI2eEdkcExsZmhoYlYrbnBtZ2FRdHdQcjVHaDh3?=
 =?utf-8?B?ZVFnMTVNOFZwYkw4ZW9NZWY5WE5TR3g3MERtNjhmOXJjSG5sNFpuYURLN2Fq?=
 =?utf-8?B?NnU4MkMvTW5sSXROWG5kUDFNcWpiRXA2R0VDM2NwYmJxdjZ6L0dTZmpiMmd3?=
 =?utf-8?B?RVZpcXBXd3RIbFIyN2FONGJwclJia3diaitDZVM1cFdXVU1kNFZnbjBFU0k1?=
 =?utf-8?B?QmpUMU5DaUYrTis5QlViVmFsNUNOOVJQazAvMnRIcmlYemliR0lVTGJOWThl?=
 =?utf-8?B?cEZ1cVZaV1RlbWNKeGRCTHNmenNhWWpBZEpTeWEwWjdlWlNEMHBtN0Z6b3Vi?=
 =?utf-8?B?K1ZDZnBUTVRydjNtY2dqVDB6TW9wOWFOZW5ZdjJhZXltOHBlbUxlcWx0blFi?=
 =?utf-8?B?eVAwWHR1WExEdnRiUDhpcEVkWVJHOVVCZzA1TWhzQ0FqQUpFaFJuU1lreSs5?=
 =?utf-8?B?cCtNVFRpOS9EdG5DM0w0dGlZajJ5QmZIdlhla0FoTHh0eEFpVzBPL003QUlr?=
 =?utf-8?B?OWozY2IvK3QvbitocXZiUUNjcUtFZTBOazlSbG10RDhTQVVkaGF0Y1o5S2Fv?=
 =?utf-8?B?V1o0aDNNTUJXM294RXh1UFl0T2djUWNYYm4yRmVZN3JrUE5yL0tYUjN2Q3lp?=
 =?utf-8?B?cTlxNG1LY2NkYTFKOVVwVHJlTTVaelh0TXppRTRVMGxHWVIyTXl0QTRNTmtn?=
 =?utf-8?B?RFhyYTh0TDB3NEpOZkF0UUo2UXRpTy9KaTlyeVFTN0I2SnNYUzJHWXV5ZytG?=
 =?utf-8?B?YmcwcHNkMlRQVURSUkFFTGRoR1FRQlJCM3c0MXFVRS8yeHFLMXBCYnFPeFgr?=
 =?utf-8?B?TGdmY3ZpVG5MUGhobnF1eE9OandIN1BqMXpoaEZ3VlovcFZKOHVLUDhuSkgv?=
 =?utf-8?B?eEJzYThmK2NTbURyNld5ZmVJbkhWMnlkc1pqTXR0ejZhcjh6bXhFemp2bTc0?=
 =?utf-8?B?Vi9tMllYcDJVdFIyZkFxdW1jdFR1Y0pCNUFmZkJlL050SUJSd0w2YVQ0WjR1?=
 =?utf-8?B?S2lvUGNqd20vbjZoWFZIN04yMXVFN0N4aHZkWGhJODdsazFGd1ArcmhYMWJ3?=
 =?utf-8?B?MGNKYktRVzkzQU9VRmhYUlJHNlhIKzF0K0FyTVN3NTl0UCtOUmxEam1CSTcy?=
 =?utf-8?B?ZzhVdzhGQU9BQ2ppZEZ3U3BnWDFFdmFCZmliU2U3NFBOazdOemlJVll3OGFo?=
 =?utf-8?B?QTlhelV0ZzcxYnBoY283aWxCNmtnbGhveGMxRGtZTG5FM080eXdxQ1czdnU2?=
 =?utf-8?B?R2NyemFZVHdkaUMwajYyUVpJRWVQTUVnaUhiUDFERmc2bU9WeVNjYUM1eUZk?=
 =?utf-8?B?c1o1ays1Tm5telpCQUpRWFJnVFIzSG9QNXFOUng0dC9HZnZ1QVF2MEVPb2gz?=
 =?utf-8?B?T1BSRWVHTnZaZWZRcjYvWDhBUzhCYUhPaXUxQmh3NzBtdFNKcGhBQVhsbU54?=
 =?utf-8?B?bGdyOGNWUndLaVRWUUFkcWpNTXhBelByR3JaR3B1a3lwVnc0SWpWMWY4ZzFv?=
 =?utf-8?Q?x6lzLXWJw5lIOhKB2FmNL9kR+WWh3Q/W?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERJcFUxOWRkeVRMQnN4M0hYdmc3dVhqSHJINmpEMlpuSlM1RUpCdzc2UzZJ?=
 =?utf-8?B?NXFWUVh4ZWMrREQwN1NZeFNUQzhRSi8zOTVmNGpSMlplK2MzdlV1cSt1R0xY?=
 =?utf-8?B?N2EvRFJmalJsVDJwVFFyTThzMkZpTXlSdEpDTUZFTXA2bEMzOFNtMng3N3pU?=
 =?utf-8?B?U2NwRkMxbW11U0xEVkJVZ0hKenU5UjZsYU4yQllKWDZrclNicFBMQTBjeCtS?=
 =?utf-8?B?Z1pwdGRDR0NFeXEyamFYWDcwVjJRaytmeUs5WDBUVzRPUmtZc1hlVEFRcHRM?=
 =?utf-8?B?ZHkrY01oa0ZFSWM0NzdMdTFVYng1enJFMW4ySXhnVXFpTzNOdDdLRk15QXRS?=
 =?utf-8?B?UWduQzZ1V2RLb3NpVlpCelFyTEMzcE0xMXRMa1p6ZENqWmFZSTRseDREYkdt?=
 =?utf-8?B?MG1hTzBKOHpSL3ZCOW5pcklJYmcrbVdMV3VIRkpEVXJYRXdIZnJmb1FxWmY1?=
 =?utf-8?B?dGNMU3luVlRET2hZYkV4d29VbjRDS2lIMGxTQ0FMaGFHZ0tnWmFoUUNPOW51?=
 =?utf-8?B?U0MrM3hLTlFTOUs5K0dKSkdtRWhoWUtZd3JrM1N6R0RJRGJZcjlZNGwxWEY4?=
 =?utf-8?B?K0ZnVkpJQVBGYW1lZTRtaFJuT3Q3MDk1cEpFSlhrcUpaVHJjWi8vZW9UMjE2?=
 =?utf-8?B?Vk9Ta28zUWJpV09ZcVU0Tm1laGI0MWZ6NTd5S1UvVkpMU21RQ0NYOEI1bGVO?=
 =?utf-8?B?YWRWTENvRFBJOVZJYmxYbEpLWTRSd05FWW1wYnhhTzhZSk1LbnZnTVBFR1N5?=
 =?utf-8?B?a2RveXZJT2s0eldmSTBZSU9oS2huMlIzdllCM3pFUlNDanlBZlRvOE1ESW9R?=
 =?utf-8?B?VFV0aVdRMHJYTXRBWkNyMWVVN2g0dEhTZW03Q2Z6bW5ZWk02ME9xa1ZBaHU0?=
 =?utf-8?B?QSs0RytIclRXQlRMOWR6L2FUY2JPY3dkK0laOXpRc3J4NHRaWG8rSEYwTUgz?=
 =?utf-8?B?Yk8xaDl4cnNONDFPc2lsU2RMMGg3Y3BhVUJvRXdZQTJCZ29hOUJGbXg1bTF1?=
 =?utf-8?B?aDVhQU5pVzJHNnlTMEhVRk9qM0FaZUhzRCtNUloxTFBYKzhFbklVdVdaMlUr?=
 =?utf-8?B?WC9QSVVDMWhEeEJwU1J0clAxaVVUK2RYY1kxMzZUeWJMdkNiN0lJY2ZibGNk?=
 =?utf-8?B?TkJXWml1Q0djbWVQRDhsRDgzUi9UbTZuMlM5VFRYTkx0TWVlbytWTUFONGti?=
 =?utf-8?B?MnZlRW9UMEhBMkNNbjVVcUpUcG05N2JBUmtreGloWmpUbGYrREJxcHM2VWVG?=
 =?utf-8?B?UExDT01pdFpGVS91Tk1jSnYxN09KdUtCMHJCSTdtWEI1SWRXeXBwTHRNWitB?=
 =?utf-8?B?TEkxR1ZJMzByVVhjTWFqOTRvb0lYSzZVZ3g1YlY0NStVKzVBb2t1Z3VQOXpX?=
 =?utf-8?B?aGpwWk4xYU9zcTh2Z3d2Mi82R1F1bzRhV3lnc1B6bDkxZDY2NmZFcUdlY1E3?=
 =?utf-8?B?UVhyb2xWM3JESnc5dWZwbmVHSmZTS2VOTkdVaXJZcTM4MDM4U2VDN2ZrMkdr?=
 =?utf-8?B?NW9MMC9tUENSdFJyZ1Fzb3d3SDlKK1NoT2hDc2tsVVRhVVgwdmFlN25ja1FF?=
 =?utf-8?B?RWhlekFJc1A3QmtMc3dVaUlsdWEwQnAyT1NUSTU4blpnSjZsangxajRHOURU?=
 =?utf-8?B?b2tvOXBoODgvb3N3OWxYK1FOOStvTFBUSDA5WVhPcVYwNmRBMGZEbFJVY0w4?=
 =?utf-8?B?eXlLZlhnb1UrUmNZdFhhYkx5eVpSQ0ZMUENjTzlMWEZpTk0vb2V3SkN2ODVt?=
 =?utf-8?B?Z1lrYzI1Z3o3MWpsL2N4K0IvSmZtclQ0T0I4WUcwZ1FxQW9jUVVkMW1ycDhN?=
 =?utf-8?B?YjZQRm1maXhlMStRREpzTzJsYjFBM2ZWVHdvNWpmNk5XSm5LblNmY0FTQjhW?=
 =?utf-8?B?bU1ZaUdHbFd2M2dtNDVtSjZUdkx1eXJvd09aL0VYcFp1Wi9XT3B5STRFeUx6?=
 =?utf-8?B?UFJ0SDRmZ2RwVy9XODR4bzVaS1VkeXRKSi9HdjZsVGwyUjhLQ213YjU0aHUz?=
 =?utf-8?B?YWkrL0huQjNGR3FvT0F1djQ1QkV1d1R0ZnhaMzN1R2t5bnpKaTVWL3ZFS01D?=
 =?utf-8?B?ZTk2cVFqSFhueDVySER3NWtxMHZvYVBOaW1lSmFiamZ4bHlVS3ZrQTJHZXl4?=
 =?utf-8?Q?HeAKDoy1Ky7eq6/K0ouDrLXFm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0244FA73ED944646BBD1C62EFCDB75F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3572da1c-c474-441a-2ee7-08dd4c9e83ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 02:23:05.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z178Mhqcnyo164P/o0BOrKvfUZMMQDBM2M69WmGhE3OQWK6Gocts5GsgnhybgJq5XCCDTAAGDyvNFDf0budC1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8141
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAyLTEyIGF0IDA4OjU3IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMi8xMi8yNSAwNTo0MywgWmhhbmcsIFJ1aSB3cm90ZToNCj4gPiBJIGFncmVlLg0KPiA+IGFk
anVzdF90am1heCgpIGNvbnRhaW5zIGEgbGlzdCBvZiBxdWlya3MgYmFzZWQgb24gUENJLQ0KPiA+
IElEL3g4Nl92ZW5kb3JfaWQveDg2X21vZGVsL3g4Nl9zdGVwcGluZy4gVGhlIGNvbW1vbiBwcm9i
bGVtIGlzIHRoYXQNCj4gPiBhbGwNCj4gPiB0aGUgcXVpcmtzIGFyZSBmb3IgRmFtNiBwcm9jZXNz
b3JzIGJ1dCB0aGUgZmFtaWx5IGlkIGlzIG5vdA0KPiA+IGNoZWNrZWQuIFNvDQo+ID4gdGhlIGZp
eCBpcyBzdWZmaWNpZW50LiBJbiBmYWN0LCBJIHRoaW5rIGl0IGlzIGJldHRlciB0byBtb3ZlIHRo
ZQ0KPiA+IGNoZWNrDQo+ID4gdG8gdGhlIHZlcnkgYmVnaW5uaW5nIG9mIGFkanVzdF90am1heCgp
Lg0KPiANCj4gT3IsIGhlY2ssIGp1c3QgcmVtb3ZlIHRoZSBtb2RlbCBsaXN0LiBkZXZfd2Fybl9v
bmNlKCkgaWYgdGhlIHJkbXNyDQo+IGZhaWxzLiBXaG8gY2FyZXMgYWJvdXQgb25lIG1vcmUgbGlu
ZSBpbiBkbWVzZz8NCj4gDQo+IFdoeSBub3QgZG8gdGhlIGF0dGFjaGVkIHBhdGNoPw0KDQpUaGUg
cGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCg0KLXJ1aQ0K

