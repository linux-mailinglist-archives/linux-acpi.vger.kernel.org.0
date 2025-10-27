Return-Path: <linux-acpi+bounces-18256-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1ACC11246
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A47566F79
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB3132AADC;
	Mon, 27 Oct 2025 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTzKTfGJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14B32143D
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593445; cv=none; b=gq01fQX8vjKbUryoIba7DI3XR63jdQfmPwKXdkY1TggWhXJEFlUAAE94dGPNLuBZZ+jlfxoZFhBRkAIdgd3MQ0dIO+H97qaXTH3f9v9cito1IzGUwSmA5A2hCdlOvsZ2Hy7x5P33GII851uLq+H8xYESeXTIZ8vEwX/UOLWaKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593445; c=relaxed/simple;
	bh=4zGSu5O6665+Z4KvgAMrt4U4QKGAGcwfeem+WdVASmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDTJguxjO0l3t0gr3zNUva/EOAkMwempi2jSNlopqZXs8R5bxwYYb6CbyOSvh2tV8qlqBrj24wQu0/rIsFfqS6eoZSE/xywr9Z8VNQZIwJsds7sxnt6y5I3gmeY3AMZdUc2Z7jW+CsY9qCXTCSbGZAmoi+V5u6cNS7Vc4JNBAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTzKTfGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D859C16AAE
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593445;
	bh=4zGSu5O6665+Z4KvgAMrt4U4QKGAGcwfeem+WdVASmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aTzKTfGJakTqr3v3kSWj8RLSA9H2yew7+VKtZvvEUXIHUbEA13sjUbVUZBg0wYWvR
	 bcMutlRsozqTpVbEEYnsIR5Kze+MACu+PvmG3t0uSeGW12ErGBCgGoQNWzanYPEGEt
	 fILppd7pTyhgPQRQd6c9Jz+7KKamSNs1h42Gjc5lIBg8exL2BIBTwspzxCR3tsrRnL
	 mhRrarSyppOIG499Wxz99J68BD76nTZb43Fe8uj9jr3ITvpqCyYYBYxrgv+ZkIJaOv
	 3OlAz1NTQKscDxf52VHduXNi5eVhd54ovOxnNNxchNj/938BhOwFsALry2rMBNXseW
	 x5sFpuOw8mZag==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-44db1c1056cso956024b6e.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU2HOAR7cWKw4QhaPfCN28xJF70w9JxjmUsxN5LCqgPUN+k0JJAYu3OGaDNUTLp3VBvwzqFNSv+zj1@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsVqVmjj87CcJufOw0WXg0VDruO+YyUZtRhruoaantFM+PZM/
	+FBn7yweL2w2op5C/HzDO2U9ovRo3hg0MRXS+5dGDyB30bJviUlZMQOaWKkKxap9BLSDP/FyhdY
	DKmbVHL++iaho4A8qtX1TD4uP9GWqfAw=
X-Google-Smtp-Source: AGHT+IH+SDtSfHYobBAwmnI5xMhbgRP83tYXzqRiZ/eznt6J+jvQLL5SZ2qwcctw+mVlJPZFeZjWkIVgRjpTj6WqJBM=
X-Received: by 2002:a05:6808:1822:b0:44d:a337:6ca3 with SMTP id
 5614622812f47-44f6b910a71mr484015b6e.11.1761593444372; Mon, 27 Oct 2025
 12:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn> <CANiq72=9=W_j_o=oT+AdghQbEFbEmqT+Gx6q8oK8-yVwcrnDXQ@mail.gmail.com>
In-Reply-To: <CANiq72=9=W_j_o=oT+AdghQbEFbEmqT+Gx6q8oK8-yVwcrnDXQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:30:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gHK5_z25z0EdHVmkbpvMQqWdWObxUCFQt_S0bHV5LAQw@mail.gmail.com>
X-Gm-Features: AWmQ_bmjn_oJV5HZo3zUwTZ4uBkBxwOm4WB484q2m9iIJ1-7zSp2MTe_3LbLgeQ
Message-ID: <CAJZ5v0gHK5_z25z0EdHVmkbpvMQqWdWObxUCFQt_S0bHV5LAQw@mail.gmail.com>
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Siyuan Huang <huangsiyuan@kylinos.cn>
Cc: Len Brown <lenb@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 1:26=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 20, 2025 at 5:12=E2=80=AFAM Siyuan Huang <huangsiyuan@kylinos=
.cn> wrote:
> >
> > All types in `bindings` implement `Zeroable` if they can, so use
> > `pin_init::zeroed` instead of relying on `unsafe` code.
> >
> > If this ends up not compiling in the future, something in bindgen or on
> > the C side changed and is most likely incorrect.
> >
> > Link: https://github.com/Rust-for-Linux/linux/issues/1189
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>
>
> Rafael: I guess you will take this; otherwise, please let me know -- than=
ks!

Applied as 6.19 material, thanks!

