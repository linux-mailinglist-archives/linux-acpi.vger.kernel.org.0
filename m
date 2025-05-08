Return-Path: <linux-acpi+bounces-13628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77BAAF12C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 04:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81C81B65236
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 02:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2451C84C0;
	Thu,  8 May 2025 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LGLIuHXj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E81F94A
	for <linux-acpi@vger.kernel.org>; Thu,  8 May 2025 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746671688; cv=none; b=anlgzawN8c95H/d5HJgo0dlLgzB4i9HwpJ8uIs4N/a0f4llw/0Bh/0OZjIrTglPLlo1vF7dToAc5aC28Ch+Dx2Lyr9YZuwhch1MsfTTmoTmtztH09aG0Srm6iHMTw1PKx9O5q7uNHCdOOTLl71X7QtaT+BUS+M7TB5+vIBC1qkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746671688; c=relaxed/simple;
	bh=poW1GtYQTWebjyndrMzwPhXuMiIQ55QD2XUuSIcx8qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMnIeKvjjgMGq7oePmNKkeKSQ/oWr1JH/gg9vYD7Bv660Mqyv6NLDDHHzwkOV0MxoCzWX/hYQmUNeCX2ImSxZn4KCkGtJn4NG52Hg6XL4d1DVb5PDy4+uRDIHRhYXZTGGQeBCKC5bm8I0uEtmirp8oDCYLVQcKDYU803knGxbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LGLIuHXj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c336fcdaaso6062625ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746671686; x=1747276486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poW1GtYQTWebjyndrMzwPhXuMiIQ55QD2XUuSIcx8qs=;
        b=LGLIuHXj9t7s/mV+WJ8pK7UUPVDvgSKgD1Dq+AOwa2/UTX6WRbMqdu3wwgHusMBaQO
         B6gugJMWTyA1UaCWp1OKUBk+EUW3uMMbE6qE1JD4bzgrcEfCBGpsnNsmjRUstz9Ggimm
         m3+q/fqbFIulEJyJ2Oi2L8crfTao50dDYU7ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746671686; x=1747276486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poW1GtYQTWebjyndrMzwPhXuMiIQ55QD2XUuSIcx8qs=;
        b=BEk/rBIoBS1BYkguhW2bHGz/+dWoTwbi/Xa6SoRjwvk//y6grECRNx6CGMVmwMMMqf
         1twfviSZOybAwJuzQthIJH6iRIpCHuq794Fd+1yRV1CZtItLhENer6l5HxojHFVvY0Ww
         ZDu/bb7Dx8+EmP9MfjqsCo2Iimay95+xnKJep9w/BNW6JUp1/ENXvBj5/PUZsIQDxkaa
         HVamuqtgtVAGEvtxaLVz5m3W9t9K/LXkMDYuBw0a1VBN7BuoL1CE16+NXh3/4S5zD7v4
         VZ3QqOPZ2Dphpg2CozDFUEeDlvdtCZWWnk51lqXF/ggdwBO3yAMSDPtgP+ljvtwH406l
         8hjw==
X-Forwarded-Encrypted: i=1; AJvYcCU8YVQGajfAPlzNmGJW1sRNuMDcRvTafNm0ONtdMOZg04ZRFHnGc9vri9obsijgHX0kZuxTKeRl91Hj@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgGxsZ7MY9BxHNLnptsuOhAfXDU6m53OT6HXMjbXzt2nSURLV
	o2MhAjS0JP9ezMt0M6XK2gWj8BGbqbaKoV3NDg5WJ8xzBdqEN/Or2yDAyrWA3+tuexJtV42asOh
	oBTn0
X-Gm-Gg: ASbGnctNiqYq0ElCE8kq0XBrEgEh0qEBUGab/8sggYVeSfTZlvNVilPcfX8l/sJeiXA
	YVUMO8+BkE6ug5OjkrWm5E14/tjaeRFfl+YkazSlRCY2m+kkKZ8itjLbYnIf9UguWjbabOAymM1
	tZZjMu/NrwLPh0q1+J2AaREE8tCVAYDmLVx8i1y2p3sAf/+fGsc9HNB73ckFM7vTxBFfVc3Dxqa
	8/X5J24jixvVPw6sz2bjnQFpD/dD/KuY6MK4qmMjEWLOQFMmTHMGEmrXSJaDXD84HUBST5ORlVE
	1mKD7ZJg4fLuz2uWP8uiswGFPgq/0VyprGx/0VXDsg2cRXvZY26c9jaHDLiQkUL04ctXbx/QnFC
	EbPRSr3wI9A==
X-Google-Smtp-Source: AGHT+IE1aO0XL2NbG8uirvnH+KzloHX0YqIVkzPyrVG+wc6CUN5JwXb5tMZSqkBVwaDmKU2EvaIAaA==
X-Received: by 2002:a17:902:ec8e:b0:224:a74:28cd with SMTP id d9443c01a7336-22e863c411fmr24903805ad.31.1746671686337;
        Wed, 07 May 2025 19:34:46 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad483ff6bsm1023253a91.5.2025.05.07.19.34.45
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 19:34:46 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22e39fbad5fso67105ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 19:34:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXX0nTmwnW4MceoYKLaFvgCOvFXYmHcsoJznD9enfh1orqNG5P0UlDLz5RNjUahA8n9Gm3vKtMgFytc@vger.kernel.org
X-Received: by 2002:a17:902:cf0c:b0:22e:4cae:5964 with SMTP id
 d9443c01a7336-22fa14be1c1mr734815ad.23.1746671685314; Wed, 07 May 2025
 19:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507042954.43674-1-pmarheine@chromium.org> <CAJZ5v0i0y0+a5O5skm79AONjkCi9zgD7yewHAs-WrCXT=Z8vCg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i0y0+a5O5skm79AONjkCi9zgD7yewHAs-WrCXT=Z8vCg@mail.gmail.com>
From: Peter Marheine <pmarheine@chromium.org>
Date: Thu, 8 May 2025 12:34:33 +1000
X-Gmail-Original-Message-ID: <CAG_X_pA0vW6ZWcT2K5R4DnOmz3R-Kz4vpiSC9oyAwKrATXMkZA@mail.gmail.com>
X-Gm-Features: ATxdqUEsQwfXMF51urSYQQre5riflrKEnno-e3L9ucNowITNm_Nod5EcWiMxs9M
Message-ID: <CAG_X_pA0vW6ZWcT2K5R4DnOmz3R-Kz4vpiSC9oyAwKrATXMkZA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: negate current when discharging
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Marheine <pmarheine@chromium.org>, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What about this instead (modulo GMail-induced whitespace breakage):

Yeah, that LGTM and seems to better maintain the relationship between the
power and current props. v2 patch to follow.

