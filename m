Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC079DE73
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjIMDDM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 23:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjIMDDL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 23:03:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835F1731
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 20:02:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso2351819b3a.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 20:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694574164; x=1695178964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLlBGNc30t/K8B3VT50OPKzn+X7H9ddW/dZg/IXugAs=;
        b=N2rulZ6f92+ZuimAa4HDC/VGysScCqcidI6wmbBibB5IqnRfPAQKEtV5zjCO55ZDIP
         WJaGqQQ5grkIo/vyv+LduopOu6B/qD8Jwf3OZLKTpaZbhTqgAM+UFsPRVUKTIxYRhzad
         62n4dkTYlOrvZue0smmNiOoVaWhca9jTVEDrayjYRbX1r/Fy+pnfXtrtOHRHNa3q0rp6
         JzmjzkmMkJEQp34fLEDxwWUVauyTiUym0a3jmtlpp2/Jj41L4f5KvpEjDu+GBuha/1AW
         ObirdnyXRfjeeVQi8ehaa4oXJ311Efc3/w60Xf+uaVXnaeO3gjR33CYx+rVy2yZ0rPns
         R6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694574164; x=1695178964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLlBGNc30t/K8B3VT50OPKzn+X7H9ddW/dZg/IXugAs=;
        b=xKv016lkdixjoUgj87Kr5UGWrYjLjTkvwte2+F2UeUoC81f7fH3ffwV6AP4RRUSZmC
         Fp1FfwTko6lzAtCTvadM/iHm6nGEyzQOC7ngh1KXz2OgefZAICoT2/02ifpmy67H72BZ
         L/HfKid78BieEQpN+q/11NLpoFb7ZKZvwyPa4kZxdli7tgb9pJojtr73o4swoLR44+aO
         ZO3SVjjCUt2vciP/7bA1w84RZYqjwf0kHy1lcogY7+IK9PQ1K3iNI2vIeBCHAamaFgUD
         orieqSW4U/xBJn/K3DGLdFu6UhAcBjtAoZNlsgIQGnXCXtVH8lyxnWNsUNWyOnVZa91o
         8QNw==
X-Gm-Message-State: AOJu0YxPzFEaUxPkLqEGGgGu8qihIOCLsThmLM9dnI59qfmiKrE+fNPL
        /5tYWVa9DaGVB5d6d1rlJ4ogfQ==
X-Google-Smtp-Source: AGHT+IEqAjh7l16ex/mBaeh2BMUJqHqxdHLKJ7dSIiDWclpEGyRYbfzxXgkf+ptEUigb3dR6AjzzHw==
X-Received: by 2002:a05:6a20:914a:b0:155:1221:a3d5 with SMTP id x10-20020a056a20914a00b001551221a3d5mr1595447pzc.5.1694574164347;
        Tue, 12 Sep 2023 20:02:44 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([2001:c10:ff04:0:1000:0:1:5])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ec8300b001b8a3e2c241sm9276464plg.14.2023.09.12.20.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 20:02:43 -0700 (PDT)
From:   guojinhui <guojinhui.liam@bytedance.com>
To:     gregkh@linuxfoundation.org
Cc:     guojinhui.liam@bytedance.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, rafael@kernel.org
Subject: Re: [PATCH] driver core: platform: set numa_node before platform_add_device()
Date:   Wed, 13 Sep 2023 11:02:16 +0800
Message-Id: <20230913030216.2442-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023091258-matrix-imitation-cc70@gregkh>
References: <2023091258-matrix-imitation-cc70@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> On Tue, Sep 12, 2023 at 03:09:00PM +0800, guojinhui.liam wrote:
> > platform_add_device creates numa_node attribute of sysfs according to
> > whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> > of the device before creating numa_node attribute of sysfs.
>
> Why?  What will this allow to happen differently?  What is broken with
> the current code?

Commit 4a60406d3592 can run well with dtb, because of_device_add() set the numa_node before device_add().
I think it didn't test acpi before submitting.

> > Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> > Signed-off-by: guojinhui.liam <guojinhui.liam@bytedance.com>
>
> Please use your name here, and not your email alias, as the first part
> of the signed-off-by line.
>
> And also, please fix up your email client to have the correct name as
> well.

I will fix them with a new patch v2.

> > ---
> >  drivers/acpi/acpi_platform.c | 4 +---
> >  drivers/base/platform.c      | 4 ++++
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> > index 48d15dd785f6..adcbfbdc343f 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
> >  	if (IS_ERR(pdev))
> >  		dev_err(&adev->dev, "platform device creation failed: %ld\n",
> >  			PTR_ERR(pdev));
> > -	else {
> > -		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
> > +	else
> >  		dev_dbg(&adev->dev, "created platform device %s\n",
> >  			dev_name(&pdev->dev));
> > -	}
> >  
> >  	kfree(resources);
> >  
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 76bfcba25003..355abf91930a 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -808,6 +808,7 @@ struct platform_device *platform_device_register_full(
> >  {
> >  	int ret;
> >  	struct platform_device *pdev;
> > +	struct acpi_device *adev = to_acpi_device_node(pdevinfo->fwnode);
> >  
> >  	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
> >  	if (!pdev)
> > @@ -841,6 +842,9 @@ struct platform_device *platform_device_register_full(
> >  			goto err;
> >  	}
> >  
> > +	if (adev)
> > +		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
>
> Are you sure that this platform code can always call acpi functions?

Thanks for your review, there are something wrong without enabling CONFIG_ACPI.
I will fix it with patch v2 soon.

thanks,

guojinhui
