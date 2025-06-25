Return-Path: <linux-acpi+bounces-14602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D63AE87CE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDD9172B01
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941426B763;
	Wed, 25 Jun 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpzF0HvI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795E26B09A
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864888; cv=none; b=FcnesJKlDFruJXDFC+q/echXR0Bu0gOj/9ShdDR85Z0Y8EatXQtgGMLNh8mkF9qqMS/L1bFxJRrsQg5B4ea0KqsNw5UcXFRkianaRig8onzcjyHeB84LZci8TQpT7GUOUyP1RFsMtvaRj00TWtXDARQtfgD4HvhCwH1M0pBuoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864888; c=relaxed/simple;
	bh=KyGtK80to6KuEAYehb5mAJU+T+xcgGreIs/Qe+2xesE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9FqWLSHLqHzU/J5n4oMpdR2AB5+mY0H6gyTZSmKX01kHguaxrdFJDEU+FTztohOYRxlP1wR2DA3J0QGvt/OTWkInB5uNcb6CTQ3er4SSSqWaxeBvd6UI8eo66TAJ35j4zJqKH+wVNastv6S0UHDYA1FW5z4Iq8kh0apzum21NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpzF0HvI; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so33046fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864886; x=1751469686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaOBbGszEzWNvSbaKJDe5LeOUi5TUUgxvB4nzx65NaE=;
        b=dpzF0HvI50GVO8nmkHYCwMHqnAvt3wsTZZ02W2F2KsVWLuZ+gYHCjokYEAKqmsqNYX
         Rf/luAyTBXTFydtGS2O08FUWHe7+dtAR9lIOi3LZNrdRuaurVRvgttmNfpLnq5G8h78f
         ZSWPx6uKQHj8oCn2WJ6YuWMDVyCUR+l+T/2WPB9KDktcqdYtAilgsSxDxVPx93pC8HEM
         sHOyjNfRWsknhgPxKeG44rvZFHFGbYQ2zwe1xD5HJp9QZxnN5l2hMCbtCO8HsV5Zof3Y
         q8eNddk0Y5ymPa+rkFFsiLJb9vEhgrc9/IPUYfBZT8rqsRrTNILLnKWCpbdum8gyK3Mj
         KdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864886; x=1751469686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaOBbGszEzWNvSbaKJDe5LeOUi5TUUgxvB4nzx65NaE=;
        b=SIMgItJp2cBUmfy7EOoF5QOLkq6TlpsJTadpE4m106n51ppd4cT/uZIMioPrmTiFvh
         16x9CaA+Q8JMFlHtBbEUnBatQzelvxAmXkJJdWE9VZhlDZTA3sfnUtAN0vFfK6XtHs37
         Lln5/QZVyClESTBwncyq/CnUv2ZNx7alNzdWiTDcKXTYiICtpnIf2xWTENgF7fxgR0lN
         iP7/Qfk41prFoU3UH1xq+flVIp/frKeqzzlEOja4eXkJv6F7wQVmk/j7vuWT1z5UvwrR
         Gzs+m/nEjlg+VMlH1kX0v375uzPjKYt7jTkwTcPeLw9bA7OhhfLFHeTcmPt+pp1myWkk
         RXUA==
X-Forwarded-Encrypted: i=1; AJvYcCXYAj6WWbNrh6fiIKRzy8T6wNfwyccMGCxmk3zLjwebYVDo93HfmQnmJHi8x5rmdDfT1pouAJfFHAIv@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+PFCJ9xr+4jAivo11UAqUCoqMr4z31ejJVK0w+1kobSCBs+C
	2mwqhtThLNuX3UiSrr5xPLMq+2yzstHt2LHTAPEEXO+ifosKsHrFj2CWfuMN9Nij6c0=
X-Gm-Gg: ASbGncu9RtlkA93MkbbV5/2XsP9jVivpLPd3e4rNcM69PBtm1p3zgLlVkv9F34J2cTY
	AS+HkmlLGIO3LVxaaHL5Sg50/+D9THFn5tWnXIOftCpILr7jm1hfcK50WMd1/qFcNB9JKlvpZba
	A925Y7VeDjFUkQJgtO1f2VI29xCCSl6kpSnyHRfdBZf1gqpKVrWeDmqooZsJ93RilgNTZbpNXOT
	faX3XDHLG90xFUd97N4NKHEpOI+gWFq2J31SHdfPUcuJNNAGPDiBKnyzBTxUfJ5oRuISTet+fTi
	Tha36sU9MfNhK43bzQTV2hnNBk1b6nG9GiZEIqLJYeQfYgA+FGWTWVOOM58+bvn5qANzEw==
X-Google-Smtp-Source: AGHT+IGk4J0jSMpXdWyxPvRR18hOuQQOIaOFP1Wr6EYSOJlLgXKdVD4YD5Z5m09gKSGJW9gCVJhNFw==
X-Received: by 2002:a05:6870:e96:b0:29d:c832:7ef6 with SMTP id 586e51a60fabf-2efb29472c7mr2491089fac.39.1750864885674;
        Wed, 25 Jun 2025 08:21:25 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ee665666d4sm2597761fac.16.2025.06.25.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:21:25 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:21:24 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: marc.herbert@linux.intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, rafael.j.wysocki@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <4d54e4f6-0d98-4b42-9bea-169f3b8772bb@sabinyo.mountain>
References: <20250613191556.4184103-1-marc.herbert@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613191556.4184103-1-marc.herbert@linux.intel.com>

On Fri, Jun 13, 2025 at 07:15:56PM +0000, marc.herbert@linux.intel.com wrote:
> gcc -O0: Segmentation fault (core dumped)
> gcc -O1: ptr is zero
> gcc -O2: ptr is NOT zero!!!
> gcc -O3: ptr is NOT zero!!!
> gcc -Og: ptr is zero

Btw, this is testing dereferences where the kernel code is doing pointer
math.  No one disagrees about dereferences after a check.

regards,
dan carpenter


