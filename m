Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6475CAE5
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjGUPGO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGUPGM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 11:06:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8FF30EA
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 08:06:06 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A3DA83F18F
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689951964;
        bh=kl/e4UOsgyTgpZR041CkgQMtj/G2F+aKue0ZM+n3D1I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JeCRC6XHDs/rMWvYfoM+siY6Di/fTK+g7xk0hjMauEAWkA0brkcjzwOeZaRxIKmO0
         jLITM/2fh1hBbWZ8Qd4GcYFSHmDuxuA2xXGV8snw0CtxnJnH6ejs0fnArndpCFWcGo
         pSwteitFjkPIoQDbCXEVeD7ZVWX5NKARWLRbnyikIwOej4jhT25LnyLm4oQHXvQfl8
         h68p/uaWrx4zl2OdPre8trtaOype8HJg+fVDmRshdegoILuHlOXvvFXBzoPwOQrU7I
         0sQhaZZYxCgoLP2qKctI83JyhCE7/W4lFcUFRdn6bmQ/bu6WsAEWM3G8BASVKj4A3T
         vwacG+roqPNLg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26337f5d2daso1521252a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 08:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951963; x=1690556763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl/e4UOsgyTgpZR041CkgQMtj/G2F+aKue0ZM+n3D1I=;
        b=BWDS7I+NBMIUVzBBBol9osiPg9EaC1mkoJ/Y0/kNabyiD5YYjOomjr2pxfhHvnRBMq
         dCk1t0Dq8mrLcI+0rJ1OM6z5FJUb7aF69u5gvlNRXLYgzDP4cJcnmWeJZlzWAQ1+LQIX
         JacKmB1kgRHCaLa0SAoM6qy6TgoT/t6tT1hLHvROiPK/m4Ti0FHqkMd89LrS54kjmc09
         O1KG58W+UaX2ovNFDBdvQY3Qbgbc4CNzRTMtUAH+CDhFgaUtKHJ/ZvctODBHmz2DGAW1
         Hft0jCAhzBUSYyPcKn7HyJOXa3nqwtP7sqYYwXS98+ptgw27M2zeS/yubtLaF8pm7cXr
         eQgw==
X-Gm-Message-State: ABy/qLaD0NEj28brQCcIqGm1V64fZCOVSibYITLl027TgQ8DRYHS+top
        Mg3x6Q0pt3lBmGDzLwS3JpZS7umrLVLyBe3k9XwMS7yAwgSWN06jFUAI1ZxgnXop1P2bnDGafJc
        ToagQndyIT1JT9VXoCuM9SMZzPHi4EhM/3iPUOKgFxxJUCeTUBfQI7/o=
X-Received: by 2002:a17:90b:3852:b0:263:41d2:4e2 with SMTP id nl18-20020a17090b385200b0026341d204e2mr1985849pjb.32.1689951963235;
        Fri, 21 Jul 2023 08:06:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQG+8sAZFcshpgpSEmzvsz19YGr20QEN6gLymdh7VMikSISNxL1N3LszadWnJqVhvZ1lNIBLfj/PJsI0BVVTQ=
X-Received: by 2002:a17:90b:3852:b0:263:41d2:4e2 with SMTP id
 nl18-20020a17090b385200b0026341d204e2mr1985815pjb.32.1689951962778; Fri, 21
 Jul 2023 08:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230719023223.2971481-1-kai.heng.feng@canonical.com> <CAJZ5v0g4ngM4Z_nvzMfdgsMjjjc2QXkr-ZGxZBzDufbrqO6Kvw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g4ngM4Z_nvzMfdgsMjjjc2QXkr-ZGxZBzDufbrqO6Kvw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jul 2023 23:05:51 +0800
Message-ID: <CAAd53p5+3GOu9cCob2FiYEtSVCHEsJQi72PDkotK7FniwVpETg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Put ACPI video and its child devices to
 D0 at boot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, hdegoede@redhat.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2023 at 1:32=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jul 19, 2023 at 4:33=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Screen brightness can only be changed once on some HP laptops.
> >
> > Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
> > for all ACPI devices:
>
> No, it doesn't and it won't.  For the reason why please see the
> comment in acpi_bus_init_power().

Understood.

>
> BTW, missing _PSC for a device that has _PS0 violates Section 7.3.6.
> _PSC (Power State Current) of the ACPI specification, so this is a
> platform firmware problem.

This means most if not all platforms have this problem.

>
> >     Scope (\_SB.PC00.GFX0)
> >     {
> >         Scope (DD1F)
> >         {
> >             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
> >             {
> >                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
> >                 {
> >                     \_SB.PC00.LPCB.EC0.SSBC ()
> >                 }
> >             }
> >             ...
> >         }
> >         ...
> >     }
> >
> > The \_SB.PC00.GFX0.DD1F is the panel device, and its _PS0 needs to be
> > executed to make the brightness control work properly.
> >
> > _PS0 doesn't get invoked for all ACPI devices because of commit
> > 7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
> > during initialization"). For now use acpi_device_fix_up_power_extended(=
)
> > to put ACPI video and its child devices to D0 to workaround the issue.
>
> The above paragraph is misleading the reader into thinking that the
> issue was introduced by a kernel change while the issue really is
> there in the platform firmware and it is the missing _PSC.
>
> Blaming kernel changes for platform firmware defects is not really produc=
tive.

Right, I'll reword the message and make it clear that it's firmware's issue=
.

>
> So this really is a workaround for defective platform firmware on the
> affected systems and it should be documented as such.

Sure.

>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217683
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Wording
> >  - Bugzilla
> >  - Add comment
> >
> >  drivers/acpi/acpi_video.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 62f4364e4460..bac614e9fe56 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -2027,6 +2027,13 @@ static int acpi_video_bus_add(struct acpi_device=
 *device)
> >         if (error)
> >                 goto err_put_video;
> >
> > +
> > +       /*
> > +        * Some HP laptops require ACPI video's child devices have _PS0
> > +        * evaluated to have functional panel brightness control.
>
> So the comment should mention the platform firmware defect and it
> shouldn't say "some" but explicitly identify the defective platforms.

OK.

>
> > +        */
> > +       acpi_device_fix_up_power_extended(device);
> > +
>
> And the code change itself is simple enough, so it can be made as long
> as it is fine with Hans.

OK.


Kai-Heng

>
> >         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
> >                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
> >                video->flags.multihead ? "yes" : "no",
> > --
