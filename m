Return-Path: <linux-acpi+bounces-14679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2217FAE9AE0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4DA1653FF
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D221D3DB;
	Thu, 26 Jun 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKz8j8yZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A121CC62
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932671; cv=none; b=I5pG/d/6vvOCanLyjxAHS+3mX5VGXau84vX2tO/ea1EMVKHsXNguCLgLdHMGKH0V8g3saYDTQe1AWFh3c/5G02I+B4HTVkLu/+fY5h3L8yiwdCsH1hMHykAPPLAhjnrZ58xNo64iFYfQpQxmb6CMmcHVlcPJNinzleHvbpXhFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932671; c=relaxed/simple;
	bh=6/CYJDnKQKVbQcwXiQ2rMzs2H9ssDvR6KIpjsUQ6QdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEHh62P1e56hYq1pgZeaj5c2iP7ryg7RJcHpsDvb1nYi3YgSutMccGOz3uVk/fwLa8UpJvl88GRH5bfOhqCeR7Dkq79OxU3PiBsaASfPZBpnKfjD4Bt7fvMFMXdAb/CrxH4CW2cwDNkIDEQ3LLRfBtZOBVO7eWQujbr0k0tQurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKz8j8yZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8600a33792so530793276.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750932668; x=1751537468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=jKz8j8yZKBOa7biATTQpt47NE380p0arVVW2TvzqXbvq5RyIZnCMi7nhD/HhMXYxG9
         14ETF+3PzaHQPT51FU9gAiJNWVJT85d/s62Z/nGx47ZAS3XiL9bxnMyzzcoNRbkZaOLu
         Bkd578TgrI4eXkwPYweFBrsvKq4O9eYvRqwGWeN5V7lULHQgK5mVRsFHG16Azj4t/2SK
         Lft3M3XvrCJQaDOO7S6P7H8OEktGZLHitpS5Y04PLE12f5xCteSaouVLNrkEWLL7i7d2
         mMDby3gOo1GYd2hSAYRcTizT47AXZTWEDaRBRASJzsGv8l5L/L5Nh2agqwAlL8SrnNUn
         x/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750932668; x=1751537468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=ZRzJlyRySKm3AE5/M6pDPxctE9TTlPl9qZNtOcAGYlLBK2Ko7g/9MvUisyrG/24tAt
         2ENm2J+kCW3T8ZZ/t6JsIOW10A5WXFdN3dPLn0rriapkOwnP3MgdToTeOVSWtv1qvhn5
         7iF++7RTKg+0UfpFqJPI2QEx3JVzMxcO5sfRCnKRQo9Y/PcIMAq2Dl1sC496i22FYI2D
         GN/zKj9rUjACNY2RQLorokt92ebQYGjAgKK8YtQgaOFD1nkvd0ZUnyZfPbLZi/UPWxS5
         JfoJpbzP+eZNR5WifVAt5sDHNjli/QUPwxfBuwaqbx2qcljcpJvxumiVcQM5Vuaqr6FK
         DkYw==
X-Forwarded-Encrypted: i=1; AJvYcCWn1MUL9oBhq14ucKg9EHkIetWFcFflJGgt1ErcqUfmLVAQ1ph9HejM8eTU2B28VxkmVl7qdjQLdm0A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hpS6dLhUuAMy5Hr7Z++vwSa/3w3lcRaOKFJv6vCnke7OUxOi
	YbzmeXLIbJ8iyLne/WhXl5Oi54q1BXrw45Tt6dTxN2gmo+u7vgphlMOBkTRAn/VenoaCYgeIJ3H
	fgr1ZA6SjGEFJ/aQW+m7d8QWCL43Tz5DCvhe74Cjuq6U5HuQY1YEg
X-Gm-Gg: ASbGncuSoTgWTnoS+YDn1KIb81nPOSeKzIyB2o3oohwiW+NoNGAyUazmQCjz+chF4Ul
	S7fTh62PTgIqn2Y0yOevMxMU1v0snpwEae1zmpf/n/rBXlmFxE1z+vOonwNAY6aGeaI1r9suOJQ
	FWYHFFuITDYNi7pusVdDS3yBs7YTWKlC6z7WC4LTx9m4Rk
X-Google-Smtp-Source: AGHT+IFTNjmMODL7y1EvHVTNC82M3od38DyxrG8NO+F9c5mpyvxWXa3dqoy9a/B0A36TiqGlH0TnxzyON/TB5m34CYM=
X-Received: by 2002:a05:6902:210e:b0:e81:9581:4caa with SMTP id
 3f1490d57ef6-e860178bba2mr7662593276.34.1750932668573; Thu, 26 Jun 2025
 03:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <3903497.kQq0lBPeGt@rjwysocki.net>
In-Reply-To: <3903497.kQq0lBPeGt@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:10:31 +0200
X-Gm-Features: Ac12FXzz6qmhiLsuzk245wnHwdyyM19B97SD0ZUjObz7zXjCLdLDg9DQbgqL-iI
Message-ID: <CAPDyKFqXvNDqZjePwvF+mgs7bba47uoeH-7XvJkqZ2K4-bmXgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] PM: Use true/false as power.needs_force_resume values
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since power.needs_force_resume is a bool field, use true/false
> as its values instead of 1/0, respectively.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1827,7 +1827,7 @@
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> @@ -1997,7 +1997,7 @@
>                 pm_runtime_set_suspended(dev);
>         } else {
>                 __update_runtime_status(dev, RPM_SUSPENDED);
> -               dev->power.needs_force_resume = 1;
> +               dev->power.needs_force_resume = true;
>         }
>
>         return 0;
> @@ -2047,7 +2047,7 @@
>
>         pm_runtime_mark_last_busy(dev);
>  out:
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         pm_runtime_enable(dev);
>         return ret;
>  }
>
>
>

