Return-Path: <linux-acpi+bounces-10080-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B19EC6D0
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FC188A640
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21CC1D8E06;
	Wed, 11 Dec 2024 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/DBBCAX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26541C175A;
	Wed, 11 Dec 2024 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904978; cv=none; b=BB2lXHm8XUKVX/TfTQjSKvHhvXJVoNHVblxehzFPs7ib0NBreyqwmOJ8WFdaOwLfGef7K4sCPZC2wheAoE2NqZjNVAh0X9/q6LKwjWRilXYPmgLmfdPI7Y4PlqJzKfX2jSqjyE8sD8QAbYC431JPeT6QPBUcfPIdrDZSHu3nxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904978; c=relaxed/simple;
	bh=xrr5/WqbA2Osql85pHxnFVJAP+SDwYYQSTIdMCY5/8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkhor4XZelDVImj1A7jpOYcJitzhRGj97hqeFJaQofsIh4yN+eTlmTifSEWwa2gvqcriGhCrwto1QhAPzgosjgDT+RP/JJyncO5HbdMBTKb+Sx3gOR9WXrpYotFCEb/GgMHXo/hnUaHSM9IEmfA6ToNSdmZyCqBx7qqlmMsFBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/DBBCAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3D7C4CEE0;
	Wed, 11 Dec 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733904978;
	bh=xrr5/WqbA2Osql85pHxnFVJAP+SDwYYQSTIdMCY5/8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/DBBCAXkDVqVav0OSSqUDWjSo9suPFmWj8pVlL7/fvB2yeqgmcXK8yrMzVRvt8lw
	 KZHJw/8WiY+TsVRODs5i59/ME+yCxcGaunId8JDonH4TLyNVjgb5SsyGvz6QjHjcMY
	 GBL+iCDmEsOa+v6IzL6tCl++FtKwD6JmOhudKclLdwa9XUqHW/aVWkyMopoxiSUoh6
	 nhQUQV5M/0r8L3z1GORQJ6RBRBfvJKIaCUew61547yUxD4vh51W9GOaG/8oLskqwfk
	 uOQQlhUKWaRqh4syuOxw9joM6T+5weIQuwh+hrroaK6B+QtcSvuFVL3+emLZvsIbuk
	 ywqV+vMsq2arw==
Date: Wed, 11 Dec 2024 09:16:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Message-ID: <20241211091602.1907f790@foz.lan>
In-Reply-To: <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Dec 2024 19:56:00 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> Provide an implementation of acpi_get_physical_device_location that can
> be used when CONFIG_ACPI is not set.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 


> dasadsd
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Please remove duplicated SOB.

What "dasadsd" mean?


> ---
>  include/acpi/acpi_bus.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index eaafca41cf02..520f12155e7f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -43,9 +43,6 @@ acpi_status
>  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
>  		  struct acpi_buffer *status_buf);
>  
> -acpi_status
> -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
> -
>  bool acpi_has_method(acpi_handle handle, char *name);
>  acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
>  				       u64 arg);
> @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
>  			u64 rev, u64 func, union acpi_object *argv4);
>  #ifdef CONFIG_ACPI
> +acpi_status
> +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
> +
>  static inline union acpi_object *
>  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>  			u64 func, union acpi_object *argv4,
> @@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
>  
>  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
>  
> +static inline acpi_status
> +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
> +{
> +	return AE_ERROR;
> +}
> +
>  #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
>  	for (adev = NULL; false && (hid) && (uid) && (hrv);)
>  
> 



Thanks,
Mauro

