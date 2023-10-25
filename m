Return-Path: <linux-acpi+bounces-983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F167D75BE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855CA1C20A1D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADE3418B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3Fa/njm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062120B00
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 19:55:30 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2225DE5
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:55:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so49197b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698263726; x=1698868526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVfs2vQPn6075GttomjikJbq1FdZzRDZ6l0gLyS0UXY=;
        b=L3Fa/njmA3EkAUK3JY7DH7uHw2sSPrYxfEyF/V65uSeMOKZkWRZjv3UKRLz5chXKxb
         dmnBtR280sROIOiQt4947zEw+k52NUU7MKrRymeF+gdoTZf7GV85OcKgsRcshr+D6BTU
         KDkLjYzzazwjF0bBC7ofq5h37rho4lme7SuyF9b34RthaGs3QcqIfiE6xxZ2XTAZzoL6
         VN8jEBXAdrJhz5Lc+WlO8gRAVimyQEwC01vo685MZ0ZGin7nkjTEHEUkRQ+722u2feQK
         7gJSuoG9WHIyUdcC+HJSgqk0KC/KlqoPfj1aPjvOxwVd4/Pw0hFL5XDDI/I/lsePHJI0
         tnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263726; x=1698868526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVfs2vQPn6075GttomjikJbq1FdZzRDZ6l0gLyS0UXY=;
        b=IAtMYId0kJ2DoKIC8aqdLN1zKWZsdZpbIVV32iLHccRAhj901sba5Iw9ya7KonOWow
         wvrQyO4tcNUNhq+klaT4+IVBevy3l+AvTFFPlpAwOl7h1OOyE8lEqG+Dw7Jeg/y3pv60
         pYkkfKS8lkbuZcY8yEaEuhavpKhpHc0y2vUyqSQplWLm10C5HFwnAxiVaNNPIvBRoKon
         doUW2Iry9YIuyqdIizgzTiNfL2/iLAUQuofgc02WZKiOLjCcBpofoswqAIGNpvvPisbI
         LrmqUygFfRSAh4InBHn7MAqOKlbtx4q7sf5y1p9A8+suM9eWZMSV1GIC2hDqN7sScr8r
         idyA==
X-Gm-Message-State: AOJu0Yy+kBXO8hZ2AsafNMnmbsvnfQrt0d2GO/UCUDvzJ7g0yLl1qTRx
	FvtEQ4dDQPOC8YtZ22kwDHc1EsAzA2QRHUYoYZZ/ig==
X-Google-Smtp-Source: AGHT+IE5aFGh12IgD6465G/P90VCx3AJDx5zrTXXimxuEuhvkas9UEy1EiU1Xj52N1div6ehkYg4X+nOL8OdN0SShD8=
X-Received: by 2002:a05:6808:1586:b0:3ae:5c48:6f41 with SMTP id
 t6-20020a056808158600b003ae5c486f41mr20419217oiw.28.1698263726480; Wed, 25
 Oct 2023 12:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 25 Oct 2023 21:55:15 +0200
Message-ID: <CACRpkda+qSzAQggm0_MhhvK-D+f_V77O3=u=03zEOWWVTV_TJQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 8:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Driver uses so far some OF APIs when generic fwnode ones can be used.
> Replace these APIs accordingly. Note, this will help to clean up OF
> headers even more.

Clean, elegant and does exactly what we want.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

