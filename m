Return-Path: <linux-acpi+bounces-17970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1731BF0D23
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 13:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C57C18A29EB
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EB42F616F;
	Mon, 20 Oct 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhwKQZH4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1B2F5A32
	for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959570; cv=none; b=uK5sXMzJDbzVoWQAcKv/VvBRneIEfOWroJJFcgJ81yllyhkHYhi73Cb1Y8fBtyrUDyzrnSsyx+rcnbqFZszZBvHTqZITODZAzxVcI5r7WsuMksZz/0JzFjtWUgGeZNBFgSf/YpZCHDXkaXOHwRAse7+kTRd4rPMlrwlSh9e7MZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959570; c=relaxed/simple;
	bh=hgOColYtjypJYFmtghZDQhWFnff6Vuq/Pns/rc/RTxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzaYhSQN6WwMPKOiiE1ddNa/4ibai3MHbNb6QiV54Kmbmec26DFskVsSZY3SXOjxUFdFqYdwVvvcUOeBHdNF6umSxt0Hrql4pUnuAlK9vY7ERbN42qAlrgizueSfs95JoEvg/bdEXtRBZitW6BPapJ1/FTiwSibtWQdqz2cAI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhwKQZH4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2699ef1b4e3so7493275ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760959568; x=1761564368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgOColYtjypJYFmtghZDQhWFnff6Vuq/Pns/rc/RTxY=;
        b=OhwKQZH4XCkNBxqdgYf8t4PRIoL0R7vfzMjrnIsRVCinoMnJNGTYlU79n7qlW8wfpa
         zNOeNBYKYP6/eYxWB/2sc9DemE26+rxb53oellKA91Nvv7rHQG0wJZCIgVDmJQ+2XEw1
         dEm6GoPgvuxODr7HArd+jLce17R43kU8183W8FwR/u1CVZTaZDg9vg818DlpOWT/z/1p
         k0dzpsWGEn5ROTH33AbNQbPizHs684iy59JSAW6NdXdsN2bxSG0/7KdSUIHh8JcgxNE6
         I3Hz76xnKnwdypq8mtZNQp2XGIGK2gn+JoMRHkY7nKIjO1OAXExZEZtqPbwJKVTae6vD
         9y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959568; x=1761564368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgOColYtjypJYFmtghZDQhWFnff6Vuq/Pns/rc/RTxY=;
        b=RtM5Pa9Onol3thM2keVFHbc3vnB7TyASwxBLyqQujY3O5lUc7CGSnIhZm0VdXyuHLX
         udwCfwV/nu1EpFMs+YLle8/vq2Ijpqaq3gg9KNKkDzzZ7q/tAJi6NrMKSAkq9A/Kf7ZZ
         kiDSgqHQZnqDbi/8jvNa076SMOwkHvVSNV/z5Ka1Syw28FTIHrz2XY8Xvi4pBsjd1ES5
         HuSdhCHQcXQZYxYv686Vi5H6rvOE2z8FsyixdmE+d6jS2X357CZtgJdFGiJEX+Y1jsAU
         rhmluVa4qLXK3Mcisl5m+4muJiLttUbj8WcgOlT+UwE1yHZhYBfMiBcDa1v/+B6KdgpQ
         1snw==
X-Forwarded-Encrypted: i=1; AJvYcCWmDg7CsvWrcNbg+GwQ5MsSIKFdRVZ5/YXNmnLOLNfr2JK5TGDxgC8QOQResjIGEnTkUmHGdfiUMC4W@vger.kernel.org
X-Gm-Message-State: AOJu0YySYHXaZur+eXmJK179XTw1mXcVCPbD4+fegzQk4LioKIcSrGNd
	SDZhhDJwxAoSwH6Hkz1/MfkfDh7L/kp1Dep8ctRuwB35CJIsBcKrGNqJgNirRwqou2g4iP22Fvs
	QvWsOxcLCwtUDb5osXz3pLBEANyhZFwXxX3gb
X-Gm-Gg: ASbGncs49acy/oEhVN6FQl7gBIou+6MuczSjQmr94bJ1M/LTL5IQkszIvSPtbpqSUUJ
	IFYZhwFFxBi70OLbLlFkXkLDhiWaf9t7bc0h85uuZLa3v0r3gq7W40oFRosDDkTfJpEgZIEMd0X
	bbSKL+g1gnOf72H2ydf+n7+nA79xbZ/uilrOqeQrFjMM2tp1Jcd8Ohd/Yv85tYIr/LSOgLaUHjT
	wbdS8/e1uNjgqx9ApW5shca3rP7VMjDUXonLDSlCAw2iUgR9CWAd++TOOuDkOPxa+oIlffZAFnS
	k1pysflRVSdBiYWntwlX5v33D5ifdVX+fK9zugTR/npDLNgO33dxmDVY0eY4TXH1cn/NfD9DLGY
	pMJEGvVEKr6+SkTAY4+7Yb1e8
X-Google-Smtp-Source: AGHT+IEKwZbSy/N18wL4YfpzGb1pRy6ao0FR9zqJgT5EVU+s2mj3AZEqw0jAcF02AG4TQ9WpRH8/nfLRy1ytZSe20ms=
X-Received: by 2002:a17:903:40ca:b0:290:55ba:d70a with SMTP id
 d9443c01a7336-290c9cf3306mr86594545ad.2.1760959568266; Mon, 20 Oct 2025
 04:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
In-Reply-To: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 Oct 2025 13:25:55 +0200
X-Gm-Features: AS18NWDO0ydrU_D3vxY3mykKLDQk63GF017mZ_6ZLZcYagnPF_Cv3D8Dk6e5NHQ
Message-ID: <CANiq72=9=W_j_o=oT+AdghQbEFbEmqT+Gx6q8oK8-yVwcrnDXQ@mail.gmail.com>
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Siyuan Huang <huangsiyuan@kylinos.cn>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:12=E2=80=AFAM Siyuan Huang <huangsiyuan@kylinos.c=
n> wrote:
>
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>

Rafael: I guess you will take this; otherwise, please let me know -- thanks=
!

Cheers,
Miguel

