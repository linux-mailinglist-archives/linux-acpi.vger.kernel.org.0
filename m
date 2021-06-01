Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0D396CC0
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 07:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhFAFYT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 01:24:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:46593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbhFAFYR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Jun 2021 01:24:17 -0400
IronPort-SDR: OgvAG1A1uQCXni4p7RJcz6mOUsz42Cqh3yqOHS2SAi9jgwi1eiE94Sc9BY8mdxCCOSY7KtuyNN
 7MP8q/7CqW6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190831867"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="190831867"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 22:22:35 -0700
IronPort-SDR: cWZ4VOWRxMdBToMvKk0w0MkFseDkwsC+jiDQhrC3F73iqJ9SXV+clfzdABaiDZZgoOVHSy7PW+
 Yy2VXVe44Fgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="445195426"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2021 22:22:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 31 May 2021 22:22:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 31 May 2021 22:22:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 31 May 2021 22:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5uqMPhqdLsV0B0HqBGS2yVIF6aeZf0iKS3qQI6fHPU5yM+HJHff4jsxXKSbNnena2SyKW2ukPhZii4Sc2AdIehERMhzdsFR+3QQWEMGCpB1PWyWXvj10yhLngHwYnpL54VfLzey/wTyZ1JXBjsTL/rBkFkQiLaWAFuW41qa8dgvFWKbyxk6EdgNWKPHn3VGDc4Id06PyOIvv7C5pZuRt5dr8gfksLMu0ixMHYVSSoFcLipLaSKaidDGBZxLS0EJw153yXkSmes+L8l7fPGig13EqOx96KLcSSWSp42kaPS+ExDqMDaWyCQ3G2ANqTL1Kmdzhjz8K4QpmH4ib9d7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHM/MFQhDJYKs9Exnbq+0doMa+v68pDt+b0e1d11mrA=;
 b=AKprL+dS3mK/Xh1xKYlo/W8qNZ/kBT4pdhzWJs5oRIIrDDMAc2JGGXsKFrRrhnKzbv0WEq3m0d1ThbV4wIj4nCTCZsHbrQjr3pxotu4NAfuaWVkwpeelvi+jfUou75kEOgp8/lsUNxhuDVlIvOcqtBLNDqTZTID72MTfr/bMUjH6ZudaMdytYPaWbn165UIkxf2NZLn284xhmRinqXpsoPa5CB4z1FFJiOTdFpTMNZcPEzjPJFDeawrF08OUQOvbxjjXpZHBq4uFOp/xdaDindaEeeq3/vfONL9WTVrOZLrKlj/AcpOF6+UEbb9Auzqlt32c0h0sDPwZ3BTeBT1uTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHM/MFQhDJYKs9Exnbq+0doMa+v68pDt+b0e1d11mrA=;
 b=nTxjnda82OGHN/fYSkv9ujEqpNudcUdukRBPGXm7cJZfMuq0m4pVmV7LF9IiUbi1DY1WrwkzpSNSk3ofZiwCo6f2QnVAze8/oR9MvkU+Wt1JPmTkpdvmLTCjcfZ6ls5AgQKaEL7aEoIMy3p3mh/oSxiuBzCaR66Yja7eAVuIEX8=
Received: from PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 05:22:34 +0000
Received: from PH0PR11MB4853.namprd11.prod.outlook.com
 ([fe80::4538:f545:1ceb:ad83]) by PH0PR11MB4853.namprd11.prod.outlook.com
 ([fe80::4538:f545:1ceb:ad83%3]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 05:22:34 +0000
From:   "N, Shyjumon" <shyjumon.n@intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "prike.liang@amd.com" <prike.liang@amd.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: RE: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
Thread-Topic: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
Thread-Index: AQHXVejOFGHHDWoP+EKimeZfh9bERKr+nn7Q
Date:   Tue, 1 Jun 2021 05:22:33 +0000
Message-ID: <PH0PR11MB4853EBD21B8D89AC8138308F9E3E9@PH0PR11MB4853.namprd11.prod.outlook.com>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
 <20210531064655.GA1417@lst.de>
In-Reply-To: <20210531064655.GA1417@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [220.158.156.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d1a3821-6a66-4d0e-089c-08d924bd42fe
x-ms-traffictypediagnostic: PH0PR11MB5128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB512870FA0BA6A79D7BB6CDAE9E3E9@PH0PR11MB5128.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBbTbEzRaTAWrM/j7Q44ugXXghee+XmmN7Zl+m26J7YAbbVf7qNAVjfgs6zKsLddOCWRHxFbBxCu8Dz8WCAtiJn0CVYNLXSGPIo3kmoBC4kKHcsc7GckysH6oeDGRtwGUsW3Ukf2ZHeAJ418K77Tk8XPupLQj9RAB5XSNmrSmvw0K9AQNuAYEjQN79LyOF4fDCX2TifX+VGsKWhR7E4uCoFwRjp/ojPF/YLIJeUiSC8WgXFVv/vehdiPPm55Sg/hbxVTK2/aaxEQ0CYsWJ09hBAgSrS2a7+TWOe3jJBDZ02A0DYvzKJ9hyybdwxPMOoecESE996IaMflYLbVVV1tPU/uMOiETl8r/wCf3RHmGAh8wIVZ9FcccCAb0DKbUkGB6TaYxot3rvZrlbxNvtxm1bCvzx9/9vhiFKthIdeXXWmUioLS/GQY8gIAOts74IATAFIva+QtB6ndlVrfgN3EXgFA9EJnWZvRsgarVumXFIgMcI9VE1mmzysBbrSRLcvU/Qrt7RyJRPbTs7uXBI/T5LcyWzSK5PhQ+S4HsWFhw+gGDHPAPvR67B8EGczlqZSxzWVOKcDjsK1ROzKcAzUdFURnz91kJxTOtLNWAgjsXbQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4853.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(9686003)(71200400001)(83380400001)(478600001)(86362001)(66476007)(7696005)(76116006)(66446008)(53546011)(66556008)(55016002)(6506007)(64756008)(52536014)(2906002)(4326008)(66946007)(110136005)(316002)(54906003)(7416002)(5660300002)(186003)(33656002)(8936002)(26005)(8676002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gWMaHeeBHgywjSUrGJdgbDxz9zcP3xJJ05qf2nYjw40cRR63veEOB76kUudj?=
 =?us-ascii?Q?XcPgRtVIdGeffTDODIHn/DVcPYKo88KQ6n6zNltEfTpTCHNUYvlfGE5dRefY?=
 =?us-ascii?Q?wGQoSpLf0XYUMh2Cyhi9R/PV7LTY2sP4YsIVJ9sTMX1UsY3gEyZTeR7XwPO8?=
 =?us-ascii?Q?f3PlOiMBj6KznIdlH2tB3rmlGLrTKUBDzY+OfotSFY+EzfHfpbGczy0mtnMo?=
 =?us-ascii?Q?PRjZKrvIuXHN0KGP15eYIjImXrSX3AwYUwLkIXZogUkmLBswM+DjTjrIYwvA?=
 =?us-ascii?Q?mFWTIJrpWcZ43E8/+yh5b3cuHQjORu2we4TdRgSghhVQ80gdPlNNJ53DDNyT?=
 =?us-ascii?Q?LNLs9K0RHCAsLKNPAEbdKuatrjSqE6JY89OT5/Yuosr1g0hdf+VWn3ElrdMM?=
 =?us-ascii?Q?9OiYa3KbKgJUiFq2rtC9RuTe7GdzBJKaztel0wvd/3wHpjcwX0ZdjDLgR0zU?=
 =?us-ascii?Q?IvNB63DhTrULW/4K065H0TLZsih8CDoqZxi0BPEDDGz0fH/CAx6iBihh+Bb+?=
 =?us-ascii?Q?Xpe/j9D79VRlOpOBFSlEBzlUgbWt+5c3QaZoGRrmgl0+ewtrUGek2hDq8TED?=
 =?us-ascii?Q?Nt/QXTfbPH/hznSSRNoI3swrEIsMHxoQ6ejbcEmlLVJFT7SVF4fqCIHoCZwv?=
 =?us-ascii?Q?DAZdPWwU3KXL7CfaJPblShaMGudPz/qYFVxvh7TtafRRkw+1ibaNSTcnkdHe?=
 =?us-ascii?Q?qYnxP1VKU7DpNTzSWJB6sCZaeMGTN7IJHHMak9iDqe39BJcaO2YmZNv82MtX?=
 =?us-ascii?Q?j/sKjD8p6WHicv3JxFaPdVRKZgjefGfdnQKwiMv2JRdD6HbJ9s6w8nU9ZBZR?=
 =?us-ascii?Q?1JlIaei1uBPtJpAlRXT0GQhOFqel8lkRSDrDqZRKxpCxr0Tyxf/qnAM7OS+J?=
 =?us-ascii?Q?/Di3Uo3s+jIoLXTKsc5BxbqOk+Zdzn40yhRKsGIS9pWwAxyl9OdyvKkG3eYC?=
 =?us-ascii?Q?WZXyPDhkT1cPbUOGn3CQ2Wv5Fepeo4C2+9QdUiINHhD27qjN6q57OdI4JjUG?=
 =?us-ascii?Q?BGs7h5vYwx2XJZWpo/sT5V/AsEvj4WebcpFjc2hLg6DPsHga24XluDofUoxb?=
 =?us-ascii?Q?r2+vSOVvOjVZ1OYf8c8xG6sgqyQnQ7frMLzlXU2H3xHvtNWnPUBFy7enonM6?=
 =?us-ascii?Q?W+1TkKnFJUVPZ+JT36l43PfOKNVw8jSOe2+cX9vyTx8zO8RDjmcVKV//Z4dy?=
 =?us-ascii?Q?GI/96EDRKYDtU4q1K4d63zmtk6CJDZGMx82UMIhmql5gegDWecx4MxrdyywN?=
 =?us-ascii?Q?3dyiEyQiEMhylgdfQ4IXEOSfgOKJDTISuEzuQjbJPDgMr94Peg3oE7Fym1FJ?=
 =?us-ascii?Q?9+2wZglrmcYVLDs3ey7WtfjG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4853.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1a3821-6a66-4d0e-089c-08d924bd42fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 05:22:33.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wTwAnTgLkrkp4dh2L9upQ4v6Rb/FkY5fXpbVUdAo6H3RZRk0FLg0AGTQZu4jzgoDcr/O32Iqic+a+m5ILMi2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi=20
Reply in-line.=20

Have a good day.

Thank you and Regards,
Shyjumon N.
-----Original Message-----
From: Christoph Hellwig <hch@lst.de>=20
Sent: Monday, May 31, 2021 12:17 PM
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Christoph H=
ellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; Rafael J . Wysocki <=
rjw@rjwysocki.net>; open list:NVM EXPRESS DRIVER <linux-nvme@lists.infradea=
d.org>; linux-acpi@vger.kernel.org; rrangel@chromium.org; david.e.box@linux=
.intel.com; Shyam-sundar.S-k@amd.com; Alexander.Deucher@amd.com; prike.lian=
g@amd.com; N, Shyjumon <shyjumon.n@intel.com>; Derrick, Jonathan <jonathan.=
derrick@intel.com>
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACP=
I device instead

On Fri, May 28, 2021 at 11:02:34AM -0500, Mario Limonciello wrote:
> The documentation around the StorageD3Enable property hints that it=20
> should be made on the PCI device.  This is where newer AMD systems set=20
> the property and it's required for S0i3 support.
>=20
> So rather than look for nodes of the root port only present on Intel=20
> systems, switch to the companion ACPI device for all systems.
> David Box from Intel indicated this should work on Intel as well.

I think we need to wait for the confirmation from David.  This looks good, =
but I'd like to see testing.  I also wonder how many of the simple suspend =
quirks we can drop with this.

Shyjumon and Jon, can you retests the platforms quirked in
1fae37accfc5 ("nvme/pci: Add sleep quirk for Samsung and Toshiba drives") w=
ith this fix?

Shyjumon>> Yes, I do agree we need to test this also. However the boards wh=
ere which I had these issues are not in my remote access now (as the work f=
requency on this boards are less and also due to Covid situation),
                        It might  take some time for me to test. I will upd=
ate as soon as I can.
