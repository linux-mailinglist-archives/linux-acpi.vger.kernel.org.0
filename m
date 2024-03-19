Return-Path: <linux-acpi+bounces-4371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A887F570
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 03:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB301C214D5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 02:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15965189;
	Tue, 19 Mar 2024 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="Yeobk/Hf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F064CEF
	for <linux-acpi@vger.kernel.org>; Tue, 19 Mar 2024 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815260; cv=none; b=cxVvu5FQGOpgwDNYKb/hc3YylE8yuMq9PRBdifJyq2vbLiYL5Yxm9LN6j3olGQ4gPAzfQaF/1GD5+ow2fp5pDsDcEvtBD1RYuOlphQRD++BP4QKV3P9GzMETSKLR4rtwgMFCUGUON5ZYwKFLitcp5yxl7I4qCuqVxeah21aU9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815260; c=relaxed/simple;
	bh=sP2e+6JEJh7rHz8Yoq24mQxbkis71cZ97nSr01L0O54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0vioOPLDfW17tEYdJnKQ34DZDF2AtECxfCzqyeT8NpPdMNc4x/JY8LkFXouz2PgdM7KseiojOvT1WZOUvBv4gzW/HPKHVJfSVaa0LcZZZ2TopnzOpAm9j4vxLCj3cXtQ/NX9tXq9ZueKWmf+u74N1kU5brdrxkhK/8ndKkW0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=Yeobk/Hf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso33554035ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Mar 2024 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1710815258; x=1711420058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aSzY2VJWDittzpsS5JFj/mmLGexq9XYEbkvVBzvnJA=;
        b=Yeobk/Hf0XL3Ax61xcZQttm/BUQsRSsLfxbPgHnCzGbMyDutfh7X0WQbD7CbcJf7L/
         wzsZxuIFAk2IBmmdNaSWPMiB+6WvNUFvySqgZesF/sTypX7ivjMbf8Y5eX8GFa1XiTPH
         s2mwL+1vZsiXd3F+L1b+We9UVMESce9dKmAX5Ax0LEKDfg0uiX1eW0u46OxcUicNrTRK
         +hBipN3fguNOfPExZSh+9Ep2nwPeAQvPqUKScYjfxw1XaYKOrVnsiR+g/ddtzlZhGX0B
         945xDYeUG/FdP2SIy39Us37OWY760xKtoLQUF6GsRGdU0Xt35YYSAy+qMU5L47HdIvEC
         r9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710815258; x=1711420058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aSzY2VJWDittzpsS5JFj/mmLGexq9XYEbkvVBzvnJA=;
        b=RGeDQK0cnOzaSTNFycGx2X4ZvvpCD7WJ9FH20VXoHHGyY+POG+syRv+l3/xBoNjaji
         Mdc1Uc1bJkeYnXFnsyR4GLs2O3lbYub+3YXcfW+UZP/4Pmz1ZyAhn8sTHbv0QkZc26/9
         KDNx3xqg6l6kX4WZQwsgz382vRw+fnbES0WzIosGtcy9Pd5ZOPP5Oslt1yM7XFKN+oF2
         WaAb+CVtPLxzCwBln57EASf5roZTLidY1VOdQK14Ml7IDMau0quzPmBE2gmC9dvWAt1h
         2ZCl9aOVn4e7J4opMsaGMOByrQ99r3WD4mHurJTFX+MrFUhr4H3bNLsbTVoP6yBX/jPt
         Gatw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ITMVVXZERM4uN98Ke8PhiK5PybB98hqJ9BrcwMRGc2A63xqnLrKeFosax56f6DHYwbbXxp07m94dCUbFrZSNFMK2qBYNTo9g/Q==
X-Gm-Message-State: AOJu0YzMKZotBNxJ5Z7c/i6kJ+W/sv7pGIaUZPcIhhfgJ92tNNNRTEsT
	bSVs9JpcyWXcfBkRjwt9nkML/wd/uOcjgEILOhXgr/tcjaCtSMNOfdwday0dUlY=
X-Google-Smtp-Source: AGHT+IFn1GD8CcESCvZXxz6GgRez+vUiJL1aI027U4ZrLO0sqXw9+T+YegJmcdj3OkfCqIw1NPTw+w==
X-Received: by 2002:a17:902:ce81:b0:1dd:a8e2:60a4 with SMTP id f1-20020a170902ce8100b001dda8e260a4mr17768006plg.42.1710815257730;
        Mon, 18 Mar 2024 19:27:37 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:a790:ca87:56ba:58b7:a676])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001e02d9c05d8sm2323576plg.103.2024.03.18.19.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 19:27:36 -0700 (PDT)
Date: Mon, 18 Mar 2024 19:27:34 -0700
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
Message-ID: <Zfj4FnG5vAPP55ri@x1>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
 <ZfiKooxO88h1nj35@x1>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfiKooxO88h1nj35@x1>

On Mon, Mar 18, 2024 at 11:40:34AM -0700, Drew Fustini wrote:
> On Thu, Feb 08, 2024 at 09:14:11AM +0530, Sunil V L wrote:
> > This series enables the support for "Collaborative Processor Performance
> > Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> > encoding of CPPC registers as defined in RISC-V FFH spec [2].
> > 
> > CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> > enable this, is available at [2].
> > 
> > [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> > [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> > 
> > The series is based on the LPI support series.
> > Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> > (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)
> 
> Should the https://github.com/vlsunil/qemu/tree/lpi_exp branch also be
> used for this CPPC series too?

I noticed the ventanamicro qemu repo has a dev-upstream branch [1] which
contains 4bb6ba4d0fb9 ("riscv/virt: acpi: Enable CPPC - _CPC and _PSD").
I've built that but I still see 'SBI CPPC extension NOT detected!!' in
the Linux boot log.

I'm using upstream opensbi. It seems that sbi_cppc_probe() fails because
cppc_dev is not set. Nothing in the upstream opensbi repo seems to call
sbi_cppc_set_device(), so I am uncertain how it is possible for it to
work. Is there an opensbi branch I should be using?

Thanks,
Drew

[1] https://github.com/ventanamicro/qemu/tree/dev-upstream

