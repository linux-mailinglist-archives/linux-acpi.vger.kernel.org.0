Return-Path: <linux-acpi+bounces-5594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4548B99E8
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2024 13:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767641F21C0B
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2024 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7654662171;
	Thu,  2 May 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Rwm3SAUl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F64605CE
	for <linux-acpi@vger.kernel.org>; Thu,  2 May 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648876; cv=none; b=fkEDiElY4NG2r0vxjq8y8IHZz4SWWsWcCRkpp5BqkinNA2ksOL4wWQ9STLeEOCIDYID9IUfubUGDYPwuMuOj2UlD7ap9C5qSdQT5EqCguUPlViZaYcbfdGk4O5BN2Unf3EKOfjWv9MKAmT9/murijAs3oAj8Gc6+PNbpPExpTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648876; c=relaxed/simple;
	bh=oyv2s2+UJW+8uzUyt2wKXdhw0Bt0e8jLiqgVDuivZtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUebFcGXFG09u/8BiwKaetKvTHZlMOx6v3PwJRagADCSUQRl/Dwyx+KoXMNHhTH3c9WW3JNUPYjikKSqjaFIBXKDlPUIgl35qqENGoA2Tf4K4/JoJN2h4tE8freFGql0nF4jkWYsNSntQhOajKYn+CvA3w6iZEg7MPotHe27xww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Rwm3SAUl; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61bed738438so27183587b3.2
        for <linux-acpi@vger.kernel.org>; Thu, 02 May 2024 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714648874; x=1715253674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rhZwyyx5fhbpC3BrgW8PW9voWjesLYpxFqigfVNmtY=;
        b=Rwm3SAUlka6pR0PqNs2jsyTsxIHLXOv1LjuNvZ3LpnRTjSq9y37h911NDbDogNOUB8
         CwAauG+ZZecLq+lz5jHXAbMv9vvNTu4cF8sBXDrs7KQhYFahj3Lylnhy2cGz3loD2e50
         mVp85JqcS9u2gpG5gfAMVRgciNffAA6JD2ILxnQ/11KUKRnoPtjF1Bjisy6mmlpML3pa
         dd5oXYGa2Vu924hUS4W8yQvLfolk8qURGT24OtbMvSDsCqjJakWDU1XHjcK5w18mNllN
         o0GItQdvcnDaEoky3qaduemvzPpPBFfwFNJ24vD76Y3YrWHV3jJok4b9wMVrGxLKq8Sh
         SIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714648874; x=1715253674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rhZwyyx5fhbpC3BrgW8PW9voWjesLYpxFqigfVNmtY=;
        b=OMGwcrZtBCDisichBnLcTSp+oWF0b2Wg3wbJAi+cTZnKTSt7em4S2N81uhB389CUOw
         zokU76otZClZxLzyG2CRcECaeoaQy6xhLZzEbSj5ohAqVzmEHDk83ywXlt8Q+LprJO0j
         7SMckcSxIXwFxJSM79S/uadRIeuCGyLmSq0BQdtiyNCgjlyW15CGW2k9Xu4sPJ4/AoPs
         RddjndfP1hHQ/Ak9cOwepe7HSkNVoaxtGptLZpes80k2p6IYieElEu0tc2WiF54cVclc
         yv0ugF3zYX0+ufJufuqCdjfly+Vip3yLlvOF8MA/uaPCxAdRH3CHqU7cFtp6IFuzKxvb
         hNHg==
X-Forwarded-Encrypted: i=1; AJvYcCXHNmx+9R+FkDeFgumO6Qg7Fq6wGZGtACM5W5JlIXcKrgn39HrlIciwzwlqIBap2LYI/q+bkpcbS7h3dT3aPMArSsZZ5rEVyQV36Q==
X-Gm-Message-State: AOJu0YxdleLjMoDuzWNyU44o5MC45lsaP54eYaznDmw+WZqB800HkBW2
	C4RC+U5QrWOg+hReFC3Rj4k6yP/V+ZOzcMVqgrY/sCdvZfqrYjUUM8gSkCAlRH4=
X-Google-Smtp-Source: AGHT+IGdb1BqZxt9QFOczg0KUBkNrWvHSOjTP2hFKx0LDlEWOPANBNbI5rvucoOu4m97AQfAwJklfQ==
X-Received: by 2002:a05:690c:6d11:b0:61b:330e:3fec with SMTP id iv17-20020a05690c6d1100b0061b330e3fecmr1843234ywb.45.1714648872054;
        Thu, 02 May 2024 04:21:12 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id m24-20020a81ae18000000b0061bec8ccb67sm155149ywh.76.2024.05.02.04.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:21:11 -0700 (PDT)
Date: Thu, 2 May 2024 16:50:57 +0530
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
Message-ID: <ZjN3GQI3gegYOIgS@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
 <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNmdfR2J6hNnYle@smile.fi.intel.com>

On Thu, May 02, 2024 at 01:09:57PM +0300, Andy Shevchenko wrote:
> On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> > On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:
> > > On Wed, May 01, 2024 at 05:47:42PM +0530, Sunil V L wrote:
> 
> ...
> 
> > > > + * This driver is for generic 16550 compatible UART enumerated via ACPI
> > > > + * platform bus instead of PNP bus like PNP0501. This is not a full
> > > 
> > > This has to be told in the commit message. Anyway, we don't need a duplication
> > > code, please use 8250_pnp.
> > 
> > Thank you for the review!. Major issue with PNP0501 is, it gets enumerated
> > in a different way which causes issue to get _DEP to work.
> > pnpacpi_init() creates PNP data structures which gets skipped if the
> > UART puts _DEP on the GSI provider (interrupt controller). In that case,
> > we need to somehow reinitialize such PNP devices after interrupt
> > controller gets probed.
> 
> Then fix that code, we don't want a hack driver on top of the existing one for
> the same.
> 
> What I might think out of head is that used IRQ core for your case should
> return a deferred probe error code when it's not ready, then 8250_pnp will
> get reprobed.
> 
Deferred probe was ruled out in prior discussion. Also, deferred probe
will not work with _DEP approach. The reason is, PNP devices itself are
not getting created from the ACPI name space when they have _DEP. Hence,
serial_pnp_probe() will not be called at all.

> > I tried a solution [1] but it required several
> > functions to be moved out of __init. 
> 
> > This driver is not a duplicate of 8250_pnp. It just relies on UART
> > enumerated as platform device instead of using PNP interfaces.
> > Isn't it better and simple to have an option to enumerate as platform
> > device instead of PNP? 
> 
> Ah, then extract platform driver first from 8250_core.c.
> 
Let me know if I understand your suggestion correctly. Do you mean call
something like serial8250_acpi_init() from serial8250_init() and
register the driver directly in serial8250_acpi_init()?

Thanks,
Sunil

