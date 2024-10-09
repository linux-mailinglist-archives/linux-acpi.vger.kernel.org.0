Return-Path: <linux-acpi+bounces-8673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC1A997574
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D259A284C32
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5831A2643;
	Wed,  9 Oct 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVX1dmNR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D11E0E08
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501042; cv=none; b=dwXNmJeYPxbrDE0zZd4uhFRc0itlWCVpgDN6FOqDPZy6f4G/9854BuBLcqXvtKphBTsVIpS5ZLZxG+XXgI+dFXdCXheV74493sIxGMQCyzONsKc/lynR4vrdPZ8mIvon+oA9WYT3kZyuh/KGNp5DmIGjVpp8JsrKxltw4xT9uzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501042; c=relaxed/simple;
	bh=64VCxJqJGNGh/NXOLvuOVDTcE/3wSEKJ/qJp2U8Y3N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAYqyWgnybiNJPcqTX7SmJFnoYCT7E8unnYEDcs+vn19fZuvyR9g+IKa1pks3chCYPd5lmNHGa34jOpwtrIXxvAqCaFSi8LjqXFh6WMDuA1XJdplVezmhmi4MP4Z1U537W1GI+TtPxyaOuoXdfOTLfuECiksfPMLRx+NReMtSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVX1dmNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB93BC4CECC
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728501041;
	bh=64VCxJqJGNGh/NXOLvuOVDTcE/3wSEKJ/qJp2U8Y3N4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PVX1dmNRs0TvP7XL2stS/j/FwCM26d5lbbwXQXhDj8m/aAPsQjlZedfl+dE1T7AM+
	 ao0Xh9T9FPXnQVvS4NMz7Vt2wJrzqj2DLToSfmdOGKDEQgc7QSHcoX7nVEeSV7MLGd
	 zu3vqzvdjNz+1B7/z0hrvROBEh1jsjiOfTMLRmRqEqn6/Q5r3fMxJ9I1txq0X4fvM0
	 heZlahivbgdOut754jZh+0YtWYFL267gkeNsHrg2KdpLeq3dpfW80rfTl4T2mRxDi3
	 YATspyeUfdeINl+PAPyx0PCxR9TzCifMgBZHm61+BTErgeD8P0jGMkc4T17zwv6Rtw
	 H+NXIfRgzKVsw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e3e0a8aaabso79277b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Oct 2024 12:10:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz0qxfns0aK8f2uuRaHzW3gibP/bcHcGJ3oU1iGH14PfMLvrUhy
	j5x4FLLbvXTv8TMvf/l8/7Jl+PBgYQfbrNgaOV5lgTO9BatnuUY6BDtcxBGy88aeRxqWqJoHGzM
	J/BcHQ77TZ/H3Pq7sOkOPkv5VzEg=
X-Google-Smtp-Source: AGHT+IEWcctCfr9vhVUJ1wmxZda8IRBoDP4qowB5J9ACFw496LszPG5E8CsEjaEedrXXu7ncOTA9GU41Airss4qKRdo=
X-Received: by 2002:a05:6808:2dce:b0:3e4:d683:c242 with SMTP id
 5614622812f47-3e4d683c2c7mr1455453b6e.15.1728501041089; Wed, 09 Oct 2024
 12:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9e29dcb-acfb-40e1-a283-4cef9b60c5b5@bigon.be>
In-Reply-To: <c9e29dcb-acfb-40e1-a283-4cef9b60c5b5@bigon.be>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 21:10:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jRHEj+Y1F5tmY7MYe4jY8dZ3TpDDqs+L6BS4QxfxQALQ@mail.gmail.com>
Message-ID: <CAJZ5v0jRHEj+Y1F5tmY7MYe4jY8dZ3TpDDqs+L6BS4QxfxQALQ@mail.gmail.com>
Subject: Re: Dell Latitude 5530 battery drain in s2idle
To: Laurent Bigonville <bigon@bigon.be>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 8:59=E2=80=AFPM Laurent Bigonville <bigon@bigon.be> =
wrote:
>
> Hello,
>
> I've a Dell Latitude 5530 and it only supports s2idle.
>
> If I let my laptop in suspend and unplugged the battery can drain
> completely overnight.
>
> Searching a bit, I'm apparently not the only one if this issue.
>
> Any idea what can be done to trouble shoot that?
>
> $ cat /sys/power/mem_sleep
> [s2idle]
>
> Running debian unstable with kernel 6.11.2-1

File a bug at bugzilla.kernel.org and let me know its number.  We'll
follow up in the BZ.

Thanks!

