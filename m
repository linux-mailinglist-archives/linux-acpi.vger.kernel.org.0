Return-Path: <linux-acpi+bounces-5633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC448BCD0C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 13:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434CB282CA7
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B034143738;
	Mon,  6 May 2024 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OBdxxJFJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8E142E8F
	for <linux-acpi@vger.kernel.org>; Mon,  6 May 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995939; cv=none; b=pFHQGuZ26fi6mIlqFdwd3YoDw/IsamN65WZekpz7zD5ci53oCdveiGmxmJZlAR7Kl5X4qYd0ZwXt8Q5D4QPqFFygTbYHVA1aIMjfVyiJIOVTE0DhhdQwJUFs8glVuPlXU4wDdQLNxanuo/82l/523FBwc2Dr9+zPxMwY6VNu2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995939; c=relaxed/simple;
	bh=+ehF7BaalUWIfwGCQQBBdo1Vc67pvkdUy+vFzLc1VGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ6pDRiQjX65K0dw1g7kHWoOvX1lBI9RWiEv5S7O/6JXfYI6W5bPz25OvRJbwMb/k69Z059FfQOTHnMMKRYVlxojge2B9vtO0IG5aaWdf11DTJfURA9KdLy7VDg2SimpENIaMbZ+H5WHls3asaI79ASifSnlbWteLQX6Lhg77rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OBdxxJFJ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23e78ef3de7so969315fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 May 2024 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714995937; x=1715600737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mru4lIZY8M9ZaXmhBpUJWDHWUyRRfxkrVAZooaEo0w=;
        b=OBdxxJFJhY+dbRNDtdO3Uuzj1svc3C7LVqt9LFQGsgz57PaAklRnLVOPyt5b9OW8tE
         AA6HhV8sMHZDsWIcd2DB5KRboHuxg7upuMGsiQwBlnH/K7BP9arJB6Eu5d7q8h8JXtPn
         7Mwr3DpgqNuJvW3Xp0vhVg5m2Bd5nU9KJZIebhVxgdQBbLAqZ85LowQmjVuxgrp0g9AB
         Eu35bHoO1vFFNaBNtCIAwpXycgw+R8JAihC5oagSgc+fDwJIlQU8aI93bqaoFdoBZ+X1
         L0FEPr+3EPdKMW2uisPE68lETg0KIab9nifd2bBArmyRSTnmqZGKt53qegQnTtWxxE7S
         Y+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714995937; x=1715600737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mru4lIZY8M9ZaXmhBpUJWDHWUyRRfxkrVAZooaEo0w=;
        b=tHVZpauPwtzGDn5pGsbF5sN7/ZP6uSv8qfcby7TImXLQYW/H00oyALur0+gsnZ9y/V
         R+XnWr1FV5ddNmjjAuvwrEFizqOCY0QXLVhjA3ypOHdQAseXu8feG/yWPuJwXLYq/5k9
         uuSOWRvr6C1YET6Zqk73widl87VKX0ICIU3EV3rP9RAl038zTbS0UWKcChRP29XUMRvF
         Jx6+8eBGcGr4WntJzdOMWX2O4cvjETTHRp/KoPjjo+OrqRiDh7zlHJhvhkspye+YnhsK
         6g21hrfLwowLOx0vfL2xC0l3+LYarUlZX9W0dXCrOG/b0TjyRaCf7dY0U7IoppThptsc
         GF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVKH0h+swmljc/yr96MhMcbPSTEF/JvKhVOKnwyKPaJyH+yH3gm4CNrwUe+VPCR9NfTOxpc4DNfUOYD1eoyPu1m2mTBZU9XS4olHQ==
X-Gm-Message-State: AOJu0Yx2FsfRkODTgtmY9sWJ+cEvw0dM7QjtFvexwS89Efbkp71FCpey
	17+Bn+LIxRw1dqOfJpu6J0rVf3C4bCmB6bFmk/Dq6EtHd+DHaNIa3ajDqwucP54=
X-Google-Smtp-Source: AGHT+IFyCeIGGLi6q/4GvP57e6HELJs2LVP51SvO1LEbo9QoA+TRsrBFgkTO9NTNLl1fhCADnp5IPw==
X-Received: by 2002:a05:6870:1589:b0:233:5b4d:ff90 with SMTP id j9-20020a056870158900b002335b4dff90mr14085436oab.50.1714995936945;
        Mon, 06 May 2024 04:45:36 -0700 (PDT)
Received: from sunil-laptop ([106.51.191.139])
        by smtp.gmail.com with ESMTPSA id ch13-20020a056830638d00b006ebcceb7f8fsm89603otb.62.2024.05.06.04.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 04:45:36 -0700 (PDT)
Date: Mon, 6 May 2024 17:15:22 +0530
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
Message-ID: <ZjjC0vigpqwe6R/c@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
 <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
 <ZjN3GQI3gegYOIgS@sunil-laptop>
 <ZjOy2G0qN5G076i0@smile.fi.intel.com>
 <ZjTtx88zk4GvCImk@sunil-laptop>
 <ZjUDeuCQNCuYgATA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjUDeuCQNCuYgATA@smile.fi.intel.com>

On Fri, May 03, 2024 at 06:32:10PM +0300, Andy Shevchenko wrote:
> On Fri, May 03, 2024 at 07:29:35PM +0530, Sunil V L wrote:
> > On Thu, May 02, 2024 at 06:35:52PM +0300, Andy Shevchenko wrote:
> > > On Thu, May 02, 2024 at 04:50:57PM +0530, Sunil V L wrote:
> > > > On Thu, May 02, 2024 at 01:09:57PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> > > > > > On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > This driver is not a duplicate of 8250_pnp. It just relies on UART
> > > > > > enumerated as platform device instead of using PNP interfaces.
> > > > > > Isn't it better and simple to have an option to enumerate as platform
> > > > > > device instead of PNP? 
> > > > > 
> > > > > Ah, then extract platform driver first from 8250_core.c.
> > > > > 
> > > > Let me know if I understand your suggestion correctly. Do you mean call
> > > > something like serial8250_acpi_init() from serial8250_init() and
> > > > register the driver directly in serial8250_acpi_init()?
> > > 
> > > Extract the code to be 8250_platform.c and update that file.
> > > I have locally the extraction of RSA code, I will see if I can help you
> > > with the rest.
> > > 
> > Thanks!. That will be helpful. TBH, I don't understand what to do for
> > extracting the platform driver code. There are already several vendor
> > specific UART drivers (ex: 8250_fsl.c) which are enumerated as platform
> > devices. 8250_core.c looks cleanly supporting such drivers which can
> > register themselves with the core. For generic UART, DT has 8250_of.c
> > and ACPI has 8250_pnp.c. But 8250_pnp.c comes with baggage of PNP
> > contract. So, the driver in this patch is similar to vendor specific
> > drivers to support generic uart devices which are enumerated as platform
> > device.
> 
> > I can rename 8250_acpi.c to 8250_platform.c if that is better.
> 
> No, that's not what I meant. We _already_ have a generic platform driver,
> it's just inline in the 8250_core.c and needs to be extracted. When it's done,
> you may simply add an ACPI table to it.
> 
> > Could you please help with a patch even if not compiled so that I can
> > understand your suggestion better? 
> 
Okay, Thanks! Andy.

IIUC, you want to extract serial8250_isa_driver from 8250_core and
then add ACPI support. I was not sure about that since I thought it was
only for legacy ISA devices and they seem to be created by OS itself
instead of discovery. ISA driver has some ordering dependency on PNP
driver as well. Anyway, let me try if that is the acceptable way
forward.

Thanks,
Sunil



