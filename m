Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38E47C416
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Dec 2021 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhLUQrd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Dec 2021 11:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbhLUQrd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Dec 2021 11:47:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F504C061401
        for <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2021 08:47:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f5so31310283edq.6
        for <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2021 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qgzoOjuixCPGD3DrGcfNRG0OiVFUDG2snsOsT7Z+aWs=;
        b=GfZb8I6uUXmA3ugHIvVwpvC75DFWqQ9FTrkYC+xshHSAlo0PBtBwr7JyaJl6qNUSCK
         /NZ6dgKqVNXMkHXcvp8keaHOhC9o7qT5Z9WQn7CLE9/9acgQ9bSYnrzfhgtyY4icBoFS
         S47vPFEUe8cwXS+Xtn4fDGjQIFrraNgMjP/RQf4KV17CZAV6Gs6jpwglRvHOcqHDpJaL
         5hGWYcKtbkA6Zh2tnyqRJAbPS1yb272ZLAfgQMP1sImvfwE59amNwt1QMBPS3ZrdCfQA
         wgF9LuSmes4YJDeRDmkhDeZ+UoZ5SxTFUH9cTHgpFrJY/OB3ks5+8yfIUcc0dhJH3lWj
         tiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qgzoOjuixCPGD3DrGcfNRG0OiVFUDG2snsOsT7Z+aWs=;
        b=76c7PMVycz4RsyfRRcfJN23rrRtMw1PL9q4BCRmXTGjqTivEV2hUTbLICKFDlz0hf3
         g0cnWAgeOdgZNqJVZBsnEO+m7vm8qaiIgODXHf7+1h9qMvFP7s5Bm5sCotqWxxMHtyIK
         VV7GujjK8p7haLd4eOzin5vxeyrpp6b1WXJFsFcBgLShktxibxaRehwwxn3k5BPKb1/R
         InEtnVekefgxtC9nZkvXyQgIbgoz8y9a7+Z2Hgk6yOqy9oOs2tDYrfdSC+wyawyOFj4/
         760YCnQMFNto8N70gWhOTS54q/y8FJIaRFCmkgu8KlxclFehWLVwo6jXqNxJkz+dbZpv
         VnWA==
X-Gm-Message-State: AOAM530Kdw01C3molhNw5Wu8senu5FBFM958K7UHxj4no4o4mE4cm3g0
        fnmO/QW2MGHu9EsLuaFbMFxK9ghA85ElMawMDO/XBA==
X-Google-Smtp-Source: ABdhPJwDLPCgB8Wi8VYCO/jFHJtdzGpyco8O0RmQmiFpE9YLdKzudzKph06jI7RIeEBybqsLVIoSLRUWzWUsqlZzMAA=
X-Received: by 2002:a05:6402:1c08:: with SMTP id ck8mr4115171edb.32.1640105250601;
 Tue, 21 Dec 2021 08:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20211220210643.47842-1-pmenzel@molgen.mpg.de> <CAE_wzQ_Lg1ODV5sEqtW=SauhSXxi6+fh3msOuhnJy8-sNtORcg@mail.gmail.com>
In-Reply-To: <CAE_wzQ_Lg1ODV5sEqtW=SauhSXxi6+fh3msOuhnJy8-sNtORcg@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 21 Dec 2021 08:47:19 -0800
Message-ID: <CABXOdTeNy3jQ5aQijw9HTpwcNvkEJmddz9yf0Mk-Z+78bDDN-A@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: i2c: Add device property for probing
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, Wolfram Sang <wsa@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        coreboot@coreboot.org, Matt DeVillier <matt.devillier@gmail.com>,
        Felix Singer <felixsinger@posteo.net>,
        Duncan Laurie <dlaurie@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-i2c@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 20, 2021 at 1:49 PM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> Hi Paul,
>
> On Mon, Dec 20, 2021 at 1:07 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote=
:
> >
> > From: Furquan Shaikh <furquan@google.com>
> >
> > Dear Linux folks,
> >
> >
> > Google Chromebooks are often built with devices sourced from different
> > vendors. These need to be probed. To deal with this, the firmware =E2=
=80=93 in
> > this case coreboot =E2=80=93 tags such optional devices accordingly =E2=
=80=93 I think
> > this is commit fbf2c79b (drivers/i2c/generic: Add config for marking
> > device as probed) =E2=80=93 and Chromium OS=E2=80=99 Linux kernel has t=
he patch at hand
> > applied to act accordingly. Right after the merge, Dmitry created a
> > revert, which was actively discussed for two days but wasn=E2=80=99t ap=
plied.
> > That means, millions of devices shipped with such a firmware and Linux
> > kernel. To support these devices with upstream Linux kernel, is there a=
n
> > alternative to applying the patch to the Linux kernel, and to support
> > the shipped devices?
>
> *sigh* I should have pushed harder, but I see it managed to
> proliferate even into our newer kernels. Not having this patch should
> not cause any problems, it can only hurt, because the i2c core has no
> idea how to power up and reset the device properly. The only downside
> of not having this patch is that we may have devices in sysfs that are
> not connected to actual hardware. They do now cause any problems and
> is how we have been shipping ARM-based devices where we also dual- and
> triple-source components. However if we were to have a device that
> switches between several addresses (let's say device in bootloader
> mode uses 0x10 address and in normal mode 0x20) this "probing" may
> result in device not being detected at all.
>
> If we wanted to do this correctly, coreboot would have to implement
> full power and reset control and also add drivers for I2C controllers
> to be able to communicate with peripherals, and then adjust _STA
> methods to report "not present" when the device is indeed absent. And
> note that even in this case we would have issues with "morphing
> devices", so coreboot would also need to know how to reset device out
> of bootloader mode, and maybe flash firmware so device can work in
> normal mode.
>
> However coreboot does (or did?) not want to add code to handle i2c
> controllers, and would like to push this knowledge to the kernel. And
> the kernel does know how to handle peripherals properly, but that
> knowledge lies in individual drivers, not i2c core.
>
> We should remove "linux,probed" from coreboot and not propagate to
> newer Chrome OS kernels, and keep it away from upstream.
>

Revert from chromeos-5.15 is at
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
3350347.
Everyone please feel free to comment there.

Guenter
