Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6007018F9FD
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Mar 2020 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCWQgw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Mar 2020 12:36:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:20283 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbgCWQgw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Mar 2020 12:36:52 -0400
IronPort-SDR: XSG0IvWZrP9cCrCMO7pZbipRY+9VSz1lQc/GEwKjpBH0z4VVK9wBWV8VWhQPEYJtJLhWmC4cTD
 UCmJo3/mEB6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 09:36:51 -0700
IronPort-SDR: o+w/wcI7pjLS0euBWRz7jblA1WAdyS1Jr3viO/9Hk2I7ck29tu+Tad8aIDd3APcrk4Mz+h8hPm
 mSRyNu2GRsdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="239984500"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2020 09:36:51 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 09:36:50 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 09:36:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 09:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G50MInMlFirvvgJVSVa+G+ZQ/oupBtJZsxyuB58HrtZTXFjjVjH+Y5HM91MXufAbULmsmeF8aYUhw+RPZAFAWOBAbLqO5h+ewTl2HqmGblHmOaQNHNyE6Jg1msR2bimCVldtgFmWJXtQvpcpZ6xoCX1klMHuSLsWePq1dGEPmny2wCc+ByQcKJRjQbgCBuUmuKHkM3OEgvp8RO08MwdlAISQaB7fLC3clnxA2TmPnyYd5buf7tKSlS6VKXDhpr5QyUbbUwohdZst/mJeyiBnwqmzFEPLSLApridEFkWNHGMqcVHoCu/iI5XOYmrD7Y0tyEDVic8FQfxsygaaFXH5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7dJDTDbGiWn9lbtkfUqrOvcLiV2pG8jmY+IMWEZ7Yc=;
 b=Uf3BusuU2NO9v4UKJNjXw12KV6vvBcdjdCklRjOTGGD+f1XsHCMUnfiYU6cnkJudD5bA5q0mrXpKWPwqu59PPEm5L7F1SZP1oCIYJTauF1+81TI0sWr9aGzY2tS2EvphmgkQHaqBWT/Vx43ABMYfQne+ESt0KEh6yolOLAfUnXf8rWh8MNVmc/EhmJhSu2MY1oc+fCnxxZRu0BngrGxGVpKXZiaZW92eG+/A674z6YuyKqNn5bi/Uthq7yt3s2x9Z6x4u5OB9pTALUVR5NB0ieEod4xRjvOo6fOl858bqB/XeM23QyOskovA5N3I2zhjxZheVyvNsB7/tw9vFMvy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7dJDTDbGiWn9lbtkfUqrOvcLiV2pG8jmY+IMWEZ7Yc=;
 b=DVy/B5Wuvi3m5svkQOEN+x/caORCED9BM3GA1ly0rAZtRG4XYKqkGQP3PMBIwEQuTH4K6/bwG+o93RIibLd9I4LOpocQD3U2nmkOgGJsWYJeliy3uJzmnR0P/iy5xIr2KstN7yhdEpguHcVAkRi3Atk6OCb2nuDR4hLUZuwr9Fg=
Received: from CY4PR11MB1719.namprd11.prod.outlook.com (2603:10b6:903:2d::23)
 by CY4PR11MB1543.namprd11.prod.outlook.com (2603:10b6:910:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 16:36:32 +0000
Received: from CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad]) by CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad%11]) with mapi id 15.20.2835.021; Mon, 23 Mar
 2020 16:36:32 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [RESEND PATCH] acpi: Add NHLT table signature
Thread-Topic: [RESEND PATCH] acpi: Add NHLT table signature
Thread-Index: AQHV/u3Gb+pkEvRqq0St3/B+7BGc4KhS2ymAgAOHyyA=
Date:   Mon, 23 Mar 2020 16:36:31 +0000
Message-ID: <CY4PR11MB17197A94FAD8E508AA96D3AEF0F00@CY4PR11MB1719.namprd11.prod.outlook.com>
References: <20200320192727.20560-1-cezary.rojewski@intel.com>
 <1841329.abDEU0iM3b@kreacher>
In-Reply-To: <1841329.abDEU0iM3b@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [192.55.52.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f29cfe18-d7f9-4c1a-ea02-08d7cf485846
x-ms-traffictypediagnostic: CY4PR11MB1543:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB154364588D4F103CCFE1438FF0F00@CY4PR11MB1543.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(7696005)(186003)(26005)(8936002)(33656002)(81156014)(66946007)(76116006)(478600001)(8676002)(52536014)(86362001)(66556008)(64756008)(81166006)(66446008)(66476007)(5660300002)(6636002)(2906002)(55016002)(71200400001)(107886003)(4326008)(316002)(6506007)(53546011)(9686003)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1543;H:CY4PR11MB1719.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pVOhIUqoxFDA1f74q1EMQt7tjGlIUo8G8NNvGLbUK17Ni1L4QYJMEmvCv/tK3yxGJ/m6qO3sjiFt7SL7LuLSDDl5oPFZ9cM90V5tYCbjCFjQe/XILd2jjrHfl0N0+N1+hTdPM29tLafYhEAxYN8hQgvaxPxe0/2ipvZ46eWhj5ijwMuD6/T0n9Baw6emzUHKmLKzN6nfum6wuRU7mGcOPhsK9PObiwY55jU22tXJ4t9P99j6vSJHVQUfBW9jImXuejupgko5D9BT5BJBfqeM6r+bcCVCARHFtAPUL5/EEAtFa6X+T//kzc1fN0MZqadOxzKSZsb0lnwMSPZssLpQg3I39123rQXn7aRMy5/sY8sVJr7OrcOuF3hFNoALO4EDa2qBYl/j4iaeUe2aGeGYGiAFu+zosVUE5lFJ+AZvByHhnOK78nTojZnVOD7m7o+
x-ms-exchange-antispam-messagedata: L45A0a8RVStYfv0f25VUxj7x9ZHPxyz+fo2BC5/4eDo1bLQVXjohnjEOiiELeZDqoUO21nTewrcTLAf8lrcsq4qdTqleS9Q9kEa7ctmaw09OsB7/WiNt/xdO4U/V485CBbtz391rqyK0yGs0JfIxqw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f29cfe18-d7f9-4c1a-ea02-08d7cf485846
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 16:36:32.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2V0p3kwEPJ1H4JoS+kfFJc6azpdnMZq4Sk0+1hY0IYL2ciNHzlQHaV31fnlZFnXN/yiKp7JnOdfTOrC9m3g3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1543
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org <linux-acpi-
> owner@vger.kernel.org> On Behalf Of Rafael J. Wysocki
> Sent: Saturday, March 21, 2020 3:36 AM
> To: Rojewski, Cezary <cezary.rojewski@intel.com>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; Kaneda, Eri=
k
> <erik.kaneda@intel.com>; lenb@kernel.org; rafael@kernel.org; Kaneda, Erik
> <erik.kaneda@intel.com>; Moore, Robert <robert.moore@intel.com>;
> Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Subject: Re: [RESEND PATCH] acpi: Add NHLT table signature
>=20
> On Friday, March 20, 2020 8:27:27 PM CET Cezary Rojewski wrote:
> > NHLT (Non-HDAudio Link Table) provides configuration of audio
> > endpoints for Intel SST (Smart Sound Technology) DSP products.
> > Similarly to other ACPI tables, data provided by BIOS may not describe
> > it correctly, thus overriding is required.
> >
> > ACPI override mechanism checks for unknown signature before
> proceeding.
> > Update known signatures array to support NHLT.
> >
> > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > Cc: Robert Moore <robert.moore@intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> > ---
> >  drivers/acpi/tables.c | 2 +-
> >  include/acpi/actbl2.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index
> > 180ac4329763..0e905c3d1645 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -501,7 +501,7 @@ static const char * const table_sigs[] =3D {
> >  	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT,
> ACPI_SIG_FADT,
> >  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> >  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> > -	NULL };
> > +	ACPI_SIG_NHLT, NULL };
> >
> >  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > e45ced27f4c3..876ccf50ec36 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -43,6 +43,7 @@
> >  #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification =
Table
> */
> >  #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception
> Interface Table */
> >  #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
> > +#define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
> >
> >  /*
> >   * All tables must be byte-packed to match the ACPI specification,
> > since
> >
>=20
> This should go in through the ACPICA upstream IMO.
>=20
I'll add this to ACPICA for now and we'll work on implementing table compil=
er support for ACPICA in the near future.

Erik
>=20
>=20

