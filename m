Return-Path: <linux-acpi+bounces-19431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9ACA5E4E
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 03:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A029230208F5
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 02:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43055254AFF;
	Fri,  5 Dec 2025 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz6BrHZV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45C17E4
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764901004; cv=none; b=N+1T032iNcQSgVbAVm/7CLoHhOx946M1SY/iPJAwkJSk8K4SzYhLnd+udQ+rNettMdRlPqcGroM4YFe7TQVYhxX6RKegY/zyT3va0kb1lh96wpwM5tDd3o88j7zMGWs5iGhUq0t1pfk2eOGQ/NdOGTZThAi+DT/GRW3MTLQ67n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764901004; c=relaxed/simple;
	bh=XN2xK0L6T8z2gUvj7EKa9rykXv4aaY2b2j4P32dthxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z01itky3OO4hpmRV2ZV6v7dd7g4Ld8oQan4qJWJfrKBiQSPwqdLvTawzK1+szl+3Iy+6oXiuV8OB2o8Z5EogmcFKOOptgRx/8tj9K/opjWyj98NI1kaKEezS8hqh5tX3lcvo983ZLHoWaXfHQIAG7hGzqZzIIzysDK8VYbDUPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz6BrHZV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59584301f0cso1812126e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 04 Dec 2025 18:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764901001; x=1765505801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWuRmLeNcvfLPbQJ5qeNcNYIaKTZlD00V+D24Ngr388=;
        b=gz6BrHZVjWmIQRJIZLrtAH7dOhvWd+bbQMb85jql63+CnvW4HBQMSSTpFb1WNkjrhl
         WLHnKQk1jB9J5GX4/TSn/nfC8TOph0XxWeS4kEUHE5b0xi51vFpvgZoam9NqPnoRPlnW
         rPB24TMIOdbRxmqzJt2Kfb/3oJLeLK5jwN8fCY3HKS+LDqwr6CenD7KqlJQf43wUx1lV
         lrlajDKy7a32RmgF6PE5FceRQ9IZeLHbfDieRZIxgoxwxeWfu14TgKFcYnmHOkxwHZgE
         sbKpVgt04G2Z4uCe7m4fHlsiXtmvbI0279YteJuLfcLIGX26CDGr/5W7hJdB7RELEhaj
         RSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764901001; x=1765505801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWuRmLeNcvfLPbQJ5qeNcNYIaKTZlD00V+D24Ngr388=;
        b=n0hIn6oI8ZjRCsNLGHKVhMEA8Mpq/9WgRPoaSPZoA7EA8taBWPLZTT+gfl5PnnkUJn
         5u26hDxlAIgpvTUeytYvBFA6h1Q5B9McP4UkXM+l1Z/Klkbf+fEs3Fj+nX90YyHDywzx
         MXj98liPR3Fm/b8hSL5YvynQeeoTH3+yMBaYsBjvudKcdYWPIJ5mf3vpDH7zAcQbt2KC
         8Qe4pxm5rtsFEl8bWa6/Uihyqfe6EYBjhANj55gUmT8bWybe7QDBUh3M5yuiKU0M0YBK
         pia5h4q/jtZyKBrfIFEHlPVsUjLBYEkkkVdtGuGmlg5xb3u8pPo0XvAixRROzKBTO4WU
         hTcg==
X-Forwarded-Encrypted: i=1; AJvYcCUBymhkW7bHxtAiYLYsoH4ogvi8t1cNX55DedSgljXxMJqQd7hNhKhcbIFwEpsGhjrtE65rKrEsOYfe@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpZyAekhBQRLH2Peal+mzGgghfRnQ2duKlQJZ0xMcWJsIkeOd
	tBZj4k7g3fWlEMim+tMt89JvO9ICmpjWTErPHqdN+4IodZ/y8KRrwiu7
X-Gm-Gg: ASbGncujn4/sbBcy9sP35gBhU/n+zaz6etCv2rpXA+I/w0gFHB3XDXgXFh6gx2Tneec
	LSsCnzALbMN2Ru4oSzEkwmZRoDOxEC21yUS9copldRw6kr7ZFsSH9r9OxU1Cifd9eIUG9YvFFPO
	EsXrEg2zEpimD0dWIqGpzrL24kU9iC5YVEg9cxH8Fb49ldHbXBF19mrgbq3D1i1WrE/0E5jSsA1
	WX2aBUDp40AT/ni4tVTuy8mqA64iQ8A1g4wWNhXI9uNIburE8i3w/+9QA5i1Lb2QFvts04F2XG6
	iRTDQpojTDw/TE+/dvM9eJARcl0QNc0oCElnv3JQOoJ88mQEk3iCSn7fv+Rmgz8HlNGCjsGPKo5
	zUoLpCStF/kbSe9FjYqmuWxLR9SzZ2Qi6eV76ua9UwbL1Y22VruiZ71uNA389GMatxdii4XtwP/
	sCMfX3F33r
X-Google-Smtp-Source: AGHT+IEyFEkOELgyiHNROdiStkgWh5vG+sTc4f93bdHueEVTwDFr+UEZX+prSlamxC/7wi7A40g+fA==
X-Received: by 2002:a05:6512:39d2:b0:594:b2be:f3a with SMTP id 2adb3069b0e04-597d66c816amr1719792e87.25.1764901000513;
        Thu, 04 Dec 2025 18:16:40 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-597d7b24862sm999822e87.29.2025.12.04.18.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 18:16:39 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	bartosz.golaszewski@linaro.org,
	benjamin.tissoires@redhat.com,
	dmitry.torokhov@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	regressions@lists.linux.dev,
	rrangel@chromium.org,
	superm1@kernel.org,
	wse@tuxedocomputers.com
Subject: Re: [REGRESSION][BISECTED] Dell Precision 7780 wakes up on its own from suspend
Date: Fri,  5 Dec 2025 05:16:16 +0300
Message-ID: <20251205021616.1570442-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aRDml95nMPeknmUM@smile.fi.intel.com>
References: <aRDml95nMPeknmUM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > Sounds like it comes via GPIO, but it's not handled as touchpad IRQ. You may
> > try to add a quirk to prevent touchpad IRQ from waking the system. That should
> > help I believe.
> > Something like "ignore_wake=INTC1085:00@355" in the kernel command line.
> > If it helps, update drivers/gpio/gpiolib-acpi-quirks.c accordingly.
> 
> It might be actually the touchpad controller name (as I see in the quirk table):
> 
> 	ignore_wake=VEN_0488:00@355

It worked!

First, there is no option "ignore_wake". Correct option name is "gpiolib_acpi.ignore_wake".

I tried "gpiolib_acpi.ignore_wake=INTC1085:00@355", and it didn't help.

I tried "gpiolib_acpi.ignore_wake=VEN_0488:00@355", and it did help!

Please, somebody (maybe Mario?) author a patch.

Thank you in advance.

-- 
Askar Safin

