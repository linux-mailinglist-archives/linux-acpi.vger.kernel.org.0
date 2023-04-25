Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14316ED947
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 02:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDYATA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 20:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDYAS7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 20:18:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13DA5585;
        Mon, 24 Apr 2023 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682381938; x=1713917938;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FtbTd12ILj5SbSLAUrz87H0OO3dlLSa4HjOxR/pMjpE=;
  b=KnM+iz+1pKszIrMPMJ6tp+p7eT35ztaMqJuT6XrLcFMjj/dBikB6vthQ
   OQUr7e4qCrNqidPgAKJyZnf53EdMPYvQzsF/7AXkEU/XtysQYlhF7QqMj
   yBbpvNickiI4lmhnkTYBFQEmD4nHcIZN5N79kLztwetWNqQ5SkuIQ9dQv
   nYGCP1+M1NZzJbjOLMmWdsApVREOfCXjYsrQv0S9FZ2T0mhtLGvTfO97S
   Z0e1OrC70ud1Bb0bv173H06hACl4q1S57WMJI8NcMAZcssrgkqQfabvOc
   Sc27+sf3P7uB3GTBuBMrte2QwISOdN2ClVjuokWPQb+CO3Y5qmAqsarPU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345355874"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="345355874"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="804821964"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="804821964"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2023 17:18:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 17:18:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 17:18:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 17:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv8km4xyFKmpf7WfYzy51GirSOELUy9JoXEzWBsTQQY+3fRfUktEWbgd7CoIDcVAuTkE+bPb9Q1B9dDnxFYdicpgV2EB7STsFQBqUYqCjHi597VMGSUoOfEPVkDTjiZk44/WHUnBI6f73Yfa2thsg1GRYDnPhrTQIvZUaCODhnGFehV4TjEDNj01WLTpwo1xL5ZP1mVgNLKvwL8f6bsKh8kHeMHHC7Tdt2Wt1oWker/GAjD8uzWf6/LpQIHoiGhSHqj3FXmHva6hIpEDBbcjO77ms/09DtJ8ITxwlEbUZdSecwFgCsHrMbdSXwwPbE4J+1KOiL6ZCEDuXlj59IAw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcEGbF3FhnIrvT/kMS4uNVYIg8+1gq/oaYn8vRDxHZk=;
 b=VPmjrWm9jE8YvgthWRVW9hX00ZGBYpHs/1prfvxOUDwBth+dwY7O3Ib8aJnvj9VH98zFAFlXslPpQswFXnqSXJjbOtcwcrzyNYphi3L7soHvSOamg0HF3AY07ENA5oXs4OHXpOPKRqKDfOG1GhmG8CPHBlCMrTxJ1RNerV9zoGQ15v8z3MNKglmiGmTsmLIZ6RsL3npUEKNHu9FDyRANYJGAN2YmUzIWipySdHJ/SluLyM4DxUvlg0ZoXHlWCkrmGdlE1Q+CwBSfZNdzopZzylhyG9xWC2ajuWwtWtL5KjDm++U6rq7K00cRyD9ePGDwsDhQ3o7Pv3zfgn0+aBLbyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 00:18:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Tue, 25 Apr 2023
 00:18:51 +0000
Date:   Mon, 24 Apr 2023 17:18:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 09/23] cxl: Add helper function to retrieve ACPI
 handle of CXL root device
Message-ID: <64471c688be8d_1b662945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193571575.1178687.18078745201457493723.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193571575.1178687.18078745201457493723.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 224abe4b-37bf-409a-59be-08db4522a55d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJoxOgSbvi02W3RbdPBDC6DuKQnK9rFkQ3VK3nUNSTnGdfiuzNSfWiU8xGQs44TyDctpoittL8uv1Zf+GN6B7iLHFmfZSZrqvgC426o+yShxfNekqOLfS4SEb+SuSsAwkQWslVML3hDZVJNOYRMGW1AGxLBgWvQ9ZL1wpS22OXsGTc3nhJOTaksQpg6E3tlAjGmP352EnckmO+B/fDU2jgmFnjeD9BHDpYrEZXC8/BUqtl2bBinA5jWuCQsjjCK3QFuzAjv0vSkalNQRk/y2Lf1MRfO+AAk1vIzy9RZaoxEoPqCmVbnkcjRPByJZDOBtLfKK8/RKqYkOxEAYpOUT9/7pIKgDtlHdCeP2mXAdDCL6lSildMSO+5H38YtIsxgZBemz11FKHuxVAMn+6u4mkpoifEa+s2H7DsLiCk1FzxqpiHiNqq3HmOMvDYyy3I9ROAvWHZeK6ZgATs6VCf/51/HsNYaQr7P6dWoGXcfx3MTdfyPHFkM8ahySDaUgj8fb+/AKO+11fz7YIhRYXxdai/QhbeoHmSy0M5GY2qmdJnxEp8+jjK2D+sVdAtxMZOWm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(83380400001)(478600001)(6486002)(6506007)(6512007)(9686003)(26005)(6666004)(316002)(82960400001)(4326008)(186003)(66946007)(66556008)(66476007)(5660300002)(38100700002)(8936002)(4744005)(2906002)(8676002)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PaaR+qDaYrM1k4vegmR07NxTooqvKKP8BDFAaiSc1ZunzsvT5mXfPDGqvS/Q?=
 =?us-ascii?Q?WkpllkNb5E0WW25e/G34BY47dJ+XFYRNa0WMl5Zv+arazybyhpXatEU5Pl4G?=
 =?us-ascii?Q?wqNdWF+SwiC6U8s2Mog2eUVzTuIP/HDWh0Ir24eKc9mXr6meUq0vEm3eeNNt?=
 =?us-ascii?Q?d5URSjhfc+8swUEBJm6eifZUS7pIb3h3Lx16FTuuB7tvxaMPmKxX0ApgW9rl?=
 =?us-ascii?Q?UQOwdb9AxBmZyapEmI7MyatUGkNjIAi93aGL/0hAICsCselo0507kUGDXUmP?=
 =?us-ascii?Q?tJ/UO+zL47hTiAtPLdFsQZZ6kkwPKOxn2EO5B30Xxy3WM1+BH7CS2IDMHQdV?=
 =?us-ascii?Q?BjXI8jsGHn/yPWAajdgJCoHer47/qRtePvp1n1X14VqgCBnXfSGNLPC5tknK?=
 =?us-ascii?Q?HxB/vYa0+TloonaZi1SA8WKufbluw7nIC5FSgqdohejTs4EN7qJ8/WfLj5g6?=
 =?us-ascii?Q?RRlYXKPAmbAXTcV3MtGBibze0FG3Ca7eLbfyigMkwCyl8dZri2cfBWOWybO9?=
 =?us-ascii?Q?rx19z5gTYldbtq+gCIx2ThXCTNJAlYTsEQFcX5ZUgDw9Xv1HIYqZBwbUCC08?=
 =?us-ascii?Q?DkEwvLlryjJTV5I1OBxf0tP7elkTO2bSsiHShJdH4Hf7/8z8BnY72Msf12E+?=
 =?us-ascii?Q?THQPdUBqNtHWMnKBQOtOIm8PJzU273pRV6m3BId+pAB+QY277fCq+dZ/ciH5?=
 =?us-ascii?Q?cfCZCNBWY1ao/VQOHX+/iv7rIYV8MHB0vOQz+ZVCoPbipG1LtFyLdIWq5QPH?=
 =?us-ascii?Q?vo/7BazNlRwm7qnvDwdYfYkJkB5hyv5sfeBzyjmb0jc+b54/NxvoCgqq8DBc?=
 =?us-ascii?Q?9jtyz5V3eMKkbtHobu26+FouCo94BrUWFaezBkgffyNlN4/bmHQ1CNYZrNRZ?=
 =?us-ascii?Q?fLh2n5VE3F8S8ilSMffFQgxro99J1MDbF92Vl4GGmT7eRuchD4Zhcs2HUQMj?=
 =?us-ascii?Q?7WGtrIuZnuvN5fiLvMlpoOP+1yOeqRp/ghaPlRQJzbkfYuAoVV2yi0PU1K4J?=
 =?us-ascii?Q?9xCg1niY3c9QKTXxZrxApnkBGVa04nxacEeqU+tpgHUeIhknrxfSss1FzV0z?=
 =?us-ascii?Q?3aBr3g0JeAJgiUaCCqsri/hi7//d9jFeMoJnEQpGJKrHYcPWqGP0SaA21Ya9?=
 =?us-ascii?Q?yC3QMlUWJQMAVBm5mMy7vm3YWaVivqKjxb3eVs9iVeDS1hQmZoGvMawcgucU?=
 =?us-ascii?Q?nuNgnwfnOZNz3B+6O3AVI/UwSea2lu421ElEerrG90YWPG/bwBhBApkHUWYD?=
 =?us-ascii?Q?JjW4wAr015OTKoJt5Pjwls22PooRS8ntTx6EhpHhgoyxFOhmBHBT8ngWMdKV?=
 =?us-ascii?Q?h23FIedW2cdPO6zAJSYVv0dB0GqhiWIBUE1UHAc0vJweAMw1FQjnoQ4bChIU?=
 =?us-ascii?Q?uTNuTkC2Ejm/NCBmukmyfmxQwdcfqtbbZzXluX+vjyDL7muVqAxkYfHi3m/0?=
 =?us-ascii?Q?KE6iwxaZwxw1jEYZdLYmAxSh8XVXEMBbYRzAo5OwI+NxUFKK8Ni8P/UBuSRu?=
 =?us-ascii?Q?wmluyzeNFABpqQGLo9v8pN9/hcxUelteKVPpbkeyvNPU+rfa2rPk4I8t25pg?=
 =?us-ascii?Q?hEHwEKSdpbv7P8E6/CDSpkb26sd9lyNhiO2UdIfPGP60cDUskJUBY0bG+Lrx?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 224abe4b-37bf-409a-59be-08db4522a55d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 00:18:51.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWDJWl7p6MbK46D/i496iWph7XnK9MeMe3lDwxF1E35kczj2m+lpAzj2CEp7DN+PZDxqjGxsP5FGGnBRrVi65KWlKduP+RjV//9v1y7o9a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Provide a helper to find the ACPI0017 device in order to issue the _DSM.
> The helper will take the 'struct device' from a cxl_port and iterate until
> the root device is reached. The ACPI handle will be returned from the root
> device.

Following on from the last patch this should all be self contained to
drivers/cxl/acpi.c with something like:

struct cxl_root {
	struct cxl_port port;
	cxl_qos_class_fn qos_class;
};

...and then the caller does:

port = find_cxl_root(...);
root = container_of(port, typeof(*root), port);
class = root->qos_class(port, ...);

Yes, it means finally creating a formal 'struct cxl_root' type, but I
expect it will not be the last root method that gets added.
