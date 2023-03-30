Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84E6CF82B
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 02:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjC3ATY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 20:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjC3ATX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 20:19:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D811BEB;
        Wed, 29 Mar 2023 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680135562; x=1711671562;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LQlcK3ihHxRY3quvEmFlDA6KV0T52gmBDSN5FaZfVEo=;
  b=Exx1igCUZmLVmem3kpH5/cXFS9WJkfbEqzGWcu7KUPaW0//OZIi0R+gK
   IqPRiV1VjoVUrustJlsqHAVDx1XWkVcDn9o/IXkRC1Odp18vcqRAnfJV1
   z1DfV2ckDWEH3kbuoAgJEAoAnJi/euSKwsSsRKFOGHyeJGViX+uup/Wi5
   ISI70zWXbQPZsjKhDfsyCoVvyxpBLp2+D/26xRPuZoHTBqSRydQlR7Q+i
   tqfLtdlKJa4y5iiXAHNc/JmQRaXwWoLUjPIyJ0j8sTuU43nqHXItB9u3c
   pCkKqXgp6DhV1ixYJg+ckJtNMKyMqXgCo/T1WP815Ykb/TYjhIQW1zDaz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="338533789"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="338533789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714793924"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="714793924"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 17:19:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 17:19:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 17:19:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 17:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARZCe3SveUZiFba8+2yOKdHKU/tFb+IzyAucQGIxatRAD1X+G/wYEo2b93wu1LzlFGxxZOnCeBXzINFEIoFVeWpomDwxBCMAkdeCIHNy56QvYYvBPzwwEiOGocbJtBGVdxPG+XR6D67mk6wCQvXO1tq2SjG2zNrSvU5hSFYkDCyDmrmr8EytAabIQwZ8RCmFszp1cxrjASnICfkE6UmBTJ/Fc33hpoF1K0OgWkL/y4HdLUSbeDUbAvAHV/W8BB9AQ4suQ6yREJS8ZuskiqkdU84j8jfQ4rZasprfo8AZeirXbyWVc7SwTq5/h0x2agusS+AUIZx3WBa7CwK0/Ijkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LddnzYy1zzSrpd4fmPTDv4JGTL1Y1Tkdhnlca+SAmtA=;
 b=PjAcZvoi/6iL82gK2uVCq3BvaVvo0wQfhAJIoyZ2GY8TYCJB3ktWtxrTQ2MkVB2vHnPb/SIA/l6IbgKTtVF2VKPPttKUmF3ll7uhI9fxfACy77fv+q48boTO/r9WaFhRWr4cibFijdpkrtHjWmD/4stmwJvOlm595jrCXe/fKRRvD/bKKC8LYCaAmE45GEuLUwwyzn4wKCV8ggrXlCbu2K/mo9YpPe7aJLOjHxUY5vpXejnzIRNrH3iP1dxKCuorHjyONhFiA5q1MPDwpPeduNdes+ISdTnzyIE6iKDd47f3SvC/qmk2PLdz0y8y0PLNLRwZhU67aff0DckGGUcUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 00:19:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 00:19:16 +0000
Date:   Wed, 29 Mar 2023 17:19:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v2 03/21] cxl: Add support for reading CXL switch CDAT
 table
Message-ID: <6424d5816db1c_3652cd2947@iweiny-mobl.notmuch>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995346010.2857312.16383291901753972325.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167995346010.2857312.16383291901753972325.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 2975ac23-6554-485b-a2a9-08db30b465ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IK7EUo0Xkivc5Czo+q28PV35bDGhzGszj+nPBnueZt2zhVFxLX2GANPqVUPp9ORDpDPedM+gmnsDf8ARQ/k3oyzr0IRG1tAUZgzLqcxq8yck8ej2or9RsfqdtV02VJGPyjTpI0qPCzaWiG6+4/zKTy+5IE8jRXUpFZA770fcfJXYrKiZd5i5zavGXLHw3Keqthqz9ALnik27rKgggRQ2ZD4TYS/8YbHDXQgKBRTluF3NYPBQ9XhdNNyrVpHvglHRBClTaNV2SW9siXtUiJP9ZTJioBxuGdJPGxziDoD4nFeKw+QjuNo6eaFBMU5l5iAB9fMQLqgI7gQW4hSoLtidMQMfIHabz9WboEj6qzPKlKon/NrsXI/BGaN3Y+NN3VlxyelgWogY8meO1ZE1TW8xnsIN/JSSuJ5YMU1K3QUKjPJUBVwmvLGnis+G86JzXt+aM27IfxMOcpUKSyj8rc5yiP0Qphiv17ET3WiZ40LTEW7/frVChWKNeDBd5admzA6JXjaKtq/sxBm5szxO7bg1R/B3483D/bsd7KWQlDw3NGYYiEAE41scsxUNUw/pcKy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(2906002)(8936002)(44832011)(41300700001)(38100700002)(82960400001)(5660300002)(86362001)(186003)(478600001)(6666004)(26005)(6506007)(9686003)(6512007)(83380400001)(66556008)(66946007)(66476007)(6486002)(8676002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYdPkd9euEC2T73q7AhEx4opB7HL2DQeBVPmmSzAWh90cR3P6RCLswHZ4Pzd?=
 =?us-ascii?Q?v2wi3Oq6cCzTTEyJOkhea2xW66tjrdlRVzmUATtgmp/cycKnZ8+7xr9h9o90?=
 =?us-ascii?Q?/S5myFlfzF6I3kd8uUe2aJbb/YiiRlLnzZW/5BDP1MMtRJAOmwMSs/2+iXdX?=
 =?us-ascii?Q?gJojhkCGXmWK2tSA5X/2iKYBow8sY6H87nhDxUvmlEMlcQUIG7imLOj18/eD?=
 =?us-ascii?Q?39rwcIuOP877z0prZnTPStu4Jx9O/eaccmRH8oGm2A5XzIWy9dzVOr7NkjTy?=
 =?us-ascii?Q?oueFWSbTEvDE5Mh1pirIWLwWfAzofwtWhjF3DW7+5X6xnSDEiCMc0nA+O0BF?=
 =?us-ascii?Q?i/qQyUbqI5JG1qeIOS0pzEIGpcXsBsPcBsPKVzZu7+N/dBBpIRciaR3OEnJy?=
 =?us-ascii?Q?znpwyGp+QpSHJkcBqDqzo+sO4Z2cBMCtNb/LDozSsYLDsmsG1dv1J7Q51hez?=
 =?us-ascii?Q?RmmbhvOIM3RSrkYwR1afmOk9CGJQAesRhD+WiVBZvpoUdIL4P7Q7YjKc6gxI?=
 =?us-ascii?Q?wpF6V4OIUTc+elQxNmmtIZ/czOCCZvcmL0wZs4lZ6xF/9NisxaFUCZSc4E+/?=
 =?us-ascii?Q?vCnrXWa2utkyCfiC5UqZirGB1uxt+V4cHUa7WhWEbd4YVOqDNkN6YAkcjGVE?=
 =?us-ascii?Q?tKZsnmGP7KzdFhs4PCSwcOb6VuZ2HU1dCL+G/PQU7fXQOcAnLi07rUUrOpu4?=
 =?us-ascii?Q?grAnlQNzc5JY5EETXiIWMsK3vw1MZGDHn/7Q0cSoqnlLEVbw32Hmq/sQrpWM?=
 =?us-ascii?Q?LiJYlqnhriSs0Hu9R+znMpyr5UF4Tcj+L/IxM+2nncRI2OQ2Nqi1dyjpQeLa?=
 =?us-ascii?Q?ruXHtKwh6BpfcEmK52pkb2MudCOIM+oqiV3hwuTX8Yy12BsFQpnrSxv0mjEu?=
 =?us-ascii?Q?ggOXzcQi5AGMumPEY7bjUIn2xFdQ2xffaZ4i+F/8Q3E0tBHMoCJiAkKYCYqL?=
 =?us-ascii?Q?/4KHYKBeuScAMqd6pJdccus7PWQGMIYomZtfHKaCD0iMgKadFN2p8XKla2T2?=
 =?us-ascii?Q?h7OX1ykAyFpeOCBqhItyepnwOyyF2f0K9jcBE+G7jMAkURUcVkJImzh9iWMb?=
 =?us-ascii?Q?mWtlank3yAQY/P2uVZrRDUi06k51Jnx95Y0dXOhmt1YQL5Zg+42281fqIdX7?=
 =?us-ascii?Q?QQ/YO7Toc0G4PhohnR1Y1SYG8i4qlQ6fNGoyefb13HB9Xg26f2BNrHVRUitm?=
 =?us-ascii?Q?Y9Vj0MW9Q2aOSStUL/ekv5O7+uvoiQtONpC2PPpVm+3uYxPZ8JHbH/xhZJny?=
 =?us-ascii?Q?9Hkt+WJ+SLlKOP4aEkFTlMj374EAyCEijKr8JnxlSm/NHRm1e1znWzr4lU6w?=
 =?us-ascii?Q?U0lgpvpzKsgRH2AtLzlC+QXkiraScUMk7zs37tYpeULMl476JOVxwLupUcTZ?=
 =?us-ascii?Q?yoip21U9aeyMg3uYMot4Af9AF/78/CZVX3NSkhJ/sRR2ZJOHk+iij0mhxIao?=
 =?us-ascii?Q?gfZ/lKL3wNBJVPc385gmwJmh/N6QI0bpBo28MMcSS00Et4kezKE78UXH3S9v?=
 =?us-ascii?Q?wF6ZGOKcwE63iGOUliIPymxFjMrdZ4+ZmsYIPRfAwkMidR34S0P6ppr9FeIT?=
 =?us-ascii?Q?ERYJr+JibzEeT8XOLOKFdYJhk/o21VS3VCzZ92dD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2975ac23-6554-485b-a2a9-08db30b465ad
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 00:19:16.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m53Ebiz6a4UmV0BkLCDffozMAQxz7nJsIZJwAOfF1G4jRu79soQ1Tb7x+x4MEpEgSjmamnKGXUCbhiOteyrmjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Move read_cdat_data() from endpoint probe to general port probe to
> allow reading of CDAT data for CXL switches as well as CXL device.
> Add wrapper support for cxl_test to bypass the cdat reading.

I'm not sure why you needed to add this wrapper.  Overall I don't have an
issue with it though.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c        |   20 +++++++++++++++-----
>  drivers/cxl/port.c            |    6 +++---
>  tools/testing/cxl/Kbuild      |    1 +
>  tools/testing/cxl/test/mock.c |    5 +++++
>  4 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e0d5e6525c0d..4241c7b8d5c2 100644
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
> +	} else if (dev_is_pci(uport)) {
> +		pdev = to_pci_dev(uport);
> +	} else {
> +		return;
> +	}
> +
>  	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>  					CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!cdat_doe) {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 1049bb5ea496..60a865680e22 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -93,9 +93,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> -	/* Cache the data early to ensure is_visible() works */
> -	read_cdat_data(port);
> -
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -135,6 +132,9 @@ static int cxl_port_probe(struct device *dev)
>  {
>  	struct cxl_port *port = to_cxl_port(dev);
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +
>  	if (is_cxl_endpoint(port))
>  		return cxl_endpoint_port_probe(port);
>  	return cxl_switch_port_probe(port);
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index fba7bec96acd..2637c71f3378 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -12,6 +12,7 @@ ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_hdm_decode_init
>  ldflags-y += --wrap=cxl_dvsec_rr_decode
>  ldflags-y += --wrap=cxl_rcrb_to_component
> +ldflags-y += --wrap=read_cdat_data
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index c4e53f22e421..3a75909b2aae 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -263,6 +263,11 @@ resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
>  
> +void __wrap_read_cdat_data(struct cxl_port *port)
> +{
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_read_cdat_data, CXL);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(ACPI);
>  MODULE_IMPORT_NS(CXL);
> 
> 


