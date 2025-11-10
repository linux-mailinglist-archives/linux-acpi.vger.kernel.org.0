Return-Path: <linux-acpi+bounces-18746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF1C483DA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 18:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D615B3A7973
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A297C279DAD;
	Mon, 10 Nov 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MEYP/0cv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C626ED3E
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793883; cv=none; b=fFDeoPInJogkvAEtP0ov1hX9Z4oZQMpXXW4jYYWH5Vj/Kxwtk2JCv9uCsdJ0EoNK3GLFzKVBwsnuDYae/jTvyEA7rQVibzeU0BZ36L/VONXKldhYFbsaDLLyr6gmeBUjMDvmgtnoCHsl+6VpNzivrgKGNRDhZasGtM+KHzn4rGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793883; c=relaxed/simple;
	bh=rrUjnTakXAhjUzCetAR0m4o3R3KIpOKUlQf3gmLgolM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9LIAL+ZnCwfC2RgwfICh7hM4SRk7JIx/auxin0Z7XQJThZO9UpNQLzGOcx1vMgK5J8LnYknQM4gToSrEXrr1JS25olTNB9Hej7EsWitttXTI5NBHCAy1SJz6DVNEDyDyMEvk0CxZEtwZLSVIsrn1OT58wq1leWWHzoO7FXZjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MEYP/0cv; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37a48fc48deso30615721fa.3
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762793880; x=1763398680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrUjnTakXAhjUzCetAR0m4o3R3KIpOKUlQf3gmLgolM=;
        b=MEYP/0cvrBchnVCREqvREUfAZlphv8AnrHK5zz6Y1YkhmPRDB60IQuOIf1RDxASPxm
         slZgADqbkKqIuvxuWEmZ23vGEkb+MfGQuUf0vJdf6DX2+hyv/f/j3smxqJfPA47iV+7w
         fnV/Y6qp9JQRLBWeYURaouK1qAORSVPHMDUuaea7YV+NWGTAB5+zHtLs0JylzzRpN4Zd
         HlcJ5U4UMVrEPtl7MR50FdI7uX/hxWQ82JJg7pKyvP/R1iLJqg1n3IArvK3JPczx1b7M
         S5qwxTCLh895cbteCbZDIWEm+5JfW/liwCPtIEX7U00Qwl8hghooQeexSW6p7N6y+w8p
         0/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793880; x=1763398680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rrUjnTakXAhjUzCetAR0m4o3R3KIpOKUlQf3gmLgolM=;
        b=tY5PQVXYRPmpAuMiZxxWIl0WXb/JyfAcmjc2uinT66f9onvq1dytDF3Ie642C+E5o3
         fIsR7ClZvf8A1kond35Ys4QhqL0gTkGNxUwYdnjOMwJnKR8Q90W/6xDI/qJSQfeeoKQ1
         fbBocZBjEG7Q3vF5zS6LPu1hdOOxUE/EapuWlS3gNMTiFuU5ksEkqtKOtlqBgmlqEcAk
         PBoUPIgK3917cBa1FmFcEhp3/pl0hOfCSKHWZu9rcM7uDV9Nw3NrEPuZLZSWiJWdBAbO
         NbVo8Otj+oiRwKgQ9lKuUmkpIR/WCw41ORq7EHz6KFwGuBk0te8r3CW1exiKgKTLpRzZ
         qCBg==
X-Forwarded-Encrypted: i=1; AJvYcCWXO+cvhr7KZ4u5+1WIkiZfWcMCNLURhsjm+K8HsOpujx5ks77CWiHaiZ8M5vkiESzaSNUAbWADo2eq@vger.kernel.org
X-Gm-Message-State: AOJu0YyU0ZdqFXLoWwVeE1UsgtMtAF4hbpOgxPFgSF6B3k07END+XBnP
	YcW2lcJFkjCoEj4Z7vSVa3oZ7/7kRNWseIywDCk9Y0WwyUJkoaxu9Jj+F2tvtYTUOPmHVqJobdu
	aU0dDHt5PMWEQVTxfWADlj7fv9aLrBwjubRtJJyqQGA==
X-Gm-Gg: ASbGncuRQhxtd3/gZt/KLpOwgeWEtrYrcRfkPusuI3NRCRWsgA7r8lK4IGbUmLH/JRO
	ifI1CI3Xbjrs3k2+PLL6hhqtuySw1/7jLUpOK1o2clM/h3o0DygdrPOdwU3pwDPnOH2n2xv120G
	NxCLuoVJCzoZghqzwRjIfBaQK4rfF9OifmG5ZA/NJPXJeFXKoBE9IfdTv8u5vx/Bbb6n8Pw2kew
	tMfe+7q456pWHoZBEDDEm++AVSIHKvTZUGw2eXgQzzx4uuyUbIAotWj1noaOwijFumljpBsHzpT
	UTKv6aWEdyDhSHpS
X-Google-Smtp-Source: AGHT+IGZ2hmsCEnrLKC/NZdMcRsSFhcLnVybLvsgXS8FrcxJdKYTw8c0QvLMaeSHjGAt6FxVSze0EYel51frgOEUO/U=
X-Received: by 2002:a05:6512:1152:b0:593:1063:938d with SMTP id
 2adb3069b0e04-5945f1b6d61mr2560629e87.30.1762793879972; Mon, 10 Nov 2025
 08:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org> <e0e81310332cfdc075bf13f66d7be712b42964ed.camel@pengutronix.de>
In-Reply-To: <e0e81310332cfdc075bf13f66d7be712b42964ed.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Nov 2025 17:57:48 +0100
X-Gm-Features: AWmQ_bkZgrAGAfJ-PeZMB30nsvIDn1ltlQZOczM8EP-iNuFYEeVCmNXK45hyn0w
Message-ID: <CAMRc=Mfcir56ZizXgZZpt4nQY234PA9jx3CQ24YCVQJFBQ7msA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] reset: rework reset-gpios handling
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:02=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
> > NOTE: I've picked up commit e5d527be7e69 ("gpio: swnode: don't use the
> > swnode's name as the key for GPIO lookup") into my fixes branch and wil=
l
> > send it upstream by the end of this week. It will be part of v6.18-rc5
> > which tag will need to be the base for the future immutable branch
> > created by Philipp.
> >
> > Software node maintainers: if this versions is good to go, can you leav=
e
> > your Acks under patches 1-3 and allow Philipp to take it through the
> > reset tree, provided he creates an immutable branch you can pull from
> > for v6.19?
>
> Now that -rc5 is out, could I get an Ack to create an immutable branch
> with this series on top of v6.18-rc5 (and merge it into reset/next)?
>

Hi Philipp,

I assume the Reviewed-by tags by Andy and Sakari under patches 1-3
make them good enough to go in?

Bart

