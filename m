Return-Path: <linux-acpi+bounces-5325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD78B048B
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 10:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95516289861
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209F157468;
	Wed, 24 Apr 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOt8zGOU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F1156C6B
	for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948003; cv=none; b=Fj2mPadCnTXyKwKh3Ry1CvWV7sP1WR9pk8qq3Y8kGBqDpQRwqRxPOfaiCw8k902Uz8GQppzNIDBFUIPpaUcSdc9kItRdYK3PZzUpkpVfzNnyJZVMOqX8h/uogjAPKE0IxOmiZmfaiDc2YMfEhwYO6z5lM0oIBVNhao0Ct7wLGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948003; c=relaxed/simple;
	bh=uUzQknoBUwJwtT7gaiTdl3F+FfFeaiPbUFEIFshQxNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z30g8u2xhtWbvF0z2ysnanO3Yz//uSr7WhYiPu87Ow3j5OfFj7l+jcF3bBdIrh1Y9hIxpOyW6KMA+LkJT+oQc4QyyaBUrIFDnzccXSE5yFupxQ9tc0VEDO4BI1mlZXNrVmf3PVDAH7+4yf+d9osvPR/7QeCBLpTGIKN/HB6GmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UOt8zGOU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61b4cbb8834so39981767b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713948000; x=1714552800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UHaqSpAGymwtsvS6Foy4yGMLTRuN1UnMi+BHoGsiUPI=;
        b=UOt8zGOU+bVIhuMFD5/Ree0KWK0X9AsVFKC/N/IqF0F6knVWIuVIeKcnA6ddXwwF+N
         cu2NRenvf47gcrnnS9BmBuT/3+fKPEmOPGn4OUa/+WfkUdihF02RcsIkbZXASu2Yt8aF
         InV+wh7eoVq30/SoBLtgP5v5yWzgOKpZJRrfdCvC1AjUM3xJ0oW0tMnzcWdgAITf9uKQ
         g5vWyeZrzxW97cTBiNZsATTL8VT8SeX/KSm8cw87veszDBv8JHcJNuYatUQSlGiOHu0l
         hg66hiVXd1osMBI94x2Z1O6Am4Z9hUY8wrntgU/H/1sBfPIFw07d1ql31R2NthysYi+c
         6Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713948000; x=1714552800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHaqSpAGymwtsvS6Foy4yGMLTRuN1UnMi+BHoGsiUPI=;
        b=VxSG1ToRN3pS+wAQNgLuu1s++RIOawl28okXfWVt0y6jD8iXaETi6GL4OYxDMA0UC3
         3YsEAgopLEaqMPWIGhLgqUkWh2hy2h6SZc2r/P3tFKM/ecz/qyCT43hzKpYzRfc2AKXY
         eIXBWKS5cjNpJdxsHeFJEs+POJSpFuM1zlhqb3sSGC96668R6kqlqo7kAwxApBDhIymN
         R6UNNUcvgCCC2QSPJUq/qIcwF57J8Rai3fKFrXaDl07y8+jjImtXkV7JBbyF5EvupVLZ
         ssKR5mtnOSs+XU2GML/Vv9BRV2Ns7fIAY8LDevn1Kk6hwwIns/F+Qkd7tkS12Hfztzzw
         ZyNw==
X-Forwarded-Encrypted: i=1; AJvYcCX1KeRVoTPLXoMa7IVxEwdaAF7NlaI+wA6uUZhGRjsj4tZ6ZVQ8tP0ntVSaA9DFVndr64C8Nc6EPbYkSs7tx3CFViqUCKKc6gfylA==
X-Gm-Message-State: AOJu0Ywxni3uJEtUe2RYD6OvZZbSThYWqqUiG2uvt01ZdrxpKyzMLmsM
	uomvS8GvlsCpjAgi4SVbKfo6J6isnA1F+E30afiBQcmwSO2CmSdeq6YVh0maRwSRWMHp3Rvvx+G
	fMOauYfrbBIqjdmhckoe5NF7UrFtAnz/LS9pdwQ==
X-Google-Smtp-Source: AGHT+IFDnpZbMqkhpI/711BZF++4IF4xeUvgOC6ptC6ig7fo1yY5yVY5F1iPkFHPvGzaMEaoj1B4FKG6CEXfohFmXsw=
X-Received: by 2002:a25:81d1:0:b0:dc6:d808:cf75 with SMTP id
 n17-20020a2581d1000000b00dc6d808cf75mr1890649ybm.20.1713948000082; Wed, 24
 Apr 2024 01:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com> <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e> <22979e28-ed48-467f-a5cf-82be57bcc2f7@linux.dev>
In-Reply-To: <22979e28-ed48-467f-a5cf-82be57bcc2f7@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 11:39:48 +0300
Message-ID: <CAA8EJpr1vWVeGsoph9h=PPQRPKkjk+d7WVQpGwpPuhCQwkqCbg@mail.gmail.com>
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode callback
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 08:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2024/4/24 05:37, Dmitry Baryshkov wrote:
> > On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
> >> Hi,
> >>
> >> Thanks a for you reviewing my patch.
> >>
> >>
> >> On 2024/4/23 21:28, Andy Shevchenko wrote:
> >>> On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
> >>>> Because the software node backend of the fwnode API framework lacks an
> >>>> implementation for the .device_get_match_data function callback. This
> >>>> makes it difficult to use(and/or test) a few drivers that originates
> >>> Missing space before opening parenthesis.
> >> OK, will be fixed at the next version.
> >>
> >>
> >>>> from DT world on the non-DT platform.
> >>>>
> >>>> Implement the .device_get_match_data fwnode callback, device drivers or
> >>>> platform setup codes are expected to provide a string property, named as
> >>>> "compatible", the value of this software node string property is used to
> >>>> match against the compatible entries in the of_device_id table.
> >>> Yep and again, how is this related? If you want to test a driver originating
> >>> from DT, you would probably want to have a DT (overlay) to be provided.
> >> There are a few reasons, please fixed me if I'm wrong.
> >>
> >> DT (overlay) can be possible solution, but DT (overlay) still depend on DT.
> >> For example, one of my x86 computer with Ubuntu 22.04 Linux/x86 6.5.0-28-generic
> >> kernel configuration do not has the DT enabled. This means that the default kernel
> >> configuration is decided by the downstream OS distribution. It is not decided by
> >> usual programmers. This means that out-of-tree device drivers can never utilize
> >> DT or DT overlay, right?
> > No, this is not fully correct. The drivers anyway have to adopted for
> > the platforms they are used with. It is perfectly fine to have a driver
> > that supports both DT and ACPI at the same time.
> >
> >> I means that Linux kernel is intended to be used by both in-tree drivers and out-of-tree drivers.
> >> Out-of-tree device drivers don't have a chance to alter kernel config, they can only managed to
> >> get their source code compiled against the Linux kernel the host in-using.
> >>
> >> Some out-of-tree device drivers using DKMS to get their source code compiled,
> >> with the kernel configuration already *fixed*. So they don't have a opportunity
> >> to use DT overlay.
> >>
> >> Relying on DT overlay is *still* *DT* *dependent*, and I not seeing matured solution
> >> get merged into upstream kernel yet. However, software node has *already* been merged
> >> into Linux kernel. It can be used on both DT systems and non-DT systems. Software node
> >> has the least requirement, it is *handy* for interact with drivers who only need a small
> >> set properties.
> >>
> >> In short, I still think my patch maybe useful for some peoples. DT overlay support on
> >> X86 is not matured yet, need some extra work. For out-of-tree kernel module on
> >> downstream kernel. Select DT and DT overlay on X86 is out-of-control. And I don't want
> >> to restrict the freedom of developers.
> > I don't think upstream developers care about the downstream kernels.
>
>
> Theupstream kernels are facing the same problem,by default drm-misc-x86_defconfigdon't has the CONFIG_OF and CONFIG_OF_OVERLAY  selected.
> See [1] for an example.
>
> [1] https://cgit.freedesktop.org/drm/drm-tip/tree/drm-misc-x86_defconfig?h=rerere-cache
>
>
> > But let me throw an argument why this patch (or something similar) looks
> > to be necessary.
>
> Agreed till to here.
>
>
> > Both on DT and non-DT systems the kernel allows using the non-OF based
> > matching. For the platform devices there is platform_device_id-based
> > matching.
>
>
> Yeah, still sounds good.
>
>
> > Currently handling the data coming from such device_ids requires using
> > special bits of code,
>
>
> It get started to deviate from here, as you are going to rash onto a narrow way.
> Because you made the wrong assumption, it can be platform devices, it can *also*
> be of platform device created by the of_platform_device_create(). The patch itself
> won't put strong restrictions about its users.

Devices created via of_platform_device_create() have associated
device_node, so they won't have such an issue.

>
>
> > e.g. platform_get_device_id(pdev)->driver_data to
> > get the data from the platform_device_id.
>
> Right, but you run into a narrow area and stuck yourself.
> The so called non-DT, non-ACPI platform devices are all you basis of you argument, right?
>
> There have plenty i2c device and SPI device associated with software note properties.
> After applied this patch, it means that device_get_match_data() can also works for
> those device.
>
> And the approach you provide already generate a lot of *boilerplate*...

Ok, so here you are making an assumption that mentioned i2c and spi
devices should use the same match data for OF and non-OF cases. This
is not correct. These devices are matched against i2c_device_id and
spi_device_id. These structures have their own driver_data fields. It
doesn't seem logical to return match data from the structure that
wasn't used for matching and ignore the data from the device_id that
actually matched the device.

So yes, a proper solution from my POV requires teaching subsystems to
populate data in a generic way that later can be used by
device_get_match_data(). This way we can also deprecate
i2c_get_match_data() and spi_get_match_data() and always use
device_get_match_data() instead.

>
> > Having such codepaths goes
> > against the goal of unifying DT and non-DT paths via generic property /
> > fwnode code.
>
>
> Who's goal? your goal or community's goal? is it documented somewhere?
>
> Andy's goal is just to make those two drivers truely DT independent,
> and I agree with Andy. I'm going to cooperate with Andy to achieve this
> small goal.
>
> However, apparently, our goal is *different* with your goal, your goal
> is a big goal. If you have such a ambitious goal, you can definitely do
> something on behalf of yourself.
>
> For example, improving DT overlay support for the FPGA device, Or making
> the of_device_id stuff truly platform neutral before telling people that
> "XXXX doesn't depend on DT". I guess task of removing the of_node member
> from the struct device already in you job list, as you want to unify
> the DT and non-DT code paths...
>
> All I want is just be able to contribute, do something useful and do the
> right thing. So please don't throw your personal goal or taste onto the
> body of other people. Thanks.

I'm not throwing my goals onto anybody. But using taste is actually a
part of reviewing the patches. Surely you can disagree here.


> > As such, I support Sui's idea
>
>
> OK so far. But,
>
>
> > of being able to use device_get_match_data
> > for non-DT, non-ACPI platform devices.
>
> Please *stop* the making biased assumptions!
> Please stop the making *biased* assumptions!
> Please stop the making biased *assumptions*!
>
>
> Currently, the various display drivers don't have the acpi_device_id associated.
> This means that those drivers won't probed even in ACPI enabled systems either.
> Adding acpi_device_id to those drivers is another topic. If you have that ambitious,
> you can take the job. But this again is another problem.

acpi_device_id is required if those devices are matched against ACPI nodes.

> Back to the concern itself, I didn't mention what device or what drivers will
> be benefits in my commit message. In fact, after applied this patch,
> device_get_match_data() will works for the i2c device and SPI device associated
> with software note. Hence, "non-DT, non-ACPI platform devices" are just an imaginary
> of yourself. So please stop bring you own confusion to us.

Ok, excuse me here.

>
> > Sui, if that fits your purpose,
>
>
> That doesn't fits my purpose, please stop the recommendation, thanks.
>
>
> > please make sure that with your patch
> > (or the next iteration of it) you can get driver_data from the matched
> > platform_device_id.
>
>
> No, that's a another problem.
>
> The 'platform_get_device_id(pdev)->driver_data' you mentioned is completely
> off the domain of fwnode API framework. You are completely deviate what we
> are currently talking about.
>
> What we are talking about is something within the fwnode API framework.
>
> You can hack the device_get_match_data() function to call platform_get_device_id()
> as a fallback code path when the fwnode subsystem couldn't return a match data to
> you. But this is another problem.

No. I was using this as a pointer for having non-DT driver data. As I
wrote several paragraphs above, other subsystems use their own
driver-specific match structures. Reworking subsystems one-by-one to
be able to use generic codepath sounds to me like a way to go. Adding
"compatible" property doesn't.

> >>>> This also helps to keep the three backends of the fwnode API aligned as
> >>>> much as possible, which is a fundamential step to make device driver
> >>>> OF-independent truely possible.
> >>>>
> >>>> Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
> >>>> Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")
> >>> How is it a fix?
> >>
> >> Because the drm/tiny/repaper driver and drm/tiny/st7735r driver requires extra
> >> device properties. We can not make them OF-independent simply by switching to
> >> device_get_match_data(). As the device_get_match_data() is a *no-op* on non-DT
> >> environment.
> > This doesn't constitute a fix.
>
>
> No, it does.
>
> > It's not that there is a bug that you are
> > fixing. You are adding new feature ('support for non-DT platforms').
>
>
> Yes, it's a bit of farfetched.
>
> But as our goal is to make driver OF-independent, as mentioned in the commit title.
> when the needed feature is missing, the goal can not be achieved. Fix the missing.

Ok, what is the _bug_ that is being fixed by this patch? If you check
the 'submitting-patches.rst', you'll find this phrase as a description
of the Fixes: tag.

> >> Hence, before my patch is applied, the two "Make driver OF-independent" patch
> >> have no effect. Using device_get_match_data() itself is exactly *same* with
> >> using of_device_get_match_data() as long as the .device_get_match_data hook is
> >> not implemented.

As far as I can see, repaper correctly handles the case by falling
back to the spi_id. So does st7735r.c.

--
With best wishes
Dmitry

