Return-Path: <linux-acpi+bounces-15190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BEB07401
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D3A1C23794
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9E2F2734;
	Wed, 16 Jul 2025 10:53:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AD2698A2;
	Wed, 16 Jul 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663183; cv=none; b=FrCo8qc91pITba+ddYBVD/f+2g/Xw9BuX5E2a75xOcm6fICB/BXt1JSM3unnjbSEZoTPuLKRMJEyHI0lH8KRDRslUwXpbPJzcPe1b/l0kON4vJBEYutbybJFyj4pd52aq2TpmvakzOMDsysf4/75QHnJxluou3G6lj4mXgM3cYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663183; c=relaxed/simple;
	bh=ZoNaVv9YHnrs8EcPAqGvAwJKFTp7irT62UbuaE4t4aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBqtEWOUlnR09D76lHlbuVjir714+Bfz606KGTEKNRHw4rxsPF2RAWdqtpTViUwd5KyVOxjmttXwty4nKdgcLhFBcjkhpRmF37lxkJGLsx6Fvh/KCas106cSDISmKbTfXgVWNZQCcvrwdDedTREWFVaV4y6OCM32RXIbmrr9KBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so13818147a12.2;
        Wed, 16 Jul 2025 03:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752663180; x=1753267980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xByClDlJj3z/yh8YXIH8vnfoJl/3bxRozyVAfPTTKs=;
        b=gRn4MzNIaudXbqJ+SxZlj7tOj214nGzKypa4FmOOXR1stYRWcrmvErrXADozX6sZDg
         gzUfgRHhqA1a4l5ajyoNlLlNhwJizTgtT8HBLFvtnp2stFjHIfglVUC+rhTaQVaAaKwD
         BXbIhUHzL7vWfFbq5Pjemdu/I9F5PKXnKI58+Gcog/2CyIWWW2DFR7IUBOTFUMZodeZL
         VZaLkM44O13LCzbbc+KnAEZJfQgvhrT613m4rwxCI8SxNiTeBjzN/z+5rD9Yb2XRLDIY
         Yq43inbpuwO3Pkcl4wCfIpxGcgLObrId+FCvHVjai8eCsMC03+peWDPgHD9Bmqukw7O9
         GIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmHHjslNg43eyl8DW+ruO1sIt2Bgk0KtDhUIVoBQRNYw609yCzxXhJgRL5kOXAmLhBUwdRBrrWjMMU@vger.kernel.org, AJvYcCVIvwooQMlDCWFePvmK4/nBktK2sIEg9ZvBYYEmzPO1/n6M3KN7ArfpJHxQNVDZfkeU8AEbWFthREJSJfft@vger.kernel.org
X-Gm-Message-State: AOJu0YyTY/UULxCCOu7fzdqvC3fVMI3X5Q++v2Lh/QNTNPIxP1ewe69W
	ZhTrD0sJz6Ep2BaNRUUXFSsDauoOefOs8hOM/w6I8V6ImwB85BlDsTRV
X-Gm-Gg: ASbGncvVSroDvzsbtT6GjHtM1AVwkxoxBTfzc1o7nLmK5slSVEQY5lQ/+9m0lJbdos8
	SsqyytEErmist9ijaR3akhd/s+tfJaJkaSeFLYTuu1taDLOaCribwWAMRaxtylU3rQJOEUaYPIj
	Y96ricQZ03PHwBv+8SbZ8mqTb1hhsGkoiRXP4597mTBog+JLLS3yctlubgf9BByDVOU0jk0GM7B
	GlsUtTTqjrqdLzJsZv/KBaXqkVOkEInC7HLuUYgmCcDvhuDtZrLqrD2aQ8E9ObS6B5NnSWcIx4+
	N4iQWhbK67hO+wanhzuIXtw1APB/fsbCW/0JP6qCWAlpb4KMKHLMqA8aokiDJdAdl+KlfSadW68
	HcicMwJGWfLg0ra0wZMC1
X-Google-Smtp-Source: AGHT+IHvCqxRPOBq92p3c9UaB6Uu6R6G6nd9mK8Tvn9SBq+wlR8I5P+qH13+TRuRcHrKzlWv7H07qw==
X-Received: by 2002:a05:6402:5206:b0:607:35d8:4cf4 with SMTP id 4fb4d7f45d1cf-6128260bc49mr2197829a12.25.1752663179401;
        Wed, 16 Jul 2025 03:52:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9542fe5sm8416015a12.35.2025.07.16.03.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:52:58 -0700 (PDT)
Date: Wed, 16 Jul 2025 03:52:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev, kernel-team@meta.com, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, osandov@fb.com, leo.yan@arm.com, rmikey@meta.com
Subject: Re: [PATCH v2] arm64: Mark kernel as tainted on SAE and SError panic
Message-ID: <xdvsnmcgfk7kkeq4r43l2c3h4vrlhuy4s6g2nybzsibyna3ipd@tkb7elmgn5m5>
References: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>
 <aHd8uvMegWXHyhvN@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHd8uvMegWXHyhvN@J2N7QTR9R3>

Hello Mark,

On Wed, Jul 16, 2025 at 11:19:38AM +0100, Mark Rutland wrote:
> On Wed, Jul 16, 2025 at 02:42:01AM -0700, Breno Leitao wrote:
> > Set TAINT_MACHINE_CHECK when SError or Synchronous External Abort (SEA)
> > interrupts trigger a panic to flag potential hardware faults. This
> > tainting mechanism aids in debugging and enables correlation of
> > hardware-related crashes in large-scale deployments.
> > 
> > This change aligns with similar patches[1] that mark machine check
> > events when the system crashes due to hardware errors.
> > 
> > Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changes in v2:
> > - Also taint the kernel on Synchronous External Abort panics (Will Deacon)
> > - Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org
> 
> I think something went wrong when respinning this patch, because the v1
> link above is incorrect, and should be:
> 
>   https://lore.kernel.org/linux-arm-kernel/20250710-arm_serror-v1-1-2a3def3740d7@debian.org/
> 
> The Cc header for this posting matches that of the unrelated patch (and
> excludes Will, Catalin, etc), rather than that of the real v1. The
> change-id trailer also doesn't match v1.
> 
> The actual patch and commit message look fine to me, so:

Sorry about it, it was totally my mess with b4 on two different
machines/branches. I've been testing it on a arm64 hosts that
has no email access. When I picked the patch into the machine with
email, I messed up where to cherry pick and branches.
 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> I assume that Will or Catalin will be happy to pick this up. I've added
> those missing folk to this reply, so I don't imagine this should need a
> respin.

Thanks. I will not respin then (unless requested).

Sorry for the mess,
--breno

