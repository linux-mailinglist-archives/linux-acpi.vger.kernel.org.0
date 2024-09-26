Return-Path: <linux-acpi+bounces-8432-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AB986F52
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C9E28138F
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE61A4F2B;
	Thu, 26 Sep 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="m+q4TPNx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F418BC10;
	Thu, 26 Sep 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340761; cv=none; b=nDyPz7RK27+uauWdpWIWsabTxiATbn/6GCmOfayITWsBvd7Qkl/YL8yd0Jck5T9Bm7VDFAES8LkqN5S65VRda6pKywX+RuvL0i/j/9XpEhqQ2ns8ifljYEQAQ48CqrXfhVyjoGvz8KmducdB5ick6jht3q+OJzJ5FcLOEOmFBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340761; c=relaxed/simple;
	bh=oy18m8RZaRVgX9n5xHBRwSbGnBlqfFvRdv6wRivv1Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQxIoPgEi1l2oho5JUxGPdWHy1PWgaAazU+b8i0+5hgQq69g78XMuS8FOQOd5TK1czSsxt7Sc9eGCyvts/fRixlbHZpWHnnetiKaQ4rSjj0pVOC1xa3BYBXol2AL7zxlDHrdE4KZ6ubjpdMyh695Na7RghHE7N9mp4kWLW98HCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=m+q4TPNx; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 6285C2E0866B;
	Thu, 26 Sep 2024 11:52:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727340757;
	bh=U9ttzOWoUk0/DwNWB+B0Z0m7t2cu/R4OCUjEwwIRAaM=;
	h=Received:From:Subject:To;
	b=m+q4TPNxuzAnLyA+mvOSyZ/J8XjnVaQksd2KjQO1IoJGFbZOkC1IH+tf3mLv1jc81
	 rUk/D6Ozk8AE4Gxm7yUNAy1RVt1hOC2bwx9929jpf0ipPQOEvACUTsYhO3BN2zwQsu
	 mzOB7nlcZp/yy1OFogfagH35XS5Jj9LfRP/0RfIk=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.44) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f44.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-535694d67eeso793039e87.0;
        Thu, 26 Sep 2024 01:52:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ4rcla0xz6Ul+7aV/W9+iA+5yC23E6PCGGckwO+0ai2cGUGgfp3rT0hqca9Yz/6xVevyRQcJKADUX@vger.kernel.org,
 AJvYcCWMSpp5JwmFNyRAxiR0Cd6S1ljW7DGrHNLJ70HgeafvQMd8ippFjdVE1OYPbQ7T5j1ZOQxEZNk1hyHhdC3N@vger.kernel.org,
 AJvYcCWnlbD+v7MIJsezggW13lsxwSGDx/dmwdbffavAX8aQ8U1uHDk3KMrwbFtep4hoycv7OtjN9eapmlo/eDp9rA1usTvtlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVVAxRBV2l0ioLRzQtyTCtQHA7dRlYOsHL3lRX2D52PkGucvj
	LuGL8sPXsUkMcDvzLnCnr7FtfsrRE3ZVgYQ06+ZPU8ULihgcWWYVKmmsgI3NYRKHQuthHDxeM17
	LYnPftdfrU9qXZkz7Yf4uBpz/B4c=
X-Google-Smtp-Source: 
 AGHT+IHdD2hQ09b5fe6DdTTWvoDOTymvDNCOHOE1wydutsdimeFOVJ6d0EgfXT1nRc0pXvXLWJB3wiMZe2evT85mmRQ=
X-Received: by 2002:a05:6512:1287:b0:533:4322:d03e with SMTP id
 2adb3069b0e04-53896c0e20bmr656423e87.25.1727340755762; Thu, 26 Sep 2024
 01:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
In-Reply-To: <20240926025955.1728766-3-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Sep 2024 10:52:24 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGXh1RV96hvSEd3HQoKGY+DeRPrhcKMxJUu7STRZURsmg@mail.gmail.com>
Message-ID: 
 <CAGwozwGXh1RV96hvSEd3HQoKGY+DeRPrhcKMxJUu7STRZURsmg@mail.gmail.com>
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172734075684.2819.17467176703074109703@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Mario,

It is fine to require a module parameter for turning on custom profiles.

However, distributions such as Bazzite use per-device kernel
parameters, which, while user accessible, will not be modified by the
user for 95% of use-cases. In fact, the Bazzite update system manages
the kernel parameters of devices automatically.

What this would mean in practice is that for devices where this custom
control may be used, the module parameter will be set globally for all
of them and taint their kernels.

Instead, only taint the kernel when entering custom mode. If combined
with something such as `custom_mode_choices`, only taint the kernel if
`amd-pmf-user` is selected after that.

> +{
> +       add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +       pr_crit("Manual PMF control is enabled, please disable it before "
> +               "reporting any bugs unrelated to PMF.\n");
> +}

"Manual PMF control is enabled. If the device supports other ways of
thermal management, please use those before reporting any bugs
unrelated to PMF. If not, only if setting TDP is required for testing
(e.g., under load in specific thermal conditions), proceed with the
understanding that this module may cause interference, especially with
the amd-gpu driver, the suspend process, and, if the parameters are
out of spec, general stability of the system."

Antheas

