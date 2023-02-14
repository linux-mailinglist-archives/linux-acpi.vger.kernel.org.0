Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE7696E81
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Feb 2023 21:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBNU1I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Feb 2023 15:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNU1H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2023 15:27:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8392B63D;
        Tue, 14 Feb 2023 12:27:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j17so25079219lfr.3;
        Tue, 14 Feb 2023 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJa5N1j+ZDXx1hMihd0l2gcsgdbA3VwDhWxoSnBYFmw=;
        b=MZUjRzfTjNOlAO8V/XRmf56fF9wZzXsrktLJ92jLy9axTU16AU0HjJjS8H3GXjuP/q
         A2NNcC12WBlvTWp/OpfrLxAKzujbCfOaz1nqYCjjLWGKaLpCh4LV3Vsk7uSCv+cR4oZk
         W6CPxgo1yyVLO9cUCOIefd5I3n/Wq0HVpuuU7YsHDDFeYvt2fWqccDnfr52hAvVJ/Cjg
         8pdd6ifJ6wqpo91+KW8zpkKdAMZH8FsOLG/zqUpwNlXyDgDuZK8JMSKnfq4GW/vDd8td
         HyDrqKUYaYazpg8OzlxUs7krQhu/uOW1D6vgyxgy+dyJlRaUjuj0w0BQt2oTX0Y46n8d
         3uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJa5N1j+ZDXx1hMihd0l2gcsgdbA3VwDhWxoSnBYFmw=;
        b=iyH53+3k67fixaLhjx1ZxsB1epfkUQhvIisPvDuKNRqgCjTvShua64DG1Y9m7b2+nh
         bk7BiDkxicSwRR/Hmf8DLDU3F5KFcwmLzdt5LGL04peobvelf51jhGbKMrHTOBdVvB9R
         T4jnyhYiuwj6tKNgfTSntPmwtDAj5Y14MCrJoJUSBeTr0Dbw8SQsf7FCpnOB7wpwPTxJ
         jThUlqmbPn+NSs/FTUXyOBfwnLJGLEubP6Wzx2AeWqdltdLVE9J+MlaZ+UFwx6mww7rs
         oF9mBQcN46TMI7uxXqOm7WXSf8pBCi+NV5p0BWj7JQ7thL9W+b17fTGrfDAqrlsde+ao
         vdng==
X-Gm-Message-State: AO0yUKVJbnWkBEmaxeXnxMghkSn2e2ocCOW6vQhGCtSAy2qFfY1Ni1EO
        zB4eXnsMiU0WdCe85v1Uwp8WTn2ES0QvRb4QurU=
X-Google-Smtp-Source: AK7set9cUKCwZZWmhYvTo58RHa8XKmk7Pd0cKSH8U4QavAc3tSq/CpcSkps99ekSI7GWQPFqSayIuzJgOVHzQiqeI6A=
X-Received: by 2002:a05:6512:3b91:b0:4d5:ca32:6ed5 with SMTP id
 g17-20020a0565123b9100b004d5ca326ed5mr52890lfv.3.1676406423639; Tue, 14 Feb
 2023 12:27:03 -0800 (PST)
MIME-Version: 1.0
References: <CACp=KFQN79Rz0CHP-5kwP9Y5Y9bEAoN0eJzoOpSejg6aF9qnpw@mail.gmail.com>
 <233344ca-5df1-abd9-6fb6-c04634f1b401@redhat.com>
In-Reply-To: <233344ca-5df1-abd9-6fb6-c04634f1b401@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 14 Feb 2023 14:26:52 -0600
Message-ID: <CAOOmCE82d6J3Dt2GB2WTYX1UWw-cZfsBWBBGHp--ac+_2Bn_6w@mail.gmail.com>
Subject: Re: RFI: Tablet mode support on HP Pro x360 435 G9 w/ AMD Ryzen 7 5825U
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Carsten Hatger <xmb8dsv4@gmail.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mario.limonciello@amd.com,
        Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

I am forwarding this question to the BIOS team to identify which ACPI
device is the right device to get the SW_TABLET_MODE events.

On Mon, Feb 13, 2023 at 6:31 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Carsten,
>
> On 2/13/23 11:43, Carsten Hatger wrote:
> > Dear all,
> >
> > I'd like to have tablet mode support on my system, probably by means
> > an linux input device such as implemented in the intel platform
> > specific driver drivers/platform/x86/intel/vbtn.c [0]
> >
> > In the end I hope GNOME eventually to rotate the systems display and
> > to show some virtual keyboard (upon users request), cf. for [3]
> >
> > It appears there has already been a patch proposed  by the chromium
> > team to support device PNP0C60 [1] but not merged to [5].
> >
> > Since the system of interest is a HP Probook, there is already a
> > driver providing virtual buttons,namely hp-wmi [6]. However, the
> > driver loads probes and loads successfully but doesn't provide any
> > additional functionality plus some non critical errors on incorrect
> > ACPI method calls.
> >
> > I've noticed AMD has started to provide platform specific driver(s)
> > such as pmf [2]. To my knowledge there is no support for CEZANNE/green
> > sardine based systems (yet).
> >
> > What would be recommended practice and subsystem/folder to provide
> > such capability by means of a (platform specific) driver? At least the
> > CID PNP0C60 seems to be held by Microsoft [4] and thus be common to
> > both amd and intel platforms [4]. However, HID INT33D6 is held by
> > Intel and HID AMDI0081 by AMD. Yet I'm not quite sure if
> > iio-sensor-proxy [7] needs to be involved, too.
>
> The first thing to do here is to figure out which (ACPI) device
> is the right device to get the SW_TABLET_MODE events from on this
> device.
>
> Maybe Jorge (added to the Cc) can help with this ?
>
> Regards,
>
> Hans
>
>
>
>
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/intel/vbtn.c?h=v6.2-rc8
> > [1] https://lore.kernel.org/lkml/1472628817-3145-1-git-send-email-wnhuang@google.com/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/amd/pmf?h=v6.2-rc8
> > [3] https://gitlab.gnome.org/GNOME/mutter/-/issues/1760
> > [4] https://learn.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-implementation
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/button.c?h=v6.2-rc8
> > [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/hp/hp-wmi.c?h=v6.2-rc8
> > [7] https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/
> >
>
