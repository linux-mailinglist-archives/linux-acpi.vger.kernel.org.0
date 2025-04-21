Return-Path: <linux-acpi+bounces-13129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD10A94A0F
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 02:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F31891452
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 00:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550511187;
	Mon, 21 Apr 2025 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWG3LSvi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD32F9E6;
	Mon, 21 Apr 2025 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745195759; cv=none; b=BjWQP0rfHCMlQaJ+l/exEh5d3YWVZ3flCfUrjDI+V5Wju8nnWvsy6ox2RI7hEv7TOAmJPnnBSh+5cM/XInMmx2bYmRTjiYBMMYFI6ZSkRAnU5YJhBc3nqxx4lI1BSFDnLLqArkwrpppFqdWb5IFzFN5NCFUYpzUvb5tACXotR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745195759; c=relaxed/simple;
	bh=w+nRilCPBo4qLjezANmHi6IUbbDOLmbkRqy4iIoI0Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SZFEyDZP2KTjazuQ3y62SNirktJAr/N+KHc5Lnw9S1wortYKSbHalCaadAUo9YZ5nxtKQIFHiojELeBOzz5AJ3MrE8WeKQFrIuMZN6v+9pV81NrQO8dJC7Vy5cpl7WrjlggnXPTCLSQDWX+FI07cNMofFfoB21K9lNlQwiipHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWG3LSvi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30820167b47so3219282a91.0;
        Sun, 20 Apr 2025 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745195757; x=1745800557; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jj+ccMxnA1lCVJdjs6F8PzqhSDUsTWPy1/yOR0FwxBI=;
        b=MWG3LSviP3yWkow1piTwMdHXMUsBExfV7a7ZFsJ6pZocceoaWcsB41p1/BBZktJGPK
         HLdyjuxnn+ePYFqE7m3xhG8Ph2AuuuLobL4eJhlnQbRz12KNOM6FC6sScCyp10Axr/Xl
         7o85pxm1ZTZiDJ+qiWS+pI9I6msB1eBefgWfgr0GgACTgEX+ywUYG9PUIY21KfQLvJcM
         WrCg3hvPYGVVcFxqTyb3lgmQe8Nj/Xn/Yl1ApAwq5YK2Q/1DqnJTfGuagSzImLLIja1w
         IYvsGAF1I9z7QSzo+o/vuekn0AlFGmZGGUc74HAhREbIVs4Dw0H6nEIUXOQAa58BbRRo
         kohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745195757; x=1745800557;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jj+ccMxnA1lCVJdjs6F8PzqhSDUsTWPy1/yOR0FwxBI=;
        b=RixGmsbOxKn9OpjHgV3EZHx3WbOVICRn99W/XLKbW6RX9tDQnbMndlz5ynTVArZ1kY
         OakTfMie8CvQmoHKvB4lpONQTr61SE9qS9NWvVTyUlP0z6ychyHYq3kySyFzi0Hbj2OZ
         mwhkvqo/h0e0Ae/8PxkRrz1x2fAjHS2AW5M+rzVwuRfi+FpuH1cv6ABXjrUVTU1A8yG7
         YvSiHBxe6eR0CUVJCrKQBEVVq4cfQ3ujpR/0Ml1dgSFJj7cMgbUxLtTGSPugvjfUksh9
         vOA43Mw+OemH/l2WUmd7n2E7fnIvfS7Jm4+Qnc1bvUd5uzuCZ0W1QV1ZtAfDauETmuss
         ZDkw==
X-Forwarded-Encrypted: i=1; AJvYcCVHQRemQQieur3iri33RPazmmT9H5KCgCyui5/PequJMxnGJYY9CvrZDwoQPs4bifb/Wm5XTN+Sn7+O@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQusUOpY1L/Give3gpIkU48GHK/9RbIgwPsYGmFg5HKnbEztt
	vB7S3AkAoud63Hru1oUjzAwfdE7R6slxycBiFo0HmAiMNUkaWxQBdu+YiQ==
X-Gm-Gg: ASbGnctgiKWOvjlRWHsyQAzXqSLwhohxx8JQf/xDSjOVULJ0KB3JRjysi6b4xNOJM4q
	fACbmXhyJLYszAyGIbrg3YG9Or8FrznHqlY+aHpNWhnVPjJJ7fh0OnJ73yus6+Nh7d9TXGf6P8x
	07GlFSo/qSoTOGEj7FQB9KKE6EDDfpRGoNh9IMWmZutCJ+qV8r4vTA8nEJ9hUatbvFFVIzn5aUw
	R04ZpSNvPO/+L91m6npA9cqzL8OsUphYyU6fxzl1yHzuXqzdhp8EEpZB+lB8GlqOlRmGyqcQJe6
	IpmQZrao8oTVujZvcLL2ubwCUFu5heDNUd6sfRMLR/8c2LERZvFa+3fY82RVQkEj
X-Google-Smtp-Source: AGHT+IG2TklQtz1p2iLWA/jIJ1CzsVsliNAcdJBGwbUsGJh+pMCAckaAuI4xAFEMVT2sR98dxpdI0Q==
X-Received: by 2002:a17:90b:568b:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-30879ab0397mr14142056a91.3.1745195757007;
        Sun, 20 Apr 2025 17:35:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf2548sm54073125ad.64.2025.04.20.17.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 17:35:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 20 Apr 2025 17:35:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles
 around
Message-ID: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 20, 2025 at 11:02:18AM -0700, Linus Torvalds wrote:
> This is not great: I'd much rather introduce a typedef that is a "ACPI
> name byte buffer", and use that to mark these special 4-byte ACPI names
> that do not use NUL termination.
> 
> But as noted in the previous commit ("gcc-15: make 'unterminated string
> initialization' just a warning") gcc doesn't actually seem to support
> that notion, so instead you have to just mark every single array
> declaration individually.
> 
> So this is not pretty, but this gets rid of the bulk of the annoying
> warnings during an allmodconfig build for me.
> 

With gcc 13.3:

Building i386:defconfig ... failed
--------------
Error log:
drivers/acpi/tables.c:399:1: error: 'nonstring' attribute ignored on objects of type 'const char[][4]' [-Werror=attributes]
  399 | static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst __nonstring = {

Guenter

