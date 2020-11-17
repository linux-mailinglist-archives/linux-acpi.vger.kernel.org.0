Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E192B5E6F
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKQLdk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 06:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbgKQLdk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 06:33:40 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C43C0613CF;
        Tue, 17 Nov 2020 03:33:39 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so10091737plo.0;
        Tue, 17 Nov 2020 03:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D+OKJ+4fv/qJ7XgTFRASaeF6lYZ3wO/Nm8qIoQpWUGs=;
        b=dG6wD1KoAWEe9+WWXcsI+25PehGSrjHFFzj5S3wZaH30zNdkKVRXFLwrGbfaGMAu3E
         jAgrBCHZyAzP9OM6tamN94fmEKy4gGS36RM8W/MJ6qsDhVBSL+PaHsISME+zOPXiMsQt
         TGA/vGq0UFO7ZkFOqow3ZmPONyz3oDaeK8I3xxAz+4kbkM56fl6OVi9sD0aMP8uLZIkF
         fd37tiKW0b34ESfeEMASp4Jfw+6oRge1TjlHqI8DEAbFuS8Ww+grGd0FVk8c7mxOXBGa
         UxYe886Gb331ApGiXiVJRZSivmm1AfoWZ0Ub9QPUu/RvjthlUcVyli9N5i6sHlHmH94e
         PLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D+OKJ+4fv/qJ7XgTFRASaeF6lYZ3wO/Nm8qIoQpWUGs=;
        b=l4XaGTK9+T0fMMeFpVyylI7XD4FH0uituIFT6x/tiWXvAWotfAUwmCE/sa1Po6g6IS
         1GM/WrCr70Bv+t4YcycZquHq7waNHp6JlISfj+T5OWfywYjpzG/o42imlnEMxKUWpQ/y
         Nd82Ye5kS1ocKMhZkvsgl0w3V1cPNfp2QKrch8iOtndIDjBenfA2GCUFXWNd3Yl0R3EO
         kMhS5fFXS6jTfFyNYRPtnSV45UbxhbPkr13OuRoMosLwyukepxvGjBU3fp6XwgITdoDC
         tt2P8DDfbVv6237nLM+j3mhLGrowRmpdyMtqOeSKAJa/6H7H1NA0bg77Mo6AvH61lT4/
         w8xQ==
X-Gm-Message-State: AOAM532iXc4EIs/soqjRNXnciS0N08+T4NqknezT+CDKapDImEqy9zXk
        jYwQKO6adPTS/qup0AFwzXv/Uu3qPuraVUdH/lM=
X-Google-Smtp-Source: ABdhPJxHkLW9Tae3mVz2iF/cvEv2iOo+XTBU2AKTv+V8ttoooptwYZL9ewQnyP9rBUpxiWDgvzHNDZU4kJLwQNsdPJ8=
X-Received: by 2002:a17:90a:9f8e:: with SMTP id o14mr4019653pjp.181.1605612819486;
 Tue, 17 Nov 2020 03:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20201112130734.331094-1-ch@denx.de> <20201112130734.331094-3-ch@denx.de>
 <20201116144631.GB1689012@smile.fi.intel.com> <20201116163024.74c767b6@md1za8fc.ad001.siemens.net>
 <AM0PR10MB3169089EF445E785C363A0B4E7E20@AM0PR10MB3169.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM0PR10MB3169089EF445E785C363A0B4E7E20@AM0PR10MB3169.EURPRD10.PROD.OUTLOOK.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Nov 2020 13:33:23 +0200
Message-ID: <CAHp75Vdxj0tgn6P8Nfi5mMd=e9Q1+hzt4bquzB93zg0vOeMopw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rtc: rx6110: add ACPI bindings to I2C
To:     "johannes-hahn@siemens.com" <johannes-hahn@siemens.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>
Cc:     "val.krutov@erd.epson.com" <val.krutov@erd.epson.com>,
        Claudius Heine <ch@denx.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "werner.zeh@siemens.com" <werner.zeh@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "martin.mantel@siemens.com" <martin.mantel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 17, 2020 at 11:51 AM johannes-hahn@siemens.com
<johannes-hahn@siemens.com> wrote:
>
> Hello Val,
>
> my name is Johannes Hahn from Siemens AG in Germany.
> Our product Open Controller II (OCII)[1] uses the Realtime Clock RX6110SA=
 from SEIKO EPSON.

Nice to hear from you!

> Currently there is a merge request ongoing for the Linux Kernel master br=
anch[2] which adds I=C2=B2C and ACPI support to your original driver implem=
entation.
>
> Simultaneously there is an already merged patch-set for coreboot[3] avail=
able creating the ACPI (SSDT) table entries for the RX6110SA.

Thanks for pointers, I commented there. The ACPI ID change must be reverted=
!

> The OCII uses coreboot for firmware initialization.
>
> During the merge request the eligible objection arose that the ACPI ID us=
ed in the Linux driver patch is not conforming the ACPI Specification.
> Indeed it does not. But when searching for a  product identifier of RX611=
0SA I was not able to find a sufficient one with respect to the ACPI Specif=
ication (see [4] chapter 6.1.5 _HID (Hardware ID),[5]).

Unfortunately many vendors, even being registered in the ACPI/PNP
registry, are still neglecting the process.

> According to the fact that there are other Linux RTC drivers on the Kerne=
l mainline[6] which support ACPI matching that also do not have ACPI Specif=
ication compatible IDs we used that as an example for our first patch attem=
pt.

I answered this in previous mail.

> A PNP ID for SEIKO EPSON is already registered at UEFI database[7].
>
> What I kindly ask your for is an ACPI Specification conforming Product Id=
entifier for the RX6110SA RTC ?
> According to [5] this Product Identifier should be "... always four-chara=
cter hexadecimal numbers (0-9 and A-F)".
>
> In case you do not know it our can not acquire/create one could you pleas=
e redirect me to someone from SEIKO EPSON who can help me with that demand =
?

So, to be on the constructive page (I thought initially you are from G
company, but anyway) you may do the following:

- (for prototyping only) you may use the PRP0001 approach, described in [8]
- you may issue an ID under your (Siemens) vendor ID
- you may insist G company to issue the ID under their vendor space
(thru coreboot)
- (the best option) to communicate to Seiko Epson to get official ID
from them for this component (and ID mustn't abuse 6.1.5)

Unfortunately I have no contacts there, but I think the best effort is
to contact their support and at the same time ask ASWG [9] how to
proceed. I Cc'ed this to ACPI people in Linux kernel, maybe they can
help.

Of course you have choice to push bad ID forward and use precedence
(like many other companies, even Intel in past, do with firmwares and
Linux kernel is full of badly formed IDs), but since the change is not
existed in read devices I would really like to see proper process to
be followed.

In the Linux kernel I'm in principle trying to prevent bad IDs from
happening as much as I can.

> [1]: (https://mall.industry.siemens.com/mall/en/WW/Catalog/Product/6ES767=
7-2DB42-0GB0)
> [2]: https://lkml.org/lkml/2020/11/12/561
> [3]: https://review.coreboot.org/c/coreboot/+/47235
> [4]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.=
pdf
> [5]: https://www.uefi.org/PNP_ACPI_Registry
> [6]: https://elixir.bootlin.com/linux/latest/source/drivers/rtc/rtc-ds130=
7.c#L1142
> [7]: https://www.uefi.org/PNP_ID_List?search=3DSEIKO+EPSON

[8]: https://elixir.bootlin.com/linux/latest/source/Documentation/firmware-=
guide/acpi/enumeration.rst
[9]: https://www.uefi.org/workinggroups

> > Before adding new ACPI ID, can you provide an evidence (either from
> > vendor of the component, or a real snapshot of DSDT from device on
> > market) that this is real ID?
> >
> > Before that happens, NAK.
> >
> > P.S. Seems to me that this is kinda cargo cult patch because proposed
> > ID is against ACPI and PNP registry and ACPI specification.
>
> In fact we pushed it in coreboot and Linux at the same time.
>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Frevie=
w.coreboot.org%2Fc%2Fcoreboot%2F%2B%2F47235&amp;data=3D04%7C01%7Cjohannes-h=
ahn%40siemens.com%7C21c9e1fe99274df7951a08d88a448af5%7C38ae3bcd95794fd4adda=
b42e1495d55a%7C1%7C0%7C637411374276831534%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D7EVdO%2F77LNyvux0y3m9nEf2HZO%2BDm2WkWMfxzaJUoto%3D&amp;reserved=3D0
>
> That is the evidence. But in case this is wrong we can probably still cha=
nge coreboot, even though the patches have been merged there already.
>
> Maybe you can go into detail where you see the violations and maybe even =
suggest fixes that come to mind.

--=20
With Best Regards,
Andy Shevchenko
