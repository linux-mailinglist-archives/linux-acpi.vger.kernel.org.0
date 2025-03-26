Return-Path: <linux-acpi+bounces-12462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBDA72070
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8500C7A2989
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0C25E473;
	Wed, 26 Mar 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwVKtNKW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C249659;
	Wed, 26 Mar 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023277; cv=none; b=JfjNFy6CYXTyPwbAN1sYjt+Atk1mZJikuM3qHqEkbL9F/hg3y+aE3cuTzjLa74QcvZhUUoXd8retSlFKKUZkXqYBQvdcHgkJMvZEnWNmULYLaMIyeC8HXKahlcyNIvirkkv1eFMhpkplY8qN9POtez9yAYRxMjAGb5RV7Mc2g7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023277; c=relaxed/simple;
	bh=jmbqtD4LiwyaAg4ke+KGdaXaPri7TsWFk0ZUUjhHzmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKIZTfurqjgUork0HRfChdI03y7Ft1b2aAEuMoyOyYv8zH/L7BmfhoCmUFsG0jMtmcYVpUwokDQw1XxONcggJyjUdQLQlFxJnM3xYVoUmiGsm+2oatRXwJPazth17YX3ChYrrcnQaL2uLSEz2TiNiiUoBcvYH/TA76tBunxZxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwVKtNKW; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f6eaa017d0so167018b6e.0;
        Wed, 26 Mar 2025 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743023275; x=1743628075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9znL/gfjemJ+KXWcUzaQgpfYO6FdHTZCtOPGxnSFho=;
        b=mwVKtNKWy966RUgg97DCXdfDAVed6wIOYVxjEA0NHEyvnTRaMlDn3ge5aM9asbm7nD
         vBhWjGF4noTs7YJUt5jS2BkNmhshh2FlATn3h0t2K8H9YBGoZ/q3Qml3TawKfc4XWs8h
         7hb1TvqbBStwjO+bzz/Rt5SMCc3oZXT1vhG8z8TS2ZHTBQ0ZdQMqlxT2QpIlxgyN3WbI
         OQmqfugkOyXwO3Epw2uV68zroeWp8JRCI8EZ+zH3gXZRVhQDti7C9z7ZfIGdLGPuywXq
         iptXY4PrJOP6dIMzgXuFR47vl0D1eVMab5ygs3YBlz5S2kFFQLJJXGNb5ACPDGsS4yfy
         NFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023275; x=1743628075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9znL/gfjemJ+KXWcUzaQgpfYO6FdHTZCtOPGxnSFho=;
        b=GcKn9Rc9Uc3YcMJi454oqWF8LKAF4CSGVE757TyD4R7TT9YI2TIR1Kk8EAFMp37XZo
         919qGqaINlP+DTInDvJZeb4jHeEBatDwSZ0nhYU6+PwUTZfSpqW/3PZR6Q/QnghA/ld5
         ykb2U8yTt5w5z2P8Lrb0912Gf9Y0IVtHqeIHiDkske1aTrKxg3P5fNdDAx7lPLMdFbCf
         lngCpkCcmVAu+AK++MoUZ8cZ5XWYTZrYcCbSwRds5a4koXOjuwetlG6wuobeL3ZamSCd
         c9oZQUBcPXupOtnmxlOVQRCiqd3q3ythtHXTGDqJYbity7lB2qv6rRUNUgTOqZVQIn1j
         WTOw==
X-Forwarded-Encrypted: i=1; AJvYcCVF7FKpmIuwid7CI0MYWHdM+d+CnvF/IDtL8fRQueNJiGgE4CspbRrF3IkkOxHS+J75/GoVW6IyiBm7@vger.kernel.org, AJvYcCVVijhNI9thTjF8Lfgbo0BaSGwWmJCpNAcrQpzDqJy+MxHDjkQzUItynEyzgqWzj9RjwtvR59uaYku8Hg==@vger.kernel.org, AJvYcCVuOHeJxMxbmwSzyHNZ8HHDcK4/K6/6h1/WQMkVNSqOn3a4nox9JLu36lwPZtS5gUXR/Az5RsJhtkltTOyz4jc=@vger.kernel.org, AJvYcCW5JZnYMbRsjZVwPbiyxxEv577FQSnP7TbjTOU9UWXBxXrawMqUg8AT9oQP4b4ZxHaezbmLjAes3QE0/vVO@vger.kernel.org
X-Gm-Message-State: AOJu0YynhUeOMh6M73/FWNzKT4Qc7STVWRe+Y1hrc1bKtQKNbUnYfub0
	1KAM8CygyuEqe0ApELBjoQMk3cWBsj1RnOcmGDE31DZ5LnIHMtYg
X-Gm-Gg: ASbGnctBVYbBjYVFmuCgWwyZx8S5Mm3bpIXmmjA944vyeTKxRt+UP5fIhGqoiHFQbHa
	Vd1Xnf9tUEme22RmWa1yYNexhpfxDx8jreDN4euPR9SjTEkivc+npXkqqoAW9cf6u3DvDKnghWR
	w4VCHo2aW2Q2FclrmeoU60VcKwEFcMO/kCE76l3oWz+7oZlKD+qphQU0Qz0SBovBtQ7wg9HTECH
	ycxQXw1vsm8Sfrbn96EX4aC6JKHSYXSWfS0HWKepsLrMIQP55Ha2VI7T1QClDGe9OgS+EAF0B7o
	ENlD+hfVIi9WN9+Xw2/PTQ0UhaJelrmogaj8HWs5cGwfp4dZTVxGEbTwNThg2ZIX2UdX1cCbJl2
	6NiG7/4ydt+mvDcG6
X-Google-Smtp-Source: AGHT+IHGlSz2JhKYJ/vK1VoVPk1F9VLiFYz2AZWwMLdwOM6QUxtEq4lCiOjisnM3b7gChCZNmlPl0A==
X-Received: by 2002:a05:6808:6905:b0:3f9:cbc0:7420 with SMTP id 5614622812f47-3fefa5c263emr602333b6e.27.1743023274896;
        Wed, 26 Mar 2025 14:07:54 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60234783ac2sm1874282eaf.23.2025.03.26.14.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:07:54 -0700 (PDT)
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
Subject: Re: [PATCH 08/10] rust: property: Add property_get_reference_args
Date: Wed, 26 Mar 2025 16:07:35 -0500
Message-ID: <20250326210735.696416-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326171411.590681-9-remo@buenzli.dev>
References: <20250326171411.590681-9-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 26, 2025 at 12:13 PM Remo Senekowitsch Wrote: 
> +    pub fn property_get_reference_args(
> +        &self,
> +        prop: &CStr,
> +        nargs: NArgs<'_>,
> +        index: u32,
> +    ) -> Result<(
> +        ARef<Self>,
> +        ArrayVec<{ bindings::NR_FWNODE_REFERENCE_ARGS as usize }, u64>,
> +    )> {
> +        let mut out_args = bindings::fwnode_reference_args::default();
> +
> +        let (nargs_prop, nargs) = match nargs {
> +            NArgs::Prop(nargs_prop) => (nargs_prop.as_char_ptr(), 0),
> +            NArgs::N(nargs) => (ptr::null(), nargs),
> +        };
> +
> +        let ret = unsafe {
> +            bindings::fwnode_property_get_reference_args(
> +                self.0.get(),
> +                prop.as_char_ptr(),
> +                nargs_prop,
> +                nargs,
> +                index,
> +                &mut out_args,
> +            )
> +        };
> +        to_result(ret)?;
> +
> +        let node = unsafe { FwNode::from_raw(out_args.fwnode) };
> +        let mut args = ArrayVec::default();
> +
> +        for i in 0..out_args.nargs {
> +            args.push(out_args.args[i as usize]);
> +        }
> +
> +        Ok((node, args))
> +    }

This function is missing safety comments.

Andrew

