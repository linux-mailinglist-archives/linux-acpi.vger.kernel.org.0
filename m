Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC16CF5B6
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjC2Vzz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2Vzy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 17:55:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26763AB;
        Wed, 29 Mar 2023 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680126954; x=1711662954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sVs15ZHVhlFm3IzgwpOKJLJnryhQa0LttW62gZtunfs=;
  b=ZppVzu/ehdjxgweGhW1rso4ynsogSg5quvoaFjbZBS3qg/c661qZqP+F
   1z6yISabk/kADDwQpe0soIqY2kAgni003iUuAOcYWynU2McongESHOc7x
   OwS/81MUyxWDKnicuMftOLgIp2qIJtqvDDW3OGhnBLpvaArAtYacfQH5Y
   iDS41zEU7ZxrW2tuMQN4WYHirFLPw+wgBS2cYl9NOM4FSIfDgDo8nDnJ0
   JC8w+IWlTl9OqS0QUQ15wca5xE+/WX+AIIDSHY8Zud781dekLcQone6+o
   HIqm2IBGMeMRI54yxZukwdCx+ZQPkhoX2n31Iq11a82g61W9e35lpykIz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="405962067"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="405962067"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="808390287"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="808390287"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2023 14:55:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 14:55:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 14:55:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 14:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLxGBcDf9JCxPL82z2EtgJQF7NQQx3g+mhD7M+MV8fngrJseeAJ/t/mQj86564q3Bd8TQe7FkI3CM2sSdgn5Ew6KspGsp8CxjAVebbdPF8NkvkTwwoGi7l7UdNKS7QfjGyH4DvtlRsXssYIkfEPRtm9OwF4Dh/aVWaz1in9TLyYhhOHZUCZWHQPcxaFkVEGkd+FknlxIUc+Bbq0al6jmB8uPlorjw4IJsFpvwQ7VA48G4e1X5AM8GaIIEvDt0RSp/Bd+Arq78o8L6Tft+e3qLglijrX4A0dc1Wd+ogHZHvWyztidVQnLxH5sQlP9pDUZo8dpANHPh3/o1s719YCZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4mn2hvb9JQZ52VZiglQuFX7CxXk5e0npMBYHLXooQA=;
 b=MUFi+ruMtpKCNlHYLxiyjSV1ZzK1GlOAbLyv9ybfwr6ZiXUJ7UhHByZP6WcUJU6bzu4EhacLLzkC/T3JaG9O1IkXrd87UA3J8dolA694/+DirQhSM9PFMLXoDqRbX2C7AHTSox41v3qoB8QVg9f7JdDnXNQnXmjjLGXT7ywDe8EvuHrqlbPvO1iBjTZ/VO0bvJwuWoOn14AGNLqlRobZdlY/OrK+1YzrT5lUWJ6yEW19ZdzyRQ1ZdS3/yoySPg/mC0R/K4Qkbs2qGYMpuI8Zcb0H9gGkltdyfNtviBFi9j3IYQkcV9vwOh3Ek8a1a0Xr6V/7LlYzBCUiIZ04Mef2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 21:55:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 21:55:48 +0000
Date:   Wed, 29 Mar 2023 14:55:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: RE: [PATCH v2 20/21] cxl: Export sysfs attributes for memory device
 QTG ID
Message-ID: <6424b3e14b1ac_c722294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995356611.2857312.4634198260468536572.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167995356611.2857312.4634198260468536572.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1e93cc-e3ac-4ee8-807a-08db30a05ac1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/91UuCzHS82iYudWcOBqJF7EE1WrgMKGI6KiWAvA/C9zJpQCxK1ogHEKCRJZgwz4V3pOFWvBanZtEfqedvCCJeKc2Pt/bq5bl/6SYNYIx/xP2S6f9VJsqjO6dil+9iqciHbUvYUuRcK4pDej3xy7iWjfN3oX7DONT6XejjJeExkcpVex52xIlalc1YfVxjVBMf8x7TkeJPnkYc9AFZao/o/4wvtgnZMBkK15jayMikiFe+tWKA8N+k4DnXlzadlWgJUXS0Agex+E7KNqTLCvej973BvZ/fmp0JGddeAlVpkkz4+evbNwpHHNDvMEaTK5CPXf9smOsqLk15FrLiALWRYxTtLb+TeGu//6JICXa0UCFj69VRkcQCk5eSfVGr9qur/9HQs8j5eXYQBllodDufHdMhEqwuHck7IrUUFQll2FQf+Zoh3GXA215VjOvOWW7lWqdmRuxmqe3yqVp9VKy8Aa0mTiy276WZE6lBfdxLhZgHVFmxpZr9wXWXOVniCe/rgE4WOeSUT6P6poQOlg3O7BuK6s/2lXpsR0b+LJIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(316002)(41300700001)(66476007)(66556008)(8676002)(186003)(9686003)(26005)(66946007)(86362001)(478600001)(4326008)(8936002)(82960400001)(6506007)(38100700002)(5660300002)(6512007)(2906002)(966005)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?myo/ui/ZbtX/VTB8Utotvil15mdemJDpqCraUOJXcIVbTEE8Yb5t/hvfRXQh?=
 =?us-ascii?Q?a4FcPGiZZx1bXQHHNgikhIHA3yIdldyuYHxQqa0bI7I3g7VB4Bcp61U0iPwK?=
 =?us-ascii?Q?2H661TvXyQXe6ShiS3xqXzVLaZCCKx6f87rd0d83xeIJJCL2zWe47hTqO2L2?=
 =?us-ascii?Q?kcWX/JGavk7OycEw9dUY6cc4ed9t9VX1n15AHq+szcJj6EPtLfrICRzRqx9r?=
 =?us-ascii?Q?brhhmazDPXw7mZP35477B3NiZ3rM81L4dogReI1qDCMaAOn3/FcjakUg41wf?=
 =?us-ascii?Q?FrLGeOZS9VwgMr3Q+kl+hjcVwtLox3Df5RIwQImNfIr2UERA0RAAA86nlwwb?=
 =?us-ascii?Q?YJssyw88EOXIz/C3Zq38ffrOCEVffC2j3DHsfpqRsJRx0Y5VTG0yZZLo+3Xp?=
 =?us-ascii?Q?eobzeEyE0cCE4U2Xh8YkPjAmCgs6jaFGJkFfv1LcH/upRDXbFOeiBzsfs98G?=
 =?us-ascii?Q?FMPbJLY5rg3I/0mXCfvzq+9QSvtgDL+nBAJ39ua1HRw8BY/M0URhXePLU4UU?=
 =?us-ascii?Q?ZF05p/KxJCPHRPEBMk3Y64kufqGwu3ZAnE9tdTV2ZLAiZfu+FmUcPlOqbBoK?=
 =?us-ascii?Q?xbBQu+Z2OOew7upOr3GvUsTiFlvikB+5Xg+4TNLZhs8uC9WXfUe8KLHTxep0?=
 =?us-ascii?Q?eM2g4ijrEB4LvzH2zsYKamg/++gQ3gNZ6IzrWZd8nGHSTjZDxQKv/u1SoXaU?=
 =?us-ascii?Q?8K9ANyuWjTqq4tMrniJqdWIY/Atox7xhs30WUbpITrNN81KgqjhohkX8ca8h?=
 =?us-ascii?Q?GQTIIDZebjl8XCbwL0jSRjQYCAZQfdo/AltMKbys0JKAnBSH3Ph3RuLWn2Mv?=
 =?us-ascii?Q?9mYRunfJ5CVq3sJwT8HpvIktGoM72M7pSIr/28BsI5k3zclpcxO3k9z0TGo8?=
 =?us-ascii?Q?vawwEouYj51iVkx0b51y2BrZ2g1yvIErK/17oOIYmg3GpWPupO+CNv8+7vde?=
 =?us-ascii?Q?aRcRg94kwY1X1+iuBXVHjBCe90XbaZ4kTQNkFYXX9tylFoOwghjg2RpFGxOg?=
 =?us-ascii?Q?4oGYXqnkWiYtajxaVDItXuqUAViyT7KqJFBA4ZE+dDcDYDoTqS7yfrkjwAce?=
 =?us-ascii?Q?U2MuisiRryE81z1abPPIK0sv/NPeMzZj/9BazvyEyzdAeTIunA1ITk5qltGf?=
 =?us-ascii?Q?vsII+dMDtM8PzidVxyabU/+TJT0tqlkkoDtqwDBqkUfA41gC4955xPR9EhnQ?=
 =?us-ascii?Q?Mj/o1SE9udmR3KHqMm2vis+REmxBrRvyHadJm6ZxbOOj/YHeBK3TqpdC1Fso?=
 =?us-ascii?Q?+H1tPJNsjCnJ2EzQaPER681QMrHZPT6iPhTVNFAuaiKrRBQlvCKJT3Snz1jJ?=
 =?us-ascii?Q?WWggIYUNFaEAVYcVa6v5oR2WrUU7wL5Hb1YKTZcuSwkdzb5hdwH14khmN8sq?=
 =?us-ascii?Q?LKyBhc6pd8BdefY9RnWAt+oTfYObnFvsA4DfMKgXbbzyjC4BYzDLvKHLw2Y6?=
 =?us-ascii?Q?PHKGpkUO4G/H5PqedpgX83BLOrvdwnBOWr+7CfG8VMOA2AwPNommP3OugK0K?=
 =?us-ascii?Q?kAYFFfTRPJNx6Qs+Fm01sdHin8fmWYZIUiZ8ipLOWKDOJMM77sdbzG/YsW/q?=
 =?us-ascii?Q?7LUKomiONdW1CCX1ifu3nIp60P3LDyMpZ5f1Ba5AaxGJwCs1L7YiRm1jrUIC?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1e93cc-e3ac-4ee8-807a-08db30a05ac1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:55:48.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24OkRiooAbpKryVTaZ6GV4VFcEzId5O5Z5tIDSkXcQmH/30VWNEB3Xaktqk79fCcenia33/jCETkVd3DWTzEh/EEsgODYqdRLEpcZCINvUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Export qtg_id sysfs attributes for the CXL memory device. The QTG ID
> should show up as /sys/bus/cxl/devices/memX/qtg_id. The QTG ID is
> retrieved via _DSM after supplying the caluclated bandwidth and latency
> for the entire CXL path from device to the CPU. This ID is used to match
> up to the root decoder QTG ID to determine which CFMWS the memory range
> of a hotplugged CXL mem device should be assigned under.
> 
> While there may be multiple DSMAS exported by the device CDAT, the driver
> will only expose the first QTG ID in sysfs for now. In the future when
> multiple QTG IDs are necessary, they can be exposed. [1]
> 
> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
>  drivers/cxl/core/memdev.c               |   15 +++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 471ac9a37078..a018f0a21aca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,17 @@ Description:
>  		affinity for this device.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/qtg_id

Oh, I was still thinking there would be a qtg_id per partition type,
just not a multiple qtg_ids per partition type until it is clear that
those are something hardware vendors are actually going to ship, but I
expect a DSMAS per partition type will be common.

So I was expecting:

/sys/bus/cxl/devices/memX/{ram,pmem}/qtg_id

...and when the DCD patches land that expands to:

/sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_id

If someone builds a device with multiple performance classes per
partition then it would become:

/sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_id
/sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_id[1..n]
/sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_range/
/sys/bus/cxl/devices/memX/{ram,pmem,dcd[0-7]}/qtg_range[1..n]/

...where I am using CXL 3.0 Figure 9-24 "DCD DPA Space Example" as the
delineation of the possible partition types.
