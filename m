Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC947242E67
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Aug 2020 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHLSHR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Aug 2020 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHLSHQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Aug 2020 14:07:16 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5225FC061383
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2020 11:07:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l13so1437526qvt.10
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2020 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FPM/BpxL7oHk5NwDUOl9GJEl4QuvKvovtaLxj5QbinM=;
        b=dPPr77PPopJMkB3J1yt/ankUvINgjFbRtn7AMXcoTxgOv4Qnz8BmX18CGvnpDoNboC
         RdBfGamTp+ItJYrXQOhA+ATgJhrWxC7oZXQM5Q3E+IC333XHrA35Xgpiz1g1+eCk0g5J
         LHWdw0LwJi+FdGosEZll1xe5ub1affO7TItKtEmD4+bYgbMaujsZ0HkQBmx7hCRhE7gs
         ASP2oWwiikGuPIVN/TUiCMTWTtuyO/dChqvWVOrNOEVrbSokdAWF52h4N0xNIypYkucn
         Kw88wjXP6RrYAG/5c+SbZ7RH91UXZN+awliP03byg6ZCTl62qFsjos/SZlDNZZuljdig
         wIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FPM/BpxL7oHk5NwDUOl9GJEl4QuvKvovtaLxj5QbinM=;
        b=QhcaZhlU5IvDYsXEDASAc2u66mqvIiJD6puY8CPpJo5p/48nLrptmI5JX1cpc+HNd5
         pjwWj8amPxEo0g/3DkWt5YFoI3Qb0U3c4iYFpn/ZRQA9P3ye/1/tBDxlwE8qZ5QOm9C5
         FhReiwpcLMj0zfLm4ftNbg5NU8r9gfjTJ6w0vAFp5FkLASCY72UcWJQ0bswh/vZCvlbt
         7J9Rl3xl+Kyj8gwsiI5Eu7BTiKG1rB3wmiHXoidRwivnm0N+CY6LSJOKtQe/3Wwt2uQr
         QNcSBc1OEzAHoj3VXdVT4PnvwMbqvqjCWX4dNOPheWt/ZXeUE3CpXGtztB+GIyKLQMoH
         e3lg==
X-Gm-Message-State: AOAM530zptGa5+WgFsOjByXFX9DmhTM+dkzzn/XzoHeKF/sPTVDpZ10M
        vOaM31rRRYdBtyePy+gTuvVt4G2kEwxiZjB8S67D1A==
X-Google-Smtp-Source: ABdhPJxwuOgASIUMO9V8WJQloS5aDiVFEuzmNpHSIUm1BABcVUPU19igC0hVjhfl43zEzpgsO5DYTci6isBiqyb/YV4=
X-Received: by 2002:ad4:5502:: with SMTP id az2mr839333qvb.148.1597255635563;
 Wed, 12 Aug 2020 11:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200121134157.20396-1-sakari.ailus@linux.intel.com>
 <20200121134157.20396-6-sakari.ailus@linux.intel.com> <CAMpxmJU5dG49N2FA0oSQsOfKrCr3KQ1BisON4c+nUJJmZQG=bQ@mail.gmail.com>
 <20200311085555.GH5379@paasikivi.fi.intel.com> <CAMpxmJVPTKW+sYSJ3dnfF8nLAOKEa4Ob7bpxG0KD3Tkdm+rtYw@mail.gmail.com>
 <20200323213101.GB21174@kekkonen.localdomain> <CAMpxmJVdyTkZMVuhSy0Ux8VUYTmQN_YEfH-akQsAL3zrwiz8Dw@mail.gmail.com>
 <20200810082549.GD840@valkosipuli.retiisi.org.uk> <CAMpxmJUKSR-oCGnV1E5XiAMA2nYBy5f_f8=VSoMn0zf+qF39vg@mail.gmail.com>
 <20200811080009.GE840@valkosipuli.retiisi.org.uk>
In-Reply-To: <20200811080009.GE840@valkosipuli.retiisi.org.uk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 Aug 2020 20:07:04 +0200
Message-ID: <CAMpxmJWziqW-PiJPSm6aH5aXbYktMJfVjJfvfGxv8fdbWKydqg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org,
        Bingbu Cao <bingbu.cao@intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 11, 2020 at 10:00 AM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Bartosz,
>
> On Mon, Aug 10, 2020 at 08:12:00PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Aug 10, 2020 at 10:26 AM Sakari Ailus <sakari.ailus@iki.fi> wro=
te:
> > >
> >
> > [snip]
> >
> > > >
> > > > Rafael: I think that there are two issues with patch 1/5:
> > > > 1. It adds a very specific boolean flag to a structure that's meant=
 to
> > > > be very general. As I pointed out in the i2c patch: at the very lea=
st
> > > > this could be made into an int storing flag values, instead of a
> > > > boolean field. But rather than that - it looks to me more like a
> > > > device (or bus) feature than a driver feature. Is there any ACPI fl=
ag
> > > > we could use to pass this information to the driver model without
> > > > changing the driver structure?
> > >
> > > To my knowledge there isn't. The fact that I=E6=B6=8E devices are pow=
ered on for
> > > probe in ACPI based systems is specific to Linux kernel and not ACPI =
as
> > > such.
> > >
> > > The reason this needs to be in a generic struct is that the device's =
power
> > > state will be changed before any interaction with the driver takes pl=
ace as
> > > it's the I=E6=B6=8E framework that powers on the device.
> > >
> >
> > I'm not sure I'm following. Looking at patch 1/6 struct device already
> > exists so why can't this information be conveyed "per device" as
> > opposed to "per driver"?
>
> It's both driver and device.
>
> Suppose there's no indication of driver support. If you add the property
> telling the device shouldn't be powered on for probe, it won't be. And if
> the driver doesn't support that, probe will fail. That could happen e.g.
> when running an older kernel on a system that happens to specify this
> property for a given device.
>
> You could view this as a driver bug of course. I still think it's better =
to
> make driver support for this explicit, and avoid making this a practical
> problem anywhere.
>

I see. I'm not sure this is the correct solution but let's see what
Wolfram says. From my side: I'd prefer to see the
disable_i2c_core_irq_mapping converted to flags first and then the
flags extended with whatever you need. disable_i2c_core_irq_mapping
could also be removed AFAICT - nobody uses it.

Bart
