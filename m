Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11196710559
	for <lists+linux-acpi@lfdr.de>; Thu, 25 May 2023 07:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjEYFhp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 May 2023 01:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjEYFho (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2023 01:37:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC50A1
        for <linux-acpi@vger.kernel.org>; Wed, 24 May 2023 22:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684993063; x=1716529063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bjrLe/wCE6hv5YwChm/2zihsel9IAukdIxpC5jZofoU=;
  b=OlUsOc69ITdbDSOVbA3jcnoWtmYkiUprYqPyojjH4PYvTTBOETwZphFG
   YqaEriM+eGB7sBLb9B+JBceBqrawHSB4IMRQr/9O1sanHjAOslUCid6hX
   ls6AVHdmX45qQe8+2gtAACBMc6YuUmzwg0kjtH0r4RC0phV/O6YOUvET/
   /3DJ3w9Jil0t7nvW4R4WA0tIytH48m8+p6RKZjac+0ljTOnLh4K2kU4r3
   NIniOHDpgfjFeLbtFXeRedgm8sWpSiRgfgfg1Hr6g1m1Iyggq3FIP8t6F
   L3lZCkXxkncoy1JJsgbtVQ83GzZv+RDjS5i08esM+L6eO+Iq1pj9N4TXp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="382036669"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="382036669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 22:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="735441740"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="735441740"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 24 May 2023 22:37:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 22:37:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 22:37:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 22:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgTZQUcEJ/dE1FuOARzihMK0HgV4OY+09qYIA5owp7DMB05mVbayiIldt8rK3h2J44P4Et3ZhiZKCy5qdVT5UMxvT3lhy0WG2XlsmaUVEu31GKSmuTg+bKvnHdGoJl8q6ifi1lokG1bwCzM/O5XBPFjSx4Q3BffN7wxZOJbnUglEyFTCbbkGikFU8ly6Yft6xvaZW3Yt37trwjg2mIrbvsblAp2rh9F8r3kLqaEc3hfIdG5xX6Qq8zXpzA5cJMtvtlrq6FpOoJVSwFKajaAiWDLTt7I4wRgKK9+1f9r/nEcBOdbcljVn/xHkyO7j4Z5AgqgE/ogulY9X4lu1+m3kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjrLe/wCE6hv5YwChm/2zihsel9IAukdIxpC5jZofoU=;
 b=C96dQ17RQkgzlTYiL1LroDScQEtFjGhj3tQ1v+GQCCIhQMe16aIYxyYApTs7U8kwsMB38oz+QjlGhD8acGO4I07pF3LqcKGVDUHItMXcv2ACPeM+uxUsJv7TozB0vN1l5UkCswcyoyme9SYiNsfENRCiux0A2bsslYscluP7Kf+ENxRn+/uH1xMmJV4OcMDJKoyMyhwrb6xYRgRlrpPhBs9tJNEuS/EuHTA50v52ErveBU7R/TvUlYbqeVcQyuY2UMxaWOvNnvGHWCtOKsQcNmU+aRTqY8Adgx3rJQ4h4Pi9qM4ohBzGD4q5Z9xqM3RUugRmBNyvWd0kKu7FzEcTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 05:37:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 05:37:39 +0000
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
Subject: RE: [PATCH v2 10/10] iommu: Avoid locking/unlocking for
 iommu_probe_device()
Thread-Topic: [PATCH v2 10/10] iommu: Avoid locking/unlocking for
 iommu_probe_device()
Thread-Index: AQHZioGx9WrEPkZA/kuhRcE7nr9KVa9qgOaw
Date:   Thu, 25 May 2023 05:37:39 +0000
Message-ID: <BN9PR11MB52768B6DE71C88C85AC3D0188C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
 <10-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <10-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7695:EE_
x-ms-office365-filtering-correlation-id: e4dd1644-101b-41af-6bbf-08db5ce22718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVrq/Xn6Hsd2m4TvjIoXKxOx3aH4qRW6I8+0RTM5UAP5RpAEw7Y+UGTukTMdGvwnpa6tz23MuDaIgtHZ2QHh1VBsaWBI52Zi+ECTPJEWrVG79qsx9oHss/m4D4nwXYrlpbUoo3tgrYlX79FIoIrQIzywMClXKJAQx5JAmz+Vi8lUHHzBxmPB9IOEsEls8f4phrLB+wLcDDxMsJDWj/mdmMon863D9kAvw53Icb9erFcaaWgOXgEdhj2BwXw++4iFEPVqTqFnvOdJAlJ9Vgp1CfiyKp+EiJU0YHlpbCKNwmbXHs1ve73IX7hztH7mW5M4OPCTie33zTa6TJA6kGADiIQIDVLfFj2zHRydFRiPbY2lEE7GEzPEGLZVM96ERQW5mpahsxG6qyyeDS5RPMf5UlLqF5TgrEo9TDP5ZmbyRBg8igGPSFZbtFE0jDjIi5+Zb/UFoqZ4P8o4tjCaQdjnc8uziJAC/0mMUV4fq4OOzlLsDPTh2UENnqZyLwWcyq2rlHaFrDBLJlXbLakmWRSRg60E9BA5X2JlyMwv3fYYOy1bViZ33Pzqyvi9qfeLJQbWq6Ymrc+3S8M/2rSfTA2nHK+/G5qAL86TQ7ooRCcFdjMB4rPI/bRRXvw0AgovNIyka6fOzpMBIcgniYIjocrk0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(41300700001)(66476007)(66946007)(64756008)(76116006)(66446008)(66556008)(478600001)(7696005)(110136005)(316002)(71200400001)(52536014)(38070700005)(4326008)(86362001)(8676002)(5660300002)(8936002)(38100700002)(7416002)(33656002)(26005)(82960400001)(186003)(55016003)(122000001)(9686003)(6506007)(921005)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WS2JAwkcq4eC5luj8Fr2AYgJetbf1mFCC1BzReVDeE16WdLoX9uzLMCtrISq?=
 =?us-ascii?Q?7j+D3eMqdQQkv3G8KZDoX1JNfLXRxtkx7tCNzNRtX4MwyC882kUiL0jtP3iT?=
 =?us-ascii?Q?+Naz5cvLmFKvyScTf3bsK2R/0TqQBDScAlRd7zlDZCeQ2dLVyLY4NlboV+X8?=
 =?us-ascii?Q?BkW57nPOx1CnOcC13Wv+Au87AodatysPRUMU0TN122WJ7Ur+s+h7kC7zVTwR?=
 =?us-ascii?Q?6xnzWtULYFyL0nAU8yzpB75tdX6GpFJIIKo2gHcf+DsYKBthKZUnhudALeXH?=
 =?us-ascii?Q?waxYDVR4hjWs7H9DrGB4p4NGmGCJNiZyssq6Imnpj/oDMsIL/FG+cEpCC5NX?=
 =?us-ascii?Q?Vj03Q+gR0H0LFIrHzZEG9DkBGaOLKE6wDoJT2Q3RTK/Yu1cPdJLqU/lqIjUc?=
 =?us-ascii?Q?Vxv487QkF7MmyxWlCwoGYIqhe0IP1jA8sQouzIbC+nvhxrPy4NXi5AgSA3U6?=
 =?us-ascii?Q?TJwE3GYE4daADl5sIDZe6Za0r1pg92BsbHYg+gQs0P2534wOMEm4aGmEVDZ8?=
 =?us-ascii?Q?aNpszCWiVPnrjh3sCauqmTIy8h+YU4pTebvb+/lHwVXleQXDPDWuCZrmH1CB?=
 =?us-ascii?Q?4OZ5wpLNU4rGGAGscwBdvba+ymxKk9yJkuagpEAFbtoxKHOMtGW4yOm7X4dk?=
 =?us-ascii?Q?K1mdha0oUEbrQDvkiHFqtvj1IB4HohIVMi8zA89xl2pXQxwVqJuCtUtz8PDS?=
 =?us-ascii?Q?XAhiPcX6Knpdq1mnfr1S5ScxtulkE4X0/mamGlDycULZ7bzl5XGOJyupMQa7?=
 =?us-ascii?Q?6TktiKMAyuoZ9Y5cImBr0crIdByVO1KOqkqOwQihELNAWXUR92LFjFDbRC4m?=
 =?us-ascii?Q?hRTcm+//vfITt6qUtIww58KVL3MsTv6o8ghgyYvcMD1ps1EhvVquk2i1JKez?=
 =?us-ascii?Q?iR/Zt18uiA1VqlwxSBXK1yGzNszPsILpV2MRUlFG5pxFvv0nrQpmgpticcRL?=
 =?us-ascii?Q?dXXEx8fiW1cbw8nH+mkok5IJyt+PbVIljiysJL44NJak8EBKG9cYFi2D6i7f?=
 =?us-ascii?Q?YDR/12n/oIf5xKmXgwF9e3ykQXVfj3MUSPHO8DHPz6cnvC1qvOCSwYiqOPjy?=
 =?us-ascii?Q?m3Pa0HGAjmSj66yY6c2Bgaal/5yctKriuFkaiEq1SUZxfipdSOuET3CpAXiz?=
 =?us-ascii?Q?FP47lU5cbupVGUywLiKwoewNbsyj41LB0NywL2Kd4xjrYG51o4R0MFVLKcJZ?=
 =?us-ascii?Q?gs51Xc+NiVyH34wpgkI0BVVIjyon8bZe3kGN36mRTz5wiGphKLNT9hXTkevp?=
 =?us-ascii?Q?ku59vFKCGN7uU69sewrYdsF1DOrSZNO3nLUAoDRFl43yxS1c2BLxvPztQpQB?=
 =?us-ascii?Q?YRj6MHuKws4kI9GEo2bMO45y03EUVN9T5Ho9tCsyJ/XhRjiMQmBrKfuXNARX?=
 =?us-ascii?Q?km21Xh1wFlLYvrUoq/XcMOY0Dd7+mq0q9L++Nqw9o5P/S/IYsT8ebjXuLhLf?=
 =?us-ascii?Q?D/7sXty33nZX+O8T6MKxQ1zUa0XRWuf57CIBcXt+RSiZ0aefqqRX7Xjdy5iV?=
 =?us-ascii?Q?lE7oNX8iI7OG997F8uhiraqtiaDGuORKJH03YkQ3CeXekEXwZu/VWWXvhOmF?=
 =?us-ascii?Q?Eo6pAUmYUPSdugSyRKIREPgz19bWo9rN2995ZSOQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dd1644-101b-41af-6bbf-08db5ce22718
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 05:37:39.1087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GgpIyAcCUR+iwo8JBkuIxWvBbHlqs/HKJBPpIawhAs0OVEY9qIwBvMEKmbvX5ZmJchg+X681J6S4nBccL8n66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
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
> Remove the race where a hotplug of a device into an existing group will
> have the device installed in the group->devices, but not yet attached to
> the group's current domain.
>=20
> Move the group attachment logic from iommu_probe_device() and put it
> under
> the same mutex that updates the group->devices list so everything is
> atomic under the lock.
>=20
> We retain the two step setup of the default domain for the
> bus_iommu_probe() case solely so that we have a more complete view of
> the
> group when creating the default domain for boot time devices. This is not
> generally necessary with the current code structure but seems to be
> supporting some odd corner cases like alias RID's and IOMMU_RESV_DIRECT
> or
> driver bugs returning different default_domain types for the same group.
>=20
> During bus_iommu_probe() the group will have a device list but both
> group->default_domain and group->domain will be NULL.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
