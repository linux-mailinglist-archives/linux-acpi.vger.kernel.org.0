Return-Path: <linux-acpi+bounces-5587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E78B9833
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2024 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E0B1C20D0F
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC55676F;
	Thu,  2 May 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R5TBtt59"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DED5674B
	for <linux-acpi@vger.kernel.org>; Thu,  2 May 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643801; cv=none; b=MXryTJzCBATPybT1qW9ho/zrTxNdJIANBZT+EhxWh2mk5qWMH+VlbeU2Ei2uMaLLvARYRl9vSFAvSIhRP8eVGw5eL8Go/Rxsm1Tj7gtUFw/iQIEOM93lknmD1YPlQBP1C1PBX5yThy8oyywmTCiU0UdjHnUfEiY51K4Sq7LHii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643801; c=relaxed/simple;
	bh=3l3zV1CvMpPQ6M3agjT4bErcSYjrF9CaWcpEI3wJ9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCnT6sXfmNbseH34qupx1/olSMDB9eQJUtxfgPbDxm5OzlomozXuRwCxeLEFmqHqFeEHQ/blo4QcM1JqN59kzkICIzZklFxk81jqnROqcy+BaRDs81V9xJHSIw+ZPSXAmImI7rYBnmyz61vYwlCN8qeA7CTtMKDXsuxfEPmdFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=R5TBtt59; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so4384826a12.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 May 2024 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714643800; x=1715248600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=R5TBtt59vRw7pDNWPRdtnfrGzClC8OtQpN13oIl6mLbBGMWFqAhCgjMJ77PVbuTvdK
         w76Sq5hiI2T6WsreDf4rWfkHBD5ekHGzRUAuuKldv+z9sSBPcUWUkS6lxI3E11+Kz5gx
         8TPx0FK8znm3jozKmGlvT3OEr40HlR1WZ6nC9NafGgEwr4qvWEQs+Q56/Zi7X7HW4Xp/
         cEhnVJ4XtgJSpYnDJ3aIieLt6bYy+QAlpkvO5opoA/0pS+FqUOJ9XvXpsS898BH0yRsx
         Y3+GCMzFw2feSDRYNRSL6Daa8xbWWBIVz43B3hZs6+vvvWnlLjNFsfP7TGH5Pg/k3+qa
         oWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643800; x=1715248600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=hBtKyOO0mTh2hA90qhHO/XQI0xPYLn89Z/wqxgDFU5AUKLgzGIFwkORi4SB3jMgdBa
         3/YBBctPPHb74o0PQYJiOcAE/vNFkGF7jbX0aaUjgm3Qqb9ICc2KAxZTL+iDI6Bvp+US
         Kj3eedcK9JhxQMUUg8oxGyn697Jhl0ITbKW/9WtgYPWWvYszMQ9ioG3yByDJWJo/7XAN
         RBwvN4comgbHM8xopaUPES+m7rr048HVAFE/NvsjPkrSYcEjFMPO8Kx1szfFNmOOhB71
         PCzZiCD5OB/T9xxBAhN9rbpGwdAMyOWupxsiJPnM2VOD1LP7FPfysO4YRy7Ios5Et+Zw
         +dfA==
X-Forwarded-Encrypted: i=1; AJvYcCX/n33a496MEfManX4N5U/uZABqmeuIBJTZb27Ii09DhrjpiO24EUEedjSlVSNtFqqnKZONJcBc3EikA28/rd/oy7Tk+l5S8wnorA==
X-Gm-Message-State: AOJu0YzoQPnjRaSU2CCMgbJa0wL7lAlrpL3/BUq/sbu4MoFoQej9Ns4g
	oL1/ldswIE5h4dN+eWka6i+c769W/IVK1+QlrKnzzZkTa3AFaVkB9SvHNCPxwq4=
X-Google-Smtp-Source: AGHT+IEdqN4j0tZUjqkf7AiQCf6AILBV0FVoUPT7pSiU8sVSt1YtTCq7aHm3fUhXEYUOJZhfGVfIwA==
X-Received: by 2002:a05:6a20:7f86:b0:1a7:5402:8a92 with SMTP id d6-20020a056a207f8600b001a754028a92mr1702915pzj.31.1714643799826;
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id lf12-20020a170902fb4c00b001eb53dcf458sm864846plb.188.2024.05.02.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Date: Thu, 2 May 2024 15:26:26 +0530
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
Subject: Re: [PATCH v5 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <ZjNjSpJus7EYT6zn@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-2-sunilvl@ventanamicro.com>
 <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:22:28PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:26PM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, move these functions
> > to common location.
> 
> ...
> 
> There are -M -C parameters to git format-patch. Use them in the next version of
> the series. (Note, you may add percentage numbers to each of those parameters
> to get prettier result.)
> 
Yeah, I tried different combination of percentage after you told me last
time. I just didn't see any difference in the patch generated. Let me
try again while sending next version. Thanks!


