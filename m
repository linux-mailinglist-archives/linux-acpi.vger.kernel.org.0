Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F6710557
	for <lists+linux-acpi@lfdr.de>; Thu, 25 May 2023 07:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjEYFhV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 May 2023 01:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjEYFhU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2023 01:37:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A23FA
        for <linux-acpi@vger.kernel.org>; Wed, 24 May 2023 22:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684993039; x=1716529039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MOkyPz84kVJCzU+Zqpwv53+/w9EpPTLn3UoQv+9BfZo=;
  b=TKNF2r51iVYaj8FCZrf557abyqFNAqUAQxLdIPBTLYArkTZ0+Etfh6qZ
   yUwXROyJbJjv4oryopu1QlKJu3GxKEZuOXUaHhX8j+sKZFg4ZKIZgiXNt
   zRusp/I+MtRkzZcDg6VIijcQddMAoS/Ie+TztppMPpvJ57vIOP3S/WNCe
   7+0n5XJr/+91iLLdWozgleDQVVLrKO6wWQ7kXjymFUMJod0pp+46uN6nN
   8jMbGV8IVgHa29er0u4C6nhkuxIIU4MIuM7mwAWy5cj9sLdUBk2Rj5Q+K
   E+8dZXODTWR0aVsf5G1nKKivsBQ12NuT630Ql7BNjQJWfBglCYmpjlk64
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="382036599"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="382036599"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 22:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951314569"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="951314569"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2023 22:37:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 22:37:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 22:37:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 22:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFLlhlM/gJRYEf66cxHfHpWybLtBvxJMhcrRmQdT9GZkTAklPOLtVol9qjMdFTwli1qqJhUtJvXHD96VbNIkqZm1xpGevDBnm+NNOVCkutgafTb/aKAN5A3NreadIAoHoJCl2zTvcYLydZAWBtFsot5EUNK44S2JbKaSCP4YmYUbeOrDrrQpA5EYPuywZzus4Rv1nYg5ulZkLSggkXe5258qCMakAnjOkcWJ+mBPq5IxVm5QU55VPJzKGf3QS6Xd07hYzgWKmMrF5vXGaDV9+nkf+KTSzPdLoO94V2VqcUJyPdENyiXSlzLMAVF9+zFCw0QXE+udKi+0Uv1QJ5lp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOkyPz84kVJCzU+Zqpwv53+/w9EpPTLn3UoQv+9BfZo=;
 b=fJJmHGZ4hMbJxwoQM6LT+mzkUf+MJt39t8mQ+AB9IphkLS6VDluzv6Q9SlTvRWBjgNGA5wDbKvtpRjg93KkIFGXo69XjXLpRz9awtGGL6rSaskNocx2w2UkZ6CoI4qaMBzlObxkcIHrB7wxzxMup54owstiFtyENl2EWImf7I7ah4lz59oY4xSIjcvKPE6QfyXU5D1hlCxyG/cnlAWRCkYIYI/rn7vGb7x6yCkmT8qvAwuxnGQD/Zbsq45tKIkEjXVFgozuv9ud+ZxFyYYtpa+Gt4UPIaA2vn49RsoILQavXa8v1JtynBVcYjh3GnSH0/e+/eysZ5BiCWywgeVHrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 05:37:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 05:37:10 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 09/10] iommu: Split iommu_group_add_device()
Thread-Topic: [PATCH v2 09/10] iommu: Split iommu_group_add_device()
Thread-Index: AQHZjsry9rMRjWWfLUamKdW58zS8Sw==
Date:   Thu, 25 May 2023 05:37:09 +0000
Message-ID: <BN9PR11MB5276E591F75A3767CE3C383B8C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
 <9-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <9-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5053:EE_
x-ms-office365-filtering-correlation-id: b3598d51-91c8-4ee0-b37e-08db5ce21569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1uxK93iq8iXU3rZNR+54ZRLNm57xhssEi78jeHc5HqH40UNGIelWj0jw/rrzq8/SBS0gnYPCuvoHUV+zyK917HTt3UbgbZbRmRCjeLgr/HtWnqac3huLNvOYAIeCUrZdmk1Na450IxGYeKnyDe5+MWAUUdYFks7+cvdwQBytSvSBtmPW16+SaPi1VN/yo8BRpPXGSWG2aq42WsipA4qE0kCxiIpsJdZP5/5Z76gDTuh2HOplveXzNY6aYEHLviwiniOF61+dh5u+fNt5OJ0NQbP42glECqi3QPI4Oc4dj0Otlb7aCMZz4tXm9BLqRGC0M5kaRe8XGIt7syISZnHvG8gJvlEKeRZaI9l4ntWaCj0j5u3f2JZ4qXSHoSINdtP7/bxhu7qL52zJ1GTMl+MLNHbw+g0Uw+CmS2iLUQ9fofX3SaxnD5qxtBOnNuu7BsHs9tqx7a76knuPCIDeW5gsuG0p4Eih11cZHUNxaQdG5zgvqucXFSg9LhnLWJUXCvewMq2tndb32u86HcSVRghpBS1mWFG7v+oe13ALYq+aQqX2/S0YZVInQuxJ8H0DVrLsyGvoy9V8IsXcOj8gWHK/Khi+j4EFYgH9/JGvaa/DcKjTtdixtfZOzN9+HyQZCpUm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(5660300002)(6506007)(8676002)(7416002)(478600001)(41300700001)(7696005)(52536014)(8936002)(316002)(71200400001)(26005)(9686003)(4326008)(66556008)(66476007)(76116006)(66446008)(66946007)(64756008)(110136005)(186003)(83380400001)(4744005)(2906002)(921005)(82960400001)(122000001)(38100700002)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iAt+mcZiBu71rc67CZzmxQJfZWX8KjBT3NkhVTvG05frqCUJ8L6r9vPqs6y4?=
 =?us-ascii?Q?9WEOFN9zpMyOBZWudBxNeprFwywvJz6AHSK352De16Fm+OOlWFp+PmoLObGj?=
 =?us-ascii?Q?r0qvXXdEOX3J5w42NtgJbM92NSwyV4Zpng1S/unVLUAhM1QPILUG2LVndDQg?=
 =?us-ascii?Q?P33O+03eJCErojofKsDAnMTyccmiMq4AJ2o2T9zzJvWlLUlrFMysTGMERM44?=
 =?us-ascii?Q?6RrE65NKTfYaJOcKDLKMZhVrzHGRTwiQP8op0vAs81+f59b3GMzYEU7v8J7X?=
 =?us-ascii?Q?x4Vs59hjdjgnrbv0hK3i6PjeRCmsg2q05z+HbLIAIjfSJ6GQxbY5vznkr9ee?=
 =?us-ascii?Q?aoatZazFnhHtet0jjlRF4DyyKviyjgcqb++8mNRL/Uwn2yloFqSJTzaUjikU?=
 =?us-ascii?Q?Vug8f6g88Le9FyGaZ8NnMBvySDLz1XfTQQCVAIPH5TIAEVrmU9DZxG1eZqZU?=
 =?us-ascii?Q?IbO4mBaD3Xpn/W5frj9JvOhkLm2L28UE7mwYnDqQyiTZ6YSIJVmvbaAODNEo?=
 =?us-ascii?Q?oNf7xRDvCeNHyVbjRw0kDJUaBk5NjSfQ8Znlh3d/gAnWXD1OosA+kOtYvDqS?=
 =?us-ascii?Q?obay6JvRFor0mPlbpHGPuzRVrn+JNcm1s/dyLgUkre0s1O/cPX8GeVZGKwrK?=
 =?us-ascii?Q?SFgUm8KZvl7FsT6UKLt24PXwOdbboGBqkBLJ0ASBrr0ClmT3ICKdmX0alVol?=
 =?us-ascii?Q?MUmiw86nIRu93ri1utBm0gjlFdMIMDYtFuOSzcNWrzBfjWNQ5k/6VVJ+I2Wk?=
 =?us-ascii?Q?JLPNJWwyZ3U3RJTMqVxR4CLTVONVWynDn/W2xTdOpvO42YMl+nqIlzq1B1v3?=
 =?us-ascii?Q?nvgnZd8WQXGRsTvtm0nQUtPNaImQvDyvPULY/hbtEhP4QXk70F1v8J4a45dJ?=
 =?us-ascii?Q?0WD3GoiO7mnPEhgL/h4R+ivMWhNMIu0u7TtkLlk32wmq7cB8zAXjFtBb96f8?=
 =?us-ascii?Q?1PUv2vql+5Q2gVqHsYfg3aXXKHhKtpRWBtsENRYOn1LymdYYOMejjq1Pxkw1?=
 =?us-ascii?Q?ERohYBAvyN7YGdLiQLlw3ysC0NbUh+wbqBax7eWFRpIu1SQJOFrC0RMDOY7+?=
 =?us-ascii?Q?/+SWTmU2TFnjMZncLxNxETGxUaBfqWEGEYNDvf7I1AqUk/mAsXSijsUhAsM/?=
 =?us-ascii?Q?PRLVOthHYRo/JR+c0UPhM5Ys5p0K4EUdT3OXgIh7gjxYAQcOq+MGyu9gn1ip?=
 =?us-ascii?Q?2j/IX0knqM3sA9JxvIvK6i526ix0g/vNvXN4hoTyjMTjR2KolPggDLcHlnMW?=
 =?us-ascii?Q?8iMfRD42FGySE4menQa08Tt1Ilkfns1+5My0vgidcW+iwNflT1eqlY2WhB4C?=
 =?us-ascii?Q?/SHQU+y0BQlpoNdYmuWC7oBmlOsie/QizedKxC4klYeLpUzSN5sg+Z26GpYL?=
 =?us-ascii?Q?ScjvN9Qw0wo4HOutP750G/bM8fmI/usr6NjoHM5VNHd5LUmJRxQKVfaexdtc?=
 =?us-ascii?Q?rsQkkbcXl+Lee0VmSTC6l+fOT1qbsXS2WrOK7s4wciFCmH1D2gl765g4dlB9?=
 =?us-ascii?Q?5wXpLE+UFQTHhj+WlAuD5+vls8OljocadvHEyQKsWqmfafWOcIM2roQhhIhO?=
 =?us-ascii?Q?kSQOkQxdysWt/gTPdZdC0eUokUati4Er5AD2wlUt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3598d51-91c8-4ee0-b37e-08db5ce21569
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 05:37:09.4472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QCybslcSDOHWUtT9ecgUribDPjcJ7WL25yxoNu4pMZEsxfpqaVUy5w30I+xJ6WgX9LhH4otNphYBapsMEQwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, May 20, 2023 2:42 AM
>=20
> Move the list_add_tail() for the group_device into the critical region
> that immediately follows in __iommu_probe_device(). This avoids one case
> of unlocking and immediately re-locking the group->mutex.
>=20
> Consistently make the caller responsible for setting dev->iommu_group,
> prior patches moved this into iommu_init_device(), make the no-driver pat=
h
> do this in iommu_group_add_device().
>=20
> This completes making __iommu_group_free_device() and
> iommu_group_alloc_device() into pair'd functions.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
