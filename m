Return-Path: <linux-acpi+bounces-11665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C07A4AA8E
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 12:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0CB7A829F
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C461DDA31;
	Sat,  1 Mar 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YwUKfg9K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD61D89FD;
	Sat,  1 Mar 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740827361; cv=none; b=F9qq49KUgLbNGFl5R8QbbUDqQiYd+NLERmYYWnV7oF1bl7Whg+yz0+DFe2wfvg/AIAwlgXqja4K8HtX/B1+0KCN6bFSKITI2uWZqxMOLry8VrHrd7luRZv3bg+R02zIflHlOw4MGGxPC8lv6ifqElb874tS1rPpznpaXc2c+cIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740827361; c=relaxed/simple;
	bh=u8j9VzTVmndaVO3HrV8NL99wet7gCToCq5y54FRq/LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB4ZP02ZzBVL/obiKsBbIerJ+40nGy10qy7d7vBYzsibMdXQyvbHUSbodEng61L9wlCOx+vGLWctVa1d2uKcMVws5WSVKxd6sNJcFpZggtnP3hOGIgc6QE/m83alcy2HW5mKxSvNHXF6k4BxMFK8DPGiv/rfV9EpCj5xmKslFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YwUKfg9K; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id F3C9A2E024A4;
	Sat,  1 Mar 2025 13:09:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740827355;
	bh=ODZmMANDWFstVv7l6HIL2/TBZdfFHuhroNovE4QTtSY=;
	h=Received:From:Subject:To;
	b=YwUKfg9KX1jk+DV2OCNqOm4j/2oL9f9oro6KZUQw8xbpgcSgyPkAuH5qZgsZkiNO0
	 Vc6gQ01eJbZ7Qj//twHWYiter7+Xle5Ett5F1+XQJ12sZHy+bV1uNa5LTuzQNA0HvH
	 sa5y46tM/SilENTWfPNLnA3FL5375bV9/vD0DQzM=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-30a36eecb9dso34486541fa.2;
        Sat, 01 Mar 2025 03:09:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVU52APMA4lrVfxwCPfOfLaH+zp5xPRXIDeH2/+qGeqaRLIVydPI7G0AxOWS87/YyTv/W6C6+3t2Sn0@vger.kernel.org,
 AJvYcCWXPRMwDUga05uelisqDIC4tl2Ejh0sQEvbEiU/uAhro+fU49f/u5130gCacnfzRj1wfq+CwUbD1PtFEeqN@vger.kernel.org,
 AJvYcCXM72Z1gmHigsRgEzTkHuvZKj0NNeKd7rqhxtKWAejHrDun4tPKFrd1jF/I/R8mWhg6keR3hHNZAGr0smDah4fkmdZ3Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaXqClGbmc3a8rggLV1FrLvuDSmXZqHT85QMD0Bc7FMd02Xcl
	HOwNsovDTQuo0Q0URrYo0HHx/y8JVB3K4TClZDozY1Ek6GvI7xAUCHl6tNCjunHyxpSwIPZNEPv
	U1rsPUQf+1FgOCnonzN9V1kgnLHs=
X-Google-Smtp-Source: 
 AGHT+IHTOa4F6D9CTZsCBIW6VFH+IFkkhOF8T74ihTQSD4AUyeJQikuHi1jq0jqcTJiIoHPf9JAzsEVz37+2ViBhjr0=
X-Received: by 2002:a2e:bc26:0:b0:300:3bcd:8d05 with SMTP id
 38308e7fff4ca-30b9320eb4fmr22069881fa.15.1740827354350; Sat, 01 Mar 2025
 03:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org>
In-Reply-To: <20250228170155.2623386-1-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 12:09:03 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFoqUPiZjozj5MHV5-4dVF3Ef0Wy-Sn5v38keHp2BfStQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqjRZxLi0ktJ29MmA7xLit19qlo9jBgU5EzfP79arEXoDKIV5ceEM3pjbk
Message-ID: 
 <CAGwozwFoqUPiZjozj5MHV5-4dVF3Ef0Wy-Sn5v38keHp2BfStQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
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
 <174082735531.24655.3644409426825857509@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

I just tested this. The behavior of this patch series matches mine
1-1. Feel free to add a tested-by.

IMO it is a bit cleaner/thought through than my series, so I am fine
with dropping mine. Should be as it is essentially a V3

Antheas

On Fri, 28 Feb 2025 at 18:02, Mario Limonciello <superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When two drivers provide platform profile handlers but use different
> strings to mean (essentially) the same thing the legacy interface won't
> export them because it only shows profiles common to multiple drivers.
>
> This causes an unexpected behavior to people who have upgraded from an
> earlier kernel because if multiple drivers have bound platform profile
> handlers they might not be able to access profiles they were expecting.
>
> Introduce a concept of a "hidden choice" that drivers can register and
> the platform profile handler code will utilize when using the legacy
> interface.
>
> There have been some other attempts at solving this issue in other ways.
> This serves as an alternative to those attempts.
>
> Link: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
> Link: https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Cc: "Luke D. Jones" <luke@ljones.dev>
>
> Mario Limonciello (3):
>   ACPI: platform_profile: Add support for hidden choices
>   platform/x86/amd: pmf: Add 'quiet' to hidden choices
>   platform/x86/amd: pmf: Add balanced-performance to hidden choices
>
>  drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
>  drivers/platform/x86/amd/pmf/sps.c | 11 ++++
>  include/linux/platform_profile.h   |  3 +
>  3 files changed, 87 insertions(+), 21 deletions(-)
>
> --
> 2.43.0
>

