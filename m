Return-Path: <linux-acpi+bounces-21377-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDo+MgrSqGmlxgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21377-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:44:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 722912098D5
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BD54301C161
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 00:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B81E5018;
	Thu,  5 Mar 2026 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfgEPE6U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174820ED;
	Thu,  5 Mar 2026 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671494; cv=fail; b=tRrMTyPa3W7xwIPraPdfnsftxzv3q6uJuknklDO4toCXP2cxw+TDQfu6AnhKRjQ+2nG/GVbsaxEwUGxD2uH+fNcbKDwiD4PZiMiq7KE8zGGALOmYYt+ItvDitW30uR5YVjt+EOzUaEPpvH1kk0mPHxifFPiI+yR0siM3wGvzyJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671494; c=relaxed/simple;
	bh=GQxGsEa2mo1pkW5cYDSs+gAT7Gm93DvGBj0WkvtRIKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g/EkUBUl7OQ0Hblks0gat4cO2Dm7lHDETz3DBqPBqn7aXwRhlBy3VMSz8Yf9irDU03a2JT6SwdEOD3NKpUWTXdg1S6i+/exnviPMJe/+isaln7PTVS0qKMhcieWzmm0tfWXeRvI7QxRXJeHavw27eF9V4hLRhqi2c2oF7CokZ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfgEPE6U; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772671493; x=1804207493;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GQxGsEa2mo1pkW5cYDSs+gAT7Gm93DvGBj0WkvtRIKo=;
  b=AfgEPE6U8k8PtcF4WqBTUYeGcPtFib11dTUU8XF0LW+1IoxUhUklkwUQ
   1C6GpgS+juuws13cuwUMChCRdCLOLLUwZl58I+SrqUP9sxnAmfImREtvx
   cXCE95bEcjPq510IQ///7PIIkUOuM7jnvJdyPfOElfPHCjqFi/ZV0BiSM
   MjRLQPoM+C/zjnBP6u0Wk/AaTthsCVHjlLzF4ObcokfzAyhTZYMqWvZ8M
   qB5QzwJEprhgQIeiSan7NQKYyY1wAbG1s4k6eLAdMSC8JvAUmzyLvhLVE
   VJG5MkhHrY+5Kxr+WTbpOnJj3XnLoNGHqF71M7KTmK0c0o4kxQC1YDT1S
   g==;
X-CSE-ConnectionGUID: WyGz/VpqQzO30fI9DVHf4A==
X-CSE-MsgGUID: M5fXvlaeTPGxo5LSqrfhBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77590900"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77590900"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:44:53 -0800
X-CSE-ConnectionGUID: 1wwRSOAjQw+AaVaRNc5W7Q==
X-CSE-MsgGUID: 9tSaycYsQKiyUwXrPISWtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="218499877"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:44:52 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:44:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 16:44:51 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:44:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9OWIaHS4R1D6bczFIRW0kl5hFTltAoavxT9oqyCE+3SIgaRVyH3lA/QJ549ERm7bTS4/JHA3mINnm2c/CgAJ6wT3oKgKO2tw47uGSG28hN+6YrDONFSEZvivhZsag0EZ30tjkmGMjCPJ+H0cwgvmFFTVLzc1jMOEs1us+WqlM2JrH9Qz4JRktx2iMlFONhwvFSmKJeHSRyeJg3ljO+VyjMkzH48BVRkW9xkvoJiP1ksRZ/gV2/N6ILd6V9h5a4a9jjTCzC3/TBQkB/YieXEWiv+TMUI6EOJyDmYTFuwXPVaTbOuuTQexzHSThh77t2TkHTrM52EaVKUtL7+Beq+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCPNOkNOyq+5Xj5fZJEgLlaPGLPNt0WPfmLKsxqXkU0=;
 b=AiL8muq5ulxLfYhfIN42fr3FtKSvhaawlYnE+rrGAtYc+YgAt37vROlg1OmbHWqmHC7S3/FB2qr3sRCMSqb+lqRZJrmrT5/ep3mEl5qVq/2YO9mBZ8b2PoVf7UiaZ7iphrovm2s77qmeMSC7JLnPqBQyRcK49jdL6GwoIFGWZ1eAaE7R7QSQQgWcsT3oU3+Jz1xN4Y0wKl3ltqqn0OwtuxkoAdw1lhcq2HBXhewpdWyFk6Mp7FDkMF1lc1Wn088flUGdHnk2iK2OjxjE9gGeh89354tu6rhlI6P4z4xu3yWwrp2bVEXgJ56ZXSjHgIiVqnlt0RfFcNeSMiyW5Z7Odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 00:44:49 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 00:44:49 +0000
Date: Wed, 4 Mar 2026 16:44:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
CC: "gourry@gourry.net" <gourry@gourry.net>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajR-DIeW99H-9Zv@aschofie-mobl2.lan>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <acc37740d0d7fb2bdf12f181028addb1eea2e169.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acc37740d0d7fb2bdf12f181028addb1eea2e169.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5b79a0-4ba4-47ea-f94e-08de7a5067bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 5FbVwanx6yLvwAqCIMTpbOR3s2z/ua2dYi8jgfORw1JsvG9v7y5GceySkfhAaDvasrNmGByI6Nyuqa4t2pD/IE+bAb5iWy/+ML7Z0o4kXwJeJ7RewSmYqGehPbc1sclGXAhGIYLmovqqwfaDhcKiLJXlvWI+30FhrvAqnTTCLdX4sYpmMYl1HbgWEojcp+AWdiSNvb3YtrBebLbbzWXeIH+HFJ8ROHS8UU25Gx9XY/qxvQ/jUi6Y1X6r4vLUWSmwQ+bCArzJq1GDyOlFi0FzbQhGm86JI23HsZBu1LhLVGc4JRJx0g7EgSUDS6dXh1qXAStNPbHfBIUidcC7Wm/aYtms/hUP1pQzFIVMaflLMi/6vub7QQc664i1yBD13UIOy+u8I8VpDv0kuHjTdv4eMsLf2j71V/XdNcsZdE+Z3wKnWFrrI1cDCgxLH0eVm9Q74bI+oTPGgH6gZqfPrPJV5gEM5sqJ4GomvfIHJSbBjlnH/bTLHq9JZWC9KXQXvD61//CBHMQ2/O1Yd4VE8xezphUnZvdxnSFKv29yr/gp0bLDDKpgvwEaQ27CFMI4NlDvIcrsloWV3cemnX8Vcv3Jfbr6/IKU9/22beyKbFBiJNQGFlk1wJhRerF+u2ClEQWvgjZ6FBT/WWf5qoP9l7ayvFE6p2FOXzSoBar8Bg2KwWlzMMr2NQz+m+BMlDhQsoFWWJ1AZxLBPcEcueUeAtHLfetgfP42YlG5hG8LLHyW9zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VPP8T09lEgdHWSldprkbPJIbFcmzgQEhEHw94a5vjghQvrzOJNZrT0G4d3?=
 =?iso-8859-1?Q?RIbb9jfNH0mf4REsxcEi9WvFudOIOv0JGpjdel4mg0Qp+tNPMygXlw57yU?=
 =?iso-8859-1?Q?6MIc/ICNOr7McNLw4Z2AV83qr9hUk1nK5q3uH/Vyp6j80zy/lTigL/+O17?=
 =?iso-8859-1?Q?trYdueO7U0Bf2q8Y3S3I4bNUpA8hUWmHcEreXnXpwUWKJpuSPtpFuHaV4Z?=
 =?iso-8859-1?Q?jp9tfwbjTxqeoODt92bQdZA2l8woWjT2n8xi0ejRKaCytePQPom5dfxERp?=
 =?iso-8859-1?Q?WrC/QWYbfyOR2NZq20Na2Vd4ubrdP6/+v99UFCVkv7hjA16i2K7hlDJdDt?=
 =?iso-8859-1?Q?QpPIpbfQ5x28xamYERw0KtEtQZAqj4RFy7uWGtmTIH28XB+A4EESdAfHao?=
 =?iso-8859-1?Q?1ienaxEINMgaR42+aF17aY12QhBmbaxDwAN3xh/emxiwXiC9/eWK5Cm+Fm?=
 =?iso-8859-1?Q?AfRpNWRxtUp8/64445px77zuqA0eiU0vZuD89E+0FzjXiSlfM+aCR+/bj1?=
 =?iso-8859-1?Q?/Hxu6F6pvhcHWRcydFvTec8U0BuiRtmIrsrl4oBbTtkD2LLKNFNHlqVd8/?=
 =?iso-8859-1?Q?k5aVyY41PNaeQ7DdcQaD+Ay0FF+gJWz9VvVbjoKLr5QNBTqaheeq8c+WMu?=
 =?iso-8859-1?Q?PZNia3I1vLCG2U6jh2WdNXwpDAfRBjcX7Wsq8dciC+TdfMuisQlDZq4iZ3?=
 =?iso-8859-1?Q?iF3eN2D9NjfPG9eL+hk6SJuqpi13CRj+tm5wZIN8OYdzE3mCTl16ScTjZh?=
 =?iso-8859-1?Q?g2fdNSM9jxerMWNIn7mFEFu1PJ1Lb0uK1mFab+tX2kknCSDR7s+IkR9/II?=
 =?iso-8859-1?Q?DkBYPFLVQsfU7cEHs83HjVbyICwAzQGGOyl/SkKshbH2SpnqQfCqHQeHlX?=
 =?iso-8859-1?Q?O/55v/kEcJ5PSWPqR0deu9oTVQ3zORQOdDZaNHVxtZHIYiUy2bIV7N9tl6?=
 =?iso-8859-1?Q?WgsWpElJNscD77q8GuxlR1BTufQRhre6JzBd1ozMgQ9K1EpwgS74DSkV+D?=
 =?iso-8859-1?Q?LCDlgxPxRlQt2yOE1f/kYRw3dd3A00eW+DsQifhJCo0ffAlMP8B1dx/Gu3?=
 =?iso-8859-1?Q?4hsaSfKqyTZZmIzhJQ0SRC+IomyWpVq6bbfGXuZS1p25jeld2up4/g0rq4?=
 =?iso-8859-1?Q?lEd+s41ygd1U57MS0+9wMgt3HjEdMjh2D33ASkP360SMO98ry0nbc05V72?=
 =?iso-8859-1?Q?trY0iLZmDePI2dU3/C22jz6vu/ccHFS56n3UZqG30suEj494hiLYAR/HqS?=
 =?iso-8859-1?Q?hKFKo15A/yiFmCVKXNbknfJMPfYkqapCQHVvhAlSVXsGySM9IBIXWNyoD2?=
 =?iso-8859-1?Q?boeDM41o2EZEyC8tI4w5b/A5ScU51GUKJlzs8BxeWTCbaj27rqloniIgdd?=
 =?iso-8859-1?Q?F2FP9Ems2VWnib+InnDkmey89e5RWd3NKad5PpgunOxh9gT6q6SqAAWLmh?=
 =?iso-8859-1?Q?m1qwEWkv7xxhOP389MgRGzqeNWRA3gz5s2l6GMhhw26QFvZIUy2Vetb9Vt?=
 =?iso-8859-1?Q?JMtLCe3jD7IZF6ArOnducGUlb56/KafLllL89DKym+nJB3BTsRS7GKocry?=
 =?iso-8859-1?Q?eOUYYtdPvOh6P9yW+ChxBxy4naFwDZ82AUN4BDKIkjHvULYt/z8C+lrRut?=
 =?iso-8859-1?Q?pp4C97hihK79K6EEZlCqteG7G9wtC+nL1JIvPci/Rn3rA1fGXZbW0Ovb5x?=
 =?iso-8859-1?Q?tOfivrIOnh0mWAXUhghozt8rPZFJJpqUqi4IONsIi2OF4AzaF7Dhw4b2/d?=
 =?iso-8859-1?Q?Mpti8AyGL8IJ1oD/br0vI15YywdOmJaF8SP5g5Zs64uLV9/1Bvza1WLl4R?=
 =?iso-8859-1?Q?n0+QlH5v7iCVjBhF4yGfr2esNUQYTHg=3D?=
X-Exchange-RoutingPolicyChecked: ilkJ4rN9vUssFBmsr0Htw1AH1nkD9v78RHx8Fktm4/XpT7MgnOCwzFAv10/6zMzJQUtHSpfjEx5LS0ot6hNT8YdJdciSm8Qq/nnkmw8TMnFV603f4OHAb8nJB8eQcWJjjMOgNKl1IdvGt/7KZoRkEb/MYH0P5qeER1Y3fi35IyhBhpmFWcYg3RhiI11+m8X05QDIxHrdt28/WIIi9rY2zyVWjlEojTMYCL6YLwdPIOYdPMm/sVB0FQELvYTvZxS6UUvNzXXl7n1OR+XBkl4FY9qtcMb0pqxHIiwNgHexmGyM8VwxsB4Fhk0WXDUIEC1juBo4wQ0e+fTl/Y9SNlOsQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5b79a0-4ba4-47ea-f94e-08de7a5067bb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 00:44:49.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTVpsd4UBdkc5vqUS/wRfeExAmOZvzGnLE1U9QJDHEOxmrdPv50A6s8YN+GIz9ZJFQFm/ILRgdXpxpOr5qDN/bE6ABlgzGA0zlCI+WHi+UU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 722912098D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21377-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:04:57PM -0800, Huang, Kai wrote:
> On Wed, 2026-03-04 at 15:20 -0800, Alison Schofield wrote:
> > On Wed, Mar 04, 2026 at 05:33:26PM -0500, Gregory Price wrote:
> > > On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
> > > > Increasing the 'nr_node_ids' has side effects.  For instance, it is
> > > > widely used by the kernel for "highest possible NUMA node" based memory
> > > > allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> > > > related system calls such as 'get_mempolicy' which requires 'maxnode'
> > > > not being smaller than the 'nr_node_ids'.
> > > > 
> > 
> > > 
> > > Is this a Linux issue or a Firmware issue?
> 
> There are two issues actually: 
> 
> 1) on my testing platform, we can see CFMWS tables but there's no actual CXL
> memory inserted AFAICT; 
> 
> 2) The kernel unconditionally bumps the 'nr_node_ids' even CXL_ACPI driver
> is not able to detect any real CXL memory (or it is CXL port/mem driver
> cannot detect, for which I am not very familiar with).
> 
> We can argue the 1) is FW issue.  But this patch aims to improve the 2),
> which is an improvement regardless the firmware has issue or not:
> 
> If CXL_ACPI isn't even enabled in Kconfig, there's no need to detect CFMWS
> tables and assign a 'faked NUMA node' during boot.
> 
> IIUC this is even true on a perfect fine machine with actual CXL memory
> installed, since the kernel still have an option to disable CXL_ACPI in
> Kconfig.
> 
> > 
> > IIUC BIOS creates the CEDT based on the hardware it 'sees' as present.
> > 
> > This patch is describing the case (weird as it seems to me) where we
> > then boot a system with ACPI and NUMA enabled but CXL_ACPI disabled.
> 
> When I found this issue the CXL_ACPI is enabled in Kconfig, but there's no
> actual CXL memory being discovered AFAICT.

So this patch will not fix that case, because CXL_ACPI will be enabled.

I'd like to take a look at that system Kai. I'll ping you off list.

> 
>  #cxl list
> 
> tells me nothing.
> 
> > 
> > So, I don't think we can blame BIOS.
> 
> As said above, I think it's an improvement in the kernel even on a good
> machine with CXL memory inserted.
> 
> > 
> > > 
> > > Is GNR exporting more CFMWS than it should?
> > Not sure of any limits on flavors of CFMWS's a BIOS can offer.
> > If BIOS can carve out a window, it can create a CFMWS.
> > Not clear how that matters to the issue.
> > 
> > > 
> > > Is your SRAT missing entries for CFMWS that are otherwise present?
> > > 
> > > Are the CFMWS empty? (is that even valid)
> > 
> > Why this line of questioning ;)  I see the problem as a bit simpler.
> > We have other code that tells us if the CFMWS's are valid, etc, but
> > the point here is, we are not going to use these CFMWS's so stop
> > the parse as early as possible, like right here as Kai has done.
> 
> Yes. :-)
> 
> > 
> > > 
> > > > E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
> > > > reduced with this change (when CXL_ACPI is off):
> > > > 
> > > > 	w/ this change		w/o
> > > > 
> > > > Slab	900488 kB		923660 kB
> > > > 
> > > 
> > > This is a good effect, but I still question the premise.
> > > 
> > > We don't usually want #ifdef's inside of .c files if we can avoid it.
> > 
> > I thought similar, but for early init and static helpers, this 
> > #if IS_ENABLE(..) wrapper is common.
> 
> Yes.  They are early init and static helpers, so no header file is involved
> here.
> 
> I also see #if defined(CONFIG_X86) || defined(CONFIG_ARM64) is used for
> acpi_parse_gi_affinity() in this file.
> 
> > 
> > 
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> Thanks!

