Return-Path: <linux-acpi+bounces-21374-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKXvFcTIqGnhxAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21374-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:05:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A220954F
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A96B3024533
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741CB640;
	Thu,  5 Mar 2026 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/KYy2pk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F93A55;
	Thu,  5 Mar 2026 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772669121; cv=fail; b=Tj6WueKAh8cfT8r/tRKC9rP9w5VPk3UFIzRLVYzME2VpTUaZHGnjWvzU6zdN9s/JuM9sP1TRCDchvu1F0/4oVLA6f9GX3YmeV9Hm/tjJyWvrMXKC0Y56gpJ5tQsfKN9irFbQoSqD1yA5Pd37AnoPegpv77xqBDqxZk2U09cMUgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772669121; c=relaxed/simple;
	bh=x1owhxkrtsLESOVXkW+QDImRFpXByaMCda9u+6GDxNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GjLIGrUNmQbXg3uN9VqsKdiveYZ+JDuJlRrScgle3t1x7hVY250cHMcal+XP/X414jB7WvwVDeRQXyU+H/drHyCvwga4FG1GYMdygb258p3Dbcuniwu1RZotziPTCWE1iOfWO6hAar2jb/AAsJU/E4JijzIx9ToklYwgsIpRIWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/KYy2pk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772669120; x=1804205120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x1owhxkrtsLESOVXkW+QDImRFpXByaMCda9u+6GDxNw=;
  b=l/KYy2pkYRiRiBRjUqxSVNHbQ1v8qHBC7LxVFRC3B9Mx1WKVOVhP/4iE
   bF+izPryYUqojO2pjRd+sDtMpoN76Uu1YUl/YU05vH2yKBfIk28xtmDkm
   Xx+V+5s0MFSFkdIIw7fTwcDYTktwvLjg/7XIcLgtrvg23VUaJizBn7vCi
   3lYPwaPqdDrMCSR2cNJVrde9C/4D7w9N29BK3GBryX/Rl2nEsILeZT3FB
   z5yr3NILpiIMpc0aPSLalA1UeqX6g5G7VWTkfthg4KzSkzvwPMoIe86bD
   VVjLluv4YI2kJEweVLd5Y/moXzReFHo/BylMFAEt4UXzDqq0cAXb9u3nr
   A==;
X-CSE-ConnectionGUID: ifyTRmYoRKu4vkfxKTIceg==
X-CSE-MsgGUID: DDx2jkXWSYqpkO37wWkBTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="85216474"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="85216474"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:05:14 -0800
X-CSE-ConnectionGUID: V3pb06N+SomYPyJOZbr83g==
X-CSE-MsgGUID: W1M9ZJY9SaCDTYAe7s+hQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223168564"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:05:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:05:07 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 16:05:07 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:05:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1TpZeOFW64GHorWMMxfM6IPOH/BOwYGtKnHFxRt/xhaichmnPxl/HP31C9x7TQ21leO9ehquJOtjw/vDK5XDlpXMAkTlTgG7Dzkdvm13NpnZx8MJWEwsQJPqcuXqqic1d1fwOBSh4n+Blp9CL4kkx9B4asLPTGRsVXAvG6JwHx1x7LYXfVC6RN2wuAg1z/Txw8t9HOXlG3iB2s0z4w8QiNKaB7721u6MSYXjuPGE/kvy/8FU9eTaxfnn2BpiSPxBYfZ/gM5qpOsrpuRHwOXqDKucEGkjrUKjWPp5gHwU7wJycohuE0WaLuDyU0VEYvEXGeE5TVrUZ+3RWRz3G4s9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1owhxkrtsLESOVXkW+QDImRFpXByaMCda9u+6GDxNw=;
 b=ooua9R1QIdeurBa1FFPDozldl56sEC+4R9eV/E9iJOhRXELbSYbZ82hK4KoMWcULDhILJOaEeRFz/k5q+Nuh//ll9MruwSoidxmA4hUSabpXj3JvFUN/yrpUr6qkUYCU7s2pwVYaxqiBy6F7Nivx1cMPI3b+a5coysizLFho8S0O7JoJk6kZNX+ff67dW5oS0QN0ZHPJGDH0l5ERaK8LmEPIiYGiHa1aCUTSJDE5XmEePBG5GLhTAcaoiU2cMfJJzyeElQWhLRQEdrJRxfDErVE87a0lZH16cbMgVR3nCKAHt1hctMEgAu8LqoWQQB3v24pwT3jQfoO75wzCyk7psQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 5 Mar
 2026 00:04:58 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 00:04:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Schofield, Alison" <alison.schofield@intel.com>, "gourry@gourry.net"
	<gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Topic: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Index: AQHcrB6hFMt1tftCWUOUCZXHrNvLJLWe9ZgAgAAND4CAAAx6AA==
Date: Thu, 5 Mar 2026 00:04:57 +0000
Message-ID: <acc37740d0d7fb2bdf12f181028addb1eea2e169.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
	 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
	 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
In-Reply-To: <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPF9E162731D:EE_
x-ms-office365-filtering-correlation-id: 21100c67-0406-41d1-9b77-08de7a4ad69d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: Y1FB6ihyit3ACEPT8uFTEw/rYjyzMMPeidW9MjjZFZo9uUxpsxSMgS9eYn27unifCZf7qvV6ZqXuw2K0FmD9VQq/du476/kA4tarjGOElbIAwcGwXyfpxaaZ+thZpvlvH9OlBt3aaU9Sh7u1qYuW15G5gug8rp9Rq2S65UkVruylX5mUpxZxvXZAoSOk1Wp0Rl3mw0tRawa3YOHFTm5HVSFQfCUAkp39eK8B2G5ZP3X+XXs08vJYJ5rXbK/NzdHxoV+RSftA6KGbdRpxBIvZbTdUd1zj/6A9S+XF315+GOVCxd48bPfBIXOqzQ4UwsQIbb3rZHQYJLqTwLaERyNWiK570LKlrTFfDemAeIApmzIaYvWnv24SeHw/2ZYN22qqvNJJUzEDoqH6qP4uWMyzptN9iuv+L6cTPyl19vVPHgfFm6cjpvU+NuNfupkCbaX98Nele6IijuJ66uOpTbJG+rZ4APoBlk+f6617tpX5tV63kOKg7hVy1IBXZ0f4HPI6h/OWtpT8l6qgPkL+tLC5a8/dRMV3I7f1Ou/VUUyKaHcsv10PGQzlloPR8F8T0WwlcpoWWR/Qfl4gYJwAyROuhhFsHJEsDckXSHIj6UqdguxSrWI8ke8qaVgY1gXhaj1uFIYHxM9S/OhKRu0QJQj4egvhkMGDV99ZyDV6NQDW/hjGsx5bCxkq5jq9vZRKNS6oOdOMByK1Ky+WoSj0OlygomTaQhhoZu6/VFeioIUAVgM0MfVqyJCpFr/MbntPV31d+zhBKni6ptnXUO1q3VP6I2ePAw+7T8/L98cAJOGCtyI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm5LLytjQW9XeEprR2RVYWNYUk9ia3FYTDZsM091UU00REo1RnlpQWNTYkJH?=
 =?utf-8?B?eFBMZG5jVzVNZU9wSmdLbndqVmo0ejh3d3lWTnRqRERwK2thZDhGSzdUUzhR?=
 =?utf-8?B?eTBqZStKbFJVb0ZESkxxR2RndTVJOVZ3b0pSQ1ZteEZNR3pPQ1VGMENKeFlJ?=
 =?utf-8?B?bFpQSzUxTE5wVzEwYnBwc1BrOWhKSy84NnFwQnZDSGpwbHllOWhiMmxrVCsz?=
 =?utf-8?B?U1dXaXdSQ0I2eUhSb2dmbm93dWFPbVNSY3F6R05vTWJVRWNmY2REdkk1eWk5?=
 =?utf-8?B?SEJyb0dpYTVpcHM4Ym5QQVNOKy9iZmY0emdSV0tZS3lEdVhScEZnWnJYdmk4?=
 =?utf-8?B?eCtjamFzNlYxZUQwN3RyUzRNZFVnSGZ4UjFWbFNLQXVNVTVZZlRZVzc5UENV?=
 =?utf-8?B?Um1jdlFEcG5yWGkvK2NreHpSUWpLa1c2c2tyRmpiaVF5OUpJNFVnUEExL1Zs?=
 =?utf-8?B?bGdzcU5MazZJSkU3UFFiMXptMWJxZS9rbVVzUzhEOFRHWHN6UkFyemhibHRq?=
 =?utf-8?B?MklOd3R3aHlubWFQcWR1N3VGazdrV3BOL1pLY25walRHYUpCUXlPZjU3Q1U4?=
 =?utf-8?B?NHZCQ1lFVVVzUzVnaUltU0dXWWpmc1ZmNkp0ZlJzTFNYZTVxaEVrcGtIS2xP?=
 =?utf-8?B?VmZKTFNzZ09QN2JWR0d5SzJKWHlaVzIybmVOVVd0K1NGSWpkMVdNVHNGb2Fh?=
 =?utf-8?B?WkV6STVhZXo0Ym56RmhWZlFab2Z6YlhBN0xHSGdWakJmdTdRd2pObVRqRGdQ?=
 =?utf-8?B?MjV5UXN2MGhzclVpcXhnSUlDTGtZaVdINGNWQUh1VDhtV0U3eVB6ZHl4MXZZ?=
 =?utf-8?B?VHR2OWlZcW1xSW42UGdNUitHQjV6T3hxSnNBSGgzQ3EyZFRCMzRiaE40bUdZ?=
 =?utf-8?B?OUNIRFBEOG51ZEp3dVF6dmt3YmN3cEVGOXIxMUw0MnJQOHNta2NJTU5TRDJ3?=
 =?utf-8?B?eCswTkgrcFVOVUkzTnpocllrZGNrR2lZS0ZCSXhaQm50UVhWMGVSVkk0Nk04?=
 =?utf-8?B?NEI4K0pFM0Z6bS9reS9PekFtaEw5NkdUSVNncW5zMWR6eEJBUVBVeTZWT2t6?=
 =?utf-8?B?NTZuNXFlU3RrVWJPeXI4UjB2WEVZb3FhN09CQ2V6UE8ya2JHdmdzWVBFZXJY?=
 =?utf-8?B?dDN5Qk9tbGhOQ296RHRHUW45TGVFS3hsMExPTUlxQXJRaUFQS2ZnejNKeTZl?=
 =?utf-8?B?NGlwV3dIWFVkSGJyQ0kwWGtNWUJYTndIeWI2akhhNnd4NW52WE5OYXN2SUpo?=
 =?utf-8?B?K1ZlK250QXdHYzEzaUhzTGFabXUwd1lTT1U3ak1KY2JkNEk5RGhkbktwaTNa?=
 =?utf-8?B?dlFtWkt1dnlSUkVzVUh4WUQwWmJHTFJDMWtseVRlMkhJZXlPK0RocFQweGpr?=
 =?utf-8?B?ZSs5T1kyOElkR3k3SnVoRlpnZTg5V090YkQwWHlBQnk0WTFuaUZTaHpudDRS?=
 =?utf-8?B?V3cyVW9wdTRaSEVWMk1tQ2x2RFFZMlY1VDZaKzVJMHNybjh4Z3dyMnVJYll6?=
 =?utf-8?B?VjhlczlaSnpLL09IazJKTlF1VXN6QWVhcmUzeHFQWGNjbk5mUnZoRnIxT1hx?=
 =?utf-8?B?eThqc1NQT0xZbDZvYUdGSm1hQlpKMFRmKzdXcWIyRGVZS1ZWcUdrQXdLS1BV?=
 =?utf-8?B?TjVSZGFtOEdiWnNIL0FVcy82a3lORTZ3eUxnUG9nKzEwL3E0VjhRZk1ERWhj?=
 =?utf-8?B?ODlFSkdlN2xHamp2MFR1aWVXcm1HTkQ2M3JvVVZuTkR6Wm1UOEpLOVR3MHNs?=
 =?utf-8?B?SFJxTDZmRlhyVVhOUkwySDZwb1lMRWg3c1V1aG9ZbTR2Y2cyb3MxdTFUSm9r?=
 =?utf-8?B?bkxjSkFoMWliWEVSOUNKZW9vZXV6TzVSQWNMM3FvOEJXRjhtSHhNSkFIMkgz?=
 =?utf-8?B?cmR3Y28vTm1uYTdVbTNmS1FOak1aNGRySnFMRW9CRmZCSTRtSitRam5zNGxp?=
 =?utf-8?B?Q2ZFUkNaYy9mMXdmVlpNd0hHNkRlbVUrdTU3dDczd0tPR3p3RTQ5WU5CeVMr?=
 =?utf-8?B?K3J2N2FFaEdhL0lJWDdtYzNtKzcxcy9pYjBGMVNaTG81czhMSEpuZXFpMmRu?=
 =?utf-8?B?SDV0QTJhUUg0UjZsbk9RRC8vNzBBRE9Tbjg2RkpEUEd0K2xOUEJMbXBlZ29a?=
 =?utf-8?B?ZkNmTVNwenpPcTcrVFd3SXhsMnRKb01vYytXUkNuZXd0Qk0yVmcwRGJjRU1l?=
 =?utf-8?B?VnNUcEJzUm9GMTJQMGsxZko3ZlBTNW9vU011cE1WQThUNks3cWRTREtsN0E5?=
 =?utf-8?B?UzZrSTVGSTJHOU94ZzVWM2hZbFZ4ZzN3MFBsSW1NUExZRDE0czhEaDFvTTVo?=
 =?utf-8?B?c3hJSStOcGpvMmR5S0JmYUN2c1hTQWNzQTRoanFmcnk2alJjMTNSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F4A331546BE874192EA2ED5DA6878F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21100c67-0406-41d1-9b77-08de7a4ad69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 00:04:57.9827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Lmp2uGzioc4MJh+z/K5r/1JsP8jhelDYzjmVRlrfc0paSDusx0L2PNCqCEQHTba34QU6OeJaNowZoV0dw52YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: BA7A220954F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21374-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDE1OjIwIC0wODAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiBPbiBXZWQsIE1hciAwNCwgMjAyNiBhdCAwNTozMzoyNlBNIC0wNTAwLCBHcmVnb3J5IFBy
aWNlIHdyb3RlOg0KPiA+IE9uIFRodSwgTWFyIDA1LCAyMDI2IGF0IDEwOjMzOjQyQU0gKzEzMDAs
IEthaSBIdWFuZyB3cm90ZToNCj4gPiA+IEluY3JlYXNpbmcgdGhlICducl9ub2RlX2lkcycgaGFz
IHNpZGUgZWZmZWN0cy4gIEZvciBpbnN0YW5jZSwgaXQgaXMNCj4gPiA+IHdpZGVseSB1c2VkIGJ5
IHRoZSBrZXJuZWwgZm9yICJoaWdoZXN0IHBvc3NpYmxlIE5VTUEgbm9kZSIgYmFzZWQgbWVtb3J5
DQo+ID4gPiBhbGxvY2F0aW9ucy4gIEl0IGFsc28gaW1wYWN0cyB1c2Vyc3BhY2UgQUJJcywgZS5n
Liwgc29tZSBOVU1BIG1lbW9yeQ0KPiA+ID4gcmVsYXRlZCBzeXN0ZW0gY2FsbHMgc3VjaCBhcyAn
Z2V0X21lbXBvbGljeScgd2hpY2ggcmVxdWlyZXMgJ21heG5vZGUnDQo+ID4gPiBub3QgYmVpbmcg
c21hbGxlciB0aGFuIHRoZSAnbnJfbm9kZV9pZHMnLg0KPiA+ID4gDQo+IA0KPiA+IA0KPiA+IElz
IHRoaXMgYSBMaW51eCBpc3N1ZSBvciBhIEZpcm13YXJlIGlzc3VlPw0KDQpUaGVyZSBhcmUgdHdv
IGlzc3VlcyBhY3R1YWxseTrCoA0KDQoxKSBvbiBteSB0ZXN0aW5nIHBsYXRmb3JtLCB3ZSBjYW4g
c2VlIENGTVdTIHRhYmxlcyBidXQgdGhlcmUncyBubyBhY3R1YWwgQ1hMDQptZW1vcnkgaW5zZXJ0
ZWQgQUZBSUNUO8KgDQoNCjIpIFRoZSBrZXJuZWwgdW5jb25kaXRpb25hbGx5IGJ1bXBzIHRoZSAn
bnJfbm9kZV9pZHMnIGV2ZW4gQ1hMX0FDUEkgZHJpdmVyDQppcyBub3QgYWJsZSB0byBkZXRlY3Qg
YW55IHJlYWwgQ1hMIG1lbW9yeSAob3IgaXQgaXMgQ1hMIHBvcnQvbWVtIGRyaXZlcg0KY2Fubm90
IGRldGVjdCwgZm9yIHdoaWNoIEkgYW0gbm90IHZlcnkgZmFtaWxpYXIgd2l0aCkuDQoNCldlIGNh
biBhcmd1ZSB0aGUgMSkgaXMgRlcgaXNzdWUuICBCdXQgdGhpcyBwYXRjaCBhaW1zIHRvIGltcHJv
dmUgdGhlIDIpLA0Kd2hpY2ggaXMgYW4gaW1wcm92ZW1lbnQgcmVnYXJkbGVzcyB0aGUgZmlybXdh
cmUgaGFzIGlzc3VlIG9yIG5vdDoNCg0KSWYgQ1hMX0FDUEkgaXNuJ3QgZXZlbiBlbmFibGVkIGlu
IEtjb25maWcsIHRoZXJlJ3Mgbm8gbmVlZCB0byBkZXRlY3QgQ0ZNV1MNCnRhYmxlcyBhbmQgYXNz
aWduIGEgJ2Zha2VkIE5VTUEgbm9kZScgZHVyaW5nIGJvb3QuDQoNCklJVUMgdGhpcyBpcyBldmVu
IHRydWUgb24gYSBwZXJmZWN0IGZpbmUgbWFjaGluZSB3aXRoIGFjdHVhbCBDWEwgbWVtb3J5DQpp
bnN0YWxsZWQsIHNpbmNlIHRoZSBrZXJuZWwgc3RpbGwgaGF2ZSBhbiBvcHRpb24gdG8gZGlzYWJs
ZSBDWExfQUNQSSBpbg0KS2NvbmZpZy4NCg0KPiANCj4gSUlVQyBCSU9TIGNyZWF0ZXMgdGhlIENF
RFQgYmFzZWQgb24gdGhlIGhhcmR3YXJlIGl0ICdzZWVzJyBhcyBwcmVzZW50Lg0KPiANCj4gVGhp
cyBwYXRjaCBpcyBkZXNjcmliaW5nIHRoZSBjYXNlICh3ZWlyZCBhcyBpdCBzZWVtcyB0byBtZSkg
d2hlcmUgd2UNCj4gdGhlbiBib290IGEgc3lzdGVtIHdpdGggQUNQSSBhbmQgTlVNQSBlbmFibGVk
IGJ1dCBDWExfQUNQSSBkaXNhYmxlZC4NCg0KV2hlbiBJIGZvdW5kIHRoaXMgaXNzdWUgdGhlIENY
TF9BQ1BJIGlzIGVuYWJsZWQgaW4gS2NvbmZpZywgYnV0IHRoZXJlJ3Mgbm8NCmFjdHVhbCBDWEwg
bWVtb3J5IGJlaW5nIGRpc2NvdmVyZWQgQUZBSUNULg0KDQogI2N4bCBsaXN0DQoNCnRlbGxzIG1l
IG5vdGhpbmcuDQoNCj4gDQo+IFNvLCBJIGRvbid0IHRoaW5rIHdlIGNhbiBibGFtZSBCSU9TLg0K
DQpBcyBzYWlkIGFib3ZlLCBJIHRoaW5rIGl0J3MgYW4gaW1wcm92ZW1lbnQgaW4gdGhlIGtlcm5l
bCBldmVuIG9uIGEgZ29vZA0KbWFjaGluZSB3aXRoIENYTCBtZW1vcnkgaW5zZXJ0ZWQuDQoNCj4g
DQo+ID4gDQo+ID4gSXMgR05SIGV4cG9ydGluZyBtb3JlIENGTVdTIHRoYW4gaXQgc2hvdWxkPw0K
PiBOb3Qgc3VyZSBvZiBhbnkgbGltaXRzIG9uIGZsYXZvcnMgb2YgQ0ZNV1MncyBhIEJJT1MgY2Fu
IG9mZmVyLg0KPiBJZiBCSU9TIGNhbiBjYXJ2ZSBvdXQgYSB3aW5kb3csIGl0IGNhbiBjcmVhdGUg
YSBDRk1XUy4NCj4gTm90IGNsZWFyIGhvdyB0aGF0IG1hdHRlcnMgdG8gdGhlIGlzc3VlLg0KPiAN
Cj4gPiANCj4gPiBJcyB5b3VyIFNSQVQgbWlzc2luZyBlbnRyaWVzIGZvciBDRk1XUyB0aGF0IGFy
ZSBvdGhlcndpc2UgcHJlc2VudD8NCj4gPiANCj4gPiBBcmUgdGhlIENGTVdTIGVtcHR5PyAoaXMg
dGhhdCBldmVuIHZhbGlkKQ0KPiANCj4gV2h5IHRoaXMgbGluZSBvZiBxdWVzdGlvbmluZyA7KSAg
SSBzZWUgdGhlIHByb2JsZW0gYXMgYSBiaXQgc2ltcGxlci4NCj4gV2UgaGF2ZSBvdGhlciBjb2Rl
IHRoYXQgdGVsbHMgdXMgaWYgdGhlIENGTVdTJ3MgYXJlIHZhbGlkLCBldGMsIGJ1dA0KPiB0aGUg
cG9pbnQgaGVyZSBpcywgd2UgYXJlIG5vdCBnb2luZyB0byB1c2UgdGhlc2UgQ0ZNV1MncyBzbyBz
dG9wDQo+IHRoZSBwYXJzZSBhcyBlYXJseSBhcyBwb3NzaWJsZSwgbGlrZSByaWdodCBoZXJlIGFz
IEthaSBoYXMgZG9uZS4NCg0KWWVzLiA6LSkNCg0KPiANCj4gPiANCj4gPiA+IEUuZy4sIG9uIHRo
ZSBhZm9yZW1lbnRpb25lZCBHTlIgcGxhdGZvcm0sIHRoZSAiU2xhYiIgaW4gL3Byb2MvbWVtaW5m
byBpcw0KPiA+ID4gcmVkdWNlZCB3aXRoIHRoaXMgY2hhbmdlICh3aGVuIENYTF9BQ1BJIGlzIG9m
Zik6DQo+ID4gPiANCj4gPiA+IAl3LyB0aGlzIGNoYW5nZQkJdy9vDQo+ID4gPiANCj4gPiA+IFNs
YWIJOTAwNDg4IGtCCQk5MjM2NjAga0INCj4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgaXMgYSBnb29k
IGVmZmVjdCwgYnV0IEkgc3RpbGwgcXVlc3Rpb24gdGhlIHByZW1pc2UuDQo+ID4gDQo+ID4gV2Ug
ZG9uJ3QgdXN1YWxseSB3YW50ICNpZmRlZidzIGluc2lkZSBvZiAuYyBmaWxlcyBpZiB3ZSBjYW4g
YXZvaWQgaXQuDQo+IA0KPiBJIHRob3VnaHQgc2ltaWxhciwgYnV0IGZvciBlYXJseSBpbml0IGFu
ZCBzdGF0aWMgaGVscGVycywgdGhpcyANCj4gI2lmIElTX0VOQUJMRSguLikgd3JhcHBlciBpcyBj
b21tb24uDQoNClllcy4gIFRoZXkgYXJlIGVhcmx5IGluaXQgYW5kIHN0YXRpYyBoZWxwZXJzLCBz
byBubyBoZWFkZXIgZmlsZSBpcyBpbnZvbHZlZA0KaGVyZS4NCg0KSSBhbHNvIHNlZSAjaWYgZGVm
aW5lZChDT05GSUdfWDg2KSB8fCBkZWZpbmVkKENPTkZJR19BUk02NCkgaXMgdXNlZCBmb3INCmFj
cGlfcGFyc2VfZ2lfYWZmaW5pdHkoKSBpbiB0aGlzIGZpbGUuDQoNCj4gDQo+IA0KPiBSZXZpZXdl
ZC1ieTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb20+DQoNClRo
YW5rcyENCg==

