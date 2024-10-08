Return-Path: <linux-acpi+bounces-8624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A452A995756
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302741F26000
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08232139CB;
	Tue,  8 Oct 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTgHvSrV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB3212F11;
	Tue,  8 Oct 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414160; cv=fail; b=pRNy25uq5PlbPqjdU7r+u1t3M0+Npevck/wztYN/asAp+Jc7RI0qcuNMGXu1WJ5zIxyyPRqpx6oN5e6nbXgeR/W8Fv8CQBE6JEDYx2h7KlbK4q9GmTGlBzOBshqZMxgFej3ZfISY6kWyiMbzcIE86jNCoirioIL7smMk0YS14vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414160; c=relaxed/simple;
	bh=Z/fkEFc8Upq8pQzjuLW8aiX+nOBOEv+QorHNC0crPJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gYAYoEKuPHqOBtUBD7sBsKxlZ4BBzRwvha9LxCmVTaS6XvR9ZKm+vHgUm0TJZ9Ni3QKaHVdM8k/yVG6Gv5ZW6BgWKoREw4dhZcM2s040Kgd1/OCFiWA9/49KyxQ22p3WUM07ozabZnJR+CxG2Fe4jgIU3z4WzBueX3ktectNnEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTgHvSrV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728414159; x=1759950159;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z/fkEFc8Upq8pQzjuLW8aiX+nOBOEv+QorHNC0crPJs=;
  b=cTgHvSrV5OdMPkHRjX9QItH+nxmVZA1W/jDROdPBJswQDNcktlc2kJxd
   +KEmD/2Uo/fwQban/TUADRI6n0ozEP6iX5JRH+H92OlcQiktSNOhyMsAi
   xludAB9OeRrp5frESff2+Aqp/j9GsWFc/tyP2Grr7815jnuVW77+r42Oc
   aPbCZJZB6q/Zu8WUWgXZV2jYtETvhKg9ou1J4goVT/3XeLr9VUWmKwO4p
   uFiYPUIPo4m8w5Qsng7ZsJJ61Dj2ok+PKtWaOy+U4jt2V+hZ0B3m9cEbB
   5x55R9U0q6cfBzL+HgbSDa4/SXOn7DN9FxeCVA7pfwiH1p83czu/JuViJ
   Q==;
X-CSE-ConnectionGUID: dI3u5HibT4yBzE0whwzCIA==
X-CSE-MsgGUID: jYMPrXmBRaiALQQ9CYCMlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38214101"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38214101"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:02:38 -0700
X-CSE-ConnectionGUID: RwOv4atWSVuFOAqBVGmoGA==
X-CSE-MsgGUID: mLQEGBNzQYe7dWLSB36ouw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106789727"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 12:02:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 12:02:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 12:02:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 12:02:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 12:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiANoqi8Jm+gSIRB8JVCo5S384b9cG4Rp++cDeUQB1bidsCm0HsT7yLIRgljwN0XLL0edvyOOQDBI766r4QlLmeVdxYywUzCAbZPACMCCL1kbV5N5z+/8UvdgK8cF+QsaaSnuli+jQ22FIb5sqlT+QriAmsXxI+LrCJ1N76Nn49gE9Jy/w1lxbqjiGfkw4si8g4CDkYkx1P+VaoSYO/teVOEPz31zyyDP5khMYMog4fRVqQHiyPJ+zToFTneV0H5F4EfGItUu23FzgqRCju+iX/QSWrCZGXR5X3Y4YDX8bhxuNdpGNufSclCoBKvmElHB74LKcCu/aQ+Yop3eBd1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auzC/A5eHvDN1dmb4OCtMZlL3fEIRrf/3Lkc7KeDqlI=;
 b=ywOSCgBQ0ZKtavbTJD5Sys3pir6gVpjLReoUea/zXEiTVqr/tNEf2jc8ciUvZCM3CG4ij7DD4xDJ0hJp1+fLxUGxENhZoZCTzxUOWngOekwhrMHHQdluQxp2sCJnDoE2j9aQrMgOYpOxDNNkoEm/+7vfNNJI+Mm0T2o+w7qPvxd8mmnC93DzvOIH2R6o4nQIQGiSS4pCEulNS3fUV2JPyV7dsYv7sReomWk4LOZWR1HzBfKNAab3NOsR4pAv/MeLnRWi7rj1DdmgN7Zir8T2P7Xopj05FYFkPNt/SGdY146JzOgQW6PimMKDmNIsl7vbtS+KP3AxeQaFlBMCszEgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4690.namprd11.prod.outlook.com (2603:10b6:5:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 19:02:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:02:28 +0000
Date: Tue, 8 Oct 2024 14:02:22 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>, <x86@kernel.org>, <linux-mm@kvack.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<david@redhat.com>, <osalvador@suse.de>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>, <lenb@kernel.org>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH 3/3] acpi,srat: reduce memory block size if CFMWS has a
 smaller alignment
Message-ID: <670581be41956_2e172294e5@iweiny-mobl.notmuch>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-4-gourry@gourry.net>
 <6705489bdc79b_125a729415@iweiny-mobl.notmuch>
 <ZwVNAYiyUaoc8Pax@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwVNAYiyUaoc8Pax@PC2K9PVX.TheFacebook.com>
X-ClientProxiedBy: MW4PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:303:b7::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: ef66eb94-e474-4979-1935-08dce7cbc13e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H5NKuNGM6xo0atO7CM8OB7Y/p8+qIMRhf1gKUMXdqlPCz7IRcxwt07e+mU86?=
 =?us-ascii?Q?zpdpX5LWCWWZOTkQFQVWHkB/B2rQFS3UHh5FZ8aC563TGQZV8CX8y/t1mWF0?=
 =?us-ascii?Q?TSsw34uGczCb32Jo4jS+7LvpgQPpt2HgnYki8duzKpHR8DrE1a04b/z3NOB5?=
 =?us-ascii?Q?/9BmbVjUgvABrrYQUs64A7g3T/mTRYZSrV2zCV9HgNN/rJIFIZdf/AngXZnQ?=
 =?us-ascii?Q?T0UyoiabDhL8V0HEAsVbriFVpImvs5Q4Fkj368ZIOQKMgzY6SsXCdHhtKLAd?=
 =?us-ascii?Q?LeBcecfsWMlYK0RtCw7nFufIZWRJ9i4ui+2a1c8e6rpQYikDW48MeJKFjnwY?=
 =?us-ascii?Q?j2kSXYyJhgwfMjLrOYUW6Z7aR4dlebJfAtgUkU9N4+MGbhhBmQsp6DuDhc87?=
 =?us-ascii?Q?ibVSZmaznFC062PBppFprhKJABJemaxgAG2wCPjZsLpBJ+/RFeOd+AbfZq8Z?=
 =?us-ascii?Q?kcbcHq8l4JQU049VfsEGx3RImdrSI5kYa5z56tG3iL8jp2t54gDIrf/EyspE?=
 =?us-ascii?Q?7IwXUfYGUUCmGTXa6ZNpDT73ZwFze5ZWeMi57zbrOdUwbdrHHrv4w7gHNa5U?=
 =?us-ascii?Q?sBRPGMJymPBn+lQubBvBtg5bKQna2tt86YZFxmaWJfhjPrGSRdZOQKwePKNi?=
 =?us-ascii?Q?MRF/K/uduDiVna3IH6OBh6m2JXBo8dSdtdkQqzq4/10DQkglEosr4ubCdOFz?=
 =?us-ascii?Q?UeKDZrJp7R5tPVtK9JJnWzpKVED9kCghhqoB5MVtaLObzUK3A35qN6XgkOUX?=
 =?us-ascii?Q?9fabonsfoWql4kQndp4lJ6yVKNzSzSyXPPIN3iYKZ1sfFLymxAxbDteQE+zZ?=
 =?us-ascii?Q?lWLi0zDobmxk9aHFBQDrw+ObHtPmHNsJYcPMa/YJXrEUOAqCO29VtfvYbOlc?=
 =?us-ascii?Q?kp2EzUsH4uqskVNELGZQCLdmEumaXbCO83EFckD8bammoNd2HOhudsmp/vRo?=
 =?us-ascii?Q?ff22XaStAIo8+/F5XqeRrZJqYKtxzjtGA8piEKv/SUaPtxJaqdl0r8Ibhngb?=
 =?us-ascii?Q?gnKuOOokOUaf3ycsiPb6HonGJrQLC/I5101fMY/pkZSAACaijQK5zykJHQrt?=
 =?us-ascii?Q?N2bw1podu4z2X25Z8fpuG7Mwd1P6Vpax+/J3rpOMv26lheBb2drozfkLqh7Q?=
 =?us-ascii?Q?mp2FEYBT3vkO+I32VGd/9kRyzdB4H9aWIMP5RbHhdYWzyjapFBIFFc2Obx6H?=
 =?us-ascii?Q?s/BOMo9WbIOrdgs3r1NrUIkfpP4CEY0yNSVbt/xjQCLT56/O7Wzqhfo4czGu?=
 =?us-ascii?Q?9SQ4kL5WgSYeTNe07OGrWIU4XTGRlHzcztx4yolHaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJ6v9cv3XCcRax3NWKNXI1gYtYGCj9COFNF7qvQDsBHJAM+AnDJkp3WPpOdp?=
 =?us-ascii?Q?JEtRALZ+Be8rTD5l7W/z6AVKQo2lrhxJj3pojzxrH1AFmMBKRyTzsxTd6m+0?=
 =?us-ascii?Q?jaQg9sQ7BRyUdyzcGoYR0Eu3TfoDvhTeSNErSLYHBsT6fkKcfdsjqjoByYRd?=
 =?us-ascii?Q?m1XSzQZirnwm4ZDMFGtxK0Xv6zpZ+hAWWpNm7g24oxOofPluZdJx8osqTOJ7?=
 =?us-ascii?Q?BQ6uiZS4x4uCMoCyy8k8wsqGim4mUFlv2bEsPPSd+gGDFT5Z1CGRKyfAmH4Y?=
 =?us-ascii?Q?cB2M3gRA37ZFIKiotncISThL6CEj0WuC31Z9VtT4nZYyN5ujopAncurVCs7X?=
 =?us-ascii?Q?CSRQ960wVx+sDXsQ+NqzsnxRaZVxYQk7WzyaQA52XaafioUgYaaBka+3HK0F?=
 =?us-ascii?Q?FUjAIynru29Avq+8C/ZF7sgr2EoFjIIWzElGtlSTVRQRT5mV4SMcipIj168D?=
 =?us-ascii?Q?An8FG2V6o1rFvjstPsInpk9WOI1Gd8eoZ3k1buCrTHDLf/o2ajDERGwoIlAL?=
 =?us-ascii?Q?ltKD7HxKgh5iGCf4moJN8hLP5lc47NNVsKglBMfTGMI5c8uKmRLVrmemitwC?=
 =?us-ascii?Q?NPR1KdZzawL3qSXH4l9G92BrVsv4ysbLTiD2XOO8sfUfcDNdtnyURwnO/VdZ?=
 =?us-ascii?Q?RDAY9T2mCZaapoP2B2JpjR38dT7hKSKCkgMDF8zguHgXQhWPdP+foOFcQhyg?=
 =?us-ascii?Q?57GKib79pjmfI3/H2ukifMSzkUzWsZGt/sh6HmpH2kCbKhKQOt51RDJF2dRC?=
 =?us-ascii?Q?/dyUXUzOvuuAToOeoikIYcW1c2x3p888trpsnVg5qsW3gAIesaabG4qURMRl?=
 =?us-ascii?Q?jFLuF5vyb055WQjWM+M0/gK5ZJEU3mMSN92a5xIYnfbowb2/NcnVVIzLw3yy?=
 =?us-ascii?Q?m5kh/t+yzGkREOm4lol8lBJjtlhiuYZ7NN0lfkOEQKr3IgHmlzz5y2T/1B92?=
 =?us-ascii?Q?sLXGWdGSMZWvEHbANCJ5YzJoGvY5JvYN1Ck5FBL9SrxnhT7HPbdtrI1eDCYV?=
 =?us-ascii?Q?jSzAilzWB46f7Nbspb2O1Bkoo2XHb1LphpAN2E1lhZd78sK6bldhI4owgyr7?=
 =?us-ascii?Q?kneE+cFyvyrejB6sOu/Dvj8q1ngHkceAPncFo/5SfjN/EQsKOYuUE3tTcNXw?=
 =?us-ascii?Q?3oZglJiZ3+/5ZmvnGTXZbFfr2CfxIMnMHy0e5BTg7MO7TFR+TQn+OE2XYybn?=
 =?us-ascii?Q?dmWyxgQnwK+UYMTyTrypitZhHbxxv1toTgEa1JY8dTmFBzrOVcDhg+F44VzR?=
 =?us-ascii?Q?6sUFidZiCrkXVTMvjI13sr41cMZJB59L7LW9p2whhgz44PEVbjTur9enwzj/?=
 =?us-ascii?Q?PrbTyv899GBD88rCLKXfAaj8nuyTv0xe9jFLM/y95Lwd1k8G4W4cjejEWp4g?=
 =?us-ascii?Q?H7Vjse9LaPsF4eE/sl7E8tqj9RF3RKRCGckdBUplfq5eTzXtArhHToTNxeD5?=
 =?us-ascii?Q?rwqIYx+zvu92z79iQ/hPNJFzfemz8sdzX1Lo8JDZEedYanPm8c43Rrb8Ew81?=
 =?us-ascii?Q?PQHD6Cvi9DJWtVdHfHiOQPn0U6QiopCcrIlvOo2CwGMgaZbR3g0O+BkkxjNx?=
 =?us-ascii?Q?QD1rx0Cp/m0CtjQKZ1aJnVxHNBDwaQKq2GTfhpiE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef66eb94-e474-4979-1935-08dce7cbc13e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:02:28.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bEXdnxHR8fEZoMZfhAB9ZriGKKeZiNNr779g/NMJb7KLD/qPILhDonbxO9cIJW2HrmYKSTBofEWyH1k8hdlow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4690
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Oct 08, 2024 at 09:58:35AM -0500, Ira Weiny wrote:
> > Gregory Price wrote:
> > > The CXL Fixed Memory Window allows for memory aligned down to the
> > > size of 256MB.  However, by default on x86, memory blocks increase
> > > in size as total System RAM capacity increases. On x86, this caps
> > > out at 2G when 64GB of System RAM is reached.
> > > 
> > > When the CFMWS regions are not aligned to memory block size, this
> > > results in lost capacity on either side of the alignment.
> > > 
> > > Parse all CFMWS to detect the largest common denomenator among all
> > > regions, and reduce the block size accordingly.
> > > 
> > > This can only be done when MEMORY_HOTPLUG and SPARSEMEM configs are
> > > enabled, but the surrounding code may not necessarily require these
> > > configs, so build accordingly.
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/acpi/numa/srat.c | 48 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index 44f91f2c6c5d..9367d36eba9a 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/errno.h>
> > >  #include <linux/acpi.h>
> > >  #include <linux/memblock.h>
> > > +#include <linux/memory.h>
> > >  #include <linux/numa.h>
> > >  #include <linux/nodemask.h>
> > >  #include <linux/topology.h>
> > > @@ -333,6 +334,37 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
> > >  	return 0;
> > >  }
> > >  
> > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > 
> > Generally we avoid config defines in *.c files...  See more below.
> > 
> > > +/*
> > > + * CXL allows CFMW to be aligned along 256MB boundaries, but large memory
> > > + * systems default to larger alignments (2GB on x86). Misalignments can
> > > + * cause some capacity to become unreachable. Calculate the largest supported
> > > + * alignment for all CFMW to maximize the amount of mappable capacity.
> > > + */
> > > +static int __init acpi_align_cfmws(union acpi_subtable_headers *header,
> > > +				   void *arg, const unsigned long table_end)
> > > +{
> > > +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> > > +	u64 start = cfmws->base_hpa;
> > > +	u64 size = cfmws->window_size;
> > > +	unsigned long *fin_bz = arg;
> > > +	unsigned long bz;
> > > +
> > > +	for (bz = SZ_64T; bz >= SZ_256M; bz >>= 1) {
> > > +		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
> > > +			break;
> > > +	}
> > > +
> > > +	/* Only adjust downward, we never want to increase block size */
> > > +	if (bz < *fin_bz && bz >= SZ_256M)
> > > +		*fin_bz = bz;
> > > +	else if (bz < SZ_256M)
> > > +		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
> > > +
> > > +	return 0;
> > > +}
> > > +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> > > +
> > >  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >  				   void *arg, const unsigned long table_end)
> > >  {
> > > @@ -501,6 +533,10 @@ acpi_table_parse_srat(enum acpi_srat_type id,
> > >  int __init acpi_numa_init(void)
> > >  {
> > >  	int i, fake_pxm, cnt = 0;
> > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > +	unsigned long block_sz = memory_block_size_bytes();
> > 
> > To help address David's comment as well;
> > 
> > Is there a way to scan all the alignments of the windows and pass the
> > desired alignment to the arch in a new call and have the arch determine if
> > changing the order is ok?
> > 
> 
> At least on x86, it's only OK during init, so it would probably look like
> setting a static bit (like the global value in x86) and just refusing to
> update once it is locked.
> 
> I could implement that on the x86 side as an example.
> 
> FWIW: this was Dan's suggestion (quoting discord, sorry Dan!)
> ```
>     I am assuming we would call it here
>         drivers/acpi/numa/srat.c::acpi_parse_cfmws()
>     which should be before page-allocator init
> ```
> 
> It's only safe before page-allocator init (i.e. once blocks start getting
> populated and used), and this area occurs before that.

Right I was expecting the call to the arch to be here.

> 
> 
> > Also the call to the arch would be a noop for !CONFIG_MEMORY_HOTPLUG which
> > cleans up this function WRT CONFIG_MEMORY_HOTPLUG.
> > 
> > Ira
> >
> 
> The ifdefs are a nasty result of the HOTPLUG and SPARSEMEM configs
> being, from my perview, horrendously inconsistent throughout the system.

:-(

> 
> As an example, MIN_MEMORY_BLOCK_SIZE depends on SECTION_SIZE_BITS
> which on some architectures is dependent on CONFIG_SPARSEMEM, and
> on others is defined unconditionally.  Compound this with memblock
> usage appearing to imply CONFIG_MEMORY_HOTPLUG which implies
> CONFIG_SPARSEMEM (see drivers/base/memory.c) - but mm/memblock.c
> makes no such assumption.
> 
> The result of this is that if you extern these functions and build
> x86 with each combination of HOTPLUG/SPARSMEM on/off, it builds - but
> loongarch (and others) fail to build because SECTION_SIZE_BITS doesn't
> get defined in some configurations.
> 
> It's not clear if removing those ifdefs from those archs is "correct"
> (for some definition of correct) and I didn't want to increase scope.
> 
> So it's really not clear how to wire this all up.
> 
> I spent the better part of a week trying to detangle this mess just
> to get things building successfully in LKP and decided to just add the
> ifdefs to get it out and get opinions on the issue :[

Yea sometimes it is best to throw things out there.  An idea I have is to
have something like CONFIG_ARCH_HAS_ADVISE_ALIGNMENT which is only defined
for x86.  Other arch's get a default which is a noop.

So the code would be something like:

	unsigned long long cfmw_align = SZ_64T;

	/* Find largest CXL window alignment */
	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, max_cfwm_align,
			      &cfmw_align);

	/* name/interface TBD */
	if (arch_advise_alignment(cfmw_align))
		pr_warn("...", cfmw_align);

This would set the alignment up early in init if the arch allows for it.
Because it is an 'advise' call (again name TBD) it does not mean anything
is set for sure.

FWIW I am sure that David and Dan have better ideas.  Just trying to help.

Ira

>  
> > > +	unsigned long cfmw_align = block_sz;
> > > +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> > >  
> > >  	if (acpi_disabled)
> > >  		return -EINVAL;
> > > @@ -552,6 +588,18 @@ int __init acpi_numa_init(void)
> > >  	}
> > >  	last_real_pxm = fake_pxm;
> > >  	fake_pxm++;
> > > +
> > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > +	/* Calculate and set largest supported memory block size alignment */
> > > +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws,
> > > +			      &cfmw_align);
> > > +	if (cfmw_align < block_sz && cfmw_align >= SZ_256M) {
> > > +		if (set_memory_block_size_order(ffs(cfmw_align)-1))
> > > +			pr_warn("CFMWS: Unable to adjust memory block size\n");
> > > +	}
> > > +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> > > +
> > > +	/* Then parse and fill the numa nodes with the described memory */
> > >  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> > >  			      &fake_pxm);
> > >  
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> > 
> 



