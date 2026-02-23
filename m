Return-Path: <linux-acpi+bounces-21074-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKBkHVyUnGnRJQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21074-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:54:36 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107117B251
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89D26300B9E4
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8FF338910;
	Mon, 23 Feb 2026 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm+tBoUj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3233123C
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869274; cv=fail; b=EY8+ZleUDP+ocwtUpW/yQ3p+x8ymE/bgnysElNrxkaieViC09Rf2XM7CRJIe7UXNiSXUeCw/GfZR+X6tuTC/AOO5kpmcijmHn2KCvc/veVcsV/DW7EEoCKzdqI5CohlQ6pqA/+37Qj+u32seG0IJM8sIEYhs8NOiuA/tjUoyvJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869274; c=relaxed/simple;
	bh=uWvUyGoy9geRPAEmHmYrjDlSKXJOdipvr2CqOVC9LFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B3kHxjguFwG05r4mw4yg4lfVbjUFm/9YluIsJe+PypQx1SkDlyBmgSHKg8IqPrATS5CJV/0T/+bNkfgb80KEavhwmPJyMr5i64A0raesglWoE4Wn13CfAraZo5Mczpwm7wqI51ZM/GoGEr4/zQHtqlFza5VIVw44nUuZVBDB75A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm+tBoUj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771869272; x=1803405272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWvUyGoy9geRPAEmHmYrjDlSKXJOdipvr2CqOVC9LFI=;
  b=Lm+tBoUj3Gnndpnf/NtnCcmtWiif4AzFZk1a5HhvTKPlWN7xmVzKMb8k
   Ri59wXDs+5t6SbGadQg/QcfkX5l2nq7A5Rz6aQqeBPhewyh9NVKetzFBd
   96yYGEcmzjEnHUSeWmnbuju2qnCZlrIS2+BD5dCe83iLNImScr/Wnx0iq
   WKm5COkl75iBdhVCS5XusRRVlJw8PHEbpB2dfXrl/ZxmdZOrclYnsY5yf
   BQvbxaH+5mjb+rjcyKgXyv7DzBvEL75du+VAUabBDmR4HiSRlbXL39UDM
   t57BgFxdn1LOzIT7KhkA4TiWtVPDM4JIA3tgQ1PocM59+F9sj5LRL2Z8l
   g==;
X-CSE-ConnectionGUID: ltvltrBtQR6lRFlqiTCOtA==
X-CSE-MsgGUID: jYK8yPvkTDeHEMarGaIPHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90278272"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="90278272"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:54:31 -0800
X-CSE-ConnectionGUID: qpNH1h3GTuyrQefGw2Ro6Q==
X-CSE-MsgGUID: V7plxkd0SkexZCMQY4FmVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213962949"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:54:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:54:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 09:54:30 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:54:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/bPLLUUBDvg00N/gzkcoPNt0lUqjr5L0CduP1N8CcS2wPAIrLChFca9BL2SOeJZglsAr1J7v8hm44RK0Vt9Mzl4MvQ+RWWcWncXnB9EQ+v1IKR6p/opd+VYZrJ5jnEfsTLRr75N/L/4KDisMtV5Jq9COgfyX6bsTHDIqEptFnbnr/75APUdeTCkIazzExJ/UqwDPpUquN2xHbkQmMMOIpFYdnv7XJcaTTkNTvbtJOJOsXzaXvMTk1eLSbqWhQb5CxspPF2Yfs+8ucR/cLjaMOkI8HMmoDMevGmY1RoRPjtxpXL0D2OtAXeWkl5+39r8er683tKHVL+cvBRmhrI3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWvUyGoy9geRPAEmHmYrjDlSKXJOdipvr2CqOVC9LFI=;
 b=P80sbVUT88n6elFx03hJ26HTNqgfClwgwufEDwHPfkAzDr7VIFviiKqC4Qvjbr+VnqNM7R1xmtQnO0dnLL1HOBEZ+RDIjujWXiFmViJr8AG2O6E+mmUEGM1o6u/HkCr4+M6KqNW8QGIFuiuSGowtLBiRIIIRZyKs8pwiMOojByb2+PHKJ2MfUehFwrdc7qGLSpxroo8qe/MnCrkTXpiKd1weo7hK8QfD6bQO60qL35rJ586dGtlKYH/9AV4A1VgLTHcy0LjKkrLTtS87l0XtAQc7JuN42S0Qp4smVGvB+Gu4ngO9Hc92Hb+BE0uDxN36uYz2XHX8xpAwYShLpKkEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8726.namprd11.prod.outlook.com (2603:10b6:408:21a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 17:54:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:54:27 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Desimone, Nathaniel L" <nathaniel.l.desimone@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v1] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Thread-Topic: [PATCH v1] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Thread-Index: AQHco8TKkoKvD6Rq7UmnkSMZ068A77WQkfvg
Date: Mon, 23 Feb 2026 17:54:27 +0000
Message-ID: <SJ1PR11MB6083ECBFD999F240987EBDE1FC77A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
In-Reply-To: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8726:EE_
x-ms-office365-filtering-correlation-id: 72c0a735-cb59-4584-d0e6-08de73049640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?sKHmfn/eFiXqsnY6c9kzlc+HLK6iCMQaAu69MVmi8HA51WLP2a5HdghwFcQc?=
 =?us-ascii?Q?SHnyJ2W/rd3tfdWCA8VLZawiTBHxWSorXmtHyejZ0WpB+bfVvprTcYftKTU9?=
 =?us-ascii?Q?aOtKyIF0fxOTm9DCQYl3hsUNIaafD/n+mVmk1TCjxqkMlN6TsWjvhgRWfUD5?=
 =?us-ascii?Q?vKJEcQf4XxM5Tuf6MkwSZkNcZSOsW4ifqZEpkv516W0+ftLj5fRhrjTqAlc+?=
 =?us-ascii?Q?Sq9TfzcbrPtaSlMMD4xVf/kN4+uvmhkq+nw2eBWV1HSw5xO8Y16VrwRl+iYh?=
 =?us-ascii?Q?IbOidqtI2tobh3nG/SPNwjOh9yyH1gsbb8uJGI7NC0Ijnam86k5PCM7BGe+3?=
 =?us-ascii?Q?od0WNzUZnR0ShCv1IW1Okg0+dhuDFEWl8RcK1idEmYPIbtfMSmFzNIbrVCor?=
 =?us-ascii?Q?DHWKmwrlnOEAGK0WWcMn0FjI29EuLrYMQ0fvjWQurVOfXYlaNjWRXtBdNI6B?=
 =?us-ascii?Q?OzScoQMPQELVtAAdFNzIwPH/XLabEiBXR6k1tzSefAbbPqEwO3RKyEROmbWi?=
 =?us-ascii?Q?fszKiMV6WZZnvh2WoqcBF28y74folaq+VLWjsmH57/Rgxrdz8It0rXo9v8pI?=
 =?us-ascii?Q?ymht3l0DnjCm7ZIDT/5mVThBm/7gbCULKaRY8B036DA27DHVKx6e/ta7WJRi?=
 =?us-ascii?Q?XSHlPvlsNtnwYDrZaRWvK5hWahcK2G7xhSpij/7aiqM+XLPr1bM1z7jdqej+?=
 =?us-ascii?Q?JnD7b3/KZKwVBSfubWwA43C+V2nnl/Dqqx/k8aUK2x6IXgZszc1wig9aw07T?=
 =?us-ascii?Q?XFRFx3aPw83bTy/J53q4Jp/binGGaouWVB/DH5Fsd4oX+pCYI2V/OJgi8edu?=
 =?us-ascii?Q?a1k5nc2BjvmLd82xNexzqBtSiG57mgq0d7g2gSQ95MlqWuD1stSVm/gjwXVl?=
 =?us-ascii?Q?4yVvN0GgR6cnwORBci2WDpsS9UiSsv+mLsKYMrIh06DEWLK2uT88DfEV7/gJ?=
 =?us-ascii?Q?tEWx3Tk3KDJfi29UE7iSC1XqRPH8+PunOMCHqKDYb6sasTsYjhwd3jRl9urI?=
 =?us-ascii?Q?OguDCjvOezvf8KsCesnKYuPHvl2ZOpo0/TDa1KBxMXtBPoPyJSMXdqPWU5xz?=
 =?us-ascii?Q?WW7Yb4EQhFyJ5bz8a6S/azKbQZIE/90R0kQ6MpNIDFFKptBiM7AQxU/MBIX+?=
 =?us-ascii?Q?iyVpGD2nmefytyFMFrerUchZf9E30fZZb2vGEuDaL6hHbgSUI5lfW/R/4EYZ?=
 =?us-ascii?Q?IVy6CedSykLbA4Mop7hRhsSuXcTDR4Eu70laBbxN0Yk12cBgEubPkDClKFJR?=
 =?us-ascii?Q?VuldM+vFkrgElimnulHW4crqBqyrx9e77KkcHu9DioCK/QGlDZixWPU3mHAf?=
 =?us-ascii?Q?MW/SnHzooxtIFLukSvH0Fn3NJ0JJg7luhZa4hOfEIsUKEVY5Q+I488sRWCeb?=
 =?us-ascii?Q?hrtRjDK5YeQHMruyTSWk06Vh3iK3CUDlW6jqeqRz0ozMk0aLMle8h+hgCD0t?=
 =?us-ascii?Q?CykqL8vB4wktBKxWY1EGmUmFG/oyyvlwRmDtgXZdj2CycgeLFM+TVUrApBjZ?=
 =?us-ascii?Q?sb5qsvBXMCTIwGJ74uY1SJgFg+oAbm1PRfOwePyH6Rxgw0WU5a93vn6rnCCG?=
 =?us-ascii?Q?0mN34xMdqw+n16m4XSWhcbeskekSfoUYKzh77eY7Ouj0ZNfO5NKoQZtBd12v?=
 =?us-ascii?Q?hLnzEJw21FE4K9kZCaP0Ve4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EL8moabWiBvqwV8LE3BIpLNsvIO8z8//RBK8/ygSkU7Inop7THZ6enmqvF2k?=
 =?us-ascii?Q?kGjLadrGm8Lsw4jRtYkfwspGZHXHbZSWJp9U9LucgFGpt9EyMeIMpW2yrPj7?=
 =?us-ascii?Q?En1+V3Sqhst/mdxTwWolZTG9Mux0b+f3RXZ9kQaQHg35rDrNKOptB1UPgadk?=
 =?us-ascii?Q?02tB0Gf9q4gNrsAKxsMkhatmlXfUWfoXmcgOnG8tATWUH0x8714y+4JV/kB/?=
 =?us-ascii?Q?Kj77Yrfx2avugvPhmvGM/Ro/R4S5rkCZtMfafCHa2SljphRiLKwc66KkmXYr?=
 =?us-ascii?Q?UAYDe+GsVX0rYDne9TNUGX7o9CZzzCJhLjUIgdNUYGzXOEKDkBCxraLMxgke?=
 =?us-ascii?Q?gq/xOZs3/NpiUUO+F8jQcqSG6pVEuGA52vmGUQxJzf0xvKjELQ61ij1LziEh?=
 =?us-ascii?Q?ZWvCYWRKopvZtDM2mRaT1LlXQ3OENeR6dGDucwXdbKqGME/dKazQOpZI4vqK?=
 =?us-ascii?Q?9bBgHKwpDgiYtMj59Ry+/RkmhgxOp05pqHeg70CHhVmW1izv83q7EjmXryzd?=
 =?us-ascii?Q?E2tMpIB+iaE8lwzWiWp6iYRI6xI6B6HOgtNkwK+a9nqwA5YjGt0Wjq65kBDe?=
 =?us-ascii?Q?DeqhuakKoY2ZZcSktghAwbcC2XhlzGVZE3npfKzdzqvGKwYGNC24luwiXUCC?=
 =?us-ascii?Q?VGcW5qPPqWJVK+6QHFxk/xoVeuGJyfUEgovv5V9uc+yzPl615LELT4KwywUO?=
 =?us-ascii?Q?o7CzM9/WsHoI3L1Z0XAteB50c5iV5JDx1KIpd/dryzqFI9hnNlctpgd8AHo4?=
 =?us-ascii?Q?srPzCZfSg3s+fL0LVo2kcitMsTGCSbfDSjigaPjiOMShs/ERJcWrbOVCaQXT?=
 =?us-ascii?Q?G+K/dElpqs4V93bSDxGg9z+jfU9jbCo//RKmVesOVFTcyJKUmSReDOpsPVhk?=
 =?us-ascii?Q?X0rOswN0gDy4EtW1CDmecPWCEVL1g8PwxUCkDYwO0qE/rOn6uz4Wl5POImx/?=
 =?us-ascii?Q?a6EbjTLX6o0IrBDd33tjA+9R26IaHtFBJVSRv73b68ZiYmRbCVlkNpBkxfb+?=
 =?us-ascii?Q?h2ttYRpeuNMIbpmo5JMVxwdMxiulbyQHxwIje8jH5+EuMK3cuiISV1Gq1hpw?=
 =?us-ascii?Q?wMjo287r2iuGrqqz0QlLUI/a6dJWKI7MnSotsNXSHUCVz7I0Ps3WPWCDtQYJ?=
 =?us-ascii?Q?1VtAnnPDDWHpsijHgz3ipXqyi0EwcSunQ++7jEfpXjOczdMhOn3CVuBjeUOB?=
 =?us-ascii?Q?ObMg3M5DMBR98rhcMAn9PMzNwvdcobGr1Ap+nQT2cIc+vkLmmdQshfv8N6dP?=
 =?us-ascii?Q?Bn/6JVYU5TZ3emDQrPmFv+JGW1YIX4Z7vayaTiISFcL34a6Hj+9K5q3HJZdH?=
 =?us-ascii?Q?bg3Pbtis6RmW6TfpxVKTCnQjKravYIpzdfGfHjYj3rwuZRNOzkgxgNUaU0Vo?=
 =?us-ascii?Q?uZ+XJVxIffk9Iu6KgurC5EgPO+RTIwULX+XUTiO5xe9xrYk/YnvniIjvtJVT?=
 =?us-ascii?Q?4XZIv+bPTXboYqE1oZj7+C4N3/Qgm63d75GhEiWYr4ZPtcQZ5kkM4DjBUH5t?=
 =?us-ascii?Q?i/nZcBPZUubFfAP1WE0Hwe+c/YVkntOBgyJrTDMceMhNQCvv1W/eLICzWAa0?=
 =?us-ascii?Q?See4oT6Tlaf/xrO06ttKFzpF0Sx4YaiqFPoSyvHWvHE556LUb/ZzVcVyX28D?=
 =?us-ascii?Q?2UYhQndxtSEQfXLtL7pN01R6OT+UaPcLahc+WuyFHQmgjPXU8wsv8ULDrvp/?=
 =?us-ascii?Q?Co0GBKXnpb+bQ/DzaMiNM2tuD7s/1EIQS3rfK/nCaKnowBNT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c0a735-cb59-4584-d0e6-08de73049640
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 17:54:27.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkFEdSsXfbxQghuq/+0QEei8un1RzbjsZsUxgned7qkV8bA2VPF/B5H0NawGkJB6a8uWwaoP00knPW2MQL1duQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8726
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21074-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tony.luck@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2107117B251
X-Rspamd-Action: no action

> Add sysfs attributes at /sys/firmware/acpi/fpdt/tables/FBPT and
> /sys/firmware/acpi/fpdt/tables/S3PT that expose the raw contents of the
> FPDT subtables. Note that /sys/firmware/acpi/tables/FPDT only provides
> the top level table, not the subtables. Adding access to the subtables
> enables a usage model similar to /sys/firmware/dmi/tables/DMI, allowing
> userspace tools to interpret newer record types (e.g. String Event
> Records, Microcontroller Boot Performance Data Records, etc.) defined
> in recent ACPI specifications[1] without requiring kernel changes.

Is the existing (for BERT) /sys/firmware/acpi/tables/data directory a more
appropriate spot for these? Naming the new subdirectory "tables" seems
misleading as there aren't a top-level ACPI "FBPT" or "S3PT" tables?

Once naming is resolved, needs update to Documentation/ABI/testing/sysfs-fi=
rmware-acpi
for whatever names are chosed for the new files.

Code looks good.

-Tony

