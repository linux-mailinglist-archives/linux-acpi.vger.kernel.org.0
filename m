Return-Path: <linux-acpi+bounces-6302-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F9903C15
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A65E28279B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D551817C213;
	Tue, 11 Jun 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+6MxKfK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D217C20C;
	Tue, 11 Jun 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109554; cv=none; b=Q6aC427i3DL5zMPX2IHE8PoMgwQACltR18JXR4cRXJlmYuWUTEURyoR+xCK8t7Gw+YrKT/jEkwLkKHza9C+rBvPTewiiGf5qUsqyhy9ZKcVBIiQ6s+i7+acemm1uO8qPHHHdw43mW6/pS9SS5cSExF7028XFP01nJOfvBUSKYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109554; c=relaxed/simple;
	bh=bW6N6pj+DmUeZYsB0tv4MaS4r2DUYTYQ4hrlW1hr+uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItcvXo7FJC9jNsU9jhIskkgLkH2gjN0/CQvQlol7NBbbfy7m6sBs3huaiWj+1Yk4xMAmZ7JleZmR2YXS06jSm8D/mbB/2lXkX01YloR5XbA6ccfzsPm96Zht1L0MBM0sOctZM5m5DP8trPWBKA4PjQxKnKHOPymxpZfDX/5NNUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+6MxKfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FEEC4AF4D;
	Tue, 11 Jun 2024 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718109554;
	bh=bW6N6pj+DmUeZYsB0tv4MaS4r2DUYTYQ4hrlW1hr+uM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r+6MxKfKyNWX3xxuRi9FmnSfI1nAnVK4zhMqUwxAuGQOEBYZQtginPo3VKo8DfhDl
	 SeFLrnyNNA0U6b7KW+DR62zKPiNDtv9txGDvC4gxszldGbIuDR8NwYtZyWPkjmU5Mj
	 LRCSN9N2SPC84tCJOvNW8K2e46Mx9akbgmGnrjLhpB9ns4ds6R7ZOb3On6vw79QhbG
	 xf2f6WWw8fD1bMljgZg1yeu0JuVz50PwlZHJzTSjsCEWl1wgwIeldKXbsLKGK7uvgl
	 o1T0rx0EGUt3odyv/lNeO3N3D6AU99Li9Cu0JnnUNdv8XBLBD6YK8T9TXKpwV42mtV
	 2oKwZ8QDY/SUA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b97f09cde3so660979eaf.0;
        Tue, 11 Jun 2024 05:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgtI1QkTtIIg4nW5OBJ1zRY7f7F9JWo/1otWWmdxe3Gr/GVSNChmj/dyu3vUW69fMEnO4sHeQ6U6Fnm+TTjMdqT67DDNd1i2auLfIYWIRxfHDa7Pw/CezRk8S0DQ4D21fMWP65ciO28g==
X-Gm-Message-State: AOJu0Yx0gpxXeFivudBLVdnBG4rDU7MStpkog87WhrezdjJppR85ezHQ
	gT0mtloSlPCp9zsR1rpu980C3AtEgCNR1um1AHQW0WzFvNfTCtBKgFfiZ50cDpWOYGSCJrrWwN1
	6TcaW+PD6F55S1UKgEMOvqpKPK0w=
X-Google-Smtp-Source: AGHT+IHjW1iEa9gr1jDZ52bQX+S72S3JPpspolo5XoM0RZeO2qfkBp4AnIYKZPBY6dS6CCOvrEXxw5/yw2lzlWYBtT8=
X-Received: by 2002:a4a:d483:0:b0:5ba:ef94:7dc3 with SMTP id
 006d021491bc7-5baef94829bmr7179416eaf.1.1718109553466; Tue, 11 Jun 2024
 05:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <af575951-d884-4148-977f-a3450ceaee82@leemhuis.info>
In-Reply-To: <af575951-d884-4148-977f-a3450ceaee82@leemhuis.info>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Jun 2024 14:39:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjQVy0OM9okhGRiR_hXLjksn2aDcRd61dyKkdHCn3Qhg@mail.gmail.com>
Message-ID: <CAJZ5v0hjQVy0OM9okhGRiR_hXLjksn2aDcRd61dyKkdHCn3Qhg@mail.gmail.com>
Subject: Re: [regression] ac and battery readings for asus laptops (gu605)
 broken since "ACPI: EC: Install address space handler at the namespace root"
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:48=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> Rafael, I noticed a report about a regression in bugzilla.kernel.org
> that (if I understood things correctly, which in this case I'm not
> entirely sure of) appears to be caused by a change of yours:
> 60fa6ae6e6d09e ("ACPI: EC: Install address space handler at the
> namespace root")
>
> As many (most?) kernel developers don't keep an eye on the bug tracker,
> I decided to write this mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218945 :

Thanks for forwarding, I responded in the BZ.

