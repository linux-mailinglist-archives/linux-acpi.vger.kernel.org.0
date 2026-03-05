Return-Path: <linux-acpi+bounces-21415-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAd7BRN/qWlB9QAAu9opvQ
	(envelope-from <linux-acpi+bounces-21415-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 14:03:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A1212518
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 14:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25CD1308DCE1
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04E3A1A35;
	Thu,  5 Mar 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRt/V5Y+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3733A1A22
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715604; cv=none; b=T/DTLh6G1OrbP+qB4P7JLAJC2UQTQO7rVMzRO3gMe0beUcCCsz4VYIPjRTSamvV0HKDtlWhdk7T+LX+a11Ga7Jjx0wfxn3p+Aq/6evPATbV9AO0f7ErsAl2qwnnXH4BfVKmZZ3Y1xc4bNFeNSF9UGoyEyEW5xrGrDt4Fwsup8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715604; c=relaxed/simple;
	bh=MQFjFILC5mkY+Vwv4pWWykfJ7vYhfaqzdPLfw43t0cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btZgi3MUoMqd0i5ODTGIEATMElWD+so9CyJ4z9x3g8J9dqCLVQAh8jFQNzJNBifVEadBJnLhHNjLr0D+jvkKrRHNNrWrIKG9wM5ZefXKN9UDZSBUdPHZqwqEo1W4ieHqLFOaBtBgUZmiikrmZGkIzf6pAiuGdc/xIg70bFuu0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRt/V5Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DECC2BC87
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715603;
	bh=MQFjFILC5mkY+Vwv4pWWykfJ7vYhfaqzdPLfw43t0cM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mRt/V5Y+XF1IVSwG8+jgRQQyCvpXzrM2yGEMcTCtiKo92vOK/oYAOcv3PSeRo6LjC
	 4hpJ6MZp11xMwkEB9Ia5N5Lo4ZLUYuS892vquqkFTEEx5MKE0Zjypla34/hbRsbphS
	 4xUuDxfZOdkz/lUEsiGPSWi6n1d9I2BG/yFhmm87TI5WSOZcxOXEw6Ga1P/Ttxd5Lh
	 r3WNQsdzdQ+1TuV++pGiJjlLiHdiBYpVJMZbu/ZnVpgSeCMRnFVj2jq2WeGtTvL41j
	 C8Ir1Z9pBStxgl/rgavHxyBM4Bj38b2tMKwxcOAU+ND9sp3Lz98VfkZdiIW5f5RIa7
	 P8t+8Zc/xswQQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986a347d4bso78737087b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 05:00:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBRZcDxyMwU3b4yaJmXKGZ5D0yVUm7iJTk+Bv1KjvP+YgjfZ03Ym8uRNMxBtWSJZtD2Gapg5bVQDas@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhpaSgE0V7txY06S00jolWPcuxeNsyFauu37dFMz8rJ/K4hvF
	0Nt2IheLZz0XX6wtVP2giq5jaG55Dh43XTS3RrhKzcUvsri2EXZR+78RGj7ZX6jvGvboJ1AIsWi
	5blChSBWf+4olxeVZA8tIpW+CT02ZpaQ=
X-Received: by 2002:a05:690e:448d:b0:64a:e7e0:a70c with SMTP id
 956f58d0204a3-64cf9bd6f89mr3303741d50.65.1772715602763; Thu, 05 Mar 2026
 05:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:59:51 +0100
X-Gmail-Original-Message-ID: <CAD++jLnW=6CNK3F8T8UHR01UfTk7CUwavB9dwv-Ug266mVcy4g@mail.gmail.com>
X-Gm-Features: AaiRm53RubGlDYUWuLep_26rBrnPyLYf-1xTz_QksBGDgogCNI444BwJT_n_uH4
Message-ID: <CAD++jLnW=6CNK3F8T8UHR01UfTk7CUwavB9dwv-Ug266mVcy4g@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: omap1: ams-delta: convert GPIO hogs to using
 firmware nodes
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
X-Rspamd-Queue-Id: 783A1212518
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21415-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 10:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Setup a software node hierarchy for the latch2 GPIO controller defining
> the required hog and stop using legacy machine hog API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

