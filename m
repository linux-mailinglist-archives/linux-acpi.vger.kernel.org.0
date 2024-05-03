Return-Path: <linux-acpi+bounces-5618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327598BAE4C
	for <lists+linux-acpi@lfdr.de>; Fri,  3 May 2024 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33921F238F1
	for <lists+linux-acpi@lfdr.de>; Fri,  3 May 2024 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6BD154433;
	Fri,  3 May 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JfmkKyfa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2915442C
	for <linux-acpi@vger.kernel.org>; Fri,  3 May 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744792; cv=none; b=p7QD4SJs8hSpuGr/mdjjfhwwVeLYxgkFrXJgRWA4Fpg+LqvESbQgKWgq06aqfz8g7yEEbHu7NNL04iVadhIj1B4EKQB8GZy6k6m1XMaI8YhBxJ16eDyEcQFaG0D8BRXR5i6j0iSh1VdjZbvXkNyNc3lbMaXrtPnbeL8wmwQNMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744792; c=relaxed/simple;
	bh=9XTu69i9//N23QjLUaRVeITayCFaVH/ZcxE8frlF8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLeJN6QYBVCZ+5chP+Oz62A09nsAJalPdOp2jmL1SyKohwmWVrm7YjA8C5GK1eXt6uKWISb1tNS19CQsuwFeE9MkuwpRijup5BTr0i7zc8RxrOqERJfTOa+MQEtv205EWpcHvaahu2E/5jad0lau1t4A/sKJlbtDk6M4T+B7KK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JfmkKyfa; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso9077870276.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 May 2024 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714744789; x=1715349589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChPcRq4NfZHnrwL48HNhQ7iFI35ROHq79DvxMeghd44=;
        b=JfmkKyfaJuYg5mwrmJMxqu7Eel+9ThNcdFDiYO9YqQ1kJBCkO3H/xMSHQSw6Wb9+Kg
         05UzQEys4dw00NIr/Mlwr65do+t23F6VYKLzsFS/JuEn1Nq19druVREWyfQp09GPIMMA
         9dU72hsdHzPZ+f02XFa0eSpBl8ubhCKk1gkfpXSjDeNsCYk/KzF6XmXKe4OlTCOEPTOa
         KKV4x6P8fJc/wYycb4EPANAjPXBDu0IsZQYPmZ25cc/Z3uHhYS4ZxjgqtdCA4FgiUNu3
         zmHbsv8vlZpOJ3WKrevk4/I56d3Xh3d7+zW2uVzY0KymQ8aXGh4i3907OzcyHwNGrNSW
         VvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744789; x=1715349589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChPcRq4NfZHnrwL48HNhQ7iFI35ROHq79DvxMeghd44=;
        b=EZWMkbyj/d/3YQRlDJqRDanHRnYdVvEg7mDj4bYqMhLADpumIJSvhxDQl749shWe4a
         ufuyivJNu6jmJSCt5Vt1R7saONh7J3w0oH9Jd6OWzKdSO7LX0Y2O6tYWT16XUGok+qXU
         HXuO3lJI2PNQU85K8IKSx+XsrbpSi/S3T8f5ge8675bmZfqo4jWvG7FJDYccfRtEVGC5
         RGQkolA6bJ6oMj9OckkBw/DnuoWzrUFQTDKEpvybTxyQYnzvYJ5gZw22Wb0RihUyiX1K
         RBorHGUOj6H0zFeB8n987KIKXycpH4mLi6NQ4RjHWi2HILJdBhEDfniTFJ0snqAhB/ft
         MMrA==
X-Forwarded-Encrypted: i=1; AJvYcCXDmo10/KN62SRsz17zHmo6ZOXq2uzPxQGyKJi6DfIPE5H9Zfw/2TxAFcdmrzoe3P4gNxslKnNxZbLxjOUERPytEKFBhmPiQkLyOA==
X-Gm-Message-State: AOJu0Yy0DyIuVohJs9IHVsJryEAhcc2muAsjpaIGwDKeGzE/U/ixLfmd
	rGcf1HN0Diy7eT+idyjWs6KZg9cuEKdcDpCh4hFuxynkxNC/m1rF3Hdnddt0gCg=
X-Google-Smtp-Source: AGHT+IFctvodowwbTmaaEDSmGBZj/O9adwDNYje40Gk9jTBEJueLXsMCVV/UKXpClCHAizcOHif2cQ==
X-Received: by 2002:a05:6902:246:b0:de5:e046:6ac with SMTP id k6-20020a056902024600b00de5e04606acmr2994231ybs.5.1714744789552;
        Fri, 03 May 2024 06:59:49 -0700 (PDT)
Received: from sunil-laptop ([106.51.191.139])
        by smtp.gmail.com with ESMTPSA id l14-20020a25bf8e000000b00de51b87bfefsm627782ybk.18.2024.05.03.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:59:48 -0700 (PDT)
Date: Fri, 3 May 2024 19:29:35 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 17/17] serial: 8250: Add 8250_acpi driver
Message-ID: <ZjTtx88zk4GvCImk@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
 <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
 <ZjN3GQI3gegYOIgS@sunil-laptop>
 <ZjOy2G0qN5G076i0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjOy2G0qN5G076i0@smile.fi.intel.com>

On Thu, May 02, 2024 at 06:35:52PM +0300, Andy Shevchenko wrote:
> On Thu, May 02, 2024 at 04:50:57PM +0530, Sunil V L wrote:
> > On Thu, May 02, 2024 at 01:09:57PM +0300, Andy Shevchenko wrote:
> > > On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> > > > On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > This driver is not a duplicate of 8250_pnp. It just relies on UART
> > > > enumerated as platform device instead of using PNP interfaces.
> > > > Isn't it better and simple to have an option to enumerate as platform
> > > > device instead of PNP? 
> > > 
> > > Ah, then extract platform driver first from 8250_core.c.
> > > 
> > Let me know if I understand your suggestion correctly. Do you mean call
> > something like serial8250_acpi_init() from serial8250_init() and
> > register the driver directly in serial8250_acpi_init()?
> 
> Extract the code to be 8250_platform.c and update that file.
> I have locally the extraction of RSA code, I will see if I can help you
> with the rest.
> 
Thanks!. That will be helpful. TBH, I don't understand what to do for
extracting the platform driver code. There are already several vendor
specific UART drivers (ex: 8250_fsl.c) which are enumerated as platform
devices. 8250_core.c looks cleanly supporting such drivers which can
register themselves with the core. For generic UART, DT has 8250_of.c
and ACPI has 8250_pnp.c. But 8250_pnp.c comes with baggage of PNP
contract. So, the driver in this patch is similar to vendor specific
drivers to support generic uart devices which are enumerated as platform
device. I can rename 8250_acpi.c to 8250_platform.c if that is better.

Could you please help with a patch even if not compiled so that I can
understand your suggestion better? 

Thanks for your help!
Sunil

