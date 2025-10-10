Return-Path: <linux-acpi+bounces-17711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4304BCBAB0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 06:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D961890BFA
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 04:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1529326E17A;
	Fri, 10 Oct 2025 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrdiTzbT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D8246BA8
	for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072281; cv=none; b=VCkamEQeEpXZKR7UZLMnwzfzjiuFnLdPFLCSahQ6d55nt7C7PlzAZs0yVxz9qEzKu0aNFeHhdQMo2reqfOEnbvuf9wgXTiwPYx25knHDYkGDbk50TroVXZUPcszLWSiEY3xKEUjwShhrlRdJ9xne+61pIgwSnXnGUbUezGZqm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072281; c=relaxed/simple;
	bh=20zVq/I1A85ImSdUuzZ7bh9Qs7dqD4eEIEsQzzw5Ci4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADa4cN6FZt7RViPRHMlxvAucyzXlFznkPkqVMK+rXqyxFqPZSU8rm1yqaluEMULwEIJgKfw9tg2uAeULRXAiswt5583Ua7yljEAy7L6fNlJc2s5AuN4PfeU+AbFQnJmWPy4Eo+vlaLpt/NjFlPQtoJWDdKBYQlqfx8ciLp8818k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrdiTzbT; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63b960a0a2bso2024997d50.1
        for <linux-acpi@vger.kernel.org>; Thu, 09 Oct 2025 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072278; x=1760677078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=GrdiTzbTpmXrgj0/PjkohCZ6LgFNbxV45gb5L/ZVbzaWKAHJgA12/mfFqFdtOpY72m
         bZZCyt4k8jRvQo4unsWw4ZeaFcU/eOYR2U/wcLgsvZR/RYdUoV9fmyuViF8Of5PYj/l4
         634Gm0JHXypxB9ycdlhLckuOP80mjqw4wIO9HLiTQ6purdE8gu3SXgXaNMsYndjRbf75
         1dPvVv1bpLUsn7UsoLTsiGPIZ2KQmnwtMFB4nrm8RHlzLeSFwrO7OIHtu7G4t0f6Q3Az
         maevl8wn3jZRwLsUqzTevJOM0Q45hnxhlAkendZd7mXKlZsyaRmG6ugJRYjmZ1sxfyiy
         qCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072278; x=1760677078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=OnHr/XmxBqdLje0ad97jWukuJhURlCBpb23ySEdAMtvmluEfaPNnRX20mUm5vVWV0E
         bIHzCHJwtAhZc2LjFHV0BN4shP+pQjNUlXOX9CkcvXmFVHkQToGOhozJQ59RDiiak0y1
         PTpWkkDUHO9fkz7kTpc4Ld+IEGGM4X2yaEC8222aOjD1Veogmbl2p094WvbMETMbDYYt
         LIYo5jmqqHmyFixN+eY8B1fz6daNeuTIbGdVgJsMKA0rh6XS6JimiTNIOC3m9P6Q/oLL
         5k1z6MpkQTQ2XUwtI62g3tVFekF2yVJLvaMLxE+W3kufDGDFAK0QrhK5+Ll4EA8r3jyv
         1utQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa0qTHXcYYDbDVp0j7ae3Z0Ec6eQJ2XuCxZaOIOqSbdsgmbY1+mV0pnCvF7T7mdYLzllbbPY7Tq4jT@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEHC5BBaWfFJn7Y7VC7A6atdpu0mRpUG2shsD2jdGPqu/48WS
	e639VTRsk0n3Lg5fcxJl5sfY4oo7Ricw7bhMeK7YwoPQCWKn8f1+oZRVCUtznnRj08enH3Ah+Xo
	zHuiMAJvWKxtXWhvywdkMmy9pKUqS8zw=
X-Gm-Gg: ASbGncvmFAyND6WQubtbGu2UPQhU3vIVxrlLJv7GoGhNfEDNOqJWGiwOtCqlsD7N/V0
	GM8Vjoz3lQ0kypOdpp5/fgoVr/R/xlQrvz0DMXVoV1kP4LQF81DIbL1Pj+SRU6MEjca0rg4tjy5
	yeYNPUJ6i0s/EE5W02/rTChUJF6EY3XdiCdNHVaBzxM0ttcN9BYsKui38Y5ygqdLPoIR/x8pV+r
	BUocfDRQNBFiNdoUh3FO5PD8g==
X-Google-Smtp-Source: AGHT+IHqDciv7GAPYfMGdKr9Fwuo5GT168N8GcrpsJ5KozP5HqYqg/LDALxuogvzJXgNCm6zrA+DoCqu7lr8uhQrVc0=
X-Received: by 2002:a53:5009:0:b0:636:2420:d3ce with SMTP id
 956f58d0204a3-63ccb93456dmr7466309d50.51.1760072277565; Thu, 09 Oct 2025
 21:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
 <20250925131055.3933381-1-nschichan@freebox.fr>
In-Reply-To: <20250925131055.3933381-1-nschichan@freebox.fr>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:57:21 +0300
X-Gm-Features: AS18NWAQwCKadWHXCZjVUBNaD3TaKIilJiJAQzSbvGFaYuFuE8UDpW1_H3riB-k
Message-ID: <CAPnZJGBPyONjJoM6cskxysDnN4pxWuWJCK5A6TgikR2xHsrN5Q@mail.gmail.com>
Subject: Re: [PATCH-RFC] init: simplify initrd code (was Re: [PATCH RESEND
 00/62] initrd: remove classic initrd support).
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:12=E2=80=AFPM <nschichan@freebox.fr> wrote:
> - drop prompt_ramdisk and ramdisk_start kernel parameters
> - drop compression support
> - drop image autodetection, the whole /initrd.image content is now
>   copied into /dev/ram0
> - remove rd_load_disk() which doesn't seem to be used anywhere.

I welcome any initrd simplification!

> Hopefully my email config is now better and reaches gmail users
> correctly.

Yes, I got this email.

--
Askar Safin

