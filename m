Return-Path: <linux-acpi+bounces-14180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6ECACF660
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAAB3ACC2E
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB81DED5D;
	Thu,  5 Jun 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keiFWWIw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DC18CC15;
	Thu,  5 Jun 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147649; cv=none; b=mTZ1NgtIAU//augwZU7zBFR4OY5gmM4OaSWGcumAn93qaoFDEAcjn8OipaGrhy5gTaASrmjMO+RrIlVUxo+WvS2y5FmAMjQYkmUBUx+Jj9m44eE/fW4+LkHw6YM+ESl35FXmTBhu/apWP+VjpyatSv9S1xfTCGur3YGCA/VL59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147649; c=relaxed/simple;
	bh=GuXy+S2OnKHqrs/0WLDLbvtSsvLUSoORLGJxOpGZcXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdmkD0uKRmmhQBKAY6Kj+sieuTjxpviO8rmc6OuzcUgESrl4gtrz7qIzzdS0yC8umprVJpVaxig/N2tsEFfYcPiactYo4/9qxXu9/8pYuhOkTQyrSrK+HrP2zgaDJ6y8l1bCnJnog8zalF0fZ8X6pmFCFd/Mb0R6mvSx3lk1JNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keiFWWIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564AEC4AF09;
	Thu,  5 Jun 2025 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749147649;
	bh=GuXy+S2OnKHqrs/0WLDLbvtSsvLUSoORLGJxOpGZcXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=keiFWWIweJGAGGpJEc3eEuezuxh0czRjsJE0KBKUTBLewXpE67McAwV4kw3SWb94f
	 WtJ6fohNII7lPoDKA7P+UxyD2iots2ZO2fCQs6J4H9yWKdQ/BYIHPlPlAZPocABts6
	 jQXtn0wVYM0TR30KMZzoS3hXUnEnYiu8yGuyBp3HR67IrbcEQ6Wng/60vNmx7oM4ZZ
	 Hlt/h849/EwSo1OaoqWhpiNhqtV9dXp0evEb96u5KlOg14CP0igpIhqiOUEdyPwRLP
	 fYdqIO7fwRQAklxyXWJ6C3PY+I14Nirzbz4Ef6ImobeqYfZfF8Y7mHxZylHznXLlsk
	 e9vQTyDY+AuHQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4080548891fso566892b6e.3;
        Thu, 05 Jun 2025 11:20:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5wPulpf7ULzqYsOnXve/017yl/I7KXAl3eF/XhXDBSMNXejGKFVRxiEwDs+7xX4Bz9ut1iSFbrmE=@vger.kernel.org, AJvYcCXH19ShC9vyiFay6fa+XI1A7T/8De83BOjDrRLqT8WJWee42u5MuiRO0K7CxTf9H7Sg4dBVd4Wg/s8x@vger.kernel.org, AJvYcCXJrnHa+9rDNFliDooWCMyhcDQoOQvjjPsr6lmQcglg19naieqoknhuapBVlz+HyRXDyp/TQ3cv6J0dUDmg@vger.kernel.org
X-Gm-Message-State: AOJu0YyYsWOnUol94tRNdvNWDOMYuPoxk9qnjbolzlwwSXDl5Wih4gBK
	JS3/Fe/gT2XKuc8NmeXzckifYwW0r4aznlEDQFXCNSYpQv1dRHON3upeiiEeu2X5Z8I8ACN7hBj
	YtHbldgC3IR7jXFitWaFZO0f/zRtt14A=
X-Google-Smtp-Source: AGHT+IG7/jJC0HU0cZqVScsTdwM1qZWvoE/yBpdMOxLSTp/DaDcMwzM/LYCBuwtfgXrti+7vhjcfBPjwDne2N5E0Has=
X-Received: by 2002:a4a:ec44:0:b0:60f:9d6:bd08 with SMTP id
 006d021491bc7-60f3ceeda67mr390588eaf.3.1749147648692; Thu, 05 Jun 2025
 11:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2226957.irdbgypaU6@rjwysocki.net> <2005721.PYKUYFuaPT@rjwysocki.net>
 <06122416-b24a-493b-9374-550e5c290436@intel.com>
In-Reply-To: <06122416-b24a-493b-9374-550e5c290436@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Jun 2025 20:20:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=d-w3QVdTwC7dApDKE_eVtNxOa1deyG1ru-VTcY_C0g@mail.gmail.com>
X-Gm-Features: AX0GCFtFXybSlkhGV2Kxomjop5gub7gHo84hnArGGoVN05qIYAyCIl6ek_pkwhA
Message-ID: <CAJZ5v0h=d-w3QVdTwC7dApDKE_eVtNxOa1deyG1ru-VTcY_C0g@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] ACPI: processor: Rescan "dead" SMT siblings during initialization
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 6:14=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 6/5/25 08:07, Rafael J. Wysocki wrote:
> >  #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
> > +void acpi_idle_rescan_dead_smt_siblings(void)
> > +{
> > +     if (cpuidle_get_driver() =3D=3D &acpi_idle_driver)
> > +             arch_cpu_rescan_dead_smt_siblings();
> > +}
>
> My only thought in reading this is that maybe cpuidle_register_driver()
> would be a better spot to force the arch_cpu_rescan_dead_smt_siblings().
> That way, each driver would not have to do the rescan.

Unfortunately, this wouldn't work in the current arrangement of things
because cpuidle_register_driver() can be called in a CPU online path.

It should be possible to make this work in the future, but first things fir=
st.

> But that's just a little nit at worst, otherwise the series looks good
> to me. Thanks for chasing this down.
>
> For the x86 bits:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thank you!

