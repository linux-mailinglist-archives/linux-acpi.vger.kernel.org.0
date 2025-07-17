Return-Path: <linux-acpi+bounces-15222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7107B0914D
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0881AA3F84
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCC2F8C28;
	Thu, 17 Jul 2025 16:06:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C312D1F7E;
	Thu, 17 Jul 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768404; cv=none; b=J1JETPbOYP92YFW1xOL/6DvtrHlozLD0exb5d+wsqMvU8/J5Fn7CocRQ4VF3l1OtMI1rP/EyOQF/I42cHd6QEniSmwwhB3mFa/wgVD96eKLBbdjHbhjB5XqeqF/88omSjbqTr1kxS5RNj0HgvJt9ZPvDFCjEqrvsiydBZJzwXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768404; c=relaxed/simple;
	bh=AgSkia3vyN3wnXwEIc2WQexJs6VG3jfaUgZku52mIf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUQct9SdKimCgVLfJkewAC4PYdXmySqZn+Uzf+xcwQrrC74K0COASbIGDoeEEAC5iTqItZlBJqEEq1HSuv/YYPD+8GUPTkPOkGAzcTOqTRFexY6iooKfG5nTejktGbfRZ54wWCZqdtCntIFKN3Yichvqx5DsphpUORq3uBR5xTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so2587676a12.1;
        Thu, 17 Jul 2025 09:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768401; x=1753373201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRcpIrg/I+WIhRSf3upIuAZZeP3ZmwXXMCGjj+mtbZM=;
        b=dIwwDas+5+eDSCD32xUIoCG3Vn4WoOcPJIRwt9ADmJBgqW6KWXEBL1bqwZhfsV+7ue
         L6p7I8XEveFzUSPOaVNlhmJmOId6J+bdR0oZV8gHvsTVFU/1z4CtaCcCIKbPfs5QV2aX
         6GCqXGS7QkIdsVFPmSKGqg+nzL9R3vtiGXeuOr1MtSDZbgF0aQ/0eIUasKWbbfTyxfBY
         rLDjY5Ag27vtMLODitrW/Jf7JfPnt7wU3nFu+mOIAh/nToKL2ivZoLAOnZZmdia7c1sj
         RbjgIKkdLBZMt5SJokktSBThzhOXn2w0rp6mrY2eAkGMK6SfAfKeEBzsUPq01enu4GUo
         /jaw==
X-Forwarded-Encrypted: i=1; AJvYcCW2sN4dI5vaX/cieuWl2H0YsWkLMb8UZhmCnKr4sGd07JEqLYpkFlraitspEytf8FDGutHFWLe5iWsPG2N8@vger.kernel.org, AJvYcCWnLmHfOZfgOt9pN5iXkdTBOceHwpVl+q6iEjqYbmOcMbcQBTxAqtW6xJJ6FiwkJ4SmIlgQAyH++3Di@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8O+52IpRbRF0P5gPcFcPx7ASy1ka+bfAqYSjQ8JO2wfI+3IK
	rrZqOfWKxmYnykbHMOt3JXE2IRP7l2HHf5g5NwZNXOEMhYBQlGn8/qHN
X-Gm-Gg: ASbGnct2pxan4HmyVVFkv4b1+02U9JBO2E2WTItHoyrNAGfYMJ0q0Rhi5x0wix8vh/B
	4A9BdXte0XS9LFtU7uPhdneNz/zTcxqeMh7j4YrLFcaZAnooiegaxzrPUe99mzPh8QktcLd9pQ6
	4NRsZXhR3xOSpMxWw5vmbdZdghtQUjJdStFiI2o7gQhIbQFG6gpqkXF9GFfwUJtmI7LzeDn8FL/
	ZsvFprYrmFMg3c7VajM0dzAtbCltWbi8QIpl85XAl4M4M8KaDbpY3gYauTBHhwlJiA3LXp9iMhl
	KFTy0PCLjWJOb55hUIQvQQJ8MUcH9gTOqpT1zjto+5IdIlgazABcaf9T8r8RHtYTl0Kh2r8Gl7h
	HsBXRL8KCeiU7gA==
X-Google-Smtp-Source: AGHT+IFq+k4Lvk3YRgJ1AfwiC7Wnf6Jw82TtR1rviO/WaXX+XGf2dqe7+UYRpt7NBzp2yANpROMWRg==
X-Received: by 2002:a05:6402:34d3:b0:60c:679e:b957 with SMTP id 4fb4d7f45d1cf-612c01c2de9mr484303a12.1.1752768400806;
        Thu, 17 Jul 2025 09:06:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611f7365c7bsm8670852a12.62.2025.07.17.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:06:40 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:06:38 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <kw7mwmca3ir4nfyofumqiack5sht3aisdchevykdtmlio6xo7z@5xbdibpqvqix>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHWC-J851eaHa_Au@agluck-desk3>

Hello Tony,

On Mon, Jul 14, 2025 at 03:21:44PM -0700, Luck, Tony wrote:

> > But for some reason Breno still wants that info somewhere else.
> 
> So what about something like:

This is a way better suggestion than what I propose and it seems that
Shuai also liked it.

That said, I am playing with it and it is looking promissing. I liked
Borislav idea of having an always-present array and use your error
sources to index the array.

> static struct recovered_error_info {
> 	int	num_recovered_errors;
> 	time64_t	last_recovered_error_timestamp;
> } recovered_error_info[ERR_NUM_SOURCES];

I know naming is hard. Playing with it, I thought about the
hwerror_tracking as the "name" for this feature. Does it sound ok?

> void log_recovered_error(enum recovered_error_sources src)
> {
> 	recovered_error_info[src].num_recovered_errors++;
> 	recovered_error_info[src].last_recovered_error_timestamp =
> 		ktime_get_real_seconds();
> }
> EXPORT_SYMBOL_GPL(log_recovered_error);

Where do you think this code should be? I suppose we have a few options:

  1) Maybe a driver called hwerror_tracking in drivers/ directory
    - Pro: Code is self-contained
    - Cons: This will require a CONFIG_HWERROR_TRACKING, around. Also
      it will create some inter dependency of drivers.
  
  2) A hwerror_tracking.c error in kernel/ and have it always enabled
    - Pro: This is always available, and doesn't depend on the CONFIG dance
    - Cons: There is no way to disable it (?)
  
  3) In some pre-existing file.

Any opinion about it?
Thanks
--breno


