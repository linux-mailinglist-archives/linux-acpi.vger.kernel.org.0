Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C73B68C61C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 19:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBFSs2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 13:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBFSs1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 13:48:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB34C196AE;
        Mon,  6 Feb 2023 10:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675709306; x=1707245306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ewk0ashiigVyIDAVyNytS5Z7BtmLoaiJelhxT8btPY0=;
  b=c+peKxXu6aQPHmPtjJs0yTb0Y4xSbtTS8UmUghwBE8gTByX8ETlXAUNL
   3LerQDvD23NNbZwTkDJiIgh3LdyRZUjwwSFaD9Cy9QQR/zkJAGu9Pcaw3
   88la8v40lqK741Ai1evBFhD77Y34muUhpcixYDl7TqEJ8ExwwbHWj3FOv
   /fg1rL00BKacP9lruLPmPvHHUL/BnJGY7izlUWIxpxlKTrZtEtJIo77j2
   XzRTnscvI7gr4oz10cBk6DAb90F+e+PFTQLlaG8mbyV87v0xZq5aYhnD0
   DXX7B3GyXc/uM/iOK+JKQDxV5mVK6oDkK0+kZIFvTlqccVs8Eijg1RASR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312938893"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312938893"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="698942722"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="698942722"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2023 10:48:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:48:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:48:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 10:48:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 10:48:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8bcvStG0lgAYhPzDNXtwUqRYUACM4PY/smiuk942fc4AD4wnGe3PlCwp1WBMLSuBvHEHO+KuMraMVutC16/TXqOPYZzYxoGgZMDdC+hHe6InwMxz8zxW3TW6w4HkcpNvn/mAnSmeWbAgQAEZgMqFEsD3+Z/BXwxDygiS7AddK4N1LjOZTi7rOxDpopqKF6xNzYgx914dqo49Qvt4n76VIncF196HHgAjTKmJTduTexrtXBHcVnW17CnE6d582SAAKJVOsFcE2eb7XWXqtwGsrvJZTls4hjxyQRynNTVNbfstErD7q4fLVCPCykZAq+ska58/EfRqmpN56dFndscnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aBHiXpsv7KXLt5yKDCSHdiTJ7XwjnXFs7KZmRIJt5w=;
 b=I7nAlXxdX6SMzJ9LN7kwO0LXlk6LmPBOP8RPs1COSBDxYzqFzWq+Rs5xgiKE24uCPRVXCFWjvqKX2uRuQsSaN86noNQpXKn2X5V8xF5yywf/ct+40pWsbdIKKJQaQwcuDH+aIQLor8MkDtqP0c+7GXvwdtEYubjLrcISSFZI9S1/gwbbOfep0yYnmKBcQFJ1GbWQLYfQXfFgv5xDc8CvT3KbJCjKCJkUp3WveQyEZibpkRpNtM6sVJMLEhgk0rcVuw9q5zlgyapnXc5fEYqY4HrGXbHOioTEkVJGBgW/mMlGDQovkcPcdSJnDbVjmALzVQOxtKPUD5tstoQS7xvclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 18:48:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 18:48:22 +0000
Date:   Mon, 6 Feb 2023 10:48:18 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/18] cxl/region: Refactor attach_target() for
 autodiscovery
Message-ID: <63e14b723009c_e3dae2947b@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
 <20230206170636.0000739e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206170636.0000739e@Huawei.com>
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: b984d323-4ba2-4ea7-694e-08db0872b851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMpjCdkOGcobtCqLjPET7LrCHSpj72XZXfMsjMn89EPFQAZl0vvNCnNRXIMI75JPkSRLVD3iyY+ALRO1OqiYxKen3NYuXJH2tj6tJoujxN3dqCo+kgQFOjEAGDy1Rhe4W8USGSaVn5EC+370MtATT63gHBNSSHMmfTPclfRnTTX+ba791nNenRKQ/ygzzvx0UyDmDWlhpJ7hr3N420i15CZEip/uHo7JksX8VNKyWyTvHp6MaIFtSBGrNWel0IVyhbWBAs++Rbc3xLoyttyRe39O7KEugJ0WRJ2FkebGOniuFZOJxr8VtdBaGZSv0gt3Slmj+Oef0Rrk5fySJA9IqFsvuOUL9hm6f6kqZVrNDQK3MF32OTC3ZHGr1JcccJB2bEAOw1UP/eT4DRF0qfRbvNTlA6ysN81IGVJmU8ry1sksEGB86CkVyn3GSuFwzD6MHUfPlWUN1o3m/FqUtdCzPM5rTP215JkiQaShRPWLWC5kMOh/73bPGWPaw7tf5V6Hj5+OOxPBL0yl0ZPxpyn6jRv+L7xnjc6aE0Rqe82ZFO0uUVJdgsQx2ahONp5I9aA3k9lz0Hw0Z+BMVuqIPNsfif5QkWnvBAaeDoj9r2ZT9+DZU+FX+43FJmXy0cir+wY0lsVXtQBfZG5oLlhZBcKFgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(478600001)(66476007)(6486002)(26005)(2906002)(9686003)(6512007)(186003)(6666004)(66946007)(8676002)(4326008)(41300700001)(6506007)(66556008)(5660300002)(316002)(38100700002)(110136005)(82960400001)(86362001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jEfCarI/jvakWGrtHbO5Oid0e5PCRE8uJVnFxsxUOJu7cacu+K9nsRdcBgnC?=
 =?us-ascii?Q?wCyNV7wpcZXCT3VmVCeP3YqfdlUwAwVgTdWDvzicVHhZfCVOt4DwHma7nd8b?=
 =?us-ascii?Q?vI/zVJjyE03sn53AW1ddsddl3zRf1HjR9vhqhR6lyDOdJeWu2UK+t22b4QJu?=
 =?us-ascii?Q?YmawL0vfxjXqBzNWrmCOvI5jDrWXa883fMKuSl2FIp5Jw+yX5Esn/XKsElxW?=
 =?us-ascii?Q?p3PVJdN2CDalNeHcebTjxOSFlXmqEF9lkkXF7EvdXFqxkCHKWhWlMxnrEonz?=
 =?us-ascii?Q?tesEZyvbpSM1nnrIrTspK7bzhSYeqIkVhw1zvHSaPNypa8xTGYwppIuCEJ0Z?=
 =?us-ascii?Q?d5Mw8erBsRj+HfQ3ViZP1YSFej8IXaRQ8Z9ZG4sGiu0ynHG2PDL7QEEZFYBi?=
 =?us-ascii?Q?uHd7iv7dLpWkAucE0eSZJEmNq5rICZyBqCUByGBqp9gtaJeWaE7bDhWYvVKZ?=
 =?us-ascii?Q?Vm8enGDXOIk29aElVJj12q1VBv1Xewq0WV0FhSgUgOFTVPTa9fhz8fWxQ4xb?=
 =?us-ascii?Q?/lXD5mfVZ5CZnYXTVk5UDK7OGl6uy7FpeKbAhmng0CIflcEQvFduT0jzrOlO?=
 =?us-ascii?Q?RBWEu8QsH2E+h04bowKu9Tfp3qu2ArRwLXXfHH/+G3oraG7l+1DzkblNV5Om?=
 =?us-ascii?Q?sfNPxXPUiMaqQBJ2k8b+aTTwdcIhlA1jJwcJ8+axjGW4CV7MXl+GkbTYGbhE?=
 =?us-ascii?Q?/jUZJnzBa61pzYZwgfCNBJY0CBoxHVM9TIR44+PL87OpmdGCML0SUu4z6UPT?=
 =?us-ascii?Q?ab91eFm4ZnbsgJrLlA0WV66KGxagUkYYLznKHGK6LEgnwmsEztbwyTqYOPVg?=
 =?us-ascii?Q?8VRy2VyxmeUhviOt9LDHqYFXkXeGjUmdIjNDQRNLUCLOCh6JUp/Ef1b4ZrX/?=
 =?us-ascii?Q?SxbSnhDVWt1ZRTGdQ9aAmMoAv5JWvvbQANw6gOdIYkFfsMUIUfCQadSK2BJR?=
 =?us-ascii?Q?hG92+r0tLTmRfilkyjXTXyGCYfXFMWF9+saALCjh4mB1U82zt3yaATOeKCHO?=
 =?us-ascii?Q?VZmjCUATnJPiD0DXFuL7Bu2mitv03YaPGCn+KT2rQQi8l42yI17gJxe/cpZY?=
 =?us-ascii?Q?8oY6o2R6d4HsLG/HHxRYBS4lWH2TQpiOiejy13T1VNHJXOYzw9y3BmwWlCde?=
 =?us-ascii?Q?95roa7rm2+vW2nU3Ja1W5x8VNHhbp2h9fu3F3S/m7os1kFUHbYIIfcoWf9yU?=
 =?us-ascii?Q?D//eULybqXotq4dr3M28JVrYJBUMVM+7K+QLxbPsMnJIazDRMlftFXv7NXWD?=
 =?us-ascii?Q?Be/Cejn+5gNRHUegJVWfk6CoQrAFD6gXeK3ynxyrx+/1Btf1OYnlBC+bqW+F?=
 =?us-ascii?Q?kvLiJ5SxHReuxCia7bAey4ua5prrgvDZZSxUodhvHpXuQ3oC9A2ZVt08q67N?=
 =?us-ascii?Q?EoKooSUHUP8hxqvgJOBFpr9sQkbq9TuvUm7cQmqvuzr61NqDySZ2IxLKaEZ1?=
 =?us-ascii?Q?o6i6BaeLaQZQXUkGsc4VCft267o6O+W+DseAE791mIwL4hmEU3DtdDzuRZqi?=
 =?us-ascii?Q?za3WCY1qGvdt8LLpI7svSfrEv6zpGWoMco++x1m36pRiupFNuF2P9TIdvjgf?=
 =?us-ascii?Q?7k+D8DuGlkt7ZFrZlEQDY4iNx6UaqlGWT0B5w1QD4TRDmMf5u0WshzkH3Ea4?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b984d323-4ba2-4ea7-694e-08db0872b851
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 18:48:21.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+ofq6xAYGvVsorZl22ifahNsY0Fo9iQTBMbljS2bkqDp+nHIosJjP2r0pSypQct1Ruu0TOcAngVPtknxFp/83+xBthkI/kXF+6GvdrOms8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 05 Feb 2023 17:03:02 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Region autodiscovery is the process of kernel creating 'struct
> > cxl_region' object to represent active CXL memory ranges it finds
> > already active in hardware when the driver loads. Typically this happens
> > when platform firmware establishes CXL memory regions and then publishes
> > them in the memory map. However, this can also happen in the case of
> > kexec-reboot after the kernel has created regions.
> > 
> > In the autodiscovery case the region creation process starts with a
> > known endpoint decoder. Refactor attach_target() into a helper that is
> > suitable to be called from either sysfs, for runtime region creation, or
> > from cxl_port_probe() after it has enumerated all endpoint decoders.
> > 
> > The cxl_port_probe() context is an async device-core probing context, so
> > it is not appropriate to allow SIGTERM to interrupt the assembly
> > process. Refactor attach_target() to take @cxled and @state as arguments
> > where @state indicates whether waiting from the region rwsem is
> > interruptible or not.
> 
[..]
> > @@ -1418,31 +1418,25 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> >  	up_write(&cxl_region_rwsem);
> >  }
> >  
> > -static int attach_target(struct cxl_region *cxlr, const char *decoder, int pos)
> > +static int attach_target(struct cxl_region *cxlr,
> > +			 struct cxl_endpoint_decoder *cxled, int pos,
> > +			 unsigned int state)
> >  {
> > -	struct device *dev;
> > -	int rc;
> > -
> > -	dev = bus_find_device_by_name(&cxl_bus_type, NULL, decoder);
> > -	if (!dev)
> > -		return -ENODEV;
> > -
> > -	if (!is_endpoint_decoder(dev)) {
> > -		put_device(dev);
> > -		return -EINVAL;
> > -	}
> > +	int rc = 0;
> >  
> > -	rc = down_write_killable(&cxl_region_rwsem);
> > +	if (state == TASK_INTERRUPTIBLE)
> > +		rc = down_write_killable(&cxl_region_rwsem);
> > +	else
> > +		down_write(&cxl_region_rwsem);
> 
> I'd be tempted to do this in two hops for patch readability. First
> make the code reorg then follow up with this bit before the use
> of it in the next patch.
> 

Sure.
