Return-Path: <linux-acpi+bounces-16056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E890BB34F95
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 01:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D41E3B5EF4
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7567D29C325;
	Mon, 25 Aug 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3ggrkJC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEB1E32DB
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163602; cv=fail; b=tjdp3e67rUzja5DOWQ6XcwyKhblSl4aJuAO1lpXqukCKS2DT3J3+UWGAkGgBc7CSdPN3/DBtRDLwyp/uxNYO3mBiiGGe2dI56FXM2KHxxzMG1JSdRY3kqu08wL7Zk4tbfo8LQwOCLLdcC6Fd/72HjyQUIiu9MNk1+KPlxzior5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163602; c=relaxed/simple;
	bh=Qp3k3Q6KlppVwi0m4ywvda34pQuOjU9KzUbRQobYQF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tbiFkl6NgXvEdWAcK+gp4N8lgKpTu42hPvrxhO+7oohTo+Gx4Fun/1CbtzwqLUfYAPYozKgwSjHKIPPMSXnBB/pyMC0PSMoomU/pTSjSbgmoTO93HZkwUCt3fxD8Q6x5yjM/E6LGYoTZExZv/eEAOSzFDpRSjSicHs7xEYlcZSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3ggrkJC; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756163601; x=1787699601;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qp3k3Q6KlppVwi0m4ywvda34pQuOjU9KzUbRQobYQF4=;
  b=h3ggrkJCX9drwpD5OyQlTmIPp22kfCmTo74fzCHAnCBcGuZSGxeXQLPF
   F1q6DCJbLmLWdMh/3Bayo4SNrzN4xgtXs2Pi2arT4IrafUkufsi0ytj1E
   iBXf60DvefloOryfBTsmgGtxSrAOeq0hCVFjkYgpiERa+r5A5y7QxmZh/
   CxUriJF7sV6I/mCws41BKnyqMYR+5oJNCRZ3XFmhxBbo9hHUtmr5t9ych
   m0vWW5PSMX2DpQxfjaDMpU4dtombALsZ7Cz/3XEIMhC+kRh+5RAkZ2GD6
   M/PpZxzHH0uioG1burIbxhRer7p96uw/1F2s9PJeTd8E5+Qg9ThZMfhFg
   Q==;
X-CSE-ConnectionGUID: v1i9lIkFQx6VzMOB0rnLGw==
X-CSE-MsgGUID: jyHGgD7QRzaN863hOrJnmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="57404416"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57404416"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:13:19 -0700
X-CSE-ConnectionGUID: sIZtCYLZSW2p7WxgCJmp1Q==
X-CSE-MsgGUID: veVIb/uqS9KabHZMmbtSXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200367810"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:13:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:13:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 16:13:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:13:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0Z90S51EC1MJY1goq6mloxhhoZ02olTmLu/TIy7ZLaup3wLldWW/usZNvgnJFIln30sDGBkI5L7Oqbmzx/ARBx0yW4MDqxUtPIrIHbLptSncZeTz/g18dJfvvpACH7k12CWlrejTAYp91LHLOLVF5Ulv+j0NsIld3NoMFRgWAAZLstGwhkpn8dWqZDf7yFCxJs6ibsF13e0qogkvF3IJs0amTB+THOWhqkHOKkKH3JyGGBPTeBAkbP4xbnH9+lWoLloR/jdNzj6BMAY6HOqRou/A7XVf7dESb6aAIOTQSA1218sl7BocUkW8FLtEz/i7AbCfSvmajZ0vlObM8TUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Eyw+XRcfUQh308lzb5uIJ9SHa/jMMC9mF+ufVyrQJE=;
 b=zALHJ0iQmxJzfWnL7nSr2qY4AXiruX2tDSj3HKBEiFP+qQX+f/G5TPA4XcvaCFHBiuT9VU/HUol44ZkOTFWLcudWi9TFh5uPhXT0zGvWlq2VQo7WxkP8PIrCNVlzVxqxWWqbKmZTJwRlV6KFlqM8cjq6vHuXrAPpjUny2EK2B7vYjgIVX4Wt89xusITRdhl7v1fg5wUGhm9Ey5CQ+joyQUdhqK22jZ3jgCeBEs4a01ri61IoPD8VOUVXKmQ6M201ofO/AX93QeoOGF2y2d6biA//JOZm4PHUAaVdp/h0D1P47UOCNoVERR98ICxoh1ZqD3VDE8bizMCqKR7yofIWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 23:13:16 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9052.013; Mon, 25 Aug 2025
 23:13:15 +0000
Date: Mon, 25 Aug 2025 16:13:14 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jiaqi Yan <jiaqiyan@google.com>, Dan Williams <dan.j.williams@intel.com>
CC: <rafael@kernel.org>, <bp@alien8.de>, <guohanjun@huawei.com>,
	<mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: APEI: EINJ: Allow injection on legacy
 persistent memory
Message-ID: <aKzuCobhkx9X-axW@agluck-desk3>
References: <20250825223348.3780279-1-jiaqiyan@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825223348.3780279-1-jiaqiyan@google.com>
X-ClientProxiedBy: BYAPR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::48) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: c256bfc3-dba1-4e68-7c46-08dde42cf8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gvgmYsh9ces/yqh97JVz+VI/Sr1a1e+5XCcm8zAVSq9M6k81sPqfOFcqEGie?=
 =?us-ascii?Q?9mBo54ZZyUdEI7Ibh5lXoVUpqvzRWZ9IvnaAPdOFxa81e9RqUKzi6mV1bE7T?=
 =?us-ascii?Q?DjEQAfVMqAAAke8jmi0IVqlp/2JzbQS2yd7hUuRFh7ZQ9/pnZ/bkINV1FYhO?=
 =?us-ascii?Q?SGzhQEIGSL1vsUYCzwQqtqiazdsymVAHLMEMeYm5WioiW7IWWsw8kzGAHYZs?=
 =?us-ascii?Q?pmm9xB9N3RwtzXUdFaeh2xZ/dezwd8rb3AGgLrpqkSLR/OpRkaxNhqTbC410?=
 =?us-ascii?Q?OMcNU/DHKNzj2FGm2bj8bnalehXhhF/ZNJ2vywF09yr6XqjJ1HueV4SbW534?=
 =?us-ascii?Q?lHubtXXu02/wASbchjjsmGl9cQHmGEOQmwXuo4maKam7ok6dSuufgvv8n7ac?=
 =?us-ascii?Q?tp40k8AOTcQfdfK2VCWm5LvNei2dSxvu8ltxTyUa3GUDasAtOuQawP3V1Oiu?=
 =?us-ascii?Q?Q4gNadiUID7xigW1OV4dMMdLPr9MSTxgd9vC35mhLUqSZYPY1OaRQ0b+uEv0?=
 =?us-ascii?Q?hVSbPALRD5TBJa/chD1B+vWRIUaSMmlDbF6oGmUoHzM7bd9RIUy7kyJ74JpR?=
 =?us-ascii?Q?2K+ND6gnCy33bSfwrfb8SU/PkSmK2HSYoFJT/12Qj5bbL38diHE8eoexyRG1?=
 =?us-ascii?Q?eFJz9k5dQ5gHyenhhnKUDcnKJ72cSC34T2jlUvIjFQ+sz2SUX3tUXYqJ7Nn7?=
 =?us-ascii?Q?AdFxPrbGtVZXjIlDlHPR9UMwM2x7jJ26S8svijgEo0ffhgYhfrElp04RmqcZ?=
 =?us-ascii?Q?KGqJ78LDhLNUmboJcU+Rcb9RFzfL6s9iLyn/3bfkOWYb+aMOnEFDeNjnqCxU?=
 =?us-ascii?Q?EyKIwq6IEZ2c3taGzg15tn1a4MztmKyI6SqWBeeStSZB8sI3Cdt90gC03win?=
 =?us-ascii?Q?w1NoAKUyak/5o6cqFqZZtdkebL5B0kcwORhTL5Bl3nzSx8lhOru3O4tzuu1d?=
 =?us-ascii?Q?Z1gqwd9raC4PtYDTfLdqRuTy9jshBhWebVLfcV6xHYeSSYSb0zI4zcZKSQqq?=
 =?us-ascii?Q?Cu4tG3Z10CXyXbCOXm8qfWRt5iUVuW4Qz4TzKGEOoC5FyVzk9LV58J0CwKZf?=
 =?us-ascii?Q?yUHRJBbphZ4vEkgcOh3J8GX078ga2tY1Yj44gr4o4iZlcGNOtLiZmEHFIhOk?=
 =?us-ascii?Q?XEY0+jA39+lWZ1UlF2/UVSb1t60o7aOdXfSYrm+VPqkRnsWRzpV3du5Q4Z77?=
 =?us-ascii?Q?YiXsDCNFdKbH5L1Xlcgk0dnuggQHyz8oO75dgIei0XpNNaU3CldHT/s3fNOU?=
 =?us-ascii?Q?C8gip7DeR9P8I5/ohh6w5BQtD1bCm4YdllFX6GoWNQwSD2I6S0IELtj5t8gG?=
 =?us-ascii?Q?6IC/2jaBxIWQ7+kC4ZsTxquPchv4RXAp+EmF2nPHgU5o+MSbzc57kM7AcNXI?=
 =?us-ascii?Q?+/wRbqqPIx1tJ44ZbHgnzsDXGdAZ5MooJVv20/LHvBR0NBdileRzUM9UlDbv?=
 =?us-ascii?Q?lnLs3xYCIlk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAWaAfPJ8eTjmwLpJhFLeRFvtGox6YphdKfYg1ez856Cxo4WE/cV/Qt/7c6g?=
 =?us-ascii?Q?TkcxGG6kYLBEudT8M21mNrWeE6sE8xYBLq5BsZkJNYqY98bgDi4vVbY7F4q6?=
 =?us-ascii?Q?PBO30b8nDKAyskcROFyFRBJiCnPxwIZR09CV8xShwqUMwRzpe7nCYS/sTi8+?=
 =?us-ascii?Q?KBCnwrfwZTUrkP68/TkGfVPN1XbvZF6ZMlc7P0On2ql0tMN6wbrtwlZ6WgHV?=
 =?us-ascii?Q?53ozj0jfOaABBH2vdF2F7BuBrqLWrJeZZIA7ZbFEck0kStAQ2RKLO5mxJlTO?=
 =?us-ascii?Q?3JG6kCz1xSoLGk2LtdI8ZjMwLAc0pey0dHMGgMdrb2Tce3Es5KQMDIgq5jRo?=
 =?us-ascii?Q?UJ+Flt6MXOw1goV32pCGImvBotIbdBGs9HrxQe8UNZDpxUQ571UFJtiG1ZNg?=
 =?us-ascii?Q?nWlYOoX2O+uk9yqUAIO+TELWtYxuO2Uuztnr7zea0Wnm9yx6g5Q2k45VftkK?=
 =?us-ascii?Q?qxEq4Pyt2tdaJlCEHhz79jWg7T1oJZ0mssDLTXKvwyjTNkN1BESIHHG7Sgiz?=
 =?us-ascii?Q?sWUyKV1HnZ35wdPieA3a1/oizOGbPZS4P+s25EsgmzvAkN2gqPZ1RYZ/Ki23?=
 =?us-ascii?Q?ICOS+YvavA2v8PIUo/nf7Hwg+lY6N+Qi36jqw/nekG/649rjEVcLDj67q/3+?=
 =?us-ascii?Q?yBEUh9otqb6YKxqEdzMh++KIrC3XvDSre/DeYVocEzmiCv4thqALADRjSrCz?=
 =?us-ascii?Q?k3c5cNaOAGyCBJXtR8MNRt+T/XOYXNLVdpZPvcel+67cSu2VJQOuh3t0geBT?=
 =?us-ascii?Q?m55gTcSpXPb6evqGjQ9dfQCEDjx70aKyHu29dnQfzdbG7IIfa8IMTudTeGuO?=
 =?us-ascii?Q?v5ErUPxCcqAUgpHR+ukT1wU8v0YKOQL2ErYrUk846r44Kp2BwYMGIFhsX4Du?=
 =?us-ascii?Q?Fx15/o+/hLmJIG49nKIQtNEba/T58lCMc5kNrptzcQn/mw7NGNtkK8/JzYur?=
 =?us-ascii?Q?KkD70kvry/2774NIoDOOuEeTCc+DgIp/mQsaj8vlEo6dMuMxder+rDY1bmCe?=
 =?us-ascii?Q?zeqmfoP0/nI9W8bmX+huiR71ddJRmShpJOpGpsSpsx4V6Ua1Df2uLDEQFRcs?=
 =?us-ascii?Q?KJDF7WOONiq2MpGKlBGheM2cuxY9NOrIW4Y1sga+iuF2/qFlBn2NsHO0c8iU?=
 =?us-ascii?Q?1XENJ9By1isWnIE17F86MRiEy8Xe5Vw+MtH4S2AO2IDO7JMBPu2A269pchZO?=
 =?us-ascii?Q?jOfZ/6Z289mag3Sj8ey3kt55PJ6Xk/HctFoYPPsynn0KpmokccTpWqo7MjA4?=
 =?us-ascii?Q?pAjuq1yNDiYhokovxRzSnLEdAePBUr4Fa3Y9uIs4/F5/4nkLx4IlltzXI54t?=
 =?us-ascii?Q?WcljjGllAIoJupf1X6rE+JsscYLeHKTmiVplr2+qzF2WIOVWRoNdTbCncF/X?=
 =?us-ascii?Q?A7PL3c4NfqvHaYds+/PVeKwBk2Zqb5/P/7xGCyEWknEWUxgt7KpeCDiToZTm?=
 =?us-ascii?Q?HUliTNkdXhL/sfAnQAfeUHJCHmTPqG1z+XeKeDR0NY2PW1sGvcntQ+jXgizK?=
 =?us-ascii?Q?FCcF1CUi6MFiXV55+r76OWCVigQYS4qCbiUzKcj6X8YUSa3ERRXHGxXaRQ+h?=
 =?us-ascii?Q?JQXsq7EEiOyKBCE0F52iMqonifh3PgRZMfZcPDrc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c256bfc3-dba1-4e68-7c46-08dde42cf8aa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 23:13:15.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+/W9zoOQFpAe3YFv8rsunCZKXCcNY7yxP7+oPbb37n2sF/sHa5FFypENbKzY4K49/QnaiG1zA2ZFZGHmm100g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5249
X-OriginatorOrg: intel.com

On Mon, Aug 25, 2025 at 10:33:48PM +0000, Jiaqi Yan wrote:
> Legacy persistent memory, e.g. Device DAX configured like the following
> 
>   440000000-303fffffff : Persistent Memory (legacy)
>       440000000-47fffffff : dax1.0
>       480000000-4bfffffff : dax2.0
>       4c0000000-4ffffffff : dax3.0
>       500000000-53fffffff : dax4.0
>       ...
> 
> can support recover from Machine Check Exception due to memory failure.
> Therefore there is need to test it by injecting memory error
> using EINJ to legacy persistent memory.
> 
> However, current EINJ only check if physical address falls into the
> IORES_DESC_PERSISTENT_MEMORY_LEGACY region. So attempt to inject
> error to "Persistent Memory (legacy)" fails with -EINVAL.
> 
> Allow EINJ to inject at physical address belongin to
> IORES_DESC_PERSISTENT_MEMORY_LEGACY.
> 
> Tested on a machine configured with Device DAX:
>   memmap=4G!12G nd_e820.pmem=12G,4G,mode=fsdax memmap=176G!17G
>   nd_e820.pmem=17G,1G,mode=devdax,align=1G memmap=176G!209G
>   nd_e820.pmem=209G,1G,mode=devdax,align=1G memmap=176G!401G
>   nd_e820.pmem=401G,1G,mode=devdax,align=1G memmap=176G!593G
>   nd_e820.pmem=593G,1G,mode=devdax,align=1G
> 
> Injected error at 0x35238d2000, within Device DAX region and
> allocated to a userspace test process. EINJ driver now issue the
> injection request to firmware, and firmware logs shows injection
> at 0x35238d2000 succeeded. The userspace test process then
> accessed 0x35238d2000, caused a MCE, and killed by SIGBUS.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  drivers/acpi/apei/einj-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 2561b045acc7b..e746fa66f92ff 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -712,6 +712,8 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  				!= REGION_INTERSECTS) &&
>  	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
>  				!= REGION_INTERSECTS) &&
> +	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY_LEGACY)
> +				!= REGION_INTERSECTS) &&

I chatted offline with Dan Williams. He wondered whether this sanity
check should just be reduced to pass through any address except MMIO
and leave it to the BIOS to decide what is a legitimate injection
target.

>  	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
>  				!= REGION_INTERSECTS) &&
>  	     !arch_is_platform_page(base_addr)))
> -- 
> 2.51.0.268.g9569e192d0-goog

-Tony

