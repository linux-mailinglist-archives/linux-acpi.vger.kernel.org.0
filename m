Return-Path: <linux-acpi+bounces-19961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4BCF5121
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 18:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE24305BC2D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C9314D3E;
	Mon,  5 Jan 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u50NhFtG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6D3064AA
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635021; cv=none; b=j5VvTJ7GQoNovbAh6C31ut6RkdkpTsCMUTzVmfpW8BgLzQWRN95GhLvKeZzPetvP03E1OpvkzWrJgO/2bhZtU7JARMC7JWw+IkqSteJ4VY9tbLB3zsoDcN+T29rm5OV2+kxkC7M72wq7/rIrsYvJ+u2GejCrGnFzSMA91bUT+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635021; c=relaxed/simple;
	bh=v6CxBEPIvZ0cEfgYa6igmFyRfheVkYOQv4KhyK5nU4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuL9TdSRBOll+3oZYvV1ptgiPzQeBQnAMrbx5ssXyLNxSuNwbc0ylKsotPPyE/mdjbGQd1a4bEJotmaGP2cVL+GtBqf+dKMKpKLT60v93XqRz5NaMrOT+x8w1AR6gCy/KpPuP7ehyrcbvCStLaN/AntzBdRC8SpfbV44HF0nCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u50NhFtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CFAC116D0
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 17:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767635021;
	bh=v6CxBEPIvZ0cEfgYa6igmFyRfheVkYOQv4KhyK5nU4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u50NhFtGuUJq4BuCuVOjGf5k/0z9eZ6CmZTa5ns31/VRxtC9HlGLPA4uDhx4KdfSX
	 OjanWMIk16BXWlG9ufZ5OVRdXAUvgqUk7OFDr7qF9Wx7yUYK864fSzcL2/t9QE2kfZ
	 +skdH1NX+04WWK07VojKa1yw9dfAEdRPZjsQZoxz1vbxpr4y8RT+e/sG5Y3ZZ/BXiN
	 gAaZRCGPVZ8ccqUE1EW85vPwRP/jKln7tc5/7TGqb1mI/Pg4snIdPYtGhManu9XM0g
	 0um+7lpQPwScK0aOwMz+lIsypGM1UUw62rx8bU/c2y+nv9dicZ12QIUAaGk0X+JLKp
	 +qodpdzkwnjUw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65b3d3ac972so68815eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jan 2026 09:43:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdWwVQVZ4vuHGT+umRuZLjAO4o4UCxtvj09hx387A2gY/BNk0mUZnOCIg6+AF7g7SpBMA6D0qnIZNY@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUfE6MQ5TeHMGkETtYvbrBK86CkslOAHTUtKODJ2pvdgIUsrS
	+3UU/wI28MhL9yapt8n2BAynKnENbmD/X9EUf/CgI3l2BjVL1qBdpsPCqZauJ51I66+Zc18nhj2
	kzvXAset/FSF4h7DGYW7eNECR4tXGQ+M=
X-Google-Smtp-Source: AGHT+IGBsOtVsEv2e0G/B1PK4imGx3e9pxbQK7sNhAiESK8XV6Ab7yOClpeehZTEZnEtUklYVuen7gJ5dtw3MItMGsY=
X-Received: by 2002:a4a:e405:0:b0:65b:2944:7319 with SMTP id
 006d021491bc7-65f479d3f23mr88673eaf.12.1767635020091; Mon, 05 Jan 2026
 09:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12824456.O9o76ZdvQC@rafael.j.wysocki> <bd4c4501-7be4-4ca6-ac5c-1998f42fd4a8@kernel.org>
In-Reply-To: <bd4c4501-7be4-4ca6-ac5c-1998f42fd4a8@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Jan 2026 18:43:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h07kmUtpKqhV0YFVaf2eO3n154sfp1M=K0GaHmcBDekQ@mail.gmail.com>
X-Gm-Features: AQt7F2pC57CW3Mgr72VUXrMtuydauAmcRBhG3gvLxYwqhX4ywk-tKI5TlcItfJA
Message-ID: <CAJZ5v0h07kmUtpKqhV0YFVaf2eO3n154sfp1M=K0GaHmcBDekQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1 0/3] ACPI: video: Convert ACPI video driver to
 a platform one
To: Hans de Goede <hansg@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Mon, Jan 5, 2026 at 4:42=E2=80=AFPM Hans de Goede <hansg@kernel.org> wro=
te:
>
> Hi Rafael,
>
> On 2-Jan-26 12:48, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This is a resend of
> >
> > https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/
> >
> > due to the lack of feedback.
>
> Sorry for not being able to provide feedback. I'm still getting
> up 2 speed wrt my new position at Qualcomm so atm I don't really
> have time to look into this.

No worries.

> I do plan to add linux-pm/linux-next + these patches to my local
> kernel so that they get some testing that way. If I hit any issues
> I'll let you know.

Thank you!

