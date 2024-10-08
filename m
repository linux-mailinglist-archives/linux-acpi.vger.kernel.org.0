Return-Path: <linux-acpi+bounces-8626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E499575E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC9281DF6
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8F1E04A0;
	Tue,  8 Oct 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2E3GtJ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065101F4FA9;
	Tue,  8 Oct 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414257; cv=fail; b=PqgframGszgYXo/12mHcpZP4JqHe2FNJMZefDl8katc+aQKzIh32XziJxg05tWPEerxrFJrnLJXGYv8aFDVaWLEq9emIWniNCvCyrpcKi9BwuxWOJBa8UWo3YluXXJKMG+325DbPelB/NWKIPDg5htp6AuMUVDYeiNUuvhd2B3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414257; c=relaxed/simple;
	bh=MGFdg0JJpFfdJ+bKSnc5c92kfxtqBU6CGwCoFxH0Di8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2td6wFSNPWOqGdbSUr3wIKF38z5sS/46s5l6ULC1LHlb4G7Aqm5A+BaAd92p38+nPzGMMedVeuOROXjvP1tVbqmpO2aZyVcSvNFuK5JXkr81mvBfbet7KsLfARaNrtHR1QIGrKaEQ+W+xDFCUjzMVNw4BpriJNIIQrbFmNNT4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2E3GtJ7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728414256; x=1759950256;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MGFdg0JJpFfdJ+bKSnc5c92kfxtqBU6CGwCoFxH0Di8=;
  b=h2E3GtJ75tvRiek1mboWj8qaD9g6mVjvQM313fq8d3KTv+Y6Q/L/8U1/
   mWp4PjYOIjPPVPJuLYPFWkCrLZNaOS1N6YKnKrxl0IWuSReeEnk0KEGbV
   aj4zEPZGfBz8c96BiiAGjxUrEnPSkfIFsvHRADIVSEdt/RUsO2nW+1EiH
   iMMlIZPQqiJ/KPU7vwpBdnSMhRXtEQzmQKJGuzxqSJ00//N/KnsnJHQ/1
   F8udZsSDbTudcnYF70LLiru4f5mHN88ZF3AvpW+ApSIqAwXqVX8vAHyYg
   yHzc0dZJWw+26+SMNzTRLceZjMB5OmlTCCEEKW8IEAtdK344UqlQf755i
   w==;
X-CSE-ConnectionGUID: HRya8RaFSR6JnjAezgaAZw==
X-CSE-MsgGUID: xl8keekZTUqt+GeqEJjcLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="53052957"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="53052957"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:04:15 -0700
X-CSE-ConnectionGUID: tBxg3wmxRDyj6Ga5pAvGxw==
X-CSE-MsgGUID: d3+tVimSRIieqGS2EP5G3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="113418563"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 12:04:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 12:04:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 12:04:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 12:04:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 12:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuzno8qzMLFW9uoaCelO+C2/QGUsVAc8YsScO0W8Pe5MSof6Zph5ZAQIBIme3U8/ZLSZp+BNSp7Yi8JyNoEcxrdQ+vCglHBpqSPLo9fP02YQroavYvYPm/IZqIh5lvPX3uV15bznIrZdmhq/qzXnPEmhD6KC20xXt+OCWoZjvwqKkJd6IJp9Tcw/qkzamCqSRtAVVQw2bya1ccxjY5EvpBTEeMDGKI37AE9tqbqGT6Pt66X5u2W7axTTCxfwrfcEL7mWn9S79tFYmIjtJuCn+OaU5/O+fsMz0XqNu9clTkNd3xJaV8gOW1gaQCyTonu8g+K90ggEq7UhXGeoACSE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEzVbxcPvrudJn+Z6b3KEhPsMduOneUmxWD4dG8Xqtw=;
 b=wv+djyKGf//RDqysttvTQwtr+i3fsVpuAkkAFQafgwbA6aIWnnde1uPsLAkKMQz0vxLBZCm7vQ7pc7TcmdB3kM9MksSWrlbYA3q+Nnv8I0Rz7p1STRVtvzZo/WhA5AwxeUMGjywr9RwqSGc1SBGppS3ce6zTCs9U555L9dG68AH2EwWxghsImVBSXvaDEordeVivr6jHkBPGLkW0GdQfT3FJWFp/hifgVfLRTER4DifQ0DVxKdoF89L8PyFqa86lrPOkt6rd7s+nEN3+u1BwRURUU8h8BByKCWkWhOcmpx8nLbsmsWiHgxyE2/aWZYxCQpnYQlSNzL7Xh3JZXUdrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 19:04:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:04:11 +0000
Date: Tue, 8 Oct 2024 14:04:05 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, David Hildenbrand <david@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <x86@kernel.org>, <linux-mm@kvack.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>, <lenb@kernel.org>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <670582254a5db_2e172294fe@iweiny-mobl.notmuch>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
 <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4c2dcb-ebf3-42b3-488f-08dce7cbfe44
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nOHZkaejo9aSeZN0hXu9EZtmGlYoEO6ZuoHZ2mnopiOW2kkEBi3tzrkpTsEA?=
 =?us-ascii?Q?oHEr0HSb/7ti0hEKL0ngwvNEcbuBuQCr1qMcUtrfQoeurOvTxWJlRzYHO0L4?=
 =?us-ascii?Q?NYhkb4iSIc66nzL6viNdwYgD5EJZ/UOeLU4b/4xzn9jpSelLMJf7SdgH4S2B?=
 =?us-ascii?Q?dKeqbzv+jWPJ/C6DeaaCuakjBZAToPqWBq64uL6Emz7/+0j1WgMdhTPs4hjt?=
 =?us-ascii?Q?mdqDJZ3gwkJgyCzFOS1gUmNmQdswzfXssBQviaXhq1zWLDZPp1kOXU4iYOqg?=
 =?us-ascii?Q?tQ/xgdt+GA++YuINi+p/8SwhqJIX3o0VnUH5S2oDI2U9+huKmzb4ATaDSIz8?=
 =?us-ascii?Q?tCGKdS/Y3B/E82opCWhkSReSrq5qUBivUJuHINP3WGbvNWZ5Xh2ltGAFhOXR?=
 =?us-ascii?Q?WYq575JbMK8LHJEtYSUsBzwX4NaQgQ08jY6g//MU8SL+clQG1MJ3CSk99vaK?=
 =?us-ascii?Q?xX+BcgJoZNEnHmhMCI4JYCMJUppV7hBRT7pnNg/r1sRcigYr0Plqvk1mR+G7?=
 =?us-ascii?Q?4yE75vc6otdT3XbxHbWRme0I0mPW1NbF/lHH+cZ9jRjpBrOr6QtmjPx/wyO9?=
 =?us-ascii?Q?RHbC+LgL0enzFsBe9o0Zj7fEHYN8DLSSJ5ZWbG1gh2PCPrNv9a97/Kal0yjW?=
 =?us-ascii?Q?nRjnBkcGAuOfKRNxN7nSnlHa+J+VjOR0u+t8kWKuoPuennahiG8L8sIDM02Z?=
 =?us-ascii?Q?VotNG21RhtpDatqeRI1N7HRdV8oEVo0iSWs3UYvgfkvSWH0DSCvjKc9Bbkt7?=
 =?us-ascii?Q?ubaAhrusneZCTsmM7QR61KTEJNvkmtiQ2rJiJjgys/ksmAYxROa6RnEppF/5?=
 =?us-ascii?Q?CHEiHcPEVnF25WQPFPr1NlbPa0P2e+wu+OAOJxTLmp6q+5VWQFLHeEIra6Ra?=
 =?us-ascii?Q?sbkjZf3IRtKmF8RS4tTp+0bO0mPSIE4QB+auhAQlTXAJq5mY98MARUWcNNRf?=
 =?us-ascii?Q?6r9BIRt6sdUIZwasd/FU71QlIym9p2tEXTSyaJJSWYjGErtqivCEsOZ7zgZ0?=
 =?us-ascii?Q?o8cqNrC/np//d1uTgh82TpnRrFRt+ZIkcGTyy5RivvlFs6FDyvsDZMcmFpWN?=
 =?us-ascii?Q?pvW7JPklynksQH4ZTI5c2h0BgjRcX8beseM9Py347b6pk7Xq5H3i4sw0V964?=
 =?us-ascii?Q?Sg63q6mdFCHefC3mSIZq4m6sn2VBO4Wh8/gQNEr6GcRstnjJDW4DaeLDY84X?=
 =?us-ascii?Q?v2osgxcvL95v3RTNKbizhH1qImvPTtnwpdD77rLNNYo1lYS8OgyTnFtLLfUT?=
 =?us-ascii?Q?5m0iqh58L4pVk6Bnu6JN/Jx5/wQmBnICgoC2nR63xQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qQqhamyd/79UqmQNUUDhphvgQBFwc/O/W1wtp2+KxqjNz8/c8bjDnDS+94J?=
 =?us-ascii?Q?lUYBJguBHWSS8HCjfK/2FDXlSAP6kIfXiXJq61X48Y55Jr1dDtun4hridhRx?=
 =?us-ascii?Q?RnByFAqUNLjDG50nqK8CEgGHgKoz26e6kYfxJsa5OLIlMg1qDG2fX4gw7geD?=
 =?us-ascii?Q?pPtjgiSHq/60KRTiBB29ZqUFu3AEAzfMm+qco8o874PiCJIr9+OdL+vyTdwP?=
 =?us-ascii?Q?iJeIi9Z+ssV6mh5V2cm7L7FkOEUrfH5TJ3+ZrMU6T1PO9qqEP/pTlRKWQ7UO?=
 =?us-ascii?Q?BjT7/8/iSbhuYOEka7bu7KLMK0SVGsgTldS2UcsYj/vNcldi8GgFvHmK/MGO?=
 =?us-ascii?Q?Dz19+whOwdT92mvp2fQ7OZSi8aEUYGGmyvTsgza8m7s9f8FcfejlAMJkaxT1?=
 =?us-ascii?Q?HcS3W1HzCqkVmjGmPUhg+1iNkLq3FciwiyiiTw9Sj5L4FyTAA8qZxPb7rKIS?=
 =?us-ascii?Q?tWyzF/qCRBrOnkd6cPW1KZW6aKbLns1JYfWJuNtpF7p+h9gZZLC+IX1mgY8S?=
 =?us-ascii?Q?2v84tpqYVa7OuD8Rc07NFltPblNS5DxopYyp+T5IrPT/7IxFSjhN/l2r/vpg?=
 =?us-ascii?Q?IXGnj4SeFzJ16X8CzeWmyz1v9B/Yd8eclKuSARmdExrU8qYzPVhxo+Ht+IUh?=
 =?us-ascii?Q?o8RkrHVrCaXl6sZ9zk2Eb7RsCB1Z5zp6SLpj2Qtlij6Fhp69lD4tSvBL6ofx?=
 =?us-ascii?Q?mR2hS7+YtxYNgGilgqiT8MIwZPH2ieDyzR7PmiTCt8DE8VfP84KqOAJFI364?=
 =?us-ascii?Q?zYnvmgZKayO2edBjzYgT7LOkdw8QeI6TQWf6UjXE//beTRi2FcGAoB7sRKsh?=
 =?us-ascii?Q?w2CIFkJytIXHEpVTmLLjzIXU3PWSFYkR3OIJ1KBsLQ+fVNN9Z7dFOdNXWmnc?=
 =?us-ascii?Q?RMsFo2/TQYuOrAfNiTjditgpni42HFGJjPhzHmRyB+MY2vbjwU7fUJHOCXQx?=
 =?us-ascii?Q?kVKUlvBDiKHkIsk3Te3nwI1mzoM1+KBVDBXaVNFokK3WGFup0IVFQqiAR+R4?=
 =?us-ascii?Q?EJEJx7Z+UUA+lXM89h+NaMr4ba1Lq8ru9EYv45jBSMIQYAUhkdJ8hA9FoJ5j?=
 =?us-ascii?Q?2UWLBEA6RdK5gKAT0MSDdx31eutgk53UAqX9OijGJ7NYEbWDohVWcKWvHzuH?=
 =?us-ascii?Q?T1YemSwWjJYJADJbc5oyePUO8GbClPtXN5mzeXhUQgw8LKBvD5cguIa2pa6u?=
 =?us-ascii?Q?5aAMpn8TUWsH74TOmGxtfkf181F9m83SaTVBmtv4ZIN1nAp0DxUTZxUFEwEc?=
 =?us-ascii?Q?HMG79+td+2SvRfgNvXsQAqJJxnJ7a9Q44Ha3ifmvIEJnRtgXwhsXvnKmOkT0?=
 =?us-ascii?Q?nUDs8bPDFfaP6VZ/hgCCedxIDVU12nIuNdZCrunYZ/UABOk7un73R3gS/ago?=
 =?us-ascii?Q?GCQfTu93ZfxshtXcdNCb3YjJ7FalwbwWhEUO3fAhD33R0jjO1e8JrwI0xfMQ?=
 =?us-ascii?Q?+q21KD+UoHQQGGyJhOA1einVJ+/z5j4L56fpw1IjxzxWWqFJiLkpHAs0Nl/T?=
 =?us-ascii?Q?7UQ+kyJJ1PiPs5czw2ZtXlAAd9r3eoL188Auqvvy8nAubWKwwmaLvSWDJI6V?=
 =?us-ascii?Q?EKoKqbV2aqQ5uigPTTq/OWXX2XzV1WBdnF75k3N+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4c2dcb-ebf3-42b3-488f-08dce7cbfe44
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:04:11.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHvRlGmg3DbMJEbYQMYAlac6Tm4VQ6yrl3ksvG8yKFSuvx3v6H2wA8cDVxjtny126zGwicO1GLq4WgMytX9h8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8019
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
> > On 08.10.24 16:51, Gregory Price wrote:
> > > > > +int __weak set_memory_block_size_order(unsigned int order)
> > > > > +{
> > > > > +	return -ENODEV;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> > > > 
> > > > I can understand what you are trying to achieve, but letting arbitrary
> > > > modules mess with this sounds like a bad idea.
> > > > 
> > > 
> > > I suppose the alternative is trying to scan the CEDT from inside each
> > > machine, rather than the ACPI driver?  Seems less maintainable.
> > > 
> > > I don't entirely disagree with your comment.  I hummed and hawwed over
> > > externing this - hence the warning in the x86 machine.
> > > 
> > > Open to better answers.
> > 
> > Maybe an interface to add more restrictions on the maximum size might be
> > better (instead of setting the size/order, you would impose another upper
> > limit).
> 
> That is effectively what set_memory_block_size_order is, though.  Once
> blocks are exposed to the allocators, its no longer safe to change the
> size (in part because it was built assuming it wouldn't change, but I
> imagine there are other dragons waiting in the shadows to bite me).

Yea I think this is along the idea I had.  But much clearer.

Ira

> 
> So this would basically amount to a lock-bit being set in the architecture,
> beyond which block size can no longer be changed and a big ol' splat
> can be generated that says "NO TOUCH".
> 
> > Just imagine having various users of such an interface ..
> 
> I don't wanna D:
> 
> > 
> > -- 
> > Cheers,
> > 
> > David / dhildenb
> > 



