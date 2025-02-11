Return-Path: <linux-acpi+bounces-10984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8DA2FEFF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B067A257C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531E0134B0;
	Tue, 11 Feb 2025 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aql4CV1Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB079C4;
	Tue, 11 Feb 2025 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233290; cv=fail; b=deC6YtiiPHPKSs5YYBThHs7nG6W5CZaZOT77IPf/6j/6cB1P3FMeHzZ9+PDPJe0jAm847dGBg6TdgSCQH2Td4zl3xLd1sOZVzmVNS7TdttzzE6n4UTRcbQJbOYx+kHpQ8pLxSnWSFwZlGPDfItLIylOZuS9vEyE7ZxzM0pzk4bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233290; c=relaxed/simple;
	bh=i1+X1RLbvHjkXwN0jLeQ+tg8pqCsM+OYf34reWHk0CU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LRMMQ98HZwyM/4GcbzTfW+nlJs4QYnjjrfdfRm+UUR9KCB3o4TPGN+jG7xNeJsuB7w1rBi0d/MYJGMXaSGpM2Zcqt3hCIaLvwoBqMQbL8aNfEFHXdG2eWoJribJq0DwAD0eacDGiLK0mzejD8SeaZLXePtb1RGFqPh2yYyn6OmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aql4CV1Y; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739233288; x=1770769288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i1+X1RLbvHjkXwN0jLeQ+tg8pqCsM+OYf34reWHk0CU=;
  b=aql4CV1Yb7/Pix10KEIzkdN7WFgUx9/ljsMNe92YEDgHs/2C3WkNTWlj
   DXLcj/eWzXc8Xq3iWHnPpTkCDnJdJGfBcP4Y6MV0KBtnKq8SizlSOsCHC
   NQLIBHw7ybaKpHhRp9oVpadmEjF3Gd6TvPjYiNeEYhEnxoVYn0H5YhzGL
   ItX38Y/NJtAeJbFni3Au1K2jU0Fo6tYG2Zc+6QDA8sYWgXPpIkULfs7G2
   NAvsOlgQHX/Q3IX6a1/L0gUXyCQAPTjyZ1NkGVoR0nZTjzcvl9xn9ABQ+
   9xhWFQFyaoLdLkbNGvAW6C3L3H+ZQ9HhYXviKleP8wrHBD3lOjDvflCNQ
   g==;
X-CSE-ConnectionGUID: tGAc6Qw6TpqA67G1XpauwA==
X-CSE-MsgGUID: ctbDy0WXQqebBeTXk76I0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39955555"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39955555"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 16:21:28 -0800
X-CSE-ConnectionGUID: HHhuxzi4TmiGEMbIar/5Jw==
X-CSE-MsgGUID: uhJuks0RSsCRS4SjftreCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="117377498"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 16:21:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 16:21:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 16:21:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 16:21:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3dn1oLZBb8mKdv+ZxcZqpNxgGZ+RbZaA631iHMPSbtHpyuHC+tRQ8HrnqdAwkBS0b9/MrXq1vDskm38pLKoqLzyP4nr2/bF5X+v/G61HOwlL5F7Trb4gfQEl4zb+f9K//tMj0cKm/9uR2Mn+Fg1VHrIHXB8lo0CdKnY+Zj/PfW7XBPgaBwvIQMG+ObxdGC1ITortsnt3AhWtEZ31jBCPGNfGGXIpWzG2gV0u0VblH54S90Ogs1VWuMkOyrg50N0MiOAh/4kCwUnm1YrgBVpi9+Tg+uKfWLKxvUcT2aanjltR9L3JGJS0sNYG1U/Vnvdate8ClsntitKAEc3xWBejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aUTeqryfP1eusLZ1vu5vZUnTpuOnWXa4kUPhXv8SoI=;
 b=WMLFtiX+IGbCkhgMCq8VeyDNygMB0fQpDK7jbLKf7P/C3gfgLj02IewFrRmHmG3x9HjHnVrW9/W09wvCnNDQG1+otZ0Q67BCwhXOmHSegzHjNWMnT+lH7A6cZc3AqrEpIrYs22PJqKQygd4UGxfDikZ9BZWBt6JQUUSK/7vC2SEaVAfuJ2gjS8DvPLvHO8qpt2bVqon5CTyOxf3Gk7+FgBWm32gxq2BTAuBMFA8OpFBfyk7TacOCcRakt9kuJONq/Aj8ySjscxxa2skg6FaxLOTDSD0++JyiQ8TaYGPi5Wo5hgLx8PtTGvPX1vnynRhp9ZhuwY7JVT8OOj+uGEpF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 00:21:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 00:21:24 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "David
 Hildenbrand" <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Danilo Krummrich
	<dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] ACPI/MRRM: Create /sys/devices/system/memory/rangeX
 ABI
Thread-Topic: [PATCH 2/4] ACPI/MRRM: Create /sys/devices/system/memory/rangeX
 ABI
Thread-Index: AQHbfACBkCVzY5mAIk6HkDaNGr4TMbNBPRXQ
Date: Tue, 11 Feb 2025 00:21:24 +0000
Message-ID: <SJ1PR11MB6083FF509571697CE3DB280AFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-3-tony.luck@intel.com>
In-Reply-To: <20250210211223.6139-3-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM6PR11MB4529:EE_
x-ms-office365-filtering-correlation-id: d0a76927-a6e3-4c60-d7f2-08dd4a320483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?T3oerO8V3s+bLonqhNoSZbX+Z5QqymvFPJeAK09bUjmEHtgf0vxDX6LKMsWa?=
 =?us-ascii?Q?NRThX8VaR/+78BHzRk3ESxGwtFv/QQFd4LfWeSd7lMztDqhfYEIbXIo++zyT?=
 =?us-ascii?Q?+H0TATsrwMEsgZAAYDVgg8ejqqglkanT/4ipqlTJkVJEtxb76XVQxI22qOmr?=
 =?us-ascii?Q?P4wTuC4a7K+GDVjszd7VteVqrbiZjwYNfWmfsG1D+e4wzktLngKxR/oto5iu?=
 =?us-ascii?Q?3yVPRt+dQ/7AZLALOmQKGFjodSuZT6MSdFWLE9KPEXClU8FYrpZjZv1rnrYy?=
 =?us-ascii?Q?bqoJfb05Hc0MGzpbiVhUGCb01EVTrfNeESNcr8V4kP9NOQDi2C1P73bfPH9Y?=
 =?us-ascii?Q?5JAOcAHP0LGNavRk2Nl0TVe69KfWaT9pKreB8WoySpfc5VoKxKXQLcq7uC2Y?=
 =?us-ascii?Q?tU5r/jFlY69FdlC6jLferhyw+TNuK/8ujLhz6LD69MXcmN4gmbQvWc6AMBZU?=
 =?us-ascii?Q?of+WqnZLwX+En3j0TmL0gw/LIrO+NkXhhbBhCwRjamgCYmmAjFRFfDlKlvjy?=
 =?us-ascii?Q?BCPCsmM8kgh8WrOK4B8nKsEBimxu5DvTSNQ+HuHG3uN5y0ybhzpf+lWOXgMF?=
 =?us-ascii?Q?hcpM4SvOi7SUysUNxZIPQvtCwfnlcX9Q1hCGYTSbQZtwO7mkF1pdb6pbUYh8?=
 =?us-ascii?Q?1AI+xMvkES2WOP36PYhl34EXL5Z7RmQJY6cplrumdar2uMAHAfabmyJuxI0u?=
 =?us-ascii?Q?DxKxqdD8ZB+MjuVmY0J915fyoqMndEjxQs3bHGWc6CfbuNifDkj/1tCVwdlY?=
 =?us-ascii?Q?bbhm0qk2En91rGVrOVVXKRfQC3qmMG6wV6Aw5Xe55l8LgMB6eX8UadcrjbdD?=
 =?us-ascii?Q?oEaQoBYZr/4gxvjeEEXXMIrcYn7Lo4g9ExOmRB48Wg2Vr0FAatPw4NKVRRZN?=
 =?us-ascii?Q?AioOh2FBkV3nWnxr6WqSsVaN7olWvPeeemd+zHEXQalEQQIGLPXvDgNgpeCK?=
 =?us-ascii?Q?QBQcmERT0B7Nb+ffmJzbwKZo9PfldnBQvlviKItqaOqzN1khfwKZ9KRvk6MM?=
 =?us-ascii?Q?sqUajqayEWEkifsrgLrOehCCSgsT671uswYjqarw/cRUV1dyH8002yIkMvYQ?=
 =?us-ascii?Q?5CiqRQ5IA/ADP+A8O2LIUe/U2x83huqdTFCxl2h41aZPstgmUn2iCmSiqxdK?=
 =?us-ascii?Q?DExotqyyjzyzANVIQHAZLnEWQzpjsdhlgeCKwu/Tm6tfZ58F7XMCCtmu2iEA?=
 =?us-ascii?Q?XxswB2/MqNZacQA500Hlx9JEdEvCDUbYwPJe5Lud1VDMhM3nAuwmjcx2YnSH?=
 =?us-ascii?Q?SIPyD6wd+EMRjH9Boytukj2faL8FLXREcWPttOds9B2cTI3imf31LFWE7BJO?=
 =?us-ascii?Q?ze5YI8HDhl743DpSsN1R0FouTrtik8ynMyJA+PAVeGbxQJKGWuvZc2VuCj9P?=
 =?us-ascii?Q?iYJz0aPhl3Ho9Pn5tV7ONcw0LTPHS47Lrz3ff0LJ5tWkzrLBa4qs+VPKSS/M?=
 =?us-ascii?Q?t+TAC7Pd+rx6WA8zGLWMwug6zalSHYLI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pFM6h8hHmU66OJAfn9DxrpJpi6sPEwbCzhLyiNeFg622UBUcQ26jXUotXTsS?=
 =?us-ascii?Q?TKrc/TAF8ph735p6HPyn6uMSak+my7Ehmfxd/Uuw3o0rgdEoHA5pAcv9jAim?=
 =?us-ascii?Q?lZpjraUvrXk+ge723Sn68aATIoyX7hewOGDmX1h5qwx1svSDkSaerbog4IdQ?=
 =?us-ascii?Q?hJqQxETCp99totfHjeyCkKV1NeitbpIDthtum+pAy3mI7+Lhi5jSt48aYr/A?=
 =?us-ascii?Q?ZGV8nJsaqtDL3ZOoEjkrrn8V84e87knJpAUsuEkHu7DDa7AXqsa07K5/eh+P?=
 =?us-ascii?Q?tGMM7aT9jkwXSTVWB7flS/Xnd3dbKcnENTPqM3djSm4TI3yldxUCqJlAhzQ/?=
 =?us-ascii?Q?3LXOwkRrzYszeYtb5PPGAXD1uFJHayT8Xd5935jpAe/8YL6l8XkXCsOr51fF?=
 =?us-ascii?Q?U9QKttYigg3TpeBOrQRZxRfLQKj3GPKKPgnvTKETr7sZK2S4pCs0yqU59mdh?=
 =?us-ascii?Q?dxS1jjccfyvlipHRdS0t5PGZCfuc4ggOVzvJqQ8giSjIN88+yvIwhWdbbBq5?=
 =?us-ascii?Q?EYTQZ0/doQNmShuvSc4WJoKMjnfyFd3IZclNsALWZzwidxW1E//pjrZfT5lN?=
 =?us-ascii?Q?Uz70QWDjN1274SwbF9gaB/T5GMwbsypBTyHiy0gFX7u5yxHUoK+RD0YQlbQQ?=
 =?us-ascii?Q?g2O5miRj1cmVR5xUPYJVEtdUzWFXbiBXBIXj5F8NJzhhIB7cyIAKdjSgp6V+?=
 =?us-ascii?Q?t2om+OgM9obVld76uxfUAg4gBhgtwwQ6+fkUlDKskys6OaY7VYIqLZDCDVxs?=
 =?us-ascii?Q?L2Or+dRk9mTwzdFreebKxuLSQw++qt7sYNdRn9DInqOzuRMN0LXB9FG7lWvQ?=
 =?us-ascii?Q?zoTe0EX7jzuqItg77ONzs6icFvhE0GTY2X1JHISH4mzWAFJ/sxOUc/hnCxKq?=
 =?us-ascii?Q?/A1xteyWYCJ6t4/1sd+wtaWEazFz0eoTS/sHWFum8fCJ1AhzR+cXnYbKXSlM?=
 =?us-ascii?Q?yZeziYeBHl6rsG7OMKvMJRvKlfE9fra9ezsSKZwRvlVtqvt1VUNmnPyZ9HMF?=
 =?us-ascii?Q?KG0FGspJAyneQ4/Fh9eyzUE6JvlEL58TWoTrBSL/9A/u/Cmbf2XlFeBdjjDc?=
 =?us-ascii?Q?bhXu/ndD9hWITil6PCuCcjN3mIAWwc8TByJClKAk8iizV4dhSC3WjrgdsgWi?=
 =?us-ascii?Q?bazu+ovyAqSu+bFMjrpryEP+HjFrSNIqQlhcwdPCjx7aCTzBf/xX6WTmRSYw?=
 =?us-ascii?Q?ubVEGwHQzGJH6OQSKWcxfzi4iN1P27W8SaninbLUGBCwLRaao0JIdcDDojY4?=
 =?us-ascii?Q?BJ/tKoSswT+w0lVujor7a7yWGH1sBg1Wz7dr5eC9Uan13X+PvolXQcFIl24f?=
 =?us-ascii?Q?Y9zg4K+TNMUu82s0Q/Sq78da0hgz13lUfhoi+OnC98Hmdm14hUwZqlp4kGhR?=
 =?us-ascii?Q?MtqFR31okh7wU+n1OWKSpxc8vZjORD0TFlXhURxq11jJ1wkirKAS1zkrbwJC?=
 =?us-ascii?Q?r0GDA4peacG6peKcY8SnE0HHTuRkCT0YdWasJ4cnJZTu04XrCQAHCCFMlpMe?=
 =?us-ascii?Q?uKCktkk94zJPzX3wdb8CSTIcAgZI3zk3sxzXJt0cY9P+7YM0BuQRrk+suiZO?=
 =?us-ascii?Q?9s9AY4kJobXRjImDevJ6DvuF6fqoHFFSXD86Slqz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a76927-a6e3-4c60-d7f2-08dd4a320483
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 00:21:24.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gONPiT4Q5BZSw9yOZUgVU96h8x+Vz8LeqZgPWBlg4JXEl8IemxHZPhY1GkPXktcn16CfJ7SroEtbJCMxNUcVKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-OriginatorOrg: intel.com

> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index c0afee5d126e..0a21943ce44d 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -189,4 +189,13 @@ void memory_block_add_nid(struct memory_block *mem, =
int nid,
>   */
>  extern struct mutex text_mutex;
>
> +#ifdef CONFIG_ACPI_MRRM
> +int mrrm_max_mem_region(void);
> +int memory_subsys_device_register(struct device *dev);
> +#else
> +static inline int mrrm_max_mem_region(void) { return -EONENT; }

The lkp robot just pointed out my spelling error. Should be ENOENT.

> +static inline int memory_subsys_device_register(struct device *dev) { re=
turn -EINVAL; }
> +#define memory_subsys_device_register memory_subsys_device_register
> +#endif
> +
>  #endif /* _LINUX_MEMORY_H_ */

-Tony

