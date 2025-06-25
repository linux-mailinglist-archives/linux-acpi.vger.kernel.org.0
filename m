Return-Path: <linux-acpi+bounces-14601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C71BAE87CC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6866A172471
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCFD26A0D0;
	Wed, 25 Jun 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0IWnLvX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7604145355
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864840; cv=none; b=QCXfBx7N/fU20iWI5CNwkL4bgiLgubeJFrNmB/H1A/ylFHycLApvZASDFSk9PIDNJa8DNMLWFI59eCOCOuy8hlQqC4LHVvzALdxYeVCvkkoxsefwpcNGhX862gPqoddVRZaa9AOtIYVfBd/hmzxlotnOnnur+b3nlTZ5bfewE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864840; c=relaxed/simple;
	bh=I3VMeM3ROOebuGmLfBamVIQdry0me/Db5bPJT6IVBiU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG+tOBsQ04wROcB6XWXaPze4AObVGCPWSnUx/1FMBeo1W1agKfYdFgv0fvPUcBkZKNle5XL+u6cVvrUJLCM5EYQOClsc3coAGKjO2RsB/RQ7pY95IUwetzr3hRExhj7QI6NSfYPahIY3j9kqONZA8804AatCVFfss8iF/8GjLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y0IWnLvX; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-735b2699d5dso4261548a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864838; x=1751469638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N8J0ohQkucXBpYPSUPUSvYWk0PHTE1+Gl4bdfegEge0=;
        b=Y0IWnLvXsc3fEcGsQFavcKXEFpMdeXANtpCDE4i6UnW/kwQHGCVVi1o2YKuJF/Q8U9
         EMo06gzMVI/LrvQpjflqBfjAHTek6qWhOmYrHrEwcFCR1j96hbbiNbxCB6hNVXx3UEZp
         lnLXEe/BmJFvRmfqf/wf/pzYcYDCCWJXRU2Cppf7dbn1/Y/H1MQWBkeu8GzfcJuhSZ7I
         IZ8pU+yOtFEBPmJtOUTNKw3gC54Fyf+1SrWXB4GHkPYl61RQSwSfNezKw38j+pvJxA5e
         3Faitaxz9FYuOTRpfHg+q2AcjaCgGit/XdL9cxxNiqk7QzKGLZr/Iq/cI8vS1j8TFRKj
         2/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864838; x=1751469638;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8J0ohQkucXBpYPSUPUSvYWk0PHTE1+Gl4bdfegEge0=;
        b=sC7eZO+6M3+Avwpjnhoxo7izzMsyD/LsKDjO7cO6Hd+nCtquwlvTHZE8ADtLQ8iISE
         Nzbdehk0CC5Q0MqxgqGvhiK2D6BTN2DD9WLGjHWX/HxqHgQr/Y+VtKJRA+HIK7nUjfxP
         I+CatoaYw4h1LfUra+y/t7R2t+pxhLzTjvZIuPawF0/wbkaioZF1SUJqA5BoP9p88hr9
         ZlMUQF6a4/ixpebz/qoLZdzSgsX3t+W9x0rR0qoq0r3zRrx93fb9Sc5U3YbdlNCxEl+h
         T+Bwu9JOyTBlgmDVZBdxYEJLB1I3qcbkd/1Fjt5eYlzkKpGDSO8vvw4DjDatnFycYPpn
         /6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4yNJghT6tk7Ug1DhYO7Ss2cZ0IXyb3q8xDUFrD6K2HVNQgXdjG6PxThb5ARZ4V5dyNEnyRpa5o/Gu@vger.kernel.org
X-Gm-Message-State: AOJu0YyemROz0IFRnawviXpU+Go4erx+3RAy4VCuNnTDToJmlxcagp/q
	WSKNQkBA5FOWj//YfjVV8LOCLrfsmlfDUfs2XhDaYsOH9yDcr41FkXJZ64vrqb8rtgw=
X-Gm-Gg: ASbGncu9NTd5CGJAgffcKAZt0/sSyPTCs6oObFDyamCQteH9h+eYr+/mkreHlcii7I3
	Md1YHa7mwc1bqF5NOvU7tAHYmB64agF09TlOoZgfTcQT7FgBWuPJfr3idjoCzZ6sox+GFplAkTP
	467SwT5I9gZFa3SpiY+VKWkxG/DN11RjS3rVnKv82OOWah4SnMcM6QFrB63JqMG3fBCzgkygSjt
	oVvV6QoWJZgVg69fvztV6/JJkEWaZK5HeQBcojPjl3zdJ5vC+mzBKGEvBaFVi7wFI6S9iErbHwG
	by5elCihnaD1hYhDJMJd0GDk+8f4haVYMu80798VlzLXLTeOJfUK14XdPCtk8UH9iznGtA==
X-Google-Smtp-Source: AGHT+IHN+Igzxn2usZkb70KRzmmATFBMBOaapKjVxLI0arjq0Ex2N8xDeTWjV+sIuuSwiIxu3jHu/g==
X-Received: by 2002:a05:6830:8419:b0:72a:47ec:12c6 with SMTP id 46e09a7af769-73adc5099e7mr1611593a34.2.1750864837773;
        Wed, 25 Jun 2025 08:20:37 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90b337cfsm2275280a34.28.2025.06.25.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:20:37 -0700 (PDT)
Message-ID: <685c13c5.050a0220.38a39d.dcf8@mx.google.com>
X-Google-Original-Message-ID: <@sabinyo.mountain>
Date: Wed, 25 Jun 2025 10:20:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, Benjamin.Cheatham@amd.com,
	Jonathan.Cameron@huawei.com, dakr@kernel.org,
	dan.j.williams@intel.com, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	marc.herbert@linux.intel.com, rafael.j.wysocki@intel.com,
	rafael@kernel.org, sudeep.holla@arm.com,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614105037.1441029-1-ojeda@kernel.org>

On Sat, Jun 14, 2025 at 12:50:37PM +0200, Miguel Ojeda wrote:
> On Fri, 13 Jun 2025 20:33:42 -0400 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Great writeup, but as Miguel says, this isn't needed at all, the kernel
> > relies on the compiler to be sane :)
> 
> We may still want to clean them up, e.g. for tooling -- Kees/Dan: do we?
> e.g. I see a similar case with discussion at:
> 
>     https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/
> 
> Which in the end was picked up as commit 2df2c0caaecf ("fbdev: au1100fb:
> Move a variable assignment behind a null pointer check").

Putting the declarations at the top was always just a style preference.
Putting declarations at the top causes issues for __cleanup magic and
also bcachefs puts the declarations where ever it wants, but otherwise
people generally still put the declarations at the stop.

regards,
dan carpenter


