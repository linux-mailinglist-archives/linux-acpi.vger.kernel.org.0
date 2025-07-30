Return-Path: <linux-acpi+bounces-15417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F04B15829
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 06:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8461C7A13FB
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 04:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169049625;
	Wed, 30 Jul 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K3KsrKTf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4B101E6
	for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2025 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753850933; cv=none; b=QaJ6mCbimjztulKIJ1iI6dsmJPtHud0rTWs2YaSuxg7OtTcXrN1djZv35fOahMh0Bh4KFh2AIhEn+URxEJAJ/Tp1Q1Hbe6yOKeUiuOhkaQ0+IeQEPQliEZZwFNoPtYRqzXUHDwr+q1+RDMQn2W2l+RvPB/+oI2CaIlxvZ+HBsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753850933; c=relaxed/simple;
	bh=qs9mK1h01cJwpcAJVuJpTtrdkdGZS+I5iU8Wh59JrWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIzNMTjs1HV73eG6UF6bn7PfubCOteyvt/od89k2Q5hGKbzQnJcnKVATdkk3T7B49sKn/skfrnnQ6rec0VCqTjO6sXNa/wrLPInbLRmk0I0KAOF0QM1ruPe8DPFBQ5iTkKutsWYEU4ASw5AbN4QdhR41Wj0YnyrnD1FG63VGMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K3KsrKTf; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-87c28e9e7ddso54148539f.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753850931; x=1754455731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPl1wFVqasFlsqib0+/3K33ZAFpU1sORgwmap3qJ55s=;
        b=K3KsrKTf5W/UZbw2UBF9Iw66+RmR24sL4fGKkc1D3w/RWIaZ/Hpk45fF87rVkFihDs
         KtzTitODXUanOKLdViZJaZbJsMpqelkkkypLSzRZ4rJkHZ2dGQMxsYOEf4xeYyqwJl8h
         tgRfnZW05IhAC+S4yWS0Gz0Rux3sou79FFOQghLDorZididkBXR26XfuEWouPE4KhORT
         DaCGELmRmE36URktESpzOBeW52uQdWJTPaoNBTwYEV9D1KCDL3EAf7Hw5QoP2uuElRrQ
         EMajfo43z8hnrTQ15MkZmCvv2w4NHa15iMQAyaZ8tYEMJ822iBUCKKkxCeIkXnovaS6l
         kUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753850931; x=1754455731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPl1wFVqasFlsqib0+/3K33ZAFpU1sORgwmap3qJ55s=;
        b=edNlYWrxgkczHnKNRVKFgW12y9OIBjOTQXMpr6I6Fj865hTHNqEktIccJ+r8RtbGdh
         vE549Jk13gi7t5yHstRH2/rEJYVgKU9W846B1mcaf7qgcRPP1IZyTdpzxLb8coKVG5S3
         SQ0yzdKVViBNr/jCDaTen6u9NjYL5WT7wfTWIqZ+7mt9Kinx6lkL7/9G1UuJgnq/ozza
         FfM9J2nLL6S4Q5pCnjlcezmyNochyfL99gldFwVEBwDYIQRZNstyOvRG2eP5w0HYtIDB
         TI8lfg6bxVSH3bv8Xyb+wnGwy7qs2UdS+qYIBmskbhiOhHSikecG+aPf2aGlWr+dj3Jb
         ADBA==
X-Forwarded-Encrypted: i=1; AJvYcCV0FCbFKrQqLujhyD5qcvXtMyd7zqtrVOIHlV9BG6aHDzI4ujojMPdTA7G6aWP2+DjUpHegCcDh13MY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0qeSZHGk5qRntRfBTd3Mv+22donyVXJnp8uEa152AOtbqg1+
	U4qsAskA5LVyJGdDe0NpHXbHChIl1SBB7htGO0ZkXmcSSHuRv7Rp+NBrynSzFJZ/G7g=
X-Gm-Gg: ASbGncuY0vxLQYjn/p7bjWQ10M266JZLvv5lI73QDQvAqsFAhAZAll5Aknhd8lPqrtv
	JOtuf1jWFJ8AyQUsplYVvxhetVvPgOcu37w0PrBqSczZ5Oc/Qod0AAAdpm3tJt2s6/p/utFBR3o
	djMNkd7kZMnNQnU60UWg72c1x7OayleHREwA3M2u2UmHy7nvpDx6Yp0CnLMRQI53B3LusxUrB3f
	Wo0d7Q9pjxlMQEQmLJEsOK4Z3DCkqhZDA59F42FCYHDKOTLPfCHJ33ulRnKBLhixXmd06WihXRR
	0+o1BeyB7XktfbNPZtvPqNwz+hncDXbzrLwy35DBRgvGDykTSInK12cY61adXcn0tZy5z0qhwnj
	lsR/hzfn0ZXEbmliP3oX1lHsO3nvwNg==
X-Google-Smtp-Source: AGHT+IEsXPHu9g+BneDfRP9LOcvRJRqJp98NpR+/ErEyM7y7imVQRsQERm1/6PmyACRIulSbKbv+yQ==
X-Received: by 2002:a05:6602:340e:b0:880:f66f:b896 with SMTP id ca18e2360f4ac-88137c61a84mr417789039f.11.1753850931495;
        Tue, 29 Jul 2025 21:48:51 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.219])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f79b3631sm281156439f.14.2025.07.29.21.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 21:48:50 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:18:41 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-riscv@lists.infradead.org, kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/2] ACPI: support BGRT table on RISC-V
Message-ID: <aImkKUw4OVyiLlXe@sunil-laptop>
References: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>

On Tue, Jul 29, 2025 at 03:15:33PM +0200, Heinrich Schuchardt wrote:
> The BGRT table is used to display a vendor logo in the boot process.
> There is no good reason why RISC-V should not support it.
> 
> Remove the architecture constraint.
> 
Thanks!

For the series:
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

