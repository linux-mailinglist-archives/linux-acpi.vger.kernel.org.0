Return-Path: <linux-acpi+bounces-20491-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI5tIacRcWlEcgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20491-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 18:49:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC815ABE0
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 18:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA7EA5CAD95
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34332F741;
	Wed, 21 Jan 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgdoqWl+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8E358D13;
	Wed, 21 Jan 2026 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013326; cv=fail; b=kuvLrAN5qlybEkxDsMF1V2VsTjl1RL4y7FdlJOTwV6ofo2pCIXVNPwuT33fwBtfRufWkBPvoag01sZLxy2ssgeH4tiXalJ+gZeVvhHpDfaDhqZwdJRbVgGYfo1JzRhi8dlQrUvJ8naUNCN3lkZBtwd91ddZpAHk0dQhfbrMJE6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013326; c=relaxed/simple;
	bh=bu4fVle16mqo/+hXTZdBLYE/N9gM1WpCxszxMhqtzU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cK/e9/Qmvedw05Q9ESsBGWxxoIXouOg9zEUA6nOThWgtbOyQHaSazb0Yh/TgwzemZPkhJ/0wSNbEJb6K6SDlxb7MCN4SVitqHd4q+q63afDuRtkvSM0A+FgebKZTDErQuqo0+smb16rqro/YTiUwJJ9pZsyAdP/JFCedsavqaUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgdoqWl+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769013325; x=1800549325;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bu4fVle16mqo/+hXTZdBLYE/N9gM1WpCxszxMhqtzU8=;
  b=jgdoqWl+LayMDMHOYqBgSxX6XeR57q8UNwgGvi0N9Qe154GcsPeJb2rY
   0lGx02Y7X7NiOpgw+Y/LJIn81FnFkul9QmV8GpplNYQ0zNB1559iBh4I9
   7Fl/D++7v4Jafxm7y+Nl4i4DBpP1aeF2orHUoy9bIgsEAj7BMmt3ZXNzW
   Ht6SaZ7xDgg+MmwdXxKYqsbtvJn6NKVzv9Gqg/sB+Oy5ohG/j10P+AUEy
   4zqjUfEEfZTDR5pXlp2QQZYgaIf0WAG+ayUQaOCKcFK3OR/2CEShUCdSH
   Ndg7pPBGONUIxkEr/EsV2590/r38c8ntrGLOut1xVUYnPQvnIJ8FxqxcH
   w==;
X-CSE-ConnectionGUID: fVDb8DQiQjSj7kuLCW3xTQ==
X-CSE-MsgGUID: xqaTQe+GRMytd1F+82qVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70214933"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70214933"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:35:25 -0800
X-CSE-ConnectionGUID: OkZvYMMRRz6LVv+EGVpbUA==
X-CSE-MsgGUID: /5bc8bdEQw2QRxb28h3tyw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:35:23 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:35:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:35:23 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:35:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IETcz3xzBgbT5sahjIv5Uy/iBNu6BggTrVB3yAroiaZBXN2LqNNETqRw6WCd5CEo5+6eoR1UuiiOoxaxjnDWkR95y2nbWOPugxNtor3W7TeGqCyjNHPitdgG+22Yl93m+rqb4jcrQByneim64lQeAbnq76e1aTujw7AOjBkCZjjOPDju/UDjyovssvTKVImLOyWH+wGjy6c4cawMfwXAkGTWDPtVlGqfe/EW8Qc2ZmI6XeDu4SkWANK5wmuOjI13aEvLOkNMZoOTo4HHBBuq83TjVqA3B83bzq0IskFXt7NioW5Nh7V7ppERMQKmnl3haTLbaYHJF9wMMOe1g/M+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FsZHgxx2FW1kY4+Wb2AJRuhhCMtz8ZFVnBx4Prq3Go=;
 b=w2OLf4yCrn6aZhqlXyXIRyYjHiCKfq1PBrasyqEkfjWzTf/AuGE0RCVLkUCKL4Tx9TmDx9Yz1dvngFL08xk6FDvgcRnRjVO0N1wUClvbx9Dwqtik52CtVmAsSnh6wz/ZG3sYsSqoZFGrKAQpEoisN0BpBstlJQG40hEb/y98CUhiyYkVEDbY33x6MMtVlM0/rQBugGcXXVufomoCzhKACBn5jedoasDXa8hXGXTfupA28EcABjiBvDOVnk1Fkq2H7Xz2XOmvq7RKWb1TRH2/n71rmDMTYs2aXFvl7wNxOo0k52cmx1AyZX3xcA+58FUCgzW/cDpTiGYUncALW7G+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF99D0888FA.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3d) by SA0PR11MB4671.namprd11.prod.outlook.com
 (2603:10b6:806:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 16:35:20 +0000
Received: from DM3PPF99D0888FA.namprd11.prod.outlook.com
 ([fe80::45b4:e171:6f5a:9f19]) by DM3PPF99D0888FA.namprd11.prod.outlook.com
 ([fe80::45b4:e171:6f5a:9f19%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:35:20 +0000
Date: Wed, 21 Jan 2026 10:38:30 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Shubhakar Gowda <shubakargowdaps@gmail.com>, <dan.j.williams@intel.com>
CC: <vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shubhakar Gowda
	<Shubhakar_gowda.P_s@dell.com>
Subject: Re: [PATCH] ACPI: NFIT:Advertise DSM function 0xA (Query ARS error
 inject capabilities)
Message-ID: <69710106617df_1c608f10033@iweiny-mobl.notmuch>
References: <20260119184438.19942-1-Shubhakar_gowda.P_s@dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119184438.19942-1-Shubhakar_gowda.P_s@dell.com>
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To DM3PPF99D0888FA.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3d)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF99D0888FA:EE_|SA0PR11MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0b65ae-b185-4551-da47-08de590b1141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVR0MXQ5WHVtMnZORCs2b2M5aFVZMnRWd0MvVHV2dkNPZGorellyT2lYbnVM?=
 =?utf-8?B?Y0g3L0RxNTZESU0vR1BZQk90UUIrQmhjazBGS0VuREdFdkFBY2daQ0dndmVj?=
 =?utf-8?B?VVQ4UzVSRHdTNlFwL2NuaWhVeU9MN0U0elJvaHcxeWVQajUrZEF3UW4vM2NV?=
 =?utf-8?B?RGx2aXhwQXU5RUNjU1BnbVk0aXN6bkVtNERFSythL1BtYXhBUnFtTVBrUU5s?=
 =?utf-8?B?NGVHTExZWjAraVJlaS9JNTFyK1hQTCtMK2FHbFJSNm5WVGJNZU1UcEFsbmxs?=
 =?utf-8?B?dGtJTzNNMDFoNDBXMUppZ3JJTGpDUU43cUk4RWlZM3VKa29MK1MvU1crdTha?=
 =?utf-8?B?ZnNBbzM0bktxcEVoQ0F0R3dQSy9QMG4xTGdIbWZYMFJWRk9KRGZrKytCQVda?=
 =?utf-8?B?STFaNXhkcGJ2TG1tMm44TzhZcXYvdUk5eDI0NmJ1M3F1bDRyS01FZzdLcWJO?=
 =?utf-8?B?blI5citNQm1UVjA0SmZQTTd4S1p0dzRrSGEwcUltS1ZUSGpmUXVmaThCMnZQ?=
 =?utf-8?B?Nmw2S3FCSVpsbEtRZTYwanloeGlFVlRmdmRHay9wcXdmTTFaU3dua0t5SkYy?=
 =?utf-8?B?NlpUZnJqMVBEYXpHcjZTdEFhTHB3MEVKTmU5aVF6TEdrVWFSYS8rMS80Z2xn?=
 =?utf-8?B?ajZXMXZxckNibzFYK25tRVFtYkVxdXcxT3hEbFAvWGlFSldHTzUyT05ySlhH?=
 =?utf-8?B?QWFNYS82ZkJQTllrajVITkpVL0lvajFiRTBPQUNiNVhQWElaS1FGOFdiU1ZC?=
 =?utf-8?B?NlBQTlBISW8yNzd5amo2ZFFUUEhSakZVUytHVmZtR3M5cmNrUW9XOUwwR29R?=
 =?utf-8?B?elZ6ZldTKy80Q3FnQzlldXY0NGdNY0dHcFlEVTBzMW1RU0dBU3piWmtFZFFj?=
 =?utf-8?B?RHU4VjFTVm5GQlBFSXgvTFhiTTNzay9idThFRWtNNTN2aGRQQldCQkRSVklQ?=
 =?utf-8?B?dlVFMjI3bGdGZWgxS2diRkNEMTJRZktYaDFtV0VucS8ycFoyRUlNNTIxOExa?=
 =?utf-8?B?SC9RUlNTSmxGd3IwZnQ3YlQ4SXBqaElsSTFrS01oUXNkL29zVnpOdHZGQm16?=
 =?utf-8?B?NXl5WFpTbWxSdXJoaXpFRUl0QWs2UUQ3bEpqbzBqMG1lMXYvRk5lZkt0eHZM?=
 =?utf-8?B?Q0Z2Nm4ybzNyaWhabWE0K2tDZzdmZU93U0VxL09uc0RPMDI1SE1MVG9UeTBN?=
 =?utf-8?B?em53U1QzRU1rZW9CT0RHMzNxWmpMM0dEZkxaZm9YbEdmOGxySWxrMXdCVFdp?=
 =?utf-8?B?blZ3VEdPVmRvcjFnNWNoVVBzaHhFMzR5OWxPTUhtN05jL0JVOFBvTzFpUzJj?=
 =?utf-8?B?UURmLzNweEhWVjR5d3dWL0FaamxCdzBaemowK0tRWVVUTEkrK2s0QzlFVDhu?=
 =?utf-8?B?dnQ3bmNUR2lhMm1jTTZvYTlEbmdyUlFoV3pQSHJJTVJ3NkJCMzJTYlNnMFdG?=
 =?utf-8?B?VXpETnVLbnJnRk5HVUFGSUxSOWdEckFrWkdxUUd2Qjd0R1hKbFBKT3g5dzdw?=
 =?utf-8?B?cTh0OUtkK0hnZmtFazVEL0pTRytjN1J2NjAxdkV1ZjV0V3FWUHgrWHZ1eGsw?=
 =?utf-8?B?cWJwQjVaMjEzUml2R1J0aWpxWlRDTmpkKzVhdjlxcUMxRW40NHRwcWhwYklF?=
 =?utf-8?B?SEpsam1IYW40VWp5cHV4Y05mZnFiY0llTlVrVVNQSTJ3RnRXeThIeGRxdDJs?=
 =?utf-8?B?QWlJSkN2YzFlaWVqbi9HRDZ0Z1E4K3piTFNBeGJMdmw2akUxZE43akdxRXBP?=
 =?utf-8?B?L2NQVW56VjM4eDBITDhpbDRCNjNBQk9pNTRGVUsrUWVGcU82Q3RIaVdZR0gv?=
 =?utf-8?B?Qmd0ZUZzdW9HZGJ6Ly9YMUptWW1FS0g4RXg4Vkw4RncwV01kVys5c0RtM0hm?=
 =?utf-8?B?cnBTeC9DVHpDMlozOWxOQzQ0czNqdXFGTk40VytpQkRPZXc5T3B6REJzQ2p2?=
 =?utf-8?B?Zk5LWFF5cFFLbEx3clpXYmp5RzBXc25URmdBMFNlOGZaZjJwV3J3THR4R2k0?=
 =?utf-8?B?MzM4N3NxNjAyZW9nRzRBeVo3bWZ5cVM0MVJXc3FMVkRBQXNaQkh1RmR6WHdD?=
 =?utf-8?B?Q0JSa3VXdW4zM2xkT0hSTytyWVkzNWp0ODJVaEZ1MUJTSWZobmtwNnhadGE5?=
 =?utf-8?Q?BZac=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF99D0888FA.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21UL1QzTzFYb29saGNmdmo0K3hpRGdwWmVxbitDT0N0a2FJT2kyUWF4RzYw?=
 =?utf-8?B?L0RFRk5YdkNKbmZpWTRBUllkT2Q2dzI5TXF5ejFicFhUUU9yaVNIN0R3TmUz?=
 =?utf-8?B?NEwxNmlXR2g2cXBhcGkrK01uc1JsQXNZRTE0V2xrMFp3ZUNaS3FKaUZtdldR?=
 =?utf-8?B?MXg0OWJzSHhoM3pWTmNMSUl6V1lDRzBwMWNubENKdllPSmtFS3NVdloxWEtZ?=
 =?utf-8?B?SFl0NHRqdzRyNWM4bFNzc1pvdHJxa1E4S1JkalBKRnMvelNwUmRmNDFrQ016?=
 =?utf-8?B?VEY4WWFmMVREbm9vRWthZnNGK3JPVlhqbk83QlVYanNXZlVnTjdEeGQza2U5?=
 =?utf-8?B?SmxiTERFV3UxRjVZZEEveWNsT0duRkdzMWwwMkcxYVB1N3VFbklBM2dBZFpi?=
 =?utf-8?B?VDgxSVBCQ08weUNhYjcxUG5wUnRuN3FUSzJ5bjhvRHZNeEF3dXFvWWlicUFM?=
 =?utf-8?B?Vk1vZmRNWHJvK01iZElWcllTWFVXMEY5SUNUbkFTQzliRGJtb1E5Qy9raFBJ?=
 =?utf-8?B?QzI4N0lYYUVMSkdHZnY5N1JLUDRQOTEwK0k0YUhYN0NHUXJqTE1OZmh3R2Er?=
 =?utf-8?B?aFF4QXVjSjlPTHFXVGhXMlBsVS9tUGpyQ3pldVRMSUxlVGNWZUdsZUhaYVpH?=
 =?utf-8?B?YzRJeDBiSVUyQjZhR1Z5MEQvL2NqNnJSUDJEcTFFSGVNUzdFaElCeTlTcWVv?=
 =?utf-8?B?d3puMGJLWlNQVjdISlJGQjBPTlp4UWc3V1hQZ01MLzkxNmh2cmwyVGlDY3Jp?=
 =?utf-8?B?Rk55aklTVWxXbmp1RXdXOGNJZnpZbkRxSnBYak1UK3grZllOaGhlYW50NlJS?=
 =?utf-8?B?L2dCWGd4Ry81RVhKZ05xazdxMDdKWDVTcmJnWEsyd1lZZnBUTDRTdkVZL0Z3?=
 =?utf-8?B?SWJTdTZjQUtpc2tZSHo5Z04vRE53UlIxVTRJdlJ3L0tLK0VJNXFZdnRqc0cy?=
 =?utf-8?B?WDdSUDA4SDdxTFYwcEdrZjVWS1cvakRyMTNmQlAyeVdoMVJyWFc2cjI5eGtn?=
 =?utf-8?B?dlBQWHB3cEVTN2I5MWZpV1REVVFkZDBiZUgrSTYvZGJvUDlyMkNWc0xTSGE0?=
 =?utf-8?B?TDlJRjR3SFplcUVSdExkc1dSTy9FWXFITjhISkxuT0ZWa1VGa0h4WkREWUNq?=
 =?utf-8?B?SUtobHRvdEYyRmZwT0UrMDRma29sWmlmdkk2dUpBYzg0RGlHZW5WblpOcWdy?=
 =?utf-8?B?R1VDZjc5eGZrTk9OeVJ4U2RRMzEyMkh1MWZBaVRPYWZWZndJc29DeExqUDYz?=
 =?utf-8?B?RVdZdmhXLzdSS1dIWHMwdUM5YXd5WVc4czI3SlI4c1grZUV5dkltTWQ1YTZr?=
 =?utf-8?B?czgyK004SHUzQWJDcHJBKzFYMkd6cHd5c3hNOUhzOFZHSzl3SW1JT0ZpNlFK?=
 =?utf-8?B?dDdhVFhWTG1HangyRFA2TkdYdXhkNHdkM2lzUHYvU1JrVXNvRVdKUnlLRnh0?=
 =?utf-8?B?dG96K3hVVkc0R3J5MTJNcW1VVzBKdVVNdmFNSE1PMlBOK2hBT3JEYUp5SjNQ?=
 =?utf-8?B?K1R6UFdjYzc1Q0gwUmNXenhBUE81MWd6TDc0ZEhlK3dncEI1bUtKWEJqUXdP?=
 =?utf-8?B?YzBFUzE2aGlZMnhNQ1pENFFXOVcxRjZ6RGlnZHNhbXpPMlpQNjArUXdZYnBp?=
 =?utf-8?B?OFRiU3lVdEtqWTdZeHpReTN0NWExRDE5a01JSkNkelN2VUVCa3RCYXZmQmpp?=
 =?utf-8?B?Z3g3QXBSajJQcmFaRTUrUHVGVVRuN2pxU3BHRW5Da1dLelFUcGVQeHhKTjFJ?=
 =?utf-8?B?SksxT2dRYklXa21lSG9YUTFEenViU00vdWV4SjRuYkNkYUFzU1E0ZGhwZ3Jk?=
 =?utf-8?B?QTJqWDFuTk1hTHJ4elZPWW8yUW96MU8rTHBkbDI4ampZd1UwazVVUUl3T3VS?=
 =?utf-8?B?QmJNelVLdnJQUzE3YXFXVUFWV0FjVzdXbXV0YUlOSFYrMnZBNHpYR3J1TTF0?=
 =?utf-8?B?b1kvRU4wVWhJQTZTS0szc0djNGhQSjN0UEZPMTBXSFJkZFd5RVlyWHJTMU16?=
 =?utf-8?B?OE5pZmhqTjJyN2R1eVhlbWxuOWpCalVXVW8wc0hwRXdUd1RSZlIrR2c5dmVq?=
 =?utf-8?B?Y3VTWTFNOWljbzhSOElSRzNtM3R6QnZ5SlhEKzcrTjZMR0doRVdFM0x3OTVN?=
 =?utf-8?B?YmN6QjdKOHltV0pDV0hjL2hMaE8raXBFNjJidEZ5eUhTd0YzOEhkZHd2N3VO?=
 =?utf-8?B?Y1lBQXQrL2RnZmFyMENRY1kwbzdJSDBFV1RRcEpnNDZjK3NVNHhnQk0wU2x2?=
 =?utf-8?B?ZXNDMGJWdTZyb3dPY3VsdHhoZ1ZQbHhHeVp6OXAzVXQ5RGZIODNJTGpQTm1m?=
 =?utf-8?B?WHhzRGY4blppZXB6Nmp4TnNtc0s0Y2RpN1FFbGpFY0VlS245VnFSZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0b65ae-b185-4551-da47-08de590b1141
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF99D0888FA.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:35:20.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lun7V5bps6LNqeHs/QU1lzILI0Q7nKQI6pliUtWwJk/jQUVY5MXyKybjlCD245tdvEduF3KFEp6s+XFozOA21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-20491-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ira.weiny@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EEC815ABE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Shubhakar Gowda wrote:
> ACPI 6.6 defines DSM function index 0xA to Query Address Range Scrub
> (ARS) error injection capabilities. This patch adds support for this
> DSM function in the NFIT DSM mask so that userspace and ndctl tool can
> detect platform support for Query ARS error injection capabilities features.
> 
> The patch updates NFIT initialization to include DSM 0xA, logs
> supported DSMs for debugging, and uses the existing DSM infrastructure.
> No kernel ABI changes are introduced.

Is this a duplicate of...

http://lore.kernel.org/20260119181824.15408-1-Shubhakar_gowda.P_s@dell.com

?

If so why?

Ira

> 
> Signed-off-by: Shubhakar Gowda <Shubhakar_gowda.P_s@dell.com>
> ---
>  drivers/acpi/nfit/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5a1ced5..6cc863e 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2113,6 +2113,8 @@ enum nfit_aux_cmds {
>  	NFIT_CMD_ARS_INJECT_SET = 7,
>  	NFIT_CMD_ARS_INJECT_CLEAR = 8,
>  	NFIT_CMD_ARS_INJECT_GET = 9,
> +	/* ACPI 6.6: DSM function 0xA — Query ARS Error Inject Capabilities */
> +	NFIT_CMD_ARS_QUERY_CAP = 10,
>  };
>  
>  static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
> @@ -2152,10 +2154,13 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
>  		(1 << NFIT_CMD_TRANSLATE_SPA) |
>  		(1 << NFIT_CMD_ARS_INJECT_SET) |
>  		(1 << NFIT_CMD_ARS_INJECT_CLEAR) |
> -		(1 << NFIT_CMD_ARS_INJECT_GET);
> +		(1 << NFIT_CMD_ARS_INJECT_GET)	|
> +		(1 << NFIT_CMD_ARS_QUERY_CAP);
>  	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
>  		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
>  			set_bit(i, &acpi_desc->bus_dsm_mask);
> +	dev_dbg(acpi_desc->dev, "NFIT DSM mask detected: %#lx\n",
> +	acpi_desc->bus_dsm_mask);
>  
>  	/* Enumerate allowed NVDIMM_BUS_FAMILY_INTEL commands */
>  	dsm_mask = NVDIMM_BUS_INTEL_FW_ACTIVATE_CMDMASK;
> -- 
> 2.43.0
> 



