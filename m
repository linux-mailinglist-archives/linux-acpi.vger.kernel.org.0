Return-Path: <linux-acpi+bounces-170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA37AF76D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 02:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 02EE3280ED1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BB15C0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 00:31:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B3374E1
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 22:53:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64A18579;
	Tue, 26 Sep 2023 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695768823; x=1727304823;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i8uKqjgwqcwS7dTrgXIokq3WcpNQEMHqIDXNAhdVnc8=;
  b=MAqKWFQzuyuuS0+NGOw5K6YNjMT6WEj750FW8uoYyU/ZIuR6rmB+MOHR
   Oh1sg6Nb9UzY6QevGs4GQZNiGqc0hGb1pD+U3Vh5xwUaIKIrbG/x929Em
   mI0B36fOUNax2+b9Ii3Te5opMnTwTxLO02ZMVibS++caoe0uFeLsTGW/J
   hWcFw41/tXxnMkgDxlPZcStYDH6JG8E099seX/V5XBdgbdqLCXMOgh12E
   rjYvaCimmfyiGNT5oixH77o0ACVIzipeloLDUxeh3/PANNprBgWFQSIS6
   m623G3Az/Efd9v0RYQnY7XTVrCgzHC1KdDQUIx1C4I5yDPaRZiqNy1+A1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384450684"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="384450684"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="295019"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:15:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:15:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:15:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:15:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kusStPMqbID82+Fdw4RIRwa3wVwjzRbPWFLATRM5HCNIvGgsBvKGg5mBUgEIsCGIhYZB4p0sDZI5TaU5L5JevehBuSakUPE88ZuYovC2kxcwFmcSwnDlb8eOV1gd2D/GL3yXK0I9iIqd1pnr5MOnX3tsUCXZS3ASpB0S/mpWCSDvHkVfEhs338P2q00FKxtB8jvQPkSMSIwnj4jctJLRHsppvAumRfUMVFzU1xrGOVwBGNRkL5CxfTO/CwXVDvz0BEJW3MhzgMqdzRvhgh9H1g7X5kOeaWcOE5qyBwQILYrqL1ss7kpK/Rfv8yBMK7BpL1o0V7bJdpCz7M4wvTIuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=095bjjr3zMb7zQ9mX/pRBjFSSXYBcPxot+VJIGLjEhY=;
 b=ckIcS969uhw+GJTlo6f61Z8UdPAHbcOl9e0lEE2zzrT/av8Wr4b3cmXJDpR9kh27oMJTzskSGZsw9v0eOgvgwr1BkYX+XG3tKbNoZDfeillC4tZ5GM2d2C1b0D/wfiLQLEeWgL8N+zR1n3sYYPsOq+VO4mtG7mNO8bVEMak5acBqJXM9DdJCj9TC1BhOOpJ0YUVrfz7VUthUlfW3Yv0El/QZFO4G+rlydUkxckEN6ijkLlGX1qNQRhdF8U/w/6CPksyHG68l6DxjLPp7yE0KujvUSexj/VCSJ8Issh1MZycvmJstG5tXgF+IF9ybzTrWsk3rIEzFi8EqtNxlLo6v8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 26 Sep
 2023 21:15:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 21:15:50 +0000
Date: Tue, 26 Sep 2023 14:15:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <rafael@kernel.org>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
	<yazen.ghannam@amd.com>
Subject: RE: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Message-ID: <65134a03ab0ae_bf91294dc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
 <20230925200127.504256-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925200127.504256-2-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc7902e-fdda-4043-2460-08dbbed5c282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /l5tQiO/060yy0pkJ6pAPX1vs4uIKt+E2VcVPNXrA6PSOXeNIBxlFH8jL20rmgtyVuaLNimorn3ahuHedJbC/fMruJ2uahk85F2qQhhWfKf6bt1iiRSZMcUzFjdVO1JifhvE9RSjfp/naUbS+xvSgmqcXzaZG4/wAl645xzOM6mJx7xLU+eN5fIRMqsvCeJ6D3fIlh5YvyS8lkEcYyMeb3J4mKnVbD5z9KXttQQYJug7itv9De88v0WKSsSBT7pRjpxfrpMZPDoF/vWoSU39tqyGTJXidagCOjwfvXSs8Tgtp8dC58+1wPeMx6H0FS0tCxsmJKDlIq9RLBD3J2NmsyJNLl0dqVavVT0iu+wrsDJJFCuVyBHeZuclWsRTkOdSU4CVuxqleJWFQcp56tP6Jb9RsW58tjWZAOWZoBAKTRdwsb8EPecEqPJqvx7ExuB1y6DrPsQYRSFQPEehcwapg519HimkAYsXZK23NXSOP+TlpkLh5I5LcO+1htB9qADhsqA6OLGDZ5ZDg2s3EJKtgHK9CT+faSrfqLm2Mxk7xcaTloq89XTczehpgqULrr9y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(9686003)(26005)(38100700002)(86362001)(82960400001)(6666004)(2906002)(5660300002)(83380400001)(6512007)(6506007)(478600001)(6486002)(316002)(41300700001)(8676002)(4326008)(66556008)(8936002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z4l7tsryZ4lsdEkNt8lMedUTUxDFFzJ/aC8csdQCQVIAzr/mpxVYpnSp0IaB?=
 =?us-ascii?Q?wlkDmC8MmsV4+aNjzC28c2WL7r/VLOGTl0LDqmLDrNbti3toBsatwuqIv5L6?=
 =?us-ascii?Q?avOtYQqFX66c8hS+w7RcaHvNyg/ph0+cDwV9cSOVLYpSaSVdJAgxn+Z2aSk7?=
 =?us-ascii?Q?QmPvfmBswBvyfkv0RGpsXgaO925YUHNyxqSu9E0Y5HOV7vWeJyUKs54uwjBh?=
 =?us-ascii?Q?EEvtJ3Hd3X3zqpcK1CUmjWD6jWB03fFZ+PclkyQLhFGiFQ0Nougbd65bnMpv?=
 =?us-ascii?Q?HqrobpFQZ+wbyaKqsz+B2zUWNaUxf5IlYGpWByWAuP6qqZVyba4B5OvfXsJq?=
 =?us-ascii?Q?GZ3p3sa7KkefaIAESTCbuLM5W4bYgbxPrqSSulXQIBoRQ7bq+VknNysSrSMm?=
 =?us-ascii?Q?voXElal8qU+kmTtEyqNX1L18y9KARlg2upXvZ5HzGV26jAtsqT+twDxEdlPL?=
 =?us-ascii?Q?IiqTWX6vvEr7w8CfCFfpDTr74cXs/2v8wp9i/kquh82eBhuNP6VGeqGwHlQT?=
 =?us-ascii?Q?ahkQIbNrofR40O/GlDQdHyN9HfYCQjgmfxau+c5xt2OC4vM3RBy29e85HWVC?=
 =?us-ascii?Q?5ousJZeV93x5PxaBMOi9U9M4U94hJnwtvrJ7uRvkkOGMifbeyZ/RKLnBGfzf?=
 =?us-ascii?Q?lbDImudSrbwv9tuqESkXQ4Ko4gKTq7OjzuMOZfuqzH6JxyRw9DdF88ap7LdS?=
 =?us-ascii?Q?l8rtAP+e9PTApgqp+ln7qL44xoFAXfyabZajgeI9Q0J9kmZ/3/YFrtaysQ3a?=
 =?us-ascii?Q?02vXtzSvlFQexOuLDDZTie/8MyHntbt+Xlrk4aiNkBVYa1CZSd9InbXy3B/Y?=
 =?us-ascii?Q?k2JoLJ0Omxh5rsqnEKtM10cnKW8AiLtOPmULDc7Kcf3PrS8YF8l8vBawDl4r?=
 =?us-ascii?Q?u4mJ1Z9O20vbuYI8/jJGp3jHUQFUUxMDaQiVdiBNK6Z/8PPVa89Bo10aNCA3?=
 =?us-ascii?Q?hXnzRijFxqTuPV3fTDou4JbLQTg2wuAjbI2ga/Hr9MU3kGQ3M6Bq61zkh/Rx?=
 =?us-ascii?Q?vyVKMUqAOLqtUxzJWJcQZLoqUnw1ZWr1X82sZxeiu8xz11rf3ieTeqtK9uho?=
 =?us-ascii?Q?yL4HYU/2dLFrZg2wt+FZcD7HakSBnXJ2NTOKebCV9jKyl0/9cZBIDEwLm4Pa?=
 =?us-ascii?Q?pPvr+IEdLZb1l7L/4tnMH95jtdMZxA+FVs1R49gE82Ro/7Qs+CwIXKaLupNK?=
 =?us-ascii?Q?xFTP/EjhVyD1mjjqVUxOHTcErybsU3aO3UpL4aekoP1+GHbcBeV6gCMGZDd5?=
 =?us-ascii?Q?5zp0ki0s3DC0OxUw6QBzMDclTHhSkkFzw0K4sahOTOSeCL1iSuhDUz1SHcwD?=
 =?us-ascii?Q?1iI5VRNi8IPwjRn99RClqxrnayW2k7lwtjPrPEJMcNxxXhv16wbBB6k0QZcr?=
 =?us-ascii?Q?c546s1itCIiOGbj/Ibyv7d45aOirHXPOrJRocJUvkUoIObJdihFOMW+WYh7E?=
 =?us-ascii?Q?0DOV5UCiz1Yhc/bnoe8ZensH0/LxrznGr+NDlJT39R5AKL+XVYdqlD25nBGT?=
 =?us-ascii?Q?A4iE9T78YeuM0fq+HIDWettE7GLuQzJcU5J3fRj26gnrSftPNx+5ol62m6oG?=
 =?us-ascii?Q?LtLGGDoLKHyY01VsRP5SdVO5EZe1SNToBCCb2hicpUBv0Eczzb3bI3ajerB3?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc7902e-fdda-4043-2460-08dbbed5c282
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:15:50.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcYHf1tX5vkTot5g+qu42vOwBsMp8Q954E/7QEKVJsoMxgqsPsm7jhPKgBWOWYBFtcdY6wWCFPJToxF6jHP5URi4W/g21zMfKkeDRMVU4Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ben Cheatham wrote:
> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
> device) for CXL RCH root ports. The file will print the RCRB base
> MMIO address of the root port when read and will be used by
> users looking to inject CXL EINJ error types for RCH hosts.

RCRB is an implementation detail of RCH topologies, I don't see why
userspace needs this information, maybe it becomes clearer in the follow
on patches, but I would hope this detail could be hidden.

> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  9 ++++
>  drivers/cxl/acpi.c                      |  2 +
>  drivers/cxl/core/port.c                 | 58 +++++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |  2 +
>  4 files changed, 71 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 087f762ebfd5..85621da69296 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -177,6 +177,15 @@ Description:
>  		integer reflects the hardware port unique-id used in the
>  		hardware decoder target list.
>  
> +What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> +What:		/sys/devices/pciX/cxl_rcrb_addr
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The 'cxl_rcrb_addr' device file gives the MMIO base address
> +		of the RCRB of the corresponding CXL 1.1 downstream port. Only
> +		present for CXL 1.1 dports.
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y
>  Date:		June, 2021
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d1c559879dcc..3e2ca946bf47 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -676,6 +676,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (IS_ERR(root_port))
>  		return PTR_ERR(root_port);
>  
> +	set_cxl_root(root_port);
> +

The cxl_root is not a singleton and the way to determine this linkage is
by walking up the port hierarchy. See find_cxl_root().

>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_dport);
>  	if (rc < 0)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 724be8448eb4..c3914e73f67e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -875,6 +875,14 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  
> +static struct cxl_port *cxl_root;
> +
> +void set_cxl_root(struct cxl_port *root_port)
> +{
> +	cxl_root = root_port;
> +}
> +EXPORT_SYMBOL_NS_GPL(set_cxl_root, CXL);
> +
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> @@ -930,11 +938,56 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
>  		device_unlock(&port->dev);
>  }
>  
> +static ssize_t cxl_rcrb_addr_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_dport *dport;
> +
> +	if (!cxl_root)
> +		return -ENODEV;
> +
> +	dport = cxl_find_dport_by_dev(cxl_root, dev);
> +	if (!dport)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "0x%llx\n", (u64) dport->rcrb.base);
> +}
> +DEVICE_ATTR_RO(cxl_rcrb_addr);
> +
> +static umode_t cxl_rcrb_addr_is_visible(struct kobject *kobj,
> +					struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_dport *dport;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ) || !cxl_root)
> +		return 0;
> +
> +	dport = cxl_find_dport_by_dev(cxl_root, dev);
> +	if (!dport || !dport->rch || dport->rcrb.base == CXL_RESOURCE_NONE)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static struct attribute *cxl_rcrb_addr_attrs[] = {
> +	&dev_attr_cxl_rcrb_addr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group cxl_rcrb_addr_group = {
> +	.attrs = cxl_rcrb_addr_attrs,
> +	.is_visible = cxl_rcrb_addr_is_visible,
> +};
> +
>  static void cxl_dport_remove(void *data)
>  {
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> +	if (dport->rch)
> +		sysfs_remove_group(&dport->dport_dev->kobj, &cxl_rcrb_addr_group);
> +
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>  	put_device(dport->dport_dev);
>  }
> @@ -1021,6 +1074,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	rc = sysfs_create_group(&dport_dev->kobj, &cxl_rcrb_addr_group);
> +	if (rc)
> +		dev_dbg(dport_dev, "Couldn't create cxl_rcrb_addr group: %d\n",
> +			rc);

Please no dynamic sysfs attribute registration. If this attribute is
needed it should be static.

