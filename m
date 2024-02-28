Return-Path: <linux-acpi+bounces-3990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B786A819
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 06:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7214328322D
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 05:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F45C2110B;
	Wed, 28 Feb 2024 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeIn+fSJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0C21342;
	Wed, 28 Feb 2024 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709099255; cv=fail; b=Zi66LMlglTEjqfnUrHR7dNttQC0Kr1+hBTd+K232yECn+iq8AXeNhcU0BYZBOefMxER0FhIj9zvmc6Ru/jtK0WIgubrLQFwwyj7olQ7r/yYz8t1pKmSMvDu/vkdexcPt3KyyjXtKPVrfP7ewbqlJUvXtDdTFy92iCmvedpjBISc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709099255; c=relaxed/simple;
	bh=NEgJewwRyjpeRp0RqBb6dEJP/p7JzbUjR7I9I321PP4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CVUayIgJQJFO9wjr7H1JW+r+/0uNxGQ8mQZqHM8jonXtotqH3leToOC3yQLwtagI/cBYT/+S8cj5p+aVWeoF235eXDvehVq9wjth3rMRqr7UK9KInFjKtJHwK5CbyqiemDyGZ0HA2W3ht6KKu/xZsfLA/DW9GXTNahsvqV/swE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeIn+fSJ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709099253; x=1740635253;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NEgJewwRyjpeRp0RqBb6dEJP/p7JzbUjR7I9I321PP4=;
  b=NeIn+fSJcQiZVHxr0yJ1MDkmajTElpX4iinnrcr8e0fUm5AX0K6jQGxj
   +os3zRo5/NxCyoE84JBqR0UOxy3ShB+9Ot9qrvppGnDJO3KF5L4hjqn9r
   P0qx3UgjQ8BpaPWlwi/WNcDUZDaEnZmGNQmUTAC9wGYlksS3MlSQIyT2z
   5BmtQzll0cz1h8fyII0s+L6vxeHkhOV//hadS7bbQf9XYOaxBYJTwpD6q
   5kiEZ65QhIdEA4wWgq8rTSIL0cCpJJlkGKL6069jm0w59l1KSVLUBcA5j
   x1oB6y8Jjv3QpYfzpTzHFqS5Pu17+f4C2+VrltuPMdzrCroDAq/3msp8x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3603570"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3603570"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 21:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7267256"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 21:47:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 21:47:31 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 21:47:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 21:47:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 21:47:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3LXrgfBAGqlWmfp7Odhz/hcjRjyeAzR0SxFoNGFG7IxdXOSEFFN8z193ipFQ/rBY6njT9PoADmovxt289j5SHJ9TPXt9sLAUFLm3TI3FNS4V8J87DPE1of1OxH5ZvqJ3k2TFi7gZ78sRijKfOQNjh3zUbe/et9k1XNH7OBEvm7jarALn1KzOdSGVXXmAnY55WuWLHvaEyikHXMvaZkLLdMVXsWlCuook+S4DamKsKK2tIGGOx9Ra23wdWcvQXnBFlCy/BrPeAnSeR+WHRZK1efviRDsfSwiVtcXVbchwVKDMLwTD/iFFpPEH7Hc66ca40PMIxdYI5Y5LMIEwZx27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DRqEUxwaaCVzgm+SyEhckLf+035V4B14yUtVqUh96A=;
 b=UBtSnL/ESCli3pnZQPOP4UPvrUL+CfjDQTgG0EQWf0fg59eKqOvkUfx/wtHJhgnJOvS4jRk0gnHFzll+bAewpKAfNyvw6w1cXhqwR55J54YlbQUgERQadRTe5FUJxNXKWtZGzqBzgheuJ7FUyqnPeGArCQ97MJgvnV/A8s/uULk19gCu5LMx86qeuIPhIIbhy9ObFi//3CxX/1uPo1s63fYeocNXmbmBFDl4D/NC7K2ZSCX5TkNwBM+IkFmN+Kpj5VL7gDpUNz7pLbQzZE4qmhl9Ssb784363nNJTxv7q9jPo5kjcLxClMY+PAZ5TsWRYBlzwip15oDFUwAYlxNmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 05:47:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Wed, 28 Feb 2024
 05:47:27 +0000
Date: Tue, 27 Feb 2024 21:47:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v14 1/4] EINJ: Migrate to a platform driver
Message-ID: <65dec8ec4d478_3651e29421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226222704.1079449-2-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e3e600-f7c4-49e4-d41c-08dc3820bed0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKtIIk3QjwA6MU8YZzL3S24fPI2LiPW/iJq1KeZWDc4MFcV0w9W/0etnZLL5RmUWP6g1vA0JjVspE1Qhhnh5oXd9UnEgtDOj6wTh5wtbZ6tRGgQa2Rx2MNJ7oBoAyyb2kDKV7CQ2Yf62a8a8Xk9dfWmVr7HkoIt7y0S9b/ngJEbqPWQRw+sWhFBalaFi9WAYLAJ2qvLq2IqW7Wl3TXSaLPsnVimToXjIIj5eCyKGF1c2jzTaUZzgeJOmGHjisaEFsmuwQGuEu/piYjx5lwo9kT6OZz3LQvFny6IA/PHDJoe3B0dq8kzxCKXOvNXO/2EbqjJpJK7erwfxXjgtnv1fztyqxfXxw9wH34iXadYk0VmX+V9+AR3WtESA5ZrFxILweVcTQyBeUAki3vwGaPoSJqzJIlVvSJCdxVswoZjU2vb1bXBSZRMlcJYlkf0eTnbH3EE/lpTTjej4kT6OQ41sN3uo9zfJ65Uey6yPufSJrfPRYYS3tdwiMwgzeL0LclqF3bs5PzC6lqdhlmIsell2VoNLc+KMPJc9X5sOJGQRLgnAS0G3QruQxGHXj+MT7TTlReY2rZQa19z9WprytO2zaMusMLJ7ZWigyQ1Ip1IsMsw6eTMprA3C5Pdy64psk0gy21JAmgzmFDgKXV7pVLoCPHGc4HC0gm9NBccy4LtvcEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+FS6VihCGolMxiXmoV4TQd0FdByvEe8OYGjnLKGFdwn8YJzbrmP+EQgZvCV?=
 =?us-ascii?Q?g/l35AaSBd6P1JGZZVfeoZhS+SJ0cvUQ3o9Nea/LyAxBoMBE9n5/YZYznZtZ?=
 =?us-ascii?Q?jdPRLwB15fxmg6q8hMzDBf0LQZK9nu5ZV6p0oGdQCN99WhzBR3LRcVoVYXC8?=
 =?us-ascii?Q?rmV5STHZZ17JDNENUPcMOm0/U4EiPc//7cziTxdINr/SOwUtvOLMMCafo4Wy?=
 =?us-ascii?Q?u4EjMaMFxf8DdAy0FoSYEca2oD2EL42l2+E8m6uNV5DWrIEjXsd0avRzztC4?=
 =?us-ascii?Q?kjA0YhpX69UeD7DWsy7ZNY1HeoP8+8dpITSSDMGQLkccXsgBaPVf9Yh9Ti8A?=
 =?us-ascii?Q?31kpn4SnCFK2pWo6+m8Ai4IwRTdBfYx5jhI6Gg0djgQOaSZ103k4kKi8ImGc?=
 =?us-ascii?Q?0E3lAJ0ut+JvdfjrSEIMgtl/6mUFS1qRKyq4HtXCRrMol2pr7RPyqdEHiGA2?=
 =?us-ascii?Q?K3GJ7bMredEcmSPraQohSLEMzgjnYS3ytR5yqFaYIYnAKTILEv3LDgeteGGB?=
 =?us-ascii?Q?Q/nCNrvukO94pefcxkNWKtX0AIocLRfWKI0U+DVUHIIYCr1iu0j88YPtd8b4?=
 =?us-ascii?Q?WIhOuSubUMHGxLB8RCQpmiw9eNjS1KMsygUqKkNkO4k93h66qaMO3BRI7DRH?=
 =?us-ascii?Q?kopMDqEnQQLi1fJfuE0Y8DhwiQkdUE6xbUVrXRX24TtYKcJn8lF7qI4NlUhB?=
 =?us-ascii?Q?kMk5g6yDe9MJpC1PukpvoTsSiTk5PfP7Qq+oFT9g8Cj5t6fCQBASHtfRhf0W?=
 =?us-ascii?Q?vN0UGQSoBRSvtY/TD/po1KGUdkVH9iSNwr4Uv3zYp5Fu1ZOaik3iZamvQ/Kq?=
 =?us-ascii?Q?D6/7JZDN8LiSlJg/K2h33dmqw2S3CPrp//01d5hwDI/yGqipd3IMgWcZJpo7?=
 =?us-ascii?Q?fO+bI6kCAfE2l81PVjszKVLfZGViKELQl7GwhilkYkCxFCSVUycRfVVvFI/L?=
 =?us-ascii?Q?bdfj/mUDciwQDxLnAgToS9o89UpyzlceoiqwWh30YmTkcfb+4TTF62sOrwsD?=
 =?us-ascii?Q?6lLli6IB++9PKcLbZEmSD/ikYZgm+dwIFiCBvxBbe84lWg3nz+1hBOSSQ+7J?=
 =?us-ascii?Q?OCFTamnjuWO6cHhB7PmB/pjjtFud8IW+wLudIDgQXeGXe4xg614Mz5zKkN0N?=
 =?us-ascii?Q?UEbHxrH9ClUBVn3HosZPDAc7cFzspL/xH4tW0O0P9Ox65/7pP7CW1/ivx5DN?=
 =?us-ascii?Q?TIA+DYC33O25dexWtaFYErkSnoOHIOYaTRo70/8Xv9eTKkRkpkoyloP3RUTB?=
 =?us-ascii?Q?AcddXBXQohPicxFhdg7Yuvfi8S/A7pTA7OUPmUB7ZlQA192o84sZqSvfpi3E?=
 =?us-ascii?Q?0/Vd9j2mRFz4J6XIkPc5adAjzzZ9Swl1zsHeLTJBgw2DKNh/zwpQagHCI085?=
 =?us-ascii?Q?pZD6EBBwSkeOvgjWm2zFQsDRWMS8uqoOcLCaFiqBiM0MjNh2Mie8xa8+gruH?=
 =?us-ascii?Q?cyxBcAGaV1nzjKzltXG2HJ/mjKNA7u1TsSmblxItJ9jenR7heEAs2iJ1XegV?=
 =?us-ascii?Q?ps5Ss4Tulk3spYQ6SF+e2br14yJ2UWh2AiUmf0uuEf65w6fqKKx9eH745ffD?=
 =?us-ascii?Q?JOVjDKOFgCLhajepn/TIfN2K9V7DlZA4TtLXCdmB9GPfpfnEEg+RJ9R2PmQp?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e3e600-f7c4-49e4-d41c-08dc3820bed0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 05:47:27.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5uRJaZVGrwYlP2yodxTU5Z30KCLNzeru6rSZ6gEf4ngo4EN8O7cPxN4r5qs9WqiphRx0sbtWDFAz49mA9Z4qAlvK+23ngXk+pmV0Ld207A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Change the EINJ module to install a platform device/driver on module
> init and move the module init() and exit() functions to driver probe and
> remove. This change allows the EINJ module to load regardless of whether
> setting up EINJ succeeds, which allows dependent modules to still load
> (i.e. the CXL core).
> 
> Since EINJ may no longer be initialized when the module loads, any
> functions that are called from dependent/external modules should check
> the einj_initialized variable before calling any EINJ functions.

Is this statement true given that no debugfs files are registered when
einj_initialized() is false?

It would be nice to remove that from the functions and just rely on
debugfs files not being published for safety.

With that fixed up you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

