Return-Path: <linux-acpi+bounces-13418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6EAA75CD
	for <lists+linux-acpi@lfdr.de>; Fri,  2 May 2025 17:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295E71C00635
	for <lists+linux-acpi@lfdr.de>; Fri,  2 May 2025 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71E255F57;
	Fri,  2 May 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Je4gbXv2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D217A2ED
	for <linux-acpi@vger.kernel.org>; Fri,  2 May 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198939; cv=none; b=r7uYSznqHuReNKrZa5zDky2OwK8DwU9zMdqwW1crmOQCGEAlHLIs8lE9zFYVvoEto1fbdqXBbps3i2mSo/dtdufLgDh14/SP8p09aPaUzMnIwlQWAM7SjS5R4rw7BegM8xUWUuFYBAIpHZigDLhKKOSV8AXHHP0BQGAB/25Buu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198939; c=relaxed/simple;
	bh=mFj7rvx9G8v9+EiYk7/06RcBARNZQP3y2G/mp7J7IAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZHX4gFRG2VL9vLe1oz+8bbUe0iV2dO+sJJuvTDD5fVxXj4Ql+AosgSpeWzHX+Wogp59ZXizugM2aR23WWvFIqYQLnVTBlxLT5giFnCm8MQgXjwayhMsYGMjDvcUNPe6wJSYml5e+Tk2y9JTw6qoI14wMwaMnx0rCDOfB5Wa5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Je4gbXv2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39149bccb69so1568307f8f.2
        for <linux-acpi@vger.kernel.org>; Fri, 02 May 2025 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746198935; x=1746803735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujk1BtnXfFfRVWSou7qNXAW7jGu5GKXlOG/QH1lknbc=;
        b=Je4gbXv2CuWnFAnXb7YXM3nbnp6iJzx4VvrHDxDrCGzev0vGAJ9ucXqfXKkSgt+7Pt
         TyuBYN1whxO56XvYcCI8sQHsUOqlM0qskl9DJ5r81JPXCXEQ3UI0GGjp3REEZC47XYhN
         C7IHcq4sQ9uwm7LQuXbYhwkPeNws7L3KmoipkUBtGWLk5GWSHjZ+jYay3sl5ykRP2h0I
         URXU16cpdPIJ0366JqrTGxx7SJnaiiARnplgB7tCr32eGQCNYJ7G4e2w6kQRteGw23oW
         Z4ClHfScP94QPlosvHLRjr9jJpAslIDUY5HeiRsajiWuV8S3ZkEGw8sLXvGWL0elmpzh
         lr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198935; x=1746803735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujk1BtnXfFfRVWSou7qNXAW7jGu5GKXlOG/QH1lknbc=;
        b=aKe2UywQCW1sODXK7Wv0Oh5wIQ6ZPy0Co5UMD3/UlghF+ReQfI14qR4fIoqWGwbeKD
         rFdAEOYDRoo82uG49CbEujw+gv50eYyZyiJOnZ307ZGlEsRfi/o7Ly6tav5721iB4j3w
         QvJ11BqY45SCFGLzNE48NcAzY2yWDU7q/SqW0H5ZqNH30nj9e+PK3xrYqfEbbM23+zlE
         9r5mgLzQS6KRYjEacwHvB80oxWdDqpPhOfmZNIpd1+i/+2toi5GeUktwb0uHk9oU/qh8
         65xuRfcSs7WRw6n6Gu70iCs+St0Vllo1tuY7TjzyTdHOQ8M4wzP/qXEuA2q66JWaGQim
         Gnww==
X-Forwarded-Encrypted: i=1; AJvYcCWMBZkp0rg74U+pUSjJMZXJDDVNu4GbBLussqMl76wQTb5gdjrPUGLieeFbasCfZ5obLMH5xgoVJAh6@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLGtjQJoiQTNFHwoo4H8okKYrE47ly8XuOqScrbsFOMU3QzEQ
	kyL/tEarN5bH3wDvIxjb316B+M+1+LXnP7EheSDee7L7agKDLNYNKzWhkVnNDo4=
X-Gm-Gg: ASbGncsjOBhk3DoMxG/6WYbMjrUVON4FBm2vxCkNxkyUDEYgi41yb4yu53dau+C/vZE
	jaEeDUVniongEScCzB8M5PNY/ywhGDDlDe4KM5ZKM5HPiu864MPWdrCG+5FqyVDNPtBnmg5eaMx
	Oa47Hl5RZ3WYdxj/2NGHYT8vdSWyD2dUVJc9ea6WgiEi1VlZMj5pw8cDdDMWCSXsc7ORcvYjwj+
	QFexlUenk9hsRzgXrznZTNV1HRt31UqfTfSBRQ1XkRoX+P94dokjXIawdjBi++LcG5MJZLt+xc8
	59TFCWvuq1nV/np91YJ9PyFXpzoyfNS0ZaoVbSU=
X-Google-Smtp-Source: AGHT+IFldPkZpv2kJ63m7xgTDZKmiC0tyADxjEV7SCj8JMUwdDjNdLorP+ADGNPiJpOiUHA/i9w22A==
X-Received: by 2002:a5d:5887:0:b0:3a0:870d:3152 with SMTP id ffacd0b85a97d-3a099add459mr2742549f8f.33.1746198935589;
        Fri, 02 May 2025 08:15:35 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0d15sm2456737f8f.13.2025.05.02.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:15:35 -0700 (PDT)
Date: Fri, 2 May 2025 16:15:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Remove (explicitly) unused header
Message-ID: <20250502151537.GA2724505@myrica>
References: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com>

On Mon, Mar 31, 2025 at 10:23:11AM +0300, Andy Shevchenko wrote:
> The fwnode.h is not supposed to be used by the drivers as it
> has the definitions for the core parts for different device
> property provider implementations. Drop it.
> 
> Note, that fwnode API for drivers is provided in property.h
> which is included here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/acpi/viot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index 2aa69a2fba73..c13a20365c2c 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -19,11 +19,11 @@
>  #define pr_fmt(fmt) "ACPI: VIOT: " fmt
>  
>  #include <linux/acpi_viot.h>
> -#include <linux/fwnode.h>
>  #include <linux/iommu.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  struct viot_iommu {
>  	/* Node offset within the table */
> -- 
> 2.47.2
> 

