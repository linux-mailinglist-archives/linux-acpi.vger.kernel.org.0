Return-Path: <linux-acpi+bounces-14667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D971AAE9391
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 03:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D5D188C3A0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01722157493;
	Thu, 26 Jun 2025 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2NliNVE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0312F1FF1;
	Thu, 26 Jun 2025 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899831; cv=fail; b=ZGTDd36FJQ4bJcsayPXj7FflOAlQQ0COlq6wxbsNQJlqQLSl5GO5OBjIReMVioopaqAKUlOU49AqutCgYb8znUR83Ew7VhSK4aRy3bTtzzrnMSWCZLTpSfhDqZhg+BTEijPXO8eWIkE+mgACVI0c5S0MC9hh96i6B+sv6mP063M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899831; c=relaxed/simple;
	bh=jtXPTKsiCXYhBWIUkDcapLni2QU7yICASGShaEIDhsg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=so9QvdsRfX8/LiIeqROC11x6fIQNHbmaIK5APrEcgYR+jzt4hGw5ofUltTegtHBvnw4Mvlbt8cBjrZVdmSOf3OpAKyHi/IdyJ2hwzX8StC+kHEajF4HubePQRHwsM75ZJ7YUN/MOQ+DSMeygttZNlRAMOe7ox+yU4Z7iJmpoFoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2NliNVE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750899829; x=1782435829;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jtXPTKsiCXYhBWIUkDcapLni2QU7yICASGShaEIDhsg=;
  b=E2NliNVEtrbggGbeJDJXNlQ89jxHIm13LWnhWahOuDzZLLhas/SiVR+J
   OnmDyogvQyJUMLAKIiAKH+8d5PRGI3fPI7MSm8n5A2KNmR+S44tkfWkcN
   Mqb1xHKGFne8wzVb0epnQlaIK6F8LTLJ5TS27bTj73bHveHQoVCzoPfYU
   iGyXzsUf+c2aT7M8Bdrdqo8nudJWS+j+l3FYwyNld8vrvEml1hWtxT3vL
   65XauKMAK5u6W4xpOLEOhK0zPAE8KR+KRtwpm8netc3dTX9+VD90ssX9m
   ZadOASZxHTrtPuzGtQMyVzeECv7MXFJSA1ArdnyRtDaoiJPlenFD3CSQv
   w==;
X-CSE-ConnectionGUID: sAD/I7DrR5i3IFMUjxh6zA==
X-CSE-MsgGUID: aDS/4+hpREiZ8DbGOyPQnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55812410"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55812410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 18:03:48 -0700
X-CSE-ConnectionGUID: dZdx0Q/kQmm0F5+YsCRg+Q==
X-CSE-MsgGUID: vG3q/39XRXirlL2mBl4Y1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="151986889"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 18:03:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 18:03:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 18:03:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 18:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiQ6+lccChhkIEGjuta/wIxvFqUKNXSsmM8goYfd/V0JGcaBKxphnYABdKv/8Ez15F81a4OFncLgoEplfDvhStH+WmF3GGl28XhwR6L3o9NeQQ805xKvTL1wCOUt7feGXpB5H6prxoen93X6Gm4lRt8ox1UPYVF8SJpZ0sEg/6/88CTw63Mt10ltEs+UWcWhZfKe3XEjKoz1QJPwUMsLG7mNdiZQ6SmtrPfEHZEjlwTpLFN4fblEcpTAf+WimlFwXUVp3h7447hT0t7DUJIFHfqn7PHLmeRuhS3p2QVeBO1W1WHME6eESR9my4kEqdHp9koIxfPzkuVmXWU1N3Gr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9ZeS2dfQbJmZqNbk7DvehYi8KtPx8Z7e8ckRK5jZhU=;
 b=GWs82GOWjUZh9azlkNwsuPIoV4fx7POsfqaDC/owqgCEa012RJ/HuHT8i+hERVqiuknSKcyNJVBRlXbCGbfMSmGZ2Sh9p/YwhAcfskxOvaciFLUjh2NJDBYg3veenxSQ1zPAx/BojM/bhS1y6FY++knLc57aoiMVcRpSCRAyzhti2R1U/LTEjff8mHKffAhqz+iyLUFgTT5Y8pyP0N8G1PaAeI6jI8BdvycQ+e2xSUD25Xep5lvkYnYOuvcmozN3ScjsDMVnWt8rbmutOW+AdqlOi4VCHC/AFDyc6/fb+ezF1OEI8lZHQEFzrWUII7Mp4do+NfsnyriDWZR8OWCPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 01:03:16 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 01:03:15 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 25 Jun 2025 18:03:13 -0700
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook
	<kees@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>
CC: <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <linux-hardening@vger.kernel.org>
Message-ID: <685c9c515ffd8_1608bd1004d@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aFxtOLs6Yv_uzgt4@kspp>
References: <aFxtOLs6Yv_uzgt4@kspp>
Subject: Re: [PATCH v4][for-next/hardening] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 61df2412-f74c-48a1-e8a6-08ddb44d3b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUVadG44UjZpU1ZVemlRYWRsejdHcVlqOTUxSVBZK29MMTU5Z20vcmZUeWRS?=
 =?utf-8?B?NDc0eFoyOXB6QU9jQk1zVUhJOEY3NFhJbk5aVmkxbVdJS1JPbHlmSmVuTGhW?=
 =?utf-8?B?eGVvMlZEOGd2NGcwY0haazFrbU93QWgvSjA1K3JNSlNZOFBaSkg0cGpyN2tP?=
 =?utf-8?B?dVp4OFBnakVDMU12bGNkZjNtMldlQ2pjS2ZwMnViVGRiYVhQTVJZaXhtZUYw?=
 =?utf-8?B?K1lmQllBb1Y1TTIyb1RuL3lzbUp3VzRIN3c0Vjgxd2NES1RzTjAyekw2Vzlr?=
 =?utf-8?B?OTRJeWdIZ1VNZ2NTSU9xR3FOaFZTa3hEZXVSZmU4clMrbWRGUERCZ2liVXcw?=
 =?utf-8?B?NERhY0t6YUVQOGVXS001cGpPZWNhK0hLN05lNlpXUzZTNC9ZdTkwUjJwdGJB?=
 =?utf-8?B?ZDVwOUNhWGJqbXpJbmk3a3FiY01UcGg1alVYNXVGUEk4dXhtVlBrMjhhWEU3?=
 =?utf-8?B?QXc0NFFnZXVKTmJGdlZCN3BPY3NzMmJtQmZpY2xTSERKVmZGc0RrWHFWcWtD?=
 =?utf-8?B?c1lBZFlsdzRBRG9mT1A2ZC82N2RjTHNGT3Q1RFpVMlZKRk5QL2hZSllkUXVs?=
 =?utf-8?B?RnVrc3RjUjNRYXB1b09VYUJDV0hOcC8yQkZWU0I2aG9VNTBNVWpWMitsWDFa?=
 =?utf-8?B?UjBBbUhYaE0zVTJ6enJ0K0wwNG9Cb3ZtbHc3bTJNUzl0bDBzWGo0TDNzSm1q?=
 =?utf-8?B?Nm9PaFdTSE14VStpRFlwUmJJbVJUVkloZFZibjA1NlE2cGpjRUNSU3hYZUxC?=
 =?utf-8?B?SjZmU1F4YUxNS05DL2V4YTF5amFjYVhXUHp1OVpjVzRRZjlXZXczSy90Uld5?=
 =?utf-8?B?QnVlWWVGb3hmWG00aGdCMmFTeG4vNG8yM20zRnJCSjlrd2NXUkFLUkQ1cnRr?=
 =?utf-8?B?d0JOWEJrb1BnYkY4MWtXM0ZsM0tDV0lOaU1aZDRiZzg0TkZKZFVSdXBMUWZL?=
 =?utf-8?B?Ly9oWGNFbyt3VHZWOEg5RUE0ODMrSmRtWnlqMFJVdkNHTWdtNExYdXlxR0J4?=
 =?utf-8?B?QmxablgycEF3a3U0R3A3VnhYMXYwZzVBM2JSYis4d2Y1QytQaFRCWmM5MytI?=
 =?utf-8?B?VEQ4VmZBWlpaait1aVE4Vk1rbXNkQUsrbUpYVzdmeFlocFVuVnpCWGtPYXZK?=
 =?utf-8?B?WkpxUkpQWS9kOWNoWWFUMENmMjVIMWcySW5EaFhRaW9Ud2tnZnZCRUR5T0ll?=
 =?utf-8?B?a1VobW1aQ09EdTBMYzhJeUlUeWVWcHZ1MTI4K3k0RUpUMDRCQ21jR29ncjBw?=
 =?utf-8?B?NFc2dHJVamQ4c3pCVzhVRE51cEhQS0piZjZRNkIwOGNkbFczK0Nzd2puQklM?=
 =?utf-8?B?enJkczZOazRjbko4SmdWTFRldXJ4UGdvWXpDeThYSFJPNXdmWGN4Mk1oNWlY?=
 =?utf-8?B?YkkwNWp6ckc4OXNUdGNNZndFam9pdElXTHEwZWZOazM3TGcrbUF0VXRFVGFY?=
 =?utf-8?B?MjROM1k2ZXU4OHU1UTQ1V0dzSzBxSGFUMWFPOWtJMHlmL056dnRLZ2hPT3ox?=
 =?utf-8?B?L084RjZvdTRYNlJRd05yRUNFcEREYkw5R2k1L24wNUtqTldVOUpvNG9raXRT?=
 =?utf-8?B?OVNuOEZFTnBiUjRNMC8yN1IzYUVRTXVkd2ZWZ1NWTmR5KzhjRmhPRVhnV1Z2?=
 =?utf-8?B?L3Fya3lOb2VCZG4rSFBaSkZKMGl5ZVA2UVRkVGV2T1Vjdm5SSjc3azhYMDVY?=
 =?utf-8?B?THppUUtlNGlqU2NHUVJIOUNBZ0g2WEs5MTVCaUFLU0xzWVNGa3lya3p2c2Zq?=
 =?utf-8?B?MzExcW5lZzFGS1JtLytLRTAwNmhUTDBGSWV4TUlCazArN3hsTW4wemtRUm1W?=
 =?utf-8?B?ZVNQOTZlanBoOUdnZC9ieDZmU1NkVjNDcmFhTnNROHdLQ0h1aThEcGZJb0FC?=
 =?utf-8?B?RTlaQ0NTYjlWMi9leGlGaHhDMitoRXgwTFIvYXNGTXJ6ako5RlZGdGRNUXNv?=
 =?utf-8?Q?LGug5AfQTQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHAxMGkwSGViWTFHbEVoT3B5ZEVNcXlWOHdnWVRZckJUMlkrMldSTjRUaldn?=
 =?utf-8?B?azJMS2VzblpUSGplVWFpeXhKY0xuOHhDaEtMTGR2aVJPd29lbEJ2RXpFcHJ1?=
 =?utf-8?B?L0xTNU1YK0dvcXZNWWM5RUR1T3BkVmVSaWwwMWRRTHArNWs1azQ4WkNOS1lJ?=
 =?utf-8?B?RWc2d2NWOWRacXE2cFhaT1dJd3RtSmE4RzZJSVNvbjROTlVSS241R3d0eGpx?=
 =?utf-8?B?VWtTc0xzTWx2Rm5rUVBvaE9mT1dvaTRybjJDYS9peVdXVDdVWFRaK0pJeHoz?=
 =?utf-8?B?emNzM2p3VWM1MllTM0xFeExLSS9GWDJES3Z3NXpLOXhlOUdRT2Zzd1A5T25Y?=
 =?utf-8?B?Y0FTWTRIK0MzN2JUNHFLbmdpSFBUbjd5Z2kxQSsyTFUzRTNLTERkNWNYaE9M?=
 =?utf-8?B?NmF2RGw0YlRiZkxEclBrdTM5YmxVRmgzVUVJT1BKUlBjRVp4Z29Ybno3U0Ux?=
 =?utf-8?B?dW5OUGV4Z2tqN2IwUkM3VjZWRWh4dHNQaFJaY1FoWHl6SGR0dEVuc2xRRFE0?=
 =?utf-8?B?MEU4b1Q4OENEcTViV0dJc0tJdllNMGs5cVNGZmQ3VUZzMElCWVZva3VtSGZB?=
 =?utf-8?B?ZExHOUR5cC9NaXdlS1M5Q3pOWkFDdTBWanRCcEY0Ly9MbkFHWHB6WUVTNWgx?=
 =?utf-8?B?dzZpejBmTys0WkdCeXRxblUreUtLN0xPdjRLakhTQU5mMjdkSlVtUDFjMzY3?=
 =?utf-8?B?b1hRRkVUM3JPT0hHZ0JoajNRUDJCcjR2Tm5RZmJCbWlFUFR3Si9Qc1c5eE41?=
 =?utf-8?B?VzlHaEw2cmFlYTNKV2hlbnlvdkhVclpJRDFVVUJYeEZ2NVFDNGcwaWdvMjRq?=
 =?utf-8?B?ZWE1VFNxQi9JZHk4bXhxNFh6Q1FySmpZT1c4NlVHeHhnbVE2aGVwZWxIdlJx?=
 =?utf-8?B?a3VZaGxPU2JBSERjYmZGQ3lhdGcrNWZVQjNkSXN5bE1SdTRCMGVUT3ZsS3hG?=
 =?utf-8?B?TWpabmhMM0E2U0wzNWRsckJNU2d0R3ZIcFkrZWRDUjFucExCZkxwSFI5bm80?=
 =?utf-8?B?MGxsQXRoTGI3YXZzUGt5OFBPMEhlSGM0bGJRTmtqdlU1SFNCd0ZoZUd3c1V5?=
 =?utf-8?B?ejBYNzFTSjMzNkVFMG9WTnE5UzBHeU9ra2hhTEVKUmpHR08za1A4ZUlXTDF4?=
 =?utf-8?B?WFRadjBzUEVsbVNDNTh1WEJHNUlmaFBTclBLWklnTnNwd0I5by91dzVSN1BM?=
 =?utf-8?B?YU4zK1N4QjI1bWcrMjhOcFJBOTJNQU54RzdpT2pwUS91cmhsckkrVXJKSUxW?=
 =?utf-8?B?MW5GMEtrblZpUlEvNENQNUVHRm42RXBrY2JYNFhSU0VsR0o3KzY2MUhHZlBQ?=
 =?utf-8?B?VHlQeWJvY0xiWDJUVmcxUWlCRU1qZ1pWQWJ2bXdDK2hjU1dldk96eGZlemll?=
 =?utf-8?B?eDBicGZpbG40eUV2ek4rOXVXVkViOFJRK3VrZHJETTlDMGZxL0pNKzhreXFl?=
 =?utf-8?B?MW9KVDIxckhJYXVaYmdna1hiUjFDZWsyOGhFcStvWStMd3hLVTJPdXBXcjZO?=
 =?utf-8?B?b1RWOVA1ZjZXcHRuMWU3VkNrWko5MG9sNU50NUJsR0RlWGcvTkU3TC9IVDJz?=
 =?utf-8?B?YWlpWnRDMUE5QzEyWVNsajMzbEIxWEdWRnRKK1luNU5vb1hyNzRoUjR5cEtM?=
 =?utf-8?B?eG90YjFXVnBBZzVTNGg2aWczZnMxa2RUNHFkbjVDbzBKNHNmYTE0YytvOTRN?=
 =?utf-8?B?UllmRmFpeEYvcXlycE5zcVNscys3RWxSaVVjb2FwQ0tqdWxndmI5T3k0ckU5?=
 =?utf-8?B?V2NROWw2S01YTVdmb1NXU1V2Y3Bnc0JLbmRGVkR0V2tFV09aVUNheE9Iczdx?=
 =?utf-8?B?OU13STVHdndIL3JrbVpkalJiWjdhYng2eEw3ckN4SEJDNWhObVlCWE95ZEN2?=
 =?utf-8?B?WUV5K0U3dU1wamFVUk5CRjd5MUZ2R3JFNWhkc2JLemlEMGErdEtDOU85UUtj?=
 =?utf-8?B?TUFwOGljME04U2YzZXdJM2ZRcnlmZzVJSFpkUk9HalgrK2RzZzFVUS9Eb1N4?=
 =?utf-8?B?MmlzTzNYM2QwUi93cHUyYmdQWXE4RTlKS0JWQmIyQ01sYVFyeFJncXYxU3RO?=
 =?utf-8?B?SVFxdjdyU3lhaURFeTl2L3JqVG9yajA1cXBwMDArTk9NMnQ3OW5NREw4ZzUv?=
 =?utf-8?B?ZWNTMHFHcUVvaGhrRnBZWERYbXo0eElQYWZaT1RLZXZnZktNRnBGNHVVdDRq?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61df2412-f74c-48a1-e8a6-08ddb44d3b1b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 01:03:15.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEyabyW6PAAyoq4FxOwL/uI1F5n9vDEJZnnelVFuYQNVhx2C+ae9or4ltY9+wzNq1c4VgTySqJIe5mxPgFCl+bEEN2UbB6urckt/nM/Ovqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-OriginatorOrg: intel.com

Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix a dozen instances of
> the following type of warning:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> This patch should go through:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/ (for-next/hardening)
> 
> Changes in v4:
>  - Use the new TRAILING_OVERLAP() helper.
> 
> Changes in v3:
>  - Use union instead of DEFINE_RAW_FLEX().
>  - Link: https://lore.kernel.org/linux-hardening/aEneid7gdAZr1_kR@kspp/
> 
> Changes in v2:
>  - Use DEFINE_RAW_FLEX() instead of __struct_group().
>  - Link: https://lore.kernel.org/linux-hardening/Z-QpUcxFCRByYcTA@kspp/ 
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
> 
>  drivers/acpi/nfit/intel.c | 84 +++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index 3902759abcba..d0b72e906428 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -55,10 +55,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	unsigned long security_flags = 0;
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_get_security_state cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_get_security_state cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
>  			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -120,10 +119,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>  static int intel_security_freeze(struct nvdimm *nvdimm)
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_freeze_lock cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_freeze_lock cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_FREEZE_LOCK,
>  			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -153,10 +151,9 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
>  	unsigned int cmd = ptype == NVDIMM_MASTER ?
>  		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
>  		NVDIMM_INTEL_SET_PASSPHRASE;
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_set_passphrase cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_set_passphrase cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_family = NVDIMM_FAMILY_INTEL,
>  			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE * 2,
> @@ -195,10 +192,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  		const struct nvdimm_key_data *key_data)
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_unlock_unit cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_unlock_unit cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_UNLOCK_UNIT,
>  			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -234,10 +230,9 @@ static int intel_security_disable(struct nvdimm *nvdimm,
>  {
>  	int rc;
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_disable_passphrase cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_disable_passphrase cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_DISABLE_PASSPHRASE,
>  			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -277,10 +272,9 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	unsigned int cmd = ptype == NVDIMM_MASTER ?
>  		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_secure_erase cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_secure_erase cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_family = NVDIMM_FAMILY_INTEL,
>  			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE,
> @@ -318,10 +312,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
>  {
>  	int rc;
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_query_overwrite cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_query_overwrite cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_QUERY_OVERWRITE,
>  			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -354,10 +347,9 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
>  {
>  	int rc;
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_overwrite cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_overwrite cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_OVERWRITE,
>  			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -407,10 +399,9 @@ const struct nvdimm_security_ops *intel_security_ops = &__intel_security_ops;
>  static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
>  		struct nd_intel_bus_fw_activate_businfo *info)
>  {
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_bus_fw_activate_businfo cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_bus_fw_activate_businfo cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
>  			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
> @@ -518,10 +509,9 @@ static enum nvdimm_fwa_capability intel_bus_fwa_capability(
>  static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
>  {
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_bus_fw_activate cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_bus_fw_activate cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
>  			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
> @@ -582,10 +572,9 @@ const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
>  static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
>  		struct nd_intel_fw_activate_dimminfo *info)
>  {
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_fw_activate_dimminfo cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_fw_activate_dimminfo cmd;
> +	) nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
>  			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -688,10 +677,9 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_fw_activate_arm cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_fw_activate_arm cmd;
> +	) nd_cmd = {

The regression is here.


>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
>  			.nd_family = NVDIMM_FAMILY_INTEL,

So the full context is this:

        union {
                struct nd_cmd_pkg pkg;
                struct {
                        u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
                        struct nd_intel_fw_activate_arm cmd;
                };
        } nd_cmd = {
                .pkg = {
                        .nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
                        .nd_family = NVDIMM_FAMILY_INTEL,
                        .nd_size_in = sizeof(nd_cmd.cmd.activate_arm),
                        .nd_size_out =
                                sizeof(struct nd_intel_fw_activate_arm),
                        .nd_fw_size =
                                sizeof(struct nd_intel_fw_activate_arm),
                },
                .cmd = {
                        .activate_arm = arm == NVDIMM_FWA_ARM
                                ? ND_INTEL_DIMM_FWA_ARM
                                : ND_INTEL_DIMM_FWA_DISARM,
                },
        };

The problem is that the designated initialization of .cmd zeroes out the
.pkg portion of the union. This incremental change works, and with it
folded you can keep my Acked-by and Tested-by on v5.

You might want to remind folks about this designated initializer trap in
the kdoc for TRAILING_OVERLAP().

-- 8< --
diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index c88647428715..c63284ce9a87 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -511,29 +511,27 @@ static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
         TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
                          struct nd_intel_bus_fw_activate cmd;
-        ) nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
-			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
-			.nd_size_in = sizeof(nd_cmd.cmd.iodev_state),
-			.nd_size_out =
-				sizeof(struct nd_intel_bus_fw_activate),
-			.nd_fw_size =
-				sizeof(struct nd_intel_bus_fw_activate),
-		},
+        ) nd_cmd;
+	int rc;
+
+	nd_cmd.pkg = (struct nd_cmd_pkg) {
+		.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
+		.nd_family = NVDIMM_BUS_FAMILY_INTEL,
+		.nd_size_in = sizeof(nd_cmd.cmd.iodev_state),
+		.nd_size_out = sizeof(struct nd_intel_bus_fw_activate),
+		.nd_fw_size = sizeof(struct nd_intel_bus_fw_activate),
+	};
+	nd_cmd.cmd = (struct nd_intel_bus_fw_activate) {
 		/*
 		 * Even though activate is run from a suspended context,
 		 * for safety, still ask platform firmware to force
 		 * quiesce devices by default. Let a module
 		 * parameter override that policy.
 		 */
-		.cmd = {
-			.iodev_state = acpi_desc->fwa_noidle
-				? ND_INTEL_BUS_FWA_IODEV_OS_IDLE
-				: ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE,
-		},
+		.iodev_state = acpi_desc->fwa_noidle ?
+				       ND_INTEL_BUS_FWA_IODEV_OS_IDLE :
+				       ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE,
 	};
-	int rc;
 
 	switch (intel_bus_fwa_state(nd_desc)) {
 	case NVDIMM_FWA_ARMED:
@@ -679,24 +677,22 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
 	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 			 struct nd_intel_fw_activate_arm cmd;
-	) nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = sizeof(nd_cmd.cmd.activate_arm),
-			.nd_size_out =
-				sizeof(struct nd_intel_fw_activate_arm),
-			.nd_fw_size =
-				sizeof(struct nd_intel_fw_activate_arm),
-		},
-		.cmd = {
-			.activate_arm = arm == NVDIMM_FWA_ARM
-				? ND_INTEL_DIMM_FWA_ARM
-				: ND_INTEL_DIMM_FWA_DISARM,
-		},
-	};
+	) nd_cmd;
 	int rc;
 
+	nd_cmd.pkg = (struct nd_cmd_pkg) {
+		.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
+		.nd_family = NVDIMM_FAMILY_INTEL,
+		.nd_size_in = sizeof(nd_cmd.cmd.activate_arm),
+		.nd_size_out = sizeof(struct nd_intel_fw_activate_arm),
+		.nd_fw_size = sizeof(struct nd_intel_fw_activate_arm),
+	};
+	nd_cmd.cmd = (struct nd_intel_fw_activate_arm) {
+		.activate_arm = arm == NVDIMM_FWA_ARM ?
+					ND_INTEL_DIMM_FWA_ARM :
+					ND_INTEL_DIMM_FWA_DISARM,
+	};
+
 	switch (intel_fwa_state(nvdimm)) {
 	case NVDIMM_FWA_INVALID:
 		return -ENXIO;

