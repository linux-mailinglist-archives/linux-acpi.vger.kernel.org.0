Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6168C55E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBFSHW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBFSHV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 13:07:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF328D12;
        Mon,  6 Feb 2023 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675706839; x=1707242839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FJ236FjlZaO0yc40fTwoOsMaVeCXRoWIS9N3amK64Pk=;
  b=h9L4vS4SCO8kWT8G+hbqnVEf+i3RGOj1lCO8zxYMTl8JraEx8YshB8On
   EUl1/11FtNUQyf3zmkDGzPyBRqZZs93WHuIiRwiLP3MJPcdXqBwsp68hp
   +2EdLzccKTa5npkydRMkPba4tDEDxBeZ8aMk0yeeBwXvJULFdNrd9Yc8K
   LIEIJAfZgw1dqzebfFpwat98GmC7raQ+DnQ/sB//IVrHkNDFMrZjpgISM
   PlzNH5YRdXijM2O3IMW5flxl8JofjaXxErS0xb5/jLVs6c/cKYqS3xBiI
   Ey2Vvb0WqmRI2bUMe2qgJlks40OLT/7qEdxOs+jb9o7QGUSnYJ81Lgru4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317284770"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="317284770"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:07:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644126980"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644126980"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 10:07:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:07:09 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:07:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 10:07:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 10:07:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR9VVg8m1L+G/t/0UnrD4wwaqvPCj28vLwLlCLAYgvPz0eKDnn2BNeT0Q0hHhQAxHxJwzU0K8rYTMiPCLixfuzAeQ9/103Z3HWFbU4YKPcSwTEADQ1DzMMfzRtNz0cECxIh6igdxrW0wpZN7fCQZIIh+uVRkcChEMhBBi4hfbIuE+3LMI5Pp8Y8pbhotPkLmShJvbq96YmQaoPGYL31gHqUG0BUTMPIGR+ZtF1OANe1uAGSKbaZZbrzTkq3GAiDCe9FhYsK/G/kKfpEaYsRtHx+Jph4fJwRIBnstChA3HYF0/JGDIeefmCOJsCts8jFe3A05cxtFgraiqZGDAMW9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFIuTG4b4B8GLrHo4drk08y9FGagW82rFDUc1clCLUI=;
 b=eGSHjVCQ3gC+Uonig/r28q9Ugr3tMBjZyGI+fQV8zH3VliBF55JvMLAWqGEN1OIOv80zw5vs/XY5YWvHBtVY9SK5rD5n9IHaj60lun9kehAq43kX2WTNfZW8QvcmEfKMio0ZBD4lwbnfmQBN8TJrZSY4ST2xHtLdqdMADHNRXIz6RqxrYvxTjWsxsJQsyIxl/lyQPaZBHusUgYSyKvyzd/x09Hwa5nmX8JMVf+o7EYkwklIWCcWcFy3XYOj/YWzamDZdDO0J69nlSveCzCPrMbiTU7yA94lZ2oJPUKoWlBTW8ROwfdLN8lG0XLwVUyjh+9yhbSKoNcLVag7fwKVBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Mon, 6 Feb
 2023 18:07:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 18:07:03 +0000
Date:   Mon, 6 Feb 2023 10:07:00 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 03/18] cxl/region: Support empty uuids for non-pmem
 regions
Message-ID: <63e141c482ba8_ea22229449@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
 <20230206155448.00007dfe@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206155448.00007dfe@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 038975e2-e6b3-4759-a0e3-08db086cf305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWh2iXGLnkFAVV6SmN/7sP2dRNgmVwfxz0B6Mus+isOwMkCV+teZKwcxCkgJHe9DJsqE/watjHSp56jG5qyFb3EieRdFIvTSgddxbk4GUeXeAXCe7HxmDXEahMhQedSVvAY1z9e6+kDro2sm2C5O1Znn2MzjnZ+pLAO95xCfg6t6QCR4p7iH6WUrgYwqbis1+fp7SnjbXmQaIraScepAhR+pbmIcfb35S324MO9QtVKciZw2c9FMflX9JAMr/V/MTtO1tE013fzkoEnWOE31Hg/COIJO1D9BQ3/jP4FJFefV3flrU+JkcUhHb8uhFcsxclT+uuCGmGrGSj+e0pJ+L1lOG8Iwb2DFkWDhUZxxpFP0gjIYk29J6C/z7oyJ441iYK/1Nik6brBao/9X3oRW+km8gy8XXk/vmqCHYYomaw2VYkG3dkDWKhszE2VoTZF0PBw3gc7iNPhYtAhCNVVXwYyqRVjGV0Axi4wWTpNnDYFn6q/rTVb3P4JAbDpj5a01qNBWaUdyCTWu0/dAoirpM4gt8bonKAYW+dTdYI2vVoCJmdxXcmAfv+49gFtVeibs7Yn6LEg+rdPtiAtY/NDlhw7axfizu84u8AwEiGRc0Ut8NLyx2UFxue+6Rj3KEq9o2xYb62iN8rTUejEtravnJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199018)(110136005)(86362001)(66476007)(38100700002)(4326008)(8676002)(83380400001)(66946007)(8936002)(41300700001)(2906002)(5660300002)(66556008)(82960400001)(316002)(478600001)(6506007)(26005)(6486002)(186003)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90PqVkM29PRn81qB7s1jL2B5hou/7aUt/JFefFXWEKWI8TD7jI8s9GJjE0sT?=
 =?us-ascii?Q?u1+3fLRe0jYulxfSFKA9DwfkXfAE0itYBnUH84wHYKtpxnJlgH4+iq2xI+4+?=
 =?us-ascii?Q?royP3YGtNwNM/udHD8fX/vbr77GXG28n9vJC6HZcrQA+yH648xieUx4jFEBk?=
 =?us-ascii?Q?0yP6ME1jUgpRzcm0N9BdJyKluiOe1W1AGnZPFgGHb3IJYxgwePDbC0WFKpdw?=
 =?us-ascii?Q?yvUQUKtYpmTisD1Eflh6G2XcACbypMFkbaYss9/EiSoc7geh1leyO8SB+teB?=
 =?us-ascii?Q?4wVFtcOU/EAgQ+kB1QOmY7MTJuWY+NQB3gPTeZc4SMTDbH9nB3XbBGND7pj5?=
 =?us-ascii?Q?6w9U4Uq5McchmrlWv7uXmsSnFneqo5PdCZdAf5laI+8/To/80uolw6Dqk9nT?=
 =?us-ascii?Q?qU2NDvazYPAyfehlggKABp142gTU/p2JPnKbmUEDG1uHI/aFdB3FJpGvpHUJ?=
 =?us-ascii?Q?+pNPbzulMJ6OCZ3vKRE9hapIkhtui6LLuq2I2Ne9YtC8BJBYewuzZMaVz5ug?=
 =?us-ascii?Q?dBwMzUZW5gwlXLoMWp/CUzYS06zRAJrGpEAMx1gT8a6O1Xdt78cVjugNJouJ?=
 =?us-ascii?Q?UBP6+RR4fNBOjoawSWJHzmsb1CKs51Z+ozgC7I0oMlIZlW6FUtgsxPXDTNVM?=
 =?us-ascii?Q?/vaaSziq/y72UlKSffhW9L71aOZ9OMOyDIwQAczMizQ/2ZZkbltkw+FhlQqn?=
 =?us-ascii?Q?vkBPvda13+xFrZ/Md9bpGe3JhOuh3gKVLHVRtfY44cQ+Bb1KWt1kXFz/hy0m?=
 =?us-ascii?Q?gJPctk8hDs7kepTfccMdsSByrrdqVa+5XYDzJ1lrEFPN2EbAHgZtMbglAehQ?=
 =?us-ascii?Q?EfGbJmY0GjyOZ83xb92nKq38zqs5m3/Id4CWToPIFqAfc0gZtZVWK2SliTOP?=
 =?us-ascii?Q?2oc2EDc1CIHrcgOH0vmtaRacN55aOOmECB4D8uc6gtgSn/wsja46AR+5haI+?=
 =?us-ascii?Q?iBoFJkF+9qt6l1j95iYWcwBN5BHvVvFmKG/U7qbShjp+bOLvXBihP6STl+h3?=
 =?us-ascii?Q?0O2fJNv53rsZtLK+svjAzK0lCDYZa1fZaiZDS7rDdj5DSDcT97bQcfS8gd7Y?=
 =?us-ascii?Q?mRgG9cK702Dv7OEQAeX8emhzJYASxCeplcEXugHXhsaOtwBWmpRYEl/3WiZk?=
 =?us-ascii?Q?0L/uUTbLTmztClKJxSeQRQRe/Li1FK2YAyD7dmDqrv3yt2d18Z2n0cZWOKXQ?=
 =?us-ascii?Q?bDFh8DhxMDhpmU/UZE455u7OYL8qaKR0E6Vm49yIDZkWXeuU3Lg3RdrYwcOe?=
 =?us-ascii?Q?cusMy3dzDjk/2ofQUGZ25BYbA1N6WrqUmtvE9QhM75wQk0sJU0PFJ+9nSZdJ?=
 =?us-ascii?Q?4/mfijgKx0bTo3bSrO0si/Tj5SVDifHmLB56wViA81v7YOvQhUeBGpYQ3ERN?=
 =?us-ascii?Q?vVpeRHdz7wo3EF6K+ZJ9qbLO0h6uuVoQniqDF/huVgyuM9grO0TGgka/QY9a?=
 =?us-ascii?Q?pZUDO2D3RHqt7WDmx2k61LC1Qza5xDR8YGMBhCmwpCD4idzIpZD4F2TRkeOW?=
 =?us-ascii?Q?flFZOJWxBE1rq9JQ/0kHps7j4MFfFr3uq3btU8q/04pHyw/d5/jdiOIcI1eH?=
 =?us-ascii?Q?ZPUDInhNFBH1l4t3h2KsNDAJj2f7ZQAWS5sFrBbmC1qwHLskmAdO7kE47qz7?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 038975e2-e6b3-4759-a0e3-08db086cf305
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 18:07:03.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvFhkExkJbVNCMfSAdyiO0JEKlvd2ECuNVpLooMpcm+ipc61PGgIzo6Yb3SjtERl6R/KopDpmQoEgmXphobNYU5DqKbNps21SovhS4ILcjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 05 Feb 2023 17:02:45 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Shipping versions of the cxl-cli utility expect all regions to have a
> > 'uuid' attribute. In preparation for 'ram' regions, update the 'uuid'
> > attribute to return an empty string which satisfies the current
> > expectations of 'cxl list -R'. Otherwise, 'cxl list -R' fails in the
> > presence of regions with the 'uuid' attribute missing. Force the
> > attribute to be read-only as there is no facility or expectation for a
> > 'ram' region to recall its uuid from one boot to the next.
> 
> This is new functionality, so do we need the backwards compatibility?
> Or does that cxl list -R not just skip these, but fail hard?

It does this:

    # cxl list -R
    libcxl: __sysfs_device_parse: region4: add_dev() failed
      Warning: no matching devices found
    
    [
    ]

...which in hindsight is not a helpful message. However, as an end user
I hate forced upgrades, so a small kernel behavior change to extend the
useful life of an installed tool is worthwhile.

> It's inelegant to have this visible at all (and it confused me when
> I was running tests as I assumed I needed to poke something in it).

It is RO to indicate that, but I do notice I neglected to update
Documentation/ABI/testing/sysfs-bus-cxl with this behavior.

> 
> If nothing else, good to have a comment to remind us in the code
> why there is the oddity of setting it to read only.

Sure, I'll add that too.
