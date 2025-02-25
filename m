Return-Path: <linux-acpi+bounces-11473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66940A44D72
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 21:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8B23B8476
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51223210F58;
	Tue, 25 Feb 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv+ZV9iP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338020F070;
	Tue, 25 Feb 2025 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514954; cv=none; b=A3vCBUytrr1x99pS/h900uvRSL3q313bnF42TVtuIo3tmhnw6mE4yNNjr4WfkI9rjJSYUa2kq4bxW3lN4+k/9tFKMs6ijnvsskMNf1LsAE3PoGlreknImMYPnyBfUpmpiDuepRMF5Jch+vyaG7NQWOKrum5Dj/UT9N3KW+F/xxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514954; c=relaxed/simple;
	bh=WHfM+Psf/mtwjlJQPvL0GLWft+nM62DyQmwu5zUQuMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxKmiLOgvNwMt0l/Gx5BZ748adiIiCVcmKYteP7AXzVzYc1+bDr5mopQtMfL7/KQ9JBiFlRtbXYCDWUoyqzrE4/YNbyIhOU38r3LUfmFTR04flgUOsYhC6ETVoiGF15iCYExBNyWhN+0upULlqdRsmH9SvB5uDFR/nWVBzk0Yxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv+ZV9iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9109DC4CEE8;
	Tue, 25 Feb 2025 20:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514953;
	bh=WHfM+Psf/mtwjlJQPvL0GLWft+nM62DyQmwu5zUQuMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jv+ZV9iPAKCxHbgXWD3BukLzsnFzH3LewbyntxG70BCFMgULJUwAKO3ejErJQyzUy
	 aW3ahUhmrKpn3HDC4YYZXnqehkBsgr4kkhXORF//3HrXqCfKZfOXhtJ4Wqe5wJCMyk
	 rlp7KvKFSvCUrOIHM3YymT1LzKUWaOvsLkLqoDbHawF+KOU2NW4Jd0ebiAwSZC8Kiq
	 ewkfGkEiEbXy2/5kyWcNWuuHS9y/O4qNb9OAtMfdA7OqUCNnVpbUpgtVUBjKpHKGkX
	 g+BbZwWea9zu8ZZhligsGe7oV8OZMSuHE7HQKZkkP6wap4/FiCaGazY8aqyXrVyzKQ
	 nNqMGIi4MWXLQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2a01bcd0143so5729910fac.2;
        Tue, 25 Feb 2025 12:22:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBrfEIPkS66MujmXIlKld6LE9T7GBMQssoRap7Yd5ztbaS05c/ojgYasoOvgcCfQwhhkb/Omo3CKJothy7Voj5GRsEFQ==@vger.kernel.org, AJvYcCW7VRgHygzLd9UfW53mayOajHfjpxDudybaZnNkqg82qMs5hLBPsT3fDErGSr5Pi8z4WYqzf3kFYG6F@vger.kernel.org, AJvYcCWVutxFTp6XYx+ip6Xt4pYNB0mDjpI7jXr9H+4WfGVtcgovaHot4XMr3lmEsNXi1/G/ZUtpzNDWL6ZxVivP@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGi2NnKRZePDTlJbAGncbQX0Z1x+xB9mK/EeHuTNdDPmhzTP/
	R5PW9JUA5jIydEf08Y5xlBKVpnEl9WEkzLOo+Tat3SB+WxwXdDO6wlKzb8Knsg3iEG/vKQzcIzj
	UD0s2a2wE/52aY7TxgxzDzvuwZ2g=
X-Google-Smtp-Source: AGHT+IGAcEUAeOYUp2MtnZVqIB1tg5m8S4OTzu4iYW8KzZSgSuLZ2jHkw/gSrKPp7pN5UAvMdYgnU7D3c1TreJ4nRUY=
X-Received: by 2002:a05:6871:14e:b0:29e:32e7:5f17 with SMTP id
 586e51a60fabf-2c130725ea5mr530894fac.28.1740514952774; Tue, 25 Feb 2025
 12:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev> <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <9fa91732-3085-4e79-9a8f-b38263ee7d08@gmx.de> <CAGwozwHZCLaVD8iRgRxvQNqw3v+T9J+omMF+JoNe1r=+S1-OsA@mail.gmail.com>
 <CAGwozwEEbsLOJROm7rW-240Zoqh3K_JOtZE_NL8AnLy1eChR6A@mail.gmail.com>
In-Reply-To: <CAGwozwEEbsLOJROm7rW-240Zoqh3K_JOtZE_NL8AnLy1eChR6A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Feb 2025 21:22:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jpSN_Tq6D3OrRj5KDuXwqVuzcwyNXwEuL90fr=juH48g@mail.gmail.com>
X-Gm-Features: AWEUYZmzhNvwyLu_2c5CnTz2MjgKfjkbD3lP2MqZruAal3HH9xtt5BadD67fSQ4
Message-ID: <CAJZ5v0jpSN_Tq6D3OrRj5KDuXwqVuzcwyNXwEuL90fr=juH48g@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Armin Wolf <W_Armin@gmx.de>, Luke Jones <luke@ljones.dev>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Limonciello, Mario" <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:07=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> Yes, making asus-wmi use low-power is indeed the easiest solution, but
> if I thought it was good enough, I would have done that already as a
> downstream consumer of the kernel.
>
> I just want to be done with this once and for all, so I spent an extra
> hour today solving this in a cleaner way.

What about adding "quiet" as a "hidden choice" to amd-pmf such that it
would allow the test_bit(*bit, handler->choices) check in
_store_class_profile() to pass, but it would not cause this "choice"
to become visible in the new I/F (or when amd-pmf becomes the only
platform-profile driver) and it would be aliased to "low-power"
internally?

