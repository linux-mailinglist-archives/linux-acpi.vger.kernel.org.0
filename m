Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06C66ED6EB
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Apr 2023 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjDXVsC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjDXVrz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 17:47:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA6F8A4E;
        Mon, 24 Apr 2023 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682372873; x=1713908873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mOXPXhN2gKy+61NBj+HptZ/wP9N8Hckljm78D+1Uw08=;
  b=O8Ziu70So1uE1TxZLoYeB3YpHDr8SijjPIdMALaC/b2kV5skadmpUPBZ
   HpIKzMxG46B9fVUIYD8GvISeDlvDd2L76UjbPHRnwaHP30i1Sa3SecD1B
   TJk7RlsQRB9fxGlZrraipXs/aqBNDb9/NGKEmDwEaAyLazhUNVCNkqwJA
   JkOYFPpFqIsi/CcqADK1hqtXeIiylLx9fapYOY2yC65SyKfTnQ0YpKW+O
   YV7MR9R0qxpUawccjHR1wYIBlR5z73BJdHvF4a1dgrVEuGtEDcAMMVTut
   0AJq+bH4vjPdsbAu0yRm1FYt9niZEn9isQyRjUhuVuZuf4Y7MmqIT6OMP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="411856524"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="411856524"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 14:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="1022865898"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="1022865898"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 24 Apr 2023 14:46:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 14:46:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 14:46:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 14:46:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9zKGMTAXrYGNfyhnelXPIrlRSACT3m7f/Ua1QSLcCuXyXsNFfECqQbXq2gjRmk0rWA7Bx9ScHf7u7ua3uzEQVSMo4h2VDoUWPsV+mOnBfghlfwfjpJ9Ehy9NUxb1IZnjYMt8YSDL0gfYgccrdl+4FjyId5mR2IK9CLlek7zQ96l+jb8gegWHOCKNSJOcx0InkpObzCKwafdmYVBEwHcsXFqf9Op9LdCiULaAyydHaGdmLwPevB29GKxhBt1+6dmCnbR9jL0KEONfQlsSL8+DXTETACrX3+iwPEXc3MmVndTpKGnNRnKv6IilCH+iODr56SeL2q6lY0Onc3VYjN9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T+S3yG2TzMgodzseGZ0G7xHKqt10yt0XVKWuSQAwEs=;
 b=fIhnrIsVaJQaSkqtzKAgcFJ38f3XWUDqWF16hyT1Axuvue5rRJ27eaA0vHJxkzp1U4ALhV3x4j5/ugCmkNakMhEP/iv5myNBsrqT7SamlSku949g0BD/L4EQg5VuExQH6oB5oZvHIGY9w3F06ZNfuVQ3AJZEfYbWIf6eCyw51Woa+MAog2foXxuZYMutSTbQLXaHxxvYE1ANWSemSdgZQk9R2ZefbXbxCMk25z7asYuObVSB6mREOHtlq+3oq9gU9FMVzuneMWulRhdVufDwD3WDcSWwRHm9yQ7SweYlE5lu6MfbEFrWYlpmzaQGI5eXxe4utQnRJZl1wADJnObGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7089.namprd11.prod.outlook.com (2603:10b6:806:298::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 21:46:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 21:46:50 +0000
Date:   Mon, 24 Apr 2023 14:46:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 01/23] cxl: Export QTG ids from CFMWS to sysfs
Message-ID: <6446f8c77fe02_1b66294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193566778.1178687.6009753728429815467.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193566778.1178687.6009753728429815467.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e2420b-da80-4233-d661-08db450d68e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYSifwXa5uJlLi4MwpKTGd6GSE/4WNoTvVIR8P3NVusmR4b36H7Z+lwxraHh1FCzzw/9ex6EZ7ULY4BgdvQRz62vsqArhcoecM43nd1s2ZD+yvlLgJFDC34ftN0IGTaqhS9sANr3nvH54k9m6GxENMYhYbzzrttIW5I1GDq4Jv6UmnJTw3EAm0m9E/kSjgudJBaaSeRipJ8QCmBJyqW/MmxoZyo0rfyzOWApYMOwqTRs3qF6K91sQDk2ZOxgzQOv0eJ3mmj9NNR5w3ddp8geErlv0AdPJQJLQ/rZH2ZtmHzLCuK8/Khtjj8T8YAO2heUN2VIcjOOX/dHnlkwuhPB9E3pyQUW1tCmMkGRzWMfVoZTlAcdTnLH89YZ2o4SmElZvF0QscAZyCNnwPUoo+jh+VXbTU3LqPID+UUf0Zk34o/AUKysQVdZ1g148y1cv3pdnDGWXHik8agvbYRMi4EcJMJJXS0xUhGaVcFjOeRWjGlORC6xDurPCq/oELY/OI2mOFIHftH8D/lIx0RY7lq6QjGwwoumAQ8MInaT3KvAN/zDcGJcIzik3Yxlnfxh8lNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(8936002)(66556008)(66476007)(8676002)(478600001)(66946007)(38100700002)(86362001)(41300700001)(2906002)(316002)(4326008)(6666004)(5660300002)(6486002)(9686003)(6506007)(26005)(6512007)(186003)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6yzxiojMqXeKuN/1Ytb+91HVcfow1Ao7JRqmkDjd/c8u+U/mjvmsjcq6ZCCa?=
 =?us-ascii?Q?U9YSBD/aB+aDoinHRCEaSFEDd9eA2OghjeNr0ZJj3q64dcY+Ts5dKt4iOwMr?=
 =?us-ascii?Q?XGvyNSz4JXmmqFhWqLvd49I+TrcJGT6zINAJRvlunWHYlWFvB09WowpM1ZMy?=
 =?us-ascii?Q?6WJxjSUHf700rjbswOHf0bGtj24ZyZ3ewpcNuD61dDlLzgkWhcERWsfs0lG2?=
 =?us-ascii?Q?FCr2+k6JgpXdRAo3S3oNuydAVVVVY7K1QlDA7Zes05fKa/CArY3cqm4CUSG4?=
 =?us-ascii?Q?pBEWrht4+H+YpJwk5Seu6nXEjFrLtWc817YOxyRXYbcYUi858ScPCZpehF03?=
 =?us-ascii?Q?9+ebCeHx+MoqF4hzZFDonVI4WFWnIVc5KQC4nI4vSssjOYXGSvvcmhdx7DoB?=
 =?us-ascii?Q?daDzuEnPUcXD2j+BroWlxpI/7LyvdXS4YC335ITbJu4uED+5XySd5kURYEQH?=
 =?us-ascii?Q?46smmWEw1NtNdteKrDNoZEKAyHH1Em+D5u6ABfgNkeFRrPqsqdEOkXMoHhQ4?=
 =?us-ascii?Q?DjQAiTaU+fE2GojVdui7VFEUoz0EdLsFrGigx3oFgSh3kJ2+yafUmIlAsDM0?=
 =?us-ascii?Q?DiM9S1er/ZaYdyOIPIDT+2ta3kzUDO0j+Zp4lPLcsqK5pYfXaTf+nxBW99Vs?=
 =?us-ascii?Q?AfwryEzpyh61WkiSMOPNCqJygCONS7SYc69b+q8TdFXx4HreC9JHf+GhnnVy?=
 =?us-ascii?Q?dMSJyls8fFGqEETpqSPQ8XwNmUd5yz2jZeB6nSlWhafT5WVGJRZ4df+8xnDD?=
 =?us-ascii?Q?PoCNIZBPiE5/OZshkNjOkTGyatknolXpajZDQl+oQiFPXLVAX3CU30HgSa8P?=
 =?us-ascii?Q?WQ7r1Qe1i8UJG696WsOg2S5XDzdQ2Ns1RJ9mY77l5EN0a8Xmu0hFX/qWJ41z?=
 =?us-ascii?Q?w36/14lij8/XeUGd7NX78USwiTzL8AXUjm6JpjiMtuAzfQIgVy6v1LkxkJp0?=
 =?us-ascii?Q?lmq7vZt5bAQQPOrq9/ujSfPi6fnMAPBjfRut1CduZxmOZW16AREDoXZ+RRUt?=
 =?us-ascii?Q?9eQq2A7l0Lf6i5cU2cPYdLMwmvx1lKTpW277l/qr2YeHGdy1tf+U1a9gK96z?=
 =?us-ascii?Q?JpcqNuNeJzsAf1PczS/zJruYrUfHvZMfNwBq1OjHQqtG3ENcUFtp5nZd1/D0?=
 =?us-ascii?Q?2EeXSbnMO7JUYg9kH6typkykrPntCGSJ6xvrVHFP5D932yd9kSAQY7aLRJCI?=
 =?us-ascii?Q?jF+LEOgs+a05z8rG7X8Hyk131Jt2zZKCQuANAb6jTusy3gihrbjO/bGswWNM?=
 =?us-ascii?Q?7WKp8rz0LqFveQEFxcg8pBq2xTKINmAHLkf0D9p4MwKaJeQ6PzXi57dWhsiz?=
 =?us-ascii?Q?TJsgLA40r4xw7l8pgvDwEAqk73kFyCWGIXgfbKqJDjYAOBdj6LYMBm41ZE5a?=
 =?us-ascii?Q?wmBBLeqk9GCCSyz5I/9M3soN1zpepZ0MMfACtJ7ioRplFv86EJ7kcTUwyKVz?=
 =?us-ascii?Q?p/jWzHzxJOIthdxpRXfrw2Uk+i1rsSrnQI/cbiwid4KW/slqacaoSgSFhese?=
 =?us-ascii?Q?iz4Jmv7xzUEGyIRgx0KkKrFTRnRbBfd59zJzePCZ+SC+ubrWX8JTD9dGEDDA?=
 =?us-ascii?Q?DHFkE6xIzHqDHlK/leHKFjh3OVrhmjTqcliLYM7qrRp7lzG9PKeUEPfY60+k?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e2420b-da80-4233-d661-08db450d68e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:46:50.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtN4Tz9VwjGgbVKmaWxiHxdov0lDm8w1CsYZaKA79PtWF2pQxBmbomLk997ulrBIj0s68RxOGBy2bQKodsfoXHur6+E7uf/ZgK6VPCmgB2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7089
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
> Export the QoS Throttling Group ID from the CXL Fixed Memory Window
> Structure (CFMWS) under the root decoder sysfs attributes.
> CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)
> 
> cxl cli will use this QTG ID to match with the _DSM retrieved QTG ID for a
> hot-plugged CXL memory device DPA memory range to make sure that the DPA range
> is under the right CFMWS window.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v4:
> - Change kernel version for documentation to v6.5
> v2:
> - Add explanation commit header (Jonathan)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
>  drivers/cxl/acpi.c                      |    3 +++
>  drivers/cxl/core/port.c                 |   14 ++++++++++++++
>  drivers/cxl/cxl.h                       |    3 +++
>  4 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..bd2b59784979 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -309,6 +309,15 @@ Description:
>  		(WO) Write a string in the form 'regionZ' to delete that region,
>  		provided it is currently idle / not bound to a driver.
>  
> +What:		/sys/bus/cxl/devices/decoderX.Y/qtg_id
> +Date:		Jan, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows the QoS Throttling Group ID. The QTG ID for a root
> +		decoder comes from the CFMWS structure of the CEDT. A value of
> +		-1 indicates that no QTG ID was retrieved. The QTG ID is used as
> +		guidance to match against the QTG ID of a hot-plugged device.

For user documentation I do not expect a someone to know the relevance
of those ACPI table names. Also, looking at this from a future proofing
perspective, even though there is yet to be a non-ACPI CXL host
definition I do not want to tie ourselves to ACPI-specific terms here.

The CXL generic concept here is a "class" as defined in CXL 3.0 3.3.4
QoS Telemetry for Memory, and that mentions an optional platform
facility to group memory regions by their performance.  So QTG-ID is an
ACPI.CFMWS specific respopnse to that CXL QoS class and grouping
concept. See CXL 3.0 3.3.4.3 Memory Device Support for QoS Telemetry for
its usage of "class").

So lets call the user-facing attribute a "qos_class". Then the
description can be something like the below. Note that I call it a
"cookie" since the value has no meaning besides just an id for
matching purposes.

---

What:		/sys/bus/cxl/devices/decoderX.Y/qos_class
Description:
		(RO) For CXL host platforms that support "QoS Telemmetry" this
		root-decoder-only attribute conveys a platform specific cookie
		that identifies a QoS performance class for the CXL Window.
		This class-id can be compared against a similar "qos_class"
		published for each memory-type that an endpoint supports. While
		it is not required that endpoints map their local memory-class
		to a matching platform class, mismatches are not recommended and
		there are platform specific side-effects that may result.

>  
>  What:		/sys/bus/cxl/devices/regionZ/uuid
>  Date:		May, 2022
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7e1765b09e04..abc24137c291 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -289,6 +289,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  			}
>  		}
>  	}
> +
> +	cxld->qtg_id = cfmws->qtg_id;
> +
>  	rc = cxl_decoder_add(cxld, target_map);
>  err_xormap:
>  	if (rc)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4d1f9c5b5029..024d4178f557 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -276,6 +276,16 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(interleave_ways);
>  
> +static ssize_t qtg_id_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	return sysfs_emit(buf, "%d\n", cxld->qtg_id);
> +}
> +
> +static DEVICE_ATTR_RO(qtg_id);
> +
>  static struct attribute *cxl_decoder_base_attrs[] = {
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
> @@ -295,6 +305,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
>  	&dev_attr_target_list.attr,
> +	&dev_attr_qtg_id.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(create_ram_region)
>  	SET_CXL_REGION_ATTR(delete_region)
> @@ -1625,6 +1636,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  	}
>  
>  	atomic_set(&cxlrd->region_id, rc);
> +	cxld->qtg_id = CXL_QTG_ID_INVALID;

If qtg_id needs to stay in 'struct cxl_decoder' why not move this to
cxl_decoder_init() and do it once?

>  	return cxlrd;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> @@ -1662,6 +1674,7 @@ struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>  
>  	cxld = &cxlsd->cxld;
>  	cxld->dev.type = &cxl_decoder_switch_type;
> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>  	return cxlsd;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
> @@ -1694,6 +1707,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>  	}
>  
>  	cxld->dev.type = &cxl_decoder_endpoint_type;
> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>  	return cxled;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..278ab6952332 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -300,6 +300,7 @@ enum cxl_decoder_type {
>   */
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
> +#define CXL_QTG_ID_INVALID	-1
>  
>  /**
>   * struct cxl_decoder - Common CXL HDM Decoder Attributes
> @@ -311,6 +312,7 @@ enum cxl_decoder_type {
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @region: currently assigned region for this decoder
>   * @flags: memory type capabilities and locking
> + * @qtg_id: QoS Throttling Group ID
>   * @commit: device/decoder-type specific callback to commit settings to hw
>   * @reset: device/decoder-type specific callback to reset hw settings
>  */
> @@ -323,6 +325,7 @@ struct cxl_decoder {
>  	enum cxl_decoder_type target_type;
>  	struct cxl_region *region;
>  	unsigned long flags;
> +	int qtg_id;

Why not just keep this limited to 'struct cxl_root_decoder'?

>  	int (*commit)(struct cxl_decoder *cxld);
>  	int (*reset)(struct cxl_decoder *cxld);
>  };
> 
> 


