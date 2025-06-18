Return-Path: <linux-acpi+bounces-14445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A1CADEC16
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 14:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120411773E9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE42E8E0E;
	Wed, 18 Jun 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnlRXmS9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E82E265D;
	Wed, 18 Jun 2025 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249302; cv=none; b=kyBqTB0UMCtgAum1dX4zxnIL6bIZrBvDhBGFU5f+t1p3wrQ5azJ9hpN35ZReh307CGJ+MH1m1PcRCuMuvkUe0zjnMRVFunHZYITb8o7h8hl5pgOtxL8KinYkA9FdQIrR6xNtDyk/RjRH8lgKCAX33HiDLeuMVq4zRm2+eGFhJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249302; c=relaxed/simple;
	bh=K/1ddQ9lPv3NrU3uazweA8uoUo92c/y5D/tyXqQnQqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tywzwo23QjnShoXdL5ZDwazDMaJVrrOGPB+BeozvE5VfZfcUzgxtJkxfg+Rt6jXKDO6B2Ipcv/KWCXzLBh7AVUfPhfQwQZ7MZa67jz/bRKvcVGqUhNm1M4f7fFC5xtlyEJHF/mcvwggsiLJq8XKvuF5GVMI3k2G/m54io2wGW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnlRXmS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A41AC4CEE7;
	Wed, 18 Jun 2025 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750249301;
	bh=K/1ddQ9lPv3NrU3uazweA8uoUo92c/y5D/tyXqQnQqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WnlRXmS9f3pzmLTen9UWXLHC2uAMrwCwAFODb/UltsBIEh7MlFhraXXt+NKAxE7q8
	 TJPq53MJIkMbUgQffnQYUYXVzV2KXYPujnULYIMPf517TOcbEmlsQ3yn/VX8h6C6AL
	 gc/UYVVtTtUFqcZ6C1/v/r3vRTYZnouy2C4JyOgbA18XAAul+M2oqxaFBWQAYVWxct
	 nUDjQ8xGTN4ktgKSphrMlBpNdnyOYl4CuhUT67n08xDZBOx6LbAO8zLFS0xmtP8o1L
	 2jHHFhk9UrQqRj5J31JNGr0w3yuo86/CD/9KwCeH+8udG89Z/I64GsjutabMNOUvZ3
	 TemjZDLUHGbcw==
Message-ID: <b72b5ed1-6d3e-44f0-bab4-1b6aaedd9443@kernel.org>
Date: Wed, 18 Jun 2025 14:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPICA: Refuse to evaluate a method if arguments are
 missing
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Peter Williams <peter@newton.cx>, "Dumbre, Saket" <saket.dumbre@intel.com>
References: <5909446.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <5909446.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Jun-25 2:17 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> As reported in [1], a platform firmware update that increased the number
> of method parameters and forgot to update a least one of its callers,
> caused ACPICA to crash due to use-after-free.
> 
> Since this a result of a clear AML issue that arguably cannot be fixed
> up by the interpreter (it cannot produce missing data out of thin air),
> address it by making ACPICA refuse to evaluate a method if the caller
> attempts to pass fewer arguments than expected to it.
> 
> Closes: https://github.com/acpica/acpica/issues/1027 [1]
> Reported-by: Peter Williams <peter@newton.cx>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me and I've also tested it:

Reviewed-by: Hans de Goede <hansg@kernel.org>
Tested-by: Hans de Goede <hansg@kernel.org> # Dell XPS 9640 with BIOS 1.12.0

Regards,

Hans





> ---
> 
> This is an exception as it fixes a kernel crash on multiple platforms
> affected by the defective platform firmware update.
> 
> I will take care of submitting an equivalent change to upstream
> ACPICA later.
> 
> ---
>  drivers/acpi/acpica/dsmethod.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -483,6 +483,13 @@
>  		return_ACPI_STATUS(AE_NULL_OBJECT);
>  	}
>  
> +	if (this_walk_state->num_operands < obj_desc->method.param_count) {
> +		ACPI_ERROR((AE_INFO, "Missing argument for method [%4.4s]",
> +			    acpi_ut_get_node_name(method_node)));
> +
> +		return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
> +	}
> +
>  	/* Init for new method, possibly wait on method mutex */
>  
>  	status =
> 
> 
> 


