Return-Path: <linux-acpi+bounces-14249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C41AD2160
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E943AC631
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F319882B;
	Mon,  9 Jun 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmZNU+Od"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDB18FDAF;
	Mon,  9 Jun 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480636; cv=none; b=ZLtfFl4c2XJImlVsTgIj4Dv87nuhU8EgWKmHfPuvPWCTSZOKzoOOk1Dep1uokwPobeF8TWkSqYUg2/AyFEdkw52KzeoPmS5tBnNmF08stGCAP/1C3oxU37ZccgnujMvKZolZWOEk3NJS9yvAMQhpySf4GUjwcp2KWirNYJODs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480636; c=relaxed/simple;
	bh=u/oNo+FV0H/X67hr2yBqFfXJbKA29ZKnpCOR5t5vzGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG2LePs/MfSkZXXt90fIouSHfcFfWnKW4JMQ7L8Uo+yaaOzHvTOVot0HHIPUSNltSDJsuaSwvEc2WxAO28rkNqW7knIs590g/bShEC8+CFZjZd3Mp3tNd8u8sJ1dBpSr9rd8q+8eCxg2cJgKda04G0/DIizJAyu7+5zgOo2hqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmZNU+Od; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b122f2feso3067065ad.0;
        Mon, 09 Jun 2025 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749480634; x=1750085434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/oNo+FV0H/X67hr2yBqFfXJbKA29ZKnpCOR5t5vzGs=;
        b=TmZNU+OdneoIa8loXLcMGOOl4todVX2iEEiscMYTAqtO1kfzYnTJ14yYiIoSfsQIVr
         YKU5OYX6mAVEcvsLM8PZySB6mZx2K6w+28bxJGHHa6W/uEVEJKvh/ryQJ+jKI7+LcwI7
         s/48TM31TbMQxslfA5dd4bOilH0MKudmA9bBMIJ7NkOXo9hO4xnoJICivFNC38R36Lkb
         I1qAyIFZyLpAqlthdJ4n7ykwRo0/CmcNqcLkQcDz1i7XHomDIU12aQaZvxsKg5ZOY19W
         yl1/vODZzgItkj6F6GHNpANmpxZFlnXQgNUktxbfEpomiwwWvktkKbiJ2DM4rsVWqwdd
         gozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749480634; x=1750085434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/oNo+FV0H/X67hr2yBqFfXJbKA29ZKnpCOR5t5vzGs=;
        b=Ldd/yWnwqDDQlDKcbgdyOSiwTOrVEjSYd+t55bKZH0lVH9rG/XLbIyKQBPSvmNjXoz
         8mVmu2sj/QT20ZeESSzDrRp+tre0q0/QrwwIndgW1eiHA0aqAjgWeBEVSA9xPTRKa0hN
         G4qRvvWjos70lGI8hjYKbnjZJSeQ1v1Zag+suUIHYUL5GyM73jrl2NixqFj4KVzf0/5U
         aqDsnkP+kewgxdKSRUMwjmsY9x70+IYGcCnFqnZl4KahQW0uN5nrJW4vJjY3hQ6swyz0
         vXOqYqmYfEGFdFNDiC9EueAjvNleERaDdXT/PtwqGlzRN1V9G4H42ndinIQrW0UB+Q0X
         gtGA==
X-Forwarded-Encrypted: i=1; AJvYcCVeWqToPP7D0ru+IzxXP/7pl91LB2apUH+qRIwPKpm9Np2aNOXVtrLlntNCgUNIbvtK9sYpsi9jFXTU@vger.kernel.org, AJvYcCVsMmiz741PWpJCZanls8KbBsXSBONBtBcl1QoTXo1aFGlO0LNZzc/C+mfMJa3JklnW2M9h2dCVAvNHVeBKEjE=@vger.kernel.org, AJvYcCXdltvLMYmv539PSkfaIFQFjJNPTSpFV8hPdFv5pKmaOQDQf/W+LRxHoBZ4agXLl76vQIUoNlFQlOHOdw8p@vger.kernel.org
X-Gm-Message-State: AOJu0YwZE+i8JnybtWszSuFW7PKColcg/vbIycGylJQJojioj1d+7aT6
	dO3byXLCI8+YiPPGAv4Z8g19YiZHEfwFIl3KvZLuWiceiW4sSc+AfCwqqlFjAymdlW/VILdjYMG
	3z15tXaDpyF1u0M3/de76GbCyRHHPQM4=
X-Gm-Gg: ASbGncv/Iwsq+HUqOAKBd3RC0mPBUz2DLb2kG2KWetaT4YoihcoKXPgty/Cxkrnc6LZ
	4ndAreAMWHHwOejlu8yV8CnxHL9+2O12LuelPLAbb9XTGZ4PAo0i3/jnx8SgYfiy3/3jv3PW4Wh
	J+5lm2m3s6r7IU0TukoI0O2aUcmA1xqGa1
X-Google-Smtp-Source: AGHT+IHNXyCWorrYd30jE+3a6V+kr7cqQeRJiV2nHX/r7jjF5Ri7IjZz1teLnZcoatAdHO4gb+GY5VkfbNpr+HZ/AZg=
X-Received: by 2002:a17:903:2452:b0:235:ee04:dd2e with SMTP id
 d9443c01a7336-23604094a22mr69818685ad.10.1749480633948; Mon, 09 Jun 2025
 07:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170817.3881748-1-igor.korotin.linux@gmail.com> <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org>
 <aEVqgUtflBCzZi1X@pollux> <DAH4KX3Y3M3P.3B82LSVWU172Q@kernel.org>
 <aEV43zxZmWvDgKES@pollux> <CAJxaTdNZEdK21mFPu2kTJPa7aQ+PpnkwFVdEP5MCt6w+bD0wXA@mail.gmail.com>
 <CANiq72=rerpj_Ut0x7dDb0O8dEh9SHaF1HVyyfMM83hz--QCJg@mail.gmail.com>
 <CAG7QV91u4rVgAqDjKAofupASSk9q0uRKNtsrHg7Q6KExRMkFog@mail.gmail.com> <CAJxaTdMFp0WAB3BBDPUztVvTtDGUt9=KyHTDpDOgAZ4ZEk2XUw@mail.gmail.com>
In-Reply-To: <CAJxaTdMFp0WAB3BBDPUztVvTtDGUt9=KyHTDpDOgAZ4ZEk2XUw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Jun 2025 16:50:21 +0200
X-Gm-Features: AX0GCFuaAnoglbLmGnvDAPgWWiamaOBF1T0VOHg4mWfINNGaZeAYmj9hQN7iYjI
Message-ID: <CANiq72=ph_XG0TtkdsNJCUZMiAMYBo11eJaCTLCTpTAFXtcNMA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to Adapter trait
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Len Brown <lenb@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Alex Hung <alex.hung@amd.com>, Xiang Fei Ding <dingxiangfei2009@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 4:07=E2=80=AFPM Igor Korotin
<igor.korotin.linux@gmail.com> wrote:
>
> 1. rename it to `_dev`. This is nasty to my opinion, because it is mislea=
ding.

Yes, please do not change the name that would be use in the "normal/full ca=
se".

> 2. add #[alloc(unused_variables)] on top of it. Also not good since it
> will suppress
> all other possible unused_variables as well.

This can be done conditionally with `cfg_attr`, but it is not great.

> 3. The third option is `let _ =3D dev;` in `#[cfg(not(CONFIG_OF))]`
> section. I came to
> it while I was writing this reply. This looks like the best option of
> three in my opinion.

Yeah.

Cheers,
Miguel

