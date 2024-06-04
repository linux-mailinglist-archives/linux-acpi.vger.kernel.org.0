Return-Path: <linux-acpi+bounces-6165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C58FADF8
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD561C211EA
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29CC142E82;
	Tue,  4 Jun 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2KkRJmM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607D140384;
	Tue,  4 Jun 2024 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491012; cv=fail; b=GpSzb2pQKqISdvOQrnJEtiDl0EqriWnJuYccI7ymPe9JPpsgf63UfQHMhUu+Kfne1qXGYv83gQ0PXnxuG8/PBoae7Mx9ftfzy4yh1k3K6MbXROS6Ss1Z6xqgOmfXbeT0fl2S8iTwYks81U6jagTXMOwTlqIKA27RX1bdBAgEq1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491012; c=relaxed/simple;
	bh=AvvMfNV/XuqIEIFmU+QB2XeLjL/LfymZVCyJu9sRZ+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWW2q22KQmb8r1oW6sSpxczaBLhbMMZxIzNATatr0e/eE8421kaHRoaC0IqMmGs7sl9XOU1u+e44VOPT/knsfv60RQBre6XRouAGQZqJLm+y0AxVWtyjH/IluspEd13fSS9D/bmRfvMUzyfJaW2wTPCV8WzsXL1c2evDLP377ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2KkRJmM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717491011; x=1749027011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AvvMfNV/XuqIEIFmU+QB2XeLjL/LfymZVCyJu9sRZ+w=;
  b=V2KkRJmMvC4VAxPp8qrfW1jpjGlg80HB9MdE8iw1b/m6aBUAuI0oMHm5
   ltcLVPd6fFeCamuakgtwWR64YO3gON6YOPeCt8ZnFAN9rqMBDpFHRsyz8
   428yZJy299gj4JaCcsNp9JGE3skiJ/hS7fg3tMxaMrNwWU/bCtxwF+sXF
   wvCYUbCcjcQz8isf/I37RynUrBhFWQ0EEF7gXNhtwLoiJ+jX3oMvXZBrr
   yG0qjsrbrmXdM2lXGivOemMio3XRNNyYRQyFbKyDB1XHpjhMt2RhvF8au
   le5XeodobwTbPuQuIQ4+iu/Znflv0pwhbkLnIfGHt44dgqE6UOrYLKoKK
   w==;
X-CSE-ConnectionGUID: Qtb3suVoR5iL4g0Wr06DPQ==
X-CSE-MsgGUID: YsjPnLliSEWLcvbKDGmm8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14248116"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14248116"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:50:10 -0700
X-CSE-ConnectionGUID: DgxGUumDSYa7eW1TcKl2eQ==
X-CSE-MsgGUID: CYe25gXjTliIcwfu6Qf2vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37755695"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 01:50:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 01:50:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 01:50:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 01:50:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 01:50:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqfH2tgibX8mqj7Zav7aGkiAloI6jG44DMEnaXTp8NJnG20+0cL+jeh9S5QYlsihToWQYiNv4DPcyClwKFzCdzTMJCRm7pyQZQFhNONYm+FDncr4TlwgF1Mf37LGayaSI3CXFf9b/PuV6XO3Oy+I71+1b8JKevSubW64ZBDdLd/eGumiQFVBcg2JwkEMPJ9UZmfkfmAp9JY6KUbK5ckRX9lMYdh3Du8PjXg2YCqEcLI5xYz//OGXIBsAiAsiKPQX8OUTms5yBQTAOy7PMWX/WoZtAbdo2riwwHLAd336m0uC7DKwmKY+ttn2thszYwj2xgp64u5EErH+9N7ic0Uh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajkFUJgRf9vtWzvyqoDDGvwKKx6uRAGgdiAB5WD8FZY=;
 b=Q4kssjrTCsj1EzxArLswwPRa8UGsFjQn/ZiqxUEgNR6/hjN8VwI+1puC4Ty3zD28Zlu8NdFQQVmLLeQ5O6rcHGec+yJxIRmlHtuiTADG5/+F/Ccan3/sYiIXCJwOlijotX3OZf73dBvEPdbzk7w4bSXankc0EGbzLOpXDJO8cMWsa0vdDLCK0SmrZ2fWhj68zTeD6SvgViZpLG1gkeCENkaEFOAST7AtdUZ4TJPw9cGSvmKLR06xZNMzwTk+4m8yk2N+RDXUdOopwLcMH1IVCVEdBvRfJxs/olkPeIqXUCErX49neskcjx6SNjTxFD/KkoKvsMlv9wwSHGQ8Io3Z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.30; Tue, 4 Jun 2024 08:50:07 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:50:07 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Kate Hsuan <hpa@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: vsc: Fix wrong invocation of ACPI SID method
Thread-Topic: [PATCH] mei: vsc: Fix wrong invocation of ACPI SID method
Thread-Index: AQHatffIyjLwaCewn0OVu05BGV798rG3TAKA
Date: Tue, 4 Jun 2024 08:50:07 +0000
Message-ID: <MW5PR11MB57872D175B07988AF791E7558DF82@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240603205050.505389-1-hdegoede@redhat.com>
In-Reply-To: <20240603205050.505389-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|DM3PR11MB8733:EE_
x-ms-office365-filtering-correlation-id: 8095b5d3-e219-4285-e841-08dc847355b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?j7pRSedMWvQLSEOEQ876URCVPYahsHNV+u89ag03AyPa60tPuiEQkS6aUjnX?=
 =?us-ascii?Q?uI8xNbYbi9OlxZiiC/HwMRJkSORpnUu9zsfCnkB4Mh0VpypVDiUOo2kLx+Mg?=
 =?us-ascii?Q?Q6KzeB0uM8sGd/ZnZ6liUgkvKSRCLJgUcuP9WB2UIJgmM3AeFF6IUAuN6iE8?=
 =?us-ascii?Q?UMKj916RhaDjvn63GmqyQfM2lCLL2/QBXJfexPcGGwn7PVCzH42ICAmaSOuO?=
 =?us-ascii?Q?1R7OVxMIQAmEHgkUikPEl2RHSi98yn55ZZiz98yUaqDl7u50wwYBSU93S9aB?=
 =?us-ascii?Q?zsALzw9fAtoEh84xmD3SHTEW1Lo1UgEWlHg6otL3aY/CZfnyziJh/aHQOb96?=
 =?us-ascii?Q?IaYU0DRcfvdhWtqmcbMEQet8jWmKPiiD0FGVGffGlSfOi8XdU/L9mzgKtYn/?=
 =?us-ascii?Q?dT3axO0HL+7BP2/2Id3+xLYmejdG6tKRbZVL98D1aSUprfhwUsEgjhz2MIPj?=
 =?us-ascii?Q?kcdmPjBxadB9meoY3HiN4925Nhqz/ev52Us4BSacRqiAbi8CWEMwX/6P3Ykq?=
 =?us-ascii?Q?Q8ZmeWDGRDbAXc/tnV0bnAey1yd0IIq/ANBLbslKpy16XySD8QtNFEOsLgzP?=
 =?us-ascii?Q?RHFqPyC1r/EIWpVS0x6rNgBoX1YdynfnGQtslwBumpEVHDf/kC9NCfaAcwC/?=
 =?us-ascii?Q?Z1U5o8lJQb8n/2OrupMFkLsIFs/ZwBGMw6YTlANkTkSto7aCVSRuGT+1xK3q?=
 =?us-ascii?Q?0LOjfioVik+KZfPzJ+clo7cyf2tJlPtaWQgUAwt7Sr2k5MJ+F9GU41nJfSXO?=
 =?us-ascii?Q?pZCXjdpUK6HfwqPl3zah8EPBvMvNRCJKUj3nV0sUTsKB0LGqdY+zRSdSmjUn?=
 =?us-ascii?Q?v3LqJeM4XoGizrkmWtpEojM9ssS3hxg2mFWXRtGRS5AYYlw8qj9TytdOaXpj?=
 =?us-ascii?Q?EjRQuZXgQHVpcRqNF4CbsEUa04yLYA9+3hrnzWRfHoVCuSDjOWdCYyioJlNL?=
 =?us-ascii?Q?79n4MpWgN3KrknCUtYo/uxIDUKz5a8hDp8dJg44qX/pVlEzmUWEe+YfUwdrT?=
 =?us-ascii?Q?GnWdI57NksABtpq5UtCfFyVirXgwgGPdcNV5WBqMEtacto7i4H94V9lRh0yb?=
 =?us-ascii?Q?GfAd+wGg+3vo1uazY4i6y+Uz4P2BNdYnEr6wUcnECkyndThDpv1AFs+/shWQ?=
 =?us-ascii?Q?QofxhGUQJsSuhky0YBRnwN7l4+vcRy6F+f0SNxY/+yQ908BXt8bxfNJTQPHA?=
 =?us-ascii?Q?nhdAQLIOZWNf3oOEq2xLmMn2bw/FWY3GOSQw9nMHUOsbqvIACjgaiTva7P6c?=
 =?us-ascii?Q?nvMRp+ewECR+erTZTDVyCbBQ7H2STlpSNgzQoKTqv314EBhpY5tDnpPAw93e?=
 =?us-ascii?Q?Ek6EC3KMnCXhyuwNCA9gbFw2hIow/yReylGtNpc+bakJ6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uGg0yP64WIFdsn8pg8KJk4gWdAg10wkRS66i+VQvcEhYyyLKjDJqpU60z9Na?=
 =?us-ascii?Q?E4J71lTJxwUUBph8gPmc67HvFsqbEamhw86xQD2jhbUujn6Ka5oiVREbLiOz?=
 =?us-ascii?Q?eSNl3RyRCZjxrKYeG9VPNPfRHqsY29P6EWS5fXGHLOFc8WhNm6Rihrwvf0ZU?=
 =?us-ascii?Q?7pvXGspnB9l94WjYGbH6OoX/ft124SYOm77v4lkAMsSOK6s1fHfmVpgeDHsx?=
 =?us-ascii?Q?qpA2oT1oc+eTaYM/DST0TAK4LhuN6Kkx/XZQNsfn1QbRGZBDxv+n1FMKiR9b?=
 =?us-ascii?Q?csbKM1K3v73YRNDLxKgFBpjGDS+K0NxUr34Dmis2YdugYMmxqyxrHadz0zNQ?=
 =?us-ascii?Q?KUlEWobN0XJeFSRhU1FykmI0h/Thg0TgGdvh9gboS4Mr8UvidV9xZSZ+wmiP?=
 =?us-ascii?Q?IdRE9dcOEJPblGonAkaw8oscy51r4xZcED9FPxxTbN9jsbKzSZF3bUmb65t7?=
 =?us-ascii?Q?o4PQIdmduqeuLgXSiMC6Xr2K0Cq1QgyzhNwH4PkLZqqQ5n1ct+6CRuuGSLMY?=
 =?us-ascii?Q?kzA3+V9Yp7kFJzCHhOPpDbKCCPRtujelw0oEVSJlQQ/zTaJ1GD2o/rR/vpLk?=
 =?us-ascii?Q?0TGpzY7OLgeyIj5uGKFM3XnZ6uNb/7VZ/z3ioctTo9XDyHmbLKKrZUec/n8b?=
 =?us-ascii?Q?W4zsBBeXMujVyYkw7gfo9OVbepu9Ft7TqiQe6sgkvVyy0+aPVwgaXxEMEiID?=
 =?us-ascii?Q?WJqJPmg7vFRAMokHvoGxgQcou51P11eHUBQBfeMFeHmcLvEUfP7Gu8yi5XVs?=
 =?us-ascii?Q?EZ1SrqNcqEh/IkXwNfqkqk8DfaywgDWrqP4kwWnXGWr7XhTXPN4/xx5WCnFr?=
 =?us-ascii?Q?AEVEgpJtIxFXQb0m/3GYD1ZZ+i1heorZdNhVrCDAvtAIeid7SLBpDD1cNBx3?=
 =?us-ascii?Q?ffNmCosV3ggiL17thXTtlV0vBYVOll5mVPVpvZSvKJHpHgEWODNLCwjCTZuJ?=
 =?us-ascii?Q?QJhCy5IzEm7uTcq4KSV7UhmbZoaA/K7UqfdbBQvNIEIOrOl1KYRMcGhCdkBV?=
 =?us-ascii?Q?U7nP76PVSYEjzIfEID8q5x+1e8RkpmnLNb2zRP8WYxk5+/YZtA7UCeZb5YI7?=
 =?us-ascii?Q?sfmM9Q5whQZNhF3eegUDi3pFNvglDym0iNPU8RGkRezRYYggdqVx+gr6NZwc?=
 =?us-ascii?Q?C8EdfS1xbSu5KHFDmFvA233tHh/UvOJ8gz4IHO590eZEVnzrDM5L7+8epsYM?=
 =?us-ascii?Q?6pN0S3LI9U0X7jnFAuiWvTWpOKX9pQ/pkgByiActGUujYoan0IFkiOA6SAv7?=
 =?us-ascii?Q?qybnRzTHE2xRyt2ob+/MRns5xnNHg9MnKJmkCXBRBTUuBHxaY8e5Nk6PXQhs?=
 =?us-ascii?Q?54ngxIzSo0qhI/NHPMFAKdT/nq6+0O6Ycvp+VFtq0cy5EdGk6eciDMcLMj1Q?=
 =?us-ascii?Q?d9/cAGfeJrM/6mnaRh+7seiUrty08pFDhK0y7YNd0lm+cAZXJEShX7QkRpjp?=
 =?us-ascii?Q?L8ujTwjgKFUPTCf8qefOKzbpkfxWHX5GUfUAGT/wgpFrgCD9/lnpo9aVnUeW?=
 =?us-ascii?Q?9WrRTECg7vACjkfJFUoAoMqqqTmyrPwaRIZVImldtarN8DpV8PuJilCHlI+Z?=
 =?us-ascii?Q?ZVvmLfZhU7hfV4f1H2bp2AwWR4se5xPEBhRQkOhL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8095b5d3-e219-4285-e841-08dc847355b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:50:07.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7H92P0bFCwIjmkx1TvTbaQNvv8qdg0G8sfs0ZCLeEFleseT5hWLbVAuSFWDj+ZtkRtOHxlSRxM5p2OindaKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com

> From: Hans de Goede <hdegoede@redhat.com>
>=20
> When using an initializer for a union only one of the union members must
> be initialized. The initializer for the acpi_object union variable passed=
 as
> argument to the SID ACPI method was initializing both the type and the
> integer members of the union.
>=20
> Unfortunately rather then complaining about this gcc simply ignores the f=
irst
> initializer and only used the second integer.value =3D 1 initializer. Lea=
ving type
> set to 0 which leads to the argument being skipped by acpi
> acpi_ns_evaluate() resulting in:
>=20
> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Call=
er
> passed 0, method requires 1 (20240322/nsarguments-232)
>=20
> Fix this by initializing only the integer struct part of the union and in=
itializing
> both members of the integer struct.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Wentong Wu <wentong.wu@intel.com>

> ---
> Even though this is a one-liner, figuring out what was actually going wro=
ng
> here took quite a while.

Thanks a lot

BR,
Wentong
> ---
>  drivers/misc/mei/vsc-fw-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-
> loader.c
> index ffa4ccd96a10..596a9d695dfc 100644
> --- a/drivers/misc/mei/vsc-fw-loader.c
> +++ b/drivers/misc/mei/vsc-fw-loader.c
> @@ -252,7 +252,7 @@ static int vsc_get_sensor_name(struct vsc_fw_loader
> *fw_loader,  {
>  	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER };
>  	union acpi_object obj =3D {
> -		.type =3D ACPI_TYPE_INTEGER,
> +		.integer.type =3D ACPI_TYPE_INTEGER,
>  		.integer.value =3D 1,
>  	};
>  	struct acpi_object_list arg_list =3D {
> --
> 2.45.1


