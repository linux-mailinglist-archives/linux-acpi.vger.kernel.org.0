Return-Path: <linux-acpi+bounces-11721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E53A4BEE1
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1B2162E3F
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC01FECC0;
	Mon,  3 Mar 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xg1//Uj7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA701FECBB
	for <linux-acpi@vger.kernel.org>; Mon,  3 Mar 2025 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001793; cv=none; b=QLBo8jYU5fsx4IZBPqCdBy5kWLQSxVE7Q1rur2iCzTx4eJ/r4H9NxGTkdPf8Jn1FEfsl6uHttO7KL46GkXDnTv/YtHMQxPXRs8VVcPEH1Cnjr+wZDyFsjHZZPPoU8gdc6D6kD0Q6MxqIcc8nI1SGDi+Ysf3vYyhYdF/tU2OV5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001793; c=relaxed/simple;
	bh=XaHolFBWoRAOTJGYNJcQzbTPSNUzRjVdWfk1b9YZ3Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NN75e7HMHWFWJM2aPhACe6T7v5jocF0xjq05hAPiDg6U+amJYQeAg9Mz5zE2q5nTdEtRzSh9cvjd7QcZ03+nKJCz+5i93ql1yPdC6xT5WLABJNQtZhtmIvMn/yVGY6y62Yq+B50xmkM5T2+RT1ma1AEfMOnyxcetiST/ziGX0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xg1//Uj7; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd66f404fbso11251997b3.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Mar 2025 03:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741001789; x=1741606589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBUkHt3avEz8ZOzjIAytFNHnXfMupzHA8HDEzBBxn/4=;
        b=Xg1//Uj7niWr7J30SfeUTn0faxZBXOcJH35+NQ4ZSM6z04EfayImx9T7OMSzXfYw7v
         DaC8ZVl8OIUgs7dbXjCZocb1ppGapdFKgVaxnaljsaHE0OYePG959HtrUkh8sgvFcO7O
         C3tfin8XRPibVUgisjdeYl7R3S19mi+nK8Ns9T4dVqgFKvJDSE6VdgW1Z/r+IzAzIj/Y
         LVbaR6oEixJoJtKID+rr9YmFlO/EauWvWHWLQlkV4AqPUnUQCMGQ+5bSLsWwPBIZcxym
         gN1DZTYm+x11k+qJWsaHyydxC/HSUYeHwb75STuP/IEYqYep8CBUTSSGckXs3TYKauVW
         /jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001789; x=1741606589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBUkHt3avEz8ZOzjIAytFNHnXfMupzHA8HDEzBBxn/4=;
        b=NNuqGm36gBdv8QWUt/mXGzR5RkurjV4NYMooRLDZeysDz2AibNFna5arzK47YvMbZm
         bPfNeDtiekUT47m6iZpyf2YVHKb2Oafx5ydWzl+oHMiqkiDfpaQoCs+oSXQLd9rUcOun
         s7VF188krtGKVA9kKPEYmeBCoUH5cI/frAeW1pAt6kieDlFywQa04qSGd8+N5GsmuUA4
         f9YyG9HezYehSFjEfRKQafb2QeqTG7kL+pDGCk5cbAZsqXgDSPU+cGnfn6OZg259Rzxz
         a20R1BIp2BTW5KK4Lx0aRio3kR3fT9Rqii/ogcAs+qwTNkzgVKjTq/0DBvzWo05vxRlL
         ArGg==
X-Forwarded-Encrypted: i=1; AJvYcCVokCRzKztG0HHTn+MvodkTrr+4U/20r2dJKHlrmZcKbEJ3CeNps8CJYgNlKRdh+HXCJ4RgZmcXCg2Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzwecFB+cpDrmSMITiaXCWTh8Jai8pDNail6V6+Rzc8Z/vFLtpP
	r2fVWczvIDMCtcsZd0tMU6cHR62vNsAqo06NHHQws/tGmfv5EAR4yg/PZBlCS4+r2GJVjyz1Hkb
	cBqloJzSyp0XFQKmclIBkwahPjHWlX/afwEFUWA==
X-Gm-Gg: ASbGncvHtJmLDAhrvaC++bDKbpQvULaq0Fn1CwfXoOZXIiWnIoyKpyhNWh9X0bDhdjf
	V8vEqpOI0NcI+MY7Wqj7KJhfQvxwvnRHcMRvetcpGcAQ4MgiUdmZBoDn7hRpCzgUdDDQRXk3WMQ
	D59tGw48tvF1eopQE72YiRCDZukn4=
X-Google-Smtp-Source: AGHT+IGbmdK13gwcTIYs/RwA8drBpUi9FLIvtkuILBcCZ+xDfdj9K62od7OaWkHcxdZCUCSfkQyJevgrhbgYFW/YreU=
X-Received: by 2002:a05:690c:688e:b0:6ef:7036:3b57 with SMTP id
 00721157ae682-6fd4a141ce2mr148855737b3.28.1741001789654; Mon, 03 Mar 2025
 03:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12612706.O9o76ZdvQC@rjwysocki.net> <2978873.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2978873.e9J7NaK4W3@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:35:53 +0100
X-Gm-Features: AQ5f1JrNehs-WHA4X5zdeXjF_NISUdLgzpPPWrjP6G-GK3iY6EpyJABxLIHp-1U
Message-ID: <CAPDyKFpCcQGKoKB3ZNj+=aiftEduiUVKcWLfYZqGY3=MCCMcQw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PM: sleep: Avoid unnecessary checks in device_prepare_smart_suspend()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 21:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add an optimization (on top of previous changes) to avoid calling
> pm_runtime_blocked(), which involves acquiring the device's PM spinlock,
> for devices with no PM callbacks and runtime PM "blocked".
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c    |   16 +++++++++-------
>  drivers/base/power/runtime.c |    9 +++++++--
>  include/linux/pm_runtime.h   |    4 ++--
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1796,16 +1796,14 @@
>
>         /*
>          * The "smart suspend" feature is enabled for devices whose drivers ask
> -        * for it and for devices without PM callbacks unless runtime PM is
> -        * disabled and enabling it is blocked for them.
> +        * for it and for devices without PM callbacks.
>          *
>          * However, if "smart suspend" is not enabled for the device's parent
>          * or any of its suppliers that take runtime PM into account, it cannot
>          * be enabled for the device either.
>          */
> -       dev->power.smart_suspend = (dev->power.no_pm_callbacks ||
> -               dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) &&
> -               !pm_runtime_blocked(dev);
> +       dev->power.smart_suspend = dev->power.no_pm_callbacks ||
> +               dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
>
>         if (!dev_pm_smart_suspend(dev))
>                 return;
> @@ -1843,6 +1841,7 @@
>  static int device_prepare(struct device *dev, pm_message_t state)
>  {
>         int (*callback)(struct device *) = NULL;
> +       bool no_runtime_pm;
>         int ret = 0;
>
>         /*
> @@ -1858,7 +1857,7 @@
>          * suspend-resume cycle is complete, so prepare to trigger a warning on
>          * subsequent attempts to enable it.
>          */
> -       pm_runtime_block_if_disabled(dev);
> +       no_runtime_pm = pm_runtime_block_if_disabled(dev);
>
>         if (dev->power.syscore)
>                 return 0;
> @@ -1893,7 +1892,10 @@
>                 pm_runtime_put(dev);
>                 return ret;
>         }
> -       device_prepare_smart_suspend(dev);
> +       /* Do not enable "smart suspend" for devices without runtime PM. */
> +       if (!no_runtime_pm)
> +               device_prepare_smart_suspend(dev);
> +
>         /*
>          * A positive return value from ->prepare() means "this device appears
>          * to be runtime-suspended and its state is fine, so if it really is
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1460,14 +1460,19 @@
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_barrier);
>
> -void pm_runtime_block_if_disabled(struct device *dev)
> +bool pm_runtime_block_if_disabled(struct device *dev)
>  {
> +       bool ret;
> +
>         spin_lock_irq(&dev->power.lock);
>
> -       if (dev->power.disable_depth && dev->power.last_status == RPM_INVALID)
> +       ret = dev->power.disable_depth && dev->power.last_status == RPM_INVALID;
> +       if (ret)
>                 dev->power.last_status = RPM_BLOCKED;
>
>         spin_unlock_irq(&dev->power.lock);
> +
> +       return ret;
>  }
>
>  void pm_runtime_unblock(struct device *dev)
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -77,7 +77,7 @@
>  extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
>  extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
>  extern int pm_runtime_barrier(struct device *dev);
> -extern void pm_runtime_block_if_disabled(struct device *dev);
> +extern bool pm_runtime_block_if_disabled(struct device *dev);
>  extern void pm_runtime_unblock(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
>  extern void __pm_runtime_disable(struct device *dev, bool check_resume);
> @@ -274,7 +274,7 @@
>  static inline int __pm_runtime_set_status(struct device *dev,
>                                             unsigned int status) { return 0; }
>  static inline int pm_runtime_barrier(struct device *dev) { return 0; }
> -static inline void pm_runtime_block_if_disabled(struct device *dev) {}
> +static inline bool pm_runtime_block_if_disabled(struct device *dev) { return true; }
>  static inline void pm_runtime_unblock(struct device *dev) {}
>  static inline void pm_runtime_enable(struct device *dev) {}
>  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
>
>
>

