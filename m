Return-Path: <linux-acpi+bounces-19451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF00CA90B1
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17E0B303BCD6
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0895362A8A;
	Fri,  5 Dec 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8et2BFC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA42350D77;
	Fri,  5 Dec 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961903; cv=fail; b=RNz2Q4lDENui+bGdQm6CbYBVmuNnEIh4S+y4jKwS3ri4aGL3K/ShBHNX6dJqIiuZqHyCb7aWfe87+xnNsGtToJEqcr0/8sx/Mckl7+AA7wNTxHSML/TbcXWb39IxsuU6U8D/Q74BEFOsFzhz6QFw2xP8ETSyWH+oaYYDry2jSkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961903; c=relaxed/simple;
	bh=dUyanCk5c7fMmIlqEEUpUookLpUxMKIjhZH4yeI3dCY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oMO3LGXShPLVWR7j+H+VSgLplcOCSASbHZKMENvII+BOBDCahTg2JHuRB5rUdck/K6Bc98VPiHaFeuoZsNeuLNuIxzC6bSF0l9pCmPSMXZ0qNVUQeA+MXZqRIztnY4Rz5l++oWhU0IF+kMoCY1WmXsAR7YzgIgZ7vWer5tFGi44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8et2BFC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764961903; x=1796497903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dUyanCk5c7fMmIlqEEUpUookLpUxMKIjhZH4yeI3dCY=;
  b=T8et2BFCJxrcNRtRQNDISJOzqmDixa4jVsvqrYG0qSkrhE1uiMs8GDf6
   pxFLZVjLJDq9Ob9eBwWPoc4n+TmPFxzKDWCRP2io70UPiRoUiquUp7+YT
   q3dtenMmP4CMO8OYbOypNDoaMNIqaCkmax2vWElef58lbNn0jMa+guQSh
   er7RSPf8KxxN7wVCJabGlVW3glEeudBvjjjetahPoHn6KjtzAXqAEwUHQ
   usM4qrkJ/N4sxKGsu9omccxg7+CHYM1qZ+Rmp67ljdxIZ5i4Nu6cC6Xef
   zetZgT3D7s3yf71EZOLme7S1YyGNyynGjdFz6qPRRWTYeE6PYh3MSxURE
   g==;
X-CSE-ConnectionGUID: CnJXMBuZQbWhLnWsfC9BZg==
X-CSE-MsgGUID: OtpGe7gNQgW7YYZZrxED0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="89654007"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="89654007"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:11:42 -0800
X-CSE-ConnectionGUID: qEONZ4bbTAODgs9FKZ0klQ==
X-CSE-MsgGUID: HME1M3v8Q0GQ6LRVhMUt+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="195184655"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:11:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 11:11:41 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 11:11:41 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 11:11:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAgfPTD6kDGKk69aXwnVQi9DiwoJI3DKPK7VXPaKoMYDE0nQnrK/x4J0OPPz3doQMA55QHaIQvaUqhc57ptLNsHAROqBTOyIRz8TaeA+nxlJtuDIow1J7eag6Eikel9C90+feK1OUxeS0k0O1gtUVCl1YlErKTP4BziNayIwtn44+haBzGHjW+ozh8dR+xh6AtV/kh8WRPiUilSBISeAL0bdQ7t1xd0PYIiONZwVGgEUhGbxj18htVR9q6TXFxbczR43X3fx9Y0BlhyzAt5MaDlH/qon7ub62WiiEpEDkFenoLynczOZGMHyBL7Ub4tSEPTVQ4cMbLj8LfmGNjC/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnrEmfzaflmAhg8DB3cb/gb+MFDEhCTzRV1TIwCp7WU=;
 b=yD7ag28wGpYZEOoYvMHreP5mwpIKAK14ZzseGQB/ptci3pLZrbz6UA5Cf1oBKz5odoov5rpE7N6rDUNUOlhYj1wkZKfehg4/HzlHC19cYN9SHpvZTru3noz6kNnYlMlkYB/PG0BqE/ZUIgMiVM8qOc87YxWGYXDvm6x548sk7Ufmb4WCMjwIBByuo1tR3K3usQyXOJSZcTDVZLidC62hV4gXLtymJBF9PmHwxSu3uZOn86gFulKiJcwt5Epnpso63Lsb0YxIX0jCfNbqJGglpYyvEINcezli6zxw+uEpQX0T2zaIQh5jw8/aWXatp6RrZgswj0/fJ/3xkw9Mnz1/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8871.namprd11.prod.outlook.com (2603:10b6:208:5a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 19:11:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 19:11:38 +0000
Message-ID: <5261337c-337d-44ca-aff1-0a927b81e593@intel.com>
Date: Fri, 5 Dec 2025 11:11:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>, James Morse
	<james.morse@arm.com>
CC: Ben Horgan <ben.horgan@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <jonathan.cameron@huawei.com>, <kobak@nvidia.com>,
	<lcherian@marvell.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
References: <20251119122305.302149-1-ben.horgan@arm.com>
 <877bvfa23i.fsf@stealth> <a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com>
 <87sedrlsjk.fsf@stealth> <642767c9-f926-490a-83a1-160978c37553@arm.com>
 <871pl9krdz.fsf@stealth>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <871pl9krdz.fsf@stealth>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9d7984-f788-475d-b5b4-08de34321d72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUxPT0lmbUtPbVRicU5TcVpmOW1FbXFObGM4Wmk0NURWNWRieTZmMHBzSWVD?=
 =?utf-8?B?M0N6dVB0RWZpUFlTRzdObTZSNVFXTkZJek43VkRYekxrS09WRHo0aG1oVEtk?=
 =?utf-8?B?K1MzbVc0aTFjSDB5VFFoSXhySXFMQTVQOFFkdzhZZEdvem1iMWJrM3k4dW5L?=
 =?utf-8?B?UjRDdHVZRGNmb3Bvell1WExqYUMvRnQxOGxXQzJnS0hoREEvUnUzL0xic1pQ?=
 =?utf-8?B?YVlYeDlBcFFpNEYzUWhTZ3JVTjdqUnhNajkrUzkvL2xPV2NSdm9CWFRWcGhJ?=
 =?utf-8?B?ZEtyaDNYOElLTmJrai9ocEY0U3liT3hIOHhpRkdCYm8ycE9aZG5DQ0pqTHdW?=
 =?utf-8?B?aStFS3piRGVVWGc5UG9XUWsraTgwREVpcVU4Q2xzclo1V1YzWVkzUzBDUURw?=
 =?utf-8?B?SklURjQ1d0llcUt1ckxCdnBqaEVZYkFXRDZMZ09PU09sK2xiSUlxQkFLZGpj?=
 =?utf-8?B?N3lJZFEzekhjNFg0TU14TUN5eWdGSGpnakl5ZzFaemFkaEZ1NjA1MW01aUg2?=
 =?utf-8?B?emErSGpyNGFNWnBnZ3BxWldSTFQ5YTlqeVRkZldlT2tKQzRVYnk4Um9aMkdt?=
 =?utf-8?B?a2QreXdubnFVd01kWWpxVnNHMDk4VHlRNkh2YmZ5U2xqTXMxMC9HR25YV3dY?=
 =?utf-8?B?Q245YVJWMy92RmVRMXNuYSt5VXdBNVNWdFlwbjkxYTN0MWYwbkxPbHozb3VD?=
 =?utf-8?B?NmlaQUxrUHNreW43ZmhXTWN4M1NWQ2VzVWZIVzBPb0tjWko4elZ1a1NwQXRL?=
 =?utf-8?B?OFM0K01XRktnL0NUWVU4cGdVRUlHM2FmOEQxYk9Va21mNDN3enNjK0ZKWWkx?=
 =?utf-8?B?d0x1VlFnTlJ1Y2djSEtLajBUUHQ5R3FWN0hERVA1dE0wR0pHeHdSOUdLckZF?=
 =?utf-8?B?OWVCUytjOXJIdDhRN1E4UkhyenhSMzNaZUpIeXY4Sk0vN1ZHWDlVOHlYRkRm?=
 =?utf-8?B?cW9sVDBqdHJ4TDRqc2ptUmNDNXpYaW9Db2VzLzIwMUd0VGVjbGFRWVcybHVW?=
 =?utf-8?B?Y1pRQzkraVg1RTdnZHQ4NnhiVW81WlhaTVdJMTcvWEZwenJYaFdqMUpDc0FF?=
 =?utf-8?B?R1VTTUV4QmhOVlBMSW16SU4rUEFXOU42SUJuUE53TzU5SHU5REJIL05jek44?=
 =?utf-8?B?clBRMVZucVNiZXZ3N2FjRlloUmo5M1lsQUpLaDJMc2IrZklwVlprZ3c2Ulc4?=
 =?utf-8?B?TERHVzlhaWdDMkowODNDQjAvYmlEcUJYaUFlVmQzOTBXVUplUkV2TzFEcmhQ?=
 =?utf-8?B?ekhobnQzYVlkQ3IxVVBrcTBVZUhPNVVRMFN0R0gyY21MZGhpRGkyOVR1Z0dC?=
 =?utf-8?B?VWQ5TjYvbHFCdzFDTXFmYndjQm5OT1BGeEdPcUxYMzBTSWZnZ0hnbDlLOEwr?=
 =?utf-8?B?dHZ4TndQb3hsZHQrVUlmdEJGVEdiUDVoZTZ0cmVyWEwzdlo4aDNSU2M5WHBK?=
 =?utf-8?B?U3VaeXE1QmxRTGxNM0t3TXpOYmtqdmE5S1F6My9HbVJmUlRzWUFzMDNKc3Z2?=
 =?utf-8?B?SW8vTnZLS1hQU2lWNHpyNi9MZGhKWWpIU1pEdzl1QVlRb0Y1T0YrTlhmN3Jt?=
 =?utf-8?B?cGFyQVNobnh4NERuU2xsWjkvemxpMkREZStwZHFpMFdwNDQ3MC8yMkpGd0dX?=
 =?utf-8?B?ZnFBMEFRR0E3V3dPNE1ob3lQb1Q3SE5ENmxiSVRYZ0w4WmlSN1lIaXJBTnFj?=
 =?utf-8?B?S1R2Q293OXdFMk1PMDNTWXJCV3lOQjhxeXUxbi9xK0ZHVXAybWZUbGJ0V3Rm?=
 =?utf-8?B?YmNCbzVoNGorMkxSakt2OGJTdFV2TWl4bFpucE5GSTcvR0lnYVhhbXJnTTEy?=
 =?utf-8?B?QkRXbk50YlBhbW1KT0svNm1IWUlETi9LcWZoMkQ2c2ZMVGw1NlQzTitZYk9D?=
 =?utf-8?B?WDVJcytuWnpLRHFic1F1RVF0a2ZDSTA0eVF3R1hhOWs4ZnJyN3M3bEh3LzVM?=
 =?utf-8?B?UmNqY2Q2V1NLM3dnRHlnZ1VsWTBlRE5wWVRMalZvd045Zm9RSDVUZWRuanJw?=
 =?utf-8?B?VlRsd0xlT0RnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2dtcHlCcCtNU0k1U2NhQmREd0pOMDBGalU5SmVuNFVrL1VVU2hJaEpKZE5S?=
 =?utf-8?B?NXZ5TlVESVNXV0JVVHZpUytXNmRwamFXblppelIyRlZTQ0MrVXNQbW5pa1Av?=
 =?utf-8?B?ZGN2WmVlNkdHME9vd0pkK2VaU3J4S1V2am41YmZuaXlYTFg1VENIS1EzY0pn?=
 =?utf-8?B?eEh0dVdsMk1JQVpOQ1ExeUNVc1VPU2RwM1VwUE0yQXNZeWJlZHI0UWhic0hr?=
 =?utf-8?B?UFBiZndaMjBzc1NSS01rVmRCYzVwekFGcXF6U2tVOTdzRmdubEhXRzBiOTM2?=
 =?utf-8?B?U1YycUhTbFJyUm9DQlJHSlU2SlczZTYvcHNpUXdldVR4MjBVS0Z0QWFpU2VF?=
 =?utf-8?B?Vm41ZVVxL1hkRlg5eFFFaGs2ekZkcjVJTk03bnVONGRtb09hUzBQR0lDN3Bi?=
 =?utf-8?B?dk1KWjJkcW9KckJORnNRUFlJMzhESi9mSkp4dlNwSXBtRG5tcWVvSlpLQVpO?=
 =?utf-8?B?UFlQUHZGVzFxc0dMTzhBSUx1TTZPQUtIclVReFhwZ3pNU2pTMzdSblJnV3lm?=
 =?utf-8?B?WnA1azgycVhRb0hSVG1RcUZMb042RytHbk40QzE0ak1TMTk0R2NPRUtSTkNM?=
 =?utf-8?B?UURrNTF1cjdZaTdBQ2pTL2FjSWl6aUIrazlzK1lZQnR3K0srZVRzaHQzWjZN?=
 =?utf-8?B?VHBLdi9EN21KeVF5YUh2UW80YUJmNDdPNEFmY3VFSGtTS0lDOE9oZUM0aGhj?=
 =?utf-8?B?UldWWXJXUDFsNjJPT0NuWWx0dEpiN2x6SUJqOFBLM090L3N1c0pvdmdHRW9h?=
 =?utf-8?B?c2VGZURWalRHZ0J2NFNSbm1rMm1GU1FwakhnSXV1RlJsTlQ0S0dFazdKTXJU?=
 =?utf-8?B?bUViRHNSN3pseTBLNnFpa3hDR2RoNEsvRTVJUGhOU1ZUaWlhN253SjlweUhK?=
 =?utf-8?B?dWRMcUlhZk1vSmM3dEpDbVhuQ0lOQklMOFY2dDNLeEd4SDBSemJWTk1NQXAr?=
 =?utf-8?B?RWNOWHFDV0w3TDlLVVBSOFFlemNRVERBYUs1czlzeEZlQUoxQmNNdmZXQWpB?=
 =?utf-8?B?bW5Zb3daSnR0RmczUUthWC9VNjVJa3NDUmx0aEJYWGdGN2ZHOHlQR05QbTlG?=
 =?utf-8?B?WW8zU2xtUC9sTFdVQXJlTkUwRVRUQmZVQlNwOE5idXRSR3ltM2xYU0Y2akQz?=
 =?utf-8?B?ajBJTG80eTJVaEhFTlptdzhMMUNMMUUvaDEzRitVWGUwNXNna3NKWDhiOFVo?=
 =?utf-8?B?MzdmOHBETUwvWEQ0cDZFYVZKS2R2c1l5UW50T1FmWStmZVBZQVp4S2NLTUVI?=
 =?utf-8?B?d1JmTys0Y2MxcWVacklPbnhOcWJVWDlrcGYzRFVac0ZqUnFWR09WMHNOTlJD?=
 =?utf-8?B?bjlZMmt6cVJtQkQ0WGJLa092eHd3SkIyZnNGRmJCYXd2eE1oOUEwMkl2RWdR?=
 =?utf-8?B?ZjdnY3Nac0dqZW1nNE9XdXY5Z2RBdzRSdXNKajhmQ1VoLzNHZ3BRS2Z2Sjgz?=
 =?utf-8?B?N2xlakZXcmxzbFBhRlcxNkFCcWlubVk2em1pNHV2UmdKM2pBV0YvRWsvQXlH?=
 =?utf-8?B?RXhEd213OWUvZ1QrNTVpRzFVMlF0SFdLeE9rSFpmOElEc1JqNDMwMEZ6bS84?=
 =?utf-8?B?NUdQSDkxV1I4RWp2eVlOTkVPM0RNUTBDQnN0MzZMbmhOTUtsbk80R1lPUy9i?=
 =?utf-8?B?VjR5alBJK3pjV3BONm53MnA4LytyVlJLOUpOZng5N3JubHFzNnhWTHRydDJw?=
 =?utf-8?B?RXhxMjhCYThQbWxLcFJXWVM5M1RWRUNCWWVVVmhVN1NKbWo3UnFWcm56c3p1?=
 =?utf-8?B?Y01TMGdJaEpjNmtBSnFoTm0zWmxxVHBiSURQaVJjQ21WMGdEWFp6M0RLQXE0?=
 =?utf-8?B?TkFHT01JbU9IaXkvT1Z4SlpkR0VMNTR2SEgxUEQ4WDFNUFV0RDV3dFV2YVZS?=
 =?utf-8?B?akRnZ09ZaC9NdkQ1aXdiaFdzM2xKQWIzV1o2R1VxNHJudnJONXc4dlF3bVhq?=
 =?utf-8?B?bFo3cHBoYkxhaDIvcVo0VUdQR1FVandlTjNGOXdVSkx4WHpaYjZhZnZQNWFG?=
 =?utf-8?B?NjNFcEtXem5wS0wxa085TG1aZ3E3aFVXYkx4WE5JQjJuTWM5bHJRVGZFL3c5?=
 =?utf-8?B?QVZ1d2kybnRhQjgzOHBrRHduU3gyWVpNUllyQnVnTEJsM3MzY3lUSkF0dVBu?=
 =?utf-8?B?N0ZQTDdxVlo3dmZ3eFFIdWMwaCtrUDZWNHdQVWhNZHNZc3hQL25EaktGcHZr?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9d7984-f788-475d-b5b4-08de34321d72
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 19:11:38.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKkBExHdsYOfgokz69Hvj+uYR/r0adJJEqUXB34xii93MJ78sU0CA/JRAM4u4ASN5e36yinofzI1J/E/s1lsVx8khf5NqTU3W64DDY8X1Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8871
X-OriginatorOrg: intel.com

Hi Punit,

On 12/5/25 5:08 AM, Punit Agrawal wrote:
> James Morse <james.morse@arm.com> writes:
>> On 03/12/2025 11:21, Punit Agrawal wrote:
>>> Ben Horgan <ben.horgan@arm.com> writes:
>>>> On 11/24/25 15:21, Punit Agrawal wrote:

>>>>> The platform has MSCs attached
>>>>> to shared L2 caches which are being skipped during later stages of
>>>>> initialisation. IIUC, the L2 MSCs' limitations stems from the
>>>>> assumptions in the resctrl interface.
>>>>
>>>> What in particualar is being skipped?
>>
>>> The registration of the discovered MSCs with resctrl and subsequent
>>> exposing it to the user.
>>
>> resctrl's 'L2' support is limited to the CPOR bitmap.
>> If you have controls, there is no resctrl 'event' that can exposed them.
>> (the problem being they all have 'L3' in the name!)
> 
>>>>> I was wondering if there are any patches available to relax these
>>>>> limitations?
> 
>> Knowing which property it is will help - but some of these things are checked
>> to match resctrl's ABI. They can't necessarily be relaxed without breaking
>> user-space.
> 
> This platform has portion, capacity and priority partitioning, as well
> as memory bandwidth and cache storage monitoring. The MPAM code seems to
> correctly parse the properties.
> 
> But as you point out, the resctrl 'L2' support doesn't have anything
> other than CPOR bitmap yet. Have you looked at what's needed to extend
> resctrl to support some of the others?

Please see [1] for a summary of ideas on how resctrl can support multiple
controls. Nothing is final, please do add your ideas and requirements.

There are a couple of opens not included in the summary. If interested
[2] is where a lot of discussion happened that prompted the need for
a summary.

Reinette

[1] https://lore.kernel.org/lkml/aPtfMFfLV1l%2FRB0L@e133380.arm.com/
[2] https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/

