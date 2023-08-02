Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B211C76C550
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Aug 2023 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjHBGcZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Aug 2023 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHBGcX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2023 02:32:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80526BA;
        Tue,  1 Aug 2023 23:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2D7FVb1WDrJ/dFHuMhlbaNu4SQ+59iXuKl04d3pbTH4n3pQOV+TZB0qwp8hBrquaPS5yrjyW3WFh7u2t5/wO1kT3bhfs7pM6CmcYvMNOPy+giN/q8wuXBaU+5o6F09Dlgd8zCBrcpCh4wB+6SJqAploVzAWEzzS3w9k6eWIUrlZUGCaPMwikZ7N1WmIcmzw91EG0Ij+bA2+Ajoh20SXphC26b4azv8UMGThNeusSdj7fIXlGi7hVw0EzNkyD3E3Stb5O2C/3KHBxbmqjIut44QfNVjEgqGtJMOuKsWj0abTD0Lb0gGJ5mlg8pgxXa0mPdnGsBrwFW4qeOMG7V/f+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yTlvP8XKQJH7SnNW2UZojRLweEiWfHOSrtgcJ0M5cM=;
 b=bzCYHzzByCUm3gvBOSH+/5bbMwfUeEFc7e68kTZChXaivz9GBQdFxZjnlDo1GuNlmwqnVrSwPbsJJuOCGEXRTvH6f9OsDn1DjwuIZUhjCS6Hl/4+woVTpQTLKWyLRjBDEDxVeSlCqvhMtYtEARB+1IfEMmxCxpKkxz5vyeCZQPdykrlavlBVyHHOxS4XNNuGk5LQaSbD+1XGRITtZwjSjGocKdW07GEFMZubsLhfolc4x4pnYH7m14qhOKkw3+qEpCbt0LaPBHDfhRnEd36sEeT859zYd4Tk1Zn9E0cFhm7QXz4tHUyvbtjhTQtVgVmlCA9E4dVV6bNGIoA7qbL7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yTlvP8XKQJH7SnNW2UZojRLweEiWfHOSrtgcJ0M5cM=;
 b=XT1eyTehFyOCnIsvMbHCLKlH0pX2hMeIRKWKExhKkbKUzZuaal4m+h26WSyb4jr/qr22lgAmm5MwBP58W4BQIJ3prSE5fM41qUj54Rs0lhNuu0eDb0d8j19hpOQjPOD3H+ZXVYsNeL3aNgaCLRx3gyn27Lw1ksc9W/j36cRVHEU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8147.jpnprd01.prod.outlook.com (2603:1096:604:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:32:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::8f98:d64b:f092:766]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::8f98:d64b:f092:766%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:32:18 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] drivers: fwnode: Extend device_get_match_data() to
 struct bus_type
Thread-Topic: [PATCH v3 1/2] drivers: fwnode: Extend device_get_match_data()
 to struct bus_type
Thread-Index: AQHZxJoZheRJ0TW3rUG1+qIPtHxE26/V1n6AgAC2I5A=
Date:   Wed, 2 Aug 2023 06:32:18 +0000
Message-ID: <OS0PR01MB592219C8BEF733C6A75DDD5C860BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230801170318.82682-1-biju.das.jz@bp.renesas.com>
 <20230801170318.82682-2-biju.das.jz@bp.renesas.com>
 <ZMlfYU3rOQle0VuH@smile.fi.intel.com>
In-Reply-To: <ZMlfYU3rOQle0VuH@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8147:EE_
x-ms-office365-filtering-correlation-id: 58a6103f-5994-49c1-b14e-08db93223880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yn3rljnZtTWisLmlx9SuZ2TrA9uCLLqzzUqeVXV7Gd85dOoCnrMTWiQ/dVzX9mJ9wcwbgnE+SgQ8IYhq+8p2gkT9CD8HQt68dc6QneTx7hKYFewUK2yFqY+WdSgWuYnr2kTsFEuFL8CE9uMQP9fuXduL+ER4lwtSn/BnYmrl648zCEu57a/BfFHZlov1osePK5P6HyIwzOUzkct1d/46AvkyOHWe0wN0c6vZhrpYlqbiwFM1iu1SA8qXEKUU3W6+XHPJL0rTjxDcmmozHj1Hc9F2w6soXRBxKuKEwkcFuFADcyZxHaujqXzbVnH5QDCywAl5xcpD8JKTJJY3H+wLyZNSixTmo34v7YHOJFbLztifnY1oX99qu+cnbMBZDaF9jMpB8Z8BKzKwYJoCY8nTS54Jw6VCuM+SFv3G8e6bQNLKgQ4PlmlBirsR/t4k3EZYfYJqM47YXsGdXUg5bQbiL4xrf3IUh/UG5BZwV9YpA745XYSOElWWwG4qQMxY/QMNWWRKL0a7WdoxA4NOE6B9885I/FmtDoxIE+R4ww689xhbZ6KoZueWXol77hDE3yBbwxXg90grZgr0MQGdnBgpQOqW/Lq7FBhB/X5spzQAd/vzXi2kFSff7SPwP1ZmHYP1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(55016003)(186003)(9686003)(316002)(86362001)(478600001)(122000001)(54906003)(38100700002)(71200400001)(76116006)(66946007)(66446008)(66556008)(66476007)(33656002)(7696005)(64756008)(4326008)(6916009)(6506007)(41300700001)(26005)(8936002)(8676002)(52536014)(5660300002)(2906002)(38070700005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EnyLBny+g/Idv0kWU/W7XEYPueC8FkwlR1Zh68MYbfNXVyHSTaIXJZnLdDdO?=
 =?us-ascii?Q?qUYFemNupiob9QbahwQpWZYz0UZz4C2yfEd5RBNW5bBe//S9qt4YPFm/GWQO?=
 =?us-ascii?Q?KW/CE4pZ19RJoeI07SfotKRnRFM+eAl4pDZU3Zrm1ekm30T0PW31hFn9A1nJ?=
 =?us-ascii?Q?Ruqk3pznI/UvxhFvEQV1Y4dmGBo5fD0JiuYiBqWJMQntqKRqQhGeRVt+pr9e?=
 =?us-ascii?Q?J64Uzi6qk01xFHUclvWQj1B2poc2JD9XY8c4PCeuSteFxWu1NRMn7r++sUhG?=
 =?us-ascii?Q?Hnp/1lZXFux5G7yM0HxfySiSHNBc8/2fvukXnM7+h4cUPFRFiZJ+wWpmxeUi?=
 =?us-ascii?Q?s3Jkcd6fO4zIFfF2SNSHN1v9dOjDSo+4u9l4QqwmPBdcUfkK2tXphyUb96PE?=
 =?us-ascii?Q?//tPYp3zzphkLllPmDs2NooJj05GRez3tSy7iW2ASFrwXnMZCuZp4mAhQY1Y?=
 =?us-ascii?Q?KtRAVUlp7qU2KPNN3RiRWeWLDyDNWxN0FG87yG0Ro+6isl/3L42KVrM+w1IO?=
 =?us-ascii?Q?0SpZdOxd3IZqu6bbd3yred5g0TR0ZZ1deRlZqCfrgGQymT19LjdKjfWos/ON?=
 =?us-ascii?Q?KimqWFuI8Ahp3KDYQ0wO8V+LdGCw1xsmE+ZRDRpRgJvcHqOEVkYsE0Dmuoh0?=
 =?us-ascii?Q?inhPidfjRGQCYo2mLZe/J04I6HJvYHTLBu3uqoO0mncrvvQXYfK+GDg4uqL1?=
 =?us-ascii?Q?QI8sq7RRFyRziu6J4pSKZaFmINiwFwkIbfOpKVseET0pthd6Mdgk6zbN156Z?=
 =?us-ascii?Q?uzVbxF1zodUquyvukKsO+Y6+crnXPaknC3GajXiXcqGx1xOHMpM4Y5DWYszZ?=
 =?us-ascii?Q?sopXWdhoFI9lWek7QnYK/ywFhy4rOfqzB9ONFEO9BWlXLOE4DzUGYB2/Nxf/?=
 =?us-ascii?Q?2Ppqkn0dtNR4KclF984Ic1lQUkTY/wHnRdPoPqm62on+hhJgDUjjY0H/YrzJ?=
 =?us-ascii?Q?YPsEXAXbSsR412LIhvTBfxYLXn7Pvv5J1/r4fYs6M6P7nq+mT3eQyV1v4Vva?=
 =?us-ascii?Q?HhY0Jtdvk8bGUZAHfgyGXuvSQdyptz/INcXA7w8awVSOmgfl5lMftsGhSaaa?=
 =?us-ascii?Q?tXdDZXlE3BvSqwAsxT0ePGXzfKw0vBKsmCVYe2Cs6x8ewSlLIQ8ZVxY2Dj9i?=
 =?us-ascii?Q?gwEaK/qLifEqkT2m9f4ndh8o/PH9GWwmdQltZdZ1K+f8Fj8oOvwJayTFKupd?=
 =?us-ascii?Q?NAZnvh1rkcED5pIZ9Zo2nOk+hib5lhle3+d8+JSwiKzKveNgLPjOrg179GVu?=
 =?us-ascii?Q?iRMsK0O4TbgC5JkIIB7ZK0rfPwwihqqR0t4usnTSx/M1ZumEinq/3jYB6G1A?=
 =?us-ascii?Q?4QqUmVjGfUzD5CxGz+ar4joOdly+TksjuMZwNkbYkhpjicDJHbzUftOxJrUC?=
 =?us-ascii?Q?cdhYplTVZDPft6LaDzR8puQrXME/GEszieIMkV7iL4oRIiR4StgvT2KQbOeh?=
 =?us-ascii?Q?iZVPmf5zARfQDLh7zPrfhYbiq9irBk5PvszOh+IepLTTo9tg6+kEBpig65DI?=
 =?us-ascii?Q?v1y5Sd308lSI7+3SK56/0pBSn+vaxiWERsns24CyAyGEDUaFUfoNKFoWrZru?=
 =?us-ascii?Q?1zRmyiD1sJop1yi26f53C0NRQMsPTXfWceZQuzEj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a6103f-5994-49c1-b14e-08db93223880
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 06:32:18.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXJUe4nMGbr4fN4VwvnEv5AZe06GEUjrCobV35HGVQLK4a2Ffyvj4z3vpjPpKoiiaYmxJkiAwzHL2FnPH3myL4xTIKYX7Z2fIv46EZDJ+PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy Shevchenko,

Thanks for the feedback.

> Subject: Re: [PATCH v3 1/2] drivers: fwnode: Extend
> device_get_match_data() to struct bus_type
>=20
> On Tue, Aug 01, 2023 at 06:03:17PM +0100, Biju Das wrote:
> > Extend device_get_match_data() to buses (for eg: I2C) by adding a
> > callback device_get_match_data() to struct bus_type() and call this
> > method as a fallback for generic fwnode based device_get_match_data().
>=20
> Because of anticipation of v4, see one additional comment below.

Ok.

> ...
>=20
> > +/**
> > + * device_get_match_data - get match data from OF/ACPI/Bus match
> > +tables
> > + * @dev: device to find the match data
> > + *
> > + * Find match data using generic fwnode-based lookup and if there is
> > +no
> > + * match, call the bus->get_match_data() for finding match data.
> > + *
> > + * Return: a match data pointer or NULL if there is no match in the
> > +matching
> > + * table.
>=20
> Also add a note for the corner case.
>=20
> """
>  *
>  * Besides the fact that some drivers abuse the device ID driver_data
> type
>  * and claim it to be integer, for the bus specific ID tables the
> driver_data
>  * may be defined as kernel_ulong_t. For these tables 0 is a valid
> response,
>  * but not for this function. It's recommended to covert those either to

Will fix the typo covert->convert

Cheers,
Biju

> avoid
>  * 0 or use a real pointer to the predefined driver data.
> """
>=20

