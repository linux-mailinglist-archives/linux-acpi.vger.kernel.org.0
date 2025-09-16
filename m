Return-Path: <linux-acpi+bounces-17051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3708B5A1CD
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 22:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5A1893E1C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 20:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD5283FD0;
	Tue, 16 Sep 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGytgli2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE521FF55
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053198; cv=none; b=Eh4aKl6TEExA0uR0WR1c4Msj85kPNEz1n+4FuYMC31OGEJYCsYtx4UJjCHk1QGn4xPbBwrzp3hhsv1B7WQpgeF78O6BWq3XKuxQlI/24YSjIKpVTtfiBx2L43oVpMSSTN5VG5BqHY3Udc0pJZ7qu2vJ00wVZRqT6/h+F73IrDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053198; c=relaxed/simple;
	bh=sgYmSPXr5fJEn+ksoOyt6N70CNWy742OaZOeIXzvKEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE4JIMV7HvHNMjXkhgeRONL6xFltFYw747YmbWR8DLLu4d+FJG/NCB1GYfAERfHJEaT29FR6NrSlQdBOT+ENZ4wcXE7igx+g2Zh93ozSm4X79LVGiNtLLV+1JIR7dfgAqzxZTQi/9uir97y2MqjIOg9NByNgYInDm+xmznNf/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGytgli2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D41C19422
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758053198;
	bh=sgYmSPXr5fJEn+ksoOyt6N70CNWy742OaZOeIXzvKEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pGytgli2fZqIFFSPD4nEJRarafpTfU7+HzOmQ4CrN2CjEOk4ppBUfuubssvHpkzrF
	 Yq1Fu3JhenEJhBau9+SeBigC14UAXOKsIezP4Fx7i+c2SSYg7JmRNu0H+7xAQEjo71
	 rg7BXNu5OtLeDuJtpfEqyONbSEfwBrBKai/4f3qtNYNZFKyEs0XUriJ7IUEsVYR1l3
	 sgi7Um57l/zNJ55jX7gV8lA9nsst8AZcGh+Lr1JpsYDXDKsADdMKhLSbEKryyd1axR
	 K3vczRqSxgpFXlvYuZ6R54wUd/hu+zQa8K+QEPSaOlYmNzqghDusF5TeByeZsS7KsJ
	 /4SEXhXmAz//g==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74c7d98935eso2423957a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 13:06:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWfQjYsRRDB66ZL8EhBxGn/6S8T/Dnbk2HUQ6nZH4owJEaop7yAZVFFO7QgyrL3bz8sQnKMaDiOTqt@vger.kernel.org
X-Gm-Message-State: AOJu0YxKt5S3J7c2VuAHyEtJEICvu2IaRVAK1OHj1K38sZe5Jm6dNoLH
	iW+cIjkvJfjBjPqffxbfeztK715P6xHSDyAGSUeZ5MUc6tBYnKyBRGrvMAYp0ypKoYaUpXQzWTb
	G5Q6ySP4smHDeYDqjAEmUvVivSFw65lI=
X-Google-Smtp-Source: AGHT+IEgzjAAkbMDY4awbYDp3Kq0/fxmVwsoGjHomqpd9a5KNX9ogTaPcgxeatr4pPDlCJhtFOK6MLyI7Ue0IaNcehc=
X-Received: by 2002:a05:6808:689b:10b0:439:b491:401b with SMTP id
 5614622812f47-43b8d87c7bbmr8034409b6e.10.1758053197833; Tue, 16 Sep 2025
 13:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com> <CAJZ5v0hShKgPB42p4dOgKoRuMCkGhe+ZHMeAuFQO0Soa1ty_LQ@mail.gmail.com>
 <CAF3aWvHTXiODVE72Q33KDS51j4QA7gXVSsvdRnvsHdBv4NzCfw@mail.gmail.com>
In-Reply-To: <CAF3aWvHTXiODVE72Q33KDS51j4QA7gXVSsvdRnvsHdBv4NzCfw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Sep 2025 22:06:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTUj0zj3rZP+0iQAhsqMaLnN0K5RYpeH+ViS+GMKPHfw@mail.gmail.com>
X-Gm-Features: AS18NWDo9e7e7lAfAdBG6Gzab9UFwhygJIWaLVvGXMJwbkP1bC1WNNPO2W6V_JU
Message-ID: <CAJZ5v0gTUj0zj3rZP+0iQAhsqMaLnN0K5RYpeH+ViS+GMKPHfw@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] ACPI: DPTF: Move INT340X enumeration from DPTF
 core to thermal drivers
To: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 7:13=E2=80=AFPM S=C5=82awomir Rosek <srosek@google.=
com> wrote:
>
> Hi Rafael,
>
> First of all I would like to apologize for the late reply and thank
> you for your comments.
>
> On Mon, Sep 1, 2025 at 10:49=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Sat, Aug 30, 2025 at 7:34=E2=80=AFAM Slawomir Rosek <srosek@google.c=
om> wrote:
> > >
> > > The Intel Dynamic Platform and Thermal Framework (DPTF) relies on
> > > the INT340X ACPI device objects. The temperature information and
> > > cooling ability are exposed to the userspace via those objects.
> > >
> > > Since kernel v3.17 the ACPI bus scan handler is introduced to prevent
> > > enumeration of INT340X ACPI device objects on the platform bus unless
> > > related thermal drivers are enabled. However, using the IS_ENABLED()
> > > macro in the ACPI scan handler forces the kernel to be recompiled
> > > when thermal drivers are enabled or disabled, which is a significant
> > > limitation of its modularity. The IS_ENABLED() macro is particularly
> > > problematic for the Android Generic Kernel Image (GKI) project which
> > > uses unified core kernel while SoC/board support is moved to loadable
> > > vendor modules.
> > >
> > > This patch set moves enumeration of INT340X ACPI device objects on
> > > the platform bus from DPTF core to thermal drivers. It starts with
> > > some code cleanup and reorganization to eventually remove IS_ENABLED(=
)
> > > macro from the ACPI bus scan handler. Brief list of changes is listed
> > > below:
> > >
> > > 1) Remove SOC DTS thermal driver case from the ACPI scan handler
> > >    since its dependency on INT340X driver is unrelated to DPTF
> > > 2) Move all INT340X ACPI device ids to the common header and update
> > >    the DPTF core and thermal drivers accordingly
> > > 3) Move dynamic enumeration of ACPI device objects on the platform bu=
s
> > >    from the intel-hid and intel-vbtn drivers to the ACPI platform cor=
e
> > > 4) Move enumeration of INT340X ACPI device objects on the platform bu=
s
> > >    from DPTF core to thermal drivers using ACPI platform core methods
> > >
> > >
> > > Slawomir Rosek (12):
> > >   ACPI: DPTF: Ignore SoC DTS thermal while scanning
> > >   ACPI: DPTF: Move INT3400 device IDs to header
> > >   ACPI: DPTF: Move INT3401 device IDs to header
> > >   ACPI: DPTF: Move INT3402 device IDs to header
> > >   ACPI: DPTF: Move INT3403 device IDs to header
> > >   ACPI: DPTF: Move INT3404 device IDs to header
> > >   ACPI: DPTF: Move INT3406 device IDs to header
> > >   ACPI: DPTF: Move INT3407 device IDs to header
> >
> > Please avoid sending multiple patches with the same subject,
> > especially in one patch series.
> >
> > Thanks!
> >
>
> The subjects are quite similar but they are not exactly the same.
>
> Originally the ACPI bus scan handler was added in 3230bbfce8a9
> ("ACPI: introduce ACPI int340x thermal scan handler") to prevent
> enumeration of ACPI device objects in range INT3401~INT340B
> and only the INT3400 master device had their platform driver added
> in 816cab931f28 ("Thermal: introduce int3400 thermal driver").
>
> These days, however, each of INT3400~INT3407 device ID, representing
> a different kind of thermal device, has its own platform driver.
> Most of them, depending on X Lake generation, can also be enumerated
> on the ACPI bus using INTC1XXXX device ID. In addition INT3408~INT340B
> and some of The Wildcat Lake device IDs are not supported by any
> platform driver.
>
> To make the review process easier and minimize the risk of mistakes
> I decided to create separe patch for each ID in range INT3400~INT3407.
> The INT3400, INT3404 and INT3407 device ID can probably be renamed to
> Thermal Core, Fan and Power device ID, respectively, but I am not sure
> about the others.
>
> Alternatively they can be squashed into a single patch which moves
> all INT340X device IDs to the common header.

Yes, please.

