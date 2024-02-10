Return-Path: <linux-acpi+bounces-3337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535AE8500F3
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 01:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F101F24F1C
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 00:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41236B;
	Sat, 10 Feb 2024 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlc58kAj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6A79DB;
	Sat, 10 Feb 2024 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707523375; cv=fail; b=QO85uqzdyDc8zhNJGiAwq5jVps9RhOPn1JOt42Gy33RHBu/aZj3hnTKmnx++8NMOPKFy3S1lINJ+oWFi7ssB5mVyY4ARIaQXmutssB103IhydWw4J8jms2zpWGl4oernUGmTlYmvjKZ6qBK3mIhLRmd5Tw+nBFL8HAzrgGf/oFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707523375; c=relaxed/simple;
	bh=x5DCA0E0Qcadg+xNeikSnclzoh/ep+pASobv12XNe2E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ezDhTpVmeA52re6JIfYR2lSLL11HkTIWzTaGYC5tJ30ugz8/3jGaX0Mcbn/SOIZh61UAj1rxjD1WAd8treK4ljw2+iGpDt49+k6bNkK6vM/QaIOm7orIfdWkUcB+wR18CRBYJTUI1Tay/L3U86QJIIORjxnfY6z7EcNN+FeRg20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlc58kAj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707523372; x=1739059372;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x5DCA0E0Qcadg+xNeikSnclzoh/ep+pASobv12XNe2E=;
  b=dlc58kAjJQp+RCqzxXK6EoJL56LUOLLKjwV0u7bnWzMqTLBQcRRl3cOb
   vDPRa9vN+CwtF9oGPakv/ET4CWYZUx1A0QxFYsmY+MaDvJ87FcdXiOtxM
   sueUKIOkF6j+PzkKSOZAO4nZTy6xFSARkW2wwJvonTKobjMjKa0Rd4H1t
   nPrs1DYxKND+r9a+vTqErK7tumyuN1fxMceRQ3ShozvzjZDkoHCF5kROR
   XcvVydFIHJoi5eJE9wwg/S6dJSCw3F0n32paFpNXd4wYj+RFldoPlJUFj
   saG21gw8+EA9ylmThgiwluvsWLhta/2d7uFgRnmGpA0ra0A+bvhxgeBLs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1656152"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1656152"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 16:02:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="825272156"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="825272156"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 16:02:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:02:38 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:02:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 16:02:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 16:02:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfErh+M0ntH0CTXXQetkp1GmcXJlRrfcnr0NK/uPju/5ng4x1FsztkDGVSou8wtx+70XGrtaANh5yfoHqN/dH2M4sfcWJRA8Vh78sYVbGLi8hQoNSGVhbeqno6Q+ZnotR8CdQ0CNERBzz2yAovBzOOmvTrO7yDeBjlKgnAEw+V+th9TFWPY3PEJvnIF1OaxbchTHcC390GauAWC4eTXgsNWDpvMjFZ94L2tsjfP5kFZSK8vww1VwxdV9BDCB267VRNT1hTmeQgLAbhU+gtNlNBz/cSa32yUwykLwLaKumEeWipXPPqjobqBYJdRaqHVzpktmz3HcXwIyEdS/e8REtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T12ksb4PdEZjbAUcgEDjiBp8k2SMyynMGQcPc0p2fUI=;
 b=cznyzVRQxD2r8v6B1uAwAfeH5NH0vOlS4HYh0mFcTmh0cuPSlzOSlvFGFm8ekNOOHdpp7DuOJM0wV+73JTTwO+ZIaLZF+k/5xJs7S2t/EX+BMsvG3txBefVmZ51633oBqzHpKb2bx/eIO3JlZzcyOqJkTRMxGQJuZoZaeHcmEU5BFybhUqhhauI4HnXJSWN0nT3a/2UzAKrTpCGFS66KiiDsx2RQQ7tc+imMidrYSDpIHIrQIt7NSDmh/wmDOS/ANuWBX1nWxTsdAhwbHFokSQZkxaWWObTZTLZxbnTaE4CHZY+ps/MJTuwVEl5xdmWVNdn2ilTYg98Qji5AUdhSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Sat, 10 Feb
 2024 00:02:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 00:02:34 +0000
Date: Fri, 9 Feb 2024 16:02:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <65c6bd181bd36_5a7f294dc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
 <6cd90997-0dea-4dd6-ab8e-2630efaa6209@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6cd90997-0dea-4dd6-ab8e-2630efaa6209@amd.com>
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ac85c1-7411-48ac-9fd4-08dc29cb95ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZz38GNMHXRjaAtTSU03tTvVDOYGxZOSDKZuUL/tI8AENmCRSxSaPeHngsJdczpbht5Q7QyiO2UtvtDZlg0FP3CGS3VPfnnqplpOK/fugvmxCP8F9i+4w6OR2grTAI4x3o/VGCOKJm3CNPZDdicel7JHunl3mSbvPYxdgu2iTCO1VHsnUUVMyGoGBIkLfBVNi/Tu9Np7BZ78NNTYR5uqTFGwsfQZggnaWyYrKOgNKSv+k8FQFtuJSYtiqeYnuYoKG4TjPdxSp6hoCTR3y9imxOYXRNAEXLR93Cexi3BnqEMFCQf7KNiemQEcdcqvHOH2UdUFHUL2tTa05RHPKmXxkstmOVUoeO81wYVI8HZ0q3JMjvZCT6cR3PpgibN7xjyBL42kGacyKyGv/svDQww2K65M5WrnoxW5h5vjb8aJpdPkDo9SaBa43LgbXQHRPm7L+knVWSRsLc5OVf0vewJIUYwobIraVL7WZuTWqsrT2nGgTsLg4CL5mwiGkNKR4M3v75Pz1+dD7TYR28mt5FMpBmA4hFcxAx/j8NTQJmyzr50InK6rb1wGl3Z9yrhEQ5vr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(5660300002)(2906002)(86362001)(82960400001)(30864003)(26005)(6512007)(9686003)(83380400001)(6506007)(53546011)(8676002)(316002)(66946007)(66476007)(4326008)(66556008)(8936002)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VOADkEMSyqoGj/EBmJiNgQZb7aKcMreDjbI4gb1hW+kfdSRY9ctUON9VBIo0?=
 =?us-ascii?Q?c6PLhV5/EUB9JCME8h5WIOWmDdz81EVpezlXXioyPmJLHOB+MUCBBBBVk0cf?=
 =?us-ascii?Q?DJfmZt8o4MyZGR04Bsq+6zV6KoR6N0aqBL/IRk+2ErjYy2zhrXSMqG4tgQVv?=
 =?us-ascii?Q?jkwH8u++5qYHvWWyG29Zda7jc1Yefe2tgRyWxvTC2eHoevQ2t0cso41bD6oA?=
 =?us-ascii?Q?pRKMURT6AZBwjpbUVBzW1RJrLjZQojJjBSA+TDzZ1aU/tv3Oah0PdklpG5NY?=
 =?us-ascii?Q?x3LD9hJqCGYMI7shkRU+CnU3IK69hUeL5Rw/jZxXDx4qxGiGjq4xC4hiFxYl?=
 =?us-ascii?Q?8g9RKcgk9jo2WhSNxAjDh0EdX/KUoio+we5r7iwQGh896n2AqSoNOItFF8V5?=
 =?us-ascii?Q?jjFXy2LPRCWi+Pn36pfIfypMI3INF2sQkHrsqzoJZ55koDvoH9Pj+n0BGa6X?=
 =?us-ascii?Q?ehJ/5eixZYnGknY3sEotJX9ybJ48IOZIqgTMpwboepfiZF69QJ3qXzC51v0/?=
 =?us-ascii?Q?P4Z+Ny52iCnZnlLT2weKs9UTmbteph2VJCZcDTEfMRz2Y4Nct9H2W9amEio5?=
 =?us-ascii?Q?w7G70579kNXxq5GGHwuFjYaTQMz9T9pXnNAyCQvsC4e2cLSni3muzwNTN/GF?=
 =?us-ascii?Q?YHKgtAZ/uGPYoxAAv/XHuA1xLJFj+k1EDPuX7Pn8Il35CG6MvMukdFXqvTca?=
 =?us-ascii?Q?ljWPlJkjb3v2ObpQmbcCmwM0kMSPdk/z/YFmbDw+0q2qz71Q8iNk+uZFkyMQ?=
 =?us-ascii?Q?VJ78QRxvg4HsJ8vjNbK3gxRUDGNcInoozZgpS+y0r3/P+5Z9Sk6CT2byCrol?=
 =?us-ascii?Q?JD7/B8YkBMZ0PmQlpUQ6mSd3vGVUIaDFpVfgm52cLq6KExkDmw/t56ktlPkZ?=
 =?us-ascii?Q?+ywSrsFF1HoKRhb7PtAVRlgoh2euJ1tjh1X3+iseMpw02WYUkqfBw0XAuqPi?=
 =?us-ascii?Q?BV1AGUfgu1usYl+jLKL1qtrL3MZOUHeaM5j1vFRFU8SrQ2hGTrZej3PLcNGQ?=
 =?us-ascii?Q?D1cQETM0r5aGE8Q4mnCPm3k7/AKPNNjhBpq1vljVeypANgrocB5L+zfktzWb?=
 =?us-ascii?Q?XC6rlyfc1ONlKspsILjKDE0vLCi81eFVqtXU3bWHmS5nHxC8B6ybDIyQO4aH?=
 =?us-ascii?Q?HFXyc+m6JW3c/ylBlXNOlGXSwyKqCXUGPAXGTGkayiI1B2fLVq32W7pYfvLZ?=
 =?us-ascii?Q?A0tiddXgtdSrFf5xUk2iklIzcoDzqnYD3hNABPaq+lUGrewSQZJ35/zamTiX?=
 =?us-ascii?Q?i3Y2i6hLtA5yExz/cENlv8tOm9Gy3lGy7avZ3dQcAMe4iXa1PabGaqSsn3xm?=
 =?us-ascii?Q?8h9TU1Xb/S9oNdbDmQpYe40aYvPTwEOOFQfDtSyidtKVB5el3FcyK2+6+bns?=
 =?us-ascii?Q?sV3fMUrmfaEQTNDxiBWO7iGenUkivHBE6Vh7GcXJwruSLK6KFG8xnIErtxi1?=
 =?us-ascii?Q?d3+h6PDZAuSHnZZC6WP3aUFe9A9VIFiCkA0iu5NKJu6sYN0P7nR1XFmuLs7E?=
 =?us-ascii?Q?d+OfIZOiS+v5abwgcfhIYAxyNu889OEL+Rpi9Uojum02Bv4TN9070lJ71UTo?=
 =?us-ascii?Q?UlUy5zQN/6BVOVSYerzXSmMS8B6Pc6LwMUZdFdZZ2aJ7cHOMgzKoZucNXikL?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ac85c1-7411-48ac-9fd4-08dc29cb95ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:02:34.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhK4+udE70HL8g7oUEuEf1C0haLk5Q9KHxpLsDtER4s4YNx5LF8WfgAvov9tArsbpxFcB8FvuiAVCJwt2Vpuk8baM3zHTSIQ1fYv0n9qfVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> 
> 
> On 2/8/24 2:00 PM, Ben Cheatham wrote:
> > Implement CXL helper functions in the EINJ module for getting/injecting
> > available CXL protocol error types and export them to sysfs under
> > kernel/debug/cxl.
> > 
> > The kernel/debug/cxl/einj_types file will print the available CXL
> > protocol errors in the same format as the available_error_types
> > file provided by the EINJ module. The
> > kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> > error_type and error_inject files provided by the EINJ module, i.e.:
> > writing an error type into $dport_dev/einj_inject will inject said error
> > type into the CXL dport represented by $dport_dev.
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> > ---
> >  Documentation/ABI/testing/debugfs-cxl |  22 ++++
> >  MAINTAINERS                           |   1 +
> >  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
> >  drivers/cxl/core/port.c               |  39 +++++++
> >  include/linux/einj-cxl.h              |  45 ++++++++
> >  5 files changed, 255 insertions(+), 10 deletions(-)
> >  create mode 100644 include/linux/einj-cxl.h
> > 
> > diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> > index fe61d372e3fa..bcd985cca66a 100644
> > --- a/Documentation/ABI/testing/debugfs-cxl
> > +++ b/Documentation/ABI/testing/debugfs-cxl
> > @@ -33,3 +33,25 @@ Description:
> >  		device cannot clear poison from the address, -ENXIO is returned.
> >  		The clear_poison attribute is only visible for devices
> >  		supporting the capability.
> > +
> > +What:		/sys/kernel/debug/cxl/einj_types
> > +Date:		January, 2024
> > +KernelVersion:	v6.9
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Prints the CXL protocol error types made available by
> > +		the platform in the format "0x<error number>	<error type>".
> > +		The <error number> can be written to einj_inject to inject
> > +		<error type> into a chosen dport.
> > +
> > +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> > +Date:		January, 2024
> > +KernelVersion:	v6.9
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) Writing an integer to this file injects the corresponding
> > +		CXL protocol error into $dport_dev ($dport_dev will be a device
> > +		name from /sys/bus/pci/devices). The integer to type mapping for
> > +		injection can be found by reading from einj_types. If the dport
> > +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> > +		a CXL 2.0 error is injected.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9104430e148e..02d7feb2ed1f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/cxl/
> >  F:	include/uapi/linux/cxl_mem.h
> > +F:  include/linux/einj-cxl.h
> >  F:	tools/testing/cxl/
> >  
> >  COMPUTE EXPRESS LINK PMU (CPMU)
> > diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> > index 73dde21d3e89..9137cc01f791 100644
> > --- a/drivers/acpi/apei/einj.c
> > +++ b/drivers/acpi/apei/einj.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/nmi.h>
> >  #include <linux/delay.h>
> >  #include <linux/mm.h>
> > +#include <linux/einj-cxl.h>
> >  #include <linux/platform_device.h>
> >  #include <asm/unaligned.h>
> >  
> > @@ -37,6 +38,20 @@
> >  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
> >  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> >  				ACPI_EINJ_MEMORY_FATAL)
> > +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> > +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> > +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> > +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> > +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> > +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> > +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> > +#endif
> > +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> > +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> > +				ACPI_EINJ_CXL_CACHE_FATAL | \
> > +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> > +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> > +				ACPI_EINJ_CXL_MEM_FATAL)
> >  
> >  /*
> >   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> > @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  	if (type & ACPI5_VENDOR_BIT) {
> >  		if (vendor_flags != SETWA_FLAGS_MEM)
> >  			goto inject;
> > -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> > +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
> >  		goto inject;
> > +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> > +		goto inject;
> > +	}
> >  
> >  	/*
> >  	 * Disallow crazy address masks that give BIOS leeway to pick
> > @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
> >  	"0x00000200\tPlatform Correctable\n",
> >  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
> >  	"0x00000800\tPlatform Uncorrectable fatal\n",
> > +};
> > +
> > +static const char * const einj_cxl_error_type_string[] = {
> >  	"0x00001000\tCXL.cache Protocol Correctable\n",
> >  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
> >  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> > @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
> >  
> >  DEFINE_SHOW_ATTRIBUTE(available_error_type);
> >  
> > -static int error_type_get(void *data, u64 *val)
> > +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> >  {
> > -	*val = error_type;
> > +	int cxl_err, rc;
> > +	u32 available_error_type = 0;
> > +
> > +	if (!einj_initialized)
> > +		return -ENXIO;
> > +
> > +	rc = einj_get_available_error_type(&available_error_type);
> > +	if (rc)
> > +		return rc;
> > +
> > +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> > +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> > +
> > +		if (available_error_type & cxl_err)
> > +			seq_puts(m, einj_cxl_error_type_string[pos]);
> > +	}
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
> >  
> > -static int error_type_set(void *data, u64 val)
> > +static int validate_error_type(u64 type)
> >  {
> > +	u32 tval, vendor, available_error_type = 0;
> >  	int rc;
> > -	u32 available_error_type = 0;
> > -	u32 tval, vendor;
> >  
> >  	/* Only low 32 bits for error type are valid */
> > -	if (val & GENMASK_ULL(63, 32))
> > +	if (type & GENMASK_ULL(63, 32))
> >  		return -EINVAL;
> >  
> >  	/*
> >  	 * Vendor defined types have 0x80000000 bit set, and
> >  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
> >  	 */
> > -	vendor = val & ACPI5_VENDOR_BIT;
> > -	tval = val & 0x7fffffff;
> > +	vendor = type & ACPI5_VENDOR_BIT;
> > +	tval = type & 0x7fffffff;
> >  
> >  	/* Only one error type can be specified */
> >  	if (tval & (tval - 1))
> > @@ -652,9 +688,105 @@ static int error_type_set(void *data, u64 val)
> >  		rc = einj_get_available_error_type(&available_error_type);
> >  		if (rc)
> >  			return rc;
> > -		if (!(val & available_error_type))
> > +		if (!(type & available_error_type))
> >  			return -EINVAL;
> >  	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> > +{
> > +	struct pci_bus *pbus;
> > +	struct pci_host_bridge *bridge;
> > +	u64 seg = 0, bus;
> > +
> > +	pbus = dport_dev->bus;
> > +	bridge = pci_find_host_bridge(pbus);
> > +
> > +	if (!bridge)
> > +		return -ENODEV;
> > +
> > +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> > +		seg = bridge->domain_nr << 24;
> > +
> > +	bus = pbus->number << 16;
> > +	*sbdf = seg | bus | dport_dev->devfn;
> > +
> > +	return 0;
> > +}
> > +
> > +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> > +{
> > +	u64 param1 = 0, param2 = 0, param4 = 0;
> > +	u32 flags;
> > +	int rc;
> > +
> > +	if (!einj_initialized)
> > +		return -ENXIO;
> > +
> > +	/* Only CXL error types can be specified */
> > +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> > +		return -EINVAL;
> > +
> > +	rc = validate_error_type(type);
> > +	if (rc)
> > +		return rc;
> > +
> > +	param1 = (u64) rcrb;
> > +	param2 = 0xfffffffffffff000;
> > +	flags = 0x2;
> > +
> > +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
> > +
> > +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
> > +{
> > +	u64 param1 = 0, param2 = 0, param4 = 0;
> > +	u32 flags;
> > +	int rc;
> > +
> > +	if (!einj_initialized)
> > +		return -ENXIO;
> > +
> > +	/* Only CXL error types can be specified */
> > +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> > +		return -EINVAL;
> > +
> > +	rc = validate_error_type(type);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_dport_get_sbdf(dport, &param4);
> > +	if (rc)
> > +		return rc;
> > +
> > +	flags = 0x4;
> > +
> > +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
> > +
> > +static int error_type_get(void *data, u64 *val)
> > +{
> > +	*val = error_type;
> > +
> > +	return 0;
> > +}
> > +
> > +static int error_type_set(void *data, u64 val)
> > +{
> > +	int rc;
> > +
> > +	/* CXL error types have to be injected from cxl debugfs */
> > +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
> > +		return -EINVAL;
> > +
> > +	rc = validate_error_type(val);
> > +	if (rc)
> > +		return rc;
> > +
> >  	error_type = val;
> >  
> >  	return 0;
> > @@ -690,6 +822,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
> >  	return 0;
> >  }
> >  
> > +bool einj_is_initialized(void)
> > +{
> > +	return einj_initialized;
> > +}
> > +EXPORT_SYMBOL_GPL(einj_is_initialized);
> > +
> >  static int __init einj_probe(struct platform_device *pdev)
> >  {
> >  	int rc;
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 8c00fd6be730..c52c92222be5 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/memregion.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/einj-cxl.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > @@ -797,6 +798,37 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> >  	return rc;
> >  }
> >  
> > +DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
> > +
> > +static int cxl_einj_inject(void *data, u64 type)
> > +{
> > +	struct cxl_dport *dport = data;
> > +
> > +	if (dport->rch)
> > +		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
> > +
> > +	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
> > +}
> > +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
> > +
> > +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> > +{
> > +	struct dentry *dir;
> > +
> > +	/*
> > +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
> > +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
> > +	 */
> > +	if (!einj_is_initialized() ||
> > +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
> > +		return;
> > +
> > +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
> > +
> > +	debugfs_create_file("einj_inject", 0200, dir, dport,
> > +			    &cxl_einj_inject_fops);
> > +}
> > +
> >  static struct cxl_port *__devm_cxl_add_port(struct device *host,
> >  					    struct device *uport_dev,
> >  					    resource_size_t component_reg_phys,
> > @@ -1144,6 +1176,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> >  	if (dev_is_pci(dport_dev))
> >  		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
> >  
> > +	cxl_debugfs_create_dport_dir(dport);
> > +
> >  	return dport;
> >  }
> >  
> > @@ -2220,6 +2254,11 @@ static __init int cxl_core_init(void)
> >  
> >  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
> >  
> > +	if (einj_is_initialized()) {
> > +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> > +				    &einj_cxl_available_error_type_fops);
> > +	}
> > +
> >  	cxl_mbox_init();
> >  
> >  	rc = cxl_memdev_init();
> > diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> > new file mode 100644
> > index 000000000000..af57cc8580a6
> > --- /dev/null
> > +++ b/include/linux/einj-cxl.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * CXL protocol Error INJection support.
> > + *
> > + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> > + * All Rights Reserved.
> > + *
> > + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> > + */
> > +#ifndef CXL_EINJ_H
> > +#define CXL_EINJ_H
> > +
> > +#include <linux/pci.h>
> > +
> > +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> 
> I was testing some other work using this kernel and was getting a linker error
> when I had CXL_BUS set to 'y' and ACPI_APEI_EINJ set to 'm'. I went ahead and
> solved it by changing the line above to use IS_REACHABLE() instead. The change
> shouldn't actually affect the functionality of the patch since this is in a build
> configuration where the CXL driver isn't using the EINJ module since CONFIG_CXL_EINJ
> is set to n due to Kconfig restraints.
> 
> I can submit another version of this series with this fix, but I don't think it
> makes much sense for a 1 line change, so I've but a diff below with the change
> for whoever ends up putting this in their tree:

I don't think this is the right fix. CONFIG_CXL_EINJ should be disabled when
CONFIG_CXL_BUS is built-in. Looks like the polarity the dependency is
backwards. The problem with IS_REACHABLE() is it removes the simple
debug option of "send me your .config" to see why some functionality is
not turned on.

Could you test out flipping the dependency from:

    depends on ACPI_APEI_EINJ >= CXL_BUS

...to:

    depends on ACPI_APEI_EINJ <= CXL_BUS

?

