Return-Path: <linux-acpi+bounces-3626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B3785861F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 20:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5487C1C21B9A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB813664E;
	Fri, 16 Feb 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7mnsXJO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAD135A62
	for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111577; cv=none; b=Gy6a4AJXAuNNZ6N5ViY6LC4TDQvF/JL446gTYB5yifCbwm391LTcfs/RBRNzHOYq6T5/7HZf7P6z5doBQ2ujU6ewVIfeMcs0AhzG8G4kGj9O4U/DxH1WD2CFrKrCY0eyMFqNA1tl4KX6SX1OOFce+xBeVLG1x5G/0Y4PsZ4Oq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111577; c=relaxed/simple;
	bh=LsvxoTWbv1FOQ6yeqUkTxLA2CYVatFOQbOmKjCYI7gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+1puecJ3FSyWIYXCv57gM2sETPvcpi6ZknawGcqnkjnLMt0vUC8e+3tARjpOUicCEOcagp4DFnkdyfBH74zleeQdLbge+d7DWRBgd+ElKcqbM2cEAt7+zYYV+D8+Ml1RX4KzAjafvkbb8Dc1ETwGz5dHYe60uOxC8hCcE5ZZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n7mnsXJO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0a479a6cbso1612258b3a.0
        for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2024 11:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708111575; x=1708716375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMMkZTgH5T6zo3tRiYf2BJqtbx13TZfD9EFoNoWqc8A=;
        b=n7mnsXJO4powZmo7NyEPz3Ta9n6GlO5c48+tKb/gpwNwXtrny/k1tSpTpWGz8N/tBh
         3FW8nyfoEk0zkuV4Fe03gvFPO6vr6FwblqcVozpxEPCqodQoZG9DvFeNs2pnM8hAHe/T
         OvogMTAZWUqm1sP/9kpmUOenrueK+F4dXgiAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708111575; x=1708716375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMMkZTgH5T6zo3tRiYf2BJqtbx13TZfD9EFoNoWqc8A=;
        b=kRkwyHHwta+lznjRQODNGMGiDxmrI35zwl1TC4zSWoRlx2000EGDUaXOwBwYRInpoO
         0GQbTP90XHsOeoZ6IEcGvs4wCooWTyQG41hJtJL4Z+niLV6vJ2md6xAzW6pRQT1XpRq/
         ya43/JNacq0f/7TG0UWgJqRVhT+PcJGA0Rb6Ooe4AD5YklMER+x/ItySViJgYBKMESBl
         zswFQn+CbhjDp4+TF/i9vK3VnhMITTaBb+Aq4pDJoDWHQV4nLyXJgpAb/Ww1UoAjxoDK
         b4a5v4ggw1x9hsTBDBW3S0J0RnOMjIwSKWoBnnBQLYeHo2dBt2Wrr0qDdGgcpzgVmypy
         5gxw==
X-Gm-Message-State: AOJu0YxXf1VKQ5ukUgmfwdaU6j8+wnm+R2HzeLlSd1V5blZ2Z6Fzt5DJ
	MlawMPzdk/wBxrPHlSFFpxZrqF9rvHDSDtv5aeb922AnMAiCZSPK8rIH/8SoLA==
X-Google-Smtp-Source: AGHT+IE69VSNMJD9kM9C504pkifAwls4YW3/VU2rwA45AEvTvswD3teyNtF9R0mL5GmqRlttBrTH4w==
X-Received: by 2002:a05:6a00:2b47:b0:6d9:b941:dbf5 with SMTP id du7-20020a056a002b4700b006d9b941dbf5mr5169563pfb.11.1708111575368;
        Fri, 16 Feb 2024 11:26:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78682000000b006e04082ad5esm308202pfo.142.2024.02.16.11.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:26:14 -0800 (PST)
Date: Fri, 16 Feb 2024 11:26:14 -0800
From: Kees Cook <keescook@chromium.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Kees Cook <kees@kernel.org>,
	"shiqiang.deng" <shiqiang.deng213@gmail.com>,
	Sebastian Grzywna <swiftgeek@gmail.com>,
	Hang Zhang <zh.nvgt@gmail.com>
Subject: Re: [PATCH v3] ACPI: Drop the custom_method debugfs interface
Message-ID: <202402161125.3137F917DC@keescook>
References: <6029478.lOV4Wx5bFT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6029478.lOV4Wx5bFT@kreacher>

On Fri, Feb 16, 2024 at 05:38:55PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI custom_method debugfs interface is security-sensitive and
> concurrent access to it is broken [1].
> 
> Moreover, the recipe for preparing a customized version of a given
> control method has changed at one point due to ACPICA changes, which
> has not been reflected in its documentation, so whoever used it before
> has had to adapt and it had gone unnoticed for a long time.
> 
> This interface was a bad idea to start with and its implementation is
> fragile at the design level.  It's been always conceptually questionable,
> problematic from the security standpoint and implemented poorly.
> 
> Patches fixing its most apparent functional issues (for example, [2]) don't
> actually address much of the above.
> 
> Granted, at the time it was introduced, there was no alternative, but
> there is the AML debugger in the kernel now and there is the configfs
> interface allowing custom ACPI tables to be loaded.  The former can be
> used for extensive AML debugging and the latter can be use for testing
> new AML. [3]
> 
> Accordingly, drop custom_method along with its (outdated anyway)
> documentation.
> 
> Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
> https://lore.kernel.org/linux-acpi/20231111132402.4142-1-shiqiang.deng213@gmail.com/ [2]
> https://stackoverflow.com/questions/62849113/how-to-unload-an-overlay-loaded-using-acpi-config-sysfs # [3]
> Reported-by: Hang Zhang <zh.nvgt@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Yay! Happy to see this removed. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

