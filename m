Return-Path: <linux-acpi+bounces-10134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A759F174C
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 21:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE417A02C9
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EC190068;
	Fri, 13 Dec 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnh+Iyph"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6A18FDBE
	for <linux-acpi@vger.kernel.org>; Fri, 13 Dec 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120840; cv=none; b=b8FYyJAgdyDOoVrC9qpliWxZPsfW6MAyQfowqs1WzB2/1LErdEbMt1M1J3Qv1Hd4Jo2jr60zcJJIjXc59BqJGTw6LEfMaVhlkPRz67Yc7v8g+uS5swhY3G4uy48m9lxKaxYTMReFNE07ds2tlguzo5BjLrQ1Zi6apbhSsU3SZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120840; c=relaxed/simple;
	bh=f2jyOe+lg8F1rPmqbu6chfwX4anYDD0i5ra/as4BSA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBVUXbjE/6UPHP/hoq2rTQz0NL010qrQ7S1e4qW6L2Bp2mW7hJY3Zj5qWF1tVZAqnsUMRuliGFJG6PQas8U7wh9+oceD2vRq9fVzUDMPj09mUir5GU/E+VSW6nMCsu3nV+NvKtJYU8Rhj00jUwXtCKhhO/io+IkbGAOPE+kNiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hnh+Iyph; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc93152edcso1775735a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Dec 2024 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734120838; x=1734725638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA2vp+0Q4hjfylA+aN4ZK1qWmF0cLRB2spMI6XM8wUI=;
        b=hnh+IyphpXPI/UfAnVsow7vFiYny3cbbkGxQnLbht3pRATm31pL7PJCbHV2kIajQ1B
         mLLNxjG/AihUqqAabp/naZqykHbM25RTv4WtWXQK1aj6J0T3B0y9o4TtAprV5rxnX3vC
         n7vXlVW71bAaK+UKh7dpjPJjR+FcAaIhID6XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120838; x=1734725638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA2vp+0Q4hjfylA+aN4ZK1qWmF0cLRB2spMI6XM8wUI=;
        b=rlkwHf+VYXw7Y+8BhZv2oEMl4n5A+nTL/ueCjqhLgHwe/Q6cgJxPwNo1OMIzFy7bJI
         tBfRIs9mTv1EZI1HYpSyci5klzxbseGLKosB6Oz7wo3Or9OSoKFnVjJkPbvSmu5iP99k
         vpPN8sJbaFH7c29oz17C7ObWuIzQUBUaYRI6d3jG2/kZPe02Ui8XWoBn65fypJdmpPZR
         wnRMPUe8jdFcUT/1cs7Wnjwqr+ylwQnFs443zvqIER0mWQuv+eOV7ByZdcYo1FM2ymtp
         vBNxmsRqnM19fZDTMrOkuJi8c5d4ewJ/x5+SONEqaYdv8zWQvkdFQobEwjIiqHrwOJXJ
         ENzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpRPVKelY1gdpvkND/OAPy7zWt3SaAfqGlVRqB60+z2vSix7Uhr6pKo7N1lis7o1JvRiadHPRiJn+M@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkLQ2Y6ssiJRrR/mYVfrF51RwAEg7lk8vRQHHjzBsSZXNdL6T
	4cCQCSIIohsGKogcc/MAAkfHML2AatCAvsqvdFGlWqpOruGEdFvQfiTO30r6HQ==
X-Gm-Gg: ASbGnct9aOBt/0QgESg7hwd3bp9j0WXzjTO+zPVCT2AycdHk3xUHDIiPmlk+U5auApm
	KxtxT0O0Ux3f4ePHFUxSmy5/R0MuY2sHxYeInrv+b3GDGEZMReWT7PpoIPXIQ5d9qL7z+xYDMmI
	h3+ql7ZXtO64NTsgChAoy2Slnj3WTlBkDBysHP6nkdrPmXZIpqN//ViQ+mnsfqTCLA7qiu+hnwB
	cJqMTOorHVmfjMGBovr4uTX3/E8Vi8PM8hv4OzV9ltaYa6w/F0r032mdY7HW4tptH/HHEbaXbzc
	GynWD5wC4UqiwnRAgQ==
X-Google-Smtp-Source: AGHT+IE2v3SR/KU8sT1pXTDInylE09uN/fwe8e1DJVZHqAxSyKPgCbB080FVuQIdjxru6cGbzDWahg==
X-Received: by 2002:a17:90b:1c03:b0:2ee:9229:e4bd with SMTP id 98e67ed59e1d1-2f29153af6bmr5376411a91.2.1734120838389;
        Fri, 13 Dec 2024 12:13:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:356a:489a:83c:f7d9])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f2a1e9c561sm177437a91.14.2024.12.13.12.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 12:13:58 -0800 (PST)
Date: Fri, 13 Dec 2024 12:13:56 -0800
From: Brian Norris <briannorris@chromium.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
Message-ID: <Z1yVhPJjxKhsc7VE@google.com>
References: <20241212003201.2098123-1-briannorris@chromium.org>
 <20241212003201.2098123-4-briannorris@chromium.org>
 <20241213-athletic-strong-bumblebee-bfabf1@houat>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-athletic-strong-bumblebee-bfabf1@houat>

Hi Maxime,

On Fri, Dec 13, 2024 at 12:59:57PM +0100, Maxime Ripard wrote:
> On Wed, Dec 11, 2024 at 04:31:41PM -0800, Brian Norris wrote:
> > --- a/drivers/base/test/platform-device-test.c
> > +++ b/drivers/base/test/platform-device-test.c

> > @@ -217,7 +219,45 @@ static struct kunit_suite platform_device_devm_test_suite = {
> >  	.test_cases = platform_device_devm_tests,
> >  };
> >  
> > -kunit_test_suite(platform_device_devm_test_suite);
> > +static void platform_device_find_by_null_test(struct kunit *test)
> > +{
> > +	struct platform_device *pdev;
> > +	int ret;
> > +
> > +	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > +
> > +	ret = platform_device_add(pdev);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> 
> I *think* you have a bug there: if platform_device_add fails,
> KUNIT_ASSERT will stop the test execution and thus you will leak the
> platform_device you just allocated.
> 
> You need to call platform_device_put in such a case, but if
> platform_device_add succeeds then you need to call
> platform_device_unregister instead.

Hehe, well I'm imitating the existing leaks in the other tests in this
file, then ;) But admittedly, those are a little more complex, because
the unregistration is actually part of the test flow.

> It would be better to use kunit_platform_device_alloc and
> kunit_platform_device_add that already deal with this.

Cool, thanks, I'll use those in v3 for my new test.

> The rest looks good to me, once fixed:
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks for the tips and review.

Brian

