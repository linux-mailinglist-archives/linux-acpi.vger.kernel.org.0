Return-Path: <linux-acpi+bounces-3781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8985D981
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 14:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22073B20EFE
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0C763FE;
	Wed, 21 Feb 2024 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzTsbrU2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6273FB21
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521561; cv=none; b=PywrieRKd08xJMnQ27W4I22Ej+qThk81heK+vW+kenSGKxDzIbl6W8r/wt3o4209js4EOl+4MPHZ8LIRGCkF1EHIit4qv5FhMwm4Fm1aw+BG3fk+cHRA16XLhdyng7zg8pBKgK4+knesm869q+KIRpQqkuKpfTMXQfwJ+VJx600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521561; c=relaxed/simple;
	bh=v7sh1t2tO3VL3q82JxTbVWXUuuW6ywKJik5QNS7wZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLl8vIQj0SEL2WGbqNW0KuIeJMv/rATvLP8+Afl42Z6D6mDaJ2z3GCnogbjJLwCTGYjADasdZFtqy3SNsUGCFrVVJ8NDgaB5aKGCzbh7MId1QXc5sWNtotU0JPqTvL5HOSqiYuihOIEkcE6Ij1Suq3Z+c21tVepe2Fxv34XOss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzTsbrU2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d28468666so490052f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708521558; x=1709126358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1S2KOzHiWZdc6EMCFLkKLCqiX/8caKNdzG63AOEvMU=;
        b=hzTsbrU2bq8I5z9x6tdxgKRQX19yea/2FkVfBoYAUFshrOeXDrQgKEhtfFsyVNFqKn
         YIPrid4ExsV/EoO4qV4PUANNxaF/DhYMNQsuQmT4Z22zfzK727qvLn7OuQ4EoARw2bnT
         XP5KXS7ZX5P9tH76EwVNpegs0u8kIoRfhveJb4vEStjxdjct9iE/gYItDRxT7Oo3ZhuX
         8jA9eWjTNa5L4fgF320SazlEdE83/rCCptMSCxOVAC0C7DDgH5oieF/T9FuhcE/bWv85
         pMpdhtuXGGsFTxPRNxIUhEdBiim4o0RFY9MFFz1VQexSRlKom+Rm8Y6MzZUV2p2KgxPC
         nuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521558; x=1709126358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1S2KOzHiWZdc6EMCFLkKLCqiX/8caKNdzG63AOEvMU=;
        b=gdpsr5RxmMh+CV4lM65QI05k1rED9jhStM1GzSovAuI4yFdPiJpL3aafWuBVxYIn24
         FNWS900TIOj9UA1nSEH+OOqBAVV6F/eFRzSwMJR/1+9AEtamUL5SE5haQpJdcHXk1XQu
         7U7Mwgd+C3P7GI9TAtXJfJulWejjFn5lu95bX+H830+FjVWmJCnxpTRHi2CHlIs4kQAg
         rf+Cq4PVmmu5S4+riZ4WnqdwmtAMX32VnDpHd1mAqKNoIpcE6xFMgeYyQP5mgv6IKczX
         65JtDOMCt/IJPA5IDkkeXsWU9jOS12x3Bv472PDxeuWs8KsoOhjYwmeFHnXinc+VKitC
         sBQA==
X-Forwarded-Encrypted: i=1; AJvYcCWkXtXbVwnCQIIXEid2ddUx/jYtY5ERyS0kgRlH3pjYWRP1i5jJxqeAQH7YEcpSfKjklmJ3owzR8QwOJkUwYy2Y+KDRAKlO8mJetg==
X-Gm-Message-State: AOJu0YzQs9K1jvikyMErQuxxwakkw0hCMka9wZhhvEBXMeWDFXKWgaGj
	oxO0BoFTJkRwicSgFVQ9f5+T2ipUgnFJRMNSlPCJA81eERvFmcJPfFayw21xMIo=
X-Google-Smtp-Source: AGHT+IGUhnYBb72HO3q/troMrrl1Yvh0UUzCGFF2i69FmxCni6Rzv9DIpeCKiR4J0QtwMZGzWpNw9A==
X-Received: by 2002:adf:f0d0:0:b0:33d:174e:4813 with SMTP id x16-20020adff0d0000000b0033d174e4813mr10817748wro.23.1708521558177;
        Wed, 21 Feb 2024 05:19:18 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d5687000000b0033ce727e728sm16683728wrv.94.2024.02.21.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:19:17 -0800 (PST)
Date: Wed, 21 Feb 2024 16:19:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ACPI: thermal_lib: Add missing checks for errors
 in return code ret
Message-ID: <68571997-c33a-49f8-b922-4b102e5b682b@moroto.mountain>
References: <20240221123936.3421462-1-colin.i.king@gmail.com>
 <4b78456b-071f-46c0-bb47-919b493cab79@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b78456b-071f-46c0-bb47-919b493cab79@moroto.mountain>

Btw, in real life, in 2024, the compiler is going to automatically
initialize "temp_decik" to zero.  So we could just do:

-	int temp_decik;
+	int temp_decik = 0;

That would silence the warning without affecting anything else at all.

regards,
dan carpenter


