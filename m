Return-Path: <linux-acpi+bounces-4050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24686DCBB
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 09:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0630928A010
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36886930E;
	Fri,  1 Mar 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mRZc7NcB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784969966
	for <linux-acpi@vger.kernel.org>; Fri,  1 Mar 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280608; cv=none; b=eXcwq8qsBBZcPwyy4nCvswUblBESK3csKIcxoEJ2pbS1GgAHbYaOJgiGC52BjdUfrXWXj8Pe8Ny2b77wieG+iPJN9WJhOg6jVbtaZKmrBH5+3knNY10/1dDwpWSQQsyA2rn2haMn2wVGJ+b4M2srap8dKN6foeTR9Wv7jgByko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280608; c=relaxed/simple;
	bh=Gt24m6VgPEoo+PtbPdWbeLDUXQElGt2V9/LMi5WVxt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtic7hBWcu80D1R2TRhmb7NqudmUUyxcMB0NLvrezcXKuWthxM+M00ZkqOl7HA2TV6dqoFiTOBXr3kJ/ejzvoaZzoDeKoE+OFbB6Iq7zOzSrJnyyF77NcybnZ2fyvKCqpBvDDQYXqrf6d3lxcR+pRmVQXdcvJPbDJifvnVDlHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mRZc7NcB; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d158faf527so494544e0c.0
        for <linux-acpi@vger.kernel.org>; Fri, 01 Mar 2024 00:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709280606; x=1709885406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk7y2xtTESbht6nwVgBTMrqKWojYrtrLnTeVVOeEZa0=;
        b=mRZc7NcBp+gOFQ/6/ocXaCzNH+8VJaMjzW2XdKDDbkqql3+vZd4xDxCifXAkegVbs3
         aU1e3upsRci7/KXGB9zyeU0UsAJcVdErE8A0QFnTaBfrGSTuKXe03cHDqqHXFbBvDy9f
         5xP4FgBI23A249QKbnqEIsyA+LjvwnqS4O88EBeqxo2UUTLAr1bMlnrRnn4D4Ke7xR6P
         9RFsaBxznZKQif685LxEG91kL7OnXs64Kuv3mUwKVJXJLaOgUgVznLUDya90xyty7eW4
         R9PhBqQCMF+aeuyZsUsHRyUZZrpFVb3XcQKRkHpF9YWgHIuCZdN559eC0TOZxNmcXPSp
         YWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709280606; x=1709885406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk7y2xtTESbht6nwVgBTMrqKWojYrtrLnTeVVOeEZa0=;
        b=TQgg4QBuW/KKRj3ZwXkHAZC3xTOAoUgzumU5ilnX9vln3gJo6hD8BsjsSPxtpZRB+R
         l4ZPIsJwlHW+ofl0ccS2yO6f6mh7eeARgGRmCrcHKIlblQXH3jT5QiAOXKbPCgw9bwox
         XnPenjFtrwQX1xYb/epcTkXq3mpBaW16RcN0+4Y9VVXT5U9Psp/b/Y92AK98zTBN+0d5
         kz09Xn2ZTuwkREAnlR44raOjzjp4dpU575hqqGd/dEK1z0Yvr6wSAr8OTsZS4TkWUvMC
         HwmF2CzYjNX6QcR93f81E5bIBwNwn+GGQKK0GYaJSZbj5dOdi+VGxBUsr4P9W6sUaCd6
         /58A==
X-Forwarded-Encrypted: i=1; AJvYcCWb3tdxoPV/1q+atHNzldGpbrz+gboXPdY12whuJlpmrBFA/ULwkhN5xjyFJ4LYibxyOlxz60jjJkXxYUWbl6dBh1mrA/CIw3YTXQ==
X-Gm-Message-State: AOJu0YzIrM10I+L2uKXOEajRZDxiQWIIhceWdpkLZsDKxVf4wyIV7TYn
	87nAeOVw9xBA42ycwo4iBw9V0arLQio35gYX9sB4V49HRCNt1SNV2AmzbbgJch8HJSXU+2JrPT2
	ve1rM3k4Kssg8QiF86DaeQsqve2J9IHgYXZ7q6w==
X-Google-Smtp-Source: AGHT+IH0cpHkNFw5IVYbKUvxASmoajZZoX8JeRxGPbUsjHJdZ3rD/qnh+2jzEY44I3Wi8ydUmSlgeHZVgglRmImhN4U=
X-Received: by 2002:a05:6122:6ae:b0:4c0:1bb6:322 with SMTP id
 r14-20020a05612206ae00b004c01bb60322mr594744vkq.15.1709280606100; Fri, 01 Mar
 2024 00:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Mar 2024 09:09:55 +0100
Message-ID: <CAMRc=MfE_OUTU12s2eKj-d8Q7uD_52SrSOFzx2yq_D+fy0rqPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpiolib: Align prototypes of *gpio_count() APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Two out of three GPIO count APIs take device pointer. OF case clearly
> does not need it as it immediately switches to device node inside, and
> ACPI abstracts that to struct acpi_device pointer. Unify all these by
> making them to take struct fwnode_handle pointer. This, in particular,
> will allow to create fwnode_gpio_count() API if needed. The need of that
> was discussed here [1].
>
> Note, no functional changes intended.
>
> Link: https://lore.kernel.org/r/2ad735ed-963c-4e75-b83e-687ea2c0aef5@alli=
edtelesis.co.nz [1]
>
> In v2:
> - fixed typo (Chris)
> - added tag (Linus)
>
> Andy Shevchenko (2):
>   gpiolib-of: Make of_gpio_get_count() take firmware node as a parameter
>   gpiolib-acpi: Make acpi_gpio_count() take firmware node as a parameter
>
>  drivers/gpio/gpiolib-acpi.c | 13 ++++++-------
>  drivers/gpio/gpiolib-acpi.h |  4 ++--
>  drivers/gpio/gpiolib-of.c   | 13 ++++++-------
>  drivers/gpio/gpiolib-of.h   |  5 +++--
>  drivers/gpio/gpiolib.c      |  4 ++--
>  5 files changed, 19 insertions(+), 20 deletions(-)
>
> --
> 2.43.0.rc1.1.gbec44491f096
>

Series applied.

Bart

