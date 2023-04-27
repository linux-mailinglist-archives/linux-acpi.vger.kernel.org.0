Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFBE6EFE2B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Apr 2023 02:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbjD0AJ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Apr 2023 20:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbjD0AJ4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2023 20:09:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F53AA4;
        Wed, 26 Apr 2023 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682554195; x=1714090195;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dTygScj9qOYA3F4X1xv6ysL/84l5LiK+oiDKEK70l34=;
  b=NyYZqBWKabQjoT2RdT5quXgvv8vUgEtD1S3f/yjKV5xHFF2fay81a2rm
   Q0Bikvyqh47TT5ilm4ozC8TB0lazJuV6PnZYNHaPlm4mOYBZtSdgx5kmH
   Gv3su5yMzp9zcVB8kSj93e/IXk2r29PxnfXrAYtqnacZ0rIGtVoMLTJwD
   XjhQRLZwdUs8lk1Nt4n7qHcgy1s6ZZYujbgdZPEbyLmwRyO5GWwS5gVsc
   OxbkCOsnMkyIaRzxPD98zjYGAjjJ58GY1Oj8hQJ5qw7wKJo03hJF2j7+J
   rzUbOR/7b8bD0J1UTsOLagwQkRNjdJxJEannm+GoTDBS3JR0dWdLFSlJH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="375253225"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="375253225"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 17:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="940451971"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="940451971"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2023 17:09:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 17:09:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 17:09:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 17:09:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 17:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckMO2FSwbf6kIM+ZktcH+647Pq+T8LujgkR1fS7vHfLBS4Lt8VL4Eo4lyR1Bgq6NKAsneXYNEDvAasbWZm48H1dhFsnBsozKeITmk8K16jZ2vZJPytJrX9o/uVRAf7kNozP4Y2dJbs9y4zzW0A1Hb5SI/++if/RDk1ykMCPvlnoQdZOP1LjXGNJFKnGU53IEeBygsLKvb4MxGyPmZvKstjXzaMOJiXijDEzdRn9bCTleHkzgLOLT/tSrCwMaEcso3j+HOVlsSBr4JxgyK9iM2m4mFBh/OUv6mOCJw7L9k/18r3mlXk+4ZfFNBjjtYxGY6jxDZULd/RdbOKKu1nLa1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNghK4zzjMAGrqQQQDWBIOaSaG3insjlrM+Kcjwb7Rk=;
 b=J8zTdz/f7L96zBSJOn8n8MYD83PWpBpwqExzplQ5Jboe0ZL2Wj/V1O60uUlz8/FlLGetQ0oenFBEyS6n0tyZJ3hwmWANKF3co1tbN1DchhgeFzr4AAcjM1Ek3sz3ePqI94WtgdRwqpHVEg1OO881VZkkcGzD+sIpCjbwBOSg6C+lYXmQ9W7rqiXtZnDDTT4GMae7e7Na2T2zQUWMscPzYKBpcHwHdltbUi+R2yVE4R+s6bqwqI2M6eStOIL3T73ZVk1Wwx/jffoCR7MHo5v/SDE1VL7cE1R9aGmveeRbo04HcpM+02+UuletY6kCLyLcQrLc6zSumsh3Rp9gGbwMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 00:09:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Thu, 27 Apr 2023
 00:09:50 +0000
Date:   Wed, 26 Apr 2023 17:09:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <lukas@wunner.de>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 04/23] cxl: Add common helpers for cdat parsing
Message-ID: <6449bd4b89992_2028294f6@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
 <644703a1d25c2_1b66294d9@dwillia2-xfh.jf.intel.com.notmuch>
 <42b3e292-28b7-f19b-81c3-5bb40974c913@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <42b3e292-28b7-f19b-81c3-5bb40974c913@intel.com>
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d4f7b9-0c43-4e42-bd69-08db46b3b77d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rVsPxPry0KUrmvl0CXNKMrsQB3HhENgMiPfXNsLEbqrsMUW/eXEyF3r12XPsX3DkYc+X3GPtj9DODXH1bdOOyMxrN1hoD+oLBPTtsnWLCLrhic4M4FOWk5A/MKlGs6U8kWDNm1wpEe2hwV8gKYOHbeS2g+1y+YrDw+QD6FUBl6sHUin0d6prWpu6enJ4pCt99d+P1gzbffj5fH3wbTbTLur++dr3JBATO9pJPbNg2Rs9nK1XT846oiANkJqD7FKGERg9oZNtsjr3RVLWloJGTxYlGx+0zARAfpfdVWG/nsZU7BC+VxYIRuZ7n7Rat0gfwvd8ZKlD3s3H6pzZImLl3pvInyFJWS6/T8YfiyEibSYFQ9mzIgaU6D9ZWnna/DSlcuCxZCk5l7RNbp1ta3hfOh3KwMEFOLfzFLBv6qoRWaufLrKgV+rs8qizjn0zafvu7IhJdeFbrAy+D1m57HltsuAw1ykeXOU9/amGA0yuabgWC/0JtlF/mYc8m/RNqBFa96b2EBaYiZ/PUooJycVh5TWTFzZVys7vwWL7AYwv3ndIW5mtWKlrtSX8Y+yE194
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(38100700002)(26005)(82960400001)(6506007)(6512007)(53546011)(9686003)(186003)(83380400001)(5660300002)(8936002)(2906002)(8676002)(6666004)(4326008)(86362001)(478600001)(6486002)(66476007)(41300700001)(66946007)(66556008)(316002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6knoesi97UUkvqzWyjIRT2tXZfSoDugzfIWgFqpZaz+5ZaMlJFj+0dRLI6L?=
 =?us-ascii?Q?tGqzK3VxZ5uyZOTixbL2G18DqM7J9n49zwpLxmf11umgHg9ZKGUB1zCUMaIi?=
 =?us-ascii?Q?8fMYxY4+uttpIU7ElXJRwT+PLev0xRoy5o0YQbkMAEspNbj1mOjgjCBYBQuQ?=
 =?us-ascii?Q?1NSaBfyjXwV5gqMku55DDr4QBRefxgyJof4zyHRdIPzKIaUbQ5Qf78aRr8n1?=
 =?us-ascii?Q?cntKOA69fCRr1K/LsgjeStWmScbywJhDxbZPbfDNqu+OCoywH+/fXnjCn2g8?=
 =?us-ascii?Q?G95Rew0C42pBThtdjqL8Gn+6GE9IY+pKE7XoySOQ/JgMh4AhwwKnN2zfw12M?=
 =?us-ascii?Q?5mCjzb2jhExjyS6hd6iSdRUyT4gQH/59G+evGOkrk3JuOD1CBcGNwhS4H2jv?=
 =?us-ascii?Q?RxY6bdbgtgBkb5xLoAqNA1d87yI5n/uQB4M6bfZkS/zq2m6Lp/AhfALDE57P?=
 =?us-ascii?Q?ow+pQPShBIJfxbLP/Fj6v8XenD2ASvKPjROpigNaoULIFXSOiWp3w/lM2rxF?=
 =?us-ascii?Q?W6tJOoX3PqReu8KNtsRufF3tjkDifcNTa6kGa9TFc9VnsE1DdA/9OmeFKj0R?=
 =?us-ascii?Q?381asHeVh+nzj9dB03yIIezjpSWpakKH+U0ds/qQqt1lX0zA5WtbiFY+IP1z?=
 =?us-ascii?Q?M7CTMhglkQ38rJZCpNsq1NixxsWbIu03s9bB1YtsUfBOUglVpc0W0y0UXCqZ?=
 =?us-ascii?Q?sf+GIvS8VCB/PxqOhWaHZoF9dnQEuG2D1/9Y+rI7HGrkHEHRnMDl9wl0kelu?=
 =?us-ascii?Q?Q39FlddJg27v/U+3Nq0NdklgyWNfyxXNhFFJq63F7rbhxW6zam2ENdxyCEur?=
 =?us-ascii?Q?26R/CfjAzDNH/NRKAPbRPnwunMk1X8tpwljjZBQtVOsc5cE2bN/e4Qp6hV1f?=
 =?us-ascii?Q?N7bTymYVn+piBqJNDwIzCaPx6piIQuNtF0AqPe12GPKfyZ+2er9my4CDjAN0?=
 =?us-ascii?Q?4oRAmRetSO2VO+eYpJROKhmzC/Kr+M/E3tXRJkjphuh/gEYICzx5LtJhxw3/?=
 =?us-ascii?Q?xcA/7Hh+DPXJikSv983GVT6YsoCwJ1VcVWodTC3GYekh/BEpZkrGhG2tl0NF?=
 =?us-ascii?Q?e7qgbxnnkUB75i1L1NCJTtCgYpmssJfvJpsr4w227zpMV+qXkLJ3TpHVYgED?=
 =?us-ascii?Q?az5g7H3+wrwNYrENyaSIpgIV1XhEMI4d2WBZH3ndq6yO+tvVZwCNYkPtdqa1?=
 =?us-ascii?Q?1zEmHv+SD21yuiimvUDayN1V9Cn2aZLirreydrLH1fQ3Aeio59/cvXpPj0sI?=
 =?us-ascii?Q?Zg9SMek/5eC2Hl+xp7vfykHvKm6I5DmTn7lfsWoj8hYxAVpNNNbHZ+LFGbnB?=
 =?us-ascii?Q?qdNbF2Fdt0//WUSGs4Dqsqy08GRT7Ee7Buqp38kSAzPkpLLxmjHazJZSXvZV?=
 =?us-ascii?Q?RrIwjWWA1/C17cAv0lWVKdYRU0RsiSNENTniZvjt94V0xHmUBOxpiFlwt46Y?=
 =?us-ascii?Q?iyZl3coFhIDRvqPaZwinDYT+dRYeCb7TeWenxbaEoqtGn00dyG+3w/55E+xw?=
 =?us-ascii?Q?PvQCOuZ1BT+3QNBBdFbgivWwt1xllaty5+v5bR9cDUJzsNbd3UV/6rGWqDVE?=
 =?us-ascii?Q?GOFCimLdtdKnyFFSFInNy6lGFORWzJzZ9D3O0Onpi/CEnP5yZZnsp+E7gkjN?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d4f7b9-0c43-4e42-bd69-08db46b3b77d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 00:09:49.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofSUFtPLl3ADzoYciJcBmkhUWzfxrgn4JPQVmwzXUzGdqNXATu+uBGruLLoBD50oarG051hdQUqEkqRmfQABV/Erlba5rVhFi/fIXD/EYqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 4/24/23 3:33 PM, Dan Williams wrote:
> > Dave Jiang wrote:
> >> Add helper functions to parse the CDAT table and provide a callback to
> >> parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
> >> parsing. The code is patterned after the ACPI table parsing helpers.
> > 
> > It seems a shame that CDAT is so ACPI-like, but can't reuse the ACPI
> > table parsing infrastructure. Can this not be achieved by modifying some
> > of the helpers helpers in drivers/acpi/tables.c to take a passed in
> > @table_header?
> 
> Rafael,
> Do you have any issues with adding some endieness support in 
> drivers/acpi/tables.c in order to support CDAT parsing by BE hosts? To 
> start off with something like below?

Some additional background, recall that CDAT is an ACPI-like data
structure that lives on endpoint CXL devices to describe the access
characteristics of the device's memory similar to SRAT+HMAT for
host-memory. Unlike ACPI that is guaranteed to be deployed on a
little-endian host-cpu, a big-endian host might also encounter CXL
endpoints.

This reuse ends up at ~50 lines and duplication ends up at ~100 lines.
Not a huge win, but a win nonetheless.

> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 7b4680da57d7..e63e2daf151d 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -287,6 +287,12 @@ acpi_get_subtable_type(char *id)
>          return ACPI_SUBTABLE_COMMON;
>   }
> 
> +static unsigned long __init_or_acpilib
> +acpi_table_get_length(struct acpi_table_header *hdr)
> +{
> +       return le32_to_cpu((__force __le32)hdr->length);
> +}
> +
>   static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
>   {
>          return proc->handler || proc->handler_arg;
> @@ -337,7 +343,8 @@ static int __init_or_acpilib acpi_parse_entries_array(
>          int errs = 0;
>          int i;
> 
> -       table_end = (unsigned long)table_header + table_header->length;
> +       table_end = (unsigned long)table_header +
> +                   acpi_table_get_length(table_header);
> 
>          /* Parse all entries looking for a match. */
> 


