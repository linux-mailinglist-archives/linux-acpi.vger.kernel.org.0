Return-Path: <linux-acpi+bounces-14589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B511AE81F0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82A2171F8B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1AE25D213;
	Wed, 25 Jun 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcZ6Rw2i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADA25C704
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852256; cv=none; b=dZoIAn9Hw4wnDIDlKIddZ7T6krlWs9zl2ydNDiEArmNvyB6Lqqa90MnU5Q55juXrF4fPEDqyTAVkqCFlLpTcUrlJipgayHzFe56xhqh3ynOtH0XVSuUIaTpHyNK+jRXmjWR61dsoIKPL/zyQAOHljA8HDCWfCHtAcAuk3s0SGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852256; c=relaxed/simple;
	bh=ccKVrwIbREFXa4j7XcS1J1dbdZcxku7g36ksBtNIWss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WinLi3teWSN1io2pq+wHGk0u8JxD0kvIW/aNadoxRX9/EHBnRZkIkI85KnZb63LtQUxKHf18B7fEQhjBUMgo0IQrm4SzvDvlnX3QXb5GjCc/EKHAkJcJcWcMNMqD9uXKuvL544qTk8dVp3uPIiAW7mrusZm9cmuNCwm2kAIGcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcZ6Rw2i; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ea58f008e9so4981017fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750852253; x=1751457053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoutNGAerTcoF/aenrsm72CtVJG212QTVx4YhnzRYkQ=;
        b=YcZ6Rw2iiUo0d/sP97IM92RZq4tDAZiQyKcL8QUOQfWN7APNa5yFR6WgvYJpTcRO/k
         S5C8mFIwpiY9hGlsnCX8IpoXA4E+hwJDQ9ZnBjQJJpbDKW8aSXY2Jr7ugztdh3/9r3U2
         SVaMIUAhZ/js61l9kg+xl1qSUPgJM/l9oW1qnQdwNbSEPbbHsg5jlxkzO9sV1K0F9qEf
         zj1qp97U5caV+Vuw4Gk/FJcPXggzduj/RcbBX6K5QBdKR5dIC88zCA+UPqH/QD/lsrnd
         PQOu6DqlA7U0ws6s7gwEpzFkbvWcXRdwvgMFtNIo7qoffzeyXXyZGepLQuh/BHqFFpbr
         s9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750852253; x=1751457053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoutNGAerTcoF/aenrsm72CtVJG212QTVx4YhnzRYkQ=;
        b=GqXA8oifVRpiouFbbgAgJ9bah2074jg73Aj0W+8E6FMQ/3900JbI7jC/UvM7hXCHh9
         oUEO52JHIoiZaiZ/nsDEk0y2gaalLrsrQf5qLQtlPlluonVEWZkTmmBhscpwGeYSMeYS
         c+kTiHxDeVjh9jKa7iguTbN5rWdC1olhXgArW3wEY0wM5H35bu9u1G6xwkFgKw44nm+0
         dduK/ltpCaJR8Apc+uJZCKvtbbr0dgkiFuzZlGmgxA9NaOV/iUyM1WrwOhhfwMBMo/j9
         X7VrDCwULFnJfZc8TQ7WUQT1OUOl5ro8A/qUgRQLKeaZlsACr4PFe+XmJYuqd0PJZReu
         UTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVztrUNGDvlGsdROiOSt8pgKTn6+0SGQqLaERzB+31mzHooA4n0MOegYxBit4CS2nLYTuhIouvVyaQk@vger.kernel.org
X-Gm-Message-State: AOJu0YwL18oUiuSfYgn6sP6xdMkEmpnSXSPwngHrbuPQNKrNTgtgWf29
	U6NgXVfcqR/U5qOtFJxPuXOOXDNpjN4fi4MASEi8PPuWBe2hOw01UFjtodw9tlMhEtQ=
X-Gm-Gg: ASbGnct9Z9JhF1+nDAsHyBsFYHVJN1pYreAbzKJJ12b6/a8Pzxx9FJBn04hZxgXdasR
	DPrlXRmsEdKyoINnZJS5mDjbnkW5MLppkZb5K8BscQbxp17v1ydyROc8jP5JuO3vVa92Uwee4xE
	hGPAfPGy6GHHIZzhQWaWCG5/2j6LRD3xZoQnAvJZ5+H1kx97GzncXIXdgRslOSDeEMBhRnyFMOa
	ssl0c7coOQFYnuZSunBr6XG8r+mrBIpp9E4h5UUEvpLhEQ69qo+ashUjMGzlfjIj+sQlM7UOT7S
	MTghq1JEJ7AcEMwnN27/3VnGtpausFh2SY12qlUErVxQVLtV5ZHd1vdymDx6niYOTUT0cFEO+NK
	dZTdd
X-Google-Smtp-Source: AGHT+IHhifNSUvdslHEt+i0G2mhKHrYMYK7cb4RljD3ks4W3/ayaA/WwVBmac+YjncuYOBkqkdy7sg==
X-Received: by 2002:a05:6871:2104:b0:29e:4ba5:4ddc with SMTP id 586e51a60fabf-2efb27645a8mr1809349fac.24.1750852253475;
        Wed, 25 Jun 2025 04:50:53 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:22c9:dcd3:f442:dd1d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efbd439555sm185735fac.25.2025.06.25.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:50:52 -0700 (PDT)
Date: Wed, 25 Jun 2025 14:50:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of
 uninitialized pointer p
Message-ID: <ba07c097-80e2-45e2-b579-fe270c04fabc@suswa.mountain>
References: <20250624202937.523013-1-colin.i.king@gmail.com>
 <31b6548f-8ff7-4bc5-8a2c-78a5a9d5eb40@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b6548f-8ff7-4bc5-8a2c-78a5a9d5eb40@suswa.mountain>

On Wed, Jun 25, 2025 at 12:31:10AM +0300, Dan Carpenter wrote:
> On Tue, Jun 24, 2025 at 09:29:37PM +0100, Colin Ian King wrote:
> > In the case where a request_mem_region call fails and pointer r is null
> > the error exit path via label 'out' will check for a non-null pointer
> > p and try to iounmap it. However, pointer p has not been assigned a
> > value at this point, so it may potentially contain any garbage value.
> > Fix this by ensuring pointer p is initialized to NULL.
> > 
> > Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warnings")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> 
> Good catch.  Apparently this isn't in my allyesconfig.  It's weird the
> zero day bot didn't catch this either.

Never mind.  This is definitely in my allyesconfig.

regards,
dan carpenter


