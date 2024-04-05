Return-Path: <linux-acpi+bounces-4664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6236899670
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Apr 2024 09:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19ABB22E3A
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Apr 2024 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69E22E85B;
	Fri,  5 Apr 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eD32bQH/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B6364B1
	for <linux-acpi@vger.kernel.org>; Fri,  5 Apr 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301795; cv=none; b=YekyD9Zd0PyJqlP0ykPBuNJPS3LxikmA/aEqiXI6n4NDm/ce2j+QBq0fOVy9HP0+4vGeEF1XabGXBVRJZGnZHYUpQBjAVtBk6OTl0fjDZ5vfJDppMxKYSV4H3fxQHhoRnn+ZkPUuRDjhKPMYcA/oCYDHYpYH30GIbqq0Tv8XTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301795; c=relaxed/simple;
	bh=+tNTqydU4581p38UmnWmCeIibmbcb+alKyUkuT1zHJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzo4Z9kgnr1UtpF2dmrBXnNRbOwue+V0fBYpXAmwLHhPynLipkNmNs2j9twZs/IGuPsV923BYfaSZenvjckVy9HLVij8yzmC5IXh9r14Xk4WSKE0SrLmKv/ncODfJQvZoJ1PBJ4R4HeexyHmgluiJa2JniUq5MX26rjRtCIOzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eD32bQH/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4e34d138f9so264798366b.2
        for <linux-acpi@vger.kernel.org>; Fri, 05 Apr 2024 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712301792; x=1712906592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpWHBLrC+gnaL6TTZpQPIWKatda4WwjRCTQdFM/+mOs=;
        b=eD32bQH/HAC3gW9mYQVL3nd4FIHX94yWZ+SsaunqhHLO0NIGixCsjgdpevkvVKm7oa
         SSdgQg6finEP26Uit2WXYVG7iFPkVwv0ZF2c3zt7eCxJcr4lLlugJ32RppsBbyE90pu/
         cwmD2YEKxIscLIJc3o83Ke7uj9v0qG4Xpo6yL5GgSC2txwzhHW7Jzw4+cHykBrx9msNw
         ST+RyPrCiIx4F9f93v171ibjeyR6GGM88juSMK5cjjKFYuLqamVmytlflGCwTnHi9OMY
         t1qarQI75+OuGuvSNjYZ+pa9UXCCA7UHgWMi8VpCHuHImWXrT9ghmqWB3l048beShMxG
         pXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301792; x=1712906592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpWHBLrC+gnaL6TTZpQPIWKatda4WwjRCTQdFM/+mOs=;
        b=lewu1WJmC1pJwV+siaHU6qYE26/Yc2x+C+hpda0C6YF6JnQpGzF8D1MaUh/mjKmCVw
         45iF+NcNe/RIUxpwkrXKs8NaroTcLZndStsY50Ndle+5YOxoV/THlU6H6Ra8oIqfTMPT
         ESwcl2LDRmqYnhh5SIb3AVADlGNjh+sk3X6yQLruN+2rtlYzk5Ob++zRYG5+tt4VbtYt
         9rky2VGkGzK+lEYPqA23fp92SgMPhlHDzs5559NOZgx2ypz03xDU6UHnuNHOLfal0ClF
         9IFIcc+E3+fnYc8woBXF8uEZf8oc1yYByldXaSMy/6Pp8po0+KdDt9oU8wAoFmvxrwBa
         6Gew==
X-Forwarded-Encrypted: i=1; AJvYcCVcIl35+zNAekVQdfsIKc0kBWnXS2KPb6YI7aBkCF5vL1TzZwBRgpc93YmjSxnx/l1g3rt7o97vKtc8zIR80KGgCzTdFw8SItWa6g==
X-Gm-Message-State: AOJu0YxxsWyMrJvnmNMsfJND684RWhWDbcLkrae743ph9FwEpivhcwPR
	GYfN+wn7f8vFlQUOM7L+8pacBXGH4H7FaboFaEhXH1Tps6zixNAZPpEOKptsPQQ=
X-Google-Smtp-Source: AGHT+IHa2X947HJGnoLjdggroNUsEszX1cWQXP5frXhO7wlFmZu0gq410ZYzc/kn6AuszN3J8xTe/A==
X-Received: by 2002:a17:906:412:b0:a51:9916:ba77 with SMTP id d18-20020a170906041200b00a519916ba77mr361028eja.51.1712301792228;
        Fri, 05 Apr 2024 00:23:12 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b00a4e4c944e77sm523561ejc.40.2024.04.05.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:23:11 -0700 (PDT)
Date: Fri, 5 Apr 2024 10:23:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Update the kernel documentation - add
 Return sections
Message-ID: <b7d5ad29-1f0e-49e1-81b1-9400542a4074@moroto.mountain>
References: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
 <2df0e132-5599-4cb5-93f8-4ed664a5d1cc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df0e132-5599-4cb5-93f8-4ed664a5d1cc@infradead.org>

On Thu, Apr 04, 2024 at 09:10:09PM -0700, Randy Dunlap wrote:
> 
> I would s/active-low/active low/

Active-low is the correct jargon in this case.

regards,
dan carpenter

