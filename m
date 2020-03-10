Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6E117FFE3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Mar 2020 15:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCJOMR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Mar 2020 10:12:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36072 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgCJOMP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2020 10:12:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id g12so2008320ljj.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2020 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4QhA/j02FBxntBJRQBcss8svsZrEfLANO9BT4LL3iCU=;
        b=RcBB6uSziFObfQh7F40JgIh9KQqUgYDwVustVXGRIPKq5nbuKDZAMkThEJVGtYXtmC
         0gEjWZXupu/bjDHLhO3bDgP8Jai3e2Z2HPKRFnxW66BCqrmOGyFY/wtlV5fZsccTuwFX
         UmPKp0oCjsJDT3K7zOj3RS/DMRdaAVrCSFfZONmcFzs850WYw8P+2+yeYHC/H5QHiIXL
         yboqgrnJHVFHAaT7au0i6hkcUAemScwhj8pHIRGvNPzFrVp7jftLPaWXmWpjh0jt/Zm1
         rGUFN2EhWYkgauQQgZAh6Z8zUxIBW95qtYNbBQBZmxLOLJzh3/ledsuZMFKEOvYoTxxb
         wsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4QhA/j02FBxntBJRQBcss8svsZrEfLANO9BT4LL3iCU=;
        b=l/N2Ipi8pZSAuizvRnLlvphmEjCQxwNL1pWptrSd9GPzY1oPweK83Xjg87nOG65jTh
         mmMIULB8p8bFaudsA42JpeMg1gdPaKGOB5Aw/1hbC/3w9WT5lAd3HsWCebX7bzz49/EY
         4osBJM4HRDjivkDtg4sd5gRRPwTv1OTx+yFLAezMfye/pdkXECxDhu+y+k/hbGUGXByd
         8U6f+cnwMgCX3Nl536j3QizP4Y1iUd3B0HUfKT/UBiCRTsTAV2n+GRmqONqxMu6+6qx/
         2yqZ4K/pSL6aV49dM2BtbflnUeQ/r6IVJd3i2ygS7n0d4SYcv/0axGyUenmTCmWcNBN5
         hjjg==
X-Gm-Message-State: ANhLgQ1C9YzpEYIOTRdP3XX4MBDXMlToJb7PsK2j1GlN3ekNxO8X4emF
        gdQDka601rXuf355Dv7XKQJh4mEu9rNo/ATTY44qvg==
X-Google-Smtp-Source: ADFU+vsZjGe47Suk3ijAD4oBo8DcgUhtsIlZsoQp4eX5n+pgXggGbZV8FREk09m/qnaQ5xTBa9ZjBcN17IUu/qd8ZRc=
X-Received: by 2002:a2e:8105:: with SMTP id d5mr7218437ljg.172.1583849531956;
 Tue, 10 Mar 2020 07:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200205194804.1647-1-mst@semihalf.com> <20200206083149.GK2667@lahna.fi.intel.com>
 <CAMiGqYi2rVAc=hepkY-4S1U_3dJdbR4pOoB0f8tbBL4pzWLdxA@mail.gmail.com>
 <20200207075654.GB2667@lahna.fi.intel.com> <CAMiGqYjmd2edUezEXsX4JBSyOozzks1Pu8miPEviGsx=x59nZQ@mail.gmail.com>
 <20200210101414.GN2667@lahna.fi.intel.com>
In-Reply-To: <20200210101414.GN2667@lahna.fi.intel.com>
From:   =?UTF-8?Q?Micha=C5=82_Stanek?= <mst@semihalf.com>
Date:   Tue, 10 Mar 2020 15:12:00 +0100
Message-ID: <CAMiGqYiYp=aSgW-4ro5ceUEaB7g0XhepFg+HZgfPvtvQL9Z1jA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: Add quirk with custom translation of
 ACPI GPIO numbers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanekm@google.com,
        stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        levinale@chromium.org, andriy.shevchenko@linux.intel.com,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, rafael.j.wysocki@intel.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 10, 2020 at 11:14 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Sat, Feb 08, 2020 at 07:43:24PM +0100, Micha=C5=82 Stanek wrote:
> > > >
> > > > Hi Mika,
> > > >
> > > > The previous patches from Dmitry handled IRQ numbering, here we hav=
e a
> > > > similar issue with GPIO to pin translation - hardcoded values in FW
> > > > which do not agree with the (non-consecutive) numbering in newer
> > > > kernels.
> > >
> > > Hmm, so instead of passing GpioIo/GpioInt resources to devices the
> > > firmware uses some hard-coded Linux GPIO numbering scheme? Would you
> > > able to share the exact firmware description where this happens?
> >
> > Actually it is a GPIO offset in ACPI tables for Braswell that was
> > hardcoded in the old firmware to match the previous (consecutive)
> > Linux GPIO numbering.
>
> Can you share the ACPI tables and point me to the GPIO that is using
> Linux number?

I think this is the one:
https://chromium-review.googlesource.com/c/chromiumos/third_party/coreboot/=
%2B/286534/2/src/mainboard/google/cyan/acpi/chromeos.asl

On Kefka the sysfs GPIO number for wpsw_cur was gpio392 before the
translation change occurred in Linux.

> > > > > What GPIO(s) we are talking about and how does it show up to the =
user?
> > > >
> > > > As an example, the issue manifests itself when you run 'crossystem
> > > > wpsw_cur'. On my Kefka it incorrectly reports the value as 1 instea=
d
> > > > of 0 when the write protect screw is removed.
> > >
> > > Is it poking GPIOs directly through sysfs relying the Linux GPIO
> > > numbering (which can change and is fragile anyway)?
> >
> > I believe so, yes.
>
> This is something that should be fixed in userspace. Using global Linux
> GPIO or IRQ numbers is fragile and source of issues like this. There are
> correct ways of using GPIOs from userspace: in case of sysfs, you can
> find the base of the chip and then user relative numbering against it or
> switch to use libgpiod that does the same but uses the newer char
> device. Both cases the GPIO number are relative against the GPIO chip so
> they work even if global Linux GPIO numbering changes.

I analyzed crossystem source code and it looks like it is doing
exactly what you're saying without any hardcoded assumptions. It gets
the absolute offset of the GPIO pin from sysfs using its ACPI
identifier, then it subtracts the base offset of the GPIO bank from it
and the result is added to the bank's gpiochip%d number as it shows up
in sysfs. The result is what is used to export and read the state of
the pin.

With the newer kernel the gpiochip%d number is different so crossystem
ends up reading the wrong pin.
