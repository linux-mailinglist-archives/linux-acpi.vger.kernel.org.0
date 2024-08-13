Return-Path: <linux-acpi+bounces-7545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AE1950240
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59547B220B0
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01A018A6C0;
	Tue, 13 Aug 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROhD+TdC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884BE18453A;
	Tue, 13 Aug 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544268; cv=fail; b=LFqZhQWa/ryCpqYUW9NWRmzLz5bhjij7SeG+NHr3wfriLwb9faE6uWSPI8nnjOzB+4PtBJbsPXYvLkWb3XicnfpHcBvdoICOLzwHmAznx6JjfFjVSEOXCIWcBRQpTVH9ryWOReSKB3ySoVZ2xLiC7n/6ytBZBrBbZ+W98F/n4qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544268; c=relaxed/simple;
	bh=Nf/IVB2KTIH6dqDIWvcnuhy5GZCvpSi6a8P/Xva4H0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WeXRLUEyrftPORr5abyPF7ThG/TVr44PTeEEcrv41QrVzXz6fa8lEvh0TsKUznYnO8cCsd/oFGxF/D+v0QSK+kdQwhG2en4WCjiLD2dO2igzGAHokRERNrouEFrmyYcgGl7DCIy/YAZbeO90MQVJdxD9U3uajlZkJvtRVMOn8zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROhD+TdC; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723544267; x=1755080267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nf/IVB2KTIH6dqDIWvcnuhy5GZCvpSi6a8P/Xva4H0A=;
  b=ROhD+TdCIPTSAY5zLHLoXd/4RfeaAmNLt/tQxdjMHAN5LZo7CgQiUTts
   QgpyQbntAZW2OV4nZbip8Neg9Y3HaQSP919e0PTLxy/bFB2vtr8Ghe32n
   WDbli7+QuH+qunNPZa5buvrfLt22livz4dueZ6CjVfFXcmoMYI1rP1ic8
   wV6gphBS39OAS/kErdvpdCxM3uqn95ORALb1dHdvpAkZ+AmChCHS3gUQQ
   BXaYkInt6nF6jfEuImzmbLsa3HyzYjexKpxPDlUXTBEza/9CVEs32V3St
   4DTDqm/ugg347m/gNzuw2OMgAJ7AihOB8/cKHKgAqGE3CGRo6XGZMYZZH
   Q==;
X-CSE-ConnectionGUID: bSObkS3LSx2HNNqPgHYCdw==
X-CSE-MsgGUID: P6Uek/rcSWGD9otON45HLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39144952"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="39144952"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:17:46 -0700
X-CSE-ConnectionGUID: UsYp2QUsTHSgWYHNZOtPog==
X-CSE-MsgGUID: +e2Id3ICRfCar8QQlF6hKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63010378"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 03:17:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 03:17:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 03:17:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 03:17:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja2YfXucNz3CnDo27urFFAQh7sTyS/inzMj/iQTRGSgKRN6jCtzGL67yPD4489so8173q74EsT3d2XM7u4lBA46h026SQe6S9mZqKGYNLMikB4goYML/0Q2QSRljQAQrdTmcl+awDb40VQzOHplycEv/8wXVAZxrQvRWGQ9sIl2ffg7CCkKB7WdBYXpSTrLmyrq7dS0Aqaxr1PWnLHWSQN8vlEBluWo7m29+xfTgIVqX/UjWKZx3wKp2IY9uLo2FucQjCZeWHOQjgP02Knqh1OgYDRvh8kcut5+oU4T6UnrH/kaiXNdfgGr3l+gKmcywIgPpkfGA8p2Bukb2+Sv4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf/IVB2KTIH6dqDIWvcnuhy5GZCvpSi6a8P/Xva4H0A=;
 b=RWJQtpCK0bcmLRQSo2AwlQ5Yb6RI2JnqhUbk6J4SUE+c0FbElnkW1J6YGPf8rhXm1U8HM7xN6zBy9xpz++BlkCDs9mAoej81ykQPLRi9Tm/FuOxWQpt/bsc4mKKNRFHU9jSJgTaeCKagJPiF4xNz0ae/arcKWOYJ1sggA+bWFWjUZ3yIW7Qa9khn8BTqwPZ5w+JV2pzhL8Oe3zofxi3KzMeFaod0hRSAfUOy2TUqwRyFePJlvpX26rYlB3tOv8z7sVkyaTuOzGky4MuMJAnRGkmOz0TzMubW7vZqA/ouu2DZcWHPS/KlfaP+sv2BW/Ei6Rk7k9S5xCzTlPv8V0huXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Tue, 13 Aug
 2024 10:17:41 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%4]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 10:17:41 +0000
From: "King, Colin" <colin.king@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>
Subject: RE: [PATCH][next] ACPI: align slab for improved memory performance
Thread-Topic: [PATCH][next] ACPI: align slab for improved memory performance
Thread-Index: AQHa6eFfvxWyREIekUC5nF8jxVinqrIk/2sAgAAApCA=
Date: Tue, 13 Aug 2024 10:17:41 +0000
Message-ID: <CY8PR11MB77474CEA74FB6A572D9856D28D862@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20240808222138.51-1-colin.king@intel.com>
 <aaf516f8-eb36-4693-a002-a972d6f77b92@molgen.mpg.de>
In-Reply-To: <aaf516f8-eb36-4693-a002-a972d6f77b92@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|IA1PR11MB6396:EE_
x-ms-office365-filtering-correlation-id: 19afdea1-f5ac-43a5-a1c6-08dcbb812a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SngxU3MzaVZnUDFESENwOW8wSG1vMEpvUG5BVjVVMTkwbjZVd0JZbGJ0WW10?=
 =?utf-8?B?aE9kVG5pem1KMnZocVJiVWFCMTBOb1o4U0lwdFJFNUdjaWVBdXNLdzdUV1J3?=
 =?utf-8?B?S1pnTnJONkhlSG9qUWxHaXFLSHI2QlB0TlY4RnJhcmFCcVd6UG03Uk5oZURC?=
 =?utf-8?B?bWF3NjNtV3JxZmlZMGNUZzlUNjFyVjlUTndNamkxazc1eDZ4dmlMUExpbno2?=
 =?utf-8?B?MXNiMzFqK05QODFtSERBbjNIeTkzelgyeERVWGhESXlGd29oUDdTdlY2Q1JG?=
 =?utf-8?B?UU11VW1mWmpXVmdYTjZhVHVsSGJaWDQ5cGlzcUZHdWZDV2MzRUxSdWZ4WmFP?=
 =?utf-8?B?T0ZWT2Q3L2ExdmNmYTJCRXJUQ3YrS1UvUDYyWkpBVGMyRjNLT0o0eVJVd1J4?=
 =?utf-8?B?aHdZQ2ZyVElTNTQxcE9GWGFSeVhvNHQ2WW53UnhqTHRkbHdxRDdRVjBuaTJ1?=
 =?utf-8?B?a0VGWmdoYlRyZ3l5dkREY3BRamlEQkNNOERwd0NlLzZNNUljMXJKTUx1OGtO?=
 =?utf-8?B?WnFYZFFVd3Y1ODdod29vclhvNFlRVll1WE9DWXEvcVFraXdOWGI1dnFWN3lr?=
 =?utf-8?B?bStvNkN2cUl1c2lBNzBoRzBURlZmei9pK01FMGtjSEJnaVhySmVacCt3NTJq?=
 =?utf-8?B?MEtwMTgyVjVTRXJqQjVEbnVJcDhKVVpKNitqVmZGZWJhVCtOaEpHYmFmbHJ2?=
 =?utf-8?B?WlRrTVM1KzJRTGMyNC92VXY5Nlc0c2JGUUtxWkkwN240aWhrMzIvOGdhVHEv?=
 =?utf-8?B?ZHZJTnRoZ0s4Ty9zMXIyVk1BNWMyWG1lN3NCd2loVEhjYW9wY0xFempCODIy?=
 =?utf-8?B?Qnp2a1dCN2xJdHBiQ2YycEJCN1BRTTk1SzQ0MlE1RUlMRlhmb3VtcGxZTE0y?=
 =?utf-8?B?aGlIODl0RWxCd0k1QkI2WjlOaTV4UjIvR2RvUDU3eVlJUnBUWlU1bWJUcWZF?=
 =?utf-8?B?K01hTGN5Tnl5dkZ2ODMwOXEydExhZVZQMGcvN09VZWRZb0FWOERiRHlmdDIv?=
 =?utf-8?B?Vi80b01mY0I1WHl3dFdJc0YyVmMzVHI5K1RLZ3JMNzROQXk0K0tKdFVXVzh6?=
 =?utf-8?B?dzN4eFdwZFBzcFowdzBBUGFuZ050Q0lVZHphTGpFWjB2NE1SWjk3Qm4zam0w?=
 =?utf-8?B?ZDF4ZXgwZkNFWStIdWkvYnZyWUhTWFBNVjBnSm13WDYvb1BnbHIxMll1eFhE?=
 =?utf-8?B?blAyMWNqdHhMeFhidTQ0OWwxOWt0dGQxTUVJWXBPQ1YzaVZCUjhIY2JYcy96?=
 =?utf-8?B?L2QrMzQ2OWx3ODRaa1RRWVIydnRZR2I0SnJvY2I0RFdpUE9MZWFRVEMwaXNy?=
 =?utf-8?B?c0ZMVEZSZnF2NGlUQ2RibFNEUUJIcGlRWURzTndpNlVuUGFSYWY5Z3dTdHNq?=
 =?utf-8?B?K1BsaE1nakUwM0dVL01jdnI5QkF4bVJ1am5pM2JqdG9BbTZhUDJyeXh2UGtR?=
 =?utf-8?B?c0djZHluc3lyazBjbTlkYnlSeVJmUVFwa3gySTNhWHcyRHI1N1F5L25xdFhU?=
 =?utf-8?B?Qkp3cytQZncxaTM4KyszWXBydWYxK0lEVHNxbG9hTVBJMS80RG9JTC9UV2xC?=
 =?utf-8?B?cm43QlNCS1h4NTAvVERCQngwby9hcEZNbUh5ZHQwSHlmYlhRQ3pYWlFpcUpj?=
 =?utf-8?B?QUdSS3ltVDN3T0kwVFNwcFpyNmE1T0pzQ2s3TkQxOXgvR3pTaWxFR0pyeEwy?=
 =?utf-8?B?SGJDVFlyUUR3cDZkVlNGNm9TVGlTcFRJTU50MTlWVndWRVRENGh4WFJNWEpp?=
 =?utf-8?B?YlFXd3VTTS9ibUJESDdheDNOb2lBYzNzY2pGekNUdFQ4YnJMZmQ3amNNT3dG?=
 =?utf-8?B?N05BeFBXdWNockxTVi83Yy9zSUpGS2ltaFlQMTZIdW5jRmlma1BlMU82T1Vt?=
 =?utf-8?B?NFVUbmdZL0VXN2Q0Z2l0SmZhSXhReC85V0pQZndvZmtTU0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWdWZ2l0QW93YW91VWF2amk5d2g5dmdjaWVOU1l5dExQVGZzWkgxdVNCTDVp?=
 =?utf-8?B?U09EbzByaTEzOGkrMTcyc1QzZ29KMWpvd0F6dkx1MWoxTWpNNTBXUWJEbXlU?=
 =?utf-8?B?M0gvUlpvUndFUUVkSGN6NnBxNTlnM2greFZZZ2RCTEUzaVFGN1lFUjBaUlFF?=
 =?utf-8?B?amt3akIxc2cxQW1ONUpleFpkS01ESWpCUTdTRmJKZlI5NjNPbmtpUkVYVmw5?=
 =?utf-8?B?NktFcGhEdEJVNjU0TTlRSllIT3N5VmU3bFU0WlBWeUJYUHRySnE4dG5WSDZW?=
 =?utf-8?B?NmZJQW9TMHFVYjdjUWt4TmIzMk1DWEJraHdrTXp3SWtocktpcjNLeWhYaDVC?=
 =?utf-8?B?Z21qQzZyeUtjRWJuM052MU9SS0p4SUxVcmU5eW1ubEQvVEZOOTZXYzhiVHBT?=
 =?utf-8?B?dTRQMFQyUjEvL1J1Qm1lNml4Ky9FVXc3bVQvUHc4NEJSSWdCY0IxaGFsSTBM?=
 =?utf-8?B?ZGFITy92a1VxZWIvS0xIaVhJUngrRGJGL3BHdDQwdGVWdXBIbGEwb0hRT3p3?=
 =?utf-8?B?NnBrZGlBNTFqamJzMXdRZEhKUmJ3Z2szdzhRR3k1YVFuaC8rL1U4d3k3WEUx?=
 =?utf-8?B?S05GdTd6RzZ0SVBVZzVZR1FjTW00MVpqNUw5NExBaTBIc2J5YVpyMkF0bi9z?=
 =?utf-8?B?VnEwQ0xkUjcvREZGeWZJZThuWkRITjAvNUQ1enZ5T0lHUFo1TlhPSVBLWHVI?=
 =?utf-8?B?QXdyVFg3ZHFVY0plZGRrMDliZWN0K2ozOE5oNndRSUJTMGNoN1NJeC8yOE1j?=
 =?utf-8?B?SDFHYTJncDRIV3AvbXZBcU9BZnFYcnhGMCtLcUVQV3J3Q0d5NEd5enljUUls?=
 =?utf-8?B?QnZHMVVYV1E2c2VVWitFK1h4aElTcWVveG9IQzcwTkJaTlZMQlROVW5tejgx?=
 =?utf-8?B?ZEc2M2huV1kwV1Vtb1V3WmQwT01VeHpmWHhUT3FxM29Ubzg5TDNBUGY1Mkx0?=
 =?utf-8?B?U3Zzc0I4aCtTdUpwL1dzR2wwTUpVUzJDTEpaaXJ1Uy9BZlQzcnZCQnZBc01i?=
 =?utf-8?B?ZGVpeXppaElpbEwrc0o1ak9sbmpaVDRpRWlRZ1BvNndmZmJNSTlhZHRUdFlF?=
 =?utf-8?B?ZnVNY25tQWY1ZFlIdERXRlQwSzNTaEZhencreGI4QytkMktVYzJLYUYyWkFx?=
 =?utf-8?B?Wjh6VzFxYW9kU2pyOXc2TFhaQUpPdEF0VkxSUCtGUE56SGViOHl3dzBpaVJJ?=
 =?utf-8?B?VFR1TVdlZnY3bm9hRm1jQ0J2TkpzdWJmOXRPRDdvaXFMWkFkR3NEeXRJbXl2?=
 =?utf-8?B?emlxSVFIS0wzc2U4bnZJQUtFN1ZXdktvajdVYXRMRmlVN1pUL0VNWmxMRWgr?=
 =?utf-8?B?b2xEVjYwaG52ZTlEa3IzWi85a1I5Q3Q0OUhvM3NNc3h3NzNWOGZycDJFc1JF?=
 =?utf-8?B?VmFOVS9pQmZ2M0YwVnJYRUdqV2N4Y3ZFSmNyUG5hVVhRY0tSZVJhZWdZOE5N?=
 =?utf-8?B?VVRZZFJ3cW1PdGJJTVRRbUZzR2hQdEkydDZXb0I5ZHBEa3ByR2dqUHZnZXNM?=
 =?utf-8?B?NFdGaURJUkpYUitYWEdma0liVDVzdjFWcDJ3eE1KWm02amM3VGpnUjN2Tmk5?=
 =?utf-8?B?LzdBbk9YMktMLy96TWlybFV4WWtrWWk4M2JwTFVsUk5rNHVsYnJzUmx4OFcw?=
 =?utf-8?B?THBRdGdzeGNWOG5VRzFndUI5MHZvMmhGcEQ0S2RwM0JNeEZUV3A3Ly9heE1m?=
 =?utf-8?B?T0xOTXY3M2h4YTJmVnEvTDU4MCsyYkJhMHl3Y1luSHkxeGFSbkRRamxHT0ZQ?=
 =?utf-8?B?SGd1UktYTWprZUJDNXEyQ2ZUYTMzUEhucHU0RVFaaFNuNFU3M1lwYURuWkhU?=
 =?utf-8?B?VlpFVFBRT1hNbnRMRVBET2JmRGsrRzdCdzJVcmtnRERoWHBTaE1pQVpncncy?=
 =?utf-8?B?WHo2T2hqL0E0a1ljWVZjQkJ3RVJNVWhMT2J1REQvdUVsRXNnYUlYbHoyMjdM?=
 =?utf-8?B?YW90VjBBb0wweWVzY1VBdzBZVGZyRENnaHVRdTNQM3lkL3hIb3Q4alk3ck8w?=
 =?utf-8?B?REh6V2ZJRG9TL0swTkxDVndpZS9nQTRoSUhoUXNyTkZoOEFHQTFjZ2dwT01Q?=
 =?utf-8?B?OGlDZnIzaVNnelhYc1FSRXYzSjNmSGFXM1pWWEsrT1d6elhiVGN6SU52S3do?=
 =?utf-8?Q?m5SlFme/vaXznKfH98RDUAlh/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19afdea1-f5ac-43a5-a1c6-08dcbb812a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 10:17:41.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrrUE7RsvoMFtBmquZhzV+rI9nI1cXR7mOiXCK07qKCKSZek1cKsqkhqMfy6f/2XFhDgtOyivUdMqWd+pZmbcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6396
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgdGVzdGluZy4gSG93IG1hbnkgaXRlcmF0aW9ucyBv
ZiB0aGUgdGVzdCBkaWQgeW91IGRvPyAgSSByYW4gbWluZSAxMDAgdGltZXMgd2l0aCBlYWNoIGNv
bmZpZyB0byBnZXQgYSByZWxpYWJsZSBzZXQgb2YgbWVhc3VyZW1lbnRzLg0KDQpDb2xpbg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9s
Z2VuLm1wZy5kZT4gDQpTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTMsIDIwMjQgMTE6MTUgQU0NClRv
OiBLaW5nLCBDb2xpbiA8Y29saW4ua2luZ0BpbnRlbC5jb20+DQpDYzogUmFmYWVsIEogLiBXeXNv
Y2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgbGlu
dXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFN0
ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF1b
bmV4dF0gQUNQSTogYWxpZ24gc2xhYiBmb3IgaW1wcm92ZWQgbWVtb3J5IHBlcmZvcm1hbmNlDQoN
CkRlYXIgQ29saW4sDQoNCg0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoIGFuZCB3b3JraW5nIG9u
IGRlY3JlYXNpbmcgdGhlIGJvb3QgdGltZS4NCg0KDQpBbSAwOS4wOC4yNCB1bSAwMDoyMSBzY2hy
aWViIENvbGluIElhbiBLaW5nOg0KPiBFbmFibGluZyBTTEFCX0hXQ0FDSEVfQUxJR04gZm9yIHRo
ZSBBQ1BJIG9iamVjdCBjYWNoZXMgaW1wcm92ZXMgYm9vdCANCj4gc3BlZWQgaW4gdGhlIEFDUElD
QSBjb3JlIGZvciBvYmplY3QgYWxsb2NhdGlvbiBhbmQgZnJlZSdpbmcgZXNwZWNpYWxseSANCj4g
aW4gdGhlIEFNTCBwYXJzaW5nIGFuZCBleGVjdXRpb24gcGhhc2VzIGluIGJvb3QuIFRlc3Rpbmcg
d2l0aCAxMDAgDQo+IGJvb3RzIHNob3dzIGFuIGF2ZXJhZ2UgYm9vdCBzYXZpbmcgaW4gYWNwaV9p
bml0IG9mIH4zNTAwMCB1c2VjcyANCj4gY29tcGFyZWQgdG8gdGhlIHVuYWxpZ25lZCB2ZXJzaW9u
LiBNb3N0IG9mIHRoZSBBQ1BJIG9iamVjdHMgYmVpbmcgDQo+IGFsbG9jYXRlZCBhbmQgZnJlZSdk
IGFyZSBvZiB2ZXJ5IHNob3J0IGxpZmUgdGltZXMgaW4gdGhlIGNyaXRpY2FsIA0KPiBwYXRocyBm
b3IgcGFyc2luZyBhbmQgZXhlY3V0aW9uLCBzbyB0aGUgZXh0cmEgbWVtb3J5IHVzZWQgZm9yIA0K
PiBhbGlnbm1lbnQgaXNuJ3QgdG9vIG9uZXJvdXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xp
biBJYW4gS2luZyA8Y29saW4ua2luZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvYWNw
aS9vc2wuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvb3NsLmMgYi9kcml2ZXJz
L2FjcGkvb3NsLmMgaW5kZXggDQo+IDcwYWYzZmJiZWJlNS4uZGFiM2Q1MDg5NjM1IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2FjcGkvb3NsLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL29zbC5jDQo+
IEBAIC0xNTQ5LDcgKzE1NDksNyBAQCB2b2lkIGFjcGlfb3NfcmVsZWFzZV9sb2NrKGFjcGlfc3Bp
bmxvY2sgbG9ja3AsIGFjcGlfY3B1X2ZsYWdzIG5vdF91c2VkKQ0KPiAgIGFjcGlfc3RhdHVzDQo+
ICAgYWNwaV9vc19jcmVhdGVfY2FjaGUoY2hhciAqbmFtZSwgdTE2IHNpemUsIHUxNiBkZXB0aCwg
YWNwaV9jYWNoZV90ICoqY2FjaGUpDQo+ICAgew0KPiAtCSpjYWNoZSA9IGttZW1fY2FjaGVfY3Jl
YXRlKG5hbWUsIHNpemUsIDAsIDAsIE5VTEwpOw0KPiArCSpjYWNoZSA9IGttZW1fY2FjaGVfY3Jl
YXRlKG5hbWUsIHNpemUsIDAsIFNMQUJfSFdDQUNIRV9BTElHTiwgTlVMTCk7DQo+ICAgCWlmICgq
Y2FjaGUgPT0gTlVMTCkNCj4gICAJCXJldHVybiBBRV9FUlJPUjsNCj4gICAJZWxzZQ0KDQpUaGFu
ayB5b3UgZm9yIHRoZSBwYXRjaC4gSSB0ZXN0ZWQgaXQgb24gdGhlIEludGVsIEthYnkgTGFrZSBs
YXB0b3AgRGVsbCBYUFMgMTMgOTM2MCwgYW5kIHVuZm9ydHVuYXRlbHksIG15IHJlc3VsdHMgYXJl
IGRpZmZlcmVudCBmcm9tIHlvdXJzLCB0aGF0IHRoZSB0aW1lIGZvciBgYWNwaV9pbml0KClgICpp
bipjcmVhc2VkIGJ5IDIwIG1zLg0KDQpXaXRob3V0IHlvdXIgcGF0Y2g6DQoNCiAgICAgWyAgICAw
LjIwMTQ3MV0gaW5pdGNhbGwgYWNwaV9pbml0KzB4MC8weDU5MCByZXR1cm5lZCAwIGFmdGVyIDEx
MjAwMCANCnVzZWNzDQoNCldpdGggeW91ciBwYXRjaDoNCg0KICAgICBbICAgIDAuMjIyMzIxXSBp
bml0Y2FsbCBhY3BpX2luaXQrMHgwLzB4NTkwIHJldHVybmVkIDAgYWZ0ZXIgMTMyMDAwIA0KdXNl
Y3MNCg0KUGxlYXNlIGZpbmQgdGhlIGxvZ3MgYXR0YWNoZWQuDQoNCg0KS2luZCByZWdhcmRzLA0K
DQpQYXVsDQo=

