Return-Path: <linux-acpi+bounces-4390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C3880B85
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Mar 2024 07:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D65283ED7
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Mar 2024 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106621DA3A;
	Wed, 20 Mar 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="0aG9J4UJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8A23D2
	for <linux-acpi@vger.kernel.org>; Wed, 20 Mar 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917679; cv=none; b=JcKEBNKb40lsEH3T6JohXSKPdMjiK9yGAv8qjiYQbGJL1+UHLne7KNCOag+0cd5R6GyhrJ0wRDqgaOqnAWxRlrbJ7d1v7OYlssUer6CQH7Jvq8oEfiYBO1Gan/ybK++lgc9xVeVL4Aj1KeOeiw1f8lphaMY31NELoQR02CKKG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917679; c=relaxed/simple;
	bh=jMfB7g2siTVontWYpfsSZKWd5DEii2/pAstIQ3EjVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7npGjDeXmqkQfwXf69TBWP81NdI6GmdzDTuFHd1UHffgiY3X74tXNzDiTz+yq4F1ZBfNijeTDUndHG5wmLsJmqx4Kcuq4ub+Z4KvQ9pHUe/XkViqPUd2sIQTErvPpp6IgjOQc0aUHiNLExAt38d+efrEWhfxTnBJ9zzjwHGWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=0aG9J4UJ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4a14c52fcso1768227eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 Mar 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1710917675; x=1711522475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTJQaQxZhR2F3wHrCMNTf+e3Fq0ItLwh5zOXlIkVHvA=;
        b=0aG9J4UJA0yH+UXSkmDLwzYr1nT3UyWLi4F1iw2I9M1jRqSfdSOBJtvTP5i3Yom1w4
         lLlJixRmheq1krhJvVRHjMzQFTpHOgKvgUtpPmvdkNb5H5JdEYoBn+wKw1+TMSCkjCn8
         K3YgKj4X1I6+MV0F4j30/5pk2t5nB/aQ4JpbC881fc2KZXb9mFqU4a+iBDamyIkWfcBC
         u7nPGqOGoz3hAQputYn7ehC66ldhH4t8x4a0Wifzh2V3gzJFGvvykyNY7AHH8Po2MJfw
         HSfLHb5R7y/WL21rwWk2nAa81jlPQQIqxOMgRQ5Wh5J0754Lg0zcnEFjHzodxbpYfufU
         vQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710917675; x=1711522475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTJQaQxZhR2F3wHrCMNTf+e3Fq0ItLwh5zOXlIkVHvA=;
        b=iZ+wsq7UXWtafzhkq+6ec1sKHVSlcx1N7J7fOsIonX2mH7sH/3rHtpix1Y0JRvKN+9
         pF7ehwAkMOsVz7tnBwppfchxBtotUVfRX3Z9AtuKnaUrXEzzWlVVT/OODIBMZ/uj7eVc
         l6nqWwbw0E4/z1HcuVOvpPZvMSG446MjmWPCz6I2Mr+Du1nERP2oF27cjmUBy4nCf3B7
         0odD6Dny3XSjRWiVMQI8LIVSW5k4r34+gN/rb4NT3PE5MSu/A5vLXQG/gqskPelK3ylO
         Fh2rcHK1ULn+qcWLQuTduzXNyV7+Z045l0EqYd9uhyiqiE5YlFcu/J+o6PF8ELtHAb68
         hbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXKa4gcjcbHV5gN2itz5C50tbs5iuJDrBhaDUhPd3zoSIuCiKjX4JClPdEXbYdsya2lPiGbWE1NekKQy1b3bhBpaYRAiiYQG7iv3Q==
X-Gm-Message-State: AOJu0YyEfuaDyjIjUpELZPC8PkAN5nnh8iusx1qOC0vYXjRzn/y8Ok++
	2RechkxWGngO5J/AxQKSRv9WYUkQ62MHCKu/F6sOY3PSUCc7xugn1PgfXUClNeE=
X-Google-Smtp-Source: AGHT+IG7X3jSDNZLrKRWi8e9irTqZ54hqhH9dSlyY23ZUykG+Oayhus4L7kkKddYgpIV/TxBlkZUEg==
X-Received: by 2002:a05:6359:5fab:b0:17e:bbbb:92a0 with SMTP id lh43-20020a0563595fab00b0017ebbbb92a0mr975086rwc.2.1710917675245;
        Tue, 19 Mar 2024 23:54:35 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:a790:26b3:a3f9:cbee:d9f9])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b005ceeeea1816sm10037401pgc.77.2024.03.19.23.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 23:54:34 -0700 (PDT)
Date: Tue, 19 Mar 2024 23:54:32 -0700
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
Message-ID: <ZfqIKLnaAqOmXnWj@x1>
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

Thank you for providing those branches.

The CPPC extension is now detected okay during boot but I see the
following in the boot log [1]:

[    1.094707] cpufreq: cpufreq_online: ->get() failed

Have you seen that too?

This appears to be from the following in drivers/cpufreq/cpufreq.c

1500         if (cpufreq_driver->get && has_target()) {
1501                 policy->cur = cpufreq_driver->get(policy->cpu);
1502                 if (!policy->cur) {
1503                         ret = -EIO;
1504                         pr_err("%s: ->get() failed\n", __func__);
1505                         goto out_destroy_policy;
1506                 }
1507         }

I'm not very familiar with the cpufreq code yet. My first thought is
that maybe the get() function pointer isn't set correctly?

thanks,
drew

[1] https://gist.github.com/pdp7/00ab047509d25871f87b3dc1b2445eaa

