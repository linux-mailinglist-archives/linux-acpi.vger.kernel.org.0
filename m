Return-Path: <linux-acpi+bounces-13131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6715A94BFF
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 06:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA7516F12F
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2BC1EB1BA;
	Mon, 21 Apr 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XZ4xO98R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FC224EA
	for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745210022; cv=none; b=jMUhULKl6NI4dtCwFJsqQL5knLMlHskplJSuw3+STkqCStABNj6GmABXK2M7gh3aSAnDHs5hFqVbxosnEWrHobUgQLXDDte415BPzcjQ3WeyV3r28q8bTJLoAT1WcDhGkp8AvahPBOG1AkfIp/a8CaxTckQFnPVNFldK8rCJ7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745210022; c=relaxed/simple;
	bh=JN8iby6an3mfDwdowPn91zamLY1xRGg6bBMjYkZ0DIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTqKU9ze4zlMzaguTdZqUm/kL2KqrpTUuSY1m/qBKgJhm2uknT/TJGpuySG/py8j+k5g3Xs2RBBhvXwu+OgYGrD8T0DLr+fHXYi2dyBwFxCTxVR0NExP4kwopUkqkYMPwZrsF1r6S2LBjnjiQTLm1u9dO7VuMlZd7PlxU9n51u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XZ4xO98R; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so512138266b.0
        for <linux-acpi@vger.kernel.org>; Sun, 20 Apr 2025 21:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745210018; x=1745814818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVqDWiNRjRqlUA4pP3gMK9BF373U1wIAPXz+PfM0geY=;
        b=XZ4xO98Rlzh2kp4d56d2+ZvJMVwznrnfM7rr+Rem61zgvdCMa1WVG86bdFVhsxzAp+
         OFFhMAiXWwm2W2ZgdNU8qS0KgqfgRjqUl76zCKZMBWi8zix1D7hI4gf3aYm9S187vgyV
         ay+AzGKMrvK5gbffaAbbzRS8BcopgqSdopNIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745210018; x=1745814818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVqDWiNRjRqlUA4pP3gMK9BF373U1wIAPXz+PfM0geY=;
        b=xAC97hdDWuE/UHLfQVHuV7Utisaaixb6Sk1ErfHxmWOCGM9kx8pXHZlcAusgS8roay
         tX8Zah2PEbCZ49C9d+uYoEJn+iRbVRiLUDFph0v7RB+w14AbMeWA9gVF92ZqiSRPkdno
         5ROtgkOk2lAjHBsmUq1hObgr8e12YpbjeYvciJfaXaOKZUhu0gVHUGU5yctbWxXDZ1FX
         fH79HfkIi49ZX+Ya+g7GmBWrTaL3RFNt+4ftyOrEmsZYtm/Fh6ZEithKwkqzPSeTDHbi
         +saBrpGdueYn2EnMJ/Geseugz5+4mpZcXvvWfHvr5qIiT7FXxwYNDyrYIhCiNfWGzeBi
         OMVA==
X-Forwarded-Encrypted: i=1; AJvYcCXFQFP1zJNkgZUJHgAH86zJ+NtxOUdM7g5+IuLfXOF1IUCM62oXH8URIH9uGjpnDmzKHkosQUIi4s/e@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPvpLemfa/HSmrELxgcMt2NZUxcYchF2AR3618pIpqNxkzrDc
	Ae69koXY8s1jlKJfxVYM5hfUQSDUz0HiFlUaYg7l+K6rtMnWAAM1x5VDrug4+cpSTXN3NR/Q+UB
	yh3E=
X-Gm-Gg: ASbGncul4fGZ5UwsRT2/DdKqrCW7gKXDutL/vNOniuCO13xIkU3TfCZxXWHubl0wZGJ
	ISjmeorusN2OSIBAYDfu0Jmcz2cmUHGHUA3Zzm4JfO6gnhpkGFthp6lhcIMG3Qvg5rSn0BmrOrU
	LLBktSseP2eF417EIh3PRVp32z4v38G8KlSOlUo93vVYR9QZxXq14hdy0JBDmFTrfWZ9bhDVp8I
	OnSpf5NfUp5aSkQqrHw/J7RtDmSVtEm6dvN2Jps2k5vJgOargVt3ZyeQaYM3aLjXnEByFvvbdWL
	5jTYsvkyOAXH0tx7U/qL0dHrcVRtGvYG7+NRN2CqA8UtZLFUgZ16e6TasdwhS5j/N//g1JXVV7+
	uPGh1mO5aeEJZdfY=
X-Google-Smtp-Source: AGHT+IFZG9SRXPKb0k0dimx7dF7hiGzGLq3F1L4yUpmRSLe/a+Xc7LqHl0FU+MVcmHfIlEABGTtc2g==
X-Received: by 2002:a17:907:1c14:b0:aca:95e7:9977 with SMTP id a640c23a62f3a-acb74b508b5mr953825466b.28.1745210017756;
        Sun, 20 Apr 2025 21:33:37 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef47ea5sm462162066b.146.2025.04.20.21.33.36
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 21:33:36 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25d2b2354so532755466b.1
        for <linux-acpi@vger.kernel.org>; Sun, 20 Apr 2025 21:33:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiBwdCbfFIMq5KpH576NLW9lM6y0nVT7fDfU02d60ZRjWtTmE/SP70UCXQWruycV9xN+fYzXXMowCz@vger.kernel.org
X-Received: by 2002:a17:907:1c14:b0:aca:95e7:9977 with SMTP id
 a640c23a62f3a-acb74b508b5mr953823166b.28.1745210016471; Sun, 20 Apr 2025
 21:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net> <202504201840.3C1F04B09@keescook>
In-Reply-To: <202504201840.3C1F04B09@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Apr 2025 21:33:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
X-Gm-Features: ATxdqUGGqXh-vFivnudAlmvqx6H6i8OFi9l4FYYx5jTgGwSOGb4QhTZQHzEtAbE
Message-ID: <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles around
To: Kees Cook <kees@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Apr 2025 at 18:52, Kees Cook <kees@kernel.org> wrote:
>
> Can you please revert this mess and use what has already been planned
> for this warning? It is, once again, really frustrating when you update
> to unreleased compiler versions. :(

Ehh. Kees, that's the compiler in F42.

Really. It's not some "unreleased compiler version".

It's the main compiler in one of the biggest Linux distributions, out now.

Why do you think I made the change? Because the kernel DID NOT BUILD
without those changes.

So no. This was not some kind of "solved problem". Quite the reverse.

         Linus

