Return-Path: <linux-acpi+bounces-5636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0C38BD403
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 19:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D269B22F26
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 17:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1F157A45;
	Mon,  6 May 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzuw48B3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1E15749D
	for <linux-acpi@vger.kernel.org>; Mon,  6 May 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017520; cv=none; b=a7tdXcXIjf40pgmGUA4hbcE9zbI03qphK911piZPZaqj60wjzEY/TPGY9ZcXqEVytqd9ohjtMMGLNR27cs6Nw+xLtdSvfeOaA4A5KasNgn7q7VYYZaeQ5YKh5nhch5AfKeFn1AC434hi/zNozWQvTXmkPYpnETjFmHeOa+Kc0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017520; c=relaxed/simple;
	bh=LPcCtbeAnsLOce7SfLflgIRodnJTarAfZQXME5YiTAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gR5SqqKiZl8IWlTpJX+Vd3piV0K07tcKq156is3EeuAhkmoVIW6dMxzsBYR3fZ2E0i+hxrXEAmglaKfweTJsxcPpw6944hyIqJ7FClIi3KQ5IFDpZX6VUtvXNDU8mdBlOr9pNgPoDNI0EO/+qa3stPc0XgqC1CvpNnBD3xpe3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzuw48B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2737C116B1
	for <linux-acpi@vger.kernel.org>; Mon,  6 May 2024 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715017519;
	bh=LPcCtbeAnsLOce7SfLflgIRodnJTarAfZQXME5YiTAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nzuw48B3+Ov7P3zgNJ1xoeAHHhkuOIMIzLYT/YZFM2Ly4TCRRPrreIjgX++9X9cgQ
	 dONjBVWu3nLhNg7Q3AEbDG702ERH0viSW3+GWHGacFp5k//Ql9LDbYKJFhKZyjhB1t
	 dTroINkkOS29eJP1ZiSmntoKUlSe5pXUlUC4pwy5yLDwy+S9cSrQoV8brZ84HgFMXn
	 jtrgKHa1aqJXI030tYjFbjV2SJuyIJR+oEARBgJK3oIL3Fnc3nQYgplcG9ADMmwspt
	 Vfv6J6DQe2tG7ewvihYqYGkjkPt2UMmexx1K4FJQUgRzfl9V+tN38Inow6gwmAfiUI
	 p6e7mGmh3W3xQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ac4470de3bso659270eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 May 2024 10:45:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtzi4prGYlLjVqtOkhCQ09E7NfZpumFVmTLDT7YRfEQKpW3/HWj3CApgRYUEHYdc/rumlx29yxQo787m3K73pfjCaAmG+vW56FPg==
X-Gm-Message-State: AOJu0Yz8FYVTUfegQghOsYsXogxnLSYbiVeX8ReJwaLZcWW8REOs3vjz
	QAxa1dajMSIFIQYmMbUj0knzLfttTjQQDcNXHuYxK7gckEtRVdZFTpICuje4MSZetfiUU531IwS
	Jv78IfINfQ6qg/LKJ3a72r28YRuE=
X-Google-Smtp-Source: AGHT+IHYxcQAPMwxIPGVeIPuycwWU3imOMOSR1h1lHNwGaojIQ6HmxdIYOS+hyQpxHTmfRbPl5z/GR0OoTZFiSMHd4Q=
X-Received: by 2002:a4a:601:0:b0:5aa:241a:7f4b with SMTP id
 1-20020a4a0601000000b005aa241a7f4bmr11037084ooj.1.1715017518502; Mon, 06 May
 2024 10:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
In-Reply-To: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 May 2024 19:45:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
Message-ID: <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 4:55=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> There's a bug that is caused by an EmbeddedControl OpRegion which is
> declared inside the scope of a specific USB Type-C device (PNP0CA0):
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218789

And in this bug you are essentially proposing to install the EC
OpRegion handler at the namespace root instead of the EC device.

This sounds reasonable, although AFAICS this is a matter of modifying
the EC driver (before the EC OpRegion handler is installed by the EC
drvier, ACPICA has no way to handle EC address space accesses anyway).

> It looks like that's not the only case where that OpRegion ID is used
> outside of the EC device scope. There is at least one driver in Linux
> Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
> for the EmbeddedControl OpRegion, and based on a quick search, the
> problem "Region EmbeddedControl (ID=3D3) has no handler" has happened
> with some other devices too.

AFAICS, installing the EC address space handler at the EC device
object itself is not based on any sound technical arguments, it's just
been always done this way in Linux.  It's quite possible that the EC
address space handler should have been installed at the namespace root
from the outset.

Thanks!

