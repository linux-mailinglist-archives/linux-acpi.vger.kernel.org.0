Return-Path: <linux-acpi+bounces-10075-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133679EC3EB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 05:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272051889978
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 04:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E11BC077;
	Wed, 11 Dec 2024 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD/RnhMt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B392451C0;
	Wed, 11 Dec 2024 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890462; cv=none; b=Ines8mSA2ZRNjdCw64BhZ4w3pbkoMkxBFmLmSzg9aPOa/TgIJioEJAaRJ1wYeCJRfaDBqcFxdodfsHrERmdDdStgJOgaF2WIyIqookTZuKs17VRXPddz/VBIkI0rpiFAwwK7IRY45RHFuQfWE+MOGzpZiW2xkSoHmRVIdyaaVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890462; c=relaxed/simple;
	bh=+e4v88J6jf/VKEw98bjfYEKUWyC4gE2ctFEbFpZJNy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJK+9w0lcGCjqmRP/HlTlEEW/PnX6WExy41Pz/nAvX1kzWwZZJiK3CbxrFEx4gWXKdndSJ0XpqBekju0ur4CzuKmNteRqh/rAn2lcipmNLVObDZei77VXPXIKp+RrfM/mexPtQEzIiajqwGoGRYIAeNIkylHLiAkUQtqjR+d+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD/RnhMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29773C4CEE3;
	Wed, 11 Dec 2024 04:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733890462;
	bh=+e4v88J6jf/VKEw98bjfYEKUWyC4gE2ctFEbFpZJNy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gD/RnhMt+MlrZ1pYTo7Ob5+1kSZ7Nkv7Z7WQNfTG29d6mBGy99WMIxtbZITYS12RY
	 Srx1z7fN2/N1h43Yy+3FH1yXTUrWGWh6AI4TVSHmcfNzJRMtSF/eax7vRegMvlkA3R
	 LG/SaDDmkiQ5AkZWtCMdXK2pZF9YglBv4NSgHdwFJJThoQmuHbx3axcFvR1SpfHcQf
	 ngCud6OywJSq9ZFPBIVtbwPTfXelx/+43BQwIldmrbCSmN6lfHAuEW6v7kAlecSTiL
	 ZYkxkICfenIZi0zNC58/WAZCdbJO6nhooXEmz1t6t+aKSIJ5BIxKI5kNnQ7juIrdsW
	 uzQclfGmrYqMQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29ff039dab2so923956fac.3;
        Tue, 10 Dec 2024 20:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtPuPYUUmCs+2AU6OFRjMwuOC3o4Il+x+55bty51/e1CigAc/6h8bgijgaDiDYyn6SEcmDPCVsDzw=@vger.kernel.org, AJvYcCX8MuU2rzlg0Q2E9/ObMN18vvY0wp4P1GnOIeZZ3Flq41HYOBGkYGBSnjnIfXGJa5qGPOlQ7wNJVLG47DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jjWR8r3knXyoIdvjN7MB1lE1p5k1J9sf8B41D8EutIsgUvN+
	yc2bOnzZ+nRdOr+xQ+CH3Ll4ntp52LbJYH8VHQJ/X6Pj9Gw14GBIsA93Rw2umx3ZfelhLazr0Qe
	EOj+rK5vaQC5QMhI+HAGQJjGHYfY=
X-Google-Smtp-Source: AGHT+IHaQYyfKaCYrrO5PY0A1AaQ6ry6adjyCVqRy01qcTQV6W5SJ11rEAcjgmsWvM8iqB+f5ZXCmIF+n1kRL/kuB+Y=
X-Received: by 2002:a05:6870:7188:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2a012c12ff1mr739977fac.12.1733890461481; Tue, 10 Dec 2024
 20:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5857066.DvuYhMxLoT@rjwysocki.net>
In-Reply-To: <5857066.DvuYhMxLoT@rjwysocki.net>
From: Len Brown <lenb@kernel.org>
Date: Tue, 10 Dec 2024 23:14:10 -0500
X-Gmail-Original-Message-ID: <CAJvTdKmXHpXOBBAb7vU-8x4AN0V_q8w+JUVJJxtDtMw7yavUvQ@mail.gmail.com>
Message-ID: <CAJvTdKmXHpXOBBAb7vU-8x4AN0V_q8w+JUVJJxtDtMw7yavUvQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 7:24=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> Add at least 50 us on top of the requested sleep time in case the
> timer can be subject to coalescing, which is consistent with what's
> done in user space in this context [2], but for sleeps longer than 5 ms
> use 1% of the requested sleep time for this purpose.
>
> The rationale here is that longer sleeps don't need that much of a timer
> precision as a rule and making the timer a more likely candidate for
> coalescing in these cases is generally desirable.  It starts at 5 ms so
> that the delta between the requested sleep time and the effective
> deadline is a contiuous function of the former.

timerslack_ns defaults to 50,000 ns.

So when a user invokes nanosleep(50ms), they get slacked out to 50.050 ms

With this patch, if the AML BIOS programmer invokes Sleep(50ms),
it gets slacked out to 50.500 ms -- a 10x longer slack period.

I have not seen an explanation for why these cases should be treated
differently.

Len Brown, Intel Open Source Technology Center

