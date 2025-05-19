Return-Path: <linux-acpi+bounces-13790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC581ABB46B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 07:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89171724C8
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 05:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C91FAC23;
	Mon, 19 May 2025 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDD6+O4Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA71F4C9B
	for <linux-acpi@vger.kernel.org>; Mon, 19 May 2025 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631943; cv=fail; b=BgZ9exbRg6yzrtN39WA1AV9OiJPLI01cF3pNODNIo67W2+g1f1Ajf2HqUG9/moN/2d98JpI2TYB/DEGP68D8RYrUtRUAthecNG2S6j3pO/v3Po6vN/S01x+CFy2sou6PMl8boHAY85g4okWLvTl0Jt76a0Rd4qHF0p2AlvBrjgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631943; c=relaxed/simple;
	bh=EV+I3MyQO3Z//9+3JlRJWKe1Et5GoD9oo5JweZukego=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JsIbn1Vj17FIiJqukNyq7WcrO3XHdopSpIOntu7L583Y24FwhDQZtkoXfx0w/bvcDBjaPQqug3EHMgkwhUWjevIv0WLHb15ePWFD5fkXvU6CpE1f6y9+UBQ3Lk3hCLyClBrgRfjTiLgZpD3oa82ykrSuPcHb+kFQcZe9LxPAS04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDD6+O4Z; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747631940; x=1779167940;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EV+I3MyQO3Z//9+3JlRJWKe1Et5GoD9oo5JweZukego=;
  b=KDD6+O4ZpSZc0NH4yaZUONCXfNZLAv+OytD+tKp0Rt8E2f5n1hnI0WjN
   s7lXakQKpmTWhICGh4m5lm0zA1X55EBsnw/M8byjEOEBsy5SPm15f04xs
   X03tTCgUkuTYbx2w7FZA24N9xN1He3IghfwYq/FGIdvxPxIBXgRlbVla5
   E2x4StGKmzCrLsOatFocmWSTcBGKD1tpPgkYWpKTXkey/Nj5UKJOtF0w1
   wA3ngm+VKwxUAVhqguYebr/KfHbRrZ9IuQyQoTbD78g6Fsj58PKZXZaes
   LO5AXb2YN0X2kAtvoCLMBgbZ17ddWykY1vDSRxibf5/zkcLMwrcT5KwyD
   Q==;
X-CSE-ConnectionGUID: uWCVCd4RThihLYv7Ms8QxA==
X-CSE-MsgGUID: wgDg7j1OT3qxuOJ1Gl0iVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49582665"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49582665"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:19:00 -0700
X-CSE-ConnectionGUID: +T9wGcigSXW35PmyGkoISA==
X-CSE-MsgGUID: bSDhoQxMT2Kpa/1crcZRAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144238248"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:19:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 May 2025 22:18:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 18 May 2025 22:18:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 18 May 2025 22:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv7Io+uUn3ndh7iDEABocIWPi19MtqOyJAIP+SagnJfc5JIxautxBHLlU1gud2Wr4x+N3ayoU5oBYQygxUVIa4hMsDjXjVbKrPXj5wF6uJsmX0qxJGfSQ9JSIGFZr7BPInpIxLOlRCGE6ahPfVeF5hzQagrgUNY0WWJ0LqZqhCUy5P0WSdcmR4C10IHO0g8HucRMwIbIUOvfInS5smfry/Ue2dxWx5vQpTXAx8VXptme+05Mhn9A7oNTYXL9SmkPD1hHBcam3yjaceoKPT9Z0R96hr2unCDLdgBZ6KVompxr7GOs9Q+faTxfDHS6t7BXwlFUK+j77DpRYQY2/NxkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSb7mgbC6LFWs72bQcg/66nkfJXx9uCFRSCCi8Yp1mM=;
 b=kCWk/vGvAI3Xbir1C8vV0cwac2eVbs6MOF1NaKh/WSjbBo5MkA/KPxV3piS794nheAlDLs9pL96k/TIdtlXQQyyGiNVWS7aba3OHejc30B7KMgMMIbNz22mxl6+WfVh5hGBAGWczAfJFy2qJKtQS/d8d4qWtBNQt84gPvPBgh58m7kxMo8hAr05TLDyzgxycAcW00ZSWypQJTL7UXdbl5dVFdLhRJFul90kyjeuK/6mHqn4X0LU7t/rMcoeCON2s2JYj6g/bwSyQR8kH74qFGHv4wee/FzRF4/f/A1WNMklMPh0vcsP3ItHSTKuGVYhozMSLG+1xzHLnpyGaUi4j4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 19 May
 2025 05:18:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:18:30 +0000
Date: Mon, 19 May 2025 13:18:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: goralbaris <goralbaris@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <robert.moore@intel.com>,
	<rafael.j.wysocki@intel.com>, <lenb@kernel.org>, <skhan@linuxfoundation.org>,
	goralbaris <goralbaris@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] acpi: convert strncpy into strscpy
Message-ID: <202505191014.718ca1d6-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507152045.12266-1-goralbaris@gmail.com>
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: e967c55f-da1b-4cc6-d185-08dd9694976c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?m0YZYFcUPjYIgTiWVk/xa/UX7uyhdhcIlTY6F2giXoMq4Xi+jK/FMEb2lO?=
 =?iso-8859-1?Q?QYxGljkufUhTtGi/wyXLJ5VpaOf1kL3lDtTbUR+OghPmih9UHzhjbd3vL9?=
 =?iso-8859-1?Q?TGS3kL+iuiqyX/S2gmhEgGxX1X798Ib4pN/HvolLR6siyMC1R0bTv/jH1B?=
 =?iso-8859-1?Q?cgiGxrmQddldDlWMDJ/k+XA3+ttHKA7hNW+pqnmD59UWuLedtxn3wDgTiq?=
 =?iso-8859-1?Q?cKjzt+K0NvdZKe0mC00+OZC48WqxjoDfhRsOWBa43SYz7tasXQVwxh25X9?=
 =?iso-8859-1?Q?a7k7AU4EhVlcC00xPXqK9IxCFkTdeKjpAm77Mxej0cXj3G6n27xH7fj/gs?=
 =?iso-8859-1?Q?Mo7eQaCFcphW6dUEC9/QdWNpsgG/KJ3wGrcT+Kr0tyq6aP6SNDQa093qEt?=
 =?iso-8859-1?Q?yXl4pvifpuF5jr/cvvpfGn5rVQ68w1iKP3dVBcDsBbtm7dqBLNIg7Avd/6?=
 =?iso-8859-1?Q?ow3HWatn/s2tvU/lMY6vnDiRmmA6NEq6CA8/NgqOew5ppr6c8twQIZDpcD?=
 =?iso-8859-1?Q?WHvcZCwxCC7C6LcDdbhR8Ci+zCDSBUcF+AVN5SKf/bBtQdY/ZIM13NwYvS?=
 =?iso-8859-1?Q?4mQZdqBgNxLDr3nfWKYxqDMt85Qwuw8hCUAuRcBUGAHGemlOS4+xKeIemv?=
 =?iso-8859-1?Q?V3ndJ0bMqZILOEiThl1nwi6ma9r2rVTLULOhTTKxBtFxfG7GLpU7kVDynn?=
 =?iso-8859-1?Q?zmt106g9aT0vGRJ1kYeYdqcKin24zw2IIBzkH9GYafSSZFin8s4awn4DY4?=
 =?iso-8859-1?Q?WwaTUwjbp2SsW7ZioUYfmVtbZD2GCr2RWEafE2ZxMZm0Tu9BffEAyAzkMB?=
 =?iso-8859-1?Q?gamtCJBxdoWnvUigQApr8tH1t+jyYoqil7BCVvHlgl2iwTJt6kr7YZk+UJ?=
 =?iso-8859-1?Q?h4ntjl2LBtgU4dQ8jm906OCJZPKcRDxQI6lHIF6vKrpicpu0Ywdrtw5Qvn?=
 =?iso-8859-1?Q?YRP7xYkV0YxE/MNmpR083Ujp+chSyZ3QV1y6YqVIOyY1jNBOnyqMw6Nvmv?=
 =?iso-8859-1?Q?2Tp3MFqSX5I7fMKvf6bK6N9isG0QcyM+nhVLutE1Ya+eDfmbYFnUI0ieAH?=
 =?iso-8859-1?Q?p+lwJj1dhc0beqOc0Y6PIA0WLI6X0UI61Fxs3WhZmuqvVUqjAGtgHSKSlQ?=
 =?iso-8859-1?Q?R37QUtW+3NLCYiNY+yLt9q5tYo2jXJlA63rZEDc3GidIzoHSuzgH5tlP+0?=
 =?iso-8859-1?Q?5TdGp3ndrC5oDaeBirGkq1hFPyI8CDHD2kOGX6ycYuwX1p191RA3NsizDi?=
 =?iso-8859-1?Q?gkM7qcoHb2wE81OhV68tix4c14sIhYEW8Ya2/WP+OErSyRlDE5HXH8Q3Ze?=
 =?iso-8859-1?Q?1hPbplcydhPiPiY9Iulnb8Z85UKDljgtKZhRQPOAz2uMR3L9hbxKvUPEjP?=
 =?iso-8859-1?Q?XJnGmTQmGh0byMo9Vu7qHYwo5LCjFiIR9jzfG/Ocr1EsjxqvANzIR79M3D?=
 =?iso-8859-1?Q?rXKhBFuaV5DwH/Zi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XVLjDQESklN7D9jP58TtzBeUe9qhALBJdqZC05RWul+ieOTZ63C5zDUTum?=
 =?iso-8859-1?Q?aG0Xv6BtjyMJiEdvJ8v4VlZ8fFjQ5otCjcJlXnD600kdKxfPmywD6dbpyW?=
 =?iso-8859-1?Q?YiqXNyVqqGIZvUHpFOHmhZQ37RyZARWNLiK2iqJP3Thqhg39qJFqTivuZ8?=
 =?iso-8859-1?Q?pu9cwSoe8Xg+R7zEmSwYlRejfC483W9tBG0IxTfBiZLRj94ekqqsX9Qh1l?=
 =?iso-8859-1?Q?bWWn8Vf60Qs9yqop1bzT4qlLAIo4PS+GPjbqNUPk9qLinJzE7YIy5HLfE7?=
 =?iso-8859-1?Q?zSXsIGWwGV0QnqLDg2ZBrYj80lGV7lsGTo0xqCEhRF2VgMS55yAYmmRYHZ?=
 =?iso-8859-1?Q?w/Na4iRs/1rLYQVIQMnOhYGGPKRA+X9udRz68gy6U1wIvtwitK9W9VyY/d?=
 =?iso-8859-1?Q?QoOG6dLgdopPyUoW8s864afCBiyvWdQzlvNO2P9afGq8Cm183Xt1lZ1252?=
 =?iso-8859-1?Q?eg8fESz5WkC+4++rjLTlJLT4ZWWhKG5flI5YGZNsVX7wsQo5JIp+qMxZYh?=
 =?iso-8859-1?Q?rj1HO7V3KvYa9lSjJJ7qghHH//yOQ+qJIxPfG+G3hRmGC927rbQK4tK3c9?=
 =?iso-8859-1?Q?N/OQiGz0MctyOnDpHFkuOmQ29I4MUw5se3IczNQIxg5dxom/N7f3ognQCZ?=
 =?iso-8859-1?Q?Qd580bFbCBRgKA+JD0zNMr5kSLT4aIeCM8pGVyX8jjpaVGMECouyjI7jqT?=
 =?iso-8859-1?Q?Ml5tdR+ymYdyXj6rX+l1nMPEWDcIXQ8i1zMQbC4Qxrl9Gsg6OHy9j9/4zi?=
 =?iso-8859-1?Q?ABWegYwZohPJ6zbDTbzmvZZyDEeJc/myN0EQpw4Wn3eH7X5SzMTc2LLFDV?=
 =?iso-8859-1?Q?ZxW5g2exKihqNY6uCD6cu9ub9/T1aGCYLy/ncBIGLHTsHECvT7Rf7011Eg?=
 =?iso-8859-1?Q?Fb60BErxAeSH0lCKiOd3XJOyy9RDb14Vd+JEZd1dJd4cnCoSbRwCoCw+83?=
 =?iso-8859-1?Q?Rb/bhtPso5V2wj33yE08TsroagREbA757JQl0cGU8jmpIw/B8KB2r0Z/Sa?=
 =?iso-8859-1?Q?v+aBfpgTQCOvRiV+oP6eWskTY+icHLC+JscQCHA9UMyb9+0X/wkpgihjL3?=
 =?iso-8859-1?Q?hJ7FHrYuSJBwqOwyjJCJC3TFYWw3Zua+R7MbJj1fl5z0uzpHGx1p3pVTPS?=
 =?iso-8859-1?Q?CLevU0sep3SlSoqeQsXgMrClqgFUC8PVrWZ1FEzJOFAMVtR90D+ZIGYeIL?=
 =?iso-8859-1?Q?ZvP757mtY+7EHMpdlsANIEvHzSyfI0Tc21PuP1yUtONL8XILV+XBu6Z6bi?=
 =?iso-8859-1?Q?oTZPM48AsD0cl3qwdbmplVu+rwfB2gj0woOM5s0OgUlAWYGzDzrDXlORO0?=
 =?iso-8859-1?Q?nXU7eWsfamRsrycgZMZkTKD+G9WgEZR9e0r5JOXB9HQmKjJ0ffz4p7sh0h?=
 =?iso-8859-1?Q?LMZi3STto6y8z9OOl0AHyMqWaV1gKP+NAW3b1IfE/yEEGkKVkxydSL0ovd?=
 =?iso-8859-1?Q?6utwh4FnkgOfNSt4iIa71XSfq2gQeYTGj39r1An6jes66pPNeLa0sTOynM?=
 =?iso-8859-1?Q?TR4zeR6tEUDzC01tU5dsOC9juZv8/20GRvGQYSAyCqkZxSnuMgBEZ0etsD?=
 =?iso-8859-1?Q?5orrdHnnUpgWxzrNPKfOYBTuHzmrbwPZlR3fbHsPOTmCbBtXtXvjUX9gtI?=
 =?iso-8859-1?Q?lkuchmpmjYYCuh6Aki07jyqh1rwxJIOED58ON0i6wWxCsM/saFl+erNg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e967c55f-da1b-4cc6-d185-08dd9694976c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:18:30.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tN2U8BJQ2ZR1B8Lg4rqxTJWSfMerO2anrs3ZQgyalzx5Mg67GxIxDDfrHx4gzhNWA/tRGNTsHo1N+RZGIyei8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com



Hello,


we have no idea how this change could impact performance, however, we saw
several performance improvements as below.

for stress-ng.nanosleep.ops_per_sec, we did some cross platform check, still
observed similar performance improvement.

so we still make out below report FYI what we observed in our tests.



kernel test robot noticed a 299.9% improvement of stress-ng.io-uring.ops_per_sec on:


commit: 4a9f46a472591e7ffd0e9c5d8cdce26751852554 ("[PATCH] acpi: convert strncpy into strscpy")
url: https://github.com/intel-lab-lkp/linux/commits/goralbaris/acpi-convert-strncpy-into-strscpy/20250507-232259
base: v6.15-rc5
patch link: https://lore.kernel.org/all/20250507152045.12266-1-goralbaris@gmail.com/
patch subject: [PATCH] acpi: convert strncpy into strscpy

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: io-uring
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.nanosleep.ops_per_sec 23.8% improvement                                 |
| test machine     | 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=nanosleep                                                                               |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.nanosleep.ops_per_sec 115.3% improvement                                |
| test machine     | 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=nanosleep                                                                               |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250519/202505191014.718ca1d6-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp2/io-uring/stress-ng/60s

commit: 
  v6.15-rc5
  4a9f46a472 ("acpi: convert strncpy into strscpy")

       v6.15-rc5 4a9f46a472591e7ffd0e9c5d8cd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     20.29            -4.2%      19.44        boot-time.dhcp
 8.679e+09 ±  9%    -100.0%       0.00        cpuidle..time
 3.258e+08          -100.0%       0.00        cpuidle..usage
  20990053          +305.8%   85176369 ±  2%  numa-numastat.node1.local_node
  21106117          +304.1%   85283811 ±  2%  numa-numastat.node1.numa_hit
    124217 ±  9%     +25.7%     156113 ±  6%  perf-c2c.HITM.local
    126125 ±  9%     +25.5%     158230 ±  6%  perf-c2c.HITM.total
 3.642e+08          +299.9%  1.456e+09 ± 25%  stress-ng.io-uring.ops
   6069877          +299.9%   24271031 ± 25%  stress-ng.io-uring.ops_per_sec
  63452087          +102.5%  1.285e+08 ± 19%  stress-ng.time.involuntary_context_switches
      5431          +182.5%      15343 ± 20%  stress-ng.time.percent_of_cpu_this_job_got
      3051          +195.8%       9025 ± 21%  stress-ng.time.system_time
 4.461e+08          +289.0%  1.735e+09 ± 25%  stress-ng.time.voluntary_context_switches
     48.09 ±  6%     -34.7       13.42 ± 66%  mpstat.cpu.all.idle%
     19.76 ±  6%     -14.5        5.29 ± 89%  mpstat.cpu.all.iowait%
      4.84 ±  6%      -2.6        2.21 ± 77%  mpstat.cpu.all.irq%
      0.32 ±  6%      -0.3        0.04 ± 75%  mpstat.cpu.all.soft%
     24.66 ±  6%     +52.0       76.61 ± 19%  mpstat.cpu.all.sys%
     17.00           +16.7%      19.83 ± 12%  mpstat.max_utilization.seconds
     57.31           +57.7%      90.36 ± 10%  mpstat.max_utilization_pct
     49.43 ±  6%     -67.3%      16.17 ± 53%  vmstat.cpu.id
     29.04 ±  6%    +162.8%      76.30 ± 17%  vmstat.cpu.sy
     19.17 ±  6%     -73.3%       5.12 ± 89%  vmstat.cpu.wa
     71.25 ±  5%     -72.5%      19.58 ± 90%  vmstat.procs.b
     97.21 ±  7%    +124.6%     218.37 ± 15%  vmstat.procs.r
  12688269 ±  6%    +142.9%   30825156 ± 19%  vmstat.system.cs
   5224657 ±  6%     -62.8%    1943708 ± 46%  vmstat.system.in
    289935 ±  3%     -22.2%     225623 ±  5%  numa-meminfo.node0.SUnreclaim
    386160 ±  6%     -21.4%     303599 ± 12%  numa-meminfo.node0.Slab
  11844753 ±  3%     -36.4%    7538537 ± 31%  numa-meminfo.node1.Active
  11844753 ±  3%     -36.4%    7538537 ± 31%  numa-meminfo.node1.Active(anon)
     58156 ±  5%     -62.4%      21876 ±  6%  numa-meminfo.node1.KernelStack
   1029721 ± 12%     +32.1%    1360593 ± 11%  numa-meminfo.node1.Mapped
    234556 ±  4%     -25.9%     173820 ±  3%  numa-meminfo.node1.SUnreclaim
  10965603 ±  4%     -37.8%    6824977 ± 33%  numa-meminfo.node1.Shmem
    305421 ±  8%     -17.7%     251285 ± 12%  numa-meminfo.node1.Slab
     72401 ±  3%     -22.1%      56378 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
   2963605 ±  3%     -36.4%    1885576 ± 31%  numa-vmstat.node1.nr_active_anon
     58030 ±  5%     -62.4%      21811 ±  6%  numa-vmstat.node1.nr_kernel_stack
    258544 ± 12%     +32.1%     341648 ± 11%  numa-vmstat.node1.nr_mapped
   2743743 ±  4%     -37.8%    1707508 ± 33%  numa-vmstat.node1.nr_shmem
     58559 ±  4%     -25.8%      43437 ±  3%  numa-vmstat.node1.nr_slab_unreclaimable
   2963598 ±  3%     -36.4%    1885576 ± 31%  numa-vmstat.node1.nr_zone_active_anon
  21105653          +304.1%   85285462 ±  2%  numa-vmstat.node1.numa_hit
  20989589          +305.8%   85178020 ±  2%  numa-vmstat.node1.numa_local
  12284550 ±  3%     -33.5%    8175355 ± 28%  meminfo.Active
  12284550 ±  3%     -33.5%    8175355 ± 28%  meminfo.Active(anon)
  14613224 ±  3%     -28.3%   10483768 ± 22%  meminfo.Cached
  15092839 ±  2%     -26.1%   11151503 ± 20%  meminfo.Committed_AS
    118013 ±  4%     -47.1%      62476 ± 29%  meminfo.KernelStack
   1189737 ±  9%     +24.5%    1481177 ± 12%  meminfo.Mapped
  19156418 ±  2%     -23.0%   14742923 ± 15%  meminfo.Memused
    524570           -23.8%     399461 ±  2%  meminfo.SUnreclaim
  11073466 ±  4%     -37.3%    6944224 ± 33%  meminfo.Shmem
    691643           -19.8%     554889        meminfo.Slab
    399938           -13.6%     345539 ±  5%  meminfo.VmallocUsed
  19273868 ±  2%     -23.1%   14829426 ± 15%  meminfo.max_used_kB
   3072505 ±  3%     -33.5%    2044367 ± 28%  proc-vmstat.nr_active_anon
    303038            +1.5%     307548        proc-vmstat.nr_anon_pages
   5974768            +1.8%    6084995        proc-vmstat.nr_dirty_background_threshold
  11964146            +1.8%   12184870        proc-vmstat.nr_dirty_threshold
   3655222 ±  3%     -28.3%    2622497 ± 22%  proc-vmstat.nr_file_pages
  60117910            +1.8%   61221778        proc-vmstat.nr_free_pages
  60050485            +1.8%   61151282        proc-vmstat.nr_free_pages_blocks
    117206 ±  4%     -46.9%      62248 ± 28%  proc-vmstat.nr_kernel_stack
    298065 ±  9%     +24.9%     372258 ± 12%  proc-vmstat.nr_mapped
   2770279 ±  4%     -37.3%    1737611 ± 33%  proc-vmstat.nr_shmem
     41774            -7.0%      38862 ±  3%  proc-vmstat.nr_slab_reclaimable
    130994           -23.8%      99846 ±  2%  proc-vmstat.nr_slab_unreclaimable
   3072505 ±  3%     -33.5%    2044367 ± 28%  proc-vmstat.nr_zone_active_anon
  37968818          +257.4%  1.357e+08 ± 25%  proc-vmstat.numa_hit
    768.00           +22.1%     937.67 ± 11%  proc-vmstat.numa_huge_pte_updates
  37769910          +258.7%  1.355e+08 ± 25%  proc-vmstat.numa_local
    113917 ±  3%     -58.9%      46844 ±  9%  proc-vmstat.numa_pages_migrated
    622038 ±  3%     +16.6%     725068 ±  7%  proc-vmstat.numa_pte_updates
  38252525          +255.2%  1.359e+08 ± 25%  proc-vmstat.pgalloc_normal
  34002082          +291.1%   1.33e+08 ± 25%  proc-vmstat.pgfree
    113917 ±  3%     -58.9%      46844 ±  9%  proc-vmstat.pgmigrate_success
     19955           -43.2%      11333        proc-vmstat.pgreuse
  17603355           -73.2%    4719412 ± 91%  proc-vmstat.unevictable_pgs_culled
      0.31 ± 57%     -71.0%       0.09 ±  6%  perf-stat.i.MPKI
 2.695e+10 ±  6%    +157.7%  6.946e+10 ± 18%  perf-stat.i.branch-instructions
      0.93            -0.5        0.45 ± 12%  perf-stat.i.branch-miss-rate%
 2.182e+08 ±  6%     +24.3%  2.712e+08 ±  7%  perf-stat.i.branch-misses
      3.06 ± 33%      +5.9        8.91 ± 64%  perf-stat.i.cache-miss-rate%
  25459047 ±  6%     -18.4%   20785561 ± 16%  perf-stat.i.cache-misses
 1.322e+09 ±  6%     -69.1%   4.09e+08 ± 64%  perf-stat.i.cache-references
  13341377 ±  6%    +142.6%   32367405 ± 19%  perf-stat.i.context-switches
      3.31 ±  4%     -47.1%       1.75 ± 11%  perf-stat.i.cpi
 3.765e+11 ±  6%     +45.5%  5.479e+11 ±  8%  perf-stat.i.cpu-cycles
   5523943 ±  6%     -75.4%    1360465 ±100%  perf-stat.i.cpu-migrations
     25535 ±  4%     +58.9%      40578 ± 10%  perf-stat.i.cycles-between-cache-misses
 1.337e+11 ±  6%    +156.7%  3.432e+11 ± 19%  perf-stat.i.instructions
      0.35           +76.4%       0.62 ± 10%  perf-stat.i.ipc
     98.25 ±  6%     +78.8%     175.66 ± 14%  perf-stat.i.metric.K/sec
      1.29 ± 70%      +7.8        9.13 ± 71%  perf-stat.overall.cache-miss-rate%
      9811 ± 70%    +173.4%      26822 ± 11%  perf-stat.overall.cycles-between-cache-misses
      0.24 ± 70%    +162.2%       0.62 ± 10%  perf-stat.overall.ipc
 1.729e+10 ± 71%    +295.2%  6.833e+10 ± 18%  perf-stat.ps.branch-instructions
 1.401e+08 ± 71%     +90.5%  2.669e+08 ±  7%  perf-stat.ps.branch-misses
   8559237 ± 71%    +272.1%   31851996 ± 19%  perf-stat.ps.context-switches
 2.415e+11 ± 71%    +123.3%  5.391e+11 ±  8%  perf-stat.ps.cpu-cycles
 8.577e+10 ± 71%    +293.6%  3.376e+11 ± 19%  perf-stat.ps.instructions
 5.678e+12 ± 70%    +267.4%  2.086e+13 ± 19%  perf-stat.total.instructions
   1174613          +256.2%    4183841 ± 28%  sched_debug.cfs_rq:/.avg_vruntime.avg
   3797895 ± 12%     +61.5%    6135427 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.max
    970333          +185.9%    2773983 ± 52%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.31 ±  6%    +108.3%       0.64 ± 14%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.29 ±  6%    +107.6%       0.59 ± 15%  sched_debug.cfs_rq:/.h_nr_runnable.avg
    138886 ± 16%     -69.1%      42880 ±100%  sched_debug.cfs_rq:/.left_deadline.avg
    138860 ± 16%     -69.1%      42873 ±100%  sched_debug.cfs_rq:/.left_vruntime.avg
     39.33 ± 48%     -53.8%      18.15 ± 27%  sched_debug.cfs_rq:/.load_avg.avg
   1174613          +256.2%    4183841 ± 28%  sched_debug.cfs_rq:/.min_vruntime.avg
   3797895 ± 12%     +61.5%    6135427 ± 13%  sched_debug.cfs_rq:/.min_vruntime.max
    970333          +185.9%    2773983 ± 52%  sched_debug.cfs_rq:/.min_vruntime.min
      0.21 ±  7%    +114.0%       0.44 ± 16%  sched_debug.cfs_rq:/.nr_queued.avg
      0.37 ±  4%     -31.8%       0.25 ± 40%  sched_debug.cfs_rq:/.nr_queued.stddev
    138860 ± 16%     -69.1%      42873 ±100%  sched_debug.cfs_rq:/.right_vruntime.avg
    344.03 ±  4%     +88.7%     649.02 ± 16%  sched_debug.cfs_rq:/.runnable_avg.avg
      1119 ± 10%     +34.2%       1501 ±  2%  sched_debug.cfs_rq:/.runnable_avg.max
    297.90 ±  4%     +64.8%     490.81 ± 16%  sched_debug.cfs_rq:/.util_avg.avg
      1064 ±  8%     -10.6%     951.58 ±  3%  sched_debug.cfs_rq:/.util_avg.max
     72.80 ±  7%    +415.2%     375.03 ± 24%  sched_debug.cfs_rq:/.util_est.avg
      1007 ± 12%     +25.3%       1262 ±  7%  sched_debug.cfs_rq:/.util_est.max
    161.26 ±  7%     +55.3%     250.42 ± 24%  sched_debug.cfs_rq:/.util_est.stddev
    585635 ± 13%     +70.8%    1000253 ± 11%  sched_debug.cpu.avg_idle.max
      7853 ±  8%     -59.3%       3197 ±  5%  sched_debug.cpu.avg_idle.min
     94982 ± 10%     +49.7%     142227 ±  6%  sched_debug.cpu.avg_idle.stddev
      4964 ± 11%     -45.9%       2684 ± 17%  sched_debug.cpu.curr->pid.avg
     36043           -65.5%      12443 ± 54%  sched_debug.cpu.curr->pid.max
     11755 ±  4%     -74.0%       3057 ± 74%  sched_debug.cpu.curr->pid.stddev
      0.27 ±  7%    +129.8%       0.61 ± 17%  sched_debug.cpu.nr_running.avg
      2.92 ± 11%     -31.4%       2.00 ± 14%  sched_debug.cpu.nr_running.max
   2181080          +131.7%    5053532 ± 19%  sched_debug.cpu.nr_switches.avg
   2655743          +132.5%    6174297 ±  3%  sched_debug.cpu.nr_switches.max
    590551 ± 17%    +325.9%    2515328 ± 53%  sched_debug.cpu.nr_switches.min


***************************************************************************************************
lkp-gnr-2sp3: 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-gnr-2sp3/nanosleep/stress-ng/60s

commit: 
  v6.15-rc5
  4a9f46a472 ("acpi: convert strncpy into strscpy")

       v6.15-rc5 4a9f46a472591e7ffd0e9c5d8cd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 8.024e+09 ±  3%    -100.0%       0.00        cpuidle..time
  5.73e+08 ± 11%    -100.0%       0.00        cpuidle..usage
   5496607 ±  2%     -10.7%    4906416 ±  2%  numa-numastat.node1.local_node
   5662628 ±  3%     -10.8%    5052140 ±  2%  numa-numastat.node1.numa_hit
    291680 ±  3%     -17.4%     240862 ±  6%  numa-meminfo.node0.SUnreclaim
    255763 ±  4%     -16.0%     214915 ±  6%  numa-meminfo.node1.SUnreclaim
  13778965 ±  2%     -10.7%   12305910 ±  2%  numa-meminfo.node1.Shmem
     36.41 ±  8%     -51.2%      17.78 ±  2%  vmstat.cpu.id
    280.33 ± 11%    +115.8%     604.80        vmstat.procs.r
  12822190 ±  7%     -54.9%    5782167        vmstat.system.in
    370.77 ± 79%    +198.2%       1105 ±  8%  perf-c2c.DRAM.local
      5844 ±  7%     +25.8%       7349 ±  4%  perf-c2c.DRAM.remote
    302352 ±  3%     -24.5%     228196        perf-c2c.HITM.local
    306707 ±  3%     -24.0%     232964        perf-c2c.HITM.total
  15387789 ±  3%      -9.7%   13890052        meminfo.Active
  15387789 ±  3%      -9.7%   13890052        meminfo.Active(anon)
    547403           -16.7%     455722        meminfo.SUnreclaim
  13989353 ±  3%     -10.6%   12513459        meminfo.Shmem
    740264           -13.2%     642211        meminfo.Slab
     34.31 ±  9%     -19.3       15.03 ±  2%  mpstat.cpu.all.idle%
     49.08            +8.1       57.22        mpstat.cpu.all.irq%
      0.15 ± 18%      +0.2        0.37 ±  2%  mpstat.cpu.all.soft%
     10.51 ± 19%      +9.3       19.84        mpstat.cpu.all.sys%
     82.11           +13.6%      93.31        mpstat.max_utilization_pct
     72917 ±  3%     -17.4%      60209 ±  6%  numa-vmstat.node0.nr_slab_unreclaimable
   3448051 ±  2%     -10.8%    3076253 ±  2%  numa-vmstat.node1.nr_shmem
     63938 ±  4%     -16.0%      53717 ±  6%  numa-vmstat.node1.nr_slab_unreclaimable
   5662986 ±  3%     -10.8%    5052416 ±  2%  numa-vmstat.node1.numa_hit
   5496964 ±  2%     -10.7%    4906693 ±  2%  numa-vmstat.node1.numa_local
     63477 ±  6%     +60.5%     101863        stress-ng.nanosleep.nanosec_sleep_overrun
  44977307 ±  3%     +23.8%   55676879        stress-ng.nanosleep.ops
    749576 ±  3%     +23.8%     927912        stress-ng.nanosleep.ops_per_sec
  12275219 ±  9%    +150.4%   30741095        stress-ng.time.involuntary_context_switches
    220678            +1.3%     223451        stress-ng.time.minor_page_faults
      6525            +3.4%       6746        stress-ng.time.percent_of_cpu_this_job_got
      2584 ±  2%     +15.7%       2990        stress-ng.time.system_time
      1359 ±  2%     -19.8%       1089        stress-ng.time.user_time
   3847978 ±  3%      -9.8%    3472571        proc-vmstat.nr_active_anon
    350848            -1.8%     344375        proc-vmstat.nr_anon_pages
   4383290 ±  2%      -8.4%    4014428        proc-vmstat.nr_file_pages
   3498391 ±  3%     -10.5%    3129513        proc-vmstat.nr_shmem
     48220            -3.3%      46626        proc-vmstat.nr_slab_reclaimable
    136860           -16.7%     113939        proc-vmstat.nr_slab_unreclaimable
   3847978 ±  3%      -9.8%    3472571        proc-vmstat.nr_zone_active_anon
   6157573 ±  2%     -10.9%    5484244        proc-vmstat.numa_hit
   5893718 ±  3%     -11.4%    5220452        proc-vmstat.numa_local
   6454012 ±  2%     -10.3%    5788637        proc-vmstat.pgalloc_normal
    946345 ±  5%     -17.0%     785728 ±  5%  proc-vmstat.pgfault
     21653 ±  4%     -40.5%      12881 ±  4%  proc-vmstat.pgreuse
      0.25 ± 11%     +62.5%       0.41 ±  2%  perf-stat.i.MPKI
      1.43 ±  4%      +0.4        1.85        perf-stat.i.branch-miss-rate%
 7.159e+08           +27.3%  9.113e+08        perf-stat.i.branch-misses
  61844201 ±  6%     +54.8%   95712375 ±  2%  perf-stat.i.cache-misses
 5.265e+09 ±  4%     +34.7%  7.091e+09        perf-stat.i.cache-references
      2.84 ±  5%     +25.6%       3.57        perf-stat.i.cpi
 7.337e+11           +21.7%   8.93e+11        perf-stat.i.cpu-cycles
  15128294 ±  4%     -20.6%   12012304        perf-stat.i.cpu-migrations
     14582 ±  7%     -32.3%       9871 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.38 ±  5%     -19.6%       0.31 ±  2%  perf-stat.i.ipc
    166.24 ±  5%     -17.9%     136.55        perf-stat.i.metric.K/sec
     10825 ±  7%     -15.6%       9141 ±  7%  perf-stat.i.minor-faults
     10825 ±  7%     -15.6%       9141 ±  7%  perf-stat.i.page-faults
      0.22 ± 11%     +60.5%       0.35 ±  2%  perf-stat.overall.MPKI
      1.28 ±  4%      +0.4        1.67        perf-stat.overall.branch-miss-rate%
      1.18 ±  2%      +0.2        1.35 ±  2%  perf-stat.overall.cache-miss-rate%
      2.61 ±  6%     +26.5%       3.30        perf-stat.overall.cpi
     11885 ±  4%     -21.5%       9332 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.39 ±  5%     -21.2%       0.30        perf-stat.overall.ipc
 7.042e+08           +27.3%  8.964e+08        perf-stat.ps.branch-misses
  60903975 ±  6%     +54.6%   94180370 ±  2%  perf-stat.ps.cache-misses
 5.179e+09 ±  4%     +34.7%  6.975e+09        perf-stat.ps.cache-references
 7.218e+11           +21.7%  8.785e+11        perf-stat.ps.cpu-cycles
  14879980 ±  4%     -20.6%   11816383        perf-stat.ps.cpu-migrations
     10630 ±  8%     -15.4%       8990 ±  7%  perf-stat.ps.minor-faults
     10630 ±  8%     -15.4%       8990 ±  7%  perf-stat.ps.page-faults
   1361488 ±  5%     +28.1%    1743936        sched_debug.cfs_rq:/.avg_vruntime.avg
   5955807 ± 14%     +26.0%    7503578 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
   1232820 ±  3%     +19.5%    1472806 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.60 ± 10%    +125.6%       1.36 ±  6%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.83 ± 12%     +68.1%       1.40 ±  6%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.53 ± 12%    +146.6%       1.31 ±  6%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.73 ± 13%     +89.2%       1.39 ±  6%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    363369 ±  9%     +31.7%     478423 ±  5%  sched_debug.cfs_rq:/.left_deadline.avg
    363289 ±  9%     +31.7%     478341 ±  5%  sched_debug.cfs_rq:/.left_vruntime.avg
     13.19 ± 26%     -52.6%       6.25 ±  8%  sched_debug.cfs_rq:/.load_avg.avg
    525.38           -65.1%     183.50 ± 62%  sched_debug.cfs_rq:/.load_avg.max
     60.90 ± 25%     -75.2%      15.10 ± 41%  sched_debug.cfs_rq:/.load_avg.stddev
   1361488 ±  5%     +28.1%    1743936        sched_debug.cfs_rq:/.min_vruntime.avg
   5955807 ± 14%     +26.0%    7503578 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
   1232820 ±  3%     +19.5%    1472806 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
      0.31 ±  3%     +33.2%       0.41 ±  3%  sched_debug.cfs_rq:/.nr_queued.avg
      0.33 ±  4%     -18.4%       0.27 ±  5%  sched_debug.cfs_rq:/.nr_queued.stddev
      7.35 ± 50%     -98.0%       0.15 ±346%  sched_debug.cfs_rq:/.removed.load_avg.avg
    511.38           -92.6%      37.88 ±346%  sched_debug.cfs_rq:/.removed.load_avg.max
     58.58 ± 26%     -96.0%       2.36 ±346%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      3.56 ± 53%     -96.6%       0.12 ±346%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     28.44 ± 29%     -93.1%       1.96 ±346%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      3.56 ± 53%     -96.6%       0.12 ±346%  sched_debug.cfs_rq:/.removed.util_avg.avg
     28.44 ± 29%     -93.2%       1.95 ±346%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    363289 ±  9%     +31.7%     478341 ±  5%  sched_debug.cfs_rq:/.right_vruntime.avg
    257.62 ± 14%    +322.5%       1088 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
    946.38 ±  2%    +160.5%       2465 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
    173.27 ± 10%    +196.4%     513.58        sched_debug.cfs_rq:/.runnable_avg.min
    114.87 ± 23%    +137.8%     273.14 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    235.05 ±  4%     +22.8%     288.57        sched_debug.cfs_rq:/.util_avg.avg
    104.92 ±  7%     -12.0%      92.36 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
      8.93 ± 19%   +1910.0%     179.43 ±  9%  sched_debug.cfs_rq:/.util_est.avg
    802.77 ± 13%    +103.2%       1631 ± 20%  sched_debug.cfs_rq:/.util_est.max
     56.48 ± 19%    +293.2%     222.08 ±  6%  sched_debug.cfs_rq:/.util_est.stddev
     22.54 ±  3%     +26.3%      28.46 ±  3%  sched_debug.cpu.clock.stddev
      7188           -12.0%       6328 ±  3%  sched_debug.cpu.curr->pid.max
      2102 ±  3%     -18.0%       1724        sched_debug.cpu.curr->pid.stddev
      0.00 ±  3%     +32.4%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
      0.56 ± 13%    +131.1%       1.29 ±  6%  sched_debug.cpu.nr_running.avg
      0.82 ± 14%     +62.1%       1.33 ±  7%  sched_debug.cpu.nr_running.stddev
   3679769 ±  2%     -18.2%    3011353        sched_debug.cpu.nr_switches.max



***************************************************************************************************
lkp-srf-2sp3: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp3/nanosleep/stress-ng/60s

commit: 
  v6.15-rc5
  4a9f46a472 ("acpi: convert strncpy into strscpy")

       v6.15-rc5 4a9f46a472591e7ffd0e9c5d8cd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     20.29            -5.2%      19.23        boot-time.dhcp
 7.335e+09          -100.0%       0.00        cpuidle..time
 3.421e+08          -100.0%       0.00        cpuidle..usage
   1262963           -10.1%    1135588        meminfo.Mapped
    475531           -20.4%     378366        meminfo.SUnreclaim
    643055           -15.8%     541287        meminfo.Slab
     24796          +318.7%     103826 ± 42%  numa-numastat.node0.other_node
   4890571           -12.8%    4263195 ±  8%  numa-numastat.node1.numa_hit
    173010           -45.7%      94003 ± 46%  numa-numastat.node1.other_node
     45.67           -42.2%      26.41 ±  4%  vmstat.cpu.id
    201.24           +69.8%     341.72 ±  2%  vmstat.procs.r
  17944140           +75.1%   31420986 ±  7%  vmstat.system.cs
   7977950           +20.0%    9571654 ±  8%  vmstat.system.in
     44.78           -19.8       24.95 ±  6%  mpstat.cpu.all.idle%
     34.90            +9.1       43.96 ±  2%  mpstat.cpu.all.irq%
      0.11            +0.0        0.15 ±  8%  mpstat.cpu.all.soft%
     12.22            +7.3       19.50 ±  2%  mpstat.cpu.all.sys%
      8.00            +3.5       11.46 ±  3%  mpstat.cpu.all.usr%
     66.86           +34.9%      90.21 ±  2%  mpstat.max_utilization_pct
     28236           +12.1%      31643 ±  6%  numa-meminfo.node0.KernelStack
     78589          +120.3%     173093 ± 44%  numa-meminfo.node0.Mapped
    252579           -16.0%     212085 ±  2%  numa-meminfo.node0.SUnreclaim
      5630         +2952.3%     171845 ± 63%  numa-meminfo.node0.Shmem
    340274           -15.3%     288246 ± 12%  numa-meminfo.node0.Slab
     30790           -10.2%      27655 ±  7%  numa-meminfo.node1.KernelStack
   1187307           -18.8%     964213 ±  6%  numa-meminfo.node1.Mapped
    222896           -25.4%     166281 ±  3%  numa-meminfo.node1.SUnreclaim
     15.55        +9.1e+06%    1415677 ±116%  numa-meminfo.node1.Unevictable
    317041           -10.2%     284725        proc-vmstat.nr_mapped
      8595            +3.3%       8882        proc-vmstat.nr_page_table_pages
     41884            -2.7%      40737        proc-vmstat.nr_slab_reclaimable
    118869           -20.4%      94588        proc-vmstat.nr_slab_unreclaimable
    216343           -22.6%     167393 ± 21%  proc-vmstat.numa_hint_faults
    212807           -22.9%     164083 ± 22%  proc-vmstat.numa_hint_faults_local
    747646           -23.0%     575328 ±  6%  proc-vmstat.pgfault
    690042           -17.9%     566229 ±  6%  proc-vmstat.pgfree
     18242           -41.5%      10679        proc-vmstat.pgreuse
     66136           -17.8%      54373 ±  6%  stress-ng.nanosleep.nanosec_sleep_overrun
  32942741          +115.3%   70918788 ±  4%  stress-ng.nanosleep.ops
    549017          +115.3%    1181944 ±  4%  stress-ng.nanosleep.ops_per_sec
   7441350          +210.9%   23136625 ± 12%  stress-ng.time.involuntary_context_switches
     87380            +1.3%      88520        stress-ng.time.minor_page_faults
      3996           +85.1%       7396 ±  7%  stress-ng.time.percent_of_cpu_this_job_got
      1488           +93.1%       2875 ±  6%  stress-ng.time.system_time
    917.88           +72.3%       1581 ±  7%  stress-ng.time.user_time
 7.582e+08           +77.7%  1.347e+09 ±  4%  stress-ng.time.voluntary_context_switches
     28240           +11.7%      31548 ±  6%  numa-vmstat.node0.nr_kernel_stack
     19908          +116.2%      43037 ± 43%  numa-vmstat.node0.nr_mapped
      1409         +2921.1%      42588 ± 63%  numa-vmstat.node0.nr_shmem
     63145           -16.0%      53015 ±  2%  numa-vmstat.node0.nr_slab_unreclaimable
     24796          +318.7%     103826 ± 42%  numa-vmstat.node0.numa_other
     30790           -10.4%      27580 ±  7%  numa-vmstat.node1.nr_kernel_stack
    298168           -18.8%     242086 ±  6%  numa-vmstat.node1.nr_mapped
     55724           -25.4%      41568 ±  3%  numa-vmstat.node1.nr_slab_unreclaimable
      3.89        +9.1e+06%     353919 ±116%  numa-vmstat.node1.nr_unevictable
      3.89        +9.1e+06%     353919 ±116%  numa-vmstat.node1.nr_zone_unevictable
   4890208           -12.8%    4262653 ±  8%  numa-vmstat.node1.numa_hit
    173010           -45.7%      94003 ± 46%  numa-vmstat.node1.numa_other
      0.29            -2.9%       0.29        perf-stat.i.MPKI
  3.94e+10           +54.8%  6.101e+10 ±  4%  perf-stat.i.branch-instructions
      1.47            -0.1        1.36 ±  4%  perf-stat.i.branch-miss-rate%
 4.897e+08           +50.5%  7.371e+08        perf-stat.i.branch-misses
      2.66            +0.2        2.85 ±  2%  perf-stat.i.cache-miss-rate%
  54650523           +44.1%   78748562 ±  6%  perf-stat.i.cache-misses
 2.506e+09           +32.6%  3.323e+09        perf-stat.i.cache-references
  18553998           +75.0%   32467273 ±  7%  perf-stat.i.context-switches
      2.42           -17.7%       1.99 ±  2%  perf-stat.i.cpi
 4.091e+11           +34.7%  5.511e+11 ±  2%  perf-stat.i.cpu-cycles
  10138720           +79.7%   18216803 ±  9%  perf-stat.i.cpu-migrations
      9070           -16.0%       7620 ±  5%  perf-stat.i.cycles-between-cache-misses
 1.948e+11           +55.3%  3.025e+11 ±  4%  perf-stat.i.instructions
      0.47           +17.2%       0.55        perf-stat.i.ipc
    149.44           +76.7%     264.00 ±  8%  perf-stat.i.metric.K/sec
      9609           -18.9%       7792 ±  7%  perf-stat.i.minor-faults
      9609           -18.9%       7792 ±  7%  perf-stat.i.page-faults
      0.28            -7.3%       0.26 ±  2%  perf-stat.overall.MPKI
      2.18            +0.2        2.37 ±  6%  perf-stat.overall.cache-miss-rate%
      2.10           -13.2%       1.82 ±  2%  perf-stat.overall.cpi
      7483            -6.3%       7014 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.48           +15.3%       0.55 ±  2%  perf-stat.overall.ipc
 3.878e+10           +54.9%  6.007e+10 ±  4%  perf-stat.ps.branch-instructions
 4.817e+08           +50.5%   7.25e+08        perf-stat.ps.branch-misses
  53781450           +44.1%   77524937 ±  6%  perf-stat.ps.cache-misses
 2.466e+09           +32.6%  3.269e+09        perf-stat.ps.cache-references
  18252323           +75.0%   31933413 ±  7%  perf-stat.ps.context-switches
 4.025e+11           +34.7%  5.422e+11 ±  2%  perf-stat.ps.cpu-cycles
   9974053           +79.6%   17916841 ±  9%  perf-stat.ps.cpu-migrations
 1.917e+11           +55.4%  2.978e+11 ±  4%  perf-stat.ps.instructions
      9443           -18.8%       7663 ±  7%  perf-stat.ps.minor-faults
      9443           -18.8%       7663 ±  7%  perf-stat.ps.page-faults
  1.18e+13           +55.3%  1.833e+13 ±  4%  perf-stat.total.instructions
    662859          +178.2%    1844033 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
   3155866           +94.4%    6133730 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
    509569          +218.9%    1624879 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.min
    219206           +76.6%     387056 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.64           +59.8%       1.02 ± 13%  sched_debug.cfs_rq:/.h_nr_queued.avg
      8.00           -40.0%       4.80 ± 14%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.57           +50.0%       0.86 ± 16%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      8.00           -41.2%       4.70 ± 10%  sched_debug.cfs_rq:/.h_nr_runnable.max
    119579          +285.9%     461420 ±  6%  sched_debug.cfs_rq:/.left_deadline.avg
    701402          +556.6%    4605499 ± 42%  sched_debug.cfs_rq:/.left_deadline.max
    245694          +241.9%     839983 ±  7%  sched_debug.cfs_rq:/.left_deadline.stddev
    119546          +285.9%     461364 ±  6%  sched_debug.cfs_rq:/.left_vruntime.avg
    701163          +556.8%    4605228 ± 42%  sched_debug.cfs_rq:/.left_vruntime.max
    245628          +241.9%     839885 ±  7%  sched_debug.cfs_rq:/.left_vruntime.stddev
     57782           -46.4%      30982 ± 12%  sched_debug.cfs_rq:/.load.max
      7422           -32.2%       5029 ± 10%  sched_debug.cfs_rq:/.load.stddev
     43.69           -59.6%      17.67 ± 20%  sched_debug.cfs_rq:/.load_avg.avg
      2.00           -25.0%       1.50        sched_debug.cfs_rq:/.load_avg.min
    131.02           -51.1%      64.07 ± 26%  sched_debug.cfs_rq:/.load_avg.stddev
    662859          +178.2%    1844033 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
   3155866           +94.4%    6133730 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
    509569          +218.9%    1624879 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
    219206           +76.6%     387056 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.28           +41.3%       0.39 ±  3%  sched_debug.cfs_rq:/.nr_queued.avg
     34.26           -79.9%       6.90 ± 53%  sched_debug.cfs_rq:/.removed.load_avg.avg
    127.21           -60.3%      50.55 ± 51%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     14.75           -79.8%       2.98 ± 53%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     56.08           -59.9%      22.49 ± 51%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     14.75           -79.8%       2.98 ± 53%  sched_debug.cfs_rq:/.removed.util_avg.avg
     56.08           -59.9%      22.49 ± 51%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    119546          +285.9%     461364 ±  6%  sched_debug.cfs_rq:/.right_vruntime.avg
    701163          +556.8%    4605228 ± 42%  sched_debug.cfs_rq:/.right_vruntime.max
    245628          +241.9%     839885 ±  7%  sched_debug.cfs_rq:/.right_vruntime.stddev
    255.64           +76.6%     451.41 ± 12%  sched_debug.cfs_rq:/.runnable_avg.avg
    127.50           +98.1%     252.60 ± 16%  sched_debug.cfs_rq:/.runnable_avg.min
    228.34           +54.8%     353.49 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    117.50          +104.7%     240.50 ± 17%  sched_debug.cfs_rq:/.util_avg.min
     11.37           +29.9%      14.77 ± 15%  sched_debug.cfs_rq:/.util_est.avg
      6599           -51.0%       3236 ±  6%  sched_debug.cpu.avg_idle.min
      1003           +34.0%       1344 ±  6%  sched_debug.cpu.curr->pid.avg
      5836            -9.8%       5267        sched_debug.cpu.curr->pid.max
      1661           -10.8%       1482 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.00           +14.5%       0.00 ±  5%  sched_debug.cpu.next_balance.stddev
      0.54           +71.4%       0.93 ± 11%  sched_debug.cpu.nr_running.avg
      8.50           -44.7%       4.70 ± 15%  sched_debug.cpu.nr_running.max
   2891369           +74.8%    5054237 ±  7%  sched_debug.cpu.nr_switches.avg
   3315998           +69.9%    5635000        sched_debug.cpu.nr_switches.max
   1451647           +82.7%    2651528 ±  5%  sched_debug.cpu.nr_switches.min
      0.01           -53.3%       0.00 ± 57%  sched_debug.cpu.nr_uninterruptible.avg
    206.00           -43.6%     116.20 ± 45%  sched_debug.cpu.nr_uninterruptible.max
     24.50           -36.5%      15.54 ± 35%  sched_debug.cpu.nr_uninterruptible.stddev





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


