Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776ED6ED95A
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 02:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjDYAdV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 20:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDYAdT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 20:33:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00259CA;
        Mon, 24 Apr 2023 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682382795; x=1713918795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mdiuCqvIW/xTezmhPR1zbzkaym/GvaFdyimusXr3hWU=;
  b=O4DNLKlrtMpXapBPB3p1gRQ4+zDa8aN3Sfr+QC62W18024EUHuyeV91k
   zrHQZVGJOyRjlA3fgwus1p0207yJXoDCGByq7jfSdhPFtyGYAnZJPpdzS
   0YMFwzyAObgfXuAR6HKr8ncVsuSQV1abiaULu4j4cXgcAPxU8pC8/5VdG
   HM/q05XkLpqAJqwZyCJTCJ2wzGbsoiJG1Tsp92W8g8kOzpWIjxexk9bwX
   z0WOx3bv0yPulSBVL5EHyvfC5wqBl2FNUFSKvLsQusFn81T8fLQTCRYpX
   lgfgebllD3fCwxQwGeAcpyLtpygOnRftUwvLdjP4/weyvr/pimlTXVGCc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="330821749"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="330821749"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="687128178"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="687128178"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 24 Apr 2023 17:33:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 17:33:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 17:33:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 17:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9QUbCjRCwpeIwvJAFXp/TlIyaZ9wiUOsn7FuutXBlmdWC5gXOL2vbWIShcWBBO+7CHwvOpCB9yLyneMr7p8I8vXfw/+PgXKnE9sZzGkPsKS7sSN+q0/5IaxkOx9sO4v7pLVAkKYGn7xqGW7tBFt/ePEtPxouJbKmd1Exj0Y7rbW+J6WZoA1gC8PDhrD4MQhF9yjrvQ9pm4bYkaNnQb8FlJnxsqD93smEMlfWtl7pt3QGUYgf+E9//g5FTnMc25vFbzPEd85/uLaN3bdJwYTnS+/GvsaPWhWXHdR1+xZ3hCMEwwVC9OU2qX+Mvd6YV0GV37ft7H+EjCOfX84AOtkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jm1SZdh7aJ2T3rSr56PNHS+lK1AfvVWC2ksguuv23I=;
 b=hZ64tbC524gX6VZ5qi08fa+MgOsNQqQdI5opfi6rdx+opCuR7pfRp1XpVLJCrHIEoHrmPXRxQflIZHxtGcUAU17d9CaTBkVOND1ou3lPUAS+3ThAoDIQ2+O7Bw+Vo7FmMGs0l80uo64cy99P075xky5d5klsI766RHl2EJ0Z4asa9RocmfgUrPnFH7zzgzW+aG7hVUOQImjSRHwbFqdow5FTBO0j3/NxwzIxoD6Jxl/8lMeZzRLEe5CqFflyoLM4TqvnKUvefv/TVd8vXarql27dm7DNaDvROWEeJCn/+1Zss/rE2L2Zd5udrxybXCuDNJS7Ss/vgYY0xFsV7p2imQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 00:33:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Tue, 25 Apr 2023
 00:33:04 +0000
Date:   Mon, 24 Apr 2023 17:33:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 11/23] cxl: Add helper function that calculates QoS
 values for switches
Message-ID: <64471fbd2d9e9_1b6629482@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193572747.1178687.13347516490022640531.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193572747.1178687.13347516490022640531.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0183.namprd05.prod.outlook.com
 (2603:10b6:a03:330::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: e13a2abd-3fcf-4bd7-e0d6-08db4524a1b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzXfvHz3oSzrEt+TQZxTeESl7LA2mefiWmtXGXlNGLUNa0vBH4k9bFtUlHsi3or68xASZzIxakacPoSP0wYs7/3T5O+XpYUht4OsiaE9mHFNZrxYzzmkmofUka1KNFCnvafLE3XmqkFSIq0zcrfHqLcyyPFB27eBKlwDZWGIhfGTnnRWM2vCK5+Zolc1jBwCXbRKdcXz1hZpyf4Sr9+tPEg5zAl8hcJHzND9EH+51HI2FTLXJRJD6iXKkqCzCIloa2HTmtwH82EsnvWGk5xwJXuLq74AWykCdO/Qqgv+suojAb9QD987Qvf5qs+X8lSP4OjGwQYClVY/2ItXowIISXHTozmv+MctTpqL4YWWHI+OTGsreSEM2ApnNOPzUHXnQinIwuamvS7escpGjPDHWmSuj8pBo4dN+FWz5ftWUa04tv5MICMJuXqiLds8Ir2DfFODCqeVgcRmlSuSHonLhEK4yTyjm68kEOui8P2hcPi49eOJ63LaWh7UicuxbmZBryGYwB1/0k9OymLw+bzt8WLCuW/uNJXSebA3Qe77aDoxDHWx4mvxifFolHUZpnVo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(478600001)(86362001)(186003)(6486002)(26005)(9686003)(6512007)(6506007)(4326008)(66476007)(66556008)(316002)(82960400001)(6666004)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MmalmiwkdFcmBOdkV5lTzUh0Js8W6p/lFCqUul1FeDOhTwXsNFXgNxAMvaQQ?=
 =?us-ascii?Q?hU4N3qK297J9DqyrtRfBxbXOgbqGC48yIjUsXWOVxfF1YNlnYBd95E9R6gC2?=
 =?us-ascii?Q?cZO2LwC5o3vQF6ZBBKfzi8zV70wqp+F47wRQYM8S0T3aAhLCAMPKYLz5Fs3Q?=
 =?us-ascii?Q?7qHHMSXRBL0ZXhnIjgpg53ElYb8BeLygYFnKIBO3NLhDqhZ0BQFwW2IXELio?=
 =?us-ascii?Q?XB6eAa5QwRY1rBl+GfMIvNgbdZdYUa1glc/frJKyJyJJ2+tekB5+wuL0Q64r?=
 =?us-ascii?Q?OuQyUZv12Hc4fMUJXtSTQ7434DF2o1og3+1plucy+anG6a/K/mqHr2ZQlGrf?=
 =?us-ascii?Q?IZVP018Jil6wOK+8Yx/FCMM+q7swc4xrmLfssHhp4jeSE47kXC79BYk8ySsu?=
 =?us-ascii?Q?u/UiyJYmkpS6BWcdfkKT/30azIytJFifO68zm0IYzkZe0I6RzXqBVvwSN29Y?=
 =?us-ascii?Q?f9VNTLDxKgtSpK/LJs1/wrCkj8JPQB7UItSaDV4PXCW7oBUMXM4Na0cv9pyM?=
 =?us-ascii?Q?7j2yMsE1qMA6076WugXa/AYhPZPPFostW/hAs30bxhbjFJfBHQ5r5vt+XYTy?=
 =?us-ascii?Q?lrbvgJ2ctX2hsUJoTfqxEnPmht4jFyin+Rs64YIEtP5oHtw9mxVRk5I+kpdV?=
 =?us-ascii?Q?hkoUgEZKY2f/jDAg9bsEwqHH8TDKPRdar2weG4NjYQlojcOUQCwrCZs1IXpJ?=
 =?us-ascii?Q?sCkO/qVE8wCz/nxsu6KiJZ3keL3Fgl9txJycazBgqKiQG2Q2ZtrEI39UVfAs?=
 =?us-ascii?Q?8z9GYaQiHpHshF2VkamF7sobrz6LTMJko/jkieMBOa5hDAl+AZ3//6rTeyHn?=
 =?us-ascii?Q?2G9lKi5omaVsA8Aza7swwgnlPwI0y8gBYVbT5m6JQiaKHc7QwQxZcuKQ0i3s?=
 =?us-ascii?Q?hXRixRKb/4dEVbhhcyhEY10rqbdcLhw0WTpvnbj3qakb/nXG78IK4fw8i1Y5?=
 =?us-ascii?Q?u5VhMnuWEhQ9+YcPG6UwhkM2e+Nc9O3WdrKUmswJVTLfmr9dP5bgHx2R6OBP?=
 =?us-ascii?Q?MsLX8aFIWPP3tlPbubz0qGynLi1nTwZxpusTYhj6uA0xsZBN4VEUW0+cbBZa?=
 =?us-ascii?Q?X9EmmM3uBfm5StSXiV1U4WVDRM1BRYQd/hMJ9lBgHl138VmOfXRsobRTwrDM?=
 =?us-ascii?Q?HmqQ/QvFvaTfOzzzqPn+qGFP2fwvolmoiVO7PtikBNh63q/rk1vn4NqcZaxO?=
 =?us-ascii?Q?eNQlUqQdmvZI+LyNpXKJbsRoGYyVsilTDBcl3nQftyR7SVYkQv0Yl1QoVuZZ?=
 =?us-ascii?Q?uGoZbEsHAZ6L+Wu0ETDae2xhr8H2jw5+321UymqfHBt5QKhROHOakQHe7JXK?=
 =?us-ascii?Q?4akjakgIKp+Z5npcIBJ1/4ZgrACiwSHF0BUlpkD/BfxQj797RWb1cTV/cDtH?=
 =?us-ascii?Q?6xQ0zYh6dI6u9lqxor6KWRU//liJy6HZNm6JMHVbv/Y7BIhEoTWzVA48qH9m?=
 =?us-ascii?Q?qFDxhOvfJCzbQbqMhmmp4VKLjh/QFb7uIpQ3TrxQ+13A28AD7vAjc4xgwzju?=
 =?us-ascii?Q?EhIM4wure6yN8PfvJImYbfjR58q0kVMwsF/rhlQLljWcG7UAs/akEivh0hZj?=
 =?us-ascii?Q?eHCs4mYyOhRYtpR5AwqrvjKleA06udn+ncou7HBU4SwOLTaT3zE/2Ymly5kv?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e13a2abd-3fcf-4bd7-e0d6-08db4524a1b8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 00:33:03.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUfcYZhDjzF3bUAGVu6tWWTmvKAkszATmrFRgfJa3tXAGGrPKl8I/rsh0zAirqaEDnkBEstqcz28+WW9MZsAZ/mjzTJuysENTLQEm7t5G7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> The CDAT information from the switch, Switch Scoped Latency and Bandwidth
> Information Strucutre (SSLBIS), is parsed and stored in an xarray under the
> cxl_port. The QoS data are indexed by the downstream port id.  Walk the CXL
> ports from endpoint to root and retrieve the relevant QoS information
> (bandwidth and latency) that are from the switch CDAT. If read or write QoS
> values are not available, then use the access QoS value.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Move to use 'struct node_hmem_attrs'
> ---
>  drivers/cxl/core/port.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    2 +
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 3fedbabac1af..770b540d5325 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1921,6 +1921,87 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>  
> +/**
> + * cxl_port_get_switch_qos - retrieve QoS data for CXL switches
> + * @port: endpoint cxl_port
> + * @rd_bw: writeback value for min read bandwidth
> + * @rd_lat: writeback value for total read latency
> + * @wr_bw: writeback value for min write bandwidth
> + * @wr_lat: writeback value for total write latency
> + *
> + * Return: Errno on failure, 0 on success. -ENOENT if no switch device
> + */
> +int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
> +			    u64 *wr_bw, u64 *wr_lat)
> +{
> +	u64 min_rd_bw = ULONG_MAX;
> +	u64 min_wr_bw = ULONG_MAX;
> +	struct cxl_dport *dport;
> +	struct cxl_port *nport;
> +	u64 total_rd_lat = 0;
> +	u64 total_wr_lat = 0;
> +	struct device *next;
> +	int switches = 0;
> +	int rc = 0;
> +
> +	if (!is_cxl_endpoint(port))
> +		return -EINVAL;
> +
> +	/* Skip the endpoint */
> +	next = port->dev.parent;
> +	nport = to_cxl_port(next);
> +	dport = port->parent_dport;
> +
> +	do {
> +		struct node_hmem_attrs *hmem_attrs;
> +		u64 lat, bw;
> +
> +		if (!nport->cdat.table)
> +			break;
> +
> +		if (!dev_is_pci(dport->dport))
> +			break;
> +
> +		hmem_attrs = xa_load(&nport->cdat.sslbis_xa, dport->port_id);
> +		if (xa_is_err(hmem_attrs))
> +			return xa_err(hmem_attrs);
> +
> +		if (!hmem_attrs) {
> +			hmem_attrs = xa_load(&nport->cdat.sslbis_xa, SSLBIS_ANY_PORT);
> +			if (xa_is_err(hmem_attrs))
> +				return xa_err(hmem_attrs);
> +			if (!hmem_attrs)
> +				return -ENXIO;
> +		}

Yeah, I think my comment from a few patches back stands. There appears
to be no need to maintain the xarray if each dport just resolves and
caches its relative access coordinate at init time.
