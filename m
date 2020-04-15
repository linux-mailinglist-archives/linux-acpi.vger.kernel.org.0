Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4F1AACFC
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Apr 2020 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406871AbgDOQJq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Apr 2020 12:09:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:1743 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406869AbgDOQJo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Apr 2020 12:09:44 -0400
IronPort-SDR: zGKqt3C8w7ws8MNP5NCW7PnywU9OBA/uVaA8cc7OW/KRKh05CivIUcWVgYA/ul97qDWFWF0mB6
 Gk4fHJqPLfvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 09:09:43 -0700
IronPort-SDR: Rf+juQm0Yt6R8lmJypCUfmc+JoYx3NpXXd7JAaHqBYrZszR0KYEpcET01tBskpX40qybNGpPA9
 4ufVIcsVg4ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="332540198"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2020 09:09:42 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 09:09:42 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX125.amr.corp.intel.com (10.22.240.125) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 09:09:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 09:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg6q9T04D9ZOQPcUrrohoYI7ZS0i88NlCmELCZxYtSxamPND1rlj4jr8lcdKoN6d7nOAgJ6GrwwG6/GKQOJXih5HEyni5sN+toljay5b/J2G/cnDXFbIFl0ZMkJY0SgxN4Ux236ZxnRT1ENHKUnjRSA1rFo+wcPpclAIA+nsc1VmCs3JVi98lAb++tdalskHtucECbxgZ/CEguuysDLjVpnwhG5qIVdXBRlczcqh5psDSaVWkvLXgqd6ZMrX0B3OkTykPK0MONblMMuIirh9iAgLp8/1NZbKaii8RS8VnwmqNHkOT/SkbGMQxr1W3/WLgdMZFvONTjIUQ1XsV4RB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/ctAZKDnxNKey5tIBTdEXj5DWNjHLcD4ElWYXDKwfQ=;
 b=TYIPrp0DZto8hkkTzTYE405a9IY8Zhax7gRYraqn8Z/SalKJtnbo4djvOdMBGBoqOzXETqxNlTgEV2fgsrkNG1KwlmJR6ArFxiVUQZuvy27tHAdgT704jEctsPLAK5T/0709f3eGxSnmhyNnC0EdmsnsE4NDLWZb7vkCjiZ4V/MzTd90z6hOG0hd5kzTsc0vZZzOomfWjHYsnip6zekEd52y6KbKC5EesmxKQILTK+IHrSuIUIZKlBfYiD6JB/kpJfHNepanTI0SmMQU1hdIJZ2jq3q6xNG1MiqM5IH7JuSmM8Sd8mEm/uRvEt+fYnh3r9Bj9ni1ITTFLrY16RMk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/ctAZKDnxNKey5tIBTdEXj5DWNjHLcD4ElWYXDKwfQ=;
 b=yHy2+tAJdMKC7tmqOQCNGB7DvAd7EtEh7+LDVVXdoFjDjxdj3rLopKR8UbCvdy3a785XuNDwWT81KElJbgCrWmYt8afrHQxO0N8J47btWHjesyWVk3XWZWjzGCghALs1jJ5mF5fOvBN/ctm5CkA2dRRohfWG3szMP2LYD1TSHJo=
Received: from CY4PR11MB1719.namprd11.prod.outlook.com (2603:10b6:903:2d::23)
 by CY4PR11MB1573.namprd11.prod.outlook.com (2603:10b6:910:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 16:09:15 +0000
Received: from CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::3853:8344:85aa:5537]) by CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::3853:8344:85aa:5537%5]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 16:09:15 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH] ACPICA: make acpi_protocol_lengths static
Thread-Topic: [PATCH] ACPICA: make acpi_protocol_lengths static
Thread-Index: AQHWEv87r4iBQd2ks0mDcH38j9TePqh6Whag
Date:   Wed, 15 Apr 2020 16:09:15 +0000
Message-ID: <CY4PR11MB171926DECDFC37ED7EF00623F0DB0@CY4PR11MB1719.namprd11.prod.outlook.com>
References: <20200415084933.6251-1-yanaijie@huawei.com>
In-Reply-To: <20200415084933.6251-1-yanaijie@huawei.com>
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
x-ms-office365-filtering-correlation-id: 1c0dc6ef-f556-4e9d-c5d4-08d7e1575855
x-ms-traffictypediagnostic: CY4PR11MB1573:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1573D391B3F6114C08E97CECF0DB0@CY4PR11MB1573.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(86362001)(6506007)(9686003)(478600001)(55016002)(7696005)(26005)(81156014)(110136005)(4326008)(53546011)(76116006)(66556008)(66446008)(316002)(64756008)(66476007)(33656002)(8936002)(66946007)(5660300002)(71200400001)(52536014)(2906002)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0jW/vajHaQEaU0hsCXreowLu8eJYcxMDwaxwntFDpTB+pCkJQI42yUzBKGrB/g976xXLMq1ytYUm0Y2FdWZrA46xQ2QkOYls2TbteSyrRO2MDYN6HG9wxp68HCpCjgGTLVZpEbJgxUL2LAViyo7Y1BLHeXkp9O1iEoVkqXqePoRv+GB6hyvRR3JbMR7XA04cFPhsfoKUQD3WY5W9NQkg1oCCZQQ1KxnLwBy8UlkFvXzhdKcaRsqvd68LUm9Au60GXbWeIbGtXB7cF3mpBL7R3an53xTJRr4AZuHO0o8lZqZd6VmsN5kI5951RCE2P3Agc7XIRLLTqaxAQC+103Plsmxi7Y1jyenx7jvZTxCkNsxyFCGoFlKKn0+/TMXR8EEiDnaC4fvudU+TkuXPtSOWoms5tSg4h5T+NOV/9/LE5uFuNk2BSG8xwRpWqxq2ekd
x-ms-exchange-antispam-messagedata: jw0aTJe7O5wbyeYz/URvekcMlHuUawcRS0XaJQjXfxUf74LDNKPh4eQ7ZDA0fnc7zAqAOkaxjULKEksZbBN0w64UaMDAajFWMudQUPV8CgE0J6GNxadCEKRPNonsLYt4ggpVUukYGoLtIyXUKa9g7Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0dc6ef-f556-4e9d-c5d4-08d7e1575855
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 16:09:15.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNpI1UHV93+oVDYhpWeKVeZuqC+/ZK36G86Rgz+Rw19TwQ37T8PrTw4rDnKBsBIzvxYbKg5SurdresbczRPlQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1573
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Jason Yan <yanaijie@huawei.com>
> Sent: Wednesday, April 15, 2020 1:50 AM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> lenb@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org
> Cc: Jason Yan <yanaijie@huawei.com>; Hulk Robot <hulkci@huawei.com>
> Subject: [PATCH] ACPICA: make acpi_protocol_lengths static
>=20
> Fix the following sparse warning:
>=20
> drivers/acpi/acpica/exfield.c:25:10: warning: symbol 'acpi_protocol_lengt=
hs'
> was not declared. Should it be static?

This has already been reported and I've made the appropriate fix in the ACP=
ICA code base already. it should be available in the next ACPICA release

Thanks,
Erik
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/acpi/acpica/exfield.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.=
c index
> e85eb31e5075..3323a2ba6a31 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -22,7 +22,7 @@ ACPI_MODULE_NAME("exfield")
>   */
>  #define ACPI_INVALID_PROTOCOL_ID        0x80
>  #define ACPI_MAX_PROTOCOL_ID            0x0F
> -const u8 acpi_protocol_lengths[] =3D {
> +static const u8 acpi_protocol_lengths[] =3D {
>  	ACPI_INVALID_PROTOCOL_ID,	/* 0 - reserved */
>  	ACPI_INVALID_PROTOCOL_ID,	/* 1 - reserved */
>  	0x00,			/* 2 - ATTRIB_QUICK */
> --
> 2.21.1

