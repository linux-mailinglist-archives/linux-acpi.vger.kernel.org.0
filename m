Return-Path: <linux-acpi+bounces-14736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1AAEA5FF
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F616486F
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE372EF64B;
	Thu, 26 Jun 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbvQxhlt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5731F3BB5
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964401; cv=none; b=sr3dHdCUTGaCodGzoCV8RKgQbiG8Th/3Zq+D43Gf1uBCTYLiPUGZ9Cv0Pgkhb7HHGt2mJvgr2QlBaDjsYAS02WYsSMYbPxWZ9OBdn6dzOPiLzmz3P17t1lP1YmKyLf7enC3Xm2z78Ao04lmTCSixVImGzFRksaPc3+GGvn9DVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964401; c=relaxed/simple;
	bh=z8kEw7JJb2bp/MQgg2V6g++d3118nygEV9UNrHq9jUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0lp4jjtRSgsBK8uqqjbe1O3jbWnu2L7OT4PscOdFQTZHYcnS93F30V5ALwyLf2UFZesAHATGgg7R0uiBCvYwxIopLgK/GZfMkbrz2GQYjQDFn7VnftK+tZTO3OfaKKPtXc735z+VWvRxOgkFyA1g+bungmJxd/Cbf4Oey0ULOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbvQxhlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22F4C4CEF4
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964401;
	bh=z8kEw7JJb2bp/MQgg2V6g++d3118nygEV9UNrHq9jUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MbvQxhltfeUyQT0mzgv389l/425AQFZtsXYyunDHIYr4vfr+HUc4PfSdsIS3MNBsa
	 PxPRTxufEq6EdNlFCU/i9I1eMi6fo2NxD4bNranXYwdt3bA9ip9Anr3fIIPaMoaiPa
	 CmFMlUJr7vyiRAeJza/tvoCuLCHJnN28ul9FoUbXNYlZyLZrOKibsb+DkV3czdtvas
	 LebKAcArKqovLn+ERJSr+vsEwzyV9dXbyVmbaAMZL9dnV2RAk4x3urIpa3Bm7uqCV6
	 iWHzljyaNvZezLRwGJrfYjp+8qoKdzQJ7y/Gm0uJ3MHXm+r4KED6sB6nqjD3mGPaL5
	 zB0MMjGqVllqw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-606668f8d51so708989eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 12:00:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2HAXkqL/lEbRrHTWK+NlAcAGS5OISphg4umPIv4enPXOJn9Z3gwrFup6F90WuHnPBQibprHYGSLS5@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZXLRTeQy/gLdkC4rY7mYukNLAObxMx1LbyaeaZHii6je/a1N
	SptEEzznodfgVk64R7suOIzSDnxMaU76Et6fOuelmVvSCU/flBWJTkLFQtVFWliPzuGS62S36xr
	VBD5Ydux+jBlrMXpyppIW7saeyjY2reA=
X-Google-Smtp-Source: AGHT+IGRGm9V9G1/XQMXvowWQEj/txuJHawesLvcIIDcCfrtoyRYJniMPZfSR5r25D3cYeyp+04WTBWMD3OtV/C+qxM=
X-Received: by 2002:a05:6820:a09a:b0:603:f521:ff26 with SMTP id
 006d021491bc7-611aaeb14f9mr2576800eaf.1.1750964399625; Thu, 26 Jun 2025
 11:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609032839.525087-1-superm1@kernel.org> <CAJZ5v0iNoT79e9RRraifMY84oR8QAcSeYwk+=vaRSuB9mGmtAA@mail.gmail.com>
 <2825b98d-1bbf-4312-899d-c0eea0854d51@kernel.org>
In-Reply-To: <2825b98d-1bbf-4312-899d-c0eea0854d51@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 20:59:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-3L0Bh21_Z7QTEeWWgdQfW-8POKv5X+oL5HSLnKgaJA@mail.gmail.com>
X-Gm-Features: Ac12FXwRAH0vcdqhp1PRahTk8eDjUEaz50ONfTkDCH1IszkcO7Bfto-phzTJu7M
Message-ID: <CAJZ5v0h-3L0Bh21_Z7QTEeWWgdQfW-8POKv5X+oL5HSLnKgaJA@mail.gmail.com>
Subject: Re: [PATCH] Decrease `AcpiExTracePoint` verbosity
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, robert.moore@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:48=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 6/9/2025 4:31 AM, Rafael J. Wysocki wrote:
> > On Mon, Jun 9, 2025 at 5:29=E2=80=AFAM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Early in kernel boot pointers can't be used and so %p shows up
> >> incorrectly:
> >>
> >> ```
> >> extrace-0138 ex_trace_point        : Method Begin [0x(____ptrval____):=
\M460] execution.
> >> ```
> >>
> >> Later in the boot %p works, but it's not really actually useful when
> >> the pathname can resolve properly. Adjust the debug print so that if
> >> the Pathname resolves that the pointer isn't also printed:
> >>
> >> ```
> >> extrace-0138 ex_trace_point        : Method Begin [\M460] execution.
> >> ```
> >>
> >> Link: https://github.com/acpica/acpica/pull/1013
> >> Link: https://github.com/acpica/acpica/commit/bdc2a4e646f097b693aa60f1=
f2c4228d1e31b0d1
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > This is an ACPICA change, so it should be made upstream first unless
> > there is a good enough reason to make it directly in Linux.  In which
> > case that reason should be mentioned in the changelog.
>
> The patches were from ACPICA (I included the links above).

OK, applied as 6.17 material, thanks!

