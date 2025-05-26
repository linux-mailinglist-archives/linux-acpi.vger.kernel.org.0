Return-Path: <linux-acpi+bounces-13901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C4AC4341
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220497AA601
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D271FAC50;
	Mon, 26 May 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOJlPrxH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4927452;
	Mon, 26 May 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279237; cv=none; b=QD6XPjvH6XpzOCghdIdTaPnCGqEw4yyxKU3wE4gk9jHEcqGDz6/P1Mqd3jAS02B24hWEYMqlHiIdl4k7YTNhI9fD3rg6jNTN4GKjKg3ALIGhYotq20Trh9MHGp3jyhRKMR/sNWtZuawvFFPvhuZrmwsb6XE0k8LWrPITLJ6OX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279237; c=relaxed/simple;
	bh=98dgyG0SdLgZsXTvV7a21d1HejiWcvKUgoADmRpBXp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAV5W+2u4shVVODz390h0lnrB9+56IBVbV8Tefu4z2HOrRUiuPwqZfw3N65sq6uRxucy27/OxF9585gs4v6WxSAjedHedcVJBWNfumVZ/ilhCLKkDBa3gHBVmdh4lzt33ArgEwdTM+wqNLKX4SzsjGoBJ5M72rLD/mSr+crwqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOJlPrxH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so34872285e9.3;
        Mon, 26 May 2025 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748279233; x=1748884033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp82rffgSLQLudTLwPtD3G8nbSZ/sYYwkRlIx3tYV/M=;
        b=ZOJlPrxH8iJCKy2K1FCrMnm1DKZYw0560DZXU1w31Oth1Gw0fpZrkqRiYpC/hh+v/U
         1lKaPC6Pg9O2y+dHyl2RKb4J+DvtBas9PeqgWlh4vqD7kQxCrT7JsdryXowmWquOrZdx
         +PTR+pszRcb9iAbAenNh3o+aS3LW0UVv9rHOz3fOWmX8FSezhGdMqIc5Fdnv28ZFg6rj
         c9oVcla1d2cix0tT76A8MurIAAhosgSjqHdyCtqjrbG0p8XowJlkuOC87wMMtsJx/Bm7
         Y1E5Yb/AHezAZOOjrY22nZdF3LuERm9/NBbrf2hIYar4bULEUmQouVyDqIQZlR7uPqZY
         Gz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748279233; x=1748884033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zp82rffgSLQLudTLwPtD3G8nbSZ/sYYwkRlIx3tYV/M=;
        b=BooD4cn4AG+zhu8alTbel4BePk/ZhuXjjrJ9JR/uORuH4QhGoQ4bhAzPqFVcCRivTP
         o1O8emEm5gjm2vu/zKWa2S97Ua0m27c0WJzE/o+BEdEYDWIMqOXYIFTphMRcNLM6hVN4
         ryCeB9/JV7zMUSFZwqbvz13ytL7hddHSIkVVUg2s0kqzsKV2PC0tRNk60xfOd6XVTKEv
         HJ6zDbKR+kQ07UFpuB6yJerMuYAzOBNozOVdzkNzUyLHsRuwZEbSEDe6EULmSZitvykH
         bsExANYdrZpfmtfjragkI0me0CLtb6EpJxi3zdU7dq1JnvV3PsYhk5eCOHaChdd+/xnj
         B1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVR/NmV5OYC32cuIi/Zx1l+fJT5m5FfoKaFtSuLn36wD/reVBHfmQBX3RKMt/2WipvbIazybWhacjYI@vger.kernel.org, AJvYcCXXWLLTPEh35vRbTEaN6LQrqGH3dQciY31m2QkH/VhnxLH5jxV6gts9PmaxGt/9Z/ymApUs/qDOb2kNa/uh@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9t07CGHHyjs2/pte7VP51bHIDUf8Kwm0sGKJEXKWUo/5Mh1J
	CEgBZJkFggqHstaYK9OxF91bRRNiXlvzFxZilVaGbsVmXdVLPfRXDlBn
X-Gm-Gg: ASbGncuNs+34Kzctxbgq9eNtUskcHGQDcTipP9rDenoHJ50YXIgrWsZiWsypykg5kND
	prHnq+RBBP3ADKF2E2tJTfPq2fOIJ6QcWqe8k7foN6P1W+J+8c79MiSO1Bzc0nrCDDvrHmPugZf
	hYBbFWBHgWyI6cvv4ugj51MOxSMfq5+NKNWTtjl5n41EJU5w7EVbbmI/0kUFHr5cDU+CCg1Ysr1
	O23zWlGzGcoOuAGL3+ilpKqea4nMUIueMwJT04Bm/bJTbZXLYSsIjIO+4dZYSUTxENPE4jvuP42
	axSfyJZ/DqQiua738HCjHrrkQ9jnY2ktTDy2C57A7hjxtMhGXBd/Gtybj38kAnImUA==
X-Google-Smtp-Source: AGHT+IG3RszOFiLp5Az9KY6+PLwlwp1+jXG7fHgcsglQoGNMlgyMg2L+9tvpUwNjXGYGKLXwpHr6+g==
X-Received: by 2002:a05:600c:1791:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-44d5c54c826mr44373265e9.23.1748279233356;
        Mon, 26 May 2025 10:07:13 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4b68sm246184205e9.23.2025.05.26.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 10:07:13 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: peterz@infradead.org
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	khaliidcaliy@gmail.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	rafael@kernel.org,
	tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH] x86/ACPI: invalidate all cache lines on ACPI C-state transitions
Date: Mon, 26 May 2025 17:04:52 +0000
Message-ID: <20250526170616.1144-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526160753.GS39944@noisy.programming.kicks-ass.net>
References: <20250526160753.GS39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > This is absolutely insane. This day and age, nobody should use WBINVD
> > > ever. We've managed to not do this for decades, and I'm thinking that
> > > either the SPEC is 'mistaken' or otherwise out of line with reality.
> 
> > > If you hate performance, and you want to break things like CAT, feel
> > > free to put this in your own kernel.
> > Sorry, i made a mistake, i meant ACPI 6.4 and 6.5. I already resent this patch
> > please check the resended one.
> Doesn't matter. We're categorically not going to be doing this. Rafael,
> who do we kick to get the ACPI SPEC fixed?

First of all, am i talking to some kinda roasting robot?
Please talk professionally, fix the way you talk before you fix a code (of course if i am talking to human being).
I am here waiting for a real answer, so please just tell me i don't know how hard is to say yes or no. 
And tell me the reason.

BTW, if your english isn't perfect, i get that and i am sorry for what i said.

