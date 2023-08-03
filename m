Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0380776E7D1
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjHCMG6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 08:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHCMG5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 08:06:57 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9172D72;
        Thu,  3 Aug 2023 05:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFSzw88PCI8xrG7Q0w+qAzqCjKS2n/e5P9ZVctOWYmZGdxEcISNq1/rgMZn2cvS62EJh8jbC/9PKgUQyjyG9RvsciqOhKscM8wj338hf2qMz/pSV5FIbKDMKGO7Aescm1CzCCskWk/7UawrG2UL0brkDTPXvPW1g6VPzA01m4gFoQpn3dR450+MbyKhmmCiMReOGx+1v0tabXmo02XMgeGbVm+nRg7M7JvCA8NsFI29oU78YhVoyiynHb3Z56DX5QrbPnwX3skWbPfnf8GsE+l6UUS5gi/SEcxCxNBMzvPuam4AW8St97NqAYNibSoWPzye/kioj96mA+uIXjiNiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljyCIzAjHXZ025qKVdOl4UiPdc3G3Hqj1u3pRnCvv4s=;
 b=i0TAKm3FPVK+peTsqeqNq/cLumxVTIJr4/sxeWroDUZkeDMdHt57w4wigJPbh2+oOQZcWL65LDvvR3w5AS+cHYPOBjwpN3CGSAC4Pn8qr3I0ky3MecVKlJYo70aJBCDjyarGcQQB8VvDwQ3MOSKIPV7sZwctDBYGnvlJUpzuXutKBkwq/wKuo2y10OKGunwNoL5YvlR+wJAIUZ8HFvUmTM433giCLWLhp+9c6J1UaYdrjOicF9Ulrb2VhK6+dxBuPsHb6CQbKCc4+PR3z4GF5AuWjnRr8IKGBsLdW43hwh36NPpvQbwHxvKhos+x8FndW0keWZs514uMg/UxduUyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljyCIzAjHXZ025qKVdOl4UiPdc3G3Hqj1u3pRnCvv4s=;
 b=JHt0rdqmkljqJFQz7t1yhVafiym6wrVBJGYhnJizXIvTLiNQfXRoDnCqJ6EzmHt0Z4X+9q+TeZcsdQp6hfYnK00glQkvG4FbfF7OyCBVBzuOOLCaXmgK5UlMsg6LeEaGck0/VNCC/tEOkzmgGmDDcns3c+WEzl23FoKle3llm4k=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYCPR01MB6045.jpnprd01.prod.outlook.com (2603:1096:400:48::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 12:05:58 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::f5b0:8a:38cb:1fb1]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::f5b0:8a:38cb:1fb1%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 12:05:58 +0000
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
Subject: RE: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
 device_get_match_data() to struct bus_type
Thread-Topic: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
 device_get_match_data() to struct bus_type
Thread-Index: AQHZxfWh25Fey95/EESgT9jk1HOAb6/YeD6AgAABBFA=
Date:   Thu, 3 Aug 2023 12:05:58 +0000
Message-ID: <TYCPR01MB593382D6915A0D4297483B6F8608A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230803103102.323987-1-biju.das.jz@bp.renesas.com>
 <20230803103102.323987-2-biju.das.jz@bp.renesas.com>
 <ZMuW18rgUBd0mY4i@smile.fi.intel.com>
In-Reply-To: <ZMuW18rgUBd0mY4i@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYCPR01MB6045:EE_
x-ms-office365-filtering-correlation-id: 8339fc04-aa78-4723-68aa-08db9419ff42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKGlkh0diCAje6mqHHTcdAoz5+UaoEebIDVLNBMl2BIyptdOFr+s1dMRTyK0COB0aQ4LDYMw9L2aoLfQioolH1l//mwqbC2OsVp1LZLzkH+7F7Pr5h2LWLURlKDEuTnUquqlIjIoOZ/BP4jVuByjpcmee1Am0/U4rZ+Zn2y9jf9vTy4Tjlznv1I1o0gVNOxM/lu0fMKRp6manM8T4sCK6vYkOfvdenzyrfuV9Gt6ayblxwgRtlqG0UhA7gtxNncMiscAaQKAJV+6RqGyqDAMieccBese+hC/nEKnyyMDBseXir66bsyd/omYNN1RpIGfRIFgXl/FTVYqmWymqm+j/C2MxT323PDoj6zOHMtJMT61wfd9ydMEesZyuU+WERLngbVU0b1cfl7b1l6LhsgMp6dHYtw5J2h9a304TI+8uEgZv0T8P4f3xQspzqcqPQxjDcQHgtopJuKWpBeLDyWBvl8yhilVlNO+mspcpO1fOIH8uYDwY8MXBUZNN0DqBQDKoFId/vWD0Z88ju+7numcMK2VFfB8ohFPApwE1KHfzGMOKWe+KKzFxQKbz0wkiQgOESmL7bpVcg5o1yILg/3jveMBXgYIPcUT3aGvBuv8ut8y/rWNt2hBdUXjsdEbZQu5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(38070700005)(86362001)(33656002)(54906003)(478600001)(55016003)(38100700002)(122000001)(6506007)(186003)(26005)(83380400001)(8676002)(8936002)(41300700001)(52536014)(9686003)(71200400001)(7696005)(6916009)(316002)(4744005)(66446008)(66476007)(66556008)(5660300002)(4326008)(7416002)(64756008)(66946007)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XdGEGmyLu2CqXo//d9gJuIvJO/efOo4ZEHwqNdd+nrbnUGbXdJEB6joWnDA7?=
 =?us-ascii?Q?VrkRFLEkUd4HzRlS5mtLoscc/fLDWdlPE3f+1UHwaA6NCpRdqmjotkpf2bL+?=
 =?us-ascii?Q?0b45nqFAy+zWqdbr20AJ9QLXy6xNxkZ7s7M8rJs16LPfDjii+ssXQO091fpQ?=
 =?us-ascii?Q?FKwfUhsTd0xj3H63Xt+abZUBkKQrCoOmckF8FksAqp0XovEffycTi/UJmX4b?=
 =?us-ascii?Q?bKcUTtSErwT9RbxGmZ+7glvq+BCT2Ad2MQ0nlbgED6K5RXDvAdOfbCTNtqQr?=
 =?us-ascii?Q?MMcUnSzh5p3spXBzL35f3q4tem6uKFjiNPs0LxJtj8vw2hV0MSv7/IqfP3Xr?=
 =?us-ascii?Q?bLuR6TzoIAtw1eiZCvWiAn2W4Rqu8WWcvnkwrJrPXqWJ3/C544uORiXaJQy5?=
 =?us-ascii?Q?LPaD+eK8jD6a9CBf6zIQw6gaMXsBM1C17JJeHNm49kiLhQLr78F87KWN6v/M?=
 =?us-ascii?Q?sXCqgAI3lX/fn92CjUV5vR8tkASGI7r9vSACZ7z+doH/Jxv8YBpoMw5xaDM1?=
 =?us-ascii?Q?pKicw3rH2XjilyD7tffUWk9qfwCqVAkRXlpDYvDsASlzwgCjk+gC7VVF1X3U?=
 =?us-ascii?Q?oSojxFuKsGMxQWbJkv23k7PyWT/gt2YiTncHZQyIDYo0uS4rrwe8HOEJeg0K?=
 =?us-ascii?Q?laFvPQaQwUa7mToqp85LiVoZjuScG1ZBYKy8TZOTmeYTUF2QRJxIQ/RBE4uG?=
 =?us-ascii?Q?jE1IB539YnliJApqiCqK8jxX/2Kbt9vFNh+69GN/pbciSZHMfY8G76PxzCQt?=
 =?us-ascii?Q?UUVmzhHWekpjt9gtY6+qu/w/cYo/PFQllfNLva5cIk4xL3Ndo12kcs3z6wWf?=
 =?us-ascii?Q?2i0iaypUU5zBnN1cJfeTYzim6hcdelE731Zuh83YqwbRV0ONtV3lXWFsQk9D?=
 =?us-ascii?Q?SiiHxuxTDcKvre5Xmg0P8xzFggKrOQagYkoMa+sOYG0fpXiDEr3dZ+4i9OSY?=
 =?us-ascii?Q?46/yI5rK42CJzfyEUkA22SmSE8XmB0xkEAqI26lugiBRPS01j0m5E9DACRga?=
 =?us-ascii?Q?ru12DNGhZ5+2/WL0U0dfyLKLr7haYOiuAlbfPow0E+XwpJ8nb9/BbfhWg/lu?=
 =?us-ascii?Q?+SCBKl1auv1euxY0YYAhcwlG5RpEkghHRhL0rnl4T7ch+4p7SK2QkN9sy4O9?=
 =?us-ascii?Q?U5KHf+ygCdthGaW1gaJB4sP6NrzJ2GbniddDCcGYXWhV23dT8cK9UcQvbAHq?=
 =?us-ascii?Q?8WEIWp5ljs5AWtWeYzXy4aWAg6IEC/JtsIAGjXSr6N7AjOJD94hyIZ0WbAs4?=
 =?us-ascii?Q?rhVZs/2zPiyo0rPj+MR1UUYotLcI7RuVmYsPlywyY5A5mnFsQAcYcrORAWtn?=
 =?us-ascii?Q?gW1KAGGnCz0hOATr2Kcp45aWMXdYAIiSnJgr29mUSQbCYjovUBkBm21N+3kl?=
 =?us-ascii?Q?OQqB5e7YRBNEjeUGYVVhHJRDJERKeCH1W9d3wGEZITmiNCf0MgBxHRz9pPGH?=
 =?us-ascii?Q?F4YMB0am8Qv9koR9uc+PPgY4PGNj+Kg5dqn4iixU51X3ZWSVEj97QvNbVLle?=
 =?us-ascii?Q?mI2tcSfIHLtTbCA+ECJl503dFenldWPGnmj08oO2FYLQDQzREQ+eTOqmKHPx?=
 =?us-ascii?Q?As/jGQ/dYB2ft9EU1Vy7t/wqG5fiAzJ1FpEn91bknvFd+Gx9gJzrMhQiWap7?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8339fc04-aa78-4723-68aa-08db9419ff42
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 12:05:58.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pgG2ZrAFfq7hguDYtRSyWC0mn1ZdEMpmpgwDLkyTlbY/lWnatcXNxpWZvt6+YjwW739XPzN8ktgW0f+kDmVVUOv0uq9QNHA+u5AC71yqog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy Shevchenko,

Thanks for the feedback.

> Subject: Re: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
> device_get_match_data() to struct bus_type
>=20
> On Thu, Aug 03, 2023 at 11:30:59AM +0100, Biju Das wrote:
> > Extend device_get_match_data() to buses (for eg: I2C) by adding a
> > callback device_get_match_data() to struct bus_type() and call this
> > method as a fallback for generic fwnode based device_get_match_data().
>=20
> With this resend you were too fast to forgot Sakari's tag...

In my mailbox, I received Sakari's tag after sending RESEND patch series.
It may be some race situation with mailboxes.

Cheers,
Biju
