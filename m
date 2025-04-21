Return-Path: <linux-acpi+bounces-13133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A955BA954ED
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DF418843C3
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827841E0DCB;
	Mon, 21 Apr 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CnMonYfl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047213D53B
	for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254225; cv=none; b=SSuTqZWY+u/6DnvDGjaMj/Co4Y1gGP0B2V0j2iZtyUUmf3CPo25inqCTN8vPdeaiPEK742oK2jB5CZ7Yrcjp5dYyfTdEPgMoz/d1GI+TTGVInuJMbgX37PBKdBKivwhlR99YffrpTknA2BxyKa396r0NrTrsMbD5IwzhqCY7eYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254225; c=relaxed/simple;
	bh=75jmGP9bVo8fjvixWVxCAKwFwqHftpu3jiKMLJI5AIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adW5ub9Cg0OE1dS9V4fw3wqdcmC8yL2rbHGm1uyqxfthn1ZUDnxWrGWlAi+TzrYKX8nk7JAMQYCJNPOfhFgD3wu5Xa9HPYcUuWMV1/n8cPXuTEr7SYh+QGxowisQUFEZu4sMsRYI3SMYiwNcFZsu8ZhERPFYUYa3FsbF3Gk/zrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CnMonYfl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso641272266b.1
        for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2025 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745254220; x=1745859020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AjR2RVxOW6ZgZFj+OsQW+gCNX95bGPWFoitBsuyvSlg=;
        b=CnMonYflQnOvPvlIBHfb6wub3w0Ou6/QwcKZkxzvEmLP6m8tsYkMziuQjKcE12cGJR
         bDGhZlKFDeiGoQPkJWNC1eW5v3J+Jr5MogW5a0k64q1qfa083WNXa0mTzgP3QmNWAnh7
         824A+4DI+u+Ft8LKq0Xo3upiVEI7rZdFVYdAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745254220; x=1745859020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjR2RVxOW6ZgZFj+OsQW+gCNX95bGPWFoitBsuyvSlg=;
        b=Qe2WI7v91f0UoIS4p7rAA5IgrECKyOm4yXwEOwzo2SsC0UGP9cjjycVKHCnhZExoMm
         NV6reibCZdl/eMNuVWFlIuFqOiDuBYyjiGm/1EHmoV+dYOY2qKYSNaxM5r4Fwpmw1E7J
         HLZaj5iNcvRoD+uo+vyBpmOXqlAIY5V3d6N63RClJcX7gJvjEZoFHn8gUZQDaCFsZF/4
         N0/YiwsLTJvXST+ck+JoCbp0SZR2exmA1w19klcN2SwOeDoWxKnObZKyOPeldDEdOa8Q
         bjtxXg/gaeX2pr0sBM0PcFZ15uaa0pOLqjGVKx71qm9J2SGulPMylE6x24MQsUn3nTi1
         GoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXadaEMZXv9xXUef5HVzxZidCLpZytmgPRgyxP4lw68HsWuoD24AL86uRIBVgqyceYRrWOGaMkqlx9l@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgEURmVwcQ0GS7o24cl7DwMwlv1wULmrW300fXSZVAHk6lQ9g
	gv2vbJ0HOQ/CJo53+A1UAYa8/8ath9pwnytVWs/dPizk5zdIn131jlgB2whol/dG99q2XyIUmAm
	YUxA=
X-Gm-Gg: ASbGncuKzKgtld72swli/rlZKfL8gWXtzHODX0ghCsngXQBjtecyxqpbVbMb2ZU4awI
	c/wvhDl3BC6GNu40fix6aAftREhcIjs0tWa3GWnIALILMEgTy91p0I5hkI5QgcMJZThNsNkHYjn
	m2LqbZJbThwXcjnUMENYIVqsWVGcO6bAFht6CL9JKAOd5nPgAKfyNECRIHEnrr+CS9/dLHo+M0O
	MnKRYBoerC36J4tQOVYH02ilqsgdNhzYSo2Xyb/flOY2AEvXjDVqobbj/iTrb92t7YK+RZ5rK8J
	NeT5V4Y3zyewXzL9Wu8AWDPoJXS8mSucp6DUWftsq3qANGaDcG1IGi7iAFL7hJ0VZxAG6mfEoUx
	q2frQ1oR3PUIlBiI=
X-Google-Smtp-Source: AGHT+IEMHrclfYOwwb6bV4msxQK0aLDtTxC+gZHeCwa13YRhwjetsGmUAmLAdDF2C3XkXKTKgjW9MA==
X-Received: by 2002:a17:907:3d88:b0:ac3:3cff:268 with SMTP id a640c23a62f3a-acb74ba6265mr1094147766b.30.1745254220306;
        Mon, 21 Apr 2025 09:50:20 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec42af6sm527613666b.43.2025.04.21.09.50.19
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 09:50:19 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso6944691a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2025 09:50:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYuWaU/EadfCxRYB+L3UyybTyPWkmZ1yLEIv9Aap2bMo+Q6AvI3CCLVJkd9rIvBprgG4jNs//T1/aD@vger.kernel.org
X-Received: by 2002:a17:907:9488:b0:ac2:baab:681c with SMTP id
 a640c23a62f3a-acb74b7faedmr1249730566b.28.1745254219430; Mon, 21 Apr 2025
 09:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net>
 <202504201840.3C1F04B09@keescook> <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
 <202504210909.D4EAB689@keescook>
In-Reply-To: <202504210909.D4EAB689@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Apr 2025 09:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjZ-id_1m7cgp4aC+N6yZj3s5Jy=mf2oiEADJ3Tp8sxw@mail.gmail.com>
X-Gm-Features: ATxdqUE3yRy15GcXJDAlg5Pr-Yx6SJeDj43KQDBRp_RmQ2nTvhE5ZYLb4m2ELZQ
Message-ID: <CAHk-=whjZ-id_1m7cgp4aC+N6yZj3s5Jy=mf2oiEADJ3Tp8sxw@mail.gmail.com>
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles around
To: Kees Cook <kees@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 09:39, Kees Cook <kees@kernel.org> wrote:
>
> Yes, I understand that, but you didn't coordinate with anyone.

I upgraded my machine overnight and released rc3 on Sunday.

And honestly, at that point I did not *CARE* about coordinating. I had
expected things to work, since I knew people had been working on it,
and since F42 had already been released.

The fact that you then complain about a "unreleased compiler version"
is ludicrous.

If you had fixes for it, and they hadn't made it to me, that is 100% on *you*.

My problem was that my kernel didn't build, and that is what I needed
to fix. It was way too late to worry about "coordinating" things at
that point.

               Linus

