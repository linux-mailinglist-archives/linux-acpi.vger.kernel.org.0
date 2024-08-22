Return-Path: <linux-acpi+bounces-7773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1775595B154
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 11:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EC3B239CF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A70183CCE;
	Thu, 22 Aug 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAwlQV/v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBC17E00E;
	Thu, 22 Aug 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318291; cv=fail; b=b2sxE8ThPRVGxzXMX3YwVLGf8DihldTL1XSk7Pcm4FHJ9dFr4DNmX/4dR6hMqVte0/SeaMi+YuYMJPgY0IQ1htMRMu1xPlNO9gg/se3arOgRxIcg8d4VKbMBfFyxlyntBBo4kcRtmZOZeKCohLgja0VkGed+HF4z5wT1iAQz83M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318291; c=relaxed/simple;
	bh=D0szRr7xXMLJfaWJLGrPuWzIa9JEdMfqu+XkddMxbKY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEG7aaI4OKwFOgDgKQBWuBEhwGazyM+93umFgo51OIBCIJxMl+u2sPaxPi7jl1UFZqM7wPSNmGOB9QQQTZqq4qLjPkA4v6sJzE9kLlxRNTluwDgmT3wdIWU2mJ1FgQoxWQHcWAgKQw5f511Sf9QjeAtUb9Qrrtll66vfcEp8sYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAwlQV/v; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724318289; x=1755854289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D0szRr7xXMLJfaWJLGrPuWzIa9JEdMfqu+XkddMxbKY=;
  b=aAwlQV/vHIRfuJhQ0swk1HtR2U+FtU8a302rLK2ee6gDf7C9/5tNVGgU
   tyRDPANeA/ZIk2mg+S4LI7K6ejryeywBWlhdqNmZJjTXbCwfdNFmfuD9o
   ejcEwLToR323YEijROMsg2GiEXev8Yw72YleEc5XhYh90hdQKGqpa7m82
   NrUXkuny2cNACHT0qBXP317elsuknfL5/0Y62UdQsr5idXf9XAyPE9LAD
   pxTxf5BIC7SlSsfQfxdGbGjhLYQ1nXHTLgRlRNBIysQbfcdNmy4GqPW2f
   3dqi8IQP9o6F66M+l7yteqYFv5rawIf7bzxYFVZ6T/z9YXD7DdPULvHO8
   w==;
X-CSE-ConnectionGUID: hhFNBtkeTh+c357VeKEuYA==
X-CSE-MsgGUID: 4j1AR1qkS/iR626e0DPEOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22900773"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22900773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 02:18:08 -0700
X-CSE-ConnectionGUID: mzjCUbMrTpmp/zjFnm0rjg==
X-CSE-MsgGUID: Qs/OeHrMSUunWOMoXm+KZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="65724641"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 02:18:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 02:18:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 02:18:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 02:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pslBFdHIqZu8rvUimTOgtvN7GB4nZYn2lUfYbagTCOJj/A4+aYytIYSsafxDOdF1K1Ag+L+XzV1HFhi+JVplFyH5O3M2uA/hBoNshok7tYJ4uklq6biWYmTq683aQWUJFEEbMdJHSIUCmNoRdpzgRUG1Yob+XI9iRfREd/aoXLWYtQHlwlkLfHsxJ3j/tPHZ7BjPTklxeYXwKQRUjyVxbIM2I7Ry76riTmXb+vFMEDctkUeMBDqdOaiu9bVEqEXlr6cm+sgoe5wLA6kSnHmixtc97IXTM8hlnXLrrbubIPD1GVRSBoWpfIu29w03mvfxDp3m/n4in2LwNN5R10s65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddDYjNx35KgsXLrgmxM+arL/fAKH6M3VK/F6G2Qiwcw=;
 b=IBOOcsNZKRGmbwfgGWzApZWtXrD3yK+xfyne8dh67AxISkKAgo4qnKwpGas/YU0FZ9lBa9tm/yu5CpZNXZNJc+bVQhN+l2Z8WikQmn0eP5LI1fWXBYtwxW3GR0w1MwD3bpQBaINqPambAL8Rpjd5n9VqUbHj/nNZ9WdmQVzBiXjlLqHmC2ZgVjM/t/9WcrESBhWBV3QzodyTMUx7rYidOhxfhqGdyHcdim/rqwPR3TDNGxLGMZ00+rHd9KrCxdpsAcsDoEitgMypQUCqUgiTxJDl0kvseYRJO3czMd8omyIRybkVrRBW9qU5vYPZv4sXI8EtvWBPRzm0IyuWBH9WTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:18:05 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 09:18:04 +0000
Message-ID: <d0b0d0e2-dcb8-5f3b-7a0c-9eeba13952a6@intel.com>
Date: Thu, 22 Aug 2024 12:18:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: ACPI IRQ storm with 6.10
Content-Language: en-US
To: Petr Valenta <petr@jevklidu.cz>, Bjorn Helgaas <helgaas@kernel.org>, "Dima
 Ruinskiy" <dima.ruinskiy@intel.com>, Hui Wang <hui.wang@canonical.com>
CC: Jiri Slaby <jirislaby@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Linux kernel mailing list
	<linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>
References: <20240821145959.GA248604@bhelgaas>
 <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
 <5ba3c7c2-5695-421d-a747-2a23af48db26@jevklidu.cz>
 <5bba930f-4c32-401c-a2e0-80dbad36487a@jevklidu.cz>
From: Vitaly Lifshits <vitaly.lifshits@intel.com>
In-Reply-To: <5bba930f-4c32-401c-a2e0-80dbad36487a@jevklidu.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 499458cd-b0f5-47dc-5da7-08dcc28b5403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDVQcmNDL2VNMWxUUFAzZGI2My9Eb2l6OFFPNnY2SlNRS2ludjJBN2NmR3Bi?=
 =?utf-8?B?RVZ6VGJwOXF1UkxJcmRnc0IyMHh5Q0pVcXZYWHRkSFR1MFpqWW5wQ3B1VzVm?=
 =?utf-8?B?OS9RbWRiUXo5UGhZZ05WekpxbkhIczlyNlM4c0gxKzJlTTdVWE1aZ3kwOGt3?=
 =?utf-8?B?ME41WGlQTEVhT0h3bGg2Nm1qc1BjRkxtNis2RGNxN0dudHF0NnBoTDNhVDUw?=
 =?utf-8?B?UzNJei9hMnlyV1QzWXp5d1pXQUJIZHRXZXFTVnVhOWpnc1U5NUN4ZENLdVJW?=
 =?utf-8?B?TUpuRE1RVEV0bHNkWllkQzhIdUpxY1o0Q1RmS0dVM05ESGhmMDlQdWQ2dFlF?=
 =?utf-8?B?anZ4N2kyeFdCbUUyR0lnUTMyV2dOemdJMFFqZjFQajR5TjAwTWhHeDM1czdm?=
 =?utf-8?B?Ly9vM0IwdmpNdHBWTXR6WVhFdXpjTkZ4NTU3a1g3VTlGZ1dkZFR5bzRrcFUr?=
 =?utf-8?B?OW9MZUl2TXFhVFFXNFJwQkpJQW1nblV2MXIzZ1pXWkNwbnJDZUx1SGxUVkt1?=
 =?utf-8?B?VU01QkZkaW9iTE5RSGNyZFI2N0VQUzgwU0p2YmZVSFl4dnp2TW5GUVZVZ2ti?=
 =?utf-8?B?cy95Y0dzYVRSaXRvZmprT2hBTGFiMDBxMmozY3I3eE4yeXA1QnAzSWwwU3lC?=
 =?utf-8?B?YzF4K1gwRnhNeWxGaURqYnBldk5hYUd3WjJTRzEzS1MrRExFMmQ2K2F2MGNU?=
 =?utf-8?B?d1pkR09PbWM0eDZGY01VeWdCelpNOFZHTWx2eXI0NHAvUHRFaWpwWXdvN2ht?=
 =?utf-8?B?OGhTUzVuR3c0RWxOZ2hpSks1Zk94cGpsZEhTbXFsenpRblcyY2FnZ0lCcWIy?=
 =?utf-8?B?V05Pbmk2R2RYNkxZV0M1SmNuRzhoSzZRUFVvd3pRTXNhcSt5K3pTMHlramV2?=
 =?utf-8?B?NGtzY0x5YXF4Y1FLNkhHL2d3SHY2a1FXYkJBNmlUMHVQd0pvaXhLVi9nSmZT?=
 =?utf-8?B?NFFQZHpLUVk2TlhjU285ZDg3TDN3YTdzTGVtcENnUGJHZnd4elE0NWdkaXFk?=
 =?utf-8?B?NWNHdUdsK1hUZFNLRzU1d0w5SkhWZlRuaU1jQ20yd05kajVXdVZaSk1WTmV0?=
 =?utf-8?B?WUtwNzdjM1R2SVIxQmhiVW05SWx3NjU1QmRHL081bk9wRUlkYzdXa0hvZ0VI?=
 =?utf-8?B?OXRrV2Q0SEszYTFCZG1XLzRPTmxaOURyR3VMQ3Z2aGc3WU55Y2pnZC9saGdv?=
 =?utf-8?B?OU9oblBBVVljWlVFOURmOGk3TCtONXZrbGZ0QzQ5d1ZxM1RCV3RUT0dPUHVu?=
 =?utf-8?B?aSszeDNYT2dGY0laMk9wQWd3YTJvVzFTWHFud1JpYkw3R3dRdDFNUDhyNmor?=
 =?utf-8?B?WVlrcE5JVlVMK05mM2l6ZHJyQ1pkWDJnRk9Ld3hNSEV1dk1LNDg0OUpmNzda?=
 =?utf-8?B?d0hIcmQzdk1UMFBBSDR5RythYTltdU42SzNVZlJjY1RZejY3VnFlZ0dhODhE?=
 =?utf-8?B?bFR2YkkvWnF3SmNCVzJzWVBzcGVlTUhqU1VjWWRZRGZwQVB1SkMzMmV0WDBU?=
 =?utf-8?B?akNqc2taeDhzaG5TTnJqaFBrWHBHWDBPWlB2Nk1UWXk1ckh0NjQ5OWIzRHFl?=
 =?utf-8?B?dVdkYkdiQWp1NXQ2K21OQ1cvVWMwTVJRdm9vb2dTbnh3cEEyYzFlSURXRkdH?=
 =?utf-8?B?MUZ3MXNhM25POG1obklhU2gzQkxRYitDcDBaSHlQdEsxVzJhanNRNnFiL2FZ?=
 =?utf-8?B?bEl2K2VxZEU4NWtkWmdzZWZlRmxDam1SSWpjNW1wcTNsVWtGMmJXakVsV0Ns?=
 =?utf-8?Q?LqMGge7dEpkqD5p9tw6k34nO7H+V+iR2a3/lt20?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHQyaEl2V0xHbk5IYWlIcDRxcUpsZWtsVWpXN1NHVU1UeGxDb2hmaEtVOUlP?=
 =?utf-8?B?RkxCbTltbG55ZXRGTGV4S24rYStzWnp5N3hka1k4S2VkYlA3V2tzSC94dGhs?=
 =?utf-8?B?S0UwNG9TaXh2eXRjY09pbWZJNW1uL1g2eWtvTU11THp5YU9XWlh3S2ZEb2F6?=
 =?utf-8?B?aUs3L1VxdzFCQTZzdUpUVHJTWjRUMlhjWGF5VUdNK21GZm53L2FMZUhvT2xJ?=
 =?utf-8?B?R2FNNk93TkYyeVQrVWkrcHFXVDcvYVVyenhmWkgraWV1SHYwcEdwejBUZE5k?=
 =?utf-8?B?Q2NrNHZFQllzTDZVTjRSaUlkLzZPV1VGZzJ5Ly9BWXM4a0h6alFrUTJ1Ukw3?=
 =?utf-8?B?MWxGODl4RmRnYXJhSUFxTEdTQkRkODdDWlNXZkYzSXpFODM2cGpkNHRHMlB1?=
 =?utf-8?B?QW1LNkZpd3BkYzhROGtPamFhMFVleGU2Lzh1NWk0VlVCVkN3Y3FpM2U0K0oy?=
 =?utf-8?B?bFZtdkxGTUljaU5jR0IxdUZ1N3M0YkUva1lOeTRhLzQ2YjR0VXNLRGk0c3Z5?=
 =?utf-8?B?c2VSbzJPVFRmK21GTUJyb1AzZ2VyNjhFTzhFVllhbzhWTXhMSWppdlVON1dw?=
 =?utf-8?B?dUIweC9nRVd2SHZ5KzF4OUtIMmVpNzF5UTRVSkVlT3RoaGZRZmxNN001eUxZ?=
 =?utf-8?B?QW5LODdIbEtSZWovYzQwWWRNcFY2eXFJRFRaYkRSRFVzOUNHVWpjelBTNERt?=
 =?utf-8?B?T1JWV0IyM3RsMVpCeVlVeHBKZVBhaDBBbFJLazBQUnBlOWFuZFFxWXdXOWxs?=
 =?utf-8?B?SHVwdHhWRGtKMGNFaXNhTWJuSXBqZVZuY09YSzA1MWRkL3FZa3hKNWx3Q3BZ?=
 =?utf-8?B?TFI1YkFvL0VSNVV5NmsyR3pGbFZWN1VsSU96NVhtaFh0VlY3ekFKRURuYmND?=
 =?utf-8?B?Njh6eU5yWTJ5OG16dE1ZaHVCMkcrWVFSVWZzeUJENy9XcEZ4TFdadS9XZ3FI?=
 =?utf-8?B?VEhnSEgxQWwzMGFJdHZRV2l5Q2tTU05yK0RVaTdNTEJuYXlaT2JLaTZUYjJo?=
 =?utf-8?B?NVc1L1FFWWwxWUVyK21SUjVuZGwrYmQxNzMycHZpTWVQK2x0MUJJMnRDYTYw?=
 =?utf-8?B?MjNLSnQxeW9vOFVCL3pOQ25TQ0YwYnpObVJBVjRmb0RQRW9oTmNlNGZDem5p?=
 =?utf-8?B?SytMSUFPdUFJVGdGVThJSGxiVVRxTVlZRUk4L0h6VXBlVXphcW9ReWJESU5Q?=
 =?utf-8?B?cjlsRmU5OTVOb2E1WDVTL284WmNLeWEwbElodjAyZkZKZkVQbUg1d3dCY3ox?=
 =?utf-8?B?c1FPZlUwSlFNbHpxZkwzYytPdTNiS01Mamh1L1JVczUyWDdzTnJVZXZrU21P?=
 =?utf-8?B?QmY2bDJiOXVNaGlpb1VseWNydkw0WThJaDJzSEdtTU1zY014cDJrenc2aFFF?=
 =?utf-8?B?VXpKL0dqTWoyejl2UDd2aUVRRi9NQ0Zvb2tTMTRVRTVsbFpoNy9taVNLY2Rn?=
 =?utf-8?B?eTgyaVpCbld5ZHM1TVlDUkY2RjlWVENYZmJMMTVOdWN4YlNnVE1HMlo0YlFh?=
 =?utf-8?B?OFN2WlZIaUlGbGNVNHhtbGhrL21nMjNrVjhxSGZ4WHZrMThlVUtrT3l0a2ls?=
 =?utf-8?B?Wnp2SEdnVWR2V0FCckx0Smd5NmU4SERiMzB0NW5uM0dibXdZR1FRbU9KNXNK?=
 =?utf-8?B?Y1dNV3N0S0EyQzhvbkI4MEdDazNkMjJIYlRZb01jYk1LelJyZE1Qa2xkY3Fk?=
 =?utf-8?B?RzBWcDJUWnY0R3NZWGgrc3c5R0hOUGFmcVpKK1RtK051OVBZa2FsdTd2MGlS?=
 =?utf-8?B?c2FTVUJxMDVMYzczZkROcTBsWm5uR2N5NllvQzd3TGdkc0svWXVTWTd2VjU3?=
 =?utf-8?B?M3JKRUpBWlVyT0Nhc0lvWUs1M1V2NlE5NzdPWWFNcVJBd21NYmJpRUJCdTdz?=
 =?utf-8?B?Q1krWmMxOXFFVmtaa014dWNhQW1xOUYvMXNwdklOWm1vQXA2SHQ2b000QUhz?=
 =?utf-8?B?aVBLZEVRSytqZXBsM3ZNN1VGSURZRFpEMFVMMG83YXRiNmJJSDByN1dSVjlR?=
 =?utf-8?B?UHAwbHQ2dHFVUkJLa1Z4UTVCalk3YnJ3NFFvRDJ6QnUyQnFyTVpUYnFORkpu?=
 =?utf-8?B?OW9wUGV2aHUxajNycTNoVHRTRUN6K3lXb3BBTEJUN3MwbnVXbytLK2IvSjRi?=
 =?utf-8?B?Y2xXUUNRUWIxNG5KOGJuTXpHS0FXUzJMeWc4NlNlS1BoZVFqSW53c1ptNjlp?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 499458cd-b0f5-47dc-5da7-08dcc28b5403
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:18:04.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CthScw47kujitJjLYRuecZObEgJRoGrpswB7chs6LHV+RD/VCkKgZMTARLwrGjsS8EcMv1I+8ZDtKrjBKkJyffLHAjP1ehkbZ9e6EBfvbIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com


On 8/22/2024 11:33 AM, Petr Valenta wrote:
>
>
> Dne 22. 08. 24 v 9:44 Petr Valenta napsal(a):
>>
>>
>> Dne 21. 08. 24 v 17:17 Vitaly Lifshits napsal(a):
>>>
>>> On 8/21/2024 5:59 PM, Bjorn Helgaas wrote:
>>>> [+to Dima, Vitaly, Hui; beginning of thread at
>>>> https://lore.kernel.org/r/60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org] 
>>>>
>>>>
>>>> On Wed, Aug 21, 2024 at 01:39:11PM +0200, Petr Valenta wrote:
>>>>> Dne 20. 08. 24 v 23:30 Bjorn Helgaas napsal(a):
>>>>>> On Tue, Aug 20, 2024 at 11:13:54PM +0200, Petr Valenta wrote:
>>>>>>> Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
>>>>>>>> On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
>>>>>>>>> On 19. 08. 24, 6:50, Jiri Slaby wrote:
>>>>>>>>>> CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to 
>>>>>>>>>> b2c289415b2b)
>>>>> ...
>>>>>> I'm at a loss.  You could try reverting the entire b2c289415b2b 
>>>>>> commit
>>>>>> (patch for that is below).
>>>>> This patch didn't help, so I reverted it back.
>>>>>
>>>>>> If that doesn't help, I guess you could try reverting the other
>>>>>> commits Jiri mentioned:
>>>>>>
>>>>>>     76a0a3f9cc2f e1000e: fix force smbus during suspend flow
>>>>>>     c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
>>>>>>     bfd546a552e1 e1000e: move force SMBUS near the end of 
>>>>>> enable_ulp function
>>>>>>     6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD 
>>>>>> duplicates
>>>>>>     1eb2cded45b3 net: annotate writes on dev->mtu from 
>>>>>> ndo_change_mtu()
>>>>>>     b2c289415b2b e1000e: Remove redundant runtime resume for 
>>>>>> ethtool_ops
>>>>>>     75a3f93b5383 net: intel: implement modern PM ops declarations
>>>>>>
>>>>>> If you do this, I would revert 76a0a3f9cc2f, test, then revert
>>>>>> c93a6f62cb1b in addition, test, then revert bfd546a552e1 in 
>>>>>> addition,
>>>>>> etc.
>>>>> I have created revert patches like this:
>>>>> git format-patch --stdout -1 76a0a3f9cc2f | interdiff -q /dev/stdin \
>>>>> /dev/null > revert_76a0a3f9cc2f.patch
>>>>>
>>>>> I have applied revert_76a0a3f9cc2f.patch (rebuild and tested), 
>>>>> then in
>>>>> addition revert_c93a6f62cb1b.patch and after applying
>>>>> revert_bfd546a552e1.patch irq storm didn't appear.
>>>>>
>>>>> I have tested it with 3 subsequent reboots and in all those cases 
>>>>> it was ok.
>>>> Thanks for all this testing.  It sounds like reverting all three of
>>>> 76a0a3f9cc2f, c93a6f62cb1b, and bfd546a552e1 fixed the IRQ storm, but
>>>> I'm not clear on the results of other situations.
>>>>
>>>> It looks like c93a6f62cb1b could be reverted by itself because it's
>>>> unrelated to 76a0a3f9cc2f and bfd546a552e1.  I added the authors of
>>>> all three in case they have any insights.
>>>>
>>>> Bjorn
>>>
>>>
>>> I doubt that it is related to c93a6f62cb1b, I believe that is more 
>>> probable to be related to the two other patches.
>>>
>>> Apart from what I suggested in the other mailing thread (enabling 
>>> e1000e debug and to test if it happens with a cable connected),
>>>
>>> I suggest to try to apply this patch and see if it fixes the issue:
>>>
>>> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240806132348.880744-1-vitaly.lifshits@intel.com/ 
>>>
>>
>> I have applied patch from link above and command bellow really 
>> doesn't start irq storm.
>>
>> echo 'auto' > /sys/bus/pci/devices/0000:00:1f.6/power/control
>>
>> Problem is that after executing this command and plugging cable to 
>> ethernet port, kernel is not able to detect link (LED indicate link 
>> is on) so network over cable is not working.
>>
>>>
>>>
>>
>>  From mboxrd@z Thu Jan  1 00:00:00 1970
>> Return-Path: <intel-wired-lan-bounces@osuosl.org>
>> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
>>      aws-us-west-2-korg-lkml-1.web.codeaurora.org
>> Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
>>      (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 
>> bits))
>>      (No client certificate requested)
>>      by smtp.lore.kernel.org (Postfix) with ESMTPS id 7319CC531DF
>>      for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Aug 2024 
>> 07:44:59 +0000 (UTC)
>> Received: from localhost (localhost [127.0.0.1])
>>      by smtp2.osuosl.org (Postfix) with ESMTP id 2EE99404B8;
>>      Thu, 22 Aug 2024 07:44:59 +0000 (UTC)
>> X-Virus-Scanned: amavis at osuosl.org
>> Received: from smtp2.osuosl.org ([127.0.0.1])
>> by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with 
>> ESMTP
>> id VRgkrPDlq_WW; Thu, 22 Aug 2024 07:44:56 +0000 (UTC)
>> X-Comment: SPF check N/A for local connections - 
>> client-ip=140.211.166.34; helo=ash.osuosl.org; 
>> envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
>> DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53F64405BA
>> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
>>      s=default; t=1724312696;
>>      bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=;
>>      h=Date:To:References:From:In-Reply-To:Subject:List-Id:
>> List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
>>       Cc:From;
>>      b=ZIudOsHGSDoQvtekseiE4SUpOKofnvHlxj7aT3f7bLvqCDMOCfygsO6tctN23YgSh
>> xYqnq4yBSB4/JQ4v7Juyg0P/wqTcr+XFqhORTc2qBku9GCA+Y4wRKbRUeH4/AUNthL
>> cf/zG7uEOFEKz4YALwviQFqR5E+HW9gD+YnXahtGUVqYiTjB01HuESDZdYI5huiCLI
>> eHnQDw/SSwM1YmkjLzQgICjlxtIRVYjUL+shaltRg9f7t4otZa9bvrvLptzw5Mrfc0
>> GLvrNRmHckPFKEJOXgmIeQI40IOHckD3MX2dkQ2dQ0VCrkl9JIgtuSRuS3IpB1dr65
>>       TatTrq9Onm26w==
>> Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
>>      by smtp2.osuosl.org (Postfix) with ESMTP id 53F64405BA;
>>      Thu, 22 Aug 2024 07:44:56 +0000 (UTC)
>> Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
>> by ash.osuosl.org (Postfix) with ESMTP id 81E351BF322
>> for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:44:54 
>> +0000 (UTC)
>> Received: from localhost (localhost [127.0.0.1])
>> by smtp1.osuosl.org (Postfix) with ESMTP id 79A0C80A82
>> for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:44:54 
>> +0000 (UTC)
>> X-Virus-Scanned: amavis at osuosl.org
>> Received: from smtp1.osuosl.org ([127.0.0.1])
>> by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with 
>> ESMTP
>> id m9sJJpu9kR7y for <intel-wired-lan@lists.osuosl.org>;
>> Thu, 22 Aug 2024 07:44:53 +0000 (UTC)
>> Received-SPF: Pass (mailfrom) identity=mailfrom; 
>> client-ip=136.143.188.52;
>> helo=sender4-of-o52.zoho.com; envelope-from=petr@jevklidu.cz;
>> receiver=<UNKNOWN> DMARC-Filter: OpenDMARC Filter v1.4.2 
>> smtp1.osuosl.org 3674B80A59
>> DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3674B80A59
>> Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com
>> [136.143.188.52])
>> by smtp1.osuosl.org (Postfix) with ESMTPS id 3674B80A59
>> for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:44:51 
>> +0000 (UTC)
>> ARC-Seal: i=1; a=rsa-sha256; t=1724312671; cv=none; d=zohomail.com; 
>> s=zohoarc; 
>> b=B0wnUG3UHEcTRfbjC9HSfLJG+WBnpU18yag7r0240QuMQMnP/cHcj9e4oJU2FgxRPLpt6OGnlZOiPNE2GUFgnkBzKBPwzxb7eTHFwW4P8cW+1IrIOQ6jZWd2rhOIyWcRKYMydfCbMPM04Z+RwKVyRlrLTYL5UDBYYKKHOG08Ikc=
>> ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; 
>> d=zohomail.com;
>> s=zohoarc; t=1724312671;
>> h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
>>
>> bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=; 
>> b=VvZAc/xKVy85rZpNNCAwUwpxquk4r4Xw2QjZmePGlnINwOvJf6oilR9lqx2WDMezV20iKTW9f3dauO4jIjp363HOdh7P21UFfa66a0oK63RODo7IQMHSCqaCwAEoO1PKHfDfTMwz0/BShU1dt+nhtAeSeKwbG7G1qizCcoXTdjo=
>> ARC-Authentication-Results: i=1; mx.zohomail.com;
>> dkim=pass  header.i=jevklidu.cz;
>> spf=pass  smtp.mailfrom=petr@jevklidu.cz;
>> dmarc=pass header.from=<petr@jevklidu.cz>
>> Received: by mx.zohomail.com with SMTPS id 
>> 1724312669862808.3168476405893;
>> Thu, 22 Aug 2024 00:44:29 -0700 (PDT)
>> Message-ID: <5ba3c7c2-5695-421d-a747-2a23af48db26@jevklidu.cz>
>> Date: Thu, 22 Aug 2024 09:44:22 +0200
>> MIME-Version: 1.0
>> User-Agent: Mozilla Thunderbird
>> To: Vitaly Lifshits <vitaly.lifshits@intel.com>,
>> Bjorn Helgaas <helgaas@kernel.org>, Dima Ruinskiy 
>> <dima.ruinskiy@intel.com>,
>> Hui Wang <hui.wang@canonical.com>
>> References: <20240821145959.GA248604@bhelgaas>
>> <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
>> Content-Language: cs-CZ, en-US
>> From: Petr Valenta <petr@jevklidu.cz>
>> In-Reply-To: <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
>> Content-Type: text/plain; charset=UTF-8; format=flowed
>> Content-Transfer-Encoding: 7bit
>> X-ZohoMailClient: External
>> X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
>> c=relaxed/relaxed; t=1724312671; s=zoho; d=jevklidu.cz; 
>> i=petr@jevklidu.cz;
>> h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To; 
>>
>> bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=;
>> b=RSnIQpqoQp2O3ExJNnw4fk9dlt8CX1T5sbtB6GflBDYejiRQJTcrU3zRHn3pRkFq
>> tm00/cgXr6pF6T5vJFttBkfrHtnRiPiE8cjqni5KsNxCyOXOwri6I5ARAmPcUj42eda
>> e/xHQX9E3ayXrWSBQDAsun3Ann63tcXQKwlT7ffI=
>> X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
>> dmarc=none (p=none dis=none)
>> header.from=jevklidu.cz
>> X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
>> dkim=pass (1024-bit key,
>> unprotected) header.d=jevklidu.cz header.i=petr@jevklidu.cz
>> header.a=rsa-sha256 header.s=zoho header.b=RSnIQpqo
>> Subject: Re: [Intel-wired-lan] ACPI IRQ storm with 6.10
>> X-BeenThere: intel-wired-lan@osuosl.org
>> X-Mailman-Version: 2.1.29
>> Precedence: list
>> List-Id: Intel Wired Ethernet Linux Kernel Driver Development
>> <intel-wired-lan.osuosl.org>
>> List-Unsubscribe: 
>> <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
>> <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
>> List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
>> List-Post: <mailto:intel-wired-lan@osuosl.org>
>> List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
>> List-Subscribe: 
>> <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
>> <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
>> "Rafael J. Wysocki" <rafael@kernel.org>, przemyslaw.kitszel@intel.com,
>> Linux kernel mailing list <linux-kernel@vger.kernel.org>,
>> "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
>> Tony Nguyen <anthony.l.nguyen@intel.com>, Bjorn Helgaas 
>> <bhelgaas@google.com>,
>> intel-wired-lan@lists.osuosl.org, Jiri Slaby <jirislaby@kernel.org>,
>> Len Brown <lenb@kernel.org>
>> Errors-To: intel-wired-lan-bounces@osuosl.org
>> Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
>>
>>
>>
>> Dne 21. 08. 24 v 17:17 Vitaly Lifshits napsal(a):
>>>
>>> On 8/21/2024 5:59 PM, Bjorn Helgaas wrote:
>>>> [+to Dima, Vitaly, Hui; beginning of thread at
>>>> https://lore.kernel.org/r/60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org] 
>>>>
>>>>
>>>> On Wed, Aug 21, 2024 at 01:39:11PM +0200, Petr Valenta wrote:
>>>>> Dne 20. 08. 24 v 23:30 Bjorn Helgaas napsal(a):
>>>>>> On Tue, Aug 20, 2024 at 11:13:54PM +0200, Petr Valenta wrote:
>>>>>>> Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
>>>>>>>> On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
>>>>>>>>> On 19. 08. 24, 6:50, Jiri Slaby wrote:
>>>>>>>>>> CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to 
>>>>>>>>>> b2c289415b2b)
>>>>> ...
>>>>>> I'm at a loss.  You could try reverting the entire b2c289415b2b 
>>>>>> commit
>>>>>> (patch for that is below).
>>>>> This patch didn't help, so I reverted it back.
>>>>>
>>>>>> If that doesn't help, I guess you could try reverting the other
>>>>>> commits Jiri mentioned:
>>>>>>
>>>>>>     76a0a3f9cc2f e1000e: fix force smbus during suspend flow
>>>>>>     c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
>>>>>>     bfd546a552e1 e1000e: move force SMBUS near the end of 
>>>>>> enable_ulp function
>>>>>>     6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD 
>>>>>> duplicates
>>>>>>     1eb2cded45b3 net: annotate writes on dev->mtu from 
>>>>>> ndo_change_mtu()
>>>>>>     b2c289415b2b e1000e: Remove redundant runtime resume for 
>>>>>> ethtool_ops
>>>>>>     75a3f93b5383 net: intel: implement modern PM ops declarations
>>>>>>
>>>>>> If you do this, I would revert 76a0a3f9cc2f, test, then revert
>>>>>> c93a6f62cb1b in addition, test, then revert bfd546a552e1 in 
>>>>>> addition,
>>>>>> etc.
>>>>> I have created revert patches like this:
>>>>> git format-patch --stdout -1 76a0a3f9cc2f | interdiff -q /dev/stdin \
>>>>> /dev/null > revert_76a0a3f9cc2f.patch
>>>>>
>>>>> I have applied revert_76a0a3f9cc2f.patch (rebuild and tested), 
>>>>> then in
>>>>> addition revert_c93a6f62cb1b.patch and after applying
>>>>> revert_bfd546a552e1.patch irq storm didn't appear.
>>>>>
>>>>> I have tested it with 3 subsequent reboots and in all those cases 
>>>>> it was ok.
>>>> Thanks for all this testing.  It sounds like reverting all three of
>>>> 76a0a3f9cc2f, c93a6f62cb1b, and bfd546a552e1 fixed the IRQ storm, but
>>>> I'm not clear on the results of other situations.
>>>>
>>>> It looks like c93a6f62cb1b could be reverted by itself because it's
>>>> unrelated to 76a0a3f9cc2f and bfd546a552e1.  I added the authors of
>>>> all three in case they have any insights.
>>>>
>>>> Bjorn
>>>
>>>
>>> I doubt that it is related to c93a6f62cb1b, I believe that is more 
>>> probable to be related to the two other patches.
>>>
>>> Apart from what I suggested in the other mailing thread (enabling 
>>> e1000e debug and to test if it happens with a cable connected),
>>>
>>> I suggest to try to apply this patch and see if it fixes the issue:
>>>
>>> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240806132348.880744-1-vitaly.lifshits@intel.com/ 
>>>
>>
>> I have applied patch from link above and command bellow really 
>> doesn't start irq storm.
>>
>> echo 'auto' > /sys/bus/pci/devices/0000:00:1f.6/power/control
>>
>> Problem is that after executing this command and plugging cable to 
>> ethernet port, kernel is not able to detect link (LED indicate link 
>> is on) so network over cable is not working.
>>
>
> I have tested now how it behaves with kernel 6.9.9. There is a new 
> finding. After running "echo 'auto' > 
> /sys/bus/pci/devices/0000:00:1f.6/power/control" network over cable 
> works but irq storm arrises. I have never tested this before because I 
> don't use cable with this laptop at all. After unplugging cable irq 
> storm is gone.
>
> A possible workaround would be to turn off power control for the 
> e1000e at the kernel level (if is it possible) so that utilities like 
> powertop don't cause irq storm or broken network.
>
I would like to suggest the following for now as a triage:

1. revert the following patches:

    i.  e1000e: fix force smbus during suspend flow (76a0a3f9cc2f)

    ii.   e1000e: move force SMBUS near the end of enable_ulp function 
(bfd546a552e1)

    iii. "e1000e: move force SMBUS from enable ulp function to avoid PHY 
loss issue ( 861e8086029e)


2. apply this patch:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240806132348.880744-1-vitaly.lifshits@intel.com/ 



I expect this configuration not to have neither the IRQ storm nor the 
link indication issue (>"Problem is that after executing this command 
and plugging cable to ethernet port, kernel is not able to detect link 
(LED indicate link is on) so network over cable is not working.")

>>>
>>>
>>

