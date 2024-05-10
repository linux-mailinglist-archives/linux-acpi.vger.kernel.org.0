Return-Path: <linux-acpi+bounces-5756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF38C29A5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A541F20FE3
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536B1C6B5;
	Fri, 10 May 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHOSuOGc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1927182C3;
	Fri, 10 May 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364070; cv=none; b=T08QFvTJ61ohH58+9CjOGk/k90NgSrJ8QgOMyNNYwG+eK6mzRFFOIrxRPSp4PuaX+ZJvLTD50IOy0oujeMgdhgm6SfMW1MFJA3KzH0wEWIEplLdxsvIJSNnaznNkNGKjA3ifXdIGCXBieYzLl3j24mG6U9IxOcAznzMH5KjsF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364070; c=relaxed/simple;
	bh=s5ik5p4oyGVznfPViE0HOJRAYlX1f0xzznl1M2KmICc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KO6711YBKVHG3flbuuocmbXrvKgnNeQ6BP6cQ54BdDYqBUiM9/oZi68knDlXrZ6ipP6AHStELuSBOIXpIEomVvF6z4SY4UW/WjEldLvUaFPWoJvS3HPW02ZTrpytxiUvUiMjZY2/itAohdZ32wK7Cmm2BrvkWrDvHgodhT52aJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHOSuOGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7634EC32783;
	Fri, 10 May 2024 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715364069;
	bh=s5ik5p4oyGVznfPViE0HOJRAYlX1f0xzznl1M2KmICc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dHOSuOGcjSMLUBk4OGaPgzR1AzzYjLgLpcJihdGJLZ6V5YBWKA36ja43qkVRmbH6K
	 qUSkyDHH4HG/M4TMjcvuWf6jHtdlTGywIJ9bha956hsEZ8I6aukppx6VwnAXFpDa6h
	 /kn/9TPJROUBe5E39BQGShoa8x0hCzxyCGkWZvoyZbHpfRHC/lj8ruPUz28KxIjWoy
	 a//BS7YsD+G/r3W+Yr1uenw+51Tw3Se5dHHf3Rq8wIsP6hHKM4kgIH9Mb47N9jnSGb
	 IeXzQG2vxBwQTfkU+Ps9xYuEZo8kK66Hw0Lsa03vraYRMSSF/TkmuRqrVPo/iCkL6a
	 hKgy9jVXRalmw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b209a2c390so319118eaf.1;
        Fri, 10 May 2024 11:01:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwfnB4bFnTUl6dV9AQQ7dgcWt4tO2tpYXb4hymHpZAsOl1HtirOI7G0n+sAJSw0xtnu7o8xDH1plrvFjHXVCmcFkK67xOqdvTupvo0aniYKJ5WlIAoGsLyhtgn0zCtmgwthXtz15ibbg==
X-Gm-Message-State: AOJu0YyW8ZEpl3hbeLUShcmB1wF53z33xiGTZAYFMWruDmt2Llmu9j/U
	JWoyFAdHIK6JXBzwuqB9kwK1UHieVuEn14TQFsr2V8drItB3+m0LYVmC2ETJDx+2bC/hFyxcdRr
	d1tFhtNGP9XszTTIwfy7nDPcgaAs=
X-Google-Smtp-Source: AGHT+IF4yLHiIjhz1LXKq8uZ2Dk0r6aefVa6ZG534N29daSlBn5H8BdUL1FzfjYKL2VL6yjXtoda4hNGvF14YdDZQrA=
X-Received: by 2002:a4a:d692:0:b0:5b2:f29:93f0 with SMTP id
 006d021491bc7-5b2815e3c4dmr3690279eaf.0.1715364068757; Fri, 10 May 2024
 11:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de> <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de> <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
 <22937f20-93fd-4ae2-a5cb-31e5a477ac37@gmx.de>
In-Reply-To: <22937f20-93fd-4ae2-a5cb-31e5a477ac37@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 May 2024 20:00:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iC_DNTj38eCPywgG3v_pkOVOhY9itdgX09AJ7U3yRB4Q@mail.gmail.com>
Message-ID: <CAJZ5v0iC_DNTj38eCPywgG3v_pkOVOhY9itdgX09AJ7U3yRB4Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Armin Wolf <W_Armin@gmx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 7:39=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 10.05.24 um 19:29 schrieb Andy Shevchenko:
>
> > On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
> >> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
> >>> On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> >>>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
> >>>>
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>
> >>>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Len=
ovo
> >>>>> IdeaPad Pro 5 due to a missing address space handler for the EC add=
ress
> >>>>> space:
> >>>>>
> >>>>>     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [Em=
beddedControl] (20230628/evregion-130)
> >>>>>
> >>>>> This happens because the EC driver only registers the EC address sp=
ace
> >>>>> handler for operation regions defined in the EC device scope of the
> >>>>> ACPI namespace while the operation region being accessed by the _DS=
M
> >>>>> in question is located beyond that scope.
> >>>>>
> >>>>> To address this, modify the ACPI EC driver to install the EC addres=
s
> >>>>> space handler at the root of the ACPI namespace.
> >>>>>
> >>>>> Note that this change is consistent with some examples in the ACPI
> >>>>> specification in which EC operation regions located outside the EC
> >>>>> device scope are used (for example, see Section 9.17.15 in ACPI 6.5=
),
> >>>>> so the current behavior of the EC driver is arguably questionable.
> >>>> Hi,
> >>>>
> >>>> the patch itself looks good to me, but i wonder what happens if mult=
iple
> >>>> ACPI EC devices are present. How would we handle such a situation?
> >>> I'm wondering if this is a theoretical question or do you have any
> >>> existing or planned systems in mind?
> >>>
> >>> ec_read(), ec_write() and ec_transaction() use only the first EC that
> >>> has been found anyway.
> >> Its a theoretical question, i do not know of any systems which have mo=
re than
> >> one ACPI EC device.
> > The specification is clear about this case in the "ACPI Embedded Contro=
ller
> > Interface Specification":
> >
> >   "The ACPI standard supports multiple embedded controllers in a system=
,
> >    each with its own resources. Each embedded controller has a flat
> >    byte-addressable I/O space, currently defined as 256 bytes."
> >
> > However, I haven't checked deeper, so it might be a leftover in the doc=
umentation.
> >
> > The OperationRegion() has no reference to the EC (or in general, device=
) which
> > we need to speak to. The only possibility to declare OpRegion() for the=
 second+
> > EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI speci=
fication
> > supports 2+ ECs, it doesn't support OpRegion():s for them under the sam=
e
> > RegionSpace.
> >
> > That said, the commit message might be extended to summarize this, but =
at
> > the same time I see no way how this series can break anything even in 2=
+ ECs
> > environments.
>
> Consider the following execution flow when the second EC probes:
>
> 1. acpi_install_address_space_handler_no_reg() fails with AE_ALREADY_EXIS=
TS since the first EC
> has already installed a handler at ACPI_ROOT_OBJECT.
>
> 2. ec_install_handlers() fails with -ENODEV.
>
> 3. acpi_ec_setup() fails with -ENODEV.
>
> 4. acpi_ec_add() fails with -ENODEV.
>
> 5. Probe of seconds EC fails with -ENODEV.
>
> This might cause problems if the second EC is supposed to for example han=
dle EC query events.
> Of course if we only support a single EC, then this situation cannot happ=
en.

This is kind of moot though until a system with 2 ECs is available.
It is hard to say whether or not it is supported until it can be
tested.

