Return-Path: <linux-acpi+bounces-2569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039E81AB3B
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Dec 2023 00:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173C01F23B3A
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE34B142;
	Wed, 20 Dec 2023 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fp+Vhr8q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B94B133;
	Wed, 20 Dec 2023 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703116357; x=1734652357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1wByidCrQIvhkbZEnalQqqrf0ZW8idSBW8oBwNVf15Q=;
  b=Fp+Vhr8qHG5DC/zCKPquOwXX7Tp4NS+pzJG0ew8Day/GjL374mrXxx4E
   s1HjMGk5DFyR7RDYe+g2f3XmRaMIY1CW9bKJLRJ2LfeUnDNXZ55En4JZd
   PSzRVyS919hb++LFEQw+iwSd/lBIb2YFihnccKJww/Nx52hgiMQXXAu/6
   qBs/uO2LL0OoLVyb19w0TeKrQO/0ZD5j5uZapH4NEEuDmyQVww7gQPYle
   p9tj9mo1aPh6kjkumkdP+j+JV5ylbLWM/FG1JN5GzgYvubj0yDHtnhAP8
   kn5jRDjIgwlvGdXkDj4HeYd5G9qomWLSZ5RLNcpu8b/sD7aOlQqclma1L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="376041081"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="376041081"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="18479798"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:51:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:51:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:51:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:51:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auHUTd8CNyKDX4CoP+cpXBtBwF/kU6bGtjcSk1BglcCbqzYRQ82HBBbrN4LyWBlKqwzgyTLNQ29dK5YP5fgsSeavXPg+6KtOlZQveLwfsQVFFMIPpi2eDwZHsMqRKRfTWHEslqlXXvWaAWJVx8CAbdXTnJe3mMhMlY9ER7xyS4jDsk1LZV65iVCQToNHWaiv/zFVY0b/UQcgcIjFU4UiU3yIys0i+opMQ2Z9jspOCKicZ+As2c2ybAk4r2xcyYqNtB8E5tKkTeUi39usMYQ8+k1KgwtctTzRExsgT2hv3l8ZUb64Rked9h2Akv5Z+wdyDHnBDUBSRRH0ZMyd5mhwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcCFrLus2qfTF6CqqcnRz6qa44sv6IXIvwKo24Kbuns=;
 b=FQGO3fl9w+4LLqXvIg71W2FJweaikEP/b9+Zkf8OUY5v0z1hPUl2bJVxGaA6BnghoG6gVM9jWr334lg+fwVvxN1dm3l5/wyy/xQLhH7enXw3MxpNZHr+ArkP6YEJT+1a2+aWLEA3pgPamNgNxCDelley1daYxF/i7JCPGM6lQ7O/fecMFxie9k4wLQYIMsDcJaL/SVRGclThTTRzGKprVmuglBx0NN/wZzGNclZ+fEBjAP9uC+M995Bk0ScJOKl+RHVdnkRDacrgNqFgJ23my6+xVdxJmUpWZ674CJdG0HrWfgpiguVUhMyhuH+cq2W7rAMoYp9zRjoinLv5TuLeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 23:51:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 23:51:20 +0000
Date: Wed, 20 Dec 2023 15:51:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 2/5] ACPI, APEI, EINJ: Add wrapper __init function
Message-ID: <65837df484fe4_83746294fd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-3-Benjamin.Cheatham@amd.com>
 <6580dcd03b49c_7154929487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231219153955.0000473d@Huawei.com>
 <6582019fd0b2_269bd294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <1e6be72c-8966-437e-8a68-a94d27557237@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e6be72c-8966-437e-8a68-a94d27557237@amd.com>
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 23dcf382-ff10-4d4d-14a9-08dc01b69045
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhfcB8ZrKd9pNalPnS/YY9MJxwUJug7IoqEevzoWXmAHAWZ+B+2prQU99c6pC1CgCtr694MzcJ7cik6EDm45Q5W4mgXa5FkxgGFkuj8wbOCUf33AX7g2+WzucaJZ/YA8Gu9wpWeW5Qj2jFE4iQ8O80wA6XMNrnKnHKWDnLhMgArV4Ykl/AC4cEY0cyPSIo1+qBtqcqL2xuewrmpBpVcC1BslXV55sDIw1A+OYBIQptAhdnmDeNEEl4x7otplAanKGvP568Nz6ErIQDM7+rD/bpAg2o/8XSA3WAEZA3qLsPHeNPItO3AkYsvc2LDPOgxG+f08+eOPQ3UE/2SulfKlzjrTMqyq47vp4WyrLddfSqqebadGaqnOOjRrdC2EbhOxtJ7OAMwIvj6Fw9uOo6oqoqCCyjo5BjVpcmOiJGQ4ARkbTF2xrj8ar82eIGv6qXsCfVawtovZKxclzjDTfluzOIIrLQKl/bjOJnXvfRpOI++gtKPRsHJlz2iiUDrG9j2mQGJvL8H0GrFrB2PqBoKGxVyEsShY96ICh54VOSB+Os/acQIu9MC3fyNSeG8Bomi6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(9686003)(6512007)(6506007)(6666004)(478600001)(26005)(86362001)(41300700001)(110136005)(316002)(66476007)(66946007)(66556008)(2906002)(8676002)(8936002)(4744005)(5660300002)(4326008)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRUhkW+TnI9HTK3L2/kOi9cC34qHGM2qXk02L0P+K9q3xsmFktqjEiCPt8Vw?=
 =?us-ascii?Q?2pykqqnZueeZwIlBNoBBnDO+/YLlKiZQPBR55VmDkl19BC3nCPfSCZu+Q5Pg?=
 =?us-ascii?Q?QJ7fG0NPoU07sa4gZwxPq3q2bVoCqABm8GqJUlbVgxwevY+S2VBepBZVtXLO?=
 =?us-ascii?Q?1wWP3hk/upcxq/Do9/RS/KoK325d72EL7Z8vNP54teDRrrA/N44O9WWoCSeP?=
 =?us-ascii?Q?EU6iN840YR7r93UA93YgI4GwhJri5ymrhvjLEq1Gq8wUJxpuRH6vT2eji7RZ?=
 =?us-ascii?Q?zqxJuBAQDNIlKky9MoOAIsd8oavB04rtKXrAwHn6Z6PIzKr2QF7RR3+Ji9Xi?=
 =?us-ascii?Q?WciCq/53BDnflx+B28cjTw5ot3+QEmw44o11SiK7mD7oKNLhO0W6wZpooJDJ?=
 =?us-ascii?Q?33hq3biobMQy7nvIK5pzMdEqcjUYJ9eCqe1qltHBqnFnCSKoCpucDTZFI5+U?=
 =?us-ascii?Q?N05MaYCO7s/AurykV/DhAspv5W7trNp1sjvDSIjDFuZ1pMHaPIW0zDYYyX1a?=
 =?us-ascii?Q?pcjeh4phvzJD598x/Jbg2VEHV/vtoWpTaEMSdLVV7M2Ql+mO4+Fyvp8jIttc?=
 =?us-ascii?Q?L15zVeRyKI7ELp9e4NftZOIN7rqd0hDHSd7nsvLUB/RpHlsdJ5YUcabfyiZd?=
 =?us-ascii?Q?k4w2XUcoGMDNqwaY4tYRMZdB7XvRhhaZ+PV3Ne/sxCXt2JaLB9RbrzJUWsE3?=
 =?us-ascii?Q?fgUFZqplzzqrJV3CMelLmY1c92ew+uM6Zw+4/pgjsCxgrxGwkyfw5sVsSY/7?=
 =?us-ascii?Q?P5uWshPFS9Dmas8q/f2pYi6zuh3NLaNtUZvXPVoxKSGWFvBoYYUdHFcxUM48?=
 =?us-ascii?Q?SAqyXfUp+LmsGEGF6XOE9JQDwqnhBRsKsMv67JkNStZ7J0M5b6bSunxcDx7Z?=
 =?us-ascii?Q?sjWKYF0sMMzpJmDSnHKztbeery/B8dZYLcx/GFyocxtjFLb1UxgsLGQEVeI2?=
 =?us-ascii?Q?42nJj21kryvtLdND7oZddoaxTSLfUm2SqcEvfwc6x8Un4IgrISt4IeFVrSvS?=
 =?us-ascii?Q?GDI/QyD0BpDwUNfv8c/0D/OXl4dBLiYA/LYvzDQFEXsksBPbb8NFhmPeOri1?=
 =?us-ascii?Q?bxV+LF1IlUj521FB/L82KikigpSCwl64YydgOIS8gG3wD2Nm1cblGQav0KoX?=
 =?us-ascii?Q?DQBUpD04OfacKh/RqbfcrC+hfcaefRGOxHJjUeYoYiPAEfa4fdyXyvy1+YMO?=
 =?us-ascii?Q?idJqgoan9nfl/6HN5zFqgfyCEGnC3GyZYAG5JJHbVFMpm9fdLnYQVqUO4Z0Z?=
 =?us-ascii?Q?ozK+p/BiobGUEux8HpdFtdt6AubcGhDbPXBnEckesjDyrRDKH3NufN1OxLRr?=
 =?us-ascii?Q?K2Uc1ews37lTqNE9UOadlq3G3MAeBm/wwsxOg2zGcbGAzx34je9wWzR5vnvz?=
 =?us-ascii?Q?+oN7G86PDMF8fDmnvAUeSwXN8/e0dC8s8My1IbU+2GpJ1j70uyCu0LRciVyc?=
 =?us-ascii?Q?RBHZIFackAjdQTUclahM5Y8TsgjY9YWk49ri4PoTeOoRR5/TpMUD5lLfxZZS?=
 =?us-ascii?Q?3j2d/unbZM3da5WF64at0nO1rvnRzDyKyz3PLaBoU24S6hKXMuBrrU0D//75?=
 =?us-ascii?Q?waE4O6oDx+hD26peUF4g55hYVc90f0WJbqJ+IDhqUd/iXgXPVIDVNqlCUBy1?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dcf382-ff10-4d4d-14a9-08dc01b69045
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:51:20.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LrLEaVQf0ildYPCkDMHN77foJ0k/o8nF64CrKX+PxD6lzHDBJPrToc9xcSbymy0u3yYo2z1sj+X46xDfJxhzlOjnCjpCE1MbJmDAiISNfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5273
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
[..]
> > Ben, you want to give that a shot? Jonathan is right that my proposed
> > hack is *a* solution but probably not *the* solution where this should
> > end up.
> 
> I can take a look. I won't be able to get to it until around the new year
> since I'm vacation at the moment. I'll also respond take a look at the
> rest of your review around then.

Enjoy your vacation, and thanks for all the work on this. We'll get it
sorted, and I think small bit of EINJ modernization will be a nice New
Year's gift.

