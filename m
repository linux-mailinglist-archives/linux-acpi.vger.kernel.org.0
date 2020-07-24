Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E422CB71
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGXQvA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 12:51:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:25644 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXQu7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Jul 2020 12:50:59 -0400
IronPort-SDR: +/goQ1VxGiT7/Vp+dBuGlIl/SO7cgN5y8Vpe6rDaq1GLswVUTkhRgVuQZPGn5dhIeMOiwa/bUP
 frGSDHc/Denw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138798823"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="138798823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 09:50:58 -0700
IronPort-SDR: qg7hBjCe6wCl9dlc0Yg+rb5I0+NHf0WRiK+Tn4Oyd5TFwDwe3bH0TtBoz16sRamvh7nUtlG88f
 lrATqA1d5m2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="433134024"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2020 09:50:58 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 09:50:58 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 09:50:57 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 24 Jul 2020 09:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flOVuuwKGo4O3e/vQYQc+jnwmRjCvfoo6SBSOw+FoF+592pkci+1mfvP4K6EHcI2RTJcyNhEmhr+UdO8j7AMUGvXj/2s6fyIcDGN2GL/Q53IVQy7u0UD8bkA2hvRfOCRoVppz81BKlqkzs+Ra49B2qbemoQtZ1e34IzTKGECsBLAq2DNZDOJ49EuUno+CE0kWY9+6T9PoVPwUim4a6RS3them3gY8NvxwQPNU473zM5DxIqH84OQ+T9DJJRp4oTJvWnaDVDIBXHqBJ2ScIYu42tAMtF/GWgdRYdeqRITSnaAL9EaJUxsE9W+C1AACAUBvH9eC11tm0tUlT0ABwmNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0mz/37UbTb40p+d+Ae/fF6NIP9C8MNFOVAWvIDz6w0=;
 b=TOxDEJ/SYwKQLm0tNBZwXgRQe42A1r8XZprjt5vu7VFo2Km/5CuoQwN0Od5qmqhIctkHFDJvS7TLAe+ZxOy4+kEHWMvRwd597XyICJF2mUOnlR0HrNIc6ZAN+O53zyvvX32b++bLlloV0JGKc/IidADzMiSRCpqA3uV+1mALWSOhSUnCBWc2YReUNV3ckeg2PyD3uguCM9W5ynxn5NEwz4PmKNPxFgvAzt+QVbL0NRTh6QIUgf8j+3W56MgGraoJc8pH4hoHsA6kbYBWO/5DgDKV73H+O2zf0sp8qRVWK//0Vf/RjrzjfyqJ9gArrSIyEQWN+batA+OiRh26tSsKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0mz/37UbTb40p+d+Ae/fF6NIP9C8MNFOVAWvIDz6w0=;
 b=TIXm15o5vk5mLMguCbL4oBXb802RoSB3/75Tn+uKST1sm2FzGI+9szIf4VDq/7+eXEM+flPOGiRYOIZBgb0kj8oanI9NfbZEGt5zrkQIVKn/wk5oey/qJI5g5rxrxeiZdX7Y6joDNkCQM3ITev/QxsaM0h4jjYDiXK2HAADXr7o=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB3975.namprd11.prod.outlook.com (2603:10b6:a03:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 16:50:55 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c%4]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 16:50:55 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Garrit Franke <garritfranke@gmail.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Thread-Topic: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Thread-Index: AQHWYdZ+JdA88oPRJEuxGV8RX7TGgakW62CggAAFOQCAAACpEA==
Date:   Fri, 24 Jul 2020 16:50:55 +0000
Message-ID: <BYAPR11MB32563CE55D8019DA86861A7387770@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <alpine.DEB.2.21.2007241814450.2834@hadrien>
        <20200724162050.18077-2-garritfranke@gmail.com>
        <BYAPR11MB325604ACC5F3BCCEB89A58AA87770@BYAPR11MB3256.namprd11.prod.outlook.com>
 <20200724184738.ce10d8db0bbe138e2b24f7a6@gmail.com>
In-Reply-To: <20200724184738.ce10d8db0bbe138e2b24f7a6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6087cf14-b7c2-46bf-a930-08d82ff1bbe3
x-ms-traffictypediagnostic: BY5PR11MB3975:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB397588620989A11D815E782B87770@BY5PR11MB3975.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMQobKmk5Au+1NchWau7Apcxzl+GrmcfKhmON8g2z9xjRUxE2SCt3rVFkME8u6ZE5Dm+Q8E1oqzyyWRDFV2DMFL2b0BUcOnxfA11qa44306oD206IE0XjSly3VypmSxWCmWXChjjByRtVsYXTJrlLbyql+2/e963vGFI2tz1iA2cRsccIjc2dotwls+iPIOeOhW53Pm57Y0v7bW5jT4FiomkbbzxM2ziT6CQI4583D097L63Mo457v0wcvTalqug1r///TrOkmpnVtIj/uoFEKHfii8vRm60p4hRSBbc+g89TcNHDb9JjEN/KniHTUCN/TWTdQ6sx99w+ScCIw1eZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(4744005)(8936002)(478600001)(7696005)(8676002)(54906003)(83380400001)(6916009)(71200400001)(76116006)(2906002)(55016002)(316002)(66556008)(52536014)(66946007)(33656002)(66446008)(66476007)(5660300002)(9686003)(64756008)(86362001)(6506007)(53546011)(4326008)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: P8b0ezLFiJhPtwHj7PBZZvbMXTvASlgwvjTF3chTqhVH6ybHnHABPzbXGGkgI1sn508jDwFDbxdjeDeOuNF/ESEJr+xzuBYpRTvcNFOzXei5vqxMZcAICLyK3eSg0HUZ9mW/RkI6pnvzHytGGGWSCf5jws3DwmNQst3H8BTbFJE25gZT0oM9znh6E6FUyfH2qOKmHu5siBr7MnqRzmo5GDh9d7IVZ2bnM426j3mI4fwO/fNuWFjxM4Q7TMzST2g+Bvs3MfSOnDYvLekb9BzpucgQObLRjQNOekiEXSA3whorwpeqmO9M+tKNlgg8Rwazw606vJVmjC3/JFiGmpOdBtR1Ky+ImnS1mIhq0frg6oMpsTYzZNyZR164DcX9vIoYU0OczZdhhOdSWkEKK5WMl43sA/0EP73zqzOENyMWJ9G2RqRbw8qw/74hoqYwsRRxhKmECZiJRYtZU45kGAD8cGB9G3WkZRibpdPu8yGED9naVd5cJRJsOqwBah6yXPEo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6087cf14-b7c2-46bf-a930-08d82ff1bbe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 16:50:55.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHP6SYujHf/Fa/5knbl+CS7likAW/Eg2fPVh7X+np+K2hnepUC9b97nWPx/bmmIZY6AO8xtDQ7F+P3OjhFChHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3975
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Well, since BIT is a linux macro only, we can't use it in ACPICA, because t=
he code is compiler/environment independent.
Bob


-----Original Message-----
From: Garrit Franke <garritfranke@gmail.com>=20
Sent: Friday, July 24, 2020 9:48 AM
To: Moore, Robert <robert.moore@intel.com>
Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; trivia=
l@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; kernel-janitors=
@vger.kernel.org
Subject: Re: [PATCH] trivial: acpi: replace some bitshifts with BIT macro

On Fri, 24 Jul 2020 16:29:14 +0000
"Moore, Robert" <robert.moore@intel.com> wrote:

> Where is "BIT" defined?

It is defined in multiple places (see include/vdso/bits.h for example), the=
refore I blatently assumed that it would be defined. I'm quite new to kerne=
l development, and I'm learning along the way. Thank you for pointing this =
out.

Would it make sense to copy this file to this drivers root, or is it not wo=
rth the effort?

Thanks for your time
Garrit
