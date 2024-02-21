Return-Path: <linux-acpi+bounces-3780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E485D929
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBB2B231B6
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CF69E1D;
	Wed, 21 Feb 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kp9CToK0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0569DF8
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521320; cv=none; b=KNAvYljPiGtRJvNvyapYRk/rzhGdcOtuA2G87AOyc5veISMnW6UdLE3qCUUsYV6FKx/aw0GlD6bDS+N6qu0QRI9jHUMqcvr1ec6IY4ZmQ4WdBz+CvxENJBJlDhAfOIsdtGTb9TQzlm2qmnCCgaDwrt6qVPS0+gKobjUeyFTTk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521320; c=relaxed/simple;
	bh=0oiU4XaRWDS6j4LBNifbui5q7io0SNO+FMU6eW1wzu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7Wb0cp+FEuPwLl3v7BiF2yNc2t34ssLra0x3h0oNSTKF6RxuQSZ/MajFuDXtGO9BwY9g6Y5mjxqiZNa1oYuMLcQcdaQSq3mU1cAKyqxpsCsKaOk/WK+OyJ7PFwYoEf6GpofmbFo4zIWIvsjny7ZIssm6snbdUPUH1S6T9XfwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kp9CToK0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564ffb34c24so860778a12.3
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708521317; x=1709126117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0sGkUIkt/bMIosWsZDLIe9J8o3jcEjfocOjlnpUT44=;
        b=kp9CToK09MUdy8shVSgbdvZketrpl6H5z+yXxzNlF4fU+npo/6FXidY6+uxQBYI56j
         zB3zLJdu52u/wfs5HETsF7EgQb6UdwVwFDcHU0JPAu7+f2vnQu8KvOlUbcMVr1kD1dBI
         /8zc0c8wXMAJxfr26JNG8WyshsMJfK/lWlYXE+Z26udP5OA5q/Z9IL5KHCPgNfqIs9wm
         YIBfTIjT8O2/VD6v9LeU5y3o1Eaq4m6uNCgx3FOJG2HRkaPswhf9kq4Sp/traXt/XadS
         roFk2TZPUpIo2YgBXwNnmy349TfTmy2WkCJxmZQyCYoRdkCQYKFxGwpZdykLRYwSI6UU
         kLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521317; x=1709126117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0sGkUIkt/bMIosWsZDLIe9J8o3jcEjfocOjlnpUT44=;
        b=gp6esxhLrMtPxNLFuZNMJBDx7yQ3/Z5CXE5eFJtKfSbBGxarMuDzuvpD1y2RoFFJnu
         sSDDPjy+N1265gxuTgE0O3qnTXRhBmEbOrG6GvQgyMn+ffbYv8jVKlcvzOW7QJV33cts
         /b6kKLV/67RTXFhSoOXi3qjIRIOfdUrrn6rQRyT54uovGpbb5nwp+R5Hl040znUZmSZx
         PQ6kSHwV+43dp9Z7ygBk1ya1KfBtVBG4fBjOglMzSMHLOdiKm+PLnm2rCgLN4pdC3bjY
         Vycc01L2Hk+KdBAYLiTT83D/RDweLP/OnRCrw8Pw66QUi45GIT85TaODJnH0dm122U+9
         mruw==
X-Forwarded-Encrypted: i=1; AJvYcCVrIDVpEbSE7kIQ3/gBlr4d4eYlzZyA7AqRVWFPt5uOMagkOpAquN/F8juxOg9bt8Fuxe6VF8+gVrEKjSYmd9aP1e8hUnui/W8B/Q==
X-Gm-Message-State: AOJu0Yzs83qFI+zqhV5NvODhC392emXFysYQWSjDT7P+SvXkyJx3val4
	JIzEN5XYI8X61+5JK6saMUklAzY5ov8+0M+AbvK1u/DgHXNyT2CGWn1fcmubaaM=
X-Google-Smtp-Source: AGHT+IHGJ1FuMr+A7FNLQlz+4RrCrl8EAK9R3DgIA8ynv5GJFPGlAtMQsiBG++juajVubHNOCOssKA==
X-Received: by 2002:a17:906:185a:b0:a3d:994a:791d with SMTP id w26-20020a170906185a00b00a3d994a791dmr13864861eje.59.1708521317114;
        Wed, 21 Feb 2024 05:15:17 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id y2-20020a170906470200b00a3d0dd84276sm4941502ejq.184.2024.02.21.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:15:15 -0800 (PST)
Date: Wed, 21 Feb 2024 16:15:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ACPI: thermal_lib: Add missing checks for errors
 in return code ret
Message-ID: <4b78456b-071f-46c0-bb47-919b493cab79@moroto.mountain>
References: <20240221123936.3421462-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221123936.3421462-1-colin.i.king@gmail.com>

On Wed, Feb 21, 2024 at 12:39:36PM +0000, Colin Ian King wrote:
> Static analysis with clang scan build detected various return codes
> being assigned and not checked. The calls to the trip point functions
> probably should be error return checked as these can fail because
> of unlikely issues such as invalid ACPI object names or ACPI value
> evaluation failures.
> 
> Cleans up clang scan warnings, such as:
> drivers/acpi/thermal_lib.c:106:9: warning: 2nd function call argument
> is an uninitialized value [core.CallAndMessage]
>         return thermal_temp(ret, temp_decik, ret_temp);
> 
> 
> Fixes: 6908097aa5a7 ("ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> 
> Note: Not tested.
> 
> ---
>  drivers/acpi/thermal_lib.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
> index 4e0519ca9739..4d27048ef075 100644
> --- a/drivers/acpi/thermal_lib.c
> +++ b/drivers/acpi/thermal_lib.c
> @@ -103,6 +103,9 @@ int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_tem
>  	int temp_decik;
>  	int ret = acpi_active_trip_temp(adev, id, &temp_decik);
>  
> +	if (ret)
> +		return ret;
> +
>  	return thermal_temp(ret, temp_decik, ret_temp);
                            ^^^
The "ret" variable is checked at the start of the thermal_temp()
function which means the code works the same before and after your
patch.

However, the static checker is correct that we are passing uninitialized
data to this function, it's just never used if "ret" is non-zero.

In this case, the rule is that if the function is parsed inline then
it's not a bug, but if it's not inline then it is a bug.  Technically,
passing uninitialized data to a function is undefined behavior in C but
Linus said that didn't really match with real life and that everyone
should recognize that inlines are different and update the tools
accordingly.  (Something like that, I don't have the email in front of
me).

The other thing to consider is that tools like MEMSan (?) will see
non-inline function calls and we're reading from uninitialized memory
and trigger a warning for that.

In this code, I suspect that thermal_temp() will be inlined so it's
probably a false positive in Clang.

regards,
dan carpenter


