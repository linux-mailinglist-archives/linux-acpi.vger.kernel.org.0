Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1D6CF7D6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 01:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjC2X5M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 19:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjC2X5L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 19:57:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610811FD2;
        Wed, 29 Mar 2023 16:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680134230; x=1711670230;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ioxoe18jIb5Tg3zgHVI0KmP3p7CNEWhsqU5dUtdmNmY=;
  b=Muz9Y5U1epM8FjQ8cpCe1vTd16jaJSg7IWAK8P7zqJiRcZK16LY2mHDx
   sIxc/bp8xuyE/uy5B+RPYPYJIUsXt3A+dZJG3kvKJZBs0ogr3ZWIBD8+w
   2bBUBDxMQw9VDO7S/Xl2P8/iCgu8afDY85FE5+SklwFX3PNPo+Vk0vOql
   /WGZEeYZ8Qjjwc+LYhZP1eDIRL0bAYAxJEgpqcqZkCVX7k8eIrkz2HpTL
   Gu42RB3DMtSjH8TF7B8UVkMZRFf2oC9TX9xljMSDbVxa/TTPWqN6RckmK
   qX3y/IOvbUEjq6gvDP6uxoJmWXLTGnbDma2zyi0qd1Rxa7ECo1evsiFsP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="324948904"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="324948904"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 16:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="773776834"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="773776834"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2023 16:57:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 16:57:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 16:57:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 16:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf30p+BfiZiCLQbtEsD7lu0Cu1hZhDyqi45Ko2SbG0PlR7nVvB5xRr1+gSvLtqnDFEoLjhtLNoBEKSt9lRZ+HiS/h3nnOFt1fsU/HAG0ZAitcYBMO+VwCtv6uYjIR8qJy6I1IWY1lXGdaU468Xnm57jPcru6aTnO+OpNRON4HFYxDDWeOAMPG2yzpsvnfsVWtNkOZyvXSPSHpz5DmGh08wwVkoKhNefFISI5CBNhsYyxXi7mteJd3wRDRO5Iw0OBBlaeqYzh5rgaj4vhh83wTquc84Xhvk7T7c9GoK5SKWxi01tmg3erIXjrOIeYfdRwD8hfzRY4zTlLx0M2+ta4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBxOZc+UiK0ys8adUFBHQp+YKzcvOlzot3+RRca2VCI=;
 b=PWNAa5uvqToQVAiiBEhTkBSfOs29LQynB/AC0IWt8kIzu3cVxmTl0qBxZtnlMEr+aGJow0xZotxjozCP4LupPif8j1FtRzgLqNvccOwD7QWC3bk656pWWnK01vH0KTYkA1vbRfTklw4A8WQ0RZycvYm5saJaCgvTjpSKBbnvjfrii/3TJsDmnNVLt4eEPG03jNsc+c1pAWT7f+SZbmyLx6f0EO3F85sSGCGoKiI4dyZbA4ySKv2kC30XphR9f+JCzwOK5o07cGJeDes4FVSZOO0rlShIqDE5ouzKDtdD1RvyCk+KZPg9pjNo8XfKQrfVgootjly6j+QWdz8dQkBsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 23:57:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 23:57:05 +0000
Date:   Wed, 29 Mar 2023 16:57:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v2 01/21] cxl: Export QTG ids from CFMWS to sysfs
Message-ID: <6424d04c70bce_3652cd2944d@iweiny-mobl.notmuch>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995344806.2857312.16258432683708945736.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167995344806.2857312.16258432683708945736.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: b32ab7c6-0042-4515-5e9c-08db30b14c78
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP1qYoDasDcxEKg1vK9r6IXw59rcjmG/KLh+aGs0sHB3+/4fQAx8lTJDw6I5vJUONjvUffh08aI0gxu+KupO/yCAlxdYURZSdN+Wd73GxyFuW4kpEdDvd8bcIHE1yfFhnMnFdDqQXwiboQxHktfnU0+zqngpo/Y5xB8W5JbaB47BUNd9xEwfS9aqXvCvHOz4m2RCB6cNL4yzr0Ab/hGIiRDzZV2oYXc65X/V+6HJ1nBphp+YDRKvBezRLZS0rjd+nh/MBmrRs+/KuxCYtCyq0zrypQhfkWBZkIRRnI51mwWiL+Fx0UWP9leSzTsyAg3D0jtermgVYaMH5v+tZL2bbf5d9lBB4apNMd4rdrBKIIN9fqzUsY2EgA+9JSw8prM48/yM+SvFdk6FhRjxa+rek8tY6WmvNjG3h6tU9UCi0IStqwfWGiGJ5klEUrt6d9CAvenbuBgDD4hkYRc4/Y6N1MBMF2g9OvUSwHc/09UW+91mPF/qhiODsjV56MLvz0bKFhGF7uoZyH9eiORLErgFiPgh8vWojfJnIjNsciCvOaiGPWj9QKM/vd1XhCmFnoAv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(44832011)(4744005)(38100700002)(41300700001)(8936002)(4326008)(5660300002)(2906002)(86362001)(82960400001)(316002)(478600001)(6666004)(6506007)(6486002)(6512007)(26005)(66946007)(8676002)(66556008)(66476007)(186003)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cel8VoMytRKFE0lW3pgLoil0LzV8GisW+m2M4qIxjwLZQ8saAApkQYHm1AWN?=
 =?us-ascii?Q?57ra86/WKKwbSGUDevJs/QoOqQClJwASRJ/O2Vp71xWiSVMqbZnTC82G603T?=
 =?us-ascii?Q?ugxmxmUqw1JoWIFzKz5G0di0oNG5uci5H3L0xpX1ow2mys/g7z8gCheAYIpW?=
 =?us-ascii?Q?IvYyLs7nW2vsoD2gnAYZ3F5uHFH6e7wTiGLs/X3VNi+V7LBn/2mBswCzap0P?=
 =?us-ascii?Q?OMgYRh5VkvsJO0mmK9T6DC5h75Zd/JGJxinsQeOjtx0NKt+CjjxmdfIvSsYG?=
 =?us-ascii?Q?beT185u66jzcVHNwW3EOBXXKXEj23I85dfnWARyiE/r0QNDkr0NO92LfYSd6?=
 =?us-ascii?Q?iR24OQXS4Pc5ULz//V8pm9tv7yzSdevu8epgYHlkp/FRWr7QmZQRCXFCBV9B?=
 =?us-ascii?Q?nn7q4KXt0H19Yk8FXjW/quVxjy4SA9TpP/Y1wtKkNzYpuRERtEo6SOoXuunO?=
 =?us-ascii?Q?L+zfaXcS12TiypDUDaouU1X+yFTPyetXu3vA85ftilNrtwh/zKe/kALvGmsX?=
 =?us-ascii?Q?Tc9wgrkDeM/G6bfR38oziKTX9rvHhWQlzirUdo1sqXrtS/iMoVDO/1KPNSyx?=
 =?us-ascii?Q?qtAqbKYdxwGz8D6BZVzW6pxWxHFz9WBroxyoLc8HdxqI37SlsG+Pkz8U6aG9?=
 =?us-ascii?Q?6uchT8IZ9whoRru4xT4Uf/KIjoAsEMcs9JXAp5Rv/z/XNk+9s6t9hILf8dAs?=
 =?us-ascii?Q?C2pgJVcDL42zjdbOVM8BzGXaEV56nd+MLmFRzujVDnobxt6dd3/s8rU+Guw6?=
 =?us-ascii?Q?limcH+LqZDqXVpvAhn7LZN/m+5wYvY7uOEUEAdetipBwbNDM/WzHB8PXkPLE?=
 =?us-ascii?Q?EJ5K9H+MEB86NF+0Rv9GF5US+U0kPXtM1ziezF6/Hf8Eoc2omYierkpWWw9/?=
 =?us-ascii?Q?WFKCaYjl9BgIgm/7TS+kPfIwRpYkvf4gRrPHPaPg0dF/+VenIM9dKZPwOfic?=
 =?us-ascii?Q?4B2JnntR9CzkGtbzQZ7YFM+LWvkF/N8krn+YhvZEcBCasBpIkz+B6S3GZ5Bw?=
 =?us-ascii?Q?SJEJ8dyEnSfE9MRUL6dEAvLfo7Tk8/ojJ44x8WVXVSDLGEDExHxAHj/M24Kd?=
 =?us-ascii?Q?jtVfWn3ud1xo8d/6tKYNMhbJerVIYzQW5cGiHM/Db8kiQLBEtAxmExBEuseU?=
 =?us-ascii?Q?Ie+8ROhitIfYVZBTdiPesw1XD3abDnXdtowhG8G8vC+bNdUsHLn3IxWoa/ad?=
 =?us-ascii?Q?DaCr5tbA/3XQI1vLw9OI9mEJ05PLz3Ok+Retv46yGlMjN5gSvHfUJ/3bEVHu?=
 =?us-ascii?Q?D4DsAZ5htMB+3ZBpac5XxmhbkhJz7+ldyjQppZiu8GczozVTDetq0eCyYh6K?=
 =?us-ascii?Q?uUGxhaXjZUp7GaPkWoZgSpOpAq3TDVwSm6pomIT8zuk4gTDBjG/7GcvqVTS4?=
 =?us-ascii?Q?ARNTFAcK2Tbvw9z5bc4buayhpy5MU7ryOdnmWsLyxnx2p+204ITud9ZrHqz9?=
 =?us-ascii?Q?DfGirB0fzNQkeZFCyD0iKh1hxzGiHgYJvbDkdS4pOCraWx2lW8xpzxa2Knbk?=
 =?us-ascii?Q?LgxEchJ4V7U6pSUUL/9ZyvINVdRClPFjrH32NwfokzKwolgfyU30LIoU/CQl?=
 =?us-ascii?Q?qjgYLSP2WsMXuLf5uD4wYxYiF4TITIVerdy0Uu5s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b32ab7c6-0042-4515-5e9c-08db30b14c78
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:57:05.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMJOkHbOUhSEB5mb5nVBhA/bL4ww1Rj5A9LN+/3Qz7pPAVkEHjA7bulMxIcL94aT7w5QItpfmPpm2FZA3e7E2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Export the QoS Throttling Group ID from the CXL Fixed Memory Window
> Structure (CFMWS) under the root decoder sysfs attributes.
> CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)
> 
> cxl cli will use this QTG ID to match with the _DSM retrieved QTG ID for a
> hot-plugged CXL memory device DPA memory range to make sure that the DPA range
> is under the right CFMWS window.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
