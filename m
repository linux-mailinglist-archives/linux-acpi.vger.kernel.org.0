Return-Path: <linux-acpi+bounces-11465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A306A44605
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 17:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4543E1882A51
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3418E023;
	Tue, 25 Feb 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="tNP/9R0o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3044183CB0;
	Tue, 25 Feb 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500856; cv=none; b=nuS33hCiEUi2e0+Ts2vMXJ5Mjbfq7ZbLpAlsipAkC7WMcX4IoOIHoknyMOaMWWfS4++c0tsDDAe9DqhiwMz7R1rVdAh5qzv2iidxVXZ1Q78AaM/6lLgIyAM5dCqPo8f9b/RvQ20taPOH4mH1G2ge2PiUdyym9VnC8iodXYUJYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500856; c=relaxed/simple;
	bh=BdJtZnTV2i07SNC32yy0QgGJM8y0+NMRw9EmWllffYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7mkq2C5OvZduYvCm69P8SyeHT2Wj4sud4G/7oupN0hFy1u6J6rekSON5/E1zQsAgtiYnG5+ync5RD28ZR6Z97eu+Ei/0KbEKnWKH77C73Dm49NJ4nGMMgxea3NVK4iMpA77w1RxaOaddvQxmptz+/+3ktqUyT+Jvv69FbwfFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=tNP/9R0o; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 16C972E0904A;
	Tue, 25 Feb 2025 18:27:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740500845;
	bh=NnGd3+Erk9r9ZZ2TFe6MqU7NYineZtnKsCzncysHX0s=;
	h=Received:From:Subject:To;
	b=tNP/9R0oSfESPQvz6pGPWLQN7SYMjYF109sGAiCVnAcvKQyc4FJikUZ2y/kOXaczp
	 scQ+s5tlnY9dzvRRR+gkXLwGBFF5iIL1AxIVUAx6tkugK26vIpUzcNF8waqK7CoVZu
	 U/cpy3SJ7h9xl/Py+0j5oH6KwBMHv99F5CtCl0wQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-30613802a59so60210751fa.0;
        Tue, 25 Feb 2025 08:27:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUHM9XlKBIkKC8BYIbEM/4fXekR8ofFfQyRLhWDJTO4QAF20STNBBNzSK2htSVaPN0iUVxIFGE0Lvxe@vger.kernel.org,
 AJvYcCWOGnnRXvWVdPmnadjcvR12mJUELGay17EmXP0SQIzRsaaP3B2prXjuQG3sO5DsgFOGpwTXCbOHpa2vFqXg@vger.kernel.org,
 AJvYcCWSD8SRbWQT5MekTgn+zRF4HpB6dCY+l4Ty1+rg3HbJgmv8bgeq2y0wAxkvcglRadpbcVfDn+uJEtEGUUD1mxvnlxlBgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJiO+7aC/kBN4tdlPJccXgGK4C+ejEopqgJYXCPx5IH3cKzh2
	p8d9UEfdrfa1Y9NrALQNryBTUvKb+7bxobg7C3ou4e2uOjJye0Wkm/lFslZXxjPjkdnEXztdfdT
	Nq6O8LLG0rfSj8f/wvK/CIW8nyAw=
X-Google-Smtp-Source: 
 AGHT+IFsEd4oylDEyrfYtIXluntvlN8HJd7l3mUHfTBfJ4KDbootcyCrzrgRIjvvg0uN4xvbU3BUYWc5Q5DfEy0x9AI=
X-Received: by 2002:a2e:9ecd:0:b0:308:fedf:8c12 with SMTP id
 38308e7fff4ca-30b79133d87mr2041851fa.5.1740500843364; Tue, 25 Feb 2025
 08:27:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <f5d39d3c932a78a5021877230c212c620edc586e.camel@ljones.dev>
 <CAGwozwEWZxWzcTjPby4OeUz+CCXbvQAkvCExo-Qc7=r-0-6BCg@mail.gmail.com>
 <5cff4286-2800-4bc0-b243-5244d19a64b7@gmx.de>
In-Reply-To: <5cff4286-2800-4bc0-b243-5244d19a64b7@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 25 Feb 2025 17:27:10 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFS_D4k-Q-QUums8FMZ82p_5-RzBvZZJX1k7_YP2E1cfg@mail.gmail.com>
X-Gm-Features: AQ5f1JpbOG7dozqD-mEqecwiGnoINaSfPy5IByhYBSLlH1eBPPJoAtDSCeMqdxM
Message-ID: 
 <CAGwozwFS_D4k-Q-QUums8FMZ82p_5-RzBvZZJX1k7_YP2E1cfg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Armin Wolf <W_Armin@gmx.de>
Cc: Luke Jones <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174050084442.5352.9862764441592976971@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 25 Feb 2025 at 16:56, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 25.02.25 um 03:26 schrieb Antheas Kapenekakis:
>
> >> If these "scripts" use `platform_profile_choices` to get their
> >> selections and verify they are available then there should be zero
> >> breakage. If they don't then they should be updated to be correct.
> > Yeah, if any Asus users wrote scripts for their laptops to e.g., "echo
> > quiet | sudo tee /sys/firmware/acpi/platform_profile" or used TLP let
> > them spend a few days finding out why kernel 6.14 does not work. They
> > should have written a 300 line bash script instead.
>
> Hi,
>
> using "echo quiet | sudo tee /sys/firmware/acpi/platform_profile" is quite
> brittle, as some hardware will populate the available profiles dynamically.
>
> Still breaking userspace is indeed not an option here, so we have to think
> of something else.

e.g., for example I had a tdp handler for the ally and had to
transplant it to thermal_throttle_profile when the breakage with
amd_pmf started happening.

> snip
>
> This whole driver was likely written by someone as a hobby, so you already
> depend on a hobby here.
>
> That being said, i agree that fixes have a priority over new features, and
> i think everyone agrees on that.

Indeed.In which case, saying people should use your hobby code perhaps
is a bit overreaching. Haha.

> Maybe the current strategy of the legacy platform-profile interface can be extended
> without introducing the "secondary handler" concept.
>
> The current strategy only advertises platform profiles supported by all handlers, and
> as you pointed out this causes problems for users on certain devices.
>
> I was thinking that be can change this strategy to advertise all platform profiles supported
> by at least one handler can then do something like this:
>
>   - handler 1: supports low_power, balanced and performance
>
>   - handler 2: supports quiet, balanced and balanced-performance
>
> -> legacy interface advertises low_power, quiet, balanced, balanced-performance and performance
>
> When setting low_power, the closes equivalent is picked for handlers which do not support low_power:
>
>   - handler 1: setting low_power
>
>   - handler 2: setting quiet
>
> When setting quiet, the same happens:
>
>   - handler 1: setting balanced
>
>   - handler 2: setting quiet
>
> Basically all profiles get treated like a range:
>
> low_power <- lower end of the performance range
> cool,
> quiet,
> balanced,
> balanced-performance,
> performance <- upper end of the performance range
>
> The only problem will be that getting the current platform profile would be more difficult, as
> the legacy handler has to determine the lowest currently selected platform profile.
>
> Would this approach be OK?
>
> Thanks,
> Armin Wolf
>

So the way this patch series is designed is that the new
/sys/class/platform-profileX works exactly the same.

Then, when asus-wmi is loaded, regardless of whether amd-pmf is
loaded, you get quiet, balanced, and performance. Like it was before.
Setting it to quiet makes amd-pmf use its low power setting. And it
will work the same with all WMI drivers, regardless of whether they
use cool, low-power, quiet, or balanced-power

When asus-wmi is unloaded, you get low-power, balanced, and
performance. As you would with amd-pmf on its own. 0 ABI changes.

Series is small enough so that if you don't like it, it is easy to
refactor out during the 6.15 merge window.

$ cat /sys/firmware/acpi/platform_profile_choices
quiet balanced performance
$ sudo rmmod asus-nb-wmi
$ cat /sys/firmware/acpi/platform_profile_choices
low-power balanced performance

Antheas

