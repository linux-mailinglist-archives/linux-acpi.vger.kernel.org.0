Return-Path: <linux-acpi+bounces-12555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3AFA7654C
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8929188B225
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C61DF273;
	Mon, 31 Mar 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSnsAHZ8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092B155393;
	Mon, 31 Mar 2025 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743422570; cv=none; b=M8OfjDZWode6XBzTsLQXJaaw4op5qPdZNN37pb80NnuY9dtYPUA/QYfkXLFKHEaTvPUbni1fN/ZwERY9XrqAiW3wYDv6qJ5/Ej3NGyTYZdR34ppB8DzJgF/vVTNTk8DkzT84+j9XVTw4+2W8UtfPX0XA/lLWxz3siHtDpudg9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743422570; c=relaxed/simple;
	bh=PL9eSqKHOu/dlIWfnxn/TfZ0nJbbzG4XeD7K4BWteb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HISv3AkO03YiT4FJYRm95TbzKPudzpzT/j1EYes1bGrOaxXOCQJsB5VVa+hKm6T+uj2Q5xQ2FwNptG7LzjoOsqF6Yr5AgEJNwox/RUOf52kG8YBfZLgBBbhSftb6wFpQJUZ/reD4Vong22IVPkaFhoAk2wKLU+rcFkGtA3jbrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSnsAHZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F20C4CEED;
	Mon, 31 Mar 2025 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743422569;
	bh=PL9eSqKHOu/dlIWfnxn/TfZ0nJbbzG4XeD7K4BWteb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eSnsAHZ8fcmCBVIPW5/3MtPKJG28EGKqZoln0hs2Z0NGV2j7wVktZED/CjwZfZDnB
	 /d1lsFfrlh1yDZMocTnQnF7tyYVRST+KU2xHeKIjY/yIZ3NoNRrZ1+XysF+67lGOYR
	 iUheCr+vYkxAcKv0uGA6WHt4VNw0FpA2bndfAICaMuStA29jywDk0q3NEwLvGyTjWc
	 wetd3cSwePbD08PD5MdZTFodgN0ybjM77mIKVmWemaKQ2o93Jv6zG7ytOMnM/+FihK
	 JiKiAq/54Lfb+w10R521wTED1dL5KI43J53HJ/PwgqvD4XxDcnUqaO0XSJTsldvoLq
	 cgfKdAA90kS7w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso2687968fac.0;
        Mon, 31 Mar 2025 05:02:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWEVvDZ9AsSeyYIV1/UhEB7rca6yL02vBZQWZmXWsBrew9VWoZ9ks4UtimqqL33mDKnDjokrYKKWBfhNIY@vger.kernel.org, AJvYcCXKHbPHDyuphZtYt9G4zpRiUKmlHeXHj6hiMkRsWVpuCZB3SO6FFdZZ3gxAR/AbVvwAo7/yAi6UMYkX@vger.kernel.org, AJvYcCXPsIf0zWaiPMQY7aa8juW5slnfpXsfmYPBEBXFhV/rVtgk1wKIHrvyXW/D1VnLlQhZLkXumAsWj84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDST7h5yDe3IP//baGmpLPkgIz5Ggny821WMBKdmnbwjprbxI
	fzlhjOk4YOg4uvS/X3ZocKUXYnE+61twDLcfRHUZUpY8wS9inQnQnW6j8qSvF6P9TVVJC+kVo7M
	4NTDs+Iadx45chXFsnbAFWh4v6Jc=
X-Google-Smtp-Source: AGHT+IFnxwbIR38R3P0W2nuk1c+/yzug2edBWqFS7sb8O2cuqgfmBB0P3C0t0MUSle+/fFxcXPC7bpatmMaFUzvTnAs=
X-Received: by 2002:a05:6870:ff8a:b0:2c8:340d:1076 with SMTP id
 586e51a60fabf-2cbcf7e01e5mr5298272fac.32.1743422568784; Mon, 31 Mar 2025
 05:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328143040.9348-1-ggherdovich@suse.cz> <55bc62e588f526ae964533cf2af612a4beea5d32.camel@intel.com>
In-Reply-To: <55bc62e588f526ae964533cf2af612a4beea5d32.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 14:02:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ic-07asu50EMwFV5DyXtjT7rArdcsap1C3n8m4SwKx_A@mail.gmail.com>
X-Gm-Features: AQ5f1JpdcuMZQmRSP49PHnPr0UtmSQDJJYsk8bKXnck5QUYOObX8X-4duTh9WhU
Message-ID: <CAJZ5v0ic-07asu50EMwFV5DyXtjT7rArdcsap1C3n8m4SwKx_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: processor: idle: Return an error if both
 P_LVL{2,3} idle states are invalid
To: "Zhang, Rui" <rui.zhang@intel.com>, "ggherdovich@suse.cz" <ggherdovich@suse.cz>
Cc: "rafael@kernel.org" <rafael@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 3:09=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Fri, 2025-03-28 at 15:30 +0100, Giovanni Gherdovich wrote:
> > Prior to commit 496121c02127e9c460b436244c38260b044cc45a ("ACPI:
> > processor:
> > idle: Allow probing on platforms with one ACPI C-state"), the
> > acpi_idle
> > driver wouldn't load on systems without a valid C-State at least as
> > deep
> > as C2. The behavior was desirable for guests on hypervisors such as
> > VMWare
> > ESXi, which by default don't have the _CST ACPI method, and set the
> > C2 and
> > C3 latencies to 101 and 1001 microseconds respectively via the FADT,
> > to
> > signify they're unsupported.
> >
> > Since the above change though, these virtualized deployments end up
> > loading
> > acpi_idle, and thus entering the default C1 C-State set by
> > acpi_processor_get_power_info_default(); this is undesirable for a
> > system
> > that's communicating to the OS it doesn't want C-States (missing
> > _CST, and
> > invalid C2/C3 in FADT).
> >
> > Make acpi_processor_get_power_info_fadt() return ENODEV in that case,
> > so
> > that acpi_processor_get_cstate_info() exits early and doesn't set
> > pr->flags.power =3D 1.
> >
> > Fixes: 496121c02127 ("ACPI: processor: idle: Allow probing on
> > platforms with one ACPI C-state")
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>
> LGTM.
>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Applied as 6.15-rc material, thanks!

> > ---
> >  drivers/acpi/processor_idle.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/acpi/processor_idle.c
> > b/drivers/acpi/processor_idle.c
> > index 586cc7d1d8aa..b181f7fc2090 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -268,6 +268,10 @@ static int
> > acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
> >                        ACPI_CX_DESC_LEN, "ACPI P_LVL3 IOPORT
> > 0x%x",
> >                        pr->power.states[ACPI_STATE_C3].address);
> >
> > +     if (!pr->power.states[ACPI_STATE_C2].address &&
> > +         !pr->power.states[ACPI_STATE_C3].address)
> > +             return -ENODEV;
> > +
> >       return 0;
> >  }
> >
>

