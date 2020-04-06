Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1366619FD37
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgDFSbJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 14:31:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:43839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgDFSbJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Apr 2020 14:31:09 -0400
IronPort-SDR: fpMCmu9SsT7IBHwDzdQ2Waw0zBkS2HeVZ/Zl5uDyFUDjjcVUrorBsx5MGBiqNMaPnn8rOjysOC
 iwkU5NG1dyOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 11:31:09 -0700
IronPort-SDR: N1K1/IvDx2Bc4bQpGoFRheqf7Ou3UVNaYeR5gyy8jR1Zif+YSzy/yNpjuFSC9tGFXb94/Ak4Y0
 7gAkrIl6muqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,352,1580803200"; 
   d="scan'208";a="296729273"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2020 11:31:08 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Apr 2020 11:31:08 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Apr 2020 11:31:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Apr 2020 11:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAcja1Tpasw8B45qo4DA5EooC2NwCvQw8zhaS6A4L2/re9lyjRbCKMgOn7WC/daP37GfwjW8lMFf06Whe+5aTIF1VlexThcvsrI+7qpSjFoRzult9Hb1AAP2z2z60Li9GBeVPdzkfcBL9MJ3KqXWhoz+whlLBibhT3qVjh3JNvd0cqRXNlDQOuqC8jE0+N5kl2w9v2YTDwOFRm2ImN6PsaUpTnvSyLwLTCnvkrKkLNCiqzQDnPp8z7+SzbLMrkDIOHaJqKfpvbsgp5bAsOvcNtqzyYHdZxbcv1IuE1ZA4MnDIhI+GqAP56ZloBvk+Wv+/Oy9Q1RU1ZmpVwvmDE56dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x5swxbhd3X+vrwtpfXRGZd1qhqe09ghX93QKBt20H4=;
 b=fiDQZ7P6SSt32f+TJQia3V7bUjoZrK1bGKXfftz8tl8PprGVkZKjAdt8AiC7EgAVqY+hCq0sijTOiKj7VcIUeI1OG1B/noFC372lTPbEkLP1/hNDFkgAc7sjZxgrd6Wla8pNSwnWBX8H/+BoH11p3QGD1uMKkdIWm4yqDpDib75OLMbhJ4RqYvoMuXmIVdY3RjgdwUgYwslIMwBeIBO83qB8NzKCXEeKckD3EFizmD2bSJdOB52QcVYiSbWka9L/oxFqB5wwvkDidjDmyC8qNBuDjfqEFQTjloQZR4rJHBRufHgvNhW9ZaoLCSxzEkcrlzSbIN8GUX3rzKpAdlXamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x5swxbhd3X+vrwtpfXRGZd1qhqe09ghX93QKBt20H4=;
 b=wsvH3Hy28YarKLPYPqAzIqtxKKFuv8P/eqd8AbhaZiPUaoGzs5yOd88OSvXYZ20egc82T38mBmQEjFtr64s//OemjX9IQOaWMeADn2k3x0Jtn8xjIxTy3qFj/LYoEkUb3+dDUPKa94tVaQj5CgNTw24x0aZ/SRsEmGv+7D+GujA=
Received: from CY4PR11MB1719.namprd11.prod.outlook.com (2603:10b6:903:2d::23)
 by CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Mon, 6 Apr
 2020 18:30:54 +0000
Received: from CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::3853:8344:85aa:5537]) by CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::3853:8344:85aa:5537%5]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 18:30:54 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Yan <yanaijie@huawei.com>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: RE: [Devel] Re: [PATCH] ACPICA: make acpi_gbl_next_cmd_num static
Thread-Topic: [Devel] Re: [PATCH] ACPICA: make acpi_gbl_next_cmd_num static
Thread-Index: AQHWCYQFWbp4hiV+/kafGsHvNXkOg6hnIEWAgAVK2tA=
Date:   Mon, 6 Apr 2020 18:30:54 +0000
Message-ID: <CY4PR11MB1719914B52CC92F25827F99CF0C20@CY4PR11MB1719.namprd11.prod.outlook.com>
References: <20200403064712.26746-1-yanaijie@huawei.com>
 <CAJZ5v0gHsUMS+LciZnzC12=QO+hsVkeQWHDR1LC8PMCxoWvtAQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHsUMS+LciZnzC12=QO+hsVkeQWHDR1LC8PMCxoWvtAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [50.39.96.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16131efa-a39c-4910-55e7-08d7da58a42e
x-ms-traffictypediagnostic: CY4PR11MB1320:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB13208FF2B88299C8FD17F9E7F0C20@CY4PR11MB1320.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(376002)(396003)(366004)(346002)(136003)(33656002)(53546011)(6506007)(64756008)(316002)(52536014)(6636002)(110136005)(8676002)(66556008)(66476007)(66946007)(8936002)(54906003)(66446008)(81156014)(76116006)(7696005)(81166006)(5660300002)(2906002)(966005)(55016002)(9686003)(26005)(71200400001)(186003)(478600001)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcOCwfrZoSQ4BE6o+TomZSNekpYXAl9uL6ibbR1ueX627EtkYw7nn7SH5obzQThmC3FYCIstGgGQSa98Mar6s+nXHH2Zpw5sZ3f/SZwfnoU7poA596EkmlyBJ1GNSLr6ZXcM1pD9TqgmGRGorwn7x87exs7iDiMSkdOfDQHmF90aNQXIl4nKsJfFmuHZPlB8h9G3rWV1GvbnN0vqgEGItSUKbvcH6e8yauJPe3ESLawOkKxAki15j14WC5L9cqGjiMxMEOR5k1KWHti1veABOZNucJ30bvEMI8SRrsdZyDDy5i9y7RAW+vEuV33qz6x8Il7K/+YxNxxWfVuFOAKVHXuGC/0ZoOyGDZY08WeiG3dKb5SNb22kX0bgpeBnEZQBGS2BRqYV7CmcHZxmuytcVQSLs3hAsXtINc1kgjSNN9A4MJA8hwMBSKJXbJIl71F7hRO2gCwjI4yAE6ocBbGA/N334G91vNNkn09JYxHO6WUlbjPg17+BHATJ1XmitwKQyGm21R2I9a/N+OZ/Xv456g==
x-ms-exchange-antispam-messagedata: j7ZJsWG9v3GcV0wYh84oTTCWTOYO6K7NPdlNkqPSOYjof2PLvXYXrrtiIEfE1ZSUndshV8fKXZqCcTaj1U/5CfPS0I/QZQJ5HXMvBLUlA9j8FTamQ0iIIOKE5AuYtpklwPwvio5ax/LezmiAsHK4zQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16131efa-a39c-4910-55e7-08d7da58a42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 18:30:54.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c494rcgy9ol0godhJLicAuvBSq8F1jyEBxLYqNfZ1mNL5oZhraee7+Rn2pAoFT28Hth6HuEUv2EidE9wdjzf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1320
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Rafael J. Wysocki <rafael@kernel.org>
> Sent: Friday, April 3, 2020 2:24 AM
> To: Jason Yan <yanaijie@huawei.com>; Moore, Robert
> <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; ACPI Devel Maling Lis=
t
> <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> (ACPICA) <devel@acpica.org>
> Subject: [Devel] Re: [PATCH] ACPICA: make acpi_gbl_next_cmd_num static
>=20
> On Fri, Apr 3, 2020 at 8:48 AM Jason Yan <yanaijie@huawei.com> wrote:
> >
> > Fix the following sparse warning:
> >
> > drivers/acpi/acpica/dbhistry.c:30:5: warning: symbol
> > 'acpi_gbl_next_cmd_num' was not declared. Should it be static?
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
>=20
> Bob, Erik, I'm leaving this one to you.

Hi Jason,

This variable is being used in other parts of the code base so I made an ad=
justment here: https://github.com/acpica/acpica/pull/582
Once this pull request gets merged, we'll do a release and resubmit this ch=
ange to Linux upstream.

Thanks,

Erik
>=20
> > ---
> >  drivers/acpi/acpica/dbhistry.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/dbhistry.c
> > b/drivers/acpi/acpica/dbhistry.c index bb9600b867ee..801b35a08174
> > 100644
> > --- a/drivers/acpi/acpica/dbhistry.c
> > +++ b/drivers/acpi/acpica/dbhistry.c
> > @@ -27,7 +27,7 @@ static HISTORY_INFO
> > acpi_gbl_history_buffer[HISTORY_SIZE];
> >  static u16 acpi_gbl_lo_history =3D 0;
> >  static u16 acpi_gbl_num_history =3D 0;
> >  static u16 acpi_gbl_next_history_index =3D 0;
> > -u32 acpi_gbl_next_cmd_num =3D 1;
> > +static u32 acpi_gbl_next_cmd_num =3D 1;
> >
> >
> /**********************************************************
> *********************
> >   *
> > --
> > 2.17.2
> >
> _______________________________________________
> Devel mailing list -- devel@acpica.org
> To unsubscribe send an email to devel-
> leave@acpica.org %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
