Return-Path: <linux-acpi+bounces-20595-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCFRJfsVdGk32AAAu9opvQ
	(envelope-from <linux-acpi+bounces-20595-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 01:44:43 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DB7BC72
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 01:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375C030166C4
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 00:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849BB1D88B4;
	Sat, 24 Jan 2026 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xpgjvy6v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805081D130E;
	Sat, 24 Jan 2026 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215480; cv=fail; b=gwuh2voKv1CO6JhuqW3XZuwahSmWF7mEi8W2ngQ3E7+Z0VId9kJYUD1QQpQFRQVi456FjPwgUedjHwS3HDwbGVRWWvAcivB9TUWJrR9C6cHQ6ErwoPQLeBvD+gnYJ+hyzBRcT7dpGZzARMcEMxsdzQff+pycl3IewZA1pBxipEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215480; c=relaxed/simple;
	bh=7HaJZo7ecSGsYoCyELm3v3tc7AZxRfpDmpkpKFCMCzc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=A2l0lp77mjnkM6uZvETtLCf/9ebQdQS1spuWpt5PD5CkAq45hSYCjowEPVOoXp0RvlU2KYLIPl7A/Z/0/uVfUpJGeE/6qLW44to6psPwtBs63VqIK20fup2/jpGjfsP+skzdgF7aCSXYHX/9+2hoMaXMMURZLKmzbBfYLHa1oM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xpgjvy6v; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769215478; x=1800751478;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7HaJZo7ecSGsYoCyELm3v3tc7AZxRfpDmpkpKFCMCzc=;
  b=Xpgjvy6vBsHK/uyJoLjeLszpA2HmLxiKtssxgnt84FrZD8pZERaApp/z
   r/e4ZBn0OB75yIwRgwWzT6iMyN5di3HfJVNaPbZmDcJ71d9gK5T3lYhc4
   f088+2ewYEPtLkrmvYxWbZ6gEGOQDzcU9TkU3BurIU+ctYvFo/duO3wYj
   LQEloOPySPHMMX4U+4WT0nEwLyoBEwCklJ4gUSML18aNskolDVsMKAV1N
   INQED84MzBdqbAvyyuPHh5F8VRtXLdf3qL/jRgyH7J5ADks9cjH72yAOk
   aY5HzJeAn9L6R8AxyvSmCeAeGgzidUZmWIHefV/CxRgJ3pehU27r13DvW
   w==;
X-CSE-ConnectionGUID: Vyc7LLVdQ4uAjEOOqfKvGw==
X-CSE-MsgGUID: ar/86NRUQQCvtN2nsNFyuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81100554"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="81100554"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 16:44:38 -0800
X-CSE-ConnectionGUID: 0prmioNXTaKpSPbq/MatPQ==
X-CSE-MsgGUID: Jj+5UoAqTHKgAd/WIrGF+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="207501993"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 16:44:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 16:44:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 16:44:37 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 16:44:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApVhDsovJAhszjVynUdkdUvOSoU0knHTD/3LoHTB2EgvFggLKGJLOhGFlGcWfAuvWjk/9h9cAW89NN/9cDDJ6bLrgprZNJbDwwwnVLz+M2HVs6+nIjG0bzya8a0wFJBrxKLsjqkUvwgeDjobWCSDdQLFj2WJg+8s92YbyETPct3cPYHz8P2Gw/jiVMNjSobfDpQwDU/wbqlaInH4Mb9vnVsvw+EuFdIOnaWxTHF/M3k+2aMjLcQ4k0F80waul1NTKqAG9ZxkPaEK1VzbJ8ZfoEiYNkrTmWPlp11NCIrQNtOCxL5RDq7K2YbRYx1t9GqGTWS9ekOBEIjdWwed8rdtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUHe1ttbTi2HtxXExpEk9AEoY6mjB4SeOKh5d6859Dg=;
 b=C+XgkKN6rLU80zInKMtxRo1vbmJYe3pv3/ciUzdYOhEVZtXqFWzpHHAO7MtGSS2alDccduf/ULN1YEjoKrvfDIaVxVhqCFOnrUBPQkq9yRIuBwhXgQRmBOTDlZHrj7fDBrIOmfnohggkv2NhS808bTA4olUFiim+xAwrqarsLrbwM4x0b4BlrXmki9hSlcXiPF/4l3Ru7ToFXzD0SUkgF7avtaFOQqH8OeRUIDCiTfJO7SAfV2XzbYHiwCIxfcXOJTONP8PJP8IuvV7CCC/ag8hCITTFeDzRaCMiXri0g5FdMXspCRAwRkzi4hY8BExoD62qdX9R7P/cWuauw9cLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8297.namprd11.prod.outlook.com (2603:10b6:a03:539::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sat, 24 Jan
 2026 00:44:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 00:44:29 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 23 Jan 2026 16:44:28 -0800
To: Shubhakar Gowda <shubakargowdaps@gmail.com>, <dan.j.williams@intel.com>
CC: <vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shubhakar Gowda
	<Shubhakar_gowda.P_s@dell.com>
Message-ID: <697415ec95e13_3095100cb@dwillia2-mobl4.notmuch>
In-Reply-To: <20260119184438.19942-1-Shubhakar_gowda.P_s@dell.com>
References: <20260119184438.19942-1-Shubhakar_gowda.P_s@dell.com>
Subject: Re: [PATCH] ACPI: NFIT:Advertise DSM function 0xA (Query ARS error
 inject capabilities)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 272cb2aa-3672-4dda-a349-08de5ae1bbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTZyVEJVU2VmaVpDUng0VWFtTkIyTDhYR05IUHo0RDhZT3lqNDZLajFiL3BX?=
 =?utf-8?B?SForMGxtNWNEdlJubEdGQ0Vja09yelpScllRWHVPa2U1cEZ0OUpVMUZJV001?=
 =?utf-8?B?cnFXalN2aUh2WTdqR1RIYm5XRzJ4eERZZURBS1NPbmlEU2pBY0M1RHQ3ZW14?=
 =?utf-8?B?ZDN5a0pRcFNQNmY1dU9XVXJuTlA0eFREZk42MEZKMS9FNkJJTVdEY0Fod1Vx?=
 =?utf-8?B?K0gyWTBhbzdubGVuY0RPZ3d4WDZtc1pMb2RYQnVDc2NYVkU1L1VPRGNTSnRX?=
 =?utf-8?B?SFcycnprT1JrYVZTWVYxVVhiTUU5a3FGbmhXdTZuVDBlaDRNS2VYNXVscWFQ?=
 =?utf-8?B?RUpaTGhMbHEyK0ZBVElLcUFNWlZsa3pjdkZpMkRJeTFxZkp3YklFdXhYcjZQ?=
 =?utf-8?B?YlNwdDlEdXRVOFkvYSt3bkFKekFCdW5ldHJleGFyVlZEaXNwV1JNVTBiMmZW?=
 =?utf-8?B?ZXFKZVI5MUU3TUdhRkJkNEdjdHI1Zm1FRWVZZDVSOE9IdUNLMG10WGxqcVV5?=
 =?utf-8?B?UzVnbFJVckZEcTNzL1JWQWYxSFQ5NUkva3ZzclZTZndEM3FuN21vVlJZaDlN?=
 =?utf-8?B?YlpEOS92eWlUVmVwNEdrdytMakZ2QjVvRWpNUjF5Q3E4TUhmd01yalpKWXZl?=
 =?utf-8?B?MkJNRWxHdXhIbnJ0K3laUnJ4YlA4MmlRUUI5ODU5ZitRVEZpU1VyemZhYUhU?=
 =?utf-8?B?Q21LczlBWFNvQ0EvY3oxb3VMM3lhb05kQVQvR25oWkJ4VVhjQXhQRFY2VXVz?=
 =?utf-8?B?RXZIWjdPRmVvV2wybzJ1azkrSml4TTlRRnVDMGY0cEtjVXlXOEIwWkRKSDln?=
 =?utf-8?B?QmJ0UmRVR1hwL3BOb1NlMlRaTlhwVFNNaGNwTDRYRXNVQngvWWxMeUx2dVRw?=
 =?utf-8?B?VlU4MitWUFdOcjJwd0pRR3NTREo1Tnp5U0R0T0dMMTc3UVpFN2RxNkJIWUhL?=
 =?utf-8?B?M0F2eTFkNTh4SlpPQk5Hb1ZFSzZTYW15aXduMlhSQjE5Tks0ZTYxRUFHc1c0?=
 =?utf-8?B?NkxITjF3cjM1QThjeUZQVkFHOWVDMWdiYjhmckluS2QwUGxYRVpwSDRkNWs5?=
 =?utf-8?B?azYvbHZLdS8zUlJ3dnd3SkMyd0drTmh0SE44U2VoVGxyUTRsSHhnUy9DYkpn?=
 =?utf-8?B?NnhLQkxENGlxclYxZDNzUnVuNXBTNTBTSXcrNFdRbit2ejZ3RjJkMDBCeHIr?=
 =?utf-8?B?c3pRZ1dDR3pBWStJM1BGemlnbEN3REF5WkRSRkJIMXdWUXc0S1BUWHVORmpl?=
 =?utf-8?B?VmgwREpLenluTitjVzZIN2ZoV3ZSYXE0ZW8wRFpTc0J6cDJhTm9JckEyRTZD?=
 =?utf-8?B?YmFZZ2Y5d2RyaHFITXp0Y1JQeDBzTmlqc2tlK0xMNHU4d3pwYkppVldtRXVq?=
 =?utf-8?B?ZUJPZldEM25IOVdMbTNxd0UrNHhtUnVnWnpXckZ3SnJGaG1aNmlBejk0MVBZ?=
 =?utf-8?B?SlM0NnUvV1p6SFZZUE01RWV2aFBkUGYrVkJJa0h0ajBZRStibys3dUxDT3hP?=
 =?utf-8?B?ZG40MzRVSnVmQm93TStTc0RDalhQRVFJZDM4RCt2TVY3TGZWV1VhWGNDQUFi?=
 =?utf-8?B?Y05ya1hoT1prdkwxNzErUVNRZ0NneE5MZ2RuNlV3Q3lIUG9CcSt0QUdNdlQ1?=
 =?utf-8?B?YzBBNzRSaVc4OVhOZFlDVGM2TTBGRVdUTkFOWmpiZmYwUzFwVFFIK1pwRVlE?=
 =?utf-8?B?OGNMSGFVZk9OL2kvLyt1M0tVMEdlWnl4ZnZCbU5POG1rQ3BOQVZVYlp2Vkow?=
 =?utf-8?B?SlVCd1haRXVMa1lRT1hvQnpmMkwySFJlRng1VTFUSFU1c0p0Ym1HK1FMeldp?=
 =?utf-8?B?MEVFdWM0eVE1R1VNSk1CWmlMam9FeUpNZGRVc09QZGN6UDJDQXFuK0RPNWJF?=
 =?utf-8?B?UElYc2NUai9HNUFqelJtYXNyYmpPWG85WVE1a2xGQUNScHRvLzQwOFhYMWJJ?=
 =?utf-8?B?bHYwUDY1T29FNkpqa0cyOGE4L2ZDd1Y1ZGs5K2hqZUVIenJ6aDZiOGZtdkc5?=
 =?utf-8?B?ZHBIUHo0YlFsU0Z0bFNKN0JBaUtoSGsvdW0xMDlibnBnb1Z6MDBsQXNUVG5S?=
 =?utf-8?B?dHY1VW1Xa25UZTNTa1pISS8xS0V6VWU4V3c3Ujg1RVh0Rzg3eHBiWEtSWlBF?=
 =?utf-8?Q?zj8E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEk3TmNDSHFJbllPUWUzS1hLcEhSRXM4SFpEY25RSjVLSmp5Y1F6ak1GMzAw?=
 =?utf-8?B?RDR4TjNiVlJwdTN4MmIvdXVVMlVLZkY2TDFHdFV1bkZtWXZRQzZtVWhVY1V2?=
 =?utf-8?B?Zm9iVm5IenR5SDRHZjJrNzRHOFdzRG13L0U4QU9pVXV5S2s3M1RWTjJwZCtQ?=
 =?utf-8?B?eUNSb0s3SjZFTHd5cnFaV2RTd0hFbG9XMm80TjRTWHRaVnBhaUloU05Valc1?=
 =?utf-8?B?bGVwSE50MGRBUWZ5SXF2TlVZV2tHdEV5cEFrQ2JSNUtnejJVNUNxb0xPdlNn?=
 =?utf-8?B?L3VUQjQwaThOVmtrK0NoUFVJSnRqc2thZ1VFZGFKODAwb2xSUmFvcWZEeHUy?=
 =?utf-8?B?MmhNaHBwTGFXbkJ4STMzQXB6OG5hWnhBWGNWSVk5Z2l5SWlYM0dMYlFwNndp?=
 =?utf-8?B?U2xZOWUzR0VFMFRkK3pEaGlPcXpMeUk0QmRhWElTam85My82cVBGa1VmRW1G?=
 =?utf-8?B?WExydHdmdXRWWFE1Z3FTaVMzL0xUOUU3VTR0N0tpWUoxRjdFOHJzWC9tcFZq?=
 =?utf-8?B?dFVPaUFQS1BUa1RyeGUwRFJub3hZYzVNb202cTFCakcrQUhqd3BFM2N0dzZH?=
 =?utf-8?B?MHIvc3pIc2dxWEJFQVBLQnBlMGU5ZjdjY3p4UEwrV2ZoS1dDMmd0eUZpVVg3?=
 =?utf-8?B?Qy81RHBWNVNFbHdtU0ZLdVVjazJ1ZUdvU2tqVlB4N3FEbmhTbXNQblNSOE01?=
 =?utf-8?B?ZnJsUmtNcVdEUTFQcmFSTXlFNU5OS29GT0psSjlCYXZ5NXlaVGZMekNTN3hJ?=
 =?utf-8?B?TzBBL1c3QWRJWTdBNGt4UkFWL2h0ZEpxSEg5MDlXenVjL29CMDlqWDV4RlVO?=
 =?utf-8?B?RjNUVzB1aWd0NEczYWlwZDBONWhOa0ZkZzcvTkRMRGQxekE4QWdLclk3ZTV1?=
 =?utf-8?B?d1hselJNcFBvT2ZkRzZGcC8xRERXbmFiL3U2aWx6bXBsVVJUMnRTdXhiK1pL?=
 =?utf-8?B?NXdabWhIN2RqQU14UkZ6NjZxT2FwdnJ6djBwTUlCaEFSUlNZTGZjYm9zOWxt?=
 =?utf-8?B?R2NVUmdEcG4weE12UHlPWlp4Sk1Yb3RkQ2dOc0NTd0I2R0ErbHBJVDFuNktH?=
 =?utf-8?B?V3BYdnpXdW9UZVVwSmQzVHQzVFc5QjkyakhRdVlCbkdNUFdhbUxxbHQxU2Ri?=
 =?utf-8?B?aGZkait6WjU4SFBmU1ZiUE5uaTc1SXUxVjZWQlVmUG9jeEVuUUJZbnByNlVa?=
 =?utf-8?B?dGJlb0ZhZlZMZzRVek5vaGFCUDh1aXRhWXhJa3pnd1Y4K3ZLOWVQWEt3TGlv?=
 =?utf-8?B?c01ORHB0Tmxwc0tnR294a2EyekFIRW1DZWpVZEtMSUNNbXA0NWxsU3hNNEd0?=
 =?utf-8?B?bUtCVlVTdnpGRWhuODI0WFZpelVRSm44UGMvcXJXTnB1NWVISGhaU3FYT09E?=
 =?utf-8?B?TUlBK283dmxnUkpDZjVkNG15RHdsLzBNcGE2R2JJYjFoajdBWWlWVHhaaVFV?=
 =?utf-8?B?dk8wRjNWVnVacHpsdUNzUE5qL3JjUmdHN21iaHpsT0NZTFhLYlAyM1lmVFhx?=
 =?utf-8?B?OVFiN2pGWFhxa1g0MDBQdFBwamoxMVhtcjZqQ0ZZRW5vWWJTa3NMTUV6b2xV?=
 =?utf-8?B?TGZLakJyWEY1QUUrYTBxZEg1MUJ0aEI5OHBxSzJKbnFDc0N4TGY5TkJ4QnNm?=
 =?utf-8?B?RHJMMmtPalRLRHlsUTkwZFA0NndnZjlrSFZwd0k4UjJTTC9keFlKZVlMbUdL?=
 =?utf-8?B?KzJoN2lPY3Y0S01JVEVKWGdUdktXMWJleEVuVWxETTZTbUJrdHIwSzkzZ1hD?=
 =?utf-8?B?QTJrT3hndnNrM0pMeUJtOEc1VEtqeHZpWkx1dklBZE93di9GUU00L3pxZkFO?=
 =?utf-8?B?SCtyWkJHYk9SWTlPTm54WmxGQWhRUWd4YW1YYU02bG8wNGY5TUlFVW0yR3g1?=
 =?utf-8?B?akZJdjZ5ckdzTzQyUkZ4ZnRsM2Fqejhpemw1N2huK1BGM1Nqakp1TTFHMFlt?=
 =?utf-8?B?L1V3VFhwSEtxa21jNlRkSUhCL1RFdGZlTk1uYnN1Z3oxaVE1bzdHVy9uaVR4?=
 =?utf-8?B?UWdJU2JrRzJVck9URm5QZjFlV2p2L2ZYU3F2aGJFU1dmRnI2K2w0bkRTVVI3?=
 =?utf-8?B?cVluczB0QmZHQW8xTnloNlFkNHgrWWF5SS8xRjJCSG55bTlEckFkVWNFd2RC?=
 =?utf-8?B?bTF0RVVwdXB1RHg1L3F2RlFBa2Rxa1V2OHVVWEpLTzhDbHUyWS94VEc3SDdj?=
 =?utf-8?B?RHl1dFdMeHJsWng1UGZjUDJXd2NrWUpkS2lPbXF1WGhvcHpxTFMya09QWThT?=
 =?utf-8?B?RGVNd1N1dUhtWjZFVU5NWTliU3Irc0xXRGE5ejNTWmEwd0JodnV6bkhxak1S?=
 =?utf-8?B?c1lWY0xtczFncW5Cc1BGTGIvQUZwWWIzQzVTaldSV3p0cjJVS1MxS0d1UzZP?=
 =?utf-8?Q?fgNTcTc8aSVy8CL0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 272cb2aa-3672-4dda-a349-08de5ae1bbc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 00:44:29.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjOBub0JoDrvwf3MmTentMyB1ReSr4cxgerLPYDWFRoXJjI3/TyRXHQTTcdU3TYEbDJozqv4OuhaRysvJ2C1H3pT6giiJTod+LaQFujgl90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8297
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20595-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,dwillia2-mobl4.notmuch:mid];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8B9DB7BC72
X-Rspamd-Action: no action

Shubhakar Gowda wrote:
> ACPI 6.6 defines DSM function index 0xA to Query Address Range Scrub
> (ARS) error injection capabilities. This patch adds support for this
> DSM function in the NFIT DSM mask so that userspace and ndctl tool can
> detect platform support for Query ARS error injection capabilities features.
> 
> The patch updates NFIT initialization to include DSM 0xA, logs
> supported DSMs for debugging, and uses the existing DSM infrastructure.
> No kernel ABI changes are introduced.

It does introduce new ABI. This new command can now be passed from
userspace. Can you say a bit more about why this is needed and the plans
for userspace to consume this? Like proposed changes to the "ndctl
inject-error" command, and otherwise what problems occur today with the
kernel blocking this command code?

