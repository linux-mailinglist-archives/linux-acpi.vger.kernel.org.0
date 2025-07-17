Return-Path: <linux-acpi+bounces-15226-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DAAB093A4
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D774F5A0081
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6B2FE324;
	Thu, 17 Jul 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlOnJ199"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32D4503B;
	Thu, 17 Jul 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774859; cv=fail; b=ruEVs3b+dk95p1GMus8e0kYTqVQDe0FBqtWTHKfh00IMMxagjGlO3isvuPGZfEr5H8oOCbu+VsruBZ83STzH7bQ6gCmmtBEiMlzUOVPoa920bqZvlbbrT2ZMhENlU62PYntls1JuwEY1TwCbYZN8ZmGvNyZv3mSvbRedrl3sHfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774859; c=relaxed/simple;
	bh=CSjJyP0GTymJuhbm+AifIAkJ1nzNdRo0NFcCPCNsfEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdcihYNPMdFt29F/cW+ohjbSC92WBNkvxbJrLaI/bTrYbmOh0QZpNqMYOKzLoROg/hg4wotmZcQCwvHlFrRiu4qT/F15JKV+f6gtPvyfW6YvBOnYuK98DdciD358KYMz3D97WiLmmMEeJe4GnIbX7AJ4+/rli+UD9gxh0FgydPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlOnJ199; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752774858; x=1784310858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CSjJyP0GTymJuhbm+AifIAkJ1nzNdRo0NFcCPCNsfEc=;
  b=SlOnJ1995U7vYIoEz/K8LqXBbt+ki/xzHO8KkpGMrYAFvLnMrUpMnYhT
   peaLdHKE+GQi+VqaCFt6hckNx8P2MVHNhBbQpo11HYsxhb6e8LOIDVBXv
   aDqzmeNF7/9qiMSWoyXX3KSv1VFc6YaA9AeH665yEFXMu52LeV/i2LMXz
   RupxuycptC01pdwPw0SWcr6S7FSuIVK91ouBhFtTiw/LXfdM6VL2S+0Dw
   FOirXdCGgIPZCOGZJCsMSlSwU9ZcK6iQaiahms5FWrSr7cIGzLuoTbGYU
   80QfpAkNJoQTksPNyctg8NVVbuFUR20vlw8OWRaPJBcrqUdJzVjfwrpBB
   Q==;
X-CSE-ConnectionGUID: 6/+kKjkpSq+lcijM4PQ81A==
X-CSE-MsgGUID: ZH+ur0l3QEi3wWKeiJENpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65634180"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="65634180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:54:18 -0700
X-CSE-ConnectionGUID: H/6XgXjeTQu7u/N7JarH9Q==
X-CSE-MsgGUID: eASoogHlQW6O0LL/A34Krw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157972987"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:54:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 10:54:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 10:54:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 10:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbmskSz3KcR3SnYsTH5WbZytK+1EAclD7g8lvJ3wFQbnnDePFDZCl9giYHf7sQRRXAYBqK52908Z5vwilwYvyeGgF8ppD36D5LXbLby/f4H+SykVfTw0cWOk9F3Xdo0i4qBl3c7PCGmYVh1PQkzAC6OCRJ9c3Kkii5g3eOftg6IVM1Q7BHWuxo9vKYuTkV70cuXSPyWEXyUvqR030ON/5TN0hMA3+hMwAn1dz3BzHCvzGt1Q6fqdYMvTZtevIZtCn/HDvRTJCL5wK7L4f5wM8S/nU3GQSN9utJ+jAllAvs8wqMb8VxHC+Y4aRA15N6w3A5TIDq912/5cw7c1+Y9hkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPaLnuM8L4q7HE9ZQs72H9mQG5HenNwXR3VVGh4tHto=;
 b=S1zxK+djzFTEDXtxlYiZPlMYwMIHZbHJn3JrnwgW9WjvFLlxu7VaUUcsyyhxSkaZXg70RU3lSt5yJW3PSfKXLZyvDRjdXPhfNO7F95T7K0Gnw3I4TSHQOnrQRmoRtLBFM92IRaF9agAERp9ZvgZrRd/wB5ZOmpye8F0AjamTEBYaKWO2/jyRpcG4/UtgfK3t81HLhlP74aYKvW1mOoAAY/c3382aaKIK266zI42LKjx5vsUY8YkOcqMUSACK3lgiulbefK+e/XoWW1QjOx1MmazmwSS3pmeumxyxg/S5wsesEPSjqVYXDPwQemBFeXs4EMaH8O+5qP9Krxck/+pg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM3PPFB266726CF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 17:54:14 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Thu, 17 Jul 2025
 17:54:14 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Breno Leitao <leitao@debian.org>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	"Graf, Alexander" <graf@amazon.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, Peter Gonda <pgonda@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
	<james.morse@arm.com>, "Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [PATCH] ghes: Track number of recovered hardware errors
Thread-Topic: [PATCH] ghes: Track number of recovered hardware errors
Thread-Index: AQHb9OBy0msNHAJLb0CCMVEuXQ5eELQx2rEAgAAFjlCAAAGCAIAA+fB2gAAewoCAAAMHgIAAGX2AgAAOMoCAAA6ygIAAPWMAgAChsACAAKGggIAA8ImAgACXsYCAAFaQYIAABn+AgAADYuA=
Date: Thu, 17 Jul 2025 17:54:13 +0000
Message-ID: <SJ1PR11MB6083D0B2B8AA0C056A1B4F7BFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
 <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
 <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>
 <4fbreveuibi7q5nc2v4t3fpaxrgpwfd4f5c3ubfhssidqesax4@n7q4wrdpbfjv>
 <SJ1PR11MB60838F74FA06ED06C5D29FEDFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <p2jxuwlierrzbgsdjdmiw5336mhj5s57vg77zkekix6fkjqbqi@sa6opsvnxv6d>
In-Reply-To: <p2jxuwlierrzbgsdjdmiw5336mhj5s57vg77zkekix6fkjqbqi@sa6opsvnxv6d>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM3PPFB266726CF:EE_
x-ms-office365-filtering-correlation-id: 61f0c47d-836b-454d-4925-08ddc55af121
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5x5O2Dzdz1H3tmsTZ0QKiCXT8NR+I0k2uRoOR6cUDZwa8sl/vKXY9kx5h43l?=
 =?us-ascii?Q?ckDerOqdDTLj+w/JYCgZIacaqc/vY6kXFUb9GegN2b/4yXB/CQIRXk4Gw9Ix?=
 =?us-ascii?Q?QmQ/FsuaChuvKQSfNaHY86alwTpSw5t6laUJeKQMsdwzSIUESsjsSGG7Qpvn?=
 =?us-ascii?Q?aMFXhK6MbPEgsESxltTaj3VYberEog4w4gjVtZLUvw+NMEGGhkSpqUQaxVyP?=
 =?us-ascii?Q?B38btBgJTewhN6UJA4dmSpbolntL9NmGkJODc60dYzL3sKemf75+6bPOqBrl?=
 =?us-ascii?Q?QKyXQ2nfIemTa0q6rl9FSfVxV8t5arN3RdraqDVCyRvp5ZKv82dKQRgidUMw?=
 =?us-ascii?Q?2qv5BtV0qYUsf1+NIgnyfM55SLEhVPCeJASqVkrI+IyPoeOUbHl6n2LEha+K?=
 =?us-ascii?Q?yH5QijA/3mNmBYE+yCRF1TD8T6hUOfsIR5prKPKPhyyrtHrahKL3+ROWLwIL?=
 =?us-ascii?Q?C6NEiZ2/28sn3Mj9AdUMs4GvQO0DYZsVbGTmm4ifJv/zy9NLd8qADrYe1Q7I?=
 =?us-ascii?Q?MHvIPe13JKURZNXnbSsnbbaiS6arlKlssf6dmdY7ZF5YwMLxKYi8gFeLx4pw?=
 =?us-ascii?Q?t9Azc9dtUaNyCO1tvkAUBng0MEpjgVaf8M5OO+QqI+nLR7Ux7QgE5TZwUI0D?=
 =?us-ascii?Q?JxaVELwCRbWrYCsZsWj5BjuBP2BsxLbmgEBEPm9amt+4Dpn5fl7j5jxqVwMk?=
 =?us-ascii?Q?6P1f/rQEXRKE4UpN/k45uBH8bZ9nhvLJhvGaKD6S0aiYyT7YqjRm7LwT3yKh?=
 =?us-ascii?Q?f+h4ltXW5JpYMcs+WahyxMV+opHJ0w2mPwWwkyCtTSbBP/bLmRW/jdo+/Zmf?=
 =?us-ascii?Q?mjxlG/ieD3ytNWSwCiFJ4SSjFcrD6tCIZp7AfjeJGQCrqzZ1Tsq731PKGod7?=
 =?us-ascii?Q?tug6K2FctpYco3bJ+RdINlzwGnTsDvOdNP4us9xFC+Im8IV2fp+AWTGLDLfq?=
 =?us-ascii?Q?Y87fxzeZUoB089OUnMbaFC/6IpIjm4ZGWpQYthhEndp6o5rX4Tu4ykGTp30h?=
 =?us-ascii?Q?5ugtCd0HCFtPEe8zKpWjkxyLKuahUsAqHHmVFKvpsHaocu+iMim1ePJzvyDy?=
 =?us-ascii?Q?DEwd0Dv7E8mzuLZbsGsvuDL3fe0NxKYtmk7pwJHYlm0lETT8wk+e0oguXzwD?=
 =?us-ascii?Q?WxgylZ6e0ShWjdWtUW2ej9ZLL3hPiPOWfDjSTNCmm2sOUlJQWJgV1hEoBU9L?=
 =?us-ascii?Q?xXf4nof9L/5E/xtbkEcG/JZl+7MVCXwfCoOrw48keg05ksA0GEP9liFOBexQ?=
 =?us-ascii?Q?n15NDkAfKFYm8j4pD6XTt3jmBHZK4dbemwZiS9G5uScevPjAIDPryR4qHiFT?=
 =?us-ascii?Q?h6SzhEFY2lqR6mdiO3aLfzOFxenKtzEJ9U5OTjqwo+wVaAPikOkieuAJY4sc?=
 =?us-ascii?Q?l/wck7ayAgEC5A9uItafbThh/WlN17TXG4J9k8piJwNeduohgZw5g3wDE8RH?=
 =?us-ascii?Q?xmSTLcd9guWZKzWP44d9YJKJLe4zigClbEukPwJvi5pRT6c9F+ZAJC2CMjC1?=
 =?us-ascii?Q?7gH6HqrYgmB1c3M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+zVSRwlBLC/NGxzR8MNqA5ytIb+UOEr7gKxU3sDSCpNGxuHToPC97zmQ335W?=
 =?us-ascii?Q?e3Seh/l0YMfbEY1NzUXn3PDWi6WMEllpbErK8Tp+fbQIaz7omXD/FDxhccTk?=
 =?us-ascii?Q?0Q/MFcdXlAVaVcKLwEjwKQ0TWmKdw0qjupir0euy6iYM2GCc3QmyCqi32K8K?=
 =?us-ascii?Q?R2/1ARU6WFFueNlcw15Sg42CffNwZH0uhcKA8CfcesMs4W8DAom5SJoRZfx3?=
 =?us-ascii?Q?pbZXcgu6A1/YWSof+jE01avncqRWGEhhAlNqR979k5hHGbckVR6rtincVSSR?=
 =?us-ascii?Q?BMbtNAxijiBFnipxUSIxh5NrJXVRKpQUfzKZLbO+e8UuqHOxfiNqHqbUQRn2?=
 =?us-ascii?Q?2keXqkkIQrEXqPr1irmr3uiMlWR16T8BXEStr5hW6XvvynVvIqv76CJ4iPsS?=
 =?us-ascii?Q?I1GQyH05ZOR6VFgk8PrpJsFMCkYp4/FyFqkeymJ5Ay3BbMG9tReXDyRhORqS?=
 =?us-ascii?Q?xR446jdtNgckxuz9rUSlapl4cveHmdWfmmcSrm3/LeoIzTCs6dhsdCP6atts?=
 =?us-ascii?Q?31153klzsN4Nq01fb5+vGxj0mF6ufMvw4Gv0UhHQ/dnz3S+iDF7/9uj/e44O?=
 =?us-ascii?Q?YHGoJeTYoCrvyBDQtE2tKybIIFR+8hz8w4+jxIHZqRw+hNaJHM0E4GvlnakP?=
 =?us-ascii?Q?lcPNqMtU+pGMQrGnpj4n6mqU4N68KiCEx9AhUFipJw95BSHUJjIakd1qxwgv?=
 =?us-ascii?Q?h2j/27TNDBuMT/OQsmK7qS2Tx8zlPaU7M+WugUJLIWexrczaFgElhFLI2DLG?=
 =?us-ascii?Q?wJqBgkcsY/8s8+FaEYacPdszsc8HChqd4j6/rnbGkMbKyJcTEIOWgM/6XQvk?=
 =?us-ascii?Q?TjAWfRMqdoRnGVYxUcj44awDA5FUxRSiD+CIhDzKcLfZqopmj8227s6SvM3b?=
 =?us-ascii?Q?rEZ7AdUCGKoHtyoaPBt1TGarEJPefDagAJcPNx9XfnnpnGLppJsClKZUD3R2?=
 =?us-ascii?Q?/ovFldGuORTJYoE1lRE1jLLHIIvZud5tdExVQW1Gw9ba4Y5xv940RRCbSOQe?=
 =?us-ascii?Q?W05pqs/dqtXHXBEc3Bv38GIhifJeO8l50KCElWL6nTQpmgbr76ZB94Fkb0oY?=
 =?us-ascii?Q?uAZRO4ExWQ0VpPYGe/+rv8o7+7udm+dVkcwgDIpPcHBh53eESxC46xZw1ZUC?=
 =?us-ascii?Q?Y2zLuavuIZdoV/qtFKIN/Wv5Aoxr2tW7aWjJYbIjWrOBnc2TqgIeL9ixnODi?=
 =?us-ascii?Q?YyjWMuGrTa9jguhO28DoPYBoDj4CpVPLJCaQocYtWpMdeGbRltUPlTZVwAR/?=
 =?us-ascii?Q?z0V80atNbA4iInAwercUeVC1woQj2Iimvsq7N5r/5sksAGfI+mPd9cJxrW96?=
 =?us-ascii?Q?aB6Q2x3lZpPUp/jYXGctg9OruwLIc4a0D7RUnAjGc2SVXSTk5RUA3ZK70RDy?=
 =?us-ascii?Q?iGtwoUN4HCUQdGG4qEKnTipQ0iJ89w8kWnaqiCvUR2ge+1RbW4WB38hS7768?=
 =?us-ascii?Q?x79MITHjsuTTPICv28VAhiSNVhMN4lqCnh1DMnlzOnfumL2Cwclc5GMqG+nk?=
 =?us-ascii?Q?ewRie7m/iv8cdzoADLm346dVtQeGlwSzu5GX66JrahAhepljbA0DMc49LDUY?=
 =?us-ascii?Q?Q0IOAb6lOYvcCDoD7A0C9wJcy2xARaEJK3qpU+7z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f0c47d-836b-454d-4925-08ddc55af121
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 17:54:13.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSZaw/lVdM3JNeLozZ4jkxf8FTlkQ9My9XS2YgoE+UznlPwdiL/gm4aLK40qrMjVQ0x6Ea9glyDom6xzwNMNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB266726CF
X-OriginatorOrg: intel.com

>> Total agreement on keeping corrected memory errors out of this special
>> handling. They happen all the time in a large fleet, and are not signifi=
cant
>> unless the same address repeats.
>
>  Are these EDAC errors? Shouldn't we track CE errors in
> edac_device_handle_ce_count()?

Existing code should already handle this. EDAC drivers register
with mce_register_injector_chain() to be told of memory errors.

-Tony

