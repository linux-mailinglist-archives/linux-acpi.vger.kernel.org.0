Return-Path: <linux-acpi+bounces-12674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E39A7A136
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0004A16DB7B
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4F24A071;
	Thu,  3 Apr 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a594eN2p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315D1F4CBA;
	Thu,  3 Apr 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676994; cv=none; b=Be+pHeo3YyeqdLBzVSM4wkjlPHIXnS9ityv3vsph5hxpsAO28BRROBcLZgIEq7L6SQIzTbhCjHS7oGSr5q1sVqUkG8KtghcIrg39hDzTTUuMeEKCiaxb60+HGY6X5STjnZDZARL1jrasH6GWnQPB97kiZGA2s0prW5kszPd9JcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676994; c=relaxed/simple;
	bh=Zqp997HLp8WyLh7fXbv/lo9UezZBRX9g065XQWLDcjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0qD2nlyWow0MmRVoJl6E+f/sgHT7+pLL4MH4bTJtdo3OpjKp55kos0jJAZtAEefcPDBUrjPBH5mdlQPU0boPg4OtvHkGRfxjkcmIKY0CE4QQxbX7Mgb1IvFmns1NRJ63HDwt55CBADwtmA7cCDRym6EaRch/+el8FYmHwk9rZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a594eN2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77211C4AF0B;
	Thu,  3 Apr 2025 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743676993;
	bh=Zqp997HLp8WyLh7fXbv/lo9UezZBRX9g065XQWLDcjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a594eN2p0ofJIrF0IfEXOc7t4aIzGzvjJ9gbksLaJxBKHMJLVtuTuTF8EQV6rU5nH
	 MrE3xcozsL5w3kf1rxLZcdhpTgLZbXQu5locovy97vEooK6ywGgH2AThZsU/i7UZ0u
	 KvZJaf6O4eL9+0XiGtjPvmO/acgMCafnp/1ianiS9wBSTmTjBIXnkxAf4MDrydG9HH
	 NuGanR3xur1Oy6lZFKB+xCaUDUVfwdJawxxhat9VXahBFOlcNMtdo90mM2a4JzTKQ6
	 nLIUHr90g9lEy33qPhEld+DSMQIwnMil0GrvKPaM7dZ/e0Mnckq5lesSjs92iuH7Fz
	 8nFSbaYqgL5rg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c172f1de1so459678a34.3;
        Thu, 03 Apr 2025 03:43:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjGcOrcZoMeWDtdhicZW8/gP0bXWg7FZE4rMIDeC62Xc/hr1OT3xAyaSlUGhLosG/6lOEd6/h9WvHpencI@vger.kernel.org, AJvYcCXoU1Hb7cufiTsqhPS2TVT3glLjaX7LwXkVJ1abdmMNn6nCkmXZF8rpreXjb21x3HPXEBgJvshI6Ss=@vger.kernel.org, AJvYcCXuMfVCo5heIv+dQZ7nJxIyXyjPo8KZInBe22LS5qI8gyTqL6cjng8oFTrV2opSgnbkUeCk98TsexXq@vger.kernel.org
X-Gm-Message-State: AOJu0YycYEktGtNvSLPWOCtn9REro3qZmhGgFXqVzEAucHDO3AMsjyvK
	jONQUVKWWqd3IvhCaN3VfbLnG5Sd+N3gEtqc60o5WJEwOZJA+oswCImAFMrcHhyj9PKoCDAx27r
	ThgGhlRRyexK3Fr5M+bfkWLtOevM=
X-Google-Smtp-Source: AGHT+IG3AWB7CaPZwf0Tb0Ajn3mv8KyCE2OKLilFuXZicoSYb86Eb+BE+cNvbfGSivr8mtIxQOT9rNbcg1Tvna0Ct4k=
X-Received: by 2002:a9d:4788:0:b0:72b:8fd3:e2dc with SMTP id
 46e09a7af769-72c63816953mr12541972a34.21.1743676992741; Thu, 03 Apr 2025
 03:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328143040.9348-1-ggherdovich@suse.cz> <20250328143040.9348-2-ggherdovich@suse.cz>
 <SJ0PR11MB66228319834B1C7B48FCE52EF5AD2@SJ0PR11MB6622.namprd11.prod.outlook.com>
 <CAJZ5v0gC3DzanSdPqQiJ4JQppgNeRA7Z9Cge7NxmTO_shoUyOA@mail.gmail.com>
 <7a14ea42462a346958954f328933f583dcf9cb52.camel@intel.com>
 <CAJZ5v0juH2kYx-fyyfoFLBTjg30y59Dwj1wBYXxuHvU2c7X31w@mail.gmail.com> <29626e175f3238ae04451477e38bad875794a61c.camel@intel.com>
In-Reply-To: <29626e175f3238ae04451477e38bad875794a61c.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 12:42:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0mBTkxeHBWff0koYG4NhkN2wFwkKR5_4XUq-1U0maFg@mail.gmail.com>
X-Gm-Features: AQ5f1JrbzgGfC6WbwtpYyvFFJNoFRh9ods5kRfcRZ2ufljOl_lvM5LSdxrCl_Wo
Message-ID: <CAJZ5v0g0mBTkxeHBWff0koYG4NhkN2wFwkKR5_4XUq-1U0maFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "ggherdovich@suse.cz" <ggherdovich@suse.cz>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 4:54=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wro=
te:
>
> On Tue, 2025-04-01 at 14:13 +0200, Rafael J. Wysocki wrote:
> >
> > > So I'm proposing to return the index of the highest valid state
> > > directly
> > > in acpi_processor_power_verify() and then we don't need this loop any
> > > more.
> >
> > OK, so I'd prefer to first rename power.count to power.max_index
> > (which it really is) and then make the changes you have proposed.
>
> well, in other cases, like in acpi_processor_evaluate_cst() and in the
> _LPI case, power.count is still set and used as the total number of
> cstates.
>
> in this acpi_processor_get_cstate_info() case, maybe we should drop this
> change
> -               working++;
> +               working =3D i;
> So power.count is still consistent in all these cases.

OK

> For the current for loop that overrides power.count, I think we can just
> drop it, because no one checks power.count after it, which means no one
> actually uses power.count as max_index.

Sounds good to me.

