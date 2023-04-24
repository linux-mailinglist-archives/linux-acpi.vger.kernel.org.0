Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339CD6ED8E2
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 01:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjDXXj2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 19:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDXXj1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 19:39:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90249E5;
        Mon, 24 Apr 2023 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682379566; x=1713915566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4di1eleXhJvD8YI/qS20X23feW0w8B4dBfQR1SYuack=;
  b=U41DdvqiM/IVxZ918/+ywq6k4dm2UrZKGdAihC5ODQsPl+s9Sr/PsIHC
   DNmXrfSSws51A817kOHn6tFV80CCa6y2xSdd4dFmNARVt2aCLbIV6z4cG
   5g3Cm9g5X/ikyM8AWEzRPkxoIeRjLOJdddXDwk9/VREcfxY5GkP0IFADN
   TF1Y7Ol20yclNLlX+IoMhBRm97X5cAhjfTpZS4Uc9DomlGzplHnZdVsNj
   JN6iIT97EK4SzeExhrkLxVv7ZVUuu9lg34toEixyKdcojiRca6wWc5cV7
   L1I35mM+iFzYFzfep1MSgIXDekX6f/ACGu+Jfidw+n3HM8LIfTnmZFhHs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="411884964"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="411884964"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 16:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="693266627"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="693266627"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 24 Apr 2023 16:39:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 16:39:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 16:39:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 16:39:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 16:39:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jik/yUzA+5fhLGIx9fk4JAEQ+i6Hfbk45VTRukK+hRQgvHWjadwGJTs2E8GqIhnlr36WQ91vWjZTlSxcxe5DGkKZKJ+cytpxFID/3WtpEEu7M+UNq7Ouo44pTC+pNO6zLhlI30UedL2EU3Z18+bnGL3lm/JUwYWmNGW66Be/CwgDwURzdfpDzeUO9a1tyBsr9YiPVYRmQ1vvRshuD8gxsgNKQWuXoO/QJynaoB5aR6xSmHsd5jfTctS1ixTKypMYGhV221JhyxSRQzHIhjSQXNwDTv1cIG1mm+iLWd+L91zFxekIFZqsgp1rMFj4C+C3Y0EjlDHwhEu82hSSWMUbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5W+Ii5B9Nm8ne7B6Ztnw526VgKnIZyrIOESCI9wNbA=;
 b=kF5pbknMXnteqGcB41Y0Z/YjYS21xGAFLr7mosqnMjAIXf6R+HJE9JUuVCRA3S/5pIT5BVUKwulH/zTTYM6QBAkCnTfo/UxRf/Tl6TK2j8Qw1O7NMfJtD96R8IEIZYz9/29waRg4CsC20kFnWcta1JnVlNynPoOHUdwIjDBSAJLYsBd+ogI8Y7KgO5gIFzszSAi9YVVSEhKeIb32OlFi6DKI5qr9xSOTPMI9+9cKg/s91MKWXaoHNlko/r07TxUb7fzVC6+YNWmmMx0ph79x5H8Z8sT/Q+vokbLnOpPDG9jWa7Kse6djqWZtld7ZDl6nGcplZYjSPh1uDUxfZt6bXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4747.namprd11.prod.outlook.com (2603:10b6:303:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 23:39:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 23:39:01 +0000
Date:   Mon, 24 Apr 2023 16:38:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 07/23] cxl: Add callback to parse the SSLBIS subtable
 from CDAT
Message-ID: <64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193570345.1178687.2383268813534307968.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193570345.1178687.2383268813534307968.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4747:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6a63f1-0c67-4b2e-d344-08db451d150b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18w+yMUVR/vXRCGm+vTXqKxwLc8glKK0hwtqB4s/FqBC9+FSrkekYH8Tgx0Gp+vWgt8maz0xb1e5+UkmYh5AMAJqBV+ELGDJh8Jkt6UuV52HsKEW5MlGHxl/VWw8pAWJi5iQNT1yG5GPxMw+4eQiECNs1bbWbJqrttCbzLPchkOzcV1UOUgyavsiQ50hsHBeh8Vw8KsG4X9dFY/mOK12Jbn6oskfVy6UNNSG9Qf69ibutfhcbZbFo0wfrx4tDSLkJZeFocI53TidixK1uuqe2l7gQrBqqZfkAZCVa+MZETXd5tuilComZ7E8kD/93H3QUYuk/9NsCurTN652tLDdOaU71roUt9TBBawTUUsnmPI4KBfHLT9+O6BYm1yAMipDEucTGJEn9epD+kge098o0nZ1zXalwgDCw2WGnzVelx1D4tKIlQMRCebdPeUzFXaPA2WcA3ls225weCGR57T8ciD8nxuev9lXkOvmKdt6VVubJppjodcpAeY3lGJbYNumaBSC6ehrH0KJy8AXZ44jDmBlYxNuc1vti378rJUGlHM8oNyT+JxF3NhVqmEXchUr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(83380400001)(66946007)(2906002)(6506007)(6512007)(26005)(9686003)(316002)(66476007)(66556008)(82960400001)(4326008)(8676002)(41300700001)(38100700002)(5660300002)(8936002)(86362001)(478600001)(186003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BG+Dp4DH22tRzAu9Q8mFBN3BQo40aBrwUDYHwLJifu+q6Y++6l2nhsML1I+C?=
 =?us-ascii?Q?YDmiDOmTNlRBS5XuvnY8qPtn9oC26HCdpVzDPYMUg/aJuzEMfKVSy5bCHR3r?=
 =?us-ascii?Q?0JNz3PmdZxqHhUXjPigY7Evzj1mTngB43jhEajA4FTDewJweCC/UjABYH/qh?=
 =?us-ascii?Q?5bpbUhhMvRg/W/+e8cJpnLWLKzjGYa1Sj0lp60odQOSyb/U53+ipvHOzrOKG?=
 =?us-ascii?Q?LjbnUNRL0TXv+E045FwwiKtS4+kKz1PvGkK4TLnY2QpfYugwmgxBcn4vepxU?=
 =?us-ascii?Q?bHdGQdBu4J0MOOmg2kiAcZmYSBhyuy9JuscLI4+pcDRC6cugHiU4hiUb7OHM?=
 =?us-ascii?Q?0oKtcM6AL1znHtHsZUhyF40Ab+qoFAHtyn4pi1w/lhFbL3Dau87uZ2f6n8f3?=
 =?us-ascii?Q?MwRH3Hge4pMt2+1TowB4h0z1BHaasMTCRX1sY6kgLHgef2O9WgdOy/Ry1S6G?=
 =?us-ascii?Q?TWB3sw08xWojRsMl78fe2+0lqABoBTA2foC54QqjohCAqREucm6EbvDAyORU?=
 =?us-ascii?Q?2VYMS9dWHc6fi2Ym2VdEuA90y8tpD0OEax8kXmfT390za1PoMvkaX8mn7WAx?=
 =?us-ascii?Q?S5wWh8ILNqc/ITcKouAE/37elwPA7lDYKkhWNwcpvaybM4KqXYYVnzyJMzuN?=
 =?us-ascii?Q?k/jRTKFg7n1jFR7kqUgmqOcEhHu7bYrlfsVg4AHOaYmbcGnCBrfvaeOJMbGl?=
 =?us-ascii?Q?dTrybfTqS8DAHiGQf51usNGjHDdEpnrAEsexIIDTkkmzs5WOllPVAgHVU+FA?=
 =?us-ascii?Q?q/fNfrzDRlbrGpl6CpgWhQGa64z1dj5LpiEFM3DHgVqzWl9yjnrV61/L+W7H?=
 =?us-ascii?Q?rC2e8aPoCb20bp8hkcNhEgvadFOvLqJhaXnjXKW1hy2h/cqy3inE3Y7wCKPd?=
 =?us-ascii?Q?rqTMFvYFj0apeJBcYDDbSSljMJt4X4BG+XHtA7+CE9uGmQmYBKt8wqxNLV19?=
 =?us-ascii?Q?ISa2CwV+IrZ5hiyfEi9EE43s6uH5k4Sw7Q5qXDA7WiSRg4TWmHVvCV5GAijj?=
 =?us-ascii?Q?24aUnOBefR89XROz3EFvHa5xccGWpUlQiglcdPakQPlS8MG37W/dmb+E43Ag?=
 =?us-ascii?Q?3SUIAu6UtLXxv/8zIC8o5F6utzlmE2kAZ4VNmFtzq2e33Y6s0ovjyWlyqHJD?=
 =?us-ascii?Q?FN2Btv+iPWHrAKso/+FUsggmO9dQxUcNmGNpBQj6JW0LvUJUhXuTu/UDdmxA?=
 =?us-ascii?Q?aV/o4PEpA0bUUl/jt9m4f2YOd/abpAYAYJ+bsR1etbPaawIw07nZx4eq+p44?=
 =?us-ascii?Q?GKKgM8L1O+vox2ra8oaTOthGsuqgfAOUveO+CfXOYAjKJBtJcEQ46oeOy4iC?=
 =?us-ascii?Q?zqqt0JeoYbxbYtwIcL95zM/AQ9SYTRRyh2NzbfKvnXPojGXn8CORSt5yOj9v?=
 =?us-ascii?Q?A2Bl1DSp7La4erD7pqKTuPgmMIpFqIXssRvotpfwjZ6G8V0NN4Nt3qHsx3S4?=
 =?us-ascii?Q?JIHJQfCK061dMpoQg2N7lCcvXECm/fj461vjGSZJifwXw9qdkO5EcMlqVNGp?=
 =?us-ascii?Q?NTMWaM4Ei+ls/TZoR2KJqefin1nTNAAfsXWEuhQySuahdxxMMLhH+ctnWddo?=
 =?us-ascii?Q?VhHQFLrrEJ8LHtMCT/NlJI5OZocZ4SALjCQAijT8e4qelbgQiRGnkgrCpiOX?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6a63f1-0c67-4b2e-d344-08db451d150b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 23:39:01.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G39jdlR/OD9fK+dJ5Nyswbay5uDQBwbPuJWAcmeMpIYZ1UixViZkZ3mUZihRlQ1sed/B5Um2KqDaa/eNKztmkrtozc75TApxcMn3vyk3lX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Provide a callback to parse the Switched Scoped Latency and Bandwidth
> Information Structure (DSLBIS) in the CDAT structures. The SSLBIS
> contains the bandwidth and latency information that's tied to the
> CLX switch that the data table has been read from. The extracted

s/CLX/CXL/

> values are indexed by the downstream port id.

For other readers of this patch it might be worth mentioning that this
corresponds to 'struct cxl_dport::portid'.

> It is possible the downstream port id is 0xffff which is a wildcard
> value for any port id.
> 
> Coherent Device Attribute Table 1.03 2.1 Switched Scoped Latency
> and Bandwidth Information Structure (DSLBIS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Add spec section in commit header (Alison)
> - Move CDAT parse to cxl_switch_port_probe()
> - Use 'struct node_hmem_attrs'
> ---
>  drivers/cxl/core/cdat.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |    5 +++
>  drivers/cxl/cxl.h       |    1 +
>  drivers/cxl/cxlpci.h    |   20 ++++++++++++
>  drivers/cxl/port.c      |   14 ++++++++-
>  5 files changed, 115 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index e8b9bb99dfdf..ec3420dddf27 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -192,3 +192,79 @@ int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
> +
> +int cxl_sslbis_parse_entry(struct cdat_entry_header *header, void *arg)
> +{
> +	struct cdat_sslbis *sslbis = (struct cdat_sslbis *)header;
> +	struct xarray *sslbis_xa = arg;
> +	int remain, entries, i;
> +
> +	remain = sslbis->hdr.length - sizeof(*sslbis);
> +	if (!remain || remain % sizeof(struct sslbis_sslbe)) {
> +		pr_warn("Malformed SSLBIS table length: (%u)\n",
> +			sslbis->hdr.length);
> +		return -EINVAL;
> +	}
> +
> +	/* Unrecognized data type, we can skip */
> +	if (sslbis->data_type >= HMAT_SLLBIS_DATA_TYPE_MAX)
> +		return 0;
> +
> +	entries = remain / sizeof(*sslbis);
> +
> +	for (i = 0; i < entries; i++) {
> +		struct sslbis_sslbe *sslbe = &sslbis->sslbe[i];
> +		u16 x = le16_to_cpu(sslbe->port_x_id);
> +		u16 y = le16_to_cpu(sslbe->port_y_id);
> +		struct node_hmem_attrs *hmem_attrs;

The more "node_hmem_attrs" get reused the more it sticks out as no
longer a good name. There's no Linux "nodes" to consider in this code,
no hmem since this is switch path and not a memory node, and no sysfs
attributes (which are typically named with "_attrs"). This data
structure is just a container for passing a tuple of r/w-latency and
r/w-bandwidth numbers. It's a performance coordinate that just happens
to get reused by the hmem sysfs nodes and now CXL cdat. Perhaps 'struct
access_coordinate'?

That would also make this code more readable:

void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
                         unsigned access);

...vs:

void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
                         unsigned access);


...at least that seems more readable to me.


> +		u16 dsp_id;
> +		u64 val;
> +		int rc;
> +
> +		switch (x) {
> +		case SSLBIS_US_PORT:
> +			dsp_id = y;
> +			break;
> +		case SSLBIS_ANY_PORT:
> +			switch (y) {
> +			case SSLBIS_US_PORT:
> +				dsp_id = x;
> +				break;
> +			case SSLBIS_ANY_PORT:
> +				dsp_id = SSLBIS_ANY_PORT;
> +				break;
> +			default:
> +				dsp_id = y;
> +				break;
> +			}
> +			break;
> +		default:
> +			dsp_id = x;
> +			break;
> +		}
> +
> +		hmem_attrs = xa_load(sslbis_xa, dsp_id);
> +		if (xa_is_err(hmem_attrs))
> +			return xa_err(hmem_attrs);
> +		if (!hmem_attrs) {
> +			hmem_attrs = kzalloc(sizeof(*hmem_attrs), GFP_KERNEL);
> +			if (!hmem_attrs)
> +				return -ENOMEM;
> +		}
> +
> +		rc = check_mul_overflow(le64_to_cpu(sslbis->entry_base_unit),
> +					le16_to_cpu(sslbe->value), &val);
> +		if (unlikely(rc))
> +			pr_warn("SSLBIS value overflowed!\n");
> +
> +		cxl_hmem_attrs_set(hmem_attrs, sslbis->data_type, val);
> +		rc = xa_insert(sslbis_xa, dsp_id, hmem_attrs, GFP_KERNEL);

I'm confused why an xarray is needed. If the sslbis indicates the access
parameters from the upstream port to the downstream port, just record
that access_coordinate and point each downstream port to the same
coordinate. Why keep an xarray full of these around?

In other words just add 'struct access_coordinate' to 'struct cxl_dport'
rather maintaining this parallel array of per-downstream port data.

When / if p2p support comes along then we can worry about dport-to-dport
performance, but for this patchset those sslbis entries are 'don't care'.

> +		if (rc < 0 && rc != -EBUSY) {
> +			kfree(hmem_attrs);
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_sslbis_parse_entry, CXL);
