Return-Path: <linux-acpi+bounces-10036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6FB9EB96C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3348F281553
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96C1A00F8;
	Tue, 10 Dec 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIvPB8KV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133673C17;
	Tue, 10 Dec 2024 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855790; cv=none; b=MoQJjpPKaVfTfysbE9gGRM9LUPt3ky6MoqsYQhh6gvAz/Qeb23eD9jqC/2PYZcieo9qcLMws/ougDxVZmR5AhqBUq+zSo8v3KzcOMfvMa0dA1KgRFaOJp4RlgKnLEKrcSr8KZzkePpA19yGYKwYIeFoi6KD0dvZYLkfDG16PjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855790; c=relaxed/simple;
	bh=ITOjEhppnIIzlZRuQ5yGsgyuxRc1qh55h/J/fSClFO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf4KY6KponC1lYJLdM/r7zknMMxtXWonUcJxcGrJdggjTS5ewqIjM0U6meMnBVAk6urH70R1+FhKS8dPXK1utqclw5jBANS/5DCEWN3IhSg2k2VMcYazWwZmrAWsFUiPdkS29fyM9V5pvdLnP8xnirBRWE8JFz7JsLY7TOvSIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIvPB8KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949BFC4CED6;
	Tue, 10 Dec 2024 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855789;
	bh=ITOjEhppnIIzlZRuQ5yGsgyuxRc1qh55h/J/fSClFO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oIvPB8KV4om2wIy1MEGNaS1HpoQMosu77yZAspVkNsSNY9os8931Ka2dVrlYyBl5H
	 gfNJs+ADtJtR8dVbX38mEmx8L8np8wBHXDc8bzkVL7M2kVsDfbaZCjX4guoG2EKEZL
	 2/h+u/DFf21ECKZvQNFw1Ia0CWCG3qrAxqK2B/gzo+j77ZvzL1mPpbycmrW9Mk829E
	 YhDvN8CgOK0bjxLWpcZqL2EmATuK5iXGHRW7VpNDORundftnUqS2Xm6yy9za8Uve/b
	 DAt7MpZLAt4gwOIarXxyao9lFOmTBqaPElLrwGS9Vt+coOAlsyfFlYsdgp1Q6XfXAg
	 Ja+KNG04RE2dQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f2b71bdeeeso1082595eaf.0;
        Tue, 10 Dec 2024 10:36:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjBzyC+Y3KBT5LSDpFHagnCNMJtH7okRAZZ4zHj3IWqPLkFtcBt2T0Ninykqb9lvqXzl9aNccT/LeZCGJE@vger.kernel.org, AJvYcCXNvUtFDaxBA8paQddazOcWPXlN0Ir3OygGRf0EgO2+LuBKruPRg6ZWOQZCuQ7GS4hmUcok2Zi5XIa2@vger.kernel.org
X-Gm-Message-State: AOJu0YyUydBiDTV3V3LH/FfIux+uMqO6A4chj/gT3ZQKV6EJ5WbXrlLI
	aJLi00uZnXW1vWZ5Kiw8xzE2VvlIX9/zDS5SBfl3nNavrScKSMDdkt8djMmainqCbtaKv+VoH4s
	yFcoB0qrofZ80KCMwNNXLvq+LqTw=
X-Google-Smtp-Source: AGHT+IHia3A5r4UsgHwjmpvjxjWEdb7G2QMNqqI07ydw5oy920qm7afYwrU7LRMwYyV0ZndkLASZyV6hhgaOXD0hquk=
X-Received: by 2002:a05:6820:1acc:b0:5f2:aefe:5b8f with SMTP id
 006d021491bc7-5f2c8eb1b62mr3819072eaf.7.1733855788983; Tue, 10 Dec 2024
 10:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:36:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iWaFxPj2Yny=jQ3Xz8qNNN3dUOD6mZWcEwMV_Ej5HSig@mail.gmail.com>
Message-ID: <CAJZ5v0iWaFxPj2Yny=jQ3Xz8qNNN3dUOD6mZWcEwMV_Ej5HSig@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: Constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:04=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>
> The usage of read_new/write_new/bin_attrs_new is a transition mechanism
> and will be reverted after the transition is complete.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Thomas Wei=C3=9Fschuh (3):
>       ACPI: BGRT: Mark bin_attribute as __ro_after_init
>       ACPI: BGRT: Constify 'struct bin_attribute'
>       ACPI: sysfs: Constify 'struct bin_attribute'
>
>  drivers/acpi/bgrt.c  | 6 +++---
>  drivers/acpi/sysfs.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> ---

All applied as 6.14 material, thanks!

