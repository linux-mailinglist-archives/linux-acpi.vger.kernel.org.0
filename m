Return-Path: <linux-acpi+bounces-12459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86088A7204A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6BE18978E3
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D6025E833;
	Wed, 26 Mar 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2BHT/sS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8C1A2541;
	Wed, 26 Mar 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022741; cv=none; b=PJER/dooEzHcJGmJr92yCQrn6zffMV3UODclhwpHGr7MBNGxpjlODq5Ba4PatL0BcrjOza2G9FZaB3pU6sfgraXK+e5b+NXXaiH6Yx22ipEd0lexPxEn2HmgV/GvhSwS6zIbgV6/Zgyuh4HZ1pJ8tCPf+rWt7erVF9jCb80lzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022741; c=relaxed/simple;
	bh=e+GGi5UAmM6CVgxPTUQNBJPDl18un1EucT6xzYFlgk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1bohUCaEO7zHlhJPwNBAnpAKCiHh5w8LtpM6ubqSteewL8ovQefpl7jUapLpUa9zGYYn7TCrE32HxF0iSya9/8ds21Fs1lEQ4xsYDcAOu+qxaKGZYZAGFaLhswVHKbWZpFolnuDKUIGCJUXpJpSz8VDFHmnt0HVjpjl/V2FVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2BHT/sS; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72bb9725de1so94831a34.2;
        Wed, 26 Mar 2025 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743022739; x=1743627539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXN/ZGcBHJP5iRy6/nH6o1Y5X0gNKUlaCg+l1e82JK0=;
        b=G2BHT/sS9m/tb21oAhS691GPACCGIyUgJtW8/zMXiGjnleEgN+kvPJLu8OgekQdeNL
         ikLgzd2jeMvtS0AsjcmXffj15NlGqUHSyrn8u8GMpdme4Q0E7weLqpMkaf5x2wQhnZGJ
         3EwNf/FaZ2X3xumS7y7EMN87w80bEUIbc0/Wn9iDco5q5XwpwGj8FwAlb4sfGGpNrdHx
         0Yx7t8ZobHzfZP2grMOT8PyfE+/iWrRreenK4KPwyITq6xR5AZgaqA/1Xa2q0h+PeLER
         HzPWbP9aIxS5BlvmWD8rL7EpTi3YeKvJiKAGXiKjUWagvLJMIgKoqfPAYKXYSj76VHSL
         1/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022739; x=1743627539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXN/ZGcBHJP5iRy6/nH6o1Y5X0gNKUlaCg+l1e82JK0=;
        b=TKg+ODP6EXxLKkWQi49D+UtJOuSvPCqGuerdBT64ztxTnINX8nbB8zm63bIXXOUPhw
         U/RWQUnM9TSdkl9rW1D/9N3LmrF6F8Joo0vx+Q+b4fa57tPcaB7kzkSBDn37U89Ccdcv
         jt4vxGAr+QZEHxvtTwkrExzX6FeJX8XJ7emFS0GULJspxXymaefVzQsp3UiG5JI/xdZ5
         nA/hNPnTbf4Hni0DgAsgnyXJQbLEaQkShmH81fK3h4II4p4jNXvKuPpmTMnpLuZcM3wx
         FpGJkr/vSyPOCmMBCBVqZXM2qnNceg5shQ+WBTREx5fTIJ1lpHE7fLcm5M3JqNMrtAsY
         d6QA==
X-Forwarded-Encrypted: i=1; AJvYcCVeykMmuwbfi+GCOSxYO2ADRyDQBdZGFp/IJwPGcZBWXczWyGxSO0XcwigVOjINaRpPIYw1rOs+9J9T/WOPsJA=@vger.kernel.org, AJvYcCWIaVpFbfiSQbi+6Ou70uPzHxGPIrQEP8M9RAvlzAQRbjBxGhsTDFmbDyEV50RadmDMCRwvb3Dzk0Qctw==@vger.kernel.org, AJvYcCXExLvJUdC6opEo6RNdOdLlo2Qvxl5oeRSr8VYuBLRjJcWVt5Pe1cdh2cDbbHkqJcwzw1Mnb4tQDssk@vger.kernel.org, AJvYcCXHX+2x3u+EvDiWl6nXtC1s7GG3Ko3hiBwYeSutLBx92eEO92sOCdG9UY1RbzFJ5IlKzD/2y4QSWTPkXAFa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IfS+8o43WwTFPSNfeAYwytOkZFy1jzhkz7YS+BKeZDYwNNe1
	+JG4CWAH3yasexHrhZw1/pexiSQNguQah6snfRHSgVNfOBGkamX9
X-Gm-Gg: ASbGncu0jnlhDT6Iz4umWGNeQ9TW2qfjrs3oHtZDUpRzTmjroivDxVlA6kPryRsyWAa
	0u7zO+7mb9P7KJ/FWfqdPOs2UNRN8RgyiurQVcuDB6yMyqxmoxZMQiyGHAv3oakLZ4IeoYhEeWa
	i8ZN8dvNWC974xkyd5nSCg9Mn3hPELibC1vqTUpgLfM9Xi8Z1CTmsgnYkoDznHJsIU0Jnafh13i
	suRxc5URpK3nz28SjuTvMUaQ79p7oh+nE7t6Vwm6VhlhYU5kv/LIoSKKzKs/GaZc8Rg/4mIn34K
	ecHDaCelMIRZ8Ub/hMTX1dUNCJxm6nfkLzvLGW9GJp18KIcLOIbeaCgeuMThb0LtvBJ4Hm17tRa
	NRnZHgtPEiJkHGWtH
X-Google-Smtp-Source: AGHT+IExZRuAc5UJfWGIbTEZTnqZsDFY3noP0suiYY1Ncy03PZIt5gv/Z9c/ftM829fSUbo+KHtRtw==
X-Received: by 2002:a05:6830:651a:b0:72b:9bb3:67cf with SMTP id 46e09a7af769-72c4c96f232mr1041730a34.9.1743022738446;
        Wed, 26 Mar 2025 13:58:58 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72c419ccf46sm553122a34.12.2025.03.26.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:58:58 -0700 (PDT)
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
	tmgross@umich.edu
Subject: Re: [PATCH 01/10] rust: Move property_present to property.rs
Date: Wed, 26 Mar 2025 15:58:38 -0500
Message-ID: <20250326205838.695261-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326171411.590681-2-remo@buenzli.dev>
References: <20250326171411.590681-2-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 26, 2025 at 12:13 PM Remo Senekowitsch Wrote: 
> +        // SAFETY: `fwnode_handle` is valid. Its lifetime is tied to `&self`. We
> +        // return a reference instead of an `ARef<FwNode>` because `dev_fwnode()`
> +        // doesn't increment the refcount.
> +        unsafe { &*fwnode_handle.cast() }


this safety comment should say why it is safe to cast from a
struct fwnode_handle* to a *const FwNode

Andrew

