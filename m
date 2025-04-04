Return-Path: <linux-acpi+bounces-12752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9541A7BEC0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D4B179C74
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0321F1519;
	Fri,  4 Apr 2025 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwfZdxFs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19F1EB191;
	Fri,  4 Apr 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775889; cv=fail; b=GwHTeq0dM3hhlZL9hChlBKbjgkXbzUtFGK9WbwuKHwSLsV2npCOTcUxqbQbJbhGnB+uI9WlhYPNOBBnRIvyyj5nLHuAxRsJB1Vvw1Q3anAtNcIQ8byCJZ0dS3K+wttuRhGZT79eOAL2UNlYzhmUB1rV7yQ8DTAYdtihSQDnr/x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775889; c=relaxed/simple;
	bh=yZrXIULEuPA3K3j1eXXh2/5kwpifsFHBvCrcV2MYcJM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OlgnvYNIyw7ymqSfzX5BqMPZ+63tg6QwOVI3zLmtL+2Hw+LTEM91EVyxMIsSX+wdxyAoqrsvgjuswhHMKrVXbBVl4Ql0Io/CLNOlQqcK7DwqHFTwpV1ppk3sGRhJGuE0OiG9XkLc+j+z0wGVW8NjXo9YrAvfLVLbZ4XlzMqtE3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwfZdxFs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743775888; x=1775311888;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=yZrXIULEuPA3K3j1eXXh2/5kwpifsFHBvCrcV2MYcJM=;
  b=GwfZdxFswJTEeb7rVB8v5rPBMobkZatP3YJ1Hn1ei65HT2Jh6ukM1vwV
   p2F+8aBL1rUtdh5Hx2EgNW+C9fGAYLHdle2CT+9h6ZJGOglJNfXOs3F3U
   9rBqQ8ZkOAFK4UcMKb290Y00RFFRNTQM38tFXqv9FFkNSvpD8MyxrycpE
   nlfrLH8rPn0gBE9HHh+4bIiiX4TqScIVzg4xAZDJzmcFT7sctnWiFPIwT
   9lkTCx40j1W5ltte4qDoMAH3lR6RNYCfp52AiZEwTlJf/emKwP5Y+PCZk
   Wvk+RmJCfG3zqxvtQeLKK+2sfsQox3W3KYnz1ZfoS//x52a+jFtkalylM
   A==;
X-CSE-ConnectionGUID: z/SqJf+6Rae3rVhDSCbAcQ==
X-CSE-MsgGUID: Q7llxc6cTza5GUSgt+dSkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="45124083"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="45124083"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:11:27 -0700
X-CSE-ConnectionGUID: 2nv+8XwcRYyI/dAe4jR4EA==
X-CSE-MsgGUID: WB75C0wqRl6AzSwtyVCf6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127078687"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2025 07:11:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Apr 2025 07:11:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 07:11:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 07:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nobjuR4VZ8AaHlRJPXPgQ7In7L+m3LXrgDpFCz5uBQc+vulKus63ghW6KrBps5Igefz2y2w15xt5BKvYh711T8iMkCGa19lQsinBagT19Knb5ZtJDJWjV/CNwCatjWj4A2FO0keAU6xgL9FS6vJ5gmhIKbPFP5GGIa766WiMJi3j064BuvH0vAGI8mco4Ffxvs4I1Shzd07iGLUicgsmtBtkTxzQ4xM0MMnxwWKcZHGMQivcCOGxFle9gaCK/wW46zaK0VR+CZC4vm/2JrW+z5pefWw0SHyXwsdKpsx9JptkzyT+zU/z9rspiomWsfom7wzgR/WAh+KNj5uICm6DHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1opCS0wOOqwn4fPmMdGU4uLHuo77+3plk6H97ECkU5Q=;
 b=o2kKO2Dt9D2RMOea8eIfNwU9qCVc4770W+7Exb0+vzUzY/DjKDzE3IEaueBqQDTEavWRyalo49ULV/GzVkimRvKN+m24DAuj0dum+NWPvo2Mx6XCp+/mErREAr+B1GHzPJeWaKI/rL29eiHVSVFxNnLFUPnlJFh1sag8tbMaNtF45f1nrmsTotFjz06mNGWjJywlrP9fd53a72AyyGSyCih2zBFlKp19YevNFDDaL4rOUrVdZDn1pfI2ChIgCXGeVg0eJ4KYELbII4tglnq2J6iUuM5j+YeNMgPrOiKhLmb3TBdQULsc3huFpI+8mEYMFrOfT/5/Br4XU830LPvZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 14:11:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.052; Fri, 4 Apr 2025
 14:11:18 +0000
Date: Fri, 4 Apr 2025 09:11:40 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <robert.moore@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 4/9] ACPI: APEI: EINJ: Remove redundant calls to
 einj_get_available_error_type
Message-ID: <67efe89ca38ac_9807c29472@iweiny-mobl.notmuch>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
 <20250403231339.23708-5-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403231339.23708-5-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: fec0ae8c-9998-4877-d31b-08dd738291b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LDff5il2LdoEn8fBwjF8YrXwBXMgU+1CegQEcRvrYRMiiLDOi166rCLX/uTm?=
 =?us-ascii?Q?dJVccmcKAE2k3A2gqnnYxyZXh4kZrs1HbJ8iTJDr9xN4ADWtGDnA9ASBA+0U?=
 =?us-ascii?Q?4MpLYa2HNRA7faXbLiHxKYqomm4Dq3B4v5x9VU3BIduFtH5/XaN0AiTIWS9D?=
 =?us-ascii?Q?J25ypKJMXcPUzjq1IPYUak7n3WgvUBpOlATFVfeHaXetYPSMcvd+j0hKAfEs?=
 =?us-ascii?Q?qIuYVkIwfz5pQv96Nk48FA92uP2Ri31dI7XsFtpl8kqcJ5txT+NEBgI4JNum?=
 =?us-ascii?Q?VxAMUAvlD6ycvU4oipWy1HevFWk25DRvKXFH/gP++o+8I7Z4PqlFDSWWBPV9?=
 =?us-ascii?Q?1iQKl3hAMfpTX9byhfs39zeNVtIZ99S+A1dAndR/NJ9zt8PjyFipgyX63O7c?=
 =?us-ascii?Q?R6XPcSio4xTTPrbyaocr0vSoCKwW51MhmuGyZPXTqupqHXMqZq10Ds2/i0By?=
 =?us-ascii?Q?P0CFg+94eRIa4klxWArZKfsgfVHJBnTMlS+LhaYC1SAxvM5nBqUsVqEbiLQd?=
 =?us-ascii?Q?WzLfMhBHoT+U0/01yvFBhaNQqSRiu5jFa8QbeIALAHjzGoDcm/cTIO/l4w1Q?=
 =?us-ascii?Q?jAh0vRfvtVPv1oz3cvVLN57b4yDSxKISf/2f2i82Q6WxWtvPU8hqkeaUZZc4?=
 =?us-ascii?Q?m4JrRWTPi5Z+Qmy7xjudxQk6F9flFy4LdljVMvFoVcRt5CTrx8BaTXDax108?=
 =?us-ascii?Q?8N7PMEE8dOVXax5BKjh5kp/kbIJyYo5waPCfBM1QUVfTWuR347qaaq/VQ5pU?=
 =?us-ascii?Q?7BAtwx9mP+2tjDO2ETVdXfYwU9wVqNa22b18xGKmRqAdKn1jgBN2LoqnVhtT?=
 =?us-ascii?Q?rgdqG8SuFe2p/OY4XWu+zgzrSJXE96Loh0Oy6wfmGY7kGorpcV/lsgsLm6i9?=
 =?us-ascii?Q?5P7/oBUsY4l+xFTWvpQcCD4TMj+W9L7uHLD66nVuKAmj+shgRC9KdxUC9a3R?=
 =?us-ascii?Q?J8OWmdb9xDYGPnRMaWluppHqXKpr0Nu4E9tSgz2/WMjdwynDu1v1ZkdF6OYs?=
 =?us-ascii?Q?Q3V0c6TgwQX6ID0baowzI75Y820CURM3RttHDcJKeJmUHXb61Jt/LCw4uz6k?=
 =?us-ascii?Q?Ad2+5fnJQlgvVSPYG1pwaB5WhWTXFKxr6InkepuQPcnHOYc8/uYDLkVEg0Rk?=
 =?us-ascii?Q?5M6F30RQwkYIxghr6+a7VAbUzyePsIe18iyqfBon7o0mdaHcOvv+a1+r4DPr?=
 =?us-ascii?Q?uxU4+6bEQoLmhCQAqN5Xd4AbuEo/Bg+olM+A26U074nwymEoteNxvltLiV2e?=
 =?us-ascii?Q?6xNAE5tTy42E8bKuedj4UOHeAc+mvuEMzw02ooVuZ7Q6iW2NIX1/H4k4R+9f?=
 =?us-ascii?Q?62x5dZxMln8o7L1rlwsjAMtWkiWL3I453l4b0V1N4v63O0VV1zgJba81GUA7?=
 =?us-ascii?Q?9cr4G5JWQFEXWMrRr/gPx8SA8VyKUAAAdcbdhNb1RFVfw37+qZ0maTQ4OLLV?=
 =?us-ascii?Q?mVZ6x01pArE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjDLUoPDEynBNgxUDfYrptS01NLjcSiLs6gWbLFADIfADCTb0TMc9EKQuEK8?=
 =?us-ascii?Q?8QEYgZ6re3/o0v/KO5/p72C4AYdd1fDGnW2GwZX2aH4m5qjKrMKallYBjERG?=
 =?us-ascii?Q?T4igqsesmaZgpbM/xgyOhHWLzli1ZH7rCcnCfWR0oUGTaLQZ3Pd3Eq3iqE9+?=
 =?us-ascii?Q?3Q6E+k3FUtVLLOu6EZhY5BoNqHRF/GtlILmmKkq3GiihdPljMWYHO1iih82b?=
 =?us-ascii?Q?hf6cSOI9FuO7JqLhahZGvfW5jegJFdxtQooGnLzqlCxbj5y92FYUVvte6qFx?=
 =?us-ascii?Q?XknlTCDkAJX4IbGuzTIT7lGJaEY7hz5MiOCWCG7j2VmcDj6LLXX3tYT6NnNW?=
 =?us-ascii?Q?lKUTTQql5r57cQ1BDEnnkTSVbS9Ih9mcQ/PH5hQ1Gy9R8i8UsuyrPp1kLOY3?=
 =?us-ascii?Q?Doplho7goZ/S0Pi0GtnVUdUtRS01hTpFUW+ieSDltEB5xyqgfRPQtdigwGHZ?=
 =?us-ascii?Q?szuDskDQHhNwVR3QEBQE7ug6HGqWqf5zZHEmyZEtjDm8hXzGBFqlr9+G0S9L?=
 =?us-ascii?Q?f3UvUL5dQ/qYYQ54Zf22aRtwwFUM1oNa8p/BhO0Ojpafbuj5wAoUMquA68Ra?=
 =?us-ascii?Q?/q6l3uQRzDVTovg2cJjj70+1cVHiCOeFCi3n+9LyjJJ9uW8L1XsPdSL2UaCf?=
 =?us-ascii?Q?kmqvE2jlGFJ66W3vHL7wk2b10behy0RiDenThc/209LJLgi/5Gi2ky9vl7n9?=
 =?us-ascii?Q?0PaV5fNIHjhqumK80XwLaQqmnA8NW/VPxXAdU5RwS+KzNeCrmBnDs5c9GeyQ?=
 =?us-ascii?Q?o/EcxVgbn1nSxmdpIqPGFwXazqN6rwNoQhBJDFBqDcZcNNE/n4sf9VufGElJ?=
 =?us-ascii?Q?3duWyUDUhyJfnrO1oV+RQ1TmmyYVdPHY4pgJJltm9VsNtGWIH4wd3A+JwM7S?=
 =?us-ascii?Q?+A0dYuL5a042NeALJM8wHuCEdCWOw3B1iH6naljbHTk26TEk0OLKD0wgXTAk?=
 =?us-ascii?Q?GTTcm1cbmmFtkkxQqsuTHtteC6rkm2S4hTz4oYqZ9atC21L+ZRWueOnsdjbH?=
 =?us-ascii?Q?8El/POPqh3hvzbmlTI5uy5SuJwFDfq9JQqk1lN99LLKYAIF1X4U5FVztou2f?=
 =?us-ascii?Q?F1Y+H7YAiRrImRHvjDF0hyVxQMbgMEvM4jYtdEYlfvKCfTYde1jC96I/QodW?=
 =?us-ascii?Q?Ii31Y/vNQ81bOLyVaQW4Gt6rUi/wg+M/L+OfhySxJhWMs/4QjvZCUjW345Dv?=
 =?us-ascii?Q?GX0PQucoACAr8x80JBmCK6rcpATKenAp2rPJYAyyL+mJ/0Kcho2SbYaBVf+E?=
 =?us-ascii?Q?EzdqbuCjAggQJJGaBOLyNqsf23bUE8Iv1+28ruJserzFWOVzhQXkYFCy3JC+?=
 =?us-ascii?Q?9pT4SFmzC6lqTxlYAkEo9bDq/71Lw8Hjwhvs8jK+lRBnypHdYoZzjGKdOxSt?=
 =?us-ascii?Q?5DizLlsgHRqR/mzOoiBZnCBLT30ncmpxvDvgecSwdFVHKIAJCPq/5ehubVSQ?=
 =?us-ascii?Q?ueqsBIDHEclcNSJaWyhN1yhq/p65KT3Sye5JScVfkXJROSY7eLx3H/QkWL/T?=
 =?us-ascii?Q?k8mFVPwzcE0cfBXqU2cGQhC5e8Po984IbbZj3ZuGPHN75k6T9lCQpNSA/ExY?=
 =?us-ascii?Q?qeS4ySz5y8LMZFG4coR+u1CT1NC0OI+vwpfx16rN0YMDq1/Pf7ZQ7Qw2e2Zy?=
 =?us-ascii?Q?0eJgJ7Z+1NP17R4ZeANL6c+QUGI+cCry2NuhbJdJNUu2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fec0ae8c-9998-4877-d31b-08dd738291b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 14:11:18.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyUBcRLsX8hddf3sQaHanj8s4Up0uQWY9GQFdnrBWYEfv96Y1TahUp6WkHsoE/mGL5T3MFIfD+YvP4cIkdCAdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> A single call to einj_get_available_error_type in init function is
> sufficient to save the return value in a global variable to be used
> later in various places in the code. This commit does not introduce
> any functional changes, but only removing unnecessary redundant
> function calls.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

