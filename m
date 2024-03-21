Return-Path: <linux-acpi+bounces-4413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B68881BD7
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Mar 2024 05:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0451FB21906
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Mar 2024 04:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DCAC13C;
	Thu, 21 Mar 2024 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="2jJ4AblK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A99BA56
	for <linux-acpi@vger.kernel.org>; Thu, 21 Mar 2024 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994338; cv=none; b=l9JFbDWqI4fpDHD8Pcc1KPDhPHnOanwD1/8A1Ka7Ve2gQDnVLyI9QsjPrcTu20TBaFjqOydeVou9TqeWlquPnWg9yd6RLKHcqLs5QXt2LplYd+EjfJ2jO+qTsIvYJNa9MnnVhSkPxViat7JpaGnFh3X8ENylbHTuCtPt5UWgpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994338; c=relaxed/simple;
	bh=D2LKJBuegrkqqFvtx1Ne8dXhiyvoMiJPHPxb1SNIvUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX5NmXYcVmWsBjQWIwUJUCJah8HRKqAhpQ3x/3htS0PiKE8pm2q8HpEq22EP0JvF2vr2m9EgcLi+7PAb2J7qLLGX+pxQGbWmUnFZHdsne0OAo0/MauT+fLggK5MqORCQ4ICKDyUJsybc1+Z3f7/KFrO4NxyXH/FUuP2CpH7noPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=2jJ4AblK; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2282597eff5so422260fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Mar 2024 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1710994335; x=1711599135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kduO0x4spM88iFaD5FhSFW1gMwV+o0hY6zrL+nrtm8g=;
        b=2jJ4AblKvSd4asP6qTZm8XR96httGorJXDClfIqxX5786OppVwlxi/RhvamfoCZRe3
         l8aHQ/PTP07opk796FrPvb0G7xhnMzEwwQ9KQUFJSlsAJVoZ3xpcmdAl4GJHhkTbfQYd
         Bun2BEZ0Ys12mjTU3bz3XWmeTsc3geeFgBRi9zZ9zw2JWD498sgNLitoOGeO2KiDNEZF
         +G7XpNUhLoF/YJoh/vIAQyH79yo+Rowpy1nTsrjPOZIkRWVxVadqNpt7nKzthm31Sx3y
         hrBeM6NnU9vafU0gy2uTY7DqtnyfqF6/9kf3eO1mnqdtM7p2qecZ1ZuArzyiFWuxsthP
         qX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710994335; x=1711599135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kduO0x4spM88iFaD5FhSFW1gMwV+o0hY6zrL+nrtm8g=;
        b=wv2W0+3U9gvnf1ZNfVTN0kucYQ46ZnXFsefAdWu1PNpyGZ6FTA6YMciHtMrJCF5/kc
         qLnPX012sOmI6O4tWtuBeVXlvSQqgW566aqqNfLb2dLkOGCrIVML0S8gZzacBoWcJBVE
         6+J+3WCNRkECroqwt4MVGSkyrQRGT/WujsYTQs6vTVqxo+4T2o104uMOElhVcXW9m1/k
         s2XiSSk3v34O5h9LCXwLylQGGXIaX+XIhKUzwSJbgufIAVHoE/CQUTySoMNzWJF1uSLx
         +O/JCKezArPNUqzqqc0HUyb8xmNEPzSh8YIyTb/E2LxspwVqExap7Nab8aUrtTNmbZ4E
         GTAA==
X-Forwarded-Encrypted: i=1; AJvYcCUoxmCLd2z09XK5C7Nb918srYvOssu5AITpQRDKgmUz8FWg04N2okJQEXo66d4eooBwMyh/eJsJDndJe3Y7acgfCjhLAmfBfUhVWA==
X-Gm-Message-State: AOJu0YyY50VQrRHxWq+HBE9TuGOUHNKq1oxdQufVdISr1hNYTx7yQE49
	jGTU0S3CwCrP+cEan3VsW0bWWue5TNquOtwZnB2dr0MVWFV6zDMvwLj82Gw/d7g=
X-Google-Smtp-Source: AGHT+IGx3642CaswuSrx68/XcrK8Mgl4EVGL8+vIwCPFuG1X2sbTQHUJ7i2/MAIw0/siJ9d9NovCiw==
X-Received: by 2002:a05:6870:36d2:b0:222:7273:a0a6 with SMTP id u18-20020a05687036d200b002227273a0a6mr1054226oak.49.1710994334868;
        Wed, 20 Mar 2024 21:12:14 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:a790:e494:c435:a45e:14c9])
        by smtp.gmail.com with ESMTPSA id v18-20020aa78512000000b006e6c60aeb21sm12582842pfn.70.2024.03.20.21.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 21:12:14 -0700 (PDT)
Date: Wed, 20 Mar 2024 21:12:11 -0700
From: Drew Fustini <drew@pdp7.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq
 support
Message-ID: <Zfuzmx/bvJZjWDx4@x1>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
 <ZfiKooxO88h1nj35@x1>
 <Zfj4FnG5vAPP55ri@x1>
 <Zflm5cje/+rnZ7HH@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zflm5cje/+rnZ7HH@sunil-laptop>

On Tue, Mar 19, 2024 at 03:50:21PM +0530, Sunil V L wrote:
> On Mon, Mar 18, 2024 at 07:27:34PM -0700, Drew Fustini wrote:
> > On Mon, Mar 18, 2024 at 11:40:34AM -0700, Drew Fustini wrote:
> > > On Thu, Feb 08, 2024 at 09:14:11AM +0530, Sunil V L wrote:
> > > > This series enables the support for "Collaborative Processor Performance
> > > > Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> > > > encoding of CPPC registers as defined in RISC-V FFH spec [2].
> > > > 
> > > > CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> > > > enable this, is available at [2].
> > > > 
> > > > [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> > > > [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> > > > 
> > > > The series is based on the LPI support series.
> > > > Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> > > > (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)
> > > 
> > > Should the https://github.com/vlsunil/qemu/tree/lpi_exp branch also be
> > > used for this CPPC series too?
> > 
> > I noticed the ventanamicro qemu repo has a dev-upstream branch [1] which
> > contains 4bb6ba4d0fb9 ("riscv/virt: acpi: Enable CPPC - _CPC and _PSD").
> > I've built that but I still see 'SBI CPPC extension NOT detected!!' in
> > the Linux boot log.
> > 
> > I'm using upstream opensbi. It seems that sbi_cppc_probe() fails because
> > cppc_dev is not set. Nothing in the upstream opensbi repo seems to call
> > sbi_cppc_set_device(), so I am uncertain how it is possible for it to
> > work. Is there an opensbi branch I should be using?
> > 
> > Thanks,
> > Drew
> > 
> > [1] https://github.com/ventanamicro/qemu/tree/dev-upstream
> 
> Please use below branches for qemu and opensbi. These are just dummy
> objects/interfaces added to test the kernel change which are otherwise
> platform specific features.
> 
> https://github.com/vlsunil/qemu/tree/lpi_cppc_exp
> https://github.com/vlsunil/opensbi/tree/cppc_exp

I know the opensbi branch is just for the purpose of testing the kernel
driver. However, I am new to ACPI and I am trying to understand how a
real system might work.

The _CPC register address encoding in the RISC-V FFH spec enables the
SBI CPPC register ID to be specified. But how would SBI firmware know
what physical address corresponds to the CPPC register?

If sbi_cppc_test_write() [1] was implemented for a real system, then how
would it know what physical address to write to for a CPPC register like
SBI_CPPC_DESIRED_PERF?

Thanks,
Drew

[1] https://github.com/vlsunil/opensbi/commit/e23cda47158626f96e5992db00efaaac5dab31b0

