Return-Path: <linux-acpi+bounces-3800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D785E905
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 21:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E19B26325
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E08126F2F;
	Wed, 21 Feb 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5Qh/G5j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DC86641;
	Wed, 21 Feb 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547268; cv=fail; b=QfOHy9cO33J1mIeRq4qlfUCf/OeZWQWyLuVda5ApueS59hxlFp6IIT23EbDK0/tOa1ltjwPepUSbs7PVpkVbuIsl5ahOVXWkgd58Guv1xBWeUw9Ietc9+7WyamLawThq5Y4JvHHUBEHw1BVCsoDUcC+C4HD7WRLllQOwa/D+6Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547268; c=relaxed/simple;
	bh=L8g8oDwe2qLyHUJJbkBuliIgrTgEqIofhb5KukYnph8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fC8rhv5IaIqnFAsscsGKwkDIYLcJsJdgPrOz5Z3HRhTeEuXFCJwLFrIhPYvhP4eFx3fqJ68n62Iw9smj5V0ge2euF6va/6m7WHE3taEfLltUI3CpoK3CCAAtLH9Pho+4MxzaYryKfJpHZHV/C1uC3yZ4CLbdbSE+whgLh5mhA48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5Qh/G5j; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708547264; x=1740083264;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L8g8oDwe2qLyHUJJbkBuliIgrTgEqIofhb5KukYnph8=;
  b=Q5Qh/G5j2s7nQeojZ46Ofwps+JA+KYyjhi8VXm+k0rPcjLEYKed1Zh6s
   XufTGYrvWiGwjzAlKkEhktTVLgJvL0Kde5lAkquWwIU0DwSmRAvnHxTy+
   3WbpFwFgJXo6ovvxEkJvlkWbk1LJaGLCs9VfE9qKVvtyblfm6TEenubG/
   yJS5q9phnQt1/TScr9k3LBB8NLmbvLBXOI9rC0moL5aqNDjS2DNHze6wn
   pnexWWxGKiNqaDWUfCr3lrbIpnOq3O5Iehn0teAekvWpN7o8CRimp9tKp
   sVN+R4/twaafKYZx7pOz2cVPYxixWvd3s4eI428/aYWWR9q1gl3XCGbHd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20278673"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="20278673"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 12:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913366368"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913366368"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 12:27:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 12:27:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 12:27:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 12:27:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 12:27:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4pqDxTxpvZl7y5dJG9sRjbczHuBA449eXYsIUHHBqXQlLjwLs+qxA9cZ1kEtLJ07Dh1k7cnNGKoNW2BX28ELEZd+7rpQsYygfoXG/AHlc4TR4/uF2aQYX7sC841fIwJ0dOsojglIDBfYoF+5wc5JAuXpx1KxYthXD7cMPyMwT5u7CCdzjGxfKn0B4ongEKBl9Tip6BlKVa+seemUPtOZuXLUFOEvTJJZYk8df3ZYJoGoJWvJSdTf+/Oj2pbfLGdbefz+h5yKKL3DHZr763jraFjSXRVkogSXnHU8rFm5LHPPm+BoSBPurBjXBDgvaO0jJSyEte+89gSXR2DpUsmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uu8MnexPpXPy8Y71vJt7cTuUWfzjXfkYqcH8oKQjrM=;
 b=fv19mkEMQqFijO5zsm13ST7ShBRvkhdEkIoRwQX3TZUvuPd2IyWYsEsGHxpEMTvFUWW7AbrhrX4BfY72EHPXXMVO/bTpHkCU2R5LhlJCnlZVl6l4UmUQTpRGwuP1slSi2shZXOMPJD5Xm1Yt/7fAkMMYu2p/nFNUSKPl2yP1d79GzxGgwu6hunPnmrolaWkZiG0qnFnKIt3ODQWqUYVF0ajc5PrYqczE8uMA32vsaZcyxtCPmrbI/UEMjz7U+s7tTalCM0Ue3YVmO/Uwn5CkTzJsRTWvqdq/5qeR7Q4sL6UZBqIH+B+X1Tzjfqg/I4Tg8AGrrVoRWobiSglYGBGtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 20:27:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:27:35 +0000
Date: Wed, 21 Feb 2024 12:27:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 4/4] EINJ, Documentation: Update EINJ kernel doc
Message-ID: <65d65cb4cf949_5c76294db@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-5-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240220221146.399209-5-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: decc067e-d87d-48dc-64a8-08dc331b8a10
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBvuuH4M/iyAonSVrDrazH7ztXHPuaruNmZuegG2ZYuSs3ypEhqxKl5fmcxdB+7LUbbN1YkTlB3EtzAhcHplg5Fo9g2lLfRlZD3wC3lAEG7DbwtF7Az51bdcVYqKlIsWNw0XHvJu5OhnIOx/uMoKwQOvvYhgPgA7aXsfm5CQKdvoTX3Q2kf2mwGeMwivPmuyzEqoCJVQvOuMWAjFJf9zotZ+HqJqQn01J5JKAs78S10Tw5MxIN4Py9j9xSUIMWfd1D6ExcTjDHg3LHp0pUMUTkha/r0hqNdjuTCj4jTlNKgEThO1mPmJltFdJ6yULV0TFfdYLh2cspmTKgoet9TmShKc+XTXpXwcPnUVoVYarCP7/EEzkA8WiEWKejwyFSmlrYEePnHGmIYtkWgOZ3vnvF34/Ee/WgaGYOMxSelV939iwB7MkZ5Vn632qP76srZjoOz25TPwoMkjJQfUY/R6jNpt1aJWkxX9fMKE3GAut7G46aSgKXpMR/wZ+PXkPzS2kjRQDqzR8aLT9dbziKdJ6EuLNbO0T9bDcIRicnYswaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DQsAACzhuV1fUh9l6RQ5kD9g1EKdDaKJo4C348Wgwjxm7hpoODfE24ThAdtK?=
 =?us-ascii?Q?mFDI6oaYqy/n5/ltnLi8NbcquDzQPvLCCJ1vcCuUQSArsBPYPrZObOlYeOSA?=
 =?us-ascii?Q?33OvhWYKSwcACbGU8/XOvrVCc84xkf580ik8MYwjExbsv9Lp2SH9I043ca+W?=
 =?us-ascii?Q?j74LFjT8BQpRjQFw1DrhNC/jHabhmXImTHxcO8EH7gZ87SyhBjiozvPo2plf?=
 =?us-ascii?Q?iNWq9arn5FvYGjif13/g+V+tIen5Sm6p7X0GTE+gO+yYYS2H/caa51VW1GfH?=
 =?us-ascii?Q?+bY4aBkD6AS3de/slFmK9obnenqRFeGRMdFMlmcsMrekQbwDITConnFY5qry?=
 =?us-ascii?Q?DLrsMaVpX0gYEYneNDpk8kFAeg9KpDaPiGenlKNIrgrtzCHSxAghy62KXz8r?=
 =?us-ascii?Q?oJF/Psv8N5+C1VcWlCVxY3934P/47Ra+0u5xf8QBwqAXSGrkqdrqCxbivdL4?=
 =?us-ascii?Q?NAbOKYcfFJKiKsk01QJ8wf2RE7Zc3ElyHSAvUcCribkNvfxGG7W1x7RfNJqc?=
 =?us-ascii?Q?jpNYb6FFigjASq4CLs+FlfRVZj3ZCB6W64UuwSFTvoDxwOPvgNe4iks/lpyB?=
 =?us-ascii?Q?Z8hktB7nQHcATm4+1flzaxGQsEFz/yI42+Z54p85atMnkomDg3BWLhXdS2z/?=
 =?us-ascii?Q?wAbRMAcCOI7eFHAVuG8OHCDgGG1sni2W1h6ulomwgUUIz2Hp8k4ri4hM55gx?=
 =?us-ascii?Q?4tXQ4F/rewUmBiqRGX+xp8uPzH9u0+mVDHKd/0e3oDwPifYEHJxK2E2tczeu?=
 =?us-ascii?Q?6XYnY+dpAb2DM7lQ1W3H1cSsc6p8zmfhNsGDRNif8HBKpWWHMZEv3nW9GvFk?=
 =?us-ascii?Q?2fP0coft+hz8UCdoihd8EWFT1skGGhF21YeOQ44RE29Z4GO3Xh/PCwnVVf+C?=
 =?us-ascii?Q?R0TZPkwjeOzs3bL5trtQ8I1pqsQIkhcjs/9gD+d2gsSHBnwZriJhgeB9mjlx?=
 =?us-ascii?Q?hhcP09wpZhBjeF9V+LMTOXsMCzNGjzeR/6Andn8YQiC0kPawGshW0+4sDoIR?=
 =?us-ascii?Q?VqiA3kSqLYrX/F/6OJNf3DZrqjdq1rW3lMHGG8fRTFCt6X/Pw0LFNfGGLP2C?=
 =?us-ascii?Q?6Lfb7+IiuOZ++X/lOhYebx5V0SArU9FkALePNlEygRn4umXJPKNg3kqpn2Lx?=
 =?us-ascii?Q?955Q2WLzRPr1NoJD9RWe2kk9qP5Pshi7fOvNTJypzsxDiPSp+NKY9SWTUEGh?=
 =?us-ascii?Q?+Bkp4dOaXsr3XZFT0812H6RFKmTYIHw5pjFr7lcBtrE8YgH9Ify5bEKfVLiF?=
 =?us-ascii?Q?Qy4yK0Lpn/GNz6RkW2irJi2HteT6JeuxL1nZIZTqD3bXxBdm4t6URgmoSpBm?=
 =?us-ascii?Q?QKOUvI1XZAAR+F9mkNx0in8cJ8I7/y1jiZB8+6iw//agLvaE23jJkQfH7iF4?=
 =?us-ascii?Q?05kstuOYDaAVWOW8juiWiVZUkvSxpmlO4gfNC4dDEdi7TdWrtZjWcbbfqQgL?=
 =?us-ascii?Q?e+ayPDnVGTgM6DI/yeHqu3wGQLUWP+jSmZAuvK6XZuNMK6MEfYkie+e60TNO?=
 =?us-ascii?Q?CDv1CVwF+Q66khOmZK9YHEYzgOxsETxp4WpYfsGcOBP6iZ0gX6rOWQyVDdkw?=
 =?us-ascii?Q?UU6XwXoyTrLeulgjD8SvvsW8juQA0jY8USY80pFW0eGbExo/71keWvS8hMNb?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: decc067e-d87d-48dc-64a8-08dc331b8a10
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:27:35.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQpZDdcyCKMeskwCQ5EXwI08BoGQ80hLKosdjaPuaOEDD/qImoWPsFKN3oa3Ib6iaiYHNBZ4DPt2Xz/byICJlDFausFHScKvaePc/9zxsjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Update EINJ kernel document to include how to inject CXL protocol error
> types, build the kernel to include CXL error types, and give an example
> injection.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index d6b61d22f525..23741ec0de75 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -181,6 +181,27 @@ You should see something like this in dmesg::
>    [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
>    [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
>  
> +CXL error types are supported from ACPI 6.5 onwards (given a CXL port
> +is present). These error types are not available in the legacy interface
> +at /sys/kernel/debug/apei/einj, and are instead at /sys/kernel/debug/cxl/.
> +There is a file under debug/cxl called "einj_type" that is analogous to
> +available_error_type under debug/cxl. There is also a "einj_inject" file
> +in each $dport_dev directory under debug/cxl that will inject a given error
> +into the dport represented by $dport_dev.

Follow the style of the current document and document the files in a
section following this one:

---
The EINJ user interface is in <debugfs mount point>/apei/einj.

The following files belong to it:
---

> +
> +For example, to inject a CXL.mem protocol correctable error into
> +$dport_dev=pci0000:0c::
> +
> +    # cd /sys/kernel/debug/cxl/
> +    # cat einj_type                 # See which error can be injected
> +	0x00008000  CXL.mem Protocol Correctable
> +	0x00010000  CXL.mem Protocol Uncorrectable non-fatal
> +	0x00020000  CXL.mem Protocol Uncorrectable fatal
> +    # cd 0000:e0:01.1               # Navigate to dport to inject into
> +    # echo 0x8000 > einj_inject     # Inject error
> +
> +To use CXL error types, ``CONFIG_ACPI_APEI_CXL_EINJ`` will need to be enabled.

Config symbols are already communicated in this list:

---
To use EINJ, make sure the following are options enabled in your kernel
configuration::

  CONFIG_DEBUG_FS
  CONFIG_ACPI_APEI
  CONFIG_ACPI_APEI_EINJ
---

...so just add something like:

---
diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/e>
index d6b61d22f525..3bfd86f50c61 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -32,6 +32,10 @@ configuration::
   CONFIG_ACPI_APEI
   CONFIG_ACPI_APEI_EINJ
 
+...and optionally to enable CXL protocol error injection set:
+
+  CONFIG_ACPI_APEI_EINJ_CXL
+
 The EINJ user interface is in <debugfs mount point>/apei/einj.
 
 The following files belong to it:
---

...just to make it look like the document was written by a single
author.

