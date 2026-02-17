Return-Path: <linux-acpi+bounces-21002-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YELaCjmZlGkoFwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21002-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 17:37:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40B14E4B2
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 17:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 164F33023D6A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001D36D50A;
	Tue, 17 Feb 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFxpNnSq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBC36C0BE;
	Tue, 17 Feb 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346046; cv=fail; b=ToNwcqpa9iINbK/wXrW7i6WVXw8j15DXV9MfgRObHur9HnDwFJ7CI4gWSPgfZSEYLhFCagJbBuArc248Lh8bO6hqRDHdPKsq6NZDHCBOGA+hiOZ16HcywsXG23igG/iOeCmdbiKlyDz7NOYOvdCylmqcVqkrPr8SMw6PE6lUMdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346046; c=relaxed/simple;
	bh=3XP8FD8UYfM+IPKBRZDDUXaoVhDuiKcvpNGz7/4FawU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ic37hS4qP/J2IEYzdGvSc0vi7cyUjn34MTCWglEMPcyuJw5V1pFlN7t2ugO54HmhXcDZ+27BbqHUbV62d6D9w47XgEKgxhb4BIP2JaBWHvdd8ROb3dXy+YxEp4MjuEhFClE9boxMUATAodFyC4hqryWABwlO8gb1cBMQ9ZQdYp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFxpNnSq; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771346044; x=1802882044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3XP8FD8UYfM+IPKBRZDDUXaoVhDuiKcvpNGz7/4FawU=;
  b=fFxpNnSqbQuoye2/mOpoD/iW1ZJ70BTPPf3feoB8TbJBmhZ64BrTknsm
   cLGxjjMPpA0NNCuSDIhtg8urbFt4LiPrTaJhIfJ8EAFeQgf/FB6owQ9bo
   XXWJ6I6ep/eZufMVRagudEkNz6trXX3I/bZE3Zf5NaOdT58+rupjwYvHO
   NYibulmxAPBI2KohOP/9m2vAOFuf7uO70v0ii/PEjg5Mt8p1RvqscxpN4
   0CdV66ElErAIWcj0RcXgzyIujlagMvRb53RhHRR/p1ZfXsREasl4u1rwZ
   SiETE7I3kBRgEpUCRMTrsmEFuswYmc1k8HBHp4NO3/WFNsXPyc6JGjwLx
   Q==;
X-CSE-ConnectionGUID: YlQs6UNpSc6fchMzQXTmlg==
X-CSE-MsgGUID: LbGYSB31QCW/c0XcLel4Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72463609"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72463609"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 08:34:03 -0800
X-CSE-ConnectionGUID: lANBpRrrRGGeNZ+xg5FNXw==
X-CSE-MsgGUID: TYvlJDfWT7q0o9arLTUs/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213941678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 08:34:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 08:34:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 08:34:02 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 08:34:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBZ2QWlkLSFpNueuqm7X3j2QfqkrkyGFFuKFne+1m4BfVIWp4SLXvwJPWnXVKiHTK3nKBiiSakdaGjzPzAaGV8TbWqs8/6IcplyYmBnaZDU3TO8QrXEGn16I+jSmRO4LENJQ1Md6GeaUV3JkAhbovYPoGk5ZRt5q9+8hfEAKoY/PZz7KWcBINuq8jkXJbRfqfRribyRtGjf8sQrwGfCAPrmnEUquY3b97UXgcxrvrkAyvLSFl232XM+9uISORF8FF92ucG2rX/+Qf5DbeKFcBPT9Gx7qJVvp3RzT7y7CL8kHxPc1Kn9xOI3MSLawQouIrmc+/XqDa34r8/9X2fDU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTZqsmtMveNkGAPuLrlEE2kBjRLKnGUuXmDNYwUbNdU=;
 b=snzo3XBcOrZfeBVCff7NjgXTLDLXJCNIbjJP9h4o0GODXaz9DDo3I5sAycToxCLOUwHAe1uwjpFuhXd9QBI53/l5lSMpACkuKnYirxxdUviumNAGDC4Ou3Vrbz0GjBInR+2p6jhgDk+p6hAufl1oHirUROOF1xJ/ZoUkiIv6zi/F9PrP91S74WKwRYfAhW525+8Be3bouw6b4nPlMSg3o2Zz7nrYhr1UwqbIRPt+s41R1OQb4iZNDyGEhyCYZHKNF6Z9FFiUFl/IgYfm3TYe1cZcbr7HcCLkSPPnVwdYiIzPC/t3/8HmrLhmeGeY+cgMwD4klR+WRrSUc03wPJm1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 16:33:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 16:33:58 +0000
Message-ID: <0ba158fc-0c44-4b83-b733-9fc00c4d7f3a@intel.com>
Date: Tue, 17 Feb 2026 08:32:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/17] RISC-V: QoS: define CBQRI capacity and
 bandwidth capabilities
To: Drew Fustini <fustini@kernel.org>
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Samuel Holland
	<samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
	<mindal@semihalf.com>, Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra
	<atishp@rivosinc.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, "Ved
 Shanbhogue" <ved@rivosinc.com>, yunhui cui <cuiyunhui@bytedance.com>, Chen
 Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	"Weiwei Li" <liwei1518@gmail.com>, <guo.wenjia23@zte.com.cn>,
	<liu.qingtao2@zte.com.cn>, Tony Luck <tony.luck@intel.com>, Babu Moger
	<babu.moger@amd.com>, Peter Newman <peternewman@google.com>, Fenghua Yu
	<fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, Ben Horgan
	<ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, Rob Herring <robh@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
	<robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-5-dca586b091b9@kernel.org>
 <3f53c823-74ab-46c3-9cf0-c28b062f2c89@intel.com> <aZCh3JaS2V0pLWXm@gen8>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aZCh3JaS2V0pLWXm@gen8>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c322e4-286c-41a1-8bc1-08de6e4259dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXJkd1U0T1pvT01ldnJEY2JsZmt5SHZJUWV1aE1DTGZGQ0Q3cFg3TnBxbW9T?=
 =?utf-8?B?OUk1VElVTkJobzMzejNxZkRtT2dSdzZXbUM3T0RRS3g0RlhqaUhtQnladEhm?=
 =?utf-8?B?cDVnNEhLM2VRS2ZCajFDOHVXWE1RK2FzelAzaUxPL3dEdGJqOEw3NmlHbTRY?=
 =?utf-8?B?WndqRERBeTRvN3FwS2ZWL3lmT1gweGtxVmxQWWJnRndONTRTVk0rb2duSVh4?=
 =?utf-8?B?cWhQSnhZZkVscFVTT0liTWNveC9XOFZhcXkwV0tYNmNvUkl3NUFCditSUEVk?=
 =?utf-8?B?eExxUlJCM2RYdGk3Y1dNV3cxSC9QMlJLRm84ZzVxQm1WdmliV1gyVzY4RXZ5?=
 =?utf-8?B?dTMwZUpaNy9icE5NUHI5dDdlZDlaV1NPRW5ldW9hdDVpMUozVTRFQ2I4d3Na?=
 =?utf-8?B?cElXR3V2LzZtSGRENnFDd0Q2dmw0ZGRqWjlORGwxcGRaWHZ1aWhGQVlnWGs3?=
 =?utf-8?B?RXlXQmlQRnRIKzhiVUpZN1NZQ1E0Z0l6ZTZqeElrQnA4RGJVM0lxak9DejJ2?=
 =?utf-8?B?RENmNlF0TDJKMlhLbVpIc2lVN0g5OHMyM2tiU3dQNm5oeHIwYk41R3BySTVI?=
 =?utf-8?B?K1ZlYmYyd0drWXdOOW5LeVdXSmdaSzh5QWwwcVFsQkMrN1o5ZHZZbityeTV5?=
 =?utf-8?B?dWNySUgvQ2x3V3E1ZGMwYVpXdHZ6Qm1qbitZRmhkdURnSzJyamZjaFZIRXEw?=
 =?utf-8?B?OG4vNk5EcjgydllEWG9XeHlkMFkxOXNNN1lKWVM3U00xbXRxU1hTQklsUEJF?=
 =?utf-8?B?WFFHeUV0VnI5Szd5VEFTaEM1YStJMjlzUVVtVHpWUDYwaTJ5ZHpyWWFuQjQ0?=
 =?utf-8?B?enJHUGNIdUxja1k5alVEa05uNU1wVXZMbDgrRk9NNVAzdlY4UEdKSk03blhm?=
 =?utf-8?B?cXluM21DeFFYUU12TTR3Y2FQeFVvenlMNUJlVFM0aWdMcWFvbTdJWmFNSWNy?=
 =?utf-8?B?cU5kNG5tTDhNUWcwT254dWlTL1ZpVWJHVnlzQXNRYnNjeGdhOG5MT1JpVFhq?=
 =?utf-8?B?RVc5L2xZQzJ0Q3Jic3FMS1c1dGV6N2NkTG12citPa2VkdW00cExadXJEMGk1?=
 =?utf-8?B?eTZCeUVHVUhOQ1pkV2t6Vm5tejFGVG9tR0liVzdzTGNyOGMwbElBajR0MUFG?=
 =?utf-8?B?dkIyQU9oYW5WWmNjUjJKbjROTjZUazZ0UkdTbUdXdnhVRDVUN0ZBWllwQzRo?=
 =?utf-8?B?SGhZVEQ1NlQ1M0tLdTVvREhkUUgyM2V0b09MNjVVdXd2L0c0ejVIN01leTFT?=
 =?utf-8?B?Ymt5MlJ0YTFyNzhLcXZtcWs3eVNzdTIwTVVxVGh4ZHFDTXVLL00yZHBvVCts?=
 =?utf-8?B?dEtzbUxLdDJTaURySlN3OG9WVUlsTFU4cXdsVEs5QzlnaTN6UHh3eEl0TnJM?=
 =?utf-8?B?MlRISXZqNmpvakhlLzFrVy8yalFVdElESmgyMzc4UGlreENmZXptbmxRZGc1?=
 =?utf-8?B?dThXOUxuYTJMQ0d3a1dTV3BtNlV2YWZEYS84a0Q3VmlocTd2bkFQS21vVUox?=
 =?utf-8?B?anVBM0FuRm5IUWFnc3BlMGk0eVY4Mnc5dGdxL3BRRGtRUTZQRnhmYWxhMUJD?=
 =?utf-8?B?L2pKNDd4N1BtSW1ZL0dDMWllbk41MURERmpDN0tzaUxCZFduNzlGYllkNEtp?=
 =?utf-8?B?T3ZQTUNsUFNGRnNHN3pSNkJwT0F4MzFFZkYrRVBranVVc0hmV0ZRZ0hkT0pN?=
 =?utf-8?B?emhnWFFNRkh6WkZjanRSWVM0MFdzbUZtZ0VjbzF6ajRTM1lKRGlZNWJRNXF6?=
 =?utf-8?B?d3pocDkxUEJYQzI2YmNieWJKTlVuT2M2U2dBWXJlT3hNNGpibWVBNWRHZTJH?=
 =?utf-8?B?VUdPVUJ3dzZKczcvMlVGK0U1RTZ6TWVPWGViR2RuOUl2eWpVTUVGMWRvd3BU?=
 =?utf-8?B?MWVtU0QrYVAxTzhNaXphWklyS1NhQUhIODhxUFc5cmpoWEtBSkRlMERCa2tV?=
 =?utf-8?B?MjNCaFZrR3M3RlF6N3FJWHZScThXZTR6UDlrUnVSZzZVY3QvSFQrVFgrL3JM?=
 =?utf-8?B?dDJaWnVndUNlRjJtRmc0M0V6Y0hCcUdiY0k0RjZGZnZWYzlOc2hVbWtvUjdW?=
 =?utf-8?B?clc5ZlV2TWF4eTY5RFVPSU0vT2ovL1BZMHJrUXZvTk45UkU2clV3N0NRdzFN?=
 =?utf-8?Q?VZrI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5DNFBJdWdFd1k1a01OejEralZsQnU0ZExaMzNrWUlUYng1cmVlNFFjTUht?=
 =?utf-8?B?NFJrMnNTbDR0ZVh6Rm5JVUdpTFk2SEFaV0VGSW43YmpjMk1UTWV5VkVTTXEw?=
 =?utf-8?B?U1JSWmhlaTY1N1BiZlNLUmpienp0QUNyVHF5UTRMUy9ZRDAwREtYdU1tM050?=
 =?utf-8?B?VWhFenRkT0ZOTGNDT1JOUDV6QmgvYm5ROGR6RmpGUXpiOTMwOUw3QlhabEJV?=
 =?utf-8?B?OUcraTB2WDYyQXREWHowaVA3SFpObURKblNZdnVEZ1FMNTdzdWFGellLYTRT?=
 =?utf-8?B?MkprM0ZWZTdCOEVjUDYyaW5Qb0tCN3dzbSs5UWF5d24vTDd2T3dPbkgrN2Zo?=
 =?utf-8?B?TDR6MUxZUkVrNmY3NXY3RUZhNFhLTXB1ZlFFKy9hVFJLYm8wdzRiYnJxTmlE?=
 =?utf-8?B?aXAyd1JjTW5UQmdkVUl6SzRwUERCYWRWYU5rdzVKZkxrR3EybU5TKzhld3Ey?=
 =?utf-8?B?OUdVQkp1MVZpdjhDNCsrKy9wMW51ZGt0bGFmS2E2MjgvYUM3Vkk0T0RJQVBo?=
 =?utf-8?B?UWhHR3luOGZHWFRQU3JWdy83VHk4T1NqWjFkbndUSUg1eURHeTdmZ2wzRGx4?=
 =?utf-8?B?c3ViOGxPa3VpZjUyelFuSDQ4aVJabnBZUnBVOVVtODJFYWJaTkFSaytkQll1?=
 =?utf-8?B?bEx0VmVNeXNnWjZSNmNvRGdPZzB4NWlrN3E5Q3dndW8yeERIVDVSaTlqdm5v?=
 =?utf-8?B?TmFubTc1YTZXNWU2U2ZRSkcreE44b0E1andzbzNSTW1ULzJ1UDNoRVFiZnZW?=
 =?utf-8?B?L1NmOUhzVFQ5S09vTFNhcUo5Y1Vad3BqbDVKWS9idVVhcm80dnZYSUFJZmFX?=
 =?utf-8?B?eC9XWnRQUFdJZEdoZ3R6bU1OZC9iTGZFTTIvWVZGNm4ydllFUUNqek9HVHZU?=
 =?utf-8?B?MEJQdXBDWVNRVHNSc25EcS9vVnZpeDJiWnRXa2plQndEeS9XUHNSalNtdTFn?=
 =?utf-8?B?VktjOGRlKzRGWllKc0dScWlGRllBWUQrbWpBVjY5a0R6K01keG4xdkJJb1l6?=
 =?utf-8?B?MU02UWR3cWJCS05QbFlLT29mM282WnhCbTFRYUZSaXZDNkJIdkNQUisxSjE1?=
 =?utf-8?B?dWx4T1NUeTRwamY1THRTcG14UDN2VkRwL1g2VGFBTngyQWQ0cFVUUFlYeDd6?=
 =?utf-8?B?NDZYRmNyOEJqREFqcXBReC9XVkwzeGwyMDVES0hRdlNqa2pRMll0d3JkMUt2?=
 =?utf-8?B?SlNHTHpia3hRNXkyYnpsZHVTTUxJYnpkSVRwQWFXYythNlphSHQ2WFNUakxK?=
 =?utf-8?B?bnNTVDUxdWlTWWo5ejVMU1Nobk1LVUJhN0lFck9XTWtpZzhSMTE0R0JpV0R5?=
 =?utf-8?B?TEtmaSttYmplNHJoamxia0MwSGtoSWhlQjBidDl4aXZDdzdCMk5KdTBrdGlJ?=
 =?utf-8?B?T1AxVGxQelphQmJ0N1YxblFjYUdTN0RVUER1MUY5TUdBRldLN09ZK2ZYL0Ri?=
 =?utf-8?B?cjB4Q0Y0S0JjMHo0VTFFRHJsVDZKYzlrbDNFa0ZVdnFTc1JjOFVZUVJlS2dK?=
 =?utf-8?B?dm4yTUxuOG1yRHFrTUR4UGtiMG9YbFEyZnNSY2JadEgwdGhnSWpQYlkwN3pI?=
 =?utf-8?B?Z2ZYNEdrK01JRm5oVHNzSHJja05Zcmo3VGNKSlVLRjh4VnBVVUJ6Y01pbXky?=
 =?utf-8?B?YXhMOCtDeWtzeS83WTYzTXpMT3FjOFhYelpWQmZzb09md1lpQTRGTmlkYTlL?=
 =?utf-8?B?RkI0QjBabDRFY0U0dFJvanZMZExvV1V6MVhTUFNNRjBpLyt3SHQzUWxOYXlH?=
 =?utf-8?B?ZjF4NmhRb1FjNXdjbnJUVXpDNU1hWEZPUlFvaDVPdDNTWnZnTy82UDFWbk9M?=
 =?utf-8?B?aGRUSGlWa0diYjRnUmcwcWxTU3Q1clJFczQ5VnRSbXZJVHBZcDJ3TXNMdTVS?=
 =?utf-8?B?ZVAxL0lQWEtPN2sycXY1TXhyeVczdkNlenJoVlZLUmlLMDArcitXcmhjR3dT?=
 =?utf-8?B?dkl0ZTdHaVpMRXRvOXR4OFM0L2k2cUVveFRnT3Y2dTVoYlBmcVd0bnVINU8w?=
 =?utf-8?B?YTFjMG1YRzhSM2ExdkVPMU9HRWUyN3ZsMjhwTVFhQ0VYQ2RrUXdvbUk2K0dh?=
 =?utf-8?B?cFE2bG9DaXB3VWZHMTgyNk9OQTJoZnJ5dmZnS0U3cVQ5M2JZVFk1dFczUnhW?=
 =?utf-8?B?aGxEQlRIeFhzempRTUovU2h4bnQyM3d0dE93TzFhd2Z0ZG1MZ0dIQ3pCOERC?=
 =?utf-8?B?ekVuU1o3Z1ZGa1gyQkVkdzdCQnRrZitteGcxZEVYWDEvcytKMEtGdHloc0RE?=
 =?utf-8?B?YzZDVXJnVFhiRmdpTzZzVE1HQW9nQnRiU253ZzhsT3IvT1VrcXJWRlNncHFE?=
 =?utf-8?B?MG4vWUFvb3BNNU54RGw2Qk40bjlGUTRrTzhGb0tKUUZWUjNOMkQ4RGdxdEEx?=
 =?utf-8?Q?1LKiWQMun4/YboQ4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c322e4-286c-41a1-8bc1-08de6e4259dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:33:58.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6yR6i+8TME+vOywfTDwCnGaDQEJtaNhgnn5oFE+2W4daNQnJ1NgkkmFWK4z+0+aBtWYXaEWGjUO5a0eTAItnJ1Oa3EA6HKRKMv4XRwQ0Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21002-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4E40B14E4B2
X-Rspamd-Action: no action

Hi Drew,

On 2/14/26 8:25 AM, Drew Fustini wrote:
> On Fri, Feb 13, 2026 at 03:13:42PM -0800, Reinette Chatre wrote:
>> Hi Drew,
> 
> Hi! Thanks for your detailed feedback on this series.
> 
>> On 1/28/26 12:27 PM, Drew Fustini wrote:
>>> Define data structures to store the capacity and bandwidth capabilities
>>> that are discovered for a CBQRI-capable controller.
>>>
>>> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
>>> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
>>> Signed-off-by: Drew Fustini <fustini@kernel.org>
>>> ---
>>>  arch/riscv/kernel/qos/internal.h | 128 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 128 insertions(+)
>>>
>>> diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
>>> new file mode 100644
>>> index 000000000000..ff2c7eff50be
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/qos/internal.h
>>> @@ -0,0 +1,128 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +#ifndef _ASM_RISCV_QOS_INTERNAL_H
>>> +#define _ASM_RISCV_QOS_INTERNAL_H
>>> +
>>> +#include <linux/resctrl.h>
>>
>> The include caught my eye but I did not notice any additions in this patch
>> refer to it.
>>
>> Reinette
>>
> 
> I was using this to make resctrl structs available in the code that
> includdes this header:
> 
> arch/riscv/kernel/qos/qos.c
> arch/riscv/kernel/qos/qos_resctrl.c

I see. The changelog made me believe that this patch defines new data structures
used by the patches that follow and the inclusion of resctrl.h created expectation
that some of these new data structures contain resctrl members that I was interested
in seeing used. If keeping this style then a snippet in changelog that explains the
header inclusion/organization would be helpful.
 
> Should I rearrange to include resctrl.h directly where it is needed?
I'll defer to the RISC-V folks since I understand that not all subsystems follow/enforce
rule #1 of Documentation/process/submit-checklist.rst the same (also called "Include
What You Use (IWYU)") quoted for convenience:

	1) If you use a facility then #include the file that defines/declares           
	   that facility.  Don't depend on other header files pulling in ones           
	   that you use.

I have worked with code following different customs and personally I do find code
following IWYU easier to maintain.

Reinette


