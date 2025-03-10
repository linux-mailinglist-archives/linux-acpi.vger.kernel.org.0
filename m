Return-Path: <linux-acpi+bounces-12053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D1A5AAB7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 00:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F927172594
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFC20B803;
	Mon, 10 Mar 2025 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi7UI5DE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326A1DE3D2;
	Mon, 10 Mar 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647858; cv=none; b=s/JQuNG9UCJ3g6JQxdC9ephlHkmDg0DEXwMrdnqjoTszG/RjvE6pHbK+buyrydJVujWft/kRPKkn6NMvAoN7pF8oe694U30F38No32+1pWfkqBhrtHQI8OPL5tnZBLqL0qFfheCgs5yvp91LOojYlbePZAX0rZay/wkTLqZU/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647858; c=relaxed/simple;
	bh=Zdfhh0ipuN8MCu+L9MfsZd22Ig8nwfFBb83EjH5gd20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmGik4XulpdqjcxHk6c/A9FXKEBX5993zzH9ZVipV22V7iEyqEPfglQ5/Mo65T4sk2JK8aPxZlhIDY4xxsXgV+87dVEDGT61O+OobG+cVZ2glX0R8NiFOrwvCafAajC/Ma8kAXDf9MDp18hSpGV+F+TGlxXk0jChg2POzDxexNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi7UI5DE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff5f2c5924so1354251a91.2;
        Mon, 10 Mar 2025 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741647855; x=1742252655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdfhh0ipuN8MCu+L9MfsZd22Ig8nwfFBb83EjH5gd20=;
        b=bi7UI5DEBJlt7U4r55V7KBGdjXbdTvBKyq/SSMRyB06RKZAE8w4BeZSmSypdq5xir/
         kYwODsGm7fzIveNDY9dlVeLlExO63G7EnftqXOeEwdww2p1MWE91biOc8PDSfTdGVMEJ
         9Sw/qPQ01jVBm86s/AtC1QE7X2/Gaptl0ZrYWqKlxVtJld6mKvopVTro+b0n6eR84Awq
         tQciBCQXtSVUDE6uOr4F0k0DiQMPWRoWuMJhPp597cT5vaeklyXbN9THdKPzqhGfYodQ
         5f2rT1fDlPLItK0s/mLAO9tYW/TmrvJcp0za5RYbEjPMeZPZV6zmEXdNPCgvRVkSBsA0
         yraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741647855; x=1742252655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdfhh0ipuN8MCu+L9MfsZd22Ig8nwfFBb83EjH5gd20=;
        b=kLLVZoGYFfq2RePo2ERgysSINvUBKC+9O40nKX8mA8qNJyYI47PMdbWkrgX2tYfyUK
         5nIetnNCvd5hLibMeqKtL0YujUw5dhsWiQVL6ybU1vLhnDM472TcONiTNogdbA+bXkNT
         hgg6x87GXwKCtG1PAJ+iifkKIPeJIkxrLLFvq8sqo7m+CGD2xFU2PhoFNhGu3vtIcFDz
         1DTb76MW0vA4FXZaCWY/ujv4xG2FqG4qqMFl5cXQb6EJSsFE2tmvCksYykAHNiCggLEr
         MKdr4/CtPvc+VS2oiUHc8690E/J2izp2KxBBzlFTaQSGiTEO0sME6pSewW5K+UscyPPc
         TwVg==
X-Forwarded-Encrypted: i=1; AJvYcCUCNUQIe3/SGZFv346cez0UHAUgWtPxA58hbWIxid9TXF6ho6WWzMhUI1ef+QtT0J0RIBJdHUjodi9LwFWr3Czv@vger.kernel.org, AJvYcCVtbcN3ICg6dgtylRTXcjq49d9gTrE+qTUzvWlebXYEZ5ovSncxf3wKTEgNsj8NMK1HmrItWT5gbNZe@vger.kernel.org, AJvYcCWg1q0cTPK707yCR5kl/2r/Ov5pkEkrwtJBYe95NG/ZqM9ct86r5Fnqu/u7c+Q9ARoOEw5WrupzfBfkJ96k@vger.kernel.org
X-Gm-Message-State: AOJu0YyzM6SZhqQEpQfEUgYafmiHfxBrbm0mYX1FACE/43r1guXvWUCk
	+qE6y2zC9ztKWLjZmYOo0J5k//M9hvPniPx34UWY4Ep1UqqeNIzvUCt5/a1XCepaDvFHGmOtRTS
	HkzJl50vlYTvSljNtuuyQw9LxiRU=
X-Gm-Gg: ASbGncvaRsah+kUNPZL8a8AWUtz5MrSzbopS9Jry7TnnceLahJURnSToXjHWW0i6s9q
	tiUFCaKIBEnD59IgxQebU8D+e5Bm4QvvxmicKfDMcVV9T+ukJm5yNZkLzEhqUZ0HGdwFKp3P+Wv
	fr6W2j9vVCnVWcMUYyOxXixRWC4w==
X-Google-Smtp-Source: AGHT+IH6T8fdGIzDXC4W4TJjk1AVx/xQcuVgZrI0OMlDI+CxP0UiXAkP8MlnNFwcdqOhyukWA7xsEQmiPq3/ophLU1U=
X-Received: by 2002:a17:90b:1c8d:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-300ff37b586mr756039a91.0.1741647855338; Mon, 10 Mar 2025
 16:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310214244.work.194-kees@kernel.org>
In-Reply-To: <20250310214244.work.194-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 00:04:02 +0100
X-Gm-Features: AQ5f1JpZqJCnF45H_65NrQFI7MtNuIN6z8BNK855RsbyJrPe9EJztgfm--UbPaE
Message-ID: <CANiq72=n97YAJEMtgQFJbRP=Mt-SqznX0xcqxxXeeiXCPTqpoA@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Introduce __nonstring_array
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Marco Elver <elver@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Hao Luo <haoluo@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-acpi@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alice Ryhl <aliceryhl@google.com>, 
	Tejun Heo <tj@kernel.org>, Yoann Congal <yoann.congal@smile.fr>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Chen Ridong <chenridong@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Jann Horn <jannh@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:42=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> GCC has expanded support of the "nonstring" attribute so that it can be
> applied to arrays of character arrays[1], which is needed to identify
> correct static initialization of those kinds of objects. Since this was
> not supported prior to GCC 15, we need to distinguish the usage of Linux'=
s
> existing __nonstring macro for the attribute for non-multi-dimensional
> char arrays. Until GCC 15 is the minimum version, use __nonstring_array t=
o
> mark arrays of non-string character arrays. (Regular non-string character
> arrays can continue to use __nonstring.)

Sounds reasonable. So this means that, when the GCC minimum goes over
15 in some years, we can both remove it and move it to
`compiler_attributes.h`, right?

Perhaps we should mention part of this commit message (or the sentence
above) in the comment to clarify (it will also help to clarify what
that "only supported since GCC >=3D 15" means).

If you are going to use it in a series that has a use case:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

