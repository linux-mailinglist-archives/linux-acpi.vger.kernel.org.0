Return-Path: <linux-acpi+bounces-13865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD1FAC27A7
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC87BF1B2
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237FC297B71;
	Fri, 23 May 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QolIbKG7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE229373F;
	Fri, 23 May 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017604; cv=fail; b=YZPeP6ReHMltSgqgzUMRUYwFkeRq+9xd7Y1kWtkYMA/s2LmTCHiFhyBJWNFUMFowWPnoIYj4jrRgWM0r5vimhcJlgcdJaOvMw7jLAsbJ9ZLIi6vp0HzRsbAA5b8ysvOzSou0Zxo76eXj7p9NN4I4lgDgfFchH3TmxmgKXERPsS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017604; c=relaxed/simple;
	bh=LKthaKlOLiDUMtEkxQt+uUMhWbteM8j702e7DB2fgHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fond2z0io+UM5HKZ9T4F1G9IUtv8Nr6WpCvP7wqsUiVShoQ4rvASQJ0g/evO9E0DfO2f4rE6+4iaECMBZGxUiV2LLJ9nUJrj3L8atg/DjMY+eMx8Mp9b/vOeZn0yiPFGJ/FTqHWF2z/wOg/KBCZYY7YdABf+F4fcRMe5xnfO7wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QolIbKG7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748017602; x=1779553602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LKthaKlOLiDUMtEkxQt+uUMhWbteM8j702e7DB2fgHc=;
  b=QolIbKG7QpwaDh2xFKcAP6MQK1+qXegzWy16UJ458setSjXkpKuoih+x
   l5OCFuQpIWooHW2rVgwqBRCxpMT6CFm26euZPnuy61fnnyEZMzY3Nycyc
   ha36OA3XrIGHy6UmIaHUusZc7JDVKFkB6FVftAyKXkV6nNXuu7sSg9qmL
   UB5YD3skaIc+9hA0nJDthGw8NWsvV/3lCcWuUTZwEF1g7ju+5EcFdBtTh
   vsBK+7vC4NQB0yUamM78ryfsqh3MzzUWedbgPLYh5gJLeedmK/b7wK05x
   9sr5njtHg14SL0l+rxYRNWi8qllmOw2Q4FiaJuuLLeM28UYoDagX0XijP
   g==;
X-CSE-ConnectionGUID: 1nJ1yC3lStCvQUheidrnAg==
X-CSE-MsgGUID: 57haMqXOSvCCH2+qD1EOVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50002905"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="50002905"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:26:41 -0700
X-CSE-ConnectionGUID: 0rVEavF+Q16ZLpqaJDFXiQ==
X-CSE-MsgGUID: gGidQqmKTMKloO5zxaqv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="142155522"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:26:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 09:26:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 09:26:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 09:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpGPWO1vgir/i/KPh6Q+ytiuwpniD/geeBXZMmqAe166trgXg8B7EtJCmx84SWLaDc+Ye61BTPIMyXMJkyoFvzc8VcVr9ZYE2GJctF64RFZc+aPjxnTSpaiWspTwkx4+v+WhtCx4EgGVccVf33gv5EXBrZ3/InPe+ZsMau3msx9zi5GMXqJ2yyOhg2iWdTIs3JZnENS5ecFkwGzESuqaKs4avaCy4Zql2Wo4hDl0BP/STk3y9ej7GSIgahb7y90CMb2KAlj/bdr8u9E9yybTlLzX5PoHDrUVCFk4yZZCsxtP/I23Cl6wKR4D3fcZOAF2pm8Ykr3PhJoZOevSAZCZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKthaKlOLiDUMtEkxQt+uUMhWbteM8j702e7DB2fgHc=;
 b=HvmtIUf7apVeQ62uewqEJPIiVCJbsF3XIOeSZuhQqyOdj6vj7eDI436AVaKayNceyy7u8i/qhBmcTvboDGNeFEGvaBj+qpjSxl9jFFZaC6RvkpFdLNXI4PbkCyFQiH0bNLzJHbzjJcFlH7Q5aVskxmBNw6keC5NBCcuvuYcgplzvA3FpGIDoC+0v2A3f2RoGFWZqlZNBFeZNjTqZaeUhK/U5UeKNjoLjC3UMIhUgb8a2pyqoJRz4PBQgIX9B0rDmg0mJ1COj75RJ7YWymywVOSYpBW5ejW57IqtytEZujBC5zuApfgCBWznwo+VbHpsPg2s4szakP/Js/TLmr4RuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS4PPF708A6BB3E.namprd11.prod.outlook.com (2603:10b6:f:fc02::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 16:26:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 16:26:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v5 1/3] ACPI/MRRM: Minimal parse of ACPI MRRM table
Thread-Topic: [PATCH v5 1/3] ACPI/MRRM: Minimal parse of ACPI MRRM table
Thread-Index: AQHbveSITDJ/qjk5skyK6eqzx7Fcc7Pgf2kAgAAC2RA=
Date: Fri, 23 May 2025 16:26:38 +0000
Message-ID: <SJ1PR11MB6083AA31D763B103D8296438FC98A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250505173819.419271-1-tony.luck@intel.com>
 <20250505173819.419271-2-tony.luck@intel.com>
 <8f7266ee-bc45-4d2a-ae23-140b1e3d455d@intel.com>
In-Reply-To: <8f7266ee-bc45-4d2a-ae23-140b1e3d455d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS4PPF708A6BB3E:EE_
x-ms-office365-filtering-correlation-id: a1a96580-aa96-43d2-72ce-08dd9a16981f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHAwWmR0ejFlMnN0WTZBNC9jalhBOTRmV1NDUjFoU0V2WGtGdm1Dd05Fdzhu?=
 =?utf-8?B?ZzJGbmdTU2Fkb21SM1pIT2xLUHl5MTJJQ0J1TDJBdk5QRzl4SUsxbjJFWmI4?=
 =?utf-8?B?WjZ3NnFkeUNrSVFZV20vc1hGTmlES3JLL1dOUWhiTE9yaVZzQzF6ZFJTOGda?=
 =?utf-8?B?SnNxcEZMN2g0aVRzVFJ1MktBZXlFQ3NsUktmMDhERVc5ZHFTc25nNXhzaUZC?=
 =?utf-8?B?cDdPMUhnSU1aWS9nVm5IbUpZcURFZlRjaFROc2l4NVFPdGpRb05yRlUwbU9S?=
 =?utf-8?B?Y1pHRGNwQjJ5b1A4TUtpRXFPeXNnVFJaR0dzelNSZHgrMGtONW5XMmIrbC9m?=
 =?utf-8?B?eCtoL0RKR0p3UWFmZnU5cjNka0xQSDBCbTFnUXlYazRUSGxhcDZiL1NiRklj?=
 =?utf-8?B?Nmx6TE0rMDVuai9rQjF0TTVSVkM2TUlla1ljb012ZXhNcFRIeE9pMVAwZ2sw?=
 =?utf-8?B?WmM4OFVqU2kvSU5OamwxSEQxSUYxcG5LWWd6N2d5TDUvUGN0Q3Zabjd2WkVK?=
 =?utf-8?B?UW13RW55Q09lT2ZWMlRJclN4cDMraFVCaEFZalFaYkFRdGpOalhmenlibVJU?=
 =?utf-8?B?dW8ycWMxbktIajBuYnptcHZJd1VQTUlWcFl4enFUSWl4a09CYktiZ1dReVZz?=
 =?utf-8?B?ZFJiM0t3aEQ1T1BLT3NhSUp5T2lRWXFZcWFoUkRBZlhZcEJKYlFLZGhuY09a?=
 =?utf-8?B?Nmw3MlVKUE1TS043WWQrRHJsckdUVWxCQVcvK3dGQk1BNldXUERuNXhRc2pP?=
 =?utf-8?B?S291Y1dlZll1T2xBcjZZcDBpeFB2SVpKS2tmRXhrbGZYRnNEb0NBVGZWMHVD?=
 =?utf-8?B?M3ZOU2xDeXI0VTVSMWpQN2M5bUIwaXJOT204MHlMOXBDWE9yRzREYVFTZGZM?=
 =?utf-8?B?TnRnV0djQXVsUTREWFlJbWd5OFc5dHROSkQxeFc0ZlV4cllud3lJanhKRUEv?=
 =?utf-8?B?Z1E5OWdjZ1RaaHJrdzNXK0NlME5wQVEwQmd4TE5Id2JwOUJZNHFCZUcrUHo0?=
 =?utf-8?B?YmlJNFFpdDhkTit3M3RoaHBaSG45QlNiWXhhQndDTU91WnBYWkk0eHU3TTR3?=
 =?utf-8?B?VlhjWmd4SkhCTjI3UENOM0dCTlFxSld3UHVsTkV3b0V3T29WYWgzcmQvcU1Q?=
 =?utf-8?B?bnNWNWtZZkp4dG5CclJPRThGclBHUVJDSzVCVU9MQjMyaHM4c2RoazY3TUNi?=
 =?utf-8?B?SlovSVNhaDU4N2ZRSk9TSk5xY0ZsMFB2WlhPaU0rZUl1NHF4Q3VuNGFkZVBB?=
 =?utf-8?B?Ly9RdnRDZEJHWWJ6NCtJbFhqVS9KRUQzUTlTc3Z5ZlQ2VkxXaHdGYXJ0M0cr?=
 =?utf-8?B?T3RUNVJLRnVPY3hUbFh4OXNaRDlvOHVaRWh1M3JMM2dmbTF6eXJGUmp2VU4z?=
 =?utf-8?B?cDdVbmRuRTFJN2JUam1vaGJCOXUwR253YWxPTWV0ZTVtZktFQU8xUTlVUHRD?=
 =?utf-8?B?UnRnWGJZNkJKRVc2NHFQQzM4dC9xajVOWnhvbnlMdWRUMVVSbEJMNDFGMTFi?=
 =?utf-8?B?azBtby95SWtDRGpXNzZxS2NpRE9ZYkdmeEpNbUQ5WHkrcVN4ODZmb0hoT3Nt?=
 =?utf-8?B?YlYvbEhDelozdDR5ME9tUnhhYjhVbStMK1NSYkRlMjlrK2hvNUZmcEhIYVFJ?=
 =?utf-8?B?U0Z3S0gwZlVjSGh5UzRRUVA2cmdsK1JQR0pKUkRmMzZUb0xraGdDQWZGdVRY?=
 =?utf-8?B?dFZYbXJqaDZXZVYrOEFHUkZ6UzFrRHpNbzk3Nm9oMmluT1RZQmVYa1FHeGor?=
 =?utf-8?B?a2F3ME5yWHNRQk8xd0dDMnBMeE1hTnkyTFE1dVo4Tkw2NjhRdWhJcVk4ZG5W?=
 =?utf-8?B?Kzh1U1JkeTJJU3ZSOVovdWtJc1JqbmI0cnJEQ3l0MmQwekRPZHptcDBOQTl1?=
 =?utf-8?B?eWIraHZoWkxyOGRqdXNFa283dDlRMUN5MTdnRkNWQVZma3k2Q1ZsejJLbGZ3?=
 =?utf-8?B?d003SlpPU09xdXVtdnFsM0JLRUs2TWNpUDNLU3Z3RC93dGZSclgyWlMzaDFy?=
 =?utf-8?B?U1VYU3d5UGp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q09wVFI0VWFmSW9UcG43RGhtTjlSc0ZkOTNGUXBnMHhIY2dTY0l2b1ZkRUxp?=
 =?utf-8?B?ZGZZKzNiL1puVWdpOFZqUFFrSG93SUgzbi8veUQ4bUVYYVcwMnlDZ0x0S3Nn?=
 =?utf-8?B?MFpTbE56cjVmcStaQ3JsZzBGS21oWk5aVnMrYW5YSm5hMUJTb1Zoai93dXBG?=
 =?utf-8?B?dDBXYTRIZmJxRkNiSlF1ZG8xTXJKT3VaMGlCQ0szaW1kbmVld0NNcVZ3MDhB?=
 =?utf-8?B?WWFTaUdldTVZSFhLaFVMMk9oYUF4WWhQV3EvVjJ4SDlKQzZYZGhTVkI2Ykto?=
 =?utf-8?B?MUg0NHFUVlFhcFdRMDJFNXVDOUwzbkNZWG5VcTFFR1kzY2dhaUsxZ0hHNTNX?=
 =?utf-8?B?OFFhK0M5bVd5TFJOTzFnKzNoYmdRMStwRWprNTNra1o3UWs2OFJ3ZkZOd3lr?=
 =?utf-8?B?ZG56TUsrS1A0cHFTdkNsNUlLOU9XWHhqa0ltY0IvbG9rVnBuc0RHTkFxcGVx?=
 =?utf-8?B?SVhGcUxtSU1RdjNHMmx3R2hLbXJIamRNSnZmMWZnTUV1eFRZeUxCZTBIeTY0?=
 =?utf-8?B?M09zdllUdm9qK0ZiSmVLYnJlOUF3cmw4ZCt4Vll6azFwZE1WS2tOeEw2Nkx6?=
 =?utf-8?B?cC93TnZFazgwNmpqa0FMYmdjUkRudWdkQXZRSGNvSlYwbytWUHBubGp3MFhz?=
 =?utf-8?B?VkwxbW5LcVJqcXYrYUpBV0x2akFic1Ezd0VFdlV0NzRsSlBhSDRma0E4ZFJO?=
 =?utf-8?B?NHZDS1Qzb0ZSc1pkTTdkdTIxVEdSZnZGL2FPbFhiaEZLNE5JTHhLNDNtb2Vn?=
 =?utf-8?B?U1JMVmdrZEUydHF6aDE3aHhtTEdrT1ExZW1kTS9EcHJTMTVHQTdCMlFoTXFE?=
 =?utf-8?B?QTlScDExSm80aGVqWlNYbEFNLy9WalZUdFhIT01qZCswRENMbm5nRTk5ZXlO?=
 =?utf-8?B?a1VScU1mYlBjUzVTdnY4SHE1TzJUcmpYd2lZeDI1YW8xaDZ2ZjVjRDhPeXhS?=
 =?utf-8?B?UW9PWUIzT0NMczRDenROSzdHMlNNcnZ5aHc3azY1aTFZNm9FQWozNTRGa2hi?=
 =?utf-8?B?Q3RQTzBPK0tPUHRPUWwvT2J2c3pCQWExcjEySDI1TWZnVThRTkJsNjV4VzlK?=
 =?utf-8?B?OHVRa3lxVkNtUzk5aDlMaklWSndXTm8rZURsbmVmSk1ZUjY5YVNGZzJEbHgz?=
 =?utf-8?B?Z095MVQrM0NGQ2VIVHM5SGlUQkttcTJaNVhtSFpuZ2tjdHRnYmpoS1pZSHEy?=
 =?utf-8?B?L0ZxNTlNSmhoTkVpRlVyK0l1bU95Z2hVUnF6NkRXak5nTGk1bjhUUUNNVXVp?=
 =?utf-8?B?WTFHNzdPbGJyektCVG1JQXR2MTZKQVhTdmxiQ1BqNldlVWkxaDNtY2hHZTE4?=
 =?utf-8?B?ZllKOWlyb0pUa0hqQnJob1VIU0VDbFpIRVJMTXFPVUQ1SStMM0FDOUU4VllQ?=
 =?utf-8?B?VElha2hHUFRkRHd6bHdaN253ZmZIRlJlajE4MVNZOS8wemlzRHE3MWZFWUV0?=
 =?utf-8?B?SVJCaVdHclVqNUk2aXJHQlJrZDM5VVZzZ0Z3d1J6dFl2VkgzcVJudVNTTk9R?=
 =?utf-8?B?QTUvOHlHbVlMbUFLcVJJRUoyNHpXM2VZOUVXL1FweUhUeC9CaGY0bnJOTHBl?=
 =?utf-8?B?NHFXSDlpR0NQczVpMXVNb2R5OFNDYnR0VHo2b3FHR0Q3UUFUWCswZU1hdnI0?=
 =?utf-8?B?d2lCTXhjYVRwaGNpSmZQQUFXbXRlRnFKVThHTjFhd2RCeVNnRTdHTVdCZzJ0?=
 =?utf-8?B?TzAxdG5NSVVJR3FRZC95aWtIbklTVG9Yb2p3cjZtalNuV2h1RVFZTm82Nk1T?=
 =?utf-8?B?Zk44N0RSMEk1WnJhUlBpNkJodExnQTNwZFRpZVRaRXJGQmFTU1hla1I1SFlu?=
 =?utf-8?B?aFlVVUNlQlc3SVJMd2JEcUMzUkxVWm8rRlBJMVZteGJONVVpdmRPK2ZCWEJU?=
 =?utf-8?B?TjdIWldnb2lxSkFQWi9BTktqSXVRZ3FLV0hoczlKSm4rcDFHQjRZaFlaWlBz?=
 =?utf-8?B?TTBFZ0RJMk9Vc3RleWJPOGJmN054UTk5NFpqdW9hd2ZQVzQwbEhFUlVaMFZI?=
 =?utf-8?B?dFpzbVZsZ1VhcTlvT2RvdnlNODQ3UTJHYkVBYlFmeGpjOHVkVXlrSHFMcDlT?=
 =?utf-8?B?K2h2cStqWDRROHdSODRtL2Q5TkxZek1zb3p0TDd1Z3A5VmdQMGFpdUZFSzRo?=
 =?utf-8?Q?Kwr9ZG8QsrxJFE2Q9ZdcRDC8E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a96580-aa96-43d2-72ce-08dd9a16981f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 16:26:38.8525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA8J9WP9riXctkqhJM7ClS7sY05zbap9/WRrjiyC+qJiYYrV+j+NsCanwhnZdyLvnUiekHPV40B7Unec7OHTpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF708A6BB3E
X-OriginatorOrg: intel.com

PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfbXJybS5jIGIvZHJpdmVycy9hY3BpL2Fj
cGlfbXJybS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4u
YWI4MDIyZTU4ZGE1DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9hY3BpL2FjcGlf
bXJybS5jDQo+IEBAIC0wLDAgKzEsNDIgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChjKSAyMDI1LCBJbnRlbCBDb3Jwb3Jh
dGlvbi4NCj4gKyAqDQo+ICsgKiBNZW1vcnkgUmFuZ2UgYW5kIFJlZ2lvbiBNYXBwaW5nIChNUlJN
KSBzdHJ1Y3R1cmUNCj4gKyAqLw0KPiArDQo+ICsjZGVmaW5lIHByX2ZtdChmbXQpICJhY3BpL21y
cm06ICIgZm10DQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9hY3BpLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvaW5pdC5oPg0KPiArDQo+ICtzdGF0aWMgaW50IG1heF9tZW1fcmVnaW9uID0gLUVOT0VO
VDsNCj4gVGhpcyBzaG91bGQgYmUgaW5pdGlhbGl6ZWQgdG8gMSBpbnN0ZWFkIG9mIC1FTk9FTlQo
LTIpLg0KPiBQZXIgdGhlIHNwZWMsIHNlYyA1LjEsIGlmIHBsYXRmb3JtIGRvZXMgbm90IGRlZmlu
ZSBNUlJNLCBpdCBzYXlzLCBTVyBtYXkgYXNzdW1lIHRoYXQgb25seSBvbmUgbWVtb3J5IHJlZ2lv
biBpcyBkZWZpbmVkLg0KPg0KPiArDQo+ICsvKiBBY2Nlc3MgZm9yIHVzZSBieSByZXNjdHJsIGZp
bGUgc3lzdGVtICovDQo+ICtpbnQgYWNwaV9tcnJtX21heF9tZW1fcmVnaW9uKHZvaWQpDQo+ICt7
DQo+ICsgICAgIHJldHVybiBtYXhfbWVtX3JlZ2lvbjsNCj4gK30NCj4gSW4gd2hpY2ggY2FzZSB0
aGlzIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIGEgbWluaW11bSBvZiAxIHJlZ2lvbiBhcyBtYXhfbWVt
X3JlZ2lvbiBvZiAtMiBoYXMgbm8gbWVhbmluZy4NCj4gV2hlbiByZXNjdHJsIGZpbGUgc3lzdGVt
IGNhbGxzIHRoaXMgZnVuY3Rpb24sIGl0IGV4cGVjdHMgYXQgbGVhc3Qgb25lIHJlZ2lvbiBleGlz
dHMuDQoNCltSZXBseWluZyB0byBIVE1MIGUtbWFpbCB0aGF0IHdpbGwgaGF2ZSBiZWVuIGRyb3Bw
ZWQgZnJvbSBMS01MIGFuZCBvdGhlciBsaXN0c10NCg0KQW5pbCwNCg0KUmFmYWVsIGhhcyB0aGlz
IHF1ZXVlZCBmb3IgbmV4dCBtZXJnZSB3aW5kb3cuIFBsZWFzZSBzZW5kIGEgcGF0Y2ggdG8NCmZp
eCB0aGUgaXNzdWVzIHlvdSBmb3VuZC4NCg0KVGhhbmtzDQoNCi1Ub255DQo=

