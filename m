Return-Path: <linux-acpi+bounces-4357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6587EFDF
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213421F2307B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58338DD3;
	Mon, 18 Mar 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="lAbX+Bkb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39F219F6
	for <linux-acpi@vger.kernel.org>; Mon, 18 Mar 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787240; cv=none; b=OWXTuhwxmf3YQ5HGAmFc0t49aZf7hiKU1zpu2H+mMsc+aT/S09i2vLh+8LaRdnWxayffO2Bo4iY2LTNVaF67G4WpBr+06JrotL8fg8u3c3N+e6VmN80IeZ0a57liHeL9QxSCasoww5DZt+66xSleBW9IVQwrJvCVWx7mpI5fL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787240; c=relaxed/simple;
	bh=GA4Jp0MiIXNyFhTaq6Llqwf9LKvDBtkeMPnxmBySnEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDKhVblrl+wxB2MNvovxxffsNMJ+P9Kdz3QCejOU6NeFT7WU2mJZlSLpMgGhVyKwuV54hXHfWlnns0LfTl8W09QNTTH9Xpz1radSu6Mjb1iWV3JlG1POX/igiLnuXKuoAjuswpe36vSSmFtsBgNgSrrKYYna2SzAasA95mVJVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=lAbX+Bkb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dee27acf7aso29779985ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 18 Mar 2024 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1710787237; x=1711392037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPJT1cBm0JZhHbRAeyC7k94UmgVH4lXjFoSAOzz9Bn0=;
        b=lAbX+Bkbfmp9vNzuEaIsDbiK7mJBMmS32FnyBSb8g8ixAYDFKRaGJSPnNy69eoWdnd
         I3/h10gkBIswcXO0YquG/Sl8/sROqqbeFamX7uzTZ4qXo5gSeNGUlGtArGJVwmiv8e7s
         +6OoD5JCgcMOFptkBis6qwnyLEvDYVMuASVXYoAZRk2FscWGzrTkJq47yLZt4QCjJJCV
         Vv3bK1qNZWMUWfG9pVekf89BnHJxj7ICoAa/QDfsT0hD/lTJIp0ch3bkDxNoih3jO9pj
         EZlKSFX/frsVFW2OBe6Ymb4jfIf7fNoSJV1SizIo8vwPq1f6LL07EDuZvtctuud8Hmn9
         QACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787237; x=1711392037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPJT1cBm0JZhHbRAeyC7k94UmgVH4lXjFoSAOzz9Bn0=;
        b=FcH5AEe5TE2Ohed/OaAN9N1Ng7RQdHDzXfG1PWYwP9lw6j4Re7zs75CNO9FFSuk3Sb
         FZO4lOXoaqFlH3qjhRBrcpQHv4oZ442/9UA3cfxpmqUU2m0T9EhHMLHtNctzLWFnbTpE
         BJS0kDI1/yJjHnyLNeqAsb2x81j5jjdQ/bUVNtJSG7uYTFNdNvxsgxZkTuBbc+EzxlB+
         ZYw7Uh1JuGcOvLS3zfEDhQzVKkaZGCspSYwn7aPw8RHTchTKPtg7X86zvyt8SULJES9l
         vH9yO4MgDapa6rjRNh+iaT44xnyes32PdUcX4pC6mhkC/T1cSqVzR3HZHSxiPYxMunmf
         buNA==
X-Forwarded-Encrypted: i=1; AJvYcCX87DD8dzG8+qF67z2lNouDt40Nw43uLVWygASu79jxUJt1tVMfxJjKDZsBLk71QP2O8dEH3ttJ7YFb+qi2E1JYgVLiMdQLM2xB0Q==
X-Gm-Message-State: AOJu0Yy4Hr2xLm6oxss36wJJTolPdPpcbGsHeE5RrU2+bc7x+kCeciHw
	ZmTWHM5KOye/CL8ZAuZW019+R15T9HvHr67fVfG413gpTX+jq/fEP+TXAh7+khs=
X-Google-Smtp-Source: AGHT+IERZprP8bJw5Kg2m3rUqK4BSa2GGG3UrN27m7sqm1+N3azIFVcxsfEMVD/M+9yg6cN0tL/g/g==
X-Received: by 2002:a17:902:e744:b0:1e0:ae6:3a6 with SMTP id p4-20020a170902e74400b001e00ae603a6mr8131789plf.20.1710787237315;
        Mon, 18 Mar 2024 11:40:37 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:a790:ca87:56ba:58b7:a676])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170903288c00b001dd3bc79142sm9609313plb.264.2024.03.18.11.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:40:36 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:40:34 -0700
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
Message-ID: <ZfiKooxO88h1nj35@x1>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208034414.22579-1-sunilvl@ventanamicro.com>

On Thu, Feb 08, 2024 at 09:14:11AM +0530, Sunil V L wrote:
> This series enables the support for "Collaborative Processor Performance
> Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> encoding of CPPC registers as defined in RISC-V FFH spec [2].
> 
> CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this, is available at [2].
> 
> [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> 
> The series is based on the LPI support series.
> Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)

Should the https://github.com/vlsunil/qemu/tree/lpi_exp branch also be
used for this CPPC series too?

Thanks,
Drew

