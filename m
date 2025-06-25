Return-Path: <linux-acpi+bounces-14651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BFAAE9019
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECEF3A2F74
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C7212D67;
	Wed, 25 Jun 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cM3bczOE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545F1D54FA;
	Wed, 25 Jun 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886395; cv=fail; b=bUrQfDMvTc5teH6sipexBNEdQhO4OlNiwlNZQlCZb0/dbKetBYOJ0C6BXyDZBnrJ0dEJmcCwXamxV98cpMQvkHAeaCj8c4qr0MLC7zDzh00XhmLhld8lozqnp+BiSFO+xt7vikW04x2fzMruTtLol5zc2QySrqHSjQ9GAcxXlOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886395; c=relaxed/simple;
	bh=auXGbS5QIhPpI3rJKDmTL8tip+NXNheqd7SaoUunly4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRC04M18F+hK+h7NW7kAJf6yeTIuV8OesjxtPeaeuk6HWYIgAZI45tj662dvyIqUAdp5++vsQxWAfXdrCMeBgN0wI4Bh9MYN+Aid8Hpiia+0/YcQnMXUM9/4AIn3JgwVRXB0xh8DaMdGprHQVxHz059FjQ32h8CGrPjj/46B3dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cM3bczOE; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750886394; x=1782422394;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=auXGbS5QIhPpI3rJKDmTL8tip+NXNheqd7SaoUunly4=;
  b=cM3bczOESgmM2k2pZ41fzgCEBAIUDNGEjYtCcveFE6SrkhyBZzdvkotZ
   OkPLQL34SjtQKGzu3QjM2x4serL5y+CMf4tAUgB449IUfAisUqsgBlexa
   nxbu7B7BRtWTBEJ8UHfgsRUEFnqiBkU9hOitn/w3WvTPOqWzvMvvASvtc
   u+tWqP204fuNI8efaNREwwowo5f3hiHpnM1o9iM0PFAx0GCrXQerfnsmK
   xVZ/YQPcUjaQCLv+ZyCRBPw9nVmNthP43mQt0qZ69pX7ijhHuNbZsTPO/
   O5s2Zz2LK+9rUHdKNk+DKnOhi5uq1YQNYmPHzA6KwGzfNuL/Rii/LtTMP
   A==;
X-CSE-ConnectionGUID: 4BYNJEYtRhmiOsgpFnm8ZQ==
X-CSE-MsgGUID: Yoth3aK5TQiDDqfUqfY7DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53109228"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53109228"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:19:53 -0700
X-CSE-ConnectionGUID: liRLfylyTT2pTtmS1KBZTQ==
X-CSE-MsgGUID: iqmPyRWTTwSPiKrJTDAdpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152852018"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:19:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:19:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 14:19:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKTcksU7w+PVi8EMuByqFoPf9ObYOst7UyLjjGeBjVzOuznwxTz+w8LOgwwDq1zMNDsnDYtg2rSvygcGwfa7MPBfIyunwCWIBQZnQ8n+JVK47//evdxca+lnVUv9WFJWfgnRGYIV/SzIzw+1WgDX9NOnTarCZW7Q2YZ/D93SrnfdYvKz+k9BYtpRa2fMTA7b3shFHX/xBpZfwQ7r3hZcFQI+slDXIro/JkEzT4xIOUias1ZMuTrWzszYU9TDiVLuCCByebVtHRYeMBlHDBnTHdpJi/x4VGYwWb4rOlhZX+R0p9b0m5yG0kmXQy+Efgif+6YL/s6huXx36RUOc3ozuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NbXve0zwSaYwgya7VfOoJq/Qh1p1wgaG+h7a5aw8yU=;
 b=t75jt0nc2heZXwX8iiKQf20Qs4uQwERnAmMYhJ1UcKLIX8BlPIroLyOH7Dv4mSVCPEKFibHJ5PfTL6GbuRbSA20CvKu1FzI3rodSneK9Idk5DaP7RpKqwtjXNIrldDT4/iK9Sta9OYmmAozWKtG98l4wDskbeeuGuIuPpGcmyw9XYK5MTJHIXFIj7BFMpEDpMrt25jCzeyeks4f19f522SNUayNvKFb8QQgooF8bmDN3RgxJZ5K65PDze6gN/Zlb/EcpWOUYPLvGwvVlZDsYpqSRTRXbuAVUhsgIEaKJGng5SguN21Cdbq5FaE0nPKVn4YHO24vIIoads/Gaf4tiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DM6PR11MB4708.namprd11.prod.outlook.com
 (2603:10b6:5:28f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 21:19:50 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Wed, 25 Jun 2025
 21:19:50 +0000
Date: Wed, 25 Jun 2025 16:21:09 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Zaid Alali
	<zaidal@os.amperecomputing.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, "Sudeep
 Holla" <sudeep.holla@arm.com>, Jon Hunter <jonathanh@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Message-ID: <685c684533e1c_2c354429441@iweiny-mobl.notmuch>
References: <ae6286cf-4d73-4b97-8c0f-0782a65b8f51@sabinyo.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae6286cf-4d73-4b97-8c0f-0782a65b8f51@sabinyo.mountain>
X-ClientProxiedBy: MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::33) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DM6PR11MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7275c955-f922-440b-7186-08ddb42e04d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvxqafOMCBSa/Tw5qyWRRPEUbsAiWQDo9M8h0q36SUd1pQ8dcgpEJxEN5+EC?=
 =?us-ascii?Q?JWMqnLDMRcSD9uQ3KXm4E1NmUM8WdUcVpjzSfQAQVFqrobt029ojh34rLoBo?=
 =?us-ascii?Q?oBHqJbNeSdFLlquJgcEYaStYF1/HpnIGl6Qp4koKCTmMPaxz+dTW7Bt5I18P?=
 =?us-ascii?Q?hLLzdisPwtstiG2pfs3grIrfd+F2gyoVdeM4X+bVVy76TjJ9vyd2YqTRRSQw?=
 =?us-ascii?Q?zZ7Z8P1dRUW6sV6bxWlTxXCRmLa31oxMKVaiEokN74u3FjlzGxCJr+66KNLe?=
 =?us-ascii?Q?OrfMFbtIzbXBc2b8Wb8ljFIFfKY/PfJTVR5GL1DMgiWrn5q+gwLLA220PLcK?=
 =?us-ascii?Q?/uRJ8BczjJI2SQXOv7gRg2HmPW9gKihVQHLrUxrBrwYyCKo4a71SKsplvP0g?=
 =?us-ascii?Q?Eq1/JJsL+qWIOzqSO4HIvN6/GauzduDIt1D+5LVFvJULTt8gNMaIx8x2Ugv7?=
 =?us-ascii?Q?zDKi40DecQndOkZFvCks2f9f1KRXcfQojHe2r7DGk86vdqOZ6QsBD43sX2MW?=
 =?us-ascii?Q?AOTf7Zt+FW7hgifXrUB7/OZqmG+3Hn3Yn7O/tnkv9fVtsPqajZ/5KyCyl6Ej?=
 =?us-ascii?Q?LgPDvZ3YpJ/R2D33j/P/QTVmIlwBVzRlQNEtxCf7nY+aoXq8xtyMjKnyYUCX?=
 =?us-ascii?Q?7vq92jaDxaANu5fsVAdVJ4Oq/PTKBCydFRx8M5rMYU+a8Ad6RG1skvmjhgLv?=
 =?us-ascii?Q?WDuIMfwF1hI/D1t8hMPDQo4weIi/GkFNRZ3qVqCRmDDa629AIvj/wnrq43DC?=
 =?us-ascii?Q?vFaSZ9/RRKveCfut6MyxlHO4m6xaSoSLFMEZQtUDVsyN+qcUh+IFGfD3qJ92?=
 =?us-ascii?Q?4JRSlHNX193w9ILMkNSgKoqC9/wy1t65A7lW1nYA86xADkwz8c0bmGqJZ1oR?=
 =?us-ascii?Q?lAOK1+H8YOKi0BCM1I1Rxv2QN+jHzxdiPpDMIaqbeSqnM+ihUGiXLzblzkwX?=
 =?us-ascii?Q?IFuTEXnesyxJMuDZ3/TewDx/Rr9Cn9YX2sRdLh71e2me3WgZq/OyML7/JqQd?=
 =?us-ascii?Q?1gKMqfouwrOg8nqTD3pUc3VgbCo7xFNlkRRmBPwuesx3Ss2pXEPe5pV6dI8w?=
 =?us-ascii?Q?/prEn1dHkaa3kHUchYlZeFrGQAQeI7kAHs9fO7XCaVOa/N/pOXjfR59tWS5x?=
 =?us-ascii?Q?DxwYAXUIt89CCSN/d5TH0UZ0VpDYYFtZGt536V9FCFSHsm6QeafJPFs0X6Kq?=
 =?us-ascii?Q?9i7WfGJFraUD5ozqp5asJ/qMpaSRcjrB9Ob87KWXWavoJgt+/9l1YMNpa1yG?=
 =?us-ascii?Q?NHc6W6DKF+e7wZ/booGu8kqN8M4xqU9IaMejor95mnGpkEURrDIwqh6BULzP?=
 =?us-ascii?Q?IrSU7VjrbxaODqgn4FYMzB9ORaQwkzm6h1cUG1wL8VvQ/FfGiKDB0lvPIjd+?=
 =?us-ascii?Q?AO1LvkfV7dTwIvZ1oK/F6kHjBFkwmG/x22nf9MAcoHsM8iTnviLxegffX1i0?=
 =?us-ascii?Q?Tozq+Ld0/yQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHg47nrH/65rO8AZg0/vsPMrSFM1zHhtjwAL0ljmsZKYaXtjR1hv3SNEHor0?=
 =?us-ascii?Q?UtVHsUpC1aPmEAof2oySVWYLEbmPWaW80kRz8iU6kH/l4Obl3ZA+vquhW64g?=
 =?us-ascii?Q?52n+UKPQVLLuxiDjD3mtJ+u2j16kD6iBEQlwph7QdGd4mDMngP5ptQSU2MOm?=
 =?us-ascii?Q?s4qg8+0B09xpK4cm2YEW5gp+CBJg2cEZZ53Vilaz0z3bAWlmY2CTH1wi9/+p?=
 =?us-ascii?Q?xXKFFTygwHce4rNhwHgahYNHwMT8yZreLZF6grMgllLsugA8Bjq0IRjAVrHm?=
 =?us-ascii?Q?VEz1q2UGLdQIHJUEajP3SZis4Y2gTEjV7oq6pu+y4hjCi0L4VNXhEDze93p1?=
 =?us-ascii?Q?K5HVF6svBxofkv5rsM3SfLHqL3hwSO5un3VTDateYNidW5FtPcLUQV6MT6k1?=
 =?us-ascii?Q?7wuqG0DKEBwdJNB5AmrNCAdMQ53Wqp4sYJd8MCVK1fBUwMDiiBXTDA/4t5up?=
 =?us-ascii?Q?WzudJtU3kzOhfqrhXCCHiOpwUCnQUtmOI2gc9oGnI22A5Ls5jK+ZmnMp0JeG?=
 =?us-ascii?Q?Bkc+slIXg6bZfdfacBQ2fo9sMEw0O3AOSPmlg8uvfVpJ3vC4woH3Shs0XVA6?=
 =?us-ascii?Q?Z8zTUzZDr82STOw7cOCVfJpLtokMiKMEr3rqqIfKPEExbhjCbpnIBnHq40ci?=
 =?us-ascii?Q?sbdVjJGAG2AX+Wijamsy6o+3PDayg2aepY0fHzX3+37WN0pGQePPCXyOVQcz?=
 =?us-ascii?Q?8Wkn0EQvInBjN+5RS6aA/xCj/nF+pqs8XJeLp5Qgush1XxDErpE6GWEbTyyv?=
 =?us-ascii?Q?mt773BJ5Q/W3SAMacSM1vNKZLPAy8/SMa5so/V48jKLy0H+tZyLAcWlhikWt?=
 =?us-ascii?Q?89JsMSjvZYPwVEtEjcSBdti6tw3fC7+bnB4tIpzepfUiCL03Cqz9iC6sh7Qp?=
 =?us-ascii?Q?NtdOoWOgTmBzhoS5O6tz4XORYKP6SfShRuPguVqffI4WMX0XBmP2Bn/JQVDq?=
 =?us-ascii?Q?mPa0mE7rvcvlDJZTDJYXE8uv+vIzU2H3K40Z5SZWBDM+/hqpJhexRcyIhURS?=
 =?us-ascii?Q?9HTgthRhDkMo3J2XAycIECIu40VZWUoAsn7NV6BrIv1Q5FtLGOswzRc+BBn0?=
 =?us-ascii?Q?vkW33s5o1oxg2cZlJNAU+lkUdv+6pYkpJehrpype0ePj2ubJErdiaNzq594l?=
 =?us-ascii?Q?6ImxiRexHGUDHfEQvPbLCYOcQ1z9VZQue0XSLLComzZRU2gVkpJ4BhdGUwol?=
 =?us-ascii?Q?1dm5ly3qx28DBpZqdt7JWG0pgq5EScj0FBF4Y2hHrnF/v6YecXXnM4cCIKFP?=
 =?us-ascii?Q?0V1dfcM8t6XAPeubDrvOG6CMVmiBidXjfVUtY1eO/ykbenl+9fuQrpIUNIZ6?=
 =?us-ascii?Q?yZlaNX0HjCpKhNmc2CHKxYz+S38Eur2hjXWQiwzHa+q7jwt+1SzWmDXfJiQv?=
 =?us-ascii?Q?yjQLbJDigX767V1jcQpqIS2cAzDiSjkLgrqaVl/ldJi+4OHeE/EcxWm7O80o?=
 =?us-ascii?Q?cpNzjZ433qSffCe0wpH6W491lxnRnZRgwon5fjGpTISNtzuR23UrbEG0FklN?=
 =?us-ascii?Q?3RJCfmEcMYNN5fuA9vdDQ7HbYlJjn8uv4SwTt91ixfL9kl4iOLnX8Hu0LwL0?=
 =?us-ascii?Q?fyIK2xCEC+YqYTVyV1FsHL37jQdNmn/NQRjnDNoG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7275c955-f922-440b-7186-08ddb42e04d4
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:19:50.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcc4g9Upb2lw9imFZ9FeoVj8qlU8GZIFdPyOTUNTAO6vpXHN1SRHne2YnC/CDcBqdekoFijWGFTuHnClrTfmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com

Dan Carpenter wrote:
> The "einj_buf" buffer is 32 chars.  If "count" is larger than that it
> results in memory corruption.  Cap it at 31 so that we leave the last
> character as a NUL terminator.  By the way, the highest reasonable value
> for "count" is 24.
> 
> Fixes: 0c6176e1e186 ("ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

