Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CD2FA22C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 14:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392483AbhARNvp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 08:51:45 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39901 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392477AbhARNvh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2021 08:51:37 -0500
Received: by mail-ot1-f48.google.com with SMTP id i30so3345692ota.6;
        Mon, 18 Jan 2021 05:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWMUyKQASjDR6+Q35MwW6JXNWk2Dq2HJlpeAoaLS16g=;
        b=U8sKd9QezsIbNnfB0oHFc7/KZ9xz9f/jfQJ7QOqFjKFWUiK5TfKm+HXRaA9a8EuZJB
         7dPAdsWEJ9rfWVBQxSo/E0x/yU9fgRn3uG7CCyuF+YroQK+oCS2BgUwsksUARYxzW6co
         ehtaXdSN2seJM8y/lpvZYB+RomJmeynh9fo4hnJveNDqO7JfkMThXb2W12Pcm6WVp2rw
         JevgVFNH5CO+yjJX4oi8Oteh/0xOlrEYSrC6vUapuFcmm5CSr+wuMLGHZ3xvlmnGqLWN
         re+72ISwMbt34CkkcHWps1hL2qh6c9ocgp0h9+aXX45S3lPJp/m+QNyPnnIkINam4vxt
         SRxA==
X-Gm-Message-State: AOAM532biXHJ24Eq+1IPNbtRan3ohmEGBlB1zlJ3/DP2V3xMFZ9XD6Rg
        xlfl/35sv9+rf38vIpAOhtHon4e7N2rS+Fe8LY5P9itw
X-Google-Smtp-Source: ABdhPJzBwdU2RfzvFay30BhhzoDzprQ5FOfN1Lp3un+sHaj3r3ln2oPa4ry4/c4f1bHAhHTK2Ko4P8KaA5BYwJtDmAM=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr18059642otk.206.1610977851304;
 Mon, 18 Jan 2021 05:50:51 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
 <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
In-Reply-To: <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jan 2021 14:50:33 +0100
Message-ID: <CAJZ5v0iyEq6+OemJNXQv46h0pW=LHxiR2HeFe4+us59_x6Nymg@mail.gmail.com>
Subject: Re: Multiple MODALIAS= in uevent file confuses userspace
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CC Mika and Andy.

On Mon, Jan 18, 2021 at 8:27 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Sat, Jan 9, 2021 at 12:25 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
> > "compatible" is present") creates two modaliases for certain ACPI
> > devices. However userspace (systemd-udevd in this case) assumes uevent
> > file doesn't have duplicated keys, so two "MODALIAS=" breaks the
> > assumption.
> >
> > Based on the assumption, systemd-udevd internally uses hashmap to
> > store each line of uevent file, so the second modalias always replaces
> > the first modalias.
> >
> > My attempt [1] is to add a new key, "MODALIAS1" for the second
> > modalias. This brings up the question of whether each key in uevent
> > file is unique. If it's no unique, this may break may userspace.
>
> Does anyone know if there's any user of the second modalias?
> If there's no user of the second one, can we change it to OF_MODALIAS
> or COMPAT_MODALIAS?
>
> Kai-Heng
>
> >
> > [1] https://github.com/systemd/systemd/pull/18163
> >
> > Kai-Heng
