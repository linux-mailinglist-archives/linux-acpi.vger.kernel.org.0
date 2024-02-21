Return-Path: <linux-acpi+bounces-3803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C285E933
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 21:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C662A2848B0
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7542A8E;
	Wed, 21 Feb 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hbl3Kwon"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CB3A1DB;
	Wed, 21 Feb 2024 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548102; cv=fail; b=h/0fpOD0D1KslSwlFOq/crNA3Q45tp/MF9++U33CLqupojoQS7X5Enfcaw0N90jUq+zWZr23+75IB4/IDoW6YWnt0HPpzbzWMDtZjsrQGaN1FbcHBQQp5f5IzraIE2VMZCOjb7RuJV26eHAhAK3CeqW86PLEZSdkHPgh45jKCeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548102; c=relaxed/simple;
	bh=DMI/ZexLDTIaRe+2HWJNzS/32EwjRzYFaOgQwVINp5s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Liuy+7vbc3HjzVJoTYzRRi8AyH5Cj/LHrE2mVE9/Gn6xxJLgV4QNU3Lhm7YBIGDB+yS2yHQQAuWW/V/vJPWSSAT+m3KaPk/jga14dLqIUSm2CJ0mMSK2ZFCv2/sH+3oQVnaOpqLimw/IJ6Y7DmMI7upyG2O/m81nTlh4WeIP/fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hbl3Kwon; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708548100; x=1740084100;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DMI/ZexLDTIaRe+2HWJNzS/32EwjRzYFaOgQwVINp5s=;
  b=Hbl3KwoniuhAMsH/qqneabSkH1Z6aERgTX1/Q6m2dX2Y7qiDBT9V6UwA
   YdYGunSG2T5C1Zh1Uz/LlR24wQVBiwxaV2O/5ScvL4cIP1LNXc3Nq+5fG
   UmfEUMLtFxxslHVrzYkqCRPWXMp7dOSamF2bSjTb8KQBk9dDZBPUYNm6J
   UIzRRH4wdSmJZtH3uOclYnsmLHB7BPsv3EgO71YrsKBs7Dq1mPoaWNyL2
   wIDQHdEPZXyvnBQ2T9Fda2YUnN39ytzVqhf5z+bbyr0HDDggyCNttZabC
   Y1MGBqCOfWI2/NCbYeSK8rmF5eQE2bOscNsCyv+G5vGFNSv+eBwekFmus
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14157085"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="14157085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 12:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9958071"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 12:41:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 12:41:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 12:41:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 12:41:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 12:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzsc8oEP2X/rWWBQjjBuRUg4bvV0yFzGEUuFGtkZCb2ItfVjX0aVe9wMRZOfuMgcT7QFvIJt15wW6dVCxMi+zK26zwezxwtoa8xFqgkYqUmXZm+REosNP3iTcVSFYrTWfKegPBeD+o6zKzbpWQdd0aSZfnYL8Cfv7uhgw3KbieOYmcdWHpTxDDvw+j6PQ59F43dHKuQKjiRpC90bKitkPQGGLvlQ9y/sKznfgMlLlrhzxZi00QrCdd5yfd0VuoeHtCjxXttlDMdZIMW22UO/nEU5JyucevDn+kvuwoMfi5sag3bhGr/DKcKkWi4cE+zcNZ3AmUjJ/R3gjuJ/oHD6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ2ITTgz700nuk5Mu+6Pape41UkM0TZsuNgSY8VHhLg=;
 b=MqIKHQNXkN90025ButJAc9zNZ8/eYI6esFNsVLZOhoTEGx3V7rxz/vdMJc+f7o/WkEGKjEBSW7W3Joak58UtdWFVJ3AzVeNsv0CiaKJuXmrEkiHNDdm0QrqtW6s+xFlgAIXEKK+euqam1Vo7i9ZrPN4vGK/U+xWRBxmYNZC2ky7gRHAfnk+OJNrKv5/XANxEK/CRkMLlTbXeqtPoBr/pdCQPEfjMWNmunXmxpOnP9/IaMXdF4VNZh9aDXb2URclGcHrTje2Y9MehCPQBz9kNAA+DPAfyBdWYA+AYgEOUdfl2wHGH0T0B6+Ol2/shP7Om+07oC7CK+duF7VWAXtcIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6383.namprd11.prod.outlook.com (2603:10b6:8:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 20:41:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:41:35 +0000
Date: Wed, 21 Feb 2024 12:41:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
Message-ID: <65d65ffdd40f_5c76294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
 <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
 <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
X-ClientProxiedBy: MW4PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:303:b5::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b8694a-1c61-4171-41fe-08dc331d7ee1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygTPpzdOGl/Y29BoQy9hUxLgCrfAf/2gIpYVmSgOvRZaGdhu4qj/MnFLEomIvyZpXoWqAZkBAKK/r+5SmnhAxdVq/Ls9FFrOuxfe2n8NeGP9b5UqUX2WvWJTex3x9T8HOXKP4WRptfeZE4N1sH+vDwixPL/2kcS03fnYKRQx1GT6HY2MitXLAtNP6dbTHSaAn56bpYbor5negXHa2haXYwjjv0olWCYoqp9lYd+OGS7g0XlY/yXiHvENuvLiaVb2N2oGO4fDJhfVByQ0QHdjSBA53U/tBui+BGptSj5KhgWLshBlYHhEYFrPtLO36p6ZCeQwaEBfZ3Cl+HZLc3loImDMEF1l7B2y1rGG25HfJqjOMoSCA7B3Qp+GytueAOEUvhOxxWte49rtZobbnnuml0Wtc0I134n7cx2ckWGUJPaApCTwkjgEvFUP+S7MH1zwURcpSuauu+msIqODzhqqW5DXjVwJnXH495Ox1rc5VmzDSQ0yF3tRVkbriplS/VL4czrWo44xX4HeLn7xkD7eUQHSbVajs2SA5ywvguEXwys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyqEBimHaroOkat0Wyk3fAvr2PAgWtAKRSIkLRCICWszkCfrflwPyMTYmssm?=
 =?us-ascii?Q?tJp00vsXSoBQMszW8OlyYTNYxnblDgbFYRuZyffzDABYohj/7TBbJX3cgVbo?=
 =?us-ascii?Q?MFquXxBxJqB6/SY/EqSzRBTW73o8ImKyvF4XXkevd7ps3OuiFXNwaSZQVzq8?=
 =?us-ascii?Q?Ebv27WcHyUo4AJT+pf6WdJ91G5pJUx3Ru1L6tfGGo25Gv8gP2eOZBpJ2uBGz?=
 =?us-ascii?Q?P8dqi1Lql5DQejCbki50037rZHMzFNaLuoEvh7dlemfzfOpBFug/Wu2f09aK?=
 =?us-ascii?Q?A1GM4vNB6b3gR24t3Hdwt+5R6F6pv9TOqQkyYacpO1aa3hnnQn7/R7wjfA4C?=
 =?us-ascii?Q?kgaTycafTiTAHjvyABvEmtmPQcEryc66RK2Xj4RXYSRKGzoZierRDLeHm81q?=
 =?us-ascii?Q?WOyXK/Yig6z/ci6ea48awROR8JVG0lqwoG9bN2dnPDYgHpfIfK3C3arnaDzg?=
 =?us-ascii?Q?Ebq1oMrHFoFLy3icA3JlbvYHxHe6/dEti3MXJv1eVuI4D/wT2FlVpPnoT0di?=
 =?us-ascii?Q?rcC5rERyGtnutrO6SUfgOVLF/S7RVkkTRln4m66n0YKHGmNByaJA52+5DnWG?=
 =?us-ascii?Q?UFUkHxSPcDDmQRJworYK6v6X0E3amJf6p9TMmdkc+F/ZHBYMCRpl4MaonV3p?=
 =?us-ascii?Q?9iklckqQ8zwYJpV6ceLFw4b76rctAW/Pn5jtBZZEEF0/yKGxHVCRoVnkc8QY?=
 =?us-ascii?Q?JyW8z6lvYFe6USTMWHRtQR3LzxKzHDaLT9TFKQg/M6ufMoF6mFtgsWAZVVkE?=
 =?us-ascii?Q?+QKEWxkaE/9fYaD1bkJ789yEWHjtOCgCoi/U7cohBh6BPaBxjnuWiYGQgdj6?=
 =?us-ascii?Q?AImWHlzCEOAsodua2tnBCB2vCCGWVSGEemiIyM2KB28immkgBOL+Jirpygly?=
 =?us-ascii?Q?TIQhPS+xxRe3Zj26kKQPwg99ZtUc7cAwkylaCmOMwtzsA7fTP0Egq+DZL6Is?=
 =?us-ascii?Q?8MW4TjWH579kJACT26iUVNK6q9V8q2bmK4mC5RnyL8NnzPRLI1z334PjOKy/?=
 =?us-ascii?Q?ZmMu1iuwInfsbg8Pv7+IrXliH82F2N9LLYkYtZvTGGU//0Kh+Ug+Q4X6wKwD?=
 =?us-ascii?Q?B1MhST0s9BSMMxygzQ1s7I8No5JPc5s9ZxwZeWHXxiLuGrKa358tEOxEv5HF?=
 =?us-ascii?Q?+D7Uk2JQ7hdJkwYbaOlIMAQ2Ka51ltiGQTNSppBPqv4odgBxvH7oTNeA+YL+?=
 =?us-ascii?Q?qfn4hcSP8txU8p2Zxp5GP51wkr0FkcPS0r3jnnaObLdbu/wuMj7SB5FFxUpr?=
 =?us-ascii?Q?I3ECAA/ji2O+SIEJCYdq5iMyTgXuz59ySAPyPCjAkcNpwlPLhEbyQIM4NNVx?=
 =?us-ascii?Q?ERxITDdcGkQSfvmJFLruorsv3PqZ4RXPoVm2ti+npVeUsKwxz7ln81BsR2dj?=
 =?us-ascii?Q?3THjSSKS1plNfS+H/9v8IL5jCmZ4wzJ+KdEhSD596phjj4sYahgjDx+VV5I2?=
 =?us-ascii?Q?gKcxc6U72WC5YI3ue+YBUgZ2JIp3dS3Qrix4zHSHAhswcUiKSwEEctpcIEBG?=
 =?us-ascii?Q?HgEmrYvk0OY/ggCzltFFWuJ9FmJfVSEvlSGc3gnKZM2124ZTfRqghYKgBtko?=
 =?us-ascii?Q?Co+LQs0GDkEKDJ533PexnJAjf6NrQn3ejy9HqbvlA1HX7yPDcdFvpc+EpSuB?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b8694a-1c61-4171-41fe-08dc331d7ee1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:41:35.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1jifgymyrdj61CANaZLtWtb1NY35e47z6xIF5YvhuOzWNvxhmZEMrJu3yPYjP3jf+G79D4QeXxb6kNW1ZIbkv6Oz3DA3RFvQxw6sAUIjDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6383
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> 
> 
> On 2/21/24 11:43 AM, Dan Williams wrote:
> > Ben Cheatham wrote:
> >> Remove CXL protocol error types from the EINJ module and move them to
> >> a new einj_cxl module. The einj_cxl module implements the necessary
> >> handling for CXL protocol error injection and exposes an API for the
> >> CXL core to use said functionality. Because the CXL error types
> >> require special handling, only allow them to be injected through the
> >> einj_cxl module and return an error when attempting to inject through
> >> "regular" EINJ.
> > 
> > So Robustness Principle says be conservative in what you send and
> > liberal in what you accept. So cleaning up the reporting of CXL
> > capabilities over to the new interface is consistent with that
> > principle, but not removing the ability to inject via the legacy
> > interface. Especially since that has been the status quo for a few
> > kernel cycles is there a good reason to actively prevent usage of that
> > path?
> > 
> 
> For CXL 2.0+ ports it's fine since EINJ only expects an SBDF which is
> pretty readily accessible by the user. CXL 1.1/1.0 ports however, it's a bit
> of a headache. It would require the user to find the address of the RCRB
> for the port and supply that to the EINJ module. I originally had this option
> anyway, but I think it got shot down for being too obtuse to use (I think by
> you, but it's been a while xD). If you think it's still worthwhile I can
> remove the restriction for both types of ports or just the 2.0+ ports.

So, to be clear, yes I NAKd that being the primary interface, and I am
not changing my mind on it being too obtuse to inflict on end users.
However, just because it is too obtuse to be the primary interface does
not mean that if someone runs that gauntlet, or has expert knowledge of
where RCRB is located, that they be tripped up at the last moment from
specifying that parameter via the legacy path.

So consider it an undocumented feature, and I think it only ends up
being a one line change to let that parameter through, if it can be done
safely.

That said, if there is any concern about input validation and safety
then keep the policy as you have it.

> For CXL 1.0/1.1 ports there's also the security issue of being able to inject
> to any address since the way it works is by skipping the memory address
> checks, but since this is a debug module I don't think it's that big
> of a deal.

Say more here, this seems like just the safety issue I just mentioned
that would justify forcing folks through the CXL interface. Depending on
how severe this is it might also require backporting the removal of CXL
injection from older kernels.

The main concern would be whether einj needs to disabled when kernel
lockdown is enabled.

