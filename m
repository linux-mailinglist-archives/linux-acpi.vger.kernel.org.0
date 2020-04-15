Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F81A9299
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Apr 2020 07:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393387AbgDOFmT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Apr 2020 01:42:19 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:11841
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393375AbgDOFmI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Apr 2020 01:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/gOcLP/oX1CBUuVs4GvY9SJ7XSS9+fqQVTV7bNCHEEUdBZa7TjksrReZLSjHXiA42gmbExoUr2VAjBMwZkuZbkNZKvL01ZB6+VLIeWrmY4sCozbZAjdzw0vm/Vi/aR0/xHjhK15Q5sptry/DJorAi44kSSYi2qBZmNE+iSS7HwqLBuBzu4G+Yf6+Q30+j9CyCHJi3mWMA7XralM48uEIKcbrG4tcdzzKZflTL/hY9jqij5+ANPgXg3JWN6Pw1vbH0I924hl8EhCA78inCYTAq9Wvbz5LhfS6jptQivtYX+Cb4lP+MO0hNILE9qGhvz2bUiYspsuRmv/Zaqpodx72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0eNH+pEvYe/+GlVjfV1rCCEPIL8VshkRzKjGGFtTB0=;
 b=LTw1meZlhZZ8UrZ0Qd5MmOLCXbH2u2Y260iphROH5rL0o9JBp5euejrNTtHrGh/xo22YXBJjhP6znc5IpUQ8BgwvPNvh2Tv+Wzkb8hpBsjPebzXgW1e0hlWTO/NJREXlqSWTCW6paRsYER8M9velfciS82PC7O+P4z1jYoltIkGjsfQX5IU/rERCxG+S+OnJTkd3FrGrsc5zc3aCOUjh/Nqj54RDZ5x8eh9j3N/l0mjSExpiphxO1dyS87J12RmnBiY03IrpRDO7o852VoETOjkYHFQEvlad3q6+iRR28V9AkujepPtynt2g3mYRxvvXqVL/YcKmCBajMAXSMPbYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0eNH+pEvYe/+GlVjfV1rCCEPIL8VshkRzKjGGFtTB0=;
 b=h9eQhQfqKj3C/FB/C/luvUDqyx3m+S+zx9gNJjcePMujX3hGHkQVJOy3DAV2iPpHNgPZHxJDxMXtuhJtheQYynk2QlymFt+SQJ9axpbj8F0fPCBdjg3Yrm1DfQ9/vZeSJBCOr+W4ZT6QFBNpxd1vGtmRp8zSN1/KtDcP9ZLXYzM=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (2603:10a6:10:13::25)
 by DB7PR04MB4057.eurprd04.prod.outlook.com (2603:10a6:5:25::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 05:42:03 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::4a9:a633:614e:e055]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::4a9:a633:614e:e055%5]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 05:42:03 +0000
From:   Makarand Pawagi <makarand.pawagi@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "jon@solid-run.com" <jon@solid-run.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Calvin Johnson <calvin.johnson@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        "Stuart.Yoder@arm.com" <Stuart.Yoder@arm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
Subject: RE: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Thread-Topic: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Thread-Index: AQHWAsVH5evd3VqgDk+6ugY0rVkdjah4zWyAgAD9FYA=
Date:   Wed, 15 Apr 2020 05:42:03 +0000
Message-ID: <DB7PR04MB4986A8A3427DBA096628D6FBEBDB0@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
 <20200414143211.GA14905@red-moon.cambridge.arm.com>
In-Reply-To: <20200414143211.GA14905@red-moon.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=makarand.pawagi@nxp.com; 
x-originating-ip: [122.169.134.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42b0c87f-85c5-436a-cfb4-08d7e0ffb9dd
x-ms-traffictypediagnostic: DB7PR04MB4057:|DB7PR04MB4057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4057B72548E64CB8D1B08638EBDB0@DB7PR04MB4057.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4986.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(6636002)(316002)(71200400001)(76116006)(66556008)(186003)(110136005)(54906003)(66446008)(26005)(81156014)(64756008)(8676002)(66946007)(7416002)(66476007)(8936002)(478600001)(53546011)(6506007)(7696005)(5660300002)(2906002)(9686003)(44832011)(52536014)(33656002)(55016002)(4326008)(86362001)(142923001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TQrQfh26atmHTzytQmw12OsrfHV2W2h6LPsz/3fTOGSvF0qoQuuoFFGUg+yFP2UuUaSeuWF3XemnoF1aL5huFjQm9GagfA97JuKTjLHyJ5A8ajdXEGm7B/pFBrHjELLvwWNJMN1HLsPQUNz9Wxosm71Q+sWPyAQCg7h5U5LOlGGq19+lq0wWnb9BJkRrWr86EErTstovYTcSa3mBk2Uty0rExVZ4LxR0/CtOnnoSFyWx5s7+cNEgRlhMLTj/gndxqZAG5zykqsEDxGn0Fsf88NtejZu36NkpHJE0hiYzPtXSliuQXrkMTi1At9BBv+dcO347SI4dgiiFydMWhWmeGPLyFMmTHHl+BVilfPWLMj3Gpa2TUGtvYBeXZHOXxcA2KQ0ay1NjfV6dWIrylkWU1kZv8o0rWTqD9bYgYqVLvibU6mKVlGC4CuON6KtKhRz5802zU9fwLZqkdAdy2mMXePouitWfRsv8OPEfyEfU6hM9GkxHgrbS8ILcghCXhzcc
x-ms-exchange-antispam-messagedata: pDGs8M8DYm38XC0DA1EHDcfc3JDxkGpd7nn6VfgtGRn986uDed1lqTnpAl2DKbcqtAFEtOxR4wenLO8j4gwRrqPGVLAbsITTeVXPzz8rm4e0myVIrlGtIrKzf6l68JdFoEDhqUkZUWlkAOgL/DnEKg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b0c87f-85c5-436a-cfb4-08d7e0ffb9dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 05:42:03.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCQVlYyuUu5aGleQ4XT4N8or98o6FoAkEBRWafGO7jY49+y7V0Jn9p/x00Rxv6465zhHDNSAx2oa34T6lE49rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4057
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Tuesday, April 14, 2020 8:02 PM
> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org; linux=
-arm-
> kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> robin.murphy@arm.com; ard.biesheuvel@linaro.org; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Diana Madalina Craciun (OSS)
> <diana.craciun@oss.nxp.com>; maz@kernel.org; jon@solid-run.com; Pankaj
> Bansal <pankaj.bansal@nxp.com>; Makarand Pawagi
> <makarand.pawagi@nxp.com>; Calvin Johnson <calvin.johnson@nxp.com>;
> Varun Sethi <V.Sethi@nxp.com>; Cristi Sovaiala <cristian.sovaiala@nxp.com=
>;
> Stuart.Yoder@arm.com; jeremy.linton@arm.com; joro@8bytes.org;
> tglx@linutronix.de; jason@lakedaemon.net
> Subject: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
> implementation
>=20
> Caution: EXT Email
>=20
> On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
> > Hi Lorenzo,
> >
> > On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
> > > On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wro=
te:
> > >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > >>
> > >> The devices on this bus are not discovered by way of device tree
> > >> but by queries to the firmware. It makes little sense to trick the
> > >> generic of layer into thinking that these devices are of related so
> > >> that we can get our dma configuration. Instead of doing that, add
> > >> our custom dma configuration implementation.
> > >>
> > >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > >> ---
> > >>  drivers/bus/fsl-mc/fsl-mc-bus.c | 31
> > >> ++++++++++++++++++++++++++++++-
> > >>  1 file changed, 30 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > >> b/drivers/bus/fsl-mc/fsl-mc-bus.c index 36eb25f82c8e..eafaa0e0b906
> > >> 100644
> > >> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > >> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > >> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device
> > >> *dev, struct kobj_uevent_env *env)  static int
> > >> fsl_mc_dma_configure(struct device *dev)  {
> > >>    struct device *dma_dev =3D dev;
> > >> +  struct iommu_fwspec *fwspec;
> > >> +  const struct iommu_ops *iommu_ops;  struct fsl_mc_device *mc_dev
> > >> + =3D to_fsl_mc_device(dev);  int ret;
> > >> +  u32 icid;
> > >>
> > >>    while (dev_is_fsl_mc(dma_dev))
> > >>            dma_dev =3D dma_dev->parent;
> > >>
> > >> -  return of_dma_configure(dev, dma_dev->of_node, 0);
> > >> +  fwspec =3D dev_iommu_fwspec_get(dma_dev);  if (!fwspec)
> > >> +          return -ENODEV;
> > >> +  iommu_ops =3D iommu_ops_from_fwnode(fwspec->iommu_fwnode);
> > >> +  if (!iommu_ops)
> > >> +          return -ENODEV;
> > >> +
> > >> +  ret =3D iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
> > >> + if (ret)
> > >> +          return ret;
> > >> +
> > >> +  icid =3D mc_dev->icid;
> > >> +  ret =3D iommu_fwspec_add_ids(dev, &icid, 1);
> > >
> > > I see. So with this patch we would use the MC named component only
> > > to retrieve the iommu_ops
> >
> > Right. I'd also add that the implementation tries to follow the
> > existing standard .dma_configure implementations, e.g.
> > of_dma_configure + of_iommu_configure. I'd also note that similarly to
> > the ACPI case, this MC FW device is probed as a platform device in the
> > DT scenario, binding here [1].
> > A similar approach is used for the retrieval of the msi irq domain,
> > see following patch.
> >
> > > - the streamid are injected directly here bypassing OF/IORT bindings
> translations altogether.
> >
> > Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
> > the smmu driver to do some processing on the raw streamid coming from
> > the firmware. I have not yet tested this with ACPI but expect it to
> > work, however, it's debatable how valid is this approach in the
> > context of ACPI.
>=20
> Actually, what I think you need is of_map_rid() (and an IORT equivalent, =
that I
> am going to write - generalizing iort_msi_map_rid()).
>=20

That would help.

> Would that be enough to enable IORT "normal" mappings in the MC bus named
> components ?
>=20

But still the question remain unanswered that how we are going to represent=
 MC? As Platform device with single ID mapping flag?

> Thanks,
> Lorenzo
