Return-Path: <linux-acpi+bounces-12709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B89A7B0AC
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD648880D52
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 21:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D7206F31;
	Thu,  3 Apr 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuAWdIsf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485EA1EE7D5;
	Thu,  3 Apr 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714112; cv=fail; b=flhic05ADE9ETPmcrif73T1/7TS8XfwD7XGRi6bVuC2A5oJ9RNp+oXVomjsmnCIH3iJQ8LtEoNLCHHbUKIiI4i3HShqDArvxj1rCpCPRELAajVg+a/PVrPLfbqudsaG7C6DQZ2UWGlOqNnC3o/mRuq0s4tNdPD23hlcCqnvolrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714112; c=relaxed/simple;
	bh=KUodNTW1X1mNht48GXRCp6GGy1L9c8oI58TZTNqet2M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qak0ym/dB0Bo3La19EQvPir/2CGpJQhvn5b1yPNeZ6Gl8RRkyFb+fT2Lnsv06fLc1mTdNfbcYuk2mehDX9GMqQeqUcEsG8Pk+TAcRnheLok8hkx4Z/n8kJ3DVw4M2RQ+3dCtZqa0lNiDE+Nj+56d0xQOIv1Jx1gVA+KvD7DST7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuAWdIsf; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743714111; x=1775250111;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KUodNTW1X1mNht48GXRCp6GGy1L9c8oI58TZTNqet2M=;
  b=QuAWdIsfVjrrfwKw12TVQAtQvPno5i4MX3RP7FdmHem7up24ylLHt4v2
   3/jKYD/72Q6sruZ5qaHRCkPT5aW0ZYsBjalVfVNxueKeL1S+Zrwx/+wJi
   hNX+9THxn7ru9TLV+NQZnTuunGBW3Q3hdev1Z+2Vq9CN3XuYJppHXyxmx
   BkfR5rLT0CqA76pQz4qeMsvn/pV9aJXkZRLVSwYBr36wqPodeVPYzq8oV
   mWCG53iZ1BMVeDDHpRL2V1CnboCTVT/6xh9cs7iO9kuYFkM65sDMNodjT
   PeFFPBxCM4wq1F462SlbGoxSWGPFigCVSniLKStOY+eiSS3lY11ywqN0X
   A==;
X-CSE-ConnectionGUID: oIYosgbWRwG37XeY2Yoemg==
X-CSE-MsgGUID: rOlwnlUNTqOsiffErpZsXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="56132702"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="56132702"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 14:01:50 -0700
X-CSE-ConnectionGUID: n+0ef/BjS0GtEHzZiCVP0g==
X-CSE-MsgGUID: UNFvUSUxS1O5RF27s3ZpYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="158112591"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 14:01:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Apr 2025 14:01:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 3 Apr 2025 14:01:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 3 Apr 2025 14:01:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvFbhP0IE7lQmMpt2yZXtIp0clnIfPSAlajN+/XEl2BLYYbl5CfEscsuQRYsmfstTuaikZq31MBQ3v9tSwOZma32KUGI8SgFOJzDepOpsAPIUcRrfsVYdc99l6Glc60Oih086pSGrENduBuyIdj8uADDaKJaas0SIrspdLC2Na4Jza0cTstepW6LqdETGe/1byrTWQUTze6KXn3zt5xRNAoq3ivTxNwfRxwyuaDo3fYxxr4WF+co5T/hVhDZE3GgAjD//nlqUUmVjTj/Q5059zK90ETTxHNEPZTSEp3kM9sUjTgU5mTkPS05KjxtCB9pOvlt0OdFPoFFN0s8xDxwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIeW1Ux1GJ8FuGZdyMwpQoZHQERuQrn5ILkOOZL0pcw=;
 b=aPPVAV1Q+hb9ZRpCY3+o0NH3gKUxnNDFuvEtLIz8v1HeDGeylUTWWRNLPs8XQGGupyuynoJDa0nCVhg2iD6Xa0X/Jc0ByqRs/qwub9oQBUNvN29gtB5pEXj0spXIMZyFmr4b44QTPtHSvV7Ap1cpyiy297zkP1/C92c3wIuS9hKvxsfvGrcTwYbjcWoMpNVoP2FJnynv6pe+0N9/4xAcBKJ+0s2TN/8jD8jkyp51XS9z6Ax35ISPCzo6gWqsdSnhvPosjw3DssLJKXTSM9rfVsSijmkj1U2HOgNC5Nm1r85MGoq5l27qup/tr6B+5auPi0FoUnCGSpxiHRMw11oX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 21:01:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 21:01:28 +0000
Date: Thu, 3 Apr 2025 14:01:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: kernel test robot <lkp@intel.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <rppt@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <akpm@linux-foundation.org>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <bfaccini@nvidia.com>, <haibo1.xu@intel.com>,
	<david@redhat.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<chenbaozi@phytium.com.cn>, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <67eef72411bec_464ec29434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
 <202503282026.QNaOAK79-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202503282026.QNaOAK79-lkp@intel.com>
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: e78213a1-492b-4d88-d5d3-08dd72f2b3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?higcMwvAiNU1lisWu2dyidp5BNXYavcLXB8pjZyWSiSJk19wJvzBSEyqbze+?=
 =?us-ascii?Q?cSAX0vSLFQSRLDPj1heQOMsP1sxgOFXWiREu7YmFXNw8UDwyjVRgRIOVSpI8?=
 =?us-ascii?Q?gPfBvdxJQvc7eqGksVuWRe/qFOrYb40+Kulhvrv4mL+wn31xzktJqtG0M9IB?=
 =?us-ascii?Q?dZr8e6JXS/6tSZwchKZNofO6DRutIkMjVhOsQ0Jb1RtrzrPBZIwL2Ttn2AON?=
 =?us-ascii?Q?AZEqCBu2prnWRIUKr3D+aXBqbJ8L61MFm8IreJi6rcRCvQ2VQe1dzSwGjVty?=
 =?us-ascii?Q?YuHWU7GdJhkLRGNWT+c9JGe/MwlZno8IB15Z8A95DoUKL5tfZ+n1MTYjjUu8?=
 =?us-ascii?Q?d8GS8k3hp08ci1Dw8/eHDPcvXF8CyDJheAnsU/BVt1OWtVrvTbM8Lp9Fktrm?=
 =?us-ascii?Q?sLnLSBavacqOoF9/MgXrDsqMUHcJDBjAgTnz5SyCLTyTh4WJD/Zh8ItJsp5L?=
 =?us-ascii?Q?Hdb1hplJuWyovuMmzFTh7/Ee6QPoiA+gr9Q6rPrIvHl/ikdxT1HEMqtxUpUr?=
 =?us-ascii?Q?+LO5iZkHaYClklU6WVturpyqUlbmMX3Owl1sexJ9dcPHTzFhnuyiwVaAoq2P?=
 =?us-ascii?Q?Rxu8rk2pO6nb8+v/OUVnl73NPyPxyLepNwFvubeOEk4ShFTqjZrST5ybORS5?=
 =?us-ascii?Q?Ey0IwTTu6nomvFQNO3WEoVlE3L24wjNBzpG2af27iovlRQ7BYjQNCLN6S74/?=
 =?us-ascii?Q?M7EG+C6UWzayairUYthaYeSjW6H/FoKybewah8CLBLAw7OKW45OaAbFsc+os?=
 =?us-ascii?Q?KxYV+6zpZr2F5lgXihM85Unw4RuP9jdnlEqswW1KkA9ZGY9K9J/MVbvd7d7f?=
 =?us-ascii?Q?T7160CsYpK5UDQIcYkjj5S5zRcyvc+ELcfVjo2+xeq/xTIyOxapJpmlJ/15C?=
 =?us-ascii?Q?eK/BtbELwKNOS/Icib8aBbdxvD4EwmR1g5zJyzHm8m4FvyjVjMLVVcRI/FTn?=
 =?us-ascii?Q?Fsm1KQHTpovnZ17pUv4g273j6LOiUdiAw7PbRiZ7AhlRyXP+UizhPKicZ1fD?=
 =?us-ascii?Q?Onoqj9mwkwXY0C3U/Fxj40jZiRGfvazlueHFZ2CUZLr3xKLgzp64jn4X5UE1?=
 =?us-ascii?Q?dCuhvbLmW1icobTXS0JQ3V5wXH2lC/KBFp7HmJ8/+H2dk2AujNjSeiHr6lfa?=
 =?us-ascii?Q?PCP6/W4LNWkNX00X949zIfdIIn5hXOOpku2dGQMVKe4+1zLp9Lxh6qyA7Jw7?=
 =?us-ascii?Q?AluTcvBB9YdeaHiY2mGo+Hb9rpBPaH2mgUiisxRXnaupYEL2z/Puz5FBBsq5?=
 =?us-ascii?Q?aT+sx2hVZZrEhzW7u4eGmuk5q/FGOW6Ifrga2B3DSMQoEFceO2BouJZ5ymDn?=
 =?us-ascii?Q?Vxupv8yXshUOBaOkTTLW8nl7jaUWa2C0uBzsAJIRxHUt8Pw2TYZI4rcKErrh?=
 =?us-ascii?Q?wUc2De1yd4VhA3HXEV1lAqClfygM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X06mOzojTO3JOYOsltUcxoge3BNNdZJ5I1up5LeEChUiRc03FnZwkdWFBKsI?=
 =?us-ascii?Q?uV3WUY/sOCdUfanIFF26C4k9AaQWif5ovJKQwNhLKdbC4Agoy7AG/m1eGL1T?=
 =?us-ascii?Q?Ryk1Bnra5fhGUWLair5joXQKn+RudWkNXwEbZ0YSqgS63xhJi83s2Hubwmt6?=
 =?us-ascii?Q?QZuUxbg6Ru0J31y7hko2OLlXi6IxTHgf3oA10lCG9EHErcnwHNjk+/xup+Dt?=
 =?us-ascii?Q?sU7psE765iBpJfgZkE3W0hnbDs6ssMx+NWh07QL/lFYfUwVnL1NK1BAFzO0P?=
 =?us-ascii?Q?TemUV+KeuEhWMNi818trvwnYFJ6iRXqjb3Rc5/v5jwXAu0tRS2YN15gYOKJu?=
 =?us-ascii?Q?VA3CRGD3ht/wnfOx73MvNFIhEv4WeB/HlZbxgxp8IhZM2VjNfoBaMqF0FLnp?=
 =?us-ascii?Q?faxoSEefxjROFkEQnpXvUx6hRH3YfcOANGYPGa5AbMCFkQezMRnnZ1QDerMq?=
 =?us-ascii?Q?LH08v4xy7JSvTs+u7noZAycd77y2cl1cUfCYzFxZYFtAAdrUScmPG/lkPHpP?=
 =?us-ascii?Q?tJs5immdbYrfUB6kKi2Aj+5vS5ut6KeJX4PHyjHLoMVKUXPjCWTC7URY59HF?=
 =?us-ascii?Q?x+RAdRsodp4T92fyH9hI+M7zZYNS6JZjA5MOiLh75qfk/4rzyZp53p7WfutL?=
 =?us-ascii?Q?bRlKL0T56XYgsnwHpn0iU+Wk4+HE8lSMhP4e6UaLE83zlXeysyuCWVTmhUaJ?=
 =?us-ascii?Q?dxHoFgXiDFK4E9r/40mSGTvspLK+LeAuTAHFU7L/gMew3T7XTpwEFJWm6Olu?=
 =?us-ascii?Q?CpRjPzVYyklIju0HUA/DCFipO1K4jp9RNCniGfWo2iZB/jQhFPgSUZTMju6t?=
 =?us-ascii?Q?tfu0pMDMq+zeHzap12//WJy2856StcnojXH+fs+fxZPhKmu2SHjEz0kUnijo?=
 =?us-ascii?Q?dvJGkrKhDfJfYvNmCwXUIdiIvreFhiq7xgXGMk/xGBGnjX9Bs/7wTSG0A4Qe?=
 =?us-ascii?Q?LZISSKH/dwWgB/deOf3xwdeEf00m9N4/izh68mZjVIDt+LVmeDXIaKJHjlY0?=
 =?us-ascii?Q?G44xhG9t/OtLjTm/4hdk0onkY4UykJ1dKej0Mk+rBf5vErns+A3YaZ/HKsdf?=
 =?us-ascii?Q?y2/uX+5xpv+8/cW1ysl6/704u6kVam+ItBjRKL6Dsy26VPUPsFv0EBEocQ1C?=
 =?us-ascii?Q?NuZzsa6CgABalQern9ojR9rSxXJxkvu4x/9LGLtHuOHexWZBYClvMs0fq38V?=
 =?us-ascii?Q?k6M7UeMsHTFUSI0XvjQEscFAsKL8kKhtLZYPIoDnKBLw9pWmCyLWmpqjTEBs?=
 =?us-ascii?Q?qYlgAzQlzdA67n46/a6t3tyGopcl0nYGcOmbu1LbUbADQkt9K3Ti6DPfKait?=
 =?us-ascii?Q?IiGIVAhbKVTgAep63H6R6y8ZvDVTFPSkyfvKYZGnyx1D3yqmjgNnJlByAkl3?=
 =?us-ascii?Q?N6gwG6+mUr9CfAAYqCFtOHNz1OxhEI4rr4yOCl3SIY4ogix1ODCEaYVfAn/c?=
 =?us-ascii?Q?lB2IA1snmPAerjcJ4g7w1Lnlxz/UcicnwrF4vZXBxDlp+dwn0MyzkOdspZA8?=
 =?us-ascii?Q?UlYaR/dwDumBRnuSJbuD3KHUJDuikZwXHL2TISnLt6yF1OoRGdGJE5hmR/Ol?=
 =?us-ascii?Q?trHFhKcAm9nvVopu9lpvvhUDb9pWom3M59OX+xEEUd3PzVrRNVwALJbY/Kkd?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e78213a1-492b-4d88-d5d3-08dd72f2b3f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 21:01:28.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Qq7o97kvbyQaG6dkFMYtYVNQ3jMFiTtmDiz6EDv/Ro46Ba26wRMQQ4ZunEytg8SrXrX/Q+7o4cDzu2G+WDhJhKULuXratGsY+ccXRLsOZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
X-OriginatorOrg: intel.com

[add loongarch folks, cc linux-cxl ]

kernel test robot wrote:
> Hi Yuquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yuquan-Wang/mm-numa_memblks-introduce-numa_add_reserved_memblk/20250328-172428
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20250328092132.2695299-1-wangyuquan1236%40phytium.com.cn
> patch subject: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
> config: loongarch-randconfig-002-20250328 (https://download.01.org/0day-ci/archive/20250328/202503282026.QNaOAK79-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250328/202503282026.QNaOAK79-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503282026.QNaOAK79-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/build_bug.h:5,
>                     from include/linux/container_of.h:5,
>                     from include/linux/list.h:5,
>                     from include/linux/module.h:12,
>                     from drivers/acpi/numa/srat.c:10:
>    drivers/acpi/numa/srat.c: In function 'acpi_parse_cfmws':
> >> drivers/acpi/numa/srat.c:461:13: error: implicit declaration of function 'numa_add_reserved_memblk' [-Wimplicit-function-declaration]
>      461 |         if (numa_add_reserved_memblk(node, start, end) < 0) {
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~

So it looks like loongarch was left out of the numa_memblks conversion:
87482708210f ("mm: introduce numa_memblks")

I think the update needed is something like this (untested):

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2b8bd27a852f..cac16c827159 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -183,6 +183,7 @@ config LOONGARCH
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select NUMA_MEMBLKS
 	select OF
 	select OF_EARLY_FLATTREE
 	select PCI
diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
index b5f9de9f102e..bbf9f70bd25f 100644
--- a/arch/loongarch/include/asm/numa.h
+++ b/arch/loongarch/include/asm/numa.h
@@ -22,20 +22,6 @@ extern int numa_off;
 extern s16 __cpuid_to_node[CONFIG_NR_CPUS];
 extern nodemask_t numa_nodes_parsed __initdata;
 
-struct numa_memblk {
-	u64			start;
-	u64			end;
-	int			nid;
-};
-
-#define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
-struct numa_meminfo {
-	int			nr_blks;
-	struct numa_memblk	blk[NR_NODE_MEMBLKS];
-};
-
-extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
-
 extern void __init early_numa_add_cpu(int cpuid, s16 node);
 extern void numa_add_cpu(unsigned int cpu);
 extern void numa_remove_cpu(unsigned int cpu);
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 84fe7f854820..57b21082e893 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -18,6 +18,7 @@
 #include <linux/efi.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/numa_memblks.h>
 #include <asm/bootinfo.h>
 #include <asm/loongson.h>
 #include <asm/numa.h>

Could someone from the loongarch side propose the fixups needed here so
Yuquan can land this patch?

