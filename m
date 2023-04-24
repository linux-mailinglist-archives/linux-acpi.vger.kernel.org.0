Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8498E6ED790
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjDXWJt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjDXWJs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 18:09:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C3DA5F7;
        Mon, 24 Apr 2023 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682374159; x=1713910159;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KasPKYcdHbTW61Jjo/m4xyAai7EbFt0wy3N5nKbKJsQ=;
  b=P+hqkW2b89Gd1xXJng59ZerZ4tPO+EOaVWv+r850pKJXoT0K6+YDj+60
   zzKPQJpEO+Y3jPg9N+9RLsC0gGDZmElfJp5IyPSUccS3/+uWb/sThzoA3
   9IWjkoMYx42ymDUcQPTjJA+3Clxj6H5rgyhJMFAGGDlg0ZDMx2R9536sJ
   g/XWlVQXJINZo8lU6QI1zTiEcQjY/RqMTnUux6L5n6lHPSoFxGDmrjcHH
   OLPteRcQt7KDj/Bs20XfN/TOIKMR4mBPYI+p4jM5Oc4N74s4hQYEIvT+U
   h3Xely61d4PJID2oFnE5E2Oa9K4VHF7AgkDcjFiFTUsLxPlVSpyTJJEHM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326885101"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326885101"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 15:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="693244765"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="693244765"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 24 Apr 2023 15:09:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:09:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:09:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 15:09:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 15:09:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLTq66yeoVN/OivgojU1DQ6yM8jHWrfF0SKDs4QKMJJyqRRcmSbbXcuqUrC0qLMDSvMcpnbrHFm1spPJOqecBBhOFqYm6675F2yOwTmovZBXkvPNrdZYUM5npxrBOMaAuqYFPsRZh5qsb/GPce2/OMUZ0jJP/xpa0zT9jwHkTNtgCiigT6L9qXyYjWlkJg1SrhHGp+oy1bf4hoStuBupwKG4xTYzCev3scWqXoJV8nnFS+z1+FcPYpq18z+EJD8jJZ4okx88Z87+GgQFSuvR9PUh/tJGFQ54KPumbsTyrbOzS433nZidrv4WF9WOM3XpEpNQ3H4Q4WbK2ebbZmCTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9cxGz5Unc4cXscXWh++QmhQAxB6/owQRZqj/RnZZXM=;
 b=PzSAXkcuQ3YSQPVZ7knAEKNbZnN9I7J4tYUfx9JVaLSOIyRYitx6QcSt4buNnjMaVMxfyLdh+72AxLUtQWNn3oT2jyB8U0M/6eg8wZAtogyHArTtEz9rvHs49T+NaHU3P8EoF403zogFo8Jzx9pk/31Mz/boyC84puBirCaYyVtiUql7OlwLENI2GBO7e6y90zSKEZ9gemCkWTMPveEJJ7Dw35gA6CEtAq4smXZ/KzZOm/VcHe53uK51mz7Klrd63L5UwWbAxWTcfAVgoIsrUhpSnVjMW364QDVKDFrgp+ZlBR0pH7qAuFornDO2a0SnGgg3K1FxbYuKWjfpxPpSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Mon, 24 Apr
 2023 22:09:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 22:09:01 +0000
Date:   Mon, 24 Apr 2023 15:08:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 03/23] cxl: Add support for reading CXL switch CDAT
 table
Message-ID: <6446fdfa69769_1b66294ef@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193567959.1178687.13133878561024203176.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193567959.1178687.13133878561024203176.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: da51216d-f280-4058-ca36-08db4510820f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzmaFnYuaIs6npqMibLMtFJeVBZ+b31uKRANTNN8DmgZe1w+U2fIs+Nc+NVdLnBQ39gQbS5iSQR2OSmzHxi1wntMUmO5WxhCpYgI+OINt/bEpmNBsHOPhwL66KexR6K7/wFIe+VxZcUdjjNzzNoBS2a92MC8YFs5bq22oeMH/E615wLnfWAYpfAYm6g0/0maoUE301Mg1SU+Iucu8Cwo8DcNcdn338CrTQM1pLUTCpG9gPol3y+Ho/dcSBb03xZtmLZB38gKneAkeKn9fq2ZKC8ZXoEYiJPgK+qcU7X1W7kN75+iQMw/Lyl/3zh/0w760s7441ZZmESq0A0qC/QWY38ZQFwR0nYqOFs05JACX6swMSIWiMs6zfkQj71fPMokXXHYIUfb6ZxRY3jfpU9smOSERcXEebqxOhCBYdF3E9nInhvFxSPZTaJdMjwfece2Ce8Zz6pDsF4YrZ8lVRHZGAloMp0ulcaUGco2CbOt8XrjshhatGmggfVhJDultDqAHMYfi2VqIr55HEOouXcGTuyseO/U+kH0U8rBVVyp1go=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(5660300002)(478600001)(8676002)(8936002)(86362001)(38100700002)(2906002)(316002)(6666004)(66946007)(6486002)(41300700001)(4326008)(66476007)(66556008)(6506007)(6512007)(9686003)(26005)(966005)(186003)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vtDUdOtaa0u7hsjVIfsBJVyw2Bc8BTPGa1xUUB0SH9AWw6E03i6Yef7TvBoh?=
 =?us-ascii?Q?cY2kEgFFkTh05+gaRFh0YC2nHKizbt4lTEHNVX3z5J/h0YtLdgKA4T+oTqxS?=
 =?us-ascii?Q?Ne+XWI3yM2MKmUD46pzO4JlUxp5RXH9YPlXIzHcSqKkDE7kwZnKbf2lGa8ik?=
 =?us-ascii?Q?fsYIL8W4vkdur5uc5zWoPxKfwQekkzkampiit8YiyRLmtGHJuyLqyN1HysPM?=
 =?us-ascii?Q?9HgniQ3+IMh9Xr6Y/l6/UuYxCL8T3Ig63WN2JtZcn5XcTdgMgWTngdqA4kwV?=
 =?us-ascii?Q?Drnz9PDYqo+d/vQ/kYyLEY6BqE/XI0BIHJLsFOKBEshBNFeZa8wsll/KtmtB?=
 =?us-ascii?Q?FkaIwqWOjbePPCrQ3rX0WllfOCEySz5gqA7wr+Abfgz+lkETegtD+lq2do10?=
 =?us-ascii?Q?RqVt7OCA28Tjw+0C+0xI6hyHgn7XcNGelYrqZzMzVBcwjZM9SqTGEhMNHIar?=
 =?us-ascii?Q?Gvg09dBXOCxg/V0UwlZsoqQcPzgE5cR12+bVD8Weawr4BrWGbkesEmzA2lV3?=
 =?us-ascii?Q?i2CU9Z2zpbYZLPH3gCZYswxJFFAeLq6u6qwX2Z1DQaLdOqjXO7p+2NqmvD1Y?=
 =?us-ascii?Q?I5efqB3XLKxF7YiFt1hqBCJF0cU6oO2oob1jgIfowAD3opQ3pdeXbBrmLYpG?=
 =?us-ascii?Q?gCxm7NeT+h0xaOj9DtHObNOMZ1bR32h4BMr/1PhO7gasvMOKSZc0kYccRrv6?=
 =?us-ascii?Q?342uKrbcASE+BBZURdv88GzUr94IIAabrrP7OVszK1E06ifOmYoXk43cHYWN?=
 =?us-ascii?Q?mxpcjHZLDWhJdJ+wDSGKd18GL+Us+PZdB5HXuVldL1jw6flj5HiCrV/kM9qv?=
 =?us-ascii?Q?VAFPS6FTsCjmIkgDW6EBr3IevxxlCcSuKSmgYIS4qOsdZPUi/W1a/dPsBATN?=
 =?us-ascii?Q?14J4VZBlJXz2YvmsRZGAJ7wVzBC/YM8Vmv/F9PBnpW3QIe8/bxf3+bdLhK2y?=
 =?us-ascii?Q?J8gYcm4FAFX+Lb3bLiZBC+TpPq45wTbVHoEEpPvjqGyqqySQdJLBswpy2u/6?=
 =?us-ascii?Q?uysCH3t2bOjlf1ahOgYJKiSmiOR0k5n4q1XqWbUWJBIyEmSSovGIpe51wW3q?=
 =?us-ascii?Q?7uADmfzBAmRTrLu9xVwb7hoJNa4nqzR9H500aTMRTtMcfKclo/17SCHpfozT?=
 =?us-ascii?Q?glHBs5/4tvKteCdtvgnxEE2SHHoV4meVJTMkxvKCvDVc6wHVEpV1dUuia7nW?=
 =?us-ascii?Q?iOnSotR6S0jEhJOkdz8fM6mFTc/GjBM5x4i3Q8WHnDTUybYvm1ULSqIsCu2r?=
 =?us-ascii?Q?qe1SU0T1uNRkOjIpkzCy/MTCEg/vGdidChXN3Z06sdLEzdwM8+sz1zl04RyS?=
 =?us-ascii?Q?8qGmjBkVylImZzAaa21TVBi2jRdwuByyMJGFQn2pani1pZ0WDEj8QM3oGC0c?=
 =?us-ascii?Q?fZhr8Xiu/061RW/rKdjFC0sk3LbVihdbxGduK09WDoJpiX9d6fJWYMGsLIJK?=
 =?us-ascii?Q?DjUovq8s8S2olrjbkouWXUfDZiDOLkNMcpFOYJRmN8VOUYTxp0C0sjOzjJsg?=
 =?us-ascii?Q?pUKgB+HGBltY2YjMEbPUosilUpEP+NfL6fOIUyoBrrR3xzZOLj53CP9e0e2M?=
 =?us-ascii?Q?1uIKUyLnZZ2FkNu9Vwg6gAEkJYzF5313K7zlXx9xC7Jlbzjpzw0j5FNCOryr?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da51216d-f280-4058-ca36-08db4510820f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:09:01.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdwOlSR+Cu2orZ/u8pdkmaKLWKLnpBiyjdx2MJl+spEHPtYc0SYUCag2+CIOIF1X4PtmZz/s/tKqso4W1sb4e6sfdWA3wr5DPdwTD46q8zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Move read_cdat_data() from endpoint probe to general port probe to
> allow reading of CDAT data for CXL switches as well as CXL device.
> Add wrapper support for cxl_test to bypass the cdat reading.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v4:
> - Remove cxl_test wrapper. (Ira)
> ---
>  drivers/cxl/core/pci.c |   20 +++++++++++++++-----
>  drivers/cxl/port.c     |    6 +++---
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9c7e2f69d9ca..1c415b26e866 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -546,16 +546,26 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct pci_doe_mb *cdat_doe;
> -	struct device *dev = &port->dev;
>  	struct device *uport = port->uport;
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct device *dev = &port->dev;
> +	struct cxl_dev_state *cxlds;
> +	struct pci_doe_mb *cdat_doe;
> +	struct cxl_memdev *cxlmd;
> +	struct pci_dev *pdev;
>  	size_t cdat_length;
>  	void *cdat_table;
>  	int rc;
>  
> +	if (is_cxl_memdev(uport)) {
> +		cxlmd = to_cxl_memdev(uport);
> +		cxlds = cxlmd->cxlds;
> +		pdev = to_pci_dev(cxlds->dev);

Per this fix [1], there's no need to reference cxlds, the parent of the
memory device is the device this wants, and needs to be careful that not
all 'struct cxl_memdev' instances are hosted by pci devices.

[1]: http://lore.kernel.org/r/168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com

Otherwise, looks good to me.
