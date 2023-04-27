Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AAE6F0871
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Apr 2023 17:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbjD0Pfv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Apr 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjD0Pfu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2023 11:35:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123BFF;
        Thu, 27 Apr 2023 08:35:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b99f374179bso5432256276.3;
        Thu, 27 Apr 2023 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682609748; x=1685201748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsZyi0a0Qyzd4XEPp5AQRM/aaSWc36m3XhoaZ/NYbBo=;
        b=dydtZn8dDiSwkv+/AK1cPkzFY7whtzPac7kF5OSf2RNdj+p5ORD4Vo8beDMBEPtaBm
         6VnuDrLefwunnYWyrvpHkeSMBfOPMnvj3tctgGiGQli+JA3sp/bysou8mNlRvQIsVjP5
         n/TGQ99mmdKg5axbl3+FgKW8RkYXYDs9ru/U1Urh9k9pfkbUz1+Nmo3T60afTcCqAjB5
         Oa92XsZBy4ZjP2+ryTNrSMsBKQw2STWe6lVkd/XCJeU/TH0KwjhO20t9B+/JrDPiWj+p
         fTYZekcdY5jNH8BnSrjZ9t4DQX9eEuwax5iPeXAiZfagK2922HXzwh0T6cMrktk4D9Qx
         0OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609748; x=1685201748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsZyi0a0Qyzd4XEPp5AQRM/aaSWc36m3XhoaZ/NYbBo=;
        b=iuhJqJGLkIieF2G2znFonRMoyY+Vr/jo/E5cYbvveldAF46WafsFc6eQUZ8dQuHHy6
         RVARLQKdpQqlW/P2Ts3m/tLLFy6LzsMkNQ70cNP9rSJ2atb+ZEMXaMHw6ZFB3iEmS3fW
         V48bGLMHGVS7EbAvfTnQXMFnXSFoE/r6lsvZ19k9jigVVGuOwzJFrJDWytZFFYquk/sq
         5cXG1qLEUqyZnzhiKO+Ur24BNKw92CJVPEeXbatvArcJJMM5rfP0ZsPy0Pv32hKcCAdt
         MrZBM1Ng2vfqCmHyujT8RLBO6dp0RquHF8ZIfGt9H544n6Pmrwap5YkMahJ7RKJ5YsKc
         8zuw==
X-Gm-Message-State: AC+VfDzhigmVOmUvvYRFUPOlkndEZMt0KoKanLvrPS2RMB6k6tTu68oH
        LYZOoj6j/ZAryTxU66zzY38dsM5gCecjfb8rPg58hZOnEbxA6w==
X-Google-Smtp-Source: ACHHUZ7HlMu1I4+r3L/J09BkBgctpOSx5nEnN0PSN7OjMbq/Qf+tQ8g/Sgo59BnZoxyvqWaf0MhbUQoIxzP0CTbnSH8=
X-Received: by 2002:a25:24c4:0:b0:b99:15c0:770b with SMTP id
 k187-20020a2524c4000000b00b9915c0770bmr1334413ybk.38.1682609748005; Thu, 27
 Apr 2023 08:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK4BXn0ngZRmzx1bodAF8nmYj0PWdUXzPGHofRrsyZj8MBpcVA@mail.gmail.com>
 <2023041711-overcoat-fantastic-c817@gregkh> <CAK4BXn30dd3oCwcF2yVb5nNnjR21=8J2_po-gSUuArd5y=f9Ww@mail.gmail.com>
 <CAJZ5v0g+PAOZs47LCrxRswZoCmHbGfBg3_cr13Y8zWPXDjgm3A@mail.gmail.com> <a3b89478-2d37-1b25-94e0-0e12396f6fd4@redhat.com>
In-Reply-To: <a3b89478-2d37-1b25-94e0-0e12396f6fd4@redhat.com>
From:   =?UTF-8?B?0KDRg9GB0LXQsiDQn9GD0YLQuNC9?= 
        <rockeraliexpress@gmail.com>
Date:   Thu, 27 Apr 2023 21:05:37 +0530
Message-ID: <CAK4BXn37Ns8Z8g4ysKoOZJaVa8K+mFQm5PupAanQwmz07ygW9A@mail.gmail.com>
Subject: Re: REGRESSION: ThinkPad W530 dim backlight with recent changes
 introduced in Linux 6.1.24
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> This patch should not change the maximum brightness. But you may need
to adjust the brightness once after changing to a new kernel with
the patch because the range / brightness-curve may be different.

This patch does change the display brightness curve but it is very
buggy and does not change the brightness as soon as set. There is a
very significant delay in brightness transition on the laptop due to
this patch. Also it is worth mentioning that this patch also messes up
color contrast of the display causing significantly deeper blacks on
the display.

> I would expect you to be able to get back your old brightness level
then and this should persist over reboots after you have adjusted
it once.
>what happens if you use e.g. Fn + F9 to increase the brightness

Here are the attached pictures explaining the situation.
100% brightness on Kernel 6.3-rc7 - https://i.imgur.com/eQK890s.jpg
100% brightness on Kernel 6.1.22 - https://i.imgur.com/1rgNtxJ.jpg

Thanks.

On Fri, Apr 21, 2023 at 12:05=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi =D0=A0=D1=83=D1=81=D0=B5=D0=B2 =D0=9F=D1=83=D1=82=D0=B8=D0=BD,
>
> On 4/20/23 19:02, Rafael J. Wysocki wrote:
> > CC: Hans
> >
> > On Thu, Apr 20, 2023 at 6:38=E2=80=AFPM =D0=A0=D1=83=D1=81=D0=B5=D0=B2 =
=D0=9F=D1=83=D1=82=D0=B8=D0=BD <rockeraliexpress@gmail.com> wrote:
> >>
> >>> Any reason why you didn't cc: the developers of that commit?
> >> Sorry I did not realise I should have done that.
> >>
> >>> Do you also have this issue on the latest 6.3-rc release?
> >> Yes I have tested it recently by installing the latest 6.3-rc7 kernel
> >> , and I do encounter the same issue there. I have linked the
> >> screenshots below referring the same.
> >> Kernel 6.3.0-rc7 with 43% brightness - https://i.imgur.com/5LqsEJb.jpg
> >>
> >>> That's what this commit does, right?
> >> According to the commit , it was pushed to fix backlight controls
> >> which were broken on Lenovo Thinkpad W530 while using NVIDIA. It was
> >> not intended to reduce the backlight intensity on W530. Backlight is
> >> dimmer than before even when using the laptop in Intel iGPU mode.
>
> This patch should not change the maximum brightness. But you may need
> to adjust the brightness once after changing to a new kernel with
> the patch because the range / brightness-curve may be different.
>
> On the imgur URL your display brightness shows as being at 43%,
> what happens if you use e.g. Fn + F9 to increase the brightness ?
>
> I would expect you to be able to get back your old brightness level
> then and this should persist over reboots after you have adjusted
> it once.
>
> If adjusting it does not help / work then we will need to revert
> the patch causing this.
>
> Regards,
>
> Hans
>
>
