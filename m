Return-Path: <linux-acpi+bounces-15017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B803AF8BD5
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A053F765A74
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E600D30E84A;
	Fri,  4 Jul 2025 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDxrdXgx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8C30E848
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617002; cv=none; b=lfC1kVCdnRzvGzdY0yYFaSX9hulUhKCIByQJRhLpkbrOyWI9PVdIn3SGscPFPqqqI/KjKUlDK4Ea4oK9CbTy0/XPoH3xT9/bg/T8zveqSVwfw8uGen9HJhVJwIjTeTJOxt8sD5vSuJVKqzgJpcQQKP/Vy+7OyevK6M053iE51JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617002; c=relaxed/simple;
	bh=dGsMdWNNo7Kr4TZt6J0SFs0hAUGLXiGKCsH0gVxSZ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkB6IzY8lpB4gkaFnUukgl9W+2xCAjWj8gIxvbzlu+PPGuajYyWawUs3cLUNQYBZzs2v8sDdTq4AcR+MJy8l58IS2D1Q7rVA9GQliWShF1TmDnIghJLdc0sqAr2KWCBTta7yjMg2t+/4O9M9TCo1yB3J2CmNEE/Oii2WI24GknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDxrdXgx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so2003324e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751616999; x=1752221799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGsMdWNNo7Kr4TZt6J0SFs0hAUGLXiGKCsH0gVxSZ0s=;
        b=fDxrdXgxOfdi7SSlHV4Eiy5iK/bF4aqPxcx8rCWDKZMQgW7aev2sPzpBbJsSq8k9jw
         6AwupaY6Wh8yoDzUJyZeQ6m5dC5r73pA/HYy9CDTys/JyXHlfSRi+qvnG/a1bthkicJy
         /9fcfkMh2fdOzZmbllNzhQih2VX/I7Ej1CbhV/Yjmd/HQi6KwUcmOLZvd3JD8gRjR6WS
         PUuuD9dGuO0/eGCgugUC19e8589IHkCKx9sn6GPn53VnXOmjz0TVZStSEQotT8FjQHUv
         8HdMi30Qdc3Ydg+aFP9YYw8/oBSXUDHriR+M66MVOmfCYd/724mjzm6njFq9gvpnPWqZ
         it3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751616999; x=1752221799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGsMdWNNo7Kr4TZt6J0SFs0hAUGLXiGKCsH0gVxSZ0s=;
        b=G7KBbIIgkofRXzZS+LwWh7XZ/8nMTIYRX4ZAPu2fS4KIz6xrCMyWlb10M2P0bm4Zxr
         cJ38mkVxmBAirlcLxV6ZJC8zbISfcUDwLGET1W2sP22bL2af3OV5+hDoN0OqeeuwRbBY
         b5Ss2PVTY+KaG74drqBD3tCdI0nt1MZltF3p+UT3BaU3sFsSJMgIpltAZ/tcyZh8a2lm
         b4OjwGkZaIXMAdKXdRykcKKXWuwNs2VoQvDeg/k3c2I0bDTi2zSrrFx0xQoR2o3MgOJg
         hbAeqavO+Wob2Zk591gFKAxfujbYCXyl3ASHzqgefeFDp7nygsEO8tWbBp00x/GAam6i
         Pqtw==
X-Forwarded-Encrypted: i=1; AJvYcCWt7wL6WqI2g7Zb+IkdFzl93FCu0bXkQDMzYHogG2dUlw/D4CmhE8dOdPgJYTRORuxly3WnGyL9w3+m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9Mf0342RCggKVFqi9OH0AlsivqBFamdyLDKV8wp6NrJqkz0t
	gI9yfZ6KWRhWQYrPhu3c4GrvQ76OUCDUX7cTTVJ+bQ9OuvOlW9AQj5fd0zKdw3qelCplwVENBqp
	OkBsuTozZ8JQk+zUzRta1+HqhVxhuU2Tq535c5C1h/Q==
X-Gm-Gg: ASbGncvSN6WeeucA36aJx9MHs2makWtv7/vNfsy3lMZCxh/Q8/5vAFB95EyNBxRwbly
	3Js+bRNXB4UhephBICRpLP2Q5D3fhlQZVahpPdXKCSdnu2LP7dx1qzIVDK/g78Uqa/0bZz1fUhg
	oFO0pYYvnxDqZDwtu+G9aHK0E7MuN1Kv0Md9xSdaF7zts=
X-Google-Smtp-Source: AGHT+IEUHpxlHJAaJyUnD91z1Awdc7+mfmlcOB7ydvJEbIgyvKJk/YjEvZBui91QkwXNtGOS6lwTRVoL9chNvbUBeNA=
X-Received: by 2002:a05:6512:32d6:b0:553:cf72:45d3 with SMTP id
 2adb3069b0e04-5565840173fmr528205e87.3.1751616998945; Fri, 04 Jul 2025
 01:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com> <20250702051345.1460497-7-apatel@ventanamicro.com>
In-Reply-To: <20250702051345.1460497-7-apatel@ventanamicro.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:16:27 +0200
X-Gm-Features: Ac12FXzg4WuZhSIauiG8DCqEO1Wj-Rdq7FM-OMSweMcuUZLpJE_RoU4DDONVAww
Message-ID: <CACRpkdZc9EpUkd-Q3T__4U0XeqTQnxnmW2K=O0BBobgXiQna9Q@mail.gmail.com>
Subject: Re: [PATCH v7 06/24] byteorder: Add memcpy_to_le32() and memcpy_from_le32()
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:14=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:

> Add common memcpy APIs for copying u32 array to/from __le32 array.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

That looks useful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

