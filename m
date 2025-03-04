Return-Path: <linux-acpi+bounces-11752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78504A4D6D9
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 09:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76EE3A4CEB
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61731FBEB3;
	Tue,  4 Mar 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acHnUO3D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11843172
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077879; cv=none; b=gDR38uGlnvNbW68SwDmHo6t4vb6l/UntoX7qkQWetVhfsoC/8HzcWb43qTYfT1eebAIIWbTT8IV9bsGcx6RvLI6yl69Bjkrs30Z9zBRHlNGavtO7e9DzRUN3obhpl23ksEhfeKWjAoYZOMiEzCE/CDcu60IxIdwMYkF0aBz6cWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077879; c=relaxed/simple;
	bh=dPMt8sQKcYcDHq3trJrxd+nQzsHylruteqNco7rulhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPo4dKLOF8pOR8V+J37R+ikXEgNmIU1EdtwSHhBDpae/KlP5nh88PhYCwrevemco1vns6KcGkdqOcyzaNTfOs/zX+Bc9YFWzbnp2da8vy2oRZEgMGxgE5mbEB0PF3+2e/gKUzl0KwMmRiVyZbRlEv1tS4KUhFeDVvv79rFayM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=acHnUO3D; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54959d1a856so2903853e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2025 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077876; x=1741682676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPMt8sQKcYcDHq3trJrxd+nQzsHylruteqNco7rulhE=;
        b=acHnUO3DNAApJzGhWaPZ4f0L4KJ7lPmfBgD0Ea0KWTCOiZbQ+u56qyvQfuEslTbTuB
         ZuXzS+Uwe99ZVopMDPVc82at8m5z/LG1X8weK48CO4HIH++ueURRcnBMK9YLl494gXfB
         He5j4irJvTxWuOI4ISzwXWUqqtrWpZ9YfdVB7Y7ARx3ZU60BRdkaRfWbLsRrTdi4Zg4V
         sv1JZCEPXPOnH8lvejfET0G7yWx1cYG0N+iq8Sb5Q1dvsK3+AcMIKA1iV5Mkjx7Yzhka
         E5CfZtFOByM99K8vwZ2hOm6gBjszbrEnJ10GsTBoA0QGl6aMi2lfqJxepG7y+401y7WY
         TvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077876; x=1741682676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPMt8sQKcYcDHq3trJrxd+nQzsHylruteqNco7rulhE=;
        b=fBG9hzG+QJSiHwdBuMYjxuDlhqNkysVlfdCTLsEmHEjmtEy6C18TB5fDjhh9EoQBdR
         TU2AXvJnudsD6zGOZNglOBhWDYXmdF8Dcx3GTYPcDl/iK4AJ6q4hE0U4yzzW1XJ+NaMT
         wm0q0mNIfjdhtpVdeXbGTUklwfAGjGrtsIV5BEOZYpSxGRIkkWAA0pwXv/nk9RRrk3x4
         6nJ98vZyS3GIVmYBuhoxpGCp9KRHN8pLhV4mUKN3ddmk7tMHMJksVeI7sofN3pFLnDCb
         IHX+muKvG23xn7kVO7gMFbz/JrSrfX45ue6hhcKymnf0g6WGlBKaLQjivmP22sNmHeHP
         YRLw==
X-Forwarded-Encrypted: i=1; AJvYcCWAvghcAWBpm811Yel+vkGdAcvPZrVVanyxpFcURUs2tkqG7avf/3VTWANl40YL3VespQnjx7l4D7Su@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8IZ8aefi/x9rfzRoKHZUP3L/xkudt7Yz7ud5e7SX5HkpESHw
	aX0AAJgzPJfrDwFZqoL5xTs5KPwrE/pl4knG2mlBDF16DTRAviGWrslgukVKchBZxdN+eg+IZoA
	qSxVTDmebvRDlUKdtAZErqDURgJLjnGGe+kstKQ==
X-Gm-Gg: ASbGncv8UNbcWhO3fEC3E704+eoe/qGNAN6LixIviXYaSLH+KZ30doEzLpBZw/I5YlI
	WtSmJnxofoAkONiEdgm3hkgVuo+kaTrJL5H5wUmQQQ2nBSZ0ZjpFOxtvswVenl87rnaFe6ncOAr
	tURYxN3L6v9mq9D0HArW7ELbR3fg==
X-Google-Smtp-Source: AGHT+IEsTpQ2JgQq73PIIi2BUjZ59IPNByHRdWpUpLhoM2TgmVIamV70BK0YXd/2ubvynp/Jd8VQltUyoga2R+pTrfk=
X-Received: by 2002:a05:6512:b08:b0:549:7394:2ccc with SMTP id
 2adb3069b0e04-549756e3ba1mr734501e87.26.1741077876026; Tue, 04 Mar 2025
 00:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com> <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:44:25 +0100
X-Gm-Features: AQ5f1JrUf4BLulGkluVvHzVvboNuHrbtC58uLx38uifniKVu4XCC8IXPLns3EFk
Message-ID: <CACRpkdbhhJ0+8BYpajdCSHHZZAYO3bOpFd-XCUxpdZyGCpj4cw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to gpiod_do_set_debounce()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

