Return-Path: <linux-acpi+bounces-19495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C5CADF94
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6038930153AE
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA82820AC;
	Mon,  8 Dec 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnE+34Yb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831D281358;
	Mon,  8 Dec 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218100; cv=fail; b=Abmrzc8/WLsCHsC5E9N3TS1ZeI8JGg+HOsaW3ImgcEpzBMyqh527aO+IXvtwt+/cTY88cktKK+OtjSvWbZgv81hN1vARhsH0TjrQMKdZA7VR7xLwRivAT3XrD479t7tZyg4FTSypRNR1j1svuDwwbbqCMkS6L8vj7LIVAxRG7HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218100; c=relaxed/simple;
	bh=cdFZVa06BHM2UF6cdLYkpHkWw1yf8kVOr0YmWfTcrck=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UCgJbddA6egGRSV+IVJmCQ81eaK0g+EcVDodHRTIrwhPcULupd4HJcZB+qo/MvjlkVbEj1TWZ2QkEkLJfzs/8rAi0NdkJG9OOe/wLdXSkWvildx3wvCyv8vS386EWe4WCJ4GoRGAW2huwrUpsl1Pl28ekFqbE6I9+95nCl5KtWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnE+34Yb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765218099; x=1796754099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cdFZVa06BHM2UF6cdLYkpHkWw1yf8kVOr0YmWfTcrck=;
  b=DnE+34YbaF+QijE1WXqSPZc8M+FuxnwxzNw1sdnh5R2Bs1qlWeCVs3lF
   XFKTGc6QhriamPdl0Jf8T27PdpXWvs31wigSsgVOz/R8U85I5LoOU9HN/
   IWUy+evy+xxaqUh9oAvTNeIlj+r2XPsgm1HunFaGbocGaQiLQ+DJgFS53
   l4bj/y+KvQ7mi0/2UMEid6WlPSD8Vv7xgvZRLKLJMDzgZLhTWEhykBn6F
   iFmD2pmbnPPGFB2U1J55PmBpLk1czIHlK+enla0C7NoRuRK8luHtsSjuQ
   0T7CqKg0a7TWVoNSkaSG3bNW3CAhowIEFYph0r+dVyKU4wpmy4NbNwdLh
   Q==;
X-CSE-ConnectionGUID: VmhA906YTriyYIyssA5HQw==
X-CSE-MsgGUID: oF0yJcOQSxaKhxR8UQbOVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67129014"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="67129014"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 10:21:38 -0800
X-CSE-ConnectionGUID: z+RFCdsOS7qxvlyqSahQcg==
X-CSE-MsgGUID: I6CXBmr9R5iO+DYdt/PgDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="201122547"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 10:21:38 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 10:21:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 10:21:37 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 10:21:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urpp+Xgk3bMWiLbLAXbhmNYdzV7lRt2aEMu3wGmnVw7Gr9mn+k4uPvH4GPRAZaJPy02o+2Tn8zUasRqdbz4KlWIEuFviCUu8dB0Zj7eha36xixdcPQTnKQ0Bb1khL2nN3GZ2V2Nh/92QUHvyMQKkFEsYszKY7a51OuDYOYS5P+67PBjYpOFCpiNoIoavvRyq1anisKD9zKtnIDOwYTuAtD7gTVXU+Qk2EIiGtyrhFmZ2XUY9v+GvcNAa7TuSdtXIPAZ3eqUu92mIjHs38KGo90tA7Y2OoA3eiPxHVatcai/NhS6JR909bdaYr6ifqAAWGg6QW7o6RTkLxbf1zYkpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boJouvugRUMfaSJmuU6IrhSK3SKembRCJvfb7QZDbjg=;
 b=LvTUnW0UMSWgGtW7i7qnXDBwAD+uY9Er+RhxF3jnQEaqf9CFr25trCl8zqVGN66ByO5WqmPMjE91XEZuu8kjsVADPkrAGNvwh3s6v3q0uQg2PDYnDGYbBBkevNA9D6pxp9VhOzBhdv079+tYLFNusyZCr82zrfoNyMirJhFBekG6LPb5bHMpOlpvizJRpUnX+alr9AzZyJnsqvj81Wo07H1rOgoIret8QiV7D7KQzf8b1ya6tL8LG6WDAt3mbHmGve8ENSsdGRUEn4mgRiHaVh5TIp++ir6jwzo5ubxzQ65lNXjn8b/SBaBxLbA04B6lABwQIDvyuWhBgYg4lr7mOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7732.namprd11.prod.outlook.com (2603:10b6:930:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 18:21:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 18:21:32 +0000
Message-ID: <f5095a4c-4617-441f-95af-9255cefdcf98@intel.com>
Date: Mon, 8 Dec 2025 10:21:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
CC: James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
	<amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<guohanjun@huawei.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
References: <20251119122305.302149-1-ben.horgan@arm.com>
 <877bvfa23i.fsf@stealth> <a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com>
 <87sedrlsjk.fsf@stealth> <642767c9-f926-490a-83a1-160978c37553@arm.com>
 <871pl9krdz.fsf@stealth> <5261337c-337d-44ca-aff1-0a927b81e593@intel.com>
 <87tsy0kgwy.fsf@stealth>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <87tsy0kgwy.fsf@stealth>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: dc44b4f0-1f99-45a1-4bf6-08de36869d58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1NWcDJyT0pVeUwycExER1U3K2YvaHo5em5qUzFnbXYzL1U1OThmdmVRT1Zz?=
 =?utf-8?B?R3plSDFtMnNRVDA2UEViZVhsY1NNMnpsZGthSmRsdXBQeEJZekxQSGZVTHJl?=
 =?utf-8?B?enZ0ZWFRNzhyOHdwTDZpT2VyL1FpaDh2N3podVVUWVRCN3RIdEg5UnAxUzFi?=
 =?utf-8?B?WUxzbk5pSEdmL3JQMmgzV1N5ckdDSmc1aDhkVENydms1cFpXb1J2MElpNDlM?=
 =?utf-8?B?K3BzMXNxcEFjQnRwb2JpcUtqZTkrRVE1cEZRcWhLUmlYL2Z6SUUrZGJOVzBE?=
 =?utf-8?B?cGN2MFlXMVBodjd2eEJDbWVDWVcrTVlMTEFoTEdLYW1pU3hRRUpLZlN2bUtu?=
 =?utf-8?B?M245RThIUGs5S0xMUDlKVTZKK2FBa1NWVkphOExHSFF4SWV5VVNJMEpQQmhn?=
 =?utf-8?B?OVVIYWRkeUdkOUFSV1A4a2hTbHNZSG5CSUNrU0l3Y29ORzN4aXdMMVJJMzJ2?=
 =?utf-8?B?bGtab0toUGM1dnl0ZEU5OVlKVERpWkEvZi9LYVF1NTU2Wm5RMUsyRThSS082?=
 =?utf-8?B?Yk5oREhEVUErS1lnUGg2SWVWVXQvQVRBUVdzVlhpVy80Z00vYUh6Mk9sQVdU?=
 =?utf-8?B?eE1XNnhDeTRNc0Z1NHhNbno5OS9BcTY5NW15cFlnVVYxODR6UEZjWkMySWEx?=
 =?utf-8?B?UnZueXlaUVJFenNHMXk4YXpUODBCNzcwbElnNDM4MjVxTUo4Qk55RDdwL1l0?=
 =?utf-8?B?U0llWWVUVGxzNDFPdDZBZ2p0WlFlNlJRZGMrSkJsRHIwSjB0MU56VGh4bmpl?=
 =?utf-8?B?U0RsK1JIeFpLM2dReEJPVUU4YkNwa1FKTndrNVp2TlNxSTdDNnNYWVVVb3A1?=
 =?utf-8?B?ajRORnZMVVFCR0FTczZYV1VuL28reHpyaDZwbmZsOXdycnZuMm1kOElpUG10?=
 =?utf-8?B?S3E5eE8yTWpJaW9VaTRwWUJGSlJCOExrVVBaTlh6WW5BRkRiWnRmTXVCa005?=
 =?utf-8?B?eFRtdTIxbHRQaGNVTXFET3RUWkhGcDRjY2F6ZmZQcnlkUExIM0JjK01Sc3Rt?=
 =?utf-8?B?YVM2VE1TQzdSVVdpMGV2ZzZnWDBZN0kxUE1URnJOTFlnVVlDd3FwM0NjdDk3?=
 =?utf-8?B?Wk56YVA4T1Q4Z3E1T2pNaGxjZjREL1lEaU1wd2VweW1LK1ZjZmhCbU5VMVNp?=
 =?utf-8?B?VzJDZlJmY2xBbmFkbzF4eHY1eXdSa1NIcmhUWGYwT3I2L01rQ2ZkY0ViUEJF?=
 =?utf-8?B?SEFOSi9pbmtzazNzenZxL2xGMGhnMGNIQ1FPdjlNNUdPei8wYjM2M25VSG1F?=
 =?utf-8?B?ZDBlRzQ4MmREYUMxZWJuc3JNMVVyYmxOYTNxdXg3RkpHOExEQ1IzRlRJL3lU?=
 =?utf-8?B?YXRVU1NiWXFvWFZJYmNqWkhsRzg1SjBPRHNwcGhFNGVBNlFiYXpRVk9XallR?=
 =?utf-8?B?MmtWdWtWaCtJeSs5UW44VDR5anJKTXY4QzBFQTQyT29nYUVhbmxSL2FuT0xz?=
 =?utf-8?B?VkQySk5STmJmOHhoY0I0ZTdIWDhQK1g0ZnNQRmZ5UU54am9MQUhObnN4OW1P?=
 =?utf-8?B?TzhCWk4ySWhobFJHaWkyS0dwWDEyNEdUVjNwWHpYN3N5NkFQakE2ZzJBTUZr?=
 =?utf-8?B?Qi9MejNTM3MvZUpDTmNGNUNhSE9LTGswOWN0M0twbUhvRUhlLzVlMHRhbUdS?=
 =?utf-8?B?dEIzRXBOWkljVXpFQmltU2dDVkVva3FxZlYwQm42cU5MUGUvY1lUaWQraHBH?=
 =?utf-8?B?MnFHYmNpWkRHMVg5SE9SWGxJalBKb2I5U3c0RUVnTWZVNW9RYlY3MlpubUdW?=
 =?utf-8?B?bmVRZGtBbnpvTHVtL0Y2TVIyR2hQS1JtaHh5UDlsZ0pTL2pnOEtVYWVLVEFK?=
 =?utf-8?B?d0lTLzdHbkllSFlZSWtTU2dKYzZsUWZEY0xuWitWbC96S2hkYjZGWGlOanFS?=
 =?utf-8?B?SVhVcG40TERsaHlRTVhXWVlGekhGd3ltK3gxVjdiektPaGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJxcUpvN28wNFMxRjRpRUNLQm9CRElJUDlJM2M4T3NHejVORzNJaW9keDVr?=
 =?utf-8?B?RFN6QTBLc0llTHhLRktyQlB2ZjFnWkJBWTN5RkpSZTc4U1Z2TElSVkpkUHZn?=
 =?utf-8?B?bnE5QXJncWdaWVVKdU9CMWMzdy9sQmtEZjNCSE9Ud29FVStSaFROdGVXSGdi?=
 =?utf-8?B?TmFmMTVxOU9IMTB2aXBsRXRzSWx6TmIyM0RWUXJtUWRyVDNFQWVUTUVYZ0lP?=
 =?utf-8?B?SkdiS2FjNGN3REd0TTVidU9vcnIyakVDM0toT3lIY2N4NitQRm5XeVIvNFdH?=
 =?utf-8?B?YkgvdXU2OGdBeXVXeEZsZ1J5NHpBRFJta0MyZUxJRzZTVXpPaXFCem1wWnRp?=
 =?utf-8?B?WUNQbVg4WEd5MzdnRmtwcUVheWMwL0w2R1dxK0dtd1dxQ2djZ3N5WjNNaE1h?=
 =?utf-8?B?R2dNako4WU1iSVJFdCtOYXIyMko5bzA0Nit4L1dzTjRCQmNYdDhBNGhhZmxT?=
 =?utf-8?B?SmdVaG0rcmxNOHZ5UVdqdG1GR0s0bElURklTUTZsQldOMGx1aHRuY2F3dyth?=
 =?utf-8?B?RDhOdmE0ditZbndoN3JTdW14N01jWXdrbG1ZK2FkWFJjYi9VaTkwQjBtWG1j?=
 =?utf-8?B?dWRoL1NOMittZ0J1aWR3Wm1pTEQyRVBRMjVRNDloRFNZSUJpWVVreUlocFp1?=
 =?utf-8?B?bmh6b0t2RmVZelQ4azFlS1YvM0VmUnlQQ2tTN0ZTY1pTMlBWdE9SRWMySGZQ?=
 =?utf-8?B?bStFeVNQT3lwYkZ5K2N3cHBidnpJajlmcVdydUU5cW10NGpKL1cyQnBjREl0?=
 =?utf-8?B?Z3RBVnY0b3M5VVllYTRJdXZnR1RVdS9Ia1BUQ3AraWhDZjZwL0dqcGFwMmlr?=
 =?utf-8?B?eXVNRnl2ek9vd2liZTcwUFhHTDVwc241ZXlxY2tUQmhoSkkvY0grVXY2azVY?=
 =?utf-8?B?VXUzeWdDUHRMT1lxeWliK09KZ3ZUMG1ubVBsQ0tMbHlvVm5GL05pM1ZvK1No?=
 =?utf-8?B?NTYxTk1kdEtoVFQ3K1VwbW1kVnhXTUdBSHljNVVrK0o4TzVVOUNoSisxWUFC?=
 =?utf-8?B?Z3lJMEUrQXcwdXBUdkppbzU3S0EvQ3h3MWdvdkVrYW0weXlleHVFSFB0b1pk?=
 =?utf-8?B?aFpOcWlCZ0t3Zmk4a2lyY2o3TXNFak1pOEVEQ29UdHVrb3k3UTQrUjQwZEJS?=
 =?utf-8?B?ZEVxNmttdkVoYVNIMDI3QVRPdnB5VURwVEErdXVEeWUxbEhQZW9nSkN5VFpu?=
 =?utf-8?B?NUxLUGVNU2ZCa1M2SWVnV21LUDBEUkQxNW1jQnVsa1JLWUttTXhKL2MzNG8y?=
 =?utf-8?B?RURDL3BBTm54d3ZSTE9CYXdCeVRLRkVQRWVMb0NITUUvOXYveG1ScTBLYktr?=
 =?utf-8?B?SlIwNjhvUFphQXBYOU9jV0FndmNDaW1GOFpRcU9aZFVEeS9YRVFjQ1N2VU9v?=
 =?utf-8?B?QkZyN1JwZXhITGJhUEZZL05Ud2hDQU9NeTdNN1UrRG5KUm83TVVkQWFHYWp1?=
 =?utf-8?B?QnQxdDV3OUlId1VWRE9VYjY3WVNxakhFTkVVUi9CeWphVThDeVZaUG9JVlZ6?=
 =?utf-8?B?MStTaTVRY2J2L1VwSmxZL25QOCtSSkE3eWVJQm83SU92WXhxNGQrK1o5dlNJ?=
 =?utf-8?B?RS9qK3B2aWEvMjJNekFqaHB1WUhjS2tYZHZJczdFOFA5aWxoRW1QaVRRTEk1?=
 =?utf-8?B?Nno5VUE5SW5ZelVsM21IcnRvOW5DVlczaWpyQjd3UWFlM2hUSG95Tis1ellK?=
 =?utf-8?B?MHBScC9HYytUY2xobWxBMWtvV3d3MThFMklVVGIrR0EvN1hVT2cwUzQ2K2F0?=
 =?utf-8?B?cno4Q2JGT2NYRjlheVFwYzdJSFNCYjBQcGs3UWplTTF0VkZ3eUpPUldxTTRt?=
 =?utf-8?B?dkgvSzAwSUoySHpicGRLbnUvR3JpYkp6TkJHUEV6TmprNXVGZzdKa0VhREpp?=
 =?utf-8?B?TDNaZE1DL2ZkR25QMzdvamNLQUdQUHVxbENXVXNBQWRMUXRuTFhJNkpNdHY0?=
 =?utf-8?B?ZHlpVkZrYnR3S2EzVXlZWEJtZzdJU2FMbCt1ZlRKSVRIaTlvZk9ubTdSZThO?=
 =?utf-8?B?aWU3WHhDSDF3NVJjb1pUYkFTdUZzSGxVc1NoSExVMlQzT3FpNzV6UFEyTCt6?=
 =?utf-8?B?T1FCVTIvL3RqRVZud3VxNHlDRFVsTTVtZlhmNUR1eEE0YVZjaUxCVWFZYTFR?=
 =?utf-8?B?K0kzaWpoRTlYaU5TV1FsY0tzeXhwSHYza2dqdEJYbW5nZ2dDZFFyNUphTWdG?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc44b4f0-1f99-45a1-4bf6-08de36869d58
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 18:21:32.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ac1qgaD41apRexUyN1n1pqd58tjE/ou9TZAfvJyZqo9KK1HKe2qSbHIzbbiKUx9ZQfjtXLpDcdd7DPhoVomarj2Rz5hdDIhcU31ipcqIF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7732
X-OriginatorOrg: intel.com

Hi Punit,

On 12/8/25 9:43 AM, Punit Agrawal wrote:
> Hi Reinette,
> 
> Reinette Chatre <reinette.chatre@intel.com> writes:
> 
>> Hi Punit,
>>
>> On 12/5/25 5:08 AM, Punit Agrawal wrote:
>>> James Morse <james.morse@arm.com> writes:
>>>> On 03/12/2025 11:21, Punit Agrawal wrote:
>>>>> Ben Horgan <ben.horgan@arm.com> writes:
>>>>>> On 11/24/25 15:21, Punit Agrawal wrote:
>>
>>>>>>> The platform has MSCs attached
>>>>>>> to shared L2 caches which are being skipped during later stages of
>>>>>>> initialisation. IIUC, the L2 MSCs' limitations stems from the
>>>>>>> assumptions in the resctrl interface.
>>>>>>
>>>>>> What in particualar is being skipped?
>>>>
>>>>> The registration of the discovered MSCs with resctrl and subsequent
>>>>> exposing it to the user.
>>>>
>>>> resctrl's 'L2' support is limited to the CPOR bitmap.
>>>> If you have controls, there is no resctrl 'event' that can exposed them.
>>>> (the problem being they all have 'L3' in the name!)
>>>
>>>>>>> I was wondering if there are any patches available to relax these
>>>>>>> limitations?
>>>
>>>> Knowing which property it is will help - but some of these things are checked
>>>> to match resctrl's ABI. They can't necessarily be relaxed without breaking
>>>> user-space.
>>>
>>> This platform has portion, capacity and priority partitioning, as well
>>> as memory bandwidth and cache storage monitoring. The MPAM code seems to
>>> correctly parse the properties.
>>>
>>> But as you point out, the resctrl 'L2' support doesn't have anything
>>> other than CPOR bitmap yet. Have you looked at what's needed to extend
>>> resctrl to support some of the others?
>>
>> Please see [1] for a summary of ideas on how resctrl can support multiple
>> controls. Nothing is final, please do add your ideas and requirements.
>>
>> There are a couple of opens not included in the summary. If interested
>> [2] is where a lot of discussion happened that prompted the need for
>> a summary.
> 
> Thanks a lot for the pointers.
> 
> Let me catch up with what's already discussed and raise any points that
> are not clear / need refining.

Please do. There are already a few known open issues. I plan to raise awareness
of these discussions (and the (so far known) sticky points still left to resolve) during
the resctrl session at LPC:
https://lpc.events/event/19/contributions/2093/

I am attending LPC remotely though so I hope increased awareness will result in more traffic
to [1] to help us get this right.

Reinette


> 
>>
>> Reinette
>>
>> [1] https://lore.kernel.org/lkml/aPtfMFfLV1l%2FRB0L@e133380.arm.com/
>> [2] https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/


