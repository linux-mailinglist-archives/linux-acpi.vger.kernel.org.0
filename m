Return-Path: <linux-acpi+bounces-11252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DDFA3A062
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 15:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E6B3BC03D
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CDC26E16C;
	Tue, 18 Feb 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzS9Jomi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80326E169
	for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889626; cv=none; b=btx34U8WR74yI4UPycPnzMhB/jaOgpryi6N6fAGgjoaOjwYfHDw3ghUehPDxLhBjcXMzpJKcUd/u/XIsKsWeIGCIftvHDUj1z0tbBNgDT81hiLnDu9+GSXQ0j4G6I+GnERAWGSL2kbrGLbiQdSgOQLF6kGRgO3qJUvMMhbmAe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889626; c=relaxed/simple;
	bh=mr+2Jhhmfhv+3seL9n1mB+VOznYBvn3lX+NZfQylTqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAnKtMGkJXnKJN9dKVwknaV51N8cjakp4FdfpfX0tsP+y01jWbQ5XpItS7BtASYa8RxjXA1DE0JBJOHR0eTamr737arGvSumwn3rffGNYcbeztt8I70+QoiDZNtvajYkR8Rka91KHzxbJC+6DLaflvxmXEQMRVAU7WB/Fp2uESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yzS9Jomi; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dbdbdaeedso3399302276.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739889624; x=1740494424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2wkeEEWV1t+jTfGMDjVEd0UQWJSursxJ+qu65t0oVks=;
        b=yzS9JomiL+1VCRq5xGA/LVJBda1hD0LHa+tIsrOwo+8YCI4bbA8FZadK/V/4waPQQH
         9aFpqNh/ia1C10WgvRzuB5wF2U66/lYcRX0QP2L1I3eQBf6yiuSOHZmFx2d7MpQ/D7zY
         U4ZFcDr7s9T1qxzTzHpwAigz1L8lTWxIO0rcZsWkoNBRq0D4NxcLBiCyVoniZJywJJ7s
         xsWKhTGX/urMFShw+xctToQ4jo4bUdGFKRL2aGJPp513TUp5dN5+B1OYXD4C9f+yFbaw
         RGlT0VlSjnEtn1qTEGgF0XzOGk/xU6ENK+5wByLpc0RPumM9RquuK4enTt/nGOnnii8s
         FbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889624; x=1740494424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wkeEEWV1t+jTfGMDjVEd0UQWJSursxJ+qu65t0oVks=;
        b=JUb01xJeAtOxnLWIUE9tYesmUVucxXhMYac6DXH6jqv9OnmiY1ZcB/rm3YqV3pxlLZ
         4JCvdshHK8U0K9S0LxuJwNdLKXNQEKH/cGaYu/2W9CBZTLI1Ft/7W8njjKwtt4GJVCnP
         5kpehzLsx750v7kw3HRqjundKwSfSZ4ezbY3X0ExLNn3ASYMx53Bs+eawz6FO4TlmhWa
         jY344WBKnoeJQyprhBXJJ0DBIMEHD0/eCVDSxBrFtxRfA0u7tGJOBFb2EWSOrWpvhk/z
         rK8Nzx74tEsZp5jBsc10RJO/BJAIuoHsu0j5Brjx1Mv7qMZMuDYDeci9bgyNONa3/oaR
         6YWA==
X-Forwarded-Encrypted: i=1; AJvYcCU08XSOvwToaLlTDjqiAl1Oh/DRw0d0hCT7PSU/H2RZP+7V3MLifr5D611pO9jAs8eVJqovD/Al6RBC@vger.kernel.org
X-Gm-Message-State: AOJu0YzEL0S/ilvC/tpip79EBi7aXtTimTzACZrIfjsEyuPbPjeT7Q52
	8GFSTYoIZTK3EKDKGk0jyZPNktfrXT2vng0zvFGSD/1yOlV4k+8gL9B9Z3kIcJLps1qv2Q4MmkF
	66PFBJmwfcP5HTIK65xoTabLcvMEaNqGqbkKCKg==
X-Gm-Gg: ASbGncsPki3C4Qn8lQUqh+w+GboLntqePvRY+aaYnzoaxbTQKnki94qN4XofWWs/zm7
	GIDvvwDTSMSyyVzpkRS9wwgWa0YxaSseKeFSKLCXdHo3nOqNqut/DA4juUvoeyfw20DX2z2YjdQ
	==
X-Google-Smtp-Source: AGHT+IGc7tsTon1APxRniRGgusdip7zanYIlI5kyK12K1ApVdClP0yClUsQd8ZYL07bK78dVmjWR+9yq+z6BP2esIog=
X-Received: by 2002:a05:6902:15c4:b0:e20:25bb:7893 with SMTP id
 3f1490d57ef6-e5dc9305520mr9687881276.46.1739889623851; Tue, 18 Feb 2025
 06:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <2000822.PYKUYFuaPT@rjwysocki.net>
 <CAPDyKFoB0fQCabahYpx=A_Ns7vJgWYdK=rxuHk+XHVv35cFvWQ@mail.gmail.com> <CAJZ5v0iHsOw4_UbEWGk_-jPpc3q2K3fUXBs4T3JCooPGV10CHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHsOw4_UbEWGk_-jPpc3q2K3fUXBs4T3JCooPGV10CHQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 15:39:47 +0100
X-Gm-Features: AWEUYZkUeOWjKpfEpylPzwUgMmhW5JCtP7D9lSJ8wjRrv-WgzsAF82ls-gYur34
Message-ID: <CAPDyKFqshaVNzHPe0KL3HRTpiuzyKVJ-LuDsaAne5PawFLMJow@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> > >
> > > +static void device_prepare_smart_suspend(struct device *dev)
> > > +{
> > > +       struct device_link *link;
> > > +       int idx;
> > > +
> > > +       /*
> > > +        * The "smart suspend" feature is enabled for devices whose drivers ask
> > > +        * for it and for devices without PM callbacks unless runtime PM is
> > > +        * disabled and enabling it is blocked for them.
> > > +        *
> > > +        * However, if "smart suspend" is not enabled for the device's parent
> > > +        * or any of its suppliers that take runtime PM into account, it cannot
> > > +        * be enabled for the device either.
> > > +        */
> > > +       dev->power.smart_suspend = (dev->power.no_pm_callbacks ||
> > > +               dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) &&
> > > +               !pm_runtime_blocked(dev);
> > > +
> > > +       if (!dev->power.smart_suspend)
> > > +               return;
> > > +
> > > +       if (dev->parent && !pm_runtime_blocked(dev->parent) &&
> > > +           !dev->parent->power.ignore_children && !dev->parent->power.smart_suspend) {
> > > +               dev->power.smart_suspend = false;
> > > +               return;
> > > +       }
> > > +
> > > +       idx = device_links_read_lock();
> > > +
> > > +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> > > +               if (!(link->flags | DL_FLAG_PM_RUNTIME))
> > > +                       continue;
> > > +
> > > +               if (!pm_runtime_blocked(link->supplier) &&
> > > +                   !link->supplier->power.smart_suspend) {
> >
> > This requires device_prepare() for all suppliers to be run before its
> > consumer. Is that always the case?
>
> Yes, it is by design.

Okay! I was worried that fw_devlink could mess this up.

>
> > > +                       dev->power.smart_suspend = false;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       device_links_read_unlock(idx);
> >
> > From an execution overhead point of view, did you check if the above
> > code had some measurable impact on the latency for dpm_prepare()?
>
> It didn't on my systems.
>
> For the vast majority of devices the overhead is just checking
> power.no_pm_callbacks and DPM_FLAG_SMART_SUSPEND.  For some,
> pm_runtime_blocked() needs to be called which requires grabbing a
> spinlock and there are only a few with power.smart_suspend set to
> start with.
>
> I'm wondering why you didn't have this concern regarding other changes
> that involved walking suppliers or consumers, though.

Well, the concern is mostly generic from my side. When introducing
code that potentially could impact latency during system
suspend/resume, we should at least check it.

That said, I think the approach makes sense, so no objections from my side!

Feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

