Return-Path: <linux-acpi+bounces-13061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA4A8A64C
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 20:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8183F3B913B
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952422333B;
	Tue, 15 Apr 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLywB/q+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49107220694;
	Tue, 15 Apr 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740302; cv=none; b=sOt/YgfLkhnlKmP2YS+SdKGAdUk4sQmf49fvKgsXEF8GYeAp5mVYzAaeQ2vMwbNBFAMFUYaq8MAF+7fVkZ4h3B2ekRtXEfgPzE1jRSdWrtDsEKVabsP39eh4toINV62gGAOfYuJdZMDrH9lqoUPInY4ItYQUu8oltP5F6Z+HNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740302; c=relaxed/simple;
	bh=bSIH+zqpDkmwA6RNwqFHsidqqNTR1psChK3N90ojLYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8pWRICgv9LD1BUwRItbMacNRhdrWXmagM5TSHd2u/CWmjNs2IeotQUAWgxQJiJQLbqjGRlI+qRiwf4fVDOYXbCvtnFqYs80qwPvjCqfiGctf+XGOVB4o/nOdQiFDrB/O7NMk2F4R5s9AqsRxfpS68GUhj6tswFtC6uS+P6el4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLywB/q+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so40587095e9.0;
        Tue, 15 Apr 2025 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740299; x=1745345099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAA5GsUBd1AyUaSODfHnhDVrxDoRhK+SaJ6cRkLQ9hE=;
        b=nLywB/q+OeO9uyblyqIsVITy4s1BDrGMNH7wU1xlJ4u0+IAqV96hwKU4Oyjn524+c2
         jwvXOMkfZ4guryI97B1ggYVm9816gyZ4oKmZhD16UhvoH1GoH8aM5ZMVkCLEByytYZWD
         lONzKkJAgHyJAl8Kr480CTHVdx5LYFAtGoePEmN0adGWOWS64fcxVD+4oQRGuvxYMutP
         kNsMFzcVbNP59sZllw23B0/f5GyLCXKF9uq4Z8AkuusA7BTdn2iG3yvzM0aoimhIJTT3
         V9It1T/RxlIQwSrwGB9BeLcQnYcD1q/MpvFsfI7QiYKFnNdonKhEJ8SuWMR/eIt7oBE5
         3k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740299; x=1745345099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAA5GsUBd1AyUaSODfHnhDVrxDoRhK+SaJ6cRkLQ9hE=;
        b=XJTFP3VkrTWoK/ffJ2pB5dS3PhdDOxrzGHpp0/Uva2Hd3G9QWfgNEx9Yitk/AG1JzR
         c/DOuFjc6ecUAWkNYXUf1oEX9yc4BEUwksXhpxtz4Whbu7mKZ43cyCLI5PJPN4pBqQT/
         JktSE31SsT3a4P7CnnKS4eXcLjZQTABV+Ep+gbiDI0CbOX//kc1d+wLZxMea40w9YZqr
         boHrhy3mvWjGB3I45xeiO68VZOY6YcnUddHgg8272HWDKMCPnMDeOv/VzJg0NGif1hf/
         wPFAi98yL6nqQpKa1mIVnTOKaPaWJ56fAqzzxiubYtN+KxkSQzfeYMr75CxxRle5khf4
         ymgg==
X-Forwarded-Encrypted: i=1; AJvYcCVq7ZXeKi87Y2HPc7KEhhK+7FnVgPo9GoNTbGspsVCpYO4a23XPqTVXKIEFC65i79NGz0lRuwHQNM1elwYF@vger.kernel.org, AJvYcCXTEkVMz6lDCmUdbhKeQufo7ZdIFz6c58aHats27AoZFmg6t+gx+SqGG47oP03yoT1Ca4VbEsepFipa@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3f/CT3RHHs7qrP22PP2YYFY9b0A1/G16GH8FKqSBfLEhXrR/
	cTloWL0Bm0dOeGJLI8FRTKFQhbUgTXwdqhiTk/ERJgmtCiXMWrxFRPmkpQ==
X-Gm-Gg: ASbGncuJAga/Sj5bF9mrNiWf+vsMv2EZUjz63E3R5gPMUOOclKffm0Ky9/nnI1Cklu8
	BW+80CApQ/nHcPuhRcNHiHJrjEBn3poXDxQWmZnM1KTsOcPQ247VedMDcl4pD8KmrUNnEw0WRRq
	jYU4KIRB/FtPX3rFGrv6qbmBqBGNkVvSVUp7Hep0DPk7mk/Kwfui3jnbWkL/T3qeEnm1yqODCSk
	PrMKrdQ9HTPy1vsIesQGZQJMn0IeFJPFva+RvvU7+VdZ1Of0aWiPg6ri51fL7kT5YbF60eXQkyU
	fkOWxxMP1vNepyY+3gN5nn9LWIC9EEiO3nY1779O9IkZyyf+7wTKVZGo9yELDDvzQBY8XFanh3r
	9rKg=
X-Google-Smtp-Source: AGHT+IFc3g8QQ9k9lgukZ0sd7DIp2WxsNbtPZklAM2PLk9fBgcH1wwc0A6XRSO71CM8ag9ErKBZWTA==
X-Received: by 2002:a05:600c:1f8d:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-4405a0064d6mr892895e9.12.1744740299439;
        Tue, 15 Apr 2025 11:04:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d6e8sm225626635e9.23.2025.04.15.11.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:04:58 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:04:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <20250415190457.351e22a1@pumpkin>
In-Reply-To: <20250414161644.30400-1-listout@listout.xyz>
References: <20250414161644.30400-1-listout@listout.xyz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 21:46:42 +0530
Brahmajit Das <brahmajit.xyz@gmail.com> wrote:

> Since the Linux kernel initializes many non-C-string char arrays with
> literals. While it would be possible to convert initializers from:
>    { "BOOP", ... }
> to something like:
>    { { 'B', 'O', 'O', 'P' }, ... }
> that is annoying.
> Making -Wunterminated-string-initialization stay silent about char
> arrays marked with nonstring would be much better.
...
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 6f4fe47c955b..d2cda1b35e59 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
>   * expected_return_btypes - Allowed type(s) for the return value
>   */
>  struct acpi_name_info {
> -	char name[ACPI_NAMESEG_SIZE];
> +	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));

Doesn't than generate an 'unknown attribute' error on older compilers?

Does:
	typedef char char_nonstring __attribute__((nonstring));
	char_nonstring name[4] = "abcd";
work?

If so the attribute could even be applied to 'u8'.

	David

