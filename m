Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF1176E7FB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjHCMNO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjHCMNN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 08:13:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB0E2D69;
        Thu,  3 Aug 2023 05:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr2ji8lKW7jquLCOyvz/C7k1LSXHDxH3KQK6qOx//2mbtTqJiuxR+21JRJMQBbo1ClUgSjXweZUvUtcmcWxy60WPLGuOHRSbXwg1tJWWq4dCZ0skOJD0eKsayI5HCCD31AseV6s+L3oAmstIWjaflJmAqGYti/t0LrMbGNk63WUTP6N/PVrUvgQ0N3JM9H485k+2/22FWwFUR2EmLud1Lf6cxNdt5SZ4Q3ljg8VXz63rSHZ1+J3JrqUFI5eiZqiUNKOX8CD6c0NmHXNvafsUW2sa+pmQEA7j0kQPXyG7fZeUacqs542AZgsdSwGGz9JF4a8KeSwzwBdFuJV5DBWOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MYWI+KZ6sWAYb1/rcGh9CCs2CZVc3qsZJ31TW24T68=;
 b=n6BsMv+ygnMHfbCy/mK8owkUu5XFaTQJJkKPW4U8YNgV5LYMxks7kMetPRPzkDURV33SySnlackSWzE/qNgipcWVv0zppCBwvljlPvcvHgb9IJ/MtjcrehyXSne/AzfCD8QF5ulO871wxEoDdxwlNqSBZXuTnzV9GqlfqVZmYI2CMB/t4t2nlU1Y+ZNH1EBR7f6A4pR6PCVuOuRarDghXEDOSNO+FlfmI8mnMhKV8qm3RgwHGfSW5MxdA47dvxwm1zM/Ks32arLbjn5v6DeLfCd5Xy+eiX1g9QFFgwUbVnp+uakyV+Ely0Wwyitw30pKXND5HP96Tgzh2AAY070VNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MYWI+KZ6sWAYb1/rcGh9CCs2CZVc3qsZJ31TW24T68=;
 b=iScnkRMJx81PnmqjICQK5RALHVQV4jcuo9mi7f4sL59cUsXXJuxSkcEQuDb/xnM8nQh7hvviXWZsURWrCGmEQ2s8uVFJN+GAxeUfJQfKTux+jMiOwqL7I1R1Z7pjpeqSiorjNorkmbHT9Wi0HOYQIP6O/+WP7la9eFgSloliUMk=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYCPR01MB10763.jpnprd01.prod.outlook.com (2603:1096:400:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 12:13:04 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::f5b0:8a:38cb:1fb1]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::f5b0:8a:38cb:1fb1%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 12:13:03 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>
CC:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
 device_get_match_data() to struct bus_type
Thread-Topic: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
 device_get_match_data() to struct bus_type
Thread-Index: AQHZxfWh25Fey95/EESgT9jk1HOAb6/YeD6AgAAAtwCAAADwkA==
Date:   Thu, 3 Aug 2023 12:13:03 +0000
Message-ID: <TYCPR01MB5933E4FACD51163009E9E5998608A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230803103102.323987-1-biju.das.jz@bp.renesas.com>
 <20230803103102.323987-2-biju.das.jz@bp.renesas.com>
 <ZMuW18rgUBd0mY4i@smile.fi.intel.com> <ZMuXcABGfDCjbaVJ@kekkonen.localdomain>
In-Reply-To: <ZMuXcABGfDCjbaVJ@kekkonen.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYCPR01MB10763:EE_
x-ms-office365-filtering-correlation-id: 4983f7a2-f340-4ce6-c01c-08db941afd06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xC9nGlQD5LNHP17nWICe4oHxZLBGGoRCjbau5kB62tvd+6wCw/Ejdypr4t/MS2WV+cOCtJvjGj3UhmNztciexlD4ccHFtxEAi1u+IDMeO3nMbWONr4qbn3xkMZ9LoPFm7uygGqyZhccpUoWh/jL2HYtOs+Q4+kkYG/XRNbWhAXru/67ouHxZ0vVf+rFKKCfUKjsNeC437yyoVUKzNS6KT4TRhPiKE/fxV4l/zBsz5KnGMOh41r4HIzqSvzcLkpWLVXfoqkCgvmK7p7FHLcR8UhlesF2OrYFlV6LbNgi6bXNNADO0LCRcQd+shQgxK8+VnSkoJrCcSE8fCHN2Qvn8jcRvObSmxae6JMA0Aloz6r6GNoynKki6uLzrpZ/txxy+RD0RUt8P89yASRfZ/LoxrXlapv0w5hevx0k7hhErSjdCLxKGTSUFdNIxBQwUGOadBUphcEfyHJKOZ+bqLGpzI3VFYKgn3eDtf/U/8q+teQhiosQzDnlGotLeV5i1sec2SW0+tXNiDN1az66cILQr8a1Xm3xY9CItwqGRFdCLq7U0q/CiSPdUWTfYsRvWizJWi4CA3nJsCWa+0N6/lw4ywAi/OmYZMgfudRyyrA/mV2Uz9cvUubbYZC2AY5jAwsca
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(110136005)(54906003)(5660300002)(52536014)(8936002)(8676002)(7416002)(122000001)(9686003)(316002)(4326008)(38100700002)(66946007)(64756008)(66446008)(66556008)(33656002)(6506007)(41300700001)(26005)(186003)(76116006)(7696005)(71200400001)(86362001)(38070700005)(478600001)(55016003)(66476007)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NqcPb4iVpoIuMzeira18kXya2abcL9btkzyW1FMk8YsewL4ThlEnjfn23f9P?=
 =?us-ascii?Q?HCmzRkBgvApQ+AUl1RTbwfkSxXYDE/YHldZ0IuEScnv/xkXkEwHGD9NPOoqz?=
 =?us-ascii?Q?2sLToY3jir8rJ5SdIl6erjn+Ad9whGwRKqWfyeZu1W64yFin4m/W3ye6Mvl0?=
 =?us-ascii?Q?DA/0CRX5lRB0qEKryv3suxj3rEy+IudLKEU82oyOn5oA59jB683Ie/uUy/NK?=
 =?us-ascii?Q?vTZBmW6ZW3g7/EXUiVIU7Ca3mYsumvBWujf4cQ+GvG9sA+n4FMMhdM0sD1EX?=
 =?us-ascii?Q?N78FEjvJl+NBWCqi5txFWH1Bm56r6uuQijGRbShJwxDVJifnQ2xP2ltisLf/?=
 =?us-ascii?Q?/gaq9l1aTee296uF4y4hknXdfP55uyZCHtrme9CtpNxo0g4B1l4kNuBDcaKV?=
 =?us-ascii?Q?eC55C2Vx5ZqgbhnnH2q6IclLRkXWS0CxggMSCNR+LwuqYeK7GZ0k2pR4ng+u?=
 =?us-ascii?Q?+gju6QDQGx1goyvgIYd1nnpU4Et2ET/bjRCEHVdS41CGeOGRklHM0lcKFeOM?=
 =?us-ascii?Q?P/gqjONQmSAFfVyKC4vyr7E2USFjDSgiecbdeVV62UWGOZPA+IXJNcMoI0NB?=
 =?us-ascii?Q?VDUPNuhgYpljofolsvtj32vR2aMHfNsGC+K3KfBjffvELE0zpbWkdDbQkUn8?=
 =?us-ascii?Q?28ULrr16LCbg7LZcEV/IUn+/3vTZ260zoZu08/rQK8njLNlc1GMFZyxgtbTh?=
 =?us-ascii?Q?oVoAlM8UV96YLEciSBvHMWDq2mm9Koct8Utz/WqdmU35rG4jQkcmcCIVfYGl?=
 =?us-ascii?Q?PISdGbSHcXhIEUJ3AcGU38+IcojasVtAi/WWerbK2j6efQx40wLXlsKABi4j?=
 =?us-ascii?Q?7w0og+UjphvcGramANlnEHqTfChvlTJ2DdyIw9hSORjcmiDZ9Vd8ERqKQ8rI?=
 =?us-ascii?Q?sjlNgXffRy2BemLXjDjwhNx8I6vHSa+0LnPMpwpp/tIgLTTiWjMqb4d3Odmu?=
 =?us-ascii?Q?3fGaaToTItZk+aocbCBoOF1xJ0qtQ4z/evKYBu+FVbtRuBtcWzTj7P8DsB4Y?=
 =?us-ascii?Q?uWPzlOLACuKzMy+CgrpTCGMsSFEe6h46287D1zs2MCAPWhsrWI5JLq080wsL?=
 =?us-ascii?Q?OCEOlINnHywmp3TVAdGcQBK1Us1LZ1z70BOotkYDDMTbOOBgb4HvC/+tQQFn?=
 =?us-ascii?Q?uGJu2IL+h7m+nfHfjNhk0m+W5L0TD1oaYLpq3TlRslvLeWrRahbXDefEiNop?=
 =?us-ascii?Q?ErEmsOTN6CE16W4oeeyAZLAtqaJkxWUm5y1k1XXKE4Ef0PEM/gCbSuooeEsL?=
 =?us-ascii?Q?As/DVduimxB4fGfjhmk+vKlC1M+MiW04TECUOBkFZ8g3rBlzAm0frDbG+p4s?=
 =?us-ascii?Q?p8/xkMp8+FD2/vmiBr1pMO/v2+MCwUX8RFu7od0mMLnNPfn70z1fTKwqOJqD?=
 =?us-ascii?Q?pcNXGWUZFuMTmcfRMUcenVQ2mDgsSB9nT3MXGfBAC3zpIzYK/fMiVCF+OrXj?=
 =?us-ascii?Q?K8DnXjJRdxGekHnwsvK6ZQM8G3cfloR/QCrSlN8a1biynMkcjOvpq/WvKht5?=
 =?us-ascii?Q?nadx3fwQT7PP62fsdqU49PvLblE71VdWTQKc0G96oDbvfLmLUdc8rwVYkKMD?=
 =?us-ascii?Q?xhXmUTLqMu2uGSwVGD7ILhSfUx60LxP/hyVrNJjMdr784H3wtrE6QiJtwI/3?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4983f7a2-f340-4ce6-c01c-08db941afd06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 12:13:03.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzFjS8eopmXfxsS+JOrlv0vYokwjtdYUcvgu0zRxoX8LPdz0ddUGmvAtKyTLWUAbHP5WzgdG7WuxpRuMhqCQ2t02gbG6GL67ZdF5Goq+wOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10763
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

> Subject: Re: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
> device_get_match_data() to struct bus_type
>=20
> On Thu, Aug 03, 2023 at 03:00:23PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 03, 2023 at 11:30:59AM +0100, Biju Das wrote:
> > > Extend device_get_match_data() to buses (for eg: I2C) by adding a
> > > callback device_get_match_data() to struct bus_type() and call this
> > > method as a fallback for generic fwnode based
> device_get_match_data().
> >
> > With this resend you were too fast to forgot Sakari's tag...
>=20
> I guess it arrived after the patches were resent?

I send v5 and v5 resent, then got Rb tag from you.

OK, will add Rb tag in v6.

Cheers,
Biju
