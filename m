Return-Path: <linux-acpi+bounces-5971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4428CD880
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 18:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6142C1C2132A
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9E18029;
	Thu, 23 May 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+enE+r1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8E374CB;
	Thu, 23 May 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482171; cv=fail; b=aunYL4bmch5TxqtFH/3eBuBJ3Fgjpk9GCsrd4t3KkGTfqgtxS570GZum2SRgBQpMi2srokKRAZkn9rJO0Kyb14OMFAJyroP9yKzYNsxtJ5d+/1w80i+nvi9itoKBnbtakQA4ccSqdAIjR76qFVuAFquEopDxtJs9pmi7xLU4MYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482171; c=relaxed/simple;
	bh=z8n8aCOT1uaT/KsjMsutEXi7t2mIWhwRg3ZsDSPEQCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9eY/qFrF+ovsTgrMNQpM7EhSg/qKc9y+1Z+JIkreB/s+IYE5z77QNC3UyLrmnV9XZRfr/15WfLSzR8XRq6LpZA2WhcQHL82RkdWi568ghxzsaNrI+F6YoIBtYxuyGiW8iPf35yixL2Q1v+NoZ6tVFI/bnK7qcggpIh7PiQxRF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+enE+r1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716482170; x=1748018170;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z8n8aCOT1uaT/KsjMsutEXi7t2mIWhwRg3ZsDSPEQCs=;
  b=Z+enE+r1jtAEm8e/Fpn8Pt/sjUXu50TaDQE0lP8e2Ce6JUeD3P5xa6Ju
   2w1qN+42uVG2gm/tN32W1XOCjBqCzslzlI1lHVJNx0cz1Wm20bv4O/X3F
   8+Co500cGW8lcPFU9L5aTbXJtSLgZwA4+T8AisjfOMHfMbxhQIhyQJxuR
   6pd1LPy9dtHFTP9UDl7c9+At0BlFAVmTF8fhlU2vjhIV2EUBYXQ5NHKSj
   WAoHNDIosFQclLHc7sB9C4ypAWdCpmCcAY6FoTCKOn3Py7nd5h3Zrizws
   ruaX8DNvxi+3J+vpjkReh3+H2yfAm22ZaUOM0I0jbAzMgPljX5NXDSgjo
   g==;
X-CSE-ConnectionGUID: FJOVHixmTG6e6t4ZocQkgg==
X-CSE-MsgGUID: pBjw2etHT5G0iJAbgAVa3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13000105"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="13000105"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 09:36:07 -0700
X-CSE-ConnectionGUID: ue/B/GYBQq2aNHSxtIPTGw==
X-CSE-MsgGUID: nflAHQXbS12QrSCfnP5AHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="34333343"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 09:36:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 09:36:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 09:36:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 09:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU/zAyeP6nS8bBH4EuA4jkon1bXLjvq3O0SLfeoc2bFJCNt2ReS335w/6akYsU5UrbEqgg5mwUQVOkbTbPPnu+7OQHvUPUgYuQ3XbG342s0VVUvDwhXFdCiGbm9gAn5ZvB00SYqOIhgm4xoNTEzsrr2Bx5HEonf6GZtUePnA36tTH+ozJdY7pxMw0b8tlsJ1yG2jh9TZ8IAP/SGJPGER9Dweo3+5EnivhO7z+nGAsEZRbP69qUmxtn8R42218w+TFGwsOdaiIWgAHG+ldlFt2K0Hodfp7ajtdKsRLTnQ3F7t36r+E98jDitXpO/yNuZmyfS7LNCAETeFJJ8OfNm4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kny7vSKda89PooEVTw8L/VM5GDJT5PkwPPMjxsNeKwU=;
 b=Gcqo3WLHpgnfDALcHtz+RBSQ3ObobaZPAsihjC2/fAZsQvRsLeBIEMdHYFezK1OE6KyOeKxVoAaBQBIwjMfYi0ocPJbI2JJAiohwpVZ4hs+xvSbax1lsZ0Ggo2TzhxbZa3SaFXo2gcYdBEVDwLVmdcfcy/EvaEG/zTcbUICKAmHiLGWXYjpxEUB0Efmhxg9w02jFDok54O/+9oyBoA4dmfXuJ0bg1A1Jmh0V/Ss4qnuBXPLpsh2a8K/O772/2FYDwIGevh8xNqzVLM3cEss5EQHExpjU4HBA9whWW+/PiMyxYBp2pUwXd0kLsQVyVA1MQ46zq2IX48dF6CbN7ILUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 16:36:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 16:36:03 +0000
Date: Thu, 23 May 2024 09:36:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] Enumerate "Inclusive Linear Address Mode"
 memory-side caches
Message-ID: <664f707125537_18c429438@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch>
 <20240517174550.0000242a@Huawei.com>
 <6647bbf6c88e3_2c2629451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240520125333.00007a47@Huawei.com>
 <664cc3a76e7d_2c2629462@dwillia2-xfh.jf.intel.com.notmuch>
 <20240523124947.000034df@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523124947.000034df@Huawei.com>
X-ClientProxiedBy: MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: e6457b35-4703-4489-68dd-08dc7b466fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?51899C3NVpiTP8ec6siuvaO4P9enZ430T+0SXHk4wdWG1N44837HnPi9s9kZ?=
 =?us-ascii?Q?Ckz15fuZKGlNCWm52TlSwX6cGE0kUI5EbHZ0Fv3k+VOAZo7wkFBWNYVDQ9gk?=
 =?us-ascii?Q?sHMeN1jWVwS3u/tFV5xhkh+mgpUFAmhGOvA3vfYqtV2EyP0TweUWwntDNqxz?=
 =?us-ascii?Q?Ix6h1bhCaCt76BHN8ZnsOejNstvVdPPmGaSXOZACeRYDjYkDcWmtepXCviOo?=
 =?us-ascii?Q?IubNGsX6YICDBNduTw28U/ZlwQ1KJIWuN+tHc3bbifWiswZRY3wlzgM5VS6p?=
 =?us-ascii?Q?07WlOMXarb8KRuC2vIAEFcqst12Zum46T+h/bpHMFnuwGKv2phTdl+0+5W33?=
 =?us-ascii?Q?7w4qw/SRImCX4MUlAXIlg4+3WtnnrIv/GBfFldKz0okiPh06Tii5m6QgiIxs?=
 =?us-ascii?Q?38fDEaYP7lMBrQx4eSXQU8Pdgv2r7uQKdn4VfSBAI03T99fjiBADgV7dhnbt?=
 =?us-ascii?Q?2AkKanNY8FeBs8PQLh+B7oQjXrmLGkuLj/ki3wO6EIvP5S/VodohRYNmoz+E?=
 =?us-ascii?Q?+DsCerUVNlACq8WS89a4mprPBxfSU2Mxqpn7h4NjqOtutRGWcSL6BsjivwHA?=
 =?us-ascii?Q?U/Xs9M4dUg9RevKvMsKcHjxoD5U1OMzhd4e9omExDHYqDnYN/e3K4flfNaAa?=
 =?us-ascii?Q?FCWpCEoUYxDzJdnWR7Lq0tmICqsT1deq2CRrmNJpF6qcsfhQ5NyQ01+YDSSL?=
 =?us-ascii?Q?97UFTP8TEQ8Ks/+H5i6Ngdm0bduJ18K9wQ5LN/YnmfOCAI/EbHSMr2bxK4Ve?=
 =?us-ascii?Q?JpMKoDv/qxZW181ZeWQqxppeP5A6ShNbHPrRktO4T4S1bfsxbBq1fQTsgpdq?=
 =?us-ascii?Q?muatGPnBJBGAOsRjDX6MEDGV0TcoZpPQ/fM+FyeJemzXNRASwopupvlXV0H+?=
 =?us-ascii?Q?su3rATklrGPbEe5IS5lUYeJ4DBiGAlQ2oN/e0SLgTnf83kNQrRS2fEpBLKNv?=
 =?us-ascii?Q?oQvqg2zFv4frWHCgxGwGc2ibUiqRvFfIyaYh5GpVIZmdWE5OMhVYgWuYPbre?=
 =?us-ascii?Q?R7J2zX4y16eJIR9hk7HK0Dag5tv+mAaxRGMGW9RsOu2qJ2xewcwVv3/kOuWc?=
 =?us-ascii?Q?er0tGIfhuH5kIF+6kHKIGxL+1Tlyrml6JJ08Rt6/HF4qTiD9t7NBW8JRd9LU?=
 =?us-ascii?Q?LuShXvHzUSVZlMkiL6wBVzEkNkAB18i6v9vTM5cBWRfx2XkL/a8db7zwi2CC?=
 =?us-ascii?Q?D3pYqaoFQFRJOS/LDkqx6DolZUfyeCfgrcQA8oFwnelp2PfUxm47JKG0/2Ug?=
 =?us-ascii?Q?lhJ8sssMP8ElUhdk9mZLaMe/CkDjKJdRy8pdnCUdbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PN02wlnWdR76TQFwOKTEyY4XCrlvewAvw/BolpaV3s1yUyIRLQfm9kjr8e2u?=
 =?us-ascii?Q?DXL2CoXG99XKVdhl2dGKTEPwbXkWVW2U0oD3prfoXnv1tFr39fND19x2HTYr?=
 =?us-ascii?Q?Ifjd7Ui1+fwa5ViSLbgPWlfLwgr69t/04maWEyuO8sTHpBtTdvOPvcWUxxWS?=
 =?us-ascii?Q?Wpe4GzMSj7Paw6yUYYnwPoohNsx9Ofk6x5BlEcVpnx/z36tSQwyxg3eSqIsM?=
 =?us-ascii?Q?pFpgjlmJZguigdtIgTPzjjPOu1A7dkh47pNDy1Zvx8B4fSX5+FspV9pCziUz?=
 =?us-ascii?Q?620Mv09f6NcyCzMstFiiulH+Dm24/3M7L9jQWXQ+xujoB9fKOB1QrfW761RK?=
 =?us-ascii?Q?gyOrL+TR6/B2hQupbLYkB7X2/z51kbgjjdtKj7gAVdFKm+3rnFWH0WCZT4Ml?=
 =?us-ascii?Q?EQi+GBBrZg4kmAoD95m9T2LP8q69KnIiYu2MN+4RULKe/iFY5CiNOZL895IV?=
 =?us-ascii?Q?IUh3Kntmevwv5T1eBJ2TPXVulYANMOTYu4JNjplj8Rj8Oj90x8SQHEc/pszT?=
 =?us-ascii?Q?0In4A1BdZvFuFi7UwU6YJjDFp/9cHKmj8RbZ/+ZgdoVvgGJDuQ5m21pNriWb?=
 =?us-ascii?Q?zwTFpZj5b2OAnvedzZ9KrKX+SrGmeFHUEQ18mi7S7Rf+O12JD/IeUHmvH4Cf?=
 =?us-ascii?Q?7iezJMrUw5Dd0/2PtitKK05Cuxznqdq4dqKdQOafpdNUv1Knq+eWaF0MEI1F?=
 =?us-ascii?Q?vbgNMCxbyCPJR8v0Bgmat5iqvWoaXhdTcve3feGqHxvuXjId9xI3sY0DPL57?=
 =?us-ascii?Q?gcIqeNgyx1GqyWC4sJfGazZz5Ki8fCo1wOeBZJ/G+EoJuch/gd0bAnm1OisU?=
 =?us-ascii?Q?dlmtTJATBd2+APq7Rn+Vogral6jb5hpERSxFphoyu4h5WhGZxwTPicw7k3eX?=
 =?us-ascii?Q?i0j0j4NjqYVAF9DPkNTilpwRnuyKkTIGxbhXJkiclaF0GaSYzMGdDQWyof/q?=
 =?us-ascii?Q?H3ghhiFrzv/DKxYl1qn0bhQv/r1CZC1/nkZoPehX3/n7psT2FtihgdrpP935?=
 =?us-ascii?Q?OaYtk3qja6lHWQJ0OyhtVsZUF7zhPws0jV/HgXbGUQx/e2RMSJeiD87LFH1l?=
 =?us-ascii?Q?54RrwM1YqmqFKk3e1KmjVJr17a/8zkGIg9hJJIlEWhx0riDBYHttXGm3OxFw?=
 =?us-ascii?Q?k2ESI4BHARnnvlpojS8p4yM1XvwR5oyaesgP+ferhqAHE1r/6fOjN/MAnM/o?=
 =?us-ascii?Q?13PrEACfYjj2z0KAZPkojLy+Rty83X4EpkNrB06/awhVh/xai3KRQvvtsTl9?=
 =?us-ascii?Q?QuX2J+89eU3l1rcAtGpQWvGG/jSYjMuZR0qD6Crz0p/fppGqOTwWRkdnLE2W?=
 =?us-ascii?Q?vZKYghSxVb8Rc+Y7aplfNCyU+tltYuQKkdXsEF0k/1sWI1FVHQ5CDcUbZZem?=
 =?us-ascii?Q?bhTY7WVnBtF6RIKEq1ewret4ThP2R9POn+Ucn0tcvyF0aHbcET6dcpZ4ISFm?=
 =?us-ascii?Q?hO8/VaFwWdXcP9QQPZNY0rAj7+0JUKhe9fYlTULIuXseZMDa3m3urJKyAWwB?=
 =?us-ascii?Q?l0FQh9Y+Fqywv+KtEc4lM2F6eGlNmhnYo3tKpQcBQrQ649L8CIdQ2rM3auuI?=
 =?us-ascii?Q?d7yAS4R3AU9Ck2B6/+qCcGWI6uYvRnoDHR5kk4KUFHpRFLsTMOu60RdENX/Z?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6457b35-4703-4489-68dd-08dc7b466fc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 16:36:03.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS8BglW5BpCvHl05RUrARS6ajGYxG6/d8X7UHjLE8uofdvi3sokO24YZznSDUh8Vx7QKrXDw2ttsE/Hk/tp+ZGCWXZ5ufffN+MLFr/8Sdts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> > 
> > > > > Whilst the CXL side of things (and I assume your hardware migration engine)
> > > > > don't provide a way to recover this, it would be possible to build
> > > > > a system that otherwise looked like you describe that did provide access
> > > > > to the tag bits and so wouldn't present the aliasing problem.    
> > > > 
> > > > Aliasing problem? All direct-mapped caches have aliases, it just happens that
> > > > this address mode allows direct-addressability of at least one alias.  
> > > 
> > > As I understand this the problem is you get address A in the error record,
> > > but that actually means any of A, A + N, A + 2N etc and the issue is you
> > > have no way of recovering which alias you have. 
> > > 
> > > Another implementation might have the same aliasing in the cache, but allow
> > > for establishing which one you have (the hardware inherently has to know that
> > > but I presume in this case doesn't provide a way to look it up - or if it
> > > does, then issue here is that the OS querying of the CXL device doesn't know
> > > about that interface?).  So I think the critical here is that information is
> > > not available, not that aliasing occurs.  
> > 
> > The critical information is that the address range is extended by the cache
> > capacity compared to the typical case. Maybe "extended-linear" is the term I was
> > searching for last Friday when I could not think of a better bikeshed color?
> > 
> > The reason an "extended-linear" indicator is important is for the driver to
> > recognize that the CXL address range programmed into the decoders is only a
> > subset of the system-physical address ranges that may route traffic to CXL. So
> > when the memory-side-cache is in this "extended" mode there are more addresses
> > that may route to CXL.
> 
> I think we need to be careful with decoders here because the extra translation in the
> path means they aren't in HPA space as such.  They are in a new HPA+ space.
> In your case I think the translation is such that addresses are the bottom of the
> HPA window, but they could just as easily be the top of the HPA window or not
> within it at all...

No need for an HPA+ concept. This is just an HPA vs SPA distinction,
similar to what we dealt with here:

0cab68720598 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window

Typically HPA and SPA are a 1:1 relationship, but in this case there is
a memory-side cache that sometimes translates the SRAT SPA to CXL HPA vs
DDR HPA. For any given SPA in the SRAT range there is no way to know
whether it is currently dynamically mapped to CXL or DDR.

> |     HPA window 1 - Length = Cache + CXL                 |
> |   HPA+ window 1 - Length = CXL only |

HPA windows are never impacted by this memory side cache addressing.


> 
> or
> |     HPA window 1 - Length = Cache + CXL                |
>                    |   HPA+ window 1 - Length = CXL only |
> 
> or for giggles
> 
> |     HPA window 1 - Length = Cache + CXL                |
>                                                    |   HPA+ window - Length = CXL only |
> 
> last one might seem odd but if you are packing multiple of these you might get
> |     HPA window 1 - Length = Cache + CXL      |   HPA window 2 Ln = Cache + CXL           |
> |   HPA+ window 1 - Length = CXL only |  HPA+ window 2  Len = CXL only|
> 
> To reduce decoder costs in the fabric (yeah we don't do this today but the
> bios might :)

No, BIOS should have no opporunity to confuse "HPA" layout. Let me see
if I can cutoff this line of confusion in the next rev and explicitly
call out SPA vs HPA expectations.

> So should the text say anything about decoder address vs (SRAT / HMAT addressing)
> Maybe reasonable to say it's contained and aligned so modulo maths works?
> This is a bit odd as HMAT wouldn't typically provide this info, but this addressing
> mode already incorporates it sort of...

SRAT portrays capacity, HMAT portrays cache and address organization.
There is no need for bringing CXL decoder concepts into the HMAT.

[..]
> > > > I still disagree with the implication that "inclusion" is a property of the
> > > > cache and not the address layout for this ECN.  
> > > 
> > > It's an ECN about caches - the chance of misunderstanding is high.
> > > Maybe there isn't a better option, but it definitely makes me feel uncomfortable.  
> > [..]
> > > Maybe hyphen will help? Inclusive-linear Address mode?
> > > to avoid reading this as separate adjectives as in that this is an
> > > 'inclusive' cache that has a 'linear address' mode?  
> > 
> > Try this on for size:
> > 
> > * "When Address Mode is 1 'Extended-Linear' it indicates that the associated
> >    address range (SRAT.MemoryAffinityStructure.Length) is comprised of the
> >    backing store capacity extended by the cache capacity. It is arranged such
> >    that there are N directly addressable aliases of a given cacheline where N is
> >    the ratio of target memory proximity domain size and the memory side cache
> >    size. Where the N aliased addresses for a given cacheline all share the same
> >    result for the operation 'address modulo cache size'. This setting is only
> >    allowed when 'Cache Associativity' is 'Direct Map'."  
> > 
> > 
> I don't promise not to change my mind, but today LGTM.

This sounds very similar to the voice that is always in my mind when
reviewing code, reminds me of one of my favorite Star Wars quotes, "I am
altering the deal, pray I do not alter it any further."

