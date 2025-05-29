Return-Path: <linux-acpi+bounces-13939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D131DAC8008
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9316C500A1F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D71DF97D;
	Thu, 29 May 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBeeO4K1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE84C81;
	Thu, 29 May 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531750; cv=none; b=UttgWwULYMPJsYdT58EBf86e8+eQfOSz/aEKAFYDfKNv78cVadHSnQKjMtocNGVhUMDryHjSdLwY5oPfHQJkwpTD1i+M1w3jpv4/FhXhvm+iE3nidrkONprbxmloeM2Rbj92/bK3X7zJm7pB3VP3DN+eWkB3t1689odRXxQdK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531750; c=relaxed/simple;
	bh=Uhk3T7EyWZLH5y0pN9TV2Tis+WwYAPNYN9H9nBJx/D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tManPb/rDuP7klPv4gh06+pwKdQjws9pmeM7uklN96DhZg5E7y7TIlGZWTIxVk0fqOerhYXjQFKpadNxJJryF60eX9rVMdJ9IFlVBYeW+PW3vnFA9SvYqW+VDCaxln4t0e3xfQ3as/fQJLttGJx0+Oq1S59ESQGyfA9VVn0Pbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBeeO4K1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so1522786a12.3;
        Thu, 29 May 2025 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748531747; x=1749136547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTkAIW/6lmJFonkNX2b2ofjEkiWveEqAyenO1Dk8Bmg=;
        b=OBeeO4K1CUY6wUG7SMBDsLLowqOqrIkJesBKOdfcuTN94LYd9PthnfGAKrpoOuDX7B
         ky3i83LKJEWWVBXOUwR7guwDHTDgDLIn3PEHFKkGTbLGaoV7m0JNocLEfGFzmbzxabiK
         WN09ZNFPOwu/1rYX5mcpSkmDUwXd/Te75f+IfjZW7+La8moMPWoAmwyeCLb0dCbYDpFJ
         L1L9PsGTxAXiAdBvUNz6RH3txmZ0dKtUJGEIJU8XoVKZoauf9di88HRPGELMFM/uHM3X
         FFCf9UIatQOkcjgGBu7x582EBO0oF9URtyBc+72xVy6l6f4dXjGzD8EcGhZvhVheFD+Z
         PQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748531747; x=1749136547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTkAIW/6lmJFonkNX2b2ofjEkiWveEqAyenO1Dk8Bmg=;
        b=gjzNEWJZTv/9/CMwcGKDNwZZ3y88VgzwOBuIrS6D2eeCvOzQDkoLZ3Bb7t/53yMxDV
         Z1r6Gu2GpaHkpgvUTnUKujnbHbzORn3aFetRiXR5nEeQE3/5FKn8JIcgBGb01oMsq6oH
         jZLEI3UqTQCNyb0uV/m8MAERDdPfx9X2XhgrK2x+Fp1xZ0YgQBh3At4GqV1V5g9CSqO5
         WKd4MPE2aTQGDNI+P7sFdfp+VmnDDu5H4cHu3QOZ2ZGujhUWDRmg6JH5h+/Jb2G13yXl
         I6aoymHiOpQ3tq8tbjYLP3Yb6iYniKJKOE/RPNfHABAf9XAIk66ucN4eSy+4pVU7yxqN
         vjyg==
X-Forwarded-Encrypted: i=1; AJvYcCUT04B1b4RLgOWYaqARKIPhqu3amvdxJNQ2BpAuYn9wqv07+qt8gtyguMsV8crTRDD6bOQ/nNYX8Yxo@vger.kernel.org, AJvYcCX9SQ+7+1ywikFWwurCASdb4KZ5olOktCgY3cY7xQ979h3/kgHKUijq2jx3VebZHmKFMg9lO23tYCGSEVES@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1eRRH/UDUHOAeV+JXaf3jf3Sb1oHhHHSVGIRBwl4/VwhN4Gp3
	6Nlx13YvErP3UbCqlMVj8mnViFpj8WZfmmYVLsyNz4IIK+iuyOHni5nmhoiQZ+xH
X-Gm-Gg: ASbGncthcemOWzJFqO0Hs8pO9NFMjMQROhxkfTo0glJv7zvRapy3x1waYgjc0Ki2mQ8
	rJOr4/ZZigmrVeOPoQP6IZrCxIcv3Xf5zMS4fubDKvQXhiGdjHZqPOwj86dag/GOX+DZDUyj6mx
	dSXu7lo/auESWD0vq4iFT9Enc+V2asRiQxayAlUINzg3c9EXGxdcPqc2eAouyOCRkqKQVqhTzuW
	mtCg4ni4Do/vKBpGjxcEZ2u13TOrSZ2rLu+STbJyKtG5PVO8k8VGUjHBmnH97+gNGM9Ah3b9G3V
	Gv4YkbNZb3dVt9ucXMqhJU3VEOCpiDCimQrFVO7n
X-Google-Smtp-Source: AGHT+IH6pz5NE67O+phUiKSggfajm1RVZ68gh/bUuk5xpUB8OAsUvcmP9ACXn7pg4rELTX81X8arzg==
X-Received: by 2002:a05:6402:3582:b0:5fc:f:7316 with SMTP id 4fb4d7f45d1cf-60545ee974fmr2249622a12.7.1748531746487;
        Thu, 29 May 2025 08:15:46 -0700 (PDT)
Received: from localhost ([95.85.21.11])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60567143860sm108557a12.57.2025.05.29.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 08:15:45 -0700 (PDT)
Date: Thu, 29 May 2025 18:15:43 +0300
From: Ahmed Salem <x0rw3ll@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: 6.16-rc0/regression/bisected - commit ebf27765421c introduced a
 new warning KASAN: global-out-of-bounds in acpi_ut_safe_strncpy+0x1b
Message-ID: <vkrdaqakxid6b4cmeknygxxstx2zerzuarryzwl66unce7jwe3@hbrlelzs4p7v>
References: <CABXGCsOCGWeZgzsXwSSOFqNxetsJhRbvqHCSG1iuQ7jMuFdo8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOCGWeZgzsXwSSOFqNxetsJhRbvqHCSG1iuQ7jMuFdo8g@mail.gmail.com>

Hi Mike,

On 25/05/29 07:17PM, Mikhail Gavrilov wrote:
> Hi,
> 
> Yesterday, after booting fresh kernel feacb1774bd5,
> I spotted a new error message in the kernel log with the following stack trace:
> 
> [    3.032828] ==================================================================
> [    3.032832] BUG: KASAN: global-out-of-bounds in
> acpi_ut_safe_strncpy+0x1b/0x60
> [    3.032839] Read of size 16 at addr ffffffffa9d32760 by task swapper/0/1
> 
> [    3.032846] CPU: 16 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.15.0-feacb1774bd5+ #2 PREEMPT(lazy)
> [    3.032849] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 3222 03/05/2025
[snip]
> git blame says the first bad commit is ebf27765421c:

That is correct. This was a very shortsighted and uninformed commit on
my part, and we had this very same discussion on upstream ACPICA. Kernel
test robot also reported the same issue earlier[1].

The issue was that I mistakenly switched to `memcpy` in the
`acpi_ut_safe_strncpy` function in drivers/acpi/acpica/utnonansi.c, which
would have caused the buffer to be terminated one byte shorter than it
should really be. It's been rectified since, and should be pulled back
into mainline once it's cleared. I do apologize for the massive
inconvenience!

Rafael, is there a possibility this upstream commit[2] gets pulled into
mainline before the next cycle?

Link:
https://lore.kernel.org/oe-lkp/202505081033.50e45ff4-lkp@intel.com/ [1]
Link:
https://github.com/acpica/acpica/pull/1024/commits/b90d0d65ec97ff8279ad826f4102e0d31c5f662a
[2]

> 
> commit ebf27765421c9238b7835d32a95e4a7fb8db26a4
> Author: Ahmed Salem <x0rw3ll@gmail.com>
> Date:   Fri Apr 25 21:32:12 2025 +0200
> 
>     ACPICA: Replace strncpy() with memcpy()
> 
>     ACPICA commit 83019b471e1902151e67c588014ba2d09fa099a3
> 
>     strncpy() is deprecated for NUL-terminated destination buffers[1].
> 
>     Use memcpy() for length-bounded destinations.
> 
>     Link: https://github.com/KSPP/linux/issues/90 [1]
>     Link: https://github.com/acpica/acpica/commit/83019b47
>     Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Link: https://patch.msgid.link/1910878.atdPhlSkOF@rjwysocki.net
[snip]
>  drivers/acpi/acpica/utnonansi.c | 2 +-
> 
> And yes, I can confirm this catch.
> The kernel with ebf27765421c reverted no longer triggers this error message.
> 
> > sh /usr/src/kernels/6.16.0-0.rc0.250528gfeacb1774bd5.5.fc43.x86_64+debug/scripts/faddr2line /lib/debug/lib/modules/6.16.0-0.rc0.250528gfeacb1774bd5.5.fc43.x86_64+debug/vmlinux acpi_ut_safe_strncpy+0x1b
> acpi_ut_safe_strncpy+0x1b/0x60:
> acpi_ut_safe_strncpy at drivers/acpi/acpica/utnonansi.c:172
> 
> Ahmed, Let me know if you need further logs or help reproducing.

Thank you so much! No further action's needed on your part, and I
appreciate your effort, sincerely!

--
Best regards,
Ahmed Salem
> 
> Full hardware specs are here:
> https://linux-hardware.org/?probe=1244406425
> 
> I’m also attaching build config, full bisect logs, and kernel logs
> from each bisect step in archives.
> 
> -- 
> Best Regards,
> Mike Gavrilov.



