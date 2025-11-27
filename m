Return-Path: <linux-acpi+bounces-19311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A6C8E609
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43F5134D659
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93724291B;
	Thu, 27 Nov 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioRJw6pN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1E194AD7
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248987; cv=none; b=D5La1QwTMxRH2PbUZ+j+TeOATmkVHdcA7K6RgGKGbA1g9dxaMlMH6/NAyxP2dWnuThrNGcnRFyzTRFqrkCvoUY3Qe4e6u9oMtfYBaq/kUs3XPmqe7WK8XubAQUpIUyw3i7nB8KEVBfxFz6zvP4i8GsqWGFIY7fbI7WJoefZr5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248987; c=relaxed/simple;
	bh=Yn1NUbwy2QCZ+LFk7Sz+iNoiT44/7NSkUTnfzTp4N+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uc1orWTX8A7SZy9ugPJTLNRgCDNcCdAh/I8ronnEDefFFJLs0XYrrgj+1XGTDbxX/SO1RNmpqNs5wh/lVePGbXOqTKlzW25aue/tK1xLE09uTDs2VFzLocOeTLXeA9253DLmVm5PZFJw/DmIUqbiX6VjCOwsj2L4IyESTJG1E6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioRJw6pN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC1AC4CEF8
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764248987;
	bh=Yn1NUbwy2QCZ+LFk7Sz+iNoiT44/7NSkUTnfzTp4N+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ioRJw6pNxS+aMc1Pk1D/FDfopMNzvt9F6wJQWS5kHLb491DGb0bNV3RskswXYUk2f
	 mvDsaeFwyGt/vYBaYLaLyuXTYKasLIRItjXSBd7UXOgQ2Di5GvFcEIuDGt5s1ZJBFy
	 FtPcOG8L/G8K+cVKBXDTisYjspoDcgkRMqJfy7H1/v8zkRUnl17RQ589PCtCez134S
	 d/mCa+fNeGCMsRqT0NEGni+TxcoH2C30je8YGssSs4NtgVbFA9K0NCTEYU6di+7O/x
	 bv2DdHo+jW5mBij0ktiqa0Wzklg0RRG0mD6wGnMtcHRF4AGtu2pYBdgtPByNr9Yaap
	 PdulLU1w5m5ww==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-65748e230f9so339008eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 05:09:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8K103VZMzs8yCZyy79Hkt6alYtK1dNnKsGjRSd9BNmq6lrsecwx53f1WboY3y0TnR2TyLPCZVCI8S@vger.kernel.org
X-Gm-Message-State: AOJu0YztUJeWTKJJmQ79jd6VYX1GZi9eOzz7VBJgSCc/rGX+GNPjwWrt
	GfrgTlBhztIhO4TE/OTeuShVONYiA7hotcTpS0BElGDoQvBTnA2/NVLUry9RX8apoznLTrDSZQ4
	f3ZnnWcn5GprHs+dKFbq24h0IZuBoi5Q=
X-Google-Smtp-Source: AGHT+IFW+B1uOV43y8Ewp862X+5FBpliPlylWDzCwcz7ncHNGGV5HE/yYBuMkAxMC+SY4hKa+YDQz1wdZJDebV/SJSw=
X-Received: by 2002:a05:6820:1c91:b0:656:bbd9:51d7 with SMTP id
 006d021491bc7-6579100d6b3mr7663399eaf.2.1764248986789; Thu, 27 Nov 2025
 05:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125021431.2243-1-chuguangqing@inspur.com>
In-Reply-To: <20251125021431.2243-1-chuguangqing@inspur.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 14:09:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gDmpUxr7KWRA_3i+nGWA54sRU11La2nwDsQAQj8PTTOQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnlckp3K8MFVIGzaHLlFDBZIc-1KomHA6d3PgjcaRtkXKvoEJ0HXjVCIts
Message-ID: <CAJZ5v0gDmpUxr7KWRA_3i+nGWA54sRU11La2nwDsQAQj8PTTOQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPSS: Fix a spelling mistake
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:14=E2=80=AFAM Chu Guangqing <chuguangqing@inspur.=
com> wrote:
>
> The spelling of the word "successfull" is incorrect; it should be "succes=
sful".
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/acpi/x86/lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
> index 6daa6372f980..1dcb80ab0d23 100644
> --- a/drivers/acpi/x86/lpss.c
> +++ b/drivers/acpi/x86/lpss.c
> @@ -181,7 +181,7 @@ static void byt_i2c_setup(struct lpss_private_data *p=
data)
>         acpi_status status;
>         u64 uid;
>
> -       /* Expected to always be successfull, but better safe then sorry =
*/
> +       /* Expected to always be successful, but better safe then sorry *=
/
>         if (!acpi_dev_uid_to_integer(pdata->adev, &uid) && uid) {
>                 /* Detect I2C bus shared with PUNIT and ignore its d3 sta=
tus */
>                 status =3D acpi_evaluate_integer(handle, "_SEM", NULL, &s=
hared_host);
> --

Applied as 6.19 material, thanks!

