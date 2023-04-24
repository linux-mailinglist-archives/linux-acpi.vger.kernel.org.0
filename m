Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891326ED75B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDXWBq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjDXWBo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 18:01:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0798B5BA7;
        Mon, 24 Apr 2023 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682373704; x=1713909704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fFlN/BhJJ9UMGqbpBwsrGC0BS4DdlgmOLBX+srbv4HQ=;
  b=bxnFnLzTnmFbh/KAB1R6t2hkcYW0ohUlNJ2eybLoRxzH9v0Hg2ZS0Gm/
   lTF3VnAUH3v66mrvH9X4m4KPOKcHoqfC+dFB9PONfB1kXTQFbQCXWRJ99
   GHD3YSgPjRA1Z9W2j8zYvmIuIG3wHE4ntaqzPVmtPFtJeqFaMsTL4SxCU
   1akqwKlhLeycy8lUV5vcx1rtSNu2TTS1yUWLHHbHPQtp0e1QPILNLEFpY
   E3B/dymifPWLBm7Gi7aj6INp04OSB6I4RkJIvdObuKWMHkNZuwMgCc+n/
   QxxZap87flAON1XyzVoBmKy+ak9adVMF/dvadM477GgzbqfGyrC3Rml0u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="432842361"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="432842361"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 15:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="804789541"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="804789541"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2023 15:01:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:01:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:01:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 15:01:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 15:01:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brdFpMZXmIJA43DK2PbfUBnp5sYr/2IvqhC1skvEiRRzyt1QaMUqaHzHpB3qeyLZv5f2m1q13t3RCW1b2TapTt7Q+gk8RMfcfUKTW1kXI3sncK8WjvHDkNyNXcBEfxDq6NCOh7ZseBQOCk+1p8vnKeUwSrb0nz/kZo0EAe4ryLeuVxIxghS7stklvI/Jit7KsWEL06egGcAUorISFwc1r54CL0D3ctWGPjH1S5h/g8BoutVqQ+O5dyeiHIvJCW4KJ/DQeQEVF1PKoUfHRhO6zHosJ1MUi5GNbWsUnwykOE4/hEdVCb1Fd/bh/flXrjhLR8qNNCrNR3h5bipLnFz4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ILWpCkI8sBLcQdSfUdyBhP2dwoP9X/+9iGCWWHiF5k=;
 b=Wd0TYHVek6fUQ1G0BM+lISjDsNdHu8BjztS7lt0o/VVn8sXcq0amR7hNwFOP6fOXL9QTiRxF/ocm73Noh8FKv7etrSNPpJoZmPsbTm9T/GhLC6cmw3fbsMl01IdG+ttmr/mTWgIMFtqH/my6pWnpAbBpbU4oA8FR25BWZmFdZ/9ttW29cE1iXaPCFMK+pQFjk4z0dQ1/8pwZ07tSyndC53bZH+EgAeBZPLvxWLcY0ekkm0SXYB43UqVNQ69c2HtnTmiMf9rDQKEQ/RvyycmEwO0hdp0yyx+U+MGG5+mojx4oI1HiiptAA1Bcr5WjG299XuN49B6zJDL2UPEmHbhXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5305.namprd11.prod.outlook.com (2603:10b6:408:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:01:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 22:01:39 +0000
Date:   Mon, 24 Apr 2023 15:01:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 02/23] cxl: Add checksum verification to CDAT from CXL
Message-ID: <6446fc40f038f_1b66294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193567363.1178687.9185773070266307121.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193567363.1178687.9185773070266307121.stgit@djiang5-mobl3>
X-ClientProxiedBy: BY3PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bdb5f3-3d7b-44b0-7fe4-08db450f7b12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAEJ1YA2M3O6ABq9my/jB49osj9JqDSji2SVY7BXb1bsc2ykubKa+ZCAoH5zFJrNfn8sbmEbuU7JEaktLbBSMs4UXwzrcjfCBdb4QQtUsujLup1rKFotruo3PxL3jrrUUbbUD5pBFKJFMpaI/fBNhBIlotlaGBYjp9m1BgWqf0x8S3+UZFf5PO4bNV/dbfLLzFpiln6SHiXcJbLIGL8fCGEWk1m362btkXw0e4wMW8Er2Ey2Zd6PPoicKc4OBhI7Rd3Pyg9B60TTC76jxjyE+9N409G8kLkXpP3kf7uCQcOOiw0eRBjNjHZXGyYN2CJNVtWCJRL05ogoIvYWWIxkCA0S4xPGHGebxaHRJLXTjF3QzWaikz6Q4A/HnngmL3Hfqj0lPZsVCopu6vak3tbFTGNxHdxld/kKAQU6d6RsowKYnCEaeJW6U/+VdvKQWOndWj4itqzDWYEUzr00a936dH8woos4lWEid2f1gx/75bdJ1yca4s7IdxTuTPZNVHXNjGzevm9ngtETR1MiLe14pgHH+NUUCE1kuV03sRToXCslHyFxdCztg/Q9Krud5IPE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(478600001)(86362001)(186003)(6486002)(26005)(9686003)(6512007)(6506007)(4326008)(66476007)(66556008)(316002)(82960400001)(83380400001)(66946007)(2906002)(38100700002)(15650500001)(8676002)(41300700001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6PpJr2mvVpPSn7wGQcZICdtO1gdt1OQlYEpV9gWJtL2mXuUw34Ndl5jhkuki?=
 =?us-ascii?Q?hum+i4DkV5xtCnIOX5DrgR8r1JtiYJTcZIR+aD+gWQYFBrlcqIGO9Aw1coac?=
 =?us-ascii?Q?QvJ9eeS89srrRzhgdel+7yxJZ7h5cCsm9BbmnK+PaAVRcMqVdUj/kaWZHKAn?=
 =?us-ascii?Q?WX2QecCVmPYco44tlGnhFYLzBDL5FuKfdsH7XwG+NGjWP22x/M6pawrT151s?=
 =?us-ascii?Q?eYchjah1SpSYDKUbBCbgQHJSXBBl5LQAVq9leNFbgQX/hZfC2ai6W9Ae5eOR?=
 =?us-ascii?Q?cvdK4ZhSVpd7xwepu4QNe21XyaUjk+3fhxhYosIEmRIDu877THjweOHM0drB?=
 =?us-ascii?Q?1/y6gM+HydUFlp54vhQFx2gQAZ3McZ7xeIa3ErTqi6du3YgDK0QGuEueAANC?=
 =?us-ascii?Q?ja3M2wY+cyOs3p5I0Te9ZfvCLHwA/+Ea4vT4YGjcb9OTkqbpHWSyGr6Is/Hy?=
 =?us-ascii?Q?iKw0P3TNENV90MFVxDNvMY4NYIZqrUY3vKWfFN2vMKq5piOzGUQoO7WxTv8U?=
 =?us-ascii?Q?r+p258l9NFMhe3cJ+obYJU7Wf/iqUwQ91WR9+OBG8RgzeDQjaroi7c4KJhAF?=
 =?us-ascii?Q?oVvzO9GAvuU6Xq49WwFyWZRiEDP7fxHjU/ERgahdTAGy/R/r7vtOGXMfAILA?=
 =?us-ascii?Q?mcsIXOLmppZRSKlGDOJY86Cutz5jm/CHawtg4NZwu1S94+DZfMWK9Dv/IKVt?=
 =?us-ascii?Q?D9mWhmVG6CL9FxHNHH+WenXWb3RVDNmridfH+/ID7BMkV8l0ZgocsK0vw1qu?=
 =?us-ascii?Q?JrUTVGZZ0AerqV1pMNUvcKv+tAzGZfdC0sqvfd9Zutb2b9bVvSohYBYERA8h?=
 =?us-ascii?Q?ozylifECfSg1Rwf8iddcj3pONRsZseyoGpBqit62lBIMYBbARZmkDKhYgyJ4?=
 =?us-ascii?Q?XVa8PRW7jgdoZLGOkz7/K2JCsfDSRKjXyl+LiOxn69wfG745J/i1HQIpB46o?=
 =?us-ascii?Q?IGkg2cj6jzciJk0lrqfI49t0wQ3Tjpuqwh8qGRwGsw+fkBqRhhpYvNHMxiuF?=
 =?us-ascii?Q?Jt3OecLVGoQEywJE9voo8Nvon9hHmvpesb92iNWaQRreG54GHi/fnDOSE/GN?=
 =?us-ascii?Q?jCy5rOco634nbyXes/NUWbWYNLLo43s7yoCSIQDI+qfM9OdLcWAOrXwA0cNl?=
 =?us-ascii?Q?1dCChp+WG/Wy+rsdNUcvOhfcCz+yHyD8r2yPx1SwMMChTPlfeBHKHkn36M5q?=
 =?us-ascii?Q?VE/d+PBoUHNOLd6WwtwEL887X70Dd3/W/qHdc7+rllsuEfWai5k2WYUhXMWy?=
 =?us-ascii?Q?VQXFZ8xb9pJ2KGEiSnq7DIyzc6uqk7yW2ejGxdVD+YBdpw8nmjp3TTk+OJvN?=
 =?us-ascii?Q?v6rUhgAo+3myAyLY/GVXvpyytwwK9DSjuC4wOgvtlnIkhEooKt5QYu4WC7sc?=
 =?us-ascii?Q?G4g0OWI61QhuIp408h3H7wkwsngrEncg1xhQ3iZI4EVoOYDUismr/cNqnG6X?=
 =?us-ascii?Q?73Px2dq1broJtw0s3Xo5ph7qy6wdZE1sgLiPs+877OwITsszTM8+3y/qfkFz?=
 =?us-ascii?Q?ZvBvGInWWEegIedy4WyUBveI5ZIwkYGJXYk9kPo9mVH7uf+hC3cBTWFbbamD?=
 =?us-ascii?Q?aJY/PKOBSvCTfcECxxR/+edZ5nlr2R5k+So5nwwLTUduby3iiTqTB56rgmtX?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bdb5f3-3d7b-44b0-7fe4-08db450f7b12
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:01:39.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypw1I5K0bZrhk/EUtQHuN9VE1MGKM2SsnKLFvJOwwVYC/i7SYBS+sKn9pgODvnAqVKPciOpgDROBrAWk5KGhDlZZN/4GfjnKTFfLtrq6djk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5305
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
> A CDAT table is available from a CXL device. The table is read by the
> driver and cached in software. With the CXL subsystem needing to parse the
> CDAT table, the checksum should be verified. Add checksum verification
> after the CDAT table is read from device.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Just return the final sum. (Alison)
> v2:
> - Drop ACPI checksum export and just use local verification. (Dan)
> ---
>  drivers/cxl/core/pci.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 25b7e8125d5d..9c7e2f69d9ca 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -528,6 +528,16 @@ static int cxl_cdat_read_table(struct device *dev,
>  	return 0;
>  }
>  
> +static unsigned char cdat_checksum(void *buf, size_t size)
> +{
> +	unsigned char sum, *data = buf;
> +	size_t i;
> +
> +	for (sum = 0, i = 0; i < size; i++)
> +		sum += data[i];
> +	return sum;
> +}
> +
>  /**
>   * read_cdat_data - Read the CDAT data on this port
>   * @port: Port to read data from
> @@ -573,6 +583,12 @@ void read_cdat_data(struct cxl_port *port)
>  	}
>  
>  	port->cdat.table = cdat_table + sizeof(__le32);
> +	if (cdat_checksum(port->cdat.table, cdat_length)) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, cdat_table);
> +		dev_err(dev, "CDAT data checksum error\n");
> +	}
> +
>  	port->cdat.length = cdat_length;

I think read_cdat_data() is confused about error cases. I note that
/sys/firmware/acpi/tables does not emit the entry if the table has bad
length or bad checksum. If you want to have a debug mode then maybe make
it a compile time option, but I otherwise do not see the benefit of
publishing known bad tables to userspace.
