Return-Path: <linux-acpi+bounces-5970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6368CD800
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 18:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D38F283F5E
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2B8D2FA;
	Thu, 23 May 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSFRLslj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1A1755C;
	Thu, 23 May 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480171; cv=fail; b=BBxnzo3kOA0SzZnig3QQP3umzwCLGZt3eniHgtfFN2kZIbHf5NA1AmiM0jQGeLbFc0j3p7+2iEtAnjxdPqugFPvrgpv4j1n6ZEC1KuJzSICQ0P34RDW4y7pR90uvyy7BAJRkschjiGWI2wQDoRLwXCiETQ1H/iV2wHI+bckZdMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480171; c=relaxed/simple;
	bh=7ApU0J5lcJjWrulhRdM+qjRSWphVwcccT5OdW6hBhKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYRWy+30MLvbeoOhLNa7fhxuv8zpWeUGRlIn9ukSxUnbCtQqHRUdaT5pHQEQFCHHBpR2gtvPZftDme2o9scasyESL6BWoOba6xbjvrkS6ga+xX7CHq3EvQkZEiOgwRPVyIqO35OPiOw/JhUBUnlg0iMst+CWWAr7mNBZHL5Rutk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSFRLslj; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716480170; x=1748016170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ApU0J5lcJjWrulhRdM+qjRSWphVwcccT5OdW6hBhKA=;
  b=DSFRLslj897jBnS6virCZR/dQwiLLkaSq8phmDu/ipyFjK9wqIr20lF+
   XZ6bNCE4CeE+sXlm1o1NMvvhulBIuSfmmm9DJ9Gn9V2FTuYcR2x/AeEW2
   rEC+1okYeNdYRBzMHuxRRVZ9V/r5HBvS9oKki/L6S+SAla8Dc2Cve2J74
   Jq8UGwDe7INKU/AoPlRmA7m5qbmmunaiKm1AXU3I/GMf1H8gLMfobdNh3
   HSpoYN/EeFbnaQqD7pP+r0ua440wSReRCS+gIMxzjpVsm6ZIzma0O+V+W
   QMxvCczsnEN79M9PZ9KfEj/HQvlMZgeuHbWzs1NSzdF0oCJmiclJ8hKzy
   w==;
X-CSE-ConnectionGUID: QbnE3v0LRm2YJxRU3kBEjg==
X-CSE-MsgGUID: F2h23glcT9CZ9+gvNYK9RA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35324484"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="35324484"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 09:02:49 -0700
X-CSE-ConnectionGUID: 2sLYjgl8S/yvlJnczx4kmg==
X-CSE-MsgGUID: tXce8hClRwOx5vc6bK++DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38702417"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 09:02:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 09:02:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 09:02:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 09:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgC5LnULZyRDKiAs8YdtPeaJsjpjKFTR4nO4bKaOhK4td77p9F1Hitx41hcl5rTGiOHwIc16CFQHPceMix+UVXg9pm8lMyPDvzew2HejCKh2/kMTyaqKHqwUcnwFnWRMbhKlXd1rYN+l0S/zn0VAAgewh/XIAS+NiSyyfUurVGOmcQat/IbPbMovBqPJ8YtmB3CD3eBub8ynup8kznIYnBmL1VVwvPR0B5nAMofk1cAMuoolWx+U75CeQfZH9BuRiXnLXW0r39xTZHfYyKq+O2uHz5/SviY4aDnaL8hmQPYpUebmpWPxml6JKHZHnKvZ2+71D4zT4NZjiUcfWhjMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ApU0J5lcJjWrulhRdM+qjRSWphVwcccT5OdW6hBhKA=;
 b=TbUtHVj/9zVd6tZ01HNWJHnm78EJl6ji4NhrAWF0+93Wm8RDwcJ+i6x8wsJ3cQ8AO7ONWvmsMpLb8MjfXvAHWPWaKsJWLU9JQQRg5e3spQqBpShqWgaNid+VYdRAKHx4PTi1/UU/KBtKmnzrtHj5t9NPhoK3OBw1M4ye7O89VMujekjfXd4ZXKF9/Ss0Q2lgeX01DQhh8wn5StbYhrh++8rrbBXtK5k0nY6xze2DyG2XbgYCDB4dH2XWmPfkYkC2zuIo5TeBD9GnHxFGMPEiJN9H/rCHzMzI7oDgD5CDFY77O4b6YsgvW8AKKMENsX/O5UMnCeK9573d7rJYV1ZBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 16:02:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.7587.028; Thu, 23 May 2024
 16:02:45 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Zaid Alali
	<zaidal@os.amperecomputing.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "Moore, Robert" <robert.moore@intel.com>,
	"Benjamin.Cheatham@amd.com" <Benjamin.Cheatham@amd.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"Avadhut.Naik@amd.com" <Avadhut.Naik@amd.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"john.allen@amd.com" <john.allen@amd.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>
Subject: RE: [RFC PATCH v2 3/8] ACPI: APEI: EINJ: Remove redundant calls to
 einj_get_available_error_type
Thread-Topic: [RFC PATCH v2 3/8] ACPI: APEI: EINJ: Remove redundant calls to
 einj_get_available_error_type
Thread-Index: AQHaq8NuQgJGsroEcUGX/TI726xI2LGk8COAgAANJMA=
Date: Thu, 23 May 2024 16:02:45 +0000
Message-ID: <SJ1PR11MB608387C960ECC119B2DF7101FCF42@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
	<20240521211036.227674-4-zaidal@os.amperecomputing.com>
 <20240523161357.00007532@Huawei.com>
In-Reply-To: <20240523161357.00007532@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6774:EE_
x-ms-office365-filtering-correlation-id: 9955715b-931c-463d-cceb-08dc7b41c8d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?R6Oo3rydJWRnHrycF5zcvKgCs5LT7Ka7gcBhchMb/d9H2EYsr4Xh7mo0bDTW?=
 =?us-ascii?Q?/72uY+JOwcQ21rkjfxox7pBt7q6RVBafUnTfC9VVtiksAdzLkRIDxdWts3mx?=
 =?us-ascii?Q?XaTj7s8sJw2vpCt62RNkeIbQ5X3Qz1RYXHRMMwp7NrWMwXir6stkUrAvV1ZQ?=
 =?us-ascii?Q?jiWQkk72o5ZjzUsxgbF2NaZHOHvf+mNgvKTRCGw/Qw/fvZE5iVzmV4abT9oI?=
 =?us-ascii?Q?vFbEL3tSHhVxnRkw34EOtSkdj2QJfbivYaBGbmiEmf3TaMHZVJpc8p0r2ZjG?=
 =?us-ascii?Q?VZR5e14WS7KD21UjYvur7Ul6oyMSrFcHUNgCZ9LHyE5ZnRpLfiUpnGctE9aK?=
 =?us-ascii?Q?Gz6jfmqdgKYwItCo+qw54IGNL6+7sc51crMhJloXK77ps7x8mgh3h7a/+g+o?=
 =?us-ascii?Q?Zu0887WDADSgMlL6KhtkIWs654enXmGf4BaOKJNSrmZFsm1DIF7CpIAOo6lu?=
 =?us-ascii?Q?oSr2ARnLSljmTm2cT21NVg6zhBRjIHPERNO7pcp3MDFr2GQnm8Nk3kWc/RvX?=
 =?us-ascii?Q?PvpT0ly+RkXxn2Qz1rGJ17cvCRpXBtmVBJRl403M0mZa0gr2q78e+yb4Ue7T?=
 =?us-ascii?Q?7ytsP0jt8kdb3ISEU64TP3LhvVXf1fWmI3wUjRuCxXbzofN0YglqVWguFhl7?=
 =?us-ascii?Q?LrxLAok/etEVizEwEfbUckgjjfvrYqOhBCfdTVurNz/3RRAcNjPVLcdWRBwN?=
 =?us-ascii?Q?dM8pwax99DjSVj/LXulJ8YS58HWVsctclRtB+X+5QhvEg4s9jwf0UYgi08ld?=
 =?us-ascii?Q?UJ1PQCTkGCNVz5e8Pw1l/xe4fNl+QaTwWIa7v0Y0qwlFJDcuI+rtC1YMCTDF?=
 =?us-ascii?Q?tuNvDnGGQc0zXbMPMq+ENV2cGIbG9HWHLLGWxX6jLiRCbIErUyJWOLy/U8CG?=
 =?us-ascii?Q?jkrgFL2X0PBWdgHLxKpraZpqAuDBAFa+YDh1YQADVsiEyu+h98ez8Fvrf4ld?=
 =?us-ascii?Q?8jP7rb4LUxgB/ubHDvNY44P4MnuL3I4+ce/csowjRCVN2jAd8Q5Z22ZdGwm+?=
 =?us-ascii?Q?ukM4c/z/VFJQIjL2hd3qCdvHzdqnQxWUZKlLcpeZt0/m+6ApzpEOBr9aZYL/?=
 =?us-ascii?Q?hKd4+idZRxEV4JOtUgPeru/LKtDd6oA+NKHoqj2yezQn6QaZIyYYlEKXzoyH?=
 =?us-ascii?Q?boplCvCoOVIz+h/zpz0Ii7gSwx/XIDjSbInJkg0M0oLeI8e45+Zed0OjVJsW?=
 =?us-ascii?Q?AaDjsRHuMVgrbQyvzlt8OjUrHI5UsE1fndHsNAM4n9mn4koOU/SLUt94k5oO?=
 =?us-ascii?Q?AMuf79EkMvdFQK2gLQryNM4jq2KmouJ7NJG5uqBDR2+UPVC2jjxuV1fU5k/t?=
 =?us-ascii?Q?uUC5JLJgwEYZ0A+n0+ahRcTbrJElC7x4oszUw6R5myY6dw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wkoQskOnoL7jckHc0uxS1MyzrNN36lhOoi9468Vv6XqLeT9Brl93vphuZa6?=
 =?us-ascii?Q?uD9ay54NKGNo1i6I+Fw3Esz/8rXty/b21tNPzOauWITsjdtBAh+80qkFxBQR?=
 =?us-ascii?Q?KCC5hB00dIAo8b2CalCgEdrk2mbEcHCJdBZz7c2IjUTEEpZtMkpgOdhLpKPC?=
 =?us-ascii?Q?+PCsB527BpwtBJqFt8LJXlaOtEmsk4Rs6eVlmUnBvL8tQ7KXMG+1iNZVlQ8C?=
 =?us-ascii?Q?5jGC3pZkCDXKL8eUoh4FrA6MGYCXEtWixFM6ZdXz6GYLJW+DTBQaoPBxMh4Z?=
 =?us-ascii?Q?F/n6H9zTyON9/Gb+NlRN3C/CX8LGo754Ke77MrlgIJjwDBQnnDddCPkBD0Yl?=
 =?us-ascii?Q?6LhLAJBKpGiDYKhbkRaCFRjk9q27+wnGhrvJfRMW0vEt/3f+XwJiawA2n97e?=
 =?us-ascii?Q?aH5lDmw6iXfCUnJFkzvlwaXWFVTPtrDD/4ww7+su/cEaX4wVw2alsuUeKxmv?=
 =?us-ascii?Q?tBUrBOYuEtIc3LnIK7WlKQpS2CJGno+7qS/gvixiKy7b7iyUpwy/dYaoQUFt?=
 =?us-ascii?Q?ofQ/BktJ93vm9DvDQ4b9EW0vu9gAQivPj/Jg4z+5LeAm+V41R/w/8djQ/OvW?=
 =?us-ascii?Q?F3DXuVIrau2ZkZY2aES+hoDaRDOtCWWFdxMcXN8ba1d7zAUdX7iU4iw2Y0FO?=
 =?us-ascii?Q?hPwhbOC3JS8uC27DFod+IvV46reOLaQB7URtX9SnNE/IftupuwiTugwB1Nes?=
 =?us-ascii?Q?j8RifzmMOH2PNDOGxGHtr3nDenPn51D63LkeoPvw+4ttTuh375cKYLbyniPZ?=
 =?us-ascii?Q?IST7PU3l1218ss5fqi+1vhK+Nw/2fp6aYVazk+ApPpgjmsUVEwVYCGBaUI2d?=
 =?us-ascii?Q?KVx9hLejTKbUkRQDE7Hu0FdURpTaL18m4hio8qBMXrX/7Y3U7D4I37eLsGqV?=
 =?us-ascii?Q?IOhIMjkmgIqdIRfBd1+SpAikUiiV6MIluROnNJ2NnshZUTC6C44hqL2jnYM1?=
 =?us-ascii?Q?hcsMmUoX6vdSVmddIzA8YTDQpcptxiiu5hc/iFJ5gL1vdJPzEeHOmeOpF4rm?=
 =?us-ascii?Q?hbLx7XgvdeOElrzIpRSNoyePO6BGGOvyRT8poa4ZJZB1XA2NNbZ5RwziZaPx?=
 =?us-ascii?Q?p+9K/JunqbDGysNF/D/XFwUJ7tpp26MAf2/4OndzBp6xq5jwSemG82+a6xPt?=
 =?us-ascii?Q?IEWuEHpguWAO6ZUmzCX8SQS+LDyDUt/AzyFp+l++gvup6zHf9P0ZoWfyva60?=
 =?us-ascii?Q?Ikm0X2eZAVMgHrEJqmqnL9R4TsuGtd4ZFTrMI6OfIJHbspt2YwD7vr2oHYHr?=
 =?us-ascii?Q?idAoWWyJfhuIVJ8SRaz5LE6bEPmTbp6Y95dFRlhUz6A4LXJcADiKY074Mv6d?=
 =?us-ascii?Q?iIX468xIUtFQo7qNFc2n6Q/guDZqXUlOpyPvSjgHVKAcKSh2tbWZQzC4mG3X?=
 =?us-ascii?Q?VVb+a1t+skhRm21YqFdIq7AO/Bl/vgOmroWFREqYUhZtPQ2EbFFEF9/N6x6Z?=
 =?us-ascii?Q?cTfiqQC4O5zekxYkNRH/QqAYpRl+EKOgh189vbU0q5wdd6JmRniQ1Ee7QDZk?=
 =?us-ascii?Q?fUUMucoOmnNLpoDVB2lMHB/BwJ7uT1K7z/Bvi1ggMMnmwW8J0MXfyccGCMYN?=
 =?us-ascii?Q?0AROSFrL+8xYzDiecUH7VKX+alLqA/Euim0HOKUP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9955715b-931c-463d-cceb-08dc7b41c8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:02:45.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7M99Pu7kqkMYYAIgCtVmAz4FgUjeSIgAJ3Wjw7TGeXkO9gEHM3uWX8zhMjKmNBt38INQ4tR1vrAwxCtoif7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
X-OriginatorOrg: intel.com

>> A single call to einj_get_available_error_type in init function is
>> sufficient to save the return value in a global variable to be used
>> later in various places in the code. This commit does not introduce
>> any functional changes, but only removing unnecessary redundant
>> function calls.
>>=20
>> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
>
> Seems reasonable to me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Agreed. I've thought about making this change many times, but always
distracted by other issues. Thanks for doing this.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony

