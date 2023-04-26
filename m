Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D267A6EF0E5
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Apr 2023 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbjDZJO5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Apr 2023 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbjDZJN6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2023 05:13:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB549EE
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2023 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682500388; x=1714036388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=spEzZo8m1MECy/5E1crf9mAMieEoEtiiPW5Ik3yFpgE=;
  b=agqPIi419UWxgoY4ql5n1+P20YWbFxCjynal1FgRV5tQoVx7KHK6CyCJ
   XkNBJljiTNdP2yCZYWjcpwqgxcqagwsYNupPlA34ub9UJoIQQQiDjuB6z
   ARdaOBN5FhbjQjFolD7Wmz08VizjU2mihov5a7DNB9XEGCYejA89C6yej
   X1osZHBRw9iZToV0H5TdJLiuaF/PytPP8V6UfkRVQDbEY0u4iaM7BaMU5
   0skIg+9mv2FLm8HpEK3qBQTTDbVw2VXn35Auyb1CC1nYCc9AmEW7vXQIU
   iMBbvzlFkPWRe92VmqOPPZqXa+rf2scO9DfnLk2vVMNKKrv4tzhSqeVf5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="347073410"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="347073410"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 02:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="726457562"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="726457562"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2023 02:12:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 02:12:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 02:12:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 02:12:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn0FrmdEQBHpiW5TWDXCPABctmBjuHH8ytgK1pDmsLn4rt3xuynl3z8jqOga7YiAxFreUjV3e5zoIB6HKyetZOZiABo1/4CS22LRRqvSDo/PCfN4zy75zMd3I0JOIMqUBDUrjKDTvnkdjvPldf6m9LdcZFPtEpKfbotvNphy1wfqdwQAACWRDbMmLEdjhpzLSrI0cidORUnQOTX4QlqznVLaoTcA3I1DHXc1UU2ODnoCwp+ulnD2/81+paap/6o4LJEupMowcKDrSushKJDfXDv30Bqxbki3ZSZ8YePul60+S/VnzWKjHpcJcnIIaJNnfoYD6ijnBG+xD1aoLT+UDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spEzZo8m1MECy/5E1crf9mAMieEoEtiiPW5Ik3yFpgE=;
 b=R2Pi1QXRYhBk9278NmZWg1Fi3IUgGfgny57vysHWjICh2H1zsIbTpCgamPB6RfuB0ADe3EQIRfRGK+pD0A/+M1quWhx8djKRCH/jvUYq/5M3lR+vZktLGvSjlrzRN6Bb9syxHvwLGXZ2YfmB+2Tyeilr5LNJzJ/bcX77BhIJkqh/ipch0T2Az6W6A3Q3vUwGYgB2aLi9YqiUkhHBEunedTbWw4iBRU2p0BqZjnYemIgBXnriNky+J93G+WWTNbQ6U/o6kgCmQVBQyWxA6gKZ9L7vi47ApQPLcqQWu3P4aYb5a6DhZFXtVWao9yd0UDj1AM3VZL6UykHCwqPoDtNy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 09:12:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6340.020; Wed, 26 Apr 2023
 09:12:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 02/11] iommu: Use iommu_group_ref_get/put() for
 dev->iommu_group
Thread-Topic: [PATCH 02/11] iommu: Use iommu_group_ref_get/put() for
 dev->iommu_group
Thread-Index: AQHZctm3OFVncbpyx06LJB6Oc8DQ5a89WMdg
Date:   Wed, 26 Apr 2023 09:12:45 +0000
Message-ID: <BN9PR11MB52763D9969D7F897DBACAF868C659@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
 <2-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
In-Reply-To: <2-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6775:EE_
x-ms-office365-filtering-correlation-id: c6b5a5ee-5dce-4816-fb5d-08db46366613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C2ahUNHjWVufCnhCTOuNGqFfGWwLo5BI0WnN4lNVC6ZDA9tRD64dzoLi84XvmRjn3acVKhlsDr+UY0FmODQJokNGPfsvapp61kShdyjGbuTBc8/uB+xJY5r6KTmeQmQwxaINICGhuJlRjcOtZh/a3z5R7/v35uf2UQyVBUkqpcybdeMvO2gqnq1l/roC2bfRHIPOiqpio81mbZeVHFb5+QLBSejnazCD8JlCRTdlWInQHZ5sGWiw5pzte/oDfeG8HM1BSCDUvJp7US4iytOyNClto4NtY+c4G8uUgJhVyEpXIejVCQSVlZpnSnBCDIctcFp1jF0PwZseRaFETh/1G3ZCgO29o4Fy1SoXD+HBEOXLqaqYVIKHkSdWow1TheJHHha00PNa6ByOFhQ3PL29LZwryW+nRiiUahTZgXgIEOHrdwJNe/NROYZt5rZQWUYWToYooNyMW0oHb16oQiGC0FfnYqRHPTpmX+SY9Uhp5I7dQdzXV/UT76X5BflLkq60NBQnWkFv6F2NCWImHsoeiiaDRZhFYUzzarGPK+0YPUk+cVYxG4nr7VqW/AkyQOQyONfpUwDxKK2c9G3fXjKwKfl+bYJamduSB1ilsbl+oehuNnCT8dvU/5bdqv2GgrgFR6id/pCsVoqRLtbEE59Elg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(76116006)(478600001)(71200400001)(7696005)(110136005)(6506007)(9686003)(26005)(186003)(5660300002)(7416002)(52536014)(558084003)(33656002)(122000001)(82960400001)(921005)(38100700002)(66556008)(66946007)(86362001)(64756008)(66446008)(66476007)(2906002)(4326008)(41300700001)(55016003)(8676002)(38070700005)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5i8yRnMi9DBvz4LGz0Dkp3Ur5K68f7V8IOdU/PWe0bcPayID26+xYrOkvFiW?=
 =?us-ascii?Q?vTJYIK2imiVczNV1PCl9Z6aQY+llVkOdWsHF72EFmqJCVlNqo3g4KLAjpqpW?=
 =?us-ascii?Q?DThCvZeAFsNTdXYrx72G4Wf1UHloPaQxTcO/nzXbSawQd18n2rA6jn0fMYct?=
 =?us-ascii?Q?mHa77ug0/BL0QWUofvJsQZcqO+d2R9ICxNW2ebPhKfTZ5+VcjTFyGwrpnu4M?=
 =?us-ascii?Q?hSVR90r/sg1iIYJ2AudAfUXztENvzlpRnLDrtcy5YN3uRYwEonOOyJvYtyj4?=
 =?us-ascii?Q?osYDesqAiCuGTmhZY2oGFNCc9+glaKap8+sD/8Xa29BiR/SvmiShypONvwSc?=
 =?us-ascii?Q?beJHiO6cSjUuFDyUJiX+atRPESYE1MwNK089tmDoXGmdMzI98tFNv5GrgmRM?=
 =?us-ascii?Q?RxIDJ6kjVJne6DyaqOV2LwPr01b92Z+aGHNy0vHkPpKeWAsJ4yM+K32Tio0t?=
 =?us-ascii?Q?6ekuISbfylFhrdG6cw2FwbHOngmnw8QfXsRrtbBtGxgZuo/PVBHuoA4NJ/Is?=
 =?us-ascii?Q?pQyF26R34Unt9waqq22GYL5b71a7VLx29UlrQ8nlEPcgtukL+dxxrTtnXQ0i?=
 =?us-ascii?Q?RB/4/ICZRbWGwwtZPWjZayLHxtfAAa4Nku3CFzfw70wwmRm4YVya5/1ycD7y?=
 =?us-ascii?Q?CObWscKDqf0l6QCePKPnExyBi7uS4y9Piw5N64EzUoHDGs51bCphy4svNr/u?=
 =?us-ascii?Q?BvMjfbe268bALfPNuiFvM18gUZcnx1WW4tnxK/08DqyYibqN5FhTjqEUQ9TM?=
 =?us-ascii?Q?Wd4GL35c64Fhor/9vjJtY7oGpmVdBwyT4uoyp6F6qswvEyCUq3KitGm3a6rQ?=
 =?us-ascii?Q?HqsR0iS8UokBTYgfy93jT/oRJGRw4psknubG6Gm0m9vOTN6F7bQg7BV2q2S5?=
 =?us-ascii?Q?K1kN0vF7H1huL6VgHLal3b0vTLRNVLwcFPRlnzRA/CLJgQI7RIqLikbP2kqU?=
 =?us-ascii?Q?j8Ldd5/af71DrzFOTXtRUSYEhwOkF7wCAMMgbndUhAPKHnJRaDSOfueF3yEJ?=
 =?us-ascii?Q?a1wdc9kWKzeeZUXsWUP7VD0MKHhYOBs5IxhPli6dPeDoK9MKZIwhlFNPUp8/?=
 =?us-ascii?Q?MSXvn8+yQhETYSaHiiqyzmPFzLfVTXFP7DqWAqqpsJmlbTD16+K5z6aFs7KY?=
 =?us-ascii?Q?1hvbwrtO5w6tssL6hJMIzq5cI5UXBQM2jCB4kYGDcGcvBSharwjGrm/Y7yUU?=
 =?us-ascii?Q?IuK+iiioXK2jzLH51xquXw23d69Icf3X1FMbOQ+BHnyECbLeETplvHSWzDIq?=
 =?us-ascii?Q?uHeQobpP30B21qDsCo5DWnRZBvnvsBuyfWGo/iDo3/a+FNyFX8IKvupC+N2T?=
 =?us-ascii?Q?nCmuJBpbk75+e1ixEvKstYXHutp0BC62Gcr/bYQ/fyVT3rELkdMUxv4HHMSM?=
 =?us-ascii?Q?0+ExW6YiVT7fEtBorZAmfc62eIIZSBLq6UEjdgEe+PjzhvwRmYYqRDZW2SdW?=
 =?us-ascii?Q?/tNhF5xZFCtQOkKN4EhwipQX+q/IFh6RA9IIDbzqth+d3xh8ZzJQefB/FLij?=
 =?us-ascii?Q?b6qBOJBhQm51HNS29BLIZolzyzIH2mAqD+Itv0/Az1b/uBPl/YxzNogeV32i?=
 =?us-ascii?Q?vwxTSO2+9IJOGRrIXzOPKztI9jBhfV/sFEEDNJe5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b5a5ee-5dce-4816-fb5d-08db46366613
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 09:12:45.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECVYjvjSa4GAdUTfHRUPg8IvohxFu/NLMwK49Ys3MgUp1GJ2HUzcJ0gfKi1r+/b34wDjt6kRVCt6XQUXLB4WwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 20, 2023 12:12 AM
>=20
> No reason to open code this, use the proper helper functions.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
