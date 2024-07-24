Return-Path: <linux-acpi+bounces-7046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D093AF6D
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14971B22F20
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895B152787;
	Wed, 24 Jul 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNabl3nz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277618AED
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814908; cv=none; b=ia0k/5vbkc6VZPFTkIiFfHQQXea1KmEIazicAZwO8q+rGJUv3fuvI0WdyApAwad6beyuCB3NyvjdL+2Sm552sM7v/G3wKkRw+ixacj2R/iKcJ+tjFUg0HOsX2EjSFlQVCfK0gy/9+oEJ73dLCALUQdiYl4da4Eq1SohX/iimSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814908; c=relaxed/simple;
	bh=vkZ9bKcc+m7SD4464UmlON9t99s4f0ufpAep5jNiCME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7GToZNsFQp274yMY6RmvCCaV4NC0kcqrKJ5bG4SIMhTEx7LaKm/0NtY2wMxJ3b7OcWcjIrQiZnOlNDIU5fqUejQCEqkS7/bj8XT+gbiDjBBYRq0cNbjecRJ6R3VXnQ7sKCxOnLyEaF1+SqmqZr3wfMh6b9UMpTF+/CFZBeaRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNabl3nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C4CC4AF0C
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2024 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721814907;
	bh=vkZ9bKcc+m7SD4464UmlON9t99s4f0ufpAep5jNiCME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eNabl3nzqLyjvNdu0PHAl+6qfFD0+xO+RcOOmOXkTFbNuLxh4T5G2OvFXdpqFAxF4
	 feLUuwq2DWqCY4DE2COpDHahRsDChmxvqq5q3+Qh+WMWg+SGQfz6HhYhPPa+NmAHpH
	 4VYZOENisbERkbStuBZB14GXfqpqLx+MXVJADD5iEKj3JG5c1iL6NaEgA7kS/muErL
	 B25xoFgPVEZPVyzEb8PzhksMV8s8G22s/5XwQCd4vWc3CpQE1zepHGX7qExHF9vrjo
	 2190kwag/d7y9e5mDgP728lhn7SbZs6eW7KKAcT4lZ48XoAZRj6ZjvPpie6K0PJgp5
	 AHdVYYi3aaPCg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c7aff2005bso168749eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2024 02:55:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOO3xRY1FcEEDDCL14GDUFc8hlbefDb3wR0vJNX7iPEFvrKwiQHd7WF876wHtujuN9IQ+JWlp3QyBFDfXOW+P3iy8ZguzEb0tlnw==
X-Gm-Message-State: AOJu0YyHydkGI/dPdkrVX+3CLrL3OOFOMiBEHvyVnBOPVf0SDyFqxoSC
	PkZ+AUsMN9CfXrUnVdLx4hEEv33Yb3rgG8vjl/QlkLsiHSaJg5gSsOGAYp0jtkTlFN/usX6RW8A
	4t8VS9RVi5sqBSNSLJza40Ye4dkU=
X-Google-Smtp-Source: AGHT+IGKLC1hSlYLZWYmUI7NWJHWhNgU7MZHB9ttlJd3e+g3YUJ0ofAsCVy8XN2eGhjvBnsx9thAzcDqkNgh6PLUbsA=
X-Received: by 2002:a4a:d74a:0:b0:5d5:a381:f303 with SMTP id
 006d021491bc7-5d5a381f7abmr589325eaf.0.1721814907012; Wed, 24 Jul 2024
 02:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGnHSE=RyPK++UG0-wAtVKgeJxe0uzFYgLxm+RUOKKoQquW=Ow@mail.gmail.com>
 <820130ae-2473-4282-9be1-9f3aab1434f0@leemhuis.info>
In-Reply-To: <820130ae-2473-4282-9be1-9f3aab1434f0@leemhuis.info>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Jul 2024 11:54:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gfTKDtjsAuyMRRhaZx600XZ6q+WsUes2osRwQSoXM=9Q@mail.gmail.com>
Message-ID: <CAJZ5v0gfTKDtjsAuyMRRhaZx600XZ6q+WsUes2osRwQSoXM=9Q@mail.gmail.com>
Subject: Re: [Bug][Regression] non-stop ACPI ([\_SB.PC00.LPCB.HEC.TSR1]) and
 thermal zone error
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Tom Yan <tom.ty89@gmail.com>, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:49=E2=80=AFAM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
>
>
>
> On 24.07.24 07:42, Tom Yan wrote:
> > Up til 6.9.10, I would see these errors every boot *twice*:
> >
> > ACPI BIOS Error (bug): Could not resolve symbol
> > [\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20230628/psargs-330)
> > ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
> > previous error (AE_NOT_FOUND) (20230628/psparse-529)
> >
> > (they do get occasionally repeated again)
> >
> > and these *once*:
> >
> > thermal thermal_zone2: failed to read out thermal zone (-5)
> > thermal thermal_zone7: failed to read out thermal zone (-61)
> >
> > But since the distro I use (Arch) has moved on to 6.10, these are
> > spammed *non-stop*:
> >
> > ACPI BIOS Error (bug): Could not resolve symbol
> > [\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20240322/psargs-330)
> > ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
> > previous error (AE_NOT_FOUND) (20240322/psparse-529)
> > thermal thermal_zone1: failed to read out thermal zone (-5)
> >
> > in the frequency of *three to four times per second*.
> >
> > For the record, this is now consecutively repeated 5 times every boot a=
s well:
> >
> > thermal thermal_zone7: failed to read out thermal zone (-61)
> >
> > But at least this one would stop.
>
> I suspect this will be fixed by "thermal: core: Allow thermal zones to
> tell the core to ignore them" which is heading towards mainline currently=
:
> https://lore.kernel.org/all/4950004.31r3eYUQgx@rjwysocki.net/

No, it won't be fixed by this commit.  It is a real thermal zone
breakage.  Fortunately, there are patches mitigating it in my queue.

> CCing Rafael, who authored that change.

Thanks, I've seen the original message already.  Please see my reply
to it for more information.

