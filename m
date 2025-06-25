Return-Path: <linux-acpi+bounces-14606-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9713AE88F4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5931787CB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB82C08B2;
	Wed, 25 Jun 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4easKFl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080EB2BF007
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867135; cv=none; b=qJa3PGs6fJiy71heolqL2PVGC/FTwfmCaUbilhPH53u6XqkNM01bNXTncL/XCPMs5qR/2nRL7J2T15WaF0csnVaP473r7amS874DbsTb0P62n37kKL2Te0Xg2DVFMmlBfJrwcianOIJ9cBhIF2V1iKgfwKlhShi8BGZrwis1PW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867135; c=relaxed/simple;
	bh=5ivSU5P1ybOP4JXEyPg2b4KE7hth8e9XxndTgLMPwek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWgeAHBmS2d+FLsfk+h3aZpMZGgLL+7CbrzrC12rfYddAnB1KBXNocZTp0D5Mgtao4s0nlxS11BOu0MuQVm1uB301kjkH11XM1w9Fd3+/Pvnb7NJcVpntGnjI1M2e95x6zo0mDE8B8Dlzn74+mR/IBV6YLHg88dv+vkBpQYl2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h4easKFl; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2efbbf5a754so63693fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750867133; x=1751471933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S50u2pGmO0FJNNUATSBkFdTyq4cP6tNm57kv4SYiUhA=;
        b=h4easKFl3gNSZbbw3TX8q89MHFIeYi+sajm30MVRaNq97IZnerBVflGYVim3nf7WwJ
         cf1tLbBxnM2mLfr1+EIybCkcwnGnP+ulxM347jWEBm0fOvBRkp+b8KDbulOMAqpG5oD0
         dQjvOSmf6UBugRsp44Yp1Q6F5/Kl+A6e1P0Il+MCO2ejYdHIACS8PA0/rN9N86pVfQk8
         R8BKM2D0Xt6oM03CRkWdE0n7BAZd8hFUpV37LPyqaB0MB2rHH1nairxKN5xPq3LZT2F8
         bn6KO2pOyfBsSreyKWcbLFpId65ebd1ZizyvAtoyrL7id9YKrqfngvjgIsBeKGhjzLFm
         yoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867133; x=1751471933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S50u2pGmO0FJNNUATSBkFdTyq4cP6tNm57kv4SYiUhA=;
        b=DjXUT/GQRFwYl/cCdqNcOmUM9BrZZChhxNrlVBk2ZMMRw6Ii7cNpLKCu54KBfTsoCI
         o5Trl1PmWL/RIFT09hzB7LFUvdmCXE2GBmEBe++jyNR7sIVZjdVqgvXARw4RsmGbDoW/
         PLJDFKRBHlM1M2Dlxfdn5TVggJQBxZBQjj75rdiwWCBbDyymwqXYiKnfNRIcWD+hfCUS
         +c+BPwM3dB0P37PE5tNieM5GbOd39esCBJUhmMRvZuqXkrGfi5k2woylD3cfPYH4oFV0
         5iZLlsPGgHWnnTR2+7TQ9YFg67LmQhE1ZMpgypvQEusM5v7d8C1Wr34VT55pZdvwh8P4
         9zJA==
X-Forwarded-Encrypted: i=1; AJvYcCXWxKk5kK3OJjJYcY7x3bfrrNiA7hK/H8sw9ax+X5AbDdh6anSGqsAIH63SlOwMcZ60F7SsMeBp3VEZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2DNTgkwy12rNwMQHR9/pz7CJdEQ/6dELj/CWAdCo63dJUxlm
	3SvfFbvdS5Z2twXxEOe4FRqAL1M6Xo6LxWb7UCghYpZi7baEhmNU4CfRAcKOZl4fI1s=
X-Gm-Gg: ASbGncvRe2wdzNpTZ6d4APc99KoswHZsA8sqfBfVihJMkaQbvX29zpggmXgtxtge/L+
	aE04FAXDbI1NjvCA8zB2CGBI6gtoQzQbxAMTBBZUFRx34coOQRLbOyelVMZqfiufdAbSGdLyNHy
	7xR8SA+0xCeSDfGZ/BZdAAs0CIYRFQ3QaIKGMRBSCDDikToWrWx+GoqZ1XoieY/nZel6y7TrwuP
	LqfnCKD2xRk7ewq6te4bmXzkS5sKh4hOXRauOjIspgjHfySZwSop4k4HpYsMNtzLhYmgT6mSdE4
	0mqL2NZ9qo9p4YEZcMK5THyEJnCRMgmFOGLMqXxaT9QROB2ZfH/J6bn9adnfc9rw3bA=
X-Google-Smtp-Source: AGHT+IFJT824h/fVUdrtP8VolwifhwFVWo0IkVtlZ5cdp9VZgCFy3WBGpkfdsvju1vACYv0c0xsXRg==
X-Received: by 2002:a05:6870:8a0c:b0:2cc:3523:9cd5 with SMTP id 586e51a60fabf-2efb22133d1mr2422068fac.17.1750867133090;
        Wed, 25 Jun 2025 08:58:53 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee8a8ea97dsm2626851fac.29.2025.06.25.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:58:51 -0700 (PDT)
Date: Wed, 25 Jun 2025 18:58:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Message-ID: <738b8abd-5825-48cf-9c5c-697ae057ab79@suswa.mountain>
References: <4d800ffb-fb1a-464d-adcc-2802187cfa9a@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d800ffb-fb1a-464d-adcc-2802187cfa9a@sabinyo.mountain>

On Wed, Jun 25, 2025 at 10:23:26AM -0500, Dan Carpenter wrote:
> The "einj_buf" buffer is 32 chars.  Verify that "count" is not too large
> for that.  Also leave the last character as a NUL terminator to ensure
> the string is properly terminated.
> 
> Fixes: 0c6176e1e186 ("ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/acpi/apei/einj-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index d6d7e36e3647..e77c0d4b4ee5 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -826,8 +826,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
>  	int rc;
>  	u64 val;
>  
> +	if (count > sizeof(einj_buf))
> +		return -EINVAL;
> +
>  	memset(einj_buf, 0, sizeof(einj_buf));
> -	if (copy_from_user(einj_buf, buf, count))
> +	if (copy_from_user(einj_buf, buf, min(count, sizeof((einj_buf) - 1))))

Nope.  I put the parentheses in the wrong place...  Let me resend.

regards,
dan carpenter

