Return-Path: <linux-acpi+bounces-21004-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHb/JXG7lGmKHQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21004-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 20:03:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396C14F712
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 20:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C189C3009F8D
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D502BDC2A;
	Tue, 17 Feb 2026 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6TBFB3/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012E2857F0;
	Tue, 17 Feb 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354961; cv=fail; b=SpcGHN5KhKS3i9jokTZOtH1ZW98ou15Tb3kqGKoPB2XgytttJtp4AMnpcDu0FUGMPQLqsWv/zduubWICV9QzLPsAJlIA1Tx1PoLkrh94d1lJJhkxH8aSYHPpZVDjdoDcJhf+WFl7O93BD4eLl8tC9+/XbqAxWioXsZhMwSrCH8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354961; c=relaxed/simple;
	bh=XbUk8FqY1XlOLu3OSbaoBVJEdtmbbLqhnV5hcUI0jFw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2XxAd7AU1jK2EmZQ05zQW8UU+tfYGCz8no7vgCJGL9rQFr5q3N1N84PpIbJr1b4uVffQHo8IDrYtIYXqdxNdfsuSnAfsDfRuHNmCa4MVHlX9olMtFVPhGhu2+quCFmms6WGNDJY8LiA2uyjo9m1E4E6QdeYbKyuQf8uEs6uPcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6TBFB3/; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771354960; x=1802890960;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XbUk8FqY1XlOLu3OSbaoBVJEdtmbbLqhnV5hcUI0jFw=;
  b=X6TBFB3/4A4syMHZYIWYaWuWPbfLrnLU6nUDupUNAj/sMV7gJPibn4Zf
   b3zdjUNFJn7VZo741ksxYihxuvEl/J9sIoxjPnNd0TgZjj4UYfkyMek54
   kDVU9xXN5Jih6gbu5qY8Rvmma8p1mN+tO4XZ4JQWn/Hqy3PAnaqLY1RO6
   EUURqPIHCV1W1RhIcC7ytfdl8AT0o5H3ieJlz4Fzr/Odjd34EuVxMXSxt
   CibhOUlNmxTCSvxKusDbeUmlgUF4k5jH9C5A0JmZHLx0UhUlz0LiNTkdo
   xHBgbPRydpQj52chNJz1e6PrX7e4YZr5R2yvuTxyoB834feakRadiurqE
   g==;
X-CSE-ConnectionGUID: /BgBHpShTVCm46AsTSOXog==
X-CSE-MsgGUID: F4IDb61FS3Gz9F6G6nsDBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83875369"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83875369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 11:02:39 -0800
X-CSE-ConnectionGUID: p0p6tXxfTDWgvXhLCPTMUw==
X-CSE-MsgGUID: WvkGMr6zT1mrrrfLNMyY0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="212686976"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 11:02:39 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 11:02:38 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 11:02:38 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 11:02:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck/9WgIGBkm1xQdH2FrcoFHJ1xc/qbJvjS2gJvjT+YKPlS4R+6YwpMiSY51J3ceL22Ha9JBEhqJNHT0Xc9ZcDQudrk3jeaMj3U3Zbphb9+9aavBXR4sDeFF3z6KeKVqepHJt9VFZapw8iSqi1IPd+tUxi5HGwS1hZOfIpQJIvIdQiJAnN67fFwUP6SEMlRrHlYz5SXQlBWy2YfCOJ0F8NU455S5c/lh7qHm15inztzMdQZ24F1k/w1NsRP2LuJ2LVGPAeIqxvWyLb+2NaWPucQIRiE+1vjACivnBtmcpKMUXppzV62oFMHF6kfHGSeEmSLu9hVmCpOnMq7vM+NgJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPvSLP7zug1a2ICWMxK7nyPlWPkCFr+S70woLI6TXQc=;
 b=gIDAayFEmvhcbrg73NH29Yyp5IguQkOzVX1rru7PBu3ZeTJ2uQbVnBlMdP/ZZyhF+CTVkO9GvuR3RZeGtPdLg5ISHcfGXm3PSaQb2Owl2lUL+YccwcFMLPxu9zFE+n9AHUN+eEpR0LC1vQgFp7K8vdifsH1VlXVB0fq0oIaIKMHe9Ek6gjkK588Ku9acbCxnLlZQAjX7/sGfe1cX+Tr/E20VsfnlEDmKQB9xA0rrOms50xAKsjvgtUAr4jS2dFHbKzRwBBqXUd4Sp/NEONbSUh/15FpV1hsRILH1g7uNrKGFHyO2yjLva/djhNqVlAz1nVWskMUPYeq2m2kwOqus0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Tue, 17 Feb
 2026 19:02:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 19:02:34 +0000
Message-ID: <538dcb97-2699-4220-9df2-0bc6d5f64412@intel.com>
Date: Tue, 17 Feb 2026 11:02:30 -0800
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
 <0ba158fc-0c44-4b83-b733-9fc00c4d7f3a@intel.com> <aZSzZChSrjXeZmf1@gen8>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aZSzZChSrjXeZmf1@gen8>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b7a336-a31b-49b7-0a7b-08de6e571bec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGxGQzVMbG0rM2hWaEw4NENtS1lYSytTRExhQWRweDdCSFNBUXdvbmhlb3B5?=
 =?utf-8?B?YlBDWTZEaUlSUWJRNFpId3ZjdGY3Mm9hUTdWd0RzRlV4TXhFQzFkc0pFbDQ2?=
 =?utf-8?B?cXMrcVBxbzU2cTYreUpyWEtBZmpLSGo0TkxPZUlXWUlsaWZhU0FnTmhYcjZ2?=
 =?utf-8?B?VUhMNkVld1ZOdlBpdUxpMGYwY0dYVFdGVTdzaXdxcTNVV1l5SGVBQVVSajBk?=
 =?utf-8?B?OWxCNWJBMkVIWkwvRWUvMkFpMDJaU2NxVmgxNlVpbHNsWWN1dVhCYWkwT0ww?=
 =?utf-8?B?OC9jSHFDOTl0bndVQitpQmRORVU3MmVrbzNDR0cyaDVWRjA3dmk4c0thSWEz?=
 =?utf-8?B?cXlIdzFOM1ladHRLQUJoZ2hJWDZYUlFwdGxOME5qVTk1UyswWllzc3hiTktt?=
 =?utf-8?B?N2hzYWdxb0ZZRHd5MXZIRUZOMGNBSGFRdDcyY3M4dTB4ZVVtUnlodjQzcEtL?=
 =?utf-8?B?QUZTUWRGcXZHejhFWHdnUzdEcWtyejZ2YjBBNk5aK0ZpUk1nZlpUcnNUSmpZ?=
 =?utf-8?B?QnZFc2tJd1FpRTFsUWEway9yWFFkSytJNlJKZmVPTUtNY1dsdmtBWTcvcmcx?=
 =?utf-8?B?bUEzelRadmlVcUt0MWNVNW1nbitxTTdxZ1g5UElhamRER054M0tsSW9tNE5G?=
 =?utf-8?B?VDE1ZFc5ZlBmNmgzUTNLb0JOK3d1eGZBUUlRelJIQnN0WG5zZ3V3dnFUM3VM?=
 =?utf-8?B?TkQySUNwMGdERGNqNmxRS1JrbFVINEc4UXAwSlpRN1VjZUdWelJqOGMwakNB?=
 =?utf-8?B?TEdRTkUwZmZpTm4vZzVwQzZnNkpGcG0za0QzSlR1ZjJ0a0hiWExkUGlJMklH?=
 =?utf-8?B?dkI4cnk3bFY3SnFxUkwrMm15ZlhScHJtSDR0TFFMVzB3ZDd5ZVkyd2VTenVD?=
 =?utf-8?B?ZXRGUjFTY2MzaUE2RkVlSG9DVTdZMGpHNUFIdVZoSTBqS2Q5R3drWFl4SXhD?=
 =?utf-8?B?UXdVZ0JiQzByWll4TlZxdmZ5NU40Uk9SKzcrTFgycHVYWkc0SDFjRmJPMy8x?=
 =?utf-8?B?RFhhV1A4QzJ2dlhOUVdrYmNXVUk3cDdRUHgybUJ6azZOTHQrMUR5YUUxVlZz?=
 =?utf-8?B?OWt1d21JeU1HMVZqZXZkcjBlY2hoODk0OS81YlY0RmpUZW5GcUc0emdPN2hv?=
 =?utf-8?B?dW5xeXVWV3Y5U2FZS2VzSmU5K1Z5TnhCblJJZlVlTlFsV1Z6d0pPU0hLdXlF?=
 =?utf-8?B?ZURSVDFMemYzbGJFQ29YUzgzOHhKWFJkWFpnaTdyaUxPTC9iTFFhcXQzWWc2?=
 =?utf-8?B?UDhITTVHMDJuMlpseE1rRXluL1hvdm1zUmU2Qy8rNjd2cUtCNzNNVnF5NUFH?=
 =?utf-8?B?Wkp5RmVPbEZSczBzVFRsYjJBSDNib1FiSTZMSy9oRTNjd1lLdlRoY0J2VExJ?=
 =?utf-8?B?N0JoMmg2REprU3ZmaERaYzFPUzIvTVdLcFNTMDIrSW90dEVmbkl1Z3lqbmZG?=
 =?utf-8?B?aDh4WUR3cUIwRTgrRUNseVhXUzhmMFpKMW9mcnV5c1lKSXBnN1NVYVp5cld1?=
 =?utf-8?B?T25XT1owSk9Ub0FuczRzcHpBMi9vZms0UEJpT3RnMWhtUFNTNUxDS2Jndk54?=
 =?utf-8?B?SEdOTU04eElESWpMOHpyY3Z0TFpDMnhkRzZUWlJFb2N3M3dxQjR3emYrejA3?=
 =?utf-8?B?L2VydUpDemxqZldVL3NlNzBoclFGU0xFRXBWRnZEQ2p3NDE2QlYxQ3JUdTli?=
 =?utf-8?B?SWJQRGlLT1ZDU2h2UUZTdm1uemVzSXZMcm9NZWdvTmxrL2Q0NHV3aVZRNDBM?=
 =?utf-8?B?djVxdkhJd0xFNW1Bdy9aR1pFTmovTUhoYS9kODVDdThaVVlaZzBtTjBMTUsx?=
 =?utf-8?B?OWJuTm16L0hhWXlDSTV3M1lZQmVVYi95Z29mWlBsYlR2djFnQTR6ejcrZi9D?=
 =?utf-8?B?dmRjV0dNempKQys0cnI0WVRsQjBlaWpRUDNzajZ0MnZNZDFMemVnWG0xVVcv?=
 =?utf-8?B?KzIvdVRzNUx4UHBzYkZ1bVNKcWVqaWp5UlgwUmw5dlo0enhDUHYxNmRSaU0y?=
 =?utf-8?B?LzEwTXhPTXZkSUxTandrQkVFMm1uNmNDcEVHdzNTRjhjWlhQYmZDTzNEemxh?=
 =?utf-8?B?MXRZbW10NENDdFltMFE2NHQ3QjhCTnNtK2czNmgrcitYUmdtNy9lTWN6Um1D?=
 =?utf-8?Q?/Rh0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1U0YkdoaW1zRVZ5RUU3cldnaU05YzRTNWhwMUlMRjNwN3lMYVBZc28zYnNB?=
 =?utf-8?B?bG9BM2ZUWEFGVGZ4Nk1Nb1pIVEVmV2dpT0d6ZGFWR0dRT0JzNnR6NE5SMGJv?=
 =?utf-8?B?aENOa1BSaUZGYnRtNnZLRmMwOEIyYXFSSGpxdFNEMUp5dEdJYXZxa2xXenZq?=
 =?utf-8?B?VUl5OGtTYXRyc3JqOXVueGl1WFlyYTNIaFYvUjVBS0VvQkswT3ljOGlFRkYy?=
 =?utf-8?B?RFhKbXlGOWd5N3JmNHFvMEtpYWRSb3cwcWRqZXZpY3JwUDN5ZGRKQlBtVmpm?=
 =?utf-8?B?SDRmUU9JS29YbmFKaHdYU3gvMHF0dUJBTGhRY3pGZmNudG9FUUdlb3RRUm9F?=
 =?utf-8?B?SFk2dllEL1l3RFltMmxNMHpwUHFHanV3VFAxeUxpZVZHeEJPbTdSdkxuOXBD?=
 =?utf-8?B?ZTRXSC9OaDBuSFN5UFRmK2R3RWM3MjMwc3JEU3VUY09iS2xOdTdsbERNU2ha?=
 =?utf-8?B?SGlsTWZEMUVxdVNoVVZLQkRXTVJleXJneGZTSDgrTGVPaWNkTWYzaFJhb1V4?=
 =?utf-8?B?YkNNbkZmWHVIL1M0Z2JuenBKdjlkS2hab25Ndk1RbWpaTENwL1pMR0xsRHNJ?=
 =?utf-8?B?bW5zdEZ5V1hrZW9wQXBKMFV2U1hmMzVreWlqc3lqak1sMTRRY1owektnSnZJ?=
 =?utf-8?B?d0JpajdUYjY5Sk1hVStMcWFiajVIQ0s2SThmSU03TlJrdjNxQU1Qb1FXRDU5?=
 =?utf-8?B?bVpHdjBKZHl5WW95cWYrNDFPeW8vRzV1cGZ0N1VzTk5TTkpCZXJVbDliUllO?=
 =?utf-8?B?R0pwU2VXamJORmxJRE8wWHo1NUl1TXpnTDAzNXh6bm1XOTRxT0J5L0ltRFFM?=
 =?utf-8?B?c0FGS0xnM1oyaTBEUkFJQ0N1VWQ2Y1c3VUVLM1UwY3g0Vzd2Q1d1eERSSEV1?=
 =?utf-8?B?Q2g5dHIvSUh0d0J2aktuNEsyWHBBaUJTS0Uvbm5uMXJoMjFmQ3dLdkljdFdj?=
 =?utf-8?B?UDdzb3J2RE05RkxxQUtQVnByYktvMFNXSmxOL0lsUW42OGhDcnhYVGpTaVlw?=
 =?utf-8?B?WjR3Y1krRndGWk9QRVE1OWVBNi9SbHU3K3pvU2ZyTXVMYmFMa1NXa2szNkhM?=
 =?utf-8?B?cm44Y09vM3JnbDEwWGUyaHIwOE1zVnFrUmJzMi8yRlU5SWdVK2lVUzY1MVox?=
 =?utf-8?B?MGEvajh6YWhrZUFLOTE0ZExldTNoLzFubjEyUzdoZ0d2UmlXenlWblExOTgw?=
 =?utf-8?B?YTF2MitMQnpZWHJlTGRoSlZ3UThxaDFreWRLN2N6ZFVRNE53bGl0YzlmSitP?=
 =?utf-8?B?M1ZqYnRHeU1aUlYzTXU4Q3daNjkyNEErRDVWeno0R0dHWlc3dG54VUhKc09O?=
 =?utf-8?B?ZkNTak9uZlRkMDBLenB4VG9XNEJjN0tVY2FIZzRuanJ1cU1SdURmejgyck1W?=
 =?utf-8?B?ajlQWUNZNjJjMHRDeFhlNWVJUEo3NDF0a2lPV25hc3VOTm1GVzNCTmxmSXpK?=
 =?utf-8?B?RUlUZ2xiMG9NU1g1dkJHckZFYkpHbkY5RWx1UmNVVUFHRHh5N2UrWlU2QUZs?=
 =?utf-8?B?NEd0cDlJdEEyQzFDSzBrTWVHR0xNaVZtdU9GUmlJVnhPcVZpdjE2dmtYTFA4?=
 =?utf-8?B?cGtnK1dPV1NhcG52b002MXIwV3dkU2JuZkNKS1YxejAyRXRGSDhSRWtzYisw?=
 =?utf-8?B?YkJCY2JTeG5BTm9tMi9BaFVxYTQ4ZFlkdUhxbTVmaVE4RlYxc25OR3RNbENh?=
 =?utf-8?B?Y3RYeGJLdm9WS2p1Q0FmSlQzNXM3TTBKQUZwekV6M2pMVDJsYmpMaGZEb09o?=
 =?utf-8?B?K3RPY3RVVEFYNURydHVUYnpxSnlaemY4UmpTSzcwOXgyS29nZTVoT1hEZ203?=
 =?utf-8?B?cFNhVVZ4Q1gwQWlUS0dmMTVtR2hFUkdFNStTNHB1TmdGRTdnNndBb2RJUWVK?=
 =?utf-8?B?WG5PaWtEK2FZR1BHNWt4STdoNithUEJJNjlXWXJoNnlwa3VVNlcxZ0VrT0Ru?=
 =?utf-8?B?dU9IMG11bHptb2crY2VHYWVrZHFlYVEwcnVVWC9LbHd3Y0duc3FUT1lOUWkz?=
 =?utf-8?B?N0M1MVpORnpMNi9wdVhDMHZBWEEvdFBidWtSNDZLdDJTemV3QXVybnJHUVRt?=
 =?utf-8?B?SldMNDNNcm9aeEZzVnM3K1BKTVFUYVV2TGNNeDlrQURtVWViUnlWZCtPOU5l?=
 =?utf-8?B?QUdOK1NUTmNVdS9VMXVzZE5CeGtmVStaNTVQL1lXUVhkeWlIaTNVQTZVR3Zh?=
 =?utf-8?B?M1VaRTdkb2NLQXJ6MlJHc2d3Mmg5SmJFVjQwN1FQMmJicGhWRFRUNm5iVmFJ?=
 =?utf-8?B?blNJR0NBcU84dGU4TW9DVEhsak1QVzN4Q0ZSQXA4QzVNZUE3ejJWWmlSd3ZN?=
 =?utf-8?B?S25lVDBnUTVXTDcyTGRmT1I2czk5SnRsMnFYSFkyM1l6TjVKMnNKelhTcER2?=
 =?utf-8?Q?Sv9orRJ5Pe2+GNE4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b7a336-a31b-49b7-0a7b-08de6e571bec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 19:02:34.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vs0G8F4Gv+lsLU9fj0wO6OS0QjZ22gaWjbhf34vpfiKtGWmRvSVtu0AN4VnnmsI5YX6IoVt75Ra7A/KHJtxlGyTN5m9Ak4peDKHAiz8ZCdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21004-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4396C14F712
X-Rspamd-Action: no action

Hi Drew,

On 2/17/26 10:28 AM, Drew Fustini wrote:
 
> BTW, I'm working through all the comments in patch 8. In short, there
> are a lot of shortcomings in my current implementation that need to be
> fixed and I will explain in my reply how I plan to address them.

Thank you very much for considering the feedback. Could you please also
consider splitting patch 8 up into more manageable chunks that have
descriptive changelogs? Even for an RFC it would help digest this work.

Reinette


