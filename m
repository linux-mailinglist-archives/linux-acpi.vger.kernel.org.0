Return-Path: <linux-acpi+bounces-4141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE21873BE8
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F422B209FA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1A134733;
	Wed,  6 Mar 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjeJEkuQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3560912
	for <linux-acpi@vger.kernel.org>; Wed,  6 Mar 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741857; cv=fail; b=kGiS7GTcC7p30HJ5c0rNQ3v6VUEpG6tkHBrfBDHWkKCNelWl3h3OesSK3aF9lW6UPjvmzrA31kqYUxwAI0rYS1bEGUm4S3qxpDLPBsj0GSNC57PVefFRSHfL4A7V1ewSosWN3IHqTtjVEHB/yOEJQxC1lhauh3ossR0EcqGNyh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741857; c=relaxed/simple;
	bh=VMXhFIlcuVaRWRxUfp/4tutmFkjGW600nOrrBQ4LTlM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HYTwyccbQXmSQ1j29X8NIjdqRkG6Ul7Ph7JZ/d7FmVk6LfRbPEIAlBPQBFkXUEG7mN2E0FqHHL2CMgnt6MMFe4jSz6wwOeqc+GAN5YcArU3Rs5HD77sE1zChzbqXkhB9IUJc0pJSlNUCNoP5DlohzytqkwMpQzkFUatPlkTgkks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjeJEkuQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709741856; x=1741277856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VMXhFIlcuVaRWRxUfp/4tutmFkjGW600nOrrBQ4LTlM=;
  b=cjeJEkuQCNJMql3KePuCwR0NxnDE51MwKwiKgCtK9NjBAt1rJSb8ZZBH
   JL1mSnJBbm46gieJQ9tvV5QwTrcSLIOkvRE2p9CKcSUABea4yhWe2eOW5
   d7Eojl5jqu0MAH76XK/NhvRrrpK2SlNSt2DBIeToSH6R7nGmVEgDwc6Ck
   bnFXPjB+ahXCoTvogsWJ5DJfPbLCLBZDD5sRH8HuV2a95cEX1Dhxt5BXc
   RlNtcOFL2365Iev7imQSKwp7g71ZO6KLCDZA/JWa/rdXjbzNA06LgNbwu
   uE5IbzoDvNdOWpGIElJhTxvwFk6dwuDXWK0KLwirfjIWNAnH6l3tBCwYg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="14940451"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14940451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14453142"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 08:17:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 08:17:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 08:17:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 08:17:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 08:17:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpgYZU6BBuximEb9bEuJUbfTSq9G2UPE0vpDeID9gHhLavl7fLWw6aFPmE1bROp36uU86iZMnjsNNguD914zSJHXPKcYZgXKwQLmbwHROm0vkQvZddOoRKzXd6pjlG9nIDJ9uPybHgijKdnpbVrk+oE/ZECHmcUDlo/n+2Z19dmeEkJ71j/XOMy8Ax4BguiJ/RW49ramaHoEvQCNDtNjYtNeIagHT/AGtekJuWMbfs1b8ggYOw8ON36jny1Y7dWUPZ3t/jHmxdtjy8km4sk8bNUzEgvzn9qaxwfBCC4Oo4ZgQkRCB01i6/x1yFYjVgZEYVgzsn99uGifsIf+yxEJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h40LYVQFuu7B6b77TEwhoKLkkaYHGiOeL8vYHuQyR74=;
 b=ZdgsfKgxDBro0oUrM81ZCQl0Uq3d7NdHMqGDGt6ZjCtbxxWqVVuO8GOY0Od/J+4V/iauzI8MuDcLvnI6RrXhBD92proFPa3ldMrJIRAuDO3tQeKrm7G599VxabPo5amVnb8Ngaqag0nax7s3Yq6ya/m9I2IOCYKZXJmaas7Cuv148xu5Y0zrTXXnkvS0iIZgVc1edm54cfLk9GrAFXzmgTcS0bBM87lOqeHo/q6L9/f22J+aOgsW22UUqCYcHyXK3do05cPVbl1/C3YC/3ytFOzrSdDoIJHXsyoaHat6b8G/RzylObkuHNHn3GsEeNiBriVWgTl2mcKygbLn1ii7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 16:17:21 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 16:17:21 +0000
Message-ID: <5b615397-2c9e-44cb-8f2f-6f763f0643e9@intel.com>
Date: Wed, 6 Mar 2024 17:17:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] ACPI: NHLT: Reintroduce types the table consists
 of
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>
CC: <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
	<robert.moore@intel.com>, <amadeuszx.slawinski@linux.intel.com>
References: <20240304161335.1734134-1-cezary.rojewski@intel.com>
 <20240304161335.1734134-2-cezary.rojewski@intel.com>
 <0d1b777e-bd95-4755-8e4c-ee37640d155b@linux.intel.com>
 <ZeYlrwqDQLAcFcnl@smile.fi.intel.com>
 <17d55fd0-8884-4f05-99f7-abccdda0e174@linux.intel.com>
 <312ff9d7-8b90-428f-b90c-ebb278e029a7@intel.com>
 <b10ddf2f-d6c4-41de-8e62-305f1d7e6e63@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <b10ddf2f-d6c4-41de-8e62-305f1d7e6e63@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::13) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|IA0PR11MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: c71b621f-93fd-4aeb-64cc-08dc3df8e6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pehalmk+ALTVIV1v1QSKvbV6sU4eMnXJkxBryxrD2VuCI2uHHN+SlycUDKvy4fEiipjJYRxbotBa7VxtZ3TCWyleVvtftTaSHTozDgwI0hfsHeWkda9hJJ8VM3ldzT2UhukVgeb6xYBpbV3lPktkMNx2ZtlKeblAwtbAzvV9CS6bSP6KbQwfkZjLua4StpPuCFGGGRxREPPO3NlyAtKHJXdGuVFgNMJCVZzayCyygOundT6nUo9E2L+TiZG2dn3xcfVsa3qFH87mEzkLOhh7ahQKrU3iSLP92ULwb/STK73EL7xEMNyP50q5o7oAJsxOjSiIHt0x2kyLXVgW+Hkmxasu6PIF9uvzYExzxCTdrqcYWoh76iSWwMiLxnz/plSo4pwVOACyegLSh8UX9w/sfkxs1ImqvWZ0kmpg/hBespveScCOh/T4bKMAp7Z0hmHs8lFGYuY/vzVOUpZeENZrn+en4wFCrz2YVu9hPT6DB0ZxWpMXYF2wunpD1x5zjhVxEon5IP3hjFhJbCepfBp6p0S1SljU1l+3bO9PugaiTRhb/BNbX0fLISMo9Zk/AhFLuUzskgF+LHJAk7/tSVNxDSCwqaRqPCvolhUMtqJQ/YYOG1yyoZy1wfePxu0/luUgpP58xbJgZWsLjOJt24kvRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWN2MGQ5QXlmZ044bUJaaDhZcnFlTGdpU2JTQnJKWmFhU2hWRkpXbzBxem84?=
 =?utf-8?B?NXRNUmk0ZGVCOW9lMm1NcFVpaHhTa1pEKzc1a3NmdVJ1VHlFVVZMV3doYVZx?=
 =?utf-8?B?S1lzeERZNDMvTG9TbXFxWE9ERWNIY2NobnQ4U25pbmNtMXFlUk9rNkhSZytE?=
 =?utf-8?B?RFZqcXB1UnNjUVR4dklZS1BGQTdacXVmblIya0ZoM0x1V0lpdkFuOCttTDBq?=
 =?utf-8?B?alMzYis5U25zay9uS3VMTHF6d0ZMaFY5R1FFTFIrN1I5MGlCZ2Y1K2h1Rnpk?=
 =?utf-8?B?b2VIVG1ydndsd2t3UDR5cDV5SXloKzhocXRMNVRvZHFES0V0eTUwZ2ZwaXNH?=
 =?utf-8?B?QnJ3MFA2cGZoNHhJZFRWMXRRaUI5SmpOUHkrb2JLcmdVS3FMbkVJcjlvcWdw?=
 =?utf-8?B?cUc0U1pMWXN4NFRwTThYbGViN0J1K0JIUGJuNE5teUcwU1IrU0lDcU5SeGtp?=
 =?utf-8?B?T0RUeVd1azdUWUlGNzFYdGxqU1EwNmZNNEE4bDZ5S1o3OGRKM29ia3lxRjlh?=
 =?utf-8?B?NlFwVHpQWjJKUlYzL2dHWk52MTVSaVZzeW5XS0MzSXZuQmVpZ0lmM3FJc2gy?=
 =?utf-8?B?U3lwdFpxcmRKTmJrZmkwK3hlYmQzU0kyS3ZvNytBQnBsMUllYUZRamEzaFFH?=
 =?utf-8?B?cDNxeDVHVXJjQWZ4cGtnUXFrUmFRUWhmN3JZQUprcUdJeUJOQXRCKzhkVGtu?=
 =?utf-8?B?dGhYTXZvR2s0eHpvZGUxMldiZlFLRlJsaTNmVmM3MnNtS0VaYThwSHlrZFl6?=
 =?utf-8?B?N3VMeWVleWh2TVZGVnZXQUNsWDQ3OFUwaFV2Q3RPaXdtYnBkYTBwcEkyN01P?=
 =?utf-8?B?ZHgzRzAwdjczcjhnUHdFaTIrUHJhaldJRElCT3FjQW9ieGRvNFBKSlJXWHQy?=
 =?utf-8?B?N3ZWdHluTFZvNkhZS2tLUmpNd1dBZ1FLMm1nYURuYTZZWEhWVlovaTY2d3V0?=
 =?utf-8?B?U0pvUXh4djVhZXM4SmFGWnc1aW5oODdiaXVscGM2R3lSazFQUmNsQWJJYVZZ?=
 =?utf-8?B?M003bnJCcW5EYlU1bVJESldnUUVCSlpEa1BjRTY0L2RzVmpRNUlWekQyRExs?=
 =?utf-8?B?SFlieWpyWGxTUURDREkzRmxVQnUzRkR5RlQ4VGtYUnZKNmZEQVg0enpGWCtL?=
 =?utf-8?B?enJBaVY0MGlSM3puZXI4SDRBdlF5NzMyUTJFN3dHaHo2QjNHdVdPNGlMaHNW?=
 =?utf-8?B?OGJxcExNNjlJYmVtSytCd2c3RXRUZTdhcVl6Y0xsd0R2bXNKaW1ZdWR3aFZv?=
 =?utf-8?B?UGxYUktQSGpkRmVtajQxNVR5UnEyYnFJazhJUTdDdDdxa2hla1JRMWJCQTFk?=
 =?utf-8?B?QkdaZmwzQlI0cCtkZWVRUTZaWFZSbm5nbnJ3cFlLZ2FVdE05dUd5eVBVL0F6?=
 =?utf-8?B?V0dWak94TG9OZkdJRFB5d3huQ1Y1Z1RzS0FvaWNNRFdKMlhrYkk2aHBmajNV?=
 =?utf-8?B?Yi9qb2tYeGRPbkE4ZlQ5RHJ4OWsva040Q3lYRHh4VlF4alZzT0hqZnZtTlhX?=
 =?utf-8?B?TStOdXFZUzBDaXh4YjB6TERPR1RBbGRiK3N6eUlRb0FpNUFCMDZXa1VzOHRp?=
 =?utf-8?B?N0hVOXRSSkpUa2NBV1M1aENRYXVBbDBGckRaUVpEUHFVSkQrSDVFKzdtUURp?=
 =?utf-8?B?eEdtbEE3dDA3d0IwS2V5b1ZmaDI0NE5WYk92V1hRL3p6a3JIVDUvRWZncktW?=
 =?utf-8?B?cHNpUUM5WXhUZlNoeU1XR050cWFBUGczcnU4R0ptRVlnaU0xWkpCZExKTTZW?=
 =?utf-8?B?Q1pJMm1ZenFHZ2N0bjY1R2NNWHQwOUtuMHZmYmVveHUvTDJiS1BKVDVpWEVn?=
 =?utf-8?B?bTR1T0tJR1RCcXJ0UUFWaVZSTWNORS9MSE41eTlIQURCaFZoQmFDQzB4TUQ5?=
 =?utf-8?B?cjVXTXZGbVpyb0FPM0NRaTdOUTFiNGFoZk1GcHRSbjB6RHBseTF2RjZjOTZj?=
 =?utf-8?B?RjcvUFFSK0NyNjRGQzJ0eXBRUmpIYmVJdnRBdG5UTEhJcjYvbDloTUl5Mm1v?=
 =?utf-8?B?Q1NMUS9nZitOTVlRT09FQUw5Y2MrdEtUdU94K2pBUXpGblRkRzhwdngrVHlE?=
 =?utf-8?B?RTFtdzBQbVlkclBHYk5NS0lrVFFPaFo1WWVCVEpiNXJkL2dQbWMyZDgraUV4?=
 =?utf-8?B?ZW81aFZXSEtTbkNkODF5VXJWbG81MzM4eVJqNDVsWGF2anp3TXZIRkIvcUg4?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c71b621f-93fd-4aeb-64cc-08dc3df8e6e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:17:21.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzYraLx08AIAKIN0tNnRL84qnquRXDs9MIHFwgnNdEd/Xsmg6jDVoFfUd/43VJfbMidjymS0drzN/A0JFKxp6xGpyM5R5oG+jWSQJysMvAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com

On 2024-03-04 9:46 PM, Pierre-Louis Bossart wrote:
> On 3/4/24 14:34, Cezary Rojewski wrote:
>> On 2024-03-04 9:22 PM, Pierre-Louis Bossart wrote:
>>> On 3/4/24 13:49, Andy Shevchenko wrote:
>>>> On Mon, Mar 04, 2024 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:
>>>>>> +/* Values for link_type field above */
>>>>>> +
>>>>>> +#define ACPI_NHLT_LINKTYPE_HDA            0
>>>>>> +#define ACPI_NHLT_LINKTYPE_DSP            1
>>>>>> +#define ACPI_NHLT_LINKTYPE_PDM            2
>>>>>> +#define ACPI_NHLT_LINKTYPE_SSP            3
>>>>>> +#define ACPI_NHLT_LINKTYPE_SLIMBUS        4
>>>>>> +#define ACPI_NHLT_LINKTYPE_SDW            5
>>>>>> +#define ACPI_NHLT_LINKTYPE_UAOL            6
>>>>>
>>>>> More than half of those values are not used. Is there really any
>>>>> benefit
>>>>> in exposing them?
>>>>
>>>> Sometimes a code is the (only) documentation. Since it's a global
>>>> header and
>>>> part of ACPICA we probably better to expose all bits that are defined.
>>>
>>> NHLT is an Intel-only solution - no other company uses it.
>>> Intel does not have any designs where SlimBus is productized.
>>>
>>> I fail to see the wisdom of exposing a non-existent option with
>>> LINKTYPE_SLIMBUS. It's not because this case was listed in a document
>>> that we have to add the information verbatim in a open-source header.
>>>
>>> Likewise for SoundWire we do NOT use NHLT at all...
>>>
>>> Options 4 and 5 are completely irrelevant. 0 and 1 most likely as well.
>>
>> Hello,
>>
>> How relevant or not given field is in LINKTYPE enumeration is..
>> irrelevant. Those values are reserved since the dawn of the table.
>> Renaming those with range of RESERVED_X(s) is hardly an alternative. On
>> top of that, specs which have been publicly shared since 2016 _do_ list
>> the non-I2S/PDW constants when describing LINKTYPE.
> 
> I maintain that all those values, while spec-defined, should be treated
> as not supported. It's not unusual in engineering to change directions
> and back-annotate, demote or cleanup initial designs. Change is the only
> constant.

What's the proposal here? Would comment suffice or there is something 
else you have in mind?

