Return-Path: <linux-acpi+bounces-12880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31FA81BD0
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364ED422386
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 04:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1CF15CD74;
	Wed,  9 Apr 2025 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGFLf92T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66B15689A;
	Wed,  9 Apr 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744172100; cv=fail; b=kpnQKZk7ZpiJnVafzm5rUV1fgIJqgZNP5F5Og/8VBxxZPUI6ZDS7kI7DhqPupPxt7Q4IKU2PuZQBbCQYIJ0YAciP0H3PSiIunkUy+gNB6Tlb+Zxww0h65dDVlVp6ShkZklsMxFVvrJPxubUUMSJgmDYLbtFh4thvzn96kwhjn+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744172100; c=relaxed/simple;
	bh=dMdlZW5KX3NKlQgt0chZn1RAygT0fyuXXNLZ/w1meEs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BtfM4r+6WYsM2a9cHhvr8kbtBVOP9ASJkrxI9P6WvNugpfJs3o8kjzuHYrUywq1nlfJWCWlK/siG2TNH5+gzhjFmv5l8ADrqWxKlCB787LnOsgCSdmeDI1sJDIMzMwhyXPp3A+V3GcyShr59FnJG7b1REDUi89vs/IHpxT1VUXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGFLf92T; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744172098; x=1775708098;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dMdlZW5KX3NKlQgt0chZn1RAygT0fyuXXNLZ/w1meEs=;
  b=NGFLf92T9+HzdMVuFRJlt1/LlvwoehNHKJykF66f11VYI3bgE9lSR1xx
   /dSrIRDjfMN8cplViG4dYhC7/zXK7Aj63YfYAz6L1PEgAUDwYBUXDQZQa
   fPM02A00R3M2no4t3/AKqvPDRmsaVgEfcCIfCoqbryEYs0jVRWk9gUeHK
   jnbPaie7JmZnQF0YhuxmcfzDbNv6PnPhMfI1rO8Icwk03U2mvzHLscVSL
   yfaNRn1LBkK8a3IG+VgzyHxafQn6D5lkGGeCizl/4H5258mCqkRvveIGq
   7duJ9hoDMIKoyVHQpEWYs8ho0GBYry4Cuaag3UT4QmekIWO4tnlW4nuq6
   Q==;
X-CSE-ConnectionGUID: ubmItvkdSA2f+ooAIQDvwg==
X-CSE-MsgGUID: 9wBUtEzLR5qULsToXXaBtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45642021"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45642021"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:14:58 -0700
X-CSE-ConnectionGUID: TyLjtG0iQVyeTGHzuj8Lvw==
X-CSE-MsgGUID: Z1kv8NI4S6KI+kIvR9TJXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133447344"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 21:14:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 21:14:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:14:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbGD70ylndfPO6XzEvprFDViY2zbgQlfa8YKiBCmLmQ4HakNMfuqgFYC6I9yG1mTh0IdMIKSZ6K/TFTjhMcma++UqtxGEzNE63GlD+YlYpgmC5dd5uZG5OgTWjp6U+fw6eNfzr+CB+GZuAp+Onf61vURTgah2G3vU9g3dZ22+k9Hr62fC/PW+wVjhS3Geb1tE6OPlnSOBtBpAbFMtEQgQC45Pj+KUhOkVwKleTlEnvMK4UvblXSCj8zoSo11nBemv/3h2f0U8m2Sk7u1CB7qZgaWoG0R+3RuZUiPL5ThmoizLBN2+xOFaqLMi4srrhWKEypeKUzOijNScD08p78GWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYeu/AwWRcGVf/NGKdbyUPen0BVx6IU2yJlZbaJK2Ic=;
 b=xRNnsntRlW1joFscmUfpcxW7U7AkDw6HmqYFu+wT0e3oJ2xa6ZKZ48XDvfrE68d0pIaRBbNfzLkTRtt9aOcCX0jGBkebjz87ZrTJMP9q+XBwqONM3zg/SFe+VBcAtuvD/tWdG2uuDEdcBVbYkvD1b+/zZDZ0Ont/lA0U31zictsfUAzBrfwBmMMHdWwZxrJdkxFnXpwyElKdWU8UNKfXzrcH/ztLqFtnRKhtNKYWc1yb1aYbFKiN+InOORkaiIw9uZfU4REgw1rTtepNVGY5b7kXQcD54wTlV/FVBwrcUKYsxpt2Pj4PnUt94LfIDxNhJJ51YaVDKr84x6SnKQ1jbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 04:14:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 04:14:22 +0000
Date: Tue, 8 Apr 2025 21:14:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, Dan Williams
	<dan.j.williams@intel.com>
CC: kernel test robot <lkp@intel.com>, <Jonathan.Cameron@huawei.com>,
	<rppt@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<akpm@linux-foundation.org>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <bfaccini@nvidia.com>, <haibo1.xu@intel.com>,
	<david@redhat.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <chenbaozi@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <67f5f41ae7a87_720529463@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
 <202503282026.QNaOAK79-lkp@intel.com>
 <67eef72411bec_464ec29434@dwillia2-xfh.jf.intel.com.notmuch>
 <54b74f06.68e1.19618bc860e.Coremail.wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54b74f06.68e1.19618bc860e.Coremail.wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 604c720c-a6d3-48df-f29c-08dd771d0190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kGHceg3kpeIgUM/c1Y9MzTNAlHVbQNGcmbQVuyPcGRIh/IBmgDL/0YZoFLL0?=
 =?us-ascii?Q?nkHUQrv5HdOEbgiqMwmeQwgWMogolIgT5bHAbAuJr81w2+uBWYDAo2t32jvx?=
 =?us-ascii?Q?Sv/fFlO9v7BhAzR+F3GUQFx6xLhm/lX4JegIL/RX/0kHSPyWMn/7BkPBPcjx?=
 =?us-ascii?Q?Ipzy5124G6ybimPWOMY5S8zetJ2VgkWoISYmrPS4OUtPpE3PI+R5vrHTBDLl?=
 =?us-ascii?Q?UikV/TRDFwlOKoTH4J2qPwp9yIbWAUwWpcrYmC/UImQBqUModg59gN7jxLaR?=
 =?us-ascii?Q?259mGX9KPCrHPcWi502OlkRNTlQH/N+J0y9rG5Uj/he3E6LwXMSanvcuOmgt?=
 =?us-ascii?Q?ZJzR/5C8k3dBKvkC1cZuIUFYKzeyFpb9jZf7uN6DkcV6CPneCGjmtHoOylSn?=
 =?us-ascii?Q?ZRV/yvRe/qzKADteDAOH4W5RMnRFI5muE3gXVRLrRAyhLWZ9XwzWCq4Tk31r?=
 =?us-ascii?Q?vmCLoEqgr2iQLHufHL8a5CnBBPAkyz/iHMxcw2cjcLaCCpVC2hNMSXFAh9Tc?=
 =?us-ascii?Q?iz/65tKTvuuZuP2k49FuwrEt04tosar1DYOEkYc7e6LVGga14tZmYcu0l5DT?=
 =?us-ascii?Q?vCHAAl0huqCZZ5j3ccevddXXch9LGMwGi0NY7MBo/4F+tnxU6PBudZd089EC?=
 =?us-ascii?Q?fwnNSyTsbV1XfWvyh6ufXaWJKFQQNslqFPfCwvDQvA4qkrx9++0LamXNVZT9?=
 =?us-ascii?Q?NRtvvXk7FBmKyHKwebLgouSqaBVA4LNuiAl5j0LAWf9j40faxqvMNp7MvnH9?=
 =?us-ascii?Q?ppEMczBIDYI/W98pMLFlaYJrIF6xrKw1WvoxxE3DjXMO3hyo3J49fpsmzcZK?=
 =?us-ascii?Q?z0uZp8/si5K1xtympK7YHRanj8gFTDLxs0aT8kM1HulrYcrYIM8phIdPewvW?=
 =?us-ascii?Q?Hi40Y3Sh+4tPIvm2++gOGLznx4WY9jvs7zheu52OlqlLux/3HPfXdaxX6Xq/?=
 =?us-ascii?Q?Ve+cEKGcSsZZ2vIVAbEUzvxQSAeSefiEvFizEg60e0QOVggS/PgTg+SZjHi2?=
 =?us-ascii?Q?b7D40GpZc3lXTMHu5zucQQovhUfeRvpuwvJKDY08z/D/ApE776GS7ltBWuIF?=
 =?us-ascii?Q?+GVEIrnt1TrRsH17dI26/e8kMuvizBCbW4YkAUfda1ngvkiwb3JdtVaM8Nu8?=
 =?us-ascii?Q?d9tdAOm/AU/D/3ANX2utbPE8FNXMM4ToY72ATYw0xBmUpRNuuYYtQLZeVhrW?=
 =?us-ascii?Q?vSKrVDufJuJlGiQkEERvW25f9GPyDg7gHTfJCejk6RdYDt2tHLaa9iIqouHj?=
 =?us-ascii?Q?3lcRwBAMhfQn5c/W8nDOOSqdBWSe6bG6brbzbSIi5fFJn1x9Y9Ry6sQ64EID?=
 =?us-ascii?Q?9Xi+wKZ48yDFyAL48hDCizg2V0IkVmlnoelt2ZL455vmXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L06QvvSBkvq7X9bW9I5yAdsouwMOtiHtvJM0D0hVx2bIu8vhdsRJOcMMAqgt?=
 =?us-ascii?Q?7FUCVlIGYfBTrlvitTDQD9ei44BjiwVUpdgYgJrtt1MF2A5FdJX07veMrwpJ?=
 =?us-ascii?Q?NvtfNFXA+jYAAq5acE0zdYjbpWKF6JXOkQYbQdft0C88g3FPpMP3KyJVB5DL?=
 =?us-ascii?Q?MK1wWxjUZo8wsZr+iFC64NviRkUVY7Nop3/9lnb9Cqx5JXYWoA+INqNFW8Ot?=
 =?us-ascii?Q?TwIhCcoLd2uL5uefIeNnOHDMjXhjDlZgeYsFQ625xQNh3SHkPsyptIzCeccM?=
 =?us-ascii?Q?9CJLmYBkPq8dX0ENuX7tuhKp0r2MM6juffSMK3DTxvdjA3pQWTk6sKuyyKiw?=
 =?us-ascii?Q?1889m1aP8RvPsrpyYLQU6k3WMqvXaM0/xxfb8aLlTkqEJfJq3b5QQVY3A4NN?=
 =?us-ascii?Q?ViAek/F84scf4i/Zo8qEKlvSki2PTGeOUmu0BTvYlEzIVoEiapaoF1ttJjIM?=
 =?us-ascii?Q?YpTMATNhnGAUolzz4+uLVZIM4BEWYEvapi38L2XkgW9uzkwzh7Iz0s5mVHRE?=
 =?us-ascii?Q?HgI0vHnZsKgGWHNAAs+ZHrNH4IGuUhhsCA3zuDuYGKLPDp1hjqgGutADyqhM?=
 =?us-ascii?Q?JqBmVGJdAnwICx0Qg7Ydz8nuyf7LDHTklhUC6og/uYxL5ONBppcdnw34HdXi?=
 =?us-ascii?Q?xtlk/18y3NrusQBFzSrLYzrbcyFV91cLRAhYInbu7QZsZ4jtRUsFCefkRh3+?=
 =?us-ascii?Q?bHGNgfY/T89+xTsnWieHGMnn5tfZUfrwh7nbf7jnv2/TrHl9JI6unuXvf9HW?=
 =?us-ascii?Q?0M+3m1CcT7ytwN+CgvR1d/YDu4ns0pfrnkOq7pI1HX8uqkj4XuoJdI1kzoSh?=
 =?us-ascii?Q?Edq4r4wobJ0+UfSPuuyQ4NNH26pWzWwt7MzPyuWESedMBek4Bxsp0M5lh34z?=
 =?us-ascii?Q?ExdHPlFX3B7RvZkhjlI4x32nSTlYmEjgHhp7yKqhJZFsjKBhr4cITjTix5LG?=
 =?us-ascii?Q?xD6rxj8lEIoDWNrGBlIWn6ytxSwEc6+CUOBg0TTDOupGsxr2GVRjM7smXR2l?=
 =?us-ascii?Q?vguY69mG9tcXUZG837VBdZfBZ4OCd832cWj2/OIOqH+ErenjG9TffsMyhPn1?=
 =?us-ascii?Q?q4pW18ukH73Lxv+Y8Cia3cHUemBC+WVdT8gkIP0c77m0BNR+w7Tbihlw7k+4?=
 =?us-ascii?Q?vxWHyBD5AdF+kWF49hBXWOY1gQNy8laqdYT43Ut3oeZI04mFG6KPTl4QYm6n?=
 =?us-ascii?Q?iuQzW7HejBY+nw79IK7QuxDlpLR0vn4+u+kr22BqpKzMdBjGtKySk78I9P7R?=
 =?us-ascii?Q?SDl39zp4gZsYBl04h5mEv+2GYrANMpT3F8D5urFCA2VLCv6yuIgGZcuHMIs5?=
 =?us-ascii?Q?JNwJx4eOoOa1PhjgGr5pwVecA0Pdq3/NYFmB23QdCaYh7gSD1vRXglGuGiCi?=
 =?us-ascii?Q?+qaaSQtyUBn2v9PxrD6rWJg1HRv4ecPeOzL138RLhpUA46ZhIn59QDAgP6sf?=
 =?us-ascii?Q?jNbAl1RB8QBXqu9CyEG9LHgrYn8wXFJbYdh/FW9kYAhTnmctBk5P8GPbQCMB?=
 =?us-ascii?Q?9cTNP+x7/1H36oAE0qVxxBmuJ5ZMbfxOLTNziHH4ohIIrJer7SYOBSmcja9m?=
 =?us-ascii?Q?39KHKDBahoBERJzMUCNUMUxKHgH4s6NyJXWBocUZN3tUZpF6IpZ0N2BWKCR9?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 604c720c-a6d3-48df-f29c-08dd771d0190
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:14:22.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9OTrMSxe59LhIa7loYna2MV0s12KMcGwf6zPqxySxHp5+oCk52O8Miag1GRh/yisCzglOZXV9KwO49OPHGbe8kuIQuyhqNciH2FeyOPAuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> 
> > [add loongarch folks, cc linux-cxl ]
> > 
> > kernel test robot wrote:
> > > Hi Yuquan,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on akpm-mm/mm-everything]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Yuquan-Wang/mm-numa_memblks-introduce-numa_add_reserved_memblk/20250328-172428
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link:    https://lore.kernel.org/r/20250328092132.2695299-1-wangyuquan1236%40phytium.com.cn
> > > patch subject: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
> > > config: loongarch-randconfig-002-20250328 (https://download.01.org/0day-ci/archive/20250328/202503282026.QNaOAK79-lkp@intel.com/config)
> > > compiler: loongarch64-linux-gcc (GCC) 14.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250328/202503282026.QNaOAK79-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202503282026.QNaOAK79-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    In file included from include/linux/build_bug.h:5,
> > >                     from include/linux/container_of.h:5,
> > >                     from include/linux/list.h:5,
> > >                     from include/linux/module.h:12,
> > >                     from drivers/acpi/numa/srat.c:10:
> > >    drivers/acpi/numa/srat.c: In function 'acpi_parse_cfmws':
> > > >> drivers/acpi/numa/srat.c:461:13: error: implicit declaration of function 'numa_add_reserved_memblk' [-Wimplicit-function-declaration]
> > >      461 |         if (numa_add_reserved_memblk(node, start, end) < 0) {
> > >          |             ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > So it looks like loongarch was left out of the numa_memblks conversion:
> > 87482708210f ("mm: introduce numa_memblks")
> > 
> > I think the update needed is something like this (untested):
> > 
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 2b8bd27a852f..cac16c827159 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -183,6 +183,7 @@ config LOONGARCH
> >   select MODULES_USE_ELF_RELA if MODULES
> >   select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >   select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > + select NUMA_MEMBLKS
> >   select OF
> >   select OF_EARLY_FLATTREE
> >   select PCI
> > diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
> > index b5f9de9f102e..bbf9f70bd25f 100644
> > --- a/arch/loongarch/include/asm/numa.h
> > +++ b/arch/loongarch/include/asm/numa.h
> > @@ -22,20 +22,6 @@ extern int numa_off;
> >  extern s16 __cpuid_to_node[CONFIG_NR_CPUS];
> >  extern nodemask_t numa_nodes_parsed __initdata;
> >  
> > -struct numa_memblk {
> > - u64 start;
> > - u64 end;
> > - int nid;
> > -};
> > -
> > -#define NR_NODE_MEMBLKS (MAX_NUMNODES*2)
> > -struct numa_meminfo {
> > - int nr_blks;
> > - struct numa_memblk blk[NR_NODE_MEMBLKS];
> > -};
> > -
> > -extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > -
> >  extern void __init early_numa_add_cpu(int cpuid, s16 node);
> >  extern void numa_add_cpu(unsigned int cpu);
> >  extern void numa_remove_cpu(unsigned int cpu);
> > diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> > index 84fe7f854820..57b21082e893 100644
> > --- a/arch/loongarch/kernel/numa.c
> > +++ b/arch/loongarch/kernel/numa.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/efi.h>
> >  #include <linux/irq.h>
> >  #include <linux/pci.h>
> > +#include <linux/numa_memblks.h>
> >  #include <asm/bootinfo.h>
> >  #include <asm/loongson.h>
> >  #include <asm/numa.h>
> > 
> > Could someone from the loongarch side propose the fixups needed here so
> > Yuquan can land this patch?
> 
> Hi, Dan
> 
> Should I wait for Loongarch folks's replies or draft a new patch for Loongarch
> to introduce numa_memblks according to your suggested code?

I would say go ahead and introduce the suggested changes. I think the
risk is low that copying what is done for numa_add_memblk() will break
something, and they can always jump in to fix that up if the worst case
happens.

