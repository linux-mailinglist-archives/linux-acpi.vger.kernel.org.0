Return-Path: <linux-acpi+bounces-2785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F782A3C7
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 23:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377FA1F26CB0
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E94F884;
	Wed, 10 Jan 2024 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4oiUuWV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975C4F1E5;
	Wed, 10 Jan 2024 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704924638; x=1736460638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qYdl5LuKTk9US+oRFAMeleTyvAKFoUsscttxVv0rQT4=;
  b=f4oiUuWV7vzXobzge3WovBdKlGgeUuGYUu+HRlcYn+Ozjv9jytZW8XIZ
   fgCRHq2+2Mw2I+xLBtuMAG4UHIn5W5jyIctYIQG33qmSgEwa4LVZaxJ/F
   VodPHr2fxo5MvE1B0ETkIWndp8ioLjOwx4SIv4ieKb1zfYG9RjlvVgDaD
   771MWh/fI1wAt+6RKIZi5CpWrpEcIgtjZ9AdZz/MVIwjjhGOnAuwa+Ytj
   ZaFvjUEyLkfdkpXtkPjRFlOzwWL2M31SkX/VDEtkzw2x5w1ZMzRt1W2C+
   FrsRo4HUVMR29S3LMhTRaJ87AlCn6af4ykFTTMG9Krlg1wm4TlIkJn9jk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5436835"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5436835"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 14:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="24097775"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 14:10:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 14:10:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 14:10:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 14:10:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 14:10:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhYj4E29ubEOK6pgPgom91at5i8CNztE39a/lAozlu5EXtLeZ75sRVqfXO3RyWmoW8v0KoYhdql8Px4vBuNoHXB27sxydhA5TBWsblNqY2O8xsdemFGISpt9KZJBMNL9sj2Yks+8lDC/zovYQdIynYJNOzoGrfaY9W8MD87/tGV8p5cpv2cafnetC8UcPE2u8YNQovKicoSuPyyrE8tbrm/RJTPhdZb3hj3m+AFXGc5QcNxrnmfUWav9m5CKixN70IFdTkaQa+HAuGv9B+nzgXxI7/dpnFWSOOGzArlD8vY0Vo/5JrZzTjjLQKhVclEsm7HNeg4Eu97oeaQUOKYBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06lAa5N4h7jAqkES3DGndUTZAH9f97i+e1SaZF1Rtdg=;
 b=DvAul9dmEHDiH16ARWECCI3ouJsiZfILehjiwDgVZ4BQFyw1399HMRZAZGCzF1AwfE+O4lEX/O2ktwWx39ygyZLJ6cCerSFrUI2tpm7zMTQNlAj07J0c+KtWb2LpnqaF+lTRtC1cNtLzp9uyuMLDhnqp+w2ZmR+/jNsKXG1wVU7DNly7c6cVe3YNq3DGJOK9gB9LiJy7N8oW8TfRVU8tY4T2EMSp3bt/vNVReVJweN9VAGPvE0ZWlP2c3mBNlWrafPlpV6Aa03j1iVPaSO0PrfUdH9pz7mVH1Dn5pq2u4rhiWOoS0pgoRJMUg2/z+AIpSAHg+HUFZCQH7fhmIGoKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 22:10:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 22:10:29 +0000
Date: Wed, 10 Jan 2024 14:10:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 4/5] cxl/core, EINJ: Add CXL debugfs files and EINJ
 functions
Message-ID: <659f15d1b4a6e_5cee2946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-5-Benjamin.Cheatham@amd.com>
 <65812045c086b_71549294aa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <83ab6ac9-8e64-475e-8ef3-a605cfafedac@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83ab6ac9-8e64-475e-8ef3-a605cfafedac@amd.com>
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d644a3-3b6c-460e-b230-08dc1228f43f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrAWZJVJSpqcTC5H6vjsRkO7dxjYqHDJLYtyUspFVtOJqPvR3/FnzY35lMNDHyXbcf4Gr/IY56aeLCEcwJMxqoAeIVqD+rHooyHTLv7A0TCLujEhgAZ7o5GsGx7oKC83eewFUGyNqvyIV8t3igZEE+ef6sSz6VRZtxlvA5pbdQ/K8h9TNiMzQby3AASUStJrdVK3QIN2oHRA2/49kFG9BhqkB1f4j0uyB1kSJLT9ogd90sANs0F+S/aXH/N1TuzC0dS82gBX66N9Ny01YcrzmYA3nAfNO/vdUuYKZrI6F4+4vp5pMch3qevJOpfk80k83vcgt617w08YMSM5E08UdGXJwfjqFCL8NNxBwZaTErqFTwcJ3hbGO/0EyIPmTgsJnuSrlEVLoD+K5pRtaPccl4xMmZZS4ECMt0Xwzy4qTs+/Mmof67YYcCsgqdLMabgMovV+T5BktrodnZ2aAjQOo5sHxMfuhw/VLNzsEyVOyXD76sTB592nx2HqIg0ZZj7epnZE9uXkdy6dt+uNhMtYRimnyBdfw0al0aAlSg4w0+ykpbbtoJEyNKHOfoOCQ3Bn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(8676002)(6506007)(6486002)(6666004)(9686003)(6512007)(26005)(66476007)(478600001)(86362001)(8936002)(316002)(66556008)(66946007)(110136005)(83380400001)(38100700002)(82960400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gi3jVY2Dh3W0Y72ExjXCeMFnGw66LNaNGdNS6kvYpL+yyZp5f0itjkJ65s5m?=
 =?us-ascii?Q?s99r7zFfeidWRuZSQAjET/kQde6nqCjp3UMS4JwTgedr0uyegLngIK0hiZpf?=
 =?us-ascii?Q?aIECL4Be1UFLyONw0u++cYCoxQxaWd98E2wpCP2Vc50L3etPmZZmE9mhXcAc?=
 =?us-ascii?Q?0CQoAUViNtqCEvunCyCICKoUf2ttR/BEQh+Q6sjcaM1I9ObfYPGmsMZiK/Lw?=
 =?us-ascii?Q?H9VbRnEy6sTLLmj/fBuzEpBd3jAFqX782pNtjPqQ1/cknPG66jb93JRkC7t0?=
 =?us-ascii?Q?RXAvYnGqSpOu8Uw1YrL6OCHGG/9qSXZPPfThv2CLHJ+CGZQ68WTT07LNCgNJ?=
 =?us-ascii?Q?ZqziZCjHwLeG4BIunKrQAwNgOAU5EAm1WUPHw0+WYJQtdOK8ZsId5Bo2JV3D?=
 =?us-ascii?Q?bAIlKdgyrBZYE4WxspLkahtir+qxiX2piVsMeqE+ox16O0chzzi6pXvR75Hf?=
 =?us-ascii?Q?F7X/Ts+Mt9OVK036K0OBfz86k9ta2kNk7UfAgbqPOttRnFbQHG9ne7yCXRVO?=
 =?us-ascii?Q?Qz4LlQI0FF8sdkxp6PTubkVSpMp8QfWDPogrR8yTLyLIMtNzu8kPUcXw/YCI?=
 =?us-ascii?Q?MbZsBldZVVqWksw+B8iKX53r3+Xzwn8vd2MWQlqV0+KwBalh1dSOsbaw+frd?=
 =?us-ascii?Q?DHiPoIL9N978bWigSp63xTzNCqFWqHkApBdCB3mm+bnEz5zLQP9wvGeu+cT4?=
 =?us-ascii?Q?yIUdhy+9Mrr1ooLnEIKVlW6QgUmYmWMybMmI/ZXTeOBThRPoqWQ8vyhA/fzP?=
 =?us-ascii?Q?vkvhjysFKE1R9mz6mW3iiYJQdhcRjb+FuzjwYNVC0uK6oFfhucKvgQ1vuENQ?=
 =?us-ascii?Q?9+Yf4Rk466AvB6IO2PK+5OLrGJ60ZnClECefNBe9CVgy21U5iSbjUyrN8Q9p?=
 =?us-ascii?Q?gWx5OBr/YTA9y7Ra063n8UZVdXFiW24yXoncte2yZxXEoEO93JEKZsSoT+2n?=
 =?us-ascii?Q?ugl3SHYyKUqGIPBbWxTH7HK1G4H33QRqsCTXw165acKF+suaqX59/vY3fr3p?=
 =?us-ascii?Q?Kt8jweseDFuf6u1oAmTiy/otWNdWq/hhSTP++E8exyigKP6gxtlJ5+a+KDbp?=
 =?us-ascii?Q?Ad/ub1aluZs1NilHn4CgxbXmn9PNPeMDORc5Lny3GiS9SPXWChLRwxYAxyf3?=
 =?us-ascii?Q?dXpCVRYVR//ZVZoMw46zZdZ8ApbOkLTtKFEylpwA+z5l+u7am3NoTsHeZCkL?=
 =?us-ascii?Q?29R6MAs/RGbxrredx1s7YEMkQ1nWGUaiT1stoZ2/sdcpLDpif7DPMZ8btSUf?=
 =?us-ascii?Q?qgavixvN56tuibf6Obk9/ss1nge2X6ufezuc0C3CYu2gi5+lBp9bzO/D+xOL?=
 =?us-ascii?Q?mMyG6ZKH3phD7lZtlx6347KA8fLtyu7+w3kRip2kRUvpyktGHF9s+YuCvXVW?=
 =?us-ascii?Q?Wajbdp5zEoPGNH9F8ucoRskWec7X8e/HR6LRoE4Aw+NXZGtQNO15NMt7BjTO?=
 =?us-ascii?Q?lEogwvGGuuhyRtqM+sFAzqLbWhE+MdQ8Z6XTxnfOck76vbV3PPm3RZ1BFz1E?=
 =?us-ascii?Q?76jAqPb/uwoSQZdGFa+JfMsng8O5I+HkIjBSKPZqU8b14kA6fw35AB2l9Ibf?=
 =?us-ascii?Q?1csnXzE1Z4Gaqq902+EjY3mWCSQ//W05N0VH/ICU1651bbpx+vNrkviYuAT/?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d644a3-3b6c-460e-b230-08dc1228f43f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 22:10:28.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSwA/b2KZhYN1YVBGb5Y4t1UQFbPyvUUrXdL+LQeSpxrALr+CGdHNiPgJaSn2W+u8T+r39/4aTiNRuNSDm1OCW04hxa4QyHEROSTbeg6ekQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
[..]
> >> +
> >> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
> >> +
> >> +	debugfs_create_file("einj_inject", 0200, dir, dport,
> >> +			    &cxl_einj_inject_fops);
> > 
> > I will note that I am little bit uneasy about this ACPI'ism escaping
> > into the common core, but he mitigation for me is that if some other
> > platform firmware invented a platform-firmware method for error inject
> > it would simply need to reuse the einj_cxl_ namespace to make it common.
> > 
> 
> I'll be honest; I'm not sure I understand the concern here, but that's probably
> just inexperience on my part. That being said, I don't mind changing it if you
> have any suggestions!
> 

Notice how the CXL subsystem organizes all the ACPI interface concerns
into drivers/cxl/acpi.c. There are some generic callbacks like the
@calc_hb argument to cxl_root_decoder_alloc(), but there are no direct
ties of the CXL core code to ACPI details. This separation allows, in
principle, a non-ACPI platform (like PowerPC OpenFirmware) to support
CXL without needing to unwind a bunch of CXL-ACPI specific stuff.

This "cxl_einj" work is leaking an ACPI specific term "EINJ" into the
core code. The reason I am ok with this is that the ABI is still gated
on CONFIG_ACPI_APEI_EINJ. Also, we still have the option to require that
OpenFirmware error injection just call their user facing ABI "EINJ" as
well, even if it is a different name in the OpenFirmware specification.
To be clear though no one has sent patches for CXL support on anything
other than ACPI based platforms.

