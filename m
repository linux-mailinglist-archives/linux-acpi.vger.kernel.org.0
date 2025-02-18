Return-Path: <linux-acpi+bounces-11266-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEDAA3A512
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B96B1891337
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455C826FDB6;
	Tue, 18 Feb 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXunfUpu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2E26FA66
	for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902586; cv=none; b=RPqZsj93obcSHO6thExEvXa792gOhYIsCIIJpQB0GcQaGDZgQN5IatM319cU5ql0bwVKgrkAxX4DcDh9FUVeVF+/7M2Kry5duTNSJG+virXkuqb5rRpEAgUYL+T1IbiM27zNHtpjuoYbY0VFEjTu2/uxBwCSMYcD3+VEXWSJLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902586; c=relaxed/simple;
	bh=qpHugEc7N7CQ0RXK0h8/NFBN8Xu/PqUEa+G6XLxXKcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCacercMBqxG8IlDycx21OXNA913bZYWvLMEHxSk3gpv3HbMkYArSUQ2zrygh/JsJTBP7eWjlcgfuxfE4eFE51QhxPoncRc808a9r/pmzpbETQVyqTsgY9OgM4knCCnUDzMnh0qzwj1YOpbcQbZV/nq6hWwDdPdC+XcD7hR17jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXunfUpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D91C4CEE8
	for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739902585;
	bh=qpHugEc7N7CQ0RXK0h8/NFBN8Xu/PqUEa+G6XLxXKcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oXunfUpuWws2PptoIN/CD9cGi3yIZ9ZSj71v2YybMIVXo5JiGiMJUDbEluLTanO+H
	 JibHOOmlMQHMI3TGASZxFqemoKg3JImkFz91x9EX2dvfUOkADn2nBLhZLg+x3W9fVS
	 03QXcLhALt2GP/OomSG7mzsVxR6BlHtO3Hi7djVgjgUA+j6bZ/8pksGx6iDU56l0f6
	 VyR10J858ZY1mN9+uZzRzDRvGJKCoaujDjq+vuwF5SVX6RT+xBppqFXwIFbV8CpJvH
	 lz1TFShrqvi3H+BcZzD/QrLDkZ0WRSdmyQrJYAKdPS3PnjSXPc6zdcoEWHM6BwgkA/
	 Pmz83BxNVAN7w==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72722d2717aso793617a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 10:16:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpl7jqMMagU6q/4IMEnCpD22wNuImkkcN1A6pLDv3ytYex2f1mdJ16eWMljTuhpr3bu9Ri6eolVoV5@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMPCJfT+e5BfqnukHMO9Ltkt2ghvqir+IETtae/RUq8Pk6Jh3
	qNs4pz9C3LWYUvcw+NaoZ5NpNsoaQvlOBfUv/+OaZlgd5UuxlcqPpwaayoG+nuxzErjQNHjQQ0z
	7LlhR38HLXBk9XnbHvOAj6C2cYXE=
X-Google-Smtp-Source: AGHT+IEjoyDYtuRhdiUiURVc6DSciisx8+WvR0w6lhW89ZF4XV7mw57AbwWKr9q5MoJ21FNJxDF5wA8IrTnMOL/Ell0=
X-Received: by 2002:a05:6808:444c:b0:3f3:cc57:753d with SMTP id
 5614622812f47-3f3eafd46fcmr10845219b6e.0.1739902585109; Tue, 18 Feb 2025
 10:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211203314.762755-1-superm1@kernel.org>
In-Reply-To: <20250211203314.762755-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 19:16:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iS8e8EPMQOf3zJ5rycLrAuzCPsbk-2tAY7o4TX99kBYg@mail.gmail.com>
X-Gm-Features: AWEUYZlxDUxZicGuKEBwVAfrgYKO-XE4f9dQI6IcE_jULh7YvhFSl8Ra_vXB5Uk
Message-ID: <CAJZ5v0iS8e8EPMQOf3zJ5rycLrAuzCPsbk-2tAY7o4TX99kBYg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Add missing include
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 9:33=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Some minimial kernel configurations will fail with -Werror=3Dimplicit-fun=
ction-declaration
> due to a missing header include.
>
> Add that header.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index d68a4cb0168fa..77bfb846490c0 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2016, Intel Corporation.
>   */
>
> +#include <linux/bitfield.h>
> +
>  #include <acpi/cppc_acpi.h>
>  #include <asm/msr.h>
>  #include <asm/processor.h>
> --

Applied as 6.15 material with "x86" added to the subject, thanks!

