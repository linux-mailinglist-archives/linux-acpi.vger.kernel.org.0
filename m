Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D94240CBF
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Aug 2020 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgHJSMN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Aug 2020 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgHJSMM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Aug 2020 14:12:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502B3C061788
        for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2020 11:12:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so9235267qkk.7
        for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2020 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QgYtQ0nvpVp5fhNq6Bvi4E7+pTeN2jB4TjYNqQS0gag=;
        b=FR2zrXihy6D3nhs1ct5EvXKpFFv8/X/8ppPIYYdFMToMH8E5g9vRvtyRITLyi1aYD4
         qFve2SrwjFOk4YOBylAQ5gTTGJ3lSvmEkoR32EUPLXrZraiyNOisEwpnQR8GOOU9tjP3
         Y2py6RuA213m/Rvnw0IhJPMijSfYqjfZWJcNsFYJ7/lyPd55FWuAYxyXTUF9ESpv6YbM
         Zw9JeH8tyW/L9vftgbAD1pwA1ZVdSOvVzYsXpTJpascbwTyGsmtLI9t1ltPXrqYi7STX
         orxLdQUrP2NMJ61eNOIU2FmENuF8hkbuncXq4ZnxD6WOkJFuP333L4i8BzJDg8EEVeg/
         7LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QgYtQ0nvpVp5fhNq6Bvi4E7+pTeN2jB4TjYNqQS0gag=;
        b=uZi6hr8VEpLGse/UodqR6pv8naEvuRX3qkFc+tJgbjOyuRoPJ2TlkmXebnBKlJTqfc
         X3D4692WgrSjTqV7MtI5pOEvXk0lSlQU672PIQwS3rwN9c1HvtD8h5VqOiE/SYK7OPvq
         jqFE/whFfMd5otIkqOEvtzU80bCWc/Hq7EEVlnXuoajgXDZuXm2BxYkXvtQhU37SPSwa
         9xxPgponNPK8jwAqf4Ss8LhJXjUrGT6+Mz3dk+kf87+iY6XaIqCU+iCuk47zME5nIlD5
         6Ip9uFxnMJ94G9v+oHn74ouUYJtRarDfaRfZouJr8Ny2WV+52Ntcorr/ewCCuLj2agRc
         7vPQ==
X-Gm-Message-State: AOAM531bdj0MammURSRGdr3VQn7HV3Wdz8dIdV0x5VBg7XjilaVrGrT3
        9HUVH2W4PS5poJbHltcgQjaaNlhlfFgGUorfTFSKHg==
X-Google-Smtp-Source: ABdhPJzVZ0Mt67L/YycKJ+BfSO6D2a5cJbAo4OEZcWsLpeH4ANdkOsDGT7TO+eRhnKZmnPmdNsI1M/pIA69c/9oNGEo=
X-Received: by 2002:a37:9d97:: with SMTP id g145mr23363392qke.263.1597083131390;
 Mon, 10 Aug 2020 11:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200121134157.20396-1-sakari.ailus@linux.intel.com>
 <20200121134157.20396-6-sakari.ailus@linux.intel.com> <CAMpxmJU5dG49N2FA0oSQsOfKrCr3KQ1BisON4c+nUJJmZQG=bQ@mail.gmail.com>
 <20200311085555.GH5379@paasikivi.fi.intel.com> <CAMpxmJVPTKW+sYSJ3dnfF8nLAOKEa4Ob7bpxG0KD3Tkdm+rtYw@mail.gmail.com>
 <20200323213101.GB21174@kekkonen.localdomain> <CAMpxmJVdyTkZMVuhSy0Ux8VUYTmQN_YEfH-akQsAL3zrwiz8Dw@mail.gmail.com>
 <20200810082549.GD840@valkosipuli.retiisi.org.uk>
In-Reply-To: <20200810082549.GD840@valkosipuli.retiisi.org.uk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 10 Aug 2020 20:12:00 +0200
Message-ID: <CAMpxmJUKSR-oCGnV1E5XiAMA2nYBy5f_f8=VSoMn0zf+qF39vg@mail.gmail.com>
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

On Mon, Aug 10, 2020 at 10:26 AM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>

[snip]

> >
> > Rafael: I think that there are two issues with patch 1/5:
> > 1. It adds a very specific boolean flag to a structure that's meant to
> > be very general. As I pointed out in the i2c patch: at the very least
> > this could be made into an int storing flag values, instead of a
> > boolean field. But rather than that - it looks to me more like a
> > device (or bus) feature than a driver feature. Is there any ACPI flag
> > we could use to pass this information to the driver model without
> > changing the driver structure?
>
> To my knowledge there isn't. The fact that I=C2=B2C devices are powered o=
n for
> probe in ACPI based systems is specific to Linux kernel and not ACPI as
> such.
>
> The reason this needs to be in a generic struct is that the device's powe=
r
> state will be changed before any interaction with the driver takes place =
as
> it's the I=C2=B2C framework that powers on the device.
>

I'm not sure I'm following. Looking at patch 1/6 struct device already
exists so why can't this information be conveyed "per device" as
opposed to "per driver"?

[snip]

Bartosz
