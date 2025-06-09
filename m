Return-Path: <linux-acpi+bounces-14244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C9AD1F24
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634ED16C683
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333D259CB0;
	Mon,  9 Jun 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3aseK6D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC2320B;
	Mon,  9 Jun 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476538; cv=none; b=QzTiIKH/x0cQF1TGoFMwZRWAEAAd/gc2SlT1Esrw71wzi81S/Ax2ntptamLTs8fh5ZVyM355wX6Al8Uj8y6M5izWPBNAKCQA0f4vQ9fRMhEkDdgg0TlgbZfaBVvoz8fDf62+LP3WY1LopBOB7mN2Q518GNij9q/sN53h3fuojxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476538; c=relaxed/simple;
	bh=aLHQQvcJ/CzG56n3F/pYuY+17KVjnXrEYITOojxRbmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4H3MIatlGEMaL8MKEMWfD4Q2RbP0T5NsU1EiA8D+53aLAeJenPuoEvdSl3Dmp4TwkhZUzjsF9IVIzFtk/jDkctmDS8JaO02N2v70pfA7/gi3AnUOFBFnHHoE/rS2FsYdFHoEgnrTDyfDvdG6dc77cg7rMOcIvc0g0DXGbgbelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3aseK6D; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2ef619e80eso299128a12.2;
        Mon, 09 Jun 2025 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749476537; x=1750081337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLHQQvcJ/CzG56n3F/pYuY+17KVjnXrEYITOojxRbmw=;
        b=G3aseK6DuXIPoQF4rJ6+cK4Ldu6BGadsay6ryDgM0dUnzCiTAslcNO+GJG0CWsEk//
         LFDmVGWomb0DszfnVRNRdoZ2+7tZw9+Va3EydGGnJbBJR4eD34kUjD2e9dVLKZpQ2U4C
         O2QxXeI8mfPY/4M1Q9EdaOaATP6h8h3WJ1sPAoF61WpeMl49tw+QyCXZBg4fFtWF0OpE
         4Rmvr9yGFUW5Rs7QNsSOFoh7XZLkf29a+hAru2+hKbzoMFll3g41y1Ayc6haYTk7IEnJ
         +NBvnOXuqZW2g05tHH2Rm+/R3YjdjstOT3Ayl066or/VAo9zqEUUI2wnBVY3FWyrlp3q
         TVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749476537; x=1750081337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLHQQvcJ/CzG56n3F/pYuY+17KVjnXrEYITOojxRbmw=;
        b=E2+vOdl++ZZW/EytuejMmrDAB/N+xGr77fAbiT3QeP8U/M8wzV15FIP7HaqCuPBrRo
         ABbHArDsMhB3It0RriXwF/79TkGRvXzHl0Cziun/9iuxF5kAc8WYi4F+z1UyKQ0ECMQ3
         en/6P9VadpSSlISXUA6xqD8x3pYqktNWNvclgcN+E/UqlYhwakfOl418PdK3AH8rXBew
         yIjMjkCt/wUQf01AuqsR3ghnXAuPpqJdSLwqZpKj7DJ9K13GUdw61xh3K7nFIYxBswBu
         2Z2mZtneGDlJ7WoGFq7AGvAbIrlZEUasQdLEQGvKHZ7LXnN/3cGwPvdKjvNu1WiPzm76
         KKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfBLT096rkQxBKlUZc4NpQRq+SYmt9N67zQ2E0cdQQe/1rRL6/rt1RxAoI8DSzYyPesRXrZVuLsGRqDDss@vger.kernel.org, AJvYcCUqkLRe9Kh/DfyWOKYihM+CYZFSvOjVd36gO3gwQYA6A6GDNdFNJaFe1+Yp89xDVmnmxzowFkmhUeDMwNPNyuQ=@vger.kernel.org, AJvYcCWhtwCZgNNiut7iHDY27bQfKXAgvIcGaKcMT0GIPdBiAkT03W5mIE2u9EB9SX1CRzwO4vOT+vFi+KhA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13moNAQsy7iP48hDlLZDxn5JpKvvfad4ESj2i8DO5pgr3Y7z+
	dREnHoGO77uuP5/ZgBvRr/3iYNwhwu+GA2Du0Ry0SQAVgGGDDjkWdzRFeslWAntqeKTgzP+2w6w
	rfp3+/U97/ImFFusLsR9xm5CWzecXj7c=
X-Gm-Gg: ASbGnctVE3TMyGUgarAlErG//P+Xs7yr+1+0ejRed2ccFE3KHMKvaB76K2/wWlJd3eJ
	xjOLGjkD1MWFg71suGpFFFGrjRfWoqszEirwCblqnlsrl4aTIkDIgGi8i9b5GvX5ppimfEMGUrG
	eRJaP2gMbbxqAAKNUR3V80sh3w92OFuDjC
X-Google-Smtp-Source: AGHT+IG8g+8pCae3TmU8EdIiokIy7+Ydfo09f+/gWEH3caQEhmXTDfFAwp608YUZ1yuwI6t7yjmGrSc0B7PuU8J1A4s=
X-Received: by 2002:a17:90b:3890:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3134753c519mr6906752a91.5.1749476536634; Mon, 09 Jun 2025
 06:42:16 -0700 (PDT)
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
In-Reply-To: <CAJxaTdNZEdK21mFPu2kTJPa7aQ+PpnkwFVdEP5MCt6w+bD0wXA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Jun 2025 15:42:02 +0200
X-Gm-Features: AX0GCFvdQ53hVVkSQ6Wno2xP-Qw2liNpZXY_h_vcL--AQe3WIQ8Lq5R3ZurK1-M
Message-ID: <CANiq72=rerpj_Ut0x7dDb0O8dEh9SHaF1HVyyfMM83hz--QCJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to Adapter trait
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, ojeda@kernel.org, 
	alex.gaynor@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-acpi@vger.kernel.org, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com, 
	viresh.kumar@linaro.org, alex.hung@amd.com, dingxiangfei2009@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:09=E2=80=AFPM Igor Korotin
<igor.korotin.linux@gmail.com> wrote:
>
> Let me know if this pattern is acceptable. To my opinion it is not much
> different from the original 2 functions conditioned by #[cfg] and
> requires some nasty changes.

In general, the more local a `cfg` can be made, the better, because we
can share more, e.g. the docs and signature.

But maybe in this case it doesn't work -- what would be the "nasty
changes" required?

Cheers,
Miguel

