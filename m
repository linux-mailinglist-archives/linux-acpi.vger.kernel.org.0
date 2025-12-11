Return-Path: <linux-acpi+bounces-19559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D2CB6EF0
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 19:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B08CE300CCD4
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114A2FC00B;
	Thu, 11 Dec 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4Na68iO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA8189F43;
	Thu, 11 Dec 2025 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478691; cv=fail; b=asFj9+54HqKw/rJvt3fL5lA+oqTK7GkFu5DNsTVWussWJ0qcAMch/8iGtMOV9R3n/5Cic5Kfqyxtz2gxTKPigWr0fBF96oGYNpVigxIzjZbcOgJbd5z7a55399Zp/wrvhz4f1z/W+NUj+V+js7ZN5DbzsDFVBzhVpnZu2r+dztw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478691; c=relaxed/simple;
	bh=nXMCUZZw9LQki23KwgrbF+tU9Fr1l7+8PqqLLwBqaWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hKVZX8YlgvZTAB9KiHv7YpxL6nlELDW1/TGiRQiKKmJGj5/Hdn+7QlrK11DWsTtfCzqT20SQoUOER1FC91WzOc90GERAkNHptfGWws5SMtwQQ6xlsEXpE2AmahFxsNCtu8K6qp0t5PTB5rAb3+XogA/d9MGW1umjYn3vMHgYXeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4Na68iO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765478690; x=1797014690;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nXMCUZZw9LQki23KwgrbF+tU9Fr1l7+8PqqLLwBqaWM=;
  b=V4Na68iO5XVLwp8EOrJ/eeT6c7FBp4jjqZTFJIotJRiusYAPFpvwg0h3
   E33rkJb9YJYjmvDGFfdRuHvAIc4nvceEMlMTCV1gxMc0lpE5x4VhpPZIQ
   3lIBR7FNC54U7zSw6qCvSa9A0JLxR1D6+xHGbjNetP7784tFFiGohZzCm
   K39J96G6qlDCdtF77PERcOASSE6vtOzDR72saZEgRLthjSex2UxqUTtaS
   /0YAJP8CtxABT8jbhEscIHI+Y9ZoMsT3/XLH5as4DBU7llJJwsP3DdmiF
   64MhCR2U4y/e0+cTSh9JKvh+HcIrRMlnPuF+sg8vzbz7YvMSFk7y5cemM
   w==;
X-CSE-ConnectionGUID: ay+SsZY3SE+s6VJ44CkDeA==
X-CSE-MsgGUID: jbW1K4P9TfO7HpLY/KF67A==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67640922"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67640922"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 10:44:42 -0800
X-CSE-ConnectionGUID: cRhhzwQvRaSL/dEng/r2hg==
X-CSE-MsgGUID: bVZRWdzNTzqwM1do0EUQXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="196774573"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 10:44:41 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 10:44:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 10:44:40 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 10:44:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8wEGWxzU1eqgKQ5z3T0HW9qQDA+qvoS3ZTwVpjwslgc6uz+x2m/gH/al8s6/lEywne81rRHYkpBgHKQseADP3hFy5zc3gJZT1lCP/uvxjWwEwgOhj4dJ83BlUF3Fdt14VdyhDPmvXsa3XHl3uWCWvi7vrWaQenEkVO5GE4wfq9IFjapysS9QPQMhEPxNPRghSHI12fZGdTTwU1XKzZZa8hqGDv7kRmyajmOnKqRWuCM38qG/ZgA7KEuaj13BuOvY4oBRKmXUMLZrX6PMj5QjlbcojzYEvc+i4u3UCi2fnUPXRXu0QmEEHfmxcpdvSF6JcFB7gRHw/7rVXJtkU9Z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYKMBqA6geWc27+rP5UfDrToj/DBU1J5SAa8Zw1Hou0=;
 b=KEZH0qWe/TYHcFlLijeaAorpi+7PwAN5IqNMzA3SwyMxxKQoujQpNwSjGif5Txp0FAiz8fwNN30QVr7sPB/tqLVs3aQ84iJA4CGk5S0dq65+npl6FzGSxHAf8YpeQHo3QV2l6BgmJjJllO6GkmMvy/aq0dpFU5Okc+/GOOBafsb5BTZrZgnoCUTaxAJ24ArJBGLfJYXBwUt4VD1d9fcN8Z2fsqy0NtpFV2HYgr0fCntQopAiFEVktHW97WcEAQ5RWGOraNDAxMaoJoYljdTAxKu/XI/Evc9ae9S7B987JGm4tTNTV0Bnf1A5jHdvnOGggULYjHGnTPnKvBNIz4gnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 18:44:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 18:44:38 +0000
Date: Thu, 11 Dec 2025 10:44:35 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <guohanjun@huawei.com>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<dave.jiang@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<leitao@debian.org>, <pengdonglin@xiaomi.com>,
	<baolin.wang@linux.alibaba.com>, <benjamin.cheatham@amd.com>, <bp@alien8.de>,
	<dan.j.williams@intel.com>, <james.morse@arm.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rafael@kernel.org>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH 0/3] ACPI: APEI: GHES: Performance improvements for error
 notification handlers
Message-ID: <aTsRE_qMKXVrvA28@agluck-desk3>
References: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 70874cc6-d93e-4009-dae4-08de38e555e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sOAcvGxvkhGgdUHl3nYmUQftANHBxtibgMaMo00/vYpQzo+M3llkpxhZqVpx?=
 =?us-ascii?Q?75WaWuisP5HTPsEqxFHo6BgL1VmOoEb/tW7I+Wy8FGMyWYToxO04I3TRWwp7?=
 =?us-ascii?Q?w7acnTGNth1VFpOq/ijkkdZqNJ2tgk69yJn2IeZ9mAhscAVI3M0J1c+Re5R9?=
 =?us-ascii?Q?u4MZC9GSJnY0t5d4LHoUXRBwuvXPilSfk7d5LM8YCTt6oN5RviIaH/MYG2A6?=
 =?us-ascii?Q?UoXefyfXmoLHPHrq5b2QIuL2ZP8MMLCG9/MV0IOV5FCPfO0Iuy4XcNeyBTuL?=
 =?us-ascii?Q?1bjsohorj8xJyK60D7zA4R5QJe85i47qBIrmLsAxdJ8DnrvO+9svebN76Pmg?=
 =?us-ascii?Q?9r3sM8TYqNniextwWrpX6bwT3IgI1LQnYGd2hdbZhfU2mVEJUCR/dnz6g/TG?=
 =?us-ascii?Q?g0TKDmoi71izcUfLsDtMDhm9fpim/qoesH32CBnQ/QsDnTf0ZA51m/qmsl0/?=
 =?us-ascii?Q?S75FmhN3Q7JyLay5thB5hf1ged4FWwqyrzq93mRumsp1DxAxtY7ysYP0cksF?=
 =?us-ascii?Q?ce7Du3HugLcyBO5X9YdN7nbNdIK4R49nnaoD4zZaIIm78YDnNH0TfNr66gJ4?=
 =?us-ascii?Q?3FjK6rUfTBUF1DzbrPP9KiaMRvXbiUPWdREhm4N9abwomqjNADs/Xw+aWLMi?=
 =?us-ascii?Q?VKO0CGO+L1LZZP4ShUyPWlbfOEAgkogMD1q9QVy25jj/QGj6mIWW8i53pbDJ?=
 =?us-ascii?Q?pYubRZ/78OMa4Atzj3fU63f8vPfVb8gzRArGQxN/xWdvCIcw5mJwjiRV1kwt?=
 =?us-ascii?Q?7A9BQtzOj1KPUb8asEeBzVRDlrXtj2wPQ9AMlkr2AWaSQd/zaJxFGQwt2KTy?=
 =?us-ascii?Q?ckiEH2uA76xw2HliGw1lbJ1m05h1GLs8rWRnHu+BFg9mk9AN1plxg2lCsG45?=
 =?us-ascii?Q?kU8b/3rVuhQ3wz9b/WdfvFeHiq5yds+d1IUnXOKgDw3dMfQhrC2zbyXk62rx?=
 =?us-ascii?Q?xUsW/s2n2tQ7ZAkJc+EWgFWP2bCWQ/RGy6+Y/UBr6iIihSnxwcZAdf3tSDqW?=
 =?us-ascii?Q?vYenYb//YAKVWVOgJdoVSZUxilX8IJC9voYskUzpRZudMReTcgFDXO3ompIe?=
 =?us-ascii?Q?bhtNgE1SR3h6pJmaN2ieVO9dW3XmrZbcBaH3sH1B7Vf+5IavqcaarqSX0CnG?=
 =?us-ascii?Q?wPVV6Bpapc+hMhNMJIY9oPsjrpxZBKxzE+9aQCN7VbmbVnzJ52lQ2kAe4D1W?=
 =?us-ascii?Q?CSM7MaewxgWL+s4QstvuaDkH6m8pei2Geh8ayBNbJgVsHupFYIcpWL+Ne/4g?=
 =?us-ascii?Q?7TPges93eXJTCSbg3NO/2j3l+OSzYQ1GSFt4y11noPR8zy3q5SL7ghDOuqqv?=
 =?us-ascii?Q?LVYZIQi6cQ5ie+fLXfyuCiF0yp6AUHtgGiWqw/CghqbM0G7Tq7dAvNLQSi8W?=
 =?us-ascii?Q?3Z7BsvVCvKTDNM8qQ4aERKTz71U6hKBqaZGJN+FNjyrejYc2iqHhEsb6gN1K?=
 =?us-ascii?Q?ssfoZ/6V28Uho3cha9pwMa8VTPQyjD0z9fA8VSV4Dj63LUStandFQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfE3x01ZX91Iv8pqGsuE5Gu9kei9V/FFpRkjMmRqV+50DSHhX2LQwKZ8l5Mf?=
 =?us-ascii?Q?fj8M0NeMEnOg+D08q4JIWEXpQnM3yi9kzKoZLs2NgiGp2YXq+cxTGUMe4qFb?=
 =?us-ascii?Q?1tdAJUhAokC876Rr6193O6R+b2AUWdXTUjouLtx1Qy4fdfy9YOU2GpbJvS9l?=
 =?us-ascii?Q?cSraX5gSNL9wrqoRtKua5ErHVSp+gIFzZuHp/FURB+FVHdyADssnJJLuVKzl?=
 =?us-ascii?Q?C1NqZ2TkKVKsnfQP3wfR6S+si1/BYLfNQtWcMv3zvnB4mrkvgesTYmSD2lHk?=
 =?us-ascii?Q?SRQXiilaPuNEdTQ6Q5+EHwKkOySpl55NvZV4YXVdse3vSayJhS1Fw0ljNLDI?=
 =?us-ascii?Q?XQ8yQUWh87itrdAfW7MeNMyS1XeiOwHNBPh1MnQDL/qkjuR8hWDCqhAKH+Jo?=
 =?us-ascii?Q?3qqtjqWUy2lXheUXy53A781cbXuGTRq6ICIT0dJuNzjbueRybmQZOqcXH4ju?=
 =?us-ascii?Q?HzYyj60i0AvPsnsubKUzVGv1QudNkQ9qf/Syw8qrUB9zLHh3VTWzX1BX1kfV?=
 =?us-ascii?Q?gGEMsyvouks+sso6ZvSoXJGYwij0s5s/eZMA8l15Lme2/wcsxy3ZawH9kW+f?=
 =?us-ascii?Q?lekALiGkJpdCEWkbLvVHO6MxOx13v9EWGt0lPzmXLjHisFNAanRCShkllEAd?=
 =?us-ascii?Q?fdfhUKL8zzDcXHUTaPpkXhGCufWNWDi/2mjICxqjkSXskmKW0D7HVjPOly68?=
 =?us-ascii?Q?5S8nk7r4U+o8S6YdYEySXQsYXuGD/DAB/DH2g06nU7cfw3k0pD8Os9KbOwkV?=
 =?us-ascii?Q?Oh6LWJjqLsEXqdm1WdPC7lR0pR8+eCt5b/mOOOhgpUMoL7r+r+ZBDU9HsqSs?=
 =?us-ascii?Q?MrDOhCf5yva0NuiWIq/uLYgD1xALf8eGtcQMNHomwqL2h/WLP15Mm7eqmwR7?=
 =?us-ascii?Q?zvFC0qXppW/izfWrTZdgDLcVANw080qsZkQsSRtR9fPxtLUhrN6+TjT0wYGs?=
 =?us-ascii?Q?C5ppQAUM+NG5LfUsfNe7tTsEti+t4KyTqgUM6FQ4SO7wQB5s0+/JjeDxNGov?=
 =?us-ascii?Q?BexHCFWinqzmx+i8LhJCdMAZIx3+Z2DerqrL/DSFYqc9B7Ap/dggf/O0cpdJ?=
 =?us-ascii?Q?sOLKUZIE+qAPP5ygbwcy9WEnnoscTyY0h4xB2xnAq6VEJbor8le+BEotJqOr?=
 =?us-ascii?Q?DJfsj/rRB3JmxetVLmEetM+Wu79Hf7yBkFVqg8QAVsfrjtNq3FU5Sl9Sxc/t?=
 =?us-ascii?Q?5QaqelNZOV8u9MsKT1a/HvyJ1BgUtuVGfwSAcCKxxI/3XqbMAPxyo0wEFcgf?=
 =?us-ascii?Q?LIEt6MKfPjILoSO6Fdnh7qN6UtjNyE1HkYvGaxmQSXj4jgoPgo89UI4Kd2Wg?=
 =?us-ascii?Q?HUflvGmtHHnzSYW8J8lQ/PC1gJTwTqJ5tlopnfSW9c00fS/gujvXT6gXqho9?=
 =?us-ascii?Q?WH8evFqklb+6ZNHb3SgNVGBG/oXJeTxDVWQpD6IkQL1fDIhynpf8nRyhIw1f?=
 =?us-ascii?Q?MoearnJ3BtiRvVsSci1kicDltR2H4ga4bg1ZqvYRHKdgErZyLkZ4Zcd5IotP?=
 =?us-ascii?Q?OY/Y8gaXfI3WkZjAE3Xuv58XkS7s9MLS9hqdewFUvDjLDEOXRC03oHWzfUDZ?=
 =?us-ascii?Q?CxTPgqK6jaU7HNTMf2ksRlpEjbMpuFouSx5d5Be7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70874cc6-d93e-4009-dae4-08de38e555e9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 18:44:37.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3E4HmKW+E9X8TnHG+gKiW8nkAo8NL5OG45EVO+OQ10Mkpx7xDTbQUO+V8xtPptIHPCujhE7VW+GFjUwiQD0BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 09:02:50PM +0800, Shuai Xue wrote:
> This patch series improves the performance of GHES error notification handlers
> (NMI and SEA) by optimizing how they check for active error conditions.
> 
> Currently, both ghes_notify_nmi() and ghes_notify_sea() perform expensive
> operations on each invocation to determine if there are actual error records
> to process. This includes mapping/unmapping physical addresses and accessing
> hardware registers, which causes significant overhead especially on systems
> with many cores.
> 
> The optimizations introduced in this series:
> 1. Pre-map error status registers during initialization
> 2. Directly check for active errors using mapped virtual addresses
> 3. Extract common functionality into reusable helper functions
> 4. Apply the same optimization to both NMI and SEA handlers
> 
> These changes significantly reduce the overhead of error checking:
> - NMI handler: From ~15,000 TSC cycles to ~900 cycles
> - SEA handler: From 8,138.3 ns to a much faster check
> 
> The initial idea for this optimization came from Tony Luck [1], who identified
> and implemented the approach for the NMI handler. This series extends the
> same concept to the SEA handler and refactors common code into shared helpers.
> 
> Patch 1 (Tony Luck): Improves ghes_notify_nmi() status check by pre-mapping
>                      error status registers and avoiding repeated mappings.
> 
> Patch 2 (Shuai Xue): Extracts common helper functions for error status handling
>                      to eliminate code duplication.
> 
> Patch 3 (Shuai Xue): Applies the same optimization to ghes_notify_sea() to improve
>                      ARMv8 system performance.
> 
> https://lore.kernel.org/lkml/20251103230547.8715-1-tony.luck@intel.com/

Thanks for the improvements to extend coverage to SEA.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

