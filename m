Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B470CF06
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjEWAYf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 20:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjEVXaH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 19:30:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576731B5;
        Mon, 22 May 2023 16:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684797905; x=1716333905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cg8L0f+Kf3RmC42ab81gqLoEDWORDhuTO83sqftep8o=;
  b=I6Lcfoo1dw6G/7Zh32B99ALzLPrWCxCIcCSoqt2dgqfXc1lf2yThIC4/
   K5y4FUFHReYikyLBn63DR4tihJPMiE9ESxheKt/Q6bA8jJGHT1MoJ5LlY
   wsy1xhA4K3fIE88odV3kBw/5VvsYn9MSHLGk/dt0QyqZGycOol8uVqBEU
   Mu2FR2/laff0N4BZCZ+7PNm7DsL1M44a17I65JQXZCYmlF4o/Ba4L8bgD
   PtDDPz1RACH3tzjFZVHAVWxgZY4AixD5t+EVFgK0Rdp0kQgamQxAA/TF0
   oxLlPgd3ePAimwDbpq21u5oYRYVdTjL3BEhFrtAzzRO0EyiK/IBIHnf8d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="353096898"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="353096898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 16:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773547198"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="773547198"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 16:25:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:25:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:25:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 16:25:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 16:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIbW0iiBzqjFTUVQeKgKi8q4Gy3bAZd1rUiQVWRY32WSYF09WCZdMTRQKsklSLHsYQbsvQDnE2sGOmnVE6m69Cfsomm1POYt99bsv5blucnhXXOqMBgYZvLOoY4qNgeOcg+E2lyToFA2v54g58l1486Or3dzjsF+uDfgdQUj8X6KkUhAxxYR3blTiTXi/PgzFjkABj5E+RVyAbw3aKPuXgGuvt2OfjMEiHq9nZ+mhVPq7xgtB7O6aQuO9lmSlNy8R/vNL2tJaS1ejlvWVaO2ZBdpFf72OQJ4/tLnS7a905WpQLgoJelQArZHpwbnSoAubtDQMAPk5lm5wjXosqw0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYTK1ykvxWet+u1tBPq0fyI9z8SZN+SEBWUY0FiFz1c=;
 b=RV8IVnWTNZzzFfvxTwkEe6HyGfQIsiVXYEcrOSovC51eoZuoG2MBR5xUCp2A9pDeZ2HqLzQKMFkaXu4Ya5hcYIWV2JJuYTsB4hseqlkFBULEkXq1Z8oOYqVPB4OWI3b5YOJv89jO/KyD6fXmqi0ujuY5gydsm2GNarc1H/1U6WJC22GO4AptWHmZd828MzsD7C3KMlua3iIp9LxojYaPIgmpL0qrZWDRHhfBhCp4RyZogBvSVYP6eR+bF020qACnpl6TKWi5jfVuAmKS08POVWJx754WbZ5aODND12K20a1vSe+tMICTfGV56GnSaXUMPHe954idzZzmWJQkoYbK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:25:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:25:02 +0000
Date:   Mon, 22 May 2023 16:24:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 4/4] acpi: Add defines for CDAT SSLBIS
Message-ID: <646bf9cbbbd2c_33fb3294e5@dwillia2-xfh.jf.intel.com.notmuch>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443480048.2966470.1931302851443645778.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168443480048.2966470.1931302851443645778.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef65709-d0f0-4983-dc29-08db5b1bc45a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLUCsa+5EKZGDhHXqog3BGU70somoM1jZC85/0mOGN3tpHr1BTsgCFJ56G9KH26xDL+Gba7MF64g5sryxRNUMf3NIJ/bLXaMEfE7IAMm/GjxeGsYpNifBYedfuWKwqS5MhlQkap6qI0MPeMxC2PlMgwshCIqw/Jr8gl41aJsBiJSnWjl8i03ChY5HLJKTQjoM1YZ1xL46+mIQpr9/jzLtebkgwPz1gRmjK/hERXg1T1t5gMv+J73jFd5/hZwy/MGqzVANgu4asDYs86jhCaUaZY9YXEpCLrbIOMgu3fm+hPuoU/OeW/hDteWnSx1OnLTI5gy1P7aquxxFv1127hHczElHYIOyrmLZ1PDE8f3Ttmxj2Tas+UtBTt3SwrpeGU64WFJNcxCrO4wCXjikCYjcQlVdcl8Tffvwr9wLl7syvcYMRCoWGgeZwhyyl/MePyNbpwVqn2w23YYds1GRaZKaVTuYp7CdDUSDJPRJu7ti2rgVUOt9Pa9NxUqnly4+ww/6vMfgVyODg6R/d0BP9NAUK8yiUFxkSTR7Fbnq4bcKic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(5660300002)(8676002)(8936002)(186003)(2906002)(4744005)(86362001)(82960400001)(38100700002)(26005)(6506007)(9686003)(6512007)(6666004)(316002)(478600001)(4326008)(66556008)(66476007)(66946007)(6486002)(41300700001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IE16/MDv3ZxjKAFf6fv8DdKaTjjTvEDff6oWP0RFkPo2av6bl6NrTBCO+yEx?=
 =?us-ascii?Q?S2axPrMVVfBnRgm4kfTH9Plw2KQZtXwjWJMjnHKJ+N/PhaYF9Q7fRupIhYE6?=
 =?us-ascii?Q?KRreB7VrXSJqfYs/d0zEAPWsOlbY4l93HtYoqjEj+GL8lmyK1erB9dBDXivD?=
 =?us-ascii?Q?ySBP2YjIMrZuKr7gf01aKTgJFzhx7k1BVwgm5xKT7oSK0ysfqiU9Km6f9ZJi?=
 =?us-ascii?Q?3EpljXhcJ71EqyURqAz3eTXQ9qfSiGFWGKSQA1gL0XCCKh8Bz1tI0NQ78hSP?=
 =?us-ascii?Q?6hjICTto79VK2AzlYFYS4fZIrWwWfnc0rHr2XXPhDTDPPRD/fc6244hGd5yF?=
 =?us-ascii?Q?8M+0jMf+03Y8lF4EyO9V2GhYDR7yvfs7z08CXCaNqhgylZlDDF+rP3aYrhWG?=
 =?us-ascii?Q?n4YZeZNOEH5iB6DsUf6+en/nRMHcBkEs9YmC0D+Ds+4FXNhnE4wS9q+tUsUf?=
 =?us-ascii?Q?kGfu/5GEfZeXWQFhjx7XYiXGqAzrOBhNMGJn8Wn01ONK4TGFGv5bgtMbZkl1?=
 =?us-ascii?Q?4jlWgghjX+8r/cgsSV5piqpEiIz8GTIDQ8MDJT/kHy0Myefil7G0/n030995?=
 =?us-ascii?Q?uricqR01clA5HUrWnKQWJcsfMudr/lhpBm7hinRTKV7tOZllXRWX+us1f1mx?=
 =?us-ascii?Q?g21ugZ2sSpXwP1HRchFg5d4f04IOi0e90mzEAmdBSchvhvIwS5oLBwhaHGFH?=
 =?us-ascii?Q?UsUc6p/EM4i/FVHKO1ce2Aei/D6rNAdp7aboXFAxG2p8bY5UlbNd0c0CNrOA?=
 =?us-ascii?Q?9M573R7Pp5C4gfB0vmq2xrDN/heCfGT2B2HcHfHA4alDg5N8oddJmG1fyS9M?=
 =?us-ascii?Q?evkQj5iU0aY3INQ5n1UuTnWeAL53V1E3BsEat9VeNpu6l4nTosIFmFIZhBQ9?=
 =?us-ascii?Q?W5CLqS5G+0IE44CmKiygtUJydcCUFskk7sXTT0dKK+iVwgsn0+U0YRKVoYRv?=
 =?us-ascii?Q?TGn36zytOQCzNfa3iiZSh2mk/IWplb3qh4jQ5FJqTsfgKgp1+0IVLK2ZH4Yw?=
 =?us-ascii?Q?bNqnhKHPNS8tdAYSilxv76oLuJ24R4k3NTIkzCuaHh7Y5wMyakg8gTGe33Kd?=
 =?us-ascii?Q?OD0r/kHQM6/mXEJvNDZcl9pTMiPqgJds+FCGCc/Y5lVaCIoCqreYoI+PG/Tk?=
 =?us-ascii?Q?xFqeU1ID+puXUrXBUsbbzI+gjjJCHzKwiETmhGv3sJeQG3CG4XI83sdFjwsw?=
 =?us-ascii?Q?muInu7CJNBAm4PEgNsPQIn7Yrc+z37rhp8D84hgHxPkeWRWI+UEhIf81ULkO?=
 =?us-ascii?Q?xThNETtpH9kcyF75Ic5k01mkw4nIh30Y95jGwgahwmbEQDSX5LZShd2cw88P?=
 =?us-ascii?Q?pdOYeX1oqJba+hhudO1dKH416vwf/He6+j5b7S8dv6wbaOsteRt9e1LZOi7I?=
 =?us-ascii?Q?dunRdg28mpjEmJcAkyf1Ynl4uD+RknIpT9dXXsFerBWTev00QERhCXBDZlsJ?=
 =?us-ascii?Q?bm3YZmGf3KtuuYCsCbnK37yjsOcBngZOoNVj4vy+tUhne/Y4UC42HiCswjAt?=
 =?us-ascii?Q?BDZugmdJtR9Lp15Qzz6o6THGC2dS8+CfKwjT+yXBpnYrJAygsD3rMJkxytq8?=
 =?us-ascii?Q?gBHxX3UzfJq72oCMyCl38XlrSpOTagOMG2RIvZO2ywJeW0xv1uAYL7Nrmir3?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef65709-d0f0-4983-dc29-08db5b1bc45a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:25:02.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4bgcDjaZy7fmFtPMzUHMbWM+yxAbLtDdmwgOj2e3lyejXiiMyksWGl31RxcIsiAPFRBiy+i46yKgA08gdgovJZC+uhWT2QXDltnTdwPTrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Add upstream port and any port definition for SSLBIS.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> See https://github.com/acpica/acpica/pull/874
> Merged
> ---
>  include/acpi/actbl1.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15df363b9144..c6189fafe87f 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -419,6 +419,9 @@ struct acpi_cdat_sslbe {
>  	u16 reserved;
>  };
>  
> +#define ACPI_CDAT_SSLBIS_US_PORT	0x0100
> +#define ACPI_CDAT_SSLBIS_ANY_PORT	0xffff
> +
>  /*******************************************************************************
>   *
>   * CEDT - CXL Early Discovery Table

Similar to the last patch, just define these locally outside of
include/acpi/actbl1.h in the patch that needs them and drop the ACPICA
entanglement.
