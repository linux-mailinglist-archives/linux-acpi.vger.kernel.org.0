Return-Path: <linux-acpi+bounces-16375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E9B4453F
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 20:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8517AC566
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF62B34165E;
	Thu,  4 Sep 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzIx75iW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767A31A54C;
	Thu,  4 Sep 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010067; cv=none; b=sUTUk8mYwVst4GxBRqHI9SFqYGcn6MRDh2iQTFJgQIM0SS4rI6p3vB5t5rzJR7ZUKnqJdAUYYM/iyxdfmlCEylbXuCxSTz3dsEDBivSW219eI61G8TYQSrNGhZKSOi7dsijuyysNIA8c++30r84wQvTfshAuP7YQGYFAWPj2n/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010067; c=relaxed/simple;
	bh=vuKt74MtYD7IscAzLV1lxdYYoSz+D2LfckiU/M4c3h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL1d1TQV+J9HpxDR/yHilksxbq4omktyLKngxZ0ET3BHTa/AYpAAixYSb3K5Y6BStbX2FzWzVoul0Xeo/ylsIym2vds2fWp3hStj5vu7mMp/LQ2hVp8bPsSsRoiih6/yblmwaooUr6JUeRUgxZ4VS1yeauJt6oTfvVJMPsHY1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzIx75iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A6AC4CEF6;
	Thu,  4 Sep 2025 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757010067;
	bh=vuKt74MtYD7IscAzLV1lxdYYoSz+D2LfckiU/M4c3h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rzIx75iWhfcpelJB3nPUaPnZfKRE/WKQeNufx43TMfGPmPXjcorGtDzXkzvLeBBnY
	 PYPT0mLtjk10HsK2tcXlOq2wtiw4CcTpB4bcKr7w131R8PDPdQFQlb9LSHAoaUGpKV
	 kdpMgLDofk8U1Ix7SVBzKkeuFPT1NlRmJjjv0r0MBOvqEFnaYA4uPywfO1/jzKRrZz
	 IDSLFa63JCTIpQD0zzE/FxQW/x5CIltv17wQblUtLR8i27TOQA05yHDnHlo7e9Mee8
	 bte8fO8Z2gx0xEQEunaBhJRd5uqtFEeXJc7Rmke+YwrA2M1zyV/XnDbMV5qBsZGuv2
	 Pzj6D9OxNqEhQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61ff9c5a0c6so55168eaf.0;
        Thu, 04 Sep 2025 11:21:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX41WqMlWKEvzf8+Jd3L5FwKmPXIiDtpf0md+Q67JvuIY6qDg66eNL7CUpuwdruwF1AwHeOwmSkK823ckg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHePTbBoWcs+NM1PkhVrB07xeeP3BuDWwkKr6KWU5gc4iQG9tR
	fUJqRlKWS4RbqH6Y5jqFE1XyQElCM4kOTZJciflMjNAmUDJ7b3N/X3xCZJyuqBzCe26sWWNI2e5
	9YbWIpW+zfHqxOwNEzQo71PfEuPpzH5g=
X-Google-Smtp-Source: AGHT+IFz7a9PeXhJsPGKqzOGIE/V1p52FgT+so0RDMEhaRB435kRDktRlrI2k+6cUH7u5NIssdFxPM/H6sN+00yoO3U=
X-Received: by 2002:a05:6820:1503:b0:61f:f9e2:b183 with SMTP id
 006d021491bc7-61ff9e2b66amr137008eaf.4.1757010066630; Thu, 04 Sep 2025
 11:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7674021.TlGXAFRqVo@daniel-desktop3> <20250828051203.GU476609@black.igk.intel.com>
 <2881298.hMirdbgypa@daniel-desktop3> <20250828081345.GV476609@black.igk.intel.com>
In-Reply-To: <20250828081345.GV476609@black.igk.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 20:20:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jTPFnb_W4eWN=o5UnAjSOGn5cLiQgmZ81YE9moy39_TQ@mail.gmail.com>
X-Gm-Features: Ac12FXxHmPSf2-Tn9DMGtlM6uqyzIRGJV-9cAzTk_uTPSZTql2tGmqWzBhr4oR4
Message-ID: <CAJZ5v0jTPFnb_W4eWN=o5UnAjSOGn5cLiQgmZ81YE9moy39_TQ@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: TAD: Add missing sysfs_remove_group for ACPI_TAD_RT
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 10:13=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Aug 28, 2025 at 01:38:14AM -0400, Daniel Tang wrote:
> > Previously, after `rmmod acpi_tad`, `modprobe acpi_tad` would fail
> > with this dmesg:
> >
> > sysfs: cannot create duplicate filename '/devices/platform/ACPI000E:00/=
time'
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x6c/0x90
> >  dump_stack+0x10/0x20
> >  sysfs_warn_dup+0x8b/0xa0
> >  sysfs_add_file_mode_ns+0x122/0x130
> >  internal_create_group+0x1dd/0x4c0
> >  sysfs_create_group+0x13/0x20
> >  acpi_tad_probe+0x147/0x1f0 [acpi_tad]
> >  platform_probe+0x42/0xb0
> >  </TASK>
> > acpi-tad ACPI000E:00: probe with driver acpi-tad failed with error -17
> >
> > Fixes: 3230b2b3c1ab ("ACPI: TAD: Add low-level support for real time ca=
pability")
> > Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied as 6.18 material, thanks!

