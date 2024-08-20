Return-Path: <linux-acpi+bounces-7727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E661E958D1E
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B0CB2427E
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C061C2335;
	Tue, 20 Aug 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f05BM5sL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851B1C0DD2
	for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174391; cv=none; b=tR/fKUtLgy9EaWpotX1e3CF9aTQuMZFu4IskfVtK/tb5rNkdZ2EmOJX23VyCMMTNP3Pxnlt1rqdcTxm+mvpgy7rf5mvn91G3GVJT3ZcRc187pIaSFML02UWcd+uWjD5CaaOKLEeBW+xROfplVbs8DfGlNMR3qqvkBrjiiiYMFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174391; c=relaxed/simple;
	bh=iDraRUjl5oL1xgN68Huw+NH/26MmOw5WLPqUrN6J8gU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwQdd0Umlg1IY+SM0WyId35jbXdTTaHCvU+k7m3RN0HxoYtZr0G2TR1kHcWADBBUxMmnHhDdCPvxpSD4zDd8RUU6hN102lj6dREcR6shY5D0dzQucOEJLx10O8y+NnSuvbmEgEZqPkHMY6u+Yc757XzwC6TxxxkWRa+fUkvZZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f05BM5sL; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1e31bc1efso368086385a.3
        for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724174389; x=1724779189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiyLbBScoOEAyh1b94eZlYoF11C+Y/bEKpA+kMzIp/4=;
        b=f05BM5sLouj6DITyoyLhldpLXgcY/W5wtdqk33z9CH++3YW7A4x2V2GGDfVrioB6M2
         EnkPgQAh09KIoZtD2Qiy/XCu1tFQ9qmmgwi+h+zZERCiowbCq14EqddOHAHEffWgWLHP
         Hap23Jcnq9cQKrjjdpy3AdpUWVeMzLlmW5sws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174389; x=1724779189;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiyLbBScoOEAyh1b94eZlYoF11C+Y/bEKpA+kMzIp/4=;
        b=ZWELk6BhaKGmls1EgFnQcOu37LsSFU0dn7FGUzs1Yum6qclePVC15099cibzA+1CWN
         dmqTNcr87SlqRShDSh6Y7zm6FqHDUiMSWq3Mz3rAUZ5PMMcfUUJU6GwzAkz9yljsCc8L
         V623mugV3kNB0pcOyIDB+bDy1NYF3JVaDla7tg+vGfaecuqxDIjoTwRv8dIMHGPweeQC
         dG1DVIKDEeVlmmAScB9aYGGij8U90tQJtV+TM3N/jBuMcVzvNoDVclAECKmIoie/guf9
         6OlRvu22fEI4PQZ2T+mTXHEHWbcozl15S8sQs3CCTrR3Xb0XOtwHLL0ifIQ8um2/ussC
         auhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvcAAd18cDGhl2LVi8Xu5nCGyKuFlXb15jTlg+Oj3ZPkdQA1aFmEp8NVEgCt9RxMVWrHUhSpkF+kng@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRBZNI/MW2pKsmfd5tsZNP78Gxv7LB8gGeAI8zavcdN+CKOPW
	ZuYKTWqWrubchLB9hR2wRy3XIr3iYRCq0rT1U8/XXkkv8I887kCDmCyPyX2slJIlu21/r0cJJ1V
	AFtybusVMCLCEMDukzRF7WzkvrpRV7ZHu+3cz
X-Google-Smtp-Source: AGHT+IGvb1y8J9GbBVxSnRA9EXCz4Y2dTYC1BxL8SdlIGlM8BUVy3xXqhZZEkOLtGvt/v6Ls5degXKbKQR8XD+zhGss=
X-Received: by 2002:a05:620a:2943:b0:7a3:49dd:2002 with SMTP id
 af79cd13be357-7a5069d5c63mr1695634285a.55.1724174388818; Tue, 20 Aug 2024
 10:19:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 10:19:48 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsTPeEsS1m4Y8imq@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org> <20240819223834.2049862-6-swboyd@chromium.org>
 <ZsRs6d6uOMb4DqQQ@smile.fi.intel.com> <CAE-0n52O01UgrDT2=-JJpZj39BOJNyyQC4w_pgDUmKDmcN=8Yw@mail.gmail.com>
 <ZsTPeEsS1m4Y8imq@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 20 Aug 2024 10:19:48 -0700
Message-ID: <CAE-0n52FSUFictNQ9kotgFAZPYnJpy+3Ad__QeUN+EiJuBWGwQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] usb: typec: Add device managed typec_switch_register()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Andy Shevchenko (2024-08-20 10:16:40)
> On Tue, Aug 20, 2024 at 10:01:07AM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2024-08-20 03:16:09)
> > > On Mon, Aug 19, 2024 at 03:38:19PM -0700, Stephen Boyd wrote:
> > > > +     ptr = devres_alloc(devm_typec_switch_unregister, sizeof(*ptr), GFP_KERNEL);
> > > > +     if (!ptr)
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +
> > > > +     switch_dev = typec_switch_register(parent ,desc);
>
> (Side note: wrong location of the white space)

Thanks.

>
> > > > +     if (!IS_ERR(switch_dev)) {
>
> (Side note: positive conditional is okay)
>
> > > > +             *ptr = switch_dev;
> > > > +             devres_add(parent, ptr);
> > > > +     } else {
> > > > +             devres_free(ptr);
> > > > +     }
> > >
> > > devm_add_action_or_reset() ?
> >
> > No. We don't want to call the 'action' devm_typec_switch_unregister()
> > when it fails because that would unregister a switch that has never been
> > registered.
>
> Hmm... With devm_add_action_or_reset() we first do things and then try to add
> them to the managed resources. In that case it won't be like you described.
>
> What do I miss?
>

I believe you've missed that this is a wrapper around struct device and
the error path is different (put_device() vs. device_unregister()).

