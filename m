Return-Path: <linux-acpi+bounces-18038-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 678C0BF6ED8
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35601188E39F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793C32ED3B;
	Tue, 21 Oct 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQFAGRhr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FB2F39C1
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055117; cv=none; b=jVOrYdAIHYzmHhwc/F3gvDF5Vws4Fc4I6CXxCpfWDW18Ts4AUBdzu6qrNai4b6YgOtmumph8NfUz/Dzzjh+upn/bfhNXe67JPNkQeOADP180+oR3UXAeKVYsOzxF7cRTTrkPmtcWtUsAnsd/4FlG9B34aQ/GWxpGJDTn6/Da3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055117; c=relaxed/simple;
	bh=CdojtTN+pQLJgp8yGLxiE7SSiy8Ar2Cuu8Ic6z9m7+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5scBxu/pHNrFKr73k/+1qiAc/0dI5iGefzfAETgQIxkGwsGB6NUnPr7XzmqwCeWbrF86GTcqtjfit94H8HW0ZezzWDmzByq8IKiWfWBLRaoeksqNaRW+QlzbDEw89PWx+CMYEVuUOh/GmZrTPiI6Ob2em+mYisIH7Uj7/MzQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQFAGRhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00278C16AAE
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761055117;
	bh=CdojtTN+pQLJgp8yGLxiE7SSiy8Ar2Cuu8Ic6z9m7+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eQFAGRhrfOkaLX2hKX+any7/bBGJeqpHea13K4kIHoGWLE80yVFgcr74ucLSWrzAo
	 6rIOE/RCcXkTBZEPjfmpVQKbd2CSNo1PGZFjo50HQFQ8BACgJ3S8/yZzyCaURhtMXM
	 PfOJcIGvcSfB6UkICy23S2RBVc25l7WloNLYITfYvA59pS9tz+AWvjn1eGTvqzUsY/
	 bGZ1/NzHlw2iN0JnCpwW3gmWa9JvQq1c+L5ihYgnjCp7+QpIlaR0WBN6wO+xzlBvqH
	 fGKlpOc6y/z9VTZtRVVXETI9CTOkH1o+/a89479vH5qS7Fal6gewBcducLbJ0sQ3R/
	 S4GgMVAHLcdyA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f715b18caso2741565b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 06:58:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXd5084mZjUwvOLxQ41Vzw2vpmGjLuhgQXpgTKJkzwQP1dGqgqBbpSBRORkGElc07gpzxa4tf5a2/2m@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxqotCTyZxAtXWbgie+Ysl8MPwtaO26RSuT2SJFpFL3r7ak6S
	/V8tMYqXIyy4xGRQTzTYvquDqhqpe4CYn6xZo9dIRuXhg0M3qO0RRe0nQ9p5fyHk1kups/cQKgU
	dFmzaL08Qje2TllWu1jX4ePlPYyQq+Dc=
X-Google-Smtp-Source: AGHT+IEju+8vNOgn/fUgmczapKzdRcaHFm+HGNYKbaf7IKu5Vg14gPckhbBdVx1M5JO2WiX9xYP7+xfojA+Job4vxKM=
X-Received: by 2002:a05:6808:1795:b0:43f:2791:12c6 with SMTP id
 5614622812f47-443a2ee2822mr7513783b6e.2.1761055116300; Tue, 21 Oct 2025
 06:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021092825.822007-1-xry111@xry111.site> <CAJZ5v0iy8wChaPYGmc=mWJRrA+uXnGF2Ar7aMCMRoUqS6877aQ@mail.gmail.com>
 <c29fcf14b87c0c0bfa1ba304c89fe8c410aac03b.camel@xry111.site>
In-Reply-To: <c29fcf14b87c0c0bfa1ba304c89fe8c410aac03b.camel@xry111.site>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 15:58:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBEQXDSH7ufBcwwYy8c2=89=LkLZGTZtTe53Fvht8dFQ@mail.gmail.com>
X-Gm-Features: AS18NWBFj7up5hYTovE9VG2SHAqp39AegNpfQLHEIWlNUW3HqCMj6ruy6axZ8h0
Message-ID: <CAJZ5v0jBEQXDSH7ufBcwwYy8c2=89=LkLZGTZtTe53Fvht8dFQ@mail.gmail.com>
Subject: Re: [PATCH] acpica: Work around bogus -Wstringop-overread warning
 since GCC 11
To: Xi Ruoyao <xry111@xry111.site>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Guenter Roeck <linux@roeck-us.net>, 
	Saket Dumbre <saket.dumbre@intel.com>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <linux-acpi@vger.kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:43=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Tue, 2025-10-21 at 15:35 +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 21, 2025 at 11:28=E2=80=AFAM Xi Ruoyao <xry111@xry111.site>=
 wrote:
> > >
> > > When ACPI_MISALIGNMENT_NOT_SUPPORTED, GCC can produce a bogus
> > > -Wstringop-overread warning, see https://gcc.gnu.org/PR122073.
> > >
> > > To me it's very clear that we have a compiler bug here, thus just
> > > disable the warning.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: a9d13433fe17 ("LoongArch: Align ACPI structures if ARCH_STRICT=
_ALIGN enabled")
> > > Link: https://lore.kernel.org/all/899f2dec-e8b9-44f4-ab8d-001e160a2ae=
d@roeck-us.net/
> > > Link: https://github.com/acpica/acpica/commit/abf5b573
>
> /* snip */
>
> > Please submit ACPICA changes to the upstream ACPICA project on GitHub
> > as pull requests (PRs).  After a given PR has been merged upstream, a
> > corresponding Linux patch can be submitted with a Link: tag pointing
> > to the upstream commit, but note that upstream ACPICA material is
> > automatically transferred to Linux, so it should not be necessary to
> > do so unless timing is important.
>
> The Link: tag is above.  The issue here is this bug is preventing
> automatic test of arch/loongarch (see another Link: tag).

OK, applied as 6.18-rc material with slightly edited subject and
changelog, thanks!

