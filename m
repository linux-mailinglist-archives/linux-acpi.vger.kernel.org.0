Return-Path: <linux-acpi+bounces-2237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFF80AC25
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 19:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73C11F20F41
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62B481A1
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOQtbcX+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB2A1729;
	Fri,  8 Dec 2023 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702058522; x=1733594522;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u8MwPJhrE/ITx9Q0l/uqWwqWlTPSq4HD1jGvQUApCVA=;
  b=NOQtbcX+lqvOQrIb+jrVdrUdoDTz4COVVcp4sbV0gVuwNX0kVh1LcKuq
   Br8JvGDTSx9iDyls+LHHzNMQ5HQH/6qNSnsIre+64GdPvdW5dQOVuwpAC
   vQBuiDvX32p0I9utISan8bnBScFnDqlsICCyowDZdZQ7PCqhoRxssOQkQ
   YNApszUSOHNbLEyuZRsQjI+MDwVyDPVbKS0O8SQGrhfRpF7/bYRdL8wAm
   P/WytbuKD9kjk4FxPsIBLJfEs+tv3sDvE++ANRBnlIDDUeMQUaxWz427v
   p4PgqbLp5hsBJRIdCo5NxDJUMvK3xdu4VHiO0p8zdgc5LuRiBBLp3r13D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="373942885"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="373942885"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="775868400"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="775868400"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 10:01:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 10:01:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 10:01:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 10:01:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2gatFyk+hB/kVM4Zeah+x90YWQ3khaAJTko+SuF9LjgIJ76yY8PK/DXbfW7uQ8fsREdGqiIhQMP2bCxD72H6I/bbmNi9r4ixAUXCmWxQ2t3vohwHUpEa1lulwTZyw9vbzms9tloFKHAb6iPtZYhbsDx2Nc5vluUx5OVuDIZvjQ8eifqp5evnoIEhBrnopeVZX7PmS8uCsXC/bbIkd7/kpT4pIyGZnN0NLp8dbDZjs/XXaMYAWQsTpXhERZFw7b07zAI6lCNK1CxBhEYuR5Ci4Ji4sF8IiOizPBekJO+EuvABMbZo8brcEPPWFWRrmT6QJZy0j462egPf4SeOZ1bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiDdsYv782zbs3TTOQtMpTy2iYD73NCdEyEVvVqTJNY=;
 b=W5M6AQZVSP3ur64OdMmy2JHJrAx/2JYhY1msze2se8XI4RgQhGvoVGhntnwCt/O0kLEgN1YecCQKGJSzVRlbmFL4JDLgnybci0nVZV5W+EadHSgspblTawGqZ/tU6CjYcwm93BeJ15jQV6/XfgPao32O+jzb1YdhLC0CLfcgLtQ5RmiZBqeCdOQ1DkjrZd7++Xdf3yt1zT/505JMILGCSFs9QyJBdbdOZt0swZJwbmdZ5yqHiCKVRwpgRQMLtJuRPqb/hatL3B3elkWnkhiT5lncMN3SLnqJm5IoiLiy2tTlveaD6l/m5/wGbSLfzhZMWIcwUcNeLw3fIM0JJfpdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 18:01:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 18:01:54 +0000
Date: Fri, 8 Dec 2023 10:01:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <yazen.ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] cxl/port: Add EINJ debugfs files and callback
 support
Message-ID: <65735a0e595e_269bd2948a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-2-Benjamin.Cheatham@amd.com>
 <657251b0517bc_45e0129418@dwillia2-xfh.jf.intel.com.notmuch>
 <359bacbf-94d9-47b8-915f-dbf321cf0a9e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <359bacbf-94d9-47b8-915f-dbf321cf0a9e@amd.com>
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba6ab4d-4d43-49c4-bd02-08dbf817c280
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8vKVL9nZagVYhmsp5JRUzLR6lyiIBR/l3x5aKD51+2WuWEMwAqgCCDwvzB0nxf7RK3TPDvQ2NM+aGD8tql9ojbnyBO8X+kHQQrvlmc4zcDGq+RvkswovrCmaVAae2/mmpZtf/O8uFopPld73TQohc88BDN+VbzCDk7BriX7001oBNve3/sKzS5tdGUM9rE2fcOf2x70ViGny3l6+jPcvqxuGmHkcRyb7VgSYHU4DiQIYZIsZ/Nf/CYPgTZPO4SwMSokZZEqBfetoqk3hQ+zOJig2NHCd5IfMKCzbgNME6jSdYk6c6nKPwiwgkOG9gXi2SMIyRqJj/DXu5eyvh5Ib1tz3CCcyk3BFmp7OhGG1+XjEmBAK5bHEY97+h+smIYllybQhV0tNSyspfJsCPpxi0JuZv5JXoZcK61WuNeZ7uq3o8tFeQy0KwXY5886m5w3oFtIgHWnTMDMeAAAr2qwBranhP5ESZSQYb4IG2yLIOcJjMERBkvvuwJ7/6j947y1gZ6692ThviUnKeCBRhohiB0Es4m1vMJHhbpYdA99l3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(86362001)(41300700001)(478600001)(8676002)(8936002)(4326008)(6486002)(966005)(6506007)(6666004)(316002)(66946007)(66476007)(66556008)(2906002)(82960400001)(26005)(9686003)(5660300002)(6512007)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ym0jfSPnzGh29AQOtOen+uPltsUtoI0OtnI9UEx2tsqNS8wa2+FSPGoE+Aec?=
 =?us-ascii?Q?Dw0wTgAIG2/DRvnjMcyelmruRYYGzYokuGtn3wl469RZj+FJanpHo302W9hg?=
 =?us-ascii?Q?oPIG+z6iqh/mKh+2TjR3vS6Q8ErDkuCcOaJW3xhgNsHpQqWHPjeb9XdgQu6Y?=
 =?us-ascii?Q?ow8J8yvspkMQHL51xKTWklUbqin+TPlEVOqFk0kC+bwW0EOHbPI3jfs36YzZ?=
 =?us-ascii?Q?sqiPB6GOPeV2xIajzU+83LCmY9Qowd+rG231PIuv97vh5Na4dKw6uDo2kkzp?=
 =?us-ascii?Q?RlLasshw9UWYEIcpdX3fUMYqAxkfeIGj7S4ie2xTg1Q8pPOS8ReTzEQsVIev?=
 =?us-ascii?Q?QEdh1bchryIlk+Cdzdu60fy6ZYFi25OukHdp99sICka8nUi9WgBg3MVNTvmu?=
 =?us-ascii?Q?rAG2aDYTjqMTUgOkCir81IRchMVwm0Q+6bZYXbkDD26pq/5EdGrdlQRuLRP/?=
 =?us-ascii?Q?cCjg52rzL5Bf3MewlAwgc5SnilTwsS+aTsv7MGqboFCrUy5tuq5XHh8TYSGN?=
 =?us-ascii?Q?t615HbDqiisPWo4JQ0j7ZKQ6eoTv3XhVKh3yXPbT2rhLIFHdCW4zxI0RbEbo?=
 =?us-ascii?Q?Hw1zz1FSBBBBvfKGi35mydx3SvCvAN97Ra5CZt3NCv/9KoKQG3SXXOgjgBbg?=
 =?us-ascii?Q?d4EHnrcumzYbSAT7/XOJkOfhBKsdU0BorTbOwZ/eHjbAOgzhCbDRzM/jzW4B?=
 =?us-ascii?Q?hw3+e/5zMU3DsltyCdsxxUeTPSe+bfo+TAFugxBgVGBmapD2kQ3g1GeqUhSA?=
 =?us-ascii?Q?o9/2HJ8FVCE9KNSspdXdr5l6f6PjQF7wNBCEsReH9Ze5hgppSuo3etj0HdPr?=
 =?us-ascii?Q?MJMzOstySN+TejgnVT7itaNYuqMfSL6wSKn5Jg/AmGiHRydC760vOwXcrkES?=
 =?us-ascii?Q?O9+idSHYaesZ66bqXA514WYCXbu0JDzAyOdkdgH6Y0M1fdzHc6naIlwNumao?=
 =?us-ascii?Q?h1fIlP7G4D7r4jYSKqQgpf+KyrWfJ97MGrQnEoOhFrz7YHgGwiTpVnqiGrjN?=
 =?us-ascii?Q?D1zsvFRbd5ThHwXHwHWSmnLGZUN5lYfhnsVdZ67sY6KUWCbzBGcOCoSFq/hu?=
 =?us-ascii?Q?RatZJMrNq+MPk5a2P3c7pD5/2PBxnAVGRWX2+edRRWDwHWbjg3HSkiG6I3zz?=
 =?us-ascii?Q?+AdhdIRgZqjzaS+n7JeIX2o70dQXYNiKAF6GqfA9DahjESL+1gOaXlLW960A?=
 =?us-ascii?Q?UtA7yjXjCSVzQjAi3Lgquu330IIXgOXrPlFkDb/m3tPOPIisvYdHSl5yNo5p?=
 =?us-ascii?Q?6yu2SBCXW0PURQaLXR/thFTH1x4L/4Gjcs/5RJRKwF28efBWCqYupNuRtQ4Q?=
 =?us-ascii?Q?DipH/+0woxA19tC+QY2JkX+8t4Z4G4+A7FEABdP3D65Y5Ltlq21qGSkW3F3w?=
 =?us-ascii?Q?nMhCg1QhSAZB1zuQESwTQxK9HUz3uvcfXu81jI+Yw3bNvdyNkQU+QYqXHM+q?=
 =?us-ascii?Q?sUge8ftnVSAjuct4pFYFgrCPn4weL9QbTrjsG0w9UT9nVWxECgsdyTlNkBA2?=
 =?us-ascii?Q?Drqpn21HJE8NRzY5GJ6EEzhS+A6uQy0Ru+NO0Oka7U8fNKE+3IZa0XBkeVIO?=
 =?us-ascii?Q?ewpokYYMnhIaF3OVI1RIO7mGAaI+/QvKUQuNsCzYZ+g/7yPCXXlzkqv+f+An?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba6ab4d-4d43-49c4-bd02-08dbf817c280
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:01:53.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K37G5fVfnxZykJdOkmmrJUHHeb6yoo2mcxcR7KjlZECU/SYta9QUhhDRX6E4jMdfjEV+95mpy9Mq/DOhhuTWG6O68P4pyB+FmmFTIx4FzU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
[..]
> > This can be simplified. Have something like:
> > 
> > config CXL_EINJ
> > 	default CXL_BUS
> > 	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
> > 	...
> > 
> > Then the documentation moves to Kconfig for how to enable this and the
> > CXL code can directly call into the EINJ module without worry.
> > 
> > It would of course need stubs like these in a shared header:
> > 
> > #ifdef CONFIG_CXL_EINJ
> > int cxl_einj_available_error_type(struct seq_file *m, void *v);
> > int cxl_einj_inject_error(struct cxl_dport *dport, u64 type);
> > #else
> > static inline int cxl_einj_available_error_type(struct seq_file *m, void *v)
> > {
> > 	return -ENXIO;
> > }
> > 
> > int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
> > {
> > 	return -ENXIO;
> > }
> > #endif
> > 
> 
> I had to go back and take a look, but I had a shared header in v5
> (link:
> https://lore.kernel.org/linux-cxl/20230926120418.0000575d@Huawei.com/).
> Jonathan recommended that I instead include cxl.h directly, but that
> was pretty much a completely different patch set at the time (and the
> header was under include/linux/). That being said, I agree that a
> header under drivers/cxl would make much more sense here.

I agree with Jonathan that there are still cases where it makes sense to
do the relative include thing, but cxl_pmu is an intimate extenstion of
the CXL subsystem that just happens to live in a another directory. This
EINJ support is a handful of functions to communicate between modules
with no need for EINJ to understand all the gory details in cxl.h.

[..]
> >> +Date:               November, 2023
> >> +KernelVersion:      v6.8
> >> +Contact:    linux-cxl@vger.kernel.org
> >> +Description:
> >> +            (WO) Writing an integer to this file injects the corresponding
> >> +            CXL protocol error into dportY (integer to type mapping is
> >> +            available by reading from einj_types). If the dport was
> >> +            enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> >> +            a CXL 2.0 error is injected. This file is only visible if
> >> +            CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
> >> +            be able to reach one (or both) of the CXL_ACPI or CXL_PORT
> >> +            modules to be functional.
> > 
> > Similar comments about dropping these details that can just be solved in
> > Kconfig.
> > 
> > This is next comment is on EINJ ABI, but you can skip it just to
> > maintain momentum with the status quo. Why require the user to do the
> > string to integer conversion? Seems like a small matter of programming
> > to allow:
> > 
> > echo "CXL.cache Protocol Correctable" > einj_inject
> > 
> > ...to do the right thing. That probably makes scripts more readable as
> > well.
> > 
> 
> That's a good point. I can do that, but I think it may be better to keep the
> consistency with the EINJ module to simplify things for end users. If you feel
> that isn't a big enough concern I can go ahead and modify it.

Oh, definitely keep the old style as well. I was thinking of something
like:

echo "CXL.cache Protocol Correctable" > einj_inject
echo "0x1000" > einj_inject

...having the same result. Up to you though, I will still take the
series if only the integer way works.

[..]
> >> +	snprintf(dir_name, 31, "dport%d", dport->port_id);
> > 
> > How about dev_name(dport->dport_dev) rather than the dynamic name?
> > 
> > The other benefit of this is that the dport_dev names are unique, so you
> > can move the einj_inject file to:
> > 
> > /sys/kernel/debug/cxl/$dport_dev/einj_inject
> > 
> 
> I didn't realize the dport names were also unique. I'll go ahead and do that instead.

Yeah, you can assume that all devices that share a bus must have unique
names so that /sys/bus/$bus/devices can list all of them without
name collisions.

