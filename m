Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208E586590
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Aug 2022 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiHAHRS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Aug 2022 03:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiHAHRS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Aug 2022 03:17:18 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342F3AB2D
        for <linux-acpi@vger.kernel.org>; Mon,  1 Aug 2022 00:17:16 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i4so7834877qvv.7
        for <linux-acpi@vger.kernel.org>; Mon, 01 Aug 2022 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1uS6E7ZkRa/baG5pTg79vAqfBuGnhvLh8VZy1wWJZEc=;
        b=kYzh7dP8lUBSGmUhcjMxp7hP9XAYdopEURRCzi9HAiLo0czTrc1L98p5+v8d8P0G4K
         M1MiCpX1s6n9xvbZ32X2kORjCmVKdbw0ByP+cM/C6auLETpOJ82dm7CzwH0nj2635TfU
         nO6F+7GmaDY3aaEaKglchBGx2jrvKz5ZEJ0BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1uS6E7ZkRa/baG5pTg79vAqfBuGnhvLh8VZy1wWJZEc=;
        b=aq7UTDE4xRrv82bm4hOUX3rlF42/XR+qanY+ausVa3+MjMlrShoFU16SnBNbQFOQvD
         riTE2t2U9G6m1bIwDgrsE6YO37sWLSpl13U+2NmGGwlKdv3pqHPGGquc+aPGmZkA2bZQ
         J9bz5OCpHFCLgnypDeMit8rxMemXjHAHDSGLQOwW8SWZmlqbIJdRyzr73/EvKh8x+Yzz
         D8taSDtabkixhUUJt0oe9MUaEfRL7efTwxIP3hi3krmI7Op9m03RldaTKA20Y3qbikH2
         ABqrhVN8SNpAjI/B6YsjbLhKUPChA3Owo6xz8lu1iKjhAjwmRAGBkNeXKyXdnzG2eCiB
         LwnA==
X-Gm-Message-State: ACgBeo3LqiCfgsMMeRVKuagPaVoBJS2MDq1bTkF64rOTXLZaDrdqYtJC
        MpseBbD5RmSAtFQvH0sD4db/Ufd1OxAT/w==
X-Google-Smtp-Source: AA6agR7RTVPkbVEXAHh6P+ybU4cCeH03kAb47K8hCB7STIWP7MytsymL5amwQ4PWEBvkM8WRomcbsw==
X-Received: by 2002:ad4:5747:0:b0:474:3abe:4260 with SMTP id q7-20020ad45747000000b004743abe4260mr12494950qvx.54.1659338235646;
        Mon, 01 Aug 2022 00:17:15 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t14-20020a37ea0e000000b006b58fce19dasm8003954qkj.20.2022.08.01.00.17.13
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 00:17:13 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id i62so15803946yba.5
        for <linux-acpi@vger.kernel.org>; Mon, 01 Aug 2022 00:17:13 -0700 (PDT)
X-Received: by 2002:a25:abc6:0:b0:674:2b0c:5a88 with SMTP id
 v64-20020a25abc6000000b006742b0c5a88mr11146946ybi.296.1659338232719; Mon, 01
 Aug 2022 00:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <YitLit9LC2zlOfdh@paasikivi.fi.intel.com> <YitMt7hVA2okuQ8x@pendragon.ideasonboard.com>
 <YitPaq2yYnrKsq4f@paasikivi.fi.intel.com> <Yi3rQGmeXQD70Tkh@pendragon.ideasonboard.com>
 <Yi3z2nR8j+ee4E4m@paasikivi.fi.intel.com> <Yi38zOHsh68FrrKK@pendragon.ideasonboard.com>
 <Yi+e/IK+eVpKit/F@paasikivi.fi.intel.com> <Yi+gEVB0FuOcY5qn@pendragon.ideasonboard.com>
 <Yi+vdvMeXqb/BvKo@paasikivi.fi.intel.com> <YkMDfvuhAvsrjbON@pendragon.ideasonboard.com>
 <YlfplRQYDYhFvc5U@paasikivi.fi.intel.com>
In-Reply-To: <YlfplRQYDYhFvc5U@paasikivi.fi.intel.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 1 Aug 2022 16:17:01 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C7-OuNpnduwKpZXFUPQKDeqkz2xkvP+JBBs+aNjB87FQ@mail.gmail.com>
Message-ID: <CAAFQd5C7-OuNpnduwKpZXFUPQKDeqkz2xkvP+JBBs+aNjB87FQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: ov5640: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Martina Krasteva <martinax.krasteva@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>, Arec Kao <arec.kao@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jimmy Su <jimmy.su@intel.com>,
        Martin Kepplinger <martink@posteo.de>,
        Daniel Scally <djrscally@gmail.com>,
        Jacopo Mondi <jmondi@jmondi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        bingbu.cao@intel.com, andriy.shevchenko@intel.com,
        "hidenorik@chromium.org" <hidenorik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 14, 2022 at 6:30 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Laurent,
>
> On Tue, Mar 29, 2022 at 04:02:54PM +0300, Laurent Pinchart wrote:
> > Hi Sakari,
> >
> > On Mon, Mar 14, 2022 at 11:11:18PM +0200, Sakari Ailus wrote:
> > > On Mon, Mar 14, 2022 at 10:05:37PM +0200, Laurent Pinchart wrote:
> > > ...
> > > > > > Yes, after reading the version register (or doing any other har=
ware
> > > > > > access). Actually the full code would be
> > > > > >
> > > > > >
> > > > > >       pm_runtime_enable(dev);
> > > > > >       pm_runtime_resume_and_get(dev);
> > > > > >
> > > > > >       /* Hardware access */
> > > > > >
> > > > > >       pm_runtime_set_autosuspend_delay(dev, 1000);
> > > > > >       pm_runtime_use_autosuspend(dev);
> > > > > >       pm_runtime_put_autosuspend(dev);
> > > > > >
> > > > > > (plus error handling).
> > > > > >
> > > > > > If the probe function doesn't need to access the hardware, then
> > > > > > the above becomes
> > > > > >
> > > > > >       pm_runtime_enable(dev);
> > > > > >       pm_runtime_set_autosuspend_delay(dev, 1000);
> > > > > >       pm_runtime_use_autosuspend(dev);
> > > > > >
> > > > > > instead of having to power up the device just in case !PM.
> > > > > >
> > > > > > > Also the latter only works on DT-based systems so it's not an=
 option for
> > > > > > > most of the drivers.
> >
> > Does the former work on ACPI systems ?
>
> Yes (i.e. the one that was above the quoted text).
>
> >
> > > > > > How so, what's wrong with the above for ACPI-based system ?
> > > > >
> > > > > I=E6=B6=8E devices are already powered on for probe on ACPI based=
 systems.
> > > >
> > > > Not through RPM I suppose ?
> > >
> > > Runtime PM isn't involved, this takes place in the ACPI framework (vi=
a
> > > dev_pm_domain_attach() called in i2c_device_probe()).
> >
> > How can we fix this ? It may have made sense a long time ago, but it's
> > making RPM handling way too difficult in I2C drivers now. We need
> > something better instead of continuing to rely on cargo-cult for probe
> > functions. Most drivers are broken.
>
> Some could be broken, there's no question of that. A lot of drivers suppo=
rt
> either ACPI or DT, too, so not _that_ many need to work with both. Albeit
> that number is probably increasing constantly for the same devices are us=
ed
> on both.
>
> Then there are drivers that prefer not powering on the device in probe (s=
ee
> <URL:https://lore.kernel.org/linux-acpi/20210210230800.30291-2-sakari.ail=
us@linux.intel.com/T/>),
> it gets complicated to support all the combinatios of DT/ACPI (with or
> without the flag / property for waiving powering device on for probe) and
> CONFIG_PM enabled/disabled.
>
> What I think could be done to add a flag for drivers that handle power on
> their own, or perhaps rather change how I2C_DRV_ACPI_WAIVE_D0_PROBE flag
> works. Right now it expects a property on the device but that check could
> be moved to existing drivers using the flag. Not many drivers are current=
ly
> using the flag. I think this would simplify driver implementation as both
> firmware interfaces would work the same way in this respect.
>
> You'd have to change one driver at a time, and people should be encourage=
d
> to write new drivers with that flag. Or add the flag to all existing
> drivers and not accept new ones with it.
>
> These devices I think are all I=E6=B6=8E but my understanding is that suc=
h
> differences exist elsewhere in the kernel, too. If they are to be
> addressed, it would probably be best to have a unified approach towards i=
t.
>
> Added a few more people and lists to cc.

+ Hidenori from my team for visibility.

I think we may want to take a step back and first define the problem
itself. To do that, let's take a look separately at DT and ACPI cases
(is platform data still relevant? are there any other firmware
interfaces that deal with I2C devices?).
For simplicity, let's forget about the ACPI waived power on in probe.

DT:
 1) hardware state unknown when probe is called
 2) claim any independently managed resources (e.g. GPIOs)
 3) enable runtime PM
 4) if driver wants to access the hardware:
    a) runtime PM get
    b) enable any independently controlled resources (e.g. reset GPIO)
    c) [do access]
    d) disable any independently controlled resources
    e) runtime PM put
 5) after probe returns, regulators, clocks (and other similarly
managed resources) would be force disabled if their enable count is 0
 6) hardware state is off (after the runtime PM state settles)

ACPI:
 1) hardware state is active when probe is called
 2) [n/a]
 3) tell runtime PM framework that the state is active and then enable
runtime PM
 4) if driver wants to access the hardware:
    a) runtime PM get
    b) [n/a]
    c) [do access]
    d) [n/a]
    e) runtime PM put
 5) [n/a]
 6) hardware state is off (after the runtime PM state settles)

It seems like the relevant difference here is that for ACPI, the
driver needs to know that the initial state is active and also relay
this knowledge to the runtime PM subsystem. If we could make the ACPI
PM domain work the same way as regulators and clocks and eventually
power off some time later when the enable count is 0, then perhaps we
could avoid the problem in the first place?

Best regards,
Tomasz
