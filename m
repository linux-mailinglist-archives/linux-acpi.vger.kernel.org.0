Return-Path: <linux-acpi+bounces-7171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBF943720
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5123F283137
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 20:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687C1684BB;
	Wed, 31 Jul 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzGm1oQb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9021684A7;
	Wed, 31 Jul 2024 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457789; cv=none; b=h9dhlM1ORFQ+PFJCJm3OrGcslXIi3TVNqblbHpZhGOqgwybl/T4wMYX8nL2mUrUwW+tsTggH57NafkyPpAt/TvIIq1xihtUlYnALf+vFncHsrYbrlTsbvg5nA1C3qUixr6VR+aviy5n0NM8cpYpqqP5ZeT1EbSTDCbXWG3cDDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457789; c=relaxed/simple;
	bh=fS727a5Z4mhUvyLyr8Ok/fbNxqlYYARPIOouXmRz5yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Un9QRDLR2bG9erEru6/TebDeS3TzO5u8kPKLxjl2TCGMnwyV8xdpuvt3hNDHuk8HNw3tKYO2cqtjbOJeT4D1pc0L4VuzOIrqU4cFMiNALHZ5RhJDn5cb4t0a6mqteFDQiW9TSy+WnAUT+IOGRYkzPMuhTW5XgaJ9hx/YRq5vTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzGm1oQb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so809096266b.3;
        Wed, 31 Jul 2024 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722457786; x=1723062586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS727a5Z4mhUvyLyr8Ok/fbNxqlYYARPIOouXmRz5yY=;
        b=GzGm1oQbRsxFdFJu6YpP7Hzx2qRe5IMwQA0S7vD8hLKszbADpOKj/xhyg/PJy/mlUQ
         YMLVdHRHWutczmt62JaGLxFdohZGFvaxHnqTDy4f91slrD/4OCvKMGkFJcrsf915LI5Y
         +pIIG1KIjIm8EJYvYMxR8MaV18V+PjgxhFTZcV3nKPaoI+ZhKIgsHTdDtB6qC3EZbe9W
         pjLu4EQENIehUpSWmOo1LvZlC8X+aYO1kKEUAqKff/xCHCnYXDvTTADWP/otRsVjIpoE
         3DhSH9J34PzuDiNDbqBY5N83HcVJvAD9Ll/bgNvIInZf1hcdL8FTckDVnIjx1jjoaOdZ
         2DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457786; x=1723062586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS727a5Z4mhUvyLyr8Ok/fbNxqlYYARPIOouXmRz5yY=;
        b=D+ZJDZ2vTeg6zAFrrI76asXHwJ18k26E0Op4doTBuqha09mltoh5+n2n4y8pElASVT
         teuIrAj3PZHKQtVFnRg8U4YkE4IwuLFCWuYJfnSkmuoi6JCxMQvEjjwuBV+08JOD+DEb
         OuKZR0N7LlBFHyukKQDUhD/nWgxtEN0YP272wEBvcPHA41wTZtuaeRw7LIU06nNkoyG7
         ulPU0CmqlbzDTdgNTpkvnr3OWZCqHgzC/22sqyyhOhrvCudBq7NasChqKjBpaO5hWhgj
         8HYKmFLFOdTRNTQVXVdA/4JfNIyBmDbh5hg1wI7G+5A3lHJpYewyscAqwYXBubwXx+NB
         58kA==
X-Forwarded-Encrypted: i=1; AJvYcCWUvkFz4cWGJuHbkFxAivPzPi8IxTCuuFlJHoyap0VYYfSp/mxEz24/S1y/JnYLo1nbT4VEld+gP19dd9rMq3vlbY57yYuZ6V6LYDfil9k5He7z9g0zlolRaM4HwjjrSMyjjd3e/08huA==
X-Gm-Message-State: AOJu0YymeOlm83KzbVf4woggvLv2ln3s8RuZ7cM7X5I0P7qCl2B+Foh6
	IH7BxNrQvJS8jXrAFFfPwqh6efQw5yrT5xGav2AQYsYIwH3AF5q0zsCrI4PXrloRy1qDBddtSOh
	/Uyur9KdnM1dRJeA3m91jH8zCGeg=
X-Google-Smtp-Source: AGHT+IG9eUCsE6Ikqh4U6Nij15hM9go4LP39ajhIRLuIggqCx+UNbHgh+P6RPABG1dc0p9muw6DGqSvwcIPKooNNOxw=
X-Received: by 2002:a17:906:99c2:b0:a7d:26ff:aeb0 with SMTP id
 a640c23a62f3a-a7daf55c9e6mr24492766b.30.1722457785932; Wed, 31 Jul 2024
 13:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705113434.17249-1-amishin@t-argos.ru> <20240730225339.13165-1-amishin@t-argos.ru>
In-Reply-To: <20240730225339.13165-1-amishin@t-argos.ru>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jul 2024 09:19:46 +0200
Message-ID: <CAHp75VeCw3NuPhcafTjV0X=5i-3qH_w8CvW8Lbg2WSWPnecNdg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:57=E2=80=AFAM Aleksandr Mishin <amishin@t-argos.=
ru> wrote:
>
> In tps68470_pmic_opregion_probe() pointer 'dev' is compared to NULL which
> is useless.
>
> Fix this issue by removing unneeded check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. In case the first version is already applied feel free to use the
above tag for the modifications that lead to the code as after this
patch.

--=20
With Best Regards,
Andy Shevchenko

