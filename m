Return-Path: <linux-acpi+bounces-17806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32364BE09D4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 22:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8936A19A6830
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454C529B204;
	Wed, 15 Oct 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI9BM649"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC829AAFD;
	Wed, 15 Oct 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559596; cv=fail; b=CJZ7W2EkqjffwvTF6i8/u8Y68uigBr4IyY3bu+LBbJKVjqIgXrt1modIbDEPzcUOMqD0oWclrII+r0/ovIgHQbokVDqHMcMDxUqA5xYTBlhXBGyjaJoZjRTvfavC67Zg8Ro9qfsepXB3TRvjolLt7ruPKFMoKpPgteCSkPRgzA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559596; c=relaxed/simple;
	bh=zGxM4qvtizTbM8dZXVeiPF5qpOqYEBNXUq2ibO2xQaQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HvPhz2HD09+/cwzHsGegNWm4T6t2LMDFrrAF96FTxOa3Dsx5wjcL0CnCGhighF29vNexvB0VVE3K4k/wYMjNKiypMAPjhl1dgq+POLksq8yskJbDDmTlqrAb8lU9cNdDO4Pqa5O242pGCRpNrxPEjGHAqGynnwBUF3MrmEw9xlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI9BM649; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760559595; x=1792095595;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zGxM4qvtizTbM8dZXVeiPF5qpOqYEBNXUq2ibO2xQaQ=;
  b=bI9BM649n8aHnB8nrYRYz1J4B/ApGYO/qh0kM41L4wIHXOk9QeiknJ0O
   fenxlomE6W/z59HveVfEseWxEIvpsBPhwoJEH18e2tXlowVPATFQgIO4h
   SIAo9QHPG5LaWz6UXsKGiqEB6jLkfaieO0g0fDKa8Vdh0jwxDGzw2xZJ1
   eADN9Tra2je82myRVVy+3EUyGJ28kRq2u6wxs0sWtuIoDzYU6RQhwAdMC
   rLoPtw2I0t97jV996ErGTW7usnRUgt9Ff4U6onOW0M7YaHlAgBedFvq9Z
   pbKv9tyNJgUR3EzvadioVqKsXwnAN5p3yo1wzBmisxAnK2XnKhQhYRx1l
   Q==;
X-CSE-ConnectionGUID: 01Kw7S+iQiyrPOJSRE0K7Q==
X-CSE-MsgGUID: Hfy+X0GWSXuG6B29qyj9Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73023405"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="73023405"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:19:54 -0700
X-CSE-ConnectionGUID: zbUzVr7dTBCQO51FRJUuEQ==
X-CSE-MsgGUID: kyuHlSIZSem2nHnH8wFW5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="181937464"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:19:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:19:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 13:19:53 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 13:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAqcBJ56BY8yKSJwTcHzaR4zwObGG6EVE3SArWOpmRmPsXcC4qOHlD9A2wlvU65rqnlnfMYmb1ur5SoAZ6mlZkB+yxJvSeVTFeoE3hmlQYMD8LKfpgXRfvyd3dgyDAKWXvQlP/STY++harl5YB3B0n3zFRbzCR1qai182wrxisgFFv3Y2P0nbQpt/sch36ZMAZkaovQVdI9bhOUTmbhEriUkQNtcktLHv56G52+l7Xi+XfgYpsgiIkz0mczCdoLi9kXkd2zycZXtIZyLP8EmH3aSGx98bInj3WQjIoZu3noaWEVU0ufE2mN/FA0lkFIIPo1laKA+1GPkTtRFZiibaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O/qWK/DfPu34JJ+7TihoVhLvrO4Mgi40rlIEMGgTUs=;
 b=HD9620PtmuRVU/Z3kBX3PehzbH8cK/FGyE4jqpGWh7IsWhw1ahjxLEYvtgboFj8DHcJoOKQOsD7QxWC6N0FtXhuml7XWvznkGqLETVLn9t0Z6d28/oe6kp2ZMmiH/1n6M+2lHiPz8EChAH2IUf7JUK63pAWQZxyLiLkm2C0VZGASRPdvtj7b8wokQFXWUoIndHX/W49S8/7qoqGFm3Lt14d00qALGLTiIpj9lfF2cqjx4J/z0tMvuRWdsoYCZbYV8sXZshvLn+FQbH8sS+KI6gLs9xjmOZgUv/DjgNvYhz2gCqtiKkR/xs+9jYckCkHjczw4blFLTWbw42rbLwOshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 20:19:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 20:19:51 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 15 Oct 2025 13:19:48 -0700
To: Dave Jiang <dave.jiang@intel.com>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
Message-ID: <68f001e4e4a2c_2f8991001a@dwillia2-mobl4.notmuch>
In-Reply-To: <20251015162958.11249-1-dave.jiang@intel.com>
References: <20251015162958.11249-1-dave.jiang@intel.com>
Subject: Re: [PATCH v2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9d60b5-0ab8-4855-5ed6-08de0c28321d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGZSZUMxWDlRUHpLQTdnOWx2c1hpekZLZCtHeG03ZzdPOTFkczdtRVNRU1lX?=
 =?utf-8?B?R1R0RUNTVmRtWHhMcUtpZS81T1lsMzFCc0NKSFEveWU5SzhCOVJ2dTM0VWIy?=
 =?utf-8?B?TmQvVlk5bERsVHNFbkxrS0xTb1ZzcnNvVTZCQTVYc200VEhLSlBhcFB4OENr?=
 =?utf-8?B?c2p0UXpmZDNGRWVkendqOXdCcmwrVlNub015VlpJYm1XbG80bHF6ekZJcEVr?=
 =?utf-8?B?Z3NIRTNEM1BYQ1o1T3RCMCtxVzcyYWJNa200UERpT0lQR1pzanV6UStBbkVu?=
 =?utf-8?B?elg5clI4N1pmRnVIOTN2MWI2dnNuQi8vNFBMcXp2MU93dlFid0ptUG15RnE5?=
 =?utf-8?B?UmhhUEtXd0xsdkNhcm51OVl5Qk5ybDg4Ym1ZVmJMZ3RyR2YyYVMrd01IMys2?=
 =?utf-8?B?bjhIYUJEMnFnWE1oaU1EQ3NvZnhYRkY4R3lob05aNExaeUhJL1FhelgxbFA2?=
 =?utf-8?B?ZkZaZWo2VG13c3p1U0h6dVBhM01pNnNBVnFCS1BpWTV3aTIrUisrNDA2UE1M?=
 =?utf-8?B?RlNaQ2NnOXc4Z3RkK1F3Q0kvUTFSdHdSRnVKVWJCcmhlNjdLcmxnbkI5NkNF?=
 =?utf-8?B?Mjh6NUd5WnpqN2U1aWFJZUlsOWp0alJId1ZlUEhtdzQ4RExWUFh0UXFDMjlU?=
 =?utf-8?B?MlIzV0o4TnA3Z09CTHhhWHJsOWJ2SUQ0eXkxYlEvMTl1NkNYYXYvemRDNkFY?=
 =?utf-8?B?R1dPcklWRHFLYVlFUW4yTk9BSlZjUSs0WkZvckd1SFNyb1RnOGlWeEExdzlX?=
 =?utf-8?B?RnkzeXlzV1BsTnZLdzFycG9WcnpueHdUVkxqdnIwdEdWdnV2TkNFZDBtS0FM?=
 =?utf-8?B?VUFXdjFPZG9WTGhldXlkSjRtbStHUWV3SENVWG1iZEFjUDFaTjhpVURxOFI5?=
 =?utf-8?B?WCs4WS9WQlVJVVNXRG9BS0dBNFZhL1ovaER2THBBTU5CZThYV1pWSzBtR21w?=
 =?utf-8?B?V1pVdUFYTkd5OHVseUFJRXhLb0xrUzB2bmt1M1NJSlA1ZjdSdGNBMWRKbVpk?=
 =?utf-8?B?eFZJQXBnc1BTTTBBbXZGVUdWQnlHenBWSE9EYnp1UWhiT2Z3RjJzZ3NyMDA4?=
 =?utf-8?B?MlkvUmFnUjFnWU0wbU5TdmZNZDZ3bk1HUkRwSFdPcExFM3RlME9CaHFad3pu?=
 =?utf-8?B?UUZ6Yk5najFtQjlWcFNIajVHMUlrT0hSZ21yU0dZTitJTmJQSktqS0VoUnlO?=
 =?utf-8?B?Q00xNVN6Y2hiMXlyOTM1RzIxTURURzdmODhLU2NSVHVYZDRsVlJ1NFNndFor?=
 =?utf-8?B?blhib2hmU1NRQmdaWkNPTkYxcUhVamRFRDBrMkpxcGJ0OG85eldhZU5Xalp5?=
 =?utf-8?B?K09KeTZHNlltRUJEcjREQjFmZW8wcUdmVXlXcFZUd29XZndIenhNaVRlWjRF?=
 =?utf-8?B?dzE0ZmVHTmpVWTNvQXNQOFRCb3QvYytqaXphaXVLbXNFRkxrU25CekNwZkl3?=
 =?utf-8?B?aXJLYUd1UGhrOGJpanZMdE9TeDh4eVdRSCt0Y1VvR2I0WTF5MTJaUVJaNmly?=
 =?utf-8?B?S2xaTEEzMDBjcEhyVmM0Y2xyWjR2cGthQUJYTWJDUHlabnk2UE9SN3U5aWQ0?=
 =?utf-8?B?S3pyMWR4a3pKdm82bnNNRHZkWCtVYWNsbzROdDMzZTFQN2lJb3poTEtlTWxK?=
 =?utf-8?B?bkMrNS9tQXNZc2ozNDk4UnlQZjFEZTNLb1R0U0FXMHRuZndvZkxod3Nvb3dE?=
 =?utf-8?B?RzNEK3pCUnRtK3hHdi9RR1lNc25mZ3hjUUN6cE50NUlDay9UL0JmRG9QMmQr?=
 =?utf-8?B?b1U5V3FlbDBJWjJoVlFFcHlCYmFDL1hYM05vc1gzSCt0cDhETmF1V3NTTFd6?=
 =?utf-8?B?WUFrMDVFZWdocjMyWUhqRm1teU9FcHJ3R2JIdmZuYmZxaGhqVzNpNkp6Zk1p?=
 =?utf-8?B?WmgvVUNYaFBSTnpLbnpnYVlmK2JUYmJuNlBtZzI4NE9WdGszbXRVb3QwUVhm?=
 =?utf-8?B?YldCVDFTWnpXcEdqemp5SkVRRDdJWlN2Y3d5eCtlR3NLU09KNGRGR2xJT011?=
 =?utf-8?B?Rm5ad1RlVk5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUtnenN4b0tyUkJhRENEOHBrb2xnT0VHK0dPM2JkaG5iTCtldHp0YVFSbXhw?=
 =?utf-8?B?a3ZySjI4aVdDR0NYUWJmbkhFSVUvUDB3MEFUU2VWWkpsVVJrK1VyZ2RxMUU3?=
 =?utf-8?B?OThMbDliWEt4NUhWTXAwd1MxUng4blJsb0Fuc1RoN2ozdW4ybU9kNU41NXlk?=
 =?utf-8?B?amlsTzg0OHZ1NVg2bTZKc0h3VmNWazZoMTRpRU42Ujl1SGV1SDY0WEsxeVR6?=
 =?utf-8?B?WERxbjNGWi8vT3NrNzlHejR2dlhBUC9GUmN5djdyTG40ajlIU2xwaDZDWC9L?=
 =?utf-8?B?ZE15SVRWSXQrd1RRUG40OVRZKzdhUERDalhqTkI2UGdYQ2RUOWsxc0I4VWlS?=
 =?utf-8?B?Mlc1UXZwL1M1aGRVQUVlcVZOWUJ1V0FyZ1drbm1Rc0hjV0hSVk9NelozeE1t?=
 =?utf-8?B?YTdDOWxNbDA4UGZBOFZMMDhCa0h5Z1UxTi9JMzNIaWlNdW5SSkpwaGZVK1RI?=
 =?utf-8?B?RnIzNk1ycVdTRnludW9QZngxdlRhR0d3ZXREWnBuSFJWZzE0RTRHRHBrdHBr?=
 =?utf-8?B?ZytpRTdvblpJSnhiR1FkWVg1SW11Z3lIUTI0c2pxc2NlOFlHMGVsQmY1eDBN?=
 =?utf-8?B?OTZXKzRYTk5jSXpzcSt1QVdKUUExeFpRblRrR1NGTFljWk5UOVlmYnBScHJr?=
 =?utf-8?B?Z01MUFpwL2pMVzZIZnk0OFNsdEJmVVpmT1VqU09heUNGTFFCbU1pRHpIRVFX?=
 =?utf-8?B?TjYzamdXWmVJU1l3VVZQRFcyUFdjV3lCVFJSMXl3N3o1azBCS1BPS3NrVGFp?=
 =?utf-8?B?b3I2OGVNcGgvbEtyTWJEeVdsMFdhMng0SkY5L3MvaGJodGxBU2EzcTJZa2o3?=
 =?utf-8?B?Z2RtRVJsWDlDTVlQeEthUDdZWXFnUmNBa2x4WmRZMkFmSWFPUGNGOExHNEpE?=
 =?utf-8?B?NEpVYTRXaGxKUFl2NUxoZkd0T2ZvRDB1aUhCMVdqVWVwWVZvZ1NRZUpJbEJL?=
 =?utf-8?B?dmxENVFNdnhiUmtyQWpWYXlmdjM1MmRyM0R2YXB5Y0hXeFM3Q2RDRTY2a0tB?=
 =?utf-8?B?NUZuanRRd2MyanM5ZjBkbGVvejJUdFcyR0l2bmZZRytXaDc4YjJCYWQrNEZv?=
 =?utf-8?B?VkNzN1Nlb09LS0tZMzdBVGs4ekZSbk5DdnBUVFk1dVlsbU1KeXRScFg2eFIw?=
 =?utf-8?B?aDVud1FacDloL1VhRDc5VlZwTXdWd2lQQU9Bb3I4YkpjM2RmUGlubVBJeHlY?=
 =?utf-8?B?dTA0ZWR2Z2tDV3JDZkUza2FpTmJkY1pHQ3kwWmVRZ1RaSzVsZXplY0U1VXZP?=
 =?utf-8?B?REJmSW9TZGZLLzhJeGNGN1JsV1VtampscE0yc25IdmxyL0k3bjlGcWZBZFlh?=
 =?utf-8?B?QmE0b2FvMWowMDZsc0pGL1V3d0F1Ymx5bXBaUy9uZVdtZ3V3U0p5TE53eE5Y?=
 =?utf-8?B?MXBtSWtCNEc5V2d5d0lGbnhFdWljM2tVZ3Q1cGpEMCt5dXljUGx1WDYxOFVr?=
 =?utf-8?B?NFdNQm9NY0JTTkhrTEdmWXVDTDVNVnJtZDlKVHNuSTFRWWwwU2J2Uk82R0lQ?=
 =?utf-8?B?dnFLWVA4aHc5cFQvSEpEcXRib0VQN3E3SE9JeGxHSkVsUWt3eGpvVVE0c0Nl?=
 =?utf-8?B?VFdBaXFHT3pBREIvRW5EZDN2S2JBK2N4aG5LRk9NTzdib3FRdUNXUTE5bzU0?=
 =?utf-8?B?TXgyYzc1STFOZUZKTWhTWHJ5QzBiZTkrTVE4Qm8vcS95bjNrTk1WMDR1RWdC?=
 =?utf-8?B?b3R2WDdZZThWNU01c3pVSytmd0JPd3BROVBzMCtCdFhPYVFqOEZjNThuN2ll?=
 =?utf-8?B?d1ExZkZaek9xYlo2clVRZnJ6dTFzc1B1amhDMm5HcUhsZXdyTCtCNFlIc21n?=
 =?utf-8?B?TU5OZUFlTy9Pdzg2ZVlXNGlxczc5Rk9yYXQ5a3JxendDL01rb1V4YWx2MlJD?=
 =?utf-8?B?NUtuOUYzd2syQlhZK0pvcE55TjlSOTNCM1Q0YmRoVG9wQTBDaWt2OE4zd0FY?=
 =?utf-8?B?VXNTSVVkZ2dZa3dDMmFzWWx6VUtwQWViZ08vTWFQRjRGeks2TnV3VEtxOVlS?=
 =?utf-8?B?UjUweEtZNE1NSTJocWEreEsvMFRodXdjSGtmbEJZdVRoOGRHcmFNcnEyMFRz?=
 =?utf-8?B?dEhEN3F6TFV5K01weTRRcEpYNWt3cUhneXR3Yk5PdUN3djNBQnJ1K1l2YXRX?=
 =?utf-8?B?cUtaR1p3OWFoRFJQaStNazF2cW9GejRDbXB3WWlXVTlQUmw3YmkxVlRMUHV4?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9d60b5-0ab8-4855-5ed6-08de0c28321d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:19:51.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPsP08hY9v1c58kVKGIUDC429DOHAjnv/VzjlIOXCH2SFPUnB8bFvAX8f/vuGeXWttJxpF6eGwtLztQE/HvzkFSUAlPiMcEjTWwsQ/Y+6rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The following lockdep splat was observed while kernel auto-online a CXL
> memory region:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.17.0djtest+ #53 Tainted: G        W
> ------------------------------------------------------
> systemd-udevd/3334 is trying to acquire lock:
> ffffffff90346188 (hmem_resource_lock){+.+.}-{4:4}, at: hmem_register_resource+0x31/0x50
> 
> but task is already holding lock:
> ffffffff90338890 ((node_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x2e/0x70
> 
> which lock already depends on the new lock.
> [..]
> Chain exists of:
>   hmem_resource_lock --> mem_hotplug_lock --> (node_chain).rwsem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   rlock((node_chain).rwsem);
>                                lock(mem_hotplug_lock);
>                                lock((node_chain).rwsem);
>   lock(hmem_resource_lock);
> 
> The lock ordering can cause potential deadlock. There are instances
> where hmem_resource_lock is taken after (node_chain).rwsem, and vice
> versa.
> 
> Remove registering of target devices from the hmat_callback(). By the
> time the hmat hotplug notifier is being called, there should not be
> hmem targets that still need to be registered.
> 
> Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
> Link: https://lore.kernel.org/nvdimm/68e46a09c2a07_2980100f3@dwillia2-mobl4.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Drop target registering in hmat_callback instead. (Dan)
> ---
>  drivers/acpi/numa/hmat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 5a36d57289b4..5084ae1688f6 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -874,7 +874,8 @@ static void hmat_register_target_devices(struct memory_target *target)
>  	}
>  }
>  
> -static void hmat_register_target(struct memory_target *target)
> +static void hmat_register_target(struct memory_target *target,
> +				 bool register_devices)
>  {
>  	int nid = pxm_to_node(target->memory_pxm);
>  
> @@ -882,7 +883,8 @@ static void hmat_register_target(struct memory_target *target)
>  	 * Devices may belong to either an offline or online
>  	 * node, so unconditionally add them.
>  	 */
> -	hmat_register_target_devices(target);
> +	if (register_devices)
> +		hmat_register_target_devices(target);

Why a new flag to pass around and not something like:

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 5a36d57289b4..9f9f09480765 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -867,6 +867,9 @@ static void hmat_register_target_devices(struct memory_target *target)
        if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
                return;
 
+       if (target->registered)
+               return;
+
        for (res = target->memregions.child; res; res = res->sibling) {
                int target_nid = pxm_to_node(target->memory_pxm);
 

...?

