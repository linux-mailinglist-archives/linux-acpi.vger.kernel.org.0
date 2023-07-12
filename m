Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6344D750D71
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGLQEV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGLQEU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 12:04:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7AF2116
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177836; x=1720713836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LiuvH+EjpbfG9qgW1w/eq2ilvt7WsHw0ksYaMzYBoB8=;
  b=bP2JSp+19KdfY9ol8r3gmpZwqvdEcglVqWaQVfvvphotdW1klJ8Sr1vg
   VBnX0zBfwNYO9izk96AzLt59ItogyOgHlepoXA/xl6gEdOdgzKPMyzDip
   XnSw2jvStSdeOOchBwQGWxcsX99tt8RNw3kAaIyrmkM/Wa/N066mNF5G4
   BLA8w0ueFOeuiGfy9tlg2SXTQtbxyiJO/RsLm4qJBVFJ2u/+HwGchklhC
   35AOOWh3S88e7P3SgsGhMJIuCoh5DeDIGiCvlf3rbibLvMTkfaO4SCpy5
   FL6w3vuju85U2RBXP2k+kJ5j/0Qz2soRYKY+0NzRbbD8pH6h6832hoJfs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428667410"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428667410"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="698911966"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="698911966"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2023 09:03:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 09:03:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 09:03:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 09:03:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwNO1PJi1Je0IL6lVF0x6Eu+nWKgRD4RCeHEPiWttGug86gF1R/Iki97vuCsYdRCwymZ8K/+xrFSz0xpvuNUx/HTFqccVjvpfcBYJESbEAz1u2INh0y3Go6qku7iCidczl6RJi1e4gkexw9TRrkCX5l0vYhfoHiEGZrMwOLNI4RWudWUFeStGCOqV0hd4RvarSTmGfHEqAmQEjXMX7/+85y/YySuhsXnnhTWlqplJsDYov+wFFRcwaJM140Phn1DKC19ZXAFlD7W84B3mXO/QNhKt+jkncEQQwfXdT8qL+xGaO9iBvfMiBLClwicvci1ggFpdgVKio+A8uzih+hBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f35+hSRR0TNRUbzw87P2NeGfgGW88mpocbt+pbtJ5x4=;
 b=J1C7aQzrJ5vXwhXOFvGqYa2SXCnJJmI94Jeu4X3knX4qfpVcB9ESVVK7Q8xcMuaKEFyH/+c5rh14Jfy+KXJnDSLcM/m2jWcYCJQ5JcQQPmm/Zr5OvUASPmKhepVhgrJJKwq003Ir67C0tze5n0Q/1urYLDcW710Tk6Y4BaDMHfyVadVeD6A49TRpsKLnNww7LLltD9ZwtPFDRUCBcuhYrnWB23f24bk6L+zYc4IMwWAo0794Vk/c07cNcjMHSed0ENzm00zg32kQv+rwi0WgFHGCeXxCIU0wTE6GzqKPSNcP/5A8i0nqt9eq9hS0mCij2oWveNpDx5r9dv57sVC5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 16:03:49 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:03:49 +0000
Message-ID: <0385567b-5cf6-b26d-68a8-9060a2a60ef4@intel.com>
Date:   Wed, 12 Jul 2023 09:03:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [RESEND v2] ACPI: NFIT: limit string attribute write
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <nvdimm@lists.linux.dev>
CC:     <linux-acpi@vger.kernel.org>
References: <20230712115753.20688-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230712115753.20688-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: c4359cbd-84ec-48d9-2c3e-08db82f1946d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUKue0PcowCjSgeOwM6UDfNSZ5KaixC2jZ1aWdf4gNqIQE9ifUBCokoZ5dBW/oPJvpi6oOxqsZ4PG5iNWLb6/eZp6uegb1kG8TJCICNKTgrhh26KLDfKMrtVXYqStXwDDAEgJsevwRBKZPh8IJ5fDKOc/JXGEpLkfZDiGT0+bM7+3x4OOATem7h3YxNZ0wgtoeAOIGOhkGQc35AHl2C+H1BkOPPbHEfaf5XkQSjIkdnMvRN4Fj+WOeOD/R3YQJ+QQJfEpLM2dk2ROLEuW7D2mAVYOyvoV5OuekVEyL36EyJq8HSZQXzG2FmQjefEQ/2MNnz1LjYbTJbBc9X8vcEMBkak1rVhrggjFlK741WiCoP2p7vS3myVxmzlUTUuiExci9/Jx6PvYbMJ9SvlFIE7qtPwc5542bCXMiXcyFx8RlagKZE+bUrZ6S+5hzxBEyBHlJAJKiU/i39ZCJxIN9iqi5+Xo5KAAXJPcmQWzt4izl3DeGV4rnrdIjNW6XTpk2VU+4Pyf0Wc3AXA7kD47bg0MR09GswgD0wcrifOqlqvDHuAAgzul1FYdzIDm6i7o/CeCsRatBnJvjWXRhImvWYvr8891bU98MMsZELu6AeSJUF8d2R/u/I6ad5z0UtBqE8YVw4KgCnCEpq8Vh6NhDnc2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(31686004)(8676002)(41300700001)(5660300002)(8936002)(44832011)(26005)(316002)(4326008)(186003)(66556008)(6506007)(2616005)(66476007)(83380400001)(66946007)(86362001)(31696002)(478600001)(4744005)(2906002)(36756003)(82960400001)(6486002)(6666004)(6512007)(38100700002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNrdU5qNjJ0ZmJQM1FMS2FSb0ZQSC9WTjNZcTA3ZHFCa2JoaERHMVg5WVBy?=
 =?utf-8?B?Y2pLaFhmVHg5STJ3UGZOcnZVZ2h3YzRHeEFaU3A0ZjBUK3dwSGR0dURydUlB?=
 =?utf-8?B?b01tVG0xRWhaa1hKd3MrTmJ6akRqbFgwejd4VDN0V3NnaVpDSHphNFhNZWY5?=
 =?utf-8?B?QSsxc0tWbWNDZXhQNUpFN0htZ0FwbFRSNmloNXJIQmZydkM4dWlpdUJJV2Z5?=
 =?utf-8?B?OG9qRzdNNVUxeUxLSVZmVThuQng2Skc0d2lJV0t3VE4yS3NYMkN5NmptQU1Z?=
 =?utf-8?B?ZEl4Qkp0bEd3TEVmVkVhWjFJQ1F4dkNuYlcrZThmRDVETEVGZWswais3NUdP?=
 =?utf-8?B?MHhxVTNiSG1FaEtGdWt3VUtWRjc1QnRDQ1h1OXZmZkNLeGtibnd4eDRQMEF0?=
 =?utf-8?B?Z2tWRExSUFQ4OVRIQmp0Nmp6bTU4QlI0ZTFDd3F2dFI1RTNybG1CdEdKcG9u?=
 =?utf-8?B?MUtLNGl0QWFqdjhnRG92SE9qcURZMTl0YjZMUHBZUkVCSU50UjkzbUVrOGY1?=
 =?utf-8?B?ZGhPYjhyOVJrbWV1a3NBNFNrazBlK2NwTUNOYk41TnI0QmJPd2VYZVZZYjFr?=
 =?utf-8?B?NHIxcUJXVDR4WS9BLzVzNGh0SUptYWhKQjViUDZENlROMGhXNmpWOE50blN4?=
 =?utf-8?B?djQvWFdNWmxtRWFodXNVTnYvanhMdUlSYWFrQ0NDMzBGSWFOU1V5T1hYbUFQ?=
 =?utf-8?B?RDBEbUVHRW5vdWk4NTdUbTNFeTdXQTdnaWhwNFNDb3pKOHEyTGozbSsyVFd3?=
 =?utf-8?B?dkFUWU40dkRqMGt3N0hjci94eFk4MzFkeVgrVXQ3Tm90cUZJVzdUd0k5aUtU?=
 =?utf-8?B?OURrY0hSRFF2QlY1NW40b0o4N0lzYXpzc1J6aTFCVG9XUlRhUlU0MnpUcFM2?=
 =?utf-8?B?UUdPOEt5Q2xRZVBKbmd0VzhyK3dRTEYrUUZyNHBvS0lWSkVxblYyak1wWTEy?=
 =?utf-8?B?Nk5sVmdKdCtnaEV5ZEZwSUM2RjlaTkNKWTFZRFo4ZUVTNjJTUklXSVhpNmU4?=
 =?utf-8?B?bVgwK2RoTFVCZXNKMEwzbytYSGhwcksxRXppdTNXMjFCL0R4TjlybWtBbUhm?=
 =?utf-8?B?RWxYVW1GMkRXc3J6REpXTXVvSDNnVFR6N2Ryd3haNDczYzRBNHVDVXRZSFlC?=
 =?utf-8?B?eGM1NkpKdGVHNHN3eVdYdU1mQ016Z1FUMjgzMzI0d1EzaHBuc085TWFqN3dh?=
 =?utf-8?B?aHVyNlUzeG8vY0hRMHhwMmNmTkFLalRCWk9vcU5XSXlRZDczbjBad3hYTWZW?=
 =?utf-8?B?ay9XR3BRaTQ5OG13cHJYUHA1Zlh5czQ3RHdlVGEzN21LbHRJT21JMmE5dTJO?=
 =?utf-8?B?Z05EZ294MG00V3ExT3ZWV1d0b3I0VlAzaEdTRzluME5sWCtzQ250UXJZek9i?=
 =?utf-8?B?UEU0a3dpMEpJQWJ2L1FVTHNiT0MvaUJjQ0dUT1RXKzlFSmtkMGlPZ1YzUDBr?=
 =?utf-8?B?NUxkOHhGZm1WbFdjZEVqdGwvTnMvdENPUHo2aGFKVlR1ZnRIeTNQcDB0TnR0?=
 =?utf-8?B?eFBVR1R1MnBtUEk5WjNaMFBPeWVpeXlXbWFKYTVGa0F3ZkRQUGJ6endFN2o3?=
 =?utf-8?B?RFRTdTFaTFNrYmRzRmpqTDA4Q0hnRmFIU1ZrR3huN2V0YXdYekU5OGQ3K1pL?=
 =?utf-8?B?c2FXQ0tGV3ZDc1dCbE53VmVZMGQ0THlVY3Z5N0lCU0lSaUxZelJPK2cwTGVJ?=
 =?utf-8?B?YkhrYVRNZVQ0LzdzcUtWa1FrWFRRaEpGbTdGdURad01nMUxvczFLWXAzcDdq?=
 =?utf-8?B?eEpiN2FmNmtMQjlmMHFtR1ZoOTdjcWdnT1JBZEcvTnlRM3BoZHJlRDFNaFBS?=
 =?utf-8?B?c2wxNExjd1NjSnYvdzgvT0pjUjJURGFNaUVycWRBWXpSMmxZSDVMd1hlNmFQ?=
 =?utf-8?B?ZUpKN1Zla2pyWTVxVit2RUlZN05uZHZmTmtyUlFnRjRVanFCdHZCNEQ0MVNV?=
 =?utf-8?B?TVZWVGN2VnJ4QUJRVDJkenlCN25kVlhnYXpCdUt5UnFOU3h2QXQ0Z3U4WFFh?=
 =?utf-8?B?NkVNejJydzA4TW9xdkloWXRrY3V5dmNNOUVXNTF1aHdvbUF3TEhIbWZyb0J2?=
 =?utf-8?B?WUJ6QmExT1JzbGp0NkNhZ2hnbU9DRVRyU0dVRlY3d09DQ2JvZWV2VTBvdG5X?=
 =?utf-8?Q?tp8b9YcGhpdcll5LTysGJ1v2T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4359cbd-84ec-48d9-2c3e-08db82f1946d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:03:49.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+CgotqlJCF1DTrWTCY8ajS3C2rWpNUkKRL5GmC722MdmDQ1vGkUFRYqZhTuWWmSufMx5UwsSt7NIfR+CqV0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/12/23 04:57, Ben Dooks wrote:
> If we're writing what could be an arbitrary sized string into an attribute
> we should probably use sysfs_emit() just to be safe. Most of the other
> attriubtes are some sort of integer so unlikely to be an issue so not
> altered at this time.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
>    - use sysfs_emit() instead of snprintf.
> ---
>   drivers/acpi/nfit/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 9213b426b125..59c354137627 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
>   {
>   	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
> -	return sprintf(buf, "%s\n", nfit_mem->id);
> +	return sysfs_emit(buf, "%s\n", nfit_mem->id);
>   }
>   static DEVICE_ATTR_RO(id);
>   
