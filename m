Return-Path: <linux-acpi+bounces-21412-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPQaBwh+qWkg8gAAu9opvQ
	(envelope-from <linux-acpi+bounces-21412-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 13:58:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF4B2123D6
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 13:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF42C3044BEE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5BF3A0B03;
	Thu,  5 Mar 2026 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV+iriVY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F193932C0
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715523; cv=none; b=uYq4dHFL1vdb5+E3iYyDjFM1nHlCROoIwepiLXfDyVUko/H3zo6UpcM0o6mcVS0XHXOqJCKc9b+mZf7PMMjlBeCfNpYjvBglg6/CmxcgDUgiKD3SqPVI2mf4ZCZ29iQSaO6rtB8W5m1r5TudZtR7wvNIAS7E/LvrG7ZultA8+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715523; c=relaxed/simple;
	bh=5are5agdAPBNhp9zXXwfI62i9NhVAzVx4EzODqm4TGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL4BwnxKMvsXmmJW3qRoXiVK4JrI0Cqfkm0R7UqU8+RD87nJq7/3+KROwW4zLvp6vWHoD/Ybm0g1e30mgQ3ZPp0V76A/7+OgUlpZwHxI3iggBqrQ2MNkfm6d8BWbNjIosEV/GGZH9RBm2dcWFgrZmDyEVNebZx3ELS5mD28ESUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV+iriVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C3C2BCB8
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715522;
	bh=5are5agdAPBNhp9zXXwfI62i9NhVAzVx4EzODqm4TGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dV+iriVYRSVkaLwZWL3RYxUVzrSC8aD09FYxF5jNKwSm5Q1YyPTJsFvSzgCigsGzx
	 HTMHgHkuc6N4hI6dLH2FrL4N6624GGkh2DzGuYN82jY6oeYT+0ZZnShusqFd4BG/Kg
	 B1JkTJG72xoKJ5V5FpMaG3Mde4MvfUWAe6CEvDOvdpIy1wzvO2zDb4SjHoqi08W4+n
	 btTVRpbcLf83Ku7WUyELXiwkcystoAPidj7LlhvuXaGCjIxxaUHfn6lHoq+76cQZRJ
	 8fJ63KdmGO1rwKGTsIhQpXPFjeeJEKbzRjR4F1fnBj4tMXrZ/dSOKAtgx8OzbOSDqF
	 t6okvHWVh3vLQ==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9c8f8783so8374587d50.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 04:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsxINxf5M5bw6BIa18mRq3K9q0zt6M5LOhpLaXvx9qVs77bccW5jpZ3XFfO46CKbvx0HmLe+gfTfDG@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJFeCYAoJG7uuxoUX5WKAB94/gkJZTjV3w6iqOSVCN0oG4vQG
	eVnShSs30Enlki95gCvS9s9Exgsgl1z5fpi9tVdlKeUE05YqUPWyNv6efW1qF2p5hqhkAdjq121
	7W8QbrKkZXxqRod1ckEyadYF7ZSHKpvs=
X-Received: by 2002:a53:e19e:0:b0:64a:e56f:49fc with SMTP id
 956f58d0204a3-64d07111ed8mr1184395d50.20.1772715522083; Thu, 05 Mar 2026
 04:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-1-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-1-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:58:30 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Zog5wPPiDDBp=mv1nhCgjOZkuG8NtZjvzfhc0KK5Z7Q@mail.gmail.com>
X-Gm-Features: AaiRm52DhevPDbjjg-MMnWaC2zgG9VailzGdf5hJANa7pRgxzk-RHGIdAAju58g
Message-ID: <CAD++jL=Zog5wPPiDDBp=mv1nhCgjOZkuG8NtZjvzfhc0KK5Z7Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] gpio: of: clear OF_POPULATED on hog nodes in remove path
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8DF4B2123D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21412-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 10:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> The previously set OF_POPULATED flag should be cleared on the hog nodes
> when removing the chip.
>
> Cc: stable@vger.kernel.org
> Fixes: 63636d956c455 ("gpio: of: Add DT overlay support for GPIO hogs")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

I have no idea how OF_POPULATED is supposed to be used
so I just trust you on this one:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

