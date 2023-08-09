Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECB7751BC
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 05:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjHID5k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 23:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjHID5i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 23:57:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE251BD9
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 20:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691553454; x=1723089454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y/GcXUXYjRVRlO3gVHYD2oUOHhGsHAR417lEkk8FQeI=;
  b=P/9zjT7aUobdEfgS75cqptIewlq6twY00tkIX7iyohw1qYvlsAe5o/P5
   rDsJp0cehGJHtMfUB69zMbb5t1yGVLpyUwhp+Gsih3ox0Dz7/xY+QAosq
   DWoWC5dL0EL+ttGNuNxdTwgumTPdid3VIMutIUui5mEUUypCrzdTjCQ2J
   Cc0rCdTWxNnue2W4sB3T+m8wImbFVrAjQlxR2cW4aprx5bcONFUagzTlx
   ogKs5USWb+JFz+PH8C1EjbZ3PV2KaiCTzMf+0hwH0VrRIBto5jrvogpCc
   fPpzx7Wbm2Y8tTpIqViGj88NwRwakHuSyy30d61Rng2lZ5jtZdGLSYpdY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401980497"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="401980497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 20:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="905472382"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="905472382"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2023 20:57:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:57:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 20:57:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 20:57:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6e+Cv95dkaBlCpvo5n6mG9+CNSm/2XL7SQ+W/xqrNGI6DIP6L4zbO7XY4+qILBDR+RY2fEYEhMKEGnFLzgVRaqCQFAQpHNEPrAxhocAYVFDMr7ixOT0p727eIhmgMpZTySHoKQ0dYz3ne2HPd9Qi5L35z2QHcqnGDJb7Skt/HrpS4D2QXZtkOJ5X5qlpUJqJnJMQgWrA4O/RKqY9xePHHG+y51ZrxG29X+v/2DpdkGgPOf2NNCXJOpmOjJMlDsiIZaLoBnX4Sd7L6vGwXxaBJslOWW+w86ogeZHdRx8lxZJneTNaRTpYQf/cm4PSDwKTLS5ZofWJ63W4Nwdt1WR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/GcXUXYjRVRlO3gVHYD2oUOHhGsHAR417lEkk8FQeI=;
 b=jtmdRJ/TjSlYqOReYpRWYxivtuu4Zfq2V4emul34ZOmzNYMT/oDlvk0R39mitdNduN8fa3AwtgY63nhwVZ0ZKtgS31m0WLcNkxT42TxZivYf1kbDCHx7ffE85J7IIgskIqr2X2z4A+4SLdx+8q3NrqCI+5m+hLxTtCJVbw64D9XdSyMj6uuL+WQHKTPB5neq9cnCUJRH9oEVzZB33hMATTeniuJqWnWMCp/ZmgjN2sJlcl0XqwSYsxKyQWe9+Mc0NH43s+6SNvPn3rwiksNsNWtTxzjzgWak2f8dESEPdI4JxczbqFrVcokhtjlXvV5OQSPu1l98jby303xCwXtnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7412.namprd11.prod.outlook.com (2603:10b6:8:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:57:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 03:57:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: RE: [PATCH 2/3] iommu: Pass in the iommu_device to probe for in
 bus_iommu_probe()
Thread-Topic: [PATCH 2/3] iommu: Pass in the iommu_device to probe for in
 bus_iommu_probe()
Thread-Index: AQHZyiMyvr7tuJ4tE0i3sUa2pXa2Ta/hVl2Q
Date:   Wed, 9 Aug 2023 03:57:26 +0000
Message-ID: <BN9PR11MB5276FF9645F87A4DE4A8C2258C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <2-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <2-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7412:EE_
x-ms-office365-filtering-correlation-id: 8a990402-198c-4702-e684-08db988cbebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQhTIJ1pg+h9aDSP4RRZkxjS1J1DD7PkIhplmc7hyga3hNbiRwNfYpphCc3lfsvzManmkNHnsQXCcebddB04LOedci4oqZBR7ggokP9A2MLr9WP0PyFVI+U7AtDVpctR8v4zv82mH3qy1FusOojuQmAvAsGxAHh/hk05RHnGOy2UaXV41acuGIHPL5jMmXcHZ1J9QC04x5bOqSP3aXf+izySex0k6kqOJQTq1D90cJNoFsql25hl8XV36szF/6gay5EdtC21i+XhHlOCb6m1UL6nIH7vh/FeQRuiWIbnyYdwvydqZ1ac6Ihg7ADbHd0Qour+zZ9mheWVdgUY1jfDbDB5ZdfKSZGbERNBiAcBS+c+lsRSOqddBTSqVBra8C9X/jAs2Ax2doceZa7z5zpGSGyGWqjElfEFWwO49o6mqCY7UNee3v1ko43OgW3alLiW9WQtxPJsS41hMKPFfOOe3wxtcFsg+C0ttlRvNn5vkHlkLKDh+vN8vW2drOMPbI352SQLoSd5MxbARtYJAvIqbnPTkDvk/m/O178VIt/fyjMWl1dVDAN+GMu0ppIvdCN5Len5GCpbOm4arkKJnCcsTLI0/hx7NeHfwKSvt9vZ+hqqocNB2MOxKb2fV3mGQ6S8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(186006)(1800799006)(451199021)(6506007)(26005)(9686003)(71200400001)(7696005)(122000001)(478600001)(82960400001)(33656002)(38100700002)(110136005)(54906003)(66556008)(66946007)(66476007)(76116006)(66446008)(4326008)(316002)(41300700001)(8676002)(52536014)(5660300002)(38070700005)(7416002)(8936002)(64756008)(4744005)(2906002)(83380400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W5uV2uaukO3vu/WaCWK6ykQ7S6U0liCakeUnAsqKBmD2fpaK9VqqAY8uo6Fe?=
 =?us-ascii?Q?3vXax7yFobVJr/4WTrwraZfU0xYUdccNRwa8Qbocp/O+OntxY3JuKT2Cb5VN?=
 =?us-ascii?Q?jc52KuOfjh7xrWWGN7UXLYG8TQutYIkrAQEMIHIaQP81g1AnlD8E2aJlNc52?=
 =?us-ascii?Q?xneBJ8cd8EjVp6dHT2T3NpQevdaO9UVrugzC5PEzu8ZVwbDzIBRHU3LkfH0i?=
 =?us-ascii?Q?ljSJsXrlYXIrEWU6wBBnWhbNwJbH5HoBP5f9HqTjQPMD+2AAH5Za+7nXZwAE?=
 =?us-ascii?Q?iMIGxknL6wYTIC5NqQ+eesT0P10wP/RUtoakHhDggcUEpu2vQiyJJGl75Nmt?=
 =?us-ascii?Q?f1Zboye03BHobcX6lRYfu+jQyOMphVq+Q0IEuLP2fVfzAuiyMEek7P1xvvDL?=
 =?us-ascii?Q?sG4mvtM8Vbi8k4lAJZLwcUnoU0fpy9U4hBPoimzaiCdJP+SLeRUOsSfPn01x?=
 =?us-ascii?Q?5uyCZne4Dnu/1ikEuVSzDojj3NOYwEr8D5jyWZgeMpX6ojKQaobX2q7R9qN2?=
 =?us-ascii?Q?Jnc2v2tYUd7mw2W/aTC1CZ2LHbVwwJExFn8eq5QRbIqrX4bl1tUZ8l/LOSX1?=
 =?us-ascii?Q?nooNJycDfFlghJ6uZSG1YaP5zou82Zy8jdQJAYW4rCUjTwzH3BNIakkiG1Gx?=
 =?us-ascii?Q?3RjYLFcwNYXthPZSOqgKgiwUtGcFqR+CRk0kU6W0cBQEMO9/c90guWhlJ2Fa?=
 =?us-ascii?Q?VlT011GPasNvVhpXw79ztLUsTBvRxuaDRyKs92W5YACNfSiE3q2tOqZgf0ri?=
 =?us-ascii?Q?Pdg0oMHpWfVuOg8D04hnsnydt5zSOEtmWFtde+n+bfrAamyCV0elSTlV5OKE?=
 =?us-ascii?Q?PRmouB/Kaa8kcFTabIbZgZVKtPoBzBR8QSdQKB3a0RGHTf64JJbg3SEGlJj8?=
 =?us-ascii?Q?GHxbOaxQZhXUe0pTzZ2bROSvFi6z3b4oZvmoLxpUNBJEcKlvYYe8Jz+1e9Ax?=
 =?us-ascii?Q?kIcO+u7AdBcZEWoGKGRP9s7/UZQf9izEorXsMXYEVQiVW3PgMCSeMJbYQ3qD?=
 =?us-ascii?Q?pNM8v3qewozIsRiXxw3J4vucpRdeLl2PzAZxaLri6e2pROMzqkpZ7AP+XeNc?=
 =?us-ascii?Q?wzbCkvRhQLmLKlBoygqDRvy0jku0kdsqZE8jJkBWelQUuXloKPfk/Ogo8LnM?=
 =?us-ascii?Q?HUMfLK26ApdsTWZSFwvRcDykwNYHS/KC++Fe63fOk2mhT7EmLoKw/uncRP6Z?=
 =?us-ascii?Q?60LWIeR+RVdZEoTcmpNsAmI9ANbPUK/s2xRXpbjLRMe3882G+Fsrxlf4mgub?=
 =?us-ascii?Q?ji2mJ+1RKEiS4Pdq6AIERb1fHFYh44Yn0Fb9BZboPi6xDbtNLHihshDJ4bhI?=
 =?us-ascii?Q?Vjd+Hb0XA4xT545+bUjIz5FX8lwqBLabmc0XdMR3mOR+1E7R/tqcl37lASqE?=
 =?us-ascii?Q?aj9CbqeB/Rd5LJUShfnTfvwupjq9j1ZH7lA/xCAqRUokbK4XBfOTObFeHpWZ?=
 =?us-ascii?Q?6Uz0cBL8E9J7wD35I8KlHQNOnR6jVLTx9AqBtKtNtx4DaN67ppAjuQ4OcII5?=
 =?us-ascii?Q?3EGEyOM3B9uPjfHP1gj/IBz3Yka55kG7fbmEClPtZwvnPLMqa9KFJHv/jAWg?=
 =?us-ascii?Q?HTao448WgaHN6faplfAGUZNS8sT+wqXLo/BFH+A2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a990402-198c-4702-e684-08db988cbebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 03:57:26.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mg+JHj1w2h6jwEd6LTE9q3bBvr+RCIiVV9GrHwOatWDXsKMsRTnDoVLEhY9PvuNqPROjPWXzuwYxB5UuUsIySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, August 9, 2023 1:27 AM
>=20
> This is preparation for the next patch.
>=20
> Each iommu driver is associated with a 'struct iommu_device' handle. Pass
> in the iommu_device to bus_iommu_probe() and all the way through to
> probe_iommu_group().
>=20
> omap is weird, it has a whole bunch of iommu devices that it creates a
> struct omap_iommu for, but it only registers some of then with the

s/then/them/

> subsystem. In the case it doesn't register then it has to open code the
> call to bus_iommu_probe() as it's omap_iommu_probe_device() function is
> sensitive. Pass in the unregistered iommu_device struct and move this cod=
e
> into an else block since there is no sense in calling bus_iommu_probe()
> twice in a row.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
