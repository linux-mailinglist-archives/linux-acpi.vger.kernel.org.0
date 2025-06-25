Return-Path: <linux-acpi+bounces-14625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBFEAE8CCE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A31316AA3E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74ED2E06D1;
	Wed, 25 Jun 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+vlhtDq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2A2DECC8
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876861; cv=none; b=phDca4t8Kw2+YTkAHHbSxpsgPatrERYeVwHB2NJAcQ+c3LKE0oddLElowc12qRBwC0R4f80srSAHTvt465UHFEoWwzdOsxmYLaANJ6yKm3kJK1y+19N242k5gxj/g/+5iXjVp53JApwaeCIOY3zCbXyEmIhWEB3NGM7XFd6C8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876861; c=relaxed/simple;
	bh=N1GrLsO5rn46Kd+qcM63O/s4L2k9YjjCFe0dE2dULaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5gHYc0KBlQUrVWhb7t9Za/FxEYSy/Drn1ZH2hpSLrsgjK57FgxS/4y1dIPSzrbL3b0oa4EXPwPPBXyd83UIIRvxdyJpEnZrQlbJ01u1LoJwrpjJNq0+Yo1zeFvlooBgK2PTnvFbGyKjO9jRFU/35gN9WRLB8DvsPUlO4iXpLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+vlhtDq; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ef493de975so138148fac.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750876859; x=1751481659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb/xkqJYQLzIZ67OSg3QEbtD8orcI+NoBMOMxQAdNnU=;
        b=h+vlhtDqwBMBdZ3GGagXoA12jRQPy5RmdQZ9h/wCF5TPLzd+CB3ucvNtVQhE1fzsx2
         psTfFcQolc1oYKpqof5UfBznbCvjDfDH1l/0YzMeDr6x0JiJhmF9tTxApa0Eprl5C8XC
         74l7BIpdjxsf5ro1TGlZWq+8VXgrcVQqusnDX+jbwry3+MUGhtL+NPOxj9JONmpodWrZ
         b7CBxNTZZDlD4hpTvOQSMRYwAsbrjJVYrQebp+bdVICAN555le4ZlZQRJbk9ULGkABX4
         /yxZeCm/BQkCxAKIdYrmAKv4i4xQMllQIJxeuvuMyAjhy1hmyXUOAF6vQF2CKzfv/Eq+
         hkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750876859; x=1751481659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb/xkqJYQLzIZ67OSg3QEbtD8orcI+NoBMOMxQAdNnU=;
        b=eGhH+i9cyifiVJcBplgvNmdPD9PX9Pi1AIvc1vvDzLTGnMOfyIoTtUbZCXq21xpVjX
         D2q6/JRatcJs1ldZsT8twY0LLeXhe7MJuqbqw2xFieTcnBW+aWkf5zsurL7wH2yuTOlB
         GRNsvsZA6P7m+d0AQTAyPKIdr3Tw2nldCpl1jTYcJucOR5CXABWMzYM7cJAr8mqiyZck
         rbwlKzf+Nl1bibhwUjyCcd+5v8BBVe4tEvXbE3mb/4EI5PlbByMoCUppNUt78FAZ/5ud
         ktt1+5CsbSTqKj3h4jomSBelsKwo18vUpJ2u0KpdpRnaEC2iDhepXaO3RLpAdlnU1RX/
         rMTA==
X-Forwarded-Encrypted: i=1; AJvYcCW3DctBeZQKS4HPpVeOGGNzldoo6Y8YOdpg0r8ltyaL4A8bzRYgvsIwtc+WJfZONwmulC/VY80VTalI@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwf4PLxRee30IGq2O/9KWV/mCVLNblWl1u7LvxFaeRv1+LGw4
	tqCl4QN9HpBuSsT4L5to5ZqixDRys/kmDjj7ykQ2TmanoxW5JcCaXIRp37wXtR4sZEU=
X-Gm-Gg: ASbGncufYS8ETUSjYLtylGsGyXgg6u9ZXbKHeCQAk3MPcjqzATa/zP0kOMMBKJ1YxMG
	79MJ+U6SJ5RAAiu/SrQdEz1oU1KkhewCvZ87aHYVxRo9QMwemDYnwWOYakPw0dvPuP/ZedBq5Fm
	K6FZDt9d8Vd2uIw1ABMiwUdJ2UYkFhetg8zq2DhcUQqaBJTPisThZz6e8KvysawpG7pebto2NTj
	Hd+zWCJRfe4B8QrkvuDI926qlQRopBZZzEKBzy5wqWYcV6pf9D2CxzbRmoMZFxEt9oOVFh0rdw7
	WvWgr5s6rS1Sh3Rri731p2bMWnqMBzWekZ2KAVveoINcH/jjNSDmOSv/yp/cVJ1hWvePnrXdnZO
	c9A==
X-Google-Smtp-Source: AGHT+IG+FodkH8YjDqJZ084eAzz89kwRqhC0U0FmJInHRKqb6H43Svn4QKtYMZJI20MCcSldmzryog==
X-Received: by 2002:a05:6871:e488:b0:296:a67c:d239 with SMTP id 586e51a60fabf-2efb21af511mr3039710fac.12.1750876859338;
        Wed, 25 Jun 2025 11:40:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee66559db2sm2665582fac.11.2025.06.25.11.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:40:58 -0700 (PDT)
Date: Wed, 25 Jun 2025 21:40:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Zaid Alali <zaidal@os.amperecomputing.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Borislav Petkov <bp@alien8.de>, "Weiny, Ira" <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2 next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Message-ID: <be2b886f-4de7-46b5-9cc6-cc5299b1af02@suswa.mountain>
References: <c71e7ba6-f127-4f49-acbf-20063dd26553@sabinyo.mountain>
 <ks34mfmv2vhwojpxlzv7tyordcjdo6zclcflplvs2wsl6gkbn5@3v5kguelmita>
 <757b5117-a865-4d31-b566-248048f87b29@suswa.mountain>
 <SJ1PR11MB6083603821632C25DA5D8EEBFC7BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083603821632C25DA5D8EEBFC7BA@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Wed, Jun 25, 2025 at 06:22:57PM +0000, Luck, Tony wrote:
> > > +	if (count > sizeof(einj_buf))
> 
> Why not:
> 	/* Leave the last character for the NUL terminator */
> 	if (count > sizeof(einj_buf) - 1)
> 		return -EINVAL;
> 
> here. Then skip the min(...) addition below.

Yeah.  You're right.  That's a better fix.

regards,
dan carpenter


