Return-Path: <linux-acpi+bounces-7714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3E4958625
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519FA285623
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E603A18E740;
	Tue, 20 Aug 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUeIyvur"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034914B075;
	Tue, 20 Aug 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154755; cv=fail; b=Ca1nVJ4as04yKySPm/1EUzBHnN3wzOsU9/i1zMprwE7mpouLsYAS+qphcjpcymhuQ7ESQM+xVGAyLWffoZuaG+7EpnyUbdu0/lnrS/h8P4axgduy/IIsQHOVp/jpooflXaHaWbH0OhYVNA5D8GBcWGnWmbwn8Z3dByUGMpjFsFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154755; c=relaxed/simple;
	bh=D0eNI8Rvb1PyJyThS6bePUU9tpMZvxVRZ+1tcm7/h8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qW8GcAfRAC7xuR4UHnV2WgKQPRbS5pj2Oyz+T5vwc5QQ5p5OvRKg3bMyxMGfjmWuUgk8mayOGEMdmxpHsitdOd96ZhmmXoKed0oaNCe3nxmxuLl0BmbCupcoCg+2+D3JacleoiuxwXoHIGsPjU5SJIaT2BrJDrdJr1v6psovmZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUeIyvur; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724154755; x=1755690755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D0eNI8Rvb1PyJyThS6bePUU9tpMZvxVRZ+1tcm7/h8Y=;
  b=KUeIyvur53yBrcw7/sIQBWXAPWYRPBUA1nX+Nzk6Hz+aqGpMKF1edGI6
   +NJAQH8mHQ+flfZ/3NPqH3JIk772m/7bNyLGsPjBLdb5BPF5bTJds2pCG
   awsjZAstOc/v1WCKk0gFTgqZv1j5CwyVrtLWAdpVUPCOExRtB/Ne/lpkF
   muj7OwdGfLPFwf9qfAyOYN06sWZis5x2IxLeHvr3j1lLh4pnZVFHyokli
   D2Kl+xfYtrdOUlF6CxxRmBXjBBwvKNKhOc+rDnLfa+RmyB2c42RSecRaU
   bFbgMGpHuksMIj2i5H3Ol79+0OIlsj5s4DD/64PzuNhF/pSzRw+ig0/Jn
   w==;
X-CSE-ConnectionGUID: 8n8hP2DKQhaUq851A1Q4Ag==
X-CSE-MsgGUID: 3vj5QisDRHGZlYQX1urduA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22583997"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22583997"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:52:34 -0700
X-CSE-ConnectionGUID: chF6Vv2+SXikG4maFbMGkw==
X-CSE-MsgGUID: 4J6Xtuc0SYGyuAy2ULeC1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="64893748"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 04:52:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:52:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:52:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 04:52:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 04:52:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNWEMiE6oC8GRVP0kmfa0kt249zNd+7hnT3tkloRqKKwtJl/+vEqA8PuApukjwb4ukU8GRnaQuNpdvCvwYdchqSDBBma2qiJ/urmqHrHuOhq8tiTWnY2G6gUK7RTltkd83huwHNnrsn8XHTAmZnLYrP8VNtj3mJJgQUvAXFA++qZJOzTkFih3SbgD4PaHK6fUGCz0QXXRmTa4zHJ8kN3/fgwz35gtBpD7d4QB6ROXHT5UutgJ5YiRPXYN+/i49EJ16eUG6noa8Nn9ff8KxgiJ5x4Vmy2AShe9c+XA3XgT5Kmh+0uqzU6L9xhxJT8G18F3d6fgcAkcdL5ViClyJfrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0eNI8Rvb1PyJyThS6bePUU9tpMZvxVRZ+1tcm7/h8Y=;
 b=jt2d/gGnMu9+qD/cM5RIsCy4/h5hkhwZljOjckeFMRsn2TSM8jLxhF+VXz6bil8VsBEuY/qC2NvOTUy/FvxEbE5869yKxRA7hlKheD425F13uzUyfaBBArEt5DVfK0LViUSfZ5Jw4zEGeQLJ/HE2IlyRjLl2r8IQOxHEK6nZntFtkWtq+coZooKmRxlSgNmqy+nv9JZvUWP0hhKr/ypOOpJ4l5wQArj5rWb3Ho0uzhzbMIxiCcP6TlqVUKQou3prJJXTHTDxLNYsF34fGuM61nNdvCCU8dNH5rwslvZM4ndDIFBTMZnEmAuff+K82KGW9JffFQciV1yB9vDowhXKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 11:52:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 11:52:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "ardb@kernel.org" <ardb@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "bhe@redhat.com" <bhe@redhat.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Topic: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Index: AQHa8gaplxIQHt1FDUe8BCwalB/rOLIuboSAgAALTQCAAAvBAIABaZEAgAAO1YCAAAJPgIAACoaA
Date: Tue, 20 Aug 2024 11:52:29 +0000
Message-ID: <4f9cd14415f1c01c937f6b3bdd56ba0243d47f94.camel@intel.com>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
	 <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
	 <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>
	 <hr7kym77uhbtj32eymcdp5mcbpid7euoiiszhx6yhkrbw5riag@lcozqjayilbo>
	 <d97a17a53cb7550134ec521e3d22177d6a6ad05e.camel@intel.com>
	 <jzqh5j4w4w23xuigqj5bggbmx2hgte4u5tvbss3hqi3vjeodhl@rnmirwt6biol>
	 <6464ab0f43f51f4526666f8924921262e8144027.camel@intel.com>
	 <hxw67ecixuf5mkj3ucwhsobvd6dyjhwjo32fu4jiwoxgrgk7rd@dklvwlnrewil>
In-Reply-To: <hxw67ecixuf5mkj3ucwhsobvd6dyjhwjo32fu4jiwoxgrgk7rd@dklvwlnrewil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL3PR11MB6363:EE_
x-ms-office365-filtering-correlation-id: 6435535c-3014-4d77-ce39-08dcc10e91c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bFMyNTUrRjZmamMzSUx0aW5LZTBJZ0dmcXdVcVFmVUdNVDF5TnlTOW9iVW9W?=
 =?utf-8?B?UVVpT2R4TXJqL0FUc0c2MkZ1SWw1R2ZUTG42ZGM2bWNKSGRmNGRSeHYyM3Rh?=
 =?utf-8?B?cmFsVVIxeElqblFEaEM0Nll5ZlJ6Y0w4NC91K0NIVlZ1TjJjeTJtSUdaa2pP?=
 =?utf-8?B?NTdQcXRUemlVOHluenNoMkxOVkVCMVpib2l3SWI2NXBiV2Nmb0FGWUY0YmhV?=
 =?utf-8?B?S050TVNGSXZSK05FUExHRVhHS05GUmFCcmM5cGxWSElENFhEL0dkaDRNYjBx?=
 =?utf-8?B?emVLTHdQTDllZ1ZDeUxYNk03aVR3MERId1h3MmtWZzFwSFQ4MEFrSVFFVkt1?=
 =?utf-8?B?WDBqdWswQVA3b3p4OW0zTXN4VjdJd2cxdDdrRFVrVmdSNWRpMTZpT1dab040?=
 =?utf-8?B?TWFqQk1GM2JJL0U5b3lMdUhHYk45bHBHZmtpYXFLUXRaaGMvYWJJQURpR0hQ?=
 =?utf-8?B?YW9Id0ZmK2k3YWxCVXRXblk1RERzUk5TTzNYWVdwa1lLOUZ3Qm16aHQzNkxv?=
 =?utf-8?B?Y1hzdkllUjI2aGh5cTI2R2JGa0ZORkQvZXFnTTgzUFArbG9ZNCtvTEF5ZWlL?=
 =?utf-8?B?S0FOM2VLWGI2Vm1UaVB2Y1B2bGRUSEFBRy9yKzNySnVyYk1JNy9HaG02OGQw?=
 =?utf-8?B?ZlJiYm02enFVejM1MXhtVzRvRjh6dUliU1hkQnJqZUxqNElVU2ROQUxsa1Vi?=
 =?utf-8?B?U3FOdHV1Ym1ZMDlRMFR2bnRRay9Hb1Z4NUprbkdMUGZtMVVaeElLd2ptZUxq?=
 =?utf-8?B?SVZ5b2RxTlU5cWM5YW9XSFFNMEE0SlNYY2hxUHBBVy9OV2pxR2ZZd3hjQWJW?=
 =?utf-8?B?MTl0K09KT2RHOWJBcHZIQjlGcDE5dlpyMXVCbjB3Z2hObWpWUktQeGowOVpG?=
 =?utf-8?B?NW8xZjhkelVhVjJsL1YwUWI3K0lzcGttNGgrTmJTcGZ3T3ZqSEJ5b1ozaXhM?=
 =?utf-8?B?M210SVJJbVRkUGNscmIrZTNIVVZ0NUZ6cjVoWVhIZWNESUN6Mlo3U2plRk1l?=
 =?utf-8?B?eTJJSUhVOHA4S2tGZm8veG9xcGVCUGRKUG9ubkZNZlNGdUhwL2U3dXc1Q1Ba?=
 =?utf-8?B?NmJRVTV0c1gzM3hOZHNmWS9UZHl4MytlK2dqNmVoZ21LQlJqMXFpZVM5WGUx?=
 =?utf-8?B?M2Rjb0NFR2tJL1dWQ2JLUFJ0L2V3Q1BXMXJFcHR1YWprclRGSFZKb2g0UFNv?=
 =?utf-8?B?M3JnUnhzR0EvVW1MZktQaU1DSENSYVBPMERkNVIvekVZM1dyazhpQXZDK0VX?=
 =?utf-8?B?WkQ0SjliT1IzUG9TaXZTc21veUQzTVZsMTBmaFdwcDFVVWYvUFUxNVpjblVV?=
 =?utf-8?B?aEsrRTZGMXV5KzhGNWFjQU9wZ05QTE5mWmN5NFhHUzR4TDNDZlp5d1dyYUlB?=
 =?utf-8?B?aElENFNvM25ERnFwVm9MN3YrVU9hU0dQcjFnS1loVFp6NEczdno2T2xHMWt1?=
 =?utf-8?B?OVE0emRPWStZRURJbkxxOFJPQTFsRGsxNVBMaFZqMXJMTENtcHpFZmN4OEtN?=
 =?utf-8?B?M0UzK0VBU2Rpa2hOUi9tWlMvVmxWVWVLM3ZEOVU3a1E5WGF1WjJrei9hQThL?=
 =?utf-8?B?SXlTWEpIRTdDeS9yVTFxNS9ubkp1UWRqMERDMXY3ZHNhNlJua2dlM3Nzb1Ni?=
 =?utf-8?B?QVgxZG8yT3djOVk0bE5rY1BGb2xWN0dQYW1lZlo0eXBzZ0dUZW42RzVnbkYw?=
 =?utf-8?B?V1pzNlorZFRZOGMyVTM5S2o1ZWNsemo3N3pQZXZTTEEzbUhXZy9qaVdHSDRL?=
 =?utf-8?B?dDZBV01xemM3QmptVVRhUElwdVlWWUtlSGZ3SXlCQ0NpeHJqS3k2NDBxM2Jk?=
 =?utf-8?B?ZlF3dUREeDF3YjgrRy80U3ZrblVaZ1MrU0MzUjhGVC9kSHAzcEp6S0x0UXJ3?=
 =?utf-8?B?SFJ4ZlMxMDQ0K2gydEd6Q3pUbkVseG9UU2NPcXNsVlRodHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azlFTDErUWhlUkRRSm9XbWtiYlY2eDNRK0EzNW9QSTY4NEpQSWlxYnZPSlRX?=
 =?utf-8?B?bU43aStGY0h2enRqNTlLK0Jpa3hPMlJ1cHBwVS94dklFdmZrbmNzNnQwdEg5?=
 =?utf-8?B?ZUFDK1VNeG8rUlFOdXJTWGZpMUtaTmxiUnpDeE9nRzQ1YlVlbFJQN2ZZWjJu?=
 =?utf-8?B?bG1IdS9wYTU0NWFrcEJORm01elpDeXhxY1ljcGZnRURhTVRRYU5MbGRnN0Ns?=
 =?utf-8?B?K2JmdFgwWTFQSFFZQm1uZXNTVi83ZzhyYjdEcDlhcWxNWFI4L0N2VmtNUW1i?=
 =?utf-8?B?NXFBZ2RSVnFpbEQrWGwxWXdmWFVKcFg3RWJZeThmdnB5aE5YbkdHMHdIRGd2?=
 =?utf-8?B?Z2NjYk9QaDdlV2hiMlJ0V1VnSTY0ZUxVWFk0eTcvdWkvM2pldjcrbXZ6V05I?=
 =?utf-8?B?YkNEMVg3d1c5NWx1RllhU2hQV3UxUElicEZjOVRxVXhnOFZYVHp2NEdvVWt6?=
 =?utf-8?B?d3JJeEp2Zk9obTc3SlpFL3ZQWk4xaVhXeCtXNmpaWW1XK3FWeWl4YzN5QzZC?=
 =?utf-8?B?eFdRUy84Z1Zxd3ptaTVmU0g0bEhPZllyMDIwRG5oUGdaSVFtNzBnYUVhdW9P?=
 =?utf-8?B?RnNrSFZKSkZGVDlBZkkwM3Y1T2dZdE4zbzZka1FEcmxlTlZLTnAyN29XNWVy?=
 =?utf-8?B?TnpqR0k1NWNpOEFUdUFRWEFBNXJvbW85VDFHRzNlV2w3cCtXanNKVWhOTjdl?=
 =?utf-8?B?c3pieEcyb1V0V2xBUEZRZUh4bDBYZGhXcm5jc2g0K3RmVkRiaUsyUmxrcW9p?=
 =?utf-8?B?cWtRU2FtRHBpUTVCZ1d5dFlhZWJqRTlvcGZpVjd5aytxTlRFRGxHaVpkbkh6?=
 =?utf-8?B?SjlpZXJRTkhtZWpSc2JodG1XTnN0WnIrU2lmRENLMmFJbituQmxhRHJOdGpV?=
 =?utf-8?B?U3ZCLzE4OFRiUm4venVUQ2hnL21kVk40QytxRGdTVG9zek9FeUZ6TXVWb0VE?=
 =?utf-8?B?OVNJQzlMbjJQaUN2Rzd4MzNvK1VhVXBiRktmVUNKSk50WHEwRGRZcXZwcTFs?=
 =?utf-8?B?ZTY0ZHpLVHFwL0l3bE1ndkc3ZFlBa3NKUG11OUs4RUk1U2c4QUd3L0ROQmU0?=
 =?utf-8?B?a1F0bEJhUEN0bUF2UWNhMFVSc203bVhuam9UdlVOQnIwcTNKV012TWVsU1cw?=
 =?utf-8?B?Sjc0SjRtRFBwRzA3RU0rN1dXMjY1a0E0YUNhM3d3MUpzQzNod28rTHRVTEdW?=
 =?utf-8?B?aXErejZFSmorUUNDeFdETWhUUDV2VVQvUTFCelBkaDVQZ0k2cEFFOWw1M0w1?=
 =?utf-8?B?ZG5XdmYrQkFwVlM3NlNkTEErOGZyRU0xT3Z1NVYwUW9aaDZSTVNYZXZNS3Mz?=
 =?utf-8?B?YzB6OGs1WFFFUWxCMWlueWJkTm4rMUFTYVc3M1R2WUNxZC96L3VFdXExTXZn?=
 =?utf-8?B?TUtRTCtDWlg2bVVEY3ZYaGZxVVZhUUZuakNsTHZ4TlpoandzbHpZdEdkMkVD?=
 =?utf-8?B?Vk5XUUxncjhIRktpNVZZamJFSWszS01hQVNsODV6aEVTMWpMWnlVenFtM21Q?=
 =?utf-8?B?NFpGREFVUm5GRmk4ZEtWL2ZQdkljNWtieDZFZE1leGoxNkFRRDdnaEpIMXVm?=
 =?utf-8?B?RXU5ay9lUmJNUWx4ZTVMTE1HZ3JabERubjRDaXVRSW9sL0hTdUNJRDZlYjlU?=
 =?utf-8?B?QjN6aTlSUnZ4RnhhR3Z1dm0xOTVrR0UxclJxSDBiWmdWZ1IyNGNkQm9jNUVW?=
 =?utf-8?B?eGtIUWV5TVJCSlZzZmI0WWdZOUJQMXFDSmQxU1poKzhxOFZDSnVSYThrcEFK?=
 =?utf-8?B?RkJVR1Q0eThaZllhOGREVjMyMmhuYkZrR25sQTNhTHpXbTM2WnZXK3p0Rkpo?=
 =?utf-8?B?bGdYeXpvVXVOQ1YvWXJJbU5NSDg4d1JvT2pGYWgzVEhUSkM0dmhMblJ5MG9U?=
 =?utf-8?B?NWJkRHBMQk14TWV4V1NOU21kZ1hLNnJWUGJtUGVPMGJHY2xURmw1cXNoUGRT?=
 =?utf-8?B?RVJ2bXNzWXFNTkptOFc3K3JvWVVVSktQNW9wL2tOYWZoemsrdkcyanh1UW9y?=
 =?utf-8?B?VVN5WVAvVzQ1Z3hybGJSRWE4M1BVS1I3elNnZTVkcEU4SjBnVzl2ZzJSOGZ4?=
 =?utf-8?B?dUp2V0pDQVdKanJDNEduQmtjQVRCREhYTWpjNWUwTDFtb2xmeWlwNGFXbGMz?=
 =?utf-8?B?WnFjZ2R0SitMaUQ3TTdjNnFwVFd0WkphaUx0U292eGVNVU1pNGdYNmhtbkIx?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1736554E3456C4A96B1E770B0C0F07B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6435535c-3014-4d77-ce39-08dcc10e91c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 11:52:29.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdCzW4+sBRuhOZc9cySZVdc1Qgomkou3w6hGh2ZFfrsQUXdtj9l6x68rz3kCIATMcTfzdJ89rXq4hoAmEq3Wkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE0OjE0ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAyMCwgMjAyNCBhdCAxMTowNjozNEFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IEF0IGxhdGVyIHRpbWU6DQo+ID4gDQo+ID4gICAg
ICAgICBjYWxsICAgIHN3YXBfcGFnZXMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICANCj4gPiAgICAgICAgIG1vdnEgICAgJHZpcnR1YWxfbWFwcGVkLCAl
cmF4ICAJPC0tLS0gKDEpICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiA+ICAgICAgICAg
cHVzaHEgICAlcmF4DQo+ID4gICAgICAgICBBTk5PVEFURV9VTlJFVF9TQUZFDQo+ID4gICAgICAg
ICByZXQgIAkJCQk8LS0tLSAoMikNCj4gPiANCj4gPiAoMSkgd2lsbCBsb2FkIHRoZSBWQSB3aGlj
aCBoYXMgX19TVEFSVF9LRVJORUxfbWFwIHRvICVyYXgsIGFuZCBhZnRlciAoMikgdGhlDQo+ID4g
a2VybmVsIHdpbGwgcnVuIGF0IFZBIG9mIHRoZSBvcmlnaW5hbCByZWxvY2F0ZV9rZXJuZWwoKSB3
aGljaCBtYXBzIHRvIHRoZSBQQQ0KPiA+IG9mIHRoZSBvcmlnaW5hbCByZWxjb2F0ZV9rZXJuZWwo
KS4gIEJ1dCBJIHRoaW5rIHRoZSBtZW1vcnkgcGFnZSBvZiB0aGUNCj4gPiBvcmlnaW5hbCByZWxv
Y2F0ZV9rZXJuZWwoKSB3b24ndCBnZXQgY29ycnVwdGVkIGFmdGVyIHJldHVybmluZyBmcm9tIHRo
ZSBzZWNvbmQNCj4gPiBrZXJuZWwsIHNvIHNob3VsZCBiZSBzYWZlIHRvIHVzZT8NCj4gDQo+IFll
cy4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQoN
Cg==

