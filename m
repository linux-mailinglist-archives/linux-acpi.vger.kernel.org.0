Return-Path: <linux-acpi+bounces-20383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB7DD24AB8
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 14:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 013D2300462C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207E39E184;
	Thu, 15 Jan 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDdlYAG+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8239C65B
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482517; cv=none; b=jlZVvoKwWydPkSqbq5GiKtCG9SERRo4i4NFHu1XMwC4Y0Hr0t2SVLn2lPMTCtD6AROLDi7ujW1MVpBP6uXlyycTjqXtfCyQQuNZ84AXiMjiS7s3Ttx8mrm2gDay0IyJS5PrhQDAMHvNS85/LvNCzuR2/ueTGnZZJHiWIKtMUUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482517; c=relaxed/simple;
	bh=kb5OJA6EJSBFxQnFxy0KZ4G3wH7WjnTjlX+40b+rzg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5F5iCroayqQuVH/f3Y5BgdVdFZqlo1A5GjATZ7aV4BAWlis4pF9iMtuSlLhwppD+myLSafdQRrrPoi6G4sW4Ng7z5d9KLf/lX3kD7AfL4R6ACvZawUoBoOB8YeIHVQYSjbcr5XwNtphNmHwoa9syoxjAIq1ZoSdea3C1AUBptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDdlYAG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631D2C116D0
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768482517;
	bh=kb5OJA6EJSBFxQnFxy0KZ4G3wH7WjnTjlX+40b+rzg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UDdlYAG+twbevkCwbi9KWE7PxtXupvAoi9asRiLWV63cZtBMmjmOWtGBrPpxmCJex
	 kNqii+G5hBO5V5OdIEW0+ew0Gmz3vi0kHB8OvEyqqbSP+gpk5T19GJOot27oQmvhBb
	 kAR3F3ug8kFL5cVJkVHU/wn62ECDUO4Mv8EOlMDMU7lkGJEhRuXFgZ60ZvBuz6defE
	 6wrftVTZlRYnWHlL96wTTiyCD4de9tRlxLW+LcgpsIE01cRLi+NxDPXz28RkEuR9t2
	 bPrTx5fsmWHwwt9MYOye1w0mnR/DLHqWH12s8M/V/gqV7DQrEuY9c0d77b6Njf0gGn
	 dLhkxs/6EC3vQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ffc3d389a8so605636fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 05:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWq689pGsyBJVPrvpbLoBM0ZOgld8OQUXOwIChDAV53awmtN4T8ttTaB9uNkJivho7pEt95QlsHxyJE@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeADlM8Tzo6tONjkj3JUbqGRrPddLgy2eLlvdvuegZVskizAZ
	f8U9Mwb46fFB82KUYj4yrqds26XHuuNbYX/hkUTwfHGZpfWhzaN96bSD+DSYFlC3QbEGFbABWgU
	p9k16w4b78UQE/z9Ie7BU7UFbCp0aDbA=
X-Received: by 2002:a05:6870:2dc6:b0:3d2:4319:38eb with SMTP id
 586e51a60fabf-40407158f6amr4000717fac.47.1768482511506; Thu, 15 Jan 2026
 05:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12824456.O9o76ZdvQC@rafael.j.wysocki> <63582fd0-8c18-48bb-b402-5d3c08b104bd@gmx.de>
In-Reply-To: <63582fd0-8c18-48bb-b402-5d3c08b104bd@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 14:08:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_F-S40aR3tysS7aRq9yyqUwmcTEiK3Kdp6E2p6Tojhg@mail.gmail.com>
X-Gm-Features: AZwV_Qj0QmWz9C-H-S126FdQ-q-UguqD39rBxUVyyJra3iZaMxtp1bq1h02wYZ4
Message-ID: <CAJZ5v0h_F-S40aR3tysS7aRq9yyqUwmcTEiK3Kdp6E2p6Tojhg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1 0/3] ACPI: video: Convert ACPI video driver to
 a platform one
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 11:57=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 02.01.26 um 12:48 schrieb Rafael J. Wysocki:
>
> > Hi All,
> >
> > This is a resend of
> >
> > https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/
> >
> > due to the lack of feedback.
> >
> > It applies on top of the ACPI patches in linux-next.
> >
> > The original cover letter still applies.
> >
> > Thanks!
>
> I finally found some time to test this series on a machine that has a wor=
king
> ACPI backlight implementation. I only booted inside a minimal console env=
ironment,
> but i was able to still control the backlight using the acpi-video driver=
.
>
> I also verified that acpi-video was bound to the correct platform device,=
 and that
> the backlight device was still associated with the correct PCI device bel=
onging to
> the integrated GPU.
>
> So for the whole series:
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thank you!

