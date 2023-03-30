Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D9C6CF7F8
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 02:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC3AJh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 20:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjC3AJg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 20:09:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C710A4212;
        Wed, 29 Mar 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680134975; x=1711670975;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GY/VlJ64/ED7A0ypnvAz0Yp4DZrkmpX9B1TLpQXp9XI=;
  b=ll3hIjTHPJRkbeBDYlVckpLEfhZcEhcF/tQP9ZEnvtv8/YpGea+r5E/v
   sJZLaajJUlJfHyiSbvFkNiO3hKxck/0IPksu1O2bWPdE4+ZMUxPbZ6e9Q
   HoHjjSf+ZaPyjLZ+eHl86SwntQ8ZKmz05wlP6dr3JnTZMq9Oc4nKSUpaG
   TYCeDhJ9+Evb0hM8dblSC3DWUqAnrUeS9wr6G2LFMj2Yh+zKpE6yk8OTP
   zFjYVcsFuMhCxOWb5oYeR0pmcU/KWYcItnXFO6IFILDVT1GKXp+BYIc9O
   vKcnWnvz1fSERaZD635gfoyei3QHfFuzy+OWlUCcI0vyUs+bvK/hU1T0z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368807958"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368807958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014229955"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="1014229955"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2023 17:09:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 17:09:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 17:09:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 17:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS816B7ze//4vPYx2+VQKJxGEobpLBkOPyXRYExMZ65PMJz5aXLD8+IqFxntXwn85Jj2tQ3WnANKnjToAXPb7RGLGi/6EZVc0iks1ZjsWGE7ypViApYOFtbhsu4OMaxsTMMM+6w6tZUK3LzO5qHtjHuq4DDLZhEXFWonvc5g5ueSme6bSD46QRJwWahsLh1u6w1A2A4qh0V8v9g77MdfMjSu8iIPriI0kezTMRf+Ob8jJ+NKypLr/6sZE+gzfAIty//RDe9AEw+NZ1lGSmD1vq+vqpL2q4vl8928ZrLz4iztKQkzappn54v3d01rN+i2kojrZDLyStapmKSk9VuKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gCfFovR+hXoCTdTRQA1AKgoaviExlYK7tJ25TU/LQI=;
 b=Gh/iVE8FI2SPoNK6mvgA+Cqu0a9Foipg/dEniHW2eg4yNHfUKUQq9LUxrXAYE1FzE3n+Zf16upE1WwME+Cit82h75xnUYq/8Ge4BU/ZnCstv3HfQgBBSjvtpeRBtr8Ebn3wtkJ64I2Bd80mkfu6rqlJ04TEkHkkHArj2R+C9hKsMnSDqdNO8sDvOa0/gVeTyFU0vROSNlgjwfNfIGIH4bVq2v4PtJkNFNP6oDZ68e0Bxd8K/sY0hUWPB9drcIfbmnBl7pdA0oOcQ5JndXVba6/Uo2WrXM9EOkdcmVAdKYjUyw9WH8WCmgUzh+R7YmFZw/CeJ5ptjWtgBNFz1XmMEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 00:09:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 00:09:26 +0000
Date:   Wed, 29 Mar 2023 17:09:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v2 02/21] cxl: Add checksum verification to CDAT from CXL
Message-ID: <6424d332987c4_3652cd294a9@iweiny-mobl.notmuch>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995345388.2857312.2421270054519644444.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167995345388.2857312.2421270054519644444.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ea6d4a-1fa6-46c5-2186-08db30b305e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bx7NUNZqWYDT8MgXNbowAqIp4FGzLts5cy2l7/5+j7qtEyZB6wsR0xlkqVXLDsSrwjY3xrnMPqKqAvzVm6bW6c5icKmkrVA+OY9TceHQM6SIZHO7dHuo8UOhyjIzTg67c5sOCcGK2WppMXMDA8BbsvN18pmVwL+M6iclwGVVGP9Au7mOoROTQHVaAl8rMRmmZFHKAWk3txsj+mFeuhiv6JsFWQOfEMqeRjoQUlPZCWDklrZgnEH02vbrcvrS6/Kp++wAwoNfpbu2dRWiwNiKPwl5W1plOnllEIVTmR0EIxxkhi1xFbxljDSPIudddSCahp2f+tIv0tfiO6KVMgpNWORTFmw8ZQ3s77CRv2bc5NMWQdnYEC9gaKQwcF2vR5gFIwQ+o+JJvABQNA22oK1DrDRkCaN2mpUmrX22Ek12v+idHP2XHlekaCibWov/d+DTC2iIADhpzZEtZxZW3Dg5IKfV1RdOKlLlSKyC5GaaZJpUuMOGAvwnvzx2vl1rvGLhi115Itl0jSMA9bymVruoPtfnQlzb2CjXEmLFSs2COxhd1OdMSciJYWHMxizrIMo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(83380400001)(186003)(6486002)(6506007)(9686003)(6512007)(6666004)(478600001)(86362001)(316002)(26005)(41300700001)(4326008)(82960400001)(66946007)(8676002)(66556008)(66476007)(15650500001)(38100700002)(44832011)(8936002)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkyGQEZ/F/H9oZ2jGxqA87NBmp+9xinWUhfQ91Ko2XDkptkRGYmzBNAs4gMz?=
 =?us-ascii?Q?hDD9AD5dMzI7m4SGeYVYngDgcnVpsCXdzWFkpVdBQsONQiBgCr+kY/aM/edM?=
 =?us-ascii?Q?NK2ga1xscImUHS9xVn7jY2WOWioQD5CyYqhWsJy4OS+y+wfOD4W84BFxB6na?=
 =?us-ascii?Q?wi6S+DaOgIQvptM/PLTIX9ouA1VCUOynrvDqvCzHzpSrs2rmns7eLbu6n1Qm?=
 =?us-ascii?Q?Mng7BmrvhS56Tz5BUQA1e4uyseBxTV/+glYmj0UAguu3Zo+O9gdyxNUFNF95?=
 =?us-ascii?Q?tv1xgv6FKGgGATMbzCI3e0FjeIyhWGSsgsYQ7Mxm5VO35kRc8k4nWkKcbKrk?=
 =?us-ascii?Q?w8opTs5ogYBtcWZNoeZkm7JAeN15OMwazSzkN+nPGWYRqQrr07w/eXOu/gLo?=
 =?us-ascii?Q?tWgKVnrBZC+JU5JZER7GEzjKcH6kuUvmgNEvjLWy8KpFCHSwlPx/PF/uH0MU?=
 =?us-ascii?Q?ieHpN8xX61H0ll7rhN4hdlnR/WOdmbjFRkHlBTNPi29dBQoLXxLZS23te9GD?=
 =?us-ascii?Q?CW+RDrPLyaILagwNhzMyEdGF0dSRDOJK4SJUYbkcVcYfxgw3K9n5l87jDTOo?=
 =?us-ascii?Q?so7gUetXDbE5VnOdR29iYBANPZawFrNuHwmUaCiMFchRx5BU25KEmcaFzqQJ?=
 =?us-ascii?Q?k8YuljQNirMKZw/om7dcKh8jgEygYx9nIciimlZJqeIszZ6sO3B7pTQ+bRys?=
 =?us-ascii?Q?en1ZdPN+rYdBhtZACeNJA/7Agdpt7XOv+RkfBDWPA9SWRzY1rvULsXHU5lH+?=
 =?us-ascii?Q?a8z4kY2v1JvKuuBsVZYvyi9kyOFWfdNYoE7SyNS8ZQYNwM+xSgJXiFtJ4eX6?=
 =?us-ascii?Q?II2KRJYwOQLFEhtFELgMU1Es3vQU8NN9CYP5f7afSVCPvZ+ucvjOh9GaO65m?=
 =?us-ascii?Q?ea8uMQE66iVEgC2OaOWshQlR/wEaUmdlVbBgl4qli6ufkou4rThMn0KCqiL8?=
 =?us-ascii?Q?nYhUplifEb29j+XgaFCdFbXCJrdaSWtZ9S9Y8W8s3wPO2N9XPb5B/xGC6Ctz?=
 =?us-ascii?Q?aSH/xiO52sXJB+H+FyCdKYspjepfc+kbLf3znj3yFWk83+3FMFDHO/5krpBl?=
 =?us-ascii?Q?9DMOB32e8ZGmW8jXt92SeHmyCy2EecSXlbkzSUegSgIc2qUL7hlef1ccQRqz?=
 =?us-ascii?Q?XyNz7xNP0ydgo1qYUL51lgEjfIuwcWWNVG5ooLAl71xa75e9f1Z1sr8Eo4hB?=
 =?us-ascii?Q?+annQQM8cT3Sy5+0BMIHEiczP6L2Bz664uK4bLNj+PZrj3BH9QoJ/MuTvAGw?=
 =?us-ascii?Q?bLhoqGOiaM1SoRcPRGW+ylbcTTf0tzFzRV6WYW51QV9kdRJbjPm/cResaHtk?=
 =?us-ascii?Q?HHe1MSD5Zlz2kYe/lzMXPcj2Xvx1r8IqVZLTYbT8Hj94KjqMCOdoQPMGp/OU?=
 =?us-ascii?Q?iKdVC4lYbMilVfMvIigVat3VSausK/I2uuvjzwTgwlZDgWu5EGPuJDBXIPLs?=
 =?us-ascii?Q?EPAGgAJFOwb/XyfeJsVxSmHUFLe3xx2NVzAgBmCj8HpcJBgbDayOR8S6kgyI?=
 =?us-ascii?Q?4rUgELueQ+c3IDmlYU62ATRCDQldK7VH2t600+P/afmUdjJs0AWlGiouzMlD?=
 =?us-ascii?Q?oyTXF56UuPR1FXT26yT6Xot0aNgcjwAvVN+AYV2Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ea6d4a-1fa6-46c5-2186-08db30b305e4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 00:09:26.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg+Hs2JckINfYooz0Rfj2CSoOVtl0LgDv264dUPqjT9UI+BsaIQkDB8MliFbtJ6jEh4+Olg0Juojnf+UxwNA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
