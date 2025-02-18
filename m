Return-Path: <linux-acpi+bounces-11245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA223A39C75
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595E03A623A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C925C6F2;
	Tue, 18 Feb 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLUpja4b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0918E743
	for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882975; cv=none; b=Wt1LRU1nyWOfljttbJP5l6GbnDC2hmmZpjCN8HZETh1OfZQMBJILHIRG//Y1AFE1Jd7itCI5W3RaVR/lhnVi6XzOAwRD1kgYSxbLvjvlJQ5WD/PiR8YnlxBGbUnfRJC2FgUukDGXbx5ZsfL4+MlLxZAQ9CKr/2QoF8LUfj5s7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882975; c=relaxed/simple;
	bh=4c34Pl9V9oAv5pnu9ClgVRb05vmvT9zIOa3MRXeK69s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUB0r39HwKQ7MB+HIZro3if7mEzcsQkxGcL0PbNJbZ4WZ5tKwMbLdMyF+/SUPxHxNBDc5ujmkrP5p/uVN23YSu2fxzdJhk5u8gVjBfJSBjDjYmFY6zHRFuRZP6K0oQhzHMYnbHwxYwn9ISppNaVMkM+BjzqRdMWrgneF28D2/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLUpja4b; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5dd697475dso2162894276.3
        for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739882971; x=1740487771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KFFzr8bI2A+xFNJr0YO4ppktmUAC80FDXNawfppZ3YM=;
        b=wLUpja4bT030NAOBXzMAAFIZ4dcIHYZK8x35N8/bxQSyJI+c69nL6SKzOCY0P5AtO7
         phUbIj42ZdZQbDcm6kvU1gk3Vqygbnpwby4DwpplXbI1XkLKWPiOYzLhJtNsedYuOxcF
         TOOl1DiXR/kgL2zAHK23TR4jaFpiSLKj1zpxQDIlEhPHNyPxXdJFZXuzVGlt5iZAas48
         YqRQhyBI/cjF4Fi8uZoB8zKNgjcdohM/pyE/HmGZPqjYivmHZzhIZ/z8FkQJ1XDoquRT
         hjvYwo2k7r+AcMyKdw8q2ZPGEK7vGZ8JaPLcknzqxzsFVmZ1la3iGtSS68vGFJAKc5oh
         Dayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739882971; x=1740487771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFFzr8bI2A+xFNJr0YO4ppktmUAC80FDXNawfppZ3YM=;
        b=AT/UUQu+BrKTuu6Q3INQ0kGbAQ0Xmog3jh2abLawWODitLz9VKaVEvhdXxDHti9hUR
         +Xp8AzdJP1c26frH9fzO9iT7PjXdPVSjZytzKPr0MGHvbzEtPGF1B1uNnbBJwctCOCrL
         YLEJFwZ/38q6NcWa0jXYuW20mvbozWOa7M9WjrijNmKYf7hJcaEa0GiN1H8Yi+WFNubs
         lbCB3wwrpytIXMdU7v5i7QTlMqXaGsXV5eFbGS0vjRY55/EhE3E76F0TO+keueBu3fC/
         uzrDC5xfK83XqhSK6/BlcgTjVk0cnuGZh9KaadtiTkfbbuioRO4zCtPtXQcIc1fkWdru
         sEDA==
X-Forwarded-Encrypted: i=1; AJvYcCVyxqC+g3IjfFeO/KeA/egGN+J0UaYHviXSARTABE47r4Dw8el7lQyU3fGOdDSNB0QflF3PBqcaZmfD@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZ0XEmvFtNC62ai9+dSkJsDmb2IvAQJRf4jQCyQasTQIUdCRh
	Xeaur5/PQZdA+krr24EcLqhjm2eyLGMMTtFfrgYp6jVYuaTA2eZ+Mkm/b9zwiygItZoUGQQDY/1
	h2QkE71st0bM3wZ4LjZH0042AnliXHfxE++Euew==
X-Gm-Gg: ASbGnctZ4GY7P2MSDwtZ2mHaFYCNAT4zRsETKRNcS1ihPKDa+4L3JwTuVV8C928g2SB
	BKak3T4HKwWMDLUm7Zn4/IW8erqBCh857CjOs/Q28b699GowfJqdiF59kqUEAwxdumRhOa5zM/g
	==
X-Google-Smtp-Source: AGHT+IGsgdIc+lrg0uaYthxDbjuu2RqLkOGypGT4hi5o7axf12/WwRJRBOA2dkTImuNSHrVtpIgEHz+zzrRbpfPSKhw=
X-Received: by 2002:a05:6902:1086:b0:e5d:dcdb:18ed with SMTP id
 3f1490d57ef6-e5ddcdb1badmr6881189276.32.1739882971297; Tue, 18 Feb 2025
 04:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <2000822.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <2000822.PYKUYFuaPT@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 13:48:54 +0100
X-Gm-Features: AWEUYZl2e3wuU09rOhy0fKyxgy2Cy7-O9CxX1TT4Fs9bV1RChSBGopUjoJ_6AZU
Message-ID: <CAPDyKFoB0fQCabahYpx=A_Ns7vJgWYdK=rxuHk+XHVv35cFvWQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

+ Saravana

On Mon, 17 Feb 2025 at 21:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> A recent discussion has revealed that using DPM_FLAG_SMART_SUSPEND
> unconditionally is generally problematic because it may lead to
> situations in which the device's runtime PM information is internally
> inconsistent or does not reflect its real state [1].
>
> For this reason, change the handling of DPM_FLAG_SMART_SUSPEND so that
> it is only taken into account if it is consistently set by the drivers
> of all devices having any PM callbacks throughout dependency graphs in
> accordance with the following rules:
>
>  - The "smart suspend" feature is only enabled for devices whose drivers
>    ask for it (that is, set DPM_FLAG_SMART_SUSPEND) and for devices
>    without PM callbacks unless they have never had runtime PM enabled.
>
>  - The "smart suspend" feature is not enabled for a device if it has not
>    been enabled for the device's parent unless the parent does not take
>    children into account or it has never had runtime PM enabled.
>
>  - The "smart suspend" feature is not enabled for a device if it has not
>    been enabled for one of the device's suppliers taking runtime PM into
>    account unless that supplier has never had runtime PM enabled.
>
> Namely, introduce a new device PM flag called smart_suspend that is only
> set if the above conditions are met and update all DPM_FLAG_SMART_SUSPEND
> users to check power.smart_suspend instead of directly checking the
> latter.
>
> At the same time, drop the power.set_active flage introduced recently
> in commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status
> of parents and children") because it is now sufficient to check
> power.smart_suspend along with the dev_pm_skip_resume() return value
> to decide whether or not pm_runtime_set_active() needs to be called
> for the device.
>
> Link: https://lore.kernel.org/linux-pm/CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com/  [1]
> Fixes: 7585946243d6 ("PM: sleep: core: Restrict power.set_active propagation")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/device_pm.c  |    6 +---
>  drivers/base/power/main.c |   63 +++++++++++++++++++++++++++++++++++-----------
>  drivers/mfd/intel-lpss.c  |    2 -
>  drivers/pci/pci-driver.c  |    6 +---
>  include/linux/pm.h        |    2 -
>  5 files changed, 55 insertions(+), 24 deletions(-)
>
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1161,8 +1161,7 @@
>   */
>  int acpi_subsys_suspend(struct device *dev)
>  {
> -       if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> -           acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
> +       if (!dev->power.smart_suspend || acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))

Nitpick: Rather than checking the dev->power.smart_suspend flag
directly here, perhaps we should provide a helper function that
returns true when dev->power.smart_suspend is set? In this way, it's
the PM core soley that operates on the flag.

>                 pm_runtime_resume(dev);
>
>         return pm_generic_suspend(dev);
> @@ -1320,8 +1319,7 @@
>   */
>  int acpi_subsys_poweroff(struct device *dev)
>  {
> -       if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> -           acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
> +       if (!dev->power.smart_suspend || acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
>                 pm_runtime_resume(dev);
>
>         return pm_generic_poweroff(dev);
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -656,15 +656,13 @@
>          * so change its status accordingly.
>          *
>          * Otherwise, the device is going to be resumed, so set its PM-runtime
> -        * status to "active" unless its power.set_active flag is clear, in
> +        * status to "active" unless its power.smart_suspend flag is clear, in
>          * which case it is not necessary to update its PM-runtime status.
>          */
> -       if (skip_resume) {
> +       if (skip_resume)
>                 pm_runtime_set_suspended(dev);
> -       } else if (dev->power.set_active) {
> +       else if (dev->power.smart_suspend)
>                 pm_runtime_set_active(dev);
> -               dev->power.set_active = false;
> -       }
>
>         if (dev->pm_domain) {
>                 info = "noirq power domain ";
> @@ -1282,14 +1280,8 @@
>               dev->power.may_skip_resume))
>                 dev->power.must_resume = true;
>
> -       if (dev->power.must_resume) {
> -               if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
> -                       dev->power.set_active = true;
> -                       if (dev->parent && !dev->parent->power.ignore_children)
> -                               dev->parent->power.set_active = true;
> -               }
> +       if (dev->power.must_resume)
>                 dpm_superior_set_must_resume(dev);
> -       }
>
>  Complete:
>         complete_all(&dev->power.completion);
> @@ -1797,6 +1789,49 @@
>         return error;
>  }
>
> +static void device_prepare_smart_suspend(struct device *dev)
> +{
> +       struct device_link *link;
> +       int idx;
> +
> +       /*
> +        * The "smart suspend" feature is enabled for devices whose drivers ask
> +        * for it and for devices without PM callbacks unless runtime PM is
> +        * disabled and enabling it is blocked for them.
> +        *
> +        * However, if "smart suspend" is not enabled for the device's parent
> +        * or any of its suppliers that take runtime PM into account, it cannot
> +        * be enabled for the device either.
> +        */
> +       dev->power.smart_suspend = (dev->power.no_pm_callbacks ||
> +               dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) &&
> +               !pm_runtime_blocked(dev);
> +
> +       if (!dev->power.smart_suspend)
> +               return;
> +
> +       if (dev->parent && !pm_runtime_blocked(dev->parent) &&
> +           !dev->parent->power.ignore_children && !dev->parent->power.smart_suspend) {
> +               dev->power.smart_suspend = false;
> +               return;
> +       }
> +
> +       idx = device_links_read_lock();
> +
> +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +               if (!(link->flags | DL_FLAG_PM_RUNTIME))
> +                       continue;
> +
> +               if (!pm_runtime_blocked(link->supplier) &&
> +                   !link->supplier->power.smart_suspend) {

This requires device_prepare() for all suppliers to be run before its
consumer. Is that always the case?

> +                       dev->power.smart_suspend = false;
> +                       break;
> +               }
> +       }
> +
> +       device_links_read_unlock(idx);

From an execution overhead point of view, did you check if the above
code had some measurable impact on the latency for dpm_prepare()?

> +}
> +
>  /**
>   * device_prepare - Prepare a device for system power transition.
>   * @dev: Device to handle.
> @@ -1858,6 +1893,7 @@
>                 pm_runtime_put(dev);
>                 return ret;
>         }
> +       device_prepare_smart_suspend(dev);
>         /*
>          * A positive return value from ->prepare() means "this device appears
>          * to be runtime-suspended and its state is fine, so if it really is
> @@ -2033,6 +2069,5 @@
>
>  bool dev_pm_skip_suspend(struct device *dev)
>  {
> -       return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> -               pm_runtime_status_suspended(dev);
> +       return dev->power.smart_suspend && pm_runtime_status_suspended(dev);
>  }
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -480,7 +480,7 @@
>
>  static int resume_lpss_device(struct device *dev, void *data)
>  {
> -       if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
> +       if (!dev->power.smart_suspend)
>                 pm_runtime_resume(dev);
>
>         return 0;
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -812,8 +812,7 @@
>          * suspend callbacks can cope with runtime-suspended devices, it is
>          * better to resume the device from runtime suspend here.
>          */
> -       if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> -           pci_dev_need_resume(pci_dev)) {
> +       if (!dev->power.smart_suspend || pci_dev_need_resume(pci_dev)) {
>                 pm_runtime_resume(dev);
>                 pci_dev->state_saved = false;
>         } else {
> @@ -1151,8 +1150,7 @@
>         }
>
>         /* The reason to do that is the same as in pci_pm_suspend(). */
> -       if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> -           pci_dev_need_resume(pci_dev)) {
> +       if (!dev->power.smart_suspend || pci_dev_need_resume(pci_dev)) {
>                 pm_runtime_resume(dev);
>                 pci_dev->state_saved = false;
>         } else {
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -680,8 +680,8 @@
>         bool                    syscore:1;
>         bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>         bool                    async_in_progress:1;    /* Owned by the PM core */
> +       bool                    smart_suspend:1;        /* Owned by the PM core */
>         bool                    must_resume:1;          /* Owned by the PM core */
> -       bool                    set_active:1;           /* Owned by the PM core */
>         bool                    may_skip_resume:1;      /* Set by subsystems */
>  #else
>         bool                    should_wakeup:1;
>
>
>

Kind regards
Uffe

