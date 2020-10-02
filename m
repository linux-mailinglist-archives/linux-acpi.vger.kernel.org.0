Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353C8281320
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgJBMsi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMsi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 08:48:38 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE7C0613D0;
        Fri,  2 Oct 2020 05:48:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u24so726176pgi.1;
        Fri, 02 Oct 2020 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAIUPEHTeHS2U3+oSG9KsAR+ktrkLYIx+qWMYCIy9n4=;
        b=pDiADnxeBlW00Qq4p1x38xVCA2IAxrvhBBqq7PjoGlfS/UW4KbPrm2PZ0NiRlWxYtK
         asEOblO5qJLuHcyicxrc3tQSf/ovxhKsy+cWV7F9CzeZrD9RaAc4HKNUn0jZmbU62L/V
         byWKtx6C+lzEAN7NV8FeGnkYCQGDvZRkxqufVjJWOaV6Sq5zALqbcSZHwI8dnmp+DaXe
         1rO1ZD2jfieTrLyLmV79xOoasLTcyoQxYT2qmUYFRS7H8twXyzdxNU2W3X6vlmK0kcke
         Wt9UrSZQJgFrUZLpDwjagpEsmOf55b2XMzGUrdxGToM6WQJ4jiZ25YOohO59PATj/grF
         dD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAIUPEHTeHS2U3+oSG9KsAR+ktrkLYIx+qWMYCIy9n4=;
        b=N6gmZzRnRRV33B2Y8tq/ROGIl49sir7nwpfj5PRrSlYtHJEYebB4sbhQLrOAK6TFwP
         w8KBZ9CBj1y24HaSyhAuJdClaiCBiWUKeJaHBvhgBpPCWU05AQnEuy+gntLQpq3Kd+ht
         pwmcQoNQuDJhA2btW0mm058T8KU9EaUNgmZaf+3DUYdthsD9L1HFM/vKUrAJAHAIJz4k
         8P2OsgYylD2MfwON+I3MXK/f9ANqkvxbgiDCbrW8KcPxSzhL0wclNxl2Fy57kWPPlu+/
         Joz0ZJ5g25Y0/FvkYAV8YScA7dRVhbzi2kT27f2IwMokW16caf/76Jdc9PmnF1AAG/vI
         heZg==
X-Gm-Message-State: AOAM531gjuUfL21ep1CGbTH1wGABe/EXduYDaACMl1bixRh3JPY+qCB2
        /fy2d2mqlsyPxU2ihlICMRBtku6Rk9Fw7aLGf7U=
X-Google-Smtp-Source: ABdhPJyQ2uudnQNegCeg41YZTs74edYoNeI0AADnzK8v5X5z2sm/0vQAll9kw4Rj6kU4iPDUTgkOZlowdc+7HS+MhDY=
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr2069434pga.203.1601642917546;
 Fri, 02 Oct 2020 05:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it> <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it> <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it> <20200930130113.GQ3956970@smile.fi.intel.com>
 <2c26adae711145639d0b982a354aff3c@asem.it> <CAHp75Vcq1WOcMNoKpOSpCD1mFSyvYsaX-h7KHTaAOPe=6S4e0A@mail.gmail.com>
 <CAHp75Vdm9K7nGxsk8P_iGy4m=vi=95zpH1S4NuJbb7bekwZoXg@mail.gmail.com> <757023db21e642a3a4b6d33428c191cc@asem.it>
In-Reply-To: <757023db21e642a3a4b6d33428c191cc@asem.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Oct 2020 15:48:18 +0300
Message-ID: <CAHp75Vf-hJ78LmXF8PqOeF-CfWEYqYzMiGCEGaEfnMqxmtiwiw@mail.gmail.com>
Subject: Re: How to use an ACPI declared GPIO in a userspace ...
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 2, 2020 at 1:02 PM Flavio Suligoi <f.suligoi@asem.it> wrote:

> > > > My SSDT table is:
> > >
> > > ^^^^ See the difference? I can't help here.
>
> This is the DSDT table related to the GPIO controller of my board:
>
> Device (GPO1)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
>             Name (_HID, "INT3452")  // _HID: Hardware ID
>             Name (_CID, "INT3452")  // _CID: Compatible ID
>             Name (_DDN, "General Purpose Input/Output (GPIO) Controller - Northwest")  // _DDN: DOS Device Name
>             Name (_UID, 0x02)  // _UID: Unique ID
>             Name (RBUF, ResourceTemplate ()
>             {
>                 Memory32Fixed (ReadWrite,
>                     0x00000000,         // Address Base
>                     0x00004000,         // Address Length
>                     _Y08)
>                 Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
>                 {
>                     0x0000000E,
>                 }
>             })
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 CreateDWordField (RBUF, \_SB.GPO1._Y08._BAS, B0BA)  // _BAS: Base Address
>                 CreateDWordField (RBUF, \_SB.GPO1._Y08._LEN, B0LN)  // _LEN: Length
>                 B0BA = GP1A /* \GP1A */
>                 B0LN = GP1L /* \GP1L */
>                 Return (RBUF) /* \_SB_.GPO1.RBUF */
>             }
>
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 If ((OSYS < 0x07DC))
>                 {
>                     Return (Zero)
>                 }
>
>                 Return (0x0F)
>             }
>         }

So, what about adding the following

DefinitionBlock ("linename.aml", "SSDT", 5, "", "LINENAME", 1)
{
  External (_SB_.GPO1, DeviceObj)
  Scope (\_SB.GPO1)
  {
      Name (_DSD, Package () {
          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package () {
              Package () {
                  "gpio-line-names",
                  Package () {
                      "Line0",
                      "Line1",
                      "Line2",
                      ...
                  }
              },
          }
      })
  }
}

?

(Replace '...' with meaningful line names or drop for now, but in any
case you need to provide as much names as lines of such GPIO
controller)

-- 
With Best Regards,
Andy Shevchenko
