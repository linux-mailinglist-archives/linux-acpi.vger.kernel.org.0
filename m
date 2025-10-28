Return-Path: <linux-acpi+bounces-18268-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A90C12E08
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 05:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3126D4E2121
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 04:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25A9236A70;
	Tue, 28 Oct 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDsbr9T9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD5220F21
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761626933; cv=fail; b=uNA+ano/bYt+X/ahK00zpItKZYjRw3q2akWWKH/a3SPQgcV9colhCw6SO1urYtt0ZTbLD8tS8phqLLVXNpuy5DJy8PmJh5gIiqmhr6mztn6MGGW300QvCYDSZa0hhU3vm3dSHV4/W46s7STcGuZ9hnNYTk6OnR15Dc+K+fIAF9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761626933; c=relaxed/simple;
	bh=Qkmcs9EuSB3l1ZTyNM+Hb4NJmAs2Or67QXJ3hDcz4KY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jHMpeFI+BeoCyRVLy/MLCrtGrsnscuYWbNb456j507OUNB6KPcNmtvVqinypoL57iKiWOcI06ByNL9b+TxYGW2vh5ycIUbfhC3HpoeVlfYtJztfQeCTJOx0oCZ6ZZ6W6y1FJO+OpCH11am7uPfwG3ZhJXMvpab9KQopTYFRcsJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDsbr9T9; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761626932; x=1793162932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qkmcs9EuSB3l1ZTyNM+Hb4NJmAs2Or67QXJ3hDcz4KY=;
  b=CDsbr9T98z63Uyy2jj+ua5l1KquuVfHyKDD6ZkgyXe4g712pDrIvKZvx
   YUY9uEUKZY8pCSLSU7FMR3oml5dGWlLJ/Tya6gQ6zcfgRA1trp8CtTY5y
   kqVsfyQE94lDn9y6vsf1vbez46MzNsvWfxLqJZTsJ3eudOIXWfA06hvCa
   54ScA7d3leTZJBkPm0RSwt3QxDJ+DO7ELDVLe5Zu7Q1uNrcvZ4zltKwhW
   6NpKfMdjkABEeQN7OT4OIXx1fT5901eku1yUimj37e4bthuTCLiq5dnho
   sBnsEU+5MNrRvgwkN0hovw1p3cZp/B2JsYFOGTvy3Pcx0R1djrefDqiWf
   Q==;
X-CSE-ConnectionGUID: gXOxesTVQL29yF/K3QI8CA==
X-CSE-MsgGUID: pylobTEGT2akurAdGc4gnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63625864"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63625864"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 21:48:50 -0700
X-CSE-ConnectionGUID: vgXZ3iZsSLe0/8U5dlzb9w==
X-CSE-MsgGUID: 87a59DeVSrCsIWCHyxoXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184869229"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 21:48:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 21:48:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 21:48:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 21:48:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/KVKxVsFjQDA801ts5gOvAUOrF/nYGmUbtyQeYyAzhA+zIdb5dqKtWgdl1znRMdhHJ0imS/1yfy2quRJIg6heOLl9pWFt2Zj2iyriGH2LLCvsD1O1Y+Olx+/FTqDVbnQdok4WKWJh/VoMEiAsDW+Siglj2o9MQ+L1sUuuEmtjaXF9XIb2M34Kri5DAhR04upgh2XljQtZhBj/sTEcdkM5O8BV0Iki14wvgx2sJfVkW4ZRD3MvXlPaPVaCkS5ySHQptEPLZWH+//J2VFxQyv8DWijIhKQoKoOxoz9HApQ83BxFOrDQPrlkOXz0j6hXnUH280c0FqvOent4Q+s4fpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkmcs9EuSB3l1ZTyNM+Hb4NJmAs2Or67QXJ3hDcz4KY=;
 b=vGbITgoo/v45W3myD+//3MUXfBku4+rXND2CWzdK7jDMRCu4OrEibpCXGK+dwckmK0tJNbjw1BMHws5238iRCqy2pc3mLK/h+092eHRae5Ix869uWyVdbCpufECZBeU+keYLqjwGHfChmZzBZPdst1GsT2OH6UsUBqyOiYIDxTsApsCGgDqj+YmtfKBirYrs+PppBbjXaBW7sDyjTlT1O15njAbqyav/saXQGmpumqM/WQ6M3rDEzzwHZXZbLDStjVdgonXY4DWi7h4sq9TO56yjGoD/K+qIkQyRbyeykSKms003JfjoKL2y3KXTrfUrTvpDv4JsOiLiyI8TANMjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 04:48:47 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 04:48:47 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Thread-Topic: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Thread-Index: AQHcQ4qFb238oYUyRkqTePQ6oSATZLTOlUuAgAhu5WA=
Date: Tue, 28 Oct 2025 04:48:47 +0000
Message-ID: <LV3PR11MB87685DB538FDC1B2AA8F6BA0F5FDA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com>
 <aPk3URcrjx_KjkJ7@agluck-desk3>
In-Reply-To: <aPk3URcrjx_KjkJ7@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA1PR11MB6489:EE_
x-ms-office365-filtering-correlation-id: 2bdc38d9-7f13-4b66-fbcc-08de15dd4813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bnBxT2QxbjhzWHErMHdVNlg0R1Rxc28vZnk3Zkk2RWtKYmcxcXh3d09jdEZS?=
 =?utf-8?B?L2dWN2NvbUJxWno5VWRqVVRaeEJGUWpGMEZHNGNjZHUxemRyVXI2d1BQdDJT?=
 =?utf-8?B?MUJLQStpRnA2MW1IWC90NWdYcjlUeng0NHU0b3laa1FxMVErelNTTFdxUTh3?=
 =?utf-8?B?L0o2VHo5YUhSR1d3V3Y3Q09ESEhjd3ZEOGJJS1dyNjRMZUs4ZTI1UHJQdjB5?=
 =?utf-8?B?QVBLY0FVREVPbFFJWk9hbXBSQXlIQzFHdkVnaWJnYmJ3NE1HWWQydm1zYmpY?=
 =?utf-8?B?R2VMcXpSWWlGUkJ4V2h1amQ0RHlUcGMwTHVQUVdXM000em1Vc2JSYWhkU3or?=
 =?utf-8?B?cEFUL1hnaW5jRWlUTHZqTGE2UGlsaXdEOFZSTHIvTTNHMmNwRlpobTJydjgx?=
 =?utf-8?B?M05pMUZ0Vi9XVzF2RHFmK1NUd3ZSZzdJUmVHa0RzZXVHYVlpWG9ybktPSnd1?=
 =?utf-8?B?UFY3Q1JwWU1Ja1c0dXRCYUJmdjdNTVgwVmd0Ums1eVNDbHl4Y0tZQUhRQzVu?=
 =?utf-8?B?bjEwZ2tFRzJQdE1jdG5IbHplem9DRDhOS09ENi9mZkQ2dXZqOW9rbFFJZ0JL?=
 =?utf-8?B?eFplZlZ0SngveHVEMUhJSnpsNzJHUzcxNnh0Mm1MSlRHUk5Rc1Bub1dQYUV5?=
 =?utf-8?B?cUUvL3hMbStIWW13QUtiVm55dzZja1RWaHNkaXZrUjRKWGc1K3hDaW1vNkMr?=
 =?utf-8?B?SzAzZDlxTktLSXhaczBtdXVPR21xOVRHS2VBTTR0alQ5cGNOTkJiSnk4MUhL?=
 =?utf-8?B?SW5vQ3dWOUsxMm9NaEVmWW1PWlNLVzdKdEl1N2VTUzdxTEFNOWprN2VhSVND?=
 =?utf-8?B?OVF6b3Rac2hsMlhiUDk1K2syUU93VDN3ajI0TTFHZzI3UStXbnVIVVlxSHgz?=
 =?utf-8?B?SkcyeDJidjZBL1k2SWRqK1BUVDR5c3Fkb252V21nR2JReG54eFY3d1RidHBJ?=
 =?utf-8?B?VHg0U25rVTlSOVE4aG56WVBzVDhTMVl3K3RiZXlwTExGa1VZZGhRUDhxSVp2?=
 =?utf-8?B?WFkvN2lJeFZHcG1QWlA5S3hmbUhtd2tLOGZibHJENmJlUWNIczNHY1VEekRv?=
 =?utf-8?B?RTdzQWllcjdmTmF0ekdnR09QM1pOUUxQL1YzdWVMcDlwUkNWQ0JNNG9Tazdx?=
 =?utf-8?B?V0N3Q3p2d0tIVmtwckRuMU1VdDkwZjNvMFJyRDlpZDhVVkNINmt3TzZWekVk?=
 =?utf-8?B?bm9vbThWNDJ2NnlzY1N6UmtveGxGOUtWdzRoYUFnODJIYzlMZmVpOEU1RkZ3?=
 =?utf-8?B?TTlISWp5cm5MdHIrbXIvcUhjejE3OE5TaWlmWWw3cnhOSTB6NnludlAwQnVw?=
 =?utf-8?B?VjhUcGtmWlZqRlJ0MWF1NU9NS2VLcUZadVJoakFka3R1Y0RjWmNkMjM0ZVlu?=
 =?utf-8?B?d0VVR0F2c3RmcVlBOThISngvUFduQlRTdXBxRXI1ZHBHM21KaUxHM2R6ODVE?=
 =?utf-8?B?Y2FBMmxrV0k5T1FFTXc1NHNFSGp5REVvOG91czFDWDRqYzlvcGFLZk43eDRY?=
 =?utf-8?B?K0t3VUtUTnpyRHkzc1ZocTJxdldXSC94L054UHdpNk5IejlEeUI2emxNY1NS?=
 =?utf-8?B?akRoR1FwM3N0MWJnSDQ5bEE2YlpKVlV2dnB0OWlFemkwQUlZbCtHOGN4MHo0?=
 =?utf-8?B?M0YvWWJIT0h1eG5haHdiYkpHVkhqZHdDN0JIWWVsRXZZWExBbTB0dHBpeS96?=
 =?utf-8?B?MG0wZnc5MXNYVkdyQllrN09hS0g4Tzh4eHdkb3NHdnllSlRlTFVaVTZjcjB4?=
 =?utf-8?B?T1BCS25LVGRDWTZyUU1aVFV6b1B6MzFFbEMzMldpTE0reDRIWVlFZ1lFd1pV?=
 =?utf-8?B?cy9HVUg1dzRNSnNGQXBabWF0b25HcFBiTkVNYVYyNnhJa1Zoci9tQ21DZTla?=
 =?utf-8?B?NTQwU1Z0N3g5cHpPWjM4WUZ2YXVNdzZGcGtFcGd6cmJweXZmbDkvaHRKbmVZ?=
 =?utf-8?B?TVpubjFrZkVFdmoyNFZmaVY0L2hPRmRvNFBUb01EUDNaL2xxVDhxTG1TUWtV?=
 =?utf-8?B?UUZUOG9iTDJITUdXUGdoblFmcWJKTFd0SmdjbUJ2KytHam5GY3BFa1d1WU5J?=
 =?utf-8?Q?Biy/Wh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmRINU02Tzl2K0twL0U5NDNDUlljZHRXcVZnTFdrQWgyaytCR2pUbmtZNXdn?=
 =?utf-8?B?QStZL08wNFZjTkVMeUZuU0g3T0lXUUxuZFpGVGg3RWJCOWx5K2Q3bW5aVy9i?=
 =?utf-8?B?OVhQWDhDc2NtT2VnYm16dUJIdVBvT2RnbnE1WlpocTJQNXhuZzVCc1laR1Aw?=
 =?utf-8?B?Z1hZV3FiTjllUEZhY1dlejlUa20xeVVpc1NMM2JFZXdOMm05eHNxRUQrc2dW?=
 =?utf-8?B?NXcvTXgxNVpvZEVHTnhyWHNDc1pNM1oxa0U2NHpCZkZiT0VtUTRMSW9NOUZu?=
 =?utf-8?B?cnNnb3lsV1A2Z1drZ1dPOXh5Sy9zZXJEbWxnVkJ5a1k1UFlvWHAxckR1dkpM?=
 =?utf-8?B?OGYyT01OQ3R4YlhYUVZVR1Zxa1ZoR0wvNGxvV25BRlhyTHRJb054dnltb2pi?=
 =?utf-8?B?QlVaSndWU3hOeUdELzlqNnNKRGtoZGVGVDJuR3RRL0NiOEd1eUpjajVPcVEy?=
 =?utf-8?B?b3A0Zk1mZTNTbGxneG5YVWtETUhIbytxelVSQWhBWG50MVNIS3NrZDl0WXdP?=
 =?utf-8?B?QUN1VTMxMHJvNUFXZFVvZUQrQk5tMHJleGJrWnpNWUkyQWRvMGFFV1BramIr?=
 =?utf-8?B?M2hQUnJrRk9vcGF2N0tiSGFyRGJkRkcyZ0s2dURsMld0bnZXOHpUM1hCVGlZ?=
 =?utf-8?B?c3d3eHNLUUNwdEJHZ1l6eXVWNVFTekt4T0FiMkhvalFDaHhrQmZ0RkJBMjNi?=
 =?utf-8?B?Q3ZGSURZdEx1dUZRWDRtVTNvUDZRcUdFYkU0VkQyaTBFVTgvV0F4VTRMS3VE?=
 =?utf-8?B?WTRWVG5KREFNS0txT0RnK0JFTENTcFU2OUhScSthdHhwSnNPTXlEWU1jdXVU?=
 =?utf-8?B?WFdOOTdsQVNTTFJZcTl2SnRGaXErNzV0dGNYa2x0TFZmSkRJU0YxaXNid2pw?=
 =?utf-8?B?UWkvMlo3Q1REOUlrU2xCL0MvU3Mvd0dzTFdDbDZWSHFvZnZvZnFDUjNTOXJy?=
 =?utf-8?B?QWdDMTZXVnVPclZGakNqd3Q4UVJoblo1RWR2Vjh1c3dUOFNIKzMwSDJHZ3Qz?=
 =?utf-8?B?RlFhQ2xuUWl6VU16OHMyM1Y5WXROVXN5R3FWVGlNR1FpcHU4NEg3Z0hrWUVi?=
 =?utf-8?B?bHlLcEhZQzB0OGgyZE1OL0gwV0RZMUduU2hvN2dqMWlIZHFmV1FOYjdxQXFk?=
 =?utf-8?B?QThiQWUxRXEycGVjdnhsd2ZFZjlUWGwzeGQxTjdmdFErMy81WE80dGRsRElP?=
 =?utf-8?B?UVIybmxZZlZjQkR4Q3hYbHl3RHJIVnlEa1htZCthWk02V3IrMkY4emhEQld2?=
 =?utf-8?B?ZS9NZGNraGRXd05OUWFlbmZoYWZhMmdadjBadVBPQllaaTY2aW8rTllZM0sy?=
 =?utf-8?B?QzNKOHF3eVNOTGFyNXlMa0VDSnVwak1VZkpwaHVoY2tlbDZKcFNYY2dWNzhR?=
 =?utf-8?B?aWtzL0tVY2ZDTjZFWXJHTmc2eWZMRytwQjJjd0pNSWp6dzRzUitDUVQ0ajFP?=
 =?utf-8?B?S3Vsa0Vub0p0RzVwMy9ncG5oaDg4UE00MU56Znl4ZUI2VlRUeDZNMmxtbXRT?=
 =?utf-8?B?ZVNhZVA5eFhDY1VWRVlQZmNGUDk5UnR5dExscTR6ZHN3NUJsZmgvMkRwZjFp?=
 =?utf-8?B?OHFtTHU4K05SUTNXRHMyRVBrN1V4TlFDcEw5b1g2clYvdmgwS2UyYlRvL1Bu?=
 =?utf-8?B?Rk1rYmFwbklPYVpUcGl3eVZlNVcxSXo5VFpQejE0V1hUMkFaLzVaSFlJV0NB?=
 =?utf-8?B?Y0pKSXpSWU1jVWRUMHlsU2F6NVhqdElwd1FSSXFGK1pEeEVzb3VxMVB4ZW5R?=
 =?utf-8?B?d2JNRjhPRGsrTkw0MDJ5WkpSSE1EZHg4MUdpcnhzWUExUUlES1BTMzh2Q1Vy?=
 =?utf-8?B?bGNvcWxqaVpZWTZVVWd0cTlLeXlHVjQ1Q3pOeXZkK0xrbEJqMzVYYlU5ejV5?=
 =?utf-8?B?N0FmOTNSZ0FySFByQm1vYVZDaFVFZHliYW0zTWlManRTUFlmMGhYWGJaU2t1?=
 =?utf-8?B?TzFGempzWisyM0N4NjhFUU8zNUQ3UGdrYUh1THM2emM2SGZSV1lDcHVxN2pj?=
 =?utf-8?B?clI1YkkxS3RDTndHNGh2bzNHZEgxdWlNZlFHbThNSGM1Z2FBZlZXV0tzcjQr?=
 =?utf-8?B?MXVhK3FNQ2kwRW1EYVFmYVhFRlV1TTV6UHZxS2RjZFFCdE5PM0RWd0hJNW5w?=
 =?utf-8?B?Wlo5M2NxcHh2RlFEWEJvUk1vZnludW91TGdaMFJMVFhrY2U4bDVQb1dKT3ZO?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdc38d9-7f13-4b66-fbcc-08de15dd4813
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 04:48:47.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHyCfd1zrk1hWn3JtOpOg1Yvlj+i4YksgadqO3qDCNglzmaNBwbgPIOxAToutUpYFh3yVnyoJjk5TPUFHu2yMflnUCkZHaBfLJwSLswXy0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6489
X-OriginatorOrg: intel.com

biBXZWQsIE9jdCAyMiwgMjAyNSBhdCAwOTozMToyOVBNICswMjAwLCBSYWZhZWwgSi4gV3lzb2Nr
aSB3cm90ZToNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFrb2JqKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGNsZWFudXA7DQo+IA0KPiBXaHkgdGVybWluYXRlIHRoaXM/ICBXaHkgbm90IGNvbnRp
bnVlPw0KDQo+IEkgZGlkbid0IHJlYWxpemUgdGhhdCBrb2JqZWN0X2NyZWF0ZV9hbmRfYWRkKCkg
bWFkZSBpdHMgb3duIGNvcHkgb2YgdGhlICJuYW1lIiBwYXJhbWV0ZXIuICBNYXliZSB0aGUgY29k
ZSBzaG91bGQgYXZvaWQgdGhlIGFsbG9jL2ZyZWUgYnkgbWFraW5nICJuYW1lIiBhIGxvY2FsIHZh
cmlhYmxlPw0KPiANCj4gCWNoYXIgbmFtZVsxNl0gPSAicmFuZ2VYWFhYWFhYWFhYIjsNCj4gDQo+
IAlzcHJpbnRmKCZuYW1lWzVdLCAiJWQiLCBpKTsNCg0KPiBUZXJtaW5hdGluZyBoZXJlIChhbmQg
YmVsb3cpIHdpbGwgZ28gdG8gS2F1c2hsZW5kcmEncyBjbGVhbnVwIGNvZGUgdG8gcmVtb3ZlIGFs
bCB0aGUgcmFuZ2VzLiBNYXliZSB0aGlzIGlzIGJldHRlciB0aGFuIGhhdmluZyBzb21lIHJhbmRv
bSBzdWJzZXQgb2YgZmlsZXMgYXBwZWFyIChiYXNlZCBvbiB3aGljaCBhbGxvY2F0aW9ucyBzdWNj
ZWVkZWQvZmFpbGVkKT8NCg0KVG9ueSBpcyBleGFjdGx5IHJpZ2h0IGhlcmUuIEkgYmVsaWV2ZSB0
aGUgY3VycmVudCBhcHByb2FjaCBpcyBtb3JlIGFwcHJvcHJpYXRlIA0KSGVyZS4NCg0KUmVnYXJk
aW5nIFRvbnkncyBzdWdnZXN0aW9uIGFib3V0IHRoZSBsb2NhbCBidWZmZXIgLSB0aGF0J3MgYSB2
YWxpZCBvcHRpbWl6YXRpb24sIA0KYnV0IEknZCBwcmVmZXIgdG8ga2VlcCB0aGUgY3VycmVudCBh
cHByb2FjaCBmb3IgY2xhcml0eS4gVGhlIGthc3ByaW50Zi9rZnJlZSANCnBhdHRlcm4gaXMgbW9y
ZSBleHBsaWNpdCBhYm91dCBtZW1vcnkgbWFuYWdlbWVudCBpbiBrZXJuZWwuDQoNClRoZSBjbGVh
bnVwIHBhdGggZW5zdXJlcyB3ZSBtYWludGFpbiBzeXN0ZW0gY29uc2lzdGVuY3kgLSBlaXRoZXIg
d2Ugc3VjY2Vzc2Z1bGx5IA0KY3JlYXRlIHRoZSBjb21wbGV0ZSBpbnRlcmZhY2UsIG9yIHdlIGxl
YXZlIHRoZSBzeXN0ZW0gaW4gYSBjbGVhbiBzdGF0ZSB3aXRoIG5vIA0KcGFydGlhbCBhcnRpZmFj
dHMuDQoNClRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIHJldmlldyENCg0KS2F1c2hsZW5kcmENCg==

