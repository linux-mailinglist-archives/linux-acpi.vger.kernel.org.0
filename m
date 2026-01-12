Return-Path: <linux-acpi+bounces-20217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65471D153C3
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 21:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D2573015116
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FBE33C50A;
	Mon, 12 Jan 2026 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="n7cVtAXY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DD33C1A5
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250010; cv=none; b=r+JlzgfA/Yas84XX1N7q8nrEpeYUKsnwImlNJwzG8njkFEsU1wJKCOhxLYh0tuOsAkorruZ5zukhFjjqufZQW5zTaTF2EZF2Io7tZKzMq2adS3SHS6x5zl8jGkUY3LyC6XxG2pgVoD13x7ejJ9YDvePPY08j1qhfZimehtj5Om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250010; c=relaxed/simple;
	bh=D53CavMbAKBuP8HtgM8AHosgNw/493IlAvWgsA9X9Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j80fYe58oWSEl0yyCz96Ey8sVASL3YeK2AjJjvMp9yi6WlRw9YV0e2WQYaatfW+k/PkYkUCmptVxczgQXNa9g8WfHm+vap59VogZttCvwE1pWpxYIcvIhP1UMYsZSRc5mB7xOKdTj9OAic3FTtC5ePINRNm4ry3zTARkSWUUTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=n7cVtAXY; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id B0EE745B74
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 22:33:20 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 403C645B6A
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 22:33:20 +0200 (EET)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 314B42023D0
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 22:33:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1768249999;
	bh=D53CavMbAKBuP8HtgM8AHosgNw/493IlAvWgsA9X9Xg=;
	h=Received:From:Subject:To;
	b=n7cVtAXYPtqBENB5E3l9iPgs8q15sJPV5ieCuhi/TPCCL6PsgdER+bMHP+INIe7wJ
	 eXK3DrhfcftMm4FCQGJd1FO7IPkWwKGUFsx60yc2Q/+YFOYYUbukFzQBmCNmlU32rE
	 y+kbVG5hwqUtOzl/Tsb24tB2PWTyS8jlHeUnlfA5Qk6Z3OzUWyLT9cbhnAeBnq3gze
	 in1Vz67CojM3Xhjs9k08Wlo1NXJtFd7Qs6OTF3di0LRG9cO2O7aOMiAmNEd41ltM3D
	 pLYzReujQriT/AbUiT6pyIUdRoB0rP8nzbK2KCXKVtF916C7308t7DLOQsLZRE3icj
	 B1ScWcPKXMoqQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-382fceabddfso47681351fa.1
        for <linux-acpi@vger.kernel.org>;
 Mon, 12 Jan 2026 12:33:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUnkc9D0Mlr0dKGCxUQDL6ZO4bDrvY4sTXEMMHLYeZXxN350PhHDzAb2mA2Ec6L2kH59LdPO0C9ci9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vm5w15N7N4mrQ6nNTKMGFj8vShnRYweJepFjHKh8y3bjVhCK
	jvIiFHWXedmq1xNybWriS2iz2JN92y9zOUPXWaFmr00KJc1/xhoT4ov3n5lTTn9FukckCH5hWPm
	yAg2OCfBEx5Rm22gukkX/dcgZZwYgi60=
X-Google-Smtp-Source: 
 AGHT+IHmnpzAjSY4F/y+o1CoN1AKtFybv+5Ydswwk61OG3azU/cY49c7LCe34F8bVKqTpvM1EzkQyG/ZwUaxCHXn1Mc=
X-Received: by 2002:a05:651c:1507:b0:383:2537:f111 with SMTP id
 38308e7fff4ca-3832537f372mr35065871fa.30.1768249998576; Mon, 12 Jan 2026
 12:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
In-Reply-To: <20251226102656.6296-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 12 Jan 2026 22:33:06 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
X-Gm-Features: AZwV_QiSJS4k4LjB8D5bJeXarreCNyXdhNZRY_SerkNgwB-TxkH6MpqT7UBBgvU
Message-ID: 
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
	superm1@kernel.org, systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176824999949.2473147.9192810424981006065@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 26 Dec 2025 at 12:27, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> This series introduces a new runtime standby ABI to allow firing Modern
> Standby firmware notifications that modify hardware appearance from userspace
> without suspending the kernel. This allows userspace to set the inactivity
> state of the device so that it looks like it is asleep (e.g., flashing the
> power button) while still being able to perform basic computations.
>
> snip
>
> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> --
> 2.52.0
>

Happy new year everyone

Small bump on this as all of us are starting to get back from holidays

I still have to bump an asus series before I get back to this. I would
appreciate some feedback in the interim.

I think targeting 6.20/7.0? is unrealistic so there is no rush from my side

Antheas


