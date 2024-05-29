Return-Path: <linux-acpi+bounces-6074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13B8D32D9
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2024 11:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD21C20FB6
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2024 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD2169AD9;
	Wed, 29 May 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="HJi43AvB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169615B109
	for <linux-acpi@vger.kernel.org>; Wed, 29 May 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974550; cv=none; b=oXOfXvzyUm7XaZZD4w4/fjye/8eqAgZtbHxNd4zDMY3trK5PHF//VdfPxUkBxh0lPeCqXbNLgs24VI+PCghn+I4Sg06Cn77rnJkDqh5i8ygtn9KdN4SZLCbU9KydvRVDdIQD9Gvz6EcKE42PHdUUcfHzdbT3C8nDfTbzXYySUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974550; c=relaxed/simple;
	bh=ra1NS+9fSWdb9q8/PcT29/DwMyhQPkUZ6X8Be6pbo2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADSMcRoaRRNf7lDgskeSWn+DeikNAvHUrdVz6wrhCTz0i8oNAuGqucJiFQzk1mg87EutelrEvLrLM+dCWBZTGAP2+DApJFLYjCybKwyG6V1R5WZIK+gjvG+SjGfJQdkWmfl/lAF8msw3hk5F7HqjiXDI+moOsZpcZtR0fzT4N68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=HJi43AvB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-681a4427816so1424634a12.3
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2024 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1716974549; x=1717579349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayGsdOx736/Ldjrgu8+xcuCXDa4GD/n6h1A7Kseqpio=;
        b=HJi43AvBd+VnmdGwGfLfcRBA6Xhz0R0JVa3gYo7AmrfDQBcKBdJO9F4j0iOE8ZOpFH
         DLH/wcP6Tm4TxMeYYtKOge9klBbvW7he+119IR5PY7Y5U8IDvt665EVts/SoWa/e52ER
         aIZm2ujr0kkqkt+Rkm+rIK1qUjiATk6kvOo7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716974549; x=1717579349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayGsdOx736/Ldjrgu8+xcuCXDa4GD/n6h1A7Kseqpio=;
        b=KrUcphKlzw2CKE/iKK6zldVF1LvKheYHcAqZ+egVeDwO3PAkZ2xD0emeEsGfQ89kzs
         u65/AyyLNgc3IVSnvSeE0M99yswyw+YKlZhSDQ+v5SoNt8Y99cX/ShTjVbvFn/bbwxOL
         qL4GvPVWxDQjxkj3YGMY6FAHD9KqncqPhnxN4Vva0O7P48Ot0kDciy0xe0UA4/Fd+Wyd
         MFIPzSHLw5iny3io5c67iDkhU9jF9pTOkJAT3eUM5xjG3BKj4wbsWiMPZ1SLMkx5UEvf
         zA8VKorqRLTyEB4eL7EVGiexZd6u9viBvyOOG0wPHSbIZTQQvPmhPudfDjIKwnrMJuT6
         BBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX59SgxeWjZ11GFHlrvxz4nFiswrl5oZ5ztP6fYGKZr4OEC4ZxUrAnGci4+390lUW9ppdJuWR2Ta7S9yLTBrLpt51xQ+vx934PknA==
X-Gm-Message-State: AOJu0Ywr0CWsh098oU8fhdDmYZr/5EiteOHgkrFeYoMLOXbDUyF7I2IV
	rGYVSZ8wGA9eV+3C7WirV7O6gh6dIjY9oYUHDUEQOwNezBXqyMjTsn++RkyAXudcKL1YXkCxjis
	i
X-Google-Smtp-Source: AGHT+IHTpPNGZHMBxVEasDQE0AcmPyQY0xs7GX9k/r2GQYi+8iF3qtVD7NFoq5OWftN6Pr8hgG4yLQ==
X-Received: by 2002:a17:90a:e501:b0:2bd:9256:8ce0 with SMTP id 98e67ed59e1d1-2bf5ea3c2f8mr13150409a91.14.1716974548681;
        Wed, 29 May 2024 02:22:28 -0700 (PDT)
Received: from localhost.localdomain ([103.14.255.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c033ce1d0bsm786090a91.19.2024.05.29.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 02:22:28 -0700 (PDT)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: rafael@kernel.org
Cc: chunjie.zhu@cloud.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix kdump kernel cannot find ACPI RSDP
Date: Wed, 29 May 2024 09:21:15 +0000
Message-Id: <20240529092115.375113-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0gcyZM7PZPrKccLhNtNDhHvqrZsgD-+Xx+W9WesD3yhyw@mail.gmail.com>
References: <CAJZ5v0gcyZM7PZPrKccLhNtNDhHvqrZsgD-+Xx+W9WesD3yhyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: "Rafael J. Wysocki" <rafael@kernel.org>
> Date: Mon, 27 May 2024 12:52:19 +0200
> Subject: Re: [PATCH] fix kdump kernel cannot find ACPI RSDP
> To: Chunjie Zhu <chunjie.zhu@cloud.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
> 	linux-kernel@vger.kernel.org
> 
> On Fri, May 24, 2024 at 11:43=E2=80=AFAM Chunjie Zhu <chunjie.zhu@cloud.com=
> > wrote:
> >
> > kexec/kdump must pass acpi_rsdp (physical address of ACPI RSDP table) to =
> the
> > crash kernel, especially in EFI case, otherwise, the crash kernel fails t=
> o
> > locate ACPI RSDP table. Consequently, ACPI init runs into error, and APIC
> > mmio read page fault happens, finally crash kernel gets stuck.
> 
> Fair enough.
> 
> So has this ever worked before?  Presumably it has, in which case it
> has regressed and so it would be prudent to say when it broke and why
> and explain why the proposed change is the right one to make.

The existing code works only if the kexec() system call (CONFIG_KEXEC) is
enabled, however, we can enter the kdump kernel by one of the following
methods,

	1. kexec_file system call (CONFIG_KEXEC_FILE)
	2. Xen-initiated crash

Instead of CONFIG_KEXEC, setup_acpi_rsdp should depend on CONFIG_KEXEC_CORE,
which should be enabled in any case where kernel is used as a kdump kernel.

> 
> > Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
> > ---
> >  drivers/acpi/osl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index f725813d0cce..39474468dba1 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -174,7 +174,7 @@ void acpi_os_vprintf(const char *fmt, va_list args)
> >  #endif
> >  }
> >
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >  static unsigned long acpi_rsdp;
> >  static int __init setup_acpi_rsdp(char *arg)
> >  {
> > @@ -187,7 +187,7 @@ acpi_physical_address __init acpi_os_get_root_pointer=
> (void)
> >  {
> >         acpi_physical_address pa;
> >
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >         /*
> >          * We may have been provided with an RSDP on the command line,
> >          * but if a malicious user has done so they may be pointing us
> > --
> > 2.34.1
> >
> 

