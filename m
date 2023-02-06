Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC768C50B
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 18:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBFRpN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 12:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBFRpJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 12:45:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C72E0D1;
        Mon,  6 Feb 2023 09:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675705495; x=1707241495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z76y2UZlnIgGDgZyVcVTw1/jC3VCiQyy6sySpARrmBE=;
  b=acEMjikmk04cQM/mICYGy5PKiejYpgdRzMD29ld/w8mM5P6LML8zMokA
   UFByMhjiHBW6trIhLJvaFcDM8Kp0psAlPqDhzPvN4NAcZzow97XZrzQP4
   olWh08kdZcKYkQXUQYPTItgkc1UUU5XcxsPSEhb5K8lfccw0GWxWoJh2Z
   xn3lYRfjEMx6uILdhN21nbR7UJg3Jht29kjG/bV2OgaSTt/rMAKymt4dG
   m6Ym/OCXyZM+D9w0eOB6+7AMuwskJIREc3AgfQPrGi5y5fOdYzqVchRXA
   mC7KxOJ838XafdKyBFBiqjT6dyDdK5AKpAzUKkcOGOVQPSKnwrOO/KkH7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308912096"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308912096"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 09:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995405548"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995405548"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2023 09:44:54 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 09:44:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 09:44:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 09:44:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7gTbpfReZ7IDNzVpXuNjHm+dKuhgaiSaMl8JrdEUM0nY6PqQZtYEgTXmS3zzHReiyvR/47qYQZbuSEsfV3ul2rdaxvbferhP+kj8B3dRokH9nsGL0VIzD9FlqjDQJQkD6yc8o6bGG1vAL1WuaQWUnq+Ta+rjIaQzt31k3tJsW9uNdTXXNK1COVVcgdNQEmCbIkYtt69c/7ZLMK8nrQxLldT2BWClGLMjuIc1Aufi1TMUF1l/BMfOc/ARhskOLXQbkT6PrL3/5nI8fmlddj0ZPsbpxWCIF7oeVE7x+VoKlo25W2OliynO53YaBFzC9JsSoo0d51+WbBgBzfwDiUhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/Vufi9u7J2iMl/ng8FdU/NczsQ3gW8SF+bAzpSOhh4=;
 b=XKaS1VJGwCrEr7JiOz0QGgxX3tvB/pJuWekaOtt9z9DU4RnZvnwFXbwNcI3UiGaFh5j6b/1+XrHtYfd2Hp81GctdqaxxkBWOUAPrqX0oRF8/7mHXHYoQapPYGa0yHV00dZlgPIdaW8VLXbESMhwX6xgsRzDyYTUaxkyS9tuFeHF/13pLTGNBghZWQlP+biV2R5bw2tRp2RjcePAbAXqqoAvNcCyy2R/GDbbjj2UNA+oS9c7LZWLaG2S2ZZBpVlDt8GqohsObiYJPpDaj2TiPMo9T0UvoPiIZmGrHRH+TxY4Pvsb1xzbQ021MCuEZPNtdJwlxH5FOEav8+XBZgHMSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 17:44:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 17:44:51 +0000
Date:   Mon, 6 Feb 2023 09:44:47 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
Message-ID: <63e13c8f5debe_fa3292946e@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aaff27-6174-491d-24a4-08db0869d8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+l8DEdHi/lWFK+6f+KAFCiOr/QtjILgGtavC1+sEM0yjvS2W7N4uKdryeQrolRiiijAfe0p9vkpBpjYtGHci6S1ap+e18o0LzoxRzIcRViceOZBy2wGWdKFUX83+BLlGoxVa9Q7D2VaAoSotF7l/TqlezTPmX95fvmEVE6XxNLZKgFBNFOUhGPqGX7h6xLc7fIfQxWAwoP9o3MRYAgZxavxSRs6BOQBAyKmpXSaXHpMI0ru91XhTOm/8g4fM3gBQH4DNhKKi7rW+uyVlubb/Zq+VxUPf1e1vPJNVYo+GslzcI9hYwpfxtMJ+Tlq6XC2z7uwqi5SQs48FhUnX7OJ2s8enQfOIId2vmYmtc1KtsaGVJ24korD2t3xqkY9o5n6Sj7NUBYqnP7/fdqvn8N/JaceOmlkRMvgkgmg+Gi6g7H/SCxwIeQlfr0UW87D3JcYKa1snFtF5k5aNOlbl1Y6TnPj8O9c8OcJgz5jvWhY4wBCwnaBDFMLtZI21bVxemDijemaI/QUHCep0Crn0LefhntUIQdQgzMjT+Hucj+NtOO0biyTa8VTqvCsjI4yacsIEgL49ZgzdYSga6dSIJpT2zcG6rzwf+ERScVxw+sza/n6OLiRLRryjzERHFnS97s3zMc4LMpOz+wjQC1Fmg+Pdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199018)(66946007)(66476007)(66556008)(6486002)(478600001)(4326008)(316002)(8676002)(86362001)(38100700002)(6666004)(83380400001)(186003)(9686003)(26005)(6506007)(6512007)(8936002)(41300700001)(5660300002)(82960400001)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pso5ob6FQ0dTM2Lu8iLL5abrcFe4kDZs8NyVhoqbUg91MvkzkBRSM8mTAKQ?=
 =?us-ascii?Q?yEnHRmzWwJJP8tPU6tuuvvfwyq74pBwGXqneR2YwWxipdgRMhi1BrT9LDZCa?=
 =?us-ascii?Q?8IF9APMqZ/3jjf/7ImDGJnc+KhtL/361ZYKlM884Vw4UM3kOeskucEf3gDR3?=
 =?us-ascii?Q?vfSLIvG/3g7mjnxIPerOwZ59QfQ4wiDzrY+/x4RysoTB2Ny1Gt+f5n2cAc6Q?=
 =?us-ascii?Q?2ONsC9A+CZGH8qoBKImY4wsBA0q5Yq/7A+sRDEg11LAT70uIfGsV01OMcWSi?=
 =?us-ascii?Q?ldY6SQfifkVH2iiqUjraYQIMnJiCPVR4boxHhmmxj56o7MITVWxUHFC68V+j?=
 =?us-ascii?Q?bCxDhJQvwloOc5gLjoyVxIGNANN5d2b1Oc7BZv8vB1NBv8kPj+oCGzBmBgMs?=
 =?us-ascii?Q?KHHK8wzNz+cfVmc6JoPq9AkoumGXOcF0ySx195C+a1BVKkzkGSP7ipK6XxFu?=
 =?us-ascii?Q?yEwy5cWVOXMrpL8LpBZrAyD5HaLgUwpDkssWDYgZXZkP9v/uBXbStwCZ6oDS?=
 =?us-ascii?Q?67NEpmodci6cH8UKF/Ye5Lyx06zD797jmGuLR/PjpB/KRXHMrd8jx7CQ0nm0?=
 =?us-ascii?Q?KFou4ym+AlJ/rorkuVci9MAU6TdvSejsEa5HTM2ZWMcgYJZsglll5ncQfX3R?=
 =?us-ascii?Q?kD06NEYoqAPSJFYjqhiS6s5E0Jh/z33qNpvQi0k1smOPFU8PsVMHkNrKc2o5?=
 =?us-ascii?Q?H0thREbMTRJNOeYBuv0VTTGAO4rrPJ4sBKlEsKtRZzBwNxuAjWPc/WsaoJYX?=
 =?us-ascii?Q?nFd0mU64gqwmJgRqYwX8EPvWes4/jrt2tC10bjBTSAtXHx4r8QhYU1CfY3CS?=
 =?us-ascii?Q?MxAprt5FOtUWhg03lMuKmfvo03+yDnG42TKl0qUVedrsVa9B5AKk3b0bIeoY?=
 =?us-ascii?Q?SGbiUnfXCHINSSXryq+7CVLV1Xuq+wI94JZ0JtX/wlUVuw17ayIqkmYSUaFk?=
 =?us-ascii?Q?Hw+IoVjx09hnHdDDYj4Gz3dYRbmbd7Ns2hxtEW/MED8nXgkeFHi4qdaCoZji?=
 =?us-ascii?Q?59ujCD9/oXneOtqnOPX+qP2qTj+v/0iq9xOHSq0kwr3WTT3DUU2WuA5UXCvw?=
 =?us-ascii?Q?I25S7tZbcpV2ydehvsvBXTYhe0eUpJ1hTLwMkuADPzbOvN9wiaxhINTsKGU/?=
 =?us-ascii?Q?cyseZH8hEByyx/nju+4Z/12voF0dQ+Ju0ilcNgZhKfZ1nRiqYgllS4WSogYm?=
 =?us-ascii?Q?7LaZjeSnrIw1kDzmFLGUAII4fUVmvwiqWzHKqTPp7yxLX+i1kIcQWqFGoFYn?=
 =?us-ascii?Q?nU5BygCOnPx9TSzpQ7Zo20SBP5+cD4yUQStbyP2f6z/MUh+OUAF2gRZeV+aY?=
 =?us-ascii?Q?43/mQ1HYCpFeor5YPYoehnkkRw1Ni6El51F3VvNqJy60Yuxp4zQcBPpEpBG/?=
 =?us-ascii?Q?48rsVh5SYeVs/abnFLWIAbGznQ5OeVscUSH2QRKu9+XUC4nmV4le2oHVqdrz?=
 =?us-ascii?Q?A7BVGsdEauX1it3+MwOwfSVfeBMgyxrh5ahe3Apefde1WG2bOcaiKo67ief+?=
 =?us-ascii?Q?QbDz1ZTMn5Ya1oAPOr8W2CYkUBcZ3LYaJapwbZZxhmic9ZZMogPrXTejvkDL?=
 =?us-ascii?Q?UfzRiw4iZ4v/Fx9H3x0f1izXHz8+voOItmf4RfsW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aaff27-6174-491d-24a4-08db0869d8f7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:44:51.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWardDHxwXOKM8CosdA+VreamyPojeB8ExOTO7ALfz4BOdWVhXzKOlDarrq9VyAp/0KB8LphmoT+owHni6cfbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> In preparation for region autodiscovery, that needs all devices
> discovered before their relative position in the region can be
> determined, consolidate all position dependent validation in a helper.
> 
> Recall that in the on-demand region creation flow the end-user picks the
> position of a given endpoint decoder in a region. In the autodiscovery
> case the position of an endpoint decoder can only be determined after
> all other endpoint decoders that claim to decode the region's address
> range have been enumerated and attached. So, in the autodiscovery case
> endpoint decoders may be attached before their relative position is
> known. Once all decoders arrive, then positions can be determined and
> validated with cxl_region_validate_position() the same as user initiated
> on-demand creation.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |  119 +++++++++++++++++++++++++++++----------------
>  1 file changed, 76 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 97eafdd75675..c82d3b6f3d1f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1207,35 +1207,13 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>  	return 0;
>  }
>  

[snip]

> @@ -1274,6 +1252,71 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		}
>  	}
>  
> +	return 0;
> +}
> +
> +static int cxl_region_attach_position(struct cxl_region *cxlr,
> +				      struct cxl_root_decoder *cxlrd,
> +				      struct cxl_endpoint_decoder *cxled,
> +				      const struct cxl_dport *dport, int pos)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *iter;
> +	int rc;
> +
> +	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> +		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			dev_name(&cxlrd->cxlsd.cxld.dev));
> +		return -ENXIO;
> +	}

I think I know the answer but I'm curious why this check is not part of
validating the position?  Is it because this is validating the position
relative to the hostbridge which is not strictly part of the region
validation?

Ira
