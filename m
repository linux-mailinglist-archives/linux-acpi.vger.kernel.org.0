Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1C68C65E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBFTC3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFTC1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:02:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0597183ED;
        Mon,  6 Feb 2023 11:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675710147; x=1707246147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u9mpkD3jrcx4WXSfRUstxAHPuETTa6Qb3dubuwd4ViM=;
  b=YhcsPIDIKYOOGiBV92xapWl+vu8865OdFozrUWwW32G32O5xwgfbG1Il
   4XPNVnoOCviDBF+kOyoornu4YMzZcdGOtEzkCvTuNCoL3tzve1kGIi4u3
   xFx5Q6dAAF0Du6xNyLPL4QYsb6sL5M8ELOBvqNTW+i1yOUhdau4u8T28E
   YK2M/GhmCjxQNX0pEWNLL35gZARp4C4XeIG9NlScwt/6x4lZRsUQWt7/c
   fJ1AeXEJ7YFKn88U9v9v15TUnaYZkiFPssDfmN9zzSal8TGrRxUNYE7EE
   ulMvHBD45OfTFzzucyTm4y2Mdw6T6jeyhwCo1+HzG3b4HQUz4jHSwTrdH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309620557"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309620557"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="840463318"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840463318"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2023 11:02:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:02:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:02:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:02:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:02:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y837tX66GTMJMOV//4eu5x6ELePcGGhA4DQCnyZH6rJTFcUI6yQg/nzX9u/PVmukqP94e39P2SMvwMN1LL6Z/J2Du0T2VdQw+l8np+TO2N1nVa9qLKfGeE/+FS7OKAAj2lykStTD59IgAten2qJR/Zp/SImKGFHf2xdY7SflQs+1xGe6YntrWzJUi1WWxuBdUNHrWiZTjEt48aiQCmz9s4d+KDWNOpLukYv/luT7fnJZoviGi5R+ZQrHqWNiT9BGShaJdz2wx62RxRmjdaH2pX+d9h6z6Q1xv/6c4I7QZWU1a2rf0fiKtG4jA3rlW6vGGb0RAgajigFxKVZcR9k2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1/KCn4AooCgpL+FZ4emhBjvdOkA3tGqCnytfNbYaQU=;
 b=FficpGESr+SMjgyLtG8bijAcuIrro9qkGM/qgJC1PrG206ssx3ckW3SvkE5RF1LAeXPw7to+hqacudZ8Q5LhZ9ZrR2gvVqgj+7tzTxeUUKvwt2br1owbx0w6GASk8JXDL8xc++3doQ/UabP1mjqKawejUXhwzx3svG3KE8SssHwUl33odGm6kAYrd0yUdAVt1ZiUxoOyEXoM3bH0RDYOaF92sqIKdEcpuYzA4HK12LMXZUuDa0eBSf06kcf6j0TiiVT7MGqEj6GSj+S92jA4LCeT3u5epQ0ihVdVCRhRoouRF0FPiNnOvny6WyMU+bD4moRA62S91g9moA8RuhKhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 19:02:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:02:17 +0000
Date:   Mon, 6 Feb 2023 11:02:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 11/18] cxl/region: Add region autodiscovery
Message-ID: <63e14eb6b350b_fa32929429@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: d625af9c-e038-4729-b0c7-08db0874aaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zA5meWobQHNxecHObeCHLh3cmchJFoImIY+iVOqlxgU75MvSiPxrI1iAl6AO+xx9R5bffkYL/mexjG3Lrdcfdg22Cb5aeg7ifMse4eXKLIcmhJA5g3FFWaqEZqZswm5MBEmnHHt9vinIDhPAXB3mVcpo4uup7wB68hzakra85bLnJe6w2U7ui+j8ABNQDXU2Do+oksWdcwntRG7xGOAiwCywXwb7BLY5tYfCDPUEYMy/AqKH+iKacpRIYPJU1k5Brf2Etha/HZmcGQSu1Vxbc4yEikg/wdK5m6czGRhfZBuNqZRf7299ohG/fpgzV1Yoe8xXoEF9mU3mZ2EX4eonMNxaBfXf3frqCrCBHYJKqkpPv/EDASpwWcx+LGP6Yb3FhEXbvwxjLEY19cq4Jr+W4+0GiCyTOIjF85/0L9JgrhgqlypC6giQ1DDVcv89BTuMFHHI4LDQua9qNvVcbhsSpkJWnm4PQmMnMwwbxHVPsmiNBnQUE9AGFJdky35q771srW1A07ZkH9ZFZ16liHUn6Aj5OXtMIo3WFwBms8K6y1rFIufVSu2r3+EEVCzjmab3EU5CP31x0dQSj6MyQ9pbct5kCMAt2P/gxcu4F8eHCM/vgpf8RDNhv+wPdvs4d7MGMNzLrV7p5AAcxErMedTL5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(6666004)(6506007)(478600001)(6486002)(6512007)(186003)(8676002)(26005)(9686003)(4326008)(66946007)(66556008)(316002)(66476007)(82960400001)(86362001)(38100700002)(83380400001)(44832011)(5660300002)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzRpSvJhzAxKec4heALKJU7JWbq0FR62Fxv5QDFmQkDIUJSDo/v9SbycM5/l?=
 =?us-ascii?Q?w6mP7ZaWMR2isK6iC+gOtKUKyYw7tNa+SUhHKmbPTY5LV3jmxv2Xk82SbQ/V?=
 =?us-ascii?Q?w7toGrWLYOdGnfVa2+Ed2YqLBGxerQCt/RGWa6x68dOV8CK8XosgYv32hH1s?=
 =?us-ascii?Q?gkVnsPF5dz2BQMG7mt4Siv8HPaTCaRVC/Lhq/Q2uD9/s4R4NKffTgOnx/N/V?=
 =?us-ascii?Q?DvDkmtKVZDHc2/jciEyHSJXCWgn9V1sHtMEI4UJkx+iUS14QfmLNK2W/m/8s?=
 =?us-ascii?Q?ob7IUn3KSTGr0l6XHifeoUW4uEJzjA0S9h/WSDYQbXxR7/yhAhXWLzQoIriv?=
 =?us-ascii?Q?gfgsMsDL7jlZjMhoPeArEMooq77rCXeu+fo4gYcnt2IQ8ftlrgCGBzUOwP0u?=
 =?us-ascii?Q?8H1MWn01G9TmFgk6ZXmbkYi6VsHsKPkOxclf+lonDkGfFi1q7WicFFb07jLt?=
 =?us-ascii?Q?vZZLD40O7Uu9Hq4rvHQqdpe6/ni+OKfd5liUqAx7ywLS91eGYKb/gb5rzhQD?=
 =?us-ascii?Q?e4UYw3+8ySscskXPz5ABBTAGJrWqV/QkM1lkzf7WZ/PAij3DKOFgzDWSHKDv?=
 =?us-ascii?Q?FxwPxSBr4pNwr89AW25umTYGvn93EfqGAm53CyfODITjO+G27CzI2DIyTTsZ?=
 =?us-ascii?Q?pYd/0u0YRJGuCPL083qVNxbz53KznmvoTmMIG7aK78v+H1/aK3ExD7j/AgNh?=
 =?us-ascii?Q?HU2HzphYCh1KWMA6SuhRnbt7Rv5qqmwVUZ7xnNfEbXKx/qkdK0Fwzhg9ucm+?=
 =?us-ascii?Q?c2mpuhH8mVsX6QO+M+Ap1vidQ/R+UVmfyrXY1XA86pBZjdd2BYVNzSjNvEYY?=
 =?us-ascii?Q?IaB1qNCPATpNgbn+zejHCFFiSM65dnWDlGiGT9GpYc4Qt6NqShxe2e9WkFPy?=
 =?us-ascii?Q?lNP3WnAStiy2VRXxKydm3nRlXFgB/Kd9llSIukAtmOdYPuCCe/auZEf1VBEp?=
 =?us-ascii?Q?ZI1iWG33vLEgBFa02tAiqDfjQimTfLP0jAIXg1sdWZ8a4z5rS7vN2La5Q9yg?=
 =?us-ascii?Q?KdzLIbgIWQd5vQQxSn+ne0KmTya/OJAcJUhO43BLfTEZOUT8IkowcScN8eNY?=
 =?us-ascii?Q?LjBzVj8hhufgolkJ8OJtGmV2PJc67mpNPvNazAhl5Q6/ixnTNLbH0Ap5NOT5?=
 =?us-ascii?Q?kHxCsig1+Fi6AUdBoTrq06EhNV2yJCLTP5eClW9n5f9MFI4JdDkjhiZGJ6WO?=
 =?us-ascii?Q?hlz/MLclYBIDVVz31QY5ot07hSoNl7wx3Q27BnKTSopX9obpTkHTXF4AaIzU?=
 =?us-ascii?Q?5fJa7Thhe3Gesxm1mI3MHMt7UtYpBA4CNjKlB+y9ERSu/lqL9zDgL6YWidVA?=
 =?us-ascii?Q?acPTJk0Sf5mkYJrcv1vL549uF+h3zmgEx+EBoohYHRD2pkKONbrDZqYUFYTJ?=
 =?us-ascii?Q?Mxl0g2a4WOK7UD4PAj0iU/5Zt/XlD+UgEainxikAtZ3mCcy9v7Fri2da02F2?=
 =?us-ascii?Q?NGE1Mbe9aDMJCpLELDi/L8BFwSxRNyXsp4FpGJhNue586yzxBaO9pyNhr0t+?=
 =?us-ascii?Q?G7qOYmCWuOTIMeVDS4cO5dN3tktx2w2WcKWNSXe21agq6F+B+W2BUI6xFoBS?=
 =?us-ascii?Q?8xYK0gerD1FtnOPMZPTrIzU8HPQ7BP+QTgkVFa12?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d625af9c-e038-4729-b0c7-08db0874aaad
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:02:17.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jwSz9EsmGm8Dm4lnaF1WLzx6PJOkKNFDsgzgXOVhWPBdj9ZAmnocGMgyYT+hoiBTryGbFXw4VFL2Sm+5T7T3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:

[snip]

> +
> +static int cmp_decode_pos(const void *a, const void *b)
> +{
> +	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
> +	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
> +	struct cxl_memdev *cxlmd_a = cxled_to_memdev(cxled_a);
> +	struct cxl_memdev *cxlmd_b = cxled_to_memdev(cxled_b);
> +	struct cxl_port *port_a = cxled_to_port(cxled_a);
> +	struct cxl_port *port_b = cxled_to_port(cxled_b);
> +	struct cxl_port *iter_a, *iter_b;
> +
> +	/* Exit early if any prior sorting failed */
> +	if (cxled_a->pos < 0 || cxled_b->pos < 0)
> +		return 0;
> +
> +	/*
> +	 * Walk up the hierarchy to find a shared port, find the decoder
> +	 * that maps the range, compare the relative position of those
> +	 * dport mappings.
> +	 */
> +	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
> +		struct cxl_port *next_a, *next_b, *port;
> +		struct cxl_switch_decoder *cxlsd;
> +
> +		next_a = next_port(iter_a);
> +		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
> +			int a_pos, b_pos, result;
> +			struct device *dev;
> +			unsigned int seq;
> +
> +			next_b = next_port(iter_b);
> +			if (next_a != next_b)
> +				continue;
> +			if (!next_a)
> +				goto out;

To me this check makes more sense before the inner loop.

> +			port = next_a;
> +			dev = device_find_child(&port->dev, cxled_a,
> +						decoder_match_range);
> +			if (!dev) {
> +				struct range *range = &cxled_a->cxld.hpa_range;
> +
> +				dev_err(port->uport,
> +					"failed to find decoder that maps %#llx-:%#llx\n",
> +					range->start, range->end);
> +				cxled_a->pos = -1;
> +				return 0;
> +			}
> +
> +			cxlsd = to_cxl_switch_decoder(dev);
> +			do {
> +				seq = read_seqbegin(&cxlsd->target_lock);
> +				find_positions(cxlsd, iter_a, iter_b, &a_pos,
> +					       &b_pos);
> +			} while (read_seqretry(&cxlsd->target_lock, seq));
> +
> +			if (a_pos < 0 || b_pos < 0) {
> +				dev_err(port->uport,
> +					"failed to find shared decoder for %s and %s\n",
> +					dev_name(cxlmd_a->dev.parent),
> +					dev_name(cxlmd_b->dev.parent));
> +				cxled_a->pos = -1;
> +				result = 0;
> +			} else {
> +				result = a_pos - b_pos;
> +				dev_dbg(port->uport, "%s: %s comes %s %s\n",
> +					dev_name(&cxlsd->cxld.dev),
> +					dev_name(cxlmd_a->dev.parent),
> +					result < 0 ? "before" : "after",
> +					dev_name(cxlmd_b->dev.parent));
> +			}
> +
> +			put_device(dev);
> +
> +			return result;
> +		}
> +	}
> +out:
> +	dev_err(cxlmd_a->dev.parent, "failed to find shared port with %s\n",
> +		dev_name(cxlmd_b->dev.parent));
> +	cxled_a->pos = -1;
> +	return 0;
> +}
> +

[snip]

> @@ -1500,8 +1766,8 @@ static int detach_target(struct cxl_region *cxlr, int pos)
>  	return rc;
>  }
>  
> -static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> -			    size_t len)
> +static ssize_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> +			     size_t len)

Is this a separate fix?

>  {
>  	int rc;
>  

[snip]

> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)

Rather than a comment would this be better named construct_empty_region()?

Ira
