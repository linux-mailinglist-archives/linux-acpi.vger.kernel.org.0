Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763A868C9A0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 23:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBFWhl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 17:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBFWhk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 17:37:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C2E065;
        Mon,  6 Feb 2023 14:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675723055; x=1707259055;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PEWTsr5DglItpJ+gF1YeFRQDaKUc0qCUiP5WibKMueA=;
  b=W0+HEeoka/yJI2wcRwZN88hQKnpJoUWuOP5e5Hyl9s889UD14dpNZlou
   GtMb7OGor/sfZkTNm2C6Dut5lZXmwXdCyBvXY6y2Qpj+rdxjEd4zlIJCy
   2nSHh7wwNQjwl9YnSO+0MFnFH9xQl7X47PMSPRCXXrn/biBMXIiqAvBWu
   lP/DiQo8WZ6NQBdgCPSKeU7K36LV3+mfF8nlEHZLXgnwMgf/RaO92iiUT
   nhof8d9HFfHC8Rw7zJDQuDJKzNHbY9ILsquwc/wMXy974I/LSBLkQHScw
   tbcGLPCSFlOzDP7zZrTXd8JXvwqc2IABvhZnOW3ucA6+/u78mTiSneduH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317347333"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="317347333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:37:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="735310207"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="735310207"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2023 14:37:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 14:37:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 14:37:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 14:37:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 14:37:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moPKW8xsrMPskXpED9xGwOZgZcQyCde8UEVj7fHOCUJuREPkkbiJI2/GaU7LKWdoDYuED9w30FqwSLQ9jiKMP6cxb4x7oQGS1n/AYux9ERZHyJQPfT3I5FXakG1IOCyDE8DzaMLAikHOMFP4Z7NO/UeTtuq7qjYNRXCHSE9TUbZU4dsSWIYqDO3Xp8vHS0mfe8XSzmG6Peyu1oOUvSZ3y2i8AHd+CYa+3safMUhjIvTuBCxYBED0Y0Vv82QmL+kzn4nj9Lrqwhh5R3gloiPzjzvlqFzCbpAYMO+K8EyjMIXK4Z2EiPGRHxzDN4THUerhxyHIRvF6nC5m7kNuzglvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/VhnHNU293BdMV5mX2Bf/1jZ7nhrF+8AG2TEJW2C0A=;
 b=jDIC0Ks0zuzFyUU+UuIbhYGtyeG7v93lNERwK79vQePXCPqt/L97IWA1RHpF14xik2GWoaaO4wjYhyjEJHMxns9G5iCHAtSzjgWot7XcXKzJhvzYJdHsLHUCTYMHo+bLnbodGXQ3WXBCdBhVrCcCpcCYlLdd3aT00IqCgYYnSda1i6o6Gr3yi8+aekDD4jlGSmzv1xOF2nXZG4ak0rWFkqWcj5+ldsJSnmTCFe3MmUw5O9eG+SnfYdkC1ZwcEtUdN9BegIeE3wYNr77UrI5jc9sB/Vb5LsEQpk3qN0Tc+vbz5AWxT5CyRYuAzL8Ad70iv9Nndlodddde6nJIeH8ATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 22:37:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 22:37:31 +0000
Date:   Mon, 6 Feb 2023 14:37:29 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 05/18] cxl/region: Add volatile region creation support
Message-ID: <63e1812921511_1049ea294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
 <3cd2cae0-72c9-6125-dfb4-3af1035e0772@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cd2cae0-72c9-6125-dfb4-3af1035e0772@intel.com>
X-ClientProxiedBy: MW4PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:303:dd::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ba319f-5836-41c4-be85-08db0892bbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czck8NCbmKt4HW1/b7mxtOPyHgCMsKHNy5cJJ/TG67fkLdo63B7/gKi2H7Od3snakb1vdByPX1Gv3vIREqcg04D4dj1IoX+IsFLVeRqGgwKwCwulCLez32GEkEdqxmJ+doJRgdrISoi/DZcbwBGYGmNhtH2ab7KGmczr0NdyI0/hJJwR6yPJavNvvVK7TA/UTYL7SuoDxX2fjuMjDYi0HgAww/2LM/xNToeabJRrG6Gjjxo0Pp0PSKQQHpm1g3m9don0SdQNFzQZIjMPCv2VIpH9woJ5cOSii/6+eezeRdF4kVGkWJTi7m9DrKXx8gVOT3PFafKU3jvqArP+HGzw6rdGjNrvxEJsNjfdSjnD29C44xqr5X3CWLB+00CWNTdqH6JfxHT9JBRxVii5y769w0GzX2IMST0wbyyTEyH4iMJECMKg4Tk6ZrCCTx/UUmvN8ZHThmvP2aLKn6nhgKbkz8merc6dRbc26tUSnGm5+uGCJqevwiFH0e3e5fCdoDbBveJ9K6cwNMafBn4HUUXrrRfkfmKKLwKqA6PZGgVhxMpJBlbruy4s19s94KLQLXEo0XQSdFSbAnm+kobxaiIgPrdIoljh0vIwXZd7QFy3g2A+DYBWRv7x8CAd7WxDiQsleqPxy2x5zTRo5TB33FhNNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(316002)(110136005)(478600001)(6506007)(53546011)(26005)(6512007)(186003)(9686003)(6486002)(5660300002)(86362001)(82960400001)(38100700002)(66946007)(83380400001)(4326008)(8676002)(2906002)(8936002)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksmWauK4FZMUWiTGUIGcC3D1QBkS5azRaEfJEh9+SLtRrS3HYmgSu5j6/e2b?=
 =?us-ascii?Q?FZb+00A7CbfdRGpUBVcuDSpIzRbpYWaNf60UO2rdxO6SuoMMWJIysTBWpUXP?=
 =?us-ascii?Q?+jzc2B7e9YcBQ5D+H2/ZgjcQj/6XmAU3wj6NxsKhhWr+pJ5SPM/FoPyYclzq?=
 =?us-ascii?Q?mx/T+nVKH5nTWWbo3+jYrmZuyDsY0mxdp8/SapOtFBYxwcTJHVz3shQTxq1I?=
 =?us-ascii?Q?cL9HAuy0WtxafkWPANc56Xsps+N3ml9rxVlhuwv1WIE1zzJHfmMap37dMV5B?=
 =?us-ascii?Q?ufmM86LPj6QnrraRmHhJOnheszOo5qDeahL6aoMRDSTVRnYY0wihctHdsV8p?=
 =?us-ascii?Q?eQZb4P1wUR72+R7cniefHbj0q1Yr//rrMDDPG1iZx2kqdhRth9LPiMuhVtTB?=
 =?us-ascii?Q?h5Ur5pcOlrN9u+gL15DBhbZW6o0df2lc2JdYmiTqv2EHbWWbE+Zy2GtZA31f?=
 =?us-ascii?Q?YmyAOOQpGQ/9latrKy0lpJu7tnAV7uWnEIEYRGSqc5LiKmtsuFNFwCuAHg5E?=
 =?us-ascii?Q?9r6dpyRuE01K0ViZMso2vXdRVSzYoP9CIbVL928S00fEOdhDjee3o1Ms4xTS?=
 =?us-ascii?Q?MuZ8ts81T/wek4epCmMeU5q/Mfk4X7woPRHyCc04d1n+WXx1E9zxT75Nqz9F?=
 =?us-ascii?Q?7R5fDfttI0GdbSnhNREpGHnjrTFyJf7Gs18OsWNWfodiNfaqTmP9hGWWusQY?=
 =?us-ascii?Q?zZaHYyO6lxT7jpIODHvBsEhPCTPwACY+9pACcr8oumAofegXVcItHoHyvTQO?=
 =?us-ascii?Q?D9qUeCC6EFKYg1z+StrrFbaeG+OvIjYneq0gNQujJ95JF26JI++TqyDCr5eA?=
 =?us-ascii?Q?RMK4pB+PpikMsj8biFRMTCE4UjLCOH5gAq2sgO4GP9hZJjPwmbHgnMJu3CFN?=
 =?us-ascii?Q?DX4CVBKpMFb/LqENf+cBXm2xNaJ0oF4VUVHWJexi+ets+se9X++CpHn5TOjT?=
 =?us-ascii?Q?00V4dsccZKAVPwiFaDVRaIAELKrZrkoN8zFtFzk+RerDbzz87jZXD9DaONuI?=
 =?us-ascii?Q?6KdUDpZWWWtlYJ96WBLGoMFD9RRXTGTR8YZz9VPvxjuCT636L/H51UA9KxhB?=
 =?us-ascii?Q?ItoSOWIFNt68HEbP0j2sIQ3oBEnhhWF4MuOvW86KVeT0LPvA5jK2ddoqBEJs?=
 =?us-ascii?Q?UmI/lyMilXoqSebA066azmO0b3PbAvqVBQc0AI5mnXiN+/011r8eeHY3qVyW?=
 =?us-ascii?Q?Jl0/dn0b5Bboy3BY0V+qor9WPBYCPdN5WhqGgc8Epha2s2QeJxblvwqAkfms?=
 =?us-ascii?Q?f/tZxmxYfyl7sx0TME4U1DAITJyL+03b21+B6RxCJ2IIl+soNVMMghiEDQ/O?=
 =?us-ascii?Q?s9zY2zbPqU5h9WRJynuhQoQrNMy8nl7X3aSNcJBnrMo6HPQlpG7zGZfYwU4P?=
 =?us-ascii?Q?x8mVXnK9LqnZqKg6bCeb0YdqaoXeh0FURacTm6s0Ex4WWb8eFs84zaYRy+aR?=
 =?us-ascii?Q?7fQ9j0bEolVJ1gfG9L8i/jmzjZmoUpbQ3T6s82Y5cEUp9TRMnEZx7nXr6In2?=
 =?us-ascii?Q?P+1r76h5iS8W/r5KnCNf498M2QyFsvbo+DIAmIwTUmgywLwvtVEs4yrDgBiO?=
 =?us-ascii?Q?QC94GrxMGUBbjVY3AmQtjJQl5SGcj1bobKQxHoVW9cVMQg1Bz+3PMOKaH9uA?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ba319f-5836-41c4-be85-08db0892bbf5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 22:37:31.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUjnezRPkzdZV12tzandguHtZXNaxZtQWuGqkR9ijYwPVy3nG/2JoHD/Hoyu69poL3GRjtiUTtJv/EsNDbhemWjyIN+LcHYKZz9DHap/YMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
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

Dave Jiang wrote:
> 
> 
> On 2/5/23 6:02 PM, Dan Williams wrote:
> > Expand the region creation infrastructure to enable 'ram'
> > (volatile-memory) regions. The internals of create_pmem_region_store()
> > and create_pmem_region_show() are factored out into helpers
> > __create_region() and __create_region_show() for the 'ram' case to
> > reuse.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Minor comment below, otherwise:
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
[..]
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 4c4e1cbb1169..3acf2f17a73f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -285,20 +285,20 @@ Description:
> >   		interleave_granularity).
> >   
> >   
> > -What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
> > -Date:		May, 2022
> > -KernelVersion:	v6.0
> > +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> > +Date:		May, 2022, January, 2023
> > +KernelVersion:	v6.0 (pmem), v6.3 (ram)
> >   Contact:	linux-cxl@vger.kernel.org
> >   Description:
> >   		(RW) Write a string in the form 'regionZ' to start the process
> > -		of defining a new persistent memory region (interleave-set)
> > -		within the decode range bounded by root decoder 'decoderX.Y'.
> > -		The value written must match the current value returned from
> > -		reading this attribute. An atomic compare exchange operation is
> > -		done on write to assign the requested id to a region and
> > -		allocate the region-id for the next creation attempt. EBUSY is
> > -		returned if the region name written does not match the current
> > -		cached value.
> > +		of defining a new persistent, or volatile memory region
> > +		(interleave-set) within the decode range bounded by root decoder
> > +		'decoderX.Y'. The value written must match the current value
> > +		returned from reading this attribute. An atomic compare exchange
> > +		operation is done on write to assign the requested id to a
> > +		region and allocate the region-id for the next creation attempt.
> > +		EBUSY is returned if the region name written does not match the
> 
> -EBUSY?

Userspace errno values are positive. So "$?" after "echo $region >
create_pmem_region" will be 16 not -16 in the busy case.
