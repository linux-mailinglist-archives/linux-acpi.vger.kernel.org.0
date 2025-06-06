Return-Path: <linux-acpi+bounces-14183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D9ACFBAC
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 05:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FE178124
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B32835961;
	Fri,  6 Jun 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikYllpyG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC454A0A;
	Fri,  6 Jun 2025 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180921; cv=fail; b=G7ayeMg4fHS9tG94OrnwjRCY4RCfHrKFCOtz1feWw9STi5029d2fNkV38ZCVv+M8O37iVVhA72H4KttmY6KULhaPab0Z5B11eYTXjCkpA/a8I+BHPmiiCr/+UT9uvmHo3EezRqKxKT2V+dbVqLa/SpnYBcRrw3cOY9oHh36fYqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180921; c=relaxed/simple;
	bh=DN3yoYD02OWqt7X1tbYLwaqH0Ee9SwPQlZeOBno8Im8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgKoyQwp7OZORQS81yt6xS7GATB37f6Z2uSVTR2SKJt5O3WRVcX13AZVuzEOTnC8Hb0TTmHMIuIbP5Bnnaa1iZzkzhnjDpD0G/xCfYj5oXMDYcwysQRXRSzrXntIWaRlr0lgu5pmbK1OSIIgLaLTqAkl+oakcSXYkZCBskrVlJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikYllpyG; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749180918; x=1780716918;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DN3yoYD02OWqt7X1tbYLwaqH0Ee9SwPQlZeOBno8Im8=;
  b=ikYllpyGF6ps4M9MmVUTFihMRFpOmgLEmCizou4K7UGtvV5sSW/9SIoV
   LkjS7llJZ2HU6ndtRC82VC7ncw7v2MqlvzAVKd6k2bkLJ9xVx6gYXtxx6
   Ok9W79esxVbQzZUv7mYsb0WPrCameBSOYJkovRdmAYss3W29y0Iq1K4hX
   cjuYRCDTturLuyuAIZiEhI27yI1HN3a7g180p7PkAX7a4rh3lX8ohuhnT
   FiBT+iVceSH9uaXJ+HrPXXkjh663JzdZUcXLGUfyU5gxlao+iaGvGStZB
   JMR/ULDHx8/yqWaRKhgh6fVQ7QzNrUK3RqhNFizjO/jJRtRJwGWb3k123
   Q==;
X-CSE-ConnectionGUID: r9w7J4PLR6CV8u+iisr3bA==
X-CSE-MsgGUID: 24XGCDf0Qr+eNMmnYFX0xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="54984202"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="54984202"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 20:35:16 -0700
X-CSE-ConnectionGUID: JdyhKnGGRWW4bpv8Br+gMg==
X-CSE-MsgGUID: ZK2ZAi7pTdOhFPA56EenwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="146295364"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 20:35:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 20:35:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 20:35:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 20:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJd7ipwubq/gIbIW2vXftgUZYmBxLo4p494fyP63wHS58lx1gIcoIZ5xLDPyveKMllLlDU8PpBBmbZnAvADUR38SAR5aExo/29FpAvSLtc6yghLYnMw7ajLbHngz+9Yz5IyZeMaLDFN1LiBdnntZ/QM12VymNH839nhc6lT8V380Plsk5dbhQ0Z6E4llgLmocrakIteR1v1mdtmjnSukwQ7Ovet72IT0RvaU0siZDHHtsdj2Oohs9o1FF4YI+eEVvH53qLbRXBiHaKDc21b02jME7CjnRiC+W4M8W712xDEWCmPF6S4QoHAATVG5DBr2mRDdhChOHSDxdDS8JS1rNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOJhVfXyQ/B4GdmwMFLwoq8FBVQZ8b5B0bfX+ehP9Iw=;
 b=sP7pzd4F/IW1mKdGwdmVFI9ew5++sFj+zh+nyNy0TUYoZvHl4hGqQMPK7tP0nAglqtjoiiSlkWaHr5cOVp84++uD4nYDKARWs/EwbxKM6RQ9jGvSisK25I5K18Uq0ciD4kgxZdZ4tzQCdDxDFl6HNM51A8uEOIPjVwS00Kua+msPz0kAIov0t7cFp5+9caacwGwIJVx9DRhO3EMnH9MOEPrH+b3sFaQrDLTDE9oZR5kCwBnjr5cVqfsMwkyM+sNsI6QIQ9IkByDUTJ9euDDKMH+mWOQw6sAni3lEna4ECgSP+pfSxOT3JtqIb5q0/xUGl9sKmm8s3WBvkyogALcmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Fri, 6 Jun
 2025 03:35:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 03:35:12 +0000
Date: Thu, 5 Jun 2025 20:35:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 8/9] ACPI: APEI: EINJ: Transition to the faux device
 interface
Message-ID: <684261ed3c91c_2491100df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-8-5fe67c085ad5@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-8-5fe67c085ad5@arm.com>
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e66cf7-61d9-44b8-1f7f-08dda4ab2540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4p3Rfp9sL9BsvP6/QUivcU7+CRUxqXU2Ipcxvnt5BXJmT+PVQ7TFLEyyQ2V6?=
 =?us-ascii?Q?EbSlehJ7a0UQe+WJsKKfRor7ndC+jUsO7exXd2qIYhXLjT++X8YYEYp6OCoI?=
 =?us-ascii?Q?3CTf6zHgY0vfn064qfseEv+ogQ1v+I9J2wRlyLNAaaitHq9rqlRTkMXXJAEZ?=
 =?us-ascii?Q?i0Um3/yaTjGaMICROWkUO8Cqoe5BZdXT/LyJPYA2bqA8FzW1m5OCReSSGZre?=
 =?us-ascii?Q?vmhZi7yD8mSpD+z4+g9OX59LiktaAtmwhA+Ne8T1TQczvZ5pVKw66otsfPIg?=
 =?us-ascii?Q?zVc8LOAQsPpuUnGu+5ZWwgxp6XhuOtTANvoOfV1ZoyYNuQS0Ueohw51AzW3n?=
 =?us-ascii?Q?nsXFbFSHKAhGJ1zt1piurpA4llkGbT7NWAo8ebeXkk7Nd08UwRKwqH9QHato?=
 =?us-ascii?Q?kxRQCphL8KlgUm4VZlP7rcp8ykNJSUH0MVCaUA8jgMmIUNlgINlCsRQuDwcn?=
 =?us-ascii?Q?Vaq5KRZCTg/eBfdURft20yVc7x4saG5qOINwsKkaUEppkNTs23bPDVgWAM/8?=
 =?us-ascii?Q?s56Co1tah8IYNj1cyKsqSiWDWkfYJve8MJPjTPTo8Fh94qg8e4AVw1sRtW3D?=
 =?us-ascii?Q?f7dxVPciQiXYGbAih+Qp+06/yzGfZxlB3BGNgnuJVo4ytYSpwRAIUY/hmZ7b?=
 =?us-ascii?Q?EUOMSfKIfBTo9tQJcEt2BHZK33/kEuCN8K54061HMNyFKN47gGU+f5QPWTci?=
 =?us-ascii?Q?UlaoPKv7BOpoP8AkjeEKg4OG+gmiljIA7QFKjgMC8PXEVfuBWFkc6TvirqVb?=
 =?us-ascii?Q?bkjKQTmmTBcvDq+ScM5Vv3RZIbMCrWPvtTQPGbz+r3dDFG35jiPl5IKf0pnu?=
 =?us-ascii?Q?e/RUVRig+sax4F0y4/K2FsQpxeH/kcACpbUvz0RyBK4ImEGM/RW0XOzM2iBN?=
 =?us-ascii?Q?sigqgHuwYnMkBi8eGr362FeDwIjLfXrSSiey5d8vlar+ezouUwKuUnrjO2sY?=
 =?us-ascii?Q?r+4Qt7Q47Gz4zyCjRLtxtF69DPwhf1gru5t/tpvQDXzXPcg5A+rG96jqtmYv?=
 =?us-ascii?Q?1GrSMwsagPfG4Tj082xMHj1rhmxFRaw0b1d60iTMun9kjoG8QOMxWowqZlez?=
 =?us-ascii?Q?bAT/S1KEHd4PFjvZifEYytYwm2BP9+u63q8PODHQsse9A1QNEnBiZIKjtdpv?=
 =?us-ascii?Q?j0T1zFxhwtHVWBYTHEHRo/OrRh7P1iEFoYgYojljo5KeMDuBwoVHLjT2f40X?=
 =?us-ascii?Q?+7hpaqrmK3u9fyrSgUcjuKDOPNY3TgPTGr20e4aQsLnFnjrzPwkbAig2vqcQ?=
 =?us-ascii?Q?imE5m2aCfdQiQ2z9tdCrMpgbUq+g2Em12Ce4gosrPjgMhlzeFLEK8gWguMle?=
 =?us-ascii?Q?PuhiLJTZAhF7EB6LAWDemCP67bqMSSmY1pfOtAtnEW5Y7koHJPOGCuqu8fyo?=
 =?us-ascii?Q?Qdfq3EKOzuKdvPCW43ghxowLrX4Fo3wU0cyrpXSILv3TP8RuxV4DHmsrGdki?=
 =?us-ascii?Q?ib9rNzztgQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzjOmJbeR+ZNT2NXiYb0qTXwihcG/0YVKaHWyR4r4pu4cUNnQn27jbq0yXiW?=
 =?us-ascii?Q?sGqDEOCc7M6uaKQJ1p4C4F56Iud/nYVM6rwsvG2x8hB1GOx5uhw7wn1iv6W/?=
 =?us-ascii?Q?+PWB2MS91YE5RUY4JlYBZ8HpUPo+Y8o4BttWS4Ms3UPOudwmt+0d/+cgbgla?=
 =?us-ascii?Q?EWRo/l3uRysLSOM0bsncmJ7iY0sgm3lsh85pr4SlhSagH8pi/pa7NFYceKhq?=
 =?us-ascii?Q?oa8pVf3zVDGSg+Qc0RHrZlplggsIRoF054wtr4aEBZcFffxKUi0k8jC0hL4a?=
 =?us-ascii?Q?Hbaguurvos+hd2UqhuCuxUxYtmkhdXnKcMQyTCjBa5te6us835sbGM8W/wzj?=
 =?us-ascii?Q?O0GIxPE9QjRMe+RFG1rss34QgWSrrGdkeA5xAcNFvF7DG/ccHyRT4tU3wyPB?=
 =?us-ascii?Q?v9JFicDNu2wRSW/mCGEGV+r5SvrKwzne01c6eLr4ps4+3rVUL+rJEe/rjQas?=
 =?us-ascii?Q?oJzk4ZYpUSPQ/645XHf1yrWJ+FbGN1sVvc4hZGMpXRODCcjqkXHyT7EsNn4x?=
 =?us-ascii?Q?f/yc0o3JdWQZjtz6lNXcbzWjbD+xYk8Vh3FK6c6De0EVJp0JwvvZFec7cxma?=
 =?us-ascii?Q?Q5bcjM/+E/fGV5u878+fTaLezcF4pDv55tqYVLxTwRxQJzgT43Xx8pyJdrve?=
 =?us-ascii?Q?/C9xteiYd7or0I3ctTuWi67VgGWJL0A9FLftGX6zfWWqIZ97uqX61s1IeL1A?=
 =?us-ascii?Q?sCSzg4XCBedvV2GO3Qvv3RT2qUWRJjBMU3m7h4yYl6vW3Ii7dCgpZZHuLsy2?=
 =?us-ascii?Q?khrVNNUWxhYmeOu+SgypfBR+cq6jPnfmAqRpnW2JqrGD5GbRKfV/sEXQRvVF?=
 =?us-ascii?Q?HfTs3zD8hy9OiWUkoehGHTsXv/IBZei8yoP+yl9Dh5nngc/iH36XVwmVYIw/?=
 =?us-ascii?Q?QjuIdlYRfGjZYcSnZP0RUItGB81OYnirV743oAZoBPCxzXdpFV5O92Oy6cJl?=
 =?us-ascii?Q?yJpTBgH48RTZwUkfiyK1UCxya+tIy46oW7GXOMY2Y5IvYD9af0R2pGiPmBoG?=
 =?us-ascii?Q?xx5KMxuMHzjIwDJclzFDb7NsySIog5JUfvpA6EqpxOTh3SA/J2bXsYFxIUsi?=
 =?us-ascii?Q?i9v2G3XU6CaBiutYBLkpCVe/d1c4PrSNybzIJ3gLJq/5D6Y+mvre6VmN6UC4?=
 =?us-ascii?Q?kwoyJcwELmTrqf95N9DwN2hZDMmMJ3NNFWzB1YYuimpnvag1BEUCdudByYgq?=
 =?us-ascii?Q?MGXAiOGNt7MaHUg3RSolUppHPEZNlqlkxSmzfXAUaofL2N81HIoNPrEaxZbh?=
 =?us-ascii?Q?UZ8NC02D2+vOTq9xz4AwzvP95iI3zABpNYGzwH37HievlpWim4cnLa1NcTfV?=
 =?us-ascii?Q?WlQj8tQD9bzy9UO+frx617YZcQc6YBC3d7vgKpgpFAM6/Bb5xsXFM+W23v5h?=
 =?us-ascii?Q?o5Ptn1ut4jlwM/fU3zAYsDdTB5gy6Zq9m2ZzmtdDhMaFDBzLLfXTpu93yYiF?=
 =?us-ascii?Q?yaSVETiXNlwp1IzpxK71H4mZTqBE5rY1QWC4ssoD5SXVX5llf+6tYRofyBba?=
 =?us-ascii?Q?almKHVxUkoi++7VB7o+u+y2zQvPXOzbiNhwbYGs1X0hCBEQZz65qM7pxQHAQ?=
 =?us-ascii?Q?RbiOD1HQvlO5zzkFRY8BX6580y2pZCclW8tFDD1oAsd3hxi+4McKaLRF5mad?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e66cf7-61d9-44b8-1f7f-08dda4ab2540
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 03:35:12.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UuzFAmzGSqecFyEPuFN6ykjuxtBOdbzLnG8p7zai9ILAKRAlYUIGB4Himfh09f6guOg5eY6yN0lbOItJVjwLFMT2wvjzTh7zecdKdhgab0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com

[ add linux-cxl ]

Sudeep Holla wrote:
> The APEI error injection driver does not require the creation of a
> platform device. Originally, this approach was chosen for simplicity
> when the driver was first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/apei/einj-core.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 04731a5b01faaba534bad853d0acc4c8a873a53b..7ff334422899e757de918107202507dd171d61da 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
[..]
>  static int __init einj_init(void)
>  {
> -	struct platform_device_info einj_dev_info = {
> -		.name = "acpi-einj",
> -		.id = -1,
> -	};
> -	int rc;
> -
> -	einj_dev = platform_device_register_full(&einj_dev_info);
> -	if (IS_ERR(einj_dev))
> -		return PTR_ERR(einj_dev);
> +	einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
> +	if (!einj_dev)
> +		return -ENODEV;
>  
> -	rc = platform_driver_probe(&einj_driver, einj_probe);
> -	einj_initialized = rc == 0;
> +	einj_initialized = true;

git bisect says this change breaks CXL subsystem initialization. This
patch seems to not understand the semantic guarantees of
platform_driver_probe().

CXL init now fails with:

    faux acpi-einj: probe did not succeed, tearing down the device

...which will fire on the majority of CXL systems because EINJ is optional.

However, failure to probe is not a module load condition failure because
the CXL subsystem still needs access to the symbols even on systems
where the EINJ facility is disabled. In other words CXL has a module
dependency on einj.ko, but all of its entry points into that module
first check einj_initialized. So part of the fix is:

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index fea11a35eea3..9b041415a9d0 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -883,19 +883,16 @@ static int __init einj_init(void)
        }
 
        einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
-       if (!einj_dev)
-               return -ENODEV;
 
-       einj_initialized = true;
+       if (einj_dev)
+               einj_initialized = true;
 
        return 0;
 }
 
 static void __exit einj_exit(void)
 {
-       if (einj_initialized)
-               faux_device_destroy(einj_dev);
-
+       faux_device_destroy(einj_dev);
 }
 
 module_init(einj_init);

However, that is not sufficient because faux_device_create() unlike
platform_driver_probe() does not suppress bind attributes which means
that einj_initialized result is not stable. I.e. somebody can unbind the
faux_driver from any faux_device at any time.

I think it is reasonable for faux_devices to only have one chance to
call ->probe() at create time:

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 9054d346bd7f..934da77ca48b 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -86,6 +86,7 @@ static struct device_driver faux_driver = {
        .name           = "faux_driver",
        .bus            = &faux_bus_type,
        .probe_type     = PROBE_FORCE_SYNCHRONOUS,
+       .suppress_bind_attrs = true,
 };
 
 static void faux_device_release(struct device *dev)

Unless that global change is acceptable I do not think
faux_device_create() is a suitable replacement for
platform_driver_probe().

Lastly, for cases where probe failure are ok the dev_err() is too noisy,
so another change to make it behave like platform_driver_probe() would
be:

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 9054d346bd7f..f5fbda0a9a44 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -169,7 +170,7 @@ struct faux_device *faux_device_create_with_groups(const char *name,
         * successful is almost impossible to determine by the caller.
         */
        if (!dev->driver) {
-               dev_err(dev, "probe did not succeed, tearing down the device\n");
+               dev_dbg(dev, "probe did not succeed, tearing down the device\n");
                faux_device_destroy(faux_dev);
                faux_dev = NULL;
        }

Greg, if you are ok with suppress_bind_attrs = true for faux devices I will
wrap the above into a 3 patch series to fix the regression.

