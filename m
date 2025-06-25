Return-Path: <linux-acpi+bounces-14623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA2AE8C2D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B94A5953
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F92D5C95;
	Wed, 25 Jun 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIBUPjQ9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750C2C17B3
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875568; cv=none; b=AwRw0od6DLKzGyVvp/WvL5hBgaY1wCW1NWmPhjeW/C6yVUkOLAQJpWCjmH5urc3jcVgyvCn5DYlkkWufUJKGBBYKBX2apzaVfYpAy625TyOYi0aolBt8GXOayDobiGMQz48Tz+qTFT51OK54U7c6F+54u7P9xPbD0ZZmQle8dMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875568; c=relaxed/simple;
	bh=Jfj5qnXFugsOMh6HpU5RjfMH6+e8axtkDbqBf4lvN0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXRYucrShUnqcLaw0KouLiSh9DKXHAccI0/DeEezxZPU8nFTy/a7ro0Z56AfJTShncB/ZZ0GweiuOhyxhvOj55MlnMSZqp2jtE2d6CLiahDzNXjiFI63XlESK+sG7II5RCtyA2BJ2E6ehi71nSNwlO7ZlP48JBqhHPCwg87HBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIBUPjQ9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4067b7d7e52so55787b6e.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750875565; x=1751480365; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Dm5388ZZrY1U4+efN8p/OTMRUgs76Nb9FuLZ9jSeOs=;
        b=gIBUPjQ96a+Lg9983NJrNYvY2HJ1SedKuihBTsBolYzOwcq2A9pgJ8PNSNt4QEb3YA
         qBXHsJAXFKWdLSaflPUayl9dbT5IIC//HQqS3WLhWgJLPqT1477PSgpMTFpfqUY4SLBd
         wmnHP4cIf6cnftPnhXnVSKZD2vd0y7wwq3iRoQJs6Ctdbhr3bi5EI185KfYupuUMUjBo
         Lo/AeDzdu8WOgxl53zsxSujFt+WomBWmUUR83ZIpvIm0wpfokOvIzNkUab8MFd+RMa0G
         sLmyfIkwsX0eeqsDFIM1JsHLD5ON2Cex/rfttEz88oTRsUbK8qAgmI0Qna+l9N8EQify
         SqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875565; x=1751480365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Dm5388ZZrY1U4+efN8p/OTMRUgs76Nb9FuLZ9jSeOs=;
        b=VY2zz7wUNu0xpO28BBAmlmUeq0Clx/SjPNdZ+hedJiZBAW5JeJWR7C/T7Zj4tJiGnv
         HHDCal1Opzj/ROXCMx8ITSsEmgONNXdJ1OH4ASfAWObCGbUrqA3BaDA9PwL8qsnUIk5b
         O7ZA8aOfNomWQPWgE3V6UWUL/V+NnEqc7YvG1N3oNnmJswNRpQcJjIYy+TL4gu2OQcCp
         0UGiqoSw7Tteo/gyZW2sIyOd+m6EbrjtLkfePweNq4ijTKZR/SEmd8c8WXwuMAwhWZWn
         eddr+xaSmzSpqX9Wxlcqq7waz35oZ2jW2TFrFpUnwYWhSAzPB/N+s+pr2otZtoC/pMRt
         Nfgw==
X-Forwarded-Encrypted: i=1; AJvYcCUWV7xSNSN5LWjPi9Skp7gdHn/8ZRB0ZPr1O84EqlHclQKPMfypnHvInc3oe09WPrlkSp//8hfV4mYQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd47OUedwaGjVREpjrkAXHXZnkp90FFkPcwcX52ZFWBA9sgMmC
	mGTwff5p8EasFb97ccgxmyUFzrlAltuAiUoRUKkhEzYntDR7snzJpQ8Az+vhqpJlIq0=
X-Gm-Gg: ASbGncuCI9+RecDwbVGdMCMyFBPuO5VljSwlqwrW661uX45qJs79nEc0rCZNWyBnAda
	J7+YeGHcnWH9W81PYUoiovUJHeYiYmF8T+M+HSWdJ0xpAWVP02DLwy29VKLFierjzKowrV7Ky3g
	qTHwC97iurTH+HqPP5weT9uKOvWb/fWL/EnoiVRCGjAxQn9HJi6BDHeAMPEdIk7qVS3UXii9V50
	doyVcDhplWNK/InHvAEgDlyMEazWJQYZhUNFcC+jRHOr0wn15a63FL19RKhbCIC41ab4Ecusrp5
	SYRIe8OVcUCThi6f6fzDCeumHY6pqfnmt+I6klbxWNmswAQpzwzXuKkgPuSym+tuxfk=
X-Google-Smtp-Source: AGHT+IGyEXNA75F1Qnqm4F8gyjHFHlyO/fw4ijh8dQyLEguVkILpGruCyf60HTw4fIUAOctXuX74UQ==
X-Received: by 2002:a05:6808:8204:b0:406:6a21:527f with SMTP id 5614622812f47-40b05c75308mr3205199b6e.35.1750875565621;
        Wed, 25 Jun 2025 11:19:25 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d22c23sm2280631b6e.42.2025.06.25.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:19:25 -0700 (PDT)
Date: Wed, 25 Jun 2025 21:19:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Message-ID: <757b5117-a865-4d31-b566-248048f87b29@suswa.mountain>
References: <c71e7ba6-f127-4f49-acbf-20063dd26553@sabinyo.mountain>
 <ks34mfmv2vhwojpxlzv7tyordcjdo6zclcflplvs2wsl6gkbn5@3v5kguelmita>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ks34mfmv2vhwojpxlzv7tyordcjdo6zclcflplvs2wsl6gkbn5@3v5kguelmita>

On Wed, Jun 25, 2025 at 08:04:14PM +0200, Uwe Kleine-König wrote:
> Hello Dan,
> 
> On Wed, Jun 25, 2025 at 11:34:38AM -0500, Dan Carpenter wrote:
> > The "einj_buf" buffer is 32 chars.  Verify that "count" is not too large
> > for that.  Also leave the last character as a NUL terminator to ensure
> > the string is properly terminated.
> > 
> > Fixes: 0c6176e1e186 ("ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: I messed up the sizeof() calculation in the copy_from_user() and I put
> >     the parentheses in the wrong place in v1.
> > 
> >  drivers/acpi/apei/einj-core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index d6d7e36e3647..2206cbbdccfa 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -826,8 +826,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
> >  	int rc;
> >  	u64 val;
> >  
> > +	if (count > sizeof(einj_buf))
> > +		return -EINVAL;
> > +
> >  	memset(einj_buf, 0, sizeof(einj_buf));
> > -	if (copy_from_user(einj_buf, buf, count))
> 
> I would add a comment here to explain the -1. It's in the commit log,
> but that doesn't help a future reader.
> 

Sure.  I can add a comment.

	/* Leave the last character for the NUL terminator */

> > +	if (copy_from_user(einj_buf, buf, min(count, sizeof(einj_buf) - 1)))
> >  		return -EFAULT;
> >  
> >  	if (strncmp(einj_buf, "V2_", 3) == 0) {
> 
> Further down there is:
> 
> 	return count;
> 
> Is that still correct given that you read less now?

Yep.  If we don't return count userspace will try again, right?

regards,
dan carpenter



