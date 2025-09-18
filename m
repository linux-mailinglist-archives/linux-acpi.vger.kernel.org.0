Return-Path: <linux-acpi+bounces-17112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE13B86C01
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440A27E1328
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D42D7D42;
	Thu, 18 Sep 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrlNH3u3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FE2D77E2
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224786; cv=fail; b=nEtJOJ1TocWo9Iyb6UczdHLgf69pmMr8SIefn0R2W2zxd3Jjfg/jgMT72ZDsZH8BnEx5H86Q8crTNTPmb7xrTnDcZ/q34+5YZFnGrcIjEcVKaG4fAwuHOC5Y3ObYfWByomaSHEBr9M9vL2yceHc5gIE4HkY2e5XZe0Ix29pF0Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224786; c=relaxed/simple;
	bh=PbBVpXIzqCgn7CNYBbcB7zylBsmQoq7S5u1bApI3OMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KCSqkGd4wv9xuWAjbqkWHP2bOVvBgVFZCH5J0wnPFs2lx4VBTnUFd+ofY8LW4wEUX/nrr1Ydxs91NR8jm7GfW5mS47neKD+Pmr3SkHtMHd7f6eLDrb0SlgNq/fM3m+EAGXkG5soT0ydrzv72ooIuiyx3OUyP72iHtn7H1c6OvkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrlNH3u3; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758224785; x=1789760785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PbBVpXIzqCgn7CNYBbcB7zylBsmQoq7S5u1bApI3OMs=;
  b=nrlNH3u3MdwSDMs1+GLw4/VCJOw8fZr9ImVR6T0JkIY1beTp52n0GwdH
   ZOqkY0b7z5UDmBEpKj51VwLi19UT3mdfJNnhKzM9gAeoygHyY2mrLvgKr
   6hD9ukteQfcgrwbW/DaiSRCko+TQrfzzyAfpy8HBqurXVPzvlTpg/yWkj
   jW9emSm17dalUMmgnfNriI6+eHC8mRmK8NOHiAXuiIhFOiIbZJUw/oAgB
   REYxr7lPwVZLLkHuijv7r4QGolQqSvGnVTVhHCa+zmGgFN18MomS9RSKN
   M2aJPQCjyckiVgcnZOX//CFu/PwJRIjFRsZr2NJW0vDq9O7c5ZXDDhu56
   w==;
X-CSE-ConnectionGUID: 9I9M/GlMTeOgMIw5n+40WQ==
X-CSE-MsgGUID: ALPuEOFZQgSdkyY05Uma1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59789040"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="59789040"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:46:24 -0700
X-CSE-ConnectionGUID: XR6vf8mVR4Ka2Z/CKsQJrA==
X-CSE-MsgGUID: UOiBan9RRYOU4FjLeJB9JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="179914839"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:46:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 12:46:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 12:46:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 12:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz7vxFOX3bwKe01Xm9zV+sQLA3OgGup6bpHGixiwm+7+8V9duGBkBXmvlVZJASTXgdGTq12ZryOzyvdwWt4HCIO81iCcEGbgIMITiDwqLRowDF1QctmuZWEjU6hHYX+Yh2x24al2V4z9rtF/7zF7K3tfgN/ILoEzSHjK41pKY59XW47vPIr/8zcBfVVi1aggUcnypeRsppQXP1doCnpKfEFKUyceBjCGSMOUKL3e3N/7C3L9+kGTkvcXZrFT/5PSFlUN1DCzhx20BpGP1CAFUYTrGGaNhNff375RT3c6DOPbN2ojlhZ2tROz23U/KUWWLQvVFwsVdgc7+qLadvIMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbBVpXIzqCgn7CNYBbcB7zylBsmQoq7S5u1bApI3OMs=;
 b=AwYlkHys7KNIjbH95CER44uSeweD8LN57iUOWVttQKP6/TkpiPah66Tb8rbNl7+uwBnASA8GzOd3OcENvy/ibHQJYsDV+4iCKPunCmRDoa3ZZiKysj+1Drs7lxIi3HmRoK/mzPAM+SHb5Td8kumTeUf4P471jWIThM4PTyE6M8pKHeH/ZGQ8Mi0cpeDOu/T0ij17SKbMZterxnBig/GSfb20NP//3rWtCHbat2MMQWQ1yy+0AiL72Ue3v9q1bd4vOAR7jX2YQjbe28n+rhROXhpYSW3ju3A29fnTJSJrK/VsmAY3BavhAIuzmNxcJF0WUQSqpmBnbtb0ZDI2PfG+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 19:46:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 19:46:17 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jiaqi Yan <jiaqiyan@google.com>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: "Meyer, Kyle" <kyle.meyer@hpe.com>, "jane.chu@oracle.com"
	<jane.chu@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, "surenb@google.com"
	<surenb@google.com>, "Anderson, Russ" <russ.anderson@hpe.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "osalvador@suse.de" <osalvador@suse.de>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "mhocko@suse.com"
	<mhocko@suse.com>, "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "david@redhat.com"
	<david@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Fan, Shawn"
	<shawn.fan@intel.com>
Subject: RE: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Thread-Topic: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Thread-Index: AQHcHpFNghz0HBmU602rHD1MDcKklLSE/FYAgAAFkgCABKqdAIAOshaAgADKUoCAAEAyUA==
Date: Thu, 18 Sep 2025 19:46:16 +0000
Message-ID: <SJ1PR11MB6083CA92BB014F4BB02F50D6FC16A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
 <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
 <CACw3F538k+dshTs1_rxbpYoRdFyX3tLYzfaWj-_d7Lq5Dd2Jsg@mail.gmail.com>
 <aL8rIgSImDh7Nj7E@hpe.com>
 <7d3cc42c-f1ef-4f28-985e-3a5e4011c585@linux.alibaba.com>
 <CACw3F50hU3BCP=A++Dx_V=U8PKvsTvTa1=krULxfQdeK2kVBrw@mail.gmail.com>
In-Reply-To: <CACw3F50hU3BCP=A++Dx_V=U8PKvsTvTa1=krULxfQdeK2kVBrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4714:EE_
x-ms-office365-filtering-correlation-id: 0ee6ce47-2f6b-47e8-c123-08ddf6ec0867
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bWRCTHdWRm04b0tkQUpqa0lkRWwrWThLR3Rra1MxQVN6RkZtai9sVENiMUtr?=
 =?utf-8?B?bnRsS0xmZ2EvbU4rc0p5RFB5cmgyQVMvSTBFOUVETU5TQ1ZPeEpiVEpDUEds?=
 =?utf-8?B?VFRMU3Z3MHBLenh5NWczcVlNcUt1ZDk2SW5MWks5MVFYY3M5dmNhYVEzcm9M?=
 =?utf-8?B?V2xqNWFmbXNRb2FCN0hBbk1rYUprN0RHalpvV1BPTEFYNkpOMDVjN1paNi9X?=
 =?utf-8?B?Y3g1cHBpVUNqd0NoUUNwWG1TL0ZMZWRXc1h5V0RWTWZOcjBONHlVcGlNQ3dP?=
 =?utf-8?B?ZTV4VVhRU1A2bnJpQ25ZVVA5dzI1a0dkK2lNUlYrWFNqTWxxWnlhQTNBY1la?=
 =?utf-8?B?S0Jvc2FpVHZSL0p3Sm5aS21OeU01YnZ4UjBsNnlQZjI1VkVTVHNuYzFFTlpO?=
 =?utf-8?B?dEdZMnUydXlqb3dsd2ZsQlNkZ0JqM3E1cUZBYmVDSmJhTjNaQU5uMldpRUpu?=
 =?utf-8?B?czIwTlZiU0tNVlo0d0R4T1BUdTQvNFp3ODUyVzVVNXJSQi9KSk9tMzM3TmtP?=
 =?utf-8?B?Q1Fpd0xyVGdvRnhTamxzV0V3WG83Sm4vSW1GM0NyODUxWGJoTnZCazllQytG?=
 =?utf-8?B?Y29YdGNtSHNqSGtoNlQ0RmtqejFsM0ZrMml4dnV0UC82OGRrS3BRUWs0VDBT?=
 =?utf-8?B?K2hBRzh4RVZyN3FrTjkvT3Y2WFNBS1k3MGJBMFkxTitDRldkT0x0Y2tHTTM2?=
 =?utf-8?B?d1VZQVVoS20zOUdFODdOdEppZGRLU0l2Zkt1bC9UZGg0Tnk1SUZqSUxJczBp?=
 =?utf-8?B?SzBXdXYraWVPTXV3Y29vemFSY0laVWZkYlRRbFBhbDdjTVJ5eUhabVJIOWY5?=
 =?utf-8?B?N3czQU1KbGdJbEhWWlFmOVNvc3RxUFA2RndOejFTYWdKSlFyR1J4ZlkydGxh?=
 =?utf-8?B?UllRRnJDOWFkb2VhUzhha0JJWEZtY1hWcndiUXpYVHlWcURINlRYb0ZhZVRS?=
 =?utf-8?B?ZkRaczFSbTk2Nm9IeHB5Q3pzOVJnY014WExSWFZBYjBDK3hJUUtocUZSNnF3?=
 =?utf-8?B?dFJQUFp5ZTB4YVNFcjhVT0JxRXQ2eVY4VlZ4VHRJWTRIL3J4aG1WcUEyY1Bm?=
 =?utf-8?B?VllDUUNOcEwrRFRpbVNxcElCc1RtaTI3OTlFV0lLeUdyWGN5N09IcjBrbURi?=
 =?utf-8?B?dm5JMXFiTUgzSnhndjdRWnVkb1E3RnlOVmh0cUd4MWlDRGtqNGxEcE1pdk9q?=
 =?utf-8?B?c213N2krTDd3MzU0NS82c2hRcmpPWUJud2pLeVFuREJNNXE0SDBaL1lWVFZ0?=
 =?utf-8?B?MW14YXlGT1Q5VDQvWitDRlNIRXZ6eXEzRDFhbzRKYmJ1aFhpTEV0aEZvQnRi?=
 =?utf-8?B?WG5EdnMzY29SajNPY2tXeTJDa3MrYjJmTXFjRUd2QU1WNDVyNUlCL0JubTNx?=
 =?utf-8?B?SGQ3YldDWWNmanR6RXN0NS9aUExQOXBvVEJJYS9aS2dFZDNlcm1xbXFyU2sz?=
 =?utf-8?B?bDNaV1hIQnhINWhRZVJUL2w2TVU0SVdpdC9aNCsxSFFXbTdpNWRsL2tWTlM2?=
 =?utf-8?B?SVZ5MXVsUDZ3VlE5akN0Q0JrSUtjK0pMMFlxYVgrQXNxMUFGQlg3Y2lKRGlj?=
 =?utf-8?B?aUpkWWJ3T2tPcFdOQ29RUHkxK09ycWc1elBOa1JkQ000NTByVXdNSDV5RmNh?=
 =?utf-8?B?aDdxOXFUYkZTWisxcFBEOVpONzJaK08rcGhhUjVxYjkrSEJRdnk2MlowLzNY?=
 =?utf-8?B?MzZDWEY4dFdZVC9BQ1p2MklXUGprU01oa1F1ZkxVbTc4a040UTVFaVd2b3dh?=
 =?utf-8?B?b1prUkFCN1pCd0E0NkYyNzB2VENqYlM2Z1BlNkQzdnl1bDU4eVQ2N2NCeEt3?=
 =?utf-8?B?azJTa1BxYlBRWlUrQTBRTjNvM01WNWhBcGtlQkduOVYyT0pBaWFHSmdCQ3A0?=
 =?utf-8?B?aGtIUit5dXZvd0wvZGpMdU12bmZ5ZElTc0xZYUV6YXZZeTFUeWdONWlzY2t1?=
 =?utf-8?B?Q1JkYjFoRW44ajFUUVpaSllxVDBTTDJYcFdKYU05OWQ4WCtkSUJheHpUM2lr?=
 =?utf-8?B?Y1FMdi9OeEF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzljREZqZU1mcm9NRkJqOEljZm4zTmNBcmlnMUdWYzFVaW9DL3h4R0dhMzIx?=
 =?utf-8?B?ZDdjRXNOSnI2SVllcUlhVXVEa0JkNXVoYVhnbkJ0MEtFM1BCek1zbnRTVFhk?=
 =?utf-8?B?YUVnV2d0MnhTbmdLZHYvV1M4SlIxMVlNcWlNQkdOTjU3U2FpNHNNanpYRHdo?=
 =?utf-8?B?emZiYk4rczJPMEh3Slh4TFBtWXRjei9PU2ZPdGpVQ0NIVkF3S3UwU1ZxcnJh?=
 =?utf-8?B?NE82VC8zaGFVWk1VNW9uL2JQZzFLRmFPalJpLzE4aTE4WGh1L2hFZHM3VHNl?=
 =?utf-8?B?RGtRaDYrUkI5SkpFNEVoK01iV3V3aDdhVm9oQkVKTEllcTVsVSs3RlZ2YzB1?=
 =?utf-8?B?TTlia2RnQ0FKenNGQkI3M1Q1Q2kreXhmcTNlYkdDb0cvbGptMmp0ZDIxZStB?=
 =?utf-8?B?aVh4WmNyK3oyQXlrTXc4ZU4xd3JRKzlsN0xtdURJd21FcVhNTTBVUklUWTNW?=
 =?utf-8?B?WXlzL1FLanY0TXcwMEdVYUE0WFZQa1EvZnljelRZcC9RUHZwaVk3VUJYY2dW?=
 =?utf-8?B?RkoyNjFwWXBVY3dLcUJrT3pZVDVMZlBuVXZxOFNUSjk2MDJ5WlYvdUpMTlhX?=
 =?utf-8?B?d2VGQi9PbW9ScTZPejZjeThuYzZiSmhPWGVoR3U3eFVyNUJ2NTVDamFrVUJ3?=
 =?utf-8?B?T0hTTmxxRzRVUGZKblNuYUlVOHNtN3FaeVVSRWcwWEJtVFFXVkxoMm1UQzVp?=
 =?utf-8?B?YThzU3BwTWFQV3lBMTl3MnBiSTBtcjZxVkhHbm5GbFptQmw2ZmZDOVVaZTQz?=
 =?utf-8?B?aUlrbkFPMkQ5dng2UmdUN0FSY204MThaWktCQnhUeVBiMHAyWk9vclE1T2RJ?=
 =?utf-8?B?TFkxL3Boand0bHNka0h0Uy9UVWVmZFVZVFB2bmw3SVRYMzFaTTA5R1A4WHJE?=
 =?utf-8?B?bkRDeUhXRUdxUkpiWWMyNlFzNmJTSDRkU1ZiT3N3TGpnZTUxd0Q4UGlnVVV6?=
 =?utf-8?B?R3VGMU1nU3N6OGR3dVM2Nk1Ed3ZNdExQN1ZhRTRzMXFkNXUxY0tMRStDY1B3?=
 =?utf-8?B?UC9tbWk0and4aExRamI3TzYxSDBRamZMUVUzRTlsenRMSGFaSVArNkM2R2Vw?=
 =?utf-8?B?RjhVM3pYT0FuZFgraFlWV1BzcDJTVDFSQ2dhNElvMVNPUWdSb0ZxcFVEamNy?=
 =?utf-8?B?VG5OVFRmVlRZU3luZVZocTFSYnNHaC9VL0Y5c3lZb0FEWUFlaGZlaGt0Sm1i?=
 =?utf-8?B?K3R0a1d2bGEzaFFuY0tTREIwY1A3U1lSY2hzVTVlb1JDWDlFOEJxZktHUGJ4?=
 =?utf-8?B?NEIzdnFET2xtVVFGUEJBdk1INUo3cCszbFpmMFczcTYvakVpbWZBZ1NwR3hX?=
 =?utf-8?B?SzdUOElSZHo1K0ZQMlJmeU5CNURJNFZzT2JWdmw5NHZzemxTVkVHbjVpZHk0?=
 =?utf-8?B?OUxTeVJXN2FqZ3hFeHlCdi9CRTRCUW01NXdoeWVzczg4UXJqaEJiVnZkVDQ2?=
 =?utf-8?B?ZjhsbGhFT2pKd3k5RUpuWElCMnFKVjMwcE85b0hZaDZBcXZQeGdQRWpIc3Q2?=
 =?utf-8?B?TENmaFlYMExiSmtoUmlpclRvd1JKWVBmS3E0UUVQQzhXOTNHNTIzcVhuL3NT?=
 =?utf-8?B?bEN0RGllWkpacTJOZ2xqOFYwWG9RWHdPT3MzWHVROVMwbVAyV3dyNnd1NFlv?=
 =?utf-8?B?RnA2eTZ3UEZZRjhOS3grNTJCYUVXeFJCMCt6UVpRaTFNS09KUlU5Mytwdnd3?=
 =?utf-8?B?OWZCemE5VzVZYzZRZVFYeE5Pck05VXErY0tHRmQzRW80dS9meVN1WFhoMDJX?=
 =?utf-8?B?SXdoRGpqNXl4ckFPYklzOVRtbkRRdjdYU1JHaG9FWEE4TzdaSnFvdXlrdmhF?=
 =?utf-8?B?eWM1djhoeTh4VUw5cVVNN1JhOTJXc0ZmNWJzalY5c3NiNXN4bUQyRE9ncldP?=
 =?utf-8?B?WkFXOFhTNDdXc095RVdybnJERXJGckRUR1NuT1VRTUZVT0E0dXltdXJGSXl4?=
 =?utf-8?B?SXNjdDZRdVNXS1ZnVlcraFE0dmJtWXZidlF1Q1hMWDQwL3BSWEh5ZTJCTjl2?=
 =?utf-8?B?c1Z0eDNubXdsRHg1MjJ3MDRpTmtscmVKcXB0N2NyR2MyM3RtdGxPK3o0WjZP?=
 =?utf-8?B?OXB1WElWanV2MjY2aDgvSFdMSGlxemduNnArMnFtdlJLYWY1UitCWGpNUEJZ?=
 =?utf-8?Q?MAQ8+FMPuHXH/zI3QrHmtq0px?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee6ce47-2f6b-47e8-c123-08ddf6ec0867
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 19:46:16.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1EYAp6aEi0y+7kR2EjDgExWcswQuGm1xhEsZ26t6LGPDIjxxBfYqqoQk4YheZ69n2R6k2dHtWrmn7EDt7hKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com

V2UgaGF2ZSBtdWx0aXBsZSB3YXlzIHRoYXQgc29mdCBvZmZsaW5lIG9mIG1lbW9yeSBjYW4gaGFw
cGVuLg0KDQoxKSBCSU9TICh2aWEgR0hFUyByZXF1ZXN0KQ0KCWEpIE9sZCAiSUJNIHN0eWxlIiBC
SU9TIGNvdW50aW5nIGVycm9ycyBwZXItcGFnZSA9PiBQcm9iYWJseSB3YW50IHRvIG9mZmxpbmUg
YSA0SyBwYWdlLA0KCWJyZWFrdXAgYSB0cmFuc3BhcmVudCBodWdlIHBhZ2UsIGxpa2VseSBkb24n
dCB3YW50IHRvIG9mZmxpbmUgYSBsaWJodWdldGxiIHBhZ2UuDQoJYikgTmV3IEJJT1MgY291bnRp
bmcgZXJyb3JzIG9uIGxhcmdlciBzdHJ1Y3R1cmVzIChyYW5rLCBjaGFubmVsKSA9PiBQcm9iYWJs
eSB3YW50IHRvIGlnbm9yZSB0aGVzZSByZXF1ZXN0cy4NCjIpIFJBU19DRUMNCglUaGlzIGlzIGNv
dW50aW5nIHBlciBwYWdlICh3aXRoIHZlcnkgZGlmZmVyZW50IHRocmVzaG9sZHMgZm9yIEludGVs
IHZzLiBBTUQpLiA9PiBTYW1lIGFzIDEoYSkgYWJvdmU/DQozKSAvc3lzL2RldmljZXMvc3lzdGVt
L21lbW9yeS9zb2Z0X29mZmxpbmVfcGFnZQ0KCWEpIG1jZWxvZyg4KSBBbHNvIGNvdW50aW5nIHBl
ci1wYWdlLiA9PiBTYW1lIGFzIDEoYSkNCgliKSByYXNkYWVtb24oOCkgU2FtZSBhcyBtY2Vsb2co
OCkgPT4gU2FtZSBhcyAxKGEpDQoJYykgU29tZSBvdGhlciB1c2VyIGFnZW50LiBVcCB0byB0aGUg
dXNlciB3aG8ga25vd3Mgd2hhdCB0aGlzIGFnZW50IGRvZXMuID0+IE1heSBhbHdheXMgd2FudCB0
byBvZmZsaW5lPw0KDQpQZXJoYXBzIHRoZSBzeXNjdGwgb3B0aW9uIHRvIGNvbnRyb2wgb2ZmbGlu
ZSBzaG91bGQgdGFrZSBpbnRvIGFjY291bnQgdGhlIHNvdXJjZSBvZiB0aGUgcmVxdWVzdC4NCkVz
cGVjaWFsbHkgZm9yIHVzZXJzIHdobyBrbm93IHdoZXRoZXIgdGhlaXIgQklPUyBpcyAxKGEpIG9y
LiAxKGIpIA0KDQotVG9ueQ0K

