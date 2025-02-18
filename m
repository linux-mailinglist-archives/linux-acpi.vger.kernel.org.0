Return-Path: <linux-acpi+bounces-11247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7BA39C82
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 13:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF56170C48
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E8D263C64;
	Tue, 18 Feb 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LI1XOXi5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A32594B7
	for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883013; cv=none; b=DmJ4ElpBIJO3eguSFLWdmPCu9fWvsFHI40r1OuxFV3xCR8ElgX0zR7P0t63MStSjMWT14MFoKNMo3mF8ZQO1FGqHVTzzvauONeV4ScDMyIiLQfBgpfeOdRiR5qIcJLIlxBthh8IExIh2Z1Z401xkzghxGFyJeZVEZCvNyZkMGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883013; c=relaxed/simple;
	bh=DSSMR5/oEhrBBxMGuRsitGmxXCXATnKq0oSmeDXTbJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPFT2mQmS4mISrDLhS1mmQgtZ4s8jg5FsLKhYXRcrKYCAIQUhmwAPPVRoRuiYGHXylYqcy5oBU06Noqv4QuNx9xuF7EJx6F9K6BV0x8fxHMWSr6lcvnMnrVdxeP0kZQlwOXkcyEFBtSQPy4+MP4NCF5HadVXWR27tFqX5FugcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LI1XOXi5; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53c9035003so3961898276.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739883010; x=1740487810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QK+dyc1PR4OboE+3BwHPM5pfaMLTgXZ0OSHSzMoMBf4=;
        b=LI1XOXi5tf3zljDF0S2W8d4a0gEosS7HarkrSAemlYCh41CU7SWjumrljK7DB+dNqG
         ndkGY6MsMzto8nTXbqAtWtlJiIL2sIMhYjR/lJaZR18zJiJXRPGYi8k2byALdl0UGy3v
         Gk3EKDm8mISHW8w2A1vjknH0yO+F77m612hUEjGLLp50UPKtJq+tAYggbTgPmreKc6qI
         Cg04nUgYmvp/PwT7z3pOO1pv8bfSMdUg8YnYShMOvWpyDa+i2HvGe2Iavrx4SuBVWnfM
         H11DFYBxZV037n98jzY3/imgPiGfLYBHoQ+kVhL8LFhe9FXKkiHSrIBhpV6ZV83WzBL8
         iEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883010; x=1740487810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK+dyc1PR4OboE+3BwHPM5pfaMLTgXZ0OSHSzMoMBf4=;
        b=GQOg+h3nkbiYLjyLbXVSwPiV1zA4GokEjb5o9eGiQDaYhPEEaSpaTrARie/1jKSu+C
         vXEGq0A+T8usxWxAQTs3PDcdZ/RPal3ZNLhfGFyaKq1zrLlq15OuvLHDEu+7ue1EMLZR
         peIlanPR4iz+0qcYYq6QsSy0qEOWjKa9lTsRYp9gwlKF0+vTAosoC2JkP8F5ohpvwF5X
         VmT8r/q+S4FRi3iqCnH++bbdPExzWJ/8Tm2jhzP+CEybXOwU5dFXXdFn4lnQ6HP6lIJ/
         luBZyWjfGPQwAGbC8Eac2o9Tqk1qWVUM8/Y8lVrKIFk8Q3R5FLTWm2ZSyIVF4RuLUKGU
         ySlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg9IZPg1eNgudh+GH1jS/hgK3kdjE29P99EJnNC9n3xDhKR4ijhwCCUFXYtBeOWXsdE4nKrw7xYMoE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb72AwXsvSyDBhj3t6yb8vYLSKSihJlycNPfYbiuES9VSH9EnC
	kzU2V6zVYOs+yeBTBUl+dnRnkj7CXivZiSXzKkGms7a60h+lM8G62H6OQGM9xWdeN3rVn2QpCZD
	IwCliIbCZA7CzRagqhPGL3HIp7PYOuYNujiUJlg==
X-Gm-Gg: ASbGncsBKxH5cIOjg/Ct4lakAwU6nJ8AayoQmc0hAzw++DMFMXMfQGM6iqzCxCNqhb1
	2ZFlWWwP4mbqet/1+RCT36qFSGUx/bu8VqklxKbU41iFVsC8u359GyxEZmm3l37Lkgz0ut71n+Q
	==
X-Google-Smtp-Source: AGHT+IGH6vLk+U+IpOyIROSa4vJIPltJqku8QV1ftbJYlBuc7ZpPko6DcHgsxYIF2mNCIF53PQLSxJLqorXWqZRliXg=
X-Received: by 2002:a05:6902:1086:b0:e5d:dcdb:18ed with SMTP id
 3f1490d57ef6-e5ddcdb1badmr6882930276.32.1739883010026; Tue, 18 Feb 2025
 04:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <8497121.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <8497121.T7Z3S40VBb@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 13:49:34 +0100
X-Gm-Features: AWEUYZmNBflOPEaSpUMJ4BLjpv29L0jW7mM1vQW96k8wGYHbNA9-sC34ojg02fg
Message-ID: <CAPDyKFpp1iuBXZB-T2=hhTND4Z63s7kJfaXWuiKTu1rrqMGc_Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PM: runtime: Introduce pm_runtime_blocked()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 21:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Introduce a new helper function called pm_runtime_blocked() for
> checking the power.last_status value indicating whether or not the
> enabling of runtime PM for the given device has been blocked (which
> happens in the "prepare" phase of system-wide suspend if runtime
> PM is disabled for the given device at that point and has never
> been enabled so far).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c |   17 +++++++++++++++++
>  include/linux/pm_runtime.h   |    2 ++
>  2 files changed, 19 insertions(+)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1555,6 +1555,23 @@
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +bool pm_runtime_blocked(struct device *dev)
> +{
> +       bool ret;
> +
> +       /*
> +        * dev->power.last_status is a bit field, so in case it is updated via
> +        * RMW, read it under the spin lock.
> +        */
> +       spin_lock_irq(&dev->power.lock);
> +
> +       ret = dev->power.last_status == RPM_BLOCKED;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
> +       return ret;
> +}
> +
>  static void pm_runtime_disable_action(void *data)
>  {
>         pm_runtime_dont_use_autosuspend(data);
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -81,6 +81,7 @@
>  extern void pm_runtime_unblock(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
>  extern void __pm_runtime_disable(struct device *dev, bool regular);
> +extern bool pm_runtime_blocked(struct device *dev);
>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> @@ -277,6 +278,7 @@
>  static inline void pm_runtime_unblock(struct device *dev) {}
>  static inline void pm_runtime_enable(struct device *dev) {}
>  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
> +static inline bool pm_runtime_blocked(struct device *dev) { return true; }
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>
>
>
>

