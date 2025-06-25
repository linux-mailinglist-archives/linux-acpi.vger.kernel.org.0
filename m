Return-Path: <linux-acpi+bounces-14664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F43AE9236
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 01:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C507AD345
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBA329E106;
	Wed, 25 Jun 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9da6tqT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8A204592
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893518; cv=none; b=dha3t874XvWznu3aLRjAULkuCfl0qCucZy4Zi+yYUXYFdESDteebMBtiXqtGX+3Tnp1BGZg74DHGxN4HKKg8yj9YuNWF8e3S+PdfqJH/IyWnuXSQrDvaKulIsXsOq8eJUT6vBAa2RO+r7PAG/gFQquXss0OeayQfHi3Tkqc40DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893518; c=relaxed/simple;
	bh=o7nWOpB8g4zXrKnObOSxdMpT/uFNKTEpAMgxA33hsCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svyrS4mWr1dbcK4KI0Hyt3aEk+lceNQkP9M4sTRE/IoaHdJdHa6u6Xd6xq8N6lx8pd3DLDk9cIoXnP3Sx5lm1qg6DtN4T7prQXuCZ4IztRGz8anlJiL/SDapr+eHca00ff511RTXaRf/4n2sQXlEsuT7iCJXhOrhGVI6KHtC8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9da6tqT; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-401c43671ecso274588b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750893515; x=1751498315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3sVHvu6rqtfwSzthUoBWhxdxzvIuGv3z4vvAxvJak0=;
        b=B9da6tqTxZKgCi76jYrsE3NbCHbppkVYsBHEgRgO6HZB1G2Aw1jwIHjNv61b8VdOpx
         35fwFuwr3OdY1rwKlZj9uAhBYM3OltPHVGSnLGdqxeiHevkqH+liVoTg36RnEIfgaGGk
         MDE4sGotloFu8XLGpb+YGu2xCzsVMsskCSOgLcG3uAIttsWk6DHavIbBgPM07X7who7A
         5Z19xQ4lNhxdkhM7GHDqjlPE3fdjhMU+ZCPaJsl20RXcYj8Ptx8rWwxsWLmN6mwCnHS5
         6qjUpZb/X7gj4qpRdN+9wmsTc9ouT3t+JcEl+OssCGeTu74oEVnVw6x1RsZu3dJR1MeP
         CjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893515; x=1751498315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3sVHvu6rqtfwSzthUoBWhxdxzvIuGv3z4vvAxvJak0=;
        b=v3mbx9mTq93qhh3EQ0L4RQYTDMttJyaRbpRiVOUG9U36fuccP/QM9AbF6sBjc1KTR2
         OY2+Wq54om0RtVCtDJ4qmWyid2ffFSNt3ua1RPkwPOYE8Yr//mRtLqyX0P6ri3M5Bjvd
         u9fawJk/IHpcmDZluz+uyAt5MI8XESrUQyP0f438m1Y//5jF880yPduwUt2xQjf0YPS6
         A8QTBSlUihHsNxmIkLKJp2/K/tu4GWz/3dd6/deyVcEqefN8zO8Jct2Ndbr92d+H4JS6
         ikIzJmnZPW+LwRiNu7hHK/oXLXG4JZBsbgD+OtDwYBB1DAstGmUxIp5FjTxBwtBwq0/l
         7VQg==
X-Forwarded-Encrypted: i=1; AJvYcCWN/xjHABgTMjaheI95o9T1O2yok5aIl1l5DoqmJ2myAgOCy70qs7Rtm1j3oJLKzuHAnh+vP7TSKN9y@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuAi1Fwh8y48WodtSBIep/rvpbjxOTL15/q4UtR2ofbXraR48
	Rkw4B+emXvYi6W8CeIxWjwIYLKuHkAXxs6gyTWJ1gYr3vU+mPHb7GQnsRZukapmarg8=
X-Gm-Gg: ASbGncuR4B9d8eecwjnWlAAVIDqS7izzi5gVw3tDa9+mjc/rFH3GKX/r7z4/YMQUAew
	73cLff1fxEhzL2q0mqmf+NAHK53+i4MwErFUZx2lEsRa1o/11aNZaE15FlPl76kq0lUFrz3+8Jh
	MdMqBAGYfiUCmrJFEm8I3pKeGr0FiiIxEeXBIcB9DWxDgpZR7QKtcOGXAgMZzKZOdTCocBLj0Lq
	QTDjiraEatBXHrbLam5nrxxQ2RjdWZhTBUbgFxrBeSM/lP4j+/x6U0j2LFj6P0lKMxnCPHbMftd
	I0xtjHcYHDds63+lJ5WsaUV6+H1sUjgOFO5gAehbCVU52/d78ORqI7faZRo2cCLQW7k=
X-Google-Smtp-Source: AGHT+IGUSOTDcMhyXVdEI7yCPybwKm55wAWpHQBu02wApjRIvEjewZ0uBQq+qXkoDQPhGY+OUVDZ7w==
X-Received: by 2002:a05:6808:178c:b0:406:8a86:6475 with SMTP id 5614622812f47-40b1c98ee06mr1362483b6e.19.1750893514886;
        Wed, 25 Jun 2025 16:18:34 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90cc3dc8sm2386202a34.67.2025.06.25.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:34 -0700 (PDT)
Date: Thu, 26 Jun 2025 02:18:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Herbert <marc.herbert@linux.intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org,
	Benjamin.Cheatham@amd.com, Jonathan.Cameron@huawei.com,
	dakr@kernel.org, dan.j.williams@intel.com,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
	rafael@kernel.org, sudeep.holla@arm.com,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <fee97bfc-aebf-47e2-8764-e998cf9a9eb3@suswa.mountain>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <685c13c5.050a0220.38a39d.dcf8@mx.google.com>
 <daa7eb83-7413-4b6e-a241-84d306db0d43@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa7eb83-7413-4b6e-a241-84d306db0d43@linux.intel.com>

On Wed, Jun 25, 2025 at 03:30:47PM -0700, Marc Herbert wrote:
> 
> 
> On 2025-06-25 08:20, Dan Carpenter wrote:
> > On Sat, Jun 14, 2025 at 12:50:37PM +0200, Miguel Ojeda wrote:
> >> On Fri, 13 Jun 2025 20:33:42 -0400 Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>
> >>> Great writeup, but as Miguel says, this isn't needed at all, the kernel
> >>> relies on the compiler to be sane :)
> >>
> >> We may still want to clean them up, e.g. for tooling -- Kees/Dan: do we?
> >> e.g. I see a similar case with discussion at:
> >>
> >>     https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/
> >>
> >> Which in the end was picked up as commit 2df2c0caaecf ("fbdev: au1100fb:
> >> Move a variable assignment behind a null pointer check").
> > 
> > Putting the declarations at the top was always just a style preference.
> 
> No, "const" and variable scopes are not just "style", please do a
> bit of research. For instance...
> 

No, I meant it was a style issue for *us* as kernel developers.  It
wasn't like kernel developers had not heard that c99 let you put
variable declarations randomly all over the place.  We knew about it
and hated it.  We only changed the rules because of __cleanup magic.

regards,
dan carpenter


