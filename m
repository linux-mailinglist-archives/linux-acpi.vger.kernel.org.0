Return-Path: <linux-acpi+bounces-12214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4276CA5FA10
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305EB7A4C3E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8C260366;
	Thu, 13 Mar 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ilazt/d7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A221282FA
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880142; cv=none; b=EJXdirOfv3/LFAF0YuXHfX9oEU+0vy++IYugMubmNXpOOJcVdHOVRcmn38MUWPCKPryk6R288zLUg+DX/6c5go3XTsv3EJP1TcaLfm2fLCrBKdgaTzxc97bBRQ2Mj+ixZWWZ5ShnH0ECm+U7QNhdIzlAQvfln15epESAZulsRbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880142; c=relaxed/simple;
	bh=AEAAcNUqRh/KcSJXj72iNfJyCs1NhT5bFsr1jwl5lvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4TYjoPqfGGWoBeL6ue88kdVG60yC4/Wu0L3FTSw/fFVtjKEnUds6rJS9I/PHXao3gcxSrutXh42zZqHv6F8QndZTgIpQpHeSg5IpoCxQszltsjOoIBomcdXrveflJxxSaNbYkMqGOnnbeDYIR9KKhfbTy/EUE4TRR7bYBnei2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ilazt/d7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A3BC4CEDD
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741880141;
	bh=AEAAcNUqRh/KcSJXj72iNfJyCs1NhT5bFsr1jwl5lvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ilazt/d7PbdSbekVd8cs4tbcYc1yCcF+J7SOoJWYXY25XkJxQekDmzjCR7MBmU1yo
	 1cfVAD32Y3DLzpPbLshMwlujqyTF8It0aMS9AL8plU1dA8iDOQrrCzK2w5gcLI5dCi
	 aIRIZ/f+YXTdLAIv6jCfUUymHDLtSsYIPfol6CvswtYI/sWsH9GtYNmg5pdKKunUuJ
	 4ZRgW/TK9OZ1/BTfYDfa343UA+0ejzCqcYw8ARVgBfsBUH1VyYyaQVdWhPwn3Frpe+
	 ZLAi6FZ1qKD5aYmlupCbb2H4b2m+DANb+twJ8SVD1OKH7jXKkyN2tqBEC3/iYKyN7X
	 /EAwS7ztKqscA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso956925fac.2
        for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 08:35:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YwvQwmHlVmrZtvc5tzcKepty3uYakDaEtLZ4K+4kHrcDoGWttQ6
	J1yUQcbC0QOxcRTkmHgqTsjTJa00D2ZnB63tFoT4i9HcFdt4rQ3+oSAYsDKx7kEGaiomThSaiRX
	22+hA2mW5TZe4+69C9jjiiukBY/0=
X-Google-Smtp-Source: AGHT+IHBVdD4g4hApGZvZFaC2smDUNYsHcM9p+0YzVBIcn41Ktz6LoTBzDOTiNxNYYX9e/S4lH3LzepI748M1lFSgGo=
X-Received: by 2002:a05:6870:d888:b0:2b8:69:6016 with SMTP id
 586e51a60fabf-2c261303ad4mr15178638fac.28.1741880141283; Thu, 13 Mar 2025
 08:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <90e6da7b-a2b2-4ff3-bb04-f39b1f6c5e70@app.fastmail.com>
In-Reply-To: <90e6da7b-a2b2-4ff3-bb04-f39b1f6c5e70@app.fastmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 16:35:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jH99jkZrsE-Ne---FwPcaOSThL+TEL0BP_w+QXaKng0g@mail.gmail.com>
X-Gm-Features: AQ5f1JqnRaM9QSLHY5oyT2FD0kvrHt-IZvwHSrdXpXn9-7812-0CwK8tcsMqsIM
Message-ID: <CAJZ5v0jH99jkZrsE-Ne---FwPcaOSThL+TEL0BP_w+QXaKng0g@mail.gmail.com>
Subject: Re: 6.14.0-rc debug kernel is slow, kacpi_notify high cpu usage
To: Chris Murphy <chris@colorremedies.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 5:12=E2=80=AFAM Chris Murphy <chris@colorremedies.c=
om> wrote:
>
> Four kacpi_notify kernel threads are continuously using CPU, makes the la=
ptop warm,
> fans run continuosly. This is a Fedora debug kernel, it's not intended fo=
r production.
> But I'm wondering if this performance hit is expected and if it's worth i=
t (for kernel developers).

No and no.

> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAN=
D
>   19429 root      20   0       0      0      0 D  26.5   0.0   3:01.99 kw=
orker/4:3+kacpi_notify
>   21018 root      20   0       0      0      0 R  26.1   0.0   2:59.99 kw=
orker/4:4+kacpi_notify
>   19753 root      20   0       0      0      0 R  24.5   0.0   3:28.92 kw=
orker/4:0+kacpi_notify
>   21919 root      20   0       0      0      0 D  21.9   0.0   1:06.62 kw=
orker/4:1+kacpi_notify
>   21206 root      20   0   38052   8192   3312 R   3.6   0.1   0:38.19 (u=
dev-worker)
>
> A possible hint is in dmesg
>
>
> [  874.399128] kernel: workqueue: acpi_os_execute_deferred hogged CPU for=
 >13333us 1027 times, consider switching to WQ_UNBOUND
> [  960.050165] kernel: workqueue: delayed_fput hogged CPU for >13333us 25=
9 times, consider switching to WQ_UNBOUND
> [ 1678.780253] kernel: workqueue: acpi_ec_event_processor hogged CPU for =
>13333us 35 times, consider switching to WQ_UNBOUND
>
> Full dmesg and kernel config attached to the downstream bug report:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2351405

kacpi_notify is only used for Notify() processing which only happens
when there are events signaled by the platform firmware.  Like battery
or thermal events, for example.

