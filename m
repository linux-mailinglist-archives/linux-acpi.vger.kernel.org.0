Return-Path: <linux-acpi+bounces-21413-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCBHNiR+qWnA9AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21413-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 13:59:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E262123F4
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 13:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD2F03041CBB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F433A0B00;
	Thu,  5 Mar 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZq1Z6aA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1B378D8E
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715554; cv=none; b=QS09y+NW4cnct3+gAxhSRD5oSfU0VG9s6Qe2AFGCM9G6JFCE8QMLBITjSilB5wcl9fm8C0OKhp7Jnn7EOXdFcYizpBPF6d9lxXAZ+XiXuCe2xTEUiA3Zyq/dpym7Nhc8GoP0cSG5xVwgPhmEZs3K7NqVvX2QMJ8dG/t3UhyiLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715554; c=relaxed/simple;
	bh=YaGVklJM6+vPIj268YCQDL+2pOq40VD8YhdiP3Qx7ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay26URWLBnps7pkwx5Y9Ia15BsVoeK43v3CYjTLGw2geNn4gJGhI088hzLsdDIFTOUcPSgfeVWZcGe27evmy6gyl46cR/wpc6gs/UgieQvUQbEw28CCVqq81BaQ8iwuHxeHbIQ6TRGENsx+RL4o3h1duVIHa/QyumLyWt7fVHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZq1Z6aA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16117C2BCB1
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715554;
	bh=YaGVklJM6+vPIj268YCQDL+2pOq40VD8YhdiP3Qx7ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iZq1Z6aAZsNPTZUWXayW2+CZWMYispH1xOGtx8AYAJla15to9gh69vT9bGXLGCuVv
	 jmt74rVorEON70lhZrHcxV04hXq3jfVaXVygsecWQXnpZfeR3SKWhbro7eO6+ixCDn
	 XfO6yrM1lWVa7hExX5d0+cXkODNVF94RuzrAlPo/LGVl2vFYI9HPihWieynuIWZnQD
	 8zxRxXnOc5MAJYmrba88RchU7dWioPCRMtHkdt/sGSO3cBOArdpy3/nj04DwRMfFcU
	 lxgz2H2dRssYWFoSCKO0Qt5Gn/Rh3m6hAKFMSD+Fz6utd9yc4iMXolceOcUmodt6jK
	 YCzToqoeLdULg==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so7289767d50.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 04:59:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW22ew+PoSWwf/qExmt4CliyggJWuX/CxAq1mPVqlOTYeIccEu4tF+aNagrrg1ROEMs1M5QSsuK+Hh7@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZQhC+weTKcZl07BjqYdAmQYTUtar+mr5G8yeOA3QBDUOYMkb
	gg9IF+fZf4w0MW8tuwVf9w5DuduP+hEkbsjwhZ9IIlQC42dniBhYXpOTGs3yAkW+Fm/kroR9++T
	2L5HC3zTGVFgog1w8KkiE5xHLkjAQHWE=
X-Received: by 2002:a05:690e:1a8d:b0:645:591a:cb6a with SMTP id
 956f58d0204a3-64cf9bdb7admr3241706d50.70.1772715553372; Thu, 05 Mar 2026
 04:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:59:02 +0100
X-Gmail-Original-Message-ID: <CAD++jLnhYc2YN2zmPG1zz8DLG1bFNFrWSL23SL1frvPDWnWMxQ@mail.gmail.com>
X-Gm-Features: AaiRm50ObTyChLnzlvD-tHjXe2KnZ0D-eRgdIfSDib-lDXFEA4x4oaLfvc_xPUI
Message-ID: <CAD++jLnhYc2YN2zmPG1zz8DLG1bFNFrWSL23SL1frvPDWnWMxQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] gpio: move hogs into GPIO core
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 79E262123F4
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
	TAGGED_FROM(0.00)[bounces-21413-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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

> Refactor line hogging code by moving the parts duplicated in
> gpiolib-acpi-core.c and gpiolib-of.c into gpiolib.c, leaving just the
> OF-specific bits in the latter.
>
> This makes fwnode the primary API for setting up hogs and allows to use
> software nodes in addition to ACPI and OF nodes.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

It's a work of art.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

