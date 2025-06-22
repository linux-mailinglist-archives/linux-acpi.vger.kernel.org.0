Return-Path: <linux-acpi+bounces-14498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED678AE2F6E
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Jun 2025 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877AB16FCD1
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Jun 2025 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F061B3939;
	Sun, 22 Jun 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2rGRIV2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311719C558;
	Sun, 22 Jun 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750589604; cv=none; b=a7VNK9lyv62FTRWhBy0X2XwBxAL10jxPjIolxUXR/IP9cPGGSDSPr8ln4UxvXMPiqLDKnj+go9zJTfB5kIXI5Rxz7/vzbsqLoOmhcSauZ06e0d9GJ7JFugu5sQQlYl9ZEGy4kw7lHJmdbTT+YPr0N6sMBXxrclpu/gWPZ+uBMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750589604; c=relaxed/simple;
	bh=6jnf6D10aFmi6G2vOcTm+WV4qZfsRTSty4FoqUHTack=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvFi3/Kme3mCED7ejQ6GhWL4WRMU+sYOtHK6KqXRqD5dnVG8TeO+X2bD89WHGJTWgyteWQ9+g738NYs36IW8DsLrk4ndxblYRwQdtca/VCjWWgwc4GciORGZjjNGfefRAhRZQrvb4TbFrGXtqC3SRREI7OTXQXOIkopa0QHy86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2rGRIV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59305C4CEED;
	Sun, 22 Jun 2025 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750589604;
	bh=6jnf6D10aFmi6G2vOcTm+WV4qZfsRTSty4FoqUHTack=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a2rGRIV2qg2Nvn54LoXm0ZZckv3t7uA1WKvdAL4eBIBY7x9QuPMigDZ7pFR6o/H/B
	 N7kJF0gLWbqh2PgWRWerA0lU0PH0yhebLLJoazudxF90mq3xkdKsdmUuyNeDqlGx4T
	 N0FsBtLOCA/vgzw2Atvj1eBlFrYvE42WEsYnjrgrqLKecAGI9Bj7i4+cw5mSvgvum8
	 vfpp5kPiClcRGV/14DhiDwo988tmQsbCkESeSxzVCY3dZSu3fRGAl4l3IdXxkNRHs+
	 1DU4qQ5jB8O15efsRdyAL/+y89MeZqFLxUpQRg0jDVP6r5WqE1HKk4ZQMaGhQAJZhL
	 G2UuOSs56WJng==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6065251725bso2472741eaf.1;
        Sun, 22 Jun 2025 03:53:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGHyPy/raAa2JV/swQLktX8Qa7Dt2SKFVjxFYhZOpgVM2fb4rrkGniby/DAQYCUOsSrdA2awncTw7N@vger.kernel.org, AJvYcCWpTegXcp0hponqirIcboZ1JnSg8TRF57a7tjTIgyfbN8QJXMDGcApBs2rC9rla+YjxxxTzCkySbxxRkdsW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TLlHiDpoKJBYaV7WFAUlGe7TF/K1nA+ogllsvQyE7puGykno
	ZQfJPNf9dfW1nE/0PaaKxgpfCAPMqXuBG/WzMJaUTbbNzbFrVLYuitTnj+42BU/eI3WqFmNIbNb
	EJhET2krAPRLerm1Bqa0FV8z7qM83C/4=
X-Google-Smtp-Source: AGHT+IFmlCBsLwqiKzlxCrOdlC59t+rjhy3dEIa1Lu4jcof1y1YoLFIq1VXwkehHaNpuoM/JgQ59ax7/po1kMZ7iivE=
X-Received: by 2002:a4a:e90a:0:b0:611:50ea:5495 with SMTP id
 006d021491bc7-6115ba72989mr6170823eaf.7.1750589603697; Sun, 22 Jun 2025
 03:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
 <CAHk-=wgPwhqr7mwmXDzYkfAcMRu3zyKRxz3hh-wfg-BQxj+UZg@mail.gmail.com>
In-Reply-To: <CAHk-=wgPwhqr7mwmXDzYkfAcMRu3zyKRxz3hh-wfg-BQxj+UZg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 22 Jun 2025 12:53:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gH=0m_RCDa1++GUt4Qa28MdFPsNYc46ZMB7OnVJL=F4g@mail.gmail.com>
X-Gm-Features: AX0GCFtRM6G6nHbDUMpveea0ygHdrwkRhtTNsoIcK-473kzovj7z9EdmyrVf2bY
Message-ID: <CAJZ5v0gH=0m_RCDa1++GUt4Qa28MdFPsNYc46ZMB7OnVJL=F4g@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fix for v6.16-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 5:35=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 21 Jun 2025 at 04:31, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > This fixes a crash in ACPICA while attempting to evaluate a control
> > method that expects more arguments than are being passed to it, which
> > was exposed by a defective firmware update from a prominent OEM on
> > multiple systems.
>
> Christ. Reading the ACPI issues page makes me go "D'oh".
>
> Does anybody know what the heck Windows does in this situation? Does
> it just happen to work because it uses random arguments and happily
> dereferences bogus things without realizing, or does it do the "zero
> out missing arguments" thing?

Saket said: "I didn't run into this same bug on Windows though and the
interpreter just aborted out with a different error message saying
that this method already exists elsewhere. Maybe Windows thinks that
when RUCC is called with 2 args instead of 3, it is perhaps referring
to a different method with the same name, but warns that this name
already exists (AE_ALREADY_EXISTS)."

> Because clearly that firmware bug must have passed entirely unnoticed
> by people testing that thing on Windows...

Well, given the above, I'm wondering how it has been tested on
Windows.  It looks like somebody set a really low bar for the
verification of it.

Cheers, Rafael

