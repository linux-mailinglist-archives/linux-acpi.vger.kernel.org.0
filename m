Return-Path: <linux-acpi+bounces-3592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D0857F70
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 15:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1131F26151
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D712E1F8;
	Fri, 16 Feb 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b="madUIqXP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E837140
	for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094220; cv=none; b=Y9ortb5Yv9DolGgxmzUkBqHt7oimlmjZl4WgR4AEAw8G3obBgCj2In3tzsIKRJCrnZEDUDxQU4+mS734+/qFQQBpL1IP7OpjqwBYgfCocWAWU7HlJk52UUKL4iGAJW/y6RV9plYSSoQm5tM11Q8+AuGSuf/c5lh98BixxyQw1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094220; c=relaxed/simple;
	bh=NMpxO6BRTF3koNH7Yt87r5MK6SiqzGPswzHSBBECWSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pINStrwFg7jK9e80XhlGf2yhyd84z8fltcOkYNWkNhutJdAHWRlyYgx1nxTgXAG7TcSdqocIBIiUYUn6PdGA6pjEMNn15ylYVrgfzX+Wl7EPkHM9ykk5udaa0H5XKtNs8k7+pYNPm383hnWZ7Gp24tHgFHmii8wcAFaX8INbajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in; spf=none smtp.mailfrom=cpp.in; dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b=madUIqXP; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cpp.in
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc73148611so2319023276.3
        for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2024 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cpp-in.20230601.gappssmtp.com; s=20230601; t=1708094218; x=1708699018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amXLUPKyR3lsUuV20wzpU1g+BcKcez3rvZv1mWJKOlM=;
        b=madUIqXPOVNiORcY0pU+VWh21IJNNDO37C11xrxwZmTP5hBrIr7RCm+aEuKcqU2sdc
         ZAGxXUxOPn4AxrjUEZo3upvn29Qmp9hq4XFKWCSvTldr8bJ/tO0Ypr3JyTWD7mazn65r
         82oPKwNeBWxng8WrYlRppyH0PdxoLurJledKz4DBXy4UYgs2pZzULD3/OySZ7t1nwYaF
         AGY2ocDNoHC3G8CrzklmuOxNenlhDXhB5wlk6tNaMGHEZWfeorBza8z+8b1B7oIJhm1p
         pLZjWnKINNAs28t0RD2btgouYfT4/+GOrSsGcX9mo+eXLDGNMWAwTo4dB+CDx3or0DK/
         LJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708094218; x=1708699018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amXLUPKyR3lsUuV20wzpU1g+BcKcez3rvZv1mWJKOlM=;
        b=bgSBVjv8TY4BnxPCiqNDaU1QnQWd50bKHoabTP9d58v1l+9pOoNTurE02tuC2h5Un4
         0j++LtiNSDI8OozECkII2LQQEyAXMqi/S2k+spKfHYV/ienlg0fDbBzaB7vJrkodN8dN
         vKbfqsYOsAAs2AqtdY3Q7HT2j3ptx7laDSOIgiKDuf/xUJos2VIh0duj5V8d/VglDLf8
         Od8pikatmPKTAdcIRO5Jjccnf+3JYmjCoYnlrNUMWtM4lFxWcI0V2Ru6KJph03FT2hoy
         0eMt2RLwZWLB7OysT9+mesYkZYlQOouRcyNLm2c9I/ddT4qgqorUe+ow6exMN6bN43fE
         dNIw==
X-Forwarded-Encrypted: i=1; AJvYcCVOqoNiBAd+DwLuECZZFtZeZBRSmJoqre6ZsTwgNEqihXyK+88IFzoaxllFmE8wfYoTn2Kalbh+LEjJnOuIKzbAh4udg8WcuUsfdA==
X-Gm-Message-State: AOJu0Yx0cWH6kgX92jcO9ZbQVMUjB+osMp6eYwIZ2mBaxDv6m6SLNcpa
	5mtep925T2cNBpIDRHZvI5J8YMhtpMraekX1fDjWlNtE6HLP0sajc9c0h0RHur+qnxaBU9tRE+J
	t7tBaWMPQnZnmF7flnov8Ej/QZCG+y/HBQpGp
X-Google-Smtp-Source: AGHT+IE19PZCDG3sFathhZaGd45U9ABUohzHnqfJhRgGlUMlnYmDkNDPZxCO3hMTVMCcC6tjFFPvox80yk4Elr1SMUk=
X-Received: by 2002:a25:29c2:0:b0:dcd:aee6:fa9 with SMTP id
 p185-20020a2529c2000000b00dcdaee60fa9mr4908407ybp.53.1708094217745; Fri, 16
 Feb 2024 06:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>
 <20240216120211.GR8454@black.fi.intel.com>
In-Reply-To: <20240216120211.GR8454@black.fi.intel.com>
From: aigilea <i@cpp.in>
Date: Fri, 16 Feb 2024 17:36:21 +0300
Message-ID: <CABYkuAhLYcLQp8PiBm-aTDC-AAV2NWVzN-79XLVcYvAfGtVhcQ@mail.gmail.com>
Subject: Re: Kernel panic in ACPICA on HP Spectre X360 (Meteor Lake 155H) laptop
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

Booting with "modprobe.blacklist=3Dintel_lpss_pci" on the kernel command
line indeed works around this panic.
I will try to find out what hardware depends on this driver.

Two years ago there was a similar issue with broken soundwire devices
configuration in dsdt on tiger lake iteration of this laptop, it is
not fixed by HP to this day.
SOF guys in Intel ended up making a quirk for that case.
So if the quirk (or some additional checks in parser?) path is not
suitable for this issue I guess the most "proper" fix might be acpi
overlay?

Thanks!


On Fri, Feb 16, 2024 at 3:02=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, Feb 16, 2024 at 10:33:00AM +0300, aigilea wrote:
> >    Hello.
> >    I've run into a problem with ACPI while trying to run any linux
> >    distribution on "HP Spectre x360 14 inch 2-in-1 Laptop PC 14-eu0000"=
 with
> >    the latest BIOS "F.05 Rev.A" with kernel versions from 6.5 to 6.7.
> >    During the boot or shortly after kernel spits out a crash backtrace
> >    originating at "acpi_ps_get_arg" called from "acpi_ps_delete_parse_t=
ree"
> >    or at "acpi_ps_delete_parse_tree" itself.
> >    It usually results in a panic and the system is halted but in some r=
are
> >    cases it continues to work for some random period of time so I was a=
ble to
> >    collect some debugging information.
> >    I'm attaching parts of the log I've got booting Arch 2024.01 liveusb=
 with
> >    kernel 6.6.8 with the following command line:
> >    acpi.debug_layer=3D0x30 acpi.debug_level=3D0x880640 log_buf_len=3D25=
6M
> >    dyndbg=3D"file device_pm.c +p"
> >    Layer is ACPI_PARSER | ACPI_NAMESPACE, level is ACPI_LV_PARSE_TREES =
|
> >    ACPI_LV_EVALUATION | ACPI_LV_NAMES | ACPI_LV_EXEC | ACPI_LV_PARSE
> >    I wasn't able to boot more recent kernels to a working state to coll=
ect
> >    the log but they panic in the very same code.
> >    Log part with crash starts at "ACPI: \_SB_.PC00.I2C3: PM: Power stat=
e
> >    change: D0 -> D3cold" because I think this is what triggers the prob=
lem
> >    and the crash happens after what looks like a double call of
> >    "ps_delete_parse_tree" from "ps_pop_scope" with the same subtree_roo=
t arg
> >    which should result in use-after-free and a double free.
>
> We have seen similar and I think this should be fixed in the BIOS side
> but I'm checking internally if this is the case or what was the
> conclusion.
>
> Temporary workaround is to blacklist intel_lpss_pci driver (although you
> may lose some of that functionality then but that's still better than
> completely non-functional system).

