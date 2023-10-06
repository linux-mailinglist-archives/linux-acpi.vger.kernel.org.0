Return-Path: <linux-acpi+bounces-492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A47BC064
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EA0281D98
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD24446A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959834180
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 19:20:33 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF45E95
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 12:20:31 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57de3096e25so461637eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Oct 2023 12:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696620031; x=1697224831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOOUvSMOOU9GGN5d6OGDoBPreZPUMrC/Z6udXYN5U9U=;
        b=a4U6bAaglKigSq/cqvT+igULT6nbo73wB9nJw0Lh6hdlTbG/78w/ewXx1KtavTQzOr
         LQTbuLedqrO3IB+RVtIlwjUFEorjaCAizBpsip61FgR1458kBbA0ZqOJ2hqqI5mG8YAI
         MwdGRCcbii4ZY8OML+Z+bOgEoMPSIny4BU1xEVy3yOnnlSY/wSr3SJ0kow+R4kH2KXA2
         fXpriWkx2N0KBRQdMgx0Q7ZNlM3OAUaQBulJAmzAjtiGU81tb7Nxnl0B/s7e9esgLSYb
         LV3Cc432Q7tyGY15QyPGavl6z4S+vWCu2Yc/hCNoYIiubhA1NUs1rkPIpHAGW0YoDRDs
         f86A==
X-Gm-Message-State: AOJu0Yy9be846UiSaJVeohDoS6Dzv8scPcCXekQqMVIa6TxrlcjdfTy9
	QdzoFg1L7aAWqnG4xYt2LrqnMbCUp0T53XF0iSU=
X-Google-Smtp-Source: AGHT+IGUTz+ETdcSbhQvUkmA+BNXFiU/YIqqaiEJLlwRl5pTXxogA54hRQFHIFor3YiRdWlqNT9gQFGUfKw49zK/Zic=
X-Received: by 2002:a4a:c509:0:b0:57e:c9bf:696e with SMTP id
 i9-20020a4ac509000000b0057ec9bf696emr9013268ooq.1.1696620030849; Fri, 06 Oct
 2023 12:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006123304.32686-1-hdegoede@redhat.com> <ed4672a7-439c-4240-aadc-7a36858c36b2@augustwikerfors.se>
 <9a905931-6210-8f6b-92f5-3c863d4a2e86@redhat.com>
In-Reply-To: <9a905931-6210-8f6b-92f5-3c863d4a2e86@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Oct 2023 21:20:19 +0200
Message-ID: <CAJZ5v0gK1Q54sMRJJJBTf+gY5jd-_57jYKvN5ELNSpmaeVVjAw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and
 GM6BG0Q to irq1_edge_low_force_override[]
To: Hans de Goede <hdegoede@redhat.com>
Cc: August Wikerfors <git@augustwikerfors.se>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Mario Limonciello <Mario.Limonciello@amd.com>, linux-acpi@vger.kernel.org, 
	Francesco <f.littarru@outlook.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 5:17=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi August,
>
> On 10/6/23 16:18, August Wikerfors wrote:
> > Hi Hans,
> >
> > On 2023-10-06 14:33, Hans de Goede wrote:
> >> The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a Tong=
Fang
> >> barebone design which is sold under various brand names.
> >>
> >> The ACPI IRQ override for the keyboard IRQ must be used on these AMD Z=
en
> >> laptops in order for the IRQ to work.
> >>
> >> Adjust the irq1_edge_low_force_override[] DMI match table for this:
> >>
> >> 1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pr=
o 16
> >>     entry for the GM6BGEQ (RTX3050 GPU) model so that it will also mat=
ch
> >>     the laptop when sold by other vendors such as hyperbook.pl.
> >>
> >> 2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX406=
0)
> >>     models.
> >>
> >> Suggested-by: August Wikerfors <git@augustwikerfors.se>
> >> Reported-by: Francesco <f.littarru@outlook.com>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217394
> >> Link: https://laptopparts4less.frl/index.php?route=3Dproduct/search&fi=
lter_name=3DGM6BG
> >> Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
> >> Link: https://linux-hardware.org/?probe=3Dbfa70344e3
> >> Link: https://bbs.archlinuxcn.org/viewtopic.php?id=3D13313
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Since this is a regression fix for 453b014e2c29 ("ACPI: resource: Fix I=
RQ override quirk for PCSpecialist Elimina Pro 16 M") (for PCSpecialist sys=
tems like Francesco's with product name "Elimina Pro 16 M" but not board na=
me "GM6BGEQ") and 2d331a6ac481 ("ACPI: resource: revert "Remove "Zen" speci=
fic match and quirks"") (for other vendors using the same TongFang design),=
 it should have a "Fixes:" tag for at least one of those.
> >
> > Both of those commits are in 6.5 (and 6.6-rc) so this should go into 6.=
6-rc and be backported to 6.5, but the patch seems to depend on 424009ab203=
0 ("ACPI: resource: Drop .ident values from dmi_system_id tables") and mayb=
e also d37273af0e42 ("ACPI: resource: Consolidate IRQ trigger-type override=
 DMI tables") to apply cleanly, which seem to only be queued for linux-next=
/6.7? I'm not familiar with what the correct process is for such cases.
>
> You are right:
>
> Fixes: 453b014e2c29 ("ACPI: resource: Fix IRQ override quirk for PCSpecia=
list Elimina Pro 16 M")

OK

> Note likewise this commit should really also be send as a fix
> for 6.6 and backported to the stable kernels:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/drivers/acpi/resource.c?h=3Dbleeding-edge&id=3Dc1ed72171ed580fbf159e703b7=
7685aa4b0d0df5

That's harder, because it does depend on commit 424009ab2030 ("ACPI:
resource: Drop .ident values from dmi_system_id tables") which is not
6.6-rc material IMV.

So I'm going to queue this up with the Fixes tag above and Cc: stable
pointing to commit 424009ab2030 as a dependency, but for 6.7.

