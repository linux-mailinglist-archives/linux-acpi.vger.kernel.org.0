Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1121834DCEF
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3ATv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 20:19:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:38981 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhC3ATN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 20:19:13 -0400
IronPort-SDR: gnoiGDpTj3iBrA3KxJwZuYKlRXO7OptsVZ7wZbfJybMZEg/FjCUVzKzu0RvVuWH2bxbaZ8Np68
 CB4+y8oC3AVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276819161"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="276819161"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 17:19:13 -0700
IronPort-SDR: oADYSzukm5GesqjwIVE2vNYJ9FpgBmgG2WBj8yIRZ+QmUmi2/vvkFo/PooJtIoV2gOrAGHdXCO
 HK9WQTaHpbww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="411341046"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2021 17:19:13 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 17:19:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 17:19:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 29 Mar 2021 17:19:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc54V2fiL7q4UUR+FHQGkupspBoGCjM4UudfZ6vVaG38DBBqUvGO5WhU79ilVlkhZ0ejlfWiX6/wVBYLZygO8w0SxcG1uZJsROBmg5b+d8wiOl+nxQp8ipxsEhG4i1Y0WFfIc3icDn0vjqf9UPcvgNDMmrKB7l9PvJOcJCVKW9xqLgYC+3aQysF4/cc3o2C+HnBS+blMQ6DTeyouoaGNQcuyHnzY66wcb+nV/GC0IgqVXcdaozXkqMNntAimj/rP2Tg0HzG6MhOSAMCTSBXOBO6OWpcpg1UPKWrPLEL3rkvXlMNeQ1ZunFxo0/X4jACScSPWnahec32tS34FCiFheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X29dv5oMk5ffoGiL0ieFG7AaRPM0vu+IKeIIBstl4KM=;
 b=QabP3+ToLsMcf27TteAlzRWW9izB9vX5xngbQujFv9EGBpRSNZkLAflEsX3AZ2T0bIo5hx6WtfAoExIyhYumbO4d1F63SQzPem2bzb79y1bCCuI0tkjsC9AXxO54jD4iyZHTQalc4tFERRvrJwR27UCPtsCKcrZ7RyhtJ2AxikmFYOVRrH4oXNT2ZZ4IntJtulozUGnXZCwsvCGebJsBhyPacpGSuMWgp7C+JpL/MQmxJLr2rJ8EBzSDItClPSg/fQBAoFJZUjcVqW3q5+Kz3wr0krg92QSHPIFtHDt9u5QzwiMmIXE+A9zVzXflHg6n+aiZKcsyIz5gOywQO5BLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X29dv5oMk5ffoGiL0ieFG7AaRPM0vu+IKeIIBstl4KM=;
 b=jgCDE1cRbyXxMSqwjcroZpggU4MYK3ljLSpB0zEjL0u1GcjfG/gzN07+8tnWyJ52j/LUb0z8URUIwUEzxqufYVQCTY9V78BlzcIcntRO693/h/KDleh9PWZziwhgAgM2U2Nz4qXx7ueRdX/HFuDw8qLYnkQy3pxNSRP+bLBAep8=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 00:19:08 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 00:19:08 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [Devel] Re: [PATCH] ACPICA: Fix a typo
Thread-Topic: [Devel] Re: [PATCH] ACPICA: Fix a typo
Thread-Index: AQHXIdYAmyJ9Mtfa/0+JACyqBrsGAqqa79eAgADApuA=
Date:   Tue, 30 Mar 2021 00:19:08 +0000
Message-ID: <MWHPR11MB15993DB0504FBD17DB4B1792F07D9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210326001922.4767-1-unixbhaskar@gmail.com>
 <CAJZ5v0izUkL=7NSFuefNYcqdq2vSxseDCCLKUTOZGC82WjJNPg@mail.gmail.com>
In-Reply-To: <CAJZ5v0izUkL=7NSFuefNYcqdq2vSxseDCCLKUTOZGC82WjJNPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e77bb566-0527-4d2f-eb62-08d8f3116f6a
x-ms-traffictypediagnostic: CO1PR11MB5025:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5025CE8580D46723377CD35DF07D9@CO1PR11MB5025.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQKErYtnSW7GGiPVxlrRTvQizlAVnBqoAXsw/SkITF26sbCeaZvSyVc6OY19aOnm31SflMgCoovj2uAY5GXNvusMOBtxl/ako2+jrs88RwXHSJBoWHsgcgg6vXSC/IwNin991uuMTp83JH16CXnj2tk3WY32tzDPP5DuYY/rgvK3/xNnOWBMR/M3/y2CHy6ei/wL24mE3Z5wVAXptOCCGQDbnJy7lIrHsQWH5OhWB3LjmyG0K83y5TE4jwMUXGUL5kufbFS64v90pxjYIhkuYd5d5cYuYkyxekLZSEiNEL9Ew1lgFbpQCUAi/QxTORXYZOTq+/+VmrspFAn1zKuqmjyO7zAaf0myRjB3WTuKldqhRDlOeL2pVqY+vtSipuGb5GsRmPkGH7xkt3ELt0dt92ZFYf4vb8MtQlDfJJ/HqJCpATwPfRYfzJaUH2ZNhZqxpQhpnKBs5dVQp0OWp/xLgLatD6W/WEft/7WZgRKx43cARUWGtekePGCSXaGSgUORzmCeK1VR3Mp6P6D24fNfzwZLPVpjKBa5dTqE8RsfWfupLA9gaKcmKqJHfybechkUW8XQbn/6/q7YL6vV9OEazhqD8/ou3TAGrHFj/b5udYkqXXNOQDEqKg2/bjMQWyThe9bYneeghg+bd2eSkXf6KMiUKZ2dSTjtqWBMadN1ZZA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(346002)(39860400002)(26005)(71200400001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(478600001)(9686003)(54906003)(2906002)(55016002)(186003)(86362001)(52536014)(53546011)(4326008)(5660300002)(83380400001)(38100700001)(6506007)(8676002)(8936002)(7696005)(110136005)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZMAvGbkfw2HVULkmkGksmxk2oGjrwCJRiq1AaPoLwlV05CUtqaFHnHkiK4oU?=
 =?us-ascii?Q?CeX2UkE0DH0MF88ThBMICNG73SZlCQNeHiVhc+94cFqh5lmzhnCwPbwTJFrA?=
 =?us-ascii?Q?aiJJc6XHEaUu3RIOw96izRBzL/uTl4Ms1cKfVA2Gq/AwF7i9Jk9YmT2coK3O?=
 =?us-ascii?Q?AVkNejs1fU7DfScrOvUamx4oKY4krfyWILmJqHWZFmUlJxHLKEt3VEgMGzAT?=
 =?us-ascii?Q?oYsmT7YLutkRRZd/4RgqVkMDBT88gEGVvECCoucqEERb0u+P2JYMlJS6aDje?=
 =?us-ascii?Q?xpk56JevRCQVFFiZGnRbrfFIy86SyGIdf+JN/lcqqClVFRPYTELoC7NQzi6p?=
 =?us-ascii?Q?93UDR8uI8H0qfKJsW/+Ynh6cJth+Vg1q+MPAPZXpRoasPTjyIv8X/+qJ2C5y?=
 =?us-ascii?Q?zEp0nKa9odqfuu54AYZGdhr/ODCPoTQCrNjpK+sSHo0fcE1cmpgwmXjR8MK5?=
 =?us-ascii?Q?ttiAS7+IQwUSqEzzPi+EYQ3zMmXLhN9uqsniRcSGcAj/ZfMsajpf993F6ndi?=
 =?us-ascii?Q?GfamnXZWAVo3CaAUPE0jKYDvKF6zwGIqaNgZK24alJMR0w65OIdQDvDv0mD+?=
 =?us-ascii?Q?l+sS1Ljzhrovux+4oV8zjotmkxkpPTFLQXyLQbreX6EBYXgHFH1A09vxcb4M?=
 =?us-ascii?Q?O4loPcK4u14+376NGrRFwOShaqsuOXEGu2EcHTj5Ts+cBavD/nG2DX+3JS3a?=
 =?us-ascii?Q?/FSwYNZO5bb1Lj2BVL0BpbeOiLz6cjonQgXhTf0TXen9F40cgszGIiegvtgo?=
 =?us-ascii?Q?DIQw+u3jMVjgCRTAlHRh/0Qyr/+0X4YXQy+Rar5fGc8EX1zcHxOJVTjAEQPX?=
 =?us-ascii?Q?T4f5kC5oKXWs3sNkU+pER7TeuM1l7VzXe+0KdVlg7/eGI7CvWJpbt2xWPiil?=
 =?us-ascii?Q?CjOLG7v4u8qUl/zVzEVScp2IlNxc1gZmv6Goy470M1//hMzZwsI9QpEdlDQu?=
 =?us-ascii?Q?WIZZa6WKwdGP1w2kBW1XnUL1xotq5IkSsq0nRaf1bfNUPZOTcivJCl16e3eL?=
 =?us-ascii?Q?pXv3yI2/lrb4wVJhke7QfotiM8wartLezYdw8mpOiSgF3JfLiFRoSJTYmbNI?=
 =?us-ascii?Q?4gdrlK/knjCpUOFTqUGN+Y9nu7UnCuR0aUzeMTHiSqo1L352UamtT7H4cetr?=
 =?us-ascii?Q?mBwCFdS/WYTVhaeoklw8HWmQAV2V4aASDI2xMxKVeGs6PhUgKEZ96PVi9tDK?=
 =?us-ascii?Q?Bvp6Yq1JKkiq77wdxTsaLg5flsV1nOnOANfuleQLMUbgw+aKXIwvHLsSS8kH?=
 =?us-ascii?Q?kfazfyAzHQGlnSX4Ot1gR+2aHYVWuwtdJfv2gd6gVFsIZSLd9/7NKMiXGnqD?=
 =?us-ascii?Q?D9xIXFM/Fzge3TXUq0SVlsUC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77bb566-0527-4d2f-eb62-08d8f3116f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 00:19:08.0997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIPi0Qfc81tjGywMDLZQjg3Pmn83haSUwF3lwmAu5blZ8NZpCywmVy5cA/EWHKY107WcstUgSB0F9J9h5XlAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Rafael J. Wysocki <rafael@kernel.org>
> Sent: Monday, March 29, 2021 5:48 AM
> To: Bhaskar Chowdhury <unixbhaskar@gmail.com>; Kaneda, Erik
> <erik.kaneda@intel.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; ACPI Devel Maling Lis=
t
> <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> (ACPICA) <devel@acpica.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Randy Dunlap <rdunlap@infradead.org>
> Subject: [Devel] Re: [PATCH] ACPICA: Fix a typo
>=20
> On Fri, Mar 26, 2021 at 1:22 AM Bhaskar Chowdhury
> <unixbhaskar@gmail.com> wrote:
> >
> >
> > s/optimzation/optimization/
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > ---
> >  include/acpi/acoutput.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> > index 1538a6853822..1b4c45815695 100644
> > --- a/include/acpi/acoutput.h
> > +++ b/include/acpi/acoutput.h
> > @@ -362,7 +362,7 @@
> >   *
> >   * A less-safe version of the macros is provided for optional use if t=
he
> >   * compiler uses excessive CPU stack (for example, this may happen in =
the
> > - * debug case if code optimzation is disabled.)
> > + * debug case if code optimization is disabled.)
> >   */
> >
> >  /* Exit trace helper macro */
> > --
>=20
> Erik, could you pick up this patch, please?  It is simple enough IMV ...

No problem, I'll pick it up

Erik
> _______________________________________________
> Devel mailing list -- devel@acpica.org
> To unsubscribe send an email to devel-leave@acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
