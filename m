Return-Path: <linux-acpi+bounces-19415-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970EC9F6A1
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2586130057D6
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B40305E33;
	Wed,  3 Dec 2025 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB2jPnWR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF58305E05
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773940; cv=none; b=Fq3Z6sx0mM35inymB1ZjgtMRzX69xinAABc+HezNV9GbsYAIkb8gTLGvRwYyjWQVe/KUdf2K17ON79OkxZnWZAYLBaquOcS6+UpT435ByssKSXL43O1uvDdHoaUWfJggaE9UEdkn+QwdUqxTQpL9cQT9YBbnh1XFd7kjSor0a+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773940; c=relaxed/simple;
	bh=TPaDeV+6Fc8KTANF/Ld1E4bncc7kvYIbKYKVVe41BSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPi39uoXwl0am8XFP5GEDpIF3EOsM0pDyn9mbW7PwPKaPCKWurR8l+tfadOEp2Lx+qSsUOWIC2Zw1MVNbqrVrkeDJc856vRfaj3vymH504VbBHT0YLhmXujtjoTBPpTV7I8T5gPF7YqtaL2yjDB+ZorzmMBaJOJSryUFQV/jdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB2jPnWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4658C19423
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764773939;
	bh=TPaDeV+6Fc8KTANF/Ld1E4bncc7kvYIbKYKVVe41BSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mB2jPnWRnXRikSseitBjiBAVxjRKg4x+dr4ui8q0gLMT1uGEmG8AJ3G8cj9jmUAEv
	 8xu4rHgol9bbEYghY1iQ147Iol9E377Y62sLhqB8KUSmgYX+VGXrbw9eHq1MwhYKXa
	 EhHaNw4rztpw3fznju2gA7m8h9EYT3TJdoiXThHvWGis+lnGhKLknUtepkD+Wv1Kpf
	 cOYsx6gjgi5e8L5hLzZlgr+2fK/g3bsPynQu1GxjGo09zOBcSXeWKfAXnLIKlIKsfY
	 K3d3ukrZnh9ra7OesapODcpLrF62wetUlrh+1KqLB4THImEcnZbDbcM2dyTK620kR/
	 Sn0RT7OlwYvlQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65962c714eeso601128eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 06:58:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9wVuKp2pyeIOoEHDegsr5ZQ6IZW0WZs6vQMIx/Ge774GekwW2PB4Ot7mqG/lAdhUIpDyq5NfIAGsb@vger.kernel.org
X-Gm-Message-State: AOJu0YycEw2VoRrQAespTjAiITmsu6HzJ+X9w1+zmt0ND9LuW13EPnLU
	iWyxZyQuo5YsrDdZUWwwT/afOa+PNbUhJALEXdTJGCKygGbNWxM7da2j3/0/dcVb+R5yQFVutA2
	VuLApX3FTw3KEl0PQ/ffnwGidyf5Qeik=
X-Google-Smtp-Source: AGHT+IEBNvdWekTmfE86jDSdxY14uWlXWCsZcxH50K+oYUWxGSuEgm8p1XWax1u8lR5GhDe8jCyvnE659kbh8ngFmcc=
X-Received: by 2002:a05:6820:4d42:20b0:657:59a8:5611 with SMTP id
 006d021491bc7-6597289f30bmr975982eaf.0.1764773939126; Wed, 03 Dec 2025
 06:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com> <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Dec 2025 15:58:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
X-Gm-Features: AWmQ_bn69N2BEZVFedw8ZJ1rf0fiVhAgA54J3MxX2gSyGMmdA14zqAKirZsAAcY
Message-ID: <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org, 
	kernel@collabora.com, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>, Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 5:36=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add `/sys/power/lps0_screen_off` interface to allow userspace to control
> Display OFF/ON DSM notifications at runtime.

Why?

> Writing "1" to this file triggers the OFF notification, and "0" triggers =
the ON notification.
>
> Userspace should write "1" after turning off all physical and remote
> displays. It should write "0" before turning on any of displays.

This sets a limitation on the correct/expected usage of this
interface.  How can the kernel ensure that the limitation is taken
into account?  In principle, it should not allow OFF to be triggered
if any displays are "on", for example.

And what exactly do you mean by "turning off a display".  Cutting
power from it or something else?

