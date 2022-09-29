Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD205EED77
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 08:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiI2GDk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiI2GDf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 02:03:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4C12C686
        for <linux-acpi@vger.kernel.org>; Wed, 28 Sep 2022 23:03:34 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C67E441472
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 06:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664431411;
        bh=k6b2K4E94ZEhD8vRDR4/zvr1vdGBEPqs0TlnA04+ktw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=StCyqOIg5KgQ6seUEPBVfWtXmpyh8w56XynvNKeukrZ0LfYFfHKQOACLpz4vhTLnQ
         USfGSAbIfFzfDyjJwVmJAX4oSW+8STd8ooEfR35Jjht79S38C54W0Ib4g6Udry4iZx
         GO69vb9RfZnhJ632ooVmK4pSXARvd3hS0dbWgmM4Rd7T/XKb5MBo10teO42ejRD+3F
         1MtHLCwWCJWg+aLkbZURUR2I99ywgO83vpNV9ys5rWPyFtVTP+gJHmKbG3ZVk9SniO
         wVBQMUgzAHQ02J2/Z37v1E4B6GAGt8yjApxeFumCG7B4Ttz2FxVdVZEF2f3GNjYGem
         kinsB2BaAxV3g==
Received: by mail-ed1-f72.google.com with SMTP id t13-20020a056402524d00b00452c6289448so439276edd.17
        for <linux-acpi@vger.kernel.org>; Wed, 28 Sep 2022 23:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=k6b2K4E94ZEhD8vRDR4/zvr1vdGBEPqs0TlnA04+ktw=;
        b=bj8nyK30tl8Lzo/wDwUfILSwHu0NkJbLSltuxIwec+UvXAKpP3uCiW0Ame6t406s0x
         xUV0pecjn35MYTrVT7omqCV3CoVyGEpH3HXNFyiE/jVHFE4+9Y/ij6swMm2Xv+++HE2B
         mmBQ2LPIwPxFCoAese2p1MCCKKtyilt8KhaeDpDLwR1zq6G90iuVDj5VDuRczc5zoNx5
         L+QPpc15yi9E38GnEwMC7sQjHmWg1L9Jw/ZKZBMx8WA9HyPoEShKRS15Le4D+dWHMulg
         SKTfS7kipc2shGTCc0jkjn6SynaohLrbRsy6YRudB1qRxXR7FSFWjU0g3NG/bct6iS9o
         gi7g==
X-Gm-Message-State: ACrzQf3VysrYQ2a9XqpX9iEK4h4VFJvWt9Z/f2o0BDt6fwUon636stm3
        VX0n+NfEmfc51lKTGHTkyIv0sK9augxkRHVV0ANTWbXUBTs5Tw+J0I1spZrmGVpqngXvcAagGOF
        sFTOk3W1BHWjBLQX1uoTlag8G4TMtUiGa1rpdMeqwuYsTnlLz9PYg0vQ=
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr1274377ejc.53.1664431410897;
        Wed, 28 Sep 2022 23:03:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM49aMII/RF5CDfCDWMJusejDjYSmDmGPGUnyaMKVN7/Jxn+5q8qbK5cUzcUQzHG2kfpdbehnn4ldGjBc+CUz40=
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id
 hs6-20020a1709073e8600b006f5091710ccmr1274357ejc.53.1664431410635; Wed, 28
 Sep 2022 23:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220916043319.119716-1-kai.heng.feng@canonical.com>
 <20220916043319.119716-2-kai.heng.feng@canonical.com> <CAJZ5v0gTEkZkyKkrjDZk0s+UVR9yPTtBJ_nzG40ZO9kgikFdqw@mail.gmail.com>
 <CAJZ5v0h+3ez6=Hf7iJOAv1T7vs9qXudt90iuccDx84gGN=rbcA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h+3ez6=Hf7iJOAv1T7vs9qXudt90iuccDx84gGN=rbcA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 29 Sep 2022 14:03:18 +0800
Message-ID: <CAAd53p4oOL6ZyCxvneea2VZGDibb7+RkhWfsyyXQuBhjno3VtA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Sep 25, 2022 at 11:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Sep 24, 2022 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Sep 16, 2022 at 6:33 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> > > PowerEdge r440 hangs at reboot.
> > >
> > > The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> > > system reboot to avoid triggering AER"), so use the new sysoff API to
> > > reinstate S5 for reboot on ACPI-based systems.
> > >
> > > Using S5 for reboot is default behavior under Windows, "A full shutdown
> > > (S5) occurs when a system restart is requested" [1].
> > >
> > > [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-state
> > >
> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v4:
> > >  - Add comment and add more info to commit message.
> > > v3:
> > >  - Use new API to invoke ACPI S5.
> > > v2:
> > >  - Use do_kernel_power_off_prepare() instead.
> > >
> > >  drivers/acpi/sleep.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index ad4b2987b3d6e..0b557c0d405ef 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -1088,6 +1088,14 @@ int __init acpi_sleep_init(void)
> > >                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> > >                                          SYS_OFF_PRIO_FIRMWARE,
> > >                                          acpi_power_off, NULL);
> > > +
> > > +               /*
> > > +                * Windows uses S5 for reboot, so some BIOSes depend on it to
> > > +                * perform proper reboot.
> > > +                */
> > > +               register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
> > > +                                        SYS_OFF_PRIO_FIRMWARE,
> > > +                                        acpi_power_off_prepare, NULL);
> > >         } else {
> > >                 acpi_no_s5 = true;
> > >         }
> > > --
> >
> > Applied as 6.1 material with some edits in the changelog, thanks!
>
> And dropped due to a build failure.
>
> It looks like it depends on patch [1/2], but I haven't seen that one.

Sorry about that, let me resend it to linux-pm too.

Kai-Heng
