Return-Path: <linux-acpi+bounces-14197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D4AD0457
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8596A16054E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238C286897;
	Fri,  6 Jun 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEsSPpjR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AB27E7CF;
	Fri,  6 Jun 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221905; cv=none; b=FdnS56CusMUy/ARFj3jPUjzfwCoMczpR1QQtEXdZvZ8/Gp0J80ormYaJfbTf9/wnHLu9kcy6K0ScZZdS1QWEGNUedgTIlnb5V2oMcz6eGosx2Sfi7ahJYMw0dXYPD564hqaVthdPM3vAfUxSZ2TIuzudW510BFD2F9HbfFtlqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221905; c=relaxed/simple;
	bh=L3ansMab82uYiup2PPPtsuZ7QMMlqwUdIbnuDaDUGZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXubPFqMUQwaoO1rmthG6lawk97Iqjt562IYH50EA6TpZfJLXqBvcotqlL62am7uJOLOzPL1nGdX+JJdmwGHzfz1SQq8MXWdcaEQ3nxC4tbcyWXvTS50xkRlPEgQPYrYMp2gPby9/HBHxA2vY5wJM7g0Nf7DGQlBTrHATduiEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEsSPpjR; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-87ead500f9aso1193276241.3;
        Fri, 06 Jun 2025 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749221902; x=1749826702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3ansMab82uYiup2PPPtsuZ7QMMlqwUdIbnuDaDUGZQ=;
        b=WEsSPpjRro+OtSr5TZInS5YlqrDfteWA0XAJBquWoMwUE2K//mT5NUOC46JIaSM2DL
         eb1wMM5WspZ/r3bFpKuNVqSMJzuMgBu1l9FVlPr+yZ0MO0SqmX9SUpX6CPkuzAWvDCG+
         HollNWQRqCVZA197KkKyiUx2zEUf4i0G2LZ2euHa8WLNPQCOrymzdqFmVTrdS1OLYhat
         61142HwcsOp/bDbpuYKLe78FtF7jW/EuIIwz6r0vpOVAyJQWgQpFb6LFwLCd7AgE05wo
         rD7rVhGZcVOB/P9tsqNuNxk/V+tuCOFR226jqa3s+BZj/ueXg+fBJQtbjLrNFbC5TZbM
         uk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749221902; x=1749826702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3ansMab82uYiup2PPPtsuZ7QMMlqwUdIbnuDaDUGZQ=;
        b=HmMtmTFb3cgt3UbM+LzV27ltfol1ZdEFpMH+ffj2S/89Pl8STx65DYk7FEwo+58r6c
         6j1icaY+MSF1t32DCdKONeyhfyph5O9yCIw8HqOsM40vopf1y0FN9HcaO7PI4ewye2n9
         iOvN6DTENk3zj4yBPJlH0CvWbk/b8actDB4T4g/3NLE8p2QwEGPvFfkWlLMI3Vy6fADR
         +QJKETBrJ9EBpQt9AJVQqTnsIB3wb/+4J57darYJO/g6hyMmyVCiYzHM3GqFKSEKy8iT
         VvmQGaATYGEinALoeDC07Wbv0HndD3J8WYe9c3If8RZkFx51q1Ql3SY0eF2z/DweZriU
         2UKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaeiQZyG5rvSu07rf/xIv3dxQm7ySzhEuJJGeNsXng+MFlSIYXjHG5aXQxSF6JLnisOchQKQQRRBnxkQMlouI=@vger.kernel.org, AJvYcCVej/gwuRpmkYo2r1FQRCHFq7OKpUR/65C0XnDvtNpdNpUC5cK+ydzeiypQ34XWT6anIHlaPcOTYIm1YRia@vger.kernel.org, AJvYcCWSefYTXR3qdDkDgg7NuBZMDxDSZ3p7+8bmPrm02ttqdp5oH1G83gd8bDc0kd8mWJJkr6pEQ7GB0FaQ@vger.kernel.org, AJvYcCXVmfFCyRNO+iQNBt6UAj4bF56ZNPfMWMHLSwvyT/D7pYxcKQ+69VMUZZ9kRvxYs7I6PRfZhRsHK6Zf3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsh+sux3dYqMQu4VZUY+3spTLr1qYvMGej7fuIo3iSvcEbHa8O
	r7l13tt4f+Wrz0yXAxNJhNETOBM0XR0GCVdYRmTjPeiDZz46bF4etbTMzCBJqy/kovqsQAZdCag
	n+bn/GB3++K6xpk4fquL3KIfovDW2sbo=
X-Gm-Gg: ASbGnctsE3TAmDI+ujJJ3SL4TNQjUEMvwnqzUu3JXQwTBgDDUSRJ4oGCaANKyO7w81V
	JfnU3w7DIxMrUB2PvYloXKXCgubYAB0y3cV03bf9NpUJ9kp83RwHijm2R5fVmdnGHGGaok/QZJR
	EOma+dUG1IsKe3lcWkI8s4OrYdXAz5K2fH08iQGFeP
X-Google-Smtp-Source: AGHT+IGEngtE5dWaklnsqQU6Ig0UmMfAlJowM3JqRrbcvQtEtfvISuLc4Jr4sWBXQ4ZCf8k92OHmpc46xgu8moJvcw4=
X-Received: by 2002:a05:6122:2193:b0:529:1a6a:cc2f with SMTP id
 71dfb90a1353d-530e48876e6mr3854370e0c.7.1749221902592; Fri, 06 Jun 2025
 07:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605162726.3659792-1-igor.korotin@yahoo.com> <aELyEqg0GrkC8oZY@pollux>
 <CAG7QV91AWpOk7VUcE-B1MLkEQPDB0Y=zsBOBf6MhHVYh1aEGQA@mail.gmail.com> <aEL76mgHSZG5idW8@pollux>
In-Reply-To: <aEL76mgHSZG5idW8@pollux>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Fri, 6 Jun 2025 15:58:11 +0100
X-Gm-Features: AX0GCFuTvai9XMEtyC_KYBdO9EciOGTan2CvJLh680Tl9vtdtqAjm7YLmxzKx0Q
Message-ID: <CAG7QV91kkVqE2BgB5VpmX7QST25VDCqr+9zNx1Nt0-fuwp9t=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to Adapter trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: Igor Korotin <igor.korotin@yahoo.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	devicetree@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 3:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Fri, Jun 06, 2025 at 03:26:13PM +0100, Igor Korotin wrote:
> > On Fri, Jun 6, 2025 at 2:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> > > However, I don't understand why we need this and the subsequent
> > > is_acpi_device_node() and is_of_node() checks.
> >
> > The idea is to avoid unnecessary table lookups when both OF and ACPI
> > match tables are present.
>
> Ok, that's fair -- let's build it on top of the FwNode abstractions thoug=
h.

I'm ok with the FwNode abstractions. Just to make sure I understood
you correctly:
I'll need to wait until these FwNode abstractions are pushed to the
rust-next branch, reimplement what is necessary and send v3. Is this
the course of actions?

Thanks
Igor

