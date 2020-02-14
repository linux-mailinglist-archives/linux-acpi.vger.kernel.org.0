Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C168415E998
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 18:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbgBNRIB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 12:08:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:14682 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403971AbgBNRIA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 12:08:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 09:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433080978"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 09:07:59 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 09:07:59 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 09:07:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 14 Feb 2020 09:07:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGntPuBmFitJWKjARpiVzgaVScefjbSP7pybJuxf42dRSJD1d0l2UWkFLWYOBA0/YGnryss+KAd1KidZ0LjJii8mhnWVRejn0qLAX0uoW+EVCQpC0KaC3SNffRiM819HcmHZE8HMJNc7c1qhhXodu/QLj0zm9WJFwyI/gFu3I7Ko4RE8JIcZ2h/UlS1NMWevBNzPvd3aI/g8Z6BXSX0pxpBCg2W4z9NyILGAYSBtJXWCiXHwgIjh/0EffZAEwBelJ2arQtGennCagRDpIBlAIfWbPULMSoI2ZE4/seuGzCNC0D77tIEkeBLTJIoCDKL3Qd/oG0bHZSAIaPHh/oI7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEZ8spLu7lD7q0/82UEsCt/f9GgWoYbpYbRFgi3x4sg=;
 b=nBlq67HmABcP8wWBg8Fq2kZRO6uZ8CxiboP5tVaAQLHUQHc7ZZCbKzZQFcLlseqr6bZTrY4HHjtClxJ770SnEjeDTICM9UODOpt2e9QKfgDkHGXxU/jkmmf3N8PYFPFD/0vXXRaIlkvLP0Vk5j84DH85eGZ/kTCUi89FItlmzVUDbmmqdrh+jGWHNvCTGmSb+wMhzaX95OvHT8+RQ9hhdCkQZ20lCnx/x66gQ/JbWKEr2x1doR0jzXAHNUyEAhwHeIUPtLbvgWCizpTAMt53ZbSVUgOvFrK31j4Vw0QdaxfHjLaf0X84qPBXXrwfGjUYSrrhrDgoe2Kn5+Gt07w0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEZ8spLu7lD7q0/82UEsCt/f9GgWoYbpYbRFgi3x4sg=;
 b=krPqs5fbr+nBF0zTLm70U5phTNVqhEKf8RrLzGA6AezGtqOJ6rkmRWDJo1/0756aCRFhUIFjie3QjBvTbBQpH4kHVXGdhVzR53sB6ACv/BKUAyiqg8uIExVmSOcEuAbo3AGlxgJtIEjlwqck3GdtUFXnLGNnC4LKR5zXZh8fBfE=
Received: from BL0PR11MB2946.namprd11.prod.outlook.com (20.177.204.15) by
 BL0PR11MB3140.namprd11.prod.outlook.com (20.177.147.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 17:07:54 +0000
Received: from BL0PR11MB2946.namprd11.prod.outlook.com
 ([fe80::38d7:a675:2790:563d]) by BL0PR11MB2946.namprd11.prod.outlook.com
 ([fe80::38d7:a675:2790:563d%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 17:07:54 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Fix a typo in acuuid.h
Thread-Topic: [PATCH] ACPICA: Fix a typo in acuuid.h
Thread-Index: AQHV4wBKlXQSDH021EqG6SYoIQmOdagadaCAgAB2gdA=
Date:   Fri, 14 Feb 2020 17:07:53 +0000
Message-ID: <BL0PR11MB29466C25466F5A88B4D4F5B9F0150@BL0PR11MB2946.namprd11.prod.outlook.com>
References: <20200214063003.29741-1-christophe.jaillet@wanadoo.fr>
 <2712088.SaWAGPlJqS@kreacher>
In-Reply-To: <2712088.SaWAGPlJqS@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2ZkMjYzOTktMmRlOS00ZGYyLWFkMTEtNTlmMzc4ZTBhYjVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOCsxbldrMEtsbkZCS2N6c2o4dXpvQ2ZWYXBERkdvb3hzTFRjeFwvdERKK1lnZjNESmZcLzNoZ29ObUt4emhYK0hQIn0=
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [134.134.136.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e34d774-fe52-424d-14d2-08d7b1706e55
x-ms-traffictypediagnostic: BL0PR11MB3140:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3140271898AA50F2DCAF4ACBF0150@BL0PR11MB3140.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(5660300002)(2906002)(8936002)(52536014)(55016002)(81166006)(81156014)(8676002)(9686003)(4326008)(478600001)(316002)(76116006)(66476007)(66556008)(66446008)(86362001)(110136005)(53546011)(6506007)(54906003)(7696005)(26005)(186003)(33656002)(66946007)(71200400001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3140;H:BL0PR11MB2946.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFkLlVRiS2mqdsm/kBimBhGAxdiKO6ziUYt3eD3K/46u1xTkmM+lCskNZAP4J3If8zJ4tLFMWCWBVmhlt0Pyh4XHk5j2QGmQIcboeIYPDMFGJxpg0bKeMkGlEyKc6ZTrMloknxRKBpQXWs2k6eroiOieJDiLEBhx/VFykj6iTu27VENd4S84Nunqyj5TUKZmyNy3NEC5qT7v8cWK39rI6u+YtANvQkq9YyuXzN3fDPILd5D26emeFA3mXyNVEv5gRb0zXGMG0PJkaAPCqF8Mha6WHgVFvWuBBiR1sjXwgDeh+viGQLrz8MhrwdWVi4fJsO2AR8jVg2xg1P0IAKZXLXJrz/R/JdvsqnqTq7pAxMGHfzHEES7f1DNBCgndx80Ii1Y89ZKmhy7n3sNxsOKsXWZwdVU65+ZtJablgwjgP/GXzMXrxrzD8JiuYjesHHrH
x-ms-exchange-antispam-messagedata: Oy0XSLpY41RHjoXKJ3lSm8zjb+jPTVFFBmj+OKkJRL17U3WlGBDmC0RGPMBgWXbeYQ0v2BPM0Dorijm0U7X37aeB3c1KgyP8tpMhBBklY/M+xLRLzY/ec47DS1Xc1ZXlYTknNyEMgkYy6C+S7oMORA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e34d774-fe52-424d-14d2-08d7b1706e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 17:07:53.9728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7m/16jxu82V2txTI6HkzWro7/x0iW27iDe0VrGxWBETkE/8YyL4u8h3BA3zjJ/P9gkGDoS6zHApBCvFdxSkXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3140
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org <linux-acpi-
> owner@vger.kernel.org> On Behalf Of Rafael J. Wysocki
> Sent: Friday, February 14, 2020 2:02 AM
> To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Kaneda, Erik
> <erik.kaneda@intel.com>
> Cc: lenb@kernel.org; Moore, Robert <robert.moore@intel.com>; linux-
> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: Re: [PATCH] ACPICA: Fix a typo in acuuid.h
>=20
> On Friday, February 14, 2020 7:30:03 AM CET Christophe JAILLET wrote:
> > The comment related to the ending of the include guard should be
> > related to __ACUUID_H__, not __AUUID_H__ (i.e. 'C' is missing).
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>=20
> Erik, please route this through the upstream.

Thanks for your patch!

I'll add it to our next release (in March)

Erik
>=20
> Thanks!
>=20
> > ---
> >  include/acpi/acuuid.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h index
> > 9dd4689a39cf..9e1367b19069 100644
> > --- a/include/acpi/acuuid.h
> > +++ b/include/acpi/acuuid.h
> > @@ -57,4 +57,4 @@
> >  #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-
> 7cb7b9f4e500"
> >  #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-
> bc9bbf4aa301"
> >
> > -#endif				/* __AUUID_H__ */
> > +#endif				/* __ACUUID_H__ */
> >
>=20
>=20
>=20

