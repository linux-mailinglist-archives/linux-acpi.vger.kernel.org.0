Return-Path: <linux-acpi+bounces-10083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5419EC6FD
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAEA169728
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532F1D7E4E;
	Wed, 11 Dec 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6u4cbya"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AD1D61AF;
	Wed, 11 Dec 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905378; cv=none; b=YwKwfUzcr9Juo02o3SC7aqgwCGWFQYo7y+3yle/mW9uU3iUGe5SE7ocGc/uoJpqZu+4wI0/VVvQ0uyUkO6uWsTA0ZBcNYcIX1O0RAdE5ZB5oLv+mnJLJAKv1gzloBso24rubpBNZVOYWMJX203YlIr5kuruLUL4lmHaw0hp39FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905378; c=relaxed/simple;
	bh=dEGW18FBs0efR5Q/XxoNJQlBdBeSlmtuoDZFTtu+PCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0L/MCP0ZguESkQ3b5hIpkqSBXhq1NYVg2fugC+sl6emrOzV4Cf7n1rtVgzZHoKBZ7UcGjf3wAEyaefX+Zd4R8GA97OYFBZcwRg9PZ7/UWCNYtkUtL/SzJizgxxpw7cQWK8tplA7MhHmEqlvl5iL4nf4AeU7CziwmJKpPMyhB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6u4cbya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C313FC4CED2;
	Wed, 11 Dec 2024 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733905377;
	bh=dEGW18FBs0efR5Q/XxoNJQlBdBeSlmtuoDZFTtu+PCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q6u4cbyaWizD7UIkLypCj68iw9b5KEhYCNraM6qB0DzldXnjN7k4cDPoUDk5TbQ4A
	 NfASi98zxNmEXWusJXSAo/fWBtM1PLUdacb0BVPv1iiHJ69X2lBjktBhWXaGaq92Qk
	 sZqnnebnicFARG5i1AGktfz7QS17yxN0PmBd6SkLqHtW8fQRLhVcaOySARmrr1uwrb
	 ZWLblb5MduCy+XUNy1RViLZnrmWEZoFiT/Jdihf9+ssGcO5eTrOMwCoGRo4TfPW24y
	 D3/ZVmuAUATf8c2T7fyN9YREeRwKyMfRV+PVqofAi+ZfFyE8WXhafrWhykZ5Tstl4m
	 C7rbChOGneY8g==
Date: Wed, 11 Dec 2024 09:22:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Message-ID: <20241211092250.02b38b50@foz.lan>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Dec 2024 19:55:57 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> We want to be able to compile_test the ipu6 driver in situations with
> !ACPI.
> 
> In order to do this we had to add some conditional #ifs, which lead to
> false positives on the static analysers.
> 
> Let's implement some helpers when !ACPI in the acpi headers to make the
> code more easier to maintain.
> 
> We can land the first patch of this series ASAP to fix the current
> smatch warning.
> 
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> To: Rafael J. Wysocki <rafael@kernel.org>
> To: Len Brown <lenb@kernel.org>
> To: Robert Moore <robert.moore@intel.com>
> To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linux.dev
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> Changes in v3:
> - Prefer static inlines to macros (Thanks Rafael).
> - Link to v2: https://lore.kernel.org/r/20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org
> 
> Changes in v2:
> - Add helpers in acpi to avoid conditional compilation
> - Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org
> 
> ---
> Ricardo Ribalda (7):
>       media: ipu-bridge: Fix warning when !ACPI

Not needed, as patch 7 will revert it.

>       ACPI: bus: implement for_each_acpi_dev_match when !ACPI
>       ACPI: bus: implement acpi_get_physical_device_location when !ACPI
>       ACPI: header: implement acpi_device_handle when !ACPI
>       ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
>       ACPI: bus: implement acpi_device_hid when !ACPI

patches 2-6 look ok to me, but I'll leave it to ACPI maintainers
to review. From my side:

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

>       media: ipu-bridge: Remove unneeded conditional compilations

See my review with my R-B.

As the crucial changes are at ACPI side, I'm assuming that this will
be merged via ACPI tree.

Regards,
Maur

Thanks,
Mauro

