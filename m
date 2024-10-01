Return-Path: <linux-acpi+bounces-8509-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A598BF97
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 16:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85476B24A80
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0671CCB4F;
	Tue,  1 Oct 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fw9NwXWd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE71CCB39
	for <linux-acpi@vger.kernel.org>; Tue,  1 Oct 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792043; cv=none; b=WkwmWeB/imS0swHBob/XNaoPIvAGGx3aoCS1i2dUubxSe2qFWQ2auyW1hGwKCEDBhWDfBJsiLIntRfRvprDyc6QoMMTLTWnPnxNIfSsMltA24VCGA3GE8hf4Hqhj1GQf6ZYDX271SRNB9THwbHdTNitp9w2A433Ts2ze4d1TCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792043; c=relaxed/simple;
	bh=c9k27wF4HRgpLueBG4Pf2APtXo6yuM+OkrBzV15ubFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIX9ntptTOi71oAPoByUXND8HYzNh37jb7rc8KW/IE/IKoeq1foRpg+gDDSihnVGoCytM0nBvXLvLG15IcCYvy3RNoM7/ZH/w1xpNFt7iygfZGbA/8utaH4rzOD6BaoWu4NqjRfAXnu/dVXcQez+cNJf8jvTEXXgs/aq24+nOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fw9NwXWd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53997328633so3075220e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Oct 2024 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727792040; x=1728396840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bsrbSdX6EPWFR3XqD525RkRXnDDB9V77qUREJTrLp8=;
        b=Fw9NwXWdKy6L1/FQpqN+ZMi7FLHrwxbjXD6e3FvDV9+PWxmJ0KbAFOd/KIQQIOacbW
         ygK4I9s7sfjqHQ7QeM9rkz0nSYwquxGkH3oIht79lsL8h+kMvTecgsyT5cLyRkSEAVdT
         5JtnGDHBZcda1ood9PVQ93mF289jXwzJhgNYV6aaFQ8pPaCuWyi1kpBwfPXBfi4nvuxy
         ChAcrT3NMX1f8LlETIc28GgClD72zPlTlOh/s5YAb5dQ8zzZr4UotcSn6Yop0+ESY3V/
         R0W8g2oscGCkXc2ONHRIuqOcpYhvU0BUX3nFj/toTeN13ZTM3iod+ReKUdv9PTdUkKJM
         zJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792040; x=1728396840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bsrbSdX6EPWFR3XqD525RkRXnDDB9V77qUREJTrLp8=;
        b=d+wo206hmCSJU5fzXYsYtX0YsIDEzSLaqP5FxR1TV0y1JK39dZ5nSl4HeaL77h257j
         Hnm4PBzfIflQj2s8gR8dDPFnmY7+wX5pITTJpX/6mtj9AQ8ZxXaRAwFC1g3m1WrqyVgL
         PXDIKI8ChWe44oTomrrtpi0zS+2B0BA/h7wFLzKByVc7tNrxU6RmOZyfgKhotngi58F0
         R5DGosjBp50QHOK9jGfPL5dnizZCnUJHbM6jxjvDNGAApCDUa7ttQ6zPflq5mom7PF5C
         1kqnUXAMaMrNlZSTw5YdfrUt/BMAMCUhW4YLDGJDJY2yhzUYcFOgA8pESlmHgI3Ak00v
         B+kA==
X-Forwarded-Encrypted: i=1; AJvYcCU9N5B9VG0fIz/wF0n/efryYPczexxxEjxxJ74gafp0ARWt69BJnlfdtBdK3AAAVDHiASMOUoWtlKV0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pnuXlj19acIdAF3wSp8XhMzh/wVFKaXzsyMBKrGHMhAU7Omz
	jX4BPz+P5KRDiOV38ysvTXnhCOhDXbgITSuYz4hIO2OZ+USzFtpbuLWtw7XFgllQu64Sw1IB7s/
	FLmoxmUUT5LsMIHenVHBTbAbat9s5Ov1vTC4AZw==
X-Google-Smtp-Source: AGHT+IH6ZblbuHzeWYNgj0qMbKQe6HIgMe33csaXGbHVMylssdfO2oRVeVcy6SqujgFdACrOi05i6ciessxhYK0oDP0=
X-Received: by 2002:a05:6512:108d:b0:533:407f:5cbd with SMTP id
 2adb3069b0e04-5389fc3445emr12362507e87.7.1727792038590; Tue, 01 Oct 2024
 07:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
 <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 16:13:46 +0200
Message-ID: <CACRpkdb+C5u4cQ0EapgXTzuwL-9CE2MrimRd11U3O8c6vajjNQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: dwapb: switch to device_for_each_child_node_scoped()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 9:47=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:

> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for a  call to fwnode_handle_put() in the error path.
>
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Neat.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

