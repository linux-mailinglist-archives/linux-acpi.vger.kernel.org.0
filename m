Return-Path: <linux-acpi+bounces-15552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D7B1CC2E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD88F7B0630
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A62BCF41;
	Wed,  6 Aug 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UG8+KSEm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B6299A8E
	for <linux-acpi@vger.kernel.org>; Wed,  6 Aug 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506256; cv=none; b=CFdkR0N78Rb1IV3Ot9TRR0sidWMKHz330XjghqsRbbnzmngjGY83Ewaboj1Z+sbZ3RiEkasj2KQvnUOdJ1FIXQ0c85zuDrpdhEnDySZV2vPPsuUPYFyNcCHTdLRbNc+/bKngk0EVCjU7zGp1D2Roed9CK44iVo02gJFbPdxhDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506256; c=relaxed/simple;
	bh=4L7OnCYNKnrx/l5GKbgkr0QaMN4bC6LphZ7ZI4fQNsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5jtsU0f3HK4OCVou3WqlOi3k+KcrzcyGxtudnfW2laVvw4OvqW9m8Z23V5fgvWTwjkbcW8BOqQkcVI3QnLRYNbSmale5pUEFv5tqdJyg+wMbiXh0OnmOyg+zI8i+jt6u1NmT2vNVPGHDXUPcqaAFCCcdyWYWPq7g8TOK04yimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UG8+KSEm; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8141C4028381;
	Wed,  6 Aug 2025 18:50:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8141C4028381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1754506243;
	bh=9j5CexT8bdFIHvMhQ9FMXMaZBJvFjFE6SMxQVK0pW4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UG8+KSEmkifDq2ZyI+1rN+2dOIND8R1c/hVFcwNNE71s8sqYGgGykOBs/pizrZ/PF
	 Gr7ath7i5jryrqAnDwmDfntX2OKFNwHiK5hhIqsY3Yi1ZJ0bg1q8XMYmdQZu9b4SeR
	 zAZaCg4e4bYEKh19cY9rvj2cGTuGfSAwOWvbaaOk=
Date: Wed, 6 Aug 2025 21:50:43 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Niyas Sait <niyas.sait@linaro.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] ACPICA: fix largest possible resource
 descriptor index
Message-ID: <ydubyehjdctffxhcr3ou6d7p7q7mwtmnwby5m6sbxcdepvpelt@sfblrcg7p36f>
References: <20250806161301.233242-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806161301.233242-1-dmantipov@yandex.ru>

Hey Dmitry,

On Wed, 06. Aug 19:13, Dmitry Antipov wrote:
> ACPI_RESOURCE_NAME_LARGE_MAX should be equal to the last actually
> used resource descriptor index (ACPI_RESOURCE_NAME_CLOCK_INPUT).
> Otherwise 'resource_index' in 'acpi_ut_validate_resource()' may be
> clamped incorrectly and resulting value may issue an out-of-bounds
> access for 'acpi_gbl_resource_types' array. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 520d4a0ee5b6 ("ACPICA: add support for ClockInput resource (v6.5)")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---

ACPICA patches should go through the separate Github project [1] first.
Please see [2] and [3] for examples.

[1]: https://github.com/acpica/acpica
[2]: https://docs.kernel.org/driver-api/acpi/linuxized-acpica.html
[3]: https://lore.kernel.org/acpica-devel/CAJZ5v0i7LYzF13M0qdeYWXZ7uO6HUpAS7pE5RJnOAJtKB8o88A@mail.gmail.com/T/#u

>  drivers/acpi/acpica/aclocal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 0c41f0097e8d..f98640086f4e 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -1141,7 +1141,7 @@ struct acpi_port_info {
>  #define ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION   0x91
>  #define ACPI_RESOURCE_NAME_PIN_GROUP_CONFIG     0x92
>  #define ACPI_RESOURCE_NAME_CLOCK_INPUT          0x93
> -#define ACPI_RESOURCE_NAME_LARGE_MAX            0x94
> +#define ACPI_RESOURCE_NAME_LARGE_MAX            0x93

I think some brief comment in the code explaining the reasoning for such a
definition for the MAX value would be worth it.

Though another way is to tweak the check inside acpi_ut_validate_resource()
to have '>=':

	if (resource_type > ACPI_RESOURCE_NAME_LARGE_MAX) {
		goto invalid_resource;
	}

Maybe that'd be a bit clearer?

Thanks!

>  
>  /*****************************************************************************
>   *
> -- 
> 2.50.1

