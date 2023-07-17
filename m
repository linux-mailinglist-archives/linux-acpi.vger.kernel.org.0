Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7381A755912
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 03:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGQBfc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Jul 2023 21:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGQBfb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Jul 2023 21:35:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C6E54
        for <linux-acpi@vger.kernel.org>; Sun, 16 Jul 2023 18:35:27 -0700 (PDT)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ADA353F487
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 01:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689557725;
        bh=gGX3xQTmz9PWaJDMnjtJtvUca5GVPZygjRmu/4e6C1s=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RqSD8PAP+nB5ezPXi3TnjmwzzJsu+S52VLdDLceXhNk33JnPI64NKbGPD+IKE+FWs
         nCk509uFvM8AaQeuxjASI0AZ7+BTzwrGJrAcdVNan11jhTqWAuxXMBM/9F/PfM9MCo
         t4YnYJDwLuxSdsN0kDVWKovjJnHq5OnZG46wW52BpvyEepMDGgRwYpTCwqAJ9PLkGF
         JqwWa+O0yDpWH7CNbUICQ7iQKP39Mt6oOKaIPcfTQPlIb2lqAtHpJfLd3OUKN2EbcK
         c8xXfTewhyqxSKUiaa+Hlgpsd6dQb7nDdKfjO6VAcF7xS3GTMejQ9DQWXhapU7+DQK
         WxU7JRSUCh+5g==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-53ba38cf091so2346676a12.1
        for <linux-acpi@vger.kernel.org>; Sun, 16 Jul 2023 18:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689557723; x=1692149723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGX3xQTmz9PWaJDMnjtJtvUca5GVPZygjRmu/4e6C1s=;
        b=KQJNXzWzaFjoAx0jfrFb+L8clfS1SgbRPVWHycx05hx0zy5dtc1jvBoXW7cpp419jo
         xf22h4Ur+UhJONThZqBL7v3kuai2cCwieaT9orP0p9riKGxhXXnNXT9XQoZdmxLxPios
         TTLOOTqfDQjgCvyBDWuyaFiwB1DmDDO+eyXXaFwmam86IUmKdcelXIdLiBBtMNTYT36X
         6OZx13bQWO6P1uNSHv31IBuv9WHOODjOsHQb/SoMFQmzHw9fnCxWvXr1PgO577c6zsiV
         NorI/u26D2m2ETPvT49P5CAdMdh/Y9hqF8xCfaELVday+TEvMF5ELHh29tdt+nhZwASI
         zbyQ==
X-Gm-Message-State: ABy/qLYpbqX1Rv4BwK7NTZ3j9+aaUeFalt4mkaU8ls3AxAQk4PPqno+4
        S6cgnfpENgSyIYasLoILIMDte9Emdqcd88alDxw6ymLVOrycF99T8u3TUlvp+Z8wIq1p9/RVUhX
        Yn0ct0wVwKnNcfNWTT+h4Hh9o91YWm+1cKSRoYdjVWo8h8vmfxfJdUNw=
X-Received: by 2002:a17:90a:d3c9:b0:263:1e6c:16f4 with SMTP id d9-20020a17090ad3c900b002631e6c16f4mr11269481pjw.20.1689557723450;
        Sun, 16 Jul 2023 18:35:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxobN/f+m1aPkY9v/WlPtbaNRAt7AlZSB2boqi8H0Y2IutKniynY/ksoUsJno+//N8asRnNj58+SstNFfPxqk=
X-Received: by 2002:a17:90a:d3c9:b0:263:1e6c:16f4 with SMTP id
 d9-20020a17090ad3c900b002631e6c16f4mr11269473pjw.20.1689557723158; Sun, 16
 Jul 2023 18:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
 <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
 <f5a4f802-d6a1-050e-ec70-701048ab1a2f@redhat.com> <CAAd53p5nkE+QdxJwF_mEsNiEHvRwg+4D7yP77H6CDrMWPOX_zQ@mail.gmail.com>
 <615d1d62-514b-0cf4-9725-b899b06ecbc3@redhat.com>
In-Reply-To: <615d1d62-514b-0cf4-9725-b899b06ecbc3@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Jul 2023 09:35:11 +0800
Message-ID: <CAAd53p42b5+U2U3-grJp41h1XQbu5Q-3VrN+ggXTG7Mr8J_YcQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Mon, Jul 10, 2023 at 8:54=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
[snipped]
> > Or put all ACPI devices to D0 at boot?
> > According to the BIOS folks that's what Windows does.
> > This way we can drop acpi_device_fix_up_power* helpers altogether.
>
> Doing that will leave any devices for which we lack a driver at D0 for ev=
er,
> so that IMHO is not a good idea.
>
> I guess calling acpi_device_fix_up_power_extended(device) from the
> ACPI-video code, so that the connector sub-objects are put in D0 is
> somewhat ok. Although I would prefer to see you first try to do
> the same thing from the i915 driver instead.

I was told by vendor that the same design is used on AMD based laptops too.
So I think putting this in ACPI-video is a better approach.

>
> If we do end up doing this from the acpi-video code please add
> a comment above the call why this is done; and as Rafael mentioned
> the commit msg needs to better explain things too.

Sure.

Kai-Heng

>
> Regards,
>
> Hans
>
>
>
> >
> >>
> >> Also can you provide some more info on the hw on which this is being s=
een:
> >>
> >> 1. What GPU(s) is/are being used
> >
> > Intel GFX.
> >
> > AFAIK AMD based laptops also require this fixup too.
> >
> >> 2. If there is a mux for hybrid gfx in which mode is the mux set ?
> >
> > No. This happens to mux-less and dGPU-less laptops.
> >
> >> 3. Wjich method is used to control the brightness (which backlight-cla=
ss-devices show up under /sys/class/backlight) ?
> >
> > intel_backlight.
> >
> >>
> >> And can you add this info to the commit msg for the next version of th=
e patch ?
> >
> > Sure.
> > Can putting all devices to D0 be considered too? It's a better
> > solution for the long wrong.
> >
> > Kai-Heng
> >
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >>
> >>>
> >>> And yes, Linux doesn't put all of the ACPI devices into D0 during
> >>> initialization, but the above commit has a little to do with that.
> >>>
> >>>> For now explicitly call _PS0 for ACPI video to workaround the issue.
> >>>
> >>> This is not what the patch is doing.
> >>>
> >>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>> ---
> >>>>  drivers/acpi/acpi_video.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> >>>> index 62f4364e4460..793259bd18c8 100644
> >>>> --- a/drivers/acpi/acpi_video.c
> >>>> +++ b/drivers/acpi/acpi_video.c
> >>>> @@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_devi=
ce *device)
> >>>>         if (error)
> >>>>                 goto err_put_video;
> >>>>
> >>>> +       acpi_device_fix_up_power_extended(device);
> >>>> +
> >>>
> >>> I would like to know what Hans thinks about this.
> >>>
> >>>>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
> >>>>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
> >>>>                video->flags.multihead ? "yes" : "no",
> >>>> --
> >>>
> >>
> >
>
