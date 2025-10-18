Return-Path: <linux-acpi+bounces-17938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34FCBED02A
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AEE19A4B7C
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E028727B;
	Sat, 18 Oct 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMjLUinV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CFEEBB
	for <linux-acpi@vger.kernel.org>; Sat, 18 Oct 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792920; cv=none; b=aEcLfAUJDlfZlZ6kLS4qO1mbxMjqPXXDsRCOuwKTYzWFj3jyhyl5Sj2btHxPVl66RgtWS1hFMnxqFUBgP9XWGJI2gQkB2+fLlrGiOY14u8rlwMbtosBRba9km6z7PZEN/VC4rgtMCXb7zozGaPT4VRmdziuNYHymw8xO5tLJp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792920; c=relaxed/simple;
	bh=7bciMT4CrJgHKV2awrVlF94hyJakdzQzPeC7HV2JNd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKeV2uie0yvzTBVl5DyHTuCqQnkU1LXoTIdk5VMaEMYV4O2HPAOSmx7yhxi/s3e3ZeTnBIVuGJJZJgjonp4cLES8ZZzIf+5gOG7qDCb9yORLzZIkCFw1RCl31NVTTqx2ozNmpPggGiXhv+TOABIlLZFw+4pMGstVAchfKPTsrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMjLUinV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4D2C116B1
	for <linux-acpi@vger.kernel.org>; Sat, 18 Oct 2025 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760792920;
	bh=7bciMT4CrJgHKV2awrVlF94hyJakdzQzPeC7HV2JNd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rMjLUinVgFSGjl6uoU02+Ak5xAk9RNc+YqOjg9wsr1F7OOLh7/myiRCO3dUtgk1uq
	 Zqnd8dKyfQuzZmSakgHoKCPPKVZ85s32tJ2flwAhXBQJYvUiw7M6s6iToL7O8p0eeq
	 tB3lYN7t77unYj9zwavAHOOkQk12btSSeZFUKokCSA4DP+Q4DF1PapVhLd2IMS2LVm
	 9xYeylz5ORQ6uXlcG1ZrsA353w81aw8qMQiZsRSZ7CewKuA7ck3BGD+txAxncJoCyb
	 Q8Mw2ZrNJmgvuYt5mWK0W7DlDAfj1txF3ENGKZMLOVizC3KxZkZfyQ/UytzvNgDxwf
	 Tm3PT3Gm0Vgww==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43f8116a130so1626225b6e.2
        for <linux-acpi@vger.kernel.org>; Sat, 18 Oct 2025 06:08:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRerRi4HUwqrclBt6O90V1+B/vrxgOCGJH/zolOeQxrtTGTbWsF8xQI9Hf7LWNugysE5VdGW5EAkle@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTd2fBdS2/k859VjfMgNWTZRn0q4IARYTZdUy1gIFZjqYfGFR
	zEKe+gaokEh9T669MXRlVYlZfotmcVJT3OPO06oqG6Ki2r5s0mcA3jWJU9FgxPdFhKcHfC+3+ip
	A17Q89x8lx/cWkYYb5sh5FVpg9iah2ag=
X-Google-Smtp-Source: AGHT+IE3IyWD8mbjzjUkhag2HiyTdsKepKeXqIjdN5kIYqtuyLNUN8wb4rc40oFml3V6Oau69bVfccWUcXlyJTfwtRE=
X-Received: by 2002:a05:6808:1819:b0:43d:2197:c1e5 with SMTP id
 5614622812f47-443a2bdc5a2mr3278714b6e.0.1760792919338; Sat, 18 Oct 2025
 06:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-1-40435fb9305e@linux.intel.com>
 <CAJZ5v0iB4iZFs8C6EZayLVPbLz50MJ9GEniSHfbP31-yHRg1Bw@mail.gmail.com> <20251017211015.GA7078@ranerica-svr.sc.intel.com>
In-Reply-To: <20251017211015.GA7078@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 18 Oct 2025 15:08:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9AnWNzrkpf25Cri0FEcimMs6W=DDjwJ=mBBpZ1zPNyA@mail.gmail.com>
X-Gm-Features: AS18NWD6fdyJ9GswWIBppzxjyAHenHHv81mhe71Mo9dApeffRiexv-v6zB6M85M
Message-ID: <CAJZ5v0j9AnWNzrkpf25Cri0FEcimMs6W=DDjwJ=mBBpZ1zPNyA@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] x86/acpi: Add helper functions to setup and
 access the wakeup mailbox
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 4:48=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Fri, Oct 17, 2025 at 11:46:59AM +0200, Rafael J. Wysocki wrote:
> > On Fri, Oct 17, 2025 at 4:48=E2=80=AFAM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > In preparation to move the functionality to wake secondary CPUs up fr=
om the
> > > ACPI code, add two helper functions.
> > >
> > > The function acpi_setup_mp_wakeup_mailbox() stores the physical addre=
ss of
> > > the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
> > >
> > > There is a slight change in behavior: now the APIC callback is update=
d
> > > before configuring CPU hotplug offline behavior. This is fine as the =
APIC
> > > callback continues to be updated unconditionally, regardless of the
> > > restriction on CPU offlining.
> > >
> > > The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer t=
o the
> > > mailbox. Use this helper function only in the portions of the code fo=
r
> > > which the variable acpi_mp_wake_mailbox will be out of scope once it =
is
> > > relocated out of the ACPI directory.
> > >
> > > The wakeup mailbox is only supported for CONFIG_X86_64 and needed onl=
y with
> > > CONFIG_SMP=3Dy.
> > >
> > > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > This should have been
> >
> > Acked-by: Rafael J. Wysocki (Intel) <rafael.j.wysocki@intel.com>
> >
> > The "(Intel)" part is missing and I omitted it when I sent the tag.
> > Sorry for the confusion.
>
> Thanks for the clarification Rafael. Does this clarification apply also
> patches 2 and 3?

Yes, it does.

> Also, if no further changes are needed in the series, can it be corrected
> when the patches are merged?

I think so.

