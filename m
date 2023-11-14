Return-Path: <linux-acpi+bounces-1490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B07EB7F4
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 21:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532351C20947
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1B2FC2B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJ2OT6ci"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E926AF3
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 20:27:02 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F08106
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 12:26:59 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59b5484fbe6so69347407b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699993618; x=1700598418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyPk7mTIFyi1Mq925aGtOcHWpJE/D4tGT9IM+H+4QvI=;
        b=uJ2OT6ciz6X/ApxgTMO76zMj+GuMIfsRtiGwZ5Ibk3KF3C0tKgXY7pzJ6R20zc7aB+
         x/7IPkpa7+//A7ODvD2ZPSXsHZcbtm/gE8IEIl3MdlvDXxbvAghzQmJItS7spY8X9mvp
         pTV7HSHs90cHmzdgYChQNqnIqhSRD8JqMocfP/Ldtpi1YV29uk+sSh+X9n+P4WcT6kfI
         CBrKZHWVI5mv2PAlGp/xHTbo4bcASaJgMVkvRE1JWHOR0bva03oijfRb8Sr6ChYMVIE0
         yX7LC2zLOPz60uqDLOsW+kImrgrk3gCSjIOrGwNpgTuo3ov0v9dNNWvtSkgNnIaTFYaT
         SvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993618; x=1700598418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyPk7mTIFyi1Mq925aGtOcHWpJE/D4tGT9IM+H+4QvI=;
        b=nEG/Pp73coqxuW/AM5erV7R2E6hUUXkrzXSsc9EhLbpI0BsYX+uTjLt98W+tY39gvz
         +8bw/eyXARkbC9Bm4P4O5Enr3JJHmJsAFtJUqFStCSxn/oQAyGan0YIuJUP82+cWY3fw
         jdguuK8r4tw0ZjQvInu21SQBr8is8KU5Hoo6oDLoVwy1wqS9gN6WVdp26MJJYifDxMIv
         pFXtEkgv1SWI56U5OUGTXwk8NBqPcS1qaxHzoQ1/hlUpcvgELygmvZ1ws+ANacZPOPfv
         6snBIOadQNvZ/nDPktHRCupkBxSmWRxsDy57cW5zAsdove+1lPc/0IS4BWxzwVgS8VfD
         JXlg==
X-Gm-Message-State: AOJu0YxfA3mgPhClgR4MIgIRkXR55zq/slV0DQMcWOiR+Hdrbp4QOEq3
	eEantmURL+8k8pud6W/va04creLjKrYgoqhp5DBUOQ==
X-Google-Smtp-Source: AGHT+IGDUNGrEe7ZqE1i4ZUafpug/38LIAsEh0uh+kGvuV6geQFAaf2I4fmavw+uhHRw1Ik7dYOSYdmK8vql4edD5mA=
X-Received: by 2002:a81:b289:0:b0:5a8:6286:bee with SMTP id
 q131-20020a81b289000000b005a862860beemr11437100ywh.4.1699993618748; Tue, 14
 Nov 2023 12:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com> <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2023 21:26:47 +0100
Message-ID: <CACRpkdYXqQg2Ph5R7dphQPXe03onCid-4=+V2Z-9h+F-8ak9nA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in gpiod_find_and_request()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Hans de Goede <hdegoede@redhat.com>, Ferry Toth <ftoth@exalondelft.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 7:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been broken and hence lost a bit of sense. Restore debug
> messaging in gpiod_find_and_request() when configuring the GPIO
> line via gpiod_configure_flags().
>
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Please copy the example dmesg outputs you sent in reply to
Dmitry and with that:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

