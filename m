Return-Path: <linux-acpi+bounces-513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8F7BCE56
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Oct 2023 14:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ED82817F1
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Oct 2023 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2505C13F
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Oct 2023 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BACBE7F
	for <linux-acpi@vger.kernel.org>; Sun,  8 Oct 2023 12:17:06 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6755BA
	for <linux-acpi@vger.kernel.org>; Sun,  8 Oct 2023 05:17:03 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c61dd1c229so960928a34.0
        for <linux-acpi@vger.kernel.org>; Sun, 08 Oct 2023 05:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696767423; x=1697372223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odxjl/aijwDjkxzS8boDazUlR5StFzwCzOin2WOA178=;
        b=KI7JYlJc7MyTCJxLrsKGxFC/Wqa7UELQPU8vFZLa1CKodLO55i6STGoSfOsWRQHIYr
         Kw0hkb2loekEJWHIrNNczrnYXiNJxbNbdxGHvvgHCgEDFBh8WGQYFTWKH2K2dq/p/ve+
         FmXYcaXKofOtBq9yr+CTy6wfESAPfUraxobYNLTcv1U3m5uCFnKU5sqBdcaAZZpWTbep
         GSAl+QXj/KWFSgSN0H7tZxE+RgO01M4SGRbqa+FqR9hx7hxSGn3Xk5sx84WeyAT5b+5z
         Eed+ovZZj2XGh0qS6rLd5f075/FfhhwVi9xZzLaflJ8wrY0qxPZ/kZm5sAIXBkYZRxH5
         mHeg==
X-Gm-Message-State: AOJu0YzQrSPIuV3NXUHLO/mzy8GOh2by2d6OycHAawDC/4Si73m46PdF
	YIEIDIl9Uvl/5KAl9I2SjA2+L7dP4M7wN7cvI7Q=
X-Google-Smtp-Source: AGHT+IFnafo6ttT4xaY95LXuiwRwhcCXlBCWIwkqA3FgFK+AvY0orBJ/viALcLXMs8MhHXO8IyBzdUgPlHpDMur0O1A=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr11355483oot.0.1696767422823; Sun, 08 Oct
 2023 05:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006123304.32686-1-hdegoede@redhat.com> <ed4672a7-439c-4240-aadc-7a36858c36b2@augustwikerfors.se>
 <9a905931-6210-8f6b-92f5-3c863d4a2e86@redhat.com> <CAJZ5v0gK1Q54sMRJJJBTf+gY5jd-_57jYKvN5ELNSpmaeVVjAw@mail.gmail.com>
 <026f8034-0b0e-9c77-f547-7f883b9b8bc1@redhat.com>
In-Reply-To: <026f8034-0b0e-9c77-f547-7f883b9b8bc1@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 8 Oct 2023 14:16:49 +0200
Message-ID: <CAJZ5v0gYc7OePFzLLA2NTEzRy1DU+L86gE80vtBT6Jz4DBO1nA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and
 GM6BG0Q to irq1_edge_low_force_override[]
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, August Wikerfors <git@augustwikerfors.se>, 
	Mario Limonciello <Mario.Limonciello@amd.com>, linux-acpi@vger.kernel.org, 
	Francesco <f.littarru@outlook.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 10:51=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Rafael,
>
> On 10/6/23 21:20, Rafael J. Wysocki wrote:
> > On Fri, Oct 6, 2023 at 5:17=E2=80=AFPM Hans de Goede <hdegoede@redhat.c=
om> wrote:
> >>
> >> Hi August,
> >>
> >> On 10/6/23 16:18, August Wikerfors wrote:
> >>> Hi Hans,
> >>>
> >>> On 2023-10-06 14:33, Hans de Goede wrote:
> >>>> The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a To=
ngFang
> >>>> barebone design which is sold under various brand names.
> >>>>
> >>>> The ACPI IRQ override for the keyboard IRQ must be used on these AMD=
 Zen
> >>>> laptops in order for the IRQ to work.
> >>>>
> >>>> Adjust the irq1_edge_low_force_override[] DMI match table for this:
> >>>>
> >>>> 1. Drop the sys-vendor match from the existing PCSpecialist Elimina =
Pro 16
> >>>>     entry for the GM6BGEQ (RTX3050 GPU) model so that it will also m=
atch
> >>>>     the laptop when sold by other vendors such as hyperbook.pl.
> >>>>
> >>>> 2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4=
060)
> >>>>     models.
> >>>>
> >>>> Suggested-by: August Wikerfors <git@augustwikerfors.se>
> >>>> Reported-by: Francesco <f.littarru@outlook.com>
> >>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217394
> >>>> Link: https://laptopparts4less.frl/index.php?route=3Dproduct/search&=
filter_name=3DGM6BG
> >>>> Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
> >>>> Link: https://linux-hardware.org/?probe=3Dbfa70344e3
> >>>> Link: https://bbs.archlinuxcn.org/viewtopic.php?id=3D13313
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>> Since this is a regression fix for 453b014e2c29 ("ACPI: resource: Fix=
 IRQ override quirk for PCSpecialist Elimina Pro 16 M") (for PCSpecialist s=
ystems like Francesco's with product name "Elimina Pro 16 M" but not board =
name "GM6BGEQ") and 2d331a6ac481 ("ACPI: resource: revert "Remove "Zen" spe=
cific match and quirks"") (for other vendors using the same TongFang design=
), it should have a "Fixes:" tag for at least one of those.
> >>>
> >>> Both of those commits are in 6.5 (and 6.6-rc) so this should go into =
6.6-rc and be backported to 6.5, but the patch seems to depend on 424009ab2=
030 ("ACPI: resource: Drop .ident values from dmi_system_id tables") and ma=
ybe also d37273af0e42 ("ACPI: resource: Consolidate IRQ trigger-type overri=
de DMI tables") to apply cleanly, which seem to only be queued for linux-ne=
xt/6.7? I'm not familiar with what the correct process is for such cases.
> >>
> >> You are right:
> >>
> >> Fixes: 453b014e2c29 ("ACPI: resource: Fix IRQ override quirk for PCSpe=
cialist Elimina Pro 16 M")
> >
> > OK
> >
> >> Note likewise this commit should really also be send as a fix
> >> for 6.6 and backported to the stable kernels:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/co=
mmit/drivers/acpi/resource.c?h=3Dbleeding-edge&id=3Dc1ed72171ed580fbf159e70=
3b77685aa4b0d0df5
> >
> > That's harder, because it does depend on commit 424009ab2030 ("ACPI:
> > resource: Drop .ident values from dmi_system_id tables") which is not
> > 6.6-rc material IMV.
> >
> > So I'm going to queue this up with the Fixes tag above and Cc: stable
> > pointing to commit 424009ab2030 as a dependency, but for 6.7.
>
> I realize that I'm the architect of this whole mess, but delaying
> these new quirks to 6.7 does not seem like a good idea to me.
>
> This fixes a serious problem (kbd not working pretty much makes
> the whole laptop unusable under Linux at least on the road). With
> a very small chance of regressions since this is DMI match base.
>
> Maybe we can just take all the resource.c DMI quirk changes
> as fixes to 6.6 ?  I admit the:
>
> "ACPI: resource: Consolidate IRQ trigger-type override DMI tables"
> "ACPI: resource: Drop .ident values from dmi_system_id tables"
>
> patches are not really bugfixes. But they too have a very low
> chance of causing regressions.
>
> Regards,
>
> Hans
>
>
> p.s.
>
> Note that "ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA"
> should probably go as a fix to 6.6 regardless of the discussion since
> that is a pure bugfix which applies cleanly on top of 6.6

That can be done.

> And the same goes for this (unrelated) drivers/acpi/ec.c patch:
>
> "ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx"

That can be done too.

> That too is a pure bugfix which IMHO should go to 6.6 as such.

But if you want the $subject patch to go into 6.6-rc, please rebase it
on top of the latest 6.6-rc and resubmit.  It will not apply cleanly
on top of the current linux-next, but I can handle the merge conflict.

