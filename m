Return-Path: <linux-acpi+bounces-15224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700ABB09333
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F317ABB2E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FE2FD885;
	Thu, 17 Jul 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKLDEHB4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143482F85E6;
	Thu, 17 Jul 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773399; cv=fail; b=l2xCBSNOFQp66staAYCW+ZSh0x2uIDVk/sw4D2tECtLW5YEYcTPhKljEabC1D3kl5qoIVkvaRVscPYSJ4VV/dH9d8s0Zi7juw+AuE46LNPz40pGCVBC+7X9X9dt9pGrI3LvtoST7LTTRteKwMUQgC4iYBrJYEGHL1juAysc2204=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773399; c=relaxed/simple;
	bh=3nLD3JhgATP56bDuTV/UMr+MubHygKLOaT2M3WaMQpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCVXIf75cEwRXCvaPVfO3iaLJmGUZ1dv5XhnX9UBwKcVH7GqW5iwkOIS+/coPkq95GurOIMZloH3B0Ld6XgS7ogbMd8oxo4lEPpU0MQSj7T1m2PwSYJN4LFG4LVoE5luOIzSRZawnhpmkHoM3x2+dGLay4EUHGinoeImTFXwDf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKLDEHB4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752773399; x=1784309399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3nLD3JhgATP56bDuTV/UMr+MubHygKLOaT2M3WaMQpk=;
  b=TKLDEHB4RNVPq3fUniF2cO+Ps6ZDVM/ayoJ+j+cSBKOke+/rBMXbwwTj
   7ebg1HQ5Vsl9B7bv1tAQn/CBFAPhW43S11GHwqAD/UeBSYY2Aonc+y7On
   ZajZX3ux+G8WOTdP2+Gq8cLRfBLdMHqeV38MHu/6/FDXtU57ZUpHDruxo
   7kJQKPHf3SZxHv0TMLJzJWBzzmNmZ42CmnibUpewV0NpwUOxasGeXYWhy
   YeGItNALDUiUfyGcFko5su6TTWzgCHoeIxUDpf6ctfnEAANDHQ3jrPbX7
   J1KTAP5NfLMKDm4XxWI/yRZslMMEASZuGXbUnA2MKpcRlT4E44p1DWhjB
   Q==;
X-CSE-ConnectionGUID: HYYQeY2dT3+gMf3JUIQyfg==
X-CSE-MsgGUID: SjI+5DH9SdycRdicC2yqAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55215212"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55215212"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:29:58 -0700
X-CSE-ConnectionGUID: Sc74yHi6RQGwHKc+3frrzA==
X-CSE-MsgGUID: tKpcAIxyRo+NU1efN4TCuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="161882532"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:29:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 10:29:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 10:29:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 10:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxDCx6/ta032kI7JrwnuE8CHml++o75nBZqjL80dMmGwwAAFlwC7nDoi6gVeld1sE9bqW9J6Lyf5qBxMXWcd0XtWvwAtaS1ZmhwgHMAzL/A4blk+Mq7EJ9X8O3+Daf9kLkWwLTciKMxoECgOUgN2jeUQYGa8R7psFieurDzADawGRHNgRdl00CxzppxPZNa1mBt3izilw8655SwhOquVYKB/p97sabm52xvdKa4I4LW+utZxr3jBvjqfgURCDHwJLjCuiMTm3dLTnF7WlCghV+nSmLHCdVlcQzRA6GeetEldu/cp5G2YPv58FA+os70t4yfUBaASG81SEly+fxDKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNIOeSiHltUaMA+Elkqxi0In3USBuSdzo7hTj8JJ2ac=;
 b=CtrenmF4MA/C3u6YtVkz7Z5MNS8aSpVmCk+xcWVgYvxOAl/EiOmTb6sudJh5Rc30VUS32sYH2w5YvPvrAtLXKARyXlBZrZ9o0q1Xus7WncoYv+5AsewDTXHUGAZ+kitPxyf+vrHs4TOrJ+L4MtvojAYMPwXji+ZJzqWXoAgcOCljavIu9ASk6ZRp4GCJkQp1SGRJBOOYazFLllfm3/JRGKJLYd3jUDv2iFKuYmklCwnixRcK/xgpujMwD5+mg4ke7LebWy8AvAmoNmyjjXK4+y1y1fi4wwssquQGlgDkxNAxe+li1xaO/Wvgpy7+8CU3VlluXTkq+TXCK2EpuuYPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6488.namprd11.prod.outlook.com (2603:10b6:930:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 17 Jul
 2025 17:29:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Thu, 17 Jul 2025
 17:29:15 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Breno Leitao <leitao@debian.org>
CC: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, "Moore,
 Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [PATCH] ghes: Track number of recovered hardware errors
Thread-Topic: [PATCH] ghes: Track number of recovered hardware errors
Thread-Index: AQHb9OBy0msNHAJLb0CCMVEuXQ5eELQx2rEAgAAFjlCAAAGCAIAEniKmgAAVGSA=
Date: Thu, 17 Jul 2025 17:29:14 +0000
Message-ID: <SJ1PR11MB6083CEAB23FCE85937DC5403FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <kw7mwmca3ir4nfyofumqiack5sht3aisdchevykdtmlio6xo7z@5xbdibpqvqix>
In-Reply-To: <kw7mwmca3ir4nfyofumqiack5sht3aisdchevykdtmlio6xo7z@5xbdibpqvqix>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6488:EE_
x-ms-office365-filtering-correlation-id: 2db34695-ae9f-4184-b9e3-08ddc55773b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GivOYypfcO1HNTEb06dhKyXGVQdDIqqlUmemuocl7xS30kvWNznObXZGTDvC?=
 =?us-ascii?Q?/xU4xscLm4cdHEGDYI+cgh29Htf6lziGo2tMLNMw1zcMHehjrFP7Xfn1ew2p?=
 =?us-ascii?Q?XvIHgJyb8OvJb/6IUnvM0mpU7rw3CAmHraxRKGwy+H6lCRT71htT72zfHS0R?=
 =?us-ascii?Q?ffnZbdjQsXlg8jH41tZCRDJqwDdvutmys7Z7GiowmdEaclC7oanbWaYf+KL9?=
 =?us-ascii?Q?2DI3V9EeqLvnn6HH6Tts3fXnoH6zjzBRhBDIA9+95kpDcsXGX+x2czNPMGCk?=
 =?us-ascii?Q?03/lZl880tyKIKhBk4mp2IQB7rgZ23e+iIHBhOaXYEzlRxAUoecjRR3e3MLd?=
 =?us-ascii?Q?7fsjthSPH0t2leQisPMI/mIHjlg4rH5cddm0LoTLq4ew3lztBXXGrQJVFd+U?=
 =?us-ascii?Q?OLTdbeZKZnE2IXhrvwzupT9h0zzAJRVHBnySPX0i2AQrLEUSHriLnfdzepo1?=
 =?us-ascii?Q?AF/dcRiJu0tCQP7hVqa0TaLCexcjA/nLsm3/M5A/eXXjG5GKop8JgoMaARVT?=
 =?us-ascii?Q?uIeE2YC7WggzKGZm0tTtlH5q6OJrqRnjvE2bX1MhghMkveieZ3Zr586FyOQj?=
 =?us-ascii?Q?OC0jZJMnpD7yuy7qN3gyDOVRccpfRayuzYGUwTrKly332lDQ4NObgHVVk+wz?=
 =?us-ascii?Q?0YUdUGyNnkGwqD14dNsZkkalxbJO0RDgaKSwYvrOJJTGeW5wUIknLdRu89SZ?=
 =?us-ascii?Q?If5ZRDoihjZwbEpEyrY7eNmZoZIvi+ImJrfoZPJnSdn6lTnE+cvfeHYuQqKB?=
 =?us-ascii?Q?mvV/D1jLKKCJ8K5+zBYCJuJxFT0MkpRZPB+KJhezdx+Yus3cWHlfiRWg/KAV?=
 =?us-ascii?Q?znFiEICWo3Ot4Orj2d/8C8ixo2XMQxn0542Yss4w+E0m8rUZHNHNoMbYc3qe?=
 =?us-ascii?Q?+Jr68ggwilm+gFgM3Ks73qobElJXQks+/mooDLJGLWeDLouldmlL+JmeCkbQ?=
 =?us-ascii?Q?trAOmZTffmV7VLEAaKI69lpyxB0POS2Bjs9DuIbUR3qJfetexYyDde+zx0tV?=
 =?us-ascii?Q?iD2XxVtXYlImOvg60jMJqerGs5EW6705/o/qcFfKITLZqLilzCEQD79/pjKm?=
 =?us-ascii?Q?spQGjZPISRF3QgkKRZiXseTjz3Z9aNna2O583NneJJ0oZjO7DMywiubuMFMG?=
 =?us-ascii?Q?ZGJGiAoO8tlPUK1irI+Vm3hyIIn2s+jF4mzNjKruWReNztyCMlJLAaaDMXu7?=
 =?us-ascii?Q?Jwnl5zTy7mNwcrlbRhQBZ75GFbzHDWi2EAst9LpjXjtgXmvAZbzeIFl+9VZh?=
 =?us-ascii?Q?fUrpnNGG7pOe59DKZ/tnq/+KNOLhXe/buNHhqJJ3XxIyfeQ9/5MPyKyCQ47F?=
 =?us-ascii?Q?9DtKW6f2kwJsm7lS0KTLcKomo/xhFhfOKlQftc2OF46dwrcNJMvJ4mRH/XtK?=
 =?us-ascii?Q?8ZohBC0Ms2X4FzQkfULDdD9vCa5LtJmi+AkYBko6V3rgnnc6J6ejYhcNE0/2?=
 =?us-ascii?Q?Q2haN8K4xg+DIN62CLo7DJtBP7npUUlUySDH0+H7s1/oTIFSAjX9oWDUMtVU?=
 =?us-ascii?Q?F61sX2uHpCJkyGE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dYkwh2GmxCNrslZ/aiSgUjnsmUnZYDN9KNEMI+MViSQNCEjbaCJFEHKWJAiS?=
 =?us-ascii?Q?0gA23aBZrwhVEpjx2zOJEwAoz2dJRjl0qKmlnxGFMfj4T7w1S5M1kDGu866z?=
 =?us-ascii?Q?EF7Jiwb3ngLAjUU5c5dOAkZ3gmXdHWHOEaWJAvVqL4jUUeM+d1+K3TxypWJr?=
 =?us-ascii?Q?wwFNpipHSyfIQBBKEPrXNrmKBLcZy2iCSzXPpvT/te9LR746GauwopnePYX6?=
 =?us-ascii?Q?H9sBrA58Gp8qECmmIAasUWEwV2FHGf4KN5Nn+UPpKdWSCkVZtHEiIzgl6FUy?=
 =?us-ascii?Q?5ILHrvWpnTWlvobXcXSHjwULGNXvI5hGmlJ4cdrFvuyYJ2VG9hQEBLVo2C8F?=
 =?us-ascii?Q?N0cd3+Pu+oCOY6eks2u6Pla0al92cT6jx3NuYoxLsxOOIWyPoJ5dnXNPGFog?=
 =?us-ascii?Q?wB3L6EutyTMlgki/Uncv7Q6Uz9MnoTCgFVy2+qRs0cMGiXRbN609Z00kwokR?=
 =?us-ascii?Q?lTkgGPCJE9KBiWFIOt5c9NWoh99bYS7zX+Kirn6NObvAH7yt/N4lnZKaZ4Jv?=
 =?us-ascii?Q?mdzGLqBmSPcfUWzj7TDK5jip/4JAwpttua7dfeGQlzmQ6iRNDclcfkkb/FLq?=
 =?us-ascii?Q?evqAJyaj6nZhMX63sV1PoM1fgc1jdYKPMQ/nPPedwwQYLj+X+uYWfL3CKGO4?=
 =?us-ascii?Q?qm+uWnAydZWHn8gUCf2QPCG+fFEWW49ANhqZy97J8krqj2aGdSOD25NjNVET?=
 =?us-ascii?Q?m75qx/Ftxx5m3wdlmKLb2xe2yCScrIWhNdRbeRB+IOc5D+1jfPqw3/7HqJX6?=
 =?us-ascii?Q?ySKYTfF4Q/ExB5asib3voXLk173A/hACeRj00+hWSjgrUomxkzTky1ek8d3J?=
 =?us-ascii?Q?/VUkvB+q9FDk7jmnhgnzhJf+JFbA0o2vQUkYtjzcFWhqigdvofwH7UFApd6F?=
 =?us-ascii?Q?9BZ8QFcBh/kK2sPR0XFypHLbmFfAmySpNxpAghXB1H6ZApjzrtJSjLNsxmBw?=
 =?us-ascii?Q?+M9j3Xnuvc/GEhe0PWpsGMs5gEhsVS9tkt6eONmlxWyCZePtxRBqnsBdnJWy?=
 =?us-ascii?Q?lz5XEQaJgUodSGA53jbNI2b6BcLmKh4fB2z0cvyAjI5fMXSMcFI3Lo6i8ppG?=
 =?us-ascii?Q?PWQ9WPk2pWhbLoZ1yuREh/CLP7foh6GS5wDg0jziaGVcZwXSEDn2vOfBXz3L?=
 =?us-ascii?Q?PKm/uRdv48R3au7oHUMwP4/W19g75W7yGoSF6GaNMV2OQkcZRg2guED6HRst?=
 =?us-ascii?Q?ybdlRmzC7zVeeHVOfcug+82pgBsXCp1qKAdmW7c2y3QaTqDIkby41CSygkiT?=
 =?us-ascii?Q?NRyR2NrtFc9lKUowXuGQatEzt1vgZxN7J+DjfIWISjfsuhYRTflfeZacRgs/?=
 =?us-ascii?Q?j+5Kj+6eEZToqf11FjgWuyMhAk6fkk2WnFFVbZ1ZfW0+17yvzspKO3RBnM2U?=
 =?us-ascii?Q?Q7VNoK5fYwnYtD7n/WerSO894njdGuzP6O0AFdwANLyLkU521wbnxIvWz09p?=
 =?us-ascii?Q?DEeNAOi8eJ5ss1Rheo9J3Ex7ddoLMYuMRH+BsVLI7Uj3FVTzeltZAA0MCIE5?=
 =?us-ascii?Q?e9e12X9S5pPm3M1BuR9eF9TaU7cE5IExKwczhyNzoXbIMaiwDDwWApIgBtnQ?=
 =?us-ascii?Q?CzWTPbAdm8LdOGoigMC9iW19aoKbkCkDhFEFtFLj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db34695-ae9f-4184-b9e3-08ddc55773b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 17:29:14.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ox/FqgOKmxVnBX/S2xcWfG/nmq/g9202B5JtPuoYMmubi0SQhbhKLFFAir7QOH5XOF/9f8cjhtb5oOgkjiD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6488
X-OriginatorOrg: intel.com

> That said, I am playing with it and it is looking promissing. I liked
> Borislav idea of having an always-present array and use your error
> sources to index the array.
>
> > static struct recovered_error_info {
> >     int     num_recovered_errors;
> >     time64_t        last_recovered_error_timestamp;
> > } recovered_error_info[ERR_NUM_SOURCES];
>
> I know naming is hard. Playing with it, I thought about the
> hwerror_tracking as the "name" for this feature. Does it sound ok?

Much better than the name I picked. But easy to swap out if
somebody suggests something better.

> > void log_recovered_error(enum recovered_error_sources src)
> > {
> >     recovered_error_info[src].num_recovered_errors++;
> >     recovered_error_info[src].last_recovered_error_timestamp =3D
> >             ktime_get_real_seconds();
> > }
> > EXPORT_SYMBOL_GPL(log_recovered_error);
>
> Where do you think this code should be? I suppose we have a few options:
>
>   1) Maybe a driver called hwerror_tracking in drivers/ directory
>     - Pro: Code is self-contained
>     - Cons: This will require a CONFIG_HWERROR_TRACKING, around. Also
>       it will create some inter dependency of drivers.
>
>   2) A hwerror_tracking.c error in kernel/ and have it always enabled
>     - Pro: This is always available, and doesn't depend on the CONFIG dan=
ce
>     - Cons: There is no way to disable it (?)
>
>   3) In some pre-existing file.

If the intent is still to add this information to vmcore (as in
earlier discussions in this thread). Then it could go into
kernel/vmcore_info.c (and be configured with CONFIG_VMCORE_INFO).

Would just need an empty stub in some header file for the
log_recovered_error() function.

-Tony

