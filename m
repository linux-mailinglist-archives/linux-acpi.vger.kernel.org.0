Return-Path: <linux-acpi+bounces-19724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6273CD120D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE901306FE6D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613C31ED94;
	Fri, 19 Dec 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZHsFLCU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6528689A
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164956; cv=none; b=oedQRu0PIZD98Bc2VO4FjY5zgDbFuBMRF/u9FkzfuWJw5xBxzglO5b7RFu+vBOUFjwfFLFyKQYUjejrAGll8UDdsdVT3f0/CzQIiKB+UNECaibU2EY3P1aWcHguA8ec8p+unkhRgNoCa1K7VttfxwJl1PMf5cA5dG5O4qDIDOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164956; c=relaxed/simple;
	bh=51v80vuIoLBHyp+xqmm+MZ/h09/A74izSzDgSNSD8JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHL77MgLtD8AzmCy6DwdH5WagCKutXaqiMvtFDybXZmEbNuMA7HbSImH6K8AOLexSW+tPtZfOwczn1guEzT5l3uoio6y2P9k6e2lde6da5BjNpPS53ffePiCHIGE1ZGJBIDj+spz89V8cvbMtRR/En3EfeuX2BSFhdxeUlZxkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZHsFLCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43305C4CEF1
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766164956;
	bh=51v80vuIoLBHyp+xqmm+MZ/h09/A74izSzDgSNSD8JA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SZHsFLCUG5iOsa0xFmemdqpHdQ0IjuSeQoz/Hn3FCIwpt3sJ7Bqay6a2XLywkCGns
	 pHuD4zMqFg4sAe5rCTVlJoG0mNLzYI42y9PBtloWhbs8z3i0pwXIgxtWSBkV9OVQdL
	 b8E1kk5ewORYSYxDMAgREC6hEhSa8HUDScFc2avREtTnME8NkfzXB7POk1LrBWAAt2
	 mW4AwT3J4phxbEYkGJ4KSEsOsQTdkE+TJb0SfW7gFAy+LDCOT9kORrlMZceUey99FC
	 p0ti0RkNC+TgkNxElcvxuKywrlWzD+MZ/a8tXTEray1JYaaOeMHKBY0vnGEAiuVZ+S
	 CWtEFWu8o+JzQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6579872f00dso993677eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 09:22:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd1+2sUdqIBN67WCTrDpluo/drIOvrhOh4Jok0P5eBXsq4Py4HAL6+v/mQgW6p6jPBzt/BluUUA9vT@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFmgAVkycryshZDB/TEJhR9Lk0eKdrUBF2I0XjSkePaPlt4LC
	MMERMqMhJi1g+hFLwCfLeymCcnQFQupgd7g+Y9lQBH3xZhRfNdnI6oAz9tnBaVRM6L5aDlxSb8/
	/z3wFYIXcrMSy9PBStEGO8GWGEpff9Gg=
X-Google-Smtp-Source: AGHT+IEPziboAv0SjFN6LRGSAEPjVo0OdDZx8uWJVKPI0XREcCFfiC22XnVGk0v8QKC/wFrNMUW+AHnsnQF7xdeDQko=
X-Received: by 2002:a05:6820:22a6:b0:659:9a49:9009 with SMTP id
 006d021491bc7-65d0ea7234dmr1596923eaf.54.1766164955384; Fri, 19 Dec 2025
 09:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049211.GXAFRqVoOG@rafael.j.wysocki> <3407425.44csPzL39Z@rafael.j.wysocki>
 <20251219124409.00002f4e@huawei.com>
In-Reply-To: <20251219124409.00002f4e@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Dec 2025 18:22:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gS1yvORG_+Z80y6McBhu_QLNfY7-RqJKZ1HjGevzGJFQ@mail.gmail.com>
X-Gm-Features: AQt7F2pQuubjq7dHC5JuGMZJBDhFiLI8iYB6uMa5VMISG27dVolh_1x_vPmFnHY
Message-ID: <CAJZ5v0gS1yvORG_+Z80y6McBhu_QLNfY7-RqJKZ1HjGevzGJFQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] ACPI: bus: Split _OSC evaluation out of acpi_run_osc()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:44=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 18 Dec 2025 21:36:08 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Split a function for evaluating _OSL called acpi_eval_osc() out of
>
> _OSC

Yup, thanks!

> > acpi_run_osc() to facilitate subsequent changes and add some more
> > parameters sanity checks to the latter.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> One comment on the fun static keyword usage.  Next time I have
> to ask/answer some silly C questions in an interview that one is definite=
ly going
> in :)
> > ---
> >  drivers/acpi/bus.c |   89 ++++++++++++++++++++++++++++++--------------=
---------
> >  1 file changed, 52 insertions(+), 37 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -195,52 +195,67 @@ static void acpi_dump_osc_data(acpi_hand
> >                        OSC_INVALID_REVISION_ERROR | \
> >                        OSC_CAPABILITIES_MASK_ERROR)
> >
> > -acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *=
context)
> > +static int acpi_eval_osc(acpi_handle handle, guid_t *guid, int rev,
> > +                      struct acpi_buffer *cap,
> > +                      union acpi_object in_params[static 4],
>
> This static usage has such non intuitive behavior maybe use
> the new at_least marking in compiler_types.h to indicate
> what protection against wrong sizes it can offer.

I'll have a look at that, thanks!

