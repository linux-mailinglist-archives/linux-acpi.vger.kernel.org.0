Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E184411ED
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 02:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKABxG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 21:53:06 -0400
Received: from mail-bn1nam07on2075.outbound.protection.outlook.com ([40.107.212.75]:21762
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230191AbhKABxG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 31 Oct 2021 21:53:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z49kYI92aSF0fyVgYgbDQbn35O9gKmqy8Lz0yeg5krb1o7+Ko60fmAOobGchaUHpM97XeasMe/CfPs5aa2wTbWXiqJqZvJS33oa8rPKUw+qFiBvt2szFKqNtwhKhPqKymam5zFS8B4tsGTtNAAv07ZQMn0IuiqSjtgJ5YOoD0/K7Z7hXl3rO/D7MzOLOtvxQ6EyuPEKcsDH5ll4uyAsN9aCqz1y6ROllxib8XQaVkagV4mcOS2MKe3g4rXvkYpDcOrnp8tuaMYQW+Lk/iUwZIMJ5d0CCgpPUOHiI+aME0CW0Q5FzdWZQkIdcZA3yn5Zkb6hf+YbSbQZYcU+I10VfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftOMHOS7b8VwdSr8PP4ZIcXaBk5L9aPW0UDaagNmkDI=;
 b=P5advLJBsboJ1fzkFY1mbN4Md/ydj8WCoMhUJfdPxOeBxek7s1a9uvZVwF4zmsJH3TPX1DOjbpvyOX1ut7+MRXLWUCF5bAD5oohbjhQ0AFjAiH4aOLyWd4ZDXo04mkOgatNsE6Zp3trF62+Jn8AdYG2CE77CrvSTEnNRH1oXnDpNd7so2QaUGiErHBqSgCCKTdc58+DJF2I43YH+RG7oFtsj26YfLqKHAAI/hcrz6RPXOiwe8wZWrFOJRyqsLyu//Xly+R00tpAN8ljp3GHcW7WYiRLBsITCKky2/UFa1aX0J3cE4wZubwnARm+u6rgd/6d6UPE99uwoG34EqPnixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftOMHOS7b8VwdSr8PP4ZIcXaBk5L9aPW0UDaagNmkDI=;
 b=uAwwKphQE8OgZ4u51xPvAa8W4sqIuHPlCYW90FOeS68DWxetfsQExVGQqht40llniy0QZcQCtJUD0v9nCAjQojAxrAD59x3hcyjqiK07JdE2ZTKVR1nUD589gj0eoWzyce91CnGyADoDX8TR61qUEKCM5H4QQpV/VmtudEvKHus=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Mon, 1 Nov
 2021 01:50:29 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 01:50:29 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "stable@kernel.org" <stable@kernel.org>,
        Joerie de Gram <j.de.gram@gmail.com>
Subject: RE: [PATCH v6 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with
 SCI
Thread-Topic: [PATCH v6 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with
 SCI
Thread-Index: AQHXzQU6PqIy3vKAS0udqGjDwYZVsKvtGKEAgADSoKA=
Date:   Mon, 1 Nov 2021 01:50:29 +0000
Message-ID: <SA0PR12MB45104B9765BF4C693A5B2D7EE28A9@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211029204017.8223-1-mario.limonciello@amd.com>
 <20211029204017.8223-2-mario.limonciello@amd.com>
 <CAHp75VfOBBpt84aQYGOW32kKqeNH5gZUbJtqf1sPP7O-ZZkW+g@mail.gmail.com>
In-Reply-To: <CAHp75VfOBBpt84aQYGOW32kKqeNH5gZUbJtqf1sPP7O-ZZkW+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-01T01:50:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7d085191-5026-4a6d-aa80-34531d9b5eac;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af14589f-ae33-49bf-dca9-08d99cd9fbb5
x-ms-traffictypediagnostic: SN6PR12MB2685:
x-microsoft-antispam-prvs: <SN6PR12MB2685B272DFDF9414A2586DC5E28A9@SN6PR12MB2685.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Su0P/aqUb2NJo7tXJF3BwlyYUIcgaRv+GL1XdfeoLbKn4qM1y8lxtKKDC8fqVgXlRI0aC+5IkqPvNy27BL6wq9INQ1+CC6dTRAlzAUWylQiGDqeyKciYop+FCrc99Xol/LzhzNe6MMB9X1iM07aIJGeuGeHN4IoqhaS6Pmv5shuN7X3+1wdVHp2fcm04AKuPTwvRpytr9uAQbWf4WpcsKXynH9MrWcQfaQPnTLuGjeO2p+RXGfALVj4T4b9enWyDCi9TS2ZWnYZzQjCTK9h7sBMxCSHClXhz6T+TUA0dIRFyKlUyBp6xtO6+xjWO4433qujciV7bpl12htRzvFlLSGZ0BWe2WcGU0x93xuLfrlVpsgkRdLxXsb5tBIo/LICso7QbuwWQ4Fqi2cYhmwnbJtoiKUzm9zPnGaD8aoLrHzGggNSOw9oLsyreU6NjwYoB0yJ3P1pFJfpJ9PXw9Mr8rtCPJAVfdjawlUUVmblGoZ5BIHy8gOZFkuYbs6atmUbunf9uCh9XVEyxQzbbweYrQom3TwgAnUlYb1lxJnVQp9I/HOWR7a29fXHaI/P8CxdjIOUF/yKt4C5MW6kA1i3wtNu8NzdKwLaoxrBTU5cmG2nFgFtzQ+hIJXC+a6BVZ2Ot9NDebOHsJQDKFURrQCVsRJRmRmlvUsNUNibqTLBoduNV5bzUNfm0Q05Qfx9HmPylwGlT4N4BWT+H9uIdAb7Uklyer8OJ34B6VWFAtrrr5kxJgMsCNtMqalSVtfr/+4dvxjsF9tR3MpvL2um5R9bm28lp/QWU+gqW4DHIgxQpDLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(9686003)(122000001)(8936002)(71200400001)(76116006)(54906003)(55016002)(316002)(8676002)(53546011)(83380400001)(6506007)(38100700002)(4326008)(508600001)(38070700005)(186003)(2906002)(66446008)(6916009)(5660300002)(45080400002)(64756008)(966005)(66946007)(7696005)(52536014)(33656002)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ubSz5Szy7hrJ9sMRv0Y7wlWFe4SCJxccGayMacmA22OwHgUIqUDu0/tYbkVi?=
 =?us-ascii?Q?/BYdkXguLpJ7xb3BR7DC8rRAbfTVOG+dEErqWJYngqGUGa4qqh0eZFxfSrGO?=
 =?us-ascii?Q?SkzE6ekTBbcpIDJ0JrkXu0j7GkJGFjHcCPARj04JWP6PAl9CYuQX8RQkli85?=
 =?us-ascii?Q?/QPFRbbLV3bsaOjGChQ8DH/aSJWSJrJzeNzcyDhTP1bBsv5uP1mjx4K16vI1?=
 =?us-ascii?Q?MxCs8mMLUegSdHmeDGOjoztoxwB6B4m+PmqdTi6IQIJSBybAG+obqRwRjpX/?=
 =?us-ascii?Q?P/38/CATInrZyz4t5wRmArqt8zFJ/PN4yrVtjRNfRHtW4AFYRWzTHo3jE0hL?=
 =?us-ascii?Q?ajmH4J/bucHCkt2NmDj3xI3Aqin4J/QQWRtZzgl8ObFheWyzO0eyDGOyPWdn?=
 =?us-ascii?Q?/X67Gz6UhzJisezz3RsxTcMlD8o4Yf4B4lsK75C2brZ8hdyX2EIBDCwbBdCg?=
 =?us-ascii?Q?gPncjRgWvCkyhjmMuSP9uKKp8QIzC4s+CzsaHlqc7b2jNHXVqrtQOnA7e7v0?=
 =?us-ascii?Q?wxDETd1bHSCM0CvMl4ucICsIam6fhaqwBwTzeSFtMDKxPZMe6QzkzJH3NJSN?=
 =?us-ascii?Q?RqjGVyrBVQUD+uhdvijGy7wJX0YlyMuxpA6kxga25LgE0f54hqte0TiXm7c6?=
 =?us-ascii?Q?Ov92gbG55VFbd5uc47G+rfiTrwopmtXDWO0pc9nCcBKZpAtMiQsi/9Y6bZvI?=
 =?us-ascii?Q?tfmG8q+fFEeqy+sHZmUOMGSGUI3KxYEssubzZ8WxNvxjpH8HgZ4f6Up8bqJp?=
 =?us-ascii?Q?NjzKTfdQUsFa73nuMfjJ5UOmTBO4ryrJuN89bAtg56SeUNOoVBAcUgCYC6+n?=
 =?us-ascii?Q?2iJbvnXpMstxqjWI+GSDpsb/494pQEVnF9YVWE/a42NHoz+WcaH4Xxsyt1ln?=
 =?us-ascii?Q?g6N4k6oC++6ypnAzcWHhZvMiM59T5unbeX1SKF2FDaG3Kx47SL9Rvx5oAk7N?=
 =?us-ascii?Q?PFwmyYF8sOfBbC265TFtEkQjPn4Afk5GRI3W6r4j3BoU5jJLv/avUgfTZlbn?=
 =?us-ascii?Q?olPQAw2DRMPg+wBZZKflc8BKOOKO5GkHplX2w4HKsf/Ii4WQEf0/XXPnHQ6q?=
 =?us-ascii?Q?XTlEauLbUDbbFj/03kZReklXMAmCE2HOEDfC40Iq1340CDFJi5ycwORh/Uqm?=
 =?us-ascii?Q?LnS/qgvaHq7jj/J7NGyc0cTWj2Z9fFcgIKe6vMxtfI75a3xV9q1AdwWo1qKm?=
 =?us-ascii?Q?cWB/H8pi6i/4OA8W44OrtY4TLUV3Dv5+3+aqp7c2I6MAqNJAZ7kilN4iYNUo?=
 =?us-ascii?Q?dbWgmheIEM38kYJvPx0joLnEeMvVYxPMN5CtJojSka8UuFGw8rt6TPnmAGBj?=
 =?us-ascii?Q?I/5YGpYczaWywrRhhuaEuLfyL0tHBko0Q4Ix0nCnuS9kI9UFQiysRwh2NjkB?=
 =?us-ascii?Q?r8+jVSu/rSABhhuynLpbqSnwjl4dUuOMbdEHRvrwWihjaAUq2a4fSuykV8fc?=
 =?us-ascii?Q?ugqmb1SOayzjrp7uONCLXgFUsXvLQV2WQM7jbwV8MqIkSlclmjHI24t+tD2W?=
 =?us-ascii?Q?2xreoNxmR4IcG1Vn9Y3w22V2kOy7THiUSSE+MQ5PCnboy6zs9mkDwVpe2YK0?=
 =?us-ascii?Q?lCQMmUJpL44PVXGNJNMqyXhTvXWYsW+f8Mun2zqFl9ICOEhsyxCApiRTA6PF?=
 =?us-ascii?Q?G3D04PS0eZ463uho6LWrbllir/UBrCZJiX2BQfLbbqlt8/3nr4uoRNxJILW4?=
 =?us-ascii?Q?3PNp/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af14589f-ae33-49bf-dca9-08d99cd9fbb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 01:50:29.2888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9wpk8VUdy38fIyrmIglxMo4OapUEjizFsmlJhcnRbNnNFpuT/1FbYmn+eBnV5Q4VcdtI4y0cSsJNdK78fO9HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Public]

> -----Original Message-----
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Sent: Sunday, October 31, 2021 08:15
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Natikar, Basavaraj
> <Basavaraj.Natikar@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; open list:PIN CONTROL SUBSYSTEM <linux-
> gpio@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>; ACPI Dev=
el
> Maling List <linux-acpi@vger.kernel.org>; Shah, Nehal-bakulchandra <Nehal=
-
> bakulchandra.Shah@amd.com>; stable@kernel.org; Joerie de Gram
> <j.de.gram@gmail.com>
> Subject: Re: [PATCH v6 2/2] pinctrl: amd: Fix wakeups when IRQ is shared =
with
> SCI
>=20
> On Fri, Oct 29, 2021 at 11:42 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > On some Lenovo AMD Gen2 platforms the IRQ for the SCI and pinctrl drive=
rs
> > are shared.  Due to how the s2idle loop handling works, this case needs
> > an extra explicit check whether the interrupt was caused by SCI or by
> > the GPIO controller.
> >
> > To fix this rework the existing IRQ handler function to function as a
> > checker and an IRQ handler depending on the calling arguments.
> >
> > Cc: stable@kernel.org
> > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1738&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7
> C8962eb61c66843248eff08d99c708f19%7C3dd8961fe4884e608e11a82d994e18
> 3d%7C0%7C0%7C637712829517705057%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=3D57LKx3moIAVwtjmncHiqDMgvYP5tkEL7JuAP76iaCHI%3D&amp;re
> served=3D0
> > Reported-by: Joerie de Gram <j.de.gram@gmail.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>=20
> ...
>=20
> > +static bool _amd_gpio_irq_handler(int irq, void *dev_id)
>=20
> I know Linus does not like leading _* in the function names, what
> about 'do_' instead?
>=20
> ...
>=20
> > +                       /* called from resume context on a shared IRQ, =
just
> > +                        * checking wake source.
> > +                        */
>=20
> Is this comment aligned with the style used elsewhere in the driver code?
>=20
> ...
>=20
> > +                               dev_dbg(&gpio_dev->pdev->dev,
> > +                                       "Waking due to GPIO %ld: 0x%x",
> > +                                       (long)(regs + i - ((u32 __iomem=
 *)gpio_dev->base)),
> regval);
>=20
> Oy vey, these castings are ugly. The rule of thumb is that if one does
> such a thing for printf() it means something is really wrong (in 99%
> of the cases).
>=20
> AFAICS you may simply use 'irqnr + i' as the other message does.
>=20

Andy,

Appreciate your comments.  You're correct.  I've sent a follow up addressin=
g them.

> ...
>=20
> >         platform_set_drvdata(pdev, gpio_dev);
> > +       acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake=
,
> gpio_dev);
> >
> >         dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
> >         return ret;
> > @@ -1021,6 +1045,7 @@ static int amd_gpio_remove(struct platform_device
> *pdev)
> >         gpio_dev =3D platform_get_drvdata(pdev);
> >
> >         gpiochip_remove(&gpio_dev->gc);
> > +       acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
>=20
> Thinking about making this in the generic GPIO library code, but this
> is out of scope of the patch...

Sure, we can think about this if/when there ends up being another consumer =
of it.

>=20
> --
> With Best Regards,
> Andy Shevchenko
