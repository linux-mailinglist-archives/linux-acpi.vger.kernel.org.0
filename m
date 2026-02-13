Return-Path: <linux-acpi+bounces-20981-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD6KJTmwj2n0SgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20981-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 00:14:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8F5139EE9
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 00:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C87C303BB13
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 23:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851A32E12E;
	Fri, 13 Feb 2026 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aki1rjCB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348E328631;
	Fri, 13 Feb 2026 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771024437; cv=fail; b=On0c6mibvVJ3urieZS/jlVMaiUuKlj+1YPzx0dd3/GLoXllJoE2PVHkUTQ5Th+9eDpbz0w7JOxl+8NDG3/u7DXmGXlTRqqfbXeq5QLJhOKMtcQ5hzW92bYbLQtGYtP7p9fK4ydeujj9kzaks11QAkEx760QxyP9CKQnshkn+3C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771024437; c=relaxed/simple;
	bh=CTRLpNOkvrQL6BSGP13C3b/RyM4es0loHOI6z7hMjqo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=br+f4ZNoRYGQgeVkk4ByIulctlIxFEehOkFP8ZBT+9FJUG9dG72X0OD69pZKIK2W/CA/aZK5e0x03GLfZilzJ5RsmVSLTAbeHOa95u+1yMl49CT5wtYubVS3XlZMn4k/AyRIBhT7A6ANarNcpZHQ4GphR2HwYSiss801OxoSnQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aki1rjCB; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771024436; x=1802560436;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CTRLpNOkvrQL6BSGP13C3b/RyM4es0loHOI6z7hMjqo=;
  b=aki1rjCBs/znoK9lvsZsdxWyMWv1/Rrb5kDD6B7Isn/n88eZVpl6dAyB
   qHXcJ6MQk9td3UDLGzL41tP/cxK0EOTs5xfoefKROToeYLlKArPrqRBDx
   2hjl34+4DnfxpPWjIVhpCEBSOefOM7QcacqNNFMwfnXHsi/VE5+d7vyX5
   5wtvOjJrkVdZNN3FtHe3DgQWUtE9AcP1WikA22wWOajN8dAeYjC7EpaEF
   ExAJBeCv9/rzuHnYxqhDY/jfwgxJucQsakXx5WOr6VzHPrZVz6ZmeiHkK
   /acW+CJ9tECW6Zzgwbnscnh92ctjDTuNzUGWjmW3lKXXUNuvhrFpeX4uB
   A==;
X-CSE-ConnectionGUID: laLJ68qjSlyFrIQk7aL9iw==
X-CSE-MsgGUID: +xClNztgQAK159xYgEKLGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72117748"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="72117748"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:13:55 -0800
X-CSE-ConnectionGUID: AaPhem/vQ82W8Ptru0/PUQ==
X-CSE-MsgGUID: z3Hs0LNlRg6mzCtESsxOSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="217171718"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:13:54 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 15:13:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 15:13:54 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 15:13:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrwA7pCSuqjLQAmhvQAT8SQdi3r6gLdjC4Pl1y7D9LGIxiZz/MUUSgc8A1gS0Ew/oSlvfNdVgFcew8igks3fGRZXpBL68XVUQoVSSWXsQUi7L4kq0HFDgtULuAFhfbpdkvZQuwn0AsGZI2HpVIjebtgav7+3qICZz0NMsgWbsQ4Z8PVcN2oyc7skbZqzTBA+LSfyuPWiRIQXSsnkv36DjYmpgSih4rW6QV/uRTm76+earRBehCmoDpzFlhksdLe5Qyl9gbnzUdLk/fvUEAb+cO5aGWyfTSMuGZl6wvBari0z6NU6Q4L7I7mfrZTv7aBp4kOk9BpYUR4llBE45Jorbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5UImsJ1HjJwvPSA6ZxNilijbFjJFo1k/hg6NEk9UzM=;
 b=JNdWLfL9CdJH0GXud9Qk982nGewGObQnIAaLtqwtvJ6WtZzeO2jhvMCUamFgmnYpwJG5feQylOqZ9h9ZxJcuGVv8pmqlrZU9JHjKrlOk53bwTyXYRMBpRAgOEHDsFkJIt4t0jmaJWW8PQDxYv1k7C9WiEdiKIaxJulL08rQUOCYFMWJ5ccOIhMnb0MWJaQvdjRkfckfUK5SVnkUS0SAMw4DKlWJ+lfPnhimVjYYl7G08OBoTqZLDeWSOLed9CQiW5kbPAkX9UOEGZpPBcJMI4MPoDpkjk4u2Png/DgzOw3OgGthX/QgIVtN8YiL51LiMFEy0m4o2KuScynga5R7/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8756.namprd11.prod.outlook.com (2603:10b6:930:d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 23:13:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 23:13:46 +0000
Message-ID: <3f53c823-74ab-46c3-9cf0-c28b062f2c89@intel.com>
Date: Fri, 13 Feb 2026 15:13:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/17] RISC-V: QoS: define CBQRI capacity and
 bandwidth capabilities
To: Drew Fustini <fustini@kernel.org>, Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
	<rkrcmar@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>, Nicolas Pitre
	<npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
	yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
	<guo.wenjia23@zte.com.cn>, <liu.qingtao2@zte.com.cn>, Tony Luck
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, Peter Newman
	<peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, James Morse
	<james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Dave Martin
	<Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <x86@kernel.org>, Rob Herring
	<robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Sunil V L
	<sunilvl@ventanamicro.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-5-dca586b091b9@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260128-ssqosid-cbqri-v2-5-dca586b091b9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 784456a3-9185-4c47-04dd-08de6b5589b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEd1UnFSQnBGLzcrdmdPQWdqU3dxMVhrUE1KYlJPOFZuY2k3dE9HQ01xUW1Z?=
 =?utf-8?B?UzdJcjUyUkdqamN4emVHeTlrcnQ3cUptbEdGMFdRZ2Z2bC9vNEMvUnI5NE04?=
 =?utf-8?B?UUYzVUgwRHFmb29McjI5dVdQNGpUeE9wNlRHTlNUR3VFTE1QODAxek11cHNV?=
 =?utf-8?B?VUdwSUlwZTUvN2orZFUvWGVTRnhOcHBlWFJFb2FuOXBqS24vSkF0R1VLOUZj?=
 =?utf-8?B?QnVyaXhXNDNvL0NTeUs1YndwUVVCQ2V1QzhLRTZDZzdHU0pzcEorMEhmTkgz?=
 =?utf-8?B?am52OVFUdk1pTjNZeXpycmptcnhjOStnZ0JiemJPRHRVbXVzcmF0SjRLRGVa?=
 =?utf-8?B?SndzckVsU3BkM0h2eFB0N3lrait0YlBIWHFGZ2Ria3N1c2NtOFFvcytoNzgz?=
 =?utf-8?B?UFlpd3NneVJiTGE1VWs0MXZ3WlB6aHQ1anh2VXlhaE5hNjV5V0gyV25XNzY0?=
 =?utf-8?B?TGIxNm9QSEtIZzVhRUdCVlpaRzZoVE5GTG1PSUpxcEpoKzdMMk8ySHVnOEFH?=
 =?utf-8?B?NzRyRFc4Zy80MFhKU0p1b21RTFV0ZEx4cXlrTHpCdjVDdGlVcjhKWmNYS0pn?=
 =?utf-8?B?ZDJ4Rlg1U0QxM3ZTazRtUnZlUURDNjJFMkM1My94cldJd01GemR5a0wrSHVG?=
 =?utf-8?B?aXF3L3NzVksrY1NzVWw1KzJnRnhZWjBySFIrTGpuQW94U0hZTU1RaWk5MS96?=
 =?utf-8?B?UlE5YnN2c2dybjd0OFE5RnoxQWZuYVRtTFV6UzFweThoMEFiR2FvUUJuVW1w?=
 =?utf-8?B?NERDRlk4T1VTZVlwZ0FTMks2ZmFhVk5pcEJQeUJKYWMzdVdBUUlENmk1RFpR?=
 =?utf-8?B?Qzd2aWsxRmRqcm5PckkzUjBRbWdWam9uYWFwelZ6RUdUTkk1anJzMElpNW9t?=
 =?utf-8?B?TWJ6NTA5bWJ0NHROZU1EWmt2L041bjZKL0xrWE01U3c3dGxrMzU1RVZnb1Zv?=
 =?utf-8?B?VEVITThSN1NqdGFycFdOcWFBNGVFWjFhWGROa1JyTk9Vd05EVUlLdjVaZXFM?=
 =?utf-8?B?K1lENUJZRmhkMmRDNkdvQVJhVWpmWGVsVGRURDBoelpWN2hWMTRLWVpsWWdS?=
 =?utf-8?B?UG5rN1N6OCtnYnMyZjRtdVdZOVZtUTFDeVBVSG85R3l4bE1UZHd1YzlOS1lF?=
 =?utf-8?B?ZVAwZ0pVNDNrK1BoZjA2MlRSNk9NUXJiMWRGVG9zMGpnU2tHbjNVVjMzdUE3?=
 =?utf-8?B?eGhNTSt5Q0lPVGZPcWV6U0tTSWFkUkZMaHFLaFhTY1hOQS9BcTBISU5uVFp1?=
 =?utf-8?B?WGo4Z2RUdXZSUDJRM0pkb1pLSFRHK0Q5Rk9wenk2OFVxVCtsa092L3d4Zno1?=
 =?utf-8?B?Z3U3MkJ6azNQNHZubTBsY1IzeE5vMFIyNDZMdU9ra1dvL0RvaVZiRzVwanMr?=
 =?utf-8?B?aW5DTlV3TEhOZFhPU0lDTFd3YTBlSnlQUElvVWxmdGYrdHRkV0U0WDNJeGFK?=
 =?utf-8?B?dkhUblZEYXNIMStmK1BwSzFrQUpyOENxS0hlQVRHOEdaU09WdFNrUHVEVmwr?=
 =?utf-8?B?bkxvQjhNLzJyTmlZVjlRRlEzcVMxUTBYYzJFTTkrWVgrQUFsZHJkOE5DQmpt?=
 =?utf-8?B?Sy9iTVVLdXg1akJjb3kxUmhhNjhjWjRuUEQzUDBmR0F2eDlpOXlSUWNyWXdF?=
 =?utf-8?B?bzk1RGx2YXlHd05iYUY0ZnVxQ01yU05wODBSV2E5NUNQaFBpanEwV2pjODhl?=
 =?utf-8?B?QkZuOTVjZytlOUg5RzVGSGwvRmRQcGMwVWFIK0VKS1ByczA5MlhkM3M1enUz?=
 =?utf-8?B?dmVpR3YxVWx2RWNQZ0xqdGpNYnhZUm1FYU5wV2hYU0lsM3l1eTVoekFva0Nq?=
 =?utf-8?B?ODRXU0lXelVzT2NDMjhpQnVBUGNhRTRPRWpWSkFONlZpa2kza05JZnFSaUVz?=
 =?utf-8?B?bEdxblB3YUdKL0xYRkwxRG9WT05YTjlqdFpDWXEzVmFDZk02NmJJNWlvbzZW?=
 =?utf-8?B?d3Z0VVBzWExRcG56WFRsSndJbmhqYUxjMm52R0VEL05xckhsR1Z1ZUdnbk9J?=
 =?utf-8?B?dnlFWVFDc1Vpc3hOcERvZ2JWanlFakk1YUZDRG5JZDFZVEVMR3ZLQkp5eWFh?=
 =?utf-8?B?OXdlQU9Ld0QyT0J1OG5KNjRFVVRvTkh5K2dsZVZPRCtrYlVMTHlINnY5cTha?=
 =?utf-8?B?UklhYUkyNXlEcnNYOG5BanBEeERZQWUvSnB5bVZFa2RWdTJHejAvT3lYWlRY?=
 =?utf-8?B?dkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xQMEVBSG9YTTlveGdaS0NzSjVDclU5eSsrMEpWOUJUWitweS8rT2JJdTU3?=
 =?utf-8?B?RDhsUWJ6enR6MXZXOEFGVDN4RGxiQ0RVc1FUdEplRG9qSEd5ZXdjTVpUS2lR?=
 =?utf-8?B?Y3ovQnJXK1ZWZVFtbEJQVHAxZ0RCQnZSNVRyQUtpeHdOVXZXWlRsUFZBN0Jq?=
 =?utf-8?B?a1EwdWVnYkd5MUVwUGN3b0FHWWtQYzd4ME9EK0tSNElQSU82TkxraUdsbXdw?=
 =?utf-8?B?emx1VndPbmpiNU94ZWp2K0ZWangvYkVvcnpOQXZpQW1HWEJiSnp3eUlrcU5P?=
 =?utf-8?B?VnZMYUJ1TWQwb2dRNmdNYkp6Tm4xODNZT0FuQko5QmloRm9PbzBIRGxXV0c4?=
 =?utf-8?B?UDZiYmxvTGcyVkF1TlQwSlFCb3RnaGl2ZThOQllJOUsvUDJJR1Rwa3daejJh?=
 =?utf-8?B?QWIyU1Q4dlROcElPTjBOaW9HdEY1b1NxcnpUcXh2VFh5eHNUSkEwdjdOSlRQ?=
 =?utf-8?B?T2FjY0lPd1RTTDVMK1dZWUVMQ0lZYkovdXpKdnAzMXU3Y08velNmTmlYWWM0?=
 =?utf-8?B?YlNkVjZqSzB0UlZ1SGRBdkJFdGJ4YzQyOHFyZ0JOVFJZbGwvQVhkRWRCZFZS?=
 =?utf-8?B?MVVyb1YvM2JlRG92dTRlRnJySkIrM0d2Uk16dU9pRXdPQk8xa3Jyb1ppRWNI?=
 =?utf-8?B?NnlMUFZTQS82ZVZ6eVZsUDVPSFlvdmswK3BrS1I5bUFiSVdPOG8ybWU5Yjdm?=
 =?utf-8?B?eFF4ZCtCVjBGcXRWMjJsMkRGOGRCVDZGeXVMZTA2bFJhdUFuWUplamNLdlpO?=
 =?utf-8?B?RmhhRzZZWTJtUG1EVzlHd0l4SVppVWY1anI0TDBJS3hrMnpJMW9IYmQ0UmlY?=
 =?utf-8?B?T2cwTlpxaHJUcVVISjhFVW5Wb1RyOHJXdDFoWlJxc1Q1dVJZdWt4d2hISDVO?=
 =?utf-8?B?clBaeXdNakxvcWEvRCtnOEZSOUtxc1Vhek5lMWF1ZFBxS1lFdThSQ25TdTBy?=
 =?utf-8?B?Q0RkWmN3UFhUNlRWMXA5NFk2a2cvOVdsWDh5NVloVEtsSnQyOWVBTHFEUFc4?=
 =?utf-8?B?dk1nQ2ZBR3NZUXBiK1BiWnRqRVhsVG5pQThpcmJkS0FrdjFFNC85UjVsQk42?=
 =?utf-8?B?N0FwazJ0Mjk0akZjZExqblVwQnViVUtJTnJuTy9UYTgzWGFtdmtsTmd4QUVC?=
 =?utf-8?B?ZDRYczljWDV3SzE3VllzbkFSOGQzREtJdmFPSTdncWFubkxjK3RlOGRKdE0x?=
 =?utf-8?B?VEV6VjA2TGZnb3daWHJxOElyaGhQM0cvSlNBdlBsK1kxTklTZ2JMVXRncUQ1?=
 =?utf-8?B?WndyK3JjYllYVWpQYURWQ2NGQTNZZ2x6WGQ4VXhVdXZ6c3N2ZjVja2ltc1B0?=
 =?utf-8?B?d1hhWmM0SjlhRzNMaHRkbFJ1YVZudzl1dkFFdGFXWk1XT3YwWGVMWU5IOW1m?=
 =?utf-8?B?N3Vqc0dCY2hDZWlRNHBXRkUvY0YxQTh1c2p0Mm15ZEJ0OUxJZzh6WkVlQ0VE?=
 =?utf-8?B?Q2RhRFZQYnJQb2NibzZ3bGt2YWdZblc2NDNzUTgraXM2Qjc1dFppSUZ5VVV3?=
 =?utf-8?B?UW9SWStTUDlDUTNyaC9aN2o5TUgzNXVYVkRxMmE4OVl1LzhsMFAyRlFBdVI2?=
 =?utf-8?B?eGNTeGlHdGlSNlJub1hncHVIL3pGY1J1eVB5TjJrcklYSkIydklVNGJPb2VD?=
 =?utf-8?B?aFBSbEswN1QxcEdyMlA0aDRYMFBDa29HeUd1L3BGZEtQRGZmWWVOSlhDZWJn?=
 =?utf-8?B?RE1Sdi9tdG1NaVRKY0tTcjBSWWdIaGRRT2tLMURzUUR4cFZBM0EzMWUwUGFu?=
 =?utf-8?B?L2ZLN1dXMzR4T3Q1N0ZvK1Z4bGZiUHY5bUdKa3BEQUVmR0tEWmxHZ3Z3WkFn?=
 =?utf-8?B?cDlIMHRjOUxFeENXSDVDbFUzZ1p0SEtNT2lHbnNvZ3FCUC9kclN4STUzV0w3?=
 =?utf-8?B?eW5hKy9mWjZTV3ZOWFYwOGEvcDYzcGl1S0pxWHhpd20zYXJvVDNPT2FXSHZi?=
 =?utf-8?B?ZUsyQmhDRFM3TXplRXg2Y1BwM3h5dC9xSWJ5aWhpeWZRMVZGN0FmWnBIZTMw?=
 =?utf-8?B?NkQrbnc2YmxNZ1o2RGE2U3ltS2RablpLYVBIZm1GK3FtbzVNTnV5SUs3dGZq?=
 =?utf-8?B?NWp5MW9nOStMNzRKVUxkTmJLUjVEUnhkY1lLU2VEOStFeFA1NStYNklZUDU4?=
 =?utf-8?B?c1l5aGZRVVpqMXVkbjRuZ1NJVnpWbmNKRUdnY1hRSVpIek16cWhGZ1FHdTNz?=
 =?utf-8?B?SlFKcS9WQ0p5UnJHbTVPV0R4aThLaDFreGM2c0hMajBpdWhIdXRqRnRKNzAy?=
 =?utf-8?B?eHl2UjNkZ0JsdnhNbjg1Umw3SWVIampobnhXV3d1TDNENmZaRVBtOE15R3lH?=
 =?utf-8?B?N2k3Z1NLVHhzNXdGN3F4TUVlMzZITjZCTCtXYXBna1N3L05zNGs4Vk5FU2lw?=
 =?utf-8?Q?UNN4DOX4XhsaTzQg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 784456a3-9185-4c47-04dd-08de6b5589b6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 23:13:46.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI/6uVNGtpFvqHeOTwcWn/riNHqjCRBIPEvCCoxUj/KqX4eyRXebrdXkQzamBXZxYW5/q5m8DtZ4+1kL8fJIPDXrjzWFXPwxIGnrSDswJCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8756
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20981-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3D8F5139EE9
X-Rspamd-Action: no action

Hi Drew,

On 1/28/26 12:27 PM, Drew Fustini wrote:
> Define data structures to store the capacity and bandwidth capabilities
> that are discovered for a CBQRI-capable controller.
> 
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  arch/riscv/kernel/qos/internal.h | 128 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
> new file mode 100644
> index 000000000000..ff2c7eff50be
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/internal.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_QOS_INTERNAL_H
> +#define _ASM_RISCV_QOS_INTERNAL_H
> +
> +#include <linux/resctrl.h>

The include caught my eye but I did not notice any additions in this patch
refer to it.

Reinette


