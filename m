Return-Path: <linux-acpi+bounces-12923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB0A82E5C
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 20:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABB33BD88D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDB27702C;
	Wed,  9 Apr 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="lkFwlPix"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA9D26B2CA;
	Wed,  9 Apr 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222628; cv=none; b=nCed6JYjdCJ5GbQupAMk2K+Ej/s45FOp+znvg9B4vNTc9URCdTAazdlRFm2fcQc00w24xdQw17pVFhKdBOYenU13hkxvvop4q4X83K3YJmnVXCVZOTPATjD6+TqYRQ4LzkJ6gXgJu3EE4jtRvP8hBTgXyj9NofYCC8h4g/1DccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222628; c=relaxed/simple;
	bh=RlQyrCucUebSpzBZ0SiXZwAu7QBoTEAbCFjb1KaLXKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XF6JrSoCC2J+mk3QT2FUd29m8/6tzWWx/41++2bBxQ10X1SAL9tWixHSOf5bgdg3hChC/SdFSgOXd+JKHTl3axdKFGh68JAqG5CJA5VZ7BquI7HgkdUdxuDwS19NxgtcCY8tlNLcwr+AjU1XBHiEk6RKnbMnI5oednVRC2NiGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=lkFwlPix; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1744222622; bh=RlQyrCucUebSpzBZ0SiXZwAu7QBoTEAbCFjb1KaLXKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lkFwlPix333fAQ7xTLz9dmSmDPQqK5qY1WHjYQmn7uGLvUuV4nJh3iYr1q43ZjRRs
	 BEnwFI7cHQoaYbgX8raJxBXg8dZ28RD7y/TpcfJ7zLrQ4oS7gg4BuoUSgmUuzOMn2p
	 1fNZU87zaUJ7URve6IpkT+YPPPTc1jOvvAy5kT1qSxRZdmik/8U2SHP9cDpIt9GAI9
	 zWzM1WAtzC5PqHLv/WOcUnxblS9G+GJILdirwMnPuyiGKFer1aiBQnkCl7YhpmR1Kl
	 4RVcCRF0wkzvalxUrF1WTUDVFwijp0my0B4P+HD4PAuw3VYXr8Qp9KzoAOe0QmTNFQ
	 MhknwFMzR8yB4vjenz82eVqYuRPwUSL4gmXMHG8AqDtfW0o72a4nKFOKO5dFK65xk/
	 GKsGKs9PAntWU87uFj7EHPLODgyhz5Sw5f5OeE8OAk0Zgf043ef/OdeReXesFRLUu/
	 PAaaPl6PTfUeFU/+1+FjWvEdWMNvaI7g54KpAQu+rgWhQXICFJIKNzu25tbnVr0c/e
	 XRsc3IW14INY6ox524Qj7N2geiw5OL6vgCrp8LfX7qpa9vqhcAyQL+OuzHiPMTDWge
	 XT0yOV0I0eVnRpdC1VyhxKoVofjZTMrul7F+KV7jLH4Edj7krVCaNUQITEDNQVew43
	 2V/5WVGcb+HQWy7WzHg/68L0=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id E038116358B;
	Wed,  9 Apr 2025 20:17:01 +0200 (CEST)
Message-ID: <98ded07e-33e4-417c-8146-fbf2783a7464@ijzerbout.nl>
Date: Wed, 9 Apr 2025 20:16:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] gpiolib: acpi: Make sure we fill struct
 acpi_gpio_info
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
 <20250409132942.2550719-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20250409132942.2550719-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 09-04-2025 om 15:27 schreef Andy Shevchenko:
> The previous refactoring missed the filling of the struct acpi_gpio_info
> and that's how the lot of the code got eliminated. Restore those pieces
> by passing the pointer all down in the call stack.
>
> With this, the code grows by ~6%, but in conjunction with the previous
> refactoring it still gives -387 bytes
>
> add/remove: 2/0 grow/shrink: 5/1 up/down: 852/-35 (817)
> Function                                     old     new   delta
> acpi_dev_gpio_irq_wake_get_by                129     695    +566
> acpi_find_gpio                               216     354    +138
> acpi_find_gpio.__UNIQUE_ID_ddebug504           -      56     +56
> acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug506       -      56     +56
> acpi_populate_gpio_lookup                    536     548     +12
> acpi_gpio_property_lookup                    414     426     +12
> acpi_get_gpiod_by_index                      307     319     +12
> __acpi_find_gpio                             638     603     -35
> Total: Before=14154, After=14971, chg +5.77%
>
> As a positive side effect, it improves memory footprint for
> struct acpi_gpio_lookup. `pahole` difference before and after:
>
> -       /* size: 64, cachelines: 1, members: 4 */
> -       /* member types with holes: 1, total: 1 */
>
> +       /* size: 32, cachelines: 1, members: 4 */
>
> Reported-by: Kees Bakker <kees@ijzerbout.nl>
> Closes: https://lore.kernel.org/r/9715c8dd-38df-48fd-a9d1-7a78163dc989@ijzerbout.nl
> Fixes: 8b4f52ef7a41 ("gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/gpio/gpiolib-acpi.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 5b6344f0d065..2ac9c7b31908 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -742,8 +742,8 @@ static int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
>   }
>   
>   struct acpi_gpio_lookup {
> -	struct acpi_gpio_info info;
>   	struct acpi_gpio_params params;
> +	struct acpi_gpio_info *info;
>   	struct gpio_desc *desc;
>   	int n;
>   };
> @@ -752,7 +752,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>   {
>   	struct acpi_gpio_lookup *lookup = data;
>   	struct acpi_gpio_params *params = &lookup->params;
> -	struct acpi_gpio_info *info = &lookup->info;
> +	struct acpi_gpio_info *info = lookup->info;
>   
>   	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
>   		return 1;
> @@ -806,7 +806,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>   
>   static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup)
>   {
> -	struct acpi_gpio_info *info = &lookup->info;
> +	struct acpi_gpio_info *info = lookup->info;
>   	struct acpi_device *adev = info->adev;
>   	struct list_head res_list;
>   	int ret;
> @@ -832,7 +832,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
>   {
>   	struct fwnode_reference_args args;
>   	struct acpi_gpio_params *params = &lookup->params;
> -	struct acpi_gpio_info *info = &lookup->info;
> +	struct acpi_gpio_info *info = lookup->info;
>   	unsigned int index = params->crs_entry_index;
>   	unsigned int quirks = 0;
>   	int ret;
> @@ -893,8 +893,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
>   static int acpi_get_gpiod_by_index(struct acpi_device *adev, const char *propname,
>   				   struct acpi_gpio_lookup *lookup)
>   {
> -	struct acpi_gpio_info *info = &lookup->info;
>   	struct acpi_gpio_params *params = &lookup->params;
> +	struct acpi_gpio_info *info = lookup->info;
>   	int ret;
>   
>   	if (propname) {
> @@ -975,6 +975,7 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
>   
>   	memset(&lookup, 0, sizeof(lookup));
>   	lookup.params.crs_entry_index = idx;
> +	lookup.info = info;
>   
>   	/* Try first from _DSD */
>   	for_each_gpio_property_name(propname, con_id) {
Can you check and confirm that at least info.gpioint is filled in (or 
initialized)?
The callers of `__acpi_find_gpio` pass in an uninitialized `struct 
acpi_gpio_info`
and after the call they read `info.gpioint`.
-- 
Kees

