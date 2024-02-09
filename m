Return-Path: <linux-acpi+bounces-3319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB484F5C5
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 14:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E80B21D62
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22D381B9;
	Fri,  9 Feb 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGKaKcTO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330E381AB
	for <linux-acpi@vger.kernel.org>; Fri,  9 Feb 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485141; cv=none; b=YlfLZEwofruL6IJtGNR7kOgeEt9t0KmS0k7s0fZueQdubJpZbwpeDayDyofVH85ianH/+oCOecNjsLBi28dPQ1HUu8Hoh9WtEsWz0iXFO5UB7Bdsg7z5Rfax4DKME/WSE8A6ozfhYrVRiOJ6TX1O9aNU+jS61iEft8NDzPU4V2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485141; c=relaxed/simple;
	bh=IRmUxOo8xpxTnzyDJCNyfLb+z4mUKnik1Xz78qZ/PLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3Y7CFBKStpgT6W5Rd0DNfhEBK3pUB6VNey/Q8dLMJhZ4PM7Ic5ZS8evR7kNAqGZ5YJpv2NdVTtRQLlJv5suMFi0eEmPcs0kyEZLVO73Jf2f17Va4lvAS/dZbL406xozthF15+hZMyAlsf6ZVMBKuAs6FPwB85TucpSD+e9hUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGKaKcTO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6002317a427so9201937b3.2
        for <linux-acpi@vger.kernel.org>; Fri, 09 Feb 2024 05:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707485139; x=1708089939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRmUxOo8xpxTnzyDJCNyfLb+z4mUKnik1Xz78qZ/PLk=;
        b=eGKaKcTOx56l8syxpmNdORtvfXee5tlq8LQKtoASetDqHFT5gAAcQ3ZdrDp/N2bpOf
         A2GuCZBV7fLfOl5E3u5IK7XofXkJXx1avvcUcuPxuKfO+N4UWtZYisX7buCcM0kD/7xU
         bS7d7xBy/xtX7/T4bLwuSpcmL1JODEn1W39VebRBDvgbIzMcpOSk2A5a2l0JOA9h/Fip
         7frhE3m/eQQ7s3xdezZIcAKIkAgyTpK85KdXYSNKzI3dy7VD8sux5nBltNqJC+ofG6aY
         zOLues7a4ZQEjHWfS0EJUikRMQnCvPCAPvMu2oGf3lQ2F/hDELSrvdZJVL1wEC68YGGL
         xrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485139; x=1708089939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRmUxOo8xpxTnzyDJCNyfLb+z4mUKnik1Xz78qZ/PLk=;
        b=ffl2nUqZPjECpo2pp1UDjHkIGwHWgkd8N9Zr2j02i4RSBVthoHQY/+qlDhsSiV8+BD
         uT9w1tOxoBYWun61YPOOVrgkGJVUshv+ywdeg98ev+uI7LQCDi6jrUUW6rYgycY5XSQT
         pY/R4rc4VMMkDy3MeLbDOLYSfGFR0TOmBw6feQNXsFXERPun5oe4llhExuLfDfvLaMm+
         kpPanzvKM4okT9OaY+3O7XuFk6SPJeFxqhL2QdDuYeuLkJxvAB57CXeHNS0SN1qDTygf
         hvQSXs4JuRjoYdX+wTrHiSXSQj7YU6C3PiEnzd+GVf2Lxvpsd6QHOyU35ZIarHzBpnwQ
         MYPQ==
X-Gm-Message-State: AOJu0YzRZ+Sbk+ii4gBNvgHkQ8y9YKMQxSJYmSi4y3YRDYq6uTOxutUM
	TH8zx3TBWRKSNDhuw3x8w1NBjUklJCqMoEX7LXnN3bOTpgX02IpZb1aUaSI0QUqP7e+4R1Sc7nk
	a4KXBPtzrb3msugEMDGw5V7xwff7Qgb4RXnoOeA==
X-Google-Smtp-Source: AGHT+IFKR6S4/G9DmrvM0mEtaFdZwkbCXlZkhaqKJtQhDFVowF0KrwEF85bMCAPU+yFzG20W3ToCXZz9/ObHLrZrmKg=
X-Received: by 2002:a81:7255:0:b0:604:9c2e:923f with SMTP id
 n82-20020a817255000000b006049c2e923fmr1452942ywc.32.1707485138749; Fri, 09
 Feb 2024 05:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:25:27 +0100
Message-ID: <CACRpkdaCNJ3g2gRWmcrBQ3KeXwfH7i2Xpmnm1NAgi2+ASLwMUg@mail.gmail.com>
Subject: Re: [PATCH] gpio: constify opaque pointer in gpio_device_find() match function
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The match function used in gpio_device_find() should not modify the
> contents of passed opaque pointer, because such modification would not
> be necessary for actual matching and it could lead to quite unreadable,
> spaghetti code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

It's what we call a pure function, good const-correctness fix.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

