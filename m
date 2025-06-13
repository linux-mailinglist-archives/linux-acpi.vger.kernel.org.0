Return-Path: <linux-acpi+bounces-14362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 260CAAD93D2
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 19:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E54E189FE1B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F622157E;
	Fri, 13 Jun 2025 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc/CjlSH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269E2135DE;
	Fri, 13 Jun 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836243; cv=fail; b=pDfyFJ9zIA4bbBrVohry/C5VO4DHrYMGWl62DviZ0d5ouEfkpjAgFAFomE+H6Y5kNME3vZSqGpRwkQu+crl7eDlnaRU7d9M5TdorYMcWb8shCdYckT+G9yf4U7dV0249Cxbh8eEBgda1blOjteKpjmYLabxah5lzJ+BKCIcAD7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836243; c=relaxed/simple;
	bh=ni9oSt2xeHbtlNDESpKyLUsIkPTw0Ly67QrHni7dju8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HDx+p5IlJA6Lfit3FEPPg9RVNwuqdPlsSEKN3SYOXHgiMP5fGIXuBPMK4QzOaLYxXxgJeB/FRXPGg8SvlJ8xyEA1KktP4N8CGuv/t6VADSLnIqFCcwyzNaSL7/YdTgeUKDhdwkW/NVEw4nA9EUoCQQPFQtaCbKOBtsTW/yt1PkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc/CjlSH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749836241; x=1781372241;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=ni9oSt2xeHbtlNDESpKyLUsIkPTw0Ly67QrHni7dju8=;
  b=bc/CjlSHdzXKpOwByTEKNieBNPRIvg2TwsoSyRvx5yjzjmPNkCEP2sCQ
   OiUWxGyK0lmy7rk8ety9e3xkoq1duJfOTCptyXZns9kot/tKG7TYs2zfo
   d0AyrBnJm02zVprUFLk8yeE5RKpd6e3XL+VdYvbqneU5qfAp8xOO53wZU
   iF+jOr7BWain99+Rsk/a3yIjrPn+ShjgblOg0qVKcXics2f3W3M+kcz7E
   RmKfQWQswLSB1iCkEhg4LXd6mtb0gZ4JnrF4ahy/WiATqOvDsG8eSs5aD
   FEjuOYf0oW7pXPbZnRM9QGSQ9eQ4En6u+Eqf3xdcA73vr8R2RWySZKeHL
   A==;
X-CSE-ConnectionGUID: mZaI9AT6TPqsyL0mbNX+ug==
X-CSE-MsgGUID: MuiB4EQrQG645r1ihjPy6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="55857928"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="55857928"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:37:18 -0700
X-CSE-ConnectionGUID: Rf9fqsisTUmGLbI3w7tQ0A==
X-CSE-MsgGUID: aSCjfHZaTFCIu3XvHMH4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147781453"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:37:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:37:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 10:37:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP6x05fVn2EXsbB1HMlT+BLA0qLMdSnxTIfUyKEGrZ/ZoQ9QMENAlnN/AfCABltDqz5f1w/ol0KhJrJqnLWKTzWlpFrW7RXaGwjWQpexny57giC3m6sESGPgeLzAfnY8u/JA2xJnsbFEOQlIOnfGvzzF4TMdSEZmaZqSv3CcSH+hrW9YoXn3raYYlppPS2/UPfKjk+Da8UdYknJbXBAt9u/dYDH3q76zM+jrKU9KnYfI8waUD5iIwEupbBn3LrumHKpUnwaSfHN+uQ9AzzrP69eeIav/dXZdXehQYYZaGk8yGPFFXQWf3zdmThia3fHVnDZ0KFaVSofxUI8mF8YtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkWQUy6y/k+Xc7o4RmuK558T7kg/k4iIAH3xsN5xLAc=;
 b=RXJtRowyQayJqzkEMYjsBJNrhex/ah/IVOUikvdPW84r0dPgVkh7EqkWEQrm0YLgA+pNcVUgIXTcQYS1n7fhj+na4ZSYGXC/EUPcgmXP/PTPMf5wbNX0Hky+fhFnWEnyUncpZwcIkm4++/5sdqsipNgQaO3xSpDj+WD5RiKzJzupQx2zVPj2cMrPntumL+WqNuMLP0ZjTh/zk++WAiw1IGVJ1N9yyAuekMxZcQH8pJ0vmaGRlYoL/bw8SSmyGKkSJz7dcA6pGyBIoaS3lRaSJ3whkd3NIE/+YqrCQUtbAIO4GBR6HjPTu2XdyMSpLvgRJ2OgmiQbXC7sqSysk451bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BL1PR11MB5979.namprd11.prod.outlook.com
 (2603:10b6:208:386::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 17:36:47 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 17:36:47 +0000
Date: Fri, 13 Jun 2025 12:37:54 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <sudeep.holla@arm.com>,
	<jonathanh@nvidia.com>, <u.kleine-koenig@baylibre.com>,
	<dan.carpenter@linaro.org>, <viro@zeniv.linux.org.uk>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<gregkh@linuxfoundation.org>, <peterz@infradead.org>, <dave.jiang@intel.com>,
	<Benjamin.Cheatham@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <684c61f275a5d_224f6a29411@iweiny-mobl.notmuch>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-7-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612231327.84360-7-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BL1PR11MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edd2d0c-a5cc-473b-e719-08ddaaa0df22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rQRpE5ui3u2UnR11GAySS9BQTXHI6eGTnVya//Ax/OuGe6Y7EpUMUlZiJO3y?=
 =?us-ascii?Q?EdfMIXi7jGa7fQ9ie6WTWI7J9RCPjwYl7BYpTCDTCtRWLbBZEA6BaJdZXQRZ?=
 =?us-ascii?Q?Y1GYSUrtAVGRohsGt9FZkA0TtwJ3JTQ47QCqyksqM7XavmOlyf3joAd1vNWc?=
 =?us-ascii?Q?zDbgnv2uZw/8KDNcQExCXneRE17hxJSScvnZU2mI+kxxy65NwGfoEAQOS4H0?=
 =?us-ascii?Q?zXSRUf8ZQP/ilyxCfitv2gwlz0HeN/NWiWzfmiFvi33EMcdOAOl789Or+vyI?=
 =?us-ascii?Q?L76Q/Ju+A7aSTpMeFao6Ph49pespPbmzGJkFjNp5N0/NU6gnvdBTuFeKP6zU?=
 =?us-ascii?Q?kyprWMj4JbK78F3WSCnhhrtgtX5vM/WQx7Mv2+S5+pOLZEN9bB6EWHavVvvQ?=
 =?us-ascii?Q?YYX3MbDcFtvX8cL6nzNTjFBkhLEjKlrMEDE4ymCL57Y5A2ur18y0XfUEYkLS?=
 =?us-ascii?Q?T/zIDQdPboHijxNI2vXvlgAOnhP+tTelwyOGrRTBa8q/oo3O9TkJzKaGdv3F?=
 =?us-ascii?Q?M5bnYxkKLVWfCwgkq/PLKTF4AZXygIyXvymyADGiXa9TqzQDGOgBbhhioQpE?=
 =?us-ascii?Q?+NyaphT5M7w4DWA9fuaNRHWWYwZ4rKksTuCP/+psUNiXwpXvCqKDCbRnqZdn?=
 =?us-ascii?Q?wI3Nfbt8GaC81kMJxXZD48NzkG89PIgmX+hmj95Ix5ogPB2502uDct4+i0aG?=
 =?us-ascii?Q?Z+uZH5Una1yyi3Kycqrp0p6YzvoWy7dSdnugieMYW4JoBGduv4ZWq549waZk?=
 =?us-ascii?Q?inLRVP/16Hy2UXy9mQOBop15xMcidXOdxfm5+WzlxJKYXKOrATNUx32J0BoW?=
 =?us-ascii?Q?leeTLpZc0msgS2q/DBs/9R2xD1XPfYrhxTZ4jtqTPruCjMTSS7QEyT/wu1lt?=
 =?us-ascii?Q?3GD7L3RD+wwyhsQQfAHfUmHaa5zDusi4gw4EY6aSLbIy4io9O5/EWWryHLpc?=
 =?us-ascii?Q?1yCzQnQ8p3YARcJll7re+3lUp4fm6PgJ9srlV1U1wMTgtSDel1A642QM06eH?=
 =?us-ascii?Q?+JQk3zyozIstv/Ltp6sqjtmlzxg11Y3rAj4PXS/ZSTv3VZE1LQrHFEjuSGA+?=
 =?us-ascii?Q?YkDX3iy7PqmRYPz7Wwzer68PeOoEYm8kpVZQ8y0BeV0cf5krbqp13y17X31C?=
 =?us-ascii?Q?IMOd7ePEQzjcdWgTON3frvMrSS0djSuQARHF9QkEP+1CcETp9w8CVvjAXjLa?=
 =?us-ascii?Q?2fem90T/t1G5rwfpGe6ZsBD5tCTNdRDeMOFeczsDlHbf301FJ1m+Xkzp6vQA?=
 =?us-ascii?Q?mN8f3n3749jWajJ/AElmu48pZYGu/TzDkQlVpHjxlHK8sDs94tsIHaCb0uDa?=
 =?us-ascii?Q?i69hx5OhC3ztIzYCLlHD2waof0r/7IKoJdHHh5mS/vqHc73qRy71/9LDesrL?=
 =?us-ascii?Q?FPN2WBm9QYDIcBigVMBmO5HHYeZ9sUWjfWnVaDTTg24LdHvVT2mc5+Za9k+I?=
 =?us-ascii?Q?Q9dh5xyOq+iCym+z/tO90wz5gfE63hVaV2ZiNJv0cob5QxpD33CyTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fS1cmWntQCmaVZQtLjlBthctfEzBtXz3un8/xmmlA2ITzLvMnsqMVTqkJYdP?=
 =?us-ascii?Q?a0b+2+FaR1vQ4hL6jGIXpvPfXN7dMkINWCO5YA0vn6581fb2Nz7K0bCYEYch?=
 =?us-ascii?Q?emIZJNc2+sddQi4LB4v35hMQUl1tjxAL8f/Sth1JRSggu/jYB7I/aSc7fzw5?=
 =?us-ascii?Q?ya94og8KumTGXFKQ9qdzvswOQlVUi1kAAGwECIaBLVpVWywnmu7VMncHV1n7?=
 =?us-ascii?Q?ysXQ9r2W+XLYMNhvszqg5x9OxY3vpM0JgdcHZtr2BR8Q41ONuq6Oz9RSvrSo?=
 =?us-ascii?Q?8cHUaex99uQsWDNFLBs1L2PPjReJMebK4M8JAAtG7ZUqk4WoqVBe+S6Shf9k?=
 =?us-ascii?Q?JNz3JqltxUi43ZRkrN09zwhg1pGJwfVDSFSn4dEiP+s0OtkzQX7DKiprZxb/?=
 =?us-ascii?Q?VRFmeMM24u5JqU8se+IxzHfcu+NwrrmxUL4BsduIYe0Zc+XmOj/bJEL+aBSz?=
 =?us-ascii?Q?S5wws3sLDNHJ7YWUxILsGoFoYNVC+rOC2j3Q0w1gV2NmgMUbyNMhAcCGAm75?=
 =?us-ascii?Q?eP6Fb0SNx5Ru6TxNLyeeIsPkLKeDGbFo9zvs1ExyIICEt+UkVrE7PHfktq1B?=
 =?us-ascii?Q?gKXMcdbRUQT1jvTMfDaVMG0KPlHcVuv6xb+nAxRH9+Ju86gNxUrAXUGKAX6T?=
 =?us-ascii?Q?O7ZDt9HLAH/KDGlk1Zg1UVPuYzsNMltQbeEIcJ9pXUIXzsLNmagqTpHvxIFh?=
 =?us-ascii?Q?4qWgHYgi9NYcLDepCDVyBo1wZxv3NLn1OceEpAEvJnJnJAunxcqTfx6YU2OJ?=
 =?us-ascii?Q?7RhfNlx6XReYMp7SAyhZyq23ph14AA7eqwDJpyJWP7ipwcNGelqylkVQVJOi?=
 =?us-ascii?Q?yVTliYpW02K45PKaqispkK4hR7ogNxW/hIs/hTIzUV6YspAtEezzL6XvpjWx?=
 =?us-ascii?Q?evY6aBgcqFvFNWrrJb8jQFHOH31Z+R2xWFGrZvyxIasrbPm8mYJ9/cWmtpGf?=
 =?us-ascii?Q?cUi1nSvNiuvseNkRkMAE1JCjoE+CrnnjgtAeB53mZLOw0CeN3830fTj7ujZN?=
 =?us-ascii?Q?ox9it0suIW8mJELfs+t9pG29xPArEwu6UrHW4efThoOzVSKcWH0L+P68qa3c?=
 =?us-ascii?Q?Si8UwsqqszY/f0v+Ja1QIeAhrbd+Hq+gOKM4OU0UTUSLVJq8vnZ+YYJB5YWd?=
 =?us-ascii?Q?ABa6gc15mXhNZquHjz2kGjkr1U/Yj+CNCnMsIGdgmAF+uhUt6ExCifD1u3H/?=
 =?us-ascii?Q?HXsxB8g+c+/WT+hNJSuu0ccusYrkDa8Pm9VBDRzedGx2PYf2C2XG8cIlAbbQ?=
 =?us-ascii?Q?p2q65fMYC21ax+Zl1SpGogtHvvRODuL/ZvpFw6d+xjcUdzXyxruZmbLHp4v+?=
 =?us-ascii?Q?raJc3Mq6/JJAaEKL81of2SKMmeVDrwYNG+vI7ua6m4l7Bmo9BTr0ubOf1Fvm?=
 =?us-ascii?Q?zfsUmI5dG5MK/2rocLcwkWjzDpqiChHL0a6Ldr4PHzYfSYiv0/7ce/SCYtUm?=
 =?us-ascii?Q?IpHOZG0cs0X8RmAK8gcLIanmTAN2DOF6Aj0L0X7R+9ZvZUI6CfAMzYOr6LOJ?=
 =?us-ascii?Q?FwzmGlU69XTyI4GJ8X8xcpUwieNG5DR0FeL6kGDBPXJmNqpzPSitc5Z2gFpB?=
 =?us-ascii?Q?eI+TE5BiGRSwXQKQTeX5qu4AKILRCxHrRFUgsaLC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edd2d0c-a5cc-473b-e719-08ddaaa0df22
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:36:47.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJlY+SluJeaG24xF69Bausw5/OsdvRty39ZYvdvvlOwZjjUGiZmHVKd5LYZaD/Qzbw7JseV04+wQKAfL1U+gWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5979
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> Enable injection using EINJv2 mode of operation.
> 
> [Tony: Mostly Zaid's original code. I just changed how the error ID
> and syndrome bits are implemented. Also swapped out some camelcase
> variable names]
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 56 ++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 8d60e5f1785c..7741c2082f33 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -87,6 +87,7 @@ enum {
>  	SETWA_FLAGS_APICID = 1,
>  	SETWA_FLAGS_MEM = 2,
>  	SETWA_FLAGS_PCIE_SBDF = 4,
> +	SETWA_FLAGS_EINJV2 = 8,
>  };
>  
>  /*
> @@ -181,6 +182,7 @@ bool einj_initialized __ro_after_init;
>  
>  static void __iomem *einj_param;
>  static u32 v5param_size;
> +static bool is_v2;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -507,12 +509,20 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  	return rc;
>  }
>  
> +static bool is_end_of_list(u8 *val)
> +{
> +	for (int i = 0; i < COMPONENT_LEN; ++i) {

Back in patch 3/7 these are defined using a hard coded value.

I think it might be better to at least use COMPONENT_LEN for those
definitions.

I'm also wondering if it would be better to have some type safety here...
but probably fine.

> +		if (val[i] != 0xFF)
> +			return false;
> +	}
> +	return true;

I'm unclear of the way this list is terminated.  The cover letter does not
mention it.  I read the documentation patch and it looks like you echo ''
to the id to terminate.  How does that work here?

From the documentation patch.

  # echo '' > component_id2			# Mark id2 invalid to terminate list


> +}
>  static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			       u64 param3, u64 param4)
>  {
>  	struct apei_exec_context ctx;
>  	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
> -	int rc;
> +	int i, rc;
>  
>  	einj_exec_ctx_init(&ctx);
>  
> @@ -521,10 +531,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  		return rc;
>  	apei_exec_ctx_set_input(&ctx, type);
>  	if (acpi5) {
> -		struct set_error_type_with_address *v5param, v5_struct;
> +		struct set_error_type_with_address *v5param;
>  
> -		v5param = &v5_struct;
> -		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
> +		v5param = kmalloc(v5param_size, GFP_KERNEL);
> +		memcpy_fromio(v5param, einj_param, v5param_size);
>  		v5param->type = type;
>  		if (type & ACPI5_VENDOR_BIT) {
>  			switch (vendor_flags) {
> @@ -544,8 +554,21 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = flags;
>  			v5param->memory_address = param1;
>  			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +
> +			if (is_v2) {
> +				for (i = 0; i < max_nr_components; i++) {
> +					if (is_end_of_list(syndrome_data[i].comp_id.acpi_id))
> +						break;
> +					v5param->einjv2_struct.component_arr[i].comp_id =
> +						syndrome_data[i].comp_id;
> +					v5param->einjv2_struct.component_arr[i].comp_synd =
> +						syndrome_data[i].comp_synd;
> +				}
> +				v5param->einjv2_struct.component_arr_count = i;
> +			} else {
> +				v5param->apicid = param3;
> +				v5param->pcie_sbdf = param4;
> +			}
>  		} else {
>  			switch (type) {
>  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> @@ -569,7 +592,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  				break;
>  			}
>  		}
> -		memcpy_toio(einj_param, v5param, sizeof(*v5param));
> +		memcpy_toio(einj_param, v5param, v5param_size);
> +		kfree(v5param);
>  	} else {
>  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>  		if (rc)
> @@ -631,10 +655,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  	u64 base_addr, size;
>  
>  	/* If user manually set "flags", make sure it is legal */
> -	if (flags && (flags &
> -		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> +	if (flags && (flags & ~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
> +		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
>  		return -EINVAL;
>  
> +	/* check if type is a valid EINJv2 error type */
> +	if (is_v2) {
> +		if (!(type & available_error_type_v2))
> +			return -EINVAL;
> +	}
>  	/*
>  	 * We need extra sanity checks for memory errors.
>  	 * Other types leap directly to injection.
> @@ -743,7 +772,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  		if (available_error_type & einj_error_type_string[pos].mask)
>  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
>  				   einj_error_type_string[pos].str);
> -	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +	if ((available_error_type & ACPI65_EINJV2_SUPP) && einj_v2_enabled) {
>  		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
>  			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
>  				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
> @@ -785,7 +814,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type | available_error_type_v2)))
>  			return -EINVAL;
>  
>  	return 0;
> @@ -804,9 +833,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
>  	if (strncmp(einj_buf, "V2_", 3) == 0) {
>  		if (!sscanf(einj_buf, "V2_%llx", &val))
>  			return -EINVAL;
> +		is_v2 = true;
>  	} else {
>  		if (!sscanf(einj_buf, "%llx", &val))
>  			return -EINVAL;
> +		is_v2 = false;
>  	}
>  
>  	rc = einj_validate_error_type(val);
> @@ -828,6 +859,9 @@ static int error_inject_set(void *data, u64 val)
>  	if (!error_type)
>  		return -EINVAL;
>  
> +	if (is_v2)
> +		error_flags |= SETWA_FLAGS_EINJV2;
> +
> +

Does this flag need to be cleared if a v1 error is being used?

Ira

>  	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
>  		error_param3, error_param4);
>  }
> -- 
> 2.43.0
> 

