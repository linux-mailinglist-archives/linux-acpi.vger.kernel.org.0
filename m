Return-Path: <linux-acpi+bounces-4348-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03487C8AB
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 06:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469F1282FC7
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 05:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B312E78;
	Fri, 15 Mar 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ADeBF+Ez"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8959112E67
	for <linux-acpi@vger.kernel.org>; Fri, 15 Mar 2024 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482015; cv=none; b=LGBcwzh4v3k8h7gbutVm46thD4uR0cMZiad1eH7O/ISGynWpMyLcEoSEoIOCQ7aVFL7xnugecgF+pOksh4h8K05sI38rLOhMtHhx2pMhQlE7OjSP90eZqIzNn4AOpbuPa4QUhVcJCzAoctqFA6xM7AsNMCYCNTfaRWD0aAN+9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482015; c=relaxed/simple;
	bh=UDhwVLvrhKZ4zV83WNvEmS1n7Q5RwVHTSzv7hrkimAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iud1DpSDv8r16FkFYPOIEXQcuocqq+n4PyfrzLUD5Lrihi4z6GmpqccptL739bF8s/lPi6SsQJpufLohKAZBXiNhvaIGq8xW8mgDt3cQ7Qqi0avghSVDoGYxh907t1vdBmd3MddiizkYuU+a5Hl6G37gApIqFlJzBga2Vo9ieu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ADeBF+Ez; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dee27acf7aso7986455ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 14 Mar 2024 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710482013; x=1711086813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6143Xt6B1fDIKqVroZrZ1l3ARGTZuJpSXXKGYmPvAls=;
        b=ADeBF+EzvihhgqCzjtlhJAWGFXdOcayNCcFl51JfItK8YNAuKa+3+UN9+I4JPNa6pO
         vYJyTE25aWD7L2oobBVuSaB5gMTeCfBGNyVVc5BqhUR06SkUvF3yE5c683YmWV9Q9cSS
         r3rQT9L0Av74zCK98nSRpqO25sintcjT0nR3oJaPLh/485r/FN8uooyZEhmw02Ly1wcc
         yFOfD+8qHR0W40TIFU8Q2dBKCwfK+P3MDEllkqkA9pScG2jQhObB9Tjty4DE+3xVccEW
         E6aedSjyuRE+GjXhIllxuSFuI7wC1NkmI6Ck94937CBJE/3SwKMjS0QmAYx2JF5dJ9M3
         D35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710482013; x=1711086813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6143Xt6B1fDIKqVroZrZ1l3ARGTZuJpSXXKGYmPvAls=;
        b=DqlbapLUpMJnp6eM238CDDXyKZ2GfZZVH/NaglmRdMF/7963vkOirr5hEcwld/UoC1
         lONZVh8F4f8GhigHPOfhlO+R0KW6ElNIx6Zh3xlJfNcCM58Kr31b38jIkK8YoEAW8nbA
         IMS37oj/6y1VkkXEqliXlg6RtQmLwuAlAlcTy61ROiuG4JYrPtVQwCul9uf1wJufSjXF
         4GsKCZPrgQURLpC0exMRm+CpICZoQzzVPSBVdWXtLDns1mrGfthKU8wvUM12ludvpawN
         LtU7Znq5OR+GEaw5O2SjSPDXNpMIl4DfZbiv/Z5N9aSXxuNcHT2g+dAhcPcvwnW3e06x
         csgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCydAgnFDaDim92ZVEt4C+QTAuRoTnXnrkg4IERjXhhDwyqRY2lwk8FqmGAh0eaZ6nWFpM50nwatkUPz/Gho0xupsHDDKbhwRU4A==
X-Gm-Message-State: AOJu0YwXX/RL6ABTpoAlZNx558yJodTF/SwVdwkqpiowDyxgviZYcOYh
	lHeJSYE+cYxQ6qckTcKkY0HiDFS00hnTnL229sZPgt3Gc5SoHlMr+qlDrSaDR9E=
X-Google-Smtp-Source: AGHT+IFdhVX1m34Rty2PqcdB9AWHBwlmpI+1s+YRgrPY8LLbB4ruxR0YBRVt2iLRDYdvkYdiR1xfvw==
X-Received: by 2002:a17:902:f706:b0:1dd:8df3:1727 with SMTP id h6-20020a170902f70600b001dd8df31727mr2720117plo.44.1710482012859;
        Thu, 14 Mar 2024 22:53:32 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001dcbffec642sm2804203plh.133.2024.03.14.22.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:53:32 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:23:23 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Drew Fustini <drew@pdp7.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 0/3] RISC-V: ACPI: Add LPI support
Message-ID: <ZfPiU5aSw0jML3S1@sunil-laptop>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
 <ZfO5oiVSVSmlP8eL@x1>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfO5oiVSVSmlP8eL@x1>

Hi Drew,

On Thu, Mar 14, 2024 at 07:59:46PM -0700, Drew Fustini wrote:
> On Thu, Jan 18, 2024 at 11:59:27AM +0530, Sunil V L wrote:
> > This series adds support for Low Power Idle (LPI) on ACPI based
> > platforms. 
> > 
> > LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
> > enable this is available at [2].
> 
> I'm interested in trying out this series. Might you be able to provide
> some guidance on how to setup a test environment?
> 
> Are there specific branches of qemu and edk2 that I should use?
> 
1) You need LPI objects in the platform. I have added dummy objects for
testing this for qemu virt machine. Please use below branch.

https://github.com/vlsunil/qemu/tree/lpi_exp

Since interrupt controllers are not merged yet in linux, we need to boot
without any IO devices and use only polling based console and ram disk.
Above qemu branch disables IO devices as well.

2) Enable below config options while building linux kernel.
RISCV_SBI_V01
HVC_RISCV_SBI

3) Use upstream EDK2 (RiscVVirt)

4) Boot:
qemu-system-riscv64 \
 -M virt,pflash0=pflash0,pflash1=pflash1 \
 -m 2G -smp 8 \
 -serial mon:stdio \
 -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
 -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
 -kernel arch/riscv/boot/Image \
 -initrd buildroot/output/images/rootfs.cpio \
 -append "root=/dev/ram ro console=hvc earlycon=sbi"

Feel free to ping me if you have any difficulties.

Thanks!
Sunil

