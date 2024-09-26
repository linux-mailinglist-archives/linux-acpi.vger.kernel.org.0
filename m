Return-Path: <linux-acpi+bounces-8437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FAD987224
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 13:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B1F1F2560B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A70158218;
	Thu, 26 Sep 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="VXKXyLXp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7701D5AA2;
	Thu, 26 Sep 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348435; cv=none; b=fQYN5awvnExOhz4uFy0txhAsJfKpvv03/XBSpEFvH/A4cO0b8YI8a6dZ1ow+B7iz4Ahr2KzkgsB3nY+oH2RnjBer5ehNEwIyPuqe412TRWDu5ds+W30tyG3WhxaGq08OFgEscjOcOO10b9r5uCHDOZhv9RN0Ymem6FXzfPMzlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348435; c=relaxed/simple;
	bh=Pc9TQipB1PXhPa7yxQyCZHQQyfF9tPgiTNX4o9cxzGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz62JONBhBcpT7kvd6NgAVfagcs9TmRzw7BNG69oOjB+CLaE8KnFYHFl03G1TLASbb4e/TsaGvfDMfHbCM7AF+sbhX2Y+BqjKjAOELP4aUNWzW2HlaGTa7OKzVVf0r3QYR9EHxTbjzu1UJm/+pehKgCEaDCtUi6wNjPLyeHd0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=VXKXyLXp; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id CF6C52E0341F;
	Thu, 26 Sep 2024 14:00:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727348429;
	bh=Pc9TQipB1PXhPa7yxQyCZHQQyfF9tPgiTNX4o9cxzGs=;
	h=Received:From:Subject:To;
	b=VXKXyLXp3chwQqlZhyWs3BlTwzjaFsMOcN8A33h5YzuK+A8VVeHrj1y/PX56WWkZ+
	 degBIPSY58RgXNd+N+fXPH29ONsbOz33BdcLI7nBTLO1Lda1e2pRvYiNardLY9o8g6
	 LAdl24D1e9qt52czejxU8e8U1sNmyoXyIBR/8J8Q=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2f75f116d11so9824451fa.1;
        Thu, 26 Sep 2024 04:00:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVR9SPFBk1kPK7ZzuLnd3bGc1F/3Rv+5OaxWDc2EPZl+S9yinjN3ZT3Fts3ZQh/wRdjH4Hnl+8yEWlosW3j@vger.kernel.org,
 AJvYcCVloSAVO4ohT6N4LFqp+v/GHpTG4LGKiJFIbNugUK9UeO0FHneJb3ia4/FeIE6G3K8aF7jl7ZnQKVBDKfloCUoHRsbyZw==@vger.kernel.org,
 AJvYcCXmhSvtbtBq6RV78qc/ib5aM3t9ilRPMgcF91rY1Odab30lKnAQ5unrVBMnhLfy3/ITUuRhOic/M+64@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCaTYeb3g1n0PA0dMuZ3wQZ3UXFKeFfXLXRBvvHbTX40Uqfmk
	3VNG4bdgtyFYXAiLGhvRNamFBjLLjkeQQQ6u7BhlP97sASByaHxg5fhB+vKkG1byJBSAqxdSBl1
	sozixPvRxrddUoe2Yfay9ughn6OQ=
X-Google-Smtp-Source: 
 AGHT+IFO9a8ZqmMJTgUiVOCjewruLn5HCAF8pol28Te+3WoJXoS2uVX7hcs6mSAmRYDeyIFNrrGzqccjLKpD/X6pULk=
X-Received: by 2002:a2e:d09:0:b0:2f9:ccc3:38cf with SMTP id
 38308e7fff4ca-2f9ccc33a62mr4456791fa.37.1727348428018; Thu, 26 Sep 2024
 04:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
 <5a75b73f-dcb1-4a45-9526-194a3451b5c6@amd.com>
In-Reply-To: <5a75b73f-dcb1-4a45-9526-194a3451b5c6@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Sep 2024 13:00:16 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGtqwOOfrUpjLghW4JCKqcFk9ut-X0MBvHAm37YVS51tw@mail.gmail.com>
Message-ID: 
 <CAGwozwGtqwOOfrUpjLghW4JCKqcFk9ut-X0MBvHAm37YVS51tw@mail.gmail.com>
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>,
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
 <172734842939.27093.10360311400567677248@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Shyam,

> I appreciate the proposal, but giving users this control seems similar
> to using tools like Ryzenadj or Ryzen Master, which are primarily for
> overclocking. Atleast Ryzen Master has a dedicated mailbox with PMFW.

In the laptop market I agree with you. However, in the handheld
market, users expect to be able to lower the power envelope of the
device on demand in a granular fashion. As the battery drop is
measured in Watts, tying a slider to Watts is a natural solution.

Most of the time, when those controls are used it is to limit the
thermal envelope of the device, not exceed it. We want to remove the
use of these tools and allow manufacturers the ability to customise
the power envelope they offer to users.

> While some existing PMF mailboxes are being deprecated, and SPL has
> been removed starting with Strix[1] due to the APTS method.
>
> It's important to use some settings together rather than individually
> (which the users might not be aware of). For instance, updating SPL
> requires corresponding updates to STT limits to avoid negative outcomes.

This suggestion was referring to a combined slider, much like the
suggestion below. So STT limits would be modified in tandem,
respecting manufacturer profiles. See comments below.

If you find the name SPL disagreeable, it could be named {tdp,
tdp_min, tdp_max}. This is the solution used by Valve on the Steam
Deck (power1_cap{+min,max}, power2_cap{+min,max}).

In addition, boost is seen as detrimental to handheld devices, with
most users disliking and disabling it. Steam Deck does not use boost.
It is disabled by Steam (power1_cap == power2_cap). So STT and STAPM
are not very relevant. In addition, Steam Deck van gogh has a more
linear response so TDP limits are less required.

> Additionally, altering these parameters can exceed thermal limits and
> potentially void warranties.
>
> Considering CnQF, why not let OEMs opt-in and allow the algorithm to
> manage power budgets, rather than providing these controls to users
> from the kernel when userspace tools already exist?
>
> Please note that on systems with Smart PC enabled, if users manually
> adjust the system thermals, it can lead to the thermal controls
> becoming unmanageable.
>
> Please consider this perspective.
>
> [1]
> https://github.com/torvalds/linux/blob/master/drivers/platform/x86/amd/pmf/sps.c#L193

This slider looks like it would do what we would need. I will note the
importance of tying the slider to Watts to manage user expectation and
adding more gradations (e.g., 15-25, every 1-2W for sub-50W devices).

We have found automatic solutions to not work in the handheld market,
as most AAA games will consume the maximum TDP the profile allows. In
addition, due to performance non-linearities above e.g., 15W,
performance will be similar. For example, on the Legion Go,
performance might increase 20% when going from 17W-25W, however
consumption will increase from ~30W to 45W (50%) which greatly affects
battery life.

Therefore, we need to allow the user to choose between 20% and extra
battery life. If you think we can use an algorithm for this I would
love to know.

Much like you, we dislike AutoTDP solutions that use e.g., RyzenAdj, as they:
 1) Do not respect manufacturer limits
 2) Cause system instability such as stutters when setting values
 3) Can cause crashes if they access the mailbox at the same time as
the AMD drm driver.

Thank you for your time,
Antheas

