Return-Path: <linux-acpi+bounces-13574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B78AADF4E
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584C81C24FDA
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F1F280005;
	Wed,  7 May 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKVUmewQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573752327A7;
	Wed,  7 May 2025 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621339; cv=none; b=LrYMiMosljKaOlo9cndijdF4HlTOfl3mYBqBJhsL+EX64QF4MfHDNzzx6BsvwlDO2qrMhQog3c7QknnK2+oddILHauNbKlvApxYJJDBjbrudlXRuMpNXU03dH9bSO6FwiLkauORm7zmmLnhnS5Of5qOALQgf9NDRd75uJvbfveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621339; c=relaxed/simple;
	bh=QN0iYaTj5lXtSoMu1TVz9P54D0YZyQOGyVxihYjrfeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEBWnZ1C2IW1v5+bLa6QATOB5pHTAJCz+neU7iX2g0+0HPsaK51o/XsOqm/FJOO4mX8lCzPfroM8UbgBo0QJ0zY28An7oalGi5N7ra+vuR867UmhqhAFn+n5MgLhrPrM9sS2wchhuhV815oZxVsXVm3PEZED9gHz/OZOVk6lUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKVUmewQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEEFC4CEF1;
	Wed,  7 May 2025 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746621338;
	bh=QN0iYaTj5lXtSoMu1TVz9P54D0YZyQOGyVxihYjrfeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SKVUmewQj0XsJbohitWCvOFhVcI3BQwXlMeNl81ZbJq4yZj0YcbyGdR9A2cXhzLWV
	 5Pyo0TRbZwQyzY8z4MsgXQ1Nf2D+AtwlXfgNrg/O3vIdkOuXslQPtzx1DGxmKRDW2s
	 rY5zfUB08tYbf07d0Mj9lsi7EnnDutxufWZUXh5kNNb0B6W1wZ/eztYwouuY/X2u+2
	 VJmNDQ9ZcD2yelmJRFOIEqicqZXSlCzubiKeQ0pp0aDhbs3XWp8eY333k8J2JE+B/2
	 SaACfxY4iP3BbKAIowN+iez74ipUPe6fLiK/5ykkMk+7uHQTQsDhk8zHTrqYXX1c9M
	 A6XV16fRQ+e8w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2da73155e91so1763697fac.0;
        Wed, 07 May 2025 05:35:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbOwWGHTgNtMYCVVF2mQ9nOtl+xc4/sHRCdgrFA5L1ONZoYctVOGRHb1dzVblBXkvcCjdwHanCgkqe@vger.kernel.org, AJvYcCX4UpcDox8sME3w1DuZpL9BUYNTiw3ouJ1rPqeeLDCqfy0POpkOzsk9kf6WN7aXqakd4y84gIdUq6SK+jaq@vger.kernel.org, AJvYcCXpQGNdV4xIS4tNQedBsBDDQd54tOrhE7Hkz6pDZ0rDBoQF3gXUL8B3kIBZoYOo4YFtzq449ugq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PBY7S4zQhSDis3a7iS1YyRXv3CIvmxuib7boj/g28y/cYCHU
	GNZA2qVfjDbQyMfA1Y8UbgzjZq0JPnDF9B7wdfvhahU3blzSOfQzj9sdN2oEVzVe+anB+Xy2c1J
	2h1P86PBlONU78KIRrd27JNtzYT4=
X-Google-Smtp-Source: AGHT+IGQLgvypqx3JcHwD5PFPM2WjUgglfXhMZCVbBxVzPyWXbTBVdybrYDiwZRccGO4EQVpsjcwxf77T7Ddt+bH3NU=
X-Received: by 2002:a05:6870:1585:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-2db5be13542mr1641073fac.12.1746621338107; Wed, 07 May 2025
 05:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-draco-taped-15f475cd@mheyne-amazon> <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon> <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon> <20250507-quantum-solid-ibex-218f1b@sudeepholla>
In-Reply-To: <20250507-quantum-solid-ibex-218f1b@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 14:35:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixm4MYCxkMo0wiRP=W7TD3cwQtj0Fwb3H24yY+MGoLUQ@mail.gmail.com>
X-Gm-Features: ATxdqUGdAhoqiscdDan0zbOIvJu8owZ1f9kinzJ-STFEWdVHedeGnKVeBK7FnIc
Message-ID: <CAJZ5v0ixm4MYCxkMo0wiRP=W7TD3cwQtj0Fwb3H24yY+MGoLUQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Heyne, Maximilian" <mheyne@amazon.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:31=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, May 07, 2025 at 11:56:48AM +0000, Heyne, Maximilian wrote:
> > On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> > >
> > > Just to understand, this node is absolutely processor node with no
> > > private resources ? I find it hard to trust this as most of the CPUs
> > > do have L1 I&D caches. If they were present the table can't abruptly =
end
> > > like this.
> >
> > Yes looks like it. In our case the ACPI subtable has length 0x14 which =
is
> > exactly sizeof(acpi_pptt_processor).
> >
>
> OK, this seem like it is emulated platform with no private resources as
> it is specified in the other similar patch clearly(QEMU/VM). So this
> doesn't match real platforms. Your PPTT is wrong if it is real hardware
> platform as you must have private resources.
>
> Anyways if we allow emulation to present CPUs without private resources
> we may have to consider allowing this as the computed pointer will match
> the table end.
>
> Rafael,
>
> If it is OK for QEMU to present cacheless CPUs, then we need to allow
> this logic. What do you think ?

I don't see why QEMU would be disallowed to do so.

