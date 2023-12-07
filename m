Return-Path: <linux-acpi+bounces-2212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F080973E
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 01:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C897C1C20B91
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276D185E
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMlR9cqv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7231710;
	Thu,  7 Dec 2023 15:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701990876; x=1733526876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8njrY1o7amBvNg3sgF/L03+9tnSDuUenrBSOAwhTfvs=;
  b=ZMlR9cqv5KVAyJlVbczWLaZRLzYnaZU498H6e8NkqliusTxn5pXgdQKh
   uHePTFswA478f9DBFP0HzfzqRlSV/wpO0NuG0hZS5EPNhSkXR6iMjxBil
   kU0Df4+DzNIaQIpE/KZxjZwgOEciX9SPvNm+YPA4R6XNHXRMaRxwlbPjc
   zoBUXSJFty0A/d3xsxwyEtuaC+oss6TrlKqVX2gP0b2DXvcF5J5j70VTL
   nq5HbPEOTpmN3BeFLYpCi5P+FqtoRds2Vl2yDtWqXSiOJga+XTMAJj6HJ
   uvpW4oAtFBVljOCktMOtvcUu79LoWCBoqYngDs/tFOFTlLQtGs7v0wcq+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1403062"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1403062"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862659936"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="862659936"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 15:14:10 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:14:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:14:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 15:14:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 15:14:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwdrghICuLOflZlJPALjjAlyycn/8qbcodK2Pkh0g2P95GDJ28rvNQPhIIe9CenkefxCQB7MNezOhH0Fcl9hwMhp3W8zectj+rhwl2ML5QYm3nk/ntPhStqucEAWmpM2FwbUPX913a18CTX9qup1kZARaqYKgFR/UY5IS3988/gtkpESoPlMfiCMxLXjISONRyDn3Y26pPmR1XhVqgk6nlXY5iucZ/f1NXQoq5xp7KZapLqGBhI2qSN55BJc/nkizOAwdim6LUCFfh01KS9EPyVQNlWZwfhS19f6Q7DVrTFY0L7HXIzTxqAXK0lfrHhnTH4VYEgtLAOliHveCDSrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tux5lN3tHs4+zjhgbbrkiYIqpiAHHzVP9f3qdkxJ4s4=;
 b=DyTI5aRkq6q1ZmKbrslsyd6gF8GRmeclfJmUx0o3TOjYpqTTQFjojxs01Uf0y8XosyliBAUMyYkvl6ofqMWkWSoJY9eBgQ5HwkGMVtQgWTnEF/Cyl/yswd7eEavlCo+DDVLJwJQHUpDgBfZ1H9AR5MRIIfZ9e0YhPKc8n36Sh4Na5J3L3ymbvaCDBdrDzqM7cggwQ0OvgaCWteqAQZVqKjhSr9e8v6D1KY0exi6CNER+W5xpOL72tB537DXJmZ607xVWbfZMelhCxGwaCatNfYePSXR4mDVTMcy1NpPA43wQsNifX0JeYkdA2xZ0lwi9/4GRs2h9M7MuheCjgYC92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7028.namprd11.prod.outlook.com (2603:10b6:510:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 23:14:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 23:14:00 +0000
Date: Thu, 7 Dec 2023 15:13:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v7 1/5] cxl/port: Add EINJ debugfs files and callback
 support
Message-ID: <657251b0517bc_45e0129418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128160656.166609-2-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 07097b5c-4029-44d2-5467-08dbf77a31f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p90OE/jUWLldhQh2n4o7dMwgbd0nVAtr2jVAwd9yCxEZWxnoI8PcZM3a4YaXA+6zUiLth+j7THsYN8uAYpV7kUUfNH64k5ntUM9NnXPTr4wDiew7qFLAGtamirS1T/zybdQ39pePJBuuWtDeK4dzoBAOls3IS6hJnsS3SyY+XB7osm8qWdggs1rHHS+PXNTzYR2uVZL+9PZvRDHQtczlxfV876E3u1b42qWL6EgR89GniRzfcaUp7WZpO6rP7JhxCPbtufw5ylaF46PxqmrQhWj67UZRN+/ATlEIIU2AOXw0oPlVAzTQKdmsW3LiB2bGCzasY5K5wy4brdKlBZX9Gai9wQ5F1rmlh1IqKqP70cghAelW+c1++lJTIhh/tL+pEyD7d0iKE1gjqRFJYvDsx9XmdbaMINXQec1hR/OLyRiW8hWi2GYDFIs0WNvH/QdDq1GcuvsK/4CvYTZ4+s/236/dqmz7yp5vO/IcuNZMB43RqbG7Ep8eD2D9AarnbRmvwL7v8wWOtgUENNNYIdNE8MBl8eVH1urh9bAfHBXezu8bSe6kGM501q0L/TR6oDhr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(4326008)(8936002)(8676002)(82960400001)(86362001)(6666004)(316002)(66476007)(66556008)(66946007)(6486002)(9686003)(5660300002)(6506007)(6512007)(2906002)(478600001)(83380400001)(41300700001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mlt+aLwMJLzRe2x+l1M7tgmoJVnrKY8RgbuOWYv7oYnMK+iS+qne48FRpRmT?=
 =?us-ascii?Q?maKlfPm4Y3ble5gj0RuVo4m6LENYWDtrhdqHo2tR565YQ6rWiYE8mbUVpfEm?=
 =?us-ascii?Q?qCms7meu17hdehLq28OpdB+zq/DFjMGEAH1rh4SgFxufXl5EtVa4juB7hV+q?=
 =?us-ascii?Q?WSHY+0WIeWTI6TxM/6pWX2tU/DDgc96fkRsT8frUAUPPQEuEzkCLrJuSxL9M?=
 =?us-ascii?Q?Y9bwwzhYZw6mNewmqibUwKIpdCfT6H5n1MrOM296lINTCQHky1Jr5J2QPW1M?=
 =?us-ascii?Q?QJ2mXolxJiwIHZ+70q8UdVsVMiplQ/S2Lt1ugcBoNS4hFI+r6hEyJ1I1GL3T?=
 =?us-ascii?Q?DR3SkC9si5UHcL7es5IGysV4gOAm0f2OSGR75p3jvL1MefRQXvNo+PztP0XZ?=
 =?us-ascii?Q?q8EU9N8fpQiw7fABEueYnlZVlnCDOc2RIDXWhGeN+ZgiAKdGIY1hKu/WPPTv?=
 =?us-ascii?Q?SRPFu0jGX4AhGnL3DjN4UKMHukaMGNpfMTjDTVfM+2DjGFp5uiFWl0/uZTh3?=
 =?us-ascii?Q?gHLmMiLXaxDBBS+PkS6SK1Y6D9Omv0FD7+dYfV+dpOZr49L8VJ3qC1tVXXGZ?=
 =?us-ascii?Q?+yBg6YnrDQEkSKugNo/5yo4Uln48MKtG1QtdPEsybM44Qlem7zRv8T33oYKe?=
 =?us-ascii?Q?bqycNxtxEOywignXHee58u1OFQk1/8LPfx4LhpYJK5vL0lWVxQsKnq9zIWCx?=
 =?us-ascii?Q?1DZFVeL0XgZ7XbQXl3Pba9LNuCvRWdOjOFU3UecxwjFhNGXodbwNlyA7BFEb?=
 =?us-ascii?Q?qlJQomU20zpH+mgyhVJHWTCHxNkj23gOshHAUMw7xj7Vn1laDdMHHQPRwa2O?=
 =?us-ascii?Q?Sh0hZhC2k9eypUlJOKBIsdBq+QqHLoO+Ee+w1sL9xhnJqv05OH+suU90shQU?=
 =?us-ascii?Q?0k6mH7ndojzUknicslDWTH4fjq8UFycCE3ylECk9Gw7be8kp5pf1k6LuWiyP?=
 =?us-ascii?Q?f2bGYvm+nk7bApLe2avYxkNwCgEgJSgNDOnhA+XLG6dYGuceO5vE6uLi1Znm?=
 =?us-ascii?Q?gBu9x9hoXHzSiLb1tnAv1fP4RXenrCoQ/9VX9dscNi6wn75lBiT20vMOGjOV?=
 =?us-ascii?Q?/MoOigVYX8VNUN3V62HBKV+/pV/Pcf6BLMHYPEt1t1yR+zO+AuE8jgybEy8S?=
 =?us-ascii?Q?YgGOSrZZ+FX4d40QtCKbv5nlLEO5ym/K8vRJxHQz0BVHqNdGLLN4mi13BnmO?=
 =?us-ascii?Q?vY6am+K0CF8NcnOF9c5/VmMdNRmKkXodHwrc4/P/C06dvb4NSxgejbcWIU5y?=
 =?us-ascii?Q?pULmRh3t8ThKvLcuBDWtKh58V0hU+I1whBCmAb4+EDJ/facJ/pVzoZBkZSWm?=
 =?us-ascii?Q?ErmVRR4kvbYwl9fj7rjkUeuCZFFq67OEc2ElNw8pPJ3FsAvlNtb8LshBaySV?=
 =?us-ascii?Q?S90ATlK2OpiXui4Rv/4EYd3fQ1mCCc/YB62UjEEEHXBKFEb2H43ORXfAoUjO?=
 =?us-ascii?Q?uHhzGMapssOfEGTu+yOQhAc8PqoI2KfXIVYkH1g7YV1ujqao9o4v/8lCv7Qh?=
 =?us-ascii?Q?lyeGjX3m5A5F7kD/V/2XpYk7OE9f5aDnw9LM+FRy58jTw+ewAsjUWgcffT74?=
 =?us-ascii?Q?IKJmX+/VkkGQfDzER+X2aKz0fUSYuN72H6IyX/zA3PoXfy0cd4/7R4ATXAxA?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07097b5c-4029-44d2-5467-08dbf77a31f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:14:00.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT6lICmPpZz1+oumcJlXwkuvfHRP9srAGTtM5uwknAv38CULDwUBNJwVGuxSoJFAAd0lDAUflRBuuppgdmDM0KGBuNBMMSkktBcbHRdT6KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7028
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Add creation of debugfs directories for ports and dports under
> /sys/kernel/debug/cxl when EINJ support is enabled. The dport
> directories will contain files for injecting CXL protocol errors.
> These files are only usable once the EINJ module has loaded and
> registered callback functions with the CXL core module, before that
> occurs (or if the EINJ module isn't loaded) the files will do nothing
> and return an ENODEV error.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl | 27 +++++++++
>  drivers/cxl/core/port.c               | 84 +++++++++++++++++++++++++++
>  drivers/cxl/cxl.h                     | 10 ++++
>  3 files changed, 121 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index fe61d372e3fa..782a1bb78884 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -33,3 +33,30 @@ Description:
>  		device cannot clear poison from the address, -ENXIO is returned.
>  		The clear_poison attribute is only visible for devices
>  		supporting the capability.
> +
> +What:		/sys/kernel/debug/cxl/portX/dportY/einj_types

Given this file is identical contents for all dports it only needs to
exist in one common location

/sys/kernel/debug/cxl/einj_types


> +Date:		November, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Prints the CXL protocol error types made available by
> +		the platform in the format "0x<error number>	<error type>".
> +		The <error number> can be written to einj_inject to inject
> +		<error type> into dportY. This file is only visible if
> +		CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
> +		be able to reach one (or both) of the CXL_ACPI or CXL_PORT
> +		modules to be functional.

This can be simplified. Have something like:

config CXL_EINJ
	default CXL_BUS
	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
	...

Then the documentation moves to Kconfig for how to enable this and the
CXL code can directly call into the EINJ module without worry.

It would of course need stubs like these in a shared header:

#ifdef CONFIG_CXL_EINJ
int cxl_einj_available_error_type(struct seq_file *m, void *v);
int cxl_einj_inject_error(struct cxl_dport *dport, u64 type);
#else
static inline int cxl_einj_available_error_type(struct seq_file *m, void *v)
{
	return -ENXIO;
}

int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
{
	return -ENXIO;
}
#endif

> +
> +What:		/sys/kernel/debug/cxl/portX/dportY/einj_inject

See my comments on cxl_debugfs_create_dport_dir() later on, but I think
the "portX" directory can be eliminated.

> +Date:		November, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Writing an integer to this file injects the corresponding
> +		CXL protocol error into dportY (integer to type mapping is
> +		available by reading from einj_types). If the dport was
> +		enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> +		a CXL 2.0 error is injected. This file is only visible if
> +		CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
> +		be able to reach one (or both) of the CXL_ACPI or CXL_PORT
> +		modules to be functional.

Similar comments about dropping these details that can just be solved in
Kconfig.

This is next comment is on EINJ ABI, but you can skip it just to
maintain momentum with the status quo. Why require the user to do the
string to integer conversion? Seems like a small matter of programming
to allow:

echo "CXL.cache Protocol Correctable" > einj_inject

...to do the right thing. That probably makes scripts more readable as
well.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 38441634e4c6..acf10415a174 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -783,6 +783,72 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	return rc;
>  }
>  
> +static struct cxl_einj_ops einj_ops;
> +void cxl_einj_set_ops_cbs(struct cxl_einj_ops *ops)
> +{
> +	if (!IS_REACHABLE(CONFIG_ACPI_APEI_EINJ) || !ops)
> +		return;
> +
> +	einj_ops = *ops;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_einj_set_ops_cbs, CXL);

einj_ops goes away when the CXL code can just call the EINJ module
directly.

> +
> +static int cxl_einj_type_show(struct seq_file *f, void *data)
> +{
> +	if (!einj_ops.einj_type)
> +		return -ENODEV;
> +
> +	return einj_ops.einj_type(f, data);
> +}
> +
> +static int cxl_einj_inject(void *data, u64 type)
> +{
> +	struct cxl_dport *dport = data;
> +
> +	if (!einj_ops.einj_inject)
> +		return -ENODEV;
> +
> +	return einj_ops.einj_inject(dport, type);
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");

The wrappers go away and DEFINE_DEBUGFS_ATTRIBUTE() can reference the
EINJ symbols directly.

> +
> +static int cxl_debugfs_create_dport_dir(struct dentry *port_dir,
> +						   struct cxl_dport *dport)
> +{
> +	struct dentry *dir;
> +	char dir_name[32];
> +
> +	snprintf(dir_name, 31, "dport%d", dport->port_id);

How about dev_name(dport->dport_dev) rather than the dynamic name?

The other benefit of this is that the dport_dev names are unique, so you
can move the einj_inject file to:

/sys/kernel/debug/cxl/$dport_dev/einj_inject

> +	dir = debugfs_create_dir(dir_name, port_dir);
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);
> +
> +	debugfs_create_devm_seqfile(dport->dport_dev, "einj_types", dir,
> +				    cxl_einj_type_show);

Per above, move this to be a top-level file.

> +
> +	debugfs_create_file("einj_inject", 0200, dir, dport,
> +			    &cxl_einj_inject_fops);
> +	return 0;

debugfs is good about failing gracefully when pre-requisites are not
present. This is why none of the debugfs creation helpers have return
codes because failing to setup debugfs is never fatal.

In other words, it is ok to take the output of debugfs_create_dir()
without checking, and this function should not be returning an error.

> +}
> +
> +static struct dentry *cxl_debugfs_create_port_dir(struct cxl_port *port)
> +{
> +	const char *dir_name = dev_name(&port->dev);
> +	struct dentry *dir;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ))
> +		return ERR_PTR(-ENODEV);
> +
> +	dir = cxl_debugfs_create_dir(dir_name);
> +	if (IS_ERR(dir)) {
> +		dev_dbg(&port->dev, "Failed to create port debugfs dir: %ld\n",
> +			PTR_ERR(dir));
> +		return dir;
> +	}
> +
> +	return dir;
> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport_dev,
>  					    resource_size_t component_reg_phys,
> @@ -861,6 +927,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  				   struct cxl_dport *parent_dport)
>  {
>  	struct cxl_port *port, *parent_port;
> +	struct dentry *dir;
>  
>  	port = __devm_cxl_add_port(host, uport_dev, component_reg_phys,
>  				   parent_dport);
> @@ -878,6 +945,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  			parent_port ? " to " : "",
>  			parent_port ? dev_name(&parent_port->dev) : "",
>  			parent_port ? "" : " (root port)");
> +
> +		dir = cxl_debugfs_create_port_dir(port);
> +		if (!IS_ERR(dir))
> +			port->debug_dir = dir;
>  	}
>  
>  	return port;
> @@ -1127,6 +1198,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  				     resource_size_t component_reg_phys)
>  {
>  	struct cxl_dport *dport;
> +	int rc;
>  
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>  				     component_reg_phys, CXL_RESOURCE_NONE);
> @@ -1136,6 +1208,11 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	} else {
>  		dev_dbg(dport_dev, "dport added to %s\n",
>  			dev_name(&port->dev));
> +
> +		rc = cxl_debugfs_create_dport_dir(port->debug_dir, dport);
> +		if (rc)
> +			dev_dbg(dport_dev,
> +				"Failed to create dport debugfs dir: %d\n", rc);

Drop the debug messages about failing to setup debugfs. This follows the
lead of other debugfs setup in CXL.

>  	}
>  
>  	return dport;
> @@ -1156,6 +1233,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 resource_size_t rcrb)
>  {
>  	struct cxl_dport *dport;
> +	int rc;
>  
>  	if (rcrb == CXL_RESOURCE_NONE) {
>  		dev_dbg(&port->dev, "failed to add RCH dport, missing RCRB\n");
> @@ -1170,6 +1248,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  	} else {
>  		dev_dbg(dport_dev, "RCH dport added to %s\n",
>  			dev_name(&port->dev));
> +
> +		rc = cxl_debugfs_create_dport_dir(port->debug_dir, dport);
> +		if (rc)
> +			dev_dbg(dport_dev,
> +				"Failed to create rch dport debugfs dir: %d\n",
> +				rc);
>  	}
>  
>  	return dport;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 687043ece101..3c7744fc3106 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -590,6 +590,7 @@ struct cxl_dax_region {
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
> + * @debug_dir: dentry for port in cxl debugfs (optional)
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -612,6 +613,7 @@ struct cxl_port {
>  		size_t length;
>  	} cdat;
>  	bool cdat_available;
> +	struct dentry *debug_dir;

Part of why I asked for the debugfs file rename was to eliminate this
wart on the data structure.

>  };
>  
>  static inline struct cxl_dport *
> @@ -813,6 +815,14 @@ bool is_cxl_nvdimm_bridge(struct device *dev);
>  int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
>  
> +struct cxl_einj_ops {
> +	int (*einj_type)(struct seq_file *f, void *data);
> +	int (*einj_inject)(struct cxl_dport *dport, u64 type);
> +};
> +
> +void cxl_einj_set_ops_cbs(struct cxl_einj_ops *ops);
> +
> +
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);
>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
> -- 
> 2.34.1
> 
> 




