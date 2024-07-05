Return-Path: <linux-acpi+bounces-6774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A509286DA
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 12:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593B41C210AC
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6421474B8;
	Fri,  5 Jul 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhxL7H73"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207D22313;
	Fri,  5 Jul 2024 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175762; cv=fail; b=ioAqucH20GuanbB51uEv1tlc3tUbQcCQjNuu+ILKXmuji2GMtYqjkoNnIu66KLpgxC5BQmphr9c/if09l+NoMdSQ7TwOcevBcfLfmtF3kj+BCTVbdIKve9IJ5yqOgaSYizckMAcwmooqmf+heTYb1drfMAvfbfLqQSAmLUFUHMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175762; c=relaxed/simple;
	bh=O9mJXlNghGJCcX3MW7dBgV+NUAsjaef1eGTjLUZ2E74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=idwjGl68nnUXkhdZoFdWMIB1ERJZPfOeoryMA+j2JFvdFRShkzKeoX5BdBtqbAwK1g2u1IuR6BWi7ohdfH87czsTmcG6oUHta6yQgOf4jJJhbSX9XnyM+I050f6ODDDbutwUIdjqSROxLCkd7wU80r59JrKpEYw6f7WDi7NQPGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhxL7H73; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720175761; x=1751711761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O9mJXlNghGJCcX3MW7dBgV+NUAsjaef1eGTjLUZ2E74=;
  b=EhxL7H737WmW4dAABucM0Qd/yktSTF4fuyKIFsTcXVK1hZDa5m44dzeY
   ab/shdX/DBUkxP/EOPDxS9M1JshOv8jqqNl7SbiS0eBBLV/DyQu+qLSIk
   bvicxQ5dLbYFBG9Hrp0zVjFpwTXvffpz9pUgU7TQyaiD8W9ysbVg8VXF3
   miLVn2VVlUQY6yOVBXgYHA3409bsPz3vGWXM/RL+5jaO74Td2tmGhoIEO
   5jzMWwWFab+fuz+yhEst9yYmRrnVzJQAm1tQse+zwK/I2x8SJa4NSGGXb
   INHMSVG7nvKbBhP5Ov5hIH2fZz9f9p1pt3uvO0kcRn7dJUbIF7ZBQYNGV
   g==;
X-CSE-ConnectionGUID: ohRC0hz0Q+eETYgB5sY0vA==
X-CSE-MsgGUID: 7cOBCE33Qd2XBvktj42K/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17596111"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17596111"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 03:36:00 -0700
X-CSE-ConnectionGUID: MNYqguMFTNmJTt9yKMCDGw==
X-CSE-MsgGUID: 27Xz1JSDQP2D0D+ndkHJ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="70044501"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 03:36:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 03:35:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 03:35:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 03:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8zGupyBM52GsEoMy7sI2/hgjB92Vv1/ZUpLq8eYwVUWt1gFwF65OrNft8qqwRUgiqDEjCWZ1UTDqpuF5JpLjzTGjbvquYimjjUctkkJtO6QJydtdKNhuJWNcvM/I118MOilSBJ39CQgqOniSQUc08KnDzlniSTUE/t3MqNbxOi4K/R/kb3wSMtzYaV6xviAoKs11o0W5bsHqqVzOfca7BZSJeBS01UDdXwXggCL2e3T7GbtPnba1FTblLxKdih88apjQk/72Ym3TSXT2LWuDLhmp6Z11qSzdaH3lf3XPdyMJ6TOC/PxfCLl+VjgTkM+vxsI5NIQT2m65qJsc5s+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9mJXlNghGJCcX3MW7dBgV+NUAsjaef1eGTjLUZ2E74=;
 b=KACl2BIrtvDDSjbu+uuinqwweUGcXtJoX6aGKQRrDqTDgAIYiiflX7oWB6HL7ly+EB9ZZzKbw9qs+af7oJPYign4JuoeqwYyyNKwpZ9KmLAAlnIOJFT3RZFRpbbzPHgI7Iacf1p/AMHO49Wy27PhWaoHM0XuBmBZua/hkHdTqEt2Ia41BcpSOKe7chwN2Rct9VkIk24yceDADQzYxrvXQYcAT0iurP8QIB2oE5W47hDz8CQ6TgUcnRgAhgcMsDq2tA+IrP9Y75ScHwyTYs3tek+z8XNbw5JCw2GqmIVw6otZXx0prjOpu8kJXEQDh943ijf/b5tr8ZAe+Bn6cyFzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 10:35:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 10:35:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "ardb@kernel.org" <ardb@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 3/3] x86/64/kexec: Rewrite init_transition_pgtable() with
 kernel_ident_mapping_init()
Thread-Topic: [PATCH 3/3] x86/64/kexec: Rewrite init_transition_pgtable() with
 kernel_ident_mapping_init()
Thread-Index: AQHay7R0UfciK4zhOEeY8RF1SP8BgLHk2qSAgAG+aYCAAV3AgA==
Date: Fri, 5 Jul 2024 10:35:52 +0000
Message-ID: <50ceccb8039847c253b68c59af0ceaa5e04eefb4.camel@intel.com>
References: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
	 <20240701124334.1855981-4-kirill.shutemov@linux.intel.com>
	 <cd655676d5e81ca9b1de0a66f5f5c719ef816c89.camel@intel.com>
	 <vyvbvham7qcj2pnotfn4mocozx6x33zkvuks63w3ymzk4w6sjc@2gk5xbtb5xrb>
In-Reply-To: <vyvbvham7qcj2pnotfn4mocozx6x33zkvuks63w3ymzk4w6sjc@2gk5xbtb5xrb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7778:EE_
x-ms-office365-filtering-correlation-id: 08a2c050-d2ba-471e-ec55-08dc9cde3e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ek5zaEpTU0hhRlUvOFFvc0thQmE3RGlubkVjZmtTOHlTd1dab2tGdkxBSmRy?=
 =?utf-8?B?cHJEQkVzaTZzWW9SY1RmQ0tEc0ZEMzlYVC9GeVVzcDZydmlGSDJkRFBXL3ZU?=
 =?utf-8?B?S05mZWIwbXVreUdLemJ3Um9XUE9yL0thSC9JempEaDNjaUppNktDdzhQRUJk?=
 =?utf-8?B?eWdtYWdER0xhTUlGRnR4K3NzY09aSWdGbHZHY1VySkpwdFV1eHk1MktOMUVG?=
 =?utf-8?B?TEdNTGY4SmpqYmhBbC9IK0s5VXozaDl3TnVudkJicFZBTzJCbHZPYzErUXNj?=
 =?utf-8?B?dVc5dU5yb3RXSVVxYkh3cFd2eDRXL1k4QUM3UFpLckJyQndoTGtLUmhYUEJD?=
 =?utf-8?B?OUxIUVlrdnF3WTFJV3JxRUVvckVqREszUkt3cVd5aS94c29OS1cyNnVPNXJU?=
 =?utf-8?B?RFhRdmJIWWIyWTA0QTBOSitLVFlkUG1GdEE0Mkplc2k0OUxzZjdWNzhWUEFF?=
 =?utf-8?B?K2pyeXB4dVVxMFA5cWZGbW9YZThKY0NSYzdMREh1YWdTbGw0Q1RPc3cwQjZv?=
 =?utf-8?B?RmsybHE3S2Y5SThDRlBOdmY5ODdSbkgxSVdlMFoxdXgySDVlNTAyQUVETEdx?=
 =?utf-8?B?b2JRNkNjY2hsUVcrS2xxU0UyUmFObmdNUlZzS1FncUlibjdtQTRHSllZVGti?=
 =?utf-8?B?RUpzTHdtNHhUNlpNNTZ0QjRVdURXRlExdTNtZ0RhaVREcCtJeUJ0K3JDZUxH?=
 =?utf-8?B?L0lKV1grRUFnS25TSk1uallGako2S2ZEZmFKTHVMdHZPdDBzTUZGZkZRUmpU?=
 =?utf-8?B?cXNNQlJwN3Z1YkZPNndYVUk5cG5IdXpKNk9CUUhBdGdaRDZHWkVaRWY2NVJx?=
 =?utf-8?B?Qk94QXdpbUhRNnpXVTFlRWpRcFZIcC9vNWQrZEtHYmpwVCtvWnpBaWsyN1o1?=
 =?utf-8?B?YkhoUldFNzZrd3IwTEp0VXg5T2xpaWJTb0FyN0RhN3JXdmRheENRTXR2c1Ba?=
 =?utf-8?B?aDR0RzdUKzhpV3NhMHdaa3pjNHBPYVpEZzQvQlB2YUR5U2twR0FlRStRRzVn?=
 =?utf-8?B?b0VobTlZQWRGRGp5a2EzQTdwZzU5dmtWOWo0TVZpVnFaL1RHbDF5Mm53dVF4?=
 =?utf-8?B?MnJqaXg0bW91QjU1cGVhNkM4M2dJdlh6YndnTWt5RmI4dUd5RmcyZ3pXbEll?=
 =?utf-8?B?b2Vsbm9WL0pZa1gxY0llUGc0cnNuUVdTVElOWk9TMFJSNWVVUy8yTWlEcUpp?=
 =?utf-8?B?S1ZRczF0RGpCNzEvOTVyQ0h1MCtMYU1pS0gwdG1ldjRDSXBCR3pzckd1bGc5?=
 =?utf-8?B?S1diSTNJOVg5WW1TZm91SlhOaWpvR0ZMbVlSUkNFMWEwL205NFJtcVlzZVBh?=
 =?utf-8?B?WGVZMytEcXo5UHU5VzV5VU5VK1N5VkRvc2w3eFFDdWkxdzJxYjF1T3psU1FQ?=
 =?utf-8?B?TGpCT0RxZnI1b015amZEL0JGMERIZmdtOVozelkyUmV1VjQ4NXVjdllFSDdp?=
 =?utf-8?B?ZWtPTGNTWVAvZm9WQUczWHFCcFQrY2xpOTg1US9maGdkL3ZCQkFsMTg0M3ll?=
 =?utf-8?B?V3RUb1Y2V3ROajV4b3dBclcxZDNJZDRTM2trcHZEK1hpVHgzdUh0c0wyd0NC?=
 =?utf-8?B?QXBkaTdaZVZ2eHEvL2ZGejJNaXBIVlFnTXJtTG1NbG1GTTBBQ2N1bjFicHEv?=
 =?utf-8?B?K1d4VVhxY2diUVBoaXIwUG80bEJPWTNLRHBkZHpxTXVLSlIwOWtHejVJc1ha?=
 =?utf-8?B?T0k5T0VSM252eWVaeUJ6Nm40T2xzbE5WNmpTdzcvMWhwc1h3YVFtMjlpTm1X?=
 =?utf-8?B?eUJORXlYMjZYSXF5VUY4M3kzYzZUTzU1Z3JhZEFpb3I1eXdNRlVqLzFScTB2?=
 =?utf-8?B?aGtXVm1teDZxNVh1aTk3MHhYMW80V1pCb21iemk2QWErcjJSckc0d3JPbVVV?=
 =?utf-8?B?YlFhWVYzKzRPMVNkUCtzMXZxY1lQNUdKNVplLzB5bWFLdkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm90T1hnVnZQd0huVWRaRjFCK09LZndBTHFQT09qUVJXWnludFQ0SlNoRy9R?=
 =?utf-8?B?V01DbmlyaHBLWG5DL201L0dMbWxrWVJYWVIyclg0WGY3SWNmSFNJL0grN0ZI?=
 =?utf-8?B?VVFseUJmM3FESTdMdUQydDVBV2dVOWlCbHVPWk5qb29hZWQwdTVpUFZnMnRX?=
 =?utf-8?B?L2Q3T0R1Sy9xWElZa21XaVZVemd0eVZTV3pZeXA0Vkw2QVF4ZFZsanR5ejBs?=
 =?utf-8?B?MGJxR0M4QXRDanRkcFkwWHk4NkZNTkc1WHppN0hDbHpCcUVlNW9DdHNIMGdF?=
 =?utf-8?B?OUhmT1NXcjVuVzVGemNEcWVDZWJJNlhkOU1RNGhRTjBGc2RCR1hydlBzamZF?=
 =?utf-8?B?KzZqYW96Slc5SHRheTJXV2h5V0ZXc2pHYTRZbEZuanVuMnVQUGJtWVZhNDlT?=
 =?utf-8?B?bCthS05nWGV3T1ZUT1JSWlBlcUtHV1p2TkZpOTd1SWtocUtlT3l3Q21BU2ov?=
 =?utf-8?B?ckhyVlo5NzJta0Nzc3B5UTNJQVNQU2FlaW9uNnMzRHo4NE9STlhYN1VMcDJx?=
 =?utf-8?B?dXAwRFRmTk95emJhSDVBaGNKRkowa1g5VUQvbnhXNVgxVXBwTXBjK0wrWElK?=
 =?utf-8?B?OEYvVWZnTXR4QXBqc01tSFFzRlZxb05QcUVIMHh1aUVLT2tHazRrQWY4MXZK?=
 =?utf-8?B?WFl0WnprK1hNcWVrMHg4c1p4anZWZVFUTzlibC9sbEs4L1pFNmZkL2NqUXgy?=
 =?utf-8?B?NGwyMnR3eFVPWEV0aXZDNGhpRzEyOGQwSFJwWldlVmdVQVgyOWFKTmRESDJU?=
 =?utf-8?B?SENyTlJlK3A4VDVRQ2VlT2p1TmdGNEF0emhKcjVNMS8vVGc5bUJRQzM0Nm96?=
 =?utf-8?B?YmdsaWVuSGtJU3VwM0F5eWh6MGNYSEdPYTVQSjJSREc4RE5Ja25QVXFhS01X?=
 =?utf-8?B?YkhLOW80QUFRdldSNTFuZlR6K2ZXR1dJZ3lZM2NHMVdJajlrbW5UYlkzMHM5?=
 =?utf-8?B?RjY0WU43WERzY0Z5RU9ZYk8xV2xIY0tPQTNhaS9BYlRYMThnakxkd3c2a2dL?=
 =?utf-8?B?eW16T0FLNUJ5UXlvVWs0emFOSG1nc0sxSE1aeHlmcFlDRkgrSmZTTDFiSTAr?=
 =?utf-8?B?eXVEdjMweDJWM1BTcy9iOWZEMmI2TnlxS1FFRlRBNVY1K04rdS9RejM0ZkZC?=
 =?utf-8?B?WjRRTGp6RmVhSm1tYzZDVHdiMjl2QXZ1dmdKeW9JdXp5VUN1c3RVQVNqZi8w?=
 =?utf-8?B?NmpqVmpnOFVmSHhMcElVWE5mSDZBLzB6elorYjZucHlSYW5jcjB6RTFQZkNy?=
 =?utf-8?B?RmlWalF4TTBtT001a0hkdVRxc24yN2RCK2FzR29Pa2tUVHBjcUQ3YTVxVmZh?=
 =?utf-8?B?RTFTWjU1Q3hpT0pFVGZndDNCNERxaU5meXd5aEZYalErVm5iWUNVQ0NGREJ0?=
 =?utf-8?B?ZEluOWYvbUluVXpaZlAwOU1sV00rcnJ1eGFDT2JPMEhKbkpxOTlrdTN6Y2FQ?=
 =?utf-8?B?YTh1WUpaeHFXWHVjdXdsM2Noc0pOVi81c296U1czd1NGMGoyNVBEZVFXamNt?=
 =?utf-8?B?WXNSUjdnV25LMkxFQXM2eFlKNnp6OXJRSktSaC8vT0lIa1IrMCt4NzBGWTJ3?=
 =?utf-8?B?M3dyT1Fvb1AxOEt6NFNRUURBMWs0cXFTNFNxWjZGT1p6M3ZOZVB1MG9JZS9m?=
 =?utf-8?B?ZmFnekpJTU1TRGlMNHVPbjZFVGNIdHJhWTZaZC9yc0Q3MUU2b1NpTUlPMUFQ?=
 =?utf-8?B?M0VxZ0NVN3A0eWZUYzA5d1RLSXovdzY0ZkRKTlpLSjJRckJNUGxEUjRZK3ND?=
 =?utf-8?B?RWlHeU04cWh2YjZ6SHo4MnVObVlnenY1c3pSbTk2Ui9rRFR1V083UXViRFNC?=
 =?utf-8?B?OHRqVVRnT3BQRDVEWE4xRE8wbDY1aVp5SFhqSWIyeXU3a3FCa1JPY2MxRmJT?=
 =?utf-8?B?a0FtVXhnbWRKSnROSC9kRTdSd3pPSmFnR1doOEdBZGNJVkNyOVNzbENPZUVX?=
 =?utf-8?B?dTBKelptd0hmU2s2WTBqTTZBcVNiM0NRM3RTTjBaY3loVmU4dEZkWEZqZDJK?=
 =?utf-8?B?QlQ3aGNwbUFzbkNyejNGc05vUXBMTWtKdktkZ2hTRUFxU05FZS9QeDBWWUhY?=
 =?utf-8?B?aGFYem5ab1Nqd0sxRStSSXI0dXZCYTBETXpNT0tkWWlpZ0g1ekY0ZFBRTjJ3?=
 =?utf-8?Q?e/h+5dK7sfezGAOV4GPKzanKb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <989D3D2837399B4FA692031372551F19@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a2c050-d2ba-471e-ec55-08dc9cde3e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 10:35:52.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8C59wVdBAZWsig1Y7il5IJICXdmRjdfe2VBM26QgaGK73vaIJnuNDcGvypqAMNsV+BDUvrtAcr8noY2qW3Viw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA3LTA0IGF0IDE2OjQ0ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAwMywgMjAyNCBhdCAxMTowNjoyMUFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gIHN0YXRpYyBpbnQgaW5pdF90cmFuc2l0aW9u
X3BndGFibGUoc3RydWN0IGtpbWFnZSAqaW1hZ2UsIHBnZF90ICpwZ2QpDQo+ID4gPiAgew0KPiA+
ID4gLQlwZ3Byb3RfdCBwcm90ID0gUEFHRV9LRVJORUxfRVhFQ19OT0VOQzsNCj4gPiA+IC0JdW5z
aWduZWQgbG9uZyB2YWRkciwgcGFkZHI7DQo+ID4gPiAtCWludCByZXN1bHQgPSAtRU5PTUVNOw0K
PiA+ID4gLQlwNGRfdCAqcDRkOw0KPiA+ID4gLQlwdWRfdCAqcHVkOw0KPiA+ID4gLQlwbWRfdCAq
cG1kOw0KPiA+ID4gLQlwdGVfdCAqcHRlOw0KPiA+ID4gKwlzdHJ1Y3QgeDg2X21hcHBpbmdfaW5m
byBpbmZvID0gew0KPiA+ID4gKwkJLmFsbG9jX3BndF9wYWdlCT0gYWxsb2NfdHJhbnNpdGlvbl9w
Z3RfcGFnZSwNCj4gPiA+ICsJCS5jb250ZXh0CT0gaW1hZ2UsDQo+ID4gPiArCQkucGFnZV9mbGFn
CT0gX19QQUdFX0tFUk5FTF9MQVJHRV9FWEVDLA0KPiA+ID4gKwkJLmtlcm5wZ19mbGFnCT0gX0tF
Uk5QR19UQUJMRV9OT0VOQywNCj4gPiA+ICsJCS5vZmZzZXQgPSBfX1NUQVJUX0tFUk5FTF9tYXAg
LSBwaHlzX2Jhc2UsDQo+ID4gPiArCX07DQo+ID4gPiArCXVuc2lnbmVkIGxvbmcgbXN0YXJ0ID0g
UEFHRV9BTElHTl9ET1dOKF9fcGEocmVsb2NhdGVfa2VybmVsKSk7DQo+ID4gPiArCXVuc2lnbmVk
IGxvbmcgbWVuZCA9IG1zdGFydCArIFBBR0VfU0laRTsNCj4gPiA+ICANCj4gPiA+IC0JdmFkZHIg
PSAodW5zaWduZWQgbG9uZylyZWxvY2F0ZV9rZXJuZWw7DQo+ID4gPiAtCXBhZGRyID0gX19wYShw
YWdlX2FkZHJlc3MoaW1hZ2UtPmNvbnRyb2xfY29kZV9wYWdlKStQQUdFX1NJWkUpOw0KPiA+IA0K
PiA+IFBlcmhhcHMgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IHRoaXMgc2VlbXMgYSBmdW5j
dGlvbmFsIGNoYW5nZSB0byBtZS4NCj4gPiANCj4gPiBJSVVDIHRoZSBwYWdlIGFmdGVyIGltYWdl
LT5jb250cm9sX2NvZGVfcGFnZSBpcyBhbGxvY2F0ZWQgd2hlbiBsb2FkaW5nIHRoZQ0KPiA+IGtl
eGVjIGtlcm5lbCBpbWFnZS4gIEl0IGlzIGEgZGlmZmVyZW50IHBhZ2UgZnJvbSB0aGUgcGFnZSB3
aGVyZSB0aGUNCj4gPiByZWxvY2F0ZV9rZXJuZWwgY29kZSByZXNpZGVzIGluLg0KPiA+IA0KPiA+
IFRoZSBvbGQgY29kZSBtYXBzIHJlbG9jYXRlX2tlcm5lbCBrZXJuZWwgVkEgdG8gdGhlIHBhZ2Ug
YWZ0ZXIgdGhlDQo+ID4gY29udHJvbF9jb2RlX3BhZ2UuICBMYXRlciBpbiBtYWNoaW5lX2tleGVj
KCksIHRoZSByZWxvY2F0ZV9rZXJuZWwgY29kZSBpcw0KPiA+IGNvcGllZCB0byB0aGF0IHBhZ2Ug
c28gdGhlIG1hcHBpbmcgY2FuIHdvcmsgZm9yIHRoYXQ6DQo+ID4gDQo+ID4gCWNvbnRyb2xfcGFn
ZSA9IHBhZ2VfYWRkcmVzcyhpbWFnZS0+Y29udHJvbF9jb2RlX3BhZ2UpICsgUEFHRV9TSVpFOw0K
PiA+IAlfX21lbWNweShjb250cm9sX3BhZ2UsIHJlbG9jYXRlX2tlcm5lbCwNCj4gPiBLRVhFQ19D
T05UUk9MX0NPREVfTUFYX1NJWkUpOw0KPiA+IA0KPiA+IFRoZSBuZXcgY29kZSBpbiB0aGlzIHBh
dGNoLCBob3dldmVyLCBzZWVtcyBqdXN0IG1hcHMgdGhlIHJlbG9jYXRlX2tlcm5lbCBWQQ0KPiA+
IHRvIHRoZSBQQSBvZiB0aGUgcmVsb2NhdGVfa2VybmVsLCB3aGljaCBzaG91bGQgYmUgZGlmZmVy
ZW50IGZyb20gdGhlIG9sZA0KPiA+IG1hcHBpbmcuDQo+IA0KPiBZZXMsIG9yaWdpbmFsIGNvZGUg
bWFwcyBhdCByZWxvY2F0ZV9rZXJuZWwoKSBWQSB0aGUgcGFnZSB3aXRoIGNvcHkgb2YgdGhlDQo+
IHJlbG9jYXRlX2tlcm5lbCgpIGluIGNvbnRyb2xfY29kZV9wYWdlLiBCdXQgaXQgaXMgc2FmZSB0
byBtYXAgb3JpZ2luYWwNCj4gcmVsb2NhdGVfa2VybmVsKCkgcGFnZSB0aGVyZSBhcyB3ZWxsIGFz
IGl0IGlzIG5vdCBnb2luZyB0byBiZSBvdmVyd3JpdHRlbg0KPiB1bnRpbCBzd2FwX3BhZ2VzKCku
IFdlIGFyZSBub3QgZ29pbmcgdG8gdXNlIG9yaWdpbmFsIHJlbG9jYXRlX2tlcm5lbCgpDQo+IHBh
Z2UgYWZ0ZXIgUkVUIGF0IHRoZSBlbmQgb2YgcmVsb2NhdGVfa2VybmVsKCkuDQoNCkkgYW0gbm90
IHN1cGVyIGZhbWlsaWFyIHdpdGggdGhpcywgYnV0IHRoaXMgZG9lc24ndCBzZWVtIDEwMCUgc2Fm
ZSB0byBtZS4NCg0KRS5nLCBkaWQgeW91IGNvbnNpZGVyIHRoZSBrZXhlYyBqdW1wIGNhc2U/DQoN
ClRoZSBzZWNvbmQgaGFsZiBvZiBjb250cm9sIHBhZ2UgaXMgYWxzbyB1c2VkIHRvIHN0b3JlIHJl
Z2lzdGVycyBpbiBrZXhlYw0KanVtcC4gIElmIHRoZSByZWxvY2F0ZV9rZXJuZWwgVkEgaXNuJ3Qg
bWFwcGVkIHRvIHRoZSBjb250cm9sIHBhZ2UsIHRoZW4gSUlVQw0KYWZ0ZXIganVtcGluZyBiYWNr
IHRvIG9sZCBrZXJuZWwgaXQgc2VlbXMgd2Ugd29uJ3QgYmUgYWJsZSB0byByZWFkIHRob3NlDQpy
ZWdpc3RlcnMgYmFjaz8NCg0KPiANCj4gRG9lcyBpdCBtYWtlIGFueSBzZW5zZT8NCj4gDQo+IEkg
d2lsbCB0cnkgdG8gZXhwbGFpbiBpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gdGhlIG5leHQg
dmVyc2lvbi4NCj4gDQoNCkkgdGhpbmsgZXZlbiBpdCdzIHNhZmUgdG8gY2hhbmdlIHRvIG1hcCB0
byB0aGUgcmVsb2NhdGVfa2VybmVsKCkgcGFnZSwgaXQNCnNob3VsZCBiZSBkb25lIGluIGEgc2Vw
YXJhdGUgcGF0Y2guICBUaGlzIHBhdGNoIHNob3VsZCBqdXN0IGZvY3VzIG9uIHJlbW92aW5nDQp0
aGUgZHVwbGljYXRlZCBwYWdlIHRhYmxlIHNldHVwIGNvZGUuIA0K

