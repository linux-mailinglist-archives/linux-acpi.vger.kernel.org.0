Return-Path: <linux-acpi+bounces-10873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C2A24A50
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Feb 2025 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E084188400D
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Feb 2025 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47411C3C1F;
	Sat,  1 Feb 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n931ZUyu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AA10E0;
	Sat,  1 Feb 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427010; cv=none; b=YF4MDP31eGiTHOh114qas/R+0Wu4RRlV6oetp3NgoOFooV+I0UyBH7F6sJSTuJBMGZtxTtILXv1dM0TZm9fBVtHRmIfIqI8qkSKgEFKXMDZpsG0ebbGAyO+MOWdCYxmgP0qBmjKUhSDlU46/Sy9YlaohwNwpY3aGbrwGcXYBKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427010; c=relaxed/simple;
	bh=kwipPyfK3HoDWC6AAXBjngIEgCA1V9KvjUcUqi1M34U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXsoSG5M7Ioq57pXmHEvU9SNxvshlqXF0dESDS5tGczs3gQZoyafSjiSZsTSZji4DC+Et8Wbv5HAcheGyBcR1xnGcJ6aCbLJOLfLHAOyxqUedALTXxC/0/udZQ86yhJivVQbUjlp/PDjx9SX4L+fCd4h9sw0t5GhHV16IlKxzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n931ZUyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3391C4CEDF;
	Sat,  1 Feb 2025 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738427009;
	bh=kwipPyfK3HoDWC6AAXBjngIEgCA1V9KvjUcUqi1M34U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n931ZUyuqlrjQED2SaettUYLKaYRXzMZjXk6i26oMKCf7sdnldtVa0k0S85Ml6Liy
	 iFkeGA5qfntsVl0Khvoqzpwf74spDtOsOR8fA7mx+nWN99cw1et45h9K8XaT9i78W8
	 WWz7ceG64ln0XrEsW4RfmpV0jLNbNuF43rj7aXjCI5837cF0iynFSgK0nAN2Ubuyyp
	 NveeM8E92To5dwkQEif/ASrMmxyl/RCJm+HrGKPvZIJxxsO7JYJvcecFRD0P2gNpVx
	 X4X/cvXF0qEOXEeCYmjtb1phiv6zExp8tVlf4W+AAQ+b6dh/db7OWZJXd8GsuTGMfL
	 KI8Mcm8WtS8Mg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-304e4562516so29698361fa.1;
        Sat, 01 Feb 2025 08:23:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDz/RG0C7T4BHOI4RHhKmuY3RNPXgW+8Spoi0e7aOuJCGIkWV5NHIRD5Fq7btHGV0u+vvYNUXrdo+L7Tc+@vger.kernel.org, AJvYcCVEFarClHpXChI2JOnBbDD4Qm8qxVF1T1at7aUuxvxeqkihBEbLwNywDskVvCJbpQdgG4MTOzpYW6kY@vger.kernel.org, AJvYcCVTheELs93WEVY9SQeH3J51xx0VMVMJsEAXqjtMZ3R4iCOamCqsJ44I44E1vw+86oZ1yrZ/vPCs@vger.kernel.org
X-Gm-Message-State: AOJu0YygKMdNUAibtjUq5AquNSD3a7VaLTL7hzlZgQGuy0GHsQVdS3Q0
	tskztmd9/zzUap8+m0Sc34tPwxHzCD/mYQ7Qw0L9OzJRcPBOJtxJKKNiD9iDnHLDTgTHjZ+BAgJ
	imPKRSHWUQ2LVP5o8K7RBal2pFho=
X-Google-Smtp-Source: AGHT+IFMfMB8vBEC0C9cAzXloaprOzJlFYB2xJPiWh3MdYBNHAaVlrKqVDmZAsWyTnGtmIvySx9PxMwq7nBSAei0Bg4=
X-Received: by 2002:a2e:8198:0:b0:2ff:c167:a965 with SMTP id
 38308e7fff4ca-307aa3a75c3mr22576891fa.8.1738427008222; Sat, 01 Feb 2025
 08:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126022250.3014210-1-aubrey.li@linux.intel.com>
In-Reply-To: <20250126022250.3014210-1-aubrey.li@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 1 Feb 2025 17:23:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEe_Foz2G4GbdZtbaB9azHoBOW_E97wgTXoNAcZSykwaw@mail.gmail.com>
X-Gm-Features: AWEUYZlBWrtjvul20UguN8NO_lzgoCKW_e_upM-KPT7iH855u7GoVsDbRjJtX4g
Message-ID: <CAMj1kXEe_Foz2G4GbdZtbaB9azHoBOW_E97wgTXoNAcZSykwaw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Remove unnecessary strict handler address checks
To: Aubrey Li <aubrey.li@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Koba Ko <kobak@nvidia.com>, "Matthew R . Ochs" <mochs@nvidia.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shi Liu <aurelianliu@tencent.com>, 
	All applicable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jan 2025 at 03:08, Aubrey Li <aubrey.li@linux.intel.com> wrote:
>
> Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
> handler and context") added unnecessary strict handler address checks,
> caused the PRM module to fail in translating memory error addresses.
>
> Both static data buffer address and acpi parameter buffer address may
> be NULL if they are not needed, as described in section 4.1.2 PRM Handler
> Information Structure of Platform Runtime Mechanism specification [1].
>
> Here are two examples from real hardware:
>
> ----PRMT.dsl----
>
> - staic data address is not used
> [10Ch 0268   2]                     Revision : 0000
> [10Eh 0270   2]                       Length : 002C
> [110h 0272  16]                 Handler GUID : F6A58D47-E04F-4F5A-86B8-2A50D4AA109B
> [120h 0288   8]              Handler address : 0000000065CE51F4
> [128h 0296   8]           Satic Data Address : 0000000000000000
> [130h 0304   8]       ACPI Parameter Address : 000000006522A718
>
> - ACPI parameter address is not used
> [1B0h 0432   2]                     Revision : 0000
> [1B2h 0434   2]                       Length : 002C
> [1B4h 0436  16]                 Handler GUID : 657E8AE6-A8FC-4877-BB28-42E7DE1899A5
> [1C4h 0452   8]              Handler address : 0000000065C567C8
> [1CCh 0460   8]           Satic Data Address : 000000006113FB98
> [1D4h 0468   8]       ACPI Parameter Address : 0000000000000000
>
> Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context")
> Reported-and-tested-by: Shi Liu <aurelianliu@tencent.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]
> ---
>  drivers/acpi/prmt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 747f83f7114d..e549914a636c 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -287,9 +287,7 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>                 if (!handler || !module)
>                         goto invalid_guid;
>
> -               if (!handler->handler_addr ||
> -                   !handler->static_data_buffer_addr ||
> -                   !handler->acpi_param_buffer_addr) {
> +               if (!handler->handler_addr) {
>                         buffer->prm_status = PRM_HANDLER_ERROR;
>                         return AE_OK;
>                 }
> --
> 2.34.1
>

