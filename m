Return-Path: <linux-acpi+bounces-13327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DAA9E2AD
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2A35A35C8
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F26324E008;
	Sun, 27 Apr 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfsZeIhp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3B10E0;
	Sun, 27 Apr 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745753047; cv=none; b=KauuP8fiDtTKU79xLtg5NhYsf9L0I3NlpKe1p/TIopcDJr9vu6mv/ElMqNC1FoWlk+HBtjGSa77bEACHxuyu+jfNddWz4bKRMK6eXdebWE/eq1Lwec9b93TuSpGJu9fkYkjfe/twHyLpHEpD2Dh2856ZZhd+4JlGBWcb9Xky250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745753047; c=relaxed/simple;
	bh=K5NgWw5pu+JTeuRT/s5Guk8+KrTWalNfn9lv7uBpLKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMrEQl1za+JQe1D3Tpt+q45/WhYUHbSQH8X37KJDPioTMeDgfAEugcHTlkwkwT6wQwNbOdm0sTDzJSoSX1rNE+Px6fpIjnOK5YKuPh4mFNQxrzcy99qRN0IjGABzTobLXGwMRW0DLkSMTvaf8r1Co/4E+cLtdjSX/1oNH8+LSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfsZeIhp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so25044245e9.1;
        Sun, 27 Apr 2025 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745753044; x=1746357844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GmhtR5XyoizgspWHGu3E6zXm514utYLd+OlCOs/2I8=;
        b=cfsZeIhpjvD5UCTi9FFMCetqrh1OiCkMDssHApv7Y9jJAEqGYT2FsfF/lQx2+2E5US
         ILFtgGc7bzqcn4JaOQSa7NnJQg25kJoD/35NXcWKSEhLusO04vUTjAkt5qMIV+HXBQB+
         3iJ6TTY9H+iUnOuYRdrO1P0c1qGge27Xe4Ay3d5Y1SlgpZibNDl+rx7amLQoEfPu3NtF
         bWzkny0NqXWz/urZB/aGRLAvOIS2ZkZjfn09/N6o8rDfRU7vb2BqL7OjIAbLwkvpYx6y
         iuD7gJW36jzD74y8NxPhAFDn6u4Sq35sla7GIWxZrGzCuEpVZ1YypQ+YuHdVnkcgVnaF
         ZJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745753044; x=1746357844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GmhtR5XyoizgspWHGu3E6zXm514utYLd+OlCOs/2I8=;
        b=m6HsSczbESlx2UASH6DwzU57dcOgvGzTQj5pyF2kyeFmykkZ1XjgCvwypHI8wtQ+d7
         V11CULUahjb9MVg5Ni9U4q0QI652qJiNvN0bu+AveBEHm1EOJWbiCCzs7npqf2LFzPPn
         E/HNmGg9Vf5Fy4UI73w1JPqUQ4FFGMEpve9FFG4epwMPuiF6/jATX1CClOv6/Tn/Acxy
         W/tWAd9R5oe35KDEwj0a/vl7m8AnOzVdIT5CDb8P782AtGiZQaJ2dhfnzuagOMlM8Nbv
         ClKyn8Ts3vUI5DQ6i8GYflEPbeD87Bu+gUFba/MdQiz4puY45jTZtLQvs7ByIWsxLduB
         n0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUPYFIek7DFParSMwZgtMNgPCFemY8vGZ9kCe/Xw1xPOn1FmV5R23nQmkO25hndkSu5I5a4WKnzd//cwv3K@vger.kernel.org, AJvYcCVFypfMgb9jZU3Abjpy5eNmb2WEV2A8lPlI9RJecUuSTKrI9gnX5FnQxZylm/482fiHRTQMEkA7EQa7uqjCseQe@vger.kernel.org, AJvYcCX+l3V7Kaq+wy4wvqOBUPXqwhSrrAOCJnhWKC7Xf94/WGm6MS2MAVDq+HnPE/sYz5i3XONrbPrAcsUd@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdbEzbZiaulYxh4BgXIQV6MzUuQ0seNXS6tY3TZza7n15kkSX
	eQLpl608Jj6tZQxJmPmQ/QB1dQwBOlPYnI17F8ha6pquLFAClqZiG00KZA==
X-Gm-Gg: ASbGncsx+yp3g8pLU1FLKNSdCZU0GIJkWZ9+yxp+UDT7pz7wtvvoFlmcH6tErEAxThB
	8h2L5+rCMtLC8SJ8ybn8xzzJ7DuLLqlNY8fTOHKGfNFPVTbV1ziwhA12+Np6CqUStrm5PYW/ybF
	v9fCx8++/5BcKS1rlb12b1hW6aRLQRMJR/qSfub7S1Mky1VkSnLYA+VVe5breCR2u/1XFrR2O2B
	Z6M8xe2xuOSPB9U66giiAD/bRKttNH/l4EOxLNUO/m4p5gq/m2gdq/+j6YgW/oLQ8PfiNjsvE6L
	I/HZwJqVERujpoCCzzmr1oj+0sTP0hdr4kO7Rp4f+ZR0dBy6f2vqb74cdtp0xt/osqkWM+YfD3t
	zgm0=
X-Google-Smtp-Source: AGHT+IEJOYBdNlxOe3Vm4WcACkiF6uqe+uQDSlsIGpWsTHEbpT8FWvRz7QRfM070LidEpAOO0rephw==
X-Received: by 2002:a05:600c:8505:b0:440:6a68:826a with SMTP id 5b1f17b1804b1-440a66a0e7emr79136995e9.13.1745753043952;
        Sun, 27 Apr 2025 04:24:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5369cdasm91777655e9.31.2025.04.27.04.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:24:03 -0700 (PDT)
Date: Sun, 27 Apr 2025 12:24:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles
 around
Message-ID: <20250427122402.4f4fbfa8@pumpkin>
In-Reply-To: <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
References: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net>
	<202504201840.3C1F04B09@keescook>
	<CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Apr 2025 21:33:19 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 20 Apr 2025 at 18:52, Kees Cook <kees@kernel.org> wrote:
> >
> > Can you please revert this mess and use what has already been planned
> > for this warning? It is, once again, really frustrating when you update
> > to unreleased compiler versions. :(  
> 
> Ehh. Kees, that's the compiler in F42.
> 
> Really. It's not some "unreleased compiler version".

Would it make sens to disable the warning on versions of gcc 15 that don't
contain all the 'fixes'?

After all they are compile time checks so only need to be detected
by one person doing a build - not everyone.

	David

> 
> It's the main compiler in one of the biggest Linux distributions, out now.
> 
> Why do you think I made the change? Because the kernel DID NOT BUILD
> without those changes.
> 
> So no. This was not some kind of "solved problem". Quite the reverse.
> 
>          Linus
> 


