Return-Path: <linux-acpi+bounces-10081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4149EC6F1
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EFD1679EC
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435D71D90B1;
	Wed, 11 Dec 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Azb14DTO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DA1D7E57
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905165; cv=none; b=HlKjg973Y981JFRjAuzuzgwD5TCJSb8T6gL4Fz2y+Sp+jUCGYeKwx3cEvqQsaqetHfjawv1k0BlKAHKdekQGbeCjr/Yne/Cav2MmiHY0DgsLn09MuFC0zQ34R5SKYM5ffo+VyKNmkvghqR2BoV2vX5xAlvDhWkK1oLlZGcHMdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905165; c=relaxed/simple;
	bh=Lsm8C3031w9xBCb23/cgZ3DoZ2ls3z/NYBjnTBCzjJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izxyFXpKbUtWg5DjhUXe0aHDAqeoqiN5rJPSjIxoZa06dhXL38qedEzvU2We0XHjA4KwJRM1hodhzMXo0HQ4SWAgrOWHi6mscm0dUxA1g0TIC4KID5lERbL9QkHL2GE3AZVAzVyWpO4xWJcjS+GnZnkIGAXiPEn+xt9XbBs8jsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Azb14DTO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so4829061a12.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 00:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905163; x=1734509963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S37tUa9+4E/BElh55Abu22jNluchZXe2JCq2BZHuzPc=;
        b=Azb14DTO09RsweCQU1LRUGl39Foo3hyivMjcSvFEbcLy3WALRPDbdSvtdqtom4mHCz
         m/+1rypVrApr1bb5Sqm/fqDTI4liuIrklJod+Z3hXEpSzndxTEW8RYamPUFAAHWIc6aC
         j9BHGxv2YvPKcBDmFb9AD52gffQ5J/NefUV+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905163; x=1734509963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S37tUa9+4E/BElh55Abu22jNluchZXe2JCq2BZHuzPc=;
        b=LmZoflRmDEo5EzuZAwaFyjpDrwQGZTRzEe0GLaLBkc1q8a/rTf0xjo9KYOLJcdon2D
         GRva902FzJNBPB4Gn9q3M6UbRvPmhEUIz1jAnDl0/rTlYya3poQojWEHd508u+Kx4aUA
         yziEmXXnbPhsXroH+gxv0URpmcbPB8PoFPVJ7f2/L8G4RTYuWuTZ7OYqx8m/HLXeP7vE
         7q701Bv6ctxUdHXZvCzGZnu3z/EUO1aCXZ0RyGoPDgTlhKpoYO9N1VodqnU4nKEpZ7ys
         RZVUZoCBcYaX87XsPE0PnLb5BQQpiQ7KK5lP5ikmhNHeg86n80wF8AuhzwWVKfNJwuCW
         oI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRlEP7MdHOA6OiVlZKWPNrwRmjc6hOHBkvoBtA7kHWRBwozjdIlW4m6DiZ7fQaZuaIdEm/yBO6YUbf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OMF93MYT83sDv5e0TvAIHMZ1NnC84JzpNRiInPP3zDY/Sr/b
	VSzlYHeh+eimISlrDTu0iE1aX/k3H8ztjCXzC5WiwjVMN17Bm6kDOPfZ6ZPDG7NSGcnnWmXneA0
	=
X-Gm-Gg: ASbGncvsvXKPBgY0ZgHNCdn+bXSAJ3tgPPa8cc/MXMXW5o3lnbK4c5cVy5k4yWICZzw
	SqKxWR8Xp1dD0F1Sro47heP+OAeoqm1V6s6Sk81Qt1/zhx8+DxwNRlnkrrXdMSfT3TPv3QTRpQZ
	mcRZQCglfyqxRB8MO9cq48N+IIOXn7BjxouexN64ht1M/ODQaQXLpykGerfkr2nq57aZBYOzCsx
	InzTjT/9ZVDz619/SqNj12azoXO8kEOAWtvg7h7Yx3U0yEfEvfyjzjVG6JoG5QbvgKujFhBhkYG
	fVf4vPyzt7rHn0t+SwEn
X-Google-Smtp-Source: AGHT+IE/vCrHmXT7snbWm1bzWoMqO2nRpoGR8ljJQeVvBVRAedW2FiYuMsfYyHYbrzsG+AWUMdlH4w==
X-Received: by 2002:a17:90b:1c05:b0:2ee:f550:3837 with SMTP id 98e67ed59e1d1-2f127f64262mr3367646a91.7.1733905162650;
        Wed, 11 Dec 2024 00:19:22 -0800 (PST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21649ad2bb0sm49565065ad.254.2024.12.11.00.19.19
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:19:19 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so5002232a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 00:19:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqWV+MXqcmTPP25CKIvbEAFJGnNWjw/ptw5fmn98LdowDs6f5HlCQE15Vef83UXIrVQ9l7awEgE84/@vger.kernel.org
X-Received: by 2002:a17:90b:1d91:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-2f127fc7278mr3021275a91.13.1733905159097; Wed, 11 Dec 2024
 00:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org> <20241211091147.717e53a4@foz.lan>
In-Reply-To: <20241211091147.717e53a4@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:19:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvkBvdstVn4GwtdNiJhs67TO6rXVBcsdfRJNgNMXkjvKA@mail.gmail.com>
X-Gm-Features: AZHOrDm09Y0n30eCWNJ7YxalIcoq21V7pnpLmE36rjaksDFouTGIwgN4Tsc_yGk
Message-ID: <CANiDSCvkBvdstVn4GwtdNiJhs67TO6rXVBcsdfRJNgNMXkjvKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
To: Mauro Carvalho Chehab <maurochehab@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mauro

On Wed, 11 Dec 2024 at 09:15, Mauro Carvalho Chehab
<maurochehab@gmail.com> wrote:
>
> Em Tue, 10 Dec 2024 19:55:58 +0000
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > throws the following smatch warning:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> >
> > Fix it by replacing the condition.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu-bridge.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> > index a0e9a71580b5..be82bc3e27d0 100644
> > --- a/drivers/media/pci/intel/ipu-bridge.c
> > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > @@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
> >
> >               for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> >  #else
> > -             while (true) {
> > +             while (false) {
> >                       sensor_adev = NULL;
> >  #endif
>
> The better would be to just remove all #if and handle ACPI compatibility
> with COMPILE_TEST inside acpi headers.
>
> Besides that, t sounds that patch 2 makes this hack unneeded, as you added
> a false check at the for macro:
>
>         #define for_each_acpi_dev_match(adev, hid, uid, hrv)                    \
>         for (adev = NULL; false && (hid) && (uid) && (hrv);)
>
> Please place only one set of subsystem maintainers at the To: line,
> directing to the one(s) you expect to merge this series.
>
> In this particular case, the one to be added should be the ACPI
> maintainers.

The plan was to land 1/7 via the media tree with a PR from Sakari soonish.

I believe he has already picked it on his tree. I will remove you from
Cc in the next version

thanks :)

>
> Regards,
> Mauro



-- 
Ricardo Ribalda

