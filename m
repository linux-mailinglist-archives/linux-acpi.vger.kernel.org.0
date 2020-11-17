Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B32B5E82
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKQLlZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 06:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgKQLlY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 06:41:24 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1859C0613CF;
        Tue, 17 Nov 2020 03:41:24 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id r6so306061pjd.1;
        Tue, 17 Nov 2020 03:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i67jZxq1bxJVzrVrFFPgj4tGhq93qfE3EuR+ysQTuuE=;
        b=NyDJXNc/DMF57Ph+9/wMhZlhCUDz+y4kBDFewLrzDPLYVw90QGbZeX5jXTK0Y5IlSj
         gNsuRx+mLZOnlumT+OxHSG4IjObbWI1gNZ9MsqTzD92SHL+sdrwZKgQMm6aZkGly+hp7
         o8QUzR8yyeja6vbsGfNQZ1IxBoIL9HZ7DQqfHZQVcgF2j49CLzb+i3KPq9ozYgUZDqYm
         z6Lx0OeF7zPF5O2Qs+ozUgyxjAINhYC4A9W+fFuNl0CTKHjRtZwsEHDAbr45BvliIvit
         y54B8Gck9uIZXryUpNBWsAxA105V+J0t8LanCL/v99XLtOBfeHrpEofpax21Y9SdxUo1
         mEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i67jZxq1bxJVzrVrFFPgj4tGhq93qfE3EuR+ysQTuuE=;
        b=foIGI4MwviJIpjNDa71xjoYCIaQCDo6byu5e+FjaILyjXcev13/ov78OM3pwVsGq0T
         0khQPXzGy8Gtq6DHzXMjW60oNHSQ3m5rOutO+gwiy+RY+Qct8bXUJ94OLl+pgo5RHpLx
         v67lU7n2/884FBhdq6q+8sr9qOS8HCN92oGj31/QQy+t1q5dTT5pAFjetfOSZFf/JzBh
         qLW9o3rYjj6UvYCUTB6eFbauL/JT22ZLRATOrQzHkfTdFVwe9pPb8UkjyJBfvjadylzA
         affOshmVBUF8xjbCgYZBU/ALwTValhU2lP2QieMap86UqseHwQ6F59zNqUexqJHW1oe2
         hfNg==
X-Gm-Message-State: AOAM531jy9ZbrZgOPHwub+ISHLo0QRP1dwurSFS+0PQ6Jft8r3YenNFs
        2wjDhl6beLF0QsaWWO71fhp6icLFukJzYbY4G5U=
X-Google-Smtp-Source: ABdhPJxMElgPEOmFU/GilWUwdNkn4ZwfYJ9tp2Nm5HomYNiavhXx40GcDeZ7Maq+BhjwR9iktjTfh3Fn6azmjswAR6M=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr2367465pjv.129.1605613284239;
 Tue, 17 Nov 2020 03:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20201112130734.331094-1-ch@denx.de> <20201112130734.331094-3-ch@denx.de>
 <20201116144631.GB1689012@smile.fi.intel.com> <20201116163024.74c767b6@md1za8fc.ad001.siemens.net>
 <AM0PR10MB3169089EF445E785C363A0B4E7E20@AM0PR10MB3169.EURPRD10.PROD.OUTLOOK.COM>
 <CAHp75Vdxj0tgn6P8Nfi5mMd=e9Q1+hzt4bquzB93zg0vOeMopw@mail.gmail.com>
In-Reply-To: <CAHp75Vdxj0tgn6P8Nfi5mMd=e9Q1+hzt4bquzB93zg0vOeMopw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Nov 2020 13:41:08 +0200
Message-ID: <CAHp75VfkHgaaFUN9Nw4sVVsLxzky0=-dAgAmmG+EkF8xV7Na5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rtc: rx6110: add ACPI bindings to I2C
To:     "johannes-hahn@siemens.com" <johannes-hahn@siemens.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Simon Glass <sjg@chromium.org>,
        Simon Glass <sjg@google.com>
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

+Cc: Simon

Simon, this is an issue with ACPI IDs and I think JFYI would be an
interesting topic since this may happen in the future in U-Boot or
other projects. Also, you may know people from coreboot to figure out
what to do with this case and how to prevent something similar from
happening in the future.

On Tue, Nov 17, 2020 at 1:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Nov 17, 2020 at 11:51 AM johannes-hahn@siemens.com
> <johannes-hahn@siemens.com> wrote:
> >
> > Hello Val,
> >
> > my name is Johannes Hahn from Siemens AG in Germany.
> > Our product Open Controller II (OCII)[1] uses the Realtime Clock RX6110=
SA from SEIKO EPSON.
>
> Nice to hear from you!
>
> > Currently there is a merge request ongoing for the Linux Kernel master =
branch[2] which adds I=C2=B2C and ACPI support to your original driver impl=
ementation.
> >
> > Simultaneously there is an already merged patch-set for coreboot[3] ava=
ilable creating the ACPI (SSDT) table entries for the RX6110SA.
>
> Thanks for pointers, I commented there. The ACPI ID change must be revert=
ed!
>
> > The OCII uses coreboot for firmware initialization.
> >
> > During the merge request the eligible objection arose that the ACPI ID =
used in the Linux driver patch is not conforming the ACPI Specification.
> > Indeed it does not. But when searching for a  product identifier of RX6=
110SA I was not able to find a sufficient one with respect to the ACPI Spec=
ification (see [4] chapter 6.1.5 _HID (Hardware ID),[5]).
>
> Unfortunately many vendors, even being registered in the ACPI/PNP
> registry, are still neglecting the process.
>
> > According to the fact that there are other Linux RTC drivers on the Ker=
nel mainline[6] which support ACPI matching that also do not have ACPI Spec=
ification compatible IDs we used that as an example for our first patch att=
empt.
>
> I answered this in previous mail.
>
> > A PNP ID for SEIKO EPSON is already registered at UEFI database[7].
> >
> > What I kindly ask your for is an ACPI Specification conforming Product =
Identifier for the RX6110SA RTC ?
> > According to [5] this Product Identifier should be "... always four-cha=
racter hexadecimal numbers (0-9 and A-F)".
> >
> > In case you do not know it our can not acquire/create one could you ple=
ase redirect me to someone from SEIKO EPSON who can help me with that deman=
d ?
>
> So, to be on the constructive page (I thought initially you are from G
> company, but anyway) you may do the following:
>
> - (for prototyping only) you may use the PRP0001 approach, described in [=
8]
> - you may issue an ID under your (Siemens) vendor ID
> - you may insist G company to issue the ID under their vendor space
> (thru coreboot)
> - (the best option) to communicate to Seiko Epson to get official ID
> from them for this component (and ID mustn't abuse 6.1.5)
>
> Unfortunately I have no contacts there, but I think the best effort is
> to contact their support and at the same time ask ASWG [9] how to
> proceed. I Cc'ed this to ACPI people in Linux kernel, maybe they can
> help.
>
> Of course you have choice to push bad ID forward and use precedence
> (like many other companies, even Intel in past, do with firmwares and
> Linux kernel is full of badly formed IDs), but since the change is not
> existed in read devices I would really like to see proper process to
> be followed.
>
> In the Linux kernel I'm in principle trying to prevent bad IDs from
> happening as much as I can.
>
> > [1]: (https://mall.industry.siemens.com/mall/en/WW/Catalog/Product/6ES7=
677-2DB42-0GB0)
> > [2]: https://lkml.org/lkml/2020/11/12/561
> > [3]: https://review.coreboot.org/c/coreboot/+/47235
> > [4]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan3=
0.pdf
> > [5]: https://www.uefi.org/PNP_ACPI_Registry
> > [6]: https://elixir.bootlin.com/linux/latest/source/drivers/rtc/rtc-ds1=
307.c#L1142
> > [7]: https://www.uefi.org/PNP_ID_List?search=3DSEIKO+EPSON
>
> [8]: https://elixir.bootlin.com/linux/latest/source/Documentation/firmwar=
e-guide/acpi/enumeration.rst
> [9]: https://www.uefi.org/workinggroups
>
> > > Before adding new ACPI ID, can you provide an evidence (either from
> > > vendor of the component, or a real snapshot of DSDT from device on
> > > market) that this is real ID?
> > >
> > > Before that happens, NAK.
> > >
> > > P.S. Seems to me that this is kinda cargo cult patch because proposed
> > > ID is against ACPI and PNP registry and ACPI specification.
> >
> > In fact we pushed it in coreboot and Linux at the same time.
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Frev=
iew.coreboot.org%2Fc%2Fcoreboot%2F%2B%2F47235&amp;data=3D04%7C01%7Cjohannes=
-hahn%40siemens.com%7C21c9e1fe99274df7951a08d88a448af5%7C38ae3bcd95794fd4ad=
dab42e1495d55a%7C1%7C0%7C637411374276831534%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D7EVdO%2F77LNyvux0y3m9nEf2HZO%2BDm2WkWMfxzaJUoto%3D&amp;reserved=3D0
> >
> > That is the evidence. But in case this is wrong we can probably still c=
hange coreboot, even though the patches have been merged there already.
> >
> > Maybe you can go into detail where you see the violations and maybe eve=
n suggest fixes that come to mind.
>
> --
> With Best Regards,
> Andy Shevchenko



--=20
With Best Regards,
Andy Shevchenko
