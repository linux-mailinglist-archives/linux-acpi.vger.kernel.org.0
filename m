Return-Path: <linux-acpi+bounces-15223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC148B09303
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D397580EAA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373872FA63E;
	Thu, 17 Jul 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erxf0dRg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD29157A55;
	Thu, 17 Jul 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772824; cv=fail; b=S6cDM8MAuu5ZUrKxOaq7ofThDqcDeoxDlhe+9Us+fS5tjjqupoQhZKUrk4hEWtsgBAmGzEc8xsobF5O6KxoqP1DTAid2wH3uYs4MQPNt1MSm/CvT6vTNCxOmf1ASPtehXe4b6ZIvTA6MJidrTJ/qWecBF36XohIgPIqvYXqX2D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772824; c=relaxed/simple;
	bh=Xj6KhBl94ki09qfaFtIC6lIvuWKoUs6KHp2vApVbFXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdTrjbH5BK5BSl2tiLdpKQ3ovDSeCRXSvuLQan9Vz5yxGTQhPaqBpoJCKQZvTyuS2WGq7trW5ezozDFGyzsT/MrNmlLz3jUmsebxIsUDsqOatgw2i7QX4Cq9dEyG1A5XdtB4X1K4oTlL9ZjK8pnPVkpCqFqTBl30h9Zax5v9wxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erxf0dRg; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752772822; x=1784308822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xj6KhBl94ki09qfaFtIC6lIvuWKoUs6KHp2vApVbFXM=;
  b=erxf0dRgbU37DmMq7lzNcpx1ADhpdxvYDbkVIuWtPPgoGvT3TQHv16yH
   OoI7uRcDa45Nvq3mEpRMMrQYjY8YIjaIL3VBRW0L9K8MX6n7to/quv2R7
   kbAKaK6uZ3Yckjbg7uPwWtdIPb+u3G3p1gr6M3YGrHipOX9KoX8mcPc/Q
   /PXW35yHV3CKiJKoc22gqWj+0FdoC0hY+p+NTuQvuyJT7aNxUiUAL/cPd
   83uLNBjJH1Zgr81WkG1otATC5WVVdSceKb72zUJckptNzzyKmZtaqhkIY
   oKPranXlgUUoNkDjcyb1Y+6tuIi3oI8L4vixWmcPeVL3ZCoWEqV5bZa1u
   g==;
X-CSE-ConnectionGUID: iksw5Ik+SMKr46AUaHaiVQ==
X-CSE-MsgGUID: J/z9T/IDSgOtvq/cSK8cpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58870708"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="58870708"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:20:21 -0700
X-CSE-ConnectionGUID: hNqoqMRTQTSyRlFgZ+Qz0A==
X-CSE-MsgGUID: 2qCRe3wuQp6L95sBx/sq4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="181563186"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:20:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 10:20:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 10:20:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 10:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkraVQY45N1cGTzom3SwhGF14pF19A8xKgE7ne69rU3dheJTXcuPyLJ96uJllORQRZg+cAubaVXPBO5kxE65RMY/dGo5zJj6MHB/lv8XjzRJbThV+cP5X4i+FQDSTbshFwFnqHZj9CwPOjVWpM8Om8VEvQevXlEp7kY0esrRjnMCH6OLvx8Ye3UZ7uXiLEh6vw0HAT3O7JDsL/t8GvGm/1bNOXGTk8DxwH0Xoz99aTd+iDxNPM9/49BC6BUOlEKYlmavNl1J6bIqOiNZWIP13NPCmEfjCt0WDFNScZVDC5olLZ1zn0rrB5gxkKCcBnqFize7jTvDmjmx0KQMF1izsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj6KhBl94ki09qfaFtIC6lIvuWKoUs6KHp2vApVbFXM=;
 b=XheTIGaeQAoV1ir2dG6BD94mux5s9Ruwpe8OKXGhIb7Qna5NSTry3cLm39TZlA2NyiaexTFmp7vXCCref5TImmAcKGzX4tLwsjzLPO8K06Eppb0OqBx/QzSdmNkLpIxCPJ5uJ48LM+gYuws1oV5wV9YYWr8PQXqEKY7RxhhTj3ZfKtym2mNnB+iWV/xZYZR2BbXNUt7QAbm+Y/oP2ToOo3ZfcY+R2Ft42Iu05zJVvZSZ3Ny8eQC9V5kFoG5PcxlUcXzliiInWiS5/7i2pGt1wcBTsSI1Y6AjiErlOYATjw7UpddfSEoHDjhjpJeEtVBkTZI0cPJ46BGby4d1+Q4J8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 17 Jul
 2025 17:19:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Thu, 17 Jul 2025
 17:19:48 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Breno Leitao <leitao@debian.org>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: Borislav Petkov <bp@alien8.de>, "Graf, Alexander" <graf@amazon.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Gonda
	<pgonda@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, James Morse <james.morse@arm.com>, "Moore, Robert"
	<robert.moore@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [PATCH] ghes: Track number of recovered hardware errors
Thread-Topic: [PATCH] ghes: Track number of recovered hardware errors
Thread-Index: AQHb9OBy0msNHAJLb0CCMVEuXQ5eELQx2rEAgAAFjlCAAAGCAIAA+fB2gAAewoCAAAMHgIAAGX2AgAAOMoCAAA6ygIAAPWMAgAChsACAAKGggIAA8ImAgACXsYCAAFaQYA==
Date: Thu, 17 Jul 2025 17:19:48 +0000
Message-ID: <SJ1PR11MB60838F74FA06ED06C5D29FEDFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
 <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
 <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>
 <4fbreveuibi7q5nc2v4t3fpaxrgpwfd4f5c3ubfhssidqesax4@n7q4wrdpbfjv>
In-Reply-To: <4fbreveuibi7q5nc2v4t3fpaxrgpwfd4f5c3ubfhssidqesax4@n7q4wrdpbfjv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB7007:EE_
x-ms-office365-filtering-correlation-id: 419c9fcb-0710-4386-fa74-08ddc55621ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dEhNRnFUUXZ6UXRWd2VBYjczdzhna3hPUngyYWJZdExlUHFNaW00WnB6Wmdn?=
 =?utf-8?B?SUhPeFNjVVBzU1V6VnNOMzVMS21CWXlSckhjTW1YQU50S2lqbGJkMlVKL2hz?=
 =?utf-8?B?SVhSdjBPQklTcGlSbENMdWtEU2JZTjNJQjl6MENaa2Z5T3I3SEtkUWRuMnQ0?=
 =?utf-8?B?V2k5ZXZNUUVmd0Niek5RcU9nWkNJTnhxWlRPRkdvNFhKU0lyL0JLSjBmMThp?=
 =?utf-8?B?SzRPR2kzQXdrbmNKblNORVI0ZTREZldUeTdBUjV3WjNCeXpDb1FVM0ZFV1BU?=
 =?utf-8?B?Tzg5cE5hRjVib0FzZ0xwV0dOM2FzWkQzazQ0ZVdoM0gxZmNzYnE1WWxUeVFF?=
 =?utf-8?B?YzlFZmlNZnk1SkFmcG9zalVVQmUwcmw4V2tONHVKaTExZ1ZvaXBDckp2Z0lC?=
 =?utf-8?B?UVlwODNZaG1jbW50SjJBU3EySUwyd3BmUXFsL24rOEt6RmJUMWZsaHNBT1J1?=
 =?utf-8?B?OXhTaXl3ZmlZalE3eDZUYmhLSkVIK2V1aWdXQ0dic3RhSVYrRVl3SE5CVFpy?=
 =?utf-8?B?V3dIVEkvWHJxTXRuTDJLRTg2Mm1CNkc1dG1TeHdkSTF6U3htVGg3L240NWNO?=
 =?utf-8?B?T0lqb0gzbEJaa1ZSSmZ5YytQc3NHb3pjVE85WG8wK2IrUnZGeEdjNTBFNzh3?=
 =?utf-8?B?eFVTT0lyOU85QmlsVXVUb2dNWEx6elR4WkxCUnRzMGR2QlB4R3BvUE4wb2xn?=
 =?utf-8?B?REJXMytlYW9LZmplQ1JxZXhicHkxUzAyMU5obWpZKzE3U2c0UzhMc1ZyL3Ra?=
 =?utf-8?B?NGR5WTVkMzdhVnJjdmQ5cFYyUGlVSThSZXpWaHFJYUxFRlRtYlovM3kxd3BT?=
 =?utf-8?B?Y3AzSXVKWnJ2UzdjRzVVOHdGZ0EzY1l3QXg2aXlJNzRFUXAyV2s4OXp4TnBU?=
 =?utf-8?B?UlZUbkl1d09KeDdkbnhtVk5CU0tQdzRlOFBtOVVxZHJzNGVJZ1ZHQWZiOEQ5?=
 =?utf-8?B?bVpkcFdITlY5VEQ4TUlESkpiUTlTbEI3V3FPWCtPaHlsUXZ4QzVNMmx5MGhj?=
 =?utf-8?B?aVRPYXc1RVVlRnEydS8wc0tXc1M1SDR2U3ZydjZqMEw3ejZtbGhXekZPVTM5?=
 =?utf-8?B?cE9zQlhtZmZPYis1SlJUQ3hPTXNTUFhlN2NLWmhqYmtkRnZsYTl1WkQrUkhl?=
 =?utf-8?B?TkxUb0Qwdmp3cXRKZHZWSWFoeGRkS1dheVlDNVkzRWpoZzJ6b20xV0srQURQ?=
 =?utf-8?B?TGJEb2VlUzFCdlZORVg1a2pBZUNzS3BwaXFYL3NKcDVKL05uWVoxTFIzalZ6?=
 =?utf-8?B?bW5aenNCRTdnQzZZTmcrOXFFMW9TZVVkSUEyQ1BLd2FpVi85MGV1TjQzeENq?=
 =?utf-8?B?QkhNL3ZqRlhla1Jyeld0SXMrQVVoaStaakw3aGd5NG9Xb25IMGw2SjZNL0ZC?=
 =?utf-8?B?dUYrK0tzdE90S0RpNHBBaytFQ21RWVBaVGtJelJNT2ROcTdHYW1saWQ4UFVI?=
 =?utf-8?B?cnpKWk00eWZRc1JBY1lqRnNraUk0TlJFZ28vOE9aQ1Z4OUV0Zy90SFlxaERF?=
 =?utf-8?B?TEdMNXVyZ3RmNWxuV0hBdG5oYUpWeUNsblQzUHdXck1qcjBOdmFCYm1sVU1q?=
 =?utf-8?B?b2JTbHlTOW1icEhVTnlGSkNqdFpSTFdnaVVIWWlrMFJCa3V5Ym1LcmtqNnNJ?=
 =?utf-8?B?VlNaMktKdzVScEc4RlVFUUE5Y3d3cDJuK0VnQ3ZiUkNtNElzYllXQWNNc29p?=
 =?utf-8?B?TXI0c1gyQUFMSXpybVlvTU1LWk9BbDFMS0xvR0tSMGJJK2JlSEcvbEVYUDJ0?=
 =?utf-8?B?emZFdnIxMFd3Snlyb28va1Q1dlhMT3Zvc3A3bjNxblNTcnUvNGZXTkFZbWpj?=
 =?utf-8?B?RGgwTVZOZWN6ZzJWd3R0U2NZbEFVRVJqTVVWUFNsZzJnL21HZnVrclFaTXg3?=
 =?utf-8?B?YlRtR0hMczR1S0ZpTzhKUEdyUVlDZTdQS1NVa1dXaWlEeTZtQStEQS81ZzNp?=
 =?utf-8?B?VjhSd2Z5UnYzYW1vUHJYNExaaUN1UExWMGsycWR3bEdwdzJPM1dCT21LTTdk?=
 =?utf-8?B?Rm53YzYvVDdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWVZTUZ6R3ZZaW9NT1MxdmZsOEt3V3hXY3RaaUNGVFRWLzRMalJzYjVUVU8r?=
 =?utf-8?B?dERvWEFvZHU2NGo2OWpab0J0OWJvSXhuWDh4NXlFdzJYaUZycEUxQnBDVHd4?=
 =?utf-8?B?VkhkTEpMUUVyL3p0eWQzSmM5QUlXQS93ZWtXMVB2U3BMNEhWR2wycm9FYU9K?=
 =?utf-8?B?TmxzRE9FeVhKWHhVVXpzMkcyWWphTWdMblRQQWZhYTFRRldhdi9WdDN5dVJC?=
 =?utf-8?B?cGgyVkVzWEd3VnFsSEV3U05hLzJMcHc0VjI4ekNzamxjalNzTkF3SHZldTRI?=
 =?utf-8?B?Ujh6R2pwUS9TbDMvbTJScUNFQjNWUnhUdzJsT2NIS3VPU3NONzY3dUwyZEhu?=
 =?utf-8?B?YmFiWWtPT1c1bWR5L3gzZVhPRk5PNEp6RlZ6dTJlSzg1STNCb1FoVVcyRFZV?=
 =?utf-8?B?czQvVmNGTUhnRlZpSW9vSnYvREQ4YldTUU9TOVh1T29mSE5oRHVIT2FYV01J?=
 =?utf-8?B?Mi9jcmhqekFvazgwblkrWllGWDZWWnN5MERwSFRIV1RiTXo1K2Nkdm1ZN2tG?=
 =?utf-8?B?U25nc2t1ZVEvY2FZVE8wQ0RZdVN4bzBGbWdTQUN6YXFsVk5wQllTbjExRWtO?=
 =?utf-8?B?ZDRJUkVHOXY1VnJ2UE1kbDI5T0FJSlJSRWlzczhmd2tOelhNMHBLR2Y5dE5v?=
 =?utf-8?B?ZGtyektLNlFOU0F3N3ZZQUlXMzF5bjRleGJuRmg3bHBDN2UzU0hPRFRzTHhS?=
 =?utf-8?B?NkhEbXQrVmI3TUNHeHZvWUNUclJKaVovbkJTUHYwa2JoWjBuVkpDYWZzd3Vv?=
 =?utf-8?B?ZVB0bUlhMkZhK0E3blNuTy9oZWdLMlBoMDNOaTl4d2ZTRGx1S1hxQTh3OWdB?=
 =?utf-8?B?VmNzamkxc3A2bEwxWWxwRWhDZDR1VUlnOTZ0RmREay9vMnBwMEU4a3RZbE1R?=
 =?utf-8?B?VzRVUTRvWndlS2M2RWJMUUcvc0RqRjFwMXEwZWlUenplK09KaWZqZmFqYXU4?=
 =?utf-8?B?bDJTSmpndm82elZvREhBeFh2THhLdGtrQnlPdHJqOTlZWU5qT25nOVZJTXRO?=
 =?utf-8?B?Y29TWlVnR3R2ZjJPWE9kbVpvN25rejRNSmY4dGg0MDJUeC91T3JzUXhhQjFZ?=
 =?utf-8?B?SW5hWkkvQzZHT2hJVmFNUFdQaEhOOVRQa2tob0NKV2ZpR1lLMVVSdGxVRFRT?=
 =?utf-8?B?bHVkSUhjVnVLR3lheXc0ZHhDaXh3Q092aWRYRkVSUnVxR2Nqdk5mZFNCL0RB?=
 =?utf-8?B?cGVCY25uRnpQVk00QlczNUIzcS80alJkZ2VWVE1RVkhTbEZ3T2JCc2ZSclU2?=
 =?utf-8?B?UFhuVEp3ZWJDd05EL1I5cEhQQnpzYllld2Z6bGdudFlZU1FUSFY3TWlCdWkx?=
 =?utf-8?B?dHBmOWFBU2JTcjVMeXgwYW9NTnU3VkFXV2ovMkxrQlFPakQ1RHUxWVdCVDVS?=
 =?utf-8?B?SHBRMmIxTzIwMkhQZzhNeG5IZFNoV0JJMS9HaGlTbEorbU13UWVnVnJ2Rk01?=
 =?utf-8?B?RVNnakFGZVlJNmI2RDZ0SlJnTmkzZWxnTTBXVEM5b0hnZ1llcXpud1QvbCt3?=
 =?utf-8?B?QnZlQ0hwcUF1dHNPVzdzdkcxeGNGL1kzVWZMRjNuZ3QvYlE0L1V3UHJpcnB0?=
 =?utf-8?B?eVh6SXZad0JldHg3K0RTdnJud2VIS3diMEphdjFlSjRLV0VHSUx0MkRFR3J1?=
 =?utf-8?B?V1lkYTVDV09mMnViYlpnbkgxSjJBbVNtbjhiT0FvODRkQUpWWWhpNXhLY1Ew?=
 =?utf-8?B?S3RnUGp4czArSFJ1WHpYcm15RHk5MVlDSnlMMWIxbGtJVEhvVGdCdXhwVHJk?=
 =?utf-8?B?M0VHSkY1Ylh3WXFON1VOZmRYTWdYYk9UUHVDNHRoZmpGR3dXTkhWeUtmSVgv?=
 =?utf-8?B?Z2p2T05DWjdoQkdiWmpjdlRSVmVjdGRWNWtpdGlMY0wzQkN6cG5EbWdvU2JP?=
 =?utf-8?B?WGNnazhpRU5zb3RMcEI2aXFDKy85cENIbjM5Tjg0LzhoSjQ1bytBVDZqSWtO?=
 =?utf-8?B?MHgvVzFHd3EzeDBadTA3bm4xNHBVYzA1Z2FlYzNlaTFRVDh2SjVVVm9rQnpY?=
 =?utf-8?B?ZkJHZnBvWUNESW1oejNDTkFBUk9hWkJUSi9DMVdQMjMxQkZFU3gxVVp1UHNB?=
 =?utf-8?B?QnlXYUhTMndvUmFONjBiREZMb3owdlFrSzlhNTZQQmxocC9hNk9DS3RZVmtM?=
 =?utf-8?Q?NORJEc3tUzEf9dfdrEl5vl9De?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 419c9fcb-0710-4386-fa74-08ddc55621ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 17:19:48.3115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPfBS05yBVyvvv90DwdDiNEPdC6+ud6oWWO8B1kITTzF19r+Pa1jwKtdQ0E+slQ3soqwl6EvV7be7AUPyGmuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com

Pj4gUGVyc29uYWxseSwgSSB0aGluayB0aGlzIGFwcHJvYWNoIHdvdWxkIGJlIG1vcmUgaGVscGZ1
bC4gQWRkaXRpb25hbGx5LCBJDQo+PiBzdWdnZXN0IG5vdCBtaXhpbmcgQ0VzIChDb3JyZWN0YWJs
ZSBFcnJvcnMpIGFuZCBVRXMgKFVuY29ycmVjdGFibGUNCj4+IEVycm9ycykgdG9nZXRoZXIuIFRo
aXMgaXMgZXNwZWNpYWxseSBpbXBvcnRhbnQgZm9yIG1lbW9yeSBlcnJvcnMsIGFzIENFcw0KPj4g
b2NjdXIgbXVjaCBtb3JlIGZyZXF1ZW50bHkgdGhhbiBVRXMsIGJ1dCB0aGVpciBpbXBhY3QgaXMg
bXVjaCBzbWFsbGVyLg0KDQpUb3RhbCBhZ3JlZW1lbnQgb24ga2VlcGluZyBjb3JyZWN0ZWQgbWVt
b3J5IGVycm9ycyBvdXQgb2YgdGhpcyBzcGVjaWFsDQpoYW5kbGluZy4gVGhleSBoYXBwZW4gYWxs
IHRoZSB0aW1lIGluIGEgbGFyZ2UgZmxlZXQsIGFuZCBhcmUgbm90IHNpZ25pZmljYW50DQp1bmxl
c3MgdGhlIHNhbWUgYWRkcmVzcyByZXBlYXRzLg0KDQotVG9ueQ0K

