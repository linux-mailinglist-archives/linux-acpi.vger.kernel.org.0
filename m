Return-Path: <linux-acpi+bounces-8585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF99930DC
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D261C21755
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D471D79BB;
	Mon,  7 Oct 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHnfPs3J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE401D2784;
	Mon,  7 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314110; cv=none; b=VjbVLHp9wQAk3k83+hA5LX/LfWpbTvtSyKBgxeNb7a204uk7x5XhnIRfT5pdmfbbR7oUq3VbM/bRKVFqQeVO7NpV3noxs+8T0eIjxg+uZpTZH2N3TfjOGtDJQS+SBGkiITPCuV8kC8h5ReLi77W38x+njHiWDpIwZ/xUgH35fvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314110; c=relaxed/simple;
	bh=4LDuThyWdMNsyf1fyk29kDAVrzEcbQF1sfliAgr2Rsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoUbB+Y/LgiBtSCDZnL85nFWpXwpgPkQP5Rn8FitQZ1ZEJ14JKDH+APA6M0GsIkpMT1zeL1D52ha5ECG+DPnI0nSiNr6T+WHJQI1OypyJFIje+3euJ5Q7Y24mXLI73xrcTJabiRK7n+uz1lCmzt9Nc+jXMf5FHM/9GCq44vQEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHnfPs3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77A5C4CECF;
	Mon,  7 Oct 2024 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314109;
	bh=4LDuThyWdMNsyf1fyk29kDAVrzEcbQF1sfliAgr2Rsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bHnfPs3JovhKOPJia6Y1mU/V6rjGoWMcRq3E0lkEHGoMLuUs4rmImXB/3maati9zr
	 CZwz+Mh7NVY6QjBNAmjCpl72xi9Az93LGWfr6gU1RsDVFnZTRnKDKOtk/36THh3+c2
	 AKNC7hA+zz+2kyG14l7LiutmL41s6+iwdqIA5Dm9uzcZLw+XkzOgmyh3PKz3z4xiR+
	 WCV2P/yV3saTvMli00m6UoFYSCHJgalP34HsyL1Nv9KouPZxW+2hx4KcwwjoaH9/I9
	 G1otuaV/xUKCjkwPNJVRx2Auw70iFitkReefVlHYDmfrTFjCg/N5hbvTFIw8/8f9YL
	 gbN3BIt4Z5zLQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e0465e6bd5so1927418b6e.2;
        Mon, 07 Oct 2024 08:15:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEj+S1g/1kAA+UmXljCVVk+t/IdO8ito18xJBx40X1/c43jzB9n00PxSvICnQ7QD2XCPk4Lo6kbdRZ/mnJtjw5KTejag==@vger.kernel.org, AJvYcCVMj/2Yeaa3HDJNbR5+MZVmphVENrZvCN0zq6nY6BjfIJ9nzVGju9vJKq9Zr5TlMQSBXB+rkp2Ytuud@vger.kernel.org
X-Gm-Message-State: AOJu0YwqY1hgFmBJOA7sdk82SheGxcHGD+cKwmz9JdSogQmm4AGqtgDk
	so6s7g3RBftNfkZIvwNSBek/a4RhrUt3nu7+7tbC1TuampnhO5JI3oq/7xuupHP4Il6R5gA0WPY
	p9WyP8MSt0pLNWzM1IWqp0ox71uo=
X-Google-Smtp-Source: AGHT+IHmku3lngjvNFQAQ4MNIc3A0Fzsojqg2B3RKxhVMeStHRmdpgbDqQ+g10BHOmCAhfnJzAXFQxTNeHpdBqOzLwQ=
X-Received: by 2002:a05:6808:2388:b0:3de:16f1:7659 with SMTP id
 5614622812f47-3e3c1329770mr7176728b6e.11.1728314109027; Mon, 07 Oct 2024
 08:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005212819.354681-1-hdegoede@redhat.com>
In-Reply-To: <20241005212819.354681-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 17:14:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iewd+hmF6ZrXSPTs5_aKov57taaRKEoBM5VaRefrdM1Q@mail.gmail.com>
Message-ID: <CAJZ5v0iewd+hmF6ZrXSPTs5_aKov57taaRKEoBM5VaRefrdM1Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI: resource: Improve Asus skip IRQ override quirks
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, "Luke D . Jones" <luke@ljones.dev>, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Oct 5, 2024 at 11:28=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Rafael,
>
> After receiving yet another Asus skip IRQ override bug report / patch:
> https://lore.kernel.org/platform-driver-x86/a983e6d5-c7ab-4758-be9b-7dcfc=
1b44ed3@gmail.com/
>
> I have taken a closer look at the existing Asus quirks to see if they can
> be simplied to cover more models.
>
> This patch series removes 8 quirks by making the quirks match more models=
,
> while extending coverage with 3 new models which also need a skip IRQ
> override quirk for their keyboards to work (including the model from
> the new report).
>
> Please send these to Linus as 6.12-rc# fixes, since this fixes
> the keyboard not working on 3 more models.

I will, thanks!

