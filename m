Return-Path: <linux-acpi+bounces-10307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4E9FC76A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 02:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA85716235C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BCF9FE;
	Thu, 26 Dec 2024 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUwBAdUx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E620EB;
	Thu, 26 Dec 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176453; cv=none; b=LrQ0hZx7KN6DGqgmV+v7IR2aAfa2MmBEbQqpM+f6n+iah3vWZwH1HB6uCPwCB+r8Zxyu3mEFihylbCrcuxNcAQJ3kA1+8xz82FbTGzBzM+W1zMnSLp4AyprIoED4mxpUz+OABB7qkZnXM99JJ1Y9ppd4bxyO+UqHZ8GBQtC1yb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176453; c=relaxed/simple;
	bh=n2c/pdJWTKjoyAi5f1u+wUe30qTvN+tUqOS5EdVBl+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1PyigqeSRuo6NAgS8z4M0LRWU+QzV+BA47c1cYyBVeTz1PhbBZrmq1JadmfXjPVlaSRQ2+8mv09wG5VzJbH6q0Ti044rXyuXP6hLR9AyC4LOI2NnB/ibcuVA+aSkiGn3D28lCDejJszQ0W+ZrPZ488Vky1I+ePtz3crxntIk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUwBAdUx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so60782515e9.1;
        Wed, 25 Dec 2024 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735176449; x=1735781249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+1gJ6KVd4d91QuBEx/cbFE3H0/ijnRtOxNNQIBNOxI=;
        b=HUwBAdUxhHMIJihcElNrVQFSKusNOny6HQrE/bEIvVsGMz6rpqJnhGkHpKTDnLsVKw
         SrSeW1uO9at9eOWaDtxUf6uD3UOcjvENiNKtfBFgoc0ejesjOUJO60YtzS7yMOz5gBxV
         UeyZKlrJLLxTb1cD9pyopPZlxgQ9V9ZQoihhRPV7LazZCe94eMBrQKxIsG+Y0+IcPnYW
         yYvHMyKio9qSbRSt35rddzLBtgixqJh8WKniNRsOx+3Zd/wiS3fVHybx7AJ37LE//LuG
         7f69CjB1V1PK466172hD7QB12Eat5tueMpHf2lFU74GKKY6Qpj5E22mEf96R+KCzeaet
         zGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735176449; x=1735781249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+1gJ6KVd4d91QuBEx/cbFE3H0/ijnRtOxNNQIBNOxI=;
        b=hwbMA84Au7qI6Fbsp8irDoWrUadUa/eV3IOfGt9QWzN00EkgnDdyppu9tlzWDRmuL+
         GV2ZR45guWMUrF8yQvCT4nQssIUNke0v7cdAV6qsI9J+/tSYHwgj6yJyvwu2sta0yaol
         6KllSBtLOMVoGBsBglxEKJArHNS246otDioqVB03H81/BIq8Kw+Odx2I9yhZP/LQm/Ba
         0NTprkOeo2uhtAvgbwokzRV4QQhfjuz/BigJ0kiAq2Gzcc1QphJkmUV/xJJbnFB9E8aL
         9wGtQAZ62aMqYBzsnK6ZdAlfKlYwDxGDjuV0+QuIgh0AMCz1OKBljA1tRkxpeRh+1VSE
         L+gg==
X-Forwarded-Encrypted: i=1; AJvYcCV0o/6IOwxgXeYIA7R8qgEvo7/ugdFg+3rfqyrrG9hVqz2R3zSSAo+foElEFuDFP9y7EzRcAhMxtEkR@vger.kernel.org, AJvYcCWoZeXRV1PY/D7/fgals3QVz7kat7jPzFtol4CT62zGmqSNZbeMEb+rvwckBBJBPJXxkFIb4QuNXdo0EfZr@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7j/Mqg6czigKHFR4Fo1vwKd9v794jl3H+KNsZ3a084IZT3pf
	WBtcmcwslNJ86tGIqKgIeVr9tRnZw0vucg3ZpCuV0UUu/Mn4YMSQ
X-Gm-Gg: ASbGnctuhDp7COBnMuAETmM13qBe7LfRTVC2qTpl8jZhSobvQcTjSuVZwQIJSirxMEB
	Hgpkg3vgNkj8zedB1X/7SxcwRcDuAzIKM289YL5Y3zgCW4MRhTupdUfMQv2q4+kHxfKNAiPqAKO
	MvyLeXmzXwSrvQHTnCgyjHKlwFy+g6IuE1VsIlkmO8SNawKTgz239rBXLn2306z7A3ps7v1qrDg
	xwhEV1gNAmnvtYwHD8axl3J57FQkqJ3oygc0VWCeH2k+xpr2toYYitKpFz9Inc=
X-Google-Smtp-Source: AGHT+IEhKxgf4hIQTI+Klr0apBS3ueanh/tTSMf0cm7MR8jqtmgAC2JCW+Dv1tvv1AYLHnhwnZnAgg==
X-Received: by 2002:a5d:47c3:0:b0:385:e35e:9da8 with SMTP id ffacd0b85a97d-38a221f69e0mr18547954f8f.18.1735176449451;
        Wed, 25 Dec 2024 17:27:29 -0800 (PST)
Received: from debian.local ([31.94.62.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219611sm218332885e9.23.2024.12.25.17.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 17:27:29 -0800 (PST)
Date: Thu, 26 Dec 2024 01:27:25 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
	regressions@lists.linux.dev, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
Message-ID: <Z2yw_eJwR5ih1Npr@debian.local>
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>

On Thu, Dec 26, 2024 at 12:19:02AM +0100, Tobias Jakobi wrote:
> Hi Chris!
> 
> On 12/26/24 00:09, Chris Bainbridge wrote:
> 
> > Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> > available for eDP") added function dm_helpers_probe_acpi_edid, which
> > fetches the EDID from the BIOS by calling acpi_video_get_edid.
> > acpi_video_get_edid returns a pointer to the EDID, but this pointer does
> > not originate from kmalloc - it is actually the internal "pointer" field
> > from an acpi_buffer struct (which did come from kmalloc).
> > dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> > resulting in memory corruption which leads to random, intermittent
> > crashes (e.g. 4% of boots will fail with some Oops).
> > 
> > Fix this by allocating a new array (which can be safely freed) for the
> > EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.
> 
> Hmm, maybe I'm missing something here. But shouldn't it suffice to just
> remove the kfree call in dm_helpers_probe_acpi_edid()?

Yes, that would work to fix the bad kfree, but there would be a small
memory leak of the acpi_buffer struct. It's not a huge problem since
this code is rarely run, and the Nouveau code has never tried to free
the edid buffer and apparently nobody noticed, but it would be better to
do the correct thing.

One other curiosity is this comment in the code that allocates the
memory:

case ACPI_ALLOCATE_BUFFER:
	/*
	 * Allocate a new buffer. We directectly call acpi_os_allocate here to
	 * purposefully bypass the (optionally enabled) internal allocation
	 * tracking mechanism since we only want to track internal
	 * allocations. Note: The caller should use acpi_os_free to free this
	 * buffer created via ACPI_ALLOCATE_BUFFER.
	 */

Which makes me wonder if all the calls to kfree on acpi_buffer structs
with ACPI_ALLOCATE_BUFFER in acpi_video.c should actually be calls to
acpi_os_free instead? I used kfree just for consistency with the
existing code.

