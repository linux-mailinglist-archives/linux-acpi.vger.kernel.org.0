Return-Path: <linux-acpi+bounces-4569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC78923B6
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Mar 2024 19:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEEB1C22274
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Mar 2024 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D646BB22;
	Fri, 29 Mar 2024 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i++wOH24"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3851DA5E
	for <linux-acpi@vger.kernel.org>; Fri, 29 Mar 2024 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738557; cv=fail; b=f+sYWYMuKBYK0A0X+pjS0P8M0FVnwashgH59ut+78NK3qwCxYWUVofJIykQcrj5sq6OQu0OqDXugNLTKteoS/dvL0v9xoylM4kMbtplTjoBZCxwqrDoENQQBdFCCfcuSCpQ5kZ06U2Xa/OrZ60PxDfYbeqi+NHrGg1iAlj2TeG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738557; c=relaxed/simple;
	bh=kL38/Wr2coQlri5GqbB7kKlAF+9GqrIYV+LECLznfpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RXgIgkDZge+fapqkIR6QtvMqKZqcgLwTwAaUjL5SqkrjqTAdSVy2z4Wtgvw+L6ecRpZNtCHSVzoHm0y8loTzQaiiOSvOThH/nDsrciHzBQ/9NP7GrJmrMBLaTVAvVnUkW2m4dk1JuCWNCwOflUWqCHPoP+yXR9lvnUwz2VbjWWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i++wOH24; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711738555; x=1743274555;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kL38/Wr2coQlri5GqbB7kKlAF+9GqrIYV+LECLznfpQ=;
  b=i++wOH24XGakDBsyJX3IYv9AqR0/jvpOxhZwkN2sjsv1iM9YVqYHWlp2
   QmWr+X56z9r0Is/RuwdTrOWnYeCkLRsKELQYJYo/C3O7qUwM7bEMNFdEz
   +OvfYe5jLeRhy+7JXjkVmgLHQjqsEw9OdBPMAbv5t9ixhkGFY/y5fqX9g
   tOG23MsNFzJgnHVNTAUkxjasGv+s885RBtKXVfugwpRpgYWTt2fSAVJkp
   0IrnpacdkOMDaykhoJhVxxpGV7huVLDV2wk0LehmGUVg5/lDE38FapCqZ
   TR0Hx/7G0PtW0DvrfJk/TCiAMy7SCVD9rwMWf5DeFw+Xn0Qb4Bp6DR8mn
   w==;
X-CSE-ConnectionGUID: iPzW9m83R0SuCxaI8KwG0g==
X-CSE-MsgGUID: uVZpjx6BTXWwRWG4iSX07g==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24427082"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24427082"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21702754"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 11:55:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 11:55:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 11:55:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 11:55:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKTz4IA5yiNEb0ngvM7ypEsrKo0K0uuE4TXW3uXOlQ6W4J/ufs4KNv4aj8p4ddsgEmb7aDkRXO0f7cdrXNUydR46nW6R1HJse0E07X4Yz1LDvvIBypwFtRU9k29laObAOsd9stgnqIsQyTdia5q98zu8dRqkUZA0bddHgZ/cOqB9uv6zSt9lsTaeiq7T4JOOcgVdqLjPannnyVrSwyhco/XK1tKQAiG57KeDey2NP7sQy26IFp33oVDTsEpRJVF6dt86Bu2J/A3JwTxBbTrQmM9Jz0xh0iR6HjI74kABWMEZYNE+cQYLKVaDcOjOkzTz6BsROha/MfjcJRzPteDdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOp5iIFxOYF1hCVvnwuH4w2Z9M05OCzm0ihl16An0QY=;
 b=jMwDx+2QSQwLBhni997Uf3Oa2AMsJA4WYA17KZMxf5JR6ffV1LLkcbYuqF/lH61DOZt+PHlBgrzDe/WoqqF/O7a1zjGrEnG0wc2GCDKq+P0TDb84+79iqj39EnWmpu33pyzdJOfXc0kXyw+Kf7y35dHT+55xwXy3GhwzbHgfRsDIMwafeeK1hbOv+M//G95TPPi4A2uSorTCB3fkWibB4vOM5q3jl0ygaKkntwZQD+nSwp8RixpCMfxR/ZkRDuMglJXiuFFvjaSUrWcDd8Wo+iLpZLf3CrQqu4pRf3eyEu2AiPb+TyOWt+TgTfJlya4VypVIEQbACESZ+Bwvl5scaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7602.namprd11.prod.outlook.com (2603:10b6:806:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 18:55:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 18:55:51 +0000
Date: Fri, 29 Mar 2024 11:55:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>
CC: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, Tony Luck
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Avadhut Naik <Avadhut.Naik@amd.com>, "Ben
 Cheatham" <Benjamin.Cheatham@amd.com>, <linux-acpi@vger.kernel.org>,
	<kernel@pengutronix.de>
Subject: Re: [PATCH] ACPI: APEI: EINJ: mark remove callback as __exit
Message-ID: <66070eb518072_4a98a294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329100203.540368-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329100203.540368-2-u.kleine-koenig@pengutronix.de>
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7602:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqttG4F5ipNN13JgPbqmQUCAcePxolSNIt9uDwP28ZBKYnFmyYkyIIloH3LDEBSCvsUOvUnqdHWaD69UMDZwCULeg/G2yLBZ6t5PEiIQXE96Hdp3CPGhbjMtEm3JKvsMv/Dn3fely3ZrSXx6uybDLFTXA92paO+F2nB25m+U2hHIoCAuM/VT2dJySRgoq0eW+zW7yo4uo245AZgSlyJf0Na7M7zBuI2FxNc48EaEWXBUx++3CSNUrCo0XzkXbBleuMvPMSMC7lPTSmtLA7G+cxpJTEVqd8+ljGUrLFUslj2n1r4NTf6LLUerPEoSSbt/xUQtBEVRveL6+CSrIZvCOcETOWNQgePIP4ggyLv4861sOlDPG85IRWFaIgIAr7ZGh0/9MKGypIuQ9guXeVX/sF7voq+FKnzAh91VXrbP3JozO/NkjH82egfQUx6216UlVkq+IYNqZrUD6ZKd+avsJULRsRyFhNdJkCtvWDRomuZEIGpjT6v4sP2tv3dAurh1rJs0A8NhEinseretRZKdL0feaHMv4P2HlM7ReJABO0UAJejS4oiCFtXveQJrp42ObdtG9DdfiFUyO14+xCmiLbSI8CxzEGAc7k7+Jtx74jpE63kptKx5zlCB7qgHa/XoH3Dy5hPRnwTNC5zUmTQlCa7GWkSZDFHXbwZtzA0W0+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eQks73jxcWGNYZrmyjPOSSsoR7pfJ/FNTFLC9v87teRffdne9dj0b6K1sm?=
 =?iso-8859-1?Q?WKr97VN9r1bF1nbcZkFi51CS4Kw5hIgmIm9vbLHgQLvtRPC46rKIMVe1+i?=
 =?iso-8859-1?Q?uSBBrfEajtgrJBGlIb5jk3ucAwXwWAjMGfonVKp8LmNVqcLYOtZJgf37Is?=
 =?iso-8859-1?Q?4+3okvL69LrXXeuSz9ELx/2D3hmeqRaALAeqfEIPOUp17+sDE4Oe4CwkvT?=
 =?iso-8859-1?Q?1C0VcW/qOvCqGIVt0PtLTP8YttWbEXVebKaBhPTNLXZZU8X668ZS9N2Dm1?=
 =?iso-8859-1?Q?cqwGGRtOTRtLchO0NEwGBC7Aw+B5jCBn/Eiv9NWyS/NyFRMGXqdd8sFsYV?=
 =?iso-8859-1?Q?hlYDL5Ny4+nVfmJtFEVEFeewfpGcq5hpvXxF3ieDfKY01Mnnhz9PgEKqMG?=
 =?iso-8859-1?Q?LkZsvK3Ol8k8M+UBWTVaKBi4Ieyzfr78A1zqMjZVeyQAH1mIiLDeeOe5Q1?=
 =?iso-8859-1?Q?jiuuAHknDvPFBG8vLDEYBmVKWBExZP36bx/dFHYbG2dWiJeEvtiL+kE3RT?=
 =?iso-8859-1?Q?iGCdRnTE8CcY9fKbp5ZwQzHBAmtSSzCWFEo3p35XwN4pYLUpXbRTBcIMT9?=
 =?iso-8859-1?Q?GERi3J0NB2xgdMn4dpc8bcM9g5P/O5d24+v65H8OkkAd0qbDlHL2lJvxJJ?=
 =?iso-8859-1?Q?//b9nWP0145fjhw2KFuc1MIdsVf1p0+S8l1C4Ml0UP4BlThAJ/iDQNCipY?=
 =?iso-8859-1?Q?9oiZyQZVz/aSmnbTHOX//Pu8dc65gcyWvAO0ST1fcU6adHFj8p81UMjuxY?=
 =?iso-8859-1?Q?z3JLJKVTZZoHiwNeQja2nQsTkwoi2ZvmHgIw4bUbH+ABYM+PbZJvlLYlQ8?=
 =?iso-8859-1?Q?Gxjn165f+nvbogflWNu6415AFZw8e/7mmxxe+WN6SqSEIgVmbvdmjnSGep?=
 =?iso-8859-1?Q?SEMgcJtSSYzCKYY5liUAl8hqTJOVF66WdbqDUpV4Z6X6UDmoSHmxb+0dke?=
 =?iso-8859-1?Q?UgMVUQlzee9vPzVyFTAoRpJpogiRRGt1Tvjvha4YEVM9m5TS+WlzdFN0Ae?=
 =?iso-8859-1?Q?gXvO6AiwXrw1zYCMsDlOTWFo9cvrop4RZlBRN2IsX7iqXr5AYxs7o7zfkP?=
 =?iso-8859-1?Q?9S8QazjVNKIo3kXSNXFt62xI3KVpBwTxJxGqmljlN4rHzPkp4rF5OoYya3?=
 =?iso-8859-1?Q?xEZAuCC6hPFVwu6DQndcYL5pRBv2VfK9zfftuBYahbnH2tdccHgbcPtgEQ?=
 =?iso-8859-1?Q?uHHKHbgQQQO/9181ZwRuAeihtdFtrfNWjB3/uk/LFJ2JDnX8ChiVsdh7ym?=
 =?iso-8859-1?Q?PxSXaOy4xdOUjDeu8iyFvOjojhtc4mH5BZq/aK0/hMNt1INlwtqrVHZeC+?=
 =?iso-8859-1?Q?Z/CN0ZxTovh6hFcPEfScN3rCIk8QIUDKlRv9AZKoHVSXBEVSpe8IzJuNQO?=
 =?iso-8859-1?Q?ciAgsaXcJxj+DctoCHaUqaZQb3EWbPOlpfSw9rRK5IFJBWuKZ1/llpcT8C?=
 =?iso-8859-1?Q?Lpg7Ecr4KEtEjwXQiF2AWD0yGeuMssz1RslIKOim5avkummLc6XFQop3wa?=
 =?iso-8859-1?Q?G5W5s9BpMlL5wKnRdPw22oyvn8LnSbtMnHFNJr1QFYRkEBeoOEZFQL6exV?=
 =?iso-8859-1?Q?Ln2oH6mIA/qFb0xHbO4cMTuTLkY2zcyCeTHYXnzk4BEx1PgfwhkLlw7sl/?=
 =?iso-8859-1?Q?kWM4oa/fh2vmM2akS6dTRxapb0cEUZDqF0xqInHhAV8vZq3OuVLOYUhw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1823b7ba-2344-4f1b-b5e6-08dc5021dadc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 18:55:51.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iThJrCwfk2lVrHQICXfY+N3v52zg5pPp/3rRczf/oou9GltDljh3LKgkVv8/7Bf2c4IFZHKN2HbaknsDNsmX0B7acR3/5kAjVv8xoTmQc2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7602
X-OriginatorOrg: intel.com

Uwe Kleine-König wrote:
> The einj_driver driver is registered using platform_driver_probe(). In
> this case it cannot get unbound via sysfs and it's ok to put the remove
> callback into an exit section. To prevent the modpost warning about
> einj_driver referencing .exit.text, mark the driver struct with
> __refdata and explain the situation in a comment.
> 
> This is an improvement over commit a24118a8a687 ("ACPI: APEI: EINJ: mark
> remove callback as non-__exit") which recently addressed the same issue,
> but picked a less optimal variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for the explanation Uwe, this makes sense.

Rafael, do you want to pick this one up as well?

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

