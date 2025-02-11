Return-Path: <linux-acpi+bounces-10998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94CAA303C5
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 07:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120E11888864
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 06:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CDB1E9B17;
	Tue, 11 Feb 2025 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ugolflmu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9BB17580
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256335; cv=none; b=CHShvqrUDfyd7fs/jchPb4bzUCH7gsKvgszlP+IJhw/zHt7Aa16s7MK7rniDJiirvTgmAV504E48FnxiWlE0cOYFxA4cWEuN5FD1kw7vax45j5RcdwAnfOtlvN7gs6wvcV6MwV+DF3U2w8Ci/8xiDhxWbD+6D1pnfmQhaMKw+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256335; c=relaxed/simple;
	bh=nVfG0++mT1ID/WJVtPd975t5UPGFo2kbmky6L/bL4xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCnXUyeNydAqzRzv1BJOsIxAN1HO/EVnrvoMJj6AFUZBgrFys54ynRABP1wt2Gc65UXcyAtaE0KytCsAubLbbnhz4oZtAVj4WSAL57c4tl3XeEt0gZfvfw+T+ZUOXSO98DFwGQ7QtRSOnx2TCLLNEjdNRl7h4pmDA4U5NAdHoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ugolflmu; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4ba9680271fso2140841137.1
        for <linux-acpi@vger.kernel.org>; Mon, 10 Feb 2025 22:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739256332; x=1739861132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1QiFCUT3qvEQvHwez3VPpjFS/OoBwVp/3j9UJxOxrlI=;
        b=UgolflmuQBP0lJQq/x0bG/yRl6xEGSnrQt/HkVI078Z0b5HRB2CexuUv3JLe1xQS9Q
         +Gzelmm7gf6Cjsr2hC7tXcB88DxU5L5JsnamRkOrInEOem7vgex2hWgR0+mAn4JtVzHc
         EXlZRkTFq6gCYBX/CPGu66ylQIkQvKGFHrk+xwFNIYPZ/5KChcOuAm6ou0QXRrmIijd4
         e+OqQ80CoeLg10nqSmxPY3Cf7HlRMNCxHClyc+Xn0uC8v30NIMURHxx8zq/dYXNFXb73
         i9ohCT+/q7uOvYvtk03+Rqn7adhLosTa/Hl4ETDgpkZKOIx6ZhZ2RnIxbHECUbjnHkcQ
         F2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739256332; x=1739861132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QiFCUT3qvEQvHwez3VPpjFS/OoBwVp/3j9UJxOxrlI=;
        b=XZFfzcpi6Fbwag7FoNKjBi9muNO5e9+3JHki7mkvyOzIxiw1etTMlJ6EGh1TJrrvN8
         tCzkrixqDR0n+LHCpGlcUVILVROTSoYm7TDhUO1iHth2uepxNMsiBmgUaSZpOad7Sh1/
         CQlsfYSpVwy2IRcLKB1Cl6ouxribTS0bgx9G3p5uBTZURLD+H8isBy7xr6mFRJmgXyi/
         IfKrDnqsafGPIgT1ltj5octo41TxxHPEwy8AGEGNuiyEVtobKin52dHuv4Xy3XT7fkos
         FeFF4HM+azAQusXl9vDVOzQoQurgucWToLG6Je6ZNADyTeZUuskGWI1XknMliBxaNWBn
         AoCw==
X-Forwarded-Encrypted: i=1; AJvYcCXzs+DVc8Zte+SlFUw2J+DY3yBu0Zos659WutNHWYr67vf0p5bnBcu4W8Or6+560ulXOJtMh5jDUetM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+A2PGSEiRjAe/LCBhe7Ra2u1r5flq+LV7YWJ37POu3+hFyiUp
	wRcgAOdPVjSMcRaKVEO3+ZgLE43Pc770udo+xWZRUmbJgUGi7ZwCK4W+lwvZjAOkJ4uRTxu8EgS
	afyLZbaqRF/TEJSHvE1fsD6+Wu98PLwpy1pYjVA==
X-Gm-Gg: ASbGnctXtXWbaAMs21POEJzyZAqHDe5XHvtpJGchX/COQJFRyPy0SkXZhvks0GBzkDw
	rvhu+WMYCEqK2NVcLlvxdaxa332tCXmYecYWX227Vvz9isCPM4PeMt2Dvy9X5cazao7+fOq3n+F
	s=
X-Google-Smtp-Source: AGHT+IHraUWItx7lyhs3RGJc1hMUxbfl9W9qX1eehSk1rDY3s6SNEwm4KmyNFqY9duS3Ua0mf2EDxT5evKNmccbGxaE=
X-Received: by 2002:a05:6102:2acf:b0:4bb:41c0:ea63 with SMTP id
 ada2fe7eead31-4bbe13bc505mr1500286137.8.1739256331732; Mon, 10 Feb 2025
 22:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210232227.97761-1-stuart.yoder@arm.com>
In-Reply-To: <20250210232227.97761-1-stuart.yoder@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 11 Feb 2025 12:15:20 +0530
X-Gm-Features: AWEUYZmss9mgyyi4uduffWjEUtPdHOzBfArVxLUXxchfgmNTaYDr5MANoP7oRrI
Message-ID: <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ Jens

Hi Stuart,

On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
> These patches add support for the CRB FF-A start method defined
> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
> (https://developer.arm.com/documentation/den0138/latest/)

Nice to have a specification standardizing interface to TPM
managed/implemented by the firmware. Care to add corresponding kernel
documentation under Documentation/security/tpm/.

BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
possibilities for an abstraction layer on top of communication channel
based on either FF-A or TEE or platform bus?

>
> FF-A is a messaging framework for Arm-based systems and in the
> context of the TPM driver is used to signal 'start' to a CRB-based
> TPM service which is hosted in an FF-A secure partition running in
> TrustZone.

Is there any open source implementation for such a secure partition
managing the TPM? Also, is that really a discrete TPM or firmware TPM
managed by the firmware?

If it supports firmware TPM, I would be interested to see how you plan
to handle cases related to secure storage.

-Sumit

>
> The first patch adds an FF-A driver to handle the FF-A messaging when
> communicating with a CRB-based TPM secure partition built on FF-A.
> The driver is probed when the TPM secure partition is discovered by
> the Linux FF-A infrastructure.
>
> The second patch consolidates the check for idle support in the CRB
> driver to one place.
>
> The third patch defines the new ACPI start method enumeration for
> CRB over FF-A.
>
> The fourth patch adds support for the FF-A ACPI start method to
> the TPM crb driver.
>
> Stuart Yoder (4):
>   tpm_crb: implement driver compliant to CRB over FF-A
>   tpm_crb: refactor check for idle support into TPM into inline function
>   ACPICA: add start method for Arm FF-A
>   tpm_crb: add support for the Arm FF-A start method
>
>  drivers/char/tpm/Kconfig   |   9 ++
>  drivers/char/tpm/Makefile  |   1 +
>  drivers/char/tpm/ffa_crb.c | 310 +++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/ffa_crb.h |  30 ++++
>  drivers/char/tpm/tpm_crb.c |  81 +++++++++-
>  include/acpi/actbl3.h      |   1 +
>  6 files changed, 426 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/char/tpm/ffa_crb.c
>  create mode 100644 drivers/char/tpm/ffa_crb.h
>
> --
> 2.34.1
>
>

