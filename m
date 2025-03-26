Return-Path: <linux-acpi+bounces-12461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFEA72068
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CD3B8D88
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207125F78C;
	Wed, 26 Mar 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQQRDIQ/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9A253B68;
	Wed, 26 Mar 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023198; cv=none; b=VHoA9qtaQkCCxpPGm3y4gPWPHZXwXwmd/80SMhJsvzNpoIbAq/X54aswNdlxPaprkhSNrXlSRb5TYnLq6WLKPqfniMf7tD8kia+ibUrt6X+wE9SQ3/6eYID41lrxpVA/KB/h38R+bBnQ3wOuv/vHsyJhXefz+MCG2qQK9kuSybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023198; c=relaxed/simple;
	bh=u1KKFwlHMV+XwZjtWbdcpJPJxVd7jlTCsavRzYqtYBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T60ykZUujCspaJcTeVlJvwNt5zMJjvKmpL6LkQcwdeF/sD4qk/hzXfa2+c7tdvZ2hLnN7v5Jm5jiJ29LpxAYdlznH8fpzwaAlBn2cj55hrNhZ9K69F1rh22ZuHKZ0TVRI7cyZkXg5C/rjdyT9DV3KgflkQd2SRG2MoR1tyBnMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQQRDIQ/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso116694fac.2;
        Wed, 26 Mar 2025 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743023196; x=1743627996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JOjr+0Qr4MoAVBxIa3oIk039R0iGfKEGtCgpeZh3CA=;
        b=QQQRDIQ/NsFukujrpoMbsUhqFQsskqEGIcld/N5ruXQFSRgQLR3Dkw9g8D/6907PNG
         oUYOARaR7CzsXc2Ix/yDTHhIRaK7iIIc8jx4GcxQ3bwGLkx+SaugUCXdrtV4UDV3zZT6
         F//zi/+gkFG5cUBEXuuuo/nlokLudK5zS5f7uO2ACFZua8Xvy8ZFTv3H5o92fMS2yPMz
         PoyY8j85XzVi6ut0LgrgeBeP0hKdfI/PWvH0gjA+TPzQi64RqDDlpmGr4V4fPk+a9qpd
         PS2m+lAzBN3aYP8nPdT8M4E+WBhLZe1lLzqsVp6lGyVORMIctvIbTWn+u218iPelITrL
         Tn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023196; x=1743627996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JOjr+0Qr4MoAVBxIa3oIk039R0iGfKEGtCgpeZh3CA=;
        b=jwncPAe+Zd5UIvVu0ajDx6aJ0NMKhO6PTQigAYvR1R9I2yRRnwANHEGJTzVWUVsYmK
         4AWXe9DRBT8QQPSiL7Etyo0oYELr2xseni4695asqH8k4qdh4oxc5yAGRV9uYVFF/k7X
         Hn11BlGspW0O2nUaQCwHfzFmiondtFjcl8mLplbZ/g1DIungS04ofQ3ufUno3ckFTlkL
         12ZdxQ82e4DGf7u1Ush/O7PvCK2C3ijC+ax5b2ag0QUHibNSTw/Bo2y05gPDmrUUO+pX
         jH+UXNwJsOOMWjlMQBL+l1djWUIW8fLTNlm/ofZrVflnY1GgxikhrQ13UuQocfjy7709
         1d3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSJoc6l4syo8yww6WoiIre0mx7OZYEYY21FfR1bC9fGDh0NXHMfqbMW1pF88GzeHzKgqLNYFCAbFSinQ==@vger.kernel.org, AJvYcCWIi4UQyEwksEI3zVpPCNNE+Zt3IikzFaOdrAnMfWkFiGA0S1MO2EaRV7dsUCtPKgaPdx+p3PzfCGltwdDesNo=@vger.kernel.org, AJvYcCXL4AWb6/ReG5hRXYZnC7y3LzeBy9LOPDJVxlSEcjqzhDZwOGzWHm6xMsegRHVaubadYKBG7Tbyf90/KuSA@vger.kernel.org, AJvYcCXWjVIvgzQWo9pRYCetRqGli1U3RnjjNlgtzZubRsk8k2uQKeuWQKketQmSmdi5d/dzAYgenae+egEM@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPGJW9zfssxS7vnWQWLjBkSM+tBvb4qZiW3QOEd4UpZad/xlW
	PPrPhsK3RUC0NS+gf6E8J9GnbLlcsRhQpLGWdoTs0uPvt1wIJXmG
X-Gm-Gg: ASbGncsiwCkhjna57hmNCF5lnrB6W6B8a+yAb8sL5QaLWrKxbMpbfVEvDY+Om4d45n4
	i2FyTz58U4uCPliy3S0FqnxP50D54gFd+4itGjHRP2lld4o3U4WqbgaBRVepNa4xTB1TPiP0Fyl
	o6PjIfz4JOpLL2GWc4FXQes9UkH/g5gUR1I2L8k27eQ7U5U+5PvUwOqBRAh1rXbKauhligAjLRQ
	nilE+AiCFQ66ISgkkOOVnEmvaL4vFTLbB/PYHC90wk5KcUjCek0v5oMcxKixF599VV+cdY/9BwU
	TzBlHBaM8UqjwH3k0KNZGqp4izK8RXZLP7TjbxB27wL4AcC1JNmchOHHOjzBnYGEGfOhlTa53I/
	9WFHcQSAPTths4a+L
X-Google-Smtp-Source: AGHT+IHQNtPcwcTbkL3ozNLpTAgid4LRiOvA4DfqxExbFGHGGPBuOQdhi6WkcEySpIVWuP72t6SU0w==
X-Received: by 2002:a05:6871:b13:b0:2a3:c59f:4cba with SMTP id 586e51a60fabf-2c848018e3emr679398fac.17.1743023195608;
        Wed, 26 Mar 2025 14:06:35 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c78b6cc741sm3034713fac.21.2025.03.26.14.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:06:35 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: remo@buenzli.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andriy.shevchenko@linux.intel.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	devicetree@vger.kernel.org,
	dirk.behme@de.bosch.com,
	djrscally@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	rust-for-linux@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	saravanak@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com
Subject: Re: [PATCH 07/10] rust: Add arrayvec
Date: Wed, 26 Mar 2025 16:06:15 -0500
Message-ID: <20250326210615.696266-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326171411.590681-8-remo@buenzli.dev>
References: <20250326171411.590681-8-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 26, 2025 at 12:13 PM Remo Senekowitsch Wrote: 
> +pub struct ArrayVec<const N: usize, T> {
> +    array: [core::mem::MaybeUninit<T>; N],
> +    len: usize,
> +}

I would reverse the order of the generic arguments so T is first so
that it matches the declaration of an array: [T; N] 

> +    /// Adds a new element to the end of the vector.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if the vector is already full.
> +    pub fn push(&mut self, elem: T) {
> +        if self.len == N {
> +            panic!("OOM")
> +        }
> +        self.array[self.len] = MaybeUninit::new(elem);
> +        self.len += 1;
> +    }

This function should not panic. I would rewrite it so that its signature is
pub fn push(&mut self, elem: T) -> Result<(), T>

> +impl<const N: usize, T> AsRef<[T]> for ArrayVec<N, T> {
> +    fn as_ref(&self) -> &[T] {
> +        // SAFETY: As per the type invariant, all elements at index < self.len
> +        // are initialized.
> +        unsafe { core::mem::transmute(&self.array[..self.len]) }
> +    }
> +}
> +
> +impl<const N: usize, T> AsMut<[T]> for ArrayVec<N, T> {
> +    fn as_mut(&mut self) -> &mut [T] {
> +        // SAFETY: As per the type invariant, all elements at index < self.len
> +        // are initialized.
> +        unsafe { core::mem::transmute(&mut self.array[..self.len]) }
> +    }
> +}

I would replace both uses of transmute here with slice::from_raw_parts
like you did in drop. 

also it's not needed but you could also impl Deref and DerefMut for ArrayVec
because you have already impl'ed AsRef and AsMut so it should be simple

> +impl<const N: usize, T> Drop for ArrayVec<N, T> {
> +    fn drop(&mut self) {
> +        unsafe {

this is missing a safety comment

> +            let slice: &mut [T] =
> +                core::slice::from_raw_parts_mut(self.array.as_mut_ptr().cast(), self.len);
> +            core::ptr::drop_in_place(slice);
> +        }
> +    }
> +}

Andrew


