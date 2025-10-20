Return-Path: <linux-acpi+bounces-17971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC98BF0D3B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 13:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FCD1890375
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4C2DF122;
	Mon, 20 Oct 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MEQ/zL/P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50220F067
	for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959634; cv=none; b=USNcbbq+5ZAPIgBHPNZr8fWz6bUiPVl/FQ2MYelpK/q2c10JMeBVeVEl6fR3LVgyb0EuWK6SQrZcqkE5uISpkMk4CDTkIWowpEA7jw4Iho2W2jAcaPs7xLBFG2fDeZK6j756xkqeg1bp9BUDoah+rjym7bqyzKx5bcLioBpWZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959634; c=relaxed/simple;
	bh=wQwaXwcsfbQNWY+bTgc6E4fl7f0YQBbZmM/0LtL4aKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+5IVkcPsgCHVszlDk9RRJuFCJ7AeMzHqBm39q5gviSOkKZteX8/Ba+Paa5BBWIrQmiK6vJ/yTcmdSymhFxBEHttcNfjQr3RqERnHscfh6Tw8ol3RG/iW7Sv84Uunswx1wRhmgnmEZaNfzt+qdV0NJJyI8qs8qde0e2hCGXw0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MEQ/zL/P; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5199214e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760959631; x=1761564431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQwaXwcsfbQNWY+bTgc6E4fl7f0YQBbZmM/0LtL4aKA=;
        b=MEQ/zL/P1ReGHxk5Bh0jEmlfctk/m5IH3TkQJDzqLkNXCHeqjDb1jQvDdcWJcvUP2Z
         ax54OtEGEswXgEEcSgfAgadh40ljLhJpPKVlN1+rWCha28WfXif7r6vPbmHcWtbiDFQ+
         gDpc6KAqeAdg7afFdOesZIVjbSHNXY+CBhHDwU5wDl6AKReby99M8obgMznJjgGBrXJo
         oHzmx7DpZD7IDCd/qwVbPfMdHjUAein8v8CcvMZxbnSeJNEjX1pe03FEvgNr83YaV/u5
         Oi8SH+pAAlaTvJcqnYX+mau+j0h9y1XnaqX2C0tgQnXC/kDQwRMhwNlb/yEOwUVwqqKc
         FO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959631; x=1761564431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQwaXwcsfbQNWY+bTgc6E4fl7f0YQBbZmM/0LtL4aKA=;
        b=u26V0Xy0+k+SsI6ynzglBlXwD/2Kl+Jv15jbCo0BTWzJgU7obzC4wN/I/J0QfsYk20
         fSONs8waB0yXsGFJkgSwQcQVyPV3c13lPW/rLKGXt/DAExvDECbctk6YHH6Jfymhm4FX
         Fp7biZ9X0ax2qg5mGk8nPoJeTALUKu/OQVPCC4hfqlDnkJXyZUlSoGH2305u1bE15gG+
         2vLi/IIHiX7wZqyJZxWH21TI7WqEj+CpxGb5LJNM3FGHjlhTFDwQX7hCPzZ+P+Ni8C2Y
         MIlmU/bZVVy9PWvVAMA/ywfe8ytrsDeuE/Vl1YF9FVqzSKHxeHIv54q7wlI0QX5/xpMa
         KOBw==
X-Forwarded-Encrypted: i=1; AJvYcCVT02Som2wuTxpRrl722Aqa2Uvan93ZQ9C0qc319Ks260aXy4gay5fIPiVj5ye6AcwzCr/IHZU4dSiR@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqwoJic+Vvh2TyYzTCYAk27zZrrzcWx9fFLQK4U967DHYMMkx
	KXdk/yal4mDQ4VcalxQiLjv1JgJzHBV+L9k3JI2+20Pn681oefbbfGsOBJgxuI166mD/tTqmdL4
	D3KlXx0maPRHkJ1ScgdodnW0818YXCT/pNIYKNEbHOw==
X-Gm-Gg: ASbGncsEBRyQpxRZgcSFI0WyqjzK9v8+lDByPfnNcjrG2vQOzdOrdMYG4Q6uYBammC/
	MKJxO2kkzP/dRBJrYhhubB1zLipoug4//bkC0qrdSl+d0WVGNpXjST6w5dwmFKAzDFHqevysUDW
	6xMcYGzh6rNf6sxopEYETIZks3rer/dOSo+wlkfE5XdD2qOL0SAFpL/h2jPRvFhaWOcUik9GuCS
	9fs9TNWqpSNrAJvO76KUQBdpN9UiwohTCZ/+y/gw6BFlmlC7/Gg9aBc2co5PDdqUDI8DEqRg7uD
	2johm/LhlIKRzNpJakER8dZumKY=
X-Google-Smtp-Source: AGHT+IGalTfddMYmqPUMb4AlapgNAjae0CM9hNu+IF9T0qg8x8cTp34CDOE8QlIQcTGSDLGSSRT9k3sM5LmDBCOqf2k=
X-Received: by 2002:a05:6512:1044:b0:55f:4746:6202 with SMTP id
 2adb3069b0e04-591d84cfe56mr3806231e87.11.1760959631042; Mon, 20 Oct 2025
 04:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-3-6d3325b9af42@linaro.org>
 <aO1dBgPZfDJTsPfE@smile.fi.intel.com> <CAMRc=MfOoHn+mLRpQBEsC3g5sM=VZBgVffsm68CAXJBHffPxdA@mail.gmail.com>
 <aPYJeqFY_9YV9AQn@ashevche-desk.local>
In-Reply-To: <aPYJeqFY_9YV9AQn@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 20 Oct 2025 13:26:59 +0200
X-Gm-Features: AS18NWBbGp8rhOGqx7d1wIA8a09Onzo3YSJmCbDM3PxUzN3ptqkGsqAXJsQs1_k
Message-ID: <CAMRc=McBTgnQXkPoOUYC=PDDwFXuVqfMFuiwZTW7ODb6owJbeg@mail.gmail.com>
Subject: Re: [PATCH 3/9] software node: allow referencing firmware nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > >
> > > Can't we always have an fwnode reference?
> >
> > Unfortunately no. A const struct software_node is not yet a full
> > fwnode, it's just a template that becomes an actual firmware node when
> > it's registered with the swnode framework. However in order to allow
> > creating a graph of software nodes before we register them, we need a
> > way to reference those templates and then look them up internally in
> > swnode code.
>
> Strange that you need this way. The IPU3 bridge driver (that creates a gr=
aph of
> fwnodes at run-time for being consumed by the respective parts of v4l2
> framework) IIRC has no such issue. Why your case is different?
>

From what I can tell the ipu-bridge driver only references software
nodes (as struct software_node) from other software nodes. I need to
reference ANY implementation of firmware node from a software node.

Bartosz

